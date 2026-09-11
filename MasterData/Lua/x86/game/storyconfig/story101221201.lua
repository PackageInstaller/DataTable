return {
	Play122121001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 122121001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play122121002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST12 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST12")
				var_4_0.name = "ST12"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST12 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST12

				arg_1_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST12" then
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

			if 1.46666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.46666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_office", "bgm_story_office", "bgm_story_office.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

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
			local var_4_15 = 0.2

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

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(122121001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 8 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 8)

				if (8 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 8)) > 0 and var_4_15 < var_4_19 then
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
	Play122121002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 122121002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play122121003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.7

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(122121002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 28 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 28)

				if (28 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 28)) > 0 and var_12_0 < var_12_3 then
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
	Play122121003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 122121003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play122121004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 1.725

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(122121003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 69 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 69)

				if (69 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 69)) > 0 and var_16_0 < var_16_3 then
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
	Play122121004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 122121004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play122121005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.85

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

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(122121004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 34 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 34)

				if (34 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 34)) > 0 and var_20_0 < var_20_3 then
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
	Play122121005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 122121005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play122121006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_24_0 = 1

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				local var_24_1, var_24_2 = math.modf((arg_21_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_24_2 * 0.13, var_24_2 * 0.13, var_24_2 * 0.13) + arg_21_1.var_.shakeOldPos
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				manager.ui.mainCamera.transform.localPosition = arg_21_1.var_.shakeOldPos
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:AudioAction("play", "effect", "se_story_122_02", "se_story_122_02_table", "")
			end

			local var_24_4 = 0
			local var_24_5 = 0.9

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
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

				local var_24_6 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(122121005).content)

				arg_21_1.text_.text = var_24_6

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_8 = 36 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_6) / 36)

				if (36 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_6) / 36)) > 0 and var_24_5 < var_24_8 then
					arg_21_1.talkMaxDuration = var_24_8

					if var_24_8 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_6
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_9 = math.max(var_24_5, arg_21_1.talkMaxDuration)

			if var_24_4 <= arg_21_1.time_ and arg_21_1.time_ < var_24_4 + var_24_9 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_4) / var_24_9

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_4 + var_24_9 and arg_21_1.time_ < var_24_4 + var_24_9 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play122121006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 122121006
		arg_25_1.duration_ = 5.43

		local var_25_0 = {
			ja = 5.433,
			ko = 3.1,
			zh = 3.1
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play122121007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_28_0 = 0.6

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				local var_28_1, var_28_2 = math.modf((arg_25_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_28_2 * 0.13, var_28_2 * 0.13, var_28_2 * 0.13) + arg_25_1.var_.shakeOldPos
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				manager.ui.mainCamera.transform.localPosition = arg_25_1.var_.shakeOldPos
			end

			local var_28_3 = 0

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_3 + arg_28_0 then
				arg_25_1.allBtn_.enabled = false
			end

			if arg_25_1.time_ >= var_28_3 + 0.6 and arg_25_1.time_ < var_28_3 + 0.6 + arg_28_0 then
				arg_25_1.allBtn_.enabled = true
			end

			local var_28_4 = 0
			local var_28_5 = 0.2

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
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

				local var_28_6 = arg_25_1:GetWordFromCfg(122121006)
				local var_28_7 = arg_25_1:FormatText(var_28_6.content)

				arg_25_1.text_.text = var_28_7

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_9 = 8 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 8)

				if (8 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 8)) > 0 and var_28_5 < var_28_9 then
					arg_25_1.talkMaxDuration = var_28_9

					if var_28_9 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_4
					end
				end

				arg_25_1.text_.text = var_28_7
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121006", "story_v_out_122121.awb") ~= 0 then
					local var_28_10 = manager.audio:GetVoiceLength("story_v_out_122121", "122121006", "story_v_out_122121.awb") / 1000

					if var_28_10 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_4
					end

					if var_28_6.prefab_name ~= "" and arg_25_1.actors_[var_28_6.prefab_name] ~= nil then
						local var_28_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_6.prefab_name].transform, "story_v_out_122121", "122121006", "story_v_out_122121.awb")

						arg_25_1:RecordAudio("122121006", var_28_11)
						arg_25_1:RecordAudio("122121006", var_28_11)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_122121", "122121006", "story_v_out_122121.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_122121", "122121006", "story_v_out_122121.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_12 = math.max(var_28_5, arg_25_1.talkMaxDuration)

			if var_28_4 <= arg_25_1.time_ and arg_25_1.time_ < var_28_4 + var_28_12 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_4) / var_28_12

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_4 + var_28_12 and arg_25_1.time_ < var_28_4 + var_28_12 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play122121007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 122121007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play122121008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_32_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_29_1.stage_.transform)

				var_32_0.name = "1084ui_story"
				var_32_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.actors_["1084ui_story"] = var_32_0

				local var_32_1 = var_32_0:GetComponentInChildren(typeof(CharacterEffect))

				var_32_1.enabled = true

				local var_32_2 = GameObjectTools.GetOrAddComponent(var_32_0, typeof(DynamicBoneHelper))

				if var_32_2 then
					var_32_2:EnableDynamicBone(false)
				end

				arg_29_1:ShowWeapon(var_32_1.transform, false)

				arg_29_1.var_["1084ui_story" .. "Animator"] = var_32_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_29_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_29_1.var_["1084ui_story" .. "LipSync"] = var_32_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_32_3 = arg_29_1.actors_["1084ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1084ui_story = var_32_3.localPosition
			end

			local var_32_4 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				var_32_3.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_29_1.time_ - 0) / var_32_4)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				var_32_3.localPosition = Vector3.New(0, -0.97, -6)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_32_5 = arg_29_1.actors_["1084ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect1084ui_story == nil then
				arg_29_1.var_.characterEffect1084ui_story = var_32_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_6 = 0.0166666666666667

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_6 and not isNil(var_32_5) then
				if arg_29_1.var_.characterEffect1084ui_story and not isNil(var_32_5) then
					arg_29_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_6)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_6 and arg_29_1.time_ < 0 + var_32_6 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect1084ui_story then
				arg_29_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_32_7 = 0
			local var_32_8 = 0.65

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_7 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_9 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(122121007).content)

				arg_29_1.text_.text = var_32_9

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_11 = 26 <= 0 and var_32_8 or var_32_8 * (utf8.len(var_32_9) / 26)

				if (26 <= 0 and var_32_8 or var_32_8 * (utf8.len(var_32_9) / 26)) > 0 and var_32_8 < var_32_11 then
					arg_29_1.talkMaxDuration = var_32_11

					if var_32_11 + var_32_7 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_7
					end
				end

				arg_29_1.text_.text = var_32_9
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_12 = math.max(var_32_8, arg_29_1.talkMaxDuration)

			if var_32_7 <= arg_29_1.time_ and arg_29_1.time_ < var_32_7 + var_32_12 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_7) / var_32_12

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_7 + var_32_12 and arg_29_1.time_ < var_32_7 + var_32_12 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play122121008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 122121008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play122121009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_2")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_36_0 = 0
			local var_36_1 = 1.525

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_2 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(122121008).content)

				arg_33_1.text_.text = var_36_2

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 61 <= 0 and var_36_1 or var_36_1 * (utf8.len(var_36_2) / 61)

				if (61 <= 0 and var_36_1 or var_36_1 * (utf8.len(var_36_2) / 61)) > 0 and var_36_1 < var_36_4 then
					arg_33_1.talkMaxDuration = var_36_4

					if var_36_4 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_4 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_2
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_5 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_5 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_5

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_5 and arg_33_1.time_ < var_36_0 + var_36_5 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play122121009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 122121009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play122121010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.975

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_1 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(122121009).content)

				arg_37_1.text_.text = var_40_1

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_3 = 39 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 39)

				if (39 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 39)) > 0 and var_40_0 < var_40_3 then
					arg_37_1.talkMaxDuration = var_40_3

					if var_40_3 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_3 + 0
					end
				end

				arg_37_1.text_.text = var_40_1
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_4 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_4

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play122121010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 122121010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play122121011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.175

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_1 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(122121010).content)

				arg_41_1.text_.text = var_44_1

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_3 = 7 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 7)

				if (7 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 7)) > 0 and var_44_0 < var_44_3 then
					arg_41_1.talkMaxDuration = var_44_3

					if var_44_3 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_3 + 0
					end
				end

				arg_41_1.text_.text = var_44_1
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_4 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_4

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play122121011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 122121011
		arg_45_1.duration_ = 7.37

		local var_45_0 = {
			ja = 7.366,
			ko = 6.866,
			zh = 6.866
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play122121012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1084ui_story"]) and arg_45_1.var_.characterEffect1084ui_story == nil then
				arg_45_1.var_.characterEffect1084ui_story = arg_45_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1084ui_story"]) then
				if arg_45_1.var_.characterEffect1084ui_story and not isNil(arg_45_1.actors_["1084ui_story"]) then
					arg_45_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1084ui_story"]) and arg_45_1.var_.characterEffect1084ui_story then
				arg_45_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_48_2 = 0
			local var_48_3 = 0.8

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_4 = arg_45_1:GetWordFromCfg(122121011)
				local var_48_5 = arg_45_1:FormatText(var_48_4.content)

				arg_45_1.text_.text = var_48_5

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_7 = 32 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 32)

				if (32 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 32)) > 0 and var_48_3 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_2
					end
				end

				arg_45_1.text_.text = var_48_5
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121011", "story_v_out_122121.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_122121", "122121011", "story_v_out_122121.awb") / 1000

					if var_48_8 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_2
					end

					if var_48_4.prefab_name ~= "" and arg_45_1.actors_[var_48_4.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_4.prefab_name].transform, "story_v_out_122121", "122121011", "story_v_out_122121.awb")

						arg_45_1:RecordAudio("122121011", var_48_9)
						arg_45_1:RecordAudio("122121011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_122121", "122121011", "story_v_out_122121.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_122121", "122121011", "story_v_out_122121.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_10 = math.max(var_48_3, arg_45_1.talkMaxDuration)

			if var_48_2 <= arg_45_1.time_ and arg_45_1.time_ < var_48_2 + var_48_10 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_2) / var_48_10

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_2 + var_48_10 and arg_45_1.time_ < var_48_2 + var_48_10 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play122121012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 122121012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play122121013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1084ui_story"]) and arg_49_1.var_.characterEffect1084ui_story == nil then
				arg_49_1.var_.characterEffect1084ui_story = arg_49_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1084ui_story"]) then
				if arg_49_1.var_.characterEffect1084ui_story and not isNil(arg_49_1.actors_["1084ui_story"]) then
					arg_49_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_0)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1084ui_story"]) and arg_49_1.var_.characterEffect1084ui_story then
				arg_49_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_52_1 = 0
			local var_52_2 = 0.7

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(122121012).content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 28 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 28)

				if (28 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 28)) > 0 and var_52_2 < var_52_5 then
					arg_49_1.talkMaxDuration = var_52_5

					if var_52_5 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + var_52_1
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_6 = math.max(var_52_2, arg_49_1.talkMaxDuration)

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_6 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_1) / var_52_6

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_1 + var_52_6 and arg_49_1.time_ < var_52_1 + var_52_6 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play122121013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 122121013
		arg_53_1.duration_ = 10.2

		local var_53_0 = {
			ja = 10.2,
			ko = 5.9,
			zh = 5.9
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play122121014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1084ui_story"]) and arg_53_1.var_.characterEffect1084ui_story == nil then
				arg_53_1.var_.characterEffect1084ui_story = arg_53_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1084ui_story"]) then
				if arg_53_1.var_.characterEffect1084ui_story and not isNil(arg_53_1.actors_["1084ui_story"]) then
					arg_53_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1084ui_story"]) and arg_53_1.var_.characterEffect1084ui_story then
				arg_53_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action486")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_56_2 = 0
			local var_56_3 = 0.675

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_4 = arg_53_1:GetWordFromCfg(122121013)
				local var_56_5 = arg_53_1:FormatText(var_56_4.content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_7 = 27 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 27)

				if (27 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 27)) > 0 and var_56_3 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_2
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121013", "story_v_out_122121.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_122121", "122121013", "story_v_out_122121.awb") / 1000

					if var_56_8 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_2
					end

					if var_56_4.prefab_name ~= "" and arg_53_1.actors_[var_56_4.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_4.prefab_name].transform, "story_v_out_122121", "122121013", "story_v_out_122121.awb")

						arg_53_1:RecordAudio("122121013", var_56_9)
						arg_53_1:RecordAudio("122121013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_122121", "122121013", "story_v_out_122121.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_122121", "122121013", "story_v_out_122121.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_3, arg_53_1.talkMaxDuration)

			if var_56_2 <= arg_53_1.time_ and arg_53_1.time_ < var_56_2 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_2) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_2 + var_56_10 and arg_53_1.time_ < var_56_2 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play122121014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 122121014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play122121015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1084ui_story = arg_57_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1084ui_story"].transform.position).z)
				arg_57_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1084ui_story"].transform.localEulerAngles = arg_57_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_57_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1084ui_story"].transform.position).z)
				arg_57_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1084ui_story"].transform.localEulerAngles = arg_57_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_60_1 = 0
			local var_60_2 = 0.7

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_3 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(122121014).content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 28 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 28)

				if (28 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 28)) > 0 and var_60_2 < var_60_5 then
					arg_57_1.talkMaxDuration = var_60_5

					if var_60_5 + var_60_1 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + var_60_1
					end
				end

				arg_57_1.text_.text = var_60_3
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_6 = math.max(var_60_2, arg_57_1.talkMaxDuration)

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_6 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_1) / var_60_6

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_1 + var_60_6 and arg_57_1.time_ < var_60_1 + var_60_6 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
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

		arg_57_1:InitPlayNodeList()
	end,
	Play122121015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 122121015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play122121016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.675

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_1 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(122121015).content)

				arg_61_1.text_.text = var_64_1

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_3 = 27 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 27)

				if (27 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 27)) > 0 and var_64_0 < var_64_3 then
					arg_61_1.talkMaxDuration = var_64_3

					if var_64_3 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_3 + 0
					end
				end

				arg_61_1.text_.text = var_64_1
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_4 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_4

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play122121016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 122121016
		arg_65_1.duration_ = 11.8

		local var_65_0 = {
			ja = 11.8,
			ko = 6.233,
			zh = 6.233
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play122121017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1084ui_story = arg_65_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1084ui_story"].transform.position).z)
				arg_65_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1084ui_story"].transform.localEulerAngles = arg_65_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_65_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1084ui_story"].transform.position).z)
				arg_65_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1084ui_story"].transform.localEulerAngles = arg_65_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["1084ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1084ui_story == nil then
				arg_65_1.var_.characterEffect1084ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect1084ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1084ui_story then
				arg_65_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4612")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_68_4 = 0
			local var_68_5 = 0.825

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(122121016)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 33 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 33)

				if (33 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 33)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121016", "story_v_out_122121.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_out_122121", "122121016", "story_v_out_122121.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_out_122121", "122121016", "story_v_out_122121.awb")

						arg_65_1:RecordAudio("122121016", var_68_11)
						arg_65_1:RecordAudio("122121016", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_122121", "122121016", "story_v_out_122121.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_122121", "122121016", "story_v_out_122121.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_12 = math.max(var_68_5, arg_65_1.talkMaxDuration)

			if var_68_4 <= arg_65_1.time_ and arg_65_1.time_ < var_68_4 + var_68_12 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_4) / var_68_12

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_4 + var_68_12 and arg_65_1.time_ < var_68_4 + var_68_12 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
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

		arg_65_1:InitPlayNodeList()
	end,
	Play122121017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 122121017
		arg_69_1.duration_ = 5.63

		local var_69_0 = {
			ja = 5.633,
			ko = 3.8,
			zh = 3.8
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play122121018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.5

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_1 = arg_69_1:GetWordFromCfg(122121017)
				local var_72_2 = arg_69_1:FormatText(var_72_1.content)

				arg_69_1.text_.text = var_72_2

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 20 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 20)

				if (20 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 20)) > 0 and var_72_0 < var_72_4 then
					arg_69_1.talkMaxDuration = var_72_4

					if var_72_4 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_4 + 0
					end
				end

				arg_69_1.text_.text = var_72_2
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121017", "story_v_out_122121.awb") ~= 0 then
					local var_72_5 = manager.audio:GetVoiceLength("story_v_out_122121", "122121017", "story_v_out_122121.awb") / 1000

					if var_72_5 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + 0
					end

					if var_72_1.prefab_name ~= "" and arg_69_1.actors_[var_72_1.prefab_name] ~= nil then
						local var_72_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_1.prefab_name].transform, "story_v_out_122121", "122121017", "story_v_out_122121.awb")

						arg_69_1:RecordAudio("122121017", var_72_6)
						arg_69_1:RecordAudio("122121017", var_72_6)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_122121", "122121017", "story_v_out_122121.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_122121", "122121017", "story_v_out_122121.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_7 and arg_69_1.time_ < 0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play122121018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 122121018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play122121019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1084ui_story"]) and arg_73_1.var_.characterEffect1084ui_story == nil then
				arg_73_1.var_.characterEffect1084ui_story = arg_73_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1084ui_story"]) then
				if arg_73_1.var_.characterEffect1084ui_story and not isNil(arg_73_1.actors_["1084ui_story"]) then
					arg_73_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_0)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1084ui_story"]) and arg_73_1.var_.characterEffect1084ui_story then
				arg_73_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_76_1 = 0
			local var_76_2 = 1.125

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_3 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(122121018).content)

				arg_73_1.text_.text = var_76_3

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 45 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 45)

				if (45 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 45)) > 0 and var_76_2 < var_76_5 then
					arg_73_1.talkMaxDuration = var_76_5

					if var_76_5 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + var_76_1
					end
				end

				arg_73_1.text_.text = var_76_3
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_6 = math.max(var_76_2, arg_73_1.talkMaxDuration)

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_6 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_1) / var_76_6

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_1 + var_76_6 and arg_73_1.time_ < var_76_1 + var_76_6 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play122121019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 122121019
		arg_77_1.duration_ = 4.67

		local var_77_0 = {
			ja = 3.8,
			ko = 4.666,
			zh = 4.666
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play122121020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1084ui_story"]) and arg_77_1.var_.characterEffect1084ui_story == nil then
				arg_77_1.var_.characterEffect1084ui_story = arg_77_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1084ui_story"]) then
				if arg_77_1.var_.characterEffect1084ui_story and not isNil(arg_77_1.actors_["1084ui_story"]) then
					arg_77_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1084ui_story"]) and arg_77_1.var_.characterEffect1084ui_story then
				arg_77_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_80_2 = 0
			local var_80_3 = 0.625

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_4 = arg_77_1:GetWordFromCfg(122121019)
				local var_80_5 = arg_77_1:FormatText(var_80_4.content)

				arg_77_1.text_.text = var_80_5

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_7 = 25 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 25)

				if (25 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 25)) > 0 and var_80_3 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_2
					end
				end

				arg_77_1.text_.text = var_80_5
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121019", "story_v_out_122121.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_122121", "122121019", "story_v_out_122121.awb") / 1000

					if var_80_8 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_2
					end

					if var_80_4.prefab_name ~= "" and arg_77_1.actors_[var_80_4.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_4.prefab_name].transform, "story_v_out_122121", "122121019", "story_v_out_122121.awb")

						arg_77_1:RecordAudio("122121019", var_80_9)
						arg_77_1:RecordAudio("122121019", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_122121", "122121019", "story_v_out_122121.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_122121", "122121019", "story_v_out_122121.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_10 = math.max(var_80_3, arg_77_1.talkMaxDuration)

			if var_80_2 <= arg_77_1.time_ and arg_77_1.time_ < var_80_2 + var_80_10 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_2) / var_80_10

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_2 + var_80_10 and arg_77_1.time_ < var_80_2 + var_80_10 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play122121020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 122121020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play122121021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1084ui_story"]) and arg_81_1.var_.characterEffect1084ui_story == nil then
				arg_81_1.var_.characterEffect1084ui_story = arg_81_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1084ui_story"]) then
				if arg_81_1.var_.characterEffect1084ui_story and not isNil(arg_81_1.actors_["1084ui_story"]) then
					arg_81_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_0)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1084ui_story"]) and arg_81_1.var_.characterEffect1084ui_story then
				arg_81_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_84_1 = 0
			local var_84_2 = 0.325

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_3 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(122121020).content)

				arg_81_1.text_.text = var_84_3

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 13 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 13)

				if (13 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 13)) > 0 and var_84_2 < var_84_5 then
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

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play122121021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 122121021
		arg_85_1.duration_ = 9.63

		local var_85_0 = {
			ja = 9.633,
			ko = 6.166,
			zh = 6.166
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play122121022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1084ui_story"]) and arg_85_1.var_.characterEffect1084ui_story == nil then
				arg_85_1.var_.characterEffect1084ui_story = arg_85_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["1084ui_story"]) then
				if arg_85_1.var_.characterEffect1084ui_story and not isNil(arg_85_1.actors_["1084ui_story"]) then
					arg_85_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["1084ui_story"]) and arg_85_1.var_.characterEffect1084ui_story then
				arg_85_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4125")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_88_2 = 0
			local var_88_3 = 0.725

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_2 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_4 = arg_85_1:GetWordFromCfg(122121021)
				local var_88_5 = arg_85_1:FormatText(var_88_4.content)

				arg_85_1.text_.text = var_88_5

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_7 = 29 <= 0 and var_88_3 or var_88_3 * (utf8.len(var_88_5) / 29)

				if (29 <= 0 and var_88_3 or var_88_3 * (utf8.len(var_88_5) / 29)) > 0 and var_88_3 < var_88_7 then
					arg_85_1.talkMaxDuration = var_88_7

					if var_88_7 + var_88_2 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_2
					end
				end

				arg_85_1.text_.text = var_88_5
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121021", "story_v_out_122121.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_out_122121", "122121021", "story_v_out_122121.awb") / 1000

					if var_88_8 + var_88_2 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_2
					end

					if var_88_4.prefab_name ~= "" and arg_85_1.actors_[var_88_4.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_4.prefab_name].transform, "story_v_out_122121", "122121021", "story_v_out_122121.awb")

						arg_85_1:RecordAudio("122121021", var_88_9)
						arg_85_1:RecordAudio("122121021", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_122121", "122121021", "story_v_out_122121.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_122121", "122121021", "story_v_out_122121.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_10 = math.max(var_88_3, arg_85_1.talkMaxDuration)

			if var_88_2 <= arg_85_1.time_ and arg_85_1.time_ < var_88_2 + var_88_10 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_2) / var_88_10

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_2 + var_88_10 and arg_85_1.time_ < var_88_2 + var_88_10 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play122121022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 122121022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play122121023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1084ui_story"]) and arg_89_1.var_.characterEffect1084ui_story == nil then
				arg_89_1.var_.characterEffect1084ui_story = arg_89_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1084ui_story"]) then
				if arg_89_1.var_.characterEffect1084ui_story and not isNil(arg_89_1.actors_["1084ui_story"]) then
					arg_89_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_0)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1084ui_story"]) and arg_89_1.var_.characterEffect1084ui_story then
				arg_89_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_92_1 = arg_89_1.actors_["1084ui_story"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1084ui_story = var_92_1.localPosition
			end

			local var_92_2 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 then
				var_92_1.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_89_1.time_ - 0) / var_92_2)
				var_92_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_1.position).x, (manager.ui.mainCamera.transform.position - var_92_1.position).y, (manager.ui.mainCamera.transform.position - var_92_1.position).z)
				var_92_1.localEulerAngles.z = 0
				var_92_1.localEulerAngles.x = 0
				var_92_1.localEulerAngles = var_92_1.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 then
				var_92_1.localPosition = Vector3.New(0, 100, 0)
				var_92_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_1.position).x, (manager.ui.mainCamera.transform.position - var_92_1.position).y, (manager.ui.mainCamera.transform.position - var_92_1.position).z)
				var_92_1.localEulerAngles.z = 0
				var_92_1.localEulerAngles.x = 0
				var_92_1.localEulerAngles = var_92_1.localEulerAngles
			end

			local var_92_3 = 0
			local var_92_4 = 1.075

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_3 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_5 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(122121022).content)

				arg_89_1.text_.text = var_92_5

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_7 = 43 <= 0 and var_92_4 or var_92_4 * (utf8.len(var_92_5) / 43)

				if (43 <= 0 and var_92_4 or var_92_4 * (utf8.len(var_92_5) / 43)) > 0 and var_92_4 < var_92_7 then
					arg_89_1.talkMaxDuration = var_92_7

					if var_92_7 + var_92_3 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_3
					end
				end

				arg_89_1.text_.text = var_92_5
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_8 = math.max(var_92_4, arg_89_1.talkMaxDuration)

			if var_92_3 <= arg_89_1.time_ and arg_89_1.time_ < var_92_3 + var_92_8 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_3) / var_92_8

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_3 + var_92_8 and arg_89_1.time_ < var_92_3 + var_92_8 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
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

		arg_89_1:InitPlayNodeList()
	end,
	Play122121023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 122121023
		arg_93_1.duration_ = 7.77

		local var_93_0 = {
			ja = 6.5,
			ko = 7.766,
			zh = 7.766
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play122121024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1084ui_story = arg_93_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1084ui_story"].transform.position).z)
				arg_93_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1084ui_story"].transform.localEulerAngles = arg_93_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_93_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1084ui_story"].transform.position).z)
				arg_93_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1084ui_story"].transform.localEulerAngles = arg_93_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_96_1 = arg_93_1.actors_["1084ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1084ui_story == nil then
				arg_93_1.var_.characterEffect1084ui_story = var_96_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 and not isNil(var_96_1) then
				if arg_93_1.var_.characterEffect1084ui_story and not isNil(var_96_1) then
					arg_93_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1084ui_story then
				arg_93_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_96_4 = 0
			local var_96_5 = 0.85

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_6 = arg_93_1:GetWordFromCfg(122121023)
				local var_96_7 = arg_93_1:FormatText(var_96_6.content)

				arg_93_1.text_.text = var_96_7

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_9 = 34 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 34)

				if (34 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 34)) > 0 and var_96_5 < var_96_9 then
					arg_93_1.talkMaxDuration = var_96_9

					if var_96_9 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_4
					end
				end

				arg_93_1.text_.text = var_96_7
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121023", "story_v_out_122121.awb") ~= 0 then
					local var_96_10 = manager.audio:GetVoiceLength("story_v_out_122121", "122121023", "story_v_out_122121.awb") / 1000

					if var_96_10 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_4
					end

					if var_96_6.prefab_name ~= "" and arg_93_1.actors_[var_96_6.prefab_name] ~= nil then
						local var_96_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_6.prefab_name].transform, "story_v_out_122121", "122121023", "story_v_out_122121.awb")

						arg_93_1:RecordAudio("122121023", var_96_11)
						arg_93_1:RecordAudio("122121023", var_96_11)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_122121", "122121023", "story_v_out_122121.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_122121", "122121023", "story_v_out_122121.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_12 = math.max(var_96_5, arg_93_1.talkMaxDuration)

			if var_96_4 <= arg_93_1.time_ and arg_93_1.time_ < var_96_4 + var_96_12 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_4) / var_96_12

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_4 + var_96_12 and arg_93_1.time_ < var_96_4 + var_96_12 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
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

		arg_93_1:InitPlayNodeList()
	end,
	Play122121024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 122121024
		arg_97_1.duration_ = 9.9

		local var_97_0 = {
			ja = 7.866,
			ko = 9.9,
			zh = 9.9
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play122121025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_100_0 = 0
			local var_100_1 = 1.175

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_2 = arg_97_1:GetWordFromCfg(122121024)
				local var_100_3 = arg_97_1:FormatText(var_100_2.content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 47 <= 0 and var_100_1 or var_100_1 * (utf8.len(var_100_3) / 47)

				if (47 <= 0 and var_100_1 or var_100_1 * (utf8.len(var_100_3) / 47)) > 0 and var_100_1 < var_100_5 then
					arg_97_1.talkMaxDuration = var_100_5

					if var_100_5 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_3
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121024", "story_v_out_122121.awb") ~= 0 then
					local var_100_6 = manager.audio:GetVoiceLength("story_v_out_122121", "122121024", "story_v_out_122121.awb") / 1000

					if var_100_6 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_6 + var_100_0
					end

					if var_100_2.prefab_name ~= "" and arg_97_1.actors_[var_100_2.prefab_name] ~= nil then
						local var_100_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_2.prefab_name].transform, "story_v_out_122121", "122121024", "story_v_out_122121.awb")

						arg_97_1:RecordAudio("122121024", var_100_7)
						arg_97_1:RecordAudio("122121024", var_100_7)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_122121", "122121024", "story_v_out_122121.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_122121", "122121024", "story_v_out_122121.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_8 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_8 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_8

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_8 and arg_97_1.time_ < var_100_0 + var_100_8 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play122121025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 122121025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play122121026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1084ui_story"]) and arg_101_1.var_.characterEffect1084ui_story == nil then
				arg_101_1.var_.characterEffect1084ui_story = arg_101_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1084ui_story"]) then
				if arg_101_1.var_.characterEffect1084ui_story and not isNil(arg_101_1.actors_["1084ui_story"]) then
					arg_101_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_0)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1084ui_story"]) and arg_101_1.var_.characterEffect1084ui_story then
				arg_101_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_104_1 = 0
			local var_104_2 = 1.1

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_3 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(122121025).content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 44 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 44)

				if (44 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 44)) > 0 and var_104_2 < var_104_5 then
					arg_101_1.talkMaxDuration = var_104_5

					if var_104_5 + var_104_1 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + var_104_1
					end
				end

				arg_101_1.text_.text = var_104_3
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_6 = math.max(var_104_2, arg_101_1.talkMaxDuration)

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_6 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_1) / var_104_6

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_1 + var_104_6 and arg_101_1.time_ < var_104_1 + var_104_6 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play122121026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 122121026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play122121027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 1.125

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_1 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(122121026).content)

				arg_105_1.text_.text = var_108_1

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_3 = 45 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 45)

				if (45 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 45)) > 0 and var_108_0 < var_108_3 then
					arg_105_1.talkMaxDuration = var_108_3

					if var_108_3 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_3 + 0
					end
				end

				arg_105_1.text_.text = var_108_1
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_4 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_4

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play122121027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 122121027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play122121028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 1.25

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
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

				local var_112_1 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(122121027).content)

				arg_109_1.text_.text = var_112_1

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_3 = 50 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 50)

				if (50 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 50)) > 0 and var_112_0 < var_112_3 then
					arg_109_1.talkMaxDuration = var_112_3

					if var_112_3 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_3 + 0
					end
				end

				arg_109_1.text_.text = var_112_1
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_4 = math.max(var_112_0, arg_109_1.talkMaxDuration)

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_4 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - 0) / var_112_4

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= 0 + var_112_4 and arg_109_1.time_ < 0 + var_112_4 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play122121028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 122121028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play122121029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_116_0 = 0
			local var_116_1 = 1.3

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
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

				local var_116_2 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(122121028).content)

				arg_113_1.text_.text = var_116_2

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 50 <= 0 and var_116_1 or var_116_1 * (utf8.len(var_116_2) / 50)

				if (50 <= 0 and var_116_1 or var_116_1 * (utf8.len(var_116_2) / 50)) > 0 and var_116_1 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + var_116_0
					end
				end

				arg_113_1.text_.text = var_116_2
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_5 = math.max(var_116_1, arg_113_1.talkMaxDuration)

			if var_116_0 <= arg_113_1.time_ and arg_113_1.time_ < var_116_0 + var_116_5 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_0) / var_116_5

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_0 + var_116_5 and arg_113_1.time_ < var_116_0 + var_116_5 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play122121029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 122121029
		arg_117_1.duration_ = 8.03

		local var_117_0 = {
			ja = 8.033,
			ko = 7.633,
			zh = 7.633
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play122121030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["1084ui_story"]) and arg_117_1.var_.characterEffect1084ui_story == nil then
				arg_117_1.var_.characterEffect1084ui_story = arg_117_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["1084ui_story"]) then
				if arg_117_1.var_.characterEffect1084ui_story and not isNil(arg_117_1.actors_["1084ui_story"]) then
					arg_117_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["1084ui_story"]) and arg_117_1.var_.characterEffect1084ui_story then
				arg_117_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action436")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_120_2 = 0
			local var_120_3 = 0.875

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_2 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_4 = arg_117_1:GetWordFromCfg(122121029)
				local var_120_5 = arg_117_1:FormatText(var_120_4.content)

				arg_117_1.text_.text = var_120_5

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_7 = 35 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_5) / 35)

				if (35 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_5) / 35)) > 0 and var_120_3 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_2
					end
				end

				arg_117_1.text_.text = var_120_5
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121029", "story_v_out_122121.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_out_122121", "122121029", "story_v_out_122121.awb") / 1000

					if var_120_8 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_2
					end

					if var_120_4.prefab_name ~= "" and arg_117_1.actors_[var_120_4.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_4.prefab_name].transform, "story_v_out_122121", "122121029", "story_v_out_122121.awb")

						arg_117_1:RecordAudio("122121029", var_120_9)
						arg_117_1:RecordAudio("122121029", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_122121", "122121029", "story_v_out_122121.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_122121", "122121029", "story_v_out_122121.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_10 = math.max(var_120_3, arg_117_1.talkMaxDuration)

			if var_120_2 <= arg_117_1.time_ and arg_117_1.time_ < var_120_2 + var_120_10 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_2) / var_120_10

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_2 + var_120_10 and arg_117_1.time_ < var_120_2 + var_120_10 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play122121030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 122121030
		arg_121_1.duration_ = 3.3

		local var_121_0 = {
			ja = 3.233,
			ko = 3.3,
			zh = 3.3
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
				arg_121_0:Play122121031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			local var_124_0 = 0
			local var_124_1 = 0.35

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_2 = arg_121_1:GetWordFromCfg(122121030)
				local var_124_3 = arg_121_1:FormatText(var_124_2.content)

				arg_121_1.text_.text = var_124_3

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 14 <= 0 and var_124_1 or var_124_1 * (utf8.len(var_124_3) / 14)

				if (14 <= 0 and var_124_1 or var_124_1 * (utf8.len(var_124_3) / 14)) > 0 and var_124_1 < var_124_5 then
					arg_121_1.talkMaxDuration = var_124_5

					if var_124_5 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + var_124_0
					end
				end

				arg_121_1.text_.text = var_124_3
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121030", "story_v_out_122121.awb") ~= 0 then
					local var_124_6 = manager.audio:GetVoiceLength("story_v_out_122121", "122121030", "story_v_out_122121.awb") / 1000

					if var_124_6 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_6 + var_124_0
					end

					if var_124_2.prefab_name ~= "" and arg_121_1.actors_[var_124_2.prefab_name] ~= nil then
						local var_124_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_2.prefab_name].transform, "story_v_out_122121", "122121030", "story_v_out_122121.awb")

						arg_121_1:RecordAudio("122121030", var_124_7)
						arg_121_1:RecordAudio("122121030", var_124_7)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_122121", "122121030", "story_v_out_122121.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_122121", "122121030", "story_v_out_122121.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_8 = math.max(var_124_1, arg_121_1.talkMaxDuration)

			if var_124_0 <= arg_121_1.time_ and arg_121_1.time_ < var_124_0 + var_124_8 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_0) / var_124_8

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_0 + var_124_8 and arg_121_1.time_ < var_124_0 + var_124_8 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play122121031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 122121031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play122121032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["1084ui_story"]) and arg_125_1.var_.characterEffect1084ui_story == nil then
				arg_125_1.var_.characterEffect1084ui_story = arg_125_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["1084ui_story"]) then
				if arg_125_1.var_.characterEffect1084ui_story and not isNil(arg_125_1.actors_["1084ui_story"]) then
					arg_125_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_0)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["1084ui_story"]) and arg_125_1.var_.characterEffect1084ui_story then
				arg_125_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_128_1 = 0
			local var_128_2 = 1.075

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_3 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(122121031).content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 43 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 43)

				if (43 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 43)) > 0 and var_128_2 < var_128_5 then
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

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play122121032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 122121032
		arg_129_1.duration_ = 0.5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"

			SetActive(arg_129_1.choicesGo_, true)

			for iter_130_0, iter_130_1 in ipairs(arg_129_1.choices_) do
				SetActive(iter_130_1.go, iter_130_0 <= 1)
			end

			arg_129_1.choices_[1].txt.text = arg_129_1:FormatText(StoryChoiceCfg[445].name)
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play122121033(arg_129_1)
			end

			arg_129_1:RecordChoiceLog(122121032, 445)
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.allBtn_.enabled = false
			end

			if arg_129_1.time_ >= 0 + 0.5 and arg_129_1.time_ < 0 + 0.5 + arg_132_0 then
				arg_129_1.allBtn_.enabled = true
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play122121033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 122121033
		arg_133_1.duration_ = 3.07

		local var_133_0 = {
			ja = 3.066,
			ko = 2.666,
			zh = 2.666
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
				arg_133_0:Play122121034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1084ui_story = arg_133_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_136_0 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 then
				arg_133_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_133_1.time_ - 0) / var_136_0)
				arg_133_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1084ui_story"].transform.position).z)
				arg_133_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1084ui_story"].transform.localEulerAngles = arg_133_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 then
				arg_133_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_133_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1084ui_story"].transform.position).z)
				arg_133_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1084ui_story"].transform.localEulerAngles = arg_133_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_136_1 = arg_133_1.actors_["1084ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1084ui_story == nil then
				arg_133_1.var_.characterEffect1084ui_story = var_136_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 and not isNil(var_136_1) then
				if arg_133_1.var_.characterEffect1084ui_story and not isNil(var_136_1) then
					arg_133_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1084ui_story then
				arg_133_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_136_4 = 0
			local var_136_5 = 0.25

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_6 = arg_133_1:GetWordFromCfg(122121033)
				local var_136_7 = arg_133_1:FormatText(var_136_6.content)

				arg_133_1.text_.text = var_136_7

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_9 = 10 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 10)

				if (10 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 10)) > 0 and var_136_5 < var_136_9 then
					arg_133_1.talkMaxDuration = var_136_9

					if var_136_9 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_9 + var_136_4
					end
				end

				arg_133_1.text_.text = var_136_7
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121033", "story_v_out_122121.awb") ~= 0 then
					local var_136_10 = manager.audio:GetVoiceLength("story_v_out_122121", "122121033", "story_v_out_122121.awb") / 1000

					if var_136_10 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_4
					end

					if var_136_6.prefab_name ~= "" and arg_133_1.actors_[var_136_6.prefab_name] ~= nil then
						local var_136_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_6.prefab_name].transform, "story_v_out_122121", "122121033", "story_v_out_122121.awb")

						arg_133_1:RecordAudio("122121033", var_136_11)
						arg_133_1:RecordAudio("122121033", var_136_11)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_122121", "122121033", "story_v_out_122121.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_122121", "122121033", "story_v_out_122121.awb")
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
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play122121034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 122121034
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play122121035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["1084ui_story"]) and arg_137_1.var_.characterEffect1084ui_story == nil then
				arg_137_1.var_.characterEffect1084ui_story = arg_137_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["1084ui_story"]) then
				if arg_137_1.var_.characterEffect1084ui_story and not isNil(arg_137_1.actors_["1084ui_story"]) then
					arg_137_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_0)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["1084ui_story"]) and arg_137_1.var_.characterEffect1084ui_story then
				arg_137_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_140_1 = 0
			local var_140_2 = 0.925

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_3 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(122121034).content)

				arg_137_1.text_.text = var_140_3

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 37 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_3) / 37)

				if (37 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_3) / 37)) > 0 and var_140_2 < var_140_5 then
					arg_137_1.talkMaxDuration = var_140_5

					if var_140_5 + var_140_1 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + var_140_1
					end
				end

				arg_137_1.text_.text = var_140_3
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_6 = math.max(var_140_2, arg_137_1.talkMaxDuration)

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_6 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_1) / var_140_6

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_1 + var_140_6 and arg_137_1.time_ < var_140_1 + var_140_6 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play122121035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 122121035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play122121036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 1.175

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

				local var_144_1 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(122121035).content)

				arg_141_1.text_.text = var_144_1

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_3 = 47 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 47)

				if (47 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 47)) > 0 and var_144_0 < var_144_3 then
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
	Play122121036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 122121036
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play122121037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 1.25

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_1 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(122121036).content)

				arg_145_1.text_.text = var_148_1

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_3 = 50 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 50)

				if (50 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 50)) > 0 and var_148_0 < var_148_3 then
					arg_145_1.talkMaxDuration = var_148_3

					if var_148_3 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_3 + 0
					end
				end

				arg_145_1.text_.text = var_148_1
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_4 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_4 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_4

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_4 and arg_145_1.time_ < 0 + var_148_4 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play122121037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 122121037
		arg_149_1.duration_ = 6.2

		local var_149_0 = {
			ja = 6.2,
			ko = 5.3,
			zh = 5.3
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play122121038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1084ui_story = arg_149_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_152_0 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 then
				arg_149_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_149_1.time_ - 0) / var_152_0)
				arg_149_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1084ui_story"].transform.position).z)
				arg_149_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1084ui_story"].transform.localEulerAngles = arg_149_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 then
				arg_149_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_149_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1084ui_story"].transform.position).z)
				arg_149_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1084ui_story"].transform.localEulerAngles = arg_149_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_152_1 = arg_149_1.actors_["1084ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1084ui_story == nil then
				arg_149_1.var_.characterEffect1084ui_story = var_152_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_2 and not isNil(var_152_1) then
				if arg_149_1.var_.characterEffect1084ui_story and not isNil(var_152_1) then
					arg_149_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_2 and arg_149_1.time_ < 0 + var_152_2 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1084ui_story then
				arg_149_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_152_4 = 0
			local var_152_5 = 0.45

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_6 = arg_149_1:GetWordFromCfg(122121037)
				local var_152_7 = arg_149_1:FormatText(var_152_6.content)

				arg_149_1.text_.text = var_152_7

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_9 = 18 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 18)

				if (18 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 18)) > 0 and var_152_5 < var_152_9 then
					arg_149_1.talkMaxDuration = var_152_9

					if var_152_9 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_9 + var_152_4
					end
				end

				arg_149_1.text_.text = var_152_7
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121037", "story_v_out_122121.awb") ~= 0 then
					local var_152_10 = manager.audio:GetVoiceLength("story_v_out_122121", "122121037", "story_v_out_122121.awb") / 1000

					if var_152_10 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_10 + var_152_4
					end

					if var_152_6.prefab_name ~= "" and arg_149_1.actors_[var_152_6.prefab_name] ~= nil then
						local var_152_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_6.prefab_name].transform, "story_v_out_122121", "122121037", "story_v_out_122121.awb")

						arg_149_1:RecordAudio("122121037", var_152_11)
						arg_149_1:RecordAudio("122121037", var_152_11)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_122121", "122121037", "story_v_out_122121.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_122121", "122121037", "story_v_out_122121.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_12 = math.max(var_152_5, arg_149_1.talkMaxDuration)

			if var_152_4 <= arg_149_1.time_ and arg_149_1.time_ < var_152_4 + var_152_12 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_4) / var_152_12

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_4 + var_152_12 and arg_149_1.time_ < var_152_4 + var_152_12 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
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

		arg_149_1:InitPlayNodeList()
	end,
	Play122121038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 122121038
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play122121039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["1084ui_story"]) and arg_153_1.var_.characterEffect1084ui_story == nil then
				arg_153_1.var_.characterEffect1084ui_story = arg_153_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_0 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["1084ui_story"]) then
				if arg_153_1.var_.characterEffect1084ui_story and not isNil(arg_153_1.actors_["1084ui_story"]) then
					arg_153_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_0)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["1084ui_story"]) and arg_153_1.var_.characterEffect1084ui_story then
				arg_153_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_156_1 = 0
			local var_156_2 = 0.8

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_3 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(122121038).content)

				arg_153_1.text_.text = var_156_3

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 32 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_3) / 32)

				if (32 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_3) / 32)) > 0 and var_156_2 < var_156_5 then
					arg_153_1.talkMaxDuration = var_156_5

					if var_156_5 + var_156_1 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + var_156_1
					end
				end

				arg_153_1.text_.text = var_156_3
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_6 = math.max(var_156_2, arg_153_1.talkMaxDuration)

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_6 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_1) / var_156_6

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_1 + var_156_6 and arg_153_1.time_ < var_156_1 + var_156_6 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play122121039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 122121039
		arg_157_1.duration_ = 2

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play122121040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1084ui_story = arg_157_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_160_0 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 then
				arg_157_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_157_1.time_ - 0) / var_160_0)
				arg_157_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1084ui_story"].transform.position).z)
				arg_157_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1084ui_story"].transform.localEulerAngles = arg_157_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 then
				arg_157_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_157_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1084ui_story"].transform.position).z)
				arg_157_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1084ui_story"].transform.localEulerAngles = arg_157_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_160_1 = arg_157_1.actors_["1084ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1084ui_story == nil then
				arg_157_1.var_.characterEffect1084ui_story = var_160_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_2 and not isNil(var_160_1) then
				if arg_157_1.var_.characterEffect1084ui_story and not isNil(var_160_1) then
					arg_157_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_2 and arg_157_1.time_ < 0 + var_160_2 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1084ui_story then
				arg_157_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4313")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_160_4 = 0
			local var_160_5 = 0.1

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_4 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_6 = arg_157_1:GetWordFromCfg(122121039)
				local var_160_7 = arg_157_1:FormatText(var_160_6.content)

				arg_157_1.text_.text = var_160_7

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_9 = 4 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_7) / 4)

				if (4 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_7) / 4)) > 0 and var_160_5 < var_160_9 then
					arg_157_1.talkMaxDuration = var_160_9

					if var_160_9 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_9 + var_160_4
					end
				end

				arg_157_1.text_.text = var_160_7
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121039", "story_v_out_122121.awb") ~= 0 then
					local var_160_10 = manager.audio:GetVoiceLength("story_v_out_122121", "122121039", "story_v_out_122121.awb") / 1000

					if var_160_10 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_10 + var_160_4
					end

					if var_160_6.prefab_name ~= "" and arg_157_1.actors_[var_160_6.prefab_name] ~= nil then
						local var_160_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_6.prefab_name].transform, "story_v_out_122121", "122121039", "story_v_out_122121.awb")

						arg_157_1:RecordAudio("122121039", var_160_11)
						arg_157_1:RecordAudio("122121039", var_160_11)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_122121", "122121039", "story_v_out_122121.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_122121", "122121039", "story_v_out_122121.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_12 = math.max(var_160_5, arg_157_1.talkMaxDuration)

			if var_160_4 <= arg_157_1.time_ and arg_157_1.time_ < var_160_4 + var_160_12 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_4) / var_160_12

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_4 + var_160_12 and arg_157_1.time_ < var_160_4 + var_160_12 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
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

		arg_157_1:InitPlayNodeList()
	end,
	Play122121040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 122121040
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play122121041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_164_0 = arg_161_1.actors_["1084ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1084ui_story == nil then
				arg_161_1.var_.characterEffect1084ui_story = var_164_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_1 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_1 and not isNil(var_164_0) then
				if arg_161_1.var_.characterEffect1084ui_story and not isNil(var_164_0) then
					arg_161_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_1)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_1 and arg_161_1.time_ < 0 + var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1084ui_story then
				arg_161_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_164_2 = 0
			local var_164_3 = 0.6

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_2 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_4 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(122121040).content)

				arg_161_1.text_.text = var_164_4

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_6 = 24 <= 0 and var_164_3 or var_164_3 * (utf8.len(var_164_4) / 24)

				if (24 <= 0 and var_164_3 or var_164_3 * (utf8.len(var_164_4) / 24)) > 0 and var_164_3 < var_164_6 then
					arg_161_1.talkMaxDuration = var_164_6

					if var_164_6 + var_164_2 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_6 + var_164_2
					end
				end

				arg_161_1.text_.text = var_164_4
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_7 = math.max(var_164_3, arg_161_1.talkMaxDuration)

			if var_164_2 <= arg_161_1.time_ and arg_161_1.time_ < var_164_2 + var_164_7 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_2) / var_164_7

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_2 + var_164_7 and arg_161_1.time_ < var_164_2 + var_164_7 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play122121041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 122121041
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play122121042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1084ui_story = arg_165_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1084ui_story"].transform.position).z)
				arg_165_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1084ui_story"].transform.localEulerAngles = arg_165_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_165_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1084ui_story"].transform.position).z)
				arg_165_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1084ui_story"].transform.localEulerAngles = arg_165_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_168_1 = 0
			local var_168_2 = 1.2

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

				local var_168_3 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(122121041).content)

				arg_165_1.text_.text = var_168_3

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 48 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 48)

				if (48 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 48)) > 0 and var_168_2 < var_168_5 then
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

		arg_165_1.nodeConfigList_ = {
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

		arg_165_1:InitPlayNodeList()
	end,
	Play122121042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 122121042
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play122121043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 1.275

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

				local var_172_1 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(122121042).content)

				arg_169_1.text_.text = var_172_1

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_3 = 51 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 51)

				if (51 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 51)) > 0 and var_172_0 < var_172_3 then
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
	Play122121043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 122121043
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play122121044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 1.55

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_1 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(122121043).content)

				arg_173_1.text_.text = var_176_1

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_3 = 61 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 61)

				if (61 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 61)) > 0 and var_176_0 < var_176_3 then
					arg_173_1.talkMaxDuration = var_176_3

					if var_176_3 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_3 + 0
					end
				end

				arg_173_1.text_.text = var_176_1
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_4 = math.max(var_176_0, arg_173_1.talkMaxDuration)

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_4 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - 0) / var_176_4

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= 0 + var_176_4 and arg_173_1.time_ < 0 + var_176_4 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play122121044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 122121044
		arg_177_1.duration_ = 4.37

		local var_177_0 = {
			ja = 4.366,
			ko = 3.3,
			zh = 3.3
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
				arg_177_0:Play122121045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1084ui_story = arg_177_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_180_0 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 then
				arg_177_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_177_1.time_ - 0) / var_180_0)
				arg_177_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1084ui_story"].transform.position).z)
				arg_177_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1084ui_story"].transform.localEulerAngles = arg_177_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 then
				arg_177_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_177_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1084ui_story"].transform.position).z)
				arg_177_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1084ui_story"].transform.localEulerAngles = arg_177_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_180_1 = arg_177_1.actors_["1084ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1084ui_story == nil then
				arg_177_1.var_.characterEffect1084ui_story = var_180_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_2 and not isNil(var_180_1) then
				if arg_177_1.var_.characterEffect1084ui_story and not isNil(var_180_1) then
					arg_177_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_2 and arg_177_1.time_ < 0 + var_180_2 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1084ui_story then
				arg_177_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action41312")
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_180_4 = 0
			local var_180_5 = 0.225

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_6 = arg_177_1:GetWordFromCfg(122121044)
				local var_180_7 = arg_177_1:FormatText(var_180_6.content)

				arg_177_1.text_.text = var_180_7

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_9 = 9 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 9)

				if (9 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 9)) > 0 and var_180_5 < var_180_9 then
					arg_177_1.talkMaxDuration = var_180_9

					if var_180_9 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_9 + var_180_4
					end
				end

				arg_177_1.text_.text = var_180_7
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121044", "story_v_out_122121.awb") ~= 0 then
					local var_180_10 = manager.audio:GetVoiceLength("story_v_out_122121", "122121044", "story_v_out_122121.awb") / 1000

					if var_180_10 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_4
					end

					if var_180_6.prefab_name ~= "" and arg_177_1.actors_[var_180_6.prefab_name] ~= nil then
						local var_180_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_6.prefab_name].transform, "story_v_out_122121", "122121044", "story_v_out_122121.awb")

						arg_177_1:RecordAudio("122121044", var_180_11)
						arg_177_1:RecordAudio("122121044", var_180_11)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_122121", "122121044", "story_v_out_122121.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_122121", "122121044", "story_v_out_122121.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_12 = math.max(var_180_5, arg_177_1.talkMaxDuration)

			if var_180_4 <= arg_177_1.time_ and arg_177_1.time_ < var_180_4 + var_180_12 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_4) / var_180_12

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_4 + var_180_12 and arg_177_1.time_ < var_180_4 + var_180_12 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
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

		arg_177_1:InitPlayNodeList()
	end,
	Play122121045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 122121045
		arg_181_1.duration_ = 0.5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"

			SetActive(arg_181_1.choicesGo_, true)

			for iter_182_0, iter_182_1 in ipairs(arg_181_1.choices_) do
				SetActive(iter_182_1.go, iter_182_0 <= 1)
			end

			arg_181_1.choices_[1].txt.text = arg_181_1:FormatText(StoryChoiceCfg[446].name)
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play122121046(arg_181_1)
			end

			arg_181_1:RecordChoiceLog(122121045, 446)
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["1084ui_story"]) and arg_181_1.var_.characterEffect1084ui_story == nil then
				arg_181_1.var_.characterEffect1084ui_story = arg_181_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_0 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["1084ui_story"]) then
				if arg_181_1.var_.characterEffect1084ui_story and not isNil(arg_181_1.actors_["1084ui_story"]) then
					arg_181_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_0)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["1084ui_story"]) and arg_181_1.var_.characterEffect1084ui_story then
				arg_181_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_184_1 = 0

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.allBtn_.enabled = false
			end

			if arg_181_1.time_ >= var_184_1 + 0.5 and arg_181_1.time_ < var_184_1 + 0.5 + arg_184_0 then
				arg_181_1.allBtn_.enabled = true
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play122121046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 122121046
		arg_185_1.duration_ = 9.9

		local var_185_0 = {
			ja = 9.9,
			ko = 8.133,
			zh = 8.133
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
				arg_185_0:Play122121047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(arg_185_1.actors_["1084ui_story"]) and arg_185_1.var_.characterEffect1084ui_story == nil then
				arg_185_1.var_.characterEffect1084ui_story = arg_185_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_0 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 and not isNil(arg_185_1.actors_["1084ui_story"]) then
				if arg_185_1.var_.characterEffect1084ui_story and not isNil(arg_185_1.actors_["1084ui_story"]) then
					arg_185_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 and not isNil(arg_185_1.actors_["1084ui_story"]) and arg_185_1.var_.characterEffect1084ui_story then
				arg_185_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_188_2 = 0
			local var_188_3 = 0.875

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_2 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_4 = arg_185_1:GetWordFromCfg(122121046)
				local var_188_5 = arg_185_1:FormatText(var_188_4.content)

				arg_185_1.text_.text = var_188_5

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_7 = 35 <= 0 and var_188_3 or var_188_3 * (utf8.len(var_188_5) / 35)

				if (35 <= 0 and var_188_3 or var_188_3 * (utf8.len(var_188_5) / 35)) > 0 and var_188_3 < var_188_7 then
					arg_185_1.talkMaxDuration = var_188_7

					if var_188_7 + var_188_2 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_2
					end
				end

				arg_185_1.text_.text = var_188_5
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121046", "story_v_out_122121.awb") ~= 0 then
					local var_188_8 = manager.audio:GetVoiceLength("story_v_out_122121", "122121046", "story_v_out_122121.awb") / 1000

					if var_188_8 + var_188_2 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_8 + var_188_2
					end

					if var_188_4.prefab_name ~= "" and arg_185_1.actors_[var_188_4.prefab_name] ~= nil then
						local var_188_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_4.prefab_name].transform, "story_v_out_122121", "122121046", "story_v_out_122121.awb")

						arg_185_1:RecordAudio("122121046", var_188_9)
						arg_185_1:RecordAudio("122121046", var_188_9)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_122121", "122121046", "story_v_out_122121.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_122121", "122121046", "story_v_out_122121.awb")
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
	Play122121047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 122121047
		arg_189_1.duration_ = 14.6

		local var_189_0 = {
			ja = 14.6,
			ko = 14.233,
			zh = 14.233
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play122121048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 1.85

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_1 = arg_189_1:GetWordFromCfg(122121047)
				local var_192_2 = arg_189_1:FormatText(var_192_1.content)

				arg_189_1.text_.text = var_192_2

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 74 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 74)

				if (74 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 74)) > 0 and var_192_0 < var_192_4 then
					arg_189_1.talkMaxDuration = var_192_4

					if var_192_4 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_4 + 0
					end
				end

				arg_189_1.text_.text = var_192_2
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121047", "story_v_out_122121.awb") ~= 0 then
					local var_192_5 = manager.audio:GetVoiceLength("story_v_out_122121", "122121047", "story_v_out_122121.awb") / 1000

					if var_192_5 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + 0
					end

					if var_192_1.prefab_name ~= "" and arg_189_1.actors_[var_192_1.prefab_name] ~= nil then
						local var_192_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_1.prefab_name].transform, "story_v_out_122121", "122121047", "story_v_out_122121.awb")

						arg_189_1:RecordAudio("122121047", var_192_6)
						arg_189_1:RecordAudio("122121047", var_192_6)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_122121", "122121047", "story_v_out_122121.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_122121", "122121047", "story_v_out_122121.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_7 = math.max(var_192_0, arg_189_1.talkMaxDuration)

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_7 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - 0) / var_192_7

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= 0 + var_192_7 and arg_189_1.time_ < 0 + var_192_7 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play122121048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 122121048
		arg_193_1.duration_ = 13.87

		local var_193_0 = {
			ja = 13.866,
			ko = 10.333,
			zh = 10.333
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
				arg_193_0:Play122121049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4126")
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_196_0 = 0
			local var_196_1 = 1.275

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_2 = arg_193_1:GetWordFromCfg(122121048)
				local var_196_3 = arg_193_1:FormatText(var_196_2.content)

				arg_193_1.text_.text = var_196_3

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 51 <= 0 and var_196_1 or var_196_1 * (utf8.len(var_196_3) / 51)

				if (51 <= 0 and var_196_1 or var_196_1 * (utf8.len(var_196_3) / 51)) > 0 and var_196_1 < var_196_5 then
					arg_193_1.talkMaxDuration = var_196_5

					if var_196_5 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + var_196_0
					end
				end

				arg_193_1.text_.text = var_196_3
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121048", "story_v_out_122121.awb") ~= 0 then
					local var_196_6 = manager.audio:GetVoiceLength("story_v_out_122121", "122121048", "story_v_out_122121.awb") / 1000

					if var_196_6 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_6 + var_196_0
					end

					if var_196_2.prefab_name ~= "" and arg_193_1.actors_[var_196_2.prefab_name] ~= nil then
						local var_196_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_2.prefab_name].transform, "story_v_out_122121", "122121048", "story_v_out_122121.awb")

						arg_193_1:RecordAudio("122121048", var_196_7)
						arg_193_1:RecordAudio("122121048", var_196_7)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_122121", "122121048", "story_v_out_122121.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_122121", "122121048", "story_v_out_122121.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_8 = math.max(var_196_1, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_8 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_0) / var_196_8

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_8 and arg_193_1.time_ < var_196_0 + var_196_8 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play122121049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 122121049
		arg_197_1.duration_ = 11.47

		local var_197_0 = {
			ja = 8.933,
			ko = 11.466,
			zh = 11.466
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play122121050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_200_0 = 0
			local var_200_1 = 1.4

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_2 = arg_197_1:GetWordFromCfg(122121049)
				local var_200_3 = arg_197_1:FormatText(var_200_2.content)

				arg_197_1.text_.text = var_200_3

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 56 <= 0 and var_200_1 or var_200_1 * (utf8.len(var_200_3) / 56)

				if (56 <= 0 and var_200_1 or var_200_1 * (utf8.len(var_200_3) / 56)) > 0 and var_200_1 < var_200_5 then
					arg_197_1.talkMaxDuration = var_200_5

					if var_200_5 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + var_200_0
					end
				end

				arg_197_1.text_.text = var_200_3
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121049", "story_v_out_122121.awb") ~= 0 then
					local var_200_6 = manager.audio:GetVoiceLength("story_v_out_122121", "122121049", "story_v_out_122121.awb") / 1000

					if var_200_6 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_6 + var_200_0
					end

					if var_200_2.prefab_name ~= "" and arg_197_1.actors_[var_200_2.prefab_name] ~= nil then
						local var_200_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_2.prefab_name].transform, "story_v_out_122121", "122121049", "story_v_out_122121.awb")

						arg_197_1:RecordAudio("122121049", var_200_7)
						arg_197_1:RecordAudio("122121049", var_200_7)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_122121", "122121049", "story_v_out_122121.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_122121", "122121049", "story_v_out_122121.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_8 = math.max(var_200_1, arg_197_1.talkMaxDuration)

			if var_200_0 <= arg_197_1.time_ and arg_197_1.time_ < var_200_0 + var_200_8 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_0) / var_200_8

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_0 + var_200_8 and arg_197_1.time_ < var_200_0 + var_200_8 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play122121050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 122121050
		arg_201_1.duration_ = 10.27

		local var_201_0 = {
			ja = 8.533,
			ko = 10.266,
			zh = 10.266
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
				arg_201_0:Play122121051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_204_0 = 0
			local var_204_1 = 1.125

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_2 = arg_201_1:GetWordFromCfg(122121050)
				local var_204_3 = arg_201_1:FormatText(var_204_2.content)

				arg_201_1.text_.text = var_204_3

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 46 <= 0 and var_204_1 or var_204_1 * (utf8.len(var_204_3) / 46)

				if (46 <= 0 and var_204_1 or var_204_1 * (utf8.len(var_204_3) / 46)) > 0 and var_204_1 < var_204_5 then
					arg_201_1.talkMaxDuration = var_204_5

					if var_204_5 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + var_204_0
					end
				end

				arg_201_1.text_.text = var_204_3
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121050", "story_v_out_122121.awb") ~= 0 then
					local var_204_6 = manager.audio:GetVoiceLength("story_v_out_122121", "122121050", "story_v_out_122121.awb") / 1000

					if var_204_6 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_6 + var_204_0
					end

					if var_204_2.prefab_name ~= "" and arg_201_1.actors_[var_204_2.prefab_name] ~= nil then
						local var_204_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_2.prefab_name].transform, "story_v_out_122121", "122121050", "story_v_out_122121.awb")

						arg_201_1:RecordAudio("122121050", var_204_7)
						arg_201_1:RecordAudio("122121050", var_204_7)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_122121", "122121050", "story_v_out_122121.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_122121", "122121050", "story_v_out_122121.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_8 = math.max(var_204_1, arg_201_1.talkMaxDuration)

			if var_204_0 <= arg_201_1.time_ and arg_201_1.time_ < var_204_0 + var_204_8 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_0) / var_204_8

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_0 + var_204_8 and arg_201_1.time_ < var_204_0 + var_204_8 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play122121051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 122121051
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play122121052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(arg_205_1.actors_["1084ui_story"]) and arg_205_1.var_.characterEffect1084ui_story == nil then
				arg_205_1.var_.characterEffect1084ui_story = arg_205_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_0 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 and not isNil(arg_205_1.actors_["1084ui_story"]) then
				if arg_205_1.var_.characterEffect1084ui_story and not isNil(arg_205_1.actors_["1084ui_story"]) then
					arg_205_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_205_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_205_1.time_ - 0) / var_208_0)
				end
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 and not isNil(arg_205_1.actors_["1084ui_story"]) and arg_205_1.var_.characterEffect1084ui_story then
				arg_205_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_205_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_208_1 = 0
			local var_208_2 = 0.95

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_3 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(122121051).content)

				arg_205_1.text_.text = var_208_3

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 38 <= 0 and var_208_2 or var_208_2 * (utf8.len(var_208_3) / 38)

				if (38 <= 0 and var_208_2 or var_208_2 * (utf8.len(var_208_3) / 38)) > 0 and var_208_2 < var_208_5 then
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
	Play122121052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 122121052
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play122121053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0.375

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_1 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(122121052).content)

				arg_209_1.text_.text = var_212_1

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_3 = 15 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 15)

				if (15 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 15)) > 0 and var_212_0 < var_212_3 then
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
	Play122121053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 122121053
		arg_213_1.duration_ = 2.83

		local var_213_0 = {
			ja = 2.833,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_213_0:Play122121054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_216_0 = arg_213_1.actors_["1084ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1084ui_story == nil then
				arg_213_1.var_.characterEffect1084ui_story = var_216_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_1 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_1 and not isNil(var_216_0) then
				if arg_213_1.var_.characterEffect1084ui_story and not isNil(var_216_0) then
					arg_213_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_1 and arg_213_1.time_ < 0 + var_216_1 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1084ui_story then
				arg_213_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_216_3 = 0
			local var_216_4 = 0.1

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_3 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_5 = arg_213_1:GetWordFromCfg(122121053)
				local var_216_6 = arg_213_1:FormatText(var_216_5.content)

				arg_213_1.text_.text = var_216_6

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_8 = 4 <= 0 and var_216_4 or var_216_4 * (utf8.len(var_216_6) / 4)

				if (4 <= 0 and var_216_4 or var_216_4 * (utf8.len(var_216_6) / 4)) > 0 and var_216_4 < var_216_8 then
					arg_213_1.talkMaxDuration = var_216_8

					if var_216_8 + var_216_3 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_8 + var_216_3
					end
				end

				arg_213_1.text_.text = var_216_6
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121053", "story_v_out_122121.awb") ~= 0 then
					local var_216_9 = manager.audio:GetVoiceLength("story_v_out_122121", "122121053", "story_v_out_122121.awb") / 1000

					if var_216_9 + var_216_3 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_9 + var_216_3
					end

					if var_216_5.prefab_name ~= "" and arg_213_1.actors_[var_216_5.prefab_name] ~= nil then
						local var_216_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_5.prefab_name].transform, "story_v_out_122121", "122121053", "story_v_out_122121.awb")

						arg_213_1:RecordAudio("122121053", var_216_10)
						arg_213_1:RecordAudio("122121053", var_216_10)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_122121", "122121053", "story_v_out_122121.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_122121", "122121053", "story_v_out_122121.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_11 = math.max(var_216_4, arg_213_1.talkMaxDuration)

			if var_216_3 <= arg_213_1.time_ and arg_213_1.time_ < var_216_3 + var_216_11 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_3) / var_216_11

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_3 + var_216_11 and arg_213_1.time_ < var_216_3 + var_216_11 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play122121054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 122121054
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play122121055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(arg_217_1.actors_["1084ui_story"]) and arg_217_1.var_.characterEffect1084ui_story == nil then
				arg_217_1.var_.characterEffect1084ui_story = arg_217_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_0 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 and not isNil(arg_217_1.actors_["1084ui_story"]) then
				if arg_217_1.var_.characterEffect1084ui_story and not isNil(arg_217_1.actors_["1084ui_story"]) then
					arg_217_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_217_1.time_ - 0) / var_220_0)
				end
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 and not isNil(arg_217_1.actors_["1084ui_story"]) and arg_217_1.var_.characterEffect1084ui_story then
				arg_217_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_220_1 = 0
			local var_220_2 = 1.7

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

				local var_220_3 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(122121054).content)

				arg_217_1.text_.text = var_220_3

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 68 <= 0 and var_220_2 or var_220_2 * (utf8.len(var_220_3) / 68)

				if (68 <= 0 and var_220_2 or var_220_2 * (utf8.len(var_220_3) / 68)) > 0 and var_220_2 < var_220_5 then
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
	Play122121055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 122121055
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play122121056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0.4

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_1 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(122121055).content)

				arg_221_1.text_.text = var_224_1

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_3 = 16 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_1) / 16)

				if (16 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_1) / 16)) > 0 and var_224_0 < var_224_3 then
					arg_221_1.talkMaxDuration = var_224_3

					if var_224_3 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_3 + 0
					end
				end

				arg_221_1.text_.text = var_224_1
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_4 = math.max(var_224_0, arg_221_1.talkMaxDuration)

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_4 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - 0) / var_224_4

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= 0 + var_224_4 and arg_221_1.time_ < 0 + var_224_4 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play122121056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 122121056
		arg_225_1.duration_ = 10.5

		local var_225_0 = {
			ja = 10.5,
			ko = 5.166,
			zh = 5.166
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play122121057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(arg_225_1.actors_["1084ui_story"]) and arg_225_1.var_.characterEffect1084ui_story == nil then
				arg_225_1.var_.characterEffect1084ui_story = arg_225_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_0 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 and not isNil(arg_225_1.actors_["1084ui_story"]) then
				if arg_225_1.var_.characterEffect1084ui_story and not isNil(arg_225_1.actors_["1084ui_story"]) then
					arg_225_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 and not isNil(arg_225_1.actors_["1084ui_story"]) and arg_225_1.var_.characterEffect1084ui_story then
				arg_225_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_228_2 = 0
			local var_228_3 = 0.5

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_2 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_4 = arg_225_1:GetWordFromCfg(122121056)
				local var_228_5 = arg_225_1:FormatText(var_228_4.content)

				arg_225_1.text_.text = var_228_5

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_7 = 20 <= 0 and var_228_3 or var_228_3 * (utf8.len(var_228_5) / 20)

				if (20 <= 0 and var_228_3 or var_228_3 * (utf8.len(var_228_5) / 20)) > 0 and var_228_3 < var_228_7 then
					arg_225_1.talkMaxDuration = var_228_7

					if var_228_7 + var_228_2 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_7 + var_228_2
					end
				end

				arg_225_1.text_.text = var_228_5
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121056", "story_v_out_122121.awb") ~= 0 then
					local var_228_8 = manager.audio:GetVoiceLength("story_v_out_122121", "122121056", "story_v_out_122121.awb") / 1000

					if var_228_8 + var_228_2 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_8 + var_228_2
					end

					if var_228_4.prefab_name ~= "" and arg_225_1.actors_[var_228_4.prefab_name] ~= nil then
						local var_228_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_4.prefab_name].transform, "story_v_out_122121", "122121056", "story_v_out_122121.awb")

						arg_225_1:RecordAudio("122121056", var_228_9)
						arg_225_1:RecordAudio("122121056", var_228_9)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_122121", "122121056", "story_v_out_122121.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_122121", "122121056", "story_v_out_122121.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_10 = math.max(var_228_3, arg_225_1.talkMaxDuration)

			if var_228_2 <= arg_225_1.time_ and arg_225_1.time_ < var_228_2 + var_228_10 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_2) / var_228_10

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_2 + var_228_10 and arg_225_1.time_ < var_228_2 + var_228_10 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play122121057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 122121057
		arg_229_1.duration_ = 9.47

		local var_229_0 = {
			ja = 8.8,
			ko = 9.466,
			zh = 9.466
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
				arg_229_0:Play122121058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 1.1

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_1 = arg_229_1:GetWordFromCfg(122121057)
				local var_232_2 = arg_229_1:FormatText(var_232_1.content)

				arg_229_1.text_.text = var_232_2

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_4 = 44 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 44)

				if (44 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 44)) > 0 and var_232_0 < var_232_4 then
					arg_229_1.talkMaxDuration = var_232_4

					if var_232_4 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_4 + 0
					end
				end

				arg_229_1.text_.text = var_232_2
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121057", "story_v_out_122121.awb") ~= 0 then
					local var_232_5 = manager.audio:GetVoiceLength("story_v_out_122121", "122121057", "story_v_out_122121.awb") / 1000

					if var_232_5 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + 0
					end

					if var_232_1.prefab_name ~= "" and arg_229_1.actors_[var_232_1.prefab_name] ~= nil then
						local var_232_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_1.prefab_name].transform, "story_v_out_122121", "122121057", "story_v_out_122121.awb")

						arg_229_1:RecordAudio("122121057", var_232_6)
						arg_229_1:RecordAudio("122121057", var_232_6)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_122121", "122121057", "story_v_out_122121.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_122121", "122121057", "story_v_out_122121.awb")
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
	Play122121058 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 122121058
		arg_233_1.duration_ = 7.13

		local var_233_0 = {
			ja = 7.133,
			ko = 5.166,
			zh = 5.166
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play122121059(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0.7

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_1 = arg_233_1:GetWordFromCfg(122121058)
				local var_236_2 = arg_233_1:FormatText(var_236_1.content)

				arg_233_1.text_.text = var_236_2

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_4 = 28 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_2) / 28)

				if (28 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_2) / 28)) > 0 and var_236_0 < var_236_4 then
					arg_233_1.talkMaxDuration = var_236_4

					if var_236_4 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_4 + 0
					end
				end

				arg_233_1.text_.text = var_236_2
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121058", "story_v_out_122121.awb") ~= 0 then
					local var_236_5 = manager.audio:GetVoiceLength("story_v_out_122121", "122121058", "story_v_out_122121.awb") / 1000

					if var_236_5 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_5 + 0
					end

					if var_236_1.prefab_name ~= "" and arg_233_1.actors_[var_236_1.prefab_name] ~= nil then
						local var_236_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_1.prefab_name].transform, "story_v_out_122121", "122121058", "story_v_out_122121.awb")

						arg_233_1:RecordAudio("122121058", var_236_6)
						arg_233_1:RecordAudio("122121058", var_236_6)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_122121", "122121058", "story_v_out_122121.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_122121", "122121058", "story_v_out_122121.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_7 = math.max(var_236_0, arg_233_1.talkMaxDuration)

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_7 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - 0) / var_236_7

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= 0 + var_236_7 and arg_233_1.time_ < 0 + var_236_7 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play122121059 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 122121059
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play122121060(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(arg_237_1.actors_["1084ui_story"]) and arg_237_1.var_.characterEffect1084ui_story == nil then
				arg_237_1.var_.characterEffect1084ui_story = arg_237_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_0 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 and not isNil(arg_237_1.actors_["1084ui_story"]) then
				if arg_237_1.var_.characterEffect1084ui_story and not isNil(arg_237_1.actors_["1084ui_story"]) then
					arg_237_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_0)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 and not isNil(arg_237_1.actors_["1084ui_story"]) and arg_237_1.var_.characterEffect1084ui_story then
				arg_237_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_240_1 = 0
			local var_240_2 = 0.125

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_3 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(122121059).content)

				arg_237_1.text_.text = var_240_3

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_5 = 5 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_3) / 5)

				if (5 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_3) / 5)) > 0 and var_240_2 < var_240_5 then
					arg_237_1.talkMaxDuration = var_240_5

					if var_240_5 + var_240_1 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_5 + var_240_1
					end
				end

				arg_237_1.text_.text = var_240_3
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_6 = math.max(var_240_2, arg_237_1.talkMaxDuration)

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_6 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_1) / var_240_6

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_1 + var_240_6 and arg_237_1.time_ < var_240_1 + var_240_6 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play122121060 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 122121060
		arg_241_1.duration_ = 6.7

		local var_241_0 = {
			ja = 6.7,
			ko = 2.166,
			zh = 2.166
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play122121061(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(arg_241_1.actors_["1084ui_story"]) and arg_241_1.var_.characterEffect1084ui_story == nil then
				arg_241_1.var_.characterEffect1084ui_story = arg_241_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_0 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 and not isNil(arg_241_1.actors_["1084ui_story"]) then
				if arg_241_1.var_.characterEffect1084ui_story and not isNil(arg_241_1.actors_["1084ui_story"]) then
					arg_241_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 and not isNil(arg_241_1.actors_["1084ui_story"]) and arg_241_1.var_.characterEffect1084ui_story then
				arg_241_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action482")
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_244_2 = 0
			local var_244_3 = 0.225

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_2 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_4 = arg_241_1:GetWordFromCfg(122121060)
				local var_244_5 = arg_241_1:FormatText(var_244_4.content)

				arg_241_1.text_.text = var_244_5

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_7 = 9 <= 0 and var_244_3 or var_244_3 * (utf8.len(var_244_5) / 9)

				if (9 <= 0 and var_244_3 or var_244_3 * (utf8.len(var_244_5) / 9)) > 0 and var_244_3 < var_244_7 then
					arg_241_1.talkMaxDuration = var_244_7

					if var_244_7 + var_244_2 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_7 + var_244_2
					end
				end

				arg_241_1.text_.text = var_244_5
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121060", "story_v_out_122121.awb") ~= 0 then
					local var_244_8 = manager.audio:GetVoiceLength("story_v_out_122121", "122121060", "story_v_out_122121.awb") / 1000

					if var_244_8 + var_244_2 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_8 + var_244_2
					end

					if var_244_4.prefab_name ~= "" and arg_241_1.actors_[var_244_4.prefab_name] ~= nil then
						local var_244_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_4.prefab_name].transform, "story_v_out_122121", "122121060", "story_v_out_122121.awb")

						arg_241_1:RecordAudio("122121060", var_244_9)
						arg_241_1:RecordAudio("122121060", var_244_9)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_122121", "122121060", "story_v_out_122121.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_122121", "122121060", "story_v_out_122121.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_10 = math.max(var_244_3, arg_241_1.talkMaxDuration)

			if var_244_2 <= arg_241_1.time_ and arg_241_1.time_ < var_244_2 + var_244_10 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_2) / var_244_10

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_2 + var_244_10 and arg_241_1.time_ < var_244_2 + var_244_10 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play122121061 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 122121061
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play122121062(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos1084ui_story = arg_245_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_248_0 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 then
				arg_245_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_245_1.time_ - 0) / var_248_0)
				arg_245_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1084ui_story"].transform.position).z)
				arg_245_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["1084ui_story"].transform.localEulerAngles = arg_245_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 then
				arg_245_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_245_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1084ui_story"].transform.position).z)
				arg_245_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["1084ui_story"].transform.localEulerAngles = arg_245_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_248_1 = 0
			local var_248_2 = 0.975

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_3 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(122121061).content)

				arg_245_1.text_.text = var_248_3

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 39 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_3) / 39)

				if (39 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_3) / 39)) > 0 and var_248_2 < var_248_5 then
					arg_245_1.talkMaxDuration = var_248_5

					if var_248_5 + var_248_1 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_5 + var_248_1
					end
				end

				arg_245_1.text_.text = var_248_3
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_6 = math.max(var_248_2, arg_245_1.talkMaxDuration)

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_6 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_1) / var_248_6

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_1 + var_248_6 and arg_245_1.time_ < var_248_1 + var_248_6 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play122121062 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 122121062
		arg_249_1.duration_ = 12.63

		local var_249_0 = {
			ja = 12.633,
			ko = 8.766,
			zh = 8.766
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
				arg_249_0:Play122121063(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1084ui_story = arg_249_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_252_0 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 then
				arg_249_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_249_1.time_ - 0) / var_252_0)
				arg_249_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1084ui_story"].transform.position).z)
				arg_249_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["1084ui_story"].transform.localEulerAngles = arg_249_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 then
				arg_249_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_249_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1084ui_story"].transform.position).z)
				arg_249_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["1084ui_story"].transform.localEulerAngles = arg_249_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_252_1 = arg_249_1.actors_["1084ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect1084ui_story == nil then
				arg_249_1.var_.characterEffect1084ui_story = var_252_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_2 and not isNil(var_252_1) then
				if arg_249_1.var_.characterEffect1084ui_story and not isNil(var_252_1) then
					arg_249_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_2 and arg_249_1.time_ < 0 + var_252_2 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect1084ui_story then
				arg_249_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_252_4 = 0
			local var_252_5 = 1.125

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_4 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_6 = arg_249_1:GetWordFromCfg(122121062)
				local var_252_7 = arg_249_1:FormatText(var_252_6.content)

				arg_249_1.text_.text = var_252_7

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_9 = 45 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 45)

				if (45 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 45)) > 0 and var_252_5 < var_252_9 then
					arg_249_1.talkMaxDuration = var_252_9

					if var_252_9 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_9 + var_252_4
					end
				end

				arg_249_1.text_.text = var_252_7
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121062", "story_v_out_122121.awb") ~= 0 then
					local var_252_10 = manager.audio:GetVoiceLength("story_v_out_122121", "122121062", "story_v_out_122121.awb") / 1000

					if var_252_10 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_10 + var_252_4
					end

					if var_252_6.prefab_name ~= "" and arg_249_1.actors_[var_252_6.prefab_name] ~= nil then
						local var_252_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_6.prefab_name].transform, "story_v_out_122121", "122121062", "story_v_out_122121.awb")

						arg_249_1:RecordAudio("122121062", var_252_11)
						arg_249_1:RecordAudio("122121062", var_252_11)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_122121", "122121062", "story_v_out_122121.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_122121", "122121062", "story_v_out_122121.awb")
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
				actorName = "1084ui_story",
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
	Play122121063 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 122121063
		arg_253_1.duration_ = 12.27

		local var_253_0 = {
			ja = 12.266,
			ko = 9.766,
			zh = 9.766
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play122121064(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action436")
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_256_0 = 0
			local var_256_1 = 1.25

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_2 = arg_253_1:GetWordFromCfg(122121063)
				local var_256_3 = arg_253_1:FormatText(var_256_2.content)

				arg_253_1.text_.text = var_256_3

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_5 = 50 <= 0 and var_256_1 or var_256_1 * (utf8.len(var_256_3) / 50)

				if (50 <= 0 and var_256_1 or var_256_1 * (utf8.len(var_256_3) / 50)) > 0 and var_256_1 < var_256_5 then
					arg_253_1.talkMaxDuration = var_256_5

					if var_256_5 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_5 + var_256_0
					end
				end

				arg_253_1.text_.text = var_256_3
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121063", "story_v_out_122121.awb") ~= 0 then
					local var_256_6 = manager.audio:GetVoiceLength("story_v_out_122121", "122121063", "story_v_out_122121.awb") / 1000

					if var_256_6 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_6 + var_256_0
					end

					if var_256_2.prefab_name ~= "" and arg_253_1.actors_[var_256_2.prefab_name] ~= nil then
						local var_256_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_2.prefab_name].transform, "story_v_out_122121", "122121063", "story_v_out_122121.awb")

						arg_253_1:RecordAudio("122121063", var_256_7)
						arg_253_1:RecordAudio("122121063", var_256_7)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_122121", "122121063", "story_v_out_122121.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_122121", "122121063", "story_v_out_122121.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_8 = math.max(var_256_1, arg_253_1.talkMaxDuration)

			if var_256_0 <= arg_253_1.time_ and arg_253_1.time_ < var_256_0 + var_256_8 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_0) / var_256_8

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_0 + var_256_8 and arg_253_1.time_ < var_256_0 + var_256_8 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play122121064 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 122121064
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play122121065(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(arg_257_1.actors_["1084ui_story"]) and arg_257_1.var_.characterEffect1084ui_story == nil then
				arg_257_1.var_.characterEffect1084ui_story = arg_257_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_0 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 and not isNil(arg_257_1.actors_["1084ui_story"]) then
				if arg_257_1.var_.characterEffect1084ui_story and not isNil(arg_257_1.actors_["1084ui_story"]) then
					arg_257_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_257_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_257_1.time_ - 0) / var_260_0)
				end
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 and not isNil(arg_257_1.actors_["1084ui_story"]) and arg_257_1.var_.characterEffect1084ui_story then
				arg_257_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_257_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_260_1 = 0
			local var_260_2 = 0.175

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
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

				local var_260_3 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(122121064).content)

				arg_257_1.text_.text = var_260_3

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 7 <= 0 and var_260_2 or var_260_2 * (utf8.len(var_260_3) / 7)

				if (7 <= 0 and var_260_2 or var_260_2 * (utf8.len(var_260_3) / 7)) > 0 and var_260_2 < var_260_5 then
					arg_257_1.talkMaxDuration = var_260_5

					if var_260_5 + var_260_1 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_5 + var_260_1
					end
				end

				arg_257_1.text_.text = var_260_3
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_6 = math.max(var_260_2, arg_257_1.talkMaxDuration)

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_6 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_1) / var_260_6

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_1 + var_260_6 and arg_257_1.time_ < var_260_1 + var_260_6 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play122121065 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 122121065
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play122121066(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1084ui_story = arg_261_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_264_0 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 then
				arg_261_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_261_1.time_ - 0) / var_264_0)
				arg_261_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1084ui_story"].transform.position).z)
				arg_261_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1084ui_story"].transform.localEulerAngles = arg_261_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 then
				arg_261_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_261_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1084ui_story"].transform.position).z)
				arg_261_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1084ui_story"].transform.localEulerAngles = arg_261_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_264_1 = 0
			local var_264_2 = 1.475

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_3 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(122121065).content)

				arg_261_1.text_.text = var_264_3

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 60 <= 0 and var_264_2 or var_264_2 * (utf8.len(var_264_3) / 60)

				if (60 <= 0 and var_264_2 or var_264_2 * (utf8.len(var_264_3) / 60)) > 0 and var_264_2 < var_264_5 then
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

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play122121066 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 122121066
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play122121067(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0.875

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_1 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(122121066).content)

				arg_265_1.text_.text = var_268_1

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_3 = 35 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 35)

				if (35 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 35)) > 0 and var_268_0 < var_268_3 then
					arg_265_1.talkMaxDuration = var_268_3

					if var_268_3 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_3 + 0
					end
				end

				arg_265_1.text_.text = var_268_1
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_4 = math.max(var_268_0, arg_265_1.talkMaxDuration)

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_4 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - 0) / var_268_4

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= 0 + var_268_4 and arg_265_1.time_ < 0 + var_268_4 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play122121067 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 122121067
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play122121068(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 1.725

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, false)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_1 = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(122121067).content)

				arg_269_1.text_.text = var_272_1

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_3 = 69 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_1) / 69)

				if (69 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_1) / 69)) > 0 and var_272_0 < var_272_3 then
					arg_269_1.talkMaxDuration = var_272_3

					if var_272_3 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_3 + 0
					end
				end

				arg_269_1.text_.text = var_272_1
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_4 = math.max(var_272_0, arg_269_1.talkMaxDuration)

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_4 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - 0) / var_272_4

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= 0 + var_272_4 and arg_269_1.time_ < 0 + var_272_4 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play122121068 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 122121068
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play122121069(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0.5

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, true)
				arg_273_1.iconController_:SetSelectedState("hero")

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_1 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(122121068).content)

				arg_273_1.text_.text = var_276_1

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_3 = 20 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_1) / 20)

				if (20 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_1) / 20)) > 0 and var_276_0 < var_276_3 then
					arg_273_1.talkMaxDuration = var_276_3

					if var_276_3 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_3 + 0
					end
				end

				arg_273_1.text_.text = var_276_1
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_4 = math.max(var_276_0, arg_273_1.talkMaxDuration)

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_4 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - 0) / var_276_4

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= 0 + var_276_4 and arg_273_1.time_ < 0 + var_276_4 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play122121069 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 122121069
		arg_277_1.duration_ = 4.27

		local var_277_0 = {
			ja = 4.233,
			ko = 4.266,
			zh = 4.266
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play122121070(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(arg_277_1.actors_["1084ui_story"]) and arg_277_1.var_.characterEffect1084ui_story == nil then
				arg_277_1.var_.characterEffect1084ui_story = arg_277_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_0 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 and not isNil(arg_277_1.actors_["1084ui_story"]) then
				if arg_277_1.var_.characterEffect1084ui_story and not isNil(arg_277_1.actors_["1084ui_story"]) then
					arg_277_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 and not isNil(arg_277_1.actors_["1084ui_story"]) and arg_277_1.var_.characterEffect1084ui_story then
				arg_277_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4612")
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_280_2 = arg_277_1.actors_["1084ui_story"].transform

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos1084ui_story = var_280_2.localPosition
			end

			local var_280_3 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_3 then
				var_280_2.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_277_1.time_ - 0) / var_280_3)
				var_280_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_280_2.position).x, (manager.ui.mainCamera.transform.position - var_280_2.position).y, (manager.ui.mainCamera.transform.position - var_280_2.position).z)
				var_280_2.localEulerAngles.z = 0
				var_280_2.localEulerAngles.x = 0
				var_280_2.localEulerAngles = var_280_2.localEulerAngles
			end

			if arg_277_1.time_ >= 0 + var_280_3 and arg_277_1.time_ < 0 + var_280_3 + arg_280_0 then
				var_280_2.localPosition = Vector3.New(0, -0.97, -6)
				var_280_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_280_2.position).x, (manager.ui.mainCamera.transform.position - var_280_2.position).y, (manager.ui.mainCamera.transform.position - var_280_2.position).z)
				var_280_2.localEulerAngles.z = 0
				var_280_2.localEulerAngles.x = 0
				var_280_2.localEulerAngles = var_280_2.localEulerAngles
			end

			local var_280_4 = 0
			local var_280_5 = 0.6

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_4 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_6 = arg_277_1:GetWordFromCfg(122121069)
				local var_280_7 = arg_277_1:FormatText(var_280_6.content)

				arg_277_1.text_.text = var_280_7

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_9 = 24 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 24)

				if (24 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 24)) > 0 and var_280_5 < var_280_9 then
					arg_277_1.talkMaxDuration = var_280_9

					if var_280_9 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_9 + var_280_4
					end
				end

				arg_277_1.text_.text = var_280_7
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121069", "story_v_out_122121.awb") ~= 0 then
					local var_280_10 = manager.audio:GetVoiceLength("story_v_out_122121", "122121069", "story_v_out_122121.awb") / 1000

					if var_280_10 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_10 + var_280_4
					end

					if var_280_6.prefab_name ~= "" and arg_277_1.actors_[var_280_6.prefab_name] ~= nil then
						local var_280_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_6.prefab_name].transform, "story_v_out_122121", "122121069", "story_v_out_122121.awb")

						arg_277_1:RecordAudio("122121069", var_280_11)
						arg_277_1:RecordAudio("122121069", var_280_11)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_122121", "122121069", "story_v_out_122121.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_122121", "122121069", "story_v_out_122121.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_12 = math.max(var_280_5, arg_277_1.talkMaxDuration)

			if var_280_4 <= arg_277_1.time_ and arg_277_1.time_ < var_280_4 + var_280_12 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_4) / var_280_12

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_4 + var_280_12 and arg_277_1.time_ < var_280_4 + var_280_12 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play122121070 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 122121070
		arg_281_1.duration_ = 5.6

		local var_281_0 = {
			ja = 5.6,
			ko = 3.6,
			zh = 3.6
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play122121071(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_284_0 = 0
			local var_284_1 = 0.575

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_2 = arg_281_1:GetWordFromCfg(122121070)
				local var_284_3 = arg_281_1:FormatText(var_284_2.content)

				arg_281_1.text_.text = var_284_3

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 23 <= 0 and var_284_1 or var_284_1 * (utf8.len(var_284_3) / 23)

				if (23 <= 0 and var_284_1 or var_284_1 * (utf8.len(var_284_3) / 23)) > 0 and var_284_1 < var_284_5 then
					arg_281_1.talkMaxDuration = var_284_5

					if var_284_5 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + var_284_0
					end
				end

				arg_281_1.text_.text = var_284_3
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121070", "story_v_out_122121.awb") ~= 0 then
					local var_284_6 = manager.audio:GetVoiceLength("story_v_out_122121", "122121070", "story_v_out_122121.awb") / 1000

					if var_284_6 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_6 + var_284_0
					end

					if var_284_2.prefab_name ~= "" and arg_281_1.actors_[var_284_2.prefab_name] ~= nil then
						local var_284_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_2.prefab_name].transform, "story_v_out_122121", "122121070", "story_v_out_122121.awb")

						arg_281_1:RecordAudio("122121070", var_284_7)
						arg_281_1:RecordAudio("122121070", var_284_7)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_122121", "122121070", "story_v_out_122121.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_122121", "122121070", "story_v_out_122121.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_8 = math.max(var_284_1, arg_281_1.talkMaxDuration)

			if var_284_0 <= arg_281_1.time_ and arg_281_1.time_ < var_284_0 + var_284_8 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_0) / var_284_8

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_0 + var_284_8 and arg_281_1.time_ < var_284_0 + var_284_8 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play122121071 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 122121071
		arg_285_1.duration_ = 6

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play122121072(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if arg_285_1.bgs_.STblack == nil then
				local var_288_0 = Object.Instantiate(arg_285_1.paintGo_)

				var_288_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_288_0.name = "STblack"
				var_288_0.transform.parent = arg_285_1.stage_.transform
				var_288_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_285_1.bgs_.STblack = var_288_0
			end

			if 3 < arg_285_1.time_ and arg_285_1.time_ <= 3 + arg_288_0 then
				local var_288_1 = arg_285_1.bgs_.STblack

				arg_285_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_288_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_288_2 = var_288_1:GetComponent("SpriteRenderer")

				if var_288_2 and var_288_2.sprite then
					local var_288_3 = 2 * (var_288_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_288_1.transform.localScale = Vector3.New(var_288_3 / var_288_2.sprite.bounds.size.y < var_288_3 * manager.ui.mainCameraCom_.aspect / var_288_2.sprite.bounds.size.x and var_288_3 * manager.ui.mainCameraCom_.aspect / var_288_2.sprite.bounds.size.x or var_288_3 / var_288_2.sprite.bounds.size.y, var_288_3 / var_288_2.sprite.bounds.size.y < var_288_3 * manager.ui.mainCameraCom_.aspect / var_288_2.sprite.bounds.size.x and var_288_3 * manager.ui.mainCameraCom_.aspect / var_288_2.sprite.bounds.size.x or var_288_3 / var_288_2.sprite.bounds.size.y, 0)
				end

				for iter_288_0, iter_288_1 in pairs(arg_285_1.bgs_) do
					if iter_288_0 ~= "STblack" then
						iter_288_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_288_4 = arg_285_1.actors_["1084ui_story"].transform

			if 3 < arg_285_1.time_ and arg_285_1.time_ <= 3 + arg_288_0 then
				arg_285_1.var_.moveOldPos1084ui_story = var_288_4.localPosition
			end

			local var_288_5 = 0.001

			if 3 <= arg_285_1.time_ and arg_285_1.time_ < 3 + var_288_5 then
				var_288_4.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_285_1.time_ - 3) / var_288_5)
				var_288_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_288_4.position).x, (manager.ui.mainCamera.transform.position - var_288_4.position).y, (manager.ui.mainCamera.transform.position - var_288_4.position).z)
				var_288_4.localEulerAngles.z = 0
				var_288_4.localEulerAngles.x = 0
				var_288_4.localEulerAngles = var_288_4.localEulerAngles
			end

			if arg_285_1.time_ >= 3 + var_288_5 and arg_285_1.time_ < 3 + var_288_5 + arg_288_0 then
				var_288_4.localPosition = Vector3.New(0, 100, 0)
				var_288_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_288_4.position).x, (manager.ui.mainCamera.transform.position - var_288_4.position).y, (manager.ui.mainCamera.transform.position - var_288_4.position).z)
				var_288_4.localEulerAngles.z = 0
				var_288_4.localEulerAngles.x = 0
				var_288_4.localEulerAngles = var_288_4.localEulerAngles
			end

			local var_288_6 = 0

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_6 + arg_288_0 then
				arg_285_1.mask_.enabled = true
				arg_285_1.mask_.raycastTarget = true

				arg_285_1:SetGaussion(false)
			end

			local var_288_7 = 3

			if var_288_6 <= arg_285_1.time_ and arg_285_1.time_ < var_288_6 + var_288_7 then
				local var_288_8 = Color.New(0, 0, 0)

				var_288_8.a = Mathf.Lerp(0, 1, (arg_285_1.time_ - var_288_6) / var_288_7)
				arg_285_1.mask_.color = var_288_8
			end

			if arg_285_1.time_ >= var_288_6 + var_288_7 and arg_285_1.time_ < var_288_6 + var_288_7 + arg_288_0 then
				local var_288_9 = Color.New(0, 0, 0)

				var_288_9.a = 1
				arg_285_1.mask_.color = var_288_9
			end

			local var_288_10 = 3

			if 3 < arg_285_1.time_ and arg_285_1.time_ <= var_288_10 + arg_288_0 then
				arg_285_1.mask_.enabled = true
				arg_285_1.mask_.raycastTarget = true

				arg_285_1:SetGaussion(false)
			end

			local var_288_11 = 3

			if var_288_10 <= arg_285_1.time_ and arg_285_1.time_ < var_288_10 + var_288_11 then
				local var_288_12 = Color.New(0, 0, 0)

				var_288_12.a = Mathf.Lerp(1, 0, (arg_285_1.time_ - var_288_10) / var_288_11)
				arg_285_1.mask_.color = var_288_12
			end

			if arg_285_1.time_ >= var_288_10 + var_288_11 and arg_285_1.time_ < var_288_10 + var_288_11 + arg_288_0 then
				local var_288_13 = Color.New(0, 0, 0)

				arg_285_1.mask_.enabled = false
				var_288_13.a = 0
				arg_285_1.mask_.color = var_288_13
			end

			if 3 < arg_285_1.time_ and arg_285_1.time_ <= 3 + arg_288_0 then
				arg_285_1.fswbg_:SetActive(true)
				arg_285_1.dialog_:SetActive(false)

				arg_285_1.fswtw_.percent = 0
				arg_285_1.fswt_.text = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(122121071).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.fswt_)

				arg_285_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_285_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_285_1.fswtw_:SetDirty()

				arg_285_1.typewritterCharCountI18N = 0

				SetActive(arg_285_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_285_1:ShowNextGo(false)
			end

			local var_288_14 = 3

			if 3 < arg_285_1.time_ and arg_285_1.time_ <= var_288_14 + arg_288_0 then
				arg_285_1.var_.oldValueTypewriter = arg_285_1.fswtw_.percent

				SetActive(arg_285_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_285_1:ShowNextGo(false)
			end

			local var_288_15 = 21
			local var_288_16 = 1.4
			local var_288_17, var_288_18 = arg_285_1:GetPercentByPara(arg_285_1:FormatText(arg_285_1:GetWordFromCfg(122121071).content), 1)

			if var_288_14 < arg_285_1.time_ and arg_285_1.time_ <= var_288_14 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0

				local var_288_19 = var_288_15 <= 0 and var_288_16 or var_288_16 * ((var_288_18 - arg_285_1.typewritterCharCountI18N) / var_288_15)

				if (var_288_15 <= 0 and var_288_16 or var_288_16 * ((var_288_18 - arg_285_1.typewritterCharCountI18N) / var_288_15)) > 0 and var_288_16 < var_288_19 then
					arg_285_1.talkMaxDuration = var_288_19

					if var_288_19 + var_288_14 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_19 + var_288_14
					end
				end
			end

			local var_288_20 = math.max(1.4, arg_285_1.talkMaxDuration)

			if var_288_14 <= arg_285_1.time_ and arg_285_1.time_ < var_288_14 + var_288_20 then
				arg_285_1.fswtw_.percent = Mathf.Lerp(arg_285_1.var_.oldValueTypewriter, var_288_17, (arg_285_1.time_ - var_288_14) / var_288_20)
				arg_285_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_285_1.fswtw_:SetDirty()
			end

			if arg_285_1.time_ >= var_288_14 + var_288_20 and arg_285_1.time_ < var_288_14 + var_288_20 + arg_288_0 then
				arg_285_1.fswtw_.percent = var_288_17

				arg_285_1.fswtw_:SetDirty()
				arg_285_1:ShowNextGo(true)

				arg_285_1.typewritterCharCountI18N = var_288_18
			end

			if 3 < arg_285_1.time_ and arg_285_1.time_ <= 3 + arg_288_0 then
				local var_288_21 = arg_285_1.fswbg_.transform:Find("textbox/adapt/content") or arg_285_1.fswbg_.transform:Find("textbox/content")
				local var_288_22 = arg_285_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_288_23 = var_288_21:GetComponent("RectTransform")

				var_288_21:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_288_23.offsetMin = Vector2.New(0, 0)
				var_288_23.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_288_26 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_285_1.bgmTxt_.text ~= var_288_26 and arg_285_1.bgmTxt_.text ~= "" then
						if arg_285_1.bgmTxt2_.text ~= "" then
							arg_285_1.bgmTxt_.text = arg_285_1.bgmTxt2_.text
						end

						arg_285_1.bgmTxt2_.text = var_288_26

						arg_285_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_285_1.bgmTxt_.text = var_288_26
						arg_285_1.bgmTxt2_.text = var_288_26
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
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_285_1:InitPlayNodeList()
	end,
	Play122121072 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 122121072
		arg_290_1.duration_ = 3

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play122121073(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.mask_.enabled = true
				arg_290_1.mask_.raycastTarget = true

				arg_290_1:SetGaussion(false)
			end

			local var_293_0 = 3

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_0 then
				local var_293_1 = Color.New(0, 0, 0)

				var_293_1.a = Mathf.Lerp(1, 0, (arg_290_1.time_ - 0) / var_293_0)
				arg_290_1.mask_.color = var_293_1
			end

			if arg_290_1.time_ >= 0 + var_293_0 and arg_290_1.time_ < 0 + var_293_0 + arg_293_0 then
				local var_293_2 = Color.New(0, 0, 0)

				arg_290_1.mask_.enabled = false
				var_293_2.a = 0
				arg_290_1.mask_.color = var_293_2
			end

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.fswbg_:SetActive(true)
				arg_290_1.dialog_:SetActive(false)

				arg_290_1.fswtw_.percent = 0
				arg_290_1.fswt_.text = arg_290_1:FormatText(arg_290_1:GetWordFromCfg(122121072).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.fswt_)

				arg_290_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_290_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_290_1.fswtw_:SetDirty()

				arg_290_1.typewritterCharCountI18N = 0

				SetActive(arg_290_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_290_1:ShowNextGo(false)
			end

			local var_293_3 = 0.0166666666666667

			if 0.0166666666666667 < arg_290_1.time_ and arg_290_1.time_ <= var_293_3 + arg_293_0 then
				arg_290_1.var_.oldValueTypewriter = arg_290_1.fswtw_.percent

				SetActive(arg_290_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_290_1:ShowNextGo(false)
			end

			local var_293_4 = 24
			local var_293_5 = 1.6
			local var_293_6, var_293_7 = arg_290_1:GetPercentByPara(arg_290_1:FormatText(arg_290_1:GetWordFromCfg(122121072).content), 1)

			if var_293_3 < arg_290_1.time_ and arg_290_1.time_ <= var_293_3 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0

				local var_293_8 = var_293_4 <= 0 and var_293_5 or var_293_5 * ((var_293_7 - arg_290_1.typewritterCharCountI18N) / var_293_4)

				if (var_293_4 <= 0 and var_293_5 or var_293_5 * ((var_293_7 - arg_290_1.typewritterCharCountI18N) / var_293_4)) > 0 and var_293_5 < var_293_8 then
					arg_290_1.talkMaxDuration = var_293_8

					if var_293_8 + var_293_3 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_8 + var_293_3
					end
				end
			end

			local var_293_9 = math.max(1.6, arg_290_1.talkMaxDuration)

			if var_293_3 <= arg_290_1.time_ and arg_290_1.time_ < var_293_3 + var_293_9 then
				arg_290_1.fswtw_.percent = Mathf.Lerp(arg_290_1.var_.oldValueTypewriter, var_293_6, (arg_290_1.time_ - var_293_3) / var_293_9)
				arg_290_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_290_1.fswtw_:SetDirty()
			end

			if arg_290_1.time_ >= var_293_3 + var_293_9 and arg_290_1.time_ < var_293_3 + var_293_9 + arg_293_0 then
				arg_290_1.fswtw_.percent = var_293_6

				arg_290_1.fswtw_:SetDirty()
				arg_290_1:ShowNextGo(true)

				arg_290_1.typewritterCharCountI18N = var_293_7
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play122121073 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 122121073
		arg_294_1.duration_ = 11.17

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play122121074(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 3.01666666666667 < arg_294_1.time_ and arg_294_1.time_ <= 3.01666666666667 + arg_297_0 then
				local var_297_0 = arg_294_1.bgs_.ST12

				arg_294_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_297_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_297_1 = var_297_0:GetComponent("SpriteRenderer")

				if var_297_1 and var_297_1.sprite then
					local var_297_2 = 2 * (var_297_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_297_0.transform.localScale = Vector3.New(var_297_2 / var_297_1.sprite.bounds.size.y < var_297_2 * manager.ui.mainCameraCom_.aspect / var_297_1.sprite.bounds.size.x and var_297_2 * manager.ui.mainCameraCom_.aspect / var_297_1.sprite.bounds.size.x or var_297_2 / var_297_1.sprite.bounds.size.y, var_297_2 / var_297_1.sprite.bounds.size.y < var_297_2 * manager.ui.mainCameraCom_.aspect / var_297_1.sprite.bounds.size.x and var_297_2 * manager.ui.mainCameraCom_.aspect / var_297_1.sprite.bounds.size.x or var_297_2 / var_297_1.sprite.bounds.size.y, 0)
				end

				for iter_297_0, iter_297_1 in pairs(arg_294_1.bgs_) do
					if iter_297_0 ~= "ST12" then
						iter_297_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_297_3 = 0

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_3 + arg_297_0 then
				arg_294_1.mask_.enabled = true
				arg_294_1.mask_.raycastTarget = true

				arg_294_1:SetGaussion(false)
			end

			local var_297_4 = 3

			if var_297_3 <= arg_294_1.time_ and arg_294_1.time_ < var_297_3 + var_297_4 then
				local var_297_5 = Color.New(0, 0, 0)

				var_297_5.a = Mathf.Lerp(0, 1, (arg_294_1.time_ - var_297_3) / var_297_4)
				arg_294_1.mask_.color = var_297_5
			end

			if arg_294_1.time_ >= var_297_3 + var_297_4 and arg_294_1.time_ < var_297_3 + var_297_4 + arg_297_0 then
				local var_297_6 = Color.New(0, 0, 0)

				var_297_6.a = 1
				arg_294_1.mask_.color = var_297_6
			end

			local var_297_7 = 3

			if 3 < arg_294_1.time_ and arg_294_1.time_ <= var_297_7 + arg_297_0 then
				arg_294_1.mask_.enabled = true
				arg_294_1.mask_.raycastTarget = true

				arg_294_1:SetGaussion(false)
			end

			local var_297_8 = 3.183334

			if var_297_7 <= arg_294_1.time_ and arg_294_1.time_ < var_297_7 + var_297_8 then
				local var_297_9 = Color.New(0, 0, 0)

				var_297_9.a = Mathf.Lerp(1, 0, (arg_294_1.time_ - var_297_7) / var_297_8)
				arg_294_1.mask_.color = var_297_9
			end

			if arg_294_1.time_ >= var_297_7 + var_297_8 and arg_294_1.time_ < var_297_7 + var_297_8 + arg_297_0 then
				local var_297_10 = Color.New(0, 0, 0)

				arg_294_1.mask_.enabled = false
				var_297_10.a = 0
				arg_294_1.mask_.color = var_297_10
			end

			if 3 < arg_294_1.time_ and arg_294_1.time_ <= 3 + arg_297_0 then
				arg_294_1.fswbg_:SetActive(false)
				arg_294_1.dialog_:SetActive(false)
				SetActive(arg_294_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_294_1:ShowNextGo(false)
			end

			local var_297_11 = manager.ui.mainCamera.transform

			if 6.16666666666667 < arg_294_1.time_ and arg_294_1.time_ <= 6.16666666666667 + arg_297_0 then
				arg_294_1.var_.shakeOldPos = var_297_11.localPosition
			end

			local var_297_12 = 0.133333333333335

			if 6.16666666666667 <= arg_294_1.time_ and arg_294_1.time_ < 6.16666666666667 + var_297_12 then
				local var_297_13, var_297_14 = math.modf((arg_294_1.time_ - 6.16666666666667) / 0.066)

				var_297_11.localPosition = Vector3.New(var_297_14 * 0.13, var_297_14 * 0.13, var_297_14 * 0.13) + arg_294_1.var_.shakeOldPos
			end

			if arg_294_1.time_ >= 6.16666666666667 + var_297_12 and arg_294_1.time_ < 6.16666666666667 + var_297_12 + arg_297_0 then
				var_297_11.localPosition = arg_294_1.var_.shakeOldPos
			end

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_297_17 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_294_1.bgmTxt_.text ~= var_297_17 and arg_294_1.bgmTxt_.text ~= "" then
						if arg_294_1.bgmTxt2_.text ~= "" then
							arg_294_1.bgmTxt_.text = arg_294_1.bgmTxt2_.text
						end

						arg_294_1.bgmTxt2_.text = var_297_17

						arg_294_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_294_1.bgmTxt_.text = var_297_17
						arg_294_1.bgmTxt2_.text = var_297_17
					end

					if arg_294_1.bgmTimer then
						arg_294_1.bgmTimer:Stop()

						arg_294_1.bgmTimer = nil
					end

					if arg_294_1.settingData.show_music_name == 1 then
						arg_294_1.musicController:SetSelectedState("show")
						arg_294_1.musicAnimator_:Play("open", 0, 0)

						if arg_294_1.settingData.music_time ~= 0 then
							arg_294_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_294_1.settingData.music_time), function()
								if arg_294_1 == nil or isNil(arg_294_1.bgmTxt_) then
									return
								end

								arg_294_1.musicController:SetSelectedState("hide")
								arg_294_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 2.9 < arg_294_1.time_ and arg_294_1.time_ <= 2.9 + arg_297_0 then
				arg_294_1:AudioAction("play", "music", "bgm_story_office", "bgm_story_office", "bgm_story_office.awb")

				local var_297_20 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

				if "" ~= "" then
					if arg_294_1.bgmTxt_.text ~= var_297_20 and arg_294_1.bgmTxt_.text ~= "" then
						if arg_294_1.bgmTxt2_.text ~= "" then
							arg_294_1.bgmTxt_.text = arg_294_1.bgmTxt2_.text
						end

						arg_294_1.bgmTxt2_.text = var_297_20

						arg_294_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_294_1.bgmTxt_.text = var_297_20
						arg_294_1.bgmTxt2_.text = var_297_20
					end

					if arg_294_1.bgmTimer then
						arg_294_1.bgmTimer:Stop()

						arg_294_1.bgmTimer = nil
					end

					if arg_294_1.settingData.show_music_name == 1 then
						arg_294_1.musicController:SetSelectedState("show")
						arg_294_1.musicAnimator_:Play("open", 0, 0)

						if arg_294_1.settingData.music_time ~= 0 then
							arg_294_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_294_1.settingData.music_time), function()
								if arg_294_1 == nil or isNil(arg_294_1.bgmTxt_) then
									return
								end

								arg_294_1.musicController:SetSelectedState("hide")
								arg_294_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_294_1.frameCnt_ <= 1 then
				arg_294_1.dialog_:SetActive(false)
			end

			local var_297_21 = 6.16666666666667
			local var_297_22 = 0.425

			if 6.16666666666667 < arg_294_1.time_ and arg_294_1.time_ <= var_297_21 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0

				arg_294_1.dialog_:SetActive(true)

				arg_294_1.dialogCg_.alpha = 0

				local var_297_23 = LeanTween.value(arg_294_1.dialog_, 0, 1, 0.3)

				var_297_23:setOnUpdate(LuaHelper.FloatAction(function(arg_300_0)
					arg_294_1.dialogCg_.alpha = arg_300_0
				end))
				var_297_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_294_1.dialog_)
					var_297_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_294_1.duration_ = arg_294_1.duration_ + 0.3

				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, true)
				arg_294_1.iconController_:SetSelectedState("hero")

				arg_294_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_294_1.callingController_:SetSelectedState("normal")

				arg_294_1.keyicon_.color = Color.New(1, 1, 1)
				arg_294_1.icon_.color = Color.New(1, 1, 1)

				local var_297_24 = arg_294_1:FormatText(arg_294_1:GetWordFromCfg(122121073).content)

				arg_294_1.text_.text = var_297_24

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_26 = 17 <= 0 and var_297_22 or var_297_22 * (utf8.len(var_297_24) / 17)

				if (17 <= 0 and var_297_22 or var_297_22 * (utf8.len(var_297_24) / 17)) > 0 and var_297_22 < var_297_26 then
					arg_294_1.talkMaxDuration = var_297_26
					var_297_21 = var_297_21 + 0.3

					if var_297_26 + var_297_21 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_26 + var_297_21
					end
				end

				arg_294_1.text_.text = var_297_24
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_27 = var_297_21 + 0.3
			local var_297_28 = math.max(var_297_22, arg_294_1.talkMaxDuration)

			if var_297_21 + 0.3 <= arg_294_1.time_ and arg_294_1.time_ < var_297_27 + var_297_28 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_27) / var_297_28

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_27 + var_297_28 and arg_294_1.time_ < var_297_27 + var_297_28 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play122121074 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 122121074
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play122121075(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = 1.65

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, false)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_1 = arg_302_1:FormatText(arg_302_1:GetWordFromCfg(122121074).content)

				arg_302_1.text_.text = var_305_1

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_3 = 66 <= 0 and var_305_0 or var_305_0 * (utf8.len(var_305_1) / 66)

				if (66 <= 0 and var_305_0 or var_305_0 * (utf8.len(var_305_1) / 66)) > 0 and var_305_0 < var_305_3 then
					arg_302_1.talkMaxDuration = var_305_3

					if var_305_3 + 0 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_3 + 0
					end
				end

				arg_302_1.text_.text = var_305_1
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_4 = math.max(var_305_0, arg_302_1.talkMaxDuration)

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_4 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - 0) / var_305_4

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= 0 + var_305_4 and arg_302_1.time_ < 0 + var_305_4 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play122121075 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 122121075
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play122121076(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1:AudioAction("play", "effect", "se_story_side_1094", "se_story_1094_alarmclock", "")
			end

			local var_309_1 = 0
			local var_309_2 = 1.125

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, false)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_3 = arg_306_1:FormatText(arg_306_1:GetWordFromCfg(122121075).content)

				arg_306_1.text_.text = var_309_3

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_5 = 45 <= 0 and var_309_2 or var_309_2 * (utf8.len(var_309_3) / 45)

				if (45 <= 0 and var_309_2 or var_309_2 * (utf8.len(var_309_3) / 45)) > 0 and var_309_2 < var_309_5 then
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
	Play122121076 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 122121076
		arg_310_1.duration_ = 5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play122121077(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = 0.45

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, true)
				arg_310_1.iconController_:SetSelectedState("hero")

				arg_310_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_310_1.callingController_:SetSelectedState("normal")

				arg_310_1.keyicon_.color = Color.New(1, 1, 1)
				arg_310_1.icon_.color = Color.New(1, 1, 1)

				local var_313_1 = arg_310_1:FormatText(arg_310_1:GetWordFromCfg(122121076).content)

				arg_310_1.text_.text = var_313_1

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_3 = 18 <= 0 and var_313_0 or var_313_0 * (utf8.len(var_313_1) / 18)

				if (18 <= 0 and var_313_0 or var_313_0 * (utf8.len(var_313_1) / 18)) > 0 and var_313_0 < var_313_3 then
					arg_310_1.talkMaxDuration = var_313_3

					if var_313_3 + 0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_3 + 0
					end
				end

				arg_310_1.text_.text = var_313_1
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_4 = math.max(var_313_0, arg_310_1.talkMaxDuration)

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_4 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - 0) / var_313_4

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= 0 + var_313_4 and arg_310_1.time_ < 0 + var_313_4 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play122121077 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 122121077
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play122121078(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = 1.1

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, false)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_1 = arg_314_1:FormatText(arg_314_1:GetWordFromCfg(122121077).content)

				arg_314_1.text_.text = var_317_1

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_3 = 44 <= 0 and var_317_0 or var_317_0 * (utf8.len(var_317_1) / 44)

				if (44 <= 0 and var_317_0 or var_317_0 * (utf8.len(var_317_1) / 44)) > 0 and var_317_0 < var_317_3 then
					arg_314_1.talkMaxDuration = var_317_3

					if var_317_3 + 0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_3 + 0
					end
				end

				arg_314_1.text_.text = var_317_1
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_4 = math.max(var_317_0, arg_314_1.talkMaxDuration)

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_4 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - 0) / var_317_4

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= 0 + var_317_4 and arg_314_1.time_ < 0 + var_317_4 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play122121078 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 122121078
		arg_318_1.duration_ = 8.57

		local var_318_0 = {
			ja = 8.566,
			ko = 8.066,
			zh = 8.066
		}
		local var_318_1 = manager.audio:GetLocalizationFlag()

		if var_318_0[var_318_1] ~= nil then
			arg_318_1.duration_ = var_318_0[var_318_1]
		end

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play122121079(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 0.775

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, true)
				arg_318_1.iconController_:SetSelectedState("hero")

				arg_318_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1067")

				arg_318_1.callingController_:SetSelectedState("normal")

				arg_318_1.keyicon_.color = Color.New(1, 1, 1)
				arg_318_1.icon_.color = Color.New(1, 1, 1)

				local var_321_1 = arg_318_1:GetWordFromCfg(122121078)
				local var_321_2 = arg_318_1:FormatText(var_321_1.content)

				arg_318_1.text_.text = var_321_2

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_4 = 31 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_2) / 31)

				if (31 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_2) / 31)) > 0 and var_321_0 < var_321_4 then
					arg_318_1.talkMaxDuration = var_321_4

					if var_321_4 + 0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_4 + 0
					end
				end

				arg_318_1.text_.text = var_321_2
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121078", "story_v_out_122121.awb") ~= 0 then
					local var_321_5 = manager.audio:GetVoiceLength("story_v_out_122121", "122121078", "story_v_out_122121.awb") / 1000

					if var_321_5 + 0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_5 + 0
					end

					if var_321_1.prefab_name ~= "" and arg_318_1.actors_[var_321_1.prefab_name] ~= nil then
						local var_321_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_1.prefab_name].transform, "story_v_out_122121", "122121078", "story_v_out_122121.awb")

						arg_318_1:RecordAudio("122121078", var_321_6)
						arg_318_1:RecordAudio("122121078", var_321_6)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_122121", "122121078", "story_v_out_122121.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_122121", "122121078", "story_v_out_122121.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_7 = math.max(var_321_0, arg_318_1.talkMaxDuration)

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_7 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - 0) / var_321_7

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= 0 + var_321_7 and arg_318_1.time_ < 0 + var_321_7 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play122121079 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 122121079
		arg_322_1.duration_ = 10.87

		local var_322_0 = {
			ja = 7.533,
			ko = 10.866,
			zh = 10.866
		}
		local var_322_1 = manager.audio:GetLocalizationFlag()

		if var_322_0[var_322_1] ~= nil then
			arg_322_1.duration_ = var_322_0[var_322_1]
		end

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play122121080(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 0.95

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, true)
				arg_322_1.iconController_:SetSelectedState("hero")

				arg_322_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1067")

				arg_322_1.callingController_:SetSelectedState("normal")

				arg_322_1.keyicon_.color = Color.New(1, 1, 1)
				arg_322_1.icon_.color = Color.New(1, 1, 1)

				local var_325_1 = arg_322_1:GetWordFromCfg(122121079)
				local var_325_2 = arg_322_1:FormatText(var_325_1.content)

				arg_322_1.text_.text = var_325_2

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_4 = 38 <= 0 and var_325_0 or var_325_0 * (utf8.len(var_325_2) / 38)

				if (38 <= 0 and var_325_0 or var_325_0 * (utf8.len(var_325_2) / 38)) > 0 and var_325_0 < var_325_4 then
					arg_322_1.talkMaxDuration = var_325_4

					if var_325_4 + 0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_4 + 0
					end
				end

				arg_322_1.text_.text = var_325_2
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121079", "story_v_out_122121.awb") ~= 0 then
					local var_325_5 = manager.audio:GetVoiceLength("story_v_out_122121", "122121079", "story_v_out_122121.awb") / 1000

					if var_325_5 + 0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_5 + 0
					end

					if var_325_1.prefab_name ~= "" and arg_322_1.actors_[var_325_1.prefab_name] ~= nil then
						local var_325_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_1.prefab_name].transform, "story_v_out_122121", "122121079", "story_v_out_122121.awb")

						arg_322_1:RecordAudio("122121079", var_325_6)
						arg_322_1:RecordAudio("122121079", var_325_6)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_122121", "122121079", "story_v_out_122121.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_122121", "122121079", "story_v_out_122121.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_7 = math.max(var_325_0, arg_322_1.talkMaxDuration)

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_7 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - 0) / var_325_7

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= 0 + var_325_7 and arg_322_1.time_ < 0 + var_325_7 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play122121080 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 122121080
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play122121081(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0.975

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, false)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_1 = arg_326_1:FormatText(arg_326_1:GetWordFromCfg(122121080).content)

				arg_326_1.text_.text = var_329_1

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_3 = 39 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_1) / 39)

				if (39 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_1) / 39)) > 0 and var_329_0 < var_329_3 then
					arg_326_1.talkMaxDuration = var_329_3

					if var_329_3 + 0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_3 + 0
					end
				end

				arg_326_1.text_.text = var_329_1
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_4 = math.max(var_329_0, arg_326_1.talkMaxDuration)

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_4 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - 0) / var_329_4

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= 0 + var_329_4 and arg_326_1.time_ < 0 + var_329_4 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play122121081 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 122121081
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play122121082(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0.95

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

				local var_333_1 = arg_330_1:FormatText(arg_330_1:GetWordFromCfg(122121081).content)

				arg_330_1.text_.text = var_333_1

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_3 = 38 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_1) / 38)

				if (38 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_1) / 38)) > 0 and var_333_0 < var_333_3 then
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
	Play122121082 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 122121082
		arg_334_1.duration_ = 2

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play122121083(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.var_.moveOldPos1084ui_story = arg_334_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_337_0 = 0.001

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_0 then
				arg_334_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_334_1.time_ - 0) / var_337_0)
				arg_334_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_334_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["1084ui_story"].transform.position).z)
				arg_334_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_334_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_334_1.actors_["1084ui_story"].transform.localEulerAngles = arg_334_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_334_1.time_ >= 0 + var_337_0 and arg_334_1.time_ < 0 + var_337_0 + arg_337_0 then
				arg_334_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_334_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_334_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["1084ui_story"].transform.position).z)
				arg_334_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_334_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_334_1.actors_["1084ui_story"].transform.localEulerAngles = arg_334_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_337_1 = arg_334_1.actors_["1084ui_story"]

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(var_337_1) and arg_334_1.var_.characterEffect1084ui_story == nil then
				arg_334_1.var_.characterEffect1084ui_story = var_337_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_2 = 0.200000002980232

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_2 and not isNil(var_337_1) then
				if arg_334_1.var_.characterEffect1084ui_story and not isNil(var_337_1) then
					arg_334_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_334_1.time_ >= 0 + var_337_2 and arg_334_1.time_ < 0 + var_337_2 + arg_337_0 and not isNil(var_337_1) and arg_334_1.var_.characterEffect1084ui_story then
				arg_334_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				if arg_334_1.var_.characterEffect1084ui_story == nil then
					arg_334_1.var_.characterEffect1084ui_story = arg_334_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_337_4 = arg_334_1.var_.characterEffect1084ui_story

				arg_334_1.var_.characterEffect1084ui_story.imageEffect:turnOff()

				var_337_4.interferenceEffect.enabled = true
				var_337_4.interferenceEffect.noise = 0.001
				var_337_4.interferenceEffect.simTimeScale = 1
				var_337_4.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				if arg_334_1.var_.characterEffect1084ui_story == nil then
					arg_334_1.var_.characterEffect1084ui_story = arg_334_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_334_1.var_.characterEffect1084ui_story.imageEffect:turnOn(false)
			end

			local var_337_6 = 0
			local var_337_7 = 0.1

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_6 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_8 = arg_334_1:GetWordFromCfg(122121082)
				local var_337_9 = arg_334_1:FormatText(var_337_8.content)

				arg_334_1.text_.text = var_337_9

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_11 = 4 <= 0 and var_337_7 or var_337_7 * (utf8.len(var_337_9) / 4)

				if (4 <= 0 and var_337_7 or var_337_7 * (utf8.len(var_337_9) / 4)) > 0 and var_337_7 < var_337_11 then
					arg_334_1.talkMaxDuration = var_337_11

					if var_337_11 + var_337_6 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_11 + var_337_6
					end
				end

				arg_334_1.text_.text = var_337_9
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121082", "story_v_out_122121.awb") ~= 0 then
					local var_337_12 = manager.audio:GetVoiceLength("story_v_out_122121", "122121082", "story_v_out_122121.awb") / 1000

					if var_337_12 + var_337_6 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_12 + var_337_6
					end

					if var_337_8.prefab_name ~= "" and arg_334_1.actors_[var_337_8.prefab_name] ~= nil then
						local var_337_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_8.prefab_name].transform, "story_v_out_122121", "122121082", "story_v_out_122121.awb")

						arg_334_1:RecordAudio("122121082", var_337_13)
						arg_334_1:RecordAudio("122121082", var_337_13)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_122121", "122121082", "story_v_out_122121.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_122121", "122121082", "story_v_out_122121.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_14 = math.max(var_337_7, arg_334_1.talkMaxDuration)

			if var_337_6 <= arg_334_1.time_ and arg_334_1.time_ < var_337_6 + var_337_14 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_6) / var_337_14

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_6 + var_337_14 and arg_334_1.time_ < var_337_6 + var_337_14 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_334_1:InitPlayNodeList()
	end,
	Play122121083 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 122121083
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play122121084(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(arg_338_1.actors_["1084ui_story"]) and arg_338_1.var_.characterEffect1084ui_story == nil then
				arg_338_1.var_.characterEffect1084ui_story = arg_338_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_0 = 0.200000002980232

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_0 and not isNil(arg_338_1.actors_["1084ui_story"]) then
				if arg_338_1.var_.characterEffect1084ui_story and not isNil(arg_338_1.actors_["1084ui_story"]) then
					arg_338_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_338_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_338_1.time_ - 0) / var_341_0)
				end
			end

			if arg_338_1.time_ >= 0 + var_341_0 and arg_338_1.time_ < 0 + var_341_0 + arg_341_0 and not isNil(arg_338_1.actors_["1084ui_story"]) and arg_338_1.var_.characterEffect1084ui_story then
				arg_338_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_338_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1:AudioAction("play", "effect", "se_story_side_1026", "se_story_1026_cat03", "")
			end

			local var_341_2 = 0
			local var_341_3 = 0.05

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_2 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, true)
				arg_338_1.iconController_:SetSelectedState("hero")

				arg_338_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_338_1.callingController_:SetSelectedState("normal")

				arg_338_1.keyicon_.color = Color.New(1, 1, 1)
				arg_338_1.icon_.color = Color.New(1, 1, 1)

				local var_341_4 = arg_338_1:FormatText(arg_338_1:GetWordFromCfg(122121083).content)

				arg_338_1.text_.text = var_341_4

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_6 = 2 <= 0 and var_341_3 or var_341_3 * (utf8.len(var_341_4) / 2)

				if (2 <= 0 and var_341_3 or var_341_3 * (utf8.len(var_341_4) / 2)) > 0 and var_341_3 < var_341_6 then
					arg_338_1.talkMaxDuration = var_341_6

					if var_341_6 + var_341_2 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_6 + var_341_2
					end
				end

				arg_338_1.text_.text = var_341_4
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_7 = math.max(var_341_3, arg_338_1.talkMaxDuration)

			if var_341_2 <= arg_338_1.time_ and arg_338_1.time_ < var_341_2 + var_341_7 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_2) / var_341_7

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_2 + var_341_7 and arg_338_1.time_ < var_341_2 + var_341_7 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play122121084 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 122121084
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play122121085(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = 0.55

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(1, 1, 1)
				arg_342_1.icon_.color = Color.New(1, 1, 1)

				local var_345_1 = arg_342_1:FormatText(arg_342_1:GetWordFromCfg(122121084).content)

				arg_342_1.text_.text = var_345_1

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_3 = 22 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_1) / 22)

				if (22 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_1) / 22)) > 0 and var_345_0 < var_345_3 then
					arg_342_1.talkMaxDuration = var_345_3

					if var_345_3 + 0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_3 + 0
					end
				end

				arg_342_1.text_.text = var_345_1
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_4 = math.max(var_345_0, arg_342_1.talkMaxDuration)

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_4 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - 0) / var_345_4

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= 0 + var_345_4 and arg_342_1.time_ < 0 + var_345_4 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play122121085 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 122121085
		arg_346_1.duration_ = 4

		local var_346_0 = {
			ja = 4,
			ko = 3,
			zh = 3
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play122121086(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(arg_346_1.actors_["1084ui_story"]) and arg_346_1.var_.characterEffect1084ui_story == nil then
				arg_346_1.var_.characterEffect1084ui_story = arg_346_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_0 = 0.200000002980232

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_0 and not isNil(arg_346_1.actors_["1084ui_story"]) then
				if arg_346_1.var_.characterEffect1084ui_story and not isNil(arg_346_1.actors_["1084ui_story"]) then
					arg_346_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_346_1.time_ >= 0 + var_349_0 and arg_346_1.time_ < 0 + var_349_0 + arg_349_0 and not isNil(arg_346_1.actors_["1084ui_story"]) and arg_346_1.var_.characterEffect1084ui_story then
				arg_346_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_349_2 = 0
			local var_349_3 = 0.35

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_2 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_4 = arg_346_1:GetWordFromCfg(122121085)
				local var_349_5 = arg_346_1:FormatText(var_349_4.content)

				arg_346_1.text_.text = var_349_5

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_7 = 14 <= 0 and var_349_3 or var_349_3 * (utf8.len(var_349_5) / 14)

				if (14 <= 0 and var_349_3 or var_349_3 * (utf8.len(var_349_5) / 14)) > 0 and var_349_3 < var_349_7 then
					arg_346_1.talkMaxDuration = var_349_7

					if var_349_7 + var_349_2 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_7 + var_349_2
					end
				end

				arg_346_1.text_.text = var_349_5
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121085", "story_v_out_122121.awb") ~= 0 then
					local var_349_8 = manager.audio:GetVoiceLength("story_v_out_122121", "122121085", "story_v_out_122121.awb") / 1000

					if var_349_8 + var_349_2 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_8 + var_349_2
					end

					if var_349_4.prefab_name ~= "" and arg_346_1.actors_[var_349_4.prefab_name] ~= nil then
						local var_349_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_4.prefab_name].transform, "story_v_out_122121", "122121085", "story_v_out_122121.awb")

						arg_346_1:RecordAudio("122121085", var_349_9)
						arg_346_1:RecordAudio("122121085", var_349_9)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_122121", "122121085", "story_v_out_122121.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_122121", "122121085", "story_v_out_122121.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_10 = math.max(var_349_3, arg_346_1.talkMaxDuration)

			if var_349_2 <= arg_346_1.time_ and arg_346_1.time_ < var_349_2 + var_349_10 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_2) / var_349_10

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_2 + var_349_10 and arg_346_1.time_ < var_349_2 + var_349_10 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play122121086 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 122121086
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play122121087(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.var_.moveOldPos1084ui_story = arg_350_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_353_0 = 0.001

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_0 then
				arg_350_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_350_1.time_ - 0) / var_353_0)
				arg_350_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_350_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["1084ui_story"].transform.position).z)
				arg_350_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_350_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_350_1.actors_["1084ui_story"].transform.localEulerAngles = arg_350_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_350_1.time_ >= 0 + var_353_0 and arg_350_1.time_ < 0 + var_353_0 + arg_353_0 then
				arg_350_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_350_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_350_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["1084ui_story"].transform.position).z)
				arg_350_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_350_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_350_1.actors_["1084ui_story"].transform.localEulerAngles = arg_350_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_353_1 = 0
			local var_353_2 = 1.25

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_1 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, false)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_3 = arg_350_1:FormatText(arg_350_1:GetWordFromCfg(122121086).content)

				arg_350_1.text_.text = var_353_3

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_5 = 50 <= 0 and var_353_2 or var_353_2 * (utf8.len(var_353_3) / 50)

				if (50 <= 0 and var_353_2 or var_353_2 * (utf8.len(var_353_3) / 50)) > 0 and var_353_2 < var_353_5 then
					arg_350_1.talkMaxDuration = var_353_5

					if var_353_5 + var_353_1 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_5 + var_353_1
					end
				end

				arg_350_1.text_.text = var_353_3
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_6 = math.max(var_353_2, arg_350_1.talkMaxDuration)

			if var_353_1 <= arg_350_1.time_ and arg_350_1.time_ < var_353_1 + var_353_6 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_1) / var_353_6

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_1 + var_353_6 and arg_350_1.time_ < var_353_1 + var_353_6 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_350_1:InitPlayNodeList()
	end,
	Play122121087 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 122121087
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play122121088(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = 0.35

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				arg_354_1.leftNameTxt_.text = arg_354_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, true)
				arg_354_1.iconController_:SetSelectedState("hero")

				arg_354_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_354_1.callingController_:SetSelectedState("normal")

				arg_354_1.keyicon_.color = Color.New(1, 1, 1)
				arg_354_1.icon_.color = Color.New(1, 1, 1)

				local var_357_1 = arg_354_1:FormatText(arg_354_1:GetWordFromCfg(122121087).content)

				arg_354_1.text_.text = var_357_1

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_3 = 14 <= 0 and var_357_0 or var_357_0 * (utf8.len(var_357_1) / 14)

				if (14 <= 0 and var_357_0 or var_357_0 * (utf8.len(var_357_1) / 14)) > 0 and var_357_0 < var_357_3 then
					arg_354_1.talkMaxDuration = var_357_3

					if var_357_3 + 0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_3 + 0
					end
				end

				arg_354_1.text_.text = var_357_1
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_4 = math.max(var_357_0, arg_354_1.talkMaxDuration)

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_4 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - 0) / var_357_4

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= 0 + var_357_4 and arg_354_1.time_ < 0 + var_357_4 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play122121088 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 122121088
		arg_358_1.duration_ = 8.47

		local var_358_0 = {
			ja = 8.466,
			ko = 6.566,
			zh = 6.566
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
				arg_358_0:Play122121089(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.var_.moveOldPos1084ui_story = arg_358_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_361_0 = 0.001

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_0 then
				arg_358_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_358_1.time_ - 0) / var_361_0)
				arg_358_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_358_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["1084ui_story"].transform.position).z)
				arg_358_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_358_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_358_1.actors_["1084ui_story"].transform.localEulerAngles = arg_358_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_358_1.time_ >= 0 + var_361_0 and arg_358_1.time_ < 0 + var_361_0 + arg_361_0 then
				arg_358_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_358_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_358_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["1084ui_story"].transform.position).z)
				arg_358_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_358_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_358_1.actors_["1084ui_story"].transform.localEulerAngles = arg_358_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_361_1 = arg_358_1.actors_["1084ui_story"]

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 and not isNil(var_361_1) and arg_358_1.var_.characterEffect1084ui_story == nil then
				arg_358_1.var_.characterEffect1084ui_story = var_361_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_2 = 0.200000002980232

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_2 and not isNil(var_361_1) then
				if arg_358_1.var_.characterEffect1084ui_story and not isNil(var_361_1) then
					arg_358_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_358_1.time_ >= 0 + var_361_2 and arg_358_1.time_ < 0 + var_361_2 + arg_361_0 and not isNil(var_361_1) and arg_358_1.var_.characterEffect1084ui_story then
				arg_358_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action438")
			end

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_361_4 = 0
			local var_361_5 = 0.775

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_4 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_6 = arg_358_1:GetWordFromCfg(122121088)
				local var_361_7 = arg_358_1:FormatText(var_361_6.content)

				arg_358_1.text_.text = var_361_7

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_9 = 31 <= 0 and var_361_5 or var_361_5 * (utf8.len(var_361_7) / 31)

				if (31 <= 0 and var_361_5 or var_361_5 * (utf8.len(var_361_7) / 31)) > 0 and var_361_5 < var_361_9 then
					arg_358_1.talkMaxDuration = var_361_9

					if var_361_9 + var_361_4 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_9 + var_361_4
					end
				end

				arg_358_1.text_.text = var_361_7
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121088", "story_v_out_122121.awb") ~= 0 then
					local var_361_10 = manager.audio:GetVoiceLength("story_v_out_122121", "122121088", "story_v_out_122121.awb") / 1000

					if var_361_10 + var_361_4 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_10 + var_361_4
					end

					if var_361_6.prefab_name ~= "" and arg_358_1.actors_[var_361_6.prefab_name] ~= nil then
						local var_361_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_6.prefab_name].transform, "story_v_out_122121", "122121088", "story_v_out_122121.awb")

						arg_358_1:RecordAudio("122121088", var_361_11)
						arg_358_1:RecordAudio("122121088", var_361_11)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_out_122121", "122121088", "story_v_out_122121.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_out_122121", "122121088", "story_v_out_122121.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_12 = math.max(var_361_5, arg_358_1.talkMaxDuration)

			if var_361_4 <= arg_358_1.time_ and arg_358_1.time_ < var_361_4 + var_361_12 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_4) / var_361_12

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_4 + var_361_12 and arg_358_1.time_ < var_361_4 + var_361_12 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_358_1:InitPlayNodeList()
	end,
	Play122121089 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 122121089
		arg_362_1.duration_ = 5

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play122121090(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 and not isNil(arg_362_1.actors_["1084ui_story"]) and arg_362_1.var_.characterEffect1084ui_story == nil then
				arg_362_1.var_.characterEffect1084ui_story = arg_362_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_0 = 0.200000002980232

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_0 and not isNil(arg_362_1.actors_["1084ui_story"]) then
				if arg_362_1.var_.characterEffect1084ui_story and not isNil(arg_362_1.actors_["1084ui_story"]) then
					arg_362_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_362_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_362_1.time_ - 0) / var_365_0)
				end
			end

			if arg_362_1.time_ >= 0 + var_365_0 and arg_362_1.time_ < 0 + var_365_0 + arg_365_0 and not isNil(arg_362_1.actors_["1084ui_story"]) and arg_362_1.var_.characterEffect1084ui_story then
				arg_362_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_362_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_365_1 = 0
			local var_365_2 = 0.45

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_1 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, true)
				arg_362_1.iconController_:SetSelectedState("hero")

				arg_362_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_362_1.callingController_:SetSelectedState("normal")

				arg_362_1.keyicon_.color = Color.New(1, 1, 1)
				arg_362_1.icon_.color = Color.New(1, 1, 1)

				local var_365_3 = arg_362_1:FormatText(arg_362_1:GetWordFromCfg(122121089).content)

				arg_362_1.text_.text = var_365_3

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_5 = 18 <= 0 and var_365_2 or var_365_2 * (utf8.len(var_365_3) / 18)

				if (18 <= 0 and var_365_2 or var_365_2 * (utf8.len(var_365_3) / 18)) > 0 and var_365_2 < var_365_5 then
					arg_362_1.talkMaxDuration = var_365_5

					if var_365_5 + var_365_1 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_5 + var_365_1
					end
				end

				arg_362_1.text_.text = var_365_3
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)
				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_6 = math.max(var_365_2, arg_362_1.talkMaxDuration)

			if var_365_1 <= arg_362_1.time_ and arg_362_1.time_ < var_365_1 + var_365_6 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_1) / var_365_6

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_1 + var_365_6 and arg_362_1.time_ < var_365_1 + var_365_6 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play122121090 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 122121090
		arg_366_1.duration_ = 5

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play122121091(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = 1

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				arg_366_1.leftNameTxt_.text = arg_366_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, true)
				arg_366_1.iconController_:SetSelectedState("hero")

				arg_366_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_366_1.callingController_:SetSelectedState("normal")

				arg_366_1.keyicon_.color = Color.New(1, 1, 1)
				arg_366_1.icon_.color = Color.New(1, 1, 1)

				local var_369_1 = arg_366_1:FormatText(arg_366_1:GetWordFromCfg(122121090).content)

				arg_366_1.text_.text = var_369_1

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_3 = 40 <= 0 and var_369_0 or var_369_0 * (utf8.len(var_369_1) / 40)

				if (40 <= 0 and var_369_0 or var_369_0 * (utf8.len(var_369_1) / 40)) > 0 and var_369_0 < var_369_3 then
					arg_366_1.talkMaxDuration = var_369_3

					if var_369_3 + 0 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_3 + 0
					end
				end

				arg_366_1.text_.text = var_369_1
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)
				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_4 = math.max(var_369_0, arg_366_1.talkMaxDuration)

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_4 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - 0) / var_369_4

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= 0 + var_369_4 and arg_366_1.time_ < 0 + var_369_4 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play122121091 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 122121091
		arg_370_1.duration_ = 6.03

		local var_370_0 = {
			ja = 6,
			ko = 6.033,
			zh = 6.033
		}
		local var_370_1 = manager.audio:GetLocalizationFlag()

		if var_370_0[var_370_1] ~= nil then
			arg_370_1.duration_ = var_370_0[var_370_1]
		end

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play122121092(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(arg_370_1.actors_["1084ui_story"]) and arg_370_1.var_.characterEffect1084ui_story == nil then
				arg_370_1.var_.characterEffect1084ui_story = arg_370_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_0 = 0.200000002980232

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_0 and not isNil(arg_370_1.actors_["1084ui_story"]) then
				if arg_370_1.var_.characterEffect1084ui_story and not isNil(arg_370_1.actors_["1084ui_story"]) then
					arg_370_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_370_1.time_ >= 0 + var_373_0 and arg_370_1.time_ < 0 + var_373_0 + arg_373_0 and not isNil(arg_370_1.actors_["1084ui_story"]) and arg_370_1.var_.characterEffect1084ui_story then
				arg_370_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action482")
			end

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_373_2 = 0
			local var_373_3 = 0.775

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_2 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_4 = arg_370_1:GetWordFromCfg(122121091)
				local var_373_5 = arg_370_1:FormatText(var_373_4.content)

				arg_370_1.text_.text = var_373_5

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_7 = 31 <= 0 and var_373_3 or var_373_3 * (utf8.len(var_373_5) / 31)

				if (31 <= 0 and var_373_3 or var_373_3 * (utf8.len(var_373_5) / 31)) > 0 and var_373_3 < var_373_7 then
					arg_370_1.talkMaxDuration = var_373_7

					if var_373_7 + var_373_2 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_7 + var_373_2
					end
				end

				arg_370_1.text_.text = var_373_5
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121091", "story_v_out_122121.awb") ~= 0 then
					local var_373_8 = manager.audio:GetVoiceLength("story_v_out_122121", "122121091", "story_v_out_122121.awb") / 1000

					if var_373_8 + var_373_2 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_8 + var_373_2
					end

					if var_373_4.prefab_name ~= "" and arg_370_1.actors_[var_373_4.prefab_name] ~= nil then
						local var_373_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_4.prefab_name].transform, "story_v_out_122121", "122121091", "story_v_out_122121.awb")

						arg_370_1:RecordAudio("122121091", var_373_9)
						arg_370_1:RecordAudio("122121091", var_373_9)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_122121", "122121091", "story_v_out_122121.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_122121", "122121091", "story_v_out_122121.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_10 = math.max(var_373_3, arg_370_1.talkMaxDuration)

			if var_373_2 <= arg_370_1.time_ and arg_370_1.time_ < var_373_2 + var_373_10 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_2) / var_373_10

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_2 + var_373_10 and arg_370_1.time_ < var_373_2 + var_373_10 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play122121092 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 122121092
		arg_374_1.duration_ = 6.27

		local var_374_0 = {
			ja = 6.266,
			ko = 5.1,
			zh = 5.1
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
				arg_374_0:Play122121093(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = 0.775

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_1 = arg_374_1:GetWordFromCfg(122121092)
				local var_377_2 = arg_374_1:FormatText(var_377_1.content)

				arg_374_1.text_.text = var_377_2

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_4 = 31 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_2) / 31)

				if (31 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_2) / 31)) > 0 and var_377_0 < var_377_4 then
					arg_374_1.talkMaxDuration = var_377_4

					if var_377_4 + 0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_4 + 0
					end
				end

				arg_374_1.text_.text = var_377_2
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121092", "story_v_out_122121.awb") ~= 0 then
					local var_377_5 = manager.audio:GetVoiceLength("story_v_out_122121", "122121092", "story_v_out_122121.awb") / 1000

					if var_377_5 + 0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_5 + 0
					end

					if var_377_1.prefab_name ~= "" and arg_374_1.actors_[var_377_1.prefab_name] ~= nil then
						local var_377_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_1.prefab_name].transform, "story_v_out_122121", "122121092", "story_v_out_122121.awb")

						arg_374_1:RecordAudio("122121092", var_377_6)
						arg_374_1:RecordAudio("122121092", var_377_6)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_122121", "122121092", "story_v_out_122121.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_122121", "122121092", "story_v_out_122121.awb")
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
	Play122121093 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 122121093
		arg_378_1.duration_ = 5

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play122121094(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1.var_.moveOldPos1084ui_story = arg_378_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_381_0 = 0.001

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_0 then
				arg_378_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_378_1.time_ - 0) / var_381_0)
				arg_378_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_378_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_378_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_378_1.actors_["1084ui_story"].transform.position).z)
				arg_378_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_378_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_378_1.actors_["1084ui_story"].transform.localEulerAngles = arg_378_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_378_1.time_ >= 0 + var_381_0 and arg_378_1.time_ < 0 + var_381_0 + arg_381_0 then
				arg_378_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_378_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_378_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_378_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_378_1.actors_["1084ui_story"].transform.position).z)
				arg_378_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_378_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_378_1.actors_["1084ui_story"].transform.localEulerAngles = arg_378_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_381_1 = 0
			local var_381_2 = 1.175

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_1 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, false)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_3 = arg_378_1:FormatText(arg_378_1:GetWordFromCfg(122121093).content)

				arg_378_1.text_.text = var_381_3

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_5 = 47 <= 0 and var_381_2 or var_381_2 * (utf8.len(var_381_3) / 47)

				if (47 <= 0 and var_381_2 or var_381_2 * (utf8.len(var_381_3) / 47)) > 0 and var_381_2 < var_381_5 then
					arg_378_1.talkMaxDuration = var_381_5

					if var_381_5 + var_381_1 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_5 + var_381_1
					end
				end

				arg_378_1.text_.text = var_381_3
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)
				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_6 = math.max(var_381_2, arg_378_1.talkMaxDuration)

			if var_381_1 <= arg_378_1.time_ and arg_378_1.time_ < var_381_1 + var_381_6 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_1) / var_381_6

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_1 + var_381_6 and arg_378_1.time_ < var_381_1 + var_381_6 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_378_1:InitPlayNodeList()
	end,
	Play122121094 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 122121094
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play122121095(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = 1.2

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, false)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_1 = arg_382_1:FormatText(arg_382_1:GetWordFromCfg(122121094).content)

				arg_382_1.text_.text = var_385_1

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_3 = 48 <= 0 and var_385_0 or var_385_0 * (utf8.len(var_385_1) / 48)

				if (48 <= 0 and var_385_0 or var_385_0 * (utf8.len(var_385_1) / 48)) > 0 and var_385_0 < var_385_3 then
					arg_382_1.talkMaxDuration = var_385_3

					if var_385_3 + 0 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_3 + 0
					end
				end

				arg_382_1.text_.text = var_385_1
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_4 = math.max(var_385_0, arg_382_1.talkMaxDuration)

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_4 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - 0) / var_385_4

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= 0 + var_385_4 and arg_382_1.time_ < 0 + var_385_4 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play122121095 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 122121095
		arg_386_1.duration_ = 8.6

		local var_386_0 = {
			ja = 6.666,
			ko = 8.6,
			zh = 8.6
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
				arg_386_0:Play122121096(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1.var_.moveOldPos1084ui_story = arg_386_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_389_0 = 0.001

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_0 then
				arg_386_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_386_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_386_1.time_ - 0) / var_389_0)
				arg_386_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_386_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_386_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_386_1.actors_["1084ui_story"].transform.position).z)
				arg_386_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_386_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_386_1.actors_["1084ui_story"].transform.localEulerAngles = arg_386_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_386_1.time_ >= 0 + var_389_0 and arg_386_1.time_ < 0 + var_389_0 + arg_389_0 then
				arg_386_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_386_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_386_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_386_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_386_1.actors_["1084ui_story"].transform.position).z)
				arg_386_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_386_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_386_1.actors_["1084ui_story"].transform.localEulerAngles = arg_386_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_389_1 = arg_386_1.actors_["1084ui_story"]

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 and not isNil(var_389_1) and arg_386_1.var_.characterEffect1084ui_story == nil then
				arg_386_1.var_.characterEffect1084ui_story = var_389_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_2 = 0.200000002980232

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_2 and not isNil(var_389_1) then
				if arg_386_1.var_.characterEffect1084ui_story and not isNil(var_389_1) then
					arg_386_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_386_1.time_ >= 0 + var_389_2 and arg_386_1.time_ < 0 + var_389_2 + arg_389_0 and not isNil(var_389_1) and arg_386_1.var_.characterEffect1084ui_story then
				arg_386_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				if arg_386_1.var_.characterEffect1084ui_story == nil then
					arg_386_1.var_.characterEffect1084ui_story = arg_386_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_389_4 = arg_386_1.var_.characterEffect1084ui_story

				arg_386_1.var_.characterEffect1084ui_story.imageEffect:turnOff()

				var_389_4.interferenceEffect.enabled = true
				var_389_4.interferenceEffect.noise = 0.001
				var_389_4.interferenceEffect.simTimeScale = 1
				var_389_4.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_389_5 = 0
			local var_389_6 = 1.2

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_5 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				arg_386_1.leftNameTxt_.text = arg_386_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_7 = arg_386_1:GetWordFromCfg(122121095)
				local var_389_8 = arg_386_1:FormatText(var_389_7.content)

				arg_386_1.text_.text = var_389_8

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_10 = 48 <= 0 and var_389_6 or var_389_6 * (utf8.len(var_389_8) / 48)

				if (48 <= 0 and var_389_6 or var_389_6 * (utf8.len(var_389_8) / 48)) > 0 and var_389_6 < var_389_10 then
					arg_386_1.talkMaxDuration = var_389_10

					if var_389_10 + var_389_5 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_10 + var_389_5
					end
				end

				arg_386_1.text_.text = var_389_8
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121095", "story_v_out_122121.awb") ~= 0 then
					local var_389_11 = manager.audio:GetVoiceLength("story_v_out_122121", "122121095", "story_v_out_122121.awb") / 1000

					if var_389_11 + var_389_5 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_11 + var_389_5
					end

					if var_389_7.prefab_name ~= "" and arg_386_1.actors_[var_389_7.prefab_name] ~= nil then
						local var_389_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_7.prefab_name].transform, "story_v_out_122121", "122121095", "story_v_out_122121.awb")

						arg_386_1:RecordAudio("122121095", var_389_12)
						arg_386_1:RecordAudio("122121095", var_389_12)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_out_122121", "122121095", "story_v_out_122121.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_out_122121", "122121095", "story_v_out_122121.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_13 = math.max(var_389_6, arg_386_1.talkMaxDuration)

			if var_389_5 <= arg_386_1.time_ and arg_386_1.time_ < var_389_5 + var_389_13 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_5) / var_389_13

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_5 + var_389_13 and arg_386_1.time_ < var_389_5 + var_389_13 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_386_1:InitPlayNodeList()
	end,
	Play122121096 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 122121096
		arg_390_1.duration_ = 5.83

		local var_390_0 = {
			ja = 4.733,
			ko = 5.833,
			zh = 5.833
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
				arg_390_0:Play122121097(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_393_0 = 0
			local var_393_1 = 0.725

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_0 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_2 = arg_390_1:GetWordFromCfg(122121096)
				local var_393_3 = arg_390_1:FormatText(var_393_2.content)

				arg_390_1.text_.text = var_393_3

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_5 = 29 <= 0 and var_393_1 or var_393_1 * (utf8.len(var_393_3) / 29)

				if (29 <= 0 and var_393_1 or var_393_1 * (utf8.len(var_393_3) / 29)) > 0 and var_393_1 < var_393_5 then
					arg_390_1.talkMaxDuration = var_393_5

					if var_393_5 + var_393_0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_5 + var_393_0
					end
				end

				arg_390_1.text_.text = var_393_3
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121096", "story_v_out_122121.awb") ~= 0 then
					local var_393_6 = manager.audio:GetVoiceLength("story_v_out_122121", "122121096", "story_v_out_122121.awb") / 1000

					if var_393_6 + var_393_0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_6 + var_393_0
					end

					if var_393_2.prefab_name ~= "" and arg_390_1.actors_[var_393_2.prefab_name] ~= nil then
						local var_393_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_2.prefab_name].transform, "story_v_out_122121", "122121096", "story_v_out_122121.awb")

						arg_390_1:RecordAudio("122121096", var_393_7)
						arg_390_1:RecordAudio("122121096", var_393_7)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_122121", "122121096", "story_v_out_122121.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_122121", "122121096", "story_v_out_122121.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_8 = math.max(var_393_1, arg_390_1.talkMaxDuration)

			if var_393_0 <= arg_390_1.time_ and arg_390_1.time_ < var_393_0 + var_393_8 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_0) / var_393_8

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_0 + var_393_8 and arg_390_1.time_ < var_393_0 + var_393_8 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play122121097 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 122121097
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play122121098(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 and not isNil(arg_394_1.actors_["1084ui_story"]) and arg_394_1.var_.characterEffect1084ui_story == nil then
				arg_394_1.var_.characterEffect1084ui_story = arg_394_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_0 = 0.2

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_0 and not isNil(arg_394_1.actors_["1084ui_story"]) then
				if arg_394_1.var_.characterEffect1084ui_story and not isNil(arg_394_1.actors_["1084ui_story"]) then
					arg_394_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_394_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_394_1.time_ - 0) / var_397_0)
				end
			end

			if arg_394_1.time_ >= 0 + var_397_0 and arg_394_1.time_ < 0 + var_397_0 + arg_397_0 and not isNil(arg_394_1.actors_["1084ui_story"]) and arg_394_1.var_.characterEffect1084ui_story then
				arg_394_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_394_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_397_1 = 0
			local var_397_2 = 0.175

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_1 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				arg_394_1.leftNameTxt_.text = arg_394_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, true)
				arg_394_1.iconController_:SetSelectedState("hero")

				arg_394_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_394_1.callingController_:SetSelectedState("normal")

				arg_394_1.keyicon_.color = Color.New(1, 1, 1)
				arg_394_1.icon_.color = Color.New(1, 1, 1)

				local var_397_3 = arg_394_1:FormatText(arg_394_1:GetWordFromCfg(122121097).content)

				arg_394_1.text_.text = var_397_3

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_5 = 7 <= 0 and var_397_2 or var_397_2 * (utf8.len(var_397_3) / 7)

				if (7 <= 0 and var_397_2 or var_397_2 * (utf8.len(var_397_3) / 7)) > 0 and var_397_2 < var_397_5 then
					arg_394_1.talkMaxDuration = var_397_5

					if var_397_5 + var_397_1 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_5 + var_397_1
					end
				end

				arg_394_1.text_.text = var_397_3
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_6 = math.max(var_397_2, arg_394_1.talkMaxDuration)

			if var_397_1 <= arg_394_1.time_ and arg_394_1.time_ < var_397_1 + var_397_6 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_1) / var_397_6

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_1 + var_397_6 and arg_394_1.time_ < var_397_1 + var_397_6 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play122121098 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 122121098
		arg_398_1.duration_ = 5

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play122121099(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 1.2

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, false)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_1 = arg_398_1:FormatText(arg_398_1:GetWordFromCfg(122121098).content)

				arg_398_1.text_.text = var_401_1

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_3 = 48 <= 0 and var_401_0 or var_401_0 * (utf8.len(var_401_1) / 48)

				if (48 <= 0 and var_401_0 or var_401_0 * (utf8.len(var_401_1) / 48)) > 0 and var_401_0 < var_401_3 then
					arg_398_1.talkMaxDuration = var_401_3

					if var_401_3 + 0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_3 + 0
					end
				end

				arg_398_1.text_.text = var_401_1
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)
				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_4 = math.max(var_401_0, arg_398_1.talkMaxDuration)

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_4 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - 0) / var_401_4

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= 0 + var_401_4 and arg_398_1.time_ < 0 + var_401_4 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play122121099 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 122121099
		arg_402_1.duration_ = 4.1

		local var_402_0 = {
			ja = 4.1,
			ko = 2.733,
			zh = 2.733
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
				arg_402_0:Play122121100(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_405_0 = arg_402_1.actors_["1084ui_story"]

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 and not isNil(var_405_0) and arg_402_1.var_.characterEffect1084ui_story == nil then
				arg_402_1.var_.characterEffect1084ui_story = var_405_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_405_1 = 0.2

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_1 and not isNil(var_405_0) then
				if arg_402_1.var_.characterEffect1084ui_story and not isNil(var_405_0) then
					arg_402_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_402_1.time_ >= 0 + var_405_1 and arg_402_1.time_ < 0 + var_405_1 + arg_405_0 and not isNil(var_405_0) and arg_402_1.var_.characterEffect1084ui_story then
				arg_402_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_405_3 = 0
			local var_405_4 = 0.325

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_3 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_5 = arg_402_1:GetWordFromCfg(122121099)
				local var_405_6 = arg_402_1:FormatText(var_405_5.content)

				arg_402_1.text_.text = var_405_6

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_8 = 13 <= 0 and var_405_4 or var_405_4 * (utf8.len(var_405_6) / 13)

				if (13 <= 0 and var_405_4 or var_405_4 * (utf8.len(var_405_6) / 13)) > 0 and var_405_4 < var_405_8 then
					arg_402_1.talkMaxDuration = var_405_8

					if var_405_8 + var_405_3 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_8 + var_405_3
					end
				end

				arg_402_1.text_.text = var_405_6
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121099", "story_v_out_122121.awb") ~= 0 then
					local var_405_9 = manager.audio:GetVoiceLength("story_v_out_122121", "122121099", "story_v_out_122121.awb") / 1000

					if var_405_9 + var_405_3 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_9 + var_405_3
					end

					if var_405_5.prefab_name ~= "" and arg_402_1.actors_[var_405_5.prefab_name] ~= nil then
						local var_405_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_5.prefab_name].transform, "story_v_out_122121", "122121099", "story_v_out_122121.awb")

						arg_402_1:RecordAudio("122121099", var_405_10)
						arg_402_1:RecordAudio("122121099", var_405_10)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_out_122121", "122121099", "story_v_out_122121.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_out_122121", "122121099", "story_v_out_122121.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_11 = math.max(var_405_4, arg_402_1.talkMaxDuration)

			if var_405_3 <= arg_402_1.time_ and arg_402_1.time_ < var_405_3 + var_405_11 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_3) / var_405_11

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_3 + var_405_11 and arg_402_1.time_ < var_405_3 + var_405_11 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play122121100 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 122121100
		arg_406_1.duration_ = 1.47

		local var_406_0 = {
			ja = 1.466,
			ko = 1.433,
			zh = 1.433
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
				arg_406_0:Play122121101(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = 0.1

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				arg_406_1.leftNameTxt_.text = arg_406_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_1 = arg_406_1:GetWordFromCfg(122121100)
				local var_409_2 = arg_406_1:FormatText(var_409_1.content)

				arg_406_1.text_.text = var_409_2

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_4 = 4 <= 0 and var_409_0 or var_409_0 * (utf8.len(var_409_2) / 4)

				if (4 <= 0 and var_409_0 or var_409_0 * (utf8.len(var_409_2) / 4)) > 0 and var_409_0 < var_409_4 then
					arg_406_1.talkMaxDuration = var_409_4

					if var_409_4 + 0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_4 + 0
					end
				end

				arg_406_1.text_.text = var_409_2
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121100", "story_v_out_122121.awb") ~= 0 then
					local var_409_5 = manager.audio:GetVoiceLength("story_v_out_122121", "122121100", "story_v_out_122121.awb") / 1000

					if var_409_5 + 0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_5 + 0
					end

					if var_409_1.prefab_name ~= "" and arg_406_1.actors_[var_409_1.prefab_name] ~= nil then
						local var_409_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_1.prefab_name].transform, "story_v_out_122121", "122121100", "story_v_out_122121.awb")

						arg_406_1:RecordAudio("122121100", var_409_6)
						arg_406_1:RecordAudio("122121100", var_409_6)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_122121", "122121100", "story_v_out_122121.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_122121", "122121100", "story_v_out_122121.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_7 = math.max(var_409_0, arg_406_1.talkMaxDuration)

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_7 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - 0) / var_409_7

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= 0 + var_409_7 and arg_406_1.time_ < 0 + var_409_7 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play122121101 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 122121101
		arg_410_1.duration_ = 5

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play122121102(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1.var_.moveOldPos1084ui_story = arg_410_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_413_0 = 0.001

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_0 then
				arg_410_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_410_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_410_1.time_ - 0) / var_413_0)
				arg_410_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_410_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_410_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_410_1.actors_["1084ui_story"].transform.position).z)
				arg_410_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_410_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_410_1.actors_["1084ui_story"].transform.localEulerAngles = arg_410_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_410_1.time_ >= 0 + var_413_0 and arg_410_1.time_ < 0 + var_413_0 + arg_413_0 then
				arg_410_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_410_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_410_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_410_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_410_1.actors_["1084ui_story"].transform.position).z)
				arg_410_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_410_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_410_1.actors_["1084ui_story"].transform.localEulerAngles = arg_410_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				if arg_410_1.var_.characterEffect1084ui_story == nil then
					arg_410_1.var_.characterEffect1084ui_story = arg_410_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_413_1 = arg_410_1.var_.characterEffect1084ui_story

				arg_410_1.var_.characterEffect1084ui_story.imageEffect:turnOff()

				var_413_1.interferenceEffect.enabled = false
				var_413_1.interferenceEffect.noise = 0.001
				var_413_1.interferenceEffect.simTimeScale = 1
				var_413_1.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_413_4 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_410_1.bgmTxt_.text ~= var_413_4 and arg_410_1.bgmTxt_.text ~= "" then
						if arg_410_1.bgmTxt2_.text ~= "" then
							arg_410_1.bgmTxt_.text = arg_410_1.bgmTxt2_.text
						end

						arg_410_1.bgmTxt2_.text = var_413_4

						arg_410_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_410_1.bgmTxt_.text = var_413_4
						arg_410_1.bgmTxt2_.text = var_413_4
					end

					if arg_410_1.bgmTimer then
						arg_410_1.bgmTimer:Stop()

						arg_410_1.bgmTimer = nil
					end

					if arg_410_1.settingData.show_music_name == 1 then
						arg_410_1.musicController:SetSelectedState("show")
						arg_410_1.musicAnimator_:Play("open", 0, 0)

						if arg_410_1.settingData.music_time ~= 0 then
							arg_410_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_410_1.settingData.music_time), function()
								if arg_410_1 == nil or isNil(arg_410_1.bgmTxt_) then
									return
								end

								arg_410_1.musicController:SetSelectedState("hide")
								arg_410_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1:AudioAction("play", "effect", "se_story_122_02", "se_story_122_02_Signalinterrupt", "")
			end

			local var_413_6 = 0
			local var_413_7 = 1.025

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_6 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, false)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_8 = arg_410_1:FormatText(arg_410_1:GetWordFromCfg(122121101).content)

				arg_410_1.text_.text = var_413_8

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_10 = 41 <= 0 and var_413_7 or var_413_7 * (utf8.len(var_413_8) / 41)

				if (41 <= 0 and var_413_7 or var_413_7 * (utf8.len(var_413_8) / 41)) > 0 and var_413_7 < var_413_10 then
					arg_410_1.talkMaxDuration = var_413_10

					if var_413_10 + var_413_6 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_10 + var_413_6
					end
				end

				arg_410_1.text_.text = var_413_8
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)
				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_11 = math.max(var_413_7, arg_410_1.talkMaxDuration)

			if var_413_6 <= arg_410_1.time_ and arg_410_1.time_ < var_413_6 + var_413_11 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_6) / var_413_11

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_6 + var_413_11 and arg_410_1.time_ < var_413_6 + var_413_11 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_410_1:InitPlayNodeList()
	end,
	Play122121102 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 122121102
		arg_415_1.duration_ = 5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play122121103(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 1.1

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, false)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_1 = arg_415_1:FormatText(arg_415_1:GetWordFromCfg(122121102).content)

				arg_415_1.text_.text = var_418_1

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_3 = 44 <= 0 and var_418_0 or var_418_0 * (utf8.len(var_418_1) / 44)

				if (44 <= 0 and var_418_0 or var_418_0 * (utf8.len(var_418_1) / 44)) > 0 and var_418_0 < var_418_3 then
					arg_415_1.talkMaxDuration = var_418_3

					if var_418_3 + 0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_3 + 0
					end
				end

				arg_415_1.text_.text = var_418_1
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_4 = math.max(var_418_0, arg_415_1.talkMaxDuration)

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_4 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - 0) / var_418_4

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= 0 + var_418_4 and arg_415_1.time_ < 0 + var_418_4 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play122121103 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 122121103
		arg_419_1.duration_ = 5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play122121104(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 0.625

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, false)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_1 = arg_419_1:FormatText(arg_419_1:GetWordFromCfg(122121103).content)

				arg_419_1.text_.text = var_422_1

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_3 = 25 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_1) / 25)

				if (25 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_1) / 25)) > 0 and var_422_0 < var_422_3 then
					arg_419_1.talkMaxDuration = var_422_3

					if var_422_3 + 0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_3 + 0
					end
				end

				arg_419_1.text_.text = var_422_1
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_4 = math.max(var_422_0, arg_419_1.talkMaxDuration)

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_4 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - 0) / var_422_4

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= 0 + var_422_4 and arg_419_1.time_ < 0 + var_422_4 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play122121104 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 122121104
		arg_423_1.duration_ = 16.2

		local var_423_0 = {
			ja = 16.2,
			ko = 13.1,
			zh = 13.1
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
				arg_423_0:Play122121105(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if arg_423_1.bgs_.ST17 == nil then
				local var_426_0 = Object.Instantiate(arg_423_1.paintGo_)

				var_426_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST17")
				var_426_0.name = "ST17"
				var_426_0.transform.parent = arg_423_1.stage_.transform
				var_426_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_423_1.bgs_.ST17 = var_426_0
			end

			if 3 < arg_423_1.time_ and arg_423_1.time_ <= 3 + arg_426_0 then
				local var_426_1 = arg_423_1.bgs_.ST17

				arg_423_1.bgs_.ST17.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_426_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_426_2 = var_426_1:GetComponent("SpriteRenderer")

				if var_426_2 and var_426_2.sprite then
					local var_426_3 = 2 * (var_426_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_426_1.transform.localScale = Vector3.New(var_426_3 / var_426_2.sprite.bounds.size.y < var_426_3 * manager.ui.mainCameraCom_.aspect / var_426_2.sprite.bounds.size.x and var_426_3 * manager.ui.mainCameraCom_.aspect / var_426_2.sprite.bounds.size.x or var_426_3 / var_426_2.sprite.bounds.size.y, var_426_3 / var_426_2.sprite.bounds.size.y < var_426_3 * manager.ui.mainCameraCom_.aspect / var_426_2.sprite.bounds.size.x and var_426_3 * manager.ui.mainCameraCom_.aspect / var_426_2.sprite.bounds.size.x or var_426_3 / var_426_2.sprite.bounds.size.y, 0)
				end

				for iter_426_0, iter_426_1 in pairs(arg_423_1.bgs_) do
					if iter_426_0 ~= "ST17" then
						iter_426_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_426_4 = 0

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_4 + arg_426_0 then
				arg_423_1.mask_.enabled = true
				arg_423_1.mask_.raycastTarget = true

				arg_423_1:SetGaussion(false)
			end

			local var_426_5 = 3

			if var_426_4 <= arg_423_1.time_ and arg_423_1.time_ < var_426_4 + var_426_5 then
				local var_426_6 = Color.New(0, 0, 0)

				var_426_6.a = Mathf.Lerp(0, 1, (arg_423_1.time_ - var_426_4) / var_426_5)
				arg_423_1.mask_.color = var_426_6
			end

			if arg_423_1.time_ >= var_426_4 + var_426_5 and arg_423_1.time_ < var_426_4 + var_426_5 + arg_426_0 then
				local var_426_7 = Color.New(0, 0, 0)

				var_426_7.a = 1
				arg_423_1.mask_.color = var_426_7
			end

			local var_426_8 = 3

			if 3 < arg_423_1.time_ and arg_423_1.time_ <= var_426_8 + arg_426_0 then
				arg_423_1.mask_.enabled = true
				arg_423_1.mask_.raycastTarget = true

				arg_423_1:SetGaussion(false)
			end

			local var_426_9 = 3

			if var_426_8 <= arg_423_1.time_ and arg_423_1.time_ < var_426_8 + var_426_9 then
				local var_426_10 = Color.New(0, 0, 0)

				var_426_10.a = Mathf.Lerp(1, 0, (arg_423_1.time_ - var_426_8) / var_426_9)
				arg_423_1.mask_.color = var_426_10
			end

			if arg_423_1.time_ >= var_426_8 + var_426_9 and arg_423_1.time_ < var_426_8 + var_426_9 + arg_426_0 then
				local var_426_11 = Color.New(0, 0, 0)

				arg_423_1.mask_.enabled = false
				var_426_11.a = 0
				arg_423_1.mask_.color = var_426_11
			end

			local var_426_12 = arg_423_1.actors_["1084ui_story"].transform

			if 5.8 < arg_423_1.time_ and arg_423_1.time_ <= 5.8 + arg_426_0 then
				arg_423_1.var_.moveOldPos1084ui_story = var_426_12.localPosition
			end

			local var_426_13 = 0.001

			if 5.8 <= arg_423_1.time_ and arg_423_1.time_ < 5.8 + var_426_13 then
				var_426_12.localPosition = Vector3.Lerp(arg_423_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_423_1.time_ - 5.8) / var_426_13)
				var_426_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_426_12.position).x, (manager.ui.mainCamera.transform.position - var_426_12.position).y, (manager.ui.mainCamera.transform.position - var_426_12.position).z)
				var_426_12.localEulerAngles.z = 0
				var_426_12.localEulerAngles.x = 0
				var_426_12.localEulerAngles = var_426_12.localEulerAngles
			end

			if arg_423_1.time_ >= 5.8 + var_426_13 and arg_423_1.time_ < 5.8 + var_426_13 + arg_426_0 then
				var_426_12.localPosition = Vector3.New(0, -0.97, -6)
				var_426_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_426_12.position).x, (manager.ui.mainCamera.transform.position - var_426_12.position).y, (manager.ui.mainCamera.transform.position - var_426_12.position).z)
				var_426_12.localEulerAngles.z = 0
				var_426_12.localEulerAngles.x = 0
				var_426_12.localEulerAngles = var_426_12.localEulerAngles
			end

			local var_426_14 = arg_423_1.actors_["1084ui_story"]

			if 5.8 < arg_423_1.time_ and arg_423_1.time_ <= 5.8 + arg_426_0 and not isNil(var_426_14) and arg_423_1.var_.characterEffect1084ui_story == nil then
				arg_423_1.var_.characterEffect1084ui_story = var_426_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_15 = 0.200000002980232

			if 5.8 <= arg_423_1.time_ and arg_423_1.time_ < 5.8 + var_426_15 and not isNil(var_426_14) then
				if arg_423_1.var_.characterEffect1084ui_story and not isNil(var_426_14) then
					arg_423_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_423_1.time_ >= 5.8 + var_426_15 and arg_423_1.time_ < 5.8 + var_426_15 + arg_426_0 and not isNil(var_426_14) and arg_423_1.var_.characterEffect1084ui_story then
				arg_423_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 5.8 < arg_423_1.time_ and arg_423_1.time_ <= 5.8 + arg_426_0 then
				arg_423_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_1")
			end

			if 5.8 < arg_423_1.time_ and arg_423_1.time_ <= 5.8 + arg_426_0 then
				arg_423_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_426_17 = 3

			arg_423_1.isInRecall_ = false

			if var_426_17 < arg_423_1.time_ and arg_423_1.time_ <= var_426_17 + arg_426_0 then
				arg_423_1.screenFilterGo_:SetActive(true)

				arg_423_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_426_2, iter_426_3 in pairs(arg_423_1.actors_) do
					for iter_426_4, iter_426_5 in ipairs((iter_426_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_426_5.color = iter_426_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_426_18 = 0.0166666666666667

			if var_426_17 <= arg_423_1.time_ and arg_423_1.time_ < var_426_17 + var_426_18 then
				arg_423_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_423_1.time_ - var_426_17) / var_426_18)
			end

			if arg_423_1.time_ >= var_426_17 + var_426_18 and arg_423_1.time_ < var_426_17 + var_426_18 + arg_426_0 then
				arg_423_1.screenFilterEffect_.weight = 1
			end

			if arg_423_1.frameCnt_ <= 1 then
				arg_423_1.dialog_:SetActive(false)
			end

			local var_426_19 = 6
			local var_426_20 = 1.1

			if 6 < arg_423_1.time_ and arg_423_1.time_ <= var_426_19 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0

				arg_423_1.dialog_:SetActive(true)

				arg_423_1.dialogCg_.alpha = 0

				local var_426_21 = LeanTween.value(arg_423_1.dialog_, 0, 1, 0.3)

				var_426_21:setOnUpdate(LuaHelper.FloatAction(function(arg_427_0)
					arg_423_1.dialogCg_.alpha = arg_427_0
				end))
				var_426_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_423_1.dialog_)
					var_426_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_423_1.duration_ = arg_423_1.duration_ + 0.3

				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_22 = arg_423_1:GetWordFromCfg(122121104)
				local var_426_23 = arg_423_1:FormatText(var_426_22.content)

				arg_423_1.text_.text = var_426_23

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_25 = 44 <= 0 and var_426_20 or var_426_20 * (utf8.len(var_426_23) / 44)

				if (44 <= 0 and var_426_20 or var_426_20 * (utf8.len(var_426_23) / 44)) > 0 and var_426_20 < var_426_25 then
					arg_423_1.talkMaxDuration = var_426_25
					var_426_19 = var_426_19 + 0.3

					if var_426_25 + var_426_19 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_25 + var_426_19
					end
				end

				arg_423_1.text_.text = var_426_23
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121104", "story_v_out_122121.awb") ~= 0 then
					local var_426_26 = manager.audio:GetVoiceLength("story_v_out_122121", "122121104", "story_v_out_122121.awb") / 1000

					if var_426_26 + var_426_19 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_26 + var_426_19
					end

					if var_426_22.prefab_name ~= "" and arg_423_1.actors_[var_426_22.prefab_name] ~= nil then
						local var_426_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_22.prefab_name].transform, "story_v_out_122121", "122121104", "story_v_out_122121.awb")

						arg_423_1:RecordAudio("122121104", var_426_27)
						arg_423_1:RecordAudio("122121104", var_426_27)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_122121", "122121104", "story_v_out_122121.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_122121", "122121104", "story_v_out_122121.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_28 = var_426_19 + 0.3
			local var_426_29 = math.max(var_426_20, arg_423_1.talkMaxDuration)

			if var_426_19 + 0.3 <= arg_423_1.time_ and arg_423_1.time_ < var_426_28 + var_426_29 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_28) / var_426_29

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_28 + var_426_29 and arg_423_1.time_ < var_426_28 + var_426_29 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 5.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_423_1:InitPlayNodeList()
	end,
	Play122121105 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 122121105
		arg_429_1.duration_ = 9

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play122121106(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if 2 < arg_429_1.time_ and arg_429_1.time_ <= 2 + arg_432_0 then
				local var_432_0 = arg_429_1.bgs_.ST12

				arg_429_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_432_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_432_1 = var_432_0:GetComponent("SpriteRenderer")

				if var_432_1 and var_432_1.sprite then
					local var_432_2 = 2 * (var_432_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_432_0.transform.localScale = Vector3.New(var_432_2 / var_432_1.sprite.bounds.size.y < var_432_2 * manager.ui.mainCameraCom_.aspect / var_432_1.sprite.bounds.size.x and var_432_2 * manager.ui.mainCameraCom_.aspect / var_432_1.sprite.bounds.size.x or var_432_2 / var_432_1.sprite.bounds.size.y, var_432_2 / var_432_1.sprite.bounds.size.y < var_432_2 * manager.ui.mainCameraCom_.aspect / var_432_1.sprite.bounds.size.x and var_432_2 * manager.ui.mainCameraCom_.aspect / var_432_1.sprite.bounds.size.x or var_432_2 / var_432_1.sprite.bounds.size.y, 0)
				end

				for iter_432_0, iter_432_1 in pairs(arg_429_1.bgs_) do
					if iter_432_0 ~= "ST12" then
						iter_432_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_432_3 = 0

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_3 + arg_432_0 then
				arg_429_1.mask_.enabled = true
				arg_429_1.mask_.raycastTarget = true

				arg_429_1:SetGaussion(false)
			end

			local var_432_4 = 2

			if var_432_3 <= arg_429_1.time_ and arg_429_1.time_ < var_432_3 + var_432_4 then
				local var_432_5 = Color.New(0, 0, 0)

				var_432_5.a = Mathf.Lerp(0, 1, (arg_429_1.time_ - var_432_3) / var_432_4)
				arg_429_1.mask_.color = var_432_5
			end

			if arg_429_1.time_ >= var_432_3 + var_432_4 and arg_429_1.time_ < var_432_3 + var_432_4 + arg_432_0 then
				local var_432_6 = Color.New(0, 0, 0)

				var_432_6.a = 1
				arg_429_1.mask_.color = var_432_6
			end

			local var_432_7 = 2

			if 2 < arg_429_1.time_ and arg_429_1.time_ <= var_432_7 + arg_432_0 then
				arg_429_1.mask_.enabled = true
				arg_429_1.mask_.raycastTarget = true

				arg_429_1:SetGaussion(false)
			end

			local var_432_8 = 2

			if var_432_7 <= arg_429_1.time_ and arg_429_1.time_ < var_432_7 + var_432_8 then
				local var_432_9 = Color.New(0, 0, 0)

				var_432_9.a = Mathf.Lerp(1, 0, (arg_429_1.time_ - var_432_7) / var_432_8)
				arg_429_1.mask_.color = var_432_9
			end

			if arg_429_1.time_ >= var_432_7 + var_432_8 and arg_429_1.time_ < var_432_7 + var_432_8 + arg_432_0 then
				local var_432_10 = Color.New(0, 0, 0)

				arg_429_1.mask_.enabled = false
				var_432_10.a = 0
				arg_429_1.mask_.color = var_432_10
			end

			local var_432_11 = 1.98333333333333

			arg_429_1.isInRecall_ = false

			if var_432_11 < arg_429_1.time_ and arg_429_1.time_ <= var_432_11 + arg_432_0 then
				arg_429_1.screenFilterGo_:SetActive(false)

				for iter_432_2, iter_432_3 in pairs(arg_429_1.actors_) do
					for iter_432_4, iter_432_5 in ipairs((iter_432_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_432_5.color = iter_432_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_432_12 = 0.0166666666666667

			if var_432_11 <= arg_429_1.time_ and arg_429_1.time_ < var_432_11 + var_432_12 then
				arg_429_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_429_1.time_ - var_432_11) / var_432_12)
			end

			if arg_429_1.time_ >= var_432_11 + var_432_12 and arg_429_1.time_ < var_432_11 + var_432_12 + arg_432_0 then
				arg_429_1.screenFilterEffect_.weight = 0
			end

			local var_432_13 = arg_429_1.actors_["1084ui_story"].transform

			if 1.98333333333333 < arg_429_1.time_ and arg_429_1.time_ <= 1.98333333333333 + arg_432_0 then
				arg_429_1.var_.moveOldPos1084ui_story = var_432_13.localPosition
			end

			local var_432_14 = 0.001

			if 1.98333333333333 <= arg_429_1.time_ and arg_429_1.time_ < 1.98333333333333 + var_432_14 then
				var_432_13.localPosition = Vector3.Lerp(arg_429_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_429_1.time_ - 1.98333333333333) / var_432_14)
				var_432_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_432_13.position).x, (manager.ui.mainCamera.transform.position - var_432_13.position).y, (manager.ui.mainCamera.transform.position - var_432_13.position).z)
				var_432_13.localEulerAngles.z = 0
				var_432_13.localEulerAngles.x = 0
				var_432_13.localEulerAngles = var_432_13.localEulerAngles
			end

			if arg_429_1.time_ >= 1.98333333333333 + var_432_14 and arg_429_1.time_ < 1.98333333333333 + var_432_14 + arg_432_0 then
				var_432_13.localPosition = Vector3.New(0, 100, 0)
				var_432_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_432_13.position).x, (manager.ui.mainCamera.transform.position - var_432_13.position).y, (manager.ui.mainCamera.transform.position - var_432_13.position).z)
				var_432_13.localEulerAngles.z = 0
				var_432_13.localEulerAngles.x = 0
				var_432_13.localEulerAngles = var_432_13.localEulerAngles
			end

			local var_432_15 = "ST12_blur"

			if arg_429_1.bgs_.ST12_blur == nil then
				local var_432_16 = Object.Instantiate(arg_429_1.blurPaintGo_)

				var_432_16:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_432_15)
				var_432_16.name = var_432_15
				var_432_16.transform.parent = arg_429_1.stage_.transform
				var_432_16.transform.localPosition = Vector3.New(0, 100, 0)
				arg_429_1.bgs_[var_432_15] = var_432_16
			end

			local var_432_17 = 2
			local var_432_18 = arg_429_1.bgs_[var_432_15]

			if 2 < arg_429_1.time_ and arg_429_1.time_ <= var_432_17 + arg_432_0 then
				var_432_18.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_432_18.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_432_19 = var_432_18:GetComponent("SpriteRenderer")

				if var_432_19 and var_432_19.sprite then
					local var_432_20 = 2 * (var_432_18.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_432_18.transform.localScale = Vector3.New(var_432_20 / var_432_19.sprite.bounds.size.y < var_432_20 * manager.ui.mainCameraCom_.aspect / var_432_19.sprite.bounds.size.x and var_432_20 * manager.ui.mainCameraCom_.aspect / var_432_19.sprite.bounds.size.x or var_432_20 / var_432_19.sprite.bounds.size.y, var_432_20 / var_432_19.sprite.bounds.size.y < var_432_20 * manager.ui.mainCameraCom_.aspect / var_432_19.sprite.bounds.size.x and var_432_20 * manager.ui.mainCameraCom_.aspect / var_432_19.sprite.bounds.size.x or var_432_20 / var_432_19.sprite.bounds.size.y, 0)
				end
			end

			local var_432_21 = 2

			if var_432_17 <= arg_429_1.time_ and arg_429_1.time_ < var_432_17 + var_432_21 then
				local var_432_22 = Color.New(1, 1, 1)

				var_432_22.a = Mathf.Lerp(1, 0, (arg_429_1.time_ - var_432_17) / var_432_21)

				var_432_18:GetComponent("SpriteRenderer").material:SetColor("_Color", var_432_22)
			end

			if arg_429_1.frameCnt_ <= 1 then
				arg_429_1.dialog_:SetActive(false)
			end

			local var_432_23 = 4
			local var_432_24 = 0.45

			if 4 < arg_429_1.time_ and arg_429_1.time_ <= var_432_23 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0

				arg_429_1.dialog_:SetActive(true)

				arg_429_1.dialogCg_.alpha = 0

				local var_432_25 = LeanTween.value(arg_429_1.dialog_, 0, 1, 0.3)

				var_432_25:setOnUpdate(LuaHelper.FloatAction(function(arg_433_0)
					arg_429_1.dialogCg_.alpha = arg_433_0
				end))
				var_432_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_429_1.dialog_)
					var_432_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_429_1.duration_ = arg_429_1.duration_ + 0.3

				SetActive(arg_429_1.leftNameGo_, true)

				arg_429_1.leftNameTxt_.text = arg_429_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, true)
				arg_429_1.iconController_:SetSelectedState("hero")

				arg_429_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_429_1.callingController_:SetSelectedState("normal")

				arg_429_1.keyicon_.color = Color.New(1, 1, 1)
				arg_429_1.icon_.color = Color.New(1, 1, 1)

				local var_432_26 = arg_429_1:FormatText(arg_429_1:GetWordFromCfg(122121105).content)

				arg_429_1.text_.text = var_432_26

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_28 = 18 <= 0 and var_432_24 or var_432_24 * (utf8.len(var_432_26) / 18)

				if (18 <= 0 and var_432_24 or var_432_24 * (utf8.len(var_432_26) / 18)) > 0 and var_432_24 < var_432_28 then
					arg_429_1.talkMaxDuration = var_432_28
					var_432_23 = var_432_23 + 0.3

					if var_432_28 + var_432_23 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_28 + var_432_23
					end
				end

				arg_429_1.text_.text = var_432_26
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_29 = var_432_23 + 0.3
			local var_432_30 = math.max(var_432_24, arg_429_1.talkMaxDuration)

			if var_432_23 + 0.3 <= arg_429_1.time_ and arg_429_1.time_ < var_432_29 + var_432_30 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_29) / var_432_30

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_29 + var_432_30 and arg_429_1.time_ < var_432_29 + var_432_30 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_429_1:InitPlayNodeList()
	end,
	Play122121106 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 122121106
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play122121107(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1.mask_.enabled = true
				arg_435_1.mask_.raycastTarget = true

				arg_435_1:SetGaussion(false)
			end

			local var_438_0 = 0.5

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_0 then
				local var_438_1 = Color.New(0, 0, 0)

				var_438_1.a = Mathf.Lerp(0, 1, (arg_435_1.time_ - 0) / var_438_0)
				arg_435_1.mask_.color = var_438_1
			end

			if arg_435_1.time_ >= 0 + var_438_0 and arg_435_1.time_ < 0 + var_438_0 + arg_438_0 then
				local var_438_2 = Color.New(0, 0, 0)

				var_438_2.a = 1
				arg_435_1.mask_.color = var_438_2
			end

			local var_438_3 = 0.5

			if 0.5 < arg_435_1.time_ and arg_435_1.time_ <= var_438_3 + arg_438_0 then
				arg_435_1.mask_.enabled = true
				arg_435_1.mask_.raycastTarget = true

				arg_435_1:SetGaussion(false)
			end

			local var_438_4 = 0.5

			if var_438_3 <= arg_435_1.time_ and arg_435_1.time_ < var_438_3 + var_438_4 then
				local var_438_5 = Color.New(0, 0, 0)

				var_438_5.a = Mathf.Lerp(1, 0, (arg_435_1.time_ - var_438_3) / var_438_4)
				arg_435_1.mask_.color = var_438_5
			end

			if arg_435_1.time_ >= var_438_3 + var_438_4 and arg_435_1.time_ < var_438_3 + var_438_4 + arg_438_0 then
				local var_438_6 = Color.New(0, 0, 0)

				arg_435_1.mask_.enabled = false
				var_438_6.a = 0
				arg_435_1.mask_.color = var_438_6
			end

			local var_438_7 = "ST12_blur"

			if arg_435_1.bgs_.ST12_blur == nil then
				local var_438_8 = Object.Instantiate(arg_435_1.blurPaintGo_)

				var_438_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_438_7)
				var_438_8.name = var_438_7
				var_438_8.transform.parent = arg_435_1.stage_.transform
				var_438_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_435_1.bgs_[var_438_7] = var_438_8
			end

			local var_438_9 = 0
			local var_438_10 = arg_435_1.bgs_[var_438_7]

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_9 + arg_438_0 then
				var_438_10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_438_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_438_11 = var_438_10:GetComponent("SpriteRenderer")

				if var_438_11 and var_438_11.sprite then
					local var_438_12 = 2 * (var_438_10.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_438_10.transform.localScale = Vector3.New(var_438_12 / var_438_11.sprite.bounds.size.y < var_438_12 * manager.ui.mainCameraCom_.aspect / var_438_11.sprite.bounds.size.x and var_438_12 * manager.ui.mainCameraCom_.aspect / var_438_11.sprite.bounds.size.x or var_438_12 / var_438_11.sprite.bounds.size.y, var_438_12 / var_438_11.sprite.bounds.size.y < var_438_12 * manager.ui.mainCameraCom_.aspect / var_438_11.sprite.bounds.size.x and var_438_12 * manager.ui.mainCameraCom_.aspect / var_438_11.sprite.bounds.size.x or var_438_12 / var_438_11.sprite.bounds.size.y, 0)
				end
			end

			local var_438_13 = 2

			if var_438_9 <= arg_435_1.time_ and arg_435_1.time_ < var_438_9 + var_438_13 then
				local var_438_14 = Color.New(1, 1, 1)

				var_438_14.a = Mathf.Lerp(0, 1, (arg_435_1.time_ - var_438_9) / var_438_13)

				var_438_10:GetComponent("SpriteRenderer").material:SetColor("_Color", var_438_14)
			end

			local var_438_15 = 0
			local var_438_16 = 1

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_15 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, false)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_17 = arg_435_1:FormatText(arg_435_1:GetWordFromCfg(122121106).content)

				arg_435_1.text_.text = var_438_17

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_19 = 40 <= 0 and var_438_16 or var_438_16 * (utf8.len(var_438_17) / 40)

				if (40 <= 0 and var_438_16 or var_438_16 * (utf8.len(var_438_17) / 40)) > 0 and var_438_16 < var_438_19 then
					arg_435_1.talkMaxDuration = var_438_19

					if var_438_19 + var_438_15 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_19 + var_438_15
					end
				end

				arg_435_1.text_.text = var_438_17
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_20 = math.max(var_438_16, arg_435_1.talkMaxDuration)

			if var_438_15 <= arg_435_1.time_ and arg_435_1.time_ < var_438_15 + var_438_20 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_15) / var_438_20

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_15 + var_438_20 and arg_435_1.time_ < var_438_15 + var_438_20 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play122121107 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 122121107
		arg_439_1.duration_ = 5

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play122121108(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 1.425

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, false)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_1 = arg_439_1:FormatText(arg_439_1:GetWordFromCfg(122121107).content)

				arg_439_1.text_.text = var_442_1

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_3 = 57 <= 0 and var_442_0 or var_442_0 * (utf8.len(var_442_1) / 57)

				if (57 <= 0 and var_442_0 or var_442_0 * (utf8.len(var_442_1) / 57)) > 0 and var_442_0 < var_442_3 then
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
	Play122121108 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 122121108
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play122121109(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = 0.325

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				arg_443_1.leftNameTxt_.text = arg_443_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, true)
				arg_443_1.iconController_:SetSelectedState("hero")

				arg_443_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_443_1.callingController_:SetSelectedState("normal")

				arg_443_1.keyicon_.color = Color.New(1, 1, 1)
				arg_443_1.icon_.color = Color.New(1, 1, 1)

				local var_446_1 = arg_443_1:FormatText(arg_443_1:GetWordFromCfg(122121108).content)

				arg_443_1.text_.text = var_446_1

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_3 = 13 <= 0 and var_446_0 or var_446_0 * (utf8.len(var_446_1) / 13)

				if (13 <= 0 and var_446_0 or var_446_0 * (utf8.len(var_446_1) / 13)) > 0 and var_446_0 < var_446_3 then
					arg_443_1.talkMaxDuration = var_446_3

					if var_446_3 + 0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_3 + 0
					end
				end

				arg_443_1.text_.text = var_446_1
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)
				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_4 = math.max(var_446_0, arg_443_1.talkMaxDuration)

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_4 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - 0) / var_446_4

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= 0 + var_446_4 and arg_443_1.time_ < 0 + var_446_4 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play122121109 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 122121109
		arg_447_1.duration_ = 4.93

		local var_447_0 = {
			ja = 4.5,
			ko = 4.933,
			zh = 4.933
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
				arg_447_0:Play122121110(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = 0.7

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				arg_447_1.leftNameTxt_.text = arg_447_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, true)
				arg_447_1.iconController_:SetSelectedState("hero")

				arg_447_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1032")

				arg_447_1.callingController_:SetSelectedState("normal")

				arg_447_1.keyicon_.color = Color.New(1, 1, 1)
				arg_447_1.icon_.color = Color.New(1, 1, 1)

				local var_450_1 = arg_447_1:GetWordFromCfg(122121109)
				local var_450_2 = arg_447_1:FormatText(var_450_1.content)

				arg_447_1.text_.text = var_450_2

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_4 = 28 <= 0 and var_450_0 or var_450_0 * (utf8.len(var_450_2) / 28)

				if (28 <= 0 and var_450_0 or var_450_0 * (utf8.len(var_450_2) / 28)) > 0 and var_450_0 < var_450_4 then
					arg_447_1.talkMaxDuration = var_450_4

					if var_450_4 + 0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_4 + 0
					end
				end

				arg_447_1.text_.text = var_450_2
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121109", "story_v_out_122121.awb") ~= 0 then
					local var_450_5 = manager.audio:GetVoiceLength("story_v_out_122121", "122121109", "story_v_out_122121.awb") / 1000

					if var_450_5 + 0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_5 + 0
					end

					if var_450_1.prefab_name ~= "" and arg_447_1.actors_[var_450_1.prefab_name] ~= nil then
						local var_450_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_1.prefab_name].transform, "story_v_out_122121", "122121109", "story_v_out_122121.awb")

						arg_447_1:RecordAudio("122121109", var_450_6)
						arg_447_1:RecordAudio("122121109", var_450_6)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_out_122121", "122121109", "story_v_out_122121.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_out_122121", "122121109", "story_v_out_122121.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_7 = math.max(var_450_0, arg_447_1.talkMaxDuration)

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_7 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - 0) / var_450_7

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= 0 + var_450_7 and arg_447_1.time_ < 0 + var_450_7 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play122121110 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 122121110
		arg_451_1.duration_ = 5

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play122121111(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = 0.75

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				arg_451_1.leftNameTxt_.text = arg_451_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, true)
				arg_451_1.iconController_:SetSelectedState("hero")

				arg_451_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_451_1.callingController_:SetSelectedState("normal")

				arg_451_1.keyicon_.color = Color.New(1, 1, 1)
				arg_451_1.icon_.color = Color.New(1, 1, 1)

				local var_454_1 = arg_451_1:FormatText(arg_451_1:GetWordFromCfg(122121110).content)

				arg_451_1.text_.text = var_454_1

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_3 = 30 <= 0 and var_454_0 or var_454_0 * (utf8.len(var_454_1) / 30)

				if (30 <= 0 and var_454_0 or var_454_0 * (utf8.len(var_454_1) / 30)) > 0 and var_454_0 < var_454_3 then
					arg_451_1.talkMaxDuration = var_454_3

					if var_454_3 + 0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_3 + 0
					end
				end

				arg_451_1.text_.text = var_454_1
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)
				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_4 = math.max(var_454_0, arg_451_1.talkMaxDuration)

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_4 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - 0) / var_454_4

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= 0 + var_454_4 and arg_451_1.time_ < 0 + var_454_4 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play122121111 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 122121111
		arg_455_1.duration_ = 1.37

		local var_455_0 = {
			ja = 1.133,
			ko = 1.366,
			zh = 1.366
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
				arg_455_0:Play122121112(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = 0.05

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				arg_455_1.leftNameTxt_.text = arg_455_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, true)
				arg_455_1.iconController_:SetSelectedState("hero")

				arg_455_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1032")

				arg_455_1.callingController_:SetSelectedState("normal")

				arg_455_1.keyicon_.color = Color.New(1, 1, 1)
				arg_455_1.icon_.color = Color.New(1, 1, 1)

				local var_458_1 = arg_455_1:GetWordFromCfg(122121111)
				local var_458_2 = arg_455_1:FormatText(var_458_1.content)

				arg_455_1.text_.text = var_458_2

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_4 = 2 <= 0 and var_458_0 or var_458_0 * (utf8.len(var_458_2) / 2)

				if (2 <= 0 and var_458_0 or var_458_0 * (utf8.len(var_458_2) / 2)) > 0 and var_458_0 < var_458_4 then
					arg_455_1.talkMaxDuration = var_458_4

					if var_458_4 + 0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_4 + 0
					end
				end

				arg_455_1.text_.text = var_458_2
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121111", "story_v_out_122121.awb") ~= 0 then
					local var_458_5 = manager.audio:GetVoiceLength("story_v_out_122121", "122121111", "story_v_out_122121.awb") / 1000

					if var_458_5 + 0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_5 + 0
					end

					if var_458_1.prefab_name ~= "" and arg_455_1.actors_[var_458_1.prefab_name] ~= nil then
						local var_458_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_1.prefab_name].transform, "story_v_out_122121", "122121111", "story_v_out_122121.awb")

						arg_455_1:RecordAudio("122121111", var_458_6)
						arg_455_1:RecordAudio("122121111", var_458_6)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_out_122121", "122121111", "story_v_out_122121.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_out_122121", "122121111", "story_v_out_122121.awb")
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
	Play122121112 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 122121112
		arg_459_1.duration_ = 5

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play122121113(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = 1

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

				local var_462_1 = arg_459_1:FormatText(arg_459_1:GetWordFromCfg(122121112).content)

				arg_459_1.text_.text = var_462_1

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_3 = 40 <= 0 and var_462_0 or var_462_0 * (utf8.len(var_462_1) / 40)

				if (40 <= 0 and var_462_0 or var_462_0 * (utf8.len(var_462_1) / 40)) > 0 and var_462_0 < var_462_3 then
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
	Play122121113 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 122121113
		arg_463_1.duration_ = 7.4

		local var_463_0 = {
			ja = 6.9,
			ko = 7.4,
			zh = 7.4
		}
		local var_463_1 = manager.audio:GetLocalizationFlag()

		if var_463_0[var_463_1] ~= nil then
			arg_463_1.duration_ = var_463_0[var_463_1]
		end

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play122121114(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = 1

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				arg_463_1.leftNameTxt_.text = arg_463_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, true)
				arg_463_1.iconController_:SetSelectedState("hero")

				arg_463_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1032")

				arg_463_1.callingController_:SetSelectedState("normal")

				arg_463_1.keyicon_.color = Color.New(1, 1, 1)
				arg_463_1.icon_.color = Color.New(1, 1, 1)

				local var_466_1 = arg_463_1:GetWordFromCfg(122121113)
				local var_466_2 = arg_463_1:FormatText(var_466_1.content)

				arg_463_1.text_.text = var_466_2

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_4 = 40 <= 0 and var_466_0 or var_466_0 * (utf8.len(var_466_2) / 40)

				if (40 <= 0 and var_466_0 or var_466_0 * (utf8.len(var_466_2) / 40)) > 0 and var_466_0 < var_466_4 then
					arg_463_1.talkMaxDuration = var_466_4

					if var_466_4 + 0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_4 + 0
					end
				end

				arg_463_1.text_.text = var_466_2
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121113", "story_v_out_122121.awb") ~= 0 then
					local var_466_5 = manager.audio:GetVoiceLength("story_v_out_122121", "122121113", "story_v_out_122121.awb") / 1000

					if var_466_5 + 0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_5 + 0
					end

					if var_466_1.prefab_name ~= "" and arg_463_1.actors_[var_466_1.prefab_name] ~= nil then
						local var_466_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_1.prefab_name].transform, "story_v_out_122121", "122121113", "story_v_out_122121.awb")

						arg_463_1:RecordAudio("122121113", var_466_6)
						arg_463_1:RecordAudio("122121113", var_466_6)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_out_122121", "122121113", "story_v_out_122121.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_out_122121", "122121113", "story_v_out_122121.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_7 = math.max(var_466_0, arg_463_1.talkMaxDuration)

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_7 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - 0) / var_466_7

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= 0 + var_466_7 and arg_463_1.time_ < 0 + var_466_7 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play122121114 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 122121114
		arg_467_1.duration_ = 10.87

		local var_467_0 = {
			ja = 10.866,
			ko = 7.4,
			zh = 7.4
		}
		local var_467_1 = manager.audio:GetLocalizationFlag()

		if var_467_0[var_467_1] ~= nil then
			arg_467_1.duration_ = var_467_0[var_467_1]
		end

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play122121115(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = 0.8

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				arg_467_1.leftNameTxt_.text = arg_467_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, true)
				arg_467_1.iconController_:SetSelectedState("hero")

				arg_467_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1032")

				arg_467_1.callingController_:SetSelectedState("normal")

				arg_467_1.keyicon_.color = Color.New(1, 1, 1)
				arg_467_1.icon_.color = Color.New(1, 1, 1)

				local var_470_1 = arg_467_1:GetWordFromCfg(122121114)
				local var_470_2 = arg_467_1:FormatText(var_470_1.content)

				arg_467_1.text_.text = var_470_2

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_4 = 32 <= 0 and var_470_0 or var_470_0 * (utf8.len(var_470_2) / 32)

				if (32 <= 0 and var_470_0 or var_470_0 * (utf8.len(var_470_2) / 32)) > 0 and var_470_0 < var_470_4 then
					arg_467_1.talkMaxDuration = var_470_4

					if var_470_4 + 0 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_4 + 0
					end
				end

				arg_467_1.text_.text = var_470_2
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121114", "story_v_out_122121.awb") ~= 0 then
					local var_470_5 = manager.audio:GetVoiceLength("story_v_out_122121", "122121114", "story_v_out_122121.awb") / 1000

					if var_470_5 + 0 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_5 + 0
					end

					if var_470_1.prefab_name ~= "" and arg_467_1.actors_[var_470_1.prefab_name] ~= nil then
						local var_470_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_467_1.actors_[var_470_1.prefab_name].transform, "story_v_out_122121", "122121114", "story_v_out_122121.awb")

						arg_467_1:RecordAudio("122121114", var_470_6)
						arg_467_1:RecordAudio("122121114", var_470_6)
					else
						arg_467_1:AudioAction("play", "voice", "story_v_out_122121", "122121114", "story_v_out_122121.awb")
					end

					arg_467_1:RecordHistoryTalkVoice("story_v_out_122121", "122121114", "story_v_out_122121.awb")
				end

				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_7 = math.max(var_470_0, arg_467_1.talkMaxDuration)

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_7 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - 0) / var_470_7

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= 0 + var_470_7 and arg_467_1.time_ < 0 + var_470_7 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play122121115 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 122121115
		arg_471_1.duration_ = 11.87

		local var_471_0 = {
			ja = 10.766,
			ko = 11.866,
			zh = 11.866
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
				arg_471_0:Play122121116(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_0 = 0.925

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				arg_471_1.leftNameTxt_.text = arg_471_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, true)
				arg_471_1.iconController_:SetSelectedState("hero")

				arg_471_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1032")

				arg_471_1.callingController_:SetSelectedState("normal")

				arg_471_1.keyicon_.color = Color.New(1, 1, 1)
				arg_471_1.icon_.color = Color.New(1, 1, 1)

				local var_474_1 = arg_471_1:GetWordFromCfg(122121115)
				local var_474_2 = arg_471_1:FormatText(var_474_1.content)

				arg_471_1.text_.text = var_474_2

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_4 = 39 <= 0 and var_474_0 or var_474_0 * (utf8.len(var_474_2) / 39)

				if (39 <= 0 and var_474_0 or var_474_0 * (utf8.len(var_474_2) / 39)) > 0 and var_474_0 < var_474_4 then
					arg_471_1.talkMaxDuration = var_474_4

					if var_474_4 + 0 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_4 + 0
					end
				end

				arg_471_1.text_.text = var_474_2
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121115", "story_v_out_122121.awb") ~= 0 then
					local var_474_5 = manager.audio:GetVoiceLength("story_v_out_122121", "122121115", "story_v_out_122121.awb") / 1000

					if var_474_5 + 0 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_5 + 0
					end

					if var_474_1.prefab_name ~= "" and arg_471_1.actors_[var_474_1.prefab_name] ~= nil then
						local var_474_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_471_1.actors_[var_474_1.prefab_name].transform, "story_v_out_122121", "122121115", "story_v_out_122121.awb")

						arg_471_1:RecordAudio("122121115", var_474_6)
						arg_471_1:RecordAudio("122121115", var_474_6)
					else
						arg_471_1:AudioAction("play", "voice", "story_v_out_122121", "122121115", "story_v_out_122121.awb")
					end

					arg_471_1:RecordHistoryTalkVoice("story_v_out_122121", "122121115", "story_v_out_122121.awb")
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
	Play122121116 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 122121116
		arg_475_1.duration_ = 4.62

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play122121117(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			if arg_475_1.bgs_.ST15a == nil then
				local var_478_0 = Object.Instantiate(arg_475_1.paintGo_)

				var_478_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST15a")
				var_478_0.name = "ST15a"
				var_478_0.transform.parent = arg_475_1.stage_.transform
				var_478_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_475_1.bgs_.ST15a = var_478_0
			end

			if 2 < arg_475_1.time_ and arg_475_1.time_ <= 2 + arg_478_0 then
				local var_478_1 = arg_475_1.bgs_.ST15a

				arg_475_1.bgs_.ST15a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_478_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_478_2 = var_478_1:GetComponent("SpriteRenderer")

				if var_478_2 and var_478_2.sprite then
					local var_478_3 = 2 * (var_478_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_478_1.transform.localScale = Vector3.New(var_478_3 / var_478_2.sprite.bounds.size.y < var_478_3 * manager.ui.mainCameraCom_.aspect / var_478_2.sprite.bounds.size.x and var_478_3 * manager.ui.mainCameraCom_.aspect / var_478_2.sprite.bounds.size.x or var_478_3 / var_478_2.sprite.bounds.size.y, var_478_3 / var_478_2.sprite.bounds.size.y < var_478_3 * manager.ui.mainCameraCom_.aspect / var_478_2.sprite.bounds.size.x and var_478_3 * manager.ui.mainCameraCom_.aspect / var_478_2.sprite.bounds.size.x or var_478_3 / var_478_2.sprite.bounds.size.y, 0)
				end

				for iter_478_0, iter_478_1 in pairs(arg_475_1.bgs_) do
					if iter_478_0 ~= "ST15a" then
						iter_478_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_478_4 = 0

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= var_478_4 + arg_478_0 then
				arg_475_1.mask_.enabled = true
				arg_475_1.mask_.raycastTarget = true

				arg_475_1:SetGaussion(false)
			end

			local var_478_5 = 2

			if var_478_4 <= arg_475_1.time_ and arg_475_1.time_ < var_478_4 + var_478_5 then
				local var_478_6 = Color.New(0, 0, 0)

				var_478_6.a = Mathf.Lerp(0, 1, (arg_475_1.time_ - var_478_4) / var_478_5)
				arg_475_1.mask_.color = var_478_6
			end

			if arg_475_1.time_ >= var_478_4 + var_478_5 and arg_475_1.time_ < var_478_4 + var_478_5 + arg_478_0 then
				local var_478_7 = Color.New(0, 0, 0)

				var_478_7.a = 1
				arg_475_1.mask_.color = var_478_7
			end

			local var_478_8 = 2

			if 2 < arg_475_1.time_ and arg_475_1.time_ <= var_478_8 + arg_478_0 then
				arg_475_1.mask_.enabled = true
				arg_475_1.mask_.raycastTarget = true

				arg_475_1:SetGaussion(false)
			end

			local var_478_9 = 2

			if var_478_8 <= arg_475_1.time_ and arg_475_1.time_ < var_478_8 + var_478_9 then
				local var_478_10 = Color.New(0, 0, 0)

				var_478_10.a = Mathf.Lerp(1, 0, (arg_475_1.time_ - var_478_8) / var_478_9)
				arg_475_1.mask_.color = var_478_10
			end

			if arg_475_1.time_ >= var_478_8 + var_478_9 and arg_475_1.time_ < var_478_8 + var_478_9 + arg_478_0 then
				local var_478_11 = Color.New(0, 0, 0)

				arg_475_1.mask_.enabled = false
				var_478_11.a = 0
				arg_475_1.mask_.color = var_478_11
			end

			if 2 < arg_475_1.time_ and arg_475_1.time_ <= 2 + arg_478_0 then
				arg_475_1.fswbg_:SetActive(true)
				arg_475_1.dialog_:SetActive(false)

				arg_475_1.fswtw_.percent = 0
				arg_475_1.fswt_.text = arg_475_1:FormatText(arg_475_1:GetWordFromCfg(122121116).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.fswt_)

				arg_475_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_475_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_475_1.fswtw_:SetDirty()

				arg_475_1.typewritterCharCountI18N = 0

				SetActive(arg_475_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_475_1:ShowNextGo(false)
			end

			local var_478_12 = 2.01666666666667

			if 2.01666666666667 < arg_475_1.time_ and arg_475_1.time_ <= var_478_12 + arg_478_0 then
				arg_475_1.var_.oldValueTypewriter = arg_475_1.fswtw_.percent

				SetActive(arg_475_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_475_1:ShowNextGo(false)
			end

			local var_478_13 = 29
			local var_478_14 = 1.66666666666667
			local var_478_15, var_478_16 = arg_475_1:GetPercentByPara(arg_475_1:FormatText(arg_475_1:GetWordFromCfg(122121116).content), 1)

			if var_478_12 < arg_475_1.time_ and arg_475_1.time_ <= var_478_12 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0

				local var_478_17 = var_478_13 <= 0 and var_478_14 or var_478_14 * ((var_478_16 - arg_475_1.typewritterCharCountI18N) / var_478_13)

				if (var_478_13 <= 0 and var_478_14 or var_478_14 * ((var_478_16 - arg_475_1.typewritterCharCountI18N) / var_478_13)) > 0 and var_478_14 < var_478_17 then
					arg_475_1.talkMaxDuration = var_478_17

					if var_478_17 + var_478_12 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_17 + var_478_12
					end
				end
			end

			local var_478_18 = math.max(1.66666666666667, arg_475_1.talkMaxDuration)

			if var_478_12 <= arg_475_1.time_ and arg_475_1.time_ < var_478_12 + var_478_18 then
				arg_475_1.fswtw_.percent = Mathf.Lerp(arg_475_1.var_.oldValueTypewriter, var_478_15, (arg_475_1.time_ - var_478_12) / var_478_18)
				arg_475_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_475_1.fswtw_:SetDirty()
			end

			if arg_475_1.time_ >= var_478_12 + var_478_18 and arg_475_1.time_ < var_478_12 + var_478_18 + arg_478_0 then
				arg_475_1.fswtw_.percent = var_478_15

				arg_475_1.fswtw_:SetDirty()
				arg_475_1:ShowNextGo(true)

				arg_475_1.typewritterCharCountI18N = var_478_16
			end

			if 2.01666666666667 < arg_475_1.time_ and arg_475_1.time_ <= 2.01666666666667 + arg_478_0 then
				local var_478_19 = arg_475_1.fswbg_.transform:Find("textbox/adapt/content") or arg_475_1.fswbg_.transform:Find("textbox/content")
				local var_478_20 = arg_475_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_478_21 = var_478_19:GetComponent("RectTransform")

				var_478_19:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_478_21.offsetMin = Vector2.New(0, 0)
				var_478_21.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_478_24 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_475_1.bgmTxt_.text ~= var_478_24 and arg_475_1.bgmTxt_.text ~= "" then
						if arg_475_1.bgmTxt2_.text ~= "" then
							arg_475_1.bgmTxt_.text = arg_475_1.bgmTxt2_.text
						end

						arg_475_1.bgmTxt2_.text = var_478_24

						arg_475_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_475_1.bgmTxt_.text = var_478_24
						arg_475_1.bgmTxt2_.text = var_478_24
					end

					if arg_475_1.bgmTimer then
						arg_475_1.bgmTimer:Stop()

						arg_475_1.bgmTimer = nil
					end

					if arg_475_1.settingData.show_music_name == 1 then
						arg_475_1.musicController:SetSelectedState("show")
						arg_475_1.musicAnimator_:Play("open", 0, 0)

						if arg_475_1.settingData.music_time ~= 0 then
							arg_475_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_475_1.settingData.music_time), function()
								if arg_475_1 == nil or isNil(arg_475_1.bgmTxt_) then
									return
								end

								arg_475_1.musicController:SetSelectedState("hide")
								arg_475_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.46666666666667 < arg_475_1.time_ and arg_475_1.time_ <= 1.46666666666667 + arg_478_0 then
				arg_475_1:AudioAction("play", "effect", "se_story_side_1028", "se_story_1028_smallwaveloop", "")
			end
		end

		arg_475_1.nodeConfigList_ = {}

		arg_475_1:InitPlayNodeList()
	end,
	Play122121117 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 122121117
		arg_480_1.duration_ = 1.35

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play122121118(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 then
				arg_480_1.fswbg_:SetActive(true)
				arg_480_1.dialog_:SetActive(false)

				arg_480_1.fswtw_.percent = 0
				arg_480_1.fswt_.text = arg_480_1:FormatText(arg_480_1:GetWordFromCfg(122121117).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.fswt_)

				arg_480_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_480_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_480_1.fswtw_:SetDirty()

				arg_480_1.typewritterCharCountI18N = 0

				SetActive(arg_480_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_480_1:ShowNextGo(false)
			end

			local var_483_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_480_1.time_ and arg_480_1.time_ <= var_483_0 + arg_483_0 then
				arg_480_1.var_.oldValueTypewriter = arg_480_1.fswtw_.percent

				SetActive(arg_480_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_480_1:ShowNextGo(false)
			end

			local var_483_1 = 20
			local var_483_2 = 1.33333333333333
			local var_483_3, var_483_4 = arg_480_1:GetPercentByPara(arg_480_1:FormatText(arg_480_1:GetWordFromCfg(122121117).content), 1)

			if var_483_0 < arg_480_1.time_ and arg_480_1.time_ <= var_483_0 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0

				local var_483_5 = var_483_1 <= 0 and var_483_2 or var_483_2 * ((var_483_4 - arg_480_1.typewritterCharCountI18N) / var_483_1)

				if (var_483_1 <= 0 and var_483_2 or var_483_2 * ((var_483_4 - arg_480_1.typewritterCharCountI18N) / var_483_1)) > 0 and var_483_2 < var_483_5 then
					arg_480_1.talkMaxDuration = var_483_5

					if var_483_5 + var_483_0 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_5 + var_483_0
					end
				end
			end

			local var_483_6 = math.max(1.33333333333333, arg_480_1.talkMaxDuration)

			if var_483_0 <= arg_480_1.time_ and arg_480_1.time_ < var_483_0 + var_483_6 then
				arg_480_1.fswtw_.percent = Mathf.Lerp(arg_480_1.var_.oldValueTypewriter, var_483_3, (arg_480_1.time_ - var_483_0) / var_483_6)
				arg_480_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_480_1.fswtw_:SetDirty()
			end

			if arg_480_1.time_ >= var_483_0 + var_483_6 and arg_480_1.time_ < var_483_0 + var_483_6 + arg_483_0 then
				arg_480_1.fswtw_.percent = var_483_3

				arg_480_1.fswtw_:SetDirty()
				arg_480_1:ShowNextGo(true)

				arg_480_1.typewritterCharCountI18N = var_483_4
			end
		end

		arg_480_1.nodeConfigList_ = {}

		arg_480_1:InitPlayNodeList()
	end,
	Play122121118 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 122121118
		arg_484_1.duration_ = 5

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play122121119(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 then
				arg_484_1.fswbg_:SetActive(false)
				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_484_1:ShowNextGo(false)
			end

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 then
				arg_484_1:AudioAction("play", "music", "bgm_activity_1_3_story_destroyed", "bgm_activity_1_3_story_destroyed", "bgm_activity_1_3_story_destroyed.awb")

				local var_487_2 = manager.audio:GetAudioName("bgm_activity_1_3_story_destroyed", "bgm_activity_1_3_story_destroyed")

				if "" ~= "" then
					if arg_484_1.bgmTxt_.text ~= var_487_2 and arg_484_1.bgmTxt_.text ~= "" then
						if arg_484_1.bgmTxt2_.text ~= "" then
							arg_484_1.bgmTxt_.text = arg_484_1.bgmTxt2_.text
						end

						arg_484_1.bgmTxt2_.text = var_487_2

						arg_484_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_484_1.bgmTxt_.text = var_487_2
						arg_484_1.bgmTxt2_.text = var_487_2
					end

					if arg_484_1.bgmTimer then
						arg_484_1.bgmTimer:Stop()

						arg_484_1.bgmTimer = nil
					end

					if arg_484_1.settingData.show_music_name == 1 then
						arg_484_1.musicController:SetSelectedState("show")
						arg_484_1.musicAnimator_:Play("open", 0, 0)

						if arg_484_1.settingData.music_time ~= 0 then
							arg_484_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_484_1.settingData.music_time), function()
								if arg_484_1 == nil or isNil(arg_484_1.bgmTxt_) then
									return
								end

								arg_484_1.musicController:SetSelectedState("hide")
								arg_484_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_487_3 = 0
			local var_487_4 = 1.1

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= var_487_3 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, false)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_484_1.iconTrs_.gameObject, false)
				arg_484_1.callingController_:SetSelectedState("normal")

				local var_487_5 = arg_484_1:FormatText(arg_484_1:GetWordFromCfg(122121118).content)

				arg_484_1.text_.text = var_487_5

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_7 = 44 <= 0 and var_487_4 or var_487_4 * (utf8.len(var_487_5) / 44)

				if (44 <= 0 and var_487_4 or var_487_4 * (utf8.len(var_487_5) / 44)) > 0 and var_487_4 < var_487_7 then
					arg_484_1.talkMaxDuration = var_487_7

					if var_487_7 + var_487_3 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_7 + var_487_3
					end
				end

				arg_484_1.text_.text = var_487_5
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)
				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_8 = math.max(var_487_4, arg_484_1.talkMaxDuration)

			if var_487_3 <= arg_484_1.time_ and arg_484_1.time_ < var_487_3 + var_487_8 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_3) / var_487_8

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_3 + var_487_8 and arg_484_1.time_ < var_487_3 + var_487_8 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play122121119 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 122121119
		arg_489_1.duration_ = 4.13

		local var_489_0 = {
			ja = 4.133,
			ko = 3.166,
			zh = 3.166
		}
		local var_489_1 = manager.audio:GetLocalizationFlag()

		if var_489_0[var_489_1] ~= nil then
			arg_489_1.duration_ = var_489_0[var_489_1]
		end

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play122121120(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = 0.35

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				arg_489_1.leftNameTxt_.text = arg_489_1:FormatText(StoryNameCfg[146].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, true)
				arg_489_1.iconController_:SetSelectedState("hero")

				arg_489_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_489_1.callingController_:SetSelectedState("normal")

				arg_489_1.keyicon_.color = Color.New(1, 1, 1)
				arg_489_1.icon_.color = Color.New(1, 1, 1)

				local var_492_1 = arg_489_1:GetWordFromCfg(122121119)
				local var_492_2 = arg_489_1:FormatText(var_492_1.content)

				arg_489_1.text_.text = var_492_2

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_4 = 14 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_2) / 14)

				if (14 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_2) / 14)) > 0 and var_492_0 < var_492_4 then
					arg_489_1.talkMaxDuration = var_492_4

					if var_492_4 + 0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_4 + 0
					end
				end

				arg_489_1.text_.text = var_492_2
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121119", "story_v_out_122121.awb") ~= 0 then
					local var_492_5 = manager.audio:GetVoiceLength("story_v_out_122121", "122121119", "story_v_out_122121.awb") / 1000

					if var_492_5 + 0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_5 + 0
					end

					if var_492_1.prefab_name ~= "" and arg_489_1.actors_[var_492_1.prefab_name] ~= nil then
						local var_492_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_489_1.actors_[var_492_1.prefab_name].transform, "story_v_out_122121", "122121119", "story_v_out_122121.awb")

						arg_489_1:RecordAudio("122121119", var_492_6)
						arg_489_1:RecordAudio("122121119", var_492_6)
					else
						arg_489_1:AudioAction("play", "voice", "story_v_out_122121", "122121119", "story_v_out_122121.awb")
					end

					arg_489_1:RecordHistoryTalkVoice("story_v_out_122121", "122121119", "story_v_out_122121.awb")
				end

				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_7 = math.max(var_492_0, arg_489_1.talkMaxDuration)

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_7 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - 0) / var_492_7

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= 0 + var_492_7 and arg_489_1.time_ < 0 + var_492_7 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play122121120 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 122121120
		arg_493_1.duration_ = 5

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play122121121(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = 0.325

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				arg_493_1.leftNameTxt_.text = arg_493_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, true)
				arg_493_1.iconController_:SetSelectedState("hero")

				arg_493_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_493_1.callingController_:SetSelectedState("normal")

				arg_493_1.keyicon_.color = Color.New(1, 1, 1)
				arg_493_1.icon_.color = Color.New(1, 1, 1)

				local var_496_1 = arg_493_1:FormatText(arg_493_1:GetWordFromCfg(122121120).content)

				arg_493_1.text_.text = var_496_1

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_3 = 13 <= 0 and var_496_0 or var_496_0 * (utf8.len(var_496_1) / 13)

				if (13 <= 0 and var_496_0 or var_496_0 * (utf8.len(var_496_1) / 13)) > 0 and var_496_0 < var_496_3 then
					arg_493_1.talkMaxDuration = var_496_3

					if var_496_3 + 0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_3 + 0
					end
				end

				arg_493_1.text_.text = var_496_1
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)
				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_4 = math.max(var_496_0, arg_493_1.talkMaxDuration)

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_4 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - 0) / var_496_4

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= 0 + var_496_4 and arg_493_1.time_ < 0 + var_496_4 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	Play122121121 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 122121121
		arg_497_1.duration_ = 8.2

		local var_497_0 = {
			ja = 7.2,
			ko = 8.2,
			zh = 8.2
		}
		local var_497_1 = manager.audio:GetLocalizationFlag()

		if var_497_0[var_497_1] ~= nil then
			arg_497_1.duration_ = var_497_0[var_497_1]
		end

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play122121122(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = 1.025

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				arg_497_1.leftNameTxt_.text = arg_497_1:FormatText(StoryNameCfg[146].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, true)
				arg_497_1.iconController_:SetSelectedState("hero")

				arg_497_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_497_1.callingController_:SetSelectedState("normal")

				arg_497_1.keyicon_.color = Color.New(1, 1, 1)
				arg_497_1.icon_.color = Color.New(1, 1, 1)

				local var_500_1 = arg_497_1:GetWordFromCfg(122121121)
				local var_500_2 = arg_497_1:FormatText(var_500_1.content)

				arg_497_1.text_.text = var_500_2

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_4 = 41 <= 0 and var_500_0 or var_500_0 * (utf8.len(var_500_2) / 41)

				if (41 <= 0 and var_500_0 or var_500_0 * (utf8.len(var_500_2) / 41)) > 0 and var_500_0 < var_500_4 then
					arg_497_1.talkMaxDuration = var_500_4

					if var_500_4 + 0 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_4 + 0
					end
				end

				arg_497_1.text_.text = var_500_2
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121121", "story_v_out_122121.awb") ~= 0 then
					local var_500_5 = manager.audio:GetVoiceLength("story_v_out_122121", "122121121", "story_v_out_122121.awb") / 1000

					if var_500_5 + 0 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_5 + 0
					end

					if var_500_1.prefab_name ~= "" and arg_497_1.actors_[var_500_1.prefab_name] ~= nil then
						local var_500_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_497_1.actors_[var_500_1.prefab_name].transform, "story_v_out_122121", "122121121", "story_v_out_122121.awb")

						arg_497_1:RecordAudio("122121121", var_500_6)
						arg_497_1:RecordAudio("122121121", var_500_6)
					else
						arg_497_1:AudioAction("play", "voice", "story_v_out_122121", "122121121", "story_v_out_122121.awb")
					end

					arg_497_1:RecordHistoryTalkVoice("story_v_out_122121", "122121121", "story_v_out_122121.awb")
				end

				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_7 = math.max(var_500_0, arg_497_1.talkMaxDuration)

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_7 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - 0) / var_500_7

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= 0 + var_500_7 and arg_497_1.time_ < 0 + var_500_7 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play122121122 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 122121122
		arg_501_1.duration_ = 5

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play122121123(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = 0.5

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				arg_501_1.leftNameTxt_.text = arg_501_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, true)
				arg_501_1.iconController_:SetSelectedState("hero")

				arg_501_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_501_1.callingController_:SetSelectedState("normal")

				arg_501_1.keyicon_.color = Color.New(1, 1, 1)
				arg_501_1.icon_.color = Color.New(1, 1, 1)

				local var_504_1 = arg_501_1:FormatText(arg_501_1:GetWordFromCfg(122121122).content)

				arg_501_1.text_.text = var_504_1

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_3 = 20 <= 0 and var_504_0 or var_504_0 * (utf8.len(var_504_1) / 20)

				if (20 <= 0 and var_504_0 or var_504_0 * (utf8.len(var_504_1) / 20)) > 0 and var_504_0 < var_504_3 then
					arg_501_1.talkMaxDuration = var_504_3

					if var_504_3 + 0 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_3 + 0
					end
				end

				arg_501_1.text_.text = var_504_1
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_4 = math.max(var_504_0, arg_501_1.talkMaxDuration)

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_4 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - 0) / var_504_4

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= 0 + var_504_4 and arg_501_1.time_ < 0 + var_504_4 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play122121123 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 122121123
		arg_505_1.duration_ = 3.9

		local var_505_0 = {
			ja = 3.9,
			ko = 2.066,
			zh = 2.066
		}
		local var_505_1 = manager.audio:GetLocalizationFlag()

		if var_505_0[var_505_1] ~= nil then
			arg_505_1.duration_ = var_505_0[var_505_1]
		end

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play122121124(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			local var_508_0 = 0.25

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				arg_505_1.leftNameTxt_.text = arg_505_1:FormatText(StoryNameCfg[146].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, true)
				arg_505_1.iconController_:SetSelectedState("hero")

				arg_505_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_505_1.callingController_:SetSelectedState("normal")

				arg_505_1.keyicon_.color = Color.New(1, 1, 1)
				arg_505_1.icon_.color = Color.New(1, 1, 1)

				local var_508_1 = arg_505_1:GetWordFromCfg(122121123)
				local var_508_2 = arg_505_1:FormatText(var_508_1.content)

				arg_505_1.text_.text = var_508_2

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_4 = 10 <= 0 and var_508_0 or var_508_0 * (utf8.len(var_508_2) / 10)

				if (10 <= 0 and var_508_0 or var_508_0 * (utf8.len(var_508_2) / 10)) > 0 and var_508_0 < var_508_4 then
					arg_505_1.talkMaxDuration = var_508_4

					if var_508_4 + 0 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_4 + 0
					end
				end

				arg_505_1.text_.text = var_508_2
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121123", "story_v_out_122121.awb") ~= 0 then
					local var_508_5 = manager.audio:GetVoiceLength("story_v_out_122121", "122121123", "story_v_out_122121.awb") / 1000

					if var_508_5 + 0 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_5 + 0
					end

					if var_508_1.prefab_name ~= "" and arg_505_1.actors_[var_508_1.prefab_name] ~= nil then
						local var_508_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_505_1.actors_[var_508_1.prefab_name].transform, "story_v_out_122121", "122121123", "story_v_out_122121.awb")

						arg_505_1:RecordAudio("122121123", var_508_6)
						arg_505_1:RecordAudio("122121123", var_508_6)
					else
						arg_505_1:AudioAction("play", "voice", "story_v_out_122121", "122121123", "story_v_out_122121.awb")
					end

					arg_505_1:RecordHistoryTalkVoice("story_v_out_122121", "122121123", "story_v_out_122121.awb")
				end

				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_7 = math.max(var_508_0, arg_505_1.talkMaxDuration)

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_7 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - 0) / var_508_7

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= 0 + var_508_7 and arg_505_1.time_ < 0 + var_508_7 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play122121124 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 122121124
		arg_509_1.duration_ = 5

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play122121125(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			local var_512_0 = 1.05

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

				local var_512_1 = arg_509_1:FormatText(arg_509_1:GetWordFromCfg(122121124).content)

				arg_509_1.text_.text = var_512_1

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_3 = 42 <= 0 and var_512_0 or var_512_0 * (utf8.len(var_512_1) / 42)

				if (42 <= 0 and var_512_0 or var_512_0 * (utf8.len(var_512_1) / 42)) > 0 and var_512_0 < var_512_3 then
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
	Play122121125 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 122121125
		arg_513_1.duration_ = 9.77

		local var_513_0 = {
			ja = 9.766,
			ko = 6.066,
			zh = 6.066
		}
		local var_513_1 = manager.audio:GetLocalizationFlag()

		if var_513_0[var_513_1] ~= nil then
			arg_513_1.duration_ = var_513_0[var_513_1]
		end

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play122121126(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = 0.7

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				arg_513_1.leftNameTxt_.text = arg_513_1:FormatText(StoryNameCfg[146].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, true)
				arg_513_1.iconController_:SetSelectedState("hero")

				arg_513_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_513_1.callingController_:SetSelectedState("normal")

				arg_513_1.keyicon_.color = Color.New(1, 1, 1)
				arg_513_1.icon_.color = Color.New(1, 1, 1)

				local var_516_1 = arg_513_1:GetWordFromCfg(122121125)
				local var_516_2 = arg_513_1:FormatText(var_516_1.content)

				arg_513_1.text_.text = var_516_2

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_4 = 28 <= 0 and var_516_0 or var_516_0 * (utf8.len(var_516_2) / 28)

				if (28 <= 0 and var_516_0 or var_516_0 * (utf8.len(var_516_2) / 28)) > 0 and var_516_0 < var_516_4 then
					arg_513_1.talkMaxDuration = var_516_4

					if var_516_4 + 0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_4 + 0
					end
				end

				arg_513_1.text_.text = var_516_2
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121125", "story_v_out_122121.awb") ~= 0 then
					local var_516_5 = manager.audio:GetVoiceLength("story_v_out_122121", "122121125", "story_v_out_122121.awb") / 1000

					if var_516_5 + 0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_5 + 0
					end

					if var_516_1.prefab_name ~= "" and arg_513_1.actors_[var_516_1.prefab_name] ~= nil then
						local var_516_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_513_1.actors_[var_516_1.prefab_name].transform, "story_v_out_122121", "122121125", "story_v_out_122121.awb")

						arg_513_1:RecordAudio("122121125", var_516_6)
						arg_513_1:RecordAudio("122121125", var_516_6)
					else
						arg_513_1:AudioAction("play", "voice", "story_v_out_122121", "122121125", "story_v_out_122121.awb")
					end

					arg_513_1:RecordHistoryTalkVoice("story_v_out_122121", "122121125", "story_v_out_122121.awb")
				end

				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_7 = math.max(var_516_0, arg_513_1.talkMaxDuration)

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_7 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - 0) / var_516_7

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= 0 + var_516_7 and arg_513_1.time_ < 0 + var_516_7 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play122121126 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 122121126
		arg_517_1.duration_ = 5

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play122121127(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = 0.125

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				arg_517_1.leftNameTxt_.text = arg_517_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, true)
				arg_517_1.iconController_:SetSelectedState("hero")

				arg_517_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_517_1.callingController_:SetSelectedState("normal")

				arg_517_1.keyicon_.color = Color.New(1, 1, 1)
				arg_517_1.icon_.color = Color.New(1, 1, 1)

				local var_520_1 = arg_517_1:FormatText(arg_517_1:GetWordFromCfg(122121126).content)

				arg_517_1.text_.text = var_520_1

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_3 = 5 <= 0 and var_520_0 or var_520_0 * (utf8.len(var_520_1) / 5)

				if (5 <= 0 and var_520_0 or var_520_0 * (utf8.len(var_520_1) / 5)) > 0 and var_520_0 < var_520_3 then
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
	Play122121127 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 122121127
		arg_521_1.duration_ = 5

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play122121128(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = 0.85

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, false)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_1 = arg_521_1:FormatText(arg_521_1:GetWordFromCfg(122121127).content)

				arg_521_1.text_.text = var_524_1

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_3 = 34 <= 0 and var_524_0 or var_524_0 * (utf8.len(var_524_1) / 34)

				if (34 <= 0 and var_524_0 or var_524_0 * (utf8.len(var_524_1) / 34)) > 0 and var_524_0 < var_524_3 then
					arg_521_1.talkMaxDuration = var_524_3

					if var_524_3 + 0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_3 + 0
					end
				end

				arg_521_1.text_.text = var_524_1
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)
				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_4 = math.max(var_524_0, arg_521_1.talkMaxDuration)

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_4 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - 0) / var_524_4

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= 0 + var_524_4 and arg_521_1.time_ < 0 + var_524_4 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play122121128 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 122121128
		arg_525_1.duration_ = 5

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play122121129(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = 1.275

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

				local var_528_1 = arg_525_1:FormatText(arg_525_1:GetWordFromCfg(122121128).content)

				arg_525_1.text_.text = var_528_1

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_3 = 51 <= 0 and var_528_0 or var_528_0 * (utf8.len(var_528_1) / 51)

				if (51 <= 0 and var_528_0 or var_528_0 * (utf8.len(var_528_1) / 51)) > 0 and var_528_0 < var_528_3 then
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
	Play122121129 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 122121129
		arg_529_1.duration_ = 5

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play122121130(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1:AudioAction("play", "effect", "se_story_122_02", "se_story_122_02_footstep", "")
			end

			local var_532_1 = 0
			local var_532_2 = 1.5

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= var_532_1 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, false)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_3 = arg_529_1:FormatText(arg_529_1:GetWordFromCfg(122121129).content)

				arg_529_1.text_.text = var_532_3

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_5 = 60 <= 0 and var_532_2 or var_532_2 * (utf8.len(var_532_3) / 60)

				if (60 <= 0 and var_532_2 or var_532_2 * (utf8.len(var_532_3) / 60)) > 0 and var_532_2 < var_532_5 then
					arg_529_1.talkMaxDuration = var_532_5

					if var_532_5 + var_532_1 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_5 + var_532_1
					end
				end

				arg_529_1.text_.text = var_532_3
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)
				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_6 = math.max(var_532_2, arg_529_1.talkMaxDuration)

			if var_532_1 <= arg_529_1.time_ and arg_529_1.time_ < var_532_1 + var_532_6 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_1) / var_532_6

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_1 + var_532_6 and arg_529_1.time_ < var_532_1 + var_532_6 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play122121130 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 122121130
		arg_533_1.duration_ = 0.5

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"

			SetActive(arg_533_1.choicesGo_, true)

			for iter_534_0, iter_534_1 in ipairs(arg_533_1.choices_) do
				SetActive(iter_534_1.go, iter_534_0 <= 1)
			end

			arg_533_1.choices_[1].txt.text = arg_533_1:FormatText(StoryChoiceCfg[447].name)
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play122121131(arg_533_1)
			end

			arg_533_1:RecordChoiceLog(122121130, 447)
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 then
				arg_533_1.allBtn_.enabled = false
			end

			if arg_533_1.time_ >= 0 + 0.5 and arg_533_1.time_ < 0 + 0.5 + arg_536_0 then
				arg_533_1.allBtn_.enabled = true
			end
		end

		arg_533_1.nodeConfigList_ = {}

		arg_533_1:InitPlayNodeList()
	end,
	Play122121131 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 122121131
		arg_537_1.duration_ = 11.93

		local var_537_0 = {
			ja = 11.133,
			ko = 11.933,
			zh = 11.933
		}
		local var_537_1 = manager.audio:GetLocalizationFlag()

		if var_537_0[var_537_1] ~= nil then
			arg_537_1.duration_ = var_537_0[var_537_1]
		end

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play122121132(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			if arg_537_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_540_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_537_1.stage_.transform)

				var_540_0.name = "1019ui_story"
				var_540_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_537_1.actors_["1019ui_story"] = var_540_0

				local var_540_1 = var_540_0:GetComponentInChildren(typeof(CharacterEffect))

				var_540_1.enabled = true

				local var_540_2 = GameObjectTools.GetOrAddComponent(var_540_0, typeof(DynamicBoneHelper))

				if var_540_2 then
					var_540_2:EnableDynamicBone(false)
				end

				arg_537_1:ShowWeapon(var_540_1.transform, false)

				arg_537_1.var_["1019ui_story" .. "Animator"] = var_540_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_537_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_537_1.var_["1019ui_story" .. "LipSync"] = var_540_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_540_3 = arg_537_1.actors_["1019ui_story"].transform

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1.var_.moveOldPos1019ui_story = var_540_3.localPosition
			end

			local var_540_4 = 0.001

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_4 then
				var_540_3.localPosition = Vector3.Lerp(arg_537_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_537_1.time_ - 0) / var_540_4)
				var_540_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_540_3.position).x, (manager.ui.mainCamera.transform.position - var_540_3.position).y, (manager.ui.mainCamera.transform.position - var_540_3.position).z)
				var_540_3.localEulerAngles.z = 0
				var_540_3.localEulerAngles.x = 0
				var_540_3.localEulerAngles = var_540_3.localEulerAngles
			end

			if arg_537_1.time_ >= 0 + var_540_4 and arg_537_1.time_ < 0 + var_540_4 + arg_540_0 then
				var_540_3.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_540_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_540_3.position).x, (manager.ui.mainCamera.transform.position - var_540_3.position).y, (manager.ui.mainCamera.transform.position - var_540_3.position).z)
				var_540_3.localEulerAngles.z = 0
				var_540_3.localEulerAngles.x = 0
				var_540_3.localEulerAngles = var_540_3.localEulerAngles
			end

			local var_540_5 = arg_537_1.actors_["1019ui_story"]

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 and not isNil(var_540_5) and arg_537_1.var_.characterEffect1019ui_story == nil then
				arg_537_1.var_.characterEffect1019ui_story = var_540_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_540_6 = 0.2

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_6 and not isNil(var_540_5) then
				if arg_537_1.var_.characterEffect1019ui_story and not isNil(var_540_5) then
					arg_537_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_537_1.time_ >= 0 + var_540_6 and arg_537_1.time_ < 0 + var_540_6 + arg_540_0 and not isNil(var_540_5) and arg_537_1.var_.characterEffect1019ui_story then
				arg_537_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_540_8 = 0

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= var_540_8 + arg_540_0 then
				arg_537_1.mask_.enabled = true
				arg_537_1.mask_.raycastTarget = true

				arg_537_1:SetGaussion(false)
			end

			local var_540_9 = 1

			if var_540_8 <= arg_537_1.time_ and arg_537_1.time_ < var_540_8 + var_540_9 then
				local var_540_10 = Color.New(1, 1, 1)

				var_540_10.a = Mathf.Lerp(1, 0, (arg_537_1.time_ - var_540_8) / var_540_9)
				arg_537_1.mask_.color = var_540_10
			end

			if arg_537_1.time_ >= var_540_8 + var_540_9 and arg_537_1.time_ < var_540_8 + var_540_9 + arg_540_0 then
				local var_540_11 = Color.New(1, 1, 1)

				arg_537_1.mask_.enabled = false
				var_540_11.a = 0
				arg_537_1.mask_.color = var_540_11
			end

			local var_540_12 = 0
			local var_540_13 = 1.075

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= var_540_12 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0

				arg_537_1.dialog_:SetActive(true)

				arg_537_1.dialogCg_.alpha = 0

				local var_540_14 = LeanTween.value(arg_537_1.dialog_, 0, 1, 0.3)

				var_540_14:setOnUpdate(LuaHelper.FloatAction(function(arg_541_0)
					arg_537_1.dialogCg_.alpha = arg_541_0
				end))
				var_540_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_537_1.dialog_)
					var_540_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_537_1.duration_ = arg_537_1.duration_ + 0.3

				SetActive(arg_537_1.leftNameGo_, true)

				arg_537_1.leftNameTxt_.text = arg_537_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_15 = arg_537_1:GetWordFromCfg(122121131)
				local var_540_16 = arg_537_1:FormatText(var_540_15.content)

				arg_537_1.text_.text = var_540_16

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_18 = 43 <= 0 and var_540_13 or var_540_13 * (utf8.len(var_540_16) / 43)

				if (43 <= 0 and var_540_13 or var_540_13 * (utf8.len(var_540_16) / 43)) > 0 and var_540_13 < var_540_18 then
					arg_537_1.talkMaxDuration = var_540_18
					var_540_12 = var_540_12 + 0.3

					if var_540_18 + var_540_12 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_18 + var_540_12
					end
				end

				arg_537_1.text_.text = var_540_16
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121131", "story_v_out_122121.awb") ~= 0 then
					local var_540_19 = manager.audio:GetVoiceLength("story_v_out_122121", "122121131", "story_v_out_122121.awb") / 1000

					if var_540_19 + var_540_12 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_19 + var_540_12
					end

					if var_540_15.prefab_name ~= "" and arg_537_1.actors_[var_540_15.prefab_name] ~= nil then
						local var_540_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_537_1.actors_[var_540_15.prefab_name].transform, "story_v_out_122121", "122121131", "story_v_out_122121.awb")

						arg_537_1:RecordAudio("122121131", var_540_20)
						arg_537_1:RecordAudio("122121131", var_540_20)
					else
						arg_537_1:AudioAction("play", "voice", "story_v_out_122121", "122121131", "story_v_out_122121.awb")
					end

					arg_537_1:RecordHistoryTalkVoice("story_v_out_122121", "122121131", "story_v_out_122121.awb")
				end

				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_21 = var_540_12 + 0.3
			local var_540_22 = math.max(var_540_13, arg_537_1.talkMaxDuration)

			if var_540_12 + 0.3 <= arg_537_1.time_ and arg_537_1.time_ < var_540_21 + var_540_22 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_21) / var_540_22

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_21 + var_540_22 and arg_537_1.time_ < var_540_21 + var_540_22 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {
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

		arg_537_1:InitPlayNodeList()
	end,
	Play122121132 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 122121132
		arg_543_1.duration_ = 12.8

		local var_543_0 = {
			ja = 12.8,
			ko = 7.2,
			zh = 7.2
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
				arg_543_0:Play122121133(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			local var_546_0 = 0.725

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 then
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

				local var_546_1 = arg_543_1:GetWordFromCfg(122121132)
				local var_546_2 = arg_543_1:FormatText(var_546_1.content)

				arg_543_1.text_.text = var_546_2

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_4 = 29 <= 0 and var_546_0 or var_546_0 * (utf8.len(var_546_2) / 29)

				if (29 <= 0 and var_546_0 or var_546_0 * (utf8.len(var_546_2) / 29)) > 0 and var_546_0 < var_546_4 then
					arg_543_1.talkMaxDuration = var_546_4

					if var_546_4 + 0 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_4 + 0
					end
				end

				arg_543_1.text_.text = var_546_2
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121132", "story_v_out_122121.awb") ~= 0 then
					local var_546_5 = manager.audio:GetVoiceLength("story_v_out_122121", "122121132", "story_v_out_122121.awb") / 1000

					if var_546_5 + 0 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_5 + 0
					end

					if var_546_1.prefab_name ~= "" and arg_543_1.actors_[var_546_1.prefab_name] ~= nil then
						local var_546_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_543_1.actors_[var_546_1.prefab_name].transform, "story_v_out_122121", "122121132", "story_v_out_122121.awb")

						arg_543_1:RecordAudio("122121132", var_546_6)
						arg_543_1:RecordAudio("122121132", var_546_6)
					else
						arg_543_1:AudioAction("play", "voice", "story_v_out_122121", "122121132", "story_v_out_122121.awb")
					end

					arg_543_1:RecordHistoryTalkVoice("story_v_out_122121", "122121132", "story_v_out_122121.awb")
				end

				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_7 = math.max(var_546_0, arg_543_1.talkMaxDuration)

			if 0 <= arg_543_1.time_ and arg_543_1.time_ < 0 + var_546_7 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - 0) / var_546_7

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= 0 + var_546_7 and arg_543_1.time_ < 0 + var_546_7 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {}

		arg_543_1:InitPlayNodeList()
	end,
	Play122121133 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 122121133
		arg_547_1.duration_ = 5

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play122121134(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 and not isNil(arg_547_1.actors_["1019ui_story"]) and arg_547_1.var_.characterEffect1019ui_story == nil then
				arg_547_1.var_.characterEffect1019ui_story = arg_547_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_550_0 = 0.2

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
			local var_550_2 = 1.35

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= var_550_1 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, false)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_547_1.iconTrs_.gameObject, false)
				arg_547_1.callingController_:SetSelectedState("normal")

				local var_550_3 = arg_547_1:FormatText(arg_547_1:GetWordFromCfg(122121133).content)

				arg_547_1.text_.text = var_550_3

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_5 = 53 <= 0 and var_550_2 or var_550_2 * (utf8.len(var_550_3) / 53)

				if (53 <= 0 and var_550_2 or var_550_2 * (utf8.len(var_550_3) / 53)) > 0 and var_550_2 < var_550_5 then
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
	Play122121134 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 122121134
		arg_551_1.duration_ = 2.13

		local var_551_0 = {
			ja = 2.133,
			ko = 1.633,
			zh = 1.633
		}
		local var_551_1 = manager.audio:GetLocalizationFlag()

		if var_551_0[var_551_1] ~= nil then
			arg_551_1.duration_ = var_551_0[var_551_1]
		end

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play122121135(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			local var_554_0 = 0.175

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, true)

				arg_551_1.leftNameTxt_.text = arg_551_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, false)
				arg_551_1.callingController_:SetSelectedState("normal")

				local var_554_1 = arg_551_1:GetWordFromCfg(122121134)
				local var_554_2 = arg_551_1:FormatText(var_554_1.content)

				arg_551_1.text_.text = var_554_2

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_4 = 7 <= 0 and var_554_0 or var_554_0 * (utf8.len(var_554_2) / 7)

				if (7 <= 0 and var_554_0 or var_554_0 * (utf8.len(var_554_2) / 7)) > 0 and var_554_0 < var_554_4 then
					arg_551_1.talkMaxDuration = var_554_4

					if var_554_4 + 0 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_4 + 0
					end
				end

				arg_551_1.text_.text = var_554_2
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121134", "story_v_out_122121.awb") ~= 0 then
					local var_554_5 = manager.audio:GetVoiceLength("story_v_out_122121", "122121134", "story_v_out_122121.awb") / 1000

					if var_554_5 + 0 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_5 + 0
					end

					if var_554_1.prefab_name ~= "" and arg_551_1.actors_[var_554_1.prefab_name] ~= nil then
						local var_554_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_551_1.actors_[var_554_1.prefab_name].transform, "story_v_out_122121", "122121134", "story_v_out_122121.awb")

						arg_551_1:RecordAudio("122121134", var_554_6)
						arg_551_1:RecordAudio("122121134", var_554_6)
					else
						arg_551_1:AudioAction("play", "voice", "story_v_out_122121", "122121134", "story_v_out_122121.awb")
					end

					arg_551_1:RecordHistoryTalkVoice("story_v_out_122121", "122121134", "story_v_out_122121.awb")
				end

				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_7 = math.max(var_554_0, arg_551_1.talkMaxDuration)

			if 0 <= arg_551_1.time_ and arg_551_1.time_ < 0 + var_554_7 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - 0) / var_554_7

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= 0 + var_554_7 and arg_551_1.time_ < 0 + var_554_7 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {}

		arg_551_1:InitPlayNodeList()
	end,
	Play122121135 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 122121135
		arg_555_1.duration_ = 5

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play122121136(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			local var_558_0 = 1.325

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

				local var_558_1 = arg_555_1:FormatText(arg_555_1:GetWordFromCfg(122121135).content)

				arg_555_1.text_.text = var_558_1

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_3 = 53 <= 0 and var_558_0 or var_558_0 * (utf8.len(var_558_1) / 53)

				if (53 <= 0 and var_558_0 or var_558_0 * (utf8.len(var_558_1) / 53)) > 0 and var_558_0 < var_558_3 then
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
	Play122121136 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 122121136
		arg_559_1.duration_ = 5

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play122121137(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			local var_562_0 = 1

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, true)

				arg_559_1.leftNameTxt_.text = arg_559_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_559_1.leftNameTxt_.transform)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1.leftNameTxt_.text)
				SetActive(arg_559_1.iconTrs_.gameObject, true)
				arg_559_1.iconController_:SetSelectedState("hero")

				arg_559_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_559_1.callingController_:SetSelectedState("normal")

				arg_559_1.keyicon_.color = Color.New(1, 1, 1)
				arg_559_1.icon_.color = Color.New(1, 1, 1)

				local var_562_1 = arg_559_1:FormatText(arg_559_1:GetWordFromCfg(122121136).content)

				arg_559_1.text_.text = var_562_1

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_3 = 40 <= 0 and var_562_0 or var_562_0 * (utf8.len(var_562_1) / 40)

				if (40 <= 0 and var_562_0 or var_562_0 * (utf8.len(var_562_1) / 40)) > 0 and var_562_0 < var_562_3 then
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
	Play122121137 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 122121137
		arg_563_1.duration_ = 14.2

		local var_563_0 = {
			ja = 14.2,
			ko = 7.433,
			zh = 7.433
		}
		local var_563_1 = manager.audio:GetLocalizationFlag()

		if var_563_0[var_563_1] ~= nil then
			arg_563_1.duration_ = var_563_0[var_563_1]
		end

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play122121138(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 then
				arg_563_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_1")
			end

			local var_566_0 = arg_563_1.actors_["1019ui_story"]

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 and not isNil(var_566_0) and arg_563_1.var_.characterEffect1019ui_story == nil then
				arg_563_1.var_.characterEffect1019ui_story = var_566_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_566_1 = 0.2

			if 0 <= arg_563_1.time_ and arg_563_1.time_ < 0 + var_566_1 and not isNil(var_566_0) then
				if arg_563_1.var_.characterEffect1019ui_story and not isNil(var_566_0) then
					arg_563_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_563_1.time_ >= 0 + var_566_1 and arg_563_1.time_ < 0 + var_566_1 + arg_566_0 and not isNil(var_566_0) and arg_563_1.var_.characterEffect1019ui_story then
				arg_563_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 then
				arg_563_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_566_3 = 0
			local var_566_4 = 0.65

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= var_566_3 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, true)

				arg_563_1.leftNameTxt_.text = arg_563_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_563_1.leftNameTxt_.transform)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1.leftNameTxt_.text)
				SetActive(arg_563_1.iconTrs_.gameObject, false)
				arg_563_1.callingController_:SetSelectedState("normal")

				local var_566_5 = arg_563_1:GetWordFromCfg(122121137)
				local var_566_6 = arg_563_1:FormatText(var_566_5.content)

				arg_563_1.text_.text = var_566_6

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_8 = 26 <= 0 and var_566_4 or var_566_4 * (utf8.len(var_566_6) / 26)

				if (26 <= 0 and var_566_4 or var_566_4 * (utf8.len(var_566_6) / 26)) > 0 and var_566_4 < var_566_8 then
					arg_563_1.talkMaxDuration = var_566_8

					if var_566_8 + var_566_3 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_8 + var_566_3
					end
				end

				arg_563_1.text_.text = var_566_6
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121137", "story_v_out_122121.awb") ~= 0 then
					local var_566_9 = manager.audio:GetVoiceLength("story_v_out_122121", "122121137", "story_v_out_122121.awb") / 1000

					if var_566_9 + var_566_3 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_9 + var_566_3
					end

					if var_566_5.prefab_name ~= "" and arg_563_1.actors_[var_566_5.prefab_name] ~= nil then
						local var_566_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_563_1.actors_[var_566_5.prefab_name].transform, "story_v_out_122121", "122121137", "story_v_out_122121.awb")

						arg_563_1:RecordAudio("122121137", var_566_10)
						arg_563_1:RecordAudio("122121137", var_566_10)
					else
						arg_563_1:AudioAction("play", "voice", "story_v_out_122121", "122121137", "story_v_out_122121.awb")
					end

					arg_563_1:RecordHistoryTalkVoice("story_v_out_122121", "122121137", "story_v_out_122121.awb")
				end

				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_11 = math.max(var_566_4, arg_563_1.talkMaxDuration)

			if var_566_3 <= arg_563_1.time_ and arg_563_1.time_ < var_566_3 + var_566_11 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - var_566_3) / var_566_11

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= var_566_3 + var_566_11 and arg_563_1.time_ < var_566_3 + var_566_11 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {}

		arg_563_1:InitPlayNodeList()
	end,
	Play122121138 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 122121138
		arg_567_1.duration_ = 5

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play122121139(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			if 0 < arg_567_1.time_ and arg_567_1.time_ <= 0 + arg_570_0 and not isNil(arg_567_1.actors_["1019ui_story"]) and arg_567_1.var_.characterEffect1019ui_story == nil then
				arg_567_1.var_.characterEffect1019ui_story = arg_567_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_570_0 = 0.2

			if 0 <= arg_567_1.time_ and arg_567_1.time_ < 0 + var_570_0 and not isNil(arg_567_1.actors_["1019ui_story"]) then
				if arg_567_1.var_.characterEffect1019ui_story and not isNil(arg_567_1.actors_["1019ui_story"]) then
					arg_567_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_567_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_567_1.time_ - 0) / var_570_0)
				end
			end

			if arg_567_1.time_ >= 0 + var_570_0 and arg_567_1.time_ < 0 + var_570_0 + arg_570_0 and not isNil(arg_567_1.actors_["1019ui_story"]) and arg_567_1.var_.characterEffect1019ui_story then
				arg_567_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_567_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_570_1 = 0
			local var_570_2 = 0.575

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= var_570_1 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, true)

				arg_567_1.leftNameTxt_.text = arg_567_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_567_1.leftNameTxt_.transform)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1.leftNameTxt_.text)
				SetActive(arg_567_1.iconTrs_.gameObject, true)
				arg_567_1.iconController_:SetSelectedState("hero")

				arg_567_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_567_1.callingController_:SetSelectedState("normal")

				arg_567_1.keyicon_.color = Color.New(1, 1, 1)
				arg_567_1.icon_.color = Color.New(1, 1, 1)

				local var_570_3 = arg_567_1:FormatText(arg_567_1:GetWordFromCfg(122121138).content)

				arg_567_1.text_.text = var_570_3

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_5 = 23 <= 0 and var_570_2 or var_570_2 * (utf8.len(var_570_3) / 23)

				if (23 <= 0 and var_570_2 or var_570_2 * (utf8.len(var_570_3) / 23)) > 0 and var_570_2 < var_570_5 then
					arg_567_1.talkMaxDuration = var_570_5

					if var_570_5 + var_570_1 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_5 + var_570_1
					end
				end

				arg_567_1.text_.text = var_570_3
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)
				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_6 = math.max(var_570_2, arg_567_1.talkMaxDuration)

			if var_570_1 <= arg_567_1.time_ and arg_567_1.time_ < var_570_1 + var_570_6 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - var_570_1) / var_570_6

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= var_570_1 + var_570_6 and arg_567_1.time_ < var_570_1 + var_570_6 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {}

		arg_567_1:InitPlayNodeList()
	end,
	Play122121139 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 122121139
		arg_571_1.duration_ = 13.27

		local var_571_0 = {
			ja = 8.833,
			ko = 13.266,
			zh = 13.266
		}
		local var_571_1 = manager.audio:GetLocalizationFlag()

		if var_571_0[var_571_1] ~= nil then
			arg_571_1.duration_ = var_571_0[var_571_1]
		end

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play122121140(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			if 0 < arg_571_1.time_ and arg_571_1.time_ <= 0 + arg_574_0 and not isNil(arg_571_1.actors_["1019ui_story"]) and arg_571_1.var_.characterEffect1019ui_story == nil then
				arg_571_1.var_.characterEffect1019ui_story = arg_571_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_574_0 = 0.2

			if 0 <= arg_571_1.time_ and arg_571_1.time_ < 0 + var_574_0 and not isNil(arg_571_1.actors_["1019ui_story"]) then
				if arg_571_1.var_.characterEffect1019ui_story and not isNil(arg_571_1.actors_["1019ui_story"]) then
					arg_571_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_571_1.time_ >= 0 + var_574_0 and arg_571_1.time_ < 0 + var_574_0 + arg_574_0 and not isNil(arg_571_1.actors_["1019ui_story"]) and arg_571_1.var_.characterEffect1019ui_story then
				arg_571_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_574_2 = 0
			local var_574_3 = 1.1

			if 0 < arg_571_1.time_ and arg_571_1.time_ <= var_574_2 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, true)

				arg_571_1.leftNameTxt_.text = arg_571_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_571_1.leftNameTxt_.transform)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1.leftNameTxt_.text)
				SetActive(arg_571_1.iconTrs_.gameObject, false)
				arg_571_1.callingController_:SetSelectedState("normal")

				local var_574_4 = arg_571_1:GetWordFromCfg(122121139)
				local var_574_5 = arg_571_1:FormatText(var_574_4.content)

				arg_571_1.text_.text = var_574_5

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_7 = 44 <= 0 and var_574_3 or var_574_3 * (utf8.len(var_574_5) / 44)

				if (44 <= 0 and var_574_3 or var_574_3 * (utf8.len(var_574_5) / 44)) > 0 and var_574_3 < var_574_7 then
					arg_571_1.talkMaxDuration = var_574_7

					if var_574_7 + var_574_2 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_7 + var_574_2
					end
				end

				arg_571_1.text_.text = var_574_5
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121139", "story_v_out_122121.awb") ~= 0 then
					local var_574_8 = manager.audio:GetVoiceLength("story_v_out_122121", "122121139", "story_v_out_122121.awb") / 1000

					if var_574_8 + var_574_2 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_8 + var_574_2
					end

					if var_574_4.prefab_name ~= "" and arg_571_1.actors_[var_574_4.prefab_name] ~= nil then
						local var_574_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_571_1.actors_[var_574_4.prefab_name].transform, "story_v_out_122121", "122121139", "story_v_out_122121.awb")

						arg_571_1:RecordAudio("122121139", var_574_9)
						arg_571_1:RecordAudio("122121139", var_574_9)
					else
						arg_571_1:AudioAction("play", "voice", "story_v_out_122121", "122121139", "story_v_out_122121.awb")
					end

					arg_571_1:RecordHistoryTalkVoice("story_v_out_122121", "122121139", "story_v_out_122121.awb")
				end

				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_10 = math.max(var_574_3, arg_571_1.talkMaxDuration)

			if var_574_2 <= arg_571_1.time_ and arg_571_1.time_ < var_574_2 + var_574_10 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - var_574_2) / var_574_10

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= var_574_2 + var_574_10 and arg_571_1.time_ < var_574_2 + var_574_10 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {}

		arg_571_1:InitPlayNodeList()
	end,
	Play122121140 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 122121140
		arg_575_1.duration_ = 5

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play122121141(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 and not isNil(arg_575_1.actors_["1019ui_story"]) and arg_575_1.var_.characterEffect1019ui_story == nil then
				arg_575_1.var_.characterEffect1019ui_story = arg_575_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_578_0 = 0.2

			if 0 <= arg_575_1.time_ and arg_575_1.time_ < 0 + var_578_0 and not isNil(arg_575_1.actors_["1019ui_story"]) then
				if arg_575_1.var_.characterEffect1019ui_story and not isNil(arg_575_1.actors_["1019ui_story"]) then
					arg_575_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_575_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_575_1.time_ - 0) / var_578_0)
				end
			end

			if arg_575_1.time_ >= 0 + var_578_0 and arg_575_1.time_ < 0 + var_578_0 + arg_578_0 and not isNil(arg_575_1.actors_["1019ui_story"]) and arg_575_1.var_.characterEffect1019ui_story then
				arg_575_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_575_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_578_1 = 0
			local var_578_2 = 1.5

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= var_578_1 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, false)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_575_1.iconTrs_.gameObject, false)
				arg_575_1.callingController_:SetSelectedState("normal")

				local var_578_3 = arg_575_1:FormatText(arg_575_1:GetWordFromCfg(122121140).content)

				arg_575_1.text_.text = var_578_3

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_5 = 60 <= 0 and var_578_2 or var_578_2 * (utf8.len(var_578_3) / 60)

				if (60 <= 0 and var_578_2 or var_578_2 * (utf8.len(var_578_3) / 60)) > 0 and var_578_2 < var_578_5 then
					arg_575_1.talkMaxDuration = var_578_5

					if var_578_5 + var_578_1 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_5 + var_578_1
					end
				end

				arg_575_1.text_.text = var_578_3
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)
				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_6 = math.max(var_578_2, arg_575_1.talkMaxDuration)

			if var_578_1 <= arg_575_1.time_ and arg_575_1.time_ < var_578_1 + var_578_6 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - var_578_1) / var_578_6

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= var_578_1 + var_578_6 and arg_575_1.time_ < var_578_1 + var_578_6 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {}

		arg_575_1:InitPlayNodeList()
	end,
	Play122121141 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 122121141
		arg_579_1.duration_ = 16.37

		local var_579_0 = {
			ja = 16.366,
			ko = 8.166,
			zh = 8.166
		}
		local var_579_1 = manager.audio:GetLocalizationFlag()

		if var_579_0[var_579_1] ~= nil then
			arg_579_1.duration_ = var_579_0[var_579_1]
		end

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play122121142(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			if 0 < arg_579_1.time_ and arg_579_1.time_ <= 0 + arg_582_0 and not isNil(arg_579_1.actors_["1019ui_story"]) and arg_579_1.var_.characterEffect1019ui_story == nil then
				arg_579_1.var_.characterEffect1019ui_story = arg_579_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_582_0 = 0.2

			if 0 <= arg_579_1.time_ and arg_579_1.time_ < 0 + var_582_0 and not isNil(arg_579_1.actors_["1019ui_story"]) then
				if arg_579_1.var_.characterEffect1019ui_story and not isNil(arg_579_1.actors_["1019ui_story"]) then
					arg_579_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_579_1.time_ >= 0 + var_582_0 and arg_579_1.time_ < 0 + var_582_0 + arg_582_0 and not isNil(arg_579_1.actors_["1019ui_story"]) and arg_579_1.var_.characterEffect1019ui_story then
				arg_579_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_582_2 = 0
			local var_582_3 = 0.95

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= var_582_2 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, true)

				arg_579_1.leftNameTxt_.text = arg_579_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_579_1.leftNameTxt_.transform)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1.leftNameTxt_.text)
				SetActive(arg_579_1.iconTrs_.gameObject, false)
				arg_579_1.callingController_:SetSelectedState("normal")

				local var_582_4 = arg_579_1:GetWordFromCfg(122121141)
				local var_582_5 = arg_579_1:FormatText(var_582_4.content)

				arg_579_1.text_.text = var_582_5

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_7 = 38 <= 0 and var_582_3 or var_582_3 * (utf8.len(var_582_5) / 38)

				if (38 <= 0 and var_582_3 or var_582_3 * (utf8.len(var_582_5) / 38)) > 0 and var_582_3 < var_582_7 then
					arg_579_1.talkMaxDuration = var_582_7

					if var_582_7 + var_582_2 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_7 + var_582_2
					end
				end

				arg_579_1.text_.text = var_582_5
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121141", "story_v_out_122121.awb") ~= 0 then
					local var_582_8 = manager.audio:GetVoiceLength("story_v_out_122121", "122121141", "story_v_out_122121.awb") / 1000

					if var_582_8 + var_582_2 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_8 + var_582_2
					end

					if var_582_4.prefab_name ~= "" and arg_579_1.actors_[var_582_4.prefab_name] ~= nil then
						local var_582_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_579_1.actors_[var_582_4.prefab_name].transform, "story_v_out_122121", "122121141", "story_v_out_122121.awb")

						arg_579_1:RecordAudio("122121141", var_582_9)
						arg_579_1:RecordAudio("122121141", var_582_9)
					else
						arg_579_1:AudioAction("play", "voice", "story_v_out_122121", "122121141", "story_v_out_122121.awb")
					end

					arg_579_1:RecordHistoryTalkVoice("story_v_out_122121", "122121141", "story_v_out_122121.awb")
				end

				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_10 = math.max(var_582_3, arg_579_1.talkMaxDuration)

			if var_582_2 <= arg_579_1.time_ and arg_579_1.time_ < var_582_2 + var_582_10 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - var_582_2) / var_582_10

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= var_582_2 + var_582_10 and arg_579_1.time_ < var_582_2 + var_582_10 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	Play122121142 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 122121142
		arg_583_1.duration_ = 6.33

		local var_583_0 = {
			ja = 6.333,
			ko = 6.233,
			zh = 6.233
		}
		local var_583_1 = manager.audio:GetLocalizationFlag()

		if var_583_0[var_583_1] ~= nil then
			arg_583_1.duration_ = var_583_0[var_583_1]
		end

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play122121143(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			local var_586_0 = 0.675

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, true)

				arg_583_1.leftNameTxt_.text = arg_583_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_583_1.leftNameTxt_.transform)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1.leftNameTxt_.text)
				SetActive(arg_583_1.iconTrs_.gameObject, false)
				arg_583_1.callingController_:SetSelectedState("normal")

				local var_586_1 = arg_583_1:GetWordFromCfg(122121142)
				local var_586_2 = arg_583_1:FormatText(var_586_1.content)

				arg_583_1.text_.text = var_586_2

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_4 = 27 <= 0 and var_586_0 or var_586_0 * (utf8.len(var_586_2) / 27)

				if (27 <= 0 and var_586_0 or var_586_0 * (utf8.len(var_586_2) / 27)) > 0 and var_586_0 < var_586_4 then
					arg_583_1.talkMaxDuration = var_586_4

					if var_586_4 + 0 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_4 + 0
					end
				end

				arg_583_1.text_.text = var_586_2
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121142", "story_v_out_122121.awb") ~= 0 then
					local var_586_5 = manager.audio:GetVoiceLength("story_v_out_122121", "122121142", "story_v_out_122121.awb") / 1000

					if var_586_5 + 0 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_5 + 0
					end

					if var_586_1.prefab_name ~= "" and arg_583_1.actors_[var_586_1.prefab_name] ~= nil then
						local var_586_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_583_1.actors_[var_586_1.prefab_name].transform, "story_v_out_122121", "122121142", "story_v_out_122121.awb")

						arg_583_1:RecordAudio("122121142", var_586_6)
						arg_583_1:RecordAudio("122121142", var_586_6)
					else
						arg_583_1:AudioAction("play", "voice", "story_v_out_122121", "122121142", "story_v_out_122121.awb")
					end

					arg_583_1:RecordHistoryTalkVoice("story_v_out_122121", "122121142", "story_v_out_122121.awb")
				end

				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_7 = math.max(var_586_0, arg_583_1.talkMaxDuration)

			if 0 <= arg_583_1.time_ and arg_583_1.time_ < 0 + var_586_7 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - 0) / var_586_7

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= 0 + var_586_7 and arg_583_1.time_ < 0 + var_586_7 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {}

		arg_583_1:InitPlayNodeList()
	end,
	Play122121143 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 122121143
		arg_587_1.duration_ = 5

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play122121144(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			if 0 < arg_587_1.time_ and arg_587_1.time_ <= 0 + arg_590_0 then
				arg_587_1.var_.moveOldPos1019ui_story = arg_587_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_590_0 = 0.001

			if 0 <= arg_587_1.time_ and arg_587_1.time_ < 0 + var_590_0 then
				arg_587_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_587_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_587_1.time_ - 0) / var_590_0)
				arg_587_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_587_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_587_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_587_1.actors_["1019ui_story"].transform.position).z)
				arg_587_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_587_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_587_1.actors_["1019ui_story"].transform.localEulerAngles = arg_587_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_587_1.time_ >= 0 + var_590_0 and arg_587_1.time_ < 0 + var_590_0 + arg_590_0 then
				arg_587_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_587_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_587_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_587_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_587_1.actors_["1019ui_story"].transform.position).z)
				arg_587_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_587_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_587_1.actors_["1019ui_story"].transform.localEulerAngles = arg_587_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_590_1 = 0
			local var_590_2 = 1.3

			if 0 < arg_587_1.time_ and arg_587_1.time_ <= var_590_1 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, false)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_587_1.iconTrs_.gameObject, false)
				arg_587_1.callingController_:SetSelectedState("normal")

				local var_590_3 = arg_587_1:FormatText(arg_587_1:GetWordFromCfg(122121143).content)

				arg_587_1.text_.text = var_590_3

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_5 = 52 <= 0 and var_590_2 or var_590_2 * (utf8.len(var_590_3) / 52)

				if (52 <= 0 and var_590_2 or var_590_2 * (utf8.len(var_590_3) / 52)) > 0 and var_590_2 < var_590_5 then
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

		arg_587_1.nodeConfigList_ = {
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

		arg_587_1:InitPlayNodeList()
	end,
	Play122121144 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 122121144
		arg_591_1.duration_ = 5

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
		end

		function arg_591_1.playNext_(arg_593_0)
			if arg_593_0 == 1 then
				arg_591_0:Play122121145(arg_591_1)
			end
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			local var_594_0 = 0.45

			if 0 < arg_591_1.time_ and arg_591_1.time_ <= 0 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0
				arg_591_1.dialogCg_.alpha = 1

				arg_591_1.dialog_:SetActive(true)
				SetActive(arg_591_1.leftNameGo_, true)

				arg_591_1.leftNameTxt_.text = arg_591_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_591_1.leftNameTxt_.transform)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1.leftNameTxt_.text)
				SetActive(arg_591_1.iconTrs_.gameObject, true)
				arg_591_1.iconController_:SetSelectedState("hero")

				arg_591_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_591_1.callingController_:SetSelectedState("normal")

				arg_591_1.keyicon_.color = Color.New(1, 1, 1)
				arg_591_1.icon_.color = Color.New(1, 1, 1)

				local var_594_1 = arg_591_1:FormatText(arg_591_1:GetWordFromCfg(122121144).content)

				arg_591_1.text_.text = var_594_1

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_3 = 18 <= 0 and var_594_0 or var_594_0 * (utf8.len(var_594_1) / 18)

				if (18 <= 0 and var_594_0 or var_594_0 * (utf8.len(var_594_1) / 18)) > 0 and var_594_0 < var_594_3 then
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
	Play122121145 = function(arg_595_0, arg_595_1)
		arg_595_1.time_ = 0
		arg_595_1.frameCnt_ = 0
		arg_595_1.state_ = "playing"
		arg_595_1.curTalkId_ = 122121145
		arg_595_1.duration_ = 5

		SetActive(arg_595_1.tipsGo_, false)

		function arg_595_1.onSingleLineFinish_()
			arg_595_1.onSingleLineUpdate_ = nil
			arg_595_1.onSingleLineFinish_ = nil
			arg_595_1.state_ = "waiting"
		end

		function arg_595_1.playNext_(arg_597_0)
			if arg_597_0 == 1 then
				arg_595_0:Play122121146(arg_595_1)
			end
		end

		function arg_595_1.onSingleLineUpdate_(arg_598_0)
			local var_598_0 = 0.85

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

				local var_598_1 = arg_595_1:FormatText(arg_595_1:GetWordFromCfg(122121145).content)

				arg_595_1.text_.text = var_598_1

				LuaForUtil.ClearLinePrefixSymbol(arg_595_1.text_)

				local var_598_3 = 34 <= 0 and var_598_0 or var_598_0 * (utf8.len(var_598_1) / 34)

				if (34 <= 0 and var_598_0 or var_598_0 * (utf8.len(var_598_1) / 34)) > 0 and var_598_0 < var_598_3 then
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
	Play122121146 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 122121146
		arg_599_1.duration_ = 2.15

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play122121147(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			if 0 < arg_599_1.time_ and arg_599_1.time_ <= 0 + arg_602_0 then
				arg_599_1.fswbg_:SetActive(true)
				arg_599_1.dialog_:SetActive(false)

				arg_599_1.fswtw_.percent = 0
				arg_599_1.fswt_.text = arg_599_1:FormatText(arg_599_1:GetWordFromCfg(122121146).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.fswt_)

				arg_599_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_599_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_599_1.fswtw_:SetDirty()

				arg_599_1.typewritterCharCountI18N = 0

				SetActive(arg_599_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_599_1:ShowNextGo(false)
			end

			local var_602_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_599_1.time_ and arg_599_1.time_ <= var_602_0 + arg_602_0 then
				arg_599_1.var_.oldValueTypewriter = arg_599_1.fswtw_.percent

				SetActive(arg_599_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_599_1:ShowNextGo(false)
			end

			local var_602_1 = 32
			local var_602_2 = 2.13333333333333
			local var_602_3, var_602_4 = arg_599_1:GetPercentByPara(arg_599_1:FormatText(arg_599_1:GetWordFromCfg(122121146).content), 1)

			if var_602_0 < arg_599_1.time_ and arg_599_1.time_ <= var_602_0 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0

				local var_602_5 = var_602_1 <= 0 and var_602_2 or var_602_2 * ((var_602_4 - arg_599_1.typewritterCharCountI18N) / var_602_1)

				if (var_602_1 <= 0 and var_602_2 or var_602_2 * ((var_602_4 - arg_599_1.typewritterCharCountI18N) / var_602_1)) > 0 and var_602_2 < var_602_5 then
					arg_599_1.talkMaxDuration = var_602_5

					if var_602_5 + var_602_0 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_5 + var_602_0
					end
				end
			end

			local var_602_6 = math.max(2.13333333333333, arg_599_1.talkMaxDuration)

			if var_602_0 <= arg_599_1.time_ and arg_599_1.time_ < var_602_0 + var_602_6 then
				arg_599_1.fswtw_.percent = Mathf.Lerp(arg_599_1.var_.oldValueTypewriter, var_602_3, (arg_599_1.time_ - var_602_0) / var_602_6)
				arg_599_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_599_1.fswtw_:SetDirty()
			end

			if arg_599_1.time_ >= var_602_0 + var_602_6 and arg_599_1.time_ < var_602_0 + var_602_6 + arg_602_0 then
				arg_599_1.fswtw_.percent = var_602_3

				arg_599_1.fswtw_:SetDirty()
				arg_599_1:ShowNextGo(true)

				arg_599_1.typewritterCharCountI18N = var_602_4
			end
		end

		arg_599_1.nodeConfigList_ = {}

		arg_599_1:InitPlayNodeList()
	end,
	Play122121147 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 122121147
		arg_603_1.duration_ = 9

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play122121148(arg_603_1)
			end
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			if 1.98333333333333 < arg_603_1.time_ and arg_603_1.time_ <= 1.98333333333333 + arg_606_0 then
				arg_603_1.fswbg_:SetActive(false)
				arg_603_1.dialog_:SetActive(true)
				SetActive(arg_603_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_603_1:ShowNextGo(false)
			end

			local var_606_0 = 0

			if 0 < arg_603_1.time_ and arg_603_1.time_ <= var_606_0 + arg_606_0 then
				arg_603_1.mask_.enabled = true
				arg_603_1.mask_.raycastTarget = true

				arg_603_1:SetGaussion(false)
			end

			local var_606_1 = 2

			if var_606_0 <= arg_603_1.time_ and arg_603_1.time_ < var_606_0 + var_606_1 then
				local var_606_2 = Color.New(0, 0, 0)

				var_606_2.a = Mathf.Lerp(0, 1, (arg_603_1.time_ - var_606_0) / var_606_1)
				arg_603_1.mask_.color = var_606_2
			end

			if arg_603_1.time_ >= var_606_0 + var_606_1 and arg_603_1.time_ < var_606_0 + var_606_1 + arg_606_0 then
				local var_606_3 = Color.New(0, 0, 0)

				var_606_3.a = 1
				arg_603_1.mask_.color = var_606_3
			end

			local var_606_4 = 2

			if 2 < arg_603_1.time_ and arg_603_1.time_ <= var_606_4 + arg_606_0 then
				arg_603_1.mask_.enabled = true
				arg_603_1.mask_.raycastTarget = true

				arg_603_1:SetGaussion(false)
			end

			local var_606_5 = 2

			if var_606_4 <= arg_603_1.time_ and arg_603_1.time_ < var_606_4 + var_606_5 then
				local var_606_6 = Color.New(0, 0, 0)

				var_606_6.a = Mathf.Lerp(1, 0, (arg_603_1.time_ - var_606_4) / var_606_5)
				arg_603_1.mask_.color = var_606_6
			end

			if arg_603_1.time_ >= var_606_4 + var_606_5 and arg_603_1.time_ < var_606_4 + var_606_5 + arg_606_0 then
				local var_606_7 = Color.New(0, 0, 0)

				arg_603_1.mask_.enabled = false
				var_606_7.a = 0
				arg_603_1.mask_.color = var_606_7
			end

			if arg_603_1.frameCnt_ <= 1 then
				arg_603_1.dialog_:SetActive(false)
			end

			local var_606_8 = 4
			local var_606_9 = 0.275

			if 4 < arg_603_1.time_ and arg_603_1.time_ <= var_606_8 + arg_606_0 then
				arg_603_1.talkMaxDuration = 0

				arg_603_1.dialog_:SetActive(true)

				arg_603_1.dialogCg_.alpha = 0

				local var_606_10 = LeanTween.value(arg_603_1.dialog_, 0, 1, 0.3)

				var_606_10:setOnUpdate(LuaHelper.FloatAction(function(arg_607_0)
					arg_603_1.dialogCg_.alpha = arg_607_0
				end))
				var_606_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_603_1.dialog_)
					var_606_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_603_1.duration_ = arg_603_1.duration_ + 0.3

				SetActive(arg_603_1.leftNameGo_, true)

				arg_603_1.leftNameTxt_.text = arg_603_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_603_1.leftNameTxt_.transform)

				arg_603_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_603_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_603_1:RecordName(arg_603_1.leftNameTxt_.text)
				SetActive(arg_603_1.iconTrs_.gameObject, true)
				arg_603_1.iconController_:SetSelectedState("hero")

				arg_603_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_603_1.callingController_:SetSelectedState("normal")

				arg_603_1.keyicon_.color = Color.New(1, 1, 1)
				arg_603_1.icon_.color = Color.New(1, 1, 1)

				local var_606_11 = arg_603_1:FormatText(arg_603_1:GetWordFromCfg(122121147).content)

				arg_603_1.text_.text = var_606_11

				LuaForUtil.ClearLinePrefixSymbol(arg_603_1.text_)

				local var_606_13 = 11 <= 0 and var_606_9 or var_606_9 * (utf8.len(var_606_11) / 11)

				if (11 <= 0 and var_606_9 or var_606_9 * (utf8.len(var_606_11) / 11)) > 0 and var_606_9 < var_606_13 then
					arg_603_1.talkMaxDuration = var_606_13
					var_606_8 = var_606_8 + 0.3

					if var_606_13 + var_606_8 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_13 + var_606_8
					end
				end

				arg_603_1.text_.text = var_606_11
				arg_603_1.typewritter.percent = 0

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(false)
				arg_603_1:RecordContent(arg_603_1.text_.text)
			end

			local var_606_14 = var_606_8 + 0.3
			local var_606_15 = math.max(var_606_9, arg_603_1.talkMaxDuration)

			if var_606_8 + 0.3 <= arg_603_1.time_ and arg_603_1.time_ < var_606_14 + var_606_15 then
				arg_603_1.typewritter.percent = (arg_603_1.time_ - var_606_14) / var_606_15

				arg_603_1.typewritter:SetDirty()
			end

			if arg_603_1.time_ >= var_606_14 + var_606_15 and arg_603_1.time_ < var_606_14 + var_606_15 + arg_606_0 then
				arg_603_1.typewritter.percent = 1

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(true)
			end
		end

		arg_603_1.nodeConfigList_ = {}

		arg_603_1:InitPlayNodeList()
	end,
	Play122121148 = function(arg_609_0, arg_609_1)
		arg_609_1.time_ = 0
		arg_609_1.frameCnt_ = 0
		arg_609_1.state_ = "playing"
		arg_609_1.curTalkId_ = 122121148
		arg_609_1.duration_ = 5

		SetActive(arg_609_1.tipsGo_, false)

		function arg_609_1.onSingleLineFinish_()
			arg_609_1.onSingleLineUpdate_ = nil
			arg_609_1.onSingleLineFinish_ = nil
			arg_609_1.state_ = "waiting"
		end

		function arg_609_1.playNext_(arg_611_0)
			if arg_611_0 == 1 then
				arg_609_0:Play122121149(arg_609_1)
			end
		end

		function arg_609_1.onSingleLineUpdate_(arg_612_0)
			local var_612_0 = 0.975

			if 0 < arg_609_1.time_ and arg_609_1.time_ <= 0 + arg_612_0 then
				arg_609_1.talkMaxDuration = 0
				arg_609_1.dialogCg_.alpha = 1

				arg_609_1.dialog_:SetActive(true)
				SetActive(arg_609_1.leftNameGo_, false)

				arg_609_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_609_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_609_1:RecordName(arg_609_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_609_1.iconTrs_.gameObject, false)
				arg_609_1.callingController_:SetSelectedState("normal")

				local var_612_1 = arg_609_1:FormatText(arg_609_1:GetWordFromCfg(122121148).content)

				arg_609_1.text_.text = var_612_1

				LuaForUtil.ClearLinePrefixSymbol(arg_609_1.text_)

				local var_612_3 = 39 <= 0 and var_612_0 or var_612_0 * (utf8.len(var_612_1) / 39)

				if (39 <= 0 and var_612_0 or var_612_0 * (utf8.len(var_612_1) / 39)) > 0 and var_612_0 < var_612_3 then
					arg_609_1.talkMaxDuration = var_612_3

					if var_612_3 + 0 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_3 + 0
					end
				end

				arg_609_1.text_.text = var_612_1
				arg_609_1.typewritter.percent = 0

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(false)
				arg_609_1:RecordContent(arg_609_1.text_.text)
			end

			local var_612_4 = math.max(var_612_0, arg_609_1.talkMaxDuration)

			if 0 <= arg_609_1.time_ and arg_609_1.time_ < 0 + var_612_4 then
				arg_609_1.typewritter.percent = (arg_609_1.time_ - 0) / var_612_4

				arg_609_1.typewritter:SetDirty()
			end

			if arg_609_1.time_ >= 0 + var_612_4 and arg_609_1.time_ < 0 + var_612_4 + arg_612_0 then
				arg_609_1.typewritter.percent = 1

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(true)
			end
		end

		arg_609_1.nodeConfigList_ = {}

		arg_609_1:InitPlayNodeList()
	end,
	Play122121149 = function(arg_613_0, arg_613_1)
		arg_613_1.time_ = 0
		arg_613_1.frameCnt_ = 0
		arg_613_1.state_ = "playing"
		arg_613_1.curTalkId_ = 122121149
		arg_613_1.duration_ = 3.28

		SetActive(arg_613_1.tipsGo_, false)

		function arg_613_1.onSingleLineFinish_()
			arg_613_1.onSingleLineUpdate_ = nil
			arg_613_1.onSingleLineFinish_ = nil
			arg_613_1.state_ = "waiting"
		end

		function arg_613_1.playNext_(arg_615_0)
			if arg_615_0 == 1 then
				arg_613_0:Play122121150(arg_613_1)
			end
		end

		function arg_613_1.onSingleLineUpdate_(arg_616_0)
			if 0 < arg_613_1.time_ and arg_613_1.time_ <= 0 + arg_616_0 then
				local var_616_0 = arg_613_1.bgs_.STblack

				arg_613_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_616_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_616_1 = var_616_0:GetComponent("SpriteRenderer")

				if var_616_1 and var_616_1.sprite then
					local var_616_2 = 2 * (var_616_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_616_0.transform.localScale = Vector3.New(var_616_2 / var_616_1.sprite.bounds.size.y < var_616_2 * manager.ui.mainCameraCom_.aspect / var_616_1.sprite.bounds.size.x and var_616_2 * manager.ui.mainCameraCom_.aspect / var_616_1.sprite.bounds.size.x or var_616_2 / var_616_1.sprite.bounds.size.y, var_616_2 / var_616_1.sprite.bounds.size.y < var_616_2 * manager.ui.mainCameraCom_.aspect / var_616_1.sprite.bounds.size.x and var_616_2 * manager.ui.mainCameraCom_.aspect / var_616_1.sprite.bounds.size.x or var_616_2 / var_616_1.sprite.bounds.size.y, 0)
				end

				for iter_616_0, iter_616_1 in pairs(arg_613_1.bgs_) do
					if iter_616_0 ~= "STblack" then
						iter_616_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_616_3 = 0

			if 0 < arg_613_1.time_ and arg_613_1.time_ <= var_616_3 + arg_616_0 then
				arg_613_1.mask_.enabled = true
				arg_613_1.mask_.raycastTarget = true

				arg_613_1:SetGaussion(false)
			end

			local var_616_4 = 2

			if var_616_3 <= arg_613_1.time_ and arg_613_1.time_ < var_616_3 + var_616_4 then
				local var_616_5 = Color.New(1, 1, 1)

				var_616_5.a = Mathf.Lerp(1, 0, (arg_613_1.time_ - var_616_3) / var_616_4)
				arg_613_1.mask_.color = var_616_5
			end

			if arg_613_1.time_ >= var_616_3 + var_616_4 and arg_613_1.time_ < var_616_3 + var_616_4 + arg_616_0 then
				local var_616_6 = Color.New(1, 1, 1)

				arg_613_1.mask_.enabled = false
				var_616_6.a = 0
				arg_613_1.mask_.color = var_616_6
			end

			if 0 < arg_613_1.time_ and arg_613_1.time_ <= 0 + arg_616_0 then
				arg_613_1.fswbg_:SetActive(true)
				arg_613_1.dialog_:SetActive(false)

				arg_613_1.fswtw_.percent = 0
				arg_613_1.fswt_.text = arg_613_1:FormatText(arg_613_1:GetWordFromCfg(122121149).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_613_1.fswt_)

				arg_613_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_613_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_613_1.fswtw_:SetDirty()

				arg_613_1.typewritterCharCountI18N = 0

				SetActive(arg_613_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_613_1:ShowNextGo(false)
			end

			local var_616_7 = 2

			if 2 < arg_613_1.time_ and arg_613_1.time_ <= var_616_7 + arg_616_0 then
				arg_613_1.var_.oldValueTypewriter = arg_613_1.fswtw_.percent

				SetActive(arg_613_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_613_1:ShowNextGo(false)
			end

			local var_616_8 = 19
			local var_616_9 = 1.26666666666667
			local var_616_10, var_616_11 = arg_613_1:GetPercentByPara(arg_613_1:FormatText(arg_613_1:GetWordFromCfg(122121149).content), 1)

			if var_616_7 < arg_613_1.time_ and arg_613_1.time_ <= var_616_7 + arg_616_0 then
				arg_613_1.talkMaxDuration = 0

				local var_616_12 = var_616_8 <= 0 and var_616_9 or var_616_9 * ((var_616_11 - arg_613_1.typewritterCharCountI18N) / var_616_8)

				if (var_616_8 <= 0 and var_616_9 or var_616_9 * ((var_616_11 - arg_613_1.typewritterCharCountI18N) / var_616_8)) > 0 and var_616_9 < var_616_12 then
					arg_613_1.talkMaxDuration = var_616_12

					if var_616_12 + var_616_7 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_12 + var_616_7
					end
				end
			end

			local var_616_13 = math.max(1.26666666666667, arg_613_1.talkMaxDuration)

			if var_616_7 <= arg_613_1.time_ and arg_613_1.time_ < var_616_7 + var_616_13 then
				arg_613_1.fswtw_.percent = Mathf.Lerp(arg_613_1.var_.oldValueTypewriter, var_616_10, (arg_613_1.time_ - var_616_7) / var_616_13)
				arg_613_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_613_1.fswtw_:SetDirty()
			end

			if arg_613_1.time_ >= var_616_7 + var_616_13 and arg_613_1.time_ < var_616_7 + var_616_13 + arg_616_0 then
				arg_613_1.fswtw_.percent = var_616_10

				arg_613_1.fswtw_:SetDirty()
				arg_613_1:ShowNextGo(true)

				arg_613_1.typewritterCharCountI18N = var_616_11
			end
		end

		arg_613_1.nodeConfigList_ = {}

		arg_613_1:InitPlayNodeList()
	end,
	Play122121150 = function(arg_617_0, arg_617_1)
		arg_617_1.time_ = 0
		arg_617_1.frameCnt_ = 0
		arg_617_1.state_ = "playing"
		arg_617_1.curTalkId_ = 122121150
		arg_617_1.duration_ = 1

		SetActive(arg_617_1.tipsGo_, false)

		function arg_617_1.onSingleLineFinish_()
			arg_617_1.onSingleLineUpdate_ = nil
			arg_617_1.onSingleLineFinish_ = nil
			arg_617_1.state_ = "waiting"
		end

		function arg_617_1.playNext_(arg_619_0)
			if arg_619_0 == 1 then
				arg_617_0:Play122121151(arg_617_1)
			end
		end

		function arg_617_1.onSingleLineUpdate_(arg_620_0)
			if 0 < arg_617_1.time_ and arg_617_1.time_ <= 0 + arg_620_0 then
				arg_617_1.fswbg_:SetActive(true)
				arg_617_1.dialog_:SetActive(false)

				arg_617_1.fswtw_.percent = 0
				arg_617_1.fswt_.text = arg_617_1:FormatText(arg_617_1:GetWordFromCfg(122121150).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_617_1.fswt_)

				arg_617_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_617_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_617_1.fswtw_:SetDirty()

				arg_617_1.typewritterCharCountI18N = 0

				SetActive(arg_617_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_617_1:ShowNextGo(false)
			end

			local var_620_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_617_1.time_ and arg_617_1.time_ <= var_620_0 + arg_620_0 then
				arg_617_1.var_.oldValueTypewriter = arg_617_1.fswtw_.percent

				SetActive(arg_617_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_617_1:ShowNextGo(false)
			end

			local var_620_1 = 11
			local var_620_2 = 0.733333333333333
			local var_620_3, var_620_4 = arg_617_1:GetPercentByPara(arg_617_1:FormatText(arg_617_1:GetWordFromCfg(122121150).content), 1)

			if var_620_0 < arg_617_1.time_ and arg_617_1.time_ <= var_620_0 + arg_620_0 then
				arg_617_1.talkMaxDuration = 0

				local var_620_5 = var_620_1 <= 0 and var_620_2 or var_620_2 * ((var_620_4 - arg_617_1.typewritterCharCountI18N) / var_620_1)

				if (var_620_1 <= 0 and var_620_2 or var_620_2 * ((var_620_4 - arg_617_1.typewritterCharCountI18N) / var_620_1)) > 0 and var_620_2 < var_620_5 then
					arg_617_1.talkMaxDuration = var_620_5

					if var_620_5 + var_620_0 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_5 + var_620_0
					end
				end
			end

			local var_620_6 = math.max(0.733333333333333, arg_617_1.talkMaxDuration)

			if var_620_0 <= arg_617_1.time_ and arg_617_1.time_ < var_620_0 + var_620_6 then
				arg_617_1.fswtw_.percent = Mathf.Lerp(arg_617_1.var_.oldValueTypewriter, var_620_3, (arg_617_1.time_ - var_620_0) / var_620_6)
				arg_617_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_617_1.fswtw_:SetDirty()
			end

			if arg_617_1.time_ >= var_620_0 + var_620_6 and arg_617_1.time_ < var_620_0 + var_620_6 + arg_620_0 then
				arg_617_1.fswtw_.percent = var_620_3

				arg_617_1.fswtw_:SetDirty()
				arg_617_1:ShowNextGo(true)

				arg_617_1.typewritterCharCountI18N = var_620_4
			end
		end

		arg_617_1.nodeConfigList_ = {}

		arg_617_1:InitPlayNodeList()
	end,
	Play122121151 = function(arg_621_0, arg_621_1)
		arg_621_1.time_ = 0
		arg_621_1.frameCnt_ = 0
		arg_621_1.state_ = "playing"
		arg_621_1.curTalkId_ = 122121151
		arg_621_1.duration_ = 2.75

		SetActive(arg_621_1.tipsGo_, false)

		function arg_621_1.onSingleLineFinish_()
			arg_621_1.onSingleLineUpdate_ = nil
			arg_621_1.onSingleLineFinish_ = nil
			arg_621_1.state_ = "waiting"
		end

		function arg_621_1.playNext_(arg_623_0)
			if arg_623_0 == 1 then
				arg_621_0:Play122121152(arg_621_1)
			end
		end

		function arg_621_1.onSingleLineUpdate_(arg_624_0)
			if 0 < arg_621_1.time_ and arg_621_1.time_ <= 0 + arg_624_0 then
				arg_621_1.fswbg_:SetActive(true)
				arg_621_1.dialog_:SetActive(false)

				arg_621_1.fswtw_.percent = 0
				arg_621_1.fswt_.text = arg_621_1:FormatText(arg_621_1:GetWordFromCfg(122121151).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_621_1.fswt_)

				arg_621_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_621_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_621_1.fswtw_:SetDirty()

				arg_621_1.typewritterCharCountI18N = 0

				SetActive(arg_621_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_621_1:ShowNextGo(false)
			end

			local var_624_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_621_1.time_ and arg_621_1.time_ <= var_624_0 + arg_624_0 then
				arg_621_1.var_.oldValueTypewriter = arg_621_1.fswtw_.percent

				SetActive(arg_621_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_621_1:ShowNextGo(false)
			end

			local var_624_1 = 41
			local var_624_2 = 2.73333333333333
			local var_624_3, var_624_4 = arg_621_1:GetPercentByPara(arg_621_1:FormatText(arg_621_1:GetWordFromCfg(122121151).content), 1)

			if var_624_0 < arg_621_1.time_ and arg_621_1.time_ <= var_624_0 + arg_624_0 then
				arg_621_1.talkMaxDuration = 0

				local var_624_5 = var_624_1 <= 0 and var_624_2 or var_624_2 * ((var_624_4 - arg_621_1.typewritterCharCountI18N) / var_624_1)

				if (var_624_1 <= 0 and var_624_2 or var_624_2 * ((var_624_4 - arg_621_1.typewritterCharCountI18N) / var_624_1)) > 0 and var_624_2 < var_624_5 then
					arg_621_1.talkMaxDuration = var_624_5

					if var_624_5 + var_624_0 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_5 + var_624_0
					end
				end
			end

			local var_624_6 = math.max(2.73333333333333, arg_621_1.talkMaxDuration)

			if var_624_0 <= arg_621_1.time_ and arg_621_1.time_ < var_624_0 + var_624_6 then
				arg_621_1.fswtw_.percent = Mathf.Lerp(arg_621_1.var_.oldValueTypewriter, var_624_3, (arg_621_1.time_ - var_624_0) / var_624_6)
				arg_621_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_621_1.fswtw_:SetDirty()
			end

			if arg_621_1.time_ >= var_624_0 + var_624_6 and arg_621_1.time_ < var_624_0 + var_624_6 + arg_624_0 then
				arg_621_1.fswtw_.percent = var_624_3

				arg_621_1.fswtw_:SetDirty()
				arg_621_1:ShowNextGo(true)

				arg_621_1.typewritterCharCountI18N = var_624_4
			end
		end

		arg_621_1.nodeConfigList_ = {}

		arg_621_1:InitPlayNodeList()
	end,
	Play122121152 = function(arg_625_0, arg_625_1)
		arg_625_1.time_ = 0
		arg_625_1.frameCnt_ = 0
		arg_625_1.state_ = "playing"
		arg_625_1.curTalkId_ = 122121152
		arg_625_1.duration_ = 0.35

		SetActive(arg_625_1.tipsGo_, false)

		function arg_625_1.onSingleLineFinish_()
			arg_625_1.onSingleLineUpdate_ = nil
			arg_625_1.onSingleLineFinish_ = nil
			arg_625_1.state_ = "waiting"
		end

		function arg_625_1.playNext_(arg_627_0)
			if arg_627_0 == 1 then
				arg_625_0:Play122121153(arg_625_1)
			end
		end

		function arg_625_1.onSingleLineUpdate_(arg_628_0)
			if 0 < arg_625_1.time_ and arg_625_1.time_ <= 0 + arg_628_0 then
				arg_625_1.fswbg_:SetActive(true)
				arg_625_1.dialog_:SetActive(false)

				arg_625_1.fswtw_.percent = 0
				arg_625_1.fswt_.text = arg_625_1:FormatText(arg_625_1:GetWordFromCfg(122121152).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_625_1.fswt_)

				arg_625_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_625_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_625_1.fswtw_:SetDirty()

				arg_625_1.typewritterCharCountI18N = 0

				SetActive(arg_625_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_625_1:ShowNextGo(false)
			end

			local var_628_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_625_1.time_ and arg_625_1.time_ <= var_628_0 + arg_628_0 then
				arg_625_1.var_.oldValueTypewriter = arg_625_1.fswtw_.percent

				SetActive(arg_625_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_625_1:ShowNextGo(false)
			end

			local var_628_1 = 5
			local var_628_2 = 0.333333333333333
			local var_628_3, var_628_4 = arg_625_1:GetPercentByPara(arg_625_1:FormatText(arg_625_1:GetWordFromCfg(122121152).content), 1)

			if var_628_0 < arg_625_1.time_ and arg_625_1.time_ <= var_628_0 + arg_628_0 then
				arg_625_1.talkMaxDuration = 0

				local var_628_5 = var_628_1 <= 0 and var_628_2 or var_628_2 * ((var_628_4 - arg_625_1.typewritterCharCountI18N) / var_628_1)

				if (var_628_1 <= 0 and var_628_2 or var_628_2 * ((var_628_4 - arg_625_1.typewritterCharCountI18N) / var_628_1)) > 0 and var_628_2 < var_628_5 then
					arg_625_1.talkMaxDuration = var_628_5

					if var_628_5 + var_628_0 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_5 + var_628_0
					end
				end
			end

			local var_628_6 = math.max(0.333333333333333, arg_625_1.talkMaxDuration)

			if var_628_0 <= arg_625_1.time_ and arg_625_1.time_ < var_628_0 + var_628_6 then
				arg_625_1.fswtw_.percent = Mathf.Lerp(arg_625_1.var_.oldValueTypewriter, var_628_3, (arg_625_1.time_ - var_628_0) / var_628_6)
				arg_625_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_625_1.fswtw_:SetDirty()
			end

			if arg_625_1.time_ >= var_628_0 + var_628_6 and arg_625_1.time_ < var_628_0 + var_628_6 + arg_628_0 then
				arg_625_1.fswtw_.percent = var_628_3

				arg_625_1.fswtw_:SetDirty()
				arg_625_1:ShowNextGo(true)

				arg_625_1.typewritterCharCountI18N = var_628_4
			end
		end

		arg_625_1.nodeConfigList_ = {}

		arg_625_1:InitPlayNodeList()
	end,
	Play122121153 = function(arg_629_0, arg_629_1)
		arg_629_1.time_ = 0
		arg_629_1.frameCnt_ = 0
		arg_629_1.state_ = "playing"
		arg_629_1.curTalkId_ = 122121153
		arg_629_1.duration_ = 1

		SetActive(arg_629_1.tipsGo_, false)

		function arg_629_1.onSingleLineFinish_()
			arg_629_1.onSingleLineUpdate_ = nil
			arg_629_1.onSingleLineFinish_ = nil
			arg_629_1.state_ = "waiting"
		end

		function arg_629_1.playNext_(arg_631_0)
			if arg_631_0 == 1 then
				arg_629_0:Play122121154(arg_629_1)
			end
		end

		function arg_629_1.onSingleLineUpdate_(arg_632_0)
			if 0 < arg_629_1.time_ and arg_629_1.time_ <= 0 + arg_632_0 then
				arg_629_1.fswbg_:SetActive(true)
				arg_629_1.dialog_:SetActive(false)

				arg_629_1.fswtw_.percent = 0
				arg_629_1.fswt_.text = arg_629_1:FormatText(arg_629_1:GetWordFromCfg(122121153).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_629_1.fswt_)

				arg_629_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_629_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_629_1.fswtw_:SetDirty()

				arg_629_1.typewritterCharCountI18N = 0

				SetActive(arg_629_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_629_1:ShowNextGo(false)
			end

			local var_632_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_629_1.time_ and arg_629_1.time_ <= var_632_0 + arg_632_0 then
				arg_629_1.var_.oldValueTypewriter = arg_629_1.fswtw_.percent

				SetActive(arg_629_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_629_1:ShowNextGo(false)
			end

			local var_632_1 = 8
			local var_632_2 = 0.533333333333333
			local var_632_3, var_632_4 = arg_629_1:GetPercentByPara(arg_629_1:FormatText(arg_629_1:GetWordFromCfg(122121153).content), 1)

			if var_632_0 < arg_629_1.time_ and arg_629_1.time_ <= var_632_0 + arg_632_0 then
				arg_629_1.talkMaxDuration = 0

				local var_632_5 = var_632_1 <= 0 and var_632_2 or var_632_2 * ((var_632_4 - arg_629_1.typewritterCharCountI18N) / var_632_1)

				if (var_632_1 <= 0 and var_632_2 or var_632_2 * ((var_632_4 - arg_629_1.typewritterCharCountI18N) / var_632_1)) > 0 and var_632_2 < var_632_5 then
					arg_629_1.talkMaxDuration = var_632_5

					if var_632_5 + var_632_0 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_5 + var_632_0
					end
				end
			end

			local var_632_6 = math.max(0.533333333333333, arg_629_1.talkMaxDuration)

			if var_632_0 <= arg_629_1.time_ and arg_629_1.time_ < var_632_0 + var_632_6 then
				arg_629_1.fswtw_.percent = Mathf.Lerp(arg_629_1.var_.oldValueTypewriter, var_632_3, (arg_629_1.time_ - var_632_0) / var_632_6)
				arg_629_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_629_1.fswtw_:SetDirty()
			end

			if arg_629_1.time_ >= var_632_0 + var_632_6 and arg_629_1.time_ < var_632_0 + var_632_6 + arg_632_0 then
				arg_629_1.fswtw_.percent = var_632_3

				arg_629_1.fswtw_:SetDirty()
				arg_629_1:ShowNextGo(true)

				arg_629_1.typewritterCharCountI18N = var_632_4
			end

			if 0 < arg_629_1.time_ and arg_629_1.time_ <= 0 + arg_632_0 then
				arg_629_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_632_9 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_629_1.bgmTxt_.text ~= var_632_9 and arg_629_1.bgmTxt_.text ~= "" then
						if arg_629_1.bgmTxt2_.text ~= "" then
							arg_629_1.bgmTxt_.text = arg_629_1.bgmTxt2_.text
						end

						arg_629_1.bgmTxt2_.text = var_632_9

						arg_629_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_629_1.bgmTxt_.text = var_632_9
						arg_629_1.bgmTxt2_.text = var_632_9
					end

					if arg_629_1.bgmTimer then
						arg_629_1.bgmTimer:Stop()

						arg_629_1.bgmTimer = nil
					end

					if arg_629_1.settingData.show_music_name == 1 then
						arg_629_1.musicController:SetSelectedState("show")
						arg_629_1.musicAnimator_:Play("open", 0, 0)

						if arg_629_1.settingData.music_time ~= 0 then
							arg_629_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_629_1.settingData.music_time), function()
								if arg_629_1 == nil or isNil(arg_629_1.bgmTxt_) then
									return
								end

								arg_629_1.musicController:SetSelectedState("hide")
								arg_629_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_629_1.nodeConfigList_ = {}

		arg_629_1:InitPlayNodeList()
	end,
	Play122121154 = function(arg_634_0, arg_634_1)
		arg_634_1.time_ = 0
		arg_634_1.frameCnt_ = 0
		arg_634_1.state_ = "playing"
		arg_634_1.curTalkId_ = 122121154
		arg_634_1.duration_ = 10.47

		local var_634_0 = {
			ja = 10.466,
			ko = 9.733,
			zh = 9.733
		}
		local var_634_1 = manager.audio:GetLocalizationFlag()

		if var_634_0[var_634_1] ~= nil then
			arg_634_1.duration_ = var_634_0[var_634_1]
		end

		SetActive(arg_634_1.tipsGo_, false)

		function arg_634_1.onSingleLineFinish_()
			arg_634_1.onSingleLineUpdate_ = nil
			arg_634_1.onSingleLineFinish_ = nil
			arg_634_1.state_ = "waiting"
		end

		function arg_634_1.playNext_(arg_636_0)
			if arg_636_0 == 1 then
				arg_634_0:Play122121155(arg_634_1)
			end
		end

		function arg_634_1.onSingleLineUpdate_(arg_637_0)
			if 2 < arg_634_1.time_ and arg_634_1.time_ <= 2 + arg_637_0 then
				local var_637_0 = arg_634_1.bgs_.ST15a

				arg_634_1.bgs_.ST15a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_637_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_637_1 = var_637_0:GetComponent("SpriteRenderer")

				if var_637_1 and var_637_1.sprite then
					local var_637_2 = 2 * (var_637_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_637_0.transform.localScale = Vector3.New(var_637_2 / var_637_1.sprite.bounds.size.y < var_637_2 * manager.ui.mainCameraCom_.aspect / var_637_1.sprite.bounds.size.x and var_637_2 * manager.ui.mainCameraCom_.aspect / var_637_1.sprite.bounds.size.x or var_637_2 / var_637_1.sprite.bounds.size.y, var_637_2 / var_637_1.sprite.bounds.size.y < var_637_2 * manager.ui.mainCameraCom_.aspect / var_637_1.sprite.bounds.size.x and var_637_2 * manager.ui.mainCameraCom_.aspect / var_637_1.sprite.bounds.size.x or var_637_2 / var_637_1.sprite.bounds.size.y, 0)
				end

				for iter_637_0, iter_637_1 in pairs(arg_634_1.bgs_) do
					if iter_637_0 ~= "ST15a" then
						iter_637_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_637_3 = 0

			if 0 < arg_634_1.time_ and arg_634_1.time_ <= var_637_3 + arg_637_0 then
				arg_634_1.mask_.enabled = true
				arg_634_1.mask_.raycastTarget = true

				arg_634_1:SetGaussion(false)
			end

			local var_637_4 = 2

			if var_637_3 <= arg_634_1.time_ and arg_634_1.time_ < var_637_3 + var_637_4 then
				local var_637_5 = Color.New(0, 0, 0)

				var_637_5.a = Mathf.Lerp(0, 1, (arg_634_1.time_ - var_637_3) / var_637_4)
				arg_634_1.mask_.color = var_637_5
			end

			if arg_634_1.time_ >= var_637_3 + var_637_4 and arg_634_1.time_ < var_637_3 + var_637_4 + arg_637_0 then
				local var_637_6 = Color.New(0, 0, 0)

				var_637_6.a = 1
				arg_634_1.mask_.color = var_637_6
			end

			local var_637_7 = 2

			if 2 < arg_634_1.time_ and arg_634_1.time_ <= var_637_7 + arg_637_0 then
				arg_634_1.mask_.enabled = true
				arg_634_1.mask_.raycastTarget = true

				arg_634_1:SetGaussion(false)
			end

			local var_637_8 = 2

			if var_637_7 <= arg_634_1.time_ and arg_634_1.time_ < var_637_7 + var_637_8 then
				local var_637_9 = Color.New(0, 0, 0)

				var_637_9.a = Mathf.Lerp(1, 0, (arg_634_1.time_ - var_637_7) / var_637_8)
				arg_634_1.mask_.color = var_637_9
			end

			if arg_634_1.time_ >= var_637_7 + var_637_8 and arg_634_1.time_ < var_637_7 + var_637_8 + arg_637_0 then
				local var_637_10 = Color.New(0, 0, 0)

				arg_634_1.mask_.enabled = false
				var_637_10.a = 0
				arg_634_1.mask_.color = var_637_10
			end

			if 2 < arg_634_1.time_ and arg_634_1.time_ <= 2 + arg_637_0 then
				arg_634_1.fswbg_:SetActive(false)
				arg_634_1.dialog_:SetActive(false)
				SetActive(arg_634_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_634_1:ShowNextGo(false)
			end

			if arg_634_1.frameCnt_ <= 1 then
				arg_634_1.dialog_:SetActive(false)
			end

			local var_637_11 = 4
			local var_637_12 = 0.55

			if 4 < arg_634_1.time_ and arg_634_1.time_ <= var_637_11 + arg_637_0 then
				arg_634_1.talkMaxDuration = 0

				arg_634_1.dialog_:SetActive(true)

				arg_634_1.dialogCg_.alpha = 0

				local var_637_13 = LeanTween.value(arg_634_1.dialog_, 0, 1, 0.3)

				var_637_13:setOnUpdate(LuaHelper.FloatAction(function(arg_638_0)
					arg_634_1.dialogCg_.alpha = arg_638_0
				end))
				var_637_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_634_1.dialog_)
					var_637_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_634_1.duration_ = arg_634_1.duration_ + 0.3

				SetActive(arg_634_1.leftNameGo_, true)

				arg_634_1.leftNameTxt_.text = arg_634_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_634_1.leftNameTxt_.transform)

				arg_634_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_634_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_634_1:RecordName(arg_634_1.leftNameTxt_.text)
				SetActive(arg_634_1.iconTrs_.gameObject, true)
				arg_634_1.iconController_:SetSelectedState("hero")

				arg_634_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_634_1.callingController_:SetSelectedState("normal")

				arg_634_1.keyicon_.color = Color.New(1, 1, 1)
				arg_634_1.icon_.color = Color.New(1, 1, 1)

				local var_637_14 = arg_634_1:GetWordFromCfg(122121154)
				local var_637_15 = arg_634_1:FormatText(var_637_14.content)

				arg_634_1.text_.text = var_637_15

				LuaForUtil.ClearLinePrefixSymbol(arg_634_1.text_)

				local var_637_17 = 22 <= 0 and var_637_12 or var_637_12 * (utf8.len(var_637_15) / 22)

				if (22 <= 0 and var_637_12 or var_637_12 * (utf8.len(var_637_15) / 22)) > 0 and var_637_12 < var_637_17 then
					arg_634_1.talkMaxDuration = var_637_17
					var_637_11 = var_637_11 + 0.3

					if var_637_17 + var_637_11 > arg_634_1.duration_ then
						arg_634_1.duration_ = var_637_17 + var_637_11
					end
				end

				arg_634_1.text_.text = var_637_15
				arg_634_1.typewritter.percent = 0

				arg_634_1.typewritter:SetDirty()
				arg_634_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121154", "story_v_out_122121.awb") ~= 0 then
					local var_637_18 = manager.audio:GetVoiceLength("story_v_out_122121", "122121154", "story_v_out_122121.awb") / 1000

					if var_637_18 + var_637_11 > arg_634_1.duration_ then
						arg_634_1.duration_ = var_637_18 + var_637_11
					end

					if var_637_14.prefab_name ~= "" and arg_634_1.actors_[var_637_14.prefab_name] ~= nil then
						local var_637_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_634_1.actors_[var_637_14.prefab_name].transform, "story_v_out_122121", "122121154", "story_v_out_122121.awb")

						arg_634_1:RecordAudio("122121154", var_637_19)
						arg_634_1:RecordAudio("122121154", var_637_19)
					else
						arg_634_1:AudioAction("play", "voice", "story_v_out_122121", "122121154", "story_v_out_122121.awb")
					end

					arg_634_1:RecordHistoryTalkVoice("story_v_out_122121", "122121154", "story_v_out_122121.awb")
				end

				arg_634_1:RecordContent(arg_634_1.text_.text)
			end

			local var_637_20 = var_637_11 + 0.3
			local var_637_21 = math.max(var_637_12, arg_634_1.talkMaxDuration)

			if var_637_11 + 0.3 <= arg_634_1.time_ and arg_634_1.time_ < var_637_20 + var_637_21 then
				arg_634_1.typewritter.percent = (arg_634_1.time_ - var_637_20) / var_637_21

				arg_634_1.typewritter:SetDirty()
			end

			if arg_634_1.time_ >= var_637_20 + var_637_21 and arg_634_1.time_ < var_637_20 + var_637_21 + arg_637_0 then
				arg_634_1.typewritter.percent = 1

				arg_634_1.typewritter:SetDirty()
				arg_634_1:ShowNextGo(true)
			end
		end

		arg_634_1.nodeConfigList_ = {}

		arg_634_1:InitPlayNodeList()
	end,
	Play122121155 = function(arg_640_0, arg_640_1)
		arg_640_1.time_ = 0
		arg_640_1.frameCnt_ = 0
		arg_640_1.state_ = "playing"
		arg_640_1.curTalkId_ = 122121155
		arg_640_1.duration_ = 5

		SetActive(arg_640_1.tipsGo_, false)

		function arg_640_1.onSingleLineFinish_()
			arg_640_1.onSingleLineUpdate_ = nil
			arg_640_1.onSingleLineFinish_ = nil
			arg_640_1.state_ = "waiting"
		end

		function arg_640_1.playNext_(arg_642_0)
			if arg_642_0 == 1 then
				arg_640_0:Play122121156(arg_640_1)
			end
		end

		function arg_640_1.onSingleLineUpdate_(arg_643_0)
			local var_643_0 = 0.075

			if 0 < arg_640_1.time_ and arg_640_1.time_ <= 0 + arg_643_0 then
				arg_640_1.talkMaxDuration = 0
				arg_640_1.dialogCg_.alpha = 1

				arg_640_1.dialog_:SetActive(true)
				SetActive(arg_640_1.leftNameGo_, true)

				arg_640_1.leftNameTxt_.text = arg_640_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_640_1.leftNameTxt_.transform)

				arg_640_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_640_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_640_1:RecordName(arg_640_1.leftNameTxt_.text)
				SetActive(arg_640_1.iconTrs_.gameObject, true)
				arg_640_1.iconController_:SetSelectedState("hero")

				arg_640_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_640_1.callingController_:SetSelectedState("normal")

				arg_640_1.keyicon_.color = Color.New(1, 1, 1)
				arg_640_1.icon_.color = Color.New(1, 1, 1)

				local var_643_1 = arg_640_1:FormatText(arg_640_1:GetWordFromCfg(122121155).content)

				arg_640_1.text_.text = var_643_1

				LuaForUtil.ClearLinePrefixSymbol(arg_640_1.text_)

				local var_643_3 = 3 <= 0 and var_643_0 or var_643_0 * (utf8.len(var_643_1) / 3)

				if (3 <= 0 and var_643_0 or var_643_0 * (utf8.len(var_643_1) / 3)) > 0 and var_643_0 < var_643_3 then
					arg_640_1.talkMaxDuration = var_643_3

					if var_643_3 + 0 > arg_640_1.duration_ then
						arg_640_1.duration_ = var_643_3 + 0
					end
				end

				arg_640_1.text_.text = var_643_1
				arg_640_1.typewritter.percent = 0

				arg_640_1.typewritter:SetDirty()
				arg_640_1:ShowNextGo(false)
				arg_640_1:RecordContent(arg_640_1.text_.text)
			end

			local var_643_4 = math.max(var_643_0, arg_640_1.talkMaxDuration)

			if 0 <= arg_640_1.time_ and arg_640_1.time_ < 0 + var_643_4 then
				arg_640_1.typewritter.percent = (arg_640_1.time_ - 0) / var_643_4

				arg_640_1.typewritter:SetDirty()
			end

			if arg_640_1.time_ >= 0 + var_643_4 and arg_640_1.time_ < 0 + var_643_4 + arg_643_0 then
				arg_640_1.typewritter.percent = 1

				arg_640_1.typewritter:SetDirty()
				arg_640_1:ShowNextGo(true)
			end
		end

		arg_640_1.nodeConfigList_ = {}

		arg_640_1:InitPlayNodeList()
	end,
	Play122121156 = function(arg_644_0, arg_644_1)
		arg_644_1.time_ = 0
		arg_644_1.frameCnt_ = 0
		arg_644_1.state_ = "playing"
		arg_644_1.curTalkId_ = 122121156
		arg_644_1.duration_ = 1.5

		local var_644_0 = {
			ja = 1.5,
			ko = 1.333,
			zh = 1.333
		}
		local var_644_1 = manager.audio:GetLocalizationFlag()

		if var_644_0[var_644_1] ~= nil then
			arg_644_1.duration_ = var_644_0[var_644_1]
		end

		SetActive(arg_644_1.tipsGo_, false)

		function arg_644_1.onSingleLineFinish_()
			arg_644_1.onSingleLineUpdate_ = nil
			arg_644_1.onSingleLineFinish_ = nil
			arg_644_1.state_ = "waiting"
		end

		function arg_644_1.playNext_(arg_646_0)
			if arg_646_0 == 1 then
				arg_644_0:Play122121157(arg_644_1)
			end
		end

		function arg_644_1.onSingleLineUpdate_(arg_647_0)
			if 0 < arg_644_1.time_ and arg_644_1.time_ <= 0 + arg_647_0 then
				arg_644_1.mask_.enabled = true
				arg_644_1.mask_.raycastTarget = true

				arg_644_1:SetGaussion(false)
			end

			local var_647_0 = 1

			if 0 <= arg_644_1.time_ and arg_644_1.time_ < 0 + var_647_0 then
				local var_647_1 = Color.New(1, 1, 1)

				var_647_1.a = Mathf.Lerp(1, 0, (arg_644_1.time_ - 0) / var_647_0)
				arg_644_1.mask_.color = var_647_1
			end

			if arg_644_1.time_ >= 0 + var_647_0 and arg_644_1.time_ < 0 + var_647_0 + arg_647_0 then
				local var_647_2 = Color.New(1, 1, 1)

				arg_644_1.mask_.enabled = false
				var_647_2.a = 0
				arg_644_1.mask_.color = var_647_2
			end

			local var_647_3 = 0
			local var_647_4 = 0.225

			if 0 < arg_644_1.time_ and arg_644_1.time_ <= var_647_3 + arg_647_0 then
				arg_644_1.talkMaxDuration = 0

				arg_644_1.dialog_:SetActive(true)

				arg_644_1.dialogCg_.alpha = 0

				local var_647_5 = LeanTween.value(arg_644_1.dialog_, 0, 1, 0.3)

				var_647_5:setOnUpdate(LuaHelper.FloatAction(function(arg_648_0)
					arg_644_1.dialogCg_.alpha = arg_648_0
				end))
				var_647_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_644_1.dialog_)
					var_647_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_644_1.duration_ = arg_644_1.duration_ + 0.3

				SetActive(arg_644_1.leftNameGo_, true)

				arg_644_1.leftNameTxt_.text = arg_644_1:FormatText(StoryNameCfg[449].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_644_1.leftNameTxt_.transform)

				arg_644_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_644_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_644_1:RecordName(arg_644_1.leftNameTxt_.text)
				SetActive(arg_644_1.iconTrs_.gameObject, false)
				arg_644_1.callingController_:SetSelectedState("normal")

				local var_647_6 = arg_644_1:GetWordFromCfg(122121156)
				local var_647_7 = arg_644_1:FormatText(var_647_6.content)

				arg_644_1.text_.text = var_647_7

				LuaForUtil.ClearLinePrefixSymbol(arg_644_1.text_)

				local var_647_9 = 9 <= 0 and var_647_4 or var_647_4 * (utf8.len(var_647_7) / 9)

				if (9 <= 0 and var_647_4 or var_647_4 * (utf8.len(var_647_7) / 9)) > 0 and var_647_4 < var_647_9 then
					arg_644_1.talkMaxDuration = var_647_9
					var_647_3 = var_647_3 + 0.3

					if var_647_9 + var_647_3 > arg_644_1.duration_ then
						arg_644_1.duration_ = var_647_9 + var_647_3
					end
				end

				arg_644_1.text_.text = var_647_7
				arg_644_1.typewritter.percent = 0

				arg_644_1.typewritter:SetDirty()
				arg_644_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121156", "story_v_out_122121.awb") ~= 0 then
					local var_647_10 = manager.audio:GetVoiceLength("story_v_out_122121", "122121156", "story_v_out_122121.awb") / 1000

					if var_647_10 + var_647_3 > arg_644_1.duration_ then
						arg_644_1.duration_ = var_647_10 + var_647_3
					end

					if var_647_6.prefab_name ~= "" and arg_644_1.actors_[var_647_6.prefab_name] ~= nil then
						local var_647_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_644_1.actors_[var_647_6.prefab_name].transform, "story_v_out_122121", "122121156", "story_v_out_122121.awb")

						arg_644_1:RecordAudio("122121156", var_647_11)
						arg_644_1:RecordAudio("122121156", var_647_11)
					else
						arg_644_1:AudioAction("play", "voice", "story_v_out_122121", "122121156", "story_v_out_122121.awb")
					end

					arg_644_1:RecordHistoryTalkVoice("story_v_out_122121", "122121156", "story_v_out_122121.awb")
				end

				arg_644_1:RecordContent(arg_644_1.text_.text)
			end

			local var_647_12 = var_647_3 + 0.3
			local var_647_13 = math.max(var_647_4, arg_644_1.talkMaxDuration)

			if var_647_3 + 0.3 <= arg_644_1.time_ and arg_644_1.time_ < var_647_12 + var_647_13 then
				arg_644_1.typewritter.percent = (arg_644_1.time_ - var_647_12) / var_647_13

				arg_644_1.typewritter:SetDirty()
			end

			if arg_644_1.time_ >= var_647_12 + var_647_13 and arg_644_1.time_ < var_647_12 + var_647_13 + arg_647_0 then
				arg_644_1.typewritter.percent = 1

				arg_644_1.typewritter:SetDirty()
				arg_644_1:ShowNextGo(true)
			end
		end

		arg_644_1.nodeConfigList_ = {}

		arg_644_1:InitPlayNodeList()
	end,
	Play122121157 = function(arg_650_0, arg_650_1)
		arg_650_1.time_ = 0
		arg_650_1.frameCnt_ = 0
		arg_650_1.state_ = "playing"
		arg_650_1.curTalkId_ = 122121157
		arg_650_1.duration_ = 5

		SetActive(arg_650_1.tipsGo_, false)

		function arg_650_1.onSingleLineFinish_()
			arg_650_1.onSingleLineUpdate_ = nil
			arg_650_1.onSingleLineFinish_ = nil
			arg_650_1.state_ = "waiting"
		end

		function arg_650_1.playNext_(arg_652_0)
			if arg_652_0 == 1 then
				arg_650_0:Play122121158(arg_650_1)
			end
		end

		function arg_650_1.onSingleLineUpdate_(arg_653_0)
			local var_653_0 = 1.15

			if 0 < arg_650_1.time_ and arg_650_1.time_ <= 0 + arg_653_0 then
				arg_650_1.talkMaxDuration = 0
				arg_650_1.dialogCg_.alpha = 1

				arg_650_1.dialog_:SetActive(true)
				SetActive(arg_650_1.leftNameGo_, false)

				arg_650_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_650_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_650_1:RecordName(arg_650_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_650_1.iconTrs_.gameObject, false)
				arg_650_1.callingController_:SetSelectedState("normal")

				local var_653_1 = arg_650_1:FormatText(arg_650_1:GetWordFromCfg(122121157).content)

				arg_650_1.text_.text = var_653_1

				LuaForUtil.ClearLinePrefixSymbol(arg_650_1.text_)

				local var_653_3 = 46 <= 0 and var_653_0 or var_653_0 * (utf8.len(var_653_1) / 46)

				if (46 <= 0 and var_653_0 or var_653_0 * (utf8.len(var_653_1) / 46)) > 0 and var_653_0 < var_653_3 then
					arg_650_1.talkMaxDuration = var_653_3

					if var_653_3 + 0 > arg_650_1.duration_ then
						arg_650_1.duration_ = var_653_3 + 0
					end
				end

				arg_650_1.text_.text = var_653_1
				arg_650_1.typewritter.percent = 0

				arg_650_1.typewritter:SetDirty()
				arg_650_1:ShowNextGo(false)
				arg_650_1:RecordContent(arg_650_1.text_.text)
			end

			local var_653_4 = math.max(var_653_0, arg_650_1.talkMaxDuration)

			if 0 <= arg_650_1.time_ and arg_650_1.time_ < 0 + var_653_4 then
				arg_650_1.typewritter.percent = (arg_650_1.time_ - 0) / var_653_4

				arg_650_1.typewritter:SetDirty()
			end

			if arg_650_1.time_ >= 0 + var_653_4 and arg_650_1.time_ < 0 + var_653_4 + arg_653_0 then
				arg_650_1.typewritter.percent = 1

				arg_650_1.typewritter:SetDirty()
				arg_650_1:ShowNextGo(true)
			end
		end

		arg_650_1.nodeConfigList_ = {}

		arg_650_1:InitPlayNodeList()
	end,
	Play122121158 = function(arg_654_0, arg_654_1)
		arg_654_1.time_ = 0
		arg_654_1.frameCnt_ = 0
		arg_654_1.state_ = "playing"
		arg_654_1.curTalkId_ = 122121158
		arg_654_1.duration_ = 5

		SetActive(arg_654_1.tipsGo_, false)

		function arg_654_1.onSingleLineFinish_()
			arg_654_1.onSingleLineUpdate_ = nil
			arg_654_1.onSingleLineFinish_ = nil
			arg_654_1.state_ = "waiting"
		end

		function arg_654_1.playNext_(arg_656_0)
			if arg_656_0 == 1 then
				arg_654_0:Play122121159(arg_654_1)
			end
		end

		function arg_654_1.onSingleLineUpdate_(arg_657_0)
			local var_657_0 = 0.175

			if 0 < arg_654_1.time_ and arg_654_1.time_ <= 0 + arg_657_0 then
				arg_654_1.talkMaxDuration = 0
				arg_654_1.dialogCg_.alpha = 1

				arg_654_1.dialog_:SetActive(true)
				SetActive(arg_654_1.leftNameGo_, true)

				arg_654_1.leftNameTxt_.text = arg_654_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_654_1.leftNameTxt_.transform)

				arg_654_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_654_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_654_1:RecordName(arg_654_1.leftNameTxt_.text)
				SetActive(arg_654_1.iconTrs_.gameObject, true)
				arg_654_1.iconController_:SetSelectedState("hero")

				arg_654_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_654_1.callingController_:SetSelectedState("normal")

				arg_654_1.keyicon_.color = Color.New(1, 1, 1)
				arg_654_1.icon_.color = Color.New(1, 1, 1)

				local var_657_1 = arg_654_1:FormatText(arg_654_1:GetWordFromCfg(122121158).content)

				arg_654_1.text_.text = var_657_1

				LuaForUtil.ClearLinePrefixSymbol(arg_654_1.text_)

				local var_657_3 = 7 <= 0 and var_657_0 or var_657_0 * (utf8.len(var_657_1) / 7)

				if (7 <= 0 and var_657_0 or var_657_0 * (utf8.len(var_657_1) / 7)) > 0 and var_657_0 < var_657_3 then
					arg_654_1.talkMaxDuration = var_657_3

					if var_657_3 + 0 > arg_654_1.duration_ then
						arg_654_1.duration_ = var_657_3 + 0
					end
				end

				arg_654_1.text_.text = var_657_1
				arg_654_1.typewritter.percent = 0

				arg_654_1.typewritter:SetDirty()
				arg_654_1:ShowNextGo(false)
				arg_654_1:RecordContent(arg_654_1.text_.text)
			end

			local var_657_4 = math.max(var_657_0, arg_654_1.talkMaxDuration)

			if 0 <= arg_654_1.time_ and arg_654_1.time_ < 0 + var_657_4 then
				arg_654_1.typewritter.percent = (arg_654_1.time_ - 0) / var_657_4

				arg_654_1.typewritter:SetDirty()
			end

			if arg_654_1.time_ >= 0 + var_657_4 and arg_654_1.time_ < 0 + var_657_4 + arg_657_0 then
				arg_654_1.typewritter.percent = 1

				arg_654_1.typewritter:SetDirty()
				arg_654_1:ShowNextGo(true)
			end
		end

		arg_654_1.nodeConfigList_ = {}

		arg_654_1:InitPlayNodeList()
	end,
	Play122121159 = function(arg_658_0, arg_658_1)
		arg_658_1.time_ = 0
		arg_658_1.frameCnt_ = 0
		arg_658_1.state_ = "playing"
		arg_658_1.curTalkId_ = 122121159
		arg_658_1.duration_ = 5

		SetActive(arg_658_1.tipsGo_, false)

		function arg_658_1.onSingleLineFinish_()
			arg_658_1.onSingleLineUpdate_ = nil
			arg_658_1.onSingleLineFinish_ = nil
			arg_658_1.state_ = "waiting"
		end

		function arg_658_1.playNext_(arg_660_0)
			if arg_660_0 == 1 then
				arg_658_0:Play122121160(arg_658_1)
			end
		end

		function arg_658_1.onSingleLineUpdate_(arg_661_0)
			local var_661_0 = 1.425

			if 0 < arg_658_1.time_ and arg_658_1.time_ <= 0 + arg_661_0 then
				arg_658_1.talkMaxDuration = 0
				arg_658_1.dialogCg_.alpha = 1

				arg_658_1.dialog_:SetActive(true)
				SetActive(arg_658_1.leftNameGo_, false)

				arg_658_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_658_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_658_1:RecordName(arg_658_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_658_1.iconTrs_.gameObject, false)
				arg_658_1.callingController_:SetSelectedState("normal")

				local var_661_1 = arg_658_1:FormatText(arg_658_1:GetWordFromCfg(122121159).content)

				arg_658_1.text_.text = var_661_1

				LuaForUtil.ClearLinePrefixSymbol(arg_658_1.text_)

				local var_661_3 = 57 <= 0 and var_661_0 or var_661_0 * (utf8.len(var_661_1) / 57)

				if (57 <= 0 and var_661_0 or var_661_0 * (utf8.len(var_661_1) / 57)) > 0 and var_661_0 < var_661_3 then
					arg_658_1.talkMaxDuration = var_661_3

					if var_661_3 + 0 > arg_658_1.duration_ then
						arg_658_1.duration_ = var_661_3 + 0
					end
				end

				arg_658_1.text_.text = var_661_1
				arg_658_1.typewritter.percent = 0

				arg_658_1.typewritter:SetDirty()
				arg_658_1:ShowNextGo(false)
				arg_658_1:RecordContent(arg_658_1.text_.text)
			end

			local var_661_4 = math.max(var_661_0, arg_658_1.talkMaxDuration)

			if 0 <= arg_658_1.time_ and arg_658_1.time_ < 0 + var_661_4 then
				arg_658_1.typewritter.percent = (arg_658_1.time_ - 0) / var_661_4

				arg_658_1.typewritter:SetDirty()
			end

			if arg_658_1.time_ >= 0 + var_661_4 and arg_658_1.time_ < 0 + var_661_4 + arg_661_0 then
				arg_658_1.typewritter.percent = 1

				arg_658_1.typewritter:SetDirty()
				arg_658_1:ShowNextGo(true)
			end
		end

		arg_658_1.nodeConfigList_ = {}

		arg_658_1:InitPlayNodeList()
	end,
	Play122121160 = function(arg_662_0, arg_662_1)
		arg_662_1.time_ = 0
		arg_662_1.frameCnt_ = 0
		arg_662_1.state_ = "playing"
		arg_662_1.curTalkId_ = 122121160
		arg_662_1.duration_ = 4.9

		local var_662_0 = {
			ja = 4.9,
			ko = 3.8,
			zh = 3.8
		}
		local var_662_1 = manager.audio:GetLocalizationFlag()

		if var_662_0[var_662_1] ~= nil then
			arg_662_1.duration_ = var_662_0[var_662_1]
		end

		SetActive(arg_662_1.tipsGo_, false)

		function arg_662_1.onSingleLineFinish_()
			arg_662_1.onSingleLineUpdate_ = nil
			arg_662_1.onSingleLineFinish_ = nil
			arg_662_1.state_ = "waiting"
		end

		function arg_662_1.playNext_(arg_664_0)
			if arg_664_0 == 1 then
				arg_662_0:Play122121161(arg_662_1)
			end
		end

		function arg_662_1.onSingleLineUpdate_(arg_665_0)
			if arg_662_1.bgs_.XH0504 == nil then
				local var_665_0 = Object.Instantiate(arg_662_1.paintGo_)

				var_665_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0504")
				var_665_0.name = "XH0504"
				var_665_0.transform.parent = arg_662_1.stage_.transform
				var_665_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_662_1.bgs_.XH0504 = var_665_0
			end

			if 0 < arg_662_1.time_ and arg_662_1.time_ <= 0 + arg_665_0 then
				local var_665_1 = arg_662_1.bgs_.XH0504

				arg_662_1.bgs_.XH0504.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_665_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_665_2 = var_665_1:GetComponent("SpriteRenderer")

				if var_665_2 and var_665_2.sprite then
					local var_665_3 = 2 * (var_665_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_665_1.transform.localScale = Vector3.New(var_665_3 / var_665_2.sprite.bounds.size.y < var_665_3 * manager.ui.mainCameraCom_.aspect / var_665_2.sprite.bounds.size.x and var_665_3 * manager.ui.mainCameraCom_.aspect / var_665_2.sprite.bounds.size.x or var_665_3 / var_665_2.sprite.bounds.size.y, var_665_3 / var_665_2.sprite.bounds.size.y < var_665_3 * manager.ui.mainCameraCom_.aspect / var_665_2.sprite.bounds.size.x and var_665_3 * manager.ui.mainCameraCom_.aspect / var_665_2.sprite.bounds.size.x or var_665_3 / var_665_2.sprite.bounds.size.y, 0)
				end

				for iter_665_0, iter_665_1 in pairs(arg_662_1.bgs_) do
					if iter_665_0 ~= "XH0504" then
						iter_665_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_665_4 = 0

			if 0 < arg_662_1.time_ and arg_662_1.time_ <= var_665_4 + arg_665_0 then
				arg_662_1.mask_.enabled = true
				arg_662_1.mask_.raycastTarget = true

				arg_662_1:SetGaussion(false)
			end

			local var_665_5 = 1

			if var_665_4 <= arg_662_1.time_ and arg_662_1.time_ < var_665_4 + var_665_5 then
				local var_665_6 = Color.New(1, 1, 1)

				var_665_6.a = Mathf.Lerp(1, 0, (arg_662_1.time_ - var_665_4) / var_665_5)
				arg_662_1.mask_.color = var_665_6
			end

			if arg_662_1.time_ >= var_665_4 + var_665_5 and arg_662_1.time_ < var_665_4 + var_665_5 + arg_665_0 then
				local var_665_7 = Color.New(1, 1, 1)

				arg_662_1.mask_.enabled = false
				var_665_7.a = 0
				arg_662_1.mask_.color = var_665_7
			end

			local var_665_8 = manager.ui.mainCamera.transform

			if 1 < arg_662_1.time_ and arg_662_1.time_ <= 1 + arg_665_0 then
				arg_662_1.var_.shakeOldPos = var_665_8.localPosition
			end

			local var_665_9 = 0.375

			if 1 <= arg_662_1.time_ and arg_662_1.time_ < 1 + var_665_9 then
				local var_665_10, var_665_11 = math.modf((arg_662_1.time_ - 1) / 0.066)

				var_665_8.localPosition = Vector3.New(var_665_11 * 0.13, var_665_11 * 0.13, var_665_11 * 0.13) + arg_662_1.var_.shakeOldPos
			end

			if arg_662_1.time_ >= 1 + var_665_9 and arg_662_1.time_ < 1 + var_665_9 + arg_665_0 then
				var_665_8.localPosition = arg_662_1.var_.shakeOldPos
			end

			if arg_662_1.frameCnt_ <= 1 then
				arg_662_1.dialog_:SetActive(false)
			end

			local var_665_12 = 1
			local var_665_13 = 0.375

			if 1 < arg_662_1.time_ and arg_662_1.time_ <= var_665_12 + arg_665_0 then
				arg_662_1.talkMaxDuration = 0

				arg_662_1.dialog_:SetActive(true)

				arg_662_1.dialogCg_.alpha = 0

				local var_665_14 = LeanTween.value(arg_662_1.dialog_, 0, 1, 0.3)

				var_665_14:setOnUpdate(LuaHelper.FloatAction(function(arg_666_0)
					arg_662_1.dialogCg_.alpha = arg_666_0
				end))
				var_665_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_662_1.dialog_)
					var_665_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_662_1.duration_ = arg_662_1.duration_ + 0.3

				SetActive(arg_662_1.leftNameGo_, true)

				arg_662_1.leftNameTxt_.text = arg_662_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_662_1.leftNameTxt_.transform)

				arg_662_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_662_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_662_1:RecordName(arg_662_1.leftNameTxt_.text)
				SetActive(arg_662_1.iconTrs_.gameObject, false)
				arg_662_1.callingController_:SetSelectedState("normal")

				local var_665_15 = arg_662_1:GetWordFromCfg(122121160)
				local var_665_16 = arg_662_1:FormatText(var_665_15.content)

				arg_662_1.text_.text = var_665_16

				LuaForUtil.ClearLinePrefixSymbol(arg_662_1.text_)

				local var_665_18 = 15 <= 0 and var_665_13 or var_665_13 * (utf8.len(var_665_16) / 15)

				if (15 <= 0 and var_665_13 or var_665_13 * (utf8.len(var_665_16) / 15)) > 0 and var_665_13 < var_665_18 then
					arg_662_1.talkMaxDuration = var_665_18
					var_665_12 = var_665_12 + 0.3

					if var_665_18 + var_665_12 > arg_662_1.duration_ then
						arg_662_1.duration_ = var_665_18 + var_665_12
					end
				end

				arg_662_1.text_.text = var_665_16
				arg_662_1.typewritter.percent = 0

				arg_662_1.typewritter:SetDirty()
				arg_662_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121160", "story_v_out_122121.awb") ~= 0 then
					local var_665_19 = manager.audio:GetVoiceLength("story_v_out_122121", "122121160", "story_v_out_122121.awb") / 1000

					if var_665_19 + var_665_12 > arg_662_1.duration_ then
						arg_662_1.duration_ = var_665_19 + var_665_12
					end

					if var_665_15.prefab_name ~= "" and arg_662_1.actors_[var_665_15.prefab_name] ~= nil then
						local var_665_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_662_1.actors_[var_665_15.prefab_name].transform, "story_v_out_122121", "122121160", "story_v_out_122121.awb")

						arg_662_1:RecordAudio("122121160", var_665_20)
						arg_662_1:RecordAudio("122121160", var_665_20)
					else
						arg_662_1:AudioAction("play", "voice", "story_v_out_122121", "122121160", "story_v_out_122121.awb")
					end

					arg_662_1:RecordHistoryTalkVoice("story_v_out_122121", "122121160", "story_v_out_122121.awb")
				end

				arg_662_1:RecordContent(arg_662_1.text_.text)
			end

			local var_665_21 = var_665_12 + 0.3
			local var_665_22 = math.max(var_665_13, arg_662_1.talkMaxDuration)

			if var_665_12 + 0.3 <= arg_662_1.time_ and arg_662_1.time_ < var_665_21 + var_665_22 then
				arg_662_1.typewritter.percent = (arg_662_1.time_ - var_665_21) / var_665_22

				arg_662_1.typewritter:SetDirty()
			end

			if arg_662_1.time_ >= var_665_21 + var_665_22 and arg_662_1.time_ < var_665_21 + var_665_22 + arg_665_0 then
				arg_662_1.typewritter.percent = 1

				arg_662_1.typewritter:SetDirty()
				arg_662_1:ShowNextGo(true)
			end
		end

		arg_662_1.nodeConfigList_ = {}

		arg_662_1:InitPlayNodeList()
	end,
	Play122121161 = function(arg_668_0, arg_668_1)
		arg_668_1.time_ = 0
		arg_668_1.frameCnt_ = 0
		arg_668_1.state_ = "playing"
		arg_668_1.curTalkId_ = 122121161
		arg_668_1.duration_ = 2.07

		local var_668_0 = {
			ja = 2.066,
			ko = 1.833,
			zh = 1.833
		}
		local var_668_1 = manager.audio:GetLocalizationFlag()

		if var_668_0[var_668_1] ~= nil then
			arg_668_1.duration_ = var_668_0[var_668_1]
		end

		SetActive(arg_668_1.tipsGo_, false)

		function arg_668_1.onSingleLineFinish_()
			arg_668_1.onSingleLineUpdate_ = nil
			arg_668_1.onSingleLineFinish_ = nil
			arg_668_1.state_ = "waiting"
		end

		function arg_668_1.playNext_(arg_670_0)
			if arg_670_0 == 1 then
				arg_668_0:Play122121162(arg_668_1)
			end
		end

		function arg_668_1.onSingleLineUpdate_(arg_671_0)
			local var_671_0 = 0.225

			if 0 < arg_668_1.time_ and arg_668_1.time_ <= 0 + arg_671_0 then
				arg_668_1.talkMaxDuration = 0
				arg_668_1.dialogCg_.alpha = 1

				arg_668_1.dialog_:SetActive(true)
				SetActive(arg_668_1.leftNameGo_, true)

				arg_668_1.leftNameTxt_.text = arg_668_1:FormatText(StoryNameCfg[449].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_668_1.leftNameTxt_.transform)

				arg_668_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_668_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_668_1:RecordName(arg_668_1.leftNameTxt_.text)
				SetActive(arg_668_1.iconTrs_.gameObject, false)
				arg_668_1.callingController_:SetSelectedState("normal")

				local var_671_1 = arg_668_1:GetWordFromCfg(122121161)
				local var_671_2 = arg_668_1:FormatText(var_671_1.content)

				arg_668_1.text_.text = var_671_2

				LuaForUtil.ClearLinePrefixSymbol(arg_668_1.text_)

				local var_671_4 = 9 <= 0 and var_671_0 or var_671_0 * (utf8.len(var_671_2) / 9)

				if (9 <= 0 and var_671_0 or var_671_0 * (utf8.len(var_671_2) / 9)) > 0 and var_671_0 < var_671_4 then
					arg_668_1.talkMaxDuration = var_671_4

					if var_671_4 + 0 > arg_668_1.duration_ then
						arg_668_1.duration_ = var_671_4 + 0
					end
				end

				arg_668_1.text_.text = var_671_2
				arg_668_1.typewritter.percent = 0

				arg_668_1.typewritter:SetDirty()
				arg_668_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122121", "122121161", "story_v_out_122121.awb") ~= 0 then
					local var_671_5 = manager.audio:GetVoiceLength("story_v_out_122121", "122121161", "story_v_out_122121.awb") / 1000

					if var_671_5 + 0 > arg_668_1.duration_ then
						arg_668_1.duration_ = var_671_5 + 0
					end

					if var_671_1.prefab_name ~= "" and arg_668_1.actors_[var_671_1.prefab_name] ~= nil then
						local var_671_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_668_1.actors_[var_671_1.prefab_name].transform, "story_v_out_122121", "122121161", "story_v_out_122121.awb")

						arg_668_1:RecordAudio("122121161", var_671_6)
						arg_668_1:RecordAudio("122121161", var_671_6)
					else
						arg_668_1:AudioAction("play", "voice", "story_v_out_122121", "122121161", "story_v_out_122121.awb")
					end

					arg_668_1:RecordHistoryTalkVoice("story_v_out_122121", "122121161", "story_v_out_122121.awb")
				end

				arg_668_1:RecordContent(arg_668_1.text_.text)
			end

			local var_671_7 = math.max(var_671_0, arg_668_1.talkMaxDuration)

			if 0 <= arg_668_1.time_ and arg_668_1.time_ < 0 + var_671_7 then
				arg_668_1.typewritter.percent = (arg_668_1.time_ - 0) / var_671_7

				arg_668_1.typewritter:SetDirty()
			end

			if arg_668_1.time_ >= 0 + var_671_7 and arg_668_1.time_ < 0 + var_671_7 + arg_671_0 then
				arg_668_1.typewritter.percent = 1

				arg_668_1.typewritter:SetDirty()
				arg_668_1:ShowNextGo(true)
			end
		end

		arg_668_1.nodeConfigList_ = {}

		arg_668_1:InitPlayNodeList()
	end,
	Play122121162 = function(arg_672_0, arg_672_1)
		arg_672_1.time_ = 0
		arg_672_1.frameCnt_ = 0
		arg_672_1.state_ = "playing"
		arg_672_1.curTalkId_ = 122121162
		arg_672_1.duration_ = 6

		SetActive(arg_672_1.tipsGo_, false)

		function arg_672_1.onSingleLineFinish_()
			arg_672_1.onSingleLineUpdate_ = nil
			arg_672_1.onSingleLineFinish_ = nil
			arg_672_1.state_ = "waiting"
		end

		function arg_672_1.playNext_(arg_674_0)
			if arg_674_0 == 1 then
				arg_672_0:Play122121163(arg_672_1)
			end
		end

		function arg_672_1.onSingleLineUpdate_(arg_675_0)
			if arg_672_1.bgs_.XH0508a == nil then
				local var_675_0 = Object.Instantiate(arg_672_1.paintGo_)

				var_675_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0508a")
				var_675_0.name = "XH0508a"
				var_675_0.transform.parent = arg_672_1.stage_.transform
				var_675_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_672_1.bgs_.XH0508a = var_675_0
			end

			if 0 < arg_672_1.time_ and arg_672_1.time_ <= 0 + arg_675_0 then
				local var_675_1 = arg_672_1.bgs_.XH0508a

				arg_672_1.bgs_.XH0508a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_675_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_675_2 = var_675_1:GetComponent("SpriteRenderer")

				if var_675_2 and var_675_2.sprite then
					local var_675_3 = 2 * (var_675_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_675_1.transform.localScale = Vector3.New(var_675_3 / var_675_2.sprite.bounds.size.y < var_675_3 * manager.ui.mainCameraCom_.aspect / var_675_2.sprite.bounds.size.x and var_675_3 * manager.ui.mainCameraCom_.aspect / var_675_2.sprite.bounds.size.x or var_675_3 / var_675_2.sprite.bounds.size.y, var_675_3 / var_675_2.sprite.bounds.size.y < var_675_3 * manager.ui.mainCameraCom_.aspect / var_675_2.sprite.bounds.size.x and var_675_3 * manager.ui.mainCameraCom_.aspect / var_675_2.sprite.bounds.size.x or var_675_3 / var_675_2.sprite.bounds.size.y, 0)
				end

				for iter_675_0, iter_675_1 in pairs(arg_672_1.bgs_) do
					if iter_675_0 ~= "XH0508a" then
						iter_675_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_675_4 = 0

			if 0 < arg_672_1.time_ and arg_672_1.time_ <= var_675_4 + arg_675_0 then
				arg_672_1.mask_.enabled = true
				arg_672_1.mask_.raycastTarget = true

				arg_672_1:SetGaussion(false)
			end

			local var_675_5 = 1

			if var_675_4 <= arg_672_1.time_ and arg_672_1.time_ < var_675_4 + var_675_5 then
				local var_675_6 = Color.New(1, 1, 1)

				var_675_6.a = Mathf.Lerp(1, 0, (arg_672_1.time_ - var_675_4) / var_675_5)
				arg_672_1.mask_.color = var_675_6
			end

			if arg_672_1.time_ >= var_675_4 + var_675_5 and arg_672_1.time_ < var_675_4 + var_675_5 + arg_675_0 then
				local var_675_7 = Color.New(1, 1, 1)

				arg_672_1.mask_.enabled = false
				var_675_7.a = 0
				arg_672_1.mask_.color = var_675_7
			end

			local var_675_8 = manager.ui.mainCamera.transform

			if 0.366666666666667 < arg_672_1.time_ and arg_672_1.time_ <= 0.366666666666667 + arg_675_0 then
				arg_672_1.var_.shakeOldPos = var_675_8.localPosition
			end

			local var_675_9 = 0.633333333333333

			if 0.366666666666667 <= arg_672_1.time_ and arg_672_1.time_ < 0.366666666666667 + var_675_9 then
				local var_675_10, var_675_11 = math.modf((arg_672_1.time_ - 0.366666666666667) / 0.066)

				var_675_8.localPosition = Vector3.New(var_675_11 * 0.13, var_675_11 * 0.13, var_675_11 * 0.13) + arg_672_1.var_.shakeOldPos
			end

			if arg_672_1.time_ >= 0.366666666666667 + var_675_9 and arg_672_1.time_ < 0.366666666666667 + var_675_9 + arg_675_0 then
				var_675_8.localPosition = arg_672_1.var_.shakeOldPos
			end

			local var_675_12 = manager.ui.mainCamera.transform

			if 1 < arg_672_1.time_ and arg_672_1.time_ <= 1 + arg_675_0 then
				arg_672_1.var_.shakeOldPos = var_675_12.localPosition
			end

			local var_675_13 = 0.15

			if 1 <= arg_672_1.time_ and arg_672_1.time_ < 1 + var_675_13 then
				local var_675_14, var_675_15 = math.modf((arg_672_1.time_ - 1) / 0.066)

				var_675_12.localPosition = Vector3.New(var_675_15 * 0.13, var_675_15 * 0.13, var_675_15 * 0.13) + arg_672_1.var_.shakeOldPos
			end

			if arg_672_1.time_ >= 1 + var_675_13 and arg_672_1.time_ < 1 + var_675_13 + arg_675_0 then
				var_675_12.localPosition = arg_672_1.var_.shakeOldPos
			end

			if 1.35 < arg_672_1.time_ and arg_672_1.time_ <= 1.35 + arg_675_0 then
				arg_672_1:AudioAction("play", "music", "bgm_activity_2_2_story_ver_1", "bgm_activity_2_2_story_ver_1", "bgm_activity_2_2_story_ver_1.awb")

				local var_675_18 = manager.audio:GetAudioName("bgm_activity_2_2_story_ver_1", "bgm_activity_2_2_story_ver_1")

				if "" ~= "" then
					if arg_672_1.bgmTxt_.text ~= var_675_18 and arg_672_1.bgmTxt_.text ~= "" then
						if arg_672_1.bgmTxt2_.text ~= "" then
							arg_672_1.bgmTxt_.text = arg_672_1.bgmTxt2_.text
						end

						arg_672_1.bgmTxt2_.text = var_675_18

						arg_672_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_672_1.bgmTxt_.text = var_675_18
						arg_672_1.bgmTxt2_.text = var_675_18
					end

					if arg_672_1.bgmTimer then
						arg_672_1.bgmTimer:Stop()

						arg_672_1.bgmTimer = nil
					end

					if arg_672_1.settingData.show_music_name == 1 then
						arg_672_1.musicController:SetSelectedState("show")
						arg_672_1.musicAnimator_:Play("open", 0, 0)

						if arg_672_1.settingData.music_time ~= 0 then
							arg_672_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_672_1.settingData.music_time), function()
								if arg_672_1 == nil or isNil(arg_672_1.bgmTxt_) then
									return
								end

								arg_672_1.musicController:SetSelectedState("hide")
								arg_672_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_672_1.frameCnt_ <= 1 then
				arg_672_1.dialog_:SetActive(false)
			end

			local var_675_19 = 1
			local var_675_20 = 0.15

			if 1 < arg_672_1.time_ and arg_672_1.time_ <= var_675_19 + arg_675_0 then
				arg_672_1.talkMaxDuration = 0

				arg_672_1.dialog_:SetActive(true)

				arg_672_1.dialogCg_.alpha = 0

				local var_675_21 = LeanTween.value(arg_672_1.dialog_, 0, 1, 0.3)

				var_675_21:setOnUpdate(LuaHelper.FloatAction(function(arg_677_0)
					arg_672_1.dialogCg_.alpha = arg_677_0
				end))
				var_675_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_672_1.dialog_)
					var_675_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_672_1.duration_ = arg_672_1.duration_ + 0.3

				SetActive(arg_672_1.leftNameGo_, true)

				arg_672_1.leftNameTxt_.text = arg_672_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_672_1.leftNameTxt_.transform)

				arg_672_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_672_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_672_1:RecordName(arg_672_1.leftNameTxt_.text)
				SetActive(arg_672_1.iconTrs_.gameObject, true)
				arg_672_1.iconController_:SetSelectedState("hero")

				arg_672_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_672_1.callingController_:SetSelectedState("normal")

				arg_672_1.keyicon_.color = Color.New(1, 1, 1)
				arg_672_1.icon_.color = Color.New(1, 1, 1)

				local var_675_22 = arg_672_1:FormatText(arg_672_1:GetWordFromCfg(122121162).content)

				arg_672_1.text_.text = var_675_22

				LuaForUtil.ClearLinePrefixSymbol(arg_672_1.text_)

				local var_675_24 = 6 <= 0 and var_675_20 or var_675_20 * (utf8.len(var_675_22) / 6)

				if (6 <= 0 and var_675_20 or var_675_20 * (utf8.len(var_675_22) / 6)) > 0 and var_675_20 < var_675_24 then
					arg_672_1.talkMaxDuration = var_675_24
					var_675_19 = var_675_19 + 0.3

					if var_675_24 + var_675_19 > arg_672_1.duration_ then
						arg_672_1.duration_ = var_675_24 + var_675_19
					end
				end

				arg_672_1.text_.text = var_675_22
				arg_672_1.typewritter.percent = 0

				arg_672_1.typewritter:SetDirty()
				arg_672_1:ShowNextGo(false)
				arg_672_1:RecordContent(arg_672_1.text_.text)
			end

			local var_675_25 = var_675_19 + 0.3
			local var_675_26 = math.max(var_675_20, arg_672_1.talkMaxDuration)

			if var_675_19 + 0.3 <= arg_672_1.time_ and arg_672_1.time_ < var_675_25 + var_675_26 then
				arg_672_1.typewritter.percent = (arg_672_1.time_ - var_675_25) / var_675_26

				arg_672_1.typewritter:SetDirty()
			end

			if arg_672_1.time_ >= var_675_25 + var_675_26 and arg_672_1.time_ < var_675_25 + var_675_26 + arg_675_0 then
				arg_672_1.typewritter.percent = 1

				arg_672_1.typewritter:SetDirty()
				arg_672_1:ShowNextGo(true)
			end
		end

		arg_672_1.nodeConfigList_ = {}

		arg_672_1:InitPlayNodeList()
	end,
	Play122121163 = function(arg_679_0, arg_679_1)
		arg_679_1.time_ = 0
		arg_679_1.frameCnt_ = 0
		arg_679_1.state_ = "playing"
		arg_679_1.curTalkId_ = 122121163
		arg_679_1.duration_ = 5

		SetActive(arg_679_1.tipsGo_, false)

		function arg_679_1.onSingleLineFinish_()
			arg_679_1.onSingleLineUpdate_ = nil
			arg_679_1.onSingleLineFinish_ = nil
			arg_679_1.state_ = "waiting"
		end

		function arg_679_1.playNext_(arg_681_0)
			if arg_681_0 == 1 then
				arg_679_0:Play122121164(arg_679_1)
			end
		end

		function arg_679_1.onSingleLineUpdate_(arg_682_0)
			local var_682_0 = 1.55

			if 0 < arg_679_1.time_ and arg_679_1.time_ <= 0 + arg_682_0 then
				arg_679_1.talkMaxDuration = 0
				arg_679_1.dialogCg_.alpha = 1

				arg_679_1.dialog_:SetActive(true)
				SetActive(arg_679_1.leftNameGo_, false)

				arg_679_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_679_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_679_1:RecordName(arg_679_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_679_1.iconTrs_.gameObject, false)
				arg_679_1.callingController_:SetSelectedState("normal")

				local var_682_1 = arg_679_1:FormatText(arg_679_1:GetWordFromCfg(122121163).content)

				arg_679_1.text_.text = var_682_1

				LuaForUtil.ClearLinePrefixSymbol(arg_679_1.text_)

				local var_682_3 = 62 <= 0 and var_682_0 or var_682_0 * (utf8.len(var_682_1) / 62)

				if (62 <= 0 and var_682_0 or var_682_0 * (utf8.len(var_682_1) / 62)) > 0 and var_682_0 < var_682_3 then
					arg_679_1.talkMaxDuration = var_682_3

					if var_682_3 + 0 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_3 + 0
					end
				end

				arg_679_1.text_.text = var_682_1
				arg_679_1.typewritter.percent = 0

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(false)
				arg_679_1:RecordContent(arg_679_1.text_.text)
			end

			local var_682_4 = math.max(var_682_0, arg_679_1.talkMaxDuration)

			if 0 <= arg_679_1.time_ and arg_679_1.time_ < 0 + var_682_4 then
				arg_679_1.typewritter.percent = (arg_679_1.time_ - 0) / var_682_4

				arg_679_1.typewritter:SetDirty()
			end

			if arg_679_1.time_ >= 0 + var_682_4 and arg_679_1.time_ < 0 + var_682_4 + arg_682_0 then
				arg_679_1.typewritter.percent = 1

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(true)
			end
		end

		arg_679_1.nodeConfigList_ = {}

		arg_679_1:InitPlayNodeList()
	end,
	Play122121164 = function(arg_683_0, arg_683_1)
		arg_683_1.time_ = 0
		arg_683_1.frameCnt_ = 0
		arg_683_1.state_ = "playing"
		arg_683_1.curTalkId_ = 122121164
		arg_683_1.duration_ = 9

		SetActive(arg_683_1.tipsGo_, false)

		function arg_683_1.onSingleLineFinish_()
			arg_683_1.onSingleLineUpdate_ = nil
			arg_683_1.onSingleLineFinish_ = nil
			arg_683_1.state_ = "waiting"
		end

		function arg_683_1.playNext_(arg_685_0)
			if arg_685_0 == 1 then
				arg_683_0:Play122121165(arg_683_1)
			end
		end

		function arg_683_1.onSingleLineUpdate_(arg_686_0)
			if arg_683_1.bgs_.I05f == nil then
				local var_686_0 = Object.Instantiate(arg_683_1.paintGo_)

				var_686_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I05f")
				var_686_0.name = "I05f"
				var_686_0.transform.parent = arg_683_1.stage_.transform
				var_686_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_683_1.bgs_.I05f = var_686_0
			end

			if 2 < arg_683_1.time_ and arg_683_1.time_ <= 2 + arg_686_0 then
				local var_686_1 = arg_683_1.bgs_.I05f

				arg_683_1.bgs_.I05f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_686_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_686_2 = var_686_1:GetComponent("SpriteRenderer")

				if var_686_2 and var_686_2.sprite then
					local var_686_3 = 2 * (var_686_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_686_1.transform.localScale = Vector3.New(var_686_3 / var_686_2.sprite.bounds.size.y < var_686_3 * manager.ui.mainCameraCom_.aspect / var_686_2.sprite.bounds.size.x and var_686_3 * manager.ui.mainCameraCom_.aspect / var_686_2.sprite.bounds.size.x or var_686_3 / var_686_2.sprite.bounds.size.y, var_686_3 / var_686_2.sprite.bounds.size.y < var_686_3 * manager.ui.mainCameraCom_.aspect / var_686_2.sprite.bounds.size.x and var_686_3 * manager.ui.mainCameraCom_.aspect / var_686_2.sprite.bounds.size.x or var_686_3 / var_686_2.sprite.bounds.size.y, 0)
				end

				for iter_686_0, iter_686_1 in pairs(arg_683_1.bgs_) do
					if iter_686_0 ~= "I05f" then
						iter_686_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_686_4 = 0

			if 0 < arg_683_1.time_ and arg_683_1.time_ <= var_686_4 + arg_686_0 then
				arg_683_1.mask_.enabled = true
				arg_683_1.mask_.raycastTarget = true

				arg_683_1:SetGaussion(false)
			end

			local var_686_5 = 2

			if var_686_4 <= arg_683_1.time_ and arg_683_1.time_ < var_686_4 + var_686_5 then
				local var_686_6 = Color.New(1, 1, 1)

				var_686_6.a = Mathf.Lerp(0, 1, (arg_683_1.time_ - var_686_4) / var_686_5)
				arg_683_1.mask_.color = var_686_6
			end

			if arg_683_1.time_ >= var_686_4 + var_686_5 and arg_683_1.time_ < var_686_4 + var_686_5 + arg_686_0 then
				local var_686_7 = Color.New(1, 1, 1)

				var_686_7.a = 1
				arg_683_1.mask_.color = var_686_7
			end

			local var_686_8 = 2

			if 2 < arg_683_1.time_ and arg_683_1.time_ <= var_686_8 + arg_686_0 then
				arg_683_1.mask_.enabled = true
				arg_683_1.mask_.raycastTarget = true

				arg_683_1:SetGaussion(false)
			end

			local var_686_9 = 2

			if var_686_8 <= arg_683_1.time_ and arg_683_1.time_ < var_686_8 + var_686_9 then
				local var_686_10 = Color.New(1, 1, 1)

				var_686_10.a = Mathf.Lerp(1, 0, (arg_683_1.time_ - var_686_8) / var_686_9)
				arg_683_1.mask_.color = var_686_10
			end

			if arg_683_1.time_ >= var_686_8 + var_686_9 and arg_683_1.time_ < var_686_8 + var_686_9 + arg_686_0 then
				local var_686_11 = Color.New(1, 1, 1)

				arg_683_1.mask_.enabled = false
				var_686_11.a = 0
				arg_683_1.mask_.color = var_686_11
			end

			if 0 < arg_683_1.time_ and arg_683_1.time_ <= 0 + arg_686_0 then
				arg_683_1:AudioAction("stop", "effect", "se_story_side_1028", "se_story_1028_smallwaveloop", "")
			end

			if arg_683_1.frameCnt_ <= 1 then
				arg_683_1.dialog_:SetActive(false)
			end

			local var_686_13 = 4
			local var_686_14 = 1.15

			if 4 < arg_683_1.time_ and arg_683_1.time_ <= var_686_13 + arg_686_0 then
				arg_683_1.talkMaxDuration = 0

				arg_683_1.dialog_:SetActive(true)

				arg_683_1.dialogCg_.alpha = 0

				local var_686_15 = LeanTween.value(arg_683_1.dialog_, 0, 1, 0.3)

				var_686_15:setOnUpdate(LuaHelper.FloatAction(function(arg_687_0)
					arg_683_1.dialogCg_.alpha = arg_687_0
				end))
				var_686_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_683_1.dialog_)
					var_686_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_683_1.duration_ = arg_683_1.duration_ + 0.3

				SetActive(arg_683_1.leftNameGo_, false)

				arg_683_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_683_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_683_1:RecordName(arg_683_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_683_1.iconTrs_.gameObject, false)
				arg_683_1.callingController_:SetSelectedState("normal")

				local var_686_16 = arg_683_1:FormatText(arg_683_1:GetWordFromCfg(122121164).content)

				arg_683_1.text_.text = var_686_16

				LuaForUtil.ClearLinePrefixSymbol(arg_683_1.text_)

				local var_686_18 = 46 <= 0 and var_686_14 or var_686_14 * (utf8.len(var_686_16) / 46)

				if (46 <= 0 and var_686_14 or var_686_14 * (utf8.len(var_686_16) / 46)) > 0 and var_686_14 < var_686_18 then
					arg_683_1.talkMaxDuration = var_686_18
					var_686_13 = var_686_13 + 0.3

					if var_686_18 + var_686_13 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_18 + var_686_13
					end
				end

				arg_683_1.text_.text = var_686_16
				arg_683_1.typewritter.percent = 0

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(false)
				arg_683_1:RecordContent(arg_683_1.text_.text)
			end

			local var_686_19 = var_686_13 + 0.3
			local var_686_20 = math.max(var_686_14, arg_683_1.talkMaxDuration)

			if var_686_13 + 0.3 <= arg_683_1.time_ and arg_683_1.time_ < var_686_19 + var_686_20 then
				arg_683_1.typewritter.percent = (arg_683_1.time_ - var_686_19) / var_686_20

				arg_683_1.typewritter:SetDirty()
			end

			if arg_683_1.time_ >= var_686_19 + var_686_20 and arg_683_1.time_ < var_686_19 + var_686_20 + arg_686_0 then
				arg_683_1.typewritter.percent = 1

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(true)
			end
		end

		arg_683_1.nodeConfigList_ = {}

		arg_683_1:InitPlayNodeList()
	end,
	Play122121165 = function(arg_689_0, arg_689_1)
		arg_689_1.time_ = 0
		arg_689_1.frameCnt_ = 0
		arg_689_1.state_ = "playing"
		arg_689_1.curTalkId_ = 122121165
		arg_689_1.duration_ = 5

		SetActive(arg_689_1.tipsGo_, false)

		function arg_689_1.onSingleLineFinish_()
			arg_689_1.onSingleLineUpdate_ = nil
			arg_689_1.onSingleLineFinish_ = nil
			arg_689_1.state_ = "waiting"
		end

		function arg_689_1.playNext_(arg_691_0)
			if arg_691_0 == 1 then
				arg_689_0:Play122121166(arg_689_1)
			end
		end

		function arg_689_1.onSingleLineUpdate_(arg_692_0)
			if 0 < arg_689_1.time_ and arg_689_1.time_ <= 0 + arg_692_0 then
				arg_689_1:AudioAction("play", "effect", "se_story_122_02", "se_story_122_02_hit", "")
			end

			local var_692_1 = 0
			local var_692_2 = 1.125

			if 0 < arg_689_1.time_ and arg_689_1.time_ <= var_692_1 + arg_692_0 then
				arg_689_1.talkMaxDuration = 0
				arg_689_1.dialogCg_.alpha = 1

				arg_689_1.dialog_:SetActive(true)
				SetActive(arg_689_1.leftNameGo_, false)

				arg_689_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_689_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_689_1:RecordName(arg_689_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_689_1.iconTrs_.gameObject, false)
				arg_689_1.callingController_:SetSelectedState("normal")

				local var_692_3 = arg_689_1:FormatText(arg_689_1:GetWordFromCfg(122121165).content)

				arg_689_1.text_.text = var_692_3

				LuaForUtil.ClearLinePrefixSymbol(arg_689_1.text_)

				local var_692_5 = 45 <= 0 and var_692_2 or var_692_2 * (utf8.len(var_692_3) / 45)

				if (45 <= 0 and var_692_2 or var_692_2 * (utf8.len(var_692_3) / 45)) > 0 and var_692_2 < var_692_5 then
					arg_689_1.talkMaxDuration = var_692_5

					if var_692_5 + var_692_1 > arg_689_1.duration_ then
						arg_689_1.duration_ = var_692_5 + var_692_1
					end
				end

				arg_689_1.text_.text = var_692_3
				arg_689_1.typewritter.percent = 0

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(false)
				arg_689_1:RecordContent(arg_689_1.text_.text)
			end

			local var_692_6 = math.max(var_692_2, arg_689_1.talkMaxDuration)

			if var_692_1 <= arg_689_1.time_ and arg_689_1.time_ < var_692_1 + var_692_6 then
				arg_689_1.typewritter.percent = (arg_689_1.time_ - var_692_1) / var_692_6

				arg_689_1.typewritter:SetDirty()
			end

			if arg_689_1.time_ >= var_692_1 + var_692_6 and arg_689_1.time_ < var_692_1 + var_692_6 + arg_692_0 then
				arg_689_1.typewritter.percent = 1

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(true)
			end
		end

		arg_689_1.nodeConfigList_ = {}

		arg_689_1:InitPlayNodeList()
	end,
	Play122121166 = function(arg_693_0, arg_693_1)
		arg_693_1.time_ = 0
		arg_693_1.frameCnt_ = 0
		arg_693_1.state_ = "playing"
		arg_693_1.curTalkId_ = 122121166
		arg_693_1.duration_ = 5

		SetActive(arg_693_1.tipsGo_, false)

		function arg_693_1.onSingleLineFinish_()
			arg_693_1.onSingleLineUpdate_ = nil
			arg_693_1.onSingleLineFinish_ = nil
			arg_693_1.state_ = "waiting"
		end

		function arg_693_1.playNext_(arg_695_0)
			if arg_695_0 == 1 then
				arg_693_0:Play122121167(arg_693_1)
			end
		end

		function arg_693_1.onSingleLineUpdate_(arg_696_0)
			local var_696_0 = 1.35

			if 0 < arg_693_1.time_ and arg_693_1.time_ <= 0 + arg_696_0 then
				arg_693_1.talkMaxDuration = 0
				arg_693_1.dialogCg_.alpha = 1

				arg_693_1.dialog_:SetActive(true)
				SetActive(arg_693_1.leftNameGo_, false)

				arg_693_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_693_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_693_1:RecordName(arg_693_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_693_1.iconTrs_.gameObject, false)
				arg_693_1.callingController_:SetSelectedState("normal")

				local var_696_1 = arg_693_1:FormatText(arg_693_1:GetWordFromCfg(122121166).content)

				arg_693_1.text_.text = var_696_1

				LuaForUtil.ClearLinePrefixSymbol(arg_693_1.text_)

				local var_696_3 = 54 <= 0 and var_696_0 or var_696_0 * (utf8.len(var_696_1) / 54)

				if (54 <= 0 and var_696_0 or var_696_0 * (utf8.len(var_696_1) / 54)) > 0 and var_696_0 < var_696_3 then
					arg_693_1.talkMaxDuration = var_696_3

					if var_696_3 + 0 > arg_693_1.duration_ then
						arg_693_1.duration_ = var_696_3 + 0
					end
				end

				arg_693_1.text_.text = var_696_1
				arg_693_1.typewritter.percent = 0

				arg_693_1.typewritter:SetDirty()
				arg_693_1:ShowNextGo(false)
				arg_693_1:RecordContent(arg_693_1.text_.text)
			end

			local var_696_4 = math.max(var_696_0, arg_693_1.talkMaxDuration)

			if 0 <= arg_693_1.time_ and arg_693_1.time_ < 0 + var_696_4 then
				arg_693_1.typewritter.percent = (arg_693_1.time_ - 0) / var_696_4

				arg_693_1.typewritter:SetDirty()
			end

			if arg_693_1.time_ >= 0 + var_696_4 and arg_693_1.time_ < 0 + var_696_4 + arg_696_0 then
				arg_693_1.typewritter.percent = 1

				arg_693_1.typewritter:SetDirty()
				arg_693_1:ShowNextGo(true)
			end
		end

		arg_693_1.nodeConfigList_ = {}

		arg_693_1:InitPlayNodeList()
	end,
	Play122121167 = function(arg_697_0, arg_697_1)
		arg_697_1.time_ = 0
		arg_697_1.frameCnt_ = 0
		arg_697_1.state_ = "playing"
		arg_697_1.curTalkId_ = 122121167
		arg_697_1.duration_ = 5

		SetActive(arg_697_1.tipsGo_, false)

		function arg_697_1.onSingleLineFinish_()
			arg_697_1.onSingleLineUpdate_ = nil
			arg_697_1.onSingleLineFinish_ = nil
			arg_697_1.state_ = "waiting"
		end

		function arg_697_1.playNext_(arg_699_0)
			if arg_699_0 == 1 then
				arg_697_0:Play122121168(arg_697_1)
			end
		end

		function arg_697_1.onSingleLineUpdate_(arg_700_0)
			local var_700_0 = 0.725

			if 0 < arg_697_1.time_ and arg_697_1.time_ <= 0 + arg_700_0 then
				arg_697_1.talkMaxDuration = 0
				arg_697_1.dialogCg_.alpha = 1

				arg_697_1.dialog_:SetActive(true)
				SetActive(arg_697_1.leftNameGo_, true)

				arg_697_1.leftNameTxt_.text = arg_697_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_697_1.leftNameTxt_.transform)

				arg_697_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_697_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_697_1:RecordName(arg_697_1.leftNameTxt_.text)
				SetActive(arg_697_1.iconTrs_.gameObject, true)
				arg_697_1.iconController_:SetSelectedState("hero")

				arg_697_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_697_1.callingController_:SetSelectedState("normal")

				arg_697_1.keyicon_.color = Color.New(1, 1, 1)
				arg_697_1.icon_.color = Color.New(1, 1, 1)

				local var_700_1 = arg_697_1:FormatText(arg_697_1:GetWordFromCfg(122121167).content)

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
	Play122121168 = function(arg_701_0, arg_701_1)
		arg_701_1.time_ = 0
		arg_701_1.frameCnt_ = 0
		arg_701_1.state_ = "playing"
		arg_701_1.curTalkId_ = 122121168
		arg_701_1.duration_ = 5

		SetActive(arg_701_1.tipsGo_, false)

		function arg_701_1.onSingleLineFinish_()
			arg_701_1.onSingleLineUpdate_ = nil
			arg_701_1.onSingleLineFinish_ = nil
			arg_701_1.state_ = "waiting"
		end

		function arg_701_1.playNext_(arg_703_0)
			if arg_703_0 == 1 then
				arg_701_0:Play122121169(arg_701_1)
			end
		end

		function arg_701_1.onSingleLineUpdate_(arg_704_0)
			local var_704_0 = 0.65

			if 0 < arg_701_1.time_ and arg_701_1.time_ <= 0 + arg_704_0 then
				arg_701_1.talkMaxDuration = 0
				arg_701_1.dialogCg_.alpha = 1

				arg_701_1.dialog_:SetActive(true)
				SetActive(arg_701_1.leftNameGo_, true)

				arg_701_1.leftNameTxt_.text = arg_701_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_701_1.leftNameTxt_.transform)

				arg_701_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_701_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_701_1:RecordName(arg_701_1.leftNameTxt_.text)
				SetActive(arg_701_1.iconTrs_.gameObject, true)
				arg_701_1.iconController_:SetSelectedState("hero")

				arg_701_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_701_1.callingController_:SetSelectedState("normal")

				arg_701_1.keyicon_.color = Color.New(1, 1, 1)
				arg_701_1.icon_.color = Color.New(1, 1, 1)

				local var_704_1 = arg_701_1:FormatText(arg_701_1:GetWordFromCfg(122121168).content)

				arg_701_1.text_.text = var_704_1

				LuaForUtil.ClearLinePrefixSymbol(arg_701_1.text_)

				local var_704_3 = 26 <= 0 and var_704_0 or var_704_0 * (utf8.len(var_704_1) / 26)

				if (26 <= 0 and var_704_0 or var_704_0 * (utf8.len(var_704_1) / 26)) > 0 and var_704_0 < var_704_3 then
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
	Play122121169 = function(arg_705_0, arg_705_1)
		arg_705_1.time_ = 0
		arg_705_1.frameCnt_ = 0
		arg_705_1.state_ = "playing"
		arg_705_1.curTalkId_ = 122121169
		arg_705_1.duration_ = 5

		SetActive(arg_705_1.tipsGo_, false)

		function arg_705_1.onSingleLineFinish_()
			arg_705_1.onSingleLineUpdate_ = nil
			arg_705_1.onSingleLineFinish_ = nil
			arg_705_1.state_ = "waiting"
		end

		function arg_705_1.playNext_(arg_707_0)
			if arg_707_0 == 1 then
				arg_705_0:Play122121170(arg_705_1)
			end
		end

		function arg_705_1.onSingleLineUpdate_(arg_708_0)
			local var_708_0 = 1.125

			if 0 < arg_705_1.time_ and arg_705_1.time_ <= 0 + arg_708_0 then
				arg_705_1.talkMaxDuration = 0
				arg_705_1.dialogCg_.alpha = 1

				arg_705_1.dialog_:SetActive(true)
				SetActive(arg_705_1.leftNameGo_, false)

				arg_705_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_705_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_705_1:RecordName(arg_705_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_705_1.iconTrs_.gameObject, false)
				arg_705_1.callingController_:SetSelectedState("normal")

				local var_708_1 = arg_705_1:FormatText(arg_705_1:GetWordFromCfg(122121169).content)

				arg_705_1.text_.text = var_708_1

				LuaForUtil.ClearLinePrefixSymbol(arg_705_1.text_)

				local var_708_3 = 44 <= 0 and var_708_0 or var_708_0 * (utf8.len(var_708_1) / 44)

				if (44 <= 0 and var_708_0 or var_708_0 * (utf8.len(var_708_1) / 44)) > 0 and var_708_0 < var_708_3 then
					arg_705_1.talkMaxDuration = var_708_3

					if var_708_3 + 0 > arg_705_1.duration_ then
						arg_705_1.duration_ = var_708_3 + 0
					end
				end

				arg_705_1.text_.text = var_708_1
				arg_705_1.typewritter.percent = 0

				arg_705_1.typewritter:SetDirty()
				arg_705_1:ShowNextGo(false)
				arg_705_1:RecordContent(arg_705_1.text_.text)
			end

			local var_708_4 = math.max(var_708_0, arg_705_1.talkMaxDuration)

			if 0 <= arg_705_1.time_ and arg_705_1.time_ < 0 + var_708_4 then
				arg_705_1.typewritter.percent = (arg_705_1.time_ - 0) / var_708_4

				arg_705_1.typewritter:SetDirty()
			end

			if arg_705_1.time_ >= 0 + var_708_4 and arg_705_1.time_ < 0 + var_708_4 + arg_708_0 then
				arg_705_1.typewritter.percent = 1

				arg_705_1.typewritter:SetDirty()
				arg_705_1:ShowNextGo(true)
			end
		end

		arg_705_1.nodeConfigList_ = {}

		arg_705_1:InitPlayNodeList()
	end,
	Play122121170 = function(arg_709_0, arg_709_1)
		arg_709_1.time_ = 0
		arg_709_1.frameCnt_ = 0
		arg_709_1.state_ = "playing"
		arg_709_1.curTalkId_ = 122121170
		arg_709_1.duration_ = 5

		SetActive(arg_709_1.tipsGo_, false)

		function arg_709_1.onSingleLineFinish_()
			arg_709_1.onSingleLineUpdate_ = nil
			arg_709_1.onSingleLineFinish_ = nil
			arg_709_1.state_ = "waiting"
		end

		function arg_709_1.playNext_(arg_711_0)
			if arg_711_0 == 1 then
				arg_709_0:Play122121171(arg_709_1)
			end
		end

		function arg_709_1.onSingleLineUpdate_(arg_712_0)
			local var_712_0 = 1.35

			if 0 < arg_709_1.time_ and arg_709_1.time_ <= 0 + arg_712_0 then
				arg_709_1.talkMaxDuration = 0
				arg_709_1.dialogCg_.alpha = 1

				arg_709_1.dialog_:SetActive(true)
				SetActive(arg_709_1.leftNameGo_, false)

				arg_709_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_709_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_709_1:RecordName(arg_709_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_709_1.iconTrs_.gameObject, false)
				arg_709_1.callingController_:SetSelectedState("normal")

				local var_712_1 = arg_709_1:FormatText(arg_709_1:GetWordFromCfg(122121170).content)

				arg_709_1.text_.text = var_712_1

				LuaForUtil.ClearLinePrefixSymbol(arg_709_1.text_)

				local var_712_3 = 54 <= 0 and var_712_0 or var_712_0 * (utf8.len(var_712_1) / 54)

				if (54 <= 0 and var_712_0 or var_712_0 * (utf8.len(var_712_1) / 54)) > 0 and var_712_0 < var_712_3 then
					arg_709_1.talkMaxDuration = var_712_3

					if var_712_3 + 0 > arg_709_1.duration_ then
						arg_709_1.duration_ = var_712_3 + 0
					end
				end

				arg_709_1.text_.text = var_712_1
				arg_709_1.typewritter.percent = 0

				arg_709_1.typewritter:SetDirty()
				arg_709_1:ShowNextGo(false)
				arg_709_1:RecordContent(arg_709_1.text_.text)
			end

			local var_712_4 = math.max(var_712_0, arg_709_1.talkMaxDuration)

			if 0 <= arg_709_1.time_ and arg_709_1.time_ < 0 + var_712_4 then
				arg_709_1.typewritter.percent = (arg_709_1.time_ - 0) / var_712_4

				arg_709_1.typewritter:SetDirty()
			end

			if arg_709_1.time_ >= 0 + var_712_4 and arg_709_1.time_ < 0 + var_712_4 + arg_712_0 then
				arg_709_1.typewritter.percent = 1

				arg_709_1.typewritter:SetDirty()
				arg_709_1:ShowNextGo(true)
			end
		end

		arg_709_1.nodeConfigList_ = {}

		arg_709_1:InitPlayNodeList()
	end,
	Play122121171 = function(arg_713_0, arg_713_1)
		arg_713_1.time_ = 0
		arg_713_1.frameCnt_ = 0
		arg_713_1.state_ = "playing"
		arg_713_1.curTalkId_ = 122121171
		arg_713_1.duration_ = 5

		SetActive(arg_713_1.tipsGo_, false)

		function arg_713_1.onSingleLineFinish_()
			arg_713_1.onSingleLineUpdate_ = nil
			arg_713_1.onSingleLineFinish_ = nil
			arg_713_1.state_ = "waiting"
		end

		function arg_713_1.playNext_(arg_715_0)
			if arg_715_0 == 1 then
				arg_713_0:Play122121172(arg_713_1)
			end
		end

		function arg_713_1.onSingleLineUpdate_(arg_716_0)
			local var_716_0 = 0.45

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

				local var_716_1 = arg_713_1:FormatText(arg_713_1:GetWordFromCfg(122121171).content)

				arg_713_1.text_.text = var_716_1

				LuaForUtil.ClearLinePrefixSymbol(arg_713_1.text_)

				local var_716_3 = 18 <= 0 and var_716_0 or var_716_0 * (utf8.len(var_716_1) / 18)

				if (18 <= 0 and var_716_0 or var_716_0 * (utf8.len(var_716_1) / 18)) > 0 and var_716_0 < var_716_3 then
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
	Play122121172 = function(arg_717_0, arg_717_1)
		arg_717_1.time_ = 0
		arg_717_1.frameCnt_ = 0
		arg_717_1.state_ = "playing"
		arg_717_1.curTalkId_ = 122121172
		arg_717_1.duration_ = 5

		SetActive(arg_717_1.tipsGo_, false)

		function arg_717_1.onSingleLineFinish_()
			arg_717_1.onSingleLineUpdate_ = nil
			arg_717_1.onSingleLineFinish_ = nil
			arg_717_1.state_ = "waiting"
			arg_717_1.auto_ = false
		end

		function arg_717_1.playNext_(arg_719_0)
			arg_717_1.onStoryFinished_()
		end

		function arg_717_1.onSingleLineUpdate_(arg_720_0)
			local var_720_0 = 0.4

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

				local var_720_1 = arg_717_1:FormatText(arg_717_1:GetWordFromCfg(122121172).content)

				arg_717_1.text_.text = var_720_1

				LuaForUtil.ClearLinePrefixSymbol(arg_717_1.text_)

				local var_720_3 = 16 <= 0 and var_720_0 or var_720_0 * (utf8.len(var_720_1) / 16)

				if (16 <= 0 and var_720_0 or var_720_0 * (utf8.len(var_720_1) / 16)) > 0 and var_720_0 < var_720_3 then
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
	assets = {
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST17",
		"TextureConfig/Background/ST15a",
		"TextureConfig/Background/XH0504",
		"TextureConfig/Background/XH0508a",
		"TextureConfig/Background/I05f"
	},
	voices = {
		"story_v_out_122121.awb"
	}
}
