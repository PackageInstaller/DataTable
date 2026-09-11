return {
	Play102604001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 102604001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play102604002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.B01c == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B01c")
				var_4_0.name = "B01c"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.B01c = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.B01c

				arg_1_1.bgs_.B01c.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B01c" then
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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

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
			local var_4_15 = 0.525

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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(102604001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 21 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 21)

				if (21 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 21)) > 0 and var_4_15 < var_4_19 then
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
	Play102604002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 102604002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play102604003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.075

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(102604002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 3 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 3)

				if (3 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 3)) > 0 and var_12_0 < var_12_3 then
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
	Play102604003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 102604003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play102604004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.925

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(102604003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 37 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 37)

				if (37 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 37)) > 0 and var_16_0 < var_16_3 then
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
	Play102604004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 102604004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play102604005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.875

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

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(102604004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 35 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 35)

				if (35 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 35)) > 0 and var_20_0 < var_20_3 then
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
	Play102604005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 102604005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play102604006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.35

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

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(102604005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 14 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 14)

				if (14 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 14)) > 0 and var_24_0 < var_24_3 then
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
	Play102604006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 102604006
		arg_25_1.duration_ = 7.7

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play102604007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				local var_28_0 = arg_25_1.bgs_.B01c:GetComponent("SpriteRenderer")

				if var_28_0 then
					arg_25_1.var_.alphaOldValueB01c = var_28_0.color.a
					arg_25_1.var_.alphaMatValueB01c = var_28_0
				end

				arg_25_1.var_.alphaOldValueB01c = 1
			end

			local var_28_1 = 1.5

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_1 then
				if arg_25_1.var_.alphaMatValueB01c then
					arg_25_1.var_.alphaMatValueB01c.color.a = Mathf.Lerp(arg_25_1.var_.alphaOldValueB01c, 0, (arg_25_1.time_ - 0) / var_28_1)
					arg_25_1.var_.alphaMatValueB01c.color = arg_25_1.var_.alphaMatValueB01c.color
				end
			end

			if arg_25_1.time_ >= 0 + var_28_1 and arg_25_1.time_ < 0 + var_28_1 + arg_28_0 and arg_25_1.var_.alphaMatValueB01c then
				arg_25_1.var_.alphaMatValueB01c.color.a = 0
				arg_25_1.var_.alphaMatValueB01c.color = arg_25_1.var_.alphaMatValueB01c.color
			end

			local var_28_2 = "ST13"

			if arg_25_1.bgs_.ST13 == nil then
				local var_28_3 = Object.Instantiate(arg_25_1.paintGo_)

				var_28_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_28_2)
				var_28_3.name = var_28_2
				var_28_3.transform.parent = arg_25_1.stage_.transform
				var_28_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.bgs_[var_28_2] = var_28_3
			end

			if 1.5 < arg_25_1.time_ and arg_25_1.time_ <= 1.5 + arg_28_0 then
				local var_28_4 = arg_25_1.bgs_.ST13:GetComponent("SpriteRenderer")

				if var_28_4 then
					arg_25_1.var_.alphaOldValueST13 = var_28_4.color.a
					arg_25_1.var_.alphaMatValueST13 = var_28_4
				end

				arg_25_1.var_.alphaOldValueST13 = 0
			end

			local var_28_5 = 1.5

			if 1.5 <= arg_25_1.time_ and arg_25_1.time_ < 1.5 + var_28_5 then
				if arg_25_1.var_.alphaMatValueST13 then
					arg_25_1.var_.alphaMatValueST13.color.a = Mathf.Lerp(arg_25_1.var_.alphaOldValueST13, 1, (arg_25_1.time_ - 1.5) / var_28_5)
					arg_25_1.var_.alphaMatValueST13.color = arg_25_1.var_.alphaMatValueST13.color
				end
			end

			if arg_25_1.time_ >= 1.5 + var_28_5 and arg_25_1.time_ < 1.5 + var_28_5 + arg_28_0 and arg_25_1.var_.alphaMatValueST13 then
				arg_25_1.var_.alphaMatValueST13.color.a = 1
				arg_25_1.var_.alphaMatValueST13.color = arg_25_1.var_.alphaMatValueST13.color
			end

			if 1.5 < arg_25_1.time_ and arg_25_1.time_ <= 1.5 + arg_28_0 then
				local var_28_6 = arg_25_1.bgs_.ST13

				arg_25_1.bgs_.ST13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_28_6.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_28_7 = var_28_6:GetComponent("SpriteRenderer")

				if var_28_7 and var_28_7.sprite then
					local var_28_8 = 2 * (var_28_6.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_28_6.transform.localScale = Vector3.New(var_28_8 / var_28_7.sprite.bounds.size.y < var_28_8 * manager.ui.mainCameraCom_.aspect / var_28_7.sprite.bounds.size.x and var_28_8 * manager.ui.mainCameraCom_.aspect / var_28_7.sprite.bounds.size.x or var_28_8 / var_28_7.sprite.bounds.size.y, var_28_8 / var_28_7.sprite.bounds.size.y < var_28_8 * manager.ui.mainCameraCom_.aspect / var_28_7.sprite.bounds.size.x and var_28_8 * manager.ui.mainCameraCom_.aspect / var_28_7.sprite.bounds.size.x or var_28_8 / var_28_7.sprite.bounds.size.y, 0)
				end

				for iter_28_0, iter_28_1 in pairs(arg_25_1.bgs_) do
					if iter_28_0 ~= "ST13" then
						iter_28_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_28_9 = 0

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_9 + arg_28_0 then
				arg_25_1.allBtn_.enabled = false
			end

			if arg_25_1.time_ >= var_28_9 + 2.7 and arg_25_1.time_ < var_28_9 + 2.7 + arg_28_0 then
				arg_25_1.allBtn_.enabled = true
			end

			if arg_25_1.frameCnt_ <= 1 then
				arg_25_1.dialog_:SetActive(false)
			end

			local var_28_10 = 2.7
			local var_28_11 = 0.3

			if 2.7 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0

				arg_25_1.dialog_:SetActive(true)

				arg_25_1.dialogCg_.alpha = 0

				local var_28_12 = LeanTween.value(arg_25_1.dialog_, 0, 1, 0.3)

				var_28_12:setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
					arg_25_1.dialogCg_.alpha = arg_29_0
				end))
				var_28_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_25_1.dialog_)
					var_28_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_25_1.duration_ = arg_25_1.duration_ + 0.3

				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_13 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(102604006).content)

				arg_25_1.text_.text = var_28_13

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_15 = 12 <= 0 and var_28_11 or var_28_11 * (utf8.len(var_28_13) / 12)

				if (12 <= 0 and var_28_11 or var_28_11 * (utf8.len(var_28_13) / 12)) > 0 and var_28_11 < var_28_15 then
					arg_25_1.talkMaxDuration = var_28_15
					var_28_10 = var_28_10 + 0.3

					if var_28_15 + var_28_10 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_15 + var_28_10
					end
				end

				arg_25_1.text_.text = var_28_13
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_16 = var_28_10 + 0.3
			local var_28_17 = math.max(var_28_11, arg_25_1.talkMaxDuration)

			if var_28_10 + 0.3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_16 + var_28_17 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_16) / var_28_17

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_16 + var_28_17 and arg_25_1.time_ < var_28_16 + var_28_17 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play102604007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 102604007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play102604008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0.875

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_1 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(102604007).content)

				arg_31_1.text_.text = var_34_1

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_3 = 35 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_1) / 35)

				if (35 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_1) / 35)) > 0 and var_34_0 < var_34_3 then
					arg_31_1.talkMaxDuration = var_34_3

					if var_34_3 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_3 + 0
					end
				end

				arg_31_1.text_.text = var_34_1
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_4 = math.max(var_34_0, arg_31_1.talkMaxDuration)

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_4 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - 0) / var_34_4

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= 0 + var_34_4 and arg_31_1.time_ < 0 + var_34_4 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play102604008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 102604008
		arg_35_1.duration_ = 3.73

		local var_35_0 = {
			ja = 3.733,
			ko = 1.5,
			zh = 1.533,
			en = 1.666
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play102604009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0.225

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1026")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_1 = arg_35_1:GetWordFromCfg(102604008)
				local var_38_2 = arg_35_1:FormatText(var_38_1.content)

				arg_35_1.text_.text = var_38_2

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_4 = 9 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 9)

				if (9 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 9)) > 0 and var_38_0 < var_38_4 then
					arg_35_1.talkMaxDuration = var_38_4

					if var_38_4 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_4 + 0
					end
				end

				arg_35_1.text_.text = var_38_2
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604008", "story_v_side_old_102604.awb") ~= 0 then
					local var_38_5 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604008", "story_v_side_old_102604.awb") / 1000

					if var_38_5 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_5 + 0
					end

					if var_38_1.prefab_name ~= "" and arg_35_1.actors_[var_38_1.prefab_name] ~= nil then
						local var_38_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_1.prefab_name].transform, "story_v_side_old_102604", "102604008", "story_v_side_old_102604.awb")

						arg_35_1:RecordAudio("102604008", var_38_6)
						arg_35_1:RecordAudio("102604008", var_38_6)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604008", "story_v_side_old_102604.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604008", "story_v_side_old_102604.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_7 = math.max(var_38_0, arg_35_1.talkMaxDuration)

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_7 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - 0) / var_38_7

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= 0 + var_38_7 and arg_35_1.time_ < 0 + var_38_7 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play102604009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 102604009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play102604010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if arg_39_1.actors_["1026ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1026ui_story"))) then
				local var_42_0 = Object.Instantiate(Asset.Load("Char/" .. "1026ui_story"), arg_39_1.stage_.transform)

				var_42_0.name = "1026ui_story"
				var_42_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_39_1.actors_["1026ui_story"] = var_42_0

				local var_42_1 = var_42_0:GetComponentInChildren(typeof(CharacterEffect))

				var_42_1.enabled = true

				local var_42_2 = GameObjectTools.GetOrAddComponent(var_42_0, typeof(DynamicBoneHelper))

				if var_42_2 then
					var_42_2:EnableDynamicBone(false)
				end

				arg_39_1:ShowWeapon(var_42_1.transform, false)

				arg_39_1.var_["1026ui_story" .. "Animator"] = var_42_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_39_1.var_["1026ui_story" .. "Animator"].applyRootMotion = true
				arg_39_1.var_["1026ui_story" .. "LipSync"] = var_42_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_42_3 = arg_39_1.actors_["1026ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_3) and arg_39_1.var_.characterEffect1026ui_story == nil then
				arg_39_1.var_.characterEffect1026ui_story = var_42_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_4 = 0.2

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_4 and not isNil(var_42_3) then
				if arg_39_1.var_.characterEffect1026ui_story and not isNil(var_42_3) then
					arg_39_1.var_.characterEffect1026ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1026ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_4)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_4 and arg_39_1.time_ < 0 + var_42_4 + arg_42_0 and not isNil(var_42_3) and arg_39_1.var_.characterEffect1026ui_story then
				arg_39_1.var_.characterEffect1026ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1026ui_story.fillRatio = 0.5
			end

			local var_42_5 = 0
			local var_42_6 = 0.175

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_5 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_7 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(102604009).content)

				arg_39_1.text_.text = var_42_7

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_9 = 7 <= 0 and var_42_6 or var_42_6 * (utf8.len(var_42_7) / 7)

				if (7 <= 0 and var_42_6 or var_42_6 * (utf8.len(var_42_7) / 7)) > 0 and var_42_6 < var_42_9 then
					arg_39_1.talkMaxDuration = var_42_9

					if var_42_9 + var_42_5 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_9 + var_42_5
					end
				end

				arg_39_1.text_.text = var_42_7
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_10 = math.max(var_42_6, arg_39_1.talkMaxDuration)

			if var_42_5 <= arg_39_1.time_ and arg_39_1.time_ < var_42_5 + var_42_10 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_5) / var_42_10

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_5 + var_42_10 and arg_39_1.time_ < var_42_5 + var_42_10 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play102604010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 102604010
		arg_43_1.duration_ = 7.03

		local var_43_0 = {
			ja = 7.033,
			ko = 4.7,
			zh = 4.7,
			en = 5.266
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play102604011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos1026ui_story = arg_43_1.actors_["1026ui_story"].transform.localPosition
			end

			local var_46_0 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 then
				arg_43_1.actors_["1026ui_story"].transform.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1026ui_story, Vector3.New(0, -1.05, -6.2), (arg_43_1.time_ - 0) / var_46_0)
				arg_43_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1026ui_story"].transform.position).z)
				arg_43_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1026ui_story"].transform.localEulerAngles = arg_43_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 then
				arg_43_1.actors_["1026ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.2)
				arg_43_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1026ui_story"].transform.position).z)
				arg_43_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1026ui_story"].transform.localEulerAngles = arg_43_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			local var_46_1 = arg_43_1.actors_["1026ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect1026ui_story == nil then
				arg_43_1.var_.characterEffect1026ui_story = var_46_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.2

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_2 and not isNil(var_46_1) then
				if arg_43_1.var_.characterEffect1026ui_story and not isNil(var_46_1) then
					arg_43_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_2 and arg_43_1.time_ < 0 + var_46_2 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect1026ui_story then
				arg_43_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action7_1")
			end

			local var_46_4 = 0
			local var_46_5 = 0.625

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_6 = arg_43_1:GetWordFromCfg(102604010)
				local var_46_7 = arg_43_1:FormatText(var_46_6.content)

				arg_43_1.text_.text = var_46_7

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_9 = 25 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 25)

				if (25 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 25)) > 0 and var_46_5 < var_46_9 then
					arg_43_1.talkMaxDuration = var_46_9

					if var_46_9 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_9 + var_46_4
					end
				end

				arg_43_1.text_.text = var_46_7
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604010", "story_v_side_old_102604.awb") ~= 0 then
					local var_46_10 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604010", "story_v_side_old_102604.awb") / 1000

					if var_46_10 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_10 + var_46_4
					end

					if var_46_6.prefab_name ~= "" and arg_43_1.actors_[var_46_6.prefab_name] ~= nil then
						local var_46_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_6.prefab_name].transform, "story_v_side_old_102604", "102604010", "story_v_side_old_102604.awb")

						arg_43_1:RecordAudio("102604010", var_46_11)
						arg_43_1:RecordAudio("102604010", var_46_11)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604010", "story_v_side_old_102604.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604010", "story_v_side_old_102604.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_12 = math.max(var_46_5, arg_43_1.talkMaxDuration)

			if var_46_4 <= arg_43_1.time_ and arg_43_1.time_ < var_46_4 + var_46_12 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_4) / var_46_12

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_4 + var_46_12 and arg_43_1.time_ < var_46_4 + var_46_12 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play102604011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 102604011
		arg_47_1.duration_ = 9.87

		local var_47_0 = {
			ja = 9.866,
			ko = 7.266,
			zh = 6.833,
			en = 8.666
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play102604012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action7_2")
			end

			local var_50_0 = 0
			local var_50_1 = 0.9

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_2 = arg_47_1:GetWordFromCfg(102604011)
				local var_50_3 = arg_47_1:FormatText(var_50_2.content)

				arg_47_1.text_.text = var_50_3

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_5 = 36 <= 0 and var_50_1 or var_50_1 * (utf8.len(var_50_3) / 36)

				if (36 <= 0 and var_50_1 or var_50_1 * (utf8.len(var_50_3) / 36)) > 0 and var_50_1 < var_50_5 then
					arg_47_1.talkMaxDuration = var_50_5

					if var_50_5 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + var_50_0
					end
				end

				arg_47_1.text_.text = var_50_3
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604011", "story_v_side_old_102604.awb") ~= 0 then
					local var_50_6 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604011", "story_v_side_old_102604.awb") / 1000

					if var_50_6 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_6 + var_50_0
					end

					if var_50_2.prefab_name ~= "" and arg_47_1.actors_[var_50_2.prefab_name] ~= nil then
						local var_50_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_2.prefab_name].transform, "story_v_side_old_102604", "102604011", "story_v_side_old_102604.awb")

						arg_47_1:RecordAudio("102604011", var_50_7)
						arg_47_1:RecordAudio("102604011", var_50_7)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604011", "story_v_side_old_102604.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604011", "story_v_side_old_102604.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_8 = math.max(var_50_1, arg_47_1.talkMaxDuration)

			if var_50_0 <= arg_47_1.time_ and arg_47_1.time_ < var_50_0 + var_50_8 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_0) / var_50_8

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_0 + var_50_8 and arg_47_1.time_ < var_50_0 + var_50_8 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play102604012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 102604012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play102604013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["1026ui_story"]) and arg_51_1.var_.characterEffect1026ui_story == nil then
				arg_51_1.var_.characterEffect1026ui_story = arg_51_1.actors_["1026ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_0 = 0.2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["1026ui_story"]) then
				if arg_51_1.var_.characterEffect1026ui_story and not isNil(arg_51_1.actors_["1026ui_story"]) then
					arg_51_1.var_.characterEffect1026ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1026ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_0)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["1026ui_story"]) and arg_51_1.var_.characterEffect1026ui_story then
				arg_51_1.var_.characterEffect1026ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1026ui_story.fillRatio = 0.5
			end

			local var_54_1 = 0
			local var_54_2 = 0.275

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_3 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(102604012).content)

				arg_51_1.text_.text = var_54_3

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 11 <= 0 and var_54_2 or var_54_2 * (utf8.len(var_54_3) / 11)

				if (11 <= 0 and var_54_2 or var_54_2 * (utf8.len(var_54_3) / 11)) > 0 and var_54_2 < var_54_5 then
					arg_51_1.talkMaxDuration = var_54_5

					if var_54_5 + var_54_1 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_5 + var_54_1
					end
				end

				arg_51_1.text_.text = var_54_3
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_6 = math.max(var_54_2, arg_51_1.talkMaxDuration)

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_6 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_1) / var_54_6

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_1 + var_54_6 and arg_51_1.time_ < var_54_1 + var_54_6 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play102604013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 102604013
		arg_55_1.duration_ = 2.07

		local var_55_0 = {
			ja = 2.066,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play102604014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action5_1")
			end

			local var_58_0 = arg_55_1.actors_["1026ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect1026ui_story == nil then
				arg_55_1.var_.characterEffect1026ui_story = var_58_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_1 = 0.2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_1 and not isNil(var_58_0) then
				if arg_55_1.var_.characterEffect1026ui_story and not isNil(var_58_0) then
					arg_55_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_1 and arg_55_1.time_ < 0 + var_58_1 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect1026ui_story then
				arg_55_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			local var_58_3 = 0
			local var_58_4 = 0.1

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_3 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_5 = arg_55_1:GetWordFromCfg(102604013)
				local var_58_6 = arg_55_1:FormatText(var_58_5.content)

				arg_55_1.text_.text = var_58_6

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_8 = 4 <= 0 and var_58_4 or var_58_4 * (utf8.len(var_58_6) / 4)

				if (4 <= 0 and var_58_4 or var_58_4 * (utf8.len(var_58_6) / 4)) > 0 and var_58_4 < var_58_8 then
					arg_55_1.talkMaxDuration = var_58_8

					if var_58_8 + var_58_3 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_8 + var_58_3
					end
				end

				arg_55_1.text_.text = var_58_6
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604013", "story_v_side_old_102604.awb") ~= 0 then
					local var_58_9 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604013", "story_v_side_old_102604.awb") / 1000

					if var_58_9 + var_58_3 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_9 + var_58_3
					end

					if var_58_5.prefab_name ~= "" and arg_55_1.actors_[var_58_5.prefab_name] ~= nil then
						local var_58_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_5.prefab_name].transform, "story_v_side_old_102604", "102604013", "story_v_side_old_102604.awb")

						arg_55_1:RecordAudio("102604013", var_58_10)
						arg_55_1:RecordAudio("102604013", var_58_10)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604013", "story_v_side_old_102604.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604013", "story_v_side_old_102604.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_11 = math.max(var_58_4, arg_55_1.talkMaxDuration)

			if var_58_3 <= arg_55_1.time_ and arg_55_1.time_ < var_58_3 + var_58_11 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_3) / var_58_11

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_3 + var_58_11 and arg_55_1.time_ < var_58_3 + var_58_11 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play102604014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 102604014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play102604015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos1026ui_story = arg_59_1.actors_["1026ui_story"].transform.localPosition
			end

			local var_62_0 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 then
				arg_59_1.actors_["1026ui_story"].transform.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1026ui_story, Vector3.New(0, 100, 0), (arg_59_1.time_ - 0) / var_62_0)
				arg_59_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1026ui_story"].transform.position).z)
				arg_59_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["1026ui_story"].transform.localEulerAngles = arg_59_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 then
				arg_59_1.actors_["1026ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_59_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1026ui_story"].transform.position).z)
				arg_59_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["1026ui_story"].transform.localEulerAngles = arg_59_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			local var_62_1 = 0
			local var_62_2 = 1.025

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_3 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(102604014).content)

				arg_59_1.text_.text = var_62_3

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_5 = 41 <= 0 and var_62_2 or var_62_2 * (utf8.len(var_62_3) / 41)

				if (41 <= 0 and var_62_2 or var_62_2 * (utf8.len(var_62_3) / 41)) > 0 and var_62_2 < var_62_5 then
					arg_59_1.talkMaxDuration = var_62_5

					if var_62_5 + var_62_1 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_5 + var_62_1
					end
				end

				arg_59_1.text_.text = var_62_3
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_6 = math.max(var_62_2, arg_59_1.talkMaxDuration)

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_6 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_1) / var_62_6

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_1 + var_62_6 and arg_59_1.time_ < var_62_1 + var_62_6 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play102604015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 102604015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play102604016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0.95

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_1 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(102604015).content)

				arg_63_1.text_.text = var_66_1

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_3 = 38 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 38)

				if (38 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 38)) > 0 and var_66_0 < var_66_3 then
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
	Play102604016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 102604016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play102604017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.175

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_1 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(102604016).content)

				arg_67_1.text_.text = var_70_1

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_3 = 7 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 7)

				if (7 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 7)) > 0 and var_70_0 < var_70_3 then
					arg_67_1.talkMaxDuration = var_70_3

					if var_70_3 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_3 + 0
					end
				end

				arg_67_1.text_.text = var_70_1
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_4 = math.max(var_70_0, arg_67_1.talkMaxDuration)

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_4 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - 0) / var_70_4

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= 0 + var_70_4 and arg_67_1.time_ < 0 + var_70_4 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play102604017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 102604017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play102604018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0.6

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_1 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(102604017).content)

				arg_71_1.text_.text = var_74_1

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_3 = 24 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_1) / 24)

				if (24 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_1) / 24)) > 0 and var_74_0 < var_74_3 then
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
	Play102604018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 102604018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play102604019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 1.025

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_1 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(102604018).content)

				arg_75_1.text_.text = var_78_1

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_3 = 41 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 41)

				if (41 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 41)) > 0 and var_78_0 < var_78_3 then
					arg_75_1.talkMaxDuration = var_78_3

					if var_78_3 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_3 + 0
					end
				end

				arg_75_1.text_.text = var_78_1
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_4 = math.max(var_78_0, arg_75_1.talkMaxDuration)

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_4 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - 0) / var_78_4

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= 0 + var_78_4 and arg_75_1.time_ < 0 + var_78_4 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play102604019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 102604019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play102604020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:AudioAction("play", "effect", "se_story_side_1026", "se_story_1026_cat03", "")
			end

			local var_82_1 = 0
			local var_82_2 = 0.05

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[198].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_cata")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_3 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(102604019).content)

				arg_79_1.text_.text = var_82_3

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 2 <= 0 and var_82_2 or var_82_2 * (utf8.len(var_82_3) / 2)

				if (2 <= 0 and var_82_2 or var_82_2 * (utf8.len(var_82_3) / 2)) > 0 and var_82_2 < var_82_5 then
					arg_79_1.talkMaxDuration = var_82_5

					if var_82_5 + var_82_1 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_5 + var_82_1
					end
				end

				arg_79_1.text_.text = var_82_3
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_6 = math.max(var_82_2, arg_79_1.talkMaxDuration)

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_6 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_1) / var_82_6

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_1 + var_82_6 and arg_79_1.time_ < var_82_1 + var_82_6 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play102604020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 102604020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play102604021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0.175

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_1 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(102604020).content)

				arg_83_1.text_.text = var_86_1

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_3 = 7 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_1) / 7)

				if (7 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_1) / 7)) > 0 and var_86_0 < var_86_3 then
					arg_83_1.talkMaxDuration = var_86_3

					if var_86_3 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_3 + 0
					end
				end

				arg_83_1.text_.text = var_86_1
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_4 = math.max(var_86_0, arg_83_1.talkMaxDuration)

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_4 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - 0) / var_86_4

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= 0 + var_86_4 and arg_83_1.time_ < 0 + var_86_4 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play102604021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 102604021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play102604022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0.55

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

				local var_90_1 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(102604021).content)

				arg_87_1.text_.text = var_90_1

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_3 = 22 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_1) / 22)

				if (22 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_1) / 22)) > 0 and var_90_0 < var_90_3 then
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
	Play102604022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 102604022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play102604023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0.225

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_1 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(102604022).content)

				arg_91_1.text_.text = var_94_1

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_3 = 9 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_1) / 9)

				if (9 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_1) / 9)) > 0 and var_94_0 < var_94_3 then
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
	Play102604023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 102604023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play102604024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 1.4

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_1 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(102604023).content)

				arg_95_1.text_.text = var_98_1

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_3 = 55 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_1) / 55)

				if (55 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_1) / 55)) > 0 and var_98_0 < var_98_3 then
					arg_95_1.talkMaxDuration = var_98_3

					if var_98_3 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_3 + 0
					end
				end

				arg_95_1.text_.text = var_98_1
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_4 = math.max(var_98_0, arg_95_1.talkMaxDuration)

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_4 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - 0) / var_98_4

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= 0 + var_98_4 and arg_95_1.time_ < 0 + var_98_4 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play102604024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 102604024
		arg_99_1.duration_ = 2.77

		local var_99_0 = {
			ja = 2.533,
			ko = 2.333,
			zh = 2.766,
			en = 2.366
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play102604025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos1026ui_story = arg_99_1.actors_["1026ui_story"].transform.localPosition
			end

			local var_102_0 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 then
				arg_99_1.actors_["1026ui_story"].transform.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1026ui_story, Vector3.New(0, -1.05, -6.2), (arg_99_1.time_ - 0) / var_102_0)
				arg_99_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1026ui_story"].transform.position).z)
				arg_99_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["1026ui_story"].transform.localEulerAngles = arg_99_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 then
				arg_99_1.actors_["1026ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.2)
				arg_99_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1026ui_story"].transform.position).z)
				arg_99_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["1026ui_story"].transform.localEulerAngles = arg_99_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			local var_102_1 = arg_99_1.actors_["1026ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect1026ui_story == nil then
				arg_99_1.var_.characterEffect1026ui_story = var_102_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.2

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_2 and not isNil(var_102_1) then
				if arg_99_1.var_.characterEffect1026ui_story and not isNil(var_102_1) then
					arg_99_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= 0 + var_102_2 and arg_99_1.time_ < 0 + var_102_2 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect1026ui_story then
				arg_99_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action1_1")
			end

			local var_102_4 = 0
			local var_102_5 = 0.275

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_4 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_6 = arg_99_1:GetWordFromCfg(102604024)
				local var_102_7 = arg_99_1:FormatText(var_102_6.content)

				arg_99_1.text_.text = var_102_7

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_9 = 11 <= 0 and var_102_5 or var_102_5 * (utf8.len(var_102_7) / 11)

				if (11 <= 0 and var_102_5 or var_102_5 * (utf8.len(var_102_7) / 11)) > 0 and var_102_5 < var_102_9 then
					arg_99_1.talkMaxDuration = var_102_9

					if var_102_9 + var_102_4 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_9 + var_102_4
					end
				end

				arg_99_1.text_.text = var_102_7
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604024", "story_v_side_old_102604.awb") ~= 0 then
					local var_102_10 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604024", "story_v_side_old_102604.awb") / 1000

					if var_102_10 + var_102_4 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_10 + var_102_4
					end

					if var_102_6.prefab_name ~= "" and arg_99_1.actors_[var_102_6.prefab_name] ~= nil then
						local var_102_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_6.prefab_name].transform, "story_v_side_old_102604", "102604024", "story_v_side_old_102604.awb")

						arg_99_1:RecordAudio("102604024", var_102_11)
						arg_99_1:RecordAudio("102604024", var_102_11)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604024", "story_v_side_old_102604.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604024", "story_v_side_old_102604.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_12 = math.max(var_102_5, arg_99_1.talkMaxDuration)

			if var_102_4 <= arg_99_1.time_ and arg_99_1.time_ < var_102_4 + var_102_12 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_4) / var_102_12

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_4 + var_102_12 and arg_99_1.time_ < var_102_4 + var_102_12 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play102604025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 102604025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play102604026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(arg_103_1.actors_["1026ui_story"]) and arg_103_1.var_.characterEffect1026ui_story == nil then
				arg_103_1.var_.characterEffect1026ui_story = arg_103_1.actors_["1026ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_0 = 0.2

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 and not isNil(arg_103_1.actors_["1026ui_story"]) then
				if arg_103_1.var_.characterEffect1026ui_story and not isNil(arg_103_1.actors_["1026ui_story"]) then
					arg_103_1.var_.characterEffect1026ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1026ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_103_1.time_ - 0) / var_106_0)
				end
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 and not isNil(arg_103_1.actors_["1026ui_story"]) and arg_103_1.var_.characterEffect1026ui_story then
				arg_103_1.var_.characterEffect1026ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1026ui_story.fillRatio = 0.5
			end

			local var_106_1 = 0
			local var_106_2 = 0.125

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, true)
				arg_103_1.iconController_:SetSelectedState("hero")

				arg_103_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_103_1.callingController_:SetSelectedState("normal")

				arg_103_1.keyicon_.color = Color.New(1, 1, 1)
				arg_103_1.icon_.color = Color.New(1, 1, 1)

				local var_106_3 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(102604025).content)

				arg_103_1.text_.text = var_106_3

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 5 <= 0 and var_106_2 or var_106_2 * (utf8.len(var_106_3) / 5)

				if (5 <= 0 and var_106_2 or var_106_2 * (utf8.len(var_106_3) / 5)) > 0 and var_106_2 < var_106_5 then
					arg_103_1.talkMaxDuration = var_106_5

					if var_106_5 + var_106_1 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_5 + var_106_1
					end
				end

				arg_103_1.text_.text = var_106_3
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_6 = math.max(var_106_2, arg_103_1.talkMaxDuration)

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_6 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_1) / var_106_6

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_1 + var_106_6 and arg_103_1.time_ < var_106_1 + var_106_6 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play102604026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 102604026
		arg_107_1.duration_ = 2

		local var_107_0 = {
			ja = 2,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play102604027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos1026ui_story = arg_107_1.actors_["1026ui_story"].transform.localPosition
			end

			local var_110_0 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 then
				arg_107_1.actors_["1026ui_story"].transform.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1026ui_story, Vector3.New(0, -1.05, -6.2), (arg_107_1.time_ - 0) / var_110_0)
				arg_107_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1026ui_story"].transform.position).z)
				arg_107_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["1026ui_story"].transform.localEulerAngles = arg_107_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 then
				arg_107_1.actors_["1026ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.2)
				arg_107_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1026ui_story"].transform.position).z)
				arg_107_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["1026ui_story"].transform.localEulerAngles = arg_107_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			local var_110_1 = arg_107_1.actors_["1026ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect1026ui_story == nil then
				arg_107_1.var_.characterEffect1026ui_story = var_110_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.2

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_2 and not isNil(var_110_1) then
				if arg_107_1.var_.characterEffect1026ui_story and not isNil(var_110_1) then
					arg_107_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_2 and arg_107_1.time_ < 0 + var_110_2 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect1026ui_story then
				arg_107_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action4_1")
			end

			local var_110_4 = 0
			local var_110_5 = 0.1

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_4 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_6 = arg_107_1:GetWordFromCfg(102604026)
				local var_110_7 = arg_107_1:FormatText(var_110_6.content)

				arg_107_1.text_.text = var_110_7

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_9 = 4 <= 0 and var_110_5 or var_110_5 * (utf8.len(var_110_7) / 4)

				if (4 <= 0 and var_110_5 or var_110_5 * (utf8.len(var_110_7) / 4)) > 0 and var_110_5 < var_110_9 then
					arg_107_1.talkMaxDuration = var_110_9

					if var_110_9 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_9 + var_110_4
					end
				end

				arg_107_1.text_.text = var_110_7
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604026", "story_v_side_old_102604.awb") ~= 0 then
					local var_110_10 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604026", "story_v_side_old_102604.awb") / 1000

					if var_110_10 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_10 + var_110_4
					end

					if var_110_6.prefab_name ~= "" and arg_107_1.actors_[var_110_6.prefab_name] ~= nil then
						local var_110_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_6.prefab_name].transform, "story_v_side_old_102604", "102604026", "story_v_side_old_102604.awb")

						arg_107_1:RecordAudio("102604026", var_110_11)
						arg_107_1:RecordAudio("102604026", var_110_11)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604026", "story_v_side_old_102604.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604026", "story_v_side_old_102604.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_12 = math.max(var_110_5, arg_107_1.talkMaxDuration)

			if var_110_4 <= arg_107_1.time_ and arg_107_1.time_ < var_110_4 + var_110_12 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_4) / var_110_12

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_4 + var_110_12 and arg_107_1.time_ < var_110_4 + var_110_12 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play102604027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 102604027
		arg_111_1.duration_ = 6.03

		local var_111_0 = {
			ja = 6.033,
			ko = 4.633,
			zh = 3.6,
			en = 4.666
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play102604028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action4_2")
			end

			local var_114_0 = 0
			local var_114_1 = 0.425

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_2 = arg_111_1:GetWordFromCfg(102604027)
				local var_114_3 = arg_111_1:FormatText(var_114_2.content)

				arg_111_1.text_.text = var_114_3

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 17 <= 0 and var_114_1 or var_114_1 * (utf8.len(var_114_3) / 17)

				if (17 <= 0 and var_114_1 or var_114_1 * (utf8.len(var_114_3) / 17)) > 0 and var_114_1 < var_114_5 then
					arg_111_1.talkMaxDuration = var_114_5

					if var_114_5 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_5 + var_114_0
					end
				end

				arg_111_1.text_.text = var_114_3
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604027", "story_v_side_old_102604.awb") ~= 0 then
					local var_114_6 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604027", "story_v_side_old_102604.awb") / 1000

					if var_114_6 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_6 + var_114_0
					end

					if var_114_2.prefab_name ~= "" and arg_111_1.actors_[var_114_2.prefab_name] ~= nil then
						local var_114_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_2.prefab_name].transform, "story_v_side_old_102604", "102604027", "story_v_side_old_102604.awb")

						arg_111_1:RecordAudio("102604027", var_114_7)
						arg_111_1:RecordAudio("102604027", var_114_7)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604027", "story_v_side_old_102604.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604027", "story_v_side_old_102604.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_8 = math.max(var_114_1, arg_111_1.talkMaxDuration)

			if var_114_0 <= arg_111_1.time_ and arg_111_1.time_ < var_114_0 + var_114_8 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_0) / var_114_8

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_0 + var_114_8 and arg_111_1.time_ < var_114_0 + var_114_8 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play102604028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 102604028
		arg_115_1.duration_ = 7

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play102604029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				local var_118_0 = arg_115_1.bgs_.ST13:GetComponent("SpriteRenderer")

				if var_118_0 then
					arg_115_1.var_.alphaOldValueST13 = var_118_0.color.a
					arg_115_1.var_.alphaMatValueST13 = var_118_0
				end

				arg_115_1.var_.alphaOldValueST13 = 1
			end

			local var_118_1 = 1.5

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_1 then
				if arg_115_1.var_.alphaMatValueST13 then
					arg_115_1.var_.alphaMatValueST13.color.a = Mathf.Lerp(arg_115_1.var_.alphaOldValueST13, 0, (arg_115_1.time_ - 0) / var_118_1)
					arg_115_1.var_.alphaMatValueST13.color = arg_115_1.var_.alphaMatValueST13.color
				end
			end

			if arg_115_1.time_ >= 0 + var_118_1 and arg_115_1.time_ < 0 + var_118_1 + arg_118_0 and arg_115_1.var_.alphaMatValueST13 then
				arg_115_1.var_.alphaMatValueST13.color.a = 0
				arg_115_1.var_.alphaMatValueST13.color = arg_115_1.var_.alphaMatValueST13.color
			end

			local var_118_2 = "ST04a"

			if arg_115_1.bgs_.ST04a == nil then
				local var_118_3 = Object.Instantiate(arg_115_1.paintGo_)

				var_118_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_118_2)
				var_118_3.name = var_118_2
				var_118_3.transform.parent = arg_115_1.stage_.transform
				var_118_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_115_1.bgs_[var_118_2] = var_118_3
			end

			if 1.5 < arg_115_1.time_ and arg_115_1.time_ <= 1.5 + arg_118_0 then
				local var_118_4 = arg_115_1.bgs_.ST04a:GetComponent("SpriteRenderer")

				if var_118_4 then
					arg_115_1.var_.alphaOldValueST04a = var_118_4.color.a
					arg_115_1.var_.alphaMatValueST04a = var_118_4
				end

				arg_115_1.var_.alphaOldValueST04a = 0
			end

			local var_118_5 = 1.5

			if 1.5 <= arg_115_1.time_ and arg_115_1.time_ < 1.5 + var_118_5 then
				if arg_115_1.var_.alphaMatValueST04a then
					arg_115_1.var_.alphaMatValueST04a.color.a = Mathf.Lerp(arg_115_1.var_.alphaOldValueST04a, 1, (arg_115_1.time_ - 1.5) / var_118_5)
					arg_115_1.var_.alphaMatValueST04a.color = arg_115_1.var_.alphaMatValueST04a.color
				end
			end

			if arg_115_1.time_ >= 1.5 + var_118_5 and arg_115_1.time_ < 1.5 + var_118_5 + arg_118_0 and arg_115_1.var_.alphaMatValueST04a then
				arg_115_1.var_.alphaMatValueST04a.color.a = 1
				arg_115_1.var_.alphaMatValueST04a.color = arg_115_1.var_.alphaMatValueST04a.color
			end

			if 1.5 < arg_115_1.time_ and arg_115_1.time_ <= 1.5 + arg_118_0 then
				local var_118_6 = arg_115_1.bgs_.ST04a

				arg_115_1.bgs_.ST04a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_118_6.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_118_7 = var_118_6:GetComponent("SpriteRenderer")

				if var_118_7 and var_118_7.sprite then
					local var_118_8 = 2 * (var_118_6.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_118_6.transform.localScale = Vector3.New(var_118_8 / var_118_7.sprite.bounds.size.y < var_118_8 * manager.ui.mainCameraCom_.aspect / var_118_7.sprite.bounds.size.x and var_118_8 * manager.ui.mainCameraCom_.aspect / var_118_7.sprite.bounds.size.x or var_118_8 / var_118_7.sprite.bounds.size.y, var_118_8 / var_118_7.sprite.bounds.size.y < var_118_8 * manager.ui.mainCameraCom_.aspect / var_118_7.sprite.bounds.size.x and var_118_8 * manager.ui.mainCameraCom_.aspect / var_118_7.sprite.bounds.size.x or var_118_8 / var_118_7.sprite.bounds.size.y, 0)
				end

				for iter_118_0, iter_118_1 in pairs(arg_115_1.bgs_) do
					if iter_118_0 ~= "ST04a" then
						iter_118_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_118_9 = arg_115_1.actors_["1026ui_story"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos1026ui_story = var_118_9.localPosition
			end

			local var_118_10 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_10 then
				var_118_9.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1026ui_story, Vector3.New(0, 100, 0), (arg_115_1.time_ - 0) / var_118_10)
				var_118_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_9.position).x, (manager.ui.mainCamera.transform.position - var_118_9.position).y, (manager.ui.mainCamera.transform.position - var_118_9.position).z)
				var_118_9.localEulerAngles.z = 0
				var_118_9.localEulerAngles.x = 0
				var_118_9.localEulerAngles = var_118_9.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_10 and arg_115_1.time_ < 0 + var_118_10 + arg_118_0 then
				var_118_9.localPosition = Vector3.New(0, 100, 0)
				var_118_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_9.position).x, (manager.ui.mainCamera.transform.position - var_118_9.position).y, (manager.ui.mainCamera.transform.position - var_118_9.position).z)
				var_118_9.localEulerAngles.z = 0
				var_118_9.localEulerAngles.x = 0
				var_118_9.localEulerAngles = var_118_9.localEulerAngles
			end

			local var_118_11 = 0

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_11 + arg_118_0 then
				arg_115_1.allBtn_.enabled = false
			end

			if arg_115_1.time_ >= var_118_11 + 2 and arg_115_1.time_ < var_118_11 + 2 + arg_118_0 then
				arg_115_1.allBtn_.enabled = true
			end

			if arg_115_1.frameCnt_ <= 1 then
				arg_115_1.dialog_:SetActive(false)
			end

			local var_118_12 = 2
			local var_118_13 = 1

			if 2 < arg_115_1.time_ and arg_115_1.time_ <= var_118_12 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0

				arg_115_1.dialog_:SetActive(true)

				arg_115_1.dialogCg_.alpha = 0

				local var_118_14 = LeanTween.value(arg_115_1.dialog_, 0, 1, 0.3)

				var_118_14:setOnUpdate(LuaHelper.FloatAction(function(arg_119_0)
					arg_115_1.dialogCg_.alpha = arg_119_0
				end))
				var_118_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_115_1.dialog_)
					var_118_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_115_1.duration_ = arg_115_1.duration_ + 0.3

				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_15 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(102604028).content)

				arg_115_1.text_.text = var_118_15

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_17 = 27 <= 0 and var_118_13 or var_118_13 * (utf8.len(var_118_15) / 27)

				if (27 <= 0 and var_118_13 or var_118_13 * (utf8.len(var_118_15) / 27)) > 0 and var_118_13 < var_118_17 then
					arg_115_1.talkMaxDuration = var_118_17
					var_118_12 = var_118_12 + 0.3

					if var_118_17 + var_118_12 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_17 + var_118_12
					end
				end

				arg_115_1.text_.text = var_118_15
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_18 = var_118_12 + 0.3
			local var_118_19 = math.max(var_118_13, arg_115_1.talkMaxDuration)

			if var_118_12 + 0.3 <= arg_115_1.time_ and arg_115_1.time_ < var_118_18 + var_118_19 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_18) / var_118_19

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_18 + var_118_19 and arg_115_1.time_ < var_118_18 + var_118_19 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play102604029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 102604029
		arg_121_1.duration_ = 3.43

		local var_121_0 = {
			ja = 3.3,
			ko = 3.433,
			zh = 2.866,
			en = 2.833
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play102604030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1026ui_story = arg_121_1.actors_["1026ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["1026ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1026ui_story, Vector3.New(0, -1.05, -6.2), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1026ui_story"].transform.position).z)
				arg_121_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1026ui_story"].transform.localEulerAngles = arg_121_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["1026ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.2)
				arg_121_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1026ui_story"].transform.position).z)
				arg_121_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1026ui_story"].transform.localEulerAngles = arg_121_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["1026ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1026ui_story == nil then
				arg_121_1.var_.characterEffect1026ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect1026ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1026ui_story then
				arg_121_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action1_1")
			end

			local var_124_4 = 0
			local var_124_5 = 0.25

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_6 = arg_121_1:GetWordFromCfg(102604029)
				local var_124_7 = arg_121_1:FormatText(var_124_6.content)

				arg_121_1.text_.text = var_124_7

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_9 = 10 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 10)

				if (10 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 10)) > 0 and var_124_5 < var_124_9 then
					arg_121_1.talkMaxDuration = var_124_9

					if var_124_9 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_4
					end
				end

				arg_121_1.text_.text = var_124_7
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604029", "story_v_side_old_102604.awb") ~= 0 then
					local var_124_10 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604029", "story_v_side_old_102604.awb") / 1000

					if var_124_10 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_4
					end

					if var_124_6.prefab_name ~= "" and arg_121_1.actors_[var_124_6.prefab_name] ~= nil then
						local var_124_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_6.prefab_name].transform, "story_v_side_old_102604", "102604029", "story_v_side_old_102604.awb")

						arg_121_1:RecordAudio("102604029", var_124_11)
						arg_121_1:RecordAudio("102604029", var_124_11)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604029", "story_v_side_old_102604.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604029", "story_v_side_old_102604.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_12 = math.max(var_124_5, arg_121_1.talkMaxDuration)

			if var_124_4 <= arg_121_1.time_ and arg_121_1.time_ < var_124_4 + var_124_12 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_4) / var_124_12

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_4 + var_124_12 and arg_121_1.time_ < var_124_4 + var_124_12 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play102604030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 102604030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play102604031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1026ui_story = arg_125_1.actors_["1026ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["1026ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1026ui_story, Vector3.New(0, 100, 0), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1026ui_story"].transform.position).z)
				arg_125_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1026ui_story"].transform.localEulerAngles = arg_125_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["1026ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_125_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1026ui_story"].transform.position).z)
				arg_125_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1026ui_story"].transform.localEulerAngles = arg_125_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			local var_128_1 = 0
			local var_128_2 = 0.575

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_3 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(102604030).content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 23 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 23)

				if (23 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 23)) > 0 and var_128_2 < var_128_5 then
					arg_125_1.talkMaxDuration = var_128_5

					if var_128_5 + var_128_1 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + var_128_1
					end
				end

				arg_125_1.text_.text = var_128_3
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_6 = math.max(var_128_2, arg_125_1.talkMaxDuration)

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_6 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_1) / var_128_6

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_1 + var_128_6 and arg_125_1.time_ < var_128_1 + var_128_6 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play102604031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 102604031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play102604032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0.7

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_1 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(102604031).content)

				arg_129_1.text_.text = var_132_1

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_3 = 28 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 28)

				if (28 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 28)) > 0 and var_132_0 < var_132_3 then
					arg_129_1.talkMaxDuration = var_132_3

					if var_132_3 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_3 + 0
					end
				end

				arg_129_1.text_.text = var_132_1
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_4 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_4 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_4

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_4 and arg_129_1.time_ < 0 + var_132_4 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play102604032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 102604032
		arg_133_1.duration_ = 6.03

		local var_133_0 = {
			ja = 6.033,
			ko = 3.7,
			zh = 5.566,
			en = 4.033
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play102604033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1026ui_story = arg_133_1.actors_["1026ui_story"].transform.localPosition
			end

			local var_136_0 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 then
				arg_133_1.actors_["1026ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1026ui_story, Vector3.New(0, -1.05, -6.2), (arg_133_1.time_ - 0) / var_136_0)
				arg_133_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1026ui_story"].transform.position).z)
				arg_133_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1026ui_story"].transform.localEulerAngles = arg_133_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 then
				arg_133_1.actors_["1026ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.2)
				arg_133_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1026ui_story"].transform.position).z)
				arg_133_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1026ui_story"].transform.localEulerAngles = arg_133_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			local var_136_1 = arg_133_1.actors_["1026ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1026ui_story == nil then
				arg_133_1.var_.characterEffect1026ui_story = var_136_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.2

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 and not isNil(var_136_1) then
				if arg_133_1.var_.characterEffect1026ui_story and not isNil(var_136_1) then
					arg_133_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1026ui_story then
				arg_133_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action7_1")
			end

			local var_136_4 = 0
			local var_136_5 = 0.425

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_6 = arg_133_1:GetWordFromCfg(102604032)
				local var_136_7 = arg_133_1:FormatText(var_136_6.content)

				arg_133_1.text_.text = var_136_7

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_9 = 17 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 17)

				if (17 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 17)) > 0 and var_136_5 < var_136_9 then
					arg_133_1.talkMaxDuration = var_136_9

					if var_136_9 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_9 + var_136_4
					end
				end

				arg_133_1.text_.text = var_136_7
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604032", "story_v_side_old_102604.awb") ~= 0 then
					local var_136_10 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604032", "story_v_side_old_102604.awb") / 1000

					if var_136_10 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_4
					end

					if var_136_6.prefab_name ~= "" and arg_133_1.actors_[var_136_6.prefab_name] ~= nil then
						local var_136_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_6.prefab_name].transform, "story_v_side_old_102604", "102604032", "story_v_side_old_102604.awb")

						arg_133_1:RecordAudio("102604032", var_136_11)
						arg_133_1:RecordAudio("102604032", var_136_11)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604032", "story_v_side_old_102604.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604032", "story_v_side_old_102604.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_12 = math.max(var_136_5, arg_133_1.talkMaxDuration)

			if var_136_4 <= arg_133_1.time_ and arg_133_1.time_ < var_136_4 + var_136_12 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_4) / var_136_12

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_4 + var_136_12 and arg_133_1.time_ < var_136_4 + var_136_12 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play102604033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 102604033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play102604034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["1026ui_story"]) and arg_137_1.var_.characterEffect1026ui_story == nil then
				arg_137_1.var_.characterEffect1026ui_story = arg_137_1.actors_["1026ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.2

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["1026ui_story"]) then
				if arg_137_1.var_.characterEffect1026ui_story and not isNil(arg_137_1.actors_["1026ui_story"]) then
					arg_137_1.var_.characterEffect1026ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1026ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_0)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["1026ui_story"]) and arg_137_1.var_.characterEffect1026ui_story then
				arg_137_1.var_.characterEffect1026ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1026ui_story.fillRatio = 0.5
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:AudioAction("play", "effect", "se_story_side_1026", "se_story_1026_cat02", "")
			end

			local var_140_2 = 0
			local var_140_3 = 0.05

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_2 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[198].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_cata")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_4 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(102604033).content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_6 = 2 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_4) / 2)

				if (2 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_4) / 2)) > 0 and var_140_3 < var_140_6 then
					arg_137_1.talkMaxDuration = var_140_6

					if var_140_6 + var_140_2 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_6 + var_140_2
					end
				end

				arg_137_1.text_.text = var_140_4
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_3, arg_137_1.talkMaxDuration)

			if var_140_2 <= arg_137_1.time_ and arg_137_1.time_ < var_140_2 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_2) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_2 + var_140_7 and arg_137_1.time_ < var_140_2 + var_140_7 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play102604034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 102604034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play102604035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0.2

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_1 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(102604034).content)

				arg_141_1.text_.text = var_144_1

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_3 = 8 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 8)

				if (8 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 8)) > 0 and var_144_0 < var_144_3 then
					arg_141_1.talkMaxDuration = var_144_3

					if var_144_3 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_3 + 0
					end
				end

				arg_141_1.text_.text = var_144_1
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_4 = math.max(var_144_0, arg_141_1.talkMaxDuration)

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - 0) / var_144_4

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play102604035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 102604035
		arg_145_1.duration_ = 5.7

		local var_145_0 = {
			ja = 5.7,
			ko = 3.166,
			zh = 2.8,
			en = 4.633
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play102604036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["1026ui_story"]) and arg_145_1.var_.characterEffect1026ui_story == nil then
				arg_145_1.var_.characterEffect1026ui_story = arg_145_1.actors_["1026ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_0 = 0.2

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["1026ui_story"]) then
				if arg_145_1.var_.characterEffect1026ui_story and not isNil(arg_145_1.actors_["1026ui_story"]) then
					arg_145_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["1026ui_story"]) and arg_145_1.var_.characterEffect1026ui_story then
				arg_145_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026actionlink/1026action473")
			end

			local var_148_2 = 0
			local var_148_3 = 0.35

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_2 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_4 = arg_145_1:GetWordFromCfg(102604035)
				local var_148_5 = arg_145_1:FormatText(var_148_4.content)

				arg_145_1.text_.text = var_148_5

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_7 = 14 <= 0 and var_148_3 or var_148_3 * (utf8.len(var_148_5) / 14)

				if (14 <= 0 and var_148_3 or var_148_3 * (utf8.len(var_148_5) / 14)) > 0 and var_148_3 < var_148_7 then
					arg_145_1.talkMaxDuration = var_148_7

					if var_148_7 + var_148_2 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_2
					end
				end

				arg_145_1.text_.text = var_148_5
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604035", "story_v_side_old_102604.awb") ~= 0 then
					local var_148_8 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604035", "story_v_side_old_102604.awb") / 1000

					if var_148_8 + var_148_2 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_8 + var_148_2
					end

					if var_148_4.prefab_name ~= "" and arg_145_1.actors_[var_148_4.prefab_name] ~= nil then
						local var_148_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_4.prefab_name].transform, "story_v_side_old_102604", "102604035", "story_v_side_old_102604.awb")

						arg_145_1:RecordAudio("102604035", var_148_9)
						arg_145_1:RecordAudio("102604035", var_148_9)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604035", "story_v_side_old_102604.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604035", "story_v_side_old_102604.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_10 = math.max(var_148_3, arg_145_1.talkMaxDuration)

			if var_148_2 <= arg_145_1.time_ and arg_145_1.time_ < var_148_2 + var_148_10 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_2) / var_148_10

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_2 + var_148_10 and arg_145_1.time_ < var_148_2 + var_148_10 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play102604036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 102604036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play102604037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1026ui_story = arg_149_1.actors_["1026ui_story"].transform.localPosition
			end

			local var_152_0 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 then
				arg_149_1.actors_["1026ui_story"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1026ui_story, Vector3.New(0, 100, 0), (arg_149_1.time_ - 0) / var_152_0)
				arg_149_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1026ui_story"].transform.position).z)
				arg_149_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1026ui_story"].transform.localEulerAngles = arg_149_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 then
				arg_149_1.actors_["1026ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_149_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1026ui_story"].transform.position).z)
				arg_149_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1026ui_story"].transform.localEulerAngles = arg_149_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			local var_152_1 = 0
			local var_152_2 = 0.85

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_3 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(102604036).content)

				arg_149_1.text_.text = var_152_3

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 34 <= 0 and var_152_2 or var_152_2 * (utf8.len(var_152_3) / 34)

				if (34 <= 0 and var_152_2 or var_152_2 * (utf8.len(var_152_3) / 34)) > 0 and var_152_2 < var_152_5 then
					arg_149_1.talkMaxDuration = var_152_5

					if var_152_5 + var_152_1 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_5 + var_152_1
					end
				end

				arg_149_1.text_.text = var_152_3
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_6 = math.max(var_152_2, arg_149_1.talkMaxDuration)

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_6 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_1) / var_152_6

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_1 + var_152_6 and arg_149_1.time_ < var_152_1 + var_152_6 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play102604037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 102604037
		arg_153_1.duration_ = 8.33

		local var_153_0 = {
			ja = 8.333,
			ko = 6.666,
			zh = 6.8,
			en = 7.2
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play102604038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1026ui_story = arg_153_1.actors_["1026ui_story"].transform.localPosition
			end

			local var_156_0 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 then
				arg_153_1.actors_["1026ui_story"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1026ui_story, Vector3.New(0, -1.05, -6.2), (arg_153_1.time_ - 0) / var_156_0)
				arg_153_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1026ui_story"].transform.position).z)
				arg_153_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1026ui_story"].transform.localEulerAngles = arg_153_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 then
				arg_153_1.actors_["1026ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.2)
				arg_153_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1026ui_story"].transform.position).z)
				arg_153_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1026ui_story"].transform.localEulerAngles = arg_153_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			local var_156_1 = arg_153_1.actors_["1026ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1026ui_story == nil then
				arg_153_1.var_.characterEffect1026ui_story = var_156_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.2

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_2 and not isNil(var_156_1) then
				if arg_153_1.var_.characterEffect1026ui_story and not isNil(var_156_1) then
					arg_153_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_2 and arg_153_1.time_ < 0 + var_156_2 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1026ui_story then
				arg_153_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action4_1")
			end

			local var_156_4 = 0
			local var_156_5 = 0.65

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_6 = arg_153_1:GetWordFromCfg(102604037)
				local var_156_7 = arg_153_1:FormatText(var_156_6.content)

				arg_153_1.text_.text = var_156_7

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_9 = 26 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 26)

				if (26 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 26)) > 0 and var_156_5 < var_156_9 then
					arg_153_1.talkMaxDuration = var_156_9

					if var_156_9 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_9 + var_156_4
					end
				end

				arg_153_1.text_.text = var_156_7
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604037", "story_v_side_old_102604.awb") ~= 0 then
					local var_156_10 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604037", "story_v_side_old_102604.awb") / 1000

					if var_156_10 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_4
					end

					if var_156_6.prefab_name ~= "" and arg_153_1.actors_[var_156_6.prefab_name] ~= nil then
						local var_156_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_6.prefab_name].transform, "story_v_side_old_102604", "102604037", "story_v_side_old_102604.awb")

						arg_153_1:RecordAudio("102604037", var_156_11)
						arg_153_1:RecordAudio("102604037", var_156_11)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604037", "story_v_side_old_102604.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604037", "story_v_side_old_102604.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_12 = math.max(var_156_5, arg_153_1.talkMaxDuration)

			if var_156_4 <= arg_153_1.time_ and arg_153_1.time_ < var_156_4 + var_156_12 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_4) / var_156_12

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_4 + var_156_12 and arg_153_1.time_ < var_156_4 + var_156_12 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play102604038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 102604038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play102604039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["1026ui_story"]) and arg_157_1.var_.characterEffect1026ui_story == nil then
				arg_157_1.var_.characterEffect1026ui_story = arg_157_1.actors_["1026ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_0 = 0.2

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["1026ui_story"]) then
				if arg_157_1.var_.characterEffect1026ui_story and not isNil(arg_157_1.actors_["1026ui_story"]) then
					arg_157_1.var_.characterEffect1026ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1026ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_0)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["1026ui_story"]) and arg_157_1.var_.characterEffect1026ui_story then
				arg_157_1.var_.characterEffect1026ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1026ui_story.fillRatio = 0.5
			end

			local var_160_1 = 0
			local var_160_2 = 0.275

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_3 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(102604038).content)

				arg_157_1.text_.text = var_160_3

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 11 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_3) / 11)

				if (11 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_3) / 11)) > 0 and var_160_2 < var_160_5 then
					arg_157_1.talkMaxDuration = var_160_5

					if var_160_5 + var_160_1 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + var_160_1
					end
				end

				arg_157_1.text_.text = var_160_3
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_6 = math.max(var_160_2, arg_157_1.talkMaxDuration)

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_6 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_1) / var_160_6

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_1 + var_160_6 and arg_157_1.time_ < var_160_1 + var_160_6 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play102604039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 102604039
		arg_161_1.duration_ = 5.73

		local var_161_0 = {
			ja = 5.733,
			ko = 4.6,
			zh = 3.833,
			en = 3.633
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
				arg_161_0:Play102604040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action4_2")
			end

			local var_164_0 = arg_161_1.actors_["1026ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1026ui_story == nil then
				arg_161_1.var_.characterEffect1026ui_story = var_164_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_1 = 0.2

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_1 and not isNil(var_164_0) then
				if arg_161_1.var_.characterEffect1026ui_story and not isNil(var_164_0) then
					arg_161_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_1 and arg_161_1.time_ < 0 + var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1026ui_story then
				arg_161_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			local var_164_3 = 0
			local var_164_4 = 0.525

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_3 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_5 = arg_161_1:GetWordFromCfg(102604039)
				local var_164_6 = arg_161_1:FormatText(var_164_5.content)

				arg_161_1.text_.text = var_164_6

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_8 = 21 <= 0 and var_164_4 or var_164_4 * (utf8.len(var_164_6) / 21)

				if (21 <= 0 and var_164_4 or var_164_4 * (utf8.len(var_164_6) / 21)) > 0 and var_164_4 < var_164_8 then
					arg_161_1.talkMaxDuration = var_164_8

					if var_164_8 + var_164_3 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_8 + var_164_3
					end
				end

				arg_161_1.text_.text = var_164_6
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604039", "story_v_side_old_102604.awb") ~= 0 then
					local var_164_9 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604039", "story_v_side_old_102604.awb") / 1000

					if var_164_9 + var_164_3 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_9 + var_164_3
					end

					if var_164_5.prefab_name ~= "" and arg_161_1.actors_[var_164_5.prefab_name] ~= nil then
						local var_164_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_5.prefab_name].transform, "story_v_side_old_102604", "102604039", "story_v_side_old_102604.awb")

						arg_161_1:RecordAudio("102604039", var_164_10)
						arg_161_1:RecordAudio("102604039", var_164_10)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604039", "story_v_side_old_102604.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604039", "story_v_side_old_102604.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_11 = math.max(var_164_4, arg_161_1.talkMaxDuration)

			if var_164_3 <= arg_161_1.time_ and arg_161_1.time_ < var_164_3 + var_164_11 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_3) / var_164_11

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_3 + var_164_11 and arg_161_1.time_ < var_164_3 + var_164_11 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play102604040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 102604040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play102604041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["1026ui_story"]) and arg_165_1.var_.characterEffect1026ui_story == nil then
				arg_165_1.var_.characterEffect1026ui_story = arg_165_1.actors_["1026ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_0 = 0.2

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["1026ui_story"]) then
				if arg_165_1.var_.characterEffect1026ui_story and not isNil(arg_165_1.actors_["1026ui_story"]) then
					arg_165_1.var_.characterEffect1026ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1026ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_0)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["1026ui_story"]) and arg_165_1.var_.characterEffect1026ui_story then
				arg_165_1.var_.characterEffect1026ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1026ui_story.fillRatio = 0.5
			end

			local var_168_1 = 0
			local var_168_2 = 0.2

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_3 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(102604040).content)

				arg_165_1.text_.text = var_168_3

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 8 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 8)

				if (8 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 8)) > 0 and var_168_2 < var_168_5 then
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
	Play102604041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 102604041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play102604042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0.375

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_1 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(102604041).content)

				arg_169_1.text_.text = var_172_1

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_3 = 15 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 15)

				if (15 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 15)) > 0 and var_172_0 < var_172_3 then
					arg_169_1.talkMaxDuration = var_172_3

					if var_172_3 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_3 + 0
					end
				end

				arg_169_1.text_.text = var_172_1
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_4 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_4

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play102604042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 102604042
		arg_173_1.duration_ = 7

		local var_173_0 = {
			ja = 7,
			ko = 4.933,
			zh = 4.2,
			en = 6.8
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play102604043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action7_1")
			end

			local var_176_0 = arg_173_1.actors_["1026ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1026ui_story == nil then
				arg_173_1.var_.characterEffect1026ui_story = var_176_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_1 = 0.2

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_1 and not isNil(var_176_0) then
				if arg_173_1.var_.characterEffect1026ui_story and not isNil(var_176_0) then
					arg_173_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_1 and arg_173_1.time_ < 0 + var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1026ui_story then
				arg_173_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			local var_176_3 = 0
			local var_176_4 = 0.475

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_3 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_5 = arg_173_1:GetWordFromCfg(102604042)
				local var_176_6 = arg_173_1:FormatText(var_176_5.content)

				arg_173_1.text_.text = var_176_6

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_8 = 19 <= 0 and var_176_4 or var_176_4 * (utf8.len(var_176_6) / 19)

				if (19 <= 0 and var_176_4 or var_176_4 * (utf8.len(var_176_6) / 19)) > 0 and var_176_4 < var_176_8 then
					arg_173_1.talkMaxDuration = var_176_8

					if var_176_8 + var_176_3 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_8 + var_176_3
					end
				end

				arg_173_1.text_.text = var_176_6
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604042", "story_v_side_old_102604.awb") ~= 0 then
					local var_176_9 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604042", "story_v_side_old_102604.awb") / 1000

					if var_176_9 + var_176_3 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_9 + var_176_3
					end

					if var_176_5.prefab_name ~= "" and arg_173_1.actors_[var_176_5.prefab_name] ~= nil then
						local var_176_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_5.prefab_name].transform, "story_v_side_old_102604", "102604042", "story_v_side_old_102604.awb")

						arg_173_1:RecordAudio("102604042", var_176_10)
						arg_173_1:RecordAudio("102604042", var_176_10)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604042", "story_v_side_old_102604.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604042", "story_v_side_old_102604.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_11 = math.max(var_176_4, arg_173_1.talkMaxDuration)

			if var_176_3 <= arg_173_1.time_ and arg_173_1.time_ < var_176_3 + var_176_11 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_3) / var_176_11

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_3 + var_176_11 and arg_173_1.time_ < var_176_3 + var_176_11 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play102604043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 102604043
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play102604044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1026ui_story = arg_177_1.actors_["1026ui_story"].transform.localPosition
			end

			local var_180_0 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 then
				arg_177_1.actors_["1026ui_story"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1026ui_story, Vector3.New(0, 100, 0), (arg_177_1.time_ - 0) / var_180_0)
				arg_177_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1026ui_story"].transform.position).z)
				arg_177_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1026ui_story"].transform.localEulerAngles = arg_177_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 then
				arg_177_1.actors_["1026ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_177_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1026ui_story"].transform.position).z)
				arg_177_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1026ui_story"].transform.localEulerAngles = arg_177_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			local var_180_1 = 0
			local var_180_2 = 0.175

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_3 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(102604043).content)

				arg_177_1.text_.text = var_180_3

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_5 = 7 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_3) / 7)

				if (7 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_3) / 7)) > 0 and var_180_2 < var_180_5 then
					arg_177_1.talkMaxDuration = var_180_5

					if var_180_5 + var_180_1 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + var_180_1
					end
				end

				arg_177_1.text_.text = var_180_3
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_6 = math.max(var_180_2, arg_177_1.talkMaxDuration)

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_6 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_1) / var_180_6

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_1 + var_180_6 and arg_177_1.time_ < var_180_1 + var_180_6 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play102604044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 102604044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play102604045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0.85

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_1 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(102604044).content)

				arg_181_1.text_.text = var_184_1

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_3 = 34 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 34)

				if (34 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 34)) > 0 and var_184_0 < var_184_3 then
					arg_181_1.talkMaxDuration = var_184_3

					if var_184_3 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_3 + 0
					end
				end

				arg_181_1.text_.text = var_184_1
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_4 = math.max(var_184_0, arg_181_1.talkMaxDuration)

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_4 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - 0) / var_184_4

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= 0 + var_184_4 and arg_181_1.time_ < 0 + var_184_4 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play102604045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 102604045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play102604046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0.5

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_1 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(102604045).content)

				arg_185_1.text_.text = var_188_1

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_3 = 20 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 20)

				if (20 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 20)) > 0 and var_188_0 < var_188_3 then
					arg_185_1.talkMaxDuration = var_188_3

					if var_188_3 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_3 + 0
					end
				end

				arg_185_1.text_.text = var_188_1
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_4 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_4 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_4

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_4 and arg_185_1.time_ < 0 + var_188_4 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play102604046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 102604046
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play102604047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 1.275

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
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

				local var_192_1 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(102604046).content)

				arg_189_1.text_.text = var_192_1

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_3 = 51 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_1) / 51)

				if (51 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_1) / 51)) > 0 and var_192_0 < var_192_3 then
					arg_189_1.talkMaxDuration = var_192_3

					if var_192_3 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_3 + 0
					end
				end

				arg_189_1.text_.text = var_192_1
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_4 = math.max(var_192_0, arg_189_1.talkMaxDuration)

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_4 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - 0) / var_192_4

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= 0 + var_192_4 and arg_189_1.time_ < 0 + var_192_4 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play102604047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 102604047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play102604048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0.75

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_1 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(102604047).content)

				arg_193_1.text_.text = var_196_1

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_3 = 29 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 29)

				if (29 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 29)) > 0 and var_196_0 < var_196_3 then
					arg_193_1.talkMaxDuration = var_196_3

					if var_196_3 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_3 + 0
					end
				end

				arg_193_1.text_.text = var_196_1
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_4 = math.max(var_196_0, arg_193_1.talkMaxDuration)

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_4 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - 0) / var_196_4

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= 0 + var_196_4 and arg_193_1.time_ < 0 + var_196_4 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play102604048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 102604048
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play102604049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0.675

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_1 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(102604048).content)

				arg_197_1.text_.text = var_200_1

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_3 = 27 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_1) / 27)

				if (27 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_1) / 27)) > 0 and var_200_0 < var_200_3 then
					arg_197_1.talkMaxDuration = var_200_3

					if var_200_3 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_3 + 0
					end
				end

				arg_197_1.text_.text = var_200_1
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_4 = math.max(var_200_0, arg_197_1.talkMaxDuration)

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_4 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - 0) / var_200_4

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= 0 + var_200_4 and arg_197_1.time_ < 0 + var_200_4 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play102604049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 102604049
		arg_201_1.duration_ = 5.43

		local var_201_0 = {
			ja = 5.433,
			ko = 3.833,
			zh = 3.5,
			en = 5.3
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
				arg_201_0:Play102604050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos1026ui_story = arg_201_1.actors_["1026ui_story"].transform.localPosition
			end

			local var_204_0 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 then
				arg_201_1.actors_["1026ui_story"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1026ui_story, Vector3.New(0, -1.05, -6.2), (arg_201_1.time_ - 0) / var_204_0)
				arg_201_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1026ui_story"].transform.position).z)
				arg_201_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1026ui_story"].transform.localEulerAngles = arg_201_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 then
				arg_201_1.actors_["1026ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.2)
				arg_201_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1026ui_story"].transform.position).z)
				arg_201_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1026ui_story"].transform.localEulerAngles = arg_201_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			local var_204_1 = arg_201_1.actors_["1026ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_1) and arg_201_1.var_.characterEffect1026ui_story == nil then
				arg_201_1.var_.characterEffect1026ui_story = var_204_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.2

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_2 and not isNil(var_204_1) then
				if arg_201_1.var_.characterEffect1026ui_story and not isNil(var_204_1) then
					arg_201_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= 0 + var_204_2 and arg_201_1.time_ < 0 + var_204_2 + arg_204_0 and not isNil(var_204_1) and arg_201_1.var_.characterEffect1026ui_story then
				arg_201_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action7_1")
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_204_4 = 0
			local var_204_5 = 0.4

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_4 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_6 = arg_201_1:GetWordFromCfg(102604049)
				local var_204_7 = arg_201_1:FormatText(var_204_6.content)

				arg_201_1.text_.text = var_204_7

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_9 = 16 <= 0 and var_204_5 or var_204_5 * (utf8.len(var_204_7) / 16)

				if (16 <= 0 and var_204_5 or var_204_5 * (utf8.len(var_204_7) / 16)) > 0 and var_204_5 < var_204_9 then
					arg_201_1.talkMaxDuration = var_204_9

					if var_204_9 + var_204_4 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_9 + var_204_4
					end
				end

				arg_201_1.text_.text = var_204_7
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604049", "story_v_side_old_102604.awb") ~= 0 then
					local var_204_10 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604049", "story_v_side_old_102604.awb") / 1000

					if var_204_10 + var_204_4 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_10 + var_204_4
					end

					if var_204_6.prefab_name ~= "" and arg_201_1.actors_[var_204_6.prefab_name] ~= nil then
						local var_204_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_6.prefab_name].transform, "story_v_side_old_102604", "102604049", "story_v_side_old_102604.awb")

						arg_201_1:RecordAudio("102604049", var_204_11)
						arg_201_1:RecordAudio("102604049", var_204_11)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604049", "story_v_side_old_102604.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604049", "story_v_side_old_102604.awb")
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
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play102604050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 102604050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play102604051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos1026ui_story = arg_205_1.actors_["1026ui_story"].transform.localPosition
			end

			local var_208_0 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 then
				arg_205_1.actors_["1026ui_story"].transform.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1026ui_story, Vector3.New(0, 100, 0), (arg_205_1.time_ - 0) / var_208_0)
				arg_205_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1026ui_story"].transform.position).z)
				arg_205_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1026ui_story"].transform.localEulerAngles = arg_205_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 then
				arg_205_1.actors_["1026ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_205_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1026ui_story"].transform.position).z)
				arg_205_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1026ui_story"].transform.localEulerAngles = arg_205_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:AudioAction("play", "effect", "se_story_side_1026", "se_story_1026_alert", "")
			end

			local var_208_2 = 0
			local var_208_3 = 0.55

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_2 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_4 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(102604050).content)

				arg_205_1.text_.text = var_208_4

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_6 = 21 <= 0 and var_208_3 or var_208_3 * (utf8.len(var_208_4) / 21)

				if (21 <= 0 and var_208_3 or var_208_3 * (utf8.len(var_208_4) / 21)) > 0 and var_208_3 < var_208_6 then
					arg_205_1.talkMaxDuration = var_208_6

					if var_208_6 + var_208_2 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_6 + var_208_2
					end
				end

				arg_205_1.text_.text = var_208_4
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_7 = math.max(var_208_3, arg_205_1.talkMaxDuration)

			if var_208_2 <= arg_205_1.time_ and arg_205_1.time_ < var_208_2 + var_208_7 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_2) / var_208_7

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_2 + var_208_7 and arg_205_1.time_ < var_208_2 + var_208_7 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play102604051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 102604051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play102604052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0.35

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_1 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(102604051).content)

				arg_209_1.text_.text = var_212_1

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_3 = 14 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 14)

				if (14 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 14)) > 0 and var_212_0 < var_212_3 then
					arg_209_1.talkMaxDuration = var_212_3

					if var_212_3 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_3 + 0
					end
				end

				arg_209_1.text_.text = var_212_1
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_4 = math.max(var_212_0, arg_209_1.talkMaxDuration)

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_4 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - 0) / var_212_4

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= 0 + var_212_4 and arg_209_1.time_ < 0 + var_212_4 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play102604052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 102604052
		arg_213_1.duration_ = 8.57

		local var_213_0 = {
			ja = 8.566,
			ko = 5.266,
			zh = 6.966,
			en = 6.666
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play102604053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1026ui_story = arg_213_1.actors_["1026ui_story"].transform.localPosition
			end

			local var_216_0 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 then
				arg_213_1.actors_["1026ui_story"].transform.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1026ui_story, Vector3.New(0, -1.05, -6.2), (arg_213_1.time_ - 0) / var_216_0)
				arg_213_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1026ui_story"].transform.position).z)
				arg_213_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1026ui_story"].transform.localEulerAngles = arg_213_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 then
				arg_213_1.actors_["1026ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.2)
				arg_213_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1026ui_story"].transform.position).z)
				arg_213_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1026ui_story"].transform.localEulerAngles = arg_213_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			local var_216_1 = arg_213_1.actors_["1026ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1026ui_story == nil then
				arg_213_1.var_.characterEffect1026ui_story = var_216_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.2

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_2 and not isNil(var_216_1) then
				if arg_213_1.var_.characterEffect1026ui_story and not isNil(var_216_1) then
					arg_213_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_2 and arg_213_1.time_ < 0 + var_216_2 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1026ui_story then
				arg_213_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action7_2")
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_216_4 = 0
			local var_216_5 = 0.55

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_6 = arg_213_1:GetWordFromCfg(102604052)
				local var_216_7 = arg_213_1:FormatText(var_216_6.content)

				arg_213_1.text_.text = var_216_7

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_9 = 22 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 22)

				if (22 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 22)) > 0 and var_216_5 < var_216_9 then
					arg_213_1.talkMaxDuration = var_216_9

					if var_216_9 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_9 + var_216_4
					end
				end

				arg_213_1.text_.text = var_216_7
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604052", "story_v_side_old_102604.awb") ~= 0 then
					local var_216_10 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604052", "story_v_side_old_102604.awb") / 1000

					if var_216_10 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_10 + var_216_4
					end

					if var_216_6.prefab_name ~= "" and arg_213_1.actors_[var_216_6.prefab_name] ~= nil then
						local var_216_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_6.prefab_name].transform, "story_v_side_old_102604", "102604052", "story_v_side_old_102604.awb")

						arg_213_1:RecordAudio("102604052", var_216_11)
						arg_213_1:RecordAudio("102604052", var_216_11)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604052", "story_v_side_old_102604.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604052", "story_v_side_old_102604.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_12 = math.max(var_216_5, arg_213_1.talkMaxDuration)

			if var_216_4 <= arg_213_1.time_ and arg_213_1.time_ < var_216_4 + var_216_12 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_4) / var_216_12

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_4 + var_216_12 and arg_213_1.time_ < var_216_4 + var_216_12 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play102604053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 102604053
		arg_217_1.duration_ = 15.57

		local var_217_0 = {
			ja = 15.566,
			ko = 9,
			zh = 10.666,
			en = 6.7
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play102604054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action4_1")
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_220_0 = 0
			local var_220_1 = 1.1

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_2 = arg_217_1:GetWordFromCfg(102604053)
				local var_220_3 = arg_217_1:FormatText(var_220_2.content)

				arg_217_1.text_.text = var_220_3

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 44 <= 0 and var_220_1 or var_220_1 * (utf8.len(var_220_3) / 44)

				if (44 <= 0 and var_220_1 or var_220_1 * (utf8.len(var_220_3) / 44)) > 0 and var_220_1 < var_220_5 then
					arg_217_1.talkMaxDuration = var_220_5

					if var_220_5 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + var_220_0
					end
				end

				arg_217_1.text_.text = var_220_3
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604053", "story_v_side_old_102604.awb") ~= 0 then
					local var_220_6 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604053", "story_v_side_old_102604.awb") / 1000

					if var_220_6 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_6 + var_220_0
					end

					if var_220_2.prefab_name ~= "" and arg_217_1.actors_[var_220_2.prefab_name] ~= nil then
						local var_220_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_2.prefab_name].transform, "story_v_side_old_102604", "102604053", "story_v_side_old_102604.awb")

						arg_217_1:RecordAudio("102604053", var_220_7)
						arg_217_1:RecordAudio("102604053", var_220_7)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604053", "story_v_side_old_102604.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604053", "story_v_side_old_102604.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_8 = math.max(var_220_1, arg_217_1.talkMaxDuration)

			if var_220_0 <= arg_217_1.time_ and arg_217_1.time_ < var_220_0 + var_220_8 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_0) / var_220_8

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_0 + var_220_8 and arg_217_1.time_ < var_220_0 + var_220_8 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play102604054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 102604054
		arg_221_1.duration_ = 7.3

		local var_221_0 = {
			ja = 7.3,
			ko = 6.033,
			zh = 4.866,
			en = 5.233
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play102604055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action4_2")
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_224_0 = 0
			local var_224_1 = 0.725

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_2 = arg_221_1:GetWordFromCfg(102604054)
				local var_224_3 = arg_221_1:FormatText(var_224_2.content)

				arg_221_1.text_.text = var_224_3

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_5 = 28 <= 0 and var_224_1 or var_224_1 * (utf8.len(var_224_3) / 28)

				if (28 <= 0 and var_224_1 or var_224_1 * (utf8.len(var_224_3) / 28)) > 0 and var_224_1 < var_224_5 then
					arg_221_1.talkMaxDuration = var_224_5

					if var_224_5 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + var_224_0
					end
				end

				arg_221_1.text_.text = var_224_3
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604054", "story_v_side_old_102604.awb") ~= 0 then
					local var_224_6 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604054", "story_v_side_old_102604.awb") / 1000

					if var_224_6 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_6 + var_224_0
					end

					if var_224_2.prefab_name ~= "" and arg_221_1.actors_[var_224_2.prefab_name] ~= nil then
						local var_224_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_2.prefab_name].transform, "story_v_side_old_102604", "102604054", "story_v_side_old_102604.awb")

						arg_221_1:RecordAudio("102604054", var_224_7)
						arg_221_1:RecordAudio("102604054", var_224_7)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604054", "story_v_side_old_102604.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604054", "story_v_side_old_102604.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_8 = math.max(var_224_1, arg_221_1.talkMaxDuration)

			if var_224_0 <= arg_221_1.time_ and arg_221_1.time_ < var_224_0 + var_224_8 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_0) / var_224_8

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_0 + var_224_8 and arg_221_1.time_ < var_224_0 + var_224_8 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play102604055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 102604055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play102604056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(arg_225_1.actors_["1026ui_story"]) and arg_225_1.var_.characterEffect1026ui_story == nil then
				arg_225_1.var_.characterEffect1026ui_story = arg_225_1.actors_["1026ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_0 = 0.2

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 and not isNil(arg_225_1.actors_["1026ui_story"]) then
				if arg_225_1.var_.characterEffect1026ui_story and not isNil(arg_225_1.actors_["1026ui_story"]) then
					arg_225_1.var_.characterEffect1026ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1026ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_0)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 and not isNil(arg_225_1.actors_["1026ui_story"]) and arg_225_1.var_.characterEffect1026ui_story then
				arg_225_1.var_.characterEffect1026ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1026ui_story.fillRatio = 0.5
			end

			local var_228_1 = 0
			local var_228_2 = 0.7

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_3 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(102604055).content)

				arg_225_1.text_.text = var_228_3

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 28 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_3) / 28)

				if (28 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_3) / 28)) > 0 and var_228_2 < var_228_5 then
					arg_225_1.talkMaxDuration = var_228_5

					if var_228_5 + var_228_1 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + var_228_1
					end
				end

				arg_225_1.text_.text = var_228_3
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_6 = math.max(var_228_2, arg_225_1.talkMaxDuration)

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_6 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_1) / var_228_6

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_1 + var_228_6 and arg_225_1.time_ < var_228_1 + var_228_6 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play102604056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 102604056
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play102604057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos1026ui_story = arg_229_1.actors_["1026ui_story"].transform.localPosition
			end

			local var_232_0 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 then
				arg_229_1.actors_["1026ui_story"].transform.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1026ui_story, Vector3.New(0, 100, 0), (arg_229_1.time_ - 0) / var_232_0)
				arg_229_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1026ui_story"].transform.position).z)
				arg_229_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["1026ui_story"].transform.localEulerAngles = arg_229_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 then
				arg_229_1.actors_["1026ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_229_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1026ui_story"].transform.position).z)
				arg_229_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["1026ui_story"].transform.localEulerAngles = arg_229_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			local var_232_1 = 0
			local var_232_2 = 0.25

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, false)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_3 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(102604056).content)

				arg_229_1.text_.text = var_232_3

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 10 <= 0 and var_232_2 or var_232_2 * (utf8.len(var_232_3) / 10)

				if (10 <= 0 and var_232_2 or var_232_2 * (utf8.len(var_232_3) / 10)) > 0 and var_232_2 < var_232_5 then
					arg_229_1.talkMaxDuration = var_232_5

					if var_232_5 + var_232_1 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + var_232_1
					end
				end

				arg_229_1.text_.text = var_232_3
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_6 = math.max(var_232_2, arg_229_1.talkMaxDuration)

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_6 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_1) / var_232_6

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_1 + var_232_6 and arg_229_1.time_ < var_232_1 + var_232_6 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play102604057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 102604057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play102604058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0.3

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
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

				local var_236_1 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(102604057).content)

				arg_233_1.text_.text = var_236_1

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_3 = 12 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 12)

				if (12 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 12)) > 0 and var_236_0 < var_236_3 then
					arg_233_1.talkMaxDuration = var_236_3

					if var_236_3 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_3 + 0
					end
				end

				arg_233_1.text_.text = var_236_1
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_4 = math.max(var_236_0, arg_233_1.talkMaxDuration)

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_4 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - 0) / var_236_4

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= 0 + var_236_4 and arg_233_1.time_ < 0 + var_236_4 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play102604058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 102604058
		arg_237_1.duration_ = 2

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play102604059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos1026ui_story = arg_237_1.actors_["1026ui_story"].transform.localPosition
			end

			local var_240_0 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 then
				arg_237_1.actors_["1026ui_story"].transform.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1026ui_story, Vector3.New(0, -1.05, -6.2), (arg_237_1.time_ - 0) / var_240_0)
				arg_237_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1026ui_story"].transform.position).z)
				arg_237_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["1026ui_story"].transform.localEulerAngles = arg_237_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 then
				arg_237_1.actors_["1026ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.2)
				arg_237_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1026ui_story"].transform.position).z)
				arg_237_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["1026ui_story"].transform.localEulerAngles = arg_237_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			local var_240_1 = arg_237_1.actors_["1026ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect1026ui_story == nil then
				arg_237_1.var_.characterEffect1026ui_story = var_240_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.2

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_2 and not isNil(var_240_1) then
				if arg_237_1.var_.characterEffect1026ui_story and not isNil(var_240_1) then
					arg_237_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_2 and arg_237_1.time_ < 0 + var_240_2 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect1026ui_story then
				arg_237_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action1_1")
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_240_4 = 0
			local var_240_5 = 0.1

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_4 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_6 = arg_237_1:GetWordFromCfg(102604058)
				local var_240_7 = arg_237_1:FormatText(var_240_6.content)

				arg_237_1.text_.text = var_240_7

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_9 = 4 <= 0 and var_240_5 or var_240_5 * (utf8.len(var_240_7) / 4)

				if (4 <= 0 and var_240_5 or var_240_5 * (utf8.len(var_240_7) / 4)) > 0 and var_240_5 < var_240_9 then
					arg_237_1.talkMaxDuration = var_240_9

					if var_240_9 + var_240_4 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_9 + var_240_4
					end
				end

				arg_237_1.text_.text = var_240_7
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604058", "story_v_side_old_102604.awb") ~= 0 then
					local var_240_10 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604058", "story_v_side_old_102604.awb") / 1000

					if var_240_10 + var_240_4 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_10 + var_240_4
					end

					if var_240_6.prefab_name ~= "" and arg_237_1.actors_[var_240_6.prefab_name] ~= nil then
						local var_240_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_6.prefab_name].transform, "story_v_side_old_102604", "102604058", "story_v_side_old_102604.awb")

						arg_237_1:RecordAudio("102604058", var_240_11)
						arg_237_1:RecordAudio("102604058", var_240_11)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604058", "story_v_side_old_102604.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604058", "story_v_side_old_102604.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_12 = math.max(var_240_5, arg_237_1.talkMaxDuration)

			if var_240_4 <= arg_237_1.time_ and arg_237_1.time_ < var_240_4 + var_240_12 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_4) / var_240_12

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_4 + var_240_12 and arg_237_1.time_ < var_240_4 + var_240_12 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play102604059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 102604059
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play102604060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1026ui_story = arg_241_1.actors_["1026ui_story"].transform.localPosition
			end

			local var_244_0 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 then
				arg_241_1.actors_["1026ui_story"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1026ui_story, Vector3.New(0, 100, 0), (arg_241_1.time_ - 0) / var_244_0)
				arg_241_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1026ui_story"].transform.position).z)
				arg_241_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1026ui_story"].transform.localEulerAngles = arg_241_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 then
				arg_241_1.actors_["1026ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_241_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1026ui_story"].transform.position).z)
				arg_241_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1026ui_story"].transform.localEulerAngles = arg_241_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			local var_244_1 = 0
			local var_244_2 = 0.7

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_3 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(102604059).content)

				arg_241_1.text_.text = var_244_3

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_5 = 28 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_3) / 28)

				if (28 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_3) / 28)) > 0 and var_244_2 < var_244_5 then
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

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play102604060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 102604060
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play102604061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 1.675

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_1 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(102604060).content)

				arg_245_1.text_.text = var_248_1

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_3 = 67 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_1) / 67)

				if (67 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_1) / 67)) > 0 and var_248_0 < var_248_3 then
					arg_245_1.talkMaxDuration = var_248_3

					if var_248_3 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_3 + 0
					end
				end

				arg_245_1.text_.text = var_248_1
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_4 = math.max(var_248_0, arg_245_1.talkMaxDuration)

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_4 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - 0) / var_248_4

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= 0 + var_248_4 and arg_245_1.time_ < 0 + var_248_4 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play102604061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 102604061
		arg_249_1.duration_ = 4.83

		local var_249_0 = {
			ja = 3.9,
			ko = 3.733,
			zh = 4.833,
			en = 2.7
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play102604062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1026ui_story = arg_249_1.actors_["1026ui_story"].transform.localPosition
			end

			local var_252_0 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 then
				arg_249_1.actors_["1026ui_story"].transform.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1026ui_story, Vector3.New(0, -1.05, -6.2), (arg_249_1.time_ - 0) / var_252_0)
				arg_249_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1026ui_story"].transform.position).z)
				arg_249_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["1026ui_story"].transform.localEulerAngles = arg_249_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 then
				arg_249_1.actors_["1026ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.2)
				arg_249_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1026ui_story"].transform.position).z)
				arg_249_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["1026ui_story"].transform.localEulerAngles = arg_249_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			local var_252_1 = arg_249_1.actors_["1026ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect1026ui_story == nil then
				arg_249_1.var_.characterEffect1026ui_story = var_252_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.2

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_2 and not isNil(var_252_1) then
				if arg_249_1.var_.characterEffect1026ui_story and not isNil(var_252_1) then
					arg_249_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_2 and arg_249_1.time_ < 0 + var_252_2 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect1026ui_story then
				arg_249_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action7_1")
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_252_4 = 0
			local var_252_5 = 0.4

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_4 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_6 = arg_249_1:GetWordFromCfg(102604061)
				local var_252_7 = arg_249_1:FormatText(var_252_6.content)

				arg_249_1.text_.text = var_252_7

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_9 = 16 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 16)

				if (16 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 16)) > 0 and var_252_5 < var_252_9 then
					arg_249_1.talkMaxDuration = var_252_9

					if var_252_9 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_9 + var_252_4
					end
				end

				arg_249_1.text_.text = var_252_7
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604061", "story_v_side_old_102604.awb") ~= 0 then
					local var_252_10 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604061", "story_v_side_old_102604.awb") / 1000

					if var_252_10 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_10 + var_252_4
					end

					if var_252_6.prefab_name ~= "" and arg_249_1.actors_[var_252_6.prefab_name] ~= nil then
						local var_252_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_6.prefab_name].transform, "story_v_side_old_102604", "102604061", "story_v_side_old_102604.awb")

						arg_249_1:RecordAudio("102604061", var_252_11)
						arg_249_1:RecordAudio("102604061", var_252_11)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604061", "story_v_side_old_102604.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604061", "story_v_side_old_102604.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_12 = math.max(var_252_5, arg_249_1.talkMaxDuration)

			if var_252_4 <= arg_249_1.time_ and arg_249_1.time_ < var_252_4 + var_252_12 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_4) / var_252_12

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_4 + var_252_12 and arg_249_1.time_ < var_252_4 + var_252_12 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play102604062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 102604062
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play102604063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1026ui_story = arg_253_1.actors_["1026ui_story"].transform.localPosition
			end

			local var_256_0 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 then
				arg_253_1.actors_["1026ui_story"].transform.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1026ui_story, Vector3.New(0, 100, 0), (arg_253_1.time_ - 0) / var_256_0)
				arg_253_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1026ui_story"].transform.position).z)
				arg_253_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1026ui_story"].transform.localEulerAngles = arg_253_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 then
				arg_253_1.actors_["1026ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_253_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1026ui_story"].transform.position).z)
				arg_253_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1026ui_story"].transform.localEulerAngles = arg_253_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			local var_256_1 = 0
			local var_256_2 = 0.05

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[7].name)

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

				local var_256_3 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(102604062).content)

				arg_253_1.text_.text = var_256_3

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_5 = 2 <= 0 and var_256_2 or var_256_2 * (utf8.len(var_256_3) / 2)

				if (2 <= 0 and var_256_2 or var_256_2 * (utf8.len(var_256_3) / 2)) > 0 and var_256_2 < var_256_5 then
					arg_253_1.talkMaxDuration = var_256_5

					if var_256_5 + var_256_1 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_5 + var_256_1
					end
				end

				arg_253_1.text_.text = var_256_3
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_6 = math.max(var_256_2, arg_253_1.talkMaxDuration)

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_6 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_1) / var_256_6

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_1 + var_256_6 and arg_253_1.time_ < var_256_1 + var_256_6 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play102604063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 102604063
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play102604064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0.6

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_1 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(102604063).content)

				arg_257_1.text_.text = var_260_1

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_3 = 24 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 24)

				if (24 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 24)) > 0 and var_260_0 < var_260_3 then
					arg_257_1.talkMaxDuration = var_260_3

					if var_260_3 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_3 + 0
					end
				end

				arg_257_1.text_.text = var_260_1
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_4 = math.max(var_260_0, arg_257_1.talkMaxDuration)

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_4 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - 0) / var_260_4

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= 0 + var_260_4 and arg_257_1.time_ < 0 + var_260_4 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play102604064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 102604064
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play102604065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0.275

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
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

				local var_264_1 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(102604064).content)

				arg_261_1.text_.text = var_264_1

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_3 = 10 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 10)

				if (10 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 10)) > 0 and var_264_0 < var_264_3 then
					arg_261_1.talkMaxDuration = var_264_3

					if var_264_3 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_3 + 0
					end
				end

				arg_261_1.text_.text = var_264_1
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_4 = math.max(var_264_0, arg_261_1.talkMaxDuration)

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_4 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - 0) / var_264_4

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= 0 + var_264_4 and arg_261_1.time_ < 0 + var_264_4 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play102604065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 102604065
		arg_265_1.duration_ = 7.65

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play102604066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 1.5 < arg_265_1.time_ and arg_265_1.time_ <= 1.5 + arg_268_0 then
				local var_268_0 = arg_265_1.bgs_.B01c

				arg_265_1.bgs_.B01c.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_268_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_268_1 = var_268_0:GetComponent("SpriteRenderer")

				if var_268_1 and var_268_1.sprite then
					local var_268_2 = 2 * (var_268_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_268_0.transform.localScale = Vector3.New(var_268_2 / var_268_1.sprite.bounds.size.y < var_268_2 * manager.ui.mainCameraCom_.aspect / var_268_1.sprite.bounds.size.x and var_268_2 * manager.ui.mainCameraCom_.aspect / var_268_1.sprite.bounds.size.x or var_268_2 / var_268_1.sprite.bounds.size.y, var_268_2 / var_268_1.sprite.bounds.size.y < var_268_2 * manager.ui.mainCameraCom_.aspect / var_268_1.sprite.bounds.size.x and var_268_2 * manager.ui.mainCameraCom_.aspect / var_268_1.sprite.bounds.size.x or var_268_2 / var_268_1.sprite.bounds.size.y, 0)
				end

				for iter_268_0, iter_268_1 in pairs(arg_265_1.bgs_) do
					if iter_268_0 ~= "B01c" then
						iter_268_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				local var_268_3 = arg_265_1.bgs_.ST04a:GetComponent("SpriteRenderer")

				if var_268_3 then
					arg_265_1.var_.alphaOldValueST04a = var_268_3.color.a
					arg_265_1.var_.alphaMatValueST04a = var_268_3
				end

				arg_265_1.var_.alphaOldValueST04a = 1
			end

			local var_268_4 = 1.5

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_4 then
				if arg_265_1.var_.alphaMatValueST04a then
					arg_265_1.var_.alphaMatValueST04a.color.a = Mathf.Lerp(arg_265_1.var_.alphaOldValueST04a, 0, (arg_265_1.time_ - 0) / var_268_4)
					arg_265_1.var_.alphaMatValueST04a.color = arg_265_1.var_.alphaMatValueST04a.color
				end
			end

			if arg_265_1.time_ >= 0 + var_268_4 and arg_265_1.time_ < 0 + var_268_4 + arg_268_0 and arg_265_1.var_.alphaMatValueST04a then
				arg_265_1.var_.alphaMatValueST04a.color.a = 0
				arg_265_1.var_.alphaMatValueST04a.color = arg_265_1.var_.alphaMatValueST04a.color
			end

			if 1.5 < arg_265_1.time_ and arg_265_1.time_ <= 1.5 + arg_268_0 then
				local var_268_5 = arg_265_1.bgs_.B01c:GetComponent("SpriteRenderer")

				if var_268_5 then
					arg_265_1.var_.alphaOldValueB01c = var_268_5.color.a
					arg_265_1.var_.alphaMatValueB01c = var_268_5
				end

				arg_265_1.var_.alphaOldValueB01c = 0
			end

			local var_268_6 = 1.5

			if 1.5 <= arg_265_1.time_ and arg_265_1.time_ < 1.5 + var_268_6 then
				if arg_265_1.var_.alphaMatValueB01c then
					arg_265_1.var_.alphaMatValueB01c.color.a = Mathf.Lerp(arg_265_1.var_.alphaOldValueB01c, 1, (arg_265_1.time_ - 1.5) / var_268_6)
					arg_265_1.var_.alphaMatValueB01c.color = arg_265_1.var_.alphaMatValueB01c.color
				end
			end

			if arg_265_1.time_ >= 1.5 + var_268_6 and arg_265_1.time_ < 1.5 + var_268_6 + arg_268_0 and arg_265_1.var_.alphaMatValueB01c then
				arg_265_1.var_.alphaMatValueB01c.color.a = 1
				arg_265_1.var_.alphaMatValueB01c.color = arg_265_1.var_.alphaMatValueB01c.color
			end

			local var_268_7 = 0

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_7 + arg_268_0 then
				arg_265_1.allBtn_.enabled = false
			end

			if arg_265_1.time_ >= var_268_7 + 2.65 and arg_265_1.time_ < var_268_7 + 2.65 + arg_268_0 then
				arg_265_1.allBtn_.enabled = true
			end

			if arg_265_1.frameCnt_ <= 1 then
				arg_265_1.dialog_:SetActive(false)
			end

			local var_268_8 = 2.65
			local var_268_9 = 0.35

			if 2.65 < arg_265_1.time_ and arg_265_1.time_ <= var_268_8 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0

				arg_265_1.dialog_:SetActive(true)

				arg_265_1.dialogCg_.alpha = 0

				local var_268_10 = LeanTween.value(arg_265_1.dialog_, 0, 1, 0.3)

				var_268_10:setOnUpdate(LuaHelper.FloatAction(function(arg_269_0)
					arg_265_1.dialogCg_.alpha = arg_269_0
				end))
				var_268_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_265_1.dialog_)
					var_268_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_265_1.duration_ = arg_265_1.duration_ + 0.3

				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_11 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(102604065).content)

				arg_265_1.text_.text = var_268_11

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_13 = 14 <= 0 and var_268_9 or var_268_9 * (utf8.len(var_268_11) / 14)

				if (14 <= 0 and var_268_9 or var_268_9 * (utf8.len(var_268_11) / 14)) > 0 and var_268_9 < var_268_13 then
					arg_265_1.talkMaxDuration = var_268_13
					var_268_8 = var_268_8 + 0.3

					if var_268_13 + var_268_8 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_13 + var_268_8
					end
				end

				arg_265_1.text_.text = var_268_11
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_14 = var_268_8 + 0.3
			local var_268_15 = math.max(var_268_9, arg_265_1.talkMaxDuration)

			if var_268_8 + 0.3 <= arg_265_1.time_ and arg_265_1.time_ < var_268_14 + var_268_15 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_14) / var_268_15

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_14 + var_268_15 and arg_265_1.time_ < var_268_14 + var_268_15 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play102604066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 102604066
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play102604067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0.8

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, false)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_1 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(102604066).content)

				arg_271_1.text_.text = var_274_1

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_3 = 32 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 32)

				if (32 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 32)) > 0 and var_274_0 < var_274_3 then
					arg_271_1.talkMaxDuration = var_274_3

					if var_274_3 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_3 + 0
					end
				end

				arg_271_1.text_.text = var_274_1
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_4 = math.max(var_274_0, arg_271_1.talkMaxDuration)

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_4 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - 0) / var_274_4

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= 0 + var_274_4 and arg_271_1.time_ < 0 + var_274_4 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play102604067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 102604067
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play102604068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 1.225

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_1 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(102604067).content)

				arg_275_1.text_.text = var_278_1

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_3 = 49 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_1) / 49)

				if (49 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_1) / 49)) > 0 and var_278_0 < var_278_3 then
					arg_275_1.talkMaxDuration = var_278_3

					if var_278_3 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_3 + 0
					end
				end

				arg_275_1.text_.text = var_278_1
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_4 = math.max(var_278_0, arg_275_1.talkMaxDuration)

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_4 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - 0) / var_278_4

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= 0 + var_278_4 and arg_275_1.time_ < 0 + var_278_4 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play102604068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 102604068
		arg_279_1.duration_ = 5.03

		local var_279_0 = {
			ja = 3.433,
			ko = 3.5,
			zh = 4,
			en = 5.033
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play102604069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 0.2

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, true)
				arg_279_1.iconController_:SetSelectedState("hero")

				arg_279_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1026")

				arg_279_1.callingController_:SetSelectedState("normal")

				arg_279_1.keyicon_.color = Color.New(1, 1, 1)
				arg_279_1.icon_.color = Color.New(1, 1, 1)

				local var_282_1 = arg_279_1:GetWordFromCfg(102604068)
				local var_282_2 = arg_279_1:FormatText(var_282_1.content)

				arg_279_1.text_.text = var_282_2

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_4 = 8 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_2) / 8)

				if (8 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_2) / 8)) > 0 and var_282_0 < var_282_4 then
					arg_279_1.talkMaxDuration = var_282_4

					if var_282_4 + 0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_4 + 0
					end
				end

				arg_279_1.text_.text = var_282_2
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604068", "story_v_side_old_102604.awb") ~= 0 then
					local var_282_5 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604068", "story_v_side_old_102604.awb") / 1000

					if var_282_5 + 0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_5 + 0
					end

					if var_282_1.prefab_name ~= "" and arg_279_1.actors_[var_282_1.prefab_name] ~= nil then
						local var_282_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_1.prefab_name].transform, "story_v_side_old_102604", "102604068", "story_v_side_old_102604.awb")

						arg_279_1:RecordAudio("102604068", var_282_6)
						arg_279_1:RecordAudio("102604068", var_282_6)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604068", "story_v_side_old_102604.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604068", "story_v_side_old_102604.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_7 = math.max(var_282_0, arg_279_1.talkMaxDuration)

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_7 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - 0) / var_282_7

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= 0 + var_282_7 and arg_279_1.time_ < 0 + var_282_7 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play102604069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 102604069
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play102604070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 0.25

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, true)
				arg_283_1.iconController_:SetSelectedState("hero")

				arg_283_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_283_1.callingController_:SetSelectedState("normal")

				arg_283_1.keyicon_.color = Color.New(1, 1, 1)
				arg_283_1.icon_.color = Color.New(1, 1, 1)

				local var_286_1 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(102604069).content)

				arg_283_1.text_.text = var_286_1

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_3 = 10 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 10)

				if (10 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 10)) > 0 and var_286_0 < var_286_3 then
					arg_283_1.talkMaxDuration = var_286_3

					if var_286_3 + 0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_3 + 0
					end
				end

				arg_283_1.text_.text = var_286_1
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_4 = math.max(var_286_0, arg_283_1.talkMaxDuration)

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_4 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - 0) / var_286_4

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= 0 + var_286_4 and arg_283_1.time_ < 0 + var_286_4 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play102604070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 102604070
		arg_287_1.duration_ = 10.57

		local var_287_0 = {
			ja = 8.9,
			ko = 6.866,
			zh = 6.7,
			en = 10.566
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play102604071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0.65

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, true)
				arg_287_1.iconController_:SetSelectedState("hero")

				arg_287_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1026")

				arg_287_1.callingController_:SetSelectedState("normal")

				arg_287_1.keyicon_.color = Color.New(1, 1, 1)
				arg_287_1.icon_.color = Color.New(1, 1, 1)

				local var_290_1 = arg_287_1:GetWordFromCfg(102604070)
				local var_290_2 = arg_287_1:FormatText(var_290_1.content)

				arg_287_1.text_.text = var_290_2

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_4 = 26 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 26)

				if (26 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 26)) > 0 and var_290_0 < var_290_4 then
					arg_287_1.talkMaxDuration = var_290_4

					if var_290_4 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_4 + 0
					end
				end

				arg_287_1.text_.text = var_290_2
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604070", "story_v_side_old_102604.awb") ~= 0 then
					local var_290_5 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604070", "story_v_side_old_102604.awb") / 1000

					if var_290_5 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_5 + 0
					end

					if var_290_1.prefab_name ~= "" and arg_287_1.actors_[var_290_1.prefab_name] ~= nil then
						local var_290_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_1.prefab_name].transform, "story_v_side_old_102604", "102604070", "story_v_side_old_102604.awb")

						arg_287_1:RecordAudio("102604070", var_290_6)
						arg_287_1:RecordAudio("102604070", var_290_6)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604070", "story_v_side_old_102604.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604070", "story_v_side_old_102604.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_7 = math.max(var_290_0, arg_287_1.talkMaxDuration)

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_7 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - 0) / var_290_7

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= 0 + var_290_7 and arg_287_1.time_ < 0 + var_290_7 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play102604071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 102604071
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play102604072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0.45

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, true)
				arg_291_1.iconController_:SetSelectedState("hero")

				arg_291_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_291_1.callingController_:SetSelectedState("normal")

				arg_291_1.keyicon_.color = Color.New(1, 1, 1)
				arg_291_1.icon_.color = Color.New(1, 1, 1)

				local var_294_1 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(102604071).content)

				arg_291_1.text_.text = var_294_1

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_3 = 18 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_1) / 18)

				if (18 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_1) / 18)) > 0 and var_294_0 < var_294_3 then
					arg_291_1.talkMaxDuration = var_294_3

					if var_294_3 + 0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_3 + 0
					end
				end

				arg_291_1.text_.text = var_294_1
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_4 = math.max(var_294_0, arg_291_1.talkMaxDuration)

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_4 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - 0) / var_294_4

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= 0 + var_294_4 and arg_291_1.time_ < 0 + var_294_4 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play102604072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 102604072
		arg_295_1.duration_ = 5.13

		local var_295_0 = {
			ja = 5.133,
			ko = 3.1,
			zh = 2.2,
			en = 3.166
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play102604073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0.15

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_1 = arg_295_1:GetWordFromCfg(102604072)
				local var_298_2 = arg_295_1:FormatText(var_298_1.content)

				arg_295_1.text_.text = var_298_2

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_4 = 6 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_2) / 6)

				if (6 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_2) / 6)) > 0 and var_298_0 < var_298_4 then
					arg_295_1.talkMaxDuration = var_298_4

					if var_298_4 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_4 + 0
					end
				end

				arg_295_1.text_.text = var_298_2
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604072", "story_v_side_old_102604.awb") ~= 0 then
					local var_298_5 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604072", "story_v_side_old_102604.awb") / 1000

					if var_298_5 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_5 + 0
					end

					if var_298_1.prefab_name ~= "" and arg_295_1.actors_[var_298_1.prefab_name] ~= nil then
						local var_298_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_1.prefab_name].transform, "story_v_side_old_102604", "102604072", "story_v_side_old_102604.awb")

						arg_295_1:RecordAudio("102604072", var_298_6)
						arg_295_1:RecordAudio("102604072", var_298_6)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604072", "story_v_side_old_102604.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604072", "story_v_side_old_102604.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_7 = math.max(var_298_0, arg_295_1.talkMaxDuration)

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_7 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - 0) / var_298_7

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= 0 + var_298_7 and arg_295_1.time_ < 0 + var_298_7 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play102604073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 102604073
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play102604074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 1.15

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, false)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_1 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(102604073).content)

				arg_299_1.text_.text = var_302_1

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_3 = 46 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 46)

				if (46 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 46)) > 0 and var_302_0 < var_302_3 then
					arg_299_1.talkMaxDuration = var_302_3

					if var_302_3 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_3 + 0
					end
				end

				arg_299_1.text_.text = var_302_1
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_4 = math.max(var_302_0, arg_299_1.talkMaxDuration)

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_4 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - 0) / var_302_4

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= 0 + var_302_4 and arg_299_1.time_ < 0 + var_302_4 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play102604074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 102604074
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play102604075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 1.4

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_1 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(102604074).content)

				arg_303_1.text_.text = var_306_1

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_3 = 56 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 56)

				if (56 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 56)) > 0 and var_306_0 < var_306_3 then
					arg_303_1.talkMaxDuration = var_306_3

					if var_306_3 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_3 + 0
					end
				end

				arg_303_1.text_.text = var_306_1
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_4 = math.max(var_306_0, arg_303_1.talkMaxDuration)

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_4 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - 0) / var_306_4

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= 0 + var_306_4 and arg_303_1.time_ < 0 + var_306_4 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play102604075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 102604075
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play102604076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 1.25

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_1 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(102604075).content)

				arg_307_1.text_.text = var_310_1

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_3 = 50 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_1) / 50)

				if (50 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_1) / 50)) > 0 and var_310_0 < var_310_3 then
					arg_307_1.talkMaxDuration = var_310_3

					if var_310_3 + 0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_3 + 0
					end
				end

				arg_307_1.text_.text = var_310_1
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_4 = math.max(var_310_0, arg_307_1.talkMaxDuration)

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_4 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - 0) / var_310_4

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= 0 + var_310_4 and arg_307_1.time_ < 0 + var_310_4 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play102604076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 102604076
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play102604077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0.525

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, false)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_1 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(102604076).content)

				arg_311_1.text_.text = var_314_1

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_3 = 21 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 21)

				if (21 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 21)) > 0 and var_314_0 < var_314_3 then
					arg_311_1.talkMaxDuration = var_314_3

					if var_314_3 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_3 + 0
					end
				end

				arg_311_1.text_.text = var_314_1
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_4 = math.max(var_314_0, arg_311_1.talkMaxDuration)

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_4 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - 0) / var_314_4

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= 0 + var_314_4 and arg_311_1.time_ < 0 + var_314_4 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play102604077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 102604077
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play102604078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0.65

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, false)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_1 = arg_315_1:FormatText(arg_315_1:GetWordFromCfg(102604077).content)

				arg_315_1.text_.text = var_318_1

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_3 = 26 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_1) / 26)

				if (26 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_1) / 26)) > 0 and var_318_0 < var_318_3 then
					arg_315_1.talkMaxDuration = var_318_3

					if var_318_3 + 0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_3 + 0
					end
				end

				arg_315_1.text_.text = var_318_1
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_4 = math.max(var_318_0, arg_315_1.talkMaxDuration)

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_4 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - 0) / var_318_4

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= 0 + var_318_4 and arg_315_1.time_ < 0 + var_318_4 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play102604078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 102604078
		arg_319_1.duration_ = 3.03

		local var_319_0 = {
			ja = 3.033,
			ko = 2,
			zh = 1.6,
			en = 2.133
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play102604079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 0.175

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[199].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, true)
				arg_319_1.iconController_:SetSelectedState("hero")

				arg_319_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboyb")

				arg_319_1.callingController_:SetSelectedState("normal")

				arg_319_1.keyicon_.color = Color.New(1, 1, 1)
				arg_319_1.icon_.color = Color.New(1, 1, 1)

				local var_322_1 = arg_319_1:GetWordFromCfg(102604078)
				local var_322_2 = arg_319_1:FormatText(var_322_1.content)

				arg_319_1.text_.text = var_322_2

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_4 = 7 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_2) / 7)

				if (7 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_2) / 7)) > 0 and var_322_0 < var_322_4 then
					arg_319_1.talkMaxDuration = var_322_4

					if var_322_4 + 0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_4 + 0
					end
				end

				arg_319_1.text_.text = var_322_2
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604078", "story_v_side_old_102604.awb") ~= 0 then
					local var_322_5 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604078", "story_v_side_old_102604.awb") / 1000

					if var_322_5 + 0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_5 + 0
					end

					if var_322_1.prefab_name ~= "" and arg_319_1.actors_[var_322_1.prefab_name] ~= nil then
						local var_322_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_1.prefab_name].transform, "story_v_side_old_102604", "102604078", "story_v_side_old_102604.awb")

						arg_319_1:RecordAudio("102604078", var_322_6)
						arg_319_1:RecordAudio("102604078", var_322_6)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604078", "story_v_side_old_102604.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604078", "story_v_side_old_102604.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_7 = math.max(var_322_0, arg_319_1.talkMaxDuration)

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_7 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - 0) / var_322_7

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= 0 + var_322_7 and arg_319_1.time_ < 0 + var_322_7 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play102604079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 102604079
		arg_323_1.duration_ = 6.03

		local var_323_0 = {
			ja = 6.033,
			ko = 4,
			zh = 4.5,
			en = 2.733
		}
		local var_323_1 = manager.audio:GetLocalizationFlag()

		if var_323_0[var_323_1] ~= nil then
			arg_323_1.duration_ = var_323_0[var_323_1]
		end

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play102604080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_326_0 = 0.6

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 then
				local var_326_1, var_326_2 = math.modf((arg_323_1.time_ - 0) / 0)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_326_2 * 0, var_326_2 * 0, var_326_2 * 0) + arg_323_1.var_.shakeOldPos
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 then
				manager.ui.mainCamera.transform.localPosition = arg_323_1.var_.shakeOldPos
			end

			local var_326_3 = 0
			local var_326_4 = 0.55

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_3 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[200].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, true)
				arg_323_1.iconController_:SetSelectedState("hero")

				arg_323_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_323_1.callingController_:SetSelectedState("normal")

				arg_323_1.keyicon_.color = Color.New(1, 1, 1)
				arg_323_1.icon_.color = Color.New(1, 1, 1)

				local var_326_5 = arg_323_1:GetWordFromCfg(102604079)
				local var_326_6 = arg_323_1:FormatText(var_326_5.content)

				arg_323_1.text_.text = var_326_6

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_8 = 22 <= 0 and var_326_4 or var_326_4 * (utf8.len(var_326_6) / 22)

				if (22 <= 0 and var_326_4 or var_326_4 * (utf8.len(var_326_6) / 22)) > 0 and var_326_4 < var_326_8 then
					arg_323_1.talkMaxDuration = var_326_8

					if var_326_8 + var_326_3 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_8 + var_326_3
					end
				end

				arg_323_1.text_.text = var_326_6
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604079", "story_v_side_old_102604.awb") ~= 0 then
					local var_326_9 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604079", "story_v_side_old_102604.awb") / 1000

					if var_326_9 + var_326_3 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_9 + var_326_3
					end

					if var_326_5.prefab_name ~= "" and arg_323_1.actors_[var_326_5.prefab_name] ~= nil then
						local var_326_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_5.prefab_name].transform, "story_v_side_old_102604", "102604079", "story_v_side_old_102604.awb")

						arg_323_1:RecordAudio("102604079", var_326_10)
						arg_323_1:RecordAudio("102604079", var_326_10)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604079", "story_v_side_old_102604.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604079", "story_v_side_old_102604.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_11 = math.max(var_326_4, arg_323_1.talkMaxDuration)

			if var_326_3 <= arg_323_1.time_ and arg_323_1.time_ < var_326_3 + var_326_11 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_3) / var_326_11

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_3 + var_326_11 and arg_323_1.time_ < var_326_3 + var_326_11 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play102604080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 102604080
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play102604081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1:AudioAction("play", "effect", "se_story_side_1026", "se_story_1026_slap", "")
			end

			local var_330_1 = 0
			local var_330_2 = 0.45

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, false)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_3 = arg_327_1:FormatText(arg_327_1:GetWordFromCfg(102604080).content)

				arg_327_1.text_.text = var_330_3

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_5 = 22 <= 0 and var_330_2 or var_330_2 * (utf8.len(var_330_3) / 22)

				if (22 <= 0 and var_330_2 or var_330_2 * (utf8.len(var_330_3) / 22)) > 0 and var_330_2 < var_330_5 then
					arg_327_1.talkMaxDuration = var_330_5

					if var_330_5 + var_330_1 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_5 + var_330_1
					end
				end

				arg_327_1.text_.text = var_330_3
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_6 = math.max(var_330_2, arg_327_1.talkMaxDuration)

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_6 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_1) / var_330_6

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_1 + var_330_6 and arg_327_1.time_ < var_330_1 + var_330_6 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play102604081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 102604081
		arg_331_1.duration_ = 9.47

		local var_331_0 = {
			ja = 9.466,
			ko = 5.3,
			zh = 6.333,
			en = 7.866
		}
		local var_331_1 = manager.audio:GetLocalizationFlag()

		if var_331_0[var_331_1] ~= nil then
			arg_331_1.duration_ = var_331_0[var_331_1]
		end

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play102604082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 0.675

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[199].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, true)
				arg_331_1.iconController_:SetSelectedState("hero")

				arg_331_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboyb")

				arg_331_1.callingController_:SetSelectedState("normal")

				arg_331_1.keyicon_.color = Color.New(1, 1, 1)
				arg_331_1.icon_.color = Color.New(1, 1, 1)

				local var_334_1 = arg_331_1:GetWordFromCfg(102604081)
				local var_334_2 = arg_331_1:FormatText(var_334_1.content)

				arg_331_1.text_.text = var_334_2

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_4 = 27 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_2) / 27)

				if (27 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_2) / 27)) > 0 and var_334_0 < var_334_4 then
					arg_331_1.talkMaxDuration = var_334_4

					if var_334_4 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_4 + 0
					end
				end

				arg_331_1.text_.text = var_334_2
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604081", "story_v_side_old_102604.awb") ~= 0 then
					local var_334_5 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604081", "story_v_side_old_102604.awb") / 1000

					if var_334_5 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_5 + 0
					end

					if var_334_1.prefab_name ~= "" and arg_331_1.actors_[var_334_1.prefab_name] ~= nil then
						local var_334_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_1.prefab_name].transform, "story_v_side_old_102604", "102604081", "story_v_side_old_102604.awb")

						arg_331_1:RecordAudio("102604081", var_334_6)
						arg_331_1:RecordAudio("102604081", var_334_6)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604081", "story_v_side_old_102604.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604081", "story_v_side_old_102604.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_7 = math.max(var_334_0, arg_331_1.talkMaxDuration)

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_7 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - 0) / var_334_7

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= 0 + var_334_7 and arg_331_1.time_ < 0 + var_334_7 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play102604082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 102604082
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play102604083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 0.775

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, false)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_1 = arg_335_1:FormatText(arg_335_1:GetWordFromCfg(102604082).content)

				arg_335_1.text_.text = var_338_1

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_3 = 33 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_1) / 33)

				if (33 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_1) / 33)) > 0 and var_338_0 < var_338_3 then
					arg_335_1.talkMaxDuration = var_338_3

					if var_338_3 + 0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_3 + 0
					end
				end

				arg_335_1.text_.text = var_338_1
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_4 = math.max(var_338_0, arg_335_1.talkMaxDuration)

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_4 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - 0) / var_338_4

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= 0 + var_338_4 and arg_335_1.time_ < 0 + var_338_4 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play102604083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 102604083
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play102604084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 0.05

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, true)
				arg_339_1.iconController_:SetSelectedState("hero")

				arg_339_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_339_1.callingController_:SetSelectedState("normal")

				arg_339_1.keyicon_.color = Color.New(1, 1, 1)
				arg_339_1.icon_.color = Color.New(1, 1, 1)

				local var_342_1 = arg_339_1:FormatText(arg_339_1:GetWordFromCfg(102604083).content)

				arg_339_1.text_.text = var_342_1

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_3 = 2 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_1) / 2)

				if (2 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_1) / 2)) > 0 and var_342_0 < var_342_3 then
					arg_339_1.talkMaxDuration = var_342_3

					if var_342_3 + 0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_3 + 0
					end
				end

				arg_339_1.text_.text = var_342_1
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_4 = math.max(var_342_0, arg_339_1.talkMaxDuration)

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_4 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - 0) / var_342_4

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= 0 + var_342_4 and arg_339_1.time_ < 0 + var_342_4 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play102604084 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 102604084
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play102604085(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 0.05

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, false)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_1 = arg_343_1:FormatText(arg_343_1:GetWordFromCfg(102604084).content)

				arg_343_1.text_.text = var_346_1

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_3 = 2 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_1) / 2)

				if (2 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_1) / 2)) > 0 and var_346_0 < var_346_3 then
					arg_343_1.talkMaxDuration = var_346_3

					if var_346_3 + 0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_3 + 0
					end
				end

				arg_343_1.text_.text = var_346_1
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_4 = math.max(var_346_0, arg_343_1.talkMaxDuration)

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_4 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - 0) / var_346_4

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= 0 + var_346_4 and arg_343_1.time_ < 0 + var_346_4 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play102604085 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 102604085
		arg_347_1.duration_ = 5

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play102604086(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 0.175

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, false)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_1 = arg_347_1:FormatText(arg_347_1:GetWordFromCfg(102604085).content)

				arg_347_1.text_.text = var_350_1

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_3 = 7 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_1) / 7)

				if (7 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_1) / 7)) > 0 and var_350_0 < var_350_3 then
					arg_347_1.talkMaxDuration = var_350_3

					if var_350_3 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_3 + 0
					end
				end

				arg_347_1.text_.text = var_350_1
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)
				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_4 = math.max(var_350_0, arg_347_1.talkMaxDuration)

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_4 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - 0) / var_350_4

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= 0 + var_350_4 and arg_347_1.time_ < 0 + var_350_4 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play102604086 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 102604086
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play102604087(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 0.45

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, false)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_1 = arg_351_1:FormatText(arg_351_1:GetWordFromCfg(102604086).content)

				arg_351_1.text_.text = var_354_1

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_3 = 20 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_1) / 20)

				if (20 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_1) / 20)) > 0 and var_354_0 < var_354_3 then
					arg_351_1.talkMaxDuration = var_354_3

					if var_354_3 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_3 + 0
					end
				end

				arg_351_1.text_.text = var_354_1
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_4 = math.max(var_354_0, arg_351_1.talkMaxDuration)

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_4 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - 0) / var_354_4

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= 0 + var_354_4 and arg_351_1.time_ < 0 + var_354_4 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play102604087 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 102604087
		arg_355_1.duration_ = 4.33

		local var_355_0 = {
			ja = 4.333,
			ko = 1.633,
			zh = 2.933,
			en = 2.533
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play102604088(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 0.15

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[200].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, true)
				arg_355_1.iconController_:SetSelectedState("hero")

				arg_355_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_355_1.callingController_:SetSelectedState("normal")

				arg_355_1.keyicon_.color = Color.New(1, 1, 1)
				arg_355_1.icon_.color = Color.New(1, 1, 1)

				local var_358_1 = arg_355_1:GetWordFromCfg(102604087)
				local var_358_2 = arg_355_1:FormatText(var_358_1.content)

				arg_355_1.text_.text = var_358_2

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_4 = 6 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_2) / 6)

				if (6 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_2) / 6)) > 0 and var_358_0 < var_358_4 then
					arg_355_1.talkMaxDuration = var_358_4

					if var_358_4 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_4 + 0
					end
				end

				arg_355_1.text_.text = var_358_2
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604087", "story_v_side_old_102604.awb") ~= 0 then
					local var_358_5 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604087", "story_v_side_old_102604.awb") / 1000

					if var_358_5 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_5 + 0
					end

					if var_358_1.prefab_name ~= "" and arg_355_1.actors_[var_358_1.prefab_name] ~= nil then
						local var_358_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_1.prefab_name].transform, "story_v_side_old_102604", "102604087", "story_v_side_old_102604.awb")

						arg_355_1:RecordAudio("102604087", var_358_6)
						arg_355_1:RecordAudio("102604087", var_358_6)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604087", "story_v_side_old_102604.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604087", "story_v_side_old_102604.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_7 = math.max(var_358_0, arg_355_1.talkMaxDuration)

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_7 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - 0) / var_358_7

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= 0 + var_358_7 and arg_355_1.time_ < 0 + var_358_7 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play102604088 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 102604088
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play102604089(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:AudioAction("play", "effect", "se_story_side_1026", "se_story_1026_bones", "")
			end

			local var_362_1 = 0
			local var_362_2 = 0.7

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, false)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_3 = arg_359_1:FormatText(arg_359_1:GetWordFromCfg(102604088).content)

				arg_359_1.text_.text = var_362_3

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_5 = 28 <= 0 and var_362_2 or var_362_2 * (utf8.len(var_362_3) / 28)

				if (28 <= 0 and var_362_2 or var_362_2 * (utf8.len(var_362_3) / 28)) > 0 and var_362_2 < var_362_5 then
					arg_359_1.talkMaxDuration = var_362_5

					if var_362_5 + var_362_1 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_5 + var_362_1
					end
				end

				arg_359_1.text_.text = var_362_3
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_6 = math.max(var_362_2, arg_359_1.talkMaxDuration)

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_6 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_1) / var_362_6

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_1 + var_362_6 and arg_359_1.time_ < var_362_1 + var_362_6 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play102604089 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 102604089
		arg_363_1.duration_ = 5.7

		local var_363_0 = {
			ja = 5.7,
			ko = 2.866,
			zh = 3.633,
			en = 5.5
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play102604090(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 0.25

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[200].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, true)
				arg_363_1.iconController_:SetSelectedState("hero")

				arg_363_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_363_1.callingController_:SetSelectedState("normal")

				arg_363_1.keyicon_.color = Color.New(1, 1, 1)
				arg_363_1.icon_.color = Color.New(1, 1, 1)

				local var_366_1 = arg_363_1:GetWordFromCfg(102604089)
				local var_366_2 = arg_363_1:FormatText(var_366_1.content)

				arg_363_1.text_.text = var_366_2

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_4 = 10 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_2) / 10)

				if (10 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_2) / 10)) > 0 and var_366_0 < var_366_4 then
					arg_363_1.talkMaxDuration = var_366_4

					if var_366_4 + 0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_4 + 0
					end
				end

				arg_363_1.text_.text = var_366_2
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604089", "story_v_side_old_102604.awb") ~= 0 then
					local var_366_5 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604089", "story_v_side_old_102604.awb") / 1000

					if var_366_5 + 0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_5 + 0
					end

					if var_366_1.prefab_name ~= "" and arg_363_1.actors_[var_366_1.prefab_name] ~= nil then
						local var_366_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_1.prefab_name].transform, "story_v_side_old_102604", "102604089", "story_v_side_old_102604.awb")

						arg_363_1:RecordAudio("102604089", var_366_6)
						arg_363_1:RecordAudio("102604089", var_366_6)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604089", "story_v_side_old_102604.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604089", "story_v_side_old_102604.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_7 = math.max(var_366_0, arg_363_1.talkMaxDuration)

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_7 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - 0) / var_366_7

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= 0 + var_366_7 and arg_363_1.time_ < 0 + var_366_7 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play102604090 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 102604090
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play102604091(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 0.925

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, false)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_1 = arg_367_1:FormatText(arg_367_1:GetWordFromCfg(102604090).content)

				arg_367_1.text_.text = var_370_1

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_3 = 37 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_1) / 37)

				if (37 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_1) / 37)) > 0 and var_370_0 < var_370_3 then
					arg_367_1.talkMaxDuration = var_370_3

					if var_370_3 + 0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_3 + 0
					end
				end

				arg_367_1.text_.text = var_370_1
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_4 = math.max(var_370_0, arg_367_1.talkMaxDuration)

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_4 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - 0) / var_370_4

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= 0 + var_370_4 and arg_367_1.time_ < 0 + var_370_4 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play102604091 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 102604091
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play102604092(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 0.325

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, false)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_1 = arg_371_1:FormatText(arg_371_1:GetWordFromCfg(102604091).content)

				arg_371_1.text_.text = var_374_1

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_3 = 13 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_1) / 13)

				if (13 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_1) / 13)) > 0 and var_374_0 < var_374_3 then
					arg_371_1.talkMaxDuration = var_374_3

					if var_374_3 + 0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_3 + 0
					end
				end

				arg_371_1.text_.text = var_374_1
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_4 = math.max(var_374_0, arg_371_1.talkMaxDuration)

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_4 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - 0) / var_374_4

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= 0 + var_374_4 and arg_371_1.time_ < 0 + var_374_4 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play102604092 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 102604092
		arg_375_1.duration_ = 5

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play102604093(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_378_0 = 0.6

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_0 then
				local var_378_1, var_378_2 = math.modf((arg_375_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_378_2 * 0.13, var_378_2 * 0.13, var_378_2 * 0.13) + arg_375_1.var_.shakeOldPos
			end

			if arg_375_1.time_ >= 0 + var_378_0 and arg_375_1.time_ < 0 + var_378_0 + arg_378_0 then
				manager.ui.mainCamera.transform.localPosition = arg_375_1.var_.shakeOldPos
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:AudioAction("play", "effect", "se_story_side_1026", "se_story_1026_burst", "")
			end

			local var_378_4 = 0
			local var_378_5 = 0.05

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_4 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, false)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_6 = arg_375_1:FormatText(arg_375_1:GetWordFromCfg(102604092).content)

				arg_375_1.text_.text = var_378_6

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_8 = 2 <= 0 and var_378_5 or var_378_5 * (utf8.len(var_378_6) / 2)

				if (2 <= 0 and var_378_5 or var_378_5 * (utf8.len(var_378_6) / 2)) > 0 and var_378_5 < var_378_8 then
					arg_375_1.talkMaxDuration = var_378_8

					if var_378_8 + var_378_4 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_8 + var_378_4
					end
				end

				arg_375_1.text_.text = var_378_6
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_9 = math.max(var_378_5, arg_375_1.talkMaxDuration)

			if var_378_4 <= arg_375_1.time_ and arg_375_1.time_ < var_378_4 + var_378_9 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_4) / var_378_9

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_4 + var_378_9 and arg_375_1.time_ < var_378_4 + var_378_9 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play102604093 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 102604093
		arg_379_1.duration_ = 1.7

		local var_379_0 = {
			ja = 1.7,
			ko = 1.066,
			zh = 0.999999999999,
			en = 1.433
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play102604094(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = 0.1

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, true)
				arg_379_1.iconController_:SetSelectedState("hero")

				arg_379_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1026")

				arg_379_1.callingController_:SetSelectedState("normal")

				arg_379_1.keyicon_.color = Color.New(1, 1, 1)
				arg_379_1.icon_.color = Color.New(1, 1, 1)

				local var_382_1 = arg_379_1:GetWordFromCfg(102604093)
				local var_382_2 = arg_379_1:FormatText(var_382_1.content)

				arg_379_1.text_.text = var_382_2

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_4 = 4 <= 0 and var_382_0 or var_382_0 * (utf8.len(var_382_2) / 4)

				if (4 <= 0 and var_382_0 or var_382_0 * (utf8.len(var_382_2) / 4)) > 0 and var_382_0 < var_382_4 then
					arg_379_1.talkMaxDuration = var_382_4

					if var_382_4 + 0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_4 + 0
					end
				end

				arg_379_1.text_.text = var_382_2
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604093", "story_v_side_old_102604.awb") ~= 0 then
					local var_382_5 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604093", "story_v_side_old_102604.awb") / 1000

					if var_382_5 + 0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_5 + 0
					end

					if var_382_1.prefab_name ~= "" and arg_379_1.actors_[var_382_1.prefab_name] ~= nil then
						local var_382_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_1.prefab_name].transform, "story_v_side_old_102604", "102604093", "story_v_side_old_102604.awb")

						arg_379_1:RecordAudio("102604093", var_382_6)
						arg_379_1:RecordAudio("102604093", var_382_6)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604093", "story_v_side_old_102604.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604093", "story_v_side_old_102604.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_7 = math.max(var_382_0, arg_379_1.talkMaxDuration)

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_7 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - 0) / var_382_7

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= 0 + var_382_7 and arg_379_1.time_ < 0 + var_382_7 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play102604094 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 102604094
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play102604095(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = 0.8

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, false)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_1 = arg_383_1:FormatText(arg_383_1:GetWordFromCfg(102604094).content)

				arg_383_1.text_.text = var_386_1

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_3 = 32 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_1) / 32)

				if (32 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_1) / 32)) > 0 and var_386_0 < var_386_3 then
					arg_383_1.talkMaxDuration = var_386_3

					if var_386_3 + 0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_3 + 0
					end
				end

				arg_383_1.text_.text = var_386_1
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_4 = math.max(var_386_0, arg_383_1.talkMaxDuration)

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_4 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - 0) / var_386_4

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= 0 + var_386_4 and arg_383_1.time_ < 0 + var_386_4 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play102604095 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 102604095
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play102604096(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 0.825

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, false)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_1 = arg_387_1:FormatText(arg_387_1:GetWordFromCfg(102604095).content)

				arg_387_1.text_.text = var_390_1

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_3 = 33 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_1) / 33)

				if (33 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_1) / 33)) > 0 and var_390_0 < var_390_3 then
					arg_387_1.talkMaxDuration = var_390_3

					if var_390_3 + 0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_3 + 0
					end
				end

				arg_387_1.text_.text = var_390_1
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_4 = math.max(var_390_0, arg_387_1.talkMaxDuration)

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_4 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - 0) / var_390_4

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= 0 + var_390_4 and arg_387_1.time_ < 0 + var_390_4 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play102604096 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 102604096
		arg_391_1.duration_ = 3.63

		local var_391_0 = {
			ja = 3.633,
			ko = 1.933,
			zh = 3,
			en = 2.466
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play102604097(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 0.225

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[200].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, true)
				arg_391_1.iconController_:SetSelectedState("hero")

				arg_391_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_391_1.callingController_:SetSelectedState("normal")

				arg_391_1.keyicon_.color = Color.New(1, 1, 1)
				arg_391_1.icon_.color = Color.New(1, 1, 1)

				local var_394_1 = arg_391_1:GetWordFromCfg(102604096)
				local var_394_2 = arg_391_1:FormatText(var_394_1.content)

				arg_391_1.text_.text = var_394_2

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_4 = 9 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_2) / 9)

				if (9 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_2) / 9)) > 0 and var_394_0 < var_394_4 then
					arg_391_1.talkMaxDuration = var_394_4

					if var_394_4 + 0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_4 + 0
					end
				end

				arg_391_1.text_.text = var_394_2
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604096", "story_v_side_old_102604.awb") ~= 0 then
					local var_394_5 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604096", "story_v_side_old_102604.awb") / 1000

					if var_394_5 + 0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_5 + 0
					end

					if var_394_1.prefab_name ~= "" and arg_391_1.actors_[var_394_1.prefab_name] ~= nil then
						local var_394_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_1.prefab_name].transform, "story_v_side_old_102604", "102604096", "story_v_side_old_102604.awb")

						arg_391_1:RecordAudio("102604096", var_394_6)
						arg_391_1:RecordAudio("102604096", var_394_6)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604096", "story_v_side_old_102604.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604096", "story_v_side_old_102604.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_7 = math.max(var_394_0, arg_391_1.talkMaxDuration)

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_7 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - 0) / var_394_7

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= 0 + var_394_7 and arg_391_1.time_ < 0 + var_394_7 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play102604097 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 102604097
		arg_395_1.duration_ = 5

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play102604098(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = 0.05

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, true)
				arg_395_1.iconController_:SetSelectedState("hero")

				arg_395_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_395_1.callingController_:SetSelectedState("normal")

				arg_395_1.keyicon_.color = Color.New(1, 1, 1)
				arg_395_1.icon_.color = Color.New(1, 1, 1)

				local var_398_1 = arg_395_1:FormatText(arg_395_1:GetWordFromCfg(102604097).content)

				arg_395_1.text_.text = var_398_1

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_3 = 2 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_1) / 2)

				if (2 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_1) / 2)) > 0 and var_398_0 < var_398_3 then
					arg_395_1.talkMaxDuration = var_398_3

					if var_398_3 + 0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_3 + 0
					end
				end

				arg_395_1.text_.text = var_398_1
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_4 = math.max(var_398_0, arg_395_1.talkMaxDuration)

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_4 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - 0) / var_398_4

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= 0 + var_398_4 and arg_395_1.time_ < 0 + var_398_4 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play102604098 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 102604098
		arg_399_1.duration_ = 4.53

		local var_399_0 = {
			ja = 4.533,
			ko = 3.1,
			zh = 3.466,
			en = 3
		}
		local var_399_1 = manager.audio:GetLocalizationFlag()

		if var_399_0[var_399_1] ~= nil then
			arg_399_1.duration_ = var_399_0[var_399_1]
		end

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play102604099(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = 0.35

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[200].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, true)
				arg_399_1.iconController_:SetSelectedState("hero")

				arg_399_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_399_1.callingController_:SetSelectedState("normal")

				arg_399_1.keyicon_.color = Color.New(1, 1, 1)
				arg_399_1.icon_.color = Color.New(1, 1, 1)

				local var_402_1 = arg_399_1:GetWordFromCfg(102604098)
				local var_402_2 = arg_399_1:FormatText(var_402_1.content)

				arg_399_1.text_.text = var_402_2

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_4 = 14 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_2) / 14)

				if (14 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_2) / 14)) > 0 and var_402_0 < var_402_4 then
					arg_399_1.talkMaxDuration = var_402_4

					if var_402_4 + 0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_4 + 0
					end
				end

				arg_399_1.text_.text = var_402_2
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604098", "story_v_side_old_102604.awb") ~= 0 then
					local var_402_5 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604098", "story_v_side_old_102604.awb") / 1000

					if var_402_5 + 0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_5 + 0
					end

					if var_402_1.prefab_name ~= "" and arg_399_1.actors_[var_402_1.prefab_name] ~= nil then
						local var_402_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_1.prefab_name].transform, "story_v_side_old_102604", "102604098", "story_v_side_old_102604.awb")

						arg_399_1:RecordAudio("102604098", var_402_6)
						arg_399_1:RecordAudio("102604098", var_402_6)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604098", "story_v_side_old_102604.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604098", "story_v_side_old_102604.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_7 = math.max(var_402_0, arg_399_1.talkMaxDuration)

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_7 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - 0) / var_402_7

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= 0 + var_402_7 and arg_399_1.time_ < 0 + var_402_7 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play102604099 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 102604099
		arg_403_1.duration_ = 5

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play102604100(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = 0.175

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, false)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_1 = arg_403_1:FormatText(arg_403_1:GetWordFromCfg(102604099).content)

				arg_403_1.text_.text = var_406_1

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_3 = 7 <= 0 and var_406_0 or var_406_0 * (utf8.len(var_406_1) / 7)

				if (7 <= 0 and var_406_0 or var_406_0 * (utf8.len(var_406_1) / 7)) > 0 and var_406_0 < var_406_3 then
					arg_403_1.talkMaxDuration = var_406_3

					if var_406_3 + 0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_3 + 0
					end
				end

				arg_403_1.text_.text = var_406_1
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)
				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_4 = math.max(var_406_0, arg_403_1.talkMaxDuration)

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_4 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - 0) / var_406_4

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= 0 + var_406_4 and arg_403_1.time_ < 0 + var_406_4 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play102604100 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 102604100
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play102604101(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = 1.3

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, false)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_1 = arg_407_1:FormatText(arg_407_1:GetWordFromCfg(102604100).content)

				arg_407_1.text_.text = var_410_1

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_3 = 56 <= 0 and var_410_0 or var_410_0 * (utf8.len(var_410_1) / 56)

				if (56 <= 0 and var_410_0 or var_410_0 * (utf8.len(var_410_1) / 56)) > 0 and var_410_0 < var_410_3 then
					arg_407_1.talkMaxDuration = var_410_3

					if var_410_3 + 0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_3 + 0
					end
				end

				arg_407_1.text_.text = var_410_1
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_4 = math.max(var_410_0, arg_407_1.talkMaxDuration)

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_4 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - 0) / var_410_4

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= 0 + var_410_4 and arg_407_1.time_ < 0 + var_410_4 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play102604101 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 102604101
		arg_411_1.duration_ = 7.2

		local var_411_0 = {
			ja = 7.2,
			ko = 4.466,
			zh = 5.2,
			en = 5.433
		}
		local var_411_1 = manager.audio:GetLocalizationFlag()

		if var_411_0[var_411_1] ~= nil then
			arg_411_1.duration_ = var_411_0[var_411_1]
		end

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play102604102(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = 0.5

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[200].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, true)
				arg_411_1.iconController_:SetSelectedState("hero")

				arg_411_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_411_1.callingController_:SetSelectedState("normal")

				arg_411_1.keyicon_.color = Color.New(1, 1, 1)
				arg_411_1.icon_.color = Color.New(1, 1, 1)

				local var_414_1 = arg_411_1:GetWordFromCfg(102604101)
				local var_414_2 = arg_411_1:FormatText(var_414_1.content)

				arg_411_1.text_.text = var_414_2

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_4 = 20 <= 0 and var_414_0 or var_414_0 * (utf8.len(var_414_2) / 20)

				if (20 <= 0 and var_414_0 or var_414_0 * (utf8.len(var_414_2) / 20)) > 0 and var_414_0 < var_414_4 then
					arg_411_1.talkMaxDuration = var_414_4

					if var_414_4 + 0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_4 + 0
					end
				end

				arg_411_1.text_.text = var_414_2
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604101", "story_v_side_old_102604.awb") ~= 0 then
					local var_414_5 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604101", "story_v_side_old_102604.awb") / 1000

					if var_414_5 + 0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_5 + 0
					end

					if var_414_1.prefab_name ~= "" and arg_411_1.actors_[var_414_1.prefab_name] ~= nil then
						local var_414_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_1.prefab_name].transform, "story_v_side_old_102604", "102604101", "story_v_side_old_102604.awb")

						arg_411_1:RecordAudio("102604101", var_414_6)
						arg_411_1:RecordAudio("102604101", var_414_6)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604101", "story_v_side_old_102604.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604101", "story_v_side_old_102604.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_7 = math.max(var_414_0, arg_411_1.talkMaxDuration)

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_7 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - 0) / var_414_7

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= 0 + var_414_7 and arg_411_1.time_ < 0 + var_414_7 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play102604102 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 102604102
		arg_415_1.duration_ = 5.93

		local var_415_0 = {
			ja = 5.933,
			ko = 2.6,
			zh = 3.366,
			en = 2.966
		}
		local var_415_1 = manager.audio:GetLocalizationFlag()

		if var_415_0[var_415_1] ~= nil then
			arg_415_1.duration_ = var_415_0[var_415_1]
		end

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play102604103(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 0.275

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[200].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, true)
				arg_415_1.iconController_:SetSelectedState("hero")

				arg_415_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_415_1.callingController_:SetSelectedState("normal")

				arg_415_1.keyicon_.color = Color.New(1, 1, 1)
				arg_415_1.icon_.color = Color.New(1, 1, 1)

				local var_418_1 = arg_415_1:GetWordFromCfg(102604102)
				local var_418_2 = arg_415_1:FormatText(var_418_1.content)

				arg_415_1.text_.text = var_418_2

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_4 = 11 <= 0 and var_418_0 or var_418_0 * (utf8.len(var_418_2) / 11)

				if (11 <= 0 and var_418_0 or var_418_0 * (utf8.len(var_418_2) / 11)) > 0 and var_418_0 < var_418_4 then
					arg_415_1.talkMaxDuration = var_418_4

					if var_418_4 + 0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_4 + 0
					end
				end

				arg_415_1.text_.text = var_418_2
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604102", "story_v_side_old_102604.awb") ~= 0 then
					local var_418_5 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604102", "story_v_side_old_102604.awb") / 1000

					if var_418_5 + 0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_5 + 0
					end

					if var_418_1.prefab_name ~= "" and arg_415_1.actors_[var_418_1.prefab_name] ~= nil then
						local var_418_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_1.prefab_name].transform, "story_v_side_old_102604", "102604102", "story_v_side_old_102604.awb")

						arg_415_1:RecordAudio("102604102", var_418_6)
						arg_415_1:RecordAudio("102604102", var_418_6)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604102", "story_v_side_old_102604.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604102", "story_v_side_old_102604.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_7 = math.max(var_418_0, arg_415_1.talkMaxDuration)

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_7 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - 0) / var_418_7

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= 0 + var_418_7 and arg_415_1.time_ < 0 + var_418_7 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play102604103 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 102604103
		arg_419_1.duration_ = 5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play102604104(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_422_0 = 0.6

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_0 then
				local var_422_1, var_422_2 = math.modf((arg_419_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_422_2 * 0.13, var_422_2 * 0.13, var_422_2 * 0.13) + arg_419_1.var_.shakeOldPos
			end

			if arg_419_1.time_ >= 0 + var_422_0 and arg_419_1.time_ < 0 + var_422_0 + arg_422_0 then
				manager.ui.mainCamera.transform.localPosition = arg_419_1.var_.shakeOldPos
			end

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1:AudioAction("play", "effect", "se_story_side_1026", "se_story_1026_smash02", "")
			end

			local var_422_4 = 0
			local var_422_5 = 0.675

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_4 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, false)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_6 = arg_419_1:FormatText(arg_419_1:GetWordFromCfg(102604103).content)

				arg_419_1.text_.text = var_422_6

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_8 = 27 <= 0 and var_422_5 or var_422_5 * (utf8.len(var_422_6) / 27)

				if (27 <= 0 and var_422_5 or var_422_5 * (utf8.len(var_422_6) / 27)) > 0 and var_422_5 < var_422_8 then
					arg_419_1.talkMaxDuration = var_422_8

					if var_422_8 + var_422_4 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_8 + var_422_4
					end
				end

				arg_419_1.text_.text = var_422_6
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_9 = math.max(var_422_5, arg_419_1.talkMaxDuration)

			if var_422_4 <= arg_419_1.time_ and arg_419_1.time_ < var_422_4 + var_422_9 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_4) / var_422_9

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_4 + var_422_9 and arg_419_1.time_ < var_422_4 + var_422_9 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play102604104 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 102604104
		arg_423_1.duration_ = 10.17

		local var_423_0 = {
			ja = 10.166,
			ko = 7.3,
			zh = 6.066,
			en = 6.566
		}
		local var_423_1 = manager.audio:GetLocalizationFlag()

		if var_423_0[var_423_1] ~= nil then
			arg_423_1.duration_ = var_423_0[var_423_1]
		end

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play102604105(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = 0.75

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[200].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, true)
				arg_423_1.iconController_:SetSelectedState("hero")

				arg_423_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_423_1.callingController_:SetSelectedState("normal")

				arg_423_1.keyicon_.color = Color.New(1, 1, 1)
				arg_423_1.icon_.color = Color.New(1, 1, 1)

				local var_426_1 = arg_423_1:GetWordFromCfg(102604104)
				local var_426_2 = arg_423_1:FormatText(var_426_1.content)

				arg_423_1.text_.text = var_426_2

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_4 = 30 <= 0 and var_426_0 or var_426_0 * (utf8.len(var_426_2) / 30)

				if (30 <= 0 and var_426_0 or var_426_0 * (utf8.len(var_426_2) / 30)) > 0 and var_426_0 < var_426_4 then
					arg_423_1.talkMaxDuration = var_426_4

					if var_426_4 + 0 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_4 + 0
					end
				end

				arg_423_1.text_.text = var_426_2
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604104", "story_v_side_old_102604.awb") ~= 0 then
					local var_426_5 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604104", "story_v_side_old_102604.awb") / 1000

					if var_426_5 + 0 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_5 + 0
					end

					if var_426_1.prefab_name ~= "" and arg_423_1.actors_[var_426_1.prefab_name] ~= nil then
						local var_426_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_1.prefab_name].transform, "story_v_side_old_102604", "102604104", "story_v_side_old_102604.awb")

						arg_423_1:RecordAudio("102604104", var_426_6)
						arg_423_1:RecordAudio("102604104", var_426_6)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604104", "story_v_side_old_102604.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604104", "story_v_side_old_102604.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_7 = math.max(var_426_0, arg_423_1.talkMaxDuration)

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_7 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - 0) / var_426_7

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= 0 + var_426_7 and arg_423_1.time_ < 0 + var_426_7 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play102604105 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 102604105
		arg_427_1.duration_ = 13.63

		local var_427_0 = {
			ja = 13.4,
			ko = 12.6,
			zh = 13.633,
			en = 13
		}
		local var_427_1 = manager.audio:GetLocalizationFlag()

		if var_427_0[var_427_1] ~= nil then
			arg_427_1.duration_ = var_427_0[var_427_1]
		end

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play102604106(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = 1.375

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[200].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, true)
				arg_427_1.iconController_:SetSelectedState("hero")

				arg_427_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_427_1.callingController_:SetSelectedState("normal")

				arg_427_1.keyicon_.color = Color.New(1, 1, 1)
				arg_427_1.icon_.color = Color.New(1, 1, 1)

				local var_430_1 = arg_427_1:GetWordFromCfg(102604105)
				local var_430_2 = arg_427_1:FormatText(var_430_1.content)

				arg_427_1.text_.text = var_430_2

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_4 = 55 <= 0 and var_430_0 or var_430_0 * (utf8.len(var_430_2) / 55)

				if (55 <= 0 and var_430_0 or var_430_0 * (utf8.len(var_430_2) / 55)) > 0 and var_430_0 < var_430_4 then
					arg_427_1.talkMaxDuration = var_430_4

					if var_430_4 + 0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_4 + 0
					end
				end

				arg_427_1.text_.text = var_430_2
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604105", "story_v_side_old_102604.awb") ~= 0 then
					local var_430_5 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604105", "story_v_side_old_102604.awb") / 1000

					if var_430_5 + 0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_5 + 0
					end

					if var_430_1.prefab_name ~= "" and arg_427_1.actors_[var_430_1.prefab_name] ~= nil then
						local var_430_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_1.prefab_name].transform, "story_v_side_old_102604", "102604105", "story_v_side_old_102604.awb")

						arg_427_1:RecordAudio("102604105", var_430_6)
						arg_427_1:RecordAudio("102604105", var_430_6)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604105", "story_v_side_old_102604.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604105", "story_v_side_old_102604.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_7 = math.max(var_430_0, arg_427_1.talkMaxDuration)

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_7 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - 0) / var_430_7

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= 0 + var_430_7 and arg_427_1.time_ < 0 + var_430_7 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play102604106 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 102604106
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play102604107(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = 1.1

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, false)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_1 = arg_431_1:FormatText(arg_431_1:GetWordFromCfg(102604106).content)

				arg_431_1.text_.text = var_434_1

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_3 = 46 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_1) / 46)

				if (46 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_1) / 46)) > 0 and var_434_0 < var_434_3 then
					arg_431_1.talkMaxDuration = var_434_3

					if var_434_3 + 0 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_3 + 0
					end
				end

				arg_431_1.text_.text = var_434_1
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_4 = math.max(var_434_0, arg_431_1.talkMaxDuration)

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_4 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - 0) / var_434_4

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= 0 + var_434_4 and arg_431_1.time_ < 0 + var_434_4 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play102604107 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 102604107
		arg_435_1.duration_ = 7.63

		local var_435_0 = {
			ja = 7.633,
			ko = 5.333,
			zh = 3.833,
			en = 3.433
		}
		local var_435_1 = manager.audio:GetLocalizationFlag()

		if var_435_0[var_435_1] ~= nil then
			arg_435_1.duration_ = var_435_0[var_435_1]
		end

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play102604108(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(arg_435_1.actors_["1026ui_story"]) and arg_435_1.var_.characterEffect1026ui_story == nil then
				arg_435_1.var_.characterEffect1026ui_story = arg_435_1.actors_["1026ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_0 = 0.2

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_0 and not isNil(arg_435_1.actors_["1026ui_story"]) then
				if arg_435_1.var_.characterEffect1026ui_story and not isNil(arg_435_1.actors_["1026ui_story"]) then
					arg_435_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_435_1.time_ >= 0 + var_438_0 and arg_435_1.time_ < 0 + var_438_0 + arg_438_0 and not isNil(arg_435_1.actors_["1026ui_story"]) and arg_435_1.var_.characterEffect1026ui_story then
				arg_435_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action1_1")
			end

			local var_438_2 = arg_435_1.actors_["1026ui_story"].transform

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1.var_.moveOldPos1026ui_story = var_438_2.localPosition
			end

			local var_438_3 = 0.001

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_3 then
				var_438_2.localPosition = Vector3.Lerp(arg_435_1.var_.moveOldPos1026ui_story, Vector3.New(0, -1.05, -6.2), (arg_435_1.time_ - 0) / var_438_3)
				var_438_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_438_2.position).x, (manager.ui.mainCamera.transform.position - var_438_2.position).y, (manager.ui.mainCamera.transform.position - var_438_2.position).z)
				var_438_2.localEulerAngles.z = 0
				var_438_2.localEulerAngles.x = 0
				var_438_2.localEulerAngles = var_438_2.localEulerAngles
			end

			if arg_435_1.time_ >= 0 + var_438_3 and arg_435_1.time_ < 0 + var_438_3 + arg_438_0 then
				var_438_2.localPosition = Vector3.New(0, -1.05, -6.2)
				var_438_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_438_2.position).x, (manager.ui.mainCamera.transform.position - var_438_2.position).y, (manager.ui.mainCamera.transform.position - var_438_2.position).z)
				var_438_2.localEulerAngles.z = 0
				var_438_2.localEulerAngles.x = 0
				var_438_2.localEulerAngles = var_438_2.localEulerAngles
			end

			local var_438_4 = 0
			local var_438_5 = 0.5

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_4 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				arg_435_1.leftNameTxt_.text = arg_435_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_6 = arg_435_1:GetWordFromCfg(102604107)
				local var_438_7 = arg_435_1:FormatText(var_438_6.content)

				arg_435_1.text_.text = var_438_7

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_9 = 20 <= 0 and var_438_5 or var_438_5 * (utf8.len(var_438_7) / 20)

				if (20 <= 0 and var_438_5 or var_438_5 * (utf8.len(var_438_7) / 20)) > 0 and var_438_5 < var_438_9 then
					arg_435_1.talkMaxDuration = var_438_9

					if var_438_9 + var_438_4 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_9 + var_438_4
					end
				end

				arg_435_1.text_.text = var_438_7
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604107", "story_v_side_old_102604.awb") ~= 0 then
					local var_438_10 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604107", "story_v_side_old_102604.awb") / 1000

					if var_438_10 + var_438_4 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_10 + var_438_4
					end

					if var_438_6.prefab_name ~= "" and arg_435_1.actors_[var_438_6.prefab_name] ~= nil then
						local var_438_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_6.prefab_name].transform, "story_v_side_old_102604", "102604107", "story_v_side_old_102604.awb")

						arg_435_1:RecordAudio("102604107", var_438_11)
						arg_435_1:RecordAudio("102604107", var_438_11)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604107", "story_v_side_old_102604.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604107", "story_v_side_old_102604.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_12 = math.max(var_438_5, arg_435_1.talkMaxDuration)

			if var_438_4 <= arg_435_1.time_ and arg_435_1.time_ < var_438_4 + var_438_12 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_4) / var_438_12

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_4 + var_438_12 and arg_435_1.time_ < var_438_4 + var_438_12 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_435_1:InitPlayNodeList()
	end,
	Play102604108 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 102604108
		arg_439_1.duration_ = 8.57

		local var_439_0 = {
			ja = 8.566,
			ko = 5.9,
			zh = 5.266,
			en = 3.933
		}
		local var_439_1 = manager.audio:GetLocalizationFlag()

		if var_439_0[var_439_1] ~= nil then
			arg_439_1.duration_ = var_439_0[var_439_1]
		end

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play102604109(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 and not isNil(arg_439_1.actors_["1026ui_story"]) and arg_439_1.var_.characterEffect1026ui_story == nil then
				arg_439_1.var_.characterEffect1026ui_story = arg_439_1.actors_["1026ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_442_0 = 0.2

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_0 and not isNil(arg_439_1.actors_["1026ui_story"]) then
				if arg_439_1.var_.characterEffect1026ui_story and not isNil(arg_439_1.actors_["1026ui_story"]) then
					arg_439_1.var_.characterEffect1026ui_story.fillFlat = true
					arg_439_1.var_.characterEffect1026ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_439_1.time_ - 0) / var_442_0)
				end
			end

			if arg_439_1.time_ >= 0 + var_442_0 and arg_439_1.time_ < 0 + var_442_0 + arg_442_0 and not isNil(arg_439_1.actors_["1026ui_story"]) and arg_439_1.var_.characterEffect1026ui_story then
				arg_439_1.var_.characterEffect1026ui_story.fillFlat = true
				arg_439_1.var_.characterEffect1026ui_story.fillRatio = 0.5
			end

			local var_442_1 = 0
			local var_442_2 = 0.6

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_1 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				arg_439_1.leftNameTxt_.text = arg_439_1:FormatText(StoryNameCfg[200].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, true)
				arg_439_1.iconController_:SetSelectedState("hero")

				arg_439_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_439_1.callingController_:SetSelectedState("normal")

				arg_439_1.keyicon_.color = Color.New(1, 1, 1)
				arg_439_1.icon_.color = Color.New(1, 1, 1)

				local var_442_3 = arg_439_1:GetWordFromCfg(102604108)
				local var_442_4 = arg_439_1:FormatText(var_442_3.content)

				arg_439_1.text_.text = var_442_4

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_6 = 24 <= 0 and var_442_2 or var_442_2 * (utf8.len(var_442_4) / 24)

				if (24 <= 0 and var_442_2 or var_442_2 * (utf8.len(var_442_4) / 24)) > 0 and var_442_2 < var_442_6 then
					arg_439_1.talkMaxDuration = var_442_6

					if var_442_6 + var_442_1 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_6 + var_442_1
					end
				end

				arg_439_1.text_.text = var_442_4
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604108", "story_v_side_old_102604.awb") ~= 0 then
					local var_442_7 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604108", "story_v_side_old_102604.awb") / 1000

					if var_442_7 + var_442_1 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_7 + var_442_1
					end

					if var_442_3.prefab_name ~= "" and arg_439_1.actors_[var_442_3.prefab_name] ~= nil then
						local var_442_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_3.prefab_name].transform, "story_v_side_old_102604", "102604108", "story_v_side_old_102604.awb")

						arg_439_1:RecordAudio("102604108", var_442_8)
						arg_439_1:RecordAudio("102604108", var_442_8)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604108", "story_v_side_old_102604.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604108", "story_v_side_old_102604.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_9 = math.max(var_442_2, arg_439_1.talkMaxDuration)

			if var_442_1 <= arg_439_1.time_ and arg_439_1.time_ < var_442_1 + var_442_9 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_1) / var_442_9

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_1 + var_442_9 and arg_439_1.time_ < var_442_1 + var_442_9 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play102604109 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 102604109
		arg_443_1.duration_ = 12.6

		local var_443_0 = {
			ja = 12.366,
			ko = 10.4,
			zh = 12.6,
			en = 10.533
		}
		local var_443_1 = manager.audio:GetLocalizationFlag()

		if var_443_0[var_443_1] ~= nil then
			arg_443_1.duration_ = var_443_0[var_443_1]
		end

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play102604110(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = 1.175

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				arg_443_1.leftNameTxt_.text = arg_443_1:FormatText(StoryNameCfg[200].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, true)
				arg_443_1.iconController_:SetSelectedState("hero")

				arg_443_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_443_1.callingController_:SetSelectedState("normal")

				arg_443_1.keyicon_.color = Color.New(1, 1, 1)
				arg_443_1.icon_.color = Color.New(1, 1, 1)

				local var_446_1 = arg_443_1:GetWordFromCfg(102604109)
				local var_446_2 = arg_443_1:FormatText(var_446_1.content)

				arg_443_1.text_.text = var_446_2

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_4 = 47 <= 0 and var_446_0 or var_446_0 * (utf8.len(var_446_2) / 47)

				if (47 <= 0 and var_446_0 or var_446_0 * (utf8.len(var_446_2) / 47)) > 0 and var_446_0 < var_446_4 then
					arg_443_1.talkMaxDuration = var_446_4

					if var_446_4 + 0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_4 + 0
					end
				end

				arg_443_1.text_.text = var_446_2
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604109", "story_v_side_old_102604.awb") ~= 0 then
					local var_446_5 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604109", "story_v_side_old_102604.awb") / 1000

					if var_446_5 + 0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_5 + 0
					end

					if var_446_1.prefab_name ~= "" and arg_443_1.actors_[var_446_1.prefab_name] ~= nil then
						local var_446_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_1.prefab_name].transform, "story_v_side_old_102604", "102604109", "story_v_side_old_102604.awb")

						arg_443_1:RecordAudio("102604109", var_446_6)
						arg_443_1:RecordAudio("102604109", var_446_6)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604109", "story_v_side_old_102604.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604109", "story_v_side_old_102604.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_7 = math.max(var_446_0, arg_443_1.talkMaxDuration)

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_7 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - 0) / var_446_7

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= 0 + var_446_7 and arg_443_1.time_ < 0 + var_446_7 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play102604110 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 102604110
		arg_447_1.duration_ = 2.9

		local var_447_0 = {
			ja = 2.466,
			ko = 2.133,
			zh = 2.9,
			en = 1.999999999999
		}
		local var_447_1 = manager.audio:GetLocalizationFlag()

		if var_447_0[var_447_1] ~= nil then
			arg_447_1.duration_ = var_447_0[var_447_1]
		end

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play102604111(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_450_0 = arg_447_1.actors_["1026ui_story"]

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 and not isNil(var_450_0) and arg_447_1.var_.characterEffect1026ui_story == nil then
				arg_447_1.var_.characterEffect1026ui_story = var_450_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_450_1 = 0.2

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_1 and not isNil(var_450_0) then
				if arg_447_1.var_.characterEffect1026ui_story and not isNil(var_450_0) then
					arg_447_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_447_1.time_ >= 0 + var_450_1 and arg_447_1.time_ < 0 + var_450_1 + arg_450_0 and not isNil(var_450_0) and arg_447_1.var_.characterEffect1026ui_story then
				arg_447_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			local var_450_3 = 0
			local var_450_4 = 0.125

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_3 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				arg_447_1.leftNameTxt_.text = arg_447_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_5 = arg_447_1:GetWordFromCfg(102604110)
				local var_450_6 = arg_447_1:FormatText(var_450_5.content)

				arg_447_1.text_.text = var_450_6

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_8 = 5 <= 0 and var_450_4 or var_450_4 * (utf8.len(var_450_6) / 5)

				if (5 <= 0 and var_450_4 or var_450_4 * (utf8.len(var_450_6) / 5)) > 0 and var_450_4 < var_450_8 then
					arg_447_1.talkMaxDuration = var_450_8

					if var_450_8 + var_450_3 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_8 + var_450_3
					end
				end

				arg_447_1.text_.text = var_450_6
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604110", "story_v_side_old_102604.awb") ~= 0 then
					local var_450_9 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604110", "story_v_side_old_102604.awb") / 1000

					if var_450_9 + var_450_3 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_9 + var_450_3
					end

					if var_450_5.prefab_name ~= "" and arg_447_1.actors_[var_450_5.prefab_name] ~= nil then
						local var_450_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_5.prefab_name].transform, "story_v_side_old_102604", "102604110", "story_v_side_old_102604.awb")

						arg_447_1:RecordAudio("102604110", var_450_10)
						arg_447_1:RecordAudio("102604110", var_450_10)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604110", "story_v_side_old_102604.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604110", "story_v_side_old_102604.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_11 = math.max(var_450_4, arg_447_1.talkMaxDuration)

			if var_450_3 <= arg_447_1.time_ and arg_447_1.time_ < var_450_3 + var_450_11 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_3) / var_450_11

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_3 + var_450_11 and arg_447_1.time_ < var_450_3 + var_450_11 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play102604111 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 102604111
		arg_451_1.duration_ = 5.87

		local var_451_0 = {
			ja = 5.866,
			ko = 3.3,
			zh = 3.2,
			en = 1.999999999999
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
				arg_451_0:Play102604112(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action7_1")
			end

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_454_0 = 0
			local var_454_1 = 0.375

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_0 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				arg_451_1.leftNameTxt_.text = arg_451_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_2 = arg_451_1:GetWordFromCfg(102604111)
				local var_454_3 = arg_451_1:FormatText(var_454_2.content)

				arg_451_1.text_.text = var_454_3

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_5 = 15 <= 0 and var_454_1 or var_454_1 * (utf8.len(var_454_3) / 15)

				if (15 <= 0 and var_454_1 or var_454_1 * (utf8.len(var_454_3) / 15)) > 0 and var_454_1 < var_454_5 then
					arg_451_1.talkMaxDuration = var_454_5

					if var_454_5 + var_454_0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_5 + var_454_0
					end
				end

				arg_451_1.text_.text = var_454_3
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604111", "story_v_side_old_102604.awb") ~= 0 then
					local var_454_6 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604111", "story_v_side_old_102604.awb") / 1000

					if var_454_6 + var_454_0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_6 + var_454_0
					end

					if var_454_2.prefab_name ~= "" and arg_451_1.actors_[var_454_2.prefab_name] ~= nil then
						local var_454_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_2.prefab_name].transform, "story_v_side_old_102604", "102604111", "story_v_side_old_102604.awb")

						arg_451_1:RecordAudio("102604111", var_454_7)
						arg_451_1:RecordAudio("102604111", var_454_7)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604111", "story_v_side_old_102604.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604111", "story_v_side_old_102604.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_8 = math.max(var_454_1, arg_451_1.talkMaxDuration)

			if var_454_0 <= arg_451_1.time_ and arg_451_1.time_ < var_454_0 + var_454_8 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_0) / var_454_8

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_0 + var_454_8 and arg_451_1.time_ < var_454_0 + var_454_8 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play102604112 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 102604112
		arg_455_1.duration_ = 5

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play102604113(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1.var_.moveOldPos1026ui_story = arg_455_1.actors_["1026ui_story"].transform.localPosition
			end

			local var_458_0 = 0.001

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_0 then
				arg_455_1.actors_["1026ui_story"].transform.localPosition = Vector3.Lerp(arg_455_1.var_.moveOldPos1026ui_story, Vector3.New(0, 100, 0), (arg_455_1.time_ - 0) / var_458_0)
				arg_455_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_455_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_455_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_455_1.actors_["1026ui_story"].transform.position).z)
				arg_455_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_455_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_455_1.actors_["1026ui_story"].transform.localEulerAngles = arg_455_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			if arg_455_1.time_ >= 0 + var_458_0 and arg_455_1.time_ < 0 + var_458_0 + arg_458_0 then
				arg_455_1.actors_["1026ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_455_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_455_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_455_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_455_1.actors_["1026ui_story"].transform.position).z)
				arg_455_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_455_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_455_1.actors_["1026ui_story"].transform.localEulerAngles = arg_455_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			local var_458_1 = 0
			local var_458_2 = 1.125

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_1 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, false)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_3 = arg_455_1:FormatText(arg_455_1:GetWordFromCfg(102604112).content)

				arg_455_1.text_.text = var_458_3

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_5 = 45 <= 0 and var_458_2 or var_458_2 * (utf8.len(var_458_3) / 45)

				if (45 <= 0 and var_458_2 or var_458_2 * (utf8.len(var_458_3) / 45)) > 0 and var_458_2 < var_458_5 then
					arg_455_1.talkMaxDuration = var_458_5

					if var_458_5 + var_458_1 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_5 + var_458_1
					end
				end

				arg_455_1.text_.text = var_458_3
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)
				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_6 = math.max(var_458_2, arg_455_1.talkMaxDuration)

			if var_458_1 <= arg_455_1.time_ and arg_455_1.time_ < var_458_1 + var_458_6 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_1) / var_458_6

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_1 + var_458_6 and arg_455_1.time_ < var_458_1 + var_458_6 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_455_1:InitPlayNodeList()
	end,
	Play102604113 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 102604113
		arg_459_1.duration_ = 5

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play102604114(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = 0.725

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, false)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_1 = arg_459_1:FormatText(arg_459_1:GetWordFromCfg(102604113).content)

				arg_459_1.text_.text = var_462_1

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_3 = 31 <= 0 and var_462_0 or var_462_0 * (utf8.len(var_462_1) / 31)

				if (31 <= 0 and var_462_0 or var_462_0 * (utf8.len(var_462_1) / 31)) > 0 and var_462_0 < var_462_3 then
					arg_459_1.talkMaxDuration = var_462_3

					if var_462_3 + 0 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_3 + 0
					end
				end

				arg_459_1.text_.text = var_462_1
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)
				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_4 = math.max(var_462_0, arg_459_1.talkMaxDuration)

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_4 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - 0) / var_462_4

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= 0 + var_462_4 and arg_459_1.time_ < 0 + var_462_4 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play102604114 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 102604114
		arg_463_1.duration_ = 5

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play102604115(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = 1.025

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, false)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_1 = arg_463_1:FormatText(arg_463_1:GetWordFromCfg(102604114).content)

				arg_463_1.text_.text = var_466_1

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_3 = 41 <= 0 and var_466_0 or var_466_0 * (utf8.len(var_466_1) / 41)

				if (41 <= 0 and var_466_0 or var_466_0 * (utf8.len(var_466_1) / 41)) > 0 and var_466_0 < var_466_3 then
					arg_463_1.talkMaxDuration = var_466_3

					if var_466_3 + 0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_3 + 0
					end
				end

				arg_463_1.text_.text = var_466_1
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)
				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_4 = math.max(var_466_0, arg_463_1.talkMaxDuration)

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_4 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - 0) / var_466_4

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= 0 + var_466_4 and arg_463_1.time_ < 0 + var_466_4 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play102604115 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 102604115
		arg_467_1.duration_ = 5

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play102604116(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1.var_.moveOldPosB01c = arg_467_1.bgs_.B01c.transform.localPosition
			end

			local var_470_0 = 2

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_0 then
				arg_467_1.bgs_.B01c.transform.localPosition = Vector3.Lerp(arg_467_1.var_.moveOldPosB01c, Vector3.New(0, 1, 9.5), (arg_467_1.time_ - 0) / var_470_0)
			end

			if arg_467_1.time_ >= 0 + var_470_0 and arg_467_1.time_ < 0 + var_470_0 + arg_470_0 then
				arg_467_1.bgs_.B01c.transform.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_470_1 = 0
			local var_470_2 = 0.9

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_1 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, false)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_3 = arg_467_1:FormatText(arg_467_1:GetWordFromCfg(102604115).content)

				arg_467_1.text_.text = var_470_3

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_5 = 38 <= 0 and var_470_2 or var_470_2 * (utf8.len(var_470_3) / 38)

				if (38 <= 0 and var_470_2 or var_470_2 * (utf8.len(var_470_3) / 38)) > 0 and var_470_2 < var_470_5 then
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

		arg_467_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "B01c",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_467_1:InitPlayNodeList()
	end,
	Play102604116 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 102604116
		arg_471_1.duration_ = 3.33

		local var_471_0 = {
			ja = 3.333,
			ko = 1.3,
			zh = 1.866,
			en = 1.833
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
				arg_471_0:Play102604117(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_0 = 0.15

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				arg_471_1.leftNameTxt_.text = arg_471_1:FormatText(StoryNameCfg[200].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, true)
				arg_471_1.iconController_:SetSelectedState("hero")

				arg_471_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_471_1.callingController_:SetSelectedState("normal")

				arg_471_1.keyicon_.color = Color.New(1, 1, 1)
				arg_471_1.icon_.color = Color.New(1, 1, 1)

				local var_474_1 = arg_471_1:GetWordFromCfg(102604116)
				local var_474_2 = arg_471_1:FormatText(var_474_1.content)

				arg_471_1.text_.text = var_474_2

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_4 = 6 <= 0 and var_474_0 or var_474_0 * (utf8.len(var_474_2) / 6)

				if (6 <= 0 and var_474_0 or var_474_0 * (utf8.len(var_474_2) / 6)) > 0 and var_474_0 < var_474_4 then
					arg_471_1.talkMaxDuration = var_474_4

					if var_474_4 + 0 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_4 + 0
					end
				end

				arg_471_1.text_.text = var_474_2
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604116", "story_v_side_old_102604.awb") ~= 0 then
					local var_474_5 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604116", "story_v_side_old_102604.awb") / 1000

					if var_474_5 + 0 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_5 + 0
					end

					if var_474_1.prefab_name ~= "" and arg_471_1.actors_[var_474_1.prefab_name] ~= nil then
						local var_474_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_471_1.actors_[var_474_1.prefab_name].transform, "story_v_side_old_102604", "102604116", "story_v_side_old_102604.awb")

						arg_471_1:RecordAudio("102604116", var_474_6)
						arg_471_1:RecordAudio("102604116", var_474_6)
					else
						arg_471_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604116", "story_v_side_old_102604.awb")
					end

					arg_471_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604116", "story_v_side_old_102604.awb")
				end

				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_7 = math.max(var_474_0, arg_471_1.talkMaxDuration)

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_7 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - 0) / var_474_7

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= 0 + var_474_7 and arg_471_1.time_ < 0 + var_474_7 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {}

		arg_471_1:InitPlayNodeList()
	end,
	Play102604117 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 102604117
		arg_475_1.duration_ = 5

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play102604118(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			local var_478_0 = 0.8

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, false)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_1 = arg_475_1:FormatText(arg_475_1:GetWordFromCfg(102604117).content)

				arg_475_1.text_.text = var_478_1

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_3 = 32 <= 0 and var_478_0 or var_478_0 * (utf8.len(var_478_1) / 32)

				if (32 <= 0 and var_478_0 or var_478_0 * (utf8.len(var_478_1) / 32)) > 0 and var_478_0 < var_478_3 then
					arg_475_1.talkMaxDuration = var_478_3

					if var_478_3 + 0 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_3 + 0
					end
				end

				arg_475_1.text_.text = var_478_1
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)
				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_4 = math.max(var_478_0, arg_475_1.talkMaxDuration)

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_4 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - 0) / var_478_4

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= 0 + var_478_4 and arg_475_1.time_ < 0 + var_478_4 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {}

		arg_475_1:InitPlayNodeList()
	end,
	Play102604118 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 102604118
		arg_479_1.duration_ = 5

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play102604119(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = 0.625

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, false)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_1 = arg_479_1:FormatText(arg_479_1:GetWordFromCfg(102604118).content)

				arg_479_1.text_.text = var_482_1

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_3 = 25 <= 0 and var_482_0 or var_482_0 * (utf8.len(var_482_1) / 25)

				if (25 <= 0 and var_482_0 or var_482_0 * (utf8.len(var_482_1) / 25)) > 0 and var_482_0 < var_482_3 then
					arg_479_1.talkMaxDuration = var_482_3

					if var_482_3 + 0 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_3 + 0
					end
				end

				arg_479_1.text_.text = var_482_1
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)
				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_4 = math.max(var_482_0, arg_479_1.talkMaxDuration)

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_4 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - 0) / var_482_4

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= 0 + var_482_4 and arg_479_1.time_ < 0 + var_482_4 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play102604119 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 102604119
		arg_483_1.duration_ = 7

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play102604120(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1.mask_.enabled = true
				arg_483_1.mask_.raycastTarget = false

				arg_483_1:SetGaussion(false)
			end

			local var_486_0 = 1.5

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_0 then
				local var_486_1 = Color.New(1, 1, 1)

				var_486_1.a = Mathf.Lerp(1, 0, (arg_483_1.time_ - 0) / var_486_0)
				arg_483_1.mask_.color = var_486_1
			end

			if arg_483_1.time_ >= 0 + var_486_0 and arg_483_1.time_ < 0 + var_486_0 + arg_486_0 then
				local var_486_2 = Color.New(1, 1, 1)

				arg_483_1.mask_.enabled = false
				var_486_2.a = 0
				arg_483_1.mask_.color = var_486_2
			end

			if 1.5 < arg_483_1.time_ and arg_483_1.time_ <= 1.5 + arg_486_0 then
				arg_483_1:AudioAction("play", "effect", "se_story_side_1026", "se_story_1026_cat05", "")
			end

			if arg_483_1.frameCnt_ <= 1 then
				arg_483_1.dialog_:SetActive(false)
			end

			local var_486_4 = 2
			local var_486_5 = 0.05

			if 2 < arg_483_1.time_ and arg_483_1.time_ <= var_486_4 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0

				arg_483_1.dialog_:SetActive(true)

				arg_483_1.dialogCg_.alpha = 0

				local var_486_6 = LeanTween.value(arg_483_1.dialog_, 0, 1, 0.3)

				var_486_6:setOnUpdate(LuaHelper.FloatAction(function(arg_487_0)
					arg_483_1.dialogCg_.alpha = arg_487_0
				end))
				var_486_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_483_1.dialog_)
					var_486_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_483_1.duration_ = arg_483_1.duration_ + 0.3

				SetActive(arg_483_1.leftNameGo_, true)

				arg_483_1.leftNameTxt_.text = arg_483_1:FormatText(StoryNameCfg[198].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, true)
				arg_483_1.iconController_:SetSelectedState("hero")

				arg_483_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_cata")

				arg_483_1.callingController_:SetSelectedState("normal")

				arg_483_1.keyicon_.color = Color.New(1, 1, 1)
				arg_483_1.icon_.color = Color.New(1, 1, 1)

				local var_486_7 = arg_483_1:FormatText(arg_483_1:GetWordFromCfg(102604119).content)

				arg_483_1.text_.text = var_486_7

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_9 = 2 <= 0 and var_486_5 or var_486_5 * (utf8.len(var_486_7) / 2)

				if (2 <= 0 and var_486_5 or var_486_5 * (utf8.len(var_486_7) / 2)) > 0 and var_486_5 < var_486_9 then
					arg_483_1.talkMaxDuration = var_486_9
					var_486_4 = var_486_4 + 0.3

					if var_486_9 + var_486_4 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_9 + var_486_4
					end
				end

				arg_483_1.text_.text = var_486_7
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)
				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_10 = var_486_4 + 0.3
			local var_486_11 = math.max(var_486_5, arg_483_1.talkMaxDuration)

			if var_486_4 + 0.3 <= arg_483_1.time_ and arg_483_1.time_ < var_486_10 + var_486_11 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_10) / var_486_11

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_10 + var_486_11 and arg_483_1.time_ < var_486_10 + var_486_11 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play102604120 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 102604120
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play102604121(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = 0.725

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, false)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_1 = arg_489_1:FormatText(arg_489_1:GetWordFromCfg(102604120).content)

				arg_489_1.text_.text = var_492_1

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_3 = 29 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_1) / 29)

				if (29 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_1) / 29)) > 0 and var_492_0 < var_492_3 then
					arg_489_1.talkMaxDuration = var_492_3

					if var_492_3 + 0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_3 + 0
					end
				end

				arg_489_1.text_.text = var_492_1
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_4 = math.max(var_492_0, arg_489_1.talkMaxDuration)

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_4 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - 0) / var_492_4

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= 0 + var_492_4 and arg_489_1.time_ < 0 + var_492_4 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play102604121 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 102604121
		arg_493_1.duration_ = 7.33

		local var_493_0 = {
			ja = 7.333,
			ko = 1.5,
			zh = 2.766,
			en = 2.166
		}
		local var_493_1 = manager.audio:GetLocalizationFlag()

		if var_493_0[var_493_1] ~= nil then
			arg_493_1.duration_ = var_493_0[var_493_1]
		end

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play102604122(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = 0.15

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				arg_493_1.leftNameTxt_.text = arg_493_1:FormatText(StoryNameCfg[200].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, true)
				arg_493_1.iconController_:SetSelectedState("hero")

				arg_493_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_493_1.callingController_:SetSelectedState("normal")

				arg_493_1.keyicon_.color = Color.New(1, 1, 1)
				arg_493_1.icon_.color = Color.New(1, 1, 1)

				local var_496_1 = arg_493_1:GetWordFromCfg(102604121)
				local var_496_2 = arg_493_1:FormatText(var_496_1.content)

				arg_493_1.text_.text = var_496_2

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_4 = 6 <= 0 and var_496_0 or var_496_0 * (utf8.len(var_496_2) / 6)

				if (6 <= 0 and var_496_0 or var_496_0 * (utf8.len(var_496_2) / 6)) > 0 and var_496_0 < var_496_4 then
					arg_493_1.talkMaxDuration = var_496_4

					if var_496_4 + 0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_4 + 0
					end
				end

				arg_493_1.text_.text = var_496_2
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604121", "story_v_side_old_102604.awb") ~= 0 then
					local var_496_5 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604121", "story_v_side_old_102604.awb") / 1000

					if var_496_5 + 0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_5 + 0
					end

					if var_496_1.prefab_name ~= "" and arg_493_1.actors_[var_496_1.prefab_name] ~= nil then
						local var_496_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_493_1.actors_[var_496_1.prefab_name].transform, "story_v_side_old_102604", "102604121", "story_v_side_old_102604.awb")

						arg_493_1:RecordAudio("102604121", var_496_6)
						arg_493_1:RecordAudio("102604121", var_496_6)
					else
						arg_493_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604121", "story_v_side_old_102604.awb")
					end

					arg_493_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604121", "story_v_side_old_102604.awb")
				end

				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_7 = math.max(var_496_0, arg_493_1.talkMaxDuration)

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_7 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - 0) / var_496_7

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= 0 + var_496_7 and arg_493_1.time_ < 0 + var_496_7 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	Play102604122 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 102604122
		arg_497_1.duration_ = 5

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play102604123(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = 1.2

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, false)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_1 = arg_497_1:FormatText(arg_497_1:GetWordFromCfg(102604122).content)

				arg_497_1.text_.text = var_500_1

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_3 = 50 <= 0 and var_500_0 or var_500_0 * (utf8.len(var_500_1) / 50)

				if (50 <= 0 and var_500_0 or var_500_0 * (utf8.len(var_500_1) / 50)) > 0 and var_500_0 < var_500_3 then
					arg_497_1.talkMaxDuration = var_500_3

					if var_500_3 + 0 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_3 + 0
					end
				end

				arg_497_1.text_.text = var_500_1
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)
				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_4 = math.max(var_500_0, arg_497_1.talkMaxDuration)

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_4 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - 0) / var_500_4

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= 0 + var_500_4 and arg_497_1.time_ < 0 + var_500_4 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play102604123 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 102604123
		arg_501_1.duration_ = 5

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play102604124(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			if 0.333333333333333 < arg_501_1.time_ and arg_501_1.time_ <= 0.333333333333333 + arg_504_0 then
				arg_501_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_504_0 = 0.6

			if 0.333333333333333 <= arg_501_1.time_ and arg_501_1.time_ < 0.333333333333333 + var_504_0 then
				local var_504_1, var_504_2 = math.modf((arg_501_1.time_ - 0.333333333333333) / 0)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_504_2 * 0, var_504_2 * 0, var_504_2 * 0) + arg_501_1.var_.shakeOldPos
			end

			if arg_501_1.time_ >= 0.333333333333333 + var_504_0 and arg_501_1.time_ < 0.333333333333333 + var_504_0 + arg_504_0 then
				manager.ui.mainCamera.transform.localPosition = arg_501_1.var_.shakeOldPos
			end

			if 0.333333333333333 < arg_501_1.time_ and arg_501_1.time_ <= 0.333333333333333 + arg_504_0 then
				arg_501_1:AudioAction("play", "effect", "se_story_side_1026", "se_story_1026_smash03", "")
			end

			local var_504_4 = 0
			local var_504_5 = 0.55

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_4 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, false)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_6 = arg_501_1:FormatText(arg_501_1:GetWordFromCfg(102604123).content)

				arg_501_1.text_.text = var_504_6

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_8 = 24 <= 0 and var_504_5 or var_504_5 * (utf8.len(var_504_6) / 24)

				if (24 <= 0 and var_504_5 or var_504_5 * (utf8.len(var_504_6) / 24)) > 0 and var_504_5 < var_504_8 then
					arg_501_1.talkMaxDuration = var_504_8

					if var_504_8 + var_504_4 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_8 + var_504_4
					end
				end

				arg_501_1.text_.text = var_504_6
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_9 = math.max(var_504_5, arg_501_1.talkMaxDuration)

			if var_504_4 <= arg_501_1.time_ and arg_501_1.time_ < var_504_4 + var_504_9 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_4) / var_504_9

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_4 + var_504_9 and arg_501_1.time_ < var_504_4 + var_504_9 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play102604124 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 102604124
		arg_505_1.duration_ = 5

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play102604125(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			if 0.325 < arg_505_1.time_ and arg_505_1.time_ <= 0.325 + arg_508_0 then
				arg_505_1:AudioAction("play", "effect", "se_story_side_1026", "se_story_1026_electric", "")
			end

			local var_508_1 = 0
			local var_508_2 = 1.325

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= var_508_1 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, false)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_3 = arg_505_1:FormatText(arg_505_1:GetWordFromCfg(102604124).content)

				arg_505_1.text_.text = var_508_3

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_5 = 53 <= 0 and var_508_2 or var_508_2 * (utf8.len(var_508_3) / 53)

				if (53 <= 0 and var_508_2 or var_508_2 * (utf8.len(var_508_3) / 53)) > 0 and var_508_2 < var_508_5 then
					arg_505_1.talkMaxDuration = var_508_5

					if var_508_5 + var_508_1 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_5 + var_508_1
					end
				end

				arg_505_1.text_.text = var_508_3
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)
				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_6 = math.max(var_508_2, arg_505_1.talkMaxDuration)

			if var_508_1 <= arg_505_1.time_ and arg_505_1.time_ < var_508_1 + var_508_6 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_1) / var_508_6

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_1 + var_508_6 and arg_505_1.time_ < var_508_1 + var_508_6 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play102604125 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 102604125
		arg_509_1.duration_ = 5

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play102604126(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			local var_512_0 = 0.075

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				arg_509_1.leftNameTxt_.text = arg_509_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, true)
				arg_509_1.iconController_:SetSelectedState("hero")

				arg_509_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_509_1.callingController_:SetSelectedState("normal")

				arg_509_1.keyicon_.color = Color.New(1, 1, 1)
				arg_509_1.icon_.color = Color.New(1, 1, 1)

				local var_512_1 = arg_509_1:FormatText(arg_509_1:GetWordFromCfg(102604125).content)

				arg_509_1.text_.text = var_512_1

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_3 = 3 <= 0 and var_512_0 or var_512_0 * (utf8.len(var_512_1) / 3)

				if (3 <= 0 and var_512_0 or var_512_0 * (utf8.len(var_512_1) / 3)) > 0 and var_512_0 < var_512_3 then
					arg_509_1.talkMaxDuration = var_512_3

					if var_512_3 + 0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_3 + 0
					end
				end

				arg_509_1.text_.text = var_512_1
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)
				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_4 = math.max(var_512_0, arg_509_1.talkMaxDuration)

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_4 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - 0) / var_512_4

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= 0 + var_512_4 and arg_509_1.time_ < 0 + var_512_4 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play102604126 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 102604126
		arg_513_1.duration_ = 5

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play102604127(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = 0.6

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, false)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_1 = arg_513_1:FormatText(arg_513_1:GetWordFromCfg(102604126).content)

				arg_513_1.text_.text = var_516_1

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_3 = 24 <= 0 and var_516_0 or var_516_0 * (utf8.len(var_516_1) / 24)

				if (24 <= 0 and var_516_0 or var_516_0 * (utf8.len(var_516_1) / 24)) > 0 and var_516_0 < var_516_3 then
					arg_513_1.talkMaxDuration = var_516_3

					if var_516_3 + 0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_3 + 0
					end
				end

				arg_513_1.text_.text = var_516_1
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)
				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_4 = math.max(var_516_0, arg_513_1.talkMaxDuration)

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_4 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - 0) / var_516_4

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= 0 + var_516_4 and arg_513_1.time_ < 0 + var_516_4 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play102604127 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 102604127
		arg_517_1.duration_ = 5

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play102604128(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = 0.475

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, false)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_1 = arg_517_1:FormatText(arg_517_1:GetWordFromCfg(102604127).content)

				arg_517_1.text_.text = var_520_1

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_3 = 21 <= 0 and var_520_0 or var_520_0 * (utf8.len(var_520_1) / 21)

				if (21 <= 0 and var_520_0 or var_520_0 * (utf8.len(var_520_1) / 21)) > 0 and var_520_0 < var_520_3 then
					arg_517_1.talkMaxDuration = var_520_3

					if var_520_3 + 0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_3 + 0
					end
				end

				arg_517_1.text_.text = var_520_1
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)
				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_4 = math.max(var_520_0, arg_517_1.talkMaxDuration)

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_4 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - 0) / var_520_4

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= 0 + var_520_4 and arg_517_1.time_ < 0 + var_520_4 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play102604128 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 102604128
		arg_521_1.duration_ = 5

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play102604129(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_524_0 = 0.6

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_0 then
				local var_524_1, var_524_2 = math.modf((arg_521_1.time_ - 0) / 0)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_524_2 * 0, var_524_2 * 0, var_524_2 * 0) + arg_521_1.var_.shakeOldPos
			end

			if arg_521_1.time_ >= 0 + var_524_0 and arg_521_1.time_ < 0 + var_524_0 + arg_524_0 then
				manager.ui.mainCamera.transform.localPosition = arg_521_1.var_.shakeOldPos
			end

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1:AudioAction("play", "effect", "se_story_side_1026", "se_story_1026_wrench02", "")
			end

			local var_524_4 = 0
			local var_524_5 = 0.075

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= var_524_4 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, false)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_6 = arg_521_1:FormatText(arg_521_1:GetWordFromCfg(102604128).content)

				arg_521_1.text_.text = var_524_6

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_8 = 3 <= 0 and var_524_5 or var_524_5 * (utf8.len(var_524_6) / 3)

				if (3 <= 0 and var_524_5 or var_524_5 * (utf8.len(var_524_6) / 3)) > 0 and var_524_5 < var_524_8 then
					arg_521_1.talkMaxDuration = var_524_8

					if var_524_8 + var_524_4 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_8 + var_524_4
					end
				end

				arg_521_1.text_.text = var_524_6
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)
				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_9 = math.max(var_524_5, arg_521_1.talkMaxDuration)

			if var_524_4 <= arg_521_1.time_ and arg_521_1.time_ < var_524_4 + var_524_9 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_4) / var_524_9

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_4 + var_524_9 and arg_521_1.time_ < var_524_4 + var_524_9 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play102604129 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 102604129
		arg_525_1.duration_ = 5

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play102604130(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = 0.35

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, false)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_1 = arg_525_1:FormatText(arg_525_1:GetWordFromCfg(102604129).content)

				arg_525_1.text_.text = var_528_1

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_3 = 15 <= 0 and var_528_0 or var_528_0 * (utf8.len(var_528_1) / 15)

				if (15 <= 0 and var_528_0 or var_528_0 * (utf8.len(var_528_1) / 15)) > 0 and var_528_0 < var_528_3 then
					arg_525_1.talkMaxDuration = var_528_3

					if var_528_3 + 0 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_3 + 0
					end
				end

				arg_525_1.text_.text = var_528_1
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)
				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_4 = math.max(var_528_0, arg_525_1.talkMaxDuration)

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_4 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - 0) / var_528_4

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= 0 + var_528_4 and arg_525_1.time_ < 0 + var_528_4 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play102604130 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 102604130
		arg_529_1.duration_ = 5

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play102604131(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			local var_532_0 = 1

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, false)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_1 = arg_529_1:FormatText(arg_529_1:GetWordFromCfg(102604130).content)

				arg_529_1.text_.text = var_532_1

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_3 = 40 <= 0 and var_532_0 or var_532_0 * (utf8.len(var_532_1) / 40)

				if (40 <= 0 and var_532_0 or var_532_0 * (utf8.len(var_532_1) / 40)) > 0 and var_532_0 < var_532_3 then
					arg_529_1.talkMaxDuration = var_532_3

					if var_532_3 + 0 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_3 + 0
					end
				end

				arg_529_1.text_.text = var_532_1
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)
				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_4 = math.max(var_532_0, arg_529_1.talkMaxDuration)

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_4 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - 0) / var_532_4

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= 0 + var_532_4 and arg_529_1.time_ < 0 + var_532_4 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play102604131 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 102604131
		arg_533_1.duration_ = 5

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play102604132(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			local var_536_0 = 0.85

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, false)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_533_1.iconTrs_.gameObject, false)
				arg_533_1.callingController_:SetSelectedState("normal")

				local var_536_1 = arg_533_1:FormatText(arg_533_1:GetWordFromCfg(102604131).content)

				arg_533_1.text_.text = var_536_1

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_3 = 36 <= 0 and var_536_0 or var_536_0 * (utf8.len(var_536_1) / 36)

				if (36 <= 0 and var_536_0 or var_536_0 * (utf8.len(var_536_1) / 36)) > 0 and var_536_0 < var_536_3 then
					arg_533_1.talkMaxDuration = var_536_3

					if var_536_3 + 0 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_3 + 0
					end
				end

				arg_533_1.text_.text = var_536_1
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)
				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_4 = math.max(var_536_0, arg_533_1.talkMaxDuration)

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_4 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - 0) / var_536_4

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= 0 + var_536_4 and arg_533_1.time_ < 0 + var_536_4 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {}

		arg_533_1:InitPlayNodeList()
	end,
	Play102604132 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 102604132
		arg_537_1.duration_ = 5

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play102604133(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			local var_540_0 = 1.075

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, false)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_1 = arg_537_1:FormatText(arg_537_1:GetWordFromCfg(102604132).content)

				arg_537_1.text_.text = var_540_1

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_3 = 43 <= 0 and var_540_0 or var_540_0 * (utf8.len(var_540_1) / 43)

				if (43 <= 0 and var_540_0 or var_540_0 * (utf8.len(var_540_1) / 43)) > 0 and var_540_0 < var_540_3 then
					arg_537_1.talkMaxDuration = var_540_3

					if var_540_3 + 0 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_3 + 0
					end
				end

				arg_537_1.text_.text = var_540_1
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)
				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_4 = math.max(var_540_0, arg_537_1.talkMaxDuration)

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_4 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - 0) / var_540_4

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= 0 + var_540_4 and arg_537_1.time_ < 0 + var_540_4 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play102604133 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 102604133
		arg_541_1.duration_ = 6

		local var_541_0 = {
			ja = 6,
			ko = 2.466,
			zh = 3.6,
			en = 4.166
		}
		local var_541_1 = manager.audio:GetLocalizationFlag()

		if var_541_0[var_541_1] ~= nil then
			arg_541_1.duration_ = var_541_0[var_541_1]
		end

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play102604134(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			local var_544_0 = 0.3

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				arg_541_1.leftNameTxt_.text = arg_541_1:FormatText(StoryNameCfg[200].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, true)
				arg_541_1.iconController_:SetSelectedState("hero")

				arg_541_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_541_1.callingController_:SetSelectedState("normal")

				arg_541_1.keyicon_.color = Color.New(1, 1, 1)
				arg_541_1.icon_.color = Color.New(1, 1, 1)

				local var_544_1 = arg_541_1:GetWordFromCfg(102604133)
				local var_544_2 = arg_541_1:FormatText(var_544_1.content)

				arg_541_1.text_.text = var_544_2

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_4 = 12 <= 0 and var_544_0 or var_544_0 * (utf8.len(var_544_2) / 12)

				if (12 <= 0 and var_544_0 or var_544_0 * (utf8.len(var_544_2) / 12)) > 0 and var_544_0 < var_544_4 then
					arg_541_1.talkMaxDuration = var_544_4

					if var_544_4 + 0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_4 + 0
					end
				end

				arg_541_1.text_.text = var_544_2
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604133", "story_v_side_old_102604.awb") ~= 0 then
					local var_544_5 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604133", "story_v_side_old_102604.awb") / 1000

					if var_544_5 + 0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_5 + 0
					end

					if var_544_1.prefab_name ~= "" and arg_541_1.actors_[var_544_1.prefab_name] ~= nil then
						local var_544_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_541_1.actors_[var_544_1.prefab_name].transform, "story_v_side_old_102604", "102604133", "story_v_side_old_102604.awb")

						arg_541_1:RecordAudio("102604133", var_544_6)
						arg_541_1:RecordAudio("102604133", var_544_6)
					else
						arg_541_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604133", "story_v_side_old_102604.awb")
					end

					arg_541_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604133", "story_v_side_old_102604.awb")
				end

				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_7 = math.max(var_544_0, arg_541_1.talkMaxDuration)

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_7 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - 0) / var_544_7

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= 0 + var_544_7 and arg_541_1.time_ < 0 + var_544_7 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {}

		arg_541_1:InitPlayNodeList()
	end,
	Play102604134 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 102604134
		arg_545_1.duration_ = 5

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play102604135(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_548_0 = 0.6

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_0 then
				local var_548_1, var_548_2 = math.modf((arg_545_1.time_ - 0) / 0)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_548_2 * 0, var_548_2 * 0, var_548_2 * 0) + arg_545_1.var_.shakeOldPos
			end

			if arg_545_1.time_ >= 0 + var_548_0 and arg_545_1.time_ < 0 + var_548_0 + arg_548_0 then
				manager.ui.mainCamera.transform.localPosition = arg_545_1.var_.shakeOldPos
			end

			local var_548_3 = 0
			local var_548_4 = 0.25

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= var_548_3 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				arg_545_1.leftNameTxt_.text = arg_545_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, true)
				arg_545_1.iconController_:SetSelectedState("hero")

				arg_545_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_545_1.callingController_:SetSelectedState("normal")

				arg_545_1.keyicon_.color = Color.New(1, 1, 1)
				arg_545_1.icon_.color = Color.New(1, 1, 1)

				local var_548_5 = arg_545_1:FormatText(arg_545_1:GetWordFromCfg(102604134).content)

				arg_545_1.text_.text = var_548_5

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_7 = 10 <= 0 and var_548_4 or var_548_4 * (utf8.len(var_548_5) / 10)

				if (10 <= 0 and var_548_4 or var_548_4 * (utf8.len(var_548_5) / 10)) > 0 and var_548_4 < var_548_7 then
					arg_545_1.talkMaxDuration = var_548_7

					if var_548_7 + var_548_3 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_7 + var_548_3
					end
				end

				arg_545_1.text_.text = var_548_5
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)
				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_8 = math.max(var_548_4, arg_545_1.talkMaxDuration)

			if var_548_3 <= arg_545_1.time_ and arg_545_1.time_ < var_548_3 + var_548_8 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_3) / var_548_8

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_3 + var_548_8 and arg_545_1.time_ < var_548_3 + var_548_8 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {}

		arg_545_1:InitPlayNodeList()
	end,
	Play102604135 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 102604135
		arg_549_1.duration_ = 5

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play102604136(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = 0.275

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, false)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_1 = arg_549_1:FormatText(arg_549_1:GetWordFromCfg(102604135).content)

				arg_549_1.text_.text = var_552_1

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_3 = 11 <= 0 and var_552_0 or var_552_0 * (utf8.len(var_552_1) / 11)

				if (11 <= 0 and var_552_0 or var_552_0 * (utf8.len(var_552_1) / 11)) > 0 and var_552_0 < var_552_3 then
					arg_549_1.talkMaxDuration = var_552_3

					if var_552_3 + 0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_3 + 0
					end
				end

				arg_549_1.text_.text = var_552_1
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)
				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_4 = math.max(var_552_0, arg_549_1.talkMaxDuration)

			if 0 <= arg_549_1.time_ and arg_549_1.time_ < 0 + var_552_4 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - 0) / var_552_4

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= 0 + var_552_4 and arg_549_1.time_ < 0 + var_552_4 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play102604136 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 102604136
		arg_553_1.duration_ = 5

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play102604137(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			local var_556_0 = 0.475

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, false)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_1 = arg_553_1:FormatText(arg_553_1:GetWordFromCfg(102604136).content)

				arg_553_1.text_.text = var_556_1

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_3 = 19 <= 0 and var_556_0 or var_556_0 * (utf8.len(var_556_1) / 19)

				if (19 <= 0 and var_556_0 or var_556_0 * (utf8.len(var_556_1) / 19)) > 0 and var_556_0 < var_556_3 then
					arg_553_1.talkMaxDuration = var_556_3

					if var_556_3 + 0 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_3 + 0
					end
				end

				arg_553_1.text_.text = var_556_1
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)
				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_4 = math.max(var_556_0, arg_553_1.talkMaxDuration)

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_4 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - 0) / var_556_4

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= 0 + var_556_4 and arg_553_1.time_ < 0 + var_556_4 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {}

		arg_553_1:InitPlayNodeList()
	end,
	Play102604137 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 102604137
		arg_557_1.duration_ = 5.7

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play102604138(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			local var_560_0 = 1.225

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, false)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_1 = arg_557_1:FormatText(arg_557_1:GetWordFromCfg(102604137).content)

				arg_557_1.text_.text = var_560_1

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_3 = 49 <= 0 and var_560_0 or var_560_0 * (utf8.len(var_560_1) / 49)

				if (49 <= 0 and var_560_0 or var_560_0 * (utf8.len(var_560_1) / 49)) > 0 and var_560_0 < var_560_3 then
					arg_557_1.talkMaxDuration = var_560_3

					if var_560_3 + 0 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_3 + 0
					end
				end

				arg_557_1.text_.text = var_560_1
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)
				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_4 = math.max(var_560_0, arg_557_1.talkMaxDuration)

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_4 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - 0) / var_560_4

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= 0 + var_560_4 and arg_557_1.time_ < 0 + var_560_4 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play102604138 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 102604138
		arg_561_1.duration_ = 5

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play102604139(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action1_1")
			end

			local var_564_0 = arg_561_1.actors_["1026ui_story"]

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 and not isNil(var_564_0) and arg_561_1.var_.characterEffect1026ui_story == nil then
				arg_561_1.var_.characterEffect1026ui_story = var_564_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_564_1 = 0.2

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_1 and not isNil(var_564_0) then
				if arg_561_1.var_.characterEffect1026ui_story and not isNil(var_564_0) then
					arg_561_1.var_.characterEffect1026ui_story.fillFlat = true
					arg_561_1.var_.characterEffect1026ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_561_1.time_ - 0) / var_564_1)
				end
			end

			if arg_561_1.time_ >= 0 + var_564_1 and arg_561_1.time_ < 0 + var_564_1 + arg_564_0 and not isNil(var_564_0) and arg_561_1.var_.characterEffect1026ui_story then
				arg_561_1.var_.characterEffect1026ui_story.fillFlat = true
				arg_561_1.var_.characterEffect1026ui_story.fillRatio = 0.5
			end

			local var_564_2 = arg_561_1.actors_["1026ui_story"].transform

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1.var_.moveOldPos1026ui_story = var_564_2.localPosition
			end

			local var_564_3 = 0.001

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_3 then
				var_564_2.localPosition = Vector3.Lerp(arg_561_1.var_.moveOldPos1026ui_story, Vector3.New(0, -1.05, -6.2), (arg_561_1.time_ - 0) / var_564_3)
				var_564_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_564_2.position).x, (manager.ui.mainCamera.transform.position - var_564_2.position).y, (manager.ui.mainCamera.transform.position - var_564_2.position).z)
				var_564_2.localEulerAngles.z = 0
				var_564_2.localEulerAngles.x = 0
				var_564_2.localEulerAngles = var_564_2.localEulerAngles
			end

			if arg_561_1.time_ >= 0 + var_564_3 and arg_561_1.time_ < 0 + var_564_3 + arg_564_0 then
				var_564_2.localPosition = Vector3.New(0, -1.05, -6.2)
				var_564_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_564_2.position).x, (manager.ui.mainCamera.transform.position - var_564_2.position).y, (manager.ui.mainCamera.transform.position - var_564_2.position).z)
				var_564_2.localEulerAngles.z = 0
				var_564_2.localEulerAngles.x = 0
				var_564_2.localEulerAngles = var_564_2.localEulerAngles
			end

			local var_564_4 = 0
			local var_564_5 = 1.2

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= var_564_4 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0

				arg_561_1.dialog_:SetActive(true)

				arg_561_1.dialogCg_.alpha = 0

				local var_564_6 = LeanTween.value(arg_561_1.dialog_, 0, 1, 0.3)

				var_564_6:setOnUpdate(LuaHelper.FloatAction(function(arg_565_0)
					arg_561_1.dialogCg_.alpha = arg_565_0
				end))
				var_564_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_561_1.dialog_)
					var_564_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_561_1.duration_ = arg_561_1.duration_ + 0.3

				SetActive(arg_561_1.leftNameGo_, false)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_561_1.iconTrs_.gameObject, false)
				arg_561_1.callingController_:SetSelectedState("normal")

				local var_564_7 = arg_561_1:FormatText(arg_561_1:GetWordFromCfg(102604138).content)

				arg_561_1.text_.text = var_564_7

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_9 = 48 <= 0 and var_564_5 or var_564_5 * (utf8.len(var_564_7) / 48)

				if (48 <= 0 and var_564_5 or var_564_5 * (utf8.len(var_564_7) / 48)) > 0 and var_564_5 < var_564_9 then
					arg_561_1.talkMaxDuration = var_564_9
					var_564_4 = var_564_4 + 0.3

					if var_564_9 + var_564_4 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_9 + var_564_4
					end
				end

				arg_561_1.text_.text = var_564_7
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)
				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_10 = var_564_4 + 0.3
			local var_564_11 = math.max(var_564_5, arg_561_1.talkMaxDuration)

			if var_564_4 + 0.3 <= arg_561_1.time_ and arg_561_1.time_ < var_564_10 + var_564_11 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_10) / var_564_11

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_10 + var_564_11 and arg_561_1.time_ < var_564_10 + var_564_11 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_561_1:InitPlayNodeList()
	end,
	Play102604139 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 102604139
		arg_567_1.duration_ = 4.07

		local var_567_0 = {
			ja = 3.8,
			ko = 4.066,
			zh = 3.833,
			en = 2.5
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
				arg_567_0:Play102604140(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			if 0 < arg_567_1.time_ and arg_567_1.time_ <= 0 + arg_570_0 then
				arg_567_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_570_0 = arg_567_1.actors_["1026ui_story"]

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= 0 + arg_570_0 and not isNil(var_570_0) and arg_567_1.var_.characterEffect1026ui_story == nil then
				arg_567_1.var_.characterEffect1026ui_story = var_570_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_570_1 = 0.2

			if 0 <= arg_567_1.time_ and arg_567_1.time_ < 0 + var_570_1 and not isNil(var_570_0) then
				if arg_567_1.var_.characterEffect1026ui_story and not isNil(var_570_0) then
					arg_567_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_567_1.time_ >= 0 + var_570_1 and arg_567_1.time_ < 0 + var_570_1 + arg_570_0 and not isNil(var_570_0) and arg_567_1.var_.characterEffect1026ui_story then
				arg_567_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			local var_570_3 = 0
			local var_570_4 = 0.275

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= var_570_3 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, true)

				arg_567_1.leftNameTxt_.text = arg_567_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_567_1.leftNameTxt_.transform)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1.leftNameTxt_.text)
				SetActive(arg_567_1.iconTrs_.gameObject, false)
				arg_567_1.callingController_:SetSelectedState("normal")

				local var_570_5 = arg_567_1:GetWordFromCfg(102604139)
				local var_570_6 = arg_567_1:FormatText(var_570_5.content)

				arg_567_1.text_.text = var_570_6

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_8 = 11 <= 0 and var_570_4 or var_570_4 * (utf8.len(var_570_6) / 11)

				if (11 <= 0 and var_570_4 or var_570_4 * (utf8.len(var_570_6) / 11)) > 0 and var_570_4 < var_570_8 then
					arg_567_1.talkMaxDuration = var_570_8

					if var_570_8 + var_570_3 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_8 + var_570_3
					end
				end

				arg_567_1.text_.text = var_570_6
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604139", "story_v_side_old_102604.awb") ~= 0 then
					local var_570_9 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604139", "story_v_side_old_102604.awb") / 1000

					if var_570_9 + var_570_3 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_9 + var_570_3
					end

					if var_570_5.prefab_name ~= "" and arg_567_1.actors_[var_570_5.prefab_name] ~= nil then
						local var_570_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_567_1.actors_[var_570_5.prefab_name].transform, "story_v_side_old_102604", "102604139", "story_v_side_old_102604.awb")

						arg_567_1:RecordAudio("102604139", var_570_10)
						arg_567_1:RecordAudio("102604139", var_570_10)
					else
						arg_567_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604139", "story_v_side_old_102604.awb")
					end

					arg_567_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604139", "story_v_side_old_102604.awb")
				end

				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_11 = math.max(var_570_4, arg_567_1.talkMaxDuration)

			if var_570_3 <= arg_567_1.time_ and arg_567_1.time_ < var_570_3 + var_570_11 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - var_570_3) / var_570_11

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= var_570_3 + var_570_11 and arg_567_1.time_ < var_570_3 + var_570_11 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {}

		arg_567_1:InitPlayNodeList()
	end,
	Play102604140 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 102604140
		arg_571_1.duration_ = 5

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play102604141(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			if 0 < arg_571_1.time_ and arg_571_1.time_ <= 0 + arg_574_0 then
				arg_571_1.var_.moveOldPos1026ui_story = arg_571_1.actors_["1026ui_story"].transform.localPosition
			end

			local var_574_0 = 0.001

			if 0 <= arg_571_1.time_ and arg_571_1.time_ < 0 + var_574_0 then
				arg_571_1.actors_["1026ui_story"].transform.localPosition = Vector3.Lerp(arg_571_1.var_.moveOldPos1026ui_story, Vector3.New(0, 100, 0), (arg_571_1.time_ - 0) / var_574_0)
				arg_571_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_571_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_571_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_571_1.actors_["1026ui_story"].transform.position).z)
				arg_571_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_571_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_571_1.actors_["1026ui_story"].transform.localEulerAngles = arg_571_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			if arg_571_1.time_ >= 0 + var_574_0 and arg_571_1.time_ < 0 + var_574_0 + arg_574_0 then
				arg_571_1.actors_["1026ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_571_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_571_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_571_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_571_1.actors_["1026ui_story"].transform.position).z)
				arg_571_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_571_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_571_1.actors_["1026ui_story"].transform.localEulerAngles = arg_571_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			local var_574_1 = 0
			local var_574_2 = 0.675

			if 0 < arg_571_1.time_ and arg_571_1.time_ <= var_574_1 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, false)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_571_1.iconTrs_.gameObject, false)
				arg_571_1.callingController_:SetSelectedState("normal")

				local var_574_3 = arg_571_1:FormatText(arg_571_1:GetWordFromCfg(102604140).content)

				arg_571_1.text_.text = var_574_3

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_5 = 27 <= 0 and var_574_2 or var_574_2 * (utf8.len(var_574_3) / 27)

				if (27 <= 0 and var_574_2 or var_574_2 * (utf8.len(var_574_3) / 27)) > 0 and var_574_2 < var_574_5 then
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

		arg_571_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_571_1:InitPlayNodeList()
	end,
	Play102604141 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 102604141
		arg_575_1.duration_ = 5

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play102604142(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			local var_578_0 = 0.95

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, false)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_575_1.iconTrs_.gameObject, false)
				arg_575_1.callingController_:SetSelectedState("normal")

				local var_578_1 = arg_575_1:FormatText(arg_575_1:GetWordFromCfg(102604141).content)

				arg_575_1.text_.text = var_578_1

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_3 = 38 <= 0 and var_578_0 or var_578_0 * (utf8.len(var_578_1) / 38)

				if (38 <= 0 and var_578_0 or var_578_0 * (utf8.len(var_578_1) / 38)) > 0 and var_578_0 < var_578_3 then
					arg_575_1.talkMaxDuration = var_578_3

					if var_578_3 + 0 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_3 + 0
					end
				end

				arg_575_1.text_.text = var_578_1
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)
				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_4 = math.max(var_578_0, arg_575_1.talkMaxDuration)

			if 0 <= arg_575_1.time_ and arg_575_1.time_ < 0 + var_578_4 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - 0) / var_578_4

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= 0 + var_578_4 and arg_575_1.time_ < 0 + var_578_4 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {}

		arg_575_1:InitPlayNodeList()
	end,
	Play102604142 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 102604142
		arg_579_1.duration_ = 5

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play102604143(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			local var_582_0 = 0.35

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= 0 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, false)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_579_1.iconTrs_.gameObject, false)
				arg_579_1.callingController_:SetSelectedState("normal")

				local var_582_1 = arg_579_1:FormatText(arg_579_1:GetWordFromCfg(102604142).content)

				arg_579_1.text_.text = var_582_1

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_3 = 13 <= 0 and var_582_0 or var_582_0 * (utf8.len(var_582_1) / 13)

				if (13 <= 0 and var_582_0 or var_582_0 * (utf8.len(var_582_1) / 13)) > 0 and var_582_0 < var_582_3 then
					arg_579_1.talkMaxDuration = var_582_3

					if var_582_3 + 0 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_3 + 0
					end
				end

				arg_579_1.text_.text = var_582_1
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)
				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_4 = math.max(var_582_0, arg_579_1.talkMaxDuration)

			if 0 <= arg_579_1.time_ and arg_579_1.time_ < 0 + var_582_4 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - 0) / var_582_4

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= 0 + var_582_4 and arg_579_1.time_ < 0 + var_582_4 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	Play102604143 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 102604143
		arg_583_1.duration_ = 5

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play102604144(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			local var_586_0 = 1.325

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, false)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_583_1.iconTrs_.gameObject, false)
				arg_583_1.callingController_:SetSelectedState("normal")

				local var_586_1 = arg_583_1:FormatText(arg_583_1:GetWordFromCfg(102604143).content)

				arg_583_1.text_.text = var_586_1

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_3 = 53 <= 0 and var_586_0 or var_586_0 * (utf8.len(var_586_1) / 53)

				if (53 <= 0 and var_586_0 or var_586_0 * (utf8.len(var_586_1) / 53)) > 0 and var_586_0 < var_586_3 then
					arg_583_1.talkMaxDuration = var_586_3

					if var_586_3 + 0 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_3 + 0
					end
				end

				arg_583_1.text_.text = var_586_1
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)
				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_4 = math.max(var_586_0, arg_583_1.talkMaxDuration)

			if 0 <= arg_583_1.time_ and arg_583_1.time_ < 0 + var_586_4 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - 0) / var_586_4

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= 0 + var_586_4 and arg_583_1.time_ < 0 + var_586_4 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {}

		arg_583_1:InitPlayNodeList()
	end,
	Play102604144 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 102604144
		arg_587_1.duration_ = 5

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play102604145(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			local var_590_0 = 0.675

			if 0 < arg_587_1.time_ and arg_587_1.time_ <= 0 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, false)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_587_1.iconTrs_.gameObject, false)
				arg_587_1.callingController_:SetSelectedState("normal")

				local var_590_1 = arg_587_1:FormatText(arg_587_1:GetWordFromCfg(102604144).content)

				arg_587_1.text_.text = var_590_1

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_3 = 27 <= 0 and var_590_0 or var_590_0 * (utf8.len(var_590_1) / 27)

				if (27 <= 0 and var_590_0 or var_590_0 * (utf8.len(var_590_1) / 27)) > 0 and var_590_0 < var_590_3 then
					arg_587_1.talkMaxDuration = var_590_3

					if var_590_3 + 0 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_3 + 0
					end
				end

				arg_587_1.text_.text = var_590_1
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)
				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_4 = math.max(var_590_0, arg_587_1.talkMaxDuration)

			if 0 <= arg_587_1.time_ and arg_587_1.time_ < 0 + var_590_4 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - 0) / var_590_4

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= 0 + var_590_4 and arg_587_1.time_ < 0 + var_590_4 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {}

		arg_587_1:InitPlayNodeList()
	end,
	Play102604145 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 102604145
		arg_591_1.duration_ = 5

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
		end

		function arg_591_1.playNext_(arg_593_0)
			if arg_593_0 == 1 then
				arg_591_0:Play102604146(arg_591_1)
			end
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			local var_594_0 = 1.1

			if 0 < arg_591_1.time_ and arg_591_1.time_ <= 0 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0
				arg_591_1.dialogCg_.alpha = 1

				arg_591_1.dialog_:SetActive(true)
				SetActive(arg_591_1.leftNameGo_, false)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_591_1.iconTrs_.gameObject, false)
				arg_591_1.callingController_:SetSelectedState("normal")

				local var_594_1 = arg_591_1:FormatText(arg_591_1:GetWordFromCfg(102604145).content)

				arg_591_1.text_.text = var_594_1

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_3 = 44 <= 0 and var_594_0 or var_594_0 * (utf8.len(var_594_1) / 44)

				if (44 <= 0 and var_594_0 or var_594_0 * (utf8.len(var_594_1) / 44)) > 0 and var_594_0 < var_594_3 then
					arg_591_1.talkMaxDuration = var_594_3

					if var_594_3 + 0 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_3 + 0
					end
				end

				arg_591_1.text_.text = var_594_1
				arg_591_1.typewritter.percent = 0

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(false)
				arg_591_1:RecordContent(arg_591_1.text_.text)
			end

			local var_594_4 = math.max(var_594_0, arg_591_1.talkMaxDuration)

			if 0 <= arg_591_1.time_ and arg_591_1.time_ < 0 + var_594_4 then
				arg_591_1.typewritter.percent = (arg_591_1.time_ - 0) / var_594_4

				arg_591_1.typewritter:SetDirty()
			end

			if arg_591_1.time_ >= 0 + var_594_4 and arg_591_1.time_ < 0 + var_594_4 + arg_594_0 then
				arg_591_1.typewritter.percent = 1

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(true)
			end
		end

		arg_591_1.nodeConfigList_ = {}

		arg_591_1:InitPlayNodeList()
	end,
	Play102604146 = function(arg_595_0, arg_595_1)
		arg_595_1.time_ = 0
		arg_595_1.frameCnt_ = 0
		arg_595_1.state_ = "playing"
		arg_595_1.curTalkId_ = 102604146
		arg_595_1.duration_ = 5

		SetActive(arg_595_1.tipsGo_, false)

		function arg_595_1.onSingleLineFinish_()
			arg_595_1.onSingleLineUpdate_ = nil
			arg_595_1.onSingleLineFinish_ = nil
			arg_595_1.state_ = "waiting"
		end

		function arg_595_1.playNext_(arg_597_0)
			if arg_597_0 == 1 then
				arg_595_0:Play102604147(arg_595_1)
			end
		end

		function arg_595_1.onSingleLineUpdate_(arg_598_0)
			local var_598_0 = 0.25

			if 0 < arg_595_1.time_ and arg_595_1.time_ <= 0 + arg_598_0 then
				arg_595_1.talkMaxDuration = 0
				arg_595_1.dialogCg_.alpha = 1

				arg_595_1.dialog_:SetActive(true)
				SetActive(arg_595_1.leftNameGo_, false)

				arg_595_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_595_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_595_1:RecordName(arg_595_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_595_1.iconTrs_.gameObject, false)
				arg_595_1.callingController_:SetSelectedState("normal")

				local var_598_1 = arg_595_1:FormatText(arg_595_1:GetWordFromCfg(102604146).content)

				arg_595_1.text_.text = var_598_1

				LuaForUtil.ClearLinePrefixSymbol(arg_595_1.text_)

				local var_598_3 = 10 <= 0 and var_598_0 or var_598_0 * (utf8.len(var_598_1) / 10)

				if (10 <= 0 and var_598_0 or var_598_0 * (utf8.len(var_598_1) / 10)) > 0 and var_598_0 < var_598_3 then
					arg_595_1.talkMaxDuration = var_598_3

					if var_598_3 + 0 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_3 + 0
					end
				end

				arg_595_1.text_.text = var_598_1
				arg_595_1.typewritter.percent = 0

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(false)
				arg_595_1:RecordContent(arg_595_1.text_.text)
			end

			local var_598_4 = math.max(var_598_0, arg_595_1.talkMaxDuration)

			if 0 <= arg_595_1.time_ and arg_595_1.time_ < 0 + var_598_4 then
				arg_595_1.typewritter.percent = (arg_595_1.time_ - 0) / var_598_4

				arg_595_1.typewritter:SetDirty()
			end

			if arg_595_1.time_ >= 0 + var_598_4 and arg_595_1.time_ < 0 + var_598_4 + arg_598_0 then
				arg_595_1.typewritter.percent = 1

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(true)
			end
		end

		arg_595_1.nodeConfigList_ = {}

		arg_595_1:InitPlayNodeList()
	end,
	Play102604147 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 102604147
		arg_599_1.duration_ = 5

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play102604148(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			local var_602_0 = 1.2

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= 0 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0
				arg_599_1.dialogCg_.alpha = 1

				arg_599_1.dialog_:SetActive(true)
				SetActive(arg_599_1.leftNameGo_, false)

				arg_599_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_599_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_599_1:RecordName(arg_599_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_599_1.iconTrs_.gameObject, false)
				arg_599_1.callingController_:SetSelectedState("normal")

				local var_602_1 = arg_599_1:FormatText(arg_599_1:GetWordFromCfg(102604147).content)

				arg_599_1.text_.text = var_602_1

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_3 = 48 <= 0 and var_602_0 or var_602_0 * (utf8.len(var_602_1) / 48)

				if (48 <= 0 and var_602_0 or var_602_0 * (utf8.len(var_602_1) / 48)) > 0 and var_602_0 < var_602_3 then
					arg_599_1.talkMaxDuration = var_602_3

					if var_602_3 + 0 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_3 + 0
					end
				end

				arg_599_1.text_.text = var_602_1
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)
				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_4 = math.max(var_602_0, arg_599_1.talkMaxDuration)

			if 0 <= arg_599_1.time_ and arg_599_1.time_ < 0 + var_602_4 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - 0) / var_602_4

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= 0 + var_602_4 and arg_599_1.time_ < 0 + var_602_4 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {}

		arg_599_1:InitPlayNodeList()
	end,
	Play102604148 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 102604148
		arg_603_1.duration_ = 5

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play102604149(arg_603_1)
			end
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			local var_606_0 = 0.85

			if 0 < arg_603_1.time_ and arg_603_1.time_ <= 0 + arg_606_0 then
				arg_603_1.talkMaxDuration = 0
				arg_603_1.dialogCg_.alpha = 1

				arg_603_1.dialog_:SetActive(true)
				SetActive(arg_603_1.leftNameGo_, false)

				arg_603_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_603_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_603_1:RecordName(arg_603_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_603_1.iconTrs_.gameObject, false)
				arg_603_1.callingController_:SetSelectedState("normal")

				local var_606_1 = arg_603_1:FormatText(arg_603_1:GetWordFromCfg(102604148).content)

				arg_603_1.text_.text = var_606_1

				LuaForUtil.ClearLinePrefixSymbol(arg_603_1.text_)

				local var_606_3 = 36 <= 0 and var_606_0 or var_606_0 * (utf8.len(var_606_1) / 36)

				if (36 <= 0 and var_606_0 or var_606_0 * (utf8.len(var_606_1) / 36)) > 0 and var_606_0 < var_606_3 then
					arg_603_1.talkMaxDuration = var_606_3

					if var_606_3 + 0 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_3 + 0
					end
				end

				arg_603_1.text_.text = var_606_1
				arg_603_1.typewritter.percent = 0

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(false)
				arg_603_1:RecordContent(arg_603_1.text_.text)
			end

			local var_606_4 = math.max(var_606_0, arg_603_1.talkMaxDuration)

			if 0 <= arg_603_1.time_ and arg_603_1.time_ < 0 + var_606_4 then
				arg_603_1.typewritter.percent = (arg_603_1.time_ - 0) / var_606_4

				arg_603_1.typewritter:SetDirty()
			end

			if arg_603_1.time_ >= 0 + var_606_4 and arg_603_1.time_ < 0 + var_606_4 + arg_606_0 then
				arg_603_1.typewritter.percent = 1

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(true)
			end
		end

		arg_603_1.nodeConfigList_ = {}

		arg_603_1:InitPlayNodeList()
	end,
	Play102604149 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 102604149
		arg_607_1.duration_ = 4

		local var_607_0 = {
			ja = 4,
			ko = 3.066,
			zh = 3.933,
			en = 3.833
		}
		local var_607_1 = manager.audio:GetLocalizationFlag()

		if var_607_0[var_607_1] ~= nil then
			arg_607_1.duration_ = var_607_0[var_607_1]
		end

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
		end

		function arg_607_1.playNext_(arg_609_0)
			if arg_609_0 == 1 then
				arg_607_0:Play102604150(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			local var_610_0 = 0.225

			if 0 < arg_607_1.time_ and arg_607_1.time_ <= 0 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, true)

				arg_607_1.leftNameTxt_.text = arg_607_1:FormatText(StoryNameCfg[199].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_607_1.leftNameTxt_.transform)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1.leftNameTxt_.text)
				SetActive(arg_607_1.iconTrs_.gameObject, true)
				arg_607_1.iconController_:SetSelectedState("hero")

				arg_607_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboyb")

				arg_607_1.callingController_:SetSelectedState("normal")

				arg_607_1.keyicon_.color = Color.New(1, 1, 1)
				arg_607_1.icon_.color = Color.New(1, 1, 1)

				local var_610_1 = arg_607_1:GetWordFromCfg(102604149)
				local var_610_2 = arg_607_1:FormatText(var_610_1.content)

				arg_607_1.text_.text = var_610_2

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_4 = 9 <= 0 and var_610_0 or var_610_0 * (utf8.len(var_610_2) / 9)

				if (9 <= 0 and var_610_0 or var_610_0 * (utf8.len(var_610_2) / 9)) > 0 and var_610_0 < var_610_4 then
					arg_607_1.talkMaxDuration = var_610_4

					if var_610_4 + 0 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_4 + 0
					end
				end

				arg_607_1.text_.text = var_610_2
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604149", "story_v_side_old_102604.awb") ~= 0 then
					local var_610_5 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604149", "story_v_side_old_102604.awb") / 1000

					if var_610_5 + 0 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_5 + 0
					end

					if var_610_1.prefab_name ~= "" and arg_607_1.actors_[var_610_1.prefab_name] ~= nil then
						local var_610_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_607_1.actors_[var_610_1.prefab_name].transform, "story_v_side_old_102604", "102604149", "story_v_side_old_102604.awb")

						arg_607_1:RecordAudio("102604149", var_610_6)
						arg_607_1:RecordAudio("102604149", var_610_6)
					else
						arg_607_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604149", "story_v_side_old_102604.awb")
					end

					arg_607_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604149", "story_v_side_old_102604.awb")
				end

				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_7 = math.max(var_610_0, arg_607_1.talkMaxDuration)

			if 0 <= arg_607_1.time_ and arg_607_1.time_ < 0 + var_610_7 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - 0) / var_610_7

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= 0 + var_610_7 and arg_607_1.time_ < 0 + var_610_7 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {}

		arg_607_1:InitPlayNodeList()
	end,
	Play102604150 = function(arg_611_0, arg_611_1)
		arg_611_1.time_ = 0
		arg_611_1.frameCnt_ = 0
		arg_611_1.state_ = "playing"
		arg_611_1.curTalkId_ = 102604150
		arg_611_1.duration_ = 5

		SetActive(arg_611_1.tipsGo_, false)

		function arg_611_1.onSingleLineFinish_()
			arg_611_1.onSingleLineUpdate_ = nil
			arg_611_1.onSingleLineFinish_ = nil
			arg_611_1.state_ = "waiting"
		end

		function arg_611_1.playNext_(arg_613_0)
			if arg_613_0 == 1 then
				arg_611_0:Play102604151(arg_611_1)
			end
		end

		function arg_611_1.onSingleLineUpdate_(arg_614_0)
			local var_614_0 = 0.825

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 then
				arg_611_1.talkMaxDuration = 0
				arg_611_1.dialogCg_.alpha = 1

				arg_611_1.dialog_:SetActive(true)
				SetActive(arg_611_1.leftNameGo_, false)

				arg_611_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_611_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_611_1:RecordName(arg_611_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_611_1.iconTrs_.gameObject, false)
				arg_611_1.callingController_:SetSelectedState("normal")

				local var_614_1 = arg_611_1:FormatText(arg_611_1:GetWordFromCfg(102604150).content)

				arg_611_1.text_.text = var_614_1

				LuaForUtil.ClearLinePrefixSymbol(arg_611_1.text_)

				local var_614_3 = 33 <= 0 and var_614_0 or var_614_0 * (utf8.len(var_614_1) / 33)

				if (33 <= 0 and var_614_0 or var_614_0 * (utf8.len(var_614_1) / 33)) > 0 and var_614_0 < var_614_3 then
					arg_611_1.talkMaxDuration = var_614_3

					if var_614_3 + 0 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_3 + 0
					end
				end

				arg_611_1.text_.text = var_614_1
				arg_611_1.typewritter.percent = 0

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(false)
				arg_611_1:RecordContent(arg_611_1.text_.text)
			end

			local var_614_4 = math.max(var_614_0, arg_611_1.talkMaxDuration)

			if 0 <= arg_611_1.time_ and arg_611_1.time_ < 0 + var_614_4 then
				arg_611_1.typewritter.percent = (arg_611_1.time_ - 0) / var_614_4

				arg_611_1.typewritter:SetDirty()
			end

			if arg_611_1.time_ >= 0 + var_614_4 and arg_611_1.time_ < 0 + var_614_4 + arg_614_0 then
				arg_611_1.typewritter.percent = 1

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(true)
			end
		end

		arg_611_1.nodeConfigList_ = {}

		arg_611_1:InitPlayNodeList()
	end,
	Play102604151 = function(arg_615_0, arg_615_1)
		arg_615_1.time_ = 0
		arg_615_1.frameCnt_ = 0
		arg_615_1.state_ = "playing"
		arg_615_1.curTalkId_ = 102604151
		arg_615_1.duration_ = 5

		SetActive(arg_615_1.tipsGo_, false)

		function arg_615_1.onSingleLineFinish_()
			arg_615_1.onSingleLineUpdate_ = nil
			arg_615_1.onSingleLineFinish_ = nil
			arg_615_1.state_ = "waiting"
		end

		function arg_615_1.playNext_(arg_617_0)
			if arg_617_0 == 1 then
				arg_615_0:Play102604152(arg_615_1)
			end
		end

		function arg_615_1.onSingleLineUpdate_(arg_618_0)
			local var_618_0 = 1.025

			if 0 < arg_615_1.time_ and arg_615_1.time_ <= 0 + arg_618_0 then
				arg_615_1.talkMaxDuration = 0
				arg_615_1.dialogCg_.alpha = 1

				arg_615_1.dialog_:SetActive(true)
				SetActive(arg_615_1.leftNameGo_, false)

				arg_615_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_615_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_615_1:RecordName(arg_615_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_615_1.iconTrs_.gameObject, false)
				arg_615_1.callingController_:SetSelectedState("normal")

				local var_618_1 = arg_615_1:FormatText(arg_615_1:GetWordFromCfg(102604151).content)

				arg_615_1.text_.text = var_618_1

				LuaForUtil.ClearLinePrefixSymbol(arg_615_1.text_)

				local var_618_3 = 43 <= 0 and var_618_0 or var_618_0 * (utf8.len(var_618_1) / 43)

				if (43 <= 0 and var_618_0 or var_618_0 * (utf8.len(var_618_1) / 43)) > 0 and var_618_0 < var_618_3 then
					arg_615_1.talkMaxDuration = var_618_3

					if var_618_3 + 0 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_3 + 0
					end
				end

				arg_615_1.text_.text = var_618_1
				arg_615_1.typewritter.percent = 0

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(false)
				arg_615_1:RecordContent(arg_615_1.text_.text)
			end

			local var_618_4 = math.max(var_618_0, arg_615_1.talkMaxDuration)

			if 0 <= arg_615_1.time_ and arg_615_1.time_ < 0 + var_618_4 then
				arg_615_1.typewritter.percent = (arg_615_1.time_ - 0) / var_618_4

				arg_615_1.typewritter:SetDirty()
			end

			if arg_615_1.time_ >= 0 + var_618_4 and arg_615_1.time_ < 0 + var_618_4 + arg_618_0 then
				arg_615_1.typewritter.percent = 1

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(true)
			end
		end

		arg_615_1.nodeConfigList_ = {}

		arg_615_1:InitPlayNodeList()
	end,
	Play102604152 = function(arg_619_0, arg_619_1)
		arg_619_1.time_ = 0
		arg_619_1.frameCnt_ = 0
		arg_619_1.state_ = "playing"
		arg_619_1.curTalkId_ = 102604152
		arg_619_1.duration_ = 5

		SetActive(arg_619_1.tipsGo_, false)

		function arg_619_1.onSingleLineFinish_()
			arg_619_1.onSingleLineUpdate_ = nil
			arg_619_1.onSingleLineFinish_ = nil
			arg_619_1.state_ = "waiting"
		end

		function arg_619_1.playNext_(arg_621_0)
			if arg_621_0 == 1 then
				arg_619_0:Play102604153(arg_619_1)
			end
		end

		function arg_619_1.onSingleLineUpdate_(arg_622_0)
			local var_622_0 = 1.2

			if 0 < arg_619_1.time_ and arg_619_1.time_ <= 0 + arg_622_0 then
				arg_619_1.talkMaxDuration = 0
				arg_619_1.dialogCg_.alpha = 1

				arg_619_1.dialog_:SetActive(true)
				SetActive(arg_619_1.leftNameGo_, false)

				arg_619_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_619_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_619_1:RecordName(arg_619_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_619_1.iconTrs_.gameObject, false)
				arg_619_1.callingController_:SetSelectedState("normal")

				local var_622_1 = arg_619_1:FormatText(arg_619_1:GetWordFromCfg(102604152).content)

				arg_619_1.text_.text = var_622_1

				LuaForUtil.ClearLinePrefixSymbol(arg_619_1.text_)

				local var_622_3 = 50 <= 0 and var_622_0 or var_622_0 * (utf8.len(var_622_1) / 50)

				if (50 <= 0 and var_622_0 or var_622_0 * (utf8.len(var_622_1) / 50)) > 0 and var_622_0 < var_622_3 then
					arg_619_1.talkMaxDuration = var_622_3

					if var_622_3 + 0 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_3 + 0
					end
				end

				arg_619_1.text_.text = var_622_1
				arg_619_1.typewritter.percent = 0

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(false)
				arg_619_1:RecordContent(arg_619_1.text_.text)
			end

			local var_622_4 = math.max(var_622_0, arg_619_1.talkMaxDuration)

			if 0 <= arg_619_1.time_ and arg_619_1.time_ < 0 + var_622_4 then
				arg_619_1.typewritter.percent = (arg_619_1.time_ - 0) / var_622_4

				arg_619_1.typewritter:SetDirty()
			end

			if arg_619_1.time_ >= 0 + var_622_4 and arg_619_1.time_ < 0 + var_622_4 + arg_622_0 then
				arg_619_1.typewritter.percent = 1

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(true)
			end
		end

		arg_619_1.nodeConfigList_ = {}

		arg_619_1:InitPlayNodeList()
	end,
	Play102604153 = function(arg_623_0, arg_623_1)
		arg_623_1.time_ = 0
		arg_623_1.frameCnt_ = 0
		arg_623_1.state_ = "playing"
		arg_623_1.curTalkId_ = 102604153
		arg_623_1.duration_ = 5

		SetActive(arg_623_1.tipsGo_, false)

		function arg_623_1.onSingleLineFinish_()
			arg_623_1.onSingleLineUpdate_ = nil
			arg_623_1.onSingleLineFinish_ = nil
			arg_623_1.state_ = "waiting"
		end

		function arg_623_1.playNext_(arg_625_0)
			if arg_625_0 == 1 then
				arg_623_0:Play102604154(arg_623_1)
			end
		end

		function arg_623_1.onSingleLineUpdate_(arg_626_0)
			local var_626_0 = 0.65

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 then
				arg_623_1.talkMaxDuration = 0
				arg_623_1.dialogCg_.alpha = 1

				arg_623_1.dialog_:SetActive(true)
				SetActive(arg_623_1.leftNameGo_, false)

				arg_623_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_623_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_623_1:RecordName(arg_623_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_623_1.iconTrs_.gameObject, false)
				arg_623_1.callingController_:SetSelectedState("normal")

				local var_626_1 = arg_623_1:FormatText(arg_623_1:GetWordFromCfg(102604153).content)

				arg_623_1.text_.text = var_626_1

				LuaForUtil.ClearLinePrefixSymbol(arg_623_1.text_)

				local var_626_3 = 28 <= 0 and var_626_0 or var_626_0 * (utf8.len(var_626_1) / 28)

				if (28 <= 0 and var_626_0 or var_626_0 * (utf8.len(var_626_1) / 28)) > 0 and var_626_0 < var_626_3 then
					arg_623_1.talkMaxDuration = var_626_3

					if var_626_3 + 0 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_3 + 0
					end
				end

				arg_623_1.text_.text = var_626_1
				arg_623_1.typewritter.percent = 0

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(false)
				arg_623_1:RecordContent(arg_623_1.text_.text)
			end

			local var_626_4 = math.max(var_626_0, arg_623_1.talkMaxDuration)

			if 0 <= arg_623_1.time_ and arg_623_1.time_ < 0 + var_626_4 then
				arg_623_1.typewritter.percent = (arg_623_1.time_ - 0) / var_626_4

				arg_623_1.typewritter:SetDirty()
			end

			if arg_623_1.time_ >= 0 + var_626_4 and arg_623_1.time_ < 0 + var_626_4 + arg_626_0 then
				arg_623_1.typewritter.percent = 1

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(true)
			end
		end

		arg_623_1.nodeConfigList_ = {}

		arg_623_1:InitPlayNodeList()
	end,
	Play102604154 = function(arg_627_0, arg_627_1)
		arg_627_1.time_ = 0
		arg_627_1.frameCnt_ = 0
		arg_627_1.state_ = "playing"
		arg_627_1.curTalkId_ = 102604154
		arg_627_1.duration_ = 5.77

		local var_627_0 = {
			ja = 5.766,
			ko = 2.7,
			zh = 4.3,
			en = 3
		}
		local var_627_1 = manager.audio:GetLocalizationFlag()

		if var_627_0[var_627_1] ~= nil then
			arg_627_1.duration_ = var_627_0[var_627_1]
		end

		SetActive(arg_627_1.tipsGo_, false)

		function arg_627_1.onSingleLineFinish_()
			arg_627_1.onSingleLineUpdate_ = nil
			arg_627_1.onSingleLineFinish_ = nil
			arg_627_1.state_ = "waiting"
		end

		function arg_627_1.playNext_(arg_629_0)
			if arg_629_0 == 1 then
				arg_627_0:Play102604155(arg_627_1)
			end
		end

		function arg_627_1.onSingleLineUpdate_(arg_630_0)
			local var_630_0 = 0.2

			if 0 < arg_627_1.time_ and arg_627_1.time_ <= 0 + arg_630_0 then
				arg_627_1.talkMaxDuration = 0
				arg_627_1.dialogCg_.alpha = 1

				arg_627_1.dialog_:SetActive(true)
				SetActive(arg_627_1.leftNameGo_, true)

				arg_627_1.leftNameTxt_.text = arg_627_1:FormatText(StoryNameCfg[200].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_627_1.leftNameTxt_.transform)

				arg_627_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_627_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_627_1:RecordName(arg_627_1.leftNameTxt_.text)
				SetActive(arg_627_1.iconTrs_.gameObject, false)
				arg_627_1.callingController_:SetSelectedState("normal")

				local var_630_1 = arg_627_1:GetWordFromCfg(102604154)
				local var_630_2 = arg_627_1:FormatText(var_630_1.content)

				arg_627_1.text_.text = var_630_2

				LuaForUtil.ClearLinePrefixSymbol(arg_627_1.text_)

				local var_630_4 = 8 <= 0 and var_630_0 or var_630_0 * (utf8.len(var_630_2) / 8)

				if (8 <= 0 and var_630_0 or var_630_0 * (utf8.len(var_630_2) / 8)) > 0 and var_630_0 < var_630_4 then
					arg_627_1.talkMaxDuration = var_630_4

					if var_630_4 + 0 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_4 + 0
					end
				end

				arg_627_1.text_.text = var_630_2
				arg_627_1.typewritter.percent = 0

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604154", "story_v_side_old_102604.awb") ~= 0 then
					local var_630_5 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604154", "story_v_side_old_102604.awb") / 1000

					if var_630_5 + 0 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_5 + 0
					end

					if var_630_1.prefab_name ~= "" and arg_627_1.actors_[var_630_1.prefab_name] ~= nil then
						local var_630_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_627_1.actors_[var_630_1.prefab_name].transform, "story_v_side_old_102604", "102604154", "story_v_side_old_102604.awb")

						arg_627_1:RecordAudio("102604154", var_630_6)
						arg_627_1:RecordAudio("102604154", var_630_6)
					else
						arg_627_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604154", "story_v_side_old_102604.awb")
					end

					arg_627_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604154", "story_v_side_old_102604.awb")
				end

				arg_627_1:RecordContent(arg_627_1.text_.text)
			end

			local var_630_7 = math.max(var_630_0, arg_627_1.talkMaxDuration)

			if 0 <= arg_627_1.time_ and arg_627_1.time_ < 0 + var_630_7 then
				arg_627_1.typewritter.percent = (arg_627_1.time_ - 0) / var_630_7

				arg_627_1.typewritter:SetDirty()
			end

			if arg_627_1.time_ >= 0 + var_630_7 and arg_627_1.time_ < 0 + var_630_7 + arg_630_0 then
				arg_627_1.typewritter.percent = 1

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(true)
			end
		end

		arg_627_1.nodeConfigList_ = {}

		arg_627_1:InitPlayNodeList()
	end,
	Play102604155 = function(arg_631_0, arg_631_1)
		arg_631_1.time_ = 0
		arg_631_1.frameCnt_ = 0
		arg_631_1.state_ = "playing"
		arg_631_1.curTalkId_ = 102604155
		arg_631_1.duration_ = 5

		SetActive(arg_631_1.tipsGo_, false)

		function arg_631_1.onSingleLineFinish_()
			arg_631_1.onSingleLineUpdate_ = nil
			arg_631_1.onSingleLineFinish_ = nil
			arg_631_1.state_ = "waiting"
		end

		function arg_631_1.playNext_(arg_633_0)
			if arg_633_0 == 1 then
				arg_631_0:Play102604156(arg_631_1)
			end
		end

		function arg_631_1.onSingleLineUpdate_(arg_634_0)
			local var_634_0 = 1.6

			if 0 < arg_631_1.time_ and arg_631_1.time_ <= 0 + arg_634_0 then
				arg_631_1.talkMaxDuration = 0
				arg_631_1.dialogCg_.alpha = 1

				arg_631_1.dialog_:SetActive(true)
				SetActive(arg_631_1.leftNameGo_, false)

				arg_631_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_631_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_631_1:RecordName(arg_631_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_631_1.iconTrs_.gameObject, false)
				arg_631_1.callingController_:SetSelectedState("normal")

				local var_634_1 = arg_631_1:FormatText(arg_631_1:GetWordFromCfg(102604155).content)

				arg_631_1.text_.text = var_634_1

				LuaForUtil.ClearLinePrefixSymbol(arg_631_1.text_)

				local var_634_3 = 64 <= 0 and var_634_0 or var_634_0 * (utf8.len(var_634_1) / 64)

				if (64 <= 0 and var_634_0 or var_634_0 * (utf8.len(var_634_1) / 64)) > 0 and var_634_0 < var_634_3 then
					arg_631_1.talkMaxDuration = var_634_3

					if var_634_3 + 0 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_3 + 0
					end
				end

				arg_631_1.text_.text = var_634_1
				arg_631_1.typewritter.percent = 0

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(false)
				arg_631_1:RecordContent(arg_631_1.text_.text)
			end

			local var_634_4 = math.max(var_634_0, arg_631_1.talkMaxDuration)

			if 0 <= arg_631_1.time_ and arg_631_1.time_ < 0 + var_634_4 then
				arg_631_1.typewritter.percent = (arg_631_1.time_ - 0) / var_634_4

				arg_631_1.typewritter:SetDirty()
			end

			if arg_631_1.time_ >= 0 + var_634_4 and arg_631_1.time_ < 0 + var_634_4 + arg_634_0 then
				arg_631_1.typewritter.percent = 1

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(true)
			end
		end

		arg_631_1.nodeConfigList_ = {}

		arg_631_1:InitPlayNodeList()
	end,
	Play102604156 = function(arg_635_0, arg_635_1)
		arg_635_1.time_ = 0
		arg_635_1.frameCnt_ = 0
		arg_635_1.state_ = "playing"
		arg_635_1.curTalkId_ = 102604156
		arg_635_1.duration_ = 6.9

		local var_635_0 = {
			ja = 6.9,
			ko = 4.666,
			zh = 5.4,
			en = 4.966
		}
		local var_635_1 = manager.audio:GetLocalizationFlag()

		if var_635_0[var_635_1] ~= nil then
			arg_635_1.duration_ = var_635_0[var_635_1]
		end

		SetActive(arg_635_1.tipsGo_, false)

		function arg_635_1.onSingleLineFinish_()
			arg_635_1.onSingleLineUpdate_ = nil
			arg_635_1.onSingleLineFinish_ = nil
			arg_635_1.state_ = "waiting"
		end

		function arg_635_1.playNext_(arg_637_0)
			if arg_637_0 == 1 then
				arg_635_0:Play102604157(arg_635_1)
			end
		end

		function arg_635_1.onSingleLineUpdate_(arg_638_0)
			local var_638_0 = 0.55

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 then
				arg_635_1.talkMaxDuration = 0
				arg_635_1.dialogCg_.alpha = 1

				arg_635_1.dialog_:SetActive(true)
				SetActive(arg_635_1.leftNameGo_, true)

				arg_635_1.leftNameTxt_.text = arg_635_1:FormatText(StoryNameCfg[200].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_635_1.leftNameTxt_.transform)

				arg_635_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_635_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_635_1:RecordName(arg_635_1.leftNameTxt_.text)
				SetActive(arg_635_1.iconTrs_.gameObject, false)
				arg_635_1.callingController_:SetSelectedState("normal")

				local var_638_1 = arg_635_1:GetWordFromCfg(102604156)
				local var_638_2 = arg_635_1:FormatText(var_638_1.content)

				arg_635_1.text_.text = var_638_2

				LuaForUtil.ClearLinePrefixSymbol(arg_635_1.text_)

				local var_638_4 = 22 <= 0 and var_638_0 or var_638_0 * (utf8.len(var_638_2) / 22)

				if (22 <= 0 and var_638_0 or var_638_0 * (utf8.len(var_638_2) / 22)) > 0 and var_638_0 < var_638_4 then
					arg_635_1.talkMaxDuration = var_638_4

					if var_638_4 + 0 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_4 + 0
					end
				end

				arg_635_1.text_.text = var_638_2
				arg_635_1.typewritter.percent = 0

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604156", "story_v_side_old_102604.awb") ~= 0 then
					local var_638_5 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604156", "story_v_side_old_102604.awb") / 1000

					if var_638_5 + 0 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_5 + 0
					end

					if var_638_1.prefab_name ~= "" and arg_635_1.actors_[var_638_1.prefab_name] ~= nil then
						local var_638_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_635_1.actors_[var_638_1.prefab_name].transform, "story_v_side_old_102604", "102604156", "story_v_side_old_102604.awb")

						arg_635_1:RecordAudio("102604156", var_638_6)
						arg_635_1:RecordAudio("102604156", var_638_6)
					else
						arg_635_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604156", "story_v_side_old_102604.awb")
					end

					arg_635_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604156", "story_v_side_old_102604.awb")
				end

				arg_635_1:RecordContent(arg_635_1.text_.text)
			end

			local var_638_7 = math.max(var_638_0, arg_635_1.talkMaxDuration)

			if 0 <= arg_635_1.time_ and arg_635_1.time_ < 0 + var_638_7 then
				arg_635_1.typewritter.percent = (arg_635_1.time_ - 0) / var_638_7

				arg_635_1.typewritter:SetDirty()
			end

			if arg_635_1.time_ >= 0 + var_638_7 and arg_635_1.time_ < 0 + var_638_7 + arg_638_0 then
				arg_635_1.typewritter.percent = 1

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(true)
			end
		end

		arg_635_1.nodeConfigList_ = {}

		arg_635_1:InitPlayNodeList()
	end,
	Play102604157 = function(arg_639_0, arg_639_1)
		arg_639_1.time_ = 0
		arg_639_1.frameCnt_ = 0
		arg_639_1.state_ = "playing"
		arg_639_1.curTalkId_ = 102604157
		arg_639_1.duration_ = 2

		SetActive(arg_639_1.tipsGo_, false)

		function arg_639_1.onSingleLineFinish_()
			arg_639_1.onSingleLineUpdate_ = nil
			arg_639_1.onSingleLineFinish_ = nil
			arg_639_1.state_ = "waiting"
		end

		function arg_639_1.playNext_(arg_641_0)
			if arg_641_0 == 1 then
				arg_639_0:Play102604158(arg_639_1)
			end
		end

		function arg_639_1.onSingleLineUpdate_(arg_642_0)
			if 0 < arg_639_1.time_ and arg_639_1.time_ <= 0 + arg_642_0 then
				arg_639_1.var_.moveOldPos1026ui_story = arg_639_1.actors_["1026ui_story"].transform.localPosition
			end

			local var_642_0 = 0.001

			if 0 <= arg_639_1.time_ and arg_639_1.time_ < 0 + var_642_0 then
				arg_639_1.actors_["1026ui_story"].transform.localPosition = Vector3.Lerp(arg_639_1.var_.moveOldPos1026ui_story, Vector3.New(0, -1.05, -6.2), (arg_639_1.time_ - 0) / var_642_0)
				arg_639_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_639_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_639_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_639_1.actors_["1026ui_story"].transform.position).z)
				arg_639_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_639_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_639_1.actors_["1026ui_story"].transform.localEulerAngles = arg_639_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			if arg_639_1.time_ >= 0 + var_642_0 and arg_639_1.time_ < 0 + var_642_0 + arg_642_0 then
				arg_639_1.actors_["1026ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.2)
				arg_639_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_639_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_639_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_639_1.actors_["1026ui_story"].transform.position).z)
				arg_639_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_639_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_639_1.actors_["1026ui_story"].transform.localEulerAngles = arg_639_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			local var_642_1 = arg_639_1.actors_["1026ui_story"]

			if 0 < arg_639_1.time_ and arg_639_1.time_ <= 0 + arg_642_0 and not isNil(var_642_1) and arg_639_1.var_.characterEffect1026ui_story == nil then
				arg_639_1.var_.characterEffect1026ui_story = var_642_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_642_2 = 0.2

			if 0 <= arg_639_1.time_ and arg_639_1.time_ < 0 + var_642_2 and not isNil(var_642_1) then
				if arg_639_1.var_.characterEffect1026ui_story and not isNil(var_642_1) then
					arg_639_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_639_1.time_ >= 0 + var_642_2 and arg_639_1.time_ < 0 + var_642_2 + arg_642_0 and not isNil(var_642_1) and arg_639_1.var_.characterEffect1026ui_story then
				arg_639_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			if 0 < arg_639_1.time_ and arg_639_1.time_ <= 0 + arg_642_0 then
				arg_639_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			if 0 < arg_639_1.time_ and arg_639_1.time_ <= 0 + arg_642_0 then
				arg_639_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action1_1")
			end

			local var_642_4 = 0
			local var_642_5 = 0.075

			if 0 < arg_639_1.time_ and arg_639_1.time_ <= var_642_4 + arg_642_0 then
				arg_639_1.talkMaxDuration = 0
				arg_639_1.dialogCg_.alpha = 1

				arg_639_1.dialog_:SetActive(true)
				SetActive(arg_639_1.leftNameGo_, true)

				arg_639_1.leftNameTxt_.text = arg_639_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_639_1.leftNameTxt_.transform)

				arg_639_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_639_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_639_1:RecordName(arg_639_1.leftNameTxt_.text)
				SetActive(arg_639_1.iconTrs_.gameObject, false)
				arg_639_1.callingController_:SetSelectedState("normal")

				local var_642_6 = arg_639_1:GetWordFromCfg(102604157)
				local var_642_7 = arg_639_1:FormatText(var_642_6.content)

				arg_639_1.text_.text = var_642_7

				LuaForUtil.ClearLinePrefixSymbol(arg_639_1.text_)

				local var_642_9 = 3 <= 0 and var_642_5 or var_642_5 * (utf8.len(var_642_7) / 3)

				if (3 <= 0 and var_642_5 or var_642_5 * (utf8.len(var_642_7) / 3)) > 0 and var_642_5 < var_642_9 then
					arg_639_1.talkMaxDuration = var_642_9

					if var_642_9 + var_642_4 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_9 + var_642_4
					end
				end

				arg_639_1.text_.text = var_642_7
				arg_639_1.typewritter.percent = 0

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604157", "story_v_side_old_102604.awb") ~= 0 then
					local var_642_10 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604157", "story_v_side_old_102604.awb") / 1000

					if var_642_10 + var_642_4 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_10 + var_642_4
					end

					if var_642_6.prefab_name ~= "" and arg_639_1.actors_[var_642_6.prefab_name] ~= nil then
						local var_642_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_639_1.actors_[var_642_6.prefab_name].transform, "story_v_side_old_102604", "102604157", "story_v_side_old_102604.awb")

						arg_639_1:RecordAudio("102604157", var_642_11)
						arg_639_1:RecordAudio("102604157", var_642_11)
					else
						arg_639_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604157", "story_v_side_old_102604.awb")
					end

					arg_639_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604157", "story_v_side_old_102604.awb")
				end

				arg_639_1:RecordContent(arg_639_1.text_.text)
			end

			local var_642_12 = math.max(var_642_5, arg_639_1.talkMaxDuration)

			if var_642_4 <= arg_639_1.time_ and arg_639_1.time_ < var_642_4 + var_642_12 then
				arg_639_1.typewritter.percent = (arg_639_1.time_ - var_642_4) / var_642_12

				arg_639_1.typewritter:SetDirty()
			end

			if arg_639_1.time_ >= var_642_4 + var_642_12 and arg_639_1.time_ < var_642_4 + var_642_12 + arg_642_0 then
				arg_639_1.typewritter.percent = 1

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(true)
			end
		end

		arg_639_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_639_1:InitPlayNodeList()
	end,
	Play102604158 = function(arg_643_0, arg_643_1)
		arg_643_1.time_ = 0
		arg_643_1.frameCnt_ = 0
		arg_643_1.state_ = "playing"
		arg_643_1.curTalkId_ = 102604158
		arg_643_1.duration_ = 5

		SetActive(arg_643_1.tipsGo_, false)

		function arg_643_1.onSingleLineFinish_()
			arg_643_1.onSingleLineUpdate_ = nil
			arg_643_1.onSingleLineFinish_ = nil
			arg_643_1.state_ = "waiting"
		end

		function arg_643_1.playNext_(arg_645_0)
			if arg_645_0 == 1 then
				arg_643_0:Play102604159(arg_643_1)
			end
		end

		function arg_643_1.onSingleLineUpdate_(arg_646_0)
			if 0 < arg_643_1.time_ and arg_643_1.time_ <= 0 + arg_646_0 then
				arg_643_1.var_.moveOldPos1026ui_story = arg_643_1.actors_["1026ui_story"].transform.localPosition
			end

			local var_646_0 = 0.001

			if 0 <= arg_643_1.time_ and arg_643_1.time_ < 0 + var_646_0 then
				arg_643_1.actors_["1026ui_story"].transform.localPosition = Vector3.Lerp(arg_643_1.var_.moveOldPos1026ui_story, Vector3.New(0, 100, 0), (arg_643_1.time_ - 0) / var_646_0)
				arg_643_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_643_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_643_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_643_1.actors_["1026ui_story"].transform.position).z)
				arg_643_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_643_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_643_1.actors_["1026ui_story"].transform.localEulerAngles = arg_643_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			if arg_643_1.time_ >= 0 + var_646_0 and arg_643_1.time_ < 0 + var_646_0 + arg_646_0 then
				arg_643_1.actors_["1026ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_643_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_643_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_643_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_643_1.actors_["1026ui_story"].transform.position).z)
				arg_643_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_643_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_643_1.actors_["1026ui_story"].transform.localEulerAngles = arg_643_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			local var_646_1 = 0
			local var_646_2 = 0.45

			if 0 < arg_643_1.time_ and arg_643_1.time_ <= var_646_1 + arg_646_0 then
				arg_643_1.talkMaxDuration = 0
				arg_643_1.dialogCg_.alpha = 1

				arg_643_1.dialog_:SetActive(true)
				SetActive(arg_643_1.leftNameGo_, false)

				arg_643_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_643_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_643_1:RecordName(arg_643_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_643_1.iconTrs_.gameObject, false)
				arg_643_1.callingController_:SetSelectedState("normal")

				local var_646_3 = arg_643_1:FormatText(arg_643_1:GetWordFromCfg(102604158).content)

				arg_643_1.text_.text = var_646_3

				LuaForUtil.ClearLinePrefixSymbol(arg_643_1.text_)

				local var_646_5 = 18 <= 0 and var_646_2 or var_646_2 * (utf8.len(var_646_3) / 18)

				if (18 <= 0 and var_646_2 or var_646_2 * (utf8.len(var_646_3) / 18)) > 0 and var_646_2 < var_646_5 then
					arg_643_1.talkMaxDuration = var_646_5

					if var_646_5 + var_646_1 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_5 + var_646_1
					end
				end

				arg_643_1.text_.text = var_646_3
				arg_643_1.typewritter.percent = 0

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(false)
				arg_643_1:RecordContent(arg_643_1.text_.text)
			end

			local var_646_6 = math.max(var_646_2, arg_643_1.talkMaxDuration)

			if var_646_1 <= arg_643_1.time_ and arg_643_1.time_ < var_646_1 + var_646_6 then
				arg_643_1.typewritter.percent = (arg_643_1.time_ - var_646_1) / var_646_6

				arg_643_1.typewritter:SetDirty()
			end

			if arg_643_1.time_ >= var_646_1 + var_646_6 and arg_643_1.time_ < var_646_1 + var_646_6 + arg_646_0 then
				arg_643_1.typewritter.percent = 1

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(true)
			end
		end

		arg_643_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_643_1:InitPlayNodeList()
	end,
	Play102604159 = function(arg_647_0, arg_647_1)
		arg_647_1.time_ = 0
		arg_647_1.frameCnt_ = 0
		arg_647_1.state_ = "playing"
		arg_647_1.curTalkId_ = 102604159
		arg_647_1.duration_ = 5

		SetActive(arg_647_1.tipsGo_, false)

		function arg_647_1.onSingleLineFinish_()
			arg_647_1.onSingleLineUpdate_ = nil
			arg_647_1.onSingleLineFinish_ = nil
			arg_647_1.state_ = "waiting"
		end

		function arg_647_1.playNext_(arg_649_0)
			if arg_649_0 == 1 then
				arg_647_0:Play102604160(arg_647_1)
			end
		end

		function arg_647_1.onSingleLineUpdate_(arg_650_0)
			local var_650_0 = 1.2

			if 0 < arg_647_1.time_ and arg_647_1.time_ <= 0 + arg_650_0 then
				arg_647_1.talkMaxDuration = 0
				arg_647_1.dialogCg_.alpha = 1

				arg_647_1.dialog_:SetActive(true)
				SetActive(arg_647_1.leftNameGo_, false)

				arg_647_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_647_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_647_1:RecordName(arg_647_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_647_1.iconTrs_.gameObject, false)
				arg_647_1.callingController_:SetSelectedState("normal")

				local var_650_1 = arg_647_1:FormatText(arg_647_1:GetWordFromCfg(102604159).content)

				arg_647_1.text_.text = var_650_1

				LuaForUtil.ClearLinePrefixSymbol(arg_647_1.text_)

				local var_650_3 = 52 <= 0 and var_650_0 or var_650_0 * (utf8.len(var_650_1) / 52)

				if (52 <= 0 and var_650_0 or var_650_0 * (utf8.len(var_650_1) / 52)) > 0 and var_650_0 < var_650_3 then
					arg_647_1.talkMaxDuration = var_650_3

					if var_650_3 + 0 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_3 + 0
					end
				end

				arg_647_1.text_.text = var_650_1
				arg_647_1.typewritter.percent = 0

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(false)
				arg_647_1:RecordContent(arg_647_1.text_.text)
			end

			local var_650_4 = math.max(var_650_0, arg_647_1.talkMaxDuration)

			if 0 <= arg_647_1.time_ and arg_647_1.time_ < 0 + var_650_4 then
				arg_647_1.typewritter.percent = (arg_647_1.time_ - 0) / var_650_4

				arg_647_1.typewritter:SetDirty()
			end

			if arg_647_1.time_ >= 0 + var_650_4 and arg_647_1.time_ < 0 + var_650_4 + arg_650_0 then
				arg_647_1.typewritter.percent = 1

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(true)
			end
		end

		arg_647_1.nodeConfigList_ = {}

		arg_647_1:InitPlayNodeList()
	end,
	Play102604160 = function(arg_651_0, arg_651_1)
		arg_651_1.time_ = 0
		arg_651_1.frameCnt_ = 0
		arg_651_1.state_ = "playing"
		arg_651_1.curTalkId_ = 102604160
		arg_651_1.duration_ = 5

		SetActive(arg_651_1.tipsGo_, false)

		function arg_651_1.onSingleLineFinish_()
			arg_651_1.onSingleLineUpdate_ = nil
			arg_651_1.onSingleLineFinish_ = nil
			arg_651_1.state_ = "waiting"
		end

		function arg_651_1.playNext_(arg_653_0)
			if arg_653_0 == 1 then
				arg_651_0:Play102604161(arg_651_1)
			end
		end

		function arg_651_1.onSingleLineUpdate_(arg_654_0)
			local var_654_0 = 1.35

			if 0 < arg_651_1.time_ and arg_651_1.time_ <= 0 + arg_654_0 then
				arg_651_1.talkMaxDuration = 0
				arg_651_1.dialogCg_.alpha = 1

				arg_651_1.dialog_:SetActive(true)
				SetActive(arg_651_1.leftNameGo_, false)

				arg_651_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_651_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_651_1:RecordName(arg_651_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_651_1.iconTrs_.gameObject, false)
				arg_651_1.callingController_:SetSelectedState("normal")

				local var_654_1 = arg_651_1:FormatText(arg_651_1:GetWordFromCfg(102604160).content)

				arg_651_1.text_.text = var_654_1

				LuaForUtil.ClearLinePrefixSymbol(arg_651_1.text_)

				local var_654_3 = 56 <= 0 and var_654_0 or var_654_0 * (utf8.len(var_654_1) / 56)

				if (56 <= 0 and var_654_0 or var_654_0 * (utf8.len(var_654_1) / 56)) > 0 and var_654_0 < var_654_3 then
					arg_651_1.talkMaxDuration = var_654_3

					if var_654_3 + 0 > arg_651_1.duration_ then
						arg_651_1.duration_ = var_654_3 + 0
					end
				end

				arg_651_1.text_.text = var_654_1
				arg_651_1.typewritter.percent = 0

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(false)
				arg_651_1:RecordContent(arg_651_1.text_.text)
			end

			local var_654_4 = math.max(var_654_0, arg_651_1.talkMaxDuration)

			if 0 <= arg_651_1.time_ and arg_651_1.time_ < 0 + var_654_4 then
				arg_651_1.typewritter.percent = (arg_651_1.time_ - 0) / var_654_4

				arg_651_1.typewritter:SetDirty()
			end

			if arg_651_1.time_ >= 0 + var_654_4 and arg_651_1.time_ < 0 + var_654_4 + arg_654_0 then
				arg_651_1.typewritter.percent = 1

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(true)
			end
		end

		arg_651_1.nodeConfigList_ = {}

		arg_651_1:InitPlayNodeList()
	end,
	Play102604161 = function(arg_655_0, arg_655_1)
		arg_655_1.time_ = 0
		arg_655_1.frameCnt_ = 0
		arg_655_1.state_ = "playing"
		arg_655_1.curTalkId_ = 102604161
		arg_655_1.duration_ = 7

		SetActive(arg_655_1.tipsGo_, false)

		function arg_655_1.onSingleLineFinish_()
			arg_655_1.onSingleLineUpdate_ = nil
			arg_655_1.onSingleLineFinish_ = nil
			arg_655_1.state_ = "waiting"
		end

		function arg_655_1.playNext_(arg_657_0)
			if arg_657_0 == 1 then
				arg_655_0:Play102604162(arg_655_1)
			end
		end

		function arg_655_1.onSingleLineUpdate_(arg_658_0)
			if 0 < arg_655_1.time_ and arg_655_1.time_ <= 0 + arg_658_0 then
				arg_655_1.mask_.enabled = true
				arg_655_1.mask_.raycastTarget = false

				arg_655_1:SetGaussion(false)
			end

			local var_658_0 = 1.5

			if 0 <= arg_655_1.time_ and arg_655_1.time_ < 0 + var_658_0 then
				local var_658_1 = Color.New(1, 1, 1)

				var_658_1.a = Mathf.Lerp(1, 0, (arg_655_1.time_ - 0) / var_658_0)
				arg_655_1.mask_.color = var_658_1
			end

			if arg_655_1.time_ >= 0 + var_658_0 and arg_655_1.time_ < 0 + var_658_0 + arg_658_0 then
				local var_658_2 = Color.New(1, 1, 1)

				arg_655_1.mask_.enabled = false
				var_658_2.a = 0
				arg_655_1.mask_.color = var_658_2
			end

			local var_658_3 = manager.ui.mainCamera.transform

			if 1.5 < arg_655_1.time_ and arg_655_1.time_ <= 1.5 + arg_658_0 then
				arg_655_1.var_.shakeOldPos = var_658_3.localPosition
			end

			local var_658_4 = 0.6

			if 1.5 <= arg_655_1.time_ and arg_655_1.time_ < 1.5 + var_658_4 then
				local var_658_5, var_658_6 = math.modf((arg_655_1.time_ - 1.5) / 0.066)

				var_658_3.localPosition = Vector3.New(var_658_6 * 0.13, var_658_6 * 0.13, var_658_6 * 0.13) + arg_655_1.var_.shakeOldPos
			end

			if arg_655_1.time_ >= 1.5 + var_658_4 and arg_655_1.time_ < 1.5 + var_658_4 + arg_658_0 then
				var_658_3.localPosition = arg_655_1.var_.shakeOldPos
			end

			if 2.26666666666667 < arg_655_1.time_ and arg_655_1.time_ <= 2.26666666666667 + arg_658_0 then
				arg_655_1:AudioAction("play", "effect", "se_story_side_1026", "se_story_1026_burst", "")
			end

			if arg_655_1.frameCnt_ <= 1 then
				arg_655_1.dialog_:SetActive(false)
			end

			local var_658_8 = 2
			local var_658_9 = 0.875

			if 2 < arg_655_1.time_ and arg_655_1.time_ <= var_658_8 + arg_658_0 then
				arg_655_1.talkMaxDuration = 0

				arg_655_1.dialog_:SetActive(true)

				arg_655_1.dialogCg_.alpha = 0

				local var_658_10 = LeanTween.value(arg_655_1.dialog_, 0, 1, 0.3)

				var_658_10:setOnUpdate(LuaHelper.FloatAction(function(arg_659_0)
					arg_655_1.dialogCg_.alpha = arg_659_0
				end))
				var_658_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_655_1.dialog_)
					var_658_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_655_1.duration_ = arg_655_1.duration_ + 0.3

				SetActive(arg_655_1.leftNameGo_, false)

				arg_655_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_655_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_655_1:RecordName(arg_655_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_655_1.iconTrs_.gameObject, false)
				arg_655_1.callingController_:SetSelectedState("normal")

				local var_658_11 = arg_655_1:FormatText(arg_655_1:GetWordFromCfg(102604161).content)

				arg_655_1.text_.text = var_658_11

				LuaForUtil.ClearLinePrefixSymbol(arg_655_1.text_)

				local var_658_13 = 37 <= 0 and var_658_9 or var_658_9 * (utf8.len(var_658_11) / 37)

				if (37 <= 0 and var_658_9 or var_658_9 * (utf8.len(var_658_11) / 37)) > 0 and var_658_9 < var_658_13 then
					arg_655_1.talkMaxDuration = var_658_13
					var_658_8 = var_658_8 + 0.3

					if var_658_13 + var_658_8 > arg_655_1.duration_ then
						arg_655_1.duration_ = var_658_13 + var_658_8
					end
				end

				arg_655_1.text_.text = var_658_11
				arg_655_1.typewritter.percent = 0

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(false)
				arg_655_1:RecordContent(arg_655_1.text_.text)
			end

			local var_658_14 = var_658_8 + 0.3
			local var_658_15 = math.max(var_658_9, arg_655_1.talkMaxDuration)

			if var_658_8 + 0.3 <= arg_655_1.time_ and arg_655_1.time_ < var_658_14 + var_658_15 then
				arg_655_1.typewritter.percent = (arg_655_1.time_ - var_658_14) / var_658_15

				arg_655_1.typewritter:SetDirty()
			end

			if arg_655_1.time_ >= var_658_14 + var_658_15 and arg_655_1.time_ < var_658_14 + var_658_15 + arg_658_0 then
				arg_655_1.typewritter.percent = 1

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(true)
			end
		end

		arg_655_1.nodeConfigList_ = {}

		arg_655_1:InitPlayNodeList()
	end,
	Play102604162 = function(arg_661_0, arg_661_1)
		arg_661_1.time_ = 0
		arg_661_1.frameCnt_ = 0
		arg_661_1.state_ = "playing"
		arg_661_1.curTalkId_ = 102604162
		arg_661_1.duration_ = 5

		SetActive(arg_661_1.tipsGo_, false)

		function arg_661_1.onSingleLineFinish_()
			arg_661_1.onSingleLineUpdate_ = nil
			arg_661_1.onSingleLineFinish_ = nil
			arg_661_1.state_ = "waiting"
		end

		function arg_661_1.playNext_(arg_663_0)
			if arg_663_0 == 1 then
				arg_661_0:Play102604163(arg_661_1)
			end
		end

		function arg_661_1.onSingleLineUpdate_(arg_664_0)
			if 0 < arg_661_1.time_ and arg_661_1.time_ <= 0 + arg_664_0 then
				arg_661_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_664_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_661_1.bgmTxt_.text ~= var_664_2 and arg_661_1.bgmTxt_.text ~= "" then
						if arg_661_1.bgmTxt2_.text ~= "" then
							arg_661_1.bgmTxt_.text = arg_661_1.bgmTxt2_.text
						end

						arg_661_1.bgmTxt2_.text = var_664_2

						arg_661_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_661_1.bgmTxt_.text = var_664_2
						arg_661_1.bgmTxt2_.text = var_664_2
					end

					if arg_661_1.bgmTimer then
						arg_661_1.bgmTimer:Stop()

						arg_661_1.bgmTimer = nil
					end

					if arg_661_1.settingData.show_music_name == 1 then
						arg_661_1.musicController:SetSelectedState("show")
						arg_661_1.musicAnimator_:Play("open", 0, 0)

						if arg_661_1.settingData.music_time ~= 0 then
							arg_661_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_661_1.settingData.music_time), function()
								if arg_661_1 == nil or isNil(arg_661_1.bgmTxt_) then
									return
								end

								arg_661_1.musicController:SetSelectedState("hide")
								arg_661_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_664_3 = 0
			local var_664_4 = 0.15

			if 0 < arg_661_1.time_ and arg_661_1.time_ <= var_664_3 + arg_664_0 then
				arg_661_1.talkMaxDuration = 0
				arg_661_1.dialogCg_.alpha = 1

				arg_661_1.dialog_:SetActive(true)
				SetActive(arg_661_1.leftNameGo_, false)

				arg_661_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_661_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_661_1:RecordName(arg_661_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_661_1.iconTrs_.gameObject, false)
				arg_661_1.callingController_:SetSelectedState("normal")

				local var_664_5 = arg_661_1:FormatText(arg_661_1:GetWordFromCfg(102604162).content)

				arg_661_1.text_.text = var_664_5

				LuaForUtil.ClearLinePrefixSymbol(arg_661_1.text_)

				local var_664_7 = 6 <= 0 and var_664_4 or var_664_4 * (utf8.len(var_664_5) / 6)

				if (6 <= 0 and var_664_4 or var_664_4 * (utf8.len(var_664_5) / 6)) > 0 and var_664_4 < var_664_7 then
					arg_661_1.talkMaxDuration = var_664_7

					if var_664_7 + var_664_3 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_7 + var_664_3
					end
				end

				arg_661_1.text_.text = var_664_5
				arg_661_1.typewritter.percent = 0

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(false)
				arg_661_1:RecordContent(arg_661_1.text_.text)
			end

			local var_664_8 = math.max(var_664_4, arg_661_1.talkMaxDuration)

			if var_664_3 <= arg_661_1.time_ and arg_661_1.time_ < var_664_3 + var_664_8 then
				arg_661_1.typewritter.percent = (arg_661_1.time_ - var_664_3) / var_664_8

				arg_661_1.typewritter:SetDirty()
			end

			if arg_661_1.time_ >= var_664_3 + var_664_8 and arg_661_1.time_ < var_664_3 + var_664_8 + arg_664_0 then
				arg_661_1.typewritter.percent = 1

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(true)
			end
		end

		arg_661_1.nodeConfigList_ = {}

		arg_661_1:InitPlayNodeList()
	end,
	Play102604163 = function(arg_666_0, arg_666_1)
		arg_666_1.time_ = 0
		arg_666_1.frameCnt_ = 0
		arg_666_1.state_ = "playing"
		arg_666_1.curTalkId_ = 102604163
		arg_666_1.duration_ = 5

		SetActive(arg_666_1.tipsGo_, false)

		function arg_666_1.onSingleLineFinish_()
			arg_666_1.onSingleLineUpdate_ = nil
			arg_666_1.onSingleLineFinish_ = nil
			arg_666_1.state_ = "waiting"
		end

		function arg_666_1.playNext_(arg_668_0)
			if arg_668_0 == 1 then
				arg_666_0:Play102604164(arg_666_1)
			end
		end

		function arg_666_1.onSingleLineUpdate_(arg_669_0)
			local var_669_0 = 0.95

			if 0 < arg_666_1.time_ and arg_666_1.time_ <= 0 + arg_669_0 then
				arg_666_1.talkMaxDuration = 0
				arg_666_1.dialogCg_.alpha = 1

				arg_666_1.dialog_:SetActive(true)
				SetActive(arg_666_1.leftNameGo_, false)

				arg_666_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_666_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_666_1:RecordName(arg_666_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_666_1.iconTrs_.gameObject, false)
				arg_666_1.callingController_:SetSelectedState("normal")

				local var_669_1 = arg_666_1:FormatText(arg_666_1:GetWordFromCfg(102604163).content)

				arg_666_1.text_.text = var_669_1

				LuaForUtil.ClearLinePrefixSymbol(arg_666_1.text_)

				local var_669_3 = 38 <= 0 and var_669_0 or var_669_0 * (utf8.len(var_669_1) / 38)

				if (38 <= 0 and var_669_0 or var_669_0 * (utf8.len(var_669_1) / 38)) > 0 and var_669_0 < var_669_3 then
					arg_666_1.talkMaxDuration = var_669_3

					if var_669_3 + 0 > arg_666_1.duration_ then
						arg_666_1.duration_ = var_669_3 + 0
					end
				end

				arg_666_1.text_.text = var_669_1
				arg_666_1.typewritter.percent = 0

				arg_666_1.typewritter:SetDirty()
				arg_666_1:ShowNextGo(false)
				arg_666_1:RecordContent(arg_666_1.text_.text)
			end

			local var_669_4 = math.max(var_669_0, arg_666_1.talkMaxDuration)

			if 0 <= arg_666_1.time_ and arg_666_1.time_ < 0 + var_669_4 then
				arg_666_1.typewritter.percent = (arg_666_1.time_ - 0) / var_669_4

				arg_666_1.typewritter:SetDirty()
			end

			if arg_666_1.time_ >= 0 + var_669_4 and arg_666_1.time_ < 0 + var_669_4 + arg_669_0 then
				arg_666_1.typewritter.percent = 1

				arg_666_1.typewritter:SetDirty()
				arg_666_1:ShowNextGo(true)
			end
		end

		arg_666_1.nodeConfigList_ = {}

		arg_666_1:InitPlayNodeList()
	end,
	Play102604164 = function(arg_670_0, arg_670_1)
		arg_670_1.time_ = 0
		arg_670_1.frameCnt_ = 0
		arg_670_1.state_ = "playing"
		arg_670_1.curTalkId_ = 102604164
		arg_670_1.duration_ = 5

		SetActive(arg_670_1.tipsGo_, false)

		function arg_670_1.onSingleLineFinish_()
			arg_670_1.onSingleLineUpdate_ = nil
			arg_670_1.onSingleLineFinish_ = nil
			arg_670_1.state_ = "waiting"
		end

		function arg_670_1.playNext_(arg_672_0)
			if arg_672_0 == 1 then
				arg_670_0:Play102604165(arg_670_1)
			end
		end

		function arg_670_1.onSingleLineUpdate_(arg_673_0)
			local var_673_0 = 0.75

			if 0 < arg_670_1.time_ and arg_670_1.time_ <= 0 + arg_673_0 then
				arg_670_1.talkMaxDuration = 0
				arg_670_1.dialogCg_.alpha = 1

				arg_670_1.dialog_:SetActive(true)
				SetActive(arg_670_1.leftNameGo_, false)

				arg_670_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_670_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_670_1:RecordName(arg_670_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_670_1.iconTrs_.gameObject, false)
				arg_670_1.callingController_:SetSelectedState("normal")

				local var_673_1 = arg_670_1:FormatText(arg_670_1:GetWordFromCfg(102604164).content)

				arg_670_1.text_.text = var_673_1

				LuaForUtil.ClearLinePrefixSymbol(arg_670_1.text_)

				local var_673_3 = 30 <= 0 and var_673_0 or var_673_0 * (utf8.len(var_673_1) / 30)

				if (30 <= 0 and var_673_0 or var_673_0 * (utf8.len(var_673_1) / 30)) > 0 and var_673_0 < var_673_3 then
					arg_670_1.talkMaxDuration = var_673_3

					if var_673_3 + 0 > arg_670_1.duration_ then
						arg_670_1.duration_ = var_673_3 + 0
					end
				end

				arg_670_1.text_.text = var_673_1
				arg_670_1.typewritter.percent = 0

				arg_670_1.typewritter:SetDirty()
				arg_670_1:ShowNextGo(false)
				arg_670_1:RecordContent(arg_670_1.text_.text)
			end

			local var_673_4 = math.max(var_673_0, arg_670_1.talkMaxDuration)

			if 0 <= arg_670_1.time_ and arg_670_1.time_ < 0 + var_673_4 then
				arg_670_1.typewritter.percent = (arg_670_1.time_ - 0) / var_673_4

				arg_670_1.typewritter:SetDirty()
			end

			if arg_670_1.time_ >= 0 + var_673_4 and arg_670_1.time_ < 0 + var_673_4 + arg_673_0 then
				arg_670_1.typewritter.percent = 1

				arg_670_1.typewritter:SetDirty()
				arg_670_1:ShowNextGo(true)
			end
		end

		arg_670_1.nodeConfigList_ = {}

		arg_670_1:InitPlayNodeList()
	end,
	Play102604165 = function(arg_674_0, arg_674_1)
		arg_674_1.time_ = 0
		arg_674_1.frameCnt_ = 0
		arg_674_1.state_ = "playing"
		arg_674_1.curTalkId_ = 102604165
		arg_674_1.duration_ = 5

		SetActive(arg_674_1.tipsGo_, false)

		function arg_674_1.onSingleLineFinish_()
			arg_674_1.onSingleLineUpdate_ = nil
			arg_674_1.onSingleLineFinish_ = nil
			arg_674_1.state_ = "waiting"
		end

		function arg_674_1.playNext_(arg_676_0)
			if arg_676_0 == 1 then
				arg_674_0:Play102604166(arg_674_1)
			end
		end

		function arg_674_1.onSingleLineUpdate_(arg_677_0)
			local var_677_0 = 0.6

			if 0 < arg_674_1.time_ and arg_674_1.time_ <= 0 + arg_677_0 then
				arg_674_1.talkMaxDuration = 0
				arg_674_1.dialogCg_.alpha = 1

				arg_674_1.dialog_:SetActive(true)
				SetActive(arg_674_1.leftNameGo_, false)

				arg_674_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_674_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_674_1:RecordName(arg_674_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_674_1.iconTrs_.gameObject, false)
				arg_674_1.callingController_:SetSelectedState("normal")

				local var_677_1 = arg_674_1:FormatText(arg_674_1:GetWordFromCfg(102604165).content)

				arg_674_1.text_.text = var_677_1

				LuaForUtil.ClearLinePrefixSymbol(arg_674_1.text_)

				local var_677_3 = 24 <= 0 and var_677_0 or var_677_0 * (utf8.len(var_677_1) / 24)

				if (24 <= 0 and var_677_0 or var_677_0 * (utf8.len(var_677_1) / 24)) > 0 and var_677_0 < var_677_3 then
					arg_674_1.talkMaxDuration = var_677_3

					if var_677_3 + 0 > arg_674_1.duration_ then
						arg_674_1.duration_ = var_677_3 + 0
					end
				end

				arg_674_1.text_.text = var_677_1
				arg_674_1.typewritter.percent = 0

				arg_674_1.typewritter:SetDirty()
				arg_674_1:ShowNextGo(false)
				arg_674_1:RecordContent(arg_674_1.text_.text)
			end

			local var_677_4 = math.max(var_677_0, arg_674_1.talkMaxDuration)

			if 0 <= arg_674_1.time_ and arg_674_1.time_ < 0 + var_677_4 then
				arg_674_1.typewritter.percent = (arg_674_1.time_ - 0) / var_677_4

				arg_674_1.typewritter:SetDirty()
			end

			if arg_674_1.time_ >= 0 + var_677_4 and arg_674_1.time_ < 0 + var_677_4 + arg_677_0 then
				arg_674_1.typewritter.percent = 1

				arg_674_1.typewritter:SetDirty()
				arg_674_1:ShowNextGo(true)
			end
		end

		arg_674_1.nodeConfigList_ = {}

		arg_674_1:InitPlayNodeList()
	end,
	Play102604166 = function(arg_678_0, arg_678_1)
		arg_678_1.time_ = 0
		arg_678_1.frameCnt_ = 0
		arg_678_1.state_ = "playing"
		arg_678_1.curTalkId_ = 102604166
		arg_678_1.duration_ = 5

		SetActive(arg_678_1.tipsGo_, false)

		function arg_678_1.onSingleLineFinish_()
			arg_678_1.onSingleLineUpdate_ = nil
			arg_678_1.onSingleLineFinish_ = nil
			arg_678_1.state_ = "waiting"
		end

		function arg_678_1.playNext_(arg_680_0)
			if arg_680_0 == 1 then
				arg_678_0:Play102604167(arg_678_1)
			end
		end

		function arg_678_1.onSingleLineUpdate_(arg_681_0)
			local var_681_0 = 0.45

			if 0 < arg_678_1.time_ and arg_678_1.time_ <= 0 + arg_681_0 then
				arg_678_1.talkMaxDuration = 0
				arg_678_1.dialogCg_.alpha = 1

				arg_678_1.dialog_:SetActive(true)
				SetActive(arg_678_1.leftNameGo_, false)

				arg_678_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_678_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_678_1:RecordName(arg_678_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_678_1.iconTrs_.gameObject, false)
				arg_678_1.callingController_:SetSelectedState("normal")

				local var_681_1 = arg_678_1:FormatText(arg_678_1:GetWordFromCfg(102604166).content)

				arg_678_1.text_.text = var_681_1

				LuaForUtil.ClearLinePrefixSymbol(arg_678_1.text_)

				local var_681_3 = 18 <= 0 and var_681_0 or var_681_0 * (utf8.len(var_681_1) / 18)

				if (18 <= 0 and var_681_0 or var_681_0 * (utf8.len(var_681_1) / 18)) > 0 and var_681_0 < var_681_3 then
					arg_678_1.talkMaxDuration = var_681_3

					if var_681_3 + 0 > arg_678_1.duration_ then
						arg_678_1.duration_ = var_681_3 + 0
					end
				end

				arg_678_1.text_.text = var_681_1
				arg_678_1.typewritter.percent = 0

				arg_678_1.typewritter:SetDirty()
				arg_678_1:ShowNextGo(false)
				arg_678_1:RecordContent(arg_678_1.text_.text)
			end

			local var_681_4 = math.max(var_681_0, arg_678_1.talkMaxDuration)

			if 0 <= arg_678_1.time_ and arg_678_1.time_ < 0 + var_681_4 then
				arg_678_1.typewritter.percent = (arg_678_1.time_ - 0) / var_681_4

				arg_678_1.typewritter:SetDirty()
			end

			if arg_678_1.time_ >= 0 + var_681_4 and arg_678_1.time_ < 0 + var_681_4 + arg_681_0 then
				arg_678_1.typewritter.percent = 1

				arg_678_1.typewritter:SetDirty()
				arg_678_1:ShowNextGo(true)
			end
		end

		arg_678_1.nodeConfigList_ = {}

		arg_678_1:InitPlayNodeList()
	end,
	Play102604167 = function(arg_682_0, arg_682_1)
		arg_682_1.time_ = 0
		arg_682_1.frameCnt_ = 0
		arg_682_1.state_ = "playing"
		arg_682_1.curTalkId_ = 102604167
		arg_682_1.duration_ = 5

		SetActive(arg_682_1.tipsGo_, false)

		function arg_682_1.onSingleLineFinish_()
			arg_682_1.onSingleLineUpdate_ = nil
			arg_682_1.onSingleLineFinish_ = nil
			arg_682_1.state_ = "waiting"
		end

		function arg_682_1.playNext_(arg_684_0)
			if arg_684_0 == 1 then
				arg_682_0:Play102604168(arg_682_1)
			end
		end

		function arg_682_1.onSingleLineUpdate_(arg_685_0)
			local var_685_0 = 0.05

			if 0 < arg_682_1.time_ and arg_682_1.time_ <= 0 + arg_685_0 then
				arg_682_1.talkMaxDuration = 0
				arg_682_1.dialogCg_.alpha = 1

				arg_682_1.dialog_:SetActive(true)
				SetActive(arg_682_1.leftNameGo_, true)

				arg_682_1.leftNameTxt_.text = arg_682_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_682_1.leftNameTxt_.transform)

				arg_682_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_682_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_682_1:RecordName(arg_682_1.leftNameTxt_.text)
				SetActive(arg_682_1.iconTrs_.gameObject, true)
				arg_682_1.iconController_:SetSelectedState("hero")

				arg_682_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_682_1.callingController_:SetSelectedState("normal")

				arg_682_1.keyicon_.color = Color.New(1, 1, 1)
				arg_682_1.icon_.color = Color.New(1, 1, 1)

				local var_685_1 = arg_682_1:FormatText(arg_682_1:GetWordFromCfg(102604167).content)

				arg_682_1.text_.text = var_685_1

				LuaForUtil.ClearLinePrefixSymbol(arg_682_1.text_)

				local var_685_3 = 2 <= 0 and var_685_0 or var_685_0 * (utf8.len(var_685_1) / 2)

				if (2 <= 0 and var_685_0 or var_685_0 * (utf8.len(var_685_1) / 2)) > 0 and var_685_0 < var_685_3 then
					arg_682_1.talkMaxDuration = var_685_3

					if var_685_3 + 0 > arg_682_1.duration_ then
						arg_682_1.duration_ = var_685_3 + 0
					end
				end

				arg_682_1.text_.text = var_685_1
				arg_682_1.typewritter.percent = 0

				arg_682_1.typewritter:SetDirty()
				arg_682_1:ShowNextGo(false)
				arg_682_1:RecordContent(arg_682_1.text_.text)
			end

			local var_685_4 = math.max(var_685_0, arg_682_1.talkMaxDuration)

			if 0 <= arg_682_1.time_ and arg_682_1.time_ < 0 + var_685_4 then
				arg_682_1.typewritter.percent = (arg_682_1.time_ - 0) / var_685_4

				arg_682_1.typewritter:SetDirty()
			end

			if arg_682_1.time_ >= 0 + var_685_4 and arg_682_1.time_ < 0 + var_685_4 + arg_685_0 then
				arg_682_1.typewritter.percent = 1

				arg_682_1.typewritter:SetDirty()
				arg_682_1:ShowNextGo(true)
			end
		end

		arg_682_1.nodeConfigList_ = {}

		arg_682_1:InitPlayNodeList()
	end,
	Play102604168 = function(arg_686_0, arg_686_1)
		arg_686_1.time_ = 0
		arg_686_1.frameCnt_ = 0
		arg_686_1.state_ = "playing"
		arg_686_1.curTalkId_ = 102604168
		arg_686_1.duration_ = 5

		SetActive(arg_686_1.tipsGo_, false)

		function arg_686_1.onSingleLineFinish_()
			arg_686_1.onSingleLineUpdate_ = nil
			arg_686_1.onSingleLineFinish_ = nil
			arg_686_1.state_ = "waiting"
		end

		function arg_686_1.playNext_(arg_688_0)
			if arg_688_0 == 1 then
				arg_686_0:Play102604169(arg_686_1)
			end
		end

		function arg_686_1.onSingleLineUpdate_(arg_689_0)
			local var_689_0 = 0.125

			if 0 < arg_686_1.time_ and arg_686_1.time_ <= 0 + arg_689_0 then
				arg_686_1.talkMaxDuration = 0
				arg_686_1.dialogCg_.alpha = 1

				arg_686_1.dialog_:SetActive(true)
				SetActive(arg_686_1.leftNameGo_, true)

				arg_686_1.leftNameTxt_.text = arg_686_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_686_1.leftNameTxt_.transform)

				arg_686_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_686_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_686_1:RecordName(arg_686_1.leftNameTxt_.text)
				SetActive(arg_686_1.iconTrs_.gameObject, true)
				arg_686_1.iconController_:SetSelectedState("hero")

				arg_686_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_686_1.callingController_:SetSelectedState("normal")

				arg_686_1.keyicon_.color = Color.New(1, 1, 1)
				arg_686_1.icon_.color = Color.New(1, 1, 1)

				local var_689_1 = arg_686_1:FormatText(arg_686_1:GetWordFromCfg(102604168).content)

				arg_686_1.text_.text = var_689_1

				LuaForUtil.ClearLinePrefixSymbol(arg_686_1.text_)

				local var_689_3 = 5 <= 0 and var_689_0 or var_689_0 * (utf8.len(var_689_1) / 5)

				if (5 <= 0 and var_689_0 or var_689_0 * (utf8.len(var_689_1) / 5)) > 0 and var_689_0 < var_689_3 then
					arg_686_1.talkMaxDuration = var_689_3

					if var_689_3 + 0 > arg_686_1.duration_ then
						arg_686_1.duration_ = var_689_3 + 0
					end
				end

				arg_686_1.text_.text = var_689_1
				arg_686_1.typewritter.percent = 0

				arg_686_1.typewritter:SetDirty()
				arg_686_1:ShowNextGo(false)
				arg_686_1:RecordContent(arg_686_1.text_.text)
			end

			local var_689_4 = math.max(var_689_0, arg_686_1.talkMaxDuration)

			if 0 <= arg_686_1.time_ and arg_686_1.time_ < 0 + var_689_4 then
				arg_686_1.typewritter.percent = (arg_686_1.time_ - 0) / var_689_4

				arg_686_1.typewritter:SetDirty()
			end

			if arg_686_1.time_ >= 0 + var_689_4 and arg_686_1.time_ < 0 + var_689_4 + arg_689_0 then
				arg_686_1.typewritter.percent = 1

				arg_686_1.typewritter:SetDirty()
				arg_686_1:ShowNextGo(true)
			end
		end

		arg_686_1.nodeConfigList_ = {}

		arg_686_1:InitPlayNodeList()
	end,
	Play102604169 = function(arg_690_0, arg_690_1)
		arg_690_1.time_ = 0
		arg_690_1.frameCnt_ = 0
		arg_690_1.state_ = "playing"
		arg_690_1.curTalkId_ = 102604169
		arg_690_1.duration_ = 5

		SetActive(arg_690_1.tipsGo_, false)

		function arg_690_1.onSingleLineFinish_()
			arg_690_1.onSingleLineUpdate_ = nil
			arg_690_1.onSingleLineFinish_ = nil
			arg_690_1.state_ = "waiting"
		end

		function arg_690_1.playNext_(arg_692_0)
			if arg_692_0 == 1 then
				arg_690_0:Play102604170(arg_690_1)
			end
		end

		function arg_690_1.onSingleLineUpdate_(arg_693_0)
			local var_693_0 = 0.45

			if 0 < arg_690_1.time_ and arg_690_1.time_ <= 0 + arg_693_0 then
				arg_690_1.talkMaxDuration = 0
				arg_690_1.dialogCg_.alpha = 1

				arg_690_1.dialog_:SetActive(true)
				SetActive(arg_690_1.leftNameGo_, false)

				arg_690_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_690_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_690_1:RecordName(arg_690_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_690_1.iconTrs_.gameObject, false)
				arg_690_1.callingController_:SetSelectedState("normal")

				local var_693_1 = arg_690_1:FormatText(arg_690_1:GetWordFromCfg(102604169).content)

				arg_690_1.text_.text = var_693_1

				LuaForUtil.ClearLinePrefixSymbol(arg_690_1.text_)

				local var_693_3 = 18 <= 0 and var_693_0 or var_693_0 * (utf8.len(var_693_1) / 18)

				if (18 <= 0 and var_693_0 or var_693_0 * (utf8.len(var_693_1) / 18)) > 0 and var_693_0 < var_693_3 then
					arg_690_1.talkMaxDuration = var_693_3

					if var_693_3 + 0 > arg_690_1.duration_ then
						arg_690_1.duration_ = var_693_3 + 0
					end
				end

				arg_690_1.text_.text = var_693_1
				arg_690_1.typewritter.percent = 0

				arg_690_1.typewritter:SetDirty()
				arg_690_1:ShowNextGo(false)
				arg_690_1:RecordContent(arg_690_1.text_.text)
			end

			local var_693_4 = math.max(var_693_0, arg_690_1.talkMaxDuration)

			if 0 <= arg_690_1.time_ and arg_690_1.time_ < 0 + var_693_4 then
				arg_690_1.typewritter.percent = (arg_690_1.time_ - 0) / var_693_4

				arg_690_1.typewritter:SetDirty()
			end

			if arg_690_1.time_ >= 0 + var_693_4 and arg_690_1.time_ < 0 + var_693_4 + arg_693_0 then
				arg_690_1.typewritter.percent = 1

				arg_690_1.typewritter:SetDirty()
				arg_690_1:ShowNextGo(true)
			end
		end

		arg_690_1.nodeConfigList_ = {}

		arg_690_1:InitPlayNodeList()
	end,
	Play102604170 = function(arg_694_0, arg_694_1)
		arg_694_1.time_ = 0
		arg_694_1.frameCnt_ = 0
		arg_694_1.state_ = "playing"
		arg_694_1.curTalkId_ = 102604170
		arg_694_1.duration_ = 12.47

		local var_694_0 = {
			ja = 12.466,
			ko = 7.233,
			zh = 7.266,
			en = 8.166
		}
		local var_694_1 = manager.audio:GetLocalizationFlag()

		if var_694_0[var_694_1] ~= nil then
			arg_694_1.duration_ = var_694_0[var_694_1]
		end

		SetActive(arg_694_1.tipsGo_, false)

		function arg_694_1.onSingleLineFinish_()
			arg_694_1.onSingleLineUpdate_ = nil
			arg_694_1.onSingleLineFinish_ = nil
			arg_694_1.state_ = "waiting"
		end

		function arg_694_1.playNext_(arg_696_0)
			if arg_696_0 == 1 then
				arg_694_0:Play102604171(arg_694_1)
			end
		end

		function arg_694_1.onSingleLineUpdate_(arg_697_0)
			if 0 < arg_694_1.time_ and arg_694_1.time_ <= 0 + arg_697_0 then
				arg_694_1.var_.moveOldPos1026ui_story = arg_694_1.actors_["1026ui_story"].transform.localPosition
			end

			local var_697_0 = 0.001

			if 0 <= arg_694_1.time_ and arg_694_1.time_ < 0 + var_697_0 then
				arg_694_1.actors_["1026ui_story"].transform.localPosition = Vector3.Lerp(arg_694_1.var_.moveOldPos1026ui_story, Vector3.New(0, -1.05, -6.2), (arg_694_1.time_ - 0) / var_697_0)
				arg_694_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_694_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_694_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_694_1.actors_["1026ui_story"].transform.position).z)
				arg_694_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_694_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_694_1.actors_["1026ui_story"].transform.localEulerAngles = arg_694_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			if arg_694_1.time_ >= 0 + var_697_0 and arg_694_1.time_ < 0 + var_697_0 + arg_697_0 then
				arg_694_1.actors_["1026ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.2)
				arg_694_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_694_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_694_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_694_1.actors_["1026ui_story"].transform.position).z)
				arg_694_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_694_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_694_1.actors_["1026ui_story"].transform.localEulerAngles = arg_694_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			local var_697_1 = arg_694_1.actors_["1026ui_story"]

			if 0 < arg_694_1.time_ and arg_694_1.time_ <= 0 + arg_697_0 and not isNil(var_697_1) and arg_694_1.var_.characterEffect1026ui_story == nil then
				arg_694_1.var_.characterEffect1026ui_story = var_697_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_697_2 = 0.2

			if 0 <= arg_694_1.time_ and arg_694_1.time_ < 0 + var_697_2 and not isNil(var_697_1) then
				if arg_694_1.var_.characterEffect1026ui_story and not isNil(var_697_1) then
					arg_694_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_694_1.time_ >= 0 + var_697_2 and arg_694_1.time_ < 0 + var_697_2 + arg_697_0 and not isNil(var_697_1) and arg_694_1.var_.characterEffect1026ui_story then
				arg_694_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			if 0 < arg_694_1.time_ and arg_694_1.time_ <= 0 + arg_697_0 then
				arg_694_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			if 0 < arg_694_1.time_ and arg_694_1.time_ <= 0 + arg_697_0 then
				arg_694_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action1_1")
			end

			local var_697_4 = 0
			local var_697_5 = 0.925

			if 0 < arg_694_1.time_ and arg_694_1.time_ <= var_697_4 + arg_697_0 then
				arg_694_1.talkMaxDuration = 0
				arg_694_1.dialogCg_.alpha = 1

				arg_694_1.dialog_:SetActive(true)
				SetActive(arg_694_1.leftNameGo_, true)

				arg_694_1.leftNameTxt_.text = arg_694_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_694_1.leftNameTxt_.transform)

				arg_694_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_694_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_694_1:RecordName(arg_694_1.leftNameTxt_.text)
				SetActive(arg_694_1.iconTrs_.gameObject, false)
				arg_694_1.callingController_:SetSelectedState("normal")

				local var_697_6 = arg_694_1:GetWordFromCfg(102604170)
				local var_697_7 = arg_694_1:FormatText(var_697_6.content)

				arg_694_1.text_.text = var_697_7

				LuaForUtil.ClearLinePrefixSymbol(arg_694_1.text_)

				local var_697_9 = 37 <= 0 and var_697_5 or var_697_5 * (utf8.len(var_697_7) / 37)

				if (37 <= 0 and var_697_5 or var_697_5 * (utf8.len(var_697_7) / 37)) > 0 and var_697_5 < var_697_9 then
					arg_694_1.talkMaxDuration = var_697_9

					if var_697_9 + var_697_4 > arg_694_1.duration_ then
						arg_694_1.duration_ = var_697_9 + var_697_4
					end
				end

				arg_694_1.text_.text = var_697_7
				arg_694_1.typewritter.percent = 0

				arg_694_1.typewritter:SetDirty()
				arg_694_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604170", "story_v_side_old_102604.awb") ~= 0 then
					local var_697_10 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604170", "story_v_side_old_102604.awb") / 1000

					if var_697_10 + var_697_4 > arg_694_1.duration_ then
						arg_694_1.duration_ = var_697_10 + var_697_4
					end

					if var_697_6.prefab_name ~= "" and arg_694_1.actors_[var_697_6.prefab_name] ~= nil then
						local var_697_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_694_1.actors_[var_697_6.prefab_name].transform, "story_v_side_old_102604", "102604170", "story_v_side_old_102604.awb")

						arg_694_1:RecordAudio("102604170", var_697_11)
						arg_694_1:RecordAudio("102604170", var_697_11)
					else
						arg_694_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604170", "story_v_side_old_102604.awb")
					end

					arg_694_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604170", "story_v_side_old_102604.awb")
				end

				arg_694_1:RecordContent(arg_694_1.text_.text)
			end

			local var_697_12 = math.max(var_697_5, arg_694_1.talkMaxDuration)

			if var_697_4 <= arg_694_1.time_ and arg_694_1.time_ < var_697_4 + var_697_12 then
				arg_694_1.typewritter.percent = (arg_694_1.time_ - var_697_4) / var_697_12

				arg_694_1.typewritter:SetDirty()
			end

			if arg_694_1.time_ >= var_697_4 + var_697_12 and arg_694_1.time_ < var_697_4 + var_697_12 + arg_697_0 then
				arg_694_1.typewritter.percent = 1

				arg_694_1.typewritter:SetDirty()
				arg_694_1:ShowNextGo(true)
			end
		end

		arg_694_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_694_1:InitPlayNodeList()
	end,
	Play102604171 = function(arg_698_0, arg_698_1)
		arg_698_1.time_ = 0
		arg_698_1.frameCnt_ = 0
		arg_698_1.state_ = "playing"
		arg_698_1.curTalkId_ = 102604171
		arg_698_1.duration_ = 5

		SetActive(arg_698_1.tipsGo_, false)

		function arg_698_1.onSingleLineFinish_()
			arg_698_1.onSingleLineUpdate_ = nil
			arg_698_1.onSingleLineFinish_ = nil
			arg_698_1.state_ = "waiting"
		end

		function arg_698_1.playNext_(arg_700_0)
			if arg_700_0 == 1 then
				arg_698_0:Play102604172(arg_698_1)
			end
		end

		function arg_698_1.onSingleLineUpdate_(arg_701_0)
			if 0 < arg_698_1.time_ and arg_698_1.time_ <= 0 + arg_701_0 then
				arg_698_1.var_.moveOldPos1026ui_story = arg_698_1.actors_["1026ui_story"].transform.localPosition
			end

			local var_701_0 = 0.001

			if 0 <= arg_698_1.time_ and arg_698_1.time_ < 0 + var_701_0 then
				arg_698_1.actors_["1026ui_story"].transform.localPosition = Vector3.Lerp(arg_698_1.var_.moveOldPos1026ui_story, Vector3.New(0, 100, 0), (arg_698_1.time_ - 0) / var_701_0)
				arg_698_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_698_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_698_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_698_1.actors_["1026ui_story"].transform.position).z)
				arg_698_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_698_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_698_1.actors_["1026ui_story"].transform.localEulerAngles = arg_698_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			if arg_698_1.time_ >= 0 + var_701_0 and arg_698_1.time_ < 0 + var_701_0 + arg_701_0 then
				arg_698_1.actors_["1026ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_698_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_698_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_698_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_698_1.actors_["1026ui_story"].transform.position).z)
				arg_698_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_698_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_698_1.actors_["1026ui_story"].transform.localEulerAngles = arg_698_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			local var_701_1 = 0
			local var_701_2 = 0.45

			if 0 < arg_698_1.time_ and arg_698_1.time_ <= var_701_1 + arg_701_0 then
				arg_698_1.talkMaxDuration = 0
				arg_698_1.dialogCg_.alpha = 1

				arg_698_1.dialog_:SetActive(true)
				SetActive(arg_698_1.leftNameGo_, false)

				arg_698_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_698_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_698_1:RecordName(arg_698_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_698_1.iconTrs_.gameObject, false)
				arg_698_1.callingController_:SetSelectedState("normal")

				local var_701_3 = arg_698_1:FormatText(arg_698_1:GetWordFromCfg(102604171).content)

				arg_698_1.text_.text = var_701_3

				LuaForUtil.ClearLinePrefixSymbol(arg_698_1.text_)

				local var_701_5 = 18 <= 0 and var_701_2 or var_701_2 * (utf8.len(var_701_3) / 18)

				if (18 <= 0 and var_701_2 or var_701_2 * (utf8.len(var_701_3) / 18)) > 0 and var_701_2 < var_701_5 then
					arg_698_1.talkMaxDuration = var_701_5

					if var_701_5 + var_701_1 > arg_698_1.duration_ then
						arg_698_1.duration_ = var_701_5 + var_701_1
					end
				end

				arg_698_1.text_.text = var_701_3
				arg_698_1.typewritter.percent = 0

				arg_698_1.typewritter:SetDirty()
				arg_698_1:ShowNextGo(false)
				arg_698_1:RecordContent(arg_698_1.text_.text)
			end

			local var_701_6 = math.max(var_701_2, arg_698_1.talkMaxDuration)

			if var_701_1 <= arg_698_1.time_ and arg_698_1.time_ < var_701_1 + var_701_6 then
				arg_698_1.typewritter.percent = (arg_698_1.time_ - var_701_1) / var_701_6

				arg_698_1.typewritter:SetDirty()
			end

			if arg_698_1.time_ >= var_701_1 + var_701_6 and arg_698_1.time_ < var_701_1 + var_701_6 + arg_701_0 then
				arg_698_1.typewritter.percent = 1

				arg_698_1.typewritter:SetDirty()
				arg_698_1:ShowNextGo(true)
			end
		end

		arg_698_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_698_1:InitPlayNodeList()
	end,
	Play102604172 = function(arg_702_0, arg_702_1)
		arg_702_1.time_ = 0
		arg_702_1.frameCnt_ = 0
		arg_702_1.state_ = "playing"
		arg_702_1.curTalkId_ = 102604172
		arg_702_1.duration_ = 5

		SetActive(arg_702_1.tipsGo_, false)

		function arg_702_1.onSingleLineFinish_()
			arg_702_1.onSingleLineUpdate_ = nil
			arg_702_1.onSingleLineFinish_ = nil
			arg_702_1.state_ = "waiting"
		end

		function arg_702_1.playNext_(arg_704_0)
			if arg_704_0 == 1 then
				arg_702_0:Play102604173(arg_702_1)
			end
		end

		function arg_702_1.onSingleLineUpdate_(arg_705_0)
			local var_705_0 = 0.55

			if 0 < arg_702_1.time_ and arg_702_1.time_ <= 0 + arg_705_0 then
				arg_702_1.talkMaxDuration = 0
				arg_702_1.dialogCg_.alpha = 1

				arg_702_1.dialog_:SetActive(true)
				SetActive(arg_702_1.leftNameGo_, true)

				arg_702_1.leftNameTxt_.text = arg_702_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_702_1.leftNameTxt_.transform)

				arg_702_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_702_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_702_1:RecordName(arg_702_1.leftNameTxt_.text)
				SetActive(arg_702_1.iconTrs_.gameObject, true)
				arg_702_1.iconController_:SetSelectedState("hero")

				arg_702_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_702_1.callingController_:SetSelectedState("normal")

				arg_702_1.keyicon_.color = Color.New(1, 1, 1)
				arg_702_1.icon_.color = Color.New(1, 1, 1)

				local var_705_1 = arg_702_1:FormatText(arg_702_1:GetWordFromCfg(102604172).content)

				arg_702_1.text_.text = var_705_1

				LuaForUtil.ClearLinePrefixSymbol(arg_702_1.text_)

				local var_705_3 = 22 <= 0 and var_705_0 or var_705_0 * (utf8.len(var_705_1) / 22)

				if (22 <= 0 and var_705_0 or var_705_0 * (utf8.len(var_705_1) / 22)) > 0 and var_705_0 < var_705_3 then
					arg_702_1.talkMaxDuration = var_705_3

					if var_705_3 + 0 > arg_702_1.duration_ then
						arg_702_1.duration_ = var_705_3 + 0
					end
				end

				arg_702_1.text_.text = var_705_1
				arg_702_1.typewritter.percent = 0

				arg_702_1.typewritter:SetDirty()
				arg_702_1:ShowNextGo(false)
				arg_702_1:RecordContent(arg_702_1.text_.text)
			end

			local var_705_4 = math.max(var_705_0, arg_702_1.talkMaxDuration)

			if 0 <= arg_702_1.time_ and arg_702_1.time_ < 0 + var_705_4 then
				arg_702_1.typewritter.percent = (arg_702_1.time_ - 0) / var_705_4

				arg_702_1.typewritter:SetDirty()
			end

			if arg_702_1.time_ >= 0 + var_705_4 and arg_702_1.time_ < 0 + var_705_4 + arg_705_0 then
				arg_702_1.typewritter.percent = 1

				arg_702_1.typewritter:SetDirty()
				arg_702_1:ShowNextGo(true)
			end
		end

		arg_702_1.nodeConfigList_ = {}

		arg_702_1:InitPlayNodeList()
	end,
	Play102604173 = function(arg_706_0, arg_706_1)
		arg_706_1.time_ = 0
		arg_706_1.frameCnt_ = 0
		arg_706_1.state_ = "playing"
		arg_706_1.curTalkId_ = 102604173
		arg_706_1.duration_ = 8.27

		local var_706_0 = {
			ja = 8.266,
			ko = 3.233,
			zh = 2.8,
			en = 2.2
		}
		local var_706_1 = manager.audio:GetLocalizationFlag()

		if var_706_0[var_706_1] ~= nil then
			arg_706_1.duration_ = var_706_0[var_706_1]
		end

		SetActive(arg_706_1.tipsGo_, false)

		function arg_706_1.onSingleLineFinish_()
			arg_706_1.onSingleLineUpdate_ = nil
			arg_706_1.onSingleLineFinish_ = nil
			arg_706_1.state_ = "waiting"
		end

		function arg_706_1.playNext_(arg_708_0)
			if arg_708_0 == 1 then
				arg_706_0:Play102604174(arg_706_1)
			end
		end

		function arg_706_1.onSingleLineUpdate_(arg_709_0)
			if 0 < arg_706_1.time_ and arg_706_1.time_ <= 0 + arg_709_0 then
				arg_706_1.var_.moveOldPos1026ui_story = arg_706_1.actors_["1026ui_story"].transform.localPosition
			end

			local var_709_0 = 0.001

			if 0 <= arg_706_1.time_ and arg_706_1.time_ < 0 + var_709_0 then
				arg_706_1.actors_["1026ui_story"].transform.localPosition = Vector3.Lerp(arg_706_1.var_.moveOldPos1026ui_story, Vector3.New(0, -1.05, -6.2), (arg_706_1.time_ - 0) / var_709_0)
				arg_706_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_706_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_706_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_706_1.actors_["1026ui_story"].transform.position).z)
				arg_706_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_706_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_706_1.actors_["1026ui_story"].transform.localEulerAngles = arg_706_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			if arg_706_1.time_ >= 0 + var_709_0 and arg_706_1.time_ < 0 + var_709_0 + arg_709_0 then
				arg_706_1.actors_["1026ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.2)
				arg_706_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_706_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_706_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_706_1.actors_["1026ui_story"].transform.position).z)
				arg_706_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_706_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_706_1.actors_["1026ui_story"].transform.localEulerAngles = arg_706_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			local var_709_1 = arg_706_1.actors_["1026ui_story"]

			if 0 < arg_706_1.time_ and arg_706_1.time_ <= 0 + arg_709_0 and not isNil(var_709_1) and arg_706_1.var_.characterEffect1026ui_story == nil then
				arg_706_1.var_.characterEffect1026ui_story = var_709_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_709_2 = 0.2

			if 0 <= arg_706_1.time_ and arg_706_1.time_ < 0 + var_709_2 and not isNil(var_709_1) then
				if arg_706_1.var_.characterEffect1026ui_story and not isNil(var_709_1) then
					arg_706_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_706_1.time_ >= 0 + var_709_2 and arg_706_1.time_ < 0 + var_709_2 + arg_709_0 and not isNil(var_709_1) and arg_706_1.var_.characterEffect1026ui_story then
				arg_706_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			if 0 < arg_706_1.time_ and arg_706_1.time_ <= 0 + arg_709_0 then
				arg_706_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			if 0 < arg_706_1.time_ and arg_706_1.time_ <= 0 + arg_709_0 then
				arg_706_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action7_1")
			end

			local var_709_4 = 0
			local var_709_5 = 0.375

			if 0 < arg_706_1.time_ and arg_706_1.time_ <= var_709_4 + arg_709_0 then
				arg_706_1.talkMaxDuration = 0
				arg_706_1.dialogCg_.alpha = 1

				arg_706_1.dialog_:SetActive(true)
				SetActive(arg_706_1.leftNameGo_, true)

				arg_706_1.leftNameTxt_.text = arg_706_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_706_1.leftNameTxt_.transform)

				arg_706_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_706_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_706_1:RecordName(arg_706_1.leftNameTxt_.text)
				SetActive(arg_706_1.iconTrs_.gameObject, false)
				arg_706_1.callingController_:SetSelectedState("normal")

				local var_709_6 = arg_706_1:GetWordFromCfg(102604173)
				local var_709_7 = arg_706_1:FormatText(var_709_6.content)

				arg_706_1.text_.text = var_709_7

				LuaForUtil.ClearLinePrefixSymbol(arg_706_1.text_)

				local var_709_9 = 15 <= 0 and var_709_5 or var_709_5 * (utf8.len(var_709_7) / 15)

				if (15 <= 0 and var_709_5 or var_709_5 * (utf8.len(var_709_7) / 15)) > 0 and var_709_5 < var_709_9 then
					arg_706_1.talkMaxDuration = var_709_9

					if var_709_9 + var_709_4 > arg_706_1.duration_ then
						arg_706_1.duration_ = var_709_9 + var_709_4
					end
				end

				arg_706_1.text_.text = var_709_7
				arg_706_1.typewritter.percent = 0

				arg_706_1.typewritter:SetDirty()
				arg_706_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604173", "story_v_side_old_102604.awb") ~= 0 then
					local var_709_10 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604173", "story_v_side_old_102604.awb") / 1000

					if var_709_10 + var_709_4 > arg_706_1.duration_ then
						arg_706_1.duration_ = var_709_10 + var_709_4
					end

					if var_709_6.prefab_name ~= "" and arg_706_1.actors_[var_709_6.prefab_name] ~= nil then
						local var_709_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_706_1.actors_[var_709_6.prefab_name].transform, "story_v_side_old_102604", "102604173", "story_v_side_old_102604.awb")

						arg_706_1:RecordAudio("102604173", var_709_11)
						arg_706_1:RecordAudio("102604173", var_709_11)
					else
						arg_706_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604173", "story_v_side_old_102604.awb")
					end

					arg_706_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604173", "story_v_side_old_102604.awb")
				end

				arg_706_1:RecordContent(arg_706_1.text_.text)
			end

			local var_709_12 = math.max(var_709_5, arg_706_1.talkMaxDuration)

			if var_709_4 <= arg_706_1.time_ and arg_706_1.time_ < var_709_4 + var_709_12 then
				arg_706_1.typewritter.percent = (arg_706_1.time_ - var_709_4) / var_709_12

				arg_706_1.typewritter:SetDirty()
			end

			if arg_706_1.time_ >= var_709_4 + var_709_12 and arg_706_1.time_ < var_709_4 + var_709_12 + arg_709_0 then
				arg_706_1.typewritter.percent = 1

				arg_706_1.typewritter:SetDirty()
				arg_706_1:ShowNextGo(true)
			end
		end

		arg_706_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_706_1:InitPlayNodeList()
	end,
	Play102604174 = function(arg_710_0, arg_710_1)
		arg_710_1.time_ = 0
		arg_710_1.frameCnt_ = 0
		arg_710_1.state_ = "playing"
		arg_710_1.curTalkId_ = 102604174
		arg_710_1.duration_ = 7.2

		SetActive(arg_710_1.tipsGo_, false)

		function arg_710_1.onSingleLineFinish_()
			arg_710_1.onSingleLineUpdate_ = nil
			arg_710_1.onSingleLineFinish_ = nil
			arg_710_1.state_ = "waiting"
		end

		function arg_710_1.playNext_(arg_712_0)
			if arg_712_0 == 1 then
				arg_710_0:Play102604175(arg_710_1)
			end
		end

		function arg_710_1.onSingleLineUpdate_(arg_713_0)
			if 0 < arg_710_1.time_ and arg_710_1.time_ <= 0 + arg_713_0 then
				arg_710_1.var_.moveOldPos1026ui_story = arg_710_1.actors_["1026ui_story"].transform.localPosition
			end

			local var_713_0 = 0.001

			if 0 <= arg_710_1.time_ and arg_710_1.time_ < 0 + var_713_0 then
				arg_710_1.actors_["1026ui_story"].transform.localPosition = Vector3.Lerp(arg_710_1.var_.moveOldPos1026ui_story, Vector3.New(0, 100, 0), (arg_710_1.time_ - 0) / var_713_0)
				arg_710_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_710_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_710_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_710_1.actors_["1026ui_story"].transform.position).z)
				arg_710_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_710_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_710_1.actors_["1026ui_story"].transform.localEulerAngles = arg_710_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			if arg_710_1.time_ >= 0 + var_713_0 and arg_710_1.time_ < 0 + var_713_0 + arg_713_0 then
				arg_710_1.actors_["1026ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_710_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_710_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_710_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_710_1.actors_["1026ui_story"].transform.position).z)
				arg_710_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_710_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_710_1.actors_["1026ui_story"].transform.localEulerAngles = arg_710_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			local var_713_1 = "R2601"

			if arg_710_1.bgs_.R2601 == nil then
				local var_713_2 = Object.Instantiate(arg_710_1.paintGo_)

				var_713_2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_713_1)
				var_713_2.name = var_713_1
				var_713_2.transform.parent = arg_710_1.stage_.transform
				var_713_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_710_1.bgs_[var_713_1] = var_713_2
			end

			if 1.5 < arg_710_1.time_ and arg_710_1.time_ <= 1.5 + arg_713_0 then
				local var_713_3 = arg_710_1.bgs_.R2601

				arg_710_1.bgs_.R2601.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_713_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_713_4 = var_713_3:GetComponent("SpriteRenderer")

				if var_713_4 and var_713_4.sprite then
					local var_713_5 = 2 * (var_713_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_713_3.transform.localScale = Vector3.New(var_713_5 / var_713_4.sprite.bounds.size.y < var_713_5 * manager.ui.mainCameraCom_.aspect / var_713_4.sprite.bounds.size.x and var_713_5 * manager.ui.mainCameraCom_.aspect / var_713_4.sprite.bounds.size.x or var_713_5 / var_713_4.sprite.bounds.size.y, var_713_5 / var_713_4.sprite.bounds.size.y < var_713_5 * manager.ui.mainCameraCom_.aspect / var_713_4.sprite.bounds.size.x and var_713_5 * manager.ui.mainCameraCom_.aspect / var_713_4.sprite.bounds.size.x or var_713_5 / var_713_4.sprite.bounds.size.y, 0)
				end

				for iter_713_0, iter_713_1 in pairs(arg_710_1.bgs_) do
					if iter_713_0 ~= "R2601" then
						iter_713_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_710_1.time_ and arg_710_1.time_ <= 0 + arg_713_0 then
				local var_713_6 = arg_710_1.bgs_.B01c:GetComponent("SpriteRenderer")

				if var_713_6 then
					arg_710_1.var_.alphaOldValueB01c = var_713_6.color.a
					arg_710_1.var_.alphaMatValueB01c = var_713_6
				end

				arg_710_1.var_.alphaOldValueB01c = 1
			end

			local var_713_7 = 1.5

			if 0 <= arg_710_1.time_ and arg_710_1.time_ < 0 + var_713_7 then
				if arg_710_1.var_.alphaMatValueB01c then
					arg_710_1.var_.alphaMatValueB01c.color.a = Mathf.Lerp(arg_710_1.var_.alphaOldValueB01c, 0, (arg_710_1.time_ - 0) / var_713_7)
					arg_710_1.var_.alphaMatValueB01c.color = arg_710_1.var_.alphaMatValueB01c.color
				end
			end

			if arg_710_1.time_ >= 0 + var_713_7 and arg_710_1.time_ < 0 + var_713_7 + arg_713_0 and arg_710_1.var_.alphaMatValueB01c then
				arg_710_1.var_.alphaMatValueB01c.color.a = 0
				arg_710_1.var_.alphaMatValueB01c.color = arg_710_1.var_.alphaMatValueB01c.color
			end

			if 1.5 < arg_710_1.time_ and arg_710_1.time_ <= 1.5 + arg_713_0 then
				local var_713_8 = arg_710_1.bgs_.R2601:GetComponent("SpriteRenderer")

				if var_713_8 then
					arg_710_1.var_.alphaOldValueR2601 = var_713_8.color.a
					arg_710_1.var_.alphaMatValueR2601 = var_713_8
				end

				arg_710_1.var_.alphaOldValueR2601 = 0
			end

			local var_713_9 = 1.5

			if 1.5 <= arg_710_1.time_ and arg_710_1.time_ < 1.5 + var_713_9 then
				if arg_710_1.var_.alphaMatValueR2601 then
					arg_710_1.var_.alphaMatValueR2601.color.a = Mathf.Lerp(arg_710_1.var_.alphaOldValueR2601, 1, (arg_710_1.time_ - 1.5) / var_713_9)
					arg_710_1.var_.alphaMatValueR2601.color = arg_710_1.var_.alphaMatValueR2601.color
				end
			end

			if arg_710_1.time_ >= 1.5 + var_713_9 and arg_710_1.time_ < 1.5 + var_713_9 + arg_713_0 and arg_710_1.var_.alphaMatValueR2601 then
				arg_710_1.var_.alphaMatValueR2601.color.a = 1
				arg_710_1.var_.alphaMatValueR2601.color = arg_710_1.var_.alphaMatValueR2601.color
			end

			local var_713_10 = 0

			if 0 < arg_710_1.time_ and arg_710_1.time_ <= var_713_10 + arg_713_0 then
				arg_710_1.allBtn_.enabled = false
			end

			if arg_710_1.time_ >= var_713_10 + 2.2 and arg_710_1.time_ < var_713_10 + 2.2 + arg_713_0 then
				arg_710_1.allBtn_.enabled = true
			end

			if 2.2 < arg_710_1.time_ and arg_710_1.time_ <= 2.2 + arg_713_0 then
				arg_710_1:AudioAction("play", "music", "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_713_13 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if "" ~= "" then
					if arg_710_1.bgmTxt_.text ~= var_713_13 and arg_710_1.bgmTxt_.text ~= "" then
						if arg_710_1.bgmTxt2_.text ~= "" then
							arg_710_1.bgmTxt_.text = arg_710_1.bgmTxt2_.text
						end

						arg_710_1.bgmTxt2_.text = var_713_13

						arg_710_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_710_1.bgmTxt_.text = var_713_13
						arg_710_1.bgmTxt2_.text = var_713_13
					end

					if arg_710_1.bgmTimer then
						arg_710_1.bgmTimer:Stop()

						arg_710_1.bgmTimer = nil
					end

					if arg_710_1.settingData.show_music_name == 1 then
						arg_710_1.musicController:SetSelectedState("show")
						arg_710_1.musicAnimator_:Play("open", 0, 0)

						if arg_710_1.settingData.music_time ~= 0 then
							arg_710_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_710_1.settingData.music_time), function()
								if arg_710_1 == nil or isNil(arg_710_1.bgmTxt_) then
									return
								end

								arg_710_1.musicController:SetSelectedState("hide")
								arg_710_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_710_1.frameCnt_ <= 1 then
				arg_710_1.dialog_:SetActive(false)
			end

			local var_713_14 = 2.2
			local var_713_15 = 1.3

			if 2.2 < arg_710_1.time_ and arg_710_1.time_ <= var_713_14 + arg_713_0 then
				arg_710_1.talkMaxDuration = 0

				arg_710_1.dialog_:SetActive(true)

				arg_710_1.dialogCg_.alpha = 0

				local var_713_16 = LeanTween.value(arg_710_1.dialog_, 0, 1, 0.3)

				var_713_16:setOnUpdate(LuaHelper.FloatAction(function(arg_715_0)
					arg_710_1.dialogCg_.alpha = arg_715_0
				end))
				var_713_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_710_1.dialog_)
					var_713_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_710_1.duration_ = arg_710_1.duration_ + 0.3

				SetActive(arg_710_1.leftNameGo_, false)

				arg_710_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_710_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_710_1:RecordName(arg_710_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_710_1.iconTrs_.gameObject, false)
				arg_710_1.callingController_:SetSelectedState("normal")

				local var_713_17 = arg_710_1:FormatText(arg_710_1:GetWordFromCfg(102604174).content)

				arg_710_1.text_.text = var_713_17

				LuaForUtil.ClearLinePrefixSymbol(arg_710_1.text_)

				local var_713_19 = 52 <= 0 and var_713_15 or var_713_15 * (utf8.len(var_713_17) / 52)

				if (52 <= 0 and var_713_15 or var_713_15 * (utf8.len(var_713_17) / 52)) > 0 and var_713_15 < var_713_19 then
					arg_710_1.talkMaxDuration = var_713_19
					var_713_14 = var_713_14 + 0.3

					if var_713_19 + var_713_14 > arg_710_1.duration_ then
						arg_710_1.duration_ = var_713_19 + var_713_14
					end
				end

				arg_710_1.text_.text = var_713_17
				arg_710_1.typewritter.percent = 0

				arg_710_1.typewritter:SetDirty()
				arg_710_1:ShowNextGo(false)
				arg_710_1:RecordContent(arg_710_1.text_.text)
			end

			local var_713_20 = var_713_14 + 0.3
			local var_713_21 = math.max(var_713_15, arg_710_1.talkMaxDuration)

			if var_713_14 + 0.3 <= arg_710_1.time_ and arg_710_1.time_ < var_713_20 + var_713_21 then
				arg_710_1.typewritter.percent = (arg_710_1.time_ - var_713_20) / var_713_21

				arg_710_1.typewritter:SetDirty()
			end

			if arg_710_1.time_ >= var_713_20 + var_713_21 and arg_710_1.time_ < var_713_20 + var_713_21 + arg_713_0 then
				arg_710_1.typewritter.percent = 1

				arg_710_1.typewritter:SetDirty()
				arg_710_1:ShowNextGo(true)
			end
		end

		arg_710_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_710_1:InitPlayNodeList()
	end,
	Play102604175 = function(arg_717_0, arg_717_1)
		arg_717_1.time_ = 0
		arg_717_1.frameCnt_ = 0
		arg_717_1.state_ = "playing"
		arg_717_1.curTalkId_ = 102604175
		arg_717_1.duration_ = 12.8

		local var_717_0 = {
			ja = 12.8,
			ko = 9.733,
			zh = 10.8,
			en = 7.333
		}
		local var_717_1 = manager.audio:GetLocalizationFlag()

		if var_717_0[var_717_1] ~= nil then
			arg_717_1.duration_ = var_717_0[var_717_1]
		end

		SetActive(arg_717_1.tipsGo_, false)

		function arg_717_1.onSingleLineFinish_()
			arg_717_1.onSingleLineUpdate_ = nil
			arg_717_1.onSingleLineFinish_ = nil
			arg_717_1.state_ = "waiting"
		end

		function arg_717_1.playNext_(arg_719_0)
			if arg_719_0 == 1 then
				arg_717_0:Play102604176(arg_717_1)
			end
		end

		function arg_717_1.onSingleLineUpdate_(arg_720_0)
			local var_720_0 = 1.175

			if 0 < arg_717_1.time_ and arg_717_1.time_ <= 0 + arg_720_0 then
				arg_717_1.talkMaxDuration = 0
				arg_717_1.dialogCg_.alpha = 1

				arg_717_1.dialog_:SetActive(true)
				SetActive(arg_717_1.leftNameGo_, true)

				arg_717_1.leftNameTxt_.text = arg_717_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_717_1.leftNameTxt_.transform)

				arg_717_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_717_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_717_1:RecordName(arg_717_1.leftNameTxt_.text)
				SetActive(arg_717_1.iconTrs_.gameObject, false)
				arg_717_1.callingController_:SetSelectedState("normal")

				local var_720_1 = arg_717_1:GetWordFromCfg(102604175)
				local var_720_2 = arg_717_1:FormatText(var_720_1.content)

				arg_717_1.text_.text = var_720_2

				LuaForUtil.ClearLinePrefixSymbol(arg_717_1.text_)

				local var_720_4 = 47 <= 0 and var_720_0 or var_720_0 * (utf8.len(var_720_2) / 47)

				if (47 <= 0 and var_720_0 or var_720_0 * (utf8.len(var_720_2) / 47)) > 0 and var_720_0 < var_720_4 then
					arg_717_1.talkMaxDuration = var_720_4

					if var_720_4 + 0 > arg_717_1.duration_ then
						arg_717_1.duration_ = var_720_4 + 0
					end
				end

				arg_717_1.text_.text = var_720_2
				arg_717_1.typewritter.percent = 0

				arg_717_1.typewritter:SetDirty()
				arg_717_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604175", "story_v_side_old_102604.awb") ~= 0 then
					local var_720_5 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604175", "story_v_side_old_102604.awb") / 1000

					if var_720_5 + 0 > arg_717_1.duration_ then
						arg_717_1.duration_ = var_720_5 + 0
					end

					if var_720_1.prefab_name ~= "" and arg_717_1.actors_[var_720_1.prefab_name] ~= nil then
						local var_720_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_717_1.actors_[var_720_1.prefab_name].transform, "story_v_side_old_102604", "102604175", "story_v_side_old_102604.awb")

						arg_717_1:RecordAudio("102604175", var_720_6)
						arg_717_1:RecordAudio("102604175", var_720_6)
					else
						arg_717_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604175", "story_v_side_old_102604.awb")
					end

					arg_717_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604175", "story_v_side_old_102604.awb")
				end

				arg_717_1:RecordContent(arg_717_1.text_.text)
			end

			local var_720_7 = math.max(var_720_0, arg_717_1.talkMaxDuration)

			if 0 <= arg_717_1.time_ and arg_717_1.time_ < 0 + var_720_7 then
				arg_717_1.typewritter.percent = (arg_717_1.time_ - 0) / var_720_7

				arg_717_1.typewritter:SetDirty()
			end

			if arg_717_1.time_ >= 0 + var_720_7 and arg_717_1.time_ < 0 + var_720_7 + arg_720_0 then
				arg_717_1.typewritter.percent = 1

				arg_717_1.typewritter:SetDirty()
				arg_717_1:ShowNextGo(true)
			end
		end

		arg_717_1.nodeConfigList_ = {}

		arg_717_1:InitPlayNodeList()
	end,
	Play102604176 = function(arg_721_0, arg_721_1)
		arg_721_1.time_ = 0
		arg_721_1.frameCnt_ = 0
		arg_721_1.state_ = "playing"
		arg_721_1.curTalkId_ = 102604176
		arg_721_1.duration_ = 6.2

		local var_721_0 = {
			ja = 6.2,
			ko = 4.7,
			zh = 4.8,
			en = 5.933
		}
		local var_721_1 = manager.audio:GetLocalizationFlag()

		if var_721_0[var_721_1] ~= nil then
			arg_721_1.duration_ = var_721_0[var_721_1]
		end

		SetActive(arg_721_1.tipsGo_, false)

		function arg_721_1.onSingleLineFinish_()
			arg_721_1.onSingleLineUpdate_ = nil
			arg_721_1.onSingleLineFinish_ = nil
			arg_721_1.state_ = "waiting"
		end

		function arg_721_1.playNext_(arg_723_0)
			if arg_723_0 == 1 then
				arg_721_0:Play102604177(arg_721_1)
			end
		end

		function arg_721_1.onSingleLineUpdate_(arg_724_0)
			local var_724_0 = 0.55

			if 0 < arg_721_1.time_ and arg_721_1.time_ <= 0 + arg_724_0 then
				arg_721_1.talkMaxDuration = 0
				arg_721_1.dialogCg_.alpha = 1

				arg_721_1.dialog_:SetActive(true)
				SetActive(arg_721_1.leftNameGo_, true)

				arg_721_1.leftNameTxt_.text = arg_721_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_721_1.leftNameTxt_.transform)

				arg_721_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_721_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_721_1:RecordName(arg_721_1.leftNameTxt_.text)
				SetActive(arg_721_1.iconTrs_.gameObject, false)
				arg_721_1.callingController_:SetSelectedState("normal")

				local var_724_1 = arg_721_1:GetWordFromCfg(102604176)
				local var_724_2 = arg_721_1:FormatText(var_724_1.content)

				arg_721_1.text_.text = var_724_2

				LuaForUtil.ClearLinePrefixSymbol(arg_721_1.text_)

				local var_724_4 = 22 <= 0 and var_724_0 or var_724_0 * (utf8.len(var_724_2) / 22)

				if (22 <= 0 and var_724_0 or var_724_0 * (utf8.len(var_724_2) / 22)) > 0 and var_724_0 < var_724_4 then
					arg_721_1.talkMaxDuration = var_724_4

					if var_724_4 + 0 > arg_721_1.duration_ then
						arg_721_1.duration_ = var_724_4 + 0
					end
				end

				arg_721_1.text_.text = var_724_2
				arg_721_1.typewritter.percent = 0

				arg_721_1.typewritter:SetDirty()
				arg_721_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604176", "story_v_side_old_102604.awb") ~= 0 then
					local var_724_5 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604176", "story_v_side_old_102604.awb") / 1000

					if var_724_5 + 0 > arg_721_1.duration_ then
						arg_721_1.duration_ = var_724_5 + 0
					end

					if var_724_1.prefab_name ~= "" and arg_721_1.actors_[var_724_1.prefab_name] ~= nil then
						local var_724_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_721_1.actors_[var_724_1.prefab_name].transform, "story_v_side_old_102604", "102604176", "story_v_side_old_102604.awb")

						arg_721_1:RecordAudio("102604176", var_724_6)
						arg_721_1:RecordAudio("102604176", var_724_6)
					else
						arg_721_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604176", "story_v_side_old_102604.awb")
					end

					arg_721_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604176", "story_v_side_old_102604.awb")
				end

				arg_721_1:RecordContent(arg_721_1.text_.text)
			end

			local var_724_7 = math.max(var_724_0, arg_721_1.talkMaxDuration)

			if 0 <= arg_721_1.time_ and arg_721_1.time_ < 0 + var_724_7 then
				arg_721_1.typewritter.percent = (arg_721_1.time_ - 0) / var_724_7

				arg_721_1.typewritter:SetDirty()
			end

			if arg_721_1.time_ >= 0 + var_724_7 and arg_721_1.time_ < 0 + var_724_7 + arg_724_0 then
				arg_721_1.typewritter.percent = 1

				arg_721_1.typewritter:SetDirty()
				arg_721_1:ShowNextGo(true)
			end
		end

		arg_721_1.nodeConfigList_ = {}

		arg_721_1:InitPlayNodeList()
	end,
	Play102604177 = function(arg_725_0, arg_725_1)
		arg_725_1.time_ = 0
		arg_725_1.frameCnt_ = 0
		arg_725_1.state_ = "playing"
		arg_725_1.curTalkId_ = 102604177
		arg_725_1.duration_ = 5

		SetActive(arg_725_1.tipsGo_, false)

		function arg_725_1.onSingleLineFinish_()
			arg_725_1.onSingleLineUpdate_ = nil
			arg_725_1.onSingleLineFinish_ = nil
			arg_725_1.state_ = "waiting"
		end

		function arg_725_1.playNext_(arg_727_0)
			if arg_727_0 == 1 then
				arg_725_0:Play102604178(arg_725_1)
			end
		end

		function arg_725_1.onSingleLineUpdate_(arg_728_0)
			local var_728_0 = 0.1

			if 0 < arg_725_1.time_ and arg_725_1.time_ <= 0 + arg_728_0 then
				arg_725_1.talkMaxDuration = 0
				arg_725_1.dialogCg_.alpha = 1

				arg_725_1.dialog_:SetActive(true)
				SetActive(arg_725_1.leftNameGo_, true)

				arg_725_1.leftNameTxt_.text = arg_725_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_725_1.leftNameTxt_.transform)

				arg_725_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_725_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_725_1:RecordName(arg_725_1.leftNameTxt_.text)
				SetActive(arg_725_1.iconTrs_.gameObject, true)
				arg_725_1.iconController_:SetSelectedState("hero")

				arg_725_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_725_1.callingController_:SetSelectedState("normal")

				arg_725_1.keyicon_.color = Color.New(1, 1, 1)
				arg_725_1.icon_.color = Color.New(1, 1, 1)

				local var_728_1 = arg_725_1:FormatText(arg_725_1:GetWordFromCfg(102604177).content)

				arg_725_1.text_.text = var_728_1

				LuaForUtil.ClearLinePrefixSymbol(arg_725_1.text_)

				local var_728_3 = 4 <= 0 and var_728_0 or var_728_0 * (utf8.len(var_728_1) / 4)

				if (4 <= 0 and var_728_0 or var_728_0 * (utf8.len(var_728_1) / 4)) > 0 and var_728_0 < var_728_3 then
					arg_725_1.talkMaxDuration = var_728_3

					if var_728_3 + 0 > arg_725_1.duration_ then
						arg_725_1.duration_ = var_728_3 + 0
					end
				end

				arg_725_1.text_.text = var_728_1
				arg_725_1.typewritter.percent = 0

				arg_725_1.typewritter:SetDirty()
				arg_725_1:ShowNextGo(false)
				arg_725_1:RecordContent(arg_725_1.text_.text)
			end

			local var_728_4 = math.max(var_728_0, arg_725_1.talkMaxDuration)

			if 0 <= arg_725_1.time_ and arg_725_1.time_ < 0 + var_728_4 then
				arg_725_1.typewritter.percent = (arg_725_1.time_ - 0) / var_728_4

				arg_725_1.typewritter:SetDirty()
			end

			if arg_725_1.time_ >= 0 + var_728_4 and arg_725_1.time_ < 0 + var_728_4 + arg_728_0 then
				arg_725_1.typewritter.percent = 1

				arg_725_1.typewritter:SetDirty()
				arg_725_1:ShowNextGo(true)
			end
		end

		arg_725_1.nodeConfigList_ = {}

		arg_725_1:InitPlayNodeList()
	end,
	Play102604178 = function(arg_729_0, arg_729_1)
		arg_729_1.time_ = 0
		arg_729_1.frameCnt_ = 0
		arg_729_1.state_ = "playing"
		arg_729_1.curTalkId_ = 102604178
		arg_729_1.duration_ = 5

		SetActive(arg_729_1.tipsGo_, false)

		function arg_729_1.onSingleLineFinish_()
			arg_729_1.onSingleLineUpdate_ = nil
			arg_729_1.onSingleLineFinish_ = nil
			arg_729_1.state_ = "waiting"
		end

		function arg_729_1.playNext_(arg_731_0)
			if arg_731_0 == 1 then
				arg_729_0:Play102604179(arg_729_1)
			end
		end

		function arg_729_1.onSingleLineUpdate_(arg_732_0)
			local var_732_0 = 0.525

			if 0 < arg_729_1.time_ and arg_729_1.time_ <= 0 + arg_732_0 then
				arg_729_1.talkMaxDuration = 0
				arg_729_1.dialogCg_.alpha = 1

				arg_729_1.dialog_:SetActive(true)
				SetActive(arg_729_1.leftNameGo_, false)

				arg_729_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_729_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_729_1:RecordName(arg_729_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_729_1.iconTrs_.gameObject, false)
				arg_729_1.callingController_:SetSelectedState("normal")

				local var_732_1 = arg_729_1:FormatText(arg_729_1:GetWordFromCfg(102604178).content)

				arg_729_1.text_.text = var_732_1

				LuaForUtil.ClearLinePrefixSymbol(arg_729_1.text_)

				local var_732_3 = 21 <= 0 and var_732_0 or var_732_0 * (utf8.len(var_732_1) / 21)

				if (21 <= 0 and var_732_0 or var_732_0 * (utf8.len(var_732_1) / 21)) > 0 and var_732_0 < var_732_3 then
					arg_729_1.talkMaxDuration = var_732_3

					if var_732_3 + 0 > arg_729_1.duration_ then
						arg_729_1.duration_ = var_732_3 + 0
					end
				end

				arg_729_1.text_.text = var_732_1
				arg_729_1.typewritter.percent = 0

				arg_729_1.typewritter:SetDirty()
				arg_729_1:ShowNextGo(false)
				arg_729_1:RecordContent(arg_729_1.text_.text)
			end

			local var_732_4 = math.max(var_732_0, arg_729_1.talkMaxDuration)

			if 0 <= arg_729_1.time_ and arg_729_1.time_ < 0 + var_732_4 then
				arg_729_1.typewritter.percent = (arg_729_1.time_ - 0) / var_732_4

				arg_729_1.typewritter:SetDirty()
			end

			if arg_729_1.time_ >= 0 + var_732_4 and arg_729_1.time_ < 0 + var_732_4 + arg_732_0 then
				arg_729_1.typewritter.percent = 1

				arg_729_1.typewritter:SetDirty()
				arg_729_1:ShowNextGo(true)
			end
		end

		arg_729_1.nodeConfigList_ = {}

		arg_729_1:InitPlayNodeList()
	end,
	Play102604179 = function(arg_733_0, arg_733_1)
		arg_733_1.time_ = 0
		arg_733_1.frameCnt_ = 0
		arg_733_1.state_ = "playing"
		arg_733_1.curTalkId_ = 102604179
		arg_733_1.duration_ = 5

		SetActive(arg_733_1.tipsGo_, false)

		function arg_733_1.onSingleLineFinish_()
			arg_733_1.onSingleLineUpdate_ = nil
			arg_733_1.onSingleLineFinish_ = nil
			arg_733_1.state_ = "waiting"
		end

		function arg_733_1.playNext_(arg_735_0)
			if arg_735_0 == 1 then
				arg_733_0:Play102604180(arg_733_1)
			end
		end

		function arg_733_1.onSingleLineUpdate_(arg_736_0)
			local var_736_0 = 0.225

			if 0 < arg_733_1.time_ and arg_733_1.time_ <= 0 + arg_736_0 then
				arg_733_1.talkMaxDuration = 0
				arg_733_1.dialogCg_.alpha = 1

				arg_733_1.dialog_:SetActive(true)
				SetActive(arg_733_1.leftNameGo_, false)

				arg_733_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_733_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_733_1:RecordName(arg_733_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_733_1.iconTrs_.gameObject, false)
				arg_733_1.callingController_:SetSelectedState("normal")

				local var_736_1 = arg_733_1:FormatText(arg_733_1:GetWordFromCfg(102604179).content)

				arg_733_1.text_.text = var_736_1

				LuaForUtil.ClearLinePrefixSymbol(arg_733_1.text_)

				local var_736_3 = 9 <= 0 and var_736_0 or var_736_0 * (utf8.len(var_736_1) / 9)

				if (9 <= 0 and var_736_0 or var_736_0 * (utf8.len(var_736_1) / 9)) > 0 and var_736_0 < var_736_3 then
					arg_733_1.talkMaxDuration = var_736_3

					if var_736_3 + 0 > arg_733_1.duration_ then
						arg_733_1.duration_ = var_736_3 + 0
					end
				end

				arg_733_1.text_.text = var_736_1
				arg_733_1.typewritter.percent = 0

				arg_733_1.typewritter:SetDirty()
				arg_733_1:ShowNextGo(false)
				arg_733_1:RecordContent(arg_733_1.text_.text)
			end

			local var_736_4 = math.max(var_736_0, arg_733_1.talkMaxDuration)

			if 0 <= arg_733_1.time_ and arg_733_1.time_ < 0 + var_736_4 then
				arg_733_1.typewritter.percent = (arg_733_1.time_ - 0) / var_736_4

				arg_733_1.typewritter:SetDirty()
			end

			if arg_733_1.time_ >= 0 + var_736_4 and arg_733_1.time_ < 0 + var_736_4 + arg_736_0 then
				arg_733_1.typewritter.percent = 1

				arg_733_1.typewritter:SetDirty()
				arg_733_1:ShowNextGo(true)
			end
		end

		arg_733_1.nodeConfigList_ = {}

		arg_733_1:InitPlayNodeList()
	end,
	Play102604180 = function(arg_737_0, arg_737_1)
		arg_737_1.time_ = 0
		arg_737_1.frameCnt_ = 0
		arg_737_1.state_ = "playing"
		arg_737_1.curTalkId_ = 102604180
		arg_737_1.duration_ = 6.5

		local var_737_0 = {
			ja = 6.5,
			ko = 5.8,
			zh = 3.833,
			en = 5.866
		}
		local var_737_1 = manager.audio:GetLocalizationFlag()

		if var_737_0[var_737_1] ~= nil then
			arg_737_1.duration_ = var_737_0[var_737_1]
		end

		SetActive(arg_737_1.tipsGo_, false)

		function arg_737_1.onSingleLineFinish_()
			arg_737_1.onSingleLineUpdate_ = nil
			arg_737_1.onSingleLineFinish_ = nil
			arg_737_1.state_ = "waiting"
		end

		function arg_737_1.playNext_(arg_739_0)
			if arg_739_0 == 1 then
				arg_737_0:Play102604181(arg_737_1)
			end
		end

		function arg_737_1.onSingleLineUpdate_(arg_740_0)
			local var_740_0 = 0.525

			if 0 < arg_737_1.time_ and arg_737_1.time_ <= 0 + arg_740_0 then
				arg_737_1.talkMaxDuration = 0
				arg_737_1.dialogCg_.alpha = 1

				arg_737_1.dialog_:SetActive(true)
				SetActive(arg_737_1.leftNameGo_, true)

				arg_737_1.leftNameTxt_.text = arg_737_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_737_1.leftNameTxt_.transform)

				arg_737_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_737_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_737_1:RecordName(arg_737_1.leftNameTxt_.text)
				SetActive(arg_737_1.iconTrs_.gameObject, false)
				arg_737_1.callingController_:SetSelectedState("normal")

				local var_740_1 = arg_737_1:GetWordFromCfg(102604180)
				local var_740_2 = arg_737_1:FormatText(var_740_1.content)

				arg_737_1.text_.text = var_740_2

				LuaForUtil.ClearLinePrefixSymbol(arg_737_1.text_)

				local var_740_4 = 21 <= 0 and var_740_0 or var_740_0 * (utf8.len(var_740_2) / 21)

				if (21 <= 0 and var_740_0 or var_740_0 * (utf8.len(var_740_2) / 21)) > 0 and var_740_0 < var_740_4 then
					arg_737_1.talkMaxDuration = var_740_4

					if var_740_4 + 0 > arg_737_1.duration_ then
						arg_737_1.duration_ = var_740_4 + 0
					end
				end

				arg_737_1.text_.text = var_740_2
				arg_737_1.typewritter.percent = 0

				arg_737_1.typewritter:SetDirty()
				arg_737_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604180", "story_v_side_old_102604.awb") ~= 0 then
					local var_740_5 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604180", "story_v_side_old_102604.awb") / 1000

					if var_740_5 + 0 > arg_737_1.duration_ then
						arg_737_1.duration_ = var_740_5 + 0
					end

					if var_740_1.prefab_name ~= "" and arg_737_1.actors_[var_740_1.prefab_name] ~= nil then
						local var_740_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_737_1.actors_[var_740_1.prefab_name].transform, "story_v_side_old_102604", "102604180", "story_v_side_old_102604.awb")

						arg_737_1:RecordAudio("102604180", var_740_6)
						arg_737_1:RecordAudio("102604180", var_740_6)
					else
						arg_737_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604180", "story_v_side_old_102604.awb")
					end

					arg_737_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604180", "story_v_side_old_102604.awb")
				end

				arg_737_1:RecordContent(arg_737_1.text_.text)
			end

			local var_740_7 = math.max(var_740_0, arg_737_1.talkMaxDuration)

			if 0 <= arg_737_1.time_ and arg_737_1.time_ < 0 + var_740_7 then
				arg_737_1.typewritter.percent = (arg_737_1.time_ - 0) / var_740_7

				arg_737_1.typewritter:SetDirty()
			end

			if arg_737_1.time_ >= 0 + var_740_7 and arg_737_1.time_ < 0 + var_740_7 + arg_740_0 then
				arg_737_1.typewritter.percent = 1

				arg_737_1.typewritter:SetDirty()
				arg_737_1:ShowNextGo(true)
			end
		end

		arg_737_1.nodeConfigList_ = {}

		arg_737_1:InitPlayNodeList()
	end,
	Play102604181 = function(arg_741_0, arg_741_1)
		arg_741_1.time_ = 0
		arg_741_1.frameCnt_ = 0
		arg_741_1.state_ = "playing"
		arg_741_1.curTalkId_ = 102604181
		arg_741_1.duration_ = 7.37

		local var_741_0 = {
			ja = 7.366,
			ko = 3.6,
			zh = 4.333,
			en = 4
		}
		local var_741_1 = manager.audio:GetLocalizationFlag()

		if var_741_0[var_741_1] ~= nil then
			arg_741_1.duration_ = var_741_0[var_741_1]
		end

		SetActive(arg_741_1.tipsGo_, false)

		function arg_741_1.onSingleLineFinish_()
			arg_741_1.onSingleLineUpdate_ = nil
			arg_741_1.onSingleLineFinish_ = nil
			arg_741_1.state_ = "waiting"
		end

		function arg_741_1.playNext_(arg_743_0)
			if arg_743_0 == 1 then
				arg_741_0:Play102604182(arg_741_1)
			end
		end

		function arg_741_1.onSingleLineUpdate_(arg_744_0)
			local var_744_0 = 0.5

			if 0 < arg_741_1.time_ and arg_741_1.time_ <= 0 + arg_744_0 then
				arg_741_1.talkMaxDuration = 0
				arg_741_1.dialogCg_.alpha = 1

				arg_741_1.dialog_:SetActive(true)
				SetActive(arg_741_1.leftNameGo_, true)

				arg_741_1.leftNameTxt_.text = arg_741_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_741_1.leftNameTxt_.transform)

				arg_741_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_741_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_741_1:RecordName(arg_741_1.leftNameTxt_.text)
				SetActive(arg_741_1.iconTrs_.gameObject, false)
				arg_741_1.callingController_:SetSelectedState("normal")

				local var_744_1 = arg_741_1:GetWordFromCfg(102604181)
				local var_744_2 = arg_741_1:FormatText(var_744_1.content)

				arg_741_1.text_.text = var_744_2

				LuaForUtil.ClearLinePrefixSymbol(arg_741_1.text_)

				local var_744_4 = 20 <= 0 and var_744_0 or var_744_0 * (utf8.len(var_744_2) / 20)

				if (20 <= 0 and var_744_0 or var_744_0 * (utf8.len(var_744_2) / 20)) > 0 and var_744_0 < var_744_4 then
					arg_741_1.talkMaxDuration = var_744_4

					if var_744_4 + 0 > arg_741_1.duration_ then
						arg_741_1.duration_ = var_744_4 + 0
					end
				end

				arg_741_1.text_.text = var_744_2
				arg_741_1.typewritter.percent = 0

				arg_741_1.typewritter:SetDirty()
				arg_741_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604181", "story_v_side_old_102604.awb") ~= 0 then
					local var_744_5 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604181", "story_v_side_old_102604.awb") / 1000

					if var_744_5 + 0 > arg_741_1.duration_ then
						arg_741_1.duration_ = var_744_5 + 0
					end

					if var_744_1.prefab_name ~= "" and arg_741_1.actors_[var_744_1.prefab_name] ~= nil then
						local var_744_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_741_1.actors_[var_744_1.prefab_name].transform, "story_v_side_old_102604", "102604181", "story_v_side_old_102604.awb")

						arg_741_1:RecordAudio("102604181", var_744_6)
						arg_741_1:RecordAudio("102604181", var_744_6)
					else
						arg_741_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604181", "story_v_side_old_102604.awb")
					end

					arg_741_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604181", "story_v_side_old_102604.awb")
				end

				arg_741_1:RecordContent(arg_741_1.text_.text)
			end

			local var_744_7 = math.max(var_744_0, arg_741_1.talkMaxDuration)

			if 0 <= arg_741_1.time_ and arg_741_1.time_ < 0 + var_744_7 then
				arg_741_1.typewritter.percent = (arg_741_1.time_ - 0) / var_744_7

				arg_741_1.typewritter:SetDirty()
			end

			if arg_741_1.time_ >= 0 + var_744_7 and arg_741_1.time_ < 0 + var_744_7 + arg_744_0 then
				arg_741_1.typewritter.percent = 1

				arg_741_1.typewritter:SetDirty()
				arg_741_1:ShowNextGo(true)
			end
		end

		arg_741_1.nodeConfigList_ = {}

		arg_741_1:InitPlayNodeList()
	end,
	Play102604182 = function(arg_745_0, arg_745_1)
		arg_745_1.time_ = 0
		arg_745_1.frameCnt_ = 0
		arg_745_1.state_ = "playing"
		arg_745_1.curTalkId_ = 102604182
		arg_745_1.duration_ = 5

		SetActive(arg_745_1.tipsGo_, false)

		function arg_745_1.onSingleLineFinish_()
			arg_745_1.onSingleLineUpdate_ = nil
			arg_745_1.onSingleLineFinish_ = nil
			arg_745_1.state_ = "waiting"
		end

		function arg_745_1.playNext_(arg_747_0)
			if arg_747_0 == 1 then
				arg_745_0:Play102604183(arg_745_1)
			end
		end

		function arg_745_1.onSingleLineUpdate_(arg_748_0)
			local var_748_0 = 0.125

			if 0 < arg_745_1.time_ and arg_745_1.time_ <= 0 + arg_748_0 then
				arg_745_1.talkMaxDuration = 0
				arg_745_1.dialogCg_.alpha = 1

				arg_745_1.dialog_:SetActive(true)
				SetActive(arg_745_1.leftNameGo_, false)

				arg_745_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_745_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_745_1:RecordName(arg_745_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_745_1.iconTrs_.gameObject, false)
				arg_745_1.callingController_:SetSelectedState("normal")

				local var_748_1 = arg_745_1:FormatText(arg_745_1:GetWordFromCfg(102604182).content)

				arg_745_1.text_.text = var_748_1

				LuaForUtil.ClearLinePrefixSymbol(arg_745_1.text_)

				local var_748_3 = 5 <= 0 and var_748_0 or var_748_0 * (utf8.len(var_748_1) / 5)

				if (5 <= 0 and var_748_0 or var_748_0 * (utf8.len(var_748_1) / 5)) > 0 and var_748_0 < var_748_3 then
					arg_745_1.talkMaxDuration = var_748_3

					if var_748_3 + 0 > arg_745_1.duration_ then
						arg_745_1.duration_ = var_748_3 + 0
					end
				end

				arg_745_1.text_.text = var_748_1
				arg_745_1.typewritter.percent = 0

				arg_745_1.typewritter:SetDirty()
				arg_745_1:ShowNextGo(false)
				arg_745_1:RecordContent(arg_745_1.text_.text)
			end

			local var_748_4 = math.max(var_748_0, arg_745_1.talkMaxDuration)

			if 0 <= arg_745_1.time_ and arg_745_1.time_ < 0 + var_748_4 then
				arg_745_1.typewritter.percent = (arg_745_1.time_ - 0) / var_748_4

				arg_745_1.typewritter:SetDirty()
			end

			if arg_745_1.time_ >= 0 + var_748_4 and arg_745_1.time_ < 0 + var_748_4 + arg_748_0 then
				arg_745_1.typewritter.percent = 1

				arg_745_1.typewritter:SetDirty()
				arg_745_1:ShowNextGo(true)
			end
		end

		arg_745_1.nodeConfigList_ = {}

		arg_745_1:InitPlayNodeList()
	end,
	Play102604183 = function(arg_749_0, arg_749_1)
		arg_749_1.time_ = 0
		arg_749_1.frameCnt_ = 0
		arg_749_1.state_ = "playing"
		arg_749_1.curTalkId_ = 102604183
		arg_749_1.duration_ = 5

		SetActive(arg_749_1.tipsGo_, false)

		function arg_749_1.onSingleLineFinish_()
			arg_749_1.onSingleLineUpdate_ = nil
			arg_749_1.onSingleLineFinish_ = nil
			arg_749_1.state_ = "waiting"
		end

		function arg_749_1.playNext_(arg_751_0)
			if arg_751_0 == 1 then
				arg_749_0:Play102604184(arg_749_1)
			end
		end

		function arg_749_1.onSingleLineUpdate_(arg_752_0)
			local var_752_0 = 1.375

			if 0 < arg_749_1.time_ and arg_749_1.time_ <= 0 + arg_752_0 then
				arg_749_1.talkMaxDuration = 0
				arg_749_1.dialogCg_.alpha = 1

				arg_749_1.dialog_:SetActive(true)
				SetActive(arg_749_1.leftNameGo_, false)

				arg_749_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_749_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_749_1:RecordName(arg_749_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_749_1.iconTrs_.gameObject, false)
				arg_749_1.callingController_:SetSelectedState("normal")

				local var_752_1 = arg_749_1:FormatText(arg_749_1:GetWordFromCfg(102604183).content)

				arg_749_1.text_.text = var_752_1

				LuaForUtil.ClearLinePrefixSymbol(arg_749_1.text_)

				local var_752_3 = 54 <= 0 and var_752_0 or var_752_0 * (utf8.len(var_752_1) / 54)

				if (54 <= 0 and var_752_0 or var_752_0 * (utf8.len(var_752_1) / 54)) > 0 and var_752_0 < var_752_3 then
					arg_749_1.talkMaxDuration = var_752_3

					if var_752_3 + 0 > arg_749_1.duration_ then
						arg_749_1.duration_ = var_752_3 + 0
					end
				end

				arg_749_1.text_.text = var_752_1
				arg_749_1.typewritter.percent = 0

				arg_749_1.typewritter:SetDirty()
				arg_749_1:ShowNextGo(false)
				arg_749_1:RecordContent(arg_749_1.text_.text)
			end

			local var_752_4 = math.max(var_752_0, arg_749_1.talkMaxDuration)

			if 0 <= arg_749_1.time_ and arg_749_1.time_ < 0 + var_752_4 then
				arg_749_1.typewritter.percent = (arg_749_1.time_ - 0) / var_752_4

				arg_749_1.typewritter:SetDirty()
			end

			if arg_749_1.time_ >= 0 + var_752_4 and arg_749_1.time_ < 0 + var_752_4 + arg_752_0 then
				arg_749_1.typewritter.percent = 1

				arg_749_1.typewritter:SetDirty()
				arg_749_1:ShowNextGo(true)
			end
		end

		arg_749_1.nodeConfigList_ = {}

		arg_749_1:InitPlayNodeList()
	end,
	Play102604184 = function(arg_753_0, arg_753_1)
		arg_753_1.time_ = 0
		arg_753_1.frameCnt_ = 0
		arg_753_1.state_ = "playing"
		arg_753_1.curTalkId_ = 102604184
		arg_753_1.duration_ = 7.43

		local var_753_0 = {
			ja = 7.433,
			ko = 3.4,
			zh = 4.8,
			en = 2.733
		}
		local var_753_1 = manager.audio:GetLocalizationFlag()

		if var_753_0[var_753_1] ~= nil then
			arg_753_1.duration_ = var_753_0[var_753_1]
		end

		SetActive(arg_753_1.tipsGo_, false)

		function arg_753_1.onSingleLineFinish_()
			arg_753_1.onSingleLineUpdate_ = nil
			arg_753_1.onSingleLineFinish_ = nil
			arg_753_1.state_ = "waiting"
		end

		function arg_753_1.playNext_(arg_755_0)
			if arg_755_0 == 1 then
				arg_753_0:Play102604185(arg_753_1)
			end
		end

		function arg_753_1.onSingleLineUpdate_(arg_756_0)
			local var_756_0 = 0.525

			if 0 < arg_753_1.time_ and arg_753_1.time_ <= 0 + arg_756_0 then
				arg_753_1.talkMaxDuration = 0
				arg_753_1.dialogCg_.alpha = 1

				arg_753_1.dialog_:SetActive(true)
				SetActive(arg_753_1.leftNameGo_, true)

				arg_753_1.leftNameTxt_.text = arg_753_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_753_1.leftNameTxt_.transform)

				arg_753_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_753_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_753_1:RecordName(arg_753_1.leftNameTxt_.text)
				SetActive(arg_753_1.iconTrs_.gameObject, false)
				arg_753_1.callingController_:SetSelectedState("normal")

				local var_756_1 = arg_753_1:GetWordFromCfg(102604184)
				local var_756_2 = arg_753_1:FormatText(var_756_1.content)

				arg_753_1.text_.text = var_756_2

				LuaForUtil.ClearLinePrefixSymbol(arg_753_1.text_)

				local var_756_4 = 21 <= 0 and var_756_0 or var_756_0 * (utf8.len(var_756_2) / 21)

				if (21 <= 0 and var_756_0 or var_756_0 * (utf8.len(var_756_2) / 21)) > 0 and var_756_0 < var_756_4 then
					arg_753_1.talkMaxDuration = var_756_4

					if var_756_4 + 0 > arg_753_1.duration_ then
						arg_753_1.duration_ = var_756_4 + 0
					end
				end

				arg_753_1.text_.text = var_756_2
				arg_753_1.typewritter.percent = 0

				arg_753_1.typewritter:SetDirty()
				arg_753_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604184", "story_v_side_old_102604.awb") ~= 0 then
					local var_756_5 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604184", "story_v_side_old_102604.awb") / 1000

					if var_756_5 + 0 > arg_753_1.duration_ then
						arg_753_1.duration_ = var_756_5 + 0
					end

					if var_756_1.prefab_name ~= "" and arg_753_1.actors_[var_756_1.prefab_name] ~= nil then
						local var_756_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_753_1.actors_[var_756_1.prefab_name].transform, "story_v_side_old_102604", "102604184", "story_v_side_old_102604.awb")

						arg_753_1:RecordAudio("102604184", var_756_6)
						arg_753_1:RecordAudio("102604184", var_756_6)
					else
						arg_753_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604184", "story_v_side_old_102604.awb")
					end

					arg_753_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604184", "story_v_side_old_102604.awb")
				end

				arg_753_1:RecordContent(arg_753_1.text_.text)
			end

			local var_756_7 = math.max(var_756_0, arg_753_1.talkMaxDuration)

			if 0 <= arg_753_1.time_ and arg_753_1.time_ < 0 + var_756_7 then
				arg_753_1.typewritter.percent = (arg_753_1.time_ - 0) / var_756_7

				arg_753_1.typewritter:SetDirty()
			end

			if arg_753_1.time_ >= 0 + var_756_7 and arg_753_1.time_ < 0 + var_756_7 + arg_756_0 then
				arg_753_1.typewritter.percent = 1

				arg_753_1.typewritter:SetDirty()
				arg_753_1:ShowNextGo(true)
			end
		end

		arg_753_1.nodeConfigList_ = {}

		arg_753_1:InitPlayNodeList()
	end,
	Play102604185 = function(arg_757_0, arg_757_1)
		arg_757_1.time_ = 0
		arg_757_1.frameCnt_ = 0
		arg_757_1.state_ = "playing"
		arg_757_1.curTalkId_ = 102604185
		arg_757_1.duration_ = 5

		SetActive(arg_757_1.tipsGo_, false)

		function arg_757_1.onSingleLineFinish_()
			arg_757_1.onSingleLineUpdate_ = nil
			arg_757_1.onSingleLineFinish_ = nil
			arg_757_1.state_ = "waiting"
		end

		function arg_757_1.playNext_(arg_759_0)
			if arg_759_0 == 1 then
				arg_757_0:Play102604186(arg_757_1)
			end
		end

		function arg_757_1.onSingleLineUpdate_(arg_760_0)
			local var_760_0 = 0.175

			if 0 < arg_757_1.time_ and arg_757_1.time_ <= 0 + arg_760_0 then
				arg_757_1.talkMaxDuration = 0
				arg_757_1.dialogCg_.alpha = 1

				arg_757_1.dialog_:SetActive(true)
				SetActive(arg_757_1.leftNameGo_, true)

				arg_757_1.leftNameTxt_.text = arg_757_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_757_1.leftNameTxt_.transform)

				arg_757_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_757_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_757_1:RecordName(arg_757_1.leftNameTxt_.text)
				SetActive(arg_757_1.iconTrs_.gameObject, true)
				arg_757_1.iconController_:SetSelectedState("hero")

				arg_757_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_757_1.callingController_:SetSelectedState("normal")

				arg_757_1.keyicon_.color = Color.New(1, 1, 1)
				arg_757_1.icon_.color = Color.New(1, 1, 1)

				local var_760_1 = arg_757_1:FormatText(arg_757_1:GetWordFromCfg(102604185).content)

				arg_757_1.text_.text = var_760_1

				LuaForUtil.ClearLinePrefixSymbol(arg_757_1.text_)

				local var_760_3 = 7 <= 0 and var_760_0 or var_760_0 * (utf8.len(var_760_1) / 7)

				if (7 <= 0 and var_760_0 or var_760_0 * (utf8.len(var_760_1) / 7)) > 0 and var_760_0 < var_760_3 then
					arg_757_1.talkMaxDuration = var_760_3

					if var_760_3 + 0 > arg_757_1.duration_ then
						arg_757_1.duration_ = var_760_3 + 0
					end
				end

				arg_757_1.text_.text = var_760_1
				arg_757_1.typewritter.percent = 0

				arg_757_1.typewritter:SetDirty()
				arg_757_1:ShowNextGo(false)
				arg_757_1:RecordContent(arg_757_1.text_.text)
			end

			local var_760_4 = math.max(var_760_0, arg_757_1.talkMaxDuration)

			if 0 <= arg_757_1.time_ and arg_757_1.time_ < 0 + var_760_4 then
				arg_757_1.typewritter.percent = (arg_757_1.time_ - 0) / var_760_4

				arg_757_1.typewritter:SetDirty()
			end

			if arg_757_1.time_ >= 0 + var_760_4 and arg_757_1.time_ < 0 + var_760_4 + arg_760_0 then
				arg_757_1.typewritter.percent = 1

				arg_757_1.typewritter:SetDirty()
				arg_757_1:ShowNextGo(true)
			end
		end

		arg_757_1.nodeConfigList_ = {}

		arg_757_1:InitPlayNodeList()
	end,
	Play102604186 = function(arg_761_0, arg_761_1)
		arg_761_1.time_ = 0
		arg_761_1.frameCnt_ = 0
		arg_761_1.state_ = "playing"
		arg_761_1.curTalkId_ = 102604186
		arg_761_1.duration_ = 5

		SetActive(arg_761_1.tipsGo_, false)

		function arg_761_1.onSingleLineFinish_()
			arg_761_1.onSingleLineUpdate_ = nil
			arg_761_1.onSingleLineFinish_ = nil
			arg_761_1.state_ = "waiting"
		end

		function arg_761_1.playNext_(arg_763_0)
			if arg_763_0 == 1 then
				arg_761_0:Play102604187(arg_761_1)
			end
		end

		function arg_761_1.onSingleLineUpdate_(arg_764_0)
			local var_764_0 = 0.875

			if 0 < arg_761_1.time_ and arg_761_1.time_ <= 0 + arg_764_0 then
				arg_761_1.talkMaxDuration = 0
				arg_761_1.dialogCg_.alpha = 1

				arg_761_1.dialog_:SetActive(true)
				SetActive(arg_761_1.leftNameGo_, false)

				arg_761_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_761_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_761_1:RecordName(arg_761_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_761_1.iconTrs_.gameObject, false)
				arg_761_1.callingController_:SetSelectedState("normal")

				local var_764_1 = arg_761_1:FormatText(arg_761_1:GetWordFromCfg(102604186).content)

				arg_761_1.text_.text = var_764_1

				LuaForUtil.ClearLinePrefixSymbol(arg_761_1.text_)

				local var_764_3 = 35 <= 0 and var_764_0 or var_764_0 * (utf8.len(var_764_1) / 35)

				if (35 <= 0 and var_764_0 or var_764_0 * (utf8.len(var_764_1) / 35)) > 0 and var_764_0 < var_764_3 then
					arg_761_1.talkMaxDuration = var_764_3

					if var_764_3 + 0 > arg_761_1.duration_ then
						arg_761_1.duration_ = var_764_3 + 0
					end
				end

				arg_761_1.text_.text = var_764_1
				arg_761_1.typewritter.percent = 0

				arg_761_1.typewritter:SetDirty()
				arg_761_1:ShowNextGo(false)
				arg_761_1:RecordContent(arg_761_1.text_.text)
			end

			local var_764_4 = math.max(var_764_0, arg_761_1.talkMaxDuration)

			if 0 <= arg_761_1.time_ and arg_761_1.time_ < 0 + var_764_4 then
				arg_761_1.typewritter.percent = (arg_761_1.time_ - 0) / var_764_4

				arg_761_1.typewritter:SetDirty()
			end

			if arg_761_1.time_ >= 0 + var_764_4 and arg_761_1.time_ < 0 + var_764_4 + arg_764_0 then
				arg_761_1.typewritter.percent = 1

				arg_761_1.typewritter:SetDirty()
				arg_761_1:ShowNextGo(true)
			end
		end

		arg_761_1.nodeConfigList_ = {}

		arg_761_1:InitPlayNodeList()
	end,
	Play102604187 = function(arg_765_0, arg_765_1)
		arg_765_1.time_ = 0
		arg_765_1.frameCnt_ = 0
		arg_765_1.state_ = "playing"
		arg_765_1.curTalkId_ = 102604187
		arg_765_1.duration_ = 4.5

		local var_765_0 = {
			ja = 4.5,
			ko = 2.766,
			zh = 3.066,
			en = 3.433
		}
		local var_765_1 = manager.audio:GetLocalizationFlag()

		if var_765_0[var_765_1] ~= nil then
			arg_765_1.duration_ = var_765_0[var_765_1]
		end

		SetActive(arg_765_1.tipsGo_, false)

		function arg_765_1.onSingleLineFinish_()
			arg_765_1.onSingleLineUpdate_ = nil
			arg_765_1.onSingleLineFinish_ = nil
			arg_765_1.state_ = "waiting"
		end

		function arg_765_1.playNext_(arg_767_0)
			if arg_767_0 == 1 then
				arg_765_0:Play102604188(arg_765_1)
			end
		end

		function arg_765_1.onSingleLineUpdate_(arg_768_0)
			local var_768_0 = 0.375

			if 0 < arg_765_1.time_ and arg_765_1.time_ <= 0 + arg_768_0 then
				arg_765_1.talkMaxDuration = 0
				arg_765_1.dialogCg_.alpha = 1

				arg_765_1.dialog_:SetActive(true)
				SetActive(arg_765_1.leftNameGo_, true)

				arg_765_1.leftNameTxt_.text = arg_765_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_765_1.leftNameTxt_.transform)

				arg_765_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_765_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_765_1:RecordName(arg_765_1.leftNameTxt_.text)
				SetActive(arg_765_1.iconTrs_.gameObject, false)
				arg_765_1.callingController_:SetSelectedState("normal")

				local var_768_1 = arg_765_1:GetWordFromCfg(102604187)
				local var_768_2 = arg_765_1:FormatText(var_768_1.content)

				arg_765_1.text_.text = var_768_2

				LuaForUtil.ClearLinePrefixSymbol(arg_765_1.text_)

				local var_768_4 = 15 <= 0 and var_768_0 or var_768_0 * (utf8.len(var_768_2) / 15)

				if (15 <= 0 and var_768_0 or var_768_0 * (utf8.len(var_768_2) / 15)) > 0 and var_768_0 < var_768_4 then
					arg_765_1.talkMaxDuration = var_768_4

					if var_768_4 + 0 > arg_765_1.duration_ then
						arg_765_1.duration_ = var_768_4 + 0
					end
				end

				arg_765_1.text_.text = var_768_2
				arg_765_1.typewritter.percent = 0

				arg_765_1.typewritter:SetDirty()
				arg_765_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604187", "story_v_side_old_102604.awb") ~= 0 then
					local var_768_5 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604187", "story_v_side_old_102604.awb") / 1000

					if var_768_5 + 0 > arg_765_1.duration_ then
						arg_765_1.duration_ = var_768_5 + 0
					end

					if var_768_1.prefab_name ~= "" and arg_765_1.actors_[var_768_1.prefab_name] ~= nil then
						local var_768_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_765_1.actors_[var_768_1.prefab_name].transform, "story_v_side_old_102604", "102604187", "story_v_side_old_102604.awb")

						arg_765_1:RecordAudio("102604187", var_768_6)
						arg_765_1:RecordAudio("102604187", var_768_6)
					else
						arg_765_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604187", "story_v_side_old_102604.awb")
					end

					arg_765_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604187", "story_v_side_old_102604.awb")
				end

				arg_765_1:RecordContent(arg_765_1.text_.text)
			end

			local var_768_7 = math.max(var_768_0, arg_765_1.talkMaxDuration)

			if 0 <= arg_765_1.time_ and arg_765_1.time_ < 0 + var_768_7 then
				arg_765_1.typewritter.percent = (arg_765_1.time_ - 0) / var_768_7

				arg_765_1.typewritter:SetDirty()
			end

			if arg_765_1.time_ >= 0 + var_768_7 and arg_765_1.time_ < 0 + var_768_7 + arg_768_0 then
				arg_765_1.typewritter.percent = 1

				arg_765_1.typewritter:SetDirty()
				arg_765_1:ShowNextGo(true)
			end
		end

		arg_765_1.nodeConfigList_ = {}

		arg_765_1:InitPlayNodeList()
	end,
	Play102604188 = function(arg_769_0, arg_769_1)
		arg_769_1.time_ = 0
		arg_769_1.frameCnt_ = 0
		arg_769_1.state_ = "playing"
		arg_769_1.curTalkId_ = 102604188
		arg_769_1.duration_ = 2.47

		local var_769_0 = {
			ja = 2.1,
			ko = 2.066,
			zh = 2.466,
			en = 1.833
		}
		local var_769_1 = manager.audio:GetLocalizationFlag()

		if var_769_0[var_769_1] ~= nil then
			arg_769_1.duration_ = var_769_0[var_769_1]
		end

		SetActive(arg_769_1.tipsGo_, false)

		function arg_769_1.onSingleLineFinish_()
			arg_769_1.onSingleLineUpdate_ = nil
			arg_769_1.onSingleLineFinish_ = nil
			arg_769_1.state_ = "waiting"
		end

		function arg_769_1.playNext_(arg_771_0)
			if arg_771_0 == 1 then
				arg_769_0:Play102604189(arg_769_1)
			end
		end

		function arg_769_1.onSingleLineUpdate_(arg_772_0)
			local var_772_0 = 0.25

			if 0 < arg_769_1.time_ and arg_769_1.time_ <= 0 + arg_772_0 then
				arg_769_1.talkMaxDuration = 0
				arg_769_1.dialogCg_.alpha = 1

				arg_769_1.dialog_:SetActive(true)
				SetActive(arg_769_1.leftNameGo_, true)

				arg_769_1.leftNameTxt_.text = arg_769_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_769_1.leftNameTxt_.transform)

				arg_769_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_769_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_769_1:RecordName(arg_769_1.leftNameTxt_.text)
				SetActive(arg_769_1.iconTrs_.gameObject, false)
				arg_769_1.callingController_:SetSelectedState("normal")

				local var_772_1 = arg_769_1:GetWordFromCfg(102604188)
				local var_772_2 = arg_769_1:FormatText(var_772_1.content)

				arg_769_1.text_.text = var_772_2

				LuaForUtil.ClearLinePrefixSymbol(arg_769_1.text_)

				local var_772_4 = 10 <= 0 and var_772_0 or var_772_0 * (utf8.len(var_772_2) / 10)

				if (10 <= 0 and var_772_0 or var_772_0 * (utf8.len(var_772_2) / 10)) > 0 and var_772_0 < var_772_4 then
					arg_769_1.talkMaxDuration = var_772_4

					if var_772_4 + 0 > arg_769_1.duration_ then
						arg_769_1.duration_ = var_772_4 + 0
					end
				end

				arg_769_1.text_.text = var_772_2
				arg_769_1.typewritter.percent = 0

				arg_769_1.typewritter:SetDirty()
				arg_769_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604188", "story_v_side_old_102604.awb") ~= 0 then
					local var_772_5 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604188", "story_v_side_old_102604.awb") / 1000

					if var_772_5 + 0 > arg_769_1.duration_ then
						arg_769_1.duration_ = var_772_5 + 0
					end

					if var_772_1.prefab_name ~= "" and arg_769_1.actors_[var_772_1.prefab_name] ~= nil then
						local var_772_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_769_1.actors_[var_772_1.prefab_name].transform, "story_v_side_old_102604", "102604188", "story_v_side_old_102604.awb")

						arg_769_1:RecordAudio("102604188", var_772_6)
						arg_769_1:RecordAudio("102604188", var_772_6)
					else
						arg_769_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604188", "story_v_side_old_102604.awb")
					end

					arg_769_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604188", "story_v_side_old_102604.awb")
				end

				arg_769_1:RecordContent(arg_769_1.text_.text)
			end

			local var_772_7 = math.max(var_772_0, arg_769_1.talkMaxDuration)

			if 0 <= arg_769_1.time_ and arg_769_1.time_ < 0 + var_772_7 then
				arg_769_1.typewritter.percent = (arg_769_1.time_ - 0) / var_772_7

				arg_769_1.typewritter:SetDirty()
			end

			if arg_769_1.time_ >= 0 + var_772_7 and arg_769_1.time_ < 0 + var_772_7 + arg_772_0 then
				arg_769_1.typewritter.percent = 1

				arg_769_1.typewritter:SetDirty()
				arg_769_1:ShowNextGo(true)
			end
		end

		arg_769_1.nodeConfigList_ = {}

		arg_769_1:InitPlayNodeList()
	end,
	Play102604189 = function(arg_773_0, arg_773_1)
		arg_773_1.time_ = 0
		arg_773_1.frameCnt_ = 0
		arg_773_1.state_ = "playing"
		arg_773_1.curTalkId_ = 102604189
		arg_773_1.duration_ = 5

		SetActive(arg_773_1.tipsGo_, false)

		function arg_773_1.onSingleLineFinish_()
			arg_773_1.onSingleLineUpdate_ = nil
			arg_773_1.onSingleLineFinish_ = nil
			arg_773_1.state_ = "waiting"
		end

		function arg_773_1.playNext_(arg_775_0)
			if arg_775_0 == 1 then
				arg_773_0:Play102604190(arg_773_1)
			end
		end

		function arg_773_1.onSingleLineUpdate_(arg_776_0)
			local var_776_0 = 0.35

			if 0 < arg_773_1.time_ and arg_773_1.time_ <= 0 + arg_776_0 then
				arg_773_1.talkMaxDuration = 0
				arg_773_1.dialogCg_.alpha = 1

				arg_773_1.dialog_:SetActive(true)
				SetActive(arg_773_1.leftNameGo_, false)

				arg_773_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_773_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_773_1:RecordName(arg_773_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_773_1.iconTrs_.gameObject, false)
				arg_773_1.callingController_:SetSelectedState("normal")

				local var_776_1 = arg_773_1:FormatText(arg_773_1:GetWordFromCfg(102604189).content)

				arg_773_1.text_.text = var_776_1

				LuaForUtil.ClearLinePrefixSymbol(arg_773_1.text_)

				local var_776_3 = 14 <= 0 and var_776_0 or var_776_0 * (utf8.len(var_776_1) / 14)

				if (14 <= 0 and var_776_0 or var_776_0 * (utf8.len(var_776_1) / 14)) > 0 and var_776_0 < var_776_3 then
					arg_773_1.talkMaxDuration = var_776_3

					if var_776_3 + 0 > arg_773_1.duration_ then
						arg_773_1.duration_ = var_776_3 + 0
					end
				end

				arg_773_1.text_.text = var_776_1
				arg_773_1.typewritter.percent = 0

				arg_773_1.typewritter:SetDirty()
				arg_773_1:ShowNextGo(false)
				arg_773_1:RecordContent(arg_773_1.text_.text)
			end

			local var_776_4 = math.max(var_776_0, arg_773_1.talkMaxDuration)

			if 0 <= arg_773_1.time_ and arg_773_1.time_ < 0 + var_776_4 then
				arg_773_1.typewritter.percent = (arg_773_1.time_ - 0) / var_776_4

				arg_773_1.typewritter:SetDirty()
			end

			if arg_773_1.time_ >= 0 + var_776_4 and arg_773_1.time_ < 0 + var_776_4 + arg_776_0 then
				arg_773_1.typewritter.percent = 1

				arg_773_1.typewritter:SetDirty()
				arg_773_1:ShowNextGo(true)
			end
		end

		arg_773_1.nodeConfigList_ = {}

		arg_773_1:InitPlayNodeList()
	end,
	Play102604190 = function(arg_777_0, arg_777_1)
		arg_777_1.time_ = 0
		arg_777_1.frameCnt_ = 0
		arg_777_1.state_ = "playing"
		arg_777_1.curTalkId_ = 102604190
		arg_777_1.duration_ = 7.1

		local var_777_0 = {
			ja = 5.466,
			ko = 3.6,
			zh = 4.3,
			en = 7.1
		}
		local var_777_1 = manager.audio:GetLocalizationFlag()

		if var_777_0[var_777_1] ~= nil then
			arg_777_1.duration_ = var_777_0[var_777_1]
		end

		SetActive(arg_777_1.tipsGo_, false)

		function arg_777_1.onSingleLineFinish_()
			arg_777_1.onSingleLineUpdate_ = nil
			arg_777_1.onSingleLineFinish_ = nil
			arg_777_1.state_ = "waiting"
		end

		function arg_777_1.playNext_(arg_779_0)
			if arg_779_0 == 1 then
				arg_777_0:Play102604191(arg_777_1)
			end
		end

		function arg_777_1.onSingleLineUpdate_(arg_780_0)
			local var_780_0 = 0.475

			if 0 < arg_777_1.time_ and arg_777_1.time_ <= 0 + arg_780_0 then
				arg_777_1.talkMaxDuration = 0
				arg_777_1.dialogCg_.alpha = 1

				arg_777_1.dialog_:SetActive(true)
				SetActive(arg_777_1.leftNameGo_, true)

				arg_777_1.leftNameTxt_.text = arg_777_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_777_1.leftNameTxt_.transform)

				arg_777_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_777_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_777_1:RecordName(arg_777_1.leftNameTxt_.text)
				SetActive(arg_777_1.iconTrs_.gameObject, false)
				arg_777_1.callingController_:SetSelectedState("normal")

				local var_780_1 = arg_777_1:GetWordFromCfg(102604190)
				local var_780_2 = arg_777_1:FormatText(var_780_1.content)

				arg_777_1.text_.text = var_780_2

				LuaForUtil.ClearLinePrefixSymbol(arg_777_1.text_)

				local var_780_4 = 19 <= 0 and var_780_0 or var_780_0 * (utf8.len(var_780_2) / 19)

				if (19 <= 0 and var_780_0 or var_780_0 * (utf8.len(var_780_2) / 19)) > 0 and var_780_0 < var_780_4 then
					arg_777_1.talkMaxDuration = var_780_4

					if var_780_4 + 0 > arg_777_1.duration_ then
						arg_777_1.duration_ = var_780_4 + 0
					end
				end

				arg_777_1.text_.text = var_780_2
				arg_777_1.typewritter.percent = 0

				arg_777_1.typewritter:SetDirty()
				arg_777_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604190", "story_v_side_old_102604.awb") ~= 0 then
					local var_780_5 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604190", "story_v_side_old_102604.awb") / 1000

					if var_780_5 + 0 > arg_777_1.duration_ then
						arg_777_1.duration_ = var_780_5 + 0
					end

					if var_780_1.prefab_name ~= "" and arg_777_1.actors_[var_780_1.prefab_name] ~= nil then
						local var_780_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_777_1.actors_[var_780_1.prefab_name].transform, "story_v_side_old_102604", "102604190", "story_v_side_old_102604.awb")

						arg_777_1:RecordAudio("102604190", var_780_6)
						arg_777_1:RecordAudio("102604190", var_780_6)
					else
						arg_777_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604190", "story_v_side_old_102604.awb")
					end

					arg_777_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604190", "story_v_side_old_102604.awb")
				end

				arg_777_1:RecordContent(arg_777_1.text_.text)
			end

			local var_780_7 = math.max(var_780_0, arg_777_1.talkMaxDuration)

			if 0 <= arg_777_1.time_ and arg_777_1.time_ < 0 + var_780_7 then
				arg_777_1.typewritter.percent = (arg_777_1.time_ - 0) / var_780_7

				arg_777_1.typewritter:SetDirty()
			end

			if arg_777_1.time_ >= 0 + var_780_7 and arg_777_1.time_ < 0 + var_780_7 + arg_780_0 then
				arg_777_1.typewritter.percent = 1

				arg_777_1.typewritter:SetDirty()
				arg_777_1:ShowNextGo(true)
			end
		end

		arg_777_1.nodeConfigList_ = {}

		arg_777_1:InitPlayNodeList()
	end,
	Play102604191 = function(arg_781_0, arg_781_1)
		arg_781_1.time_ = 0
		arg_781_1.frameCnt_ = 0
		arg_781_1.state_ = "playing"
		arg_781_1.curTalkId_ = 102604191
		arg_781_1.duration_ = 5

		SetActive(arg_781_1.tipsGo_, false)

		function arg_781_1.onSingleLineFinish_()
			arg_781_1.onSingleLineUpdate_ = nil
			arg_781_1.onSingleLineFinish_ = nil
			arg_781_1.state_ = "waiting"
		end

		function arg_781_1.playNext_(arg_783_0)
			if arg_783_0 == 1 then
				arg_781_0:Play102604192(arg_781_1)
			end
		end

		function arg_781_1.onSingleLineUpdate_(arg_784_0)
			local var_784_0 = 0.05

			if 0 < arg_781_1.time_ and arg_781_1.time_ <= 0 + arg_784_0 then
				arg_781_1.talkMaxDuration = 0
				arg_781_1.dialogCg_.alpha = 1

				arg_781_1.dialog_:SetActive(true)
				SetActive(arg_781_1.leftNameGo_, true)

				arg_781_1.leftNameTxt_.text = arg_781_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_781_1.leftNameTxt_.transform)

				arg_781_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_781_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_781_1:RecordName(arg_781_1.leftNameTxt_.text)
				SetActive(arg_781_1.iconTrs_.gameObject, true)
				arg_781_1.iconController_:SetSelectedState("hero")

				arg_781_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_781_1.callingController_:SetSelectedState("normal")

				arg_781_1.keyicon_.color = Color.New(1, 1, 1)
				arg_781_1.icon_.color = Color.New(1, 1, 1)

				local var_784_1 = arg_781_1:FormatText(arg_781_1:GetWordFromCfg(102604191).content)

				arg_781_1.text_.text = var_784_1

				LuaForUtil.ClearLinePrefixSymbol(arg_781_1.text_)

				local var_784_3 = 2 <= 0 and var_784_0 or var_784_0 * (utf8.len(var_784_1) / 2)

				if (2 <= 0 and var_784_0 or var_784_0 * (utf8.len(var_784_1) / 2)) > 0 and var_784_0 < var_784_3 then
					arg_781_1.talkMaxDuration = var_784_3

					if var_784_3 + 0 > arg_781_1.duration_ then
						arg_781_1.duration_ = var_784_3 + 0
					end
				end

				arg_781_1.text_.text = var_784_1
				arg_781_1.typewritter.percent = 0

				arg_781_1.typewritter:SetDirty()
				arg_781_1:ShowNextGo(false)
				arg_781_1:RecordContent(arg_781_1.text_.text)
			end

			local var_784_4 = math.max(var_784_0, arg_781_1.talkMaxDuration)

			if 0 <= arg_781_1.time_ and arg_781_1.time_ < 0 + var_784_4 then
				arg_781_1.typewritter.percent = (arg_781_1.time_ - 0) / var_784_4

				arg_781_1.typewritter:SetDirty()
			end

			if arg_781_1.time_ >= 0 + var_784_4 and arg_781_1.time_ < 0 + var_784_4 + arg_784_0 then
				arg_781_1.typewritter.percent = 1

				arg_781_1.typewritter:SetDirty()
				arg_781_1:ShowNextGo(true)
			end
		end

		arg_781_1.nodeConfigList_ = {}

		arg_781_1:InitPlayNodeList()
	end,
	Play102604192 = function(arg_785_0, arg_785_1)
		arg_785_1.time_ = 0
		arg_785_1.frameCnt_ = 0
		arg_785_1.state_ = "playing"
		arg_785_1.curTalkId_ = 102604192
		arg_785_1.duration_ = 5

		SetActive(arg_785_1.tipsGo_, false)

		function arg_785_1.onSingleLineFinish_()
			arg_785_1.onSingleLineUpdate_ = nil
			arg_785_1.onSingleLineFinish_ = nil
			arg_785_1.state_ = "waiting"
		end

		function arg_785_1.playNext_(arg_787_0)
			if arg_787_0 == 1 then
				arg_785_0:Play102604193(arg_785_1)
			end
		end

		function arg_785_1.onSingleLineUpdate_(arg_788_0)
			local var_788_0 = 0.125

			if 0 < arg_785_1.time_ and arg_785_1.time_ <= 0 + arg_788_0 then
				arg_785_1.talkMaxDuration = 0
				arg_785_1.dialogCg_.alpha = 1

				arg_785_1.dialog_:SetActive(true)
				SetActive(arg_785_1.leftNameGo_, false)

				arg_785_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_785_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_785_1:RecordName(arg_785_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_785_1.iconTrs_.gameObject, false)
				arg_785_1.callingController_:SetSelectedState("normal")

				local var_788_1 = arg_785_1:FormatText(arg_785_1:GetWordFromCfg(102604192).content)

				arg_785_1.text_.text = var_788_1

				LuaForUtil.ClearLinePrefixSymbol(arg_785_1.text_)

				local var_788_3 = 5 <= 0 and var_788_0 or var_788_0 * (utf8.len(var_788_1) / 5)

				if (5 <= 0 and var_788_0 or var_788_0 * (utf8.len(var_788_1) / 5)) > 0 and var_788_0 < var_788_3 then
					arg_785_1.talkMaxDuration = var_788_3

					if var_788_3 + 0 > arg_785_1.duration_ then
						arg_785_1.duration_ = var_788_3 + 0
					end
				end

				arg_785_1.text_.text = var_788_1
				arg_785_1.typewritter.percent = 0

				arg_785_1.typewritter:SetDirty()
				arg_785_1:ShowNextGo(false)
				arg_785_1:RecordContent(arg_785_1.text_.text)
			end

			local var_788_4 = math.max(var_788_0, arg_785_1.talkMaxDuration)

			if 0 <= arg_785_1.time_ and arg_785_1.time_ < 0 + var_788_4 then
				arg_785_1.typewritter.percent = (arg_785_1.time_ - 0) / var_788_4

				arg_785_1.typewritter:SetDirty()
			end

			if arg_785_1.time_ >= 0 + var_788_4 and arg_785_1.time_ < 0 + var_788_4 + arg_788_0 then
				arg_785_1.typewritter.percent = 1

				arg_785_1.typewritter:SetDirty()
				arg_785_1:ShowNextGo(true)
			end
		end

		arg_785_1.nodeConfigList_ = {}

		arg_785_1:InitPlayNodeList()
	end,
	Play102604193 = function(arg_789_0, arg_789_1)
		arg_789_1.time_ = 0
		arg_789_1.frameCnt_ = 0
		arg_789_1.state_ = "playing"
		arg_789_1.curTalkId_ = 102604193
		arg_789_1.duration_ = 5

		SetActive(arg_789_1.tipsGo_, false)

		function arg_789_1.onSingleLineFinish_()
			arg_789_1.onSingleLineUpdate_ = nil
			arg_789_1.onSingleLineFinish_ = nil
			arg_789_1.state_ = "waiting"
		end

		function arg_789_1.playNext_(arg_791_0)
			if arg_791_0 == 1 then
				arg_789_0:Play102604194(arg_789_1)
			end
		end

		function arg_789_1.onSingleLineUpdate_(arg_792_0)
			local var_792_0 = 0.85

			if 0 < arg_789_1.time_ and arg_789_1.time_ <= 0 + arg_792_0 then
				arg_789_1.talkMaxDuration = 0
				arg_789_1.dialogCg_.alpha = 1

				arg_789_1.dialog_:SetActive(true)
				SetActive(arg_789_1.leftNameGo_, false)

				arg_789_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_789_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_789_1:RecordName(arg_789_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_789_1.iconTrs_.gameObject, false)
				arg_789_1.callingController_:SetSelectedState("normal")

				local var_792_1 = arg_789_1:FormatText(arg_789_1:GetWordFromCfg(102604193).content)

				arg_789_1.text_.text = var_792_1

				LuaForUtil.ClearLinePrefixSymbol(arg_789_1.text_)

				local var_792_3 = 34 <= 0 and var_792_0 or var_792_0 * (utf8.len(var_792_1) / 34)

				if (34 <= 0 and var_792_0 or var_792_0 * (utf8.len(var_792_1) / 34)) > 0 and var_792_0 < var_792_3 then
					arg_789_1.talkMaxDuration = var_792_3

					if var_792_3 + 0 > arg_789_1.duration_ then
						arg_789_1.duration_ = var_792_3 + 0
					end
				end

				arg_789_1.text_.text = var_792_1
				arg_789_1.typewritter.percent = 0

				arg_789_1.typewritter:SetDirty()
				arg_789_1:ShowNextGo(false)
				arg_789_1:RecordContent(arg_789_1.text_.text)
			end

			local var_792_4 = math.max(var_792_0, arg_789_1.talkMaxDuration)

			if 0 <= arg_789_1.time_ and arg_789_1.time_ < 0 + var_792_4 then
				arg_789_1.typewritter.percent = (arg_789_1.time_ - 0) / var_792_4

				arg_789_1.typewritter:SetDirty()
			end

			if arg_789_1.time_ >= 0 + var_792_4 and arg_789_1.time_ < 0 + var_792_4 + arg_792_0 then
				arg_789_1.typewritter.percent = 1

				arg_789_1.typewritter:SetDirty()
				arg_789_1:ShowNextGo(true)
			end
		end

		arg_789_1.nodeConfigList_ = {}

		arg_789_1:InitPlayNodeList()
	end,
	Play102604194 = function(arg_793_0, arg_793_1)
		arg_793_1.time_ = 0
		arg_793_1.frameCnt_ = 0
		arg_793_1.state_ = "playing"
		arg_793_1.curTalkId_ = 102604194
		arg_793_1.duration_ = 5

		SetActive(arg_793_1.tipsGo_, false)

		function arg_793_1.onSingleLineFinish_()
			arg_793_1.onSingleLineUpdate_ = nil
			arg_793_1.onSingleLineFinish_ = nil
			arg_793_1.state_ = "waiting"
		end

		function arg_793_1.playNext_(arg_795_0)
			if arg_795_0 == 1 then
				arg_793_0:Play102604195(arg_793_1)
			end
		end

		function arg_793_1.onSingleLineUpdate_(arg_796_0)
			local var_796_0 = 0.375

			if 0 < arg_793_1.time_ and arg_793_1.time_ <= 0 + arg_796_0 then
				arg_793_1.talkMaxDuration = 0
				arg_793_1.dialogCg_.alpha = 1

				arg_793_1.dialog_:SetActive(true)
				SetActive(arg_793_1.leftNameGo_, true)

				arg_793_1.leftNameTxt_.text = arg_793_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_793_1.leftNameTxt_.transform)

				arg_793_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_793_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_793_1:RecordName(arg_793_1.leftNameTxt_.text)
				SetActive(arg_793_1.iconTrs_.gameObject, true)
				arg_793_1.iconController_:SetSelectedState("hero")

				arg_793_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_793_1.callingController_:SetSelectedState("normal")

				arg_793_1.keyicon_.color = Color.New(1, 1, 1)
				arg_793_1.icon_.color = Color.New(1, 1, 1)

				local var_796_1 = arg_793_1:FormatText(arg_793_1:GetWordFromCfg(102604194).content)

				arg_793_1.text_.text = var_796_1

				LuaForUtil.ClearLinePrefixSymbol(arg_793_1.text_)

				local var_796_3 = 15 <= 0 and var_796_0 or var_796_0 * (utf8.len(var_796_1) / 15)

				if (15 <= 0 and var_796_0 or var_796_0 * (utf8.len(var_796_1) / 15)) > 0 and var_796_0 < var_796_3 then
					arg_793_1.talkMaxDuration = var_796_3

					if var_796_3 + 0 > arg_793_1.duration_ then
						arg_793_1.duration_ = var_796_3 + 0
					end
				end

				arg_793_1.text_.text = var_796_1
				arg_793_1.typewritter.percent = 0

				arg_793_1.typewritter:SetDirty()
				arg_793_1:ShowNextGo(false)
				arg_793_1:RecordContent(arg_793_1.text_.text)
			end

			local var_796_4 = math.max(var_796_0, arg_793_1.talkMaxDuration)

			if 0 <= arg_793_1.time_ and arg_793_1.time_ < 0 + var_796_4 then
				arg_793_1.typewritter.percent = (arg_793_1.time_ - 0) / var_796_4

				arg_793_1.typewritter:SetDirty()
			end

			if arg_793_1.time_ >= 0 + var_796_4 and arg_793_1.time_ < 0 + var_796_4 + arg_796_0 then
				arg_793_1.typewritter.percent = 1

				arg_793_1.typewritter:SetDirty()
				arg_793_1:ShowNextGo(true)
			end
		end

		arg_793_1.nodeConfigList_ = {}

		arg_793_1:InitPlayNodeList()
	end,
	Play102604195 = function(arg_797_0, arg_797_1)
		arg_797_1.time_ = 0
		arg_797_1.frameCnt_ = 0
		arg_797_1.state_ = "playing"
		arg_797_1.curTalkId_ = 102604195
		arg_797_1.duration_ = 3.77

		local var_797_0 = {
			ja = 2.8,
			ko = 2.033,
			zh = 3.766,
			en = 3.733
		}
		local var_797_1 = manager.audio:GetLocalizationFlag()

		if var_797_0[var_797_1] ~= nil then
			arg_797_1.duration_ = var_797_0[var_797_1]
		end

		SetActive(arg_797_1.tipsGo_, false)

		function arg_797_1.onSingleLineFinish_()
			arg_797_1.onSingleLineUpdate_ = nil
			arg_797_1.onSingleLineFinish_ = nil
			arg_797_1.state_ = "waiting"
		end

		function arg_797_1.playNext_(arg_799_0)
			if arg_799_0 == 1 then
				arg_797_0:Play102604196(arg_797_1)
			end
		end

		function arg_797_1.onSingleLineUpdate_(arg_800_0)
			local var_800_0 = 0.3

			if 0 < arg_797_1.time_ and arg_797_1.time_ <= 0 + arg_800_0 then
				arg_797_1.talkMaxDuration = 0
				arg_797_1.dialogCg_.alpha = 1

				arg_797_1.dialog_:SetActive(true)
				SetActive(arg_797_1.leftNameGo_, true)

				arg_797_1.leftNameTxt_.text = arg_797_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_797_1.leftNameTxt_.transform)

				arg_797_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_797_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_797_1:RecordName(arg_797_1.leftNameTxt_.text)
				SetActive(arg_797_1.iconTrs_.gameObject, false)
				arg_797_1.callingController_:SetSelectedState("normal")

				local var_800_1 = arg_797_1:GetWordFromCfg(102604195)
				local var_800_2 = arg_797_1:FormatText(var_800_1.content)

				arg_797_1.text_.text = var_800_2

				LuaForUtil.ClearLinePrefixSymbol(arg_797_1.text_)

				local var_800_4 = 12 <= 0 and var_800_0 or var_800_0 * (utf8.len(var_800_2) / 12)

				if (12 <= 0 and var_800_0 or var_800_0 * (utf8.len(var_800_2) / 12)) > 0 and var_800_0 < var_800_4 then
					arg_797_1.talkMaxDuration = var_800_4

					if var_800_4 + 0 > arg_797_1.duration_ then
						arg_797_1.duration_ = var_800_4 + 0
					end
				end

				arg_797_1.text_.text = var_800_2
				arg_797_1.typewritter.percent = 0

				arg_797_1.typewritter:SetDirty()
				arg_797_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102604", "102604195", "story_v_side_old_102604.awb") ~= 0 then
					local var_800_5 = manager.audio:GetVoiceLength("story_v_side_old_102604", "102604195", "story_v_side_old_102604.awb") / 1000

					if var_800_5 + 0 > arg_797_1.duration_ then
						arg_797_1.duration_ = var_800_5 + 0
					end

					if var_800_1.prefab_name ~= "" and arg_797_1.actors_[var_800_1.prefab_name] ~= nil then
						local var_800_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_797_1.actors_[var_800_1.prefab_name].transform, "story_v_side_old_102604", "102604195", "story_v_side_old_102604.awb")

						arg_797_1:RecordAudio("102604195", var_800_6)
						arg_797_1:RecordAudio("102604195", var_800_6)
					else
						arg_797_1:AudioAction("play", "voice", "story_v_side_old_102604", "102604195", "story_v_side_old_102604.awb")
					end

					arg_797_1:RecordHistoryTalkVoice("story_v_side_old_102604", "102604195", "story_v_side_old_102604.awb")
				end

				arg_797_1:RecordContent(arg_797_1.text_.text)
			end

			local var_800_7 = math.max(var_800_0, arg_797_1.talkMaxDuration)

			if 0 <= arg_797_1.time_ and arg_797_1.time_ < 0 + var_800_7 then
				arg_797_1.typewritter.percent = (arg_797_1.time_ - 0) / var_800_7

				arg_797_1.typewritter:SetDirty()
			end

			if arg_797_1.time_ >= 0 + var_800_7 and arg_797_1.time_ < 0 + var_800_7 + arg_800_0 then
				arg_797_1.typewritter.percent = 1

				arg_797_1.typewritter:SetDirty()
				arg_797_1:ShowNextGo(true)
			end
		end

		arg_797_1.nodeConfigList_ = {}

		arg_797_1:InitPlayNodeList()
	end,
	Play102604196 = function(arg_801_0, arg_801_1)
		arg_801_1.time_ = 0
		arg_801_1.frameCnt_ = 0
		arg_801_1.state_ = "playing"
		arg_801_1.curTalkId_ = 102604196
		arg_801_1.duration_ = 5

		SetActive(arg_801_1.tipsGo_, false)

		function arg_801_1.onSingleLineFinish_()
			arg_801_1.onSingleLineUpdate_ = nil
			arg_801_1.onSingleLineFinish_ = nil
			arg_801_1.state_ = "waiting"
		end

		function arg_801_1.playNext_(arg_803_0)
			if arg_803_0 == 1 then
				arg_801_0:Play102604197(arg_801_1)
			end
		end

		function arg_801_1.onSingleLineUpdate_(arg_804_0)
			local var_804_0 = 0.075

			if 0 < arg_801_1.time_ and arg_801_1.time_ <= 0 + arg_804_0 then
				arg_801_1.talkMaxDuration = 0
				arg_801_1.dialogCg_.alpha = 1

				arg_801_1.dialog_:SetActive(true)
				SetActive(arg_801_1.leftNameGo_, true)

				arg_801_1.leftNameTxt_.text = arg_801_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_801_1.leftNameTxt_.transform)

				arg_801_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_801_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_801_1:RecordName(arg_801_1.leftNameTxt_.text)
				SetActive(arg_801_1.iconTrs_.gameObject, true)
				arg_801_1.iconController_:SetSelectedState("hero")

				arg_801_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_801_1.callingController_:SetSelectedState("normal")

				arg_801_1.keyicon_.color = Color.New(1, 1, 1)
				arg_801_1.icon_.color = Color.New(1, 1, 1)

				local var_804_1 = arg_801_1:FormatText(arg_801_1:GetWordFromCfg(102604196).content)

				arg_801_1.text_.text = var_804_1

				LuaForUtil.ClearLinePrefixSymbol(arg_801_1.text_)

				local var_804_3 = 3 <= 0 and var_804_0 or var_804_0 * (utf8.len(var_804_1) / 3)

				if (3 <= 0 and var_804_0 or var_804_0 * (utf8.len(var_804_1) / 3)) > 0 and var_804_0 < var_804_3 then
					arg_801_1.talkMaxDuration = var_804_3

					if var_804_3 + 0 > arg_801_1.duration_ then
						arg_801_1.duration_ = var_804_3 + 0
					end
				end

				arg_801_1.text_.text = var_804_1
				arg_801_1.typewritter.percent = 0

				arg_801_1.typewritter:SetDirty()
				arg_801_1:ShowNextGo(false)
				arg_801_1:RecordContent(arg_801_1.text_.text)
			end

			local var_804_4 = math.max(var_804_0, arg_801_1.talkMaxDuration)

			if 0 <= arg_801_1.time_ and arg_801_1.time_ < 0 + var_804_4 then
				arg_801_1.typewritter.percent = (arg_801_1.time_ - 0) / var_804_4

				arg_801_1.typewritter:SetDirty()
			end

			if arg_801_1.time_ >= 0 + var_804_4 and arg_801_1.time_ < 0 + var_804_4 + arg_804_0 then
				arg_801_1.typewritter.percent = 1

				arg_801_1.typewritter:SetDirty()
				arg_801_1:ShowNextGo(true)
			end
		end

		arg_801_1.nodeConfigList_ = {}

		arg_801_1:InitPlayNodeList()
	end,
	Play102604197 = function(arg_805_0, arg_805_1)
		arg_805_1.time_ = 0
		arg_805_1.frameCnt_ = 0
		arg_805_1.state_ = "playing"
		arg_805_1.curTalkId_ = 102604197
		arg_805_1.duration_ = 5

		SetActive(arg_805_1.tipsGo_, false)

		function arg_805_1.onSingleLineFinish_()
			arg_805_1.onSingleLineUpdate_ = nil
			arg_805_1.onSingleLineFinish_ = nil
			arg_805_1.state_ = "waiting"
		end

		function arg_805_1.playNext_(arg_807_0)
			if arg_807_0 == 1 then
				arg_805_0:Play102604198(arg_805_1)
			end
		end

		function arg_805_1.onSingleLineUpdate_(arg_808_0)
			if 0 < arg_805_1.time_ and arg_805_1.time_ <= 0 + arg_808_0 then
				arg_805_1:AudioAction("play", "effect", "se_story_side_1026", "se_story_1026_cat", "")
			end

			local var_808_1 = 0
			local var_808_2 = 0.075

			if 0 < arg_805_1.time_ and arg_805_1.time_ <= var_808_1 + arg_808_0 then
				arg_805_1.talkMaxDuration = 0
				arg_805_1.dialogCg_.alpha = 1

				arg_805_1.dialog_:SetActive(true)
				SetActive(arg_805_1.leftNameGo_, true)

				arg_805_1.leftNameTxt_.text = arg_805_1:FormatText(StoryNameCfg[198].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_805_1.leftNameTxt_.transform)

				arg_805_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_805_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_805_1:RecordName(arg_805_1.leftNameTxt_.text)
				SetActive(arg_805_1.iconTrs_.gameObject, true)
				arg_805_1.iconController_:SetSelectedState("hero")

				arg_805_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_cata")

				arg_805_1.callingController_:SetSelectedState("normal")

				arg_805_1.keyicon_.color = Color.New(1, 1, 1)
				arg_805_1.icon_.color = Color.New(1, 1, 1)

				local var_808_3 = arg_805_1:FormatText(arg_805_1:GetWordFromCfg(102604197).content)

				arg_805_1.text_.text = var_808_3

				LuaForUtil.ClearLinePrefixSymbol(arg_805_1.text_)

				local var_808_5 = 3 <= 0 and var_808_2 or var_808_2 * (utf8.len(var_808_3) / 3)

				if (3 <= 0 and var_808_2 or var_808_2 * (utf8.len(var_808_3) / 3)) > 0 and var_808_2 < var_808_5 then
					arg_805_1.talkMaxDuration = var_808_5

					if var_808_5 + var_808_1 > arg_805_1.duration_ then
						arg_805_1.duration_ = var_808_5 + var_808_1
					end
				end

				arg_805_1.text_.text = var_808_3
				arg_805_1.typewritter.percent = 0

				arg_805_1.typewritter:SetDirty()
				arg_805_1:ShowNextGo(false)
				arg_805_1:RecordContent(arg_805_1.text_.text)
			end

			local var_808_6 = math.max(var_808_2, arg_805_1.talkMaxDuration)

			if var_808_1 <= arg_805_1.time_ and arg_805_1.time_ < var_808_1 + var_808_6 then
				arg_805_1.typewritter.percent = (arg_805_1.time_ - var_808_1) / var_808_6

				arg_805_1.typewritter:SetDirty()
			end

			if arg_805_1.time_ >= var_808_1 + var_808_6 and arg_805_1.time_ < var_808_1 + var_808_6 + arg_808_0 then
				arg_805_1.typewritter.percent = 1

				arg_805_1.typewritter:SetDirty()
				arg_805_1:ShowNextGo(true)
			end
		end

		arg_805_1.nodeConfigList_ = {}

		arg_805_1:InitPlayNodeList()
	end,
	Play102604198 = function(arg_809_0, arg_809_1)
		arg_809_1.time_ = 0
		arg_809_1.frameCnt_ = 0
		arg_809_1.state_ = "playing"
		arg_809_1.curTalkId_ = 102604198
		arg_809_1.duration_ = 5

		SetActive(arg_809_1.tipsGo_, false)

		function arg_809_1.onSingleLineFinish_()
			arg_809_1.onSingleLineUpdate_ = nil
			arg_809_1.onSingleLineFinish_ = nil
			arg_809_1.state_ = "waiting"
		end

		function arg_809_1.playNext_(arg_811_0)
			if arg_811_0 == 1 then
				arg_809_0:Play102604199(arg_809_1)
			end
		end

		function arg_809_1.onSingleLineUpdate_(arg_812_0)
			local var_812_0 = 0.425

			if 0 < arg_809_1.time_ and arg_809_1.time_ <= 0 + arg_812_0 then
				arg_809_1.talkMaxDuration = 0
				arg_809_1.dialogCg_.alpha = 1

				arg_809_1.dialog_:SetActive(true)
				SetActive(arg_809_1.leftNameGo_, false)

				arg_809_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_809_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_809_1:RecordName(arg_809_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_809_1.iconTrs_.gameObject, false)
				arg_809_1.callingController_:SetSelectedState("normal")

				local var_812_1 = arg_809_1:FormatText(arg_809_1:GetWordFromCfg(102604198).content)

				arg_809_1.text_.text = var_812_1

				LuaForUtil.ClearLinePrefixSymbol(arg_809_1.text_)

				local var_812_3 = 17 <= 0 and var_812_0 or var_812_0 * (utf8.len(var_812_1) / 17)

				if (17 <= 0 and var_812_0 or var_812_0 * (utf8.len(var_812_1) / 17)) > 0 and var_812_0 < var_812_3 then
					arg_809_1.talkMaxDuration = var_812_3

					if var_812_3 + 0 > arg_809_1.duration_ then
						arg_809_1.duration_ = var_812_3 + 0
					end
				end

				arg_809_1.text_.text = var_812_1
				arg_809_1.typewritter.percent = 0

				arg_809_1.typewritter:SetDirty()
				arg_809_1:ShowNextGo(false)
				arg_809_1:RecordContent(arg_809_1.text_.text)
			end

			local var_812_4 = math.max(var_812_0, arg_809_1.talkMaxDuration)

			if 0 <= arg_809_1.time_ and arg_809_1.time_ < 0 + var_812_4 then
				arg_809_1.typewritter.percent = (arg_809_1.time_ - 0) / var_812_4

				arg_809_1.typewritter:SetDirty()
			end

			if arg_809_1.time_ >= 0 + var_812_4 and arg_809_1.time_ < 0 + var_812_4 + arg_812_0 then
				arg_809_1.typewritter.percent = 1

				arg_809_1.typewritter:SetDirty()
				arg_809_1:ShowNextGo(true)
			end
		end

		arg_809_1.nodeConfigList_ = {}

		arg_809_1:InitPlayNodeList()
	end,
	Play102604199 = function(arg_813_0, arg_813_1)
		arg_813_1.time_ = 0
		arg_813_1.frameCnt_ = 0
		arg_813_1.state_ = "playing"
		arg_813_1.curTalkId_ = 102604199
		arg_813_1.duration_ = 5

		SetActive(arg_813_1.tipsGo_, false)

		function arg_813_1.onSingleLineFinish_()
			arg_813_1.onSingleLineUpdate_ = nil
			arg_813_1.onSingleLineFinish_ = nil
			arg_813_1.state_ = "waiting"
		end

		function arg_813_1.playNext_(arg_815_0)
			if arg_815_0 == 1 then
				arg_813_0:Play102604200(arg_813_1)
			end
		end

		function arg_813_1.onSingleLineUpdate_(arg_816_0)
			local var_816_0 = 0.425

			if 0 < arg_813_1.time_ and arg_813_1.time_ <= 0 + arg_816_0 then
				arg_813_1.talkMaxDuration = 0
				arg_813_1.dialogCg_.alpha = 1

				arg_813_1.dialog_:SetActive(true)
				SetActive(arg_813_1.leftNameGo_, false)

				arg_813_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_813_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_813_1:RecordName(arg_813_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_813_1.iconTrs_.gameObject, false)
				arg_813_1.callingController_:SetSelectedState("normal")

				local var_816_1 = arg_813_1:FormatText(arg_813_1:GetWordFromCfg(102604199).content)

				arg_813_1.text_.text = var_816_1

				LuaForUtil.ClearLinePrefixSymbol(arg_813_1.text_)

				local var_816_3 = 17 <= 0 and var_816_0 or var_816_0 * (utf8.len(var_816_1) / 17)

				if (17 <= 0 and var_816_0 or var_816_0 * (utf8.len(var_816_1) / 17)) > 0 and var_816_0 < var_816_3 then
					arg_813_1.talkMaxDuration = var_816_3

					if var_816_3 + 0 > arg_813_1.duration_ then
						arg_813_1.duration_ = var_816_3 + 0
					end
				end

				arg_813_1.text_.text = var_816_1
				arg_813_1.typewritter.percent = 0

				arg_813_1.typewritter:SetDirty()
				arg_813_1:ShowNextGo(false)
				arg_813_1:RecordContent(arg_813_1.text_.text)
			end

			local var_816_4 = math.max(var_816_0, arg_813_1.talkMaxDuration)

			if 0 <= arg_813_1.time_ and arg_813_1.time_ < 0 + var_816_4 then
				arg_813_1.typewritter.percent = (arg_813_1.time_ - 0) / var_816_4

				arg_813_1.typewritter:SetDirty()
			end

			if arg_813_1.time_ >= 0 + var_816_4 and arg_813_1.time_ < 0 + var_816_4 + arg_816_0 then
				arg_813_1.typewritter.percent = 1

				arg_813_1.typewritter:SetDirty()
				arg_813_1:ShowNextGo(true)
			end
		end

		arg_813_1.nodeConfigList_ = {}

		arg_813_1:InitPlayNodeList()
	end,
	Play102604200 = function(arg_817_0, arg_817_1)
		arg_817_1.time_ = 0
		arg_817_1.frameCnt_ = 0
		arg_817_1.state_ = "playing"
		arg_817_1.curTalkId_ = 102604200
		arg_817_1.duration_ = 5

		SetActive(arg_817_1.tipsGo_, false)

		function arg_817_1.onSingleLineFinish_()
			arg_817_1.onSingleLineUpdate_ = nil
			arg_817_1.onSingleLineFinish_ = nil
			arg_817_1.state_ = "waiting"
		end

		function arg_817_1.playNext_(arg_819_0)
			if arg_819_0 == 1 then
				arg_817_0:Play102604201(arg_817_1)
			end
		end

		function arg_817_1.onSingleLineUpdate_(arg_820_0)
			local var_820_0 = 0.9

			if 0 < arg_817_1.time_ and arg_817_1.time_ <= 0 + arg_820_0 then
				arg_817_1.talkMaxDuration = 0
				arg_817_1.dialogCg_.alpha = 1

				arg_817_1.dialog_:SetActive(true)
				SetActive(arg_817_1.leftNameGo_, false)

				arg_817_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_817_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_817_1:RecordName(arg_817_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_817_1.iconTrs_.gameObject, false)
				arg_817_1.callingController_:SetSelectedState("normal")

				local var_820_1 = arg_817_1:FormatText(arg_817_1:GetWordFromCfg(102604200).content)

				arg_817_1.text_.text = var_820_1

				LuaForUtil.ClearLinePrefixSymbol(arg_817_1.text_)

				local var_820_3 = 36 <= 0 and var_820_0 or var_820_0 * (utf8.len(var_820_1) / 36)

				if (36 <= 0 and var_820_0 or var_820_0 * (utf8.len(var_820_1) / 36)) > 0 and var_820_0 < var_820_3 then
					arg_817_1.talkMaxDuration = var_820_3

					if var_820_3 + 0 > arg_817_1.duration_ then
						arg_817_1.duration_ = var_820_3 + 0
					end
				end

				arg_817_1.text_.text = var_820_1
				arg_817_1.typewritter.percent = 0

				arg_817_1.typewritter:SetDirty()
				arg_817_1:ShowNextGo(false)
				arg_817_1:RecordContent(arg_817_1.text_.text)
			end

			local var_820_4 = math.max(var_820_0, arg_817_1.talkMaxDuration)

			if 0 <= arg_817_1.time_ and arg_817_1.time_ < 0 + var_820_4 then
				arg_817_1.typewritter.percent = (arg_817_1.time_ - 0) / var_820_4

				arg_817_1.typewritter:SetDirty()
			end

			if arg_817_1.time_ >= 0 + var_820_4 and arg_817_1.time_ < 0 + var_820_4 + arg_820_0 then
				arg_817_1.typewritter.percent = 1

				arg_817_1.typewritter:SetDirty()
				arg_817_1:ShowNextGo(true)
			end
		end

		arg_817_1.nodeConfigList_ = {}

		arg_817_1:InitPlayNodeList()
	end,
	Play102604201 = function(arg_821_0, arg_821_1)
		arg_821_1.time_ = 0
		arg_821_1.frameCnt_ = 0
		arg_821_1.state_ = "playing"
		arg_821_1.curTalkId_ = 102604201
		arg_821_1.duration_ = 5

		SetActive(arg_821_1.tipsGo_, false)

		function arg_821_1.onSingleLineFinish_()
			arg_821_1.onSingleLineUpdate_ = nil
			arg_821_1.onSingleLineFinish_ = nil
			arg_821_1.state_ = "waiting"
		end

		function arg_821_1.playNext_(arg_823_0)
			if arg_823_0 == 1 then
				arg_821_0:Play102604202(arg_821_1)
			end
		end

		function arg_821_1.onSingleLineUpdate_(arg_824_0)
			local var_824_0 = 0.225

			if 0 < arg_821_1.time_ and arg_821_1.time_ <= 0 + arg_824_0 then
				arg_821_1.talkMaxDuration = 0
				arg_821_1.dialogCg_.alpha = 1

				arg_821_1.dialog_:SetActive(true)
				SetActive(arg_821_1.leftNameGo_, false)

				arg_821_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_821_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_821_1:RecordName(arg_821_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_821_1.iconTrs_.gameObject, false)
				arg_821_1.callingController_:SetSelectedState("normal")

				local var_824_1 = arg_821_1:FormatText(arg_821_1:GetWordFromCfg(102604201).content)

				arg_821_1.text_.text = var_824_1

				LuaForUtil.ClearLinePrefixSymbol(arg_821_1.text_)

				local var_824_3 = 9 <= 0 and var_824_0 or var_824_0 * (utf8.len(var_824_1) / 9)

				if (9 <= 0 and var_824_0 or var_824_0 * (utf8.len(var_824_1) / 9)) > 0 and var_824_0 < var_824_3 then
					arg_821_1.talkMaxDuration = var_824_3

					if var_824_3 + 0 > arg_821_1.duration_ then
						arg_821_1.duration_ = var_824_3 + 0
					end
				end

				arg_821_1.text_.text = var_824_1
				arg_821_1.typewritter.percent = 0

				arg_821_1.typewritter:SetDirty()
				arg_821_1:ShowNextGo(false)
				arg_821_1:RecordContent(arg_821_1.text_.text)
			end

			local var_824_4 = math.max(var_824_0, arg_821_1.talkMaxDuration)

			if 0 <= arg_821_1.time_ and arg_821_1.time_ < 0 + var_824_4 then
				arg_821_1.typewritter.percent = (arg_821_1.time_ - 0) / var_824_4

				arg_821_1.typewritter:SetDirty()
			end

			if arg_821_1.time_ >= 0 + var_824_4 and arg_821_1.time_ < 0 + var_824_4 + arg_824_0 then
				arg_821_1.typewritter.percent = 1

				arg_821_1.typewritter:SetDirty()
				arg_821_1:ShowNextGo(true)
			end
		end

		arg_821_1.nodeConfigList_ = {}

		arg_821_1:InitPlayNodeList()
	end,
	Play102604202 = function(arg_825_0, arg_825_1)
		arg_825_1.time_ = 0
		arg_825_1.frameCnt_ = 0
		arg_825_1.state_ = "playing"
		arg_825_1.curTalkId_ = 102604202
		arg_825_1.duration_ = 5

		SetActive(arg_825_1.tipsGo_, false)

		function arg_825_1.onSingleLineFinish_()
			arg_825_1.onSingleLineUpdate_ = nil
			arg_825_1.onSingleLineFinish_ = nil
			arg_825_1.state_ = "waiting"
		end

		function arg_825_1.playNext_(arg_827_0)
			if arg_827_0 == 1 then
				arg_825_0:Play102604203(arg_825_1)
			end
		end

		function arg_825_1.onSingleLineUpdate_(arg_828_0)
			local var_828_0 = 0.975

			if 0 < arg_825_1.time_ and arg_825_1.time_ <= 0 + arg_828_0 then
				arg_825_1.talkMaxDuration = 0
				arg_825_1.dialogCg_.alpha = 1

				arg_825_1.dialog_:SetActive(true)
				SetActive(arg_825_1.leftNameGo_, false)

				arg_825_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_825_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_825_1:RecordName(arg_825_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_825_1.iconTrs_.gameObject, false)
				arg_825_1.callingController_:SetSelectedState("normal")

				local var_828_1 = arg_825_1:FormatText(arg_825_1:GetWordFromCfg(102604202).content)

				arg_825_1.text_.text = var_828_1

				LuaForUtil.ClearLinePrefixSymbol(arg_825_1.text_)

				local var_828_3 = 39 <= 0 and var_828_0 or var_828_0 * (utf8.len(var_828_1) / 39)

				if (39 <= 0 and var_828_0 or var_828_0 * (utf8.len(var_828_1) / 39)) > 0 and var_828_0 < var_828_3 then
					arg_825_1.talkMaxDuration = var_828_3

					if var_828_3 + 0 > arg_825_1.duration_ then
						arg_825_1.duration_ = var_828_3 + 0
					end
				end

				arg_825_1.text_.text = var_828_1
				arg_825_1.typewritter.percent = 0

				arg_825_1.typewritter:SetDirty()
				arg_825_1:ShowNextGo(false)
				arg_825_1:RecordContent(arg_825_1.text_.text)
			end

			local var_828_4 = math.max(var_828_0, arg_825_1.talkMaxDuration)

			if 0 <= arg_825_1.time_ and arg_825_1.time_ < 0 + var_828_4 then
				arg_825_1.typewritter.percent = (arg_825_1.time_ - 0) / var_828_4

				arg_825_1.typewritter:SetDirty()
			end

			if arg_825_1.time_ >= 0 + var_828_4 and arg_825_1.time_ < 0 + var_828_4 + arg_828_0 then
				arg_825_1.typewritter.percent = 1

				arg_825_1.typewritter:SetDirty()
				arg_825_1:ShowNextGo(true)
			end
		end

		arg_825_1.nodeConfigList_ = {}

		arg_825_1:InitPlayNodeList()
	end,
	Play102604203 = function(arg_829_0, arg_829_1)
		arg_829_1.time_ = 0
		arg_829_1.frameCnt_ = 0
		arg_829_1.state_ = "playing"
		arg_829_1.curTalkId_ = 102604203
		arg_829_1.duration_ = 5

		SetActive(arg_829_1.tipsGo_, false)

		function arg_829_1.onSingleLineFinish_()
			arg_829_1.onSingleLineUpdate_ = nil
			arg_829_1.onSingleLineFinish_ = nil
			arg_829_1.state_ = "waiting"
		end

		function arg_829_1.playNext_(arg_831_0)
			if arg_831_0 == 1 then
				arg_829_0:Play102604204(arg_829_1)
			end
		end

		function arg_829_1.onSingleLineUpdate_(arg_832_0)
			local var_832_0 = 1.225

			if 0 < arg_829_1.time_ and arg_829_1.time_ <= 0 + arg_832_0 then
				arg_829_1.talkMaxDuration = 0
				arg_829_1.dialogCg_.alpha = 1

				arg_829_1.dialog_:SetActive(true)
				SetActive(arg_829_1.leftNameGo_, false)

				arg_829_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_829_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_829_1:RecordName(arg_829_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_829_1.iconTrs_.gameObject, false)
				arg_829_1.callingController_:SetSelectedState("normal")

				local var_832_1 = arg_829_1:FormatText(arg_829_1:GetWordFromCfg(102604203).content)

				arg_829_1.text_.text = var_832_1

				LuaForUtil.ClearLinePrefixSymbol(arg_829_1.text_)

				local var_832_3 = 49 <= 0 and var_832_0 or var_832_0 * (utf8.len(var_832_1) / 49)

				if (49 <= 0 and var_832_0 or var_832_0 * (utf8.len(var_832_1) / 49)) > 0 and var_832_0 < var_832_3 then
					arg_829_1.talkMaxDuration = var_832_3

					if var_832_3 + 0 > arg_829_1.duration_ then
						arg_829_1.duration_ = var_832_3 + 0
					end
				end

				arg_829_1.text_.text = var_832_1
				arg_829_1.typewritter.percent = 0

				arg_829_1.typewritter:SetDirty()
				arg_829_1:ShowNextGo(false)
				arg_829_1:RecordContent(arg_829_1.text_.text)
			end

			local var_832_4 = math.max(var_832_0, arg_829_1.talkMaxDuration)

			if 0 <= arg_829_1.time_ and arg_829_1.time_ < 0 + var_832_4 then
				arg_829_1.typewritter.percent = (arg_829_1.time_ - 0) / var_832_4

				arg_829_1.typewritter:SetDirty()
			end

			if arg_829_1.time_ >= 0 + var_832_4 and arg_829_1.time_ < 0 + var_832_4 + arg_832_0 then
				arg_829_1.typewritter.percent = 1

				arg_829_1.typewritter:SetDirty()
				arg_829_1:ShowNextGo(true)
			end
		end

		arg_829_1.nodeConfigList_ = {}

		arg_829_1:InitPlayNodeList()
	end,
	Play102604204 = function(arg_833_0, arg_833_1)
		arg_833_1.time_ = 0
		arg_833_1.frameCnt_ = 0
		arg_833_1.state_ = "playing"
		arg_833_1.curTalkId_ = 102604204
		arg_833_1.duration_ = 5

		SetActive(arg_833_1.tipsGo_, false)

		function arg_833_1.onSingleLineFinish_()
			arg_833_1.onSingleLineUpdate_ = nil
			arg_833_1.onSingleLineFinish_ = nil
			arg_833_1.state_ = "waiting"
		end

		function arg_833_1.playNext_(arg_835_0)
			if arg_835_0 == 1 then
				arg_833_0:Play102604205(arg_833_1)
			end
		end

		function arg_833_1.onSingleLineUpdate_(arg_836_0)
			local var_836_0 = 0.225

			if 0 < arg_833_1.time_ and arg_833_1.time_ <= 0 + arg_836_0 then
				arg_833_1.talkMaxDuration = 0
				arg_833_1.dialogCg_.alpha = 1

				arg_833_1.dialog_:SetActive(true)
				SetActive(arg_833_1.leftNameGo_, true)

				arg_833_1.leftNameTxt_.text = arg_833_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_833_1.leftNameTxt_.transform)

				arg_833_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_833_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_833_1:RecordName(arg_833_1.leftNameTxt_.text)
				SetActive(arg_833_1.iconTrs_.gameObject, true)
				arg_833_1.iconController_:SetSelectedState("hero")

				arg_833_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_833_1.callingController_:SetSelectedState("normal")

				arg_833_1.keyicon_.color = Color.New(1, 1, 1)
				arg_833_1.icon_.color = Color.New(1, 1, 1)

				local var_836_1 = arg_833_1:FormatText(arg_833_1:GetWordFromCfg(102604204).content)

				arg_833_1.text_.text = var_836_1

				LuaForUtil.ClearLinePrefixSymbol(arg_833_1.text_)

				local var_836_3 = 9 <= 0 and var_836_0 or var_836_0 * (utf8.len(var_836_1) / 9)

				if (9 <= 0 and var_836_0 or var_836_0 * (utf8.len(var_836_1) / 9)) > 0 and var_836_0 < var_836_3 then
					arg_833_1.talkMaxDuration = var_836_3

					if var_836_3 + 0 > arg_833_1.duration_ then
						arg_833_1.duration_ = var_836_3 + 0
					end
				end

				arg_833_1.text_.text = var_836_1
				arg_833_1.typewritter.percent = 0

				arg_833_1.typewritter:SetDirty()
				arg_833_1:ShowNextGo(false)
				arg_833_1:RecordContent(arg_833_1.text_.text)
			end

			local var_836_4 = math.max(var_836_0, arg_833_1.talkMaxDuration)

			if 0 <= arg_833_1.time_ and arg_833_1.time_ < 0 + var_836_4 then
				arg_833_1.typewritter.percent = (arg_833_1.time_ - 0) / var_836_4

				arg_833_1.typewritter:SetDirty()
			end

			if arg_833_1.time_ >= 0 + var_836_4 and arg_833_1.time_ < 0 + var_836_4 + arg_836_0 then
				arg_833_1.typewritter.percent = 1

				arg_833_1.typewritter:SetDirty()
				arg_833_1:ShowNextGo(true)
			end
		end

		arg_833_1.nodeConfigList_ = {}

		arg_833_1:InitPlayNodeList()
	end,
	Play102604205 = function(arg_837_0, arg_837_1)
		arg_837_1.time_ = 0
		arg_837_1.frameCnt_ = 0
		arg_837_1.state_ = "playing"
		arg_837_1.curTalkId_ = 102604205
		arg_837_1.duration_ = 5

		SetActive(arg_837_1.tipsGo_, false)

		function arg_837_1.onSingleLineFinish_()
			arg_837_1.onSingleLineUpdate_ = nil
			arg_837_1.onSingleLineFinish_ = nil
			arg_837_1.state_ = "waiting"
		end

		function arg_837_1.playNext_(arg_839_0)
			if arg_839_0 == 1 then
				arg_837_0:Play102604206(arg_837_1)
			end
		end

		function arg_837_1.onSingleLineUpdate_(arg_840_0)
			local var_840_0 = 0.65

			if 0 < arg_837_1.time_ and arg_837_1.time_ <= 0 + arg_840_0 then
				arg_837_1.talkMaxDuration = 0
				arg_837_1.dialogCg_.alpha = 1

				arg_837_1.dialog_:SetActive(true)
				SetActive(arg_837_1.leftNameGo_, true)

				arg_837_1.leftNameTxt_.text = arg_837_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_837_1.leftNameTxt_.transform)

				arg_837_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_837_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_837_1:RecordName(arg_837_1.leftNameTxt_.text)
				SetActive(arg_837_1.iconTrs_.gameObject, true)
				arg_837_1.iconController_:SetSelectedState("hero")

				arg_837_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_837_1.callingController_:SetSelectedState("normal")

				arg_837_1.keyicon_.color = Color.New(1, 1, 1)
				arg_837_1.icon_.color = Color.New(1, 1, 1)

				local var_840_1 = arg_837_1:FormatText(arg_837_1:GetWordFromCfg(102604205).content)

				arg_837_1.text_.text = var_840_1

				LuaForUtil.ClearLinePrefixSymbol(arg_837_1.text_)

				local var_840_3 = 26 <= 0 and var_840_0 or var_840_0 * (utf8.len(var_840_1) / 26)

				if (26 <= 0 and var_840_0 or var_840_0 * (utf8.len(var_840_1) / 26)) > 0 and var_840_0 < var_840_3 then
					arg_837_1.talkMaxDuration = var_840_3

					if var_840_3 + 0 > arg_837_1.duration_ then
						arg_837_1.duration_ = var_840_3 + 0
					end
				end

				arg_837_1.text_.text = var_840_1
				arg_837_1.typewritter.percent = 0

				arg_837_1.typewritter:SetDirty()
				arg_837_1:ShowNextGo(false)
				arg_837_1:RecordContent(arg_837_1.text_.text)
			end

			local var_840_4 = math.max(var_840_0, arg_837_1.talkMaxDuration)

			if 0 <= arg_837_1.time_ and arg_837_1.time_ < 0 + var_840_4 then
				arg_837_1.typewritter.percent = (arg_837_1.time_ - 0) / var_840_4

				arg_837_1.typewritter:SetDirty()
			end

			if arg_837_1.time_ >= 0 + var_840_4 and arg_837_1.time_ < 0 + var_840_4 + arg_840_0 then
				arg_837_1.typewritter.percent = 1

				arg_837_1.typewritter:SetDirty()
				arg_837_1:ShowNextGo(true)
			end
		end

		arg_837_1.nodeConfigList_ = {}

		arg_837_1:InitPlayNodeList()
	end,
	Play102604206 = function(arg_841_0, arg_841_1)
		arg_841_1.time_ = 0
		arg_841_1.frameCnt_ = 0
		arg_841_1.state_ = "playing"
		arg_841_1.curTalkId_ = 102604206
		arg_841_1.duration_ = 5

		SetActive(arg_841_1.tipsGo_, false)

		function arg_841_1.onSingleLineFinish_()
			arg_841_1.onSingleLineUpdate_ = nil
			arg_841_1.onSingleLineFinish_ = nil
			arg_841_1.state_ = "waiting"
		end

		function arg_841_1.playNext_(arg_843_0)
			if arg_843_0 == 1 then
				arg_841_0:Play102604207(arg_841_1)
			end
		end

		function arg_841_1.onSingleLineUpdate_(arg_844_0)
			local var_844_0 = 1.025

			if 0 < arg_841_1.time_ and arg_841_1.time_ <= 0 + arg_844_0 then
				arg_841_1.talkMaxDuration = 0
				arg_841_1.dialogCg_.alpha = 1

				arg_841_1.dialog_:SetActive(true)
				SetActive(arg_841_1.leftNameGo_, false)

				arg_841_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_841_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_841_1:RecordName(arg_841_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_841_1.iconTrs_.gameObject, false)
				arg_841_1.callingController_:SetSelectedState("normal")

				local var_844_1 = arg_841_1:FormatText(arg_841_1:GetWordFromCfg(102604206).content)

				arg_841_1.text_.text = var_844_1

				LuaForUtil.ClearLinePrefixSymbol(arg_841_1.text_)

				local var_844_3 = 41 <= 0 and var_844_0 or var_844_0 * (utf8.len(var_844_1) / 41)

				if (41 <= 0 and var_844_0 or var_844_0 * (utf8.len(var_844_1) / 41)) > 0 and var_844_0 < var_844_3 then
					arg_841_1.talkMaxDuration = var_844_3

					if var_844_3 + 0 > arg_841_1.duration_ then
						arg_841_1.duration_ = var_844_3 + 0
					end
				end

				arg_841_1.text_.text = var_844_1
				arg_841_1.typewritter.percent = 0

				arg_841_1.typewritter:SetDirty()
				arg_841_1:ShowNextGo(false)
				arg_841_1:RecordContent(arg_841_1.text_.text)
			end

			local var_844_4 = math.max(var_844_0, arg_841_1.talkMaxDuration)

			if 0 <= arg_841_1.time_ and arg_841_1.time_ < 0 + var_844_4 then
				arg_841_1.typewritter.percent = (arg_841_1.time_ - 0) / var_844_4

				arg_841_1.typewritter:SetDirty()
			end

			if arg_841_1.time_ >= 0 + var_844_4 and arg_841_1.time_ < 0 + var_844_4 + arg_844_0 then
				arg_841_1.typewritter.percent = 1

				arg_841_1.typewritter:SetDirty()
				arg_841_1:ShowNextGo(true)
			end
		end

		arg_841_1.nodeConfigList_ = {}

		arg_841_1:InitPlayNodeList()
	end,
	Play102604207 = function(arg_845_0, arg_845_1)
		arg_845_1.time_ = 0
		arg_845_1.frameCnt_ = 0
		arg_845_1.state_ = "playing"
		arg_845_1.curTalkId_ = 102604207
		arg_845_1.duration_ = 5

		SetActive(arg_845_1.tipsGo_, false)

		function arg_845_1.onSingleLineFinish_()
			arg_845_1.onSingleLineUpdate_ = nil
			arg_845_1.onSingleLineFinish_ = nil
			arg_845_1.state_ = "waiting"
		end

		function arg_845_1.playNext_(arg_847_0)
			if arg_847_0 == 1 then
				arg_845_0:Play102604208(arg_845_1)
			end
		end

		function arg_845_1.onSingleLineUpdate_(arg_848_0)
			local var_848_0 = 0.5

			if 0 < arg_845_1.time_ and arg_845_1.time_ <= 0 + arg_848_0 then
				arg_845_1.talkMaxDuration = 0
				arg_845_1.dialogCg_.alpha = 1

				arg_845_1.dialog_:SetActive(true)
				SetActive(arg_845_1.leftNameGo_, false)

				arg_845_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_845_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_845_1:RecordName(arg_845_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_845_1.iconTrs_.gameObject, false)
				arg_845_1.callingController_:SetSelectedState("normal")

				local var_848_1 = arg_845_1:FormatText(arg_845_1:GetWordFromCfg(102604207).content)

				arg_845_1.text_.text = var_848_1

				LuaForUtil.ClearLinePrefixSymbol(arg_845_1.text_)

				local var_848_3 = 20 <= 0 and var_848_0 or var_848_0 * (utf8.len(var_848_1) / 20)

				if (20 <= 0 and var_848_0 or var_848_0 * (utf8.len(var_848_1) / 20)) > 0 and var_848_0 < var_848_3 then
					arg_845_1.talkMaxDuration = var_848_3

					if var_848_3 + 0 > arg_845_1.duration_ then
						arg_845_1.duration_ = var_848_3 + 0
					end
				end

				arg_845_1.text_.text = var_848_1
				arg_845_1.typewritter.percent = 0

				arg_845_1.typewritter:SetDirty()
				arg_845_1:ShowNextGo(false)
				arg_845_1:RecordContent(arg_845_1.text_.text)
			end

			local var_848_4 = math.max(var_848_0, arg_845_1.talkMaxDuration)

			if 0 <= arg_845_1.time_ and arg_845_1.time_ < 0 + var_848_4 then
				arg_845_1.typewritter.percent = (arg_845_1.time_ - 0) / var_848_4

				arg_845_1.typewritter:SetDirty()
			end

			if arg_845_1.time_ >= 0 + var_848_4 and arg_845_1.time_ < 0 + var_848_4 + arg_848_0 then
				arg_845_1.typewritter.percent = 1

				arg_845_1.typewritter:SetDirty()
				arg_845_1:ShowNextGo(true)
			end
		end

		arg_845_1.nodeConfigList_ = {}

		arg_845_1:InitPlayNodeList()
	end,
	Play102604208 = function(arg_849_0, arg_849_1)
		arg_849_1.time_ = 0
		arg_849_1.frameCnt_ = 0
		arg_849_1.state_ = "playing"
		arg_849_1.curTalkId_ = 102604208
		arg_849_1.duration_ = 5

		SetActive(arg_849_1.tipsGo_, false)

		function arg_849_1.onSingleLineFinish_()
			arg_849_1.onSingleLineUpdate_ = nil
			arg_849_1.onSingleLineFinish_ = nil
			arg_849_1.state_ = "waiting"
			arg_849_1.auto_ = false
		end

		function arg_849_1.playNext_(arg_851_0)
			arg_849_1.onStoryFinished_()
		end

		function arg_849_1.onSingleLineUpdate_(arg_852_0)
			local var_852_0 = 0.525

			if 0 < arg_849_1.time_ and arg_849_1.time_ <= 0 + arg_852_0 then
				arg_849_1.talkMaxDuration = 0
				arg_849_1.dialogCg_.alpha = 1

				arg_849_1.dialog_:SetActive(true)
				SetActive(arg_849_1.leftNameGo_, false)

				arg_849_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_849_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_849_1:RecordName(arg_849_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_849_1.iconTrs_.gameObject, false)
				arg_849_1.callingController_:SetSelectedState("normal")

				local var_852_1 = arg_849_1:FormatText(arg_849_1:GetWordFromCfg(102604208).content)

				arg_849_1.text_.text = var_852_1

				LuaForUtil.ClearLinePrefixSymbol(arg_849_1.text_)

				local var_852_3 = 21 <= 0 and var_852_0 or var_852_0 * (utf8.len(var_852_1) / 21)

				if (21 <= 0 and var_852_0 or var_852_0 * (utf8.len(var_852_1) / 21)) > 0 and var_852_0 < var_852_3 then
					arg_849_1.talkMaxDuration = var_852_3

					if var_852_3 + 0 > arg_849_1.duration_ then
						arg_849_1.duration_ = var_852_3 + 0
					end
				end

				arg_849_1.text_.text = var_852_1
				arg_849_1.typewritter.percent = 0

				arg_849_1.typewritter:SetDirty()
				arg_849_1:ShowNextGo(false)
				arg_849_1:RecordContent(arg_849_1.text_.text)
			end

			local var_852_4 = math.max(var_852_0, arg_849_1.talkMaxDuration)

			if 0 <= arg_849_1.time_ and arg_849_1.time_ < 0 + var_852_4 then
				arg_849_1.typewritter.percent = (arg_849_1.time_ - 0) / var_852_4

				arg_849_1.typewritter:SetDirty()
			end

			if arg_849_1.time_ >= 0 + var_852_4 and arg_849_1.time_ < 0 + var_852_4 + arg_852_0 then
				arg_849_1.typewritter.percent = 1

				arg_849_1.typewritter:SetDirty()
				arg_849_1:ShowNextGo(true)
			end
		end

		arg_849_1.nodeConfigList_ = {}

		arg_849_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B01c",
		"TextureConfig/Background/ST13",
		"TextureConfig/Background/ST04a",
		"TextureConfig/Background/R2601"
	},
	voices = {
		"story_v_side_old_102604.awb"
	}
}
