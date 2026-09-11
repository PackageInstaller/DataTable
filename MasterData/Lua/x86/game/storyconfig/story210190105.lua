return {
	Play1101905001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1101905001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1101905002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.D999 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "D999")
				var_4_0.name = "D999"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.D999 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.D999

				arg_1_1.bgs_.D999.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "D999" then
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

			if 0.3 < arg_1_1.time_ and arg_1_1.time_ <= 0.3 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
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

			local var_4_14 = 2
			local var_4_15 = 0.35

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1101905001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 14 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 14)

				if (14 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 14)) > 0 and var_4_15 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_14 = var_4_14 + 0.3

					if var_4_19 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = var_4_14 + 0.3
			local var_4_21 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_20) / var_4_21

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play1101905002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1101905002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1101905003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.65

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(1101905002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 26 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 26)

				if (26 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 26)) > 0 and var_12_0 < var_12_3 then
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
	Play1101905003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1101905003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1101905004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.65

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(1101905003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 26 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 26)

				if (26 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 26)) > 0 and var_16_0 < var_16_3 then
					arg_13_1.talkMaxDuration = var_16_3

					if var_16_3 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_3 + 0
					end
				end

				arg_13_1.text_.text = var_16_1
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_4 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_4

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play1101905004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1101905004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1101905005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 1.475

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

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(1101905004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 59 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 59)

				if (59 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 59)) > 0 and var_20_0 < var_20_3 then
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
	Play1101905005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1101905005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1101905006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.3

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(1101905005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 12 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 12)

				if (12 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 12)) > 0 and var_24_0 < var_24_3 then
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
	Play1101905006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1101905006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1101905007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.975

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_1 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(1101905006).content)

				arg_25_1.text_.text = var_28_1

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_3 = 39 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 39)

				if (39 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 39)) > 0 and var_28_0 < var_28_3 then
					arg_25_1.talkMaxDuration = var_28_3

					if var_28_3 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_3 + 0
					end
				end

				arg_25_1.text_.text = var_28_1
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_4 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_4

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play1101905007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1101905007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1101905008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:AudioAction("play", "effect", "se_story_side_1019", "se_story_side_1019_crack", "")
			end

			local var_32_1 = 0
			local var_32_2 = 1.325

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

				local var_32_3 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(1101905007).content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 53 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 53)

				if (53 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 53)) > 0 and var_32_2 < var_32_5 then
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
	Play1101905008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1101905008
		arg_33_1.duration_ = 9

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1101905009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if arg_33_1.bgs_.ST01a == nil then
				local var_36_0 = Object.Instantiate(arg_33_1.paintGo_)

				var_36_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST01a")
				var_36_0.name = "ST01a"
				var_36_0.transform.parent = arg_33_1.stage_.transform
				var_36_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.bgs_.ST01a = var_36_0
			end

			if 2 < arg_33_1.time_ and arg_33_1.time_ <= 2 + arg_36_0 then
				local var_36_1 = arg_33_1.bgs_.ST01a

				arg_33_1.bgs_.ST01a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_36_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_36_2 = var_36_1:GetComponent("SpriteRenderer")

				if var_36_2 and var_36_2.sprite then
					local var_36_3 = 2 * (var_36_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_36_1.transform.localScale = Vector3.New(var_36_3 / var_36_2.sprite.bounds.size.y < var_36_3 * manager.ui.mainCameraCom_.aspect / var_36_2.sprite.bounds.size.x and var_36_3 * manager.ui.mainCameraCom_.aspect / var_36_2.sprite.bounds.size.x or var_36_3 / var_36_2.sprite.bounds.size.y, var_36_3 / var_36_2.sprite.bounds.size.y < var_36_3 * manager.ui.mainCameraCom_.aspect / var_36_2.sprite.bounds.size.x and var_36_3 * manager.ui.mainCameraCom_.aspect / var_36_2.sprite.bounds.size.x or var_36_3 / var_36_2.sprite.bounds.size.y, 0)
				end

				for iter_36_0, iter_36_1 in pairs(arg_33_1.bgs_) do
					if iter_36_0 ~= "ST01a" then
						iter_36_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_36_4 = 0

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_5 = 2

			if var_36_4 <= arg_33_1.time_ and arg_33_1.time_ < var_36_4 + var_36_5 then
				local var_36_6 = Color.New(0, 0, 0)

				var_36_6.a = Mathf.Lerp(0, 1, (arg_33_1.time_ - var_36_4) / var_36_5)
				arg_33_1.mask_.color = var_36_6
			end

			if arg_33_1.time_ >= var_36_4 + var_36_5 and arg_33_1.time_ < var_36_4 + var_36_5 + arg_36_0 then
				local var_36_7 = Color.New(0, 0, 0)

				var_36_7.a = 1
				arg_33_1.mask_.color = var_36_7
			end

			local var_36_8 = 2

			if 2 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_9 = 2

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_9 then
				local var_36_10 = Color.New(0, 0, 0)

				var_36_10.a = Mathf.Lerp(1, 0, (arg_33_1.time_ - var_36_8) / var_36_9)
				arg_33_1.mask_.color = var_36_10
			end

			if arg_33_1.time_ >= var_36_8 + var_36_9 and arg_33_1.time_ < var_36_8 + var_36_9 + arg_36_0 then
				local var_36_11 = Color.New(0, 0, 0)

				arg_33_1.mask_.enabled = false
				var_36_11.a = 0
				arg_33_1.mask_.color = var_36_11
			end

			if arg_33_1.frameCnt_ <= 1 then
				arg_33_1.dialog_:SetActive(false)
			end

			local var_36_12 = 4
			local var_36_13 = 0.125

			if 4 < arg_33_1.time_ and arg_33_1.time_ <= var_36_12 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0

				arg_33_1.dialog_:SetActive(true)

				arg_33_1.dialogCg_.alpha = 0

				local var_36_14 = LeanTween.value(arg_33_1.dialog_, 0, 1, 0.3)

				var_36_14:setOnUpdate(LuaHelper.FloatAction(function(arg_37_0)
					arg_33_1.dialogCg_.alpha = arg_37_0
				end))
				var_36_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_33_1.dialog_)
					var_36_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_33_1.duration_ = arg_33_1.duration_ + 0.3

				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_15 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(1101905008).content)

				arg_33_1.text_.text = var_36_15

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_17 = 5 <= 0 and var_36_13 or var_36_13 * (utf8.len(var_36_15) / 5)

				if (5 <= 0 and var_36_13 or var_36_13 * (utf8.len(var_36_15) / 5)) > 0 and var_36_13 < var_36_17 then
					arg_33_1.talkMaxDuration = var_36_17
					var_36_12 = var_36_12 + 0.3

					if var_36_17 + var_36_12 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_17 + var_36_12
					end
				end

				arg_33_1.text_.text = var_36_15
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_18 = var_36_12 + 0.3
			local var_36_19 = math.max(var_36_13, arg_33_1.talkMaxDuration)

			if var_36_12 + 0.3 <= arg_33_1.time_ and arg_33_1.time_ < var_36_18 + var_36_19 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_18) / var_36_19

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_18 + var_36_19 and arg_33_1.time_ < var_36_18 + var_36_19 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play1101905009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 1101905009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play1101905010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0.8

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_1 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(1101905009).content)

				arg_39_1.text_.text = var_42_1

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_3 = 32 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 32)

				if (32 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 32)) > 0 and var_42_0 < var_42_3 then
					arg_39_1.talkMaxDuration = var_42_3

					if var_42_3 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_3 + 0
					end
				end

				arg_39_1.text_.text = var_42_1
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_4 = math.max(var_42_0, arg_39_1.talkMaxDuration)

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_4 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - 0) / var_42_4

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= 0 + var_42_4 and arg_39_1.time_ < 0 + var_42_4 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play1101905010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 1101905010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play1101905011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0.6

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_1 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(1101905010).content)

				arg_43_1.text_.text = var_46_1

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_3 = 24 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 24)

				if (24 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 24)) > 0 and var_46_0 < var_46_3 then
					arg_43_1.talkMaxDuration = var_46_3

					if var_46_3 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_3 + 0
					end
				end

				arg_43_1.text_.text = var_46_1
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_4 = math.max(var_46_0, arg_43_1.talkMaxDuration)

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_4 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - 0) / var_46_4

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= 0 + var_46_4 and arg_43_1.time_ < 0 + var_46_4 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play1101905011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 1101905011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play1101905012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 1.45

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_1 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(1101905011).content)

				arg_47_1.text_.text = var_50_1

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_3 = 58 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_1) / 58)

				if (58 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_1) / 58)) > 0 and var_50_0 < var_50_3 then
					arg_47_1.talkMaxDuration = var_50_3

					if var_50_3 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_3 + 0
					end
				end

				arg_47_1.text_.text = var_50_1
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_4 = math.max(var_50_0, arg_47_1.talkMaxDuration)

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_4 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - 0) / var_50_4

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= 0 + var_50_4 and arg_47_1.time_ < 0 + var_50_4 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play1101905012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 1101905012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play1101905013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0.35

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_1 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(1101905012).content)

				arg_51_1.text_.text = var_54_1

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_3 = 14 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_1) / 14)

				if (14 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_1) / 14)) > 0 and var_54_0 < var_54_3 then
					arg_51_1.talkMaxDuration = var_54_3

					if var_54_3 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_3 + 0
					end
				end

				arg_51_1.text_.text = var_54_1
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_4 = math.max(var_54_0, arg_51_1.talkMaxDuration)

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_4 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - 0) / var_54_4

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= 0 + var_54_4 and arg_51_1.time_ < 0 + var_54_4 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play1101905013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 1101905013
		arg_55_1.duration_ = 9

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play1101905014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if arg_55_1.bgs_.A00 == nil then
				local var_58_0 = Object.Instantiate(arg_55_1.paintGo_)

				var_58_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "A00")
				var_58_0.name = "A00"
				var_58_0.transform.parent = arg_55_1.stage_.transform
				var_58_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_55_1.bgs_.A00 = var_58_0
			end

			if 2 < arg_55_1.time_ and arg_55_1.time_ <= 2 + arg_58_0 then
				local var_58_1 = arg_55_1.bgs_.A00

				arg_55_1.bgs_.A00.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_58_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_58_2 = var_58_1:GetComponent("SpriteRenderer")

				if var_58_2 and var_58_2.sprite then
					local var_58_3 = 2 * (var_58_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_58_1.transform.localScale = Vector3.New(var_58_3 / var_58_2.sprite.bounds.size.y < var_58_3 * manager.ui.mainCameraCom_.aspect / var_58_2.sprite.bounds.size.x and var_58_3 * manager.ui.mainCameraCom_.aspect / var_58_2.sprite.bounds.size.x or var_58_3 / var_58_2.sprite.bounds.size.y, var_58_3 / var_58_2.sprite.bounds.size.y < var_58_3 * manager.ui.mainCameraCom_.aspect / var_58_2.sprite.bounds.size.x and var_58_3 * manager.ui.mainCameraCom_.aspect / var_58_2.sprite.bounds.size.x or var_58_3 / var_58_2.sprite.bounds.size.y, 0)
				end

				for iter_58_0, iter_58_1 in pairs(arg_55_1.bgs_) do
					if iter_58_0 ~= "A00" then
						iter_58_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_58_4 = 0

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_4 + arg_58_0 then
				arg_55_1.mask_.enabled = true
				arg_55_1.mask_.raycastTarget = true

				arg_55_1:SetGaussion(false)
			end

			local var_58_5 = 2

			if var_58_4 <= arg_55_1.time_ and arg_55_1.time_ < var_58_4 + var_58_5 then
				local var_58_6 = Color.New(0, 0, 0)

				var_58_6.a = Mathf.Lerp(0, 1, (arg_55_1.time_ - var_58_4) / var_58_5)
				arg_55_1.mask_.color = var_58_6
			end

			if arg_55_1.time_ >= var_58_4 + var_58_5 and arg_55_1.time_ < var_58_4 + var_58_5 + arg_58_0 then
				local var_58_7 = Color.New(0, 0, 0)

				var_58_7.a = 1
				arg_55_1.mask_.color = var_58_7
			end

			local var_58_8 = 2

			if 2 < arg_55_1.time_ and arg_55_1.time_ <= var_58_8 + arg_58_0 then
				arg_55_1.mask_.enabled = true
				arg_55_1.mask_.raycastTarget = true

				arg_55_1:SetGaussion(false)
			end

			local var_58_9 = 2

			if var_58_8 <= arg_55_1.time_ and arg_55_1.time_ < var_58_8 + var_58_9 then
				local var_58_10 = Color.New(0, 0, 0)

				var_58_10.a = Mathf.Lerp(1, 0, (arg_55_1.time_ - var_58_8) / var_58_9)
				arg_55_1.mask_.color = var_58_10
			end

			if arg_55_1.time_ >= var_58_8 + var_58_9 and arg_55_1.time_ < var_58_8 + var_58_9 + arg_58_0 then
				local var_58_11 = Color.New(0, 0, 0)

				arg_55_1.mask_.enabled = false
				var_58_11.a = 0
				arg_55_1.mask_.color = var_58_11
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_58_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_55_1.bgmTxt_.text ~= var_58_14 and arg_55_1.bgmTxt_.text ~= "" then
						if arg_55_1.bgmTxt2_.text ~= "" then
							arg_55_1.bgmTxt_.text = arg_55_1.bgmTxt2_.text
						end

						arg_55_1.bgmTxt2_.text = var_58_14

						arg_55_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_55_1.bgmTxt_.text = var_58_14
						arg_55_1.bgmTxt2_.text = var_58_14
					end

					if arg_55_1.bgmTimer then
						arg_55_1.bgmTimer:Stop()

						arg_55_1.bgmTimer = nil
					end

					if arg_55_1.settingData.show_music_name == 1 then
						arg_55_1.musicController:SetSelectedState("show")
						arg_55_1.musicAnimator_:Play("open", 0, 0)

						if arg_55_1.settingData.music_time ~= 0 then
							arg_55_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_55_1.settingData.music_time), function()
								if arg_55_1 == nil or isNil(arg_55_1.bgmTxt_) then
									return
								end

								arg_55_1.musicController:SetSelectedState("hide")
								arg_55_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.3 < arg_55_1.time_ and arg_55_1.time_ <= 0.3 + arg_58_0 then
				arg_55_1:AudioAction("play", "music", "bgm_story_office", "bgm_story_office", "bgm_story_office.awb")

				local var_58_17 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

				if "" ~= "" then
					if arg_55_1.bgmTxt_.text ~= var_58_17 and arg_55_1.bgmTxt_.text ~= "" then
						if arg_55_1.bgmTxt2_.text ~= "" then
							arg_55_1.bgmTxt_.text = arg_55_1.bgmTxt2_.text
						end

						arg_55_1.bgmTxt2_.text = var_58_17

						arg_55_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_55_1.bgmTxt_.text = var_58_17
						arg_55_1.bgmTxt2_.text = var_58_17
					end

					if arg_55_1.bgmTimer then
						arg_55_1.bgmTimer:Stop()

						arg_55_1.bgmTimer = nil
					end

					if arg_55_1.settingData.show_music_name == 1 then
						arg_55_1.musicController:SetSelectedState("show")
						arg_55_1.musicAnimator_:Play("open", 0, 0)

						if arg_55_1.settingData.music_time ~= 0 then
							arg_55_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_55_1.settingData.music_time), function()
								if arg_55_1 == nil or isNil(arg_55_1.bgmTxt_) then
									return
								end

								arg_55_1.musicController:SetSelectedState("hide")
								arg_55_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_55_1.frameCnt_ <= 1 then
				arg_55_1.dialog_:SetActive(false)
			end

			local var_58_18 = 4
			local var_58_19 = 0.375

			if 4 < arg_55_1.time_ and arg_55_1.time_ <= var_58_18 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0

				arg_55_1.dialog_:SetActive(true)

				arg_55_1.dialogCg_.alpha = 0

				local var_58_20 = LeanTween.value(arg_55_1.dialog_, 0, 1, 0.3)

				var_58_20:setOnUpdate(LuaHelper.FloatAction(function(arg_61_0)
					arg_55_1.dialogCg_.alpha = arg_61_0
				end))
				var_58_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_55_1.dialog_)
					var_58_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_55_1.duration_ = arg_55_1.duration_ + 0.3

				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_21 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(1101905013).content)

				arg_55_1.text_.text = var_58_21

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_23 = 15 <= 0 and var_58_19 or var_58_19 * (utf8.len(var_58_21) / 15)

				if (15 <= 0 and var_58_19 or var_58_19 * (utf8.len(var_58_21) / 15)) > 0 and var_58_19 < var_58_23 then
					arg_55_1.talkMaxDuration = var_58_23
					var_58_18 = var_58_18 + 0.3

					if var_58_23 + var_58_18 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_23 + var_58_18
					end
				end

				arg_55_1.text_.text = var_58_21
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_24 = var_58_18 + 0.3
			local var_58_25 = math.max(var_58_19, arg_55_1.talkMaxDuration)

			if var_58_18 + 0.3 <= arg_55_1.time_ and arg_55_1.time_ < var_58_24 + var_58_25 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_24) / var_58_25

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_24 + var_58_25 and arg_55_1.time_ < var_58_24 + var_58_25 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play1101905014 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 1101905014
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play1101905015(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 1.075

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_1 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(1101905014).content)

				arg_63_1.text_.text = var_66_1

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_3 = 43 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 43)

				if (43 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 43)) > 0 and var_66_0 < var_66_3 then
					arg_63_1.talkMaxDuration = var_66_3

					if var_66_3 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_3 + 0
					end
				end

				arg_63_1.text_.text = var_66_1
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_4 = math.max(var_66_0, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - 0) / var_66_4

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play1101905015 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 1101905015
		arg_67_1.duration_ = 1

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play1101905016(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.05

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[705].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_1 = arg_67_1:GetWordFromCfg(1101905015)
				local var_70_2 = arg_67_1:FormatText(var_70_1.content)

				arg_67_1.text_.text = var_70_2

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_4 = 2 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 2)

				if (2 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 2)) > 0 and var_70_0 < var_70_4 then
					arg_67_1.talkMaxDuration = var_70_4

					if var_70_4 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_4 + 0
					end
				end

				arg_67_1.text_.text = var_70_2
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905015", "story_v_side_new_1101905.awb") ~= 0 then
					local var_70_5 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905015", "story_v_side_new_1101905.awb") / 1000

					if var_70_5 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + 0
					end

					if var_70_1.prefab_name ~= "" and arg_67_1.actors_[var_70_1.prefab_name] ~= nil then
						local var_70_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_1.prefab_name].transform, "story_v_side_new_1101905", "1101905015", "story_v_side_new_1101905.awb")

						arg_67_1:RecordAudio("1101905015", var_70_6)
						arg_67_1:RecordAudio("1101905015", var_70_6)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905015", "story_v_side_new_1101905.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905015", "story_v_side_new_1101905.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_7 = math.max(var_70_0, arg_67_1.talkMaxDuration)

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_7 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - 0) / var_70_7

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= 0 + var_70_7 and arg_67_1.time_ < 0 + var_70_7 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play1101905016 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 1101905016
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play1101905017(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 1.125

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_1 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(1101905016).content)

				arg_71_1.text_.text = var_74_1

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_3 = 45 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_1) / 45)

				if (45 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_1) / 45)) > 0 and var_74_0 < var_74_3 then
					arg_71_1.talkMaxDuration = var_74_3

					if var_74_3 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_3 + 0
					end
				end

				arg_71_1.text_.text = var_74_1
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_4 = math.max(var_74_0, arg_71_1.talkMaxDuration)

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_4 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - 0) / var_74_4

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= 0 + var_74_4 and arg_71_1.time_ < 0 + var_74_4 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play1101905017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 1101905017
		arg_75_1.duration_ = 5.6

		local var_75_0 = {
			zh = 3.666,
			ja = 5.6
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play1101905018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0.425

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[706].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwb")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_1 = arg_75_1:GetWordFromCfg(1101905017)
				local var_78_2 = arg_75_1:FormatText(var_78_1.content)

				arg_75_1.text_.text = var_78_2

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_4 = 17 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 17)

				if (17 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 17)) > 0 and var_78_0 < var_78_4 then
					arg_75_1.talkMaxDuration = var_78_4

					if var_78_4 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_4 + 0
					end
				end

				arg_75_1.text_.text = var_78_2
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905017", "story_v_side_new_1101905.awb") ~= 0 then
					local var_78_5 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905017", "story_v_side_new_1101905.awb") / 1000

					if var_78_5 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + 0
					end

					if var_78_1.prefab_name ~= "" and arg_75_1.actors_[var_78_1.prefab_name] ~= nil then
						local var_78_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_1.prefab_name].transform, "story_v_side_new_1101905", "1101905017", "story_v_side_new_1101905.awb")

						arg_75_1:RecordAudio("1101905017", var_78_6)
						arg_75_1:RecordAudio("1101905017", var_78_6)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905017", "story_v_side_new_1101905.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905017", "story_v_side_new_1101905.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_7 = math.max(var_78_0, arg_75_1.talkMaxDuration)

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_7 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - 0) / var_78_7

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= 0 + var_78_7 and arg_75_1.time_ < 0 + var_78_7 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play1101905018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 1101905018
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play1101905019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0.55

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_1 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(1101905018).content)

				arg_79_1.text_.text = var_82_1

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_3 = 22 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 22)

				if (22 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 22)) > 0 and var_82_0 < var_82_3 then
					arg_79_1.talkMaxDuration = var_82_3

					if var_82_3 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_3 + 0
					end
				end

				arg_79_1.text_.text = var_82_1
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_4 = math.max(var_82_0, arg_79_1.talkMaxDuration)

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - 0) / var_82_4

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play1101905019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 1101905019
		arg_83_1.duration_ = 3.23

		local var_83_0 = {
			zh = 2.8,
			ja = 3.233
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play1101905020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0.3

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[707].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwc")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_1 = arg_83_1:GetWordFromCfg(1101905019)
				local var_86_2 = arg_83_1:FormatText(var_86_1.content)

				arg_83_1.text_.text = var_86_2

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_4 = 12 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 12)

				if (12 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 12)) > 0 and var_86_0 < var_86_4 then
					arg_83_1.talkMaxDuration = var_86_4

					if var_86_4 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_4 + 0
					end
				end

				arg_83_1.text_.text = var_86_2
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905019", "story_v_side_new_1101905.awb") ~= 0 then
					local var_86_5 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905019", "story_v_side_new_1101905.awb") / 1000

					if var_86_5 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + 0
					end

					if var_86_1.prefab_name ~= "" and arg_83_1.actors_[var_86_1.prefab_name] ~= nil then
						local var_86_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_1.prefab_name].transform, "story_v_side_new_1101905", "1101905019", "story_v_side_new_1101905.awb")

						arg_83_1:RecordAudio("1101905019", var_86_6)
						arg_83_1:RecordAudio("1101905019", var_86_6)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905019", "story_v_side_new_1101905.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905019", "story_v_side_new_1101905.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_7 = math.max(var_86_0, arg_83_1.talkMaxDuration)

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_7 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - 0) / var_86_7

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= 0 + var_86_7 and arg_83_1.time_ < 0 + var_86_7 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play1101905020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 1101905020
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play1101905021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 1

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_1 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(1101905020).content)

				arg_87_1.text_.text = var_90_1

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_3 = 40 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_1) / 40)

				if (40 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_1) / 40)) > 0 and var_90_0 < var_90_3 then
					arg_87_1.talkMaxDuration = var_90_3

					if var_90_3 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_3 + 0
					end
				end

				arg_87_1.text_.text = var_90_1
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_4 = math.max(var_90_0, arg_87_1.talkMaxDuration)

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_4 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - 0) / var_90_4

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= 0 + var_90_4 and arg_87_1.time_ < 0 + var_90_4 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play1101905021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 1101905021
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play1101905022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0.65

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_1 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(1101905021).content)

				arg_91_1.text_.text = var_94_1

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_3 = 26 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_1) / 26)

				if (26 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_1) / 26)) > 0 and var_94_0 < var_94_3 then
					arg_91_1.talkMaxDuration = var_94_3

					if var_94_3 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_3 + 0
					end
				end

				arg_91_1.text_.text = var_94_1
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_4 = math.max(var_94_0, arg_91_1.talkMaxDuration)

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_4 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - 0) / var_94_4

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= 0 + var_94_4 and arg_91_1.time_ < 0 + var_94_4 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play1101905022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 1101905022
		arg_95_1.duration_ = 3.73

		local var_95_0 = {
			zh = 3.7,
			ja = 3.733
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play1101905023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0.525

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[705].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_1 = arg_95_1:GetWordFromCfg(1101905022)
				local var_98_2 = arg_95_1:FormatText(var_98_1.content)

				arg_95_1.text_.text = var_98_2

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_4 = 21 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 21)

				if (21 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 21)) > 0 and var_98_0 < var_98_4 then
					arg_95_1.talkMaxDuration = var_98_4

					if var_98_4 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_4 + 0
					end
				end

				arg_95_1.text_.text = var_98_2
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905022", "story_v_side_new_1101905.awb") ~= 0 then
					local var_98_5 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905022", "story_v_side_new_1101905.awb") / 1000

					if var_98_5 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_5 + 0
					end

					if var_98_1.prefab_name ~= "" and arg_95_1.actors_[var_98_1.prefab_name] ~= nil then
						local var_98_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_1.prefab_name].transform, "story_v_side_new_1101905", "1101905022", "story_v_side_new_1101905.awb")

						arg_95_1:RecordAudio("1101905022", var_98_6)
						arg_95_1:RecordAudio("1101905022", var_98_6)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905022", "story_v_side_new_1101905.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905022", "story_v_side_new_1101905.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_7 = math.max(var_98_0, arg_95_1.talkMaxDuration)

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_7 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - 0) / var_98_7

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= 0 + var_98_7 and arg_95_1.time_ < 0 + var_98_7 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play1101905023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 1101905023
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play1101905024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0.575

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_1 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(1101905023).content)

				arg_99_1.text_.text = var_102_1

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_3 = 23 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 23)

				if (23 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 23)) > 0 and var_102_0 < var_102_3 then
					arg_99_1.talkMaxDuration = var_102_3

					if var_102_3 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_3 + 0
					end
				end

				arg_99_1.text_.text = var_102_1
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_4 = math.max(var_102_0, arg_99_1.talkMaxDuration)

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_4 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - 0) / var_102_4

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= 0 + var_102_4 and arg_99_1.time_ < 0 + var_102_4 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play1101905024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 1101905024
		arg_103_1.duration_ = 6.9

		local var_103_0 = {
			zh = 6.9,
			ja = 6.5
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play1101905025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0.825

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[705].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, true)
				arg_103_1.iconController_:SetSelectedState("hero")

				arg_103_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_103_1.callingController_:SetSelectedState("normal")

				arg_103_1.keyicon_.color = Color.New(1, 1, 1)
				arg_103_1.icon_.color = Color.New(1, 1, 1)

				local var_106_1 = arg_103_1:GetWordFromCfg(1101905024)
				local var_106_2 = arg_103_1:FormatText(var_106_1.content)

				arg_103_1.text_.text = var_106_2

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_4 = 33 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_2) / 33)

				if (33 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_2) / 33)) > 0 and var_106_0 < var_106_4 then
					arg_103_1.talkMaxDuration = var_106_4

					if var_106_4 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_4 + 0
					end
				end

				arg_103_1.text_.text = var_106_2
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905024", "story_v_side_new_1101905.awb") ~= 0 then
					local var_106_5 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905024", "story_v_side_new_1101905.awb") / 1000

					if var_106_5 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_5 + 0
					end

					if var_106_1.prefab_name ~= "" and arg_103_1.actors_[var_106_1.prefab_name] ~= nil then
						local var_106_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_1.prefab_name].transform, "story_v_side_new_1101905", "1101905024", "story_v_side_new_1101905.awb")

						arg_103_1:RecordAudio("1101905024", var_106_6)
						arg_103_1:RecordAudio("1101905024", var_106_6)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905024", "story_v_side_new_1101905.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905024", "story_v_side_new_1101905.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_7 = math.max(var_106_0, arg_103_1.talkMaxDuration)

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_7 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - 0) / var_106_7

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= 0 + var_106_7 and arg_103_1.time_ < 0 + var_106_7 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play1101905025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 1101905025
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play1101905026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0.675

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_1 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(1101905025).content)

				arg_107_1.text_.text = var_110_1

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_3 = 27 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_1) / 27)

				if (27 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_1) / 27)) > 0 and var_110_0 < var_110_3 then
					arg_107_1.talkMaxDuration = var_110_3

					if var_110_3 + 0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_3 + 0
					end
				end

				arg_107_1.text_.text = var_110_1
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_4 = math.max(var_110_0, arg_107_1.talkMaxDuration)

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_4 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - 0) / var_110_4

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= 0 + var_110_4 and arg_107_1.time_ < 0 + var_110_4 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play1101905026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 1101905026
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play1101905027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0.325

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_1 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(1101905026).content)

				arg_111_1.text_.text = var_114_1

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_3 = 13 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 13)

				if (13 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 13)) > 0 and var_114_0 < var_114_3 then
					arg_111_1.talkMaxDuration = var_114_3

					if var_114_3 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_3 + 0
					end
				end

				arg_111_1.text_.text = var_114_1
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_4 = math.max(var_114_0, arg_111_1.talkMaxDuration)

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_4 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - 0) / var_114_4

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= 0 + var_114_4 and arg_111_1.time_ < 0 + var_114_4 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play1101905027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 1101905027
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play1101905028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 1.325

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_1 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(1101905027).content)

				arg_115_1.text_.text = var_118_1

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_3 = 53 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_1) / 53)

				if (53 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_1) / 53)) > 0 and var_118_0 < var_118_3 then
					arg_115_1.talkMaxDuration = var_118_3

					if var_118_3 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_3 + 0
					end
				end

				arg_115_1.text_.text = var_118_1
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_4 = math.max(var_118_0, arg_115_1.talkMaxDuration)

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_4 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - 0) / var_118_4

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= 0 + var_118_4 and arg_115_1.time_ < 0 + var_118_4 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play1101905028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 1101905028
		arg_119_1.duration_ = 4.1

		local var_119_0 = {
			zh = 4.1,
			ja = 2.833
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
				arg_119_0:Play1101905029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0.6

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[705].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_1 = arg_119_1:GetWordFromCfg(1101905028)
				local var_122_2 = arg_119_1:FormatText(var_122_1.content)

				arg_119_1.text_.text = var_122_2

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_4 = 24 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 24)

				if (24 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 24)) > 0 and var_122_0 < var_122_4 then
					arg_119_1.talkMaxDuration = var_122_4

					if var_122_4 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_4 + 0
					end
				end

				arg_119_1.text_.text = var_122_2
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905028", "story_v_side_new_1101905.awb") ~= 0 then
					local var_122_5 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905028", "story_v_side_new_1101905.awb") / 1000

					if var_122_5 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_5 + 0
					end

					if var_122_1.prefab_name ~= "" and arg_119_1.actors_[var_122_1.prefab_name] ~= nil then
						local var_122_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_1.prefab_name].transform, "story_v_side_new_1101905", "1101905028", "story_v_side_new_1101905.awb")

						arg_119_1:RecordAudio("1101905028", var_122_6)
						arg_119_1:RecordAudio("1101905028", var_122_6)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905028", "story_v_side_new_1101905.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905028", "story_v_side_new_1101905.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_7 = math.max(var_122_0, arg_119_1.talkMaxDuration)

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_7 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - 0) / var_122_7

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= 0 + var_122_7 and arg_119_1.time_ < 0 + var_122_7 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play1101905029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 1101905029
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play1101905030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0.975

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_1 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(1101905029).content)

				arg_123_1.text_.text = var_126_1

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_3 = 39 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 39)

				if (39 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 39)) > 0 and var_126_0 < var_126_3 then
					arg_123_1.talkMaxDuration = var_126_3

					if var_126_3 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_3 + 0
					end
				end

				arg_123_1.text_.text = var_126_1
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_4 = math.max(var_126_0, arg_123_1.talkMaxDuration)

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - 0) / var_126_4

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play1101905030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 1101905030
		arg_127_1.duration_ = 8.9

		local var_127_0 = {
			zh = 7.633,
			ja = 8.9
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play1101905031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.975

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[706].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwb")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_1 = arg_127_1:GetWordFromCfg(1101905030)
				local var_130_2 = arg_127_1:FormatText(var_130_1.content)

				arg_127_1.text_.text = var_130_2

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_4 = 39 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 39)

				if (39 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 39)) > 0 and var_130_0 < var_130_4 then
					arg_127_1.talkMaxDuration = var_130_4

					if var_130_4 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_4 + 0
					end
				end

				arg_127_1.text_.text = var_130_2
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905030", "story_v_side_new_1101905.awb") ~= 0 then
					local var_130_5 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905030", "story_v_side_new_1101905.awb") / 1000

					if var_130_5 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_5 + 0
					end

					if var_130_1.prefab_name ~= "" and arg_127_1.actors_[var_130_1.prefab_name] ~= nil then
						local var_130_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_1.prefab_name].transform, "story_v_side_new_1101905", "1101905030", "story_v_side_new_1101905.awb")

						arg_127_1:RecordAudio("1101905030", var_130_6)
						arg_127_1:RecordAudio("1101905030", var_130_6)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905030", "story_v_side_new_1101905.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905030", "story_v_side_new_1101905.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_7 = math.max(var_130_0, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_7 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - 0) / var_130_7

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_7 and arg_127_1.time_ < 0 + var_130_7 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play1101905031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 1101905031
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play1101905032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.925

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_1 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(1101905031).content)

				arg_131_1.text_.text = var_134_1

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_3 = 37 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 37)

				if (37 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 37)) > 0 and var_134_0 < var_134_3 then
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
	Play1101905032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 1101905032
		arg_135_1.duration_ = 2.97

		local var_135_0 = {
			zh = 2.966,
			ja = 1.466
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
				arg_135_0:Play1101905033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0.15

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[707].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwc")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_1 = arg_135_1:GetWordFromCfg(1101905032)
				local var_138_2 = arg_135_1:FormatText(var_138_1.content)

				arg_135_1.text_.text = var_138_2

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_4 = 6 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 6)

				if (6 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 6)) > 0 and var_138_0 < var_138_4 then
					arg_135_1.talkMaxDuration = var_138_4

					if var_138_4 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_4 + 0
					end
				end

				arg_135_1.text_.text = var_138_2
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905032", "story_v_side_new_1101905.awb") ~= 0 then
					local var_138_5 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905032", "story_v_side_new_1101905.awb") / 1000

					if var_138_5 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_5 + 0
					end

					if var_138_1.prefab_name ~= "" and arg_135_1.actors_[var_138_1.prefab_name] ~= nil then
						local var_138_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_1.prefab_name].transform, "story_v_side_new_1101905", "1101905032", "story_v_side_new_1101905.awb")

						arg_135_1:RecordAudio("1101905032", var_138_6)
						arg_135_1:RecordAudio("1101905032", var_138_6)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905032", "story_v_side_new_1101905.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905032", "story_v_side_new_1101905.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_7 = math.max(var_138_0, arg_135_1.talkMaxDuration)

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_7 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - 0) / var_138_7

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= 0 + var_138_7 and arg_135_1.time_ < 0 + var_138_7 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play1101905033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 1101905033
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play1101905034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 1.4

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_1 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(1101905033).content)

				arg_139_1.text_.text = var_142_1

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_3 = 56 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 56)

				if (56 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 56)) > 0 and var_142_0 < var_142_3 then
					arg_139_1.talkMaxDuration = var_142_3

					if var_142_3 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_3 + 0
					end
				end

				arg_139_1.text_.text = var_142_1
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_4 = math.max(var_142_0, arg_139_1.talkMaxDuration)

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_4 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - 0) / var_142_4

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= 0 + var_142_4 and arg_139_1.time_ < 0 + var_142_4 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play1101905034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 1101905034
		arg_143_1.duration_ = 3.1

		local var_143_0 = {
			zh = 1.933,
			ja = 3.1
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
				arg_143_0:Play1101905035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0.2

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[705].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_1 = arg_143_1:GetWordFromCfg(1101905034)
				local var_146_2 = arg_143_1:FormatText(var_146_1.content)

				arg_143_1.text_.text = var_146_2

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_4 = 8 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 8)

				if (8 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 8)) > 0 and var_146_0 < var_146_4 then
					arg_143_1.talkMaxDuration = var_146_4

					if var_146_4 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_4 + 0
					end
				end

				arg_143_1.text_.text = var_146_2
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905034", "story_v_side_new_1101905.awb") ~= 0 then
					local var_146_5 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905034", "story_v_side_new_1101905.awb") / 1000

					if var_146_5 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + 0
					end

					if var_146_1.prefab_name ~= "" and arg_143_1.actors_[var_146_1.prefab_name] ~= nil then
						local var_146_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_1.prefab_name].transform, "story_v_side_new_1101905", "1101905034", "story_v_side_new_1101905.awb")

						arg_143_1:RecordAudio("1101905034", var_146_6)
						arg_143_1:RecordAudio("1101905034", var_146_6)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905034", "story_v_side_new_1101905.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905034", "story_v_side_new_1101905.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_7 = math.max(var_146_0, arg_143_1.talkMaxDuration)

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_7 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - 0) / var_146_7

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= 0 + var_146_7 and arg_143_1.time_ < 0 + var_146_7 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play1101905035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 1101905035
		arg_147_1.duration_ = 9

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play1101905036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 2 < arg_147_1.time_ and arg_147_1.time_ <= 2 + arg_150_0 then
				local var_150_0 = arg_147_1.bgs_.A00

				arg_147_1.bgs_.A00.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_150_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_150_1 = var_150_0:GetComponent("SpriteRenderer")

				if var_150_1 and var_150_1.sprite then
					local var_150_2 = 2 * (var_150_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_150_0.transform.localScale = Vector3.New(var_150_2 / var_150_1.sprite.bounds.size.y < var_150_2 * manager.ui.mainCameraCom_.aspect / var_150_1.sprite.bounds.size.x and var_150_2 * manager.ui.mainCameraCom_.aspect / var_150_1.sprite.bounds.size.x or var_150_2 / var_150_1.sprite.bounds.size.y, var_150_2 / var_150_1.sprite.bounds.size.y < var_150_2 * manager.ui.mainCameraCom_.aspect / var_150_1.sprite.bounds.size.x and var_150_2 * manager.ui.mainCameraCom_.aspect / var_150_1.sprite.bounds.size.x or var_150_2 / var_150_1.sprite.bounds.size.y, 0)
				end

				for iter_150_0, iter_150_1 in pairs(arg_147_1.bgs_) do
					if iter_150_0 ~= "A00" then
						iter_150_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_150_3 = 0

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_3 + arg_150_0 then
				arg_147_1.mask_.enabled = true
				arg_147_1.mask_.raycastTarget = true

				arg_147_1:SetGaussion(false)
			end

			local var_150_4 = 2

			if var_150_3 <= arg_147_1.time_ and arg_147_1.time_ < var_150_3 + var_150_4 then
				local var_150_5 = Color.New(0, 0, 0)

				var_150_5.a = Mathf.Lerp(0, 1, (arg_147_1.time_ - var_150_3) / var_150_4)
				arg_147_1.mask_.color = var_150_5
			end

			if arg_147_1.time_ >= var_150_3 + var_150_4 and arg_147_1.time_ < var_150_3 + var_150_4 + arg_150_0 then
				local var_150_6 = Color.New(0, 0, 0)

				var_150_6.a = 1
				arg_147_1.mask_.color = var_150_6
			end

			local var_150_7 = 2

			if 2 < arg_147_1.time_ and arg_147_1.time_ <= var_150_7 + arg_150_0 then
				arg_147_1.mask_.enabled = true
				arg_147_1.mask_.raycastTarget = true

				arg_147_1:SetGaussion(false)
			end

			local var_150_8 = 2

			if var_150_7 <= arg_147_1.time_ and arg_147_1.time_ < var_150_7 + var_150_8 then
				local var_150_9 = Color.New(0, 0, 0)

				var_150_9.a = Mathf.Lerp(1, 0, (arg_147_1.time_ - var_150_7) / var_150_8)
				arg_147_1.mask_.color = var_150_9
			end

			if arg_147_1.time_ >= var_150_7 + var_150_8 and arg_147_1.time_ < var_150_7 + var_150_8 + arg_150_0 then
				local var_150_10 = Color.New(0, 0, 0)

				arg_147_1.mask_.enabled = false
				var_150_10.a = 0
				arg_147_1.mask_.color = var_150_10
			end

			if arg_147_1.frameCnt_ <= 1 then
				arg_147_1.dialog_:SetActive(false)
			end

			local var_150_11 = 4
			local var_150_12 = 1.125

			if 4 < arg_147_1.time_ and arg_147_1.time_ <= var_150_11 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0

				arg_147_1.dialog_:SetActive(true)

				arg_147_1.dialogCg_.alpha = 0

				local var_150_13 = LeanTween.value(arg_147_1.dialog_, 0, 1, 0.3)

				var_150_13:setOnUpdate(LuaHelper.FloatAction(function(arg_151_0)
					arg_147_1.dialogCg_.alpha = arg_151_0
				end))
				var_150_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_147_1.dialog_)
					var_150_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_147_1.duration_ = arg_147_1.duration_ + 0.3

				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_14 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(1101905035).content)

				arg_147_1.text_.text = var_150_14

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_16 = 45 <= 0 and var_150_12 or var_150_12 * (utf8.len(var_150_14) / 45)

				if (45 <= 0 and var_150_12 or var_150_12 * (utf8.len(var_150_14) / 45)) > 0 and var_150_12 < var_150_16 then
					arg_147_1.talkMaxDuration = var_150_16
					var_150_11 = var_150_11 + 0.3

					if var_150_16 + var_150_11 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_16 + var_150_11
					end
				end

				arg_147_1.text_.text = var_150_14
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_17 = var_150_11 + 0.3
			local var_150_18 = math.max(var_150_12, arg_147_1.talkMaxDuration)

			if var_150_11 + 0.3 <= arg_147_1.time_ and arg_147_1.time_ < var_150_17 + var_150_18 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_17) / var_150_18

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_17 + var_150_18 and arg_147_1.time_ < var_150_17 + var_150_18 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play1101905036 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 1101905036
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play1101905037(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0.975

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_1 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(1101905036).content)

				arg_153_1.text_.text = var_156_1

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_3 = 39 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_1) / 39)

				if (39 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_1) / 39)) > 0 and var_156_0 < var_156_3 then
					arg_153_1.talkMaxDuration = var_156_3

					if var_156_3 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_3 + 0
					end
				end

				arg_153_1.text_.text = var_156_1
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_4 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_4 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_4

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_4 and arg_153_1.time_ < 0 + var_156_4 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play1101905037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 1101905037
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play1101905038(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.35

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_1 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(1101905037).content)

				arg_157_1.text_.text = var_160_1

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_3 = 14 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 14)

				if (14 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 14)) > 0 and var_160_0 < var_160_3 then
					arg_157_1.talkMaxDuration = var_160_3

					if var_160_3 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_3 + 0
					end
				end

				arg_157_1.text_.text = var_160_1
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_4 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_4 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_4

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_4 and arg_157_1.time_ < 0 + var_160_4 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play1101905038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 1101905038
		arg_161_1.duration_ = 2.2

		local var_161_0 = {
			zh = 1.999999999999,
			ja = 2.2
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play1101905039(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if arg_161_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_164_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_161_1.stage_.transform)

				var_164_0.name = "1019ui_story"
				var_164_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_161_1.actors_["1019ui_story"] = var_164_0

				local var_164_1 = var_164_0:GetComponentInChildren(typeof(CharacterEffect))

				var_164_1.enabled = true

				local var_164_2 = GameObjectTools.GetOrAddComponent(var_164_0, typeof(DynamicBoneHelper))

				if var_164_2 then
					var_164_2:EnableDynamicBone(false)
				end

				arg_161_1:ShowWeapon(var_164_1.transform, false)

				arg_161_1.var_["1019ui_story" .. "Animator"] = var_164_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_161_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_161_1.var_["1019ui_story" .. "LipSync"] = var_164_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_164_3 = arg_161_1.actors_["1019ui_story"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1019ui_story = var_164_3.localPosition
			end

			local var_164_4 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				var_164_3.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_161_1.time_ - 0) / var_164_4)
				var_164_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_3.position).x, (manager.ui.mainCamera.transform.position - var_164_3.position).y, (manager.ui.mainCamera.transform.position - var_164_3.position).z)
				var_164_3.localEulerAngles.z = 0
				var_164_3.localEulerAngles.x = 0
				var_164_3.localEulerAngles = var_164_3.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				var_164_3.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_164_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_3.position).x, (manager.ui.mainCamera.transform.position - var_164_3.position).y, (manager.ui.mainCamera.transform.position - var_164_3.position).z)
				var_164_3.localEulerAngles.z = 0
				var_164_3.localEulerAngles.x = 0
				var_164_3.localEulerAngles = var_164_3.localEulerAngles
			end

			local var_164_5 = arg_161_1.actors_["1019ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_5) and arg_161_1.var_.characterEffect1019ui_story == nil then
				arg_161_1.var_.characterEffect1019ui_story = var_164_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_6 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_6 and not isNil(var_164_5) then
				if arg_161_1.var_.characterEffect1019ui_story and not isNil(var_164_5) then
					arg_161_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_6 and arg_161_1.time_ < 0 + var_164_6 + arg_164_0 and not isNil(var_164_5) and arg_161_1.var_.characterEffect1019ui_story then
				arg_161_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_164_8 = 0
			local var_164_9 = 0.15

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_8 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_10 = arg_161_1:GetWordFromCfg(1101905038)
				local var_164_11 = arg_161_1:FormatText(var_164_10.content)

				arg_161_1.text_.text = var_164_11

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_13 = 6 <= 0 and var_164_9 or var_164_9 * (utf8.len(var_164_11) / 6)

				if (6 <= 0 and var_164_9 or var_164_9 * (utf8.len(var_164_11) / 6)) > 0 and var_164_9 < var_164_13 then
					arg_161_1.talkMaxDuration = var_164_13

					if var_164_13 + var_164_8 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_13 + var_164_8
					end
				end

				arg_161_1.text_.text = var_164_11
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905038", "story_v_side_new_1101905.awb") ~= 0 then
					local var_164_14 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905038", "story_v_side_new_1101905.awb") / 1000

					if var_164_14 + var_164_8 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_14 + var_164_8
					end

					if var_164_10.prefab_name ~= "" and arg_161_1.actors_[var_164_10.prefab_name] ~= nil then
						local var_164_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_10.prefab_name].transform, "story_v_side_new_1101905", "1101905038", "story_v_side_new_1101905.awb")

						arg_161_1:RecordAudio("1101905038", var_164_15)
						arg_161_1:RecordAudio("1101905038", var_164_15)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905038", "story_v_side_new_1101905.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905038", "story_v_side_new_1101905.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_16 = math.max(var_164_9, arg_161_1.talkMaxDuration)

			if var_164_8 <= arg_161_1.time_ and arg_161_1.time_ < var_164_8 + var_164_16 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_8) / var_164_16

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_8 + var_164_16 and arg_161_1.time_ < var_164_8 + var_164_16 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play1101905039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 1101905039
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play1101905040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["1019ui_story"]) and arg_165_1.var_.characterEffect1019ui_story == nil then
				arg_165_1.var_.characterEffect1019ui_story = arg_165_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_0 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["1019ui_story"]) then
				if arg_165_1.var_.characterEffect1019ui_story and not isNil(arg_165_1.actors_["1019ui_story"]) then
					arg_165_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_0)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["1019ui_story"]) and arg_165_1.var_.characterEffect1019ui_story then
				arg_165_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_168_1 = 0
			local var_168_2 = 0.4

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_3 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(1101905039).content)

				arg_165_1.text_.text = var_168_3

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 16 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 16)

				if (16 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 16)) > 0 and var_168_2 < var_168_5 then
					arg_165_1.talkMaxDuration = var_168_5

					if var_168_5 + var_168_1 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + var_168_1
					end
				end

				arg_165_1.text_.text = var_168_3
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_6 = math.max(var_168_2, arg_165_1.talkMaxDuration)

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_6 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_1) / var_168_6

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_1 + var_168_6 and arg_165_1.time_ < var_168_1 + var_168_6 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play1101905040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 1101905040
		arg_169_1.duration_ = 8.23

		local var_169_0 = {
			zh = 4.733,
			ja = 8.233
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play1101905041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1019ui_story = arg_169_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_172_0 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				arg_169_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_169_1.time_ - 0) / var_172_0)
				arg_169_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1019ui_story"].transform.position).z)
				arg_169_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1019ui_story"].transform.localEulerAngles = arg_169_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				arg_169_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_169_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1019ui_story"].transform.position).z)
				arg_169_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1019ui_story"].transform.localEulerAngles = arg_169_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_172_1 = arg_169_1.actors_["1019ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1019ui_story == nil then
				arg_169_1.var_.characterEffect1019ui_story = var_172_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_2 and not isNil(var_172_1) then
				if arg_169_1.var_.characterEffect1019ui_story and not isNil(var_172_1) then
					arg_169_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_2 and arg_169_1.time_ < 0 + var_172_2 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1019ui_story then
				arg_169_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_172_4 = 0
			local var_172_5 = 0.575

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_4 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_6 = arg_169_1:GetWordFromCfg(1101905040)
				local var_172_7 = arg_169_1:FormatText(var_172_6.content)

				arg_169_1.text_.text = var_172_7

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_9 = 23 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 23)

				if (23 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 23)) > 0 and var_172_5 < var_172_9 then
					arg_169_1.talkMaxDuration = var_172_9

					if var_172_9 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_9 + var_172_4
					end
				end

				arg_169_1.text_.text = var_172_7
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905040", "story_v_side_new_1101905.awb") ~= 0 then
					local var_172_10 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905040", "story_v_side_new_1101905.awb") / 1000

					if var_172_10 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_10 + var_172_4
					end

					if var_172_6.prefab_name ~= "" and arg_169_1.actors_[var_172_6.prefab_name] ~= nil then
						local var_172_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_6.prefab_name].transform, "story_v_side_new_1101905", "1101905040", "story_v_side_new_1101905.awb")

						arg_169_1:RecordAudio("1101905040", var_172_11)
						arg_169_1:RecordAudio("1101905040", var_172_11)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905040", "story_v_side_new_1101905.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905040", "story_v_side_new_1101905.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_12 = math.max(var_172_5, arg_169_1.talkMaxDuration)

			if var_172_4 <= arg_169_1.time_ and arg_169_1.time_ < var_172_4 + var_172_12 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_4) / var_172_12

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_4 + var_172_12 and arg_169_1.time_ < var_172_4 + var_172_12 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play1101905041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 1101905041
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play1101905042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["1019ui_story"]) and arg_173_1.var_.characterEffect1019ui_story == nil then
				arg_173_1.var_.characterEffect1019ui_story = arg_173_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_0 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["1019ui_story"]) then
				if arg_173_1.var_.characterEffect1019ui_story and not isNil(arg_173_1.actors_["1019ui_story"]) then
					arg_173_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_0)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["1019ui_story"]) and arg_173_1.var_.characterEffect1019ui_story then
				arg_173_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_176_1 = 0
			local var_176_2 = 0.425

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_3 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(1101905041).content)

				arg_173_1.text_.text = var_176_3

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 17 <= 0 and var_176_2 or var_176_2 * (utf8.len(var_176_3) / 17)

				if (17 <= 0 and var_176_2 or var_176_2 * (utf8.len(var_176_3) / 17)) > 0 and var_176_2 < var_176_5 then
					arg_173_1.talkMaxDuration = var_176_5

					if var_176_5 + var_176_1 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + var_176_1
					end
				end

				arg_173_1.text_.text = var_176_3
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_6 = math.max(var_176_2, arg_173_1.talkMaxDuration)

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_6 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_1) / var_176_6

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_1 + var_176_6 and arg_173_1.time_ < var_176_1 + var_176_6 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play1101905042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 1101905042
		arg_177_1.duration_ = 8.17

		local var_177_0 = {
			zh = 5.366,
			ja = 8.166
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play1101905043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["1019ui_story"]) and arg_177_1.var_.characterEffect1019ui_story == nil then
				arg_177_1.var_.characterEffect1019ui_story = arg_177_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["1019ui_story"]) then
				if arg_177_1.var_.characterEffect1019ui_story and not isNil(arg_177_1.actors_["1019ui_story"]) then
					arg_177_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["1019ui_story"]) and arg_177_1.var_.characterEffect1019ui_story then
				arg_177_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_180_2 = 0
			local var_180_3 = 0.65

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_2 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_4 = arg_177_1:GetWordFromCfg(1101905042)
				local var_180_5 = arg_177_1:FormatText(var_180_4.content)

				arg_177_1.text_.text = var_180_5

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_7 = 26 <= 0 and var_180_3 or var_180_3 * (utf8.len(var_180_5) / 26)

				if (26 <= 0 and var_180_3 or var_180_3 * (utf8.len(var_180_5) / 26)) > 0 and var_180_3 < var_180_7 then
					arg_177_1.talkMaxDuration = var_180_7

					if var_180_7 + var_180_2 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_7 + var_180_2
					end
				end

				arg_177_1.text_.text = var_180_5
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905042", "story_v_side_new_1101905.awb") ~= 0 then
					local var_180_8 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905042", "story_v_side_new_1101905.awb") / 1000

					if var_180_8 + var_180_2 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_8 + var_180_2
					end

					if var_180_4.prefab_name ~= "" and arg_177_1.actors_[var_180_4.prefab_name] ~= nil then
						local var_180_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_4.prefab_name].transform, "story_v_side_new_1101905", "1101905042", "story_v_side_new_1101905.awb")

						arg_177_1:RecordAudio("1101905042", var_180_9)
						arg_177_1:RecordAudio("1101905042", var_180_9)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905042", "story_v_side_new_1101905.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905042", "story_v_side_new_1101905.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_10 = math.max(var_180_3, arg_177_1.talkMaxDuration)

			if var_180_2 <= arg_177_1.time_ and arg_177_1.time_ < var_180_2 + var_180_10 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_2) / var_180_10

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_2 + var_180_10 and arg_177_1.time_ < var_180_2 + var_180_10 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play1101905043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 1101905043
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play1101905044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["1019ui_story"]) and arg_181_1.var_.characterEffect1019ui_story == nil then
				arg_181_1.var_.characterEffect1019ui_story = arg_181_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_0 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["1019ui_story"]) then
				if arg_181_1.var_.characterEffect1019ui_story and not isNil(arg_181_1.actors_["1019ui_story"]) then
					arg_181_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_0)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["1019ui_story"]) and arg_181_1.var_.characterEffect1019ui_story then
				arg_181_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_184_1 = 0
			local var_184_2 = 0.55

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_3 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(1101905043).content)

				arg_181_1.text_.text = var_184_3

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 22 <= 0 and var_184_2 or var_184_2 * (utf8.len(var_184_3) / 22)

				if (22 <= 0 and var_184_2 or var_184_2 * (utf8.len(var_184_3) / 22)) > 0 and var_184_2 < var_184_5 then
					arg_181_1.talkMaxDuration = var_184_5

					if var_184_5 + var_184_1 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + var_184_1
					end
				end

				arg_181_1.text_.text = var_184_3
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_6 = math.max(var_184_2, arg_181_1.talkMaxDuration)

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_6 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_1) / var_184_6

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_1 + var_184_6 and arg_181_1.time_ < var_184_1 + var_184_6 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play1101905044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 1101905044
		arg_185_1.duration_ = 7.3

		local var_185_0 = {
			zh = 3.7,
			ja = 7.3
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play1101905045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(arg_185_1.actors_["1019ui_story"]) and arg_185_1.var_.characterEffect1019ui_story == nil then
				arg_185_1.var_.characterEffect1019ui_story = arg_185_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_0 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 and not isNil(arg_185_1.actors_["1019ui_story"]) then
				if arg_185_1.var_.characterEffect1019ui_story and not isNil(arg_185_1.actors_["1019ui_story"]) then
					arg_185_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 and not isNil(arg_185_1.actors_["1019ui_story"]) and arg_185_1.var_.characterEffect1019ui_story then
				arg_185_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_188_2 = 0
			local var_188_3 = 0.45

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_2 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_4 = arg_185_1:GetWordFromCfg(1101905044)
				local var_188_5 = arg_185_1:FormatText(var_188_4.content)

				arg_185_1.text_.text = var_188_5

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_7 = 18 <= 0 and var_188_3 or var_188_3 * (utf8.len(var_188_5) / 18)

				if (18 <= 0 and var_188_3 or var_188_3 * (utf8.len(var_188_5) / 18)) > 0 and var_188_3 < var_188_7 then
					arg_185_1.talkMaxDuration = var_188_7

					if var_188_7 + var_188_2 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_2
					end
				end

				arg_185_1.text_.text = var_188_5
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905044", "story_v_side_new_1101905.awb") ~= 0 then
					local var_188_8 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905044", "story_v_side_new_1101905.awb") / 1000

					if var_188_8 + var_188_2 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_8 + var_188_2
					end

					if var_188_4.prefab_name ~= "" and arg_185_1.actors_[var_188_4.prefab_name] ~= nil then
						local var_188_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_4.prefab_name].transform, "story_v_side_new_1101905", "1101905044", "story_v_side_new_1101905.awb")

						arg_185_1:RecordAudio("1101905044", var_188_9)
						arg_185_1:RecordAudio("1101905044", var_188_9)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905044", "story_v_side_new_1101905.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905044", "story_v_side_new_1101905.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_10 = math.max(var_188_3, arg_185_1.talkMaxDuration)

			if var_188_2 <= arg_185_1.time_ and arg_185_1.time_ < var_188_2 + var_188_10 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_2) / var_188_10

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_2 + var_188_10 and arg_185_1.time_ < var_188_2 + var_188_10 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play1101905045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 1101905045
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play1101905046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["1019ui_story"]) and arg_189_1.var_.characterEffect1019ui_story == nil then
				arg_189_1.var_.characterEffect1019ui_story = arg_189_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_0 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["1019ui_story"]) then
				if arg_189_1.var_.characterEffect1019ui_story and not isNil(arg_189_1.actors_["1019ui_story"]) then
					arg_189_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_0)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["1019ui_story"]) and arg_189_1.var_.characterEffect1019ui_story then
				arg_189_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_192_1 = 0
			local var_192_2 = 0.65

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_3 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(1101905045).content)

				arg_189_1.text_.text = var_192_3

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 26 <= 0 and var_192_2 or var_192_2 * (utf8.len(var_192_3) / 26)

				if (26 <= 0 and var_192_2 or var_192_2 * (utf8.len(var_192_3) / 26)) > 0 and var_192_2 < var_192_5 then
					arg_189_1.talkMaxDuration = var_192_5

					if var_192_5 + var_192_1 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + var_192_1
					end
				end

				arg_189_1.text_.text = var_192_3
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_6 = math.max(var_192_2, arg_189_1.talkMaxDuration)

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_6 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_1) / var_192_6

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_1 + var_192_6 and arg_189_1.time_ < var_192_1 + var_192_6 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play1101905046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 1101905046
		arg_193_1.duration_ = 9.2

		local var_193_0 = {
			zh = 9.2,
			ja = 5.5
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play1101905047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1019ui_story = arg_193_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_196_0 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 then
				arg_193_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_193_1.time_ - 0) / var_196_0)
				arg_193_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1019ui_story"].transform.position).z)
				arg_193_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1019ui_story"].transform.localEulerAngles = arg_193_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 then
				arg_193_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_193_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1019ui_story"].transform.position).z)
				arg_193_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1019ui_story"].transform.localEulerAngles = arg_193_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_196_1 = arg_193_1.actors_["1019ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect1019ui_story == nil then
				arg_193_1.var_.characterEffect1019ui_story = var_196_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_2 and not isNil(var_196_1) then
				if arg_193_1.var_.characterEffect1019ui_story and not isNil(var_196_1) then
					arg_193_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_2 and arg_193_1.time_ < 0 + var_196_2 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect1019ui_story then
				arg_193_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_2")
			end

			local var_196_4 = 0
			local var_196_5 = 1.05

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_6 = arg_193_1:GetWordFromCfg(1101905046)
				local var_196_7 = arg_193_1:FormatText(var_196_6.content)

				arg_193_1.text_.text = var_196_7

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_9 = 42 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 42)

				if (42 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 42)) > 0 and var_196_5 < var_196_9 then
					arg_193_1.talkMaxDuration = var_196_9

					if var_196_9 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_9 + var_196_4
					end
				end

				arg_193_1.text_.text = var_196_7
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905046", "story_v_side_new_1101905.awb") ~= 0 then
					local var_196_10 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905046", "story_v_side_new_1101905.awb") / 1000

					if var_196_10 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_10 + var_196_4
					end

					if var_196_6.prefab_name ~= "" and arg_193_1.actors_[var_196_6.prefab_name] ~= nil then
						local var_196_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_6.prefab_name].transform, "story_v_side_new_1101905", "1101905046", "story_v_side_new_1101905.awb")

						arg_193_1:RecordAudio("1101905046", var_196_11)
						arg_193_1:RecordAudio("1101905046", var_196_11)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905046", "story_v_side_new_1101905.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905046", "story_v_side_new_1101905.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_12 = math.max(var_196_5, arg_193_1.talkMaxDuration)

			if var_196_4 <= arg_193_1.time_ and arg_193_1.time_ < var_196_4 + var_196_12 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_4) / var_196_12

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_4 + var_196_12 and arg_193_1.time_ < var_196_4 + var_196_12 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play1101905047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 1101905047
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play1101905048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["1019ui_story"]) and arg_197_1.var_.characterEffect1019ui_story == nil then
				arg_197_1.var_.characterEffect1019ui_story = arg_197_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_0 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["1019ui_story"]) then
				if arg_197_1.var_.characterEffect1019ui_story and not isNil(arg_197_1.actors_["1019ui_story"]) then
					arg_197_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_0)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["1019ui_story"]) and arg_197_1.var_.characterEffect1019ui_story then
				arg_197_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_200_1 = 0
			local var_200_2 = 0.95

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_3 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(1101905047).content)

				arg_197_1.text_.text = var_200_3

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 38 <= 0 and var_200_2 or var_200_2 * (utf8.len(var_200_3) / 38)

				if (38 <= 0 and var_200_2 or var_200_2 * (utf8.len(var_200_3) / 38)) > 0 and var_200_2 < var_200_5 then
					arg_197_1.talkMaxDuration = var_200_5

					if var_200_5 + var_200_1 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + var_200_1
					end
				end

				arg_197_1.text_.text = var_200_3
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_6 = math.max(var_200_2, arg_197_1.talkMaxDuration)

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_6 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_1) / var_200_6

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_1 + var_200_6 and arg_197_1.time_ < var_200_1 + var_200_6 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play1101905048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 1101905048
		arg_201_1.duration_ = 2.47

		local var_201_0 = {
			zh = 2.466,
			ja = 2.2
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play1101905049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos1019ui_story = arg_201_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_204_0 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 then
				arg_201_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_201_1.time_ - 0) / var_204_0)
				arg_201_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1019ui_story"].transform.position).z)
				arg_201_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1019ui_story"].transform.localEulerAngles = arg_201_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 then
				arg_201_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_201_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1019ui_story"].transform.position).z)
				arg_201_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1019ui_story"].transform.localEulerAngles = arg_201_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_204_1 = arg_201_1.actors_["1019ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_1) and arg_201_1.var_.characterEffect1019ui_story == nil then
				arg_201_1.var_.characterEffect1019ui_story = var_204_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_2 and not isNil(var_204_1) then
				if arg_201_1.var_.characterEffect1019ui_story and not isNil(var_204_1) then
					arg_201_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= 0 + var_204_2 and arg_201_1.time_ < 0 + var_204_2 + arg_204_0 and not isNil(var_204_1) and arg_201_1.var_.characterEffect1019ui_story then
				arg_201_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_204_4 = 0
			local var_204_5 = 0.25

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_4 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_6 = arg_201_1:GetWordFromCfg(1101905048)
				local var_204_7 = arg_201_1:FormatText(var_204_6.content)

				arg_201_1.text_.text = var_204_7

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_9 = 10 <= 0 and var_204_5 or var_204_5 * (utf8.len(var_204_7) / 10)

				if (10 <= 0 and var_204_5 or var_204_5 * (utf8.len(var_204_7) / 10)) > 0 and var_204_5 < var_204_9 then
					arg_201_1.talkMaxDuration = var_204_9

					if var_204_9 + var_204_4 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_9 + var_204_4
					end
				end

				arg_201_1.text_.text = var_204_7
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905048", "story_v_side_new_1101905.awb") ~= 0 then
					local var_204_10 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905048", "story_v_side_new_1101905.awb") / 1000

					if var_204_10 + var_204_4 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_10 + var_204_4
					end

					if var_204_6.prefab_name ~= "" and arg_201_1.actors_[var_204_6.prefab_name] ~= nil then
						local var_204_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_6.prefab_name].transform, "story_v_side_new_1101905", "1101905048", "story_v_side_new_1101905.awb")

						arg_201_1:RecordAudio("1101905048", var_204_11)
						arg_201_1:RecordAudio("1101905048", var_204_11)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905048", "story_v_side_new_1101905.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905048", "story_v_side_new_1101905.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_12 = math.max(var_204_5, arg_201_1.talkMaxDuration)

			if var_204_4 <= arg_201_1.time_ and arg_201_1.time_ < var_204_4 + var_204_12 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_4) / var_204_12

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_4 + var_204_12 and arg_201_1.time_ < var_204_4 + var_204_12 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play1101905049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 1101905049
		arg_205_1.duration_ = 14.3

		local var_205_0 = {
			zh = 12.566,
			ja = 14.3
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play1101905050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if arg_205_1.bgs_.S0004 == nil then
				local var_208_0 = Object.Instantiate(arg_205_1.paintGo_)

				var_208_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "S0004")
				var_208_0.name = "S0004"
				var_208_0.transform.parent = arg_205_1.stage_.transform
				var_208_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_205_1.bgs_.S0004 = var_208_0
			end

			if 2 < arg_205_1.time_ and arg_205_1.time_ <= 2 + arg_208_0 then
				local var_208_1 = arg_205_1.bgs_.S0004

				arg_205_1.bgs_.S0004.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_208_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_208_2 = var_208_1:GetComponent("SpriteRenderer")

				if var_208_2 and var_208_2.sprite then
					local var_208_3 = 2 * (var_208_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_208_1.transform.localScale = Vector3.New(var_208_3 / var_208_2.sprite.bounds.size.y < var_208_3 * manager.ui.mainCameraCom_.aspect / var_208_2.sprite.bounds.size.x and var_208_3 * manager.ui.mainCameraCom_.aspect / var_208_2.sprite.bounds.size.x or var_208_3 / var_208_2.sprite.bounds.size.y, var_208_3 / var_208_2.sprite.bounds.size.y < var_208_3 * manager.ui.mainCameraCom_.aspect / var_208_2.sprite.bounds.size.x and var_208_3 * manager.ui.mainCameraCom_.aspect / var_208_2.sprite.bounds.size.x or var_208_3 / var_208_2.sprite.bounds.size.y, 0)
				end

				for iter_208_0, iter_208_1 in pairs(arg_205_1.bgs_) do
					if iter_208_0 ~= "S0004" then
						iter_208_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_208_4 = 0

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_4 + arg_208_0 then
				arg_205_1.mask_.enabled = true
				arg_205_1.mask_.raycastTarget = true

				arg_205_1:SetGaussion(false)
			end

			local var_208_5 = 2

			if var_208_4 <= arg_205_1.time_ and arg_205_1.time_ < var_208_4 + var_208_5 then
				local var_208_6 = Color.New(0, 0, 0)

				var_208_6.a = Mathf.Lerp(0, 1, (arg_205_1.time_ - var_208_4) / var_208_5)
				arg_205_1.mask_.color = var_208_6
			end

			if arg_205_1.time_ >= var_208_4 + var_208_5 and arg_205_1.time_ < var_208_4 + var_208_5 + arg_208_0 then
				local var_208_7 = Color.New(0, 0, 0)

				var_208_7.a = 1
				arg_205_1.mask_.color = var_208_7
			end

			local var_208_8 = 2

			if 2 < arg_205_1.time_ and arg_205_1.time_ <= var_208_8 + arg_208_0 then
				arg_205_1.mask_.enabled = true
				arg_205_1.mask_.raycastTarget = true

				arg_205_1:SetGaussion(false)
			end

			local var_208_9 = 2

			if var_208_8 <= arg_205_1.time_ and arg_205_1.time_ < var_208_8 + var_208_9 then
				local var_208_10 = Color.New(0, 0, 0)

				var_208_10.a = Mathf.Lerp(1, 0, (arg_205_1.time_ - var_208_8) / var_208_9)
				arg_205_1.mask_.color = var_208_10
			end

			if arg_205_1.time_ >= var_208_8 + var_208_9 and arg_205_1.time_ < var_208_8 + var_208_9 + arg_208_0 then
				local var_208_11 = Color.New(0, 0, 0)

				arg_205_1.mask_.enabled = false
				var_208_11.a = 0
				arg_205_1.mask_.color = var_208_11
			end

			local var_208_12 = arg_205_1.actors_["1019ui_story"].transform

			if 2 < arg_205_1.time_ and arg_205_1.time_ <= 2 + arg_208_0 then
				arg_205_1.var_.moveOldPos1019ui_story = var_208_12.localPosition
			end

			local var_208_13 = 0.001

			if 2 <= arg_205_1.time_ and arg_205_1.time_ < 2 + var_208_13 then
				var_208_12.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_205_1.time_ - 2) / var_208_13)
				var_208_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_12.position).x, (manager.ui.mainCamera.transform.position - var_208_12.position).y, (manager.ui.mainCamera.transform.position - var_208_12.position).z)
				var_208_12.localEulerAngles.z = 0
				var_208_12.localEulerAngles.x = 0
				var_208_12.localEulerAngles = var_208_12.localEulerAngles
			end

			if arg_205_1.time_ >= 2 + var_208_13 and arg_205_1.time_ < 2 + var_208_13 + arg_208_0 then
				var_208_12.localPosition = Vector3.New(0, 100, 0)
				var_208_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_12.position).x, (manager.ui.mainCamera.transform.position - var_208_12.position).y, (manager.ui.mainCamera.transform.position - var_208_12.position).z)
				var_208_12.localEulerAngles.z = 0
				var_208_12.localEulerAngles.x = 0
				var_208_12.localEulerAngles = var_208_12.localEulerAngles
			end

			local var_208_14 = arg_205_1.actors_["1019ui_story"]

			if 2 < arg_205_1.time_ and arg_205_1.time_ <= 2 + arg_208_0 and not isNil(var_208_14) and arg_205_1.var_.characterEffect1019ui_story == nil then
				arg_205_1.var_.characterEffect1019ui_story = var_208_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_15 = 0.200000002980232

			if 2 <= arg_205_1.time_ and arg_205_1.time_ < 2 + var_208_15 and not isNil(var_208_14) then
				if arg_205_1.var_.characterEffect1019ui_story and not isNil(var_208_14) then
					arg_205_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= 2 + var_208_15 and arg_205_1.time_ < 2 + var_208_15 + arg_208_0 and not isNil(var_208_14) and arg_205_1.var_.characterEffect1019ui_story then
				arg_205_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_208_17 = 2

			arg_205_1.isInRecall_ = false

			if var_208_17 < arg_205_1.time_ and arg_205_1.time_ <= var_208_17 + arg_208_0 then
				arg_205_1.screenFilterGo_:SetActive(true)

				arg_205_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_208_2, iter_208_3 in pairs(arg_205_1.actors_) do
					for iter_208_4, iter_208_5 in ipairs((iter_208_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_208_5.color = iter_208_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_208_18 = 0.2

			if var_208_17 <= arg_205_1.time_ and arg_205_1.time_ < var_208_17 + var_208_18 then
				arg_205_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_205_1.time_ - var_208_17) / var_208_18)
			end

			if arg_205_1.time_ >= var_208_17 + var_208_18 and arg_205_1.time_ < var_208_17 + var_208_18 + arg_208_0 then
				arg_205_1.screenFilterEffect_.weight = 1
			end

			if arg_205_1.frameCnt_ <= 1 then
				arg_205_1.dialog_:SetActive(false)
			end

			local var_208_19 = 4
			local var_208_20 = 0.875

			if 4 < arg_205_1.time_ and arg_205_1.time_ <= var_208_19 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0

				arg_205_1.dialog_:SetActive(true)

				arg_205_1.dialogCg_.alpha = 0

				local var_208_21 = LeanTween.value(arg_205_1.dialog_, 0, 1, 0.3)

				var_208_21:setOnUpdate(LuaHelper.FloatAction(function(arg_209_0)
					arg_205_1.dialogCg_.alpha = arg_209_0
				end))
				var_208_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_205_1.dialog_)
					var_208_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_205_1.duration_ = arg_205_1.duration_ + 0.3

				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_22 = arg_205_1:GetWordFromCfg(1101905049)
				local var_208_23 = arg_205_1:FormatText(var_208_22.content)

				arg_205_1.text_.text = var_208_23

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_25 = 35 <= 0 and var_208_20 or var_208_20 * (utf8.len(var_208_23) / 35)

				if (35 <= 0 and var_208_20 or var_208_20 * (utf8.len(var_208_23) / 35)) > 0 and var_208_20 < var_208_25 then
					arg_205_1.talkMaxDuration = var_208_25
					var_208_19 = var_208_19 + 0.3

					if var_208_25 + var_208_19 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_25 + var_208_19
					end
				end

				arg_205_1.text_.text = var_208_23
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905049", "story_v_side_new_1101905.awb") ~= 0 then
					local var_208_26 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905049", "story_v_side_new_1101905.awb") / 1000

					if var_208_26 + var_208_19 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_26 + var_208_19
					end

					if var_208_22.prefab_name ~= "" and arg_205_1.actors_[var_208_22.prefab_name] ~= nil then
						local var_208_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_22.prefab_name].transform, "story_v_side_new_1101905", "1101905049", "story_v_side_new_1101905.awb")

						arg_205_1:RecordAudio("1101905049", var_208_27)
						arg_205_1:RecordAudio("1101905049", var_208_27)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905049", "story_v_side_new_1101905.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905049", "story_v_side_new_1101905.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_28 = var_208_19 + 0.3
			local var_208_29 = math.max(var_208_20, arg_205_1.talkMaxDuration)

			if var_208_19 + 0.3 <= arg_205_1.time_ and arg_205_1.time_ < var_208_28 + var_208_29 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_28) / var_208_29

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_28 + var_208_29 and arg_205_1.time_ < var_208_28 + var_208_29 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play1101905050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 1101905050
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play1101905051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(arg_211_1.actors_["1019ui_story"]) and arg_211_1.var_.characterEffect1019ui_story == nil then
				arg_211_1.var_.characterEffect1019ui_story = arg_211_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_0 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 and not isNil(arg_211_1.actors_["1019ui_story"]) then
				if arg_211_1.var_.characterEffect1019ui_story and not isNil(arg_211_1.actors_["1019ui_story"]) then
					arg_211_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_211_1.time_ - 0) / var_214_0)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 and not isNil(arg_211_1.actors_["1019ui_story"]) and arg_211_1.var_.characterEffect1019ui_story then
				arg_211_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_214_1 = 0
			local var_214_2 = 0.125

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_3 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(1101905050).content)

				arg_211_1.text_.text = var_214_3

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_5 = 5 <= 0 and var_214_2 or var_214_2 * (utf8.len(var_214_3) / 5)

				if (5 <= 0 and var_214_2 or var_214_2 * (utf8.len(var_214_3) / 5)) > 0 and var_214_2 < var_214_5 then
					arg_211_1.talkMaxDuration = var_214_5

					if var_214_5 + var_214_1 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_5 + var_214_1
					end
				end

				arg_211_1.text_.text = var_214_3
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_6 = math.max(var_214_2, arg_211_1.talkMaxDuration)

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_6 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_1) / var_214_6

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_1 + var_214_6 and arg_211_1.time_ < var_214_1 + var_214_6 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play1101905051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 1101905051
		arg_215_1.duration_ = 13.8

		local var_215_0 = {
			zh = 7.133,
			ja = 13.8
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
				arg_215_0:Play1101905052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0.975

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_1 = arg_215_1:GetWordFromCfg(1101905051)
				local var_218_2 = arg_215_1:FormatText(var_218_1.content)

				arg_215_1.text_.text = var_218_2

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_4 = 39 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 39)

				if (39 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 39)) > 0 and var_218_0 < var_218_4 then
					arg_215_1.talkMaxDuration = var_218_4

					if var_218_4 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_4 + 0
					end
				end

				arg_215_1.text_.text = var_218_2
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905051", "story_v_side_new_1101905.awb") ~= 0 then
					local var_218_5 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905051", "story_v_side_new_1101905.awb") / 1000

					if var_218_5 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + 0
					end

					if var_218_1.prefab_name ~= "" and arg_215_1.actors_[var_218_1.prefab_name] ~= nil then
						local var_218_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_1.prefab_name].transform, "story_v_side_new_1101905", "1101905051", "story_v_side_new_1101905.awb")

						arg_215_1:RecordAudio("1101905051", var_218_6)
						arg_215_1:RecordAudio("1101905051", var_218_6)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905051", "story_v_side_new_1101905.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905051", "story_v_side_new_1101905.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_7 = math.max(var_218_0, arg_215_1.talkMaxDuration)

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_7 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - 0) / var_218_7

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= 0 + var_218_7 and arg_215_1.time_ < 0 + var_218_7 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play1101905052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 1101905052
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play1101905053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0.25

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_1 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(1101905052).content)

				arg_219_1.text_.text = var_222_1

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_3 = 10 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_1) / 10)

				if (10 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_1) / 10)) > 0 and var_222_0 < var_222_3 then
					arg_219_1.talkMaxDuration = var_222_3

					if var_222_3 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_3 + 0
					end
				end

				arg_219_1.text_.text = var_222_1
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_4 = math.max(var_222_0, arg_219_1.talkMaxDuration)

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_4 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - 0) / var_222_4

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= 0 + var_222_4 and arg_219_1.time_ < 0 + var_222_4 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play1101905053 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 1101905053
		arg_223_1.duration_ = 7

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play1101905054(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 2 < arg_223_1.time_ and arg_223_1.time_ <= 2 + arg_226_0 then
				local var_226_0 = arg_223_1.bgs_.A00

				arg_223_1.bgs_.A00.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_226_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_226_1 = var_226_0:GetComponent("SpriteRenderer")

				if var_226_1 and var_226_1.sprite then
					local var_226_2 = 2 * (var_226_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_226_0.transform.localScale = Vector3.New(var_226_2 / var_226_1.sprite.bounds.size.y < var_226_2 * manager.ui.mainCameraCom_.aspect / var_226_1.sprite.bounds.size.x and var_226_2 * manager.ui.mainCameraCom_.aspect / var_226_1.sprite.bounds.size.x or var_226_2 / var_226_1.sprite.bounds.size.y, var_226_2 / var_226_1.sprite.bounds.size.y < var_226_2 * manager.ui.mainCameraCom_.aspect / var_226_1.sprite.bounds.size.x and var_226_2 * manager.ui.mainCameraCom_.aspect / var_226_1.sprite.bounds.size.x or var_226_2 / var_226_1.sprite.bounds.size.y, 0)
				end

				for iter_226_0, iter_226_1 in pairs(arg_223_1.bgs_) do
					if iter_226_0 ~= "A00" then
						iter_226_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_226_3 = 0

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_3 + arg_226_0 then
				arg_223_1.mask_.enabled = true
				arg_223_1.mask_.raycastTarget = true

				arg_223_1:SetGaussion(false)
			end

			local var_226_4 = 2

			if var_226_3 <= arg_223_1.time_ and arg_223_1.time_ < var_226_3 + var_226_4 then
				local var_226_5 = Color.New(0, 0, 0)

				var_226_5.a = Mathf.Lerp(0, 1, (arg_223_1.time_ - var_226_3) / var_226_4)
				arg_223_1.mask_.color = var_226_5
			end

			if arg_223_1.time_ >= var_226_3 + var_226_4 and arg_223_1.time_ < var_226_3 + var_226_4 + arg_226_0 then
				local var_226_6 = Color.New(0, 0, 0)

				var_226_6.a = 1
				arg_223_1.mask_.color = var_226_6
			end

			local var_226_7 = 2

			if 2 < arg_223_1.time_ and arg_223_1.time_ <= var_226_7 + arg_226_0 then
				arg_223_1.mask_.enabled = true
				arg_223_1.mask_.raycastTarget = true

				arg_223_1:SetGaussion(false)
			end

			local var_226_8 = 2

			if var_226_7 <= arg_223_1.time_ and arg_223_1.time_ < var_226_7 + var_226_8 then
				local var_226_9 = Color.New(0, 0, 0)

				var_226_9.a = Mathf.Lerp(1, 0, (arg_223_1.time_ - var_226_7) / var_226_8)
				arg_223_1.mask_.color = var_226_9
			end

			if arg_223_1.time_ >= var_226_7 + var_226_8 and arg_223_1.time_ < var_226_7 + var_226_8 + arg_226_0 then
				local var_226_10 = Color.New(0, 0, 0)

				arg_223_1.mask_.enabled = false
				var_226_10.a = 0
				arg_223_1.mask_.color = var_226_10
			end

			local var_226_11 = arg_223_1.actors_["1019ui_story"]

			if 2 < arg_223_1.time_ and arg_223_1.time_ <= 2 + arg_226_0 and not isNil(var_226_11) and arg_223_1.var_.characterEffect1019ui_story == nil then
				arg_223_1.var_.characterEffect1019ui_story = var_226_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_12 = 0.200000002980232

			if 2 <= arg_223_1.time_ and arg_223_1.time_ < 2 + var_226_12 and not isNil(var_226_11) then
				if arg_223_1.var_.characterEffect1019ui_story and not isNil(var_226_11) then
					arg_223_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 2 + var_226_12 and arg_223_1.time_ < 2 + var_226_12 + arg_226_0 and not isNil(var_226_11) and arg_223_1.var_.characterEffect1019ui_story then
				arg_223_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 2 < arg_223_1.time_ and arg_223_1.time_ <= 2 + arg_226_0 then
				arg_223_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			if 2 < arg_223_1.time_ and arg_223_1.time_ <= 2 + arg_226_0 then
				arg_223_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_226_14 = arg_223_1.actors_["1019ui_story"].transform

			if 2 < arg_223_1.time_ and arg_223_1.time_ <= 2 + arg_226_0 then
				arg_223_1.var_.moveOldPos1019ui_story = var_226_14.localPosition
			end

			local var_226_15 = 0.001

			if 2 <= arg_223_1.time_ and arg_223_1.time_ < 2 + var_226_15 then
				var_226_14.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_223_1.time_ - 2) / var_226_15)
				var_226_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_14.position).x, (manager.ui.mainCamera.transform.position - var_226_14.position).y, (manager.ui.mainCamera.transform.position - var_226_14.position).z)
				var_226_14.localEulerAngles.z = 0
				var_226_14.localEulerAngles.x = 0
				var_226_14.localEulerAngles = var_226_14.localEulerAngles
			end

			if arg_223_1.time_ >= 2 + var_226_15 and arg_223_1.time_ < 2 + var_226_15 + arg_226_0 then
				var_226_14.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_226_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_14.position).x, (manager.ui.mainCamera.transform.position - var_226_14.position).y, (manager.ui.mainCamera.transform.position - var_226_14.position).z)
				var_226_14.localEulerAngles.z = 0
				var_226_14.localEulerAngles.x = 0
				var_226_14.localEulerAngles = var_226_14.localEulerAngles
			end

			local var_226_16 = 2

			arg_223_1.isInRecall_ = false

			if var_226_16 < arg_223_1.time_ and arg_223_1.time_ <= var_226_16 + arg_226_0 then
				arg_223_1.screenFilterGo_:SetActive(false)

				for iter_226_2, iter_226_3 in pairs(arg_223_1.actors_) do
					for iter_226_4, iter_226_5 in ipairs((iter_226_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_226_5.color = iter_226_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_226_17 = 0.2

			if var_226_16 <= arg_223_1.time_ and arg_223_1.time_ < var_226_16 + var_226_17 then
				arg_223_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_223_1.time_ - var_226_16) / var_226_17)
			end

			if arg_223_1.time_ >= var_226_16 + var_226_17 and arg_223_1.time_ < var_226_16 + var_226_17 + arg_226_0 then
				arg_223_1.screenFilterEffect_.weight = 0
			end

			if arg_223_1.frameCnt_ <= 1 then
				arg_223_1.dialog_:SetActive(false)
			end

			local var_226_18 = 2
			local var_226_19 = 0.825

			if 2 < arg_223_1.time_ and arg_223_1.time_ <= var_226_18 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0

				arg_223_1.dialog_:SetActive(true)

				arg_223_1.dialogCg_.alpha = 0

				local var_226_20 = LeanTween.value(arg_223_1.dialog_, 0, 1, 0.3)

				var_226_20:setOnUpdate(LuaHelper.FloatAction(function(arg_227_0)
					arg_223_1.dialogCg_.alpha = arg_227_0
				end))
				var_226_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_223_1.dialog_)
					var_226_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_223_1.duration_ = arg_223_1.duration_ + 0.3

				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_21 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(1101905053).content)

				arg_223_1.text_.text = var_226_21

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_23 = 33 <= 0 and var_226_19 or var_226_19 * (utf8.len(var_226_21) / 33)

				if (33 <= 0 and var_226_19 or var_226_19 * (utf8.len(var_226_21) / 33)) > 0 and var_226_19 < var_226_23 then
					arg_223_1.talkMaxDuration = var_226_23
					var_226_18 = var_226_18 + 0.3

					if var_226_23 + var_226_18 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_23 + var_226_18
					end
				end

				arg_223_1.text_.text = var_226_21
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_24 = var_226_18 + 0.3
			local var_226_25 = math.max(var_226_19, arg_223_1.talkMaxDuration)

			if var_226_18 + 0.3 <= arg_223_1.time_ and arg_223_1.time_ < var_226_24 + var_226_25 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_24) / var_226_25

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_24 + var_226_25 and arg_223_1.time_ < var_226_24 + var_226_25 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play1101905054 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1101905054
		arg_229_1.duration_ = 5.83

		local var_229_0 = {
			zh = 3.9,
			ja = 5.833
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play1101905055(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0.5

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_1 = arg_229_1:GetWordFromCfg(1101905054)
				local var_232_2 = arg_229_1:FormatText(var_232_1.content)

				arg_229_1.text_.text = var_232_2

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_4 = 20 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 20)

				if (20 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 20)) > 0 and var_232_0 < var_232_4 then
					arg_229_1.talkMaxDuration = var_232_4

					if var_232_4 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_4 + 0
					end
				end

				arg_229_1.text_.text = var_232_2
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905054", "story_v_side_new_1101905.awb") ~= 0 then
					local var_232_5 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905054", "story_v_side_new_1101905.awb") / 1000

					if var_232_5 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + 0
					end

					if var_232_1.prefab_name ~= "" and arg_229_1.actors_[var_232_1.prefab_name] ~= nil then
						local var_232_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_1.prefab_name].transform, "story_v_side_new_1101905", "1101905054", "story_v_side_new_1101905.awb")

						arg_229_1:RecordAudio("1101905054", var_232_6)
						arg_229_1:RecordAudio("1101905054", var_232_6)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905054", "story_v_side_new_1101905.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905054", "story_v_side_new_1101905.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_7 = math.max(var_232_0, arg_229_1.talkMaxDuration)

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_7 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - 0) / var_232_7

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= 0 + var_232_7 and arg_229_1.time_ < 0 + var_232_7 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play1101905055 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1101905055
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play1101905056(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(arg_233_1.actors_["1019ui_story"]) and arg_233_1.var_.characterEffect1019ui_story == nil then
				arg_233_1.var_.characterEffect1019ui_story = arg_233_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_0 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 and not isNil(arg_233_1.actors_["1019ui_story"]) then
				if arg_233_1.var_.characterEffect1019ui_story and not isNil(arg_233_1.actors_["1019ui_story"]) then
					arg_233_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_0)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 and not isNil(arg_233_1.actors_["1019ui_story"]) and arg_233_1.var_.characterEffect1019ui_story then
				arg_233_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_236_1 = 0
			local var_236_2 = 0.125

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[7].name)

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

				local var_236_3 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(1101905055).content)

				arg_233_1.text_.text = var_236_3

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_5 = 5 <= 0 and var_236_2 or var_236_2 * (utf8.len(var_236_3) / 5)

				if (5 <= 0 and var_236_2 or var_236_2 * (utf8.len(var_236_3) / 5)) > 0 and var_236_2 < var_236_5 then
					arg_233_1.talkMaxDuration = var_236_5

					if var_236_5 + var_236_1 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_5 + var_236_1
					end
				end

				arg_233_1.text_.text = var_236_3
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_6 = math.max(var_236_2, arg_233_1.talkMaxDuration)

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_6 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_1) / var_236_6

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_1 + var_236_6 and arg_233_1.time_ < var_236_1 + var_236_6 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play1101905056 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1101905056
		arg_237_1.duration_ = 12.4

		local var_237_0 = {
			zh = 9.4,
			ja = 12.4
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play1101905057(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(arg_237_1.actors_["1019ui_story"]) and arg_237_1.var_.characterEffect1019ui_story == nil then
				arg_237_1.var_.characterEffect1019ui_story = arg_237_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_0 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 and not isNil(arg_237_1.actors_["1019ui_story"]) then
				if arg_237_1.var_.characterEffect1019ui_story and not isNil(arg_237_1.actors_["1019ui_story"]) then
					arg_237_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 and not isNil(arg_237_1.actors_["1019ui_story"]) and arg_237_1.var_.characterEffect1019ui_story then
				arg_237_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_240_2 = 0
			local var_240_3 = 1.075

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_2 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_4 = arg_237_1:GetWordFromCfg(1101905056)
				local var_240_5 = arg_237_1:FormatText(var_240_4.content)

				arg_237_1.text_.text = var_240_5

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_7 = 43 <= 0 and var_240_3 or var_240_3 * (utf8.len(var_240_5) / 43)

				if (43 <= 0 and var_240_3 or var_240_3 * (utf8.len(var_240_5) / 43)) > 0 and var_240_3 < var_240_7 then
					arg_237_1.talkMaxDuration = var_240_7

					if var_240_7 + var_240_2 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_7 + var_240_2
					end
				end

				arg_237_1.text_.text = var_240_5
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905056", "story_v_side_new_1101905.awb") ~= 0 then
					local var_240_8 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905056", "story_v_side_new_1101905.awb") / 1000

					if var_240_8 + var_240_2 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_8 + var_240_2
					end

					if var_240_4.prefab_name ~= "" and arg_237_1.actors_[var_240_4.prefab_name] ~= nil then
						local var_240_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_4.prefab_name].transform, "story_v_side_new_1101905", "1101905056", "story_v_side_new_1101905.awb")

						arg_237_1:RecordAudio("1101905056", var_240_9)
						arg_237_1:RecordAudio("1101905056", var_240_9)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905056", "story_v_side_new_1101905.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905056", "story_v_side_new_1101905.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_10 = math.max(var_240_3, arg_237_1.talkMaxDuration)

			if var_240_2 <= arg_237_1.time_ and arg_237_1.time_ < var_240_2 + var_240_10 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_2) / var_240_10

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_2 + var_240_10 and arg_237_1.time_ < var_240_2 + var_240_10 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play1101905057 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 1101905057
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play1101905058(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(arg_241_1.actors_["1019ui_story"]) and arg_241_1.var_.characterEffect1019ui_story == nil then
				arg_241_1.var_.characterEffect1019ui_story = arg_241_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_0 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 and not isNil(arg_241_1.actors_["1019ui_story"]) then
				if arg_241_1.var_.characterEffect1019ui_story and not isNil(arg_241_1.actors_["1019ui_story"]) then
					arg_241_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_241_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_241_1.time_ - 0) / var_244_0)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 and not isNil(arg_241_1.actors_["1019ui_story"]) and arg_241_1.var_.characterEffect1019ui_story then
				arg_241_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_241_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_244_1 = 0
			local var_244_2 = 0.65

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_3 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(1101905057).content)

				arg_241_1.text_.text = var_244_3

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_5 = 26 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_3) / 26)

				if (26 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_3) / 26)) > 0 and var_244_2 < var_244_5 then
					arg_241_1.talkMaxDuration = var_244_5

					if var_244_5 + var_244_1 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_5 + var_244_1
					end
				end

				arg_241_1.text_.text = var_244_3
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_6 = math.max(var_244_2, arg_241_1.talkMaxDuration)

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_6 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_1) / var_244_6

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_1 + var_244_6 and arg_241_1.time_ < var_244_1 + var_244_6 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play1101905058 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 1101905058
		arg_245_1.duration_ = 7.53

		local var_245_0 = {
			zh = 4.233,
			ja = 7.533
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play1101905059(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["1019ui_story"]) and arg_245_1.var_.characterEffect1019ui_story == nil then
				arg_245_1.var_.characterEffect1019ui_story = arg_245_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_0 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["1019ui_story"]) then
				if arg_245_1.var_.characterEffect1019ui_story and not isNil(arg_245_1.actors_["1019ui_story"]) then
					arg_245_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["1019ui_story"]) and arg_245_1.var_.characterEffect1019ui_story then
				arg_245_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_248_2 = 0
			local var_248_3 = 0.525

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_2 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_4 = arg_245_1:GetWordFromCfg(1101905058)
				local var_248_5 = arg_245_1:FormatText(var_248_4.content)

				arg_245_1.text_.text = var_248_5

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_7 = 21 <= 0 and var_248_3 or var_248_3 * (utf8.len(var_248_5) / 21)

				if (21 <= 0 and var_248_3 or var_248_3 * (utf8.len(var_248_5) / 21)) > 0 and var_248_3 < var_248_7 then
					arg_245_1.talkMaxDuration = var_248_7

					if var_248_7 + var_248_2 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_7 + var_248_2
					end
				end

				arg_245_1.text_.text = var_248_5
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905058", "story_v_side_new_1101905.awb") ~= 0 then
					local var_248_8 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905058", "story_v_side_new_1101905.awb") / 1000

					if var_248_8 + var_248_2 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_8 + var_248_2
					end

					if var_248_4.prefab_name ~= "" and arg_245_1.actors_[var_248_4.prefab_name] ~= nil then
						local var_248_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_4.prefab_name].transform, "story_v_side_new_1101905", "1101905058", "story_v_side_new_1101905.awb")

						arg_245_1:RecordAudio("1101905058", var_248_9)
						arg_245_1:RecordAudio("1101905058", var_248_9)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905058", "story_v_side_new_1101905.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905058", "story_v_side_new_1101905.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_10 = math.max(var_248_3, arg_245_1.talkMaxDuration)

			if var_248_2 <= arg_245_1.time_ and arg_245_1.time_ < var_248_2 + var_248_10 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_2) / var_248_10

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_2 + var_248_10 and arg_245_1.time_ < var_248_2 + var_248_10 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play1101905059 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 1101905059
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play1101905060(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["1019ui_story"]) and arg_249_1.var_.characterEffect1019ui_story == nil then
				arg_249_1.var_.characterEffect1019ui_story = arg_249_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_0 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["1019ui_story"]) then
				if arg_249_1.var_.characterEffect1019ui_story and not isNil(arg_249_1.actors_["1019ui_story"]) then
					arg_249_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_249_1.time_ - 0) / var_252_0)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["1019ui_story"]) and arg_249_1.var_.characterEffect1019ui_story then
				arg_249_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_252_1 = 0
			local var_252_2 = 0.075

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_3 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(1101905059).content)

				arg_249_1.text_.text = var_252_3

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_5 = 3 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_3) / 3)

				if (3 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_3) / 3)) > 0 and var_252_2 < var_252_5 then
					arg_249_1.talkMaxDuration = var_252_5

					if var_252_5 + var_252_1 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_5 + var_252_1
					end
				end

				arg_249_1.text_.text = var_252_3
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_6 = math.max(var_252_2, arg_249_1.talkMaxDuration)

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_6 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_1) / var_252_6

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_1 + var_252_6 and arg_249_1.time_ < var_252_1 + var_252_6 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play1101905060 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 1101905060
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play1101905061(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0.925

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_1 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(1101905060).content)

				arg_253_1.text_.text = var_256_1

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_3 = 37 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 37)

				if (37 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 37)) > 0 and var_256_0 < var_256_3 then
					arg_253_1.talkMaxDuration = var_256_3

					if var_256_3 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_3 + 0
					end
				end

				arg_253_1.text_.text = var_256_1
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_4 = math.max(var_256_0, arg_253_1.talkMaxDuration)

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_4 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - 0) / var_256_4

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= 0 + var_256_4 and arg_253_1.time_ < 0 + var_256_4 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play1101905061 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 1101905061
		arg_257_1.duration_ = 8.47

		local var_257_0 = {
			zh = 8.466,
			ja = 7.666
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play1101905062(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1019ui_story = arg_257_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_260_0 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 then
				arg_257_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_257_1.time_ - 0) / var_260_0)
				arg_257_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1019ui_story"].transform.position).z)
				arg_257_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1019ui_story"].transform.localEulerAngles = arg_257_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 then
				arg_257_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_257_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1019ui_story"].transform.position).z)
				arg_257_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1019ui_story"].transform.localEulerAngles = arg_257_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_260_1 = arg_257_1.actors_["1019ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_1) and arg_257_1.var_.characterEffect1019ui_story == nil then
				arg_257_1.var_.characterEffect1019ui_story = var_260_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_2 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_2 and not isNil(var_260_1) then
				if arg_257_1.var_.characterEffect1019ui_story and not isNil(var_260_1) then
					arg_257_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= 0 + var_260_2 and arg_257_1.time_ < 0 + var_260_2 + arg_260_0 and not isNil(var_260_1) and arg_257_1.var_.characterEffect1019ui_story then
				arg_257_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_2")
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_260_4 = 0
			local var_260_5 = 0.825

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_4 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_6 = arg_257_1:GetWordFromCfg(1101905061)
				local var_260_7 = arg_257_1:FormatText(var_260_6.content)

				arg_257_1.text_.text = var_260_7

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_9 = 33 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_7) / 33)

				if (33 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_7) / 33)) > 0 and var_260_5 < var_260_9 then
					arg_257_1.talkMaxDuration = var_260_9

					if var_260_9 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_9 + var_260_4
					end
				end

				arg_257_1.text_.text = var_260_7
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905061", "story_v_side_new_1101905.awb") ~= 0 then
					local var_260_10 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905061", "story_v_side_new_1101905.awb") / 1000

					if var_260_10 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_10 + var_260_4
					end

					if var_260_6.prefab_name ~= "" and arg_257_1.actors_[var_260_6.prefab_name] ~= nil then
						local var_260_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_6.prefab_name].transform, "story_v_side_new_1101905", "1101905061", "story_v_side_new_1101905.awb")

						arg_257_1:RecordAudio("1101905061", var_260_11)
						arg_257_1:RecordAudio("1101905061", var_260_11)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905061", "story_v_side_new_1101905.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905061", "story_v_side_new_1101905.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_12 = math.max(var_260_5, arg_257_1.talkMaxDuration)

			if var_260_4 <= arg_257_1.time_ and arg_257_1.time_ < var_260_4 + var_260_12 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_4) / var_260_12

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_4 + var_260_12 and arg_257_1.time_ < var_260_4 + var_260_12 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play1101905062 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 1101905062
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play1101905063(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(arg_261_1.actors_["1019ui_story"]) and arg_261_1.var_.characterEffect1019ui_story == nil then
				arg_261_1.var_.characterEffect1019ui_story = arg_261_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_0 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 and not isNil(arg_261_1.actors_["1019ui_story"]) then
				if arg_261_1.var_.characterEffect1019ui_story and not isNil(arg_261_1.actors_["1019ui_story"]) then
					arg_261_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_261_1.time_ - 0) / var_264_0)
				end
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 and not isNil(arg_261_1.actors_["1019ui_story"]) and arg_261_1.var_.characterEffect1019ui_story then
				arg_261_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_264_1 = 0
			local var_264_2 = 0.55

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_3 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(1101905062).content)

				arg_261_1.text_.text = var_264_3

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 22 <= 0 and var_264_2 or var_264_2 * (utf8.len(var_264_3) / 22)

				if (22 <= 0 and var_264_2 or var_264_2 * (utf8.len(var_264_3) / 22)) > 0 and var_264_2 < var_264_5 then
					arg_261_1.talkMaxDuration = var_264_5

					if var_264_5 + var_264_1 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_5 + var_264_1
					end
				end

				arg_261_1.text_.text = var_264_3
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_6 = math.max(var_264_2, arg_261_1.talkMaxDuration)

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_6 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_1) / var_264_6

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_1 + var_264_6 and arg_261_1.time_ < var_264_1 + var_264_6 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play1101905063 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 1101905063
		arg_265_1.duration_ = 3.47

		local var_265_0 = {
			zh = 1.533,
			ja = 3.466
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play1101905064(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(arg_265_1.actors_["1019ui_story"]) and arg_265_1.var_.characterEffect1019ui_story == nil then
				arg_265_1.var_.characterEffect1019ui_story = arg_265_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_0 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 and not isNil(arg_265_1.actors_["1019ui_story"]) then
				if arg_265_1.var_.characterEffect1019ui_story and not isNil(arg_265_1.actors_["1019ui_story"]) then
					arg_265_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 and not isNil(arg_265_1.actors_["1019ui_story"]) and arg_265_1.var_.characterEffect1019ui_story then
				arg_265_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_268_2 = 0
			local var_268_3 = 0.2

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_2 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_4 = arg_265_1:GetWordFromCfg(1101905063)
				local var_268_5 = arg_265_1:FormatText(var_268_4.content)

				arg_265_1.text_.text = var_268_5

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_7 = 8 <= 0 and var_268_3 or var_268_3 * (utf8.len(var_268_5) / 8)

				if (8 <= 0 and var_268_3 or var_268_3 * (utf8.len(var_268_5) / 8)) > 0 and var_268_3 < var_268_7 then
					arg_265_1.talkMaxDuration = var_268_7

					if var_268_7 + var_268_2 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_7 + var_268_2
					end
				end

				arg_265_1.text_.text = var_268_5
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905063", "story_v_side_new_1101905.awb") ~= 0 then
					local var_268_8 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905063", "story_v_side_new_1101905.awb") / 1000

					if var_268_8 + var_268_2 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_8 + var_268_2
					end

					if var_268_4.prefab_name ~= "" and arg_265_1.actors_[var_268_4.prefab_name] ~= nil then
						local var_268_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_4.prefab_name].transform, "story_v_side_new_1101905", "1101905063", "story_v_side_new_1101905.awb")

						arg_265_1:RecordAudio("1101905063", var_268_9)
						arg_265_1:RecordAudio("1101905063", var_268_9)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905063", "story_v_side_new_1101905.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905063", "story_v_side_new_1101905.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_10 = math.max(var_268_3, arg_265_1.talkMaxDuration)

			if var_268_2 <= arg_265_1.time_ and arg_265_1.time_ < var_268_2 + var_268_10 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_2) / var_268_10

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_2 + var_268_10 and arg_265_1.time_ < var_268_2 + var_268_10 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play1101905064 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 1101905064
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play1101905065(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(arg_269_1.actors_["1019ui_story"]) and arg_269_1.var_.characterEffect1019ui_story == nil then
				arg_269_1.var_.characterEffect1019ui_story = arg_269_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_0 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 and not isNil(arg_269_1.actors_["1019ui_story"]) then
				if arg_269_1.var_.characterEffect1019ui_story and not isNil(arg_269_1.actors_["1019ui_story"]) then
					arg_269_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_269_1.time_ - 0) / var_272_0)
				end
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 and not isNil(arg_269_1.actors_["1019ui_story"]) and arg_269_1.var_.characterEffect1019ui_story then
				arg_269_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_272_1 = 0
			local var_272_2 = 0.525

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, true)
				arg_269_1.iconController_:SetSelectedState("hero")

				arg_269_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_269_1.callingController_:SetSelectedState("normal")

				arg_269_1.keyicon_.color = Color.New(1, 1, 1)
				arg_269_1.icon_.color = Color.New(1, 1, 1)

				local var_272_3 = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(1101905064).content)

				arg_269_1.text_.text = var_272_3

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_5 = 21 <= 0 and var_272_2 or var_272_2 * (utf8.len(var_272_3) / 21)

				if (21 <= 0 and var_272_2 or var_272_2 * (utf8.len(var_272_3) / 21)) > 0 and var_272_2 < var_272_5 then
					arg_269_1.talkMaxDuration = var_272_5

					if var_272_5 + var_272_1 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_5 + var_272_1
					end
				end

				arg_269_1.text_.text = var_272_3
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_6 = math.max(var_272_2, arg_269_1.talkMaxDuration)

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_6 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_1) / var_272_6

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_1 + var_272_6 and arg_269_1.time_ < var_272_1 + var_272_6 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play1101905065 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 1101905065
		arg_273_1.duration_ = 4.97

		local var_273_0 = {
			zh = 3,
			ja = 4.966
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play1101905066(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos1019ui_story = arg_273_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_276_0 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 then
				arg_273_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_273_1.time_ - 0) / var_276_0)
				arg_273_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1019ui_story"].transform.position).z)
				arg_273_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1019ui_story"].transform.localEulerAngles = arg_273_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 then
				arg_273_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_273_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1019ui_story"].transform.position).z)
				arg_273_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1019ui_story"].transform.localEulerAngles = arg_273_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_276_1 = arg_273_1.actors_["1019ui_story"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect1019ui_story == nil then
				arg_273_1.var_.characterEffect1019ui_story = var_276_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_2 and not isNil(var_276_1) then
				if arg_273_1.var_.characterEffect1019ui_story and not isNil(var_276_1) then
					arg_273_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= 0 + var_276_2 and arg_273_1.time_ < 0 + var_276_2 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect1019ui_story then
				arg_273_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_276_4 = 0
			local var_276_5 = 0.275

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_4 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_6 = arg_273_1:GetWordFromCfg(1101905065)
				local var_276_7 = arg_273_1:FormatText(var_276_6.content)

				arg_273_1.text_.text = var_276_7

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_9 = 11 <= 0 and var_276_5 or var_276_5 * (utf8.len(var_276_7) / 11)

				if (11 <= 0 and var_276_5 or var_276_5 * (utf8.len(var_276_7) / 11)) > 0 and var_276_5 < var_276_9 then
					arg_273_1.talkMaxDuration = var_276_9

					if var_276_9 + var_276_4 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_9 + var_276_4
					end
				end

				arg_273_1.text_.text = var_276_7
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905065", "story_v_side_new_1101905.awb") ~= 0 then
					local var_276_10 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905065", "story_v_side_new_1101905.awb") / 1000

					if var_276_10 + var_276_4 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_10 + var_276_4
					end

					if var_276_6.prefab_name ~= "" and arg_273_1.actors_[var_276_6.prefab_name] ~= nil then
						local var_276_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_6.prefab_name].transform, "story_v_side_new_1101905", "1101905065", "story_v_side_new_1101905.awb")

						arg_273_1:RecordAudio("1101905065", var_276_11)
						arg_273_1:RecordAudio("1101905065", var_276_11)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905065", "story_v_side_new_1101905.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905065", "story_v_side_new_1101905.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_12 = math.max(var_276_5, arg_273_1.talkMaxDuration)

			if var_276_4 <= arg_273_1.time_ and arg_273_1.time_ < var_276_4 + var_276_12 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_4) / var_276_12

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_4 + var_276_12 and arg_273_1.time_ < var_276_4 + var_276_12 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
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
	Play1101905066 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 1101905066
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play1101905067(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(arg_277_1.actors_["1019ui_story"]) and arg_277_1.var_.characterEffect1019ui_story == nil then
				arg_277_1.var_.characterEffect1019ui_story = arg_277_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_0 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 and not isNil(arg_277_1.actors_["1019ui_story"]) then
				if arg_277_1.var_.characterEffect1019ui_story and not isNil(arg_277_1.actors_["1019ui_story"]) then
					arg_277_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_277_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_277_1.time_ - 0) / var_280_0)
				end
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 and not isNil(arg_277_1.actors_["1019ui_story"]) and arg_277_1.var_.characterEffect1019ui_story then
				arg_277_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_277_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_280_1 = 0
			local var_280_2 = 0.525

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, false)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_3 = arg_277_1:FormatText(arg_277_1:GetWordFromCfg(1101905066).content)

				arg_277_1.text_.text = var_280_3

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_5 = 21 <= 0 and var_280_2 or var_280_2 * (utf8.len(var_280_3) / 21)

				if (21 <= 0 and var_280_2 or var_280_2 * (utf8.len(var_280_3) / 21)) > 0 and var_280_2 < var_280_5 then
					arg_277_1.talkMaxDuration = var_280_5

					if var_280_5 + var_280_1 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_5 + var_280_1
					end
				end

				arg_277_1.text_.text = var_280_3
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_6 = math.max(var_280_2, arg_277_1.talkMaxDuration)

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_6 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_1) / var_280_6

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_1 + var_280_6 and arg_277_1.time_ < var_280_1 + var_280_6 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play1101905067 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 1101905067
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play1101905068(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0.975

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_1 = arg_281_1:FormatText(arg_281_1:GetWordFromCfg(1101905067).content)

				arg_281_1.text_.text = var_284_1

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_3 = 39 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_1) / 39)

				if (39 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_1) / 39)) > 0 and var_284_0 < var_284_3 then
					arg_281_1.talkMaxDuration = var_284_3

					if var_284_3 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_3 + 0
					end
				end

				arg_281_1.text_.text = var_284_1
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_4 = math.max(var_284_0, arg_281_1.talkMaxDuration)

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_4 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - 0) / var_284_4

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= 0 + var_284_4 and arg_281_1.time_ < 0 + var_284_4 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play1101905068 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 1101905068
		arg_285_1.duration_ = 11.93

		local var_285_0 = {
			zh = 7.566,
			ja = 11.933
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play1101905069(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["1019ui_story"]) and arg_285_1.var_.characterEffect1019ui_story == nil then
				arg_285_1.var_.characterEffect1019ui_story = arg_285_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_0 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["1019ui_story"]) then
				if arg_285_1.var_.characterEffect1019ui_story and not isNil(arg_285_1.actors_["1019ui_story"]) then
					arg_285_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["1019ui_story"]) and arg_285_1.var_.characterEffect1019ui_story then
				arg_285_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_288_2 = 0
			local var_288_3 = 0.925

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_2 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_4 = arg_285_1:GetWordFromCfg(1101905068)
				local var_288_5 = arg_285_1:FormatText(var_288_4.content)

				arg_285_1.text_.text = var_288_5

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_7 = 37 <= 0 and var_288_3 or var_288_3 * (utf8.len(var_288_5) / 37)

				if (37 <= 0 and var_288_3 or var_288_3 * (utf8.len(var_288_5) / 37)) > 0 and var_288_3 < var_288_7 then
					arg_285_1.talkMaxDuration = var_288_7

					if var_288_7 + var_288_2 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_7 + var_288_2
					end
				end

				arg_285_1.text_.text = var_288_5
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905068", "story_v_side_new_1101905.awb") ~= 0 then
					local var_288_8 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905068", "story_v_side_new_1101905.awb") / 1000

					if var_288_8 + var_288_2 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_8 + var_288_2
					end

					if var_288_4.prefab_name ~= "" and arg_285_1.actors_[var_288_4.prefab_name] ~= nil then
						local var_288_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_4.prefab_name].transform, "story_v_side_new_1101905", "1101905068", "story_v_side_new_1101905.awb")

						arg_285_1:RecordAudio("1101905068", var_288_9)
						arg_285_1:RecordAudio("1101905068", var_288_9)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905068", "story_v_side_new_1101905.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905068", "story_v_side_new_1101905.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_10 = math.max(var_288_3, arg_285_1.talkMaxDuration)

			if var_288_2 <= arg_285_1.time_ and arg_285_1.time_ < var_288_2 + var_288_10 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_2) / var_288_10

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_2 + var_288_10 and arg_285_1.time_ < var_288_2 + var_288_10 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play1101905069 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 1101905069
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play1101905070(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0.675

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(1, 1, 1)
				arg_289_1.icon_.color = Color.New(1, 1, 1)

				local var_292_1 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(1101905069).content)

				arg_289_1.text_.text = var_292_1

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_3 = 27 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 27)

				if (27 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 27)) > 0 and var_292_0 < var_292_3 then
					arg_289_1.talkMaxDuration = var_292_3

					if var_292_3 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_3 + 0
					end
				end

				arg_289_1.text_.text = var_292_1
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_4 = math.max(var_292_0, arg_289_1.talkMaxDuration)

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_4 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - 0) / var_292_4

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= 0 + var_292_4 and arg_289_1.time_ < 0 + var_292_4 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play1101905070 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 1101905070
		arg_293_1.duration_ = 2

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play1101905071(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(arg_293_1.actors_["1019ui_story"]) and arg_293_1.var_.characterEffect1019ui_story == nil then
				arg_293_1.var_.characterEffect1019ui_story = arg_293_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_0 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 and not isNil(arg_293_1.actors_["1019ui_story"]) then
				if arg_293_1.var_.characterEffect1019ui_story and not isNil(arg_293_1.actors_["1019ui_story"]) then
					arg_293_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 and not isNil(arg_293_1.actors_["1019ui_story"]) and arg_293_1.var_.characterEffect1019ui_story then
				arg_293_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_1")
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_296_2 = 0
			local var_296_3 = 0.15

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_2 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_4 = arg_293_1:GetWordFromCfg(1101905070)
				local var_296_5 = arg_293_1:FormatText(var_296_4.content)

				arg_293_1.text_.text = var_296_5

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_7 = 6 <= 0 and var_296_3 or var_296_3 * (utf8.len(var_296_5) / 6)

				if (6 <= 0 and var_296_3 or var_296_3 * (utf8.len(var_296_5) / 6)) > 0 and var_296_3 < var_296_7 then
					arg_293_1.talkMaxDuration = var_296_7

					if var_296_7 + var_296_2 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_7 + var_296_2
					end
				end

				arg_293_1.text_.text = var_296_5
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905070", "story_v_side_new_1101905.awb") ~= 0 then
					local var_296_8 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905070", "story_v_side_new_1101905.awb") / 1000

					if var_296_8 + var_296_2 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_8 + var_296_2
					end

					if var_296_4.prefab_name ~= "" and arg_293_1.actors_[var_296_4.prefab_name] ~= nil then
						local var_296_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_4.prefab_name].transform, "story_v_side_new_1101905", "1101905070", "story_v_side_new_1101905.awb")

						arg_293_1:RecordAudio("1101905070", var_296_9)
						arg_293_1:RecordAudio("1101905070", var_296_9)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905070", "story_v_side_new_1101905.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905070", "story_v_side_new_1101905.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_10 = math.max(var_296_3, arg_293_1.talkMaxDuration)

			if var_296_2 <= arg_293_1.time_ and arg_293_1.time_ < var_296_2 + var_296_10 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_2) / var_296_10

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_2 + var_296_10 and arg_293_1.time_ < var_296_2 + var_296_10 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play1101905071 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 1101905071
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play1101905072(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(arg_297_1.actors_["1019ui_story"]) and arg_297_1.var_.characterEffect1019ui_story == nil then
				arg_297_1.var_.characterEffect1019ui_story = arg_297_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_0 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 and not isNil(arg_297_1.actors_["1019ui_story"]) then
				if arg_297_1.var_.characterEffect1019ui_story and not isNil(arg_297_1.actors_["1019ui_story"]) then
					arg_297_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_297_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_297_1.time_ - 0) / var_300_0)
				end
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 and not isNil(arg_297_1.actors_["1019ui_story"]) and arg_297_1.var_.characterEffect1019ui_story then
				arg_297_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_297_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_300_1 = 0
			local var_300_2 = 0.05

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_3 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(1101905071).content)

				arg_297_1.text_.text = var_300_3

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_5 = 2 <= 0 and var_300_2 or var_300_2 * (utf8.len(var_300_3) / 2)

				if (2 <= 0 and var_300_2 or var_300_2 * (utf8.len(var_300_3) / 2)) > 0 and var_300_2 < var_300_5 then
					arg_297_1.talkMaxDuration = var_300_5

					if var_300_5 + var_300_1 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_5 + var_300_1
					end
				end

				arg_297_1.text_.text = var_300_3
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_6 = math.max(var_300_2, arg_297_1.talkMaxDuration)

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_6 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_1) / var_300_6

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_1 + var_300_6 and arg_297_1.time_ < var_300_1 + var_300_6 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play1101905072 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 1101905072
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play1101905073(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0.65

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_1 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(1101905072).content)

				arg_301_1.text_.text = var_304_1

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_3 = 26 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_1) / 26)

				if (26 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_1) / 26)) > 0 and var_304_0 < var_304_3 then
					arg_301_1.talkMaxDuration = var_304_3

					if var_304_3 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_3 + 0
					end
				end

				arg_301_1.text_.text = var_304_1
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_4 = math.max(var_304_0, arg_301_1.talkMaxDuration)

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_4 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - 0) / var_304_4

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= 0 + var_304_4 and arg_301_1.time_ < 0 + var_304_4 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play1101905073 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 1101905073
		arg_305_1.duration_ = 1

		SetActive(arg_305_1.tipsGo_, true)

		arg_305_1.tipsText_.text = StoryTipsCfg[101901].name

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"

			SetActive(arg_305_1.choicesGo_, true)

			for iter_306_0, iter_306_1 in ipairs(arg_305_1.choices_) do
				SetActive(iter_306_1.go, iter_306_0 <= 2)
			end

			arg_305_1.choices_[1].txt.text = arg_305_1:FormatText(StoryChoiceCfg[734].name)
			arg_305_1.choices_[2].txt.text = arg_305_1:FormatText(StoryChoiceCfg[735].name)
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				PlayerAction.UseStoryTrigger(1019012, 210190105, 1101905073, 1)
				arg_305_0:Play1101905074(arg_305_1)
			end

			if arg_307_0 == 2 then
				arg_305_0:Play1101905076(arg_305_1)
			end

			arg_305_1:RecordChoiceLog(1101905073, 734, 735)
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.allBtn_.enabled = false
			end

			if arg_305_1.time_ >= 0 + 0.5 and arg_305_1.time_ < 0 + 0.5 + arg_308_0 then
				arg_305_1.allBtn_.enabled = true
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play1101905074 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 1101905074
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play1101905075(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0.475

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, false)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_1 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(1101905074).content)

				arg_309_1.text_.text = var_312_1

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_3 = 19 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 19)

				if (19 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 19)) > 0 and var_312_0 < var_312_3 then
					arg_309_1.talkMaxDuration = var_312_3

					if var_312_3 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_3 + 0
					end
				end

				arg_309_1.text_.text = var_312_1
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_4 = math.max(var_312_0, arg_309_1.talkMaxDuration)

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_4 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - 0) / var_312_4

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= 0 + var_312_4 and arg_309_1.time_ < 0 + var_312_4 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play1101905075 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 1101905075
		arg_313_1.duration_ = 7.83

		local var_313_0 = {
			zh = 5.2,
			ja = 7.833
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
				arg_313_0:Play1101905077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1019ui_story = arg_313_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_316_0 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 then
				arg_313_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_313_1.time_ - 0) / var_316_0)
				arg_313_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1019ui_story"].transform.position).z)
				arg_313_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1019ui_story"].transform.localEulerAngles = arg_313_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 then
				arg_313_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_313_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1019ui_story"].transform.position).z)
				arg_313_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1019ui_story"].transform.localEulerAngles = arg_313_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_316_1 = arg_313_1.actors_["1019ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect1019ui_story == nil then
				arg_313_1.var_.characterEffect1019ui_story = var_316_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_2 and not isNil(var_316_1) then
				if arg_313_1.var_.characterEffect1019ui_story and not isNil(var_316_1) then
					arg_313_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= 0 + var_316_2 and arg_313_1.time_ < 0 + var_316_2 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect1019ui_story then
				arg_313_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_316_4 = 0
			local var_316_5 = 0.675

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_4 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_6 = arg_313_1:GetWordFromCfg(1101905075)
				local var_316_7 = arg_313_1:FormatText(var_316_6.content)

				arg_313_1.text_.text = var_316_7

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_9 = 27 <= 0 and var_316_5 or var_316_5 * (utf8.len(var_316_7) / 27)

				if (27 <= 0 and var_316_5 or var_316_5 * (utf8.len(var_316_7) / 27)) > 0 and var_316_5 < var_316_9 then
					arg_313_1.talkMaxDuration = var_316_9

					if var_316_9 + var_316_4 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_9 + var_316_4
					end
				end

				arg_313_1.text_.text = var_316_7
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905075", "story_v_side_new_1101905.awb") ~= 0 then
					local var_316_10 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905075", "story_v_side_new_1101905.awb") / 1000

					if var_316_10 + var_316_4 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_10 + var_316_4
					end

					if var_316_6.prefab_name ~= "" and arg_313_1.actors_[var_316_6.prefab_name] ~= nil then
						local var_316_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_6.prefab_name].transform, "story_v_side_new_1101905", "1101905075", "story_v_side_new_1101905.awb")

						arg_313_1:RecordAudio("1101905075", var_316_11)
						arg_313_1:RecordAudio("1101905075", var_316_11)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905075", "story_v_side_new_1101905.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905075", "story_v_side_new_1101905.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_12 = math.max(var_316_5, arg_313_1.talkMaxDuration)

			if var_316_4 <= arg_313_1.time_ and arg_313_1.time_ < var_316_4 + var_316_12 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_4) / var_316_12

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_4 + var_316_12 and arg_313_1.time_ < var_316_4 + var_316_12 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
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
	Play1101905077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 1101905077
		arg_317_1.duration_ = 12.57

		local var_317_0 = {
			zh = 9.633,
			ja = 12.566
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play1101905078(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_2")
			end

			local var_320_0 = arg_317_1.actors_["1019ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect1019ui_story == nil then
				arg_317_1.var_.characterEffect1019ui_story = var_320_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_1 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_1 and not isNil(var_320_0) then
				if arg_317_1.var_.characterEffect1019ui_story and not isNil(var_320_0) then
					arg_317_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= 0 + var_320_1 and arg_317_1.time_ < 0 + var_320_1 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect1019ui_story then
				arg_317_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_320_3 = 0
			local var_320_4 = 0.825

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_3 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_5 = arg_317_1:GetWordFromCfg(1101905077)
				local var_320_6 = arg_317_1:FormatText(var_320_5.content)

				arg_317_1.text_.text = var_320_6

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_8 = 44 <= 0 and var_320_4 or var_320_4 * (utf8.len(var_320_6) / 44)

				if (44 <= 0 and var_320_4 or var_320_4 * (utf8.len(var_320_6) / 44)) > 0 and var_320_4 < var_320_8 then
					arg_317_1.talkMaxDuration = var_320_8

					if var_320_8 + var_320_3 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_8 + var_320_3
					end
				end

				arg_317_1.text_.text = var_320_6
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905077", "story_v_side_new_1101905.awb") ~= 0 then
					local var_320_9 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905077", "story_v_side_new_1101905.awb") / 1000

					if var_320_9 + var_320_3 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_9 + var_320_3
					end

					if var_320_5.prefab_name ~= "" and arg_317_1.actors_[var_320_5.prefab_name] ~= nil then
						local var_320_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_5.prefab_name].transform, "story_v_side_new_1101905", "1101905077", "story_v_side_new_1101905.awb")

						arg_317_1:RecordAudio("1101905077", var_320_10)
						arg_317_1:RecordAudio("1101905077", var_320_10)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905077", "story_v_side_new_1101905.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905077", "story_v_side_new_1101905.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_11 = math.max(var_320_4, arg_317_1.talkMaxDuration)

			if var_320_3 <= arg_317_1.time_ and arg_317_1.time_ < var_320_3 + var_320_11 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_3) / var_320_11

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_3 + var_320_11 and arg_317_1.time_ < var_320_3 + var_320_11 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play1101905078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 1101905078
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play1101905079(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 1.1

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, true)
				arg_321_1.iconController_:SetSelectedState("hero")

				arg_321_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_321_1.callingController_:SetSelectedState("normal")

				arg_321_1.keyicon_.color = Color.New(1, 1, 1)
				arg_321_1.icon_.color = Color.New(1, 1, 1)

				local var_324_1 = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(1101905078).content)

				arg_321_1.text_.text = var_324_1

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_3 = 53 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_1) / 53)

				if (53 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_1) / 53)) > 0 and var_324_0 < var_324_3 then
					arg_321_1.talkMaxDuration = var_324_3

					if var_324_3 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_3 + 0
					end
				end

				arg_321_1.text_.text = var_324_1
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_4 = math.max(var_324_0, arg_321_1.talkMaxDuration)

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_4 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - 0) / var_324_4

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= 0 + var_324_4 and arg_321_1.time_ < 0 + var_324_4 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play1101905079 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 1101905079
		arg_325_1.duration_ = 7

		local var_325_0 = {
			zh = 3.833,
			ja = 7
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play1101905080(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(arg_325_1.actors_["1019ui_story"]) and arg_325_1.var_.characterEffect1019ui_story == nil then
				arg_325_1.var_.characterEffect1019ui_story = arg_325_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_0 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 and not isNil(arg_325_1.actors_["1019ui_story"]) then
				if arg_325_1.var_.characterEffect1019ui_story and not isNil(arg_325_1.actors_["1019ui_story"]) then
					arg_325_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 and not isNil(arg_325_1.actors_["1019ui_story"]) and arg_325_1.var_.characterEffect1019ui_story then
				arg_325_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_328_2 = 0
			local var_328_3 = 1.325

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_2 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_4 = arg_325_1:GetWordFromCfg(1101905079)
				local var_328_5 = arg_325_1:FormatText(var_328_4.content)

				arg_325_1.text_.text = var_328_5

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_7 = 19 <= 0 and var_328_3 or var_328_3 * (utf8.len(var_328_5) / 19)

				if (19 <= 0 and var_328_3 or var_328_3 * (utf8.len(var_328_5) / 19)) > 0 and var_328_3 < var_328_7 then
					arg_325_1.talkMaxDuration = var_328_7

					if var_328_7 + var_328_2 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_7 + var_328_2
					end
				end

				arg_325_1.text_.text = var_328_5
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905079", "story_v_side_new_1101905.awb") ~= 0 then
					local var_328_8 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905079", "story_v_side_new_1101905.awb") / 1000

					if var_328_8 + var_328_2 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_8 + var_328_2
					end

					if var_328_4.prefab_name ~= "" and arg_325_1.actors_[var_328_4.prefab_name] ~= nil then
						local var_328_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_4.prefab_name].transform, "story_v_side_new_1101905", "1101905079", "story_v_side_new_1101905.awb")

						arg_325_1:RecordAudio("1101905079", var_328_9)
						arg_325_1:RecordAudio("1101905079", var_328_9)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905079", "story_v_side_new_1101905.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905079", "story_v_side_new_1101905.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_10 = math.max(var_328_3, arg_325_1.talkMaxDuration)

			if var_328_2 <= arg_325_1.time_ and arg_325_1.time_ < var_328_2 + var_328_10 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_2) / var_328_10

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_2 + var_328_10 and arg_325_1.time_ < var_328_2 + var_328_10 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play1101905080 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 1101905080
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play1101905081(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(arg_329_1.actors_["1019ui_story"]) and arg_329_1.var_.characterEffect1019ui_story == nil then
				arg_329_1.var_.characterEffect1019ui_story = arg_329_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_0 = 0.200000002980232

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 and not isNil(arg_329_1.actors_["1019ui_story"]) then
				if arg_329_1.var_.characterEffect1019ui_story and not isNil(arg_329_1.actors_["1019ui_story"]) then
					arg_329_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_329_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_329_1.time_ - 0) / var_332_0)
				end
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 and not isNil(arg_329_1.actors_["1019ui_story"]) and arg_329_1.var_.characterEffect1019ui_story then
				arg_329_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_329_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_332_1 = 0
			local var_332_2 = 0.475

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, true)
				arg_329_1.iconController_:SetSelectedState("hero")

				arg_329_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_329_1.callingController_:SetSelectedState("normal")

				arg_329_1.keyicon_.color = Color.New(1, 1, 1)
				arg_329_1.icon_.color = Color.New(1, 1, 1)

				local var_332_3 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(1101905080).content)

				arg_329_1.text_.text = var_332_3

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_5 = 38 <= 0 and var_332_2 or var_332_2 * (utf8.len(var_332_3) / 38)

				if (38 <= 0 and var_332_2 or var_332_2 * (utf8.len(var_332_3) / 38)) > 0 and var_332_2 < var_332_5 then
					arg_329_1.talkMaxDuration = var_332_5

					if var_332_5 + var_332_1 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_5 + var_332_1
					end
				end

				arg_329_1.text_.text = var_332_3
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_6 = math.max(var_332_2, arg_329_1.talkMaxDuration)

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_6 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_1) / var_332_6

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_1 + var_332_6 and arg_329_1.time_ < var_332_1 + var_332_6 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play1101905081 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 1101905081
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play1101905082(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 0.95

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[7].name)

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

				local var_336_1 = arg_333_1:FormatText(arg_333_1:GetWordFromCfg(1101905081).content)

				arg_333_1.text_.text = var_336_1

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_3 = 14 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_1) / 14)

				if (14 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_1) / 14)) > 0 and var_336_0 < var_336_3 then
					arg_333_1.talkMaxDuration = var_336_3

					if var_336_3 + 0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_3 + 0
					end
				end

				arg_333_1.text_.text = var_336_1
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_4 = math.max(var_336_0, arg_333_1.talkMaxDuration)

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_4 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - 0) / var_336_4

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= 0 + var_336_4 and arg_333_1.time_ < 0 + var_336_4 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play1101905082 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 1101905082
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play1101905083(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0.35

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[7].name)

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

				local var_340_1 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(1101905082).content)

				arg_337_1.text_.text = var_340_1

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_3 = 13 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_1) / 13)

				if (13 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_1) / 13)) > 0 and var_340_0 < var_340_3 then
					arg_337_1.talkMaxDuration = var_340_3

					if var_340_3 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_3 + 0
					end
				end

				arg_337_1.text_.text = var_340_1
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_4 = math.max(var_340_0, arg_337_1.talkMaxDuration)

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_4 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - 0) / var_340_4

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= 0 + var_340_4 and arg_337_1.time_ < 0 + var_340_4 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play1101905083 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 1101905083
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play1101905084(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_344_0 = 0
			local var_344_1 = 0.325

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, false)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_2 = arg_341_1:FormatText(arg_341_1:GetWordFromCfg(1101905083).content)

				arg_341_1.text_.text = var_344_2

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_4 = 6 <= 0 and var_344_1 or var_344_1 * (utf8.len(var_344_2) / 6)

				if (6 <= 0 and var_344_1 or var_344_1 * (utf8.len(var_344_2) / 6)) > 0 and var_344_1 < var_344_4 then
					arg_341_1.talkMaxDuration = var_344_4

					if var_344_4 + var_344_0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_4 + var_344_0
					end
				end

				arg_341_1.text_.text = var_344_2
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_5 = math.max(var_344_1, arg_341_1.talkMaxDuration)

			if var_344_0 <= arg_341_1.time_ and arg_341_1.time_ < var_344_0 + var_344_5 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_0) / var_344_5

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_0 + var_344_5 and arg_341_1.time_ < var_344_0 + var_344_5 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play1101905084 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 1101905084
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play1101905085(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_348_0 = 0
			local var_348_1 = 0.15

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_0 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[7].name)

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

				local var_348_2 = arg_345_1:FormatText(arg_345_1:GetWordFromCfg(1101905084).content)

				arg_345_1.text_.text = var_348_2

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_4 = 19 <= 0 and var_348_1 or var_348_1 * (utf8.len(var_348_2) / 19)

				if (19 <= 0 and var_348_1 or var_348_1 * (utf8.len(var_348_2) / 19)) > 0 and var_348_1 < var_348_4 then
					arg_345_1.talkMaxDuration = var_348_4

					if var_348_4 + var_348_0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_4 + var_348_0
					end
				end

				arg_345_1.text_.text = var_348_2
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_5 = math.max(var_348_1, arg_345_1.talkMaxDuration)

			if var_348_0 <= arg_345_1.time_ and arg_345_1.time_ < var_348_0 + var_348_5 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_0) / var_348_5

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_0 + var_348_5 and arg_345_1.time_ < var_348_0 + var_348_5 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play1101905085 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 1101905085
		arg_349_1.duration_ = 7.4

		local var_349_0 = {
			zh = 2.766,
			ja = 7.4
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play1101905086(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPos1019ui_story = arg_349_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_352_0 = 0.001

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 then
				arg_349_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_349_1.time_ - 0) / var_352_0)
				arg_349_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1019ui_story"].transform.position).z)
				arg_349_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["1019ui_story"].transform.localEulerAngles = arg_349_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 then
				arg_349_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_349_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1019ui_story"].transform.position).z)
				arg_349_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["1019ui_story"].transform.localEulerAngles = arg_349_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_352_1 = arg_349_1.actors_["1019ui_story"]

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(var_352_1) and arg_349_1.var_.characterEffect1019ui_story == nil then
				arg_349_1.var_.characterEffect1019ui_story = var_352_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_2 = 0.200000002980232

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_2 and not isNil(var_352_1) then
				if arg_349_1.var_.characterEffect1019ui_story and not isNil(var_352_1) then
					arg_349_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= 0 + var_352_2 and arg_349_1.time_ < 0 + var_352_2 + arg_352_0 and not isNil(var_352_1) and arg_349_1.var_.characterEffect1019ui_story then
				arg_349_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_2")
			end

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_352_4 = 0
			local var_352_5 = 0.475

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_4 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_6 = arg_349_1:GetWordFromCfg(1101905085)
				local var_352_7 = arg_349_1:FormatText(var_352_6.content)

				arg_349_1.text_.text = var_352_7

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_9 = 12 <= 0 and var_352_5 or var_352_5 * (utf8.len(var_352_7) / 12)

				if (12 <= 0 and var_352_5 or var_352_5 * (utf8.len(var_352_7) / 12)) > 0 and var_352_5 < var_352_9 then
					arg_349_1.talkMaxDuration = var_352_9

					if var_352_9 + var_352_4 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_9 + var_352_4
					end
				end

				arg_349_1.text_.text = var_352_7
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905085", "story_v_side_new_1101905.awb") ~= 0 then
					local var_352_10 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905085", "story_v_side_new_1101905.awb") / 1000

					if var_352_10 + var_352_4 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_10 + var_352_4
					end

					if var_352_6.prefab_name ~= "" and arg_349_1.actors_[var_352_6.prefab_name] ~= nil then
						local var_352_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_6.prefab_name].transform, "story_v_side_new_1101905", "1101905085", "story_v_side_new_1101905.awb")

						arg_349_1:RecordAudio("1101905085", var_352_11)
						arg_349_1:RecordAudio("1101905085", var_352_11)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905085", "story_v_side_new_1101905.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905085", "story_v_side_new_1101905.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_12 = math.max(var_352_5, arg_349_1.talkMaxDuration)

			if var_352_4 <= arg_349_1.time_ and arg_349_1.time_ < var_352_4 + var_352_12 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_4) / var_352_12

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_4 + var_352_12 and arg_349_1.time_ < var_352_4 + var_352_12 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_349_1:InitPlayNodeList()
	end,
	Play1101905086 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 1101905086
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play1101905087(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(arg_353_1.actors_["1019ui_story"]) and arg_353_1.var_.characterEffect1019ui_story == nil then
				arg_353_1.var_.characterEffect1019ui_story = arg_353_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_0 = 0.200000002980232

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 and not isNil(arg_353_1.actors_["1019ui_story"]) then
				if arg_353_1.var_.characterEffect1019ui_story and not isNil(arg_353_1.actors_["1019ui_story"]) then
					arg_353_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_353_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_353_1.time_ - 0) / var_356_0)
				end
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 and not isNil(arg_353_1.actors_["1019ui_story"]) and arg_353_1.var_.characterEffect1019ui_story then
				arg_353_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_353_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_356_1 = 0
			local var_356_2 = 0.3

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, false)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_3 = arg_353_1:FormatText(arg_353_1:GetWordFromCfg(1101905086).content)

				arg_353_1.text_.text = var_356_3

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_5 = 37 <= 0 and var_356_2 or var_356_2 * (utf8.len(var_356_3) / 37)

				if (37 <= 0 and var_356_2 or var_356_2 * (utf8.len(var_356_3) / 37)) > 0 and var_356_2 < var_356_5 then
					arg_353_1.talkMaxDuration = var_356_5

					if var_356_5 + var_356_1 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_5 + var_356_1
					end
				end

				arg_353_1.text_.text = var_356_3
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_6 = math.max(var_356_2, arg_353_1.talkMaxDuration)

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_6 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_1) / var_356_6

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_1 + var_356_6 and arg_353_1.time_ < var_356_1 + var_356_6 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play1101905087 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 1101905087
		arg_357_1.duration_ = 9.37

		local var_357_0 = {
			zh = 3.7,
			ja = 9.366
		}
		local var_357_1 = manager.audio:GetLocalizationFlag()

		if var_357_0[var_357_1] ~= nil then
			arg_357_1.duration_ = var_357_0[var_357_1]
		end

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play1101905088(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(arg_357_1.actors_["1019ui_story"]) and arg_357_1.var_.characterEffect1019ui_story == nil then
				arg_357_1.var_.characterEffect1019ui_story = arg_357_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_0 = 0.200000002980232

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 and not isNil(arg_357_1.actors_["1019ui_story"]) then
				if arg_357_1.var_.characterEffect1019ui_story and not isNil(arg_357_1.actors_["1019ui_story"]) then
					arg_357_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 and not isNil(arg_357_1.actors_["1019ui_story"]) and arg_357_1.var_.characterEffect1019ui_story then
				arg_357_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			local var_360_2 = 0
			local var_360_3 = 0.925

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_2 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_4 = arg_357_1:GetWordFromCfg(1101905087)
				local var_360_5 = arg_357_1:FormatText(var_360_4.content)

				arg_357_1.text_.text = var_360_5

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_7 = 18 <= 0 and var_360_3 or var_360_3 * (utf8.len(var_360_5) / 18)

				if (18 <= 0 and var_360_3 or var_360_3 * (utf8.len(var_360_5) / 18)) > 0 and var_360_3 < var_360_7 then
					arg_357_1.talkMaxDuration = var_360_7

					if var_360_7 + var_360_2 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_7 + var_360_2
					end
				end

				arg_357_1.text_.text = var_360_5
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905087", "story_v_side_new_1101905.awb") ~= 0 then
					local var_360_8 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905087", "story_v_side_new_1101905.awb") / 1000

					if var_360_8 + var_360_2 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_8 + var_360_2
					end

					if var_360_4.prefab_name ~= "" and arg_357_1.actors_[var_360_4.prefab_name] ~= nil then
						local var_360_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_4.prefab_name].transform, "story_v_side_new_1101905", "1101905087", "story_v_side_new_1101905.awb")

						arg_357_1:RecordAudio("1101905087", var_360_9)
						arg_357_1:RecordAudio("1101905087", var_360_9)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905087", "story_v_side_new_1101905.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905087", "story_v_side_new_1101905.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_10 = math.max(var_360_3, arg_357_1.talkMaxDuration)

			if var_360_2 <= arg_357_1.time_ and arg_357_1.time_ < var_360_2 + var_360_10 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_2) / var_360_10

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_2 + var_360_10 and arg_357_1.time_ < var_360_2 + var_360_10 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play1101905088 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 1101905088
		arg_361_1.duration_ = 8.7

		local var_361_0 = {
			zh = 5.466,
			ja = 8.7
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
				arg_361_0:Play1101905089(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 0.45

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_1 = arg_361_1:GetWordFromCfg(1101905088)
				local var_364_2 = arg_361_1:FormatText(var_364_1.content)

				arg_361_1.text_.text = var_364_2

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_4 = 25 <= 0 and var_364_0 or var_364_0 * (utf8.len(var_364_2) / 25)

				if (25 <= 0 and var_364_0 or var_364_0 * (utf8.len(var_364_2) / 25)) > 0 and var_364_0 < var_364_4 then
					arg_361_1.talkMaxDuration = var_364_4

					if var_364_4 + 0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_4 + 0
					end
				end

				arg_361_1.text_.text = var_364_2
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905088", "story_v_side_new_1101905.awb") ~= 0 then
					local var_364_5 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905088", "story_v_side_new_1101905.awb") / 1000

					if var_364_5 + 0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_5 + 0
					end

					if var_364_1.prefab_name ~= "" and arg_361_1.actors_[var_364_1.prefab_name] ~= nil then
						local var_364_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_1.prefab_name].transform, "story_v_side_new_1101905", "1101905088", "story_v_side_new_1101905.awb")

						arg_361_1:RecordAudio("1101905088", var_364_6)
						arg_361_1:RecordAudio("1101905088", var_364_6)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905088", "story_v_side_new_1101905.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905088", "story_v_side_new_1101905.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_7 = math.max(var_364_0, arg_361_1.talkMaxDuration)

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_7 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - 0) / var_364_7

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= 0 + var_364_7 and arg_361_1.time_ < 0 + var_364_7 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play1101905089 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 1101905089
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play1101905090(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(arg_365_1.actors_["1019ui_story"]) and arg_365_1.var_.characterEffect1019ui_story == nil then
				arg_365_1.var_.characterEffect1019ui_story = arg_365_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_0 = 0.200000002980232

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_0 and not isNil(arg_365_1.actors_["1019ui_story"]) then
				if arg_365_1.var_.characterEffect1019ui_story and not isNil(arg_365_1.actors_["1019ui_story"]) then
					arg_365_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_365_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_365_1.time_ - 0) / var_368_0)
				end
			end

			if arg_365_1.time_ >= 0 + var_368_0 and arg_365_1.time_ < 0 + var_368_0 + arg_368_0 and not isNil(arg_365_1.actors_["1019ui_story"]) and arg_365_1.var_.characterEffect1019ui_story then
				arg_365_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_365_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_368_1 = 0
			local var_368_2 = 0.625

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_1 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, true)
				arg_365_1.iconController_:SetSelectedState("hero")

				arg_365_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_365_1.callingController_:SetSelectedState("normal")

				arg_365_1.keyicon_.color = Color.New(1, 1, 1)
				arg_365_1.icon_.color = Color.New(1, 1, 1)

				local var_368_3 = arg_365_1:FormatText(arg_365_1:GetWordFromCfg(1101905089).content)

				arg_365_1.text_.text = var_368_3

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_5 = 8 <= 0 and var_368_2 or var_368_2 * (utf8.len(var_368_3) / 8)

				if (8 <= 0 and var_368_2 or var_368_2 * (utf8.len(var_368_3) / 8)) > 0 and var_368_2 < var_368_5 then
					arg_365_1.talkMaxDuration = var_368_5

					if var_368_5 + var_368_1 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_5 + var_368_1
					end
				end

				arg_365_1.text_.text = var_368_3
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_6 = math.max(var_368_2, arg_365_1.talkMaxDuration)

			if var_368_1 <= arg_365_1.time_ and arg_365_1.time_ < var_368_1 + var_368_6 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_1) / var_368_6

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_1 + var_368_6 and arg_365_1.time_ < var_368_1 + var_368_6 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play1101905090 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 1101905090
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play1101905091(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = 0.2

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, false)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_1 = arg_369_1:FormatText(arg_369_1:GetWordFromCfg(1101905090).content)

				arg_369_1.text_.text = var_372_1

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_3 = 14 <= 0 and var_372_0 or var_372_0 * (utf8.len(var_372_1) / 14)

				if (14 <= 0 and var_372_0 or var_372_0 * (utf8.len(var_372_1) / 14)) > 0 and var_372_0 < var_372_3 then
					arg_369_1.talkMaxDuration = var_372_3

					if var_372_3 + 0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_3 + 0
					end
				end

				arg_369_1.text_.text = var_372_1
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_4 = math.max(var_372_0, arg_369_1.talkMaxDuration)

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_4 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - 0) / var_372_4

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= 0 + var_372_4 and arg_369_1.time_ < 0 + var_372_4 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play1101905091 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 1101905091
		arg_373_1.duration_ = 6.67

		local var_373_0 = {
			zh = 4.666,
			ja = 6.666
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
				arg_373_0:Play1101905092(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.var_.moveOldPos1019ui_story = arg_373_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_376_0 = 0.001

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 then
				arg_373_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_373_1.time_ - 0) / var_376_0)
				arg_373_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_373_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["1019ui_story"].transform.position).z)
				arg_373_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_373_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_373_1.actors_["1019ui_story"].transform.localEulerAngles = arg_373_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 then
				arg_373_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_373_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_373_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["1019ui_story"].transform.position).z)
				arg_373_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_373_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_373_1.actors_["1019ui_story"].transform.localEulerAngles = arg_373_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_376_1 = arg_373_1.actors_["1019ui_story"]

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(var_376_1) and arg_373_1.var_.characterEffect1019ui_story == nil then
				arg_373_1.var_.characterEffect1019ui_story = var_376_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_2 = 0.200000002980232

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_2 and not isNil(var_376_1) then
				if arg_373_1.var_.characterEffect1019ui_story and not isNil(var_376_1) then
					arg_373_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_373_1.time_ >= 0 + var_376_2 and arg_373_1.time_ < 0 + var_376_2 + arg_376_0 and not isNil(var_376_1) and arg_373_1.var_.characterEffect1019ui_story then
				arg_373_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_2")
			end

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_376_4 = 0
			local var_376_5 = 0.35

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_4 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_6 = arg_373_1:GetWordFromCfg(1101905091)
				local var_376_7 = arg_373_1:FormatText(var_376_6.content)

				arg_373_1.text_.text = var_376_7

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_9 = 20 <= 0 and var_376_5 or var_376_5 * (utf8.len(var_376_7) / 20)

				if (20 <= 0 and var_376_5 or var_376_5 * (utf8.len(var_376_7) / 20)) > 0 and var_376_5 < var_376_9 then
					arg_373_1.talkMaxDuration = var_376_9

					if var_376_9 + var_376_4 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_9 + var_376_4
					end
				end

				arg_373_1.text_.text = var_376_7
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905091", "story_v_side_new_1101905.awb") ~= 0 then
					local var_376_10 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905091", "story_v_side_new_1101905.awb") / 1000

					if var_376_10 + var_376_4 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_10 + var_376_4
					end

					if var_376_6.prefab_name ~= "" and arg_373_1.actors_[var_376_6.prefab_name] ~= nil then
						local var_376_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_6.prefab_name].transform, "story_v_side_new_1101905", "1101905091", "story_v_side_new_1101905.awb")

						arg_373_1:RecordAudio("1101905091", var_376_11)
						arg_373_1:RecordAudio("1101905091", var_376_11)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905091", "story_v_side_new_1101905.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905091", "story_v_side_new_1101905.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_12 = math.max(var_376_5, arg_373_1.talkMaxDuration)

			if var_376_4 <= arg_373_1.time_ and arg_373_1.time_ < var_376_4 + var_376_12 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_4) / var_376_12

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_4 + var_376_12 and arg_373_1.time_ < var_376_4 + var_376_12 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_373_1:InitPlayNodeList()
	end,
	Play1101905092 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 1101905092
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play1101905093(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(arg_377_1.actors_["1019ui_story"]) and arg_377_1.var_.characterEffect1019ui_story == nil then
				arg_377_1.var_.characterEffect1019ui_story = arg_377_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_0 = 0.200000002980232

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 and not isNil(arg_377_1.actors_["1019ui_story"]) then
				if arg_377_1.var_.characterEffect1019ui_story and not isNil(arg_377_1.actors_["1019ui_story"]) then
					arg_377_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_377_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_377_1.time_ - 0) / var_380_0)
				end
			end

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 and not isNil(arg_377_1.actors_["1019ui_story"]) and arg_377_1.var_.characterEffect1019ui_story then
				arg_377_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_377_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_380_1 = 0
			local var_380_2 = 0.5

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[7].name)

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

				local var_380_3 = arg_377_1:FormatText(arg_377_1:GetWordFromCfg(1101905092).content)

				arg_377_1.text_.text = var_380_3

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_5 = 23 <= 0 and var_380_2 or var_380_2 * (utf8.len(var_380_3) / 23)

				if (23 <= 0 and var_380_2 or var_380_2 * (utf8.len(var_380_3) / 23)) > 0 and var_380_2 < var_380_5 then
					arg_377_1.talkMaxDuration = var_380_5

					if var_380_5 + var_380_1 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_5 + var_380_1
					end
				end

				arg_377_1.text_.text = var_380_3
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_6 = math.max(var_380_2, arg_377_1.talkMaxDuration)

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_6 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_1) / var_380_6

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_1 + var_380_6 and arg_377_1.time_ < var_380_1 + var_380_6 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play1101905093 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 1101905093
		arg_381_1.duration_ = 2.8

		local var_381_0 = {
			zh = 1.1,
			ja = 2.8
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
				arg_381_0:Play1101905094(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(arg_381_1.actors_["1019ui_story"]) and arg_381_1.var_.characterEffect1019ui_story == nil then
				arg_381_1.var_.characterEffect1019ui_story = arg_381_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_0 = 0.200000002980232

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_0 and not isNil(arg_381_1.actors_["1019ui_story"]) then
				if arg_381_1.var_.characterEffect1019ui_story and not isNil(arg_381_1.actors_["1019ui_story"]) then
					arg_381_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_381_1.time_ >= 0 + var_384_0 and arg_381_1.time_ < 0 + var_384_0 + arg_384_0 and not isNil(arg_381_1.actors_["1019ui_story"]) and arg_381_1.var_.characterEffect1019ui_story then
				arg_381_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_384_2 = 0
			local var_384_3 = 0.575

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_2 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_4 = arg_381_1:GetWordFromCfg(1101905093)
				local var_384_5 = arg_381_1:FormatText(var_384_4.content)

				arg_381_1.text_.text = var_384_5

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_7 = 5 <= 0 and var_384_3 or var_384_3 * (utf8.len(var_384_5) / 5)

				if (5 <= 0 and var_384_3 or var_384_3 * (utf8.len(var_384_5) / 5)) > 0 and var_384_3 < var_384_7 then
					arg_381_1.talkMaxDuration = var_384_7

					if var_384_7 + var_384_2 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_7 + var_384_2
					end
				end

				arg_381_1.text_.text = var_384_5
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905093", "story_v_side_new_1101905.awb") ~= 0 then
					local var_384_8 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905093", "story_v_side_new_1101905.awb") / 1000

					if var_384_8 + var_384_2 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_8 + var_384_2
					end

					if var_384_4.prefab_name ~= "" and arg_381_1.actors_[var_384_4.prefab_name] ~= nil then
						local var_384_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_4.prefab_name].transform, "story_v_side_new_1101905", "1101905093", "story_v_side_new_1101905.awb")

						arg_381_1:RecordAudio("1101905093", var_384_9)
						arg_381_1:RecordAudio("1101905093", var_384_9)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905093", "story_v_side_new_1101905.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905093", "story_v_side_new_1101905.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_10 = math.max(var_384_3, arg_381_1.talkMaxDuration)

			if var_384_2 <= arg_381_1.time_ and arg_381_1.time_ < var_384_2 + var_384_10 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_2) / var_384_10

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_2 + var_384_10 and arg_381_1.time_ < var_384_2 + var_384_10 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play1101905094 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 1101905094
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play1101905095(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(arg_385_1.actors_["1019ui_story"]) and arg_385_1.var_.characterEffect1019ui_story == nil then
				arg_385_1.var_.characterEffect1019ui_story = arg_385_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_0 = 0.200000002980232

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_0 and not isNil(arg_385_1.actors_["1019ui_story"]) then
				if arg_385_1.var_.characterEffect1019ui_story and not isNil(arg_385_1.actors_["1019ui_story"]) then
					arg_385_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_385_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_385_1.time_ - 0) / var_388_0)
				end
			end

			if arg_385_1.time_ >= 0 + var_388_0 and arg_385_1.time_ < 0 + var_388_0 + arg_388_0 and not isNil(arg_385_1.actors_["1019ui_story"]) and arg_385_1.var_.characterEffect1019ui_story then
				arg_385_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_385_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_388_1 = 0
			local var_388_2 = 0.125

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[7].name)

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

				local var_388_3 = arg_385_1:FormatText(arg_385_1:GetWordFromCfg(1101905094).content)

				arg_385_1.text_.text = var_388_3

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_5 = 7 <= 0 and var_388_2 or var_388_2 * (utf8.len(var_388_3) / 7)

				if (7 <= 0 and var_388_2 or var_388_2 * (utf8.len(var_388_3) / 7)) > 0 and var_388_2 < var_388_5 then
					arg_385_1.talkMaxDuration = var_388_5

					if var_388_5 + var_388_1 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_5 + var_388_1
					end
				end

				arg_385_1.text_.text = var_388_3
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_6 = math.max(var_388_2, arg_385_1.talkMaxDuration)

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_6 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_1) / var_388_6

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_1 + var_388_6 and arg_385_1.time_ < var_388_1 + var_388_6 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play1101905095 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 1101905095
		arg_389_1.duration_ = 8.03

		local var_389_0 = {
			zh = 8.033,
			ja = 7.666
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
				arg_389_0:Play1101905096(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(arg_389_1.actors_["1019ui_story"]) and arg_389_1.var_.characterEffect1019ui_story == nil then
				arg_389_1.var_.characterEffect1019ui_story = arg_389_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_0 = 0.200000002980232

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 and not isNil(arg_389_1.actors_["1019ui_story"]) then
				if arg_389_1.var_.characterEffect1019ui_story and not isNil(arg_389_1.actors_["1019ui_story"]) then
					arg_389_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 and not isNil(arg_389_1.actors_["1019ui_story"]) and arg_389_1.var_.characterEffect1019ui_story then
				arg_389_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_392_2 = 0
			local var_392_3 = 0.175

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_2 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_4 = arg_389_1:GetWordFromCfg(1101905095)
				local var_392_5 = arg_389_1:FormatText(var_392_4.content)

				arg_389_1.text_.text = var_392_5

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_7 = 35 <= 0 and var_392_3 or var_392_3 * (utf8.len(var_392_5) / 35)

				if (35 <= 0 and var_392_3 or var_392_3 * (utf8.len(var_392_5) / 35)) > 0 and var_392_3 < var_392_7 then
					arg_389_1.talkMaxDuration = var_392_7

					if var_392_7 + var_392_2 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_7 + var_392_2
					end
				end

				arg_389_1.text_.text = var_392_5
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905095", "story_v_side_new_1101905.awb") ~= 0 then
					local var_392_8 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905095", "story_v_side_new_1101905.awb") / 1000

					if var_392_8 + var_392_2 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_8 + var_392_2
					end

					if var_392_4.prefab_name ~= "" and arg_389_1.actors_[var_392_4.prefab_name] ~= nil then
						local var_392_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_4.prefab_name].transform, "story_v_side_new_1101905", "1101905095", "story_v_side_new_1101905.awb")

						arg_389_1:RecordAudio("1101905095", var_392_9)
						arg_389_1:RecordAudio("1101905095", var_392_9)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905095", "story_v_side_new_1101905.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905095", "story_v_side_new_1101905.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_10 = math.max(var_392_3, arg_389_1.talkMaxDuration)

			if var_392_2 <= arg_389_1.time_ and arg_389_1.time_ < var_392_2 + var_392_10 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_2) / var_392_10

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_2 + var_392_10 and arg_389_1.time_ < var_392_2 + var_392_10 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play1101905096 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 1101905096
		arg_393_1.duration_ = 9

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play1101905097(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if arg_393_1.bgs_.ST28 == nil then
				local var_396_0 = Object.Instantiate(arg_393_1.paintGo_)

				var_396_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST28")
				var_396_0.name = "ST28"
				var_396_0.transform.parent = arg_393_1.stage_.transform
				var_396_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_393_1.bgs_.ST28 = var_396_0
			end

			if 2 < arg_393_1.time_ and arg_393_1.time_ <= 2 + arg_396_0 then
				local var_396_1 = arg_393_1.bgs_.ST28

				arg_393_1.bgs_.ST28.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_396_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_396_2 = var_396_1:GetComponent("SpriteRenderer")

				if var_396_2 and var_396_2.sprite then
					local var_396_3 = 2 * (var_396_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_396_1.transform.localScale = Vector3.New(var_396_3 / var_396_2.sprite.bounds.size.y < var_396_3 * manager.ui.mainCameraCom_.aspect / var_396_2.sprite.bounds.size.x and var_396_3 * manager.ui.mainCameraCom_.aspect / var_396_2.sprite.bounds.size.x or var_396_3 / var_396_2.sprite.bounds.size.y, var_396_3 / var_396_2.sprite.bounds.size.y < var_396_3 * manager.ui.mainCameraCom_.aspect / var_396_2.sprite.bounds.size.x and var_396_3 * manager.ui.mainCameraCom_.aspect / var_396_2.sprite.bounds.size.x or var_396_3 / var_396_2.sprite.bounds.size.y, 0)
				end

				for iter_396_0, iter_396_1 in pairs(arg_393_1.bgs_) do
					if iter_396_0 ~= "ST28" then
						iter_396_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_396_4 = 0

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_4 + arg_396_0 then
				arg_393_1.mask_.enabled = true
				arg_393_1.mask_.raycastTarget = true

				arg_393_1:SetGaussion(false)
			end

			local var_396_5 = 2

			if var_396_4 <= arg_393_1.time_ and arg_393_1.time_ < var_396_4 + var_396_5 then
				local var_396_6 = Color.New(0, 0, 0)

				var_396_6.a = Mathf.Lerp(0, 1, (arg_393_1.time_ - var_396_4) / var_396_5)
				arg_393_1.mask_.color = var_396_6
			end

			if arg_393_1.time_ >= var_396_4 + var_396_5 and arg_393_1.time_ < var_396_4 + var_396_5 + arg_396_0 then
				local var_396_7 = Color.New(0, 0, 0)

				var_396_7.a = 1
				arg_393_1.mask_.color = var_396_7
			end

			local var_396_8 = 2

			if 2 < arg_393_1.time_ and arg_393_1.time_ <= var_396_8 + arg_396_0 then
				arg_393_1.mask_.enabled = true
				arg_393_1.mask_.raycastTarget = true

				arg_393_1:SetGaussion(false)
			end

			local var_396_9 = 2

			if var_396_8 <= arg_393_1.time_ and arg_393_1.time_ < var_396_8 + var_396_9 then
				local var_396_10 = Color.New(0, 0, 0)

				var_396_10.a = Mathf.Lerp(1, 0, (arg_393_1.time_ - var_396_8) / var_396_9)
				arg_393_1.mask_.color = var_396_10
			end

			if arg_393_1.time_ >= var_396_8 + var_396_9 and arg_393_1.time_ < var_396_8 + var_396_9 + arg_396_0 then
				local var_396_11 = Color.New(0, 0, 0)

				arg_393_1.mask_.enabled = false
				var_396_11.a = 0
				arg_393_1.mask_.color = var_396_11
			end

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_396_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_393_1.bgmTxt_.text ~= var_396_14 and arg_393_1.bgmTxt_.text ~= "" then
						if arg_393_1.bgmTxt2_.text ~= "" then
							arg_393_1.bgmTxt_.text = arg_393_1.bgmTxt2_.text
						end

						arg_393_1.bgmTxt2_.text = var_396_14

						arg_393_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_393_1.bgmTxt_.text = var_396_14
						arg_393_1.bgmTxt2_.text = var_396_14
					end

					if arg_393_1.bgmTimer then
						arg_393_1.bgmTimer:Stop()

						arg_393_1.bgmTimer = nil
					end

					if arg_393_1.settingData.show_music_name == 1 then
						arg_393_1.musicController:SetSelectedState("show")
						arg_393_1.musicAnimator_:Play("open", 0, 0)

						if arg_393_1.settingData.music_time ~= 0 then
							arg_393_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_393_1.settingData.music_time), function()
								if arg_393_1 == nil or isNil(arg_393_1.bgmTxt_) then
									return
								end

								arg_393_1.musicController:SetSelectedState("hide")
								arg_393_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.3 < arg_393_1.time_ and arg_393_1.time_ <= 0.3 + arg_396_0 then
				arg_393_1:AudioAction("play", "music", "bgm_activity_3_0_story_daily_leisure", "bgm_activity_3_0_story_daily_leisure", "bgm_activity_3_0_story_daily_leisure.awb")

				local var_396_17 = manager.audio:GetAudioName("bgm_activity_3_0_story_daily_leisure", "bgm_activity_3_0_story_daily_leisure")

				if "" ~= "" then
					if arg_393_1.bgmTxt_.text ~= var_396_17 and arg_393_1.bgmTxt_.text ~= "" then
						if arg_393_1.bgmTxt2_.text ~= "" then
							arg_393_1.bgmTxt_.text = arg_393_1.bgmTxt2_.text
						end

						arg_393_1.bgmTxt2_.text = var_396_17

						arg_393_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_393_1.bgmTxt_.text = var_396_17
						arg_393_1.bgmTxt2_.text = var_396_17
					end

					if arg_393_1.bgmTimer then
						arg_393_1.bgmTimer:Stop()

						arg_393_1.bgmTimer = nil
					end

					if arg_393_1.settingData.show_music_name == 1 then
						arg_393_1.musicController:SetSelectedState("show")
						arg_393_1.musicAnimator_:Play("open", 0, 0)

						if arg_393_1.settingData.music_time ~= 0 then
							arg_393_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_393_1.settingData.music_time), function()
								if arg_393_1 == nil or isNil(arg_393_1.bgmTxt_) then
									return
								end

								arg_393_1.musicController:SetSelectedState("hide")
								arg_393_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1:AudioAction("play", "effect", "se_story_side_1080", "se_story_1080_parkloop", "")
			end

			local var_396_19 = arg_393_1.actors_["1019ui_story"]

			if 2 < arg_393_1.time_ and arg_393_1.time_ <= 2 + arg_396_0 and not isNil(var_396_19) and arg_393_1.var_.characterEffect1019ui_story == nil then
				arg_393_1.var_.characterEffect1019ui_story = var_396_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_20 = 0.200000002980232

			if 2 <= arg_393_1.time_ and arg_393_1.time_ < 2 + var_396_20 and not isNil(var_396_19) then
				if arg_393_1.var_.characterEffect1019ui_story and not isNil(var_396_19) then
					arg_393_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_393_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_393_1.time_ - 2) / var_396_20)
				end
			end

			if arg_393_1.time_ >= 2 + var_396_20 and arg_393_1.time_ < 2 + var_396_20 + arg_396_0 and not isNil(var_396_19) and arg_393_1.var_.characterEffect1019ui_story then
				arg_393_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_393_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_396_21 = arg_393_1.actors_["1019ui_story"].transform

			if 1.966 < arg_393_1.time_ and arg_393_1.time_ <= 1.966 + arg_396_0 then
				arg_393_1.var_.moveOldPos1019ui_story = var_396_21.localPosition
			end

			local var_396_22 = 0.001

			if 1.966 <= arg_393_1.time_ and arg_393_1.time_ < 1.966 + var_396_22 then
				var_396_21.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_393_1.time_ - 1.966) / var_396_22)
				var_396_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_396_21.position).x, (manager.ui.mainCamera.transform.position - var_396_21.position).y, (manager.ui.mainCamera.transform.position - var_396_21.position).z)
				var_396_21.localEulerAngles.z = 0
				var_396_21.localEulerAngles.x = 0
				var_396_21.localEulerAngles = var_396_21.localEulerAngles
			end

			if arg_393_1.time_ >= 1.966 + var_396_22 and arg_393_1.time_ < 1.966 + var_396_22 + arg_396_0 then
				var_396_21.localPosition = Vector3.New(0, 100, 0)
				var_396_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_396_21.position).x, (manager.ui.mainCamera.transform.position - var_396_21.position).y, (manager.ui.mainCamera.transform.position - var_396_21.position).z)
				var_396_21.localEulerAngles.z = 0
				var_396_21.localEulerAngles.x = 0
				var_396_21.localEulerAngles = var_396_21.localEulerAngles
			end

			if arg_393_1.frameCnt_ <= 1 then
				arg_393_1.dialog_:SetActive(false)
			end

			local var_396_23 = 4
			local var_396_24 = 0.875

			if 4 < arg_393_1.time_ and arg_393_1.time_ <= var_396_23 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0

				arg_393_1.dialog_:SetActive(true)

				arg_393_1.dialogCg_.alpha = 0

				local var_396_25 = LeanTween.value(arg_393_1.dialog_, 0, 1, 0.3)

				var_396_25:setOnUpdate(LuaHelper.FloatAction(function(arg_399_0)
					arg_393_1.dialogCg_.alpha = arg_399_0
				end))
				var_396_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_393_1.dialog_)
					var_396_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_393_1.duration_ = arg_393_1.duration_ + 0.3

				SetActive(arg_393_1.leftNameGo_, false)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_26 = arg_393_1:FormatText(arg_393_1:GetWordFromCfg(1101905096).content)

				arg_393_1.text_.text = var_396_26

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_28 = 18 <= 0 and var_396_24 or var_396_24 * (utf8.len(var_396_26) / 18)

				if (18 <= 0 and var_396_24 or var_396_24 * (utf8.len(var_396_26) / 18)) > 0 and var_396_24 < var_396_28 then
					arg_393_1.talkMaxDuration = var_396_28
					var_396_23 = var_396_23 + 0.3

					if var_396_28 + var_396_23 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_28 + var_396_23
					end
				end

				arg_393_1.text_.text = var_396_26
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_29 = var_396_23 + 0.3
			local var_396_30 = math.max(var_396_24, arg_393_1.talkMaxDuration)

			if var_396_23 + 0.3 <= arg_393_1.time_ and arg_393_1.time_ < var_396_29 + var_396_30 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_29) / var_396_30

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_29 + var_396_30 and arg_393_1.time_ < var_396_29 + var_396_30 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_393_1:InitPlayNodeList()
	end,
	Play1101905097 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 1101905097
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play1101905098(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0.45

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, false)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_1 = arg_401_1:FormatText(arg_401_1:GetWordFromCfg(1101905097).content)

				arg_401_1.text_.text = var_404_1

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_3 = 57 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_1) / 57)

				if (57 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_1) / 57)) > 0 and var_404_0 < var_404_3 then
					arg_401_1.talkMaxDuration = var_404_3

					if var_404_3 + 0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_3 + 0
					end
				end

				arg_401_1.text_.text = var_404_1
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_4 = math.max(var_404_0, arg_401_1.talkMaxDuration)

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_4 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - 0) / var_404_4

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= 0 + var_404_4 and arg_401_1.time_ < 0 + var_404_4 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play1101905098 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 1101905098
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play1101905099(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 1.425

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, true)
				arg_405_1.iconController_:SetSelectedState("hero")

				arg_405_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_405_1.callingController_:SetSelectedState("normal")

				arg_405_1.keyicon_.color = Color.New(1, 1, 1)
				arg_405_1.icon_.color = Color.New(1, 1, 1)

				local var_408_1 = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(1101905098).content)

				arg_405_1.text_.text = var_408_1

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_3 = 8 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_1) / 8)

				if (8 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_1) / 8)) > 0 and var_408_0 < var_408_3 then
					arg_405_1.talkMaxDuration = var_408_3

					if var_408_3 + 0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_3 + 0
					end
				end

				arg_405_1.text_.text = var_408_1
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_4 = math.max(var_408_0, arg_405_1.talkMaxDuration)

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_4 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - 0) / var_408_4

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= 0 + var_408_4 and arg_405_1.time_ < 0 + var_408_4 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play1101905099 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 1101905099
		arg_409_1.duration_ = 3.83

		local var_409_0 = {
			zh = 1.999999999999,
			ja = 3.833
		}
		local var_409_1 = manager.audio:GetLocalizationFlag()

		if var_409_0[var_409_1] ~= nil then
			arg_409_1.duration_ = var_409_0[var_409_1]
		end

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play1101905100(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.var_.moveOldPos1019ui_story = arg_409_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_412_0 = 0.001

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 then
				arg_409_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_409_1.time_ - 0) / var_412_0)
				arg_409_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_409_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["1019ui_story"].transform.position).z)
				arg_409_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_409_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_409_1.actors_["1019ui_story"].transform.localEulerAngles = arg_409_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 then
				arg_409_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_409_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_409_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["1019ui_story"].transform.position).z)
				arg_409_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_409_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_409_1.actors_["1019ui_story"].transform.localEulerAngles = arg_409_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_412_1 = arg_409_1.actors_["1019ui_story"]

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(var_412_1) and arg_409_1.var_.characterEffect1019ui_story == nil then
				arg_409_1.var_.characterEffect1019ui_story = var_412_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_2 = 0.200000002980232

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_2 and not isNil(var_412_1) then
				if arg_409_1.var_.characterEffect1019ui_story and not isNil(var_412_1) then
					arg_409_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_409_1.time_ >= 0 + var_412_2 and arg_409_1.time_ < 0 + var_412_2 + arg_412_0 and not isNil(var_412_1) and arg_409_1.var_.characterEffect1019ui_story then
				arg_409_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_412_4 = 0
			local var_412_5 = 0.2

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_4 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_6 = arg_409_1:GetWordFromCfg(1101905099)
				local var_412_7 = arg_409_1:FormatText(var_412_6.content)

				arg_409_1.text_.text = var_412_7

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_9 = 10 <= 0 and var_412_5 or var_412_5 * (utf8.len(var_412_7) / 10)

				if (10 <= 0 and var_412_5 or var_412_5 * (utf8.len(var_412_7) / 10)) > 0 and var_412_5 < var_412_9 then
					arg_409_1.talkMaxDuration = var_412_9

					if var_412_9 + var_412_4 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_9 + var_412_4
					end
				end

				arg_409_1.text_.text = var_412_7
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905099", "story_v_side_new_1101905.awb") ~= 0 then
					local var_412_10 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905099", "story_v_side_new_1101905.awb") / 1000

					if var_412_10 + var_412_4 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_10 + var_412_4
					end

					if var_412_6.prefab_name ~= "" and arg_409_1.actors_[var_412_6.prefab_name] ~= nil then
						local var_412_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_6.prefab_name].transform, "story_v_side_new_1101905", "1101905099", "story_v_side_new_1101905.awb")

						arg_409_1:RecordAudio("1101905099", var_412_11)
						arg_409_1:RecordAudio("1101905099", var_412_11)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905099", "story_v_side_new_1101905.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905099", "story_v_side_new_1101905.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_12 = math.max(var_412_5, arg_409_1.talkMaxDuration)

			if var_412_4 <= arg_409_1.time_ and arg_409_1.time_ < var_412_4 + var_412_12 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_4) / var_412_12

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_4 + var_412_12 and arg_409_1.time_ < var_412_4 + var_412_12 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_409_1:InitPlayNodeList()
	end,
	Play1101905100 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 1101905100
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play1101905101(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(arg_413_1.actors_["1019ui_story"]) and arg_413_1.var_.characterEffect1019ui_story == nil then
				arg_413_1.var_.characterEffect1019ui_story = arg_413_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_0 = 0.200000002980232

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_0 and not isNil(arg_413_1.actors_["1019ui_story"]) then
				if arg_413_1.var_.characterEffect1019ui_story and not isNil(arg_413_1.actors_["1019ui_story"]) then
					arg_413_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_413_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_413_1.time_ - 0) / var_416_0)
				end
			end

			if arg_413_1.time_ >= 0 + var_416_0 and arg_413_1.time_ < 0 + var_416_0 + arg_416_0 and not isNil(arg_413_1.actors_["1019ui_story"]) and arg_413_1.var_.characterEffect1019ui_story then
				arg_413_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_413_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_416_1 = 0
			local var_416_2 = 0.25

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				arg_413_1.leftNameTxt_.text = arg_413_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, true)
				arg_413_1.iconController_:SetSelectedState("hero")

				arg_413_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_413_1.callingController_:SetSelectedState("normal")

				arg_413_1.keyicon_.color = Color.New(1, 1, 1)
				arg_413_1.icon_.color = Color.New(1, 1, 1)

				local var_416_3 = arg_413_1:FormatText(arg_413_1:GetWordFromCfg(1101905100).content)

				arg_413_1.text_.text = var_416_3

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_5 = 23 <= 0 and var_416_2 or var_416_2 * (utf8.len(var_416_3) / 23)

				if (23 <= 0 and var_416_2 or var_416_2 * (utf8.len(var_416_3) / 23)) > 0 and var_416_2 < var_416_5 then
					arg_413_1.talkMaxDuration = var_416_5

					if var_416_5 + var_416_1 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_5 + var_416_1
					end
				end

				arg_413_1.text_.text = var_416_3
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_6 = math.max(var_416_2, arg_413_1.talkMaxDuration)

			if var_416_1 <= arg_413_1.time_ and arg_413_1.time_ < var_416_1 + var_416_6 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_1) / var_416_6

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_1 + var_416_6 and arg_413_1.time_ < var_416_1 + var_416_6 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play1101905101 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 1101905101
		arg_417_1.duration_ = 9.5

		local var_417_0 = {
			zh = 6.333,
			ja = 9.5
		}
		local var_417_1 = manager.audio:GetLocalizationFlag()

		if var_417_0[var_417_1] ~= nil then
			arg_417_1.duration_ = var_417_0[var_417_1]
		end

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play1101905102(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(arg_417_1.actors_["1019ui_story"]) and arg_417_1.var_.characterEffect1019ui_story == nil then
				arg_417_1.var_.characterEffect1019ui_story = arg_417_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_0 = 0.200000002980232

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 and not isNil(arg_417_1.actors_["1019ui_story"]) then
				if arg_417_1.var_.characterEffect1019ui_story and not isNil(arg_417_1.actors_["1019ui_story"]) then
					arg_417_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 and not isNil(arg_417_1.actors_["1019ui_story"]) and arg_417_1.var_.characterEffect1019ui_story then
				arg_417_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_420_2 = 0
			local var_420_3 = 0.575

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_2 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_4 = arg_417_1:GetWordFromCfg(1101905101)
				local var_420_5 = arg_417_1:FormatText(var_420_4.content)

				arg_417_1.text_.text = var_420_5

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_7 = 29 <= 0 and var_420_3 or var_420_3 * (utf8.len(var_420_5) / 29)

				if (29 <= 0 and var_420_3 or var_420_3 * (utf8.len(var_420_5) / 29)) > 0 and var_420_3 < var_420_7 then
					arg_417_1.talkMaxDuration = var_420_7

					if var_420_7 + var_420_2 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_7 + var_420_2
					end
				end

				arg_417_1.text_.text = var_420_5
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905101", "story_v_side_new_1101905.awb") ~= 0 then
					local var_420_8 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905101", "story_v_side_new_1101905.awb") / 1000

					if var_420_8 + var_420_2 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_8 + var_420_2
					end

					if var_420_4.prefab_name ~= "" and arg_417_1.actors_[var_420_4.prefab_name] ~= nil then
						local var_420_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_4.prefab_name].transform, "story_v_side_new_1101905", "1101905101", "story_v_side_new_1101905.awb")

						arg_417_1:RecordAudio("1101905101", var_420_9)
						arg_417_1:RecordAudio("1101905101", var_420_9)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905101", "story_v_side_new_1101905.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905101", "story_v_side_new_1101905.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_10 = math.max(var_420_3, arg_417_1.talkMaxDuration)

			if var_420_2 <= arg_417_1.time_ and arg_417_1.time_ < var_420_2 + var_420_10 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_2) / var_420_10

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_2 + var_420_10 and arg_417_1.time_ < var_420_2 + var_420_10 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play1101905102 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 1101905102
		arg_421_1.duration_ = 5

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play1101905103(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(arg_421_1.actors_["1019ui_story"]) and arg_421_1.var_.characterEffect1019ui_story == nil then
				arg_421_1.var_.characterEffect1019ui_story = arg_421_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_0 = 0.200000002980232

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_0 and not isNil(arg_421_1.actors_["1019ui_story"]) then
				if arg_421_1.var_.characterEffect1019ui_story and not isNil(arg_421_1.actors_["1019ui_story"]) then
					arg_421_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_421_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_421_1.time_ - 0) / var_424_0)
				end
			end

			if arg_421_1.time_ >= 0 + var_424_0 and arg_421_1.time_ < 0 + var_424_0 + arg_424_0 and not isNil(arg_421_1.actors_["1019ui_story"]) and arg_421_1.var_.characterEffect1019ui_story then
				arg_421_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_421_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_424_1 = 0
			local var_424_2 = 0.725

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_1 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, true)
				arg_421_1.iconController_:SetSelectedState("hero")

				arg_421_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_421_1.callingController_:SetSelectedState("normal")

				arg_421_1.keyicon_.color = Color.New(1, 1, 1)
				arg_421_1.icon_.color = Color.New(1, 1, 1)

				local var_424_3 = arg_421_1:FormatText(arg_421_1:GetWordFromCfg(1101905102).content)

				arg_421_1.text_.text = var_424_3

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_5 = 25 <= 0 and var_424_2 or var_424_2 * (utf8.len(var_424_3) / 25)

				if (25 <= 0 and var_424_2 or var_424_2 * (utf8.len(var_424_3) / 25)) > 0 and var_424_2 < var_424_5 then
					arg_421_1.talkMaxDuration = var_424_5

					if var_424_5 + var_424_1 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_5 + var_424_1
					end
				end

				arg_421_1.text_.text = var_424_3
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_6 = math.max(var_424_2, arg_421_1.talkMaxDuration)

			if var_424_1 <= arg_421_1.time_ and arg_421_1.time_ < var_424_1 + var_424_6 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_1) / var_424_6

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_1 + var_424_6 and arg_421_1.time_ < var_424_1 + var_424_6 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play1101905103 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 1101905103
		arg_425_1.duration_ = 5

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play1101905104(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = 0.625

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, false)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_1 = arg_425_1:FormatText(arg_425_1:GetWordFromCfg(1101905103).content)

				arg_425_1.text_.text = var_428_1

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_3 = 42 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_1) / 42)

				if (42 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_1) / 42)) > 0 and var_428_0 < var_428_3 then
					arg_425_1.talkMaxDuration = var_428_3

					if var_428_3 + 0 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_3 + 0
					end
				end

				arg_425_1.text_.text = var_428_1
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)
				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_4 = math.max(var_428_0, arg_425_1.talkMaxDuration)

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_4 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - 0) / var_428_4

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= 0 + var_428_4 and arg_425_1.time_ < 0 + var_428_4 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play1101905104 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 1101905104
		arg_429_1.duration_ = 2.73

		local var_429_0 = {
			zh = 2.733,
			ja = 1.999999999999
		}
		local var_429_1 = manager.audio:GetLocalizationFlag()

		if var_429_0[var_429_1] ~= nil then
			arg_429_1.duration_ = var_429_0[var_429_1]
		end

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play1101905105(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(arg_429_1.actors_["1019ui_story"]) and arg_429_1.var_.characterEffect1019ui_story == nil then
				arg_429_1.var_.characterEffect1019ui_story = arg_429_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_0 = 0.200000002980232

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_0 and not isNil(arg_429_1.actors_["1019ui_story"]) then
				if arg_429_1.var_.characterEffect1019ui_story and not isNil(arg_429_1.actors_["1019ui_story"]) then
					arg_429_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_429_1.time_ >= 0 + var_432_0 and arg_429_1.time_ < 0 + var_432_0 + arg_432_0 and not isNil(arg_429_1.actors_["1019ui_story"]) and arg_429_1.var_.characterEffect1019ui_story then
				arg_429_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_432_2 = 0
			local var_432_3 = 1.05

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_2 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				arg_429_1.leftNameTxt_.text = arg_429_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_4 = arg_429_1:GetWordFromCfg(1101905104)
				local var_432_5 = arg_429_1:FormatText(var_432_4.content)

				arg_429_1.text_.text = var_432_5

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_7 = 12 <= 0 and var_432_3 or var_432_3 * (utf8.len(var_432_5) / 12)

				if (12 <= 0 and var_432_3 or var_432_3 * (utf8.len(var_432_5) / 12)) > 0 and var_432_3 < var_432_7 then
					arg_429_1.talkMaxDuration = var_432_7

					if var_432_7 + var_432_2 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_7 + var_432_2
					end
				end

				arg_429_1.text_.text = var_432_5
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905104", "story_v_side_new_1101905.awb") ~= 0 then
					local var_432_8 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905104", "story_v_side_new_1101905.awb") / 1000

					if var_432_8 + var_432_2 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_8 + var_432_2
					end

					if var_432_4.prefab_name ~= "" and arg_429_1.actors_[var_432_4.prefab_name] ~= nil then
						local var_432_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_4.prefab_name].transform, "story_v_side_new_1101905", "1101905104", "story_v_side_new_1101905.awb")

						arg_429_1:RecordAudio("1101905104", var_432_9)
						arg_429_1:RecordAudio("1101905104", var_432_9)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905104", "story_v_side_new_1101905.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905104", "story_v_side_new_1101905.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_10 = math.max(var_432_3, arg_429_1.talkMaxDuration)

			if var_432_2 <= arg_429_1.time_ and arg_429_1.time_ < var_432_2 + var_432_10 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_2) / var_432_10

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_2 + var_432_10 and arg_429_1.time_ < var_432_2 + var_432_10 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play1101905105 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 1101905105
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play1101905106(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(arg_433_1.actors_["1019ui_story"]) and arg_433_1.var_.characterEffect1019ui_story == nil then
				arg_433_1.var_.characterEffect1019ui_story = arg_433_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_0 = 0.200000002980232

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_0 and not isNil(arg_433_1.actors_["1019ui_story"]) then
				if arg_433_1.var_.characterEffect1019ui_story and not isNil(arg_433_1.actors_["1019ui_story"]) then
					arg_433_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_433_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_433_1.time_ - 0) / var_436_0)
				end
			end

			if arg_433_1.time_ >= 0 + var_436_0 and arg_433_1.time_ < 0 + var_436_0 + arg_436_0 and not isNil(arg_433_1.actors_["1019ui_story"]) and arg_433_1.var_.characterEffect1019ui_story then
				arg_433_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_433_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_436_1 = 0
			local var_436_2 = 0.3

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_1 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				arg_433_1.leftNameTxt_.text = arg_433_1:FormatText(StoryNameCfg[7].name)

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

				local var_436_3 = arg_433_1:FormatText(arg_433_1:GetWordFromCfg(1101905105).content)

				arg_433_1.text_.text = var_436_3

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_5 = 19 <= 0 and var_436_2 or var_436_2 * (utf8.len(var_436_3) / 19)

				if (19 <= 0 and var_436_2 or var_436_2 * (utf8.len(var_436_3) / 19)) > 0 and var_436_2 < var_436_5 then
					arg_433_1.talkMaxDuration = var_436_5

					if var_436_5 + var_436_1 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_5 + var_436_1
					end
				end

				arg_433_1.text_.text = var_436_3
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)
				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_6 = math.max(var_436_2, arg_433_1.talkMaxDuration)

			if var_436_1 <= arg_433_1.time_ and arg_433_1.time_ < var_436_1 + var_436_6 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_1) / var_436_6

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_1 + var_436_6 and arg_433_1.time_ < var_436_1 + var_436_6 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play1101905106 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 1101905106
		arg_437_1.duration_ = 7

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play1101905107(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0.966 < arg_437_1.time_ and arg_437_1.time_ <= 0.966 + arg_440_0 then
				arg_437_1.var_.moveOldPos1019ui_story = arg_437_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_440_0 = 0.001

			if 0.966 <= arg_437_1.time_ and arg_437_1.time_ < 0.966 + var_440_0 then
				arg_437_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_437_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_437_1.time_ - 0.966) / var_440_0)
				arg_437_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_437_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1019ui_story"].transform.position).z)
				arg_437_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_437_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_437_1.actors_["1019ui_story"].transform.localEulerAngles = arg_437_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_437_1.time_ >= 0.966 + var_440_0 and arg_437_1.time_ < 0.966 + var_440_0 + arg_440_0 then
				arg_437_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_437_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_437_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1019ui_story"].transform.position).z)
				arg_437_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_437_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_437_1.actors_["1019ui_story"].transform.localEulerAngles = arg_437_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_440_1 = 0

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_1 + arg_440_0 then
				arg_437_1.mask_.enabled = true
				arg_437_1.mask_.raycastTarget = true

				arg_437_1:SetGaussion(false)
			end

			local var_440_2 = 1

			if var_440_1 <= arg_437_1.time_ and arg_437_1.time_ < var_440_1 + var_440_2 then
				local var_440_3 = Color.New(0, 0, 0)

				var_440_3.a = Mathf.Lerp(0, 1, (arg_437_1.time_ - var_440_1) / var_440_2)
				arg_437_1.mask_.color = var_440_3
			end

			if arg_437_1.time_ >= var_440_1 + var_440_2 and arg_437_1.time_ < var_440_1 + var_440_2 + arg_440_0 then
				local var_440_4 = Color.New(0, 0, 0)

				var_440_4.a = 1
				arg_437_1.mask_.color = var_440_4
			end

			local var_440_5 = 1

			if 1 < arg_437_1.time_ and arg_437_1.time_ <= var_440_5 + arg_440_0 then
				arg_437_1.mask_.enabled = true
				arg_437_1.mask_.raycastTarget = true

				arg_437_1:SetGaussion(false)
			end

			local var_440_6 = 1

			if var_440_5 <= arg_437_1.time_ and arg_437_1.time_ < var_440_5 + var_440_6 then
				local var_440_7 = Color.New(0, 0, 0)

				var_440_7.a = Mathf.Lerp(1, 0, (arg_437_1.time_ - var_440_5) / var_440_6)
				arg_437_1.mask_.color = var_440_7
			end

			if arg_437_1.time_ >= var_440_5 + var_440_6 and arg_437_1.time_ < var_440_5 + var_440_6 + arg_440_0 then
				local var_440_8 = Color.New(0, 0, 0)

				arg_437_1.mask_.enabled = false
				var_440_8.a = 0
				arg_437_1.mask_.color = var_440_8
			end

			if arg_437_1.frameCnt_ <= 1 then
				arg_437_1.dialog_:SetActive(false)
			end

			local var_440_9 = 2
			local var_440_10 = 0.475

			if 2 < arg_437_1.time_ and arg_437_1.time_ <= var_440_9 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0

				arg_437_1.dialog_:SetActive(true)

				arg_437_1.dialogCg_.alpha = 0

				local var_440_11 = LeanTween.value(arg_437_1.dialog_, 0, 1, 0.3)

				var_440_11:setOnUpdate(LuaHelper.FloatAction(function(arg_441_0)
					arg_437_1.dialogCg_.alpha = arg_441_0
				end))
				var_440_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_437_1.dialog_)
					var_440_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_437_1.duration_ = arg_437_1.duration_ + 0.3

				SetActive(arg_437_1.leftNameGo_, false)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_12 = arg_437_1:FormatText(arg_437_1:GetWordFromCfg(1101905106).content)

				arg_437_1.text_.text = var_440_12

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_14 = 66 <= 0 and var_440_10 or var_440_10 * (utf8.len(var_440_12) / 66)

				if (66 <= 0 and var_440_10 or var_440_10 * (utf8.len(var_440_12) / 66)) > 0 and var_440_10 < var_440_14 then
					arg_437_1.talkMaxDuration = var_440_14
					var_440_9 = var_440_9 + 0.3

					if var_440_14 + var_440_9 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_14 + var_440_9
					end
				end

				arg_437_1.text_.text = var_440_12
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_15 = var_440_9 + 0.3
			local var_440_16 = math.max(var_440_10, arg_437_1.talkMaxDuration)

			if var_440_9 + 0.3 <= arg_437_1.time_ and arg_437_1.time_ < var_440_15 + var_440_16 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_15) / var_440_16

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_15 + var_440_16 and arg_437_1.time_ < var_440_15 + var_440_16 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_437_1:InitPlayNodeList()
	end,
	Play1101905107 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 1101905107
		arg_443_1.duration_ = 2

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play1101905108(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1.var_.moveOldPos1019ui_story = arg_443_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_446_0 = 0.001

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_0 then
				arg_443_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_443_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_443_1.time_ - 0) / var_446_0)
				arg_443_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_443_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["1019ui_story"].transform.position).z)
				arg_443_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_443_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_443_1.actors_["1019ui_story"].transform.localEulerAngles = arg_443_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_443_1.time_ >= 0 + var_446_0 and arg_443_1.time_ < 0 + var_446_0 + arg_446_0 then
				arg_443_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_443_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_443_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["1019ui_story"].transform.position).z)
				arg_443_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_443_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_443_1.actors_["1019ui_story"].transform.localEulerAngles = arg_443_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_446_1 = arg_443_1.actors_["1019ui_story"]

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 and not isNil(var_446_1) and arg_443_1.var_.characterEffect1019ui_story == nil then
				arg_443_1.var_.characterEffect1019ui_story = var_446_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_446_2 = 0.200000002980232

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_2 and not isNil(var_446_1) then
				if arg_443_1.var_.characterEffect1019ui_story and not isNil(var_446_1) then
					arg_443_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_443_1.time_ >= 0 + var_446_2 and arg_443_1.time_ < 0 + var_446_2 + arg_446_0 and not isNil(var_446_1) and arg_443_1.var_.characterEffect1019ui_story then
				arg_443_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_446_4 = 0
			local var_446_5 = 1.65

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_4 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				arg_443_1.leftNameTxt_.text = arg_443_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_6 = arg_443_1:GetWordFromCfg(1101905107)
				local var_446_7 = arg_443_1:FormatText(var_446_6.content)

				arg_443_1.text_.text = var_446_7

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_9 = 9 <= 0 and var_446_5 or var_446_5 * (utf8.len(var_446_7) / 9)

				if (9 <= 0 and var_446_5 or var_446_5 * (utf8.len(var_446_7) / 9)) > 0 and var_446_5 < var_446_9 then
					arg_443_1.talkMaxDuration = var_446_9

					if var_446_9 + var_446_4 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_9 + var_446_4
					end
				end

				arg_443_1.text_.text = var_446_7
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905107", "story_v_side_new_1101905.awb") ~= 0 then
					local var_446_10 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905107", "story_v_side_new_1101905.awb") / 1000

					if var_446_10 + var_446_4 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_10 + var_446_4
					end

					if var_446_6.prefab_name ~= "" and arg_443_1.actors_[var_446_6.prefab_name] ~= nil then
						local var_446_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_6.prefab_name].transform, "story_v_side_new_1101905", "1101905107", "story_v_side_new_1101905.awb")

						arg_443_1:RecordAudio("1101905107", var_446_11)
						arg_443_1:RecordAudio("1101905107", var_446_11)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905107", "story_v_side_new_1101905.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905107", "story_v_side_new_1101905.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_12 = math.max(var_446_5, arg_443_1.talkMaxDuration)

			if var_446_4 <= arg_443_1.time_ and arg_443_1.time_ < var_446_4 + var_446_12 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_4) / var_446_12

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_4 + var_446_12 and arg_443_1.time_ < var_446_4 + var_446_12 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_443_1:InitPlayNodeList()
	end,
	Play1101905108 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 1101905108
		arg_447_1.duration_ = 5

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play1101905109(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 and not isNil(arg_447_1.actors_["1019ui_story"]) and arg_447_1.var_.characterEffect1019ui_story == nil then
				arg_447_1.var_.characterEffect1019ui_story = arg_447_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_450_0 = 0.200000002980232

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_0 and not isNil(arg_447_1.actors_["1019ui_story"]) then
				if arg_447_1.var_.characterEffect1019ui_story and not isNil(arg_447_1.actors_["1019ui_story"]) then
					arg_447_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_447_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_447_1.time_ - 0) / var_450_0)
				end
			end

			if arg_447_1.time_ >= 0 + var_450_0 and arg_447_1.time_ < 0 + var_450_0 + arg_450_0 and not isNil(arg_447_1.actors_["1019ui_story"]) and arg_447_1.var_.characterEffect1019ui_story then
				arg_447_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_447_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_450_1 = 0
			local var_450_2 = 0.225

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_1 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				arg_447_1.leftNameTxt_.text = arg_447_1:FormatText(StoryNameCfg[7].name)

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

				local var_450_3 = arg_447_1:FormatText(arg_447_1:GetWordFromCfg(1101905108).content)

				arg_447_1.text_.text = var_450_3

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_5 = 34 <= 0 and var_450_2 or var_450_2 * (utf8.len(var_450_3) / 34)

				if (34 <= 0 and var_450_2 or var_450_2 * (utf8.len(var_450_3) / 34)) > 0 and var_450_2 < var_450_5 then
					arg_447_1.talkMaxDuration = var_450_5

					if var_450_5 + var_450_1 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_5 + var_450_1
					end
				end

				arg_447_1.text_.text = var_450_3
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)
				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_6 = math.max(var_450_2, arg_447_1.talkMaxDuration)

			if var_450_1 <= arg_447_1.time_ and arg_447_1.time_ < var_450_1 + var_450_6 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_1) / var_450_6

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_1 + var_450_6 and arg_447_1.time_ < var_450_1 + var_450_6 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play1101905109 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 1101905109
		arg_451_1.duration_ = 6.7

		local var_451_0 = {
			zh = 6.7,
			ja = 5.3
		}
		local var_451_1 = manager.audio:GetLocalizationFlag()

		if var_451_0[var_451_1] ~= nil then
			arg_451_1.duration_ = var_451_0[var_451_1]
		end

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play1101905110(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 and not isNil(arg_451_1.actors_["1019ui_story"]) and arg_451_1.var_.characterEffect1019ui_story == nil then
				arg_451_1.var_.characterEffect1019ui_story = arg_451_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_0 = 0.200000002980232

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_0 and not isNil(arg_451_1.actors_["1019ui_story"]) then
				if arg_451_1.var_.characterEffect1019ui_story and not isNil(arg_451_1.actors_["1019ui_story"]) then
					arg_451_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_451_1.time_ >= 0 + var_454_0 and arg_451_1.time_ < 0 + var_454_0 + arg_454_0 and not isNil(arg_451_1.actors_["1019ui_story"]) and arg_451_1.var_.characterEffect1019ui_story then
				arg_451_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_454_2 = 0
			local var_454_3 = 0.85

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_2 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				arg_451_1.leftNameTxt_.text = arg_451_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_4 = arg_451_1:GetWordFromCfg(1101905109)
				local var_454_5 = arg_451_1:FormatText(var_454_4.content)

				arg_451_1.text_.text = var_454_5

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_7 = 27 <= 0 and var_454_3 or var_454_3 * (utf8.len(var_454_5) / 27)

				if (27 <= 0 and var_454_3 or var_454_3 * (utf8.len(var_454_5) / 27)) > 0 and var_454_3 < var_454_7 then
					arg_451_1.talkMaxDuration = var_454_7

					if var_454_7 + var_454_2 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_7 + var_454_2
					end
				end

				arg_451_1.text_.text = var_454_5
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905109", "story_v_side_new_1101905.awb") ~= 0 then
					local var_454_8 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905109", "story_v_side_new_1101905.awb") / 1000

					if var_454_8 + var_454_2 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_8 + var_454_2
					end

					if var_454_4.prefab_name ~= "" and arg_451_1.actors_[var_454_4.prefab_name] ~= nil then
						local var_454_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_4.prefab_name].transform, "story_v_side_new_1101905", "1101905109", "story_v_side_new_1101905.awb")

						arg_451_1:RecordAudio("1101905109", var_454_9)
						arg_451_1:RecordAudio("1101905109", var_454_9)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905109", "story_v_side_new_1101905.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905109", "story_v_side_new_1101905.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_10 = math.max(var_454_3, arg_451_1.talkMaxDuration)

			if var_454_2 <= arg_451_1.time_ and arg_451_1.time_ < var_454_2 + var_454_10 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_2) / var_454_10

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_2 + var_454_10 and arg_451_1.time_ < var_454_2 + var_454_10 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play1101905110 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 1101905110
		arg_455_1.duration_ = 11.27

		local var_455_0 = {
			zh = 11.266,
			ja = 9.533
		}
		local var_455_1 = manager.audio:GetLocalizationFlag()

		if var_455_0[var_455_1] ~= nil then
			arg_455_1.duration_ = var_455_0[var_455_1]
		end

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play1101905111(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = 0.675

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				arg_455_1.leftNameTxt_.text = arg_455_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_1 = arg_455_1:GetWordFromCfg(1101905110)
				local var_458_2 = arg_455_1:FormatText(var_458_1.content)

				arg_455_1.text_.text = var_458_2

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_4 = 38 <= 0 and var_458_0 or var_458_0 * (utf8.len(var_458_2) / 38)

				if (38 <= 0 and var_458_0 or var_458_0 * (utf8.len(var_458_2) / 38)) > 0 and var_458_0 < var_458_4 then
					arg_455_1.talkMaxDuration = var_458_4

					if var_458_4 + 0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_4 + 0
					end
				end

				arg_455_1.text_.text = var_458_2
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905110", "story_v_side_new_1101905.awb") ~= 0 then
					local var_458_5 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905110", "story_v_side_new_1101905.awb") / 1000

					if var_458_5 + 0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_5 + 0
					end

					if var_458_1.prefab_name ~= "" and arg_455_1.actors_[var_458_1.prefab_name] ~= nil then
						local var_458_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_1.prefab_name].transform, "story_v_side_new_1101905", "1101905110", "story_v_side_new_1101905.awb")

						arg_455_1:RecordAudio("1101905110", var_458_6)
						arg_455_1:RecordAudio("1101905110", var_458_6)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905110", "story_v_side_new_1101905.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905110", "story_v_side_new_1101905.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_7 = math.max(var_458_0, arg_455_1.talkMaxDuration)

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_7 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - 0) / var_458_7

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= 0 + var_458_7 and arg_455_1.time_ < 0 + var_458_7 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play1101905111 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 1101905111
		arg_459_1.duration_ = 5

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play1101905112(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 and not isNil(arg_459_1.actors_["1019ui_story"]) and arg_459_1.var_.characterEffect1019ui_story == nil then
				arg_459_1.var_.characterEffect1019ui_story = arg_459_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_462_0 = 0.200000002980232

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_0 and not isNil(arg_459_1.actors_["1019ui_story"]) then
				if arg_459_1.var_.characterEffect1019ui_story and not isNil(arg_459_1.actors_["1019ui_story"]) then
					arg_459_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_459_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_459_1.time_ - 0) / var_462_0)
				end
			end

			if arg_459_1.time_ >= 0 + var_462_0 and arg_459_1.time_ < 0 + var_462_0 + arg_462_0 and not isNil(arg_459_1.actors_["1019ui_story"]) and arg_459_1.var_.characterEffect1019ui_story then
				arg_459_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_459_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_462_1 = 0
			local var_462_2 = 0.95

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= var_462_1 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				arg_459_1.leftNameTxt_.text = arg_459_1:FormatText(StoryNameCfg[7].name)

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

				local var_462_3 = arg_459_1:FormatText(arg_459_1:GetWordFromCfg(1101905111).content)

				arg_459_1.text_.text = var_462_3

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_5 = 23 <= 0 and var_462_2 or var_462_2 * (utf8.len(var_462_3) / 23)

				if (23 <= 0 and var_462_2 or var_462_2 * (utf8.len(var_462_3) / 23)) > 0 and var_462_2 < var_462_5 then
					arg_459_1.talkMaxDuration = var_462_5

					if var_462_5 + var_462_1 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_5 + var_462_1
					end
				end

				arg_459_1.text_.text = var_462_3
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)
				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_6 = math.max(var_462_2, arg_459_1.talkMaxDuration)

			if var_462_1 <= arg_459_1.time_ and arg_459_1.time_ < var_462_1 + var_462_6 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_1) / var_462_6

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_1 + var_462_6 and arg_459_1.time_ < var_462_1 + var_462_6 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play1101905112 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 1101905112
		arg_463_1.duration_ = 7.33

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play1101905113(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1.var_.moveOldPos1019ui_story = arg_463_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_466_0 = 0.001

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_0 then
				arg_463_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_463_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_463_1.time_ - 0) / var_466_0)
				arg_463_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_463_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_463_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_463_1.actors_["1019ui_story"].transform.position).z)
				arg_463_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_463_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_463_1.actors_["1019ui_story"].transform.localEulerAngles = arg_463_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_463_1.time_ >= 0 + var_466_0 and arg_463_1.time_ < 0 + var_466_0 + arg_466_0 then
				arg_463_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_463_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_463_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_463_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_463_1.actors_["1019ui_story"].transform.position).z)
				arg_463_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_463_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_463_1.actors_["1019ui_story"].transform.localEulerAngles = arg_463_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_466_1 = arg_463_1.actors_["1019ui_story"]

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 and not isNil(var_466_1) and arg_463_1.var_.characterEffect1019ui_story == nil then
				arg_463_1.var_.characterEffect1019ui_story = var_466_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_466_2 = 0.200000002980232

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_2 and not isNil(var_466_1) then
				if arg_463_1.var_.characterEffect1019ui_story and not isNil(var_466_1) then
					arg_463_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_463_1.time_ >= 0 + var_466_2 and arg_463_1.time_ < 0 + var_466_2 + arg_466_0 and not isNil(var_466_1) and arg_463_1.var_.characterEffect1019ui_story then
				arg_463_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_466_4 = 0
			local var_466_5 = 0.575

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= var_466_4 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				arg_463_1.leftNameTxt_.text = arg_463_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_6 = arg_463_1:GetWordFromCfg(1101905112)
				local var_466_7 = arg_463_1:FormatText(var_466_6.content)

				arg_463_1.text_.text = var_466_7

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_9 = 2 <= 0 and var_466_5 or var_466_5 * (utf8.len(var_466_7) / 2)

				if (2 <= 0 and var_466_5 or var_466_5 * (utf8.len(var_466_7) / 2)) > 0 and var_466_5 < var_466_9 then
					arg_463_1.talkMaxDuration = var_466_9

					if var_466_9 + var_466_4 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_9 + var_466_4
					end
				end

				arg_463_1.text_.text = var_466_7
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905112", "story_v_side_new_1101905.awb") ~= 0 then
					local var_466_10 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905112", "story_v_side_new_1101905.awb") / 1000

					if var_466_10 + var_466_4 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_10 + var_466_4
					end

					if var_466_6.prefab_name ~= "" and arg_463_1.actors_[var_466_6.prefab_name] ~= nil then
						local var_466_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_6.prefab_name].transform, "story_v_side_new_1101905", "1101905112", "story_v_side_new_1101905.awb")

						arg_463_1:RecordAudio("1101905112", var_466_11)
						arg_463_1:RecordAudio("1101905112", var_466_11)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905112", "story_v_side_new_1101905.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905112", "story_v_side_new_1101905.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_12 = math.max(var_466_5, arg_463_1.talkMaxDuration)

			if var_466_4 <= arg_463_1.time_ and arg_463_1.time_ < var_466_4 + var_466_12 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_4) / var_466_12

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_4 + var_466_12 and arg_463_1.time_ < var_466_4 + var_466_12 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_463_1:InitPlayNodeList()
	end,
	Play1101905113 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 1101905113
		arg_467_1.duration_ = 5

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play1101905114(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 and not isNil(arg_467_1.actors_["1019ui_story"]) and arg_467_1.var_.characterEffect1019ui_story == nil then
				arg_467_1.var_.characterEffect1019ui_story = arg_467_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_470_0 = 0.200000002980232

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_0 and not isNil(arg_467_1.actors_["1019ui_story"]) then
				if arg_467_1.var_.characterEffect1019ui_story and not isNil(arg_467_1.actors_["1019ui_story"]) then
					arg_467_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_467_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_467_1.time_ - 0) / var_470_0)
				end
			end

			if arg_467_1.time_ >= 0 + var_470_0 and arg_467_1.time_ < 0 + var_470_0 + arg_470_0 and not isNil(arg_467_1.actors_["1019ui_story"]) and arg_467_1.var_.characterEffect1019ui_story then
				arg_467_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_467_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_470_1 = 0
			local var_470_2 = 0.05

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_1 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				arg_467_1.leftNameTxt_.text = arg_467_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, true)
				arg_467_1.iconController_:SetSelectedState("hero")

				arg_467_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_467_1.callingController_:SetSelectedState("normal")

				arg_467_1.keyicon_.color = Color.New(1, 1, 1)
				arg_467_1.icon_.color = Color.New(1, 1, 1)

				local var_470_3 = arg_467_1:FormatText(arg_467_1:GetWordFromCfg(1101905113).content)

				arg_467_1.text_.text = var_470_3

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_5 = 6 <= 0 and var_470_2 or var_470_2 * (utf8.len(var_470_3) / 6)

				if (6 <= 0 and var_470_2 or var_470_2 * (utf8.len(var_470_3) / 6)) > 0 and var_470_2 < var_470_5 then
					arg_467_1.talkMaxDuration = var_470_5

					if var_470_5 + var_470_1 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_5 + var_470_1
					end
				end

				arg_467_1.text_.text = var_470_3
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)
				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_6 = math.max(var_470_2, arg_467_1.talkMaxDuration)

			if var_470_1 <= arg_467_1.time_ and arg_467_1.time_ < var_470_1 + var_470_6 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_1) / var_470_6

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_1 + var_470_6 and arg_467_1.time_ < var_470_1 + var_470_6 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play1101905114 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 1101905114
		arg_471_1.duration_ = 10.9

		local var_471_0 = {
			zh = 4.766,
			ja = 10.9
		}
		local var_471_1 = manager.audio:GetLocalizationFlag()

		if var_471_0[var_471_1] ~= nil then
			arg_471_1.duration_ = var_471_0[var_471_1]
		end

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play1101905115(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1.var_.moveOldPos1019ui_story = arg_471_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_474_0 = 0.001

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_0 then
				arg_471_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_471_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_471_1.time_ - 0) / var_474_0)
				arg_471_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_471_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_471_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_471_1.actors_["1019ui_story"].transform.position).z)
				arg_471_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_471_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_471_1.actors_["1019ui_story"].transform.localEulerAngles = arg_471_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_471_1.time_ >= 0 + var_474_0 and arg_471_1.time_ < 0 + var_474_0 + arg_474_0 then
				arg_471_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_471_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_471_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_471_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_471_1.actors_["1019ui_story"].transform.position).z)
				arg_471_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_471_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_471_1.actors_["1019ui_story"].transform.localEulerAngles = arg_471_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_474_1 = arg_471_1.actors_["1019ui_story"]

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 and not isNil(var_474_1) and arg_471_1.var_.characterEffect1019ui_story == nil then
				arg_471_1.var_.characterEffect1019ui_story = var_474_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_474_2 = 0.200000002980232

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_2 and not isNil(var_474_1) then
				if arg_471_1.var_.characterEffect1019ui_story and not isNil(var_474_1) then
					arg_471_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_471_1.time_ >= 0 + var_474_2 and arg_471_1.time_ < 0 + var_474_2 + arg_474_0 and not isNil(var_474_1) and arg_471_1.var_.characterEffect1019ui_story then
				arg_471_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action425")
			end

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_474_4 = 0
			local var_474_5 = 0.15

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= var_474_4 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				arg_471_1.leftNameTxt_.text = arg_471_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_6 = arg_471_1:GetWordFromCfg(1101905114)
				local var_474_7 = arg_471_1:FormatText(var_474_6.content)

				arg_471_1.text_.text = var_474_7

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_9 = 19 <= 0 and var_474_5 or var_474_5 * (utf8.len(var_474_7) / 19)

				if (19 <= 0 and var_474_5 or var_474_5 * (utf8.len(var_474_7) / 19)) > 0 and var_474_5 < var_474_9 then
					arg_471_1.talkMaxDuration = var_474_9

					if var_474_9 + var_474_4 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_9 + var_474_4
					end
				end

				arg_471_1.text_.text = var_474_7
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905114", "story_v_side_new_1101905.awb") ~= 0 then
					local var_474_10 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905114", "story_v_side_new_1101905.awb") / 1000

					if var_474_10 + var_474_4 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_10 + var_474_4
					end

					if var_474_6.prefab_name ~= "" and arg_471_1.actors_[var_474_6.prefab_name] ~= nil then
						local var_474_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_471_1.actors_[var_474_6.prefab_name].transform, "story_v_side_new_1101905", "1101905114", "story_v_side_new_1101905.awb")

						arg_471_1:RecordAudio("1101905114", var_474_11)
						arg_471_1:RecordAudio("1101905114", var_474_11)
					else
						arg_471_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905114", "story_v_side_new_1101905.awb")
					end

					arg_471_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905114", "story_v_side_new_1101905.awb")
				end

				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_12 = math.max(var_474_5, arg_471_1.talkMaxDuration)

			if var_474_4 <= arg_471_1.time_ and arg_471_1.time_ < var_474_4 + var_474_12 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_4) / var_474_12

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_4 + var_474_12 and arg_471_1.time_ < var_474_4 + var_474_12 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_471_1:InitPlayNodeList()
	end,
	Play1101905115 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 1101905115
		arg_475_1.duration_ = 5

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play1101905116(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 and not isNil(arg_475_1.actors_["1019ui_story"]) and arg_475_1.var_.characterEffect1019ui_story == nil then
				arg_475_1.var_.characterEffect1019ui_story = arg_475_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_478_0 = 0.200000002980232

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_0 and not isNil(arg_475_1.actors_["1019ui_story"]) then
				if arg_475_1.var_.characterEffect1019ui_story and not isNil(arg_475_1.actors_["1019ui_story"]) then
					arg_475_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_475_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_475_1.time_ - 0) / var_478_0)
				end
			end

			if arg_475_1.time_ >= 0 + var_478_0 and arg_475_1.time_ < 0 + var_478_0 + arg_478_0 and not isNil(arg_475_1.actors_["1019ui_story"]) and arg_475_1.var_.characterEffect1019ui_story then
				arg_475_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_475_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_478_1 = 0
			local var_478_2 = 0.475

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= var_478_1 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				arg_475_1.leftNameTxt_.text = arg_475_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, true)
				arg_475_1.iconController_:SetSelectedState("hero")

				arg_475_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_475_1.callingController_:SetSelectedState("normal")

				arg_475_1.keyicon_.color = Color.New(1, 1, 1)
				arg_475_1.icon_.color = Color.New(1, 1, 1)

				local var_478_3 = arg_475_1:FormatText(arg_475_1:GetWordFromCfg(1101905115).content)

				arg_475_1.text_.text = var_478_3

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_5 = 8 <= 0 and var_478_2 or var_478_2 * (utf8.len(var_478_3) / 8)

				if (8 <= 0 and var_478_2 or var_478_2 * (utf8.len(var_478_3) / 8)) > 0 and var_478_2 < var_478_5 then
					arg_475_1.talkMaxDuration = var_478_5

					if var_478_5 + var_478_1 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_5 + var_478_1
					end
				end

				arg_475_1.text_.text = var_478_3
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)
				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_6 = math.max(var_478_2, arg_475_1.talkMaxDuration)

			if var_478_1 <= arg_475_1.time_ and arg_475_1.time_ < var_478_1 + var_478_6 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_1) / var_478_6

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_1 + var_478_6 and arg_475_1.time_ < var_478_1 + var_478_6 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {}

		arg_475_1:InitPlayNodeList()
	end,
	Play1101905116 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 1101905116
		arg_479_1.duration_ = 8.9

		local var_479_0 = {
			zh = 7.433,
			ja = 8.9
		}
		local var_479_1 = manager.audio:GetLocalizationFlag()

		if var_479_0[var_479_1] ~= nil then
			arg_479_1.duration_ = var_479_0[var_479_1]
		end

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play1101905117(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_482_0 = arg_479_1.actors_["1019ui_story"]

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 and not isNil(var_482_0) and arg_479_1.var_.characterEffect1019ui_story == nil then
				arg_479_1.var_.characterEffect1019ui_story = var_482_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_482_1 = 0.200000002980232

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_1 and not isNil(var_482_0) then
				if arg_479_1.var_.characterEffect1019ui_story and not isNil(var_482_0) then
					arg_479_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_479_1.time_ >= 0 + var_482_1 and arg_479_1.time_ < 0 + var_482_1 + arg_482_0 and not isNil(var_482_0) and arg_479_1.var_.characterEffect1019ui_story then
				arg_479_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_482_3 = 0
			local var_482_4 = 0.2

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= var_482_3 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				arg_479_1.leftNameTxt_.text = arg_479_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_5 = arg_479_1:GetWordFromCfg(1101905116)
				local var_482_6 = arg_479_1:FormatText(var_482_5.content)

				arg_479_1.text_.text = var_482_6

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_8 = 27 <= 0 and var_482_4 or var_482_4 * (utf8.len(var_482_6) / 27)

				if (27 <= 0 and var_482_4 or var_482_4 * (utf8.len(var_482_6) / 27)) > 0 and var_482_4 < var_482_8 then
					arg_479_1.talkMaxDuration = var_482_8

					if var_482_8 + var_482_3 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_8 + var_482_3
					end
				end

				arg_479_1.text_.text = var_482_6
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905116", "story_v_side_new_1101905.awb") ~= 0 then
					local var_482_9 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905116", "story_v_side_new_1101905.awb") / 1000

					if var_482_9 + var_482_3 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_9 + var_482_3
					end

					if var_482_5.prefab_name ~= "" and arg_479_1.actors_[var_482_5.prefab_name] ~= nil then
						local var_482_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_5.prefab_name].transform, "story_v_side_new_1101905", "1101905116", "story_v_side_new_1101905.awb")

						arg_479_1:RecordAudio("1101905116", var_482_10)
						arg_479_1:RecordAudio("1101905116", var_482_10)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905116", "story_v_side_new_1101905.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905116", "story_v_side_new_1101905.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_11 = math.max(var_482_4, arg_479_1.talkMaxDuration)

			if var_482_3 <= arg_479_1.time_ and arg_479_1.time_ < var_482_3 + var_482_11 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_3) / var_482_11

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_3 + var_482_11 and arg_479_1.time_ < var_482_3 + var_482_11 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play1101905117 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 1101905117
		arg_483_1.duration_ = 9.2

		local var_483_0 = {
			zh = 5.933,
			ja = 9.2
		}
		local var_483_1 = manager.audio:GetLocalizationFlag()

		if var_483_0[var_483_1] ~= nil then
			arg_483_1.duration_ = var_483_0[var_483_1]
		end

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play1101905118(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = 0.675

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				arg_483_1.leftNameTxt_.text = arg_483_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_1 = arg_483_1:GetWordFromCfg(1101905117)
				local var_486_2 = arg_483_1:FormatText(var_486_1.content)

				arg_483_1.text_.text = var_486_2

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_4 = 30 <= 0 and var_486_0 or var_486_0 * (utf8.len(var_486_2) / 30)

				if (30 <= 0 and var_486_0 or var_486_0 * (utf8.len(var_486_2) / 30)) > 0 and var_486_0 < var_486_4 then
					arg_483_1.talkMaxDuration = var_486_4

					if var_486_4 + 0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_4 + 0
					end
				end

				arg_483_1.text_.text = var_486_2
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905117", "story_v_side_new_1101905.awb") ~= 0 then
					local var_486_5 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905117", "story_v_side_new_1101905.awb") / 1000

					if var_486_5 + 0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_5 + 0
					end

					if var_486_1.prefab_name ~= "" and arg_483_1.actors_[var_486_1.prefab_name] ~= nil then
						local var_486_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_483_1.actors_[var_486_1.prefab_name].transform, "story_v_side_new_1101905", "1101905117", "story_v_side_new_1101905.awb")

						arg_483_1:RecordAudio("1101905117", var_486_6)
						arg_483_1:RecordAudio("1101905117", var_486_6)
					else
						arg_483_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905117", "story_v_side_new_1101905.awb")
					end

					arg_483_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905117", "story_v_side_new_1101905.awb")
				end

				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_7 = math.max(var_486_0, arg_483_1.talkMaxDuration)

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_7 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - 0) / var_486_7

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= 0 + var_486_7 and arg_483_1.time_ < 0 + var_486_7 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play1101905118 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 1101905118
		arg_487_1.duration_ = 5

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play1101905119(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 and not isNil(arg_487_1.actors_["1019ui_story"]) and arg_487_1.var_.characterEffect1019ui_story == nil then
				arg_487_1.var_.characterEffect1019ui_story = arg_487_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_490_0 = 0.200000002980232

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_0 and not isNil(arg_487_1.actors_["1019ui_story"]) then
				if arg_487_1.var_.characterEffect1019ui_story and not isNil(arg_487_1.actors_["1019ui_story"]) then
					arg_487_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_487_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_487_1.time_ - 0) / var_490_0)
				end
			end

			if arg_487_1.time_ >= 0 + var_490_0 and arg_487_1.time_ < 0 + var_490_0 + arg_490_0 and not isNil(arg_487_1.actors_["1019ui_story"]) and arg_487_1.var_.characterEffect1019ui_story then
				arg_487_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_487_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_490_1 = 0
			local var_490_2 = 0.75

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_1 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				arg_487_1.leftNameTxt_.text = arg_487_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, true)
				arg_487_1.iconController_:SetSelectedState("hero")

				arg_487_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_487_1.callingController_:SetSelectedState("normal")

				arg_487_1.keyicon_.color = Color.New(1, 1, 1)
				arg_487_1.icon_.color = Color.New(1, 1, 1)

				local var_490_3 = arg_487_1:FormatText(arg_487_1:GetWordFromCfg(1101905118).content)

				arg_487_1.text_.text = var_490_3

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_5 = 5 <= 0 and var_490_2 or var_490_2 * (utf8.len(var_490_3) / 5)

				if (5 <= 0 and var_490_2 or var_490_2 * (utf8.len(var_490_3) / 5)) > 0 and var_490_2 < var_490_5 then
					arg_487_1.talkMaxDuration = var_490_5

					if var_490_5 + var_490_1 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_5 + var_490_1
					end
				end

				arg_487_1.text_.text = var_490_3
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)
				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_6 = math.max(var_490_2, arg_487_1.talkMaxDuration)

			if var_490_1 <= arg_487_1.time_ and arg_487_1.time_ < var_490_1 + var_490_6 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_1) / var_490_6

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_1 + var_490_6 and arg_487_1.time_ < var_490_1 + var_490_6 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play1101905119 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 1101905119
		arg_491_1.duration_ = 5.27

		local var_491_0 = {
			zh = 3.333,
			ja = 5.266
		}
		local var_491_1 = manager.audio:GetLocalizationFlag()

		if var_491_0[var_491_1] ~= nil then
			arg_491_1.duration_ = var_491_0[var_491_1]
		end

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play1101905120(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1.var_.moveOldPos1019ui_story = arg_491_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_494_0 = 0.001

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_0 then
				arg_491_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_491_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_491_1.time_ - 0) / var_494_0)
				arg_491_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_491_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_491_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_491_1.actors_["1019ui_story"].transform.position).z)
				arg_491_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_491_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_491_1.actors_["1019ui_story"].transform.localEulerAngles = arg_491_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_491_1.time_ >= 0 + var_494_0 and arg_491_1.time_ < 0 + var_494_0 + arg_494_0 then
				arg_491_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_491_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_491_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_491_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_491_1.actors_["1019ui_story"].transform.position).z)
				arg_491_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_491_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_491_1.actors_["1019ui_story"].transform.localEulerAngles = arg_491_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_494_1 = arg_491_1.actors_["1019ui_story"]

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 and not isNil(var_494_1) and arg_491_1.var_.characterEffect1019ui_story == nil then
				arg_491_1.var_.characterEffect1019ui_story = var_494_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_494_2 = 0.200000002980232

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_2 and not isNil(var_494_1) then
				if arg_491_1.var_.characterEffect1019ui_story and not isNil(var_494_1) then
					arg_491_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_491_1.time_ >= 0 + var_494_2 and arg_491_1.time_ < 0 + var_494_2 + arg_494_0 and not isNil(var_494_1) and arg_491_1.var_.characterEffect1019ui_story then
				arg_491_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_2")
			end

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_494_4 = 0
			local var_494_5 = 0.125

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_4 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				arg_491_1.leftNameTxt_.text = arg_491_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_6 = arg_491_1:GetWordFromCfg(1101905119)
				local var_494_7 = arg_491_1:FormatText(var_494_6.content)

				arg_491_1.text_.text = var_494_7

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_9 = 16 <= 0 and var_494_5 or var_494_5 * (utf8.len(var_494_7) / 16)

				if (16 <= 0 and var_494_5 or var_494_5 * (utf8.len(var_494_7) / 16)) > 0 and var_494_5 < var_494_9 then
					arg_491_1.talkMaxDuration = var_494_9

					if var_494_9 + var_494_4 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_9 + var_494_4
					end
				end

				arg_491_1.text_.text = var_494_7
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905119", "story_v_side_new_1101905.awb") ~= 0 then
					local var_494_10 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905119", "story_v_side_new_1101905.awb") / 1000

					if var_494_10 + var_494_4 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_10 + var_494_4
					end

					if var_494_6.prefab_name ~= "" and arg_491_1.actors_[var_494_6.prefab_name] ~= nil then
						local var_494_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_6.prefab_name].transform, "story_v_side_new_1101905", "1101905119", "story_v_side_new_1101905.awb")

						arg_491_1:RecordAudio("1101905119", var_494_11)
						arg_491_1:RecordAudio("1101905119", var_494_11)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905119", "story_v_side_new_1101905.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905119", "story_v_side_new_1101905.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_12 = math.max(var_494_5, arg_491_1.talkMaxDuration)

			if var_494_4 <= arg_491_1.time_ and arg_491_1.time_ < var_494_4 + var_494_12 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_4) / var_494_12

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_4 + var_494_12 and arg_491_1.time_ < var_494_4 + var_494_12 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_491_1:InitPlayNodeList()
	end,
	Play1101905120 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 1101905120
		arg_495_1.duration_ = 7.27

		local var_495_0 = {
			zh = 2.733,
			ja = 7.266
		}
		local var_495_1 = manager.audio:GetLocalizationFlag()

		if var_495_0[var_495_1] ~= nil then
			arg_495_1.duration_ = var_495_0[var_495_1]
		end

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play1101905121(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = 0.4

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				arg_495_1.leftNameTxt_.text = arg_495_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_1 = arg_495_1:GetWordFromCfg(1101905120)
				local var_498_2 = arg_495_1:FormatText(var_498_1.content)

				arg_495_1.text_.text = var_498_2

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_4 = 14 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_2) / 14)

				if (14 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_2) / 14)) > 0 and var_498_0 < var_498_4 then
					arg_495_1.talkMaxDuration = var_498_4

					if var_498_4 + 0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_4 + 0
					end
				end

				arg_495_1.text_.text = var_498_2
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905120", "story_v_side_new_1101905.awb") ~= 0 then
					local var_498_5 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905120", "story_v_side_new_1101905.awb") / 1000

					if var_498_5 + 0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_5 + 0
					end

					if var_498_1.prefab_name ~= "" and arg_495_1.actors_[var_498_1.prefab_name] ~= nil then
						local var_498_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_1.prefab_name].transform, "story_v_side_new_1101905", "1101905120", "story_v_side_new_1101905.awb")

						arg_495_1:RecordAudio("1101905120", var_498_6)
						arg_495_1:RecordAudio("1101905120", var_498_6)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905120", "story_v_side_new_1101905.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905120", "story_v_side_new_1101905.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_7 = math.max(var_498_0, arg_495_1.talkMaxDuration)

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_7 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - 0) / var_498_7

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= 0 + var_498_7 and arg_495_1.time_ < 0 + var_498_7 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play1101905121 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 1101905121
		arg_499_1.duration_ = 1

		SetActive(arg_499_1.tipsGo_, true)

		arg_499_1.tipsText_.text = StoryTipsCfg[101901].name

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"

			SetActive(arg_499_1.choicesGo_, true)

			for iter_500_0, iter_500_1 in ipairs(arg_499_1.choices_) do
				SetActive(iter_500_1.go, iter_500_0 <= 2)
			end

			arg_499_1.choices_[1].txt.text = arg_499_1:FormatText(StoryChoiceCfg[736].name)
			arg_499_1.choices_[2].txt.text = arg_499_1:FormatText(StoryChoiceCfg[737].name)
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play1101905122(arg_499_1)
			end

			if arg_501_0 == 2 then
				PlayerAction.UseStoryTrigger(1019013, 210190105, 1101905121, 2)
				arg_499_0:Play1101905123(arg_499_1)
			end

			arg_499_1:RecordChoiceLog(1101905121, 736, 737)
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1.allBtn_.enabled = false
			end

			if arg_499_1.time_ >= 0 + 0.5 and arg_499_1.time_ < 0 + 0.5 + arg_502_0 then
				arg_499_1.allBtn_.enabled = true
			end

			local var_502_0 = arg_499_1.actors_["1019ui_story"]

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 and not isNil(var_502_0) and arg_499_1.var_.characterEffect1019ui_story == nil then
				arg_499_1.var_.characterEffect1019ui_story = var_502_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_502_1 = 0.200000002980232

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_1 and not isNil(var_502_0) then
				if arg_499_1.var_.characterEffect1019ui_story and not isNil(var_502_0) then
					arg_499_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_499_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_499_1.time_ - 0) / var_502_1)
				end
			end

			if arg_499_1.time_ >= 0 + var_502_1 and arg_499_1.time_ < 0 + var_502_1 + arg_502_0 and not isNil(var_502_0) and arg_499_1.var_.characterEffect1019ui_story then
				arg_499_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_499_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play1101905122 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 1101905122
		arg_503_1.duration_ = 16.2

		local var_503_0 = {
			zh = 7.9,
			ja = 16.2
		}
		local var_503_1 = manager.audio:GetLocalizationFlag()

		if var_503_0[var_503_1] ~= nil then
			arg_503_1.duration_ = var_503_0[var_503_1]
		end

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play1101905124(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 and not isNil(arg_503_1.actors_["1019ui_story"]) and arg_503_1.var_.characterEffect1019ui_story == nil then
				arg_503_1.var_.characterEffect1019ui_story = arg_503_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_506_0 = 0.200000002980232

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_0 and not isNil(arg_503_1.actors_["1019ui_story"]) then
				if arg_503_1.var_.characterEffect1019ui_story and not isNil(arg_503_1.actors_["1019ui_story"]) then
					arg_503_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_503_1.time_ >= 0 + var_506_0 and arg_503_1.time_ < 0 + var_506_0 + arg_506_0 and not isNil(arg_503_1.actors_["1019ui_story"]) and arg_503_1.var_.characterEffect1019ui_story then
				arg_503_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_506_2 = 0
			local var_506_3 = 0.25

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_2 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				arg_503_1.leftNameTxt_.text = arg_503_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_4 = arg_503_1:GetWordFromCfg(1101905122)
				local var_506_5 = arg_503_1:FormatText(var_506_4.content)

				arg_503_1.text_.text = var_506_5

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_7 = 30 <= 0 and var_506_3 or var_506_3 * (utf8.len(var_506_5) / 30)

				if (30 <= 0 and var_506_3 or var_506_3 * (utf8.len(var_506_5) / 30)) > 0 and var_506_3 < var_506_7 then
					arg_503_1.talkMaxDuration = var_506_7

					if var_506_7 + var_506_2 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_7 + var_506_2
					end
				end

				arg_503_1.text_.text = var_506_5
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905122", "story_v_side_new_1101905.awb") ~= 0 then
					local var_506_8 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905122", "story_v_side_new_1101905.awb") / 1000

					if var_506_8 + var_506_2 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_8 + var_506_2
					end

					if var_506_4.prefab_name ~= "" and arg_503_1.actors_[var_506_4.prefab_name] ~= nil then
						local var_506_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_4.prefab_name].transform, "story_v_side_new_1101905", "1101905122", "story_v_side_new_1101905.awb")

						arg_503_1:RecordAudio("1101905122", var_506_9)
						arg_503_1:RecordAudio("1101905122", var_506_9)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905122", "story_v_side_new_1101905.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905122", "story_v_side_new_1101905.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_10 = math.max(var_506_3, arg_503_1.talkMaxDuration)

			if var_506_2 <= arg_503_1.time_ and arg_503_1.time_ < var_506_2 + var_506_10 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_2) / var_506_10

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_2 + var_506_10 and arg_503_1.time_ < var_506_2 + var_506_10 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play1101905124 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 1101905124
		arg_507_1.duration_ = 5

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play1101905125(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 and not isNil(arg_507_1.actors_["1019ui_story"]) and arg_507_1.var_.characterEffect1019ui_story == nil then
				arg_507_1.var_.characterEffect1019ui_story = arg_507_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_510_0 = 0.200000002980232

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_0 and not isNil(arg_507_1.actors_["1019ui_story"]) then
				if arg_507_1.var_.characterEffect1019ui_story and not isNil(arg_507_1.actors_["1019ui_story"]) then
					arg_507_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_507_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_507_1.time_ - 0) / var_510_0)
				end
			end

			if arg_507_1.time_ >= 0 + var_510_0 and arg_507_1.time_ < 0 + var_510_0 + arg_510_0 and not isNil(arg_507_1.actors_["1019ui_story"]) and arg_507_1.var_.characterEffect1019ui_story then
				arg_507_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_507_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_510_1 = 0
			local var_510_2 = 0.35

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_1 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				arg_507_1.leftNameTxt_.text = arg_507_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, true)
				arg_507_1.iconController_:SetSelectedState("hero")

				arg_507_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_507_1.callingController_:SetSelectedState("normal")

				arg_507_1.keyicon_.color = Color.New(1, 1, 1)
				arg_507_1.icon_.color = Color.New(1, 1, 1)

				local var_510_3 = arg_507_1:FormatText(arg_507_1:GetWordFromCfg(1101905124).content)

				arg_507_1.text_.text = var_510_3

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_5 = 18 <= 0 and var_510_2 or var_510_2 * (utf8.len(var_510_3) / 18)

				if (18 <= 0 and var_510_2 or var_510_2 * (utf8.len(var_510_3) / 18)) > 0 and var_510_2 < var_510_5 then
					arg_507_1.talkMaxDuration = var_510_5

					if var_510_5 + var_510_1 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_5 + var_510_1
					end
				end

				arg_507_1.text_.text = var_510_3
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_6 = math.max(var_510_2, arg_507_1.talkMaxDuration)

			if var_510_1 <= arg_507_1.time_ and arg_507_1.time_ < var_510_1 + var_510_6 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_1) / var_510_6

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_1 + var_510_6 and arg_507_1.time_ < var_510_1 + var_510_6 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play1101905125 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 1101905125
		arg_511_1.duration_ = 5.03

		local var_511_0 = {
			zh = 5.033,
			ja = 4.966
		}
		local var_511_1 = manager.audio:GetLocalizationFlag()

		if var_511_0[var_511_1] ~= nil then
			arg_511_1.duration_ = var_511_0[var_511_1]
		end

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play1101905126(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1.var_.moveOldPos1019ui_story = arg_511_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_514_0 = 0.001

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_0 then
				arg_511_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_511_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_511_1.time_ - 0) / var_514_0)
				arg_511_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_511_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_511_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_511_1.actors_["1019ui_story"].transform.position).z)
				arg_511_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_511_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_511_1.actors_["1019ui_story"].transform.localEulerAngles = arg_511_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_511_1.time_ >= 0 + var_514_0 and arg_511_1.time_ < 0 + var_514_0 + arg_514_0 then
				arg_511_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_511_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_511_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_511_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_511_1.actors_["1019ui_story"].transform.position).z)
				arg_511_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_511_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_511_1.actors_["1019ui_story"].transform.localEulerAngles = arg_511_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_514_1 = arg_511_1.actors_["1019ui_story"]

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 and not isNil(var_514_1) and arg_511_1.var_.characterEffect1019ui_story == nil then
				arg_511_1.var_.characterEffect1019ui_story = var_514_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_514_2 = 0.200000002980232

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_2 and not isNil(var_514_1) then
				if arg_511_1.var_.characterEffect1019ui_story and not isNil(var_514_1) then
					arg_511_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_511_1.time_ >= 0 + var_514_2 and arg_511_1.time_ < 0 + var_514_2 + arg_514_0 and not isNil(var_514_1) and arg_511_1.var_.characterEffect1019ui_story then
				arg_511_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_514_4 = 0
			local var_514_5 = 0.825

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_4 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				arg_511_1.leftNameTxt_.text = arg_511_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_6 = arg_511_1:GetWordFromCfg(1101905125)
				local var_514_7 = arg_511_1:FormatText(var_514_6.content)

				arg_511_1.text_.text = var_514_7

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_9 = 19 <= 0 and var_514_5 or var_514_5 * (utf8.len(var_514_7) / 19)

				if (19 <= 0 and var_514_5 or var_514_5 * (utf8.len(var_514_7) / 19)) > 0 and var_514_5 < var_514_9 then
					arg_511_1.talkMaxDuration = var_514_9

					if var_514_9 + var_514_4 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_9 + var_514_4
					end
				end

				arg_511_1.text_.text = var_514_7
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905125", "story_v_side_new_1101905.awb") ~= 0 then
					local var_514_10 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905125", "story_v_side_new_1101905.awb") / 1000

					if var_514_10 + var_514_4 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_10 + var_514_4
					end

					if var_514_6.prefab_name ~= "" and arg_511_1.actors_[var_514_6.prefab_name] ~= nil then
						local var_514_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_6.prefab_name].transform, "story_v_side_new_1101905", "1101905125", "story_v_side_new_1101905.awb")

						arg_511_1:RecordAudio("1101905125", var_514_11)
						arg_511_1:RecordAudio("1101905125", var_514_11)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905125", "story_v_side_new_1101905.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905125", "story_v_side_new_1101905.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_12 = math.max(var_514_5, arg_511_1.talkMaxDuration)

			if var_514_4 <= arg_511_1.time_ and arg_511_1.time_ < var_514_4 + var_514_12 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_4) / var_514_12

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_4 + var_514_12 and arg_511_1.time_ < var_514_4 + var_514_12 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_511_1:InitPlayNodeList()
	end,
	Play1101905126 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 1101905126
		arg_515_1.duration_ = 5

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play1101905127(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 and not isNil(arg_515_1.actors_["1019ui_story"]) and arg_515_1.var_.characterEffect1019ui_story == nil then
				arg_515_1.var_.characterEffect1019ui_story = arg_515_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_518_0 = 0.200000002980232

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_0 and not isNil(arg_515_1.actors_["1019ui_story"]) then
				if arg_515_1.var_.characterEffect1019ui_story and not isNil(arg_515_1.actors_["1019ui_story"]) then
					arg_515_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_515_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_515_1.time_ - 0) / var_518_0)
				end
			end

			if arg_515_1.time_ >= 0 + var_518_0 and arg_515_1.time_ < 0 + var_518_0 + arg_518_0 and not isNil(arg_515_1.actors_["1019ui_story"]) and arg_515_1.var_.characterEffect1019ui_story then
				arg_515_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_515_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_518_1 = 0
			local var_518_2 = 0.45

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= var_518_1 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, false)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_3 = arg_515_1:FormatText(arg_515_1:GetWordFromCfg(1101905126).content)

				arg_515_1.text_.text = var_518_3

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_5 = 24 <= 0 and var_518_2 or var_518_2 * (utf8.len(var_518_3) / 24)

				if (24 <= 0 and var_518_2 or var_518_2 * (utf8.len(var_518_3) / 24)) > 0 and var_518_2 < var_518_5 then
					arg_515_1.talkMaxDuration = var_518_5

					if var_518_5 + var_518_1 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_5 + var_518_1
					end
				end

				arg_515_1.text_.text = var_518_3
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)
				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_6 = math.max(var_518_2, arg_515_1.talkMaxDuration)

			if var_518_1 <= arg_515_1.time_ and arg_515_1.time_ < var_518_1 + var_518_6 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_1) / var_518_6

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_1 + var_518_6 and arg_515_1.time_ < var_518_1 + var_518_6 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play1101905127 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 1101905127
		arg_519_1.duration_ = 5

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play1101905128(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = 0.475

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				arg_519_1.leftNameTxt_.text = arg_519_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, true)
				arg_519_1.iconController_:SetSelectedState("hero")

				arg_519_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_519_1.callingController_:SetSelectedState("normal")

				arg_519_1.keyicon_.color = Color.New(1, 1, 1)
				arg_519_1.icon_.color = Color.New(1, 1, 1)

				local var_522_1 = arg_519_1:FormatText(arg_519_1:GetWordFromCfg(1101905127).content)

				arg_519_1.text_.text = var_522_1

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_3 = 15 <= 0 and var_522_0 or var_522_0 * (utf8.len(var_522_1) / 15)

				if (15 <= 0 and var_522_0 or var_522_0 * (utf8.len(var_522_1) / 15)) > 0 and var_522_0 < var_522_3 then
					arg_519_1.talkMaxDuration = var_522_3

					if var_522_3 + 0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_3 + 0
					end
				end

				arg_519_1.text_.text = var_522_1
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)
				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_4 = math.max(var_522_0, arg_519_1.talkMaxDuration)

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_4 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - 0) / var_522_4

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= 0 + var_522_4 and arg_519_1.time_ < 0 + var_522_4 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play1101905128 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 1101905128
		arg_523_1.duration_ = 4.4

		local var_523_0 = {
			zh = 3.7,
			ja = 4.4
		}
		local var_523_1 = manager.audio:GetLocalizationFlag()

		if var_523_0[var_523_1] ~= nil then
			arg_523_1.duration_ = var_523_0[var_523_1]
		end

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play1101905129(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 and not isNil(arg_523_1.actors_["1019ui_story"]) and arg_523_1.var_.characterEffect1019ui_story == nil then
				arg_523_1.var_.characterEffect1019ui_story = arg_523_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_526_0 = 0.200000002980232

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_0 and not isNil(arg_523_1.actors_["1019ui_story"]) then
				if arg_523_1.var_.characterEffect1019ui_story and not isNil(arg_523_1.actors_["1019ui_story"]) then
					arg_523_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_523_1.time_ >= 0 + var_526_0 and arg_523_1.time_ < 0 + var_526_0 + arg_526_0 and not isNil(arg_523_1.actors_["1019ui_story"]) and arg_523_1.var_.characterEffect1019ui_story then
				arg_523_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_526_2 = 0
			local var_526_3 = 0.6

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= var_526_2 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				arg_523_1.leftNameTxt_.text = arg_523_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_4 = arg_523_1:GetWordFromCfg(1101905128)
				local var_526_5 = arg_523_1:FormatText(var_526_4.content)

				arg_523_1.text_.text = var_526_5

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_7 = 16 <= 0 and var_526_3 or var_526_3 * (utf8.len(var_526_5) / 16)

				if (16 <= 0 and var_526_3 or var_526_3 * (utf8.len(var_526_5) / 16)) > 0 and var_526_3 < var_526_7 then
					arg_523_1.talkMaxDuration = var_526_7

					if var_526_7 + var_526_2 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_7 + var_526_2
					end
				end

				arg_523_1.text_.text = var_526_5
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905128", "story_v_side_new_1101905.awb") ~= 0 then
					local var_526_8 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905128", "story_v_side_new_1101905.awb") / 1000

					if var_526_8 + var_526_2 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_8 + var_526_2
					end

					if var_526_4.prefab_name ~= "" and arg_523_1.actors_[var_526_4.prefab_name] ~= nil then
						local var_526_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_523_1.actors_[var_526_4.prefab_name].transform, "story_v_side_new_1101905", "1101905128", "story_v_side_new_1101905.awb")

						arg_523_1:RecordAudio("1101905128", var_526_9)
						arg_523_1:RecordAudio("1101905128", var_526_9)
					else
						arg_523_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905128", "story_v_side_new_1101905.awb")
					end

					arg_523_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905128", "story_v_side_new_1101905.awb")
				end

				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_10 = math.max(var_526_3, arg_523_1.talkMaxDuration)

			if var_526_2 <= arg_523_1.time_ and arg_523_1.time_ < var_526_2 + var_526_10 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_2) / var_526_10

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_2 + var_526_10 and arg_523_1.time_ < var_526_2 + var_526_10 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play1101905129 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 1101905129
		arg_527_1.duration_ = 5

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play1101905130(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 and not isNil(arg_527_1.actors_["1019ui_story"]) and arg_527_1.var_.characterEffect1019ui_story == nil then
				arg_527_1.var_.characterEffect1019ui_story = arg_527_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_530_0 = 0.200000002980232

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_0 and not isNil(arg_527_1.actors_["1019ui_story"]) then
				if arg_527_1.var_.characterEffect1019ui_story and not isNil(arg_527_1.actors_["1019ui_story"]) then
					arg_527_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_527_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_527_1.time_ - 0) / var_530_0)
				end
			end

			if arg_527_1.time_ >= 0 + var_530_0 and arg_527_1.time_ < 0 + var_530_0 + arg_530_0 and not isNil(arg_527_1.actors_["1019ui_story"]) and arg_527_1.var_.characterEffect1019ui_story then
				arg_527_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_527_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_530_1 = 0
			local var_530_2 = 0.375

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= var_530_1 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				arg_527_1.leftNameTxt_.text = arg_527_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, true)
				arg_527_1.iconController_:SetSelectedState("hero")

				arg_527_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_527_1.callingController_:SetSelectedState("normal")

				arg_527_1.keyicon_.color = Color.New(1, 1, 1)
				arg_527_1.icon_.color = Color.New(1, 1, 1)

				local var_530_3 = arg_527_1:FormatText(arg_527_1:GetWordFromCfg(1101905129).content)

				arg_527_1.text_.text = var_530_3

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_5 = 59 <= 0 and var_530_2 or var_530_2 * (utf8.len(var_530_3) / 59)

				if (59 <= 0 and var_530_2 or var_530_2 * (utf8.len(var_530_3) / 59)) > 0 and var_530_2 < var_530_5 then
					arg_527_1.talkMaxDuration = var_530_5

					if var_530_5 + var_530_1 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_5 + var_530_1
					end
				end

				arg_527_1.text_.text = var_530_3
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)
				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_6 = math.max(var_530_2, arg_527_1.talkMaxDuration)

			if var_530_1 <= arg_527_1.time_ and arg_527_1.time_ < var_530_1 + var_530_6 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_1) / var_530_6

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_1 + var_530_6 and arg_527_1.time_ < var_530_1 + var_530_6 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play1101905130 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 1101905130
		arg_531_1.duration_ = 4.4

		local var_531_0 = {
			zh = 3.933,
			ja = 4.4
		}
		local var_531_1 = manager.audio:GetLocalizationFlag()

		if var_531_0[var_531_1] ~= nil then
			arg_531_1.duration_ = var_531_0[var_531_1]
		end

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play1101905131(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 and not isNil(arg_531_1.actors_["1019ui_story"]) and arg_531_1.var_.characterEffect1019ui_story == nil then
				arg_531_1.var_.characterEffect1019ui_story = arg_531_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_534_0 = 0.200000002980232

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_0 and not isNil(arg_531_1.actors_["1019ui_story"]) then
				if arg_531_1.var_.characterEffect1019ui_story and not isNil(arg_531_1.actors_["1019ui_story"]) then
					arg_531_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_531_1.time_ >= 0 + var_534_0 and arg_531_1.time_ < 0 + var_534_0 + arg_534_0 and not isNil(arg_531_1.actors_["1019ui_story"]) and arg_531_1.var_.characterEffect1019ui_story then
				arg_531_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_534_2 = 0
			local var_534_3 = 0.4

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= var_534_2 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				arg_531_1.leftNameTxt_.text = arg_531_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_4 = arg_531_1:GetWordFromCfg(1101905130)
				local var_534_5 = arg_531_1:FormatText(var_534_4.content)

				arg_531_1.text_.text = var_534_5

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_7 = 12 <= 0 and var_534_3 or var_534_3 * (utf8.len(var_534_5) / 12)

				if (12 <= 0 and var_534_3 or var_534_3 * (utf8.len(var_534_5) / 12)) > 0 and var_534_3 < var_534_7 then
					arg_531_1.talkMaxDuration = var_534_7

					if var_534_7 + var_534_2 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_7 + var_534_2
					end
				end

				arg_531_1.text_.text = var_534_5
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905130", "story_v_side_new_1101905.awb") ~= 0 then
					local var_534_8 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905130", "story_v_side_new_1101905.awb") / 1000

					if var_534_8 + var_534_2 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_8 + var_534_2
					end

					if var_534_4.prefab_name ~= "" and arg_531_1.actors_[var_534_4.prefab_name] ~= nil then
						local var_534_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_531_1.actors_[var_534_4.prefab_name].transform, "story_v_side_new_1101905", "1101905130", "story_v_side_new_1101905.awb")

						arg_531_1:RecordAudio("1101905130", var_534_9)
						arg_531_1:RecordAudio("1101905130", var_534_9)
					else
						arg_531_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905130", "story_v_side_new_1101905.awb")
					end

					arg_531_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905130", "story_v_side_new_1101905.awb")
				end

				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_10 = math.max(var_534_3, arg_531_1.talkMaxDuration)

			if var_534_2 <= arg_531_1.time_ and arg_531_1.time_ < var_534_2 + var_534_10 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_2) / var_534_10

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_2 + var_534_10 and arg_531_1.time_ < var_534_2 + var_534_10 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play1101905131 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 1101905131
		arg_535_1.duration_ = 5

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play1101905132(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 and not isNil(arg_535_1.actors_["1019ui_story"]) and arg_535_1.var_.characterEffect1019ui_story == nil then
				arg_535_1.var_.characterEffect1019ui_story = arg_535_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_538_0 = 0.200000002980232

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_0 and not isNil(arg_535_1.actors_["1019ui_story"]) then
				if arg_535_1.var_.characterEffect1019ui_story and not isNil(arg_535_1.actors_["1019ui_story"]) then
					arg_535_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_535_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_535_1.time_ - 0) / var_538_0)
				end
			end

			if arg_535_1.time_ >= 0 + var_538_0 and arg_535_1.time_ < 0 + var_538_0 + arg_538_0 and not isNil(arg_535_1.actors_["1019ui_story"]) and arg_535_1.var_.characterEffect1019ui_story then
				arg_535_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_535_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_538_1 = 0
			local var_538_2 = 1.45

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= var_538_1 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, false)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_3 = arg_535_1:FormatText(arg_535_1:GetWordFromCfg(1101905131).content)

				arg_535_1.text_.text = var_538_3

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_5 = 33 <= 0 and var_538_2 or var_538_2 * (utf8.len(var_538_3) / 33)

				if (33 <= 0 and var_538_2 or var_538_2 * (utf8.len(var_538_3) / 33)) > 0 and var_538_2 < var_538_5 then
					arg_535_1.talkMaxDuration = var_538_5

					if var_538_5 + var_538_1 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_5 + var_538_1
					end
				end

				arg_535_1.text_.text = var_538_3
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)
				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_6 = math.max(var_538_2, arg_535_1.talkMaxDuration)

			if var_538_1 <= arg_535_1.time_ and arg_535_1.time_ < var_538_1 + var_538_6 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_1) / var_538_6

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_1 + var_538_6 and arg_535_1.time_ < var_538_1 + var_538_6 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {}

		arg_535_1:InitPlayNodeList()
	end,
	Play1101905132 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 1101905132
		arg_539_1.duration_ = 5

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play1101905133(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 then
				arg_539_1:AudioAction("play", "effect", "se_story_122_03", "se_story_122_03_wind", "")
			end

			local var_542_1 = 0
			local var_542_2 = 0.3

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= var_542_1 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, false)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_539_1.iconTrs_.gameObject, false)
				arg_539_1.callingController_:SetSelectedState("normal")

				local var_542_3 = arg_539_1:FormatText(arg_539_1:GetWordFromCfg(1101905132).content)

				arg_539_1.text_.text = var_542_3

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_5 = 28 <= 0 and var_542_2 or var_542_2 * (utf8.len(var_542_3) / 28)

				if (28 <= 0 and var_542_2 or var_542_2 * (utf8.len(var_542_3) / 28)) > 0 and var_542_2 < var_542_5 then
					arg_539_1.talkMaxDuration = var_542_5

					if var_542_5 + var_542_1 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_5 + var_542_1
					end
				end

				arg_539_1.text_.text = var_542_3
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)
				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_6 = math.max(var_542_2, arg_539_1.talkMaxDuration)

			if var_542_1 <= arg_539_1.time_ and arg_539_1.time_ < var_542_1 + var_542_6 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_1) / var_542_6

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_1 + var_542_6 and arg_539_1.time_ < var_542_1 + var_542_6 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play1101905133 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 1101905133
		arg_543_1.duration_ = 8.63

		local var_543_0 = {
			zh = 8.633,
			ja = 7.3
		}
		local var_543_1 = manager.audio:GetLocalizationFlag()

		if var_543_0[var_543_1] ~= nil then
			arg_543_1.duration_ = var_543_0[var_543_1]
		end

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play1101905134(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 and not isNil(arg_543_1.actors_["1019ui_story"]) and arg_543_1.var_.characterEffect1019ui_story == nil then
				arg_543_1.var_.characterEffect1019ui_story = arg_543_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_546_0 = 0.200000002980232

			if 0 <= arg_543_1.time_ and arg_543_1.time_ < 0 + var_546_0 and not isNil(arg_543_1.actors_["1019ui_story"]) then
				if arg_543_1.var_.characterEffect1019ui_story and not isNil(arg_543_1.actors_["1019ui_story"]) then
					arg_543_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_543_1.time_ >= 0 + var_546_0 and arg_543_1.time_ < 0 + var_546_0 + arg_546_0 and not isNil(arg_543_1.actors_["1019ui_story"]) and arg_543_1.var_.characterEffect1019ui_story then
				arg_543_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_546_2 = 0
			local var_546_3 = 0.825

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= var_546_2 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				arg_543_1.leftNameTxt_.text = arg_543_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_4 = arg_543_1:GetWordFromCfg(1101905133)
				local var_546_5 = arg_543_1:FormatText(var_546_4.content)

				arg_543_1.text_.text = var_546_5

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_7 = 37 <= 0 and var_546_3 or var_546_3 * (utf8.len(var_546_5) / 37)

				if (37 <= 0 and var_546_3 or var_546_3 * (utf8.len(var_546_5) / 37)) > 0 and var_546_3 < var_546_7 then
					arg_543_1.talkMaxDuration = var_546_7

					if var_546_7 + var_546_2 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_7 + var_546_2
					end
				end

				arg_543_1.text_.text = var_546_5
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905133", "story_v_side_new_1101905.awb") ~= 0 then
					local var_546_8 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905133", "story_v_side_new_1101905.awb") / 1000

					if var_546_8 + var_546_2 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_8 + var_546_2
					end

					if var_546_4.prefab_name ~= "" and arg_543_1.actors_[var_546_4.prefab_name] ~= nil then
						local var_546_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_543_1.actors_[var_546_4.prefab_name].transform, "story_v_side_new_1101905", "1101905133", "story_v_side_new_1101905.awb")

						arg_543_1:RecordAudio("1101905133", var_546_9)
						arg_543_1:RecordAudio("1101905133", var_546_9)
					else
						arg_543_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905133", "story_v_side_new_1101905.awb")
					end

					arg_543_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905133", "story_v_side_new_1101905.awb")
				end

				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_10 = math.max(var_546_3, arg_543_1.talkMaxDuration)

			if var_546_2 <= arg_543_1.time_ and arg_543_1.time_ < var_546_2 + var_546_10 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_2) / var_546_10

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_2 + var_546_10 and arg_543_1.time_ < var_546_2 + var_546_10 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {}

		arg_543_1:InitPlayNodeList()
	end,
	Play1101905134 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 1101905134
		arg_547_1.duration_ = 5

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play1101905135(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 and not isNil(arg_547_1.actors_["1019ui_story"]) and arg_547_1.var_.characterEffect1019ui_story == nil then
				arg_547_1.var_.characterEffect1019ui_story = arg_547_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_550_0 = 0.200000002980232

			if 0 <= arg_547_1.time_ and arg_547_1.time_ < 0 + var_550_0 and not isNil(arg_547_1.actors_["1019ui_story"]) then
				if arg_547_1.var_.characterEffect1019ui_story and not isNil(arg_547_1.actors_["1019ui_story"]) then
					arg_547_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_547_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_547_1.time_ - 0) / var_550_0)
				end
			end

			if arg_547_1.time_ >= 0 + var_550_0 and arg_547_1.time_ < 0 + var_550_0 + arg_550_0 and not isNil(arg_547_1.actors_["1019ui_story"]) and arg_547_1.var_.characterEffect1019ui_story then
				arg_547_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_547_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_550_1 = 0
			local var_550_2 = 0.7

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= var_550_1 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, true)

				arg_547_1.leftNameTxt_.text = arg_547_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_547_1.leftNameTxt_.transform)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1.leftNameTxt_.text)
				SetActive(arg_547_1.iconTrs_.gameObject, true)
				arg_547_1.iconController_:SetSelectedState("hero")

				arg_547_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_547_1.callingController_:SetSelectedState("normal")

				arg_547_1.keyicon_.color = Color.New(1, 1, 1)
				arg_547_1.icon_.color = Color.New(1, 1, 1)

				local var_550_3 = arg_547_1:FormatText(arg_547_1:GetWordFromCfg(1101905134).content)

				arg_547_1.text_.text = var_550_3

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_5 = 10 <= 0 and var_550_2 or var_550_2 * (utf8.len(var_550_3) / 10)

				if (10 <= 0 and var_550_2 or var_550_2 * (utf8.len(var_550_3) / 10)) > 0 and var_550_2 < var_550_5 then
					arg_547_1.talkMaxDuration = var_550_5

					if var_550_5 + var_550_1 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_5 + var_550_1
					end
				end

				arg_547_1.text_.text = var_550_3
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)
				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_6 = math.max(var_550_2, arg_547_1.talkMaxDuration)

			if var_550_1 <= arg_547_1.time_ and arg_547_1.time_ < var_550_1 + var_550_6 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - var_550_1) / var_550_6

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= var_550_1 + var_550_6 and arg_547_1.time_ < var_550_1 + var_550_6 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {}

		arg_547_1:InitPlayNodeList()
	end,
	Play1101905135 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 1101905135
		arg_551_1.duration_ = 5

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play1101905136(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			local var_554_0 = 0.925

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, false)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_551_1.iconTrs_.gameObject, false)
				arg_551_1.callingController_:SetSelectedState("normal")

				local var_554_1 = arg_551_1:FormatText(arg_551_1:GetWordFromCfg(1101905135).content)

				arg_551_1.text_.text = var_554_1

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_3 = 23 <= 0 and var_554_0 or var_554_0 * (utf8.len(var_554_1) / 23)

				if (23 <= 0 and var_554_0 or var_554_0 * (utf8.len(var_554_1) / 23)) > 0 and var_554_0 < var_554_3 then
					arg_551_1.talkMaxDuration = var_554_3

					if var_554_3 + 0 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_3 + 0
					end
				end

				arg_551_1.text_.text = var_554_1
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)
				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_4 = math.max(var_554_0, arg_551_1.talkMaxDuration)

			if 0 <= arg_551_1.time_ and arg_551_1.time_ < 0 + var_554_4 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - 0) / var_554_4

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= 0 + var_554_4 and arg_551_1.time_ < 0 + var_554_4 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {}

		arg_551_1:InitPlayNodeList()
	end,
	Play1101905136 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 1101905136
		arg_555_1.duration_ = 5

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play1101905137(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			local var_558_0 = 0.25

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, true)

				arg_555_1.leftNameTxt_.text = arg_555_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_555_1.leftNameTxt_.transform)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1.leftNameTxt_.text)
				SetActive(arg_555_1.iconTrs_.gameObject, true)
				arg_555_1.iconController_:SetSelectedState("hero")

				arg_555_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_555_1.callingController_:SetSelectedState("normal")

				arg_555_1.keyicon_.color = Color.New(1, 1, 1)
				arg_555_1.icon_.color = Color.New(1, 1, 1)

				local var_558_1 = arg_555_1:FormatText(arg_555_1:GetWordFromCfg(1101905136).content)

				arg_555_1.text_.text = var_558_1

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_3 = 13 <= 0 and var_558_0 or var_558_0 * (utf8.len(var_558_1) / 13)

				if (13 <= 0 and var_558_0 or var_558_0 * (utf8.len(var_558_1) / 13)) > 0 and var_558_0 < var_558_3 then
					arg_555_1.talkMaxDuration = var_558_3

					if var_558_3 + 0 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_3 + 0
					end
				end

				arg_555_1.text_.text = var_558_1
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)
				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_4 = math.max(var_558_0, arg_555_1.talkMaxDuration)

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_4 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - 0) / var_558_4

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= 0 + var_558_4 and arg_555_1.time_ < 0 + var_558_4 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {}

		arg_555_1:InitPlayNodeList()
	end,
	Play1101905137 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 1101905137
		arg_559_1.duration_ = 5

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play1101905138(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			local var_562_0 = 0.575

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, false)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_559_1.iconTrs_.gameObject, false)
				arg_559_1.callingController_:SetSelectedState("normal")

				local var_562_1 = arg_559_1:FormatText(arg_559_1:GetWordFromCfg(1101905137).content)

				arg_559_1.text_.text = var_562_1

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_3 = 48 <= 0 and var_562_0 or var_562_0 * (utf8.len(var_562_1) / 48)

				if (48 <= 0 and var_562_0 or var_562_0 * (utf8.len(var_562_1) / 48)) > 0 and var_562_0 < var_562_3 then
					arg_559_1.talkMaxDuration = var_562_3

					if var_562_3 + 0 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_3 + 0
					end
				end

				arg_559_1.text_.text = var_562_1
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)
				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_4 = math.max(var_562_0, arg_559_1.talkMaxDuration)

			if 0 <= arg_559_1.time_ and arg_559_1.time_ < 0 + var_562_4 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - 0) / var_562_4

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= 0 + var_562_4 and arg_559_1.time_ < 0 + var_562_4 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {}

		arg_559_1:InitPlayNodeList()
	end,
	Play1101905138 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 1101905138
		arg_563_1.duration_ = 1

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"

			SetActive(arg_563_1.choicesGo_, true)

			for iter_564_0, iter_564_1 in ipairs(arg_563_1.choices_) do
				SetActive(iter_564_1.go, iter_564_0 <= 2)
			end

			arg_563_1.choices_[1].txt.text = arg_563_1:FormatText(StoryChoiceCfg[738].name)
			arg_563_1.choices_[2].txt.text = arg_563_1:FormatText(StoryChoiceCfg[739].name)
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play1101905139(arg_563_1)
			end

			if arg_565_0 == 2 then
				arg_563_0:Play1101905139(arg_563_1)
			end

			arg_563_1:RecordChoiceLog(1101905138, 738, 739)
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 then
				arg_563_1.allBtn_.enabled = false
			end

			if arg_563_1.time_ >= 0 + 0.5 and arg_563_1.time_ < 0 + 0.5 + arg_566_0 then
				arg_563_1.allBtn_.enabled = true
			end
		end

		arg_563_1.nodeConfigList_ = {}

		arg_563_1:InitPlayNodeList()
	end,
	Play1101905139 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 1101905139
		arg_567_1.duration_ = 2.17

		local var_567_0 = {
			zh = 1.999999999999,
			ja = 2.166
		}
		local var_567_1 = manager.audio:GetLocalizationFlag()

		if var_567_0[var_567_1] ~= nil then
			arg_567_1.duration_ = var_567_0[var_567_1]
		end

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play1101905140(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			if 0 < arg_567_1.time_ and arg_567_1.time_ <= 0 + arg_570_0 then
				arg_567_1.var_.moveOldPos1019ui_story = arg_567_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_570_0 = 0.001

			if 0 <= arg_567_1.time_ and arg_567_1.time_ < 0 + var_570_0 then
				arg_567_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_567_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_567_1.time_ - 0) / var_570_0)
				arg_567_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_567_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_567_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_567_1.actors_["1019ui_story"].transform.position).z)
				arg_567_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_567_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_567_1.actors_["1019ui_story"].transform.localEulerAngles = arg_567_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_567_1.time_ >= 0 + var_570_0 and arg_567_1.time_ < 0 + var_570_0 + arg_570_0 then
				arg_567_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_567_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_567_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_567_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_567_1.actors_["1019ui_story"].transform.position).z)
				arg_567_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_567_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_567_1.actors_["1019ui_story"].transform.localEulerAngles = arg_567_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_570_1 = arg_567_1.actors_["1019ui_story"]

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= 0 + arg_570_0 and not isNil(var_570_1) and arg_567_1.var_.characterEffect1019ui_story == nil then
				arg_567_1.var_.characterEffect1019ui_story = var_570_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_570_2 = 0.200000002980232

			if 0 <= arg_567_1.time_ and arg_567_1.time_ < 0 + var_570_2 and not isNil(var_570_1) then
				if arg_567_1.var_.characterEffect1019ui_story and not isNil(var_570_1) then
					arg_567_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_567_1.time_ >= 0 + var_570_2 and arg_567_1.time_ < 0 + var_570_2 + arg_570_0 and not isNil(var_570_1) and arg_567_1.var_.characterEffect1019ui_story then
				arg_567_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_570_4 = "1019ui_story"

			if arg_567_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_570_5 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_567_1.stage_.transform)

				var_570_5.name = var_570_4
				var_570_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_567_1.actors_[var_570_4] = var_570_5

				local var_570_6 = var_570_5:GetComponentInChildren(typeof(CharacterEffect))

				var_570_6.enabled = true

				local var_570_7 = GameObjectTools.GetOrAddComponent(var_570_5, typeof(DynamicBoneHelper))

				if var_570_7 then
					var_570_7:EnableDynamicBone(false)
				end

				arg_567_1:ShowWeapon(var_570_6.transform, false)

				arg_567_1.var_[var_570_4 .. "Animator"] = var_570_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_567_1.var_[var_570_4 .. "Animator"].applyRootMotion = true
				arg_567_1.var_[var_570_4 .. "LipSync"] = var_570_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= 0 + arg_570_0 then
				arg_567_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_570_8 = "1019ui_story"

			if arg_567_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_570_9 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_567_1.stage_.transform)

				var_570_9.name = var_570_8
				var_570_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_567_1.actors_[var_570_8] = var_570_9

				local var_570_10 = var_570_9:GetComponentInChildren(typeof(CharacterEffect))

				var_570_10.enabled = true

				local var_570_11 = GameObjectTools.GetOrAddComponent(var_570_9, typeof(DynamicBoneHelper))

				if var_570_11 then
					var_570_11:EnableDynamicBone(false)
				end

				arg_567_1:ShowWeapon(var_570_10.transform, false)

				arg_567_1.var_[var_570_8 .. "Animator"] = var_570_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_567_1.var_[var_570_8 .. "Animator"].applyRootMotion = true
				arg_567_1.var_[var_570_8 .. "LipSync"] = var_570_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= 0 + arg_570_0 then
				arg_567_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_570_12 = 0
			local var_570_13 = 1.2

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= var_570_12 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, true)

				arg_567_1.leftNameTxt_.text = arg_567_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_567_1.leftNameTxt_.transform)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1.leftNameTxt_.text)
				SetActive(arg_567_1.iconTrs_.gameObject, false)
				arg_567_1.callingController_:SetSelectedState("normal")

				local var_570_14 = arg_567_1:GetWordFromCfg(1101905139)
				local var_570_15 = arg_567_1:FormatText(var_570_14.content)

				arg_567_1.text_.text = var_570_15

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_17 = 6 <= 0 and var_570_13 or var_570_13 * (utf8.len(var_570_15) / 6)

				if (6 <= 0 and var_570_13 or var_570_13 * (utf8.len(var_570_15) / 6)) > 0 and var_570_13 < var_570_17 then
					arg_567_1.talkMaxDuration = var_570_17

					if var_570_17 + var_570_12 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_17 + var_570_12
					end
				end

				arg_567_1.text_.text = var_570_15
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905139", "story_v_side_new_1101905.awb") ~= 0 then
					local var_570_18 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905139", "story_v_side_new_1101905.awb") / 1000

					if var_570_18 + var_570_12 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_18 + var_570_12
					end

					if var_570_14.prefab_name ~= "" and arg_567_1.actors_[var_570_14.prefab_name] ~= nil then
						local var_570_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_567_1.actors_[var_570_14.prefab_name].transform, "story_v_side_new_1101905", "1101905139", "story_v_side_new_1101905.awb")

						arg_567_1:RecordAudio("1101905139", var_570_19)
						arg_567_1:RecordAudio("1101905139", var_570_19)
					else
						arg_567_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905139", "story_v_side_new_1101905.awb")
					end

					arg_567_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905139", "story_v_side_new_1101905.awb")
				end

				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_20 = math.max(var_570_13, arg_567_1.talkMaxDuration)

			if var_570_12 <= arg_567_1.time_ and arg_567_1.time_ < var_570_12 + var_570_20 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - var_570_12) / var_570_20

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= var_570_12 + var_570_20 and arg_567_1.time_ < var_570_12 + var_570_20 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_567_1:InitPlayNodeList()
	end,
	Play1101905140 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 1101905140
		arg_571_1.duration_ = 5

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play1101905141(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			if 0 < arg_571_1.time_ and arg_571_1.time_ <= 0 + arg_574_0 and not isNil(arg_571_1.actors_["1019ui_story"]) and arg_571_1.var_.characterEffect1019ui_story == nil then
				arg_571_1.var_.characterEffect1019ui_story = arg_571_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_574_0 = 0.200000002980232

			if 0 <= arg_571_1.time_ and arg_571_1.time_ < 0 + var_574_0 and not isNil(arg_571_1.actors_["1019ui_story"]) then
				if arg_571_1.var_.characterEffect1019ui_story and not isNil(arg_571_1.actors_["1019ui_story"]) then
					arg_571_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_571_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_571_1.time_ - 0) / var_574_0)
				end
			end

			if arg_571_1.time_ >= 0 + var_574_0 and arg_571_1.time_ < 0 + var_574_0 + arg_574_0 and not isNil(arg_571_1.actors_["1019ui_story"]) and arg_571_1.var_.characterEffect1019ui_story then
				arg_571_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_571_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_574_1 = 0
			local var_574_2 = 0.125

			if 0 < arg_571_1.time_ and arg_571_1.time_ <= var_574_1 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, true)

				arg_571_1.leftNameTxt_.text = arg_571_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_571_1.leftNameTxt_.transform)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1.leftNameTxt_.text)
				SetActive(arg_571_1.iconTrs_.gameObject, true)
				arg_571_1.iconController_:SetSelectedState("hero")

				arg_571_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_571_1.callingController_:SetSelectedState("normal")

				arg_571_1.keyicon_.color = Color.New(1, 1, 1)
				arg_571_1.icon_.color = Color.New(1, 1, 1)

				local var_574_3 = arg_571_1:FormatText(arg_571_1:GetWordFromCfg(1101905140).content)

				arg_571_1.text_.text = var_574_3

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_5 = 16 <= 0 and var_574_2 or var_574_2 * (utf8.len(var_574_3) / 16)

				if (16 <= 0 and var_574_2 or var_574_2 * (utf8.len(var_574_3) / 16)) > 0 and var_574_2 < var_574_5 then
					arg_571_1.talkMaxDuration = var_574_5

					if var_574_5 + var_574_1 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_5 + var_574_1
					end
				end

				arg_571_1.text_.text = var_574_3
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)
				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_6 = math.max(var_574_2, arg_571_1.talkMaxDuration)

			if var_574_1 <= arg_571_1.time_ and arg_571_1.time_ < var_574_1 + var_574_6 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - var_574_1) / var_574_6

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= var_574_1 + var_574_6 and arg_571_1.time_ < var_574_1 + var_574_6 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {}

		arg_571_1:InitPlayNodeList()
	end,
	Play1101905141 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 1101905141
		arg_575_1.duration_ = 7

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play1101905142(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 then
				arg_575_1.mask_.enabled = true
				arg_575_1.mask_.raycastTarget = true

				arg_575_1:SetGaussion(false)
			end

			local var_578_0 = 1

			if 0 <= arg_575_1.time_ and arg_575_1.time_ < 0 + var_578_0 then
				local var_578_1 = Color.New(0, 0, 0)

				var_578_1.a = Mathf.Lerp(0, 1, (arg_575_1.time_ - 0) / var_578_0)
				arg_575_1.mask_.color = var_578_1
			end

			if arg_575_1.time_ >= 0 + var_578_0 and arg_575_1.time_ < 0 + var_578_0 + arg_578_0 then
				local var_578_2 = Color.New(0, 0, 0)

				var_578_2.a = 1
				arg_575_1.mask_.color = var_578_2
			end

			local var_578_3 = 1

			if 1 < arg_575_1.time_ and arg_575_1.time_ <= var_578_3 + arg_578_0 then
				arg_575_1.mask_.enabled = true
				arg_575_1.mask_.raycastTarget = true

				arg_575_1:SetGaussion(false)
			end

			local var_578_4 = 1

			if var_578_3 <= arg_575_1.time_ and arg_575_1.time_ < var_578_3 + var_578_4 then
				local var_578_5 = Color.New(0, 0, 0)

				var_578_5.a = Mathf.Lerp(1, 0, (arg_575_1.time_ - var_578_3) / var_578_4)
				arg_575_1.mask_.color = var_578_5
			end

			if arg_575_1.time_ >= var_578_3 + var_578_4 and arg_575_1.time_ < var_578_3 + var_578_4 + arg_578_0 then
				local var_578_6 = Color.New(0, 0, 0)

				arg_575_1.mask_.enabled = false
				var_578_6.a = 0
				arg_575_1.mask_.color = var_578_6
			end

			local var_578_7 = arg_575_1.actors_["1019ui_story"].transform

			if 0.966 < arg_575_1.time_ and arg_575_1.time_ <= 0.966 + arg_578_0 then
				arg_575_1.var_.moveOldPos1019ui_story = var_578_7.localPosition
			end

			local var_578_8 = 0.001

			if 0.966 <= arg_575_1.time_ and arg_575_1.time_ < 0.966 + var_578_8 then
				var_578_7.localPosition = Vector3.Lerp(arg_575_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_575_1.time_ - 0.966) / var_578_8)
				var_578_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_578_7.position).x, (manager.ui.mainCamera.transform.position - var_578_7.position).y, (manager.ui.mainCamera.transform.position - var_578_7.position).z)
				var_578_7.localEulerAngles.z = 0
				var_578_7.localEulerAngles.x = 0
				var_578_7.localEulerAngles = var_578_7.localEulerAngles
			end

			if arg_575_1.time_ >= 0.966 + var_578_8 and arg_575_1.time_ < 0.966 + var_578_8 + arg_578_0 then
				var_578_7.localPosition = Vector3.New(0, 100, 0)
				var_578_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_578_7.position).x, (manager.ui.mainCamera.transform.position - var_578_7.position).y, (manager.ui.mainCamera.transform.position - var_578_7.position).z)
				var_578_7.localEulerAngles.z = 0
				var_578_7.localEulerAngles.x = 0
				var_578_7.localEulerAngles = var_578_7.localEulerAngles
			end

			if arg_575_1.frameCnt_ <= 1 then
				arg_575_1.dialog_:SetActive(false)
			end

			local var_578_9 = 2
			local var_578_10 = 0.15

			if 2 < arg_575_1.time_ and arg_575_1.time_ <= var_578_9 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0

				arg_575_1.dialog_:SetActive(true)

				arg_575_1.dialogCg_.alpha = 0

				local var_578_11 = LeanTween.value(arg_575_1.dialog_, 0, 1, 0.3)

				var_578_11:setOnUpdate(LuaHelper.FloatAction(function(arg_579_0)
					arg_575_1.dialogCg_.alpha = arg_579_0
				end))
				var_578_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_575_1.dialog_)
					var_578_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_575_1.duration_ = arg_575_1.duration_ + 0.3

				SetActive(arg_575_1.leftNameGo_, false)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_575_1.iconTrs_.gameObject, false)
				arg_575_1.callingController_:SetSelectedState("normal")

				local var_578_12 = arg_575_1:FormatText(arg_575_1:GetWordFromCfg(1101905141).content)

				arg_575_1.text_.text = var_578_12

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_14 = 6 <= 0 and var_578_10 or var_578_10 * (utf8.len(var_578_12) / 6)

				if (6 <= 0 and var_578_10 or var_578_10 * (utf8.len(var_578_12) / 6)) > 0 and var_578_10 < var_578_14 then
					arg_575_1.talkMaxDuration = var_578_14
					var_578_9 = var_578_9 + 0.3

					if var_578_14 + var_578_9 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_14 + var_578_9
					end
				end

				arg_575_1.text_.text = var_578_12
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)
				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_15 = var_578_9 + 0.3
			local var_578_16 = math.max(var_578_10, arg_575_1.talkMaxDuration)

			if var_578_9 + 0.3 <= arg_575_1.time_ and arg_575_1.time_ < var_578_15 + var_578_16 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - var_578_15) / var_578_16

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= var_578_15 + var_578_16 and arg_575_1.time_ < var_578_15 + var_578_16 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_575_1:InitPlayNodeList()
	end,
	Play1101905142 = function(arg_581_0, arg_581_1)
		arg_581_1.time_ = 0
		arg_581_1.frameCnt_ = 0
		arg_581_1.state_ = "playing"
		arg_581_1.curTalkId_ = 1101905142
		arg_581_1.duration_ = 5

		SetActive(arg_581_1.tipsGo_, false)

		function arg_581_1.onSingleLineFinish_()
			arg_581_1.onSingleLineUpdate_ = nil
			arg_581_1.onSingleLineFinish_ = nil
			arg_581_1.state_ = "waiting"
		end

		function arg_581_1.playNext_(arg_583_0)
			if arg_583_0 == 1 then
				arg_581_0:Play1101905143(arg_581_1)
			end
		end

		function arg_581_1.onSingleLineUpdate_(arg_584_0)
			local var_584_0 = 0.15

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 then
				arg_581_1.talkMaxDuration = 0
				arg_581_1.dialogCg_.alpha = 1

				arg_581_1.dialog_:SetActive(true)
				SetActive(arg_581_1.leftNameGo_, true)

				arg_581_1.leftNameTxt_.text = arg_581_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_581_1.leftNameTxt_.transform)

				arg_581_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_581_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_581_1:RecordName(arg_581_1.leftNameTxt_.text)
				SetActive(arg_581_1.iconTrs_.gameObject, true)
				arg_581_1.iconController_:SetSelectedState("hero")

				arg_581_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_581_1.callingController_:SetSelectedState("normal")

				arg_581_1.keyicon_.color = Color.New(1, 1, 1)
				arg_581_1.icon_.color = Color.New(1, 1, 1)

				local var_584_1 = arg_581_1:FormatText(arg_581_1:GetWordFromCfg(1101905142).content)

				arg_581_1.text_.text = var_584_1

				LuaForUtil.ClearLinePrefixSymbol(arg_581_1.text_)

				local var_584_3 = 24 <= 0 and var_584_0 or var_584_0 * (utf8.len(var_584_1) / 24)

				if (24 <= 0 and var_584_0 or var_584_0 * (utf8.len(var_584_1) / 24)) > 0 and var_584_0 < var_584_3 then
					arg_581_1.talkMaxDuration = var_584_3

					if var_584_3 + 0 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_3 + 0
					end
				end

				arg_581_1.text_.text = var_584_1
				arg_581_1.typewritter.percent = 0

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(false)
				arg_581_1:RecordContent(arg_581_1.text_.text)
			end

			local var_584_4 = math.max(var_584_0, arg_581_1.talkMaxDuration)

			if 0 <= arg_581_1.time_ and arg_581_1.time_ < 0 + var_584_4 then
				arg_581_1.typewritter.percent = (arg_581_1.time_ - 0) / var_584_4

				arg_581_1.typewritter:SetDirty()
			end

			if arg_581_1.time_ >= 0 + var_584_4 and arg_581_1.time_ < 0 + var_584_4 + arg_584_0 then
				arg_581_1.typewritter.percent = 1

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(true)
			end
		end

		arg_581_1.nodeConfigList_ = {}

		arg_581_1:InitPlayNodeList()
	end,
	Play1101905143 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 1101905143
		arg_585_1.duration_ = 5

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play1101905144(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			local var_588_0 = 0.4

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, true)

				arg_585_1.leftNameTxt_.text = arg_585_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_585_1.leftNameTxt_.transform)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1.leftNameTxt_.text)
				SetActive(arg_585_1.iconTrs_.gameObject, true)
				arg_585_1.iconController_:SetSelectedState("hero")

				arg_585_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_585_1.callingController_:SetSelectedState("normal")

				arg_585_1.keyicon_.color = Color.New(1, 1, 1)
				arg_585_1.icon_.color = Color.New(1, 1, 1)

				local var_588_1 = arg_585_1:FormatText(arg_585_1:GetWordFromCfg(1101905143).content)

				arg_585_1.text_.text = var_588_1

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_3 = 23 <= 0 and var_588_0 or var_588_0 * (utf8.len(var_588_1) / 23)

				if (23 <= 0 and var_588_0 or var_588_0 * (utf8.len(var_588_1) / 23)) > 0 and var_588_0 < var_588_3 then
					arg_585_1.talkMaxDuration = var_588_3

					if var_588_3 + 0 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_3 + 0
					end
				end

				arg_585_1.text_.text = var_588_1
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)
				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_4 = math.max(var_588_0, arg_585_1.talkMaxDuration)

			if 0 <= arg_585_1.time_ and arg_585_1.time_ < 0 + var_588_4 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - 0) / var_588_4

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= 0 + var_588_4 and arg_585_1.time_ < 0 + var_588_4 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {}

		arg_585_1:InitPlayNodeList()
	end,
	Play1101905144 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 1101905144
		arg_589_1.duration_ = 5

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play1101905145(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			local var_592_0 = 0.15

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, true)

				arg_589_1.leftNameTxt_.text = arg_589_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_589_1.leftNameTxt_.transform)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1.leftNameTxt_.text)
				SetActive(arg_589_1.iconTrs_.gameObject, true)
				arg_589_1.iconController_:SetSelectedState("hero")

				arg_589_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_589_1.callingController_:SetSelectedState("normal")

				arg_589_1.keyicon_.color = Color.New(1, 1, 1)
				arg_589_1.icon_.color = Color.New(1, 1, 1)

				local var_592_1 = arg_589_1:FormatText(arg_589_1:GetWordFromCfg(1101905144).content)

				arg_589_1.text_.text = var_592_1

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_3 = 26 <= 0 and var_592_0 or var_592_0 * (utf8.len(var_592_1) / 26)

				if (26 <= 0 and var_592_0 or var_592_0 * (utf8.len(var_592_1) / 26)) > 0 and var_592_0 < var_592_3 then
					arg_589_1.talkMaxDuration = var_592_3

					if var_592_3 + 0 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_3 + 0
					end
				end

				arg_589_1.text_.text = var_592_1
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)
				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_4 = math.max(var_592_0, arg_589_1.talkMaxDuration)

			if 0 <= arg_589_1.time_ and arg_589_1.time_ < 0 + var_592_4 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - 0) / var_592_4

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= 0 + var_592_4 and arg_589_1.time_ < 0 + var_592_4 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {}

		arg_589_1:InitPlayNodeList()
	end,
	Play1101905145 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 1101905145
		arg_593_1.duration_ = 5

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play1101905146(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			local var_596_0 = 0.6

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= 0 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0
				arg_593_1.dialogCg_.alpha = 1

				arg_593_1.dialog_:SetActive(true)
				SetActive(arg_593_1.leftNameGo_, false)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_593_1.iconTrs_.gameObject, false)
				arg_593_1.callingController_:SetSelectedState("normal")

				local var_596_1 = arg_593_1:FormatText(arg_593_1:GetWordFromCfg(1101905145).content)

				arg_593_1.text_.text = var_596_1

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_3 = 27 <= 0 and var_596_0 or var_596_0 * (utf8.len(var_596_1) / 27)

				if (27 <= 0 and var_596_0 or var_596_0 * (utf8.len(var_596_1) / 27)) > 0 and var_596_0 < var_596_3 then
					arg_593_1.talkMaxDuration = var_596_3

					if var_596_3 + 0 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_3 + 0
					end
				end

				arg_593_1.text_.text = var_596_1
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)
				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_4 = math.max(var_596_0, arg_593_1.talkMaxDuration)

			if 0 <= arg_593_1.time_ and arg_593_1.time_ < 0 + var_596_4 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - 0) / var_596_4

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= 0 + var_596_4 and arg_593_1.time_ < 0 + var_596_4 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {}

		arg_593_1:InitPlayNodeList()
	end,
	Play1101905146 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 1101905146
		arg_597_1.duration_ = 2.2

		local var_597_0 = {
			zh = 1.999999999999,
			ja = 2.2
		}
		local var_597_1 = manager.audio:GetLocalizationFlag()

		if var_597_0[var_597_1] ~= nil then
			arg_597_1.duration_ = var_597_0[var_597_1]
		end

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
		end

		function arg_597_1.playNext_(arg_599_0)
			if arg_599_0 == 1 then
				arg_597_0:Play1101905147(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			if 0 < arg_597_1.time_ and arg_597_1.time_ <= 0 + arg_600_0 then
				arg_597_1.var_.moveOldPos1019ui_story = arg_597_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_600_0 = 0.001

			if 0 <= arg_597_1.time_ and arg_597_1.time_ < 0 + var_600_0 then
				arg_597_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_597_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_597_1.time_ - 0) / var_600_0)
				arg_597_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_597_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_597_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_597_1.actors_["1019ui_story"].transform.position).z)
				arg_597_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_597_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_597_1.actors_["1019ui_story"].transform.localEulerAngles = arg_597_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_597_1.time_ >= 0 + var_600_0 and arg_597_1.time_ < 0 + var_600_0 + arg_600_0 then
				arg_597_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_597_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_597_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_597_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_597_1.actors_["1019ui_story"].transform.position).z)
				arg_597_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_597_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_597_1.actors_["1019ui_story"].transform.localEulerAngles = arg_597_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_600_1 = arg_597_1.actors_["1019ui_story"]

			if 0 < arg_597_1.time_ and arg_597_1.time_ <= 0 + arg_600_0 and not isNil(var_600_1) and arg_597_1.var_.characterEffect1019ui_story == nil then
				arg_597_1.var_.characterEffect1019ui_story = var_600_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_600_2 = 0.200000002980232

			if 0 <= arg_597_1.time_ and arg_597_1.time_ < 0 + var_600_2 and not isNil(var_600_1) then
				if arg_597_1.var_.characterEffect1019ui_story and not isNil(var_600_1) then
					arg_597_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_597_1.time_ >= 0 + var_600_2 and arg_597_1.time_ < 0 + var_600_2 + arg_600_0 and not isNil(var_600_1) and arg_597_1.var_.characterEffect1019ui_story then
				arg_597_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_597_1.time_ and arg_597_1.time_ <= 0 + arg_600_0 then
				arg_597_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_597_1.time_ and arg_597_1.time_ <= 0 + arg_600_0 then
				arg_597_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_600_4 = 0
			local var_600_5 = 0.575

			if 0 < arg_597_1.time_ and arg_597_1.time_ <= var_600_4 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0
				arg_597_1.dialogCg_.alpha = 1

				arg_597_1.dialog_:SetActive(true)
				SetActive(arg_597_1.leftNameGo_, true)

				arg_597_1.leftNameTxt_.text = arg_597_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_597_1.leftNameTxt_.transform)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1.leftNameTxt_.text)
				SetActive(arg_597_1.iconTrs_.gameObject, false)
				arg_597_1.callingController_:SetSelectedState("normal")

				local var_600_6 = arg_597_1:GetWordFromCfg(1101905146)
				local var_600_7 = arg_597_1:FormatText(var_600_6.content)

				arg_597_1.text_.text = var_600_7

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_9 = 2 <= 0 and var_600_5 or var_600_5 * (utf8.len(var_600_7) / 2)

				if (2 <= 0 and var_600_5 or var_600_5 * (utf8.len(var_600_7) / 2)) > 0 and var_600_5 < var_600_9 then
					arg_597_1.talkMaxDuration = var_600_9

					if var_600_9 + var_600_4 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_9 + var_600_4
					end
				end

				arg_597_1.text_.text = var_600_7
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905146", "story_v_side_new_1101905.awb") ~= 0 then
					local var_600_10 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905146", "story_v_side_new_1101905.awb") / 1000

					if var_600_10 + var_600_4 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_10 + var_600_4
					end

					if var_600_6.prefab_name ~= "" and arg_597_1.actors_[var_600_6.prefab_name] ~= nil then
						local var_600_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_597_1.actors_[var_600_6.prefab_name].transform, "story_v_side_new_1101905", "1101905146", "story_v_side_new_1101905.awb")

						arg_597_1:RecordAudio("1101905146", var_600_11)
						arg_597_1:RecordAudio("1101905146", var_600_11)
					else
						arg_597_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905146", "story_v_side_new_1101905.awb")
					end

					arg_597_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905146", "story_v_side_new_1101905.awb")
				end

				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_12 = math.max(var_600_5, arg_597_1.talkMaxDuration)

			if var_600_4 <= arg_597_1.time_ and arg_597_1.time_ < var_600_4 + var_600_12 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - var_600_4) / var_600_12

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= var_600_4 + var_600_12 and arg_597_1.time_ < var_600_4 + var_600_12 + arg_600_0 then
				arg_597_1.typewritter.percent = 1

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(true)
			end
		end

		arg_597_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_597_1:InitPlayNodeList()
	end,
	Play1101905147 = function(arg_601_0, arg_601_1)
		arg_601_1.time_ = 0
		arg_601_1.frameCnt_ = 0
		arg_601_1.state_ = "playing"
		arg_601_1.curTalkId_ = 1101905147
		arg_601_1.duration_ = 5

		SetActive(arg_601_1.tipsGo_, false)

		function arg_601_1.onSingleLineFinish_()
			arg_601_1.onSingleLineUpdate_ = nil
			arg_601_1.onSingleLineFinish_ = nil
			arg_601_1.state_ = "waiting"
		end

		function arg_601_1.playNext_(arg_603_0)
			if arg_603_0 == 1 then
				arg_601_0:Play1101905148(arg_601_1)
			end
		end

		function arg_601_1.onSingleLineUpdate_(arg_604_0)
			if 0 < arg_601_1.time_ and arg_601_1.time_ <= 0 + arg_604_0 and not isNil(arg_601_1.actors_["1019ui_story"]) and arg_601_1.var_.characterEffect1019ui_story == nil then
				arg_601_1.var_.characterEffect1019ui_story = arg_601_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_604_0 = 0.200000002980232

			if 0 <= arg_601_1.time_ and arg_601_1.time_ < 0 + var_604_0 and not isNil(arg_601_1.actors_["1019ui_story"]) then
				if arg_601_1.var_.characterEffect1019ui_story and not isNil(arg_601_1.actors_["1019ui_story"]) then
					arg_601_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_601_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_601_1.time_ - 0) / var_604_0)
				end
			end

			if arg_601_1.time_ >= 0 + var_604_0 and arg_601_1.time_ < 0 + var_604_0 + arg_604_0 and not isNil(arg_601_1.actors_["1019ui_story"]) and arg_601_1.var_.characterEffect1019ui_story then
				arg_601_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_601_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_604_1 = 0
			local var_604_2 = 0.65

			if 0 < arg_601_1.time_ and arg_601_1.time_ <= var_604_1 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0
				arg_601_1.dialogCg_.alpha = 1

				arg_601_1.dialog_:SetActive(true)
				SetActive(arg_601_1.leftNameGo_, false)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_601_1.iconTrs_.gameObject, false)
				arg_601_1.callingController_:SetSelectedState("normal")

				local var_604_3 = arg_601_1:FormatText(arg_601_1:GetWordFromCfg(1101905147).content)

				arg_601_1.text_.text = var_604_3

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_5 = 22 <= 0 and var_604_2 or var_604_2 * (utf8.len(var_604_3) / 22)

				if (22 <= 0 and var_604_2 or var_604_2 * (utf8.len(var_604_3) / 22)) > 0 and var_604_2 < var_604_5 then
					arg_601_1.talkMaxDuration = var_604_5

					if var_604_5 + var_604_1 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_5 + var_604_1
					end
				end

				arg_601_1.text_.text = var_604_3
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)
				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_6 = math.max(var_604_2, arg_601_1.talkMaxDuration)

			if var_604_1 <= arg_601_1.time_ and arg_601_1.time_ < var_604_1 + var_604_6 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - var_604_1) / var_604_6

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= var_604_1 + var_604_6 and arg_601_1.time_ < var_604_1 + var_604_6 + arg_604_0 then
				arg_601_1.typewritter.percent = 1

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(true)
			end
		end

		arg_601_1.nodeConfigList_ = {}

		arg_601_1:InitPlayNodeList()
	end,
	Play1101905148 = function(arg_605_0, arg_605_1)
		arg_605_1.time_ = 0
		arg_605_1.frameCnt_ = 0
		arg_605_1.state_ = "playing"
		arg_605_1.curTalkId_ = 1101905148
		arg_605_1.duration_ = 2.57

		local var_605_0 = {
			zh = 1.999999999999,
			ja = 2.566
		}
		local var_605_1 = manager.audio:GetLocalizationFlag()

		if var_605_0[var_605_1] ~= nil then
			arg_605_1.duration_ = var_605_0[var_605_1]
		end

		SetActive(arg_605_1.tipsGo_, false)

		function arg_605_1.onSingleLineFinish_()
			arg_605_1.onSingleLineUpdate_ = nil
			arg_605_1.onSingleLineFinish_ = nil
			arg_605_1.state_ = "waiting"
		end

		function arg_605_1.playNext_(arg_607_0)
			if arg_607_0 == 1 then
				arg_605_0:Play1101905149(arg_605_1)
			end
		end

		function arg_605_1.onSingleLineUpdate_(arg_608_0)
			if 0 < arg_605_1.time_ and arg_605_1.time_ <= 0 + arg_608_0 and not isNil(arg_605_1.actors_["1019ui_story"]) and arg_605_1.var_.characterEffect1019ui_story == nil then
				arg_605_1.var_.characterEffect1019ui_story = arg_605_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_608_0 = 0.200000002980232

			if 0 <= arg_605_1.time_ and arg_605_1.time_ < 0 + var_608_0 and not isNil(arg_605_1.actors_["1019ui_story"]) then
				if arg_605_1.var_.characterEffect1019ui_story and not isNil(arg_605_1.actors_["1019ui_story"]) then
					arg_605_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_605_1.time_ >= 0 + var_608_0 and arg_605_1.time_ < 0 + var_608_0 + arg_608_0 and not isNil(arg_605_1.actors_["1019ui_story"]) and arg_605_1.var_.characterEffect1019ui_story then
				arg_605_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_605_1.time_ and arg_605_1.time_ <= 0 + arg_608_0 then
				arg_605_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_608_2 = 0
			local var_608_3 = 0.675

			if 0 < arg_605_1.time_ and arg_605_1.time_ <= var_608_2 + arg_608_0 then
				arg_605_1.talkMaxDuration = 0
				arg_605_1.dialogCg_.alpha = 1

				arg_605_1.dialog_:SetActive(true)
				SetActive(arg_605_1.leftNameGo_, true)

				arg_605_1.leftNameTxt_.text = arg_605_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_605_1.leftNameTxt_.transform)

				arg_605_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_605_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_605_1:RecordName(arg_605_1.leftNameTxt_.text)
				SetActive(arg_605_1.iconTrs_.gameObject, false)
				arg_605_1.callingController_:SetSelectedState("normal")

				local var_608_4 = arg_605_1:GetWordFromCfg(1101905148)
				local var_608_5 = arg_605_1:FormatText(var_608_4.content)

				arg_605_1.text_.text = var_608_5

				LuaForUtil.ClearLinePrefixSymbol(arg_605_1.text_)

				local var_608_7 = 5 <= 0 and var_608_3 or var_608_3 * (utf8.len(var_608_5) / 5)

				if (5 <= 0 and var_608_3 or var_608_3 * (utf8.len(var_608_5) / 5)) > 0 and var_608_3 < var_608_7 then
					arg_605_1.talkMaxDuration = var_608_7

					if var_608_7 + var_608_2 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_7 + var_608_2
					end
				end

				arg_605_1.text_.text = var_608_5
				arg_605_1.typewritter.percent = 0

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905148", "story_v_side_new_1101905.awb") ~= 0 then
					local var_608_8 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905148", "story_v_side_new_1101905.awb") / 1000

					if var_608_8 + var_608_2 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_8 + var_608_2
					end

					if var_608_4.prefab_name ~= "" and arg_605_1.actors_[var_608_4.prefab_name] ~= nil then
						local var_608_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_605_1.actors_[var_608_4.prefab_name].transform, "story_v_side_new_1101905", "1101905148", "story_v_side_new_1101905.awb")

						arg_605_1:RecordAudio("1101905148", var_608_9)
						arg_605_1:RecordAudio("1101905148", var_608_9)
					else
						arg_605_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905148", "story_v_side_new_1101905.awb")
					end

					arg_605_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905148", "story_v_side_new_1101905.awb")
				end

				arg_605_1:RecordContent(arg_605_1.text_.text)
			end

			local var_608_10 = math.max(var_608_3, arg_605_1.talkMaxDuration)

			if var_608_2 <= arg_605_1.time_ and arg_605_1.time_ < var_608_2 + var_608_10 then
				arg_605_1.typewritter.percent = (arg_605_1.time_ - var_608_2) / var_608_10

				arg_605_1.typewritter:SetDirty()
			end

			if arg_605_1.time_ >= var_608_2 + var_608_10 and arg_605_1.time_ < var_608_2 + var_608_10 + arg_608_0 then
				arg_605_1.typewritter.percent = 1

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(true)
			end
		end

		arg_605_1.nodeConfigList_ = {}

		arg_605_1:InitPlayNodeList()
	end,
	Play1101905149 = function(arg_609_0, arg_609_1)
		arg_609_1.time_ = 0
		arg_609_1.frameCnt_ = 0
		arg_609_1.state_ = "playing"
		arg_609_1.curTalkId_ = 1101905149
		arg_609_1.duration_ = 1

		SetActive(arg_609_1.tipsGo_, true)

		arg_609_1.tipsText_.text = StoryTipsCfg[101901].name

		function arg_609_1.onSingleLineFinish_()
			arg_609_1.onSingleLineUpdate_ = nil
			arg_609_1.onSingleLineFinish_ = nil
			arg_609_1.state_ = "waiting"

			SetActive(arg_609_1.choicesGo_, true)

			for iter_610_0, iter_610_1 in ipairs(arg_609_1.choices_) do
				SetActive(iter_610_1.go, iter_610_0 <= 2)
			end

			arg_609_1.choices_[1].txt.text = arg_609_1:FormatText(StoryChoiceCfg[740].name)
			arg_609_1.choices_[2].txt.text = arg_609_1:FormatText(StoryChoiceCfg[741].name)
		end

		function arg_609_1.playNext_(arg_611_0)
			if arg_611_0 == 1 then
				arg_609_0:Play1101905150(arg_609_1)
			end

			if arg_611_0 == 2 then
				PlayerAction.UseStoryTrigger(1019014, 210190105, 1101905149, 2)
				arg_609_0:Play1101905150(arg_609_1)
			end

			arg_609_1:RecordChoiceLog(1101905149, 740, 741)
		end

		function arg_609_1.onSingleLineUpdate_(arg_612_0)
			if 0 < arg_609_1.time_ and arg_609_1.time_ <= 0 + arg_612_0 then
				arg_609_1.allBtn_.enabled = false
			end

			if arg_609_1.time_ >= 0 + 0.5 and arg_609_1.time_ < 0 + 0.5 + arg_612_0 then
				arg_609_1.allBtn_.enabled = true
			end

			local var_612_0 = arg_609_1.actors_["1019ui_story"]

			if 0 < arg_609_1.time_ and arg_609_1.time_ <= 0 + arg_612_0 and not isNil(var_612_0) and arg_609_1.var_.characterEffect1019ui_story == nil then
				arg_609_1.var_.characterEffect1019ui_story = var_612_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_612_1 = 0.200000002980232

			if 0 <= arg_609_1.time_ and arg_609_1.time_ < 0 + var_612_1 and not isNil(var_612_0) then
				if arg_609_1.var_.characterEffect1019ui_story and not isNil(var_612_0) then
					arg_609_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_609_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_609_1.time_ - 0) / var_612_1)
				end
			end

			if arg_609_1.time_ >= 0 + var_612_1 and arg_609_1.time_ < 0 + var_612_1 + arg_612_0 and not isNil(var_612_0) and arg_609_1.var_.characterEffect1019ui_story then
				arg_609_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_609_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end
		end

		arg_609_1.nodeConfigList_ = {}

		arg_609_1:InitPlayNodeList()
	end,
	Play1101905150 = function(arg_613_0, arg_613_1)
		arg_613_1.time_ = 0
		arg_613_1.frameCnt_ = 0
		arg_613_1.state_ = "playing"
		arg_613_1.curTalkId_ = 1101905150
		arg_613_1.duration_ = 5

		SetActive(arg_613_1.tipsGo_, false)

		function arg_613_1.onSingleLineFinish_()
			arg_613_1.onSingleLineUpdate_ = nil
			arg_613_1.onSingleLineFinish_ = nil
			arg_613_1.state_ = "waiting"
		end

		function arg_613_1.playNext_(arg_615_0)
			if arg_615_0 == 1 then
				arg_613_0:Play1101905151(arg_613_1)
			end
		end

		function arg_613_1.onSingleLineUpdate_(arg_616_0)
			if 0 < arg_613_1.time_ and arg_613_1.time_ <= 0 + arg_616_0 and not isNil(arg_613_1.actors_["1019ui_story"]) and arg_613_1.var_.characterEffect1019ui_story == nil then
				arg_613_1.var_.characterEffect1019ui_story = arg_613_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_616_0 = 0.200000002980232

			if 0 <= arg_613_1.time_ and arg_613_1.time_ < 0 + var_616_0 and not isNil(arg_613_1.actors_["1019ui_story"]) then
				if arg_613_1.var_.characterEffect1019ui_story and not isNil(arg_613_1.actors_["1019ui_story"]) then
					arg_613_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_613_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_613_1.time_ - 0) / var_616_0)
				end
			end

			if arg_613_1.time_ >= 0 + var_616_0 and arg_613_1.time_ < 0 + var_616_0 + arg_616_0 and not isNil(arg_613_1.actors_["1019ui_story"]) and arg_613_1.var_.characterEffect1019ui_story then
				arg_613_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_613_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_616_1 = 0
			local var_616_2 = 0.55

			if 0 < arg_613_1.time_ and arg_613_1.time_ <= var_616_1 + arg_616_0 then
				arg_613_1.talkMaxDuration = 0
				arg_613_1.dialogCg_.alpha = 1

				arg_613_1.dialog_:SetActive(true)
				SetActive(arg_613_1.leftNameGo_, true)

				arg_613_1.leftNameTxt_.text = arg_613_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_613_1.leftNameTxt_.transform)

				arg_613_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_613_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_613_1:RecordName(arg_613_1.leftNameTxt_.text)
				SetActive(arg_613_1.iconTrs_.gameObject, true)
				arg_613_1.iconController_:SetSelectedState("hero")

				arg_613_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_613_1.callingController_:SetSelectedState("normal")

				arg_613_1.keyicon_.color = Color.New(1, 1, 1)
				arg_613_1.icon_.color = Color.New(1, 1, 1)

				local var_616_3 = arg_613_1:FormatText(arg_613_1:GetWordFromCfg(1101905150).content)

				arg_613_1.text_.text = var_616_3

				LuaForUtil.ClearLinePrefixSymbol(arg_613_1.text_)

				local var_616_5 = 13 <= 0 and var_616_2 or var_616_2 * (utf8.len(var_616_3) / 13)

				if (13 <= 0 and var_616_2 or var_616_2 * (utf8.len(var_616_3) / 13)) > 0 and var_616_2 < var_616_5 then
					arg_613_1.talkMaxDuration = var_616_5

					if var_616_5 + var_616_1 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_5 + var_616_1
					end
				end

				arg_613_1.text_.text = var_616_3
				arg_613_1.typewritter.percent = 0

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(false)
				arg_613_1:RecordContent(arg_613_1.text_.text)
			end

			local var_616_6 = math.max(var_616_2, arg_613_1.talkMaxDuration)

			if var_616_1 <= arg_613_1.time_ and arg_613_1.time_ < var_616_1 + var_616_6 then
				arg_613_1.typewritter.percent = (arg_613_1.time_ - var_616_1) / var_616_6

				arg_613_1.typewritter:SetDirty()
			end

			if arg_613_1.time_ >= var_616_1 + var_616_6 and arg_613_1.time_ < var_616_1 + var_616_6 + arg_616_0 then
				arg_613_1.typewritter.percent = 1

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(true)
			end
		end

		arg_613_1.nodeConfigList_ = {}

		arg_613_1:InitPlayNodeList()
	end,
	Play1101905151 = function(arg_617_0, arg_617_1)
		arg_617_1.time_ = 0
		arg_617_1.frameCnt_ = 0
		arg_617_1.state_ = "playing"
		arg_617_1.curTalkId_ = 1101905151
		arg_617_1.duration_ = 1

		SetActive(arg_617_1.tipsGo_, false)

		function arg_617_1.onSingleLineFinish_()
			arg_617_1.onSingleLineUpdate_ = nil
			arg_617_1.onSingleLineFinish_ = nil
			arg_617_1.state_ = "waiting"
		end

		function arg_617_1.playNext_(arg_619_0)
			if arg_619_0 == 1 then
				arg_617_0:Play1101905152(arg_617_1)
			end
		end

		function arg_617_1.onSingleLineUpdate_(arg_620_0)
			if 0 < arg_617_1.time_ and arg_617_1.time_ <= 0 + arg_620_0 and not isNil(arg_617_1.actors_["1019ui_story"]) and arg_617_1.var_.characterEffect1019ui_story == nil then
				arg_617_1.var_.characterEffect1019ui_story = arg_617_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_620_0 = 0.200000002980232

			if 0 <= arg_617_1.time_ and arg_617_1.time_ < 0 + var_620_0 and not isNil(arg_617_1.actors_["1019ui_story"]) then
				if arg_617_1.var_.characterEffect1019ui_story and not isNil(arg_617_1.actors_["1019ui_story"]) then
					arg_617_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_617_1.time_ >= 0 + var_620_0 and arg_617_1.time_ < 0 + var_620_0 + arg_620_0 and not isNil(arg_617_1.actors_["1019ui_story"]) and arg_617_1.var_.characterEffect1019ui_story then
				arg_617_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_620_2 = 0
			local var_620_3 = 0.125

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= var_620_2 + arg_620_0 then
				arg_617_1.talkMaxDuration = 0
				arg_617_1.dialogCg_.alpha = 1

				arg_617_1.dialog_:SetActive(true)
				SetActive(arg_617_1.leftNameGo_, true)

				arg_617_1.leftNameTxt_.text = arg_617_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_617_1.leftNameTxt_.transform)

				arg_617_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_617_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_617_1:RecordName(arg_617_1.leftNameTxt_.text)
				SetActive(arg_617_1.iconTrs_.gameObject, false)
				arg_617_1.callingController_:SetSelectedState("normal")

				local var_620_4 = arg_617_1:GetWordFromCfg(1101905151)
				local var_620_5 = arg_617_1:FormatText(var_620_4.content)

				arg_617_1.text_.text = var_620_5

				LuaForUtil.ClearLinePrefixSymbol(arg_617_1.text_)

				local var_620_7 = 2 <= 0 and var_620_3 or var_620_3 * (utf8.len(var_620_5) / 2)

				if (2 <= 0 and var_620_3 or var_620_3 * (utf8.len(var_620_5) / 2)) > 0 and var_620_3 < var_620_7 then
					arg_617_1.talkMaxDuration = var_620_7

					if var_620_7 + var_620_2 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_7 + var_620_2
					end
				end

				arg_617_1.text_.text = var_620_5
				arg_617_1.typewritter.percent = 0

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905151", "story_v_side_new_1101905.awb") ~= 0 then
					local var_620_8 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905151", "story_v_side_new_1101905.awb") / 1000

					if var_620_8 + var_620_2 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_8 + var_620_2
					end

					if var_620_4.prefab_name ~= "" and arg_617_1.actors_[var_620_4.prefab_name] ~= nil then
						local var_620_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_617_1.actors_[var_620_4.prefab_name].transform, "story_v_side_new_1101905", "1101905151", "story_v_side_new_1101905.awb")

						arg_617_1:RecordAudio("1101905151", var_620_9)
						arg_617_1:RecordAudio("1101905151", var_620_9)
					else
						arg_617_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905151", "story_v_side_new_1101905.awb")
					end

					arg_617_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905151", "story_v_side_new_1101905.awb")
				end

				arg_617_1:RecordContent(arg_617_1.text_.text)
			end

			local var_620_10 = math.max(var_620_3, arg_617_1.talkMaxDuration)

			if var_620_2 <= arg_617_1.time_ and arg_617_1.time_ < var_620_2 + var_620_10 then
				arg_617_1.typewritter.percent = (arg_617_1.time_ - var_620_2) / var_620_10

				arg_617_1.typewritter:SetDirty()
			end

			if arg_617_1.time_ >= var_620_2 + var_620_10 and arg_617_1.time_ < var_620_2 + var_620_10 + arg_620_0 then
				arg_617_1.typewritter.percent = 1

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(true)
			end
		end

		arg_617_1.nodeConfigList_ = {}

		arg_617_1:InitPlayNodeList()
	end,
	Play1101905152 = function(arg_621_0, arg_621_1)
		arg_621_1.time_ = 0
		arg_621_1.frameCnt_ = 0
		arg_621_1.state_ = "playing"
		arg_621_1.curTalkId_ = 1101905152
		arg_621_1.duration_ = 5

		SetActive(arg_621_1.tipsGo_, false)

		function arg_621_1.onSingleLineFinish_()
			arg_621_1.onSingleLineUpdate_ = nil
			arg_621_1.onSingleLineFinish_ = nil
			arg_621_1.state_ = "waiting"
		end

		function arg_621_1.playNext_(arg_623_0)
			if arg_623_0 == 1 then
				arg_621_0:Play1101905153(arg_621_1)
			end
		end

		function arg_621_1.onSingleLineUpdate_(arg_624_0)
			if 0 < arg_621_1.time_ and arg_621_1.time_ <= 0 + arg_624_0 and not isNil(arg_621_1.actors_["1019ui_story"]) and arg_621_1.var_.characterEffect1019ui_story == nil then
				arg_621_1.var_.characterEffect1019ui_story = arg_621_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_624_0 = 0.200000002980232

			if 0 <= arg_621_1.time_ and arg_621_1.time_ < 0 + var_624_0 and not isNil(arg_621_1.actors_["1019ui_story"]) then
				if arg_621_1.var_.characterEffect1019ui_story and not isNil(arg_621_1.actors_["1019ui_story"]) then
					arg_621_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_621_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_621_1.time_ - 0) / var_624_0)
				end
			end

			if arg_621_1.time_ >= 0 + var_624_0 and arg_621_1.time_ < 0 + var_624_0 + arg_624_0 and not isNil(arg_621_1.actors_["1019ui_story"]) and arg_621_1.var_.characterEffect1019ui_story then
				arg_621_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_621_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_624_1 = 0
			local var_624_2 = 0.1

			if 0 < arg_621_1.time_ and arg_621_1.time_ <= var_624_1 + arg_624_0 then
				arg_621_1.talkMaxDuration = 0
				arg_621_1.dialogCg_.alpha = 1

				arg_621_1.dialog_:SetActive(true)
				SetActive(arg_621_1.leftNameGo_, false)

				arg_621_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_621_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_621_1:RecordName(arg_621_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_621_1.iconTrs_.gameObject, false)
				arg_621_1.callingController_:SetSelectedState("normal")

				local var_624_3 = arg_621_1:FormatText(arg_621_1:GetWordFromCfg(1101905152).content)

				arg_621_1.text_.text = var_624_3

				LuaForUtil.ClearLinePrefixSymbol(arg_621_1.text_)

				local var_624_5 = 34 <= 0 and var_624_2 or var_624_2 * (utf8.len(var_624_3) / 34)

				if (34 <= 0 and var_624_2 or var_624_2 * (utf8.len(var_624_3) / 34)) > 0 and var_624_2 < var_624_5 then
					arg_621_1.talkMaxDuration = var_624_5

					if var_624_5 + var_624_1 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_5 + var_624_1
					end
				end

				arg_621_1.text_.text = var_624_3
				arg_621_1.typewritter.percent = 0

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(false)
				arg_621_1:RecordContent(arg_621_1.text_.text)
			end

			local var_624_6 = math.max(var_624_2, arg_621_1.talkMaxDuration)

			if var_624_1 <= arg_621_1.time_ and arg_621_1.time_ < var_624_1 + var_624_6 then
				arg_621_1.typewritter.percent = (arg_621_1.time_ - var_624_1) / var_624_6

				arg_621_1.typewritter:SetDirty()
			end

			if arg_621_1.time_ >= var_624_1 + var_624_6 and arg_621_1.time_ < var_624_1 + var_624_6 + arg_624_0 then
				arg_621_1.typewritter.percent = 1

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(true)
			end
		end

		arg_621_1.nodeConfigList_ = {}

		arg_621_1:InitPlayNodeList()
	end,
	Play1101905153 = function(arg_625_0, arg_625_1)
		arg_625_1.time_ = 0
		arg_625_1.frameCnt_ = 0
		arg_625_1.state_ = "playing"
		arg_625_1.curTalkId_ = 1101905153
		arg_625_1.duration_ = 3.67

		local var_625_0 = {
			zh = 2,
			ja = 3.666
		}
		local var_625_1 = manager.audio:GetLocalizationFlag()

		if var_625_0[var_625_1] ~= nil then
			arg_625_1.duration_ = var_625_0[var_625_1]
		end

		SetActive(arg_625_1.tipsGo_, false)

		function arg_625_1.onSingleLineFinish_()
			arg_625_1.onSingleLineUpdate_ = nil
			arg_625_1.onSingleLineFinish_ = nil
			arg_625_1.state_ = "waiting"
		end

		function arg_625_1.playNext_(arg_627_0)
			if arg_627_0 == 1 then
				arg_625_0:Play1101905154(arg_625_1)
			end
		end

		function arg_625_1.onSingleLineUpdate_(arg_628_0)
			if 0 < arg_625_1.time_ and arg_625_1.time_ <= 0 + arg_628_0 then
				arg_625_1.var_.moveOldPos1019ui_story = arg_625_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_628_0 = 0.001

			if 0 <= arg_625_1.time_ and arg_625_1.time_ < 0 + var_628_0 then
				arg_625_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_625_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_625_1.time_ - 0) / var_628_0)
				arg_625_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_625_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_625_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_625_1.actors_["1019ui_story"].transform.position).z)
				arg_625_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_625_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_625_1.actors_["1019ui_story"].transform.localEulerAngles = arg_625_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_625_1.time_ >= 0 + var_628_0 and arg_625_1.time_ < 0 + var_628_0 + arg_628_0 then
				arg_625_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_625_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_625_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_625_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_625_1.actors_["1019ui_story"].transform.position).z)
				arg_625_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_625_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_625_1.actors_["1019ui_story"].transform.localEulerAngles = arg_625_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_628_1 = arg_625_1.actors_["1019ui_story"]

			if 0 < arg_625_1.time_ and arg_625_1.time_ <= 0 + arg_628_0 and not isNil(var_628_1) and arg_625_1.var_.characterEffect1019ui_story == nil then
				arg_625_1.var_.characterEffect1019ui_story = var_628_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_628_2 = 0.200000002980232

			if 0 <= arg_625_1.time_ and arg_625_1.time_ < 0 + var_628_2 and not isNil(var_628_1) then
				if arg_625_1.var_.characterEffect1019ui_story and not isNil(var_628_1) then
					arg_625_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_625_1.time_ >= 0 + var_628_2 and arg_625_1.time_ < 0 + var_628_2 + arg_628_0 and not isNil(var_628_1) and arg_625_1.var_.characterEffect1019ui_story then
				arg_625_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_625_1.time_ and arg_625_1.time_ <= 0 + arg_628_0 then
				arg_625_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action8_1")
			end

			if 0 < arg_625_1.time_ and arg_625_1.time_ <= 0 + arg_628_0 then
				arg_625_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_628_4 = 0
			local var_628_5 = 0.125

			if 0 < arg_625_1.time_ and arg_625_1.time_ <= var_628_4 + arg_628_0 then
				arg_625_1.talkMaxDuration = 0
				arg_625_1.dialogCg_.alpha = 1

				arg_625_1.dialog_:SetActive(true)
				SetActive(arg_625_1.leftNameGo_, true)

				arg_625_1.leftNameTxt_.text = arg_625_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_625_1.leftNameTxt_.transform)

				arg_625_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_625_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_625_1:RecordName(arg_625_1.leftNameTxt_.text)
				SetActive(arg_625_1.iconTrs_.gameObject, false)
				arg_625_1.callingController_:SetSelectedState("normal")

				local var_628_6 = arg_625_1:GetWordFromCfg(1101905153)
				local var_628_7 = arg_625_1:FormatText(var_628_6.content)

				arg_625_1.text_.text = var_628_7

				LuaForUtil.ClearLinePrefixSymbol(arg_625_1.text_)

				local var_628_9 = 7 <= 0 and var_628_5 or var_628_5 * (utf8.len(var_628_7) / 7)

				if (7 <= 0 and var_628_5 or var_628_5 * (utf8.len(var_628_7) / 7)) > 0 and var_628_5 < var_628_9 then
					arg_625_1.talkMaxDuration = var_628_9

					if var_628_9 + var_628_4 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_9 + var_628_4
					end
				end

				arg_625_1.text_.text = var_628_7
				arg_625_1.typewritter.percent = 0

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905153", "story_v_side_new_1101905.awb") ~= 0 then
					local var_628_10 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905153", "story_v_side_new_1101905.awb") / 1000

					if var_628_10 + var_628_4 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_10 + var_628_4
					end

					if var_628_6.prefab_name ~= "" and arg_625_1.actors_[var_628_6.prefab_name] ~= nil then
						local var_628_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_625_1.actors_[var_628_6.prefab_name].transform, "story_v_side_new_1101905", "1101905153", "story_v_side_new_1101905.awb")

						arg_625_1:RecordAudio("1101905153", var_628_11)
						arg_625_1:RecordAudio("1101905153", var_628_11)
					else
						arg_625_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905153", "story_v_side_new_1101905.awb")
					end

					arg_625_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905153", "story_v_side_new_1101905.awb")
				end

				arg_625_1:RecordContent(arg_625_1.text_.text)
			end

			local var_628_12 = math.max(var_628_5, arg_625_1.talkMaxDuration)

			if var_628_4 <= arg_625_1.time_ and arg_625_1.time_ < var_628_4 + var_628_12 then
				arg_625_1.typewritter.percent = (arg_625_1.time_ - var_628_4) / var_628_12

				arg_625_1.typewritter:SetDirty()
			end

			if arg_625_1.time_ >= var_628_4 + var_628_12 and arg_625_1.time_ < var_628_4 + var_628_12 + arg_628_0 then
				arg_625_1.typewritter.percent = 1

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(true)
			end
		end

		arg_625_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_625_1:InitPlayNodeList()
	end,
	Play1101905154 = function(arg_629_0, arg_629_1)
		arg_629_1.time_ = 0
		arg_629_1.frameCnt_ = 0
		arg_629_1.state_ = "playing"
		arg_629_1.curTalkId_ = 1101905154
		arg_629_1.duration_ = 5

		SetActive(arg_629_1.tipsGo_, false)

		function arg_629_1.onSingleLineFinish_()
			arg_629_1.onSingleLineUpdate_ = nil
			arg_629_1.onSingleLineFinish_ = nil
			arg_629_1.state_ = "waiting"
		end

		function arg_629_1.playNext_(arg_631_0)
			if arg_631_0 == 1 then
				arg_629_0:Play1101905155(arg_629_1)
			end
		end

		function arg_629_1.onSingleLineUpdate_(arg_632_0)
			if 0 < arg_629_1.time_ and arg_629_1.time_ <= 0 + arg_632_0 and not isNil(arg_629_1.actors_["1019ui_story"]) and arg_629_1.var_.characterEffect1019ui_story == nil then
				arg_629_1.var_.characterEffect1019ui_story = arg_629_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_632_0 = 0.200000002980232

			if 0 <= arg_629_1.time_ and arg_629_1.time_ < 0 + var_632_0 and not isNil(arg_629_1.actors_["1019ui_story"]) then
				if arg_629_1.var_.characterEffect1019ui_story and not isNil(arg_629_1.actors_["1019ui_story"]) then
					arg_629_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_629_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_629_1.time_ - 0) / var_632_0)
				end
			end

			if arg_629_1.time_ >= 0 + var_632_0 and arg_629_1.time_ < 0 + var_632_0 + arg_632_0 and not isNil(arg_629_1.actors_["1019ui_story"]) and arg_629_1.var_.characterEffect1019ui_story then
				arg_629_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_629_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_632_1 = 0
			local var_632_2 = 0.325

			if 0 < arg_629_1.time_ and arg_629_1.time_ <= var_632_1 + arg_632_0 then
				arg_629_1.talkMaxDuration = 0
				arg_629_1.dialogCg_.alpha = 1

				arg_629_1.dialog_:SetActive(true)
				SetActive(arg_629_1.leftNameGo_, false)

				arg_629_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_629_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_629_1:RecordName(arg_629_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_629_1.iconTrs_.gameObject, false)
				arg_629_1.callingController_:SetSelectedState("normal")

				local var_632_3 = arg_629_1:FormatText(arg_629_1:GetWordFromCfg(1101905154).content)

				arg_629_1.text_.text = var_632_3

				LuaForUtil.ClearLinePrefixSymbol(arg_629_1.text_)

				local var_632_5 = 26 <= 0 and var_632_2 or var_632_2 * (utf8.len(var_632_3) / 26)

				if (26 <= 0 and var_632_2 or var_632_2 * (utf8.len(var_632_3) / 26)) > 0 and var_632_2 < var_632_5 then
					arg_629_1.talkMaxDuration = var_632_5

					if var_632_5 + var_632_1 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_5 + var_632_1
					end
				end

				arg_629_1.text_.text = var_632_3
				arg_629_1.typewritter.percent = 0

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(false)
				arg_629_1:RecordContent(arg_629_1.text_.text)
			end

			local var_632_6 = math.max(var_632_2, arg_629_1.talkMaxDuration)

			if var_632_1 <= arg_629_1.time_ and arg_629_1.time_ < var_632_1 + var_632_6 then
				arg_629_1.typewritter.percent = (arg_629_1.time_ - var_632_1) / var_632_6

				arg_629_1.typewritter:SetDirty()
			end

			if arg_629_1.time_ >= var_632_1 + var_632_6 and arg_629_1.time_ < var_632_1 + var_632_6 + arg_632_0 then
				arg_629_1.typewritter.percent = 1

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(true)
			end
		end

		arg_629_1.nodeConfigList_ = {}

		arg_629_1:InitPlayNodeList()
	end,
	Play1101905155 = function(arg_633_0, arg_633_1)
		arg_633_1.time_ = 0
		arg_633_1.frameCnt_ = 0
		arg_633_1.state_ = "playing"
		arg_633_1.curTalkId_ = 1101905155
		arg_633_1.duration_ = 5

		SetActive(arg_633_1.tipsGo_, false)

		function arg_633_1.onSingleLineFinish_()
			arg_633_1.onSingleLineUpdate_ = nil
			arg_633_1.onSingleLineFinish_ = nil
			arg_633_1.state_ = "waiting"
		end

		function arg_633_1.playNext_(arg_635_0)
			if arg_635_0 == 1 then
				arg_633_0:Play1101905156(arg_633_1)
			end
		end

		function arg_633_1.onSingleLineUpdate_(arg_636_0)
			if 0 < arg_633_1.time_ and arg_633_1.time_ <= 0 + arg_636_0 then
				arg_633_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action8_2")
			end

			if 0 < arg_633_1.time_ and arg_633_1.time_ <= 0 + arg_636_0 then
				arg_633_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_636_0 = 0
			local var_636_1 = 0.05

			if 0 < arg_633_1.time_ and arg_633_1.time_ <= var_636_0 + arg_636_0 then
				arg_633_1.talkMaxDuration = 0
				arg_633_1.dialogCg_.alpha = 1

				arg_633_1.dialog_:SetActive(true)
				SetActive(arg_633_1.leftNameGo_, false)

				arg_633_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_633_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_633_1:RecordName(arg_633_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_633_1.iconTrs_.gameObject, false)
				arg_633_1.callingController_:SetSelectedState("normal")

				local var_636_2 = arg_633_1:FormatText(arg_633_1:GetWordFromCfg(1101905155).content)

				arg_633_1.text_.text = var_636_2

				LuaForUtil.ClearLinePrefixSymbol(arg_633_1.text_)

				local var_636_4 = 13 <= 0 and var_636_1 or var_636_1 * (utf8.len(var_636_2) / 13)

				if (13 <= 0 and var_636_1 or var_636_1 * (utf8.len(var_636_2) / 13)) > 0 and var_636_1 < var_636_4 then
					arg_633_1.talkMaxDuration = var_636_4

					if var_636_4 + var_636_0 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_4 + var_636_0
					end
				end

				arg_633_1.text_.text = var_636_2
				arg_633_1.typewritter.percent = 0

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(false)
				arg_633_1:RecordContent(arg_633_1.text_.text)
			end

			local var_636_5 = math.max(var_636_1, arg_633_1.talkMaxDuration)

			if var_636_0 <= arg_633_1.time_ and arg_633_1.time_ < var_636_0 + var_636_5 then
				arg_633_1.typewritter.percent = (arg_633_1.time_ - var_636_0) / var_636_5

				arg_633_1.typewritter:SetDirty()
			end

			if arg_633_1.time_ >= var_636_0 + var_636_5 and arg_633_1.time_ < var_636_0 + var_636_5 + arg_636_0 then
				arg_633_1.typewritter.percent = 1

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(true)
			end
		end

		arg_633_1.nodeConfigList_ = {}

		arg_633_1:InitPlayNodeList()
	end,
	Play1101905156 = function(arg_637_0, arg_637_1)
		arg_637_1.time_ = 0
		arg_637_1.frameCnt_ = 0
		arg_637_1.state_ = "playing"
		arg_637_1.curTalkId_ = 1101905156
		arg_637_1.duration_ = 5

		SetActive(arg_637_1.tipsGo_, false)

		function arg_637_1.onSingleLineFinish_()
			arg_637_1.onSingleLineUpdate_ = nil
			arg_637_1.onSingleLineFinish_ = nil
			arg_637_1.state_ = "waiting"
		end

		function arg_637_1.playNext_(arg_639_0)
			if arg_639_0 == 1 then
				arg_637_0:Play1101905157(arg_637_1)
			end
		end

		function arg_637_1.onSingleLineUpdate_(arg_640_0)
			local var_640_0 = 0.85

			if 0 < arg_637_1.time_ and arg_637_1.time_ <= 0 + arg_640_0 then
				arg_637_1.talkMaxDuration = 0
				arg_637_1.dialogCg_.alpha = 1

				arg_637_1.dialog_:SetActive(true)
				SetActive(arg_637_1.leftNameGo_, true)

				arg_637_1.leftNameTxt_.text = arg_637_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_637_1.leftNameTxt_.transform)

				arg_637_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_637_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_637_1:RecordName(arg_637_1.leftNameTxt_.text)
				SetActive(arg_637_1.iconTrs_.gameObject, true)
				arg_637_1.iconController_:SetSelectedState("hero")

				arg_637_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_637_1.callingController_:SetSelectedState("normal")

				arg_637_1.keyicon_.color = Color.New(1, 1, 1)
				arg_637_1.icon_.color = Color.New(1, 1, 1)

				local var_640_1 = arg_637_1:FormatText(arg_637_1:GetWordFromCfg(1101905156).content)

				arg_637_1.text_.text = var_640_1

				LuaForUtil.ClearLinePrefixSymbol(arg_637_1.text_)

				local var_640_3 = 7 <= 0 and var_640_0 or var_640_0 * (utf8.len(var_640_1) / 7)

				if (7 <= 0 and var_640_0 or var_640_0 * (utf8.len(var_640_1) / 7)) > 0 and var_640_0 < var_640_3 then
					arg_637_1.talkMaxDuration = var_640_3

					if var_640_3 + 0 > arg_637_1.duration_ then
						arg_637_1.duration_ = var_640_3 + 0
					end
				end

				arg_637_1.text_.text = var_640_1
				arg_637_1.typewritter.percent = 0

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(false)
				arg_637_1:RecordContent(arg_637_1.text_.text)
			end

			local var_640_4 = math.max(var_640_0, arg_637_1.talkMaxDuration)

			if 0 <= arg_637_1.time_ and arg_637_1.time_ < 0 + var_640_4 then
				arg_637_1.typewritter.percent = (arg_637_1.time_ - 0) / var_640_4

				arg_637_1.typewritter:SetDirty()
			end

			if arg_637_1.time_ >= 0 + var_640_4 and arg_637_1.time_ < 0 + var_640_4 + arg_640_0 then
				arg_637_1.typewritter.percent = 1

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(true)
			end
		end

		arg_637_1.nodeConfigList_ = {}

		arg_637_1:InitPlayNodeList()
	end,
	Play1101905157 = function(arg_641_0, arg_641_1)
		arg_641_1.time_ = 0
		arg_641_1.frameCnt_ = 0
		arg_641_1.state_ = "playing"
		arg_641_1.curTalkId_ = 1101905157
		arg_641_1.duration_ = 1.33

		local var_641_0 = {
			zh = 1.333,
			ja = 0.999999999999
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
				arg_641_0:Play1101905158(arg_641_1)
			end
		end

		function arg_641_1.onSingleLineUpdate_(arg_644_0)
			if 0 < arg_641_1.time_ and arg_641_1.time_ <= 0 + arg_644_0 and not isNil(arg_641_1.actors_["1019ui_story"]) and arg_641_1.var_.characterEffect1019ui_story == nil then
				arg_641_1.var_.characterEffect1019ui_story = arg_641_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_644_0 = 0.200000002980232

			if 0 <= arg_641_1.time_ and arg_641_1.time_ < 0 + var_644_0 and not isNil(arg_641_1.actors_["1019ui_story"]) then
				if arg_641_1.var_.characterEffect1019ui_story and not isNil(arg_641_1.actors_["1019ui_story"]) then
					arg_641_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_641_1.time_ >= 0 + var_644_0 and arg_641_1.time_ < 0 + var_644_0 + arg_644_0 and not isNil(arg_641_1.actors_["1019ui_story"]) and arg_641_1.var_.characterEffect1019ui_story then
				arg_641_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_644_2 = 0
			local var_644_3 = 0.175

			if 0 < arg_641_1.time_ and arg_641_1.time_ <= var_644_2 + arg_644_0 then
				arg_641_1.talkMaxDuration = 0
				arg_641_1.dialogCg_.alpha = 1

				arg_641_1.dialog_:SetActive(true)
				SetActive(arg_641_1.leftNameGo_, true)

				arg_641_1.leftNameTxt_.text = arg_641_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_641_1.leftNameTxt_.transform)

				arg_641_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_641_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_641_1:RecordName(arg_641_1.leftNameTxt_.text)
				SetActive(arg_641_1.iconTrs_.gameObject, false)
				arg_641_1.callingController_:SetSelectedState("normal")

				local var_644_4 = arg_641_1:GetWordFromCfg(1101905157)
				local var_644_5 = arg_641_1:FormatText(var_644_4.content)

				arg_641_1.text_.text = var_644_5

				LuaForUtil.ClearLinePrefixSymbol(arg_641_1.text_)

				local var_644_7 = 6 <= 0 and var_644_3 or var_644_3 * (utf8.len(var_644_5) / 6)

				if (6 <= 0 and var_644_3 or var_644_3 * (utf8.len(var_644_5) / 6)) > 0 and var_644_3 < var_644_7 then
					arg_641_1.talkMaxDuration = var_644_7

					if var_644_7 + var_644_2 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_7 + var_644_2
					end
				end

				arg_641_1.text_.text = var_644_5
				arg_641_1.typewritter.percent = 0

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905157", "story_v_side_new_1101905.awb") ~= 0 then
					local var_644_8 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905157", "story_v_side_new_1101905.awb") / 1000

					if var_644_8 + var_644_2 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_8 + var_644_2
					end

					if var_644_4.prefab_name ~= "" and arg_641_1.actors_[var_644_4.prefab_name] ~= nil then
						local var_644_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_641_1.actors_[var_644_4.prefab_name].transform, "story_v_side_new_1101905", "1101905157", "story_v_side_new_1101905.awb")

						arg_641_1:RecordAudio("1101905157", var_644_9)
						arg_641_1:RecordAudio("1101905157", var_644_9)
					else
						arg_641_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905157", "story_v_side_new_1101905.awb")
					end

					arg_641_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905157", "story_v_side_new_1101905.awb")
				end

				arg_641_1:RecordContent(arg_641_1.text_.text)
			end

			local var_644_10 = math.max(var_644_3, arg_641_1.talkMaxDuration)

			if var_644_2 <= arg_641_1.time_ and arg_641_1.time_ < var_644_2 + var_644_10 then
				arg_641_1.typewritter.percent = (arg_641_1.time_ - var_644_2) / var_644_10

				arg_641_1.typewritter:SetDirty()
			end

			if arg_641_1.time_ >= var_644_2 + var_644_10 and arg_641_1.time_ < var_644_2 + var_644_10 + arg_644_0 then
				arg_641_1.typewritter.percent = 1

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(true)
			end
		end

		arg_641_1.nodeConfigList_ = {}

		arg_641_1:InitPlayNodeList()
	end,
	Play1101905158 = function(arg_645_0, arg_645_1)
		arg_645_1.time_ = 0
		arg_645_1.frameCnt_ = 0
		arg_645_1.state_ = "playing"
		arg_645_1.curTalkId_ = 1101905158
		arg_645_1.duration_ = 5

		SetActive(arg_645_1.tipsGo_, false)

		function arg_645_1.onSingleLineFinish_()
			arg_645_1.onSingleLineUpdate_ = nil
			arg_645_1.onSingleLineFinish_ = nil
			arg_645_1.state_ = "waiting"
		end

		function arg_645_1.playNext_(arg_647_0)
			if arg_647_0 == 1 then
				arg_645_0:Play1101905159(arg_645_1)
			end
		end

		function arg_645_1.onSingleLineUpdate_(arg_648_0)
			if 0 < arg_645_1.time_ and arg_645_1.time_ <= 0 + arg_648_0 and not isNil(arg_645_1.actors_["1019ui_story"]) and arg_645_1.var_.characterEffect1019ui_story == nil then
				arg_645_1.var_.characterEffect1019ui_story = arg_645_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_648_0 = 0.200000002980232

			if 0 <= arg_645_1.time_ and arg_645_1.time_ < 0 + var_648_0 and not isNil(arg_645_1.actors_["1019ui_story"]) then
				if arg_645_1.var_.characterEffect1019ui_story and not isNil(arg_645_1.actors_["1019ui_story"]) then
					arg_645_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_645_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_645_1.time_ - 0) / var_648_0)
				end
			end

			if arg_645_1.time_ >= 0 + var_648_0 and arg_645_1.time_ < 0 + var_648_0 + arg_648_0 and not isNil(arg_645_1.actors_["1019ui_story"]) and arg_645_1.var_.characterEffect1019ui_story then
				arg_645_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_645_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_648_1 = 0
			local var_648_2 = 0.65

			if 0 < arg_645_1.time_ and arg_645_1.time_ <= var_648_1 + arg_648_0 then
				arg_645_1.talkMaxDuration = 0
				arg_645_1.dialogCg_.alpha = 1

				arg_645_1.dialog_:SetActive(true)
				SetActive(arg_645_1.leftNameGo_, true)

				arg_645_1.leftNameTxt_.text = arg_645_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_645_1.leftNameTxt_.transform)

				arg_645_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_645_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_645_1:RecordName(arg_645_1.leftNameTxt_.text)
				SetActive(arg_645_1.iconTrs_.gameObject, true)
				arg_645_1.iconController_:SetSelectedState("hero")

				arg_645_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_645_1.callingController_:SetSelectedState("normal")

				arg_645_1.keyicon_.color = Color.New(1, 1, 1)
				arg_645_1.icon_.color = Color.New(1, 1, 1)

				local var_648_3 = arg_645_1:FormatText(arg_645_1:GetWordFromCfg(1101905158).content)

				arg_645_1.text_.text = var_648_3

				LuaForUtil.ClearLinePrefixSymbol(arg_645_1.text_)

				local var_648_5 = 6 <= 0 and var_648_2 or var_648_2 * (utf8.len(var_648_3) / 6)

				if (6 <= 0 and var_648_2 or var_648_2 * (utf8.len(var_648_3) / 6)) > 0 and var_648_2 < var_648_5 then
					arg_645_1.talkMaxDuration = var_648_5

					if var_648_5 + var_648_1 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_5 + var_648_1
					end
				end

				arg_645_1.text_.text = var_648_3
				arg_645_1.typewritter.percent = 0

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(false)
				arg_645_1:RecordContent(arg_645_1.text_.text)
			end

			local var_648_6 = math.max(var_648_2, arg_645_1.talkMaxDuration)

			if var_648_1 <= arg_645_1.time_ and arg_645_1.time_ < var_648_1 + var_648_6 then
				arg_645_1.typewritter.percent = (arg_645_1.time_ - var_648_1) / var_648_6

				arg_645_1.typewritter:SetDirty()
			end

			if arg_645_1.time_ >= var_648_1 + var_648_6 and arg_645_1.time_ < var_648_1 + var_648_6 + arg_648_0 then
				arg_645_1.typewritter.percent = 1

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(true)
			end
		end

		arg_645_1.nodeConfigList_ = {}

		arg_645_1:InitPlayNodeList()
	end,
	Play1101905159 = function(arg_649_0, arg_649_1)
		arg_649_1.time_ = 0
		arg_649_1.frameCnt_ = 0
		arg_649_1.state_ = "playing"
		arg_649_1.curTalkId_ = 1101905159
		arg_649_1.duration_ = 5

		SetActive(arg_649_1.tipsGo_, false)

		function arg_649_1.onSingleLineFinish_()
			arg_649_1.onSingleLineUpdate_ = nil
			arg_649_1.onSingleLineFinish_ = nil
			arg_649_1.state_ = "waiting"
		end

		function arg_649_1.playNext_(arg_651_0)
			if arg_651_0 == 1 then
				arg_649_0:Play1101905160(arg_649_1)
			end
		end

		function arg_649_1.onSingleLineUpdate_(arg_652_0)
			local var_652_0 = 0.325

			if 0 < arg_649_1.time_ and arg_649_1.time_ <= 0 + arg_652_0 then
				arg_649_1.talkMaxDuration = 0
				arg_649_1.dialogCg_.alpha = 1

				arg_649_1.dialog_:SetActive(true)
				SetActive(arg_649_1.leftNameGo_, false)

				arg_649_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_649_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_649_1:RecordName(arg_649_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_649_1.iconTrs_.gameObject, false)
				arg_649_1.callingController_:SetSelectedState("normal")

				local var_652_1 = arg_649_1:FormatText(arg_649_1:GetWordFromCfg(1101905159).content)

				arg_649_1.text_.text = var_652_1

				LuaForUtil.ClearLinePrefixSymbol(arg_649_1.text_)

				local var_652_3 = 15 <= 0 and var_652_0 or var_652_0 * (utf8.len(var_652_1) / 15)

				if (15 <= 0 and var_652_0 or var_652_0 * (utf8.len(var_652_1) / 15)) > 0 and var_652_0 < var_652_3 then
					arg_649_1.talkMaxDuration = var_652_3

					if var_652_3 + 0 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_3 + 0
					end
				end

				arg_649_1.text_.text = var_652_1
				arg_649_1.typewritter.percent = 0

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(false)
				arg_649_1:RecordContent(arg_649_1.text_.text)
			end

			local var_652_4 = math.max(var_652_0, arg_649_1.talkMaxDuration)

			if 0 <= arg_649_1.time_ and arg_649_1.time_ < 0 + var_652_4 then
				arg_649_1.typewritter.percent = (arg_649_1.time_ - 0) / var_652_4

				arg_649_1.typewritter:SetDirty()
			end

			if arg_649_1.time_ >= 0 + var_652_4 and arg_649_1.time_ < 0 + var_652_4 + arg_652_0 then
				arg_649_1.typewritter.percent = 1

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(true)
			end
		end

		arg_649_1.nodeConfigList_ = {}

		arg_649_1:InitPlayNodeList()
	end,
	Play1101905160 = function(arg_653_0, arg_653_1)
		arg_653_1.time_ = 0
		arg_653_1.frameCnt_ = 0
		arg_653_1.state_ = "playing"
		arg_653_1.curTalkId_ = 1101905160
		arg_653_1.duration_ = 4.37

		local var_653_0 = {
			zh = 4.066,
			ja = 4.366
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
				arg_653_0:Play1101905161(arg_653_1)
			end
		end

		function arg_653_1.onSingleLineUpdate_(arg_656_0)
			if 0 < arg_653_1.time_ and arg_653_1.time_ <= 0 + arg_656_0 and not isNil(arg_653_1.actors_["1019ui_story"]) and arg_653_1.var_.characterEffect1019ui_story == nil then
				arg_653_1.var_.characterEffect1019ui_story = arg_653_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_656_0 = 0.200000002980232

			if 0 <= arg_653_1.time_ and arg_653_1.time_ < 0 + var_656_0 and not isNil(arg_653_1.actors_["1019ui_story"]) then
				if arg_653_1.var_.characterEffect1019ui_story and not isNil(arg_653_1.actors_["1019ui_story"]) then
					arg_653_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_653_1.time_ >= 0 + var_656_0 and arg_653_1.time_ < 0 + var_656_0 + arg_656_0 and not isNil(arg_653_1.actors_["1019ui_story"]) and arg_653_1.var_.characterEffect1019ui_story then
				arg_653_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_656_2 = 0
			local var_656_3 = 0.175

			if 0 < arg_653_1.time_ and arg_653_1.time_ <= var_656_2 + arg_656_0 then
				arg_653_1.talkMaxDuration = 0
				arg_653_1.dialogCg_.alpha = 1

				arg_653_1.dialog_:SetActive(true)
				SetActive(arg_653_1.leftNameGo_, true)

				arg_653_1.leftNameTxt_.text = arg_653_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_653_1.leftNameTxt_.transform)

				arg_653_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_653_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_653_1:RecordName(arg_653_1.leftNameTxt_.text)
				SetActive(arg_653_1.iconTrs_.gameObject, false)
				arg_653_1.callingController_:SetSelectedState("normal")

				local var_656_4 = arg_653_1:GetWordFromCfg(1101905160)
				local var_656_5 = arg_653_1:FormatText(var_656_4.content)

				arg_653_1.text_.text = var_656_5

				LuaForUtil.ClearLinePrefixSymbol(arg_653_1.text_)

				local var_656_7 = 17 <= 0 and var_656_3 or var_656_3 * (utf8.len(var_656_5) / 17)

				if (17 <= 0 and var_656_3 or var_656_3 * (utf8.len(var_656_5) / 17)) > 0 and var_656_3 < var_656_7 then
					arg_653_1.talkMaxDuration = var_656_7

					if var_656_7 + var_656_2 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_7 + var_656_2
					end
				end

				arg_653_1.text_.text = var_656_5
				arg_653_1.typewritter.percent = 0

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905160", "story_v_side_new_1101905.awb") ~= 0 then
					local var_656_8 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905160", "story_v_side_new_1101905.awb") / 1000

					if var_656_8 + var_656_2 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_8 + var_656_2
					end

					if var_656_4.prefab_name ~= "" and arg_653_1.actors_[var_656_4.prefab_name] ~= nil then
						local var_656_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_653_1.actors_[var_656_4.prefab_name].transform, "story_v_side_new_1101905", "1101905160", "story_v_side_new_1101905.awb")

						arg_653_1:RecordAudio("1101905160", var_656_9)
						arg_653_1:RecordAudio("1101905160", var_656_9)
					else
						arg_653_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905160", "story_v_side_new_1101905.awb")
					end

					arg_653_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905160", "story_v_side_new_1101905.awb")
				end

				arg_653_1:RecordContent(arg_653_1.text_.text)
			end

			local var_656_10 = math.max(var_656_3, arg_653_1.talkMaxDuration)

			if var_656_2 <= arg_653_1.time_ and arg_653_1.time_ < var_656_2 + var_656_10 then
				arg_653_1.typewritter.percent = (arg_653_1.time_ - var_656_2) / var_656_10

				arg_653_1.typewritter:SetDirty()
			end

			if arg_653_1.time_ >= var_656_2 + var_656_10 and arg_653_1.time_ < var_656_2 + var_656_10 + arg_656_0 then
				arg_653_1.typewritter.percent = 1

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(true)
			end
		end

		arg_653_1.nodeConfigList_ = {}

		arg_653_1:InitPlayNodeList()
	end,
	Play1101905161 = function(arg_657_0, arg_657_1)
		arg_657_1.time_ = 0
		arg_657_1.frameCnt_ = 0
		arg_657_1.state_ = "playing"
		arg_657_1.curTalkId_ = 1101905161
		arg_657_1.duration_ = 9

		SetActive(arg_657_1.tipsGo_, false)

		function arg_657_1.onSingleLineFinish_()
			arg_657_1.onSingleLineUpdate_ = nil
			arg_657_1.onSingleLineFinish_ = nil
			arg_657_1.state_ = "waiting"
		end

		function arg_657_1.playNext_(arg_659_0)
			if arg_659_0 == 1 then
				arg_657_0:Play1101905162(arg_657_1)
			end
		end

		function arg_657_1.onSingleLineUpdate_(arg_660_0)
			if arg_657_1.bgs_.ST02 == nil then
				local var_660_0 = Object.Instantiate(arg_657_1.paintGo_)

				var_660_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST02")
				var_660_0.name = "ST02"
				var_660_0.transform.parent = arg_657_1.stage_.transform
				var_660_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_657_1.bgs_.ST02 = var_660_0
			end

			if 2 < arg_657_1.time_ and arg_657_1.time_ <= 2 + arg_660_0 then
				local var_660_1 = arg_657_1.bgs_.ST02

				arg_657_1.bgs_.ST02.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_660_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_660_2 = var_660_1:GetComponent("SpriteRenderer")

				if var_660_2 and var_660_2.sprite then
					local var_660_3 = 2 * (var_660_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_660_1.transform.localScale = Vector3.New(var_660_3 / var_660_2.sprite.bounds.size.y < var_660_3 * manager.ui.mainCameraCom_.aspect / var_660_2.sprite.bounds.size.x and var_660_3 * manager.ui.mainCameraCom_.aspect / var_660_2.sprite.bounds.size.x or var_660_3 / var_660_2.sprite.bounds.size.y, var_660_3 / var_660_2.sprite.bounds.size.y < var_660_3 * manager.ui.mainCameraCom_.aspect / var_660_2.sprite.bounds.size.x and var_660_3 * manager.ui.mainCameraCom_.aspect / var_660_2.sprite.bounds.size.x or var_660_3 / var_660_2.sprite.bounds.size.y, 0)
				end

				for iter_660_0, iter_660_1 in pairs(arg_657_1.bgs_) do
					if iter_660_0 ~= "ST02" then
						iter_660_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_660_4 = 0

			if 0 < arg_657_1.time_ and arg_657_1.time_ <= var_660_4 + arg_660_0 then
				arg_657_1.mask_.enabled = true
				arg_657_1.mask_.raycastTarget = true

				arg_657_1:SetGaussion(false)
			end

			local var_660_5 = 2

			if var_660_4 <= arg_657_1.time_ and arg_657_1.time_ < var_660_4 + var_660_5 then
				local var_660_6 = Color.New(0, 0, 0)

				var_660_6.a = Mathf.Lerp(0, 1, (arg_657_1.time_ - var_660_4) / var_660_5)
				arg_657_1.mask_.color = var_660_6
			end

			if arg_657_1.time_ >= var_660_4 + var_660_5 and arg_657_1.time_ < var_660_4 + var_660_5 + arg_660_0 then
				local var_660_7 = Color.New(0, 0, 0)

				var_660_7.a = 1
				arg_657_1.mask_.color = var_660_7
			end

			local var_660_8 = 2

			if 2 < arg_657_1.time_ and arg_657_1.time_ <= var_660_8 + arg_660_0 then
				arg_657_1.mask_.enabled = true
				arg_657_1.mask_.raycastTarget = true

				arg_657_1:SetGaussion(false)
			end

			local var_660_9 = 2

			if var_660_8 <= arg_657_1.time_ and arg_657_1.time_ < var_660_8 + var_660_9 then
				local var_660_10 = Color.New(0, 0, 0)

				var_660_10.a = Mathf.Lerp(1, 0, (arg_657_1.time_ - var_660_8) / var_660_9)
				arg_657_1.mask_.color = var_660_10
			end

			if arg_657_1.time_ >= var_660_8 + var_660_9 and arg_657_1.time_ < var_660_8 + var_660_9 + arg_660_0 then
				local var_660_11 = Color.New(0, 0, 0)

				arg_657_1.mask_.enabled = false
				var_660_11.a = 0
				arg_657_1.mask_.color = var_660_11
			end

			if 0 < arg_657_1.time_ and arg_657_1.time_ <= 0 + arg_660_0 then
				arg_657_1:AudioAction("stop", "effect", "se_story_side_1080", "se_story_1080_parkloop", "")
			end

			local var_660_13 = arg_657_1.actors_["1019ui_story"].transform

			if 1.966 < arg_657_1.time_ and arg_657_1.time_ <= 1.966 + arg_660_0 then
				arg_657_1.var_.moveOldPos1019ui_story = var_660_13.localPosition
			end

			local var_660_14 = 0.001

			if 1.966 <= arg_657_1.time_ and arg_657_1.time_ < 1.966 + var_660_14 then
				var_660_13.localPosition = Vector3.Lerp(arg_657_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_657_1.time_ - 1.966) / var_660_14)
				var_660_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_660_13.position).x, (manager.ui.mainCamera.transform.position - var_660_13.position).y, (manager.ui.mainCamera.transform.position - var_660_13.position).z)
				var_660_13.localEulerAngles.z = 0
				var_660_13.localEulerAngles.x = 0
				var_660_13.localEulerAngles = var_660_13.localEulerAngles
			end

			if arg_657_1.time_ >= 1.966 + var_660_14 and arg_657_1.time_ < 1.966 + var_660_14 + arg_660_0 then
				var_660_13.localPosition = Vector3.New(0, 100, 0)
				var_660_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_660_13.position).x, (manager.ui.mainCamera.transform.position - var_660_13.position).y, (manager.ui.mainCamera.transform.position - var_660_13.position).z)
				var_660_13.localEulerAngles.z = 0
				var_660_13.localEulerAngles.x = 0
				var_660_13.localEulerAngles = var_660_13.localEulerAngles
			end

			if arg_657_1.frameCnt_ <= 1 then
				arg_657_1.dialog_:SetActive(false)
			end

			local var_660_15 = 4
			local var_660_16 = 0.15

			if 4 < arg_657_1.time_ and arg_657_1.time_ <= var_660_15 + arg_660_0 then
				arg_657_1.talkMaxDuration = 0

				arg_657_1.dialog_:SetActive(true)

				arg_657_1.dialogCg_.alpha = 0

				local var_660_17 = LeanTween.value(arg_657_1.dialog_, 0, 1, 0.3)

				var_660_17:setOnUpdate(LuaHelper.FloatAction(function(arg_661_0)
					arg_657_1.dialogCg_.alpha = arg_661_0
				end))
				var_660_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_657_1.dialog_)
					var_660_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_657_1.duration_ = arg_657_1.duration_ + 0.3

				SetActive(arg_657_1.leftNameGo_, false)

				arg_657_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_657_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_657_1:RecordName(arg_657_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_657_1.iconTrs_.gameObject, false)
				arg_657_1.callingController_:SetSelectedState("normal")

				local var_660_18 = arg_657_1:FormatText(arg_657_1:GetWordFromCfg(1101905161).content)

				arg_657_1.text_.text = var_660_18

				LuaForUtil.ClearLinePrefixSymbol(arg_657_1.text_)

				local var_660_20 = 36 <= 0 and var_660_16 or var_660_16 * (utf8.len(var_660_18) / 36)

				if (36 <= 0 and var_660_16 or var_660_16 * (utf8.len(var_660_18) / 36)) > 0 and var_660_16 < var_660_20 then
					arg_657_1.talkMaxDuration = var_660_20
					var_660_15 = var_660_15 + 0.3

					if var_660_20 + var_660_15 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_20 + var_660_15
					end
				end

				arg_657_1.text_.text = var_660_18
				arg_657_1.typewritter.percent = 0

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(false)
				arg_657_1:RecordContent(arg_657_1.text_.text)
			end

			local var_660_21 = var_660_15 + 0.3
			local var_660_22 = math.max(var_660_16, arg_657_1.talkMaxDuration)

			if var_660_15 + 0.3 <= arg_657_1.time_ and arg_657_1.time_ < var_660_21 + var_660_22 then
				arg_657_1.typewritter.percent = (arg_657_1.time_ - var_660_21) / var_660_22

				arg_657_1.typewritter:SetDirty()
			end

			if arg_657_1.time_ >= var_660_21 + var_660_22 and arg_657_1.time_ < var_660_21 + var_660_22 + arg_660_0 then
				arg_657_1.typewritter.percent = 1

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(true)
			end
		end

		arg_657_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_657_1:InitPlayNodeList()
	end,
	Play1101905162 = function(arg_663_0, arg_663_1)
		arg_663_1.time_ = 0
		arg_663_1.frameCnt_ = 0
		arg_663_1.state_ = "playing"
		arg_663_1.curTalkId_ = 1101905162
		arg_663_1.duration_ = 3.07

		local var_663_0 = {
			zh = 3.066,
			ja = 2.566
		}
		local var_663_1 = manager.audio:GetLocalizationFlag()

		if var_663_0[var_663_1] ~= nil then
			arg_663_1.duration_ = var_663_0[var_663_1]
		end

		SetActive(arg_663_1.tipsGo_, false)

		function arg_663_1.onSingleLineFinish_()
			arg_663_1.onSingleLineUpdate_ = nil
			arg_663_1.onSingleLineFinish_ = nil
			arg_663_1.state_ = "waiting"
		end

		function arg_663_1.playNext_(arg_665_0)
			if arg_665_0 == 1 then
				arg_663_0:Play1101905163(arg_663_1)
			end
		end

		function arg_663_1.onSingleLineUpdate_(arg_666_0)
			if 0 < arg_663_1.time_ and arg_663_1.time_ <= 0 + arg_666_0 then
				arg_663_1.var_.moveOldPos1019ui_story = arg_663_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_666_0 = 0.001

			if 0 <= arg_663_1.time_ and arg_663_1.time_ < 0 + var_666_0 then
				arg_663_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_663_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_663_1.time_ - 0) / var_666_0)
				arg_663_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_663_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_663_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_663_1.actors_["1019ui_story"].transform.position).z)
				arg_663_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_663_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_663_1.actors_["1019ui_story"].transform.localEulerAngles = arg_663_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_663_1.time_ >= 0 + var_666_0 and arg_663_1.time_ < 0 + var_666_0 + arg_666_0 then
				arg_663_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_663_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_663_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_663_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_663_1.actors_["1019ui_story"].transform.position).z)
				arg_663_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_663_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_663_1.actors_["1019ui_story"].transform.localEulerAngles = arg_663_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_666_1 = arg_663_1.actors_["1019ui_story"]

			if 0 < arg_663_1.time_ and arg_663_1.time_ <= 0 + arg_666_0 and not isNil(var_666_1) and arg_663_1.var_.characterEffect1019ui_story == nil then
				arg_663_1.var_.characterEffect1019ui_story = var_666_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_666_2 = 0.200000002980232

			if 0 <= arg_663_1.time_ and arg_663_1.time_ < 0 + var_666_2 and not isNil(var_666_1) then
				if arg_663_1.var_.characterEffect1019ui_story and not isNil(var_666_1) then
					arg_663_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_663_1.time_ >= 0 + var_666_2 and arg_663_1.time_ < 0 + var_666_2 + arg_666_0 and not isNil(var_666_1) and arg_663_1.var_.characterEffect1019ui_story then
				arg_663_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_663_1.time_ and arg_663_1.time_ <= 0 + arg_666_0 then
				arg_663_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_663_1.time_ and arg_663_1.time_ <= 0 + arg_666_0 then
				arg_663_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_666_4 = 0
			local var_666_5 = 0.15

			if 0 < arg_663_1.time_ and arg_663_1.time_ <= var_666_4 + arg_666_0 then
				arg_663_1.talkMaxDuration = 0
				arg_663_1.dialogCg_.alpha = 1

				arg_663_1.dialog_:SetActive(true)
				SetActive(arg_663_1.leftNameGo_, true)

				arg_663_1.leftNameTxt_.text = arg_663_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_663_1.leftNameTxt_.transform)

				arg_663_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_663_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_663_1:RecordName(arg_663_1.leftNameTxt_.text)
				SetActive(arg_663_1.iconTrs_.gameObject, false)
				arg_663_1.callingController_:SetSelectedState("normal")

				local var_666_6 = arg_663_1:GetWordFromCfg(1101905162)
				local var_666_7 = arg_663_1:FormatText(var_666_6.content)

				arg_663_1.text_.text = var_666_7

				LuaForUtil.ClearLinePrefixSymbol(arg_663_1.text_)

				local var_666_9 = 13 <= 0 and var_666_5 or var_666_5 * (utf8.len(var_666_7) / 13)

				if (13 <= 0 and var_666_5 or var_666_5 * (utf8.len(var_666_7) / 13)) > 0 and var_666_5 < var_666_9 then
					arg_663_1.talkMaxDuration = var_666_9

					if var_666_9 + var_666_4 > arg_663_1.duration_ then
						arg_663_1.duration_ = var_666_9 + var_666_4
					end
				end

				arg_663_1.text_.text = var_666_7
				arg_663_1.typewritter.percent = 0

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905162", "story_v_side_new_1101905.awb") ~= 0 then
					local var_666_10 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905162", "story_v_side_new_1101905.awb") / 1000

					if var_666_10 + var_666_4 > arg_663_1.duration_ then
						arg_663_1.duration_ = var_666_10 + var_666_4
					end

					if var_666_6.prefab_name ~= "" and arg_663_1.actors_[var_666_6.prefab_name] ~= nil then
						local var_666_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_663_1.actors_[var_666_6.prefab_name].transform, "story_v_side_new_1101905", "1101905162", "story_v_side_new_1101905.awb")

						arg_663_1:RecordAudio("1101905162", var_666_11)
						arg_663_1:RecordAudio("1101905162", var_666_11)
					else
						arg_663_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905162", "story_v_side_new_1101905.awb")
					end

					arg_663_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905162", "story_v_side_new_1101905.awb")
				end

				arg_663_1:RecordContent(arg_663_1.text_.text)
			end

			local var_666_12 = math.max(var_666_5, arg_663_1.talkMaxDuration)

			if var_666_4 <= arg_663_1.time_ and arg_663_1.time_ < var_666_4 + var_666_12 then
				arg_663_1.typewritter.percent = (arg_663_1.time_ - var_666_4) / var_666_12

				arg_663_1.typewritter:SetDirty()
			end

			if arg_663_1.time_ >= var_666_4 + var_666_12 and arg_663_1.time_ < var_666_4 + var_666_12 + arg_666_0 then
				arg_663_1.typewritter.percent = 1

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(true)
			end
		end

		arg_663_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_663_1:InitPlayNodeList()
	end,
	Play1101905163 = function(arg_667_0, arg_667_1)
		arg_667_1.time_ = 0
		arg_667_1.frameCnt_ = 0
		arg_667_1.state_ = "playing"
		arg_667_1.curTalkId_ = 1101905163
		arg_667_1.duration_ = 5

		SetActive(arg_667_1.tipsGo_, false)

		function arg_667_1.onSingleLineFinish_()
			arg_667_1.onSingleLineUpdate_ = nil
			arg_667_1.onSingleLineFinish_ = nil
			arg_667_1.state_ = "waiting"
		end

		function arg_667_1.playNext_(arg_669_0)
			if arg_669_0 == 1 then
				arg_667_0:Play1101905164(arg_667_1)
			end
		end

		function arg_667_1.onSingleLineUpdate_(arg_670_0)
			if 0 < arg_667_1.time_ and arg_667_1.time_ <= 0 + arg_670_0 and not isNil(arg_667_1.actors_["1019ui_story"]) and arg_667_1.var_.characterEffect1019ui_story == nil then
				arg_667_1.var_.characterEffect1019ui_story = arg_667_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_670_0 = 0.200000002980232

			if 0 <= arg_667_1.time_ and arg_667_1.time_ < 0 + var_670_0 and not isNil(arg_667_1.actors_["1019ui_story"]) then
				if arg_667_1.var_.characterEffect1019ui_story and not isNil(arg_667_1.actors_["1019ui_story"]) then
					arg_667_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_667_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_667_1.time_ - 0) / var_670_0)
				end
			end

			if arg_667_1.time_ >= 0 + var_670_0 and arg_667_1.time_ < 0 + var_670_0 + arg_670_0 and not isNil(arg_667_1.actors_["1019ui_story"]) and arg_667_1.var_.characterEffect1019ui_story then
				arg_667_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_667_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_670_1 = 0
			local var_670_2 = 0.375

			if 0 < arg_667_1.time_ and arg_667_1.time_ <= var_670_1 + arg_670_0 then
				arg_667_1.talkMaxDuration = 0
				arg_667_1.dialogCg_.alpha = 1

				arg_667_1.dialog_:SetActive(true)
				SetActive(arg_667_1.leftNameGo_, true)

				arg_667_1.leftNameTxt_.text = arg_667_1:FormatText(StoryNameCfg[7].name)

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

				local var_670_3 = arg_667_1:FormatText(arg_667_1:GetWordFromCfg(1101905163).content)

				arg_667_1.text_.text = var_670_3

				LuaForUtil.ClearLinePrefixSymbol(arg_667_1.text_)

				local var_670_5 = 32 <= 0 and var_670_2 or var_670_2 * (utf8.len(var_670_3) / 32)

				if (32 <= 0 and var_670_2 or var_670_2 * (utf8.len(var_670_3) / 32)) > 0 and var_670_2 < var_670_5 then
					arg_667_1.talkMaxDuration = var_670_5

					if var_670_5 + var_670_1 > arg_667_1.duration_ then
						arg_667_1.duration_ = var_670_5 + var_670_1
					end
				end

				arg_667_1.text_.text = var_670_3
				arg_667_1.typewritter.percent = 0

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(false)
				arg_667_1:RecordContent(arg_667_1.text_.text)
			end

			local var_670_6 = math.max(var_670_2, arg_667_1.talkMaxDuration)

			if var_670_1 <= arg_667_1.time_ and arg_667_1.time_ < var_670_1 + var_670_6 then
				arg_667_1.typewritter.percent = (arg_667_1.time_ - var_670_1) / var_670_6

				arg_667_1.typewritter:SetDirty()
			end

			if arg_667_1.time_ >= var_670_1 + var_670_6 and arg_667_1.time_ < var_670_1 + var_670_6 + arg_670_0 then
				arg_667_1.typewritter.percent = 1

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(true)
			end
		end

		arg_667_1.nodeConfigList_ = {}

		arg_667_1:InitPlayNodeList()
	end,
	Play1101905164 = function(arg_671_0, arg_671_1)
		arg_671_1.time_ = 0
		arg_671_1.frameCnt_ = 0
		arg_671_1.state_ = "playing"
		arg_671_1.curTalkId_ = 1101905164
		arg_671_1.duration_ = 5.1

		local var_671_0 = {
			zh = 2.8,
			ja = 5.1
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
				arg_671_0:Play1101905165(arg_671_1)
			end
		end

		function arg_671_1.onSingleLineUpdate_(arg_674_0)
			if 0 < arg_671_1.time_ and arg_671_1.time_ <= 0 + arg_674_0 and not isNil(arg_671_1.actors_["1019ui_story"]) and arg_671_1.var_.characterEffect1019ui_story == nil then
				arg_671_1.var_.characterEffect1019ui_story = arg_671_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_674_0 = 0.200000002980232

			if 0 <= arg_671_1.time_ and arg_671_1.time_ < 0 + var_674_0 and not isNil(arg_671_1.actors_["1019ui_story"]) then
				if arg_671_1.var_.characterEffect1019ui_story and not isNil(arg_671_1.actors_["1019ui_story"]) then
					arg_671_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_671_1.time_ >= 0 + var_674_0 and arg_671_1.time_ < 0 + var_674_0 + arg_674_0 and not isNil(arg_671_1.actors_["1019ui_story"]) and arg_671_1.var_.characterEffect1019ui_story then
				arg_671_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_674_2 = 0
			local var_674_3 = 0.425

			if 0 < arg_671_1.time_ and arg_671_1.time_ <= var_674_2 + arg_674_0 then
				arg_671_1.talkMaxDuration = 0
				arg_671_1.dialogCg_.alpha = 1

				arg_671_1.dialog_:SetActive(true)
				SetActive(arg_671_1.leftNameGo_, true)

				arg_671_1.leftNameTxt_.text = arg_671_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_671_1.leftNameTxt_.transform)

				arg_671_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_671_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_671_1:RecordName(arg_671_1.leftNameTxt_.text)
				SetActive(arg_671_1.iconTrs_.gameObject, false)
				arg_671_1.callingController_:SetSelectedState("normal")

				local var_674_4 = arg_671_1:GetWordFromCfg(1101905164)
				local var_674_5 = arg_671_1:FormatText(var_674_4.content)

				arg_671_1.text_.text = var_674_5

				LuaForUtil.ClearLinePrefixSymbol(arg_671_1.text_)

				local var_674_7 = 13 <= 0 and var_674_3 or var_674_3 * (utf8.len(var_674_5) / 13)

				if (13 <= 0 and var_674_3 or var_674_3 * (utf8.len(var_674_5) / 13)) > 0 and var_674_3 < var_674_7 then
					arg_671_1.talkMaxDuration = var_674_7

					if var_674_7 + var_674_2 > arg_671_1.duration_ then
						arg_671_1.duration_ = var_674_7 + var_674_2
					end
				end

				arg_671_1.text_.text = var_674_5
				arg_671_1.typewritter.percent = 0

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905164", "story_v_side_new_1101905.awb") ~= 0 then
					local var_674_8 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905164", "story_v_side_new_1101905.awb") / 1000

					if var_674_8 + var_674_2 > arg_671_1.duration_ then
						arg_671_1.duration_ = var_674_8 + var_674_2
					end

					if var_674_4.prefab_name ~= "" and arg_671_1.actors_[var_674_4.prefab_name] ~= nil then
						local var_674_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_671_1.actors_[var_674_4.prefab_name].transform, "story_v_side_new_1101905", "1101905164", "story_v_side_new_1101905.awb")

						arg_671_1:RecordAudio("1101905164", var_674_9)
						arg_671_1:RecordAudio("1101905164", var_674_9)
					else
						arg_671_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905164", "story_v_side_new_1101905.awb")
					end

					arg_671_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905164", "story_v_side_new_1101905.awb")
				end

				arg_671_1:RecordContent(arg_671_1.text_.text)
			end

			local var_674_10 = math.max(var_674_3, arg_671_1.talkMaxDuration)

			if var_674_2 <= arg_671_1.time_ and arg_671_1.time_ < var_674_2 + var_674_10 then
				arg_671_1.typewritter.percent = (arg_671_1.time_ - var_674_2) / var_674_10

				arg_671_1.typewritter:SetDirty()
			end

			if arg_671_1.time_ >= var_674_2 + var_674_10 and arg_671_1.time_ < var_674_2 + var_674_10 + arg_674_0 then
				arg_671_1.typewritter.percent = 1

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(true)
			end
		end

		arg_671_1.nodeConfigList_ = {}

		arg_671_1:InitPlayNodeList()
	end,
	Play1101905165 = function(arg_675_0, arg_675_1)
		arg_675_1.time_ = 0
		arg_675_1.frameCnt_ = 0
		arg_675_1.state_ = "playing"
		arg_675_1.curTalkId_ = 1101905165
		arg_675_1.duration_ = 5

		SetActive(arg_675_1.tipsGo_, false)

		function arg_675_1.onSingleLineFinish_()
			arg_675_1.onSingleLineUpdate_ = nil
			arg_675_1.onSingleLineFinish_ = nil
			arg_675_1.state_ = "waiting"
		end

		function arg_675_1.playNext_(arg_677_0)
			if arg_677_0 == 1 then
				arg_675_0:Play1101905166(arg_675_1)
			end
		end

		function arg_675_1.onSingleLineUpdate_(arg_678_0)
			if 0 < arg_675_1.time_ and arg_675_1.time_ <= 0 + arg_678_0 and not isNil(arg_675_1.actors_["1019ui_story"]) and arg_675_1.var_.characterEffect1019ui_story == nil then
				arg_675_1.var_.characterEffect1019ui_story = arg_675_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_678_0 = 0.200000002980232

			if 0 <= arg_675_1.time_ and arg_675_1.time_ < 0 + var_678_0 and not isNil(arg_675_1.actors_["1019ui_story"]) then
				if arg_675_1.var_.characterEffect1019ui_story and not isNil(arg_675_1.actors_["1019ui_story"]) then
					arg_675_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_675_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_675_1.time_ - 0) / var_678_0)
				end
			end

			if arg_675_1.time_ >= 0 + var_678_0 and arg_675_1.time_ < 0 + var_678_0 + arg_678_0 and not isNil(arg_675_1.actors_["1019ui_story"]) and arg_675_1.var_.characterEffect1019ui_story then
				arg_675_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_675_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_678_1 = 0
			local var_678_2 = 0.9

			if 0 < arg_675_1.time_ and arg_675_1.time_ <= var_678_1 + arg_678_0 then
				arg_675_1.talkMaxDuration = 0
				arg_675_1.dialogCg_.alpha = 1

				arg_675_1.dialog_:SetActive(true)
				SetActive(arg_675_1.leftNameGo_, true)

				arg_675_1.leftNameTxt_.text = arg_675_1:FormatText(StoryNameCfg[7].name)

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

				local var_678_3 = arg_675_1:FormatText(arg_675_1:GetWordFromCfg(1101905165).content)

				arg_675_1.text_.text = var_678_3

				LuaForUtil.ClearLinePrefixSymbol(arg_675_1.text_)

				local var_678_5 = 8 <= 0 and var_678_2 or var_678_2 * (utf8.len(var_678_3) / 8)

				if (8 <= 0 and var_678_2 or var_678_2 * (utf8.len(var_678_3) / 8)) > 0 and var_678_2 < var_678_5 then
					arg_675_1.talkMaxDuration = var_678_5

					if var_678_5 + var_678_1 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_5 + var_678_1
					end
				end

				arg_675_1.text_.text = var_678_3
				arg_675_1.typewritter.percent = 0

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(false)
				arg_675_1:RecordContent(arg_675_1.text_.text)
			end

			local var_678_6 = math.max(var_678_2, arg_675_1.talkMaxDuration)

			if var_678_1 <= arg_675_1.time_ and arg_675_1.time_ < var_678_1 + var_678_6 then
				arg_675_1.typewritter.percent = (arg_675_1.time_ - var_678_1) / var_678_6

				arg_675_1.typewritter:SetDirty()
			end

			if arg_675_1.time_ >= var_678_1 + var_678_6 and arg_675_1.time_ < var_678_1 + var_678_6 + arg_678_0 then
				arg_675_1.typewritter.percent = 1

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(true)
			end
		end

		arg_675_1.nodeConfigList_ = {}

		arg_675_1:InitPlayNodeList()
	end,
	Play1101905166 = function(arg_679_0, arg_679_1)
		arg_679_1.time_ = 0
		arg_679_1.frameCnt_ = 0
		arg_679_1.state_ = "playing"
		arg_679_1.curTalkId_ = 1101905166
		arg_679_1.duration_ = 6

		local var_679_0 = {
			zh = 4.833,
			ja = 6
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
				arg_679_0:Play1101905167(arg_679_1)
			end
		end

		function arg_679_1.onSingleLineUpdate_(arg_682_0)
			if 0 < arg_679_1.time_ and arg_679_1.time_ <= 0 + arg_682_0 and not isNil(arg_679_1.actors_["1019ui_story"]) and arg_679_1.var_.characterEffect1019ui_story == nil then
				arg_679_1.var_.characterEffect1019ui_story = arg_679_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_682_0 = 0.200000002980232

			if 0 <= arg_679_1.time_ and arg_679_1.time_ < 0 + var_682_0 and not isNil(arg_679_1.actors_["1019ui_story"]) then
				if arg_679_1.var_.characterEffect1019ui_story and not isNil(arg_679_1.actors_["1019ui_story"]) then
					arg_679_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_679_1.time_ >= 0 + var_682_0 and arg_679_1.time_ < 0 + var_682_0 + arg_682_0 and not isNil(arg_679_1.actors_["1019ui_story"]) and arg_679_1.var_.characterEffect1019ui_story then
				arg_679_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_682_2 = 0
			local var_682_3 = 0.325

			if 0 < arg_679_1.time_ and arg_679_1.time_ <= var_682_2 + arg_682_0 then
				arg_679_1.talkMaxDuration = 0
				arg_679_1.dialogCg_.alpha = 1

				arg_679_1.dialog_:SetActive(true)
				SetActive(arg_679_1.leftNameGo_, true)

				arg_679_1.leftNameTxt_.text = arg_679_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_679_1.leftNameTxt_.transform)

				arg_679_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_679_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_679_1:RecordName(arg_679_1.leftNameTxt_.text)
				SetActive(arg_679_1.iconTrs_.gameObject, false)
				arg_679_1.callingController_:SetSelectedState("normal")

				local var_682_4 = arg_679_1:GetWordFromCfg(1101905166)
				local var_682_5 = arg_679_1:FormatText(var_682_4.content)

				arg_679_1.text_.text = var_682_5

				LuaForUtil.ClearLinePrefixSymbol(arg_679_1.text_)

				local var_682_7 = 25 <= 0 and var_682_3 or var_682_3 * (utf8.len(var_682_5) / 25)

				if (25 <= 0 and var_682_3 or var_682_3 * (utf8.len(var_682_5) / 25)) > 0 and var_682_3 < var_682_7 then
					arg_679_1.talkMaxDuration = var_682_7

					if var_682_7 + var_682_2 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_7 + var_682_2
					end
				end

				arg_679_1.text_.text = var_682_5
				arg_679_1.typewritter.percent = 0

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905166", "story_v_side_new_1101905.awb") ~= 0 then
					local var_682_8 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905166", "story_v_side_new_1101905.awb") / 1000

					if var_682_8 + var_682_2 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_8 + var_682_2
					end

					if var_682_4.prefab_name ~= "" and arg_679_1.actors_[var_682_4.prefab_name] ~= nil then
						local var_682_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_679_1.actors_[var_682_4.prefab_name].transform, "story_v_side_new_1101905", "1101905166", "story_v_side_new_1101905.awb")

						arg_679_1:RecordAudio("1101905166", var_682_9)
						arg_679_1:RecordAudio("1101905166", var_682_9)
					else
						arg_679_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905166", "story_v_side_new_1101905.awb")
					end

					arg_679_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905166", "story_v_side_new_1101905.awb")
				end

				arg_679_1:RecordContent(arg_679_1.text_.text)
			end

			local var_682_10 = math.max(var_682_3, arg_679_1.talkMaxDuration)

			if var_682_2 <= arg_679_1.time_ and arg_679_1.time_ < var_682_2 + var_682_10 then
				arg_679_1.typewritter.percent = (arg_679_1.time_ - var_682_2) / var_682_10

				arg_679_1.typewritter:SetDirty()
			end

			if arg_679_1.time_ >= var_682_2 + var_682_10 and arg_679_1.time_ < var_682_2 + var_682_10 + arg_682_0 then
				arg_679_1.typewritter.percent = 1

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(true)
			end
		end

		arg_679_1.nodeConfigList_ = {}

		arg_679_1:InitPlayNodeList()
	end,
	Play1101905167 = function(arg_683_0, arg_683_1)
		arg_683_1.time_ = 0
		arg_683_1.frameCnt_ = 0
		arg_683_1.state_ = "playing"
		arg_683_1.curTalkId_ = 1101905167
		arg_683_1.duration_ = 5

		SetActive(arg_683_1.tipsGo_, false)

		function arg_683_1.onSingleLineFinish_()
			arg_683_1.onSingleLineUpdate_ = nil
			arg_683_1.onSingleLineFinish_ = nil
			arg_683_1.state_ = "waiting"
		end

		function arg_683_1.playNext_(arg_685_0)
			if arg_685_0 == 1 then
				arg_683_0:Play1101905168(arg_683_1)
			end
		end

		function arg_683_1.onSingleLineUpdate_(arg_686_0)
			if 0 < arg_683_1.time_ and arg_683_1.time_ <= 0 + arg_686_0 and not isNil(arg_683_1.actors_["1019ui_story"]) and arg_683_1.var_.characterEffect1019ui_story == nil then
				arg_683_1.var_.characterEffect1019ui_story = arg_683_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_686_0 = 0.200000002980232

			if 0 <= arg_683_1.time_ and arg_683_1.time_ < 0 + var_686_0 and not isNil(arg_683_1.actors_["1019ui_story"]) then
				if arg_683_1.var_.characterEffect1019ui_story and not isNil(arg_683_1.actors_["1019ui_story"]) then
					arg_683_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_683_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_683_1.time_ - 0) / var_686_0)
				end
			end

			if arg_683_1.time_ >= 0 + var_686_0 and arg_683_1.time_ < 0 + var_686_0 + arg_686_0 and not isNil(arg_683_1.actors_["1019ui_story"]) and arg_683_1.var_.characterEffect1019ui_story then
				arg_683_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_683_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_686_1 = 0
			local var_686_2 = 0.8

			if 0 < arg_683_1.time_ and arg_683_1.time_ <= var_686_1 + arg_686_0 then
				arg_683_1.talkMaxDuration = 0
				arg_683_1.dialogCg_.alpha = 1

				arg_683_1.dialog_:SetActive(true)
				SetActive(arg_683_1.leftNameGo_, true)

				arg_683_1.leftNameTxt_.text = arg_683_1:FormatText(StoryNameCfg[7].name)

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

				local var_686_3 = arg_683_1:FormatText(arg_683_1:GetWordFromCfg(1101905167).content)

				arg_683_1.text_.text = var_686_3

				LuaForUtil.ClearLinePrefixSymbol(arg_683_1.text_)

				local var_686_5 = 37 <= 0 and var_686_2 or var_686_2 * (utf8.len(var_686_3) / 37)

				if (37 <= 0 and var_686_2 or var_686_2 * (utf8.len(var_686_3) / 37)) > 0 and var_686_2 < var_686_5 then
					arg_683_1.talkMaxDuration = var_686_5

					if var_686_5 + var_686_1 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_5 + var_686_1
					end
				end

				arg_683_1.text_.text = var_686_3
				arg_683_1.typewritter.percent = 0

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(false)
				arg_683_1:RecordContent(arg_683_1.text_.text)
			end

			local var_686_6 = math.max(var_686_2, arg_683_1.talkMaxDuration)

			if var_686_1 <= arg_683_1.time_ and arg_683_1.time_ < var_686_1 + var_686_6 then
				arg_683_1.typewritter.percent = (arg_683_1.time_ - var_686_1) / var_686_6

				arg_683_1.typewritter:SetDirty()
			end

			if arg_683_1.time_ >= var_686_1 + var_686_6 and arg_683_1.time_ < var_686_1 + var_686_6 + arg_686_0 then
				arg_683_1.typewritter.percent = 1

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(true)
			end
		end

		arg_683_1.nodeConfigList_ = {}

		arg_683_1:InitPlayNodeList()
	end,
	Play1101905168 = function(arg_687_0, arg_687_1)
		arg_687_1.time_ = 0
		arg_687_1.frameCnt_ = 0
		arg_687_1.state_ = "playing"
		arg_687_1.curTalkId_ = 1101905168
		arg_687_1.duration_ = 7.9

		local var_687_0 = {
			zh = 6.933,
			ja = 7.9
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
				arg_687_0:Play1101905169(arg_687_1)
			end
		end

		function arg_687_1.onSingleLineUpdate_(arg_690_0)
			if 0 < arg_687_1.time_ and arg_687_1.time_ <= 0 + arg_690_0 and not isNil(arg_687_1.actors_["1019ui_story"]) and arg_687_1.var_.characterEffect1019ui_story == nil then
				arg_687_1.var_.characterEffect1019ui_story = arg_687_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_690_0 = 0.200000002980232

			if 0 <= arg_687_1.time_ and arg_687_1.time_ < 0 + var_690_0 and not isNil(arg_687_1.actors_["1019ui_story"]) then
				if arg_687_1.var_.characterEffect1019ui_story and not isNil(arg_687_1.actors_["1019ui_story"]) then
					arg_687_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_687_1.time_ >= 0 + var_690_0 and arg_687_1.time_ < 0 + var_690_0 + arg_690_0 and not isNil(arg_687_1.actors_["1019ui_story"]) and arg_687_1.var_.characterEffect1019ui_story then
				arg_687_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_690_2 = 0
			local var_690_3 = 0.325

			if 0 < arg_687_1.time_ and arg_687_1.time_ <= var_690_2 + arg_690_0 then
				arg_687_1.talkMaxDuration = 0
				arg_687_1.dialogCg_.alpha = 1

				arg_687_1.dialog_:SetActive(true)
				SetActive(arg_687_1.leftNameGo_, true)

				arg_687_1.leftNameTxt_.text = arg_687_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_687_1.leftNameTxt_.transform)

				arg_687_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_687_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_687_1:RecordName(arg_687_1.leftNameTxt_.text)
				SetActive(arg_687_1.iconTrs_.gameObject, false)
				arg_687_1.callingController_:SetSelectedState("normal")

				local var_690_4 = arg_687_1:GetWordFromCfg(1101905168)
				local var_690_5 = arg_687_1:FormatText(var_690_4.content)

				arg_687_1.text_.text = var_690_5

				LuaForUtil.ClearLinePrefixSymbol(arg_687_1.text_)

				local var_690_7 = 31 <= 0 and var_690_3 or var_690_3 * (utf8.len(var_690_5) / 31)

				if (31 <= 0 and var_690_3 or var_690_3 * (utf8.len(var_690_5) / 31)) > 0 and var_690_3 < var_690_7 then
					arg_687_1.talkMaxDuration = var_690_7

					if var_690_7 + var_690_2 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_7 + var_690_2
					end
				end

				arg_687_1.text_.text = var_690_5
				arg_687_1.typewritter.percent = 0

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905168", "story_v_side_new_1101905.awb") ~= 0 then
					local var_690_8 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905168", "story_v_side_new_1101905.awb") / 1000

					if var_690_8 + var_690_2 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_8 + var_690_2
					end

					if var_690_4.prefab_name ~= "" and arg_687_1.actors_[var_690_4.prefab_name] ~= nil then
						local var_690_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_687_1.actors_[var_690_4.prefab_name].transform, "story_v_side_new_1101905", "1101905168", "story_v_side_new_1101905.awb")

						arg_687_1:RecordAudio("1101905168", var_690_9)
						arg_687_1:RecordAudio("1101905168", var_690_9)
					else
						arg_687_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905168", "story_v_side_new_1101905.awb")
					end

					arg_687_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905168", "story_v_side_new_1101905.awb")
				end

				arg_687_1:RecordContent(arg_687_1.text_.text)
			end

			local var_690_10 = math.max(var_690_3, arg_687_1.talkMaxDuration)

			if var_690_2 <= arg_687_1.time_ and arg_687_1.time_ < var_690_2 + var_690_10 then
				arg_687_1.typewritter.percent = (arg_687_1.time_ - var_690_2) / var_690_10

				arg_687_1.typewritter:SetDirty()
			end

			if arg_687_1.time_ >= var_690_2 + var_690_10 and arg_687_1.time_ < var_690_2 + var_690_10 + arg_690_0 then
				arg_687_1.typewritter.percent = 1

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(true)
			end
		end

		arg_687_1.nodeConfigList_ = {}

		arg_687_1:InitPlayNodeList()
	end,
	Play1101905169 = function(arg_691_0, arg_691_1)
		arg_691_1.time_ = 0
		arg_691_1.frameCnt_ = 0
		arg_691_1.state_ = "playing"
		arg_691_1.curTalkId_ = 1101905169
		arg_691_1.duration_ = 5

		SetActive(arg_691_1.tipsGo_, false)

		function arg_691_1.onSingleLineFinish_()
			arg_691_1.onSingleLineUpdate_ = nil
			arg_691_1.onSingleLineFinish_ = nil
			arg_691_1.state_ = "waiting"
		end

		function arg_691_1.playNext_(arg_693_0)
			if arg_693_0 == 1 then
				arg_691_0:Play1101905170(arg_691_1)
			end
		end

		function arg_691_1.onSingleLineUpdate_(arg_694_0)
			if 0 < arg_691_1.time_ and arg_691_1.time_ <= 0 + arg_694_0 and not isNil(arg_691_1.actors_["1019ui_story"]) and arg_691_1.var_.characterEffect1019ui_story == nil then
				arg_691_1.var_.characterEffect1019ui_story = arg_691_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_694_0 = 0.200000002980232

			if 0 <= arg_691_1.time_ and arg_691_1.time_ < 0 + var_694_0 and not isNil(arg_691_1.actors_["1019ui_story"]) then
				if arg_691_1.var_.characterEffect1019ui_story and not isNil(arg_691_1.actors_["1019ui_story"]) then
					arg_691_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_691_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_691_1.time_ - 0) / var_694_0)
				end
			end

			if arg_691_1.time_ >= 0 + var_694_0 and arg_691_1.time_ < 0 + var_694_0 + arg_694_0 and not isNil(arg_691_1.actors_["1019ui_story"]) and arg_691_1.var_.characterEffect1019ui_story then
				arg_691_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_691_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_694_1 = 0
			local var_694_2 = 0.2

			if 0 < arg_691_1.time_ and arg_691_1.time_ <= var_694_1 + arg_694_0 then
				arg_691_1.talkMaxDuration = 0
				arg_691_1.dialogCg_.alpha = 1

				arg_691_1.dialog_:SetActive(true)
				SetActive(arg_691_1.leftNameGo_, false)

				arg_691_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_691_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_691_1:RecordName(arg_691_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_691_1.iconTrs_.gameObject, false)
				arg_691_1.callingController_:SetSelectedState("normal")

				local var_694_3 = arg_691_1:FormatText(arg_691_1:GetWordFromCfg(1101905169).content)

				arg_691_1.text_.text = var_694_3

				LuaForUtil.ClearLinePrefixSymbol(arg_691_1.text_)

				local var_694_5 = 22 <= 0 and var_694_2 or var_694_2 * (utf8.len(var_694_3) / 22)

				if (22 <= 0 and var_694_2 or var_694_2 * (utf8.len(var_694_3) / 22)) > 0 and var_694_2 < var_694_5 then
					arg_691_1.talkMaxDuration = var_694_5

					if var_694_5 + var_694_1 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_5 + var_694_1
					end
				end

				arg_691_1.text_.text = var_694_3
				arg_691_1.typewritter.percent = 0

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(false)
				arg_691_1:RecordContent(arg_691_1.text_.text)
			end

			local var_694_6 = math.max(var_694_2, arg_691_1.talkMaxDuration)

			if var_694_1 <= arg_691_1.time_ and arg_691_1.time_ < var_694_1 + var_694_6 then
				arg_691_1.typewritter.percent = (arg_691_1.time_ - var_694_1) / var_694_6

				arg_691_1.typewritter:SetDirty()
			end

			if arg_691_1.time_ >= var_694_1 + var_694_6 and arg_691_1.time_ < var_694_1 + var_694_6 + arg_694_0 then
				arg_691_1.typewritter.percent = 1

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(true)
			end
		end

		arg_691_1.nodeConfigList_ = {}

		arg_691_1:InitPlayNodeList()
	end,
	Play1101905170 = function(arg_695_0, arg_695_1)
		arg_695_1.time_ = 0
		arg_695_1.frameCnt_ = 0
		arg_695_1.state_ = "playing"
		arg_695_1.curTalkId_ = 1101905170
		arg_695_1.duration_ = 5

		SetActive(arg_695_1.tipsGo_, false)

		function arg_695_1.onSingleLineFinish_()
			arg_695_1.onSingleLineUpdate_ = nil
			arg_695_1.onSingleLineFinish_ = nil
			arg_695_1.state_ = "waiting"
		end

		function arg_695_1.playNext_(arg_697_0)
			if arg_697_0 == 1 then
				arg_695_0:Play1101905171(arg_695_1)
			end
		end

		function arg_695_1.onSingleLineUpdate_(arg_698_0)
			local var_698_0 = 0.625

			if 0 < arg_695_1.time_ and arg_695_1.time_ <= 0 + arg_698_0 then
				arg_695_1.talkMaxDuration = 0
				arg_695_1.dialogCg_.alpha = 1

				arg_695_1.dialog_:SetActive(true)
				SetActive(arg_695_1.leftNameGo_, false)

				arg_695_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_695_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_695_1:RecordName(arg_695_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_695_1.iconTrs_.gameObject, false)
				arg_695_1.callingController_:SetSelectedState("normal")

				local var_698_1 = arg_695_1:FormatText(arg_695_1:GetWordFromCfg(1101905170).content)

				arg_695_1.text_.text = var_698_1

				LuaForUtil.ClearLinePrefixSymbol(arg_695_1.text_)

				local var_698_3 = 12 <= 0 and var_698_0 or var_698_0 * (utf8.len(var_698_1) / 12)

				if (12 <= 0 and var_698_0 or var_698_0 * (utf8.len(var_698_1) / 12)) > 0 and var_698_0 < var_698_3 then
					arg_695_1.talkMaxDuration = var_698_3

					if var_698_3 + 0 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_3 + 0
					end
				end

				arg_695_1.text_.text = var_698_1
				arg_695_1.typewritter.percent = 0

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(false)
				arg_695_1:RecordContent(arg_695_1.text_.text)
			end

			local var_698_4 = math.max(var_698_0, arg_695_1.talkMaxDuration)

			if 0 <= arg_695_1.time_ and arg_695_1.time_ < 0 + var_698_4 then
				arg_695_1.typewritter.percent = (arg_695_1.time_ - 0) / var_698_4

				arg_695_1.typewritter:SetDirty()
			end

			if arg_695_1.time_ >= 0 + var_698_4 and arg_695_1.time_ < 0 + var_698_4 + arg_698_0 then
				arg_695_1.typewritter.percent = 1

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(true)
			end
		end

		arg_695_1.nodeConfigList_ = {}

		arg_695_1:InitPlayNodeList()
	end,
	Play1101905171 = function(arg_699_0, arg_699_1)
		arg_699_1.time_ = 0
		arg_699_1.frameCnt_ = 0
		arg_699_1.state_ = "playing"
		arg_699_1.curTalkId_ = 1101905171
		arg_699_1.duration_ = 5

		SetActive(arg_699_1.tipsGo_, false)

		function arg_699_1.onSingleLineFinish_()
			arg_699_1.onSingleLineUpdate_ = nil
			arg_699_1.onSingleLineFinish_ = nil
			arg_699_1.state_ = "waiting"
		end

		function arg_699_1.playNext_(arg_701_0)
			if arg_701_0 == 1 then
				arg_699_0:Play1101905172(arg_699_1)
			end
		end

		function arg_699_1.onSingleLineUpdate_(arg_702_0)
			local var_702_0 = 0.925

			if 0 < arg_699_1.time_ and arg_699_1.time_ <= 0 + arg_702_0 then
				arg_699_1.talkMaxDuration = 0
				arg_699_1.dialogCg_.alpha = 1

				arg_699_1.dialog_:SetActive(true)
				SetActive(arg_699_1.leftNameGo_, true)

				arg_699_1.leftNameTxt_.text = arg_699_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_699_1.leftNameTxt_.transform)

				arg_699_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_699_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_699_1:RecordName(arg_699_1.leftNameTxt_.text)
				SetActive(arg_699_1.iconTrs_.gameObject, true)
				arg_699_1.iconController_:SetSelectedState("hero")

				arg_699_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_699_1.callingController_:SetSelectedState("normal")

				arg_699_1.keyicon_.color = Color.New(1, 1, 1)
				arg_699_1.icon_.color = Color.New(1, 1, 1)

				local var_702_1 = arg_699_1:FormatText(arg_699_1:GetWordFromCfg(1101905171).content)

				arg_699_1.text_.text = var_702_1

				LuaForUtil.ClearLinePrefixSymbol(arg_699_1.text_)

				local var_702_3 = 27 <= 0 and var_702_0 or var_702_0 * (utf8.len(var_702_1) / 27)

				if (27 <= 0 and var_702_0 or var_702_0 * (utf8.len(var_702_1) / 27)) > 0 and var_702_0 < var_702_3 then
					arg_699_1.talkMaxDuration = var_702_3

					if var_702_3 + 0 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_3 + 0
					end
				end

				arg_699_1.text_.text = var_702_1
				arg_699_1.typewritter.percent = 0

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(false)
				arg_699_1:RecordContent(arg_699_1.text_.text)
			end

			local var_702_4 = math.max(var_702_0, arg_699_1.talkMaxDuration)

			if 0 <= arg_699_1.time_ and arg_699_1.time_ < 0 + var_702_4 then
				arg_699_1.typewritter.percent = (arg_699_1.time_ - 0) / var_702_4

				arg_699_1.typewritter:SetDirty()
			end

			if arg_699_1.time_ >= 0 + var_702_4 and arg_699_1.time_ < 0 + var_702_4 + arg_702_0 then
				arg_699_1.typewritter.percent = 1

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(true)
			end
		end

		arg_699_1.nodeConfigList_ = {}

		arg_699_1:InitPlayNodeList()
	end,
	Play1101905172 = function(arg_703_0, arg_703_1)
		arg_703_1.time_ = 0
		arg_703_1.frameCnt_ = 0
		arg_703_1.state_ = "playing"
		arg_703_1.curTalkId_ = 1101905172
		arg_703_1.duration_ = 6.63

		local var_703_0 = {
			zh = 3.7,
			ja = 6.633
		}
		local var_703_1 = manager.audio:GetLocalizationFlag()

		if var_703_0[var_703_1] ~= nil then
			arg_703_1.duration_ = var_703_0[var_703_1]
		end

		SetActive(arg_703_1.tipsGo_, false)

		function arg_703_1.onSingleLineFinish_()
			arg_703_1.onSingleLineUpdate_ = nil
			arg_703_1.onSingleLineFinish_ = nil
			arg_703_1.state_ = "waiting"
		end

		function arg_703_1.playNext_(arg_705_0)
			if arg_705_0 == 1 then
				arg_703_0:Play1101905173(arg_703_1)
			end
		end

		function arg_703_1.onSingleLineUpdate_(arg_706_0)
			if 0 < arg_703_1.time_ and arg_703_1.time_ <= 0 + arg_706_0 then
				arg_703_1.var_.moveOldPos1019ui_story = arg_703_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_706_0 = 0.001

			if 0 <= arg_703_1.time_ and arg_703_1.time_ < 0 + var_706_0 then
				arg_703_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_703_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_703_1.time_ - 0) / var_706_0)
				arg_703_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_703_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_703_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_703_1.actors_["1019ui_story"].transform.position).z)
				arg_703_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_703_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_703_1.actors_["1019ui_story"].transform.localEulerAngles = arg_703_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_703_1.time_ >= 0 + var_706_0 and arg_703_1.time_ < 0 + var_706_0 + arg_706_0 then
				arg_703_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_703_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_703_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_703_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_703_1.actors_["1019ui_story"].transform.position).z)
				arg_703_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_703_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_703_1.actors_["1019ui_story"].transform.localEulerAngles = arg_703_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_706_1 = arg_703_1.actors_["1019ui_story"]

			if 0 < arg_703_1.time_ and arg_703_1.time_ <= 0 + arg_706_0 and not isNil(var_706_1) and arg_703_1.var_.characterEffect1019ui_story == nil then
				arg_703_1.var_.characterEffect1019ui_story = var_706_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_706_2 = 0.200000002980232

			if 0 <= arg_703_1.time_ and arg_703_1.time_ < 0 + var_706_2 and not isNil(var_706_1) then
				if arg_703_1.var_.characterEffect1019ui_story and not isNil(var_706_1) then
					arg_703_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_703_1.time_ >= 0 + var_706_2 and arg_703_1.time_ < 0 + var_706_2 + arg_706_0 and not isNil(var_706_1) and arg_703_1.var_.characterEffect1019ui_story then
				arg_703_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_703_1.time_ and arg_703_1.time_ <= 0 + arg_706_0 then
				arg_703_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_703_1.time_ and arg_703_1.time_ <= 0 + arg_706_0 then
				arg_703_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_706_4 = 0
			local var_706_5 = 0.775

			if 0 < arg_703_1.time_ and arg_703_1.time_ <= var_706_4 + arg_706_0 then
				arg_703_1.talkMaxDuration = 0
				arg_703_1.dialogCg_.alpha = 1

				arg_703_1.dialog_:SetActive(true)
				SetActive(arg_703_1.leftNameGo_, true)

				arg_703_1.leftNameTxt_.text = arg_703_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_703_1.leftNameTxt_.transform)

				arg_703_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_703_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_703_1:RecordName(arg_703_1.leftNameTxt_.text)
				SetActive(arg_703_1.iconTrs_.gameObject, false)
				arg_703_1.callingController_:SetSelectedState("normal")

				local var_706_6 = arg_703_1:GetWordFromCfg(1101905172)
				local var_706_7 = arg_703_1:FormatText(var_706_6.content)

				arg_703_1.text_.text = var_706_7

				LuaForUtil.ClearLinePrefixSymbol(arg_703_1.text_)

				local var_706_9 = 17 <= 0 and var_706_5 or var_706_5 * (utf8.len(var_706_7) / 17)

				if (17 <= 0 and var_706_5 or var_706_5 * (utf8.len(var_706_7) / 17)) > 0 and var_706_5 < var_706_9 then
					arg_703_1.talkMaxDuration = var_706_9

					if var_706_9 + var_706_4 > arg_703_1.duration_ then
						arg_703_1.duration_ = var_706_9 + var_706_4
					end
				end

				arg_703_1.text_.text = var_706_7
				arg_703_1.typewritter.percent = 0

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905172", "story_v_side_new_1101905.awb") ~= 0 then
					local var_706_10 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905172", "story_v_side_new_1101905.awb") / 1000

					if var_706_10 + var_706_4 > arg_703_1.duration_ then
						arg_703_1.duration_ = var_706_10 + var_706_4
					end

					if var_706_6.prefab_name ~= "" and arg_703_1.actors_[var_706_6.prefab_name] ~= nil then
						local var_706_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_703_1.actors_[var_706_6.prefab_name].transform, "story_v_side_new_1101905", "1101905172", "story_v_side_new_1101905.awb")

						arg_703_1:RecordAudio("1101905172", var_706_11)
						arg_703_1:RecordAudio("1101905172", var_706_11)
					else
						arg_703_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905172", "story_v_side_new_1101905.awb")
					end

					arg_703_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905172", "story_v_side_new_1101905.awb")
				end

				arg_703_1:RecordContent(arg_703_1.text_.text)
			end

			local var_706_12 = math.max(var_706_5, arg_703_1.talkMaxDuration)

			if var_706_4 <= arg_703_1.time_ and arg_703_1.time_ < var_706_4 + var_706_12 then
				arg_703_1.typewritter.percent = (arg_703_1.time_ - var_706_4) / var_706_12

				arg_703_1.typewritter:SetDirty()
			end

			if arg_703_1.time_ >= var_706_4 + var_706_12 and arg_703_1.time_ < var_706_4 + var_706_12 + arg_706_0 then
				arg_703_1.typewritter.percent = 1

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(true)
			end
		end

		arg_703_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_703_1:InitPlayNodeList()
	end,
	Play1101905173 = function(arg_707_0, arg_707_1)
		arg_707_1.time_ = 0
		arg_707_1.frameCnt_ = 0
		arg_707_1.state_ = "playing"
		arg_707_1.curTalkId_ = 1101905173
		arg_707_1.duration_ = 9.77

		local var_707_0 = {
			zh = 7.4,
			ja = 9.766
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
				arg_707_0:Play1101905174(arg_707_1)
			end
		end

		function arg_707_1.onSingleLineUpdate_(arg_710_0)
			local var_710_0 = 0.55

			if 0 < arg_707_1.time_ and arg_707_1.time_ <= 0 + arg_710_0 then
				arg_707_1.talkMaxDuration = 0
				arg_707_1.dialogCg_.alpha = 1

				arg_707_1.dialog_:SetActive(true)
				SetActive(arg_707_1.leftNameGo_, true)

				arg_707_1.leftNameTxt_.text = arg_707_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_707_1.leftNameTxt_.transform)

				arg_707_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_707_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_707_1:RecordName(arg_707_1.leftNameTxt_.text)
				SetActive(arg_707_1.iconTrs_.gameObject, false)
				arg_707_1.callingController_:SetSelectedState("normal")

				local var_710_1 = arg_707_1:GetWordFromCfg(1101905173)
				local var_710_2 = arg_707_1:FormatText(var_710_1.content)

				arg_707_1.text_.text = var_710_2

				LuaForUtil.ClearLinePrefixSymbol(arg_707_1.text_)

				local var_710_4 = 35 <= 0 and var_710_0 or var_710_0 * (utf8.len(var_710_2) / 35)

				if (35 <= 0 and var_710_0 or var_710_0 * (utf8.len(var_710_2) / 35)) > 0 and var_710_0 < var_710_4 then
					arg_707_1.talkMaxDuration = var_710_4

					if var_710_4 + 0 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_4 + 0
					end
				end

				arg_707_1.text_.text = var_710_2
				arg_707_1.typewritter.percent = 0

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905173", "story_v_side_new_1101905.awb") ~= 0 then
					local var_710_5 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905173", "story_v_side_new_1101905.awb") / 1000

					if var_710_5 + 0 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_5 + 0
					end

					if var_710_1.prefab_name ~= "" and arg_707_1.actors_[var_710_1.prefab_name] ~= nil then
						local var_710_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_707_1.actors_[var_710_1.prefab_name].transform, "story_v_side_new_1101905", "1101905173", "story_v_side_new_1101905.awb")

						arg_707_1:RecordAudio("1101905173", var_710_6)
						arg_707_1:RecordAudio("1101905173", var_710_6)
					else
						arg_707_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905173", "story_v_side_new_1101905.awb")
					end

					arg_707_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905173", "story_v_side_new_1101905.awb")
				end

				arg_707_1:RecordContent(arg_707_1.text_.text)
			end

			local var_710_7 = math.max(var_710_0, arg_707_1.talkMaxDuration)

			if 0 <= arg_707_1.time_ and arg_707_1.time_ < 0 + var_710_7 then
				arg_707_1.typewritter.percent = (arg_707_1.time_ - 0) / var_710_7

				arg_707_1.typewritter:SetDirty()
			end

			if arg_707_1.time_ >= 0 + var_710_7 and arg_707_1.time_ < 0 + var_710_7 + arg_710_0 then
				arg_707_1.typewritter.percent = 1

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(true)
			end
		end

		arg_707_1.nodeConfigList_ = {}

		arg_707_1:InitPlayNodeList()
	end,
	Play1101905174 = function(arg_711_0, arg_711_1)
		arg_711_1.time_ = 0
		arg_711_1.frameCnt_ = 0
		arg_711_1.state_ = "playing"
		arg_711_1.curTalkId_ = 1101905174
		arg_711_1.duration_ = 8

		local var_711_0 = {
			zh = 4.2,
			ja = 8
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
				arg_711_0:Play1101905175(arg_711_1)
			end
		end

		function arg_711_1.onSingleLineUpdate_(arg_714_0)
			local var_714_0 = 0.3

			if 0 < arg_711_1.time_ and arg_711_1.time_ <= 0 + arg_714_0 then
				arg_711_1.talkMaxDuration = 0
				arg_711_1.dialogCg_.alpha = 1

				arg_711_1.dialog_:SetActive(true)
				SetActive(arg_711_1.leftNameGo_, true)

				arg_711_1.leftNameTxt_.text = arg_711_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_711_1.leftNameTxt_.transform)

				arg_711_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_711_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_711_1:RecordName(arg_711_1.leftNameTxt_.text)
				SetActive(arg_711_1.iconTrs_.gameObject, false)
				arg_711_1.callingController_:SetSelectedState("normal")

				local var_714_1 = arg_711_1:GetWordFromCfg(1101905174)
				local var_714_2 = arg_711_1:FormatText(var_714_1.content)

				arg_711_1.text_.text = var_714_2

				LuaForUtil.ClearLinePrefixSymbol(arg_711_1.text_)

				local var_714_4 = 14 <= 0 and var_714_0 or var_714_0 * (utf8.len(var_714_2) / 14)

				if (14 <= 0 and var_714_0 or var_714_0 * (utf8.len(var_714_2) / 14)) > 0 and var_714_0 < var_714_4 then
					arg_711_1.talkMaxDuration = var_714_4

					if var_714_4 + 0 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_4 + 0
					end
				end

				arg_711_1.text_.text = var_714_2
				arg_711_1.typewritter.percent = 0

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905174", "story_v_side_new_1101905.awb") ~= 0 then
					local var_714_5 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905174", "story_v_side_new_1101905.awb") / 1000

					if var_714_5 + 0 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_5 + 0
					end

					if var_714_1.prefab_name ~= "" and arg_711_1.actors_[var_714_1.prefab_name] ~= nil then
						local var_714_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_711_1.actors_[var_714_1.prefab_name].transform, "story_v_side_new_1101905", "1101905174", "story_v_side_new_1101905.awb")

						arg_711_1:RecordAudio("1101905174", var_714_6)
						arg_711_1:RecordAudio("1101905174", var_714_6)
					else
						arg_711_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905174", "story_v_side_new_1101905.awb")
					end

					arg_711_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905174", "story_v_side_new_1101905.awb")
				end

				arg_711_1:RecordContent(arg_711_1.text_.text)
			end

			local var_714_7 = math.max(var_714_0, arg_711_1.talkMaxDuration)

			if 0 <= arg_711_1.time_ and arg_711_1.time_ < 0 + var_714_7 then
				arg_711_1.typewritter.percent = (arg_711_1.time_ - 0) / var_714_7

				arg_711_1.typewritter:SetDirty()
			end

			if arg_711_1.time_ >= 0 + var_714_7 and arg_711_1.time_ < 0 + var_714_7 + arg_714_0 then
				arg_711_1.typewritter.percent = 1

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(true)
			end
		end

		arg_711_1.nodeConfigList_ = {}

		arg_711_1:InitPlayNodeList()
	end,
	Play1101905175 = function(arg_715_0, arg_715_1)
		arg_715_1.time_ = 0
		arg_715_1.frameCnt_ = 0
		arg_715_1.state_ = "playing"
		arg_715_1.curTalkId_ = 1101905175
		arg_715_1.duration_ = 5

		SetActive(arg_715_1.tipsGo_, false)

		function arg_715_1.onSingleLineFinish_()
			arg_715_1.onSingleLineUpdate_ = nil
			arg_715_1.onSingleLineFinish_ = nil
			arg_715_1.state_ = "waiting"
		end

		function arg_715_1.playNext_(arg_717_0)
			if arg_717_0 == 1 then
				arg_715_0:Play1101905176(arg_715_1)
			end
		end

		function arg_715_1.onSingleLineUpdate_(arg_718_0)
			if 0 < arg_715_1.time_ and arg_715_1.time_ <= 0 + arg_718_0 and not isNil(arg_715_1.actors_["1019ui_story"]) and arg_715_1.var_.characterEffect1019ui_story == nil then
				arg_715_1.var_.characterEffect1019ui_story = arg_715_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_718_0 = 0.200000002980232

			if 0 <= arg_715_1.time_ and arg_715_1.time_ < 0 + var_718_0 and not isNil(arg_715_1.actors_["1019ui_story"]) then
				if arg_715_1.var_.characterEffect1019ui_story and not isNil(arg_715_1.actors_["1019ui_story"]) then
					arg_715_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_715_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_715_1.time_ - 0) / var_718_0)
				end
			end

			if arg_715_1.time_ >= 0 + var_718_0 and arg_715_1.time_ < 0 + var_718_0 + arg_718_0 and not isNil(arg_715_1.actors_["1019ui_story"]) and arg_715_1.var_.characterEffect1019ui_story then
				arg_715_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_715_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_718_1 = 0
			local var_718_2 = 0.675

			if 0 < arg_715_1.time_ and arg_715_1.time_ <= var_718_1 + arg_718_0 then
				arg_715_1.talkMaxDuration = 0
				arg_715_1.dialogCg_.alpha = 1

				arg_715_1.dialog_:SetActive(true)
				SetActive(arg_715_1.leftNameGo_, true)

				arg_715_1.leftNameTxt_.text = arg_715_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_715_1.leftNameTxt_.transform)

				arg_715_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_715_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_715_1:RecordName(arg_715_1.leftNameTxt_.text)
				SetActive(arg_715_1.iconTrs_.gameObject, true)
				arg_715_1.iconController_:SetSelectedState("hero")

				arg_715_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_715_1.callingController_:SetSelectedState("normal")

				arg_715_1.keyicon_.color = Color.New(1, 1, 1)
				arg_715_1.icon_.color = Color.New(1, 1, 1)

				local var_718_3 = arg_715_1:FormatText(arg_715_1:GetWordFromCfg(1101905175).content)

				arg_715_1.text_.text = var_718_3

				LuaForUtil.ClearLinePrefixSymbol(arg_715_1.text_)

				local var_718_5 = 17 <= 0 and var_718_2 or var_718_2 * (utf8.len(var_718_3) / 17)

				if (17 <= 0 and var_718_2 or var_718_2 * (utf8.len(var_718_3) / 17)) > 0 and var_718_2 < var_718_5 then
					arg_715_1.talkMaxDuration = var_718_5

					if var_718_5 + var_718_1 > arg_715_1.duration_ then
						arg_715_1.duration_ = var_718_5 + var_718_1
					end
				end

				arg_715_1.text_.text = var_718_3
				arg_715_1.typewritter.percent = 0

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(false)
				arg_715_1:RecordContent(arg_715_1.text_.text)
			end

			local var_718_6 = math.max(var_718_2, arg_715_1.talkMaxDuration)

			if var_718_1 <= arg_715_1.time_ and arg_715_1.time_ < var_718_1 + var_718_6 then
				arg_715_1.typewritter.percent = (arg_715_1.time_ - var_718_1) / var_718_6

				arg_715_1.typewritter:SetDirty()
			end

			if arg_715_1.time_ >= var_718_1 + var_718_6 and arg_715_1.time_ < var_718_1 + var_718_6 + arg_718_0 then
				arg_715_1.typewritter.percent = 1

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(true)
			end
		end

		arg_715_1.nodeConfigList_ = {}

		arg_715_1:InitPlayNodeList()
	end,
	Play1101905176 = function(arg_719_0, arg_719_1)
		arg_719_1.time_ = 0
		arg_719_1.frameCnt_ = 0
		arg_719_1.state_ = "playing"
		arg_719_1.curTalkId_ = 1101905176
		arg_719_1.duration_ = 4.83

		local var_719_0 = {
			zh = 4.8,
			ja = 4.833
		}
		local var_719_1 = manager.audio:GetLocalizationFlag()

		if var_719_0[var_719_1] ~= nil then
			arg_719_1.duration_ = var_719_0[var_719_1]
		end

		SetActive(arg_719_1.tipsGo_, false)

		function arg_719_1.onSingleLineFinish_()
			arg_719_1.onSingleLineUpdate_ = nil
			arg_719_1.onSingleLineFinish_ = nil
			arg_719_1.state_ = "waiting"
		end

		function arg_719_1.playNext_(arg_721_0)
			if arg_721_0 == 1 then
				arg_719_0:Play1101905177(arg_719_1)
			end
		end

		function arg_719_1.onSingleLineUpdate_(arg_722_0)
			local var_722_0 = 0.425

			if 0 < arg_719_1.time_ and arg_719_1.time_ <= 0 + arg_722_0 then
				arg_719_1.talkMaxDuration = 0
				arg_719_1.dialogCg_.alpha = 1

				arg_719_1.dialog_:SetActive(true)
				SetActive(arg_719_1.leftNameGo_, true)

				arg_719_1.leftNameTxt_.text = arg_719_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_719_1.leftNameTxt_.transform)

				arg_719_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_719_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_719_1:RecordName(arg_719_1.leftNameTxt_.text)
				SetActive(arg_719_1.iconTrs_.gameObject, true)
				arg_719_1.iconController_:SetSelectedState("hero")

				arg_719_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_719_1.callingController_:SetSelectedState("normal")

				arg_719_1.keyicon_.color = Color.New(1, 1, 1)
				arg_719_1.icon_.color = Color.New(1, 1, 1)

				local var_722_1 = arg_719_1:GetWordFromCfg(1101905176)
				local var_722_2 = arg_719_1:FormatText(var_722_1.content)

				arg_719_1.text_.text = var_722_2

				LuaForUtil.ClearLinePrefixSymbol(arg_719_1.text_)

				local var_722_4 = 20 <= 0 and var_722_0 or var_722_0 * (utf8.len(var_722_2) / 20)

				if (20 <= 0 and var_722_0 or var_722_0 * (utf8.len(var_722_2) / 20)) > 0 and var_722_0 < var_722_4 then
					arg_719_1.talkMaxDuration = var_722_4

					if var_722_4 + 0 > arg_719_1.duration_ then
						arg_719_1.duration_ = var_722_4 + 0
					end
				end

				arg_719_1.text_.text = var_722_2
				arg_719_1.typewritter.percent = 0

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905176", "story_v_side_new_1101905.awb") ~= 0 then
					local var_722_5 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905176", "story_v_side_new_1101905.awb") / 1000

					if var_722_5 + 0 > arg_719_1.duration_ then
						arg_719_1.duration_ = var_722_5 + 0
					end

					if var_722_1.prefab_name ~= "" and arg_719_1.actors_[var_722_1.prefab_name] ~= nil then
						local var_722_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_719_1.actors_[var_722_1.prefab_name].transform, "story_v_side_new_1101905", "1101905176", "story_v_side_new_1101905.awb")

						arg_719_1:RecordAudio("1101905176", var_722_6)
						arg_719_1:RecordAudio("1101905176", var_722_6)
					else
						arg_719_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905176", "story_v_side_new_1101905.awb")
					end

					arg_719_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905176", "story_v_side_new_1101905.awb")
				end

				arg_719_1:RecordContent(arg_719_1.text_.text)
			end

			local var_722_7 = math.max(var_722_0, arg_719_1.talkMaxDuration)

			if 0 <= arg_719_1.time_ and arg_719_1.time_ < 0 + var_722_7 then
				arg_719_1.typewritter.percent = (arg_719_1.time_ - 0) / var_722_7

				arg_719_1.typewritter:SetDirty()
			end

			if arg_719_1.time_ >= 0 + var_722_7 and arg_719_1.time_ < 0 + var_722_7 + arg_722_0 then
				arg_719_1.typewritter.percent = 1

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(true)
			end
		end

		arg_719_1.nodeConfigList_ = {}

		arg_719_1:InitPlayNodeList()
	end,
	Play1101905177 = function(arg_723_0, arg_723_1)
		arg_723_1.time_ = 0
		arg_723_1.frameCnt_ = 0
		arg_723_1.state_ = "playing"
		arg_723_1.curTalkId_ = 1101905177
		arg_723_1.duration_ = 5

		SetActive(arg_723_1.tipsGo_, false)

		function arg_723_1.onSingleLineFinish_()
			arg_723_1.onSingleLineUpdate_ = nil
			arg_723_1.onSingleLineFinish_ = nil
			arg_723_1.state_ = "waiting"
		end

		function arg_723_1.playNext_(arg_725_0)
			if arg_725_0 == 1 then
				arg_723_0:Play1101905178(arg_723_1)
			end
		end

		function arg_723_1.onSingleLineUpdate_(arg_726_0)
			local var_726_0 = 0.875

			if 0 < arg_723_1.time_ and arg_723_1.time_ <= 0 + arg_726_0 then
				arg_723_1.talkMaxDuration = 0
				arg_723_1.dialogCg_.alpha = 1

				arg_723_1.dialog_:SetActive(true)
				SetActive(arg_723_1.leftNameGo_, false)

				arg_723_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_723_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_723_1:RecordName(arg_723_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_723_1.iconTrs_.gameObject, false)
				arg_723_1.callingController_:SetSelectedState("normal")

				local var_726_1 = arg_723_1:FormatText(arg_723_1:GetWordFromCfg(1101905177).content)

				arg_723_1.text_.text = var_726_1

				LuaForUtil.ClearLinePrefixSymbol(arg_723_1.text_)

				local var_726_3 = 15 <= 0 and var_726_0 or var_726_0 * (utf8.len(var_726_1) / 15)

				if (15 <= 0 and var_726_0 or var_726_0 * (utf8.len(var_726_1) / 15)) > 0 and var_726_0 < var_726_3 then
					arg_723_1.talkMaxDuration = var_726_3

					if var_726_3 + 0 > arg_723_1.duration_ then
						arg_723_1.duration_ = var_726_3 + 0
					end
				end

				arg_723_1.text_.text = var_726_1
				arg_723_1.typewritter.percent = 0

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(false)
				arg_723_1:RecordContent(arg_723_1.text_.text)
			end

			local var_726_4 = math.max(var_726_0, arg_723_1.talkMaxDuration)

			if 0 <= arg_723_1.time_ and arg_723_1.time_ < 0 + var_726_4 then
				arg_723_1.typewritter.percent = (arg_723_1.time_ - 0) / var_726_4

				arg_723_1.typewritter:SetDirty()
			end

			if arg_723_1.time_ >= 0 + var_726_4 and arg_723_1.time_ < 0 + var_726_4 + arg_726_0 then
				arg_723_1.typewritter.percent = 1

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(true)
			end
		end

		arg_723_1.nodeConfigList_ = {}

		arg_723_1:InitPlayNodeList()
	end,
	Play1101905178 = function(arg_727_0, arg_727_1)
		arg_727_1.time_ = 0
		arg_727_1.frameCnt_ = 0
		arg_727_1.state_ = "playing"
		arg_727_1.curTalkId_ = 1101905178
		arg_727_1.duration_ = 5

		SetActive(arg_727_1.tipsGo_, false)

		function arg_727_1.onSingleLineFinish_()
			arg_727_1.onSingleLineUpdate_ = nil
			arg_727_1.onSingleLineFinish_ = nil
			arg_727_1.state_ = "waiting"
		end

		function arg_727_1.playNext_(arg_729_0)
			if arg_729_0 == 1 then
				arg_727_0:Play1101905179(arg_727_1)
			end
		end

		function arg_727_1.onSingleLineUpdate_(arg_730_0)
			local var_730_0 = 0.35

			if 0 < arg_727_1.time_ and arg_727_1.time_ <= 0 + arg_730_0 then
				arg_727_1.talkMaxDuration = 0
				arg_727_1.dialogCg_.alpha = 1

				arg_727_1.dialog_:SetActive(true)
				SetActive(arg_727_1.leftNameGo_, true)

				arg_727_1.leftNameTxt_.text = arg_727_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_727_1.leftNameTxt_.transform)

				arg_727_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_727_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_727_1:RecordName(arg_727_1.leftNameTxt_.text)
				SetActive(arg_727_1.iconTrs_.gameObject, true)
				arg_727_1.iconController_:SetSelectedState("hero")

				arg_727_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_727_1.callingController_:SetSelectedState("normal")

				arg_727_1.keyicon_.color = Color.New(1, 1, 1)
				arg_727_1.icon_.color = Color.New(1, 1, 1)

				local var_730_1 = arg_727_1:FormatText(arg_727_1:GetWordFromCfg(1101905178).content)

				arg_727_1.text_.text = var_730_1

				LuaForUtil.ClearLinePrefixSymbol(arg_727_1.text_)

				local var_730_3 = 7 <= 0 and var_730_0 or var_730_0 * (utf8.len(var_730_1) / 7)

				if (7 <= 0 and var_730_0 or var_730_0 * (utf8.len(var_730_1) / 7)) > 0 and var_730_0 < var_730_3 then
					arg_727_1.talkMaxDuration = var_730_3

					if var_730_3 + 0 > arg_727_1.duration_ then
						arg_727_1.duration_ = var_730_3 + 0
					end
				end

				arg_727_1.text_.text = var_730_1
				arg_727_1.typewritter.percent = 0

				arg_727_1.typewritter:SetDirty()
				arg_727_1:ShowNextGo(false)
				arg_727_1:RecordContent(arg_727_1.text_.text)
			end

			local var_730_4 = math.max(var_730_0, arg_727_1.talkMaxDuration)

			if 0 <= arg_727_1.time_ and arg_727_1.time_ < 0 + var_730_4 then
				arg_727_1.typewritter.percent = (arg_727_1.time_ - 0) / var_730_4

				arg_727_1.typewritter:SetDirty()
			end

			if arg_727_1.time_ >= 0 + var_730_4 and arg_727_1.time_ < 0 + var_730_4 + arg_730_0 then
				arg_727_1.typewritter.percent = 1

				arg_727_1.typewritter:SetDirty()
				arg_727_1:ShowNextGo(true)
			end
		end

		arg_727_1.nodeConfigList_ = {}

		arg_727_1:InitPlayNodeList()
	end,
	Play1101905179 = function(arg_731_0, arg_731_1)
		arg_731_1.time_ = 0
		arg_731_1.frameCnt_ = 0
		arg_731_1.state_ = "playing"
		arg_731_1.curTalkId_ = 1101905179
		arg_731_1.duration_ = 7.13

		local var_731_0 = {
			zh = 7.133,
			ja = 5.833
		}
		local var_731_1 = manager.audio:GetLocalizationFlag()

		if var_731_0[var_731_1] ~= nil then
			arg_731_1.duration_ = var_731_0[var_731_1]
		end

		SetActive(arg_731_1.tipsGo_, false)

		function arg_731_1.onSingleLineFinish_()
			arg_731_1.onSingleLineUpdate_ = nil
			arg_731_1.onSingleLineFinish_ = nil
			arg_731_1.state_ = "waiting"
		end

		function arg_731_1.playNext_(arg_733_0)
			if arg_733_0 == 1 then
				arg_731_0:Play1101905180(arg_731_1)
			end
		end

		function arg_731_1.onSingleLineUpdate_(arg_734_0)
			if arg_731_1.actors_["1029ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1029ui_story"))) then
				local var_734_0 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_731_1.stage_.transform)

				var_734_0.name = "1029ui_story"
				var_734_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_731_1.actors_["1029ui_story"] = var_734_0

				local var_734_1 = var_734_0:GetComponentInChildren(typeof(CharacterEffect))

				var_734_1.enabled = true

				local var_734_2 = GameObjectTools.GetOrAddComponent(var_734_0, typeof(DynamicBoneHelper))

				if var_734_2 then
					var_734_2:EnableDynamicBone(false)
				end

				arg_731_1:ShowWeapon(var_734_1.transform, false)

				arg_731_1.var_["1029ui_story" .. "Animator"] = var_734_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_731_1.var_["1029ui_story" .. "Animator"].applyRootMotion = true
				arg_731_1.var_["1029ui_story" .. "LipSync"] = var_734_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_734_3 = arg_731_1.actors_["1029ui_story"].transform

			if 0 < arg_731_1.time_ and arg_731_1.time_ <= 0 + arg_734_0 then
				arg_731_1.var_.moveOldPos1029ui_story = var_734_3.localPosition
			end

			local var_734_4 = 0.001

			if 0 <= arg_731_1.time_ and arg_731_1.time_ < 0 + var_734_4 then
				var_734_3.localPosition = Vector3.Lerp(arg_731_1.var_.moveOldPos1029ui_story, Vector3.New(0.7, -1.09, -6.2), (arg_731_1.time_ - 0) / var_734_4)
				var_734_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_734_3.position).x, (manager.ui.mainCamera.transform.position - var_734_3.position).y, (manager.ui.mainCamera.transform.position - var_734_3.position).z)
				var_734_3.localEulerAngles.z = 0
				var_734_3.localEulerAngles.x = 0
				var_734_3.localEulerAngles = var_734_3.localEulerAngles
			end

			if arg_731_1.time_ >= 0 + var_734_4 and arg_731_1.time_ < 0 + var_734_4 + arg_734_0 then
				var_734_3.localPosition = Vector3.New(0.7, -1.09, -6.2)
				var_734_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_734_3.position).x, (manager.ui.mainCamera.transform.position - var_734_3.position).y, (manager.ui.mainCamera.transform.position - var_734_3.position).z)
				var_734_3.localEulerAngles.z = 0
				var_734_3.localEulerAngles.x = 0
				var_734_3.localEulerAngles = var_734_3.localEulerAngles
			end

			local var_734_5 = arg_731_1.actors_["1029ui_story"]

			if 0 < arg_731_1.time_ and arg_731_1.time_ <= 0 + arg_734_0 and not isNil(var_734_5) and arg_731_1.var_.characterEffect1029ui_story == nil then
				arg_731_1.var_.characterEffect1029ui_story = var_734_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_734_6 = 0.200000002980232

			if 0 <= arg_731_1.time_ and arg_731_1.time_ < 0 + var_734_6 and not isNil(var_734_5) then
				if arg_731_1.var_.characterEffect1029ui_story and not isNil(var_734_5) then
					arg_731_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_731_1.time_ >= 0 + var_734_6 and arg_731_1.time_ < 0 + var_734_6 + arg_734_0 and not isNil(var_734_5) and arg_731_1.var_.characterEffect1029ui_story then
				arg_731_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_734_8 = arg_731_1.actors_["1019ui_story"].transform

			if 0 < arg_731_1.time_ and arg_731_1.time_ <= 0 + arg_734_0 then
				arg_731_1.var_.moveOldPos1019ui_story = var_734_8.localPosition
			end

			local var_734_9 = 0.001

			if 0 <= arg_731_1.time_ and arg_731_1.time_ < 0 + var_734_9 then
				var_734_8.localPosition = Vector3.Lerp(arg_731_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_731_1.time_ - 0) / var_734_9)
				var_734_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_734_8.position).x, (manager.ui.mainCamera.transform.position - var_734_8.position).y, (manager.ui.mainCamera.transform.position - var_734_8.position).z)
				var_734_8.localEulerAngles.z = 0
				var_734_8.localEulerAngles.x = 0
				var_734_8.localEulerAngles = var_734_8.localEulerAngles
			end

			if arg_731_1.time_ >= 0 + var_734_9 and arg_731_1.time_ < 0 + var_734_9 + arg_734_0 then
				var_734_8.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_734_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_734_8.position).x, (manager.ui.mainCamera.transform.position - var_734_8.position).y, (manager.ui.mainCamera.transform.position - var_734_8.position).z)
				var_734_8.localEulerAngles.z = 0
				var_734_8.localEulerAngles.x = 0
				var_734_8.localEulerAngles = var_734_8.localEulerAngles
			end

			local var_734_10 = arg_731_1.actors_["1019ui_story"]

			if 0 < arg_731_1.time_ and arg_731_1.time_ <= 0 + arg_734_0 and not isNil(var_734_10) and arg_731_1.var_.characterEffect1019ui_story == nil then
				arg_731_1.var_.characterEffect1019ui_story = var_734_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_734_11 = 0.200000002980232

			if 0 <= arg_731_1.time_ and arg_731_1.time_ < 0 + var_734_11 and not isNil(var_734_10) then
				if arg_731_1.var_.characterEffect1019ui_story and not isNil(var_734_10) then
					arg_731_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_731_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_731_1.time_ - 0) / var_734_11)
				end
			end

			if arg_731_1.time_ >= 0 + var_734_11 and arg_731_1.time_ < 0 + var_734_11 + arg_734_0 and not isNil(var_734_10) and arg_731_1.var_.characterEffect1019ui_story then
				arg_731_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_731_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_731_1.time_ and arg_731_1.time_ <= 0 + arg_734_0 then
				arg_731_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action2_1")
			end

			if 0 < arg_731_1.time_ and arg_731_1.time_ <= 0 + arg_734_0 then
				arg_731_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_734_12 = 0
			local var_734_13 = 0.425

			if 0 < arg_731_1.time_ and arg_731_1.time_ <= var_734_12 + arg_734_0 then
				arg_731_1.talkMaxDuration = 0
				arg_731_1.dialogCg_.alpha = 1

				arg_731_1.dialog_:SetActive(true)
				SetActive(arg_731_1.leftNameGo_, true)

				arg_731_1.leftNameTxt_.text = arg_731_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_731_1.leftNameTxt_.transform)

				arg_731_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_731_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_731_1:RecordName(arg_731_1.leftNameTxt_.text)
				SetActive(arg_731_1.iconTrs_.gameObject, false)
				arg_731_1.callingController_:SetSelectedState("normal")

				local var_734_14 = arg_731_1:GetWordFromCfg(1101905179)
				local var_734_15 = arg_731_1:FormatText(var_734_14.content)

				arg_731_1.text_.text = var_734_15

				LuaForUtil.ClearLinePrefixSymbol(arg_731_1.text_)

				local var_734_17 = 25 <= 0 and var_734_13 or var_734_13 * (utf8.len(var_734_15) / 25)

				if (25 <= 0 and var_734_13 or var_734_13 * (utf8.len(var_734_15) / 25)) > 0 and var_734_13 < var_734_17 then
					arg_731_1.talkMaxDuration = var_734_17

					if var_734_17 + var_734_12 > arg_731_1.duration_ then
						arg_731_1.duration_ = var_734_17 + var_734_12
					end
				end

				arg_731_1.text_.text = var_734_15
				arg_731_1.typewritter.percent = 0

				arg_731_1.typewritter:SetDirty()
				arg_731_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905179", "story_v_side_new_1101905.awb") ~= 0 then
					local var_734_18 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905179", "story_v_side_new_1101905.awb") / 1000

					if var_734_18 + var_734_12 > arg_731_1.duration_ then
						arg_731_1.duration_ = var_734_18 + var_734_12
					end

					if var_734_14.prefab_name ~= "" and arg_731_1.actors_[var_734_14.prefab_name] ~= nil then
						local var_734_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_731_1.actors_[var_734_14.prefab_name].transform, "story_v_side_new_1101905", "1101905179", "story_v_side_new_1101905.awb")

						arg_731_1:RecordAudio("1101905179", var_734_19)
						arg_731_1:RecordAudio("1101905179", var_734_19)
					else
						arg_731_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905179", "story_v_side_new_1101905.awb")
					end

					arg_731_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905179", "story_v_side_new_1101905.awb")
				end

				arg_731_1:RecordContent(arg_731_1.text_.text)
			end

			local var_734_20 = math.max(var_734_13, arg_731_1.talkMaxDuration)

			if var_734_12 <= arg_731_1.time_ and arg_731_1.time_ < var_734_12 + var_734_20 then
				arg_731_1.typewritter.percent = (arg_731_1.time_ - var_734_12) / var_734_20

				arg_731_1.typewritter:SetDirty()
			end

			if arg_731_1.time_ >= var_734_12 + var_734_20 and arg_731_1.time_ < var_734_12 + var_734_20 + arg_734_0 then
				arg_731_1.typewritter.percent = 1

				arg_731_1.typewritter:SetDirty()
				arg_731_1:ShowNextGo(true)
			end
		end

		arg_731_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_731_1:InitPlayNodeList()
	end,
	Play1101905180 = function(arg_735_0, arg_735_1)
		arg_735_1.time_ = 0
		arg_735_1.frameCnt_ = 0
		arg_735_1.state_ = "playing"
		arg_735_1.curTalkId_ = 1101905180
		arg_735_1.duration_ = 5

		SetActive(arg_735_1.tipsGo_, false)

		function arg_735_1.onSingleLineFinish_()
			arg_735_1.onSingleLineUpdate_ = nil
			arg_735_1.onSingleLineFinish_ = nil
			arg_735_1.state_ = "waiting"
		end

		function arg_735_1.playNext_(arg_737_0)
			if arg_737_0 == 1 then
				arg_735_0:Play1101905181(arg_735_1)
			end
		end

		function arg_735_1.onSingleLineUpdate_(arg_738_0)
			if 0 < arg_735_1.time_ and arg_735_1.time_ <= 0 + arg_738_0 and not isNil(arg_735_1.actors_["1029ui_story"]) and arg_735_1.var_.characterEffect1029ui_story == nil then
				arg_735_1.var_.characterEffect1029ui_story = arg_735_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_738_0 = 0.200000002980232

			if 0 <= arg_735_1.time_ and arg_735_1.time_ < 0 + var_738_0 and not isNil(arg_735_1.actors_["1029ui_story"]) then
				if arg_735_1.var_.characterEffect1029ui_story and not isNil(arg_735_1.actors_["1029ui_story"]) then
					arg_735_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_735_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_735_1.time_ - 0) / var_738_0)
				end
			end

			if arg_735_1.time_ >= 0 + var_738_0 and arg_735_1.time_ < 0 + var_738_0 + arg_738_0 and not isNil(arg_735_1.actors_["1029ui_story"]) and arg_735_1.var_.characterEffect1029ui_story then
				arg_735_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_735_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_738_1 = 0
			local var_738_2 = 0.5

			if 0 < arg_735_1.time_ and arg_735_1.time_ <= var_738_1 + arg_738_0 then
				arg_735_1.talkMaxDuration = 0
				arg_735_1.dialogCg_.alpha = 1

				arg_735_1.dialog_:SetActive(true)
				SetActive(arg_735_1.leftNameGo_, true)

				arg_735_1.leftNameTxt_.text = arg_735_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_735_1.leftNameTxt_.transform)

				arg_735_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_735_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_735_1:RecordName(arg_735_1.leftNameTxt_.text)
				SetActive(arg_735_1.iconTrs_.gameObject, true)
				arg_735_1.iconController_:SetSelectedState("hero")

				arg_735_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_735_1.callingController_:SetSelectedState("normal")

				arg_735_1.keyicon_.color = Color.New(1, 1, 1)
				arg_735_1.icon_.color = Color.New(1, 1, 1)

				local var_738_3 = arg_735_1:FormatText(arg_735_1:GetWordFromCfg(1101905180).content)

				arg_735_1.text_.text = var_738_3

				LuaForUtil.ClearLinePrefixSymbol(arg_735_1.text_)

				local var_738_5 = 24 <= 0 and var_738_2 or var_738_2 * (utf8.len(var_738_3) / 24)

				if (24 <= 0 and var_738_2 or var_738_2 * (utf8.len(var_738_3) / 24)) > 0 and var_738_2 < var_738_5 then
					arg_735_1.talkMaxDuration = var_738_5

					if var_738_5 + var_738_1 > arg_735_1.duration_ then
						arg_735_1.duration_ = var_738_5 + var_738_1
					end
				end

				arg_735_1.text_.text = var_738_3
				arg_735_1.typewritter.percent = 0

				arg_735_1.typewritter:SetDirty()
				arg_735_1:ShowNextGo(false)
				arg_735_1:RecordContent(arg_735_1.text_.text)
			end

			local var_738_6 = math.max(var_738_2, arg_735_1.talkMaxDuration)

			if var_738_1 <= arg_735_1.time_ and arg_735_1.time_ < var_738_1 + var_738_6 then
				arg_735_1.typewritter.percent = (arg_735_1.time_ - var_738_1) / var_738_6

				arg_735_1.typewritter:SetDirty()
			end

			if arg_735_1.time_ >= var_738_1 + var_738_6 and arg_735_1.time_ < var_738_1 + var_738_6 + arg_738_0 then
				arg_735_1.typewritter.percent = 1

				arg_735_1.typewritter:SetDirty()
				arg_735_1:ShowNextGo(true)
			end
		end

		arg_735_1.nodeConfigList_ = {}

		arg_735_1:InitPlayNodeList()
	end,
	Play1101905181 = function(arg_739_0, arg_739_1)
		arg_739_1.time_ = 0
		arg_739_1.frameCnt_ = 0
		arg_739_1.state_ = "playing"
		arg_739_1.curTalkId_ = 1101905181
		arg_739_1.duration_ = 5

		SetActive(arg_739_1.tipsGo_, false)

		function arg_739_1.onSingleLineFinish_()
			arg_739_1.onSingleLineUpdate_ = nil
			arg_739_1.onSingleLineFinish_ = nil
			arg_739_1.state_ = "waiting"
		end

		function arg_739_1.playNext_(arg_741_0)
			if arg_741_0 == 1 then
				arg_739_0:Play1101905182(arg_739_1)
			end
		end

		function arg_739_1.onSingleLineUpdate_(arg_742_0)
			if 0 < arg_739_1.time_ and arg_739_1.time_ <= 0 + arg_742_0 then
				arg_739_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action2_2")
			end

			if 0 < arg_739_1.time_ and arg_739_1.time_ <= 0 + arg_742_0 then
				arg_739_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_742_0 = 0
			local var_742_1 = 0.375

			if 0 < arg_739_1.time_ and arg_739_1.time_ <= var_742_0 + arg_742_0 then
				arg_739_1.talkMaxDuration = 0
				arg_739_1.dialogCg_.alpha = 1

				arg_739_1.dialog_:SetActive(true)
				SetActive(arg_739_1.leftNameGo_, false)

				arg_739_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_739_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_739_1:RecordName(arg_739_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_739_1.iconTrs_.gameObject, false)
				arg_739_1.callingController_:SetSelectedState("normal")

				local var_742_2 = arg_739_1:FormatText(arg_739_1:GetWordFromCfg(1101905181).content)

				arg_739_1.text_.text = var_742_2

				LuaForUtil.ClearLinePrefixSymbol(arg_739_1.text_)

				local var_742_4 = 27 <= 0 and var_742_1 or var_742_1 * (utf8.len(var_742_2) / 27)

				if (27 <= 0 and var_742_1 or var_742_1 * (utf8.len(var_742_2) / 27)) > 0 and var_742_1 < var_742_4 then
					arg_739_1.talkMaxDuration = var_742_4

					if var_742_4 + var_742_0 > arg_739_1.duration_ then
						arg_739_1.duration_ = var_742_4 + var_742_0
					end
				end

				arg_739_1.text_.text = var_742_2
				arg_739_1.typewritter.percent = 0

				arg_739_1.typewritter:SetDirty()
				arg_739_1:ShowNextGo(false)
				arg_739_1:RecordContent(arg_739_1.text_.text)
			end

			local var_742_5 = math.max(var_742_1, arg_739_1.talkMaxDuration)

			if var_742_0 <= arg_739_1.time_ and arg_739_1.time_ < var_742_0 + var_742_5 then
				arg_739_1.typewritter.percent = (arg_739_1.time_ - var_742_0) / var_742_5

				arg_739_1.typewritter:SetDirty()
			end

			if arg_739_1.time_ >= var_742_0 + var_742_5 and arg_739_1.time_ < var_742_0 + var_742_5 + arg_742_0 then
				arg_739_1.typewritter.percent = 1

				arg_739_1.typewritter:SetDirty()
				arg_739_1:ShowNextGo(true)
			end
		end

		arg_739_1.nodeConfigList_ = {}

		arg_739_1:InitPlayNodeList()
	end,
	Play1101905182 = function(arg_743_0, arg_743_1)
		arg_743_1.time_ = 0
		arg_743_1.frameCnt_ = 0
		arg_743_1.state_ = "playing"
		arg_743_1.curTalkId_ = 1101905182
		arg_743_1.duration_ = 5

		SetActive(arg_743_1.tipsGo_, false)

		function arg_743_1.onSingleLineFinish_()
			arg_743_1.onSingleLineUpdate_ = nil
			arg_743_1.onSingleLineFinish_ = nil
			arg_743_1.state_ = "waiting"
		end

		function arg_743_1.playNext_(arg_745_0)
			if arg_745_0 == 1 then
				arg_743_0:Play1101905183(arg_743_1)
			end
		end

		function arg_743_1.onSingleLineUpdate_(arg_746_0)
			local var_746_0 = 0.175

			if 0 < arg_743_1.time_ and arg_743_1.time_ <= 0 + arg_746_0 then
				arg_743_1.talkMaxDuration = 0
				arg_743_1.dialogCg_.alpha = 1

				arg_743_1.dialog_:SetActive(true)
				SetActive(arg_743_1.leftNameGo_, false)

				arg_743_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_743_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_743_1:RecordName(arg_743_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_743_1.iconTrs_.gameObject, false)
				arg_743_1.callingController_:SetSelectedState("normal")

				local var_746_1 = arg_743_1:FormatText(arg_743_1:GetWordFromCfg(1101905182).content)

				arg_743_1.text_.text = var_746_1

				LuaForUtil.ClearLinePrefixSymbol(arg_743_1.text_)

				local var_746_3 = 9 <= 0 and var_746_0 or var_746_0 * (utf8.len(var_746_1) / 9)

				if (9 <= 0 and var_746_0 or var_746_0 * (utf8.len(var_746_1) / 9)) > 0 and var_746_0 < var_746_3 then
					arg_743_1.talkMaxDuration = var_746_3

					if var_746_3 + 0 > arg_743_1.duration_ then
						arg_743_1.duration_ = var_746_3 + 0
					end
				end

				arg_743_1.text_.text = var_746_1
				arg_743_1.typewritter.percent = 0

				arg_743_1.typewritter:SetDirty()
				arg_743_1:ShowNextGo(false)
				arg_743_1:RecordContent(arg_743_1.text_.text)
			end

			local var_746_4 = math.max(var_746_0, arg_743_1.talkMaxDuration)

			if 0 <= arg_743_1.time_ and arg_743_1.time_ < 0 + var_746_4 then
				arg_743_1.typewritter.percent = (arg_743_1.time_ - 0) / var_746_4

				arg_743_1.typewritter:SetDirty()
			end

			if arg_743_1.time_ >= 0 + var_746_4 and arg_743_1.time_ < 0 + var_746_4 + arg_746_0 then
				arg_743_1.typewritter.percent = 1

				arg_743_1.typewritter:SetDirty()
				arg_743_1:ShowNextGo(true)
			end
		end

		arg_743_1.nodeConfigList_ = {}

		arg_743_1:InitPlayNodeList()
	end,
	Play1101905183 = function(arg_747_0, arg_747_1)
		arg_747_1.time_ = 0
		arg_747_1.frameCnt_ = 0
		arg_747_1.state_ = "playing"
		arg_747_1.curTalkId_ = 1101905183
		arg_747_1.duration_ = 5

		SetActive(arg_747_1.tipsGo_, false)

		function arg_747_1.onSingleLineFinish_()
			arg_747_1.onSingleLineUpdate_ = nil
			arg_747_1.onSingleLineFinish_ = nil
			arg_747_1.state_ = "waiting"
		end

		function arg_747_1.playNext_(arg_749_0)
			if arg_749_0 == 1 then
				arg_747_0:Play1101905184(arg_747_1)
			end
		end

		function arg_747_1.onSingleLineUpdate_(arg_750_0)
			local var_750_0 = 0.625

			if 0 < arg_747_1.time_ and arg_747_1.time_ <= 0 + arg_750_0 then
				arg_747_1.talkMaxDuration = 0
				arg_747_1.dialogCg_.alpha = 1

				arg_747_1.dialog_:SetActive(true)
				SetActive(arg_747_1.leftNameGo_, true)

				arg_747_1.leftNameTxt_.text = arg_747_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_747_1.leftNameTxt_.transform)

				arg_747_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_747_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_747_1:RecordName(arg_747_1.leftNameTxt_.text)
				SetActive(arg_747_1.iconTrs_.gameObject, true)
				arg_747_1.iconController_:SetSelectedState("hero")

				arg_747_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_747_1.callingController_:SetSelectedState("normal")

				arg_747_1.keyicon_.color = Color.New(1, 1, 1)
				arg_747_1.icon_.color = Color.New(1, 1, 1)

				local var_750_1 = arg_747_1:FormatText(arg_747_1:GetWordFromCfg(1101905183).content)

				arg_747_1.text_.text = var_750_1

				LuaForUtil.ClearLinePrefixSymbol(arg_747_1.text_)

				local var_750_3 = 20 <= 0 and var_750_0 or var_750_0 * (utf8.len(var_750_1) / 20)

				if (20 <= 0 and var_750_0 or var_750_0 * (utf8.len(var_750_1) / 20)) > 0 and var_750_0 < var_750_3 then
					arg_747_1.talkMaxDuration = var_750_3

					if var_750_3 + 0 > arg_747_1.duration_ then
						arg_747_1.duration_ = var_750_3 + 0
					end
				end

				arg_747_1.text_.text = var_750_1
				arg_747_1.typewritter.percent = 0

				arg_747_1.typewritter:SetDirty()
				arg_747_1:ShowNextGo(false)
				arg_747_1:RecordContent(arg_747_1.text_.text)
			end

			local var_750_4 = math.max(var_750_0, arg_747_1.talkMaxDuration)

			if 0 <= arg_747_1.time_ and arg_747_1.time_ < 0 + var_750_4 then
				arg_747_1.typewritter.percent = (arg_747_1.time_ - 0) / var_750_4

				arg_747_1.typewritter:SetDirty()
			end

			if arg_747_1.time_ >= 0 + var_750_4 and arg_747_1.time_ < 0 + var_750_4 + arg_750_0 then
				arg_747_1.typewritter.percent = 1

				arg_747_1.typewritter:SetDirty()
				arg_747_1:ShowNextGo(true)
			end
		end

		arg_747_1.nodeConfigList_ = {}

		arg_747_1:InitPlayNodeList()
	end,
	Play1101905184 = function(arg_751_0, arg_751_1)
		arg_751_1.time_ = 0
		arg_751_1.frameCnt_ = 0
		arg_751_1.state_ = "playing"
		arg_751_1.curTalkId_ = 1101905184
		arg_751_1.duration_ = 4.4

		local var_751_0 = {
			zh = 2.033,
			ja = 4.4
		}
		local var_751_1 = manager.audio:GetLocalizationFlag()

		if var_751_0[var_751_1] ~= nil then
			arg_751_1.duration_ = var_751_0[var_751_1]
		end

		SetActive(arg_751_1.tipsGo_, false)

		function arg_751_1.onSingleLineFinish_()
			arg_751_1.onSingleLineUpdate_ = nil
			arg_751_1.onSingleLineFinish_ = nil
			arg_751_1.state_ = "waiting"
		end

		function arg_751_1.playNext_(arg_753_0)
			if arg_753_0 == 1 then
				arg_751_0:Play1101905185(arg_751_1)
			end
		end

		function arg_751_1.onSingleLineUpdate_(arg_754_0)
			if 0 < arg_751_1.time_ and arg_751_1.time_ <= 0 + arg_754_0 and not isNil(arg_751_1.actors_["1029ui_story"]) and arg_751_1.var_.characterEffect1029ui_story == nil then
				arg_751_1.var_.characterEffect1029ui_story = arg_751_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_754_0 = 0.200000002980232

			if 0 <= arg_751_1.time_ and arg_751_1.time_ < 0 + var_754_0 and not isNil(arg_751_1.actors_["1029ui_story"]) then
				if arg_751_1.var_.characterEffect1029ui_story and not isNil(arg_751_1.actors_["1029ui_story"]) then
					arg_751_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_751_1.time_ >= 0 + var_754_0 and arg_751_1.time_ < 0 + var_754_0 + arg_754_0 and not isNil(arg_751_1.actors_["1029ui_story"]) and arg_751_1.var_.characterEffect1029ui_story then
				arg_751_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_754_2 = 0
			local var_754_3 = 0.6

			if 0 < arg_751_1.time_ and arg_751_1.time_ <= var_754_2 + arg_754_0 then
				arg_751_1.talkMaxDuration = 0
				arg_751_1.dialogCg_.alpha = 1

				arg_751_1.dialog_:SetActive(true)
				SetActive(arg_751_1.leftNameGo_, true)

				arg_751_1.leftNameTxt_.text = arg_751_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_751_1.leftNameTxt_.transform)

				arg_751_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_751_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_751_1:RecordName(arg_751_1.leftNameTxt_.text)
				SetActive(arg_751_1.iconTrs_.gameObject, false)
				arg_751_1.callingController_:SetSelectedState("normal")

				local var_754_4 = arg_751_1:GetWordFromCfg(1101905184)
				local var_754_5 = arg_751_1:FormatText(var_754_4.content)

				arg_751_1.text_.text = var_754_5

				LuaForUtil.ClearLinePrefixSymbol(arg_751_1.text_)

				local var_754_7 = 9 <= 0 and var_754_3 or var_754_3 * (utf8.len(var_754_5) / 9)

				if (9 <= 0 and var_754_3 or var_754_3 * (utf8.len(var_754_5) / 9)) > 0 and var_754_3 < var_754_7 then
					arg_751_1.talkMaxDuration = var_754_7

					if var_754_7 + var_754_2 > arg_751_1.duration_ then
						arg_751_1.duration_ = var_754_7 + var_754_2
					end
				end

				arg_751_1.text_.text = var_754_5
				arg_751_1.typewritter.percent = 0

				arg_751_1.typewritter:SetDirty()
				arg_751_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905184", "story_v_side_new_1101905.awb") ~= 0 then
					local var_754_8 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905184", "story_v_side_new_1101905.awb") / 1000

					if var_754_8 + var_754_2 > arg_751_1.duration_ then
						arg_751_1.duration_ = var_754_8 + var_754_2
					end

					if var_754_4.prefab_name ~= "" and arg_751_1.actors_[var_754_4.prefab_name] ~= nil then
						local var_754_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_751_1.actors_[var_754_4.prefab_name].transform, "story_v_side_new_1101905", "1101905184", "story_v_side_new_1101905.awb")

						arg_751_1:RecordAudio("1101905184", var_754_9)
						arg_751_1:RecordAudio("1101905184", var_754_9)
					else
						arg_751_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905184", "story_v_side_new_1101905.awb")
					end

					arg_751_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905184", "story_v_side_new_1101905.awb")
				end

				arg_751_1:RecordContent(arg_751_1.text_.text)
			end

			local var_754_10 = math.max(var_754_3, arg_751_1.talkMaxDuration)

			if var_754_2 <= arg_751_1.time_ and arg_751_1.time_ < var_754_2 + var_754_10 then
				arg_751_1.typewritter.percent = (arg_751_1.time_ - var_754_2) / var_754_10

				arg_751_1.typewritter:SetDirty()
			end

			if arg_751_1.time_ >= var_754_2 + var_754_10 and arg_751_1.time_ < var_754_2 + var_754_10 + arg_754_0 then
				arg_751_1.typewritter.percent = 1

				arg_751_1.typewritter:SetDirty()
				arg_751_1:ShowNextGo(true)
			end
		end

		arg_751_1.nodeConfigList_ = {}

		arg_751_1:InitPlayNodeList()
	end,
	Play1101905185 = function(arg_755_0, arg_755_1)
		arg_755_1.time_ = 0
		arg_755_1.frameCnt_ = 0
		arg_755_1.state_ = "playing"
		arg_755_1.curTalkId_ = 1101905185
		arg_755_1.duration_ = 5

		SetActive(arg_755_1.tipsGo_, false)

		function arg_755_1.onSingleLineFinish_()
			arg_755_1.onSingleLineUpdate_ = nil
			arg_755_1.onSingleLineFinish_ = nil
			arg_755_1.state_ = "waiting"
		end

		function arg_755_1.playNext_(arg_757_0)
			if arg_757_0 == 1 then
				arg_755_0:Play1101905186(arg_755_1)
			end
		end

		function arg_755_1.onSingleLineUpdate_(arg_758_0)
			if 0 < arg_755_1.time_ and arg_755_1.time_ <= 0 + arg_758_0 and not isNil(arg_755_1.actors_["1029ui_story"]) and arg_755_1.var_.characterEffect1029ui_story == nil then
				arg_755_1.var_.characterEffect1029ui_story = arg_755_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_758_0 = 0.200000002980232

			if 0 <= arg_755_1.time_ and arg_755_1.time_ < 0 + var_758_0 and not isNil(arg_755_1.actors_["1029ui_story"]) then
				if arg_755_1.var_.characterEffect1029ui_story and not isNil(arg_755_1.actors_["1029ui_story"]) then
					arg_755_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_755_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_755_1.time_ - 0) / var_758_0)
				end
			end

			if arg_755_1.time_ >= 0 + var_758_0 and arg_755_1.time_ < 0 + var_758_0 + arg_758_0 and not isNil(arg_755_1.actors_["1029ui_story"]) and arg_755_1.var_.characterEffect1029ui_story then
				arg_755_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_755_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_758_1 = 0
			local var_758_2 = 0.675

			if 0 < arg_755_1.time_ and arg_755_1.time_ <= var_758_1 + arg_758_0 then
				arg_755_1.talkMaxDuration = 0
				arg_755_1.dialogCg_.alpha = 1

				arg_755_1.dialog_:SetActive(true)
				SetActive(arg_755_1.leftNameGo_, true)

				arg_755_1.leftNameTxt_.text = arg_755_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_755_1.leftNameTxt_.transform)

				arg_755_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_755_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_755_1:RecordName(arg_755_1.leftNameTxt_.text)
				SetActive(arg_755_1.iconTrs_.gameObject, true)
				arg_755_1.iconController_:SetSelectedState("hero")

				arg_755_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_755_1.callingController_:SetSelectedState("normal")

				arg_755_1.keyicon_.color = Color.New(1, 1, 1)
				arg_755_1.icon_.color = Color.New(1, 1, 1)

				local var_758_3 = arg_755_1:FormatText(arg_755_1:GetWordFromCfg(1101905185).content)

				arg_755_1.text_.text = var_758_3

				LuaForUtil.ClearLinePrefixSymbol(arg_755_1.text_)

				local var_758_5 = 27 <= 0 and var_758_2 or var_758_2 * (utf8.len(var_758_3) / 27)

				if (27 <= 0 and var_758_2 or var_758_2 * (utf8.len(var_758_3) / 27)) > 0 and var_758_2 < var_758_5 then
					arg_755_1.talkMaxDuration = var_758_5

					if var_758_5 + var_758_1 > arg_755_1.duration_ then
						arg_755_1.duration_ = var_758_5 + var_758_1
					end
				end

				arg_755_1.text_.text = var_758_3
				arg_755_1.typewritter.percent = 0

				arg_755_1.typewritter:SetDirty()
				arg_755_1:ShowNextGo(false)
				arg_755_1:RecordContent(arg_755_1.text_.text)
			end

			local var_758_6 = math.max(var_758_2, arg_755_1.talkMaxDuration)

			if var_758_1 <= arg_755_1.time_ and arg_755_1.time_ < var_758_1 + var_758_6 then
				arg_755_1.typewritter.percent = (arg_755_1.time_ - var_758_1) / var_758_6

				arg_755_1.typewritter:SetDirty()
			end

			if arg_755_1.time_ >= var_758_1 + var_758_6 and arg_755_1.time_ < var_758_1 + var_758_6 + arg_758_0 then
				arg_755_1.typewritter.percent = 1

				arg_755_1.typewritter:SetDirty()
				arg_755_1:ShowNextGo(true)
			end
		end

		arg_755_1.nodeConfigList_ = {}

		arg_755_1:InitPlayNodeList()
	end,
	Play1101905186 = function(arg_759_0, arg_759_1)
		arg_759_1.time_ = 0
		arg_759_1.frameCnt_ = 0
		arg_759_1.state_ = "playing"
		arg_759_1.curTalkId_ = 1101905186
		arg_759_1.duration_ = 8.03

		local var_759_0 = {
			zh = 6.3,
			ja = 8.033
		}
		local var_759_1 = manager.audio:GetLocalizationFlag()

		if var_759_0[var_759_1] ~= nil then
			arg_759_1.duration_ = var_759_0[var_759_1]
		end

		SetActive(arg_759_1.tipsGo_, false)

		function arg_759_1.onSingleLineFinish_()
			arg_759_1.onSingleLineUpdate_ = nil
			arg_759_1.onSingleLineFinish_ = nil
			arg_759_1.state_ = "waiting"
		end

		function arg_759_1.playNext_(arg_761_0)
			if arg_761_0 == 1 then
				arg_759_0:Play1101905187(arg_759_1)
			end
		end

		function arg_759_1.onSingleLineUpdate_(arg_762_0)
			if 0 < arg_759_1.time_ and arg_759_1.time_ <= 0 + arg_762_0 and not isNil(arg_759_1.actors_["1029ui_story"]) and arg_759_1.var_.characterEffect1029ui_story == nil then
				arg_759_1.var_.characterEffect1029ui_story = arg_759_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_762_0 = 0.200000002980232

			if 0 <= arg_759_1.time_ and arg_759_1.time_ < 0 + var_762_0 and not isNil(arg_759_1.actors_["1029ui_story"]) then
				if arg_759_1.var_.characterEffect1029ui_story and not isNil(arg_759_1.actors_["1029ui_story"]) then
					arg_759_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_759_1.time_ >= 0 + var_762_0 and arg_759_1.time_ < 0 + var_762_0 + arg_762_0 and not isNil(arg_759_1.actors_["1029ui_story"]) and arg_759_1.var_.characterEffect1029ui_story then
				arg_759_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_759_1.time_ and arg_759_1.time_ <= 0 + arg_762_0 then
				arg_759_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			if 0 < arg_759_1.time_ and arg_759_1.time_ <= 0 + arg_762_0 then
				arg_759_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_762_2 = 0
			local var_762_3 = 0.225

			if 0 < arg_759_1.time_ and arg_759_1.time_ <= var_762_2 + arg_762_0 then
				arg_759_1.talkMaxDuration = 0
				arg_759_1.dialogCg_.alpha = 1

				arg_759_1.dialog_:SetActive(true)
				SetActive(arg_759_1.leftNameGo_, true)

				arg_759_1.leftNameTxt_.text = arg_759_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_759_1.leftNameTxt_.transform)

				arg_759_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_759_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_759_1:RecordName(arg_759_1.leftNameTxt_.text)
				SetActive(arg_759_1.iconTrs_.gameObject, false)
				arg_759_1.callingController_:SetSelectedState("normal")

				local var_762_4 = arg_759_1:GetWordFromCfg(1101905186)
				local var_762_5 = arg_759_1:FormatText(var_762_4.content)

				arg_759_1.text_.text = var_762_5

				LuaForUtil.ClearLinePrefixSymbol(arg_759_1.text_)

				local var_762_7 = 24 <= 0 and var_762_3 or var_762_3 * (utf8.len(var_762_5) / 24)

				if (24 <= 0 and var_762_3 or var_762_3 * (utf8.len(var_762_5) / 24)) > 0 and var_762_3 < var_762_7 then
					arg_759_1.talkMaxDuration = var_762_7

					if var_762_7 + var_762_2 > arg_759_1.duration_ then
						arg_759_1.duration_ = var_762_7 + var_762_2
					end
				end

				arg_759_1.text_.text = var_762_5
				arg_759_1.typewritter.percent = 0

				arg_759_1.typewritter:SetDirty()
				arg_759_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905186", "story_v_side_new_1101905.awb") ~= 0 then
					local var_762_8 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905186", "story_v_side_new_1101905.awb") / 1000

					if var_762_8 + var_762_2 > arg_759_1.duration_ then
						arg_759_1.duration_ = var_762_8 + var_762_2
					end

					if var_762_4.prefab_name ~= "" and arg_759_1.actors_[var_762_4.prefab_name] ~= nil then
						local var_762_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_759_1.actors_[var_762_4.prefab_name].transform, "story_v_side_new_1101905", "1101905186", "story_v_side_new_1101905.awb")

						arg_759_1:RecordAudio("1101905186", var_762_9)
						arg_759_1:RecordAudio("1101905186", var_762_9)
					else
						arg_759_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905186", "story_v_side_new_1101905.awb")
					end

					arg_759_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905186", "story_v_side_new_1101905.awb")
				end

				arg_759_1:RecordContent(arg_759_1.text_.text)
			end

			local var_762_10 = math.max(var_762_3, arg_759_1.talkMaxDuration)

			if var_762_2 <= arg_759_1.time_ and arg_759_1.time_ < var_762_2 + var_762_10 then
				arg_759_1.typewritter.percent = (arg_759_1.time_ - var_762_2) / var_762_10

				arg_759_1.typewritter:SetDirty()
			end

			if arg_759_1.time_ >= var_762_2 + var_762_10 and arg_759_1.time_ < var_762_2 + var_762_10 + arg_762_0 then
				arg_759_1.typewritter.percent = 1

				arg_759_1.typewritter:SetDirty()
				arg_759_1:ShowNextGo(true)
			end
		end

		arg_759_1.nodeConfigList_ = {}

		arg_759_1:InitPlayNodeList()
	end,
	Play1101905187 = function(arg_763_0, arg_763_1)
		arg_763_1.time_ = 0
		arg_763_1.frameCnt_ = 0
		arg_763_1.state_ = "playing"
		arg_763_1.curTalkId_ = 1101905187
		arg_763_1.duration_ = 2.27

		local var_763_0 = {
			zh = 1.999999999999,
			ja = 2.266
		}
		local var_763_1 = manager.audio:GetLocalizationFlag()

		if var_763_0[var_763_1] ~= nil then
			arg_763_1.duration_ = var_763_0[var_763_1]
		end

		SetActive(arg_763_1.tipsGo_, false)

		function arg_763_1.onSingleLineFinish_()
			arg_763_1.onSingleLineUpdate_ = nil
			arg_763_1.onSingleLineFinish_ = nil
			arg_763_1.state_ = "waiting"
		end

		function arg_763_1.playNext_(arg_765_0)
			if arg_765_0 == 1 then
				arg_763_0:Play1101905188(arg_763_1)
			end
		end

		function arg_763_1.onSingleLineUpdate_(arg_766_0)
			if 0 < arg_763_1.time_ and arg_763_1.time_ <= 0 + arg_766_0 then
				arg_763_1.var_.moveOldPos1019ui_story = arg_763_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_766_0 = 0.001

			if 0 <= arg_763_1.time_ and arg_763_1.time_ < 0 + var_766_0 then
				arg_763_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_763_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_763_1.time_ - 0) / var_766_0)
				arg_763_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_763_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_763_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_763_1.actors_["1019ui_story"].transform.position).z)
				arg_763_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_763_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_763_1.actors_["1019ui_story"].transform.localEulerAngles = arg_763_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_763_1.time_ >= 0 + var_766_0 and arg_763_1.time_ < 0 + var_766_0 + arg_766_0 then
				arg_763_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				arg_763_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_763_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_763_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_763_1.actors_["1019ui_story"].transform.position).z)
				arg_763_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_763_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_763_1.actors_["1019ui_story"].transform.localEulerAngles = arg_763_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_766_1 = arg_763_1.actors_["1019ui_story"]

			if 0 < arg_763_1.time_ and arg_763_1.time_ <= 0 + arg_766_0 and not isNil(var_766_1) and arg_763_1.var_.characterEffect1019ui_story == nil then
				arg_763_1.var_.characterEffect1019ui_story = var_766_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_766_2 = 0.200000002980232

			if 0 <= arg_763_1.time_ and arg_763_1.time_ < 0 + var_766_2 and not isNil(var_766_1) then
				if arg_763_1.var_.characterEffect1019ui_story and not isNil(var_766_1) then
					arg_763_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_763_1.time_ >= 0 + var_766_2 and arg_763_1.time_ < 0 + var_766_2 + arg_766_0 and not isNil(var_766_1) and arg_763_1.var_.characterEffect1019ui_story then
				arg_763_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_763_1.time_ and arg_763_1.time_ <= 0 + arg_766_0 then
				arg_763_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_763_1.time_ and arg_763_1.time_ <= 0 + arg_766_0 then
				arg_763_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1301cva")
			end

			local var_766_4 = arg_763_1.actors_["1029ui_story"]

			if 0 < arg_763_1.time_ and arg_763_1.time_ <= 0 + arg_766_0 and not isNil(var_766_4) and arg_763_1.var_.characterEffect1029ui_story == nil then
				arg_763_1.var_.characterEffect1029ui_story = var_766_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_766_5 = 0.200000002980232

			if 0 <= arg_763_1.time_ and arg_763_1.time_ < 0 + var_766_5 and not isNil(var_766_4) then
				if arg_763_1.var_.characterEffect1029ui_story and not isNil(var_766_4) then
					arg_763_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_763_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_763_1.time_ - 0) / var_766_5)
				end
			end

			if arg_763_1.time_ >= 0 + var_766_5 and arg_763_1.time_ < 0 + var_766_5 + arg_766_0 and not isNil(var_766_4) and arg_763_1.var_.characterEffect1029ui_story then
				arg_763_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_763_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_766_6 = 0
			local var_766_7 = 0.5

			if 0 < arg_763_1.time_ and arg_763_1.time_ <= var_766_6 + arg_766_0 then
				arg_763_1.talkMaxDuration = 0
				arg_763_1.dialogCg_.alpha = 1

				arg_763_1.dialog_:SetActive(true)
				SetActive(arg_763_1.leftNameGo_, true)

				arg_763_1.leftNameTxt_.text = arg_763_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_763_1.leftNameTxt_.transform)

				arg_763_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_763_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_763_1:RecordName(arg_763_1.leftNameTxt_.text)
				SetActive(arg_763_1.iconTrs_.gameObject, false)
				arg_763_1.callingController_:SetSelectedState("normal")

				local var_766_8 = arg_763_1:GetWordFromCfg(1101905187)
				local var_766_9 = arg_763_1:FormatText(var_766_8.content)

				arg_763_1.text_.text = var_766_9

				LuaForUtil.ClearLinePrefixSymbol(arg_763_1.text_)

				local var_766_11 = 7 <= 0 and var_766_7 or var_766_7 * (utf8.len(var_766_9) / 7)

				if (7 <= 0 and var_766_7 or var_766_7 * (utf8.len(var_766_9) / 7)) > 0 and var_766_7 < var_766_11 then
					arg_763_1.talkMaxDuration = var_766_11

					if var_766_11 + var_766_6 > arg_763_1.duration_ then
						arg_763_1.duration_ = var_766_11 + var_766_6
					end
				end

				arg_763_1.text_.text = var_766_9
				arg_763_1.typewritter.percent = 0

				arg_763_1.typewritter:SetDirty()
				arg_763_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905187", "story_v_side_new_1101905.awb") ~= 0 then
					local var_766_12 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905187", "story_v_side_new_1101905.awb") / 1000

					if var_766_12 + var_766_6 > arg_763_1.duration_ then
						arg_763_1.duration_ = var_766_12 + var_766_6
					end

					if var_766_8.prefab_name ~= "" and arg_763_1.actors_[var_766_8.prefab_name] ~= nil then
						local var_766_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_763_1.actors_[var_766_8.prefab_name].transform, "story_v_side_new_1101905", "1101905187", "story_v_side_new_1101905.awb")

						arg_763_1:RecordAudio("1101905187", var_766_13)
						arg_763_1:RecordAudio("1101905187", var_766_13)
					else
						arg_763_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905187", "story_v_side_new_1101905.awb")
					end

					arg_763_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905187", "story_v_side_new_1101905.awb")
				end

				arg_763_1:RecordContent(arg_763_1.text_.text)
			end

			local var_766_14 = math.max(var_766_7, arg_763_1.talkMaxDuration)

			if var_766_6 <= arg_763_1.time_ and arg_763_1.time_ < var_766_6 + var_766_14 then
				arg_763_1.typewritter.percent = (arg_763_1.time_ - var_766_6) / var_766_14

				arg_763_1.typewritter:SetDirty()
			end

			if arg_763_1.time_ >= var_766_6 + var_766_14 and arg_763_1.time_ < var_766_6 + var_766_14 + arg_766_0 then
				arg_763_1.typewritter.percent = 1

				arg_763_1.typewritter:SetDirty()
				arg_763_1:ShowNextGo(true)
			end
		end

		arg_763_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_763_1:InitPlayNodeList()
	end,
	Play1101905188 = function(arg_767_0, arg_767_1)
		arg_767_1.time_ = 0
		arg_767_1.frameCnt_ = 0
		arg_767_1.state_ = "playing"
		arg_767_1.curTalkId_ = 1101905188
		arg_767_1.duration_ = 4.87

		local var_767_0 = {
			zh = 3.633,
			ja = 4.866
		}
		local var_767_1 = manager.audio:GetLocalizationFlag()

		if var_767_0[var_767_1] ~= nil then
			arg_767_1.duration_ = var_767_0[var_767_1]
		end

		SetActive(arg_767_1.tipsGo_, false)

		function arg_767_1.onSingleLineFinish_()
			arg_767_1.onSingleLineUpdate_ = nil
			arg_767_1.onSingleLineFinish_ = nil
			arg_767_1.state_ = "waiting"
		end

		function arg_767_1.playNext_(arg_769_0)
			if arg_769_0 == 1 then
				arg_767_0:Play1101905189(arg_767_1)
			end
		end

		function arg_767_1.onSingleLineUpdate_(arg_770_0)
			if 0 < arg_767_1.time_ and arg_767_1.time_ <= 0 + arg_770_0 then
				arg_767_1.var_.moveOldPos1029ui_story = arg_767_1.actors_["1029ui_story"].transform.localPosition
			end

			local var_770_0 = 0.001

			if 0 <= arg_767_1.time_ and arg_767_1.time_ < 0 + var_770_0 then
				arg_767_1.actors_["1029ui_story"].transform.localPosition = Vector3.Lerp(arg_767_1.var_.moveOldPos1029ui_story, Vector3.New(0.7, -1.09, -6.2), (arg_767_1.time_ - 0) / var_770_0)
				arg_767_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_767_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_767_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_767_1.actors_["1029ui_story"].transform.position).z)
				arg_767_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_767_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_767_1.actors_["1029ui_story"].transform.localEulerAngles = arg_767_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if arg_767_1.time_ >= 0 + var_770_0 and arg_767_1.time_ < 0 + var_770_0 + arg_770_0 then
				arg_767_1.actors_["1029ui_story"].transform.localPosition = Vector3.New(0.7, -1.09, -6.2)
				arg_767_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_767_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_767_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_767_1.actors_["1029ui_story"].transform.position).z)
				arg_767_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_767_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_767_1.actors_["1029ui_story"].transform.localEulerAngles = arg_767_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			local var_770_1 = arg_767_1.actors_["1029ui_story"]

			if 0 < arg_767_1.time_ and arg_767_1.time_ <= 0 + arg_770_0 and not isNil(var_770_1) and arg_767_1.var_.characterEffect1029ui_story == nil then
				arg_767_1.var_.characterEffect1029ui_story = var_770_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_770_2 = 0.200000002980232

			if 0 <= arg_767_1.time_ and arg_767_1.time_ < 0 + var_770_2 and not isNil(var_770_1) then
				if arg_767_1.var_.characterEffect1029ui_story and not isNil(var_770_1) then
					arg_767_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_767_1.time_ >= 0 + var_770_2 and arg_767_1.time_ < 0 + var_770_2 + arg_770_0 and not isNil(var_770_1) and arg_767_1.var_.characterEffect1029ui_story then
				arg_767_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_770_4 = arg_767_1.actors_["1019ui_story"]

			if 0 < arg_767_1.time_ and arg_767_1.time_ <= 0 + arg_770_0 and not isNil(var_770_4) and arg_767_1.var_.characterEffect1019ui_story == nil then
				arg_767_1.var_.characterEffect1019ui_story = var_770_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_770_5 = 0.200000002980232

			if 0 <= arg_767_1.time_ and arg_767_1.time_ < 0 + var_770_5 and not isNil(var_770_4) then
				if arg_767_1.var_.characterEffect1019ui_story and not isNil(var_770_4) then
					arg_767_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_767_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_767_1.time_ - 0) / var_770_5)
				end
			end

			if arg_767_1.time_ >= 0 + var_770_5 and arg_767_1.time_ < 0 + var_770_5 + arg_770_0 and not isNil(var_770_4) and arg_767_1.var_.characterEffect1019ui_story then
				arg_767_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_767_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_770_6 = 0
			local var_770_7 = 0.225

			if 0 < arg_767_1.time_ and arg_767_1.time_ <= var_770_6 + arg_770_0 then
				arg_767_1.talkMaxDuration = 0
				arg_767_1.dialogCg_.alpha = 1

				arg_767_1.dialog_:SetActive(true)
				SetActive(arg_767_1.leftNameGo_, true)

				arg_767_1.leftNameTxt_.text = arg_767_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_767_1.leftNameTxt_.transform)

				arg_767_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_767_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_767_1:RecordName(arg_767_1.leftNameTxt_.text)
				SetActive(arg_767_1.iconTrs_.gameObject, false)
				arg_767_1.callingController_:SetSelectedState("normal")

				local var_770_8 = arg_767_1:GetWordFromCfg(1101905188)
				local var_770_9 = arg_767_1:FormatText(var_770_8.content)

				arg_767_1.text_.text = var_770_9

				LuaForUtil.ClearLinePrefixSymbol(arg_767_1.text_)

				local var_770_11 = 17 <= 0 and var_770_7 or var_770_7 * (utf8.len(var_770_9) / 17)

				if (17 <= 0 and var_770_7 or var_770_7 * (utf8.len(var_770_9) / 17)) > 0 and var_770_7 < var_770_11 then
					arg_767_1.talkMaxDuration = var_770_11

					if var_770_11 + var_770_6 > arg_767_1.duration_ then
						arg_767_1.duration_ = var_770_11 + var_770_6
					end
				end

				arg_767_1.text_.text = var_770_9
				arg_767_1.typewritter.percent = 0

				arg_767_1.typewritter:SetDirty()
				arg_767_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905188", "story_v_side_new_1101905.awb") ~= 0 then
					local var_770_12 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905188", "story_v_side_new_1101905.awb") / 1000

					if var_770_12 + var_770_6 > arg_767_1.duration_ then
						arg_767_1.duration_ = var_770_12 + var_770_6
					end

					if var_770_8.prefab_name ~= "" and arg_767_1.actors_[var_770_8.prefab_name] ~= nil then
						local var_770_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_767_1.actors_[var_770_8.prefab_name].transform, "story_v_side_new_1101905", "1101905188", "story_v_side_new_1101905.awb")

						arg_767_1:RecordAudio("1101905188", var_770_13)
						arg_767_1:RecordAudio("1101905188", var_770_13)
					else
						arg_767_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905188", "story_v_side_new_1101905.awb")
					end

					arg_767_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905188", "story_v_side_new_1101905.awb")
				end

				arg_767_1:RecordContent(arg_767_1.text_.text)
			end

			local var_770_14 = math.max(var_770_7, arg_767_1.talkMaxDuration)

			if var_770_6 <= arg_767_1.time_ and arg_767_1.time_ < var_770_6 + var_770_14 then
				arg_767_1.typewritter.percent = (arg_767_1.time_ - var_770_6) / var_770_14

				arg_767_1.typewritter:SetDirty()
			end

			if arg_767_1.time_ >= var_770_6 + var_770_14 and arg_767_1.time_ < var_770_6 + var_770_14 + arg_770_0 then
				arg_767_1.typewritter.percent = 1

				arg_767_1.typewritter:SetDirty()
				arg_767_1:ShowNextGo(true)
			end
		end

		arg_767_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_767_1:InitPlayNodeList()
	end,
	Play1101905189 = function(arg_771_0, arg_771_1)
		arg_771_1.time_ = 0
		arg_771_1.frameCnt_ = 0
		arg_771_1.state_ = "playing"
		arg_771_1.curTalkId_ = 1101905189
		arg_771_1.duration_ = 7.63

		local var_771_0 = {
			zh = 5.766,
			ja = 7.633
		}
		local var_771_1 = manager.audio:GetLocalizationFlag()

		if var_771_0[var_771_1] ~= nil then
			arg_771_1.duration_ = var_771_0[var_771_1]
		end

		SetActive(arg_771_1.tipsGo_, false)

		function arg_771_1.onSingleLineFinish_()
			arg_771_1.onSingleLineUpdate_ = nil
			arg_771_1.onSingleLineFinish_ = nil
			arg_771_1.state_ = "waiting"
		end

		function arg_771_1.playNext_(arg_773_0)
			if arg_773_0 == 1 then
				arg_771_0:Play1101905190(arg_771_1)
			end
		end

		function arg_771_1.onSingleLineUpdate_(arg_774_0)
			local var_774_0 = 0.675

			if 0 < arg_771_1.time_ and arg_771_1.time_ <= 0 + arg_774_0 then
				arg_771_1.talkMaxDuration = 0
				arg_771_1.dialogCg_.alpha = 1

				arg_771_1.dialog_:SetActive(true)
				SetActive(arg_771_1.leftNameGo_, true)

				arg_771_1.leftNameTxt_.text = arg_771_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_771_1.leftNameTxt_.transform)

				arg_771_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_771_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_771_1:RecordName(arg_771_1.leftNameTxt_.text)
				SetActive(arg_771_1.iconTrs_.gameObject, false)
				arg_771_1.callingController_:SetSelectedState("normal")

				local var_774_1 = arg_771_1:GetWordFromCfg(1101905189)
				local var_774_2 = arg_771_1:FormatText(var_774_1.content)

				arg_771_1.text_.text = var_774_2

				LuaForUtil.ClearLinePrefixSymbol(arg_771_1.text_)

				local var_774_4 = 27 <= 0 and var_774_0 or var_774_0 * (utf8.len(var_774_2) / 27)

				if (27 <= 0 and var_774_0 or var_774_0 * (utf8.len(var_774_2) / 27)) > 0 and var_774_0 < var_774_4 then
					arg_771_1.talkMaxDuration = var_774_4

					if var_774_4 + 0 > arg_771_1.duration_ then
						arg_771_1.duration_ = var_774_4 + 0
					end
				end

				arg_771_1.text_.text = var_774_2
				arg_771_1.typewritter.percent = 0

				arg_771_1.typewritter:SetDirty()
				arg_771_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905189", "story_v_side_new_1101905.awb") ~= 0 then
					local var_774_5 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905189", "story_v_side_new_1101905.awb") / 1000

					if var_774_5 + 0 > arg_771_1.duration_ then
						arg_771_1.duration_ = var_774_5 + 0
					end

					if var_774_1.prefab_name ~= "" and arg_771_1.actors_[var_774_1.prefab_name] ~= nil then
						local var_774_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_771_1.actors_[var_774_1.prefab_name].transform, "story_v_side_new_1101905", "1101905189", "story_v_side_new_1101905.awb")

						arg_771_1:RecordAudio("1101905189", var_774_6)
						arg_771_1:RecordAudio("1101905189", var_774_6)
					else
						arg_771_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905189", "story_v_side_new_1101905.awb")
					end

					arg_771_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905189", "story_v_side_new_1101905.awb")
				end

				arg_771_1:RecordContent(arg_771_1.text_.text)
			end

			local var_774_7 = math.max(var_774_0, arg_771_1.talkMaxDuration)

			if 0 <= arg_771_1.time_ and arg_771_1.time_ < 0 + var_774_7 then
				arg_771_1.typewritter.percent = (arg_771_1.time_ - 0) / var_774_7

				arg_771_1.typewritter:SetDirty()
			end

			if arg_771_1.time_ >= 0 + var_774_7 and arg_771_1.time_ < 0 + var_774_7 + arg_774_0 then
				arg_771_1.typewritter.percent = 1

				arg_771_1.typewritter:SetDirty()
				arg_771_1:ShowNextGo(true)
			end
		end

		arg_771_1.nodeConfigList_ = {}

		arg_771_1:InitPlayNodeList()
	end,
	Play1101905190 = function(arg_775_0, arg_775_1)
		arg_775_1.time_ = 0
		arg_775_1.frameCnt_ = 0
		arg_775_1.state_ = "playing"
		arg_775_1.curTalkId_ = 1101905190
		arg_775_1.duration_ = 6.2

		local var_775_0 = {
			zh = 2.3,
			ja = 6.2
		}
		local var_775_1 = manager.audio:GetLocalizationFlag()

		if var_775_0[var_775_1] ~= nil then
			arg_775_1.duration_ = var_775_0[var_775_1]
		end

		SetActive(arg_775_1.tipsGo_, false)

		function arg_775_1.onSingleLineFinish_()
			arg_775_1.onSingleLineUpdate_ = nil
			arg_775_1.onSingleLineFinish_ = nil
			arg_775_1.state_ = "waiting"
		end

		function arg_775_1.playNext_(arg_777_0)
			if arg_777_0 == 1 then
				arg_775_0:Play1101905191(arg_775_1)
			end
		end

		function arg_775_1.onSingleLineUpdate_(arg_778_0)
			if 0 < arg_775_1.time_ and arg_775_1.time_ <= 0 + arg_778_0 and not isNil(arg_775_1.actors_["1019ui_story"]) and arg_775_1.var_.characterEffect1019ui_story == nil then
				arg_775_1.var_.characterEffect1019ui_story = arg_775_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_778_0 = 0.200000002980232

			if 0 <= arg_775_1.time_ and arg_775_1.time_ < 0 + var_778_0 and not isNil(arg_775_1.actors_["1019ui_story"]) then
				if arg_775_1.var_.characterEffect1019ui_story and not isNil(arg_775_1.actors_["1019ui_story"]) then
					arg_775_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_775_1.time_ >= 0 + var_778_0 and arg_775_1.time_ < 0 + var_778_0 + arg_778_0 and not isNil(arg_775_1.actors_["1019ui_story"]) and arg_775_1.var_.characterEffect1019ui_story then
				arg_775_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_775_1.time_ and arg_775_1.time_ <= 0 + arg_778_0 then
				arg_775_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_778_2 = arg_775_1.actors_["1029ui_story"]

			if 0 < arg_775_1.time_ and arg_775_1.time_ <= 0 + arg_778_0 and not isNil(var_778_2) and arg_775_1.var_.characterEffect1029ui_story == nil then
				arg_775_1.var_.characterEffect1029ui_story = var_778_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_778_3 = 0.200000002980232

			if 0 <= arg_775_1.time_ and arg_775_1.time_ < 0 + var_778_3 and not isNil(var_778_2) then
				if arg_775_1.var_.characterEffect1029ui_story and not isNil(var_778_2) then
					arg_775_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_775_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_775_1.time_ - 0) / var_778_3)
				end
			end

			if arg_775_1.time_ >= 0 + var_778_3 and arg_775_1.time_ < 0 + var_778_3 + arg_778_0 and not isNil(var_778_2) and arg_775_1.var_.characterEffect1029ui_story then
				arg_775_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_775_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_778_4 = 0
			local var_778_5 = 0.6

			if 0 < arg_775_1.time_ and arg_775_1.time_ <= var_778_4 + arg_778_0 then
				arg_775_1.talkMaxDuration = 0
				arg_775_1.dialogCg_.alpha = 1

				arg_775_1.dialog_:SetActive(true)
				SetActive(arg_775_1.leftNameGo_, true)

				arg_775_1.leftNameTxt_.text = arg_775_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_775_1.leftNameTxt_.transform)

				arg_775_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_775_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_775_1:RecordName(arg_775_1.leftNameTxt_.text)
				SetActive(arg_775_1.iconTrs_.gameObject, false)
				arg_775_1.callingController_:SetSelectedState("normal")

				local var_778_6 = arg_775_1:GetWordFromCfg(1101905190)
				local var_778_7 = arg_775_1:FormatText(var_778_6.content)

				arg_775_1.text_.text = var_778_7

				LuaForUtil.ClearLinePrefixSymbol(arg_775_1.text_)

				local var_778_9 = 12 <= 0 and var_778_5 or var_778_5 * (utf8.len(var_778_7) / 12)

				if (12 <= 0 and var_778_5 or var_778_5 * (utf8.len(var_778_7) / 12)) > 0 and var_778_5 < var_778_9 then
					arg_775_1.talkMaxDuration = var_778_9

					if var_778_9 + var_778_4 > arg_775_1.duration_ then
						arg_775_1.duration_ = var_778_9 + var_778_4
					end
				end

				arg_775_1.text_.text = var_778_7
				arg_775_1.typewritter.percent = 0

				arg_775_1.typewritter:SetDirty()
				arg_775_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905190", "story_v_side_new_1101905.awb") ~= 0 then
					local var_778_10 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905190", "story_v_side_new_1101905.awb") / 1000

					if var_778_10 + var_778_4 > arg_775_1.duration_ then
						arg_775_1.duration_ = var_778_10 + var_778_4
					end

					if var_778_6.prefab_name ~= "" and arg_775_1.actors_[var_778_6.prefab_name] ~= nil then
						local var_778_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_775_1.actors_[var_778_6.prefab_name].transform, "story_v_side_new_1101905", "1101905190", "story_v_side_new_1101905.awb")

						arg_775_1:RecordAudio("1101905190", var_778_11)
						arg_775_1:RecordAudio("1101905190", var_778_11)
					else
						arg_775_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905190", "story_v_side_new_1101905.awb")
					end

					arg_775_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905190", "story_v_side_new_1101905.awb")
				end

				arg_775_1:RecordContent(arg_775_1.text_.text)
			end

			local var_778_12 = math.max(var_778_5, arg_775_1.talkMaxDuration)

			if var_778_4 <= arg_775_1.time_ and arg_775_1.time_ < var_778_4 + var_778_12 then
				arg_775_1.typewritter.percent = (arg_775_1.time_ - var_778_4) / var_778_12

				arg_775_1.typewritter:SetDirty()
			end

			if arg_775_1.time_ >= var_778_4 + var_778_12 and arg_775_1.time_ < var_778_4 + var_778_12 + arg_778_0 then
				arg_775_1.typewritter.percent = 1

				arg_775_1.typewritter:SetDirty()
				arg_775_1:ShowNextGo(true)
			end
		end

		arg_775_1.nodeConfigList_ = {}

		arg_775_1:InitPlayNodeList()
	end,
	Play1101905191 = function(arg_779_0, arg_779_1)
		arg_779_1.time_ = 0
		arg_779_1.frameCnt_ = 0
		arg_779_1.state_ = "playing"
		arg_779_1.curTalkId_ = 1101905191
		arg_779_1.duration_ = 3.43

		local var_779_0 = {
			zh = 3.433,
			ja = 3.333
		}
		local var_779_1 = manager.audio:GetLocalizationFlag()

		if var_779_0[var_779_1] ~= nil then
			arg_779_1.duration_ = var_779_0[var_779_1]
		end

		SetActive(arg_779_1.tipsGo_, false)

		function arg_779_1.onSingleLineFinish_()
			arg_779_1.onSingleLineUpdate_ = nil
			arg_779_1.onSingleLineFinish_ = nil
			arg_779_1.state_ = "waiting"
		end

		function arg_779_1.playNext_(arg_781_0)
			if arg_781_0 == 1 then
				arg_779_0:Play1101905192(arg_779_1)
			end
		end

		function arg_779_1.onSingleLineUpdate_(arg_782_0)
			if 0 < arg_779_1.time_ and arg_779_1.time_ <= 0 + arg_782_0 and not isNil(arg_779_1.actors_["1029ui_story"]) and arg_779_1.var_.characterEffect1029ui_story == nil then
				arg_779_1.var_.characterEffect1029ui_story = arg_779_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_782_0 = 0.200000002980232

			if 0 <= arg_779_1.time_ and arg_779_1.time_ < 0 + var_782_0 and not isNil(arg_779_1.actors_["1029ui_story"]) then
				if arg_779_1.var_.characterEffect1029ui_story and not isNil(arg_779_1.actors_["1029ui_story"]) then
					arg_779_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_779_1.time_ >= 0 + var_782_0 and arg_779_1.time_ < 0 + var_782_0 + arg_782_0 and not isNil(arg_779_1.actors_["1029ui_story"]) and arg_779_1.var_.characterEffect1029ui_story then
				arg_779_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_779_1.time_ and arg_779_1.time_ <= 0 + arg_782_0 then
				arg_779_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			if 0 < arg_779_1.time_ and arg_779_1.time_ <= 0 + arg_782_0 then
				arg_779_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_782_2 = arg_779_1.actors_["1019ui_story"]

			if 0 < arg_779_1.time_ and arg_779_1.time_ <= 0 + arg_782_0 and not isNil(var_782_2) and arg_779_1.var_.characterEffect1019ui_story == nil then
				arg_779_1.var_.characterEffect1019ui_story = var_782_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_782_3 = 0.200000002980232

			if 0 <= arg_779_1.time_ and arg_779_1.time_ < 0 + var_782_3 and not isNil(var_782_2) then
				if arg_779_1.var_.characterEffect1019ui_story and not isNil(var_782_2) then
					arg_779_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_779_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_779_1.time_ - 0) / var_782_3)
				end
			end

			if arg_779_1.time_ >= 0 + var_782_3 and arg_779_1.time_ < 0 + var_782_3 + arg_782_0 and not isNil(var_782_2) and arg_779_1.var_.characterEffect1019ui_story then
				arg_779_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_779_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_782_4 = 0
			local var_782_5 = 0.175

			if 0 < arg_779_1.time_ and arg_779_1.time_ <= var_782_4 + arg_782_0 then
				arg_779_1.talkMaxDuration = 0
				arg_779_1.dialogCg_.alpha = 1

				arg_779_1.dialog_:SetActive(true)
				SetActive(arg_779_1.leftNameGo_, true)

				arg_779_1.leftNameTxt_.text = arg_779_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_779_1.leftNameTxt_.transform)

				arg_779_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_779_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_779_1:RecordName(arg_779_1.leftNameTxt_.text)
				SetActive(arg_779_1.iconTrs_.gameObject, false)
				arg_779_1.callingController_:SetSelectedState("normal")

				local var_782_6 = arg_779_1:GetWordFromCfg(1101905191)
				local var_782_7 = arg_779_1:FormatText(var_782_6.content)

				arg_779_1.text_.text = var_782_7

				LuaForUtil.ClearLinePrefixSymbol(arg_779_1.text_)

				local var_782_9 = 16 <= 0 and var_782_5 or var_782_5 * (utf8.len(var_782_7) / 16)

				if (16 <= 0 and var_782_5 or var_782_5 * (utf8.len(var_782_7) / 16)) > 0 and var_782_5 < var_782_9 then
					arg_779_1.talkMaxDuration = var_782_9

					if var_782_9 + var_782_4 > arg_779_1.duration_ then
						arg_779_1.duration_ = var_782_9 + var_782_4
					end
				end

				arg_779_1.text_.text = var_782_7
				arg_779_1.typewritter.percent = 0

				arg_779_1.typewritter:SetDirty()
				arg_779_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905191", "story_v_side_new_1101905.awb") ~= 0 then
					local var_782_10 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905191", "story_v_side_new_1101905.awb") / 1000

					if var_782_10 + var_782_4 > arg_779_1.duration_ then
						arg_779_1.duration_ = var_782_10 + var_782_4
					end

					if var_782_6.prefab_name ~= "" and arg_779_1.actors_[var_782_6.prefab_name] ~= nil then
						local var_782_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_779_1.actors_[var_782_6.prefab_name].transform, "story_v_side_new_1101905", "1101905191", "story_v_side_new_1101905.awb")

						arg_779_1:RecordAudio("1101905191", var_782_11)
						arg_779_1:RecordAudio("1101905191", var_782_11)
					else
						arg_779_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905191", "story_v_side_new_1101905.awb")
					end

					arg_779_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905191", "story_v_side_new_1101905.awb")
				end

				arg_779_1:RecordContent(arg_779_1.text_.text)
			end

			local var_782_12 = math.max(var_782_5, arg_779_1.talkMaxDuration)

			if var_782_4 <= arg_779_1.time_ and arg_779_1.time_ < var_782_4 + var_782_12 then
				arg_779_1.typewritter.percent = (arg_779_1.time_ - var_782_4) / var_782_12

				arg_779_1.typewritter:SetDirty()
			end

			if arg_779_1.time_ >= var_782_4 + var_782_12 and arg_779_1.time_ < var_782_4 + var_782_12 + arg_782_0 then
				arg_779_1.typewritter.percent = 1

				arg_779_1.typewritter:SetDirty()
				arg_779_1:ShowNextGo(true)
			end
		end

		arg_779_1.nodeConfigList_ = {}

		arg_779_1:InitPlayNodeList()
	end,
	Play1101905192 = function(arg_783_0, arg_783_1)
		arg_783_1.time_ = 0
		arg_783_1.frameCnt_ = 0
		arg_783_1.state_ = "playing"
		arg_783_1.curTalkId_ = 1101905192
		arg_783_1.duration_ = 2

		SetActive(arg_783_1.tipsGo_, false)

		function arg_783_1.onSingleLineFinish_()
			arg_783_1.onSingleLineUpdate_ = nil
			arg_783_1.onSingleLineFinish_ = nil
			arg_783_1.state_ = "waiting"
		end

		function arg_783_1.playNext_(arg_785_0)
			if arg_785_0 == 1 then
				arg_783_0:Play1101905193(arg_783_1)
			end
		end

		function arg_783_1.onSingleLineUpdate_(arg_786_0)
			if 0 < arg_783_1.time_ and arg_783_1.time_ <= 0 + arg_786_0 and not isNil(arg_783_1.actors_["1019ui_story"]) and arg_783_1.var_.characterEffect1019ui_story == nil then
				arg_783_1.var_.characterEffect1019ui_story = arg_783_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_786_0 = 0.200000002980232

			if 0 <= arg_783_1.time_ and arg_783_1.time_ < 0 + var_786_0 and not isNil(arg_783_1.actors_["1019ui_story"]) then
				if arg_783_1.var_.characterEffect1019ui_story and not isNil(arg_783_1.actors_["1019ui_story"]) then
					arg_783_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_783_1.time_ >= 0 + var_786_0 and arg_783_1.time_ < 0 + var_786_0 + arg_786_0 and not isNil(arg_783_1.actors_["1019ui_story"]) and arg_783_1.var_.characterEffect1019ui_story then
				arg_783_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_783_1.time_ and arg_783_1.time_ <= 0 + arg_786_0 then
				arg_783_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_783_1.time_ and arg_783_1.time_ <= 0 + arg_786_0 then
				arg_783_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_786_2 = arg_783_1.actors_["1029ui_story"]

			if 0 < arg_783_1.time_ and arg_783_1.time_ <= 0 + arg_786_0 and not isNil(var_786_2) and arg_783_1.var_.characterEffect1029ui_story == nil then
				arg_783_1.var_.characterEffect1029ui_story = var_786_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_786_3 = 0.200000002980232

			if 0 <= arg_783_1.time_ and arg_783_1.time_ < 0 + var_786_3 and not isNil(var_786_2) then
				if arg_783_1.var_.characterEffect1029ui_story and not isNil(var_786_2) then
					arg_783_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_783_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_783_1.time_ - 0) / var_786_3)
				end
			end

			if arg_783_1.time_ >= 0 + var_786_3 and arg_783_1.time_ < 0 + var_786_3 + arg_786_0 and not isNil(var_786_2) and arg_783_1.var_.characterEffect1029ui_story then
				arg_783_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_783_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_786_4 = 0
			local var_786_5 = 0.425

			if 0 < arg_783_1.time_ and arg_783_1.time_ <= var_786_4 + arg_786_0 then
				arg_783_1.talkMaxDuration = 0
				arg_783_1.dialogCg_.alpha = 1

				arg_783_1.dialog_:SetActive(true)
				SetActive(arg_783_1.leftNameGo_, true)

				arg_783_1.leftNameTxt_.text = arg_783_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_783_1.leftNameTxt_.transform)

				arg_783_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_783_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_783_1:RecordName(arg_783_1.leftNameTxt_.text)
				SetActive(arg_783_1.iconTrs_.gameObject, false)
				arg_783_1.callingController_:SetSelectedState("normal")

				local var_786_6 = arg_783_1:GetWordFromCfg(1101905192)
				local var_786_7 = arg_783_1:FormatText(var_786_6.content)

				arg_783_1.text_.text = var_786_7

				LuaForUtil.ClearLinePrefixSymbol(arg_783_1.text_)

				local var_786_9 = 3 <= 0 and var_786_5 or var_786_5 * (utf8.len(var_786_7) / 3)

				if (3 <= 0 and var_786_5 or var_786_5 * (utf8.len(var_786_7) / 3)) > 0 and var_786_5 < var_786_9 then
					arg_783_1.talkMaxDuration = var_786_9

					if var_786_9 + var_786_4 > arg_783_1.duration_ then
						arg_783_1.duration_ = var_786_9 + var_786_4
					end
				end

				arg_783_1.text_.text = var_786_7
				arg_783_1.typewritter.percent = 0

				arg_783_1.typewritter:SetDirty()
				arg_783_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905192", "story_v_side_new_1101905.awb") ~= 0 then
					local var_786_10 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905192", "story_v_side_new_1101905.awb") / 1000

					if var_786_10 + var_786_4 > arg_783_1.duration_ then
						arg_783_1.duration_ = var_786_10 + var_786_4
					end

					if var_786_6.prefab_name ~= "" and arg_783_1.actors_[var_786_6.prefab_name] ~= nil then
						local var_786_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_783_1.actors_[var_786_6.prefab_name].transform, "story_v_side_new_1101905", "1101905192", "story_v_side_new_1101905.awb")

						arg_783_1:RecordAudio("1101905192", var_786_11)
						arg_783_1:RecordAudio("1101905192", var_786_11)
					else
						arg_783_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905192", "story_v_side_new_1101905.awb")
					end

					arg_783_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905192", "story_v_side_new_1101905.awb")
				end

				arg_783_1:RecordContent(arg_783_1.text_.text)
			end

			local var_786_12 = math.max(var_786_5, arg_783_1.talkMaxDuration)

			if var_786_4 <= arg_783_1.time_ and arg_783_1.time_ < var_786_4 + var_786_12 then
				arg_783_1.typewritter.percent = (arg_783_1.time_ - var_786_4) / var_786_12

				arg_783_1.typewritter:SetDirty()
			end

			if arg_783_1.time_ >= var_786_4 + var_786_12 and arg_783_1.time_ < var_786_4 + var_786_12 + arg_786_0 then
				arg_783_1.typewritter.percent = 1

				arg_783_1.typewritter:SetDirty()
				arg_783_1:ShowNextGo(true)
			end
		end

		arg_783_1.nodeConfigList_ = {}

		arg_783_1:InitPlayNodeList()
	end,
	Play1101905193 = function(arg_787_0, arg_787_1)
		arg_787_1.time_ = 0
		arg_787_1.frameCnt_ = 0
		arg_787_1.state_ = "playing"
		arg_787_1.curTalkId_ = 1101905193
		arg_787_1.duration_ = 5

		SetActive(arg_787_1.tipsGo_, false)

		function arg_787_1.onSingleLineFinish_()
			arg_787_1.onSingleLineUpdate_ = nil
			arg_787_1.onSingleLineFinish_ = nil
			arg_787_1.state_ = "waiting"
		end

		function arg_787_1.playNext_(arg_789_0)
			if arg_789_0 == 1 then
				arg_787_0:Play1101905194(arg_787_1)
			end
		end

		function arg_787_1.onSingleLineUpdate_(arg_790_0)
			if 0 < arg_787_1.time_ and arg_787_1.time_ <= 0 + arg_790_0 and not isNil(arg_787_1.actors_["1019ui_story"]) and arg_787_1.var_.characterEffect1019ui_story == nil then
				arg_787_1.var_.characterEffect1019ui_story = arg_787_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_790_0 = 0.200000002980232

			if 0 <= arg_787_1.time_ and arg_787_1.time_ < 0 + var_790_0 and not isNil(arg_787_1.actors_["1019ui_story"]) then
				if arg_787_1.var_.characterEffect1019ui_story and not isNil(arg_787_1.actors_["1019ui_story"]) then
					arg_787_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_787_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_787_1.time_ - 0) / var_790_0)
				end
			end

			if arg_787_1.time_ >= 0 + var_790_0 and arg_787_1.time_ < 0 + var_790_0 + arg_790_0 and not isNil(arg_787_1.actors_["1019ui_story"]) and arg_787_1.var_.characterEffect1019ui_story then
				arg_787_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_787_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_790_1 = 0
			local var_790_2 = 0.675

			if 0 < arg_787_1.time_ and arg_787_1.time_ <= var_790_1 + arg_790_0 then
				arg_787_1.talkMaxDuration = 0
				arg_787_1.dialogCg_.alpha = 1

				arg_787_1.dialog_:SetActive(true)
				SetActive(arg_787_1.leftNameGo_, false)

				arg_787_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_787_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_787_1:RecordName(arg_787_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_787_1.iconTrs_.gameObject, false)
				arg_787_1.callingController_:SetSelectedState("normal")

				local var_790_3 = arg_787_1:FormatText(arg_787_1:GetWordFromCfg(1101905193).content)

				arg_787_1.text_.text = var_790_3

				LuaForUtil.ClearLinePrefixSymbol(arg_787_1.text_)

				local var_790_5 = 16 <= 0 and var_790_2 or var_790_2 * (utf8.len(var_790_3) / 16)

				if (16 <= 0 and var_790_2 or var_790_2 * (utf8.len(var_790_3) / 16)) > 0 and var_790_2 < var_790_5 then
					arg_787_1.talkMaxDuration = var_790_5

					if var_790_5 + var_790_1 > arg_787_1.duration_ then
						arg_787_1.duration_ = var_790_5 + var_790_1
					end
				end

				arg_787_1.text_.text = var_790_3
				arg_787_1.typewritter.percent = 0

				arg_787_1.typewritter:SetDirty()
				arg_787_1:ShowNextGo(false)
				arg_787_1:RecordContent(arg_787_1.text_.text)
			end

			local var_790_6 = math.max(var_790_2, arg_787_1.talkMaxDuration)

			if var_790_1 <= arg_787_1.time_ and arg_787_1.time_ < var_790_1 + var_790_6 then
				arg_787_1.typewritter.percent = (arg_787_1.time_ - var_790_1) / var_790_6

				arg_787_1.typewritter:SetDirty()
			end

			if arg_787_1.time_ >= var_790_1 + var_790_6 and arg_787_1.time_ < var_790_1 + var_790_6 + arg_790_0 then
				arg_787_1.typewritter.percent = 1

				arg_787_1.typewritter:SetDirty()
				arg_787_1:ShowNextGo(true)
			end
		end

		arg_787_1.nodeConfigList_ = {}

		arg_787_1:InitPlayNodeList()
	end,
	Play1101905194 = function(arg_791_0, arg_791_1)
		arg_791_1.time_ = 0
		arg_791_1.frameCnt_ = 0
		arg_791_1.state_ = "playing"
		arg_791_1.curTalkId_ = 1101905194
		arg_791_1.duration_ = 3.93

		local var_791_0 = {
			zh = 3.933,
			ja = 1.999999999999
		}
		local var_791_1 = manager.audio:GetLocalizationFlag()

		if var_791_0[var_791_1] ~= nil then
			arg_791_1.duration_ = var_791_0[var_791_1]
		end

		SetActive(arg_791_1.tipsGo_, false)

		function arg_791_1.onSingleLineFinish_()
			arg_791_1.onSingleLineUpdate_ = nil
			arg_791_1.onSingleLineFinish_ = nil
			arg_791_1.state_ = "waiting"
		end

		function arg_791_1.playNext_(arg_793_0)
			if arg_793_0 == 1 then
				arg_791_0:Play1101905195(arg_791_1)
			end
		end

		function arg_791_1.onSingleLineUpdate_(arg_794_0)
			if 0 < arg_791_1.time_ and arg_791_1.time_ <= 0 + arg_794_0 then
				arg_791_1.var_.moveOldPos1029ui_story = arg_791_1.actors_["1029ui_story"].transform.localPosition
			end

			local var_794_0 = 0.001

			if 0 <= arg_791_1.time_ and arg_791_1.time_ < 0 + var_794_0 then
				arg_791_1.actors_["1029ui_story"].transform.localPosition = Vector3.Lerp(arg_791_1.var_.moveOldPos1029ui_story, Vector3.New(0.7, -1.09, -6.2), (arg_791_1.time_ - 0) / var_794_0)
				arg_791_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_791_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_791_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_791_1.actors_["1029ui_story"].transform.position).z)
				arg_791_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_791_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_791_1.actors_["1029ui_story"].transform.localEulerAngles = arg_791_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if arg_791_1.time_ >= 0 + var_794_0 and arg_791_1.time_ < 0 + var_794_0 + arg_794_0 then
				arg_791_1.actors_["1029ui_story"].transform.localPosition = Vector3.New(0.7, -1.09, -6.2)
				arg_791_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_791_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_791_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_791_1.actors_["1029ui_story"].transform.position).z)
				arg_791_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_791_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_791_1.actors_["1029ui_story"].transform.localEulerAngles = arg_791_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			local var_794_1 = arg_791_1.actors_["1029ui_story"]

			if 0 < arg_791_1.time_ and arg_791_1.time_ <= 0 + arg_794_0 and not isNil(var_794_1) and arg_791_1.var_.characterEffect1029ui_story == nil then
				arg_791_1.var_.characterEffect1029ui_story = var_794_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_794_2 = 0.200000002980232

			if 0 <= arg_791_1.time_ and arg_791_1.time_ < 0 + var_794_2 and not isNil(var_794_1) then
				if arg_791_1.var_.characterEffect1029ui_story and not isNil(var_794_1) then
					arg_791_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_791_1.time_ >= 0 + var_794_2 and arg_791_1.time_ < 0 + var_794_2 + arg_794_0 and not isNil(var_794_1) and arg_791_1.var_.characterEffect1029ui_story then
				arg_791_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_791_1.time_ and arg_791_1.time_ <= 0 + arg_794_0 then
				arg_791_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_1")
			end

			if 0 < arg_791_1.time_ and arg_791_1.time_ <= 0 + arg_794_0 then
				arg_791_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_794_4 = 0
			local var_794_5 = 0.3

			if 0 < arg_791_1.time_ and arg_791_1.time_ <= var_794_4 + arg_794_0 then
				arg_791_1.talkMaxDuration = 0
				arg_791_1.dialogCg_.alpha = 1

				arg_791_1.dialog_:SetActive(true)
				SetActive(arg_791_1.leftNameGo_, true)

				arg_791_1.leftNameTxt_.text = arg_791_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_791_1.leftNameTxt_.transform)

				arg_791_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_791_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_791_1:RecordName(arg_791_1.leftNameTxt_.text)
				SetActive(arg_791_1.iconTrs_.gameObject, false)
				arg_791_1.callingController_:SetSelectedState("normal")

				local var_794_6 = arg_791_1:GetWordFromCfg(1101905194)
				local var_794_7 = arg_791_1:FormatText(var_794_6.content)

				arg_791_1.text_.text = var_794_7

				LuaForUtil.ClearLinePrefixSymbol(arg_791_1.text_)

				local var_794_9 = 9 <= 0 and var_794_5 or var_794_5 * (utf8.len(var_794_7) / 9)

				if (9 <= 0 and var_794_5 or var_794_5 * (utf8.len(var_794_7) / 9)) > 0 and var_794_5 < var_794_9 then
					arg_791_1.talkMaxDuration = var_794_9

					if var_794_9 + var_794_4 > arg_791_1.duration_ then
						arg_791_1.duration_ = var_794_9 + var_794_4
					end
				end

				arg_791_1.text_.text = var_794_7
				arg_791_1.typewritter.percent = 0

				arg_791_1.typewritter:SetDirty()
				arg_791_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905194", "story_v_side_new_1101905.awb") ~= 0 then
					local var_794_10 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905194", "story_v_side_new_1101905.awb") / 1000

					if var_794_10 + var_794_4 > arg_791_1.duration_ then
						arg_791_1.duration_ = var_794_10 + var_794_4
					end

					if var_794_6.prefab_name ~= "" and arg_791_1.actors_[var_794_6.prefab_name] ~= nil then
						local var_794_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_791_1.actors_[var_794_6.prefab_name].transform, "story_v_side_new_1101905", "1101905194", "story_v_side_new_1101905.awb")

						arg_791_1:RecordAudio("1101905194", var_794_11)
						arg_791_1:RecordAudio("1101905194", var_794_11)
					else
						arg_791_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905194", "story_v_side_new_1101905.awb")
					end

					arg_791_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905194", "story_v_side_new_1101905.awb")
				end

				arg_791_1:RecordContent(arg_791_1.text_.text)
			end

			local var_794_12 = math.max(var_794_5, arg_791_1.talkMaxDuration)

			if var_794_4 <= arg_791_1.time_ and arg_791_1.time_ < var_794_4 + var_794_12 then
				arg_791_1.typewritter.percent = (arg_791_1.time_ - var_794_4) / var_794_12

				arg_791_1.typewritter:SetDirty()
			end

			if arg_791_1.time_ >= var_794_4 + var_794_12 and arg_791_1.time_ < var_794_4 + var_794_12 + arg_794_0 then
				arg_791_1.typewritter.percent = 1

				arg_791_1.typewritter:SetDirty()
				arg_791_1:ShowNextGo(true)
			end
		end

		arg_791_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_791_1:InitPlayNodeList()
	end,
	Play1101905195 = function(arg_795_0, arg_795_1)
		arg_795_1.time_ = 0
		arg_795_1.frameCnt_ = 0
		arg_795_1.state_ = "playing"
		arg_795_1.curTalkId_ = 1101905195
		arg_795_1.duration_ = 5

		SetActive(arg_795_1.tipsGo_, false)

		function arg_795_1.onSingleLineFinish_()
			arg_795_1.onSingleLineUpdate_ = nil
			arg_795_1.onSingleLineFinish_ = nil
			arg_795_1.state_ = "waiting"
		end

		function arg_795_1.playNext_(arg_797_0)
			if arg_797_0 == 1 then
				arg_795_0:Play1101905196(arg_795_1)
			end
		end

		function arg_795_1.onSingleLineUpdate_(arg_798_0)
			if 0 < arg_795_1.time_ and arg_795_1.time_ <= 0 + arg_798_0 and not isNil(arg_795_1.actors_["1029ui_story"]) and arg_795_1.var_.characterEffect1029ui_story == nil then
				arg_795_1.var_.characterEffect1029ui_story = arg_795_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_798_0 = 0.200000002980232

			if 0 <= arg_795_1.time_ and arg_795_1.time_ < 0 + var_798_0 and not isNil(arg_795_1.actors_["1029ui_story"]) then
				if arg_795_1.var_.characterEffect1029ui_story and not isNil(arg_795_1.actors_["1029ui_story"]) then
					arg_795_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_795_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_795_1.time_ - 0) / var_798_0)
				end
			end

			if arg_795_1.time_ >= 0 + var_798_0 and arg_795_1.time_ < 0 + var_798_0 + arg_798_0 and not isNil(arg_795_1.actors_["1029ui_story"]) and arg_795_1.var_.characterEffect1029ui_story then
				arg_795_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_795_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_798_1 = 0
			local var_798_2 = 0.4

			if 0 < arg_795_1.time_ and arg_795_1.time_ <= var_798_1 + arg_798_0 then
				arg_795_1.talkMaxDuration = 0
				arg_795_1.dialogCg_.alpha = 1

				arg_795_1.dialog_:SetActive(true)
				SetActive(arg_795_1.leftNameGo_, false)

				arg_795_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_795_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_795_1:RecordName(arg_795_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_795_1.iconTrs_.gameObject, false)
				arg_795_1.callingController_:SetSelectedState("normal")

				local var_798_3 = arg_795_1:FormatText(arg_795_1:GetWordFromCfg(1101905195).content)

				arg_795_1.text_.text = var_798_3

				LuaForUtil.ClearLinePrefixSymbol(arg_795_1.text_)

				local var_798_5 = 20 <= 0 and var_798_2 or var_798_2 * (utf8.len(var_798_3) / 20)

				if (20 <= 0 and var_798_2 or var_798_2 * (utf8.len(var_798_3) / 20)) > 0 and var_798_2 < var_798_5 then
					arg_795_1.talkMaxDuration = var_798_5

					if var_798_5 + var_798_1 > arg_795_1.duration_ then
						arg_795_1.duration_ = var_798_5 + var_798_1
					end
				end

				arg_795_1.text_.text = var_798_3
				arg_795_1.typewritter.percent = 0

				arg_795_1.typewritter:SetDirty()
				arg_795_1:ShowNextGo(false)
				arg_795_1:RecordContent(arg_795_1.text_.text)
			end

			local var_798_6 = math.max(var_798_2, arg_795_1.talkMaxDuration)

			if var_798_1 <= arg_795_1.time_ and arg_795_1.time_ < var_798_1 + var_798_6 then
				arg_795_1.typewritter.percent = (arg_795_1.time_ - var_798_1) / var_798_6

				arg_795_1.typewritter:SetDirty()
			end

			if arg_795_1.time_ >= var_798_1 + var_798_6 and arg_795_1.time_ < var_798_1 + var_798_6 + arg_798_0 then
				arg_795_1.typewritter.percent = 1

				arg_795_1.typewritter:SetDirty()
				arg_795_1:ShowNextGo(true)
			end
		end

		arg_795_1.nodeConfigList_ = {}

		arg_795_1:InitPlayNodeList()
	end,
	Play1101905196 = function(arg_799_0, arg_799_1)
		arg_799_1.time_ = 0
		arg_799_1.frameCnt_ = 0
		arg_799_1.state_ = "playing"
		arg_799_1.curTalkId_ = 1101905196
		arg_799_1.duration_ = 3.9

		local var_799_0 = {
			zh = 2.7,
			ja = 3.9
		}
		local var_799_1 = manager.audio:GetLocalizationFlag()

		if var_799_0[var_799_1] ~= nil then
			arg_799_1.duration_ = var_799_0[var_799_1]
		end

		SetActive(arg_799_1.tipsGo_, false)

		function arg_799_1.onSingleLineFinish_()
			arg_799_1.onSingleLineUpdate_ = nil
			arg_799_1.onSingleLineFinish_ = nil
			arg_799_1.state_ = "waiting"
		end

		function arg_799_1.playNext_(arg_801_0)
			if arg_801_0 == 1 then
				arg_799_0:Play1101905197(arg_799_1)
			end
		end

		function arg_799_1.onSingleLineUpdate_(arg_802_0)
			if 0 < arg_799_1.time_ and arg_799_1.time_ <= 0 + arg_802_0 and not isNil(arg_799_1.actors_["1029ui_story"]) and arg_799_1.var_.characterEffect1029ui_story == nil then
				arg_799_1.var_.characterEffect1029ui_story = arg_799_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_802_0 = 0.200000002980232

			if 0 <= arg_799_1.time_ and arg_799_1.time_ < 0 + var_802_0 and not isNil(arg_799_1.actors_["1029ui_story"]) then
				if arg_799_1.var_.characterEffect1029ui_story and not isNil(arg_799_1.actors_["1029ui_story"]) then
					arg_799_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_799_1.time_ >= 0 + var_802_0 and arg_799_1.time_ < 0 + var_802_0 + arg_802_0 and not isNil(arg_799_1.actors_["1029ui_story"]) and arg_799_1.var_.characterEffect1029ui_story then
				arg_799_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_802_2 = 0
			local var_802_3 = 0.075

			if 0 < arg_799_1.time_ and arg_799_1.time_ <= var_802_2 + arg_802_0 then
				arg_799_1.talkMaxDuration = 0
				arg_799_1.dialogCg_.alpha = 1

				arg_799_1.dialog_:SetActive(true)
				SetActive(arg_799_1.leftNameGo_, true)

				arg_799_1.leftNameTxt_.text = arg_799_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_799_1.leftNameTxt_.transform)

				arg_799_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_799_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_799_1:RecordName(arg_799_1.leftNameTxt_.text)
				SetActive(arg_799_1.iconTrs_.gameObject, false)
				arg_799_1.callingController_:SetSelectedState("normal")

				local var_802_4 = arg_799_1:GetWordFromCfg(1101905196)
				local var_802_5 = arg_799_1:FormatText(var_802_4.content)

				arg_799_1.text_.text = var_802_5

				LuaForUtil.ClearLinePrefixSymbol(arg_799_1.text_)

				local var_802_7 = 14 <= 0 and var_802_3 or var_802_3 * (utf8.len(var_802_5) / 14)

				if (14 <= 0 and var_802_3 or var_802_3 * (utf8.len(var_802_5) / 14)) > 0 and var_802_3 < var_802_7 then
					arg_799_1.talkMaxDuration = var_802_7

					if var_802_7 + var_802_2 > arg_799_1.duration_ then
						arg_799_1.duration_ = var_802_7 + var_802_2
					end
				end

				arg_799_1.text_.text = var_802_5
				arg_799_1.typewritter.percent = 0

				arg_799_1.typewritter:SetDirty()
				arg_799_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905196", "story_v_side_new_1101905.awb") ~= 0 then
					local var_802_8 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905196", "story_v_side_new_1101905.awb") / 1000

					if var_802_8 + var_802_2 > arg_799_1.duration_ then
						arg_799_1.duration_ = var_802_8 + var_802_2
					end

					if var_802_4.prefab_name ~= "" and arg_799_1.actors_[var_802_4.prefab_name] ~= nil then
						local var_802_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_799_1.actors_[var_802_4.prefab_name].transform, "story_v_side_new_1101905", "1101905196", "story_v_side_new_1101905.awb")

						arg_799_1:RecordAudio("1101905196", var_802_9)
						arg_799_1:RecordAudio("1101905196", var_802_9)
					else
						arg_799_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905196", "story_v_side_new_1101905.awb")
					end

					arg_799_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905196", "story_v_side_new_1101905.awb")
				end

				arg_799_1:RecordContent(arg_799_1.text_.text)
			end

			local var_802_10 = math.max(var_802_3, arg_799_1.talkMaxDuration)

			if var_802_2 <= arg_799_1.time_ and arg_799_1.time_ < var_802_2 + var_802_10 then
				arg_799_1.typewritter.percent = (arg_799_1.time_ - var_802_2) / var_802_10

				arg_799_1.typewritter:SetDirty()
			end

			if arg_799_1.time_ >= var_802_2 + var_802_10 and arg_799_1.time_ < var_802_2 + var_802_10 + arg_802_0 then
				arg_799_1.typewritter.percent = 1

				arg_799_1.typewritter:SetDirty()
				arg_799_1:ShowNextGo(true)
			end
		end

		arg_799_1.nodeConfigList_ = {}

		arg_799_1:InitPlayNodeList()
	end,
	Play1101905197 = function(arg_803_0, arg_803_1)
		arg_803_1.time_ = 0
		arg_803_1.frameCnt_ = 0
		arg_803_1.state_ = "playing"
		arg_803_1.curTalkId_ = 1101905197
		arg_803_1.duration_ = 5.1

		local var_803_0 = {
			zh = 3.533,
			ja = 5.1
		}
		local var_803_1 = manager.audio:GetLocalizationFlag()

		if var_803_0[var_803_1] ~= nil then
			arg_803_1.duration_ = var_803_0[var_803_1]
		end

		SetActive(arg_803_1.tipsGo_, false)

		function arg_803_1.onSingleLineFinish_()
			arg_803_1.onSingleLineUpdate_ = nil
			arg_803_1.onSingleLineFinish_ = nil
			arg_803_1.state_ = "waiting"
		end

		function arg_803_1.playNext_(arg_805_0)
			if arg_805_0 == 1 then
				arg_803_0:Play1101905198(arg_803_1)
			end
		end

		function arg_803_1.onSingleLineUpdate_(arg_806_0)
			if 0 < arg_803_1.time_ and arg_803_1.time_ <= 0 + arg_806_0 then
				arg_803_1.var_.moveOldPos1019ui_story = arg_803_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_806_0 = 0.001

			if 0 <= arg_803_1.time_ and arg_803_1.time_ < 0 + var_806_0 then
				arg_803_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_803_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_803_1.time_ - 0) / var_806_0)
				arg_803_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_803_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_803_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_803_1.actors_["1019ui_story"].transform.position).z)
				arg_803_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_803_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_803_1.actors_["1019ui_story"].transform.localEulerAngles = arg_803_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_803_1.time_ >= 0 + var_806_0 and arg_803_1.time_ < 0 + var_806_0 + arg_806_0 then
				arg_803_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				arg_803_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_803_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_803_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_803_1.actors_["1019ui_story"].transform.position).z)
				arg_803_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_803_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_803_1.actors_["1019ui_story"].transform.localEulerAngles = arg_803_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_806_1 = arg_803_1.actors_["1019ui_story"]

			if 0 < arg_803_1.time_ and arg_803_1.time_ <= 0 + arg_806_0 and not isNil(var_806_1) and arg_803_1.var_.characterEffect1019ui_story == nil then
				arg_803_1.var_.characterEffect1019ui_story = var_806_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_806_2 = 0.200000002980232

			if 0 <= arg_803_1.time_ and arg_803_1.time_ < 0 + var_806_2 and not isNil(var_806_1) then
				if arg_803_1.var_.characterEffect1019ui_story and not isNil(var_806_1) then
					arg_803_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_803_1.time_ >= 0 + var_806_2 and arg_803_1.time_ < 0 + var_806_2 + arg_806_0 and not isNil(var_806_1) and arg_803_1.var_.characterEffect1019ui_story then
				arg_803_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_803_1.time_ and arg_803_1.time_ <= 0 + arg_806_0 then
				arg_803_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			if 0 < arg_803_1.time_ and arg_803_1.time_ <= 0 + arg_806_0 then
				arg_803_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_806_4 = arg_803_1.actors_["1029ui_story"]

			if 0 < arg_803_1.time_ and arg_803_1.time_ <= 0 + arg_806_0 and not isNil(var_806_4) and arg_803_1.var_.characterEffect1029ui_story == nil then
				arg_803_1.var_.characterEffect1029ui_story = var_806_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_806_5 = 0.200000002980232

			if 0 <= arg_803_1.time_ and arg_803_1.time_ < 0 + var_806_5 and not isNil(var_806_4) then
				if arg_803_1.var_.characterEffect1029ui_story and not isNil(var_806_4) then
					arg_803_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_803_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_803_1.time_ - 0) / var_806_5)
				end
			end

			if arg_803_1.time_ >= 0 + var_806_5 and arg_803_1.time_ < 0 + var_806_5 + arg_806_0 and not isNil(var_806_4) and arg_803_1.var_.characterEffect1029ui_story then
				arg_803_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_803_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_806_6 = 0
			local var_806_7 = 0.4

			if 0 < arg_803_1.time_ and arg_803_1.time_ <= var_806_6 + arg_806_0 then
				arg_803_1.talkMaxDuration = 0
				arg_803_1.dialogCg_.alpha = 1

				arg_803_1.dialog_:SetActive(true)
				SetActive(arg_803_1.leftNameGo_, true)

				arg_803_1.leftNameTxt_.text = arg_803_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_803_1.leftNameTxt_.transform)

				arg_803_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_803_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_803_1:RecordName(arg_803_1.leftNameTxt_.text)
				SetActive(arg_803_1.iconTrs_.gameObject, false)
				arg_803_1.callingController_:SetSelectedState("normal")

				local var_806_8 = arg_803_1:GetWordFromCfg(1101905197)
				local var_806_9 = arg_803_1:FormatText(var_806_8.content)

				arg_803_1.text_.text = var_806_9

				LuaForUtil.ClearLinePrefixSymbol(arg_803_1.text_)

				local var_806_11 = 17 <= 0 and var_806_7 or var_806_7 * (utf8.len(var_806_9) / 17)

				if (17 <= 0 and var_806_7 or var_806_7 * (utf8.len(var_806_9) / 17)) > 0 and var_806_7 < var_806_11 then
					arg_803_1.talkMaxDuration = var_806_11

					if var_806_11 + var_806_6 > arg_803_1.duration_ then
						arg_803_1.duration_ = var_806_11 + var_806_6
					end
				end

				arg_803_1.text_.text = var_806_9
				arg_803_1.typewritter.percent = 0

				arg_803_1.typewritter:SetDirty()
				arg_803_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905197", "story_v_side_new_1101905.awb") ~= 0 then
					local var_806_12 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905197", "story_v_side_new_1101905.awb") / 1000

					if var_806_12 + var_806_6 > arg_803_1.duration_ then
						arg_803_1.duration_ = var_806_12 + var_806_6
					end

					if var_806_8.prefab_name ~= "" and arg_803_1.actors_[var_806_8.prefab_name] ~= nil then
						local var_806_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_803_1.actors_[var_806_8.prefab_name].transform, "story_v_side_new_1101905", "1101905197", "story_v_side_new_1101905.awb")

						arg_803_1:RecordAudio("1101905197", var_806_13)
						arg_803_1:RecordAudio("1101905197", var_806_13)
					else
						arg_803_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905197", "story_v_side_new_1101905.awb")
					end

					arg_803_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905197", "story_v_side_new_1101905.awb")
				end

				arg_803_1:RecordContent(arg_803_1.text_.text)
			end

			local var_806_14 = math.max(var_806_7, arg_803_1.talkMaxDuration)

			if var_806_6 <= arg_803_1.time_ and arg_803_1.time_ < var_806_6 + var_806_14 then
				arg_803_1.typewritter.percent = (arg_803_1.time_ - var_806_6) / var_806_14

				arg_803_1.typewritter:SetDirty()
			end

			if arg_803_1.time_ >= var_806_6 + var_806_14 and arg_803_1.time_ < var_806_6 + var_806_14 + arg_806_0 then
				arg_803_1.typewritter.percent = 1

				arg_803_1.typewritter:SetDirty()
				arg_803_1:ShowNextGo(true)
			end
		end

		arg_803_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_803_1:InitPlayNodeList()
	end,
	Play1101905198 = function(arg_807_0, arg_807_1)
		arg_807_1.time_ = 0
		arg_807_1.frameCnt_ = 0
		arg_807_1.state_ = "playing"
		arg_807_1.curTalkId_ = 1101905198
		arg_807_1.duration_ = 5

		SetActive(arg_807_1.tipsGo_, false)

		function arg_807_1.onSingleLineFinish_()
			arg_807_1.onSingleLineUpdate_ = nil
			arg_807_1.onSingleLineFinish_ = nil
			arg_807_1.state_ = "waiting"
		end

		function arg_807_1.playNext_(arg_809_0)
			if arg_809_0 == 1 then
				arg_807_0:Play1101905199(arg_807_1)
			end
		end

		function arg_807_1.onSingleLineUpdate_(arg_810_0)
			if 0 < arg_807_1.time_ and arg_807_1.time_ <= 0 + arg_810_0 and not isNil(arg_807_1.actors_["1019ui_story"]) and arg_807_1.var_.characterEffect1019ui_story == nil then
				arg_807_1.var_.characterEffect1019ui_story = arg_807_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_810_0 = 0.200000002980232

			if 0 <= arg_807_1.time_ and arg_807_1.time_ < 0 + var_810_0 and not isNil(arg_807_1.actors_["1019ui_story"]) then
				if arg_807_1.var_.characterEffect1019ui_story and not isNil(arg_807_1.actors_["1019ui_story"]) then
					arg_807_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_807_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_807_1.time_ - 0) / var_810_0)
				end
			end

			if arg_807_1.time_ >= 0 + var_810_0 and arg_807_1.time_ < 0 + var_810_0 + arg_810_0 and not isNil(arg_807_1.actors_["1019ui_story"]) and arg_807_1.var_.characterEffect1019ui_story then
				arg_807_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_807_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_810_1 = 0
			local var_810_2 = 0.225

			if 0 < arg_807_1.time_ and arg_807_1.time_ <= var_810_1 + arg_810_0 then
				arg_807_1.talkMaxDuration = 0
				arg_807_1.dialogCg_.alpha = 1

				arg_807_1.dialog_:SetActive(true)
				SetActive(arg_807_1.leftNameGo_, false)

				arg_807_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_807_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_807_1:RecordName(arg_807_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_807_1.iconTrs_.gameObject, false)
				arg_807_1.callingController_:SetSelectedState("normal")

				local var_810_3 = arg_807_1:FormatText(arg_807_1:GetWordFromCfg(1101905198).content)

				arg_807_1.text_.text = var_810_3

				LuaForUtil.ClearLinePrefixSymbol(arg_807_1.text_)

				local var_810_5 = 23 <= 0 and var_810_2 or var_810_2 * (utf8.len(var_810_3) / 23)

				if (23 <= 0 and var_810_2 or var_810_2 * (utf8.len(var_810_3) / 23)) > 0 and var_810_2 < var_810_5 then
					arg_807_1.talkMaxDuration = var_810_5

					if var_810_5 + var_810_1 > arg_807_1.duration_ then
						arg_807_1.duration_ = var_810_5 + var_810_1
					end
				end

				arg_807_1.text_.text = var_810_3
				arg_807_1.typewritter.percent = 0

				arg_807_1.typewritter:SetDirty()
				arg_807_1:ShowNextGo(false)
				arg_807_1:RecordContent(arg_807_1.text_.text)
			end

			local var_810_6 = math.max(var_810_2, arg_807_1.talkMaxDuration)

			if var_810_1 <= arg_807_1.time_ and arg_807_1.time_ < var_810_1 + var_810_6 then
				arg_807_1.typewritter.percent = (arg_807_1.time_ - var_810_1) / var_810_6

				arg_807_1.typewritter:SetDirty()
			end

			if arg_807_1.time_ >= var_810_1 + var_810_6 and arg_807_1.time_ < var_810_1 + var_810_6 + arg_810_0 then
				arg_807_1.typewritter.percent = 1

				arg_807_1.typewritter:SetDirty()
				arg_807_1:ShowNextGo(true)
			end
		end

		arg_807_1.nodeConfigList_ = {}

		arg_807_1:InitPlayNodeList()
	end,
	Play1101905199 = function(arg_811_0, arg_811_1)
		arg_811_1.time_ = 0
		arg_811_1.frameCnt_ = 0
		arg_811_1.state_ = "playing"
		arg_811_1.curTalkId_ = 1101905199
		arg_811_1.duration_ = 5

		SetActive(arg_811_1.tipsGo_, false)

		function arg_811_1.onSingleLineFinish_()
			arg_811_1.onSingleLineUpdate_ = nil
			arg_811_1.onSingleLineFinish_ = nil
			arg_811_1.state_ = "waiting"
		end

		function arg_811_1.playNext_(arg_813_0)
			if arg_813_0 == 1 then
				arg_811_0:Play1101905200(arg_811_1)
			end
		end

		function arg_811_1.onSingleLineUpdate_(arg_814_0)
			local var_814_0 = 0.5

			if 0 < arg_811_1.time_ and arg_811_1.time_ <= 0 + arg_814_0 then
				arg_811_1.talkMaxDuration = 0
				arg_811_1.dialogCg_.alpha = 1

				arg_811_1.dialog_:SetActive(true)
				SetActive(arg_811_1.leftNameGo_, false)

				arg_811_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_811_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_811_1:RecordName(arg_811_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_811_1.iconTrs_.gameObject, false)
				arg_811_1.callingController_:SetSelectedState("normal")

				local var_814_1 = arg_811_1:FormatText(arg_811_1:GetWordFromCfg(1101905199).content)

				arg_811_1.text_.text = var_814_1

				LuaForUtil.ClearLinePrefixSymbol(arg_811_1.text_)

				local var_814_3 = 34 <= 0 and var_814_0 or var_814_0 * (utf8.len(var_814_1) / 34)

				if (34 <= 0 and var_814_0 or var_814_0 * (utf8.len(var_814_1) / 34)) > 0 and var_814_0 < var_814_3 then
					arg_811_1.talkMaxDuration = var_814_3

					if var_814_3 + 0 > arg_811_1.duration_ then
						arg_811_1.duration_ = var_814_3 + 0
					end
				end

				arg_811_1.text_.text = var_814_1
				arg_811_1.typewritter.percent = 0

				arg_811_1.typewritter:SetDirty()
				arg_811_1:ShowNextGo(false)
				arg_811_1:RecordContent(arg_811_1.text_.text)
			end

			local var_814_4 = math.max(var_814_0, arg_811_1.talkMaxDuration)

			if 0 <= arg_811_1.time_ and arg_811_1.time_ < 0 + var_814_4 then
				arg_811_1.typewritter.percent = (arg_811_1.time_ - 0) / var_814_4

				arg_811_1.typewritter:SetDirty()
			end

			if arg_811_1.time_ >= 0 + var_814_4 and arg_811_1.time_ < 0 + var_814_4 + arg_814_0 then
				arg_811_1.typewritter.percent = 1

				arg_811_1.typewritter:SetDirty()
				arg_811_1:ShowNextGo(true)
			end
		end

		arg_811_1.nodeConfigList_ = {}

		arg_811_1:InitPlayNodeList()
	end,
	Play1101905200 = function(arg_815_0, arg_815_1)
		arg_815_1.time_ = 0
		arg_815_1.frameCnt_ = 0
		arg_815_1.state_ = "playing"
		arg_815_1.curTalkId_ = 1101905200
		arg_815_1.duration_ = 6

		local var_815_0 = {
			zh = 5.966,
			ja = 6
		}
		local var_815_1 = manager.audio:GetLocalizationFlag()

		if var_815_0[var_815_1] ~= nil then
			arg_815_1.duration_ = var_815_0[var_815_1]
		end

		SetActive(arg_815_1.tipsGo_, false)

		function arg_815_1.onSingleLineFinish_()
			arg_815_1.onSingleLineUpdate_ = nil
			arg_815_1.onSingleLineFinish_ = nil
			arg_815_1.state_ = "waiting"
		end

		function arg_815_1.playNext_(arg_817_0)
			if arg_817_0 == 1 then
				arg_815_0:Play1101905201(arg_815_1)
			end
		end

		function arg_815_1.onSingleLineUpdate_(arg_818_0)
			if 0 < arg_815_1.time_ and arg_815_1.time_ <= 0 + arg_818_0 and not isNil(arg_815_1.actors_["1029ui_story"]) and arg_815_1.var_.characterEffect1029ui_story == nil then
				arg_815_1.var_.characterEffect1029ui_story = arg_815_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_818_0 = 0.200000002980232

			if 0 <= arg_815_1.time_ and arg_815_1.time_ < 0 + var_818_0 and not isNil(arg_815_1.actors_["1029ui_story"]) then
				if arg_815_1.var_.characterEffect1029ui_story and not isNil(arg_815_1.actors_["1029ui_story"]) then
					arg_815_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_815_1.time_ >= 0 + var_818_0 and arg_815_1.time_ < 0 + var_818_0 + arg_818_0 and not isNil(arg_815_1.actors_["1029ui_story"]) and arg_815_1.var_.characterEffect1029ui_story then
				arg_815_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_818_2 = 0
			local var_818_3 = 0.35

			if 0 < arg_815_1.time_ and arg_815_1.time_ <= var_818_2 + arg_818_0 then
				arg_815_1.talkMaxDuration = 0
				arg_815_1.dialogCg_.alpha = 1

				arg_815_1.dialog_:SetActive(true)
				SetActive(arg_815_1.leftNameGo_, true)

				arg_815_1.leftNameTxt_.text = arg_815_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_815_1.leftNameTxt_.transform)

				arg_815_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_815_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_815_1:RecordName(arg_815_1.leftNameTxt_.text)
				SetActive(arg_815_1.iconTrs_.gameObject, false)
				arg_815_1.callingController_:SetSelectedState("normal")

				local var_818_4 = arg_815_1:GetWordFromCfg(1101905200)
				local var_818_5 = arg_815_1:FormatText(var_818_4.content)

				arg_815_1.text_.text = var_818_5

				LuaForUtil.ClearLinePrefixSymbol(arg_815_1.text_)

				local var_818_7 = 21 <= 0 and var_818_3 or var_818_3 * (utf8.len(var_818_5) / 21)

				if (21 <= 0 and var_818_3 or var_818_3 * (utf8.len(var_818_5) / 21)) > 0 and var_818_3 < var_818_7 then
					arg_815_1.talkMaxDuration = var_818_7

					if var_818_7 + var_818_2 > arg_815_1.duration_ then
						arg_815_1.duration_ = var_818_7 + var_818_2
					end
				end

				arg_815_1.text_.text = var_818_5
				arg_815_1.typewritter.percent = 0

				arg_815_1.typewritter:SetDirty()
				arg_815_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905200", "story_v_side_new_1101905.awb") ~= 0 then
					local var_818_8 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905200", "story_v_side_new_1101905.awb") / 1000

					if var_818_8 + var_818_2 > arg_815_1.duration_ then
						arg_815_1.duration_ = var_818_8 + var_818_2
					end

					if var_818_4.prefab_name ~= "" and arg_815_1.actors_[var_818_4.prefab_name] ~= nil then
						local var_818_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_815_1.actors_[var_818_4.prefab_name].transform, "story_v_side_new_1101905", "1101905200", "story_v_side_new_1101905.awb")

						arg_815_1:RecordAudio("1101905200", var_818_9)
						arg_815_1:RecordAudio("1101905200", var_818_9)
					else
						arg_815_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905200", "story_v_side_new_1101905.awb")
					end

					arg_815_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905200", "story_v_side_new_1101905.awb")
				end

				arg_815_1:RecordContent(arg_815_1.text_.text)
			end

			local var_818_10 = math.max(var_818_3, arg_815_1.talkMaxDuration)

			if var_818_2 <= arg_815_1.time_ and arg_815_1.time_ < var_818_2 + var_818_10 then
				arg_815_1.typewritter.percent = (arg_815_1.time_ - var_818_2) / var_818_10

				arg_815_1.typewritter:SetDirty()
			end

			if arg_815_1.time_ >= var_818_2 + var_818_10 and arg_815_1.time_ < var_818_2 + var_818_10 + arg_818_0 then
				arg_815_1.typewritter.percent = 1

				arg_815_1.typewritter:SetDirty()
				arg_815_1:ShowNextGo(true)
			end
		end

		arg_815_1.nodeConfigList_ = {}

		arg_815_1:InitPlayNodeList()
	end,
	Play1101905201 = function(arg_819_0, arg_819_1)
		arg_819_1.time_ = 0
		arg_819_1.frameCnt_ = 0
		arg_819_1.state_ = "playing"
		arg_819_1.curTalkId_ = 1101905201
		arg_819_1.duration_ = 5

		SetActive(arg_819_1.tipsGo_, false)

		function arg_819_1.onSingleLineFinish_()
			arg_819_1.onSingleLineUpdate_ = nil
			arg_819_1.onSingleLineFinish_ = nil
			arg_819_1.state_ = "waiting"
		end

		function arg_819_1.playNext_(arg_821_0)
			if arg_821_0 == 1 then
				arg_819_0:Play1101905202(arg_819_1)
			end
		end

		function arg_819_1.onSingleLineUpdate_(arg_822_0)
			if 0 < arg_819_1.time_ and arg_819_1.time_ <= 0 + arg_822_0 then
				arg_819_1.var_.moveOldPos1019ui_story = arg_819_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_822_0 = 0.001

			if 0 <= arg_819_1.time_ and arg_819_1.time_ < 0 + var_822_0 then
				arg_819_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_819_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_819_1.time_ - 0) / var_822_0)
				arg_819_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_819_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_819_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_819_1.actors_["1019ui_story"].transform.position).z)
				arg_819_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_819_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_819_1.actors_["1019ui_story"].transform.localEulerAngles = arg_819_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_819_1.time_ >= 0 + var_822_0 and arg_819_1.time_ < 0 + var_822_0 + arg_822_0 then
				arg_819_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_819_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_819_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_819_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_819_1.actors_["1019ui_story"].transform.position).z)
				arg_819_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_819_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_819_1.actors_["1019ui_story"].transform.localEulerAngles = arg_819_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_822_1 = arg_819_1.actors_["1019ui_story"]

			if 0 < arg_819_1.time_ and arg_819_1.time_ <= 0 + arg_822_0 and not isNil(var_822_1) and arg_819_1.var_.characterEffect1019ui_story == nil then
				arg_819_1.var_.characterEffect1019ui_story = var_822_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_822_2 = 0.200000002980232

			if 0 <= arg_819_1.time_ and arg_819_1.time_ < 0 + var_822_2 and not isNil(var_822_1) then
				if arg_819_1.var_.characterEffect1019ui_story and not isNil(var_822_1) then
					arg_819_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_819_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_819_1.time_ - 0) / var_822_2)
				end
			end

			if arg_819_1.time_ >= 0 + var_822_2 and arg_819_1.time_ < 0 + var_822_2 + arg_822_0 and not isNil(var_822_1) and arg_819_1.var_.characterEffect1019ui_story then
				arg_819_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_819_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_822_3 = arg_819_1.actors_["1029ui_story"].transform

			if 0 < arg_819_1.time_ and arg_819_1.time_ <= 0 + arg_822_0 then
				arg_819_1.var_.moveOldPos1029ui_story = var_822_3.localPosition
			end

			local var_822_4 = 0.001

			if 0 <= arg_819_1.time_ and arg_819_1.time_ < 0 + var_822_4 then
				var_822_3.localPosition = Vector3.Lerp(arg_819_1.var_.moveOldPos1029ui_story, Vector3.New(0, 100, 0), (arg_819_1.time_ - 0) / var_822_4)
				var_822_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_822_3.position).x, (manager.ui.mainCamera.transform.position - var_822_3.position).y, (manager.ui.mainCamera.transform.position - var_822_3.position).z)
				var_822_3.localEulerAngles.z = 0
				var_822_3.localEulerAngles.x = 0
				var_822_3.localEulerAngles = var_822_3.localEulerAngles
			end

			if arg_819_1.time_ >= 0 + var_822_4 and arg_819_1.time_ < 0 + var_822_4 + arg_822_0 then
				var_822_3.localPosition = Vector3.New(0, 100, 0)
				var_822_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_822_3.position).x, (manager.ui.mainCamera.transform.position - var_822_3.position).y, (manager.ui.mainCamera.transform.position - var_822_3.position).z)
				var_822_3.localEulerAngles.z = 0
				var_822_3.localEulerAngles.x = 0
				var_822_3.localEulerAngles = var_822_3.localEulerAngles
			end

			local var_822_5 = arg_819_1.actors_["1029ui_story"]

			if 0 < arg_819_1.time_ and arg_819_1.time_ <= 0 + arg_822_0 and not isNil(var_822_5) and arg_819_1.var_.characterEffect1029ui_story == nil then
				arg_819_1.var_.characterEffect1029ui_story = var_822_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_822_6 = 0.200000002980232

			if 0 <= arg_819_1.time_ and arg_819_1.time_ < 0 + var_822_6 and not isNil(var_822_5) then
				if arg_819_1.var_.characterEffect1029ui_story and not isNil(var_822_5) then
					arg_819_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_819_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_819_1.time_ - 0) / var_822_6)
				end
			end

			if arg_819_1.time_ >= 0 + var_822_6 and arg_819_1.time_ < 0 + var_822_6 + arg_822_0 and not isNil(var_822_5) and arg_819_1.var_.characterEffect1029ui_story then
				arg_819_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_819_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_822_7 = 0
			local var_822_8 = 0.425

			if 0 < arg_819_1.time_ and arg_819_1.time_ <= var_822_7 + arg_822_0 then
				arg_819_1.talkMaxDuration = 0
				arg_819_1.dialogCg_.alpha = 1

				arg_819_1.dialog_:SetActive(true)
				SetActive(arg_819_1.leftNameGo_, true)

				arg_819_1.leftNameTxt_.text = arg_819_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_819_1.leftNameTxt_.transform)

				arg_819_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_819_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_819_1:RecordName(arg_819_1.leftNameTxt_.text)
				SetActive(arg_819_1.iconTrs_.gameObject, true)
				arg_819_1.iconController_:SetSelectedState("hero")

				arg_819_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_819_1.callingController_:SetSelectedState("normal")

				arg_819_1.keyicon_.color = Color.New(1, 1, 1)
				arg_819_1.icon_.color = Color.New(1, 1, 1)

				local var_822_9 = arg_819_1:FormatText(arg_819_1:GetWordFromCfg(1101905201).content)

				arg_819_1.text_.text = var_822_9

				LuaForUtil.ClearLinePrefixSymbol(arg_819_1.text_)

				local var_822_11 = 10 <= 0 and var_822_8 or var_822_8 * (utf8.len(var_822_9) / 10)

				if (10 <= 0 and var_822_8 or var_822_8 * (utf8.len(var_822_9) / 10)) > 0 and var_822_8 < var_822_11 then
					arg_819_1.talkMaxDuration = var_822_11

					if var_822_11 + var_822_7 > arg_819_1.duration_ then
						arg_819_1.duration_ = var_822_11 + var_822_7
					end
				end

				arg_819_1.text_.text = var_822_9
				arg_819_1.typewritter.percent = 0

				arg_819_1.typewritter:SetDirty()
				arg_819_1:ShowNextGo(false)
				arg_819_1:RecordContent(arg_819_1.text_.text)
			end

			local var_822_12 = math.max(var_822_8, arg_819_1.talkMaxDuration)

			if var_822_7 <= arg_819_1.time_ and arg_819_1.time_ < var_822_7 + var_822_12 then
				arg_819_1.typewritter.percent = (arg_819_1.time_ - var_822_7) / var_822_12

				arg_819_1.typewritter:SetDirty()
			end

			if arg_819_1.time_ >= var_822_7 + var_822_12 and arg_819_1.time_ < var_822_7 + var_822_12 + arg_822_0 then
				arg_819_1.typewritter.percent = 1

				arg_819_1.typewritter:SetDirty()
				arg_819_1:ShowNextGo(true)
			end
		end

		arg_819_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_819_1:InitPlayNodeList()
	end,
	Play1101905202 = function(arg_823_0, arg_823_1)
		arg_823_1.time_ = 0
		arg_823_1.frameCnt_ = 0
		arg_823_1.state_ = "playing"
		arg_823_1.curTalkId_ = 1101905202
		arg_823_1.duration_ = 5

		SetActive(arg_823_1.tipsGo_, false)

		function arg_823_1.onSingleLineFinish_()
			arg_823_1.onSingleLineUpdate_ = nil
			arg_823_1.onSingleLineFinish_ = nil
			arg_823_1.state_ = "waiting"
		end

		function arg_823_1.playNext_(arg_825_0)
			if arg_825_0 == 1 then
				arg_823_0:Play1101905203(arg_823_1)
			end
		end

		function arg_823_1.onSingleLineUpdate_(arg_826_0)
			local var_826_0 = 0.575

			if 0 < arg_823_1.time_ and arg_823_1.time_ <= 0 + arg_826_0 then
				arg_823_1.talkMaxDuration = 0
				arg_823_1.dialogCg_.alpha = 1

				arg_823_1.dialog_:SetActive(true)
				SetActive(arg_823_1.leftNameGo_, false)

				arg_823_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_823_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_823_1:RecordName(arg_823_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_823_1.iconTrs_.gameObject, false)
				arg_823_1.callingController_:SetSelectedState("normal")

				local var_826_1 = arg_823_1:FormatText(arg_823_1:GetWordFromCfg(1101905202).content)

				arg_823_1.text_.text = var_826_1

				LuaForUtil.ClearLinePrefixSymbol(arg_823_1.text_)

				local var_826_3 = 13 <= 0 and var_826_0 or var_826_0 * (utf8.len(var_826_1) / 13)

				if (13 <= 0 and var_826_0 or var_826_0 * (utf8.len(var_826_1) / 13)) > 0 and var_826_0 < var_826_3 then
					arg_823_1.talkMaxDuration = var_826_3

					if var_826_3 + 0 > arg_823_1.duration_ then
						arg_823_1.duration_ = var_826_3 + 0
					end
				end

				arg_823_1.text_.text = var_826_1
				arg_823_1.typewritter.percent = 0

				arg_823_1.typewritter:SetDirty()
				arg_823_1:ShowNextGo(false)
				arg_823_1:RecordContent(arg_823_1.text_.text)
			end

			local var_826_4 = math.max(var_826_0, arg_823_1.talkMaxDuration)

			if 0 <= arg_823_1.time_ and arg_823_1.time_ < 0 + var_826_4 then
				arg_823_1.typewritter.percent = (arg_823_1.time_ - 0) / var_826_4

				arg_823_1.typewritter:SetDirty()
			end

			if arg_823_1.time_ >= 0 + var_826_4 and arg_823_1.time_ < 0 + var_826_4 + arg_826_0 then
				arg_823_1.typewritter.percent = 1

				arg_823_1.typewritter:SetDirty()
				arg_823_1:ShowNextGo(true)
			end
		end

		arg_823_1.nodeConfigList_ = {}

		arg_823_1:InitPlayNodeList()
	end,
	Play1101905203 = function(arg_827_0, arg_827_1)
		arg_827_1.time_ = 0
		arg_827_1.frameCnt_ = 0
		arg_827_1.state_ = "playing"
		arg_827_1.curTalkId_ = 1101905203
		arg_827_1.duration_ = 2

		SetActive(arg_827_1.tipsGo_, false)

		function arg_827_1.onSingleLineFinish_()
			arg_827_1.onSingleLineUpdate_ = nil
			arg_827_1.onSingleLineFinish_ = nil
			arg_827_1.state_ = "waiting"
		end

		function arg_827_1.playNext_(arg_829_0)
			if arg_829_0 == 1 then
				arg_827_0:Play1101905204(arg_827_1)
			end
		end

		function arg_827_1.onSingleLineUpdate_(arg_830_0)
			if 0 < arg_827_1.time_ and arg_827_1.time_ <= 0 + arg_830_0 and not isNil(arg_827_1.actors_["1019ui_story"]) and arg_827_1.var_.characterEffect1019ui_story == nil then
				arg_827_1.var_.characterEffect1019ui_story = arg_827_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_830_0 = 0.200000002980232

			if 0 <= arg_827_1.time_ and arg_827_1.time_ < 0 + var_830_0 and not isNil(arg_827_1.actors_["1019ui_story"]) then
				if arg_827_1.var_.characterEffect1019ui_story and not isNil(arg_827_1.actors_["1019ui_story"]) then
					arg_827_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_827_1.time_ >= 0 + var_830_0 and arg_827_1.time_ < 0 + var_830_0 + arg_830_0 and not isNil(arg_827_1.actors_["1019ui_story"]) and arg_827_1.var_.characterEffect1019ui_story then
				arg_827_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_827_1.time_ and arg_827_1.time_ <= 0 + arg_830_0 then
				arg_827_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_830_2 = 0
			local var_830_3 = 0.85

			if 0 < arg_827_1.time_ and arg_827_1.time_ <= var_830_2 + arg_830_0 then
				arg_827_1.talkMaxDuration = 0
				arg_827_1.dialogCg_.alpha = 1

				arg_827_1.dialog_:SetActive(true)
				SetActive(arg_827_1.leftNameGo_, true)

				arg_827_1.leftNameTxt_.text = arg_827_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_827_1.leftNameTxt_.transform)

				arg_827_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_827_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_827_1:RecordName(arg_827_1.leftNameTxt_.text)
				SetActive(arg_827_1.iconTrs_.gameObject, false)
				arg_827_1.callingController_:SetSelectedState("normal")

				local var_830_4 = arg_827_1:GetWordFromCfg(1101905203)
				local var_830_5 = arg_827_1:FormatText(var_830_4.content)

				arg_827_1.text_.text = var_830_5

				LuaForUtil.ClearLinePrefixSymbol(arg_827_1.text_)

				local var_830_7 = 5 <= 0 and var_830_3 or var_830_3 * (utf8.len(var_830_5) / 5)

				if (5 <= 0 and var_830_3 or var_830_3 * (utf8.len(var_830_5) / 5)) > 0 and var_830_3 < var_830_7 then
					arg_827_1.talkMaxDuration = var_830_7

					if var_830_7 + var_830_2 > arg_827_1.duration_ then
						arg_827_1.duration_ = var_830_7 + var_830_2
					end
				end

				arg_827_1.text_.text = var_830_5
				arg_827_1.typewritter.percent = 0

				arg_827_1.typewritter:SetDirty()
				arg_827_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905203", "story_v_side_new_1101905.awb") ~= 0 then
					local var_830_8 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905203", "story_v_side_new_1101905.awb") / 1000

					if var_830_8 + var_830_2 > arg_827_1.duration_ then
						arg_827_1.duration_ = var_830_8 + var_830_2
					end

					if var_830_4.prefab_name ~= "" and arg_827_1.actors_[var_830_4.prefab_name] ~= nil then
						local var_830_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_827_1.actors_[var_830_4.prefab_name].transform, "story_v_side_new_1101905", "1101905203", "story_v_side_new_1101905.awb")

						arg_827_1:RecordAudio("1101905203", var_830_9)
						arg_827_1:RecordAudio("1101905203", var_830_9)
					else
						arg_827_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905203", "story_v_side_new_1101905.awb")
					end

					arg_827_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905203", "story_v_side_new_1101905.awb")
				end

				arg_827_1:RecordContent(arg_827_1.text_.text)
			end

			local var_830_10 = math.max(var_830_3, arg_827_1.talkMaxDuration)

			if var_830_2 <= arg_827_1.time_ and arg_827_1.time_ < var_830_2 + var_830_10 then
				arg_827_1.typewritter.percent = (arg_827_1.time_ - var_830_2) / var_830_10

				arg_827_1.typewritter:SetDirty()
			end

			if arg_827_1.time_ >= var_830_2 + var_830_10 and arg_827_1.time_ < var_830_2 + var_830_10 + arg_830_0 then
				arg_827_1.typewritter.percent = 1

				arg_827_1.typewritter:SetDirty()
				arg_827_1:ShowNextGo(true)
			end
		end

		arg_827_1.nodeConfigList_ = {}

		arg_827_1:InitPlayNodeList()
	end,
	Play1101905204 = function(arg_831_0, arg_831_1)
		arg_831_1.time_ = 0
		arg_831_1.frameCnt_ = 0
		arg_831_1.state_ = "playing"
		arg_831_1.curTalkId_ = 1101905204
		arg_831_1.duration_ = 5

		SetActive(arg_831_1.tipsGo_, false)

		function arg_831_1.onSingleLineFinish_()
			arg_831_1.onSingleLineUpdate_ = nil
			arg_831_1.onSingleLineFinish_ = nil
			arg_831_1.state_ = "waiting"
			arg_831_1.auto_ = false
		end

		function arg_831_1.playNext_(arg_833_0)
			arg_831_1.onStoryFinished_()
		end

		function arg_831_1.onSingleLineUpdate_(arg_834_0)
			if 0 < arg_831_1.time_ and arg_831_1.time_ <= 0 + arg_834_0 and not isNil(arg_831_1.actors_["1019ui_story"]) and arg_831_1.var_.characterEffect1019ui_story == nil then
				arg_831_1.var_.characterEffect1019ui_story = arg_831_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_834_0 = 0.200000002980232

			if 0 <= arg_831_1.time_ and arg_831_1.time_ < 0 + var_834_0 and not isNil(arg_831_1.actors_["1019ui_story"]) then
				if arg_831_1.var_.characterEffect1019ui_story and not isNil(arg_831_1.actors_["1019ui_story"]) then
					arg_831_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_831_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_831_1.time_ - 0) / var_834_0)
				end
			end

			if arg_831_1.time_ >= 0 + var_834_0 and arg_831_1.time_ < 0 + var_834_0 + arg_834_0 and not isNil(arg_831_1.actors_["1019ui_story"]) and arg_831_1.var_.characterEffect1019ui_story then
				arg_831_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_831_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_834_1 = 0
			local var_834_2 = 0.525

			if 0 < arg_831_1.time_ and arg_831_1.time_ <= var_834_1 + arg_834_0 then
				arg_831_1.talkMaxDuration = 0
				arg_831_1.dialogCg_.alpha = 1

				arg_831_1.dialog_:SetActive(true)
				SetActive(arg_831_1.leftNameGo_, false)

				arg_831_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_831_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_831_1:RecordName(arg_831_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_831_1.iconTrs_.gameObject, false)
				arg_831_1.callingController_:SetSelectedState("normal")

				local var_834_3 = arg_831_1:FormatText(arg_831_1:GetWordFromCfg(1101905204).content)

				arg_831_1.text_.text = var_834_3

				LuaForUtil.ClearLinePrefixSymbol(arg_831_1.text_)

				local var_834_5 = 35 <= 0 and var_834_2 or var_834_2 * (utf8.len(var_834_3) / 35)

				if (35 <= 0 and var_834_2 or var_834_2 * (utf8.len(var_834_3) / 35)) > 0 and var_834_2 < var_834_5 then
					arg_831_1.talkMaxDuration = var_834_5

					if var_834_5 + var_834_1 > arg_831_1.duration_ then
						arg_831_1.duration_ = var_834_5 + var_834_1
					end
				end

				arg_831_1.text_.text = var_834_3
				arg_831_1.typewritter.percent = 0

				arg_831_1.typewritter:SetDirty()
				arg_831_1:ShowNextGo(false)
				arg_831_1:RecordContent(arg_831_1.text_.text)
			end

			local var_834_6 = math.max(var_834_2, arg_831_1.talkMaxDuration)

			if var_834_1 <= arg_831_1.time_ and arg_831_1.time_ < var_834_1 + var_834_6 then
				arg_831_1.typewritter.percent = (arg_831_1.time_ - var_834_1) / var_834_6

				arg_831_1.typewritter:SetDirty()
			end

			if arg_831_1.time_ >= var_834_1 + var_834_6 and arg_831_1.time_ < var_834_1 + var_834_6 + arg_834_0 then
				arg_831_1.typewritter.percent = 1

				arg_831_1.typewritter:SetDirty()
				arg_831_1:ShowNextGo(true)
			end
		end

		arg_831_1.nodeConfigList_ = {}

		arg_831_1:InitPlayNodeList()
	end,
	Play1101905123 = function(arg_835_0, arg_835_1)
		arg_835_1.time_ = 0
		arg_835_1.frameCnt_ = 0
		arg_835_1.state_ = "playing"
		arg_835_1.curTalkId_ = 1101905123
		arg_835_1.duration_ = 9

		local var_835_0 = {
			zh = 7.633,
			ja = 9
		}
		local var_835_1 = manager.audio:GetLocalizationFlag()

		if var_835_0[var_835_1] ~= nil then
			arg_835_1.duration_ = var_835_0[var_835_1]
		end

		SetActive(arg_835_1.tipsGo_, false)

		function arg_835_1.onSingleLineFinish_()
			arg_835_1.onSingleLineUpdate_ = nil
			arg_835_1.onSingleLineFinish_ = nil
			arg_835_1.state_ = "waiting"
		end

		function arg_835_1.playNext_(arg_837_0)
			if arg_837_0 == 1 then
				arg_835_0:Play1101905124(arg_835_1)
			end
		end

		function arg_835_1.onSingleLineUpdate_(arg_838_0)
			local var_838_0 = 0.75

			if 0 < arg_835_1.time_ and arg_835_1.time_ <= 0 + arg_838_0 then
				arg_835_1.talkMaxDuration = 0
				arg_835_1.dialogCg_.alpha = 1

				arg_835_1.dialog_:SetActive(true)
				SetActive(arg_835_1.leftNameGo_, true)

				arg_835_1.leftNameTxt_.text = arg_835_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_835_1.leftNameTxt_.transform)

				arg_835_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_835_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_835_1:RecordName(arg_835_1.leftNameTxt_.text)
				SetActive(arg_835_1.iconTrs_.gameObject, false)
				arg_835_1.callingController_:SetSelectedState("normal")

				local var_838_1 = arg_835_1:GetWordFromCfg(1101905123)
				local var_838_2 = arg_835_1:FormatText(var_838_1.content)

				arg_835_1.text_.text = var_838_2

				LuaForUtil.ClearLinePrefixSymbol(arg_835_1.text_)

				local var_838_4 = 33 <= 0 and var_838_0 or var_838_0 * (utf8.len(var_838_2) / 33)

				if (33 <= 0 and var_838_0 or var_838_0 * (utf8.len(var_838_2) / 33)) > 0 and var_838_0 < var_838_4 then
					arg_835_1.talkMaxDuration = var_838_4

					if var_838_4 + 0 > arg_835_1.duration_ then
						arg_835_1.duration_ = var_838_4 + 0
					end
				end

				arg_835_1.text_.text = var_838_2
				arg_835_1.typewritter.percent = 0

				arg_835_1.typewritter:SetDirty()
				arg_835_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905123", "story_v_side_new_1101905.awb") ~= 0 then
					local var_838_5 = manager.audio:GetVoiceLength("story_v_side_new_1101905", "1101905123", "story_v_side_new_1101905.awb") / 1000

					if var_838_5 + 0 > arg_835_1.duration_ then
						arg_835_1.duration_ = var_838_5 + 0
					end

					if var_838_1.prefab_name ~= "" and arg_835_1.actors_[var_838_1.prefab_name] ~= nil then
						local var_838_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_835_1.actors_[var_838_1.prefab_name].transform, "story_v_side_new_1101905", "1101905123", "story_v_side_new_1101905.awb")

						arg_835_1:RecordAudio("1101905123", var_838_6)
						arg_835_1:RecordAudio("1101905123", var_838_6)
					else
						arg_835_1:AudioAction("play", "voice", "story_v_side_new_1101905", "1101905123", "story_v_side_new_1101905.awb")
					end

					arg_835_1:RecordHistoryTalkVoice("story_v_side_new_1101905", "1101905123", "story_v_side_new_1101905.awb")
				end

				arg_835_1:RecordContent(arg_835_1.text_.text)
			end

			local var_838_7 = math.max(var_838_0, arg_835_1.talkMaxDuration)

			if 0 <= arg_835_1.time_ and arg_835_1.time_ < 0 + var_838_7 then
				arg_835_1.typewritter.percent = (arg_835_1.time_ - 0) / var_838_7

				arg_835_1.typewritter:SetDirty()
			end

			if arg_835_1.time_ >= 0 + var_838_7 and arg_835_1.time_ < 0 + var_838_7 + arg_838_0 then
				arg_835_1.typewritter.percent = 1

				arg_835_1.typewritter:SetDirty()
				arg_835_1:ShowNextGo(true)
			end
		end

		arg_835_1.nodeConfigList_ = {}

		arg_835_1:InitPlayNodeList()
	end,
	Play1101905076 = function(arg_839_0, arg_839_1)
		arg_839_1.time_ = 0
		arg_839_1.frameCnt_ = 0
		arg_839_1.state_ = "playing"
		arg_839_1.curTalkId_ = 1101905076
		arg_839_1.duration_ = 5

		SetActive(arg_839_1.tipsGo_, false)

		function arg_839_1.onSingleLineFinish_()
			arg_839_1.onSingleLineUpdate_ = nil
			arg_839_1.onSingleLineFinish_ = nil
			arg_839_1.state_ = "waiting"
		end

		function arg_839_1.playNext_(arg_841_0)
			if arg_841_0 == 1 then
				arg_839_0:Play1101905077(arg_839_1)
			end
		end

		function arg_839_1.onSingleLineUpdate_(arg_842_0)
			if 0 < arg_839_1.time_ and arg_839_1.time_ <= 0 + arg_842_0 and not isNil(arg_839_1.actors_["1019ui_story"]) and arg_839_1.var_.characterEffect1019ui_story == nil then
				arg_839_1.var_.characterEffect1019ui_story = arg_839_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_842_0 = 0.200000002980232

			if 0 <= arg_839_1.time_ and arg_839_1.time_ < 0 + var_842_0 and not isNil(arg_839_1.actors_["1019ui_story"]) then
				if arg_839_1.var_.characterEffect1019ui_story and not isNil(arg_839_1.actors_["1019ui_story"]) then
					arg_839_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_839_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_839_1.time_ - 0) / var_842_0)
				end
			end

			if arg_839_1.time_ >= 0 + var_842_0 and arg_839_1.time_ < 0 + var_842_0 + arg_842_0 and not isNil(arg_839_1.actors_["1019ui_story"]) and arg_839_1.var_.characterEffect1019ui_story then
				arg_839_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_839_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_842_1 = 0
			local var_842_2 = 0.225

			if 0 < arg_839_1.time_ and arg_839_1.time_ <= var_842_1 + arg_842_0 then
				arg_839_1.talkMaxDuration = 0
				arg_839_1.dialogCg_.alpha = 1

				arg_839_1.dialog_:SetActive(true)
				SetActive(arg_839_1.leftNameGo_, true)

				arg_839_1.leftNameTxt_.text = arg_839_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_839_1.leftNameTxt_.transform)

				arg_839_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_839_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_839_1:RecordName(arg_839_1.leftNameTxt_.text)
				SetActive(arg_839_1.iconTrs_.gameObject, true)
				arg_839_1.iconController_:SetSelectedState("hero")

				arg_839_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_839_1.callingController_:SetSelectedState("normal")

				arg_839_1.keyicon_.color = Color.New(1, 1, 1)
				arg_839_1.icon_.color = Color.New(1, 1, 1)

				local var_842_3 = arg_839_1:FormatText(arg_839_1:GetWordFromCfg(1101905076).content)

				arg_839_1.text_.text = var_842_3

				LuaForUtil.ClearLinePrefixSymbol(arg_839_1.text_)

				local var_842_5 = 33 <= 0 and var_842_2 or var_842_2 * (utf8.len(var_842_3) / 33)

				if (33 <= 0 and var_842_2 or var_842_2 * (utf8.len(var_842_3) / 33)) > 0 and var_842_2 < var_842_5 then
					arg_839_1.talkMaxDuration = var_842_5

					if var_842_5 + var_842_1 > arg_839_1.duration_ then
						arg_839_1.duration_ = var_842_5 + var_842_1
					end
				end

				arg_839_1.text_.text = var_842_3
				arg_839_1.typewritter.percent = 0

				arg_839_1.typewritter:SetDirty()
				arg_839_1:ShowNextGo(false)
				arg_839_1:RecordContent(arg_839_1.text_.text)
			end

			local var_842_6 = math.max(var_842_2, arg_839_1.talkMaxDuration)

			if var_842_1 <= arg_839_1.time_ and arg_839_1.time_ < var_842_1 + var_842_6 then
				arg_839_1.typewritter.percent = (arg_839_1.time_ - var_842_1) / var_842_6

				arg_839_1.typewritter:SetDirty()
			end

			if arg_839_1.time_ >= var_842_1 + var_842_6 and arg_839_1.time_ < var_842_1 + var_842_6 + arg_842_0 then
				arg_839_1.typewritter.percent = 1

				arg_839_1.typewritter:SetDirty()
				arg_839_1:ShowNextGo(true)
			end
		end

		arg_839_1.nodeConfigList_ = {}

		arg_839_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/D999",
		"TextureConfig/Background/ST01a",
		"TextureConfig/Background/A00",
		"TextureConfig/Background/S0004",
		"TextureConfig/Background/ST28",
		"TextureConfig/Background/ST02"
	},
	voices = {
		"story_v_side_new_1101905.awb"
	}
}
