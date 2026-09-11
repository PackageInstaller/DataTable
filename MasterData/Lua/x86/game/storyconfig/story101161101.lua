return {
	Play116111001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116111001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play116111002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.B13g == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B13g")
				var_4_0.name = "B13g"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.B13g = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.B13g

				arg_1_1.bgs_.B13g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B13g" then
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense")

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

			if 2.2 < arg_1_1.time_ and arg_1_1.time_ <= 2.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_6_story_intense", "HB", "bgm_activity_1_6_story_intense.awb")

				local var_4_16 = manager.audio:GetAudioName("bgm_activity_1_6_story_intense", "HB")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_16 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_16

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_16
						arg_1_1.bgmTxt2_.text = var_4_16
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

			local var_4_17 = 2
			local var_4_18 = 0.325

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_19 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_19:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_20 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(116111001).content)

				arg_1_1.text_.text = var_4_20

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_22 = 13 <= 0 and var_4_18 or var_4_18 * (utf8.len(var_4_20) / 13)

				if (13 <= 0 and var_4_18 or var_4_18 * (utf8.len(var_4_20) / 13)) > 0 and var_4_18 < var_4_22 then
					arg_1_1.talkMaxDuration = var_4_22
					var_4_17 = var_4_17 + 0.3

					if var_4_22 + var_4_17 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_17
					end
				end

				arg_1_1.text_.text = var_4_20
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_23 = var_4_17 + 0.3
			local var_4_24 = math.max(var_4_18, arg_1_1.talkMaxDuration)

			if var_4_17 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_23 + var_4_24 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_23) / var_4_24

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_23 + var_4_24 and arg_1_1.time_ < var_4_23 + var_4_24 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play116111002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 116111002
		arg_10_1.duration_ = 5

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play116111003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = 1.15

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, false)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_1 = arg_10_1:FormatText(arg_10_1:GetWordFromCfg(116111002).content)

				arg_10_1.text_.text = var_13_1

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_3 = 46 <= 0 and var_13_0 or var_13_0 * (utf8.len(var_13_1) / 46)

				if (46 <= 0 and var_13_0 or var_13_0 * (utf8.len(var_13_1) / 46)) > 0 and var_13_0 < var_13_3 then
					arg_10_1.talkMaxDuration = var_13_3

					if var_13_3 + 0 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_3 + 0
					end
				end

				arg_10_1.text_.text = var_13_1
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)
				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_4 = math.max(var_13_0, arg_10_1.talkMaxDuration)

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_4 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - 0) / var_13_4

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= 0 + var_13_4 and arg_10_1.time_ < 0 + var_13_4 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play116111003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 116111003
		arg_14_1.duration_ = 5

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play116111004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0.25

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				arg_14_1.leftNameTxt_.text = arg_14_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, true)
				arg_14_1.iconController_:SetSelectedState("hero")

				arg_14_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_14_1.callingController_:SetSelectedState("normal")

				arg_14_1.keyicon_.color = Color.New(1, 1, 1)
				arg_14_1.icon_.color = Color.New(1, 1, 1)

				local var_17_1 = arg_14_1:FormatText(arg_14_1:GetWordFromCfg(116111003).content)

				arg_14_1.text_.text = var_17_1

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_3 = 10 <= 0 and var_17_0 or var_17_0 * (utf8.len(var_17_1) / 10)

				if (10 <= 0 and var_17_0 or var_17_0 * (utf8.len(var_17_1) / 10)) > 0 and var_17_0 < var_17_3 then
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
	Play116111004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 116111004
		arg_18_1.duration_ = 5

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play116111005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0.975

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, false)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_1 = arg_18_1:FormatText(arg_18_1:GetWordFromCfg(116111004).content)

				arg_18_1.text_.text = var_21_1

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_3 = 39 <= 0 and var_21_0 or var_21_0 * (utf8.len(var_21_1) / 39)

				if (39 <= 0 and var_21_0 or var_21_0 * (utf8.len(var_21_1) / 39)) > 0 and var_21_0 < var_21_3 then
					arg_18_1.talkMaxDuration = var_21_3

					if var_21_3 + 0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_3 + 0
					end
				end

				arg_18_1.text_.text = var_21_1
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)
				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_4 = math.max(var_21_0, arg_18_1.talkMaxDuration)

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_4 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - 0) / var_21_4

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= 0 + var_21_4 and arg_18_1.time_ < 0 + var_21_4 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play116111005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 116111005
		arg_22_1.duration_ = 5

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play116111006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0.55

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, false)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_1 = arg_22_1:FormatText(arg_22_1:GetWordFromCfg(116111005).content)

				arg_22_1.text_.text = var_25_1

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_3 = 22 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_1) / 22)

				if (22 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_1) / 22)) > 0 and var_25_0 < var_25_3 then
					arg_22_1.talkMaxDuration = var_25_3

					if var_25_3 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_3 + 0
					end
				end

				arg_22_1.text_.text = var_25_1
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_4 = math.max(var_25_0, arg_22_1.talkMaxDuration)

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_4 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - 0) / var_25_4

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= 0 + var_25_4 and arg_22_1.time_ < 0 + var_25_4 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play116111006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 116111006
		arg_26_1.duration_ = 5

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play116111007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0.675

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, true)
				arg_26_1.iconController_:SetSelectedState("hero")

				arg_26_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_26_1.callingController_:SetSelectedState("normal")

				arg_26_1.keyicon_.color = Color.New(1, 1, 1)
				arg_26_1.icon_.color = Color.New(1, 1, 1)

				local var_29_1 = arg_26_1:FormatText(arg_26_1:GetWordFromCfg(116111006).content)

				arg_26_1.text_.text = var_29_1

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_3 = 27 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_1) / 27)

				if (27 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_1) / 27)) > 0 and var_29_0 < var_29_3 then
					arg_26_1.talkMaxDuration = var_29_3

					if var_29_3 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_3 + 0
					end
				end

				arg_26_1.text_.text = var_29_1
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)
				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_4 = math.max(var_29_0, arg_26_1.talkMaxDuration)

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_4 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - 0) / var_29_4

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= 0 + var_29_4 and arg_26_1.time_ < 0 + var_29_4 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play116111007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 116111007
		arg_30_1.duration_ = 5

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play116111008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 1.25

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, false)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_1 = arg_30_1:FormatText(arg_30_1:GetWordFromCfg(116111007).content)

				arg_30_1.text_.text = var_33_1

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_3 = 50 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_1) / 50)

				if (50 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_1) / 50)) > 0 and var_33_0 < var_33_3 then
					arg_30_1.talkMaxDuration = var_33_3

					if var_33_3 + 0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_3 + 0
					end
				end

				arg_30_1.text_.text = var_33_1
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_4 = math.max(var_33_0, arg_30_1.talkMaxDuration)

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_4 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - 0) / var_33_4

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= 0 + var_33_4 and arg_30_1.time_ < 0 + var_33_4 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play116111008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 116111008
		arg_34_1.duration_ = 5

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play116111009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 0.425

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, false)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_1 = arg_34_1:FormatText(arg_34_1:GetWordFromCfg(116111008).content)

				arg_34_1.text_.text = var_37_1

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_3 = 17 <= 0 and var_37_0 or var_37_0 * (utf8.len(var_37_1) / 17)

				if (17 <= 0 and var_37_0 or var_37_0 * (utf8.len(var_37_1) / 17)) > 0 and var_37_0 < var_37_3 then
					arg_34_1.talkMaxDuration = var_37_3

					if var_37_3 + 0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_3 + 0
					end
				end

				arg_34_1.text_.text = var_37_1
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)
				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_4 = math.max(var_37_0, arg_34_1.talkMaxDuration)

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_4 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - 0) / var_37_4

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= 0 + var_37_4 and arg_34_1.time_ < 0 + var_37_4 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play116111009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 116111009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play116111010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_41_0 = 0.6

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 then
				local var_41_1, var_41_2 = math.modf((arg_38_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_41_2 * 0.13, var_41_2 * 0.13, var_41_2 * 0.13) + arg_38_1.var_.shakeOldPos
			end

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 then
				manager.ui.mainCamera.transform.localPosition = arg_38_1.var_.shakeOldPos
			end

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1:AudioAction("play", "effect", "se_story_16", "se_story_16_fall02", "")
			end

			local var_41_4 = 0

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_4 + arg_41_0 then
				arg_38_1.allBtn_.enabled = false
			end

			if arg_38_1.time_ >= var_41_4 + 2.36666666666667 and arg_38_1.time_ < var_41_4 + 2.36666666666667 + arg_41_0 then
				arg_38_1.allBtn_.enabled = true
			end

			if 0.433333333333333 < arg_38_1.time_ and arg_38_1.time_ <= 0.433333333333333 + arg_41_0 then
				local var_41_5 = arg_38_1.bgs_.B13g:GetComponent("SpriteRenderer")

				if var_41_5 then
					arg_38_1.var_.alphaOldValueB13g = var_41_5.color.a
					arg_38_1.var_.alphaMatValueB13g = var_41_5
				end

				arg_38_1.var_.alphaOldValueB13g = 1
			end

			local var_41_6 = 0.733333333333333

			if 0.433333333333333 <= arg_38_1.time_ and arg_38_1.time_ < 0.433333333333333 + var_41_6 then
				if arg_38_1.var_.alphaMatValueB13g then
					arg_38_1.var_.alphaMatValueB13g.color.a = Mathf.Lerp(arg_38_1.var_.alphaOldValueB13g, 0, (arg_38_1.time_ - 0.433333333333333) / var_41_6)
					arg_38_1.var_.alphaMatValueB13g.color = arg_38_1.var_.alphaMatValueB13g.color
				end
			end

			if arg_38_1.time_ >= 0.433333333333333 + var_41_6 and arg_38_1.time_ < 0.433333333333333 + var_41_6 + arg_41_0 and arg_38_1.var_.alphaMatValueB13g then
				arg_38_1.var_.alphaMatValueB13g.color.a = 0
				arg_38_1.var_.alphaMatValueB13g.color = arg_38_1.var_.alphaMatValueB13g.color
			end

			local var_41_7 = 0
			local var_41_8 = 0.125

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_7 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, true)
				arg_38_1.iconController_:SetSelectedState("hero")

				arg_38_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_38_1.callingController_:SetSelectedState("normal")

				arg_38_1.keyicon_.color = Color.New(1, 1, 1)
				arg_38_1.icon_.color = Color.New(1, 1, 1)

				local var_41_9 = arg_38_1:FormatText(arg_38_1:GetWordFromCfg(116111009).content)

				arg_38_1.text_.text = var_41_9

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_11 = 5 <= 0 and var_41_8 or var_41_8 * (utf8.len(var_41_9) / 5)

				if (5 <= 0 and var_41_8 or var_41_8 * (utf8.len(var_41_9) / 5)) > 0 and var_41_8 < var_41_11 then
					arg_38_1.talkMaxDuration = var_41_11

					if var_41_11 + var_41_7 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_11 + var_41_7
					end
				end

				arg_38_1.text_.text = var_41_9
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_12 = math.max(var_41_8, arg_38_1.talkMaxDuration)

			if var_41_7 <= arg_38_1.time_ and arg_38_1.time_ < var_41_7 + var_41_12 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_7) / var_41_12

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_7 + var_41_12 and arg_38_1.time_ < var_41_7 + var_41_12 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play116111010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 116111010
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play116111011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 1.175

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, false)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_1 = arg_42_1:FormatText(arg_42_1:GetWordFromCfg(116111010).content)

				arg_42_1.text_.text = var_45_1

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_3 = 47 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_1) / 47)

				if (47 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_1) / 47)) > 0 and var_45_0 < var_45_3 then
					arg_42_1.talkMaxDuration = var_45_3

					if var_45_3 + 0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_3 + 0
					end
				end

				arg_42_1.text_.text = var_45_1
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_4 = math.max(var_45_0, arg_42_1.talkMaxDuration)

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_4 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - 0) / var_45_4

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= 0 + var_45_4 and arg_42_1.time_ < 0 + var_45_4 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play116111011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 116111011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play116111012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0.65

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_1 = arg_46_1:FormatText(arg_46_1:GetWordFromCfg(116111011).content)

				arg_46_1.text_.text = var_49_1

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_3 = 26 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_1) / 26)

				if (26 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_1) / 26)) > 0 and var_49_0 < var_49_3 then
					arg_46_1.talkMaxDuration = var_49_3

					if var_49_3 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_3 + 0
					end
				end

				arg_46_1.text_.text = var_49_1
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_4 = math.max(var_49_0, arg_46_1.talkMaxDuration)

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_4 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - 0) / var_49_4

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= 0 + var_49_4 and arg_46_1.time_ < 0 + var_49_4 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play116111012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 116111012
		arg_50_1.duration_ = 9

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play116111013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				local var_53_0 = arg_50_1.bgs_.B13g

				arg_50_1.bgs_.B13g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_53_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_53_1 = var_53_0:GetComponent("SpriteRenderer")

				if var_53_1 and var_53_1.sprite then
					local var_53_2 = 2 * (var_53_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_53_0.transform.localScale = Vector3.New(var_53_2 / var_53_1.sprite.bounds.size.y < var_53_2 * manager.ui.mainCameraCom_.aspect / var_53_1.sprite.bounds.size.x and var_53_2 * manager.ui.mainCameraCom_.aspect / var_53_1.sprite.bounds.size.x or var_53_2 / var_53_1.sprite.bounds.size.y, var_53_2 / var_53_1.sprite.bounds.size.y < var_53_2 * manager.ui.mainCameraCom_.aspect / var_53_1.sprite.bounds.size.x and var_53_2 * manager.ui.mainCameraCom_.aspect / var_53_1.sprite.bounds.size.x or var_53_2 / var_53_1.sprite.bounds.size.y, 0)
				end

				for iter_53_0, iter_53_1 in pairs(arg_50_1.bgs_) do
					if iter_53_0 ~= "B13g" then
						iter_53_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_53_3 = 0

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_3 + arg_53_0 then
				arg_50_1.mask_.enabled = true
				arg_50_1.mask_.raycastTarget = true

				arg_50_1:SetGaussion(false)
			end

			local var_53_4 = 1

			if var_53_3 <= arg_50_1.time_ and arg_50_1.time_ < var_53_3 + var_53_4 then
				local var_53_5 = Color.New(0, 0, 0)

				var_53_5.a = Mathf.Lerp(1, 0, (arg_50_1.time_ - var_53_3) / var_53_4)
				arg_50_1.mask_.color = var_53_5
			end

			if arg_50_1.time_ >= var_53_3 + var_53_4 and arg_50_1.time_ < var_53_3 + var_53_4 + arg_53_0 then
				local var_53_6 = Color.New(0, 0, 0)

				arg_50_1.mask_.enabled = false
				var_53_6.a = 0
				arg_50_1.mask_.color = var_53_6
			end

			local var_53_7 = 1

			if 1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_7 + arg_53_0 then
				arg_50_1.mask_.enabled = true
				arg_50_1.mask_.raycastTarget = true

				arg_50_1:SetGaussion(false)
			end

			local var_53_8 = 1

			if var_53_7 <= arg_50_1.time_ and arg_50_1.time_ < var_53_7 + var_53_8 then
				local var_53_9 = Color.New(0, 0, 0)

				var_53_9.a = Mathf.Lerp(0, 1, (arg_50_1.time_ - var_53_7) / var_53_8)
				arg_50_1.mask_.color = var_53_9
			end

			if arg_50_1.time_ >= var_53_7 + var_53_8 and arg_50_1.time_ < var_53_7 + var_53_8 + arg_53_0 then
				local var_53_10 = Color.New(0, 0, 0)

				var_53_10.a = 1
				arg_50_1.mask_.color = var_53_10
			end

			local var_53_11 = 2.5

			if 2.5 < arg_50_1.time_ and arg_50_1.time_ <= var_53_11 + arg_53_0 then
				arg_50_1.mask_.enabled = true
				arg_50_1.mask_.raycastTarget = true

				arg_50_1:SetGaussion(false)
			end

			local var_53_12 = 2.1

			if var_53_11 <= arg_50_1.time_ and arg_50_1.time_ < var_53_11 + var_53_12 then
				local var_53_13 = Color.New(0, 0, 0)

				var_53_13.a = Mathf.Lerp(1, 0, (arg_50_1.time_ - var_53_11) / var_53_12)
				arg_50_1.mask_.color = var_53_13
			end

			if arg_50_1.time_ >= var_53_11 + var_53_12 and arg_50_1.time_ < var_53_11 + var_53_12 + arg_53_0 then
				local var_53_14 = Color.New(0, 0, 0)

				arg_50_1.mask_.enabled = false
				var_53_14.a = 0
				arg_50_1.mask_.color = var_53_14
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				local var_53_15 = arg_50_1.bgs_.B13g:GetComponent("SpriteRenderer")

				if var_53_15 then
					arg_50_1.var_.alphaOldValueB13g = var_53_15.color.a
					arg_50_1.var_.alphaMatValueB13g = var_53_15
				end

				arg_50_1.var_.alphaOldValueB13g = 0
			end

			local var_53_16 = 0.0166666666666667

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_16 then
				if arg_50_1.var_.alphaMatValueB13g then
					arg_50_1.var_.alphaMatValueB13g.color.a = Mathf.Lerp(arg_50_1.var_.alphaOldValueB13g, 1, (arg_50_1.time_ - 0) / var_53_16)
					arg_50_1.var_.alphaMatValueB13g.color = arg_50_1.var_.alphaMatValueB13g.color
				end
			end

			if arg_50_1.time_ >= 0 + var_53_16 and arg_50_1.time_ < 0 + var_53_16 + arg_53_0 and arg_50_1.var_.alphaMatValueB13g then
				arg_50_1.var_.alphaMatValueB13g.color.a = 1
				arg_50_1.var_.alphaMatValueB13g.color = arg_50_1.var_.alphaMatValueB13g.color
			end

			local var_53_17 = 2

			if 2 < arg_50_1.time_ and arg_50_1.time_ <= var_53_17 + arg_53_0 then
				arg_50_1.allBtn_.enabled = false
			end

			if arg_50_1.time_ >= var_53_17 + 0.5 and arg_50_1.time_ < var_53_17 + 0.5 + arg_53_0 then
				arg_50_1.allBtn_.enabled = true
			end

			if arg_50_1.frameCnt_ <= 1 then
				arg_50_1.dialog_:SetActive(false)
			end

			local var_53_18 = 4
			local var_53_19 = 0.075

			if 4 < arg_50_1.time_ and arg_50_1.time_ <= var_53_18 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0

				arg_50_1.dialog_:SetActive(true)

				arg_50_1.dialogCg_.alpha = 0

				local var_53_20 = LeanTween.value(arg_50_1.dialog_, 0, 1, 0.3)

				var_53_20:setOnUpdate(LuaHelper.FloatAction(function(arg_54_0)
					arg_50_1.dialogCg_.alpha = arg_54_0
				end))
				var_53_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_50_1.dialog_)
					var_53_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_50_1.duration_ = arg_50_1.duration_ + 0.3

				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_21 = arg_50_1:FormatText(arg_50_1:GetWordFromCfg(116111012).content)

				arg_50_1.text_.text = var_53_21

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_23 = 3 <= 0 and var_53_19 or var_53_19 * (utf8.len(var_53_21) / 3)

				if (3 <= 0 and var_53_19 or var_53_19 * (utf8.len(var_53_21) / 3)) > 0 and var_53_19 < var_53_23 then
					arg_50_1.talkMaxDuration = var_53_23
					var_53_18 = var_53_18 + 0.3

					if var_53_23 + var_53_18 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_23 + var_53_18
					end
				end

				arg_50_1.text_.text = var_53_21
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_24 = var_53_18 + 0.3
			local var_53_25 = math.max(var_53_19, arg_50_1.talkMaxDuration)

			if var_53_18 + 0.3 <= arg_50_1.time_ and arg_50_1.time_ < var_53_24 + var_53_25 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_24) / var_53_25

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_24 + var_53_25 and arg_50_1.time_ < var_53_24 + var_53_25 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play116111013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 116111013
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play116111014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0.7

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_1 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(116111013).content)

				arg_56_1.text_.text = var_59_1

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_3 = 28 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_1) / 28)

				if (28 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_1) / 28)) > 0 and var_59_0 < var_59_3 then
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
	Play116111014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 116111014
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play116111015(arg_60_1)
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

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_1 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(116111014).content)

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
	Play116111015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 116111015
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play116111016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0.775

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

				local var_67_1 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(116111015).content)

				arg_64_1.text_.text = var_67_1

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_3 = 31 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_1) / 31)

				if (31 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_1) / 31)) > 0 and var_67_0 < var_67_3 then
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
	Play116111016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 116111016
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play116111017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0.425

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_1 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(116111016).content)

				arg_68_1.text_.text = var_71_1

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_3 = 17 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_1) / 17)

				if (17 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_1) / 17)) > 0 and var_71_0 < var_71_3 then
					arg_68_1.talkMaxDuration = var_71_3

					if var_71_3 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_3 + 0
					end
				end

				arg_68_1.text_.text = var_71_1
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_4 = math.max(var_71_0, arg_68_1.talkMaxDuration)

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_4 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - 0) / var_71_4

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= 0 + var_71_4 and arg_68_1.time_ < 0 + var_71_4 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play116111017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 116111017
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play116111018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0.65

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_1 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(116111017).content)

				arg_72_1.text_.text = var_75_1

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_3 = 26 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_1) / 26)

				if (26 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_1) / 26)) > 0 and var_75_0 < var_75_3 then
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
	Play116111018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 116111018
		arg_76_1.duration_ = 5.97

		local var_76_0 = {
			zh = 5.5,
			ja = 5.966
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
				arg_76_0:Play116111019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.mask_.enabled = true
				arg_76_1.mask_.raycastTarget = true

				arg_76_1:SetGaussion(false)
			end

			local var_79_0 = 2

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 then
				local var_79_1 = Color.New(0, 0, 0)

				var_79_1.a = Mathf.Lerp(0, 1, (arg_76_1.time_ - 0) / var_79_0)
				arg_76_1.mask_.color = var_79_1
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 then
				local var_79_2 = Color.New(0, 0, 0)

				var_79_2.a = 1
				arg_76_1.mask_.color = var_79_2
			end

			local var_79_3 = 2

			if 2 < arg_76_1.time_ and arg_76_1.time_ <= var_79_3 + arg_79_0 then
				arg_76_1.mask_.enabled = true
				arg_76_1.mask_.raycastTarget = true

				arg_76_1:SetGaussion(false)
			end

			local var_79_4 = 2

			if var_79_3 <= arg_76_1.time_ and arg_76_1.time_ < var_79_3 + var_79_4 then
				local var_79_5 = Color.New(0, 0, 0)

				var_79_5.a = Mathf.Lerp(1, 0, (arg_76_1.time_ - var_79_3) / var_79_4)
				arg_76_1.mask_.color = var_79_5
			end

			if arg_76_1.time_ >= var_79_3 + var_79_4 and arg_76_1.time_ < var_79_3 + var_79_4 + arg_79_0 then
				local var_79_6 = Color.New(0, 0, 0)

				arg_76_1.mask_.enabled = false
				var_79_6.a = 0
				arg_76_1.mask_.color = var_79_6
			end

			local var_79_7 = "ST18"

			if arg_76_1.bgs_.ST18 == nil then
				local var_79_8 = Object.Instantiate(arg_76_1.paintGo_)

				var_79_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_79_7)
				var_79_8.name = var_79_7
				var_79_8.transform.parent = arg_76_1.stage_.transform
				var_79_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_76_1.bgs_[var_79_7] = var_79_8
			end

			if 2 < arg_76_1.time_ and arg_76_1.time_ <= 2 + arg_79_0 then
				local var_79_9 = arg_76_1.bgs_.ST18

				arg_76_1.bgs_.ST18.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_79_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_79_10 = var_79_9:GetComponent("SpriteRenderer")

				if var_79_10 and var_79_10.sprite then
					local var_79_11 = 2 * (var_79_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_79_9.transform.localScale = Vector3.New(var_79_11 / var_79_10.sprite.bounds.size.y < var_79_11 * manager.ui.mainCameraCom_.aspect / var_79_10.sprite.bounds.size.x and var_79_11 * manager.ui.mainCameraCom_.aspect / var_79_10.sprite.bounds.size.x or var_79_11 / var_79_10.sprite.bounds.size.y, var_79_11 / var_79_10.sprite.bounds.size.y < var_79_11 * manager.ui.mainCameraCom_.aspect / var_79_10.sprite.bounds.size.x and var_79_11 * manager.ui.mainCameraCom_.aspect / var_79_10.sprite.bounds.size.x or var_79_11 / var_79_10.sprite.bounds.size.y, 0)
				end

				for iter_79_0, iter_79_1 in pairs(arg_76_1.bgs_) do
					if iter_79_0 ~= "ST18" then
						iter_79_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_76_1.frameCnt_ <= 1 then
				arg_76_1.dialog_:SetActive(false)
			end

			local var_79_12 = 4
			local var_79_13 = 0.125

			if 4 < arg_76_1.time_ and arg_76_1.time_ <= var_79_12 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0

				arg_76_1.dialog_:SetActive(true)

				arg_76_1.dialogCg_.alpha = 0

				local var_79_14 = LeanTween.value(arg_76_1.dialog_, 0, 1, 0.3)

				var_79_14:setOnUpdate(LuaHelper.FloatAction(function(arg_80_0)
					arg_76_1.dialogCg_.alpha = arg_80_0
				end))
				var_79_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_76_1.dialog_)
					var_79_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_76_1.duration_ = arg_76_1.duration_ + 0.3

				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_15 = arg_76_1:GetWordFromCfg(116111018)
				local var_79_16 = arg_76_1:FormatText(var_79_15.content)

				arg_76_1.text_.text = var_79_16

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_18 = 5 <= 0 and var_79_13 or var_79_13 * (utf8.len(var_79_16) / 5)

				if (5 <= 0 and var_79_13 or var_79_13 * (utf8.len(var_79_16) / 5)) > 0 and var_79_13 < var_79_18 then
					arg_76_1.talkMaxDuration = var_79_18
					var_79_12 = var_79_12 + 0.3

					if var_79_18 + var_79_12 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_18 + var_79_12
					end
				end

				arg_76_1.text_.text = var_79_16
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116111", "116111018", "story_v_out_116111.awb") ~= 0 then
					local var_79_19 = manager.audio:GetVoiceLength("story_v_out_116111", "116111018", "story_v_out_116111.awb") / 1000

					if var_79_19 + var_79_12 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_19 + var_79_12
					end

					if var_79_15.prefab_name ~= "" and arg_76_1.actors_[var_79_15.prefab_name] ~= nil then
						local var_79_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_15.prefab_name].transform, "story_v_out_116111", "116111018", "story_v_out_116111.awb")

						arg_76_1:RecordAudio("116111018", var_79_20)
						arg_76_1:RecordAudio("116111018", var_79_20)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_116111", "116111018", "story_v_out_116111.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_116111", "116111018", "story_v_out_116111.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_21 = var_79_12 + 0.3
			local var_79_22 = math.max(var_79_13, arg_76_1.talkMaxDuration)

			if var_79_12 + 0.3 <= arg_76_1.time_ and arg_76_1.time_ < var_79_21 + var_79_22 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_21) / var_79_22

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_21 + var_79_22 and arg_76_1.time_ < var_79_21 + var_79_22 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play116111019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 116111019
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play116111020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 1.4

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_1 = arg_82_1:FormatText(arg_82_1:GetWordFromCfg(116111019).content)

				arg_82_1.text_.text = var_85_1

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_3 = 56 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_1) / 56)

				if (56 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_1) / 56)) > 0 and var_85_0 < var_85_3 then
					arg_82_1.talkMaxDuration = var_85_3

					if var_85_3 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_3 + 0
					end
				end

				arg_82_1.text_.text = var_85_1
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_4 = math.max(var_85_0, arg_82_1.talkMaxDuration)

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_4 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - 0) / var_85_4

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= 0 + var_85_4 and arg_82_1.time_ < 0 + var_85_4 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play116111020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 116111020
		arg_86_1.duration_ = 3.77

		local var_86_0 = {
			zh = 3.766,
			ja = 2.8
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
				arg_86_0:Play116111021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if arg_86_1.actors_["10025ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10025ui_story"))) then
				local var_89_0 = Object.Instantiate(Asset.Load("Char/" .. "10025ui_story"), arg_86_1.stage_.transform)

				var_89_0.name = "10025ui_story"
				var_89_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_86_1.actors_["10025ui_story"] = var_89_0

				local var_89_1 = var_89_0:GetComponentInChildren(typeof(CharacterEffect))

				var_89_1.enabled = true

				local var_89_2 = GameObjectTools.GetOrAddComponent(var_89_0, typeof(DynamicBoneHelper))

				if var_89_2 then
					var_89_2:EnableDynamicBone(false)
				end

				arg_86_1:ShowWeapon(var_89_1.transform, false)

				arg_86_1.var_["10025ui_story" .. "Animator"] = var_89_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_86_1.var_["10025ui_story" .. "Animator"].applyRootMotion = true
				arg_86_1.var_["10025ui_story" .. "LipSync"] = var_89_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_89_3 = arg_86_1.actors_["10025ui_story"].transform

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos10025ui_story = var_89_3.localPosition
			end

			local var_89_4 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_4 then
				var_89_3.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_86_1.time_ - 0) / var_89_4)
				var_89_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_3.position).x, (manager.ui.mainCamera.transform.position - var_89_3.position).y, (manager.ui.mainCamera.transform.position - var_89_3.position).z)
				var_89_3.localEulerAngles.z = 0
				var_89_3.localEulerAngles.x = 0
				var_89_3.localEulerAngles = var_89_3.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_4 and arg_86_1.time_ < 0 + var_89_4 + arg_89_0 then
				var_89_3.localPosition = Vector3.New(0, -1.1, -5.9)
				var_89_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_3.position).x, (manager.ui.mainCamera.transform.position - var_89_3.position).y, (manager.ui.mainCamera.transform.position - var_89_3.position).z)
				var_89_3.localEulerAngles.z = 0
				var_89_3.localEulerAngles.x = 0
				var_89_3.localEulerAngles = var_89_3.localEulerAngles
			end

			local var_89_5 = arg_86_1.actors_["10025ui_story"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_5) and arg_86_1.var_.characterEffect10025ui_story == nil then
				arg_86_1.var_.characterEffect10025ui_story = var_89_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_6 = 0.2

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_6 and not isNil(var_89_5) then
				if arg_86_1.var_.characterEffect10025ui_story and not isNil(var_89_5) then
					arg_86_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= 0 + var_89_6 and arg_86_1.time_ < 0 + var_89_6 + arg_89_0 and not isNil(var_89_5) and arg_86_1.var_.characterEffect10025ui_story then
				arg_86_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action6_1")
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_89_8 = 0
			local var_89_9 = 0.2

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_8 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_10 = arg_86_1:GetWordFromCfg(116111020)
				local var_89_11 = arg_86_1:FormatText(var_89_10.content)

				arg_86_1.text_.text = var_89_11

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_13 = 8 <= 0 and var_89_9 or var_89_9 * (utf8.len(var_89_11) / 8)

				if (8 <= 0 and var_89_9 or var_89_9 * (utf8.len(var_89_11) / 8)) > 0 and var_89_9 < var_89_13 then
					arg_86_1.talkMaxDuration = var_89_13

					if var_89_13 + var_89_8 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_13 + var_89_8
					end
				end

				arg_86_1.text_.text = var_89_11
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116111", "116111020", "story_v_out_116111.awb") ~= 0 then
					local var_89_14 = manager.audio:GetVoiceLength("story_v_out_116111", "116111020", "story_v_out_116111.awb") / 1000

					if var_89_14 + var_89_8 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_14 + var_89_8
					end

					if var_89_10.prefab_name ~= "" and arg_86_1.actors_[var_89_10.prefab_name] ~= nil then
						local var_89_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_10.prefab_name].transform, "story_v_out_116111", "116111020", "story_v_out_116111.awb")

						arg_86_1:RecordAudio("116111020", var_89_15)
						arg_86_1:RecordAudio("116111020", var_89_15)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_116111", "116111020", "story_v_out_116111.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_116111", "116111020", "story_v_out_116111.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_16 = math.max(var_89_9, arg_86_1.talkMaxDuration)

			if var_89_8 <= arg_86_1.time_ and arg_86_1.time_ < var_89_8 + var_89_16 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_8) / var_89_16

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_8 + var_89_16 and arg_86_1.time_ < var_89_8 + var_89_16 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play116111021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 116111021
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play116111022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["10025ui_story"]) and arg_90_1.var_.characterEffect10025ui_story == nil then
				arg_90_1.var_.characterEffect10025ui_story = arg_90_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_0 = 0.2

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["10025ui_story"]) then
				if arg_90_1.var_.characterEffect10025ui_story and not isNil(arg_90_1.actors_["10025ui_story"]) then
					arg_90_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_90_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_90_1.time_ - 0) / var_93_0)
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["10025ui_story"]) and arg_90_1.var_.characterEffect10025ui_story then
				arg_90_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_90_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_93_1 = 0
			local var_93_2 = 0.475

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_3 = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(116111021).content)

				arg_90_1.text_.text = var_93_3

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_5 = 19 <= 0 and var_93_2 or var_93_2 * (utf8.len(var_93_3) / 19)

				if (19 <= 0 and var_93_2 or var_93_2 * (utf8.len(var_93_3) / 19)) > 0 and var_93_2 < var_93_5 then
					arg_90_1.talkMaxDuration = var_93_5

					if var_93_5 + var_93_1 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_5 + var_93_1
					end
				end

				arg_90_1.text_.text = var_93_3
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_6 = math.max(var_93_2, arg_90_1.talkMaxDuration)

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_6 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_1) / var_93_6

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_1 + var_93_6 and arg_90_1.time_ < var_93_1 + var_93_6 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play116111022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 116111022
		arg_94_1.duration_ = 3.97

		local var_94_0 = {
			zh = 3.333,
			ja = 3.966
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
				arg_94_0:Play116111023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["10025ui_story"]) and arg_94_1.var_.characterEffect10025ui_story == nil then
				arg_94_1.var_.characterEffect10025ui_story = arg_94_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_0 = 0.2

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 and not isNil(arg_94_1.actors_["10025ui_story"]) then
				if arg_94_1.var_.characterEffect10025ui_story and not isNil(arg_94_1.actors_["10025ui_story"]) then
					arg_94_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 and not isNil(arg_94_1.actors_["10025ui_story"]) and arg_94_1.var_.characterEffect10025ui_story then
				arg_94_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action6_2")
			end

			local var_97_2 = 0
			local var_97_3 = 0.3

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_2 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_4 = arg_94_1:GetWordFromCfg(116111022)
				local var_97_5 = arg_94_1:FormatText(var_97_4.content)

				arg_94_1.text_.text = var_97_5

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_7 = 12 <= 0 and var_97_3 or var_97_3 * (utf8.len(var_97_5) / 12)

				if (12 <= 0 and var_97_3 or var_97_3 * (utf8.len(var_97_5) / 12)) > 0 and var_97_3 < var_97_7 then
					arg_94_1.talkMaxDuration = var_97_7

					if var_97_7 + var_97_2 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_7 + var_97_2
					end
				end

				arg_94_1.text_.text = var_97_5
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116111", "116111022", "story_v_out_116111.awb") ~= 0 then
					local var_97_8 = manager.audio:GetVoiceLength("story_v_out_116111", "116111022", "story_v_out_116111.awb") / 1000

					if var_97_8 + var_97_2 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_8 + var_97_2
					end

					if var_97_4.prefab_name ~= "" and arg_94_1.actors_[var_97_4.prefab_name] ~= nil then
						local var_97_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_4.prefab_name].transform, "story_v_out_116111", "116111022", "story_v_out_116111.awb")

						arg_94_1:RecordAudio("116111022", var_97_9)
						arg_94_1:RecordAudio("116111022", var_97_9)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_116111", "116111022", "story_v_out_116111.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_116111", "116111022", "story_v_out_116111.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_10 = math.max(var_97_3, arg_94_1.talkMaxDuration)

			if var_97_2 <= arg_94_1.time_ and arg_94_1.time_ < var_97_2 + var_97_10 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_2) / var_97_10

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_2 + var_97_10 and arg_94_1.time_ < var_97_2 + var_97_10 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play116111023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 116111023
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play116111024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos10025ui_story = arg_98_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_101_0 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 then
				arg_98_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_98_1.time_ - 0) / var_101_0)
				arg_98_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_98_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["10025ui_story"].transform.position).z)
				arg_98_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_98_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_98_1.actors_["10025ui_story"].transform.localEulerAngles = arg_98_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 then
				arg_98_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_98_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_98_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["10025ui_story"].transform.position).z)
				arg_98_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_98_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_98_1.actors_["10025ui_story"].transform.localEulerAngles = arg_98_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			local var_101_1 = 0
			local var_101_2 = 1.075

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_3 = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(116111023).content)

				arg_98_1.text_.text = var_101_3

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_5 = 43 <= 0 and var_101_2 or var_101_2 * (utf8.len(var_101_3) / 43)

				if (43 <= 0 and var_101_2 or var_101_2 * (utf8.len(var_101_3) / 43)) > 0 and var_101_2 < var_101_5 then
					arg_98_1.talkMaxDuration = var_101_5

					if var_101_5 + var_101_1 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_5 + var_101_1
					end
				end

				arg_98_1.text_.text = var_101_3
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_6 = math.max(var_101_2, arg_98_1.talkMaxDuration)

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_6 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_1) / var_101_6

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_1 + var_101_6 and arg_98_1.time_ < var_101_1 + var_101_6 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play116111024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 116111024
		arg_102_1.duration_ = 5.03

		local var_102_0 = {
			zh = 5.033,
			ja = 2.966
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
				arg_102_0:Play116111025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos10025ui_story = arg_102_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_105_0 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 then
				arg_102_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_102_1.time_ - 0) / var_105_0)
				arg_102_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["10025ui_story"].transform.position).z)
				arg_102_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["10025ui_story"].transform.localEulerAngles = arg_102_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 then
				arg_102_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_102_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["10025ui_story"].transform.position).z)
				arg_102_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["10025ui_story"].transform.localEulerAngles = arg_102_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			local var_105_1 = arg_102_1.actors_["10025ui_story"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_1) and arg_102_1.var_.characterEffect10025ui_story == nil then
				arg_102_1.var_.characterEffect10025ui_story = var_105_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.2

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_2 and not isNil(var_105_1) then
				if arg_102_1.var_.characterEffect10025ui_story and not isNil(var_105_1) then
					arg_102_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= 0 + var_105_2 and arg_102_1.time_ < 0 + var_105_2 + arg_105_0 and not isNil(var_105_1) and arg_102_1.var_.characterEffect10025ui_story then
				arg_102_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action7_1")
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_105_4 = 0
			local var_105_5 = 0.4

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_4 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_6 = arg_102_1:GetWordFromCfg(116111024)
				local var_105_7 = arg_102_1:FormatText(var_105_6.content)

				arg_102_1.text_.text = var_105_7

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_9 = 16 <= 0 and var_105_5 or var_105_5 * (utf8.len(var_105_7) / 16)

				if (16 <= 0 and var_105_5 or var_105_5 * (utf8.len(var_105_7) / 16)) > 0 and var_105_5 < var_105_9 then
					arg_102_1.talkMaxDuration = var_105_9

					if var_105_9 + var_105_4 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_9 + var_105_4
					end
				end

				arg_102_1.text_.text = var_105_7
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116111", "116111024", "story_v_out_116111.awb") ~= 0 then
					local var_105_10 = manager.audio:GetVoiceLength("story_v_out_116111", "116111024", "story_v_out_116111.awb") / 1000

					if var_105_10 + var_105_4 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_10 + var_105_4
					end

					if var_105_6.prefab_name ~= "" and arg_102_1.actors_[var_105_6.prefab_name] ~= nil then
						local var_105_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_6.prefab_name].transform, "story_v_out_116111", "116111024", "story_v_out_116111.awb")

						arg_102_1:RecordAudio("116111024", var_105_11)
						arg_102_1:RecordAudio("116111024", var_105_11)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_116111", "116111024", "story_v_out_116111.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_116111", "116111024", "story_v_out_116111.awb")
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

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play116111025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 116111025
		arg_106_1.duration_ = 9

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play116111026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 1.966 < arg_106_1.time_ and arg_106_1.time_ <= 1.966 + arg_109_0 then
				arg_106_1.var_.moveOldPos10025ui_story = arg_106_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_109_0 = 0.001

			if 1.966 <= arg_106_1.time_ and arg_106_1.time_ < 1.966 + var_109_0 then
				arg_106_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_106_1.time_ - 1.966) / var_109_0)
				arg_106_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["10025ui_story"].transform.position).z)
				arg_106_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["10025ui_story"].transform.localEulerAngles = arg_106_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_106_1.time_ >= 1.966 + var_109_0 and arg_106_1.time_ < 1.966 + var_109_0 + arg_109_0 then
				arg_106_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_106_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["10025ui_story"].transform.position).z)
				arg_106_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["10025ui_story"].transform.localEulerAngles = arg_106_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			local var_109_1 = 0

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1.mask_.enabled = true
				arg_106_1.mask_.raycastTarget = true

				arg_106_1:SetGaussion(false)
			end

			local var_109_2 = 2

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 then
				local var_109_3 = Color.New(0, 0, 0)

				var_109_3.a = Mathf.Lerp(0, 1, (arg_106_1.time_ - var_109_1) / var_109_2)
				arg_106_1.mask_.color = var_109_3
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 then
				local var_109_4 = Color.New(0, 0, 0)

				var_109_4.a = 1
				arg_106_1.mask_.color = var_109_4
			end

			local var_109_5 = 2

			if 2 < arg_106_1.time_ and arg_106_1.time_ <= var_109_5 + arg_109_0 then
				arg_106_1.mask_.enabled = true
				arg_106_1.mask_.raycastTarget = true

				arg_106_1:SetGaussion(false)
			end

			local var_109_6 = 2

			if var_109_5 <= arg_106_1.time_ and arg_106_1.time_ < var_109_5 + var_109_6 then
				local var_109_7 = Color.New(0, 0, 0)

				var_109_7.a = Mathf.Lerp(1, 0, (arg_106_1.time_ - var_109_5) / var_109_6)
				arg_106_1.mask_.color = var_109_7
			end

			if arg_106_1.time_ >= var_109_5 + var_109_6 and arg_106_1.time_ < var_109_5 + var_109_6 + arg_109_0 then
				local var_109_8 = Color.New(0, 0, 0)

				arg_106_1.mask_.enabled = false
				var_109_8.a = 0
				arg_106_1.mask_.color = var_109_8
			end

			if 2 < arg_106_1.time_ and arg_106_1.time_ <= 2 + arg_109_0 then
				local var_109_9 = arg_106_1.bgs_.B13g

				arg_106_1.bgs_.B13g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_109_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_109_10 = var_109_9:GetComponent("SpriteRenderer")

				if var_109_10 and var_109_10.sprite then
					local var_109_11 = 2 * (var_109_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_109_9.transform.localScale = Vector3.New(var_109_11 / var_109_10.sprite.bounds.size.y < var_109_11 * manager.ui.mainCameraCom_.aspect / var_109_10.sprite.bounds.size.x and var_109_11 * manager.ui.mainCameraCom_.aspect / var_109_10.sprite.bounds.size.x or var_109_11 / var_109_10.sprite.bounds.size.y, var_109_11 / var_109_10.sprite.bounds.size.y < var_109_11 * manager.ui.mainCameraCom_.aspect / var_109_10.sprite.bounds.size.x and var_109_11 * manager.ui.mainCameraCom_.aspect / var_109_10.sprite.bounds.size.x or var_109_11 / var_109_10.sprite.bounds.size.y, 0)
				end

				for iter_109_0, iter_109_1 in pairs(arg_106_1.bgs_) do
					if iter_109_0 ~= "B13g" then
						iter_109_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_106_1.frameCnt_ <= 1 then
				arg_106_1.dialog_:SetActive(false)
			end

			local var_109_12 = 4
			local var_109_13 = 0.575

			if 4 < arg_106_1.time_ and arg_106_1.time_ <= var_109_12 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0

				arg_106_1.dialog_:SetActive(true)

				arg_106_1.dialogCg_.alpha = 0

				local var_109_14 = LeanTween.value(arg_106_1.dialog_, 0, 1, 0.3)

				var_109_14:setOnUpdate(LuaHelper.FloatAction(function(arg_110_0)
					arg_106_1.dialogCg_.alpha = arg_110_0
				end))
				var_109_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_106_1.dialog_)
					var_109_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_106_1.duration_ = arg_106_1.duration_ + 0.3

				SetActive(arg_106_1.leftNameGo_, false)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_15 = arg_106_1:FormatText(arg_106_1:GetWordFromCfg(116111025).content)

				arg_106_1.text_.text = var_109_15

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_17 = 23 <= 0 and var_109_13 or var_109_13 * (utf8.len(var_109_15) / 23)

				if (23 <= 0 and var_109_13 or var_109_13 * (utf8.len(var_109_15) / 23)) > 0 and var_109_13 < var_109_17 then
					arg_106_1.talkMaxDuration = var_109_17
					var_109_12 = var_109_12 + 0.3

					if var_109_17 + var_109_12 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_17 + var_109_12
					end
				end

				arg_106_1.text_.text = var_109_15
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_18 = var_109_12 + 0.3
			local var_109_19 = math.max(var_109_13, arg_106_1.talkMaxDuration)

			if var_109_12 + 0.3 <= arg_106_1.time_ and arg_106_1.time_ < var_109_18 + var_109_19 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_18) / var_109_19

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_18 + var_109_19 and arg_106_1.time_ < var_109_18 + var_109_19 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_106_1:InitPlayNodeList()
	end,
	Play116111026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 116111026
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play116111027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0.5

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_1 = arg_112_1:FormatText(arg_112_1:GetWordFromCfg(116111026).content)

				arg_112_1.text_.text = var_115_1

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_3 = 20 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_1) / 20)

				if (20 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_1) / 20)) > 0 and var_115_0 < var_115_3 then
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
	Play116111027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 116111027
		arg_116_1.duration_ = 4.57

		local var_116_0 = {
			zh = 4.4,
			ja = 4.566
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
				arg_116_0:Play116111028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0.425

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_1 = arg_116_1:GetWordFromCfg(116111027)
				local var_119_2 = arg_116_1:FormatText(var_119_1.content)

				arg_116_1.text_.text = var_119_2

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_4 = 17 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_2) / 17)

				if (17 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_2) / 17)) > 0 and var_119_0 < var_119_4 then
					arg_116_1.talkMaxDuration = var_119_4

					if var_119_4 + 0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_4 + 0
					end
				end

				arg_116_1.text_.text = var_119_2
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116111", "116111027", "story_v_out_116111.awb") ~= 0 then
					local var_119_5 = manager.audio:GetVoiceLength("story_v_out_116111", "116111027", "story_v_out_116111.awb") / 1000

					if var_119_5 + 0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_5 + 0
					end

					if var_119_1.prefab_name ~= "" and arg_116_1.actors_[var_119_1.prefab_name] ~= nil then
						local var_119_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_1.prefab_name].transform, "story_v_out_116111", "116111027", "story_v_out_116111.awb")

						arg_116_1:RecordAudio("116111027", var_119_6)
						arg_116_1:RecordAudio("116111027", var_119_6)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_116111", "116111027", "story_v_out_116111.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_116111", "116111027", "story_v_out_116111.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_7 = math.max(var_119_0, arg_116_1.talkMaxDuration)

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_7 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - 0) / var_119_7

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= 0 + var_119_7 and arg_116_1.time_ < 0 + var_119_7 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play116111028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 116111028
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play116111029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["10025ui_story"]) and arg_120_1.var_.characterEffect10025ui_story == nil then
				arg_120_1.var_.characterEffect10025ui_story = arg_120_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_0 = 0.2

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["10025ui_story"]) then
				if arg_120_1.var_.characterEffect10025ui_story and not isNil(arg_120_1.actors_["10025ui_story"]) then
					arg_120_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_120_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_120_1.time_ - 0) / var_123_0)
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["10025ui_story"]) and arg_120_1.var_.characterEffect10025ui_story then
				arg_120_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_120_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_123_1 = 0
			local var_123_2 = 0.85

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_3 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(116111028).content)

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
	Play116111029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 116111029
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play116111030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0.875

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_1 = arg_124_1:FormatText(arg_124_1:GetWordFromCfg(116111029).content)

				arg_124_1.text_.text = var_127_1

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_3 = 35 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_1) / 35)

				if (35 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_1) / 35)) > 0 and var_127_0 < var_127_3 then
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
	Play116111030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 116111030
		arg_128_1.duration_ = 5.4

		local var_128_0 = {
			zh = 4.366,
			ja = 5.4
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
				arg_128_0:Play116111031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0.4

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, true)
				arg_128_1.iconController_:SetSelectedState("hero")

				arg_128_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025")

				arg_128_1.callingController_:SetSelectedState("normal")

				arg_128_1.keyicon_.color = Color.New(1, 1, 1)
				arg_128_1.icon_.color = Color.New(1, 1, 1)

				local var_131_1 = arg_128_1:GetWordFromCfg(116111030)
				local var_131_2 = arg_128_1:FormatText(var_131_1.content)

				arg_128_1.text_.text = var_131_2

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_4 = 16 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_2) / 16)

				if (16 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_2) / 16)) > 0 and var_131_0 < var_131_4 then
					arg_128_1.talkMaxDuration = var_131_4

					if var_131_4 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_4 + 0
					end
				end

				arg_128_1.text_.text = var_131_2
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116111", "116111030", "story_v_out_116111.awb") ~= 0 then
					local var_131_5 = manager.audio:GetVoiceLength("story_v_out_116111", "116111030", "story_v_out_116111.awb") / 1000

					if var_131_5 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_5 + 0
					end

					if var_131_1.prefab_name ~= "" and arg_128_1.actors_[var_131_1.prefab_name] ~= nil then
						local var_131_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_1.prefab_name].transform, "story_v_out_116111", "116111030", "story_v_out_116111.awb")

						arg_128_1:RecordAudio("116111030", var_131_6)
						arg_128_1:RecordAudio("116111030", var_131_6)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_116111", "116111030", "story_v_out_116111.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_116111", "116111030", "story_v_out_116111.awb")
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
	Play116111031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 116111031
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play116111032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos10025ui_story = arg_132_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_135_0 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 then
				arg_132_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_132_1.time_ - 0) / var_135_0)
				arg_132_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["10025ui_story"].transform.position).z)
				arg_132_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["10025ui_story"].transform.localEulerAngles = arg_132_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 then
				arg_132_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_132_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["10025ui_story"].transform.position).z)
				arg_132_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["10025ui_story"].transform.localEulerAngles = arg_132_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			local var_135_1 = 0
			local var_135_2 = 1.575

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, false)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_3 = arg_132_1:FormatText(arg_132_1:GetWordFromCfg(116111031).content)

				arg_132_1.text_.text = var_135_3

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_5 = 63 <= 0 and var_135_2 or var_135_2 * (utf8.len(var_135_3) / 63)

				if (63 <= 0 and var_135_2 or var_135_2 * (utf8.len(var_135_3) / 63)) > 0 and var_135_2 < var_135_5 then
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

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play116111032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 116111032
		arg_136_1.duration_ = 9

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play116111033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if arg_136_1.bgs_.B13f == nil then
				local var_139_0 = Object.Instantiate(arg_136_1.paintGo_)

				var_139_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B13f")
				var_139_0.name = "B13f"
				var_139_0.transform.parent = arg_136_1.stage_.transform
				var_139_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_136_1.bgs_.B13f = var_139_0
			end

			if 2 < arg_136_1.time_ and arg_136_1.time_ <= 2 + arg_139_0 then
				local var_139_1 = arg_136_1.bgs_.B13f

				arg_136_1.bgs_.B13f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_139_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_139_2 = var_139_1:GetComponent("SpriteRenderer")

				if var_139_2 and var_139_2.sprite then
					local var_139_3 = 2 * (var_139_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_139_1.transform.localScale = Vector3.New(var_139_3 / var_139_2.sprite.bounds.size.y < var_139_3 * manager.ui.mainCameraCom_.aspect / var_139_2.sprite.bounds.size.x and var_139_3 * manager.ui.mainCameraCom_.aspect / var_139_2.sprite.bounds.size.x or var_139_3 / var_139_2.sprite.bounds.size.y, var_139_3 / var_139_2.sprite.bounds.size.y < var_139_3 * manager.ui.mainCameraCom_.aspect / var_139_2.sprite.bounds.size.x and var_139_3 * manager.ui.mainCameraCom_.aspect / var_139_2.sprite.bounds.size.x or var_139_3 / var_139_2.sprite.bounds.size.y, 0)
				end

				for iter_139_0, iter_139_1 in pairs(arg_136_1.bgs_) do
					if iter_139_0 ~= "B13f" then
						iter_139_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_139_4 = 0

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_4 + arg_139_0 then
				arg_136_1.mask_.enabled = true
				arg_136_1.mask_.raycastTarget = true

				arg_136_1:SetGaussion(false)
			end

			local var_139_5 = 2

			if var_139_4 <= arg_136_1.time_ and arg_136_1.time_ < var_139_4 + var_139_5 then
				local var_139_6 = Color.New(0, 0, 0)

				var_139_6.a = Mathf.Lerp(0, 1, (arg_136_1.time_ - var_139_4) / var_139_5)
				arg_136_1.mask_.color = var_139_6
			end

			if arg_136_1.time_ >= var_139_4 + var_139_5 and arg_136_1.time_ < var_139_4 + var_139_5 + arg_139_0 then
				local var_139_7 = Color.New(0, 0, 0)

				var_139_7.a = 1
				arg_136_1.mask_.color = var_139_7
			end

			local var_139_8 = 2

			if 2 < arg_136_1.time_ and arg_136_1.time_ <= var_139_8 + arg_139_0 then
				arg_136_1.mask_.enabled = true
				arg_136_1.mask_.raycastTarget = true

				arg_136_1:SetGaussion(false)
			end

			local var_139_9 = 2

			if var_139_8 <= arg_136_1.time_ and arg_136_1.time_ < var_139_8 + var_139_9 then
				local var_139_10 = Color.New(0, 0, 0)

				var_139_10.a = Mathf.Lerp(1, 0, (arg_136_1.time_ - var_139_8) / var_139_9)
				arg_136_1.mask_.color = var_139_10
			end

			if arg_136_1.time_ >= var_139_8 + var_139_9 and arg_136_1.time_ < var_139_8 + var_139_9 + arg_139_0 then
				local var_139_11 = Color.New(0, 0, 0)

				arg_136_1.mask_.enabled = false
				var_139_11.a = 0
				arg_136_1.mask_.color = var_139_11
			end

			if arg_136_1.frameCnt_ <= 1 then
				arg_136_1.dialog_:SetActive(false)
			end

			local var_139_12 = 4
			local var_139_13 = 0.225

			if 4 < arg_136_1.time_ and arg_136_1.time_ <= var_139_12 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0

				arg_136_1.dialog_:SetActive(true)

				arg_136_1.dialogCg_.alpha = 0

				local var_139_14 = LeanTween.value(arg_136_1.dialog_, 0, 1, 0.3)

				var_139_14:setOnUpdate(LuaHelper.FloatAction(function(arg_140_0)
					arg_136_1.dialogCg_.alpha = arg_140_0
				end))
				var_139_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_136_1.dialog_)
					var_139_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_136_1.duration_ = arg_136_1.duration_ + 0.3

				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_15 = arg_136_1:FormatText(arg_136_1:GetWordFromCfg(116111032).content)

				arg_136_1.text_.text = var_139_15

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_17 = 9 <= 0 and var_139_13 or var_139_13 * (utf8.len(var_139_15) / 9)

				if (9 <= 0 and var_139_13 or var_139_13 * (utf8.len(var_139_15) / 9)) > 0 and var_139_13 < var_139_17 then
					arg_136_1.talkMaxDuration = var_139_17
					var_139_12 = var_139_12 + 0.3

					if var_139_17 + var_139_12 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_17 + var_139_12
					end
				end

				arg_136_1.text_.text = var_139_15
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_18 = var_139_12 + 0.3
			local var_139_19 = math.max(var_139_13, arg_136_1.talkMaxDuration)

			if var_139_12 + 0.3 <= arg_136_1.time_ and arg_136_1.time_ < var_139_18 + var_139_19 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_18) / var_139_19

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_18 + var_139_19 and arg_136_1.time_ < var_139_18 + var_139_19 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play116111033 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 116111033
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play116111034(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0.75

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, false)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_1 = arg_142_1:FormatText(arg_142_1:GetWordFromCfg(116111033).content)

				arg_142_1.text_.text = var_145_1

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_3 = 30 <= 0 and var_145_0 or var_145_0 * (utf8.len(var_145_1) / 30)

				if (30 <= 0 and var_145_0 or var_145_0 * (utf8.len(var_145_1) / 30)) > 0 and var_145_0 < var_145_3 then
					arg_142_1.talkMaxDuration = var_145_3

					if var_145_3 + 0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_3 + 0
					end
				end

				arg_142_1.text_.text = var_145_1
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_4 = math.max(var_145_0, arg_142_1.talkMaxDuration)

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_4 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - 0) / var_145_4

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= 0 + var_145_4 and arg_142_1.time_ < 0 + var_145_4 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play116111034 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 116111034
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play116111035(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 1.25

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, false)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_1 = arg_146_1:FormatText(arg_146_1:GetWordFromCfg(116111034).content)

				arg_146_1.text_.text = var_149_1

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_3 = 50 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_1) / 50)

				if (50 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_1) / 50)) > 0 and var_149_0 < var_149_3 then
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
	Play116111035 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 116111035
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play116111036(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:AudioAction("play", "effect", "se_story_16", "se_story_16_beat", "")
			end

			local var_153_1 = 0
			local var_153_2 = 0.15

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, true)
				arg_150_1.iconController_:SetSelectedState("hero")

				arg_150_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_150_1.callingController_:SetSelectedState("normal")

				arg_150_1.keyicon_.color = Color.New(1, 1, 1)
				arg_150_1.icon_.color = Color.New(1, 1, 1)

				local var_153_3 = arg_150_1:FormatText(arg_150_1:GetWordFromCfg(116111035).content)

				arg_150_1.text_.text = var_153_3

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_5 = 6 <= 0 and var_153_2 or var_153_2 * (utf8.len(var_153_3) / 6)

				if (6 <= 0 and var_153_2 or var_153_2 * (utf8.len(var_153_3) / 6)) > 0 and var_153_2 < var_153_5 then
					arg_150_1.talkMaxDuration = var_153_5

					if var_153_5 + var_153_1 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_5 + var_153_1
					end
				end

				arg_150_1.text_.text = var_153_3
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_6 = math.max(var_153_2, arg_150_1.talkMaxDuration)

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_6 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_1) / var_153_6

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_1 + var_153_6 and arg_150_1.time_ < var_153_1 + var_153_6 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play116111036 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 116111036
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play116111037(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 0.525

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, false)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_1 = arg_154_1:FormatText(arg_154_1:GetWordFromCfg(116111036).content)

				arg_154_1.text_.text = var_157_1

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_3 = 21 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_1) / 21)

				if (21 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_1) / 21)) > 0 and var_157_0 < var_157_3 then
					arg_154_1.talkMaxDuration = var_157_3

					if var_157_3 + 0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_3 + 0
					end
				end

				arg_154_1.text_.text = var_157_1
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_4 = math.max(var_157_0, arg_154_1.talkMaxDuration)

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_4 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - 0) / var_157_4

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= 0 + var_157_4 and arg_154_1.time_ < 0 + var_157_4 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play116111037 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 116111037
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play116111038(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:AudioAction("play", "effect", "se_story_16", "se_story_16_beat", "")
			end

			local var_161_1 = 0
			local var_161_2 = 0.425

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_3 = arg_158_1:FormatText(arg_158_1:GetWordFromCfg(116111037).content)

				arg_158_1.text_.text = var_161_3

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_5 = 16 <= 0 and var_161_2 or var_161_2 * (utf8.len(var_161_3) / 16)

				if (16 <= 0 and var_161_2 or var_161_2 * (utf8.len(var_161_3) / 16)) > 0 and var_161_2 < var_161_5 then
					arg_158_1.talkMaxDuration = var_161_5

					if var_161_5 + var_161_1 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_5 + var_161_1
					end
				end

				arg_158_1.text_.text = var_161_3
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_6 = math.max(var_161_2, arg_158_1.talkMaxDuration)

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_6 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_1) / var_161_6

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_1 + var_161_6 and arg_158_1.time_ < var_161_1 + var_161_6 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play116111038 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 116111038
		arg_162_1.duration_ = 3.37

		local var_162_0 = {
			zh = 3.366,
			ja = 1.999999999999
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play116111039(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.var_.moveOldPos10025ui_story = arg_162_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_165_0 = 0.001

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_0 then
				arg_162_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_162_1.time_ - 0) / var_165_0)
				arg_162_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_162_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["10025ui_story"].transform.position).z)
				arg_162_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_162_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_162_1.actors_["10025ui_story"].transform.localEulerAngles = arg_162_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_162_1.time_ >= 0 + var_165_0 and arg_162_1.time_ < 0 + var_165_0 + arg_165_0 then
				arg_162_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_162_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_162_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["10025ui_story"].transform.position).z)
				arg_162_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_162_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_162_1.actors_["10025ui_story"].transform.localEulerAngles = arg_162_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			local var_165_1 = arg_162_1.actors_["10025ui_story"]

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(var_165_1) and arg_162_1.var_.characterEffect10025ui_story == nil then
				arg_162_1.var_.characterEffect10025ui_story = var_165_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_2 = 0.2

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_2 and not isNil(var_165_1) then
				if arg_162_1.var_.characterEffect10025ui_story and not isNil(var_165_1) then
					arg_162_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= 0 + var_165_2 and arg_162_1.time_ < 0 + var_165_2 + arg_165_0 and not isNil(var_165_1) and arg_162_1.var_.characterEffect10025ui_story then
				arg_162_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action1_1")
			end

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_165_4 = 0
			local var_165_5 = 0.25

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_4 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_6 = arg_162_1:GetWordFromCfg(116111038)
				local var_165_7 = arg_162_1:FormatText(var_165_6.content)

				arg_162_1.text_.text = var_165_7

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_9 = 10 <= 0 and var_165_5 or var_165_5 * (utf8.len(var_165_7) / 10)

				if (10 <= 0 and var_165_5 or var_165_5 * (utf8.len(var_165_7) / 10)) > 0 and var_165_5 < var_165_9 then
					arg_162_1.talkMaxDuration = var_165_9

					if var_165_9 + var_165_4 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_9 + var_165_4
					end
				end

				arg_162_1.text_.text = var_165_7
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116111", "116111038", "story_v_out_116111.awb") ~= 0 then
					local var_165_10 = manager.audio:GetVoiceLength("story_v_out_116111", "116111038", "story_v_out_116111.awb") / 1000

					if var_165_10 + var_165_4 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_10 + var_165_4
					end

					if var_165_6.prefab_name ~= "" and arg_162_1.actors_[var_165_6.prefab_name] ~= nil then
						local var_165_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_6.prefab_name].transform, "story_v_out_116111", "116111038", "story_v_out_116111.awb")

						arg_162_1:RecordAudio("116111038", var_165_11)
						arg_162_1:RecordAudio("116111038", var_165_11)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_116111", "116111038", "story_v_out_116111.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_116111", "116111038", "story_v_out_116111.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_12 = math.max(var_165_5, arg_162_1.talkMaxDuration)

			if var_165_4 <= arg_162_1.time_ and arg_162_1.time_ < var_165_4 + var_165_12 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_4) / var_165_12

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_4 + var_165_12 and arg_162_1.time_ < var_165_4 + var_165_12 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_162_1:InitPlayNodeList()
	end,
	Play116111039 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 116111039
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play116111040(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(arg_166_1.actors_["10025ui_story"]) and arg_166_1.var_.characterEffect10025ui_story == nil then
				arg_166_1.var_.characterEffect10025ui_story = arg_166_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_0 = 0.2

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 and not isNil(arg_166_1.actors_["10025ui_story"]) then
				if arg_166_1.var_.characterEffect10025ui_story and not isNil(arg_166_1.actors_["10025ui_story"]) then
					arg_166_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_166_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_166_1.time_ - 0) / var_169_0)
				end
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 and not isNil(arg_166_1.actors_["10025ui_story"]) and arg_166_1.var_.characterEffect10025ui_story then
				arg_166_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_166_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_169_1 = 0
			local var_169_2 = 0.25

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, true)
				arg_166_1.iconController_:SetSelectedState("hero")

				arg_166_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_166_1.callingController_:SetSelectedState("normal")

				arg_166_1.keyicon_.color = Color.New(1, 1, 1)
				arg_166_1.icon_.color = Color.New(1, 1, 1)

				local var_169_3 = arg_166_1:FormatText(arg_166_1:GetWordFromCfg(116111039).content)

				arg_166_1.text_.text = var_169_3

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_5 = 10 <= 0 and var_169_2 or var_169_2 * (utf8.len(var_169_3) / 10)

				if (10 <= 0 and var_169_2 or var_169_2 * (utf8.len(var_169_3) / 10)) > 0 and var_169_2 < var_169_5 then
					arg_166_1.talkMaxDuration = var_169_5

					if var_169_5 + var_169_1 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_5 + var_169_1
					end
				end

				arg_166_1.text_.text = var_169_3
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_6 = math.max(var_169_2, arg_166_1.talkMaxDuration)

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_6 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_1) / var_169_6

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_1 + var_169_6 and arg_166_1.time_ < var_169_1 + var_169_6 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play116111040 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 116111040
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play116111041(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:AudioAction("play", "effect", "se_story_16", "se_story_16_gun03", "")
			end

			local var_173_1 = arg_170_1.actors_["10025ui_story"].transform

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.var_.moveOldPos10025ui_story = var_173_1.localPosition
			end

			local var_173_2 = 0.001

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_2 then
				var_173_1.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_170_1.time_ - 0) / var_173_2)
				var_173_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_173_1.position).x, (manager.ui.mainCamera.transform.position - var_173_1.position).y, (manager.ui.mainCamera.transform.position - var_173_1.position).z)
				var_173_1.localEulerAngles.z = 0
				var_173_1.localEulerAngles.x = 0
				var_173_1.localEulerAngles = var_173_1.localEulerAngles
			end

			if arg_170_1.time_ >= 0 + var_173_2 and arg_170_1.time_ < 0 + var_173_2 + arg_173_0 then
				var_173_1.localPosition = Vector3.New(0, 100, 0)
				var_173_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_173_1.position).x, (manager.ui.mainCamera.transform.position - var_173_1.position).y, (manager.ui.mainCamera.transform.position - var_173_1.position).z)
				var_173_1.localEulerAngles.z = 0
				var_173_1.localEulerAngles.x = 0
				var_173_1.localEulerAngles = var_173_1.localEulerAngles
			end

			local var_173_3 = 0

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_3 + arg_173_0 then
				arg_170_1.var_.shakeOldPos = var_173_1.localPosition
			end

			local var_173_4 = 1

			if var_173_3 <= arg_170_1.time_ and arg_170_1.time_ < var_173_3 + var_173_4 then
				local var_173_5, var_173_6 = math.modf((arg_170_1.time_ - var_173_3) / 0)

				var_173_1.localPosition = Vector3.New(var_173_6 * 0, var_173_6 * 0, var_173_6 * 0) + arg_170_1.var_.shakeOldPos
			end

			if arg_170_1.time_ >= var_173_3 + var_173_4 and arg_170_1.time_ < var_173_3 + var_173_4 + arg_173_0 then
				var_173_1.localPosition = arg_170_1.var_.shakeOldPos
			end

			local var_173_7 = 0

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_7 + arg_173_0 then
				arg_170_1.allBtn_.enabled = false
			end

			if arg_170_1.time_ >= var_173_7 + 1 and arg_170_1.time_ < var_173_7 + 1 + arg_173_0 then
				arg_170_1.allBtn_.enabled = true
			end

			local var_173_8 = 0
			local var_173_9 = 0.925

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_8 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_10 = arg_170_1:FormatText(arg_170_1:GetWordFromCfg(116111040).content)

				arg_170_1.text_.text = var_173_10

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_12 = 49 <= 0 and var_173_9 or var_173_9 * (utf8.len(var_173_10) / 49)

				if (49 <= 0 and var_173_9 or var_173_9 * (utf8.len(var_173_10) / 49)) > 0 and var_173_9 < var_173_12 then
					arg_170_1.talkMaxDuration = var_173_12

					if var_173_12 + var_173_8 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_12 + var_173_8
					end
				end

				arg_170_1.text_.text = var_173_10
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_13 = math.max(var_173_9, arg_170_1.talkMaxDuration)

			if var_173_8 <= arg_170_1.time_ and arg_170_1.time_ < var_173_8 + var_173_13 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_8) / var_173_13

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_8 + var_173_13 and arg_170_1.time_ < var_173_8 + var_173_13 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_170_1:InitPlayNodeList()
	end,
	Play116111041 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 116111041
		arg_174_1.duration_ = 8

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play116111042(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if arg_174_1.bgs_.STwhite == nil then
				local var_177_0 = Object.Instantiate(arg_174_1.paintGo_)

				var_177_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STwhite")
				var_177_0.name = "STwhite"
				var_177_0.transform.parent = arg_174_1.stage_.transform
				var_177_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_174_1.bgs_.STwhite = var_177_0
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				local var_177_1 = arg_174_1.bgs_.STwhite

				arg_174_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_177_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_177_2 = var_177_1:GetComponent("SpriteRenderer")

				if var_177_2 and var_177_2.sprite then
					local var_177_3 = 2 * (var_177_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_177_1.transform.localScale = Vector3.New(var_177_3 / var_177_2.sprite.bounds.size.y < var_177_3 * manager.ui.mainCameraCom_.aspect / var_177_2.sprite.bounds.size.x and var_177_3 * manager.ui.mainCameraCom_.aspect / var_177_2.sprite.bounds.size.x or var_177_3 / var_177_2.sprite.bounds.size.y, var_177_3 / var_177_2.sprite.bounds.size.y < var_177_3 * manager.ui.mainCameraCom_.aspect / var_177_2.sprite.bounds.size.x and var_177_3 * manager.ui.mainCameraCom_.aspect / var_177_2.sprite.bounds.size.x or var_177_3 / var_177_2.sprite.bounds.size.y, 0)
				end

				for iter_177_0, iter_177_1 in pairs(arg_174_1.bgs_) do
					if iter_177_0 ~= "STwhite" then
						iter_177_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_177_4 = 0

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_4 + arg_177_0 then
				arg_174_1.mask_.enabled = true
				arg_174_1.mask_.raycastTarget = true

				arg_174_1:SetGaussion(false)
			end

			local var_177_5 = 3

			if var_177_4 <= arg_174_1.time_ and arg_174_1.time_ < var_177_4 + var_177_5 then
				local var_177_6 = Color.New(1, 1, 1)

				var_177_6.a = Mathf.Lerp(1, 0, (arg_174_1.time_ - var_177_4) / var_177_5)
				arg_174_1.mask_.color = var_177_6
			end

			if arg_174_1.time_ >= var_177_4 + var_177_5 and arg_174_1.time_ < var_177_4 + var_177_5 + arg_177_0 then
				local var_177_7 = Color.New(1, 1, 1)

				arg_174_1.mask_.enabled = false
				var_177_7.a = 0
				arg_174_1.mask_.color = var_177_7
			end

			if 3.399999999999 < arg_174_1.time_ and arg_174_1.time_ <= 3.399999999999 + arg_177_0 then
				arg_174_1:AudioAction("play", "effect", "se_story_16", "se_story_16_droplet_loop02", "")
			end

			local var_177_9 = arg_174_1.bgs_.STwhite.transform

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPosSTwhite = var_177_9.localPosition
				var_177_9.localScale = Vector3.New(12, 12, 12)
			end

			local var_177_10 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_10 then
				var_177_9.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPosSTwhite, Vector3.New(0, 0, 0), (arg_174_1.time_ - 0) / var_177_10)
			end

			if arg_174_1.time_ >= 0 + var_177_10 and arg_174_1.time_ < 0 + var_177_10 + arg_177_0 then
				var_177_9.localPosition = Vector3.New(0, 0, 0)
			end

			if arg_174_1.frameCnt_ <= 1 then
				arg_174_1.dialog_:SetActive(false)
			end

			local var_177_11 = 2.999999999999
			local var_177_12 = 0.4

			if 2.999999999999 < arg_174_1.time_ and arg_174_1.time_ <= var_177_11 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0

				arg_174_1.dialog_:SetActive(true)

				arg_174_1.dialogCg_.alpha = 0

				local var_177_13 = LeanTween.value(arg_174_1.dialog_, 0, 1, 0.3)

				var_177_13:setOnUpdate(LuaHelper.FloatAction(function(arg_178_0)
					arg_174_1.dialogCg_.alpha = arg_178_0
				end))
				var_177_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_174_1.dialog_)
					var_177_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_174_1.duration_ = arg_174_1.duration_ + 0.3

				SetActive(arg_174_1.leftNameGo_, false)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_14 = arg_174_1:FormatText(arg_174_1:GetWordFromCfg(116111041).content)

				arg_174_1.text_.text = var_177_14

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_16 = 16 <= 0 and var_177_12 or var_177_12 * (utf8.len(var_177_14) / 16)

				if (16 <= 0 and var_177_12 or var_177_12 * (utf8.len(var_177_14) / 16)) > 0 and var_177_12 < var_177_16 then
					arg_174_1.talkMaxDuration = var_177_16
					var_177_11 = var_177_11 + 0.3

					if var_177_16 + var_177_11 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_16 + var_177_11
					end
				end

				arg_174_1.text_.text = var_177_14
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_17 = var_177_11 + 0.3
			local var_177_18 = math.max(var_177_12, arg_174_1.talkMaxDuration)

			if var_177_11 + 0.3 <= arg_174_1.time_ and arg_174_1.time_ < var_177_17 + var_177_18 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_17) / var_177_18

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_17 + var_177_18 and arg_174_1.time_ < var_177_17 + var_177_18 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "STwhite",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play116111042 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 116111042
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play116111043(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = 0.825

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, false)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_1 = arg_180_1:FormatText(arg_180_1:GetWordFromCfg(116111042).content)

				arg_180_1.text_.text = var_183_1

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_3 = 33 <= 0 and var_183_0 or var_183_0 * (utf8.len(var_183_1) / 33)

				if (33 <= 0 and var_183_0 or var_183_0 * (utf8.len(var_183_1) / 33)) > 0 and var_183_0 < var_183_3 then
					arg_180_1.talkMaxDuration = var_183_3

					if var_183_3 + 0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_3 + 0
					end
				end

				arg_180_1.text_.text = var_183_1
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_4 = math.max(var_183_0, arg_180_1.talkMaxDuration)

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_4 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - 0) / var_183_4

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= 0 + var_183_4 and arg_180_1.time_ < 0 + var_183_4 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play116111043 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 116111043
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play116111044(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = 1.05

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, false)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_1 = arg_184_1:FormatText(arg_184_1:GetWordFromCfg(116111043).content)

				arg_184_1.text_.text = var_187_1

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_3 = 42 <= 0 and var_187_0 or var_187_0 * (utf8.len(var_187_1) / 42)

				if (42 <= 0 and var_187_0 or var_187_0 * (utf8.len(var_187_1) / 42)) > 0 and var_187_0 < var_187_3 then
					arg_184_1.talkMaxDuration = var_187_3

					if var_187_3 + 0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_3 + 0
					end
				end

				arg_184_1.text_.text = var_187_1
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_4 = math.max(var_187_0, arg_184_1.talkMaxDuration)

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_4 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - 0) / var_187_4

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= 0 + var_187_4 and arg_184_1.time_ < 0 + var_187_4 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play116111044 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 116111044
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play116111045(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 0.15

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, true)
				arg_188_1.iconController_:SetSelectedState("hero")

				arg_188_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_188_1.callingController_:SetSelectedState("normal")

				arg_188_1.keyicon_.color = Color.New(1, 1, 1)
				arg_188_1.icon_.color = Color.New(1, 1, 1)

				local var_191_1 = arg_188_1:FormatText(arg_188_1:GetWordFromCfg(116111044).content)

				arg_188_1.text_.text = var_191_1

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_3 = 6 <= 0 and var_191_0 or var_191_0 * (utf8.len(var_191_1) / 6)

				if (6 <= 0 and var_191_0 or var_191_0 * (utf8.len(var_191_1) / 6)) > 0 and var_191_0 < var_191_3 then
					arg_188_1.talkMaxDuration = var_191_3

					if var_191_3 + 0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_3 + 0
					end
				end

				arg_188_1.text_.text = var_191_1
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_4 = math.max(var_191_0, arg_188_1.talkMaxDuration)

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_4 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - 0) / var_191_4

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= 0 + var_191_4 and arg_188_1.time_ < 0 + var_191_4 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play116111045 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 116111045
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play116111046(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0.675

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, false)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_1 = arg_192_1:FormatText(arg_192_1:GetWordFromCfg(116111045).content)

				arg_192_1.text_.text = var_195_1

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_3 = 27 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_1) / 27)

				if (27 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_1) / 27)) > 0 and var_195_0 < var_195_3 then
					arg_192_1.talkMaxDuration = var_195_3

					if var_195_3 + 0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_3 + 0
					end
				end

				arg_192_1.text_.text = var_195_1
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_4 = math.max(var_195_0, arg_192_1.talkMaxDuration)

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_4 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - 0) / var_195_4

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= 0 + var_195_4 and arg_192_1.time_ < 0 + var_195_4 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play116111046 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 116111046
		arg_196_1.duration_ = 7

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play116111047(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if arg_196_1.bgs_.SK0101 == nil then
				local var_199_0 = Object.Instantiate(arg_196_1.paintGo_)

				var_199_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SK0101")
				var_199_0.name = "SK0101"
				var_199_0.transform.parent = arg_196_1.stage_.transform
				var_199_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_196_1.bgs_.SK0101 = var_199_0
			end

			local var_199_1 = arg_196_1.bgs_.SK0101.transform

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.var_.moveOldPosSK0101 = var_199_1.localPosition
			end

			local var_199_2 = 0.001

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_2 then
				var_199_1.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPosSK0101, Vector3.New(1.45, 1.5, 3.8), (arg_196_1.time_ - 0) / var_199_2)
			end

			if arg_196_1.time_ >= 0 + var_199_2 and arg_196_1.time_ < 0 + var_199_2 + arg_199_0 then
				var_199_1.localPosition = Vector3.New(1.45, 1.5, 3.8)
			end

			local var_199_3 = arg_196_1.bgs_.SK0101.transform

			if 0.0339999999999999 < arg_196_1.time_ and arg_196_1.time_ <= 0.0339999999999999 + arg_199_0 then
				arg_196_1.var_.moveOldPosSK0101 = var_199_3.localPosition
			end

			local var_199_4 = 5

			if 0.0339999999999999 <= arg_196_1.time_ and arg_196_1.time_ < 0.0339999999999999 + var_199_4 then
				var_199_3.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPosSK0101, Vector3.New(1.45, 0.7, 3.8), (arg_196_1.time_ - 0.0339999999999999) / var_199_4)
			end

			if arg_196_1.time_ >= 0.0339999999999999 + var_199_4 and arg_196_1.time_ < 0.0339999999999999 + var_199_4 + arg_199_0 then
				var_199_3.localPosition = Vector3.New(1.45, 0.7, 3.8)
			end

			local var_199_5 = 2

			if 2 < arg_196_1.time_ and arg_196_1.time_ <= var_199_5 + arg_199_0 then
				arg_196_1.allBtn_.enabled = false
			end

			if arg_196_1.time_ >= var_199_5 + 3.034 and arg_196_1.time_ < var_199_5 + 3.034 + arg_199_0 then
				arg_196_1.allBtn_.enabled = true
			end

			local var_199_6 = 0

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_6 + arg_199_0 then
				arg_196_1.mask_.enabled = true
				arg_196_1.mask_.raycastTarget = true

				arg_196_1:SetGaussion(false)
			end

			local var_199_7 = 2

			if var_199_6 <= arg_196_1.time_ and arg_196_1.time_ < var_199_6 + var_199_7 then
				local var_199_8 = Color.New(1, 1, 1)

				var_199_8.a = Mathf.Lerp(1, 0, (arg_196_1.time_ - var_199_6) / var_199_7)
				arg_196_1.mask_.color = var_199_8
			end

			if arg_196_1.time_ >= var_199_6 + var_199_7 and arg_196_1.time_ < var_199_6 + var_199_7 + arg_199_0 then
				local var_199_9 = Color.New(1, 1, 1)

				arg_196_1.mask_.enabled = false
				var_199_9.a = 0
				arg_196_1.mask_.color = var_199_9
			end

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				local var_199_10 = arg_196_1.bgs_.SK0101

				arg_196_1.bgs_.SK0101.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_199_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_199_11 = var_199_10:GetComponent("SpriteRenderer")

				if var_199_11 and var_199_11.sprite then
					local var_199_12 = 2 * (var_199_10.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_199_10.transform.localScale = Vector3.New(var_199_12 / var_199_11.sprite.bounds.size.y < var_199_12 * manager.ui.mainCameraCom_.aspect / var_199_11.sprite.bounds.size.x and var_199_12 * manager.ui.mainCameraCom_.aspect / var_199_11.sprite.bounds.size.x or var_199_12 / var_199_11.sprite.bounds.size.y, var_199_12 / var_199_11.sprite.bounds.size.y < var_199_12 * manager.ui.mainCameraCom_.aspect / var_199_11.sprite.bounds.size.x and var_199_12 * manager.ui.mainCameraCom_.aspect / var_199_11.sprite.bounds.size.x or var_199_12 / var_199_11.sprite.bounds.size.y, 0)
				end

				for iter_199_0, iter_199_1 in pairs(arg_196_1.bgs_) do
					if iter_199_0 ~= "SK0101" then
						iter_199_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_196_1.frameCnt_ <= 1 then
				arg_196_1.dialog_:SetActive(false)
			end

			local var_199_13 = 2
			local var_199_14 = 0.2

			if 2 < arg_196_1.time_ and arg_196_1.time_ <= var_199_13 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0

				arg_196_1.dialog_:SetActive(true)

				arg_196_1.dialogCg_.alpha = 0

				local var_199_15 = LeanTween.value(arg_196_1.dialog_, 0, 1, 0.3)

				var_199_15:setOnUpdate(LuaHelper.FloatAction(function(arg_200_0)
					arg_196_1.dialogCg_.alpha = arg_200_0
				end))
				var_199_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_196_1.dialog_)
					var_199_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_196_1.duration_ = arg_196_1.duration_ + 0.3

				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, true)
				arg_196_1.iconController_:SetSelectedState("hero")

				arg_196_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_196_1.callingController_:SetSelectedState("normal")

				arg_196_1.keyicon_.color = Color.New(1, 1, 1)
				arg_196_1.icon_.color = Color.New(1, 1, 1)

				local var_199_16 = arg_196_1:FormatText(arg_196_1:GetWordFromCfg(116111046).content)

				arg_196_1.text_.text = var_199_16

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_18 = 8 <= 0 and var_199_14 or var_199_14 * (utf8.len(var_199_16) / 8)

				if (8 <= 0 and var_199_14 or var_199_14 * (utf8.len(var_199_16) / 8)) > 0 and var_199_14 < var_199_18 then
					arg_196_1.talkMaxDuration = var_199_18
					var_199_13 = var_199_13 + 0.3

					if var_199_18 + var_199_13 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_18 + var_199_13
					end
				end

				arg_196_1.text_.text = var_199_16
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_19 = var_199_13 + 0.3
			local var_199_20 = math.max(var_199_14, arg_196_1.talkMaxDuration)

			if var_199_13 + 0.3 <= arg_196_1.time_ and arg_196_1.time_ < var_199_19 + var_199_20 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_19) / var_199_20

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_19 + var_199_20 and arg_196_1.time_ < var_199_19 + var_199_20 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SK0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5,
				className = "StoryMoveNode",
				startTime = 0.0339999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play116111047 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 116111047
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play116111048(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 0.7

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, false)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_1 = arg_202_1:FormatText(arg_202_1:GetWordFromCfg(116111047).content)

				arg_202_1.text_.text = var_205_1

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_3 = 28 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_1) / 28)

				if (28 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_1) / 28)) > 0 and var_205_0 < var_205_3 then
					arg_202_1.talkMaxDuration = var_205_3

					if var_205_3 + 0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_3 + 0
					end
				end

				arg_202_1.text_.text = var_205_1
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_4 = math.max(var_205_0, arg_202_1.talkMaxDuration)

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_4 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - 0) / var_205_4

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= 0 + var_205_4 and arg_202_1.time_ < 0 + var_205_4 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play116111048 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 116111048
		arg_206_1.duration_ = 11.83

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play116111049(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.allBtn_.enabled = false
			end

			if arg_206_1.time_ >= 0 + 10 and arg_206_1.time_ < 0 + 10 + arg_209_0 then
				arg_206_1.allBtn_.enabled = true
			end

			local var_209_0 = arg_206_1.bgs_.SK0101.transform

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPosSK0101 = var_209_0.localPosition
			end

			local var_209_1 = 10

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_1 then
				var_209_0.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPosSK0101, Vector3.New(1.45, 2.5, 3.8), (arg_206_1.time_ - 0) / var_209_1)
			end

			if arg_206_1.time_ >= 0 + var_209_1 and arg_206_1.time_ < 0 + var_209_1 + arg_209_0 then
				var_209_0.localPosition = Vector3.New(1.45, 2.5, 3.8)
			end

			local var_209_2 = 0
			local var_209_3 = 1.225

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_2 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, false)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_4 = arg_206_1:FormatText(arg_206_1:GetWordFromCfg(116111048).content)

				arg_206_1.text_.text = var_209_4

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_6 = 49 <= 0 and var_209_3 or var_209_3 * (utf8.len(var_209_4) / 49)

				if (49 <= 0 and var_209_3 or var_209_3 * (utf8.len(var_209_4) / 49)) > 0 and var_209_3 < var_209_6 then
					arg_206_1.talkMaxDuration = var_209_6

					if var_209_6 + var_209_2 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_6 + var_209_2
					end
				end

				arg_206_1.text_.text = var_209_4
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_7 = math.max(var_209_3, arg_206_1.talkMaxDuration)

			if var_209_2 <= arg_206_1.time_ and arg_206_1.time_ < var_209_2 + var_209_7 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_2) / var_209_7

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_2 + var_209_7 and arg_206_1.time_ < var_209_2 + var_209_7 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 10,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play116111049 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 116111049
		arg_210_1.duration_ = 5.23

		local var_210_0 = {
			zh = 3.033,
			ja = 5.233
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
				arg_210_0:Play116111050(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = 0.175

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, true)
				arg_210_1.iconController_:SetSelectedState("hero")

				arg_210_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025")

				arg_210_1.callingController_:SetSelectedState("normal")

				arg_210_1.keyicon_.color = Color.New(1, 1, 1)
				arg_210_1.icon_.color = Color.New(1, 1, 1)

				local var_213_1 = arg_210_1:GetWordFromCfg(116111049)
				local var_213_2 = arg_210_1:FormatText(var_213_1.content)

				arg_210_1.text_.text = var_213_2

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_4 = 7 <= 0 and var_213_0 or var_213_0 * (utf8.len(var_213_2) / 7)

				if (7 <= 0 and var_213_0 or var_213_0 * (utf8.len(var_213_2) / 7)) > 0 and var_213_0 < var_213_4 then
					arg_210_1.talkMaxDuration = var_213_4

					if var_213_4 + 0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_4 + 0
					end
				end

				arg_210_1.text_.text = var_213_2
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116111", "116111049", "story_v_out_116111.awb") ~= 0 then
					local var_213_5 = manager.audio:GetVoiceLength("story_v_out_116111", "116111049", "story_v_out_116111.awb") / 1000

					if var_213_5 + 0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_5 + 0
					end

					if var_213_1.prefab_name ~= "" and arg_210_1.actors_[var_213_1.prefab_name] ~= nil then
						local var_213_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_1.prefab_name].transform, "story_v_out_116111", "116111049", "story_v_out_116111.awb")

						arg_210_1:RecordAudio("116111049", var_213_6)
						arg_210_1:RecordAudio("116111049", var_213_6)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_116111", "116111049", "story_v_out_116111.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_116111", "116111049", "story_v_out_116111.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_7 = math.max(var_213_0, arg_210_1.talkMaxDuration)

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_7 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - 0) / var_213_7

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= 0 + var_213_7 and arg_210_1.time_ < 0 + var_213_7 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play116111050 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 116111050
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play116111051(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0.375

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, false)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_1 = arg_214_1:FormatText(arg_214_1:GetWordFromCfg(116111050).content)

				arg_214_1.text_.text = var_217_1

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_3 = 15 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_1) / 15)

				if (15 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_1) / 15)) > 0 and var_217_0 < var_217_3 then
					arg_214_1.talkMaxDuration = var_217_3

					if var_217_3 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_3 + 0
					end
				end

				arg_214_1.text_.text = var_217_1
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_4 = math.max(var_217_0, arg_214_1.talkMaxDuration)

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_4 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - 0) / var_217_4

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= 0 + var_217_4 and arg_214_1.time_ < 0 + var_217_4 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play116111051 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 116111051
		arg_218_1.duration_ = 7.03

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play116111052(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 2 < arg_218_1.time_ and arg_218_1.time_ <= 2 + arg_221_0 then
				local var_221_0 = arg_218_1.bgs_.SK0101

				arg_218_1.bgs_.SK0101.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_221_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_221_1 = var_221_0:GetComponent("SpriteRenderer")

				if var_221_1 and var_221_1.sprite then
					local var_221_2 = 2 * (var_221_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_221_0.transform.localScale = Vector3.New(var_221_2 / var_221_1.sprite.bounds.size.y < var_221_2 * manager.ui.mainCameraCom_.aspect / var_221_1.sprite.bounds.size.x and var_221_2 * manager.ui.mainCameraCom_.aspect / var_221_1.sprite.bounds.size.x or var_221_2 / var_221_1.sprite.bounds.size.y, var_221_2 / var_221_1.sprite.bounds.size.y < var_221_2 * manager.ui.mainCameraCom_.aspect / var_221_1.sprite.bounds.size.x and var_221_2 * manager.ui.mainCameraCom_.aspect / var_221_1.sprite.bounds.size.x or var_221_2 / var_221_1.sprite.bounds.size.y, 0)
				end

				for iter_221_0, iter_221_1 in pairs(arg_218_1.bgs_) do
					if iter_221_0 ~= "SK0101" then
						iter_221_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_221_3 = 0

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_3 + arg_221_0 then
				arg_218_1.mask_.enabled = true
				arg_218_1.mask_.raycastTarget = true

				arg_218_1:SetGaussion(false)
			end

			local var_221_4 = 2

			if var_221_3 <= arg_218_1.time_ and arg_218_1.time_ < var_221_3 + var_221_4 then
				local var_221_5 = Color.New(0, 0, 0)

				var_221_5.a = Mathf.Lerp(0, 1, (arg_218_1.time_ - var_221_3) / var_221_4)
				arg_218_1.mask_.color = var_221_5
			end

			if arg_218_1.time_ >= var_221_3 + var_221_4 and arg_218_1.time_ < var_221_3 + var_221_4 + arg_221_0 then
				local var_221_6 = Color.New(0, 0, 0)

				var_221_6.a = 1
				arg_218_1.mask_.color = var_221_6
			end

			local var_221_7 = 2

			if 2 < arg_218_1.time_ and arg_218_1.time_ <= var_221_7 + arg_221_0 then
				arg_218_1.mask_.enabled = true
				arg_218_1.mask_.raycastTarget = true

				arg_218_1:SetGaussion(false)
			end

			local var_221_8 = 2

			if var_221_7 <= arg_218_1.time_ and arg_218_1.time_ < var_221_7 + var_221_8 then
				local var_221_9 = Color.New(0, 0, 0)

				var_221_9.a = Mathf.Lerp(1, 0, (arg_218_1.time_ - var_221_7) / var_221_8)
				arg_218_1.mask_.color = var_221_9
			end

			if arg_218_1.time_ >= var_221_7 + var_221_8 and arg_218_1.time_ < var_221_7 + var_221_8 + arg_221_0 then
				local var_221_10 = Color.New(0, 0, 0)

				arg_218_1.mask_.enabled = false
				var_221_10.a = 0
				arg_218_1.mask_.color = var_221_10
			end

			local var_221_11 = arg_218_1.bgs_.SK0101.transform

			if 2 < arg_218_1.time_ and arg_218_1.time_ <= 2 + arg_221_0 then
				arg_218_1.var_.moveOldPosSK0101 = var_221_11.localPosition
			end

			local var_221_12 = 0.001

			if 2 <= arg_218_1.time_ and arg_218_1.time_ < 2 + var_221_12 then
				var_221_11.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPosSK0101, Vector3.New(0, 1, 10), (arg_218_1.time_ - 2) / var_221_12)
			end

			if arg_218_1.time_ >= 2 + var_221_12 and arg_218_1.time_ < 2 + var_221_12 + arg_221_0 then
				var_221_11.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_218_1.frameCnt_ <= 1 then
				arg_218_1.dialog_:SetActive(false)
			end

			local var_221_13 = 2.034
			local var_221_14 = 0.95

			if 2.034 < arg_218_1.time_ and arg_218_1.time_ <= var_221_13 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0

				arg_218_1.dialog_:SetActive(true)

				arg_218_1.dialogCg_.alpha = 0

				local var_221_15 = LeanTween.value(arg_218_1.dialog_, 0, 1, 0.3)

				var_221_15:setOnUpdate(LuaHelper.FloatAction(function(arg_222_0)
					arg_218_1.dialogCg_.alpha = arg_222_0
				end))
				var_221_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_218_1.dialog_)
					var_221_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_218_1.duration_ = arg_218_1.duration_ + 0.3

				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_16 = arg_218_1:FormatText(arg_218_1:GetWordFromCfg(116111051).content)

				arg_218_1.text_.text = var_221_16

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_18 = 38 <= 0 and var_221_14 or var_221_14 * (utf8.len(var_221_16) / 38)

				if (38 <= 0 and var_221_14 or var_221_14 * (utf8.len(var_221_16) / 38)) > 0 and var_221_14 < var_221_18 then
					arg_218_1.talkMaxDuration = var_221_18
					var_221_13 = var_221_13 + 0.3

					if var_221_18 + var_221_13 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_18 + var_221_13
					end
				end

				arg_218_1.text_.text = var_221_16
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_19 = var_221_13 + 0.3
			local var_221_20 = math.max(var_221_14, arg_218_1.talkMaxDuration)

			if var_221_13 + 0.3 <= arg_218_1.time_ and arg_218_1.time_ < var_221_19 + var_221_20 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_19) / var_221_20

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_19 + var_221_20 and arg_218_1.time_ < var_221_19 + var_221_20 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play116111052 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 116111052
		arg_224_1.duration_ = 5

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play116111053(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = 0.125

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, false)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_1 = arg_224_1:FormatText(arg_224_1:GetWordFromCfg(116111052).content)

				arg_224_1.text_.text = var_227_1

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_3 = 5 <= 0 and var_227_0 or var_227_0 * (utf8.len(var_227_1) / 5)

				if (5 <= 0 and var_227_0 or var_227_0 * (utf8.len(var_227_1) / 5)) > 0 and var_227_0 < var_227_3 then
					arg_224_1.talkMaxDuration = var_227_3

					if var_227_3 + 0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_3 + 0
					end
				end

				arg_224_1.text_.text = var_227_1
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)
				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_4 = math.max(var_227_0, arg_224_1.talkMaxDuration)

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_4 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - 0) / var_227_4

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= 0 + var_227_4 and arg_224_1.time_ < 0 + var_227_4 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play116111053 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 116111053
		arg_228_1.duration_ = 5

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play116111054(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = 0.125

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, false)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_1 = arg_228_1:FormatText(arg_228_1:GetWordFromCfg(116111053).content)

				arg_228_1.text_.text = var_231_1

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_3 = 5 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_1) / 5)

				if (5 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_1) / 5)) > 0 and var_231_0 < var_231_3 then
					arg_228_1.talkMaxDuration = var_231_3

					if var_231_3 + 0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_3 + 0
					end
				end

				arg_228_1.text_.text = var_231_1
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)
				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_4 = math.max(var_231_0, arg_228_1.talkMaxDuration)

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_4 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - 0) / var_231_4

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= 0 + var_231_4 and arg_228_1.time_ < 0 + var_231_4 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play116111054 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 116111054
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play116111055(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = 0.375

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, true)
				arg_232_1.iconController_:SetSelectedState("hero")

				arg_232_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_232_1.callingController_:SetSelectedState("normal")

				arg_232_1.keyicon_.color = Color.New(1, 1, 1)
				arg_232_1.icon_.color = Color.New(1, 1, 1)

				local var_235_1 = arg_232_1:FormatText(arg_232_1:GetWordFromCfg(116111054).content)

				arg_232_1.text_.text = var_235_1

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_3 = 15 <= 0 and var_235_0 or var_235_0 * (utf8.len(var_235_1) / 15)

				if (15 <= 0 and var_235_0 or var_235_0 * (utf8.len(var_235_1) / 15)) > 0 and var_235_0 < var_235_3 then
					arg_232_1.talkMaxDuration = var_235_3

					if var_235_3 + 0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_3 + 0
					end
				end

				arg_232_1.text_.text = var_235_1
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_4 = math.max(var_235_0, arg_232_1.talkMaxDuration)

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_4 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - 0) / var_235_4

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= 0 + var_235_4 and arg_232_1.time_ < 0 + var_235_4 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play116111055 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 116111055
		arg_236_1.duration_ = 2.67

		local var_236_0 = {
			zh = 2.3,
			ja = 2.666
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
				arg_236_0:Play116111056(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 0.1

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, true)
				arg_236_1.iconController_:SetSelectedState("hero")

				arg_236_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025")

				arg_236_1.callingController_:SetSelectedState("normal")

				arg_236_1.keyicon_.color = Color.New(1, 1, 1)
				arg_236_1.icon_.color = Color.New(1, 1, 1)

				local var_239_1 = arg_236_1:GetWordFromCfg(116111055)
				local var_239_2 = arg_236_1:FormatText(var_239_1.content)

				arg_236_1.text_.text = var_239_2

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_4 = 4 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_2) / 4)

				if (4 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_2) / 4)) > 0 and var_239_0 < var_239_4 then
					arg_236_1.talkMaxDuration = var_239_4

					if var_239_4 + 0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_4 + 0
					end
				end

				arg_236_1.text_.text = var_239_2
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116111", "116111055", "story_v_out_116111.awb") ~= 0 then
					local var_239_5 = manager.audio:GetVoiceLength("story_v_out_116111", "116111055", "story_v_out_116111.awb") / 1000

					if var_239_5 + 0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_5 + 0
					end

					if var_239_1.prefab_name ~= "" and arg_236_1.actors_[var_239_1.prefab_name] ~= nil then
						local var_239_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_1.prefab_name].transform, "story_v_out_116111", "116111055", "story_v_out_116111.awb")

						arg_236_1:RecordAudio("116111055", var_239_6)
						arg_236_1:RecordAudio("116111055", var_239_6)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_116111", "116111055", "story_v_out_116111.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_116111", "116111055", "story_v_out_116111.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_7 = math.max(var_239_0, arg_236_1.talkMaxDuration)

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_7 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - 0) / var_239_7

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= 0 + var_239_7 and arg_236_1.time_ < 0 + var_239_7 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play116111056 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 116111056
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play116111057(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0.4

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, true)
				arg_240_1.iconController_:SetSelectedState("hero")

				arg_240_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_240_1.callingController_:SetSelectedState("normal")

				arg_240_1.keyicon_.color = Color.New(1, 1, 1)
				arg_240_1.icon_.color = Color.New(1, 1, 1)

				local var_243_1 = arg_240_1:FormatText(arg_240_1:GetWordFromCfg(116111056).content)

				arg_240_1.text_.text = var_243_1

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_3 = 16 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_1) / 16)

				if (16 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_1) / 16)) > 0 and var_243_0 < var_243_3 then
					arg_240_1.talkMaxDuration = var_243_3

					if var_243_3 + 0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_3 + 0
					end
				end

				arg_240_1.text_.text = var_243_1
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_4 = math.max(var_243_0, arg_240_1.talkMaxDuration)

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_4 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - 0) / var_243_4

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= 0 + var_243_4 and arg_240_1.time_ < 0 + var_243_4 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play116111057 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 116111057
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play116111058(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 0.85

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, false)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_1 = arg_244_1:FormatText(arg_244_1:GetWordFromCfg(116111057).content)

				arg_244_1.text_.text = var_247_1

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_3 = 34 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_1) / 34)

				if (34 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_1) / 34)) > 0 and var_247_0 < var_247_3 then
					arg_244_1.talkMaxDuration = var_247_3

					if var_247_3 + 0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_3 + 0
					end
				end

				arg_244_1.text_.text = var_247_1
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_4 = math.max(var_247_0, arg_244_1.talkMaxDuration)

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_4 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - 0) / var_247_4

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= 0 + var_247_4 and arg_244_1.time_ < 0 + var_247_4 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play116111058 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 116111058
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play116111059(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0.375

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, true)
				arg_248_1.iconController_:SetSelectedState("hero")

				arg_248_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_248_1.callingController_:SetSelectedState("normal")

				arg_248_1.keyicon_.color = Color.New(1, 1, 1)
				arg_248_1.icon_.color = Color.New(1, 1, 1)

				local var_251_1 = arg_248_1:FormatText(arg_248_1:GetWordFromCfg(116111058).content)

				arg_248_1.text_.text = var_251_1

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_3 = 15 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_1) / 15)

				if (15 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_1) / 15)) > 0 and var_251_0 < var_251_3 then
					arg_248_1.talkMaxDuration = var_251_3

					if var_251_3 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_3 + 0
					end
				end

				arg_248_1.text_.text = var_251_1
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_4 = math.max(var_251_0, arg_248_1.talkMaxDuration)

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_4 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - 0) / var_251_4

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= 0 + var_251_4 and arg_248_1.time_ < 0 + var_251_4 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play116111059 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 116111059
		arg_252_1.duration_ = 5.33

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play116111060(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1:AudioAction("stop", "music", " se_story_16", "se_story_16_droplet_loop02", "")

				local var_255_2 = manager.audio:GetAudioName(" se_story_16", "se_story_16_droplet_loop02")

				if "" ~= "" then
					if arg_252_1.bgmTxt_.text ~= var_255_2 and arg_252_1.bgmTxt_.text ~= "" then
						if arg_252_1.bgmTxt2_.text ~= "" then
							arg_252_1.bgmTxt_.text = arg_252_1.bgmTxt2_.text
						end

						arg_252_1.bgmTxt2_.text = var_255_2

						arg_252_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_252_1.bgmTxt_.text = var_255_2
						arg_252_1.bgmTxt2_.text = var_255_2
					end

					if arg_252_1.bgmTimer then
						arg_252_1.bgmTimer:Stop()

						arg_252_1.bgmTimer = nil
					end

					if arg_252_1.settingData.show_music_name == 1 then
						arg_252_1.musicController:SetSelectedState("show")
						arg_252_1.musicAnimator_:Play("open", 0, 0)

						if arg_252_1.settingData.music_time ~= 0 then
							arg_252_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_252_1.settingData.music_time), function()
								if arg_252_1 == nil or isNil(arg_252_1.bgmTxt_) then
									return
								end

								arg_252_1.musicController:SetSelectedState("hide")
								arg_252_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1:AudioAction("play", "effect", "se_story_16", "se_story_16_foot03", "")
			end

			if 2 < arg_252_1.time_ and arg_252_1.time_ <= 2 + arg_255_0 then
				arg_252_1.fswbg_:SetActive(true)
				arg_252_1.dialog_:SetActive(false)

				arg_252_1.fswtw_.percent = 0
				arg_252_1.fswt_.text = arg_252_1:FormatText(arg_252_1:GetWordFromCfg(116111059).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.fswt_)

				arg_252_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_252_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_252_1.fswtw_:SetDirty()

				arg_252_1.typewritterCharCountI18N = 0

				SetActive(arg_252_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_252_1:ShowNextGo(false)
			end

			local var_255_4 = 2.01666666666667

			if 2.01666666666667 < arg_252_1.time_ and arg_252_1.time_ <= var_255_4 + arg_255_0 then
				arg_252_1.var_.oldValueTypewriter = arg_252_1.fswtw_.percent

				SetActive(arg_252_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_252_1:ShowNextGo(false)
			end

			local var_255_5 = 33
			local var_255_6 = 2.2
			local var_255_7, var_255_8 = arg_252_1:GetPercentByPara(arg_252_1:FormatText(arg_252_1:GetWordFromCfg(116111059).content), 1)

			if var_255_4 < arg_252_1.time_ and arg_252_1.time_ <= var_255_4 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0

				local var_255_9 = var_255_5 <= 0 and var_255_6 or var_255_6 * ((var_255_8 - arg_252_1.typewritterCharCountI18N) / var_255_5)

				if (var_255_5 <= 0 and var_255_6 or var_255_6 * ((var_255_8 - arg_252_1.typewritterCharCountI18N) / var_255_5)) > 0 and var_255_6 < var_255_9 then
					arg_252_1.talkMaxDuration = var_255_9

					if var_255_9 + var_255_4 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_9 + var_255_4
					end
				end
			end

			local var_255_10 = math.max(2.2, arg_252_1.talkMaxDuration)

			if var_255_4 <= arg_252_1.time_ and arg_252_1.time_ < var_255_4 + var_255_10 then
				arg_252_1.fswtw_.percent = Mathf.Lerp(arg_252_1.var_.oldValueTypewriter, var_255_7, (arg_252_1.time_ - var_255_4) / var_255_10)
				arg_252_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_252_1.fswtw_:SetDirty()
			end

			if arg_252_1.time_ >= var_255_4 + var_255_10 and arg_252_1.time_ < var_255_4 + var_255_10 + arg_255_0 then
				arg_252_1.fswtw_.percent = var_255_7

				arg_252_1.fswtw_:SetDirty()
				arg_252_1:ShowNextGo(true)

				arg_252_1.typewritterCharCountI18N = var_255_8
			end

			local var_255_11 = 0

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_11 + arg_255_0 then
				arg_252_1.mask_.enabled = true
				arg_252_1.mask_.raycastTarget = true

				arg_252_1:SetGaussion(false)
			end

			local var_255_12 = 2

			if var_255_11 <= arg_252_1.time_ and arg_252_1.time_ < var_255_11 + var_255_12 then
				local var_255_13 = Color.New(0, 0, 0)

				var_255_13.a = Mathf.Lerp(0, 1, (arg_252_1.time_ - var_255_11) / var_255_12)
				arg_252_1.mask_.color = var_255_13
			end

			if arg_252_1.time_ >= var_255_11 + var_255_12 and arg_252_1.time_ < var_255_11 + var_255_12 + arg_255_0 then
				local var_255_14 = Color.New(0, 0, 0)

				var_255_14.a = 1
				arg_252_1.mask_.color = var_255_14
			end

			local var_255_15 = 2

			if 2 < arg_252_1.time_ and arg_252_1.time_ <= var_255_15 + arg_255_0 then
				arg_252_1.mask_.enabled = true
				arg_252_1.mask_.raycastTarget = true

				arg_252_1:SetGaussion(false)
			end

			local var_255_16 = 2

			if var_255_15 <= arg_252_1.time_ and arg_252_1.time_ < var_255_15 + var_255_16 then
				local var_255_17 = Color.New(0, 0, 0)

				var_255_17.a = Mathf.Lerp(1, 0, (arg_252_1.time_ - var_255_15) / var_255_16)
				arg_252_1.mask_.color = var_255_17
			end

			if arg_252_1.time_ >= var_255_15 + var_255_16 and arg_252_1.time_ < var_255_15 + var_255_16 + arg_255_0 then
				local var_255_18 = Color.New(0, 0, 0)

				arg_252_1.mask_.enabled = false
				var_255_18.a = 0
				arg_252_1.mask_.color = var_255_18
			end

			local var_255_19 = "STblack"

			if arg_252_1.bgs_.STblack == nil then
				local var_255_20 = Object.Instantiate(arg_252_1.paintGo_)

				var_255_20:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_255_19)
				var_255_20.name = var_255_19
				var_255_20.transform.parent = arg_252_1.stage_.transform
				var_255_20.transform.localPosition = Vector3.New(0, 100, 0)
				arg_252_1.bgs_[var_255_19] = var_255_20
			end

			if 2 < arg_252_1.time_ and arg_252_1.time_ <= 2 + arg_255_0 then
				local var_255_21 = arg_252_1.bgs_.STblack

				arg_252_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_255_21.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_255_22 = var_255_21:GetComponent("SpriteRenderer")

				if var_255_22 and var_255_22.sprite then
					local var_255_23 = 2 * (var_255_21.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_255_21.transform.localScale = Vector3.New(var_255_23 / var_255_22.sprite.bounds.size.y < var_255_23 * manager.ui.mainCameraCom_.aspect / var_255_22.sprite.bounds.size.x and var_255_23 * manager.ui.mainCameraCom_.aspect / var_255_22.sprite.bounds.size.x or var_255_23 / var_255_22.sprite.bounds.size.y, var_255_23 / var_255_22.sprite.bounds.size.y < var_255_23 * manager.ui.mainCameraCom_.aspect / var_255_22.sprite.bounds.size.x and var_255_23 * manager.ui.mainCameraCom_.aspect / var_255_22.sprite.bounds.size.x or var_255_23 / var_255_22.sprite.bounds.size.y, 0)
				end

				for iter_255_0, iter_255_1 in pairs(arg_252_1.bgs_) do
					if iter_255_0 ~= "STblack" then
						iter_255_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 2 < arg_252_1.time_ and arg_252_1.time_ <= 2 + arg_255_0 then
				local var_255_24 = arg_252_1.fswbg_.transform:Find("textbox/adapt/content") or arg_252_1.fswbg_.transform:Find("textbox/content")
				local var_255_25 = arg_252_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_255_26 = var_255_24:GetComponent("RectTransform")

				var_255_24:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_255_26.offsetMin = Vector2.New(0, 0)
				var_255_26.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play116111060 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 116111060
		arg_257_1.duration_ = 3.55

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play116111061(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.fswbg_:SetActive(true)
				arg_257_1.dialog_:SetActive(false)

				arg_257_1.fswtw_.percent = 0
				arg_257_1.fswt_.text = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(116111060).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.fswt_)

				arg_257_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_257_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_257_1.fswtw_:SetDirty()

				arg_257_1.typewritterCharCountI18N = 0

				SetActive(arg_257_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_257_1:ShowNextGo(false)
			end

			local var_260_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1.var_.oldValueTypewriter = arg_257_1.fswtw_.percent

				SetActive(arg_257_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_257_1:ShowNextGo(false)
			end

			local var_260_1 = 53
			local var_260_2 = 3.53333333333333
			local var_260_3, var_260_4 = arg_257_1:GetPercentByPara(arg_257_1:FormatText(arg_257_1:GetWordFromCfg(116111060).content), 1)

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0

				local var_260_5 = var_260_1 <= 0 and var_260_2 or var_260_2 * ((var_260_4 - arg_257_1.typewritterCharCountI18N) / var_260_1)

				if (var_260_1 <= 0 and var_260_2 or var_260_2 * ((var_260_4 - arg_257_1.typewritterCharCountI18N) / var_260_1)) > 0 and var_260_2 < var_260_5 then
					arg_257_1.talkMaxDuration = var_260_5

					if var_260_5 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_5 + var_260_0
					end
				end
			end

			local var_260_6 = math.max(3.53333333333333, arg_257_1.talkMaxDuration)

			if var_260_0 <= arg_257_1.time_ and arg_257_1.time_ < var_260_0 + var_260_6 then
				arg_257_1.fswtw_.percent = Mathf.Lerp(arg_257_1.var_.oldValueTypewriter, var_260_3, (arg_257_1.time_ - var_260_0) / var_260_6)
				arg_257_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_257_1.fswtw_:SetDirty()
			end

			if arg_257_1.time_ >= var_260_0 + var_260_6 and arg_257_1.time_ < var_260_0 + var_260_6 + arg_260_0 then
				arg_257_1.fswtw_.percent = var_260_3

				arg_257_1.fswtw_:SetDirty()
				arg_257_1:ShowNextGo(true)

				arg_257_1.typewritterCharCountI18N = var_260_4
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play116111061 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 116111061
		arg_261_1.duration_ = 1.55

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play116111062(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.fswbg_:SetActive(true)
				arg_261_1.dialog_:SetActive(false)

				arg_261_1.fswtw_.percent = 0
				arg_261_1.fswt_.text = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(116111061).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.fswt_)

				arg_261_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_261_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_261_1.fswtw_:SetDirty()

				arg_261_1.typewritterCharCountI18N = 0

				SetActive(arg_261_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_261_1:ShowNextGo(false)
			end

			local var_264_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				arg_261_1.var_.oldValueTypewriter = arg_261_1.fswtw_.percent

				SetActive(arg_261_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_261_1:ShowNextGo(false)
			end

			local var_264_1 = 23
			local var_264_2 = 1.53333333333333
			local var_264_3, var_264_4 = arg_261_1:GetPercentByPara(arg_261_1:FormatText(arg_261_1:GetWordFromCfg(116111061).content), 1)

			if var_264_0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0

				local var_264_5 = var_264_1 <= 0 and var_264_2 or var_264_2 * ((var_264_4 - arg_261_1.typewritterCharCountI18N) / var_264_1)

				if (var_264_1 <= 0 and var_264_2 or var_264_2 * ((var_264_4 - arg_261_1.typewritterCharCountI18N) / var_264_1)) > 0 and var_264_2 < var_264_5 then
					arg_261_1.talkMaxDuration = var_264_5

					if var_264_5 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_5 + var_264_0
					end
				end
			end

			local var_264_6 = math.max(1.53333333333333, arg_261_1.talkMaxDuration)

			if var_264_0 <= arg_261_1.time_ and arg_261_1.time_ < var_264_0 + var_264_6 then
				arg_261_1.fswtw_.percent = Mathf.Lerp(arg_261_1.var_.oldValueTypewriter, var_264_3, (arg_261_1.time_ - var_264_0) / var_264_6)
				arg_261_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_261_1.fswtw_:SetDirty()
			end

			if arg_261_1.time_ >= var_264_0 + var_264_6 and arg_261_1.time_ < var_264_0 + var_264_6 + arg_264_0 then
				arg_261_1.fswtw_.percent = var_264_3

				arg_261_1.fswtw_:SetDirty()
				arg_261_1:ShowNextGo(true)

				arg_261_1.typewritterCharCountI18N = var_264_4
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play116111062 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 116111062
		arg_265_1.duration_ = 1

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play116111063(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.fswbg_:SetActive(true)
				arg_265_1.dialog_:SetActive(false)

				arg_265_1.fswtw_.percent = 0
				arg_265_1.fswt_.text = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(116111062).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.fswt_)

				arg_265_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_265_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_265_1.fswtw_:SetDirty()

				arg_265_1.typewritterCharCountI18N = 0

				SetActive(arg_265_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_265_1:ShowNextGo(false)
			end

			local var_268_0 = 0.0166666666666666

			if 0.0166666666666666 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.var_.oldValueTypewriter = arg_265_1.fswtw_.percent

				SetActive(arg_265_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_265_1:ShowNextGo(false)
			end

			local var_268_1 = 5
			local var_268_2 = 0.333333333333333
			local var_268_3, var_268_4 = arg_265_1:GetPercentByPara(arg_265_1:FormatText(arg_265_1:GetWordFromCfg(116111062).content), 1)

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0

				local var_268_5 = var_268_1 <= 0 and var_268_2 or var_268_2 * ((var_268_4 - arg_265_1.typewritterCharCountI18N) / var_268_1)

				if (var_268_1 <= 0 and var_268_2 or var_268_2 * ((var_268_4 - arg_265_1.typewritterCharCountI18N) / var_268_1)) > 0 and var_268_2 < var_268_5 then
					arg_265_1.talkMaxDuration = var_268_5

					if var_268_5 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_5 + var_268_0
					end
				end
			end

			local var_268_6 = math.max(0.333333333333333, arg_265_1.talkMaxDuration)

			if var_268_0 <= arg_265_1.time_ and arg_265_1.time_ < var_268_0 + var_268_6 then
				arg_265_1.fswtw_.percent = Mathf.Lerp(arg_265_1.var_.oldValueTypewriter, var_268_3, (arg_265_1.time_ - var_268_0) / var_268_6)
				arg_265_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_265_1.fswtw_:SetDirty()
			end

			if arg_265_1.time_ >= var_268_0 + var_268_6 and arg_265_1.time_ < var_268_0 + var_268_6 + arg_268_0 then
				arg_265_1.fswtw_.percent = var_268_3

				arg_265_1.fswtw_:SetDirty()
				arg_265_1:ShowNextGo(true)

				arg_265_1.typewritterCharCountI18N = var_268_4
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play116111063 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 116111063
		arg_269_1.duration_ = 58.37

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
			arg_269_1.auto_ = false
		end

		function arg_269_1.playNext_(arg_271_0)
			arg_269_1.onStoryFinished_()
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.fswbg_:SetActive(true)
				arg_269_1.dialog_:SetActive(false)

				arg_269_1.fswtw_.percent = 0
				arg_269_1.fswt_.text = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(116111063).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.fswt_)

				arg_269_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_269_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_269_1.fswtw_:SetDirty()

				arg_269_1.typewritterCharCountI18N = 0

				SetActive(arg_269_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_269_1:ShowNextGo(false)
			end

			local var_272_0 = 0.0166666666666666

			if 0.0166666666666666 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1.var_.oldValueTypewriter = arg_269_1.fswtw_.percent

				SetActive(arg_269_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_269_1:ShowNextGo(false)
			end

			local var_272_1 = 34
			local var_272_2 = 2.26666666666667
			local var_272_3, var_272_4 = arg_269_1:GetPercentByPara(arg_269_1:FormatText(arg_269_1:GetWordFromCfg(116111063).content), 1)

			if var_272_0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0

				local var_272_5 = var_272_1 <= 0 and var_272_2 or var_272_2 * ((var_272_4 - arg_269_1.typewritterCharCountI18N) / var_272_1)

				if (var_272_1 <= 0 and var_272_2 or var_272_2 * ((var_272_4 - arg_269_1.typewritterCharCountI18N) / var_272_1)) > 0 and var_272_2 < var_272_5 then
					arg_269_1.talkMaxDuration = var_272_5

					if var_272_5 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_5 + var_272_0
					end
				end
			end

			local var_272_6 = math.max(2.26666666666667, arg_269_1.talkMaxDuration)

			if var_272_0 <= arg_269_1.time_ and arg_269_1.time_ < var_272_0 + var_272_6 then
				arg_269_1.fswtw_.percent = Mathf.Lerp(arg_269_1.var_.oldValueTypewriter, var_272_3, (arg_269_1.time_ - var_272_0) / var_272_6)
				arg_269_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_269_1.fswtw_:SetDirty()
			end

			if arg_269_1.time_ >= var_272_0 + var_272_6 and arg_269_1.time_ < var_272_0 + var_272_6 + arg_272_0 then
				arg_269_1.fswtw_.percent = var_272_3

				arg_269_1.fswtw_:SetDirty()
				arg_269_1:ShowNextGo(true)

				arg_269_1.typewritterCharCountI18N = var_272_4
			end

			local var_272_7 = 2.28333333333333

			if 2.28333333333333 < arg_269_1.time_ and arg_269_1.time_ <= var_272_7 + arg_272_0 then
				arg_269_1.mask_.enabled = true
				arg_269_1.mask_.raycastTarget = true

				arg_269_1:SetGaussion(false)
			end

			local var_272_8 = 2

			if var_272_7 <= arg_269_1.time_ and arg_269_1.time_ < var_272_7 + var_272_8 then
				local var_272_9 = Color.New(0, 0, 0)

				var_272_9.a = Mathf.Lerp(0, 1, (arg_269_1.time_ - var_272_7) / var_272_8)
				arg_269_1.mask_.color = var_272_9
			end

			if arg_269_1.time_ >= var_272_7 + var_272_8 and arg_269_1.time_ < var_272_7 + var_272_8 + arg_272_0 then
				local var_272_10 = Color.New(0, 0, 0)

				var_272_10.a = 1
				arg_269_1.mask_.color = var_272_10
			end

			local var_272_11 = 4.28333333333333

			if 4.28333333333333 < arg_269_1.time_ and arg_269_1.time_ <= var_272_11 + arg_272_0 then
				arg_269_1.mask_.enabled = true
				arg_269_1.mask_.raycastTarget = true

				arg_269_1:SetGaussion(false)
			end

			local var_272_12 = 2

			if var_272_11 <= arg_269_1.time_ and arg_269_1.time_ < var_272_11 + var_272_12 then
				local var_272_13 = Color.New(0, 0, 0)

				var_272_13.a = Mathf.Lerp(1, 0, (arg_269_1.time_ - var_272_11) / var_272_12)
				arg_269_1.mask_.color = var_272_13
			end

			if arg_269_1.time_ >= var_272_11 + var_272_12 and arg_269_1.time_ < var_272_11 + var_272_12 + arg_272_0 then
				local var_272_14 = Color.New(0, 0, 0)

				arg_269_1.mask_.enabled = false
				var_272_14.a = 0
				arg_269_1.mask_.color = var_272_14
			end

			if 4.26666666666667 < arg_269_1.time_ and arg_269_1.time_ <= 4.26666666666667 + arg_272_0 then
				arg_269_1.fswbg_:SetActive(false)
				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_269_1:ShowNextGo(false)
			end

			local var_272_15 = 4.28333333333333

			if 4.28333333333333 < arg_269_1.time_ and arg_269_1.time_ <= var_272_15 + arg_272_0 then
				SetActive(arg_269_1.dialog_, false)
				SetActive(arg_269_1.allBtn_.gameObject, false)
				arg_269_1.hideBtnsController_:SetSelectedIndex(1)
				manager.video:Play("SofdecAsset/story/101161101.usm", function(arg_273_0)
					arg_269_1:Skip(arg_273_0)
					manager.video:Dispose()
				end, nil, nil, function(arg_274_0)
					arg_269_1.state_ = arg_274_0 and "pause" or "playing"
				end, 101161101)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_272_16 = 39.72

			if var_272_15 <= arg_269_1.time_ and arg_269_1.time_ < var_272_15 + var_272_16 then
				-- block empty
			end

			if arg_269_1.time_ >= var_272_15 + var_272_16 and arg_269_1.time_ < var_272_15 + var_272_16 + arg_272_0 then
				-- block empty
			end

			local var_272_17 = 0

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_17 + arg_272_0 then
				arg_269_1.allBtn_.enabled = false
			end

			if arg_269_1.time_ >= var_272_17 + 2.28333333333333 and arg_269_1.time_ < var_272_17 + 2.28333333333333 + arg_272_0 then
				arg_269_1.allBtn_.enabled = true
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_272_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_269_1.bgmTxt_.text ~= var_272_20 and arg_269_1.bgmTxt_.text ~= "" then
						if arg_269_1.bgmTxt2_.text ~= "" then
							arg_269_1.bgmTxt_.text = arg_269_1.bgmTxt2_.text
						end

						arg_269_1.bgmTxt2_.text = var_272_20

						arg_269_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_269_1.bgmTxt_.text = var_272_20
						arg_269_1.bgmTxt2_.text = var_272_20
					end

					if arg_269_1.bgmTimer then
						arg_269_1.bgmTimer:Stop()

						arg_269_1.bgmTimer = nil
					end

					if arg_269_1.settingData.show_music_name == 1 then
						arg_269_1.musicController:SetSelectedState("show")
						arg_269_1.musicAnimator_:Play("open", 0, 0)

						if arg_269_1.settingData.music_time ~= 0 then
							arg_269_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_269_1.settingData.music_time), function()
								if arg_269_1 == nil or isNil(arg_269_1.bgmTxt_) then
									return
								end

								arg_269_1.musicController:SetSelectedState("hide")
								arg_269_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B13g",
		"TextureConfig/Background/ST18",
		"TextureConfig/Background/B13f",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/SK0101",
		"TextureConfig/Background/STblack",
		"SofdecAsset/story/101161101.usm"
	},
	voices = {
		"story_v_out_116111.awb"
	}
}
