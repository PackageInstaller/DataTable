return {
	Play111032001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 111032001
		arg_1_1.duration_ = 6.5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play111032002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.D05 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "D05")
				var_4_0.name = "D05"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.D05 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.D05

				arg_1_1.bgs_.D05.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "D05" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_4 = arg_1_1.bgs_.D05:GetComponent("SpriteRenderer")

				if var_4_4 then
					arg_1_1.var_.alphaOldValueD05 = var_4_4.color.a
					arg_1_1.var_.alphaMatValueD05 = var_4_4
				end
			end

			local var_4_5 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_5 then
				if arg_1_1.var_.alphaMatValueD05 then
					arg_1_1.var_.alphaMatValueD05.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueD05, 0.5, (arg_1_1.time_ - 0) / var_4_5)
					arg_1_1.var_.alphaMatValueD05.color = arg_1_1.var_.alphaMatValueD05.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_5 and arg_1_1.time_ < 0 + var_4_5 + arg_4_0 and arg_1_1.var_.alphaMatValueD05 then
				arg_1_1.var_.alphaMatValueD05.color.a = 0.5
				arg_1_1.var_.alphaMatValueD05.color = arg_1_1.var_.alphaMatValueD05.color
			end

			local var_4_6 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_7 = 1.5

			if var_4_6 <= arg_1_1.time_ and arg_1_1.time_ < var_4_6 + var_4_7 then
				local var_4_8 = Color.New(1, 1, 1)

				var_4_8.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_6) / var_4_7)
				arg_1_1.mask_.color = var_4_8
			end

			if arg_1_1.time_ >= var_4_6 + var_4_7 and arg_1_1.time_ < var_4_6 + var_4_7 + arg_4_0 then
				local var_4_9 = Color.New(1, 1, 1)

				arg_1_1.mask_.enabled = false
				var_4_9.a = 0
				arg_1_1.mask_.color = var_4_9
			end

			local var_4_10 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_10 + 1.5 and arg_1_1.time_ < var_4_10 + 1.5 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_1_hel_story", "bgm_activity_1_1_hel_story", "bgm_activity_1_1_hel_story.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_1_1_hel_story", "bgm_activity_1_1_hel_story")

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

			local var_4_14 = 1.5
			local var_4_15 = 0.1

			if 1.5 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(111032001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 4 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 4)

				if (4 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 4)) > 0 and var_4_15 < var_4_19 then
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
	Play111032002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 111032002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play111032003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 1.15

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

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(111032002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 46 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 46)

				if (46 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 46)) > 0 and var_11_0 < var_11_3 then
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
	Play111032003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 111032003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play111032004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.925

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

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(111032003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 37 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 37)

				if (37 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 37)) > 0 and var_15_0 < var_15_3 then
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
	Play111032004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 111032004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play111032005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.45

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_1 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(111032004).content)

				arg_16_1.text_.text = var_19_1

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_3 = 18 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 18)

				if (18 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 18)) > 0 and var_19_0 < var_19_3 then
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
	Play111032005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 111032005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play111032006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 1.175

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

				local var_23_1 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(111032005).content)

				arg_20_1.text_.text = var_23_1

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_3 = 47 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 47)

				if (47 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 47)) > 0 and var_23_0 < var_23_3 then
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
	Play111032006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 111032006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play111032007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0.25

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_1 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(111032006).content)

				arg_24_1.text_.text = var_27_1

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_3 = 10 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_1) / 10)

				if (10 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_1) / 10)) > 0 and var_27_0 < var_27_3 then
					arg_24_1.talkMaxDuration = var_27_3

					if var_27_3 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_3 + 0
					end
				end

				arg_24_1.text_.text = var_27_1
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_4 = math.max(var_27_0, arg_24_1.talkMaxDuration)

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_4 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - 0) / var_27_4

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= 0 + var_27_4 and arg_24_1.time_ < 0 + var_27_4 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play111032007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 111032007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play111032008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0.25

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_1 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(111032007).content)

				arg_28_1.text_.text = var_31_1

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_3 = 10 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 10)

				if (10 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 10)) > 0 and var_31_0 < var_31_3 then
					arg_28_1.talkMaxDuration = var_31_3

					if var_31_3 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_3 + 0
					end
				end

				arg_28_1.text_.text = var_31_1
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_4 = math.max(var_31_0, arg_28_1.talkMaxDuration)

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - 0) / var_31_4

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play111032008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 111032008
		arg_32_1.duration_ = 9.1

		local var_32_0 = {
			ja = 4.133,
			ko = 6.166,
			zh = 9.1,
			en = 6.133
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play111032009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_35_0 = 0.3

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 then
				local var_35_1, var_35_2 = math.modf((arg_32_1.time_ - 0) / 0.099)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_35_2 * 0.13, var_35_2 * 0.13, var_35_2 * 0.13) + arg_32_1.var_.shakeOldPos
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 then
				manager.ui.mainCamera.transform.localPosition = arg_32_1.var_.shakeOldPos
			end

			local var_35_3 = 0
			local var_35_4 = 0.725

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_3 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_5 = arg_32_1:GetWordFromCfg(111032008)
				local var_35_6 = arg_32_1:FormatText(var_35_5.content)

				arg_32_1.text_.text = var_35_6

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_8 = 29 <= 0 and var_35_4 or var_35_4 * (utf8.len(var_35_6) / 29)

				if (29 <= 0 and var_35_4 or var_35_4 * (utf8.len(var_35_6) / 29)) > 0 and var_35_4 < var_35_8 then
					arg_32_1.talkMaxDuration = var_35_8

					if var_35_8 + var_35_3 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_3
					end
				end

				arg_32_1.text_.text = var_35_6
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111032", "111032008", "story_v_out_111032.awb") ~= 0 then
					local var_35_9 = manager.audio:GetVoiceLength("story_v_out_111032", "111032008", "story_v_out_111032.awb") / 1000

					if var_35_9 + var_35_3 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_9 + var_35_3
					end

					if var_35_5.prefab_name ~= "" and arg_32_1.actors_[var_35_5.prefab_name] ~= nil then
						local var_35_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_5.prefab_name].transform, "story_v_out_111032", "111032008", "story_v_out_111032.awb")

						arg_32_1:RecordAudio("111032008", var_35_10)
						arg_32_1:RecordAudio("111032008", var_35_10)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_111032", "111032008", "story_v_out_111032.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_111032", "111032008", "story_v_out_111032.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_11 = math.max(var_35_4, arg_32_1.talkMaxDuration)

			if var_35_3 <= arg_32_1.time_ and arg_32_1.time_ < var_35_3 + var_35_11 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_3) / var_35_11

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_3 + var_35_11 and arg_32_1.time_ < var_35_3 + var_35_11 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play111032009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 111032009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play111032010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 1.4

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_1 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(111032009).content)

				arg_36_1.text_.text = var_39_1

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_3 = 56 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_1) / 56)

				if (56 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_1) / 56)) > 0 and var_39_0 < var_39_3 then
					arg_36_1.talkMaxDuration = var_39_3

					if var_39_3 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_3 + 0
					end
				end

				arg_36_1.text_.text = var_39_1
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_4 = math.max(var_39_0, arg_36_1.talkMaxDuration)

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_4 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - 0) / var_39_4

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= 0 + var_39_4 and arg_36_1.time_ < 0 + var_39_4 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play111032010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 111032010
		arg_40_1.duration_ = 7.7

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play111032011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if arg_40_1.bgs_.AS0101 == nil then
				local var_43_0 = Object.Instantiate(arg_40_1.paintGo_)

				var_43_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "AS0101")
				var_43_0.name = "AS0101"
				var_43_0.transform.parent = arg_40_1.stage_.transform
				var_43_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_40_1.bgs_.AS0101 = var_43_0
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				local var_43_1 = arg_40_1.bgs_.AS0101

				arg_40_1.bgs_.AS0101.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_43_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_43_2 = var_43_1:GetComponent("SpriteRenderer")

				if var_43_2 and var_43_2.sprite then
					local var_43_3 = 2 * (var_43_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_43_1.transform.localScale = Vector3.New(var_43_3 / var_43_2.sprite.bounds.size.y < var_43_3 * manager.ui.mainCameraCom_.aspect / var_43_2.sprite.bounds.size.x and var_43_3 * manager.ui.mainCameraCom_.aspect / var_43_2.sprite.bounds.size.x or var_43_3 / var_43_2.sprite.bounds.size.y, var_43_3 / var_43_2.sprite.bounds.size.y < var_43_3 * manager.ui.mainCameraCom_.aspect / var_43_2.sprite.bounds.size.x and var_43_3 * manager.ui.mainCameraCom_.aspect / var_43_2.sprite.bounds.size.x or var_43_3 / var_43_2.sprite.bounds.size.y, 0)
				end

				for iter_43_0, iter_43_1 in pairs(arg_40_1.bgs_) do
					if iter_43_0 ~= "AS0101" then
						iter_43_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_43_4 = 0

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1.mask_.enabled = true
				arg_40_1.mask_.raycastTarget = true

				arg_40_1:SetGaussion(false)
			end

			local var_43_5 = 2.7

			if var_43_4 <= arg_40_1.time_ and arg_40_1.time_ < var_43_4 + var_43_5 then
				local var_43_6 = Color.New(1, 1, 1)

				var_43_6.a = Mathf.Lerp(1, 0, (arg_40_1.time_ - var_43_4) / var_43_5)
				arg_40_1.mask_.color = var_43_6
			end

			if arg_40_1.time_ >= var_43_4 + var_43_5 and arg_40_1.time_ < var_43_4 + var_43_5 + arg_43_0 then
				local var_43_7 = Color.New(1, 1, 1)

				arg_40_1.mask_.enabled = false
				var_43_7.a = 0
				arg_40_1.mask_.color = var_43_7
			end

			local var_43_8 = 0

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_8 + arg_43_0 then
				arg_40_1.allBtn_.enabled = false
			end

			if arg_40_1.time_ >= var_43_8 + 2.7 and arg_40_1.time_ < var_43_8 + 2.7 + arg_43_0 then
				arg_40_1.allBtn_.enabled = true
			end

			if arg_40_1.frameCnt_ <= 1 then
				arg_40_1.dialog_:SetActive(false)
			end

			local var_43_9 = 2.7
			local var_43_10 = 1.8

			if 2.7 < arg_40_1.time_ and arg_40_1.time_ <= var_43_9 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0

				arg_40_1.dialog_:SetActive(true)

				arg_40_1.dialogCg_.alpha = 0

				local var_43_11 = LeanTween.value(arg_40_1.dialog_, 0, 1, 0.3)

				var_43_11:setOnUpdate(LuaHelper.FloatAction(function(arg_44_0)
					arg_40_1.dialogCg_.alpha = arg_44_0
				end))
				var_43_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_40_1.dialog_)
					var_43_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_40_1.duration_ = arg_40_1.duration_ + 0.3

				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_12 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(111032010).content)

				arg_40_1.text_.text = var_43_12

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_14 = 72 <= 0 and var_43_10 or var_43_10 * (utf8.len(var_43_12) / 72)

				if (72 <= 0 and var_43_10 or var_43_10 * (utf8.len(var_43_12) / 72)) > 0 and var_43_10 < var_43_14 then
					arg_40_1.talkMaxDuration = var_43_14
					var_43_9 = var_43_9 + 0.3

					if var_43_14 + var_43_9 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_14 + var_43_9
					end
				end

				arg_40_1.text_.text = var_43_12
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_15 = var_43_9 + 0.3
			local var_43_16 = math.max(var_43_10, arg_40_1.talkMaxDuration)

			if var_43_9 + 0.3 <= arg_40_1.time_ and arg_40_1.time_ < var_43_15 + var_43_16 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_15) / var_43_16

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_15 + var_43_16 and arg_40_1.time_ < var_43_15 + var_43_16 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play111032011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 111032011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play111032012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 1.45

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

				local var_49_1 = arg_46_1:FormatText(arg_46_1:GetWordFromCfg(111032011).content)

				arg_46_1.text_.text = var_49_1

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_3 = 58 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_1) / 58)

				if (58 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_1) / 58)) > 0 and var_49_0 < var_49_3 then
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
	Play111032012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 111032012
		arg_50_1.duration_ = 11.8

		local var_50_0 = {
			ja = 3.466,
			ko = 8.4,
			zh = 11.8,
			en = 5.033
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play111032013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0.425

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedb")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_1 = arg_50_1:GetWordFromCfg(111032012)
				local var_53_2 = arg_50_1:FormatText(var_53_1.content)

				arg_50_1.text_.text = var_53_2

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_4 = 17 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_2) / 17)

				if (17 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_2) / 17)) > 0 and var_53_0 < var_53_4 then
					arg_50_1.talkMaxDuration = var_53_4

					if var_53_4 + 0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_4 + 0
					end
				end

				arg_50_1.text_.text = var_53_2
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111032", "111032012", "story_v_out_111032.awb") ~= 0 then
					local var_53_5 = manager.audio:GetVoiceLength("story_v_out_111032", "111032012", "story_v_out_111032.awb") / 1000

					if var_53_5 + 0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_5 + 0
					end

					if var_53_1.prefab_name ~= "" and arg_50_1.actors_[var_53_1.prefab_name] ~= nil then
						local var_53_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_1.prefab_name].transform, "story_v_out_111032", "111032012", "story_v_out_111032.awb")

						arg_50_1:RecordAudio("111032012", var_53_6)
						arg_50_1:RecordAudio("111032012", var_53_6)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_111032", "111032012", "story_v_out_111032.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_111032", "111032012", "story_v_out_111032.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_7 = math.max(var_53_0, arg_50_1.talkMaxDuration)

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_7 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - 0) / var_53_7

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= 0 + var_53_7 and arg_50_1.time_ < 0 + var_53_7 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play111032013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 111032013
		arg_54_1.duration_ = 2.77

		local var_54_0 = {
			ja = 1.166,
			ko = 1.9,
			zh = 2.533,
			en = 2.766
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
				arg_54_0:Play111032014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0.175

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1094")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_1 = arg_54_1:GetWordFromCfg(111032013)
				local var_57_2 = arg_54_1:FormatText(var_57_1.content)

				arg_54_1.text_.text = var_57_2

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_4 = 7 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_2) / 7)

				if (7 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_2) / 7)) > 0 and var_57_0 < var_57_4 then
					arg_54_1.talkMaxDuration = var_57_4

					if var_57_4 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_4 + 0
					end
				end

				arg_54_1.text_.text = var_57_2
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111032", "111032013", "story_v_out_111032.awb") ~= 0 then
					local var_57_5 = manager.audio:GetVoiceLength("story_v_out_111032", "111032013", "story_v_out_111032.awb") / 1000

					if var_57_5 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_5 + 0
					end

					if var_57_1.prefab_name ~= "" and arg_54_1.actors_[var_57_1.prefab_name] ~= nil then
						local var_57_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_1.prefab_name].transform, "story_v_out_111032", "111032013", "story_v_out_111032.awb")

						arg_54_1:RecordAudio("111032013", var_57_6)
						arg_54_1:RecordAudio("111032013", var_57_6)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_111032", "111032013", "story_v_out_111032.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_111032", "111032013", "story_v_out_111032.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_7 = math.max(var_57_0, arg_54_1.talkMaxDuration)

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_7 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - 0) / var_57_7

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= 0 + var_57_7 and arg_54_1.time_ < 0 + var_57_7 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play111032014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 111032014
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play111032015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_61_0 = 0.5

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 then
				local var_61_1, var_61_2 = math.modf((arg_58_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_61_2 * 0.13, var_61_2 * 0.13, var_61_2 * 0.13) + arg_58_1.var_.shakeOldPos
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 then
				manager.ui.mainCamera.transform.localPosition = arg_58_1.var_.shakeOldPos
			end

			local var_61_3 = 0

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_3 + arg_61_0 then
				arg_58_1.mask_.enabled = true
				arg_58_1.mask_.raycastTarget = true

				arg_58_1:SetGaussion(false)
			end

			local var_61_4 = 0.1

			if var_61_3 <= arg_58_1.time_ and arg_58_1.time_ < var_61_3 + var_61_4 then
				local var_61_5 = Color.New(1, 1, 1)

				var_61_5.a = Mathf.Lerp(1, 0, (arg_58_1.time_ - var_61_3) / var_61_4)
				arg_58_1.mask_.color = var_61_5
			end

			if arg_58_1.time_ >= var_61_3 + var_61_4 and arg_58_1.time_ < var_61_3 + var_61_4 + arg_61_0 then
				local var_61_6 = Color.New(1, 1, 1)

				arg_58_1.mask_.enabled = false
				var_61_6.a = 0
				arg_58_1.mask_.color = var_61_6
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:AudioAction("play", "effect", "se_story_activity_1_1", "se_story_activity_1_1_hel_cannon", "")
			end

			local var_61_8 = 0
			local var_61_9 = 1.05

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_8 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, false)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_10 = arg_58_1:FormatText(arg_58_1:GetWordFromCfg(111032014).content)

				arg_58_1.text_.text = var_61_10

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_12 = 42 <= 0 and var_61_9 or var_61_9 * (utf8.len(var_61_10) / 42)

				if (42 <= 0 and var_61_9 or var_61_9 * (utf8.len(var_61_10) / 42)) > 0 and var_61_9 < var_61_12 then
					arg_58_1.talkMaxDuration = var_61_12

					if var_61_12 + var_61_8 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_12 + var_61_8
					end
				end

				arg_58_1.text_.text = var_61_10
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_13 = math.max(var_61_9, arg_58_1.talkMaxDuration)

			if var_61_8 <= arg_58_1.time_ and arg_58_1.time_ < var_61_8 + var_61_13 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_8) / var_61_13

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_8 + var_61_13 and arg_58_1.time_ < var_61_8 + var_61_13 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play111032015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 111032015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play111032016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0.2

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_1 = arg_62_1:FormatText(arg_62_1:GetWordFromCfg(111032015).content)

				arg_62_1.text_.text = var_65_1

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_3 = 8 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_1) / 8)

				if (8 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_1) / 8)) > 0 and var_65_0 < var_65_3 then
					arg_62_1.talkMaxDuration = var_65_3

					if var_65_3 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_3 + 0
					end
				end

				arg_62_1.text_.text = var_65_1
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_4 = math.max(var_65_0, arg_62_1.talkMaxDuration)

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_4 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - 0) / var_65_4

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= 0 + var_65_4 and arg_62_1.time_ < 0 + var_65_4 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play111032016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 111032016
		arg_66_1.duration_ = 1

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play111032017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0.716666666666667

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, true)
				arg_66_1.iconController_:SetSelectedState("hero")

				arg_66_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1094")

				arg_66_1.callingController_:SetSelectedState("normal")

				arg_66_1.keyicon_.color = Color.New(1, 1, 1)
				arg_66_1.icon_.color = Color.New(1, 1, 1)

				local var_69_1 = arg_66_1:GetWordFromCfg(111032016)
				local var_69_2 = arg_66_1:FormatText(var_69_1.content)

				arg_66_1.text_.text = var_69_2

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_4 = 2 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_2) / 2)

				if (2 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_2) / 2)) > 0 and var_69_0 < var_69_4 then
					arg_66_1.talkMaxDuration = var_69_4

					if var_69_4 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_4 + 0
					end
				end

				arg_66_1.text_.text = var_69_2
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111032", "111032016", "story_v_out_111032.awb") ~= 0 then
					local var_69_5 = manager.audio:GetVoiceLength("story_v_out_111032", "111032016", "story_v_out_111032.awb") / 1000

					if var_69_5 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_5 + 0
					end

					if var_69_1.prefab_name ~= "" and arg_66_1.actors_[var_69_1.prefab_name] ~= nil then
						local var_69_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_1.prefab_name].transform, "story_v_out_111032", "111032016", "story_v_out_111032.awb")

						arg_66_1:RecordAudio("111032016", var_69_6)
						arg_66_1:RecordAudio("111032016", var_69_6)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_111032", "111032016", "story_v_out_111032.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_111032", "111032016", "story_v_out_111032.awb")
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
	Play111032017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 111032017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play111032018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 1.675

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_1 = arg_70_1:FormatText(arg_70_1:GetWordFromCfg(111032017).content)

				arg_70_1.text_.text = var_73_1

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_3 = 67 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_1) / 67)

				if (67 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_1) / 67)) > 0 and var_73_0 < var_73_3 then
					arg_70_1.talkMaxDuration = var_73_3

					if var_73_3 + 0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_3 + 0
					end
				end

				arg_70_1.text_.text = var_73_1
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_4 = math.max(var_73_0, arg_70_1.talkMaxDuration)

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_4 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - 0) / var_73_4

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= 0 + var_73_4 and arg_70_1.time_ < 0 + var_73_4 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play111032018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 111032018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play111032019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0.825

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, false)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_1 = arg_74_1:FormatText(arg_74_1:GetWordFromCfg(111032018).content)

				arg_74_1.text_.text = var_77_1

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_3 = 33 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_1) / 33)

				if (33 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_1) / 33)) > 0 and var_77_0 < var_77_3 then
					arg_74_1.talkMaxDuration = var_77_3

					if var_77_3 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_3 + 0
					end
				end

				arg_74_1.text_.text = var_77_1
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_4 = math.max(var_77_0, arg_74_1.talkMaxDuration)

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_4 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - 0) / var_77_4

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= 0 + var_77_4 and arg_74_1.time_ < 0 + var_77_4 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play111032019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 111032019
		arg_78_1.duration_ = 7.5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play111032020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 1 < arg_78_1.time_ and arg_78_1.time_ <= 1 + arg_81_0 then
				local var_81_0 = arg_78_1.bgs_.D05

				arg_78_1.bgs_.D05.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_81_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_81_1 = var_81_0:GetComponent("SpriteRenderer")

				if var_81_1 and var_81_1.sprite then
					local var_81_2 = 2 * (var_81_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_81_0.transform.localScale = Vector3.New(var_81_2 / var_81_1.sprite.bounds.size.y < var_81_2 * manager.ui.mainCameraCom_.aspect / var_81_1.sprite.bounds.size.x and var_81_2 * manager.ui.mainCameraCom_.aspect / var_81_1.sprite.bounds.size.x or var_81_2 / var_81_1.sprite.bounds.size.y, var_81_2 / var_81_1.sprite.bounds.size.y < var_81_2 * manager.ui.mainCameraCom_.aspect / var_81_1.sprite.bounds.size.x and var_81_2 * manager.ui.mainCameraCom_.aspect / var_81_1.sprite.bounds.size.x or var_81_2 / var_81_1.sprite.bounds.size.y, 0)
				end

				for iter_81_0, iter_81_1 in pairs(arg_78_1.bgs_) do
					if iter_81_0 ~= "D05" then
						iter_81_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 1 < arg_78_1.time_ and arg_78_1.time_ <= 1 + arg_81_0 then
				local var_81_3 = arg_78_1.bgs_.D05:GetComponent("SpriteRenderer")

				if var_81_3 then
					arg_78_1.var_.alphaOldValueD05 = var_81_3.color.a
					arg_78_1.var_.alphaMatValueD05 = var_81_3
				end

				arg_78_1.var_.alphaOldValueD05 = 0
			end

			local var_81_4 = 1.5

			if 1 <= arg_78_1.time_ and arg_78_1.time_ < 1 + var_81_4 then
				if arg_78_1.var_.alphaMatValueD05 then
					arg_78_1.var_.alphaMatValueD05.color.a = Mathf.Lerp(arg_78_1.var_.alphaOldValueD05, 1, (arg_78_1.time_ - 1) / var_81_4)
					arg_78_1.var_.alphaMatValueD05.color = arg_78_1.var_.alphaMatValueD05.color
				end
			end

			if arg_78_1.time_ >= 1 + var_81_4 and arg_78_1.time_ < 1 + var_81_4 + arg_81_0 and arg_78_1.var_.alphaMatValueD05 then
				arg_78_1.var_.alphaMatValueD05.color.a = 1
				arg_78_1.var_.alphaMatValueD05.color = arg_78_1.var_.alphaMatValueD05.color
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				local var_81_5 = arg_78_1.bgs_.AS0101:GetComponent("SpriteRenderer")

				if var_81_5 then
					arg_78_1.var_.alphaOldValueAS0101 = var_81_5.color.a
					arg_78_1.var_.alphaMatValueAS0101 = var_81_5
				end

				arg_78_1.var_.alphaOldValueAS0101 = 1
			end

			local var_81_6 = 1

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_6 then
				if arg_78_1.var_.alphaMatValueAS0101 then
					arg_78_1.var_.alphaMatValueAS0101.color.a = Mathf.Lerp(arg_78_1.var_.alphaOldValueAS0101, 0, (arg_78_1.time_ - 0) / var_81_6)
					arg_78_1.var_.alphaMatValueAS0101.color = arg_78_1.var_.alphaMatValueAS0101.color
				end
			end

			if arg_78_1.time_ >= 0 + var_81_6 and arg_78_1.time_ < 0 + var_81_6 + arg_81_0 and arg_78_1.var_.alphaMatValueAS0101 then
				arg_78_1.var_.alphaMatValueAS0101.color.a = 0
				arg_78_1.var_.alphaMatValueAS0101.color = arg_78_1.var_.alphaMatValueAS0101.color
			end

			local var_81_7 = 0

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_7 + arg_81_0 then
				arg_78_1.allBtn_.enabled = false
			end

			if arg_78_1.time_ >= var_81_7 + 2.5 and arg_78_1.time_ < var_81_7 + 2.5 + arg_81_0 then
				arg_78_1.allBtn_.enabled = true
			end

			if arg_78_1.frameCnt_ <= 1 then
				arg_78_1.dialog_:SetActive(false)
			end

			local var_81_8 = 2.5
			local var_81_9 = 0.95

			if 2.5 < arg_78_1.time_ and arg_78_1.time_ <= var_81_8 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0

				arg_78_1.dialog_:SetActive(true)

				arg_78_1.dialogCg_.alpha = 0

				local var_81_10 = LeanTween.value(arg_78_1.dialog_, 0, 1, 0.3)

				var_81_10:setOnUpdate(LuaHelper.FloatAction(function(arg_82_0)
					arg_78_1.dialogCg_.alpha = arg_82_0
				end))
				var_81_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_78_1.dialog_)
					var_81_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_78_1.duration_ = arg_78_1.duration_ + 0.3

				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_11 = arg_78_1:FormatText(arg_78_1:GetWordFromCfg(111032019).content)

				arg_78_1.text_.text = var_81_11

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_13 = 38 <= 0 and var_81_9 or var_81_9 * (utf8.len(var_81_11) / 38)

				if (38 <= 0 and var_81_9 or var_81_9 * (utf8.len(var_81_11) / 38)) > 0 and var_81_9 < var_81_13 then
					arg_78_1.talkMaxDuration = var_81_13
					var_81_8 = var_81_8 + 0.3

					if var_81_13 + var_81_8 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_13 + var_81_8
					end
				end

				arg_78_1.text_.text = var_81_11
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_14 = var_81_8 + 0.3
			local var_81_15 = math.max(var_81_9, arg_78_1.talkMaxDuration)

			if var_81_8 + 0.3 <= arg_78_1.time_ and arg_78_1.time_ < var_81_14 + var_81_15 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_14) / var_81_15

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_14 + var_81_15 and arg_78_1.time_ < var_81_14 + var_81_15 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play111032020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 111032020
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play111032021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0.325

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_1 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(111032020).content)

				arg_84_1.text_.text = var_87_1

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_3 = 13 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_1) / 13)

				if (13 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_1) / 13)) > 0 and var_87_0 < var_87_3 then
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
	Play111032021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 111032021
		arg_88_1.duration_ = 2

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play111032022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if arg_88_1.actors_["1094ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1094ui_story"))) then
				local var_91_0 = Object.Instantiate(Asset.Load("Char/" .. "1094ui_story"), arg_88_1.stage_.transform)

				var_91_0.name = "1094ui_story"
				var_91_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_88_1.actors_["1094ui_story"] = var_91_0

				local var_91_1 = var_91_0:GetComponentInChildren(typeof(CharacterEffect))

				var_91_1.enabled = true

				local var_91_2 = GameObjectTools.GetOrAddComponent(var_91_0, typeof(DynamicBoneHelper))

				if var_91_2 then
					var_91_2:EnableDynamicBone(false)
				end

				arg_88_1:ShowWeapon(var_91_1.transform, false)

				arg_88_1.var_["1094ui_story" .. "Animator"] = var_91_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_88_1.var_["1094ui_story" .. "Animator"].applyRootMotion = true
				arg_88_1.var_["1094ui_story" .. "LipSync"] = var_91_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_91_3 = arg_88_1.actors_["1094ui_story"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_3) and arg_88_1.var_.characterEffect1094ui_story == nil then
				arg_88_1.var_.characterEffect1094ui_story = var_91_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_4 = 0.2

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_4 and not isNil(var_91_3) then
				if arg_88_1.var_.characterEffect1094ui_story and not isNil(var_91_3) then
					arg_88_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_4 and arg_88_1.time_ < 0 + var_91_4 + arg_91_0 and not isNil(var_91_3) and arg_88_1.var_.characterEffect1094ui_story then
				arg_88_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_91_6 = arg_88_1.actors_["1094ui_story"].transform

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos1094ui_story = var_91_6.localPosition
			end

			local var_91_7 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_7 then
				var_91_6.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_88_1.time_ - 0) / var_91_7)
				var_91_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_6.position).x, (manager.ui.mainCamera.transform.position - var_91_6.position).y, (manager.ui.mainCamera.transform.position - var_91_6.position).z)
				var_91_6.localEulerAngles.z = 0
				var_91_6.localEulerAngles.x = 0
				var_91_6.localEulerAngles = var_91_6.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_7 and arg_88_1.time_ < 0 + var_91_7 + arg_91_0 then
				var_91_6.localPosition = Vector3.New(0, -0.84, -6.1)
				var_91_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_6.position).x, (manager.ui.mainCamera.transform.position - var_91_6.position).y, (manager.ui.mainCamera.transform.position - var_91_6.position).z)
				var_91_6.localEulerAngles.z = 0
				var_91_6.localEulerAngles.x = 0
				var_91_6.localEulerAngles = var_91_6.localEulerAngles
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action3_1")
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_91_8 = 0
			local var_91_9 = 0.1

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_8 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_10 = arg_88_1:GetWordFromCfg(111032021)
				local var_91_11 = arg_88_1:FormatText(var_91_10.content)

				arg_88_1.text_.text = var_91_11

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_13 = 2 <= 0 and var_91_9 or var_91_9 * (utf8.len(var_91_11) / 2)

				if (2 <= 0 and var_91_9 or var_91_9 * (utf8.len(var_91_11) / 2)) > 0 and var_91_9 < var_91_13 then
					arg_88_1.talkMaxDuration = var_91_13

					if var_91_13 + var_91_8 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_13 + var_91_8
					end
				end

				arg_88_1.text_.text = var_91_11
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111032", "111032021", "story_v_out_111032.awb") ~= 0 then
					local var_91_14 = manager.audio:GetVoiceLength("story_v_out_111032", "111032021", "story_v_out_111032.awb") / 1000

					if var_91_14 + var_91_8 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_14 + var_91_8
					end

					if var_91_10.prefab_name ~= "" and arg_88_1.actors_[var_91_10.prefab_name] ~= nil then
						local var_91_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_10.prefab_name].transform, "story_v_out_111032", "111032021", "story_v_out_111032.awb")

						arg_88_1:RecordAudio("111032021", var_91_15)
						arg_88_1:RecordAudio("111032021", var_91_15)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_111032", "111032021", "story_v_out_111032.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_111032", "111032021", "story_v_out_111032.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_16 = math.max(var_91_9, arg_88_1.talkMaxDuration)

			if var_91_8 <= arg_88_1.time_ and arg_88_1.time_ < var_91_8 + var_91_16 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_8) / var_91_16

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_8 + var_91_16 and arg_88_1.time_ < var_91_8 + var_91_16 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play111032022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 111032022
		arg_92_1.duration_ = 4.57

		local var_92_0 = {
			ja = 4.566,
			ko = 4.3,
			zh = 3.8,
			en = 3.966
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
				arg_92_0:Play111032023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_95_0 = arg_92_1.actors_["1094ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1094ui_story == nil then
				arg_92_1.var_.characterEffect1094ui_story = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_1 = 0.2

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_1 and not isNil(var_95_0) then
				if arg_92_1.var_.characterEffect1094ui_story and not isNil(var_95_0) then
					arg_92_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_1 and arg_92_1.time_ < 0 + var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1094ui_story then
				arg_92_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_95_3 = 0
			local var_95_4 = 0.425

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_3 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_5 = arg_92_1:GetWordFromCfg(111032022)
				local var_95_6 = arg_92_1:FormatText(var_95_5.content)

				arg_92_1.text_.text = var_95_6

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_8 = 17 <= 0 and var_95_4 or var_95_4 * (utf8.len(var_95_6) / 17)

				if (17 <= 0 and var_95_4 or var_95_4 * (utf8.len(var_95_6) / 17)) > 0 and var_95_4 < var_95_8 then
					arg_92_1.talkMaxDuration = var_95_8

					if var_95_8 + var_95_3 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_8 + var_95_3
					end
				end

				arg_92_1.text_.text = var_95_6
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111032", "111032022", "story_v_out_111032.awb") ~= 0 then
					local var_95_9 = manager.audio:GetVoiceLength("story_v_out_111032", "111032022", "story_v_out_111032.awb") / 1000

					if var_95_9 + var_95_3 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_9 + var_95_3
					end

					if var_95_5.prefab_name ~= "" and arg_92_1.actors_[var_95_5.prefab_name] ~= nil then
						local var_95_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_5.prefab_name].transform, "story_v_out_111032", "111032022", "story_v_out_111032.awb")

						arg_92_1:RecordAudio("111032022", var_95_10)
						arg_92_1:RecordAudio("111032022", var_95_10)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_111032", "111032022", "story_v_out_111032.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_111032", "111032022", "story_v_out_111032.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_11 = math.max(var_95_4, arg_92_1.talkMaxDuration)

			if var_95_3 <= arg_92_1.time_ and arg_92_1.time_ < var_95_3 + var_95_11 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_3) / var_95_11

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_3 + var_95_11 and arg_92_1.time_ < var_95_3 + var_95_11 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play111032023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 111032023
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play111032024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["1094ui_story"]) and arg_96_1.var_.characterEffect1094ui_story == nil then
				arg_96_1.var_.characterEffect1094ui_story = arg_96_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_0 = 0.2

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["1094ui_story"]) then
				if arg_96_1.var_.characterEffect1094ui_story and not isNil(arg_96_1.actors_["1094ui_story"]) then
					arg_96_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_0)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["1094ui_story"]) and arg_96_1.var_.characterEffect1094ui_story then
				arg_96_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_99_1 = 0
			local var_99_2 = 0.75

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_3 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(111032023).content)

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
	Play111032024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 111032024
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play111032025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 1.125

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, false)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_1 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(111032024).content)

				arg_100_1.text_.text = var_103_1

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_3 = 45 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_1) / 45)

				if (45 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_1) / 45)) > 0 and var_103_0 < var_103_3 then
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
	Play111032025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 111032025
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play111032026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0.9

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_1 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(111032025).content)

				arg_104_1.text_.text = var_107_1

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_3 = 36 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_1) / 36)

				if (36 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_1) / 36)) > 0 and var_107_0 < var_107_3 then
					arg_104_1.talkMaxDuration = var_107_3

					if var_107_3 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_3 + 0
					end
				end

				arg_104_1.text_.text = var_107_1
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_4 = math.max(var_107_0, arg_104_1.talkMaxDuration)

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_4 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - 0) / var_107_4

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= 0 + var_107_4 and arg_104_1.time_ < 0 + var_107_4 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play111032026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 111032026
		arg_108_1.duration_ = 5.8

		local var_108_0 = {
			ja = 3.233,
			ko = 2.833,
			zh = 5.8,
			en = 3.566
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
				arg_108_0:Play111032027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094actionlink/1094action435")
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_111_0 = arg_108_1.actors_["1094ui_story"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1094ui_story == nil then
				arg_108_1.var_.characterEffect1094ui_story = var_111_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_1 = 0.2

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_1 and not isNil(var_111_0) then
				if arg_108_1.var_.characterEffect1094ui_story and not isNil(var_111_0) then
					arg_108_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= 0 + var_111_1 and arg_108_1.time_ < 0 + var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1094ui_story then
				arg_108_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_111_3 = 0
			local var_111_4 = 0.325

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_3 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_5 = arg_108_1:GetWordFromCfg(111032026)
				local var_111_6 = arg_108_1:FormatText(var_111_5.content)

				arg_108_1.text_.text = var_111_6

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_8 = 13 <= 0 and var_111_4 or var_111_4 * (utf8.len(var_111_6) / 13)

				if (13 <= 0 and var_111_4 or var_111_4 * (utf8.len(var_111_6) / 13)) > 0 and var_111_4 < var_111_8 then
					arg_108_1.talkMaxDuration = var_111_8

					if var_111_8 + var_111_3 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_8 + var_111_3
					end
				end

				arg_108_1.text_.text = var_111_6
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111032", "111032026", "story_v_out_111032.awb") ~= 0 then
					local var_111_9 = manager.audio:GetVoiceLength("story_v_out_111032", "111032026", "story_v_out_111032.awb") / 1000

					if var_111_9 + var_111_3 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_9 + var_111_3
					end

					if var_111_5.prefab_name ~= "" and arg_108_1.actors_[var_111_5.prefab_name] ~= nil then
						local var_111_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_5.prefab_name].transform, "story_v_out_111032", "111032026", "story_v_out_111032.awb")

						arg_108_1:RecordAudio("111032026", var_111_10)
						arg_108_1:RecordAudio("111032026", var_111_10)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_111032", "111032026", "story_v_out_111032.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_111032", "111032026", "story_v_out_111032.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_11 = math.max(var_111_4, arg_108_1.talkMaxDuration)

			if var_111_3 <= arg_108_1.time_ and arg_108_1.time_ < var_111_3 + var_111_11 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_3) / var_111_11

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_3 + var_111_11 and arg_108_1.time_ < var_111_3 + var_111_11 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play111032027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 111032027
		arg_112_1.duration_ = 7.67

		local var_112_0 = {
			ja = 5.6,
			ko = 3.533,
			zh = 7.666,
			en = 4.7
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play111032028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_115_0 = 0
			local var_115_1 = 0.475

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_2 = arg_112_1:GetWordFromCfg(111032027)
				local var_115_3 = arg_112_1:FormatText(var_115_2.content)

				arg_112_1.text_.text = var_115_3

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_5 = 19 <= 0 and var_115_1 or var_115_1 * (utf8.len(var_115_3) / 19)

				if (19 <= 0 and var_115_1 or var_115_1 * (utf8.len(var_115_3) / 19)) > 0 and var_115_1 < var_115_5 then
					arg_112_1.talkMaxDuration = var_115_5

					if var_115_5 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_5 + var_115_0
					end
				end

				arg_112_1.text_.text = var_115_3
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111032", "111032027", "story_v_out_111032.awb") ~= 0 then
					local var_115_6 = manager.audio:GetVoiceLength("story_v_out_111032", "111032027", "story_v_out_111032.awb") / 1000

					if var_115_6 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_6 + var_115_0
					end

					if var_115_2.prefab_name ~= "" and arg_112_1.actors_[var_115_2.prefab_name] ~= nil then
						local var_115_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_2.prefab_name].transform, "story_v_out_111032", "111032027", "story_v_out_111032.awb")

						arg_112_1:RecordAudio("111032027", var_115_7)
						arg_112_1:RecordAudio("111032027", var_115_7)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_111032", "111032027", "story_v_out_111032.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_111032", "111032027", "story_v_out_111032.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_8 = math.max(var_115_1, arg_112_1.talkMaxDuration)

			if var_115_0 <= arg_112_1.time_ and arg_112_1.time_ < var_115_0 + var_115_8 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_0) / var_115_8

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_0 + var_115_8 and arg_112_1.time_ < var_115_0 + var_115_8 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play111032028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 111032028
		arg_116_1.duration_ = 6.4

		local var_116_0 = {
			ja = 6.4,
			ko = 3.866,
			zh = 4.866,
			en = 2.833
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
				arg_116_0:Play111032029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_119_0 = arg_116_1.actors_["1094ui_story"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1094ui_story == nil then
				arg_116_1.var_.characterEffect1094ui_story = var_119_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_1 = 0.2

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_1 and not isNil(var_119_0) then
				if arg_116_1.var_.characterEffect1094ui_story and not isNil(var_119_0) then
					arg_116_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= 0 + var_119_1 and arg_116_1.time_ < 0 + var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1094ui_story then
				arg_116_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_119_3 = 0
			local var_119_4 = 0.475

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_3 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_5 = arg_116_1:GetWordFromCfg(111032028)
				local var_119_6 = arg_116_1:FormatText(var_119_5.content)

				arg_116_1.text_.text = var_119_6

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_8 = 19 <= 0 and var_119_4 or var_119_4 * (utf8.len(var_119_6) / 19)

				if (19 <= 0 and var_119_4 or var_119_4 * (utf8.len(var_119_6) / 19)) > 0 and var_119_4 < var_119_8 then
					arg_116_1.talkMaxDuration = var_119_8

					if var_119_8 + var_119_3 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_8 + var_119_3
					end
				end

				arg_116_1.text_.text = var_119_6
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111032", "111032028", "story_v_out_111032.awb") ~= 0 then
					local var_119_9 = manager.audio:GetVoiceLength("story_v_out_111032", "111032028", "story_v_out_111032.awb") / 1000

					if var_119_9 + var_119_3 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_9 + var_119_3
					end

					if var_119_5.prefab_name ~= "" and arg_116_1.actors_[var_119_5.prefab_name] ~= nil then
						local var_119_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_5.prefab_name].transform, "story_v_out_111032", "111032028", "story_v_out_111032.awb")

						arg_116_1:RecordAudio("111032028", var_119_10)
						arg_116_1:RecordAudio("111032028", var_119_10)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_111032", "111032028", "story_v_out_111032.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_111032", "111032028", "story_v_out_111032.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_11 = math.max(var_119_4, arg_116_1.talkMaxDuration)

			if var_119_3 <= arg_116_1.time_ and arg_116_1.time_ < var_119_3 + var_119_11 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_3) / var_119_11

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_3 + var_119_11 and arg_116_1.time_ < var_119_3 + var_119_11 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play111032029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 111032029
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play111032030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["1094ui_story"]) and arg_120_1.var_.characterEffect1094ui_story == nil then
				arg_120_1.var_.characterEffect1094ui_story = arg_120_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_0 = 0.2

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["1094ui_story"]) then
				if arg_120_1.var_.characterEffect1094ui_story and not isNil(arg_120_1.actors_["1094ui_story"]) then
					arg_120_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_120_1.time_ - 0) / var_123_0)
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["1094ui_story"]) and arg_120_1.var_.characterEffect1094ui_story then
				arg_120_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_123_1 = 0
			local var_123_2 = 0.275

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

				local var_123_3 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(111032029).content)

				arg_120_1.text_.text = var_123_3

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_5 = 11 <= 0 and var_123_2 or var_123_2 * (utf8.len(var_123_3) / 11)

				if (11 <= 0 and var_123_2 or var_123_2 * (utf8.len(var_123_3) / 11)) > 0 and var_123_2 < var_123_5 then
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
	Play111032030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 111032030
		arg_124_1.duration_ = 5.63

		local var_124_0 = {
			ja = 4.433,
			ko = 4.8,
			zh = 5.633,
			en = 3.933
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
				arg_124_0:Play111032031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094actionlink/1094action453")
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_127_0 = arg_124_1.actors_["1094ui_story"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect1094ui_story == nil then
				arg_124_1.var_.characterEffect1094ui_story = var_127_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_1 = 0.2

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_1 and not isNil(var_127_0) then
				if arg_124_1.var_.characterEffect1094ui_story and not isNil(var_127_0) then
					arg_124_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= 0 + var_127_1 and arg_124_1.time_ < 0 + var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect1094ui_story then
				arg_124_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_127_3 = 0
			local var_127_4 = 0.45

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_3 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_5 = arg_124_1:GetWordFromCfg(111032030)
				local var_127_6 = arg_124_1:FormatText(var_127_5.content)

				arg_124_1.text_.text = var_127_6

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_8 = 18 <= 0 and var_127_4 or var_127_4 * (utf8.len(var_127_6) / 18)

				if (18 <= 0 and var_127_4 or var_127_4 * (utf8.len(var_127_6) / 18)) > 0 and var_127_4 < var_127_8 then
					arg_124_1.talkMaxDuration = var_127_8

					if var_127_8 + var_127_3 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_8 + var_127_3
					end
				end

				arg_124_1.text_.text = var_127_6
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111032", "111032030", "story_v_out_111032.awb") ~= 0 then
					local var_127_9 = manager.audio:GetVoiceLength("story_v_out_111032", "111032030", "story_v_out_111032.awb") / 1000

					if var_127_9 + var_127_3 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_9 + var_127_3
					end

					if var_127_5.prefab_name ~= "" and arg_124_1.actors_[var_127_5.prefab_name] ~= nil then
						local var_127_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_5.prefab_name].transform, "story_v_out_111032", "111032030", "story_v_out_111032.awb")

						arg_124_1:RecordAudio("111032030", var_127_10)
						arg_124_1:RecordAudio("111032030", var_127_10)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_111032", "111032030", "story_v_out_111032.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_111032", "111032030", "story_v_out_111032.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_11 = math.max(var_127_4, arg_124_1.talkMaxDuration)

			if var_127_3 <= arg_124_1.time_ and arg_124_1.time_ < var_127_3 + var_127_11 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_3) / var_127_11

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_3 + var_127_11 and arg_124_1.time_ < var_127_3 + var_127_11 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play111032031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 111032031
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play111032032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["1094ui_story"]) and arg_128_1.var_.characterEffect1094ui_story == nil then
				arg_128_1.var_.characterEffect1094ui_story = arg_128_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_0 = 0.2

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["1094ui_story"]) then
				if arg_128_1.var_.characterEffect1094ui_story and not isNil(arg_128_1.actors_["1094ui_story"]) then
					arg_128_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_128_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_128_1.time_ - 0) / var_131_0)
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["1094ui_story"]) and arg_128_1.var_.characterEffect1094ui_story then
				arg_128_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_128_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_131_1 = 0
			local var_131_2 = 0.85

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, true)
				arg_128_1.iconController_:SetSelectedState("hero")

				arg_128_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_128_1.callingController_:SetSelectedState("normal")

				arg_128_1.keyicon_.color = Color.New(1, 1, 1)
				arg_128_1.icon_.color = Color.New(1, 1, 1)

				local var_131_3 = arg_128_1:FormatText(arg_128_1:GetWordFromCfg(111032031).content)

				arg_128_1.text_.text = var_131_3

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_5 = 34 <= 0 and var_131_2 or var_131_2 * (utf8.len(var_131_3) / 34)

				if (34 <= 0 and var_131_2 or var_131_2 * (utf8.len(var_131_3) / 34)) > 0 and var_131_2 < var_131_5 then
					arg_128_1.talkMaxDuration = var_131_5

					if var_131_5 + var_131_1 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_5 + var_131_1
					end
				end

				arg_128_1.text_.text = var_131_3
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_6 = math.max(var_131_2, arg_128_1.talkMaxDuration)

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_6 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_1) / var_131_6

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_1 + var_131_6 and arg_128_1.time_ < var_131_1 + var_131_6 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play111032032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 111032032
		arg_132_1.duration_ = 2

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play111032033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_135_0 = arg_132_1.actors_["1094ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1094ui_story == nil then
				arg_132_1.var_.characterEffect1094ui_story = var_135_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_1 = 0.2

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_1 and not isNil(var_135_0) then
				if arg_132_1.var_.characterEffect1094ui_story and not isNil(var_135_0) then
					arg_132_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= 0 + var_135_1 and arg_132_1.time_ < 0 + var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1094ui_story then
				arg_132_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_135_3 = 0
			local var_135_4 = 0.2

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_3 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_5 = arg_132_1:GetWordFromCfg(111032032)
				local var_135_6 = arg_132_1:FormatText(var_135_5.content)

				arg_132_1.text_.text = var_135_6

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_8 = 2 <= 0 and var_135_4 or var_135_4 * (utf8.len(var_135_6) / 2)

				if (2 <= 0 and var_135_4 or var_135_4 * (utf8.len(var_135_6) / 2)) > 0 and var_135_4 < var_135_8 then
					arg_132_1.talkMaxDuration = var_135_8

					if var_135_8 + var_135_3 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_8 + var_135_3
					end
				end

				arg_132_1.text_.text = var_135_6
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111032", "111032032", "story_v_out_111032.awb") ~= 0 then
					local var_135_9 = manager.audio:GetVoiceLength("story_v_out_111032", "111032032", "story_v_out_111032.awb") / 1000

					if var_135_9 + var_135_3 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_9 + var_135_3
					end

					if var_135_5.prefab_name ~= "" and arg_132_1.actors_[var_135_5.prefab_name] ~= nil then
						local var_135_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_5.prefab_name].transform, "story_v_out_111032", "111032032", "story_v_out_111032.awb")

						arg_132_1:RecordAudio("111032032", var_135_10)
						arg_132_1:RecordAudio("111032032", var_135_10)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_111032", "111032032", "story_v_out_111032.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_111032", "111032032", "story_v_out_111032.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_11 = math.max(var_135_4, arg_132_1.talkMaxDuration)

			if var_135_3 <= arg_132_1.time_ and arg_132_1.time_ < var_135_3 + var_135_11 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_3) / var_135_11

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_3 + var_135_11 and arg_132_1.time_ < var_135_3 + var_135_11 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play111032033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 111032033
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play111032034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos1094ui_story = arg_136_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_139_0 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 then
				arg_136_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1094ui_story, Vector3.New(0, 100, 0), (arg_136_1.time_ - 0) / var_139_0)
				arg_136_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1094ui_story"].transform.position).z)
				arg_136_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["1094ui_story"].transform.localEulerAngles = arg_136_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 then
				arg_136_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_136_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1094ui_story"].transform.position).z)
				arg_136_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["1094ui_story"].transform.localEulerAngles = arg_136_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_139_1 = 0
			local var_139_2 = 1.5

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_3 = arg_136_1:FormatText(arg_136_1:GetWordFromCfg(111032033).content)

				arg_136_1.text_.text = var_139_3

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_5 = 60 <= 0 and var_139_2 or var_139_2 * (utf8.len(var_139_3) / 60)

				if (60 <= 0 and var_139_2 or var_139_2 * (utf8.len(var_139_3) / 60)) > 0 and var_139_2 < var_139_5 then
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

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play111032034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 111032034
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play111032035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0.775

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_1 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(111032034).content)

				arg_140_1.text_.text = var_143_1

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_3 = 31 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_1) / 31)

				if (31 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_1) / 31)) > 0 and var_143_0 < var_143_3 then
					arg_140_1.talkMaxDuration = var_143_3

					if var_143_3 + 0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_3 + 0
					end
				end

				arg_140_1.text_.text = var_143_1
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_4 = math.max(var_143_0, arg_140_1.talkMaxDuration)

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_4 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - 0) / var_143_4

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= 0 + var_143_4 and arg_140_1.time_ < 0 + var_143_4 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play111032035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 111032035
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play111032036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0.4

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_1 = arg_144_1:FormatText(arg_144_1:GetWordFromCfg(111032035).content)

				arg_144_1.text_.text = var_147_1

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_3 = 16 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_1) / 16)

				if (16 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_1) / 16)) > 0 and var_147_0 < var_147_3 then
					arg_144_1.talkMaxDuration = var_147_3

					if var_147_3 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_3 + 0
					end
				end

				arg_144_1.text_.text = var_147_1
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_4 = math.max(var_147_0, arg_144_1.talkMaxDuration)

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_4 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - 0) / var_147_4

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= 0 + var_147_4 and arg_144_1.time_ < 0 + var_147_4 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play111032036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 111032036
		arg_148_1.duration_ = 5.3

		local var_148_0 = {
			ja = 5.3,
			ko = 2.466,
			zh = 3.433,
			en = 2.533
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
				arg_148_0:Play111032037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0.275

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, true)
				arg_148_1.iconController_:SetSelectedState("hero")

				arg_148_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1094")

				arg_148_1.callingController_:SetSelectedState("normal")

				arg_148_1.keyicon_.color = Color.New(1, 1, 1)
				arg_148_1.icon_.color = Color.New(1, 1, 1)

				local var_151_1 = arg_148_1:GetWordFromCfg(111032036)
				local var_151_2 = arg_148_1:FormatText(var_151_1.content)

				arg_148_1.text_.text = var_151_2

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_4 = 11 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_2) / 11)

				if (11 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_2) / 11)) > 0 and var_151_0 < var_151_4 then
					arg_148_1.talkMaxDuration = var_151_4

					if var_151_4 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_4 + 0
					end
				end

				arg_148_1.text_.text = var_151_2
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111032", "111032036", "story_v_out_111032.awb") ~= 0 then
					local var_151_5 = manager.audio:GetVoiceLength("story_v_out_111032", "111032036", "story_v_out_111032.awb") / 1000

					if var_151_5 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_5 + 0
					end

					if var_151_1.prefab_name ~= "" and arg_148_1.actors_[var_151_1.prefab_name] ~= nil then
						local var_151_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_1.prefab_name].transform, "story_v_out_111032", "111032036", "story_v_out_111032.awb")

						arg_148_1:RecordAudio("111032036", var_151_6)
						arg_148_1:RecordAudio("111032036", var_151_6)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_111032", "111032036", "story_v_out_111032.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_111032", "111032036", "story_v_out_111032.awb")
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
	Play111032037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 111032037
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play111032038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0.95

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, false)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_1 = arg_152_1:FormatText(arg_152_1:GetWordFromCfg(111032037).content)

				arg_152_1.text_.text = var_155_1

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_3 = 38 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_1) / 38)

				if (38 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_1) / 38)) > 0 and var_155_0 < var_155_3 then
					arg_152_1.talkMaxDuration = var_155_3

					if var_155_3 + 0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_3 + 0
					end
				end

				arg_152_1.text_.text = var_155_1
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_4 = math.max(var_155_0, arg_152_1.talkMaxDuration)

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_4 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - 0) / var_155_4

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= 0 + var_155_4 and arg_152_1.time_ < 0 + var_155_4 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play111032038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 111032038
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play111032039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 1.175

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_1 = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(111032038).content)

				arg_156_1.text_.text = var_159_1

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_3 = 46 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_1) / 46)

				if (46 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_1) / 46)) > 0 and var_159_0 < var_159_3 then
					arg_156_1.talkMaxDuration = var_159_3

					if var_159_3 + 0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_3 + 0
					end
				end

				arg_156_1.text_.text = var_159_1
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_4 = math.max(var_159_0, arg_156_1.talkMaxDuration)

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_4 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - 0) / var_159_4

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= 0 + var_159_4 and arg_156_1.time_ < 0 + var_159_4 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play111032039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 111032039
		arg_160_1.duration_ = 6.13

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play111032040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				local var_163_0 = arg_160_1.bgs_.D05:GetComponent("SpriteRenderer")

				if var_163_0 then
					arg_160_1.var_.alphaOldValueD05 = var_163_0.color.a
					arg_160_1.var_.alphaMatValueD05 = var_163_0
				end

				arg_160_1.var_.alphaOldValueD05 = 1
			end

			local var_163_1 = 2

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_1 then
				if arg_160_1.var_.alphaMatValueD05 then
					arg_160_1.var_.alphaMatValueD05.color.a = Mathf.Lerp(arg_160_1.var_.alphaOldValueD05, 0, (arg_160_1.time_ - 0) / var_163_1)
					arg_160_1.var_.alphaMatValueD05.color = arg_160_1.var_.alphaMatValueD05.color
				end
			end

			if arg_160_1.time_ >= 0 + var_163_1 and arg_160_1.time_ < 0 + var_163_1 + arg_163_0 and arg_160_1.var_.alphaMatValueD05 then
				arg_160_1.var_.alphaMatValueD05.color.a = 0
				arg_160_1.var_.alphaMatValueD05.color = arg_160_1.var_.alphaMatValueD05.color
			end

			if 2 < arg_160_1.time_ and arg_160_1.time_ <= 2 + arg_163_0 then
				local var_163_2 = arg_160_1.bgs_.D05:GetComponent("SpriteRenderer")

				if var_163_2 then
					arg_160_1.var_.alphaOldValueD05 = var_163_2.color.a
					arg_160_1.var_.alphaMatValueD05 = var_163_2
				end
			end

			local var_163_3 = 1.3

			if 2 <= arg_160_1.time_ and arg_160_1.time_ < 2 + var_163_3 then
				if arg_160_1.var_.alphaMatValueD05 then
					arg_160_1.var_.alphaMatValueD05.color.a = Mathf.Lerp(arg_160_1.var_.alphaOldValueD05, 0.5, (arg_160_1.time_ - 2) / var_163_3)
					arg_160_1.var_.alphaMatValueD05.color = arg_160_1.var_.alphaMatValueD05.color
				end
			end

			if arg_160_1.time_ >= 2 + var_163_3 and arg_160_1.time_ < 2 + var_163_3 + arg_163_0 and arg_160_1.var_.alphaMatValueD05 then
				arg_160_1.var_.alphaMatValueD05.color.a = 0.5
				arg_160_1.var_.alphaMatValueD05.color = arg_160_1.var_.alphaMatValueD05.color
			end

			if 3.3 < arg_160_1.time_ and arg_160_1.time_ <= 3.3 + arg_163_0 then
				local var_163_4 = arg_160_1.bgs_.D05:GetComponent("SpriteRenderer")

				if var_163_4 then
					arg_160_1.var_.alphaOldValueD05 = var_163_4.color.a
					arg_160_1.var_.alphaMatValueD05 = var_163_4
				end

				arg_160_1.var_.alphaOldValueD05 = 1
			end

			local var_163_5 = 2.83333333333333

			if 3.3 <= arg_160_1.time_ and arg_160_1.time_ < 3.3 + var_163_5 then
				if arg_160_1.var_.alphaMatValueD05 then
					arg_160_1.var_.alphaMatValueD05.color.a = Mathf.Lerp(arg_160_1.var_.alphaOldValueD05, 0, (arg_160_1.time_ - 3.3) / var_163_5)
					arg_160_1.var_.alphaMatValueD05.color = arg_160_1.var_.alphaMatValueD05.color
				end
			end

			if arg_160_1.time_ >= 3.3 + var_163_5 and arg_160_1.time_ < 3.3 + var_163_5 + arg_163_0 and arg_160_1.var_.alphaMatValueD05 then
				arg_160_1.var_.alphaMatValueD05.color.a = 0
				arg_160_1.var_.alphaMatValueD05.color = arg_160_1.var_.alphaMatValueD05.color
			end

			local var_163_6 = 0

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_6 + arg_163_0 then
				arg_160_1.allBtn_.enabled = false
			end

			if arg_160_1.time_ >= var_163_6 + 6.13333333333333 and arg_160_1.time_ < var_163_6 + 6.13333333333333 + arg_163_0 then
				arg_160_1.allBtn_.enabled = true
			end

			local var_163_7 = 0
			local var_163_8 = 0.9

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_7 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_9 = arg_160_1:FormatText(arg_160_1:GetWordFromCfg(111032039).content)

				arg_160_1.text_.text = var_163_9

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_11 = 36 <= 0 and var_163_8 or var_163_8 * (utf8.len(var_163_9) / 36)

				if (36 <= 0 and var_163_8 or var_163_8 * (utf8.len(var_163_9) / 36)) > 0 and var_163_8 < var_163_11 then
					arg_160_1.talkMaxDuration = var_163_11

					if var_163_11 + var_163_7 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_11 + var_163_7
					end
				end

				arg_160_1.text_.text = var_163_9
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_12 = math.max(var_163_8, arg_160_1.talkMaxDuration)

			if var_163_7 <= arg_160_1.time_ and arg_160_1.time_ < var_163_7 + var_163_12 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_7) / var_163_12

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_7 + var_163_12 and arg_160_1.time_ < var_163_7 + var_163_12 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play111032040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 111032040
		arg_164_1.duration_ = 3.1

		local var_164_0 = {
			ja = 2.93266666666667,
			ko = 2.799999999999,
			zh = 2.799999999999,
			en = 3.09966666666667
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play111032041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if arg_164_1.actors_["1039ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1039ui_story"))) then
				local var_167_0 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_164_1.stage_.transform)

				var_167_0.name = "1039ui_story"
				var_167_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_164_1.actors_["1039ui_story"] = var_167_0

				local var_167_1 = var_167_0:GetComponentInChildren(typeof(CharacterEffect))

				var_167_1.enabled = true

				local var_167_2 = GameObjectTools.GetOrAddComponent(var_167_0, typeof(DynamicBoneHelper))

				if var_167_2 then
					var_167_2:EnableDynamicBone(false)
				end

				arg_164_1:ShowWeapon(var_167_1.transform, false)

				arg_164_1.var_["1039ui_story" .. "Animator"] = var_167_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_164_1.var_["1039ui_story" .. "Animator"].applyRootMotion = true
				arg_164_1.var_["1039ui_story" .. "LipSync"] = var_167_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_167_3 = arg_164_1.actors_["1039ui_story"].transform

			if 0.8 < arg_164_1.time_ and arg_164_1.time_ <= 0.8 + arg_167_0 then
				arg_164_1.var_.moveOldPos1039ui_story = var_167_3.localPosition
			end

			local var_167_4 = 0.001

			if 0.8 <= arg_164_1.time_ and arg_164_1.time_ < 0.8 + var_167_4 then
				var_167_3.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1039ui_story, Vector3.New(-0.7, -1.01, -5.9), (arg_164_1.time_ - 0.8) / var_167_4)
				var_167_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_3.position).x, (manager.ui.mainCamera.transform.position - var_167_3.position).y, (manager.ui.mainCamera.transform.position - var_167_3.position).z)
				var_167_3.localEulerAngles.z = 0
				var_167_3.localEulerAngles.x = 0
				var_167_3.localEulerAngles = var_167_3.localEulerAngles
			end

			if arg_164_1.time_ >= 0.8 + var_167_4 and arg_164_1.time_ < 0.8 + var_167_4 + arg_167_0 then
				var_167_3.localPosition = Vector3.New(-0.7, -1.01, -5.9)
				var_167_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_3.position).x, (manager.ui.mainCamera.transform.position - var_167_3.position).y, (manager.ui.mainCamera.transform.position - var_167_3.position).z)
				var_167_3.localEulerAngles.z = 0
				var_167_3.localEulerAngles.x = 0
				var_167_3.localEulerAngles = var_167_3.localEulerAngles
			end

			if 0.8 < arg_164_1.time_ and arg_164_1.time_ <= 0.8 + arg_167_0 then
				arg_164_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			if 0.8 < arg_164_1.time_ and arg_164_1.time_ <= 0.8 + arg_167_0 then
				arg_164_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2203cva")
			end

			local var_167_5 = arg_164_1.actors_["1039ui_story"]

			if 0.8 < arg_164_1.time_ and arg_164_1.time_ <= 0.8 + arg_167_0 and not isNil(var_167_5) and arg_164_1.var_.characterEffect1039ui_story == nil then
				arg_164_1.var_.characterEffect1039ui_story = var_167_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_6 = 0.2

			if 0.8 <= arg_164_1.time_ and arg_164_1.time_ < 0.8 + var_167_6 and not isNil(var_167_5) then
				if arg_164_1.var_.characterEffect1039ui_story and not isNil(var_167_5) then
					arg_164_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= 0.8 + var_167_6 and arg_164_1.time_ < 0.8 + var_167_6 + arg_167_0 and not isNil(var_167_5) and arg_164_1.var_.characterEffect1039ui_story then
				arg_164_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				local var_167_8 = arg_164_1.bgs_.D05:GetComponent("SpriteRenderer")

				if var_167_8 then
					arg_164_1.var_.alphaOldValueD05 = var_167_8.color.a
					arg_164_1.var_.alphaMatValueD05 = var_167_8
				end

				arg_164_1.var_.alphaOldValueD05 = 0
			end

			local var_167_9 = 1

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_9 then
				if arg_164_1.var_.alphaMatValueD05 then
					arg_164_1.var_.alphaMatValueD05.color.a = Mathf.Lerp(arg_164_1.var_.alphaOldValueD05, 1, (arg_164_1.time_ - 0) / var_167_9)
					arg_164_1.var_.alphaMatValueD05.color = arg_164_1.var_.alphaMatValueD05.color
				end
			end

			if arg_164_1.time_ >= 0 + var_167_9 and arg_164_1.time_ < 0 + var_167_9 + arg_167_0 and arg_164_1.var_.alphaMatValueD05 then
				arg_164_1.var_.alphaMatValueD05.color.a = 1
				arg_164_1.var_.alphaMatValueD05.color = arg_164_1.var_.alphaMatValueD05.color
			end

			local var_167_10 = 0

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_10 + arg_167_0 then
				arg_164_1.allBtn_.enabled = false
			end

			if arg_164_1.time_ >= var_167_10 + 1 and arg_164_1.time_ < var_167_10 + 1 + arg_167_0 then
				arg_164_1.allBtn_.enabled = true
			end

			if arg_164_1.frameCnt_ <= 1 then
				arg_164_1.dialog_:SetActive(false)
			end

			local var_167_11 = 0.166666666666667
			local var_167_12 = 0.25

			if 0.166666666666667 < arg_164_1.time_ and arg_164_1.time_ <= var_167_11 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0

				arg_164_1.dialog_:SetActive(true)

				arg_164_1.dialogCg_.alpha = 0

				local var_167_13 = LeanTween.value(arg_164_1.dialog_, 0, 1, 0.3)

				var_167_13:setOnUpdate(LuaHelper.FloatAction(function(arg_168_0)
					arg_164_1.dialogCg_.alpha = arg_168_0
				end))
				var_167_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_164_1.dialog_)
					var_167_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_164_1.duration_ = arg_164_1.duration_ + 0.3

				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_14 = arg_164_1:GetWordFromCfg(111032040)
				local var_167_15 = arg_164_1:FormatText(var_167_14.content)

				arg_164_1.text_.text = var_167_15

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_17 = 10 <= 0 and var_167_12 or var_167_12 * (utf8.len(var_167_15) / 10)

				if (10 <= 0 and var_167_12 or var_167_12 * (utf8.len(var_167_15) / 10)) > 0 and var_167_12 < var_167_17 then
					arg_164_1.talkMaxDuration = var_167_17
					var_167_11 = var_167_11 + 0.3

					if var_167_17 + var_167_11 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_17 + var_167_11
					end
				end

				arg_164_1.text_.text = var_167_15
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111032", "111032040", "story_v_out_111032.awb") ~= 0 then
					local var_167_18 = manager.audio:GetVoiceLength("story_v_out_111032", "111032040", "story_v_out_111032.awb") / 1000

					if var_167_18 + var_167_11 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_18 + var_167_11
					end

					if var_167_14.prefab_name ~= "" and arg_164_1.actors_[var_167_14.prefab_name] ~= nil then
						local var_167_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_14.prefab_name].transform, "story_v_out_111032", "111032040", "story_v_out_111032.awb")

						arg_164_1:RecordAudio("111032040", var_167_19)
						arg_164_1:RecordAudio("111032040", var_167_19)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_111032", "111032040", "story_v_out_111032.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_111032", "111032040", "story_v_out_111032.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_20 = var_167_11 + 0.3
			local var_167_21 = math.max(var_167_12, arg_164_1.talkMaxDuration)

			if var_167_11 + 0.3 <= arg_164_1.time_ and arg_164_1.time_ < var_167_20 + var_167_21 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_20) / var_167_21

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_20 + var_167_21 and arg_164_1.time_ < var_167_20 + var_167_21 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play111032041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 111032041
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play111032042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(arg_170_1.actors_["1039ui_story"]) and arg_170_1.var_.characterEffect1039ui_story == nil then
				arg_170_1.var_.characterEffect1039ui_story = arg_170_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_0 = 0.2

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 and not isNil(arg_170_1.actors_["1039ui_story"]) then
				if arg_170_1.var_.characterEffect1039ui_story and not isNil(arg_170_1.actors_["1039ui_story"]) then
					arg_170_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_170_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_170_1.time_ - 0) / var_173_0)
				end
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 and not isNil(arg_170_1.actors_["1039ui_story"]) and arg_170_1.var_.characterEffect1039ui_story then
				arg_170_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_170_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_173_1 = 0
			local var_173_2 = 0.325

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, true)
				arg_170_1.iconController_:SetSelectedState("hero")

				arg_170_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_170_1.callingController_:SetSelectedState("normal")

				arg_170_1.keyicon_.color = Color.New(1, 1, 1)
				arg_170_1.icon_.color = Color.New(1, 1, 1)

				local var_173_3 = arg_170_1:FormatText(arg_170_1:GetWordFromCfg(111032041).content)

				arg_170_1.text_.text = var_173_3

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_5 = 13 <= 0 and var_173_2 or var_173_2 * (utf8.len(var_173_3) / 13)

				if (13 <= 0 and var_173_2 or var_173_2 * (utf8.len(var_173_3) / 13)) > 0 and var_173_2 < var_173_5 then
					arg_170_1.talkMaxDuration = var_173_5

					if var_173_5 + var_173_1 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_5 + var_173_1
					end
				end

				arg_170_1.text_.text = var_173_3
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_6 = math.max(var_173_2, arg_170_1.talkMaxDuration)

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_6 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_1) / var_173_6

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_1 + var_173_6 and arg_170_1.time_ < var_173_1 + var_173_6 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play111032042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 111032042
		arg_174_1.duration_ = 7

		local var_174_0 = {
			ja = 4.766,
			ko = 5.1,
			zh = 5.6,
			en = 7
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
				arg_174_0:Play111032043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if arg_174_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_177_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_174_1.stage_.transform)

				var_177_0.name = "1084ui_story"
				var_177_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_174_1.actors_["1084ui_story"] = var_177_0

				local var_177_1 = var_177_0:GetComponentInChildren(typeof(CharacterEffect))

				var_177_1.enabled = true

				local var_177_2 = GameObjectTools.GetOrAddComponent(var_177_0, typeof(DynamicBoneHelper))

				if var_177_2 then
					var_177_2:EnableDynamicBone(false)
				end

				arg_174_1:ShowWeapon(var_177_1.transform, false)

				arg_174_1.var_["1084ui_story" .. "Animator"] = var_177_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_174_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_174_1.var_["1084ui_story" .. "LipSync"] = var_177_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_177_3 = arg_174_1.actors_["1084ui_story"].transform

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos1084ui_story = var_177_3.localPosition
			end

			local var_177_4 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_4 then
				var_177_3.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_174_1.time_ - 0) / var_177_4)
				var_177_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_177_3.position).x, (manager.ui.mainCamera.transform.position - var_177_3.position).y, (manager.ui.mainCamera.transform.position - var_177_3.position).z)
				var_177_3.localEulerAngles.z = 0
				var_177_3.localEulerAngles.x = 0
				var_177_3.localEulerAngles = var_177_3.localEulerAngles
			end

			if arg_174_1.time_ >= 0 + var_177_4 and arg_174_1.time_ < 0 + var_177_4 + arg_177_0 then
				var_177_3.localPosition = Vector3.New(0, -0.97, -6)
				var_177_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_177_3.position).x, (manager.ui.mainCamera.transform.position - var_177_3.position).y, (manager.ui.mainCamera.transform.position - var_177_3.position).z)
				var_177_3.localEulerAngles.z = 0
				var_177_3.localEulerAngles.x = 0
				var_177_3.localEulerAngles = var_177_3.localEulerAngles
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2203cva")
			end

			local var_177_5 = arg_174_1.actors_["1039ui_story"]

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(var_177_5) and arg_174_1.var_.characterEffect1039ui_story == nil then
				arg_174_1.var_.characterEffect1039ui_story = var_177_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_6 = 0.2

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_6 and not isNil(var_177_5) then
				if arg_174_1.var_.characterEffect1039ui_story and not isNil(var_177_5) then
					arg_174_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_174_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_174_1.time_ - 0) / var_177_6)
				end
			end

			if arg_174_1.time_ >= 0 + var_177_6 and arg_174_1.time_ < 0 + var_177_6 + arg_177_0 and not isNil(var_177_5) and arg_174_1.var_.characterEffect1039ui_story then
				arg_174_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_174_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_177_7 = arg_174_1.actors_["1084ui_story"]

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(var_177_7) and arg_174_1.var_.characterEffect1084ui_story == nil then
				arg_174_1.var_.characterEffect1084ui_story = var_177_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_8 = 0.2

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_8 and not isNil(var_177_7) then
				if arg_174_1.var_.characterEffect1084ui_story and not isNil(var_177_7) then
					arg_174_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_174_1.time_ >= 0 + var_177_8 and arg_174_1.time_ < 0 + var_177_8 + arg_177_0 and not isNil(var_177_7) and arg_174_1.var_.characterEffect1084ui_story then
				arg_174_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_177_10 = 0
			local var_177_11 = 0.775

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_10 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_12 = arg_174_1:GetWordFromCfg(111032042)
				local var_177_13 = arg_174_1:FormatText(var_177_12.content)

				arg_174_1.text_.text = var_177_13

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_15 = 31 <= 0 and var_177_11 or var_177_11 * (utf8.len(var_177_13) / 31)

				if (31 <= 0 and var_177_11 or var_177_11 * (utf8.len(var_177_13) / 31)) > 0 and var_177_11 < var_177_15 then
					arg_174_1.talkMaxDuration = var_177_15

					if var_177_15 + var_177_10 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_15 + var_177_10
					end
				end

				arg_174_1.text_.text = var_177_13
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111032", "111032042", "story_v_out_111032.awb") ~= 0 then
					local var_177_16 = manager.audio:GetVoiceLength("story_v_out_111032", "111032042", "story_v_out_111032.awb") / 1000

					if var_177_16 + var_177_10 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_16 + var_177_10
					end

					if var_177_12.prefab_name ~= "" and arg_174_1.actors_[var_177_12.prefab_name] ~= nil then
						local var_177_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_12.prefab_name].transform, "story_v_out_111032", "111032042", "story_v_out_111032.awb")

						arg_174_1:RecordAudio("111032042", var_177_17)
						arg_174_1:RecordAudio("111032042", var_177_17)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_111032", "111032042", "story_v_out_111032.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_111032", "111032042", "story_v_out_111032.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_18 = math.max(var_177_11, arg_174_1.talkMaxDuration)

			if var_177_10 <= arg_174_1.time_ and arg_174_1.time_ < var_177_10 + var_177_18 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_10) / var_177_18

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_10 + var_177_18 and arg_174_1.time_ < var_177_10 + var_177_18 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
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

		arg_174_1:InitPlayNodeList()
	end,
	Play111032043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 111032043
		arg_178_1.duration_ = 4.2

		local var_178_0 = {
			ja = 3.833,
			ko = 2.9,
			zh = 3.166,
			en = 4.2
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
				arg_178_0:Play111032044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if arg_178_1.actors_["1048ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1048ui_story"))) then
				local var_181_0 = Object.Instantiate(Asset.Load("Char/" .. "1048ui_story"), arg_178_1.stage_.transform)

				var_181_0.name = "1048ui_story"
				var_181_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_178_1.actors_["1048ui_story"] = var_181_0

				local var_181_1 = var_181_0:GetComponentInChildren(typeof(CharacterEffect))

				var_181_1.enabled = true

				local var_181_2 = GameObjectTools.GetOrAddComponent(var_181_0, typeof(DynamicBoneHelper))

				if var_181_2 then
					var_181_2:EnableDynamicBone(false)
				end

				arg_178_1:ShowWeapon(var_181_1.transform, false)

				arg_178_1.var_["1048ui_story" .. "Animator"] = var_181_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_178_1.var_["1048ui_story" .. "Animator"].applyRootMotion = true
				arg_178_1.var_["1048ui_story" .. "LipSync"] = var_181_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_181_3 = arg_178_1.actors_["1048ui_story"].transform

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos1048ui_story = var_181_3.localPosition
			end

			local var_181_4 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_4 then
				var_181_3.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1048ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_178_1.time_ - 0) / var_181_4)
				var_181_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_181_3.position).x, (manager.ui.mainCamera.transform.position - var_181_3.position).y, (manager.ui.mainCamera.transform.position - var_181_3.position).z)
				var_181_3.localEulerAngles.z = 0
				var_181_3.localEulerAngles.x = 0
				var_181_3.localEulerAngles = var_181_3.localEulerAngles
			end

			if arg_178_1.time_ >= 0 + var_181_4 and arg_178_1.time_ < 0 + var_181_4 + arg_181_0 then
				var_181_3.localPosition = Vector3.New(0.7, -0.8, -6.2)
				var_181_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_181_3.position).x, (manager.ui.mainCamera.transform.position - var_181_3.position).y, (manager.ui.mainCamera.transform.position - var_181_3.position).z)
				var_181_3.localEulerAngles.z = 0
				var_181_3.localEulerAngles.x = 0
				var_181_3.localEulerAngles = var_181_3.localEulerAngles
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action4_1")
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_181_5 = arg_178_1.actors_["1048ui_story"]

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(var_181_5) and arg_178_1.var_.characterEffect1048ui_story == nil then
				arg_178_1.var_.characterEffect1048ui_story = var_181_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_6 = 0.2

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_6 and not isNil(var_181_5) then
				if arg_178_1.var_.characterEffect1048ui_story and not isNil(var_181_5) then
					arg_178_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= 0 + var_181_6 and arg_178_1.time_ < 0 + var_181_6 + arg_181_0 and not isNil(var_181_5) and arg_178_1.var_.characterEffect1048ui_story then
				arg_178_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_181_8 = arg_178_1.actors_["1084ui_story"]

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(var_181_8) and arg_178_1.var_.characterEffect1084ui_story == nil then
				arg_178_1.var_.characterEffect1084ui_story = var_181_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_9 = 0.2

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_9 and not isNil(var_181_8) then
				if arg_178_1.var_.characterEffect1084ui_story and not isNil(var_181_8) then
					arg_178_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_178_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_178_1.time_ - 0) / var_181_9)
				end
			end

			if arg_178_1.time_ >= 0 + var_181_9 and arg_178_1.time_ < 0 + var_181_9 + arg_181_0 and not isNil(var_181_8) and arg_178_1.var_.characterEffect1084ui_story then
				arg_178_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_178_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_181_10 = 0
			local var_181_11 = 0.325

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_10 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_12 = arg_178_1:GetWordFromCfg(111032043)
				local var_181_13 = arg_178_1:FormatText(var_181_12.content)

				arg_178_1.text_.text = var_181_13

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_15 = 13 <= 0 and var_181_11 or var_181_11 * (utf8.len(var_181_13) / 13)

				if (13 <= 0 and var_181_11 or var_181_11 * (utf8.len(var_181_13) / 13)) > 0 and var_181_11 < var_181_15 then
					arg_178_1.talkMaxDuration = var_181_15

					if var_181_15 + var_181_10 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_15 + var_181_10
					end
				end

				arg_178_1.text_.text = var_181_13
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111032", "111032043", "story_v_out_111032.awb") ~= 0 then
					local var_181_16 = manager.audio:GetVoiceLength("story_v_out_111032", "111032043", "story_v_out_111032.awb") / 1000

					if var_181_16 + var_181_10 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_16 + var_181_10
					end

					if var_181_12.prefab_name ~= "" and arg_178_1.actors_[var_181_12.prefab_name] ~= nil then
						local var_181_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_12.prefab_name].transform, "story_v_out_111032", "111032043", "story_v_out_111032.awb")

						arg_178_1:RecordAudio("111032043", var_181_17)
						arg_178_1:RecordAudio("111032043", var_181_17)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_111032", "111032043", "story_v_out_111032.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_111032", "111032043", "story_v_out_111032.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_18 = math.max(var_181_11, arg_178_1.talkMaxDuration)

			if var_181_10 <= arg_178_1.time_ and arg_178_1.time_ < var_181_10 + var_181_18 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_10) / var_181_18

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_10 + var_181_18 and arg_178_1.time_ < var_181_10 + var_181_18 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play111032044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 111032044
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play111032045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(arg_182_1.actors_["1048ui_story"]) and arg_182_1.var_.characterEffect1048ui_story == nil then
				arg_182_1.var_.characterEffect1048ui_story = arg_182_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_0 = 0.2

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 and not isNil(arg_182_1.actors_["1048ui_story"]) then
				if arg_182_1.var_.characterEffect1048ui_story and not isNil(arg_182_1.actors_["1048ui_story"]) then
					arg_182_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_182_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_182_1.time_ - 0) / var_185_0)
				end
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 and not isNil(arg_182_1.actors_["1048ui_story"]) and arg_182_1.var_.characterEffect1048ui_story then
				arg_182_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_182_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_185_1 = 0
			local var_185_2 = 0.425

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, true)
				arg_182_1.iconController_:SetSelectedState("hero")

				arg_182_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_182_1.callingController_:SetSelectedState("normal")

				arg_182_1.keyicon_.color = Color.New(1, 1, 1)
				arg_182_1.icon_.color = Color.New(1, 1, 1)

				local var_185_3 = arg_182_1:FormatText(arg_182_1:GetWordFromCfg(111032044).content)

				arg_182_1.text_.text = var_185_3

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_5 = 17 <= 0 and var_185_2 or var_185_2 * (utf8.len(var_185_3) / 17)

				if (17 <= 0 and var_185_2 or var_185_2 * (utf8.len(var_185_3) / 17)) > 0 and var_185_2 < var_185_5 then
					arg_182_1.talkMaxDuration = var_185_5

					if var_185_5 + var_185_1 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_5 + var_185_1
					end
				end

				arg_182_1.text_.text = var_185_3
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_6 = math.max(var_185_2, arg_182_1.talkMaxDuration)

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_6 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_1) / var_185_6

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_1 + var_185_6 and arg_182_1.time_ < var_185_1 + var_185_6 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play111032045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 111032045
		arg_186_1.duration_ = 11.63

		local var_186_0 = {
			ja = 5.766,
			ko = 10.2,
			zh = 8.766,
			en = 11.633
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
				arg_186_0:Play111032046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action452")
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_189_0 = arg_186_1.actors_["1039ui_story"]

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.characterEffect1039ui_story == nil then
				arg_186_1.var_.characterEffect1039ui_story = var_189_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_1 = 0.2

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_1 and not isNil(var_189_0) then
				if arg_186_1.var_.characterEffect1039ui_story and not isNil(var_189_0) then
					arg_186_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= 0 + var_189_1 and arg_186_1.time_ < 0 + var_189_1 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.characterEffect1039ui_story then
				arg_186_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_189_3 = 0
			local var_189_4 = 1.15

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_3 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_5 = arg_186_1:GetWordFromCfg(111032045)
				local var_189_6 = arg_186_1:FormatText(var_189_5.content)

				arg_186_1.text_.text = var_189_6

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_8 = 46 <= 0 and var_189_4 or var_189_4 * (utf8.len(var_189_6) / 46)

				if (46 <= 0 and var_189_4 or var_189_4 * (utf8.len(var_189_6) / 46)) > 0 and var_189_4 < var_189_8 then
					arg_186_1.talkMaxDuration = var_189_8

					if var_189_8 + var_189_3 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_8 + var_189_3
					end
				end

				arg_186_1.text_.text = var_189_6
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111032", "111032045", "story_v_out_111032.awb") ~= 0 then
					local var_189_9 = manager.audio:GetVoiceLength("story_v_out_111032", "111032045", "story_v_out_111032.awb") / 1000

					if var_189_9 + var_189_3 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_9 + var_189_3
					end

					if var_189_5.prefab_name ~= "" and arg_186_1.actors_[var_189_5.prefab_name] ~= nil then
						local var_189_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_5.prefab_name].transform, "story_v_out_111032", "111032045", "story_v_out_111032.awb")

						arg_186_1:RecordAudio("111032045", var_189_10)
						arg_186_1:RecordAudio("111032045", var_189_10)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_111032", "111032045", "story_v_out_111032.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_111032", "111032045", "story_v_out_111032.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_11 = math.max(var_189_4, arg_186_1.talkMaxDuration)

			if var_189_3 <= arg_186_1.time_ and arg_186_1.time_ < var_189_3 + var_189_11 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_3) / var_189_11

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_3 + var_189_11 and arg_186_1.time_ < var_189_3 + var_189_11 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play111032046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 111032046
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play111032047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(arg_190_1.actors_["1039ui_story"]) and arg_190_1.var_.characterEffect1039ui_story == nil then
				arg_190_1.var_.characterEffect1039ui_story = arg_190_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_0 = 0.2

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 and not isNil(arg_190_1.actors_["1039ui_story"]) then
				if arg_190_1.var_.characterEffect1039ui_story and not isNil(arg_190_1.actors_["1039ui_story"]) then
					arg_190_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_190_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_190_1.time_ - 0) / var_193_0)
				end
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 and not isNil(arg_190_1.actors_["1039ui_story"]) and arg_190_1.var_.characterEffect1039ui_story then
				arg_190_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_190_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_193_1 = 0
			local var_193_2 = 0.175

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, true)
				arg_190_1.iconController_:SetSelectedState("hero")

				arg_190_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_190_1.callingController_:SetSelectedState("normal")

				arg_190_1.keyicon_.color = Color.New(1, 1, 1)
				arg_190_1.icon_.color = Color.New(1, 1, 1)

				local var_193_3 = arg_190_1:FormatText(arg_190_1:GetWordFromCfg(111032046).content)

				arg_190_1.text_.text = var_193_3

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_5 = 7 <= 0 and var_193_2 or var_193_2 * (utf8.len(var_193_3) / 7)

				if (7 <= 0 and var_193_2 or var_193_2 * (utf8.len(var_193_3) / 7)) > 0 and var_193_2 < var_193_5 then
					arg_190_1.talkMaxDuration = var_193_5

					if var_193_5 + var_193_1 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_5 + var_193_1
					end
				end

				arg_190_1.text_.text = var_193_3
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_6 = math.max(var_193_2, arg_190_1.talkMaxDuration)

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_6 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_1) / var_193_6

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_1 + var_193_6 and arg_190_1.time_ < var_193_1 + var_193_6 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play111032047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 111032047
		arg_194_1.duration_ = 3.67

		local var_194_0 = {
			ja = 3.666,
			ko = 2.5,
			zh = 2.066,
			en = 2.533
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
				arg_194_0:Play111032048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_197_0 = arg_194_1.actors_["1039ui_story"]

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.characterEffect1039ui_story == nil then
				arg_194_1.var_.characterEffect1039ui_story = var_197_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_1 = 0.2

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_1 and not isNil(var_197_0) then
				if arg_194_1.var_.characterEffect1039ui_story and not isNil(var_197_0) then
					arg_194_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= 0 + var_197_1 and arg_194_1.time_ < 0 + var_197_1 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.characterEffect1039ui_story then
				arg_194_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_197_3 = 0
			local var_197_4 = 0.2

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_3 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_5 = arg_194_1:GetWordFromCfg(111032047)
				local var_197_6 = arg_194_1:FormatText(var_197_5.content)

				arg_194_1.text_.text = var_197_6

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_8 = 8 <= 0 and var_197_4 or var_197_4 * (utf8.len(var_197_6) / 8)

				if (8 <= 0 and var_197_4 or var_197_4 * (utf8.len(var_197_6) / 8)) > 0 and var_197_4 < var_197_8 then
					arg_194_1.talkMaxDuration = var_197_8

					if var_197_8 + var_197_3 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_8 + var_197_3
					end
				end

				arg_194_1.text_.text = var_197_6
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111032", "111032047", "story_v_out_111032.awb") ~= 0 then
					local var_197_9 = manager.audio:GetVoiceLength("story_v_out_111032", "111032047", "story_v_out_111032.awb") / 1000

					if var_197_9 + var_197_3 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_9 + var_197_3
					end

					if var_197_5.prefab_name ~= "" and arg_194_1.actors_[var_197_5.prefab_name] ~= nil then
						local var_197_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_5.prefab_name].transform, "story_v_out_111032", "111032047", "story_v_out_111032.awb")

						arg_194_1:RecordAudio("111032047", var_197_10)
						arg_194_1:RecordAudio("111032047", var_197_10)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_111032", "111032047", "story_v_out_111032.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_111032", "111032047", "story_v_out_111032.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_11 = math.max(var_197_4, arg_194_1.talkMaxDuration)

			if var_197_3 <= arg_194_1.time_ and arg_194_1.time_ < var_197_3 + var_197_11 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_3) / var_197_11

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_3 + var_197_11 and arg_194_1.time_ < var_197_3 + var_197_11 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play111032048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 111032048
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
			arg_198_1.auto_ = false
		end

		function arg_198_1.playNext_(arg_200_0)
			arg_198_1.onStoryFinished_()
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPos1039ui_story = arg_198_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_201_0 = 0.001

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 then
				arg_198_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_198_1.time_ - 0) / var_201_0)
				arg_198_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1039ui_story"].transform.position).z)
				arg_198_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["1039ui_story"].transform.localEulerAngles = arg_198_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 then
				arg_198_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_198_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1039ui_story"].transform.position).z)
				arg_198_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["1039ui_story"].transform.localEulerAngles = arg_198_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_201_1 = arg_198_1.actors_["1048ui_story"].transform

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPos1048ui_story = var_201_1.localPosition
			end

			local var_201_2 = 0.001

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_2 then
				var_201_1.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1048ui_story, Vector3.New(0, 100, 0), (arg_198_1.time_ - 0) / var_201_2)
				var_201_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_201_1.position).x, (manager.ui.mainCamera.transform.position - var_201_1.position).y, (manager.ui.mainCamera.transform.position - var_201_1.position).z)
				var_201_1.localEulerAngles.z = 0
				var_201_1.localEulerAngles.x = 0
				var_201_1.localEulerAngles = var_201_1.localEulerAngles
			end

			if arg_198_1.time_ >= 0 + var_201_2 and arg_198_1.time_ < 0 + var_201_2 + arg_201_0 then
				var_201_1.localPosition = Vector3.New(0, 100, 0)
				var_201_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_201_1.position).x, (manager.ui.mainCamera.transform.position - var_201_1.position).y, (manager.ui.mainCamera.transform.position - var_201_1.position).z)
				var_201_1.localEulerAngles.z = 0
				var_201_1.localEulerAngles.x = 0
				var_201_1.localEulerAngles = var_201_1.localEulerAngles
			end

			local var_201_3 = arg_198_1.actors_["1084ui_story"].transform

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPos1084ui_story = var_201_3.localPosition
			end

			local var_201_4 = 0.001

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_4 then
				var_201_3.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_198_1.time_ - 0) / var_201_4)
				var_201_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_201_3.position).x, (manager.ui.mainCamera.transform.position - var_201_3.position).y, (manager.ui.mainCamera.transform.position - var_201_3.position).z)
				var_201_3.localEulerAngles.z = 0
				var_201_3.localEulerAngles.x = 0
				var_201_3.localEulerAngles = var_201_3.localEulerAngles
			end

			if arg_198_1.time_ >= 0 + var_201_4 and arg_198_1.time_ < 0 + var_201_4 + arg_201_0 then
				var_201_3.localPosition = Vector3.New(0, 100, 0)
				var_201_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_201_3.position).x, (manager.ui.mainCamera.transform.position - var_201_3.position).y, (manager.ui.mainCamera.transform.position - var_201_3.position).z)
				var_201_3.localEulerAngles.z = 0
				var_201_3.localEulerAngles.x = 0
				var_201_3.localEulerAngles = var_201_3.localEulerAngles
			end

			local var_201_5 = 0
			local var_201_6 = 0.775

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_5 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, false)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_7 = arg_198_1:FormatText(arg_198_1:GetWordFromCfg(111032048).content)

				arg_198_1.text_.text = var_201_7

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_9 = 31 <= 0 and var_201_6 or var_201_6 * (utf8.len(var_201_7) / 31)

				if (31 <= 0 and var_201_6 or var_201_6 * (utf8.len(var_201_7) / 31)) > 0 and var_201_6 < var_201_9 then
					arg_198_1.talkMaxDuration = var_201_9

					if var_201_9 + var_201_5 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_9 + var_201_5
					end
				end

				arg_198_1.text_.text = var_201_7
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_10 = math.max(var_201_6, arg_198_1.talkMaxDuration)

			if var_201_5 <= arg_198_1.time_ and arg_198_1.time_ < var_201_5 + var_201_10 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_5) / var_201_10

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_5 + var_201_10 and arg_198_1.time_ < var_201_5 + var_201_10 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_198_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/D05",
		"TextureConfig/Background/AS0101"
	},
	voices = {
		"story_v_out_111032.awb"
	}
}
