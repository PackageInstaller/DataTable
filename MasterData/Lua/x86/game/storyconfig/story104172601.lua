return {
	Play417261001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417261001
		arg_1_1.duration_ = 12.4

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play417261002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 7.400000000001 < arg_1_1.time_ and arg_1_1.time_ <= 7.400000000001 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= 7.400000000001 + 0.7 and arg_1_1.time_ < 7.400000000001 + 0.7 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_0 = "I16f"

			if arg_1_1.bgs_.I16f == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_2 = arg_1_1.bgs_.I16f

				arg_1_1.bgs_.I16f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_3 = var_4_2:GetComponent("SpriteRenderer")

				if var_4_3 and var_4_3.sprite then
					local var_4_4 = 2 * (var_4_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_2.transform.localScale = Vector3.New(var_4_4 / var_4_3.sprite.bounds.size.y < var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x and var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x or var_4_4 / var_4_3.sprite.bounds.size.y, var_4_4 / var_4_3.sprite.bounds.size.y < var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x and var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x or var_4_4 / var_4_3.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I16f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B13g")

				arg_1_1.timestampColorController_:SetSelectedState("cold")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				arg_1_1.text_timeText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501075).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				arg_1_1.text_siteText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501076).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_siteText_)
			end

			if arg_1_1.time_ >= var_4_5 + 5 and arg_1_1.time_ < var_4_5 + 5 + arg_4_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_1_1.timestampAni_, "out", function()
					arg_1_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_4_6 = 5

			if 5 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_7 = 1.2

			if var_4_6 <= arg_1_1.time_ and arg_1_1.time_ < var_4_6 + var_4_7 then
				local var_4_8 = Color.New(0, 0, 0)

				var_4_8.a = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_6) / var_4_7)
				arg_1_1.mask_.color = var_4_8
			end

			if arg_1_1.time_ >= var_4_6 + var_4_7 and arg_1_1.time_ < var_4_6 + var_4_7 + arg_4_0 then
				local var_4_9 = Color.New(0, 0, 0)

				var_4_9.a = 1
				arg_1_1.mask_.color = var_4_9
			end

			local var_4_10 = 6.2

			if 6.2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_11 = 1.2

			if var_4_10 <= arg_1_1.time_ and arg_1_1.time_ < var_4_10 + var_4_11 then
				local var_4_12 = Color.New(0, 0, 0)

				var_4_12.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_10) / var_4_11)
				arg_1_1.mask_.color = var_4_12
			end

			if arg_1_1.time_ >= var_4_10 + var_4_11 and arg_1_1.time_ < var_4_10 + var_4_11 + arg_4_0 then
				local var_4_13 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_13.a = 0
				arg_1_1.mask_.color = var_4_13
			end

			local var_4_14 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_15 = 1

			if var_4_14 <= arg_1_1.time_ and arg_1_1.time_ < var_4_14 + var_4_15 then
				local var_4_16 = Color.New(0, 0, 0)

				var_4_16.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_14) / var_4_15)
				arg_1_1.mask_.color = var_4_16
			end

			if arg_1_1.time_ >= var_4_14 + var_4_15 and arg_1_1.time_ < var_4_14 + var_4_15 + arg_4_0 then
				local var_4_17 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_17.a = 0
				arg_1_1.mask_.color = var_4_17
			end

			local var_4_18 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_18 + 6.2 and arg_1_1.time_ < var_4_18 + 6.2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_21 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_21

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_21
						arg_1_1.bgmTxt2_.text = var_4_21
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

			if 5.46666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 5.46666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base.awb")

				local var_4_24 = manager.audio:GetAudioName("bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_24 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_24

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_24
						arg_1_1.bgmTxt2_.text = var_4_24
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

			local var_4_25 = 7.4
			local var_4_26 = 1.6

			if 7.4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_27 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_27:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_28 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(417261001).content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 64 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_28) / 64)

				if (64 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_28) / 64)) > 0 and var_4_26 < var_4_30 then
					arg_1_1.talkMaxDuration = var_4_30
					var_4_25 = var_4_25 + 0.3

					if var_4_30 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_25
					end
				end

				arg_1_1.text_.text = var_4_28
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_31 = var_4_25 + 0.3
			local var_4_32 = math.max(var_4_26, arg_1_1.talkMaxDuration)

			if var_4_25 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_31 + var_4_32 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_31) / var_4_32

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_31 + var_4_32 and arg_1_1.time_ < var_4_31 + var_4_32 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play417261002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 417261002
		arg_10_1.duration_ = 5

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play417261003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			if 0.02 < arg_10_1.time_ and arg_10_1.time_ <= 0.02 + arg_13_0 then
				arg_10_1:AudioAction("play", "effect", "se_story_side_1148", "se_story_1148_applause", "")
			end

			local var_13_1 = 0
			local var_13_2 = 1.85

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_1 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, false)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_3 = arg_10_1:FormatText(arg_10_1:GetWordFromCfg(417261002).content)

				arg_10_1.text_.text = var_13_3

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_5 = 74 <= 0 and var_13_2 or var_13_2 * (utf8.len(var_13_3) / 74)

				if (74 <= 0 and var_13_2 or var_13_2 * (utf8.len(var_13_3) / 74)) > 0 and var_13_2 < var_13_5 then
					arg_10_1.talkMaxDuration = var_13_5

					if var_13_5 + var_13_1 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_5 + var_13_1
					end
				end

				arg_10_1.text_.text = var_13_3
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)
				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_6 = math.max(var_13_2, arg_10_1.talkMaxDuration)

			if var_13_1 <= arg_10_1.time_ and arg_10_1.time_ < var_13_1 + var_13_6 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_1) / var_13_6

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_1 + var_13_6 and arg_10_1.time_ < var_13_1 + var_13_6 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play417261003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 417261003
		arg_14_1.duration_ = 5

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play417261004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 1.6

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, false)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_1 = arg_14_1:FormatText(arg_14_1:GetWordFromCfg(417261003).content)

				arg_14_1.text_.text = var_17_1

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_3 = 64 <= 0 and var_17_0 or var_17_0 * (utf8.len(var_17_1) / 64)

				if (64 <= 0 and var_17_0 or var_17_0 * (utf8.len(var_17_1) / 64)) > 0 and var_17_0 < var_17_3 then
					arg_14_1.talkMaxDuration = var_17_3

					if var_17_3 + 0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_3 + 0
					end
				end

				arg_14_1.text_.text = var_17_1
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)
				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_4 = math.max(var_17_0, arg_14_1.talkMaxDuration)

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_4 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - 0) / var_17_4

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= 0 + var_17_4 and arg_14_1.time_ < 0 + var_17_4 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play417261004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 417261004
		arg_18_1.duration_ = 4.33

		local var_18_0 = {
			zh = 3.2,
			ja = 4.333
		}
		local var_18_1 = manager.audio:GetLocalizationFlag()

		if var_18_0[var_18_1] ~= nil then
			arg_18_1.duration_ = var_18_0[var_18_1]
		end

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play417261005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0.3

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				arg_18_1.leftNameTxt_.text = arg_18_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, true)
				arg_18_1.iconController_:SetSelectedState("hero")

				arg_18_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_18_1.callingController_:SetSelectedState("normal")

				arg_18_1.keyicon_.color = Color.New(1, 1, 1)
				arg_18_1.icon_.color = Color.New(1, 1, 1)

				local var_21_1 = arg_18_1:GetWordFromCfg(417261004)
				local var_21_2 = arg_18_1:FormatText(var_21_1.content)

				arg_18_1.text_.text = var_21_2

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_4 = 12 <= 0 and var_21_0 or var_21_0 * (utf8.len(var_21_2) / 12)

				if (12 <= 0 and var_21_0 or var_21_0 * (utf8.len(var_21_2) / 12)) > 0 and var_21_0 < var_21_4 then
					arg_18_1.talkMaxDuration = var_21_4

					if var_21_4 + 0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_4 + 0
					end
				end

				arg_18_1.text_.text = var_21_2
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261004", "story_v_out_417261.awb") ~= 0 then
					local var_21_5 = manager.audio:GetVoiceLength("story_v_out_417261", "417261004", "story_v_out_417261.awb") / 1000

					if var_21_5 + 0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_5 + 0
					end

					if var_21_1.prefab_name ~= "" and arg_18_1.actors_[var_21_1.prefab_name] ~= nil then
						local var_21_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_1.prefab_name].transform, "story_v_out_417261", "417261004", "story_v_out_417261.awb")

						arg_18_1:RecordAudio("417261004", var_21_6)
						arg_18_1:RecordAudio("417261004", var_21_6)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_417261", "417261004", "story_v_out_417261.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_417261", "417261004", "story_v_out_417261.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_7 = math.max(var_21_0, arg_18_1.talkMaxDuration)

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_7 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - 0) / var_21_7

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= 0 + var_21_7 and arg_18_1.time_ < 0 + var_21_7 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play417261005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 417261005
		arg_22_1.duration_ = 7.2

		local var_22_0 = {
			zh = 7.2,
			ja = 6.533
		}
		local var_22_1 = manager.audio:GetLocalizationFlag()

		if var_22_0[var_22_1] ~= nil then
			arg_22_1.duration_ = var_22_0[var_22_1]
		end

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play417261006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			if arg_22_1.actors_["1034"] == nil then
				local var_25_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1034")

				if not isNil(var_25_0) then
					local var_25_1 = Object.Instantiate(var_25_0, arg_22_1.canvasGo_.transform)

					var_25_1.transform:SetSiblingIndex(1)

					var_25_1.name = "1034"
					var_25_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_22_1.actors_["1034"] = var_25_1

					if arg_22_1.isInRecall_ then
						for iter_25_0, iter_25_1 in ipairs((var_25_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_25_1.color = arg_22_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_25_2 = arg_22_1.actors_["1034"]

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 and not isNil(var_25_2) and arg_22_1.var_.actorSpriteComps1034 == nil then
				arg_22_1.var_.actorSpriteComps1034 = var_25_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_25_3 = 0.2

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_3 and not isNil(var_25_2) then
				if arg_22_1.var_.actorSpriteComps1034 then
					for iter_25_2, iter_25_3 in pairs(arg_22_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_25_3 then
							if arg_22_1.isInRecall_ then
								iter_25_3.color = Color.New(Mathf.Lerp(iter_25_3.color.r, arg_22_1.hightColor1.r, (arg_22_1.time_ - 0) / var_25_3), Mathf.Lerp(iter_25_3.color.g, arg_22_1.hightColor1.g, (arg_22_1.time_ - 0) / var_25_3), (Mathf.Lerp(iter_25_3.color.b, arg_22_1.hightColor1.b, (arg_22_1.time_ - 0) / var_25_3)))
							else
								local var_25_4 = Mathf.Lerp(iter_25_3.color.r, 1, (arg_22_1.time_ - 0) / var_25_3)

								iter_25_3.color = Color.New(var_25_4, var_25_4, var_25_4)
							end
						end
					end
				end
			end

			if arg_22_1.time_ >= 0 + var_25_3 and arg_22_1.time_ < 0 + var_25_3 + arg_25_0 and not isNil(var_25_2) and arg_22_1.var_.actorSpriteComps1034 then
				for iter_25_4, iter_25_5 in pairs(arg_22_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_25_5 then
						iter_25_5.color = arg_22_1.isInRecall_ and (arg_22_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_22_1.var_.actorSpriteComps1034 = nil
			end

			local var_25_5 = arg_22_1.actors_["1034"].transform

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.var_.moveOldPos1034 = var_25_5.localPosition
				var_25_5.localScale = Vector3.New(1, 1, 1)

				arg_22_1:CheckSpriteTmpPos("1034", 3)

				for iter_25_6 = 0, var_25_5.childCount - 1 do
					local var_25_6 = var_25_5:GetChild(iter_25_6)

					if var_25_6.name == "split_4" or not string.find(var_25_6.name, "split") then
						var_25_6.gameObject:SetActive(true)
					else
						var_25_6.gameObject:SetActive(false)
					end
				end
			end

			local var_25_7 = 0.001

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_7 then
				var_25_5.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_22_1.time_ - 0) / var_25_7)
			end

			if arg_22_1.time_ >= 0 + var_25_7 and arg_22_1.time_ < 0 + var_25_7 + arg_25_0 then
				var_25_5.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_25_8 = 0
			local var_25_9 = 0.775

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_8 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_10 = arg_22_1:GetWordFromCfg(417261005)
				local var_25_11 = arg_22_1:FormatText(var_25_10.content)

				arg_22_1.text_.text = var_25_11

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_13 = 31 <= 0 and var_25_9 or var_25_9 * (utf8.len(var_25_11) / 31)

				if (31 <= 0 and var_25_9 or var_25_9 * (utf8.len(var_25_11) / 31)) > 0 and var_25_9 < var_25_13 then
					arg_22_1.talkMaxDuration = var_25_13

					if var_25_13 + var_25_8 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_13 + var_25_8
					end
				end

				arg_22_1.text_.text = var_25_11
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261005", "story_v_out_417261.awb") ~= 0 then
					local var_25_14 = manager.audio:GetVoiceLength("story_v_out_417261", "417261005", "story_v_out_417261.awb") / 1000

					if var_25_14 + var_25_8 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_14 + var_25_8
					end

					if var_25_10.prefab_name ~= "" and arg_22_1.actors_[var_25_10.prefab_name] ~= nil then
						local var_25_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_10.prefab_name].transform, "story_v_out_417261", "417261005", "story_v_out_417261.awb")

						arg_22_1:RecordAudio("417261005", var_25_15)
						arg_22_1:RecordAudio("417261005", var_25_15)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_417261", "417261005", "story_v_out_417261.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_417261", "417261005", "story_v_out_417261.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_16 = math.max(var_25_9, arg_22_1.talkMaxDuration)

			if var_25_8 <= arg_22_1.time_ and arg_22_1.time_ < var_25_8 + var_25_16 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_8) / var_25_16

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_8 + var_25_16 and arg_22_1.time_ < var_25_8 + var_25_16 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_22_1:InitPlayNodeList()
	end,
	Play417261006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 417261006
		arg_26_1.duration_ = 10.1

		local var_26_0 = {
			zh = 8.566,
			ja = 10.1
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play417261007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0.975

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_1 = arg_26_1:GetWordFromCfg(417261006)
				local var_29_2 = arg_26_1:FormatText(var_29_1.content)

				arg_26_1.text_.text = var_29_2

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_4 = 39 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 39)

				if (39 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 39)) > 0 and var_29_0 < var_29_4 then
					arg_26_1.talkMaxDuration = var_29_4

					if var_29_4 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_4 + 0
					end
				end

				arg_26_1.text_.text = var_29_2
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261006", "story_v_out_417261.awb") ~= 0 then
					local var_29_5 = manager.audio:GetVoiceLength("story_v_out_417261", "417261006", "story_v_out_417261.awb") / 1000

					if var_29_5 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_5 + 0
					end

					if var_29_1.prefab_name ~= "" and arg_26_1.actors_[var_29_1.prefab_name] ~= nil then
						local var_29_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_1.prefab_name].transform, "story_v_out_417261", "417261006", "story_v_out_417261.awb")

						arg_26_1:RecordAudio("417261006", var_29_6)
						arg_26_1:RecordAudio("417261006", var_29_6)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_417261", "417261006", "story_v_out_417261.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_417261", "417261006", "story_v_out_417261.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_7 = math.max(var_29_0, arg_26_1.talkMaxDuration)

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_7 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - 0) / var_29_7

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= 0 + var_29_7 and arg_26_1.time_ < 0 + var_29_7 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play417261007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 417261007
		arg_30_1.duration_ = 7.23

		local var_30_0 = {
			zh = 5.633,
			ja = 7.233
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play417261008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 and not isNil(arg_30_1.actors_["1034"]) and arg_30_1.var_.actorSpriteComps1034 == nil then
				arg_30_1.var_.actorSpriteComps1034 = arg_30_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_33_0 = 0.2

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_0 and not isNil(arg_30_1.actors_["1034"]) then
				if arg_30_1.var_.actorSpriteComps1034 then
					for iter_33_0, iter_33_1 in pairs(arg_30_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_33_1 then
							if arg_30_1.isInRecall_ then
								iter_33_1.color = Color.New(Mathf.Lerp(iter_33_1.color.r, arg_30_1.hightColor2.r, (arg_30_1.time_ - 0) / var_33_0), Mathf.Lerp(iter_33_1.color.g, arg_30_1.hightColor2.g, (arg_30_1.time_ - 0) / var_33_0), (Mathf.Lerp(iter_33_1.color.b, arg_30_1.hightColor2.b, (arg_30_1.time_ - 0) / var_33_0)))
							else
								local var_33_1 = Mathf.Lerp(iter_33_1.color.r, 0.5, (arg_30_1.time_ - 0) / var_33_0)

								iter_33_1.color = Color.New(var_33_1, var_33_1, var_33_1)
							end
						end
					end
				end
			end

			if arg_30_1.time_ >= 0 + var_33_0 and arg_30_1.time_ < 0 + var_33_0 + arg_33_0 and not isNil(arg_30_1.actors_["1034"]) and arg_30_1.var_.actorSpriteComps1034 then
				for iter_33_2, iter_33_3 in pairs(arg_30_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_33_3 then
						iter_33_3.color = arg_30_1.isInRecall_ and (arg_30_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_30_1.var_.actorSpriteComps1034 = nil
			end

			local var_33_2 = 0
			local var_33_3 = 0.55

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_2 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, true)
				arg_30_1.iconController_:SetSelectedState("hero")

				arg_30_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_30_1.callingController_:SetSelectedState("normal")

				arg_30_1.keyicon_.color = Color.New(1, 1, 1)
				arg_30_1.icon_.color = Color.New(1, 1, 1)

				local var_33_4 = arg_30_1:GetWordFromCfg(417261007)
				local var_33_5 = arg_30_1:FormatText(var_33_4.content)

				arg_30_1.text_.text = var_33_5

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_7 = 22 <= 0 and var_33_3 or var_33_3 * (utf8.len(var_33_5) / 22)

				if (22 <= 0 and var_33_3 or var_33_3 * (utf8.len(var_33_5) / 22)) > 0 and var_33_3 < var_33_7 then
					arg_30_1.talkMaxDuration = var_33_7

					if var_33_7 + var_33_2 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_7 + var_33_2
					end
				end

				arg_30_1.text_.text = var_33_5
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261007", "story_v_out_417261.awb") ~= 0 then
					local var_33_8 = manager.audio:GetVoiceLength("story_v_out_417261", "417261007", "story_v_out_417261.awb") / 1000

					if var_33_8 + var_33_2 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_8 + var_33_2
					end

					if var_33_4.prefab_name ~= "" and arg_30_1.actors_[var_33_4.prefab_name] ~= nil then
						local var_33_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_4.prefab_name].transform, "story_v_out_417261", "417261007", "story_v_out_417261.awb")

						arg_30_1:RecordAudio("417261007", var_33_9)
						arg_30_1:RecordAudio("417261007", var_33_9)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_417261", "417261007", "story_v_out_417261.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_417261", "417261007", "story_v_out_417261.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_10 = math.max(var_33_3, arg_30_1.talkMaxDuration)

			if var_33_2 <= arg_30_1.time_ and arg_30_1.time_ < var_33_2 + var_33_10 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_2) / var_33_10

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_2 + var_33_10 and arg_30_1.time_ < var_33_2 + var_33_10 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play417261008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 417261008
		arg_34_1.duration_ = 6.6

		local var_34_0 = {
			zh = 5.4,
			ja = 6.6
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play417261009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 0.5

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, true)
				arg_34_1.iconController_:SetSelectedState("hero")

				arg_34_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_34_1.callingController_:SetSelectedState("normal")

				arg_34_1.keyicon_.color = Color.New(1, 1, 1)
				arg_34_1.icon_.color = Color.New(1, 1, 1)

				local var_37_1 = arg_34_1:GetWordFromCfg(417261008)
				local var_37_2 = arg_34_1:FormatText(var_37_1.content)

				arg_34_1.text_.text = var_37_2

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_4 = 20 <= 0 and var_37_0 or var_37_0 * (utf8.len(var_37_2) / 20)

				if (20 <= 0 and var_37_0 or var_37_0 * (utf8.len(var_37_2) / 20)) > 0 and var_37_0 < var_37_4 then
					arg_34_1.talkMaxDuration = var_37_4

					if var_37_4 + 0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_4 + 0
					end
				end

				arg_34_1.text_.text = var_37_2
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261008", "story_v_out_417261.awb") ~= 0 then
					local var_37_5 = manager.audio:GetVoiceLength("story_v_out_417261", "417261008", "story_v_out_417261.awb") / 1000

					if var_37_5 + 0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_5 + 0
					end

					if var_37_1.prefab_name ~= "" and arg_34_1.actors_[var_37_1.prefab_name] ~= nil then
						local var_37_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_1.prefab_name].transform, "story_v_out_417261", "417261008", "story_v_out_417261.awb")

						arg_34_1:RecordAudio("417261008", var_37_6)
						arg_34_1:RecordAudio("417261008", var_37_6)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_417261", "417261008", "story_v_out_417261.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_417261", "417261008", "story_v_out_417261.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_7 = math.max(var_37_0, arg_34_1.talkMaxDuration)

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_7 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - 0) / var_37_7

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= 0 + var_37_7 and arg_34_1.time_ < 0 + var_37_7 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play417261009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 417261009
		arg_38_1.duration_ = 5.03

		local var_38_0 = {
			zh = 2.766,
			ja = 5.033
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play417261010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(arg_38_1.actors_["1034"]) and arg_38_1.var_.actorSpriteComps1034 == nil then
				arg_38_1.var_.actorSpriteComps1034 = arg_38_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_41_0 = 0.2

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 and not isNil(arg_38_1.actors_["1034"]) then
				if arg_38_1.var_.actorSpriteComps1034 then
					for iter_41_0, iter_41_1 in pairs(arg_38_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_41_1 then
							if arg_38_1.isInRecall_ then
								iter_41_1.color = Color.New(Mathf.Lerp(iter_41_1.color.r, arg_38_1.hightColor1.r, (arg_38_1.time_ - 0) / var_41_0), Mathf.Lerp(iter_41_1.color.g, arg_38_1.hightColor1.g, (arg_38_1.time_ - 0) / var_41_0), (Mathf.Lerp(iter_41_1.color.b, arg_38_1.hightColor1.b, (arg_38_1.time_ - 0) / var_41_0)))
							else
								local var_41_1 = Mathf.Lerp(iter_41_1.color.r, 1, (arg_38_1.time_ - 0) / var_41_0)

								iter_41_1.color = Color.New(var_41_1, var_41_1, var_41_1)
							end
						end
					end
				end
			end

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 and not isNil(arg_38_1.actors_["1034"]) and arg_38_1.var_.actorSpriteComps1034 then
				for iter_41_2, iter_41_3 in pairs(arg_38_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_41_3 then
						iter_41_3.color = arg_38_1.isInRecall_ and (arg_38_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_38_1.var_.actorSpriteComps1034 = nil
			end

			local var_41_2 = 0
			local var_41_3 = 0.325

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_2 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_4 = arg_38_1:GetWordFromCfg(417261009)
				local var_41_5 = arg_38_1:FormatText(var_41_4.content)

				arg_38_1.text_.text = var_41_5

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_7 = 13 <= 0 and var_41_3 or var_41_3 * (utf8.len(var_41_5) / 13)

				if (13 <= 0 and var_41_3 or var_41_3 * (utf8.len(var_41_5) / 13)) > 0 and var_41_3 < var_41_7 then
					arg_38_1.talkMaxDuration = var_41_7

					if var_41_7 + var_41_2 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_7 + var_41_2
					end
				end

				arg_38_1.text_.text = var_41_5
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261009", "story_v_out_417261.awb") ~= 0 then
					local var_41_8 = manager.audio:GetVoiceLength("story_v_out_417261", "417261009", "story_v_out_417261.awb") / 1000

					if var_41_8 + var_41_2 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_8 + var_41_2
					end

					if var_41_4.prefab_name ~= "" and arg_38_1.actors_[var_41_4.prefab_name] ~= nil then
						local var_41_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_4.prefab_name].transform, "story_v_out_417261", "417261009", "story_v_out_417261.awb")

						arg_38_1:RecordAudio("417261009", var_41_9)
						arg_38_1:RecordAudio("417261009", var_41_9)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_417261", "417261009", "story_v_out_417261.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_417261", "417261009", "story_v_out_417261.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_10 = math.max(var_41_3, arg_38_1.talkMaxDuration)

			if var_41_2 <= arg_38_1.time_ and arg_38_1.time_ < var_41_2 + var_41_10 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_2) / var_41_10

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_2 + var_41_10 and arg_38_1.time_ < var_41_2 + var_41_10 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play417261010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 417261010
		arg_42_1.duration_ = 7.8

		local var_42_0 = {
			zh = 4.833,
			ja = 7.8
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play417261011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(arg_42_1.actors_["1034"]) and arg_42_1.var_.actorSpriteComps1034 == nil then
				arg_42_1.var_.actorSpriteComps1034 = arg_42_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_0 = 0.2

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_0 and not isNil(arg_42_1.actors_["1034"]) then
				if arg_42_1.var_.actorSpriteComps1034 then
					for iter_45_0, iter_45_1 in pairs(arg_42_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_45_1 then
							if arg_42_1.isInRecall_ then
								iter_45_1.color = Color.New(Mathf.Lerp(iter_45_1.color.r, arg_42_1.hightColor2.r, (arg_42_1.time_ - 0) / var_45_0), Mathf.Lerp(iter_45_1.color.g, arg_42_1.hightColor2.g, (arg_42_1.time_ - 0) / var_45_0), (Mathf.Lerp(iter_45_1.color.b, arg_42_1.hightColor2.b, (arg_42_1.time_ - 0) / var_45_0)))
							else
								local var_45_1 = Mathf.Lerp(iter_45_1.color.r, 0.5, (arg_42_1.time_ - 0) / var_45_0)

								iter_45_1.color = Color.New(var_45_1, var_45_1, var_45_1)
							end
						end
					end
				end
			end

			if arg_42_1.time_ >= 0 + var_45_0 and arg_42_1.time_ < 0 + var_45_0 + arg_45_0 and not isNil(arg_42_1.actors_["1034"]) and arg_42_1.var_.actorSpriteComps1034 then
				for iter_45_2, iter_45_3 in pairs(arg_42_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_45_3 then
						iter_45_3.color = arg_42_1.isInRecall_ and (arg_42_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_42_1.var_.actorSpriteComps1034 = nil
			end

			local var_45_2 = 0
			local var_45_3 = 0.45

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_2 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_4 = arg_42_1:GetWordFromCfg(417261010)
				local var_45_5 = arg_42_1:FormatText(var_45_4.content)

				arg_42_1.text_.text = var_45_5

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_7 = 18 <= 0 and var_45_3 or var_45_3 * (utf8.len(var_45_5) / 18)

				if (18 <= 0 and var_45_3 or var_45_3 * (utf8.len(var_45_5) / 18)) > 0 and var_45_3 < var_45_7 then
					arg_42_1.talkMaxDuration = var_45_7

					if var_45_7 + var_45_2 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_7 + var_45_2
					end
				end

				arg_42_1.text_.text = var_45_5
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261010", "story_v_out_417261.awb") ~= 0 then
					local var_45_8 = manager.audio:GetVoiceLength("story_v_out_417261", "417261010", "story_v_out_417261.awb") / 1000

					if var_45_8 + var_45_2 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_8 + var_45_2
					end

					if var_45_4.prefab_name ~= "" and arg_42_1.actors_[var_45_4.prefab_name] ~= nil then
						local var_45_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_4.prefab_name].transform, "story_v_out_417261", "417261010", "story_v_out_417261.awb")

						arg_42_1:RecordAudio("417261010", var_45_9)
						arg_42_1:RecordAudio("417261010", var_45_9)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_417261", "417261010", "story_v_out_417261.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_417261", "417261010", "story_v_out_417261.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_10 = math.max(var_45_3, arg_42_1.talkMaxDuration)

			if var_45_2 <= arg_42_1.time_ and arg_42_1.time_ < var_45_2 + var_45_10 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_2) / var_45_10

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_2 + var_45_10 and arg_42_1.time_ < var_45_2 + var_45_10 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play417261011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 417261011
		arg_46_1.duration_ = 1

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play417261012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(arg_46_1.actors_["1034"]) and arg_46_1.var_.actorSpriteComps1034 == nil then
				arg_46_1.var_.actorSpriteComps1034 = arg_46_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_49_0 = 0.2

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_0 and not isNil(arg_46_1.actors_["1034"]) then
				if arg_46_1.var_.actorSpriteComps1034 then
					for iter_49_0, iter_49_1 in pairs(arg_46_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_49_1 then
							if arg_46_1.isInRecall_ then
								iter_49_1.color = Color.New(Mathf.Lerp(iter_49_1.color.r, arg_46_1.hightColor1.r, (arg_46_1.time_ - 0) / var_49_0), Mathf.Lerp(iter_49_1.color.g, arg_46_1.hightColor1.g, (arg_46_1.time_ - 0) / var_49_0), (Mathf.Lerp(iter_49_1.color.b, arg_46_1.hightColor1.b, (arg_46_1.time_ - 0) / var_49_0)))
							else
								local var_49_1 = Mathf.Lerp(iter_49_1.color.r, 1, (arg_46_1.time_ - 0) / var_49_0)

								iter_49_1.color = Color.New(var_49_1, var_49_1, var_49_1)
							end
						end
					end
				end
			end

			if arg_46_1.time_ >= 0 + var_49_0 and arg_46_1.time_ < 0 + var_49_0 + arg_49_0 and not isNil(arg_46_1.actors_["1034"]) and arg_46_1.var_.actorSpriteComps1034 then
				for iter_49_2, iter_49_3 in pairs(arg_46_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_49_3 then
						iter_49_3.color = arg_46_1.isInRecall_ and (arg_46_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_46_1.var_.actorSpriteComps1034 = nil
			end

			local var_49_2 = 0
			local var_49_3 = 0.075

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_2 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_4 = arg_46_1:GetWordFromCfg(417261011)
				local var_49_5 = arg_46_1:FormatText(var_49_4.content)

				arg_46_1.text_.text = var_49_5

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_7 = 3 <= 0 and var_49_3 or var_49_3 * (utf8.len(var_49_5) / 3)

				if (3 <= 0 and var_49_3 or var_49_3 * (utf8.len(var_49_5) / 3)) > 0 and var_49_3 < var_49_7 then
					arg_46_1.talkMaxDuration = var_49_7

					if var_49_7 + var_49_2 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_7 + var_49_2
					end
				end

				arg_46_1.text_.text = var_49_5
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261011", "story_v_out_417261.awb") ~= 0 then
					local var_49_8 = manager.audio:GetVoiceLength("story_v_out_417261", "417261011", "story_v_out_417261.awb") / 1000

					if var_49_8 + var_49_2 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_8 + var_49_2
					end

					if var_49_4.prefab_name ~= "" and arg_46_1.actors_[var_49_4.prefab_name] ~= nil then
						local var_49_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_4.prefab_name].transform, "story_v_out_417261", "417261011", "story_v_out_417261.awb")

						arg_46_1:RecordAudio("417261011", var_49_9)
						arg_46_1:RecordAudio("417261011", var_49_9)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_417261", "417261011", "story_v_out_417261.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_417261", "417261011", "story_v_out_417261.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_10 = math.max(var_49_3, arg_46_1.talkMaxDuration)

			if var_49_2 <= arg_46_1.time_ and arg_46_1.time_ < var_49_2 + var_49_10 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_2) / var_49_10

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_2 + var_49_10 and arg_46_1.time_ < var_49_2 + var_49_10 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play417261012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 417261012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play417261013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos1034 = arg_50_1.actors_["1034"].transform.localPosition
				arg_50_1.actors_["1034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_50_1:CheckSpriteTmpPos("1034", 7)

				for iter_53_0 = 0, arg_50_1.actors_["1034"].transform.childCount - 1 do
					local var_53_0 = arg_50_1.actors_["1034"].transform:GetChild(iter_53_0)

					if var_53_0.name == "" or not string.find(var_53_0.name, "split") then
						var_53_0.gameObject:SetActive(true)
					else
						var_53_0.gameObject:SetActive(false)
					end
				end
			end

			local var_53_1 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_1 then
				arg_50_1.actors_["1034"].transform.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_50_1.time_ - 0) / var_53_1)
			end

			if arg_50_1.time_ >= 0 + var_53_1 and arg_50_1.time_ < 0 + var_53_1 + arg_53_0 then
				arg_50_1.actors_["1034"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_53_2 = 0
			local var_53_3 = 0.55

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_2 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, false)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_4 = arg_50_1:FormatText(arg_50_1:GetWordFromCfg(417261012).content)

				arg_50_1.text_.text = var_53_4

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_6 = 22 <= 0 and var_53_3 or var_53_3 * (utf8.len(var_53_4) / 22)

				if (22 <= 0 and var_53_3 or var_53_3 * (utf8.len(var_53_4) / 22)) > 0 and var_53_3 < var_53_6 then
					arg_50_1.talkMaxDuration = var_53_6

					if var_53_6 + var_53_2 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_6 + var_53_2
					end
				end

				arg_50_1.text_.text = var_53_4
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_7 = math.max(var_53_3, arg_50_1.talkMaxDuration)

			if var_53_2 <= arg_50_1.time_ and arg_50_1.time_ < var_53_2 + var_53_7 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_2) / var_53_7

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_2 + var_53_7 and arg_50_1.time_ < var_53_2 + var_53_7 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play417261013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 417261013
		arg_54_1.duration_ = 6.6

		local var_54_0 = {
			zh = 3.466,
			ja = 6.6
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
				arg_54_0:Play417261014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.var_.moveOldPos1034 = arg_54_1.actors_["1034"].transform.localPosition
				arg_54_1.actors_["1034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_54_1:CheckSpriteTmpPos("1034", 3)

				for iter_57_0 = 0, arg_54_1.actors_["1034"].transform.childCount - 1 do
					local var_57_0 = arg_54_1.actors_["1034"].transform:GetChild(iter_57_0)

					if var_57_0.name == "split_6" or not string.find(var_57_0.name, "split") then
						var_57_0.gameObject:SetActive(true)
					else
						var_57_0.gameObject:SetActive(false)
					end
				end
			end

			local var_57_1 = 0.001

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_1 then
				arg_54_1.actors_["1034"].transform.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_54_1.time_ - 0) / var_57_1)
			end

			if arg_54_1.time_ >= 0 + var_57_1 and arg_54_1.time_ < 0 + var_57_1 + arg_57_0 then
				arg_54_1.actors_["1034"].transform.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_57_2 = arg_54_1.actors_["1034"]

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(var_57_2) and arg_54_1.var_.actorSpriteComps1034 == nil then
				arg_54_1.var_.actorSpriteComps1034 = var_57_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_57_3 = 0.2

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_3 and not isNil(var_57_2) then
				if arg_54_1.var_.actorSpriteComps1034 then
					for iter_57_1, iter_57_2 in pairs(arg_54_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_57_2 then
							if arg_54_1.isInRecall_ then
								iter_57_2.color = Color.New(Mathf.Lerp(iter_57_2.color.r, arg_54_1.hightColor1.r, (arg_54_1.time_ - 0) / var_57_3), Mathf.Lerp(iter_57_2.color.g, arg_54_1.hightColor1.g, (arg_54_1.time_ - 0) / var_57_3), (Mathf.Lerp(iter_57_2.color.b, arg_54_1.hightColor1.b, (arg_54_1.time_ - 0) / var_57_3)))
							else
								local var_57_4 = Mathf.Lerp(iter_57_2.color.r, 1, (arg_54_1.time_ - 0) / var_57_3)

								iter_57_2.color = Color.New(var_57_4, var_57_4, var_57_4)
							end
						end
					end
				end
			end

			if arg_54_1.time_ >= 0 + var_57_3 and arg_54_1.time_ < 0 + var_57_3 + arg_57_0 and not isNil(var_57_2) and arg_54_1.var_.actorSpriteComps1034 then
				for iter_57_3, iter_57_4 in pairs(arg_54_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_57_4 then
						iter_57_4.color = arg_54_1.isInRecall_ and (arg_54_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_54_1.var_.actorSpriteComps1034 = nil
			end

			local var_57_5 = 0
			local var_57_6 = 0.425

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_5 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_7 = arg_54_1:GetWordFromCfg(417261013)
				local var_57_8 = arg_54_1:FormatText(var_57_7.content)

				arg_54_1.text_.text = var_57_8

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_10 = 17 <= 0 and var_57_6 or var_57_6 * (utf8.len(var_57_8) / 17)

				if (17 <= 0 and var_57_6 or var_57_6 * (utf8.len(var_57_8) / 17)) > 0 and var_57_6 < var_57_10 then
					arg_54_1.talkMaxDuration = var_57_10

					if var_57_10 + var_57_5 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_10 + var_57_5
					end
				end

				arg_54_1.text_.text = var_57_8
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261013", "story_v_out_417261.awb") ~= 0 then
					local var_57_11 = manager.audio:GetVoiceLength("story_v_out_417261", "417261013", "story_v_out_417261.awb") / 1000

					if var_57_11 + var_57_5 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_11 + var_57_5
					end

					if var_57_7.prefab_name ~= "" and arg_54_1.actors_[var_57_7.prefab_name] ~= nil then
						local var_57_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_7.prefab_name].transform, "story_v_out_417261", "417261013", "story_v_out_417261.awb")

						arg_54_1:RecordAudio("417261013", var_57_12)
						arg_54_1:RecordAudio("417261013", var_57_12)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_417261", "417261013", "story_v_out_417261.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_417261", "417261013", "story_v_out_417261.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_13 = math.max(var_57_6, arg_54_1.talkMaxDuration)

			if var_57_5 <= arg_54_1.time_ and arg_54_1.time_ < var_57_5 + var_57_13 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_5) / var_57_13

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_5 + var_57_13 and arg_54_1.time_ < var_57_5 + var_57_13 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_54_1:InitPlayNodeList()
	end,
	Play417261014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 417261014
		arg_58_1.duration_ = 13.13

		local var_58_0 = {
			zh = 9.8,
			ja = 13.133
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play417261015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(arg_58_1.actors_["1034"]) and arg_58_1.var_.actorSpriteComps1034 == nil then
				arg_58_1.var_.actorSpriteComps1034 = arg_58_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_0 = 0.2

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 and not isNil(arg_58_1.actors_["1034"]) then
				if arg_58_1.var_.actorSpriteComps1034 then
					for iter_61_0, iter_61_1 in pairs(arg_58_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_61_1 then
							if arg_58_1.isInRecall_ then
								iter_61_1.color = Color.New(Mathf.Lerp(iter_61_1.color.r, arg_58_1.hightColor2.r, (arg_58_1.time_ - 0) / var_61_0), Mathf.Lerp(iter_61_1.color.g, arg_58_1.hightColor2.g, (arg_58_1.time_ - 0) / var_61_0), (Mathf.Lerp(iter_61_1.color.b, arg_58_1.hightColor2.b, (arg_58_1.time_ - 0) / var_61_0)))
							else
								local var_61_1 = Mathf.Lerp(iter_61_1.color.r, 0.5, (arg_58_1.time_ - 0) / var_61_0)

								iter_61_1.color = Color.New(var_61_1, var_61_1, var_61_1)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 and not isNil(arg_58_1.actors_["1034"]) and arg_58_1.var_.actorSpriteComps1034 then
				for iter_61_2, iter_61_3 in pairs(arg_58_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_61_3 then
						iter_61_3.color = arg_58_1.isInRecall_ and (arg_58_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_58_1.var_.actorSpriteComps1034 = nil
			end

			local var_61_2 = 0
			local var_61_3 = 1

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_2 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_4 = arg_58_1:GetWordFromCfg(417261014)
				local var_61_5 = arg_58_1:FormatText(var_61_4.content)

				arg_58_1.text_.text = var_61_5

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_7 = 40 <= 0 and var_61_3 or var_61_3 * (utf8.len(var_61_5) / 40)

				if (40 <= 0 and var_61_3 or var_61_3 * (utf8.len(var_61_5) / 40)) > 0 and var_61_3 < var_61_7 then
					arg_58_1.talkMaxDuration = var_61_7

					if var_61_7 + var_61_2 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_7 + var_61_2
					end
				end

				arg_58_1.text_.text = var_61_5
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261014", "story_v_out_417261.awb") ~= 0 then
					local var_61_8 = manager.audio:GetVoiceLength("story_v_out_417261", "417261014", "story_v_out_417261.awb") / 1000

					if var_61_8 + var_61_2 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_8 + var_61_2
					end

					if var_61_4.prefab_name ~= "" and arg_58_1.actors_[var_61_4.prefab_name] ~= nil then
						local var_61_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_4.prefab_name].transform, "story_v_out_417261", "417261014", "story_v_out_417261.awb")

						arg_58_1:RecordAudio("417261014", var_61_9)
						arg_58_1:RecordAudio("417261014", var_61_9)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_417261", "417261014", "story_v_out_417261.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_417261", "417261014", "story_v_out_417261.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_10 = math.max(var_61_3, arg_58_1.talkMaxDuration)

			if var_61_2 <= arg_58_1.time_ and arg_58_1.time_ < var_61_2 + var_61_10 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_2) / var_61_10

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_2 + var_61_10 and arg_58_1.time_ < var_61_2 + var_61_10 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play417261015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 417261015
		arg_62_1.duration_ = 16.6

		local var_62_0 = {
			zh = 10.633,
			ja = 16.6
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
				arg_62_0:Play417261016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 1.025

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_1 = arg_62_1:GetWordFromCfg(417261015)
				local var_65_2 = arg_62_1:FormatText(var_65_1.content)

				arg_62_1.text_.text = var_65_2

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_4 = 41 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 41)

				if (41 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 41)) > 0 and var_65_0 < var_65_4 then
					arg_62_1.talkMaxDuration = var_65_4

					if var_65_4 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_4 + 0
					end
				end

				arg_62_1.text_.text = var_65_2
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261015", "story_v_out_417261.awb") ~= 0 then
					local var_65_5 = manager.audio:GetVoiceLength("story_v_out_417261", "417261015", "story_v_out_417261.awb") / 1000

					if var_65_5 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_5 + 0
					end

					if var_65_1.prefab_name ~= "" and arg_62_1.actors_[var_65_1.prefab_name] ~= nil then
						local var_65_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_1.prefab_name].transform, "story_v_out_417261", "417261015", "story_v_out_417261.awb")

						arg_62_1:RecordAudio("417261015", var_65_6)
						arg_62_1:RecordAudio("417261015", var_65_6)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_417261", "417261015", "story_v_out_417261.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_417261", "417261015", "story_v_out_417261.awb")
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
	Play417261016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 417261016
		arg_66_1.duration_ = 10

		local var_66_0 = {
			zh = 9.766,
			ja = 10
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
				arg_66_0:Play417261017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0.825

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, true)
				arg_66_1.iconController_:SetSelectedState("hero")

				arg_66_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_66_1.callingController_:SetSelectedState("normal")

				arg_66_1.keyicon_.color = Color.New(1, 1, 1)
				arg_66_1.icon_.color = Color.New(1, 1, 1)

				local var_69_1 = arg_66_1:GetWordFromCfg(417261016)
				local var_69_2 = arg_66_1:FormatText(var_69_1.content)

				arg_66_1.text_.text = var_69_2

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_4 = 33 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_2) / 33)

				if (33 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_2) / 33)) > 0 and var_69_0 < var_69_4 then
					arg_66_1.talkMaxDuration = var_69_4

					if var_69_4 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_4 + 0
					end
				end

				arg_66_1.text_.text = var_69_2
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261016", "story_v_out_417261.awb") ~= 0 then
					local var_69_5 = manager.audio:GetVoiceLength("story_v_out_417261", "417261016", "story_v_out_417261.awb") / 1000

					if var_69_5 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_5 + 0
					end

					if var_69_1.prefab_name ~= "" and arg_66_1.actors_[var_69_1.prefab_name] ~= nil then
						local var_69_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_1.prefab_name].transform, "story_v_out_417261", "417261016", "story_v_out_417261.awb")

						arg_66_1:RecordAudio("417261016", var_69_6)
						arg_66_1:RecordAudio("417261016", var_69_6)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_417261", "417261016", "story_v_out_417261.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_417261", "417261016", "story_v_out_417261.awb")
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
	Play417261017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 417261017
		arg_70_1.duration_ = 9.53

		local var_70_0 = {
			zh = 7.433,
			ja = 9.533
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
				arg_70_0:Play417261018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 4 < arg_70_1.time_ and arg_70_1.time_ <= 4 + arg_73_0 then
				arg_70_1.allBtn_.enabled = false
			end

			if arg_70_1.time_ >= 4 + 0.0666666666666664 and arg_70_1.time_ < 4 + 0.0666666666666664 + arg_73_0 then
				arg_70_1.allBtn_.enabled = true
			end

			local var_73_0 = "ST73"

			if arg_70_1.bgs_.ST73 == nil then
				local var_73_1 = Object.Instantiate(arg_70_1.paintGo_)

				var_73_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_73_0)
				var_73_1.name = var_73_0
				var_73_1.transform.parent = arg_70_1.stage_.transform
				var_73_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_70_1.bgs_[var_73_0] = var_73_1
			end

			if 2 < arg_70_1.time_ and arg_70_1.time_ <= 2 + arg_73_0 then
				local var_73_2 = arg_70_1.bgs_.ST73

				arg_70_1.bgs_.ST73.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_73_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_73_3 = var_73_2:GetComponent("SpriteRenderer")

				if var_73_3 and var_73_3.sprite then
					local var_73_4 = 2 * (var_73_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_73_2.transform.localScale = Vector3.New(var_73_4 / var_73_3.sprite.bounds.size.y < var_73_4 * manager.ui.mainCameraCom_.aspect / var_73_3.sprite.bounds.size.x and var_73_4 * manager.ui.mainCameraCom_.aspect / var_73_3.sprite.bounds.size.x or var_73_4 / var_73_3.sprite.bounds.size.y, var_73_4 / var_73_3.sprite.bounds.size.y < var_73_4 * manager.ui.mainCameraCom_.aspect / var_73_3.sprite.bounds.size.x and var_73_4 * manager.ui.mainCameraCom_.aspect / var_73_3.sprite.bounds.size.x or var_73_4 / var_73_3.sprite.bounds.size.y, 0)
				end

				for iter_73_0, iter_73_1 in pairs(arg_70_1.bgs_) do
					if iter_73_0 ~= "ST73" then
						iter_73_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_73_5 = 0

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_5 + arg_73_0 then
				arg_70_1.mask_.enabled = true
				arg_70_1.mask_.raycastTarget = true

				arg_70_1:SetGaussion(false)
			end

			local var_73_6 = 2

			if var_73_5 <= arg_70_1.time_ and arg_70_1.time_ < var_73_5 + var_73_6 then
				local var_73_7 = Color.New(0, 0, 0)

				var_73_7.a = Mathf.Lerp(0, 1, (arg_70_1.time_ - var_73_5) / var_73_6)
				arg_70_1.mask_.color = var_73_7
			end

			if arg_70_1.time_ >= var_73_5 + var_73_6 and arg_70_1.time_ < var_73_5 + var_73_6 + arg_73_0 then
				local var_73_8 = Color.New(0, 0, 0)

				var_73_8.a = 1
				arg_70_1.mask_.color = var_73_8
			end

			local var_73_9 = 2

			if 2 < arg_70_1.time_ and arg_70_1.time_ <= var_73_9 + arg_73_0 then
				arg_70_1.mask_.enabled = true
				arg_70_1.mask_.raycastTarget = true

				arg_70_1:SetGaussion(false)
			end

			local var_73_10 = 2

			if var_73_9 <= arg_70_1.time_ and arg_70_1.time_ < var_73_9 + var_73_10 then
				local var_73_11 = Color.New(0, 0, 0)

				var_73_11.a = Mathf.Lerp(1, 0, (arg_70_1.time_ - var_73_9) / var_73_10)
				arg_70_1.mask_.color = var_73_11
			end

			if arg_70_1.time_ >= var_73_9 + var_73_10 and arg_70_1.time_ < var_73_9 + var_73_10 + arg_73_0 then
				local var_73_12 = Color.New(0, 0, 0)

				arg_70_1.mask_.enabled = false
				var_73_12.a = 0
				arg_70_1.mask_.color = var_73_12
			end

			local var_73_13 = arg_70_1.actors_["1034"].transform

			if 1.966 < arg_70_1.time_ and arg_70_1.time_ <= 1.966 + arg_73_0 then
				arg_70_1.var_.moveOldPos1034 = var_73_13.localPosition
				var_73_13.localScale = Vector3.New(1, 1, 1)

				arg_70_1:CheckSpriteTmpPos("1034", 7)

				for iter_73_2 = 0, var_73_13.childCount - 1 do
					local var_73_14 = var_73_13:GetChild(iter_73_2)

					if var_73_14.name == "" or not string.find(var_73_14.name, "split") then
						var_73_14.gameObject:SetActive(true)
					else
						var_73_14.gameObject:SetActive(false)
					end
				end
			end

			local var_73_15 = 0.001

			if 1.966 <= arg_70_1.time_ and arg_70_1.time_ < 1.966 + var_73_15 then
				var_73_13.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_70_1.time_ - 1.966) / var_73_15)
			end

			if arg_70_1.time_ >= 1.966 + var_73_15 and arg_70_1.time_ < 1.966 + var_73_15 + arg_73_0 then
				var_73_13.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_73_16 = arg_70_1.actors_["1034"].transform

			if 3.66666666666667 < arg_70_1.time_ and arg_70_1.time_ <= 3.66666666666667 + arg_73_0 then
				arg_70_1.var_.moveOldPos1034 = var_73_16.localPosition
				var_73_16.localScale = Vector3.New(1, 1, 1)

				arg_70_1:CheckSpriteTmpPos("1034", 3)

				for iter_73_3 = 0, var_73_16.childCount - 1 do
					local var_73_17 = var_73_16:GetChild(iter_73_3)

					if var_73_17.name == "split_1" or not string.find(var_73_17.name, "split") then
						var_73_17.gameObject:SetActive(true)
					else
						var_73_17.gameObject:SetActive(false)
					end
				end
			end

			local var_73_18 = 0.001

			if 3.66666666666667 <= arg_70_1.time_ and arg_70_1.time_ < 3.66666666666667 + var_73_18 then
				var_73_16.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_70_1.time_ - 3.66666666666667) / var_73_18)
			end

			if arg_70_1.time_ >= 3.66666666666667 + var_73_18 and arg_70_1.time_ < 3.66666666666667 + var_73_18 + arg_73_0 then
				var_73_16.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_73_19 = arg_70_1.actors_["1034"]

			if 3.66666666666667 < arg_70_1.time_ and arg_70_1.time_ <= 3.66666666666667 + arg_73_0 and not isNil(var_73_19) and arg_70_1.var_.actorSpriteComps1034 == nil then
				arg_70_1.var_.actorSpriteComps1034 = var_73_19:GetComponentsInChildren(typeof(Image), true)
			end

			local var_73_20 = 0.2

			if 3.66666666666667 <= arg_70_1.time_ and arg_70_1.time_ < 3.66666666666667 + var_73_20 and not isNil(var_73_19) then
				if arg_70_1.var_.actorSpriteComps1034 then
					for iter_73_4, iter_73_5 in pairs(arg_70_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_73_5 then
							if arg_70_1.isInRecall_ then
								iter_73_5.color = Color.New(Mathf.Lerp(iter_73_5.color.r, arg_70_1.hightColor1.r, (arg_70_1.time_ - 3.66666666666667) / var_73_20), Mathf.Lerp(iter_73_5.color.g, arg_70_1.hightColor1.g, (arg_70_1.time_ - 3.66666666666667) / var_73_20), (Mathf.Lerp(iter_73_5.color.b, arg_70_1.hightColor1.b, (arg_70_1.time_ - 3.66666666666667) / var_73_20)))
							else
								local var_73_21 = Mathf.Lerp(iter_73_5.color.r, 1, (arg_70_1.time_ - 3.66666666666667) / var_73_20)

								iter_73_5.color = Color.New(var_73_21, var_73_21, var_73_21)
							end
						end
					end
				end
			end

			if arg_70_1.time_ >= 3.66666666666667 + var_73_20 and arg_70_1.time_ < 3.66666666666667 + var_73_20 + arg_73_0 and not isNil(var_73_19) and arg_70_1.var_.actorSpriteComps1034 then
				for iter_73_6, iter_73_7 in pairs(arg_70_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_73_7 then
						iter_73_7.color = arg_70_1.isInRecall_ and (arg_70_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_70_1.var_.actorSpriteComps1034 = nil
			end

			if 3.66666666666667 < arg_70_1.time_ and arg_70_1.time_ <= 3.66666666666667 + arg_73_0 then
				local var_73_22 = arg_70_1.actors_["1034"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_73_22 then
					arg_70_1.var_.alphaOldValue1034 = var_73_22.alpha
					arg_70_1.var_.characterEffect1034 = var_73_22
				end

				arg_70_1.var_.alphaOldValue1034 = 0
			end

			local var_73_23 = 0.333333333333333

			if 3.66666666666667 <= arg_70_1.time_ and arg_70_1.time_ < 3.66666666666667 + var_73_23 then
				if arg_70_1.var_.characterEffect1034 then
					arg_70_1.var_.characterEffect1034.alpha = Mathf.Lerp(arg_70_1.var_.alphaOldValue1034, 1, (arg_70_1.time_ - 3.66666666666667) / var_73_23)
				end
			end

			if arg_70_1.time_ >= 3.66666666666667 + var_73_23 and arg_70_1.time_ < 3.66666666666667 + var_73_23 + arg_73_0 and arg_70_1.var_.characterEffect1034 then
				arg_70_1.var_.characterEffect1034.alpha = 1
			end

			if arg_70_1.frameCnt_ <= 1 then
				arg_70_1.dialog_:SetActive(false)
			end

			local var_73_24 = 4
			local var_73_25 = 0.2

			if 4 < arg_70_1.time_ and arg_70_1.time_ <= var_73_24 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0

				arg_70_1.dialog_:SetActive(true)

				arg_70_1.dialogCg_.alpha = 0

				local var_73_26 = LeanTween.value(arg_70_1.dialog_, 0, 1, 0.3)

				var_73_26:setOnUpdate(LuaHelper.FloatAction(function(arg_74_0)
					arg_70_1.dialogCg_.alpha = arg_74_0
				end))
				var_73_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_70_1.dialog_)
					var_73_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_70_1.duration_ = arg_70_1.duration_ + 0.3

				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_27 = arg_70_1:GetWordFromCfg(417261017)
				local var_73_28 = arg_70_1:FormatText(var_73_27.content)

				arg_70_1.text_.text = var_73_28

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_30 = 8 <= 0 and var_73_25 or var_73_25 * (utf8.len(var_73_28) / 8)

				if (8 <= 0 and var_73_25 or var_73_25 * (utf8.len(var_73_28) / 8)) > 0 and var_73_25 < var_73_30 then
					arg_70_1.talkMaxDuration = var_73_30
					var_73_24 = var_73_24 + 0.3

					if var_73_30 + var_73_24 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_30 + var_73_24
					end
				end

				arg_70_1.text_.text = var_73_28
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261017", "story_v_out_417261.awb") ~= 0 then
					local var_73_31 = manager.audio:GetVoiceLength("story_v_out_417261", "417261017", "story_v_out_417261.awb") / 1000

					if var_73_31 + var_73_24 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_31 + var_73_24
					end

					if var_73_27.prefab_name ~= "" and arg_70_1.actors_[var_73_27.prefab_name] ~= nil then
						local var_73_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_27.prefab_name].transform, "story_v_out_417261", "417261017", "story_v_out_417261.awb")

						arg_70_1:RecordAudio("417261017", var_73_32)
						arg_70_1:RecordAudio("417261017", var_73_32)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_417261", "417261017", "story_v_out_417261.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_417261", "417261017", "story_v_out_417261.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_33 = var_73_24 + 0.3
			local var_73_34 = math.max(var_73_25, arg_70_1.talkMaxDuration)

			if var_73_24 + 0.3 <= arg_70_1.time_ and arg_70_1.time_ < var_73_33 + var_73_34 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_33) / var_73_34

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_33 + var_73_34 and arg_70_1.time_ < var_73_33 + var_73_34 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play417261018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 417261018
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play417261019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1034 = arg_76_1.actors_["1034"].transform.localPosition
				arg_76_1.actors_["1034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_76_1:CheckSpriteTmpPos("1034", 7)

				for iter_79_0 = 0, arg_76_1.actors_["1034"].transform.childCount - 1 do
					local var_79_0 = arg_76_1.actors_["1034"].transform:GetChild(iter_79_0)

					if var_79_0.name == "" or not string.find(var_79_0.name, "split") then
						var_79_0.gameObject:SetActive(true)
					else
						var_79_0.gameObject:SetActive(false)
					end
				end
			end

			local var_79_1 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_1 then
				arg_76_1.actors_["1034"].transform.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_76_1.time_ - 0) / var_79_1)
			end

			if arg_76_1.time_ >= 0 + var_79_1 and arg_76_1.time_ < 0 + var_79_1 + arg_79_0 then
				arg_76_1.actors_["1034"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.133333333333333 < arg_76_1.time_ and arg_76_1.time_ <= 0.133333333333333 + arg_79_0 then
				arg_76_1:AudioAction("play", "effect", "se_story_side_1011", "se_story_side_1011_doorhandle", "")
			end

			local var_79_3 = 0
			local var_79_4 = 1.425

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_3 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_5 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(417261018).content)

				arg_76_1.text_.text = var_79_5

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_7 = 57 <= 0 and var_79_4 or var_79_4 * (utf8.len(var_79_5) / 57)

				if (57 <= 0 and var_79_4 or var_79_4 * (utf8.len(var_79_5) / 57)) > 0 and var_79_4 < var_79_7 then
					arg_76_1.talkMaxDuration = var_79_7

					if var_79_7 + var_79_3 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_7 + var_79_3
					end
				end

				arg_76_1.text_.text = var_79_5
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_8 = math.max(var_79_4, arg_76_1.talkMaxDuration)

			if var_79_3 <= arg_76_1.time_ and arg_76_1.time_ < var_79_3 + var_79_8 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_3) / var_79_8

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_3 + var_79_8 and arg_76_1.time_ < var_79_3 + var_79_8 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play417261019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 417261019
		arg_80_1.duration_ = 3.23

		local var_80_0 = {
			zh = 1.533,
			ja = 3.233
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
				arg_80_0:Play417261020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["1034"]) and arg_80_1.var_.actorSpriteComps1034 == nil then
				arg_80_1.var_.actorSpriteComps1034 = arg_80_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_83_0 = 0.2

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["1034"]) then
				if arg_80_1.var_.actorSpriteComps1034 then
					for iter_83_0, iter_83_1 in pairs(arg_80_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_83_1 then
							if arg_80_1.isInRecall_ then
								iter_83_1.color = Color.New(Mathf.Lerp(iter_83_1.color.r, arg_80_1.hightColor1.r, (arg_80_1.time_ - 0) / var_83_0), Mathf.Lerp(iter_83_1.color.g, arg_80_1.hightColor1.g, (arg_80_1.time_ - 0) / var_83_0), (Mathf.Lerp(iter_83_1.color.b, arg_80_1.hightColor1.b, (arg_80_1.time_ - 0) / var_83_0)))
							else
								local var_83_1 = Mathf.Lerp(iter_83_1.color.r, 1, (arg_80_1.time_ - 0) / var_83_0)

								iter_83_1.color = Color.New(var_83_1, var_83_1, var_83_1)
							end
						end
					end
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["1034"]) and arg_80_1.var_.actorSpriteComps1034 then
				for iter_83_2, iter_83_3 in pairs(arg_80_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_83_3 then
						iter_83_3.color = arg_80_1.isInRecall_ and (arg_80_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_80_1.var_.actorSpriteComps1034 = nil
			end

			local var_83_2 = arg_80_1.actors_["1034"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1034 = var_83_2.localPosition
				var_83_2.localScale = Vector3.New(1, 1, 1)

				arg_80_1:CheckSpriteTmpPos("1034", 3)

				for iter_83_4 = 0, var_83_2.childCount - 1 do
					local var_83_3 = var_83_2:GetChild(iter_83_4)

					if var_83_3.name == "split_6" or not string.find(var_83_3.name, "split") then
						var_83_3.gameObject:SetActive(true)
					else
						var_83_3.gameObject:SetActive(false)
					end
				end
			end

			local var_83_4 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_4 then
				var_83_2.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_80_1.time_ - 0) / var_83_4)
			end

			if arg_80_1.time_ >= 0 + var_83_4 and arg_80_1.time_ < 0 + var_83_4 + arg_83_0 then
				var_83_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_83_5 = 0
			local var_83_6 = 0.225

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_5 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_7 = arg_80_1:GetWordFromCfg(417261019)
				local var_83_8 = arg_80_1:FormatText(var_83_7.content)

				arg_80_1.text_.text = var_83_8

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_10 = 9 <= 0 and var_83_6 or var_83_6 * (utf8.len(var_83_8) / 9)

				if (9 <= 0 and var_83_6 or var_83_6 * (utf8.len(var_83_8) / 9)) > 0 and var_83_6 < var_83_10 then
					arg_80_1.talkMaxDuration = var_83_10

					if var_83_10 + var_83_5 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_10 + var_83_5
					end
				end

				arg_80_1.text_.text = var_83_8
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261019", "story_v_out_417261.awb") ~= 0 then
					local var_83_11 = manager.audio:GetVoiceLength("story_v_out_417261", "417261019", "story_v_out_417261.awb") / 1000

					if var_83_11 + var_83_5 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_11 + var_83_5
					end

					if var_83_7.prefab_name ~= "" and arg_80_1.actors_[var_83_7.prefab_name] ~= nil then
						local var_83_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_7.prefab_name].transform, "story_v_out_417261", "417261019", "story_v_out_417261.awb")

						arg_80_1:RecordAudio("417261019", var_83_12)
						arg_80_1:RecordAudio("417261019", var_83_12)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_417261", "417261019", "story_v_out_417261.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_417261", "417261019", "story_v_out_417261.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_13 = math.max(var_83_6, arg_80_1.talkMaxDuration)

			if var_83_5 <= arg_80_1.time_ and arg_80_1.time_ < var_83_5 + var_83_13 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_5) / var_83_13

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_5 + var_83_13 and arg_80_1.time_ < var_83_5 + var_83_13 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play417261020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 417261020
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play417261021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos1034 = arg_84_1.actors_["1034"].transform.localPosition
				arg_84_1.actors_["1034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_84_1:CheckSpriteTmpPos("1034", 7)

				for iter_87_0 = 0, arg_84_1.actors_["1034"].transform.childCount - 1 do
					local var_87_0 = arg_84_1.actors_["1034"].transform:GetChild(iter_87_0)

					if var_87_0.name == "" or not string.find(var_87_0.name, "split") then
						var_87_0.gameObject:SetActive(true)
					else
						var_87_0.gameObject:SetActive(false)
					end
				end
			end

			local var_87_1 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_1 then
				arg_84_1.actors_["1034"].transform.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_84_1.time_ - 0) / var_87_1)
			end

			if arg_84_1.time_ >= 0 + var_87_1 and arg_84_1.time_ < 0 + var_87_1 + arg_87_0 then
				arg_84_1.actors_["1034"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.624999999999 < arg_84_1.time_ and arg_84_1.time_ <= 0.624999999999 + arg_87_0 then
				arg_84_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_partypopper", "")
			end

			local var_87_3 = 0
			local var_87_4 = 1.625

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_3 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_5 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(417261020).content)

				arg_84_1.text_.text = var_87_5

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_7 = 65 <= 0 and var_87_4 or var_87_4 * (utf8.len(var_87_5) / 65)

				if (65 <= 0 and var_87_4 or var_87_4 * (utf8.len(var_87_5) / 65)) > 0 and var_87_4 < var_87_7 then
					arg_84_1.talkMaxDuration = var_87_7

					if var_87_7 + var_87_3 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_7 + var_87_3
					end
				end

				arg_84_1.text_.text = var_87_5
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_8 = math.max(var_87_4, arg_84_1.talkMaxDuration)

			if var_87_3 <= arg_84_1.time_ and arg_84_1.time_ < var_87_3 + var_87_8 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_3) / var_87_8

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_3 + var_87_8 and arg_84_1.time_ < var_87_3 + var_87_8 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play417261021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 417261021
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play417261022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 1.325

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

				local var_91_1 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(417261021).content)

				arg_88_1.text_.text = var_91_1

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_3 = 53 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 53)

				if (53 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 53)) > 0 and var_91_0 < var_91_3 then
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
	Play417261022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 417261022
		arg_92_1.duration_ = 5.53

		local var_92_0 = {
			zh = 2.833,
			ja = 5.533
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
				arg_92_0:Play417261023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if arg_92_1.actors_["10111"] == nil then
				local var_95_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10111")

				if not isNil(var_95_0) then
					local var_95_1 = Object.Instantiate(var_95_0, arg_92_1.canvasGo_.transform)

					var_95_1.transform:SetSiblingIndex(1)

					var_95_1.name = "10111"
					var_95_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_92_1.actors_["10111"] = var_95_1

					if arg_92_1.isInRecall_ then
						for iter_95_0, iter_95_1 in ipairs((var_95_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_95_1.color = arg_92_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_95_2 = arg_92_1.actors_["10111"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_2) and arg_92_1.var_.actorSpriteComps10111 == nil then
				arg_92_1.var_.actorSpriteComps10111 = var_95_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_95_3 = 0.2

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_3 and not isNil(var_95_2) then
				if arg_92_1.var_.actorSpriteComps10111 then
					for iter_95_2, iter_95_3 in pairs(arg_92_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_95_3 then
							if arg_92_1.isInRecall_ then
								iter_95_3.color = Color.New(Mathf.Lerp(iter_95_3.color.r, arg_92_1.hightColor1.r, (arg_92_1.time_ - 0) / var_95_3), Mathf.Lerp(iter_95_3.color.g, arg_92_1.hightColor1.g, (arg_92_1.time_ - 0) / var_95_3), (Mathf.Lerp(iter_95_3.color.b, arg_92_1.hightColor1.b, (arg_92_1.time_ - 0) / var_95_3)))
							else
								local var_95_4 = Mathf.Lerp(iter_95_3.color.r, 1, (arg_92_1.time_ - 0) / var_95_3)

								iter_95_3.color = Color.New(var_95_4, var_95_4, var_95_4)
							end
						end
					end
				end
			end

			if arg_92_1.time_ >= 0 + var_95_3 and arg_92_1.time_ < 0 + var_95_3 + arg_95_0 and not isNil(var_95_2) and arg_92_1.var_.actorSpriteComps10111 then
				for iter_95_4, iter_95_5 in pairs(arg_92_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_95_5 then
						iter_95_5.color = arg_92_1.isInRecall_ and (arg_92_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_92_1.var_.actorSpriteComps10111 = nil
			end

			local var_95_5 = arg_92_1.actors_["10111"].transform

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos10111 = var_95_5.localPosition
				var_95_5.localScale = Vector3.New(1, 1, 1)

				arg_92_1:CheckSpriteTmpPos("10111", 3)

				for iter_95_6 = 0, var_95_5.childCount - 1 do
					local var_95_6 = var_95_5:GetChild(iter_95_6)

					if var_95_6.name == "split_2" or not string.find(var_95_6.name, "split") then
						var_95_6.gameObject:SetActive(true)
					else
						var_95_6.gameObject:SetActive(false)
					end
				end
			end

			local var_95_7 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_7 then
				var_95_5.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10111, Vector3.New(0, -361.1, -274.6), (arg_92_1.time_ - 0) / var_95_7)
			end

			if arg_92_1.time_ >= 0 + var_95_7 and arg_92_1.time_ < 0 + var_95_7 + arg_95_0 then
				var_95_5.localPosition = Vector3.New(0, -361.1, -274.6)
			end

			local var_95_8 = 0
			local var_95_9 = 0.275

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_8 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_10 = arg_92_1:GetWordFromCfg(417261022)
				local var_95_11 = arg_92_1:FormatText(var_95_10.content)

				arg_92_1.text_.text = var_95_11

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_13 = 11 <= 0 and var_95_9 or var_95_9 * (utf8.len(var_95_11) / 11)

				if (11 <= 0 and var_95_9 or var_95_9 * (utf8.len(var_95_11) / 11)) > 0 and var_95_9 < var_95_13 then
					arg_92_1.talkMaxDuration = var_95_13

					if var_95_13 + var_95_8 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_13 + var_95_8
					end
				end

				arg_92_1.text_.text = var_95_11
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261022", "story_v_out_417261.awb") ~= 0 then
					local var_95_14 = manager.audio:GetVoiceLength("story_v_out_417261", "417261022", "story_v_out_417261.awb") / 1000

					if var_95_14 + var_95_8 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_14 + var_95_8
					end

					if var_95_10.prefab_name ~= "" and arg_92_1.actors_[var_95_10.prefab_name] ~= nil then
						local var_95_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_10.prefab_name].transform, "story_v_out_417261", "417261022", "story_v_out_417261.awb")

						arg_92_1:RecordAudio("417261022", var_95_15)
						arg_92_1:RecordAudio("417261022", var_95_15)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_417261", "417261022", "story_v_out_417261.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_417261", "417261022", "story_v_out_417261.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_16 = math.max(var_95_9, arg_92_1.talkMaxDuration)

			if var_95_8 <= arg_92_1.time_ and arg_92_1.time_ < var_95_8 + var_95_16 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_8) / var_95_16

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_8 + var_95_16 and arg_92_1.time_ < var_95_8 + var_95_16 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play417261023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 417261023
		arg_96_1.duration_ = 4.4

		local var_96_0 = {
			zh = 2.8,
			ja = 4.4
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
				arg_96_0:Play417261024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["10111"]) and arg_96_1.var_.actorSpriteComps10111 == nil then
				arg_96_1.var_.actorSpriteComps10111 = arg_96_1.actors_["10111"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_99_0 = 0.2

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["10111"]) then
				if arg_96_1.var_.actorSpriteComps10111 then
					for iter_99_0, iter_99_1 in pairs(arg_96_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_99_1 then
							if arg_96_1.isInRecall_ then
								iter_99_1.color = Color.New(Mathf.Lerp(iter_99_1.color.r, arg_96_1.hightColor2.r, (arg_96_1.time_ - 0) / var_99_0), Mathf.Lerp(iter_99_1.color.g, arg_96_1.hightColor2.g, (arg_96_1.time_ - 0) / var_99_0), (Mathf.Lerp(iter_99_1.color.b, arg_96_1.hightColor2.b, (arg_96_1.time_ - 0) / var_99_0)))
							else
								local var_99_1 = Mathf.Lerp(iter_99_1.color.r, 0.5, (arg_96_1.time_ - 0) / var_99_0)

								iter_99_1.color = Color.New(var_99_1, var_99_1, var_99_1)
							end
						end
					end
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["10111"]) and arg_96_1.var_.actorSpriteComps10111 then
				for iter_99_2, iter_99_3 in pairs(arg_96_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_99_3 then
						iter_99_3.color = arg_96_1.isInRecall_ and (arg_96_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_96_1.var_.actorSpriteComps10111 = nil
			end

			local var_99_2 = arg_96_1.actors_["1034"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_2) and arg_96_1.var_.actorSpriteComps1034 == nil then
				arg_96_1.var_.actorSpriteComps1034 = var_99_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_99_3 = 0.2

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_3 and not isNil(var_99_2) then
				if arg_96_1.var_.actorSpriteComps1034 then
					for iter_99_4, iter_99_5 in pairs(arg_96_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_99_5 then
							if arg_96_1.isInRecall_ then
								iter_99_5.color = Color.New(Mathf.Lerp(iter_99_5.color.r, arg_96_1.hightColor1.r, (arg_96_1.time_ - 0) / var_99_3), Mathf.Lerp(iter_99_5.color.g, arg_96_1.hightColor1.g, (arg_96_1.time_ - 0) / var_99_3), (Mathf.Lerp(iter_99_5.color.b, arg_96_1.hightColor1.b, (arg_96_1.time_ - 0) / var_99_3)))
							else
								local var_99_4 = Mathf.Lerp(iter_99_5.color.r, 1, (arg_96_1.time_ - 0) / var_99_3)

								iter_99_5.color = Color.New(var_99_4, var_99_4, var_99_4)
							end
						end
					end
				end
			end

			if arg_96_1.time_ >= 0 + var_99_3 and arg_96_1.time_ < 0 + var_99_3 + arg_99_0 and not isNil(var_99_2) and arg_96_1.var_.actorSpriteComps1034 then
				for iter_99_6, iter_99_7 in pairs(arg_96_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_99_7 then
						iter_99_7.color = arg_96_1.isInRecall_ and (arg_96_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_96_1.var_.actorSpriteComps1034 = nil
			end

			local var_99_5 = arg_96_1.actors_["1034"].transform

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos1034 = var_99_5.localPosition
				var_99_5.localScale = Vector3.New(1, 1, 1)

				arg_96_1:CheckSpriteTmpPos("1034", 4)

				for iter_99_8 = 0, var_99_5.childCount - 1 do
					local var_99_6 = var_99_5:GetChild(iter_99_8)

					if var_99_6.name == "split_1" or not string.find(var_99_6.name, "split") then
						var_99_6.gameObject:SetActive(true)
					else
						var_99_6.gameObject:SetActive(false)
					end
				end
			end

			local var_99_7 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_7 then
				var_99_5.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1034, Vector3.New(373.7, -331.9, -324), (arg_96_1.time_ - 0) / var_99_7)
			end

			if arg_96_1.time_ >= 0 + var_99_7 and arg_96_1.time_ < 0 + var_99_7 + arg_99_0 then
				var_99_5.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_99_8 = arg_96_1.actors_["10111"].transform

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos10111 = var_99_8.localPosition
				var_99_8.localScale = Vector3.New(1, 1, 1)

				arg_96_1:CheckSpriteTmpPos("10111", 2)

				for iter_99_9 = 0, var_99_8.childCount - 1 do
					local var_99_9 = var_99_8:GetChild(iter_99_9)

					if var_99_9.name == "" or not string.find(var_99_9.name, "split") then
						var_99_9.gameObject:SetActive(true)
					else
						var_99_9.gameObject:SetActive(false)
					end
				end
			end

			local var_99_10 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_10 then
				var_99_8.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos10111, Vector3.New(-390, -361.1, -274.6), (arg_96_1.time_ - 0) / var_99_10)
			end

			if arg_96_1.time_ >= 0 + var_99_10 and arg_96_1.time_ < 0 + var_99_10 + arg_99_0 then
				var_99_8.localPosition = Vector3.New(-390, -361.1, -274.6)
			end

			local var_99_11 = 0
			local var_99_12 = 0.225

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_11 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_13 = arg_96_1:GetWordFromCfg(417261023)
				local var_99_14 = arg_96_1:FormatText(var_99_13.content)

				arg_96_1.text_.text = var_99_14

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_16 = 9 <= 0 and var_99_12 or var_99_12 * (utf8.len(var_99_14) / 9)

				if (9 <= 0 and var_99_12 or var_99_12 * (utf8.len(var_99_14) / 9)) > 0 and var_99_12 < var_99_16 then
					arg_96_1.talkMaxDuration = var_99_16

					if var_99_16 + var_99_11 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_16 + var_99_11
					end
				end

				arg_96_1.text_.text = var_99_14
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261023", "story_v_out_417261.awb") ~= 0 then
					local var_99_17 = manager.audio:GetVoiceLength("story_v_out_417261", "417261023", "story_v_out_417261.awb") / 1000

					if var_99_17 + var_99_11 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_17 + var_99_11
					end

					if var_99_13.prefab_name ~= "" and arg_96_1.actors_[var_99_13.prefab_name] ~= nil then
						local var_99_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_13.prefab_name].transform, "story_v_out_417261", "417261023", "story_v_out_417261.awb")

						arg_96_1:RecordAudio("417261023", var_99_18)
						arg_96_1:RecordAudio("417261023", var_99_18)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_417261", "417261023", "story_v_out_417261.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_417261", "417261023", "story_v_out_417261.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_19 = math.max(var_99_12, arg_96_1.talkMaxDuration)

			if var_99_11 <= arg_96_1.time_ and arg_96_1.time_ < var_99_11 + var_99_19 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_11) / var_99_19

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_11 + var_99_19 and arg_96_1.time_ < var_99_11 + var_99_19 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play417261024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 417261024
		arg_100_1.duration_ = 5.23

		local var_100_0 = {
			zh = 4.333,
			ja = 5.233
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
				arg_100_0:Play417261025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["10111"]) and arg_100_1.var_.actorSpriteComps10111 == nil then
				arg_100_1.var_.actorSpriteComps10111 = arg_100_1.actors_["10111"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_103_0 = 0.2

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["10111"]) then
				if arg_100_1.var_.actorSpriteComps10111 then
					for iter_103_0, iter_103_1 in pairs(arg_100_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_103_1 then
							if arg_100_1.isInRecall_ then
								iter_103_1.color = Color.New(Mathf.Lerp(iter_103_1.color.r, arg_100_1.hightColor1.r, (arg_100_1.time_ - 0) / var_103_0), Mathf.Lerp(iter_103_1.color.g, arg_100_1.hightColor1.g, (arg_100_1.time_ - 0) / var_103_0), (Mathf.Lerp(iter_103_1.color.b, arg_100_1.hightColor1.b, (arg_100_1.time_ - 0) / var_103_0)))
							else
								local var_103_1 = Mathf.Lerp(iter_103_1.color.r, 1, (arg_100_1.time_ - 0) / var_103_0)

								iter_103_1.color = Color.New(var_103_1, var_103_1, var_103_1)
							end
						end
					end
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["10111"]) and arg_100_1.var_.actorSpriteComps10111 then
				for iter_103_2, iter_103_3 in pairs(arg_100_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_103_3 then
						iter_103_3.color = arg_100_1.isInRecall_ and (arg_100_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_100_1.var_.actorSpriteComps10111 = nil
			end

			local var_103_2 = arg_100_1.actors_["1034"]

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(var_103_2) and arg_100_1.var_.actorSpriteComps1034 == nil then
				arg_100_1.var_.actorSpriteComps1034 = var_103_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_103_3 = 0.2

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_3 and not isNil(var_103_2) then
				if arg_100_1.var_.actorSpriteComps1034 then
					for iter_103_4, iter_103_5 in pairs(arg_100_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_103_5 then
							if arg_100_1.isInRecall_ then
								iter_103_5.color = Color.New(Mathf.Lerp(iter_103_5.color.r, arg_100_1.hightColor2.r, (arg_100_1.time_ - 0) / var_103_3), Mathf.Lerp(iter_103_5.color.g, arg_100_1.hightColor2.g, (arg_100_1.time_ - 0) / var_103_3), (Mathf.Lerp(iter_103_5.color.b, arg_100_1.hightColor2.b, (arg_100_1.time_ - 0) / var_103_3)))
							else
								local var_103_4 = Mathf.Lerp(iter_103_5.color.r, 0.5, (arg_100_1.time_ - 0) / var_103_3)

								iter_103_5.color = Color.New(var_103_4, var_103_4, var_103_4)
							end
						end
					end
				end
			end

			if arg_100_1.time_ >= 0 + var_103_3 and arg_100_1.time_ < 0 + var_103_3 + arg_103_0 and not isNil(var_103_2) and arg_100_1.var_.actorSpriteComps1034 then
				for iter_103_6, iter_103_7 in pairs(arg_100_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_103_7 then
						iter_103_7.color = arg_100_1.isInRecall_ and (arg_100_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_100_1.var_.actorSpriteComps1034 = nil
			end

			local var_103_5 = arg_100_1.actors_["10111"].transform

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos10111 = var_103_5.localPosition
				var_103_5.localScale = Vector3.New(1, 1, 1)

				arg_100_1:CheckSpriteTmpPos("10111", 2)

				for iter_103_8 = 0, var_103_5.childCount - 1 do
					local var_103_6 = var_103_5:GetChild(iter_103_8)

					if var_103_6.name == "split_4" or not string.find(var_103_6.name, "split") then
						var_103_6.gameObject:SetActive(true)
					else
						var_103_6.gameObject:SetActive(false)
					end
				end
			end

			local var_103_7 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_7 then
				var_103_5.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos10111, Vector3.New(-390, -361.1, -274.6), (arg_100_1.time_ - 0) / var_103_7)
			end

			if arg_100_1.time_ >= 0 + var_103_7 and arg_100_1.time_ < 0 + var_103_7 + arg_103_0 then
				var_103_5.localPosition = Vector3.New(-390, -361.1, -274.6)
			end

			local var_103_8 = 0
			local var_103_9 = 0.55

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_8 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_10 = arg_100_1:GetWordFromCfg(417261024)
				local var_103_11 = arg_100_1:FormatText(var_103_10.content)

				arg_100_1.text_.text = var_103_11

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_13 = 22 <= 0 and var_103_9 or var_103_9 * (utf8.len(var_103_11) / 22)

				if (22 <= 0 and var_103_9 or var_103_9 * (utf8.len(var_103_11) / 22)) > 0 and var_103_9 < var_103_13 then
					arg_100_1.talkMaxDuration = var_103_13

					if var_103_13 + var_103_8 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_13 + var_103_8
					end
				end

				arg_100_1.text_.text = var_103_11
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261024", "story_v_out_417261.awb") ~= 0 then
					local var_103_14 = manager.audio:GetVoiceLength("story_v_out_417261", "417261024", "story_v_out_417261.awb") / 1000

					if var_103_14 + var_103_8 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_14 + var_103_8
					end

					if var_103_10.prefab_name ~= "" and arg_100_1.actors_[var_103_10.prefab_name] ~= nil then
						local var_103_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_10.prefab_name].transform, "story_v_out_417261", "417261024", "story_v_out_417261.awb")

						arg_100_1:RecordAudio("417261024", var_103_15)
						arg_100_1:RecordAudio("417261024", var_103_15)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_417261", "417261024", "story_v_out_417261.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_417261", "417261024", "story_v_out_417261.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_16 = math.max(var_103_9, arg_100_1.talkMaxDuration)

			if var_103_8 <= arg_100_1.time_ and arg_100_1.time_ < var_103_8 + var_103_16 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_8) / var_103_16

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_8 + var_103_16 and arg_100_1.time_ < var_103_8 + var_103_16 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play417261025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 417261025
		arg_104_1.duration_ = 2.67

		local var_104_0 = {
			zh = 1.933,
			ja = 2.666
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
				arg_104_0:Play417261026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if arg_104_1.actors_["1095"] == nil then
				local var_107_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1095")

				if not isNil(var_107_0) then
					local var_107_1 = Object.Instantiate(var_107_0, arg_104_1.canvasGo_.transform)

					var_107_1.transform:SetSiblingIndex(1)

					var_107_1.name = "1095"
					var_107_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_104_1.actors_["1095"] = var_107_1

					if arg_104_1.isInRecall_ then
						for iter_107_0, iter_107_1 in ipairs((var_107_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_107_1.color = arg_104_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_107_2 = arg_104_1.actors_["1095"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_2) and arg_104_1.var_.actorSpriteComps1095 == nil then
				arg_104_1.var_.actorSpriteComps1095 = var_107_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_3 = 0.2

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_3 and not isNil(var_107_2) then
				if arg_104_1.var_.actorSpriteComps1095 then
					for iter_107_2, iter_107_3 in pairs(arg_104_1.var_.actorSpriteComps1095:ToTable()) do
						if iter_107_3 then
							if arg_104_1.isInRecall_ then
								iter_107_3.color = Color.New(Mathf.Lerp(iter_107_3.color.r, arg_104_1.hightColor1.r, (arg_104_1.time_ - 0) / var_107_3), Mathf.Lerp(iter_107_3.color.g, arg_104_1.hightColor1.g, (arg_104_1.time_ - 0) / var_107_3), (Mathf.Lerp(iter_107_3.color.b, arg_104_1.hightColor1.b, (arg_104_1.time_ - 0) / var_107_3)))
							else
								local var_107_4 = Mathf.Lerp(iter_107_3.color.r, 1, (arg_104_1.time_ - 0) / var_107_3)

								iter_107_3.color = Color.New(var_107_4, var_107_4, var_107_4)
							end
						end
					end
				end
			end

			if arg_104_1.time_ >= 0 + var_107_3 and arg_104_1.time_ < 0 + var_107_3 + arg_107_0 and not isNil(var_107_2) and arg_104_1.var_.actorSpriteComps1095 then
				for iter_107_4, iter_107_5 in pairs(arg_104_1.var_.actorSpriteComps1095:ToTable()) do
					if iter_107_5 then
						iter_107_5.color = arg_104_1.isInRecall_ and (arg_104_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_104_1.var_.actorSpriteComps1095 = nil
			end

			local var_107_5 = arg_104_1.actors_["10111"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_5) and arg_104_1.var_.actorSpriteComps10111 == nil then
				arg_104_1.var_.actorSpriteComps10111 = var_107_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_6 = 0.2

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_6 and not isNil(var_107_5) then
				if arg_104_1.var_.actorSpriteComps10111 then
					for iter_107_6, iter_107_7 in pairs(arg_104_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_107_7 then
							if arg_104_1.isInRecall_ then
								iter_107_7.color = Color.New(Mathf.Lerp(iter_107_7.color.r, arg_104_1.hightColor2.r, (arg_104_1.time_ - 0) / var_107_6), Mathf.Lerp(iter_107_7.color.g, arg_104_1.hightColor2.g, (arg_104_1.time_ - 0) / var_107_6), (Mathf.Lerp(iter_107_7.color.b, arg_104_1.hightColor2.b, (arg_104_1.time_ - 0) / var_107_6)))
							else
								local var_107_7 = Mathf.Lerp(iter_107_7.color.r, 0.5, (arg_104_1.time_ - 0) / var_107_6)

								iter_107_7.color = Color.New(var_107_7, var_107_7, var_107_7)
							end
						end
					end
				end
			end

			if arg_104_1.time_ >= 0 + var_107_6 and arg_104_1.time_ < 0 + var_107_6 + arg_107_0 and not isNil(var_107_5) and arg_104_1.var_.actorSpriteComps10111 then
				for iter_107_8, iter_107_9 in pairs(arg_104_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_107_9 then
						iter_107_9.color = arg_104_1.isInRecall_ and (arg_104_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_104_1.var_.actorSpriteComps10111 = nil
			end

			local var_107_8 = arg_104_1.actors_["1034"].transform

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1034 = var_107_8.localPosition
				var_107_8.localScale = Vector3.New(1, 1, 1)

				arg_104_1:CheckSpriteTmpPos("1034", 7)

				for iter_107_10 = 0, var_107_8.childCount - 1 do
					local var_107_9 = var_107_8:GetChild(iter_107_10)

					if var_107_9.name == "" or not string.find(var_107_9.name, "split") then
						var_107_9.gameObject:SetActive(true)
					else
						var_107_9.gameObject:SetActive(false)
					end
				end
			end

			local var_107_10 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_10 then
				var_107_8.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_104_1.time_ - 0) / var_107_10)
			end

			if arg_104_1.time_ >= 0 + var_107_10 and arg_104_1.time_ < 0 + var_107_10 + arg_107_0 then
				var_107_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_107_11 = arg_104_1.actors_["1095"].transform

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1095 = var_107_11.localPosition
				var_107_11.localScale = Vector3.New(1, 1, 1)

				arg_104_1:CheckSpriteTmpPos("1095", 4)

				for iter_107_11 = 0, var_107_11.childCount - 1 do
					local var_107_12 = var_107_11:GetChild(iter_107_11)

					if var_107_12.name == "split_2" or not string.find(var_107_12.name, "split") then
						var_107_12.gameObject:SetActive(true)
					else
						var_107_12.gameObject:SetActive(false)
					end
				end
			end

			local var_107_13 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_13 then
				var_107_11.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1095, Vector3.New(390, -340, -285), (arg_104_1.time_ - 0) / var_107_13)
			end

			if arg_104_1.time_ >= 0 + var_107_13 and arg_104_1.time_ < 0 + var_107_13 + arg_107_0 then
				var_107_11.localPosition = Vector3.New(390, -340, -285)
			end

			local var_107_14 = 0
			local var_107_15 = 0.175

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_14 + arg_107_0 then
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

				local var_107_16 = arg_104_1:GetWordFromCfg(417261025)
				local var_107_17 = arg_104_1:FormatText(var_107_16.content)

				arg_104_1.text_.text = var_107_17

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_19 = 7 <= 0 and var_107_15 or var_107_15 * (utf8.len(var_107_17) / 7)

				if (7 <= 0 and var_107_15 or var_107_15 * (utf8.len(var_107_17) / 7)) > 0 and var_107_15 < var_107_19 then
					arg_104_1.talkMaxDuration = var_107_19

					if var_107_19 + var_107_14 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_19 + var_107_14
					end
				end

				arg_104_1.text_.text = var_107_17
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261025", "story_v_out_417261.awb") ~= 0 then
					local var_107_20 = manager.audio:GetVoiceLength("story_v_out_417261", "417261025", "story_v_out_417261.awb") / 1000

					if var_107_20 + var_107_14 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_20 + var_107_14
					end

					if var_107_16.prefab_name ~= "" and arg_104_1.actors_[var_107_16.prefab_name] ~= nil then
						local var_107_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_16.prefab_name].transform, "story_v_out_417261", "417261025", "story_v_out_417261.awb")

						arg_104_1:RecordAudio("417261025", var_107_21)
						arg_104_1:RecordAudio("417261025", var_107_21)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_417261", "417261025", "story_v_out_417261.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_417261", "417261025", "story_v_out_417261.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_22 = math.max(var_107_15, arg_104_1.talkMaxDuration)

			if var_107_14 <= arg_104_1.time_ and arg_104_1.time_ < var_107_14 + var_107_22 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_14) / var_107_22

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_14 + var_107_22 and arg_104_1.time_ < var_107_14 + var_107_22 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1095",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play417261026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 417261026
		arg_108_1.duration_ = 7.67

		local var_108_0 = {
			zh = 4.333,
			ja = 7.666
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
				arg_108_0:Play417261027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos1095 = arg_108_1.actors_["1095"].transform.localPosition
				arg_108_1.actors_["1095"].transform.localScale = Vector3.New(1, 1, 1)

				arg_108_1:CheckSpriteTmpPos("1095", 7)

				for iter_111_0 = 0, arg_108_1.actors_["1095"].transform.childCount - 1 do
					local var_111_0 = arg_108_1.actors_["1095"].transform:GetChild(iter_111_0)

					if var_111_0.name == "" or not string.find(var_111_0.name, "split") then
						var_111_0.gameObject:SetActive(true)
					else
						var_111_0.gameObject:SetActive(false)
					end
				end
			end

			local var_111_1 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_1 then
				arg_108_1.actors_["1095"].transform.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1095, Vector3.New(0, -2000, 0), (arg_108_1.time_ - 0) / var_111_1)
			end

			if arg_108_1.time_ >= 0 + var_111_1 and arg_108_1.time_ < 0 + var_111_1 + arg_111_0 then
				arg_108_1.actors_["1095"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_111_2 = arg_108_1.actors_["1034"].transform

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos1034 = var_111_2.localPosition
				var_111_2.localScale = Vector3.New(1, 1, 1)

				arg_108_1:CheckSpriteTmpPos("1034", 4)

				for iter_111_1 = 0, var_111_2.childCount - 1 do
					local var_111_3 = var_111_2:GetChild(iter_111_1)

					if var_111_3.name == "" or not string.find(var_111_3.name, "split") then
						var_111_3.gameObject:SetActive(true)
					else
						var_111_3.gameObject:SetActive(false)
					end
				end
			end

			local var_111_4 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_4 then
				var_111_2.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1034, Vector3.New(373.7, -331.9, -324), (arg_108_1.time_ - 0) / var_111_4)
			end

			if arg_108_1.time_ >= 0 + var_111_4 and arg_108_1.time_ < 0 + var_111_4 + arg_111_0 then
				var_111_2.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_111_5 = arg_108_1.actors_["1034"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_5) and arg_108_1.var_.actorSpriteComps1034 == nil then
				arg_108_1.var_.actorSpriteComps1034 = var_111_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_6 = 0.2

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_6 and not isNil(var_111_5) then
				if arg_108_1.var_.actorSpriteComps1034 then
					for iter_111_2, iter_111_3 in pairs(arg_108_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_111_3 then
							if arg_108_1.isInRecall_ then
								iter_111_3.color = Color.New(Mathf.Lerp(iter_111_3.color.r, arg_108_1.hightColor1.r, (arg_108_1.time_ - 0) / var_111_6), Mathf.Lerp(iter_111_3.color.g, arg_108_1.hightColor1.g, (arg_108_1.time_ - 0) / var_111_6), (Mathf.Lerp(iter_111_3.color.b, arg_108_1.hightColor1.b, (arg_108_1.time_ - 0) / var_111_6)))
							else
								local var_111_7 = Mathf.Lerp(iter_111_3.color.r, 1, (arg_108_1.time_ - 0) / var_111_6)

								iter_111_3.color = Color.New(var_111_7, var_111_7, var_111_7)
							end
						end
					end
				end
			end

			if arg_108_1.time_ >= 0 + var_111_6 and arg_108_1.time_ < 0 + var_111_6 + arg_111_0 and not isNil(var_111_5) and arg_108_1.var_.actorSpriteComps1034 then
				for iter_111_4, iter_111_5 in pairs(arg_108_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_111_5 then
						iter_111_5.color = arg_108_1.isInRecall_ and (arg_108_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_108_1.var_.actorSpriteComps1034 = nil
			end

			local var_111_8 = 0
			local var_111_9 = 0.625

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_8 + arg_111_0 then
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

				local var_111_10 = arg_108_1:GetWordFromCfg(417261026)
				local var_111_11 = arg_108_1:FormatText(var_111_10.content)

				arg_108_1.text_.text = var_111_11

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_13 = 25 <= 0 and var_111_9 or var_111_9 * (utf8.len(var_111_11) / 25)

				if (25 <= 0 and var_111_9 or var_111_9 * (utf8.len(var_111_11) / 25)) > 0 and var_111_9 < var_111_13 then
					arg_108_1.talkMaxDuration = var_111_13

					if var_111_13 + var_111_8 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_13 + var_111_8
					end
				end

				arg_108_1.text_.text = var_111_11
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261026", "story_v_out_417261.awb") ~= 0 then
					local var_111_14 = manager.audio:GetVoiceLength("story_v_out_417261", "417261026", "story_v_out_417261.awb") / 1000

					if var_111_14 + var_111_8 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_14 + var_111_8
					end

					if var_111_10.prefab_name ~= "" and arg_108_1.actors_[var_111_10.prefab_name] ~= nil then
						local var_111_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_10.prefab_name].transform, "story_v_out_417261", "417261026", "story_v_out_417261.awb")

						arg_108_1:RecordAudio("417261026", var_111_15)
						arg_108_1:RecordAudio("417261026", var_111_15)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_417261", "417261026", "story_v_out_417261.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_417261", "417261026", "story_v_out_417261.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_16 = math.max(var_111_9, arg_108_1.talkMaxDuration)

			if var_111_8 <= arg_108_1.time_ and arg_108_1.time_ < var_111_8 + var_111_16 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_8) / var_111_16

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_8 + var_111_16 and arg_108_1.time_ < var_111_8 + var_111_16 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play417261027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 417261027
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play417261028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["1034"]) and arg_112_1.var_.actorSpriteComps1034 == nil then
				arg_112_1.var_.actorSpriteComps1034 = arg_112_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_0 = 0.2

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["1034"]) then
				if arg_112_1.var_.actorSpriteComps1034 then
					for iter_115_0, iter_115_1 in pairs(arg_112_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_115_1 then
							if arg_112_1.isInRecall_ then
								iter_115_1.color = Color.New(Mathf.Lerp(iter_115_1.color.r, arg_112_1.hightColor2.r, (arg_112_1.time_ - 0) / var_115_0), Mathf.Lerp(iter_115_1.color.g, arg_112_1.hightColor2.g, (arg_112_1.time_ - 0) / var_115_0), (Mathf.Lerp(iter_115_1.color.b, arg_112_1.hightColor2.b, (arg_112_1.time_ - 0) / var_115_0)))
							else
								local var_115_1 = Mathf.Lerp(iter_115_1.color.r, 0.5, (arg_112_1.time_ - 0) / var_115_0)

								iter_115_1.color = Color.New(var_115_1, var_115_1, var_115_1)
							end
						end
					end
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["1034"]) and arg_112_1.var_.actorSpriteComps1034 then
				for iter_115_2, iter_115_3 in pairs(arg_112_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_115_3 then
						iter_115_3.color = arg_112_1.isInRecall_ and (arg_112_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_112_1.var_.actorSpriteComps1034 = nil
			end

			local var_115_2 = 0
			local var_115_3 = 1

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_2 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_4 = arg_112_1:FormatText(arg_112_1:GetWordFromCfg(417261027).content)

				arg_112_1.text_.text = var_115_4

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_6 = 40 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_4) / 40)

				if (40 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_4) / 40)) > 0 and var_115_3 < var_115_6 then
					arg_112_1.talkMaxDuration = var_115_6

					if var_115_6 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_6 + var_115_2
					end
				end

				arg_112_1.text_.text = var_115_4
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_7 = math.max(var_115_3, arg_112_1.talkMaxDuration)

			if var_115_2 <= arg_112_1.time_ and arg_112_1.time_ < var_115_2 + var_115_7 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_2) / var_115_7

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_2 + var_115_7 and arg_112_1.time_ < var_115_2 + var_115_7 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play417261028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 417261028
		arg_116_1.duration_ = 7.3

		local var_116_0 = {
			zh = 2.833,
			ja = 7.3
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
				arg_116_0:Play417261029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["1034"]) and arg_116_1.var_.actorSpriteComps1034 == nil then
				arg_116_1.var_.actorSpriteComps1034 = arg_116_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_0 = 0.2

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["1034"]) then
				if arg_116_1.var_.actorSpriteComps1034 then
					for iter_119_0, iter_119_1 in pairs(arg_116_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_119_1 then
							if arg_116_1.isInRecall_ then
								iter_119_1.color = Color.New(Mathf.Lerp(iter_119_1.color.r, arg_116_1.hightColor1.r, (arg_116_1.time_ - 0) / var_119_0), Mathf.Lerp(iter_119_1.color.g, arg_116_1.hightColor1.g, (arg_116_1.time_ - 0) / var_119_0), (Mathf.Lerp(iter_119_1.color.b, arg_116_1.hightColor1.b, (arg_116_1.time_ - 0) / var_119_0)))
							else
								local var_119_1 = Mathf.Lerp(iter_119_1.color.r, 1, (arg_116_1.time_ - 0) / var_119_0)

								iter_119_1.color = Color.New(var_119_1, var_119_1, var_119_1)
							end
						end
					end
				end
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["1034"]) and arg_116_1.var_.actorSpriteComps1034 then
				for iter_119_2, iter_119_3 in pairs(arg_116_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_119_3 then
						iter_119_3.color = arg_116_1.isInRecall_ and (arg_116_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_116_1.var_.actorSpriteComps1034 = nil
			end

			local var_119_2 = 0
			local var_119_3 = 0.375

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_2 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_4 = arg_116_1:GetWordFromCfg(417261028)
				local var_119_5 = arg_116_1:FormatText(var_119_4.content)

				arg_116_1.text_.text = var_119_5

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_7 = 15 <= 0 and var_119_3 or var_119_3 * (utf8.len(var_119_5) / 15)

				if (15 <= 0 and var_119_3 or var_119_3 * (utf8.len(var_119_5) / 15)) > 0 and var_119_3 < var_119_7 then
					arg_116_1.talkMaxDuration = var_119_7

					if var_119_7 + var_119_2 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_7 + var_119_2
					end
				end

				arg_116_1.text_.text = var_119_5
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261028", "story_v_out_417261.awb") ~= 0 then
					local var_119_8 = manager.audio:GetVoiceLength("story_v_out_417261", "417261028", "story_v_out_417261.awb") / 1000

					if var_119_8 + var_119_2 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_8 + var_119_2
					end

					if var_119_4.prefab_name ~= "" and arg_116_1.actors_[var_119_4.prefab_name] ~= nil then
						local var_119_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_4.prefab_name].transform, "story_v_out_417261", "417261028", "story_v_out_417261.awb")

						arg_116_1:RecordAudio("417261028", var_119_9)
						arg_116_1:RecordAudio("417261028", var_119_9)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_417261", "417261028", "story_v_out_417261.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_417261", "417261028", "story_v_out_417261.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_10 = math.max(var_119_3, arg_116_1.talkMaxDuration)

			if var_119_2 <= arg_116_1.time_ and arg_116_1.time_ < var_119_2 + var_119_10 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_2) / var_119_10

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_2 + var_119_10 and arg_116_1.time_ < var_119_2 + var_119_10 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play417261029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 417261029
		arg_120_1.duration_ = 3.83

		local var_120_0 = {
			zh = 2.333,
			ja = 3.833
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
				arg_120_0:Play417261030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["10111"]) and arg_120_1.var_.actorSpriteComps10111 == nil then
				arg_120_1.var_.actorSpriteComps10111 = arg_120_1.actors_["10111"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_123_0 = 0.2

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["10111"]) then
				if arg_120_1.var_.actorSpriteComps10111 then
					for iter_123_0, iter_123_1 in pairs(arg_120_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_123_1 then
							if arg_120_1.isInRecall_ then
								iter_123_1.color = Color.New(Mathf.Lerp(iter_123_1.color.r, arg_120_1.hightColor1.r, (arg_120_1.time_ - 0) / var_123_0), Mathf.Lerp(iter_123_1.color.g, arg_120_1.hightColor1.g, (arg_120_1.time_ - 0) / var_123_0), (Mathf.Lerp(iter_123_1.color.b, arg_120_1.hightColor1.b, (arg_120_1.time_ - 0) / var_123_0)))
							else
								local var_123_1 = Mathf.Lerp(iter_123_1.color.r, 1, (arg_120_1.time_ - 0) / var_123_0)

								iter_123_1.color = Color.New(var_123_1, var_123_1, var_123_1)
							end
						end
					end
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["10111"]) and arg_120_1.var_.actorSpriteComps10111 then
				for iter_123_2, iter_123_3 in pairs(arg_120_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_123_3 then
						iter_123_3.color = arg_120_1.isInRecall_ and (arg_120_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_120_1.var_.actorSpriteComps10111 = nil
			end

			local var_123_2 = arg_120_1.actors_["1034"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_2) and arg_120_1.var_.actorSpriteComps1034 == nil then
				arg_120_1.var_.actorSpriteComps1034 = var_123_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_123_3 = 0.2

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_3 and not isNil(var_123_2) then
				if arg_120_1.var_.actorSpriteComps1034 then
					for iter_123_4, iter_123_5 in pairs(arg_120_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_123_5 then
							if arg_120_1.isInRecall_ then
								iter_123_5.color = Color.New(Mathf.Lerp(iter_123_5.color.r, arg_120_1.hightColor2.r, (arg_120_1.time_ - 0) / var_123_3), Mathf.Lerp(iter_123_5.color.g, arg_120_1.hightColor2.g, (arg_120_1.time_ - 0) / var_123_3), (Mathf.Lerp(iter_123_5.color.b, arg_120_1.hightColor2.b, (arg_120_1.time_ - 0) / var_123_3)))
							else
								local var_123_4 = Mathf.Lerp(iter_123_5.color.r, 0.5, (arg_120_1.time_ - 0) / var_123_3)

								iter_123_5.color = Color.New(var_123_4, var_123_4, var_123_4)
							end
						end
					end
				end
			end

			if arg_120_1.time_ >= 0 + var_123_3 and arg_120_1.time_ < 0 + var_123_3 + arg_123_0 and not isNil(var_123_2) and arg_120_1.var_.actorSpriteComps1034 then
				for iter_123_6, iter_123_7 in pairs(arg_120_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_123_7 then
						iter_123_7.color = arg_120_1.isInRecall_ and (arg_120_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_120_1.var_.actorSpriteComps1034 = nil
			end

			local var_123_5 = 0
			local var_123_6 = 0.325

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_5 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_7 = arg_120_1:GetWordFromCfg(417261029)
				local var_123_8 = arg_120_1:FormatText(var_123_7.content)

				arg_120_1.text_.text = var_123_8

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_10 = 13 <= 0 and var_123_6 or var_123_6 * (utf8.len(var_123_8) / 13)

				if (13 <= 0 and var_123_6 or var_123_6 * (utf8.len(var_123_8) / 13)) > 0 and var_123_6 < var_123_10 then
					arg_120_1.talkMaxDuration = var_123_10

					if var_123_10 + var_123_5 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_10 + var_123_5
					end
				end

				arg_120_1.text_.text = var_123_8
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261029", "story_v_out_417261.awb") ~= 0 then
					local var_123_11 = manager.audio:GetVoiceLength("story_v_out_417261", "417261029", "story_v_out_417261.awb") / 1000

					if var_123_11 + var_123_5 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_11 + var_123_5
					end

					if var_123_7.prefab_name ~= "" and arg_120_1.actors_[var_123_7.prefab_name] ~= nil then
						local var_123_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_7.prefab_name].transform, "story_v_out_417261", "417261029", "story_v_out_417261.awb")

						arg_120_1:RecordAudio("417261029", var_123_12)
						arg_120_1:RecordAudio("417261029", var_123_12)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_417261", "417261029", "story_v_out_417261.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_417261", "417261029", "story_v_out_417261.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_13 = math.max(var_123_6, arg_120_1.talkMaxDuration)

			if var_123_5 <= arg_120_1.time_ and arg_120_1.time_ < var_123_5 + var_123_13 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_5) / var_123_13

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_5 + var_123_13 and arg_120_1.time_ < var_123_5 + var_123_13 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play417261030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 417261030
		arg_124_1.duration_ = 5.33

		local var_124_0 = {
			zh = 4.366,
			ja = 5.333
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
				arg_124_0:Play417261031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(arg_124_1.actors_["10111"]) and arg_124_1.var_.actorSpriteComps10111 == nil then
				arg_124_1.var_.actorSpriteComps10111 = arg_124_1.actors_["10111"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_0 = 0.2

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 and not isNil(arg_124_1.actors_["10111"]) then
				if arg_124_1.var_.actorSpriteComps10111 then
					for iter_127_0, iter_127_1 in pairs(arg_124_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_127_1 then
							if arg_124_1.isInRecall_ then
								iter_127_1.color = Color.New(Mathf.Lerp(iter_127_1.color.r, arg_124_1.hightColor2.r, (arg_124_1.time_ - 0) / var_127_0), Mathf.Lerp(iter_127_1.color.g, arg_124_1.hightColor2.g, (arg_124_1.time_ - 0) / var_127_0), (Mathf.Lerp(iter_127_1.color.b, arg_124_1.hightColor2.b, (arg_124_1.time_ - 0) / var_127_0)))
							else
								local var_127_1 = Mathf.Lerp(iter_127_1.color.r, 0.5, (arg_124_1.time_ - 0) / var_127_0)

								iter_127_1.color = Color.New(var_127_1, var_127_1, var_127_1)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["10111"]) and arg_124_1.var_.actorSpriteComps10111 then
				for iter_127_2, iter_127_3 in pairs(arg_124_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_127_3 then
						iter_127_3.color = arg_124_1.isInRecall_ and (arg_124_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_124_1.var_.actorSpriteComps10111 = nil
			end

			local var_127_2 = arg_124_1.actors_["1034"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_2) and arg_124_1.var_.actorSpriteComps1034 == nil then
				arg_124_1.var_.actorSpriteComps1034 = var_127_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_3 = 0.2

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_3 and not isNil(var_127_2) then
				if arg_124_1.var_.actorSpriteComps1034 then
					for iter_127_4, iter_127_5 in pairs(arg_124_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_127_5 then
							if arg_124_1.isInRecall_ then
								iter_127_5.color = Color.New(Mathf.Lerp(iter_127_5.color.r, arg_124_1.hightColor1.r, (arg_124_1.time_ - 0) / var_127_3), Mathf.Lerp(iter_127_5.color.g, arg_124_1.hightColor1.g, (arg_124_1.time_ - 0) / var_127_3), (Mathf.Lerp(iter_127_5.color.b, arg_124_1.hightColor1.b, (arg_124_1.time_ - 0) / var_127_3)))
							else
								local var_127_4 = Mathf.Lerp(iter_127_5.color.r, 1, (arg_124_1.time_ - 0) / var_127_3)

								iter_127_5.color = Color.New(var_127_4, var_127_4, var_127_4)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= 0 + var_127_3 and arg_124_1.time_ < 0 + var_127_3 + arg_127_0 and not isNil(var_127_2) and arg_124_1.var_.actorSpriteComps1034 then
				for iter_127_6, iter_127_7 in pairs(arg_124_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_127_7 then
						iter_127_7.color = arg_124_1.isInRecall_ and (arg_124_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_124_1.var_.actorSpriteComps1034 = nil
			end

			local var_127_5 = 0
			local var_127_6 = 0.475

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_5 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_7 = arg_124_1:GetWordFromCfg(417261030)
				local var_127_8 = arg_124_1:FormatText(var_127_7.content)

				arg_124_1.text_.text = var_127_8

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_10 = 19 <= 0 and var_127_6 or var_127_6 * (utf8.len(var_127_8) / 19)

				if (19 <= 0 and var_127_6 or var_127_6 * (utf8.len(var_127_8) / 19)) > 0 and var_127_6 < var_127_10 then
					arg_124_1.talkMaxDuration = var_127_10

					if var_127_10 + var_127_5 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_10 + var_127_5
					end
				end

				arg_124_1.text_.text = var_127_8
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261030", "story_v_out_417261.awb") ~= 0 then
					local var_127_11 = manager.audio:GetVoiceLength("story_v_out_417261", "417261030", "story_v_out_417261.awb") / 1000

					if var_127_11 + var_127_5 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_11 + var_127_5
					end

					if var_127_7.prefab_name ~= "" and arg_124_1.actors_[var_127_7.prefab_name] ~= nil then
						local var_127_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_7.prefab_name].transform, "story_v_out_417261", "417261030", "story_v_out_417261.awb")

						arg_124_1:RecordAudio("417261030", var_127_12)
						arg_124_1:RecordAudio("417261030", var_127_12)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_417261", "417261030", "story_v_out_417261.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_417261", "417261030", "story_v_out_417261.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_13 = math.max(var_127_6, arg_124_1.talkMaxDuration)

			if var_127_5 <= arg_124_1.time_ and arg_124_1.time_ < var_127_5 + var_127_13 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_5) / var_127_13

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_5 + var_127_13 and arg_124_1.time_ < var_127_5 + var_127_13 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play417261031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 417261031
		arg_128_1.duration_ = 11.7

		local var_128_0 = {
			zh = 6.2,
			ja = 11.7
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
				arg_128_0:Play417261032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0.775

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
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

				local var_131_1 = arg_128_1:GetWordFromCfg(417261031)
				local var_131_2 = arg_128_1:FormatText(var_131_1.content)

				arg_128_1.text_.text = var_131_2

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_4 = 31 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_2) / 31)

				if (31 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_2) / 31)) > 0 and var_131_0 < var_131_4 then
					arg_128_1.talkMaxDuration = var_131_4

					if var_131_4 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_4 + 0
					end
				end

				arg_128_1.text_.text = var_131_2
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261031", "story_v_out_417261.awb") ~= 0 then
					local var_131_5 = manager.audio:GetVoiceLength("story_v_out_417261", "417261031", "story_v_out_417261.awb") / 1000

					if var_131_5 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_5 + 0
					end

					if var_131_1.prefab_name ~= "" and arg_128_1.actors_[var_131_1.prefab_name] ~= nil then
						local var_131_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_1.prefab_name].transform, "story_v_out_417261", "417261031", "story_v_out_417261.awb")

						arg_128_1:RecordAudio("417261031", var_131_6)
						arg_128_1:RecordAudio("417261031", var_131_6)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_417261", "417261031", "story_v_out_417261.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_417261", "417261031", "story_v_out_417261.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_7 = math.max(var_131_0, arg_128_1.talkMaxDuration)

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_7 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - 0) / var_131_7

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= 0 + var_131_7 and arg_128_1.time_ < 0 + var_131_7 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play417261032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 417261032
		arg_132_1.duration_ = 4.23

		local var_132_0 = {
			zh = 1.733,
			ja = 4.233
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
				arg_132_0:Play417261033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["10111"]) and arg_132_1.var_.actorSpriteComps10111 == nil then
				arg_132_1.var_.actorSpriteComps10111 = arg_132_1.actors_["10111"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_0 = 0.2

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["10111"]) then
				if arg_132_1.var_.actorSpriteComps10111 then
					for iter_135_0, iter_135_1 in pairs(arg_132_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_135_1 then
							if arg_132_1.isInRecall_ then
								iter_135_1.color = Color.New(Mathf.Lerp(iter_135_1.color.r, arg_132_1.hightColor1.r, (arg_132_1.time_ - 0) / var_135_0), Mathf.Lerp(iter_135_1.color.g, arg_132_1.hightColor1.g, (arg_132_1.time_ - 0) / var_135_0), (Mathf.Lerp(iter_135_1.color.b, arg_132_1.hightColor1.b, (arg_132_1.time_ - 0) / var_135_0)))
							else
								local var_135_1 = Mathf.Lerp(iter_135_1.color.r, 1, (arg_132_1.time_ - 0) / var_135_0)

								iter_135_1.color = Color.New(var_135_1, var_135_1, var_135_1)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["10111"]) and arg_132_1.var_.actorSpriteComps10111 then
				for iter_135_2, iter_135_3 in pairs(arg_132_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_135_3 then
						iter_135_3.color = arg_132_1.isInRecall_ and (arg_132_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_132_1.var_.actorSpriteComps10111 = nil
			end

			local var_135_2 = arg_132_1.actors_["1034"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_2) and arg_132_1.var_.actorSpriteComps1034 == nil then
				arg_132_1.var_.actorSpriteComps1034 = var_135_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_3 = 0.2

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_3 and not isNil(var_135_2) then
				if arg_132_1.var_.actorSpriteComps1034 then
					for iter_135_4, iter_135_5 in pairs(arg_132_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_135_5 then
							if arg_132_1.isInRecall_ then
								iter_135_5.color = Color.New(Mathf.Lerp(iter_135_5.color.r, arg_132_1.hightColor2.r, (arg_132_1.time_ - 0) / var_135_3), Mathf.Lerp(iter_135_5.color.g, arg_132_1.hightColor2.g, (arg_132_1.time_ - 0) / var_135_3), (Mathf.Lerp(iter_135_5.color.b, arg_132_1.hightColor2.b, (arg_132_1.time_ - 0) / var_135_3)))
							else
								local var_135_4 = Mathf.Lerp(iter_135_5.color.r, 0.5, (arg_132_1.time_ - 0) / var_135_3)

								iter_135_5.color = Color.New(var_135_4, var_135_4, var_135_4)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= 0 + var_135_3 and arg_132_1.time_ < 0 + var_135_3 + arg_135_0 and not isNil(var_135_2) and arg_132_1.var_.actorSpriteComps1034 then
				for iter_135_6, iter_135_7 in pairs(arg_132_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_135_7 then
						iter_135_7.color = arg_132_1.isInRecall_ and (arg_132_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_132_1.var_.actorSpriteComps1034 = nil
			end

			local var_135_5 = arg_132_1.actors_["10111"].transform

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos10111 = var_135_5.localPosition
				var_135_5.localScale = Vector3.New(1, 1, 1)

				arg_132_1:CheckSpriteTmpPos("10111", 2)

				for iter_135_8 = 0, var_135_5.childCount - 1 do
					local var_135_6 = var_135_5:GetChild(iter_135_8)

					if var_135_6.name == "split_1" or not string.find(var_135_6.name, "split") then
						var_135_6.gameObject:SetActive(true)
					else
						var_135_6.gameObject:SetActive(false)
					end
				end
			end

			local var_135_7 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_7 then
				var_135_5.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos10111, Vector3.New(-390, -361.1, -274.6), (arg_132_1.time_ - 0) / var_135_7)
			end

			if arg_132_1.time_ >= 0 + var_135_7 and arg_132_1.time_ < 0 + var_135_7 + arg_135_0 then
				var_135_5.localPosition = Vector3.New(-390, -361.1, -274.6)
			end

			local var_135_8 = 0
			local var_135_9 = 0.25

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_8 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_10 = arg_132_1:GetWordFromCfg(417261032)
				local var_135_11 = arg_132_1:FormatText(var_135_10.content)

				arg_132_1.text_.text = var_135_11

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_13 = 10 <= 0 and var_135_9 or var_135_9 * (utf8.len(var_135_11) / 10)

				if (10 <= 0 and var_135_9 or var_135_9 * (utf8.len(var_135_11) / 10)) > 0 and var_135_9 < var_135_13 then
					arg_132_1.talkMaxDuration = var_135_13

					if var_135_13 + var_135_8 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_13 + var_135_8
					end
				end

				arg_132_1.text_.text = var_135_11
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261032", "story_v_out_417261.awb") ~= 0 then
					local var_135_14 = manager.audio:GetVoiceLength("story_v_out_417261", "417261032", "story_v_out_417261.awb") / 1000

					if var_135_14 + var_135_8 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_14 + var_135_8
					end

					if var_135_10.prefab_name ~= "" and arg_132_1.actors_[var_135_10.prefab_name] ~= nil then
						local var_135_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_10.prefab_name].transform, "story_v_out_417261", "417261032", "story_v_out_417261.awb")

						arg_132_1:RecordAudio("417261032", var_135_15)
						arg_132_1:RecordAudio("417261032", var_135_15)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_417261", "417261032", "story_v_out_417261.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_417261", "417261032", "story_v_out_417261.awb")
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
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play417261033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 417261033
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play417261034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["10111"]) and arg_136_1.var_.actorSpriteComps10111 == nil then
				arg_136_1.var_.actorSpriteComps10111 = arg_136_1.actors_["10111"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_139_0 = 0.2

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["10111"]) then
				if arg_136_1.var_.actorSpriteComps10111 then
					for iter_139_0, iter_139_1 in pairs(arg_136_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_139_1 then
							if arg_136_1.isInRecall_ then
								iter_139_1.color = Color.New(Mathf.Lerp(iter_139_1.color.r, arg_136_1.hightColor2.r, (arg_136_1.time_ - 0) / var_139_0), Mathf.Lerp(iter_139_1.color.g, arg_136_1.hightColor2.g, (arg_136_1.time_ - 0) / var_139_0), (Mathf.Lerp(iter_139_1.color.b, arg_136_1.hightColor2.b, (arg_136_1.time_ - 0) / var_139_0)))
							else
								local var_139_1 = Mathf.Lerp(iter_139_1.color.r, 0.5, (arg_136_1.time_ - 0) / var_139_0)

								iter_139_1.color = Color.New(var_139_1, var_139_1, var_139_1)
							end
						end
					end
				end
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["10111"]) and arg_136_1.var_.actorSpriteComps10111 then
				for iter_139_2, iter_139_3 in pairs(arg_136_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_139_3 then
						iter_139_3.color = arg_136_1.isInRecall_ and (arg_136_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_136_1.var_.actorSpriteComps10111 = nil
			end

			local var_139_2 = 0
			local var_139_3 = 0.95

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_2 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_4 = arg_136_1:FormatText(arg_136_1:GetWordFromCfg(417261033).content)

				arg_136_1.text_.text = var_139_4

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_6 = 38 <= 0 and var_139_3 or var_139_3 * (utf8.len(var_139_4) / 38)

				if (38 <= 0 and var_139_3 or var_139_3 * (utf8.len(var_139_4) / 38)) > 0 and var_139_3 < var_139_6 then
					arg_136_1.talkMaxDuration = var_139_6

					if var_139_6 + var_139_2 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_6 + var_139_2
					end
				end

				arg_136_1.text_.text = var_139_4
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_7 = math.max(var_139_3, arg_136_1.talkMaxDuration)

			if var_139_2 <= arg_136_1.time_ and arg_136_1.time_ < var_139_2 + var_139_7 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_2) / var_139_7

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_2 + var_139_7 and arg_136_1.time_ < var_139_2 + var_139_7 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play417261034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 417261034
		arg_140_1.duration_ = 8.97

		local var_140_0 = {
			zh = 6.266,
			ja = 8.966
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
				arg_140_0:Play417261035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["1034"]) and arg_140_1.var_.actorSpriteComps1034 == nil then
				arg_140_1.var_.actorSpriteComps1034 = arg_140_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_143_0 = 0.2

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["1034"]) then
				if arg_140_1.var_.actorSpriteComps1034 then
					for iter_143_0, iter_143_1 in pairs(arg_140_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_143_1 then
							if arg_140_1.isInRecall_ then
								iter_143_1.color = Color.New(Mathf.Lerp(iter_143_1.color.r, arg_140_1.hightColor1.r, (arg_140_1.time_ - 0) / var_143_0), Mathf.Lerp(iter_143_1.color.g, arg_140_1.hightColor1.g, (arg_140_1.time_ - 0) / var_143_0), (Mathf.Lerp(iter_143_1.color.b, arg_140_1.hightColor1.b, (arg_140_1.time_ - 0) / var_143_0)))
							else
								local var_143_1 = Mathf.Lerp(iter_143_1.color.r, 1, (arg_140_1.time_ - 0) / var_143_0)

								iter_143_1.color = Color.New(var_143_1, var_143_1, var_143_1)
							end
						end
					end
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["1034"]) and arg_140_1.var_.actorSpriteComps1034 then
				for iter_143_2, iter_143_3 in pairs(arg_140_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_143_3 then
						iter_143_3.color = arg_140_1.isInRecall_ and (arg_140_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_140_1.var_.actorSpriteComps1034 = nil
			end

			local var_143_2 = 0
			local var_143_3 = 0.75

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_2 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_4 = arg_140_1:GetWordFromCfg(417261034)
				local var_143_5 = arg_140_1:FormatText(var_143_4.content)

				arg_140_1.text_.text = var_143_5

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_7 = 30 <= 0 and var_143_3 or var_143_3 * (utf8.len(var_143_5) / 30)

				if (30 <= 0 and var_143_3 or var_143_3 * (utf8.len(var_143_5) / 30)) > 0 and var_143_3 < var_143_7 then
					arg_140_1.talkMaxDuration = var_143_7

					if var_143_7 + var_143_2 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_7 + var_143_2
					end
				end

				arg_140_1.text_.text = var_143_5
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261034", "story_v_out_417261.awb") ~= 0 then
					local var_143_8 = manager.audio:GetVoiceLength("story_v_out_417261", "417261034", "story_v_out_417261.awb") / 1000

					if var_143_8 + var_143_2 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_8 + var_143_2
					end

					if var_143_4.prefab_name ~= "" and arg_140_1.actors_[var_143_4.prefab_name] ~= nil then
						local var_143_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_4.prefab_name].transform, "story_v_out_417261", "417261034", "story_v_out_417261.awb")

						arg_140_1:RecordAudio("417261034", var_143_9)
						arg_140_1:RecordAudio("417261034", var_143_9)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_417261", "417261034", "story_v_out_417261.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_417261", "417261034", "story_v_out_417261.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_10 = math.max(var_143_3, arg_140_1.talkMaxDuration)

			if var_143_2 <= arg_140_1.time_ and arg_140_1.time_ < var_143_2 + var_143_10 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_2) / var_143_10

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_2 + var_143_10 and arg_140_1.time_ < var_143_2 + var_143_10 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play417261035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 417261035
		arg_144_1.duration_ = 5.83

		local var_144_0 = {
			zh = 3.066,
			ja = 5.833
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
				arg_144_0:Play417261036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if arg_144_1.actors_["10128"] == nil then
				local var_147_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10128")

				if not isNil(var_147_0) then
					local var_147_1 = Object.Instantiate(var_147_0, arg_144_1.canvasGo_.transform)

					var_147_1.transform:SetSiblingIndex(1)

					var_147_1.name = "10128"
					var_147_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_144_1.actors_["10128"] = var_147_1

					if arg_144_1.isInRecall_ then
						for iter_147_0, iter_147_1 in ipairs((var_147_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_147_1.color = arg_144_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_147_2 = arg_144_1.actors_["10128"]

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(var_147_2) and arg_144_1.var_.actorSpriteComps10128 == nil then
				arg_144_1.var_.actorSpriteComps10128 = var_147_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_147_3 = 0.2

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_3 and not isNil(var_147_2) then
				if arg_144_1.var_.actorSpriteComps10128 then
					for iter_147_2, iter_147_3 in pairs(arg_144_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_147_3 then
							if arg_144_1.isInRecall_ then
								iter_147_3.color = Color.New(Mathf.Lerp(iter_147_3.color.r, arg_144_1.hightColor1.r, (arg_144_1.time_ - 0) / var_147_3), Mathf.Lerp(iter_147_3.color.g, arg_144_1.hightColor1.g, (arg_144_1.time_ - 0) / var_147_3), (Mathf.Lerp(iter_147_3.color.b, arg_144_1.hightColor1.b, (arg_144_1.time_ - 0) / var_147_3)))
							else
								local var_147_4 = Mathf.Lerp(iter_147_3.color.r, 1, (arg_144_1.time_ - 0) / var_147_3)

								iter_147_3.color = Color.New(var_147_4, var_147_4, var_147_4)
							end
						end
					end
				end
			end

			if arg_144_1.time_ >= 0 + var_147_3 and arg_144_1.time_ < 0 + var_147_3 + arg_147_0 and not isNil(var_147_2) and arg_144_1.var_.actorSpriteComps10128 then
				for iter_147_4, iter_147_5 in pairs(arg_144_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_147_5 then
						iter_147_5.color = arg_144_1.isInRecall_ and (arg_144_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_144_1.var_.actorSpriteComps10128 = nil
			end

			local var_147_5 = arg_144_1.actors_["10128"].transform

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos10128 = var_147_5.localPosition
				var_147_5.localScale = Vector3.New(1, 1, 1)

				arg_144_1:CheckSpriteTmpPos("10128", 4)

				for iter_147_6 = 0, var_147_5.childCount - 1 do
					local var_147_6 = var_147_5:GetChild(iter_147_6)

					if var_147_6.name == "split_4" or not string.find(var_147_6.name, "split") then
						var_147_6.gameObject:SetActive(true)
					else
						var_147_6.gameObject:SetActive(false)
					end
				end
			end

			local var_147_7 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_7 then
				var_147_5.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos10128, Vector3.New(390, -347, -300), (arg_144_1.time_ - 0) / var_147_7)
			end

			if arg_144_1.time_ >= 0 + var_147_7 and arg_144_1.time_ < 0 + var_147_7 + arg_147_0 then
				var_147_5.localPosition = Vector3.New(390, -347, -300)
			end

			local var_147_8 = 0
			local var_147_9 = 0.35

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_8 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_10 = arg_144_1:GetWordFromCfg(417261035)
				local var_147_11 = arg_144_1:FormatText(var_147_10.content)

				arg_144_1.text_.text = var_147_11

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_13 = 14 <= 0 and var_147_9 or var_147_9 * (utf8.len(var_147_11) / 14)

				if (14 <= 0 and var_147_9 or var_147_9 * (utf8.len(var_147_11) / 14)) > 0 and var_147_9 < var_147_13 then
					arg_144_1.talkMaxDuration = var_147_13

					if var_147_13 + var_147_8 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_13 + var_147_8
					end
				end

				arg_144_1.text_.text = var_147_11
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261035", "story_v_out_417261.awb") ~= 0 then
					local var_147_14 = manager.audio:GetVoiceLength("story_v_out_417261", "417261035", "story_v_out_417261.awb") / 1000

					if var_147_14 + var_147_8 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_14 + var_147_8
					end

					if var_147_10.prefab_name ~= "" and arg_144_1.actors_[var_147_10.prefab_name] ~= nil then
						local var_147_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_10.prefab_name].transform, "story_v_out_417261", "417261035", "story_v_out_417261.awb")

						arg_144_1:RecordAudio("417261035", var_147_15)
						arg_144_1:RecordAudio("417261035", var_147_15)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_417261", "417261035", "story_v_out_417261.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_417261", "417261035", "story_v_out_417261.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_16 = math.max(var_147_9, arg_144_1.talkMaxDuration)

			if var_147_8 <= arg_144_1.time_ and arg_144_1.time_ < var_147_8 + var_147_16 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_8) / var_147_16

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_8 + var_147_16 and arg_144_1.time_ < var_147_8 + var_147_16 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play417261036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 417261036
		arg_148_1.duration_ = 3.23

		local var_148_0 = {
			zh = 2.4,
			ja = 3.233
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
				arg_148_0:Play417261037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(arg_148_1.actors_["10111"]) and arg_148_1.var_.actorSpriteComps10111 == nil then
				arg_148_1.var_.actorSpriteComps10111 = arg_148_1.actors_["10111"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_151_0 = 0.2

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 and not isNil(arg_148_1.actors_["10111"]) then
				if arg_148_1.var_.actorSpriteComps10111 then
					for iter_151_0, iter_151_1 in pairs(arg_148_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_151_1 then
							if arg_148_1.isInRecall_ then
								iter_151_1.color = Color.New(Mathf.Lerp(iter_151_1.color.r, arg_148_1.hightColor1.r, (arg_148_1.time_ - 0) / var_151_0), Mathf.Lerp(iter_151_1.color.g, arg_148_1.hightColor1.g, (arg_148_1.time_ - 0) / var_151_0), (Mathf.Lerp(iter_151_1.color.b, arg_148_1.hightColor1.b, (arg_148_1.time_ - 0) / var_151_0)))
							else
								local var_151_1 = Mathf.Lerp(iter_151_1.color.r, 1, (arg_148_1.time_ - 0) / var_151_0)

								iter_151_1.color = Color.New(var_151_1, var_151_1, var_151_1)
							end
						end
					end
				end
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 and not isNil(arg_148_1.actors_["10111"]) and arg_148_1.var_.actorSpriteComps10111 then
				for iter_151_2, iter_151_3 in pairs(arg_148_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_151_3 then
						iter_151_3.color = arg_148_1.isInRecall_ and (arg_148_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_148_1.var_.actorSpriteComps10111 = nil
			end

			local var_151_2 = arg_148_1.actors_["10128"]

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(var_151_2) and arg_148_1.var_.actorSpriteComps10128 == nil then
				arg_148_1.var_.actorSpriteComps10128 = var_151_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_151_3 = 0.2

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_3 and not isNil(var_151_2) then
				if arg_148_1.var_.actorSpriteComps10128 then
					for iter_151_4, iter_151_5 in pairs(arg_148_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_151_5 then
							if arg_148_1.isInRecall_ then
								iter_151_5.color = Color.New(Mathf.Lerp(iter_151_5.color.r, arg_148_1.hightColor2.r, (arg_148_1.time_ - 0) / var_151_3), Mathf.Lerp(iter_151_5.color.g, arg_148_1.hightColor2.g, (arg_148_1.time_ - 0) / var_151_3), (Mathf.Lerp(iter_151_5.color.b, arg_148_1.hightColor2.b, (arg_148_1.time_ - 0) / var_151_3)))
							else
								local var_151_4 = Mathf.Lerp(iter_151_5.color.r, 0.5, (arg_148_1.time_ - 0) / var_151_3)

								iter_151_5.color = Color.New(var_151_4, var_151_4, var_151_4)
							end
						end
					end
				end
			end

			if arg_148_1.time_ >= 0 + var_151_3 and arg_148_1.time_ < 0 + var_151_3 + arg_151_0 and not isNil(var_151_2) and arg_148_1.var_.actorSpriteComps10128 then
				for iter_151_6, iter_151_7 in pairs(arg_148_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_151_7 then
						iter_151_7.color = arg_148_1.isInRecall_ and (arg_148_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_148_1.var_.actorSpriteComps10128 = nil
			end

			local var_151_5 = arg_148_1.actors_["10111"].transform

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos10111 = var_151_5.localPosition
				var_151_5.localScale = Vector3.New(1, 1, 1)

				arg_148_1:CheckSpriteTmpPos("10111", 2)

				for iter_151_8 = 0, var_151_5.childCount - 1 do
					local var_151_6 = var_151_5:GetChild(iter_151_8)

					if var_151_6.name == "split_2" or not string.find(var_151_6.name, "split") then
						var_151_6.gameObject:SetActive(true)
					else
						var_151_6.gameObject:SetActive(false)
					end
				end
			end

			local var_151_7 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_7 then
				var_151_5.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos10111, Vector3.New(-390, -361.1, -274.6), (arg_148_1.time_ - 0) / var_151_7)
			end

			if arg_148_1.time_ >= 0 + var_151_7 and arg_148_1.time_ < 0 + var_151_7 + arg_151_0 then
				var_151_5.localPosition = Vector3.New(-390, -361.1, -274.6)
			end

			local var_151_8 = 0
			local var_151_9 = 0.2

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_8 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_10 = arg_148_1:GetWordFromCfg(417261036)
				local var_151_11 = arg_148_1:FormatText(var_151_10.content)

				arg_148_1.text_.text = var_151_11

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_13 = 8 <= 0 and var_151_9 or var_151_9 * (utf8.len(var_151_11) / 8)

				if (8 <= 0 and var_151_9 or var_151_9 * (utf8.len(var_151_11) / 8)) > 0 and var_151_9 < var_151_13 then
					arg_148_1.talkMaxDuration = var_151_13

					if var_151_13 + var_151_8 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_13 + var_151_8
					end
				end

				arg_148_1.text_.text = var_151_11
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261036", "story_v_out_417261.awb") ~= 0 then
					local var_151_14 = manager.audio:GetVoiceLength("story_v_out_417261", "417261036", "story_v_out_417261.awb") / 1000

					if var_151_14 + var_151_8 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_14 + var_151_8
					end

					if var_151_10.prefab_name ~= "" and arg_148_1.actors_[var_151_10.prefab_name] ~= nil then
						local var_151_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_10.prefab_name].transform, "story_v_out_417261", "417261036", "story_v_out_417261.awb")

						arg_148_1:RecordAudio("417261036", var_151_15)
						arg_148_1:RecordAudio("417261036", var_151_15)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_417261", "417261036", "story_v_out_417261.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_417261", "417261036", "story_v_out_417261.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_16 = math.max(var_151_9, arg_148_1.talkMaxDuration)

			if var_151_8 <= arg_148_1.time_ and arg_148_1.time_ < var_151_8 + var_151_16 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_8) / var_151_16

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_8 + var_151_16 and arg_148_1.time_ < var_151_8 + var_151_16 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_148_1:InitPlayNodeList()
	end,
	Play417261037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 417261037
		arg_152_1.duration_ = 7.53

		local var_152_0 = {
			zh = 5.666,
			ja = 7.533
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
				arg_152_0:Play417261038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0.625

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_1 = arg_152_1:GetWordFromCfg(417261037)
				local var_155_2 = arg_152_1:FormatText(var_155_1.content)

				arg_152_1.text_.text = var_155_2

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_4 = 25 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_2) / 25)

				if (25 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_2) / 25)) > 0 and var_155_0 < var_155_4 then
					arg_152_1.talkMaxDuration = var_155_4

					if var_155_4 + 0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_4 + 0
					end
				end

				arg_152_1.text_.text = var_155_2
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261037", "story_v_out_417261.awb") ~= 0 then
					local var_155_5 = manager.audio:GetVoiceLength("story_v_out_417261", "417261037", "story_v_out_417261.awb") / 1000

					if var_155_5 + 0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_5 + 0
					end

					if var_155_1.prefab_name ~= "" and arg_152_1.actors_[var_155_1.prefab_name] ~= nil then
						local var_155_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_1.prefab_name].transform, "story_v_out_417261", "417261037", "story_v_out_417261.awb")

						arg_152_1:RecordAudio("417261037", var_155_6)
						arg_152_1:RecordAudio("417261037", var_155_6)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_417261", "417261037", "story_v_out_417261.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_417261", "417261037", "story_v_out_417261.awb")
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
	Play417261038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 417261038
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play417261039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos10111 = arg_156_1.actors_["10111"].transform.localPosition
				arg_156_1.actors_["10111"].transform.localScale = Vector3.New(1, 1, 1)

				arg_156_1:CheckSpriteTmpPos("10111", 7)

				for iter_159_0 = 0, arg_156_1.actors_["10111"].transform.childCount - 1 do
					local var_159_0 = arg_156_1.actors_["10111"].transform:GetChild(iter_159_0)

					if var_159_0.name == "" or not string.find(var_159_0.name, "split") then
						var_159_0.gameObject:SetActive(true)
					else
						var_159_0.gameObject:SetActive(false)
					end
				end
			end

			local var_159_1 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_1 then
				arg_156_1.actors_["10111"].transform.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos10111, Vector3.New(0, -2000, 0), (arg_156_1.time_ - 0) / var_159_1)
			end

			if arg_156_1.time_ >= 0 + var_159_1 and arg_156_1.time_ < 0 + var_159_1 + arg_159_0 then
				arg_156_1.actors_["10111"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_159_2 = arg_156_1.actors_["10128"].transform

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos10128 = var_159_2.localPosition
				var_159_2.localScale = Vector3.New(1, 1, 1)

				arg_156_1:CheckSpriteTmpPos("10128", 7)

				for iter_159_1 = 0, var_159_2.childCount - 1 do
					local var_159_3 = var_159_2:GetChild(iter_159_1)

					if var_159_3.name == "" or not string.find(var_159_3.name, "split") then
						var_159_3.gameObject:SetActive(true)
					else
						var_159_3.gameObject:SetActive(false)
					end
				end
			end

			local var_159_4 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_4 then
				var_159_2.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_156_1.time_ - 0) / var_159_4)
			end

			if arg_156_1.time_ >= 0 + var_159_4 and arg_156_1.time_ < 0 + var_159_4 + arg_159_0 then
				var_159_2.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_159_5 = 0
			local var_159_6 = 0.975

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_5 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_7 = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(417261038).content)

				arg_156_1.text_.text = var_159_7

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_9 = 39 <= 0 and var_159_6 or var_159_6 * (utf8.len(var_159_7) / 39)

				if (39 <= 0 and var_159_6 or var_159_6 * (utf8.len(var_159_7) / 39)) > 0 and var_159_6 < var_159_9 then
					arg_156_1.talkMaxDuration = var_159_9

					if var_159_9 + var_159_5 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_9 + var_159_5
					end
				end

				arg_156_1.text_.text = var_159_7
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_10 = math.max(var_159_6, arg_156_1.talkMaxDuration)

			if var_159_5 <= arg_156_1.time_ and arg_156_1.time_ < var_159_5 + var_159_10 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_5) / var_159_10

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_5 + var_159_10 and arg_156_1.time_ < var_159_5 + var_159_10 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play417261039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 417261039
		arg_160_1.duration_ = 2.73

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play417261040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if arg_160_1.bgs_.STblack == nil then
				local var_163_0 = Object.Instantiate(arg_160_1.paintGo_)

				var_163_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_163_0.name = "STblack"
				var_163_0.transform.parent = arg_160_1.stage_.transform
				var_163_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_160_1.bgs_.STblack = var_163_0
			end

			if 1.2 < arg_160_1.time_ and arg_160_1.time_ <= 1.2 + arg_163_0 then
				local var_163_1 = arg_160_1.bgs_.STblack

				arg_160_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_163_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_163_2 = var_163_1:GetComponent("SpriteRenderer")

				if var_163_2 and var_163_2.sprite then
					local var_163_3 = 2 * (var_163_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_163_1.transform.localScale = Vector3.New(var_163_3 / var_163_2.sprite.bounds.size.y < var_163_3 * manager.ui.mainCameraCom_.aspect / var_163_2.sprite.bounds.size.x and var_163_3 * manager.ui.mainCameraCom_.aspect / var_163_2.sprite.bounds.size.x or var_163_3 / var_163_2.sprite.bounds.size.y, var_163_3 / var_163_2.sprite.bounds.size.y < var_163_3 * manager.ui.mainCameraCom_.aspect / var_163_2.sprite.bounds.size.x and var_163_3 * manager.ui.mainCameraCom_.aspect / var_163_2.sprite.bounds.size.x or var_163_3 / var_163_2.sprite.bounds.size.y, 0)
				end

				for iter_163_0, iter_163_1 in pairs(arg_160_1.bgs_) do
					if iter_163_0 ~= "STblack" then
						iter_163_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_163_4 = 0

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_4 + arg_163_0 then
				arg_160_1.mask_.enabled = true
				arg_160_1.mask_.raycastTarget = false

				arg_160_1:SetGaussion(false)
			end

			local var_163_5 = 1.2

			if var_163_4 <= arg_160_1.time_ and arg_160_1.time_ < var_163_4 + var_163_5 then
				local var_163_6 = Color.New(0, 0, 0)

				var_163_6.a = Mathf.Lerp(0, 1, (arg_160_1.time_ - var_163_4) / var_163_5)
				arg_160_1.mask_.color = var_163_6
			end

			if arg_160_1.time_ >= var_163_4 + var_163_5 and arg_160_1.time_ < var_163_4 + var_163_5 + arg_163_0 then
				local var_163_7 = Color.New(0, 0, 0)

				var_163_7.a = 1
				arg_160_1.mask_.color = var_163_7
			end

			local var_163_8 = 1.2

			if 1.2 < arg_160_1.time_ and arg_160_1.time_ <= var_163_8 + arg_163_0 then
				arg_160_1.mask_.enabled = true
				arg_160_1.mask_.raycastTarget = false

				arg_160_1:SetGaussion(false)
			end

			local var_163_9 = 1.2

			if var_163_8 <= arg_160_1.time_ and arg_160_1.time_ < var_163_8 + var_163_9 then
				local var_163_10 = Color.New(0, 0, 0)

				var_163_10.a = Mathf.Lerp(1, 0, (arg_160_1.time_ - var_163_8) / var_163_9)
				arg_160_1.mask_.color = var_163_10
			end

			if arg_160_1.time_ >= var_163_8 + var_163_9 and arg_160_1.time_ < var_163_8 + var_163_9 + arg_163_0 then
				local var_163_11 = Color.New(0, 0, 0)

				arg_160_1.mask_.enabled = false
				var_163_11.a = 0
				arg_160_1.mask_.color = var_163_11
			end

			if 1.2 < arg_160_1.time_ and arg_160_1.time_ <= 1.2 + arg_163_0 then
				arg_160_1.fswbg_:SetActive(true)
				arg_160_1.dialog_:SetActive(false)

				arg_160_1.fswtw_.percent = 0
				arg_160_1.fswt_.text = arg_160_1:FormatText(arg_160_1:GetWordFromCfg(417261039).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.fswt_)

				arg_160_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_160_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_160_1.fswtw_:SetDirty()

				arg_160_1.typewritterCharCountI18N = 0

				SetActive(arg_160_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_160_1:ShowNextGo(false)
			end

			local var_163_12 = 1.86666666666667

			if 1.86666666666667 < arg_160_1.time_ and arg_160_1.time_ <= var_163_12 + arg_163_0 then
				arg_160_1.var_.oldValueTypewriter = arg_160_1.fswtw_.percent

				SetActive(arg_160_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_160_1:ShowNextGo(false)
			end

			local var_163_13 = 13
			local var_163_14 = 0.866666666666667
			local var_163_15, var_163_16 = arg_160_1:GetPercentByPara(arg_160_1:FormatText(arg_160_1:GetWordFromCfg(417261039).content), 1)

			if var_163_12 < arg_160_1.time_ and arg_160_1.time_ <= var_163_12 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0

				local var_163_17 = var_163_13 <= 0 and var_163_14 or var_163_14 * ((var_163_16 - arg_160_1.typewritterCharCountI18N) / var_163_13)

				if (var_163_13 <= 0 and var_163_14 or var_163_14 * ((var_163_16 - arg_160_1.typewritterCharCountI18N) / var_163_13)) > 0 and var_163_14 < var_163_17 then
					arg_160_1.talkMaxDuration = var_163_17

					if var_163_17 + var_163_12 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_17 + var_163_12
					end
				end
			end

			local var_163_18 = math.max(0.866666666666667, arg_160_1.talkMaxDuration)

			if var_163_12 <= arg_160_1.time_ and arg_160_1.time_ < var_163_12 + var_163_18 then
				arg_160_1.fswtw_.percent = Mathf.Lerp(arg_160_1.var_.oldValueTypewriter, var_163_15, (arg_160_1.time_ - var_163_12) / var_163_18)
				arg_160_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_160_1.fswtw_:SetDirty()
			end

			if arg_160_1.time_ >= var_163_12 + var_163_18 and arg_160_1.time_ < var_163_12 + var_163_18 + arg_163_0 then
				arg_160_1.fswtw_.percent = var_163_15

				arg_160_1.fswtw_:SetDirty()
				arg_160_1:ShowNextGo(true)

				arg_160_1.typewritterCharCountI18N = var_163_16
			end

			if 1.2 < arg_160_1.time_ and arg_160_1.time_ <= 1.2 + arg_163_0 then
				local var_163_19 = arg_160_1.fswbg_.transform:Find("textbox/adapt/content") or arg_160_1.fswbg_.transform:Find("textbox/content")
				local var_163_20 = arg_160_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_163_21 = var_163_19:GetComponent("RectTransform")

				var_163_19:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_163_21.offsetMin = Vector2.New(0, 0)
				var_163_21.offsetMax = Vector2.New(0, 0)
			end

			local var_163_22 = 0
			local var_163_23 = 0.1

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_22 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_24 = arg_160_1:FormatText(arg_160_1:GetWordFromCfg(102).content)

				arg_160_1.text_.text = var_163_24

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_26 = 0 <= 0 and var_163_23 or var_163_23 * (utf8.len(var_163_24) / 0)

				if (0 <= 0 and var_163_23 or var_163_23 * (utf8.len(var_163_24) / 0)) > 0 and var_163_23 < var_163_26 then
					arg_160_1.talkMaxDuration = var_163_26

					if var_163_26 + var_163_22 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_26 + var_163_22
					end
				end

				arg_160_1.text_.text = var_163_24
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_27 = math.max(var_163_23, arg_160_1.talkMaxDuration)

			if var_163_22 <= arg_160_1.time_ and arg_160_1.time_ < var_163_22 + var_163_27 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_22) / var_163_27

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_22 + var_163_27 and arg_160_1.time_ < var_163_22 + var_163_27 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play417261040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 417261040
		arg_164_1.duration_ = 10.97

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play417261041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 5.96666666666667 < arg_164_1.time_ and arg_164_1.time_ <= 5.96666666666667 + arg_167_0 then
				arg_164_1.allBtn_.enabled = false
			end

			if arg_164_1.time_ >= 5.96666666666667 + 0.3 and arg_164_1.time_ < 5.96666666666667 + 0.3 + arg_167_0 then
				arg_164_1.allBtn_.enabled = true
			end

			local var_167_0 = "ST02"

			if arg_164_1.bgs_.ST02 == nil then
				local var_167_1 = Object.Instantiate(arg_164_1.paintGo_)

				var_167_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_167_0)
				var_167_1.name = var_167_0
				var_167_1.transform.parent = arg_164_1.stage_.transform
				var_167_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_164_1.bgs_[var_167_0] = var_167_1
			end

			if 4.96666666666667 < arg_164_1.time_ and arg_164_1.time_ <= 4.96666666666667 + arg_167_0 then
				local var_167_2 = arg_164_1.bgs_.ST02

				arg_164_1.bgs_.ST02.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_167_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_167_3 = var_167_2:GetComponent("SpriteRenderer")

				if var_167_3 and var_167_3.sprite then
					local var_167_4 = 2 * (var_167_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_167_2.transform.localScale = Vector3.New(var_167_4 / var_167_3.sprite.bounds.size.y < var_167_4 * manager.ui.mainCameraCom_.aspect / var_167_3.sprite.bounds.size.x and var_167_4 * manager.ui.mainCameraCom_.aspect / var_167_3.sprite.bounds.size.x or var_167_4 / var_167_3.sprite.bounds.size.y, var_167_4 / var_167_3.sprite.bounds.size.y < var_167_4 * manager.ui.mainCameraCom_.aspect / var_167_3.sprite.bounds.size.x and var_167_4 * manager.ui.mainCameraCom_.aspect / var_167_3.sprite.bounds.size.x or var_167_4 / var_167_3.sprite.bounds.size.y, 0)
				end

				for iter_167_0, iter_167_1 in pairs(arg_164_1.bgs_) do
					if iter_167_0 ~= "ST02" then
						iter_167_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0.975 < arg_164_1.time_ and arg_164_1.time_ <= 0.975 + arg_167_0 then
				local var_167_5 = arg_164_1.bgs_.STblack

				arg_164_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_167_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_167_6 = var_167_5:GetComponent("SpriteRenderer")

				if var_167_6 and var_167_6.sprite then
					local var_167_7 = 2 * (var_167_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_167_5.transform.localScale = Vector3.New(var_167_7 / var_167_6.sprite.bounds.size.y < var_167_7 * manager.ui.mainCameraCom_.aspect / var_167_6.sprite.bounds.size.x and var_167_7 * manager.ui.mainCameraCom_.aspect / var_167_6.sprite.bounds.size.x or var_167_7 / var_167_6.sprite.bounds.size.y, var_167_7 / var_167_6.sprite.bounds.size.y < var_167_7 * manager.ui.mainCameraCom_.aspect / var_167_6.sprite.bounds.size.x and var_167_7 * manager.ui.mainCameraCom_.aspect / var_167_6.sprite.bounds.size.x or var_167_7 / var_167_6.sprite.bounds.size.y, 0)
				end

				for iter_167_2, iter_167_3 in pairs(arg_164_1.bgs_) do
					if iter_167_2 ~= "STblack" then
						iter_167_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0.975 < arg_164_1.time_ and arg_164_1.time_ <= 0.975 + arg_167_0 then
				arg_164_1.cswbg_:SetActive(true)

				local var_167_8 = arg_164_1.cswt_:GetComponent("RectTransform")

				arg_164_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_167_8.offsetMin = Vector2.New(0, 0)
				var_167_8.offsetMax = Vector2.New(0, 0)
				arg_164_1.cswt_.text = arg_164_1:FormatText(arg_164_1:GetWordFromCfg(419123).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.cswt_)

				arg_164_1.cswt_.fontSize = 120
				arg_164_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_164_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_164_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 4.93333333333333 < arg_164_1.time_ and arg_164_1.time_ <= 4.93333333333333 + arg_167_0 then
				arg_164_1.cswbg_:SetActive(false)
			end

			local var_167_9 = 0

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_9 + arg_167_0 then
				arg_164_1.mask_.enabled = true
				arg_164_1.mask_.raycastTarget = true

				arg_164_1:SetGaussion(false)
			end

			local var_167_10 = 0.966666666666667

			if var_167_9 <= arg_164_1.time_ and arg_164_1.time_ < var_167_9 + var_167_10 then
				local var_167_11 = Color.New(0, 0, 0)

				var_167_11.a = Mathf.Lerp(0, 1, (arg_164_1.time_ - var_167_9) / var_167_10)
				arg_164_1.mask_.color = var_167_11
			end

			if arg_164_1.time_ >= var_167_9 + var_167_10 and arg_164_1.time_ < var_167_9 + var_167_10 + arg_167_0 then
				local var_167_12 = Color.New(0, 0, 0)

				var_167_12.a = 1
				arg_164_1.mask_.color = var_167_12
			end

			local var_167_13 = 0.966666666666667

			if 0.966666666666667 < arg_164_1.time_ and arg_164_1.time_ <= var_167_13 + arg_167_0 then
				arg_164_1.mask_.enabled = true
				arg_164_1.mask_.raycastTarget = true

				arg_164_1:SetGaussion(false)
			end

			local var_167_14 = 1.03333333333333

			if var_167_13 <= arg_164_1.time_ and arg_164_1.time_ < var_167_13 + var_167_14 then
				local var_167_15 = Color.New(0, 0, 0)

				var_167_15.a = Mathf.Lerp(1, 0, (arg_164_1.time_ - var_167_13) / var_167_14)
				arg_164_1.mask_.color = var_167_15
			end

			if arg_164_1.time_ >= var_167_13 + var_167_14 and arg_164_1.time_ < var_167_13 + var_167_14 + arg_167_0 then
				local var_167_16 = Color.New(0, 0, 0)

				arg_164_1.mask_.enabled = false
				var_167_16.a = 0
				arg_164_1.mask_.color = var_167_16
			end

			local var_167_17 = 3.63333333333334

			if 3.63333333333334 < arg_164_1.time_ and arg_164_1.time_ <= var_167_17 + arg_167_0 then
				arg_164_1.mask_.enabled = true
				arg_164_1.mask_.raycastTarget = true

				arg_164_1:SetGaussion(false)
			end

			local var_167_18 = 1.31666666666667

			if var_167_17 <= arg_164_1.time_ and arg_164_1.time_ < var_167_17 + var_167_18 then
				local var_167_19 = Color.New(0, 0, 0)

				var_167_19.a = Mathf.Lerp(0, 1, (arg_164_1.time_ - var_167_17) / var_167_18)
				arg_164_1.mask_.color = var_167_19
			end

			if arg_164_1.time_ >= var_167_17 + var_167_18 and arg_164_1.time_ < var_167_17 + var_167_18 + arg_167_0 then
				local var_167_20 = Color.New(0, 0, 0)

				var_167_20.a = 1
				arg_164_1.mask_.color = var_167_20
			end

			local var_167_21 = 4.95

			if 4.95 < arg_164_1.time_ and arg_164_1.time_ <= var_167_21 + arg_167_0 then
				arg_164_1.mask_.enabled = true
				arg_164_1.mask_.raycastTarget = true

				arg_164_1:SetGaussion(false)
			end

			local var_167_22 = 1

			if var_167_21 <= arg_164_1.time_ and arg_164_1.time_ < var_167_21 + var_167_22 then
				local var_167_23 = Color.New(0, 0, 0)

				var_167_23.a = Mathf.Lerp(1, 0, (arg_164_1.time_ - var_167_21) / var_167_22)
				arg_164_1.mask_.color = var_167_23
			end

			if arg_164_1.time_ >= var_167_21 + var_167_22 and arg_164_1.time_ < var_167_21 + var_167_22 + arg_167_0 then
				local var_167_24 = Color.New(0, 0, 0)

				arg_164_1.mask_.enabled = false
				var_167_24.a = 0
				arg_164_1.mask_.color = var_167_24
			end

			if 0.9 < arg_164_1.time_ and arg_164_1.time_ <= 0.9 + arg_167_0 then
				arg_164_1.fswbg_:SetActive(false)
				arg_164_1.dialog_:SetActive(false)
				SetActive(arg_164_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_164_1:ShowNextGo(false)
			end

			if 5.95 < arg_164_1.time_ and arg_164_1.time_ <= 5.95 + arg_167_0 then
				arg_164_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_plate", "")
			end

			if 4.7 < arg_164_1.time_ and arg_164_1.time_ <= 4.7 + arg_167_0 then
				arg_164_1:AudioAction("play", "effect", "se_story_side_1068", "se_story_1068_restaurant", "")
			end

			if arg_164_1.frameCnt_ <= 1 then
				arg_164_1.dialog_:SetActive(false)
			end

			local var_167_27 = 5.96666666666667
			local var_167_28 = 0.775

			if 5.96666666666667 < arg_164_1.time_ and arg_164_1.time_ <= var_167_27 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0

				arg_164_1.dialog_:SetActive(true)

				arg_164_1.dialogCg_.alpha = 0

				local var_167_29 = LeanTween.value(arg_164_1.dialog_, 0, 1, 0.3)

				var_167_29:setOnUpdate(LuaHelper.FloatAction(function(arg_168_0)
					arg_164_1.dialogCg_.alpha = arg_168_0
				end))
				var_167_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_164_1.dialog_)
					var_167_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_164_1.duration_ = arg_164_1.duration_ + 0.3

				SetActive(arg_164_1.leftNameGo_, false)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_30 = arg_164_1:FormatText(arg_164_1:GetWordFromCfg(417261040).content)

				arg_164_1.text_.text = var_167_30

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_32 = 31 <= 0 and var_167_28 or var_167_28 * (utf8.len(var_167_30) / 31)

				if (31 <= 0 and var_167_28 or var_167_28 * (utf8.len(var_167_30) / 31)) > 0 and var_167_28 < var_167_32 then
					arg_164_1.talkMaxDuration = var_167_32
					var_167_27 = var_167_27 + 0.3

					if var_167_32 + var_167_27 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_32 + var_167_27
					end
				end

				arg_164_1.text_.text = var_167_30
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_33 = var_167_27 + 0.3
			local var_167_34 = math.max(var_167_28, arg_164_1.talkMaxDuration)

			if var_167_27 + 0.3 <= arg_164_1.time_ and arg_164_1.time_ < var_167_33 + var_167_34 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_33) / var_167_34

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_33 + var_167_34 and arg_164_1.time_ < var_167_33 + var_167_34 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play417261041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 417261041
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play417261042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0.875

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

				local var_173_1 = arg_170_1:FormatText(arg_170_1:GetWordFromCfg(417261041).content)

				arg_170_1.text_.text = var_173_1

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_3 = 35 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_1) / 35)

				if (35 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_1) / 35)) > 0 and var_173_0 < var_173_3 then
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
	Play417261042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 417261042
		arg_174_1.duration_ = 10.5

		local var_174_0 = {
			zh = 7.7,
			ja = 10.5
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play417261043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if arg_174_1.actors_["10115"] == nil then
				local var_177_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10115")

				if not isNil(var_177_0) then
					local var_177_1 = Object.Instantiate(var_177_0, arg_174_1.canvasGo_.transform)

					var_177_1.transform:SetSiblingIndex(1)

					var_177_1.name = "10115"
					var_177_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_174_1.actors_["10115"] = var_177_1

					if arg_174_1.isInRecall_ then
						for iter_177_0, iter_177_1 in ipairs((var_177_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_177_1.color = arg_174_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_177_2 = arg_174_1.actors_["10115"]

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(var_177_2) and arg_174_1.var_.actorSpriteComps10115 == nil then
				arg_174_1.var_.actorSpriteComps10115 = var_177_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_177_3 = 0.2

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_3 and not isNil(var_177_2) then
				if arg_174_1.var_.actorSpriteComps10115 then
					for iter_177_2, iter_177_3 in pairs(arg_174_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_177_3 then
							if arg_174_1.isInRecall_ then
								iter_177_3.color = Color.New(Mathf.Lerp(iter_177_3.color.r, arg_174_1.hightColor1.r, (arg_174_1.time_ - 0) / var_177_3), Mathf.Lerp(iter_177_3.color.g, arg_174_1.hightColor1.g, (arg_174_1.time_ - 0) / var_177_3), (Mathf.Lerp(iter_177_3.color.b, arg_174_1.hightColor1.b, (arg_174_1.time_ - 0) / var_177_3)))
							else
								local var_177_4 = Mathf.Lerp(iter_177_3.color.r, 1, (arg_174_1.time_ - 0) / var_177_3)

								iter_177_3.color = Color.New(var_177_4, var_177_4, var_177_4)
							end
						end
					end
				end
			end

			if arg_174_1.time_ >= 0 + var_177_3 and arg_174_1.time_ < 0 + var_177_3 + arg_177_0 and not isNil(var_177_2) and arg_174_1.var_.actorSpriteComps10115 then
				for iter_177_4, iter_177_5 in pairs(arg_174_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_177_5 then
						iter_177_5.color = arg_174_1.isInRecall_ and (arg_174_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_174_1.var_.actorSpriteComps10115 = nil
			end

			local var_177_5 = arg_174_1.actors_["10115"].transform

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos10115 = var_177_5.localPosition
				var_177_5.localScale = Vector3.New(1, 1, 1)

				arg_174_1:CheckSpriteTmpPos("10115", 3)

				for iter_177_6 = 0, var_177_5.childCount - 1 do
					local var_177_6 = var_177_5:GetChild(iter_177_6)

					if var_177_6.name == "split_2" or not string.find(var_177_6.name, "split") then
						var_177_6.gameObject:SetActive(true)
					else
						var_177_6.gameObject:SetActive(false)
					end
				end
			end

			local var_177_7 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_7 then
				var_177_5.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos10115, Vector3.New(0, -387.3, -246.2), (arg_174_1.time_ - 0) / var_177_7)
			end

			if arg_174_1.time_ >= 0 + var_177_7 and arg_174_1.time_ < 0 + var_177_7 + arg_177_0 then
				var_177_5.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_177_8 = 0
			local var_177_9 = 1

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_8 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_10 = arg_174_1:GetWordFromCfg(417261042)
				local var_177_11 = arg_174_1:FormatText(var_177_10.content)

				arg_174_1.text_.text = var_177_11

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_13 = 40 <= 0 and var_177_9 or var_177_9 * (utf8.len(var_177_11) / 40)

				if (40 <= 0 and var_177_9 or var_177_9 * (utf8.len(var_177_11) / 40)) > 0 and var_177_9 < var_177_13 then
					arg_174_1.talkMaxDuration = var_177_13

					if var_177_13 + var_177_8 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_13 + var_177_8
					end
				end

				arg_174_1.text_.text = var_177_11
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261042", "story_v_out_417261.awb") ~= 0 then
					local var_177_14 = manager.audio:GetVoiceLength("story_v_out_417261", "417261042", "story_v_out_417261.awb") / 1000

					if var_177_14 + var_177_8 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_14 + var_177_8
					end

					if var_177_10.prefab_name ~= "" and arg_174_1.actors_[var_177_10.prefab_name] ~= nil then
						local var_177_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_10.prefab_name].transform, "story_v_out_417261", "417261042", "story_v_out_417261.awb")

						arg_174_1:RecordAudio("417261042", var_177_15)
						arg_174_1:RecordAudio("417261042", var_177_15)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_417261", "417261042", "story_v_out_417261.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_417261", "417261042", "story_v_out_417261.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_16 = math.max(var_177_9, arg_174_1.talkMaxDuration)

			if var_177_8 <= arg_174_1.time_ and arg_174_1.time_ < var_177_8 + var_177_16 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_8) / var_177_16

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_8 + var_177_16 and arg_174_1.time_ < var_177_8 + var_177_16 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play417261043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 417261043
		arg_178_1.duration_ = 5.2

		local var_178_0 = {
			zh = 3.566,
			ja = 5.2
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
				arg_178_0:Play417261044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if arg_178_1.actors_["10014"] == nil then
				local var_181_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10014")

				if not isNil(var_181_0) then
					local var_181_1 = Object.Instantiate(var_181_0, arg_178_1.canvasGo_.transform)

					var_181_1.transform:SetSiblingIndex(1)

					var_181_1.name = "10014"
					var_181_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_178_1.actors_["10014"] = var_181_1

					if arg_178_1.isInRecall_ then
						for iter_181_0, iter_181_1 in ipairs((var_181_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_181_1.color = arg_178_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_181_2 = arg_178_1.actors_["10014"]

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(var_181_2) and arg_178_1.var_.actorSpriteComps10014 == nil then
				arg_178_1.var_.actorSpriteComps10014 = var_181_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_181_3 = 0.2

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_3 and not isNil(var_181_2) then
				if arg_178_1.var_.actorSpriteComps10014 then
					for iter_181_2, iter_181_3 in pairs(arg_178_1.var_.actorSpriteComps10014:ToTable()) do
						if iter_181_3 then
							if arg_178_1.isInRecall_ then
								iter_181_3.color = Color.New(Mathf.Lerp(iter_181_3.color.r, arg_178_1.hightColor1.r, (arg_178_1.time_ - 0) / var_181_3), Mathf.Lerp(iter_181_3.color.g, arg_178_1.hightColor1.g, (arg_178_1.time_ - 0) / var_181_3), (Mathf.Lerp(iter_181_3.color.b, arg_178_1.hightColor1.b, (arg_178_1.time_ - 0) / var_181_3)))
							else
								local var_181_4 = Mathf.Lerp(iter_181_3.color.r, 1, (arg_178_1.time_ - 0) / var_181_3)

								iter_181_3.color = Color.New(var_181_4, var_181_4, var_181_4)
							end
						end
					end
				end
			end

			if arg_178_1.time_ >= 0 + var_181_3 and arg_178_1.time_ < 0 + var_181_3 + arg_181_0 and not isNil(var_181_2) and arg_178_1.var_.actorSpriteComps10014 then
				for iter_181_4, iter_181_5 in pairs(arg_178_1.var_.actorSpriteComps10014:ToTable()) do
					if iter_181_5 then
						iter_181_5.color = arg_178_1.isInRecall_ and (arg_178_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_178_1.var_.actorSpriteComps10014 = nil
			end

			local var_181_5 = arg_178_1.actors_["10014"].transform

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos10014 = var_181_5.localPosition
				var_181_5.localScale = Vector3.New(1, 1, 1)

				arg_178_1:CheckSpriteTmpPos("10014", 4)

				for iter_181_6 = 0, var_181_5.childCount - 1 do
					local var_181_6 = var_181_5:GetChild(iter_181_6)

					if var_181_6.name == "" or not string.find(var_181_6.name, "split") then
						var_181_6.gameObject:SetActive(true)
					else
						var_181_6.gameObject:SetActive(false)
					end
				end
			end

			local var_181_7 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_7 then
				var_181_5.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos10014, Vector3.New(420.9, -430.8, 6.9), (arg_178_1.time_ - 0) / var_181_7)
			end

			if arg_178_1.time_ >= 0 + var_181_7 and arg_178_1.time_ < 0 + var_181_7 + arg_181_0 then
				var_181_5.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_181_8 = arg_178_1.actors_["10115"]

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(var_181_8) and arg_178_1.var_.actorSpriteComps10115 == nil then
				arg_178_1.var_.actorSpriteComps10115 = var_181_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_181_9 = 0.2

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_9 and not isNil(var_181_8) then
				if arg_178_1.var_.actorSpriteComps10115 then
					for iter_181_7, iter_181_8 in pairs(arg_178_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_181_8 then
							if arg_178_1.isInRecall_ then
								iter_181_8.color = Color.New(Mathf.Lerp(iter_181_8.color.r, arg_178_1.hightColor2.r, (arg_178_1.time_ - 0) / var_181_9), Mathf.Lerp(iter_181_8.color.g, arg_178_1.hightColor2.g, (arg_178_1.time_ - 0) / var_181_9), (Mathf.Lerp(iter_181_8.color.b, arg_178_1.hightColor2.b, (arg_178_1.time_ - 0) / var_181_9)))
							else
								local var_181_10 = Mathf.Lerp(iter_181_8.color.r, 0.5, (arg_178_1.time_ - 0) / var_181_9)

								iter_181_8.color = Color.New(var_181_10, var_181_10, var_181_10)
							end
						end
					end
				end
			end

			if arg_178_1.time_ >= 0 + var_181_9 and arg_178_1.time_ < 0 + var_181_9 + arg_181_0 and not isNil(var_181_8) and arg_178_1.var_.actorSpriteComps10115 then
				for iter_181_9, iter_181_10 in pairs(arg_178_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_181_10 then
						iter_181_10.color = arg_178_1.isInRecall_ and (arg_178_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_178_1.var_.actorSpriteComps10115 = nil
			end

			local var_181_11 = arg_178_1.actors_["10115"].transform

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos10115 = var_181_11.localPosition
				var_181_11.localScale = Vector3.New(1, 1, 1)

				arg_178_1:CheckSpriteTmpPos("10115", 2)

				for iter_181_11 = 0, var_181_11.childCount - 1 do
					local var_181_12 = var_181_11:GetChild(iter_181_11)

					if var_181_12.name == "" or not string.find(var_181_12.name, "split") then
						var_181_12.gameObject:SetActive(true)
					else
						var_181_12.gameObject:SetActive(false)
					end
				end
			end

			local var_181_13 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_13 then
				var_181_11.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos10115, Vector3.New(-390, -387.3, -246.2), (arg_178_1.time_ - 0) / var_181_13)
			end

			if arg_178_1.time_ >= 0 + var_181_13 and arg_178_1.time_ < 0 + var_181_13 + arg_181_0 then
				var_181_11.localPosition = Vector3.New(-390, -387.3, -246.2)
			end

			local var_181_14 = 0
			local var_181_15 = 0.425

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_14 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_16 = arg_178_1:GetWordFromCfg(417261043)
				local var_181_17 = arg_178_1:FormatText(var_181_16.content)

				arg_178_1.text_.text = var_181_17

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_19 = 17 <= 0 and var_181_15 or var_181_15 * (utf8.len(var_181_17) / 17)

				if (17 <= 0 and var_181_15 or var_181_15 * (utf8.len(var_181_17) / 17)) > 0 and var_181_15 < var_181_19 then
					arg_178_1.talkMaxDuration = var_181_19

					if var_181_19 + var_181_14 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_19 + var_181_14
					end
				end

				arg_178_1.text_.text = var_181_17
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261043", "story_v_out_417261.awb") ~= 0 then
					local var_181_20 = manager.audio:GetVoiceLength("story_v_out_417261", "417261043", "story_v_out_417261.awb") / 1000

					if var_181_20 + var_181_14 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_20 + var_181_14
					end

					if var_181_16.prefab_name ~= "" and arg_178_1.actors_[var_181_16.prefab_name] ~= nil then
						local var_181_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_16.prefab_name].transform, "story_v_out_417261", "417261043", "story_v_out_417261.awb")

						arg_178_1:RecordAudio("417261043", var_181_21)
						arg_178_1:RecordAudio("417261043", var_181_21)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_417261", "417261043", "story_v_out_417261.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_417261", "417261043", "story_v_out_417261.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_22 = math.max(var_181_15, arg_178_1.talkMaxDuration)

			if var_181_14 <= arg_178_1.time_ and arg_178_1.time_ < var_181_14 + var_181_22 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_14) / var_181_22

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_14 + var_181_22 and arg_178_1.time_ < var_181_14 + var_181_22 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play417261044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 417261044
		arg_182_1.duration_ = 6.37

		local var_182_0 = {
			zh = 4.2,
			ja = 6.366
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
				arg_182_0:Play417261045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(arg_182_1.actors_["10115"]) and arg_182_1.var_.actorSpriteComps10115 == nil then
				arg_182_1.var_.actorSpriteComps10115 = arg_182_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_185_0 = 0.2

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 and not isNil(arg_182_1.actors_["10115"]) then
				if arg_182_1.var_.actorSpriteComps10115 then
					for iter_185_0, iter_185_1 in pairs(arg_182_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_185_1 then
							if arg_182_1.isInRecall_ then
								iter_185_1.color = Color.New(Mathf.Lerp(iter_185_1.color.r, arg_182_1.hightColor1.r, (arg_182_1.time_ - 0) / var_185_0), Mathf.Lerp(iter_185_1.color.g, arg_182_1.hightColor1.g, (arg_182_1.time_ - 0) / var_185_0), (Mathf.Lerp(iter_185_1.color.b, arg_182_1.hightColor1.b, (arg_182_1.time_ - 0) / var_185_0)))
							else
								local var_185_1 = Mathf.Lerp(iter_185_1.color.r, 1, (arg_182_1.time_ - 0) / var_185_0)

								iter_185_1.color = Color.New(var_185_1, var_185_1, var_185_1)
							end
						end
					end
				end
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 and not isNil(arg_182_1.actors_["10115"]) and arg_182_1.var_.actorSpriteComps10115 then
				for iter_185_2, iter_185_3 in pairs(arg_182_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_185_3 then
						iter_185_3.color = arg_182_1.isInRecall_ and (arg_182_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_182_1.var_.actorSpriteComps10115 = nil
			end

			local var_185_2 = arg_182_1.actors_["10014"]

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(var_185_2) and arg_182_1.var_.actorSpriteComps10014 == nil then
				arg_182_1.var_.actorSpriteComps10014 = var_185_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_185_3 = 0.2

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_3 and not isNil(var_185_2) then
				if arg_182_1.var_.actorSpriteComps10014 then
					for iter_185_4, iter_185_5 in pairs(arg_182_1.var_.actorSpriteComps10014:ToTable()) do
						if iter_185_5 then
							if arg_182_1.isInRecall_ then
								iter_185_5.color = Color.New(Mathf.Lerp(iter_185_5.color.r, arg_182_1.hightColor2.r, (arg_182_1.time_ - 0) / var_185_3), Mathf.Lerp(iter_185_5.color.g, arg_182_1.hightColor2.g, (arg_182_1.time_ - 0) / var_185_3), (Mathf.Lerp(iter_185_5.color.b, arg_182_1.hightColor2.b, (arg_182_1.time_ - 0) / var_185_3)))
							else
								local var_185_4 = Mathf.Lerp(iter_185_5.color.r, 0.5, (arg_182_1.time_ - 0) / var_185_3)

								iter_185_5.color = Color.New(var_185_4, var_185_4, var_185_4)
							end
						end
					end
				end
			end

			if arg_182_1.time_ >= 0 + var_185_3 and arg_182_1.time_ < 0 + var_185_3 + arg_185_0 and not isNil(var_185_2) and arg_182_1.var_.actorSpriteComps10014 then
				for iter_185_6, iter_185_7 in pairs(arg_182_1.var_.actorSpriteComps10014:ToTable()) do
					if iter_185_7 then
						iter_185_7.color = arg_182_1.isInRecall_ and (arg_182_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_182_1.var_.actorSpriteComps10014 = nil
			end

			local var_185_5 = 0
			local var_185_6 = 0.45

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_5 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_7 = arg_182_1:GetWordFromCfg(417261044)
				local var_185_8 = arg_182_1:FormatText(var_185_7.content)

				arg_182_1.text_.text = var_185_8

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_10 = 18 <= 0 and var_185_6 or var_185_6 * (utf8.len(var_185_8) / 18)

				if (18 <= 0 and var_185_6 or var_185_6 * (utf8.len(var_185_8) / 18)) > 0 and var_185_6 < var_185_10 then
					arg_182_1.talkMaxDuration = var_185_10

					if var_185_10 + var_185_5 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_10 + var_185_5
					end
				end

				arg_182_1.text_.text = var_185_8
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261044", "story_v_out_417261.awb") ~= 0 then
					local var_185_11 = manager.audio:GetVoiceLength("story_v_out_417261", "417261044", "story_v_out_417261.awb") / 1000

					if var_185_11 + var_185_5 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_11 + var_185_5
					end

					if var_185_7.prefab_name ~= "" and arg_182_1.actors_[var_185_7.prefab_name] ~= nil then
						local var_185_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_7.prefab_name].transform, "story_v_out_417261", "417261044", "story_v_out_417261.awb")

						arg_182_1:RecordAudio("417261044", var_185_12)
						arg_182_1:RecordAudio("417261044", var_185_12)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_417261", "417261044", "story_v_out_417261.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_417261", "417261044", "story_v_out_417261.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_13 = math.max(var_185_6, arg_182_1.talkMaxDuration)

			if var_185_5 <= arg_182_1.time_ and arg_182_1.time_ < var_185_5 + var_185_13 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_5) / var_185_13

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_5 + var_185_13 and arg_182_1.time_ < var_185_5 + var_185_13 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play417261045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 417261045
		arg_186_1.duration_ = 5.7

		local var_186_0 = {
			zh = 2.9,
			ja = 5.7
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play417261046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(arg_186_1.actors_["10014"]) and arg_186_1.var_.actorSpriteComps10014 == nil then
				arg_186_1.var_.actorSpriteComps10014 = arg_186_1.actors_["10014"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_189_0 = 0.2

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 and not isNil(arg_186_1.actors_["10014"]) then
				if arg_186_1.var_.actorSpriteComps10014 then
					for iter_189_0, iter_189_1 in pairs(arg_186_1.var_.actorSpriteComps10014:ToTable()) do
						if iter_189_1 then
							if arg_186_1.isInRecall_ then
								iter_189_1.color = Color.New(Mathf.Lerp(iter_189_1.color.r, arg_186_1.hightColor1.r, (arg_186_1.time_ - 0) / var_189_0), Mathf.Lerp(iter_189_1.color.g, arg_186_1.hightColor1.g, (arg_186_1.time_ - 0) / var_189_0), (Mathf.Lerp(iter_189_1.color.b, arg_186_1.hightColor1.b, (arg_186_1.time_ - 0) / var_189_0)))
							else
								local var_189_1 = Mathf.Lerp(iter_189_1.color.r, 1, (arg_186_1.time_ - 0) / var_189_0)

								iter_189_1.color = Color.New(var_189_1, var_189_1, var_189_1)
							end
						end
					end
				end
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 and not isNil(arg_186_1.actors_["10014"]) and arg_186_1.var_.actorSpriteComps10014 then
				for iter_189_2, iter_189_3 in pairs(arg_186_1.var_.actorSpriteComps10014:ToTable()) do
					if iter_189_3 then
						iter_189_3.color = arg_186_1.isInRecall_ and (arg_186_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_186_1.var_.actorSpriteComps10014 = nil
			end

			local var_189_2 = arg_186_1.actors_["10115"]

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(var_189_2) and arg_186_1.var_.actorSpriteComps10115 == nil then
				arg_186_1.var_.actorSpriteComps10115 = var_189_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_189_3 = 0.2

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_3 and not isNil(var_189_2) then
				if arg_186_1.var_.actorSpriteComps10115 then
					for iter_189_4, iter_189_5 in pairs(arg_186_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_189_5 then
							if arg_186_1.isInRecall_ then
								iter_189_5.color = Color.New(Mathf.Lerp(iter_189_5.color.r, arg_186_1.hightColor2.r, (arg_186_1.time_ - 0) / var_189_3), Mathf.Lerp(iter_189_5.color.g, arg_186_1.hightColor2.g, (arg_186_1.time_ - 0) / var_189_3), (Mathf.Lerp(iter_189_5.color.b, arg_186_1.hightColor2.b, (arg_186_1.time_ - 0) / var_189_3)))
							else
								local var_189_4 = Mathf.Lerp(iter_189_5.color.r, 0.5, (arg_186_1.time_ - 0) / var_189_3)

								iter_189_5.color = Color.New(var_189_4, var_189_4, var_189_4)
							end
						end
					end
				end
			end

			if arg_186_1.time_ >= 0 + var_189_3 and arg_186_1.time_ < 0 + var_189_3 + arg_189_0 and not isNil(var_189_2) and arg_186_1.var_.actorSpriteComps10115 then
				for iter_189_6, iter_189_7 in pairs(arg_186_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_189_7 then
						iter_189_7.color = arg_186_1.isInRecall_ and (arg_186_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_186_1.var_.actorSpriteComps10115 = nil
			end

			local var_189_5 = 0
			local var_189_6 = 0.275

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_5 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_7 = arg_186_1:GetWordFromCfg(417261045)
				local var_189_8 = arg_186_1:FormatText(var_189_7.content)

				arg_186_1.text_.text = var_189_8

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_10 = 11 <= 0 and var_189_6 or var_189_6 * (utf8.len(var_189_8) / 11)

				if (11 <= 0 and var_189_6 or var_189_6 * (utf8.len(var_189_8) / 11)) > 0 and var_189_6 < var_189_10 then
					arg_186_1.talkMaxDuration = var_189_10

					if var_189_10 + var_189_5 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_10 + var_189_5
					end
				end

				arg_186_1.text_.text = var_189_8
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261045", "story_v_out_417261.awb") ~= 0 then
					local var_189_11 = manager.audio:GetVoiceLength("story_v_out_417261", "417261045", "story_v_out_417261.awb") / 1000

					if var_189_11 + var_189_5 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_11 + var_189_5
					end

					if var_189_7.prefab_name ~= "" and arg_186_1.actors_[var_189_7.prefab_name] ~= nil then
						local var_189_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_7.prefab_name].transform, "story_v_out_417261", "417261045", "story_v_out_417261.awb")

						arg_186_1:RecordAudio("417261045", var_189_12)
						arg_186_1:RecordAudio("417261045", var_189_12)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_417261", "417261045", "story_v_out_417261.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_417261", "417261045", "story_v_out_417261.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_13 = math.max(var_189_6, arg_186_1.talkMaxDuration)

			if var_189_5 <= arg_186_1.time_ and arg_186_1.time_ < var_189_5 + var_189_13 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_5) / var_189_13

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_5 + var_189_13 and arg_186_1.time_ < var_189_5 + var_189_13 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play417261046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 417261046
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play417261047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(arg_190_1.actors_["10014"]) and arg_190_1.var_.actorSpriteComps10014 == nil then
				arg_190_1.var_.actorSpriteComps10014 = arg_190_1.actors_["10014"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_193_0 = 0.2

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 and not isNil(arg_190_1.actors_["10014"]) then
				if arg_190_1.var_.actorSpriteComps10014 then
					for iter_193_0, iter_193_1 in pairs(arg_190_1.var_.actorSpriteComps10014:ToTable()) do
						if iter_193_1 then
							if arg_190_1.isInRecall_ then
								iter_193_1.color = Color.New(Mathf.Lerp(iter_193_1.color.r, arg_190_1.hightColor2.r, (arg_190_1.time_ - 0) / var_193_0), Mathf.Lerp(iter_193_1.color.g, arg_190_1.hightColor2.g, (arg_190_1.time_ - 0) / var_193_0), (Mathf.Lerp(iter_193_1.color.b, arg_190_1.hightColor2.b, (arg_190_1.time_ - 0) / var_193_0)))
							else
								local var_193_1 = Mathf.Lerp(iter_193_1.color.r, 0.5, (arg_190_1.time_ - 0) / var_193_0)

								iter_193_1.color = Color.New(var_193_1, var_193_1, var_193_1)
							end
						end
					end
				end
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 and not isNil(arg_190_1.actors_["10014"]) and arg_190_1.var_.actorSpriteComps10014 then
				for iter_193_2, iter_193_3 in pairs(arg_190_1.var_.actorSpriteComps10014:ToTable()) do
					if iter_193_3 then
						iter_193_3.color = arg_190_1.isInRecall_ and (arg_190_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_190_1.var_.actorSpriteComps10014 = nil
			end

			local var_193_2 = 0
			local var_193_3 = 1

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_2 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, false)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_4 = arg_190_1:FormatText(arg_190_1:GetWordFromCfg(417261046).content)

				arg_190_1.text_.text = var_193_4

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_6 = 40 <= 0 and var_193_3 or var_193_3 * (utf8.len(var_193_4) / 40)

				if (40 <= 0 and var_193_3 or var_193_3 * (utf8.len(var_193_4) / 40)) > 0 and var_193_3 < var_193_6 then
					arg_190_1.talkMaxDuration = var_193_6

					if var_193_6 + var_193_2 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_6 + var_193_2
					end
				end

				arg_190_1.text_.text = var_193_4
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_7 = math.max(var_193_3, arg_190_1.talkMaxDuration)

			if var_193_2 <= arg_190_1.time_ and arg_190_1.time_ < var_193_2 + var_193_7 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_2) / var_193_7

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_2 + var_193_7 and arg_190_1.time_ < var_193_2 + var_193_7 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play417261047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 417261047
		arg_194_1.duration_ = 7.73

		local var_194_0 = {
			zh = 5.366,
			ja = 7.733
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play417261048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(arg_194_1.actors_["10115"]) and arg_194_1.var_.actorSpriteComps10115 == nil then
				arg_194_1.var_.actorSpriteComps10115 = arg_194_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_197_0 = 0.2

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 and not isNil(arg_194_1.actors_["10115"]) then
				if arg_194_1.var_.actorSpriteComps10115 then
					for iter_197_0, iter_197_1 in pairs(arg_194_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_197_1 then
							if arg_194_1.isInRecall_ then
								iter_197_1.color = Color.New(Mathf.Lerp(iter_197_1.color.r, arg_194_1.hightColor1.r, (arg_194_1.time_ - 0) / var_197_0), Mathf.Lerp(iter_197_1.color.g, arg_194_1.hightColor1.g, (arg_194_1.time_ - 0) / var_197_0), (Mathf.Lerp(iter_197_1.color.b, arg_194_1.hightColor1.b, (arg_194_1.time_ - 0) / var_197_0)))
							else
								local var_197_1 = Mathf.Lerp(iter_197_1.color.r, 1, (arg_194_1.time_ - 0) / var_197_0)

								iter_197_1.color = Color.New(var_197_1, var_197_1, var_197_1)
							end
						end
					end
				end
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 and not isNil(arg_194_1.actors_["10115"]) and arg_194_1.var_.actorSpriteComps10115 then
				for iter_197_2, iter_197_3 in pairs(arg_194_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_197_3 then
						iter_197_3.color = arg_194_1.isInRecall_ and (arg_194_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_194_1.var_.actorSpriteComps10115 = nil
			end

			local var_197_2 = 0
			local var_197_3 = 0.8

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_2 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_4 = arg_194_1:GetWordFromCfg(417261047)
				local var_197_5 = arg_194_1:FormatText(var_197_4.content)

				arg_194_1.text_.text = var_197_5

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_7 = 32 <= 0 and var_197_3 or var_197_3 * (utf8.len(var_197_5) / 32)

				if (32 <= 0 and var_197_3 or var_197_3 * (utf8.len(var_197_5) / 32)) > 0 and var_197_3 < var_197_7 then
					arg_194_1.talkMaxDuration = var_197_7

					if var_197_7 + var_197_2 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_7 + var_197_2
					end
				end

				arg_194_1.text_.text = var_197_5
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261047", "story_v_out_417261.awb") ~= 0 then
					local var_197_8 = manager.audio:GetVoiceLength("story_v_out_417261", "417261047", "story_v_out_417261.awb") / 1000

					if var_197_8 + var_197_2 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_8 + var_197_2
					end

					if var_197_4.prefab_name ~= "" and arg_194_1.actors_[var_197_4.prefab_name] ~= nil then
						local var_197_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_4.prefab_name].transform, "story_v_out_417261", "417261047", "story_v_out_417261.awb")

						arg_194_1:RecordAudio("417261047", var_197_9)
						arg_194_1:RecordAudio("417261047", var_197_9)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_417261", "417261047", "story_v_out_417261.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_417261", "417261047", "story_v_out_417261.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_10 = math.max(var_197_3, arg_194_1.talkMaxDuration)

			if var_197_2 <= arg_194_1.time_ and arg_194_1.time_ < var_197_2 + var_197_10 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_2) / var_197_10

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_2 + var_197_10 and arg_194_1.time_ < var_197_2 + var_197_10 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play417261048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 417261048
		arg_198_1.duration_ = 2.2

		local var_198_0 = {
			zh = 1.3,
			ja = 2.2
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play417261049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(arg_198_1.actors_["10014"]) and arg_198_1.var_.actorSpriteComps10014 == nil then
				arg_198_1.var_.actorSpriteComps10014 = arg_198_1.actors_["10014"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_201_0 = 0.2

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 and not isNil(arg_198_1.actors_["10014"]) then
				if arg_198_1.var_.actorSpriteComps10014 then
					for iter_201_0, iter_201_1 in pairs(arg_198_1.var_.actorSpriteComps10014:ToTable()) do
						if iter_201_1 then
							if arg_198_1.isInRecall_ then
								iter_201_1.color = Color.New(Mathf.Lerp(iter_201_1.color.r, arg_198_1.hightColor1.r, (arg_198_1.time_ - 0) / var_201_0), Mathf.Lerp(iter_201_1.color.g, arg_198_1.hightColor1.g, (arg_198_1.time_ - 0) / var_201_0), (Mathf.Lerp(iter_201_1.color.b, arg_198_1.hightColor1.b, (arg_198_1.time_ - 0) / var_201_0)))
							else
								local var_201_1 = Mathf.Lerp(iter_201_1.color.r, 1, (arg_198_1.time_ - 0) / var_201_0)

								iter_201_1.color = Color.New(var_201_1, var_201_1, var_201_1)
							end
						end
					end
				end
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 and not isNil(arg_198_1.actors_["10014"]) and arg_198_1.var_.actorSpriteComps10014 then
				for iter_201_2, iter_201_3 in pairs(arg_198_1.var_.actorSpriteComps10014:ToTable()) do
					if iter_201_3 then
						iter_201_3.color = arg_198_1.isInRecall_ and (arg_198_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_198_1.var_.actorSpriteComps10014 = nil
			end

			local var_201_2 = arg_198_1.actors_["10115"]

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(var_201_2) and arg_198_1.var_.actorSpriteComps10115 == nil then
				arg_198_1.var_.actorSpriteComps10115 = var_201_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_201_3 = 0.2

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_3 and not isNil(var_201_2) then
				if arg_198_1.var_.actorSpriteComps10115 then
					for iter_201_4, iter_201_5 in pairs(arg_198_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_201_5 then
							if arg_198_1.isInRecall_ then
								iter_201_5.color = Color.New(Mathf.Lerp(iter_201_5.color.r, arg_198_1.hightColor2.r, (arg_198_1.time_ - 0) / var_201_3), Mathf.Lerp(iter_201_5.color.g, arg_198_1.hightColor2.g, (arg_198_1.time_ - 0) / var_201_3), (Mathf.Lerp(iter_201_5.color.b, arg_198_1.hightColor2.b, (arg_198_1.time_ - 0) / var_201_3)))
							else
								local var_201_4 = Mathf.Lerp(iter_201_5.color.r, 0.5, (arg_198_1.time_ - 0) / var_201_3)

								iter_201_5.color = Color.New(var_201_4, var_201_4, var_201_4)
							end
						end
					end
				end
			end

			if arg_198_1.time_ >= 0 + var_201_3 and arg_198_1.time_ < 0 + var_201_3 + arg_201_0 and not isNil(var_201_2) and arg_198_1.var_.actorSpriteComps10115 then
				for iter_201_6, iter_201_7 in pairs(arg_198_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_201_7 then
						iter_201_7.color = arg_198_1.isInRecall_ and (arg_198_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_198_1.var_.actorSpriteComps10115 = nil
			end

			local var_201_5 = 0
			local var_201_6 = 0.125

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_5 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_7 = arg_198_1:GetWordFromCfg(417261048)
				local var_201_8 = arg_198_1:FormatText(var_201_7.content)

				arg_198_1.text_.text = var_201_8

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_10 = 5 <= 0 and var_201_6 or var_201_6 * (utf8.len(var_201_8) / 5)

				if (5 <= 0 and var_201_6 or var_201_6 * (utf8.len(var_201_8) / 5)) > 0 and var_201_6 < var_201_10 then
					arg_198_1.talkMaxDuration = var_201_10

					if var_201_10 + var_201_5 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_10 + var_201_5
					end
				end

				arg_198_1.text_.text = var_201_8
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261048", "story_v_out_417261.awb") ~= 0 then
					local var_201_11 = manager.audio:GetVoiceLength("story_v_out_417261", "417261048", "story_v_out_417261.awb") / 1000

					if var_201_11 + var_201_5 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_11 + var_201_5
					end

					if var_201_7.prefab_name ~= "" and arg_198_1.actors_[var_201_7.prefab_name] ~= nil then
						local var_201_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_7.prefab_name].transform, "story_v_out_417261", "417261048", "story_v_out_417261.awb")

						arg_198_1:RecordAudio("417261048", var_201_12)
						arg_198_1:RecordAudio("417261048", var_201_12)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_417261", "417261048", "story_v_out_417261.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_417261", "417261048", "story_v_out_417261.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_13 = math.max(var_201_6, arg_198_1.talkMaxDuration)

			if var_201_5 <= arg_198_1.time_ and arg_198_1.time_ < var_201_5 + var_201_13 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_5) / var_201_13

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_5 + var_201_13 and arg_198_1.time_ < var_201_5 + var_201_13 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play417261049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 417261049
		arg_202_1.duration_ = 8.73

		local var_202_0 = {
			zh = 6.533,
			ja = 8.733
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play417261050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 0.7

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_1 = arg_202_1:GetWordFromCfg(417261049)
				local var_205_2 = arg_202_1:FormatText(var_205_1.content)

				arg_202_1.text_.text = var_205_2

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_4 = 28 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_2) / 28)

				if (28 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_2) / 28)) > 0 and var_205_0 < var_205_4 then
					arg_202_1.talkMaxDuration = var_205_4

					if var_205_4 + 0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_4 + 0
					end
				end

				arg_202_1.text_.text = var_205_2
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261049", "story_v_out_417261.awb") ~= 0 then
					local var_205_5 = manager.audio:GetVoiceLength("story_v_out_417261", "417261049", "story_v_out_417261.awb") / 1000

					if var_205_5 + 0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_5 + 0
					end

					if var_205_1.prefab_name ~= "" and arg_202_1.actors_[var_205_1.prefab_name] ~= nil then
						local var_205_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_1.prefab_name].transform, "story_v_out_417261", "417261049", "story_v_out_417261.awb")

						arg_202_1:RecordAudio("417261049", var_205_6)
						arg_202_1:RecordAudio("417261049", var_205_6)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_417261", "417261049", "story_v_out_417261.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_417261", "417261049", "story_v_out_417261.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_7 = math.max(var_205_0, arg_202_1.talkMaxDuration)

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_7 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - 0) / var_205_7

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= 0 + var_205_7 and arg_202_1.time_ < 0 + var_205_7 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play417261050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 417261050
		arg_206_1.duration_ = 8

		local var_206_0 = {
			zh = 5.233,
			ja = 8
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play417261051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 0.6

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_1 = arg_206_1:GetWordFromCfg(417261050)
				local var_209_2 = arg_206_1:FormatText(var_209_1.content)

				arg_206_1.text_.text = var_209_2

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_4 = 24 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_2) / 24)

				if (24 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_2) / 24)) > 0 and var_209_0 < var_209_4 then
					arg_206_1.talkMaxDuration = var_209_4

					if var_209_4 + 0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_4 + 0
					end
				end

				arg_206_1.text_.text = var_209_2
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261050", "story_v_out_417261.awb") ~= 0 then
					local var_209_5 = manager.audio:GetVoiceLength("story_v_out_417261", "417261050", "story_v_out_417261.awb") / 1000

					if var_209_5 + 0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_5 + 0
					end

					if var_209_1.prefab_name ~= "" and arg_206_1.actors_[var_209_1.prefab_name] ~= nil then
						local var_209_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_1.prefab_name].transform, "story_v_out_417261", "417261050", "story_v_out_417261.awb")

						arg_206_1:RecordAudio("417261050", var_209_6)
						arg_206_1:RecordAudio("417261050", var_209_6)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_417261", "417261050", "story_v_out_417261.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_417261", "417261050", "story_v_out_417261.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_7 = math.max(var_209_0, arg_206_1.talkMaxDuration)

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_7 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - 0) / var_209_7

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= 0 + var_209_7 and arg_206_1.time_ < 0 + var_209_7 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play417261051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 417261051
		arg_210_1.duration_ = 5.8

		local var_210_0 = {
			zh = 4.133,
			ja = 5.8
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play417261052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(arg_210_1.actors_["10014"]) and arg_210_1.var_.actorSpriteComps10014 == nil then
				arg_210_1.var_.actorSpriteComps10014 = arg_210_1.actors_["10014"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_213_0 = 0.2

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 and not isNil(arg_210_1.actors_["10014"]) then
				if arg_210_1.var_.actorSpriteComps10014 then
					for iter_213_0, iter_213_1 in pairs(arg_210_1.var_.actorSpriteComps10014:ToTable()) do
						if iter_213_1 then
							if arg_210_1.isInRecall_ then
								iter_213_1.color = Color.New(Mathf.Lerp(iter_213_1.color.r, arg_210_1.hightColor2.r, (arg_210_1.time_ - 0) / var_213_0), Mathf.Lerp(iter_213_1.color.g, arg_210_1.hightColor2.g, (arg_210_1.time_ - 0) / var_213_0), (Mathf.Lerp(iter_213_1.color.b, arg_210_1.hightColor2.b, (arg_210_1.time_ - 0) / var_213_0)))
							else
								local var_213_1 = Mathf.Lerp(iter_213_1.color.r, 0.5, (arg_210_1.time_ - 0) / var_213_0)

								iter_213_1.color = Color.New(var_213_1, var_213_1, var_213_1)
							end
						end
					end
				end
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 and not isNil(arg_210_1.actors_["10014"]) and arg_210_1.var_.actorSpriteComps10014 then
				for iter_213_2, iter_213_3 in pairs(arg_210_1.var_.actorSpriteComps10014:ToTable()) do
					if iter_213_3 then
						iter_213_3.color = arg_210_1.isInRecall_ and (arg_210_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_210_1.var_.actorSpriteComps10014 = nil
			end

			local var_213_2 = arg_210_1.actors_["10115"]

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(var_213_2) and arg_210_1.var_.actorSpriteComps10115 == nil then
				arg_210_1.var_.actorSpriteComps10115 = var_213_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_213_3 = 0.2

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_3 and not isNil(var_213_2) then
				if arg_210_1.var_.actorSpriteComps10115 then
					for iter_213_4, iter_213_5 in pairs(arg_210_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_213_5 then
							if arg_210_1.isInRecall_ then
								iter_213_5.color = Color.New(Mathf.Lerp(iter_213_5.color.r, arg_210_1.hightColor1.r, (arg_210_1.time_ - 0) / var_213_3), Mathf.Lerp(iter_213_5.color.g, arg_210_1.hightColor1.g, (arg_210_1.time_ - 0) / var_213_3), (Mathf.Lerp(iter_213_5.color.b, arg_210_1.hightColor1.b, (arg_210_1.time_ - 0) / var_213_3)))
							else
								local var_213_4 = Mathf.Lerp(iter_213_5.color.r, 1, (arg_210_1.time_ - 0) / var_213_3)

								iter_213_5.color = Color.New(var_213_4, var_213_4, var_213_4)
							end
						end
					end
				end
			end

			if arg_210_1.time_ >= 0 + var_213_3 and arg_210_1.time_ < 0 + var_213_3 + arg_213_0 and not isNil(var_213_2) and arg_210_1.var_.actorSpriteComps10115 then
				for iter_213_6, iter_213_7 in pairs(arg_210_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_213_7 then
						iter_213_7.color = arg_210_1.isInRecall_ and (arg_210_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_210_1.var_.actorSpriteComps10115 = nil
			end

			local var_213_5 = 0
			local var_213_6 = 0.55

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_5 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_7 = arg_210_1:GetWordFromCfg(417261051)
				local var_213_8 = arg_210_1:FormatText(var_213_7.content)

				arg_210_1.text_.text = var_213_8

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_10 = 22 <= 0 and var_213_6 or var_213_6 * (utf8.len(var_213_8) / 22)

				if (22 <= 0 and var_213_6 or var_213_6 * (utf8.len(var_213_8) / 22)) > 0 and var_213_6 < var_213_10 then
					arg_210_1.talkMaxDuration = var_213_10

					if var_213_10 + var_213_5 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_10 + var_213_5
					end
				end

				arg_210_1.text_.text = var_213_8
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261051", "story_v_out_417261.awb") ~= 0 then
					local var_213_11 = manager.audio:GetVoiceLength("story_v_out_417261", "417261051", "story_v_out_417261.awb") / 1000

					if var_213_11 + var_213_5 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_11 + var_213_5
					end

					if var_213_7.prefab_name ~= "" and arg_210_1.actors_[var_213_7.prefab_name] ~= nil then
						local var_213_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_7.prefab_name].transform, "story_v_out_417261", "417261051", "story_v_out_417261.awb")

						arg_210_1:RecordAudio("417261051", var_213_12)
						arg_210_1:RecordAudio("417261051", var_213_12)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_417261", "417261051", "story_v_out_417261.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_417261", "417261051", "story_v_out_417261.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_13 = math.max(var_213_6, arg_210_1.talkMaxDuration)

			if var_213_5 <= arg_210_1.time_ and arg_210_1.time_ < var_213_5 + var_213_13 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_5) / var_213_13

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_5 + var_213_13 and arg_210_1.time_ < var_213_5 + var_213_13 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play417261052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 417261052
		arg_214_1.duration_ = 5.47

		local var_214_0 = {
			zh = 2.266,
			ja = 5.466
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play417261053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(arg_214_1.actors_["10014"]) and arg_214_1.var_.actorSpriteComps10014 == nil then
				arg_214_1.var_.actorSpriteComps10014 = arg_214_1.actors_["10014"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_217_0 = 0.2

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 and not isNil(arg_214_1.actors_["10014"]) then
				if arg_214_1.var_.actorSpriteComps10014 then
					for iter_217_0, iter_217_1 in pairs(arg_214_1.var_.actorSpriteComps10014:ToTable()) do
						if iter_217_1 then
							if arg_214_1.isInRecall_ then
								iter_217_1.color = Color.New(Mathf.Lerp(iter_217_1.color.r, arg_214_1.hightColor1.r, (arg_214_1.time_ - 0) / var_217_0), Mathf.Lerp(iter_217_1.color.g, arg_214_1.hightColor1.g, (arg_214_1.time_ - 0) / var_217_0), (Mathf.Lerp(iter_217_1.color.b, arg_214_1.hightColor1.b, (arg_214_1.time_ - 0) / var_217_0)))
							else
								local var_217_1 = Mathf.Lerp(iter_217_1.color.r, 1, (arg_214_1.time_ - 0) / var_217_0)

								iter_217_1.color = Color.New(var_217_1, var_217_1, var_217_1)
							end
						end
					end
				end
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 and not isNil(arg_214_1.actors_["10014"]) and arg_214_1.var_.actorSpriteComps10014 then
				for iter_217_2, iter_217_3 in pairs(arg_214_1.var_.actorSpriteComps10014:ToTable()) do
					if iter_217_3 then
						iter_217_3.color = arg_214_1.isInRecall_ and (arg_214_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_214_1.var_.actorSpriteComps10014 = nil
			end

			local var_217_2 = arg_214_1.actors_["10115"]

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(var_217_2) and arg_214_1.var_.actorSpriteComps10115 == nil then
				arg_214_1.var_.actorSpriteComps10115 = var_217_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_217_3 = 0.2

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_3 and not isNil(var_217_2) then
				if arg_214_1.var_.actorSpriteComps10115 then
					for iter_217_4, iter_217_5 in pairs(arg_214_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_217_5 then
							if arg_214_1.isInRecall_ then
								iter_217_5.color = Color.New(Mathf.Lerp(iter_217_5.color.r, arg_214_1.hightColor2.r, (arg_214_1.time_ - 0) / var_217_3), Mathf.Lerp(iter_217_5.color.g, arg_214_1.hightColor2.g, (arg_214_1.time_ - 0) / var_217_3), (Mathf.Lerp(iter_217_5.color.b, arg_214_1.hightColor2.b, (arg_214_1.time_ - 0) / var_217_3)))
							else
								local var_217_4 = Mathf.Lerp(iter_217_5.color.r, 0.5, (arg_214_1.time_ - 0) / var_217_3)

								iter_217_5.color = Color.New(var_217_4, var_217_4, var_217_4)
							end
						end
					end
				end
			end

			if arg_214_1.time_ >= 0 + var_217_3 and arg_214_1.time_ < 0 + var_217_3 + arg_217_0 and not isNil(var_217_2) and arg_214_1.var_.actorSpriteComps10115 then
				for iter_217_6, iter_217_7 in pairs(arg_214_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_217_7 then
						iter_217_7.color = arg_214_1.isInRecall_ and (arg_214_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_214_1.var_.actorSpriteComps10115 = nil
			end

			local var_217_5 = 0
			local var_217_6 = 0.25

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_5 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_7 = arg_214_1:GetWordFromCfg(417261052)
				local var_217_8 = arg_214_1:FormatText(var_217_7.content)

				arg_214_1.text_.text = var_217_8

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_10 = 10 <= 0 and var_217_6 or var_217_6 * (utf8.len(var_217_8) / 10)

				if (10 <= 0 and var_217_6 or var_217_6 * (utf8.len(var_217_8) / 10)) > 0 and var_217_6 < var_217_10 then
					arg_214_1.talkMaxDuration = var_217_10

					if var_217_10 + var_217_5 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_10 + var_217_5
					end
				end

				arg_214_1.text_.text = var_217_8
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261052", "story_v_out_417261.awb") ~= 0 then
					local var_217_11 = manager.audio:GetVoiceLength("story_v_out_417261", "417261052", "story_v_out_417261.awb") / 1000

					if var_217_11 + var_217_5 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_11 + var_217_5
					end

					if var_217_7.prefab_name ~= "" and arg_214_1.actors_[var_217_7.prefab_name] ~= nil then
						local var_217_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_7.prefab_name].transform, "story_v_out_417261", "417261052", "story_v_out_417261.awb")

						arg_214_1:RecordAudio("417261052", var_217_12)
						arg_214_1:RecordAudio("417261052", var_217_12)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_417261", "417261052", "story_v_out_417261.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_417261", "417261052", "story_v_out_417261.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_13 = math.max(var_217_6, arg_214_1.talkMaxDuration)

			if var_217_5 <= arg_214_1.time_ and arg_214_1.time_ < var_217_5 + var_217_13 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_5) / var_217_13

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_5 + var_217_13 and arg_214_1.time_ < var_217_5 + var_217_13 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play417261053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 417261053
		arg_218_1.duration_ = 15.17

		local var_218_0 = {
			zh = 11.866,
			ja = 15.166
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play417261054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 1.2

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_1 = arg_218_1:GetWordFromCfg(417261053)
				local var_221_2 = arg_218_1:FormatText(var_221_1.content)

				arg_218_1.text_.text = var_221_2

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_4 = 48 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_2) / 48)

				if (48 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_2) / 48)) > 0 and var_221_0 < var_221_4 then
					arg_218_1.talkMaxDuration = var_221_4

					if var_221_4 + 0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_4 + 0
					end
				end

				arg_218_1.text_.text = var_221_2
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261053", "story_v_out_417261.awb") ~= 0 then
					local var_221_5 = manager.audio:GetVoiceLength("story_v_out_417261", "417261053", "story_v_out_417261.awb") / 1000

					if var_221_5 + 0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_5 + 0
					end

					if var_221_1.prefab_name ~= "" and arg_218_1.actors_[var_221_1.prefab_name] ~= nil then
						local var_221_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_1.prefab_name].transform, "story_v_out_417261", "417261053", "story_v_out_417261.awb")

						arg_218_1:RecordAudio("417261053", var_221_6)
						arg_218_1:RecordAudio("417261053", var_221_6)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_417261", "417261053", "story_v_out_417261.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_417261", "417261053", "story_v_out_417261.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_7 = math.max(var_221_0, arg_218_1.talkMaxDuration)

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_7 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - 0) / var_221_7

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= 0 + var_221_7 and arg_218_1.time_ < 0 + var_221_7 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play417261054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 417261054
		arg_222_1.duration_ = 7.83

		local var_222_0 = {
			zh = 4.2,
			ja = 7.833
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play417261055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(arg_222_1.actors_["10014"]) and arg_222_1.var_.actorSpriteComps10014 == nil then
				arg_222_1.var_.actorSpriteComps10014 = arg_222_1.actors_["10014"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_0 = 0.2

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 and not isNil(arg_222_1.actors_["10014"]) then
				if arg_222_1.var_.actorSpriteComps10014 then
					for iter_225_0, iter_225_1 in pairs(arg_222_1.var_.actorSpriteComps10014:ToTable()) do
						if iter_225_1 then
							if arg_222_1.isInRecall_ then
								iter_225_1.color = Color.New(Mathf.Lerp(iter_225_1.color.r, arg_222_1.hightColor2.r, (arg_222_1.time_ - 0) / var_225_0), Mathf.Lerp(iter_225_1.color.g, arg_222_1.hightColor2.g, (arg_222_1.time_ - 0) / var_225_0), (Mathf.Lerp(iter_225_1.color.b, arg_222_1.hightColor2.b, (arg_222_1.time_ - 0) / var_225_0)))
							else
								local var_225_1 = Mathf.Lerp(iter_225_1.color.r, 0.5, (arg_222_1.time_ - 0) / var_225_0)

								iter_225_1.color = Color.New(var_225_1, var_225_1, var_225_1)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 and not isNil(arg_222_1.actors_["10014"]) and arg_222_1.var_.actorSpriteComps10014 then
				for iter_225_2, iter_225_3 in pairs(arg_222_1.var_.actorSpriteComps10014:ToTable()) do
					if iter_225_3 then
						iter_225_3.color = arg_222_1.isInRecall_ and (arg_222_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_222_1.var_.actorSpriteComps10014 = nil
			end

			local var_225_2 = arg_222_1.actors_["10115"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_2) and arg_222_1.var_.actorSpriteComps10115 == nil then
				arg_222_1.var_.actorSpriteComps10115 = var_225_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_3 = 0.2

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_3 and not isNil(var_225_2) then
				if arg_222_1.var_.actorSpriteComps10115 then
					for iter_225_4, iter_225_5 in pairs(arg_222_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_225_5 then
							if arg_222_1.isInRecall_ then
								iter_225_5.color = Color.New(Mathf.Lerp(iter_225_5.color.r, arg_222_1.hightColor1.r, (arg_222_1.time_ - 0) / var_225_3), Mathf.Lerp(iter_225_5.color.g, arg_222_1.hightColor1.g, (arg_222_1.time_ - 0) / var_225_3), (Mathf.Lerp(iter_225_5.color.b, arg_222_1.hightColor1.b, (arg_222_1.time_ - 0) / var_225_3)))
							else
								local var_225_4 = Mathf.Lerp(iter_225_5.color.r, 1, (arg_222_1.time_ - 0) / var_225_3)

								iter_225_5.color = Color.New(var_225_4, var_225_4, var_225_4)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= 0 + var_225_3 and arg_222_1.time_ < 0 + var_225_3 + arg_225_0 and not isNil(var_225_2) and arg_222_1.var_.actorSpriteComps10115 then
				for iter_225_6, iter_225_7 in pairs(arg_222_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_225_7 then
						iter_225_7.color = arg_222_1.isInRecall_ and (arg_222_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_222_1.var_.actorSpriteComps10115 = nil
			end

			local var_225_5 = 0
			local var_225_6 = 0.45

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_5 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_7 = arg_222_1:GetWordFromCfg(417261054)
				local var_225_8 = arg_222_1:FormatText(var_225_7.content)

				arg_222_1.text_.text = var_225_8

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_10 = 18 <= 0 and var_225_6 or var_225_6 * (utf8.len(var_225_8) / 18)

				if (18 <= 0 and var_225_6 or var_225_6 * (utf8.len(var_225_8) / 18)) > 0 and var_225_6 < var_225_10 then
					arg_222_1.talkMaxDuration = var_225_10

					if var_225_10 + var_225_5 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_10 + var_225_5
					end
				end

				arg_222_1.text_.text = var_225_8
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261054", "story_v_out_417261.awb") ~= 0 then
					local var_225_11 = manager.audio:GetVoiceLength("story_v_out_417261", "417261054", "story_v_out_417261.awb") / 1000

					if var_225_11 + var_225_5 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_11 + var_225_5
					end

					if var_225_7.prefab_name ~= "" and arg_222_1.actors_[var_225_7.prefab_name] ~= nil then
						local var_225_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_7.prefab_name].transform, "story_v_out_417261", "417261054", "story_v_out_417261.awb")

						arg_222_1:RecordAudio("417261054", var_225_12)
						arg_222_1:RecordAudio("417261054", var_225_12)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_417261", "417261054", "story_v_out_417261.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_417261", "417261054", "story_v_out_417261.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_13 = math.max(var_225_6, arg_222_1.talkMaxDuration)

			if var_225_5 <= arg_222_1.time_ and arg_222_1.time_ < var_225_5 + var_225_13 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_5) / var_225_13

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_5 + var_225_13 and arg_222_1.time_ < var_225_5 + var_225_13 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play417261055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 417261055
		arg_226_1.duration_ = 2.67

		local var_226_0 = {
			zh = 2.666,
			ja = 2
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play417261056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(arg_226_1.actors_["10014"]) and arg_226_1.var_.actorSpriteComps10014 == nil then
				arg_226_1.var_.actorSpriteComps10014 = arg_226_1.actors_["10014"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_229_0 = 0.2

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 and not isNil(arg_226_1.actors_["10014"]) then
				if arg_226_1.var_.actorSpriteComps10014 then
					for iter_229_0, iter_229_1 in pairs(arg_226_1.var_.actorSpriteComps10014:ToTable()) do
						if iter_229_1 then
							if arg_226_1.isInRecall_ then
								iter_229_1.color = Color.New(Mathf.Lerp(iter_229_1.color.r, arg_226_1.hightColor1.r, (arg_226_1.time_ - 0) / var_229_0), Mathf.Lerp(iter_229_1.color.g, arg_226_1.hightColor1.g, (arg_226_1.time_ - 0) / var_229_0), (Mathf.Lerp(iter_229_1.color.b, arg_226_1.hightColor1.b, (arg_226_1.time_ - 0) / var_229_0)))
							else
								local var_229_1 = Mathf.Lerp(iter_229_1.color.r, 1, (arg_226_1.time_ - 0) / var_229_0)

								iter_229_1.color = Color.New(var_229_1, var_229_1, var_229_1)
							end
						end
					end
				end
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 and not isNil(arg_226_1.actors_["10014"]) and arg_226_1.var_.actorSpriteComps10014 then
				for iter_229_2, iter_229_3 in pairs(arg_226_1.var_.actorSpriteComps10014:ToTable()) do
					if iter_229_3 then
						iter_229_3.color = arg_226_1.isInRecall_ and (arg_226_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_226_1.var_.actorSpriteComps10014 = nil
			end

			local var_229_2 = arg_226_1.actors_["10115"]

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(var_229_2) and arg_226_1.var_.actorSpriteComps10115 == nil then
				arg_226_1.var_.actorSpriteComps10115 = var_229_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_229_3 = 0.2

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_3 and not isNil(var_229_2) then
				if arg_226_1.var_.actorSpriteComps10115 then
					for iter_229_4, iter_229_5 in pairs(arg_226_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_229_5 then
							if arg_226_1.isInRecall_ then
								iter_229_5.color = Color.New(Mathf.Lerp(iter_229_5.color.r, arg_226_1.hightColor2.r, (arg_226_1.time_ - 0) / var_229_3), Mathf.Lerp(iter_229_5.color.g, arg_226_1.hightColor2.g, (arg_226_1.time_ - 0) / var_229_3), (Mathf.Lerp(iter_229_5.color.b, arg_226_1.hightColor2.b, (arg_226_1.time_ - 0) / var_229_3)))
							else
								local var_229_4 = Mathf.Lerp(iter_229_5.color.r, 0.5, (arg_226_1.time_ - 0) / var_229_3)

								iter_229_5.color = Color.New(var_229_4, var_229_4, var_229_4)
							end
						end
					end
				end
			end

			if arg_226_1.time_ >= 0 + var_229_3 and arg_226_1.time_ < 0 + var_229_3 + arg_229_0 and not isNil(var_229_2) and arg_226_1.var_.actorSpriteComps10115 then
				for iter_229_6, iter_229_7 in pairs(arg_226_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_229_7 then
						iter_229_7.color = arg_226_1.isInRecall_ and (arg_226_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_226_1.var_.actorSpriteComps10115 = nil
			end

			local var_229_5 = 0
			local var_229_6 = 0.225

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_5 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_7 = arg_226_1:GetWordFromCfg(417261055)
				local var_229_8 = arg_226_1:FormatText(var_229_7.content)

				arg_226_1.text_.text = var_229_8

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_10 = 9 <= 0 and var_229_6 or var_229_6 * (utf8.len(var_229_8) / 9)

				if (9 <= 0 and var_229_6 or var_229_6 * (utf8.len(var_229_8) / 9)) > 0 and var_229_6 < var_229_10 then
					arg_226_1.talkMaxDuration = var_229_10

					if var_229_10 + var_229_5 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_10 + var_229_5
					end
				end

				arg_226_1.text_.text = var_229_8
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261055", "story_v_out_417261.awb") ~= 0 then
					local var_229_11 = manager.audio:GetVoiceLength("story_v_out_417261", "417261055", "story_v_out_417261.awb") / 1000

					if var_229_11 + var_229_5 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_11 + var_229_5
					end

					if var_229_7.prefab_name ~= "" and arg_226_1.actors_[var_229_7.prefab_name] ~= nil then
						local var_229_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_7.prefab_name].transform, "story_v_out_417261", "417261055", "story_v_out_417261.awb")

						arg_226_1:RecordAudio("417261055", var_229_12)
						arg_226_1:RecordAudio("417261055", var_229_12)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_417261", "417261055", "story_v_out_417261.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_417261", "417261055", "story_v_out_417261.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_13 = math.max(var_229_6, arg_226_1.talkMaxDuration)

			if var_229_5 <= arg_226_1.time_ and arg_226_1.time_ < var_229_5 + var_229_13 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_5) / var_229_13

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_5 + var_229_13 and arg_226_1.time_ < var_229_5 + var_229_13 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play417261056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 417261056
		arg_230_1.duration_ = 12.4

		local var_230_0 = {
			zh = 10,
			ja = 12.4
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play417261057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(arg_230_1.actors_["10014"]) and arg_230_1.var_.actorSpriteComps10014 == nil then
				arg_230_1.var_.actorSpriteComps10014 = arg_230_1.actors_["10014"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_233_0 = 0.2

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 and not isNil(arg_230_1.actors_["10014"]) then
				if arg_230_1.var_.actorSpriteComps10014 then
					for iter_233_0, iter_233_1 in pairs(arg_230_1.var_.actorSpriteComps10014:ToTable()) do
						if iter_233_1 then
							if arg_230_1.isInRecall_ then
								iter_233_1.color = Color.New(Mathf.Lerp(iter_233_1.color.r, arg_230_1.hightColor1.r, (arg_230_1.time_ - 0) / var_233_0), Mathf.Lerp(iter_233_1.color.g, arg_230_1.hightColor1.g, (arg_230_1.time_ - 0) / var_233_0), (Mathf.Lerp(iter_233_1.color.b, arg_230_1.hightColor1.b, (arg_230_1.time_ - 0) / var_233_0)))
							else
								local var_233_1 = Mathf.Lerp(iter_233_1.color.r, 1, (arg_230_1.time_ - 0) / var_233_0)

								iter_233_1.color = Color.New(var_233_1, var_233_1, var_233_1)
							end
						end
					end
				end
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 and not isNil(arg_230_1.actors_["10014"]) and arg_230_1.var_.actorSpriteComps10014 then
				for iter_233_2, iter_233_3 in pairs(arg_230_1.var_.actorSpriteComps10014:ToTable()) do
					if iter_233_3 then
						iter_233_3.color = arg_230_1.isInRecall_ and (arg_230_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_230_1.var_.actorSpriteComps10014 = nil
			end

			local var_233_2 = arg_230_1.actors_["10115"]

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(var_233_2) and arg_230_1.var_.actorSpriteComps10115 == nil then
				arg_230_1.var_.actorSpriteComps10115 = var_233_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_233_3 = 0.2

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_3 and not isNil(var_233_2) then
				if arg_230_1.var_.actorSpriteComps10115 then
					for iter_233_4, iter_233_5 in pairs(arg_230_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_233_5 then
							if arg_230_1.isInRecall_ then
								iter_233_5.color = Color.New(Mathf.Lerp(iter_233_5.color.r, arg_230_1.hightColor2.r, (arg_230_1.time_ - 0) / var_233_3), Mathf.Lerp(iter_233_5.color.g, arg_230_1.hightColor2.g, (arg_230_1.time_ - 0) / var_233_3), (Mathf.Lerp(iter_233_5.color.b, arg_230_1.hightColor2.b, (arg_230_1.time_ - 0) / var_233_3)))
							else
								local var_233_4 = Mathf.Lerp(iter_233_5.color.r, 0.5, (arg_230_1.time_ - 0) / var_233_3)

								iter_233_5.color = Color.New(var_233_4, var_233_4, var_233_4)
							end
						end
					end
				end
			end

			if arg_230_1.time_ >= 0 + var_233_3 and arg_230_1.time_ < 0 + var_233_3 + arg_233_0 and not isNil(var_233_2) and arg_230_1.var_.actorSpriteComps10115 then
				for iter_233_6, iter_233_7 in pairs(arg_230_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_233_7 then
						iter_233_7.color = arg_230_1.isInRecall_ and (arg_230_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_230_1.var_.actorSpriteComps10115 = nil
			end

			local var_233_5 = 0
			local var_233_6 = 1.225

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_5 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_7 = arg_230_1:GetWordFromCfg(417261056)
				local var_233_8 = arg_230_1:FormatText(var_233_7.content)

				arg_230_1.text_.text = var_233_8

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_10 = 49 <= 0 and var_233_6 or var_233_6 * (utf8.len(var_233_8) / 49)

				if (49 <= 0 and var_233_6 or var_233_6 * (utf8.len(var_233_8) / 49)) > 0 and var_233_6 < var_233_10 then
					arg_230_1.talkMaxDuration = var_233_10

					if var_233_10 + var_233_5 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_10 + var_233_5
					end
				end

				arg_230_1.text_.text = var_233_8
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261056", "story_v_out_417261.awb") ~= 0 then
					local var_233_11 = manager.audio:GetVoiceLength("story_v_out_417261", "417261056", "story_v_out_417261.awb") / 1000

					if var_233_11 + var_233_5 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_11 + var_233_5
					end

					if var_233_7.prefab_name ~= "" and arg_230_1.actors_[var_233_7.prefab_name] ~= nil then
						local var_233_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_7.prefab_name].transform, "story_v_out_417261", "417261056", "story_v_out_417261.awb")

						arg_230_1:RecordAudio("417261056", var_233_12)
						arg_230_1:RecordAudio("417261056", var_233_12)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_417261", "417261056", "story_v_out_417261.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_417261", "417261056", "story_v_out_417261.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_13 = math.max(var_233_6, arg_230_1.talkMaxDuration)

			if var_233_5 <= arg_230_1.time_ and arg_230_1.time_ < var_233_5 + var_233_13 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_5) / var_233_13

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_5 + var_233_13 and arg_230_1.time_ < var_233_5 + var_233_13 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play417261057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 417261057
		arg_234_1.duration_ = 7

		local var_234_0 = {
			zh = 4.733,
			ja = 7
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play417261058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(arg_234_1.actors_["10014"]) and arg_234_1.var_.actorSpriteComps10014 == nil then
				arg_234_1.var_.actorSpriteComps10014 = arg_234_1.actors_["10014"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_237_0 = 0.2

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 and not isNil(arg_234_1.actors_["10014"]) then
				if arg_234_1.var_.actorSpriteComps10014 then
					for iter_237_0, iter_237_1 in pairs(arg_234_1.var_.actorSpriteComps10014:ToTable()) do
						if iter_237_1 then
							if arg_234_1.isInRecall_ then
								iter_237_1.color = Color.New(Mathf.Lerp(iter_237_1.color.r, arg_234_1.hightColor2.r, (arg_234_1.time_ - 0) / var_237_0), Mathf.Lerp(iter_237_1.color.g, arg_234_1.hightColor2.g, (arg_234_1.time_ - 0) / var_237_0), (Mathf.Lerp(iter_237_1.color.b, arg_234_1.hightColor2.b, (arg_234_1.time_ - 0) / var_237_0)))
							else
								local var_237_1 = Mathf.Lerp(iter_237_1.color.r, 0.5, (arg_234_1.time_ - 0) / var_237_0)

								iter_237_1.color = Color.New(var_237_1, var_237_1, var_237_1)
							end
						end
					end
				end
			end

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 and not isNil(arg_234_1.actors_["10014"]) and arg_234_1.var_.actorSpriteComps10014 then
				for iter_237_2, iter_237_3 in pairs(arg_234_1.var_.actorSpriteComps10014:ToTable()) do
					if iter_237_3 then
						iter_237_3.color = arg_234_1.isInRecall_ and (arg_234_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_234_1.var_.actorSpriteComps10014 = nil
			end

			local var_237_2 = arg_234_1.actors_["10115"]

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(var_237_2) and arg_234_1.var_.actorSpriteComps10115 == nil then
				arg_234_1.var_.actorSpriteComps10115 = var_237_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_237_3 = 0.2

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_3 and not isNil(var_237_2) then
				if arg_234_1.var_.actorSpriteComps10115 then
					for iter_237_4, iter_237_5 in pairs(arg_234_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_237_5 then
							if arg_234_1.isInRecall_ then
								iter_237_5.color = Color.New(Mathf.Lerp(iter_237_5.color.r, arg_234_1.hightColor1.r, (arg_234_1.time_ - 0) / var_237_3), Mathf.Lerp(iter_237_5.color.g, arg_234_1.hightColor1.g, (arg_234_1.time_ - 0) / var_237_3), (Mathf.Lerp(iter_237_5.color.b, arg_234_1.hightColor1.b, (arg_234_1.time_ - 0) / var_237_3)))
							else
								local var_237_4 = Mathf.Lerp(iter_237_5.color.r, 1, (arg_234_1.time_ - 0) / var_237_3)

								iter_237_5.color = Color.New(var_237_4, var_237_4, var_237_4)
							end
						end
					end
				end
			end

			if arg_234_1.time_ >= 0 + var_237_3 and arg_234_1.time_ < 0 + var_237_3 + arg_237_0 and not isNil(var_237_2) and arg_234_1.var_.actorSpriteComps10115 then
				for iter_237_6, iter_237_7 in pairs(arg_234_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_237_7 then
						iter_237_7.color = arg_234_1.isInRecall_ and (arg_234_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_234_1.var_.actorSpriteComps10115 = nil
			end

			local var_237_5 = 0
			local var_237_6 = 0.45

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_5 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_7 = arg_234_1:GetWordFromCfg(417261057)
				local var_237_8 = arg_234_1:FormatText(var_237_7.content)

				arg_234_1.text_.text = var_237_8

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_10 = 18 <= 0 and var_237_6 or var_237_6 * (utf8.len(var_237_8) / 18)

				if (18 <= 0 and var_237_6 or var_237_6 * (utf8.len(var_237_8) / 18)) > 0 and var_237_6 < var_237_10 then
					arg_234_1.talkMaxDuration = var_237_10

					if var_237_10 + var_237_5 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_10 + var_237_5
					end
				end

				arg_234_1.text_.text = var_237_8
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261057", "story_v_out_417261.awb") ~= 0 then
					local var_237_11 = manager.audio:GetVoiceLength("story_v_out_417261", "417261057", "story_v_out_417261.awb") / 1000

					if var_237_11 + var_237_5 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_11 + var_237_5
					end

					if var_237_7.prefab_name ~= "" and arg_234_1.actors_[var_237_7.prefab_name] ~= nil then
						local var_237_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_7.prefab_name].transform, "story_v_out_417261", "417261057", "story_v_out_417261.awb")

						arg_234_1:RecordAudio("417261057", var_237_12)
						arg_234_1:RecordAudio("417261057", var_237_12)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_417261", "417261057", "story_v_out_417261.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_417261", "417261057", "story_v_out_417261.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_13 = math.max(var_237_6, arg_234_1.talkMaxDuration)

			if var_237_5 <= arg_234_1.time_ and arg_234_1.time_ < var_237_5 + var_237_13 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_5) / var_237_13

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_5 + var_237_13 and arg_234_1.time_ < var_237_5 + var_237_13 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play417261058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 417261058
		arg_238_1.duration_ = 8.8

		local var_238_0 = {
			zh = 5.066,
			ja = 8.8
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play417261059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 0.65

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_1 = arg_238_1:GetWordFromCfg(417261058)
				local var_241_2 = arg_238_1:FormatText(var_241_1.content)

				arg_238_1.text_.text = var_241_2

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_4 = 26 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_2) / 26)

				if (26 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_2) / 26)) > 0 and var_241_0 < var_241_4 then
					arg_238_1.talkMaxDuration = var_241_4

					if var_241_4 + 0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_4 + 0
					end
				end

				arg_238_1.text_.text = var_241_2
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261058", "story_v_out_417261.awb") ~= 0 then
					local var_241_5 = manager.audio:GetVoiceLength("story_v_out_417261", "417261058", "story_v_out_417261.awb") / 1000

					if var_241_5 + 0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_5 + 0
					end

					if var_241_1.prefab_name ~= "" and arg_238_1.actors_[var_241_1.prefab_name] ~= nil then
						local var_241_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_1.prefab_name].transform, "story_v_out_417261", "417261058", "story_v_out_417261.awb")

						arg_238_1:RecordAudio("417261058", var_241_6)
						arg_238_1:RecordAudio("417261058", var_241_6)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_417261", "417261058", "story_v_out_417261.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_417261", "417261058", "story_v_out_417261.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_7 = math.max(var_241_0, arg_238_1.talkMaxDuration)

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_7 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - 0) / var_241_7

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= 0 + var_241_7 and arg_238_1.time_ < 0 + var_241_7 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play417261059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 417261059
		arg_242_1.duration_ = 3.83

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play417261060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0.966 < arg_242_1.time_ and arg_242_1.time_ <= 0.966 + arg_245_0 then
				arg_242_1.var_.moveOldPos10014 = arg_242_1.actors_["10014"].transform.localPosition
				arg_242_1.actors_["10014"].transform.localScale = Vector3.New(1, 1, 1)

				arg_242_1:CheckSpriteTmpPos("10014", 7)

				for iter_245_0 = 0, arg_242_1.actors_["10014"].transform.childCount - 1 do
					local var_245_0 = arg_242_1.actors_["10014"].transform:GetChild(iter_245_0)

					if var_245_0.name == "" or not string.find(var_245_0.name, "split") then
						var_245_0.gameObject:SetActive(true)
					else
						var_245_0.gameObject:SetActive(false)
					end
				end
			end

			local var_245_1 = 0.001

			if 0.966 <= arg_242_1.time_ and arg_242_1.time_ < 0.966 + var_245_1 then
				arg_242_1.actors_["10014"].transform.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos10014, Vector3.New(0, -2000, -40), (arg_242_1.time_ - 0.966) / var_245_1)
			end

			if arg_242_1.time_ >= 0.966 + var_245_1 and arg_242_1.time_ < 0.966 + var_245_1 + arg_245_0 then
				arg_242_1.actors_["10014"].transform.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_245_2 = arg_242_1.actors_["10115"].transform

			if 0.966 < arg_242_1.time_ and arg_242_1.time_ <= 0.966 + arg_245_0 then
				arg_242_1.var_.moveOldPos10115 = var_245_2.localPosition
				var_245_2.localScale = Vector3.New(1, 1, 1)

				arg_242_1:CheckSpriteTmpPos("10115", 7)

				for iter_245_1 = 0, var_245_2.childCount - 1 do
					local var_245_3 = var_245_2:GetChild(iter_245_1)

					if var_245_3.name == "" or not string.find(var_245_3.name, "split") then
						var_245_3.gameObject:SetActive(true)
					else
						var_245_3.gameObject:SetActive(false)
					end
				end
			end

			local var_245_4 = 0.001

			if 0.966 <= arg_242_1.time_ and arg_242_1.time_ < 0.966 + var_245_4 then
				var_245_2.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos10115, Vector3.New(0, -2000, 0), (arg_242_1.time_ - 0.966) / var_245_4)
			end

			if arg_242_1.time_ >= 0.966 + var_245_4 and arg_242_1.time_ < 0.966 + var_245_4 + arg_245_0 then
				var_245_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_245_5 = 0

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_5 + arg_245_0 then
				arg_242_1.mask_.enabled = true
				arg_242_1.mask_.raycastTarget = true

				arg_242_1:SetGaussion(false)
			end

			local var_245_6 = 1

			if var_245_5 <= arg_242_1.time_ and arg_242_1.time_ < var_245_5 + var_245_6 then
				local var_245_7 = Color.New(0, 0, 0)

				var_245_7.a = Mathf.Lerp(0, 1, (arg_242_1.time_ - var_245_5) / var_245_6)
				arg_242_1.mask_.color = var_245_7
			end

			if arg_242_1.time_ >= var_245_5 + var_245_6 and arg_242_1.time_ < var_245_5 + var_245_6 + arg_245_0 then
				local var_245_8 = Color.New(0, 0, 0)

				var_245_8.a = 1
				arg_242_1.mask_.color = var_245_8
			end

			local var_245_9 = 1

			if 1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_9 + arg_245_0 then
				arg_242_1.mask_.enabled = true
				arg_242_1.mask_.raycastTarget = true

				arg_242_1:SetGaussion(false)
			end

			local var_245_10 = 1

			if var_245_9 <= arg_242_1.time_ and arg_242_1.time_ < var_245_9 + var_245_10 then
				local var_245_11 = Color.New(0, 0, 0)

				var_245_11.a = Mathf.Lerp(1, 0, (arg_242_1.time_ - var_245_9) / var_245_10)
				arg_242_1.mask_.color = var_245_11
			end

			if arg_242_1.time_ >= var_245_9 + var_245_10 and arg_242_1.time_ < var_245_9 + var_245_10 + arg_245_0 then
				local var_245_12 = Color.New(0, 0, 0)

				arg_242_1.mask_.enabled = false
				var_245_12.a = 0
				arg_242_1.mask_.color = var_245_12
			end

			if 1 < arg_242_1.time_ and arg_242_1.time_ <= 1 + arg_245_0 then
				local var_245_13 = arg_242_1.bgs_.STblack

				arg_242_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_245_13.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_245_14 = var_245_13:GetComponent("SpriteRenderer")

				if var_245_14 and var_245_14.sprite then
					local var_245_15 = 2 * (var_245_13.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_245_13.transform.localScale = Vector3.New(var_245_15 / var_245_14.sprite.bounds.size.y < var_245_15 * manager.ui.mainCameraCom_.aspect / var_245_14.sprite.bounds.size.x and var_245_15 * manager.ui.mainCameraCom_.aspect / var_245_14.sprite.bounds.size.x or var_245_15 / var_245_14.sprite.bounds.size.y, var_245_15 / var_245_14.sprite.bounds.size.y < var_245_15 * manager.ui.mainCameraCom_.aspect / var_245_14.sprite.bounds.size.x and var_245_15 * manager.ui.mainCameraCom_.aspect / var_245_14.sprite.bounds.size.x or var_245_15 / var_245_14.sprite.bounds.size.y, 0)
				end

				for iter_245_2, iter_245_3 in pairs(arg_242_1.bgs_) do
					if iter_245_2 ~= "STblack" then
						iter_245_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 1 < arg_242_1.time_ and arg_242_1.time_ <= 1 + arg_245_0 then
				arg_242_1.cswbg_:SetActive(true)

				local var_245_16 = arg_242_1.cswt_:GetComponent("RectTransform")

				arg_242_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_245_16.offsetMin = Vector2.New(0, 0)
				var_245_16.offsetMax = Vector2.New(0, 0)
				arg_242_1.cswt_.text = arg_242_1:FormatText(arg_242_1:GetWordFromCfg(419124).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.cswt_)

				arg_242_1.cswt_.fontSize = 120
				arg_242_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_242_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_242_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 1 < arg_242_1.time_ and arg_242_1.time_ <= 1 + arg_245_0 then
				local var_245_17 = arg_242_1.fswbg_.transform:Find("textbox/adapt/content") or arg_242_1.fswbg_.transform:Find("textbox/content")
				local var_245_18 = arg_242_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_245_19 = var_245_17:GetComponent("RectTransform")

				var_245_17:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_245_19.offsetMin = Vector2.New(0, 0)
				var_245_19.offsetMax = Vector2.New(0, 0)
			end

			if 1 < arg_242_1.time_ and arg_242_1.time_ <= 1 + arg_245_0 then
				arg_242_1.fswbg_:SetActive(true)
				arg_242_1.dialog_:SetActive(false)

				arg_242_1.fswtw_.percent = 0
				arg_242_1.fswt_.text = arg_242_1:FormatText(arg_242_1:GetWordFromCfg(417261059).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.fswt_)

				arg_242_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_242_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_242_1.fswtw_:SetDirty()

				arg_242_1.typewritterCharCountI18N = 0

				SetActive(arg_242_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_242_1:ShowNextGo(false)
			end

			local var_245_20 = 1.66666666666667

			if 1.66666666666667 < arg_242_1.time_ and arg_242_1.time_ <= var_245_20 + arg_245_0 then
				arg_242_1.var_.oldValueTypewriter = arg_242_1.fswtw_.percent

				SetActive(arg_242_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_242_1:ShowNextGo(false)
			end

			local var_245_21 = 7
			local var_245_22 = 0.466666666666667
			local var_245_23, var_245_24 = arg_242_1:GetPercentByPara(arg_242_1:FormatText(arg_242_1:GetWordFromCfg(417261059).content), 1)

			if var_245_20 < arg_242_1.time_ and arg_242_1.time_ <= var_245_20 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0

				local var_245_25 = var_245_21 <= 0 and var_245_22 or var_245_22 * ((var_245_24 - arg_242_1.typewritterCharCountI18N) / var_245_21)

				if (var_245_21 <= 0 and var_245_22 or var_245_22 * ((var_245_24 - arg_242_1.typewritterCharCountI18N) / var_245_21)) > 0 and var_245_22 < var_245_25 then
					arg_242_1.talkMaxDuration = var_245_25

					if var_245_25 + var_245_20 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_25 + var_245_20
					end
				end
			end

			local var_245_26 = math.max(0.466666666666667, arg_242_1.talkMaxDuration)

			if var_245_20 <= arg_242_1.time_ and arg_242_1.time_ < var_245_20 + var_245_26 then
				arg_242_1.fswtw_.percent = Mathf.Lerp(arg_242_1.var_.oldValueTypewriter, var_245_23, (arg_242_1.time_ - var_245_20) / var_245_26)
				arg_242_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_242_1.fswtw_:SetDirty()
			end

			if arg_242_1.time_ >= var_245_20 + var_245_26 and arg_242_1.time_ < var_245_20 + var_245_26 + arg_245_0 then
				arg_242_1.fswtw_.percent = var_245_23

				arg_242_1.fswtw_:SetDirty()
				arg_242_1:ShowNextGo(true)

				arg_242_1.typewritterCharCountI18N = var_245_24
			end

			if 1 < arg_242_1.time_ and arg_242_1.time_ <= 1 + arg_245_0 then
				arg_242_1:AudioAction("play", "music", "story_v_out_417261", "417261059", "story_v_out_417261.awb")

				local var_245_29 = manager.audio:GetAudioName("story_v_out_417261", "417261059")

				if "" ~= "" then
					if arg_242_1.bgmTxt_.text ~= var_245_29 and arg_242_1.bgmTxt_.text ~= "" then
						if arg_242_1.bgmTxt2_.text ~= "" then
							arg_242_1.bgmTxt_.text = arg_242_1.bgmTxt2_.text
						end

						arg_242_1.bgmTxt2_.text = var_245_29

						arg_242_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_242_1.bgmTxt_.text = var_245_29
						arg_242_1.bgmTxt2_.text = var_245_29
					end

					if arg_242_1.bgmTimer then
						arg_242_1.bgmTimer:Stop()

						arg_242_1.bgmTimer = nil
					end

					if arg_242_1.settingData.show_music_name == 1 then
						arg_242_1.musicController:SetSelectedState("show")
						arg_242_1.musicAnimator_:Play("open", 0, 0)

						if arg_242_1.settingData.music_time ~= 0 then
							arg_242_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_242_1.settingData.music_time), function()
								if arg_242_1 == nil or isNil(arg_242_1.bgmTxt_) then
									return
								end

								arg_242_1.musicController:SetSelectedState("hide")
								arg_242_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.566666666666667 < arg_242_1.time_ and arg_242_1.time_ <= 0.566666666666667 + arg_245_0 then
				arg_242_1:AudioAction("stop", "effect", "se_story_side_1068", "se_story_1068_restaurant", "")
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play417261060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 417261060
		arg_247_1.duration_ = 4.57

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play417261061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.fswbg_:SetActive(true)
				arg_247_1.dialog_:SetActive(false)

				arg_247_1.fswtw_.percent = 0
				arg_247_1.fswt_.text = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(417261060).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.fswt_)

				arg_247_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_247_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_247_1.fswtw_:SetDirty()

				arg_247_1.typewritterCharCountI18N = 0

				SetActive(arg_247_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_247_1:ShowNextGo(false)
			end

			local var_250_0 = 0.1

			if 0.1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				arg_247_1.var_.oldValueTypewriter = arg_247_1.fswtw_.percent

				SetActive(arg_247_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_247_1:ShowNextGo(false)
			end

			local var_250_1 = 44
			local var_250_2 = 2.93333333333333
			local var_250_3, var_250_4 = arg_247_1:GetPercentByPara(arg_247_1:FormatText(arg_247_1:GetWordFromCfg(417261060).content), 1)

			if var_250_0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0

				local var_250_5 = var_250_1 <= 0 and var_250_2 or var_250_2 * ((var_250_4 - arg_247_1.typewritterCharCountI18N) / var_250_1)

				if (var_250_1 <= 0 and var_250_2 or var_250_2 * ((var_250_4 - arg_247_1.typewritterCharCountI18N) / var_250_1)) > 0 and var_250_2 < var_250_5 then
					arg_247_1.talkMaxDuration = var_250_5

					if var_250_5 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_5 + var_250_0
					end
				end
			end

			local var_250_6 = math.max(2.93333333333333, arg_247_1.talkMaxDuration)

			if var_250_0 <= arg_247_1.time_ and arg_247_1.time_ < var_250_0 + var_250_6 then
				arg_247_1.fswtw_.percent = Mathf.Lerp(arg_247_1.var_.oldValueTypewriter, var_250_3, (arg_247_1.time_ - var_250_0) / var_250_6)
				arg_247_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_247_1.fswtw_:SetDirty()
			end

			if arg_247_1.time_ >= var_250_0 + var_250_6 and arg_247_1.time_ < var_250_0 + var_250_6 + arg_250_0 then
				arg_247_1.fswtw_.percent = var_250_3

				arg_247_1.fswtw_:SetDirty()
				arg_247_1:ShowNextGo(true)

				arg_247_1.typewritterCharCountI18N = var_250_4
			end

			if 0.1 < arg_247_1.time_ and arg_247_1.time_ <= 0.1 + arg_250_0 then
				arg_247_1:AudioAction("play", "music", "story_v_out_417261", "417261060", "story_v_out_417261.awb")

				local var_250_9 = manager.audio:GetAudioName("story_v_out_417261", "417261060")

				if "" ~= "" then
					if arg_247_1.bgmTxt_.text ~= var_250_9 and arg_247_1.bgmTxt_.text ~= "" then
						if arg_247_1.bgmTxt2_.text ~= "" then
							arg_247_1.bgmTxt_.text = arg_247_1.bgmTxt2_.text
						end

						arg_247_1.bgmTxt2_.text = var_250_9

						arg_247_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_247_1.bgmTxt_.text = var_250_9
						arg_247_1.bgmTxt2_.text = var_250_9
					end

					if arg_247_1.bgmTimer then
						arg_247_1.bgmTimer:Stop()

						arg_247_1.bgmTimer = nil
					end

					if arg_247_1.settingData.show_music_name == 1 then
						arg_247_1.musicController:SetSelectedState("show")
						arg_247_1.musicAnimator_:Play("open", 0, 0)

						if arg_247_1.settingData.music_time ~= 0 then
							arg_247_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_247_1.settingData.music_time), function()
								if arg_247_1 == nil or isNil(arg_247_1.bgmTxt_) then
									return
								end

								arg_247_1.musicController:SetSelectedState("hide")
								arg_247_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play417261061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 417261061
		arg_252_1.duration_ = 1

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play417261062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.fswbg_:SetActive(true)
				arg_252_1.dialog_:SetActive(false)

				arg_252_1.fswtw_.percent = 0
				arg_252_1.fswt_.text = arg_252_1:FormatText(arg_252_1:GetWordFromCfg(417261061).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.fswt_)

				arg_252_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_252_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_252_1.fswtw_:SetDirty()

				arg_252_1.typewritterCharCountI18N = 0

				SetActive(arg_252_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_252_1:ShowNextGo(false)
			end

			local var_255_0 = 0.0999999999999999

			if 0.0999999999999999 < arg_252_1.time_ and arg_252_1.time_ <= var_255_0 + arg_255_0 then
				arg_252_1.var_.oldValueTypewriter = arg_252_1.fswtw_.percent

				SetActive(arg_252_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_252_1:ShowNextGo(false)
			end

			local var_255_1 = 7
			local var_255_2 = 0.466666666666667
			local var_255_3, var_255_4 = arg_252_1:GetPercentByPara(arg_252_1:FormatText(arg_252_1:GetWordFromCfg(417261061).content), 1)

			if var_255_0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_0 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0

				local var_255_5 = var_255_1 <= 0 and var_255_2 or var_255_2 * ((var_255_4 - arg_252_1.typewritterCharCountI18N) / var_255_1)

				if (var_255_1 <= 0 and var_255_2 or var_255_2 * ((var_255_4 - arg_252_1.typewritterCharCountI18N) / var_255_1)) > 0 and var_255_2 < var_255_5 then
					arg_252_1.talkMaxDuration = var_255_5

					if var_255_5 + var_255_0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_5 + var_255_0
					end
				end
			end

			local var_255_6 = math.max(0.466666666666667, arg_252_1.talkMaxDuration)

			if var_255_0 <= arg_252_1.time_ and arg_252_1.time_ < var_255_0 + var_255_6 then
				arg_252_1.fswtw_.percent = Mathf.Lerp(arg_252_1.var_.oldValueTypewriter, var_255_3, (arg_252_1.time_ - var_255_0) / var_255_6)
				arg_252_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_252_1.fswtw_:SetDirty()
			end

			if arg_252_1.time_ >= var_255_0 + var_255_6 and arg_252_1.time_ < var_255_0 + var_255_6 + arg_255_0 then
				arg_252_1.fswtw_.percent = var_255_3

				arg_252_1.fswtw_:SetDirty()
				arg_252_1:ShowNextGo(true)

				arg_252_1.typewritterCharCountI18N = var_255_4
			end

			local var_255_7 = 0
			local var_255_8 = manager.audio:GetVoiceLength("story_v_out_417261", "417261061", "story_v_out_417261.awb") / 1000

			if var_255_8 > 0 and 1 < var_255_8 and var_255_8 + var_255_7 > arg_252_1.duration_ then
				arg_252_1.duration_ = var_255_8 + var_255_7
			end

			if var_255_7 < arg_252_1.time_ and arg_252_1.time_ <= var_255_7 + arg_255_0 then
				arg_252_1:AudioAction("play", "voice", "story_v_out_417261", "417261061", "story_v_out_417261.awb")
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play417261062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 417261062
		arg_256_1.duration_ = 1.77

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play417261063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.fswbg_:SetActive(true)
				arg_256_1.dialog_:SetActive(false)

				arg_256_1.fswtw_.percent = 0
				arg_256_1.fswt_.text = arg_256_1:FormatText(arg_256_1:GetWordFromCfg(417261062).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.fswt_)

				arg_256_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_256_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_256_1.fswtw_:SetDirty()

				arg_256_1.typewritterCharCountI18N = 0

				SetActive(arg_256_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_256_1:ShowNextGo(false)
			end

			local var_259_0 = 0.0999999999999999

			if 0.0999999999999999 < arg_256_1.time_ and arg_256_1.time_ <= var_259_0 + arg_259_0 then
				arg_256_1.var_.oldValueTypewriter = arg_256_1.fswtw_.percent

				SetActive(arg_256_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_256_1:ShowNextGo(false)
			end

			local var_259_1 = 25
			local var_259_2 = 1.66666666666667
			local var_259_3, var_259_4 = arg_256_1:GetPercentByPara(arg_256_1:FormatText(arg_256_1:GetWordFromCfg(417261062).content), 1)

			if var_259_0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_0 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0

				local var_259_5 = var_259_1 <= 0 and var_259_2 or var_259_2 * ((var_259_4 - arg_256_1.typewritterCharCountI18N) / var_259_1)

				if (var_259_1 <= 0 and var_259_2 or var_259_2 * ((var_259_4 - arg_256_1.typewritterCharCountI18N) / var_259_1)) > 0 and var_259_2 < var_259_5 then
					arg_256_1.talkMaxDuration = var_259_5

					if var_259_5 + var_259_0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_5 + var_259_0
					end
				end
			end

			local var_259_6 = math.max(1.66666666666667, arg_256_1.talkMaxDuration)

			if var_259_0 <= arg_256_1.time_ and arg_256_1.time_ < var_259_0 + var_259_6 then
				arg_256_1.fswtw_.percent = Mathf.Lerp(arg_256_1.var_.oldValueTypewriter, var_259_3, (arg_256_1.time_ - var_259_0) / var_259_6)
				arg_256_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_256_1.fswtw_:SetDirty()
			end

			if arg_256_1.time_ >= var_259_0 + var_259_6 and arg_256_1.time_ < var_259_0 + var_259_6 + arg_259_0 then
				arg_256_1.fswtw_.percent = var_259_3

				arg_256_1.fswtw_:SetDirty()
				arg_256_1:ShowNextGo(true)

				arg_256_1.typewritterCharCountI18N = var_259_4
			end

			local var_259_7 = 0
			local var_259_8 = manager.audio:GetVoiceLength("story_v_out_417261", "417261062", "story_v_out_417261.awb") / 1000

			if var_259_8 > 0 and 1 < var_259_8 and var_259_8 + var_259_7 > arg_256_1.duration_ then
				arg_256_1.duration_ = var_259_8 + var_259_7
			end

			if var_259_7 < arg_256_1.time_ and arg_256_1.time_ <= var_259_7 + arg_259_0 then
				arg_256_1:AudioAction("play", "voice", "story_v_out_417261", "417261062", "story_v_out_417261.awb")
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play417261063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 417261063
		arg_260_1.duration_ = 1

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play417261064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.fswbg_:SetActive(true)
				arg_260_1.dialog_:SetActive(false)

				arg_260_1.fswtw_.percent = 0
				arg_260_1.fswt_.text = arg_260_1:FormatText(arg_260_1:GetWordFromCfg(417261063).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.fswt_)

				arg_260_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_260_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_260_1.fswtw_:SetDirty()

				arg_260_1.typewritterCharCountI18N = 0

				SetActive(arg_260_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_260_1:ShowNextGo(false)
			end

			local var_263_0 = 0.0999999999999999

			if 0.0999999999999999 < arg_260_1.time_ and arg_260_1.time_ <= var_263_0 + arg_263_0 then
				arg_260_1.var_.oldValueTypewriter = arg_260_1.fswtw_.percent

				SetActive(arg_260_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_260_1:ShowNextGo(false)
			end

			local var_263_1 = 9
			local var_263_2 = 0.6
			local var_263_3, var_263_4 = arg_260_1:GetPercentByPara(arg_260_1:FormatText(arg_260_1:GetWordFromCfg(417261063).content), 1)

			if var_263_0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_0 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0

				local var_263_5 = var_263_1 <= 0 and var_263_2 or var_263_2 * ((var_263_4 - arg_260_1.typewritterCharCountI18N) / var_263_1)

				if (var_263_1 <= 0 and var_263_2 or var_263_2 * ((var_263_4 - arg_260_1.typewritterCharCountI18N) / var_263_1)) > 0 and var_263_2 < var_263_5 then
					arg_260_1.talkMaxDuration = var_263_5

					if var_263_5 + var_263_0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_5 + var_263_0
					end
				end
			end

			local var_263_6 = math.max(0.6, arg_260_1.talkMaxDuration)

			if var_263_0 <= arg_260_1.time_ and arg_260_1.time_ < var_263_0 + var_263_6 then
				arg_260_1.fswtw_.percent = Mathf.Lerp(arg_260_1.var_.oldValueTypewriter, var_263_3, (arg_260_1.time_ - var_263_0) / var_263_6)
				arg_260_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_260_1.fswtw_:SetDirty()
			end

			if arg_260_1.time_ >= var_263_0 + var_263_6 and arg_260_1.time_ < var_263_0 + var_263_6 + arg_263_0 then
				arg_260_1.fswtw_.percent = var_263_3

				arg_260_1.fswtw_:SetDirty()
				arg_260_1:ShowNextGo(true)

				arg_260_1.typewritterCharCountI18N = var_263_4
			end

			local var_263_7 = 0
			local var_263_8 = manager.audio:GetVoiceLength("story_v_out_417261", "417261063", "story_v_out_417261.awb") / 1000

			if var_263_8 > 0 and 1 < var_263_8 and var_263_8 + var_263_7 > arg_260_1.duration_ then
				arg_260_1.duration_ = var_263_8 + var_263_7
			end

			if var_263_7 < arg_260_1.time_ and arg_260_1.time_ <= var_263_7 + arg_263_0 then
				arg_260_1:AudioAction("play", "voice", "story_v_out_417261", "417261063", "story_v_out_417261.awb")
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play417261064 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 417261064
		arg_264_1.duration_ = 10.1

		local var_264_0 = {
			zh = 7.966,
			ja = 10.1
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play417261065(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 1 < arg_264_1.time_ and arg_264_1.time_ <= 1 + arg_267_0 then
				local var_267_0 = arg_264_1.bgs_.I16f

				arg_264_1.bgs_.I16f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_267_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_267_1 = var_267_0:GetComponent("SpriteRenderer")

				if var_267_1 and var_267_1.sprite then
					local var_267_2 = 2 * (var_267_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_267_0.transform.localScale = Vector3.New(var_267_2 / var_267_1.sprite.bounds.size.y < var_267_2 * manager.ui.mainCameraCom_.aspect / var_267_1.sprite.bounds.size.x and var_267_2 * manager.ui.mainCameraCom_.aspect / var_267_1.sprite.bounds.size.x or var_267_2 / var_267_1.sprite.bounds.size.y, var_267_2 / var_267_1.sprite.bounds.size.y < var_267_2 * manager.ui.mainCameraCom_.aspect / var_267_1.sprite.bounds.size.x and var_267_2 * manager.ui.mainCameraCom_.aspect / var_267_1.sprite.bounds.size.x or var_267_2 / var_267_1.sprite.bounds.size.y, 0)
				end

				for iter_267_0, iter_267_1 in pairs(arg_264_1.bgs_) do
					if iter_267_0 ~= "I16f" then
						iter_267_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_267_3 = 3

			if 3 < arg_264_1.time_ and arg_264_1.time_ <= var_267_3 + arg_267_0 then
				arg_264_1.allBtn_.enabled = false
			end

			if arg_264_1.time_ >= var_267_3 + 0.3 and arg_264_1.time_ < var_267_3 + 0.3 + arg_267_0 then
				arg_264_1.allBtn_.enabled = true
			end

			local var_267_4 = 0

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_4 + arg_267_0 then
				arg_264_1.mask_.enabled = true
				arg_264_1.mask_.raycastTarget = true

				arg_264_1:SetGaussion(false)
			end

			local var_267_5 = 1

			if var_267_4 <= arg_264_1.time_ and arg_264_1.time_ < var_267_4 + var_267_5 then
				local var_267_6 = Color.New(0, 0, 0)

				var_267_6.a = Mathf.Lerp(0, 1, (arg_264_1.time_ - var_267_4) / var_267_5)
				arg_264_1.mask_.color = var_267_6
			end

			if arg_264_1.time_ >= var_267_4 + var_267_5 and arg_264_1.time_ < var_267_4 + var_267_5 + arg_267_0 then
				local var_267_7 = Color.New(0, 0, 0)

				var_267_7.a = 1
				arg_264_1.mask_.color = var_267_7
			end

			local var_267_8 = 1

			if 1 < arg_264_1.time_ and arg_264_1.time_ <= var_267_8 + arg_267_0 then
				arg_264_1.mask_.enabled = true
				arg_264_1.mask_.raycastTarget = true

				arg_264_1:SetGaussion(false)
			end

			local var_267_9 = 2

			if var_267_8 <= arg_264_1.time_ and arg_264_1.time_ < var_267_8 + var_267_9 then
				local var_267_10 = Color.New(0, 0, 0)

				var_267_10.a = Mathf.Lerp(1, 0, (arg_264_1.time_ - var_267_8) / var_267_9)
				arg_264_1.mask_.color = var_267_10
			end

			if arg_264_1.time_ >= var_267_8 + var_267_9 and arg_264_1.time_ < var_267_8 + var_267_9 + arg_267_0 then
				local var_267_11 = Color.New(0, 0, 0)

				arg_264_1.mask_.enabled = false
				var_267_11.a = 0
				arg_264_1.mask_.color = var_267_11
			end

			if 0.900666666666667 < arg_264_1.time_ and arg_264_1.time_ <= 0.900666666666667 + arg_267_0 then
				arg_264_1.fswbg_:SetActive(false)
				arg_264_1.dialog_:SetActive(false)
				SetActive(arg_264_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_264_1:ShowNextGo(false)
			end

			if 0.900666666666667 < arg_264_1.time_ and arg_264_1.time_ <= 0.900666666666667 + arg_267_0 then
				arg_264_1.cswbg_:SetActive(false)
			end

			if 2.63333333333333 < arg_264_1.time_ and arg_264_1.time_ <= 2.63333333333333 + arg_267_0 then
				arg_264_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_thunder02", "")
			end

			if 0.466666666666667 < arg_264_1.time_ and arg_264_1.time_ <= 0.466666666666667 + arg_267_0 then
				arg_264_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_wind", "")
			end

			if arg_264_1.frameCnt_ <= 1 then
				arg_264_1.dialog_:SetActive(false)
			end

			local var_267_14 = 3
			local var_267_15 = 0.5

			if 3 < arg_264_1.time_ and arg_264_1.time_ <= var_267_14 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0

				arg_264_1.dialog_:SetActive(true)

				arg_264_1.dialogCg_.alpha = 0

				local var_267_16 = LeanTween.value(arg_264_1.dialog_, 0, 1, 0.3)

				var_267_16:setOnUpdate(LuaHelper.FloatAction(function(arg_268_0)
					arg_264_1.dialogCg_.alpha = arg_268_0
				end))
				var_267_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_264_1.dialog_)
					var_267_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_264_1.duration_ = arg_264_1.duration_ + 0.3

				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[1111].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, true)
				arg_264_1.iconController_:SetSelectedState("hero")

				arg_264_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2069")

				arg_264_1.callingController_:SetSelectedState("normal")

				arg_264_1.keyicon_.color = Color.New(1, 1, 1)
				arg_264_1.icon_.color = Color.New(1, 1, 1)

				local var_267_17 = arg_264_1:GetWordFromCfg(417261064)
				local var_267_18 = arg_264_1:FormatText(var_267_17.content)

				arg_264_1.text_.text = var_267_18

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_20 = 20 <= 0 and var_267_15 or var_267_15 * (utf8.len(var_267_18) / 20)

				if (20 <= 0 and var_267_15 or var_267_15 * (utf8.len(var_267_18) / 20)) > 0 and var_267_15 < var_267_20 then
					arg_264_1.talkMaxDuration = var_267_20
					var_267_14 = var_267_14 + 0.3

					if var_267_20 + var_267_14 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_20 + var_267_14
					end
				end

				arg_264_1.text_.text = var_267_18
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261064", "story_v_out_417261.awb") ~= 0 then
					local var_267_21 = manager.audio:GetVoiceLength("story_v_out_417261", "417261064", "story_v_out_417261.awb") / 1000

					if var_267_21 + var_267_14 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_21 + var_267_14
					end

					if var_267_17.prefab_name ~= "" and arg_264_1.actors_[var_267_17.prefab_name] ~= nil then
						local var_267_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_17.prefab_name].transform, "story_v_out_417261", "417261064", "story_v_out_417261.awb")

						arg_264_1:RecordAudio("417261064", var_267_22)
						arg_264_1:RecordAudio("417261064", var_267_22)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_417261", "417261064", "story_v_out_417261.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_417261", "417261064", "story_v_out_417261.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_23 = var_267_14 + 0.3
			local var_267_24 = math.max(var_267_15, arg_264_1.talkMaxDuration)

			if var_267_14 + 0.3 <= arg_264_1.time_ and arg_264_1.time_ < var_267_23 + var_267_24 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_23) / var_267_24

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_23 + var_267_24 and arg_264_1.time_ < var_267_23 + var_267_24 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play417261065 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 417261065
		arg_270_1.duration_ = 4.77

		local var_270_0 = {
			zh = 2.4,
			ja = 4.766
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play417261066(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(arg_270_1.actors_["1034"]) and arg_270_1.var_.actorSpriteComps1034 == nil then
				arg_270_1.var_.actorSpriteComps1034 = arg_270_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_273_0 = 0.2

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_0 and not isNil(arg_270_1.actors_["1034"]) then
				if arg_270_1.var_.actorSpriteComps1034 then
					for iter_273_0, iter_273_1 in pairs(arg_270_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_273_1 then
							if arg_270_1.isInRecall_ then
								iter_273_1.color = Color.New(Mathf.Lerp(iter_273_1.color.r, arg_270_1.hightColor1.r, (arg_270_1.time_ - 0) / var_273_0), Mathf.Lerp(iter_273_1.color.g, arg_270_1.hightColor1.g, (arg_270_1.time_ - 0) / var_273_0), (Mathf.Lerp(iter_273_1.color.b, arg_270_1.hightColor1.b, (arg_270_1.time_ - 0) / var_273_0)))
							else
								local var_273_1 = Mathf.Lerp(iter_273_1.color.r, 1, (arg_270_1.time_ - 0) / var_273_0)

								iter_273_1.color = Color.New(var_273_1, var_273_1, var_273_1)
							end
						end
					end
				end
			end

			if arg_270_1.time_ >= 0 + var_273_0 and arg_270_1.time_ < 0 + var_273_0 + arg_273_0 and not isNil(arg_270_1.actors_["1034"]) and arg_270_1.var_.actorSpriteComps1034 then
				for iter_273_2, iter_273_3 in pairs(arg_270_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_273_3 then
						iter_273_3.color = arg_270_1.isInRecall_ and (arg_270_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_270_1.var_.actorSpriteComps1034 = nil
			end

			local var_273_2 = arg_270_1.actors_["1034"].transform

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.var_.moveOldPos1034 = var_273_2.localPosition
				var_273_2.localScale = Vector3.New(1, 1, 1)

				arg_270_1:CheckSpriteTmpPos("1034", 3)

				for iter_273_4 = 0, var_273_2.childCount - 1 do
					local var_273_3 = var_273_2:GetChild(iter_273_4)

					if var_273_3.name == "split_6" or not string.find(var_273_3.name, "split") then
						var_273_3.gameObject:SetActive(true)
					else
						var_273_3.gameObject:SetActive(false)
					end
				end
			end

			local var_273_4 = 0.001

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_4 then
				var_273_2.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_270_1.time_ - 0) / var_273_4)
			end

			if arg_270_1.time_ >= 0 + var_273_4 and arg_270_1.time_ < 0 + var_273_4 + arg_273_0 then
				var_273_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_273_5 = 0
			local var_273_6 = 0.225

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_5 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_7 = arg_270_1:GetWordFromCfg(417261065)
				local var_273_8 = arg_270_1:FormatText(var_273_7.content)

				arg_270_1.text_.text = var_273_8

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_10 = 9 <= 0 and var_273_6 or var_273_6 * (utf8.len(var_273_8) / 9)

				if (9 <= 0 and var_273_6 or var_273_6 * (utf8.len(var_273_8) / 9)) > 0 and var_273_6 < var_273_10 then
					arg_270_1.talkMaxDuration = var_273_10

					if var_273_10 + var_273_5 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_10 + var_273_5
					end
				end

				arg_270_1.text_.text = var_273_8
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261065", "story_v_out_417261.awb") ~= 0 then
					local var_273_11 = manager.audio:GetVoiceLength("story_v_out_417261", "417261065", "story_v_out_417261.awb") / 1000

					if var_273_11 + var_273_5 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_11 + var_273_5
					end

					if var_273_7.prefab_name ~= "" and arg_270_1.actors_[var_273_7.prefab_name] ~= nil then
						local var_273_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_7.prefab_name].transform, "story_v_out_417261", "417261065", "story_v_out_417261.awb")

						arg_270_1:RecordAudio("417261065", var_273_12)
						arg_270_1:RecordAudio("417261065", var_273_12)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_417261", "417261065", "story_v_out_417261.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_417261", "417261065", "story_v_out_417261.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_13 = math.max(var_273_6, arg_270_1.talkMaxDuration)

			if var_273_5 <= arg_270_1.time_ and arg_270_1.time_ < var_273_5 + var_273_13 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_5) / var_273_13

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_5 + var_273_13 and arg_270_1.time_ < var_273_5 + var_273_13 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play417261066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 417261066
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play417261067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(arg_274_1.actors_["1034"]) and arg_274_1.var_.actorSpriteComps1034 == nil then
				arg_274_1.var_.actorSpriteComps1034 = arg_274_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_277_0 = 0.2

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_0 and not isNil(arg_274_1.actors_["1034"]) then
				if arg_274_1.var_.actorSpriteComps1034 then
					for iter_277_0, iter_277_1 in pairs(arg_274_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_277_1 then
							if arg_274_1.isInRecall_ then
								iter_277_1.color = Color.New(Mathf.Lerp(iter_277_1.color.r, arg_274_1.hightColor2.r, (arg_274_1.time_ - 0) / var_277_0), Mathf.Lerp(iter_277_1.color.g, arg_274_1.hightColor2.g, (arg_274_1.time_ - 0) / var_277_0), (Mathf.Lerp(iter_277_1.color.b, arg_274_1.hightColor2.b, (arg_274_1.time_ - 0) / var_277_0)))
							else
								local var_277_1 = Mathf.Lerp(iter_277_1.color.r, 0.5, (arg_274_1.time_ - 0) / var_277_0)

								iter_277_1.color = Color.New(var_277_1, var_277_1, var_277_1)
							end
						end
					end
				end
			end

			if arg_274_1.time_ >= 0 + var_277_0 and arg_274_1.time_ < 0 + var_277_0 + arg_277_0 and not isNil(arg_274_1.actors_["1034"]) and arg_274_1.var_.actorSpriteComps1034 then
				for iter_277_2, iter_277_3 in pairs(arg_274_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_277_3 then
						iter_277_3.color = arg_274_1.isInRecall_ and (arg_274_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_274_1.var_.actorSpriteComps1034 = nil
			end

			local var_277_2 = 0
			local var_277_3 = 1.425

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_2 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, false)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_4 = arg_274_1:FormatText(arg_274_1:GetWordFromCfg(417261066).content)

				arg_274_1.text_.text = var_277_4

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_6 = 57 <= 0 and var_277_3 or var_277_3 * (utf8.len(var_277_4) / 57)

				if (57 <= 0 and var_277_3 or var_277_3 * (utf8.len(var_277_4) / 57)) > 0 and var_277_3 < var_277_6 then
					arg_274_1.talkMaxDuration = var_277_6

					if var_277_6 + var_277_2 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_6 + var_277_2
					end
				end

				arg_274_1.text_.text = var_277_4
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_7 = math.max(var_277_3, arg_274_1.talkMaxDuration)

			if var_277_2 <= arg_274_1.time_ and arg_274_1.time_ < var_277_2 + var_277_7 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_2) / var_277_7

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_2 + var_277_7 and arg_274_1.time_ < var_277_2 + var_277_7 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play417261067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 417261067
		arg_278_1.duration_ = 3.97

		local var_278_0 = {
			zh = 2.733,
			ja = 3.966
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
				arg_278_0:Play417261068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 and not isNil(arg_278_1.actors_["1034"]) and arg_278_1.var_.actorSpriteComps1034 == nil then
				arg_278_1.var_.actorSpriteComps1034 = arg_278_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_281_0 = 0.2

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_0 and not isNil(arg_278_1.actors_["1034"]) then
				if arg_278_1.var_.actorSpriteComps1034 then
					for iter_281_0, iter_281_1 in pairs(arg_278_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_281_1 then
							if arg_278_1.isInRecall_ then
								iter_281_1.color = Color.New(Mathf.Lerp(iter_281_1.color.r, arg_278_1.hightColor2.r, (arg_278_1.time_ - 0) / var_281_0), Mathf.Lerp(iter_281_1.color.g, arg_278_1.hightColor2.g, (arg_278_1.time_ - 0) / var_281_0), (Mathf.Lerp(iter_281_1.color.b, arg_278_1.hightColor2.b, (arg_278_1.time_ - 0) / var_281_0)))
							else
								local var_281_1 = Mathf.Lerp(iter_281_1.color.r, 0.5, (arg_278_1.time_ - 0) / var_281_0)

								iter_281_1.color = Color.New(var_281_1, var_281_1, var_281_1)
							end
						end
					end
				end
			end

			if arg_278_1.time_ >= 0 + var_281_0 and arg_278_1.time_ < 0 + var_281_0 + arg_281_0 and not isNil(arg_278_1.actors_["1034"]) and arg_278_1.var_.actorSpriteComps1034 then
				for iter_281_2, iter_281_3 in pairs(arg_278_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_281_3 then
						iter_281_3.color = arg_278_1.isInRecall_ and (arg_278_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_278_1.var_.actorSpriteComps1034 = nil
			end

			local var_281_2 = arg_278_1.actors_["1034"].transform

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.var_.moveOldPos1034 = var_281_2.localPosition
				var_281_2.localScale = Vector3.New(1, 1, 1)

				arg_278_1:CheckSpriteTmpPos("1034", 2)

				for iter_281_4 = 0, var_281_2.childCount - 1 do
					local var_281_3 = var_281_2:GetChild(iter_281_4)

					if var_281_3.name == "split_6" or not string.find(var_281_3.name, "split") then
						var_281_3.gameObject:SetActive(true)
					else
						var_281_3.gameObject:SetActive(false)
					end
				end
			end

			local var_281_4 = 0.001

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_4 then
				var_281_2.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_278_1.time_ - 0) / var_281_4)
			end

			if arg_278_1.time_ >= 0 + var_281_4 and arg_278_1.time_ < 0 + var_281_4 + arg_281_0 then
				var_281_2.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_281_5 = arg_278_1.actors_["10128"]

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 and not isNil(var_281_5) and arg_278_1.var_.actorSpriteComps10128 == nil then
				arg_278_1.var_.actorSpriteComps10128 = var_281_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_281_6 = 0.2

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_6 and not isNil(var_281_5) then
				if arg_278_1.var_.actorSpriteComps10128 then
					for iter_281_5, iter_281_6 in pairs(arg_278_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_281_6 then
							if arg_278_1.isInRecall_ then
								iter_281_6.color = Color.New(Mathf.Lerp(iter_281_6.color.r, arg_278_1.hightColor1.r, (arg_278_1.time_ - 0) / var_281_6), Mathf.Lerp(iter_281_6.color.g, arg_278_1.hightColor1.g, (arg_278_1.time_ - 0) / var_281_6), (Mathf.Lerp(iter_281_6.color.b, arg_278_1.hightColor1.b, (arg_278_1.time_ - 0) / var_281_6)))
							else
								local var_281_7 = Mathf.Lerp(iter_281_6.color.r, 1, (arg_278_1.time_ - 0) / var_281_6)

								iter_281_6.color = Color.New(var_281_7, var_281_7, var_281_7)
							end
						end
					end
				end
			end

			if arg_278_1.time_ >= 0 + var_281_6 and arg_278_1.time_ < 0 + var_281_6 + arg_281_0 and not isNil(var_281_5) and arg_278_1.var_.actorSpriteComps10128 then
				for iter_281_7, iter_281_8 in pairs(arg_278_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_281_8 then
						iter_281_8.color = arg_278_1.isInRecall_ and (arg_278_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_278_1.var_.actorSpriteComps10128 = nil
			end

			local var_281_8 = arg_278_1.actors_["10128"].transform

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.var_.moveOldPos10128 = var_281_8.localPosition
				var_281_8.localScale = Vector3.New(1, 1, 1)

				arg_278_1:CheckSpriteTmpPos("10128", 4)

				for iter_281_9 = 0, var_281_8.childCount - 1 do
					local var_281_9 = var_281_8:GetChild(iter_281_9)

					if var_281_9.name == "" or not string.find(var_281_9.name, "split") then
						var_281_9.gameObject:SetActive(true)
					else
						var_281_9.gameObject:SetActive(false)
					end
				end
			end

			local var_281_10 = 0.001

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_10 then
				var_281_8.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos10128, Vector3.New(390, -347, -300), (arg_278_1.time_ - 0) / var_281_10)
			end

			if arg_278_1.time_ >= 0 + var_281_10 and arg_278_1.time_ < 0 + var_281_10 + arg_281_0 then
				var_281_8.localPosition = Vector3.New(390, -347, -300)
			end

			local var_281_11 = 0
			local var_281_12 = 0.325

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_11 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_13 = arg_278_1:GetWordFromCfg(417261067)
				local var_281_14 = arg_278_1:FormatText(var_281_13.content)

				arg_278_1.text_.text = var_281_14

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_16 = 13 <= 0 and var_281_12 or var_281_12 * (utf8.len(var_281_14) / 13)

				if (13 <= 0 and var_281_12 or var_281_12 * (utf8.len(var_281_14) / 13)) > 0 and var_281_12 < var_281_16 then
					arg_278_1.talkMaxDuration = var_281_16

					if var_281_16 + var_281_11 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_16 + var_281_11
					end
				end

				arg_278_1.text_.text = var_281_14
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261067", "story_v_out_417261.awb") ~= 0 then
					local var_281_17 = manager.audio:GetVoiceLength("story_v_out_417261", "417261067", "story_v_out_417261.awb") / 1000

					if var_281_17 + var_281_11 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_17 + var_281_11
					end

					if var_281_13.prefab_name ~= "" and arg_278_1.actors_[var_281_13.prefab_name] ~= nil then
						local var_281_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_13.prefab_name].transform, "story_v_out_417261", "417261067", "story_v_out_417261.awb")

						arg_278_1:RecordAudio("417261067", var_281_18)
						arg_278_1:RecordAudio("417261067", var_281_18)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_417261", "417261067", "story_v_out_417261.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_417261", "417261067", "story_v_out_417261.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_19 = math.max(var_281_12, arg_278_1.talkMaxDuration)

			if var_281_11 <= arg_278_1.time_ and arg_278_1.time_ < var_281_11 + var_281_19 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_11) / var_281_19

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_11 + var_281_19 and arg_278_1.time_ < var_281_11 + var_281_19 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_278_1:InitPlayNodeList()
	end,
	Play417261068 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 417261068
		arg_282_1.duration_ = 5.6

		local var_282_0 = {
			zh = 3.466,
			ja = 5.6
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
				arg_282_0:Play417261069(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(arg_282_1.actors_["1034"]) and arg_282_1.var_.actorSpriteComps1034 == nil then
				arg_282_1.var_.actorSpriteComps1034 = arg_282_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_285_0 = 0.2

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_0 and not isNil(arg_282_1.actors_["1034"]) then
				if arg_282_1.var_.actorSpriteComps1034 then
					for iter_285_0, iter_285_1 in pairs(arg_282_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_285_1 then
							if arg_282_1.isInRecall_ then
								iter_285_1.color = Color.New(Mathf.Lerp(iter_285_1.color.r, arg_282_1.hightColor1.r, (arg_282_1.time_ - 0) / var_285_0), Mathf.Lerp(iter_285_1.color.g, arg_282_1.hightColor1.g, (arg_282_1.time_ - 0) / var_285_0), (Mathf.Lerp(iter_285_1.color.b, arg_282_1.hightColor1.b, (arg_282_1.time_ - 0) / var_285_0)))
							else
								local var_285_1 = Mathf.Lerp(iter_285_1.color.r, 1, (arg_282_1.time_ - 0) / var_285_0)

								iter_285_1.color = Color.New(var_285_1, var_285_1, var_285_1)
							end
						end
					end
				end
			end

			if arg_282_1.time_ >= 0 + var_285_0 and arg_282_1.time_ < 0 + var_285_0 + arg_285_0 and not isNil(arg_282_1.actors_["1034"]) and arg_282_1.var_.actorSpriteComps1034 then
				for iter_285_2, iter_285_3 in pairs(arg_282_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_285_3 then
						iter_285_3.color = arg_282_1.isInRecall_ and (arg_282_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_282_1.var_.actorSpriteComps1034 = nil
			end

			local var_285_2 = arg_282_1.actors_["10128"]

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(var_285_2) and arg_282_1.var_.actorSpriteComps10128 == nil then
				arg_282_1.var_.actorSpriteComps10128 = var_285_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_285_3 = 0.2

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_3 and not isNil(var_285_2) then
				if arg_282_1.var_.actorSpriteComps10128 then
					for iter_285_4, iter_285_5 in pairs(arg_282_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_285_5 then
							if arg_282_1.isInRecall_ then
								iter_285_5.color = Color.New(Mathf.Lerp(iter_285_5.color.r, arg_282_1.hightColor2.r, (arg_282_1.time_ - 0) / var_285_3), Mathf.Lerp(iter_285_5.color.g, arg_282_1.hightColor2.g, (arg_282_1.time_ - 0) / var_285_3), (Mathf.Lerp(iter_285_5.color.b, arg_282_1.hightColor2.b, (arg_282_1.time_ - 0) / var_285_3)))
							else
								local var_285_4 = Mathf.Lerp(iter_285_5.color.r, 0.5, (arg_282_1.time_ - 0) / var_285_3)

								iter_285_5.color = Color.New(var_285_4, var_285_4, var_285_4)
							end
						end
					end
				end
			end

			if arg_282_1.time_ >= 0 + var_285_3 and arg_282_1.time_ < 0 + var_285_3 + arg_285_0 and not isNil(var_285_2) and arg_282_1.var_.actorSpriteComps10128 then
				for iter_285_6, iter_285_7 in pairs(arg_282_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_285_7 then
						iter_285_7.color = arg_282_1.isInRecall_ and (arg_282_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_282_1.var_.actorSpriteComps10128 = nil
			end

			local var_285_5 = 0
			local var_285_6 = 0.35

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_5 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_7 = arg_282_1:GetWordFromCfg(417261068)
				local var_285_8 = arg_282_1:FormatText(var_285_7.content)

				arg_282_1.text_.text = var_285_8

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_10 = 14 <= 0 and var_285_6 or var_285_6 * (utf8.len(var_285_8) / 14)

				if (14 <= 0 and var_285_6 or var_285_6 * (utf8.len(var_285_8) / 14)) > 0 and var_285_6 < var_285_10 then
					arg_282_1.talkMaxDuration = var_285_10

					if var_285_10 + var_285_5 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_10 + var_285_5
					end
				end

				arg_282_1.text_.text = var_285_8
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261068", "story_v_out_417261.awb") ~= 0 then
					local var_285_11 = manager.audio:GetVoiceLength("story_v_out_417261", "417261068", "story_v_out_417261.awb") / 1000

					if var_285_11 + var_285_5 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_11 + var_285_5
					end

					if var_285_7.prefab_name ~= "" and arg_282_1.actors_[var_285_7.prefab_name] ~= nil then
						local var_285_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_7.prefab_name].transform, "story_v_out_417261", "417261068", "story_v_out_417261.awb")

						arg_282_1:RecordAudio("417261068", var_285_12)
						arg_282_1:RecordAudio("417261068", var_285_12)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_417261", "417261068", "story_v_out_417261.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_417261", "417261068", "story_v_out_417261.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_13 = math.max(var_285_6, arg_282_1.talkMaxDuration)

			if var_285_5 <= arg_282_1.time_ and arg_282_1.time_ < var_285_5 + var_285_13 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_5) / var_285_13

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_5 + var_285_13 and arg_282_1.time_ < var_285_5 + var_285_13 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play417261069 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 417261069
		arg_286_1.duration_ = 4.17

		local var_286_0 = {
			zh = 2.7,
			ja = 4.166
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
				arg_286_0:Play417261070(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0.325

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_1 = arg_286_1:GetWordFromCfg(417261069)
				local var_289_2 = arg_286_1:FormatText(var_289_1.content)

				arg_286_1.text_.text = var_289_2

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_4 = 13 <= 0 and var_289_0 or var_289_0 * (utf8.len(var_289_2) / 13)

				if (13 <= 0 and var_289_0 or var_289_0 * (utf8.len(var_289_2) / 13)) > 0 and var_289_0 < var_289_4 then
					arg_286_1.talkMaxDuration = var_289_4

					if var_289_4 + 0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_4 + 0
					end
				end

				arg_286_1.text_.text = var_289_2
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261069", "story_v_out_417261.awb") ~= 0 then
					local var_289_5 = manager.audio:GetVoiceLength("story_v_out_417261", "417261069", "story_v_out_417261.awb") / 1000

					if var_289_5 + 0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_5 + 0
					end

					if var_289_1.prefab_name ~= "" and arg_286_1.actors_[var_289_1.prefab_name] ~= nil then
						local var_289_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_1.prefab_name].transform, "story_v_out_417261", "417261069", "story_v_out_417261.awb")

						arg_286_1:RecordAudio("417261069", var_289_6)
						arg_286_1:RecordAudio("417261069", var_289_6)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_417261", "417261069", "story_v_out_417261.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_417261", "417261069", "story_v_out_417261.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_7 = math.max(var_289_0, arg_286_1.talkMaxDuration)

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_7 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - 0) / var_289_7

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= 0 + var_289_7 and arg_286_1.time_ < 0 + var_289_7 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play417261070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 417261070
		arg_290_1.duration_ = 2.93

		local var_290_0 = {
			zh = 2.9,
			ja = 2.933
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
				arg_290_0:Play417261071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(arg_290_1.actors_["1034"]) and arg_290_1.var_.actorSpriteComps1034 == nil then
				arg_290_1.var_.actorSpriteComps1034 = arg_290_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_293_0 = 0.2

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_0 and not isNil(arg_290_1.actors_["1034"]) then
				if arg_290_1.var_.actorSpriteComps1034 then
					for iter_293_0, iter_293_1 in pairs(arg_290_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_293_1 then
							if arg_290_1.isInRecall_ then
								iter_293_1.color = Color.New(Mathf.Lerp(iter_293_1.color.r, arg_290_1.hightColor2.r, (arg_290_1.time_ - 0) / var_293_0), Mathf.Lerp(iter_293_1.color.g, arg_290_1.hightColor2.g, (arg_290_1.time_ - 0) / var_293_0), (Mathf.Lerp(iter_293_1.color.b, arg_290_1.hightColor2.b, (arg_290_1.time_ - 0) / var_293_0)))
							else
								local var_293_1 = Mathf.Lerp(iter_293_1.color.r, 0.5, (arg_290_1.time_ - 0) / var_293_0)

								iter_293_1.color = Color.New(var_293_1, var_293_1, var_293_1)
							end
						end
					end
				end
			end

			if arg_290_1.time_ >= 0 + var_293_0 and arg_290_1.time_ < 0 + var_293_0 + arg_293_0 and not isNil(arg_290_1.actors_["1034"]) and arg_290_1.var_.actorSpriteComps1034 then
				for iter_293_2, iter_293_3 in pairs(arg_290_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_293_3 then
						iter_293_3.color = arg_290_1.isInRecall_ and (arg_290_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_290_1.var_.actorSpriteComps1034 = nil
			end

			local var_293_2 = arg_290_1.actors_["10128"]

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(var_293_2) and arg_290_1.var_.actorSpriteComps10128 == nil then
				arg_290_1.var_.actorSpriteComps10128 = var_293_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_293_3 = 0.2

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_3 and not isNil(var_293_2) then
				if arg_290_1.var_.actorSpriteComps10128 then
					for iter_293_4, iter_293_5 in pairs(arg_290_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_293_5 then
							if arg_290_1.isInRecall_ then
								iter_293_5.color = Color.New(Mathf.Lerp(iter_293_5.color.r, arg_290_1.hightColor1.r, (arg_290_1.time_ - 0) / var_293_3), Mathf.Lerp(iter_293_5.color.g, arg_290_1.hightColor1.g, (arg_290_1.time_ - 0) / var_293_3), (Mathf.Lerp(iter_293_5.color.b, arg_290_1.hightColor1.b, (arg_290_1.time_ - 0) / var_293_3)))
							else
								local var_293_4 = Mathf.Lerp(iter_293_5.color.r, 1, (arg_290_1.time_ - 0) / var_293_3)

								iter_293_5.color = Color.New(var_293_4, var_293_4, var_293_4)
							end
						end
					end
				end
			end

			if arg_290_1.time_ >= 0 + var_293_3 and arg_290_1.time_ < 0 + var_293_3 + arg_293_0 and not isNil(var_293_2) and arg_290_1.var_.actorSpriteComps10128 then
				for iter_293_6, iter_293_7 in pairs(arg_290_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_293_7 then
						iter_293_7.color = arg_290_1.isInRecall_ and (arg_290_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_290_1.var_.actorSpriteComps10128 = nil
			end

			local var_293_5 = 0
			local var_293_6 = 0.425

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_5 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_7 = arg_290_1:GetWordFromCfg(417261070)
				local var_293_8 = arg_290_1:FormatText(var_293_7.content)

				arg_290_1.text_.text = var_293_8

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_10 = 17 <= 0 and var_293_6 or var_293_6 * (utf8.len(var_293_8) / 17)

				if (17 <= 0 and var_293_6 or var_293_6 * (utf8.len(var_293_8) / 17)) > 0 and var_293_6 < var_293_10 then
					arg_290_1.talkMaxDuration = var_293_10

					if var_293_10 + var_293_5 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_10 + var_293_5
					end
				end

				arg_290_1.text_.text = var_293_8
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261070", "story_v_out_417261.awb") ~= 0 then
					local var_293_11 = manager.audio:GetVoiceLength("story_v_out_417261", "417261070", "story_v_out_417261.awb") / 1000

					if var_293_11 + var_293_5 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_11 + var_293_5
					end

					if var_293_7.prefab_name ~= "" and arg_290_1.actors_[var_293_7.prefab_name] ~= nil then
						local var_293_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_7.prefab_name].transform, "story_v_out_417261", "417261070", "story_v_out_417261.awb")

						arg_290_1:RecordAudio("417261070", var_293_12)
						arg_290_1:RecordAudio("417261070", var_293_12)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_417261", "417261070", "story_v_out_417261.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_417261", "417261070", "story_v_out_417261.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_13 = math.max(var_293_6, arg_290_1.talkMaxDuration)

			if var_293_5 <= arg_290_1.time_ and arg_290_1.time_ < var_293_5 + var_293_13 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_5) / var_293_13

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_5 + var_293_13 and arg_290_1.time_ < var_293_5 + var_293_13 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play417261071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 417261071
		arg_294_1.duration_ = 4.53

		local var_294_0 = {
			zh = 3.766,
			ja = 4.533
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play417261072(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0.525

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_1 = arg_294_1:GetWordFromCfg(417261071)
				local var_297_2 = arg_294_1:FormatText(var_297_1.content)

				arg_294_1.text_.text = var_297_2

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_4 = 21 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_2) / 21)

				if (21 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_2) / 21)) > 0 and var_297_0 < var_297_4 then
					arg_294_1.talkMaxDuration = var_297_4

					if var_297_4 + 0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_4 + 0
					end
				end

				arg_294_1.text_.text = var_297_2
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261071", "story_v_out_417261.awb") ~= 0 then
					local var_297_5 = manager.audio:GetVoiceLength("story_v_out_417261", "417261071", "story_v_out_417261.awb") / 1000

					if var_297_5 + 0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_5 + 0
					end

					if var_297_1.prefab_name ~= "" and arg_294_1.actors_[var_297_1.prefab_name] ~= nil then
						local var_297_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_1.prefab_name].transform, "story_v_out_417261", "417261071", "story_v_out_417261.awb")

						arg_294_1:RecordAudio("417261071", var_297_6)
						arg_294_1:RecordAudio("417261071", var_297_6)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_417261", "417261071", "story_v_out_417261.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_417261", "417261071", "story_v_out_417261.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_7 = math.max(var_297_0, arg_294_1.talkMaxDuration)

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_7 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - 0) / var_297_7

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= 0 + var_297_7 and arg_294_1.time_ < 0 + var_297_7 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play417261072 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 417261072
		arg_298_1.duration_ = 5.3

		local var_298_0 = {
			zh = 3.4,
			ja = 5.3
		}
		local var_298_1 = manager.audio:GetLocalizationFlag()

		if var_298_0[var_298_1] ~= nil then
			arg_298_1.duration_ = var_298_0[var_298_1]
		end

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play417261073(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 and not isNil(arg_298_1.actors_["1034"]) and arg_298_1.var_.actorSpriteComps1034 == nil then
				arg_298_1.var_.actorSpriteComps1034 = arg_298_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_301_0 = 0.2

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_0 and not isNil(arg_298_1.actors_["1034"]) then
				if arg_298_1.var_.actorSpriteComps1034 then
					for iter_301_0, iter_301_1 in pairs(arg_298_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_301_1 then
							if arg_298_1.isInRecall_ then
								iter_301_1.color = Color.New(Mathf.Lerp(iter_301_1.color.r, arg_298_1.hightColor1.r, (arg_298_1.time_ - 0) / var_301_0), Mathf.Lerp(iter_301_1.color.g, arg_298_1.hightColor1.g, (arg_298_1.time_ - 0) / var_301_0), (Mathf.Lerp(iter_301_1.color.b, arg_298_1.hightColor1.b, (arg_298_1.time_ - 0) / var_301_0)))
							else
								local var_301_1 = Mathf.Lerp(iter_301_1.color.r, 1, (arg_298_1.time_ - 0) / var_301_0)

								iter_301_1.color = Color.New(var_301_1, var_301_1, var_301_1)
							end
						end
					end
				end
			end

			if arg_298_1.time_ >= 0 + var_301_0 and arg_298_1.time_ < 0 + var_301_0 + arg_301_0 and not isNil(arg_298_1.actors_["1034"]) and arg_298_1.var_.actorSpriteComps1034 then
				for iter_301_2, iter_301_3 in pairs(arg_298_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_301_3 then
						iter_301_3.color = arg_298_1.isInRecall_ and (arg_298_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_298_1.var_.actorSpriteComps1034 = nil
			end

			local var_301_2 = arg_298_1.actors_["10128"]

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 and not isNil(var_301_2) and arg_298_1.var_.actorSpriteComps10128 == nil then
				arg_298_1.var_.actorSpriteComps10128 = var_301_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_301_3 = 0.2

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_3 and not isNil(var_301_2) then
				if arg_298_1.var_.actorSpriteComps10128 then
					for iter_301_4, iter_301_5 in pairs(arg_298_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_301_5 then
							if arg_298_1.isInRecall_ then
								iter_301_5.color = Color.New(Mathf.Lerp(iter_301_5.color.r, arg_298_1.hightColor2.r, (arg_298_1.time_ - 0) / var_301_3), Mathf.Lerp(iter_301_5.color.g, arg_298_1.hightColor2.g, (arg_298_1.time_ - 0) / var_301_3), (Mathf.Lerp(iter_301_5.color.b, arg_298_1.hightColor2.b, (arg_298_1.time_ - 0) / var_301_3)))
							else
								local var_301_4 = Mathf.Lerp(iter_301_5.color.r, 0.5, (arg_298_1.time_ - 0) / var_301_3)

								iter_301_5.color = Color.New(var_301_4, var_301_4, var_301_4)
							end
						end
					end
				end
			end

			if arg_298_1.time_ >= 0 + var_301_3 and arg_298_1.time_ < 0 + var_301_3 + arg_301_0 and not isNil(var_301_2) and arg_298_1.var_.actorSpriteComps10128 then
				for iter_301_6, iter_301_7 in pairs(arg_298_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_301_7 then
						iter_301_7.color = arg_298_1.isInRecall_ and (arg_298_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_298_1.var_.actorSpriteComps10128 = nil
			end

			local var_301_5 = arg_298_1.actors_["1034"].transform

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.var_.moveOldPos1034 = var_301_5.localPosition
				var_301_5.localScale = Vector3.New(1, 1, 1)

				arg_298_1:CheckSpriteTmpPos("1034", 2)

				for iter_301_8 = 0, var_301_5.childCount - 1 do
					local var_301_6 = var_301_5:GetChild(iter_301_8)

					if var_301_6.name == "split_5" or not string.find(var_301_6.name, "split") then
						var_301_6.gameObject:SetActive(true)
					else
						var_301_6.gameObject:SetActive(false)
					end
				end
			end

			local var_301_7 = 0.001

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_7 then
				var_301_5.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_298_1.time_ - 0) / var_301_7)
			end

			if arg_298_1.time_ >= 0 + var_301_7 and arg_298_1.time_ < 0 + var_301_7 + arg_301_0 then
				var_301_5.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_301_8 = 0
			local var_301_9 = 0.325

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_8 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_10 = arg_298_1:GetWordFromCfg(417261072)
				local var_301_11 = arg_298_1:FormatText(var_301_10.content)

				arg_298_1.text_.text = var_301_11

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_13 = 13 <= 0 and var_301_9 or var_301_9 * (utf8.len(var_301_11) / 13)

				if (13 <= 0 and var_301_9 or var_301_9 * (utf8.len(var_301_11) / 13)) > 0 and var_301_9 < var_301_13 then
					arg_298_1.talkMaxDuration = var_301_13

					if var_301_13 + var_301_8 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_13 + var_301_8
					end
				end

				arg_298_1.text_.text = var_301_11
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261072", "story_v_out_417261.awb") ~= 0 then
					local var_301_14 = manager.audio:GetVoiceLength("story_v_out_417261", "417261072", "story_v_out_417261.awb") / 1000

					if var_301_14 + var_301_8 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_14 + var_301_8
					end

					if var_301_10.prefab_name ~= "" and arg_298_1.actors_[var_301_10.prefab_name] ~= nil then
						local var_301_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_10.prefab_name].transform, "story_v_out_417261", "417261072", "story_v_out_417261.awb")

						arg_298_1:RecordAudio("417261072", var_301_15)
						arg_298_1:RecordAudio("417261072", var_301_15)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_417261", "417261072", "story_v_out_417261.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_417261", "417261072", "story_v_out_417261.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_16 = math.max(var_301_9, arg_298_1.talkMaxDuration)

			if var_301_8 <= arg_298_1.time_ and arg_298_1.time_ < var_301_8 + var_301_16 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_8) / var_301_16

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_8 + var_301_16 and arg_298_1.time_ < var_301_8 + var_301_16 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_298_1:InitPlayNodeList()
	end,
	Play417261073 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 417261073
		arg_302_1.duration_ = 1.93

		local var_302_0 = {
			zh = 1.633,
			ja = 1.933
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
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play417261074(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 and not isNil(arg_302_1.actors_["1034"]) and arg_302_1.var_.actorSpriteComps1034 == nil then
				arg_302_1.var_.actorSpriteComps1034 = arg_302_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_305_0 = 0.2

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_0 and not isNil(arg_302_1.actors_["1034"]) then
				if arg_302_1.var_.actorSpriteComps1034 then
					for iter_305_0, iter_305_1 in pairs(arg_302_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_305_1 then
							if arg_302_1.isInRecall_ then
								iter_305_1.color = Color.New(Mathf.Lerp(iter_305_1.color.r, arg_302_1.hightColor2.r, (arg_302_1.time_ - 0) / var_305_0), Mathf.Lerp(iter_305_1.color.g, arg_302_1.hightColor2.g, (arg_302_1.time_ - 0) / var_305_0), (Mathf.Lerp(iter_305_1.color.b, arg_302_1.hightColor2.b, (arg_302_1.time_ - 0) / var_305_0)))
							else
								local var_305_1 = Mathf.Lerp(iter_305_1.color.r, 0.5, (arg_302_1.time_ - 0) / var_305_0)

								iter_305_1.color = Color.New(var_305_1, var_305_1, var_305_1)
							end
						end
					end
				end
			end

			if arg_302_1.time_ >= 0 + var_305_0 and arg_302_1.time_ < 0 + var_305_0 + arg_305_0 and not isNil(arg_302_1.actors_["1034"]) and arg_302_1.var_.actorSpriteComps1034 then
				for iter_305_2, iter_305_3 in pairs(arg_302_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_305_3 then
						iter_305_3.color = arg_302_1.isInRecall_ and (arg_302_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_302_1.var_.actorSpriteComps1034 = nil
			end

			local var_305_2 = arg_302_1.actors_["10128"]

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 and not isNil(var_305_2) and arg_302_1.var_.actorSpriteComps10128 == nil then
				arg_302_1.var_.actorSpriteComps10128 = var_305_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_305_3 = 0.2

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_3 and not isNil(var_305_2) then
				if arg_302_1.var_.actorSpriteComps10128 then
					for iter_305_4, iter_305_5 in pairs(arg_302_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_305_5 then
							if arg_302_1.isInRecall_ then
								iter_305_5.color = Color.New(Mathf.Lerp(iter_305_5.color.r, arg_302_1.hightColor1.r, (arg_302_1.time_ - 0) / var_305_3), Mathf.Lerp(iter_305_5.color.g, arg_302_1.hightColor1.g, (arg_302_1.time_ - 0) / var_305_3), (Mathf.Lerp(iter_305_5.color.b, arg_302_1.hightColor1.b, (arg_302_1.time_ - 0) / var_305_3)))
							else
								local var_305_4 = Mathf.Lerp(iter_305_5.color.r, 1, (arg_302_1.time_ - 0) / var_305_3)

								iter_305_5.color = Color.New(var_305_4, var_305_4, var_305_4)
							end
						end
					end
				end
			end

			if arg_302_1.time_ >= 0 + var_305_3 and arg_302_1.time_ < 0 + var_305_3 + arg_305_0 and not isNil(var_305_2) and arg_302_1.var_.actorSpriteComps10128 then
				for iter_305_6, iter_305_7 in pairs(arg_302_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_305_7 then
						iter_305_7.color = arg_302_1.isInRecall_ and (arg_302_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_302_1.var_.actorSpriteComps10128 = nil
			end

			local var_305_5 = 0
			local var_305_6 = 0.175

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_5 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_7 = arg_302_1:GetWordFromCfg(417261073)
				local var_305_8 = arg_302_1:FormatText(var_305_7.content)

				arg_302_1.text_.text = var_305_8

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_10 = 7 <= 0 and var_305_6 or var_305_6 * (utf8.len(var_305_8) / 7)

				if (7 <= 0 and var_305_6 or var_305_6 * (utf8.len(var_305_8) / 7)) > 0 and var_305_6 < var_305_10 then
					arg_302_1.talkMaxDuration = var_305_10

					if var_305_10 + var_305_5 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_10 + var_305_5
					end
				end

				arg_302_1.text_.text = var_305_8
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261073", "story_v_out_417261.awb") ~= 0 then
					local var_305_11 = manager.audio:GetVoiceLength("story_v_out_417261", "417261073", "story_v_out_417261.awb") / 1000

					if var_305_11 + var_305_5 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_11 + var_305_5
					end

					if var_305_7.prefab_name ~= "" and arg_302_1.actors_[var_305_7.prefab_name] ~= nil then
						local var_305_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_7.prefab_name].transform, "story_v_out_417261", "417261073", "story_v_out_417261.awb")

						arg_302_1:RecordAudio("417261073", var_305_12)
						arg_302_1:RecordAudio("417261073", var_305_12)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_417261", "417261073", "story_v_out_417261.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_417261", "417261073", "story_v_out_417261.awb")
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

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play417261074 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 417261074
		arg_306_1.duration_ = 5.5

		local var_306_0 = {
			zh = 4.6,
			ja = 5.5
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play417261075(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(arg_306_1.actors_["1034"]) and arg_306_1.var_.actorSpriteComps1034 == nil then
				arg_306_1.var_.actorSpriteComps1034 = arg_306_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_309_0 = 0.2

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_0 and not isNil(arg_306_1.actors_["1034"]) then
				if arg_306_1.var_.actorSpriteComps1034 then
					for iter_309_0, iter_309_1 in pairs(arg_306_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_309_1 then
							if arg_306_1.isInRecall_ then
								iter_309_1.color = Color.New(Mathf.Lerp(iter_309_1.color.r, arg_306_1.hightColor1.r, (arg_306_1.time_ - 0) / var_309_0), Mathf.Lerp(iter_309_1.color.g, arg_306_1.hightColor1.g, (arg_306_1.time_ - 0) / var_309_0), (Mathf.Lerp(iter_309_1.color.b, arg_306_1.hightColor1.b, (arg_306_1.time_ - 0) / var_309_0)))
							else
								local var_309_1 = Mathf.Lerp(iter_309_1.color.r, 1, (arg_306_1.time_ - 0) / var_309_0)

								iter_309_1.color = Color.New(var_309_1, var_309_1, var_309_1)
							end
						end
					end
				end
			end

			if arg_306_1.time_ >= 0 + var_309_0 and arg_306_1.time_ < 0 + var_309_0 + arg_309_0 and not isNil(arg_306_1.actors_["1034"]) and arg_306_1.var_.actorSpriteComps1034 then
				for iter_309_2, iter_309_3 in pairs(arg_306_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_309_3 then
						iter_309_3.color = arg_306_1.isInRecall_ and (arg_306_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_306_1.var_.actorSpriteComps1034 = nil
			end

			local var_309_2 = arg_306_1.actors_["10128"]

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(var_309_2) and arg_306_1.var_.actorSpriteComps10128 == nil then
				arg_306_1.var_.actorSpriteComps10128 = var_309_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_309_3 = 0.2

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_3 and not isNil(var_309_2) then
				if arg_306_1.var_.actorSpriteComps10128 then
					for iter_309_4, iter_309_5 in pairs(arg_306_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_309_5 then
							if arg_306_1.isInRecall_ then
								iter_309_5.color = Color.New(Mathf.Lerp(iter_309_5.color.r, arg_306_1.hightColor2.r, (arg_306_1.time_ - 0) / var_309_3), Mathf.Lerp(iter_309_5.color.g, arg_306_1.hightColor2.g, (arg_306_1.time_ - 0) / var_309_3), (Mathf.Lerp(iter_309_5.color.b, arg_306_1.hightColor2.b, (arg_306_1.time_ - 0) / var_309_3)))
							else
								local var_309_4 = Mathf.Lerp(iter_309_5.color.r, 0.5, (arg_306_1.time_ - 0) / var_309_3)

								iter_309_5.color = Color.New(var_309_4, var_309_4, var_309_4)
							end
						end
					end
				end
			end

			if arg_306_1.time_ >= 0 + var_309_3 and arg_306_1.time_ < 0 + var_309_3 + arg_309_0 and not isNil(var_309_2) and arg_306_1.var_.actorSpriteComps10128 then
				for iter_309_6, iter_309_7 in pairs(arg_306_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_309_7 then
						iter_309_7.color = arg_306_1.isInRecall_ and (arg_306_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_306_1.var_.actorSpriteComps10128 = nil
			end

			local var_309_5 = arg_306_1.actors_["1034"].transform

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.var_.moveOldPos1034 = var_309_5.localPosition
				var_309_5.localScale = Vector3.New(1, 1, 1)

				arg_306_1:CheckSpriteTmpPos("1034", 2)

				for iter_309_8 = 0, var_309_5.childCount - 1 do
					local var_309_6 = var_309_5:GetChild(iter_309_8)

					if var_309_6.name == "split_6" or not string.find(var_309_6.name, "split") then
						var_309_6.gameObject:SetActive(true)
					else
						var_309_6.gameObject:SetActive(false)
					end
				end
			end

			local var_309_7 = 0.001

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_7 then
				var_309_5.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_306_1.time_ - 0) / var_309_7)
			end

			if arg_306_1.time_ >= 0 + var_309_7 and arg_306_1.time_ < 0 + var_309_7 + arg_309_0 then
				var_309_5.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_309_8 = 0
			local var_309_9 = 0.5

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_8 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_10 = arg_306_1:GetWordFromCfg(417261074)
				local var_309_11 = arg_306_1:FormatText(var_309_10.content)

				arg_306_1.text_.text = var_309_11

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_13 = 20 <= 0 and var_309_9 or var_309_9 * (utf8.len(var_309_11) / 20)

				if (20 <= 0 and var_309_9 or var_309_9 * (utf8.len(var_309_11) / 20)) > 0 and var_309_9 < var_309_13 then
					arg_306_1.talkMaxDuration = var_309_13

					if var_309_13 + var_309_8 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_13 + var_309_8
					end
				end

				arg_306_1.text_.text = var_309_11
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261074", "story_v_out_417261.awb") ~= 0 then
					local var_309_14 = manager.audio:GetVoiceLength("story_v_out_417261", "417261074", "story_v_out_417261.awb") / 1000

					if var_309_14 + var_309_8 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_14 + var_309_8
					end

					if var_309_10.prefab_name ~= "" and arg_306_1.actors_[var_309_10.prefab_name] ~= nil then
						local var_309_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_10.prefab_name].transform, "story_v_out_417261", "417261074", "story_v_out_417261.awb")

						arg_306_1:RecordAudio("417261074", var_309_15)
						arg_306_1:RecordAudio("417261074", var_309_15)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_417261", "417261074", "story_v_out_417261.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_417261", "417261074", "story_v_out_417261.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_16 = math.max(var_309_9, arg_306_1.talkMaxDuration)

			if var_309_8 <= arg_306_1.time_ and arg_306_1.time_ < var_309_8 + var_309_16 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_8) / var_309_16

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_8 + var_309_16 and arg_306_1.time_ < var_309_8 + var_309_16 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_306_1:InitPlayNodeList()
	end,
	Play417261075 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 417261075
		arg_310_1.duration_ = 2.3

		local var_310_0 = {
			zh = 2.1,
			ja = 2.3
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
				arg_310_0:Play417261076(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(arg_310_1.actors_["1034"]) and arg_310_1.var_.actorSpriteComps1034 == nil then
				arg_310_1.var_.actorSpriteComps1034 = arg_310_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_313_0 = 0.2

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_0 and not isNil(arg_310_1.actors_["1034"]) then
				if arg_310_1.var_.actorSpriteComps1034 then
					for iter_313_0, iter_313_1 in pairs(arg_310_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_313_1 then
							if arg_310_1.isInRecall_ then
								iter_313_1.color = Color.New(Mathf.Lerp(iter_313_1.color.r, arg_310_1.hightColor2.r, (arg_310_1.time_ - 0) / var_313_0), Mathf.Lerp(iter_313_1.color.g, arg_310_1.hightColor2.g, (arg_310_1.time_ - 0) / var_313_0), (Mathf.Lerp(iter_313_1.color.b, arg_310_1.hightColor2.b, (arg_310_1.time_ - 0) / var_313_0)))
							else
								local var_313_1 = Mathf.Lerp(iter_313_1.color.r, 0.5, (arg_310_1.time_ - 0) / var_313_0)

								iter_313_1.color = Color.New(var_313_1, var_313_1, var_313_1)
							end
						end
					end
				end
			end

			if arg_310_1.time_ >= 0 + var_313_0 and arg_310_1.time_ < 0 + var_313_0 + arg_313_0 and not isNil(arg_310_1.actors_["1034"]) and arg_310_1.var_.actorSpriteComps1034 then
				for iter_313_2, iter_313_3 in pairs(arg_310_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_313_3 then
						iter_313_3.color = arg_310_1.isInRecall_ and (arg_310_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_310_1.var_.actorSpriteComps1034 = nil
			end

			local var_313_2 = arg_310_1.actors_["10128"]

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(var_313_2) and arg_310_1.var_.actorSpriteComps10128 == nil then
				arg_310_1.var_.actorSpriteComps10128 = var_313_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_313_3 = 0.2

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_3 and not isNil(var_313_2) then
				if arg_310_1.var_.actorSpriteComps10128 then
					for iter_313_4, iter_313_5 in pairs(arg_310_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_313_5 then
							if arg_310_1.isInRecall_ then
								iter_313_5.color = Color.New(Mathf.Lerp(iter_313_5.color.r, arg_310_1.hightColor1.r, (arg_310_1.time_ - 0) / var_313_3), Mathf.Lerp(iter_313_5.color.g, arg_310_1.hightColor1.g, (arg_310_1.time_ - 0) / var_313_3), (Mathf.Lerp(iter_313_5.color.b, arg_310_1.hightColor1.b, (arg_310_1.time_ - 0) / var_313_3)))
							else
								local var_313_4 = Mathf.Lerp(iter_313_5.color.r, 1, (arg_310_1.time_ - 0) / var_313_3)

								iter_313_5.color = Color.New(var_313_4, var_313_4, var_313_4)
							end
						end
					end
				end
			end

			if arg_310_1.time_ >= 0 + var_313_3 and arg_310_1.time_ < 0 + var_313_3 + arg_313_0 and not isNil(var_313_2) and arg_310_1.var_.actorSpriteComps10128 then
				for iter_313_6, iter_313_7 in pairs(arg_310_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_313_7 then
						iter_313_7.color = arg_310_1.isInRecall_ and (arg_310_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_310_1.var_.actorSpriteComps10128 = nil
			end

			local var_313_5 = 0
			local var_313_6 = 0.25

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_5 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_7 = arg_310_1:GetWordFromCfg(417261075)
				local var_313_8 = arg_310_1:FormatText(var_313_7.content)

				arg_310_1.text_.text = var_313_8

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_10 = 10 <= 0 and var_313_6 or var_313_6 * (utf8.len(var_313_8) / 10)

				if (10 <= 0 and var_313_6 or var_313_6 * (utf8.len(var_313_8) / 10)) > 0 and var_313_6 < var_313_10 then
					arg_310_1.talkMaxDuration = var_313_10

					if var_313_10 + var_313_5 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_10 + var_313_5
					end
				end

				arg_310_1.text_.text = var_313_8
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261075", "story_v_out_417261.awb") ~= 0 then
					local var_313_11 = manager.audio:GetVoiceLength("story_v_out_417261", "417261075", "story_v_out_417261.awb") / 1000

					if var_313_11 + var_313_5 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_11 + var_313_5
					end

					if var_313_7.prefab_name ~= "" and arg_310_1.actors_[var_313_7.prefab_name] ~= nil then
						local var_313_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_7.prefab_name].transform, "story_v_out_417261", "417261075", "story_v_out_417261.awb")

						arg_310_1:RecordAudio("417261075", var_313_12)
						arg_310_1:RecordAudio("417261075", var_313_12)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_417261", "417261075", "story_v_out_417261.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_417261", "417261075", "story_v_out_417261.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_13 = math.max(var_313_6, arg_310_1.talkMaxDuration)

			if var_313_5 <= arg_310_1.time_ and arg_310_1.time_ < var_313_5 + var_313_13 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_5) / var_313_13

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_5 + var_313_13 and arg_310_1.time_ < var_313_5 + var_313_13 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play417261076 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 417261076
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play417261077(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(arg_314_1.actors_["1034"]) and arg_314_1.var_.actorSpriteComps1034 == nil then
				arg_314_1.var_.actorSpriteComps1034 = arg_314_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_317_0 = 0.2

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_0 and not isNil(arg_314_1.actors_["1034"]) then
				if arg_314_1.var_.actorSpriteComps1034 then
					for iter_317_0, iter_317_1 in pairs(arg_314_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_317_1 then
							if arg_314_1.isInRecall_ then
								iter_317_1.color = Color.New(Mathf.Lerp(iter_317_1.color.r, arg_314_1.hightColor2.r, (arg_314_1.time_ - 0) / var_317_0), Mathf.Lerp(iter_317_1.color.g, arg_314_1.hightColor2.g, (arg_314_1.time_ - 0) / var_317_0), (Mathf.Lerp(iter_317_1.color.b, arg_314_1.hightColor2.b, (arg_314_1.time_ - 0) / var_317_0)))
							else
								local var_317_1 = Mathf.Lerp(iter_317_1.color.r, 0.5, (arg_314_1.time_ - 0) / var_317_0)

								iter_317_1.color = Color.New(var_317_1, var_317_1, var_317_1)
							end
						end
					end
				end
			end

			if arg_314_1.time_ >= 0 + var_317_0 and arg_314_1.time_ < 0 + var_317_0 + arg_317_0 and not isNil(arg_314_1.actors_["1034"]) and arg_314_1.var_.actorSpriteComps1034 then
				for iter_317_2, iter_317_3 in pairs(arg_314_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_317_3 then
						iter_317_3.color = arg_314_1.isInRecall_ and (arg_314_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_314_1.var_.actorSpriteComps1034 = nil
			end

			local var_317_2 = arg_314_1.actors_["10128"]

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(var_317_2) and arg_314_1.var_.actorSpriteComps10128 == nil then
				arg_314_1.var_.actorSpriteComps10128 = var_317_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_317_3 = 0.2

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_3 and not isNil(var_317_2) then
				if arg_314_1.var_.actorSpriteComps10128 then
					for iter_317_4, iter_317_5 in pairs(arg_314_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_317_5 then
							if arg_314_1.isInRecall_ then
								iter_317_5.color = Color.New(Mathf.Lerp(iter_317_5.color.r, arg_314_1.hightColor2.r, (arg_314_1.time_ - 0) / var_317_3), Mathf.Lerp(iter_317_5.color.g, arg_314_1.hightColor2.g, (arg_314_1.time_ - 0) / var_317_3), (Mathf.Lerp(iter_317_5.color.b, arg_314_1.hightColor2.b, (arg_314_1.time_ - 0) / var_317_3)))
							else
								local var_317_4 = Mathf.Lerp(iter_317_5.color.r, 0.5, (arg_314_1.time_ - 0) / var_317_3)

								iter_317_5.color = Color.New(var_317_4, var_317_4, var_317_4)
							end
						end
					end
				end
			end

			if arg_314_1.time_ >= 0 + var_317_3 and arg_314_1.time_ < 0 + var_317_3 + arg_317_0 and not isNil(var_317_2) and arg_314_1.var_.actorSpriteComps10128 then
				for iter_317_6, iter_317_7 in pairs(arg_314_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_317_7 then
						iter_317_7.color = arg_314_1.isInRecall_ and (arg_314_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_314_1.var_.actorSpriteComps10128 = nil
			end

			local var_317_5 = 0
			local var_317_6 = 1.45

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_5 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, false)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_7 = arg_314_1:FormatText(arg_314_1:GetWordFromCfg(417261076).content)

				arg_314_1.text_.text = var_317_7

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_9 = 58 <= 0 and var_317_6 or var_317_6 * (utf8.len(var_317_7) / 58)

				if (58 <= 0 and var_317_6 or var_317_6 * (utf8.len(var_317_7) / 58)) > 0 and var_317_6 < var_317_9 then
					arg_314_1.talkMaxDuration = var_317_9

					if var_317_9 + var_317_5 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_9 + var_317_5
					end
				end

				arg_314_1.text_.text = var_317_7
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_10 = math.max(var_317_6, arg_314_1.talkMaxDuration)

			if var_317_5 <= arg_314_1.time_ and arg_314_1.time_ < var_317_5 + var_317_10 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_5) / var_317_10

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_5 + var_317_10 and arg_314_1.time_ < var_317_5 + var_317_10 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play417261077 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 417261077
		arg_318_1.duration_ = 9.6

		local var_318_0 = {
			zh = 6.5,
			ja = 9.6
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
				arg_318_0:Play417261078(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(arg_318_1.actors_["1034"]) and arg_318_1.var_.actorSpriteComps1034 == nil then
				arg_318_1.var_.actorSpriteComps1034 = arg_318_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_321_0 = 0.2

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_0 and not isNil(arg_318_1.actors_["1034"]) then
				if arg_318_1.var_.actorSpriteComps1034 then
					for iter_321_0, iter_321_1 in pairs(arg_318_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_321_1 then
							if arg_318_1.isInRecall_ then
								iter_321_1.color = Color.New(Mathf.Lerp(iter_321_1.color.r, arg_318_1.hightColor2.r, (arg_318_1.time_ - 0) / var_321_0), Mathf.Lerp(iter_321_1.color.g, arg_318_1.hightColor2.g, (arg_318_1.time_ - 0) / var_321_0), (Mathf.Lerp(iter_321_1.color.b, arg_318_1.hightColor2.b, (arg_318_1.time_ - 0) / var_321_0)))
							else
								local var_321_1 = Mathf.Lerp(iter_321_1.color.r, 0.5, (arg_318_1.time_ - 0) / var_321_0)

								iter_321_1.color = Color.New(var_321_1, var_321_1, var_321_1)
							end
						end
					end
				end
			end

			if arg_318_1.time_ >= 0 + var_321_0 and arg_318_1.time_ < 0 + var_321_0 + arg_321_0 and not isNil(arg_318_1.actors_["1034"]) and arg_318_1.var_.actorSpriteComps1034 then
				for iter_321_2, iter_321_3 in pairs(arg_318_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_321_3 then
						iter_321_3.color = arg_318_1.isInRecall_ and (arg_318_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_318_1.var_.actorSpriteComps1034 = nil
			end

			local var_321_2 = arg_318_1.actors_["10128"]

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(var_321_2) and arg_318_1.var_.actorSpriteComps10128 == nil then
				arg_318_1.var_.actorSpriteComps10128 = var_321_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_321_3 = 0.2

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_3 and not isNil(var_321_2) then
				if arg_318_1.var_.actorSpriteComps10128 then
					for iter_321_4, iter_321_5 in pairs(arg_318_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_321_5 then
							if arg_318_1.isInRecall_ then
								iter_321_5.color = Color.New(Mathf.Lerp(iter_321_5.color.r, arg_318_1.hightColor1.r, (arg_318_1.time_ - 0) / var_321_3), Mathf.Lerp(iter_321_5.color.g, arg_318_1.hightColor1.g, (arg_318_1.time_ - 0) / var_321_3), (Mathf.Lerp(iter_321_5.color.b, arg_318_1.hightColor1.b, (arg_318_1.time_ - 0) / var_321_3)))
							else
								local var_321_4 = Mathf.Lerp(iter_321_5.color.r, 1, (arg_318_1.time_ - 0) / var_321_3)

								iter_321_5.color = Color.New(var_321_4, var_321_4, var_321_4)
							end
						end
					end
				end
			end

			if arg_318_1.time_ >= 0 + var_321_3 and arg_318_1.time_ < 0 + var_321_3 + arg_321_0 and not isNil(var_321_2) and arg_318_1.var_.actorSpriteComps10128 then
				for iter_321_6, iter_321_7 in pairs(arg_318_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_321_7 then
						iter_321_7.color = arg_318_1.isInRecall_ and (arg_318_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_318_1.var_.actorSpriteComps10128 = nil
			end

			local var_321_5 = 0
			local var_321_6 = 0.9

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_5 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_7 = arg_318_1:GetWordFromCfg(417261077)
				local var_321_8 = arg_318_1:FormatText(var_321_7.content)

				arg_318_1.text_.text = var_321_8

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_10 = 36 <= 0 and var_321_6 or var_321_6 * (utf8.len(var_321_8) / 36)

				if (36 <= 0 and var_321_6 or var_321_6 * (utf8.len(var_321_8) / 36)) > 0 and var_321_6 < var_321_10 then
					arg_318_1.talkMaxDuration = var_321_10

					if var_321_10 + var_321_5 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_10 + var_321_5
					end
				end

				arg_318_1.text_.text = var_321_8
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261077", "story_v_out_417261.awb") ~= 0 then
					local var_321_11 = manager.audio:GetVoiceLength("story_v_out_417261", "417261077", "story_v_out_417261.awb") / 1000

					if var_321_11 + var_321_5 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_11 + var_321_5
					end

					if var_321_7.prefab_name ~= "" and arg_318_1.actors_[var_321_7.prefab_name] ~= nil then
						local var_321_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_7.prefab_name].transform, "story_v_out_417261", "417261077", "story_v_out_417261.awb")

						arg_318_1:RecordAudio("417261077", var_321_12)
						arg_318_1:RecordAudio("417261077", var_321_12)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_417261", "417261077", "story_v_out_417261.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_417261", "417261077", "story_v_out_417261.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_13 = math.max(var_321_6, arg_318_1.talkMaxDuration)

			if var_321_5 <= arg_318_1.time_ and arg_318_1.time_ < var_321_5 + var_321_13 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_5) / var_321_13

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_5 + var_321_13 and arg_318_1.time_ < var_321_5 + var_321_13 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play417261078 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 417261078
		arg_322_1.duration_ = 11.2

		local var_322_0 = {
			zh = 7.4,
			ja = 11.2
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
				arg_322_0:Play417261079(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 0.9

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_1 = arg_322_1:GetWordFromCfg(417261078)
				local var_325_2 = arg_322_1:FormatText(var_325_1.content)

				arg_322_1.text_.text = var_325_2

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_4 = 36 <= 0 and var_325_0 or var_325_0 * (utf8.len(var_325_2) / 36)

				if (36 <= 0 and var_325_0 or var_325_0 * (utf8.len(var_325_2) / 36)) > 0 and var_325_0 < var_325_4 then
					arg_322_1.talkMaxDuration = var_325_4

					if var_325_4 + 0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_4 + 0
					end
				end

				arg_322_1.text_.text = var_325_2
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261078", "story_v_out_417261.awb") ~= 0 then
					local var_325_5 = manager.audio:GetVoiceLength("story_v_out_417261", "417261078", "story_v_out_417261.awb") / 1000

					if var_325_5 + 0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_5 + 0
					end

					if var_325_1.prefab_name ~= "" and arg_322_1.actors_[var_325_1.prefab_name] ~= nil then
						local var_325_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_1.prefab_name].transform, "story_v_out_417261", "417261078", "story_v_out_417261.awb")

						arg_322_1:RecordAudio("417261078", var_325_6)
						arg_322_1:RecordAudio("417261078", var_325_6)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_417261", "417261078", "story_v_out_417261.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_417261", "417261078", "story_v_out_417261.awb")
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
	Play417261079 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 417261079
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play417261080(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.var_.moveOldPos1034 = arg_326_1.actors_["1034"].transform.localPosition
				arg_326_1.actors_["1034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_326_1:CheckSpriteTmpPos("1034", 7)

				for iter_329_0 = 0, arg_326_1.actors_["1034"].transform.childCount - 1 do
					local var_329_0 = arg_326_1.actors_["1034"].transform:GetChild(iter_329_0)

					if var_329_0.name == "" or not string.find(var_329_0.name, "split") then
						var_329_0.gameObject:SetActive(true)
					else
						var_329_0.gameObject:SetActive(false)
					end
				end
			end

			local var_329_1 = 0.001

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_1 then
				arg_326_1.actors_["1034"].transform.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_326_1.time_ - 0) / var_329_1)
			end

			if arg_326_1.time_ >= 0 + var_329_1 and arg_326_1.time_ < 0 + var_329_1 + arg_329_0 then
				arg_326_1.actors_["1034"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_329_2 = arg_326_1.actors_["10128"].transform

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.var_.moveOldPos10128 = var_329_2.localPosition
				var_329_2.localScale = Vector3.New(1, 1, 1)

				arg_326_1:CheckSpriteTmpPos("10128", 7)

				for iter_329_1 = 0, var_329_2.childCount - 1 do
					local var_329_3 = var_329_2:GetChild(iter_329_1)

					if var_329_3.name == "" or not string.find(var_329_3.name, "split") then
						var_329_3.gameObject:SetActive(true)
					else
						var_329_3.gameObject:SetActive(false)
					end
				end
			end

			local var_329_4 = 0.001

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_4 then
				var_329_2.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_326_1.time_ - 0) / var_329_4)
			end

			if arg_326_1.time_ >= 0 + var_329_4 and arg_326_1.time_ < 0 + var_329_4 + arg_329_0 then
				var_329_2.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_329_5 = 0
			local var_329_6 = 0.85

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_5 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, false)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_7 = arg_326_1:FormatText(arg_326_1:GetWordFromCfg(417261079).content)

				arg_326_1.text_.text = var_329_7

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_9 = 34 <= 0 and var_329_6 or var_329_6 * (utf8.len(var_329_7) / 34)

				if (34 <= 0 and var_329_6 or var_329_6 * (utf8.len(var_329_7) / 34)) > 0 and var_329_6 < var_329_9 then
					arg_326_1.talkMaxDuration = var_329_9

					if var_329_9 + var_329_5 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_9 + var_329_5
					end
				end

				arg_326_1.text_.text = var_329_7
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_10 = math.max(var_329_6, arg_326_1.talkMaxDuration)

			if var_329_5 <= arg_326_1.time_ and arg_326_1.time_ < var_329_5 + var_329_10 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_5) / var_329_10

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_5 + var_329_10 and arg_326_1.time_ < var_329_5 + var_329_10 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_326_1:InitPlayNodeList()
	end,
	Play417261080 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 417261080
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play417261081(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 1.475

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

				local var_333_1 = arg_330_1:FormatText(arg_330_1:GetWordFromCfg(417261080).content)

				arg_330_1.text_.text = var_333_1

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_3 = 59 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_1) / 59)

				if (59 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_1) / 59)) > 0 and var_333_0 < var_333_3 then
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
	Play417261081 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 417261081
		arg_334_1.duration_ = 9.77

		local var_334_0 = {
			zh = 4.033,
			ja = 9.766
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
				arg_334_0:Play417261082(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(arg_334_1.actors_["10128"]) and arg_334_1.var_.actorSpriteComps10128 == nil then
				arg_334_1.var_.actorSpriteComps10128 = arg_334_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_337_0 = 0.2

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_0 and not isNil(arg_334_1.actors_["10128"]) then
				if arg_334_1.var_.actorSpriteComps10128 then
					for iter_337_0, iter_337_1 in pairs(arg_334_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_337_1 then
							if arg_334_1.isInRecall_ then
								iter_337_1.color = Color.New(Mathf.Lerp(iter_337_1.color.r, arg_334_1.hightColor1.r, (arg_334_1.time_ - 0) / var_337_0), Mathf.Lerp(iter_337_1.color.g, arg_334_1.hightColor1.g, (arg_334_1.time_ - 0) / var_337_0), (Mathf.Lerp(iter_337_1.color.b, arg_334_1.hightColor1.b, (arg_334_1.time_ - 0) / var_337_0)))
							else
								local var_337_1 = Mathf.Lerp(iter_337_1.color.r, 1, (arg_334_1.time_ - 0) / var_337_0)

								iter_337_1.color = Color.New(var_337_1, var_337_1, var_337_1)
							end
						end
					end
				end
			end

			if arg_334_1.time_ >= 0 + var_337_0 and arg_334_1.time_ < 0 + var_337_0 + arg_337_0 and not isNil(arg_334_1.actors_["10128"]) and arg_334_1.var_.actorSpriteComps10128 then
				for iter_337_2, iter_337_3 in pairs(arg_334_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_337_3 then
						iter_337_3.color = arg_334_1.isInRecall_ and (arg_334_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_334_1.var_.actorSpriteComps10128 = nil
			end

			local var_337_2 = arg_334_1.actors_["10128"].transform

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.var_.moveOldPos10128 = var_337_2.localPosition
				var_337_2.localScale = Vector3.New(1, 1, 1)

				arg_334_1:CheckSpriteTmpPos("10128", 3)

				for iter_337_4 = 0, var_337_2.childCount - 1 do
					local var_337_3 = var_337_2:GetChild(iter_337_4)

					if var_337_3.name == "" or not string.find(var_337_3.name, "split") then
						var_337_3.gameObject:SetActive(true)
					else
						var_337_3.gameObject:SetActive(false)
					end
				end
			end

			local var_337_4 = 0.001

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_4 then
				var_337_2.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_334_1.time_ - 0) / var_337_4)
			end

			if arg_334_1.time_ >= 0 + var_337_4 and arg_334_1.time_ < 0 + var_337_4 + arg_337_0 then
				var_337_2.localPosition = Vector3.New(0, -347, -300)
			end

			local var_337_5 = 0
			local var_337_6 = 0.6

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_5 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_7 = arg_334_1:GetWordFromCfg(417261081)
				local var_337_8 = arg_334_1:FormatText(var_337_7.content)

				arg_334_1.text_.text = var_337_8

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_10 = 24 <= 0 and var_337_6 or var_337_6 * (utf8.len(var_337_8) / 24)

				if (24 <= 0 and var_337_6 or var_337_6 * (utf8.len(var_337_8) / 24)) > 0 and var_337_6 < var_337_10 then
					arg_334_1.talkMaxDuration = var_337_10

					if var_337_10 + var_337_5 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_10 + var_337_5
					end
				end

				arg_334_1.text_.text = var_337_8
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261081", "story_v_out_417261.awb") ~= 0 then
					local var_337_11 = manager.audio:GetVoiceLength("story_v_out_417261", "417261081", "story_v_out_417261.awb") / 1000

					if var_337_11 + var_337_5 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_11 + var_337_5
					end

					if var_337_7.prefab_name ~= "" and arg_334_1.actors_[var_337_7.prefab_name] ~= nil then
						local var_337_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_7.prefab_name].transform, "story_v_out_417261", "417261081", "story_v_out_417261.awb")

						arg_334_1:RecordAudio("417261081", var_337_12)
						arg_334_1:RecordAudio("417261081", var_337_12)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_417261", "417261081", "story_v_out_417261.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_417261", "417261081", "story_v_out_417261.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_13 = math.max(var_337_6, arg_334_1.talkMaxDuration)

			if var_337_5 <= arg_334_1.time_ and arg_334_1.time_ < var_337_5 + var_337_13 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_5) / var_337_13

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_5 + var_337_13 and arg_334_1.time_ < var_337_5 + var_337_13 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_334_1:InitPlayNodeList()
	end,
	Play417261082 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 417261082
		arg_338_1.duration_ = 1.67

		local var_338_0 = {
			zh = 1.366,
			ja = 1.666
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
				arg_338_0:Play417261083(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(arg_338_1.actors_["1034"]) and arg_338_1.var_.actorSpriteComps1034 == nil then
				arg_338_1.var_.actorSpriteComps1034 = arg_338_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_341_0 = 0.2

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_0 and not isNil(arg_338_1.actors_["1034"]) then
				if arg_338_1.var_.actorSpriteComps1034 then
					for iter_341_0, iter_341_1 in pairs(arg_338_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_341_1 then
							if arg_338_1.isInRecall_ then
								iter_341_1.color = Color.New(Mathf.Lerp(iter_341_1.color.r, arg_338_1.hightColor1.r, (arg_338_1.time_ - 0) / var_341_0), Mathf.Lerp(iter_341_1.color.g, arg_338_1.hightColor1.g, (arg_338_1.time_ - 0) / var_341_0), (Mathf.Lerp(iter_341_1.color.b, arg_338_1.hightColor1.b, (arg_338_1.time_ - 0) / var_341_0)))
							else
								local var_341_1 = Mathf.Lerp(iter_341_1.color.r, 1, (arg_338_1.time_ - 0) / var_341_0)

								iter_341_1.color = Color.New(var_341_1, var_341_1, var_341_1)
							end
						end
					end
				end
			end

			if arg_338_1.time_ >= 0 + var_341_0 and arg_338_1.time_ < 0 + var_341_0 + arg_341_0 and not isNil(arg_338_1.actors_["1034"]) and arg_338_1.var_.actorSpriteComps1034 then
				for iter_341_2, iter_341_3 in pairs(arg_338_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_341_3 then
						iter_341_3.color = arg_338_1.isInRecall_ and (arg_338_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_338_1.var_.actorSpriteComps1034 = nil
			end

			local var_341_2 = arg_338_1.actors_["1034"].transform

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.var_.moveOldPos1034 = var_341_2.localPosition
				var_341_2.localScale = Vector3.New(1, 1, 1)

				arg_338_1:CheckSpriteTmpPos("1034", 3)

				for iter_341_4 = 0, var_341_2.childCount - 1 do
					local var_341_3 = var_341_2:GetChild(iter_341_4)

					if var_341_3.name == "split_1" or not string.find(var_341_3.name, "split") then
						var_341_3.gameObject:SetActive(true)
					else
						var_341_3.gameObject:SetActive(false)
					end
				end
			end

			local var_341_4 = 0.001

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_4 then
				var_341_2.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_338_1.time_ - 0) / var_341_4)
			end

			if arg_338_1.time_ >= 0 + var_341_4 and arg_338_1.time_ < 0 + var_341_4 + arg_341_0 then
				var_341_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_341_5 = arg_338_1.actors_["10128"].transform

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.var_.moveOldPos10128 = var_341_5.localPosition
				var_341_5.localScale = Vector3.New(1, 1, 1)

				arg_338_1:CheckSpriteTmpPos("10128", 7)

				for iter_341_5 = 0, var_341_5.childCount - 1 do
					local var_341_6 = var_341_5:GetChild(iter_341_5)

					if var_341_6.name == "" or not string.find(var_341_6.name, "split") then
						var_341_6.gameObject:SetActive(true)
					else
						var_341_6.gameObject:SetActive(false)
					end
				end
			end

			local var_341_7 = 0.001

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_7 then
				var_341_5.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_338_1.time_ - 0) / var_341_7)
			end

			if arg_338_1.time_ >= 0 + var_341_7 and arg_338_1.time_ < 0 + var_341_7 + arg_341_0 then
				var_341_5.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_341_8 = 0
			local var_341_9 = 0.125

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_8 + arg_341_0 then
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

				local var_341_10 = arg_338_1:GetWordFromCfg(417261082)
				local var_341_11 = arg_338_1:FormatText(var_341_10.content)

				arg_338_1.text_.text = var_341_11

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_13 = 5 <= 0 and var_341_9 or var_341_9 * (utf8.len(var_341_11) / 5)

				if (5 <= 0 and var_341_9 or var_341_9 * (utf8.len(var_341_11) / 5)) > 0 and var_341_9 < var_341_13 then
					arg_338_1.talkMaxDuration = var_341_13

					if var_341_13 + var_341_8 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_13 + var_341_8
					end
				end

				arg_338_1.text_.text = var_341_11
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261082", "story_v_out_417261.awb") ~= 0 then
					local var_341_14 = manager.audio:GetVoiceLength("story_v_out_417261", "417261082", "story_v_out_417261.awb") / 1000

					if var_341_14 + var_341_8 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_14 + var_341_8
					end

					if var_341_10.prefab_name ~= "" and arg_338_1.actors_[var_341_10.prefab_name] ~= nil then
						local var_341_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_10.prefab_name].transform, "story_v_out_417261", "417261082", "story_v_out_417261.awb")

						arg_338_1:RecordAudio("417261082", var_341_15)
						arg_338_1:RecordAudio("417261082", var_341_15)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_417261", "417261082", "story_v_out_417261.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_417261", "417261082", "story_v_out_417261.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_16 = math.max(var_341_9, arg_338_1.talkMaxDuration)

			if var_341_8 <= arg_338_1.time_ and arg_338_1.time_ < var_341_8 + var_341_16 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_8) / var_341_16

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_8 + var_341_16 and arg_338_1.time_ < var_341_8 + var_341_16 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_338_1:InitPlayNodeList()
	end,
	Play417261083 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 417261083
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play417261084(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(arg_342_1.actors_["1034"]) and arg_342_1.var_.actorSpriteComps1034 == nil then
				arg_342_1.var_.actorSpriteComps1034 = arg_342_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_345_0 = 0.2

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_0 and not isNil(arg_342_1.actors_["1034"]) then
				if arg_342_1.var_.actorSpriteComps1034 then
					for iter_345_0, iter_345_1 in pairs(arg_342_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_345_1 then
							if arg_342_1.isInRecall_ then
								iter_345_1.color = Color.New(Mathf.Lerp(iter_345_1.color.r, arg_342_1.hightColor2.r, (arg_342_1.time_ - 0) / var_345_0), Mathf.Lerp(iter_345_1.color.g, arg_342_1.hightColor2.g, (arg_342_1.time_ - 0) / var_345_0), (Mathf.Lerp(iter_345_1.color.b, arg_342_1.hightColor2.b, (arg_342_1.time_ - 0) / var_345_0)))
							else
								local var_345_1 = Mathf.Lerp(iter_345_1.color.r, 0.5, (arg_342_1.time_ - 0) / var_345_0)

								iter_345_1.color = Color.New(var_345_1, var_345_1, var_345_1)
							end
						end
					end
				end
			end

			if arg_342_1.time_ >= 0 + var_345_0 and arg_342_1.time_ < 0 + var_345_0 + arg_345_0 and not isNil(arg_342_1.actors_["1034"]) and arg_342_1.var_.actorSpriteComps1034 then
				for iter_345_2, iter_345_3 in pairs(arg_342_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_345_3 then
						iter_345_3.color = arg_342_1.isInRecall_ and (arg_342_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_342_1.var_.actorSpriteComps1034 = nil
			end

			if 0.02 < arg_342_1.time_ and arg_342_1.time_ <= 0.02 + arg_345_0 then
				arg_342_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_cardoor01", "")
			end

			local var_345_3 = 0
			local var_345_4 = 0.75

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_3 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, false)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_5 = arg_342_1:FormatText(arg_342_1:GetWordFromCfg(417261083).content)

				arg_342_1.text_.text = var_345_5

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_7 = 30 <= 0 and var_345_4 or var_345_4 * (utf8.len(var_345_5) / 30)

				if (30 <= 0 and var_345_4 or var_345_4 * (utf8.len(var_345_5) / 30)) > 0 and var_345_4 < var_345_7 then
					arg_342_1.talkMaxDuration = var_345_7

					if var_345_7 + var_345_3 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_7 + var_345_3
					end
				end

				arg_342_1.text_.text = var_345_5
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_8 = math.max(var_345_4, arg_342_1.talkMaxDuration)

			if var_345_3 <= arg_342_1.time_ and arg_342_1.time_ < var_345_3 + var_345_8 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_3) / var_345_8

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_3 + var_345_8 and arg_342_1.time_ < var_345_3 + var_345_8 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play417261084 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 417261084
		arg_346_1.duration_ = 6.93

		local var_346_0 = {
			zh = 3.466,
			ja = 6.933
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
				arg_346_0:Play417261085(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(arg_346_1.actors_["1034"]) and arg_346_1.var_.actorSpriteComps1034 == nil then
				arg_346_1.var_.actorSpriteComps1034 = arg_346_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_349_0 = 0.2

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_0 and not isNil(arg_346_1.actors_["1034"]) then
				if arg_346_1.var_.actorSpriteComps1034 then
					for iter_349_0, iter_349_1 in pairs(arg_346_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_349_1 then
							if arg_346_1.isInRecall_ then
								iter_349_1.color = Color.New(Mathf.Lerp(iter_349_1.color.r, arg_346_1.hightColor1.r, (arg_346_1.time_ - 0) / var_349_0), Mathf.Lerp(iter_349_1.color.g, arg_346_1.hightColor1.g, (arg_346_1.time_ - 0) / var_349_0), (Mathf.Lerp(iter_349_1.color.b, arg_346_1.hightColor1.b, (arg_346_1.time_ - 0) / var_349_0)))
							else
								local var_349_1 = Mathf.Lerp(iter_349_1.color.r, 1, (arg_346_1.time_ - 0) / var_349_0)

								iter_349_1.color = Color.New(var_349_1, var_349_1, var_349_1)
							end
						end
					end
				end
			end

			if arg_346_1.time_ >= 0 + var_349_0 and arg_346_1.time_ < 0 + var_349_0 + arg_349_0 and not isNil(arg_346_1.actors_["1034"]) and arg_346_1.var_.actorSpriteComps1034 then
				for iter_349_2, iter_349_3 in pairs(arg_346_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_349_3 then
						iter_349_3.color = arg_346_1.isInRecall_ and (arg_346_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_346_1.var_.actorSpriteComps1034 = nil
			end

			local var_349_2 = arg_346_1.actors_["1034"].transform

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.var_.moveOldPos1034 = var_349_2.localPosition
				var_349_2.localScale = Vector3.New(1, 1, 1)

				arg_346_1:CheckSpriteTmpPos("1034", 3)

				for iter_349_4 = 0, var_349_2.childCount - 1 do
					local var_349_3 = var_349_2:GetChild(iter_349_4)

					if var_349_3.name == "" or not string.find(var_349_3.name, "split") then
						var_349_3.gameObject:SetActive(true)
					else
						var_349_3.gameObject:SetActive(false)
					end
				end
			end

			local var_349_4 = 0.001

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_4 then
				var_349_2.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_346_1.time_ - 0) / var_349_4)
			end

			if arg_346_1.time_ >= 0 + var_349_4 and arg_346_1.time_ < 0 + var_349_4 + arg_349_0 then
				var_349_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_349_5 = 0
			local var_349_6 = 0.5

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_5 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_7 = arg_346_1:GetWordFromCfg(417261084)
				local var_349_8 = arg_346_1:FormatText(var_349_7.content)

				arg_346_1.text_.text = var_349_8

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_10 = 20 <= 0 and var_349_6 or var_349_6 * (utf8.len(var_349_8) / 20)

				if (20 <= 0 and var_349_6 or var_349_6 * (utf8.len(var_349_8) / 20)) > 0 and var_349_6 < var_349_10 then
					arg_346_1.talkMaxDuration = var_349_10

					if var_349_10 + var_349_5 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_10 + var_349_5
					end
				end

				arg_346_1.text_.text = var_349_8
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261084", "story_v_out_417261.awb") ~= 0 then
					local var_349_11 = manager.audio:GetVoiceLength("story_v_out_417261", "417261084", "story_v_out_417261.awb") / 1000

					if var_349_11 + var_349_5 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_11 + var_349_5
					end

					if var_349_7.prefab_name ~= "" and arg_346_1.actors_[var_349_7.prefab_name] ~= nil then
						local var_349_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_7.prefab_name].transform, "story_v_out_417261", "417261084", "story_v_out_417261.awb")

						arg_346_1:RecordAudio("417261084", var_349_12)
						arg_346_1:RecordAudio("417261084", var_349_12)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_417261", "417261084", "story_v_out_417261.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_417261", "417261084", "story_v_out_417261.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_13 = math.max(var_349_6, arg_346_1.talkMaxDuration)

			if var_349_5 <= arg_346_1.time_ and arg_346_1.time_ < var_349_5 + var_349_13 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_5) / var_349_13

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_5 + var_349_13 and arg_346_1.time_ < var_349_5 + var_349_13 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_346_1:InitPlayNodeList()
	end,
	Play417261085 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 417261085
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play417261086(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.var_.moveOldPos1034 = arg_350_1.actors_["1034"].transform.localPosition
				arg_350_1.actors_["1034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_350_1:CheckSpriteTmpPos("1034", 7)

				for iter_353_0 = 0, arg_350_1.actors_["1034"].transform.childCount - 1 do
					local var_353_0 = arg_350_1.actors_["1034"].transform:GetChild(iter_353_0)

					if var_353_0.name == "" or not string.find(var_353_0.name, "split") then
						var_353_0.gameObject:SetActive(true)
					else
						var_353_0.gameObject:SetActive(false)
					end
				end
			end

			local var_353_1 = 0.001

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_1 then
				arg_350_1.actors_["1034"].transform.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_350_1.time_ - 0) / var_353_1)
			end

			if arg_350_1.time_ >= 0 + var_353_1 and arg_350_1.time_ < 0 + var_353_1 + arg_353_0 then
				arg_350_1.actors_["1034"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.02 < arg_350_1.time_ and arg_350_1.time_ <= 0.02 + arg_353_0 then
				arg_350_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_car02", "")
			end

			local var_353_3 = 0
			local var_353_4 = 0.9

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_3 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, false)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_5 = arg_350_1:FormatText(arg_350_1:GetWordFromCfg(417261085).content)

				arg_350_1.text_.text = var_353_5

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_7 = 36 <= 0 and var_353_4 or var_353_4 * (utf8.len(var_353_5) / 36)

				if (36 <= 0 and var_353_4 or var_353_4 * (utf8.len(var_353_5) / 36)) > 0 and var_353_4 < var_353_7 then
					arg_350_1.talkMaxDuration = var_353_7

					if var_353_7 + var_353_3 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_7 + var_353_3
					end
				end

				arg_350_1.text_.text = var_353_5
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_8 = math.max(var_353_4, arg_350_1.talkMaxDuration)

			if var_353_3 <= arg_350_1.time_ and arg_350_1.time_ < var_353_3 + var_353_8 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_3) / var_353_8

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_3 + var_353_8 and arg_350_1.time_ < var_353_3 + var_353_8 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_350_1:InitPlayNodeList()
	end,
	Play417261086 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 417261086
		arg_354_1.duration_ = 4.17

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play417261087(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.mask_.enabled = true
				arg_354_1.mask_.raycastTarget = true

				arg_354_1:SetGaussion(false)
			end

			local var_357_0 = 1

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_0 then
				local var_357_1 = Color.New(0, 0, 0)

				var_357_1.a = Mathf.Lerp(0, 1, (arg_354_1.time_ - 0) / var_357_0)
				arg_354_1.mask_.color = var_357_1
			end

			if arg_354_1.time_ >= 0 + var_357_0 and arg_354_1.time_ < 0 + var_357_0 + arg_357_0 then
				local var_357_2 = Color.New(0, 0, 0)

				var_357_2.a = 1
				arg_354_1.mask_.color = var_357_2
			end

			local var_357_3 = 1

			if 1 < arg_354_1.time_ and arg_354_1.time_ <= var_357_3 + arg_357_0 then
				arg_354_1.mask_.enabled = true
				arg_354_1.mask_.raycastTarget = true

				arg_354_1:SetGaussion(false)
			end

			local var_357_4 = 1

			if var_357_3 <= arg_354_1.time_ and arg_354_1.time_ < var_357_3 + var_357_4 then
				local var_357_5 = Color.New(0, 0, 0)

				var_357_5.a = Mathf.Lerp(1, 0, (arg_354_1.time_ - var_357_3) / var_357_4)
				arg_354_1.mask_.color = var_357_5
			end

			if arg_354_1.time_ >= var_357_3 + var_357_4 and arg_354_1.time_ < var_357_3 + var_357_4 + arg_357_0 then
				local var_357_6 = Color.New(0, 0, 0)

				arg_354_1.mask_.enabled = false
				var_357_6.a = 0
				arg_354_1.mask_.color = var_357_6
			end

			if 1 < arg_354_1.time_ and arg_354_1.time_ <= 1 + arg_357_0 then
				local var_357_7 = arg_354_1.bgs_.STblack

				arg_354_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_357_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_357_8 = var_357_7:GetComponent("SpriteRenderer")

				if var_357_8 and var_357_8.sprite then
					local var_357_9 = 2 * (var_357_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_357_7.transform.localScale = Vector3.New(var_357_9 / var_357_8.sprite.bounds.size.y < var_357_9 * manager.ui.mainCameraCom_.aspect / var_357_8.sprite.bounds.size.x and var_357_9 * manager.ui.mainCameraCom_.aspect / var_357_8.sprite.bounds.size.x or var_357_9 / var_357_8.sprite.bounds.size.y, var_357_9 / var_357_8.sprite.bounds.size.y < var_357_9 * manager.ui.mainCameraCom_.aspect / var_357_8.sprite.bounds.size.x and var_357_9 * manager.ui.mainCameraCom_.aspect / var_357_8.sprite.bounds.size.x or var_357_9 / var_357_8.sprite.bounds.size.y, 0)
				end

				for iter_357_0, iter_357_1 in pairs(arg_354_1.bgs_) do
					if iter_357_0 ~= "STblack" then
						iter_357_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 1 < arg_354_1.time_ and arg_354_1.time_ <= 1 + arg_357_0 then
				arg_354_1.cswbg_:SetActive(true)

				local var_357_10 = arg_354_1.cswt_:GetComponent("RectTransform")

				arg_354_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_357_10.offsetMin = Vector2.New(0, 0)
				var_357_10.offsetMax = Vector2.New(0, 0)
				arg_354_1.cswt_.text = arg_354_1:FormatText(arg_354_1:GetWordFromCfg(419125).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.cswt_)

				arg_354_1.cswt_.fontSize = 120
				arg_354_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_354_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_354_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 1 < arg_354_1.time_ and arg_354_1.time_ <= 1 + arg_357_0 then
				local var_357_11 = arg_354_1.fswbg_.transform:Find("textbox/adapt/content") or arg_354_1.fswbg_.transform:Find("textbox/content")
				local var_357_12 = arg_354_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_357_13 = var_357_11:GetComponent("RectTransform")

				var_357_11:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_357_13.offsetMin = Vector2.New(0, 0)
				var_357_13.offsetMax = Vector2.New(0, 0)
			end

			if 1 < arg_354_1.time_ and arg_354_1.time_ <= 1 + arg_357_0 then
				arg_354_1.fswbg_:SetActive(true)
				arg_354_1.dialog_:SetActive(false)

				arg_354_1.fswtw_.percent = 0
				arg_354_1.fswt_.text = arg_354_1:FormatText(arg_354_1:GetWordFromCfg(417261086).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.fswt_)

				arg_354_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_354_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_354_1.fswtw_:SetDirty()

				arg_354_1.typewritterCharCountI18N = 0

				SetActive(arg_354_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_354_1:ShowNextGo(false)
			end

			local var_357_14 = 1.36666666666667

			if 1.36666666666667 < arg_354_1.time_ and arg_354_1.time_ <= var_357_14 + arg_357_0 then
				arg_354_1.var_.oldValueTypewriter = arg_354_1.fswtw_.percent

				SetActive(arg_354_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_354_1:ShowNextGo(false)
			end

			local var_357_15 = 30
			local var_357_16 = 2
			local var_357_17, var_357_18 = arg_354_1:GetPercentByPara(arg_354_1:FormatText(arg_354_1:GetWordFromCfg(417261086).content), 1)

			if var_357_14 < arg_354_1.time_ and arg_354_1.time_ <= var_357_14 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0

				local var_357_19 = var_357_15 <= 0 and var_357_16 or var_357_16 * ((var_357_18 - arg_354_1.typewritterCharCountI18N) / var_357_15)

				if (var_357_15 <= 0 and var_357_16 or var_357_16 * ((var_357_18 - arg_354_1.typewritterCharCountI18N) / var_357_15)) > 0 and var_357_16 < var_357_19 then
					arg_354_1.talkMaxDuration = var_357_19

					if var_357_19 + var_357_14 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_19 + var_357_14
					end
				end
			end

			local var_357_20 = math.max(2, arg_354_1.talkMaxDuration)

			if var_357_14 <= arg_354_1.time_ and arg_354_1.time_ < var_357_14 + var_357_20 then
				arg_354_1.fswtw_.percent = Mathf.Lerp(arg_354_1.var_.oldValueTypewriter, var_357_17, (arg_354_1.time_ - var_357_14) / var_357_20)
				arg_354_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_354_1.fswtw_:SetDirty()
			end

			if arg_354_1.time_ >= var_357_14 + var_357_20 and arg_354_1.time_ < var_357_14 + var_357_20 + arg_357_0 then
				arg_354_1.fswtw_.percent = var_357_17

				arg_354_1.fswtw_:SetDirty()
				arg_354_1:ShowNextGo(true)

				arg_354_1.typewritterCharCountI18N = var_357_18
			end

			if 2.36666666666667 < arg_354_1.time_ and arg_354_1.time_ <= 2.36666666666667 + arg_357_0 then
				arg_354_1:AudioAction("play", "effect", "se_story_side_1148", "se_story_1148_vibrate", "")
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play417261087 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 417261087
		arg_358_1.duration_ = 2.43

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play417261088(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.fswbg_:SetActive(true)
				arg_358_1.dialog_:SetActive(false)

				arg_358_1.fswtw_.percent = 0
				arg_358_1.fswt_.text = arg_358_1:FormatText(arg_358_1:GetWordFromCfg(417261087).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.fswt_)

				arg_358_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_358_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_358_1.fswtw_:SetDirty()

				arg_358_1.typewritterCharCountI18N = 0

				SetActive(arg_358_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_358_1:ShowNextGo(false)
			end

			local var_361_0 = 0.0999999999999999

			if 0.0999999999999999 < arg_358_1.time_ and arg_358_1.time_ <= var_361_0 + arg_361_0 then
				arg_358_1.var_.oldValueTypewriter = arg_358_1.fswtw_.percent

				SetActive(arg_358_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_358_1:ShowNextGo(false)
			end

			local var_361_1 = 35
			local var_361_2 = 2.33333333333333
			local var_361_3, var_361_4 = arg_358_1:GetPercentByPara(arg_358_1:FormatText(arg_358_1:GetWordFromCfg(417261087).content), 1)

			if var_361_0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_0 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0

				local var_361_5 = var_361_1 <= 0 and var_361_2 or var_361_2 * ((var_361_4 - arg_358_1.typewritterCharCountI18N) / var_361_1)

				if (var_361_1 <= 0 and var_361_2 or var_361_2 * ((var_361_4 - arg_358_1.typewritterCharCountI18N) / var_361_1)) > 0 and var_361_2 < var_361_5 then
					arg_358_1.talkMaxDuration = var_361_5

					if var_361_5 + var_361_0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_5 + var_361_0
					end
				end
			end

			local var_361_6 = math.max(2.33333333333333, arg_358_1.talkMaxDuration)

			if var_361_0 <= arg_358_1.time_ and arg_358_1.time_ < var_361_0 + var_361_6 then
				arg_358_1.fswtw_.percent = Mathf.Lerp(arg_358_1.var_.oldValueTypewriter, var_361_3, (arg_358_1.time_ - var_361_0) / var_361_6)
				arg_358_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_358_1.fswtw_:SetDirty()
			end

			if arg_358_1.time_ >= var_361_0 + var_361_6 and arg_358_1.time_ < var_361_0 + var_361_6 + arg_361_0 then
				arg_358_1.fswtw_.percent = var_361_3

				arg_358_1.fswtw_:SetDirty()
				arg_358_1:ShowNextGo(true)

				arg_358_1.typewritterCharCountI18N = var_361_4
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play417261088 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 417261088
		arg_362_1.duration_ = 2.86

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play417261089(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_9000

			if 0.966 < arg_362_1.time_ and arg_362_1.time_ <= 0.966 + arg_365_0 then
				arg_362_1.cswbg_:SetActive(false)
			end

			if 1 < arg_362_1.time_ and arg_362_1.time_ <= 1 + arg_365_0 then
				local var_365_0 = arg_362_1.bgs_.STblack

				arg_362_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_365_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_365_1 = var_365_0:GetComponent("SpriteRenderer")

				if var_365_1 and var_365_1.sprite then
					local var_365_2 = 2 * (var_365_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_365_0.transform.localScale = Vector3.New(var_365_2 / var_365_1.sprite.bounds.size.y < var_365_2 * manager.ui.mainCameraCom_.aspect / var_365_1.sprite.bounds.size.x and var_365_2 * manager.ui.mainCameraCom_.aspect / var_365_1.sprite.bounds.size.x or var_365_2 / var_365_1.sprite.bounds.size.y, var_365_2 / var_365_1.sprite.bounds.size.y < var_365_2 * manager.ui.mainCameraCom_.aspect / var_365_1.sprite.bounds.size.x and var_365_2 * manager.ui.mainCameraCom_.aspect / var_365_1.sprite.bounds.size.x or var_365_2 / var_365_1.sprite.bounds.size.y, 0)
				end

				for iter_365_0, iter_365_1 in pairs(arg_362_1.bgs_) do
					if iter_365_0 ~= "STblack" then
						iter_365_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_365_3 = 0

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_3 + arg_365_0 then
				arg_362_1.mask_.enabled = true
				arg_362_1.mask_.raycastTarget = true

				arg_362_1:SetGaussion(false)
			end

			local var_365_4 = 1

			if var_365_3 <= arg_362_1.time_ and arg_362_1.time_ < var_365_3 + var_365_4 then
				local var_365_5 = Color.New(0, 0, 0)

				var_365_5.a = Mathf.Lerp(0, 1, (arg_362_1.time_ - var_365_3) / var_365_4)
				arg_362_1.mask_.color = var_365_5
			end

			if arg_362_1.time_ >= var_365_3 + var_365_4 and arg_362_1.time_ < var_365_3 + var_365_4 + arg_365_0 then
				local var_365_6 = Color.New(0, 0, 0)

				var_365_6.a = 1
				arg_362_1.mask_.color = var_365_6
			end

			local var_365_7 = 1

			if 1 < arg_362_1.time_ and arg_362_1.time_ <= var_365_7 + arg_365_0 then
				arg_362_1.mask_.enabled = true
				arg_362_1.mask_.raycastTarget = true

				arg_362_1:SetGaussion(false)
			end

			local var_365_8 = 1

			if var_365_7 <= arg_362_1.time_ and arg_362_1.time_ < var_365_7 + var_365_8 then
				local var_365_9 = Color.New(0, 0, 0)

				var_365_9.a = Mathf.Lerp(1, 0, (arg_362_1.time_ - var_365_7) / var_365_8)
				arg_362_1.mask_.color = var_365_9
			end

			if arg_362_1.time_ >= var_365_7 + var_365_8 and arg_362_1.time_ < var_365_7 + var_365_8 + arg_365_0 then
				local var_365_10 = Color.New(0, 0, 0)

				arg_362_1.mask_.enabled = false
				var_365_10.a = 0
				arg_362_1.mask_.color = var_365_10
			end

			if 1 < arg_362_1.time_ and arg_362_1.time_ <= 1 + arg_365_0 then
				arg_362_1.fswbg_:SetActive(true)
				arg_362_1.dialog_:SetActive(false)

				arg_362_1.fswtw_.percent = 0
				arg_362_1.fswt_.text = arg_362_1:FormatText(arg_362_1:GetWordFromCfg(417261088).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.fswt_)

				arg_362_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_362_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_362_1.fswtw_:SetDirty()

				arg_362_1.typewritterCharCountI18N = 0

				SetActive(arg_362_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_362_1:ShowNextGo(false)
			end

			local var_365_11 = 1.33333333333333

			if 1.33333333333333 < arg_362_1.time_ and arg_362_1.time_ <= var_365_11 + arg_365_0 then
				arg_362_1.var_.oldValueTypewriter = arg_362_1.fswtw_.percent

				SetActive(arg_362_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_362_1:ShowNextGo(false)
			end

			local var_365_12 = 9
			local var_365_13 = 0.6
			local var_365_14, var_365_15 = arg_362_1:GetPercentByPara(arg_362_1:FormatText(arg_362_1:GetWordFromCfg(417261088).content), 1)

			if var_365_11 < arg_362_1.time_ and arg_362_1.time_ <= var_365_11 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0

				local var_365_16 = var_365_12 <= 0 and var_365_13 or var_365_13 * ((var_365_15 - arg_362_1.typewritterCharCountI18N) / var_365_12)

				if (var_365_12 <= 0 and var_365_13 or var_365_13 * ((var_365_15 - arg_362_1.typewritterCharCountI18N) / var_365_12)) > 0 and var_365_13 < var_365_16 then
					arg_362_1.talkMaxDuration = var_365_16

					if var_365_16 + var_365_11 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_16 + var_365_11
					end
				end
			end

			local var_365_17 = math.max(0.6, arg_362_1.talkMaxDuration)

			if var_365_11 <= arg_362_1.time_ and arg_362_1.time_ < var_365_11 + var_365_17 then
				arg_362_1.fswtw_.percent = Mathf.Lerp(arg_362_1.var_.oldValueTypewriter, var_365_14, (arg_362_1.time_ - var_365_11) / var_365_17)
				arg_362_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_362_1.fswtw_:SetDirty()
			end

			if arg_362_1.time_ >= var_365_11 + var_365_17 and arg_362_1.time_ < var_365_11 + var_365_17 + arg_365_0 then
				arg_362_1.fswtw_.percent = var_365_14

				arg_362_1.fswtw_:SetDirty()
				arg_362_1:ShowNextGo(true)

				arg_362_1.typewritterCharCountI18N = var_365_15
			end

			if 1 < arg_362_1.time_ and arg_362_1.time_ <= 1 + arg_365_0 then
				local var_365_18 = arg_362_1.fswbg_.transform:Find("textbox/adapt/content") or arg_362_1.fswbg_.transform:Find("textbox/content")
				local var_365_19 = arg_362_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_365_20 = var_365_18:GetComponent("RectTransform")

				var_365_18:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_365_20.offsetMin = Vector2.New(0, 0)
				var_365_20.offsetMax = Vector2.New(0, 0)
			end

			local var_365_21 = 1
			local var_365_22 = manager.audio:GetVoiceLength("story_v_out_417261", "417261088", "story_v_out_417261.awb") / 1000

			if var_365_22 > 0 and 1 < var_365_22 and var_365_22 + var_365_21 > arg_362_1.duration_ then
				arg_362_1.duration_ = var_365_22 + var_365_21
			end

			if var_365_21 < arg_362_1.time_ and arg_362_1.time_ <= var_365_21 + arg_365_0 then
				arg_362_1:AudioAction("play", "voice", "story_v_out_417261", "417261088", "story_v_out_417261.awb")
			end

			if 1.33333333333333 < arg_362_1.time_ and arg_362_1.time_ <= 1.33333333333333 + arg_365_0 then
				arg_362_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_thunder03", "")
			end

			if 1.33333333333333 < arg_362_1.time_ and arg_362_1.time_ <= 1.33333333333333 + arg_365_0 then
				local var_365_25 = arg_362_1.var_.effect10892

				if not arg_362_1.var_.effect10892 then
					var_365_25 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_in"), manager.ui.mainCamera.transform)
					var_365_25.name = "10892"
					arg_362_1.var_.effect10892 = var_365_25
				else
					var_365_25.transform:SetParent(var_365_9000)
				end

				var_365_25.transform.localPosition = Vector3.New(0, 0, 0)
				var_365_25.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_365_27 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_365_28 = var_365_25.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_365_2, iter_365_3 in ipairs((var_365_28:ToTable())) do
					iter_365_3.transform.localScale = Vector3.New(iter_365_3.transform.localScale.x / var_365_27 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_365_28 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_365_3.transform.localScale.y / var_365_27, iter_365_3.transform.localScale.z)
				end
			end

			if 2.225 < arg_362_1.time_ and arg_362_1.time_ <= 2.225 + arg_365_0 then
				if arg_362_1.var_.effect10892 then
					Object.Destroy(arg_362_1.var_.effect10892)

					arg_362_1.var_.effect10892 = nil
				end
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play417261089 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 417261089
		arg_366_1.duration_ = 3

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
			arg_366_1.auto_ = false
		end

		function arg_366_1.playNext_(arg_368_0)
			arg_366_1.onStoryFinished_()
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_9000

			if 1 < arg_366_1.time_ and arg_366_1.time_ <= 1 + arg_369_0 then
				arg_366_1.cswbg_:SetActive(true)

				local var_369_0 = arg_366_1.cswt_:GetComponent("RectTransform")

				arg_366_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_369_0.offsetMin = Vector2.New(0, 0)
				var_369_0.offsetMax = Vector2.New(0, 0)
				arg_366_1.cswt_.text = arg_366_1:FormatText(arg_366_1:GetWordFromCfg(419126).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.cswt_)

				arg_366_1.cswt_.fontSize = 120
				arg_366_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_366_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_366_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_369_1 = 0

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_1 + arg_369_0 then
				arg_366_1.mask_.enabled = true
				arg_366_1.mask_.raycastTarget = true

				arg_366_1:SetGaussion(false)
			end

			local var_369_2 = 1

			if var_369_1 <= arg_366_1.time_ and arg_366_1.time_ < var_369_1 + var_369_2 then
				local var_369_3 = Color.New(0, 0, 0)

				var_369_3.a = Mathf.Lerp(0, 1, (arg_366_1.time_ - var_369_1) / var_369_2)
				arg_366_1.mask_.color = var_369_3
			end

			if arg_366_1.time_ >= var_369_1 + var_369_2 and arg_366_1.time_ < var_369_1 + var_369_2 + arg_369_0 then
				local var_369_4 = Color.New(0, 0, 0)

				var_369_4.a = 1
				arg_366_1.mask_.color = var_369_4
			end

			local var_369_5 = 1

			if 1 < arg_366_1.time_ and arg_366_1.time_ <= var_369_5 + arg_369_0 then
				arg_366_1.mask_.enabled = true
				arg_366_1.mask_.raycastTarget = true

				arg_366_1:SetGaussion(false)
			end

			local var_369_6 = 1

			if var_369_5 <= arg_366_1.time_ and arg_366_1.time_ < var_369_5 + var_369_6 then
				local var_369_7 = Color.New(0, 0, 0)

				var_369_7.a = Mathf.Lerp(1, 0, (arg_366_1.time_ - var_369_5) / var_369_6)
				arg_366_1.mask_.color = var_369_7
			end

			if arg_366_1.time_ >= var_369_5 + var_369_6 and arg_366_1.time_ < var_369_5 + var_369_6 + arg_369_0 then
				local var_369_8 = Color.New(0, 0, 0)

				arg_366_1.mask_.enabled = false
				var_369_8.a = 0
				arg_366_1.mask_.color = var_369_8
			end

			if 0.9 < arg_366_1.time_ and arg_366_1.time_ <= 0.9 + arg_369_0 then
				arg_366_1.fswbg_:SetActive(false)
				arg_366_1.dialog_:SetActive(false)
				SetActive(arg_366_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_366_1:ShowNextGo(false)
			end

			if 1 < arg_366_1.time_ and arg_366_1.time_ <= 1 + arg_369_0 then
				local var_369_9 = arg_366_1.var_.effect10891

				if not arg_366_1.var_.effect10891 then
					var_369_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavymax_1"), manager.ui.mainCamera.transform)
					var_369_9.name = "10891"
					arg_366_1.var_.effect10891 = var_369_9
				else
					var_369_9.transform:SetParent(var_369_9000)
				end

				var_369_9.transform.localPosition = Vector3.New(0, 0, 0)
				var_369_9.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_369_11 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_369_12 = var_369_9.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_369_0, iter_369_1 in ipairs((var_369_12:ToTable())) do
					iter_369_1.transform.localScale = Vector3.New(iter_369_1.transform.localScale.x / var_369_11 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_369_12 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_369_1.transform.localScale.y / var_369_11, iter_369_1.transform.localScale.z)
				end
			end

			if 1 < arg_366_1.time_ and arg_366_1.time_ <= 1 + arg_369_0 then
				arg_366_1:AudioAction("play", "effect", "se_story_1212", "se_story_1210_thunderrain_loop", "")
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I16f",
		"TextureConfig/Background/B13g",
		"TextureConfig/Background/ST73",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST02"
	},
	voices = {
		"story_v_out_417261.awb"
	}
}
