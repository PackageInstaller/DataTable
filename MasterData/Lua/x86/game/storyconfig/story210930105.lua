return {
	Play1109305001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1109305001
		arg_1_1.duration_ = 6.9

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1109305002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST06b == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST06b")
				var_4_0.name = "ST06b"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST06b = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST06b

				arg_1_1.bgs_.ST06b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST06b" then
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
				arg_1_1:AudioAction("play", "music", "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

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

			local var_4_14 = 1.9
			local var_4_15 = 1.175

			if 1.9 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1109305001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 47 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 47)

				if (47 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 47)) > 0 and var_4_15 < var_4_19 then
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
	Play1109305002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1109305002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1109305003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.8

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(1109305002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 32 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 32)

				if (32 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 32)) > 0 and var_12_0 < var_12_3 then
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
	Play1109305003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1109305003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1109305004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.8

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(1109305003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 32 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 32)

				if (32 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 32)) > 0 and var_16_0 < var_16_3 then
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
	Play1109305004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1109305004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1109305005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.225

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(1109305004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 9 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 9)

				if (9 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 9)) > 0 and var_20_0 < var_20_3 then
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
	Play1109305005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1109305005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1109305006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 1.425

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

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(1109305005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 57 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 57)

				if (57 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 57)) > 0 and var_24_0 < var_24_3 then
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
	Play1109305006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1109305006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1109305007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.275

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_1 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(1109305006).content)

				arg_25_1.text_.text = var_28_1

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_3 = 11 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 11)

				if (11 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 11)) > 0 and var_28_0 < var_28_3 then
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
	Play1109305007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1109305007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1109305008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.675

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(1109305007).content)

				arg_29_1.text_.text = var_32_1

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_3 = 27 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 27)

				if (27 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 27)) > 0 and var_32_0 < var_32_3 then
					arg_29_1.talkMaxDuration = var_32_3

					if var_32_3 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_3 + 0
					end
				end

				arg_29_1.text_.text = var_32_1
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_4 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_4

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play1109305008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1109305008
		arg_33_1.duration_ = 2

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1109305009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if arg_33_1.actors_["1093ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_story"))) then
				local var_36_0 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_33_1.stage_.transform)

				var_36_0.name = "1093ui_story"
				var_36_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_["1093ui_story"] = var_36_0

				local var_36_1 = var_36_0:GetComponentInChildren(typeof(CharacterEffect))

				var_36_1.enabled = true

				local var_36_2 = GameObjectTools.GetOrAddComponent(var_36_0, typeof(DynamicBoneHelper))

				if var_36_2 then
					var_36_2:EnableDynamicBone(false)
				end

				arg_33_1:ShowWeapon(var_36_1.transform, false)

				arg_33_1.var_["1093ui_story" .. "Animator"] = var_36_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_33_1.var_["1093ui_story" .. "Animator"].applyRootMotion = true
				arg_33_1.var_["1093ui_story" .. "LipSync"] = var_36_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_36_3 = arg_33_1.actors_["1093ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1093ui_story = var_36_3.localPosition

				arg_33_1:ShowWeapon(arg_33_1.var_["1093ui_story" .. "Animator"].transform, false)
			end

			local var_36_4 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				var_36_3.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_33_1.time_ - 0) / var_36_4)
				var_36_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_3.position).x, (manager.ui.mainCamera.transform.position - var_36_3.position).y, (manager.ui.mainCamera.transform.position - var_36_3.position).z)
				var_36_3.localEulerAngles.z = 0
				var_36_3.localEulerAngles.x = 0
				var_36_3.localEulerAngles = var_36_3.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				var_36_3.localPosition = Vector3.New(0, -1.11, -5.88)
				var_36_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_3.position).x, (manager.ui.mainCamera.transform.position - var_36_3.position).y, (manager.ui.mainCamera.transform.position - var_36_3.position).z)
				var_36_3.localEulerAngles.z = 0
				var_36_3.localEulerAngles.x = 0
				var_36_3.localEulerAngles = var_36_3.localEulerAngles
			end

			local var_36_5 = arg_33_1.actors_["1093ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.characterEffect1093ui_story == nil then
				arg_33_1.var_.characterEffect1093ui_story = var_36_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_6 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_6 and not isNil(var_36_5) then
				if arg_33_1.var_.characterEffect1093ui_story and not isNil(var_36_5) then
					arg_33_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_6 and arg_33_1.time_ < 0 + var_36_6 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.characterEffect1093ui_story then
				arg_33_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if arg_33_1.frameCnt_ <= 1 then
				arg_33_1.dialog_:SetActive(false)
			end

			local var_36_8 = 0.3
			local var_36_9 = 0.075

			if 0.3 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0

				arg_33_1.dialog_:SetActive(true)

				arg_33_1.dialogCg_.alpha = 0

				local var_36_10 = LeanTween.value(arg_33_1.dialog_, 0, 1, 0.3)

				var_36_10:setOnUpdate(LuaHelper.FloatAction(function(arg_37_0)
					arg_33_1.dialogCg_.alpha = arg_37_0
				end))
				var_36_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_33_1.dialog_)
					var_36_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_33_1.duration_ = arg_33_1.duration_ + 0.3

				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_11 = arg_33_1:GetWordFromCfg(1109305008)
				local var_36_12 = arg_33_1:FormatText(var_36_11.content)

				arg_33_1.text_.text = var_36_12

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_14 = 3 <= 0 and var_36_9 or var_36_9 * (utf8.len(var_36_12) / 3)

				if (3 <= 0 and var_36_9 or var_36_9 * (utf8.len(var_36_12) / 3)) > 0 and var_36_9 < var_36_14 then
					arg_33_1.talkMaxDuration = var_36_14
					var_36_8 = var_36_8 + 0.3

					if var_36_14 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_14 + var_36_8
					end
				end

				arg_33_1.text_.text = var_36_12
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305008", "story_v_side_new_1109305.awb") ~= 0 then
					local var_36_15 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305008", "story_v_side_new_1109305.awb") / 1000

					if var_36_15 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_15 + var_36_8
					end

					if var_36_11.prefab_name ~= "" and arg_33_1.actors_[var_36_11.prefab_name] ~= nil then
						local var_36_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_11.prefab_name].transform, "story_v_side_new_1109305", "1109305008", "story_v_side_new_1109305.awb")

						arg_33_1:RecordAudio("1109305008", var_36_16)
						arg_33_1:RecordAudio("1109305008", var_36_16)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305008", "story_v_side_new_1109305.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305008", "story_v_side_new_1109305.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_17 = var_36_8 + 0.3
			local var_36_18 = math.max(var_36_9, arg_33_1.talkMaxDuration)

			if var_36_8 + 0.3 <= arg_33_1.time_ and arg_33_1.time_ < var_36_17 + var_36_18 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_17) / var_36_18

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_17 + var_36_18 and arg_33_1.time_ < var_36_17 + var_36_18 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
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

		arg_33_1:InitPlayNodeList()
	end,
	Play1109305009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 1109305009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play1109305010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(arg_39_1.actors_["1093ui_story"]) and arg_39_1.var_.characterEffect1093ui_story == nil then
				arg_39_1.var_.characterEffect1093ui_story = arg_39_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_0 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 and not isNil(arg_39_1.actors_["1093ui_story"]) then
				if arg_39_1.var_.characterEffect1093ui_story and not isNil(arg_39_1.actors_["1093ui_story"]) then
					arg_39_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_0)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 and not isNil(arg_39_1.actors_["1093ui_story"]) and arg_39_1.var_.characterEffect1093ui_story then
				arg_39_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_42_1 = 0
			local var_42_2 = 0.1

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
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

				local var_42_3 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(1109305009).content)

				arg_39_1.text_.text = var_42_3

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 4 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 4)

				if (4 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 4)) > 0 and var_42_2 < var_42_5 then
					arg_39_1.talkMaxDuration = var_42_5

					if var_42_5 + var_42_1 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_5 + var_42_1
					end
				end

				arg_39_1.text_.text = var_42_3
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_6 = math.max(var_42_2, arg_39_1.talkMaxDuration)

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_6 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_1) / var_42_6

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_1 + var_42_6 and arg_39_1.time_ < var_42_1 + var_42_6 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play1109305010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 1109305010
		arg_43_1.duration_ = 3

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play1109305011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(arg_43_1.actors_["1093ui_story"]) and arg_43_1.var_.characterEffect1093ui_story == nil then
				arg_43_1.var_.characterEffect1093ui_story = arg_43_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_0 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 and not isNil(arg_43_1.actors_["1093ui_story"]) then
				if arg_43_1.var_.characterEffect1093ui_story and not isNil(arg_43_1.actors_["1093ui_story"]) then
					arg_43_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 and not isNil(arg_43_1.actors_["1093ui_story"]) and arg_43_1.var_.characterEffect1093ui_story then
				arg_43_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_46_2 = 0
			local var_46_3 = 0.3

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_2 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_4 = arg_43_1:GetWordFromCfg(1109305010)
				local var_46_5 = arg_43_1:FormatText(var_46_4.content)

				arg_43_1.text_.text = var_46_5

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_7 = 12 <= 0 and var_46_3 or var_46_3 * (utf8.len(var_46_5) / 12)

				if (12 <= 0 and var_46_3 or var_46_3 * (utf8.len(var_46_5) / 12)) > 0 and var_46_3 < var_46_7 then
					arg_43_1.talkMaxDuration = var_46_7

					if var_46_7 + var_46_2 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_7 + var_46_2
					end
				end

				arg_43_1.text_.text = var_46_5
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305010", "story_v_side_new_1109305.awb") ~= 0 then
					local var_46_8 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305010", "story_v_side_new_1109305.awb") / 1000

					if var_46_8 + var_46_2 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_8 + var_46_2
					end

					if var_46_4.prefab_name ~= "" and arg_43_1.actors_[var_46_4.prefab_name] ~= nil then
						local var_46_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_4.prefab_name].transform, "story_v_side_new_1109305", "1109305010", "story_v_side_new_1109305.awb")

						arg_43_1:RecordAudio("1109305010", var_46_9)
						arg_43_1:RecordAudio("1109305010", var_46_9)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305010", "story_v_side_new_1109305.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305010", "story_v_side_new_1109305.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_10 = math.max(var_46_3, arg_43_1.talkMaxDuration)

			if var_46_2 <= arg_43_1.time_ and arg_43_1.time_ < var_46_2 + var_46_10 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_2) / var_46_10

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_2 + var_46_10 and arg_43_1.time_ < var_46_2 + var_46_10 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play1109305011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 1109305011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play1109305012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(arg_47_1.actors_["1093ui_story"]) and arg_47_1.var_.characterEffect1093ui_story == nil then
				arg_47_1.var_.characterEffect1093ui_story = arg_47_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_0 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 and not isNil(arg_47_1.actors_["1093ui_story"]) then
				if arg_47_1.var_.characterEffect1093ui_story and not isNil(arg_47_1.actors_["1093ui_story"]) then
					arg_47_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_0)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 and not isNil(arg_47_1.actors_["1093ui_story"]) and arg_47_1.var_.characterEffect1093ui_story then
				arg_47_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_50_1 = 0
			local var_50_2 = 0.9

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_3 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(1109305011).content)

				arg_47_1.text_.text = var_50_3

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_5 = 36 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 36)

				if (36 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 36)) > 0 and var_50_2 < var_50_5 then
					arg_47_1.talkMaxDuration = var_50_5

					if var_50_5 + var_50_1 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + var_50_1
					end
				end

				arg_47_1.text_.text = var_50_3
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_6 = math.max(var_50_2, arg_47_1.talkMaxDuration)

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_6 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_1) / var_50_6

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_1 + var_50_6 and arg_47_1.time_ < var_50_1 + var_50_6 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play1109305012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 1109305012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play1109305013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0.525

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
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

				local var_54_1 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(1109305012).content)

				arg_51_1.text_.text = var_54_1

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_3 = 21 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_1) / 21)

				if (21 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_1) / 21)) > 0 and var_54_0 < var_54_3 then
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
	Play1109305013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 1109305013
		arg_55_1.duration_ = 7.7

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play1109305014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos1093ui_story = arg_55_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_58_0 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 then
				arg_55_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_55_1.time_ - 0) / var_58_0)
				arg_55_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1093ui_story"].transform.position).z)
				arg_55_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1093ui_story"].transform.localEulerAngles = arg_55_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 then
				arg_55_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_55_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1093ui_story"].transform.position).z)
				arg_55_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1093ui_story"].transform.localEulerAngles = arg_55_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_58_1 = arg_55_1.actors_["1093ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect1093ui_story == nil then
				arg_55_1.var_.characterEffect1093ui_story = var_58_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_2 and not isNil(var_58_1) then
				if arg_55_1.var_.characterEffect1093ui_story and not isNil(var_58_1) then
					arg_55_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_2 and arg_55_1.time_ < 0 + var_58_2 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect1093ui_story then
				arg_55_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action446")
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_58_4 = 0
			local var_58_5 = 0.675

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_4 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_6 = arg_55_1:GetWordFromCfg(1109305013)
				local var_58_7 = arg_55_1:FormatText(var_58_6.content)

				arg_55_1.text_.text = var_58_7

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_9 = 27 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_7) / 27)

				if (27 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_7) / 27)) > 0 and var_58_5 < var_58_9 then
					arg_55_1.talkMaxDuration = var_58_9

					if var_58_9 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_9 + var_58_4
					end
				end

				arg_55_1.text_.text = var_58_7
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305013", "story_v_side_new_1109305.awb") ~= 0 then
					local var_58_10 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305013", "story_v_side_new_1109305.awb") / 1000

					if var_58_10 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_10 + var_58_4
					end

					if var_58_6.prefab_name ~= "" and arg_55_1.actors_[var_58_6.prefab_name] ~= nil then
						local var_58_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_6.prefab_name].transform, "story_v_side_new_1109305", "1109305013", "story_v_side_new_1109305.awb")

						arg_55_1:RecordAudio("1109305013", var_58_11)
						arg_55_1:RecordAudio("1109305013", var_58_11)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305013", "story_v_side_new_1109305.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305013", "story_v_side_new_1109305.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_12 = math.max(var_58_5, arg_55_1.talkMaxDuration)

			if var_58_4 <= arg_55_1.time_ and arg_55_1.time_ < var_58_4 + var_58_12 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_4) / var_58_12

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_4 + var_58_12 and arg_55_1.time_ < var_58_4 + var_58_12 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
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

		arg_55_1:InitPlayNodeList()
	end,
	Play1109305014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 1109305014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play1109305015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["1093ui_story"]) and arg_59_1.var_.characterEffect1093ui_story == nil then
				arg_59_1.var_.characterEffect1093ui_story = arg_59_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_0 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["1093ui_story"]) then
				if arg_59_1.var_.characterEffect1093ui_story and not isNil(arg_59_1.actors_["1093ui_story"]) then
					arg_59_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_0)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["1093ui_story"]) and arg_59_1.var_.characterEffect1093ui_story then
				arg_59_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_62_1 = 0
			local var_62_2 = 0.75

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_3 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(1109305014).content)

				arg_59_1.text_.text = var_62_3

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_5 = 30 <= 0 and var_62_2 or var_62_2 * (utf8.len(var_62_3) / 30)

				if (30 <= 0 and var_62_2 or var_62_2 * (utf8.len(var_62_3) / 30)) > 0 and var_62_2 < var_62_5 then
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

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play1109305015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 1109305015
		arg_63_1.duration_ = 6.07

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play1109305016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos1093ui_story = arg_63_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_66_0 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 then
				arg_63_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_63_1.time_ - 0) / var_66_0)
				arg_63_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1093ui_story"].transform.position).z)
				arg_63_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["1093ui_story"].transform.localEulerAngles = arg_63_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 then
				arg_63_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_63_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1093ui_story"].transform.position).z)
				arg_63_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["1093ui_story"].transform.localEulerAngles = arg_63_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_66_1 = arg_63_1.actors_["1093ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect1093ui_story == nil then
				arg_63_1.var_.characterEffect1093ui_story = var_66_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_2 and not isNil(var_66_1) then
				if arg_63_1.var_.characterEffect1093ui_story and not isNil(var_66_1) then
					arg_63_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_2 and arg_63_1.time_ < 0 + var_66_2 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect1093ui_story then
				arg_63_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_66_4 = 0
			local var_66_5 = 0.625

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_4 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_6 = arg_63_1:GetWordFromCfg(1109305015)
				local var_66_7 = arg_63_1:FormatText(var_66_6.content)

				arg_63_1.text_.text = var_66_7

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_9 = 25 <= 0 and var_66_5 or var_66_5 * (utf8.len(var_66_7) / 25)

				if (25 <= 0 and var_66_5 or var_66_5 * (utf8.len(var_66_7) / 25)) > 0 and var_66_5 < var_66_9 then
					arg_63_1.talkMaxDuration = var_66_9

					if var_66_9 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_9 + var_66_4
					end
				end

				arg_63_1.text_.text = var_66_7
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305015", "story_v_side_new_1109305.awb") ~= 0 then
					local var_66_10 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305015", "story_v_side_new_1109305.awb") / 1000

					if var_66_10 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_10 + var_66_4
					end

					if var_66_6.prefab_name ~= "" and arg_63_1.actors_[var_66_6.prefab_name] ~= nil then
						local var_66_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_6.prefab_name].transform, "story_v_side_new_1109305", "1109305015", "story_v_side_new_1109305.awb")

						arg_63_1:RecordAudio("1109305015", var_66_11)
						arg_63_1:RecordAudio("1109305015", var_66_11)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305015", "story_v_side_new_1109305.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305015", "story_v_side_new_1109305.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_12 = math.max(var_66_5, arg_63_1.talkMaxDuration)

			if var_66_4 <= arg_63_1.time_ and arg_63_1.time_ < var_66_4 + var_66_12 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_4) / var_66_12

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_4 + var_66_12 and arg_63_1.time_ < var_66_4 + var_66_12 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
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

		arg_63_1:InitPlayNodeList()
	end,
	Play1109305016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 1109305016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play1109305017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["1093ui_story"]) and arg_67_1.var_.characterEffect1093ui_story == nil then
				arg_67_1.var_.characterEffect1093ui_story = arg_67_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_0 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["1093ui_story"]) then
				if arg_67_1.var_.characterEffect1093ui_story and not isNil(arg_67_1.actors_["1093ui_story"]) then
					arg_67_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_0)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["1093ui_story"]) and arg_67_1.var_.characterEffect1093ui_story then
				arg_67_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_70_1 = 0
			local var_70_2 = 0.7

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
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

				local var_70_3 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(1109305016).content)

				arg_67_1.text_.text = var_70_3

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 28 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_3) / 28)

				if (28 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_3) / 28)) > 0 and var_70_2 < var_70_5 then
					arg_67_1.talkMaxDuration = var_70_5

					if var_70_5 + var_70_1 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + var_70_1
					end
				end

				arg_67_1.text_.text = var_70_3
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_6 = math.max(var_70_2, arg_67_1.talkMaxDuration)

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_6 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_1) / var_70_6

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_1 + var_70_6 and arg_67_1.time_ < var_70_1 + var_70_6 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play1109305017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 1109305017
		arg_71_1.duration_ = 6.37

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play1109305018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1093ui_story = arg_71_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_74_0 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 then
				arg_71_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_71_1.time_ - 0) / var_74_0)
				arg_71_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1093ui_story"].transform.position).z)
				arg_71_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1093ui_story"].transform.localEulerAngles = arg_71_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 then
				arg_71_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_71_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1093ui_story"].transform.position).z)
				arg_71_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1093ui_story"].transform.localEulerAngles = arg_71_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_74_1 = arg_71_1.actors_["1093ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1093ui_story == nil then
				arg_71_1.var_.characterEffect1093ui_story = var_74_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_2 and not isNil(var_74_1) then
				if arg_71_1.var_.characterEffect1093ui_story and not isNil(var_74_1) then
					arg_71_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_2 and arg_71_1.time_ < 0 + var_74_2 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1093ui_story then
				arg_71_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_2")
			end

			if arg_71_1.frameCnt_ <= 1 then
				arg_71_1.dialog_:SetActive(false)
			end

			local var_74_4 = 0.200000002980232
			local var_74_5 = 0.625

			if 0.200000002980232 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0

				arg_71_1.dialog_:SetActive(true)

				arg_71_1.dialogCg_.alpha = 0

				local var_74_6 = LeanTween.value(arg_71_1.dialog_, 0, 1, 0.3)

				var_74_6:setOnUpdate(LuaHelper.FloatAction(function(arg_75_0)
					arg_71_1.dialogCg_.alpha = arg_75_0
				end))
				var_74_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_71_1.dialog_)
					var_74_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_71_1.duration_ = arg_71_1.duration_ + 0.3

				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_7 = arg_71_1:GetWordFromCfg(1109305017)
				local var_74_8 = arg_71_1:FormatText(var_74_7.content)

				arg_71_1.text_.text = var_74_8

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_10 = 24 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_8) / 24)

				if (24 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_8) / 24)) > 0 and var_74_5 < var_74_10 then
					arg_71_1.talkMaxDuration = var_74_10
					var_74_4 = var_74_4 + 0.3

					if var_74_10 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_10 + var_74_4
					end
				end

				arg_71_1.text_.text = var_74_8
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305017", "story_v_side_new_1109305.awb") ~= 0 then
					local var_74_11 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305017", "story_v_side_new_1109305.awb") / 1000

					if var_74_11 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_11 + var_74_4
					end

					if var_74_7.prefab_name ~= "" and arg_71_1.actors_[var_74_7.prefab_name] ~= nil then
						local var_74_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_7.prefab_name].transform, "story_v_side_new_1109305", "1109305017", "story_v_side_new_1109305.awb")

						arg_71_1:RecordAudio("1109305017", var_74_12)
						arg_71_1:RecordAudio("1109305017", var_74_12)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305017", "story_v_side_new_1109305.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305017", "story_v_side_new_1109305.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_13 = var_74_4 + 0.3
			local var_74_14 = math.max(var_74_5, arg_71_1.talkMaxDuration)

			if var_74_4 + 0.3 <= arg_71_1.time_ and arg_71_1.time_ < var_74_13 + var_74_14 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_13) / var_74_14

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_13 + var_74_14 and arg_71_1.time_ < var_74_13 + var_74_14 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
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

		arg_71_1:InitPlayNodeList()
	end,
	Play1109305018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1109305018
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play1109305019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1093ui_story"]) and arg_77_1.var_.characterEffect1093ui_story == nil then
				arg_77_1.var_.characterEffect1093ui_story = arg_77_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1093ui_story"]) then
				if arg_77_1.var_.characterEffect1093ui_story and not isNil(arg_77_1.actors_["1093ui_story"]) then
					arg_77_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_0)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1093ui_story"]) and arg_77_1.var_.characterEffect1093ui_story then
				arg_77_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_80_1 = 0
			local var_80_2 = 0.125

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_3 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(1109305018).content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 5 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 5)

				if (5 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 5)) > 0 and var_80_2 < var_80_5 then
					arg_77_1.talkMaxDuration = var_80_5

					if var_80_5 + var_80_1 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + var_80_1
					end
				end

				arg_77_1.text_.text = var_80_3
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_6 = math.max(var_80_2, arg_77_1.talkMaxDuration)

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_6 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_1) / var_80_6

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_1 + var_80_6 and arg_77_1.time_ < var_80_1 + var_80_6 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play1109305019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1109305019
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play1109305020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1093ui_story = arg_81_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1093ui_story"].transform.position).z)
				arg_81_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1093ui_story"].transform.localEulerAngles = arg_81_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_81_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1093ui_story"].transform.position).z)
				arg_81_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1093ui_story"].transform.localEulerAngles = arg_81_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_84_1 = 0
			local var_84_2 = 0.8

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_3 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(1109305019).content)

				arg_81_1.text_.text = var_84_3

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 32 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 32)

				if (32 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 32)) > 0 and var_84_2 < var_84_5 then
					arg_81_1.talkMaxDuration = var_84_5

					if var_84_5 + var_84_1 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + var_84_1
					end
				end

				arg_81_1.text_.text = var_84_3
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_6 = math.max(var_84_2, arg_81_1.talkMaxDuration)

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_6 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_1) / var_84_6

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_1 + var_84_6 and arg_81_1.time_ < var_84_1 + var_84_6 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
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

		arg_81_1:InitPlayNodeList()
	end,
	Play1109305020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1109305020
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play1109305021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.125

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_1 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(1109305020).content)

				arg_85_1.text_.text = var_88_1

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_3 = 5 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 5)

				if (5 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 5)) > 0 and var_88_0 < var_88_3 then
					arg_85_1.talkMaxDuration = var_88_3

					if var_88_3 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_3 + 0
					end
				end

				arg_85_1.text_.text = var_88_1
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_4 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_4

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play1109305021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1109305021
		arg_89_1.duration_ = 1

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play1109305022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.075

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_1 = arg_89_1:GetWordFromCfg(1109305021)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 3 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 3)

				if (3 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 3)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305021", "story_v_side_new_1109305.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305021", "story_v_side_new_1109305.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_side_new_1109305", "1109305021", "story_v_side_new_1109305.awb")

						arg_89_1:RecordAudio("1109305021", var_92_6)
						arg_89_1:RecordAudio("1109305021", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305021", "story_v_side_new_1109305.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305021", "story_v_side_new_1109305.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_7 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_7 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_7

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_7 and arg_89_1.time_ < 0 + var_92_7 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play1109305022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1109305022
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play1109305023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.25

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_1 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(1109305022).content)

				arg_93_1.text_.text = var_96_1

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_3 = 10 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 10)

				if (10 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 10)) > 0 and var_96_0 < var_96_3 then
					arg_93_1.talkMaxDuration = var_96_3

					if var_96_3 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_3 + 0
					end
				end

				arg_93_1.text_.text = var_96_1
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_4 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_4

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play1109305023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1109305023
		arg_97_1.duration_ = 3.4

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play1109305024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.325

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_1 = arg_97_1:GetWordFromCfg(1109305023)
				local var_100_2 = arg_97_1:FormatText(var_100_1.content)

				arg_97_1.text_.text = var_100_2

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 13 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 13)

				if (13 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 13)) > 0 and var_100_0 < var_100_4 then
					arg_97_1.talkMaxDuration = var_100_4

					if var_100_4 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_4 + 0
					end
				end

				arg_97_1.text_.text = var_100_2
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305023", "story_v_side_new_1109305.awb") ~= 0 then
					local var_100_5 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305023", "story_v_side_new_1109305.awb") / 1000

					if var_100_5 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + 0
					end

					if var_100_1.prefab_name ~= "" and arg_97_1.actors_[var_100_1.prefab_name] ~= nil then
						local var_100_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_1.prefab_name].transform, "story_v_side_new_1109305", "1109305023", "story_v_side_new_1109305.awb")

						arg_97_1:RecordAudio("1109305023", var_100_6)
						arg_97_1:RecordAudio("1109305023", var_100_6)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305023", "story_v_side_new_1109305.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305023", "story_v_side_new_1109305.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_7 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_7

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play1109305024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1109305024
		arg_101_1.duration_ = 0.77

		SetActive(arg_101_1.tipsGo_, true)

		arg_101_1.tipsText_.text = StoryTipsCfg[109301].name

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"

			SetActive(arg_101_1.choicesGo_, true)

			for iter_102_0, iter_102_1 in ipairs(arg_101_1.choices_) do
				SetActive(iter_102_1.go, iter_102_0 <= 2)
			end

			arg_101_1.choices_[1].txt.text = arg_101_1:FormatText(StoryChoiceCfg[1027].name)
			arg_101_1.choices_[2].txt.text = arg_101_1:FormatText(StoryChoiceCfg[1028].name)
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play1109305025(arg_101_1)
			end

			if arg_103_0 == 2 then
				PlayerAction.UseStoryTrigger(1093011, 210930105, 1109305024, 2)
				arg_101_0:Play1109305025(arg_101_1)
			end

			arg_101_1:RecordChoiceLog(1109305024, 1027, 1028)
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1093ui_story"]) and arg_101_1.var_.characterEffect1093ui_story == nil then
				arg_101_1.var_.characterEffect1093ui_story = arg_101_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.3

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1093ui_story"]) then
				if arg_101_1.var_.characterEffect1093ui_story and not isNil(arg_101_1.actors_["1093ui_story"]) then
					arg_101_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_0)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1093ui_story"]) and arg_101_1.var_.characterEffect1093ui_story then
				arg_101_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play1109305025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1109305025
		arg_105_1.duration_ = 3.53

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play1109305026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1093ui_story = arg_105_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1093ui_story"].transform.position).z)
				arg_105_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1093ui_story"].transform.localEulerAngles = arg_105_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_105_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1093ui_story"].transform.position).z)
				arg_105_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1093ui_story"].transform.localEulerAngles = arg_105_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_108_1 = arg_105_1.actors_["1093ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect1093ui_story == nil then
				arg_105_1.var_.characterEffect1093ui_story = var_108_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 and not isNil(var_108_1) then
				if arg_105_1.var_.characterEffect1093ui_story and not isNil(var_108_1) then
					arg_105_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect1093ui_story then
				arg_105_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_108_4 = "1093ui_story"

			if arg_105_1.actors_["1093ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_story"))) then
				local var_108_5 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_105_1.stage_.transform)

				var_108_5.name = var_108_4
				var_108_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.actors_[var_108_4] = var_108_5

				local var_108_6 = var_108_5:GetComponentInChildren(typeof(CharacterEffect))

				var_108_6.enabled = true

				local var_108_7 = GameObjectTools.GetOrAddComponent(var_108_5, typeof(DynamicBoneHelper))

				if var_108_7 then
					var_108_7:EnableDynamicBone(false)
				end

				arg_105_1:ShowWeapon(var_108_6.transform, false)

				arg_105_1.var_[var_108_4 .. "Animator"] = var_108_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_105_1.var_[var_108_4 .. "Animator"].applyRootMotion = true
				arg_105_1.var_[var_108_4 .. "LipSync"] = var_108_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action7_1")
			end

			local var_108_8 = "1093ui_story"

			if arg_105_1.actors_["1093ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_story"))) then
				local var_108_9 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_105_1.stage_.transform)

				var_108_9.name = var_108_8
				var_108_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.actors_[var_108_8] = var_108_9

				local var_108_10 = var_108_9:GetComponentInChildren(typeof(CharacterEffect))

				var_108_10.enabled = true

				local var_108_11 = GameObjectTools.GetOrAddComponent(var_108_9, typeof(DynamicBoneHelper))

				if var_108_11 then
					var_108_11:EnableDynamicBone(false)
				end

				arg_105_1:ShowWeapon(var_108_10.transform, false)

				arg_105_1.var_[var_108_8 .. "Animator"] = var_108_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_105_1.var_[var_108_8 .. "Animator"].applyRootMotion = true
				arg_105_1.var_[var_108_8 .. "LipSync"] = var_108_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_108_12 = 0
			local var_108_13 = 0.375

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_12 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_14 = arg_105_1:GetWordFromCfg(1109305025)
				local var_108_15 = arg_105_1:FormatText(var_108_14.content)

				arg_105_1.text_.text = var_108_15

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_17 = 15 <= 0 and var_108_13 or var_108_13 * (utf8.len(var_108_15) / 15)

				if (15 <= 0 and var_108_13 or var_108_13 * (utf8.len(var_108_15) / 15)) > 0 and var_108_13 < var_108_17 then
					arg_105_1.talkMaxDuration = var_108_17

					if var_108_17 + var_108_12 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_17 + var_108_12
					end
				end

				arg_105_1.text_.text = var_108_15
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305025", "story_v_side_new_1109305.awb") ~= 0 then
					local var_108_18 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305025", "story_v_side_new_1109305.awb") / 1000

					if var_108_18 + var_108_12 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_18 + var_108_12
					end

					if var_108_14.prefab_name ~= "" and arg_105_1.actors_[var_108_14.prefab_name] ~= nil then
						local var_108_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_14.prefab_name].transform, "story_v_side_new_1109305", "1109305025", "story_v_side_new_1109305.awb")

						arg_105_1:RecordAudio("1109305025", var_108_19)
						arg_105_1:RecordAudio("1109305025", var_108_19)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305025", "story_v_side_new_1109305.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305025", "story_v_side_new_1109305.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_20 = math.max(var_108_13, arg_105_1.talkMaxDuration)

			if var_108_12 <= arg_105_1.time_ and arg_105_1.time_ < var_108_12 + var_108_20 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_12) / var_108_20

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_12 + var_108_20 and arg_105_1.time_ < var_108_12 + var_108_20 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
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

		arg_105_1:InitPlayNodeList()
	end,
	Play1109305026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1109305026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play1109305027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["1093ui_story"]) and arg_109_1.var_.characterEffect1093ui_story == nil then
				arg_109_1.var_.characterEffect1093ui_story = arg_109_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["1093ui_story"]) then
				if arg_109_1.var_.characterEffect1093ui_story and not isNil(arg_109_1.actors_["1093ui_story"]) then
					arg_109_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_0)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["1093ui_story"]) and arg_109_1.var_.characterEffect1093ui_story then
				arg_109_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_112_1 = 0
			local var_112_2 = 0.35

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_3 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(1109305026).content)

				arg_109_1.text_.text = var_112_3

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 14 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 14)

				if (14 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 14)) > 0 and var_112_2 < var_112_5 then
					arg_109_1.talkMaxDuration = var_112_5

					if var_112_5 + var_112_1 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + var_112_1
					end
				end

				arg_109_1.text_.text = var_112_3
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_6 = math.max(var_112_2, arg_109_1.talkMaxDuration)

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_6 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_1) / var_112_6

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_1 + var_112_6 and arg_109_1.time_ < var_112_1 + var_112_6 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play1109305027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1109305027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play1109305028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.5

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_1 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(1109305027).content)

				arg_113_1.text_.text = var_116_1

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_3 = 20 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 20)

				if (20 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 20)) > 0 and var_116_0 < var_116_3 then
					arg_113_1.talkMaxDuration = var_116_3

					if var_116_3 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_3 + 0
					end
				end

				arg_113_1.text_.text = var_116_1
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_4 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_4

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play1109305028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 1109305028
		arg_117_1.duration_ = 4.97

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play1109305029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1093ui_story = arg_117_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1093ui_story"].transform.position).z)
				arg_117_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1093ui_story"].transform.localEulerAngles = arg_117_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_117_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1093ui_story"].transform.position).z)
				arg_117_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1093ui_story"].transform.localEulerAngles = arg_117_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_120_1 = arg_117_1.actors_["1093ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1093ui_story == nil then
				arg_117_1.var_.characterEffect1093ui_story = var_120_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 and not isNil(var_120_1) then
				if arg_117_1.var_.characterEffect1093ui_story and not isNil(var_120_1) then
					arg_117_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_2 and arg_117_1.time_ < 0 + var_120_2 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1093ui_story then
				arg_117_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action7_2")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_120_4 = 0
			local var_120_5 = 0.5

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_6 = arg_117_1:GetWordFromCfg(1109305028)
				local var_120_7 = arg_117_1:FormatText(var_120_6.content)

				arg_117_1.text_.text = var_120_7

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_9 = 20 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 20)

				if (20 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 20)) > 0 and var_120_5 < var_120_9 then
					arg_117_1.talkMaxDuration = var_120_9

					if var_120_9 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_9 + var_120_4
					end
				end

				arg_117_1.text_.text = var_120_7
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305028", "story_v_side_new_1109305.awb") ~= 0 then
					local var_120_10 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305028", "story_v_side_new_1109305.awb") / 1000

					if var_120_10 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_4
					end

					if var_120_6.prefab_name ~= "" and arg_117_1.actors_[var_120_6.prefab_name] ~= nil then
						local var_120_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_6.prefab_name].transform, "story_v_side_new_1109305", "1109305028", "story_v_side_new_1109305.awb")

						arg_117_1:RecordAudio("1109305028", var_120_11)
						arg_117_1:RecordAudio("1109305028", var_120_11)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305028", "story_v_side_new_1109305.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305028", "story_v_side_new_1109305.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_12 = math.max(var_120_5, arg_117_1.talkMaxDuration)

			if var_120_4 <= arg_117_1.time_ and arg_117_1.time_ < var_120_4 + var_120_12 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_4) / var_120_12

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_4 + var_120_12 and arg_117_1.time_ < var_120_4 + var_120_12 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
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

		arg_117_1:InitPlayNodeList()
	end,
	Play1109305029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 1109305029
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play1109305030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["1093ui_story"]) and arg_121_1.var_.characterEffect1093ui_story == nil then
				arg_121_1.var_.characterEffect1093ui_story = arg_121_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["1093ui_story"]) then
				if arg_121_1.var_.characterEffect1093ui_story and not isNil(arg_121_1.actors_["1093ui_story"]) then
					arg_121_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_0)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["1093ui_story"]) and arg_121_1.var_.characterEffect1093ui_story then
				arg_121_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_124_1 = 0
			local var_124_2 = 0.525

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_3 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(1109305029).content)

				arg_121_1.text_.text = var_124_3

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 21 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_3) / 21)

				if (21 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_3) / 21)) > 0 and var_124_2 < var_124_5 then
					arg_121_1.talkMaxDuration = var_124_5

					if var_124_5 + var_124_1 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + var_124_1
					end
				end

				arg_121_1.text_.text = var_124_3
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_6 = math.max(var_124_2, arg_121_1.talkMaxDuration)

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_6 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_1) / var_124_6

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_1 + var_124_6 and arg_121_1.time_ < var_124_1 + var_124_6 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play1109305030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 1109305030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play1109305031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1093ui_story = arg_125_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1093ui_story"].transform.position).z)
				arg_125_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1093ui_story"].transform.localEulerAngles = arg_125_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_125_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1093ui_story"].transform.position).z)
				arg_125_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1093ui_story"].transform.localEulerAngles = arg_125_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_128_1 = 0
			local var_128_2 = 0.9

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

				local var_128_3 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(1109305030).content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 36 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 36)

				if (36 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 36)) > 0 and var_128_2 < var_128_5 then
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
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play1109305031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 1109305031
		arg_129_1.duration_ = 8.97

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play1109305032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1093ui_story = arg_129_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_132_0 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				arg_129_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_129_1.time_ - 0) / var_132_0)
				arg_129_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1093ui_story"].transform.position).z)
				arg_129_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1093ui_story"].transform.localEulerAngles = arg_129_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				arg_129_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_129_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1093ui_story"].transform.position).z)
				arg_129_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1093ui_story"].transform.localEulerAngles = arg_129_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_132_1 = arg_129_1.actors_["1093ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1093ui_story == nil then
				arg_129_1.var_.characterEffect1093ui_story = var_132_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_2 and not isNil(var_132_1) then
				if arg_129_1.var_.characterEffect1093ui_story and not isNil(var_132_1) then
					arg_129_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_2 and arg_129_1.time_ < 0 + var_132_2 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1093ui_story then
				arg_129_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_1")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_132_4 = 0
			local var_132_5 = 0.75

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_6 = arg_129_1:GetWordFromCfg(1109305031)
				local var_132_7 = arg_129_1:FormatText(var_132_6.content)

				arg_129_1.text_.text = var_132_7

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_9 = 30 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 30)

				if (30 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 30)) > 0 and var_132_5 < var_132_9 then
					arg_129_1.talkMaxDuration = var_132_9

					if var_132_9 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_4
					end
				end

				arg_129_1.text_.text = var_132_7
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305031", "story_v_side_new_1109305.awb") ~= 0 then
					local var_132_10 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305031", "story_v_side_new_1109305.awb") / 1000

					if var_132_10 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_4
					end

					if var_132_6.prefab_name ~= "" and arg_129_1.actors_[var_132_6.prefab_name] ~= nil then
						local var_132_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_6.prefab_name].transform, "story_v_side_new_1109305", "1109305031", "story_v_side_new_1109305.awb")

						arg_129_1:RecordAudio("1109305031", var_132_11)
						arg_129_1:RecordAudio("1109305031", var_132_11)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305031", "story_v_side_new_1109305.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305031", "story_v_side_new_1109305.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_12 = math.max(var_132_5, arg_129_1.talkMaxDuration)

			if var_132_4 <= arg_129_1.time_ and arg_129_1.time_ < var_132_4 + var_132_12 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_4) / var_132_12

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_4 + var_132_12 and arg_129_1.time_ < var_132_4 + var_132_12 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
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

		arg_129_1:InitPlayNodeList()
	end,
	Play1109305032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 1109305032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play1109305033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["1093ui_story"]) and arg_133_1.var_.characterEffect1093ui_story == nil then
				arg_133_1.var_.characterEffect1093ui_story = arg_133_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["1093ui_story"]) then
				if arg_133_1.var_.characterEffect1093ui_story and not isNil(arg_133_1.actors_["1093ui_story"]) then
					arg_133_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_0)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["1093ui_story"]) and arg_133_1.var_.characterEffect1093ui_story then
				arg_133_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_136_1 = 0
			local var_136_2 = 0.4

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_3 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(1109305032).content)

				arg_133_1.text_.text = var_136_3

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 16 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_3) / 16)

				if (16 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_3) / 16)) > 0 and var_136_2 < var_136_5 then
					arg_133_1.talkMaxDuration = var_136_5

					if var_136_5 + var_136_1 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + var_136_1
					end
				end

				arg_133_1.text_.text = var_136_3
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_6 = math.max(var_136_2, arg_133_1.talkMaxDuration)

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_6 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_1) / var_136_6

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_1 + var_136_6 and arg_133_1.time_ < var_136_1 + var_136_6 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play1109305033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 1109305033
		arg_137_1.duration_ = 7.27

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play1109305034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["1093ui_story"]) and arg_137_1.var_.characterEffect1093ui_story == nil then
				arg_137_1.var_.characterEffect1093ui_story = arg_137_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["1093ui_story"]) then
				if arg_137_1.var_.characterEffect1093ui_story and not isNil(arg_137_1.actors_["1093ui_story"]) then
					arg_137_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["1093ui_story"]) and arg_137_1.var_.characterEffect1093ui_story then
				arg_137_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_140_2 = 0
			local var_140_3 = 0.675

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_2 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_4 = arg_137_1:GetWordFromCfg(1109305033)
				local var_140_5 = arg_137_1:FormatText(var_140_4.content)

				arg_137_1.text_.text = var_140_5

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_7 = 27 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_5) / 27)

				if (27 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_5) / 27)) > 0 and var_140_3 < var_140_7 then
					arg_137_1.talkMaxDuration = var_140_7

					if var_140_7 + var_140_2 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_2
					end
				end

				arg_137_1.text_.text = var_140_5
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305033", "story_v_side_new_1109305.awb") ~= 0 then
					local var_140_8 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305033", "story_v_side_new_1109305.awb") / 1000

					if var_140_8 + var_140_2 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_8 + var_140_2
					end

					if var_140_4.prefab_name ~= "" and arg_137_1.actors_[var_140_4.prefab_name] ~= nil then
						local var_140_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_4.prefab_name].transform, "story_v_side_new_1109305", "1109305033", "story_v_side_new_1109305.awb")

						arg_137_1:RecordAudio("1109305033", var_140_9)
						arg_137_1:RecordAudio("1109305033", var_140_9)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305033", "story_v_side_new_1109305.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305033", "story_v_side_new_1109305.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_10 = math.max(var_140_3, arg_137_1.talkMaxDuration)

			if var_140_2 <= arg_137_1.time_ and arg_137_1.time_ < var_140_2 + var_140_10 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_2) / var_140_10

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_2 + var_140_10 and arg_137_1.time_ < var_140_2 + var_140_10 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play1109305034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 1109305034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play1109305035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["1093ui_story"]) and arg_141_1.var_.characterEffect1093ui_story == nil then
				arg_141_1.var_.characterEffect1093ui_story = arg_141_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["1093ui_story"]) then
				if arg_141_1.var_.characterEffect1093ui_story and not isNil(arg_141_1.actors_["1093ui_story"]) then
					arg_141_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_0)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["1093ui_story"]) and arg_141_1.var_.characterEffect1093ui_story then
				arg_141_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_144_1 = 0
			local var_144_2 = 0.675

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
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

				local var_144_3 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(1109305034).content)

				arg_141_1.text_.text = var_144_3

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 27 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_3) / 27)

				if (27 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_3) / 27)) > 0 and var_144_2 < var_144_5 then
					arg_141_1.talkMaxDuration = var_144_5

					if var_144_5 + var_144_1 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + var_144_1
					end
				end

				arg_141_1.text_.text = var_144_3
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_6 = math.max(var_144_2, arg_141_1.talkMaxDuration)

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_6 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_1) / var_144_6

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_1 + var_144_6 and arg_141_1.time_ < var_144_1 + var_144_6 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play1109305035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 1109305035
		arg_145_1.duration_ = 5.67

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play1109305036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if arg_145_1.bgs_.STblack == nil then
				local var_148_0 = Object.Instantiate(arg_145_1.paintGo_)

				var_148_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_148_0.name = "STblack"
				var_148_0.transform.parent = arg_145_1.stage_.transform
				var_148_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_145_1.bgs_.STblack = var_148_0
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				local var_148_1 = arg_145_1.bgs_.STblack

				arg_145_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_148_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_148_2 = var_148_1:GetComponent("SpriteRenderer")

				if var_148_2 and var_148_2.sprite then
					local var_148_3 = 2 * (var_148_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_148_1.transform.localScale = Vector3.New(var_148_3 / var_148_2.sprite.bounds.size.y < var_148_3 * manager.ui.mainCameraCom_.aspect / var_148_2.sprite.bounds.size.x and var_148_3 * manager.ui.mainCameraCom_.aspect / var_148_2.sprite.bounds.size.x or var_148_3 / var_148_2.sprite.bounds.size.y, var_148_3 / var_148_2.sprite.bounds.size.y < var_148_3 * manager.ui.mainCameraCom_.aspect / var_148_2.sprite.bounds.size.x and var_148_3 * manager.ui.mainCameraCom_.aspect / var_148_2.sprite.bounds.size.x or var_148_3 / var_148_2.sprite.bounds.size.y, 0)
				end

				for iter_148_0, iter_148_1 in pairs(arg_145_1.bgs_) do
					if iter_148_0 ~= "STblack" then
						iter_148_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_148_4 = 0

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_4 + arg_148_0 then
				arg_145_1.allBtn_.enabled = false
			end

			if arg_145_1.time_ >= var_148_4 + 0.3 and arg_145_1.time_ < var_148_4 + 0.3 + arg_148_0 then
				arg_145_1.allBtn_.enabled = true
			end

			local var_148_5 = 0

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_5 + arg_148_0 then
				arg_145_1.mask_.enabled = true
				arg_145_1.mask_.raycastTarget = true

				arg_145_1:SetGaussion(false)
			end

			local var_148_6 = 0.200000002980232

			if var_148_5 <= arg_145_1.time_ and arg_145_1.time_ < var_148_5 + var_148_6 then
				local var_148_7 = Color.New(0.8773585, 0.87322, 0.87322)

				var_148_7.a = Mathf.Lerp(1, 0, (arg_145_1.time_ - var_148_5) / var_148_6)
				arg_145_1.mask_.color = var_148_7
			end

			if arg_145_1.time_ >= var_148_5 + var_148_6 and arg_145_1.time_ < var_148_5 + var_148_6 + arg_148_0 then
				local var_148_8 = Color.New(0.8773585, 0.87322, 0.87322)

				arg_145_1.mask_.enabled = false
				var_148_8.a = 0
				arg_145_1.mask_.color = var_148_8
			end

			local var_148_9 = arg_145_1.actors_["1093ui_story"].transform

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1093ui_story = var_148_9.localPosition
			end

			local var_148_10 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_10 then
				var_148_9.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_145_1.time_ - 0) / var_148_10)
				var_148_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_9.position).x, (manager.ui.mainCamera.transform.position - var_148_9.position).y, (manager.ui.mainCamera.transform.position - var_148_9.position).z)
				var_148_9.localEulerAngles.z = 0
				var_148_9.localEulerAngles.x = 0
				var_148_9.localEulerAngles = var_148_9.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_10 and arg_145_1.time_ < 0 + var_148_10 + arg_148_0 then
				var_148_9.localPosition = Vector3.New(0, 100, 0)
				var_148_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_9.position).x, (manager.ui.mainCamera.transform.position - var_148_9.position).y, (manager.ui.mainCamera.transform.position - var_148_9.position).z)
				var_148_9.localEulerAngles.z = 0
				var_148_9.localEulerAngles.x = 0
				var_148_9.localEulerAngles = var_148_9.localEulerAngles
			end

			local var_148_11 = arg_145_1.actors_["1093ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_11) and arg_145_1.var_.characterEffect1093ui_story == nil then
				arg_145_1.var_.characterEffect1093ui_story = var_148_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_12 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_12 and not isNil(var_148_11) then
				if arg_145_1.var_.characterEffect1093ui_story and not isNil(var_148_11) then
					arg_145_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_12)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_12 and arg_145_1.time_ < 0 + var_148_12 + arg_148_0 and not isNil(var_148_11) and arg_145_1.var_.characterEffect1093ui_story then
				arg_145_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:AudioAction("play", "effect", "ui_skip", "ui_bgm_mute", "")
			end

			if 0.034000001847744 < arg_145_1.time_ and arg_145_1.time_ <= 0.034000001847744 + arg_148_0 then
				arg_145_1:AudioAction("play", "effect", "se_story_side_1093", "se_story_side_1093_poweroff", "")
			end

			if arg_145_1.frameCnt_ <= 1 then
				arg_145_1.dialog_:SetActive(false)
			end

			local var_148_15 = 0.666666666666667
			local var_148_16 = 1.05

			if 0.666666666666667 < arg_145_1.time_ and arg_145_1.time_ <= var_148_15 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0

				arg_145_1.dialog_:SetActive(true)

				arg_145_1.dialogCg_.alpha = 0

				local var_148_17 = LeanTween.value(arg_145_1.dialog_, 0, 1, 0.3)

				var_148_17:setOnUpdate(LuaHelper.FloatAction(function(arg_149_0)
					arg_145_1.dialogCg_.alpha = arg_149_0
				end))
				var_148_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_145_1.dialog_)
					var_148_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_145_1.duration_ = arg_145_1.duration_ + 0.3

				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_18 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(1109305035).content)

				arg_145_1.text_.text = var_148_18

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_20 = 42 <= 0 and var_148_16 or var_148_16 * (utf8.len(var_148_18) / 42)

				if (42 <= 0 and var_148_16 or var_148_16 * (utf8.len(var_148_18) / 42)) > 0 and var_148_16 < var_148_20 then
					arg_145_1.talkMaxDuration = var_148_20
					var_148_15 = var_148_15 + 0.3

					if var_148_20 + var_148_15 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_20 + var_148_15
					end
				end

				arg_145_1.text_.text = var_148_18
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_21 = var_148_15 + 0.3
			local var_148_22 = math.max(var_148_16, arg_145_1.talkMaxDuration)

			if var_148_15 + 0.3 <= arg_145_1.time_ and arg_145_1.time_ < var_148_21 + var_148_22 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_21) / var_148_22

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_21 + var_148_22 and arg_145_1.time_ < var_148_21 + var_148_22 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
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

		arg_145_1:InitPlayNodeList()
	end,
	Play1109305036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 1109305036
		arg_151_1.duration_ = 2.6

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play1109305037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.225

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_1 = arg_151_1:GetWordFromCfg(1109305036)
				local var_154_2 = arg_151_1:FormatText(var_154_1.content)

				arg_151_1.text_.text = var_154_2

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_4 = 9 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 9)

				if (9 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 9)) > 0 and var_154_0 < var_154_4 then
					arg_151_1.talkMaxDuration = var_154_4

					if var_154_4 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_4 + 0
					end
				end

				arg_151_1.text_.text = var_154_2
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305036", "story_v_side_new_1109305.awb") ~= 0 then
					local var_154_5 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305036", "story_v_side_new_1109305.awb") / 1000

					if var_154_5 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + 0
					end

					if var_154_1.prefab_name ~= "" and arg_151_1.actors_[var_154_1.prefab_name] ~= nil then
						local var_154_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_1.prefab_name].transform, "story_v_side_new_1109305", "1109305036", "story_v_side_new_1109305.awb")

						arg_151_1:RecordAudio("1109305036", var_154_6)
						arg_151_1:RecordAudio("1109305036", var_154_6)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305036", "story_v_side_new_1109305.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305036", "story_v_side_new_1109305.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_7 = math.max(var_154_0, arg_151_1.talkMaxDuration)

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_7 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - 0) / var_154_7

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= 0 + var_154_7 and arg_151_1.time_ < 0 + var_154_7 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play1109305037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 1109305037
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play1109305038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0.775

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_1 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(1109305037).content)

				arg_155_1.text_.text = var_158_1

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_3 = 31 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 31)

				if (31 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 31)) > 0 and var_158_0 < var_158_3 then
					arg_155_1.talkMaxDuration = var_158_3

					if var_158_3 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_3 + 0
					end
				end

				arg_155_1.text_.text = var_158_1
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_4 = math.max(var_158_0, arg_155_1.talkMaxDuration)

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_4 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - 0) / var_158_4

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= 0 + var_158_4 and arg_155_1.time_ < 0 + var_158_4 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play1109305038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 1109305038
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play1109305039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0.5

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_1 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(1109305038).content)

				arg_159_1.text_.text = var_162_1

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_3 = 20 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_1) / 20)

				if (20 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_1) / 20)) > 0 and var_162_0 < var_162_3 then
					arg_159_1.talkMaxDuration = var_162_3

					if var_162_3 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_3 + 0
					end
				end

				arg_159_1.text_.text = var_162_1
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_4 = math.max(var_162_0, arg_159_1.talkMaxDuration)

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_4 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - 0) / var_162_4

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= 0 + var_162_4 and arg_159_1.time_ < 0 + var_162_4 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play1109305039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 1109305039
		arg_163_1.duration_ = 3.9

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play1109305040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0.375

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_1 = arg_163_1:GetWordFromCfg(1109305039)
				local var_166_2 = arg_163_1:FormatText(var_166_1.content)

				arg_163_1.text_.text = var_166_2

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_4 = 15 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_2) / 15)

				if (15 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_2) / 15)) > 0 and var_166_0 < var_166_4 then
					arg_163_1.talkMaxDuration = var_166_4

					if var_166_4 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_4 + 0
					end
				end

				arg_163_1.text_.text = var_166_2
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305039", "story_v_side_new_1109305.awb") ~= 0 then
					local var_166_5 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305039", "story_v_side_new_1109305.awb") / 1000

					if var_166_5 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_5 + 0
					end

					if var_166_1.prefab_name ~= "" and arg_163_1.actors_[var_166_1.prefab_name] ~= nil then
						local var_166_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_1.prefab_name].transform, "story_v_side_new_1109305", "1109305039", "story_v_side_new_1109305.awb")

						arg_163_1:RecordAudio("1109305039", var_166_6)
						arg_163_1:RecordAudio("1109305039", var_166_6)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305039", "story_v_side_new_1109305.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305039", "story_v_side_new_1109305.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_7 = math.max(var_166_0, arg_163_1.talkMaxDuration)

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_7 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - 0) / var_166_7

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= 0 + var_166_7 and arg_163_1.time_ < 0 + var_166_7 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play1109305040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 1109305040
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play1109305041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0.475

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_1 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(1109305040).content)

				arg_167_1.text_.text = var_170_1

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_3 = 19 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 19)

				if (19 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 19)) > 0 and var_170_0 < var_170_3 then
					arg_167_1.talkMaxDuration = var_170_3

					if var_170_3 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_3 + 0
					end
				end

				arg_167_1.text_.text = var_170_1
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_4 = math.max(var_170_0, arg_167_1.talkMaxDuration)

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_4 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - 0) / var_170_4

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= 0 + var_170_4 and arg_167_1.time_ < 0 + var_170_4 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play1109305041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 1109305041
		arg_171_1.duration_ = 5.3

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play1109305042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.575

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_1 = arg_171_1:GetWordFromCfg(1109305041)
				local var_174_2 = arg_171_1:FormatText(var_174_1.content)

				arg_171_1.text_.text = var_174_2

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_4 = 23 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 23)

				if (23 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 23)) > 0 and var_174_0 < var_174_4 then
					arg_171_1.talkMaxDuration = var_174_4

					if var_174_4 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_4 + 0
					end
				end

				arg_171_1.text_.text = var_174_2
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305041", "story_v_side_new_1109305.awb") ~= 0 then
					local var_174_5 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305041", "story_v_side_new_1109305.awb") / 1000

					if var_174_5 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + 0
					end

					if var_174_1.prefab_name ~= "" and arg_171_1.actors_[var_174_1.prefab_name] ~= nil then
						local var_174_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_1.prefab_name].transform, "story_v_side_new_1109305", "1109305041", "story_v_side_new_1109305.awb")

						arg_171_1:RecordAudio("1109305041", var_174_6)
						arg_171_1:RecordAudio("1109305041", var_174_6)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305041", "story_v_side_new_1109305.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305041", "story_v_side_new_1109305.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_7 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_7 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_7

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_7 and arg_171_1.time_ < 0 + var_174_7 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play1109305042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 1109305042
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play1109305043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.525

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_1 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(1109305042).content)

				arg_175_1.text_.text = var_178_1

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_3 = 21 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 21)

				if (21 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 21)) > 0 and var_178_0 < var_178_3 then
					arg_175_1.talkMaxDuration = var_178_3

					if var_178_3 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_3 + 0
					end
				end

				arg_175_1.text_.text = var_178_1
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_4 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_4 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_4

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_4 and arg_175_1.time_ < 0 + var_178_4 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play1109305043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 1109305043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play1109305044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0.55

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_1 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(1109305043).content)

				arg_179_1.text_.text = var_182_1

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_3 = 22 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 22)

				if (22 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 22)) > 0 and var_182_0 < var_182_3 then
					arg_179_1.talkMaxDuration = var_182_3

					if var_182_3 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_3 + 0
					end
				end

				arg_179_1.text_.text = var_182_1
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_4 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_4

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play1109305044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 1109305044
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play1109305045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0.4

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_1 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(1109305044).content)

				arg_183_1.text_.text = var_186_1

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_3 = 16 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 16)

				if (16 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 16)) > 0 and var_186_0 < var_186_3 then
					arg_183_1.talkMaxDuration = var_186_3

					if var_186_3 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_3 + 0
					end
				end

				arg_183_1.text_.text = var_186_1
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_4 = math.max(var_186_0, arg_183_1.talkMaxDuration)

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_4 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - 0) / var_186_4

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= 0 + var_186_4 and arg_183_1.time_ < 0 + var_186_4 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play1109305045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1109305045
		arg_187_1.duration_ = 6.9

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play1109305046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				local var_190_0 = arg_187_1.bgs_.ST06b

				arg_187_1.bgs_.ST06b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_190_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_190_1 = var_190_0:GetComponent("SpriteRenderer")

				if var_190_1 and var_190_1.sprite then
					local var_190_2 = 2 * (var_190_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_190_0.transform.localScale = Vector3.New(var_190_2 / var_190_1.sprite.bounds.size.y < var_190_2 * manager.ui.mainCameraCom_.aspect / var_190_1.sprite.bounds.size.x and var_190_2 * manager.ui.mainCameraCom_.aspect / var_190_1.sprite.bounds.size.x or var_190_2 / var_190_1.sprite.bounds.size.y, var_190_2 / var_190_1.sprite.bounds.size.y < var_190_2 * manager.ui.mainCameraCom_.aspect / var_190_1.sprite.bounds.size.x and var_190_2 * manager.ui.mainCameraCom_.aspect / var_190_1.sprite.bounds.size.x or var_190_2 / var_190_1.sprite.bounds.size.y, 0)
				end

				for iter_190_0, iter_190_1 in pairs(arg_187_1.bgs_) do
					if iter_190_0 ~= "ST06b" then
						iter_190_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_190_3 = 0

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_3 + arg_190_0 then
				arg_187_1.mask_.enabled = true
				arg_187_1.mask_.raycastTarget = true

				arg_187_1:SetGaussion(false)
			end

			local var_190_4 = 2

			if var_190_3 <= arg_187_1.time_ and arg_187_1.time_ < var_190_3 + var_190_4 then
				local var_190_5 = Color.New(0, 0, 0)

				var_190_5.a = Mathf.Lerp(1, 0, (arg_187_1.time_ - var_190_3) / var_190_4)
				arg_187_1.mask_.color = var_190_5
			end

			if arg_187_1.time_ >= var_190_3 + var_190_4 and arg_187_1.time_ < var_190_3 + var_190_4 + arg_190_0 then
				local var_190_6 = Color.New(0, 0, 0)

				arg_187_1.mask_.enabled = false
				var_190_6.a = 0
				arg_187_1.mask_.color = var_190_6
			end

			if 0.9 < arg_187_1.time_ and arg_187_1.time_ <= 0.9 + arg_190_0 then
				arg_187_1:AudioAction("play", "effect", "ui_skip", "ui_reset", "")
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:AudioAction("play", "effect", "se_story_side_1093", "se_story_side_1093_poweron", "")
			end

			if arg_187_1.frameCnt_ <= 1 then
				arg_187_1.dialog_:SetActive(false)
			end

			local var_190_9 = 1.9
			local var_190_10 = 0.525

			if 1.9 < arg_187_1.time_ and arg_187_1.time_ <= var_190_9 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0

				arg_187_1.dialog_:SetActive(true)

				arg_187_1.dialogCg_.alpha = 0

				local var_190_11 = LeanTween.value(arg_187_1.dialog_, 0, 1, 0.3)

				var_190_11:setOnUpdate(LuaHelper.FloatAction(function(arg_191_0)
					arg_187_1.dialogCg_.alpha = arg_191_0
				end))
				var_190_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_187_1.dialog_)
					var_190_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_187_1.duration_ = arg_187_1.duration_ + 0.3

				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_12 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(1109305045).content)

				arg_187_1.text_.text = var_190_12

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_14 = 21 <= 0 and var_190_10 or var_190_10 * (utf8.len(var_190_12) / 21)

				if (21 <= 0 and var_190_10 or var_190_10 * (utf8.len(var_190_12) / 21)) > 0 and var_190_10 < var_190_14 then
					arg_187_1.talkMaxDuration = var_190_14
					var_190_9 = var_190_9 + 0.3

					if var_190_14 + var_190_9 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_14 + var_190_9
					end
				end

				arg_187_1.text_.text = var_190_12
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_15 = var_190_9 + 0.3
			local var_190_16 = math.max(var_190_10, arg_187_1.talkMaxDuration)

			if var_190_9 + 0.3 <= arg_187_1.time_ and arg_187_1.time_ < var_190_15 + var_190_16 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_15) / var_190_16

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_15 + var_190_16 and arg_187_1.time_ < var_190_15 + var_190_16 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play1109305046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 1109305046
		arg_193_1.duration_ = 6.77

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play1109305047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1093ui_story = arg_193_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_196_0 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 then
				arg_193_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_193_1.time_ - 0) / var_196_0)
				arg_193_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1093ui_story"].transform.position).z)
				arg_193_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1093ui_story"].transform.localEulerAngles = arg_193_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 then
				arg_193_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_193_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1093ui_story"].transform.position).z)
				arg_193_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1093ui_story"].transform.localEulerAngles = arg_193_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_196_1 = arg_193_1.actors_["1093ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect1093ui_story == nil then
				arg_193_1.var_.characterEffect1093ui_story = var_196_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_2 and not isNil(var_196_1) then
				if arg_193_1.var_.characterEffect1093ui_story and not isNil(var_196_1) then
					arg_193_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_2 and arg_193_1.time_ < 0 + var_196_2 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect1093ui_story then
				arg_193_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_2")
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_196_4 = 0
			local var_196_5 = 0.7

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_6 = arg_193_1:GetWordFromCfg(1109305046)
				local var_196_7 = arg_193_1:FormatText(var_196_6.content)

				arg_193_1.text_.text = var_196_7

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_9 = 28 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 28)

				if (28 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 28)) > 0 and var_196_5 < var_196_9 then
					arg_193_1.talkMaxDuration = var_196_9

					if var_196_9 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_9 + var_196_4
					end
				end

				arg_193_1.text_.text = var_196_7
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305046", "story_v_side_new_1109305.awb") ~= 0 then
					local var_196_10 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305046", "story_v_side_new_1109305.awb") / 1000

					if var_196_10 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_10 + var_196_4
					end

					if var_196_6.prefab_name ~= "" and arg_193_1.actors_[var_196_6.prefab_name] ~= nil then
						local var_196_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_6.prefab_name].transform, "story_v_side_new_1109305", "1109305046", "story_v_side_new_1109305.awb")

						arg_193_1:RecordAudio("1109305046", var_196_11)
						arg_193_1:RecordAudio("1109305046", var_196_11)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305046", "story_v_side_new_1109305.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305046", "story_v_side_new_1109305.awb")
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
				actorName = "1093ui_story",
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
	Play1109305047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 1109305047
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play1109305048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["1093ui_story"]) and arg_197_1.var_.characterEffect1093ui_story == nil then
				arg_197_1.var_.characterEffect1093ui_story = arg_197_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_0 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["1093ui_story"]) then
				if arg_197_1.var_.characterEffect1093ui_story and not isNil(arg_197_1.actors_["1093ui_story"]) then
					arg_197_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_0)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["1093ui_story"]) and arg_197_1.var_.characterEffect1093ui_story then
				arg_197_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_200_1 = 0
			local var_200_2 = 0.425

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

				local var_200_3 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(1109305047).content)

				arg_197_1.text_.text = var_200_3

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 17 <= 0 and var_200_2 or var_200_2 * (utf8.len(var_200_3) / 17)

				if (17 <= 0 and var_200_2 or var_200_2 * (utf8.len(var_200_3) / 17)) > 0 and var_200_2 < var_200_5 then
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
	Play1109305048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 1109305048
		arg_201_1.duration_ = 5.7

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play1109305049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos1093ui_story = arg_201_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_204_0 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 then
				arg_201_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_201_1.time_ - 0) / var_204_0)
				arg_201_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1093ui_story"].transform.position).z)
				arg_201_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1093ui_story"].transform.localEulerAngles = arg_201_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 then
				arg_201_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_201_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1093ui_story"].transform.position).z)
				arg_201_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1093ui_story"].transform.localEulerAngles = arg_201_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_204_1 = arg_201_1.actors_["1093ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_1) and arg_201_1.var_.characterEffect1093ui_story == nil then
				arg_201_1.var_.characterEffect1093ui_story = var_204_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_2 and not isNil(var_204_1) then
				if arg_201_1.var_.characterEffect1093ui_story and not isNil(var_204_1) then
					arg_201_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= 0 + var_204_2 and arg_201_1.time_ < 0 + var_204_2 + arg_204_0 and not isNil(var_204_1) and arg_201_1.var_.characterEffect1093ui_story then
				arg_201_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action3_1")
			end

			local var_204_4 = 0
			local var_204_5 = 0.525

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_4 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_6 = arg_201_1:GetWordFromCfg(1109305048)
				local var_204_7 = arg_201_1:FormatText(var_204_6.content)

				arg_201_1.text_.text = var_204_7

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_9 = 21 <= 0 and var_204_5 or var_204_5 * (utf8.len(var_204_7) / 21)

				if (21 <= 0 and var_204_5 or var_204_5 * (utf8.len(var_204_7) / 21)) > 0 and var_204_5 < var_204_9 then
					arg_201_1.talkMaxDuration = var_204_9

					if var_204_9 + var_204_4 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_9 + var_204_4
					end
				end

				arg_201_1.text_.text = var_204_7
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305048", "story_v_side_new_1109305.awb") ~= 0 then
					local var_204_10 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305048", "story_v_side_new_1109305.awb") / 1000

					if var_204_10 + var_204_4 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_10 + var_204_4
					end

					if var_204_6.prefab_name ~= "" and arg_201_1.actors_[var_204_6.prefab_name] ~= nil then
						local var_204_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_6.prefab_name].transform, "story_v_side_new_1109305", "1109305048", "story_v_side_new_1109305.awb")

						arg_201_1:RecordAudio("1109305048", var_204_11)
						arg_201_1:RecordAudio("1109305048", var_204_11)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305048", "story_v_side_new_1109305.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305048", "story_v_side_new_1109305.awb")
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
				actorName = "1093ui_story",
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
	Play1109305049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 1109305049
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play1109305050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(arg_205_1.actors_["1093ui_story"]) and arg_205_1.var_.characterEffect1093ui_story == nil then
				arg_205_1.var_.characterEffect1093ui_story = arg_205_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_0 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 and not isNil(arg_205_1.actors_["1093ui_story"]) then
				if arg_205_1.var_.characterEffect1093ui_story and not isNil(arg_205_1.actors_["1093ui_story"]) then
					arg_205_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_205_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_205_1.time_ - 0) / var_208_0)
				end
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 and not isNil(arg_205_1.actors_["1093ui_story"]) and arg_205_1.var_.characterEffect1093ui_story then
				arg_205_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_205_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_208_1 = 0
			local var_208_2 = 0.5

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_3 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(1109305049).content)

				arg_205_1.text_.text = var_208_3

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 20 <= 0 and var_208_2 or var_208_2 * (utf8.len(var_208_3) / 20)

				if (20 <= 0 and var_208_2 or var_208_2 * (utf8.len(var_208_3) / 20)) > 0 and var_208_2 < var_208_5 then
					arg_205_1.talkMaxDuration = var_208_5

					if var_208_5 + var_208_1 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + var_208_1
					end
				end

				arg_205_1.text_.text = var_208_3
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_6 = math.max(var_208_2, arg_205_1.talkMaxDuration)

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_6 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_1) / var_208_6

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_1 + var_208_6 and arg_205_1.time_ < var_208_1 + var_208_6 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play1109305050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 1109305050
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play1109305051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1093ui_story = arg_209_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_212_0 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 then
				arg_209_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_209_1.time_ - 0) / var_212_0)
				arg_209_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1093ui_story"].transform.position).z)
				arg_209_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1093ui_story"].transform.localEulerAngles = arg_209_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 then
				arg_209_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_209_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1093ui_story"].transform.position).z)
				arg_209_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1093ui_story"].transform.localEulerAngles = arg_209_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_212_1 = 0
			local var_212_2 = 0.975

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_3 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(1109305050).content)

				arg_209_1.text_.text = var_212_3

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_5 = 39 <= 0 and var_212_2 or var_212_2 * (utf8.len(var_212_3) / 39)

				if (39 <= 0 and var_212_2 or var_212_2 * (utf8.len(var_212_3) / 39)) > 0 and var_212_2 < var_212_5 then
					arg_209_1.talkMaxDuration = var_212_5

					if var_212_5 + var_212_1 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_5 + var_212_1
					end
				end

				arg_209_1.text_.text = var_212_3
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_6 = math.max(var_212_2, arg_209_1.talkMaxDuration)

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_6 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_1) / var_212_6

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_1 + var_212_6 and arg_209_1.time_ < var_212_1 + var_212_6 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
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

		arg_209_1:InitPlayNodeList()
	end,
	Play1109305051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 1109305051
		arg_213_1.duration_ = 3.7

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play1109305052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1093ui_story = arg_213_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_216_0 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 then
				arg_213_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_213_1.time_ - 0) / var_216_0)
				arg_213_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1093ui_story"].transform.position).z)
				arg_213_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1093ui_story"].transform.localEulerAngles = arg_213_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 then
				arg_213_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_213_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1093ui_story"].transform.position).z)
				arg_213_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1093ui_story"].transform.localEulerAngles = arg_213_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_216_1 = arg_213_1.actors_["1093ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1093ui_story == nil then
				arg_213_1.var_.characterEffect1093ui_story = var_216_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_2 and not isNil(var_216_1) then
				if arg_213_1.var_.characterEffect1093ui_story and not isNil(var_216_1) then
					arg_213_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_2 and arg_213_1.time_ < 0 + var_216_2 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1093ui_story then
				arg_213_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action438")
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_216_4 = 0
			local var_216_5 = 0.4

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_6 = arg_213_1:GetWordFromCfg(1109305051)
				local var_216_7 = arg_213_1:FormatText(var_216_6.content)

				arg_213_1.text_.text = var_216_7

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_9 = 16 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 16)

				if (16 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 16)) > 0 and var_216_5 < var_216_9 then
					arg_213_1.talkMaxDuration = var_216_9

					if var_216_9 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_9 + var_216_4
					end
				end

				arg_213_1.text_.text = var_216_7
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305051", "story_v_side_new_1109305.awb") ~= 0 then
					local var_216_10 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305051", "story_v_side_new_1109305.awb") / 1000

					if var_216_10 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_10 + var_216_4
					end

					if var_216_6.prefab_name ~= "" and arg_213_1.actors_[var_216_6.prefab_name] ~= nil then
						local var_216_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_6.prefab_name].transform, "story_v_side_new_1109305", "1109305051", "story_v_side_new_1109305.awb")

						arg_213_1:RecordAudio("1109305051", var_216_11)
						arg_213_1:RecordAudio("1109305051", var_216_11)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305051", "story_v_side_new_1109305.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305051", "story_v_side_new_1109305.awb")
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
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play1109305052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 1109305052
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play1109305053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(arg_217_1.actors_["1093ui_story"]) and arg_217_1.var_.characterEffect1093ui_story == nil then
				arg_217_1.var_.characterEffect1093ui_story = arg_217_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_0 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 and not isNil(arg_217_1.actors_["1093ui_story"]) then
				if arg_217_1.var_.characterEffect1093ui_story and not isNil(arg_217_1.actors_["1093ui_story"]) then
					arg_217_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_217_1.time_ - 0) / var_220_0)
				end
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 and not isNil(arg_217_1.actors_["1093ui_story"]) and arg_217_1.var_.characterEffect1093ui_story then
				arg_217_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_220_1 = 0
			local var_220_2 = 0.4

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_3 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(1109305052).content)

				arg_217_1.text_.text = var_220_3

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 16 <= 0 and var_220_2 or var_220_2 * (utf8.len(var_220_3) / 16)

				if (16 <= 0 and var_220_2 or var_220_2 * (utf8.len(var_220_3) / 16)) > 0 and var_220_2 < var_220_5 then
					arg_217_1.talkMaxDuration = var_220_5

					if var_220_5 + var_220_1 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + var_220_1
					end
				end

				arg_217_1.text_.text = var_220_3
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_6 = math.max(var_220_2, arg_217_1.talkMaxDuration)

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_6 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_1) / var_220_6

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_1 + var_220_6 and arg_217_1.time_ < var_220_1 + var_220_6 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play1109305053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1109305053
		arg_221_1.duration_ = 3.8

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play1109305054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(arg_221_1.actors_["1093ui_story"]) and arg_221_1.var_.characterEffect1093ui_story == nil then
				arg_221_1.var_.characterEffect1093ui_story = arg_221_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_0 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 and not isNil(arg_221_1.actors_["1093ui_story"]) then
				if arg_221_1.var_.characterEffect1093ui_story and not isNil(arg_221_1.actors_["1093ui_story"]) then
					arg_221_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 and not isNil(arg_221_1.actors_["1093ui_story"]) and arg_221_1.var_.characterEffect1093ui_story then
				arg_221_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_224_2 = 0
			local var_224_3 = 0.425

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_2 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_4 = arg_221_1:GetWordFromCfg(1109305053)
				local var_224_5 = arg_221_1:FormatText(var_224_4.content)

				arg_221_1.text_.text = var_224_5

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_7 = 17 <= 0 and var_224_3 or var_224_3 * (utf8.len(var_224_5) / 17)

				if (17 <= 0 and var_224_3 or var_224_3 * (utf8.len(var_224_5) / 17)) > 0 and var_224_3 < var_224_7 then
					arg_221_1.talkMaxDuration = var_224_7

					if var_224_7 + var_224_2 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_2
					end
				end

				arg_221_1.text_.text = var_224_5
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305053", "story_v_side_new_1109305.awb") ~= 0 then
					local var_224_8 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305053", "story_v_side_new_1109305.awb") / 1000

					if var_224_8 + var_224_2 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_8 + var_224_2
					end

					if var_224_4.prefab_name ~= "" and arg_221_1.actors_[var_224_4.prefab_name] ~= nil then
						local var_224_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_4.prefab_name].transform, "story_v_side_new_1109305", "1109305053", "story_v_side_new_1109305.awb")

						arg_221_1:RecordAudio("1109305053", var_224_9)
						arg_221_1:RecordAudio("1109305053", var_224_9)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305053", "story_v_side_new_1109305.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305053", "story_v_side_new_1109305.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_10 = math.max(var_224_3, arg_221_1.talkMaxDuration)

			if var_224_2 <= arg_221_1.time_ and arg_221_1.time_ < var_224_2 + var_224_10 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_2) / var_224_10

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_2 + var_224_10 and arg_221_1.time_ < var_224_2 + var_224_10 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play1109305054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1109305054
		arg_225_1.duration_ = 6.33

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play1109305055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action484")
			end

			local var_228_0 = arg_225_1.actors_["1093ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1093ui_story == nil then
				arg_225_1.var_.characterEffect1093ui_story = var_228_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_1 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_1 and not isNil(var_228_0) then
				if arg_225_1.var_.characterEffect1093ui_story and not isNil(var_228_0) then
					arg_225_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= 0 + var_228_1 and arg_225_1.time_ < 0 + var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1093ui_story then
				arg_225_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_228_3 = arg_225_1.actors_["1093ui_story"].transform

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos1093ui_story = var_228_3.localPosition
			end

			local var_228_4 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_4 then
				var_228_3.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_225_1.time_ - 0) / var_228_4)
				var_228_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_228_3.position).x, (manager.ui.mainCamera.transform.position - var_228_3.position).y, (manager.ui.mainCamera.transform.position - var_228_3.position).z)
				var_228_3.localEulerAngles.z = 0
				var_228_3.localEulerAngles.x = 0
				var_228_3.localEulerAngles = var_228_3.localEulerAngles
			end

			if arg_225_1.time_ >= 0 + var_228_4 and arg_225_1.time_ < 0 + var_228_4 + arg_228_0 then
				var_228_3.localPosition = Vector3.New(0, -1.11, -5.88)
				var_228_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_228_3.position).x, (manager.ui.mainCamera.transform.position - var_228_3.position).y, (manager.ui.mainCamera.transform.position - var_228_3.position).z)
				var_228_3.localEulerAngles.z = 0
				var_228_3.localEulerAngles.x = 0
				var_228_3.localEulerAngles = var_228_3.localEulerAngles
			end

			local var_228_5 = 0
			local var_228_6 = 0.725

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_5 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_7 = arg_225_1:GetWordFromCfg(1109305054)
				local var_228_8 = arg_225_1:FormatText(var_228_7.content)

				arg_225_1.text_.text = var_228_8

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_10 = 29 <= 0 and var_228_6 or var_228_6 * (utf8.len(var_228_8) / 29)

				if (29 <= 0 and var_228_6 or var_228_6 * (utf8.len(var_228_8) / 29)) > 0 and var_228_6 < var_228_10 then
					arg_225_1.talkMaxDuration = var_228_10

					if var_228_10 + var_228_5 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_10 + var_228_5
					end
				end

				arg_225_1.text_.text = var_228_8
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305054", "story_v_side_new_1109305.awb") ~= 0 then
					local var_228_11 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305054", "story_v_side_new_1109305.awb") / 1000

					if var_228_11 + var_228_5 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_11 + var_228_5
					end

					if var_228_7.prefab_name ~= "" and arg_225_1.actors_[var_228_7.prefab_name] ~= nil then
						local var_228_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_7.prefab_name].transform, "story_v_side_new_1109305", "1109305054", "story_v_side_new_1109305.awb")

						arg_225_1:RecordAudio("1109305054", var_228_12)
						arg_225_1:RecordAudio("1109305054", var_228_12)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305054", "story_v_side_new_1109305.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305054", "story_v_side_new_1109305.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_13 = math.max(var_228_6, arg_225_1.talkMaxDuration)

			if var_228_5 <= arg_225_1.time_ and arg_225_1.time_ < var_228_5 + var_228_13 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_5) / var_228_13

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_5 + var_228_13 and arg_225_1.time_ < var_228_5 + var_228_13 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
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

		arg_225_1:InitPlayNodeList()
	end,
	Play1109305055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1109305055
		arg_229_1.duration_ = 1

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"

			SetActive(arg_229_1.choicesGo_, true)

			for iter_230_0, iter_230_1 in ipairs(arg_229_1.choices_) do
				SetActive(iter_230_1.go, iter_230_0 <= 1)
			end

			arg_229_1.choices_[1].txt.text = arg_229_1:FormatText(StoryChoiceCfg[1029].name)
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play1109305056(arg_229_1)
			end

			arg_229_1:RecordChoiceLog(1109305055, 1029)
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["1093ui_story"]) and arg_229_1.var_.characterEffect1093ui_story == nil then
				arg_229_1.var_.characterEffect1093ui_story = arg_229_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_0 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["1093ui_story"]) then
				if arg_229_1.var_.characterEffect1093ui_story and not isNil(arg_229_1.actors_["1093ui_story"]) then
					arg_229_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_0)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["1093ui_story"]) and arg_229_1.var_.characterEffect1093ui_story then
				arg_229_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play1109305056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1109305056
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play1109305057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0.625

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

				local var_236_1 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(1109305056).content)

				arg_233_1.text_.text = var_236_1

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_3 = 25 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 25)

				if (25 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 25)) > 0 and var_236_0 < var_236_3 then
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
	Play1109305057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1109305057
		arg_237_1.duration_ = 4

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play1109305058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(arg_237_1.actors_["1093ui_story"]) and arg_237_1.var_.characterEffect1093ui_story == nil then
				arg_237_1.var_.characterEffect1093ui_story = arg_237_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_0 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 and not isNil(arg_237_1.actors_["1093ui_story"]) then
				if arg_237_1.var_.characterEffect1093ui_story and not isNil(arg_237_1.actors_["1093ui_story"]) then
					arg_237_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 and not isNil(arg_237_1.actors_["1093ui_story"]) and arg_237_1.var_.characterEffect1093ui_story then
				arg_237_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_240_2 = 0
			local var_240_3 = 0.45

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_2 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_4 = arg_237_1:GetWordFromCfg(1109305057)
				local var_240_5 = arg_237_1:FormatText(var_240_4.content)

				arg_237_1.text_.text = var_240_5

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_7 = 18 <= 0 and var_240_3 or var_240_3 * (utf8.len(var_240_5) / 18)

				if (18 <= 0 and var_240_3 or var_240_3 * (utf8.len(var_240_5) / 18)) > 0 and var_240_3 < var_240_7 then
					arg_237_1.talkMaxDuration = var_240_7

					if var_240_7 + var_240_2 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_7 + var_240_2
					end
				end

				arg_237_1.text_.text = var_240_5
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305057", "story_v_side_new_1109305.awb") ~= 0 then
					local var_240_8 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305057", "story_v_side_new_1109305.awb") / 1000

					if var_240_8 + var_240_2 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_8 + var_240_2
					end

					if var_240_4.prefab_name ~= "" and arg_237_1.actors_[var_240_4.prefab_name] ~= nil then
						local var_240_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_4.prefab_name].transform, "story_v_side_new_1109305", "1109305057", "story_v_side_new_1109305.awb")

						arg_237_1:RecordAudio("1109305057", var_240_9)
						arg_237_1:RecordAudio("1109305057", var_240_9)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305057", "story_v_side_new_1109305.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305057", "story_v_side_new_1109305.awb")
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
	Play1109305058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 1109305058
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play1109305059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1093ui_story = arg_241_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_244_0 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 then
				arg_241_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_241_1.time_ - 0) / var_244_0)
				arg_241_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1093ui_story"].transform.position).z)
				arg_241_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1093ui_story"].transform.localEulerAngles = arg_241_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 then
				arg_241_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_241_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1093ui_story"].transform.position).z)
				arg_241_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1093ui_story"].transform.localEulerAngles = arg_241_1.actors_["1093ui_story"].transform.localEulerAngles
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

				local var_244_3 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(1109305058).content)

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
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play1109305059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 1109305059
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play1109305060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0.775

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_1 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(1109305059).content)

				arg_245_1.text_.text = var_248_1

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_3 = 31 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_1) / 31)

				if (31 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_1) / 31)) > 0 and var_248_0 < var_248_3 then
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
	Play1109305060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 1109305060
		arg_249_1.duration_ = 4.37

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play1109305061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1093ui_story = arg_249_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_252_0 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 then
				arg_249_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_249_1.time_ - 0) / var_252_0)
				arg_249_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1093ui_story"].transform.position).z)
				arg_249_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["1093ui_story"].transform.localEulerAngles = arg_249_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 then
				arg_249_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_249_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1093ui_story"].transform.position).z)
				arg_249_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["1093ui_story"].transform.localEulerAngles = arg_249_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_252_1 = arg_249_1.actors_["1093ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect1093ui_story == nil then
				arg_249_1.var_.characterEffect1093ui_story = var_252_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_2 and not isNil(var_252_1) then
				if arg_249_1.var_.characterEffect1093ui_story and not isNil(var_252_1) then
					arg_249_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_2 and arg_249_1.time_ < 0 + var_252_2 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect1093ui_story then
				arg_249_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_2")
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_252_4 = 0
			local var_252_5 = 0.475

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_4 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_6 = arg_249_1:GetWordFromCfg(1109305060)
				local var_252_7 = arg_249_1:FormatText(var_252_6.content)

				arg_249_1.text_.text = var_252_7

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_9 = 19 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 19)

				if (19 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 19)) > 0 and var_252_5 < var_252_9 then
					arg_249_1.talkMaxDuration = var_252_9

					if var_252_9 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_9 + var_252_4
					end
				end

				arg_249_1.text_.text = var_252_7
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305060", "story_v_side_new_1109305.awb") ~= 0 then
					local var_252_10 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305060", "story_v_side_new_1109305.awb") / 1000

					if var_252_10 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_10 + var_252_4
					end

					if var_252_6.prefab_name ~= "" and arg_249_1.actors_[var_252_6.prefab_name] ~= nil then
						local var_252_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_6.prefab_name].transform, "story_v_side_new_1109305", "1109305060", "story_v_side_new_1109305.awb")

						arg_249_1:RecordAudio("1109305060", var_252_11)
						arg_249_1:RecordAudio("1109305060", var_252_11)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305060", "story_v_side_new_1109305.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305060", "story_v_side_new_1109305.awb")
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
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play1109305061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 1109305061
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play1109305062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1093ui_story = arg_253_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_256_0 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 then
				arg_253_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_253_1.time_ - 0) / var_256_0)
				arg_253_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1093ui_story"].transform.position).z)
				arg_253_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1093ui_story"].transform.localEulerAngles = arg_253_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 then
				arg_253_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_253_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1093ui_story"].transform.position).z)
				arg_253_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1093ui_story"].transform.localEulerAngles = arg_253_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_256_1 = arg_253_1.actors_["1093ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect1093ui_story == nil then
				arg_253_1.var_.characterEffect1093ui_story = var_256_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_2 and not isNil(var_256_1) then
				if arg_253_1.var_.characterEffect1093ui_story and not isNil(var_256_1) then
					arg_253_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_2)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_2 and arg_253_1.time_ < 0 + var_256_2 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect1093ui_story then
				arg_253_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_256_3 = 0
			local var_256_4 = 0.525

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_3 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_5 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(1109305061).content)

				arg_253_1.text_.text = var_256_5

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_7 = 21 <= 0 and var_256_4 or var_256_4 * (utf8.len(var_256_5) / 21)

				if (21 <= 0 and var_256_4 or var_256_4 * (utf8.len(var_256_5) / 21)) > 0 and var_256_4 < var_256_7 then
					arg_253_1.talkMaxDuration = var_256_7

					if var_256_7 + var_256_3 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_7 + var_256_3
					end
				end

				arg_253_1.text_.text = var_256_5
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_8 = math.max(var_256_4, arg_253_1.talkMaxDuration)

			if var_256_3 <= arg_253_1.time_ and arg_253_1.time_ < var_256_3 + var_256_8 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_3) / var_256_8

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_3 + var_256_8 and arg_253_1.time_ < var_256_3 + var_256_8 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
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

		arg_253_1:InitPlayNodeList()
	end,
	Play1109305062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 1109305062
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play1109305063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0.55

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_1 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(1109305062).content)

				arg_257_1.text_.text = var_260_1

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_3 = 22 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 22)

				if (22 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 22)) > 0 and var_260_0 < var_260_3 then
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
	Play1109305063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 1109305063
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play1109305064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0.775

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_1 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(1109305063).content)

				arg_261_1.text_.text = var_264_1

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_3 = 31 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 31)

				if (31 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 31)) > 0 and var_264_0 < var_264_3 then
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
	Play1109305064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 1109305064
		arg_265_1.duration_ = 5.2

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play1109305065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos1093ui_story = arg_265_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_268_0 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 then
				arg_265_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_265_1.time_ - 0) / var_268_0)
				arg_265_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1093ui_story"].transform.position).z)
				arg_265_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["1093ui_story"].transform.localEulerAngles = arg_265_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 then
				arg_265_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_265_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1093ui_story"].transform.position).z)
				arg_265_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["1093ui_story"].transform.localEulerAngles = arg_265_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_268_1 = arg_265_1.actors_["1093ui_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_1) and arg_265_1.var_.characterEffect1093ui_story == nil then
				arg_265_1.var_.characterEffect1093ui_story = var_268_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_2 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_2 and not isNil(var_268_1) then
				if arg_265_1.var_.characterEffect1093ui_story and not isNil(var_268_1) then
					arg_265_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= 0 + var_268_2 and arg_265_1.time_ < 0 + var_268_2 + arg_268_0 and not isNil(var_268_1) and arg_265_1.var_.characterEffect1093ui_story then
				arg_265_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action9_1")
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_268_4 = 0
			local var_268_5 = 0.65

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_4 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_6 = arg_265_1:GetWordFromCfg(1109305064)
				local var_268_7 = arg_265_1:FormatText(var_268_6.content)

				arg_265_1.text_.text = var_268_7

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_9 = 26 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_7) / 26)

				if (26 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_7) / 26)) > 0 and var_268_5 < var_268_9 then
					arg_265_1.talkMaxDuration = var_268_9

					if var_268_9 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_9 + var_268_4
					end
				end

				arg_265_1.text_.text = var_268_7
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305064", "story_v_side_new_1109305.awb") ~= 0 then
					local var_268_10 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305064", "story_v_side_new_1109305.awb") / 1000

					if var_268_10 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_10 + var_268_4
					end

					if var_268_6.prefab_name ~= "" and arg_265_1.actors_[var_268_6.prefab_name] ~= nil then
						local var_268_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_6.prefab_name].transform, "story_v_side_new_1109305", "1109305064", "story_v_side_new_1109305.awb")

						arg_265_1:RecordAudio("1109305064", var_268_11)
						arg_265_1:RecordAudio("1109305064", var_268_11)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305064", "story_v_side_new_1109305.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305064", "story_v_side_new_1109305.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_12 = math.max(var_268_5, arg_265_1.talkMaxDuration)

			if var_268_4 <= arg_265_1.time_ and arg_265_1.time_ < var_268_4 + var_268_12 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_4) / var_268_12

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_4 + var_268_12 and arg_265_1.time_ < var_268_4 + var_268_12 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
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

		arg_265_1:InitPlayNodeList()
	end,
	Play1109305065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 1109305065
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play1109305066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(arg_269_1.actors_["1093ui_story"]) and arg_269_1.var_.characterEffect1093ui_story == nil then
				arg_269_1.var_.characterEffect1093ui_story = arg_269_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_0 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 and not isNil(arg_269_1.actors_["1093ui_story"]) then
				if arg_269_1.var_.characterEffect1093ui_story and not isNil(arg_269_1.actors_["1093ui_story"]) then
					arg_269_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_269_1.time_ - 0) / var_272_0)
				end
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 and not isNil(arg_269_1.actors_["1093ui_story"]) and arg_269_1.var_.characterEffect1093ui_story then
				arg_269_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_272_1 = 0
			local var_272_2 = 0.95

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

				local var_272_3 = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(1109305065).content)

				arg_269_1.text_.text = var_272_3

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_5 = 38 <= 0 and var_272_2 or var_272_2 * (utf8.len(var_272_3) / 38)

				if (38 <= 0 and var_272_2 or var_272_2 * (utf8.len(var_272_3) / 38)) > 0 and var_272_2 < var_272_5 then
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
	Play1109305066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 1109305066
		arg_273_1.duration_ = 5.23

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play1109305067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(arg_273_1.actors_["1093ui_story"]) and arg_273_1.var_.characterEffect1093ui_story == nil then
				arg_273_1.var_.characterEffect1093ui_story = arg_273_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_0 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 and not isNil(arg_273_1.actors_["1093ui_story"]) then
				if arg_273_1.var_.characterEffect1093ui_story and not isNil(arg_273_1.actors_["1093ui_story"]) then
					arg_273_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 and not isNil(arg_273_1.actors_["1093ui_story"]) and arg_273_1.var_.characterEffect1093ui_story then
				arg_273_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_276_2 = 0
			local var_276_3 = 0.475

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_2 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_4 = arg_273_1:GetWordFromCfg(1109305066)
				local var_276_5 = arg_273_1:FormatText(var_276_4.content)

				arg_273_1.text_.text = var_276_5

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_7 = 19 <= 0 and var_276_3 or var_276_3 * (utf8.len(var_276_5) / 19)

				if (19 <= 0 and var_276_3 or var_276_3 * (utf8.len(var_276_5) / 19)) > 0 and var_276_3 < var_276_7 then
					arg_273_1.talkMaxDuration = var_276_7

					if var_276_7 + var_276_2 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_7 + var_276_2
					end
				end

				arg_273_1.text_.text = var_276_5
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305066", "story_v_side_new_1109305.awb") ~= 0 then
					local var_276_8 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305066", "story_v_side_new_1109305.awb") / 1000

					if var_276_8 + var_276_2 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_8 + var_276_2
					end

					if var_276_4.prefab_name ~= "" and arg_273_1.actors_[var_276_4.prefab_name] ~= nil then
						local var_276_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_4.prefab_name].transform, "story_v_side_new_1109305", "1109305066", "story_v_side_new_1109305.awb")

						arg_273_1:RecordAudio("1109305066", var_276_9)
						arg_273_1:RecordAudio("1109305066", var_276_9)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305066", "story_v_side_new_1109305.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305066", "story_v_side_new_1109305.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_10 = math.max(var_276_3, arg_273_1.talkMaxDuration)

			if var_276_2 <= arg_273_1.time_ and arg_273_1.time_ < var_276_2 + var_276_10 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_2) / var_276_10

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_2 + var_276_10 and arg_273_1.time_ < var_276_2 + var_276_10 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play1109305067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 1109305067
		arg_277_1.duration_ = 0.33

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"

			SetActive(arg_277_1.choicesGo_, true)

			for iter_278_0, iter_278_1 in ipairs(arg_277_1.choices_) do
				SetActive(iter_278_1.go, iter_278_0 <= 1)
			end

			arg_277_1.choices_[1].txt.text = arg_277_1:FormatText(StoryChoiceCfg[1030].name)
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play1109305068(arg_277_1)
			end

			arg_277_1:RecordChoiceLog(1109305067, 1030)
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(arg_277_1.actors_["1093ui_story"]) and arg_277_1.var_.characterEffect1093ui_story == nil then
				arg_277_1.var_.characterEffect1093ui_story = arg_277_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_0 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 and not isNil(arg_277_1.actors_["1093ui_story"]) then
				if arg_277_1.var_.characterEffect1093ui_story and not isNil(arg_277_1.actors_["1093ui_story"]) then
					arg_277_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_277_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_277_1.time_ - 0) / var_280_0)
				end
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 and not isNil(arg_277_1.actors_["1093ui_story"]) and arg_277_1.var_.characterEffect1093ui_story then
				arg_277_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_277_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play1109305068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 1109305068
		arg_281_1.duration_ = 6.5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play1109305069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos1093ui_story = arg_281_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_284_0 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 then
				arg_281_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_281_1.time_ - 0) / var_284_0)
				arg_281_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1093ui_story"].transform.position).z)
				arg_281_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["1093ui_story"].transform.localEulerAngles = arg_281_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 then
				arg_281_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_281_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1093ui_story"].transform.position).z)
				arg_281_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["1093ui_story"].transform.localEulerAngles = arg_281_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_284_1 = arg_281_1.actors_["1093ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_1) and arg_281_1.var_.characterEffect1093ui_story == nil then
				arg_281_1.var_.characterEffect1093ui_story = var_284_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_2 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_2 and not isNil(var_284_1) then
				if arg_281_1.var_.characterEffect1093ui_story and not isNil(var_284_1) then
					arg_281_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= 0 + var_284_2 and arg_281_1.time_ < 0 + var_284_2 + arg_284_0 and not isNil(var_284_1) and arg_281_1.var_.characterEffect1093ui_story then
				arg_281_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action9_2")
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_284_4 = 0
			local var_284_5 = 0.625

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_4 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_6 = arg_281_1:GetWordFromCfg(1109305068)
				local var_284_7 = arg_281_1:FormatText(var_284_6.content)

				arg_281_1.text_.text = var_284_7

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_9 = 25 <= 0 and var_284_5 or var_284_5 * (utf8.len(var_284_7) / 25)

				if (25 <= 0 and var_284_5 or var_284_5 * (utf8.len(var_284_7) / 25)) > 0 and var_284_5 < var_284_9 then
					arg_281_1.talkMaxDuration = var_284_9

					if var_284_9 + var_284_4 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_9 + var_284_4
					end
				end

				arg_281_1.text_.text = var_284_7
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305068", "story_v_side_new_1109305.awb") ~= 0 then
					local var_284_10 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305068", "story_v_side_new_1109305.awb") / 1000

					if var_284_10 + var_284_4 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_10 + var_284_4
					end

					if var_284_6.prefab_name ~= "" and arg_281_1.actors_[var_284_6.prefab_name] ~= nil then
						local var_284_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_6.prefab_name].transform, "story_v_side_new_1109305", "1109305068", "story_v_side_new_1109305.awb")

						arg_281_1:RecordAudio("1109305068", var_284_11)
						arg_281_1:RecordAudio("1109305068", var_284_11)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305068", "story_v_side_new_1109305.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305068", "story_v_side_new_1109305.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_12 = math.max(var_284_5, arg_281_1.talkMaxDuration)

			if var_284_4 <= arg_281_1.time_ and arg_281_1.time_ < var_284_4 + var_284_12 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_4) / var_284_12

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_4 + var_284_12 and arg_281_1.time_ < var_284_4 + var_284_12 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
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

		arg_281_1:InitPlayNodeList()
	end,
	Play1109305069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 1109305069
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play1109305070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["1093ui_story"]) and arg_285_1.var_.characterEffect1093ui_story == nil then
				arg_285_1.var_.characterEffect1093ui_story = arg_285_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_0 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["1093ui_story"]) then
				if arg_285_1.var_.characterEffect1093ui_story and not isNil(arg_285_1.actors_["1093ui_story"]) then
					arg_285_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_285_1.time_ - 0) / var_288_0)
				end
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["1093ui_story"]) and arg_285_1.var_.characterEffect1093ui_story then
				arg_285_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_288_1 = 0
			local var_288_2 = 0.55

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[7].name)

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

				local var_288_3 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(1109305069).content)

				arg_285_1.text_.text = var_288_3

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_5 = 22 <= 0 and var_288_2 or var_288_2 * (utf8.len(var_288_3) / 22)

				if (22 <= 0 and var_288_2 or var_288_2 * (utf8.len(var_288_3) / 22)) > 0 and var_288_2 < var_288_5 then
					arg_285_1.talkMaxDuration = var_288_5

					if var_288_5 + var_288_1 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_5 + var_288_1
					end
				end

				arg_285_1.text_.text = var_288_3
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_6 = math.max(var_288_2, arg_285_1.talkMaxDuration)

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_6 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_1) / var_288_6

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_1 + var_288_6 and arg_285_1.time_ < var_288_1 + var_288_6 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play1109305070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 1109305070
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play1109305071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 1.05

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, false)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_1 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(1109305070).content)

				arg_289_1.text_.text = var_292_1

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_3 = 42 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 42)

				if (42 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 42)) > 0 and var_292_0 < var_292_3 then
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
	Play1109305071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 1109305071
		arg_293_1.duration_ = 3.97

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play1109305072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos1093ui_story = arg_293_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_296_0 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 then
				arg_293_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_293_1.time_ - 0) / var_296_0)
				arg_293_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1093ui_story"].transform.position).z)
				arg_293_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["1093ui_story"].transform.localEulerAngles = arg_293_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 then
				arg_293_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_293_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1093ui_story"].transform.position).z)
				arg_293_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["1093ui_story"].transform.localEulerAngles = arg_293_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_296_1 = arg_293_1.actors_["1093ui_story"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_1) and arg_293_1.var_.characterEffect1093ui_story == nil then
				arg_293_1.var_.characterEffect1093ui_story = var_296_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_2 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_2 and not isNil(var_296_1) then
				if arg_293_1.var_.characterEffect1093ui_story and not isNil(var_296_1) then
					arg_293_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= 0 + var_296_2 and arg_293_1.time_ < 0 + var_296_2 + arg_296_0 and not isNil(var_296_1) and arg_293_1.var_.characterEffect1093ui_story then
				arg_293_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action7_1")
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_296_4 = 0
			local var_296_5 = 0.35

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_4 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_6 = arg_293_1:GetWordFromCfg(1109305071)
				local var_296_7 = arg_293_1:FormatText(var_296_6.content)

				arg_293_1.text_.text = var_296_7

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_9 = 14 <= 0 and var_296_5 or var_296_5 * (utf8.len(var_296_7) / 14)

				if (14 <= 0 and var_296_5 or var_296_5 * (utf8.len(var_296_7) / 14)) > 0 and var_296_5 < var_296_9 then
					arg_293_1.talkMaxDuration = var_296_9

					if var_296_9 + var_296_4 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_9 + var_296_4
					end
				end

				arg_293_1.text_.text = var_296_7
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305071", "story_v_side_new_1109305.awb") ~= 0 then
					local var_296_10 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305071", "story_v_side_new_1109305.awb") / 1000

					if var_296_10 + var_296_4 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_10 + var_296_4
					end

					if var_296_6.prefab_name ~= "" and arg_293_1.actors_[var_296_6.prefab_name] ~= nil then
						local var_296_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_6.prefab_name].transform, "story_v_side_new_1109305", "1109305071", "story_v_side_new_1109305.awb")

						arg_293_1:RecordAudio("1109305071", var_296_11)
						arg_293_1:RecordAudio("1109305071", var_296_11)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305071", "story_v_side_new_1109305.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305071", "story_v_side_new_1109305.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_12 = math.max(var_296_5, arg_293_1.talkMaxDuration)

			if var_296_4 <= arg_293_1.time_ and arg_293_1.time_ < var_296_4 + var_296_12 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_4) / var_296_12

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_4 + var_296_12 and arg_293_1.time_ < var_296_4 + var_296_12 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
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

		arg_293_1:InitPlayNodeList()
	end,
	Play1109305072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 1109305072
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play1109305073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(arg_297_1.actors_["1093ui_story"]) and arg_297_1.var_.characterEffect1093ui_story == nil then
				arg_297_1.var_.characterEffect1093ui_story = arg_297_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_0 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 and not isNil(arg_297_1.actors_["1093ui_story"]) then
				if arg_297_1.var_.characterEffect1093ui_story and not isNil(arg_297_1.actors_["1093ui_story"]) then
					arg_297_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_297_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_297_1.time_ - 0) / var_300_0)
				end
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 and not isNil(arg_297_1.actors_["1093ui_story"]) and arg_297_1.var_.characterEffect1093ui_story then
				arg_297_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_297_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_300_1 = 0
			local var_300_2 = 0.775

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

				local var_300_3 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(1109305072).content)

				arg_297_1.text_.text = var_300_3

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_5 = 31 <= 0 and var_300_2 or var_300_2 * (utf8.len(var_300_3) / 31)

				if (31 <= 0 and var_300_2 or var_300_2 * (utf8.len(var_300_3) / 31)) > 0 and var_300_2 < var_300_5 then
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
	Play1109305073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 1109305073
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play1109305074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:AudioAction("play", "effect", "se_story_side_1093", "se_story_side_1093_noogies", "")
			end

			local var_304_1 = 0
			local var_304_2 = 0.575

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_3 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(1109305073).content)

				arg_301_1.text_.text = var_304_3

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_5 = 23 <= 0 and var_304_2 or var_304_2 * (utf8.len(var_304_3) / 23)

				if (23 <= 0 and var_304_2 or var_304_2 * (utf8.len(var_304_3) / 23)) > 0 and var_304_2 < var_304_5 then
					arg_301_1.talkMaxDuration = var_304_5

					if var_304_5 + var_304_1 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_5 + var_304_1
					end
				end

				arg_301_1.text_.text = var_304_3
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_6 = math.max(var_304_2, arg_301_1.talkMaxDuration)

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_6 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_1) / var_304_6

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_1 + var_304_6 and arg_301_1.time_ < var_304_1 + var_304_6 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play1109305074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 1109305074
		arg_305_1.duration_ = 2.73

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play1109305075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.var_.moveOldPos1093ui_story = arg_305_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_308_0 = 0.001

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 then
				arg_305_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_305_1.time_ - 0) / var_308_0)
				arg_305_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_305_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1093ui_story"].transform.position).z)
				arg_305_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_305_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_305_1.actors_["1093ui_story"].transform.localEulerAngles = arg_305_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 then
				arg_305_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_305_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_305_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1093ui_story"].transform.position).z)
				arg_305_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_305_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_305_1.actors_["1093ui_story"].transform.localEulerAngles = arg_305_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_308_1 = arg_305_1.actors_["1093ui_story"]

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(var_308_1) and arg_305_1.var_.characterEffect1093ui_story == nil then
				arg_305_1.var_.characterEffect1093ui_story = var_308_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_2 = 0.200000002980232

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_2 and not isNil(var_308_1) then
				if arg_305_1.var_.characterEffect1093ui_story and not isNil(var_308_1) then
					arg_305_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_305_1.time_ >= 0 + var_308_2 and arg_305_1.time_ < 0 + var_308_2 + arg_308_0 and not isNil(var_308_1) and arg_305_1.var_.characterEffect1093ui_story then
				arg_305_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action7_2")
			end

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_308_4 = 0
			local var_308_5 = 0.25

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_4 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_6 = arg_305_1:GetWordFromCfg(1109305074)
				local var_308_7 = arg_305_1:FormatText(var_308_6.content)

				arg_305_1.text_.text = var_308_7

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_9 = 10 <= 0 and var_308_5 or var_308_5 * (utf8.len(var_308_7) / 10)

				if (10 <= 0 and var_308_5 or var_308_5 * (utf8.len(var_308_7) / 10)) > 0 and var_308_5 < var_308_9 then
					arg_305_1.talkMaxDuration = var_308_9

					if var_308_9 + var_308_4 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_9 + var_308_4
					end
				end

				arg_305_1.text_.text = var_308_7
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305074", "story_v_side_new_1109305.awb") ~= 0 then
					local var_308_10 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305074", "story_v_side_new_1109305.awb") / 1000

					if var_308_10 + var_308_4 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_10 + var_308_4
					end

					if var_308_6.prefab_name ~= "" and arg_305_1.actors_[var_308_6.prefab_name] ~= nil then
						local var_308_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_6.prefab_name].transform, "story_v_side_new_1109305", "1109305074", "story_v_side_new_1109305.awb")

						arg_305_1:RecordAudio("1109305074", var_308_11)
						arg_305_1:RecordAudio("1109305074", var_308_11)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305074", "story_v_side_new_1109305.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305074", "story_v_side_new_1109305.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_12 = math.max(var_308_5, arg_305_1.talkMaxDuration)

			if var_308_4 <= arg_305_1.time_ and arg_305_1.time_ < var_308_4 + var_308_12 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_4) / var_308_12

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_4 + var_308_12 and arg_305_1.time_ < var_308_4 + var_308_12 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
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

		arg_305_1:InitPlayNodeList()
	end,
	Play1109305075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 1109305075
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play1109305076(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(arg_309_1.actors_["1093ui_story"]) and arg_309_1.var_.characterEffect1093ui_story == nil then
				arg_309_1.var_.characterEffect1093ui_story = arg_309_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_0 = 0.200000002980232

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 and not isNil(arg_309_1.actors_["1093ui_story"]) then
				if arg_309_1.var_.characterEffect1093ui_story and not isNil(arg_309_1.actors_["1093ui_story"]) then
					arg_309_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_309_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_309_1.time_ - 0) / var_312_0)
				end
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 and not isNil(arg_309_1.actors_["1093ui_story"]) and arg_309_1.var_.characterEffect1093ui_story then
				arg_309_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_309_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_312_1 = 0
			local var_312_2 = 0.4

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[7].name)

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

				local var_312_3 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(1109305075).content)

				arg_309_1.text_.text = var_312_3

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_5 = 16 <= 0 and var_312_2 or var_312_2 * (utf8.len(var_312_3) / 16)

				if (16 <= 0 and var_312_2 or var_312_2 * (utf8.len(var_312_3) / 16)) > 0 and var_312_2 < var_312_5 then
					arg_309_1.talkMaxDuration = var_312_5

					if var_312_5 + var_312_1 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_5 + var_312_1
					end
				end

				arg_309_1.text_.text = var_312_3
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_6 = math.max(var_312_2, arg_309_1.talkMaxDuration)

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_6 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_1) / var_312_6

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_1 + var_312_6 and arg_309_1.time_ < var_312_1 + var_312_6 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play1109305076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 1109305076
		arg_313_1.duration_ = 4.47

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play1109305077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(arg_313_1.actors_["1093ui_story"]) and arg_313_1.var_.characterEffect1093ui_story == nil then
				arg_313_1.var_.characterEffect1093ui_story = arg_313_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_0 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 and not isNil(arg_313_1.actors_["1093ui_story"]) then
				if arg_313_1.var_.characterEffect1093ui_story and not isNil(arg_313_1.actors_["1093ui_story"]) then
					arg_313_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 and not isNil(arg_313_1.actors_["1093ui_story"]) and arg_313_1.var_.characterEffect1093ui_story then
				arg_313_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_316_2 = 0
			local var_316_3 = 0.45

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_2 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_4 = arg_313_1:GetWordFromCfg(1109305076)
				local var_316_5 = arg_313_1:FormatText(var_316_4.content)

				arg_313_1.text_.text = var_316_5

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_7 = 18 <= 0 and var_316_3 or var_316_3 * (utf8.len(var_316_5) / 18)

				if (18 <= 0 and var_316_3 or var_316_3 * (utf8.len(var_316_5) / 18)) > 0 and var_316_3 < var_316_7 then
					arg_313_1.talkMaxDuration = var_316_7

					if var_316_7 + var_316_2 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_7 + var_316_2
					end
				end

				arg_313_1.text_.text = var_316_5
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305076", "story_v_side_new_1109305.awb") ~= 0 then
					local var_316_8 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305076", "story_v_side_new_1109305.awb") / 1000

					if var_316_8 + var_316_2 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_8 + var_316_2
					end

					if var_316_4.prefab_name ~= "" and arg_313_1.actors_[var_316_4.prefab_name] ~= nil then
						local var_316_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_4.prefab_name].transform, "story_v_side_new_1109305", "1109305076", "story_v_side_new_1109305.awb")

						arg_313_1:RecordAudio("1109305076", var_316_9)
						arg_313_1:RecordAudio("1109305076", var_316_9)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305076", "story_v_side_new_1109305.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305076", "story_v_side_new_1109305.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_10 = math.max(var_316_3, arg_313_1.talkMaxDuration)

			if var_316_2 <= arg_313_1.time_ and arg_313_1.time_ < var_316_2 + var_316_10 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_2) / var_316_10

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_2 + var_316_10 and arg_313_1.time_ < var_316_2 + var_316_10 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play1109305077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 1109305077
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play1109305078(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(arg_317_1.actors_["1093ui_story"]) and arg_317_1.var_.characterEffect1093ui_story == nil then
				arg_317_1.var_.characterEffect1093ui_story = arg_317_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_0 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 and not isNil(arg_317_1.actors_["1093ui_story"]) then
				if arg_317_1.var_.characterEffect1093ui_story and not isNil(arg_317_1.actors_["1093ui_story"]) then
					arg_317_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_317_1.time_ - 0) / var_320_0)
				end
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 and not isNil(arg_317_1.actors_["1093ui_story"]) and arg_317_1.var_.characterEffect1093ui_story then
				arg_317_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_320_1 = 0
			local var_320_2 = 0.275

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[7].name)

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

				local var_320_3 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(1109305077).content)

				arg_317_1.text_.text = var_320_3

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_5 = 9 <= 0 and var_320_2 or var_320_2 * (utf8.len(var_320_3) / 9)

				if (9 <= 0 and var_320_2 or var_320_2 * (utf8.len(var_320_3) / 9)) > 0 and var_320_2 < var_320_5 then
					arg_317_1.talkMaxDuration = var_320_5

					if var_320_5 + var_320_1 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_5 + var_320_1
					end
				end

				arg_317_1.text_.text = var_320_3
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_6 = math.max(var_320_2, arg_317_1.talkMaxDuration)

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_6 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_1) / var_320_6

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_1 + var_320_6 and arg_317_1.time_ < var_320_1 + var_320_6 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play1109305078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 1109305078
		arg_321_1.duration_ = 4.3

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play1109305079(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos1093ui_story = arg_321_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_324_0 = 0.001

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 then
				arg_321_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_321_1.time_ - 0) / var_324_0)
				arg_321_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1093ui_story"].transform.position).z)
				arg_321_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["1093ui_story"].transform.localEulerAngles = arg_321_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 then
				arg_321_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_321_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1093ui_story"].transform.position).z)
				arg_321_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["1093ui_story"].transform.localEulerAngles = arg_321_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_324_1 = arg_321_1.actors_["1093ui_story"]

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(var_324_1) and arg_321_1.var_.characterEffect1093ui_story == nil then
				arg_321_1.var_.characterEffect1093ui_story = var_324_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_2 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_2 and not isNil(var_324_1) then
				if arg_321_1.var_.characterEffect1093ui_story and not isNil(var_324_1) then
					arg_321_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= 0 + var_324_2 and arg_321_1.time_ < 0 + var_324_2 + arg_324_0 and not isNil(var_324_1) and arg_321_1.var_.characterEffect1093ui_story then
				arg_321_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_324_4 = 0
			local var_324_5 = 0.5

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_4 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_6 = arg_321_1:GetWordFromCfg(1109305078)
				local var_324_7 = arg_321_1:FormatText(var_324_6.content)

				arg_321_1.text_.text = var_324_7

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_9 = 20 <= 0 and var_324_5 or var_324_5 * (utf8.len(var_324_7) / 20)

				if (20 <= 0 and var_324_5 or var_324_5 * (utf8.len(var_324_7) / 20)) > 0 and var_324_5 < var_324_9 then
					arg_321_1.talkMaxDuration = var_324_9

					if var_324_9 + var_324_4 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_9 + var_324_4
					end
				end

				arg_321_1.text_.text = var_324_7
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305078", "story_v_side_new_1109305.awb") ~= 0 then
					local var_324_10 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305078", "story_v_side_new_1109305.awb") / 1000

					if var_324_10 + var_324_4 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_10 + var_324_4
					end

					if var_324_6.prefab_name ~= "" and arg_321_1.actors_[var_324_6.prefab_name] ~= nil then
						local var_324_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_6.prefab_name].transform, "story_v_side_new_1109305", "1109305078", "story_v_side_new_1109305.awb")

						arg_321_1:RecordAudio("1109305078", var_324_11)
						arg_321_1:RecordAudio("1109305078", var_324_11)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305078", "story_v_side_new_1109305.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305078", "story_v_side_new_1109305.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_12 = math.max(var_324_5, arg_321_1.talkMaxDuration)

			if var_324_4 <= arg_321_1.time_ and arg_321_1.time_ < var_324_4 + var_324_12 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_4) / var_324_12

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_4 + var_324_12 and arg_321_1.time_ < var_324_4 + var_324_12 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
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

		arg_321_1:InitPlayNodeList()
	end,
	Play1109305079 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 1109305079
		arg_325_1.duration_ = 0.77

		SetActive(arg_325_1.tipsGo_, true)

		arg_325_1.tipsText_.text = StoryTipsCfg[109301].name

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"

			SetActive(arg_325_1.choicesGo_, true)

			for iter_326_0, iter_326_1 in ipairs(arg_325_1.choices_) do
				SetActive(iter_326_1.go, iter_326_0 <= 2)
			end

			arg_325_1.choices_[1].txt.text = arg_325_1:FormatText(StoryChoiceCfg[1031].name)
			arg_325_1.choices_[2].txt.text = arg_325_1:FormatText(StoryChoiceCfg[1032].name)
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play1109305080(arg_325_1)
			end

			if arg_327_0 == 2 then
				PlayerAction.UseStoryTrigger(1093012, 210930105, 1109305079, 2)
				arg_325_0:Play1109305082(arg_325_1)
			end

			arg_325_1:RecordChoiceLog(1109305079, 1031, 1032)
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(arg_325_1.actors_["1093ui_story"]) and arg_325_1.var_.characterEffect1093ui_story == nil then
				arg_325_1.var_.characterEffect1093ui_story = arg_325_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_0 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 and not isNil(arg_325_1.actors_["1093ui_story"]) then
				if arg_325_1.var_.characterEffect1093ui_story and not isNil(arg_325_1.actors_["1093ui_story"]) then
					arg_325_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_325_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_325_1.time_ - 0) / var_328_0)
				end
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 and not isNil(arg_325_1.actors_["1093ui_story"]) and arg_325_1.var_.characterEffect1093ui_story then
				arg_325_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_325_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play1109305080 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 1109305080
		arg_329_1.duration_ = 3.97

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play1109305081(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos1093ui_story = arg_329_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_332_0 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 then
				arg_329_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_329_1.time_ - 0) / var_332_0)
				arg_329_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1093ui_story"].transform.position).z)
				arg_329_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1093ui_story"].transform.localEulerAngles = arg_329_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 then
				arg_329_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_329_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1093ui_story"].transform.position).z)
				arg_329_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1093ui_story"].transform.localEulerAngles = arg_329_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_332_1 = arg_329_1.actors_["1093ui_story"]

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(var_332_1) and arg_329_1.var_.characterEffect1093ui_story == nil then
				arg_329_1.var_.characterEffect1093ui_story = var_332_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_2 = 0.200000002980232

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_2 and not isNil(var_332_1) then
				if arg_329_1.var_.characterEffect1093ui_story and not isNil(var_332_1) then
					arg_329_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= 0 + var_332_2 and arg_329_1.time_ < 0 + var_332_2 + arg_332_0 and not isNil(var_332_1) and arg_329_1.var_.characterEffect1093ui_story then
				arg_329_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_332_4 = 0
			local var_332_5 = 0.45

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_4 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_6 = arg_329_1:GetWordFromCfg(1109305080)
				local var_332_7 = arg_329_1:FormatText(var_332_6.content)

				arg_329_1.text_.text = var_332_7

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_9 = 18 <= 0 and var_332_5 or var_332_5 * (utf8.len(var_332_7) / 18)

				if (18 <= 0 and var_332_5 or var_332_5 * (utf8.len(var_332_7) / 18)) > 0 and var_332_5 < var_332_9 then
					arg_329_1.talkMaxDuration = var_332_9

					if var_332_9 + var_332_4 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_9 + var_332_4
					end
				end

				arg_329_1.text_.text = var_332_7
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305080", "story_v_side_new_1109305.awb") ~= 0 then
					local var_332_10 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305080", "story_v_side_new_1109305.awb") / 1000

					if var_332_10 + var_332_4 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_10 + var_332_4
					end

					if var_332_6.prefab_name ~= "" and arg_329_1.actors_[var_332_6.prefab_name] ~= nil then
						local var_332_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_6.prefab_name].transform, "story_v_side_new_1109305", "1109305080", "story_v_side_new_1109305.awb")

						arg_329_1:RecordAudio("1109305080", var_332_11)
						arg_329_1:RecordAudio("1109305080", var_332_11)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305080", "story_v_side_new_1109305.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305080", "story_v_side_new_1109305.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_12 = math.max(var_332_5, arg_329_1.talkMaxDuration)

			if var_332_4 <= arg_329_1.time_ and arg_329_1.time_ < var_332_4 + var_332_12 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_4) / var_332_12

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_4 + var_332_12 and arg_329_1.time_ < var_332_4 + var_332_12 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
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

		arg_329_1:InitPlayNodeList()
	end,
	Play1109305081 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 1109305081
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play1109305088(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(arg_333_1.actors_["1093ui_story"]) and arg_333_1.var_.characterEffect1093ui_story == nil then
				arg_333_1.var_.characterEffect1093ui_story = arg_333_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_0 = 0.200000002980232

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 and not isNil(arg_333_1.actors_["1093ui_story"]) then
				if arg_333_1.var_.characterEffect1093ui_story and not isNil(arg_333_1.actors_["1093ui_story"]) then
					arg_333_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_333_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_333_1.time_ - 0) / var_336_0)
				end
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 and not isNil(arg_333_1.actors_["1093ui_story"]) and arg_333_1.var_.characterEffect1093ui_story then
				arg_333_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_333_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_336_1 = 0
			local var_336_2 = 0.325

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
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

				local var_336_3 = arg_333_1:FormatText(arg_333_1:GetWordFromCfg(1109305081).content)

				arg_333_1.text_.text = var_336_3

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_5 = 13 <= 0 and var_336_2 or var_336_2 * (utf8.len(var_336_3) / 13)

				if (13 <= 0 and var_336_2 or var_336_2 * (utf8.len(var_336_3) / 13)) > 0 and var_336_2 < var_336_5 then
					arg_333_1.talkMaxDuration = var_336_5

					if var_336_5 + var_336_1 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_5 + var_336_1
					end
				end

				arg_333_1.text_.text = var_336_3
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_6 = math.max(var_336_2, arg_333_1.talkMaxDuration)

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_6 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_1) / var_336_6

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_1 + var_336_6 and arg_333_1.time_ < var_336_1 + var_336_6 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play1109305088 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 1109305088
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play1109305089(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.var_.moveOldPos1093ui_story = arg_337_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_340_0 = 0.001

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 then
				arg_337_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_337_1.time_ - 0) / var_340_0)
				arg_337_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_337_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1093ui_story"].transform.position).z)
				arg_337_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_337_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_337_1.actors_["1093ui_story"].transform.localEulerAngles = arg_337_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 then
				arg_337_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_337_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_337_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1093ui_story"].transform.position).z)
				arg_337_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_337_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_337_1.actors_["1093ui_story"].transform.localEulerAngles = arg_337_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_340_1 = arg_337_1.actors_["1093ui_story"]

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(var_340_1) and arg_337_1.var_.characterEffect1093ui_story == nil then
				arg_337_1.var_.characterEffect1093ui_story = var_340_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_2 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_2 and not isNil(var_340_1) then
				if arg_337_1.var_.characterEffect1093ui_story and not isNil(var_340_1) then
					arg_337_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_337_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_337_1.time_ - 0) / var_340_2)
				end
			end

			if arg_337_1.time_ >= 0 + var_340_2 and arg_337_1.time_ < 0 + var_340_2 + arg_340_0 and not isNil(var_340_1) and arg_337_1.var_.characterEffect1093ui_story then
				arg_337_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_337_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_340_3 = 0
			local var_340_4 = 0.85

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_3 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, false)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_5 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(1109305088).content)

				arg_337_1.text_.text = var_340_5

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_7 = 34 <= 0 and var_340_4 or var_340_4 * (utf8.len(var_340_5) / 34)

				if (34 <= 0 and var_340_4 or var_340_4 * (utf8.len(var_340_5) / 34)) > 0 and var_340_4 < var_340_7 then
					arg_337_1.talkMaxDuration = var_340_7

					if var_340_7 + var_340_3 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_7 + var_340_3
					end
				end

				arg_337_1.text_.text = var_340_5
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_8 = math.max(var_340_4, arg_337_1.talkMaxDuration)

			if var_340_3 <= arg_337_1.time_ and arg_337_1.time_ < var_340_3 + var_340_8 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_3) / var_340_8

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_3 + var_340_8 and arg_337_1.time_ < var_340_3 + var_340_8 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
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

		arg_337_1:InitPlayNodeList()
	end,
	Play1109305089 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 1109305089
		arg_341_1.duration_ = 8.63

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play1109305090(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos1093ui_story = arg_341_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_344_0 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 then
				arg_341_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_341_1.time_ - 0) / var_344_0)
				arg_341_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1093ui_story"].transform.position).z)
				arg_341_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1093ui_story"].transform.localEulerAngles = arg_341_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 then
				arg_341_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_341_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1093ui_story"].transform.position).z)
				arg_341_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1093ui_story"].transform.localEulerAngles = arg_341_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_344_1 = arg_341_1.actors_["1093ui_story"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1093ui_story == nil then
				arg_341_1.var_.characterEffect1093ui_story = var_344_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_2 = 0.200000002980232

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_2 and not isNil(var_344_1) then
				if arg_341_1.var_.characterEffect1093ui_story and not isNil(var_344_1) then
					arg_341_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= 0 + var_344_2 and arg_341_1.time_ < 0 + var_344_2 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1093ui_story then
				arg_341_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_2")
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_344_4 = 0
			local var_344_5 = 0.9

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_4 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_6 = arg_341_1:GetWordFromCfg(1109305089)
				local var_344_7 = arg_341_1:FormatText(var_344_6.content)

				arg_341_1.text_.text = var_344_7

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_9 = 36 <= 0 and var_344_5 or var_344_5 * (utf8.len(var_344_7) / 36)

				if (36 <= 0 and var_344_5 or var_344_5 * (utf8.len(var_344_7) / 36)) > 0 and var_344_5 < var_344_9 then
					arg_341_1.talkMaxDuration = var_344_9

					if var_344_9 + var_344_4 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_9 + var_344_4
					end
				end

				arg_341_1.text_.text = var_344_7
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305089", "story_v_side_new_1109305.awb") ~= 0 then
					local var_344_10 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305089", "story_v_side_new_1109305.awb") / 1000

					if var_344_10 + var_344_4 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_10 + var_344_4
					end

					if var_344_6.prefab_name ~= "" and arg_341_1.actors_[var_344_6.prefab_name] ~= nil then
						local var_344_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_6.prefab_name].transform, "story_v_side_new_1109305", "1109305089", "story_v_side_new_1109305.awb")

						arg_341_1:RecordAudio("1109305089", var_344_11)
						arg_341_1:RecordAudio("1109305089", var_344_11)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305089", "story_v_side_new_1109305.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305089", "story_v_side_new_1109305.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_12 = math.max(var_344_5, arg_341_1.talkMaxDuration)

			if var_344_4 <= arg_341_1.time_ and arg_341_1.time_ < var_344_4 + var_344_12 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_4) / var_344_12

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_4 + var_344_12 and arg_341_1.time_ < var_344_4 + var_344_12 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
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

		arg_341_1:InitPlayNodeList()
	end,
	Play1109305090 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 1109305090
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play1109305091(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(arg_345_1.actors_["1093ui_story"]) and arg_345_1.var_.characterEffect1093ui_story == nil then
				arg_345_1.var_.characterEffect1093ui_story = arg_345_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_0 = 0.200000002980232

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 and not isNil(arg_345_1.actors_["1093ui_story"]) then
				if arg_345_1.var_.characterEffect1093ui_story and not isNil(arg_345_1.actors_["1093ui_story"]) then
					arg_345_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_345_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_345_1.time_ - 0) / var_348_0)
				end
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 and not isNil(arg_345_1.actors_["1093ui_story"]) and arg_345_1.var_.characterEffect1093ui_story then
				arg_345_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_345_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_348_1 = 0
			local var_348_2 = 0.225

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 then
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

				local var_348_3 = arg_345_1:FormatText(arg_345_1:GetWordFromCfg(1109305090).content)

				arg_345_1.text_.text = var_348_3

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_5 = 9 <= 0 and var_348_2 or var_348_2 * (utf8.len(var_348_3) / 9)

				if (9 <= 0 and var_348_2 or var_348_2 * (utf8.len(var_348_3) / 9)) > 0 and var_348_2 < var_348_5 then
					arg_345_1.talkMaxDuration = var_348_5

					if var_348_5 + var_348_1 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_5 + var_348_1
					end
				end

				arg_345_1.text_.text = var_348_3
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_6 = math.max(var_348_2, arg_345_1.talkMaxDuration)

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_6 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_1) / var_348_6

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_1 + var_348_6 and arg_345_1.time_ < var_348_1 + var_348_6 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play1109305091 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 1109305091
		arg_349_1.duration_ = 2

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play1109305092(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(arg_349_1.actors_["1093ui_story"]) and arg_349_1.var_.characterEffect1093ui_story == nil then
				arg_349_1.var_.characterEffect1093ui_story = arg_349_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_0 = 0.200000002980232

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 and not isNil(arg_349_1.actors_["1093ui_story"]) then
				if arg_349_1.var_.characterEffect1093ui_story and not isNil(arg_349_1.actors_["1093ui_story"]) then
					arg_349_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 and not isNil(arg_349_1.actors_["1093ui_story"]) and arg_349_1.var_.characterEffect1093ui_story then
				arg_349_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_352_2 = 0
			local var_352_3 = 0.175

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_2 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_4 = arg_349_1:GetWordFromCfg(1109305091)
				local var_352_5 = arg_349_1:FormatText(var_352_4.content)

				arg_349_1.text_.text = var_352_5

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_7 = 7 <= 0 and var_352_3 or var_352_3 * (utf8.len(var_352_5) / 7)

				if (7 <= 0 and var_352_3 or var_352_3 * (utf8.len(var_352_5) / 7)) > 0 and var_352_3 < var_352_7 then
					arg_349_1.talkMaxDuration = var_352_7

					if var_352_7 + var_352_2 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_7 + var_352_2
					end
				end

				arg_349_1.text_.text = var_352_5
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305091", "story_v_side_new_1109305.awb") ~= 0 then
					local var_352_8 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305091", "story_v_side_new_1109305.awb") / 1000

					if var_352_8 + var_352_2 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_8 + var_352_2
					end

					if var_352_4.prefab_name ~= "" and arg_349_1.actors_[var_352_4.prefab_name] ~= nil then
						local var_352_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_4.prefab_name].transform, "story_v_side_new_1109305", "1109305091", "story_v_side_new_1109305.awb")

						arg_349_1:RecordAudio("1109305091", var_352_9)
						arg_349_1:RecordAudio("1109305091", var_352_9)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305091", "story_v_side_new_1109305.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305091", "story_v_side_new_1109305.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_10 = math.max(var_352_3, arg_349_1.talkMaxDuration)

			if var_352_2 <= arg_349_1.time_ and arg_349_1.time_ < var_352_2 + var_352_10 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_2) / var_352_10

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_2 + var_352_10 and arg_349_1.time_ < var_352_2 + var_352_10 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play1109305092 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 1109305092
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play1109305093(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(arg_353_1.actors_["1093ui_story"]) and arg_353_1.var_.characterEffect1093ui_story == nil then
				arg_353_1.var_.characterEffect1093ui_story = arg_353_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_0 = 0.200000002980232

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 and not isNil(arg_353_1.actors_["1093ui_story"]) then
				if arg_353_1.var_.characterEffect1093ui_story and not isNil(arg_353_1.actors_["1093ui_story"]) then
					arg_353_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_353_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_353_1.time_ - 0) / var_356_0)
				end
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 and not isNil(arg_353_1.actors_["1093ui_story"]) and arg_353_1.var_.characterEffect1093ui_story then
				arg_353_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_353_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_356_1 = 0
			local var_356_2 = 0.4

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, true)
				arg_353_1.iconController_:SetSelectedState("hero")

				arg_353_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_353_1.callingController_:SetSelectedState("normal")

				arg_353_1.keyicon_.color = Color.New(1, 1, 1)
				arg_353_1.icon_.color = Color.New(1, 1, 1)

				local var_356_3 = arg_353_1:FormatText(arg_353_1:GetWordFromCfg(1109305092).content)

				arg_353_1.text_.text = var_356_3

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_5 = 16 <= 0 and var_356_2 or var_356_2 * (utf8.len(var_356_3) / 16)

				if (16 <= 0 and var_356_2 or var_356_2 * (utf8.len(var_356_3) / 16)) > 0 and var_356_2 < var_356_5 then
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
	Play1109305093 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 1109305093
		arg_357_1.duration_ = 2.63

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play1109305094(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.var_.moveOldPos1093ui_story = arg_357_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_360_0 = 0.001

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 then
				arg_357_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_357_1.time_ - 0) / var_360_0)
				arg_357_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1093ui_story"].transform.position).z)
				arg_357_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["1093ui_story"].transform.localEulerAngles = arg_357_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 then
				arg_357_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_357_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1093ui_story"].transform.position).z)
				arg_357_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["1093ui_story"].transform.localEulerAngles = arg_357_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_360_1 = arg_357_1.actors_["1093ui_story"]

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(var_360_1) and arg_357_1.var_.characterEffect1093ui_story == nil then
				arg_357_1.var_.characterEffect1093ui_story = var_360_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_2 = 0.200000002980232

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_2 and not isNil(var_360_1) then
				if arg_357_1.var_.characterEffect1093ui_story and not isNil(var_360_1) then
					arg_357_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= 0 + var_360_2 and arg_357_1.time_ < 0 + var_360_2 + arg_360_0 and not isNil(var_360_1) and arg_357_1.var_.characterEffect1093ui_story then
				arg_357_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_1")
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			if arg_357_1.frameCnt_ <= 1 then
				arg_357_1.dialog_:SetActive(false)
			end

			local var_360_4 = 0.433333333333333
			local var_360_5 = 0.375

			if 0.433333333333333 < arg_357_1.time_ and arg_357_1.time_ <= var_360_4 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0

				arg_357_1.dialog_:SetActive(true)

				arg_357_1.dialogCg_.alpha = 0

				local var_360_6 = LeanTween.value(arg_357_1.dialog_, 0, 1, 0.3)

				var_360_6:setOnUpdate(LuaHelper.FloatAction(function(arg_361_0)
					arg_357_1.dialogCg_.alpha = arg_361_0
				end))
				var_360_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_357_1.dialog_)
					var_360_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_357_1.duration_ = arg_357_1.duration_ + 0.3

				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_7 = arg_357_1:GetWordFromCfg(1109305093)
				local var_360_8 = arg_357_1:FormatText(var_360_7.content)

				arg_357_1.text_.text = var_360_8

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_10 = 15 <= 0 and var_360_5 or var_360_5 * (utf8.len(var_360_8) / 15)

				if (15 <= 0 and var_360_5 or var_360_5 * (utf8.len(var_360_8) / 15)) > 0 and var_360_5 < var_360_10 then
					arg_357_1.talkMaxDuration = var_360_10
					var_360_4 = var_360_4 + 0.3

					if var_360_10 + var_360_4 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_10 + var_360_4
					end
				end

				arg_357_1.text_.text = var_360_8
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305093", "story_v_side_new_1109305.awb") ~= 0 then
					local var_360_11 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305093", "story_v_side_new_1109305.awb") / 1000

					if var_360_11 + var_360_4 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_11 + var_360_4
					end

					if var_360_7.prefab_name ~= "" and arg_357_1.actors_[var_360_7.prefab_name] ~= nil then
						local var_360_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_7.prefab_name].transform, "story_v_side_new_1109305", "1109305093", "story_v_side_new_1109305.awb")

						arg_357_1:RecordAudio("1109305093", var_360_12)
						arg_357_1:RecordAudio("1109305093", var_360_12)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305093", "story_v_side_new_1109305.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305093", "story_v_side_new_1109305.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_13 = var_360_4 + 0.3
			local var_360_14 = math.max(var_360_5, arg_357_1.talkMaxDuration)

			if var_360_4 + 0.3 <= arg_357_1.time_ and arg_357_1.time_ < var_360_13 + var_360_14 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_13) / var_360_14

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_13 + var_360_14 and arg_357_1.time_ < var_360_13 + var_360_14 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
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

		arg_357_1:InitPlayNodeList()
	end,
	Play1109305094 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 1109305094
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play1109305095(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(arg_363_1.actors_["1093ui_story"]) and arg_363_1.var_.characterEffect1093ui_story == nil then
				arg_363_1.var_.characterEffect1093ui_story = arg_363_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_0 = 0.200000002980232

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_0 and not isNil(arg_363_1.actors_["1093ui_story"]) then
				if arg_363_1.var_.characterEffect1093ui_story and not isNil(arg_363_1.actors_["1093ui_story"]) then
					arg_363_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_363_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_363_1.time_ - 0) / var_366_0)
				end
			end

			if arg_363_1.time_ >= 0 + var_366_0 and arg_363_1.time_ < 0 + var_366_0 + arg_366_0 and not isNil(arg_363_1.actors_["1093ui_story"]) and arg_363_1.var_.characterEffect1093ui_story then
				arg_363_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_363_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_366_1 = 0
			local var_366_2 = 0.875

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, true)
				arg_363_1.iconController_:SetSelectedState("hero")

				arg_363_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_363_1.callingController_:SetSelectedState("normal")

				arg_363_1.keyicon_.color = Color.New(1, 1, 1)
				arg_363_1.icon_.color = Color.New(1, 1, 1)

				local var_366_3 = arg_363_1:FormatText(arg_363_1:GetWordFromCfg(1109305094).content)

				arg_363_1.text_.text = var_366_3

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_5 = 35 <= 0 and var_366_2 or var_366_2 * (utf8.len(var_366_3) / 35)

				if (35 <= 0 and var_366_2 or var_366_2 * (utf8.len(var_366_3) / 35)) > 0 and var_366_2 < var_366_5 then
					arg_363_1.talkMaxDuration = var_366_5

					if var_366_5 + var_366_1 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_5 + var_366_1
					end
				end

				arg_363_1.text_.text = var_366_3
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_6 = math.max(var_366_2, arg_363_1.talkMaxDuration)

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_6 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_1) / var_366_6

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_1 + var_366_6 and arg_363_1.time_ < var_366_1 + var_366_6 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play1109305095 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 1109305095
		arg_367_1.duration_ = 5.9

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play1109305096(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(arg_367_1.actors_["1093ui_story"]) and arg_367_1.var_.characterEffect1093ui_story == nil then
				arg_367_1.var_.characterEffect1093ui_story = arg_367_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_0 = 0.200000002980232

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_0 and not isNil(arg_367_1.actors_["1093ui_story"]) then
				if arg_367_1.var_.characterEffect1093ui_story and not isNil(arg_367_1.actors_["1093ui_story"]) then
					arg_367_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_367_1.time_ >= 0 + var_370_0 and arg_367_1.time_ < 0 + var_370_0 + arg_370_0 and not isNil(arg_367_1.actors_["1093ui_story"]) and arg_367_1.var_.characterEffect1093ui_story then
				arg_367_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_370_2 = 0
			local var_370_3 = 0.65

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_2 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_4 = arg_367_1:GetWordFromCfg(1109305095)
				local var_370_5 = arg_367_1:FormatText(var_370_4.content)

				arg_367_1.text_.text = var_370_5

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_7 = 26 <= 0 and var_370_3 or var_370_3 * (utf8.len(var_370_5) / 26)

				if (26 <= 0 and var_370_3 or var_370_3 * (utf8.len(var_370_5) / 26)) > 0 and var_370_3 < var_370_7 then
					arg_367_1.talkMaxDuration = var_370_7

					if var_370_7 + var_370_2 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_7 + var_370_2
					end
				end

				arg_367_1.text_.text = var_370_5
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305095", "story_v_side_new_1109305.awb") ~= 0 then
					local var_370_8 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305095", "story_v_side_new_1109305.awb") / 1000

					if var_370_8 + var_370_2 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_8 + var_370_2
					end

					if var_370_4.prefab_name ~= "" and arg_367_1.actors_[var_370_4.prefab_name] ~= nil then
						local var_370_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_4.prefab_name].transform, "story_v_side_new_1109305", "1109305095", "story_v_side_new_1109305.awb")

						arg_367_1:RecordAudio("1109305095", var_370_9)
						arg_367_1:RecordAudio("1109305095", var_370_9)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305095", "story_v_side_new_1109305.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305095", "story_v_side_new_1109305.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_10 = math.max(var_370_3, arg_367_1.talkMaxDuration)

			if var_370_2 <= arg_367_1.time_ and arg_367_1.time_ < var_370_2 + var_370_10 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_2) / var_370_10

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_2 + var_370_10 and arg_367_1.time_ < var_370_2 + var_370_10 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play1109305096 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 1109305096
		arg_371_1.duration_ = 3.53

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play1109305097(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 0.425

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_1 = arg_371_1:GetWordFromCfg(1109305096)
				local var_374_2 = arg_371_1:FormatText(var_374_1.content)

				arg_371_1.text_.text = var_374_2

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_4 = 17 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_2) / 17)

				if (17 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_2) / 17)) > 0 and var_374_0 < var_374_4 then
					arg_371_1.talkMaxDuration = var_374_4

					if var_374_4 + 0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_4 + 0
					end
				end

				arg_371_1.text_.text = var_374_2
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305096", "story_v_side_new_1109305.awb") ~= 0 then
					local var_374_5 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305096", "story_v_side_new_1109305.awb") / 1000

					if var_374_5 + 0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_5 + 0
					end

					if var_374_1.prefab_name ~= "" and arg_371_1.actors_[var_374_1.prefab_name] ~= nil then
						local var_374_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_1.prefab_name].transform, "story_v_side_new_1109305", "1109305096", "story_v_side_new_1109305.awb")

						arg_371_1:RecordAudio("1109305096", var_374_6)
						arg_371_1:RecordAudio("1109305096", var_374_6)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305096", "story_v_side_new_1109305.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305096", "story_v_side_new_1109305.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_7 = math.max(var_374_0, arg_371_1.talkMaxDuration)

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_7 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - 0) / var_374_7

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= 0 + var_374_7 and arg_371_1.time_ < 0 + var_374_7 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play1109305097 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 1109305097
		arg_375_1.duration_ = 5

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play1109305098(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(arg_375_1.actors_["1093ui_story"]) and arg_375_1.var_.characterEffect1093ui_story == nil then
				arg_375_1.var_.characterEffect1093ui_story = arg_375_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_0 = 0.200000002980232

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_0 and not isNil(arg_375_1.actors_["1093ui_story"]) then
				if arg_375_1.var_.characterEffect1093ui_story and not isNil(arg_375_1.actors_["1093ui_story"]) then
					arg_375_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_375_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_375_1.time_ - 0) / var_378_0)
				end
			end

			if arg_375_1.time_ >= 0 + var_378_0 and arg_375_1.time_ < 0 + var_378_0 + arg_378_0 and not isNil(arg_375_1.actors_["1093ui_story"]) and arg_375_1.var_.characterEffect1093ui_story then
				arg_375_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_375_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_378_1 = 0
			local var_378_2 = 0.25

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, true)
				arg_375_1.iconController_:SetSelectedState("hero")

				arg_375_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_375_1.callingController_:SetSelectedState("normal")

				arg_375_1.keyicon_.color = Color.New(1, 1, 1)
				arg_375_1.icon_.color = Color.New(1, 1, 1)

				local var_378_3 = arg_375_1:FormatText(arg_375_1:GetWordFromCfg(1109305097).content)

				arg_375_1.text_.text = var_378_3

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_5 = 10 <= 0 and var_378_2 or var_378_2 * (utf8.len(var_378_3) / 10)

				if (10 <= 0 and var_378_2 or var_378_2 * (utf8.len(var_378_3) / 10)) > 0 and var_378_2 < var_378_5 then
					arg_375_1.talkMaxDuration = var_378_5

					if var_378_5 + var_378_1 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_5 + var_378_1
					end
				end

				arg_375_1.text_.text = var_378_3
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_6 = math.max(var_378_2, arg_375_1.talkMaxDuration)

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_6 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_1) / var_378_6

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_1 + var_378_6 and arg_375_1.time_ < var_378_1 + var_378_6 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play1109305098 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 1109305098
		arg_379_1.duration_ = 6.13

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play1109305099(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.var_.moveOldPos1093ui_story = arg_379_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_382_0 = 0.001

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_0 then
				arg_379_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_379_1.time_ - 0) / var_382_0)
				arg_379_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_379_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1093ui_story"].transform.position).z)
				arg_379_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_379_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_379_1.actors_["1093ui_story"].transform.localEulerAngles = arg_379_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_379_1.time_ >= 0 + var_382_0 and arg_379_1.time_ < 0 + var_382_0 + arg_382_0 then
				arg_379_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_379_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_379_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1093ui_story"].transform.position).z)
				arg_379_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_379_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_379_1.actors_["1093ui_story"].transform.localEulerAngles = arg_379_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_382_1 = arg_379_1.actors_["1093ui_story"]

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(var_382_1) and arg_379_1.var_.characterEffect1093ui_story == nil then
				arg_379_1.var_.characterEffect1093ui_story = var_382_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_2 = 0.200000002980232

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_2 and not isNil(var_382_1) then
				if arg_379_1.var_.characterEffect1093ui_story and not isNil(var_382_1) then
					arg_379_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= 0 + var_382_2 and arg_379_1.time_ < 0 + var_382_2 + arg_382_0 and not isNil(var_382_1) and arg_379_1.var_.characterEffect1093ui_story then
				arg_379_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_2")
			end

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_382_4 = 0
			local var_382_5 = 0.525

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_4 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_6 = arg_379_1:GetWordFromCfg(1109305098)
				local var_382_7 = arg_379_1:FormatText(var_382_6.content)

				arg_379_1.text_.text = var_382_7

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_9 = 21 <= 0 and var_382_5 or var_382_5 * (utf8.len(var_382_7) / 21)

				if (21 <= 0 and var_382_5 or var_382_5 * (utf8.len(var_382_7) / 21)) > 0 and var_382_5 < var_382_9 then
					arg_379_1.talkMaxDuration = var_382_9

					if var_382_9 + var_382_4 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_9 + var_382_4
					end
				end

				arg_379_1.text_.text = var_382_7
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305098", "story_v_side_new_1109305.awb") ~= 0 then
					local var_382_10 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305098", "story_v_side_new_1109305.awb") / 1000

					if var_382_10 + var_382_4 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_10 + var_382_4
					end

					if var_382_6.prefab_name ~= "" and arg_379_1.actors_[var_382_6.prefab_name] ~= nil then
						local var_382_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_6.prefab_name].transform, "story_v_side_new_1109305", "1109305098", "story_v_side_new_1109305.awb")

						arg_379_1:RecordAudio("1109305098", var_382_11)
						arg_379_1:RecordAudio("1109305098", var_382_11)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305098", "story_v_side_new_1109305.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305098", "story_v_side_new_1109305.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_12 = math.max(var_382_5, arg_379_1.talkMaxDuration)

			if var_382_4 <= arg_379_1.time_ and arg_379_1.time_ < var_382_4 + var_382_12 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_4) / var_382_12

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_4 + var_382_12 and arg_379_1.time_ < var_382_4 + var_382_12 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
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

		arg_379_1:InitPlayNodeList()
	end,
	Play1109305099 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 1109305099
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play1109305100(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(arg_383_1.actors_["1093ui_story"]) and arg_383_1.var_.characterEffect1093ui_story == nil then
				arg_383_1.var_.characterEffect1093ui_story = arg_383_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_0 = 0.200000002980232

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_0 and not isNil(arg_383_1.actors_["1093ui_story"]) then
				if arg_383_1.var_.characterEffect1093ui_story and not isNil(arg_383_1.actors_["1093ui_story"]) then
					arg_383_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_383_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_383_1.time_ - 0) / var_386_0)
				end
			end

			if arg_383_1.time_ >= 0 + var_386_0 and arg_383_1.time_ < 0 + var_386_0 + arg_386_0 and not isNil(arg_383_1.actors_["1093ui_story"]) and arg_383_1.var_.characterEffect1093ui_story then
				arg_383_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_383_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_386_1 = 0
			local var_386_2 = 0.275

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, true)
				arg_383_1.iconController_:SetSelectedState("hero")

				arg_383_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_383_1.callingController_:SetSelectedState("normal")

				arg_383_1.keyicon_.color = Color.New(1, 1, 1)
				arg_383_1.icon_.color = Color.New(1, 1, 1)

				local var_386_3 = arg_383_1:FormatText(arg_383_1:GetWordFromCfg(1109305099).content)

				arg_383_1.text_.text = var_386_3

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_5 = 11 <= 0 and var_386_2 or var_386_2 * (utf8.len(var_386_3) / 11)

				if (11 <= 0 and var_386_2 or var_386_2 * (utf8.len(var_386_3) / 11)) > 0 and var_386_2 < var_386_5 then
					arg_383_1.talkMaxDuration = var_386_5

					if var_386_5 + var_386_1 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_5 + var_386_1
					end
				end

				arg_383_1.text_.text = var_386_3
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_6 = math.max(var_386_2, arg_383_1.talkMaxDuration)

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_6 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_1) / var_386_6

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_1 + var_386_6 and arg_383_1.time_ < var_386_1 + var_386_6 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play1109305100 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 1109305100
		arg_387_1.duration_ = 6.17

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play1109305101(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(arg_387_1.actors_["1093ui_story"]) and arg_387_1.var_.characterEffect1093ui_story == nil then
				arg_387_1.var_.characterEffect1093ui_story = arg_387_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_0 = 0.200000002980232

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_0 and not isNil(arg_387_1.actors_["1093ui_story"]) then
				if arg_387_1.var_.characterEffect1093ui_story and not isNil(arg_387_1.actors_["1093ui_story"]) then
					arg_387_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_387_1.time_ >= 0 + var_390_0 and arg_387_1.time_ < 0 + var_390_0 + arg_390_0 and not isNil(arg_387_1.actors_["1093ui_story"]) and arg_387_1.var_.characterEffect1093ui_story then
				arg_387_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_390_2 = 0
			local var_390_3 = 0.65

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_2 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_4 = arg_387_1:GetWordFromCfg(1109305100)
				local var_390_5 = arg_387_1:FormatText(var_390_4.content)

				arg_387_1.text_.text = var_390_5

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_7 = 26 <= 0 and var_390_3 or var_390_3 * (utf8.len(var_390_5) / 26)

				if (26 <= 0 and var_390_3 or var_390_3 * (utf8.len(var_390_5) / 26)) > 0 and var_390_3 < var_390_7 then
					arg_387_1.talkMaxDuration = var_390_7

					if var_390_7 + var_390_2 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_7 + var_390_2
					end
				end

				arg_387_1.text_.text = var_390_5
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305100", "story_v_side_new_1109305.awb") ~= 0 then
					local var_390_8 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305100", "story_v_side_new_1109305.awb") / 1000

					if var_390_8 + var_390_2 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_8 + var_390_2
					end

					if var_390_4.prefab_name ~= "" and arg_387_1.actors_[var_390_4.prefab_name] ~= nil then
						local var_390_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_4.prefab_name].transform, "story_v_side_new_1109305", "1109305100", "story_v_side_new_1109305.awb")

						arg_387_1:RecordAudio("1109305100", var_390_9)
						arg_387_1:RecordAudio("1109305100", var_390_9)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305100", "story_v_side_new_1109305.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305100", "story_v_side_new_1109305.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_10 = math.max(var_390_3, arg_387_1.talkMaxDuration)

			if var_390_2 <= arg_387_1.time_ and arg_387_1.time_ < var_390_2 + var_390_10 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_2) / var_390_10

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_2 + var_390_10 and arg_387_1.time_ < var_390_2 + var_390_10 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play1109305101 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 1109305101
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play1109305102(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 and not isNil(arg_391_1.actors_["1093ui_story"]) and arg_391_1.var_.characterEffect1093ui_story == nil then
				arg_391_1.var_.characterEffect1093ui_story = arg_391_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_0 = 0.200000002980232

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_0 and not isNil(arg_391_1.actors_["1093ui_story"]) then
				if arg_391_1.var_.characterEffect1093ui_story and not isNil(arg_391_1.actors_["1093ui_story"]) then
					arg_391_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_391_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_391_1.time_ - 0) / var_394_0)
				end
			end

			if arg_391_1.time_ >= 0 + var_394_0 and arg_391_1.time_ < 0 + var_394_0 + arg_394_0 and not isNil(arg_391_1.actors_["1093ui_story"]) and arg_391_1.var_.characterEffect1093ui_story then
				arg_391_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_391_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_394_1 = 0
			local var_394_2 = 0.8

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_1 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, true)
				arg_391_1.iconController_:SetSelectedState("hero")

				arg_391_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_391_1.callingController_:SetSelectedState("normal")

				arg_391_1.keyicon_.color = Color.New(1, 1, 1)
				arg_391_1.icon_.color = Color.New(1, 1, 1)

				local var_394_3 = arg_391_1:FormatText(arg_391_1:GetWordFromCfg(1109305101).content)

				arg_391_1.text_.text = var_394_3

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_5 = 32 <= 0 and var_394_2 or var_394_2 * (utf8.len(var_394_3) / 32)

				if (32 <= 0 and var_394_2 or var_394_2 * (utf8.len(var_394_3) / 32)) > 0 and var_394_2 < var_394_5 then
					arg_391_1.talkMaxDuration = var_394_5

					if var_394_5 + var_394_1 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_5 + var_394_1
					end
				end

				arg_391_1.text_.text = var_394_3
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_6 = math.max(var_394_2, arg_391_1.talkMaxDuration)

			if var_394_1 <= arg_391_1.time_ and arg_391_1.time_ < var_394_1 + var_394_6 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_1) / var_394_6

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_1 + var_394_6 and arg_391_1.time_ < var_394_1 + var_394_6 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play1109305102 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 1109305102
		arg_395_1.duration_ = 5.23

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play1109305103(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.var_.moveOldPos1093ui_story = arg_395_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_398_0 = 0.001

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_0 then
				arg_395_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_395_1.time_ - 0) / var_398_0)
				arg_395_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_395_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1093ui_story"].transform.position).z)
				arg_395_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_395_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_395_1.actors_["1093ui_story"].transform.localEulerAngles = arg_395_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_395_1.time_ >= 0 + var_398_0 and arg_395_1.time_ < 0 + var_398_0 + arg_398_0 then
				arg_395_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_395_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_395_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1093ui_story"].transform.position).z)
				arg_395_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_395_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_395_1.actors_["1093ui_story"].transform.localEulerAngles = arg_395_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_398_1 = arg_395_1.actors_["1093ui_story"]

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 and not isNil(var_398_1) and arg_395_1.var_.characterEffect1093ui_story == nil then
				arg_395_1.var_.characterEffect1093ui_story = var_398_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_2 = 0.200000002980232

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_2 and not isNil(var_398_1) then
				if arg_395_1.var_.characterEffect1093ui_story and not isNil(var_398_1) then
					arg_395_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_395_1.time_ >= 0 + var_398_2 and arg_395_1.time_ < 0 + var_398_2 + arg_398_0 and not isNil(var_398_1) and arg_395_1.var_.characterEffect1093ui_story then
				arg_395_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_398_4 = 0
			local var_398_5 = 0.55

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_4 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_6 = arg_395_1:GetWordFromCfg(1109305102)
				local var_398_7 = arg_395_1:FormatText(var_398_6.content)

				arg_395_1.text_.text = var_398_7

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_9 = 22 <= 0 and var_398_5 or var_398_5 * (utf8.len(var_398_7) / 22)

				if (22 <= 0 and var_398_5 or var_398_5 * (utf8.len(var_398_7) / 22)) > 0 and var_398_5 < var_398_9 then
					arg_395_1.talkMaxDuration = var_398_9

					if var_398_9 + var_398_4 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_9 + var_398_4
					end
				end

				arg_395_1.text_.text = var_398_7
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305102", "story_v_side_new_1109305.awb") ~= 0 then
					local var_398_10 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305102", "story_v_side_new_1109305.awb") / 1000

					if var_398_10 + var_398_4 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_10 + var_398_4
					end

					if var_398_6.prefab_name ~= "" and arg_395_1.actors_[var_398_6.prefab_name] ~= nil then
						local var_398_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_6.prefab_name].transform, "story_v_side_new_1109305", "1109305102", "story_v_side_new_1109305.awb")

						arg_395_1:RecordAudio("1109305102", var_398_11)
						arg_395_1:RecordAudio("1109305102", var_398_11)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305102", "story_v_side_new_1109305.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305102", "story_v_side_new_1109305.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_12 = math.max(var_398_5, arg_395_1.talkMaxDuration)

			if var_398_4 <= arg_395_1.time_ and arg_395_1.time_ < var_398_4 + var_398_12 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_4) / var_398_12

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_4 + var_398_12 and arg_395_1.time_ < var_398_4 + var_398_12 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {
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

		arg_395_1:InitPlayNodeList()
	end,
	Play1109305103 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 1109305103
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play1109305104(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(arg_399_1.actors_["1093ui_story"]) and arg_399_1.var_.characterEffect1093ui_story == nil then
				arg_399_1.var_.characterEffect1093ui_story = arg_399_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_0 = 0.200000002980232

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_0 and not isNil(arg_399_1.actors_["1093ui_story"]) then
				if arg_399_1.var_.characterEffect1093ui_story and not isNil(arg_399_1.actors_["1093ui_story"]) then
					arg_399_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_399_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_399_1.time_ - 0) / var_402_0)
				end
			end

			if arg_399_1.time_ >= 0 + var_402_0 and arg_399_1.time_ < 0 + var_402_0 + arg_402_0 and not isNil(arg_399_1.actors_["1093ui_story"]) and arg_399_1.var_.characterEffect1093ui_story then
				arg_399_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_399_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_402_1 = 0
			local var_402_2 = 0.95

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_1 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, true)
				arg_399_1.iconController_:SetSelectedState("hero")

				arg_399_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_399_1.callingController_:SetSelectedState("normal")

				arg_399_1.keyicon_.color = Color.New(1, 1, 1)
				arg_399_1.icon_.color = Color.New(1, 1, 1)

				local var_402_3 = arg_399_1:FormatText(arg_399_1:GetWordFromCfg(1109305103).content)

				arg_399_1.text_.text = var_402_3

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_5 = 38 <= 0 and var_402_2 or var_402_2 * (utf8.len(var_402_3) / 38)

				if (38 <= 0 and var_402_2 or var_402_2 * (utf8.len(var_402_3) / 38)) > 0 and var_402_2 < var_402_5 then
					arg_399_1.talkMaxDuration = var_402_5

					if var_402_5 + var_402_1 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_5 + var_402_1
					end
				end

				arg_399_1.text_.text = var_402_3
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_6 = math.max(var_402_2, arg_399_1.talkMaxDuration)

			if var_402_1 <= arg_399_1.time_ and arg_399_1.time_ < var_402_1 + var_402_6 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_1) / var_402_6

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_1 + var_402_6 and arg_399_1.time_ < var_402_1 + var_402_6 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play1109305104 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 1109305104
		arg_403_1.duration_ = 5

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play1109305105(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.var_.moveOldPos1093ui_story = arg_403_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_406_0 = 0.001

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_0 then
				arg_403_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_403_1.time_ - 0) / var_406_0)
				arg_403_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_403_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1093ui_story"].transform.position).z)
				arg_403_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_403_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_403_1.actors_["1093ui_story"].transform.localEulerAngles = arg_403_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_403_1.time_ >= 0 + var_406_0 and arg_403_1.time_ < 0 + var_406_0 + arg_406_0 then
				arg_403_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_403_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_403_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1093ui_story"].transform.position).z)
				arg_403_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_403_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_403_1.actors_["1093ui_story"].transform.localEulerAngles = arg_403_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_406_1 = arg_403_1.actors_["1093ui_story"]

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(var_406_1) and arg_403_1.var_.characterEffect1093ui_story == nil then
				arg_403_1.var_.characterEffect1093ui_story = var_406_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_2 = 0.200000002980232

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_2 and not isNil(var_406_1) then
				if arg_403_1.var_.characterEffect1093ui_story and not isNil(var_406_1) then
					arg_403_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_403_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_403_1.time_ - 0) / var_406_2)
				end
			end

			if arg_403_1.time_ >= 0 + var_406_2 and arg_403_1.time_ < 0 + var_406_2 + arg_406_0 and not isNil(var_406_1) and arg_403_1.var_.characterEffect1093ui_story then
				arg_403_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_403_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_406_3 = 0
			local var_406_4 = 0.5

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_3 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, false)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_5 = arg_403_1:FormatText(arg_403_1:GetWordFromCfg(1109305104).content)

				arg_403_1.text_.text = var_406_5

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_7 = 20 <= 0 and var_406_4 or var_406_4 * (utf8.len(var_406_5) / 20)

				if (20 <= 0 and var_406_4 or var_406_4 * (utf8.len(var_406_5) / 20)) > 0 and var_406_4 < var_406_7 then
					arg_403_1.talkMaxDuration = var_406_7

					if var_406_7 + var_406_3 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_7 + var_406_3
					end
				end

				arg_403_1.text_.text = var_406_5
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)
				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_8 = math.max(var_406_4, arg_403_1.talkMaxDuration)

			if var_406_3 <= arg_403_1.time_ and arg_403_1.time_ < var_406_3 + var_406_8 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_3) / var_406_8

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_3 + var_406_8 and arg_403_1.time_ < var_406_3 + var_406_8 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {
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

		arg_403_1:InitPlayNodeList()
	end,
	Play1109305105 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 1109305105
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play1109305106(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = 0.625

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

				local var_410_1 = arg_407_1:FormatText(arg_407_1:GetWordFromCfg(1109305105).content)

				arg_407_1.text_.text = var_410_1

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_3 = 25 <= 0 and var_410_0 or var_410_0 * (utf8.len(var_410_1) / 25)

				if (25 <= 0 and var_410_0 or var_410_0 * (utf8.len(var_410_1) / 25)) > 0 and var_410_0 < var_410_3 then
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
	Play1109305106 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 1109305106
		arg_411_1.duration_ = 7.27

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play1109305107(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.var_.moveOldPos1093ui_story = arg_411_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_414_0 = 0.001

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_0 then
				arg_411_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_411_1.time_ - 0) / var_414_0)
				arg_411_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_411_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1093ui_story"].transform.position).z)
				arg_411_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_411_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_411_1.actors_["1093ui_story"].transform.localEulerAngles = arg_411_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_411_1.time_ >= 0 + var_414_0 and arg_411_1.time_ < 0 + var_414_0 + arg_414_0 then
				arg_411_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_411_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_411_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1093ui_story"].transform.position).z)
				arg_411_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_411_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_411_1.actors_["1093ui_story"].transform.localEulerAngles = arg_411_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_414_1 = arg_411_1.actors_["1093ui_story"]

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 and not isNil(var_414_1) and arg_411_1.var_.characterEffect1093ui_story == nil then
				arg_411_1.var_.characterEffect1093ui_story = var_414_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_2 = 0.200000002980232

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_2 and not isNil(var_414_1) then
				if arg_411_1.var_.characterEffect1093ui_story and not isNil(var_414_1) then
					arg_411_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_411_1.time_ >= 0 + var_414_2 and arg_411_1.time_ < 0 + var_414_2 + arg_414_0 and not isNil(var_414_1) and arg_411_1.var_.characterEffect1093ui_story then
				arg_411_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_2")
			end

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_414_4 = 0
			local var_414_5 = 0.7

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_4 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_6 = arg_411_1:GetWordFromCfg(1109305106)
				local var_414_7 = arg_411_1:FormatText(var_414_6.content)

				arg_411_1.text_.text = var_414_7

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_9 = 28 <= 0 and var_414_5 or var_414_5 * (utf8.len(var_414_7) / 28)

				if (28 <= 0 and var_414_5 or var_414_5 * (utf8.len(var_414_7) / 28)) > 0 and var_414_5 < var_414_9 then
					arg_411_1.talkMaxDuration = var_414_9

					if var_414_9 + var_414_4 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_9 + var_414_4
					end
				end

				arg_411_1.text_.text = var_414_7
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305106", "story_v_side_new_1109305.awb") ~= 0 then
					local var_414_10 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305106", "story_v_side_new_1109305.awb") / 1000

					if var_414_10 + var_414_4 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_10 + var_414_4
					end

					if var_414_6.prefab_name ~= "" and arg_411_1.actors_[var_414_6.prefab_name] ~= nil then
						local var_414_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_6.prefab_name].transform, "story_v_side_new_1109305", "1109305106", "story_v_side_new_1109305.awb")

						arg_411_1:RecordAudio("1109305106", var_414_11)
						arg_411_1:RecordAudio("1109305106", var_414_11)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305106", "story_v_side_new_1109305.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305106", "story_v_side_new_1109305.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_12 = math.max(var_414_5, arg_411_1.talkMaxDuration)

			if var_414_4 <= arg_411_1.time_ and arg_411_1.time_ < var_414_4 + var_414_12 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_4) / var_414_12

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_4 + var_414_12 and arg_411_1.time_ < var_414_4 + var_414_12 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {
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

		arg_411_1:InitPlayNodeList()
	end,
	Play1109305107 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 1109305107
		arg_415_1.duration_ = 5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play1109305108(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 and not isNil(arg_415_1.actors_["1093ui_story"]) and arg_415_1.var_.characterEffect1093ui_story == nil then
				arg_415_1.var_.characterEffect1093ui_story = arg_415_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_0 = 0.200000002980232

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_0 and not isNil(arg_415_1.actors_["1093ui_story"]) then
				if arg_415_1.var_.characterEffect1093ui_story and not isNil(arg_415_1.actors_["1093ui_story"]) then
					arg_415_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_415_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_415_1.time_ - 0) / var_418_0)
				end
			end

			if arg_415_1.time_ >= 0 + var_418_0 and arg_415_1.time_ < 0 + var_418_0 + arg_418_0 and not isNil(arg_415_1.actors_["1093ui_story"]) and arg_415_1.var_.characterEffect1093ui_story then
				arg_415_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_415_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_418_1 = 0
			local var_418_2 = 0.375

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_1 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, true)
				arg_415_1.iconController_:SetSelectedState("hero")

				arg_415_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_415_1.callingController_:SetSelectedState("normal")

				arg_415_1.keyicon_.color = Color.New(1, 1, 1)
				arg_415_1.icon_.color = Color.New(1, 1, 1)

				local var_418_3 = arg_415_1:FormatText(arg_415_1:GetWordFromCfg(1109305107).content)

				arg_415_1.text_.text = var_418_3

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_5 = 15 <= 0 and var_418_2 or var_418_2 * (utf8.len(var_418_3) / 15)

				if (15 <= 0 and var_418_2 or var_418_2 * (utf8.len(var_418_3) / 15)) > 0 and var_418_2 < var_418_5 then
					arg_415_1.talkMaxDuration = var_418_5

					if var_418_5 + var_418_1 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_5 + var_418_1
					end
				end

				arg_415_1.text_.text = var_418_3
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_6 = math.max(var_418_2, arg_415_1.talkMaxDuration)

			if var_418_1 <= arg_415_1.time_ and arg_415_1.time_ < var_418_1 + var_418_6 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_1) / var_418_6

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_1 + var_418_6 and arg_415_1.time_ < var_418_1 + var_418_6 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play1109305108 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 1109305108
		arg_419_1.duration_ = 6.57

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play1109305109(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 and not isNil(arg_419_1.actors_["1093ui_story"]) and arg_419_1.var_.characterEffect1093ui_story == nil then
				arg_419_1.var_.characterEffect1093ui_story = arg_419_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_0 = 0.200000002980232

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_0 and not isNil(arg_419_1.actors_["1093ui_story"]) then
				if arg_419_1.var_.characterEffect1093ui_story and not isNil(arg_419_1.actors_["1093ui_story"]) then
					arg_419_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_419_1.time_ >= 0 + var_422_0 and arg_419_1.time_ < 0 + var_422_0 + arg_422_0 and not isNil(arg_419_1.actors_["1093ui_story"]) and arg_419_1.var_.characterEffect1093ui_story then
				arg_419_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_422_2 = 0
			local var_422_3 = 0.775

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_2 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_4 = arg_419_1:GetWordFromCfg(1109305108)
				local var_422_5 = arg_419_1:FormatText(var_422_4.content)

				arg_419_1.text_.text = var_422_5

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_7 = 31 <= 0 and var_422_3 or var_422_3 * (utf8.len(var_422_5) / 31)

				if (31 <= 0 and var_422_3 or var_422_3 * (utf8.len(var_422_5) / 31)) > 0 and var_422_3 < var_422_7 then
					arg_419_1.talkMaxDuration = var_422_7

					if var_422_7 + var_422_2 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_7 + var_422_2
					end
				end

				arg_419_1.text_.text = var_422_5
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305108", "story_v_side_new_1109305.awb") ~= 0 then
					local var_422_8 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305108", "story_v_side_new_1109305.awb") / 1000

					if var_422_8 + var_422_2 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_8 + var_422_2
					end

					if var_422_4.prefab_name ~= "" and arg_419_1.actors_[var_422_4.prefab_name] ~= nil then
						local var_422_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_4.prefab_name].transform, "story_v_side_new_1109305", "1109305108", "story_v_side_new_1109305.awb")

						arg_419_1:RecordAudio("1109305108", var_422_9)
						arg_419_1:RecordAudio("1109305108", var_422_9)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305108", "story_v_side_new_1109305.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305108", "story_v_side_new_1109305.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_10 = math.max(var_422_3, arg_419_1.talkMaxDuration)

			if var_422_2 <= arg_419_1.time_ and arg_419_1.time_ < var_422_2 + var_422_10 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_2) / var_422_10

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_2 + var_422_10 and arg_419_1.time_ < var_422_2 + var_422_10 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play1109305109 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 1109305109
		arg_423_1.duration_ = 5

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play1109305110(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(arg_423_1.actors_["1093ui_story"]) and arg_423_1.var_.characterEffect1093ui_story == nil then
				arg_423_1.var_.characterEffect1093ui_story = arg_423_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_0 = 0.200000002980232

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_0 and not isNil(arg_423_1.actors_["1093ui_story"]) then
				if arg_423_1.var_.characterEffect1093ui_story and not isNil(arg_423_1.actors_["1093ui_story"]) then
					arg_423_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_423_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_423_1.time_ - 0) / var_426_0)
				end
			end

			if arg_423_1.time_ >= 0 + var_426_0 and arg_423_1.time_ < 0 + var_426_0 + arg_426_0 and not isNil(arg_423_1.actors_["1093ui_story"]) and arg_423_1.var_.characterEffect1093ui_story then
				arg_423_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_423_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_426_1 = 0
			local var_426_2 = 0.325

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_1 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, true)
				arg_423_1.iconController_:SetSelectedState("hero")

				arg_423_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_423_1.callingController_:SetSelectedState("normal")

				arg_423_1.keyicon_.color = Color.New(1, 1, 1)
				arg_423_1.icon_.color = Color.New(1, 1, 1)

				local var_426_3 = arg_423_1:FormatText(arg_423_1:GetWordFromCfg(1109305109).content)

				arg_423_1.text_.text = var_426_3

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_5 = 13 <= 0 and var_426_2 or var_426_2 * (utf8.len(var_426_3) / 13)

				if (13 <= 0 and var_426_2 or var_426_2 * (utf8.len(var_426_3) / 13)) > 0 and var_426_2 < var_426_5 then
					arg_423_1.talkMaxDuration = var_426_5

					if var_426_5 + var_426_1 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_5 + var_426_1
					end
				end

				arg_423_1.text_.text = var_426_3
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_6 = math.max(var_426_2, arg_423_1.talkMaxDuration)

			if var_426_1 <= arg_423_1.time_ and arg_423_1.time_ < var_426_1 + var_426_6 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_1) / var_426_6

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_1 + var_426_6 and arg_423_1.time_ < var_426_1 + var_426_6 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play1109305110 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 1109305110
		arg_427_1.duration_ = 7.2

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play1109305111(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.var_.moveOldPos1093ui_story = arg_427_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_430_0 = 0.001

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_0 then
				arg_427_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_427_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_427_1.time_ - 0) / var_430_0)
				arg_427_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_427_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["1093ui_story"].transform.position).z)
				arg_427_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_427_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_427_1.actors_["1093ui_story"].transform.localEulerAngles = arg_427_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_427_1.time_ >= 0 + var_430_0 and arg_427_1.time_ < 0 + var_430_0 + arg_430_0 then
				arg_427_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_427_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_427_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["1093ui_story"].transform.position).z)
				arg_427_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_427_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_427_1.actors_["1093ui_story"].transform.localEulerAngles = arg_427_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_430_1 = arg_427_1.actors_["1093ui_story"]

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(var_430_1) and arg_427_1.var_.characterEffect1093ui_story == nil then
				arg_427_1.var_.characterEffect1093ui_story = var_430_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_2 = 0.200000002980232

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_2 and not isNil(var_430_1) then
				if arg_427_1.var_.characterEffect1093ui_story and not isNil(var_430_1) then
					arg_427_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_427_1.time_ >= 0 + var_430_2 and arg_427_1.time_ < 0 + var_430_2 + arg_430_0 and not isNil(var_430_1) and arg_427_1.var_.characterEffect1093ui_story then
				arg_427_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action7_1")
			end

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_430_4 = 0
			local var_430_5 = 0.675

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_4 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_6 = arg_427_1:GetWordFromCfg(1109305110)
				local var_430_7 = arg_427_1:FormatText(var_430_6.content)

				arg_427_1.text_.text = var_430_7

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_9 = 27 <= 0 and var_430_5 or var_430_5 * (utf8.len(var_430_7) / 27)

				if (27 <= 0 and var_430_5 or var_430_5 * (utf8.len(var_430_7) / 27)) > 0 and var_430_5 < var_430_9 then
					arg_427_1.talkMaxDuration = var_430_9

					if var_430_9 + var_430_4 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_9 + var_430_4
					end
				end

				arg_427_1.text_.text = var_430_7
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305110", "story_v_side_new_1109305.awb") ~= 0 then
					local var_430_10 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305110", "story_v_side_new_1109305.awb") / 1000

					if var_430_10 + var_430_4 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_10 + var_430_4
					end

					if var_430_6.prefab_name ~= "" and arg_427_1.actors_[var_430_6.prefab_name] ~= nil then
						local var_430_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_6.prefab_name].transform, "story_v_side_new_1109305", "1109305110", "story_v_side_new_1109305.awb")

						arg_427_1:RecordAudio("1109305110", var_430_11)
						arg_427_1:RecordAudio("1109305110", var_430_11)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305110", "story_v_side_new_1109305.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305110", "story_v_side_new_1109305.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_12 = math.max(var_430_5, arg_427_1.talkMaxDuration)

			if var_430_4 <= arg_427_1.time_ and arg_427_1.time_ < var_430_4 + var_430_12 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_4) / var_430_12

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_4 + var_430_12 and arg_427_1.time_ < var_430_4 + var_430_12 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {
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

		arg_427_1:InitPlayNodeList()
	end,
	Play1109305111 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 1109305111
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play1109305112(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 and not isNil(arg_431_1.actors_["1093ui_story"]) and arg_431_1.var_.characterEffect1093ui_story == nil then
				arg_431_1.var_.characterEffect1093ui_story = arg_431_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_0 = 0.200000002980232

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_0 and not isNil(arg_431_1.actors_["1093ui_story"]) then
				if arg_431_1.var_.characterEffect1093ui_story and not isNil(arg_431_1.actors_["1093ui_story"]) then
					arg_431_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_431_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_431_1.time_ - 0) / var_434_0)
				end
			end

			if arg_431_1.time_ >= 0 + var_434_0 and arg_431_1.time_ < 0 + var_434_0 + arg_434_0 and not isNil(arg_431_1.actors_["1093ui_story"]) and arg_431_1.var_.characterEffect1093ui_story then
				arg_431_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_431_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_434_1 = 0
			local var_434_2 = 0.525

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_1 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				arg_431_1.leftNameTxt_.text = arg_431_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, true)
				arg_431_1.iconController_:SetSelectedState("hero")

				arg_431_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_431_1.callingController_:SetSelectedState("normal")

				arg_431_1.keyicon_.color = Color.New(1, 1, 1)
				arg_431_1.icon_.color = Color.New(1, 1, 1)

				local var_434_3 = arg_431_1:FormatText(arg_431_1:GetWordFromCfg(1109305111).content)

				arg_431_1.text_.text = var_434_3

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_5 = 21 <= 0 and var_434_2 or var_434_2 * (utf8.len(var_434_3) / 21)

				if (21 <= 0 and var_434_2 or var_434_2 * (utf8.len(var_434_3) / 21)) > 0 and var_434_2 < var_434_5 then
					arg_431_1.talkMaxDuration = var_434_5

					if var_434_5 + var_434_1 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_5 + var_434_1
					end
				end

				arg_431_1.text_.text = var_434_3
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_6 = math.max(var_434_2, arg_431_1.talkMaxDuration)

			if var_434_1 <= arg_431_1.time_ and arg_431_1.time_ < var_434_1 + var_434_6 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_1) / var_434_6

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_1 + var_434_6 and arg_431_1.time_ < var_434_1 + var_434_6 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play1109305112 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 1109305112
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play1109305113(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = 0.65

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, false)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_1 = arg_435_1:FormatText(arg_435_1:GetWordFromCfg(1109305112).content)

				arg_435_1.text_.text = var_438_1

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_3 = 26 <= 0 and var_438_0 or var_438_0 * (utf8.len(var_438_1) / 26)

				if (26 <= 0 and var_438_0 or var_438_0 * (utf8.len(var_438_1) / 26)) > 0 and var_438_0 < var_438_3 then
					arg_435_1.talkMaxDuration = var_438_3

					if var_438_3 + 0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_3 + 0
					end
				end

				arg_435_1.text_.text = var_438_1
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_4 = math.max(var_438_0, arg_435_1.talkMaxDuration)

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_4 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - 0) / var_438_4

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= 0 + var_438_4 and arg_435_1.time_ < 0 + var_438_4 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play1109305113 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 1109305113
		arg_439_1.duration_ = 5

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play1109305114(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 0.5

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				arg_439_1.leftNameTxt_.text = arg_439_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, true)
				arg_439_1.iconController_:SetSelectedState("hero")

				arg_439_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_439_1.callingController_:SetSelectedState("normal")

				arg_439_1.keyicon_.color = Color.New(1, 1, 1)
				arg_439_1.icon_.color = Color.New(1, 1, 1)

				local var_442_1 = arg_439_1:FormatText(arg_439_1:GetWordFromCfg(1109305113).content)

				arg_439_1.text_.text = var_442_1

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_3 = 20 <= 0 and var_442_0 or var_442_0 * (utf8.len(var_442_1) / 20)

				if (20 <= 0 and var_442_0 or var_442_0 * (utf8.len(var_442_1) / 20)) > 0 and var_442_0 < var_442_3 then
					arg_439_1.talkMaxDuration = var_442_3

					if var_442_3 + 0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_3 + 0
					end
				end

				arg_439_1.text_.text = var_442_1
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_4 = math.max(var_442_0, arg_439_1.talkMaxDuration)

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_4 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - 0) / var_442_4

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= 0 + var_442_4 and arg_439_1.time_ < 0 + var_442_4 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play1109305114 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 1109305114
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play1109305115(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1.var_.moveOldPos1093ui_story = arg_443_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_446_0 = 0.001

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_0 then
				arg_443_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_443_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_443_1.time_ - 0) / var_446_0)
				arg_443_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_443_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["1093ui_story"].transform.position).z)
				arg_443_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_443_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_443_1.actors_["1093ui_story"].transform.localEulerAngles = arg_443_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_443_1.time_ >= 0 + var_446_0 and arg_443_1.time_ < 0 + var_446_0 + arg_446_0 then
				arg_443_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_443_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_443_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["1093ui_story"].transform.position).z)
				arg_443_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_443_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_443_1.actors_["1093ui_story"].transform.localEulerAngles = arg_443_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_446_1 = arg_443_1.actors_["1093ui_story"]

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 and not isNil(var_446_1) and arg_443_1.var_.characterEffect1093ui_story == nil then
				arg_443_1.var_.characterEffect1093ui_story = var_446_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_446_2 = 0.200000002980232

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_2 and not isNil(var_446_1) then
				if arg_443_1.var_.characterEffect1093ui_story and not isNil(var_446_1) then
					arg_443_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_443_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_443_1.time_ - 0) / var_446_2)
				end
			end

			if arg_443_1.time_ >= 0 + var_446_2 and arg_443_1.time_ < 0 + var_446_2 + arg_446_0 and not isNil(var_446_1) and arg_443_1.var_.characterEffect1093ui_story then
				arg_443_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_443_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_446_3 = 0
			local var_446_4 = 0.6

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_3 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, false)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_5 = arg_443_1:FormatText(arg_443_1:GetWordFromCfg(1109305114).content)

				arg_443_1.text_.text = var_446_5

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_7 = 24 <= 0 and var_446_4 or var_446_4 * (utf8.len(var_446_5) / 24)

				if (24 <= 0 and var_446_4 or var_446_4 * (utf8.len(var_446_5) / 24)) > 0 and var_446_4 < var_446_7 then
					arg_443_1.talkMaxDuration = var_446_7

					if var_446_7 + var_446_3 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_7 + var_446_3
					end
				end

				arg_443_1.text_.text = var_446_5
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)
				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_8 = math.max(var_446_4, arg_443_1.talkMaxDuration)

			if var_446_3 <= arg_443_1.time_ and arg_443_1.time_ < var_446_3 + var_446_8 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_3) / var_446_8

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_3 + var_446_8 and arg_443_1.time_ < var_446_3 + var_446_8 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {
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

		arg_443_1:InitPlayNodeList()
	end,
	Play1109305115 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 1109305115
		arg_447_1.duration_ = 5

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play1109305116(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = 0.75

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, false)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_1 = arg_447_1:FormatText(arg_447_1:GetWordFromCfg(1109305115).content)

				arg_447_1.text_.text = var_450_1

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_3 = 30 <= 0 and var_450_0 or var_450_0 * (utf8.len(var_450_1) / 30)

				if (30 <= 0 and var_450_0 or var_450_0 * (utf8.len(var_450_1) / 30)) > 0 and var_450_0 < var_450_3 then
					arg_447_1.talkMaxDuration = var_450_3

					if var_450_3 + 0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_3 + 0
					end
				end

				arg_447_1.text_.text = var_450_1
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)
				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_4 = math.max(var_450_0, arg_447_1.talkMaxDuration)

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_4 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - 0) / var_450_4

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= 0 + var_450_4 and arg_447_1.time_ < 0 + var_450_4 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play1109305116 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 1109305116
		arg_451_1.duration_ = 3.83

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play1109305117(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = 0.4

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				arg_451_1.leftNameTxt_.text = arg_451_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, true)
				arg_451_1.iconController_:SetSelectedState("hero")

				arg_451_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_451_1.callingController_:SetSelectedState("normal")

				arg_451_1.keyicon_.color = Color.New(1, 1, 1)
				arg_451_1.icon_.color = Color.New(1, 1, 1)

				local var_454_1 = arg_451_1:GetWordFromCfg(1109305116)
				local var_454_2 = arg_451_1:FormatText(var_454_1.content)

				arg_451_1.text_.text = var_454_2

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_4 = 16 <= 0 and var_454_0 or var_454_0 * (utf8.len(var_454_2) / 16)

				if (16 <= 0 and var_454_0 or var_454_0 * (utf8.len(var_454_2) / 16)) > 0 and var_454_0 < var_454_4 then
					arg_451_1.talkMaxDuration = var_454_4

					if var_454_4 + 0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_4 + 0
					end
				end

				arg_451_1.text_.text = var_454_2
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305116", "story_v_side_new_1109305.awb") ~= 0 then
					local var_454_5 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305116", "story_v_side_new_1109305.awb") / 1000

					if var_454_5 + 0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_5 + 0
					end

					if var_454_1.prefab_name ~= "" and arg_451_1.actors_[var_454_1.prefab_name] ~= nil then
						local var_454_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_1.prefab_name].transform, "story_v_side_new_1109305", "1109305116", "story_v_side_new_1109305.awb")

						arg_451_1:RecordAudio("1109305116", var_454_6)
						arg_451_1:RecordAudio("1109305116", var_454_6)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305116", "story_v_side_new_1109305.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305116", "story_v_side_new_1109305.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_7 = math.max(var_454_0, arg_451_1.talkMaxDuration)

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_7 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - 0) / var_454_7

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= 0 + var_454_7 and arg_451_1.time_ < 0 + var_454_7 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play1109305117 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 1109305117
		arg_455_1.duration_ = 5.27

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play1109305118(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = 0.625

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				arg_455_1.leftNameTxt_.text = arg_455_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, true)
				arg_455_1.iconController_:SetSelectedState("hero")

				arg_455_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_455_1.callingController_:SetSelectedState("normal")

				arg_455_1.keyicon_.color = Color.New(1, 1, 1)
				arg_455_1.icon_.color = Color.New(1, 1, 1)

				local var_458_1 = arg_455_1:GetWordFromCfg(1109305117)
				local var_458_2 = arg_455_1:FormatText(var_458_1.content)

				arg_455_1.text_.text = var_458_2

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_4 = 25 <= 0 and var_458_0 or var_458_0 * (utf8.len(var_458_2) / 25)

				if (25 <= 0 and var_458_0 or var_458_0 * (utf8.len(var_458_2) / 25)) > 0 and var_458_0 < var_458_4 then
					arg_455_1.talkMaxDuration = var_458_4

					if var_458_4 + 0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_4 + 0
					end
				end

				arg_455_1.text_.text = var_458_2
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305117", "story_v_side_new_1109305.awb") ~= 0 then
					local var_458_5 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305117", "story_v_side_new_1109305.awb") / 1000

					if var_458_5 + 0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_5 + 0
					end

					if var_458_1.prefab_name ~= "" and arg_455_1.actors_[var_458_1.prefab_name] ~= nil then
						local var_458_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_1.prefab_name].transform, "story_v_side_new_1109305", "1109305117", "story_v_side_new_1109305.awb")

						arg_455_1:RecordAudio("1109305117", var_458_6)
						arg_455_1:RecordAudio("1109305117", var_458_6)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305117", "story_v_side_new_1109305.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305117", "story_v_side_new_1109305.awb")
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
	Play1109305118 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 1109305118
		arg_459_1.duration_ = 5

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play1109305119(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = 0.45

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

				local var_462_1 = arg_459_1:FormatText(arg_459_1:GetWordFromCfg(1109305118).content)

				arg_459_1.text_.text = var_462_1

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_3 = 18 <= 0 and var_462_0 or var_462_0 * (utf8.len(var_462_1) / 18)

				if (18 <= 0 and var_462_0 or var_462_0 * (utf8.len(var_462_1) / 18)) > 0 and var_462_0 < var_462_3 then
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
	Play1109305119 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 1109305119
		arg_463_1.duration_ = 5

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play1109305120(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = 0.75

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				arg_463_1.leftNameTxt_.text = arg_463_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, true)
				arg_463_1.iconController_:SetSelectedState("hero")

				arg_463_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_463_1.callingController_:SetSelectedState("normal")

				arg_463_1.keyicon_.color = Color.New(1, 1, 1)
				arg_463_1.icon_.color = Color.New(1, 1, 1)

				local var_466_1 = arg_463_1:FormatText(arg_463_1:GetWordFromCfg(1109305119).content)

				arg_463_1.text_.text = var_466_1

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_3 = 30 <= 0 and var_466_0 or var_466_0 * (utf8.len(var_466_1) / 30)

				if (30 <= 0 and var_466_0 or var_466_0 * (utf8.len(var_466_1) / 30)) > 0 and var_466_0 < var_466_3 then
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
	Play1109305120 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 1109305120
		arg_467_1.duration_ = 5

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play1109305121(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = 0.7

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, false)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_1 = arg_467_1:FormatText(arg_467_1:GetWordFromCfg(1109305120).content)

				arg_467_1.text_.text = var_470_1

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_3 = 28 <= 0 and var_470_0 or var_470_0 * (utf8.len(var_470_1) / 28)

				if (28 <= 0 and var_470_0 or var_470_0 * (utf8.len(var_470_1) / 28)) > 0 and var_470_0 < var_470_3 then
					arg_467_1.talkMaxDuration = var_470_3

					if var_470_3 + 0 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_3 + 0
					end
				end

				arg_467_1.text_.text = var_470_1
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)
				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_4 = math.max(var_470_0, arg_467_1.talkMaxDuration)

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_4 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - 0) / var_470_4

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= 0 + var_470_4 and arg_467_1.time_ < 0 + var_470_4 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play1109305121 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 1109305121
		arg_471_1.duration_ = 7.97

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play1109305122(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			if arg_471_1.bgs_.ST02 == nil then
				local var_474_0 = Object.Instantiate(arg_471_1.paintGo_)

				var_474_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST02")
				var_474_0.name = "ST02"
				var_474_0.transform.parent = arg_471_1.stage_.transform
				var_474_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_471_1.bgs_.ST02 = var_474_0
			end

			if 1.23333333333333 < arg_471_1.time_ and arg_471_1.time_ <= 1.23333333333333 + arg_474_0 then
				local var_474_1 = arg_471_1.bgs_.ST02

				arg_471_1.bgs_.ST02.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_474_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_474_2 = var_474_1:GetComponent("SpriteRenderer")

				if var_474_2 and var_474_2.sprite then
					local var_474_3 = 2 * (var_474_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_474_1.transform.localScale = Vector3.New(var_474_3 / var_474_2.sprite.bounds.size.y < var_474_3 * manager.ui.mainCameraCom_.aspect / var_474_2.sprite.bounds.size.x and var_474_3 * manager.ui.mainCameraCom_.aspect / var_474_2.sprite.bounds.size.x or var_474_3 / var_474_2.sprite.bounds.size.y, var_474_3 / var_474_2.sprite.bounds.size.y < var_474_3 * manager.ui.mainCameraCom_.aspect / var_474_2.sprite.bounds.size.x and var_474_3 * manager.ui.mainCameraCom_.aspect / var_474_2.sprite.bounds.size.x or var_474_3 / var_474_2.sprite.bounds.size.y, 0)
				end

				for iter_474_0, iter_474_1 in pairs(arg_471_1.bgs_) do
					if iter_474_0 ~= "ST02" then
						iter_474_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_474_4 = 0

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= var_474_4 + arg_474_0 then
				arg_471_1.allBtn_.enabled = false
			end

			if arg_471_1.time_ >= var_474_4 + 0.3 and arg_471_1.time_ < var_474_4 + 0.3 + arg_474_0 then
				arg_471_1.allBtn_.enabled = true
			end

			local var_474_5 = 0

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= var_474_5 + arg_474_0 then
				arg_471_1.mask_.enabled = true
				arg_471_1.mask_.raycastTarget = true

				arg_471_1:SetGaussion(false)
			end

			local var_474_6 = 1.23333333333333

			if var_474_5 <= arg_471_1.time_ and arg_471_1.time_ < var_474_5 + var_474_6 then
				local var_474_7 = Color.New(0, 0, 0)

				var_474_7.a = Mathf.Lerp(0, 1, (arg_471_1.time_ - var_474_5) / var_474_6)
				arg_471_1.mask_.color = var_474_7
			end

			if arg_471_1.time_ >= var_474_5 + var_474_6 and arg_471_1.time_ < var_474_5 + var_474_6 + arg_474_0 then
				local var_474_8 = Color.New(0, 0, 0)

				var_474_8.a = 1
				arg_471_1.mask_.color = var_474_8
			end

			local var_474_9 = 1.23333333333333

			if 1.23333333333333 < arg_471_1.time_ and arg_471_1.time_ <= var_474_9 + arg_474_0 then
				arg_471_1.mask_.enabled = true
				arg_471_1.mask_.raycastTarget = true

				arg_471_1:SetGaussion(false)
			end

			local var_474_10 = 2

			if var_474_9 <= arg_471_1.time_ and arg_471_1.time_ < var_474_9 + var_474_10 then
				local var_474_11 = Color.New(0, 0, 0)

				var_474_11.a = Mathf.Lerp(1, 0, (arg_471_1.time_ - var_474_9) / var_474_10)
				arg_471_1.mask_.color = var_474_11
			end

			if arg_471_1.time_ >= var_474_9 + var_474_10 and arg_471_1.time_ < var_474_9 + var_474_10 + arg_474_0 then
				local var_474_12 = Color.New(0, 0, 0)

				arg_471_1.mask_.enabled = false
				var_474_12.a = 0
				arg_471_1.mask_.color = var_474_12
			end

			if arg_471_1.frameCnt_ <= 1 then
				arg_471_1.dialog_:SetActive(false)
			end

			local var_474_13 = 2.96666666666667
			local var_474_14 = 0.6

			if 2.96666666666667 < arg_471_1.time_ and arg_471_1.time_ <= var_474_13 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0

				arg_471_1.dialog_:SetActive(true)

				arg_471_1.dialogCg_.alpha = 0

				local var_474_15 = LeanTween.value(arg_471_1.dialog_, 0, 1, 0.3)

				var_474_15:setOnUpdate(LuaHelper.FloatAction(function(arg_475_0)
					arg_471_1.dialogCg_.alpha = arg_475_0
				end))
				var_474_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_471_1.dialog_)
					var_474_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_471_1.duration_ = arg_471_1.duration_ + 0.3

				SetActive(arg_471_1.leftNameGo_, false)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_16 = arg_471_1:FormatText(arg_471_1:GetWordFromCfg(1109305121).content)

				arg_471_1.text_.text = var_474_16

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_18 = 24 <= 0 and var_474_14 or var_474_14 * (utf8.len(var_474_16) / 24)

				if (24 <= 0 and var_474_14 or var_474_14 * (utf8.len(var_474_16) / 24)) > 0 and var_474_14 < var_474_18 then
					arg_471_1.talkMaxDuration = var_474_18
					var_474_13 = var_474_13 + 0.3

					if var_474_18 + var_474_13 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_18 + var_474_13
					end
				end

				arg_471_1.text_.text = var_474_16
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)
				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_19 = var_474_13 + 0.3
			local var_474_20 = math.max(var_474_14, arg_471_1.talkMaxDuration)

			if var_474_13 + 0.3 <= arg_471_1.time_ and arg_471_1.time_ < var_474_19 + var_474_20 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_19) / var_474_20

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_19 + var_474_20 and arg_471_1.time_ < var_474_19 + var_474_20 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {}

		arg_471_1:InitPlayNodeList()
	end,
	Play1109305122 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 1109305122
		arg_477_1.duration_ = 7.17

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play1109305123(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1.var_.moveOldPos1093ui_story = arg_477_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_480_0 = 0.001

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_0 then
				arg_477_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_477_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_477_1.time_ - 0) / var_480_0)
				arg_477_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_477_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_477_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_477_1.actors_["1093ui_story"].transform.position).z)
				arg_477_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_477_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_477_1.actors_["1093ui_story"].transform.localEulerAngles = arg_477_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_477_1.time_ >= 0 + var_480_0 and arg_477_1.time_ < 0 + var_480_0 + arg_480_0 then
				arg_477_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_477_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_477_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_477_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_477_1.actors_["1093ui_story"].transform.position).z)
				arg_477_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_477_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_477_1.actors_["1093ui_story"].transform.localEulerAngles = arg_477_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_480_1 = arg_477_1.actors_["1093ui_story"]

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 and not isNil(var_480_1) and arg_477_1.var_.characterEffect1093ui_story == nil then
				arg_477_1.var_.characterEffect1093ui_story = var_480_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_2 = 0.200000002980232

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_2 and not isNil(var_480_1) then
				if arg_477_1.var_.characterEffect1093ui_story and not isNil(var_480_1) then
					arg_477_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_477_1.time_ >= 0 + var_480_2 and arg_477_1.time_ < 0 + var_480_2 + arg_480_0 and not isNil(var_480_1) and arg_477_1.var_.characterEffect1093ui_story then
				arg_477_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_480_4 = 0
			local var_480_5 = 0.8

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_4 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_6 = arg_477_1:GetWordFromCfg(1109305122)
				local var_480_7 = arg_477_1:FormatText(var_480_6.content)

				arg_477_1.text_.text = var_480_7

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_9 = 32 <= 0 and var_480_5 or var_480_5 * (utf8.len(var_480_7) / 32)

				if (32 <= 0 and var_480_5 or var_480_5 * (utf8.len(var_480_7) / 32)) > 0 and var_480_5 < var_480_9 then
					arg_477_1.talkMaxDuration = var_480_9

					if var_480_9 + var_480_4 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_9 + var_480_4
					end
				end

				arg_477_1.text_.text = var_480_7
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305122", "story_v_side_new_1109305.awb") ~= 0 then
					local var_480_10 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305122", "story_v_side_new_1109305.awb") / 1000

					if var_480_10 + var_480_4 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_10 + var_480_4
					end

					if var_480_6.prefab_name ~= "" and arg_477_1.actors_[var_480_6.prefab_name] ~= nil then
						local var_480_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_6.prefab_name].transform, "story_v_side_new_1109305", "1109305122", "story_v_side_new_1109305.awb")

						arg_477_1:RecordAudio("1109305122", var_480_11)
						arg_477_1:RecordAudio("1109305122", var_480_11)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305122", "story_v_side_new_1109305.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305122", "story_v_side_new_1109305.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_12 = math.max(var_480_5, arg_477_1.talkMaxDuration)

			if var_480_4 <= arg_477_1.time_ and arg_477_1.time_ < var_480_4 + var_480_12 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_4) / var_480_12

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_4 + var_480_12 and arg_477_1.time_ < var_480_4 + var_480_12 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {
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

		arg_477_1:InitPlayNodeList()
	end,
	Play1109305123 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 1109305123
		arg_481_1.duration_ = 5

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play1109305124(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 and not isNil(arg_481_1.actors_["1093ui_story"]) and arg_481_1.var_.characterEffect1093ui_story == nil then
				arg_481_1.var_.characterEffect1093ui_story = arg_481_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_0 = 0.200000002980232

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_0 and not isNil(arg_481_1.actors_["1093ui_story"]) then
				if arg_481_1.var_.characterEffect1093ui_story and not isNil(arg_481_1.actors_["1093ui_story"]) then
					arg_481_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_481_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_481_1.time_ - 0) / var_484_0)
				end
			end

			if arg_481_1.time_ >= 0 + var_484_0 and arg_481_1.time_ < 0 + var_484_0 + arg_484_0 and not isNil(arg_481_1.actors_["1093ui_story"]) and arg_481_1.var_.characterEffect1093ui_story then
				arg_481_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_481_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_484_1 = 0
			local var_484_2 = 0.65

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_1 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[7].name)

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

				local var_484_3 = arg_481_1:FormatText(arg_481_1:GetWordFromCfg(1109305123).content)

				arg_481_1.text_.text = var_484_3

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_5 = 26 <= 0 and var_484_2 or var_484_2 * (utf8.len(var_484_3) / 26)

				if (26 <= 0 and var_484_2 or var_484_2 * (utf8.len(var_484_3) / 26)) > 0 and var_484_2 < var_484_5 then
					arg_481_1.talkMaxDuration = var_484_5

					if var_484_5 + var_484_1 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_5 + var_484_1
					end
				end

				arg_481_1.text_.text = var_484_3
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)
				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_6 = math.max(var_484_2, arg_481_1.talkMaxDuration)

			if var_484_1 <= arg_481_1.time_ and arg_481_1.time_ < var_484_1 + var_484_6 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_1) / var_484_6

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_1 + var_484_6 and arg_481_1.time_ < var_484_1 + var_484_6 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play1109305124 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 1109305124
		arg_485_1.duration_ = 2.57

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play1109305125(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 and not isNil(arg_485_1.actors_["1093ui_story"]) and arg_485_1.var_.characterEffect1093ui_story == nil then
				arg_485_1.var_.characterEffect1093ui_story = arg_485_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_0 = 0.200000002980232

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_0 and not isNil(arg_485_1.actors_["1093ui_story"]) then
				if arg_485_1.var_.characterEffect1093ui_story and not isNil(arg_485_1.actors_["1093ui_story"]) then
					arg_485_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_485_1.time_ >= 0 + var_488_0 and arg_485_1.time_ < 0 + var_488_0 + arg_488_0 and not isNil(arg_485_1.actors_["1093ui_story"]) and arg_485_1.var_.characterEffect1093ui_story then
				arg_485_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_488_2 = 0
			local var_488_3 = 0.3

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_2 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				arg_485_1.leftNameTxt_.text = arg_485_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_4 = arg_485_1:GetWordFromCfg(1109305124)
				local var_488_5 = arg_485_1:FormatText(var_488_4.content)

				arg_485_1.text_.text = var_488_5

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_7 = 12 <= 0 and var_488_3 or var_488_3 * (utf8.len(var_488_5) / 12)

				if (12 <= 0 and var_488_3 or var_488_3 * (utf8.len(var_488_5) / 12)) > 0 and var_488_3 < var_488_7 then
					arg_485_1.talkMaxDuration = var_488_7

					if var_488_7 + var_488_2 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_7 + var_488_2
					end
				end

				arg_485_1.text_.text = var_488_5
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305124", "story_v_side_new_1109305.awb") ~= 0 then
					local var_488_8 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305124", "story_v_side_new_1109305.awb") / 1000

					if var_488_8 + var_488_2 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_8 + var_488_2
					end

					if var_488_4.prefab_name ~= "" and arg_485_1.actors_[var_488_4.prefab_name] ~= nil then
						local var_488_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_4.prefab_name].transform, "story_v_side_new_1109305", "1109305124", "story_v_side_new_1109305.awb")

						arg_485_1:RecordAudio("1109305124", var_488_9)
						arg_485_1:RecordAudio("1109305124", var_488_9)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305124", "story_v_side_new_1109305.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305124", "story_v_side_new_1109305.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_10 = math.max(var_488_3, arg_485_1.talkMaxDuration)

			if var_488_2 <= arg_485_1.time_ and arg_485_1.time_ < var_488_2 + var_488_10 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_2) / var_488_10

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_2 + var_488_10 and arg_485_1.time_ < var_488_2 + var_488_10 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play1109305125 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 1109305125
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play1109305126(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 and not isNil(arg_489_1.actors_["1093ui_story"]) and arg_489_1.var_.characterEffect1093ui_story == nil then
				arg_489_1.var_.characterEffect1093ui_story = arg_489_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_492_0 = 0.200000002980232

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_0 and not isNil(arg_489_1.actors_["1093ui_story"]) then
				if arg_489_1.var_.characterEffect1093ui_story and not isNil(arg_489_1.actors_["1093ui_story"]) then
					arg_489_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_489_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_489_1.time_ - 0) / var_492_0)
				end
			end

			if arg_489_1.time_ >= 0 + var_492_0 and arg_489_1.time_ < 0 + var_492_0 + arg_492_0 and not isNil(arg_489_1.actors_["1093ui_story"]) and arg_489_1.var_.characterEffect1093ui_story then
				arg_489_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_489_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_492_1 = 0
			local var_492_2 = 0.475

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_1 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				arg_489_1.leftNameTxt_.text = arg_489_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, true)
				arg_489_1.iconController_:SetSelectedState("hero")

				arg_489_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_489_1.callingController_:SetSelectedState("normal")

				arg_489_1.keyicon_.color = Color.New(1, 1, 1)
				arg_489_1.icon_.color = Color.New(1, 1, 1)

				local var_492_3 = arg_489_1:FormatText(arg_489_1:GetWordFromCfg(1109305125).content)

				arg_489_1.text_.text = var_492_3

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_5 = 19 <= 0 and var_492_2 or var_492_2 * (utf8.len(var_492_3) / 19)

				if (19 <= 0 and var_492_2 or var_492_2 * (utf8.len(var_492_3) / 19)) > 0 and var_492_2 < var_492_5 then
					arg_489_1.talkMaxDuration = var_492_5

					if var_492_5 + var_492_1 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_5 + var_492_1
					end
				end

				arg_489_1.text_.text = var_492_3
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_6 = math.max(var_492_2, arg_489_1.talkMaxDuration)

			if var_492_1 <= arg_489_1.time_ and arg_489_1.time_ < var_492_1 + var_492_6 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_1) / var_492_6

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_1 + var_492_6 and arg_489_1.time_ < var_492_1 + var_492_6 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play1109305126 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 1109305126
		arg_493_1.duration_ = 3.53

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play1109305127(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 and not isNil(arg_493_1.actors_["1093ui_story"]) and arg_493_1.var_.characterEffect1093ui_story == nil then
				arg_493_1.var_.characterEffect1093ui_story = arg_493_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_0 = 0.200000002980232

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_0 and not isNil(arg_493_1.actors_["1093ui_story"]) then
				if arg_493_1.var_.characterEffect1093ui_story and not isNil(arg_493_1.actors_["1093ui_story"]) then
					arg_493_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_493_1.time_ >= 0 + var_496_0 and arg_493_1.time_ < 0 + var_496_0 + arg_496_0 and not isNil(arg_493_1.actors_["1093ui_story"]) and arg_493_1.var_.characterEffect1093ui_story then
				arg_493_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if arg_493_1.frameCnt_ <= 1 then
				arg_493_1.dialog_:SetActive(false)
			end

			local var_496_2 = 0.666666666666667
			local var_496_3 = 0.25

			if 0.666666666666667 < arg_493_1.time_ and arg_493_1.time_ <= var_496_2 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0

				arg_493_1.dialog_:SetActive(true)

				arg_493_1.dialogCg_.alpha = 0

				local var_496_4 = LeanTween.value(arg_493_1.dialog_, 0, 1, 0.3)

				var_496_4:setOnUpdate(LuaHelper.FloatAction(function(arg_497_0)
					arg_493_1.dialogCg_.alpha = arg_497_0
				end))
				var_496_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_493_1.dialog_)
					var_496_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_493_1.duration_ = arg_493_1.duration_ + 0.3

				SetActive(arg_493_1.leftNameGo_, true)

				arg_493_1.leftNameTxt_.text = arg_493_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_5 = arg_493_1:GetWordFromCfg(1109305126)
				local var_496_6 = arg_493_1:FormatText(var_496_5.content)

				arg_493_1.text_.text = var_496_6

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_8 = 10 <= 0 and var_496_3 or var_496_3 * (utf8.len(var_496_6) / 10)

				if (10 <= 0 and var_496_3 or var_496_3 * (utf8.len(var_496_6) / 10)) > 0 and var_496_3 < var_496_8 then
					arg_493_1.talkMaxDuration = var_496_8
					var_496_2 = var_496_2 + 0.3

					if var_496_8 + var_496_2 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_8 + var_496_2
					end
				end

				arg_493_1.text_.text = var_496_6
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305126", "story_v_side_new_1109305.awb") ~= 0 then
					local var_496_9 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305126", "story_v_side_new_1109305.awb") / 1000

					if var_496_9 + var_496_2 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_9 + var_496_2
					end

					if var_496_5.prefab_name ~= "" and arg_493_1.actors_[var_496_5.prefab_name] ~= nil then
						local var_496_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_493_1.actors_[var_496_5.prefab_name].transform, "story_v_side_new_1109305", "1109305126", "story_v_side_new_1109305.awb")

						arg_493_1:RecordAudio("1109305126", var_496_10)
						arg_493_1:RecordAudio("1109305126", var_496_10)
					else
						arg_493_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305126", "story_v_side_new_1109305.awb")
					end

					arg_493_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305126", "story_v_side_new_1109305.awb")
				end

				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_11 = var_496_2 + 0.3
			local var_496_12 = math.max(var_496_3, arg_493_1.talkMaxDuration)

			if var_496_2 + 0.3 <= arg_493_1.time_ and arg_493_1.time_ < var_496_11 + var_496_12 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_11) / var_496_12

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_11 + var_496_12 and arg_493_1.time_ < var_496_11 + var_496_12 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	Play1109305127 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 1109305127
		arg_499_1.duration_ = 5

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play1109305128(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1.var_.moveOldPos1093ui_story = arg_499_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_502_0 = 0.001

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_0 then
				arg_499_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_499_1.time_ - 0) / var_502_0)
				arg_499_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_499_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["1093ui_story"].transform.position).z)
				arg_499_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_499_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_499_1.actors_["1093ui_story"].transform.localEulerAngles = arg_499_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_499_1.time_ >= 0 + var_502_0 and arg_499_1.time_ < 0 + var_502_0 + arg_502_0 then
				arg_499_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_499_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_499_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["1093ui_story"].transform.position).z)
				arg_499_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_499_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_499_1.actors_["1093ui_story"].transform.localEulerAngles = arg_499_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_502_1 = arg_499_1.actors_["1093ui_story"]

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 and not isNil(var_502_1) and arg_499_1.var_.characterEffect1093ui_story == nil then
				arg_499_1.var_.characterEffect1093ui_story = var_502_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_502_2 = 0.200000002980232

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_2 and not isNil(var_502_1) then
				if arg_499_1.var_.characterEffect1093ui_story and not isNil(var_502_1) then
					arg_499_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_499_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_499_1.time_ - 0) / var_502_2)
				end
			end

			if arg_499_1.time_ >= 0 + var_502_2 and arg_499_1.time_ < 0 + var_502_2 + arg_502_0 and not isNil(var_502_1) and arg_499_1.var_.characterEffect1093ui_story then
				arg_499_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_499_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_502_3 = 0
			local var_502_4 = 0.875

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_3 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, false)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_5 = arg_499_1:FormatText(arg_499_1:GetWordFromCfg(1109305127).content)

				arg_499_1.text_.text = var_502_5

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_7 = 35 <= 0 and var_502_4 or var_502_4 * (utf8.len(var_502_5) / 35)

				if (35 <= 0 and var_502_4 or var_502_4 * (utf8.len(var_502_5) / 35)) > 0 and var_502_4 < var_502_7 then
					arg_499_1.talkMaxDuration = var_502_7

					if var_502_7 + var_502_3 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_7 + var_502_3
					end
				end

				arg_499_1.text_.text = var_502_5
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)
				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_8 = math.max(var_502_4, arg_499_1.talkMaxDuration)

			if var_502_3 <= arg_499_1.time_ and arg_499_1.time_ < var_502_3 + var_502_8 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_3) / var_502_8

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_3 + var_502_8 and arg_499_1.time_ < var_502_3 + var_502_8 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {
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

		arg_499_1:InitPlayNodeList()
	end,
	Play1109305128 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 1109305128
		arg_503_1.duration_ = 1.63

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play1109305129(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = 0.05

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				arg_503_1.leftNameTxt_.text = arg_503_1:FormatText(StoryNameCfg[1056].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, true)
				arg_503_1.iconController_:SetSelectedState("hero")

				arg_503_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10056_b")

				arg_503_1.callingController_:SetSelectedState("normal")

				arg_503_1.keyicon_.color = Color.New(1, 1, 1)
				arg_503_1.icon_.color = Color.New(1, 1, 1)

				local var_506_1 = arg_503_1:GetWordFromCfg(1109305128)
				local var_506_2 = arg_503_1:FormatText(var_506_1.content)

				arg_503_1.text_.text = var_506_2

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_4 = 2 <= 0 and var_506_0 or var_506_0 * (utf8.len(var_506_2) / 2)

				if (2 <= 0 and var_506_0 or var_506_0 * (utf8.len(var_506_2) / 2)) > 0 and var_506_0 < var_506_4 then
					arg_503_1.talkMaxDuration = var_506_4

					if var_506_4 + 0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_4 + 0
					end
				end

				arg_503_1.text_.text = var_506_2
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305128", "story_v_side_new_1109305.awb") ~= 0 then
					local var_506_5 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305128", "story_v_side_new_1109305.awb") / 1000

					if var_506_5 + 0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_5 + 0
					end

					if var_506_1.prefab_name ~= "" and arg_503_1.actors_[var_506_1.prefab_name] ~= nil then
						local var_506_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_1.prefab_name].transform, "story_v_side_new_1109305", "1109305128", "story_v_side_new_1109305.awb")

						arg_503_1:RecordAudio("1109305128", var_506_6)
						arg_503_1:RecordAudio("1109305128", var_506_6)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305128", "story_v_side_new_1109305.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305128", "story_v_side_new_1109305.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_7 = math.max(var_506_0, arg_503_1.talkMaxDuration)

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_7 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - 0) / var_506_7

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= 0 + var_506_7 and arg_503_1.time_ < 0 + var_506_7 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play1109305129 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 1109305129
		arg_507_1.duration_ = 4.23

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play1109305130(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1.var_.moveOldPos1093ui_story = arg_507_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_510_0 = 0.001

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_0 then
				arg_507_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_507_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_507_1.time_ - 0) / var_510_0)
				arg_507_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_507_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["1093ui_story"].transform.position).z)
				arg_507_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_507_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_507_1.actors_["1093ui_story"].transform.localEulerAngles = arg_507_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_507_1.time_ >= 0 + var_510_0 and arg_507_1.time_ < 0 + var_510_0 + arg_510_0 then
				arg_507_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_507_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_507_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["1093ui_story"].transform.position).z)
				arg_507_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_507_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_507_1.actors_["1093ui_story"].transform.localEulerAngles = arg_507_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_510_1 = arg_507_1.actors_["1093ui_story"]

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 and not isNil(var_510_1) and arg_507_1.var_.characterEffect1093ui_story == nil then
				arg_507_1.var_.characterEffect1093ui_story = var_510_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_510_2 = 0.200000002980232

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_2 and not isNil(var_510_1) then
				if arg_507_1.var_.characterEffect1093ui_story and not isNil(var_510_1) then
					arg_507_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_507_1.time_ >= 0 + var_510_2 and arg_507_1.time_ < 0 + var_510_2 + arg_510_0 and not isNil(var_510_1) and arg_507_1.var_.characterEffect1093ui_story then
				arg_507_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action446")
			end

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_510_4 = 0
			local var_510_5 = 0.45

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_4 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				arg_507_1.leftNameTxt_.text = arg_507_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_6 = arg_507_1:GetWordFromCfg(1109305129)
				local var_510_7 = arg_507_1:FormatText(var_510_6.content)

				arg_507_1.text_.text = var_510_7

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_9 = 18 <= 0 and var_510_5 or var_510_5 * (utf8.len(var_510_7) / 18)

				if (18 <= 0 and var_510_5 or var_510_5 * (utf8.len(var_510_7) / 18)) > 0 and var_510_5 < var_510_9 then
					arg_507_1.talkMaxDuration = var_510_9

					if var_510_9 + var_510_4 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_9 + var_510_4
					end
				end

				arg_507_1.text_.text = var_510_7
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305129", "story_v_side_new_1109305.awb") ~= 0 then
					local var_510_10 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305129", "story_v_side_new_1109305.awb") / 1000

					if var_510_10 + var_510_4 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_10 + var_510_4
					end

					if var_510_6.prefab_name ~= "" and arg_507_1.actors_[var_510_6.prefab_name] ~= nil then
						local var_510_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_507_1.actors_[var_510_6.prefab_name].transform, "story_v_side_new_1109305", "1109305129", "story_v_side_new_1109305.awb")

						arg_507_1:RecordAudio("1109305129", var_510_11)
						arg_507_1:RecordAudio("1109305129", var_510_11)
					else
						arg_507_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305129", "story_v_side_new_1109305.awb")
					end

					arg_507_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305129", "story_v_side_new_1109305.awb")
				end

				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_12 = math.max(var_510_5, arg_507_1.talkMaxDuration)

			if var_510_4 <= arg_507_1.time_ and arg_507_1.time_ < var_510_4 + var_510_12 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_4) / var_510_12

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_4 + var_510_12 and arg_507_1.time_ < var_510_4 + var_510_12 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {
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

		arg_507_1:InitPlayNodeList()
	end,
	Play1109305130 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 1109305130
		arg_511_1.duration_ = 5

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play1109305131(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 and not isNil(arg_511_1.actors_["1093ui_story"]) and arg_511_1.var_.characterEffect1093ui_story == nil then
				arg_511_1.var_.characterEffect1093ui_story = arg_511_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_514_0 = 0.200000002980232

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_0 and not isNil(arg_511_1.actors_["1093ui_story"]) then
				if arg_511_1.var_.characterEffect1093ui_story and not isNil(arg_511_1.actors_["1093ui_story"]) then
					arg_511_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_511_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_511_1.time_ - 0) / var_514_0)
				end
			end

			if arg_511_1.time_ >= 0 + var_514_0 and arg_511_1.time_ < 0 + var_514_0 + arg_514_0 and not isNil(arg_511_1.actors_["1093ui_story"]) and arg_511_1.var_.characterEffect1093ui_story then
				arg_511_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_511_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_514_1 = 0
			local var_514_2 = 0.375

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_1 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, false)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_3 = arg_511_1:FormatText(arg_511_1:GetWordFromCfg(1109305130).content)

				arg_511_1.text_.text = var_514_3

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_5 = 15 <= 0 and var_514_2 or var_514_2 * (utf8.len(var_514_3) / 15)

				if (15 <= 0 and var_514_2 or var_514_2 * (utf8.len(var_514_3) / 15)) > 0 and var_514_2 < var_514_5 then
					arg_511_1.talkMaxDuration = var_514_5

					if var_514_5 + var_514_1 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_5 + var_514_1
					end
				end

				arg_511_1.text_.text = var_514_3
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)
				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_6 = math.max(var_514_2, arg_511_1.talkMaxDuration)

			if var_514_1 <= arg_511_1.time_ and arg_511_1.time_ < var_514_1 + var_514_6 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_1) / var_514_6

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_1 + var_514_6 and arg_511_1.time_ < var_514_1 + var_514_6 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play1109305131 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 1109305131
		arg_515_1.duration_ = 1.87

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play1109305132(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = 0.25

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				arg_515_1.leftNameTxt_.text = arg_515_1:FormatText(StoryNameCfg[1056].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, true)
				arg_515_1.iconController_:SetSelectedState("hero")

				arg_515_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10056_b")

				arg_515_1.callingController_:SetSelectedState("normal")

				arg_515_1.keyicon_.color = Color.New(1, 1, 1)
				arg_515_1.icon_.color = Color.New(1, 1, 1)

				local var_518_1 = arg_515_1:GetWordFromCfg(1109305131)
				local var_518_2 = arg_515_1:FormatText(var_518_1.content)

				arg_515_1.text_.text = var_518_2

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_4 = 10 <= 0 and var_518_0 or var_518_0 * (utf8.len(var_518_2) / 10)

				if (10 <= 0 and var_518_0 or var_518_0 * (utf8.len(var_518_2) / 10)) > 0 and var_518_0 < var_518_4 then
					arg_515_1.talkMaxDuration = var_518_4

					if var_518_4 + 0 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_4 + 0
					end
				end

				arg_515_1.text_.text = var_518_2
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305131", "story_v_side_new_1109305.awb") ~= 0 then
					local var_518_5 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305131", "story_v_side_new_1109305.awb") / 1000

					if var_518_5 + 0 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_5 + 0
					end

					if var_518_1.prefab_name ~= "" and arg_515_1.actors_[var_518_1.prefab_name] ~= nil then
						local var_518_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_1.prefab_name].transform, "story_v_side_new_1109305", "1109305131", "story_v_side_new_1109305.awb")

						arg_515_1:RecordAudio("1109305131", var_518_6)
						arg_515_1:RecordAudio("1109305131", var_518_6)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305131", "story_v_side_new_1109305.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305131", "story_v_side_new_1109305.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_7 = math.max(var_518_0, arg_515_1.talkMaxDuration)

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_7 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - 0) / var_518_7

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= 0 + var_518_7 and arg_515_1.time_ < 0 + var_518_7 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play1109305132 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 1109305132
		arg_519_1.duration_ = 4.3

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play1109305133(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 and not isNil(arg_519_1.actors_["1093ui_story"]) and arg_519_1.var_.characterEffect1093ui_story == nil then
				arg_519_1.var_.characterEffect1093ui_story = arg_519_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_522_0 = 0.200000002980232

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_0 and not isNil(arg_519_1.actors_["1093ui_story"]) then
				if arg_519_1.var_.characterEffect1093ui_story and not isNil(arg_519_1.actors_["1093ui_story"]) then
					arg_519_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_519_1.time_ >= 0 + var_522_0 and arg_519_1.time_ < 0 + var_522_0 + arg_522_0 and not isNil(arg_519_1.actors_["1093ui_story"]) and arg_519_1.var_.characterEffect1093ui_story then
				arg_519_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_522_2 = 0
			local var_522_3 = 0.5

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_2 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				arg_519_1.leftNameTxt_.text = arg_519_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_4 = arg_519_1:GetWordFromCfg(1109305132)
				local var_522_5 = arg_519_1:FormatText(var_522_4.content)

				arg_519_1.text_.text = var_522_5

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_7 = 31 <= 0 and var_522_3 or var_522_3 * (utf8.len(var_522_5) / 31)

				if (31 <= 0 and var_522_3 or var_522_3 * (utf8.len(var_522_5) / 31)) > 0 and var_522_3 < var_522_7 then
					arg_519_1.talkMaxDuration = var_522_7

					if var_522_7 + var_522_2 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_7 + var_522_2
					end
				end

				arg_519_1.text_.text = var_522_5
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305132", "story_v_side_new_1109305.awb") ~= 0 then
					local var_522_8 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305132", "story_v_side_new_1109305.awb") / 1000

					if var_522_8 + var_522_2 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_8 + var_522_2
					end

					if var_522_4.prefab_name ~= "" and arg_519_1.actors_[var_522_4.prefab_name] ~= nil then
						local var_522_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_4.prefab_name].transform, "story_v_side_new_1109305", "1109305132", "story_v_side_new_1109305.awb")

						arg_519_1:RecordAudio("1109305132", var_522_9)
						arg_519_1:RecordAudio("1109305132", var_522_9)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305132", "story_v_side_new_1109305.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305132", "story_v_side_new_1109305.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_10 = math.max(var_522_3, arg_519_1.talkMaxDuration)

			if var_522_2 <= arg_519_1.time_ and arg_519_1.time_ < var_522_2 + var_522_10 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_2) / var_522_10

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_2 + var_522_10 and arg_519_1.time_ < var_522_2 + var_522_10 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play1109305133 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 1109305133
		arg_523_1.duration_ = 5

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play1109305134(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 and not isNil(arg_523_1.actors_["1093ui_story"]) and arg_523_1.var_.characterEffect1093ui_story == nil then
				arg_523_1.var_.characterEffect1093ui_story = arg_523_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_526_0 = 0.200000002980232

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_0 and not isNil(arg_523_1.actors_["1093ui_story"]) then
				if arg_523_1.var_.characterEffect1093ui_story and not isNil(arg_523_1.actors_["1093ui_story"]) then
					arg_523_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_523_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_523_1.time_ - 0) / var_526_0)
				end
			end

			if arg_523_1.time_ >= 0 + var_526_0 and arg_523_1.time_ < 0 + var_526_0 + arg_526_0 and not isNil(arg_523_1.actors_["1093ui_story"]) and arg_523_1.var_.characterEffect1093ui_story then
				arg_523_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_523_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_526_1 = 0
			local var_526_2 = 0.525

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= var_526_1 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, false)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_3 = arg_523_1:FormatText(arg_523_1:GetWordFromCfg(1109305133).content)

				arg_523_1.text_.text = var_526_3

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_5 = 21 <= 0 and var_526_2 or var_526_2 * (utf8.len(var_526_3) / 21)

				if (21 <= 0 and var_526_2 or var_526_2 * (utf8.len(var_526_3) / 21)) > 0 and var_526_2 < var_526_5 then
					arg_523_1.talkMaxDuration = var_526_5

					if var_526_5 + var_526_1 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_5 + var_526_1
					end
				end

				arg_523_1.text_.text = var_526_3
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_6 = math.max(var_526_2, arg_523_1.talkMaxDuration)

			if var_526_1 <= arg_523_1.time_ and arg_523_1.time_ < var_526_1 + var_526_6 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_1) / var_526_6

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_1 + var_526_6 and arg_523_1.time_ < var_526_1 + var_526_6 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play1109305134 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 1109305134
		arg_527_1.duration_ = 1.7

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play1109305135(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = 0.2

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				arg_527_1.leftNameTxt_.text = arg_527_1:FormatText(StoryNameCfg[1056].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, true)
				arg_527_1.iconController_:SetSelectedState("hero")

				arg_527_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10056_b")

				arg_527_1.callingController_:SetSelectedState("normal")

				arg_527_1.keyicon_.color = Color.New(1, 1, 1)
				arg_527_1.icon_.color = Color.New(1, 1, 1)

				local var_530_1 = arg_527_1:GetWordFromCfg(1109305134)
				local var_530_2 = arg_527_1:FormatText(var_530_1.content)

				arg_527_1.text_.text = var_530_2

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_4 = 8 <= 0 and var_530_0 or var_530_0 * (utf8.len(var_530_2) / 8)

				if (8 <= 0 and var_530_0 or var_530_0 * (utf8.len(var_530_2) / 8)) > 0 and var_530_0 < var_530_4 then
					arg_527_1.talkMaxDuration = var_530_4

					if var_530_4 + 0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_4 + 0
					end
				end

				arg_527_1.text_.text = var_530_2
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305134", "story_v_side_new_1109305.awb") ~= 0 then
					local var_530_5 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305134", "story_v_side_new_1109305.awb") / 1000

					if var_530_5 + 0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_5 + 0
					end

					if var_530_1.prefab_name ~= "" and arg_527_1.actors_[var_530_1.prefab_name] ~= nil then
						local var_530_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_527_1.actors_[var_530_1.prefab_name].transform, "story_v_side_new_1109305", "1109305134", "story_v_side_new_1109305.awb")

						arg_527_1:RecordAudio("1109305134", var_530_6)
						arg_527_1:RecordAudio("1109305134", var_530_6)
					else
						arg_527_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305134", "story_v_side_new_1109305.awb")
					end

					arg_527_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305134", "story_v_side_new_1109305.awb")
				end

				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_7 = math.max(var_530_0, arg_527_1.talkMaxDuration)

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_7 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - 0) / var_530_7

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= 0 + var_530_7 and arg_527_1.time_ < 0 + var_530_7 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play1109305135 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 1109305135
		arg_531_1.duration_ = 6.6

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play1109305136(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 and not isNil(arg_531_1.actors_["1093ui_story"]) and arg_531_1.var_.characterEffect1093ui_story == nil then
				arg_531_1.var_.characterEffect1093ui_story = arg_531_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_534_0 = 0.200000002980232

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_0 and not isNil(arg_531_1.actors_["1093ui_story"]) then
				if arg_531_1.var_.characterEffect1093ui_story and not isNil(arg_531_1.actors_["1093ui_story"]) then
					arg_531_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_531_1.time_ >= 0 + var_534_0 and arg_531_1.time_ < 0 + var_534_0 + arg_534_0 and not isNil(arg_531_1.actors_["1093ui_story"]) and arg_531_1.var_.characterEffect1093ui_story then
				arg_531_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_534_2 = 0
			local var_534_3 = 0.75

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= var_534_2 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				arg_531_1.leftNameTxt_.text = arg_531_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_4 = arg_531_1:GetWordFromCfg(1109305135)
				local var_534_5 = arg_531_1:FormatText(var_534_4.content)

				arg_531_1.text_.text = var_534_5

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_7 = 30 <= 0 and var_534_3 or var_534_3 * (utf8.len(var_534_5) / 30)

				if (30 <= 0 and var_534_3 or var_534_3 * (utf8.len(var_534_5) / 30)) > 0 and var_534_3 < var_534_7 then
					arg_531_1.talkMaxDuration = var_534_7

					if var_534_7 + var_534_2 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_7 + var_534_2
					end
				end

				arg_531_1.text_.text = var_534_5
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305135", "story_v_side_new_1109305.awb") ~= 0 then
					local var_534_8 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305135", "story_v_side_new_1109305.awb") / 1000

					if var_534_8 + var_534_2 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_8 + var_534_2
					end

					if var_534_4.prefab_name ~= "" and arg_531_1.actors_[var_534_4.prefab_name] ~= nil then
						local var_534_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_531_1.actors_[var_534_4.prefab_name].transform, "story_v_side_new_1109305", "1109305135", "story_v_side_new_1109305.awb")

						arg_531_1:RecordAudio("1109305135", var_534_9)
						arg_531_1:RecordAudio("1109305135", var_534_9)
					else
						arg_531_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305135", "story_v_side_new_1109305.awb")
					end

					arg_531_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305135", "story_v_side_new_1109305.awb")
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
	Play1109305136 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 1109305136
		arg_535_1.duration_ = 4.73

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play1109305137(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 and not isNil(arg_535_1.actors_["1093ui_story"]) and arg_535_1.var_.characterEffect1093ui_story == nil then
				arg_535_1.var_.characterEffect1093ui_story = arg_535_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_538_0 = 0.200000002980232

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_0 and not isNil(arg_535_1.actors_["1093ui_story"]) then
				if arg_535_1.var_.characterEffect1093ui_story and not isNil(arg_535_1.actors_["1093ui_story"]) then
					arg_535_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_535_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_535_1.time_ - 0) / var_538_0)
				end
			end

			if arg_535_1.time_ >= 0 + var_538_0 and arg_535_1.time_ < 0 + var_538_0 + arg_538_0 and not isNil(arg_535_1.actors_["1093ui_story"]) and arg_535_1.var_.characterEffect1093ui_story then
				arg_535_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_535_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_538_1 = 0
			local var_538_2 = 0.65

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= var_538_1 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				arg_535_1.leftNameTxt_.text = arg_535_1:FormatText(StoryNameCfg[1056].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, true)
				arg_535_1.iconController_:SetSelectedState("hero")

				arg_535_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10056_b")

				arg_535_1.callingController_:SetSelectedState("normal")

				arg_535_1.keyicon_.color = Color.New(1, 1, 1)
				arg_535_1.icon_.color = Color.New(1, 1, 1)

				local var_538_3 = arg_535_1:GetWordFromCfg(1109305136)
				local var_538_4 = arg_535_1:FormatText(var_538_3.content)

				arg_535_1.text_.text = var_538_4

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_6 = 26 <= 0 and var_538_2 or var_538_2 * (utf8.len(var_538_4) / 26)

				if (26 <= 0 and var_538_2 or var_538_2 * (utf8.len(var_538_4) / 26)) > 0 and var_538_2 < var_538_6 then
					arg_535_1.talkMaxDuration = var_538_6

					if var_538_6 + var_538_1 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_6 + var_538_1
					end
				end

				arg_535_1.text_.text = var_538_4
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305136", "story_v_side_new_1109305.awb") ~= 0 then
					local var_538_7 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305136", "story_v_side_new_1109305.awb") / 1000

					if var_538_7 + var_538_1 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_7 + var_538_1
					end

					if var_538_3.prefab_name ~= "" and arg_535_1.actors_[var_538_3.prefab_name] ~= nil then
						local var_538_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_535_1.actors_[var_538_3.prefab_name].transform, "story_v_side_new_1109305", "1109305136", "story_v_side_new_1109305.awb")

						arg_535_1:RecordAudio("1109305136", var_538_8)
						arg_535_1:RecordAudio("1109305136", var_538_8)
					else
						arg_535_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305136", "story_v_side_new_1109305.awb")
					end

					arg_535_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305136", "story_v_side_new_1109305.awb")
				end

				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_9 = math.max(var_538_2, arg_535_1.talkMaxDuration)

			if var_538_1 <= arg_535_1.time_ and arg_535_1.time_ < var_538_1 + var_538_9 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_1) / var_538_9

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_1 + var_538_9 and arg_535_1.time_ < var_538_1 + var_538_9 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {}

		arg_535_1:InitPlayNodeList()
	end,
	Play1109305137 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 1109305137
		arg_539_1.duration_ = 9.57

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play1109305138(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 then
				arg_539_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_2")
			end

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 then
				arg_539_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_542_0 = arg_539_1.actors_["1093ui_story"]

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 and not isNil(var_542_0) and arg_539_1.var_.characterEffect1093ui_story == nil then
				arg_539_1.var_.characterEffect1093ui_story = var_542_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_542_1 = 0.200000002980232

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_1 and not isNil(var_542_0) then
				if arg_539_1.var_.characterEffect1093ui_story and not isNil(var_542_0) then
					arg_539_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_539_1.time_ >= 0 + var_542_1 and arg_539_1.time_ < 0 + var_542_1 + arg_542_0 and not isNil(var_542_0) and arg_539_1.var_.characterEffect1093ui_story then
				arg_539_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_542_3 = 0
			local var_542_4 = 0.9

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= var_542_3 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				arg_539_1.leftNameTxt_.text = arg_539_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, false)
				arg_539_1.callingController_:SetSelectedState("normal")

				local var_542_5 = arg_539_1:GetWordFromCfg(1109305137)
				local var_542_6 = arg_539_1:FormatText(var_542_5.content)

				arg_539_1.text_.text = var_542_6

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_8 = 36 <= 0 and var_542_4 or var_542_4 * (utf8.len(var_542_6) / 36)

				if (36 <= 0 and var_542_4 or var_542_4 * (utf8.len(var_542_6) / 36)) > 0 and var_542_4 < var_542_8 then
					arg_539_1.talkMaxDuration = var_542_8

					if var_542_8 + var_542_3 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_8 + var_542_3
					end
				end

				arg_539_1.text_.text = var_542_6
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305137", "story_v_side_new_1109305.awb") ~= 0 then
					local var_542_9 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305137", "story_v_side_new_1109305.awb") / 1000

					if var_542_9 + var_542_3 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_9 + var_542_3
					end

					if var_542_5.prefab_name ~= "" and arg_539_1.actors_[var_542_5.prefab_name] ~= nil then
						local var_542_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_539_1.actors_[var_542_5.prefab_name].transform, "story_v_side_new_1109305", "1109305137", "story_v_side_new_1109305.awb")

						arg_539_1:RecordAudio("1109305137", var_542_10)
						arg_539_1:RecordAudio("1109305137", var_542_10)
					else
						arg_539_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305137", "story_v_side_new_1109305.awb")
					end

					arg_539_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305137", "story_v_side_new_1109305.awb")
				end

				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_11 = math.max(var_542_4, arg_539_1.talkMaxDuration)

			if var_542_3 <= arg_539_1.time_ and arg_539_1.time_ < var_542_3 + var_542_11 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_3) / var_542_11

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_3 + var_542_11 and arg_539_1.time_ < var_542_3 + var_542_11 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play1109305138 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 1109305138
		arg_543_1.duration_ = 5

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play1109305139(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 and not isNil(arg_543_1.actors_["1093ui_story"]) and arg_543_1.var_.characterEffect1093ui_story == nil then
				arg_543_1.var_.characterEffect1093ui_story = arg_543_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_546_0 = 0.200000002980232

			if 0 <= arg_543_1.time_ and arg_543_1.time_ < 0 + var_546_0 and not isNil(arg_543_1.actors_["1093ui_story"]) then
				if arg_543_1.var_.characterEffect1093ui_story and not isNil(arg_543_1.actors_["1093ui_story"]) then
					arg_543_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_543_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_543_1.time_ - 0) / var_546_0)
				end
			end

			if arg_543_1.time_ >= 0 + var_546_0 and arg_543_1.time_ < 0 + var_546_0 + arg_546_0 and not isNil(arg_543_1.actors_["1093ui_story"]) and arg_543_1.var_.characterEffect1093ui_story then
				arg_543_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_543_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_546_1 = arg_543_1.actors_["1093ui_story"].transform

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 then
				arg_543_1.var_.moveOldPos1093ui_story = var_546_1.localPosition
			end

			local var_546_2 = 0.001

			if 0 <= arg_543_1.time_ and arg_543_1.time_ < 0 + var_546_2 then
				var_546_1.localPosition = Vector3.Lerp(arg_543_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_543_1.time_ - 0) / var_546_2)
				var_546_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_546_1.position).x, (manager.ui.mainCamera.transform.position - var_546_1.position).y, (manager.ui.mainCamera.transform.position - var_546_1.position).z)
				var_546_1.localEulerAngles.z = 0
				var_546_1.localEulerAngles.x = 0
				var_546_1.localEulerAngles = var_546_1.localEulerAngles
			end

			if arg_543_1.time_ >= 0 + var_546_2 and arg_543_1.time_ < 0 + var_546_2 + arg_546_0 then
				var_546_1.localPosition = Vector3.New(0, 100, 0)
				var_546_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_546_1.position).x, (manager.ui.mainCamera.transform.position - var_546_1.position).y, (manager.ui.mainCamera.transform.position - var_546_1.position).z)
				var_546_1.localEulerAngles.z = 0
				var_546_1.localEulerAngles.x = 0
				var_546_1.localEulerAngles = var_546_1.localEulerAngles
			end

			local var_546_3 = 0
			local var_546_4 = 0.425

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= var_546_3 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, false)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_5 = arg_543_1:FormatText(arg_543_1:GetWordFromCfg(1109305138).content)

				arg_543_1.text_.text = var_546_5

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_7 = 17 <= 0 and var_546_4 or var_546_4 * (utf8.len(var_546_5) / 17)

				if (17 <= 0 and var_546_4 or var_546_4 * (utf8.len(var_546_5) / 17)) > 0 and var_546_4 < var_546_7 then
					arg_543_1.talkMaxDuration = var_546_7

					if var_546_7 + var_546_3 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_7 + var_546_3
					end
				end

				arg_543_1.text_.text = var_546_5
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)
				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_8 = math.max(var_546_4, arg_543_1.talkMaxDuration)

			if var_546_3 <= arg_543_1.time_ and arg_543_1.time_ < var_546_3 + var_546_8 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_3) / var_546_8

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_3 + var_546_8 and arg_543_1.time_ < var_546_3 + var_546_8 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {
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

		arg_543_1:InitPlayNodeList()
	end,
	Play1109305139 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 1109305139
		arg_547_1.duration_ = 5

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play1109305140(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			local var_550_0 = 0.275

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 then
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

				local var_550_1 = arg_547_1:FormatText(arg_547_1:GetWordFromCfg(1109305139).content)

				arg_547_1.text_.text = var_550_1

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_3 = 11 <= 0 and var_550_0 or var_550_0 * (utf8.len(var_550_1) / 11)

				if (11 <= 0 and var_550_0 or var_550_0 * (utf8.len(var_550_1) / 11)) > 0 and var_550_0 < var_550_3 then
					arg_547_1.talkMaxDuration = var_550_3

					if var_550_3 + 0 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_3 + 0
					end
				end

				arg_547_1.text_.text = var_550_1
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)
				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_4 = math.max(var_550_0, arg_547_1.talkMaxDuration)

			if 0 <= arg_547_1.time_ and arg_547_1.time_ < 0 + var_550_4 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - 0) / var_550_4

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= 0 + var_550_4 and arg_547_1.time_ < 0 + var_550_4 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {}

		arg_547_1:InitPlayNodeList()
	end,
	Play1109305140 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 1109305140
		arg_551_1.duration_ = 5

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play1109305141(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			local var_554_0 = 0.325

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

				local var_554_1 = arg_551_1:FormatText(arg_551_1:GetWordFromCfg(1109305140).content)

				arg_551_1.text_.text = var_554_1

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_3 = 13 <= 0 and var_554_0 or var_554_0 * (utf8.len(var_554_1) / 13)

				if (13 <= 0 and var_554_0 or var_554_0 * (utf8.len(var_554_1) / 13)) > 0 and var_554_0 < var_554_3 then
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
	Play1109305141 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 1109305141
		arg_555_1.duration_ = 5

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play1109305142(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			local var_558_0 = 0.575

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

				local var_558_1 = arg_555_1:FormatText(arg_555_1:GetWordFromCfg(1109305141).content)

				arg_555_1.text_.text = var_558_1

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_3 = 23 <= 0 and var_558_0 or var_558_0 * (utf8.len(var_558_1) / 23)

				if (23 <= 0 and var_558_0 or var_558_0 * (utf8.len(var_558_1) / 23)) > 0 and var_558_0 < var_558_3 then
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
	Play1109305142 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 1109305142
		arg_559_1.duration_ = 5.13

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play1109305143(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			local var_562_0 = 0.525

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, true)

				arg_559_1.leftNameTxt_.text = arg_559_1:FormatText(StoryNameCfg[1056].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_559_1.leftNameTxt_.transform)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1.leftNameTxt_.text)
				SetActive(arg_559_1.iconTrs_.gameObject, true)
				arg_559_1.iconController_:SetSelectedState("hero")

				arg_559_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10056_b")

				arg_559_1.callingController_:SetSelectedState("normal")

				arg_559_1.keyicon_.color = Color.New(1, 1, 1)
				arg_559_1.icon_.color = Color.New(1, 1, 1)

				local var_562_1 = arg_559_1:GetWordFromCfg(1109305142)
				local var_562_2 = arg_559_1:FormatText(var_562_1.content)

				arg_559_1.text_.text = var_562_2

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_4 = 21 <= 0 and var_562_0 or var_562_0 * (utf8.len(var_562_2) / 21)

				if (21 <= 0 and var_562_0 or var_562_0 * (utf8.len(var_562_2) / 21)) > 0 and var_562_0 < var_562_4 then
					arg_559_1.talkMaxDuration = var_562_4

					if var_562_4 + 0 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_4 + 0
					end
				end

				arg_559_1.text_.text = var_562_2
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305142", "story_v_side_new_1109305.awb") ~= 0 then
					local var_562_5 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305142", "story_v_side_new_1109305.awb") / 1000

					if var_562_5 + 0 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_5 + 0
					end

					if var_562_1.prefab_name ~= "" and arg_559_1.actors_[var_562_1.prefab_name] ~= nil then
						local var_562_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_559_1.actors_[var_562_1.prefab_name].transform, "story_v_side_new_1109305", "1109305142", "story_v_side_new_1109305.awb")

						arg_559_1:RecordAudio("1109305142", var_562_6)
						arg_559_1:RecordAudio("1109305142", var_562_6)
					else
						arg_559_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305142", "story_v_side_new_1109305.awb")
					end

					arg_559_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305142", "story_v_side_new_1109305.awb")
				end

				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_7 = math.max(var_562_0, arg_559_1.talkMaxDuration)

			if 0 <= arg_559_1.time_ and arg_559_1.time_ < 0 + var_562_7 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - 0) / var_562_7

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= 0 + var_562_7 and arg_559_1.time_ < 0 + var_562_7 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {}

		arg_559_1:InitPlayNodeList()
	end,
	Play1109305143 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 1109305143
		arg_563_1.duration_ = 5

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play1109305144(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			local var_566_0 = 0.275

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, true)

				arg_563_1.leftNameTxt_.text = arg_563_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_563_1.leftNameTxt_.transform)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1.leftNameTxt_.text)
				SetActive(arg_563_1.iconTrs_.gameObject, true)
				arg_563_1.iconController_:SetSelectedState("hero")

				arg_563_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_563_1.callingController_:SetSelectedState("normal")

				arg_563_1.keyicon_.color = Color.New(1, 1, 1)
				arg_563_1.icon_.color = Color.New(1, 1, 1)

				local var_566_1 = arg_563_1:FormatText(arg_563_1:GetWordFromCfg(1109305143).content)

				arg_563_1.text_.text = var_566_1

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_3 = 11 <= 0 and var_566_0 or var_566_0 * (utf8.len(var_566_1) / 11)

				if (11 <= 0 and var_566_0 or var_566_0 * (utf8.len(var_566_1) / 11)) > 0 and var_566_0 < var_566_3 then
					arg_563_1.talkMaxDuration = var_566_3

					if var_566_3 + 0 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_3 + 0
					end
				end

				arg_563_1.text_.text = var_566_1
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)
				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_4 = math.max(var_566_0, arg_563_1.talkMaxDuration)

			if 0 <= arg_563_1.time_ and arg_563_1.time_ < 0 + var_566_4 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - 0) / var_566_4

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= 0 + var_566_4 and arg_563_1.time_ < 0 + var_566_4 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {}

		arg_563_1:InitPlayNodeList()
	end,
	Play1109305144 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 1109305144
		arg_567_1.duration_ = 5

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play1109305145(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			local var_570_0 = 0.625

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= 0 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, false)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_567_1.iconTrs_.gameObject, false)
				arg_567_1.callingController_:SetSelectedState("normal")

				local var_570_1 = arg_567_1:FormatText(arg_567_1:GetWordFromCfg(1109305144).content)

				arg_567_1.text_.text = var_570_1

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_3 = 25 <= 0 and var_570_0 or var_570_0 * (utf8.len(var_570_1) / 25)

				if (25 <= 0 and var_570_0 or var_570_0 * (utf8.len(var_570_1) / 25)) > 0 and var_570_0 < var_570_3 then
					arg_567_1.talkMaxDuration = var_570_3

					if var_570_3 + 0 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_3 + 0
					end
				end

				arg_567_1.text_.text = var_570_1
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)
				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_4 = math.max(var_570_0, arg_567_1.talkMaxDuration)

			if 0 <= arg_567_1.time_ and arg_567_1.time_ < 0 + var_570_4 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - 0) / var_570_4

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= 0 + var_570_4 and arg_567_1.time_ < 0 + var_570_4 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {}

		arg_567_1:InitPlayNodeList()
	end,
	Play1109305145 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 1109305145
		arg_571_1.duration_ = 8.57

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play1109305146(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			local var_574_0 = 0.95

			if 0 < arg_571_1.time_ and arg_571_1.time_ <= 0 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, true)

				arg_571_1.leftNameTxt_.text = arg_571_1:FormatText(StoryNameCfg[1056].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_571_1.leftNameTxt_.transform)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1.leftNameTxt_.text)
				SetActive(arg_571_1.iconTrs_.gameObject, true)
				arg_571_1.iconController_:SetSelectedState("hero")

				arg_571_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10056_b")

				arg_571_1.callingController_:SetSelectedState("normal")

				arg_571_1.keyicon_.color = Color.New(1, 1, 1)
				arg_571_1.icon_.color = Color.New(1, 1, 1)

				local var_574_1 = arg_571_1:GetWordFromCfg(1109305145)
				local var_574_2 = arg_571_1:FormatText(var_574_1.content)

				arg_571_1.text_.text = var_574_2

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_4 = 38 <= 0 and var_574_0 or var_574_0 * (utf8.len(var_574_2) / 38)

				if (38 <= 0 and var_574_0 or var_574_0 * (utf8.len(var_574_2) / 38)) > 0 and var_574_0 < var_574_4 then
					arg_571_1.talkMaxDuration = var_574_4

					if var_574_4 + 0 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_4 + 0
					end
				end

				arg_571_1.text_.text = var_574_2
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305145", "story_v_side_new_1109305.awb") ~= 0 then
					local var_574_5 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305145", "story_v_side_new_1109305.awb") / 1000

					if var_574_5 + 0 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_5 + 0
					end

					if var_574_1.prefab_name ~= "" and arg_571_1.actors_[var_574_1.prefab_name] ~= nil then
						local var_574_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_571_1.actors_[var_574_1.prefab_name].transform, "story_v_side_new_1109305", "1109305145", "story_v_side_new_1109305.awb")

						arg_571_1:RecordAudio("1109305145", var_574_6)
						arg_571_1:RecordAudio("1109305145", var_574_6)
					else
						arg_571_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305145", "story_v_side_new_1109305.awb")
					end

					arg_571_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305145", "story_v_side_new_1109305.awb")
				end

				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_7 = math.max(var_574_0, arg_571_1.talkMaxDuration)

			if 0 <= arg_571_1.time_ and arg_571_1.time_ < 0 + var_574_7 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - 0) / var_574_7

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= 0 + var_574_7 and arg_571_1.time_ < 0 + var_574_7 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {}

		arg_571_1:InitPlayNodeList()
	end,
	Play1109305146 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 1109305146
		arg_575_1.duration_ = 5

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play1109305147(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			local var_578_0 = 1.05

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

				local var_578_1 = arg_575_1:FormatText(arg_575_1:GetWordFromCfg(1109305146).content)

				arg_575_1.text_.text = var_578_1

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_3 = 42 <= 0 and var_578_0 or var_578_0 * (utf8.len(var_578_1) / 42)

				if (42 <= 0 and var_578_0 or var_578_0 * (utf8.len(var_578_1) / 42)) > 0 and var_578_0 < var_578_3 then
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
	Play1109305147 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 1109305147
		arg_579_1.duration_ = 5.03

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play1109305148(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			if 0 < arg_579_1.time_ and arg_579_1.time_ <= 0 + arg_582_0 then
				arg_579_1.var_.moveOldPos1093ui_story = arg_579_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_582_0 = 0.001

			if 0 <= arg_579_1.time_ and arg_579_1.time_ < 0 + var_582_0 then
				arg_579_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_579_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_579_1.time_ - 0) / var_582_0)
				arg_579_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_579_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_579_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_579_1.actors_["1093ui_story"].transform.position).z)
				arg_579_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_579_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_579_1.actors_["1093ui_story"].transform.localEulerAngles = arg_579_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_579_1.time_ >= 0 + var_582_0 and arg_579_1.time_ < 0 + var_582_0 + arg_582_0 then
				arg_579_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_579_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_579_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_579_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_579_1.actors_["1093ui_story"].transform.position).z)
				arg_579_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_579_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_579_1.actors_["1093ui_story"].transform.localEulerAngles = arg_579_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_582_1 = arg_579_1.actors_["1093ui_story"]

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= 0 + arg_582_0 and not isNil(var_582_1) and arg_579_1.var_.characterEffect1093ui_story == nil then
				arg_579_1.var_.characterEffect1093ui_story = var_582_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_582_2 = 0.200000002980232

			if 0 <= arg_579_1.time_ and arg_579_1.time_ < 0 + var_582_2 and not isNil(var_582_1) then
				if arg_579_1.var_.characterEffect1093ui_story and not isNil(var_582_1) then
					arg_579_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_579_1.time_ >= 0 + var_582_2 and arg_579_1.time_ < 0 + var_582_2 + arg_582_0 and not isNil(var_582_1) and arg_579_1.var_.characterEffect1093ui_story then
				arg_579_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= 0 + arg_582_0 then
				arg_579_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= 0 + arg_582_0 then
				arg_579_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_582_4 = 0
			local var_582_5 = 0.525

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= var_582_4 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, true)

				arg_579_1.leftNameTxt_.text = arg_579_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_579_1.leftNameTxt_.transform)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1.leftNameTxt_.text)
				SetActive(arg_579_1.iconTrs_.gameObject, false)
				arg_579_1.callingController_:SetSelectedState("normal")

				local var_582_6 = arg_579_1:GetWordFromCfg(1109305147)
				local var_582_7 = arg_579_1:FormatText(var_582_6.content)

				arg_579_1.text_.text = var_582_7

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_9 = 21 <= 0 and var_582_5 or var_582_5 * (utf8.len(var_582_7) / 21)

				if (21 <= 0 and var_582_5 or var_582_5 * (utf8.len(var_582_7) / 21)) > 0 and var_582_5 < var_582_9 then
					arg_579_1.talkMaxDuration = var_582_9

					if var_582_9 + var_582_4 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_9 + var_582_4
					end
				end

				arg_579_1.text_.text = var_582_7
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305147", "story_v_side_new_1109305.awb") ~= 0 then
					local var_582_10 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305147", "story_v_side_new_1109305.awb") / 1000

					if var_582_10 + var_582_4 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_10 + var_582_4
					end

					if var_582_6.prefab_name ~= "" and arg_579_1.actors_[var_582_6.prefab_name] ~= nil then
						local var_582_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_579_1.actors_[var_582_6.prefab_name].transform, "story_v_side_new_1109305", "1109305147", "story_v_side_new_1109305.awb")

						arg_579_1:RecordAudio("1109305147", var_582_11)
						arg_579_1:RecordAudio("1109305147", var_582_11)
					else
						arg_579_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305147", "story_v_side_new_1109305.awb")
					end

					arg_579_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305147", "story_v_side_new_1109305.awb")
				end

				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_12 = math.max(var_582_5, arg_579_1.talkMaxDuration)

			if var_582_4 <= arg_579_1.time_ and arg_579_1.time_ < var_582_4 + var_582_12 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - var_582_4) / var_582_12

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= var_582_4 + var_582_12 and arg_579_1.time_ < var_582_4 + var_582_12 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {
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

		arg_579_1:InitPlayNodeList()
	end,
	Play1109305148 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 1109305148
		arg_583_1.duration_ = 9.17

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play1109305149(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 then
				arg_583_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 then
				arg_583_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_586_0 = 0
			local var_586_1 = 1

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= var_586_0 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, true)

				arg_583_1.leftNameTxt_.text = arg_583_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_583_1.leftNameTxt_.transform)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1.leftNameTxt_.text)
				SetActive(arg_583_1.iconTrs_.gameObject, false)
				arg_583_1.callingController_:SetSelectedState("normal")

				local var_586_2 = arg_583_1:GetWordFromCfg(1109305148)
				local var_586_3 = arg_583_1:FormatText(var_586_2.content)

				arg_583_1.text_.text = var_586_3

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_5 = 40 <= 0 and var_586_1 or var_586_1 * (utf8.len(var_586_3) / 40)

				if (40 <= 0 and var_586_1 or var_586_1 * (utf8.len(var_586_3) / 40)) > 0 and var_586_1 < var_586_5 then
					arg_583_1.talkMaxDuration = var_586_5

					if var_586_5 + var_586_0 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_5 + var_586_0
					end
				end

				arg_583_1.text_.text = var_586_3
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305148", "story_v_side_new_1109305.awb") ~= 0 then
					local var_586_6 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305148", "story_v_side_new_1109305.awb") / 1000

					if var_586_6 + var_586_0 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_6 + var_586_0
					end

					if var_586_2.prefab_name ~= "" and arg_583_1.actors_[var_586_2.prefab_name] ~= nil then
						local var_586_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_583_1.actors_[var_586_2.prefab_name].transform, "story_v_side_new_1109305", "1109305148", "story_v_side_new_1109305.awb")

						arg_583_1:RecordAudio("1109305148", var_586_7)
						arg_583_1:RecordAudio("1109305148", var_586_7)
					else
						arg_583_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305148", "story_v_side_new_1109305.awb")
					end

					arg_583_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305148", "story_v_side_new_1109305.awb")
				end

				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_8 = math.max(var_586_1, arg_583_1.talkMaxDuration)

			if var_586_0 <= arg_583_1.time_ and arg_583_1.time_ < var_586_0 + var_586_8 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - var_586_0) / var_586_8

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= var_586_0 + var_586_8 and arg_583_1.time_ < var_586_0 + var_586_8 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {}

		arg_583_1:InitPlayNodeList()
	end,
	Play1109305149 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 1109305149
		arg_587_1.duration_ = 5

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play1109305150(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			if 0 < arg_587_1.time_ and arg_587_1.time_ <= 0 + arg_590_0 and not isNil(arg_587_1.actors_["1093ui_story"]) and arg_587_1.var_.characterEffect1093ui_story == nil then
				arg_587_1.var_.characterEffect1093ui_story = arg_587_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_590_0 = 0.200000002980232

			if 0 <= arg_587_1.time_ and arg_587_1.time_ < 0 + var_590_0 and not isNil(arg_587_1.actors_["1093ui_story"]) then
				if arg_587_1.var_.characterEffect1093ui_story and not isNil(arg_587_1.actors_["1093ui_story"]) then
					arg_587_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_587_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_587_1.time_ - 0) / var_590_0)
				end
			end

			if arg_587_1.time_ >= 0 + var_590_0 and arg_587_1.time_ < 0 + var_590_0 + arg_590_0 and not isNil(arg_587_1.actors_["1093ui_story"]) and arg_587_1.var_.characterEffect1093ui_story then
				arg_587_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_587_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_590_1 = 0
			local var_590_2 = 0.175

			if 0 < arg_587_1.time_ and arg_587_1.time_ <= var_590_1 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, true)

				arg_587_1.leftNameTxt_.text = arg_587_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_587_1.leftNameTxt_.transform)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1.leftNameTxt_.text)
				SetActive(arg_587_1.iconTrs_.gameObject, true)
				arg_587_1.iconController_:SetSelectedState("hero")

				arg_587_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_587_1.callingController_:SetSelectedState("normal")

				arg_587_1.keyicon_.color = Color.New(1, 1, 1)
				arg_587_1.icon_.color = Color.New(1, 1, 1)

				local var_590_3 = arg_587_1:FormatText(arg_587_1:GetWordFromCfg(1109305149).content)

				arg_587_1.text_.text = var_590_3

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_5 = 7 <= 0 and var_590_2 or var_590_2 * (utf8.len(var_590_3) / 7)

				if (7 <= 0 and var_590_2 or var_590_2 * (utf8.len(var_590_3) / 7)) > 0 and var_590_2 < var_590_5 then
					arg_587_1.talkMaxDuration = var_590_5

					if var_590_5 + var_590_1 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_5 + var_590_1
					end
				end

				arg_587_1.text_.text = var_590_3
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)
				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_6 = math.max(var_590_2, arg_587_1.talkMaxDuration)

			if var_590_1 <= arg_587_1.time_ and arg_587_1.time_ < var_590_1 + var_590_6 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - var_590_1) / var_590_6

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= var_590_1 + var_590_6 and arg_587_1.time_ < var_590_1 + var_590_6 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {}

		arg_587_1:InitPlayNodeList()
	end,
	Play1109305150 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 1109305150
		arg_591_1.duration_ = 2.4

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
		end

		function arg_591_1.playNext_(arg_593_0)
			if arg_593_0 == 1 then
				arg_591_0:Play1109305151(arg_591_1)
			end
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			if 0 < arg_591_1.time_ and arg_591_1.time_ <= 0 + arg_594_0 and not isNil(arg_591_1.actors_["1093ui_story"]) and arg_591_1.var_.characterEffect1093ui_story == nil then
				arg_591_1.var_.characterEffect1093ui_story = arg_591_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_594_0 = 0.200000002980232

			if 0 <= arg_591_1.time_ and arg_591_1.time_ < 0 + var_594_0 and not isNil(arg_591_1.actors_["1093ui_story"]) then
				if arg_591_1.var_.characterEffect1093ui_story and not isNil(arg_591_1.actors_["1093ui_story"]) then
					arg_591_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_591_1.time_ >= 0 + var_594_0 and arg_591_1.time_ < 0 + var_594_0 + arg_594_0 and not isNil(arg_591_1.actors_["1093ui_story"]) and arg_591_1.var_.characterEffect1093ui_story then
				arg_591_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_594_2 = 0
			local var_594_3 = 0.3

			if 0 < arg_591_1.time_ and arg_591_1.time_ <= var_594_2 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0
				arg_591_1.dialogCg_.alpha = 1

				arg_591_1.dialog_:SetActive(true)
				SetActive(arg_591_1.leftNameGo_, true)

				arg_591_1.leftNameTxt_.text = arg_591_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_591_1.leftNameTxt_.transform)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1.leftNameTxt_.text)
				SetActive(arg_591_1.iconTrs_.gameObject, false)
				arg_591_1.callingController_:SetSelectedState("normal")

				local var_594_4 = arg_591_1:GetWordFromCfg(1109305150)
				local var_594_5 = arg_591_1:FormatText(var_594_4.content)

				arg_591_1.text_.text = var_594_5

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_7 = 12 <= 0 and var_594_3 or var_594_3 * (utf8.len(var_594_5) / 12)

				if (12 <= 0 and var_594_3 or var_594_3 * (utf8.len(var_594_5) / 12)) > 0 and var_594_3 < var_594_7 then
					arg_591_1.talkMaxDuration = var_594_7

					if var_594_7 + var_594_2 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_7 + var_594_2
					end
				end

				arg_591_1.text_.text = var_594_5
				arg_591_1.typewritter.percent = 0

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305150", "story_v_side_new_1109305.awb") ~= 0 then
					local var_594_8 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305150", "story_v_side_new_1109305.awb") / 1000

					if var_594_8 + var_594_2 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_8 + var_594_2
					end

					if var_594_4.prefab_name ~= "" and arg_591_1.actors_[var_594_4.prefab_name] ~= nil then
						local var_594_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_591_1.actors_[var_594_4.prefab_name].transform, "story_v_side_new_1109305", "1109305150", "story_v_side_new_1109305.awb")

						arg_591_1:RecordAudio("1109305150", var_594_9)
						arg_591_1:RecordAudio("1109305150", var_594_9)
					else
						arg_591_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305150", "story_v_side_new_1109305.awb")
					end

					arg_591_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305150", "story_v_side_new_1109305.awb")
				end

				arg_591_1:RecordContent(arg_591_1.text_.text)
			end

			local var_594_10 = math.max(var_594_3, arg_591_1.talkMaxDuration)

			if var_594_2 <= arg_591_1.time_ and arg_591_1.time_ < var_594_2 + var_594_10 then
				arg_591_1.typewritter.percent = (arg_591_1.time_ - var_594_2) / var_594_10

				arg_591_1.typewritter:SetDirty()
			end

			if arg_591_1.time_ >= var_594_2 + var_594_10 and arg_591_1.time_ < var_594_2 + var_594_10 + arg_594_0 then
				arg_591_1.typewritter.percent = 1

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(true)
			end
		end

		arg_591_1.nodeConfigList_ = {}

		arg_591_1:InitPlayNodeList()
	end,
	Play1109305151 = function(arg_595_0, arg_595_1)
		arg_595_1.time_ = 0
		arg_595_1.frameCnt_ = 0
		arg_595_1.state_ = "playing"
		arg_595_1.curTalkId_ = 1109305151
		arg_595_1.duration_ = 6.57

		SetActive(arg_595_1.tipsGo_, false)

		function arg_595_1.onSingleLineFinish_()
			arg_595_1.onSingleLineUpdate_ = nil
			arg_595_1.onSingleLineFinish_ = nil
			arg_595_1.state_ = "waiting"
		end

		function arg_595_1.playNext_(arg_597_0)
			if arg_597_0 == 1 then
				arg_595_0:Play1109305152(arg_595_1)
			end
		end

		function arg_595_1.onSingleLineUpdate_(arg_598_0)
			if 0 < arg_595_1.time_ and arg_595_1.time_ <= 0 + arg_598_0 and not isNil(arg_595_1.actors_["1093ui_story"]) and arg_595_1.var_.characterEffect1093ui_story == nil then
				arg_595_1.var_.characterEffect1093ui_story = arg_595_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_598_0 = 0.200000002980232

			if 0 <= arg_595_1.time_ and arg_595_1.time_ < 0 + var_598_0 and not isNil(arg_595_1.actors_["1093ui_story"]) then
				if arg_595_1.var_.characterEffect1093ui_story and not isNil(arg_595_1.actors_["1093ui_story"]) then
					arg_595_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_595_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_595_1.time_ - 0) / var_598_0)
				end
			end

			if arg_595_1.time_ >= 0 + var_598_0 and arg_595_1.time_ < 0 + var_598_0 + arg_598_0 and not isNil(arg_595_1.actors_["1093ui_story"]) and arg_595_1.var_.characterEffect1093ui_story then
				arg_595_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_595_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_598_1 = 0
			local var_598_2 = 0.725

			if 0 < arg_595_1.time_ and arg_595_1.time_ <= var_598_1 + arg_598_0 then
				arg_595_1.talkMaxDuration = 0
				arg_595_1.dialogCg_.alpha = 1

				arg_595_1.dialog_:SetActive(true)
				SetActive(arg_595_1.leftNameGo_, true)

				arg_595_1.leftNameTxt_.text = arg_595_1:FormatText(StoryNameCfg[1056].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_595_1.leftNameTxt_.transform)

				arg_595_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_595_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_595_1:RecordName(arg_595_1.leftNameTxt_.text)
				SetActive(arg_595_1.iconTrs_.gameObject, true)
				arg_595_1.iconController_:SetSelectedState("hero")

				arg_595_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10056_b")

				arg_595_1.callingController_:SetSelectedState("normal")

				arg_595_1.keyicon_.color = Color.New(1, 1, 1)
				arg_595_1.icon_.color = Color.New(1, 1, 1)

				local var_598_3 = arg_595_1:GetWordFromCfg(1109305151)
				local var_598_4 = arg_595_1:FormatText(var_598_3.content)

				arg_595_1.text_.text = var_598_4

				LuaForUtil.ClearLinePrefixSymbol(arg_595_1.text_)

				local var_598_6 = 29 <= 0 and var_598_2 or var_598_2 * (utf8.len(var_598_4) / 29)

				if (29 <= 0 and var_598_2 or var_598_2 * (utf8.len(var_598_4) / 29)) > 0 and var_598_2 < var_598_6 then
					arg_595_1.talkMaxDuration = var_598_6

					if var_598_6 + var_598_1 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_6 + var_598_1
					end
				end

				arg_595_1.text_.text = var_598_4
				arg_595_1.typewritter.percent = 0

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305151", "story_v_side_new_1109305.awb") ~= 0 then
					local var_598_7 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305151", "story_v_side_new_1109305.awb") / 1000

					if var_598_7 + var_598_1 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_7 + var_598_1
					end

					if var_598_3.prefab_name ~= "" and arg_595_1.actors_[var_598_3.prefab_name] ~= nil then
						local var_598_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_595_1.actors_[var_598_3.prefab_name].transform, "story_v_side_new_1109305", "1109305151", "story_v_side_new_1109305.awb")

						arg_595_1:RecordAudio("1109305151", var_598_8)
						arg_595_1:RecordAudio("1109305151", var_598_8)
					else
						arg_595_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305151", "story_v_side_new_1109305.awb")
					end

					arg_595_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305151", "story_v_side_new_1109305.awb")
				end

				arg_595_1:RecordContent(arg_595_1.text_.text)
			end

			local var_598_9 = math.max(var_598_2, arg_595_1.talkMaxDuration)

			if var_598_1 <= arg_595_1.time_ and arg_595_1.time_ < var_598_1 + var_598_9 then
				arg_595_1.typewritter.percent = (arg_595_1.time_ - var_598_1) / var_598_9

				arg_595_1.typewritter:SetDirty()
			end

			if arg_595_1.time_ >= var_598_1 + var_598_9 and arg_595_1.time_ < var_598_1 + var_598_9 + arg_598_0 then
				arg_595_1.typewritter.percent = 1

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(true)
			end
		end

		arg_595_1.nodeConfigList_ = {}

		arg_595_1:InitPlayNodeList()
	end,
	Play1109305152 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 1109305152
		arg_599_1.duration_ = 6.2

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play1109305153(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			if 0 < arg_599_1.time_ and arg_599_1.time_ <= 0 + arg_602_0 and not isNil(arg_599_1.actors_["1093ui_story"]) and arg_599_1.var_.characterEffect1093ui_story == nil then
				arg_599_1.var_.characterEffect1093ui_story = arg_599_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_602_0 = 0.200000002980232

			if 0 <= arg_599_1.time_ and arg_599_1.time_ < 0 + var_602_0 and not isNil(arg_599_1.actors_["1093ui_story"]) then
				if arg_599_1.var_.characterEffect1093ui_story and not isNil(arg_599_1.actors_["1093ui_story"]) then
					arg_599_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_599_1.time_ >= 0 + var_602_0 and arg_599_1.time_ < 0 + var_602_0 + arg_602_0 and not isNil(arg_599_1.actors_["1093ui_story"]) and arg_599_1.var_.characterEffect1093ui_story then
				arg_599_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_602_2 = 0
			local var_602_3 = 0.75

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= var_602_2 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0
				arg_599_1.dialogCg_.alpha = 1

				arg_599_1.dialog_:SetActive(true)
				SetActive(arg_599_1.leftNameGo_, true)

				arg_599_1.leftNameTxt_.text = arg_599_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_599_1.leftNameTxt_.transform)

				arg_599_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_599_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_599_1:RecordName(arg_599_1.leftNameTxt_.text)
				SetActive(arg_599_1.iconTrs_.gameObject, false)
				arg_599_1.callingController_:SetSelectedState("normal")

				local var_602_4 = arg_599_1:GetWordFromCfg(1109305152)
				local var_602_5 = arg_599_1:FormatText(var_602_4.content)

				arg_599_1.text_.text = var_602_5

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_7 = 30 <= 0 and var_602_3 or var_602_3 * (utf8.len(var_602_5) / 30)

				if (30 <= 0 and var_602_3 or var_602_3 * (utf8.len(var_602_5) / 30)) > 0 and var_602_3 < var_602_7 then
					arg_599_1.talkMaxDuration = var_602_7

					if var_602_7 + var_602_2 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_7 + var_602_2
					end
				end

				arg_599_1.text_.text = var_602_5
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305152", "story_v_side_new_1109305.awb") ~= 0 then
					local var_602_8 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305152", "story_v_side_new_1109305.awb") / 1000

					if var_602_8 + var_602_2 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_8 + var_602_2
					end

					if var_602_4.prefab_name ~= "" and arg_599_1.actors_[var_602_4.prefab_name] ~= nil then
						local var_602_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_599_1.actors_[var_602_4.prefab_name].transform, "story_v_side_new_1109305", "1109305152", "story_v_side_new_1109305.awb")

						arg_599_1:RecordAudio("1109305152", var_602_9)
						arg_599_1:RecordAudio("1109305152", var_602_9)
					else
						arg_599_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305152", "story_v_side_new_1109305.awb")
					end

					arg_599_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305152", "story_v_side_new_1109305.awb")
				end

				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_10 = math.max(var_602_3, arg_599_1.talkMaxDuration)

			if var_602_2 <= arg_599_1.time_ and arg_599_1.time_ < var_602_2 + var_602_10 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - var_602_2) / var_602_10

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= var_602_2 + var_602_10 and arg_599_1.time_ < var_602_2 + var_602_10 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {}

		arg_599_1:InitPlayNodeList()
	end,
	Play1109305153 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 1109305153
		arg_603_1.duration_ = 7.13

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play1109305154(arg_603_1)
			end
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			if 0 < arg_603_1.time_ and arg_603_1.time_ <= 0 + arg_606_0 and not isNil(arg_603_1.actors_["1093ui_story"]) and arg_603_1.var_.characterEffect1093ui_story == nil then
				arg_603_1.var_.characterEffect1093ui_story = arg_603_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_606_0 = 0.200000002980232

			if 0 <= arg_603_1.time_ and arg_603_1.time_ < 0 + var_606_0 and not isNil(arg_603_1.actors_["1093ui_story"]) then
				if arg_603_1.var_.characterEffect1093ui_story and not isNil(arg_603_1.actors_["1093ui_story"]) then
					arg_603_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_603_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_603_1.time_ - 0) / var_606_0)
				end
			end

			if arg_603_1.time_ >= 0 + var_606_0 and arg_603_1.time_ < 0 + var_606_0 + arg_606_0 and not isNil(arg_603_1.actors_["1093ui_story"]) and arg_603_1.var_.characterEffect1093ui_story then
				arg_603_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_603_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_606_1 = 0
			local var_606_2 = 0.65

			if 0 < arg_603_1.time_ and arg_603_1.time_ <= var_606_1 + arg_606_0 then
				arg_603_1.talkMaxDuration = 0
				arg_603_1.dialogCg_.alpha = 1

				arg_603_1.dialog_:SetActive(true)
				SetActive(arg_603_1.leftNameGo_, true)

				arg_603_1.leftNameTxt_.text = arg_603_1:FormatText(StoryNameCfg[1056].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_603_1.leftNameTxt_.transform)

				arg_603_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_603_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_603_1:RecordName(arg_603_1.leftNameTxt_.text)
				SetActive(arg_603_1.iconTrs_.gameObject, true)
				arg_603_1.iconController_:SetSelectedState("hero")

				arg_603_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10056_b")

				arg_603_1.callingController_:SetSelectedState("normal")

				arg_603_1.keyicon_.color = Color.New(1, 1, 1)
				arg_603_1.icon_.color = Color.New(1, 1, 1)

				local var_606_3 = arg_603_1:GetWordFromCfg(1109305153)
				local var_606_4 = arg_603_1:FormatText(var_606_3.content)

				arg_603_1.text_.text = var_606_4

				LuaForUtil.ClearLinePrefixSymbol(arg_603_1.text_)

				local var_606_6 = 26 <= 0 and var_606_2 or var_606_2 * (utf8.len(var_606_4) / 26)

				if (26 <= 0 and var_606_2 or var_606_2 * (utf8.len(var_606_4) / 26)) > 0 and var_606_2 < var_606_6 then
					arg_603_1.talkMaxDuration = var_606_6

					if var_606_6 + var_606_1 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_6 + var_606_1
					end
				end

				arg_603_1.text_.text = var_606_4
				arg_603_1.typewritter.percent = 0

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305153", "story_v_side_new_1109305.awb") ~= 0 then
					local var_606_7 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305153", "story_v_side_new_1109305.awb") / 1000

					if var_606_7 + var_606_1 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_7 + var_606_1
					end

					if var_606_3.prefab_name ~= "" and arg_603_1.actors_[var_606_3.prefab_name] ~= nil then
						local var_606_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_603_1.actors_[var_606_3.prefab_name].transform, "story_v_side_new_1109305", "1109305153", "story_v_side_new_1109305.awb")

						arg_603_1:RecordAudio("1109305153", var_606_8)
						arg_603_1:RecordAudio("1109305153", var_606_8)
					else
						arg_603_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305153", "story_v_side_new_1109305.awb")
					end

					arg_603_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305153", "story_v_side_new_1109305.awb")
				end

				arg_603_1:RecordContent(arg_603_1.text_.text)
			end

			local var_606_9 = math.max(var_606_2, arg_603_1.talkMaxDuration)

			if var_606_1 <= arg_603_1.time_ and arg_603_1.time_ < var_606_1 + var_606_9 then
				arg_603_1.typewritter.percent = (arg_603_1.time_ - var_606_1) / var_606_9

				arg_603_1.typewritter:SetDirty()
			end

			if arg_603_1.time_ >= var_606_1 + var_606_9 and arg_603_1.time_ < var_606_1 + var_606_9 + arg_606_0 then
				arg_603_1.typewritter.percent = 1

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(true)
			end
		end

		arg_603_1.nodeConfigList_ = {}

		arg_603_1:InitPlayNodeList()
	end,
	Play1109305154 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 1109305154
		arg_607_1.duration_ = 8.97

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
		end

		function arg_607_1.playNext_(arg_609_0)
			if arg_609_0 == 1 then
				arg_607_0:Play1109305155(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			if 0 < arg_607_1.time_ and arg_607_1.time_ <= 0 + arg_610_0 and not isNil(arg_607_1.actors_["1093ui_story"]) and arg_607_1.var_.characterEffect1093ui_story == nil then
				arg_607_1.var_.characterEffect1093ui_story = arg_607_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_610_0 = 0.200000002980232

			if 0 <= arg_607_1.time_ and arg_607_1.time_ < 0 + var_610_0 and not isNil(arg_607_1.actors_["1093ui_story"]) then
				if arg_607_1.var_.characterEffect1093ui_story and not isNil(arg_607_1.actors_["1093ui_story"]) then
					arg_607_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_607_1.time_ >= 0 + var_610_0 and arg_607_1.time_ < 0 + var_610_0 + arg_610_0 and not isNil(arg_607_1.actors_["1093ui_story"]) and arg_607_1.var_.characterEffect1093ui_story then
				arg_607_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_607_1.time_ and arg_607_1.time_ <= 0 + arg_610_0 then
				arg_607_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_2")
			end

			if 0 < arg_607_1.time_ and arg_607_1.time_ <= 0 + arg_610_0 then
				arg_607_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_610_2 = 0
			local var_610_3 = 0.975

			if 0 < arg_607_1.time_ and arg_607_1.time_ <= var_610_2 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, true)

				arg_607_1.leftNameTxt_.text = arg_607_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_607_1.leftNameTxt_.transform)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1.leftNameTxt_.text)
				SetActive(arg_607_1.iconTrs_.gameObject, false)
				arg_607_1.callingController_:SetSelectedState("normal")

				local var_610_4 = arg_607_1:GetWordFromCfg(1109305154)
				local var_610_5 = arg_607_1:FormatText(var_610_4.content)

				arg_607_1.text_.text = var_610_5

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_7 = 39 <= 0 and var_610_3 or var_610_3 * (utf8.len(var_610_5) / 39)

				if (39 <= 0 and var_610_3 or var_610_3 * (utf8.len(var_610_5) / 39)) > 0 and var_610_3 < var_610_7 then
					arg_607_1.talkMaxDuration = var_610_7

					if var_610_7 + var_610_2 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_7 + var_610_2
					end
				end

				arg_607_1.text_.text = var_610_5
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305154", "story_v_side_new_1109305.awb") ~= 0 then
					local var_610_8 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305154", "story_v_side_new_1109305.awb") / 1000

					if var_610_8 + var_610_2 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_8 + var_610_2
					end

					if var_610_4.prefab_name ~= "" and arg_607_1.actors_[var_610_4.prefab_name] ~= nil then
						local var_610_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_607_1.actors_[var_610_4.prefab_name].transform, "story_v_side_new_1109305", "1109305154", "story_v_side_new_1109305.awb")

						arg_607_1:RecordAudio("1109305154", var_610_9)
						arg_607_1:RecordAudio("1109305154", var_610_9)
					else
						arg_607_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305154", "story_v_side_new_1109305.awb")
					end

					arg_607_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305154", "story_v_side_new_1109305.awb")
				end

				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_10 = math.max(var_610_3, arg_607_1.talkMaxDuration)

			if var_610_2 <= arg_607_1.time_ and arg_607_1.time_ < var_610_2 + var_610_10 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - var_610_2) / var_610_10

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= var_610_2 + var_610_10 and arg_607_1.time_ < var_610_2 + var_610_10 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {}

		arg_607_1:InitPlayNodeList()
	end,
	Play1109305155 = function(arg_611_0, arg_611_1)
		arg_611_1.time_ = 0
		arg_611_1.frameCnt_ = 0
		arg_611_1.state_ = "playing"
		arg_611_1.curTalkId_ = 1109305155
		arg_611_1.duration_ = 5

		SetActive(arg_611_1.tipsGo_, false)

		function arg_611_1.onSingleLineFinish_()
			arg_611_1.onSingleLineUpdate_ = nil
			arg_611_1.onSingleLineFinish_ = nil
			arg_611_1.state_ = "waiting"
		end

		function arg_611_1.playNext_(arg_613_0)
			if arg_613_0 == 1 then
				arg_611_0:Play1109305156(arg_611_1)
			end
		end

		function arg_611_1.onSingleLineUpdate_(arg_614_0)
			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 and not isNil(arg_611_1.actors_["1093ui_story"]) and arg_611_1.var_.characterEffect1093ui_story == nil then
				arg_611_1.var_.characterEffect1093ui_story = arg_611_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_614_0 = 0.200000002980232

			if 0 <= arg_611_1.time_ and arg_611_1.time_ < 0 + var_614_0 and not isNil(arg_611_1.actors_["1093ui_story"]) then
				if arg_611_1.var_.characterEffect1093ui_story and not isNil(arg_611_1.actors_["1093ui_story"]) then
					arg_611_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_611_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_611_1.time_ - 0) / var_614_0)
				end
			end

			if arg_611_1.time_ >= 0 + var_614_0 and arg_611_1.time_ < 0 + var_614_0 + arg_614_0 and not isNil(arg_611_1.actors_["1093ui_story"]) and arg_611_1.var_.characterEffect1093ui_story then
				arg_611_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_611_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_614_1 = 0
			local var_614_2 = 0.65

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= var_614_1 + arg_614_0 then
				arg_611_1.talkMaxDuration = 0
				arg_611_1.dialogCg_.alpha = 1

				arg_611_1.dialog_:SetActive(true)
				SetActive(arg_611_1.leftNameGo_, true)

				arg_611_1.leftNameTxt_.text = arg_611_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_611_1.leftNameTxt_.transform)

				arg_611_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_611_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_611_1:RecordName(arg_611_1.leftNameTxt_.text)
				SetActive(arg_611_1.iconTrs_.gameObject, true)
				arg_611_1.iconController_:SetSelectedState("hero")

				arg_611_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_611_1.callingController_:SetSelectedState("normal")

				arg_611_1.keyicon_.color = Color.New(1, 1, 1)
				arg_611_1.icon_.color = Color.New(1, 1, 1)

				local var_614_3 = arg_611_1:FormatText(arg_611_1:GetWordFromCfg(1109305155).content)

				arg_611_1.text_.text = var_614_3

				LuaForUtil.ClearLinePrefixSymbol(arg_611_1.text_)

				local var_614_5 = 26 <= 0 and var_614_2 or var_614_2 * (utf8.len(var_614_3) / 26)

				if (26 <= 0 and var_614_2 or var_614_2 * (utf8.len(var_614_3) / 26)) > 0 and var_614_2 < var_614_5 then
					arg_611_1.talkMaxDuration = var_614_5

					if var_614_5 + var_614_1 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_5 + var_614_1
					end
				end

				arg_611_1.text_.text = var_614_3
				arg_611_1.typewritter.percent = 0

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(false)
				arg_611_1:RecordContent(arg_611_1.text_.text)
			end

			local var_614_6 = math.max(var_614_2, arg_611_1.talkMaxDuration)

			if var_614_1 <= arg_611_1.time_ and arg_611_1.time_ < var_614_1 + var_614_6 then
				arg_611_1.typewritter.percent = (arg_611_1.time_ - var_614_1) / var_614_6

				arg_611_1.typewritter:SetDirty()
			end

			if arg_611_1.time_ >= var_614_1 + var_614_6 and arg_611_1.time_ < var_614_1 + var_614_6 + arg_614_0 then
				arg_611_1.typewritter.percent = 1

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(true)
			end
		end

		arg_611_1.nodeConfigList_ = {}

		arg_611_1:InitPlayNodeList()
	end,
	Play1109305156 = function(arg_615_0, arg_615_1)
		arg_615_1.time_ = 0
		arg_615_1.frameCnt_ = 0
		arg_615_1.state_ = "playing"
		arg_615_1.curTalkId_ = 1109305156
		arg_615_1.duration_ = 5

		SetActive(arg_615_1.tipsGo_, false)

		function arg_615_1.onSingleLineFinish_()
			arg_615_1.onSingleLineUpdate_ = nil
			arg_615_1.onSingleLineFinish_ = nil
			arg_615_1.state_ = "waiting"
		end

		function arg_615_1.playNext_(arg_617_0)
			if arg_617_0 == 1 then
				arg_615_0:Play1109305157(arg_615_1)
			end
		end

		function arg_615_1.onSingleLineUpdate_(arg_618_0)
			local var_618_0 = 1.025

			if 0 < arg_615_1.time_ and arg_615_1.time_ <= 0 + arg_618_0 then
				arg_615_1.talkMaxDuration = 0
				arg_615_1.dialogCg_.alpha = 1

				arg_615_1.dialog_:SetActive(true)
				SetActive(arg_615_1.leftNameGo_, true)

				arg_615_1.leftNameTxt_.text = arg_615_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_615_1.leftNameTxt_.transform)

				arg_615_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_615_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_615_1:RecordName(arg_615_1.leftNameTxt_.text)
				SetActive(arg_615_1.iconTrs_.gameObject, true)
				arg_615_1.iconController_:SetSelectedState("hero")

				arg_615_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_615_1.callingController_:SetSelectedState("normal")

				arg_615_1.keyicon_.color = Color.New(1, 1, 1)
				arg_615_1.icon_.color = Color.New(1, 1, 1)

				local var_618_1 = arg_615_1:FormatText(arg_615_1:GetWordFromCfg(1109305156).content)

				arg_615_1.text_.text = var_618_1

				LuaForUtil.ClearLinePrefixSymbol(arg_615_1.text_)

				local var_618_3 = 41 <= 0 and var_618_0 or var_618_0 * (utf8.len(var_618_1) / 41)

				if (41 <= 0 and var_618_0 or var_618_0 * (utf8.len(var_618_1) / 41)) > 0 and var_618_0 < var_618_3 then
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
	Play1109305157 = function(arg_619_0, arg_619_1)
		arg_619_1.time_ = 0
		arg_619_1.frameCnt_ = 0
		arg_619_1.state_ = "playing"
		arg_619_1.curTalkId_ = 1109305157
		arg_619_1.duration_ = 5

		SetActive(arg_619_1.tipsGo_, false)

		function arg_619_1.onSingleLineFinish_()
			arg_619_1.onSingleLineUpdate_ = nil
			arg_619_1.onSingleLineFinish_ = nil
			arg_619_1.state_ = "waiting"
		end

		function arg_619_1.playNext_(arg_621_0)
			if arg_621_0 == 1 then
				arg_619_0:Play1109305158(arg_619_1)
			end
		end

		function arg_619_1.onSingleLineUpdate_(arg_622_0)
			if 0 < arg_619_1.time_ and arg_619_1.time_ <= 0 + arg_622_0 then
				arg_619_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_622_0 = 0
			local var_622_1 = 0.9

			if 0 < arg_619_1.time_ and arg_619_1.time_ <= var_622_0 + arg_622_0 then
				arg_619_1.talkMaxDuration = 0
				arg_619_1.dialogCg_.alpha = 1

				arg_619_1.dialog_:SetActive(true)
				SetActive(arg_619_1.leftNameGo_, false)

				arg_619_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_619_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_619_1:RecordName(arg_619_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_619_1.iconTrs_.gameObject, false)
				arg_619_1.callingController_:SetSelectedState("normal")

				local var_622_2 = arg_619_1:FormatText(arg_619_1:GetWordFromCfg(1109305157).content)

				arg_619_1.text_.text = var_622_2

				LuaForUtil.ClearLinePrefixSymbol(arg_619_1.text_)

				local var_622_4 = 36 <= 0 and var_622_1 or var_622_1 * (utf8.len(var_622_2) / 36)

				if (36 <= 0 and var_622_1 or var_622_1 * (utf8.len(var_622_2) / 36)) > 0 and var_622_1 < var_622_4 then
					arg_619_1.talkMaxDuration = var_622_4

					if var_622_4 + var_622_0 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_4 + var_622_0
					end
				end

				arg_619_1.text_.text = var_622_2
				arg_619_1.typewritter.percent = 0

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(false)
				arg_619_1:RecordContent(arg_619_1.text_.text)
			end

			local var_622_5 = math.max(var_622_1, arg_619_1.talkMaxDuration)

			if var_622_0 <= arg_619_1.time_ and arg_619_1.time_ < var_622_0 + var_622_5 then
				arg_619_1.typewritter.percent = (arg_619_1.time_ - var_622_0) / var_622_5

				arg_619_1.typewritter:SetDirty()
			end

			if arg_619_1.time_ >= var_622_0 + var_622_5 and arg_619_1.time_ < var_622_0 + var_622_5 + arg_622_0 then
				arg_619_1.typewritter.percent = 1

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(true)
			end
		end

		arg_619_1.nodeConfigList_ = {}

		arg_619_1:InitPlayNodeList()
	end,
	Play1109305158 = function(arg_623_0, arg_623_1)
		arg_623_1.time_ = 0
		arg_623_1.frameCnt_ = 0
		arg_623_1.state_ = "playing"
		arg_623_1.curTalkId_ = 1109305158
		arg_623_1.duration_ = 5.6

		SetActive(arg_623_1.tipsGo_, false)

		function arg_623_1.onSingleLineFinish_()
			arg_623_1.onSingleLineUpdate_ = nil
			arg_623_1.onSingleLineFinish_ = nil
			arg_623_1.state_ = "waiting"
		end

		function arg_623_1.playNext_(arg_625_0)
			if arg_625_0 == 1 then
				arg_623_0:Play1109305159(arg_623_1)
			end
		end

		function arg_623_1.onSingleLineUpdate_(arg_626_0)
			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 then
				arg_623_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_626_0 = arg_623_1.actors_["1093ui_story"]

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 and not isNil(var_626_0) and arg_623_1.var_.characterEffect1093ui_story == nil then
				arg_623_1.var_.characterEffect1093ui_story = var_626_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_626_1 = 0.200000002980232

			if 0 <= arg_623_1.time_ and arg_623_1.time_ < 0 + var_626_1 and not isNil(var_626_0) then
				if arg_623_1.var_.characterEffect1093ui_story and not isNil(var_626_0) then
					arg_623_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_623_1.time_ >= 0 + var_626_1 and arg_623_1.time_ < 0 + var_626_1 + arg_626_0 and not isNil(var_626_0) and arg_623_1.var_.characterEffect1093ui_story then
				arg_623_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_626_3 = 0
			local var_626_4 = 0.525

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= var_626_3 + arg_626_0 then
				arg_623_1.talkMaxDuration = 0
				arg_623_1.dialogCg_.alpha = 1

				arg_623_1.dialog_:SetActive(true)
				SetActive(arg_623_1.leftNameGo_, true)

				arg_623_1.leftNameTxt_.text = arg_623_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_623_1.leftNameTxt_.transform)

				arg_623_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_623_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_623_1:RecordName(arg_623_1.leftNameTxt_.text)
				SetActive(arg_623_1.iconTrs_.gameObject, false)
				arg_623_1.callingController_:SetSelectedState("normal")

				local var_626_5 = arg_623_1:GetWordFromCfg(1109305158)
				local var_626_6 = arg_623_1:FormatText(var_626_5.content)

				arg_623_1.text_.text = var_626_6

				LuaForUtil.ClearLinePrefixSymbol(arg_623_1.text_)

				local var_626_8 = 21 <= 0 and var_626_4 or var_626_4 * (utf8.len(var_626_6) / 21)

				if (21 <= 0 and var_626_4 or var_626_4 * (utf8.len(var_626_6) / 21)) > 0 and var_626_4 < var_626_8 then
					arg_623_1.talkMaxDuration = var_626_8

					if var_626_8 + var_626_3 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_8 + var_626_3
					end
				end

				arg_623_1.text_.text = var_626_6
				arg_623_1.typewritter.percent = 0

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305158", "story_v_side_new_1109305.awb") ~= 0 then
					local var_626_9 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305158", "story_v_side_new_1109305.awb") / 1000

					if var_626_9 + var_626_3 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_9 + var_626_3
					end

					if var_626_5.prefab_name ~= "" and arg_623_1.actors_[var_626_5.prefab_name] ~= nil then
						local var_626_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_623_1.actors_[var_626_5.prefab_name].transform, "story_v_side_new_1109305", "1109305158", "story_v_side_new_1109305.awb")

						arg_623_1:RecordAudio("1109305158", var_626_10)
						arg_623_1:RecordAudio("1109305158", var_626_10)
					else
						arg_623_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305158", "story_v_side_new_1109305.awb")
					end

					arg_623_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305158", "story_v_side_new_1109305.awb")
				end

				arg_623_1:RecordContent(arg_623_1.text_.text)
			end

			local var_626_11 = math.max(var_626_4, arg_623_1.talkMaxDuration)

			if var_626_3 <= arg_623_1.time_ and arg_623_1.time_ < var_626_3 + var_626_11 then
				arg_623_1.typewritter.percent = (arg_623_1.time_ - var_626_3) / var_626_11

				arg_623_1.typewritter:SetDirty()
			end

			if arg_623_1.time_ >= var_626_3 + var_626_11 and arg_623_1.time_ < var_626_3 + var_626_11 + arg_626_0 then
				arg_623_1.typewritter.percent = 1

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(true)
			end
		end

		arg_623_1.nodeConfigList_ = {}

		arg_623_1:InitPlayNodeList()
	end,
	Play1109305159 = function(arg_627_0, arg_627_1)
		arg_627_1.time_ = 0
		arg_627_1.frameCnt_ = 0
		arg_627_1.state_ = "playing"
		arg_627_1.curTalkId_ = 1109305159
		arg_627_1.duration_ = 4.1

		SetActive(arg_627_1.tipsGo_, false)

		function arg_627_1.onSingleLineFinish_()
			arg_627_1.onSingleLineUpdate_ = nil
			arg_627_1.onSingleLineFinish_ = nil
			arg_627_1.state_ = "waiting"
		end

		function arg_627_1.playNext_(arg_629_0)
			if arg_629_0 == 1 then
				arg_627_0:Play1109305160(arg_627_1)
			end
		end

		function arg_627_1.onSingleLineUpdate_(arg_630_0)
			if 0 < arg_627_1.time_ and arg_627_1.time_ <= 0 + arg_630_0 and not isNil(arg_627_1.actors_["1093ui_story"]) and arg_627_1.var_.characterEffect1093ui_story == nil then
				arg_627_1.var_.characterEffect1093ui_story = arg_627_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_630_0 = 0.200000002980232

			if 0 <= arg_627_1.time_ and arg_627_1.time_ < 0 + var_630_0 and not isNil(arg_627_1.actors_["1093ui_story"]) then
				if arg_627_1.var_.characterEffect1093ui_story and not isNil(arg_627_1.actors_["1093ui_story"]) then
					arg_627_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_627_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_627_1.time_ - 0) / var_630_0)
				end
			end

			if arg_627_1.time_ >= 0 + var_630_0 and arg_627_1.time_ < 0 + var_630_0 + arg_630_0 and not isNil(arg_627_1.actors_["1093ui_story"]) and arg_627_1.var_.characterEffect1093ui_story then
				arg_627_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_627_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_630_1 = 0
			local var_630_2 = 0.35

			if 0 < arg_627_1.time_ and arg_627_1.time_ <= var_630_1 + arg_630_0 then
				arg_627_1.talkMaxDuration = 0
				arg_627_1.dialogCg_.alpha = 1

				arg_627_1.dialog_:SetActive(true)
				SetActive(arg_627_1.leftNameGo_, true)

				arg_627_1.leftNameTxt_.text = arg_627_1:FormatText(StoryNameCfg[1056].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_627_1.leftNameTxt_.transform)

				arg_627_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_627_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_627_1:RecordName(arg_627_1.leftNameTxt_.text)
				SetActive(arg_627_1.iconTrs_.gameObject, true)
				arg_627_1.iconController_:SetSelectedState("hero")

				arg_627_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10056_b")

				arg_627_1.callingController_:SetSelectedState("normal")

				arg_627_1.keyicon_.color = Color.New(1, 1, 1)
				arg_627_1.icon_.color = Color.New(1, 1, 1)

				local var_630_3 = arg_627_1:GetWordFromCfg(1109305159)
				local var_630_4 = arg_627_1:FormatText(var_630_3.content)

				arg_627_1.text_.text = var_630_4

				LuaForUtil.ClearLinePrefixSymbol(arg_627_1.text_)

				local var_630_6 = 14 <= 0 and var_630_2 or var_630_2 * (utf8.len(var_630_4) / 14)

				if (14 <= 0 and var_630_2 or var_630_2 * (utf8.len(var_630_4) / 14)) > 0 and var_630_2 < var_630_6 then
					arg_627_1.talkMaxDuration = var_630_6

					if var_630_6 + var_630_1 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_6 + var_630_1
					end
				end

				arg_627_1.text_.text = var_630_4
				arg_627_1.typewritter.percent = 0

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305159", "story_v_side_new_1109305.awb") ~= 0 then
					local var_630_7 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305159", "story_v_side_new_1109305.awb") / 1000

					if var_630_7 + var_630_1 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_7 + var_630_1
					end

					if var_630_3.prefab_name ~= "" and arg_627_1.actors_[var_630_3.prefab_name] ~= nil then
						local var_630_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_627_1.actors_[var_630_3.prefab_name].transform, "story_v_side_new_1109305", "1109305159", "story_v_side_new_1109305.awb")

						arg_627_1:RecordAudio("1109305159", var_630_8)
						arg_627_1:RecordAudio("1109305159", var_630_8)
					else
						arg_627_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305159", "story_v_side_new_1109305.awb")
					end

					arg_627_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305159", "story_v_side_new_1109305.awb")
				end

				arg_627_1:RecordContent(arg_627_1.text_.text)
			end

			local var_630_9 = math.max(var_630_2, arg_627_1.talkMaxDuration)

			if var_630_1 <= arg_627_1.time_ and arg_627_1.time_ < var_630_1 + var_630_9 then
				arg_627_1.typewritter.percent = (arg_627_1.time_ - var_630_1) / var_630_9

				arg_627_1.typewritter:SetDirty()
			end

			if arg_627_1.time_ >= var_630_1 + var_630_9 and arg_627_1.time_ < var_630_1 + var_630_9 + arg_630_0 then
				arg_627_1.typewritter.percent = 1

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(true)
			end
		end

		arg_627_1.nodeConfigList_ = {}

		arg_627_1:InitPlayNodeList()
	end,
	Play1109305160 = function(arg_631_0, arg_631_1)
		arg_631_1.time_ = 0
		arg_631_1.frameCnt_ = 0
		arg_631_1.state_ = "playing"
		arg_631_1.curTalkId_ = 1109305160
		arg_631_1.duration_ = 5

		SetActive(arg_631_1.tipsGo_, false)

		function arg_631_1.onSingleLineFinish_()
			arg_631_1.onSingleLineUpdate_ = nil
			arg_631_1.onSingleLineFinish_ = nil
			arg_631_1.state_ = "waiting"
		end

		function arg_631_1.playNext_(arg_633_0)
			if arg_633_0 == 1 then
				arg_631_0:Play1109305161(arg_631_1)
			end
		end

		function arg_631_1.onSingleLineUpdate_(arg_634_0)
			local var_634_0 = 0.175

			if 0 < arg_631_1.time_ and arg_631_1.time_ <= 0 + arg_634_0 then
				arg_631_1.talkMaxDuration = 0
				arg_631_1.dialogCg_.alpha = 1

				arg_631_1.dialog_:SetActive(true)
				SetActive(arg_631_1.leftNameGo_, true)

				arg_631_1.leftNameTxt_.text = arg_631_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_631_1.leftNameTxt_.transform)

				arg_631_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_631_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_631_1:RecordName(arg_631_1.leftNameTxt_.text)
				SetActive(arg_631_1.iconTrs_.gameObject, true)
				arg_631_1.iconController_:SetSelectedState("hero")

				arg_631_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_631_1.callingController_:SetSelectedState("normal")

				arg_631_1.keyicon_.color = Color.New(1, 1, 1)
				arg_631_1.icon_.color = Color.New(1, 1, 1)

				local var_634_1 = arg_631_1:FormatText(arg_631_1:GetWordFromCfg(1109305160).content)

				arg_631_1.text_.text = var_634_1

				LuaForUtil.ClearLinePrefixSymbol(arg_631_1.text_)

				local var_634_3 = 7 <= 0 and var_634_0 or var_634_0 * (utf8.len(var_634_1) / 7)

				if (7 <= 0 and var_634_0 or var_634_0 * (utf8.len(var_634_1) / 7)) > 0 and var_634_0 < var_634_3 then
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
	Play1109305161 = function(arg_635_0, arg_635_1)
		arg_635_1.time_ = 0
		arg_635_1.frameCnt_ = 0
		arg_635_1.state_ = "playing"
		arg_635_1.curTalkId_ = 1109305161
		arg_635_1.duration_ = 5

		SetActive(arg_635_1.tipsGo_, false)

		function arg_635_1.onSingleLineFinish_()
			arg_635_1.onSingleLineUpdate_ = nil
			arg_635_1.onSingleLineFinish_ = nil
			arg_635_1.state_ = "waiting"
		end

		function arg_635_1.playNext_(arg_637_0)
			if arg_637_0 == 1 then
				arg_635_0:Play1109305162(arg_635_1)
			end
		end

		function arg_635_1.onSingleLineUpdate_(arg_638_0)
			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 then
				arg_635_1.var_.moveOldPos1093ui_story = arg_635_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_638_0 = 0.001

			if 0 <= arg_635_1.time_ and arg_635_1.time_ < 0 + var_638_0 then
				arg_635_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_635_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_635_1.time_ - 0) / var_638_0)
				arg_635_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_635_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_635_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_635_1.actors_["1093ui_story"].transform.position).z)
				arg_635_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_635_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_635_1.actors_["1093ui_story"].transform.localEulerAngles = arg_635_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_635_1.time_ >= 0 + var_638_0 and arg_635_1.time_ < 0 + var_638_0 + arg_638_0 then
				arg_635_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_635_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_635_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_635_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_635_1.actors_["1093ui_story"].transform.position).z)
				arg_635_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_635_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_635_1.actors_["1093ui_story"].transform.localEulerAngles = arg_635_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_638_1 = arg_635_1.actors_["1093ui_story"]

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 and not isNil(var_638_1) and arg_635_1.var_.characterEffect1093ui_story == nil then
				arg_635_1.var_.characterEffect1093ui_story = var_638_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_638_2 = 0.200000002980232

			if 0 <= arg_635_1.time_ and arg_635_1.time_ < 0 + var_638_2 and not isNil(var_638_1) then
				if arg_635_1.var_.characterEffect1093ui_story and not isNil(var_638_1) then
					arg_635_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_635_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_635_1.time_ - 0) / var_638_2)
				end
			end

			if arg_635_1.time_ >= 0 + var_638_2 and arg_635_1.time_ < 0 + var_638_2 + arg_638_0 and not isNil(var_638_1) and arg_635_1.var_.characterEffect1093ui_story then
				arg_635_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_635_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_638_3 = 0
			local var_638_4 = 0.475

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= var_638_3 + arg_638_0 then
				arg_635_1.talkMaxDuration = 0
				arg_635_1.dialogCg_.alpha = 1

				arg_635_1.dialog_:SetActive(true)
				SetActive(arg_635_1.leftNameGo_, false)

				arg_635_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_635_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_635_1:RecordName(arg_635_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_635_1.iconTrs_.gameObject, false)
				arg_635_1.callingController_:SetSelectedState("normal")

				local var_638_5 = arg_635_1:FormatText(arg_635_1:GetWordFromCfg(1109305161).content)

				arg_635_1.text_.text = var_638_5

				LuaForUtil.ClearLinePrefixSymbol(arg_635_1.text_)

				local var_638_7 = 19 <= 0 and var_638_4 or var_638_4 * (utf8.len(var_638_5) / 19)

				if (19 <= 0 and var_638_4 or var_638_4 * (utf8.len(var_638_5) / 19)) > 0 and var_638_4 < var_638_7 then
					arg_635_1.talkMaxDuration = var_638_7

					if var_638_7 + var_638_3 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_7 + var_638_3
					end
				end

				arg_635_1.text_.text = var_638_5
				arg_635_1.typewritter.percent = 0

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(false)
				arg_635_1:RecordContent(arg_635_1.text_.text)
			end

			local var_638_8 = math.max(var_638_4, arg_635_1.talkMaxDuration)

			if var_638_3 <= arg_635_1.time_ and arg_635_1.time_ < var_638_3 + var_638_8 then
				arg_635_1.typewritter.percent = (arg_635_1.time_ - var_638_3) / var_638_8

				arg_635_1.typewritter:SetDirty()
			end

			if arg_635_1.time_ >= var_638_3 + var_638_8 and arg_635_1.time_ < var_638_3 + var_638_8 + arg_638_0 then
				arg_635_1.typewritter.percent = 1

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(true)
			end
		end

		arg_635_1.nodeConfigList_ = {
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

		arg_635_1:InitPlayNodeList()
	end,
	Play1109305162 = function(arg_639_0, arg_639_1)
		arg_639_1.time_ = 0
		arg_639_1.frameCnt_ = 0
		arg_639_1.state_ = "playing"
		arg_639_1.curTalkId_ = 1109305162
		arg_639_1.duration_ = 5

		SetActive(arg_639_1.tipsGo_, false)

		function arg_639_1.onSingleLineFinish_()
			arg_639_1.onSingleLineUpdate_ = nil
			arg_639_1.onSingleLineFinish_ = nil
			arg_639_1.state_ = "waiting"
		end

		function arg_639_1.playNext_(arg_641_0)
			if arg_641_0 == 1 then
				arg_639_0:Play1109305163(arg_639_1)
			end
		end

		function arg_639_1.onSingleLineUpdate_(arg_642_0)
			local var_642_0 = 0.75

			if 0 < arg_639_1.time_ and arg_639_1.time_ <= 0 + arg_642_0 then
				arg_639_1.talkMaxDuration = 0
				arg_639_1.dialogCg_.alpha = 1

				arg_639_1.dialog_:SetActive(true)
				SetActive(arg_639_1.leftNameGo_, true)

				arg_639_1.leftNameTxt_.text = arg_639_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_639_1.leftNameTxt_.transform)

				arg_639_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_639_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_639_1:RecordName(arg_639_1.leftNameTxt_.text)
				SetActive(arg_639_1.iconTrs_.gameObject, true)
				arg_639_1.iconController_:SetSelectedState("hero")

				arg_639_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_639_1.callingController_:SetSelectedState("normal")

				arg_639_1.keyicon_.color = Color.New(1, 1, 1)
				arg_639_1.icon_.color = Color.New(1, 1, 1)

				local var_642_1 = arg_639_1:FormatText(arg_639_1:GetWordFromCfg(1109305162).content)

				arg_639_1.text_.text = var_642_1

				LuaForUtil.ClearLinePrefixSymbol(arg_639_1.text_)

				local var_642_3 = 30 <= 0 and var_642_0 or var_642_0 * (utf8.len(var_642_1) / 30)

				if (30 <= 0 and var_642_0 or var_642_0 * (utf8.len(var_642_1) / 30)) > 0 and var_642_0 < var_642_3 then
					arg_639_1.talkMaxDuration = var_642_3

					if var_642_3 + 0 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_3 + 0
					end
				end

				arg_639_1.text_.text = var_642_1
				arg_639_1.typewritter.percent = 0

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(false)
				arg_639_1:RecordContent(arg_639_1.text_.text)
			end

			local var_642_4 = math.max(var_642_0, arg_639_1.talkMaxDuration)

			if 0 <= arg_639_1.time_ and arg_639_1.time_ < 0 + var_642_4 then
				arg_639_1.typewritter.percent = (arg_639_1.time_ - 0) / var_642_4

				arg_639_1.typewritter:SetDirty()
			end

			if arg_639_1.time_ >= 0 + var_642_4 and arg_639_1.time_ < 0 + var_642_4 + arg_642_0 then
				arg_639_1.typewritter.percent = 1

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(true)
			end
		end

		arg_639_1.nodeConfigList_ = {}

		arg_639_1:InitPlayNodeList()
	end,
	Play1109305163 = function(arg_643_0, arg_643_1)
		arg_643_1.time_ = 0
		arg_643_1.frameCnt_ = 0
		arg_643_1.state_ = "playing"
		arg_643_1.curTalkId_ = 1109305163
		arg_643_1.duration_ = 7.57

		SetActive(arg_643_1.tipsGo_, false)

		function arg_643_1.onSingleLineFinish_()
			arg_643_1.onSingleLineUpdate_ = nil
			arg_643_1.onSingleLineFinish_ = nil
			arg_643_1.state_ = "waiting"
		end

		function arg_643_1.playNext_(arg_645_0)
			if arg_645_0 == 1 then
				arg_643_0:Play1109305164(arg_643_1)
			end
		end

		function arg_643_1.onSingleLineUpdate_(arg_646_0)
			if 0 < arg_643_1.time_ and arg_643_1.time_ <= 0 + arg_646_0 then
				arg_643_1.var_.moveOldPos1093ui_story = arg_643_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_646_0 = 0.001

			if 0 <= arg_643_1.time_ and arg_643_1.time_ < 0 + var_646_0 then
				arg_643_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_643_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_643_1.time_ - 0) / var_646_0)
				arg_643_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_643_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_643_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_643_1.actors_["1093ui_story"].transform.position).z)
				arg_643_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_643_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_643_1.actors_["1093ui_story"].transform.localEulerAngles = arg_643_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_643_1.time_ >= 0 + var_646_0 and arg_643_1.time_ < 0 + var_646_0 + arg_646_0 then
				arg_643_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_643_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_643_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_643_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_643_1.actors_["1093ui_story"].transform.position).z)
				arg_643_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_643_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_643_1.actors_["1093ui_story"].transform.localEulerAngles = arg_643_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_646_1 = arg_643_1.actors_["1093ui_story"]

			if 0 < arg_643_1.time_ and arg_643_1.time_ <= 0 + arg_646_0 and not isNil(var_646_1) and arg_643_1.var_.characterEffect1093ui_story == nil then
				arg_643_1.var_.characterEffect1093ui_story = var_646_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_646_2 = 0.200000002980232

			if 0 <= arg_643_1.time_ and arg_643_1.time_ < 0 + var_646_2 and not isNil(var_646_1) then
				if arg_643_1.var_.characterEffect1093ui_story and not isNil(var_646_1) then
					arg_643_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_643_1.time_ >= 0 + var_646_2 and arg_643_1.time_ < 0 + var_646_2 + arg_646_0 and not isNil(var_646_1) and arg_643_1.var_.characterEffect1093ui_story then
				arg_643_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_643_1.time_ and arg_643_1.time_ <= 0 + arg_646_0 then
				arg_643_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action8_1")
			end

			if 0 < arg_643_1.time_ and arg_643_1.time_ <= 0 + arg_646_0 then
				arg_643_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_646_4 = 0
			local var_646_5 = 0.75

			if 0 < arg_643_1.time_ and arg_643_1.time_ <= var_646_4 + arg_646_0 then
				arg_643_1.talkMaxDuration = 0
				arg_643_1.dialogCg_.alpha = 1

				arg_643_1.dialog_:SetActive(true)
				SetActive(arg_643_1.leftNameGo_, true)

				arg_643_1.leftNameTxt_.text = arg_643_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_643_1.leftNameTxt_.transform)

				arg_643_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_643_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_643_1:RecordName(arg_643_1.leftNameTxt_.text)
				SetActive(arg_643_1.iconTrs_.gameObject, false)
				arg_643_1.callingController_:SetSelectedState("normal")

				local var_646_6 = arg_643_1:GetWordFromCfg(1109305163)
				local var_646_7 = arg_643_1:FormatText(var_646_6.content)

				arg_643_1.text_.text = var_646_7

				LuaForUtil.ClearLinePrefixSymbol(arg_643_1.text_)

				local var_646_9 = 30 <= 0 and var_646_5 or var_646_5 * (utf8.len(var_646_7) / 30)

				if (30 <= 0 and var_646_5 or var_646_5 * (utf8.len(var_646_7) / 30)) > 0 and var_646_5 < var_646_9 then
					arg_643_1.talkMaxDuration = var_646_9

					if var_646_9 + var_646_4 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_9 + var_646_4
					end
				end

				arg_643_1.text_.text = var_646_7
				arg_643_1.typewritter.percent = 0

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305163", "story_v_side_new_1109305.awb") ~= 0 then
					local var_646_10 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305163", "story_v_side_new_1109305.awb") / 1000

					if var_646_10 + var_646_4 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_10 + var_646_4
					end

					if var_646_6.prefab_name ~= "" and arg_643_1.actors_[var_646_6.prefab_name] ~= nil then
						local var_646_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_643_1.actors_[var_646_6.prefab_name].transform, "story_v_side_new_1109305", "1109305163", "story_v_side_new_1109305.awb")

						arg_643_1:RecordAudio("1109305163", var_646_11)
						arg_643_1:RecordAudio("1109305163", var_646_11)
					else
						arg_643_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305163", "story_v_side_new_1109305.awb")
					end

					arg_643_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305163", "story_v_side_new_1109305.awb")
				end

				arg_643_1:RecordContent(arg_643_1.text_.text)
			end

			local var_646_12 = math.max(var_646_5, arg_643_1.talkMaxDuration)

			if var_646_4 <= arg_643_1.time_ and arg_643_1.time_ < var_646_4 + var_646_12 then
				arg_643_1.typewritter.percent = (arg_643_1.time_ - var_646_4) / var_646_12

				arg_643_1.typewritter:SetDirty()
			end

			if arg_643_1.time_ >= var_646_4 + var_646_12 and arg_643_1.time_ < var_646_4 + var_646_12 + arg_646_0 then
				arg_643_1.typewritter.percent = 1

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(true)
			end
		end

		arg_643_1.nodeConfigList_ = {
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

		arg_643_1:InitPlayNodeList()
	end,
	Play1109305164 = function(arg_647_0, arg_647_1)
		arg_647_1.time_ = 0
		arg_647_1.frameCnt_ = 0
		arg_647_1.state_ = "playing"
		arg_647_1.curTalkId_ = 1109305164
		arg_647_1.duration_ = 3.6

		SetActive(arg_647_1.tipsGo_, false)

		function arg_647_1.onSingleLineFinish_()
			arg_647_1.onSingleLineUpdate_ = nil
			arg_647_1.onSingleLineFinish_ = nil
			arg_647_1.state_ = "waiting"
		end

		function arg_647_1.playNext_(arg_649_0)
			if arg_649_0 == 1 then
				arg_647_0:Play1109305165(arg_647_1)
			end
		end

		function arg_647_1.onSingleLineUpdate_(arg_650_0)
			local var_650_0 = 0.425

			if 0 < arg_647_1.time_ and arg_647_1.time_ <= 0 + arg_650_0 then
				arg_647_1.talkMaxDuration = 0
				arg_647_1.dialogCg_.alpha = 1

				arg_647_1.dialog_:SetActive(true)
				SetActive(arg_647_1.leftNameGo_, true)

				arg_647_1.leftNameTxt_.text = arg_647_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_647_1.leftNameTxt_.transform)

				arg_647_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_647_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_647_1:RecordName(arg_647_1.leftNameTxt_.text)
				SetActive(arg_647_1.iconTrs_.gameObject, false)
				arg_647_1.callingController_:SetSelectedState("normal")

				local var_650_1 = arg_647_1:GetWordFromCfg(1109305164)
				local var_650_2 = arg_647_1:FormatText(var_650_1.content)

				arg_647_1.text_.text = var_650_2

				LuaForUtil.ClearLinePrefixSymbol(arg_647_1.text_)

				local var_650_4 = 17 <= 0 and var_650_0 or var_650_0 * (utf8.len(var_650_2) / 17)

				if (17 <= 0 and var_650_0 or var_650_0 * (utf8.len(var_650_2) / 17)) > 0 and var_650_0 < var_650_4 then
					arg_647_1.talkMaxDuration = var_650_4

					if var_650_4 + 0 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_4 + 0
					end
				end

				arg_647_1.text_.text = var_650_2
				arg_647_1.typewritter.percent = 0

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305164", "story_v_side_new_1109305.awb") ~= 0 then
					local var_650_5 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305164", "story_v_side_new_1109305.awb") / 1000

					if var_650_5 + 0 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_5 + 0
					end

					if var_650_1.prefab_name ~= "" and arg_647_1.actors_[var_650_1.prefab_name] ~= nil then
						local var_650_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_647_1.actors_[var_650_1.prefab_name].transform, "story_v_side_new_1109305", "1109305164", "story_v_side_new_1109305.awb")

						arg_647_1:RecordAudio("1109305164", var_650_6)
						arg_647_1:RecordAudio("1109305164", var_650_6)
					else
						arg_647_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305164", "story_v_side_new_1109305.awb")
					end

					arg_647_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305164", "story_v_side_new_1109305.awb")
				end

				arg_647_1:RecordContent(arg_647_1.text_.text)
			end

			local var_650_7 = math.max(var_650_0, arg_647_1.talkMaxDuration)

			if 0 <= arg_647_1.time_ and arg_647_1.time_ < 0 + var_650_7 then
				arg_647_1.typewritter.percent = (arg_647_1.time_ - 0) / var_650_7

				arg_647_1.typewritter:SetDirty()
			end

			if arg_647_1.time_ >= 0 + var_650_7 and arg_647_1.time_ < 0 + var_650_7 + arg_650_0 then
				arg_647_1.typewritter.percent = 1

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(true)
			end
		end

		arg_647_1.nodeConfigList_ = {}

		arg_647_1:InitPlayNodeList()
	end,
	Play1109305165 = function(arg_651_0, arg_651_1)
		arg_651_1.time_ = 0
		arg_651_1.frameCnt_ = 0
		arg_651_1.state_ = "playing"
		arg_651_1.curTalkId_ = 1109305165
		arg_651_1.duration_ = 5

		SetActive(arg_651_1.tipsGo_, false)

		function arg_651_1.onSingleLineFinish_()
			arg_651_1.onSingleLineUpdate_ = nil
			arg_651_1.onSingleLineFinish_ = nil
			arg_651_1.state_ = "waiting"
		end

		function arg_651_1.playNext_(arg_653_0)
			if arg_653_0 == 1 then
				arg_651_0:Play1109305166(arg_651_1)
			end
		end

		function arg_651_1.onSingleLineUpdate_(arg_654_0)
			if 0 < arg_651_1.time_ and arg_651_1.time_ <= 0 + arg_654_0 and not isNil(arg_651_1.actors_["1093ui_story"]) and arg_651_1.var_.characterEffect1093ui_story == nil then
				arg_651_1.var_.characterEffect1093ui_story = arg_651_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_654_0 = 0.200000002980232

			if 0 <= arg_651_1.time_ and arg_651_1.time_ < 0 + var_654_0 and not isNil(arg_651_1.actors_["1093ui_story"]) then
				if arg_651_1.var_.characterEffect1093ui_story and not isNil(arg_651_1.actors_["1093ui_story"]) then
					arg_651_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_651_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_651_1.time_ - 0) / var_654_0)
				end
			end

			if arg_651_1.time_ >= 0 + var_654_0 and arg_651_1.time_ < 0 + var_654_0 + arg_654_0 and not isNil(arg_651_1.actors_["1093ui_story"]) and arg_651_1.var_.characterEffect1093ui_story then
				arg_651_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_651_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_654_1 = 0
			local var_654_2 = 0.475

			if 0 < arg_651_1.time_ and arg_651_1.time_ <= var_654_1 + arg_654_0 then
				arg_651_1.talkMaxDuration = 0
				arg_651_1.dialogCg_.alpha = 1

				arg_651_1.dialog_:SetActive(true)
				SetActive(arg_651_1.leftNameGo_, true)

				arg_651_1.leftNameTxt_.text = arg_651_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_651_1.leftNameTxt_.transform)

				arg_651_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_651_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_651_1:RecordName(arg_651_1.leftNameTxt_.text)
				SetActive(arg_651_1.iconTrs_.gameObject, true)
				arg_651_1.iconController_:SetSelectedState("hero")

				arg_651_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_651_1.callingController_:SetSelectedState("normal")

				arg_651_1.keyicon_.color = Color.New(1, 1, 1)
				arg_651_1.icon_.color = Color.New(1, 1, 1)

				local var_654_3 = arg_651_1:FormatText(arg_651_1:GetWordFromCfg(1109305165).content)

				arg_651_1.text_.text = var_654_3

				LuaForUtil.ClearLinePrefixSymbol(arg_651_1.text_)

				local var_654_5 = 19 <= 0 and var_654_2 or var_654_2 * (utf8.len(var_654_3) / 19)

				if (19 <= 0 and var_654_2 or var_654_2 * (utf8.len(var_654_3) / 19)) > 0 and var_654_2 < var_654_5 then
					arg_651_1.talkMaxDuration = var_654_5

					if var_654_5 + var_654_1 > arg_651_1.duration_ then
						arg_651_1.duration_ = var_654_5 + var_654_1
					end
				end

				arg_651_1.text_.text = var_654_3
				arg_651_1.typewritter.percent = 0

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(false)
				arg_651_1:RecordContent(arg_651_1.text_.text)
			end

			local var_654_6 = math.max(var_654_2, arg_651_1.talkMaxDuration)

			if var_654_1 <= arg_651_1.time_ and arg_651_1.time_ < var_654_1 + var_654_6 then
				arg_651_1.typewritter.percent = (arg_651_1.time_ - var_654_1) / var_654_6

				arg_651_1.typewritter:SetDirty()
			end

			if arg_651_1.time_ >= var_654_1 + var_654_6 and arg_651_1.time_ < var_654_1 + var_654_6 + arg_654_0 then
				arg_651_1.typewritter.percent = 1

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(true)
			end
		end

		arg_651_1.nodeConfigList_ = {}

		arg_651_1:InitPlayNodeList()
	end,
	Play1109305166 = function(arg_655_0, arg_655_1)
		arg_655_1.time_ = 0
		arg_655_1.frameCnt_ = 0
		arg_655_1.state_ = "playing"
		arg_655_1.curTalkId_ = 1109305166
		arg_655_1.duration_ = 6.93

		SetActive(arg_655_1.tipsGo_, false)

		function arg_655_1.onSingleLineFinish_()
			arg_655_1.onSingleLineUpdate_ = nil
			arg_655_1.onSingleLineFinish_ = nil
			arg_655_1.state_ = "waiting"
		end

		function arg_655_1.playNext_(arg_657_0)
			if arg_657_0 == 1 then
				arg_655_0:Play1109305167(arg_655_1)
			end
		end

		function arg_655_1.onSingleLineUpdate_(arg_658_0)
			if 0 < arg_655_1.time_ and arg_655_1.time_ <= 0 + arg_658_0 then
				arg_655_1.var_.moveOldPos1093ui_story = arg_655_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_658_0 = 0.001

			if 0 <= arg_655_1.time_ and arg_655_1.time_ < 0 + var_658_0 then
				arg_655_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_655_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_655_1.time_ - 0) / var_658_0)
				arg_655_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_655_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_655_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_655_1.actors_["1093ui_story"].transform.position).z)
				arg_655_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_655_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_655_1.actors_["1093ui_story"].transform.localEulerAngles = arg_655_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_655_1.time_ >= 0 + var_658_0 and arg_655_1.time_ < 0 + var_658_0 + arg_658_0 then
				arg_655_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_655_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_655_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_655_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_655_1.actors_["1093ui_story"].transform.position).z)
				arg_655_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_655_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_655_1.actors_["1093ui_story"].transform.localEulerAngles = arg_655_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_658_1 = arg_655_1.actors_["1093ui_story"]

			if 0 < arg_655_1.time_ and arg_655_1.time_ <= 0 + arg_658_0 and not isNil(var_658_1) and arg_655_1.var_.characterEffect1093ui_story == nil then
				arg_655_1.var_.characterEffect1093ui_story = var_658_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_658_2 = 0.200000002980232

			if 0 <= arg_655_1.time_ and arg_655_1.time_ < 0 + var_658_2 and not isNil(var_658_1) then
				if arg_655_1.var_.characterEffect1093ui_story and not isNil(var_658_1) then
					arg_655_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_655_1.time_ >= 0 + var_658_2 and arg_655_1.time_ < 0 + var_658_2 + arg_658_0 and not isNil(var_658_1) and arg_655_1.var_.characterEffect1093ui_story then
				arg_655_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_655_1.time_ and arg_655_1.time_ <= 0 + arg_658_0 then
				arg_655_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action8_2")
			end

			if 0 < arg_655_1.time_ and arg_655_1.time_ <= 0 + arg_658_0 then
				arg_655_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_658_4 = 0
			local var_658_5 = 0.75

			if 0 < arg_655_1.time_ and arg_655_1.time_ <= var_658_4 + arg_658_0 then
				arg_655_1.talkMaxDuration = 0
				arg_655_1.dialogCg_.alpha = 1

				arg_655_1.dialog_:SetActive(true)
				SetActive(arg_655_1.leftNameGo_, true)

				arg_655_1.leftNameTxt_.text = arg_655_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_655_1.leftNameTxt_.transform)

				arg_655_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_655_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_655_1:RecordName(arg_655_1.leftNameTxt_.text)
				SetActive(arg_655_1.iconTrs_.gameObject, false)
				arg_655_1.callingController_:SetSelectedState("normal")

				local var_658_6 = arg_655_1:GetWordFromCfg(1109305166)
				local var_658_7 = arg_655_1:FormatText(var_658_6.content)

				arg_655_1.text_.text = var_658_7

				LuaForUtil.ClearLinePrefixSymbol(arg_655_1.text_)

				local var_658_9 = 30 <= 0 and var_658_5 or var_658_5 * (utf8.len(var_658_7) / 30)

				if (30 <= 0 and var_658_5 or var_658_5 * (utf8.len(var_658_7) / 30)) > 0 and var_658_5 < var_658_9 then
					arg_655_1.talkMaxDuration = var_658_9

					if var_658_9 + var_658_4 > arg_655_1.duration_ then
						arg_655_1.duration_ = var_658_9 + var_658_4
					end
				end

				arg_655_1.text_.text = var_658_7
				arg_655_1.typewritter.percent = 0

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305166", "story_v_side_new_1109305.awb") ~= 0 then
					local var_658_10 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305166", "story_v_side_new_1109305.awb") / 1000

					if var_658_10 + var_658_4 > arg_655_1.duration_ then
						arg_655_1.duration_ = var_658_10 + var_658_4
					end

					if var_658_6.prefab_name ~= "" and arg_655_1.actors_[var_658_6.prefab_name] ~= nil then
						local var_658_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_655_1.actors_[var_658_6.prefab_name].transform, "story_v_side_new_1109305", "1109305166", "story_v_side_new_1109305.awb")

						arg_655_1:RecordAudio("1109305166", var_658_11)
						arg_655_1:RecordAudio("1109305166", var_658_11)
					else
						arg_655_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305166", "story_v_side_new_1109305.awb")
					end

					arg_655_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305166", "story_v_side_new_1109305.awb")
				end

				arg_655_1:RecordContent(arg_655_1.text_.text)
			end

			local var_658_12 = math.max(var_658_5, arg_655_1.talkMaxDuration)

			if var_658_4 <= arg_655_1.time_ and arg_655_1.time_ < var_658_4 + var_658_12 then
				arg_655_1.typewritter.percent = (arg_655_1.time_ - var_658_4) / var_658_12

				arg_655_1.typewritter:SetDirty()
			end

			if arg_655_1.time_ >= var_658_4 + var_658_12 and arg_655_1.time_ < var_658_4 + var_658_12 + arg_658_0 then
				arg_655_1.typewritter.percent = 1

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(true)
			end
		end

		arg_655_1.nodeConfigList_ = {
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

		arg_655_1:InitPlayNodeList()
	end,
	Play1109305167 = function(arg_659_0, arg_659_1)
		arg_659_1.time_ = 0
		arg_659_1.frameCnt_ = 0
		arg_659_1.state_ = "playing"
		arg_659_1.curTalkId_ = 1109305167
		arg_659_1.duration_ = 5

		SetActive(arg_659_1.tipsGo_, false)

		function arg_659_1.onSingleLineFinish_()
			arg_659_1.onSingleLineUpdate_ = nil
			arg_659_1.onSingleLineFinish_ = nil
			arg_659_1.state_ = "waiting"
		end

		function arg_659_1.playNext_(arg_661_0)
			if arg_661_0 == 1 then
				arg_659_0:Play1109305168(arg_659_1)
			end
		end

		function arg_659_1.onSingleLineUpdate_(arg_662_0)
			if 0 < arg_659_1.time_ and arg_659_1.time_ <= 0 + arg_662_0 and not isNil(arg_659_1.actors_["1093ui_story"]) and arg_659_1.var_.characterEffect1093ui_story == nil then
				arg_659_1.var_.characterEffect1093ui_story = arg_659_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_662_0 = 0.200000002980232

			if 0 <= arg_659_1.time_ and arg_659_1.time_ < 0 + var_662_0 and not isNil(arg_659_1.actors_["1093ui_story"]) then
				if arg_659_1.var_.characterEffect1093ui_story and not isNil(arg_659_1.actors_["1093ui_story"]) then
					arg_659_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_659_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_659_1.time_ - 0) / var_662_0)
				end
			end

			if arg_659_1.time_ >= 0 + var_662_0 and arg_659_1.time_ < 0 + var_662_0 + arg_662_0 and not isNil(arg_659_1.actors_["1093ui_story"]) and arg_659_1.var_.characterEffect1093ui_story then
				arg_659_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_659_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_662_1 = 0
			local var_662_2 = 0.7

			if 0 < arg_659_1.time_ and arg_659_1.time_ <= var_662_1 + arg_662_0 then
				arg_659_1.talkMaxDuration = 0
				arg_659_1.dialogCg_.alpha = 1

				arg_659_1.dialog_:SetActive(true)
				SetActive(arg_659_1.leftNameGo_, true)

				arg_659_1.leftNameTxt_.text = arg_659_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_659_1.leftNameTxt_.transform)

				arg_659_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_659_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_659_1:RecordName(arg_659_1.leftNameTxt_.text)
				SetActive(arg_659_1.iconTrs_.gameObject, true)
				arg_659_1.iconController_:SetSelectedState("hero")

				arg_659_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_659_1.callingController_:SetSelectedState("normal")

				arg_659_1.keyicon_.color = Color.New(1, 1, 1)
				arg_659_1.icon_.color = Color.New(1, 1, 1)

				local var_662_3 = arg_659_1:FormatText(arg_659_1:GetWordFromCfg(1109305167).content)

				arg_659_1.text_.text = var_662_3

				LuaForUtil.ClearLinePrefixSymbol(arg_659_1.text_)

				local var_662_5 = 28 <= 0 and var_662_2 or var_662_2 * (utf8.len(var_662_3) / 28)

				if (28 <= 0 and var_662_2 or var_662_2 * (utf8.len(var_662_3) / 28)) > 0 and var_662_2 < var_662_5 then
					arg_659_1.talkMaxDuration = var_662_5

					if var_662_5 + var_662_1 > arg_659_1.duration_ then
						arg_659_1.duration_ = var_662_5 + var_662_1
					end
				end

				arg_659_1.text_.text = var_662_3
				arg_659_1.typewritter.percent = 0

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(false)
				arg_659_1:RecordContent(arg_659_1.text_.text)
			end

			local var_662_6 = math.max(var_662_2, arg_659_1.talkMaxDuration)

			if var_662_1 <= arg_659_1.time_ and arg_659_1.time_ < var_662_1 + var_662_6 then
				arg_659_1.typewritter.percent = (arg_659_1.time_ - var_662_1) / var_662_6

				arg_659_1.typewritter:SetDirty()
			end

			if arg_659_1.time_ >= var_662_1 + var_662_6 and arg_659_1.time_ < var_662_1 + var_662_6 + arg_662_0 then
				arg_659_1.typewritter.percent = 1

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(true)
			end
		end

		arg_659_1.nodeConfigList_ = {}

		arg_659_1:InitPlayNodeList()
	end,
	Play1109305168 = function(arg_663_0, arg_663_1)
		arg_663_1.time_ = 0
		arg_663_1.frameCnt_ = 0
		arg_663_1.state_ = "playing"
		arg_663_1.curTalkId_ = 1109305168
		arg_663_1.duration_ = 5

		SetActive(arg_663_1.tipsGo_, false)

		function arg_663_1.onSingleLineFinish_()
			arg_663_1.onSingleLineUpdate_ = nil
			arg_663_1.onSingleLineFinish_ = nil
			arg_663_1.state_ = "waiting"
		end

		function arg_663_1.playNext_(arg_665_0)
			if arg_665_0 == 1 then
				arg_663_0:Play1109305169(arg_663_1)
			end
		end

		function arg_663_1.onSingleLineUpdate_(arg_666_0)
			local var_666_0 = 0.8

			if 0 < arg_663_1.time_ and arg_663_1.time_ <= 0 + arg_666_0 then
				arg_663_1.talkMaxDuration = 0
				arg_663_1.dialogCg_.alpha = 1

				arg_663_1.dialog_:SetActive(true)
				SetActive(arg_663_1.leftNameGo_, false)

				arg_663_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_663_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_663_1:RecordName(arg_663_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_663_1.iconTrs_.gameObject, false)
				arg_663_1.callingController_:SetSelectedState("normal")

				local var_666_1 = arg_663_1:FormatText(arg_663_1:GetWordFromCfg(1109305168).content)

				arg_663_1.text_.text = var_666_1

				LuaForUtil.ClearLinePrefixSymbol(arg_663_1.text_)

				local var_666_3 = 32 <= 0 and var_666_0 or var_666_0 * (utf8.len(var_666_1) / 32)

				if (32 <= 0 and var_666_0 or var_666_0 * (utf8.len(var_666_1) / 32)) > 0 and var_666_0 < var_666_3 then
					arg_663_1.talkMaxDuration = var_666_3

					if var_666_3 + 0 > arg_663_1.duration_ then
						arg_663_1.duration_ = var_666_3 + 0
					end
				end

				arg_663_1.text_.text = var_666_1
				arg_663_1.typewritter.percent = 0

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(false)
				arg_663_1:RecordContent(arg_663_1.text_.text)
			end

			local var_666_4 = math.max(var_666_0, arg_663_1.talkMaxDuration)

			if 0 <= arg_663_1.time_ and arg_663_1.time_ < 0 + var_666_4 then
				arg_663_1.typewritter.percent = (arg_663_1.time_ - 0) / var_666_4

				arg_663_1.typewritter:SetDirty()
			end

			if arg_663_1.time_ >= 0 + var_666_4 and arg_663_1.time_ < 0 + var_666_4 + arg_666_0 then
				arg_663_1.typewritter.percent = 1

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(true)
			end
		end

		arg_663_1.nodeConfigList_ = {}

		arg_663_1:InitPlayNodeList()
	end,
	Play1109305169 = function(arg_667_0, arg_667_1)
		arg_667_1.time_ = 0
		arg_667_1.frameCnt_ = 0
		arg_667_1.state_ = "playing"
		arg_667_1.curTalkId_ = 1109305169
		arg_667_1.duration_ = 5

		SetActive(arg_667_1.tipsGo_, false)

		function arg_667_1.onSingleLineFinish_()
			arg_667_1.onSingleLineUpdate_ = nil
			arg_667_1.onSingleLineFinish_ = nil
			arg_667_1.state_ = "waiting"
		end

		function arg_667_1.playNext_(arg_669_0)
			if arg_669_0 == 1 then
				arg_667_0:Play1109305170(arg_667_1)
			end
		end

		function arg_667_1.onSingleLineUpdate_(arg_670_0)
			local var_670_0 = 0.775

			if 0 < arg_667_1.time_ and arg_667_1.time_ <= 0 + arg_670_0 then
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

				local var_670_1 = arg_667_1:FormatText(arg_667_1:GetWordFromCfg(1109305169).content)

				arg_667_1.text_.text = var_670_1

				LuaForUtil.ClearLinePrefixSymbol(arg_667_1.text_)

				local var_670_3 = 31 <= 0 and var_670_0 or var_670_0 * (utf8.len(var_670_1) / 31)

				if (31 <= 0 and var_670_0 or var_670_0 * (utf8.len(var_670_1) / 31)) > 0 and var_670_0 < var_670_3 then
					arg_667_1.talkMaxDuration = var_670_3

					if var_670_3 + 0 > arg_667_1.duration_ then
						arg_667_1.duration_ = var_670_3 + 0
					end
				end

				arg_667_1.text_.text = var_670_1
				arg_667_1.typewritter.percent = 0

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(false)
				arg_667_1:RecordContent(arg_667_1.text_.text)
			end

			local var_670_4 = math.max(var_670_0, arg_667_1.talkMaxDuration)

			if 0 <= arg_667_1.time_ and arg_667_1.time_ < 0 + var_670_4 then
				arg_667_1.typewritter.percent = (arg_667_1.time_ - 0) / var_670_4

				arg_667_1.typewritter:SetDirty()
			end

			if arg_667_1.time_ >= 0 + var_670_4 and arg_667_1.time_ < 0 + var_670_4 + arg_670_0 then
				arg_667_1.typewritter.percent = 1

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(true)
			end
		end

		arg_667_1.nodeConfigList_ = {}

		arg_667_1:InitPlayNodeList()
	end,
	Play1109305170 = function(arg_671_0, arg_671_1)
		arg_671_1.time_ = 0
		arg_671_1.frameCnt_ = 0
		arg_671_1.state_ = "playing"
		arg_671_1.curTalkId_ = 1109305170
		arg_671_1.duration_ = 5

		SetActive(arg_671_1.tipsGo_, false)

		function arg_671_1.onSingleLineFinish_()
			arg_671_1.onSingleLineUpdate_ = nil
			arg_671_1.onSingleLineFinish_ = nil
			arg_671_1.state_ = "waiting"
		end

		function arg_671_1.playNext_(arg_673_0)
			if arg_673_0 == 1 then
				arg_671_0:Play1109305171(arg_671_1)
			end
		end

		function arg_671_1.onSingleLineUpdate_(arg_674_0)
			local var_674_0 = 0.55

			if 0 < arg_671_1.time_ and arg_671_1.time_ <= 0 + arg_674_0 then
				arg_671_1.talkMaxDuration = 0
				arg_671_1.dialogCg_.alpha = 1

				arg_671_1.dialog_:SetActive(true)
				SetActive(arg_671_1.leftNameGo_, true)

				arg_671_1.leftNameTxt_.text = arg_671_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_671_1.leftNameTxt_.transform)

				arg_671_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_671_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_671_1:RecordName(arg_671_1.leftNameTxt_.text)
				SetActive(arg_671_1.iconTrs_.gameObject, true)
				arg_671_1.iconController_:SetSelectedState("hero")

				arg_671_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_671_1.callingController_:SetSelectedState("normal")

				arg_671_1.keyicon_.color = Color.New(1, 1, 1)
				arg_671_1.icon_.color = Color.New(1, 1, 1)

				local var_674_1 = arg_671_1:FormatText(arg_671_1:GetWordFromCfg(1109305170).content)

				arg_671_1.text_.text = var_674_1

				LuaForUtil.ClearLinePrefixSymbol(arg_671_1.text_)

				local var_674_3 = 22 <= 0 and var_674_0 or var_674_0 * (utf8.len(var_674_1) / 22)

				if (22 <= 0 and var_674_0 or var_674_0 * (utf8.len(var_674_1) / 22)) > 0 and var_674_0 < var_674_3 then
					arg_671_1.talkMaxDuration = var_674_3

					if var_674_3 + 0 > arg_671_1.duration_ then
						arg_671_1.duration_ = var_674_3 + 0
					end
				end

				arg_671_1.text_.text = var_674_1
				arg_671_1.typewritter.percent = 0

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(false)
				arg_671_1:RecordContent(arg_671_1.text_.text)
			end

			local var_674_4 = math.max(var_674_0, arg_671_1.talkMaxDuration)

			if 0 <= arg_671_1.time_ and arg_671_1.time_ < 0 + var_674_4 then
				arg_671_1.typewritter.percent = (arg_671_1.time_ - 0) / var_674_4

				arg_671_1.typewritter:SetDirty()
			end

			if arg_671_1.time_ >= 0 + var_674_4 and arg_671_1.time_ < 0 + var_674_4 + arg_674_0 then
				arg_671_1.typewritter.percent = 1

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(true)
			end
		end

		arg_671_1.nodeConfigList_ = {}

		arg_671_1:InitPlayNodeList()
	end,
	Play1109305171 = function(arg_675_0, arg_675_1)
		arg_675_1.time_ = 0
		arg_675_1.frameCnt_ = 0
		arg_675_1.state_ = "playing"
		arg_675_1.curTalkId_ = 1109305171
		arg_675_1.duration_ = 6.87

		SetActive(arg_675_1.tipsGo_, false)

		function arg_675_1.onSingleLineFinish_()
			arg_675_1.onSingleLineUpdate_ = nil
			arg_675_1.onSingleLineFinish_ = nil
			arg_675_1.state_ = "waiting"
		end

		function arg_675_1.playNext_(arg_677_0)
			if arg_677_0 == 1 then
				arg_675_0:Play1109305172(arg_675_1)
			end
		end

		function arg_675_1.onSingleLineUpdate_(arg_678_0)
			if 0 < arg_675_1.time_ and arg_675_1.time_ <= 0 + arg_678_0 then
				arg_675_1.var_.moveOldPos1093ui_story = arg_675_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_678_0 = 0.001

			if 0 <= arg_675_1.time_ and arg_675_1.time_ < 0 + var_678_0 then
				arg_675_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_675_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_675_1.time_ - 0) / var_678_0)
				arg_675_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_675_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_675_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_675_1.actors_["1093ui_story"].transform.position).z)
				arg_675_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_675_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_675_1.actors_["1093ui_story"].transform.localEulerAngles = arg_675_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_675_1.time_ >= 0 + var_678_0 and arg_675_1.time_ < 0 + var_678_0 + arg_678_0 then
				arg_675_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_675_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_675_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_675_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_675_1.actors_["1093ui_story"].transform.position).z)
				arg_675_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_675_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_675_1.actors_["1093ui_story"].transform.localEulerAngles = arg_675_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_678_1 = arg_675_1.actors_["1093ui_story"]

			if 0 < arg_675_1.time_ and arg_675_1.time_ <= 0 + arg_678_0 and not isNil(var_678_1) and arg_675_1.var_.characterEffect1093ui_story == nil then
				arg_675_1.var_.characterEffect1093ui_story = var_678_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_678_2 = 0.200000002980232

			if 0 <= arg_675_1.time_ and arg_675_1.time_ < 0 + var_678_2 and not isNil(var_678_1) then
				if arg_675_1.var_.characterEffect1093ui_story and not isNil(var_678_1) then
					arg_675_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_675_1.time_ >= 0 + var_678_2 and arg_675_1.time_ < 0 + var_678_2 + arg_678_0 and not isNil(var_678_1) and arg_675_1.var_.characterEffect1093ui_story then
				arg_675_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_675_1.time_ and arg_675_1.time_ <= 0 + arg_678_0 then
				arg_675_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action7_1")
			end

			if 0 < arg_675_1.time_ and arg_675_1.time_ <= 0 + arg_678_0 then
				arg_675_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_678_4 = 0
			local var_678_5 = 0.925

			if 0 < arg_675_1.time_ and arg_675_1.time_ <= var_678_4 + arg_678_0 then
				arg_675_1.talkMaxDuration = 0
				arg_675_1.dialogCg_.alpha = 1

				arg_675_1.dialog_:SetActive(true)
				SetActive(arg_675_1.leftNameGo_, true)

				arg_675_1.leftNameTxt_.text = arg_675_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_675_1.leftNameTxt_.transform)

				arg_675_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_675_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_675_1:RecordName(arg_675_1.leftNameTxt_.text)
				SetActive(arg_675_1.iconTrs_.gameObject, false)
				arg_675_1.callingController_:SetSelectedState("normal")

				local var_678_6 = arg_675_1:GetWordFromCfg(1109305171)
				local var_678_7 = arg_675_1:FormatText(var_678_6.content)

				arg_675_1.text_.text = var_678_7

				LuaForUtil.ClearLinePrefixSymbol(arg_675_1.text_)

				local var_678_9 = 37 <= 0 and var_678_5 or var_678_5 * (utf8.len(var_678_7) / 37)

				if (37 <= 0 and var_678_5 or var_678_5 * (utf8.len(var_678_7) / 37)) > 0 and var_678_5 < var_678_9 then
					arg_675_1.talkMaxDuration = var_678_9

					if var_678_9 + var_678_4 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_9 + var_678_4
					end
				end

				arg_675_1.text_.text = var_678_7
				arg_675_1.typewritter.percent = 0

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305171", "story_v_side_new_1109305.awb") ~= 0 then
					local var_678_10 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305171", "story_v_side_new_1109305.awb") / 1000

					if var_678_10 + var_678_4 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_10 + var_678_4
					end

					if var_678_6.prefab_name ~= "" and arg_675_1.actors_[var_678_6.prefab_name] ~= nil then
						local var_678_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_675_1.actors_[var_678_6.prefab_name].transform, "story_v_side_new_1109305", "1109305171", "story_v_side_new_1109305.awb")

						arg_675_1:RecordAudio("1109305171", var_678_11)
						arg_675_1:RecordAudio("1109305171", var_678_11)
					else
						arg_675_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305171", "story_v_side_new_1109305.awb")
					end

					arg_675_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305171", "story_v_side_new_1109305.awb")
				end

				arg_675_1:RecordContent(arg_675_1.text_.text)
			end

			local var_678_12 = math.max(var_678_5, arg_675_1.talkMaxDuration)

			if var_678_4 <= arg_675_1.time_ and arg_675_1.time_ < var_678_4 + var_678_12 then
				arg_675_1.typewritter.percent = (arg_675_1.time_ - var_678_4) / var_678_12

				arg_675_1.typewritter:SetDirty()
			end

			if arg_675_1.time_ >= var_678_4 + var_678_12 and arg_675_1.time_ < var_678_4 + var_678_12 + arg_678_0 then
				arg_675_1.typewritter.percent = 1

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(true)
			end
		end

		arg_675_1.nodeConfigList_ = {
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

		arg_675_1:InitPlayNodeList()
	end,
	Play1109305172 = function(arg_679_0, arg_679_1)
		arg_679_1.time_ = 0
		arg_679_1.frameCnt_ = 0
		arg_679_1.state_ = "playing"
		arg_679_1.curTalkId_ = 1109305172
		arg_679_1.duration_ = 5

		SetActive(arg_679_1.tipsGo_, false)

		function arg_679_1.onSingleLineFinish_()
			arg_679_1.onSingleLineUpdate_ = nil
			arg_679_1.onSingleLineFinish_ = nil
			arg_679_1.state_ = "waiting"
		end

		function arg_679_1.playNext_(arg_681_0)
			if arg_681_0 == 1 then
				arg_679_0:Play1109305173(arg_679_1)
			end
		end

		function arg_679_1.onSingleLineUpdate_(arg_682_0)
			if 0 < arg_679_1.time_ and arg_679_1.time_ <= 0 + arg_682_0 and not isNil(arg_679_1.actors_["1093ui_story"]) and arg_679_1.var_.characterEffect1093ui_story == nil then
				arg_679_1.var_.characterEffect1093ui_story = arg_679_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_682_0 = 0.200000002980232

			if 0 <= arg_679_1.time_ and arg_679_1.time_ < 0 + var_682_0 and not isNil(arg_679_1.actors_["1093ui_story"]) then
				if arg_679_1.var_.characterEffect1093ui_story and not isNil(arg_679_1.actors_["1093ui_story"]) then
					arg_679_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_679_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_679_1.time_ - 0) / var_682_0)
				end
			end

			if arg_679_1.time_ >= 0 + var_682_0 and arg_679_1.time_ < 0 + var_682_0 + arg_682_0 and not isNil(arg_679_1.actors_["1093ui_story"]) and arg_679_1.var_.characterEffect1093ui_story then
				arg_679_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_679_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_682_1 = arg_679_1.actors_["1093ui_story"].transform

			if 0 < arg_679_1.time_ and arg_679_1.time_ <= 0 + arg_682_0 then
				arg_679_1.var_.moveOldPos1093ui_story = var_682_1.localPosition
			end

			local var_682_2 = 0.001

			if 0 <= arg_679_1.time_ and arg_679_1.time_ < 0 + var_682_2 then
				var_682_1.localPosition = Vector3.Lerp(arg_679_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_679_1.time_ - 0) / var_682_2)
				var_682_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_682_1.position).x, (manager.ui.mainCamera.transform.position - var_682_1.position).y, (manager.ui.mainCamera.transform.position - var_682_1.position).z)
				var_682_1.localEulerAngles.z = 0
				var_682_1.localEulerAngles.x = 0
				var_682_1.localEulerAngles = var_682_1.localEulerAngles
			end

			if arg_679_1.time_ >= 0 + var_682_2 and arg_679_1.time_ < 0 + var_682_2 + arg_682_0 then
				var_682_1.localPosition = Vector3.New(0, 100, 0)
				var_682_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_682_1.position).x, (manager.ui.mainCamera.transform.position - var_682_1.position).y, (manager.ui.mainCamera.transform.position - var_682_1.position).z)
				var_682_1.localEulerAngles.z = 0
				var_682_1.localEulerAngles.x = 0
				var_682_1.localEulerAngles = var_682_1.localEulerAngles
			end

			local var_682_3 = 0
			local var_682_4 = 0.6

			if 0 < arg_679_1.time_ and arg_679_1.time_ <= var_682_3 + arg_682_0 then
				arg_679_1.talkMaxDuration = 0
				arg_679_1.dialogCg_.alpha = 1

				arg_679_1.dialog_:SetActive(true)
				SetActive(arg_679_1.leftNameGo_, true)

				arg_679_1.leftNameTxt_.text = arg_679_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_679_1.leftNameTxt_.transform)

				arg_679_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_679_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_679_1:RecordName(arg_679_1.leftNameTxt_.text)
				SetActive(arg_679_1.iconTrs_.gameObject, true)
				arg_679_1.iconController_:SetSelectedState("hero")

				arg_679_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_679_1.callingController_:SetSelectedState("normal")

				arg_679_1.keyicon_.color = Color.New(1, 1, 1)
				arg_679_1.icon_.color = Color.New(1, 1, 1)

				local var_682_5 = arg_679_1:FormatText(arg_679_1:GetWordFromCfg(1109305172).content)

				arg_679_1.text_.text = var_682_5

				LuaForUtil.ClearLinePrefixSymbol(arg_679_1.text_)

				local var_682_7 = 24 <= 0 and var_682_4 or var_682_4 * (utf8.len(var_682_5) / 24)

				if (24 <= 0 and var_682_4 or var_682_4 * (utf8.len(var_682_5) / 24)) > 0 and var_682_4 < var_682_7 then
					arg_679_1.talkMaxDuration = var_682_7

					if var_682_7 + var_682_3 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_7 + var_682_3
					end
				end

				arg_679_1.text_.text = var_682_5
				arg_679_1.typewritter.percent = 0

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(false)
				arg_679_1:RecordContent(arg_679_1.text_.text)
			end

			local var_682_8 = math.max(var_682_4, arg_679_1.talkMaxDuration)

			if var_682_3 <= arg_679_1.time_ and arg_679_1.time_ < var_682_3 + var_682_8 then
				arg_679_1.typewritter.percent = (arg_679_1.time_ - var_682_3) / var_682_8

				arg_679_1.typewritter:SetDirty()
			end

			if arg_679_1.time_ >= var_682_3 + var_682_8 and arg_679_1.time_ < var_682_3 + var_682_8 + arg_682_0 then
				arg_679_1.typewritter.percent = 1

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(true)
			end
		end

		arg_679_1.nodeConfigList_ = {
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

		arg_679_1:InitPlayNodeList()
	end,
	Play1109305173 = function(arg_683_0, arg_683_1)
		arg_683_1.time_ = 0
		arg_683_1.frameCnt_ = 0
		arg_683_1.state_ = "playing"
		arg_683_1.curTalkId_ = 1109305173
		arg_683_1.duration_ = 4.93

		SetActive(arg_683_1.tipsGo_, false)

		function arg_683_1.onSingleLineFinish_()
			arg_683_1.onSingleLineUpdate_ = nil
			arg_683_1.onSingleLineFinish_ = nil
			arg_683_1.state_ = "waiting"
		end

		function arg_683_1.playNext_(arg_685_0)
			if arg_685_0 == 1 then
				arg_683_0:Play1109305174(arg_683_1)
			end
		end

		function arg_683_1.onSingleLineUpdate_(arg_686_0)
			local var_686_0 = 0.575

			if 0 < arg_683_1.time_ and arg_683_1.time_ <= 0 + arg_686_0 then
				arg_683_1.talkMaxDuration = 0
				arg_683_1.dialogCg_.alpha = 1

				arg_683_1.dialog_:SetActive(true)
				SetActive(arg_683_1.leftNameGo_, true)

				arg_683_1.leftNameTxt_.text = arg_683_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_683_1.leftNameTxt_.transform)

				arg_683_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_683_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_683_1:RecordName(arg_683_1.leftNameTxt_.text)
				SetActive(arg_683_1.iconTrs_.gameObject, true)
				arg_683_1.iconController_:SetSelectedState("hero")

				arg_683_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_683_1.callingController_:SetSelectedState("normal")

				arg_683_1.keyicon_.color = Color.New(1, 1, 1)
				arg_683_1.icon_.color = Color.New(1, 1, 1)

				local var_686_1 = arg_683_1:GetWordFromCfg(1109305173)
				local var_686_2 = arg_683_1:FormatText(var_686_1.content)

				arg_683_1.text_.text = var_686_2

				LuaForUtil.ClearLinePrefixSymbol(arg_683_1.text_)

				local var_686_4 = 23 <= 0 and var_686_0 or var_686_0 * (utf8.len(var_686_2) / 23)

				if (23 <= 0 and var_686_0 or var_686_0 * (utf8.len(var_686_2) / 23)) > 0 and var_686_0 < var_686_4 then
					arg_683_1.talkMaxDuration = var_686_4

					if var_686_4 + 0 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_4 + 0
					end
				end

				arg_683_1.text_.text = var_686_2
				arg_683_1.typewritter.percent = 0

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305173", "story_v_side_new_1109305.awb") ~= 0 then
					local var_686_5 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305173", "story_v_side_new_1109305.awb") / 1000

					if var_686_5 + 0 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_5 + 0
					end

					if var_686_1.prefab_name ~= "" and arg_683_1.actors_[var_686_1.prefab_name] ~= nil then
						local var_686_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_683_1.actors_[var_686_1.prefab_name].transform, "story_v_side_new_1109305", "1109305173", "story_v_side_new_1109305.awb")

						arg_683_1:RecordAudio("1109305173", var_686_6)
						arg_683_1:RecordAudio("1109305173", var_686_6)
					else
						arg_683_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305173", "story_v_side_new_1109305.awb")
					end

					arg_683_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305173", "story_v_side_new_1109305.awb")
				end

				arg_683_1:RecordContent(arg_683_1.text_.text)
			end

			local var_686_7 = math.max(var_686_0, arg_683_1.talkMaxDuration)

			if 0 <= arg_683_1.time_ and arg_683_1.time_ < 0 + var_686_7 then
				arg_683_1.typewritter.percent = (arg_683_1.time_ - 0) / var_686_7

				arg_683_1.typewritter:SetDirty()
			end

			if arg_683_1.time_ >= 0 + var_686_7 and arg_683_1.time_ < 0 + var_686_7 + arg_686_0 then
				arg_683_1.typewritter.percent = 1

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(true)
			end
		end

		arg_683_1.nodeConfigList_ = {}

		arg_683_1:InitPlayNodeList()
	end,
	Play1109305174 = function(arg_687_0, arg_687_1)
		arg_687_1.time_ = 0
		arg_687_1.frameCnt_ = 0
		arg_687_1.state_ = "playing"
		arg_687_1.curTalkId_ = 1109305174
		arg_687_1.duration_ = 5

		SetActive(arg_687_1.tipsGo_, false)

		function arg_687_1.onSingleLineFinish_()
			arg_687_1.onSingleLineUpdate_ = nil
			arg_687_1.onSingleLineFinish_ = nil
			arg_687_1.state_ = "waiting"
		end

		function arg_687_1.playNext_(arg_689_0)
			if arg_689_0 == 1 then
				arg_687_0:Play1109305175(arg_687_1)
			end
		end

		function arg_687_1.onSingleLineUpdate_(arg_690_0)
			if 0 < arg_687_1.time_ and arg_687_1.time_ <= 0 + arg_690_0 and not isNil(arg_687_1.actors_["1093ui_story"]) and arg_687_1.var_.characterEffect1093ui_story == nil then
				arg_687_1.var_.characterEffect1093ui_story = arg_687_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_690_0 = 0.200000002980232

			if 0 <= arg_687_1.time_ and arg_687_1.time_ < 0 + var_690_0 and not isNil(arg_687_1.actors_["1093ui_story"]) then
				if arg_687_1.var_.characterEffect1093ui_story and not isNil(arg_687_1.actors_["1093ui_story"]) then
					arg_687_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_687_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_687_1.time_ - 0) / var_690_0)
				end
			end

			if arg_687_1.time_ >= 0 + var_690_0 and arg_687_1.time_ < 0 + var_690_0 + arg_690_0 and not isNil(arg_687_1.actors_["1093ui_story"]) and arg_687_1.var_.characterEffect1093ui_story then
				arg_687_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_687_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_690_1 = 0
			local var_690_2 = 0.05

			if 0 < arg_687_1.time_ and arg_687_1.time_ <= var_690_1 + arg_690_0 then
				arg_687_1.talkMaxDuration = 0
				arg_687_1.dialogCg_.alpha = 1

				arg_687_1.dialog_:SetActive(true)
				SetActive(arg_687_1.leftNameGo_, false)

				arg_687_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_687_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_687_1:RecordName(arg_687_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_687_1.iconTrs_.gameObject, false)
				arg_687_1.callingController_:SetSelectedState("normal")

				local var_690_3 = arg_687_1:FormatText(arg_687_1:GetWordFromCfg(1109305174).content)

				arg_687_1.text_.text = var_690_3

				LuaForUtil.ClearLinePrefixSymbol(arg_687_1.text_)

				local var_690_5 = 2 <= 0 and var_690_2 or var_690_2 * (utf8.len(var_690_3) / 2)

				if (2 <= 0 and var_690_2 or var_690_2 * (utf8.len(var_690_3) / 2)) > 0 and var_690_2 < var_690_5 then
					arg_687_1.talkMaxDuration = var_690_5

					if var_690_5 + var_690_1 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_5 + var_690_1
					end
				end

				arg_687_1.text_.text = var_690_3
				arg_687_1.typewritter.percent = 0

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(false)
				arg_687_1:RecordContent(arg_687_1.text_.text)
			end

			local var_690_6 = math.max(var_690_2, arg_687_1.talkMaxDuration)

			if var_690_1 <= arg_687_1.time_ and arg_687_1.time_ < var_690_1 + var_690_6 then
				arg_687_1.typewritter.percent = (arg_687_1.time_ - var_690_1) / var_690_6

				arg_687_1.typewritter:SetDirty()
			end

			if arg_687_1.time_ >= var_690_1 + var_690_6 and arg_687_1.time_ < var_690_1 + var_690_6 + arg_690_0 then
				arg_687_1.typewritter.percent = 1

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(true)
			end
		end

		arg_687_1.nodeConfigList_ = {}

		arg_687_1:InitPlayNodeList()
	end,
	Play1109305175 = function(arg_691_0, arg_691_1)
		arg_691_1.time_ = 0
		arg_691_1.frameCnt_ = 0
		arg_691_1.state_ = "playing"
		arg_691_1.curTalkId_ = 1109305175
		arg_691_1.duration_ = 8.27

		SetActive(arg_691_1.tipsGo_, false)

		function arg_691_1.onSingleLineFinish_()
			arg_691_1.onSingleLineUpdate_ = nil
			arg_691_1.onSingleLineFinish_ = nil
			arg_691_1.state_ = "waiting"
		end

		function arg_691_1.playNext_(arg_693_0)
			if arg_693_0 == 1 then
				arg_691_0:Play1109305176(arg_691_1)
			end
		end

		function arg_691_1.onSingleLineUpdate_(arg_694_0)
			if arg_691_1.bgs_.ST06 == nil then
				local var_694_0 = Object.Instantiate(arg_691_1.paintGo_)

				var_694_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST06")
				var_694_0.name = "ST06"
				var_694_0.transform.parent = arg_691_1.stage_.transform
				var_694_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_691_1.bgs_.ST06 = var_694_0
			end

			if 1.66666666666667 < arg_691_1.time_ and arg_691_1.time_ <= 1.66666666666667 + arg_694_0 then
				local var_694_1 = arg_691_1.bgs_.ST06

				arg_691_1.bgs_.ST06.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_694_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_694_2 = var_694_1:GetComponent("SpriteRenderer")

				if var_694_2 and var_694_2.sprite then
					local var_694_3 = 2 * (var_694_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_694_1.transform.localScale = Vector3.New(var_694_3 / var_694_2.sprite.bounds.size.y < var_694_3 * manager.ui.mainCameraCom_.aspect / var_694_2.sprite.bounds.size.x and var_694_3 * manager.ui.mainCameraCom_.aspect / var_694_2.sprite.bounds.size.x or var_694_3 / var_694_2.sprite.bounds.size.y, var_694_3 / var_694_2.sprite.bounds.size.y < var_694_3 * manager.ui.mainCameraCom_.aspect / var_694_2.sprite.bounds.size.x and var_694_3 * manager.ui.mainCameraCom_.aspect / var_694_2.sprite.bounds.size.x or var_694_3 / var_694_2.sprite.bounds.size.y, 0)
				end

				for iter_694_0, iter_694_1 in pairs(arg_691_1.bgs_) do
					if iter_694_0 ~= "ST06" then
						iter_694_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_694_4 = 0

			if 0 < arg_691_1.time_ and arg_691_1.time_ <= var_694_4 + arg_694_0 then
				arg_691_1.mask_.enabled = true
				arg_691_1.mask_.raycastTarget = true

				arg_691_1:SetGaussion(false)
			end

			local var_694_5 = 1.66666666666667

			if var_694_4 <= arg_691_1.time_ and arg_691_1.time_ < var_694_4 + var_694_5 then
				local var_694_6 = Color.New(0.990566, 0.990566, 0.990566)

				var_694_6.a = Mathf.Lerp(0, 1, (arg_691_1.time_ - var_694_4) / var_694_5)
				arg_691_1.mask_.color = var_694_6
			end

			if arg_691_1.time_ >= var_694_4 + var_694_5 and arg_691_1.time_ < var_694_4 + var_694_5 + arg_694_0 then
				local var_694_7 = Color.New(0.990566, 0.990566, 0.990566)

				var_694_7.a = 1
				arg_691_1.mask_.color = var_694_7
			end

			local var_694_8 = 1.66666666666667

			if 1.66666666666667 < arg_691_1.time_ and arg_691_1.time_ <= var_694_8 + arg_694_0 then
				arg_691_1.mask_.enabled = true
				arg_691_1.mask_.raycastTarget = true

				arg_691_1:SetGaussion(false)
			end

			local var_694_9 = 1.23333333333333

			if var_694_8 <= arg_691_1.time_ and arg_691_1.time_ < var_694_8 + var_694_9 then
				local var_694_10 = Color.New(0.990566, 0.990566, 0.990566)

				var_694_10.a = Mathf.Lerp(1, 0, (arg_691_1.time_ - var_694_8) / var_694_9)
				arg_691_1.mask_.color = var_694_10
			end

			if arg_691_1.time_ >= var_694_8 + var_694_9 and arg_691_1.time_ < var_694_8 + var_694_9 + arg_694_0 then
				local var_694_11 = Color.New(0.990566, 0.990566, 0.990566)

				arg_691_1.mask_.enabled = false
				var_694_11.a = 0
				arg_691_1.mask_.color = var_694_11
			end

			if arg_691_1.frameCnt_ <= 1 then
				arg_691_1.dialog_:SetActive(false)
			end

			local var_694_12 = 3.26559620979242
			local var_694_13 = 0.825

			if 3.26559620979242 < arg_691_1.time_ and arg_691_1.time_ <= var_694_12 + arg_694_0 then
				arg_691_1.talkMaxDuration = 0

				arg_691_1.dialog_:SetActive(true)

				arg_691_1.dialogCg_.alpha = 0

				local var_694_14 = LeanTween.value(arg_691_1.dialog_, 0, 1, 0.3)

				var_694_14:setOnUpdate(LuaHelper.FloatAction(function(arg_695_0)
					arg_691_1.dialogCg_.alpha = arg_695_0
				end))
				var_694_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_691_1.dialog_)
					var_694_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_691_1.duration_ = arg_691_1.duration_ + 0.3

				SetActive(arg_691_1.leftNameGo_, false)

				arg_691_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_691_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_691_1:RecordName(arg_691_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_691_1.iconTrs_.gameObject, false)
				arg_691_1.callingController_:SetSelectedState("normal")

				local var_694_15 = arg_691_1:FormatText(arg_691_1:GetWordFromCfg(1109305175).content)

				arg_691_1.text_.text = var_694_15

				LuaForUtil.ClearLinePrefixSymbol(arg_691_1.text_)

				local var_694_17 = 33 <= 0 and var_694_13 or var_694_13 * (utf8.len(var_694_15) / 33)

				if (33 <= 0 and var_694_13 or var_694_13 * (utf8.len(var_694_15) / 33)) > 0 and var_694_13 < var_694_17 then
					arg_691_1.talkMaxDuration = var_694_17
					var_694_12 = var_694_12 + 0.3

					if var_694_17 + var_694_12 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_17 + var_694_12
					end
				end

				arg_691_1.text_.text = var_694_15
				arg_691_1.typewritter.percent = 0

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(false)
				arg_691_1:RecordContent(arg_691_1.text_.text)
			end

			local var_694_18 = var_694_12 + 0.3
			local var_694_19 = math.max(var_694_13, arg_691_1.talkMaxDuration)

			if var_694_12 + 0.3 <= arg_691_1.time_ and arg_691_1.time_ < var_694_18 + var_694_19 then
				arg_691_1.typewritter.percent = (arg_691_1.time_ - var_694_18) / var_694_19

				arg_691_1.typewritter:SetDirty()
			end

			if arg_691_1.time_ >= var_694_18 + var_694_19 and arg_691_1.time_ < var_694_18 + var_694_19 + arg_694_0 then
				arg_691_1.typewritter.percent = 1

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(true)
			end
		end

		arg_691_1.nodeConfigList_ = {}

		arg_691_1:InitPlayNodeList()
	end,
	Play1109305176 = function(arg_697_0, arg_697_1)
		arg_697_1.time_ = 0
		arg_697_1.frameCnt_ = 0
		arg_697_1.state_ = "playing"
		arg_697_1.curTalkId_ = 1109305176
		arg_697_1.duration_ = 5

		SetActive(arg_697_1.tipsGo_, false)

		function arg_697_1.onSingleLineFinish_()
			arg_697_1.onSingleLineUpdate_ = nil
			arg_697_1.onSingleLineFinish_ = nil
			arg_697_1.state_ = "waiting"
		end

		function arg_697_1.playNext_(arg_699_0)
			if arg_699_0 == 1 then
				arg_697_0:Play1109305177(arg_697_1)
			end
		end

		function arg_697_1.onSingleLineUpdate_(arg_700_0)
			local var_700_0 = 0.725

			if 0 < arg_697_1.time_ and arg_697_1.time_ <= 0 + arg_700_0 then
				arg_697_1.talkMaxDuration = 0
				arg_697_1.dialogCg_.alpha = 1

				arg_697_1.dialog_:SetActive(true)
				SetActive(arg_697_1.leftNameGo_, false)

				arg_697_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_697_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_697_1:RecordName(arg_697_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_697_1.iconTrs_.gameObject, false)
				arg_697_1.callingController_:SetSelectedState("normal")

				local var_700_1 = arg_697_1:FormatText(arg_697_1:GetWordFromCfg(1109305176).content)

				arg_697_1.text_.text = var_700_1

				LuaForUtil.ClearLinePrefixSymbol(arg_697_1.text_)

				local var_700_3 = 29 <= 0 and var_700_0 or var_700_0 * (utf8.len(var_700_1) / 29)

				if (29 <= 0 and var_700_0 or var_700_0 * (utf8.len(var_700_1) / 29)) > 0 and var_700_0 < var_700_3 then
					arg_697_1.talkMaxDuration = var_700_3

					if var_700_3 + 0 > arg_697_1.duration_ then
						arg_697_1.duration_ = var_700_3 + 0
					end
				end

				arg_697_1.text_.text = var_700_1
				arg_697_1.typewritter.percent = 0

				arg_697_1.typewritter:SetDirty()
				arg_697_1:ShowNextGo(false)
				arg_697_1:RecordContent(arg_697_1.text_.text)
			end

			local var_700_4 = math.max(var_700_0, arg_697_1.talkMaxDuration)

			if 0 <= arg_697_1.time_ and arg_697_1.time_ < 0 + var_700_4 then
				arg_697_1.typewritter.percent = (arg_697_1.time_ - 0) / var_700_4

				arg_697_1.typewritter:SetDirty()
			end

			if arg_697_1.time_ >= 0 + var_700_4 and arg_697_1.time_ < 0 + var_700_4 + arg_700_0 then
				arg_697_1.typewritter.percent = 1

				arg_697_1.typewritter:SetDirty()
				arg_697_1:ShowNextGo(true)
			end
		end

		arg_697_1.nodeConfigList_ = {}

		arg_697_1:InitPlayNodeList()
	end,
	Play1109305177 = function(arg_701_0, arg_701_1)
		arg_701_1.time_ = 0
		arg_701_1.frameCnt_ = 0
		arg_701_1.state_ = "playing"
		arg_701_1.curTalkId_ = 1109305177
		arg_701_1.duration_ = 5

		SetActive(arg_701_1.tipsGo_, false)

		function arg_701_1.onSingleLineFinish_()
			arg_701_1.onSingleLineUpdate_ = nil
			arg_701_1.onSingleLineFinish_ = nil
			arg_701_1.state_ = "waiting"
		end

		function arg_701_1.playNext_(arg_703_0)
			if arg_703_0 == 1 then
				arg_701_0:Play1109305178(arg_701_1)
			end
		end

		function arg_701_1.onSingleLineUpdate_(arg_704_0)
			local var_704_0 = 0.7

			if 0 < arg_701_1.time_ and arg_701_1.time_ <= 0 + arg_704_0 then
				arg_701_1.talkMaxDuration = 0
				arg_701_1.dialogCg_.alpha = 1

				arg_701_1.dialog_:SetActive(true)
				SetActive(arg_701_1.leftNameGo_, false)

				arg_701_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_701_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_701_1:RecordName(arg_701_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_701_1.iconTrs_.gameObject, false)
				arg_701_1.callingController_:SetSelectedState("normal")

				local var_704_1 = arg_701_1:FormatText(arg_701_1:GetWordFromCfg(1109305177).content)

				arg_701_1.text_.text = var_704_1

				LuaForUtil.ClearLinePrefixSymbol(arg_701_1.text_)

				local var_704_3 = 28 <= 0 and var_704_0 or var_704_0 * (utf8.len(var_704_1) / 28)

				if (28 <= 0 and var_704_0 or var_704_0 * (utf8.len(var_704_1) / 28)) > 0 and var_704_0 < var_704_3 then
					arg_701_1.talkMaxDuration = var_704_3

					if var_704_3 + 0 > arg_701_1.duration_ then
						arg_701_1.duration_ = var_704_3 + 0
					end
				end

				arg_701_1.text_.text = var_704_1
				arg_701_1.typewritter.percent = 0

				arg_701_1.typewritter:SetDirty()
				arg_701_1:ShowNextGo(false)
				arg_701_1:RecordContent(arg_701_1.text_.text)
			end

			local var_704_4 = math.max(var_704_0, arg_701_1.talkMaxDuration)

			if 0 <= arg_701_1.time_ and arg_701_1.time_ < 0 + var_704_4 then
				arg_701_1.typewritter.percent = (arg_701_1.time_ - 0) / var_704_4

				arg_701_1.typewritter:SetDirty()
			end

			if arg_701_1.time_ >= 0 + var_704_4 and arg_701_1.time_ < 0 + var_704_4 + arg_704_0 then
				arg_701_1.typewritter.percent = 1

				arg_701_1.typewritter:SetDirty()
				arg_701_1:ShowNextGo(true)
			end
		end

		arg_701_1.nodeConfigList_ = {}

		arg_701_1:InitPlayNodeList()
	end,
	Play1109305178 = function(arg_705_0, arg_705_1)
		arg_705_1.time_ = 0
		arg_705_1.frameCnt_ = 0
		arg_705_1.state_ = "playing"
		arg_705_1.curTalkId_ = 1109305178
		arg_705_1.duration_ = 3.63

		SetActive(arg_705_1.tipsGo_, false)

		function arg_705_1.onSingleLineFinish_()
			arg_705_1.onSingleLineUpdate_ = nil
			arg_705_1.onSingleLineFinish_ = nil
			arg_705_1.state_ = "waiting"
		end

		function arg_705_1.playNext_(arg_707_0)
			if arg_707_0 == 1 then
				arg_705_0:Play1109305179(arg_705_1)
			end
		end

		function arg_705_1.onSingleLineUpdate_(arg_708_0)
			if 0 < arg_705_1.time_ and arg_705_1.time_ <= 0 + arg_708_0 then
				arg_705_1.var_.moveOldPos1093ui_story = arg_705_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_708_0 = 0.001

			if 0 <= arg_705_1.time_ and arg_705_1.time_ < 0 + var_708_0 then
				arg_705_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_705_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_705_1.time_ - 0) / var_708_0)
				arg_705_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_705_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_705_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_705_1.actors_["1093ui_story"].transform.position).z)
				arg_705_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_705_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_705_1.actors_["1093ui_story"].transform.localEulerAngles = arg_705_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_705_1.time_ >= 0 + var_708_0 and arg_705_1.time_ < 0 + var_708_0 + arg_708_0 then
				arg_705_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_705_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_705_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_705_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_705_1.actors_["1093ui_story"].transform.position).z)
				arg_705_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_705_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_705_1.actors_["1093ui_story"].transform.localEulerAngles = arg_705_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_708_1 = arg_705_1.actors_["1093ui_story"]

			if 0 < arg_705_1.time_ and arg_705_1.time_ <= 0 + arg_708_0 and not isNil(var_708_1) and arg_705_1.var_.characterEffect1093ui_story == nil then
				arg_705_1.var_.characterEffect1093ui_story = var_708_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_708_2 = 0.200000002980232

			if 0 <= arg_705_1.time_ and arg_705_1.time_ < 0 + var_708_2 and not isNil(var_708_1) then
				if arg_705_1.var_.characterEffect1093ui_story and not isNil(var_708_1) then
					arg_705_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_705_1.time_ >= 0 + var_708_2 and arg_705_1.time_ < 0 + var_708_2 + arg_708_0 and not isNil(var_708_1) and arg_705_1.var_.characterEffect1093ui_story then
				arg_705_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_705_1.time_ and arg_705_1.time_ <= 0 + arg_708_0 then
				arg_705_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action476")
			end

			if 0 < arg_705_1.time_ and arg_705_1.time_ <= 0 + arg_708_0 then
				arg_705_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_708_4 = 0
			local var_708_5 = 0.325

			if 0 < arg_705_1.time_ and arg_705_1.time_ <= var_708_4 + arg_708_0 then
				arg_705_1.talkMaxDuration = 0
				arg_705_1.dialogCg_.alpha = 1

				arg_705_1.dialog_:SetActive(true)
				SetActive(arg_705_1.leftNameGo_, true)

				arg_705_1.leftNameTxt_.text = arg_705_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_705_1.leftNameTxt_.transform)

				arg_705_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_705_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_705_1:RecordName(arg_705_1.leftNameTxt_.text)
				SetActive(arg_705_1.iconTrs_.gameObject, false)
				arg_705_1.callingController_:SetSelectedState("normal")

				local var_708_6 = arg_705_1:GetWordFromCfg(1109305178)
				local var_708_7 = arg_705_1:FormatText(var_708_6.content)

				arg_705_1.text_.text = var_708_7

				LuaForUtil.ClearLinePrefixSymbol(arg_705_1.text_)

				local var_708_9 = 13 <= 0 and var_708_5 or var_708_5 * (utf8.len(var_708_7) / 13)

				if (13 <= 0 and var_708_5 or var_708_5 * (utf8.len(var_708_7) / 13)) > 0 and var_708_5 < var_708_9 then
					arg_705_1.talkMaxDuration = var_708_9

					if var_708_9 + var_708_4 > arg_705_1.duration_ then
						arg_705_1.duration_ = var_708_9 + var_708_4
					end
				end

				arg_705_1.text_.text = var_708_7
				arg_705_1.typewritter.percent = 0

				arg_705_1.typewritter:SetDirty()
				arg_705_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305178", "story_v_side_new_1109305.awb") ~= 0 then
					local var_708_10 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305178", "story_v_side_new_1109305.awb") / 1000

					if var_708_10 + var_708_4 > arg_705_1.duration_ then
						arg_705_1.duration_ = var_708_10 + var_708_4
					end

					if var_708_6.prefab_name ~= "" and arg_705_1.actors_[var_708_6.prefab_name] ~= nil then
						local var_708_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_705_1.actors_[var_708_6.prefab_name].transform, "story_v_side_new_1109305", "1109305178", "story_v_side_new_1109305.awb")

						arg_705_1:RecordAudio("1109305178", var_708_11)
						arg_705_1:RecordAudio("1109305178", var_708_11)
					else
						arg_705_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305178", "story_v_side_new_1109305.awb")
					end

					arg_705_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305178", "story_v_side_new_1109305.awb")
				end

				arg_705_1:RecordContent(arg_705_1.text_.text)
			end

			local var_708_12 = math.max(var_708_5, arg_705_1.talkMaxDuration)

			if var_708_4 <= arg_705_1.time_ and arg_705_1.time_ < var_708_4 + var_708_12 then
				arg_705_1.typewritter.percent = (arg_705_1.time_ - var_708_4) / var_708_12

				arg_705_1.typewritter:SetDirty()
			end

			if arg_705_1.time_ >= var_708_4 + var_708_12 and arg_705_1.time_ < var_708_4 + var_708_12 + arg_708_0 then
				arg_705_1.typewritter.percent = 1

				arg_705_1.typewritter:SetDirty()
				arg_705_1:ShowNextGo(true)
			end
		end

		arg_705_1.nodeConfigList_ = {
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

		arg_705_1:InitPlayNodeList()
	end,
	Play1109305179 = function(arg_709_0, arg_709_1)
		arg_709_1.time_ = 0
		arg_709_1.frameCnt_ = 0
		arg_709_1.state_ = "playing"
		arg_709_1.curTalkId_ = 1109305179
		arg_709_1.duration_ = 5

		SetActive(arg_709_1.tipsGo_, false)

		function arg_709_1.onSingleLineFinish_()
			arg_709_1.onSingleLineUpdate_ = nil
			arg_709_1.onSingleLineFinish_ = nil
			arg_709_1.state_ = "waiting"
		end

		function arg_709_1.playNext_(arg_711_0)
			if arg_711_0 == 1 then
				arg_709_0:Play1109305180(arg_709_1)
			end
		end

		function arg_709_1.onSingleLineUpdate_(arg_712_0)
			if 0 < arg_709_1.time_ and arg_709_1.time_ <= 0 + arg_712_0 and not isNil(arg_709_1.actors_["1093ui_story"]) and arg_709_1.var_.characterEffect1093ui_story == nil then
				arg_709_1.var_.characterEffect1093ui_story = arg_709_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_712_0 = 0.200000002980232

			if 0 <= arg_709_1.time_ and arg_709_1.time_ < 0 + var_712_0 and not isNil(arg_709_1.actors_["1093ui_story"]) then
				if arg_709_1.var_.characterEffect1093ui_story and not isNil(arg_709_1.actors_["1093ui_story"]) then
					arg_709_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_709_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_709_1.time_ - 0) / var_712_0)
				end
			end

			if arg_709_1.time_ >= 0 + var_712_0 and arg_709_1.time_ < 0 + var_712_0 + arg_712_0 and not isNil(arg_709_1.actors_["1093ui_story"]) and arg_709_1.var_.characterEffect1093ui_story then
				arg_709_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_709_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_712_1 = 0
			local var_712_2 = 0.6

			if 0 < arg_709_1.time_ and arg_709_1.time_ <= var_712_1 + arg_712_0 then
				arg_709_1.talkMaxDuration = 0
				arg_709_1.dialogCg_.alpha = 1

				arg_709_1.dialog_:SetActive(true)
				SetActive(arg_709_1.leftNameGo_, true)

				arg_709_1.leftNameTxt_.text = arg_709_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_709_1.leftNameTxt_.transform)

				arg_709_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_709_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_709_1:RecordName(arg_709_1.leftNameTxt_.text)
				SetActive(arg_709_1.iconTrs_.gameObject, true)
				arg_709_1.iconController_:SetSelectedState("hero")

				arg_709_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_709_1.callingController_:SetSelectedState("normal")

				arg_709_1.keyicon_.color = Color.New(1, 1, 1)
				arg_709_1.icon_.color = Color.New(1, 1, 1)

				local var_712_3 = arg_709_1:FormatText(arg_709_1:GetWordFromCfg(1109305179).content)

				arg_709_1.text_.text = var_712_3

				LuaForUtil.ClearLinePrefixSymbol(arg_709_1.text_)

				local var_712_5 = 24 <= 0 and var_712_2 or var_712_2 * (utf8.len(var_712_3) / 24)

				if (24 <= 0 and var_712_2 or var_712_2 * (utf8.len(var_712_3) / 24)) > 0 and var_712_2 < var_712_5 then
					arg_709_1.talkMaxDuration = var_712_5

					if var_712_5 + var_712_1 > arg_709_1.duration_ then
						arg_709_1.duration_ = var_712_5 + var_712_1
					end
				end

				arg_709_1.text_.text = var_712_3
				arg_709_1.typewritter.percent = 0

				arg_709_1.typewritter:SetDirty()
				arg_709_1:ShowNextGo(false)
				arg_709_1:RecordContent(arg_709_1.text_.text)
			end

			local var_712_6 = math.max(var_712_2, arg_709_1.talkMaxDuration)

			if var_712_1 <= arg_709_1.time_ and arg_709_1.time_ < var_712_1 + var_712_6 then
				arg_709_1.typewritter.percent = (arg_709_1.time_ - var_712_1) / var_712_6

				arg_709_1.typewritter:SetDirty()
			end

			if arg_709_1.time_ >= var_712_1 + var_712_6 and arg_709_1.time_ < var_712_1 + var_712_6 + arg_712_0 then
				arg_709_1.typewritter.percent = 1

				arg_709_1.typewritter:SetDirty()
				arg_709_1:ShowNextGo(true)
			end
		end

		arg_709_1.nodeConfigList_ = {}

		arg_709_1:InitPlayNodeList()
	end,
	Play1109305180 = function(arg_713_0, arg_713_1)
		arg_713_1.time_ = 0
		arg_713_1.frameCnt_ = 0
		arg_713_1.state_ = "playing"
		arg_713_1.curTalkId_ = 1109305180
		arg_713_1.duration_ = 5

		SetActive(arg_713_1.tipsGo_, false)

		function arg_713_1.onSingleLineFinish_()
			arg_713_1.onSingleLineUpdate_ = nil
			arg_713_1.onSingleLineFinish_ = nil
			arg_713_1.state_ = "waiting"
		end

		function arg_713_1.playNext_(arg_715_0)
			if arg_715_0 == 1 then
				arg_713_0:Play1109305181(arg_713_1)
			end
		end

		function arg_713_1.onSingleLineUpdate_(arg_716_0)
			local var_716_0 = 0.7

			if 0 < arg_713_1.time_ and arg_713_1.time_ <= 0 + arg_716_0 then
				arg_713_1.talkMaxDuration = 0
				arg_713_1.dialogCg_.alpha = 1

				arg_713_1.dialog_:SetActive(true)
				SetActive(arg_713_1.leftNameGo_, true)

				arg_713_1.leftNameTxt_.text = arg_713_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_713_1.leftNameTxt_.transform)

				arg_713_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_713_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_713_1:RecordName(arg_713_1.leftNameTxt_.text)
				SetActive(arg_713_1.iconTrs_.gameObject, true)
				arg_713_1.iconController_:SetSelectedState("hero")

				arg_713_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_713_1.callingController_:SetSelectedState("normal")

				arg_713_1.keyicon_.color = Color.New(1, 1, 1)
				arg_713_1.icon_.color = Color.New(1, 1, 1)

				local var_716_1 = arg_713_1:FormatText(arg_713_1:GetWordFromCfg(1109305180).content)

				arg_713_1.text_.text = var_716_1

				LuaForUtil.ClearLinePrefixSymbol(arg_713_1.text_)

				local var_716_3 = 28 <= 0 and var_716_0 or var_716_0 * (utf8.len(var_716_1) / 28)

				if (28 <= 0 and var_716_0 or var_716_0 * (utf8.len(var_716_1) / 28)) > 0 and var_716_0 < var_716_3 then
					arg_713_1.talkMaxDuration = var_716_3

					if var_716_3 + 0 > arg_713_1.duration_ then
						arg_713_1.duration_ = var_716_3 + 0
					end
				end

				arg_713_1.text_.text = var_716_1
				arg_713_1.typewritter.percent = 0

				arg_713_1.typewritter:SetDirty()
				arg_713_1:ShowNextGo(false)
				arg_713_1:RecordContent(arg_713_1.text_.text)
			end

			local var_716_4 = math.max(var_716_0, arg_713_1.talkMaxDuration)

			if 0 <= arg_713_1.time_ and arg_713_1.time_ < 0 + var_716_4 then
				arg_713_1.typewritter.percent = (arg_713_1.time_ - 0) / var_716_4

				arg_713_1.typewritter:SetDirty()
			end

			if arg_713_1.time_ >= 0 + var_716_4 and arg_713_1.time_ < 0 + var_716_4 + arg_716_0 then
				arg_713_1.typewritter.percent = 1

				arg_713_1.typewritter:SetDirty()
				arg_713_1:ShowNextGo(true)
			end
		end

		arg_713_1.nodeConfigList_ = {}

		arg_713_1:InitPlayNodeList()
	end,
	Play1109305181 = function(arg_717_0, arg_717_1)
		arg_717_1.time_ = 0
		arg_717_1.frameCnt_ = 0
		arg_717_1.state_ = "playing"
		arg_717_1.curTalkId_ = 1109305181
		arg_717_1.duration_ = 5

		SetActive(arg_717_1.tipsGo_, false)

		function arg_717_1.onSingleLineFinish_()
			arg_717_1.onSingleLineUpdate_ = nil
			arg_717_1.onSingleLineFinish_ = nil
			arg_717_1.state_ = "waiting"
		end

		function arg_717_1.playNext_(arg_719_0)
			if arg_719_0 == 1 then
				arg_717_0:Play1109305182(arg_717_1)
			end
		end

		function arg_717_1.onSingleLineUpdate_(arg_720_0)
			local var_720_0 = 0.65

			if 0 < arg_717_1.time_ and arg_717_1.time_ <= 0 + arg_720_0 then
				arg_717_1.talkMaxDuration = 0
				arg_717_1.dialogCg_.alpha = 1

				arg_717_1.dialog_:SetActive(true)
				SetActive(arg_717_1.leftNameGo_, true)

				arg_717_1.leftNameTxt_.text = arg_717_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_717_1.leftNameTxt_.transform)

				arg_717_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_717_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_717_1:RecordName(arg_717_1.leftNameTxt_.text)
				SetActive(arg_717_1.iconTrs_.gameObject, true)
				arg_717_1.iconController_:SetSelectedState("hero")

				arg_717_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_717_1.callingController_:SetSelectedState("normal")

				arg_717_1.keyicon_.color = Color.New(1, 1, 1)
				arg_717_1.icon_.color = Color.New(1, 1, 1)

				local var_720_1 = arg_717_1:FormatText(arg_717_1:GetWordFromCfg(1109305181).content)

				arg_717_1.text_.text = var_720_1

				LuaForUtil.ClearLinePrefixSymbol(arg_717_1.text_)

				local var_720_3 = 26 <= 0 and var_720_0 or var_720_0 * (utf8.len(var_720_1) / 26)

				if (26 <= 0 and var_720_0 or var_720_0 * (utf8.len(var_720_1) / 26)) > 0 and var_720_0 < var_720_3 then
					arg_717_1.talkMaxDuration = var_720_3

					if var_720_3 + 0 > arg_717_1.duration_ then
						arg_717_1.duration_ = var_720_3 + 0
					end
				end

				arg_717_1.text_.text = var_720_1
				arg_717_1.typewritter.percent = 0

				arg_717_1.typewritter:SetDirty()
				arg_717_1:ShowNextGo(false)
				arg_717_1:RecordContent(arg_717_1.text_.text)
			end

			local var_720_4 = math.max(var_720_0, arg_717_1.talkMaxDuration)

			if 0 <= arg_717_1.time_ and arg_717_1.time_ < 0 + var_720_4 then
				arg_717_1.typewritter.percent = (arg_717_1.time_ - 0) / var_720_4

				arg_717_1.typewritter:SetDirty()
			end

			if arg_717_1.time_ >= 0 + var_720_4 and arg_717_1.time_ < 0 + var_720_4 + arg_720_0 then
				arg_717_1.typewritter.percent = 1

				arg_717_1.typewritter:SetDirty()
				arg_717_1:ShowNextGo(true)
			end
		end

		arg_717_1.nodeConfigList_ = {}

		arg_717_1:InitPlayNodeList()
	end,
	Play1109305182 = function(arg_721_0, arg_721_1)
		arg_721_1.time_ = 0
		arg_721_1.frameCnt_ = 0
		arg_721_1.state_ = "playing"
		arg_721_1.curTalkId_ = 1109305182
		arg_721_1.duration_ = 6

		SetActive(arg_721_1.tipsGo_, false)

		function arg_721_1.onSingleLineFinish_()
			arg_721_1.onSingleLineUpdate_ = nil
			arg_721_1.onSingleLineFinish_ = nil
			arg_721_1.state_ = "waiting"
		end

		function arg_721_1.playNext_(arg_723_0)
			if arg_723_0 == 1 then
				arg_721_0:Play1109305183(arg_721_1)
			end
		end

		function arg_721_1.onSingleLineUpdate_(arg_724_0)
			if 0 < arg_721_1.time_ and arg_721_1.time_ <= 0 + arg_724_0 then
				arg_721_1.var_.moveOldPos1093ui_story = arg_721_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_724_0 = 0.001

			if 0 <= arg_721_1.time_ and arg_721_1.time_ < 0 + var_724_0 then
				arg_721_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_721_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_721_1.time_ - 0) / var_724_0)
				arg_721_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_721_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_721_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_721_1.actors_["1093ui_story"].transform.position).z)
				arg_721_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_721_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_721_1.actors_["1093ui_story"].transform.localEulerAngles = arg_721_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_721_1.time_ >= 0 + var_724_0 and arg_721_1.time_ < 0 + var_724_0 + arg_724_0 then
				arg_721_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_721_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_721_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_721_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_721_1.actors_["1093ui_story"].transform.position).z)
				arg_721_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_721_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_721_1.actors_["1093ui_story"].transform.localEulerAngles = arg_721_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_724_1 = arg_721_1.actors_["1093ui_story"]

			if 0 < arg_721_1.time_ and arg_721_1.time_ <= 0 + arg_724_0 and not isNil(var_724_1) and arg_721_1.var_.characterEffect1093ui_story == nil then
				arg_721_1.var_.characterEffect1093ui_story = var_724_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_724_2 = 0.200000002980232

			if 0 <= arg_721_1.time_ and arg_721_1.time_ < 0 + var_724_2 and not isNil(var_724_1) then
				if arg_721_1.var_.characterEffect1093ui_story and not isNil(var_724_1) then
					arg_721_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_721_1.time_ >= 0 + var_724_2 and arg_721_1.time_ < 0 + var_724_2 + arg_724_0 and not isNil(var_724_1) and arg_721_1.var_.characterEffect1093ui_story then
				arg_721_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_721_1.time_ and arg_721_1.time_ <= 0 + arg_724_0 then
				arg_721_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action469")
			end

			if 0 < arg_721_1.time_ and arg_721_1.time_ <= 0 + arg_724_0 then
				arg_721_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_724_4 = 0
			local var_724_5 = 0.725

			if 0 < arg_721_1.time_ and arg_721_1.time_ <= var_724_4 + arg_724_0 then
				arg_721_1.talkMaxDuration = 0
				arg_721_1.dialogCg_.alpha = 1

				arg_721_1.dialog_:SetActive(true)
				SetActive(arg_721_1.leftNameGo_, true)

				arg_721_1.leftNameTxt_.text = arg_721_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_721_1.leftNameTxt_.transform)

				arg_721_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_721_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_721_1:RecordName(arg_721_1.leftNameTxt_.text)
				SetActive(arg_721_1.iconTrs_.gameObject, false)
				arg_721_1.callingController_:SetSelectedState("normal")

				local var_724_6 = arg_721_1:GetWordFromCfg(1109305182)
				local var_724_7 = arg_721_1:FormatText(var_724_6.content)

				arg_721_1.text_.text = var_724_7

				LuaForUtil.ClearLinePrefixSymbol(arg_721_1.text_)

				local var_724_9 = 29 <= 0 and var_724_5 or var_724_5 * (utf8.len(var_724_7) / 29)

				if (29 <= 0 and var_724_5 or var_724_5 * (utf8.len(var_724_7) / 29)) > 0 and var_724_5 < var_724_9 then
					arg_721_1.talkMaxDuration = var_724_9

					if var_724_9 + var_724_4 > arg_721_1.duration_ then
						arg_721_1.duration_ = var_724_9 + var_724_4
					end
				end

				arg_721_1.text_.text = var_724_7
				arg_721_1.typewritter.percent = 0

				arg_721_1.typewritter:SetDirty()
				arg_721_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305182", "story_v_side_new_1109305.awb") ~= 0 then
					local var_724_10 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305182", "story_v_side_new_1109305.awb") / 1000

					if var_724_10 + var_724_4 > arg_721_1.duration_ then
						arg_721_1.duration_ = var_724_10 + var_724_4
					end

					if var_724_6.prefab_name ~= "" and arg_721_1.actors_[var_724_6.prefab_name] ~= nil then
						local var_724_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_721_1.actors_[var_724_6.prefab_name].transform, "story_v_side_new_1109305", "1109305182", "story_v_side_new_1109305.awb")

						arg_721_1:RecordAudio("1109305182", var_724_11)
						arg_721_1:RecordAudio("1109305182", var_724_11)
					else
						arg_721_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305182", "story_v_side_new_1109305.awb")
					end

					arg_721_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305182", "story_v_side_new_1109305.awb")
				end

				arg_721_1:RecordContent(arg_721_1.text_.text)
			end

			local var_724_12 = math.max(var_724_5, arg_721_1.talkMaxDuration)

			if var_724_4 <= arg_721_1.time_ and arg_721_1.time_ < var_724_4 + var_724_12 then
				arg_721_1.typewritter.percent = (arg_721_1.time_ - var_724_4) / var_724_12

				arg_721_1.typewritter:SetDirty()
			end

			if arg_721_1.time_ >= var_724_4 + var_724_12 and arg_721_1.time_ < var_724_4 + var_724_12 + arg_724_0 then
				arg_721_1.typewritter.percent = 1

				arg_721_1.typewritter:SetDirty()
				arg_721_1:ShowNextGo(true)
			end
		end

		arg_721_1.nodeConfigList_ = {
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

		arg_721_1:InitPlayNodeList()
	end,
	Play1109305183 = function(arg_725_0, arg_725_1)
		arg_725_1.time_ = 0
		arg_725_1.frameCnt_ = 0
		arg_725_1.state_ = "playing"
		arg_725_1.curTalkId_ = 1109305183
		arg_725_1.duration_ = 4.6

		SetActive(arg_725_1.tipsGo_, false)

		function arg_725_1.onSingleLineFinish_()
			arg_725_1.onSingleLineUpdate_ = nil
			arg_725_1.onSingleLineFinish_ = nil
			arg_725_1.state_ = "waiting"
		end

		function arg_725_1.playNext_(arg_727_0)
			if arg_727_0 == 1 then
				arg_725_0:Play1109305184(arg_725_1)
			end
		end

		function arg_725_1.onSingleLineUpdate_(arg_728_0)
			local var_728_0 = 0.55

			if 0 < arg_725_1.time_ and arg_725_1.time_ <= 0 + arg_728_0 then
				arg_725_1.talkMaxDuration = 0
				arg_725_1.dialogCg_.alpha = 1

				arg_725_1.dialog_:SetActive(true)
				SetActive(arg_725_1.leftNameGo_, true)

				arg_725_1.leftNameTxt_.text = arg_725_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_725_1.leftNameTxt_.transform)

				arg_725_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_725_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_725_1:RecordName(arg_725_1.leftNameTxt_.text)
				SetActive(arg_725_1.iconTrs_.gameObject, false)
				arg_725_1.callingController_:SetSelectedState("normal")

				local var_728_1 = arg_725_1:GetWordFromCfg(1109305183)
				local var_728_2 = arg_725_1:FormatText(var_728_1.content)

				arg_725_1.text_.text = var_728_2

				LuaForUtil.ClearLinePrefixSymbol(arg_725_1.text_)

				local var_728_4 = 22 <= 0 and var_728_0 or var_728_0 * (utf8.len(var_728_2) / 22)

				if (22 <= 0 and var_728_0 or var_728_0 * (utf8.len(var_728_2) / 22)) > 0 and var_728_0 < var_728_4 then
					arg_725_1.talkMaxDuration = var_728_4

					if var_728_4 + 0 > arg_725_1.duration_ then
						arg_725_1.duration_ = var_728_4 + 0
					end
				end

				arg_725_1.text_.text = var_728_2
				arg_725_1.typewritter.percent = 0

				arg_725_1.typewritter:SetDirty()
				arg_725_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305183", "story_v_side_new_1109305.awb") ~= 0 then
					local var_728_5 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305183", "story_v_side_new_1109305.awb") / 1000

					if var_728_5 + 0 > arg_725_1.duration_ then
						arg_725_1.duration_ = var_728_5 + 0
					end

					if var_728_1.prefab_name ~= "" and arg_725_1.actors_[var_728_1.prefab_name] ~= nil then
						local var_728_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_725_1.actors_[var_728_1.prefab_name].transform, "story_v_side_new_1109305", "1109305183", "story_v_side_new_1109305.awb")

						arg_725_1:RecordAudio("1109305183", var_728_6)
						arg_725_1:RecordAudio("1109305183", var_728_6)
					else
						arg_725_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305183", "story_v_side_new_1109305.awb")
					end

					arg_725_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305183", "story_v_side_new_1109305.awb")
				end

				arg_725_1:RecordContent(arg_725_1.text_.text)
			end

			local var_728_7 = math.max(var_728_0, arg_725_1.talkMaxDuration)

			if 0 <= arg_725_1.time_ and arg_725_1.time_ < 0 + var_728_7 then
				arg_725_1.typewritter.percent = (arg_725_1.time_ - 0) / var_728_7

				arg_725_1.typewritter:SetDirty()
			end

			if arg_725_1.time_ >= 0 + var_728_7 and arg_725_1.time_ < 0 + var_728_7 + arg_728_0 then
				arg_725_1.typewritter.percent = 1

				arg_725_1.typewritter:SetDirty()
				arg_725_1:ShowNextGo(true)
			end
		end

		arg_725_1.nodeConfigList_ = {}

		arg_725_1:InitPlayNodeList()
	end,
	Play1109305184 = function(arg_729_0, arg_729_1)
		arg_729_1.time_ = 0
		arg_729_1.frameCnt_ = 0
		arg_729_1.state_ = "playing"
		arg_729_1.curTalkId_ = 1109305184
		arg_729_1.duration_ = 8.93

		SetActive(arg_729_1.tipsGo_, false)

		function arg_729_1.onSingleLineFinish_()
			arg_729_1.onSingleLineUpdate_ = nil
			arg_729_1.onSingleLineFinish_ = nil
			arg_729_1.state_ = "waiting"
		end

		function arg_729_1.playNext_(arg_731_0)
			if arg_731_0 == 1 then
				arg_729_0:Play1109305185(arg_729_1)
			end
		end

		function arg_729_1.onSingleLineUpdate_(arg_732_0)
			local var_732_0 = 1.05

			if 0 < arg_729_1.time_ and arg_729_1.time_ <= 0 + arg_732_0 then
				arg_729_1.talkMaxDuration = 0
				arg_729_1.dialogCg_.alpha = 1

				arg_729_1.dialog_:SetActive(true)
				SetActive(arg_729_1.leftNameGo_, true)

				arg_729_1.leftNameTxt_.text = arg_729_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_729_1.leftNameTxt_.transform)

				arg_729_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_729_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_729_1:RecordName(arg_729_1.leftNameTxt_.text)
				SetActive(arg_729_1.iconTrs_.gameObject, false)
				arg_729_1.callingController_:SetSelectedState("normal")

				local var_732_1 = arg_729_1:GetWordFromCfg(1109305184)
				local var_732_2 = arg_729_1:FormatText(var_732_1.content)

				arg_729_1.text_.text = var_732_2

				LuaForUtil.ClearLinePrefixSymbol(arg_729_1.text_)

				local var_732_4 = 42 <= 0 and var_732_0 or var_732_0 * (utf8.len(var_732_2) / 42)

				if (42 <= 0 and var_732_0 or var_732_0 * (utf8.len(var_732_2) / 42)) > 0 and var_732_0 < var_732_4 then
					arg_729_1.talkMaxDuration = var_732_4

					if var_732_4 + 0 > arg_729_1.duration_ then
						arg_729_1.duration_ = var_732_4 + 0
					end
				end

				arg_729_1.text_.text = var_732_2
				arg_729_1.typewritter.percent = 0

				arg_729_1.typewritter:SetDirty()
				arg_729_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305184", "story_v_side_new_1109305.awb") ~= 0 then
					local var_732_5 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305184", "story_v_side_new_1109305.awb") / 1000

					if var_732_5 + 0 > arg_729_1.duration_ then
						arg_729_1.duration_ = var_732_5 + 0
					end

					if var_732_1.prefab_name ~= "" and arg_729_1.actors_[var_732_1.prefab_name] ~= nil then
						local var_732_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_729_1.actors_[var_732_1.prefab_name].transform, "story_v_side_new_1109305", "1109305184", "story_v_side_new_1109305.awb")

						arg_729_1:RecordAudio("1109305184", var_732_6)
						arg_729_1:RecordAudio("1109305184", var_732_6)
					else
						arg_729_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305184", "story_v_side_new_1109305.awb")
					end

					arg_729_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305184", "story_v_side_new_1109305.awb")
				end

				arg_729_1:RecordContent(arg_729_1.text_.text)
			end

			local var_732_7 = math.max(var_732_0, arg_729_1.talkMaxDuration)

			if 0 <= arg_729_1.time_ and arg_729_1.time_ < 0 + var_732_7 then
				arg_729_1.typewritter.percent = (arg_729_1.time_ - 0) / var_732_7

				arg_729_1.typewritter:SetDirty()
			end

			if arg_729_1.time_ >= 0 + var_732_7 and arg_729_1.time_ < 0 + var_732_7 + arg_732_0 then
				arg_729_1.typewritter.percent = 1

				arg_729_1.typewritter:SetDirty()
				arg_729_1:ShowNextGo(true)
			end
		end

		arg_729_1.nodeConfigList_ = {}

		arg_729_1:InitPlayNodeList()
	end,
	Play1109305185 = function(arg_733_0, arg_733_1)
		arg_733_1.time_ = 0
		arg_733_1.frameCnt_ = 0
		arg_733_1.state_ = "playing"
		arg_733_1.curTalkId_ = 1109305185
		arg_733_1.duration_ = 11.63

		SetActive(arg_733_1.tipsGo_, false)

		function arg_733_1.onSingleLineFinish_()
			arg_733_1.onSingleLineUpdate_ = nil
			arg_733_1.onSingleLineFinish_ = nil
			arg_733_1.state_ = "waiting"
		end

		function arg_733_1.playNext_(arg_735_0)
			if arg_735_0 == 1 then
				arg_733_0:Play1109305186(arg_733_1)
			end
		end

		function arg_733_1.onSingleLineUpdate_(arg_736_0)
			if 0 < arg_733_1.time_ and arg_733_1.time_ <= 0 + arg_736_0 then
				arg_733_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action9_2")
			end

			if 0 < arg_733_1.time_ and arg_733_1.time_ <= 0 + arg_736_0 then
				arg_733_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_736_0 = 0
			local var_736_1 = 1.225

			if 0 < arg_733_1.time_ and arg_733_1.time_ <= var_736_0 + arg_736_0 then
				arg_733_1.talkMaxDuration = 0
				arg_733_1.dialogCg_.alpha = 1

				arg_733_1.dialog_:SetActive(true)
				SetActive(arg_733_1.leftNameGo_, true)

				arg_733_1.leftNameTxt_.text = arg_733_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_733_1.leftNameTxt_.transform)

				arg_733_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_733_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_733_1:RecordName(arg_733_1.leftNameTxt_.text)
				SetActive(arg_733_1.iconTrs_.gameObject, false)
				arg_733_1.callingController_:SetSelectedState("normal")

				local var_736_2 = arg_733_1:GetWordFromCfg(1109305185)
				local var_736_3 = arg_733_1:FormatText(var_736_2.content)

				arg_733_1.text_.text = var_736_3

				LuaForUtil.ClearLinePrefixSymbol(arg_733_1.text_)

				local var_736_5 = 49 <= 0 and var_736_1 or var_736_1 * (utf8.len(var_736_3) / 49)

				if (49 <= 0 and var_736_1 or var_736_1 * (utf8.len(var_736_3) / 49)) > 0 and var_736_1 < var_736_5 then
					arg_733_1.talkMaxDuration = var_736_5

					if var_736_5 + var_736_0 > arg_733_1.duration_ then
						arg_733_1.duration_ = var_736_5 + var_736_0
					end
				end

				arg_733_1.text_.text = var_736_3
				arg_733_1.typewritter.percent = 0

				arg_733_1.typewritter:SetDirty()
				arg_733_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305185", "story_v_side_new_1109305.awb") ~= 0 then
					local var_736_6 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305185", "story_v_side_new_1109305.awb") / 1000

					if var_736_6 + var_736_0 > arg_733_1.duration_ then
						arg_733_1.duration_ = var_736_6 + var_736_0
					end

					if var_736_2.prefab_name ~= "" and arg_733_1.actors_[var_736_2.prefab_name] ~= nil then
						local var_736_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_733_1.actors_[var_736_2.prefab_name].transform, "story_v_side_new_1109305", "1109305185", "story_v_side_new_1109305.awb")

						arg_733_1:RecordAudio("1109305185", var_736_7)
						arg_733_1:RecordAudio("1109305185", var_736_7)
					else
						arg_733_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305185", "story_v_side_new_1109305.awb")
					end

					arg_733_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305185", "story_v_side_new_1109305.awb")
				end

				arg_733_1:RecordContent(arg_733_1.text_.text)
			end

			local var_736_8 = math.max(var_736_1, arg_733_1.talkMaxDuration)

			if var_736_0 <= arg_733_1.time_ and arg_733_1.time_ < var_736_0 + var_736_8 then
				arg_733_1.typewritter.percent = (arg_733_1.time_ - var_736_0) / var_736_8

				arg_733_1.typewritter:SetDirty()
			end

			if arg_733_1.time_ >= var_736_0 + var_736_8 and arg_733_1.time_ < var_736_0 + var_736_8 + arg_736_0 then
				arg_733_1.typewritter.percent = 1

				arg_733_1.typewritter:SetDirty()
				arg_733_1:ShowNextGo(true)
			end
		end

		arg_733_1.nodeConfigList_ = {}

		arg_733_1:InitPlayNodeList()
	end,
	Play1109305186 = function(arg_737_0, arg_737_1)
		arg_737_1.time_ = 0
		arg_737_1.frameCnt_ = 0
		arg_737_1.state_ = "playing"
		arg_737_1.curTalkId_ = 1109305186
		arg_737_1.duration_ = 5

		SetActive(arg_737_1.tipsGo_, false)

		function arg_737_1.onSingleLineFinish_()
			arg_737_1.onSingleLineUpdate_ = nil
			arg_737_1.onSingleLineFinish_ = nil
			arg_737_1.state_ = "waiting"
		end

		function arg_737_1.playNext_(arg_739_0)
			if arg_739_0 == 1 then
				arg_737_0:Play1109305187(arg_737_1)
			end
		end

		function arg_737_1.onSingleLineUpdate_(arg_740_0)
			if 0 < arg_737_1.time_ and arg_737_1.time_ <= 0 + arg_740_0 and not isNil(arg_737_1.actors_["1093ui_story"]) and arg_737_1.var_.characterEffect1093ui_story == nil then
				arg_737_1.var_.characterEffect1093ui_story = arg_737_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_740_0 = 0.200000002980232

			if 0 <= arg_737_1.time_ and arg_737_1.time_ < 0 + var_740_0 and not isNil(arg_737_1.actors_["1093ui_story"]) then
				if arg_737_1.var_.characterEffect1093ui_story and not isNil(arg_737_1.actors_["1093ui_story"]) then
					arg_737_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_737_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_737_1.time_ - 0) / var_740_0)
				end
			end

			if arg_737_1.time_ >= 0 + var_740_0 and arg_737_1.time_ < 0 + var_740_0 + arg_740_0 and not isNil(arg_737_1.actors_["1093ui_story"]) and arg_737_1.var_.characterEffect1093ui_story then
				arg_737_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_737_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_740_1 = 0
			local var_740_2 = 0.225

			if 0 < arg_737_1.time_ and arg_737_1.time_ <= var_740_1 + arg_740_0 then
				arg_737_1.talkMaxDuration = 0
				arg_737_1.dialogCg_.alpha = 1

				arg_737_1.dialog_:SetActive(true)
				SetActive(arg_737_1.leftNameGo_, true)

				arg_737_1.leftNameTxt_.text = arg_737_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_737_1.leftNameTxt_.transform)

				arg_737_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_737_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_737_1:RecordName(arg_737_1.leftNameTxt_.text)
				SetActive(arg_737_1.iconTrs_.gameObject, true)
				arg_737_1.iconController_:SetSelectedState("hero")

				arg_737_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_737_1.callingController_:SetSelectedState("normal")

				arg_737_1.keyicon_.color = Color.New(1, 1, 1)
				arg_737_1.icon_.color = Color.New(1, 1, 1)

				local var_740_3 = arg_737_1:FormatText(arg_737_1:GetWordFromCfg(1109305186).content)

				arg_737_1.text_.text = var_740_3

				LuaForUtil.ClearLinePrefixSymbol(arg_737_1.text_)

				local var_740_5 = 9 <= 0 and var_740_2 or var_740_2 * (utf8.len(var_740_3) / 9)

				if (9 <= 0 and var_740_2 or var_740_2 * (utf8.len(var_740_3) / 9)) > 0 and var_740_2 < var_740_5 then
					arg_737_1.talkMaxDuration = var_740_5

					if var_740_5 + var_740_1 > arg_737_1.duration_ then
						arg_737_1.duration_ = var_740_5 + var_740_1
					end
				end

				arg_737_1.text_.text = var_740_3
				arg_737_1.typewritter.percent = 0

				arg_737_1.typewritter:SetDirty()
				arg_737_1:ShowNextGo(false)
				arg_737_1:RecordContent(arg_737_1.text_.text)
			end

			local var_740_6 = math.max(var_740_2, arg_737_1.talkMaxDuration)

			if var_740_1 <= arg_737_1.time_ and arg_737_1.time_ < var_740_1 + var_740_6 then
				arg_737_1.typewritter.percent = (arg_737_1.time_ - var_740_1) / var_740_6

				arg_737_1.typewritter:SetDirty()
			end

			if arg_737_1.time_ >= var_740_1 + var_740_6 and arg_737_1.time_ < var_740_1 + var_740_6 + arg_740_0 then
				arg_737_1.typewritter.percent = 1

				arg_737_1.typewritter:SetDirty()
				arg_737_1:ShowNextGo(true)
			end
		end

		arg_737_1.nodeConfigList_ = {}

		arg_737_1:InitPlayNodeList()
	end,
	Play1109305187 = function(arg_741_0, arg_741_1)
		arg_741_1.time_ = 0
		arg_741_1.frameCnt_ = 0
		arg_741_1.state_ = "playing"
		arg_741_1.curTalkId_ = 1109305187
		arg_741_1.duration_ = 2.73

		SetActive(arg_741_1.tipsGo_, false)

		function arg_741_1.onSingleLineFinish_()
			arg_741_1.onSingleLineUpdate_ = nil
			arg_741_1.onSingleLineFinish_ = nil
			arg_741_1.state_ = "waiting"
		end

		function arg_741_1.playNext_(arg_743_0)
			if arg_743_0 == 1 then
				arg_741_0:Play1109305188(arg_741_1)
			end
		end

		function arg_741_1.onSingleLineUpdate_(arg_744_0)
			if 0 < arg_741_1.time_ and arg_741_1.time_ <= 0 + arg_744_0 and not isNil(arg_741_1.actors_["1093ui_story"]) and arg_741_1.var_.characterEffect1093ui_story == nil then
				arg_741_1.var_.characterEffect1093ui_story = arg_741_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_744_0 = 0.200000002980232

			if 0 <= arg_741_1.time_ and arg_741_1.time_ < 0 + var_744_0 and not isNil(arg_741_1.actors_["1093ui_story"]) then
				if arg_741_1.var_.characterEffect1093ui_story and not isNil(arg_741_1.actors_["1093ui_story"]) then
					arg_741_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_741_1.time_ >= 0 + var_744_0 and arg_741_1.time_ < 0 + var_744_0 + arg_744_0 and not isNil(arg_741_1.actors_["1093ui_story"]) and arg_741_1.var_.characterEffect1093ui_story then
				arg_741_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_744_2 = 0
			local var_744_3 = 0.3

			if 0 < arg_741_1.time_ and arg_741_1.time_ <= var_744_2 + arg_744_0 then
				arg_741_1.talkMaxDuration = 0
				arg_741_1.dialogCg_.alpha = 1

				arg_741_1.dialog_:SetActive(true)
				SetActive(arg_741_1.leftNameGo_, true)

				arg_741_1.leftNameTxt_.text = arg_741_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_741_1.leftNameTxt_.transform)

				arg_741_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_741_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_741_1:RecordName(arg_741_1.leftNameTxt_.text)
				SetActive(arg_741_1.iconTrs_.gameObject, false)
				arg_741_1.callingController_:SetSelectedState("normal")

				local var_744_4 = arg_741_1:GetWordFromCfg(1109305187)
				local var_744_5 = arg_741_1:FormatText(var_744_4.content)

				arg_741_1.text_.text = var_744_5

				LuaForUtil.ClearLinePrefixSymbol(arg_741_1.text_)

				local var_744_7 = 12 <= 0 and var_744_3 or var_744_3 * (utf8.len(var_744_5) / 12)

				if (12 <= 0 and var_744_3 or var_744_3 * (utf8.len(var_744_5) / 12)) > 0 and var_744_3 < var_744_7 then
					arg_741_1.talkMaxDuration = var_744_7

					if var_744_7 + var_744_2 > arg_741_1.duration_ then
						arg_741_1.duration_ = var_744_7 + var_744_2
					end
				end

				arg_741_1.text_.text = var_744_5
				arg_741_1.typewritter.percent = 0

				arg_741_1.typewritter:SetDirty()
				arg_741_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305187", "story_v_side_new_1109305.awb") ~= 0 then
					local var_744_8 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305187", "story_v_side_new_1109305.awb") / 1000

					if var_744_8 + var_744_2 > arg_741_1.duration_ then
						arg_741_1.duration_ = var_744_8 + var_744_2
					end

					if var_744_4.prefab_name ~= "" and arg_741_1.actors_[var_744_4.prefab_name] ~= nil then
						local var_744_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_741_1.actors_[var_744_4.prefab_name].transform, "story_v_side_new_1109305", "1109305187", "story_v_side_new_1109305.awb")

						arg_741_1:RecordAudio("1109305187", var_744_9)
						arg_741_1:RecordAudio("1109305187", var_744_9)
					else
						arg_741_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305187", "story_v_side_new_1109305.awb")
					end

					arg_741_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305187", "story_v_side_new_1109305.awb")
				end

				arg_741_1:RecordContent(arg_741_1.text_.text)
			end

			local var_744_10 = math.max(var_744_3, arg_741_1.talkMaxDuration)

			if var_744_2 <= arg_741_1.time_ and arg_741_1.time_ < var_744_2 + var_744_10 then
				arg_741_1.typewritter.percent = (arg_741_1.time_ - var_744_2) / var_744_10

				arg_741_1.typewritter:SetDirty()
			end

			if arg_741_1.time_ >= var_744_2 + var_744_10 and arg_741_1.time_ < var_744_2 + var_744_10 + arg_744_0 then
				arg_741_1.typewritter.percent = 1

				arg_741_1.typewritter:SetDirty()
				arg_741_1:ShowNextGo(true)
			end
		end

		arg_741_1.nodeConfigList_ = {}

		arg_741_1:InitPlayNodeList()
	end,
	Play1109305188 = function(arg_745_0, arg_745_1)
		arg_745_1.time_ = 0
		arg_745_1.frameCnt_ = 0
		arg_745_1.state_ = "playing"
		arg_745_1.curTalkId_ = 1109305188
		arg_745_1.duration_ = 4.43

		SetActive(arg_745_1.tipsGo_, false)

		function arg_745_1.onSingleLineFinish_()
			arg_745_1.onSingleLineUpdate_ = nil
			arg_745_1.onSingleLineFinish_ = nil
			arg_745_1.state_ = "waiting"
		end

		function arg_745_1.playNext_(arg_747_0)
			if arg_747_0 == 1 then
				arg_745_0:Play1109305189(arg_745_1)
			end
		end

		function arg_745_1.onSingleLineUpdate_(arg_748_0)
			if 0 < arg_745_1.time_ and arg_745_1.time_ <= 0 + arg_748_0 then
				arg_745_1.var_.moveOldPos1093ui_story = arg_745_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_748_0 = 0.001

			if 0 <= arg_745_1.time_ and arg_745_1.time_ < 0 + var_748_0 then
				arg_745_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_745_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_745_1.time_ - 0) / var_748_0)
				arg_745_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_745_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_745_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_745_1.actors_["1093ui_story"].transform.position).z)
				arg_745_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_745_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_745_1.actors_["1093ui_story"].transform.localEulerAngles = arg_745_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_745_1.time_ >= 0 + var_748_0 and arg_745_1.time_ < 0 + var_748_0 + arg_748_0 then
				arg_745_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_745_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_745_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_745_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_745_1.actors_["1093ui_story"].transform.position).z)
				arg_745_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_745_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_745_1.actors_["1093ui_story"].transform.localEulerAngles = arg_745_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if 0 < arg_745_1.time_ and arg_745_1.time_ <= 0 + arg_748_0 then
				arg_745_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action8_1")
			end

			if 0 < arg_745_1.time_ and arg_745_1.time_ <= 0 + arg_748_0 then
				arg_745_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_748_1 = 0
			local var_748_2 = 0.475

			if 0 < arg_745_1.time_ and arg_745_1.time_ <= var_748_1 + arg_748_0 then
				arg_745_1.talkMaxDuration = 0
				arg_745_1.dialogCg_.alpha = 1

				arg_745_1.dialog_:SetActive(true)
				SetActive(arg_745_1.leftNameGo_, true)

				arg_745_1.leftNameTxt_.text = arg_745_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_745_1.leftNameTxt_.transform)

				arg_745_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_745_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_745_1:RecordName(arg_745_1.leftNameTxt_.text)
				SetActive(arg_745_1.iconTrs_.gameObject, false)
				arg_745_1.callingController_:SetSelectedState("normal")

				local var_748_3 = arg_745_1:GetWordFromCfg(1109305188)
				local var_748_4 = arg_745_1:FormatText(var_748_3.content)

				arg_745_1.text_.text = var_748_4

				LuaForUtil.ClearLinePrefixSymbol(arg_745_1.text_)

				local var_748_6 = 19 <= 0 and var_748_2 or var_748_2 * (utf8.len(var_748_4) / 19)

				if (19 <= 0 and var_748_2 or var_748_2 * (utf8.len(var_748_4) / 19)) > 0 and var_748_2 < var_748_6 then
					arg_745_1.talkMaxDuration = var_748_6

					if var_748_6 + var_748_1 > arg_745_1.duration_ then
						arg_745_1.duration_ = var_748_6 + var_748_1
					end
				end

				arg_745_1.text_.text = var_748_4
				arg_745_1.typewritter.percent = 0

				arg_745_1.typewritter:SetDirty()
				arg_745_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305188", "story_v_side_new_1109305.awb") ~= 0 then
					local var_748_7 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305188", "story_v_side_new_1109305.awb") / 1000

					if var_748_7 + var_748_1 > arg_745_1.duration_ then
						arg_745_1.duration_ = var_748_7 + var_748_1
					end

					if var_748_3.prefab_name ~= "" and arg_745_1.actors_[var_748_3.prefab_name] ~= nil then
						local var_748_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_745_1.actors_[var_748_3.prefab_name].transform, "story_v_side_new_1109305", "1109305188", "story_v_side_new_1109305.awb")

						arg_745_1:RecordAudio("1109305188", var_748_8)
						arg_745_1:RecordAudio("1109305188", var_748_8)
					else
						arg_745_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305188", "story_v_side_new_1109305.awb")
					end

					arg_745_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305188", "story_v_side_new_1109305.awb")
				end

				arg_745_1:RecordContent(arg_745_1.text_.text)
			end

			local var_748_9 = math.max(var_748_2, arg_745_1.talkMaxDuration)

			if var_748_1 <= arg_745_1.time_ and arg_745_1.time_ < var_748_1 + var_748_9 then
				arg_745_1.typewritter.percent = (arg_745_1.time_ - var_748_1) / var_748_9

				arg_745_1.typewritter:SetDirty()
			end

			if arg_745_1.time_ >= var_748_1 + var_748_9 and arg_745_1.time_ < var_748_1 + var_748_9 + arg_748_0 then
				arg_745_1.typewritter.percent = 1

				arg_745_1.typewritter:SetDirty()
				arg_745_1:ShowNextGo(true)
			end
		end

		arg_745_1.nodeConfigList_ = {
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

		arg_745_1:InitPlayNodeList()
	end,
	Play1109305189 = function(arg_749_0, arg_749_1)
		arg_749_1.time_ = 0
		arg_749_1.frameCnt_ = 0
		arg_749_1.state_ = "playing"
		arg_749_1.curTalkId_ = 1109305189
		arg_749_1.duration_ = 5

		SetActive(arg_749_1.tipsGo_, false)

		function arg_749_1.onSingleLineFinish_()
			arg_749_1.onSingleLineUpdate_ = nil
			arg_749_1.onSingleLineFinish_ = nil
			arg_749_1.state_ = "waiting"
		end

		function arg_749_1.playNext_(arg_751_0)
			if arg_751_0 == 1 then
				arg_749_0:Play1109305190(arg_749_1)
			end
		end

		function arg_749_1.onSingleLineUpdate_(arg_752_0)
			if 0 < arg_749_1.time_ and arg_749_1.time_ <= 0 + arg_752_0 then
				arg_749_1.var_.moveOldPos1093ui_story = arg_749_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_752_0 = 0.001

			if 0 <= arg_749_1.time_ and arg_749_1.time_ < 0 + var_752_0 then
				arg_749_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_749_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_749_1.time_ - 0) / var_752_0)
				arg_749_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_749_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_749_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_749_1.actors_["1093ui_story"].transform.position).z)
				arg_749_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_749_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_749_1.actors_["1093ui_story"].transform.localEulerAngles = arg_749_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_749_1.time_ >= 0 + var_752_0 and arg_749_1.time_ < 0 + var_752_0 + arg_752_0 then
				arg_749_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_749_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_749_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_749_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_749_1.actors_["1093ui_story"].transform.position).z)
				arg_749_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_749_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_749_1.actors_["1093ui_story"].transform.localEulerAngles = arg_749_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_752_1 = arg_749_1.actors_["1093ui_story"]

			if 0 < arg_749_1.time_ and arg_749_1.time_ <= 0 + arg_752_0 and not isNil(var_752_1) and arg_749_1.var_.characterEffect1093ui_story == nil then
				arg_749_1.var_.characterEffect1093ui_story = var_752_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_752_2 = 0.200000002980232

			if 0 <= arg_749_1.time_ and arg_749_1.time_ < 0 + var_752_2 and not isNil(var_752_1) then
				if arg_749_1.var_.characterEffect1093ui_story and not isNil(var_752_1) then
					arg_749_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_749_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_749_1.time_ - 0) / var_752_2)
				end
			end

			if arg_749_1.time_ >= 0 + var_752_2 and arg_749_1.time_ < 0 + var_752_2 + arg_752_0 and not isNil(var_752_1) and arg_749_1.var_.characterEffect1093ui_story then
				arg_749_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_749_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_752_3 = 0
			local var_752_4 = 0.825

			if 0 < arg_749_1.time_ and arg_749_1.time_ <= var_752_3 + arg_752_0 then
				arg_749_1.talkMaxDuration = 0
				arg_749_1.dialogCg_.alpha = 1

				arg_749_1.dialog_:SetActive(true)
				SetActive(arg_749_1.leftNameGo_, false)

				arg_749_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_749_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_749_1:RecordName(arg_749_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_749_1.iconTrs_.gameObject, false)
				arg_749_1.callingController_:SetSelectedState("normal")

				local var_752_5 = arg_749_1:FormatText(arg_749_1:GetWordFromCfg(1109305189).content)

				arg_749_1.text_.text = var_752_5

				LuaForUtil.ClearLinePrefixSymbol(arg_749_1.text_)

				local var_752_7 = 33 <= 0 and var_752_4 or var_752_4 * (utf8.len(var_752_5) / 33)

				if (33 <= 0 and var_752_4 or var_752_4 * (utf8.len(var_752_5) / 33)) > 0 and var_752_4 < var_752_7 then
					arg_749_1.talkMaxDuration = var_752_7

					if var_752_7 + var_752_3 > arg_749_1.duration_ then
						arg_749_1.duration_ = var_752_7 + var_752_3
					end
				end

				arg_749_1.text_.text = var_752_5
				arg_749_1.typewritter.percent = 0

				arg_749_1.typewritter:SetDirty()
				arg_749_1:ShowNextGo(false)
				arg_749_1:RecordContent(arg_749_1.text_.text)
			end

			local var_752_8 = math.max(var_752_4, arg_749_1.talkMaxDuration)

			if var_752_3 <= arg_749_1.time_ and arg_749_1.time_ < var_752_3 + var_752_8 then
				arg_749_1.typewritter.percent = (arg_749_1.time_ - var_752_3) / var_752_8

				arg_749_1.typewritter:SetDirty()
			end

			if arg_749_1.time_ >= var_752_3 + var_752_8 and arg_749_1.time_ < var_752_3 + var_752_8 + arg_752_0 then
				arg_749_1.typewritter.percent = 1

				arg_749_1.typewritter:SetDirty()
				arg_749_1:ShowNextGo(true)
			end
		end

		arg_749_1.nodeConfigList_ = {
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

		arg_749_1:InitPlayNodeList()
	end,
	Play1109305190 = function(arg_753_0, arg_753_1)
		arg_753_1.time_ = 0
		arg_753_1.frameCnt_ = 0
		arg_753_1.state_ = "playing"
		arg_753_1.curTalkId_ = 1109305190
		arg_753_1.duration_ = 5

		SetActive(arg_753_1.tipsGo_, false)

		function arg_753_1.onSingleLineFinish_()
			arg_753_1.onSingleLineUpdate_ = nil
			arg_753_1.onSingleLineFinish_ = nil
			arg_753_1.state_ = "waiting"
		end

		function arg_753_1.playNext_(arg_755_0)
			if arg_755_0 == 1 then
				arg_753_0:Play1109305191(arg_753_1)
			end
		end

		function arg_753_1.onSingleLineUpdate_(arg_756_0)
			local var_756_0 = 0.75

			if 0 < arg_753_1.time_ and arg_753_1.time_ <= 0 + arg_756_0 then
				arg_753_1.talkMaxDuration = 0
				arg_753_1.dialogCg_.alpha = 1

				arg_753_1.dialog_:SetActive(true)
				SetActive(arg_753_1.leftNameGo_, false)

				arg_753_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_753_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_753_1:RecordName(arg_753_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_753_1.iconTrs_.gameObject, false)
				arg_753_1.callingController_:SetSelectedState("normal")

				local var_756_1 = arg_753_1:FormatText(arg_753_1:GetWordFromCfg(1109305190).content)

				arg_753_1.text_.text = var_756_1

				LuaForUtil.ClearLinePrefixSymbol(arg_753_1.text_)

				local var_756_3 = 30 <= 0 and var_756_0 or var_756_0 * (utf8.len(var_756_1) / 30)

				if (30 <= 0 and var_756_0 or var_756_0 * (utf8.len(var_756_1) / 30)) > 0 and var_756_0 < var_756_3 then
					arg_753_1.talkMaxDuration = var_756_3

					if var_756_3 + 0 > arg_753_1.duration_ then
						arg_753_1.duration_ = var_756_3 + 0
					end
				end

				arg_753_1.text_.text = var_756_1
				arg_753_1.typewritter.percent = 0

				arg_753_1.typewritter:SetDirty()
				arg_753_1:ShowNextGo(false)
				arg_753_1:RecordContent(arg_753_1.text_.text)
			end

			local var_756_4 = math.max(var_756_0, arg_753_1.talkMaxDuration)

			if 0 <= arg_753_1.time_ and arg_753_1.time_ < 0 + var_756_4 then
				arg_753_1.typewritter.percent = (arg_753_1.time_ - 0) / var_756_4

				arg_753_1.typewritter:SetDirty()
			end

			if arg_753_1.time_ >= 0 + var_756_4 and arg_753_1.time_ < 0 + var_756_4 + arg_756_0 then
				arg_753_1.typewritter.percent = 1

				arg_753_1.typewritter:SetDirty()
				arg_753_1:ShowNextGo(true)
			end
		end

		arg_753_1.nodeConfigList_ = {}

		arg_753_1:InitPlayNodeList()
	end,
	Play1109305191 = function(arg_757_0, arg_757_1)
		arg_757_1.time_ = 0
		arg_757_1.frameCnt_ = 0
		arg_757_1.state_ = "playing"
		arg_757_1.curTalkId_ = 1109305191
		arg_757_1.duration_ = 5

		SetActive(arg_757_1.tipsGo_, false)

		function arg_757_1.onSingleLineFinish_()
			arg_757_1.onSingleLineUpdate_ = nil
			arg_757_1.onSingleLineFinish_ = nil
			arg_757_1.state_ = "waiting"
		end

		function arg_757_1.playNext_(arg_759_0)
			if arg_759_0 == 1 then
				arg_757_0:Play1109305192(arg_757_1)
			end
		end

		function arg_757_1.onSingleLineUpdate_(arg_760_0)
			local var_760_0 = 0.775

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

				local var_760_1 = arg_757_1:FormatText(arg_757_1:GetWordFromCfg(1109305191).content)

				arg_757_1.text_.text = var_760_1

				LuaForUtil.ClearLinePrefixSymbol(arg_757_1.text_)

				local var_760_3 = 31 <= 0 and var_760_0 or var_760_0 * (utf8.len(var_760_1) / 31)

				if (31 <= 0 and var_760_0 or var_760_0 * (utf8.len(var_760_1) / 31)) > 0 and var_760_0 < var_760_3 then
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
	Play1109305192 = function(arg_761_0, arg_761_1)
		arg_761_1.time_ = 0
		arg_761_1.frameCnt_ = 0
		arg_761_1.state_ = "playing"
		arg_761_1.curTalkId_ = 1109305192
		arg_761_1.duration_ = 2

		SetActive(arg_761_1.tipsGo_, false)

		function arg_761_1.onSingleLineFinish_()
			arg_761_1.onSingleLineUpdate_ = nil
			arg_761_1.onSingleLineFinish_ = nil
			arg_761_1.state_ = "waiting"
		end

		function arg_761_1.playNext_(arg_763_0)
			if arg_763_0 == 1 then
				arg_761_0:Play1109305193(arg_761_1)
			end
		end

		function arg_761_1.onSingleLineUpdate_(arg_764_0)
			if 0 < arg_761_1.time_ and arg_761_1.time_ <= 0 + arg_764_0 then
				arg_761_1.var_.moveOldPos1093ui_story = arg_761_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_764_0 = 0.001

			if 0 <= arg_761_1.time_ and arg_761_1.time_ < 0 + var_764_0 then
				arg_761_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_761_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_761_1.time_ - 0) / var_764_0)
				arg_761_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_761_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_761_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_761_1.actors_["1093ui_story"].transform.position).z)
				arg_761_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_761_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_761_1.actors_["1093ui_story"].transform.localEulerAngles = arg_761_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_761_1.time_ >= 0 + var_764_0 and arg_761_1.time_ < 0 + var_764_0 + arg_764_0 then
				arg_761_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_761_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_761_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_761_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_761_1.actors_["1093ui_story"].transform.position).z)
				arg_761_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_761_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_761_1.actors_["1093ui_story"].transform.localEulerAngles = arg_761_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_764_1 = arg_761_1.actors_["1093ui_story"]

			if 0 < arg_761_1.time_ and arg_761_1.time_ <= 0 + arg_764_0 and not isNil(var_764_1) and arg_761_1.var_.characterEffect1093ui_story == nil then
				arg_761_1.var_.characterEffect1093ui_story = var_764_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_764_2 = 0.200000002980232

			if 0 <= arg_761_1.time_ and arg_761_1.time_ < 0 + var_764_2 and not isNil(var_764_1) then
				if arg_761_1.var_.characterEffect1093ui_story and not isNil(var_764_1) then
					arg_761_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_761_1.time_ >= 0 + var_764_2 and arg_761_1.time_ < 0 + var_764_2 + arg_764_0 and not isNil(var_764_1) and arg_761_1.var_.characterEffect1093ui_story then
				arg_761_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_761_1.time_ and arg_761_1.time_ <= 0 + arg_764_0 then
				arg_761_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action8_2")
			end

			if 0 < arg_761_1.time_ and arg_761_1.time_ <= 0 + arg_764_0 then
				arg_761_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_764_4 = 0
			local var_764_5 = 0.175

			if 0 < arg_761_1.time_ and arg_761_1.time_ <= var_764_4 + arg_764_0 then
				arg_761_1.talkMaxDuration = 0
				arg_761_1.dialogCg_.alpha = 1

				arg_761_1.dialog_:SetActive(true)
				SetActive(arg_761_1.leftNameGo_, true)

				arg_761_1.leftNameTxt_.text = arg_761_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_761_1.leftNameTxt_.transform)

				arg_761_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_761_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_761_1:RecordName(arg_761_1.leftNameTxt_.text)
				SetActive(arg_761_1.iconTrs_.gameObject, false)
				arg_761_1.callingController_:SetSelectedState("normal")

				local var_764_6 = arg_761_1:GetWordFromCfg(1109305192)
				local var_764_7 = arg_761_1:FormatText(var_764_6.content)

				arg_761_1.text_.text = var_764_7

				LuaForUtil.ClearLinePrefixSymbol(arg_761_1.text_)

				local var_764_9 = 7 <= 0 and var_764_5 or var_764_5 * (utf8.len(var_764_7) / 7)

				if (7 <= 0 and var_764_5 or var_764_5 * (utf8.len(var_764_7) / 7)) > 0 and var_764_5 < var_764_9 then
					arg_761_1.talkMaxDuration = var_764_9

					if var_764_9 + var_764_4 > arg_761_1.duration_ then
						arg_761_1.duration_ = var_764_9 + var_764_4
					end
				end

				arg_761_1.text_.text = var_764_7
				arg_761_1.typewritter.percent = 0

				arg_761_1.typewritter:SetDirty()
				arg_761_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305192", "story_v_side_new_1109305.awb") ~= 0 then
					local var_764_10 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305192", "story_v_side_new_1109305.awb") / 1000

					if var_764_10 + var_764_4 > arg_761_1.duration_ then
						arg_761_1.duration_ = var_764_10 + var_764_4
					end

					if var_764_6.prefab_name ~= "" and arg_761_1.actors_[var_764_6.prefab_name] ~= nil then
						local var_764_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_761_1.actors_[var_764_6.prefab_name].transform, "story_v_side_new_1109305", "1109305192", "story_v_side_new_1109305.awb")

						arg_761_1:RecordAudio("1109305192", var_764_11)
						arg_761_1:RecordAudio("1109305192", var_764_11)
					else
						arg_761_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305192", "story_v_side_new_1109305.awb")
					end

					arg_761_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305192", "story_v_side_new_1109305.awb")
				end

				arg_761_1:RecordContent(arg_761_1.text_.text)
			end

			local var_764_12 = math.max(var_764_5, arg_761_1.talkMaxDuration)

			if var_764_4 <= arg_761_1.time_ and arg_761_1.time_ < var_764_4 + var_764_12 then
				arg_761_1.typewritter.percent = (arg_761_1.time_ - var_764_4) / var_764_12

				arg_761_1.typewritter:SetDirty()
			end

			if arg_761_1.time_ >= var_764_4 + var_764_12 and arg_761_1.time_ < var_764_4 + var_764_12 + arg_764_0 then
				arg_761_1.typewritter.percent = 1

				arg_761_1.typewritter:SetDirty()
				arg_761_1:ShowNextGo(true)
			end
		end

		arg_761_1.nodeConfigList_ = {
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

		arg_761_1:InitPlayNodeList()
	end,
	Play1109305193 = function(arg_765_0, arg_765_1)
		arg_765_1.time_ = 0
		arg_765_1.frameCnt_ = 0
		arg_765_1.state_ = "playing"
		arg_765_1.curTalkId_ = 1109305193
		arg_765_1.duration_ = 5

		SetActive(arg_765_1.tipsGo_, false)

		function arg_765_1.onSingleLineFinish_()
			arg_765_1.onSingleLineUpdate_ = nil
			arg_765_1.onSingleLineFinish_ = nil
			arg_765_1.state_ = "waiting"
		end

		function arg_765_1.playNext_(arg_767_0)
			if arg_767_0 == 1 then
				arg_765_0:Play1109305194(arg_765_1)
			end
		end

		function arg_765_1.onSingleLineUpdate_(arg_768_0)
			if 0 < arg_765_1.time_ and arg_765_1.time_ <= 0 + arg_768_0 and not isNil(arg_765_1.actors_["1093ui_story"]) and arg_765_1.var_.characterEffect1093ui_story == nil then
				arg_765_1.var_.characterEffect1093ui_story = arg_765_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_768_0 = 0.200000002980232

			if 0 <= arg_765_1.time_ and arg_765_1.time_ < 0 + var_768_0 and not isNil(arg_765_1.actors_["1093ui_story"]) then
				if arg_765_1.var_.characterEffect1093ui_story and not isNil(arg_765_1.actors_["1093ui_story"]) then
					arg_765_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_765_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_765_1.time_ - 0) / var_768_0)
				end
			end

			if arg_765_1.time_ >= 0 + var_768_0 and arg_765_1.time_ < 0 + var_768_0 + arg_768_0 and not isNil(arg_765_1.actors_["1093ui_story"]) and arg_765_1.var_.characterEffect1093ui_story then
				arg_765_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_765_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_768_1 = 0
			local var_768_2 = 0.775

			if 0 < arg_765_1.time_ and arg_765_1.time_ <= var_768_1 + arg_768_0 then
				arg_765_1.talkMaxDuration = 0
				arg_765_1.dialogCg_.alpha = 1

				arg_765_1.dialog_:SetActive(true)
				SetActive(arg_765_1.leftNameGo_, true)

				arg_765_1.leftNameTxt_.text = arg_765_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_765_1.leftNameTxt_.transform)

				arg_765_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_765_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_765_1:RecordName(arg_765_1.leftNameTxt_.text)
				SetActive(arg_765_1.iconTrs_.gameObject, true)
				arg_765_1.iconController_:SetSelectedState("hero")

				arg_765_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_765_1.callingController_:SetSelectedState("normal")

				arg_765_1.keyicon_.color = Color.New(1, 1, 1)
				arg_765_1.icon_.color = Color.New(1, 1, 1)

				local var_768_3 = arg_765_1:FormatText(arg_765_1:GetWordFromCfg(1109305193).content)

				arg_765_1.text_.text = var_768_3

				LuaForUtil.ClearLinePrefixSymbol(arg_765_1.text_)

				local var_768_5 = 31 <= 0 and var_768_2 or var_768_2 * (utf8.len(var_768_3) / 31)

				if (31 <= 0 and var_768_2 or var_768_2 * (utf8.len(var_768_3) / 31)) > 0 and var_768_2 < var_768_5 then
					arg_765_1.talkMaxDuration = var_768_5

					if var_768_5 + var_768_1 > arg_765_1.duration_ then
						arg_765_1.duration_ = var_768_5 + var_768_1
					end
				end

				arg_765_1.text_.text = var_768_3
				arg_765_1.typewritter.percent = 0

				arg_765_1.typewritter:SetDirty()
				arg_765_1:ShowNextGo(false)
				arg_765_1:RecordContent(arg_765_1.text_.text)
			end

			local var_768_6 = math.max(var_768_2, arg_765_1.talkMaxDuration)

			if var_768_1 <= arg_765_1.time_ and arg_765_1.time_ < var_768_1 + var_768_6 then
				arg_765_1.typewritter.percent = (arg_765_1.time_ - var_768_1) / var_768_6

				arg_765_1.typewritter:SetDirty()
			end

			if arg_765_1.time_ >= var_768_1 + var_768_6 and arg_765_1.time_ < var_768_1 + var_768_6 + arg_768_0 then
				arg_765_1.typewritter.percent = 1

				arg_765_1.typewritter:SetDirty()
				arg_765_1:ShowNextGo(true)
			end
		end

		arg_765_1.nodeConfigList_ = {}

		arg_765_1:InitPlayNodeList()
	end,
	Play1109305194 = function(arg_769_0, arg_769_1)
		arg_769_1.time_ = 0
		arg_769_1.frameCnt_ = 0
		arg_769_1.state_ = "playing"
		arg_769_1.curTalkId_ = 1109305194
		arg_769_1.duration_ = 8.13

		SetActive(arg_769_1.tipsGo_, false)

		function arg_769_1.onSingleLineFinish_()
			arg_769_1.onSingleLineUpdate_ = nil
			arg_769_1.onSingleLineFinish_ = nil
			arg_769_1.state_ = "waiting"
		end

		function arg_769_1.playNext_(arg_771_0)
			if arg_771_0 == 1 then
				arg_769_0:Play1109305195(arg_769_1)
			end
		end

		function arg_769_1.onSingleLineUpdate_(arg_772_0)
			if 0 < arg_769_1.time_ and arg_769_1.time_ <= 0 + arg_772_0 and not isNil(arg_769_1.actors_["1093ui_story"]) and arg_769_1.var_.characterEffect1093ui_story == nil then
				arg_769_1.var_.characterEffect1093ui_story = arg_769_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_772_0 = 0.200000002980232

			if 0 <= arg_769_1.time_ and arg_769_1.time_ < 0 + var_772_0 and not isNil(arg_769_1.actors_["1093ui_story"]) then
				if arg_769_1.var_.characterEffect1093ui_story and not isNil(arg_769_1.actors_["1093ui_story"]) then
					arg_769_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_769_1.time_ >= 0 + var_772_0 and arg_769_1.time_ < 0 + var_772_0 + arg_772_0 and not isNil(arg_769_1.actors_["1093ui_story"]) and arg_769_1.var_.characterEffect1093ui_story then
				arg_769_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_772_2 = 0
			local var_772_3 = 0.925

			if 0 < arg_769_1.time_ and arg_769_1.time_ <= var_772_2 + arg_772_0 then
				arg_769_1.talkMaxDuration = 0
				arg_769_1.dialogCg_.alpha = 1

				arg_769_1.dialog_:SetActive(true)
				SetActive(arg_769_1.leftNameGo_, true)

				arg_769_1.leftNameTxt_.text = arg_769_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_769_1.leftNameTxt_.transform)

				arg_769_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_769_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_769_1:RecordName(arg_769_1.leftNameTxt_.text)
				SetActive(arg_769_1.iconTrs_.gameObject, false)
				arg_769_1.callingController_:SetSelectedState("normal")

				local var_772_4 = arg_769_1:GetWordFromCfg(1109305194)
				local var_772_5 = arg_769_1:FormatText(var_772_4.content)

				arg_769_1.text_.text = var_772_5

				LuaForUtil.ClearLinePrefixSymbol(arg_769_1.text_)

				local var_772_7 = 37 <= 0 and var_772_3 or var_772_3 * (utf8.len(var_772_5) / 37)

				if (37 <= 0 and var_772_3 or var_772_3 * (utf8.len(var_772_5) / 37)) > 0 and var_772_3 < var_772_7 then
					arg_769_1.talkMaxDuration = var_772_7

					if var_772_7 + var_772_2 > arg_769_1.duration_ then
						arg_769_1.duration_ = var_772_7 + var_772_2
					end
				end

				arg_769_1.text_.text = var_772_5
				arg_769_1.typewritter.percent = 0

				arg_769_1.typewritter:SetDirty()
				arg_769_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305194", "story_v_side_new_1109305.awb") ~= 0 then
					local var_772_8 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305194", "story_v_side_new_1109305.awb") / 1000

					if var_772_8 + var_772_2 > arg_769_1.duration_ then
						arg_769_1.duration_ = var_772_8 + var_772_2
					end

					if var_772_4.prefab_name ~= "" and arg_769_1.actors_[var_772_4.prefab_name] ~= nil then
						local var_772_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_769_1.actors_[var_772_4.prefab_name].transform, "story_v_side_new_1109305", "1109305194", "story_v_side_new_1109305.awb")

						arg_769_1:RecordAudio("1109305194", var_772_9)
						arg_769_1:RecordAudio("1109305194", var_772_9)
					else
						arg_769_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305194", "story_v_side_new_1109305.awb")
					end

					arg_769_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305194", "story_v_side_new_1109305.awb")
				end

				arg_769_1:RecordContent(arg_769_1.text_.text)
			end

			local var_772_10 = math.max(var_772_3, arg_769_1.talkMaxDuration)

			if var_772_2 <= arg_769_1.time_ and arg_769_1.time_ < var_772_2 + var_772_10 then
				arg_769_1.typewritter.percent = (arg_769_1.time_ - var_772_2) / var_772_10

				arg_769_1.typewritter:SetDirty()
			end

			if arg_769_1.time_ >= var_772_2 + var_772_10 and arg_769_1.time_ < var_772_2 + var_772_10 + arg_772_0 then
				arg_769_1.typewritter.percent = 1

				arg_769_1.typewritter:SetDirty()
				arg_769_1:ShowNextGo(true)
			end
		end

		arg_769_1.nodeConfigList_ = {}

		arg_769_1:InitPlayNodeList()
	end,
	Play1109305195 = function(arg_773_0, arg_773_1)
		arg_773_1.time_ = 0
		arg_773_1.frameCnt_ = 0
		arg_773_1.state_ = "playing"
		arg_773_1.curTalkId_ = 1109305195
		arg_773_1.duration_ = 5

		SetActive(arg_773_1.tipsGo_, false)

		function arg_773_1.onSingleLineFinish_()
			arg_773_1.onSingleLineUpdate_ = nil
			arg_773_1.onSingleLineFinish_ = nil
			arg_773_1.state_ = "waiting"
		end

		function arg_773_1.playNext_(arg_775_0)
			if arg_775_0 == 1 then
				arg_773_0:Play1109305196(arg_773_1)
			end
		end

		function arg_773_1.onSingleLineUpdate_(arg_776_0)
			if 0 < arg_773_1.time_ and arg_773_1.time_ <= 0 + arg_776_0 then
				arg_773_1.var_.moveOldPos1093ui_story = arg_773_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_776_0 = 0.001

			if 0 <= arg_773_1.time_ and arg_773_1.time_ < 0 + var_776_0 then
				arg_773_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_773_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_773_1.time_ - 0) / var_776_0)
				arg_773_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_773_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_773_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_773_1.actors_["1093ui_story"].transform.position).z)
				arg_773_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_773_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_773_1.actors_["1093ui_story"].transform.localEulerAngles = arg_773_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_773_1.time_ >= 0 + var_776_0 and arg_773_1.time_ < 0 + var_776_0 + arg_776_0 then
				arg_773_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_773_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_773_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_773_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_773_1.actors_["1093ui_story"].transform.position).z)
				arg_773_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_773_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_773_1.actors_["1093ui_story"].transform.localEulerAngles = arg_773_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_776_1 = arg_773_1.actors_["1093ui_story"]

			if 0 < arg_773_1.time_ and arg_773_1.time_ <= 0 + arg_776_0 and not isNil(var_776_1) and arg_773_1.var_.characterEffect1093ui_story == nil then
				arg_773_1.var_.characterEffect1093ui_story = var_776_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_776_2 = 0.200000002980232

			if 0 <= arg_773_1.time_ and arg_773_1.time_ < 0 + var_776_2 and not isNil(var_776_1) then
				if arg_773_1.var_.characterEffect1093ui_story and not isNil(var_776_1) then
					arg_773_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_773_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_773_1.time_ - 0) / var_776_2)
				end
			end

			if arg_773_1.time_ >= 0 + var_776_2 and arg_773_1.time_ < 0 + var_776_2 + arg_776_0 and not isNil(var_776_1) and arg_773_1.var_.characterEffect1093ui_story then
				arg_773_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_773_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_776_3 = 0
			local var_776_4 = 1.025

			if 0 < arg_773_1.time_ and arg_773_1.time_ <= var_776_3 + arg_776_0 then
				arg_773_1.talkMaxDuration = 0
				arg_773_1.dialogCg_.alpha = 1

				arg_773_1.dialog_:SetActive(true)
				SetActive(arg_773_1.leftNameGo_, false)

				arg_773_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_773_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_773_1:RecordName(arg_773_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_773_1.iconTrs_.gameObject, false)
				arg_773_1.callingController_:SetSelectedState("normal")

				local var_776_5 = arg_773_1:FormatText(arg_773_1:GetWordFromCfg(1109305195).content)

				arg_773_1.text_.text = var_776_5

				LuaForUtil.ClearLinePrefixSymbol(arg_773_1.text_)

				local var_776_7 = 41 <= 0 and var_776_4 or var_776_4 * (utf8.len(var_776_5) / 41)

				if (41 <= 0 and var_776_4 or var_776_4 * (utf8.len(var_776_5) / 41)) > 0 and var_776_4 < var_776_7 then
					arg_773_1.talkMaxDuration = var_776_7

					if var_776_7 + var_776_3 > arg_773_1.duration_ then
						arg_773_1.duration_ = var_776_7 + var_776_3
					end
				end

				arg_773_1.text_.text = var_776_5
				arg_773_1.typewritter.percent = 0

				arg_773_1.typewritter:SetDirty()
				arg_773_1:ShowNextGo(false)
				arg_773_1:RecordContent(arg_773_1.text_.text)
			end

			local var_776_8 = math.max(var_776_4, arg_773_1.talkMaxDuration)

			if var_776_3 <= arg_773_1.time_ and arg_773_1.time_ < var_776_3 + var_776_8 then
				arg_773_1.typewritter.percent = (arg_773_1.time_ - var_776_3) / var_776_8

				arg_773_1.typewritter:SetDirty()
			end

			if arg_773_1.time_ >= var_776_3 + var_776_8 and arg_773_1.time_ < var_776_3 + var_776_8 + arg_776_0 then
				arg_773_1.typewritter.percent = 1

				arg_773_1.typewritter:SetDirty()
				arg_773_1:ShowNextGo(true)
			end
		end

		arg_773_1.nodeConfigList_ = {
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

		arg_773_1:InitPlayNodeList()
	end,
	Play1109305196 = function(arg_777_0, arg_777_1)
		arg_777_1.time_ = 0
		arg_777_1.frameCnt_ = 0
		arg_777_1.state_ = "playing"
		arg_777_1.curTalkId_ = 1109305196
		arg_777_1.duration_ = 5

		SetActive(arg_777_1.tipsGo_, false)

		function arg_777_1.onSingleLineFinish_()
			arg_777_1.onSingleLineUpdate_ = nil
			arg_777_1.onSingleLineFinish_ = nil
			arg_777_1.state_ = "waiting"
		end

		function arg_777_1.playNext_(arg_779_0)
			if arg_779_0 == 1 then
				arg_777_0:Play1109305197(arg_777_1)
			end
		end

		function arg_777_1.onSingleLineUpdate_(arg_780_0)
			local var_780_0 = 0.35

			if 0 < arg_777_1.time_ and arg_777_1.time_ <= 0 + arg_780_0 then
				arg_777_1.talkMaxDuration = 0
				arg_777_1.dialogCg_.alpha = 1

				arg_777_1.dialog_:SetActive(true)
				SetActive(arg_777_1.leftNameGo_, true)

				arg_777_1.leftNameTxt_.text = arg_777_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_777_1.leftNameTxt_.transform)

				arg_777_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_777_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_777_1:RecordName(arg_777_1.leftNameTxt_.text)
				SetActive(arg_777_1.iconTrs_.gameObject, true)
				arg_777_1.iconController_:SetSelectedState("hero")

				arg_777_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_777_1.callingController_:SetSelectedState("normal")

				arg_777_1.keyicon_.color = Color.New(1, 1, 1)
				arg_777_1.icon_.color = Color.New(1, 1, 1)

				local var_780_1 = arg_777_1:FormatText(arg_777_1:GetWordFromCfg(1109305196).content)

				arg_777_1.text_.text = var_780_1

				LuaForUtil.ClearLinePrefixSymbol(arg_777_1.text_)

				local var_780_3 = 14 <= 0 and var_780_0 or var_780_0 * (utf8.len(var_780_1) / 14)

				if (14 <= 0 and var_780_0 or var_780_0 * (utf8.len(var_780_1) / 14)) > 0 and var_780_0 < var_780_3 then
					arg_777_1.talkMaxDuration = var_780_3

					if var_780_3 + 0 > arg_777_1.duration_ then
						arg_777_1.duration_ = var_780_3 + 0
					end
				end

				arg_777_1.text_.text = var_780_1
				arg_777_1.typewritter.percent = 0

				arg_777_1.typewritter:SetDirty()
				arg_777_1:ShowNextGo(false)
				arg_777_1:RecordContent(arg_777_1.text_.text)
			end

			local var_780_4 = math.max(var_780_0, arg_777_1.talkMaxDuration)

			if 0 <= arg_777_1.time_ and arg_777_1.time_ < 0 + var_780_4 then
				arg_777_1.typewritter.percent = (arg_777_1.time_ - 0) / var_780_4

				arg_777_1.typewritter:SetDirty()
			end

			if arg_777_1.time_ >= 0 + var_780_4 and arg_777_1.time_ < 0 + var_780_4 + arg_780_0 then
				arg_777_1.typewritter.percent = 1

				arg_777_1.typewritter:SetDirty()
				arg_777_1:ShowNextGo(true)
			end
		end

		arg_777_1.nodeConfigList_ = {}

		arg_777_1:InitPlayNodeList()
	end,
	Play1109305197 = function(arg_781_0, arg_781_1)
		arg_781_1.time_ = 0
		arg_781_1.frameCnt_ = 0
		arg_781_1.state_ = "playing"
		arg_781_1.curTalkId_ = 1109305197
		arg_781_1.duration_ = 5

		SetActive(arg_781_1.tipsGo_, false)

		function arg_781_1.onSingleLineFinish_()
			arg_781_1.onSingleLineUpdate_ = nil
			arg_781_1.onSingleLineFinish_ = nil
			arg_781_1.state_ = "waiting"
		end

		function arg_781_1.playNext_(arg_783_0)
			if arg_783_0 == 1 then
				arg_781_0:Play1109305198(arg_781_1)
			end
		end

		function arg_781_1.onSingleLineUpdate_(arg_784_0)
			local var_784_0 = 0.575

			if 0 < arg_781_1.time_ and arg_781_1.time_ <= 0 + arg_784_0 then
				arg_781_1.talkMaxDuration = 0
				arg_781_1.dialogCg_.alpha = 1

				arg_781_1.dialog_:SetActive(true)
				SetActive(arg_781_1.leftNameGo_, false)

				arg_781_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_781_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_781_1:RecordName(arg_781_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_781_1.iconTrs_.gameObject, false)
				arg_781_1.callingController_:SetSelectedState("normal")

				local var_784_1 = arg_781_1:FormatText(arg_781_1:GetWordFromCfg(1109305197).content)

				arg_781_1.text_.text = var_784_1

				LuaForUtil.ClearLinePrefixSymbol(arg_781_1.text_)

				local var_784_3 = 23 <= 0 and var_784_0 or var_784_0 * (utf8.len(var_784_1) / 23)

				if (23 <= 0 and var_784_0 or var_784_0 * (utf8.len(var_784_1) / 23)) > 0 and var_784_0 < var_784_3 then
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
	Play1109305198 = function(arg_785_0, arg_785_1)
		arg_785_1.time_ = 0
		arg_785_1.frameCnt_ = 0
		arg_785_1.state_ = "playing"
		arg_785_1.curTalkId_ = 1109305198
		arg_785_1.duration_ = 6.83

		SetActive(arg_785_1.tipsGo_, false)

		function arg_785_1.onSingleLineFinish_()
			arg_785_1.onSingleLineUpdate_ = nil
			arg_785_1.onSingleLineFinish_ = nil
			arg_785_1.state_ = "waiting"
		end

		function arg_785_1.playNext_(arg_787_0)
			if arg_787_0 == 1 then
				arg_785_0:Play1109305199(arg_785_1)
			end
		end

		function arg_785_1.onSingleLineUpdate_(arg_788_0)
			if 0 < arg_785_1.time_ and arg_785_1.time_ <= 0 + arg_788_0 then
				arg_785_1.var_.moveOldPos1093ui_story = arg_785_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_788_0 = 0.001

			if 0 <= arg_785_1.time_ and arg_785_1.time_ < 0 + var_788_0 then
				arg_785_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_785_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_785_1.time_ - 0) / var_788_0)
				arg_785_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_785_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_785_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_785_1.actors_["1093ui_story"].transform.position).z)
				arg_785_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_785_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_785_1.actors_["1093ui_story"].transform.localEulerAngles = arg_785_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_785_1.time_ >= 0 + var_788_0 and arg_785_1.time_ < 0 + var_788_0 + arg_788_0 then
				arg_785_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_785_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_785_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_785_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_785_1.actors_["1093ui_story"].transform.position).z)
				arg_785_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_785_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_785_1.actors_["1093ui_story"].transform.localEulerAngles = arg_785_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_788_1 = arg_785_1.actors_["1093ui_story"]

			if 0 < arg_785_1.time_ and arg_785_1.time_ <= 0 + arg_788_0 and not isNil(var_788_1) and arg_785_1.var_.characterEffect1093ui_story == nil then
				arg_785_1.var_.characterEffect1093ui_story = var_788_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_788_2 = 0.200000002980232

			if 0 <= arg_785_1.time_ and arg_785_1.time_ < 0 + var_788_2 and not isNil(var_788_1) then
				if arg_785_1.var_.characterEffect1093ui_story and not isNil(var_788_1) then
					arg_785_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_785_1.time_ >= 0 + var_788_2 and arg_785_1.time_ < 0 + var_788_2 + arg_788_0 and not isNil(var_788_1) and arg_785_1.var_.characterEffect1093ui_story then
				arg_785_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_785_1.time_ and arg_785_1.time_ <= 0 + arg_788_0 then
				arg_785_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			if 0 < arg_785_1.time_ and arg_785_1.time_ <= 0 + arg_788_0 then
				arg_785_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_788_4 = 0
			local var_788_5 = 0.825

			if 0 < arg_785_1.time_ and arg_785_1.time_ <= var_788_4 + arg_788_0 then
				arg_785_1.talkMaxDuration = 0
				arg_785_1.dialogCg_.alpha = 1

				arg_785_1.dialog_:SetActive(true)
				SetActive(arg_785_1.leftNameGo_, true)

				arg_785_1.leftNameTxt_.text = arg_785_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_785_1.leftNameTxt_.transform)

				arg_785_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_785_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_785_1:RecordName(arg_785_1.leftNameTxt_.text)
				SetActive(arg_785_1.iconTrs_.gameObject, false)
				arg_785_1.callingController_:SetSelectedState("normal")

				local var_788_6 = arg_785_1:GetWordFromCfg(1109305198)
				local var_788_7 = arg_785_1:FormatText(var_788_6.content)

				arg_785_1.text_.text = var_788_7

				LuaForUtil.ClearLinePrefixSymbol(arg_785_1.text_)

				local var_788_9 = 33 <= 0 and var_788_5 or var_788_5 * (utf8.len(var_788_7) / 33)

				if (33 <= 0 and var_788_5 or var_788_5 * (utf8.len(var_788_7) / 33)) > 0 and var_788_5 < var_788_9 then
					arg_785_1.talkMaxDuration = var_788_9

					if var_788_9 + var_788_4 > arg_785_1.duration_ then
						arg_785_1.duration_ = var_788_9 + var_788_4
					end
				end

				arg_785_1.text_.text = var_788_7
				arg_785_1.typewritter.percent = 0

				arg_785_1.typewritter:SetDirty()
				arg_785_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305198", "story_v_side_new_1109305.awb") ~= 0 then
					local var_788_10 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305198", "story_v_side_new_1109305.awb") / 1000

					if var_788_10 + var_788_4 > arg_785_1.duration_ then
						arg_785_1.duration_ = var_788_10 + var_788_4
					end

					if var_788_6.prefab_name ~= "" and arg_785_1.actors_[var_788_6.prefab_name] ~= nil then
						local var_788_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_785_1.actors_[var_788_6.prefab_name].transform, "story_v_side_new_1109305", "1109305198", "story_v_side_new_1109305.awb")

						arg_785_1:RecordAudio("1109305198", var_788_11)
						arg_785_1:RecordAudio("1109305198", var_788_11)
					else
						arg_785_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305198", "story_v_side_new_1109305.awb")
					end

					arg_785_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305198", "story_v_side_new_1109305.awb")
				end

				arg_785_1:RecordContent(arg_785_1.text_.text)
			end

			local var_788_12 = math.max(var_788_5, arg_785_1.talkMaxDuration)

			if var_788_4 <= arg_785_1.time_ and arg_785_1.time_ < var_788_4 + var_788_12 then
				arg_785_1.typewritter.percent = (arg_785_1.time_ - var_788_4) / var_788_12

				arg_785_1.typewritter:SetDirty()
			end

			if arg_785_1.time_ >= var_788_4 + var_788_12 and arg_785_1.time_ < var_788_4 + var_788_12 + arg_788_0 then
				arg_785_1.typewritter.percent = 1

				arg_785_1.typewritter:SetDirty()
				arg_785_1:ShowNextGo(true)
			end
		end

		arg_785_1.nodeConfigList_ = {
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

		arg_785_1:InitPlayNodeList()
	end,
	Play1109305199 = function(arg_789_0, arg_789_1)
		arg_789_1.time_ = 0
		arg_789_1.frameCnt_ = 0
		arg_789_1.state_ = "playing"
		arg_789_1.curTalkId_ = 1109305199
		arg_789_1.duration_ = 5

		SetActive(arg_789_1.tipsGo_, false)

		function arg_789_1.onSingleLineFinish_()
			arg_789_1.onSingleLineUpdate_ = nil
			arg_789_1.onSingleLineFinish_ = nil
			arg_789_1.state_ = "waiting"
		end

		function arg_789_1.playNext_(arg_791_0)
			if arg_791_0 == 1 then
				arg_789_0:Play1109305200(arg_789_1)
			end
		end

		function arg_789_1.onSingleLineUpdate_(arg_792_0)
			if 0 < arg_789_1.time_ and arg_789_1.time_ <= 0 + arg_792_0 and not isNil(arg_789_1.actors_["1093ui_story"]) and arg_789_1.var_.characterEffect1093ui_story == nil then
				arg_789_1.var_.characterEffect1093ui_story = arg_789_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_792_0 = 0.200000002980232

			if 0 <= arg_789_1.time_ and arg_789_1.time_ < 0 + var_792_0 and not isNil(arg_789_1.actors_["1093ui_story"]) then
				if arg_789_1.var_.characterEffect1093ui_story and not isNil(arg_789_1.actors_["1093ui_story"]) then
					arg_789_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_789_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_789_1.time_ - 0) / var_792_0)
				end
			end

			if arg_789_1.time_ >= 0 + var_792_0 and arg_789_1.time_ < 0 + var_792_0 + arg_792_0 and not isNil(arg_789_1.actors_["1093ui_story"]) and arg_789_1.var_.characterEffect1093ui_story then
				arg_789_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_789_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_792_1 = 0
			local var_792_2 = 0.75

			if 0 < arg_789_1.time_ and arg_789_1.time_ <= var_792_1 + arg_792_0 then
				arg_789_1.talkMaxDuration = 0
				arg_789_1.dialogCg_.alpha = 1

				arg_789_1.dialog_:SetActive(true)
				SetActive(arg_789_1.leftNameGo_, false)

				arg_789_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_789_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_789_1:RecordName(arg_789_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_789_1.iconTrs_.gameObject, false)
				arg_789_1.callingController_:SetSelectedState("normal")

				local var_792_3 = arg_789_1:FormatText(arg_789_1:GetWordFromCfg(1109305199).content)

				arg_789_1.text_.text = var_792_3

				LuaForUtil.ClearLinePrefixSymbol(arg_789_1.text_)

				local var_792_5 = 30 <= 0 and var_792_2 or var_792_2 * (utf8.len(var_792_3) / 30)

				if (30 <= 0 and var_792_2 or var_792_2 * (utf8.len(var_792_3) / 30)) > 0 and var_792_2 < var_792_5 then
					arg_789_1.talkMaxDuration = var_792_5

					if var_792_5 + var_792_1 > arg_789_1.duration_ then
						arg_789_1.duration_ = var_792_5 + var_792_1
					end
				end

				arg_789_1.text_.text = var_792_3
				arg_789_1.typewritter.percent = 0

				arg_789_1.typewritter:SetDirty()
				arg_789_1:ShowNextGo(false)
				arg_789_1:RecordContent(arg_789_1.text_.text)
			end

			local var_792_6 = math.max(var_792_2, arg_789_1.talkMaxDuration)

			if var_792_1 <= arg_789_1.time_ and arg_789_1.time_ < var_792_1 + var_792_6 then
				arg_789_1.typewritter.percent = (arg_789_1.time_ - var_792_1) / var_792_6

				arg_789_1.typewritter:SetDirty()
			end

			if arg_789_1.time_ >= var_792_1 + var_792_6 and arg_789_1.time_ < var_792_1 + var_792_6 + arg_792_0 then
				arg_789_1.typewritter.percent = 1

				arg_789_1.typewritter:SetDirty()
				arg_789_1:ShowNextGo(true)
			end
		end

		arg_789_1.nodeConfigList_ = {}

		arg_789_1:InitPlayNodeList()
	end,
	Play1109305200 = function(arg_793_0, arg_793_1)
		arg_793_1.time_ = 0
		arg_793_1.frameCnt_ = 0
		arg_793_1.state_ = "playing"
		arg_793_1.curTalkId_ = 1109305200
		arg_793_1.duration_ = 5

		SetActive(arg_793_1.tipsGo_, false)

		function arg_793_1.onSingleLineFinish_()
			arg_793_1.onSingleLineUpdate_ = nil
			arg_793_1.onSingleLineFinish_ = nil
			arg_793_1.state_ = "waiting"
		end

		function arg_793_1.playNext_(arg_795_0)
			if arg_795_0 == 1 then
				arg_793_0:Play1109305201(arg_793_1)
			end
		end

		function arg_793_1.onSingleLineUpdate_(arg_796_0)
			local var_796_0 = 0.2

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

				local var_796_1 = arg_793_1:FormatText(arg_793_1:GetWordFromCfg(1109305200).content)

				arg_793_1.text_.text = var_796_1

				LuaForUtil.ClearLinePrefixSymbol(arg_793_1.text_)

				local var_796_3 = 8 <= 0 and var_796_0 or var_796_0 * (utf8.len(var_796_1) / 8)

				if (8 <= 0 and var_796_0 or var_796_0 * (utf8.len(var_796_1) / 8)) > 0 and var_796_0 < var_796_3 then
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
	Play1109305201 = function(arg_797_0, arg_797_1)
		arg_797_1.time_ = 0
		arg_797_1.frameCnt_ = 0
		arg_797_1.state_ = "playing"
		arg_797_1.curTalkId_ = 1109305201
		arg_797_1.duration_ = 4.4

		SetActive(arg_797_1.tipsGo_, false)

		function arg_797_1.onSingleLineFinish_()
			arg_797_1.onSingleLineUpdate_ = nil
			arg_797_1.onSingleLineFinish_ = nil
			arg_797_1.state_ = "waiting"
		end

		function arg_797_1.playNext_(arg_799_0)
			if arg_799_0 == 1 then
				arg_797_0:Play1109305202(arg_797_1)
			end
		end

		function arg_797_1.onSingleLineUpdate_(arg_800_0)
			if 0 < arg_797_1.time_ and arg_797_1.time_ <= 0 + arg_800_0 then
				arg_797_1.var_.moveOldPos1093ui_story = arg_797_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_800_0 = 0.001

			if 0 <= arg_797_1.time_ and arg_797_1.time_ < 0 + var_800_0 then
				arg_797_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_797_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_797_1.time_ - 0) / var_800_0)
				arg_797_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_797_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_797_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_797_1.actors_["1093ui_story"].transform.position).z)
				arg_797_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_797_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_797_1.actors_["1093ui_story"].transform.localEulerAngles = arg_797_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_797_1.time_ >= 0 + var_800_0 and arg_797_1.time_ < 0 + var_800_0 + arg_800_0 then
				arg_797_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_797_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_797_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_797_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_797_1.actors_["1093ui_story"].transform.position).z)
				arg_797_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_797_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_797_1.actors_["1093ui_story"].transform.localEulerAngles = arg_797_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_800_1 = arg_797_1.actors_["1093ui_story"]

			if 0 < arg_797_1.time_ and arg_797_1.time_ <= 0 + arg_800_0 and not isNil(var_800_1) and arg_797_1.var_.characterEffect1093ui_story == nil then
				arg_797_1.var_.characterEffect1093ui_story = var_800_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_800_2 = 0.200000002980232

			if 0 <= arg_797_1.time_ and arg_797_1.time_ < 0 + var_800_2 and not isNil(var_800_1) then
				if arg_797_1.var_.characterEffect1093ui_story and not isNil(var_800_1) then
					arg_797_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_797_1.time_ >= 0 + var_800_2 and arg_797_1.time_ < 0 + var_800_2 + arg_800_0 and not isNil(var_800_1) and arg_797_1.var_.characterEffect1093ui_story then
				arg_797_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_797_1.time_ and arg_797_1.time_ <= 0 + arg_800_0 then
				arg_797_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_800_4 = 0
			local var_800_5 = 0.5

			if 0 < arg_797_1.time_ and arg_797_1.time_ <= var_800_4 + arg_800_0 then
				arg_797_1.talkMaxDuration = 0
				arg_797_1.dialogCg_.alpha = 1

				arg_797_1.dialog_:SetActive(true)
				SetActive(arg_797_1.leftNameGo_, true)

				arg_797_1.leftNameTxt_.text = arg_797_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_797_1.leftNameTxt_.transform)

				arg_797_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_797_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_797_1:RecordName(arg_797_1.leftNameTxt_.text)
				SetActive(arg_797_1.iconTrs_.gameObject, false)
				arg_797_1.callingController_:SetSelectedState("normal")

				local var_800_6 = arg_797_1:GetWordFromCfg(1109305201)
				local var_800_7 = arg_797_1:FormatText(var_800_6.content)

				arg_797_1.text_.text = var_800_7

				LuaForUtil.ClearLinePrefixSymbol(arg_797_1.text_)

				local var_800_9 = 20 <= 0 and var_800_5 or var_800_5 * (utf8.len(var_800_7) / 20)

				if (20 <= 0 and var_800_5 or var_800_5 * (utf8.len(var_800_7) / 20)) > 0 and var_800_5 < var_800_9 then
					arg_797_1.talkMaxDuration = var_800_9

					if var_800_9 + var_800_4 > arg_797_1.duration_ then
						arg_797_1.duration_ = var_800_9 + var_800_4
					end
				end

				arg_797_1.text_.text = var_800_7
				arg_797_1.typewritter.percent = 0

				arg_797_1.typewritter:SetDirty()
				arg_797_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305201", "story_v_side_new_1109305.awb") ~= 0 then
					local var_800_10 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305201", "story_v_side_new_1109305.awb") / 1000

					if var_800_10 + var_800_4 > arg_797_1.duration_ then
						arg_797_1.duration_ = var_800_10 + var_800_4
					end

					if var_800_6.prefab_name ~= "" and arg_797_1.actors_[var_800_6.prefab_name] ~= nil then
						local var_800_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_797_1.actors_[var_800_6.prefab_name].transform, "story_v_side_new_1109305", "1109305201", "story_v_side_new_1109305.awb")

						arg_797_1:RecordAudio("1109305201", var_800_11)
						arg_797_1:RecordAudio("1109305201", var_800_11)
					else
						arg_797_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305201", "story_v_side_new_1109305.awb")
					end

					arg_797_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305201", "story_v_side_new_1109305.awb")
				end

				arg_797_1:RecordContent(arg_797_1.text_.text)
			end

			local var_800_12 = math.max(var_800_5, arg_797_1.talkMaxDuration)

			if var_800_4 <= arg_797_1.time_ and arg_797_1.time_ < var_800_4 + var_800_12 then
				arg_797_1.typewritter.percent = (arg_797_1.time_ - var_800_4) / var_800_12

				arg_797_1.typewritter:SetDirty()
			end

			if arg_797_1.time_ >= var_800_4 + var_800_12 and arg_797_1.time_ < var_800_4 + var_800_12 + arg_800_0 then
				arg_797_1.typewritter.percent = 1

				arg_797_1.typewritter:SetDirty()
				arg_797_1:ShowNextGo(true)
			end
		end

		arg_797_1.nodeConfigList_ = {
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

		arg_797_1:InitPlayNodeList()
	end,
	Play1109305202 = function(arg_801_0, arg_801_1)
		arg_801_1.time_ = 0
		arg_801_1.frameCnt_ = 0
		arg_801_1.state_ = "playing"
		arg_801_1.curTalkId_ = 1109305202
		arg_801_1.duration_ = 5

		SetActive(arg_801_1.tipsGo_, false)

		function arg_801_1.onSingleLineFinish_()
			arg_801_1.onSingleLineUpdate_ = nil
			arg_801_1.onSingleLineFinish_ = nil
			arg_801_1.state_ = "waiting"
		end

		function arg_801_1.playNext_(arg_803_0)
			if arg_803_0 == 1 then
				arg_801_0:Play1109305203(arg_801_1)
			end
		end

		function arg_801_1.onSingleLineUpdate_(arg_804_0)
			if 0 < arg_801_1.time_ and arg_801_1.time_ <= 0 + arg_804_0 and not isNil(arg_801_1.actors_["1093ui_story"]) and arg_801_1.var_.characterEffect1093ui_story == nil then
				arg_801_1.var_.characterEffect1093ui_story = arg_801_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_804_0 = 0.200000002980232

			if 0 <= arg_801_1.time_ and arg_801_1.time_ < 0 + var_804_0 and not isNil(arg_801_1.actors_["1093ui_story"]) then
				if arg_801_1.var_.characterEffect1093ui_story and not isNil(arg_801_1.actors_["1093ui_story"]) then
					arg_801_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_801_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_801_1.time_ - 0) / var_804_0)
				end
			end

			if arg_801_1.time_ >= 0 + var_804_0 and arg_801_1.time_ < 0 + var_804_0 + arg_804_0 and not isNil(arg_801_1.actors_["1093ui_story"]) and arg_801_1.var_.characterEffect1093ui_story then
				arg_801_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_801_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_804_1 = 0
			local var_804_2 = 0.4

			if 0 < arg_801_1.time_ and arg_801_1.time_ <= var_804_1 + arg_804_0 then
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

				local var_804_3 = arg_801_1:FormatText(arg_801_1:GetWordFromCfg(1109305202).content)

				arg_801_1.text_.text = var_804_3

				LuaForUtil.ClearLinePrefixSymbol(arg_801_1.text_)

				local var_804_5 = 16 <= 0 and var_804_2 or var_804_2 * (utf8.len(var_804_3) / 16)

				if (16 <= 0 and var_804_2 or var_804_2 * (utf8.len(var_804_3) / 16)) > 0 and var_804_2 < var_804_5 then
					arg_801_1.talkMaxDuration = var_804_5

					if var_804_5 + var_804_1 > arg_801_1.duration_ then
						arg_801_1.duration_ = var_804_5 + var_804_1
					end
				end

				arg_801_1.text_.text = var_804_3
				arg_801_1.typewritter.percent = 0

				arg_801_1.typewritter:SetDirty()
				arg_801_1:ShowNextGo(false)
				arg_801_1:RecordContent(arg_801_1.text_.text)
			end

			local var_804_6 = math.max(var_804_2, arg_801_1.talkMaxDuration)

			if var_804_1 <= arg_801_1.time_ and arg_801_1.time_ < var_804_1 + var_804_6 then
				arg_801_1.typewritter.percent = (arg_801_1.time_ - var_804_1) / var_804_6

				arg_801_1.typewritter:SetDirty()
			end

			if arg_801_1.time_ >= var_804_1 + var_804_6 and arg_801_1.time_ < var_804_1 + var_804_6 + arg_804_0 then
				arg_801_1.typewritter.percent = 1

				arg_801_1.typewritter:SetDirty()
				arg_801_1:ShowNextGo(true)
			end
		end

		arg_801_1.nodeConfigList_ = {}

		arg_801_1:InitPlayNodeList()
	end,
	Play1109305203 = function(arg_805_0, arg_805_1)
		arg_805_1.time_ = 0
		arg_805_1.frameCnt_ = 0
		arg_805_1.state_ = "playing"
		arg_805_1.curTalkId_ = 1109305203
		arg_805_1.duration_ = 5

		SetActive(arg_805_1.tipsGo_, false)

		function arg_805_1.onSingleLineFinish_()
			arg_805_1.onSingleLineUpdate_ = nil
			arg_805_1.onSingleLineFinish_ = nil
			arg_805_1.state_ = "waiting"
		end

		function arg_805_1.playNext_(arg_807_0)
			if arg_807_0 == 1 then
				arg_805_0:Play1109305204(arg_805_1)
			end
		end

		function arg_805_1.onSingleLineUpdate_(arg_808_0)
			if 0 < arg_805_1.time_ and arg_805_1.time_ <= 0 + arg_808_0 then
				arg_805_1.var_.moveOldPos1093ui_story = arg_805_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_808_0 = 0.001

			if 0 <= arg_805_1.time_ and arg_805_1.time_ < 0 + var_808_0 then
				arg_805_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_805_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_805_1.time_ - 0) / var_808_0)
				arg_805_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_805_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_805_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_805_1.actors_["1093ui_story"].transform.position).z)
				arg_805_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_805_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_805_1.actors_["1093ui_story"].transform.localEulerAngles = arg_805_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_805_1.time_ >= 0 + var_808_0 and arg_805_1.time_ < 0 + var_808_0 + arg_808_0 then
				arg_805_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_805_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_805_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_805_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_805_1.actors_["1093ui_story"].transform.position).z)
				arg_805_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_805_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_805_1.actors_["1093ui_story"].transform.localEulerAngles = arg_805_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_808_1 = arg_805_1.actors_["1093ui_story"]

			if 0 < arg_805_1.time_ and arg_805_1.time_ <= 0 + arg_808_0 and not isNil(var_808_1) and arg_805_1.var_.characterEffect1093ui_story == nil then
				arg_805_1.var_.characterEffect1093ui_story = var_808_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_808_2 = 0.200000002980232

			if 0 <= arg_805_1.time_ and arg_805_1.time_ < 0 + var_808_2 and not isNil(var_808_1) then
				if arg_805_1.var_.characterEffect1093ui_story and not isNil(var_808_1) then
					arg_805_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_805_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_805_1.time_ - 0) / var_808_2)
				end
			end

			if arg_805_1.time_ >= 0 + var_808_2 and arg_805_1.time_ < 0 + var_808_2 + arg_808_0 and not isNil(var_808_1) and arg_805_1.var_.characterEffect1093ui_story then
				arg_805_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_805_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_808_3 = 0
			local var_808_4 = 0.75

			if 0 < arg_805_1.time_ and arg_805_1.time_ <= var_808_3 + arg_808_0 then
				arg_805_1.talkMaxDuration = 0
				arg_805_1.dialogCg_.alpha = 1

				arg_805_1.dialog_:SetActive(true)
				SetActive(arg_805_1.leftNameGo_, false)

				arg_805_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_805_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_805_1:RecordName(arg_805_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_805_1.iconTrs_.gameObject, false)
				arg_805_1.callingController_:SetSelectedState("normal")

				local var_808_5 = arg_805_1:FormatText(arg_805_1:GetWordFromCfg(1109305203).content)

				arg_805_1.text_.text = var_808_5

				LuaForUtil.ClearLinePrefixSymbol(arg_805_1.text_)

				local var_808_7 = 30 <= 0 and var_808_4 or var_808_4 * (utf8.len(var_808_5) / 30)

				if (30 <= 0 and var_808_4 or var_808_4 * (utf8.len(var_808_5) / 30)) > 0 and var_808_4 < var_808_7 then
					arg_805_1.talkMaxDuration = var_808_7

					if var_808_7 + var_808_3 > arg_805_1.duration_ then
						arg_805_1.duration_ = var_808_7 + var_808_3
					end
				end

				arg_805_1.text_.text = var_808_5
				arg_805_1.typewritter.percent = 0

				arg_805_1.typewritter:SetDirty()
				arg_805_1:ShowNextGo(false)
				arg_805_1:RecordContent(arg_805_1.text_.text)
			end

			local var_808_8 = math.max(var_808_4, arg_805_1.talkMaxDuration)

			if var_808_3 <= arg_805_1.time_ and arg_805_1.time_ < var_808_3 + var_808_8 then
				arg_805_1.typewritter.percent = (arg_805_1.time_ - var_808_3) / var_808_8

				arg_805_1.typewritter:SetDirty()
			end

			if arg_805_1.time_ >= var_808_3 + var_808_8 and arg_805_1.time_ < var_808_3 + var_808_8 + arg_808_0 then
				arg_805_1.typewritter.percent = 1

				arg_805_1.typewritter:SetDirty()
				arg_805_1:ShowNextGo(true)
			end
		end

		arg_805_1.nodeConfigList_ = {
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

		arg_805_1:InitPlayNodeList()
	end,
	Play1109305204 = function(arg_809_0, arg_809_1)
		arg_809_1.time_ = 0
		arg_809_1.frameCnt_ = 0
		arg_809_1.state_ = "playing"
		arg_809_1.curTalkId_ = 1109305204
		arg_809_1.duration_ = 5

		SetActive(arg_809_1.tipsGo_, false)

		function arg_809_1.onSingleLineFinish_()
			arg_809_1.onSingleLineUpdate_ = nil
			arg_809_1.onSingleLineFinish_ = nil
			arg_809_1.state_ = "waiting"
		end

		function arg_809_1.playNext_(arg_811_0)
			if arg_811_0 == 1 then
				arg_809_0:Play1109305205(arg_809_1)
			end
		end

		function arg_809_1.onSingleLineUpdate_(arg_812_0)
			local var_812_0 = 0.45

			if 0 < arg_809_1.time_ and arg_809_1.time_ <= 0 + arg_812_0 then
				arg_809_1.talkMaxDuration = 0
				arg_809_1.dialogCg_.alpha = 1

				arg_809_1.dialog_:SetActive(true)
				SetActive(arg_809_1.leftNameGo_, true)

				arg_809_1.leftNameTxt_.text = arg_809_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_809_1.leftNameTxt_.transform)

				arg_809_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_809_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_809_1:RecordName(arg_809_1.leftNameTxt_.text)
				SetActive(arg_809_1.iconTrs_.gameObject, true)
				arg_809_1.iconController_:SetSelectedState("hero")

				arg_809_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_809_1.callingController_:SetSelectedState("normal")

				arg_809_1.keyicon_.color = Color.New(1, 1, 1)
				arg_809_1.icon_.color = Color.New(1, 1, 1)

				local var_812_1 = arg_809_1:FormatText(arg_809_1:GetWordFromCfg(1109305204).content)

				arg_809_1.text_.text = var_812_1

				LuaForUtil.ClearLinePrefixSymbol(arg_809_1.text_)

				local var_812_3 = 18 <= 0 and var_812_0 or var_812_0 * (utf8.len(var_812_1) / 18)

				if (18 <= 0 and var_812_0 or var_812_0 * (utf8.len(var_812_1) / 18)) > 0 and var_812_0 < var_812_3 then
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
	Play1109305205 = function(arg_813_0, arg_813_1)
		arg_813_1.time_ = 0
		arg_813_1.frameCnt_ = 0
		arg_813_1.state_ = "playing"
		arg_813_1.curTalkId_ = 1109305205
		arg_813_1.duration_ = 7.07

		SetActive(arg_813_1.tipsGo_, false)

		function arg_813_1.onSingleLineFinish_()
			arg_813_1.onSingleLineUpdate_ = nil
			arg_813_1.onSingleLineFinish_ = nil
			arg_813_1.state_ = "waiting"
		end

		function arg_813_1.playNext_(arg_815_0)
			if arg_815_0 == 1 then
				arg_813_0:Play1109305206(arg_813_1)
			end
		end

		function arg_813_1.onSingleLineUpdate_(arg_816_0)
			if 0 < arg_813_1.time_ and arg_813_1.time_ <= 0 + arg_816_0 then
				arg_813_1.var_.moveOldPos1093ui_story = arg_813_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_816_0 = 0.001

			if 0 <= arg_813_1.time_ and arg_813_1.time_ < 0 + var_816_0 then
				arg_813_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_813_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_813_1.time_ - 0) / var_816_0)
				arg_813_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_813_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_813_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_813_1.actors_["1093ui_story"].transform.position).z)
				arg_813_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_813_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_813_1.actors_["1093ui_story"].transform.localEulerAngles = arg_813_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_813_1.time_ >= 0 + var_816_0 and arg_813_1.time_ < 0 + var_816_0 + arg_816_0 then
				arg_813_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_813_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_813_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_813_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_813_1.actors_["1093ui_story"].transform.position).z)
				arg_813_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_813_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_813_1.actors_["1093ui_story"].transform.localEulerAngles = arg_813_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_816_1 = arg_813_1.actors_["1093ui_story"]

			if 0 < arg_813_1.time_ and arg_813_1.time_ <= 0 + arg_816_0 and not isNil(var_816_1) and arg_813_1.var_.characterEffect1093ui_story == nil then
				arg_813_1.var_.characterEffect1093ui_story = var_816_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_816_2 = 0.200000002980232

			if 0 <= arg_813_1.time_ and arg_813_1.time_ < 0 + var_816_2 and not isNil(var_816_1) then
				if arg_813_1.var_.characterEffect1093ui_story and not isNil(var_816_1) then
					arg_813_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_813_1.time_ >= 0 + var_816_2 and arg_813_1.time_ < 0 + var_816_2 + arg_816_0 and not isNil(var_816_1) and arg_813_1.var_.characterEffect1093ui_story then
				arg_813_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_813_1.time_ and arg_813_1.time_ <= 0 + arg_816_0 then
				arg_813_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_2")
			end

			if 0 < arg_813_1.time_ and arg_813_1.time_ <= 0 + arg_816_0 then
				arg_813_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_816_4 = 0
			local var_816_5 = 0.725

			if 0 < arg_813_1.time_ and arg_813_1.time_ <= var_816_4 + arg_816_0 then
				arg_813_1.talkMaxDuration = 0
				arg_813_1.dialogCg_.alpha = 1

				arg_813_1.dialog_:SetActive(true)
				SetActive(arg_813_1.leftNameGo_, true)

				arg_813_1.leftNameTxt_.text = arg_813_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_813_1.leftNameTxt_.transform)

				arg_813_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_813_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_813_1:RecordName(arg_813_1.leftNameTxt_.text)
				SetActive(arg_813_1.iconTrs_.gameObject, false)
				arg_813_1.callingController_:SetSelectedState("normal")

				local var_816_6 = arg_813_1:GetWordFromCfg(1109305205)
				local var_816_7 = arg_813_1:FormatText(var_816_6.content)

				arg_813_1.text_.text = var_816_7

				LuaForUtil.ClearLinePrefixSymbol(arg_813_1.text_)

				local var_816_9 = 29 <= 0 and var_816_5 or var_816_5 * (utf8.len(var_816_7) / 29)

				if (29 <= 0 and var_816_5 or var_816_5 * (utf8.len(var_816_7) / 29)) > 0 and var_816_5 < var_816_9 then
					arg_813_1.talkMaxDuration = var_816_9

					if var_816_9 + var_816_4 > arg_813_1.duration_ then
						arg_813_1.duration_ = var_816_9 + var_816_4
					end
				end

				arg_813_1.text_.text = var_816_7
				arg_813_1.typewritter.percent = 0

				arg_813_1.typewritter:SetDirty()
				arg_813_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305205", "story_v_side_new_1109305.awb") ~= 0 then
					local var_816_10 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305205", "story_v_side_new_1109305.awb") / 1000

					if var_816_10 + var_816_4 > arg_813_1.duration_ then
						arg_813_1.duration_ = var_816_10 + var_816_4
					end

					if var_816_6.prefab_name ~= "" and arg_813_1.actors_[var_816_6.prefab_name] ~= nil then
						local var_816_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_813_1.actors_[var_816_6.prefab_name].transform, "story_v_side_new_1109305", "1109305205", "story_v_side_new_1109305.awb")

						arg_813_1:RecordAudio("1109305205", var_816_11)
						arg_813_1:RecordAudio("1109305205", var_816_11)
					else
						arg_813_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305205", "story_v_side_new_1109305.awb")
					end

					arg_813_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305205", "story_v_side_new_1109305.awb")
				end

				arg_813_1:RecordContent(arg_813_1.text_.text)
			end

			local var_816_12 = math.max(var_816_5, arg_813_1.talkMaxDuration)

			if var_816_4 <= arg_813_1.time_ and arg_813_1.time_ < var_816_4 + var_816_12 then
				arg_813_1.typewritter.percent = (arg_813_1.time_ - var_816_4) / var_816_12

				arg_813_1.typewritter:SetDirty()
			end

			if arg_813_1.time_ >= var_816_4 + var_816_12 and arg_813_1.time_ < var_816_4 + var_816_12 + arg_816_0 then
				arg_813_1.typewritter.percent = 1

				arg_813_1.typewritter:SetDirty()
				arg_813_1:ShowNextGo(true)
			end
		end

		arg_813_1.nodeConfigList_ = {
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

		arg_813_1:InitPlayNodeList()
	end,
	Play1109305206 = function(arg_817_0, arg_817_1)
		arg_817_1.time_ = 0
		arg_817_1.frameCnt_ = 0
		arg_817_1.state_ = "playing"
		arg_817_1.curTalkId_ = 1109305206
		arg_817_1.duration_ = 5

		SetActive(arg_817_1.tipsGo_, false)

		function arg_817_1.onSingleLineFinish_()
			arg_817_1.onSingleLineUpdate_ = nil
			arg_817_1.onSingleLineFinish_ = nil
			arg_817_1.state_ = "waiting"
		end

		function arg_817_1.playNext_(arg_819_0)
			if arg_819_0 == 1 then
				arg_817_0:Play1109305207(arg_817_1)
			end
		end

		function arg_817_1.onSingleLineUpdate_(arg_820_0)
			if 0 < arg_817_1.time_ and arg_817_1.time_ <= 0 + arg_820_0 and not isNil(arg_817_1.actors_["1093ui_story"]) and arg_817_1.var_.characterEffect1093ui_story == nil then
				arg_817_1.var_.characterEffect1093ui_story = arg_817_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_820_0 = 0.200000002980232

			if 0 <= arg_817_1.time_ and arg_817_1.time_ < 0 + var_820_0 and not isNil(arg_817_1.actors_["1093ui_story"]) then
				if arg_817_1.var_.characterEffect1093ui_story and not isNil(arg_817_1.actors_["1093ui_story"]) then
					arg_817_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_817_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_817_1.time_ - 0) / var_820_0)
				end
			end

			if arg_817_1.time_ >= 0 + var_820_0 and arg_817_1.time_ < 0 + var_820_0 + arg_820_0 and not isNil(arg_817_1.actors_["1093ui_story"]) and arg_817_1.var_.characterEffect1093ui_story then
				arg_817_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_817_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_820_1 = 0
			local var_820_2 = 0.225

			if 0 < arg_817_1.time_ and arg_817_1.time_ <= var_820_1 + arg_820_0 then
				arg_817_1.talkMaxDuration = 0
				arg_817_1.dialogCg_.alpha = 1

				arg_817_1.dialog_:SetActive(true)
				SetActive(arg_817_1.leftNameGo_, true)

				arg_817_1.leftNameTxt_.text = arg_817_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_817_1.leftNameTxt_.transform)

				arg_817_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_817_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_817_1:RecordName(arg_817_1.leftNameTxt_.text)
				SetActive(arg_817_1.iconTrs_.gameObject, true)
				arg_817_1.iconController_:SetSelectedState("hero")

				arg_817_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_817_1.callingController_:SetSelectedState("normal")

				arg_817_1.keyicon_.color = Color.New(1, 1, 1)
				arg_817_1.icon_.color = Color.New(1, 1, 1)

				local var_820_3 = arg_817_1:FormatText(arg_817_1:GetWordFromCfg(1109305206).content)

				arg_817_1.text_.text = var_820_3

				LuaForUtil.ClearLinePrefixSymbol(arg_817_1.text_)

				local var_820_5 = 9 <= 0 and var_820_2 or var_820_2 * (utf8.len(var_820_3) / 9)

				if (9 <= 0 and var_820_2 or var_820_2 * (utf8.len(var_820_3) / 9)) > 0 and var_820_2 < var_820_5 then
					arg_817_1.talkMaxDuration = var_820_5

					if var_820_5 + var_820_1 > arg_817_1.duration_ then
						arg_817_1.duration_ = var_820_5 + var_820_1
					end
				end

				arg_817_1.text_.text = var_820_3
				arg_817_1.typewritter.percent = 0

				arg_817_1.typewritter:SetDirty()
				arg_817_1:ShowNextGo(false)
				arg_817_1:RecordContent(arg_817_1.text_.text)
			end

			local var_820_6 = math.max(var_820_2, arg_817_1.talkMaxDuration)

			if var_820_1 <= arg_817_1.time_ and arg_817_1.time_ < var_820_1 + var_820_6 then
				arg_817_1.typewritter.percent = (arg_817_1.time_ - var_820_1) / var_820_6

				arg_817_1.typewritter:SetDirty()
			end

			if arg_817_1.time_ >= var_820_1 + var_820_6 and arg_817_1.time_ < var_820_1 + var_820_6 + arg_820_0 then
				arg_817_1.typewritter.percent = 1

				arg_817_1.typewritter:SetDirty()
				arg_817_1:ShowNextGo(true)
			end
		end

		arg_817_1.nodeConfigList_ = {}

		arg_817_1:InitPlayNodeList()
	end,
	Play1109305207 = function(arg_821_0, arg_821_1)
		arg_821_1.time_ = 0
		arg_821_1.frameCnt_ = 0
		arg_821_1.state_ = "playing"
		arg_821_1.curTalkId_ = 1109305207
		arg_821_1.duration_ = 1.37

		SetActive(arg_821_1.tipsGo_, false)

		function arg_821_1.onSingleLineFinish_()
			arg_821_1.onSingleLineUpdate_ = nil
			arg_821_1.onSingleLineFinish_ = nil
			arg_821_1.state_ = "waiting"
		end

		function arg_821_1.playNext_(arg_823_0)
			if arg_823_0 == 1 then
				arg_821_0:Play1109305208(arg_821_1)
			end
		end

		function arg_821_1.onSingleLineUpdate_(arg_824_0)
			if 0 < arg_821_1.time_ and arg_821_1.time_ <= 0 + arg_824_0 and not isNil(arg_821_1.actors_["1093ui_story"]) and arg_821_1.var_.characterEffect1093ui_story == nil then
				arg_821_1.var_.characterEffect1093ui_story = arg_821_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_824_0 = 0.200000002980232

			if 0 <= arg_821_1.time_ and arg_821_1.time_ < 0 + var_824_0 and not isNil(arg_821_1.actors_["1093ui_story"]) then
				if arg_821_1.var_.characterEffect1093ui_story and not isNil(arg_821_1.actors_["1093ui_story"]) then
					arg_821_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_821_1.time_ >= 0 + var_824_0 and arg_821_1.time_ < 0 + var_824_0 + arg_824_0 and not isNil(arg_821_1.actors_["1093ui_story"]) and arg_821_1.var_.characterEffect1093ui_story then
				arg_821_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_824_2 = 0
			local var_824_3 = 0.125

			if 0 < arg_821_1.time_ and arg_821_1.time_ <= var_824_2 + arg_824_0 then
				arg_821_1.talkMaxDuration = 0
				arg_821_1.dialogCg_.alpha = 1

				arg_821_1.dialog_:SetActive(true)
				SetActive(arg_821_1.leftNameGo_, true)

				arg_821_1.leftNameTxt_.text = arg_821_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_821_1.leftNameTxt_.transform)

				arg_821_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_821_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_821_1:RecordName(arg_821_1.leftNameTxt_.text)
				SetActive(arg_821_1.iconTrs_.gameObject, false)
				arg_821_1.callingController_:SetSelectedState("normal")

				local var_824_4 = arg_821_1:GetWordFromCfg(1109305207)
				local var_824_5 = arg_821_1:FormatText(var_824_4.content)

				arg_821_1.text_.text = var_824_5

				LuaForUtil.ClearLinePrefixSymbol(arg_821_1.text_)

				local var_824_7 = 5 <= 0 and var_824_3 or var_824_3 * (utf8.len(var_824_5) / 5)

				if (5 <= 0 and var_824_3 or var_824_3 * (utf8.len(var_824_5) / 5)) > 0 and var_824_3 < var_824_7 then
					arg_821_1.talkMaxDuration = var_824_7

					if var_824_7 + var_824_2 > arg_821_1.duration_ then
						arg_821_1.duration_ = var_824_7 + var_824_2
					end
				end

				arg_821_1.text_.text = var_824_5
				arg_821_1.typewritter.percent = 0

				arg_821_1.typewritter:SetDirty()
				arg_821_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305207", "story_v_side_new_1109305.awb") ~= 0 then
					local var_824_8 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305207", "story_v_side_new_1109305.awb") / 1000

					if var_824_8 + var_824_2 > arg_821_1.duration_ then
						arg_821_1.duration_ = var_824_8 + var_824_2
					end

					if var_824_4.prefab_name ~= "" and arg_821_1.actors_[var_824_4.prefab_name] ~= nil then
						local var_824_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_821_1.actors_[var_824_4.prefab_name].transform, "story_v_side_new_1109305", "1109305207", "story_v_side_new_1109305.awb")

						arg_821_1:RecordAudio("1109305207", var_824_9)
						arg_821_1:RecordAudio("1109305207", var_824_9)
					else
						arg_821_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305207", "story_v_side_new_1109305.awb")
					end

					arg_821_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305207", "story_v_side_new_1109305.awb")
				end

				arg_821_1:RecordContent(arg_821_1.text_.text)
			end

			local var_824_10 = math.max(var_824_3, arg_821_1.talkMaxDuration)

			if var_824_2 <= arg_821_1.time_ and arg_821_1.time_ < var_824_2 + var_824_10 then
				arg_821_1.typewritter.percent = (arg_821_1.time_ - var_824_2) / var_824_10

				arg_821_1.typewritter:SetDirty()
			end

			if arg_821_1.time_ >= var_824_2 + var_824_10 and arg_821_1.time_ < var_824_2 + var_824_10 + arg_824_0 then
				arg_821_1.typewritter.percent = 1

				arg_821_1.typewritter:SetDirty()
				arg_821_1:ShowNextGo(true)
			end
		end

		arg_821_1.nodeConfigList_ = {}

		arg_821_1:InitPlayNodeList()
	end,
	Play1109305208 = function(arg_825_0, arg_825_1)
		arg_825_1.time_ = 0
		arg_825_1.frameCnt_ = 0
		arg_825_1.state_ = "playing"
		arg_825_1.curTalkId_ = 1109305208
		arg_825_1.duration_ = 5

		SetActive(arg_825_1.tipsGo_, false)

		function arg_825_1.onSingleLineFinish_()
			arg_825_1.onSingleLineUpdate_ = nil
			arg_825_1.onSingleLineFinish_ = nil
			arg_825_1.state_ = "waiting"
		end

		function arg_825_1.playNext_(arg_827_0)
			if arg_827_0 == 1 then
				arg_825_0:Play1109305209(arg_825_1)
			end
		end

		function arg_825_1.onSingleLineUpdate_(arg_828_0)
			if 0 < arg_825_1.time_ and arg_825_1.time_ <= 0 + arg_828_0 and not isNil(arg_825_1.actors_["1093ui_story"]) and arg_825_1.var_.characterEffect1093ui_story == nil then
				arg_825_1.var_.characterEffect1093ui_story = arg_825_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_828_0 = 0.200000002980232

			if 0 <= arg_825_1.time_ and arg_825_1.time_ < 0 + var_828_0 and not isNil(arg_825_1.actors_["1093ui_story"]) then
				if arg_825_1.var_.characterEffect1093ui_story and not isNil(arg_825_1.actors_["1093ui_story"]) then
					arg_825_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_825_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_825_1.time_ - 0) / var_828_0)
				end
			end

			if arg_825_1.time_ >= 0 + var_828_0 and arg_825_1.time_ < 0 + var_828_0 + arg_828_0 and not isNil(arg_825_1.actors_["1093ui_story"]) and arg_825_1.var_.characterEffect1093ui_story then
				arg_825_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_825_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_828_1 = 0
			local var_828_2 = 0.825

			if 0 < arg_825_1.time_ and arg_825_1.time_ <= var_828_1 + arg_828_0 then
				arg_825_1.talkMaxDuration = 0
				arg_825_1.dialogCg_.alpha = 1

				arg_825_1.dialog_:SetActive(true)
				SetActive(arg_825_1.leftNameGo_, true)

				arg_825_1.leftNameTxt_.text = arg_825_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_825_1.leftNameTxt_.transform)

				arg_825_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_825_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_825_1:RecordName(arg_825_1.leftNameTxt_.text)
				SetActive(arg_825_1.iconTrs_.gameObject, true)
				arg_825_1.iconController_:SetSelectedState("hero")

				arg_825_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_825_1.callingController_:SetSelectedState("normal")

				arg_825_1.keyicon_.color = Color.New(1, 1, 1)
				arg_825_1.icon_.color = Color.New(1, 1, 1)

				local var_828_3 = arg_825_1:FormatText(arg_825_1:GetWordFromCfg(1109305208).content)

				arg_825_1.text_.text = var_828_3

				LuaForUtil.ClearLinePrefixSymbol(arg_825_1.text_)

				local var_828_5 = 33 <= 0 and var_828_2 or var_828_2 * (utf8.len(var_828_3) / 33)

				if (33 <= 0 and var_828_2 or var_828_2 * (utf8.len(var_828_3) / 33)) > 0 and var_828_2 < var_828_5 then
					arg_825_1.talkMaxDuration = var_828_5

					if var_828_5 + var_828_1 > arg_825_1.duration_ then
						arg_825_1.duration_ = var_828_5 + var_828_1
					end
				end

				arg_825_1.text_.text = var_828_3
				arg_825_1.typewritter.percent = 0

				arg_825_1.typewritter:SetDirty()
				arg_825_1:ShowNextGo(false)
				arg_825_1:RecordContent(arg_825_1.text_.text)
			end

			local var_828_6 = math.max(var_828_2, arg_825_1.talkMaxDuration)

			if var_828_1 <= arg_825_1.time_ and arg_825_1.time_ < var_828_1 + var_828_6 then
				arg_825_1.typewritter.percent = (arg_825_1.time_ - var_828_1) / var_828_6

				arg_825_1.typewritter:SetDirty()
			end

			if arg_825_1.time_ >= var_828_1 + var_828_6 and arg_825_1.time_ < var_828_1 + var_828_6 + arg_828_0 then
				arg_825_1.typewritter.percent = 1

				arg_825_1.typewritter:SetDirty()
				arg_825_1:ShowNextGo(true)
			end
		end

		arg_825_1.nodeConfigList_ = {}

		arg_825_1:InitPlayNodeList()
	end,
	Play1109305209 = function(arg_829_0, arg_829_1)
		arg_829_1.time_ = 0
		arg_829_1.frameCnt_ = 0
		arg_829_1.state_ = "playing"
		arg_829_1.curTalkId_ = 1109305209
		arg_829_1.duration_ = 5

		SetActive(arg_829_1.tipsGo_, false)

		function arg_829_1.onSingleLineFinish_()
			arg_829_1.onSingleLineUpdate_ = nil
			arg_829_1.onSingleLineFinish_ = nil
			arg_829_1.state_ = "waiting"
		end

		function arg_829_1.playNext_(arg_831_0)
			if arg_831_0 == 1 then
				arg_829_0:Play1109305210(arg_829_1)
			end
		end

		function arg_829_1.onSingleLineUpdate_(arg_832_0)
			local var_832_0 = 1.125

			if 0 < arg_829_1.time_ and arg_829_1.time_ <= 0 + arg_832_0 then
				arg_829_1.talkMaxDuration = 0
				arg_829_1.dialogCg_.alpha = 1

				arg_829_1.dialog_:SetActive(true)
				SetActive(arg_829_1.leftNameGo_, true)

				arg_829_1.leftNameTxt_.text = arg_829_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_829_1.leftNameTxt_.transform)

				arg_829_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_829_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_829_1:RecordName(arg_829_1.leftNameTxt_.text)
				SetActive(arg_829_1.iconTrs_.gameObject, true)
				arg_829_1.iconController_:SetSelectedState("hero")

				arg_829_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_829_1.callingController_:SetSelectedState("normal")

				arg_829_1.keyicon_.color = Color.New(1, 1, 1)
				arg_829_1.icon_.color = Color.New(1, 1, 1)

				local var_832_1 = arg_829_1:FormatText(arg_829_1:GetWordFromCfg(1109305209).content)

				arg_829_1.text_.text = var_832_1

				LuaForUtil.ClearLinePrefixSymbol(arg_829_1.text_)

				local var_832_3 = 45 <= 0 and var_832_0 or var_832_0 * (utf8.len(var_832_1) / 45)

				if (45 <= 0 and var_832_0 or var_832_0 * (utf8.len(var_832_1) / 45)) > 0 and var_832_0 < var_832_3 then
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
	Play1109305210 = function(arg_833_0, arg_833_1)
		arg_833_1.time_ = 0
		arg_833_1.frameCnt_ = 0
		arg_833_1.state_ = "playing"
		arg_833_1.curTalkId_ = 1109305210
		arg_833_1.duration_ = 7.7

		SetActive(arg_833_1.tipsGo_, false)

		function arg_833_1.onSingleLineFinish_()
			arg_833_1.onSingleLineUpdate_ = nil
			arg_833_1.onSingleLineFinish_ = nil
			arg_833_1.state_ = "waiting"
		end

		function arg_833_1.playNext_(arg_835_0)
			if arg_835_0 == 1 then
				arg_833_0:Play1109305211(arg_833_1)
			end
		end

		function arg_833_1.onSingleLineUpdate_(arg_836_0)
			if 0 < arg_833_1.time_ and arg_833_1.time_ <= 0 + arg_836_0 then
				arg_833_1.var_.moveOldPos1093ui_story = arg_833_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_836_0 = 0.001

			if 0 <= arg_833_1.time_ and arg_833_1.time_ < 0 + var_836_0 then
				arg_833_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_833_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_833_1.time_ - 0) / var_836_0)
				arg_833_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_833_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_833_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_833_1.actors_["1093ui_story"].transform.position).z)
				arg_833_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_833_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_833_1.actors_["1093ui_story"].transform.localEulerAngles = arg_833_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_833_1.time_ >= 0 + var_836_0 and arg_833_1.time_ < 0 + var_836_0 + arg_836_0 then
				arg_833_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_833_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_833_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_833_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_833_1.actors_["1093ui_story"].transform.position).z)
				arg_833_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_833_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_833_1.actors_["1093ui_story"].transform.localEulerAngles = arg_833_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_836_1 = arg_833_1.actors_["1093ui_story"]

			if 0 < arg_833_1.time_ and arg_833_1.time_ <= 0 + arg_836_0 and not isNil(var_836_1) and arg_833_1.var_.characterEffect1093ui_story == nil then
				arg_833_1.var_.characterEffect1093ui_story = var_836_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_836_2 = 0.200000002980232

			if 0 <= arg_833_1.time_ and arg_833_1.time_ < 0 + var_836_2 and not isNil(var_836_1) then
				if arg_833_1.var_.characterEffect1093ui_story and not isNil(var_836_1) then
					arg_833_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_833_1.time_ >= 0 + var_836_2 and arg_833_1.time_ < 0 + var_836_2 + arg_836_0 and not isNil(var_836_1) and arg_833_1.var_.characterEffect1093ui_story then
				arg_833_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_833_1.time_ and arg_833_1.time_ <= 0 + arg_836_0 then
				arg_833_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action7_1")
			end

			if 0 < arg_833_1.time_ and arg_833_1.time_ <= 0 + arg_836_0 then
				arg_833_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if arg_833_1.frameCnt_ <= 1 then
				arg_833_1.dialog_:SetActive(false)
			end

			local var_836_4 = 0.466666666666667
			local var_836_5 = 0.825

			if 0.466666666666667 < arg_833_1.time_ and arg_833_1.time_ <= var_836_4 + arg_836_0 then
				arg_833_1.talkMaxDuration = 0

				arg_833_1.dialog_:SetActive(true)

				arg_833_1.dialogCg_.alpha = 0

				local var_836_6 = LeanTween.value(arg_833_1.dialog_, 0, 1, 0.3)

				var_836_6:setOnUpdate(LuaHelper.FloatAction(function(arg_837_0)
					arg_833_1.dialogCg_.alpha = arg_837_0
				end))
				var_836_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_833_1.dialog_)
					var_836_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_833_1.duration_ = arg_833_1.duration_ + 0.3

				SetActive(arg_833_1.leftNameGo_, true)

				arg_833_1.leftNameTxt_.text = arg_833_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_833_1.leftNameTxt_.transform)

				arg_833_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_833_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_833_1:RecordName(arg_833_1.leftNameTxt_.text)
				SetActive(arg_833_1.iconTrs_.gameObject, false)
				arg_833_1.callingController_:SetSelectedState("normal")

				local var_836_7 = arg_833_1:GetWordFromCfg(1109305210)
				local var_836_8 = arg_833_1:FormatText(var_836_7.content)

				arg_833_1.text_.text = var_836_8

				LuaForUtil.ClearLinePrefixSymbol(arg_833_1.text_)

				local var_836_10 = 33 <= 0 and var_836_5 or var_836_5 * (utf8.len(var_836_8) / 33)

				if (33 <= 0 and var_836_5 or var_836_5 * (utf8.len(var_836_8) / 33)) > 0 and var_836_5 < var_836_10 then
					arg_833_1.talkMaxDuration = var_836_10
					var_836_4 = var_836_4 + 0.3

					if var_836_10 + var_836_4 > arg_833_1.duration_ then
						arg_833_1.duration_ = var_836_10 + var_836_4
					end
				end

				arg_833_1.text_.text = var_836_8
				arg_833_1.typewritter.percent = 0

				arg_833_1.typewritter:SetDirty()
				arg_833_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305210", "story_v_side_new_1109305.awb") ~= 0 then
					local var_836_11 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305210", "story_v_side_new_1109305.awb") / 1000

					if var_836_11 + var_836_4 > arg_833_1.duration_ then
						arg_833_1.duration_ = var_836_11 + var_836_4
					end

					if var_836_7.prefab_name ~= "" and arg_833_1.actors_[var_836_7.prefab_name] ~= nil then
						local var_836_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_833_1.actors_[var_836_7.prefab_name].transform, "story_v_side_new_1109305", "1109305210", "story_v_side_new_1109305.awb")

						arg_833_1:RecordAudio("1109305210", var_836_12)
						arg_833_1:RecordAudio("1109305210", var_836_12)
					else
						arg_833_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305210", "story_v_side_new_1109305.awb")
					end

					arg_833_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305210", "story_v_side_new_1109305.awb")
				end

				arg_833_1:RecordContent(arg_833_1.text_.text)
			end

			local var_836_13 = var_836_4 + 0.3
			local var_836_14 = math.max(var_836_5, arg_833_1.talkMaxDuration)

			if var_836_4 + 0.3 <= arg_833_1.time_ and arg_833_1.time_ < var_836_13 + var_836_14 then
				arg_833_1.typewritter.percent = (arg_833_1.time_ - var_836_13) / var_836_14

				arg_833_1.typewritter:SetDirty()
			end

			if arg_833_1.time_ >= var_836_13 + var_836_14 and arg_833_1.time_ < var_836_13 + var_836_14 + arg_836_0 then
				arg_833_1.typewritter.percent = 1

				arg_833_1.typewritter:SetDirty()
				arg_833_1:ShowNextGo(true)
			end
		end

		arg_833_1.nodeConfigList_ = {
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

		arg_833_1:InitPlayNodeList()
	end,
	Play1109305211 = function(arg_839_0, arg_839_1)
		arg_839_1.time_ = 0
		arg_839_1.frameCnt_ = 0
		arg_839_1.state_ = "playing"
		arg_839_1.curTalkId_ = 1109305211
		arg_839_1.duration_ = 5

		SetActive(arg_839_1.tipsGo_, false)

		function arg_839_1.onSingleLineFinish_()
			arg_839_1.onSingleLineUpdate_ = nil
			arg_839_1.onSingleLineFinish_ = nil
			arg_839_1.state_ = "waiting"
		end

		function arg_839_1.playNext_(arg_841_0)
			if arg_841_0 == 1 then
				arg_839_0:Play1109305212(arg_839_1)
			end
		end

		function arg_839_1.onSingleLineUpdate_(arg_842_0)
			if 0 < arg_839_1.time_ and arg_839_1.time_ <= 0 + arg_842_0 and not isNil(arg_839_1.actors_["1093ui_story"]) and arg_839_1.var_.characterEffect1093ui_story == nil then
				arg_839_1.var_.characterEffect1093ui_story = arg_839_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_842_0 = 0.200000002980232

			if 0 <= arg_839_1.time_ and arg_839_1.time_ < 0 + var_842_0 and not isNil(arg_839_1.actors_["1093ui_story"]) then
				if arg_839_1.var_.characterEffect1093ui_story and not isNil(arg_839_1.actors_["1093ui_story"]) then
					arg_839_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_839_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_839_1.time_ - 0) / var_842_0)
				end
			end

			if arg_839_1.time_ >= 0 + var_842_0 and arg_839_1.time_ < 0 + var_842_0 + arg_842_0 and not isNil(arg_839_1.actors_["1093ui_story"]) and arg_839_1.var_.characterEffect1093ui_story then
				arg_839_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_839_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_842_1 = 0
			local var_842_2 = 0.65

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

				local var_842_3 = arg_839_1:FormatText(arg_839_1:GetWordFromCfg(1109305211).content)

				arg_839_1.text_.text = var_842_3

				LuaForUtil.ClearLinePrefixSymbol(arg_839_1.text_)

				local var_842_5 = 26 <= 0 and var_842_2 or var_842_2 * (utf8.len(var_842_3) / 26)

				if (26 <= 0 and var_842_2 or var_842_2 * (utf8.len(var_842_3) / 26)) > 0 and var_842_2 < var_842_5 then
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
	Play1109305212 = function(arg_843_0, arg_843_1)
		arg_843_1.time_ = 0
		arg_843_1.frameCnt_ = 0
		arg_843_1.state_ = "playing"
		arg_843_1.curTalkId_ = 1109305212
		arg_843_1.duration_ = 5

		SetActive(arg_843_1.tipsGo_, false)

		function arg_843_1.onSingleLineFinish_()
			arg_843_1.onSingleLineUpdate_ = nil
			arg_843_1.onSingleLineFinish_ = nil
			arg_843_1.state_ = "waiting"
		end

		function arg_843_1.playNext_(arg_845_0)
			if arg_845_0 == 1 then
				arg_843_0:Play1109305213(arg_843_1)
			end
		end

		function arg_843_1.onSingleLineUpdate_(arg_846_0)
			if 0 < arg_843_1.time_ and arg_843_1.time_ <= 0 + arg_846_0 then
				arg_843_1.var_.moveOldPos1093ui_story = arg_843_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_846_0 = 0.001

			if 0 <= arg_843_1.time_ and arg_843_1.time_ < 0 + var_846_0 then
				arg_843_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_843_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_843_1.time_ - 0) / var_846_0)
				arg_843_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_843_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_843_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_843_1.actors_["1093ui_story"].transform.position).z)
				arg_843_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_843_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_843_1.actors_["1093ui_story"].transform.localEulerAngles = arg_843_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_843_1.time_ >= 0 + var_846_0 and arg_843_1.time_ < 0 + var_846_0 + arg_846_0 then
				arg_843_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_843_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_843_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_843_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_843_1.actors_["1093ui_story"].transform.position).z)
				arg_843_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_843_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_843_1.actors_["1093ui_story"].transform.localEulerAngles = arg_843_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_846_1 = 0
			local var_846_2 = 0.575

			if 0 < arg_843_1.time_ and arg_843_1.time_ <= var_846_1 + arg_846_0 then
				arg_843_1.talkMaxDuration = 0
				arg_843_1.dialogCg_.alpha = 1

				arg_843_1.dialog_:SetActive(true)
				SetActive(arg_843_1.leftNameGo_, false)

				arg_843_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_843_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_843_1:RecordName(arg_843_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_843_1.iconTrs_.gameObject, false)
				arg_843_1.callingController_:SetSelectedState("normal")

				local var_846_3 = arg_843_1:FormatText(arg_843_1:GetWordFromCfg(1109305212).content)

				arg_843_1.text_.text = var_846_3

				LuaForUtil.ClearLinePrefixSymbol(arg_843_1.text_)

				local var_846_5 = 23 <= 0 and var_846_2 or var_846_2 * (utf8.len(var_846_3) / 23)

				if (23 <= 0 and var_846_2 or var_846_2 * (utf8.len(var_846_3) / 23)) > 0 and var_846_2 < var_846_5 then
					arg_843_1.talkMaxDuration = var_846_5

					if var_846_5 + var_846_1 > arg_843_1.duration_ then
						arg_843_1.duration_ = var_846_5 + var_846_1
					end
				end

				arg_843_1.text_.text = var_846_3
				arg_843_1.typewritter.percent = 0

				arg_843_1.typewritter:SetDirty()
				arg_843_1:ShowNextGo(false)
				arg_843_1:RecordContent(arg_843_1.text_.text)
			end

			local var_846_6 = math.max(var_846_2, arg_843_1.talkMaxDuration)

			if var_846_1 <= arg_843_1.time_ and arg_843_1.time_ < var_846_1 + var_846_6 then
				arg_843_1.typewritter.percent = (arg_843_1.time_ - var_846_1) / var_846_6

				arg_843_1.typewritter:SetDirty()
			end

			if arg_843_1.time_ >= var_846_1 + var_846_6 and arg_843_1.time_ < var_846_1 + var_846_6 + arg_846_0 then
				arg_843_1.typewritter.percent = 1

				arg_843_1.typewritter:SetDirty()
				arg_843_1:ShowNextGo(true)
			end
		end

		arg_843_1.nodeConfigList_ = {
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

		arg_843_1:InitPlayNodeList()
	end,
	Play1109305213 = function(arg_847_0, arg_847_1)
		arg_847_1.time_ = 0
		arg_847_1.frameCnt_ = 0
		arg_847_1.state_ = "playing"
		arg_847_1.curTalkId_ = 1109305213
		arg_847_1.duration_ = 3.67

		SetActive(arg_847_1.tipsGo_, false)

		function arg_847_1.onSingleLineFinish_()
			arg_847_1.onSingleLineUpdate_ = nil
			arg_847_1.onSingleLineFinish_ = nil
			arg_847_1.state_ = "waiting"
		end

		function arg_847_1.playNext_(arg_849_0)
			if arg_849_0 == 1 then
				arg_847_0:Play1109305214(arg_847_1)
			end
		end

		function arg_847_1.onSingleLineUpdate_(arg_850_0)
			if 0 < arg_847_1.time_ and arg_847_1.time_ <= 0 + arg_850_0 then
				arg_847_1.var_.moveOldPos1093ui_story = arg_847_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_850_0 = 0.001

			if 0 <= arg_847_1.time_ and arg_847_1.time_ < 0 + var_850_0 then
				arg_847_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_847_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_847_1.time_ - 0) / var_850_0)
				arg_847_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_847_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_847_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_847_1.actors_["1093ui_story"].transform.position).z)
				arg_847_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_847_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_847_1.actors_["1093ui_story"].transform.localEulerAngles = arg_847_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_847_1.time_ >= 0 + var_850_0 and arg_847_1.time_ < 0 + var_850_0 + arg_850_0 then
				arg_847_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_847_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_847_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_847_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_847_1.actors_["1093ui_story"].transform.position).z)
				arg_847_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_847_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_847_1.actors_["1093ui_story"].transform.localEulerAngles = arg_847_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_850_1 = arg_847_1.actors_["1093ui_story"]

			if 0 < arg_847_1.time_ and arg_847_1.time_ <= 0 + arg_850_0 and not isNil(var_850_1) and arg_847_1.var_.characterEffect1093ui_story == nil then
				arg_847_1.var_.characterEffect1093ui_story = var_850_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_850_2 = 0.200000002980232

			if 0 <= arg_847_1.time_ and arg_847_1.time_ < 0 + var_850_2 and not isNil(var_850_1) then
				if arg_847_1.var_.characterEffect1093ui_story and not isNil(var_850_1) then
					arg_847_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_847_1.time_ >= 0 + var_850_2 and arg_847_1.time_ < 0 + var_850_2 + arg_850_0 and not isNil(var_850_1) and arg_847_1.var_.characterEffect1093ui_story then
				arg_847_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_847_1.time_ and arg_847_1.time_ <= 0 + arg_850_0 then
				arg_847_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action479")
			end

			if 0 < arg_847_1.time_ and arg_847_1.time_ <= 0 + arg_850_0 then
				arg_847_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_850_4 = 0
			local var_850_5 = 0.45

			if 0 < arg_847_1.time_ and arg_847_1.time_ <= var_850_4 + arg_850_0 then
				arg_847_1.talkMaxDuration = 0
				arg_847_1.dialogCg_.alpha = 1

				arg_847_1.dialog_:SetActive(true)
				SetActive(arg_847_1.leftNameGo_, true)

				arg_847_1.leftNameTxt_.text = arg_847_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_847_1.leftNameTxt_.transform)

				arg_847_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_847_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_847_1:RecordName(arg_847_1.leftNameTxt_.text)
				SetActive(arg_847_1.iconTrs_.gameObject, false)
				arg_847_1.callingController_:SetSelectedState("normal")

				local var_850_6 = arg_847_1:GetWordFromCfg(1109305213)
				local var_850_7 = arg_847_1:FormatText(var_850_6.content)

				arg_847_1.text_.text = var_850_7

				LuaForUtil.ClearLinePrefixSymbol(arg_847_1.text_)

				local var_850_9 = 18 <= 0 and var_850_5 or var_850_5 * (utf8.len(var_850_7) / 18)

				if (18 <= 0 and var_850_5 or var_850_5 * (utf8.len(var_850_7) / 18)) > 0 and var_850_5 < var_850_9 then
					arg_847_1.talkMaxDuration = var_850_9

					if var_850_9 + var_850_4 > arg_847_1.duration_ then
						arg_847_1.duration_ = var_850_9 + var_850_4
					end
				end

				arg_847_1.text_.text = var_850_7
				arg_847_1.typewritter.percent = 0

				arg_847_1.typewritter:SetDirty()
				arg_847_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305213", "story_v_side_new_1109305.awb") ~= 0 then
					local var_850_10 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305213", "story_v_side_new_1109305.awb") / 1000

					if var_850_10 + var_850_4 > arg_847_1.duration_ then
						arg_847_1.duration_ = var_850_10 + var_850_4
					end

					if var_850_6.prefab_name ~= "" and arg_847_1.actors_[var_850_6.prefab_name] ~= nil then
						local var_850_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_847_1.actors_[var_850_6.prefab_name].transform, "story_v_side_new_1109305", "1109305213", "story_v_side_new_1109305.awb")

						arg_847_1:RecordAudio("1109305213", var_850_11)
						arg_847_1:RecordAudio("1109305213", var_850_11)
					else
						arg_847_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305213", "story_v_side_new_1109305.awb")
					end

					arg_847_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305213", "story_v_side_new_1109305.awb")
				end

				arg_847_1:RecordContent(arg_847_1.text_.text)
			end

			local var_850_12 = math.max(var_850_5, arg_847_1.talkMaxDuration)

			if var_850_4 <= arg_847_1.time_ and arg_847_1.time_ < var_850_4 + var_850_12 then
				arg_847_1.typewritter.percent = (arg_847_1.time_ - var_850_4) / var_850_12

				arg_847_1.typewritter:SetDirty()
			end

			if arg_847_1.time_ >= var_850_4 + var_850_12 and arg_847_1.time_ < var_850_4 + var_850_12 + arg_850_0 then
				arg_847_1.typewritter.percent = 1

				arg_847_1.typewritter:SetDirty()
				arg_847_1:ShowNextGo(true)
			end
		end

		arg_847_1.nodeConfigList_ = {
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

		arg_847_1:InitPlayNodeList()
	end,
	Play1109305214 = function(arg_851_0, arg_851_1)
		arg_851_1.time_ = 0
		arg_851_1.frameCnt_ = 0
		arg_851_1.state_ = "playing"
		arg_851_1.curTalkId_ = 1109305214
		arg_851_1.duration_ = 0.8

		SetActive(arg_851_1.tipsGo_, true)

		arg_851_1.tipsText_.text = StoryTipsCfg[109301].name

		function arg_851_1.onSingleLineFinish_()
			arg_851_1.onSingleLineUpdate_ = nil
			arg_851_1.onSingleLineFinish_ = nil
			arg_851_1.state_ = "waiting"

			SetActive(arg_851_1.choicesGo_, true)

			for iter_852_0, iter_852_1 in ipairs(arg_851_1.choices_) do
				SetActive(iter_852_1.go, iter_852_0 <= 2)
			end

			arg_851_1.choices_[1].txt.text = arg_851_1:FormatText(StoryChoiceCfg[1033].name)
			arg_851_1.choices_[2].txt.text = arg_851_1:FormatText(StoryChoiceCfg[1034].name)
		end

		function arg_851_1.playNext_(arg_853_0)
			if arg_853_0 == 1 then
				arg_851_0:Play1109305215(arg_851_1)
			end

			if arg_853_0 == 2 then
				PlayerAction.UseStoryTrigger(1093013, 210930105, 1109305214, 2)
				arg_851_0:Play1109305216(arg_851_1)
			end

			arg_851_1:RecordChoiceLog(1109305214, 1033, 1034)
		end

		function arg_851_1.onSingleLineUpdate_(arg_854_0)
			if 0 < arg_851_1.time_ and arg_851_1.time_ <= 0 + arg_854_0 and not isNil(arg_851_1.actors_["1093ui_story"]) and arg_851_1.var_.characterEffect1093ui_story == nil then
				arg_851_1.var_.characterEffect1093ui_story = arg_851_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_854_0 = 0.200000002980232

			if 0 <= arg_851_1.time_ and arg_851_1.time_ < 0 + var_854_0 and not isNil(arg_851_1.actors_["1093ui_story"]) then
				if arg_851_1.var_.characterEffect1093ui_story and not isNil(arg_851_1.actors_["1093ui_story"]) then
					arg_851_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_851_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_851_1.time_ - 0) / var_854_0)
				end
			end

			if arg_851_1.time_ >= 0 + var_854_0 and arg_851_1.time_ < 0 + var_854_0 + arg_854_0 and not isNil(arg_851_1.actors_["1093ui_story"]) and arg_851_1.var_.characterEffect1093ui_story then
				arg_851_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_851_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end
		end

		arg_851_1.nodeConfigList_ = {}

		arg_851_1:InitPlayNodeList()
	end,
	Play1109305215 = function(arg_855_0, arg_855_1)
		arg_855_1.time_ = 0
		arg_855_1.frameCnt_ = 0
		arg_855_1.state_ = "playing"
		arg_855_1.curTalkId_ = 1109305215
		arg_855_1.duration_ = 4.3

		SetActive(arg_855_1.tipsGo_, false)

		function arg_855_1.onSingleLineFinish_()
			arg_855_1.onSingleLineUpdate_ = nil
			arg_855_1.onSingleLineFinish_ = nil
			arg_855_1.state_ = "waiting"
		end

		function arg_855_1.playNext_(arg_857_0)
			if arg_857_0 == 1 then
				arg_855_0:Play1109305221(arg_855_1)
			end
		end

		function arg_855_1.onSingleLineUpdate_(arg_858_0)
			if 0 < arg_855_1.time_ and arg_855_1.time_ <= 0 + arg_858_0 and not isNil(arg_855_1.actors_["1093ui_story"]) and arg_855_1.var_.characterEffect1093ui_story == nil then
				arg_855_1.var_.characterEffect1093ui_story = arg_855_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_858_0 = 0.200000002980232

			if 0 <= arg_855_1.time_ and arg_855_1.time_ < 0 + var_858_0 and not isNil(arg_855_1.actors_["1093ui_story"]) then
				if arg_855_1.var_.characterEffect1093ui_story and not isNil(arg_855_1.actors_["1093ui_story"]) then
					arg_855_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_855_1.time_ >= 0 + var_858_0 and arg_855_1.time_ < 0 + var_858_0 + arg_858_0 and not isNil(arg_855_1.actors_["1093ui_story"]) and arg_855_1.var_.characterEffect1093ui_story then
				arg_855_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_855_1.time_ and arg_855_1.time_ <= 0 + arg_858_0 then
				arg_855_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action9_2")
			end

			if 0 < arg_855_1.time_ and arg_855_1.time_ <= 0 + arg_858_0 then
				arg_855_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_858_2 = 0
			local var_858_3 = 0.45

			if 0 < arg_855_1.time_ and arg_855_1.time_ <= var_858_2 + arg_858_0 then
				arg_855_1.talkMaxDuration = 0
				arg_855_1.dialogCg_.alpha = 1

				arg_855_1.dialog_:SetActive(true)
				SetActive(arg_855_1.leftNameGo_, true)

				arg_855_1.leftNameTxt_.text = arg_855_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_855_1.leftNameTxt_.transform)

				arg_855_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_855_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_855_1:RecordName(arg_855_1.leftNameTxt_.text)
				SetActive(arg_855_1.iconTrs_.gameObject, false)
				arg_855_1.callingController_:SetSelectedState("normal")

				local var_858_4 = arg_855_1:GetWordFromCfg(1109305215)
				local var_858_5 = arg_855_1:FormatText(var_858_4.content)

				arg_855_1.text_.text = var_858_5

				LuaForUtil.ClearLinePrefixSymbol(arg_855_1.text_)

				local var_858_7 = 18 <= 0 and var_858_3 or var_858_3 * (utf8.len(var_858_5) / 18)

				if (18 <= 0 and var_858_3 or var_858_3 * (utf8.len(var_858_5) / 18)) > 0 and var_858_3 < var_858_7 then
					arg_855_1.talkMaxDuration = var_858_7

					if var_858_7 + var_858_2 > arg_855_1.duration_ then
						arg_855_1.duration_ = var_858_7 + var_858_2
					end
				end

				arg_855_1.text_.text = var_858_5
				arg_855_1.typewritter.percent = 0

				arg_855_1.typewritter:SetDirty()
				arg_855_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305215", "story_v_side_new_1109305.awb") ~= 0 then
					local var_858_8 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305215", "story_v_side_new_1109305.awb") / 1000

					if var_858_8 + var_858_2 > arg_855_1.duration_ then
						arg_855_1.duration_ = var_858_8 + var_858_2
					end

					if var_858_4.prefab_name ~= "" and arg_855_1.actors_[var_858_4.prefab_name] ~= nil then
						local var_858_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_855_1.actors_[var_858_4.prefab_name].transform, "story_v_side_new_1109305", "1109305215", "story_v_side_new_1109305.awb")

						arg_855_1:RecordAudio("1109305215", var_858_9)
						arg_855_1:RecordAudio("1109305215", var_858_9)
					else
						arg_855_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305215", "story_v_side_new_1109305.awb")
					end

					arg_855_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305215", "story_v_side_new_1109305.awb")
				end

				arg_855_1:RecordContent(arg_855_1.text_.text)
			end

			local var_858_10 = math.max(var_858_3, arg_855_1.talkMaxDuration)

			if var_858_2 <= arg_855_1.time_ and arg_855_1.time_ < var_858_2 + var_858_10 then
				arg_855_1.typewritter.percent = (arg_855_1.time_ - var_858_2) / var_858_10

				arg_855_1.typewritter:SetDirty()
			end

			if arg_855_1.time_ >= var_858_2 + var_858_10 and arg_855_1.time_ < var_858_2 + var_858_10 + arg_858_0 then
				arg_855_1.typewritter.percent = 1

				arg_855_1.typewritter:SetDirty()
				arg_855_1:ShowNextGo(true)
			end
		end

		arg_855_1.nodeConfigList_ = {}

		arg_855_1:InitPlayNodeList()
	end,
	Play1109305221 = function(arg_859_0, arg_859_1)
		arg_859_1.time_ = 0
		arg_859_1.frameCnt_ = 0
		arg_859_1.state_ = "playing"
		arg_859_1.curTalkId_ = 1109305221
		arg_859_1.duration_ = 6.83

		SetActive(arg_859_1.tipsGo_, false)

		function arg_859_1.onSingleLineFinish_()
			arg_859_1.onSingleLineUpdate_ = nil
			arg_859_1.onSingleLineFinish_ = nil
			arg_859_1.state_ = "waiting"
			arg_859_1.auto_ = false
		end

		function arg_859_1.playNext_(arg_861_0)
			arg_859_1.onStoryFinished_()
		end

		function arg_859_1.onSingleLineUpdate_(arg_862_0)
			if 0 < arg_859_1.time_ and arg_859_1.time_ <= 0 + arg_862_0 then
				arg_859_1.var_.moveOldPos1093ui_story = arg_859_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_862_0 = 0.001

			if 0 <= arg_859_1.time_ and arg_859_1.time_ < 0 + var_862_0 then
				arg_859_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_859_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_859_1.time_ - 0) / var_862_0)
				arg_859_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_859_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_859_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_859_1.actors_["1093ui_story"].transform.position).z)
				arg_859_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_859_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_859_1.actors_["1093ui_story"].transform.localEulerAngles = arg_859_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_859_1.time_ >= 0 + var_862_0 and arg_859_1.time_ < 0 + var_862_0 + arg_862_0 then
				arg_859_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_859_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_859_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_859_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_859_1.actors_["1093ui_story"].transform.position).z)
				arg_859_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_859_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_859_1.actors_["1093ui_story"].transform.localEulerAngles = arg_859_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_862_1 = arg_859_1.actors_["1093ui_story"]

			if 1.133333333332 < arg_859_1.time_ and arg_859_1.time_ <= 1.133333333332 + arg_862_0 and not isNil(var_862_1) and arg_859_1.var_.characterEffect1093ui_story == nil then
				arg_859_1.var_.characterEffect1093ui_story = var_862_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_862_2 = 0.200000002980232

			if 1.133333333332 <= arg_859_1.time_ and arg_859_1.time_ < 1.133333333332 + var_862_2 and not isNil(var_862_1) then
				if arg_859_1.var_.characterEffect1093ui_story and not isNil(var_862_1) then
					arg_859_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_859_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_859_1.time_ - 1.133333333332) / var_862_2)
				end
			end

			if arg_859_1.time_ >= 1.133333333332 + var_862_2 and arg_859_1.time_ < 1.133333333332 + var_862_2 + arg_862_0 and not isNil(var_862_1) and arg_859_1.var_.characterEffect1093ui_story then
				arg_859_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_859_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_862_3 = 0

			if 0 < arg_859_1.time_ and arg_859_1.time_ <= var_862_3 + arg_862_0 then
				arg_859_1.mask_.enabled = true
				arg_859_1.mask_.raycastTarget = true

				arg_859_1:SetGaussion(false)
			end

			local var_862_4 = 1.13333333333333

			if var_862_3 <= arg_859_1.time_ and arg_859_1.time_ < var_862_3 + var_862_4 then
				local var_862_5 = Color.New(1, 1, 1)

				var_862_5.a = Mathf.Lerp(0, 1, (arg_859_1.time_ - var_862_3) / var_862_4)
				arg_859_1.mask_.color = var_862_5
			end

			if arg_859_1.time_ >= var_862_3 + var_862_4 and arg_859_1.time_ < var_862_3 + var_862_4 + arg_862_0 then
				local var_862_6 = Color.New(1, 1, 1)

				var_862_6.a = 1
				arg_859_1.mask_.color = var_862_6
			end

			local var_862_7 = 1.13333333333333

			if 1.13333333333333 < arg_859_1.time_ and arg_859_1.time_ <= var_862_7 + arg_862_0 then
				arg_859_1.mask_.enabled = true
				arg_859_1.mask_.raycastTarget = true

				arg_859_1:SetGaussion(false)
			end

			local var_862_8 = 0.633333333333333

			if var_862_7 <= arg_859_1.time_ and arg_859_1.time_ < var_862_7 + var_862_8 then
				local var_862_9 = Color.New(1, 1, 1)

				var_862_9.a = Mathf.Lerp(1, 0, (arg_859_1.time_ - var_862_7) / var_862_8)
				arg_859_1.mask_.color = var_862_9
			end

			if arg_859_1.time_ >= var_862_7 + var_862_8 and arg_859_1.time_ < var_862_7 + var_862_8 + arg_862_0 then
				local var_862_10 = Color.New(1, 1, 1)

				arg_859_1.mask_.enabled = false
				var_862_10.a = 0
				arg_859_1.mask_.color = var_862_10
			end

			if 1.13333333333333 < arg_859_1.time_ and arg_859_1.time_ <= 1.13333333333333 + arg_862_0 then
				local var_862_11 = arg_859_1.bgs_.STblack

				arg_859_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_862_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_862_12 = var_862_11:GetComponent("SpriteRenderer")

				if var_862_12 and var_862_12.sprite then
					local var_862_13 = 2 * (var_862_11.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_862_11.transform.localScale = Vector3.New(var_862_13 / var_862_12.sprite.bounds.size.y < var_862_13 * manager.ui.mainCameraCom_.aspect / var_862_12.sprite.bounds.size.x and var_862_13 * manager.ui.mainCameraCom_.aspect / var_862_12.sprite.bounds.size.x or var_862_13 / var_862_12.sprite.bounds.size.y, var_862_13 / var_862_12.sprite.bounds.size.y < var_862_13 * manager.ui.mainCameraCom_.aspect / var_862_12.sprite.bounds.size.x and var_862_13 * manager.ui.mainCameraCom_.aspect / var_862_12.sprite.bounds.size.x or var_862_13 / var_862_12.sprite.bounds.size.y, 0)
				end

				for iter_862_0, iter_862_1 in pairs(arg_859_1.bgs_) do
					if iter_862_0 ~= "STblack" then
						iter_862_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_862_14

			if 1.133333333332 < arg_859_1.time_ and arg_859_1.time_ <= 1.133333333332 + arg_862_0 then
				local var_862_15 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_862_15 then
					var_862_15.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_862_15.radialBlurScale = 0
					var_862_15.radialBlurGradient = 1
					var_862_15.radialBlurIntensity = 0.457

					if var_862_14 then
						var_862_15.radialBlurTarget = var_862_14.transform
					end
				end
			end

			local var_862_16 = 0.100000000001333

			if 1.133333333332 <= arg_859_1.time_ and arg_859_1.time_ < 1.133333333332 + var_862_16 then
				local var_862_17 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_862_17 then
					var_862_17.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_862_17.radialBlurScale = Mathf.Lerp(0, 0, (arg_859_1.time_ - 1.133333333332) / var_862_16)
					var_862_17.radialBlurGradient = Mathf.Lerp(1, 0.675, (arg_859_1.time_ - 1.133333333332) / var_862_16)
					var_862_17.radialBlurIntensity = Mathf.Lerp(0.457, 1, (arg_859_1.time_ - 1.133333333332) / var_862_16)
				end
			end

			if arg_859_1.time_ >= 1.133333333332 + var_862_16 and arg_859_1.time_ < 1.133333333332 + var_862_16 + arg_862_0 then
				local var_862_18 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_862_18 then
					var_862_18.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_862_18.radialBlurScale = 0
					var_862_18.radialBlurGradient = 0.675
					var_862_18.radialBlurIntensity = 1
				end
			end

			if arg_859_1.frameCnt_ <= 1 then
				arg_859_1.dialog_:SetActive(false)
			end

			local var_862_19 = 1.83333333333333
			local var_862_20 = 0.05

			if 1.83333333333333 < arg_859_1.time_ and arg_859_1.time_ <= var_862_19 + arg_862_0 then
				arg_859_1.talkMaxDuration = 0

				arg_859_1.dialog_:SetActive(true)

				arg_859_1.dialogCg_.alpha = 0

				local var_862_21 = LeanTween.value(arg_859_1.dialog_, 0, 1, 0.3)

				var_862_21:setOnUpdate(LuaHelper.FloatAction(function(arg_863_0)
					arg_859_1.dialogCg_.alpha = arg_863_0
				end))
				var_862_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_859_1.dialog_)
					var_862_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_859_1.duration_ = arg_859_1.duration_ + 0.3

				SetActive(arg_859_1.leftNameGo_, false)

				arg_859_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_859_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_859_1:RecordName(arg_859_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_859_1.iconTrs_.gameObject, false)
				arg_859_1.callingController_:SetSelectedState("normal")

				local var_862_22 = arg_859_1:FormatText(arg_859_1:GetWordFromCfg(1109305221).content)

				arg_859_1.text_.text = var_862_22

				LuaForUtil.ClearLinePrefixSymbol(arg_859_1.text_)

				local var_862_24 = 2 <= 0 and var_862_20 or var_862_20 * (utf8.len(var_862_22) / 2)

				if (2 <= 0 and var_862_20 or var_862_20 * (utf8.len(var_862_22) / 2)) > 0 and var_862_20 < var_862_24 then
					arg_859_1.talkMaxDuration = var_862_24
					var_862_19 = var_862_19 + 0.3

					if var_862_24 + var_862_19 > arg_859_1.duration_ then
						arg_859_1.duration_ = var_862_24 + var_862_19
					end
				end

				arg_859_1.text_.text = var_862_22
				arg_859_1.typewritter.percent = 0

				arg_859_1.typewritter:SetDirty()
				arg_859_1:ShowNextGo(false)
				arg_859_1:RecordContent(arg_859_1.text_.text)
			end

			local var_862_25 = var_862_19 + 0.3
			local var_862_26 = math.max(var_862_20, arg_859_1.talkMaxDuration)

			if var_862_19 + 0.3 <= arg_859_1.time_ and arg_859_1.time_ < var_862_25 + var_862_26 then
				arg_859_1.typewritter.percent = (arg_859_1.time_ - var_862_25) / var_862_26

				arg_859_1.typewritter:SetDirty()
			end

			if arg_859_1.time_ >= var_862_25 + var_862_26 and arg_859_1.time_ < var_862_25 + var_862_26 + arg_862_0 then
				arg_859_1.typewritter.percent = 1

				arg_859_1.typewritter:SetDirty()
				arg_859_1:ShowNextGo(true)
			end
		end

		arg_859_1.nodeConfigList_ = {
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

		arg_859_1:InitPlayNodeList()
	end,
	Play1109305216 = function(arg_865_0, arg_865_1)
		arg_865_1.time_ = 0
		arg_865_1.frameCnt_ = 0
		arg_865_1.state_ = "playing"
		arg_865_1.curTalkId_ = 1109305216
		arg_865_1.duration_ = 6.27

		SetActive(arg_865_1.tipsGo_, false)

		function arg_865_1.onSingleLineFinish_()
			arg_865_1.onSingleLineUpdate_ = nil
			arg_865_1.onSingleLineFinish_ = nil
			arg_865_1.state_ = "waiting"
		end

		function arg_865_1.playNext_(arg_867_0)
			if arg_867_0 == 1 then
				arg_865_0:Play1109305217(arg_865_1)
			end
		end

		function arg_865_1.onSingleLineUpdate_(arg_868_0)
			if 0 < arg_865_1.time_ and arg_865_1.time_ <= 0 + arg_868_0 then
				arg_865_1.var_.moveOldPos1093ui_story = arg_865_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_868_0 = 0.001

			if 0 <= arg_865_1.time_ and arg_865_1.time_ < 0 + var_868_0 then
				arg_865_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_865_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_865_1.time_ - 0) / var_868_0)
				arg_865_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_865_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_865_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_865_1.actors_["1093ui_story"].transform.position).z)
				arg_865_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_865_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_865_1.actors_["1093ui_story"].transform.localEulerAngles = arg_865_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_865_1.time_ >= 0 + var_868_0 and arg_865_1.time_ < 0 + var_868_0 + arg_868_0 then
				arg_865_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_865_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_865_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_865_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_865_1.actors_["1093ui_story"].transform.position).z)
				arg_865_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_865_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_865_1.actors_["1093ui_story"].transform.localEulerAngles = arg_865_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_868_1 = arg_865_1.actors_["1093ui_story"]

			if 0 < arg_865_1.time_ and arg_865_1.time_ <= 0 + arg_868_0 and not isNil(var_868_1) and arg_865_1.var_.characterEffect1093ui_story == nil then
				arg_865_1.var_.characterEffect1093ui_story = var_868_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_868_2 = 0.200000002980232

			if 0 <= arg_865_1.time_ and arg_865_1.time_ < 0 + var_868_2 and not isNil(var_868_1) then
				if arg_865_1.var_.characterEffect1093ui_story and not isNil(var_868_1) then
					arg_865_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_865_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_865_1.time_ - 0) / var_868_2)
				end
			end

			if arg_865_1.time_ >= 0 + var_868_2 and arg_865_1.time_ < 0 + var_868_2 + arg_868_0 and not isNil(var_868_1) and arg_865_1.var_.characterEffect1093ui_story then
				arg_865_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_865_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_868_3

			if 0 < arg_865_1.time_ and arg_865_1.time_ <= 0 + arg_868_0 then
				local var_868_4 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_868_4 then
					var_868_4.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_868_4.radialBlurScale = 0
					var_868_4.radialBlurGradient = 1
					var_868_4.radialBlurIntensity = 0.457

					if var_868_3 then
						var_868_4.radialBlurTarget = var_868_3.transform
					end
				end
			end

			local var_868_5 = 1.56666666666667

			if 0 <= arg_865_1.time_ and arg_865_1.time_ < 0 + var_868_5 then
				local var_868_6 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_868_6 then
					var_868_6.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_868_6.radialBlurScale = Mathf.Lerp(0, 0, (arg_865_1.time_ - 0) / var_868_5)
					var_868_6.radialBlurGradient = Mathf.Lerp(1, 0.675, (arg_865_1.time_ - 0) / var_868_5)
					var_868_6.radialBlurIntensity = Mathf.Lerp(0.457, 1, (arg_865_1.time_ - 0) / var_868_5)
				end
			end

			if arg_865_1.time_ >= 0 + var_868_5 and arg_865_1.time_ < 0 + var_868_5 + arg_868_0 then
				local var_868_7 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_868_7 then
					var_868_7.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_868_7.radialBlurScale = 0
					var_868_7.radialBlurGradient = 0.675
					var_868_7.radialBlurIntensity = 1
				end
			end

			if arg_865_1.frameCnt_ <= 1 then
				arg_865_1.dialog_:SetActive(false)
			end

			local var_868_8 = 1.26666666666667
			local var_868_9 = 0.8

			if 1.26666666666667 < arg_865_1.time_ and arg_865_1.time_ <= var_868_8 + arg_868_0 then
				arg_865_1.talkMaxDuration = 0

				arg_865_1.dialog_:SetActive(true)

				arg_865_1.dialogCg_.alpha = 0

				local var_868_10 = LeanTween.value(arg_865_1.dialog_, 0, 1, 0.3)

				var_868_10:setOnUpdate(LuaHelper.FloatAction(function(arg_869_0)
					arg_865_1.dialogCg_.alpha = arg_869_0
				end))
				var_868_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_865_1.dialog_)
					var_868_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_865_1.duration_ = arg_865_1.duration_ + 0.3

				SetActive(arg_865_1.leftNameGo_, false)

				arg_865_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_865_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_865_1:RecordName(arg_865_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_865_1.iconTrs_.gameObject, false)
				arg_865_1.callingController_:SetSelectedState("normal")

				local var_868_11 = arg_865_1:FormatText(arg_865_1:GetWordFromCfg(1109305216).content)

				arg_865_1.text_.text = var_868_11

				LuaForUtil.ClearLinePrefixSymbol(arg_865_1.text_)

				local var_868_13 = 32 <= 0 and var_868_9 or var_868_9 * (utf8.len(var_868_11) / 32)

				if (32 <= 0 and var_868_9 or var_868_9 * (utf8.len(var_868_11) / 32)) > 0 and var_868_9 < var_868_13 then
					arg_865_1.talkMaxDuration = var_868_13
					var_868_8 = var_868_8 + 0.3

					if var_868_13 + var_868_8 > arg_865_1.duration_ then
						arg_865_1.duration_ = var_868_13 + var_868_8
					end
				end

				arg_865_1.text_.text = var_868_11
				arg_865_1.typewritter.percent = 0

				arg_865_1.typewritter:SetDirty()
				arg_865_1:ShowNextGo(false)
				arg_865_1:RecordContent(arg_865_1.text_.text)
			end

			local var_868_14 = var_868_8 + 0.3
			local var_868_15 = math.max(var_868_9, arg_865_1.talkMaxDuration)

			if var_868_8 + 0.3 <= arg_865_1.time_ and arg_865_1.time_ < var_868_14 + var_868_15 then
				arg_865_1.typewritter.percent = (arg_865_1.time_ - var_868_14) / var_868_15

				arg_865_1.typewritter:SetDirty()
			end

			if arg_865_1.time_ >= var_868_14 + var_868_15 and arg_865_1.time_ < var_868_14 + var_868_15 + arg_868_0 then
				arg_865_1.typewritter.percent = 1

				arg_865_1.typewritter:SetDirty()
				arg_865_1:ShowNextGo(true)
			end
		end

		arg_865_1.nodeConfigList_ = {
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

		arg_865_1:InitPlayNodeList()
	end,
	Play1109305217 = function(arg_871_0, arg_871_1)
		arg_871_1.time_ = 0
		arg_871_1.frameCnt_ = 0
		arg_871_1.state_ = "playing"
		arg_871_1.curTalkId_ = 1109305217
		arg_871_1.duration_ = 5.3

		SetActive(arg_871_1.tipsGo_, false)

		function arg_871_1.onSingleLineFinish_()
			arg_871_1.onSingleLineUpdate_ = nil
			arg_871_1.onSingleLineFinish_ = nil
			arg_871_1.state_ = "waiting"
		end

		function arg_871_1.playNext_(arg_873_0)
			if arg_873_0 == 1 then
				arg_871_0:Play1109305218(arg_871_1)
			end
		end

		function arg_871_1.onSingleLineUpdate_(arg_874_0)
			local var_874_0 = 0.225

			if 0 < arg_871_1.time_ and arg_871_1.time_ <= 0 + arg_874_0 then
				arg_871_1.talkMaxDuration = 0
				arg_871_1.dialogCg_.alpha = 1

				arg_871_1.dialog_:SetActive(true)
				SetActive(arg_871_1.leftNameGo_, true)

				arg_871_1.leftNameTxt_.text = arg_871_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_871_1.leftNameTxt_.transform)

				arg_871_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_871_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_871_1:RecordName(arg_871_1.leftNameTxt_.text)
				SetActive(arg_871_1.iconTrs_.gameObject, true)
				arg_871_1.iconController_:SetSelectedState("hero")

				arg_871_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_871_1.callingController_:SetSelectedState("normal")

				arg_871_1.keyicon_.color = Color.New(1, 1, 1)
				arg_871_1.icon_.color = Color.New(1, 1, 1)

				local var_874_1 = arg_871_1:GetWordFromCfg(1109305217)
				local var_874_2 = arg_871_1:FormatText(var_874_1.content)

				arg_871_1.text_.text = var_874_2

				LuaForUtil.ClearLinePrefixSymbol(arg_871_1.text_)

				local var_874_4 = 9 <= 0 and var_874_0 or var_874_0 * (utf8.len(var_874_2) / 9)

				if (9 <= 0 and var_874_0 or var_874_0 * (utf8.len(var_874_2) / 9)) > 0 and var_874_0 < var_874_4 then
					arg_871_1.talkMaxDuration = var_874_4

					if var_874_4 + 0 > arg_871_1.duration_ then
						arg_871_1.duration_ = var_874_4 + 0
					end
				end

				arg_871_1.text_.text = var_874_2
				arg_871_1.typewritter.percent = 0

				arg_871_1.typewritter:SetDirty()
				arg_871_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305217", "story_v_side_new_1109305.awb") ~= 0 then
					local var_874_5 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305217", "story_v_side_new_1109305.awb") / 1000

					if var_874_5 + 0 > arg_871_1.duration_ then
						arg_871_1.duration_ = var_874_5 + 0
					end

					if var_874_1.prefab_name ~= "" and arg_871_1.actors_[var_874_1.prefab_name] ~= nil then
						local var_874_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_871_1.actors_[var_874_1.prefab_name].transform, "story_v_side_new_1109305", "1109305217", "story_v_side_new_1109305.awb")

						arg_871_1:RecordAudio("1109305217", var_874_6)
						arg_871_1:RecordAudio("1109305217", var_874_6)
					else
						arg_871_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305217", "story_v_side_new_1109305.awb")
					end

					arg_871_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305217", "story_v_side_new_1109305.awb")
				end

				arg_871_1:RecordContent(arg_871_1.text_.text)
			end

			local var_874_7 = math.max(var_874_0, arg_871_1.talkMaxDuration)

			if 0 <= arg_871_1.time_ and arg_871_1.time_ < 0 + var_874_7 then
				arg_871_1.typewritter.percent = (arg_871_1.time_ - 0) / var_874_7

				arg_871_1.typewritter:SetDirty()
			end

			if arg_871_1.time_ >= 0 + var_874_7 and arg_871_1.time_ < 0 + var_874_7 + arg_874_0 then
				arg_871_1.typewritter.percent = 1

				arg_871_1.typewritter:SetDirty()
				arg_871_1:ShowNextGo(true)
			end
		end

		arg_871_1.nodeConfigList_ = {}

		arg_871_1:InitPlayNodeList()
	end,
	Play1109305218 = function(arg_875_0, arg_875_1)
		arg_875_1.time_ = 0
		arg_875_1.frameCnt_ = 0
		arg_875_1.state_ = "playing"
		arg_875_1.curTalkId_ = 1109305218
		arg_875_1.duration_ = 5

		SetActive(arg_875_1.tipsGo_, false)

		function arg_875_1.onSingleLineFinish_()
			arg_875_1.onSingleLineUpdate_ = nil
			arg_875_1.onSingleLineFinish_ = nil
			arg_875_1.state_ = "waiting"
		end

		function arg_875_1.playNext_(arg_877_0)
			if arg_877_0 == 1 then
				arg_875_0:Play1109305219(arg_875_1)
			end
		end

		function arg_875_1.onSingleLineUpdate_(arg_878_0)
			local var_878_0 = 0.275

			if 0 < arg_875_1.time_ and arg_875_1.time_ <= 0 + arg_878_0 then
				arg_875_1.talkMaxDuration = 0
				arg_875_1.dialogCg_.alpha = 1

				arg_875_1.dialog_:SetActive(true)
				SetActive(arg_875_1.leftNameGo_, true)

				arg_875_1.leftNameTxt_.text = arg_875_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_875_1.leftNameTxt_.transform)

				arg_875_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_875_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_875_1:RecordName(arg_875_1.leftNameTxt_.text)
				SetActive(arg_875_1.iconTrs_.gameObject, true)
				arg_875_1.iconController_:SetSelectedState("hero")

				arg_875_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_875_1.callingController_:SetSelectedState("normal")

				arg_875_1.keyicon_.color = Color.New(1, 1, 1)
				arg_875_1.icon_.color = Color.New(1, 1, 1)

				local var_878_1 = arg_875_1:FormatText(arg_875_1:GetWordFromCfg(1109305218).content)

				arg_875_1.text_.text = var_878_1

				LuaForUtil.ClearLinePrefixSymbol(arg_875_1.text_)

				local var_878_3 = 11 <= 0 and var_878_0 or var_878_0 * (utf8.len(var_878_1) / 11)

				if (11 <= 0 and var_878_0 or var_878_0 * (utf8.len(var_878_1) / 11)) > 0 and var_878_0 < var_878_3 then
					arg_875_1.talkMaxDuration = var_878_3

					if var_878_3 + 0 > arg_875_1.duration_ then
						arg_875_1.duration_ = var_878_3 + 0
					end
				end

				arg_875_1.text_.text = var_878_1
				arg_875_1.typewritter.percent = 0

				arg_875_1.typewritter:SetDirty()
				arg_875_1:ShowNextGo(false)
				arg_875_1:RecordContent(arg_875_1.text_.text)
			end

			local var_878_4 = math.max(var_878_0, arg_875_1.talkMaxDuration)

			if 0 <= arg_875_1.time_ and arg_875_1.time_ < 0 + var_878_4 then
				arg_875_1.typewritter.percent = (arg_875_1.time_ - 0) / var_878_4

				arg_875_1.typewritter:SetDirty()
			end

			if arg_875_1.time_ >= 0 + var_878_4 and arg_875_1.time_ < 0 + var_878_4 + arg_878_0 then
				arg_875_1.typewritter.percent = 1

				arg_875_1.typewritter:SetDirty()
				arg_875_1:ShowNextGo(true)
			end
		end

		arg_875_1.nodeConfigList_ = {}

		arg_875_1:InitPlayNodeList()
	end,
	Play1109305219 = function(arg_879_0, arg_879_1)
		arg_879_1.time_ = 0
		arg_879_1.frameCnt_ = 0
		arg_879_1.state_ = "playing"
		arg_879_1.curTalkId_ = 1109305219
		arg_879_1.duration_ = 2.47

		SetActive(arg_879_1.tipsGo_, false)

		function arg_879_1.onSingleLineFinish_()
			arg_879_1.onSingleLineUpdate_ = nil
			arg_879_1.onSingleLineFinish_ = nil
			arg_879_1.state_ = "waiting"
		end

		function arg_879_1.playNext_(arg_881_0)
			if arg_881_0 == 1 then
				arg_879_0:Play1109305220(arg_879_1)
			end
		end

		function arg_879_1.onSingleLineUpdate_(arg_882_0)
			local var_882_0 = 0.275

			if 0 < arg_879_1.time_ and arg_879_1.time_ <= 0 + arg_882_0 then
				arg_879_1.talkMaxDuration = 0
				arg_879_1.dialogCg_.alpha = 1

				arg_879_1.dialog_:SetActive(true)
				SetActive(arg_879_1.leftNameGo_, true)

				arg_879_1.leftNameTxt_.text = arg_879_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_879_1.leftNameTxt_.transform)

				arg_879_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_879_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_879_1:RecordName(arg_879_1.leftNameTxt_.text)
				SetActive(arg_879_1.iconTrs_.gameObject, true)
				arg_879_1.iconController_:SetSelectedState("hero")

				arg_879_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_879_1.callingController_:SetSelectedState("normal")

				arg_879_1.keyicon_.color = Color.New(1, 1, 1)
				arg_879_1.icon_.color = Color.New(1, 1, 1)

				local var_882_1 = arg_879_1:GetWordFromCfg(1109305219)
				local var_882_2 = arg_879_1:FormatText(var_882_1.content)

				arg_879_1.text_.text = var_882_2

				LuaForUtil.ClearLinePrefixSymbol(arg_879_1.text_)

				local var_882_4 = 11 <= 0 and var_882_0 or var_882_0 * (utf8.len(var_882_2) / 11)

				if (11 <= 0 and var_882_0 or var_882_0 * (utf8.len(var_882_2) / 11)) > 0 and var_882_0 < var_882_4 then
					arg_879_1.talkMaxDuration = var_882_4

					if var_882_4 + 0 > arg_879_1.duration_ then
						arg_879_1.duration_ = var_882_4 + 0
					end
				end

				arg_879_1.text_.text = var_882_2
				arg_879_1.typewritter.percent = 0

				arg_879_1.typewritter:SetDirty()
				arg_879_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305219", "story_v_side_new_1109305.awb") ~= 0 then
					local var_882_5 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305219", "story_v_side_new_1109305.awb") / 1000

					if var_882_5 + 0 > arg_879_1.duration_ then
						arg_879_1.duration_ = var_882_5 + 0
					end

					if var_882_1.prefab_name ~= "" and arg_879_1.actors_[var_882_1.prefab_name] ~= nil then
						local var_882_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_879_1.actors_[var_882_1.prefab_name].transform, "story_v_side_new_1109305", "1109305219", "story_v_side_new_1109305.awb")

						arg_879_1:RecordAudio("1109305219", var_882_6)
						arg_879_1:RecordAudio("1109305219", var_882_6)
					else
						arg_879_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305219", "story_v_side_new_1109305.awb")
					end

					arg_879_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305219", "story_v_side_new_1109305.awb")
				end

				arg_879_1:RecordContent(arg_879_1.text_.text)
			end

			local var_882_7 = math.max(var_882_0, arg_879_1.talkMaxDuration)

			if 0 <= arg_879_1.time_ and arg_879_1.time_ < 0 + var_882_7 then
				arg_879_1.typewritter.percent = (arg_879_1.time_ - 0) / var_882_7

				arg_879_1.typewritter:SetDirty()
			end

			if arg_879_1.time_ >= 0 + var_882_7 and arg_879_1.time_ < 0 + var_882_7 + arg_882_0 then
				arg_879_1.typewritter.percent = 1

				arg_879_1.typewritter:SetDirty()
				arg_879_1:ShowNextGo(true)
			end
		end

		arg_879_1.nodeConfigList_ = {}

		arg_879_1:InitPlayNodeList()
	end,
	Play1109305220 = function(arg_883_0, arg_883_1)
		arg_883_1.time_ = 0
		arg_883_1.frameCnt_ = 0
		arg_883_1.state_ = "playing"
		arg_883_1.curTalkId_ = 1109305220
		arg_883_1.duration_ = 5

		SetActive(arg_883_1.tipsGo_, false)

		function arg_883_1.onSingleLineFinish_()
			arg_883_1.onSingleLineUpdate_ = nil
			arg_883_1.onSingleLineFinish_ = nil
			arg_883_1.state_ = "waiting"
		end

		function arg_883_1.playNext_(arg_885_0)
			if arg_885_0 == 1 then
				arg_883_0:Play1109305221(arg_883_1)
			end
		end

		function arg_883_1.onSingleLineUpdate_(arg_886_0)
			local var_886_0 = 0.425

			if 0 < arg_883_1.time_ and arg_883_1.time_ <= 0 + arg_886_0 then
				arg_883_1.talkMaxDuration = 0
				arg_883_1.dialogCg_.alpha = 1

				arg_883_1.dialog_:SetActive(true)
				SetActive(arg_883_1.leftNameGo_, true)

				arg_883_1.leftNameTxt_.text = arg_883_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_883_1.leftNameTxt_.transform)

				arg_883_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_883_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_883_1:RecordName(arg_883_1.leftNameTxt_.text)
				SetActive(arg_883_1.iconTrs_.gameObject, true)
				arg_883_1.iconController_:SetSelectedState("hero")

				arg_883_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_883_1.callingController_:SetSelectedState("normal")

				arg_883_1.keyicon_.color = Color.New(1, 1, 1)
				arg_883_1.icon_.color = Color.New(1, 1, 1)

				local var_886_1 = arg_883_1:FormatText(arg_883_1:GetWordFromCfg(1109305220).content)

				arg_883_1.text_.text = var_886_1

				LuaForUtil.ClearLinePrefixSymbol(arg_883_1.text_)

				local var_886_3 = 17 <= 0 and var_886_0 or var_886_0 * (utf8.len(var_886_1) / 17)

				if (17 <= 0 and var_886_0 or var_886_0 * (utf8.len(var_886_1) / 17)) > 0 and var_886_0 < var_886_3 then
					arg_883_1.talkMaxDuration = var_886_3

					if var_886_3 + 0 > arg_883_1.duration_ then
						arg_883_1.duration_ = var_886_3 + 0
					end
				end

				arg_883_1.text_.text = var_886_1
				arg_883_1.typewritter.percent = 0

				arg_883_1.typewritter:SetDirty()
				arg_883_1:ShowNextGo(false)
				arg_883_1:RecordContent(arg_883_1.text_.text)
			end

			local var_886_4 = math.max(var_886_0, arg_883_1.talkMaxDuration)

			if 0 <= arg_883_1.time_ and arg_883_1.time_ < 0 + var_886_4 then
				arg_883_1.typewritter.percent = (arg_883_1.time_ - 0) / var_886_4

				arg_883_1.typewritter:SetDirty()
			end

			if arg_883_1.time_ >= 0 + var_886_4 and arg_883_1.time_ < 0 + var_886_4 + arg_886_0 then
				arg_883_1.typewritter.percent = 1

				arg_883_1.typewritter:SetDirty()
				arg_883_1:ShowNextGo(true)
			end
		end

		arg_883_1.nodeConfigList_ = {}

		arg_883_1:InitPlayNodeList()
	end,
	Play1109305082 = function(arg_887_0, arg_887_1)
		arg_887_1.time_ = 0
		arg_887_1.frameCnt_ = 0
		arg_887_1.state_ = "playing"
		arg_887_1.curTalkId_ = 1109305082
		arg_887_1.duration_ = 4.07

		SetActive(arg_887_1.tipsGo_, false)

		function arg_887_1.onSingleLineFinish_()
			arg_887_1.onSingleLineUpdate_ = nil
			arg_887_1.onSingleLineFinish_ = nil
			arg_887_1.state_ = "waiting"
		end

		function arg_887_1.playNext_(arg_889_0)
			if arg_889_0 == 1 then
				arg_887_0:Play1109305083(arg_887_1)
			end
		end

		function arg_887_1.onSingleLineUpdate_(arg_890_0)
			if 0 < arg_887_1.time_ and arg_887_1.time_ <= 0 + arg_890_0 then
				arg_887_1.var_.moveOldPos1093ui_story = arg_887_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_890_0 = 0.001

			if 0 <= arg_887_1.time_ and arg_887_1.time_ < 0 + var_890_0 then
				arg_887_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_887_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_887_1.time_ - 0) / var_890_0)
				arg_887_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_887_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_887_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_887_1.actors_["1093ui_story"].transform.position).z)
				arg_887_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_887_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_887_1.actors_["1093ui_story"].transform.localEulerAngles = arg_887_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_887_1.time_ >= 0 + var_890_0 and arg_887_1.time_ < 0 + var_890_0 + arg_890_0 then
				arg_887_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_887_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_887_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_887_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_887_1.actors_["1093ui_story"].transform.position).z)
				arg_887_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_887_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_887_1.actors_["1093ui_story"].transform.localEulerAngles = arg_887_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_890_1 = arg_887_1.actors_["1093ui_story"]

			if 0 < arg_887_1.time_ and arg_887_1.time_ <= 0 + arg_890_0 and not isNil(var_890_1) and arg_887_1.var_.characterEffect1093ui_story == nil then
				arg_887_1.var_.characterEffect1093ui_story = var_890_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_890_2 = 0.200000002980232

			if 0 <= arg_887_1.time_ and arg_887_1.time_ < 0 + var_890_2 and not isNil(var_890_1) then
				if arg_887_1.var_.characterEffect1093ui_story and not isNil(var_890_1) then
					arg_887_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_887_1.time_ >= 0 + var_890_2 and arg_887_1.time_ < 0 + var_890_2 + arg_890_0 and not isNil(var_890_1) and arg_887_1.var_.characterEffect1093ui_story then
				arg_887_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_890_4 = 0
			local var_890_5 = 0.425

			if 0 < arg_887_1.time_ and arg_887_1.time_ <= var_890_4 + arg_890_0 then
				arg_887_1.talkMaxDuration = 0
				arg_887_1.dialogCg_.alpha = 1

				arg_887_1.dialog_:SetActive(true)
				SetActive(arg_887_1.leftNameGo_, true)

				arg_887_1.leftNameTxt_.text = arg_887_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_887_1.leftNameTxt_.transform)

				arg_887_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_887_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_887_1:RecordName(arg_887_1.leftNameTxt_.text)
				SetActive(arg_887_1.iconTrs_.gameObject, false)
				arg_887_1.callingController_:SetSelectedState("normal")

				local var_890_6 = arg_887_1:GetWordFromCfg(1109305082)
				local var_890_7 = arg_887_1:FormatText(var_890_6.content)

				arg_887_1.text_.text = var_890_7

				LuaForUtil.ClearLinePrefixSymbol(arg_887_1.text_)

				local var_890_9 = 17 <= 0 and var_890_5 or var_890_5 * (utf8.len(var_890_7) / 17)

				if (17 <= 0 and var_890_5 or var_890_5 * (utf8.len(var_890_7) / 17)) > 0 and var_890_5 < var_890_9 then
					arg_887_1.talkMaxDuration = var_890_9

					if var_890_9 + var_890_4 > arg_887_1.duration_ then
						arg_887_1.duration_ = var_890_9 + var_890_4
					end
				end

				arg_887_1.text_.text = var_890_7
				arg_887_1.typewritter.percent = 0

				arg_887_1.typewritter:SetDirty()
				arg_887_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305082", "story_v_side_new_1109305.awb") ~= 0 then
					local var_890_10 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305082", "story_v_side_new_1109305.awb") / 1000

					if var_890_10 + var_890_4 > arg_887_1.duration_ then
						arg_887_1.duration_ = var_890_10 + var_890_4
					end

					if var_890_6.prefab_name ~= "" and arg_887_1.actors_[var_890_6.prefab_name] ~= nil then
						local var_890_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_887_1.actors_[var_890_6.prefab_name].transform, "story_v_side_new_1109305", "1109305082", "story_v_side_new_1109305.awb")

						arg_887_1:RecordAudio("1109305082", var_890_11)
						arg_887_1:RecordAudio("1109305082", var_890_11)
					else
						arg_887_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305082", "story_v_side_new_1109305.awb")
					end

					arg_887_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305082", "story_v_side_new_1109305.awb")
				end

				arg_887_1:RecordContent(arg_887_1.text_.text)
			end

			local var_890_12 = math.max(var_890_5, arg_887_1.talkMaxDuration)

			if var_890_4 <= arg_887_1.time_ and arg_887_1.time_ < var_890_4 + var_890_12 then
				arg_887_1.typewritter.percent = (arg_887_1.time_ - var_890_4) / var_890_12

				arg_887_1.typewritter:SetDirty()
			end

			if arg_887_1.time_ >= var_890_4 + var_890_12 and arg_887_1.time_ < var_890_4 + var_890_12 + arg_890_0 then
				arg_887_1.typewritter.percent = 1

				arg_887_1.typewritter:SetDirty()
				arg_887_1:ShowNextGo(true)
			end
		end

		arg_887_1.nodeConfigList_ = {
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

		arg_887_1:InitPlayNodeList()
	end,
	Play1109305083 = function(arg_891_0, arg_891_1)
		arg_891_1.time_ = 0
		arg_891_1.frameCnt_ = 0
		arg_891_1.state_ = "playing"
		arg_891_1.curTalkId_ = 1109305083
		arg_891_1.duration_ = 5

		SetActive(arg_891_1.tipsGo_, false)

		function arg_891_1.onSingleLineFinish_()
			arg_891_1.onSingleLineUpdate_ = nil
			arg_891_1.onSingleLineFinish_ = nil
			arg_891_1.state_ = "waiting"
		end

		function arg_891_1.playNext_(arg_893_0)
			if arg_893_0 == 1 then
				arg_891_0:Play1109305084(arg_891_1)
			end
		end

		function arg_891_1.onSingleLineUpdate_(arg_894_0)
			if 0 < arg_891_1.time_ and arg_891_1.time_ <= 0 + arg_894_0 and not isNil(arg_891_1.actors_["1093ui_story"]) and arg_891_1.var_.characterEffect1093ui_story == nil then
				arg_891_1.var_.characterEffect1093ui_story = arg_891_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_894_0 = 0.200000002980232

			if 0 <= arg_891_1.time_ and arg_891_1.time_ < 0 + var_894_0 and not isNil(arg_891_1.actors_["1093ui_story"]) then
				if arg_891_1.var_.characterEffect1093ui_story and not isNil(arg_891_1.actors_["1093ui_story"]) then
					arg_891_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_891_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_891_1.time_ - 0) / var_894_0)
				end
			end

			if arg_891_1.time_ >= 0 + var_894_0 and arg_891_1.time_ < 0 + var_894_0 + arg_894_0 and not isNil(arg_891_1.actors_["1093ui_story"]) and arg_891_1.var_.characterEffect1093ui_story then
				arg_891_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_891_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_894_1 = 0
			local var_894_2 = 0.3

			if 0 < arg_891_1.time_ and arg_891_1.time_ <= var_894_1 + arg_894_0 then
				arg_891_1.talkMaxDuration = 0
				arg_891_1.dialogCg_.alpha = 1

				arg_891_1.dialog_:SetActive(true)
				SetActive(arg_891_1.leftNameGo_, true)

				arg_891_1.leftNameTxt_.text = arg_891_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_891_1.leftNameTxt_.transform)

				arg_891_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_891_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_891_1:RecordName(arg_891_1.leftNameTxt_.text)
				SetActive(arg_891_1.iconTrs_.gameObject, true)
				arg_891_1.iconController_:SetSelectedState("hero")

				arg_891_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_891_1.callingController_:SetSelectedState("normal")

				arg_891_1.keyicon_.color = Color.New(1, 1, 1)
				arg_891_1.icon_.color = Color.New(1, 1, 1)

				local var_894_3 = arg_891_1:FormatText(arg_891_1:GetWordFromCfg(1109305083).content)

				arg_891_1.text_.text = var_894_3

				LuaForUtil.ClearLinePrefixSymbol(arg_891_1.text_)

				local var_894_5 = 12 <= 0 and var_894_2 or var_894_2 * (utf8.len(var_894_3) / 12)

				if (12 <= 0 and var_894_2 or var_894_2 * (utf8.len(var_894_3) / 12)) > 0 and var_894_2 < var_894_5 then
					arg_891_1.talkMaxDuration = var_894_5

					if var_894_5 + var_894_1 > arg_891_1.duration_ then
						arg_891_1.duration_ = var_894_5 + var_894_1
					end
				end

				arg_891_1.text_.text = var_894_3
				arg_891_1.typewritter.percent = 0

				arg_891_1.typewritter:SetDirty()
				arg_891_1:ShowNextGo(false)
				arg_891_1:RecordContent(arg_891_1.text_.text)
			end

			local var_894_6 = math.max(var_894_2, arg_891_1.talkMaxDuration)

			if var_894_1 <= arg_891_1.time_ and arg_891_1.time_ < var_894_1 + var_894_6 then
				arg_891_1.typewritter.percent = (arg_891_1.time_ - var_894_1) / var_894_6

				arg_891_1.typewritter:SetDirty()
			end

			if arg_891_1.time_ >= var_894_1 + var_894_6 and arg_891_1.time_ < var_894_1 + var_894_6 + arg_894_0 then
				arg_891_1.typewritter.percent = 1

				arg_891_1.typewritter:SetDirty()
				arg_891_1:ShowNextGo(true)
			end
		end

		arg_891_1.nodeConfigList_ = {}

		arg_891_1:InitPlayNodeList()
	end,
	Play1109305084 = function(arg_895_0, arg_895_1)
		arg_895_1.time_ = 0
		arg_895_1.frameCnt_ = 0
		arg_895_1.state_ = "playing"
		arg_895_1.curTalkId_ = 1109305084
		arg_895_1.duration_ = 3.73

		SetActive(arg_895_1.tipsGo_, false)

		function arg_895_1.onSingleLineFinish_()
			arg_895_1.onSingleLineUpdate_ = nil
			arg_895_1.onSingleLineFinish_ = nil
			arg_895_1.state_ = "waiting"
		end

		function arg_895_1.playNext_(arg_897_0)
			if arg_897_0 == 1 then
				arg_895_0:Play1109305085(arg_895_1)
			end
		end

		function arg_895_1.onSingleLineUpdate_(arg_898_0)
			if 0 < arg_895_1.time_ and arg_895_1.time_ <= 0 + arg_898_0 and not isNil(arg_895_1.actors_["1093ui_story"]) and arg_895_1.var_.characterEffect1093ui_story == nil then
				arg_895_1.var_.characterEffect1093ui_story = arg_895_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_898_0 = 0.200000002980232

			if 0 <= arg_895_1.time_ and arg_895_1.time_ < 0 + var_898_0 and not isNil(arg_895_1.actors_["1093ui_story"]) then
				if arg_895_1.var_.characterEffect1093ui_story and not isNil(arg_895_1.actors_["1093ui_story"]) then
					arg_895_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_895_1.time_ >= 0 + var_898_0 and arg_895_1.time_ < 0 + var_898_0 + arg_898_0 and not isNil(arg_895_1.actors_["1093ui_story"]) and arg_895_1.var_.characterEffect1093ui_story then
				arg_895_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_898_2 = 0
			local var_898_3 = 0.425

			if 0 < arg_895_1.time_ and arg_895_1.time_ <= var_898_2 + arg_898_0 then
				arg_895_1.talkMaxDuration = 0
				arg_895_1.dialogCg_.alpha = 1

				arg_895_1.dialog_:SetActive(true)
				SetActive(arg_895_1.leftNameGo_, true)

				arg_895_1.leftNameTxt_.text = arg_895_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_895_1.leftNameTxt_.transform)

				arg_895_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_895_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_895_1:RecordName(arg_895_1.leftNameTxt_.text)
				SetActive(arg_895_1.iconTrs_.gameObject, false)
				arg_895_1.callingController_:SetSelectedState("normal")

				local var_898_4 = arg_895_1:GetWordFromCfg(1109305084)
				local var_898_5 = arg_895_1:FormatText(var_898_4.content)

				arg_895_1.text_.text = var_898_5

				LuaForUtil.ClearLinePrefixSymbol(arg_895_1.text_)

				local var_898_7 = 17 <= 0 and var_898_3 or var_898_3 * (utf8.len(var_898_5) / 17)

				if (17 <= 0 and var_898_3 or var_898_3 * (utf8.len(var_898_5) / 17)) > 0 and var_898_3 < var_898_7 then
					arg_895_1.talkMaxDuration = var_898_7

					if var_898_7 + var_898_2 > arg_895_1.duration_ then
						arg_895_1.duration_ = var_898_7 + var_898_2
					end
				end

				arg_895_1.text_.text = var_898_5
				arg_895_1.typewritter.percent = 0

				arg_895_1.typewritter:SetDirty()
				arg_895_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305084", "story_v_side_new_1109305.awb") ~= 0 then
					local var_898_8 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305084", "story_v_side_new_1109305.awb") / 1000

					if var_898_8 + var_898_2 > arg_895_1.duration_ then
						arg_895_1.duration_ = var_898_8 + var_898_2
					end

					if var_898_4.prefab_name ~= "" and arg_895_1.actors_[var_898_4.prefab_name] ~= nil then
						local var_898_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_895_1.actors_[var_898_4.prefab_name].transform, "story_v_side_new_1109305", "1109305084", "story_v_side_new_1109305.awb")

						arg_895_1:RecordAudio("1109305084", var_898_9)
						arg_895_1:RecordAudio("1109305084", var_898_9)
					else
						arg_895_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305084", "story_v_side_new_1109305.awb")
					end

					arg_895_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305084", "story_v_side_new_1109305.awb")
				end

				arg_895_1:RecordContent(arg_895_1.text_.text)
			end

			local var_898_10 = math.max(var_898_3, arg_895_1.talkMaxDuration)

			if var_898_2 <= arg_895_1.time_ and arg_895_1.time_ < var_898_2 + var_898_10 then
				arg_895_1.typewritter.percent = (arg_895_1.time_ - var_898_2) / var_898_10

				arg_895_1.typewritter:SetDirty()
			end

			if arg_895_1.time_ >= var_898_2 + var_898_10 and arg_895_1.time_ < var_898_2 + var_898_10 + arg_898_0 then
				arg_895_1.typewritter.percent = 1

				arg_895_1.typewritter:SetDirty()
				arg_895_1:ShowNextGo(true)
			end
		end

		arg_895_1.nodeConfigList_ = {}

		arg_895_1:InitPlayNodeList()
	end,
	Play1109305085 = function(arg_899_0, arg_899_1)
		arg_899_1.time_ = 0
		arg_899_1.frameCnt_ = 0
		arg_899_1.state_ = "playing"
		arg_899_1.curTalkId_ = 1109305085
		arg_899_1.duration_ = 5

		SetActive(arg_899_1.tipsGo_, false)

		function arg_899_1.onSingleLineFinish_()
			arg_899_1.onSingleLineUpdate_ = nil
			arg_899_1.onSingleLineFinish_ = nil
			arg_899_1.state_ = "waiting"
		end

		function arg_899_1.playNext_(arg_901_0)
			if arg_901_0 == 1 then
				arg_899_0:Play1109305086(arg_899_1)
			end
		end

		function arg_899_1.onSingleLineUpdate_(arg_902_0)
			if 0 < arg_899_1.time_ and arg_899_1.time_ <= 0 + arg_902_0 and not isNil(arg_899_1.actors_["1093ui_story"]) and arg_899_1.var_.characterEffect1093ui_story == nil then
				arg_899_1.var_.characterEffect1093ui_story = arg_899_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_902_0 = 0.200000002980232

			if 0 <= arg_899_1.time_ and arg_899_1.time_ < 0 + var_902_0 and not isNil(arg_899_1.actors_["1093ui_story"]) then
				if arg_899_1.var_.characterEffect1093ui_story and not isNil(arg_899_1.actors_["1093ui_story"]) then
					arg_899_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_899_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_899_1.time_ - 0) / var_902_0)
				end
			end

			if arg_899_1.time_ >= 0 + var_902_0 and arg_899_1.time_ < 0 + var_902_0 + arg_902_0 and not isNil(arg_899_1.actors_["1093ui_story"]) and arg_899_1.var_.characterEffect1093ui_story then
				arg_899_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_899_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_902_1 = 0
			local var_902_2 = 0.875

			if 0 < arg_899_1.time_ and arg_899_1.time_ <= var_902_1 + arg_902_0 then
				arg_899_1.talkMaxDuration = 0
				arg_899_1.dialogCg_.alpha = 1

				arg_899_1.dialog_:SetActive(true)
				SetActive(arg_899_1.leftNameGo_, true)

				arg_899_1.leftNameTxt_.text = arg_899_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_899_1.leftNameTxt_.transform)

				arg_899_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_899_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_899_1:RecordName(arg_899_1.leftNameTxt_.text)
				SetActive(arg_899_1.iconTrs_.gameObject, true)
				arg_899_1.iconController_:SetSelectedState("hero")

				arg_899_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_899_1.callingController_:SetSelectedState("normal")

				arg_899_1.keyicon_.color = Color.New(1, 1, 1)
				arg_899_1.icon_.color = Color.New(1, 1, 1)

				local var_902_3 = arg_899_1:FormatText(arg_899_1:GetWordFromCfg(1109305085).content)

				arg_899_1.text_.text = var_902_3

				LuaForUtil.ClearLinePrefixSymbol(arg_899_1.text_)

				local var_902_5 = 35 <= 0 and var_902_2 or var_902_2 * (utf8.len(var_902_3) / 35)

				if (35 <= 0 and var_902_2 or var_902_2 * (utf8.len(var_902_3) / 35)) > 0 and var_902_2 < var_902_5 then
					arg_899_1.talkMaxDuration = var_902_5

					if var_902_5 + var_902_1 > arg_899_1.duration_ then
						arg_899_1.duration_ = var_902_5 + var_902_1
					end
				end

				arg_899_1.text_.text = var_902_3
				arg_899_1.typewritter.percent = 0

				arg_899_1.typewritter:SetDirty()
				arg_899_1:ShowNextGo(false)
				arg_899_1:RecordContent(arg_899_1.text_.text)
			end

			local var_902_6 = math.max(var_902_2, arg_899_1.talkMaxDuration)

			if var_902_1 <= arg_899_1.time_ and arg_899_1.time_ < var_902_1 + var_902_6 then
				arg_899_1.typewritter.percent = (arg_899_1.time_ - var_902_1) / var_902_6

				arg_899_1.typewritter:SetDirty()
			end

			if arg_899_1.time_ >= var_902_1 + var_902_6 and arg_899_1.time_ < var_902_1 + var_902_6 + arg_902_0 then
				arg_899_1.typewritter.percent = 1

				arg_899_1.typewritter:SetDirty()
				arg_899_1:ShowNextGo(true)
			end
		end

		arg_899_1.nodeConfigList_ = {}

		arg_899_1:InitPlayNodeList()
	end,
	Play1109305086 = function(arg_903_0, arg_903_1)
		arg_903_1.time_ = 0
		arg_903_1.frameCnt_ = 0
		arg_903_1.state_ = "playing"
		arg_903_1.curTalkId_ = 1109305086
		arg_903_1.duration_ = 5.4

		SetActive(arg_903_1.tipsGo_, false)

		function arg_903_1.onSingleLineFinish_()
			arg_903_1.onSingleLineUpdate_ = nil
			arg_903_1.onSingleLineFinish_ = nil
			arg_903_1.state_ = "waiting"
		end

		function arg_903_1.playNext_(arg_905_0)
			if arg_905_0 == 1 then
				arg_903_0:Play1109305087(arg_903_1)
			end
		end

		function arg_903_1.onSingleLineUpdate_(arg_906_0)
			if 0 < arg_903_1.time_ and arg_903_1.time_ <= 0 + arg_906_0 then
				arg_903_1.var_.moveOldPos1093ui_story = arg_903_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_906_0 = 0.001

			if 0 <= arg_903_1.time_ and arg_903_1.time_ < 0 + var_906_0 then
				arg_903_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_903_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_903_1.time_ - 0) / var_906_0)
				arg_903_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_903_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_903_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_903_1.actors_["1093ui_story"].transform.position).z)
				arg_903_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_903_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_903_1.actors_["1093ui_story"].transform.localEulerAngles = arg_903_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_903_1.time_ >= 0 + var_906_0 and arg_903_1.time_ < 0 + var_906_0 + arg_906_0 then
				arg_903_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_903_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_903_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_903_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_903_1.actors_["1093ui_story"].transform.position).z)
				arg_903_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_903_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_903_1.actors_["1093ui_story"].transform.localEulerAngles = arg_903_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_906_1 = arg_903_1.actors_["1093ui_story"]

			if 0 < arg_903_1.time_ and arg_903_1.time_ <= 0 + arg_906_0 and not isNil(var_906_1) and arg_903_1.var_.characterEffect1093ui_story == nil then
				arg_903_1.var_.characterEffect1093ui_story = var_906_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_906_2 = 0.200000002980232

			if 0 <= arg_903_1.time_ and arg_903_1.time_ < 0 + var_906_2 and not isNil(var_906_1) then
				if arg_903_1.var_.characterEffect1093ui_story and not isNil(var_906_1) then
					arg_903_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_903_1.time_ >= 0 + var_906_2 and arg_903_1.time_ < 0 + var_906_2 + arg_906_0 and not isNil(var_906_1) and arg_903_1.var_.characterEffect1093ui_story then
				arg_903_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_903_1.time_ and arg_903_1.time_ <= 0 + arg_906_0 then
				arg_903_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_906_4 = 0
			local var_906_5 = 0.45

			if 0 < arg_903_1.time_ and arg_903_1.time_ <= var_906_4 + arg_906_0 then
				arg_903_1.talkMaxDuration = 0
				arg_903_1.dialogCg_.alpha = 1

				arg_903_1.dialog_:SetActive(true)
				SetActive(arg_903_1.leftNameGo_, true)

				arg_903_1.leftNameTxt_.text = arg_903_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_903_1.leftNameTxt_.transform)

				arg_903_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_903_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_903_1:RecordName(arg_903_1.leftNameTxt_.text)
				SetActive(arg_903_1.iconTrs_.gameObject, false)
				arg_903_1.callingController_:SetSelectedState("normal")

				local var_906_6 = arg_903_1:GetWordFromCfg(1109305086)
				local var_906_7 = arg_903_1:FormatText(var_906_6.content)

				arg_903_1.text_.text = var_906_7

				LuaForUtil.ClearLinePrefixSymbol(arg_903_1.text_)

				local var_906_9 = 18 <= 0 and var_906_5 or var_906_5 * (utf8.len(var_906_7) / 18)

				if (18 <= 0 and var_906_5 or var_906_5 * (utf8.len(var_906_7) / 18)) > 0 and var_906_5 < var_906_9 then
					arg_903_1.talkMaxDuration = var_906_9

					if var_906_9 + var_906_4 > arg_903_1.duration_ then
						arg_903_1.duration_ = var_906_9 + var_906_4
					end
				end

				arg_903_1.text_.text = var_906_7
				arg_903_1.typewritter.percent = 0

				arg_903_1.typewritter:SetDirty()
				arg_903_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305086", "story_v_side_new_1109305.awb") ~= 0 then
					local var_906_10 = manager.audio:GetVoiceLength("story_v_side_new_1109305", "1109305086", "story_v_side_new_1109305.awb") / 1000

					if var_906_10 + var_906_4 > arg_903_1.duration_ then
						arg_903_1.duration_ = var_906_10 + var_906_4
					end

					if var_906_6.prefab_name ~= "" and arg_903_1.actors_[var_906_6.prefab_name] ~= nil then
						local var_906_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_903_1.actors_[var_906_6.prefab_name].transform, "story_v_side_new_1109305", "1109305086", "story_v_side_new_1109305.awb")

						arg_903_1:RecordAudio("1109305086", var_906_11)
						arg_903_1:RecordAudio("1109305086", var_906_11)
					else
						arg_903_1:AudioAction("play", "voice", "story_v_side_new_1109305", "1109305086", "story_v_side_new_1109305.awb")
					end

					arg_903_1:RecordHistoryTalkVoice("story_v_side_new_1109305", "1109305086", "story_v_side_new_1109305.awb")
				end

				arg_903_1:RecordContent(arg_903_1.text_.text)
			end

			local var_906_12 = math.max(var_906_5, arg_903_1.talkMaxDuration)

			if var_906_4 <= arg_903_1.time_ and arg_903_1.time_ < var_906_4 + var_906_12 then
				arg_903_1.typewritter.percent = (arg_903_1.time_ - var_906_4) / var_906_12

				arg_903_1.typewritter:SetDirty()
			end

			if arg_903_1.time_ >= var_906_4 + var_906_12 and arg_903_1.time_ < var_906_4 + var_906_12 + arg_906_0 then
				arg_903_1.typewritter.percent = 1

				arg_903_1.typewritter:SetDirty()
				arg_903_1:ShowNextGo(true)
			end
		end

		arg_903_1.nodeConfigList_ = {
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

		arg_903_1:InitPlayNodeList()
	end,
	Play1109305087 = function(arg_907_0, arg_907_1)
		arg_907_1.time_ = 0
		arg_907_1.frameCnt_ = 0
		arg_907_1.state_ = "playing"
		arg_907_1.curTalkId_ = 1109305087
		arg_907_1.duration_ = 5

		SetActive(arg_907_1.tipsGo_, false)

		function arg_907_1.onSingleLineFinish_()
			arg_907_1.onSingleLineUpdate_ = nil
			arg_907_1.onSingleLineFinish_ = nil
			arg_907_1.state_ = "waiting"
		end

		function arg_907_1.playNext_(arg_909_0)
			if arg_909_0 == 1 then
				arg_907_0:Play1109305088(arg_907_1)
			end
		end

		function arg_907_1.onSingleLineUpdate_(arg_910_0)
			if 0 < arg_907_1.time_ and arg_907_1.time_ <= 0 + arg_910_0 and not isNil(arg_907_1.actors_["1093ui_story"]) and arg_907_1.var_.characterEffect1093ui_story == nil then
				arg_907_1.var_.characterEffect1093ui_story = arg_907_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_910_0 = 0.200000002980232

			if 0 <= arg_907_1.time_ and arg_907_1.time_ < 0 + var_910_0 and not isNil(arg_907_1.actors_["1093ui_story"]) then
				if arg_907_1.var_.characterEffect1093ui_story and not isNil(arg_907_1.actors_["1093ui_story"]) then
					arg_907_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_907_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_907_1.time_ - 0) / var_910_0)
				end
			end

			if arg_907_1.time_ >= 0 + var_910_0 and arg_907_1.time_ < 0 + var_910_0 + arg_910_0 and not isNil(arg_907_1.actors_["1093ui_story"]) and arg_907_1.var_.characterEffect1093ui_story then
				arg_907_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_907_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_910_1 = 0
			local var_910_2 = 0.375

			if 0 < arg_907_1.time_ and arg_907_1.time_ <= var_910_1 + arg_910_0 then
				arg_907_1.talkMaxDuration = 0
				arg_907_1.dialogCg_.alpha = 1

				arg_907_1.dialog_:SetActive(true)
				SetActive(arg_907_1.leftNameGo_, true)

				arg_907_1.leftNameTxt_.text = arg_907_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_907_1.leftNameTxt_.transform)

				arg_907_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_907_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_907_1:RecordName(arg_907_1.leftNameTxt_.text)
				SetActive(arg_907_1.iconTrs_.gameObject, true)
				arg_907_1.iconController_:SetSelectedState("hero")

				arg_907_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_907_1.callingController_:SetSelectedState("normal")

				arg_907_1.keyicon_.color = Color.New(1, 1, 1)
				arg_907_1.icon_.color = Color.New(1, 1, 1)

				local var_910_3 = arg_907_1:FormatText(arg_907_1:GetWordFromCfg(1109305087).content)

				arg_907_1.text_.text = var_910_3

				LuaForUtil.ClearLinePrefixSymbol(arg_907_1.text_)

				local var_910_5 = 15 <= 0 and var_910_2 or var_910_2 * (utf8.len(var_910_3) / 15)

				if (15 <= 0 and var_910_2 or var_910_2 * (utf8.len(var_910_3) / 15)) > 0 and var_910_2 < var_910_5 then
					arg_907_1.talkMaxDuration = var_910_5

					if var_910_5 + var_910_1 > arg_907_1.duration_ then
						arg_907_1.duration_ = var_910_5 + var_910_1
					end
				end

				arg_907_1.text_.text = var_910_3
				arg_907_1.typewritter.percent = 0

				arg_907_1.typewritter:SetDirty()
				arg_907_1:ShowNextGo(false)
				arg_907_1:RecordContent(arg_907_1.text_.text)
			end

			local var_910_6 = math.max(var_910_2, arg_907_1.talkMaxDuration)

			if var_910_1 <= arg_907_1.time_ and arg_907_1.time_ < var_910_1 + var_910_6 then
				arg_907_1.typewritter.percent = (arg_907_1.time_ - var_910_1) / var_910_6

				arg_907_1.typewritter:SetDirty()
			end

			if arg_907_1.time_ >= var_910_1 + var_910_6 and arg_907_1.time_ < var_910_1 + var_910_6 + arg_910_0 then
				arg_907_1.typewritter.percent = 1

				arg_907_1.typewritter:SetDirty()
				arg_907_1:ShowNextGo(true)
			end
		end

		arg_907_1.nodeConfigList_ = {}

		arg_907_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST06b",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST02",
		"TextureConfig/Background/ST06"
	},
	voices = {
		"story_v_side_new_1109305.awb"
	}
}
