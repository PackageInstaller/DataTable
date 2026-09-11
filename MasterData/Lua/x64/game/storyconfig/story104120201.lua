return {
	Play412021001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 412021001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play412021002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I09f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I09f")
				var_4_0.name = "I09f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I09f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I09f

				arg_1_1.bgs_.I09f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I09f" then
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

			if 0.266666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.266666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_2_story_corridor_dream", "bgm_activity_3_2_story_corridor_dream", "bgm_activity_3_2_story_corridor_dream.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_3_2_story_corridor_dream", "bgm_activity_3_2_story_corridor_dream")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_15 = 1.999999999999
			local var_4_16 = 1.25

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_17 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_17:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(412021001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 50 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 50)

				if (50 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 50)) > 0 and var_4_16 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_15 = var_4_15 + 0.3

					if var_4_20 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_21 = var_4_15 + 0.3
			local var_4_22 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_21 + var_4_22 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_21) / var_4_22

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_21 + var_4_22 and arg_1_1.time_ < var_4_21 + var_4_22 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play412021002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 412021002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play412021003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.775

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(412021002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 31 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 31)

				if (31 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 31)) > 0 and var_12_0 < var_12_3 then
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
	Play412021003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 412021003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play412021004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.975

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(412021003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 39 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 39)

				if (39 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 39)) > 0 and var_16_0 < var_16_3 then
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
	Play412021004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 412021004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play412021005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 1.125

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

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(412021004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 45 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 45)

				if (45 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 45)) > 0 and var_20_0 < var_20_3 then
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
	Play412021005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 412021005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play412021006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.375

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

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(412021005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 15 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 15)

				if (15 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 15)) > 0 and var_24_0 < var_24_3 then
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
	Play412021006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 412021006
		arg_25_1.duration_ = 5.2

		local var_25_0 = {
			zh = 4.733,
			ja = 5.2
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
				arg_25_0:Play412021007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if arg_25_1.actors_["1097ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1097ui_story"))) then
				local var_28_0 = Object.Instantiate(Asset.Load("Char/" .. "1097ui_story"), arg_25_1.stage_.transform)

				var_28_0.name = "1097ui_story"
				var_28_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["1097ui_story"] = var_28_0

				local var_28_1 = var_28_0:GetComponentInChildren(typeof(CharacterEffect))

				var_28_1.enabled = true

				local var_28_2 = GameObjectTools.GetOrAddComponent(var_28_0, typeof(DynamicBoneHelper))

				if var_28_2 then
					var_28_2:EnableDynamicBone(false)
				end

				arg_25_1:ShowWeapon(var_28_1.transform, false)

				arg_25_1.var_["1097ui_story" .. "Animator"] = var_28_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_25_1.var_["1097ui_story" .. "Animator"].applyRootMotion = true
				arg_25_1.var_["1097ui_story" .. "LipSync"] = var_28_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_28_3 = arg_25_1.actors_["1097ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1097ui_story = var_28_3.localPosition
			end

			local var_28_4 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				var_28_3.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_25_1.time_ - 0) / var_28_4)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				var_28_3.localPosition = Vector3.New(0, -0.54, -6.3)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			local var_28_5 = arg_25_1.actors_["1097ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect1097ui_story == nil then
				arg_25_1.var_.characterEffect1097ui_story = var_28_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_6 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_6 and not isNil(var_28_5) then
				if arg_25_1.var_.characterEffect1097ui_story and not isNil(var_28_5) then
					arg_25_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_6 and arg_25_1.time_ < 0 + var_28_6 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect1097ui_story then
				arg_25_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_8 = 0
			local var_28_9 = 0.375

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_10 = arg_25_1:GetWordFromCfg(412021006)
				local var_28_11 = arg_25_1:FormatText(var_28_10.content)

				arg_25_1.text_.text = var_28_11

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_13 = 15 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 15)

				if (15 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 15)) > 0 and var_28_9 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_8
					end
				end

				arg_25_1.text_.text = var_28_11
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021006", "story_v_out_412021.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_out_412021", "412021006", "story_v_out_412021.awb") / 1000

					if var_28_14 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_8
					end

					if var_28_10.prefab_name ~= "" and arg_25_1.actors_[var_28_10.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_10.prefab_name].transform, "story_v_out_412021", "412021006", "story_v_out_412021.awb")

						arg_25_1:RecordAudio("412021006", var_28_15)
						arg_25_1:RecordAudio("412021006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_412021", "412021006", "story_v_out_412021.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_412021", "412021006", "story_v_out_412021.awb")
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
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play412021007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 412021007
		arg_29_1.duration_ = 3.67

		local var_29_0 = {
			zh = 3.666,
			ja = 3.366
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play412021008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.actors_["10083ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10083ui_story"))) then
				local var_32_0 = Object.Instantiate(Asset.Load("Char/" .. "10083ui_story"), arg_29_1.stage_.transform)

				var_32_0.name = "10083ui_story"
				var_32_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.actors_["10083ui_story"] = var_32_0

				local var_32_1 = var_32_0:GetComponentInChildren(typeof(CharacterEffect))

				var_32_1.enabled = true

				local var_32_2 = GameObjectTools.GetOrAddComponent(var_32_0, typeof(DynamicBoneHelper))

				if var_32_2 then
					var_32_2:EnableDynamicBone(false)
				end

				arg_29_1:ShowWeapon(var_32_1.transform, false)

				arg_29_1.var_["10083ui_story" .. "Animator"] = var_32_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_29_1.var_["10083ui_story" .. "Animator"].applyRootMotion = true
				arg_29_1.var_["10083ui_story" .. "LipSync"] = var_32_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_32_3 = arg_29_1.actors_["10083ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10083ui_story = var_32_3.localPosition
			end

			local var_32_4 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				var_32_3.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10083ui_story, Vector3.New(0, -2.6, -2.8), (arg_29_1.time_ - 0) / var_32_4)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				var_32_3.localPosition = Vector3.New(0, -2.6, -2.8)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			local var_32_5 = arg_29_1.actors_["10083ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect10083ui_story == nil then
				arg_29_1.var_.characterEffect10083ui_story = var_32_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_6 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_6 and not isNil(var_32_5) then
				if arg_29_1.var_.characterEffect10083ui_story and not isNil(var_32_5) then
					arg_29_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_6 and arg_29_1.time_ < 0 + var_32_6 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect10083ui_story then
				arg_29_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action1_1")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_32_8 = arg_29_1.actors_["1097ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1097ui_story = var_32_8.localPosition
			end

			local var_32_9 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_9 then
				var_32_8.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_29_1.time_ - 0) / var_32_9)
				var_32_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_8.position).x, (manager.ui.mainCamera.transform.position - var_32_8.position).y, (manager.ui.mainCamera.transform.position - var_32_8.position).z)
				var_32_8.localEulerAngles.z = 0
				var_32_8.localEulerAngles.x = 0
				var_32_8.localEulerAngles = var_32_8.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_9 and arg_29_1.time_ < 0 + var_32_9 + arg_32_0 then
				var_32_8.localPosition = Vector3.New(0, 100, 0)
				var_32_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_8.position).x, (manager.ui.mainCamera.transform.position - var_32_8.position).y, (manager.ui.mainCamera.transform.position - var_32_8.position).z)
				var_32_8.localEulerAngles.z = 0
				var_32_8.localEulerAngles.x = 0
				var_32_8.localEulerAngles = var_32_8.localEulerAngles
			end

			local var_32_10 = arg_29_1.actors_["1097ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_10) and arg_29_1.var_.characterEffect1097ui_story == nil then
				arg_29_1.var_.characterEffect1097ui_story = var_32_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_11 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_11 and not isNil(var_32_10) then
				if arg_29_1.var_.characterEffect1097ui_story and not isNil(var_32_10) then
					arg_29_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_11)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_11 and arg_29_1.time_ < 0 + var_32_11 + arg_32_0 and not isNil(var_32_10) and arg_29_1.var_.characterEffect1097ui_story then
				arg_29_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_32_12 = 0
			local var_32_13 = 0.3

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_12 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_14 = arg_29_1:GetWordFromCfg(412021007)
				local var_32_15 = arg_29_1:FormatText(var_32_14.content)

				arg_29_1.text_.text = var_32_15

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_17 = 12 <= 0 and var_32_13 or var_32_13 * (utf8.len(var_32_15) / 12)

				if (12 <= 0 and var_32_13 or var_32_13 * (utf8.len(var_32_15) / 12)) > 0 and var_32_13 < var_32_17 then
					arg_29_1.talkMaxDuration = var_32_17

					if var_32_17 + var_32_12 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_17 + var_32_12
					end
				end

				arg_29_1.text_.text = var_32_15
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021007", "story_v_out_412021.awb") ~= 0 then
					local var_32_18 = manager.audio:GetVoiceLength("story_v_out_412021", "412021007", "story_v_out_412021.awb") / 1000

					if var_32_18 + var_32_12 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_18 + var_32_12
					end

					if var_32_14.prefab_name ~= "" and arg_29_1.actors_[var_32_14.prefab_name] ~= nil then
						local var_32_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_14.prefab_name].transform, "story_v_out_412021", "412021007", "story_v_out_412021.awb")

						arg_29_1:RecordAudio("412021007", var_32_19)
						arg_29_1:RecordAudio("412021007", var_32_19)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_412021", "412021007", "story_v_out_412021.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_412021", "412021007", "story_v_out_412021.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_20 = math.max(var_32_13, arg_29_1.talkMaxDuration)

			if var_32_12 <= arg_29_1.time_ and arg_29_1.time_ < var_32_12 + var_32_20 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_12) / var_32_20

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_12 + var_32_20 and arg_29_1.time_ < var_32_12 + var_32_20 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play412021008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 412021008
		arg_33_1.duration_ = 6.43

		local var_33_0 = {
			zh = 4.6,
			ja = 6.433
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play412021009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if arg_33_1.actors_["10076ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10076ui_story"))) then
				local var_36_0 = Object.Instantiate(Asset.Load("Char/" .. "10076ui_story"), arg_33_1.stage_.transform)

				var_36_0.name = "10076ui_story"
				var_36_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_["10076ui_story"] = var_36_0

				local var_36_1 = var_36_0:GetComponentInChildren(typeof(CharacterEffect))

				var_36_1.enabled = true

				local var_36_2 = GameObjectTools.GetOrAddComponent(var_36_0, typeof(DynamicBoneHelper))

				if var_36_2 then
					var_36_2:EnableDynamicBone(false)
				end

				arg_33_1:ShowWeapon(var_36_1.transform, false)

				arg_33_1.var_["10076ui_story" .. "Animator"] = var_36_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_33_1.var_["10076ui_story" .. "Animator"].applyRootMotion = true
				arg_33_1.var_["10076ui_story" .. "LipSync"] = var_36_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_36_3 = arg_33_1.actors_["10076ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos10076ui_story = var_36_3.localPosition
			end

			local var_36_4 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				var_36_3.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10076ui_story, Vector3.New(1, -0.35, -4), (arg_33_1.time_ - 0) / var_36_4)
				var_36_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_3.position).x, (manager.ui.mainCamera.transform.position - var_36_3.position).y, (manager.ui.mainCamera.transform.position - var_36_3.position).z)
				var_36_3.localEulerAngles.z = 0
				var_36_3.localEulerAngles.x = 0
				var_36_3.localEulerAngles = var_36_3.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				var_36_3.localPosition = Vector3.New(1, -0.35, -4)
				var_36_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_3.position).x, (manager.ui.mainCamera.transform.position - var_36_3.position).y, (manager.ui.mainCamera.transform.position - var_36_3.position).z)
				var_36_3.localEulerAngles.z = 0
				var_36_3.localEulerAngles.x = 0
				var_36_3.localEulerAngles = var_36_3.localEulerAngles
			end

			local var_36_5 = arg_33_1.actors_["10076ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.characterEffect10076ui_story == nil then
				arg_33_1.var_.characterEffect10076ui_story = var_36_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_6 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_6 and not isNil(var_36_5) then
				if arg_33_1.var_.characterEffect10076ui_story and not isNil(var_36_5) then
					arg_33_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_6 and arg_33_1.time_ < 0 + var_36_6 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.characterEffect10076ui_story then
				arg_33_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action2_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_8 = arg_33_1.actors_["10083ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_8) and arg_33_1.var_.characterEffect10083ui_story == nil then
				arg_33_1.var_.characterEffect10083ui_story = var_36_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_9 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_9 and not isNil(var_36_8) then
				if arg_33_1.var_.characterEffect10083ui_story and not isNil(var_36_8) then
					arg_33_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_33_1.var_.characterEffect10083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_9)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_9 and arg_33_1.time_ < 0 + var_36_9 + arg_36_0 and not isNil(var_36_8) and arg_33_1.var_.characterEffect10083ui_story then
				arg_33_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_33_1.var_.characterEffect10083ui_story.fillRatio = 0.5
			end

			local var_36_10 = arg_33_1.actors_["10083ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos10083ui_story = var_36_10.localPosition
			end

			local var_36_11 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_11 then
				var_36_10.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10083ui_story, Vector3.New(-1, -2.6, -2.8), (arg_33_1.time_ - 0) / var_36_11)
				var_36_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_10.position).x, (manager.ui.mainCamera.transform.position - var_36_10.position).y, (manager.ui.mainCamera.transform.position - var_36_10.position).z)
				var_36_10.localEulerAngles.z = 0
				var_36_10.localEulerAngles.x = 0
				var_36_10.localEulerAngles = var_36_10.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_11 and arg_33_1.time_ < 0 + var_36_11 + arg_36_0 then
				var_36_10.localPosition = Vector3.New(-1, -2.6, -2.8)
				var_36_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_10.position).x, (manager.ui.mainCamera.transform.position - var_36_10.position).y, (manager.ui.mainCamera.transform.position - var_36_10.position).z)
				var_36_10.localEulerAngles.z = 0
				var_36_10.localEulerAngles.x = 0
				var_36_10.localEulerAngles = var_36_10.localEulerAngles
			end

			local var_36_12 = 0
			local var_36_13 = 0.6

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_12 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_14 = arg_33_1:GetWordFromCfg(412021008)
				local var_36_15 = arg_33_1:FormatText(var_36_14.content)

				arg_33_1.text_.text = var_36_15

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_17 = 24 <= 0 and var_36_13 or var_36_13 * (utf8.len(var_36_15) / 24)

				if (24 <= 0 and var_36_13 or var_36_13 * (utf8.len(var_36_15) / 24)) > 0 and var_36_13 < var_36_17 then
					arg_33_1.talkMaxDuration = var_36_17

					if var_36_17 + var_36_12 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_17 + var_36_12
					end
				end

				arg_33_1.text_.text = var_36_15
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021008", "story_v_out_412021.awb") ~= 0 then
					local var_36_18 = manager.audio:GetVoiceLength("story_v_out_412021", "412021008", "story_v_out_412021.awb") / 1000

					if var_36_18 + var_36_12 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_18 + var_36_12
					end

					if var_36_14.prefab_name ~= "" and arg_33_1.actors_[var_36_14.prefab_name] ~= nil then
						local var_36_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_14.prefab_name].transform, "story_v_out_412021", "412021008", "story_v_out_412021.awb")

						arg_33_1:RecordAudio("412021008", var_36_19)
						arg_33_1:RecordAudio("412021008", var_36_19)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_412021", "412021008", "story_v_out_412021.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_412021", "412021008", "story_v_out_412021.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_20 = math.max(var_36_13, arg_33_1.talkMaxDuration)

			if var_36_12 <= arg_33_1.time_ and arg_33_1.time_ < var_36_12 + var_36_20 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_12) / var_36_20

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_12 + var_36_20 and arg_33_1.time_ < var_36_12 + var_36_20 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
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
	Play412021009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 412021009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play412021010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10083ui_story = arg_37_1.actors_["10083ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["10083ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10083ui_story, Vector3.New(0, 100, 0), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10083ui_story"].transform.position).z)
				arg_37_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["10083ui_story"].transform.localEulerAngles = arg_37_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["10083ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10083ui_story"].transform.position).z)
				arg_37_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["10083ui_story"].transform.localEulerAngles = arg_37_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["10083ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect10083ui_story == nil then
				arg_37_1.var_.characterEffect10083ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect10083ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_37_1.var_.characterEffect10083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_2)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect10083ui_story then
				arg_37_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_37_1.var_.characterEffect10083ui_story.fillRatio = 0.5
			end

			local var_40_3 = arg_37_1.actors_["10076ui_story"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10076ui_story = var_40_3.localPosition
			end

			local var_40_4 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				var_40_3.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10076ui_story, Vector3.New(0, 100, 0), (arg_37_1.time_ - 0) / var_40_4)
				var_40_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_3.position).x, (manager.ui.mainCamera.transform.position - var_40_3.position).y, (manager.ui.mainCamera.transform.position - var_40_3.position).z)
				var_40_3.localEulerAngles.z = 0
				var_40_3.localEulerAngles.x = 0
				var_40_3.localEulerAngles = var_40_3.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				var_40_3.localPosition = Vector3.New(0, 100, 0)
				var_40_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_3.position).x, (manager.ui.mainCamera.transform.position - var_40_3.position).y, (manager.ui.mainCamera.transform.position - var_40_3.position).z)
				var_40_3.localEulerAngles.z = 0
				var_40_3.localEulerAngles.x = 0
				var_40_3.localEulerAngles = var_40_3.localEulerAngles
			end

			local var_40_5 = arg_37_1.actors_["10076ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.characterEffect10076ui_story == nil then
				arg_37_1.var_.characterEffect10076ui_story = var_40_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_6 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_6 and not isNil(var_40_5) then
				if arg_37_1.var_.characterEffect10076ui_story and not isNil(var_40_5) then
					arg_37_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_37_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_6)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_6 and arg_37_1.time_ < 0 + var_40_6 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.characterEffect10076ui_story then
				arg_37_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_37_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_40_7 = 0
			local var_40_8 = 1.2

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_7 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_9 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(412021009).content)

				arg_37_1.text_.text = var_40_9

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 48 <= 0 and var_40_8 or var_40_8 * (utf8.len(var_40_9) / 48)

				if (48 <= 0 and var_40_8 or var_40_8 * (utf8.len(var_40_9) / 48)) > 0 and var_40_8 < var_40_11 then
					arg_37_1.talkMaxDuration = var_40_11

					if var_40_11 + var_40_7 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_7
					end
				end

				arg_37_1.text_.text = var_40_9
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_12 = math.max(var_40_8, arg_37_1.talkMaxDuration)

			if var_40_7 <= arg_37_1.time_ and arg_37_1.time_ < var_40_7 + var_40_12 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_7) / var_40_12

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_7 + var_40_12 and arg_37_1.time_ < var_40_7 + var_40_12 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play412021010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 412021010
		arg_41_1.duration_ = 10.87

		local var_41_0 = {
			zh = 8.866,
			ja = 10.866
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play412021011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if arg_41_1.bgs_.I09g == nil then
				local var_44_0 = Object.Instantiate(arg_41_1.paintGo_)

				var_44_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I09g")
				var_44_0.name = "I09g"
				var_44_0.transform.parent = arg_41_1.stage_.transform
				var_44_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_41_1.bgs_.I09g = var_44_0
			end

			if 2 < arg_41_1.time_ and arg_41_1.time_ <= 2 + arg_44_0 then
				local var_44_1 = arg_41_1.bgs_.I09g

				arg_41_1.bgs_.I09g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_44_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_44_2 = var_44_1:GetComponent("SpriteRenderer")

				if var_44_2 and var_44_2.sprite then
					local var_44_3 = 2 * (var_44_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_44_1.transform.localScale = Vector3.New(var_44_3 / var_44_2.sprite.bounds.size.y < var_44_3 * manager.ui.mainCameraCom_.aspect / var_44_2.sprite.bounds.size.x and var_44_3 * manager.ui.mainCameraCom_.aspect / var_44_2.sprite.bounds.size.x or var_44_3 / var_44_2.sprite.bounds.size.y, var_44_3 / var_44_2.sprite.bounds.size.y < var_44_3 * manager.ui.mainCameraCom_.aspect / var_44_2.sprite.bounds.size.x and var_44_3 * manager.ui.mainCameraCom_.aspect / var_44_2.sprite.bounds.size.x or var_44_3 / var_44_2.sprite.bounds.size.y, 0)
				end

				for iter_44_0, iter_44_1 in pairs(arg_41_1.bgs_) do
					if iter_44_0 ~= "I09g" then
						iter_44_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_44_4 = 4

			if 4 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.allBtn_.enabled = false
			end

			if arg_41_1.time_ >= var_44_4 + 0.3 and arg_41_1.time_ < var_44_4 + 0.3 + arg_44_0 then
				arg_41_1.allBtn_.enabled = true
			end

			local var_44_5 = 0

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1.mask_.enabled = true
				arg_41_1.mask_.raycastTarget = true

				arg_41_1:SetGaussion(false)
			end

			local var_44_6 = 2

			if var_44_5 <= arg_41_1.time_ and arg_41_1.time_ < var_44_5 + var_44_6 then
				local var_44_7 = Color.New(0, 0, 0)

				var_44_7.a = Mathf.Lerp(0, 1, (arg_41_1.time_ - var_44_5) / var_44_6)
				arg_41_1.mask_.color = var_44_7
			end

			if arg_41_1.time_ >= var_44_5 + var_44_6 and arg_41_1.time_ < var_44_5 + var_44_6 + arg_44_0 then
				local var_44_8 = Color.New(0, 0, 0)

				var_44_8.a = 1
				arg_41_1.mask_.color = var_44_8
			end

			local var_44_9 = 2

			if 2 < arg_41_1.time_ and arg_41_1.time_ <= var_44_9 + arg_44_0 then
				arg_41_1.mask_.enabled = true
				arg_41_1.mask_.raycastTarget = true

				arg_41_1:SetGaussion(false)
			end

			local var_44_10 = 2

			if var_44_9 <= arg_41_1.time_ and arg_41_1.time_ < var_44_9 + var_44_10 then
				local var_44_11 = Color.New(0, 0, 0)

				var_44_11.a = Mathf.Lerp(1, 0, (arg_41_1.time_ - var_44_9) / var_44_10)
				arg_41_1.mask_.color = var_44_11
			end

			if arg_41_1.time_ >= var_44_9 + var_44_10 and arg_41_1.time_ < var_44_9 + var_44_10 + arg_44_0 then
				local var_44_12 = Color.New(0, 0, 0)

				arg_41_1.mask_.enabled = false
				var_44_12.a = 0
				arg_41_1.mask_.color = var_44_12
			end

			local var_44_13 = arg_41_1.actors_["1097ui_story"].transform

			if 3.8 < arg_41_1.time_ and arg_41_1.time_ <= 3.8 + arg_44_0 then
				arg_41_1.var_.moveOldPos1097ui_story = var_44_13.localPosition
			end

			local var_44_14 = 0.001

			if 3.8 <= arg_41_1.time_ and arg_41_1.time_ < 3.8 + var_44_14 then
				var_44_13.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_41_1.time_ - 3.8) / var_44_14)
				var_44_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_13.position).x, (manager.ui.mainCamera.transform.position - var_44_13.position).y, (manager.ui.mainCamera.transform.position - var_44_13.position).z)
				var_44_13.localEulerAngles.z = 0
				var_44_13.localEulerAngles.x = 0
				var_44_13.localEulerAngles = var_44_13.localEulerAngles
			end

			if arg_41_1.time_ >= 3.8 + var_44_14 and arg_41_1.time_ < 3.8 + var_44_14 + arg_44_0 then
				var_44_13.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				var_44_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_13.position).x, (manager.ui.mainCamera.transform.position - var_44_13.position).y, (manager.ui.mainCamera.transform.position - var_44_13.position).z)
				var_44_13.localEulerAngles.z = 0
				var_44_13.localEulerAngles.x = 0
				var_44_13.localEulerAngles = var_44_13.localEulerAngles
			end

			local var_44_15 = arg_41_1.actors_["1097ui_story"]

			if 3.8 < arg_41_1.time_ and arg_41_1.time_ <= 3.8 + arg_44_0 and not isNil(var_44_15) and arg_41_1.var_.characterEffect1097ui_story == nil then
				arg_41_1.var_.characterEffect1097ui_story = var_44_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_16 = 0.200000002980232

			if 3.8 <= arg_41_1.time_ and arg_41_1.time_ < 3.8 + var_44_16 and not isNil(var_44_15) then
				if arg_41_1.var_.characterEffect1097ui_story and not isNil(var_44_15) then
					arg_41_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 3.8 + var_44_16 and arg_41_1.time_ < 3.8 + var_44_16 + arg_44_0 and not isNil(var_44_15) and arg_41_1.var_.characterEffect1097ui_story then
				arg_41_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 3.8 < arg_41_1.time_ and arg_41_1.time_ <= 3.8 + arg_44_0 then
				arg_41_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 3.8 < arg_41_1.time_ and arg_41_1.time_ <= 3.8 + arg_44_0 then
				arg_41_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_41_1.frameCnt_ <= 1 then
				arg_41_1.dialog_:SetActive(false)
			end

			local var_44_18 = 4
			local var_44_19 = 0.375

			if 4 < arg_41_1.time_ and arg_41_1.time_ <= var_44_18 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0

				arg_41_1.dialog_:SetActive(true)

				arg_41_1.dialogCg_.alpha = 0

				local var_44_20 = LeanTween.value(arg_41_1.dialog_, 0, 1, 0.3)

				var_44_20:setOnUpdate(LuaHelper.FloatAction(function(arg_45_0)
					arg_41_1.dialogCg_.alpha = arg_45_0
				end))
				var_44_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_41_1.dialog_)
					var_44_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_41_1.duration_ = arg_41_1.duration_ + 0.3

				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_21 = arg_41_1:GetWordFromCfg(412021010)
				local var_44_22 = arg_41_1:FormatText(var_44_21.content)

				arg_41_1.text_.text = var_44_22

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_24 = 15 <= 0 and var_44_19 or var_44_19 * (utf8.len(var_44_22) / 15)

				if (15 <= 0 and var_44_19 or var_44_19 * (utf8.len(var_44_22) / 15)) > 0 and var_44_19 < var_44_24 then
					arg_41_1.talkMaxDuration = var_44_24
					var_44_18 = var_44_18 + 0.3

					if var_44_24 + var_44_18 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_24 + var_44_18
					end
				end

				arg_41_1.text_.text = var_44_22
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021010", "story_v_out_412021.awb") ~= 0 then
					local var_44_25 = manager.audio:GetVoiceLength("story_v_out_412021", "412021010", "story_v_out_412021.awb") / 1000

					if var_44_25 + var_44_18 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_25 + var_44_18
					end

					if var_44_21.prefab_name ~= "" and arg_41_1.actors_[var_44_21.prefab_name] ~= nil then
						local var_44_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_21.prefab_name].transform, "story_v_out_412021", "412021010", "story_v_out_412021.awb")

						arg_41_1:RecordAudio("412021010", var_44_26)
						arg_41_1:RecordAudio("412021010", var_44_26)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_412021", "412021010", "story_v_out_412021.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_412021", "412021010", "story_v_out_412021.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_27 = var_44_18 + 0.3
			local var_44_28 = math.max(var_44_19, arg_41_1.talkMaxDuration)

			if var_44_18 + 0.3 <= arg_41_1.time_ and arg_41_1.time_ < var_44_27 + var_44_28 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_27) / var_44_28

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_27 + var_44_28 and arg_41_1.time_ < var_44_27 + var_44_28 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play412021011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 412021011
		arg_47_1.duration_ = 5.4

		local var_47_0 = {
			zh = 4.1,
			ja = 5.4
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
				arg_47_0:Play412021012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos10076ui_story = arg_47_1.actors_["10076ui_story"].transform.localPosition
			end

			local var_50_0 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 then
				arg_47_1.actors_["10076ui_story"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10076ui_story, Vector3.New(1, -0.35, -4), (arg_47_1.time_ - 0) / var_50_0)
				arg_47_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["10076ui_story"].transform.position).z)
				arg_47_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["10076ui_story"].transform.localEulerAngles = arg_47_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 then
				arg_47_1.actors_["10076ui_story"].transform.localPosition = Vector3.New(1, -0.35, -4)
				arg_47_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["10076ui_story"].transform.position).z)
				arg_47_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["10076ui_story"].transform.localEulerAngles = arg_47_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			local var_50_1 = arg_47_1.actors_["10076ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect10076ui_story == nil then
				arg_47_1.var_.characterEffect10076ui_story = var_50_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_2 and not isNil(var_50_1) then
				if arg_47_1.var_.characterEffect10076ui_story and not isNil(var_50_1) then
					arg_47_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_2 and arg_47_1.time_ < 0 + var_50_2 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect10076ui_story then
				arg_47_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action3_1")
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_50_4 = arg_47_1.actors_["1097ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_4) and arg_47_1.var_.characterEffect1097ui_story == nil then
				arg_47_1.var_.characterEffect1097ui_story = var_50_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_5 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_5 and not isNil(var_50_4) then
				if arg_47_1.var_.characterEffect1097ui_story and not isNil(var_50_4) then
					arg_47_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_5)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_5 and arg_47_1.time_ < 0 + var_50_5 + arg_50_0 and not isNil(var_50_4) and arg_47_1.var_.characterEffect1097ui_story then
				arg_47_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_50_6 = 0
			local var_50_7 = 0.4

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_6 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_8 = arg_47_1:GetWordFromCfg(412021011)
				local var_50_9 = arg_47_1:FormatText(var_50_8.content)

				arg_47_1.text_.text = var_50_9

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_11 = 16 <= 0 and var_50_7 or var_50_7 * (utf8.len(var_50_9) / 16)

				if (16 <= 0 and var_50_7 or var_50_7 * (utf8.len(var_50_9) / 16)) > 0 and var_50_7 < var_50_11 then
					arg_47_1.talkMaxDuration = var_50_11

					if var_50_11 + var_50_6 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_11 + var_50_6
					end
				end

				arg_47_1.text_.text = var_50_9
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021011", "story_v_out_412021.awb") ~= 0 then
					local var_50_12 = manager.audio:GetVoiceLength("story_v_out_412021", "412021011", "story_v_out_412021.awb") / 1000

					if var_50_12 + var_50_6 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_12 + var_50_6
					end

					if var_50_8.prefab_name ~= "" and arg_47_1.actors_[var_50_8.prefab_name] ~= nil then
						local var_50_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_8.prefab_name].transform, "story_v_out_412021", "412021011", "story_v_out_412021.awb")

						arg_47_1:RecordAudio("412021011", var_50_13)
						arg_47_1:RecordAudio("412021011", var_50_13)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_412021", "412021011", "story_v_out_412021.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_412021", "412021011", "story_v_out_412021.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_14 = math.max(var_50_7, arg_47_1.talkMaxDuration)

			if var_50_6 <= arg_47_1.time_ and arg_47_1.time_ < var_50_6 + var_50_14 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_6) / var_50_14

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_6 + var_50_14 and arg_47_1.time_ < var_50_6 + var_50_14 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play412021012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 412021012
		arg_51_1.duration_ = 6.33

		local var_51_0 = {
			zh = 5.8,
			ja = 6.333
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play412021013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos10083ui_story = arg_51_1.actors_["10083ui_story"].transform.localPosition
			end

			local var_54_0 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 then
				arg_51_1.actors_["10083ui_story"].transform.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos10083ui_story, Vector3.New(0, -2.6, -2.8), (arg_51_1.time_ - 0) / var_54_0)
				arg_51_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["10083ui_story"].transform.position).z)
				arg_51_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["10083ui_story"].transform.localEulerAngles = arg_51_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 then
				arg_51_1.actors_["10083ui_story"].transform.localPosition = Vector3.New(0, -2.6, -2.8)
				arg_51_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["10083ui_story"].transform.position).z)
				arg_51_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["10083ui_story"].transform.localEulerAngles = arg_51_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			local var_54_1 = arg_51_1.actors_["10083ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_1) and arg_51_1.var_.characterEffect10083ui_story == nil then
				arg_51_1.var_.characterEffect10083ui_story = var_54_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_2 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_2 and not isNil(var_54_1) then
				if arg_51_1.var_.characterEffect10083ui_story and not isNil(var_54_1) then
					arg_51_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= 0 + var_54_2 and arg_51_1.time_ < 0 + var_54_2 + arg_54_0 and not isNil(var_54_1) and arg_51_1.var_.characterEffect10083ui_story then
				arg_51_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action4_1")
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_54_4 = arg_51_1.actors_["1097ui_story"].transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1097ui_story = var_54_4.localPosition
			end

			local var_54_5 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_5 then
				var_54_4.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_51_1.time_ - 0) / var_54_5)
				var_54_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_4.position).x, (manager.ui.mainCamera.transform.position - var_54_4.position).y, (manager.ui.mainCamera.transform.position - var_54_4.position).z)
				var_54_4.localEulerAngles.z = 0
				var_54_4.localEulerAngles.x = 0
				var_54_4.localEulerAngles = var_54_4.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_5 and arg_51_1.time_ < 0 + var_54_5 + arg_54_0 then
				var_54_4.localPosition = Vector3.New(0, 100, 0)
				var_54_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_4.position).x, (manager.ui.mainCamera.transform.position - var_54_4.position).y, (manager.ui.mainCamera.transform.position - var_54_4.position).z)
				var_54_4.localEulerAngles.z = 0
				var_54_4.localEulerAngles.x = 0
				var_54_4.localEulerAngles = var_54_4.localEulerAngles
			end

			local var_54_6 = arg_51_1.actors_["1097ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_6) and arg_51_1.var_.characterEffect1097ui_story == nil then
				arg_51_1.var_.characterEffect1097ui_story = var_54_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_7 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_7 and not isNil(var_54_6) then
				if arg_51_1.var_.characterEffect1097ui_story and not isNil(var_54_6) then
					arg_51_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_7)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_7 and arg_51_1.time_ < 0 + var_54_7 + arg_54_0 and not isNil(var_54_6) and arg_51_1.var_.characterEffect1097ui_story then
				arg_51_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_54_8 = arg_51_1.actors_["10076ui_story"].transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos10076ui_story = var_54_8.localPosition
			end

			local var_54_9 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_9 then
				var_54_8.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos10076ui_story, Vector3.New(0, 100, 0), (arg_51_1.time_ - 0) / var_54_9)
				var_54_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_8.position).x, (manager.ui.mainCamera.transform.position - var_54_8.position).y, (manager.ui.mainCamera.transform.position - var_54_8.position).z)
				var_54_8.localEulerAngles.z = 0
				var_54_8.localEulerAngles.x = 0
				var_54_8.localEulerAngles = var_54_8.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_9 and arg_51_1.time_ < 0 + var_54_9 + arg_54_0 then
				var_54_8.localPosition = Vector3.New(0, 100, 0)
				var_54_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_8.position).x, (manager.ui.mainCamera.transform.position - var_54_8.position).y, (manager.ui.mainCamera.transform.position - var_54_8.position).z)
				var_54_8.localEulerAngles.z = 0
				var_54_8.localEulerAngles.x = 0
				var_54_8.localEulerAngles = var_54_8.localEulerAngles
			end

			local var_54_10 = arg_51_1.actors_["10076ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_10) and arg_51_1.var_.characterEffect10076ui_story == nil then
				arg_51_1.var_.characterEffect10076ui_story = var_54_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_11 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_11 and not isNil(var_54_10) then
				if arg_51_1.var_.characterEffect10076ui_story and not isNil(var_54_10) then
					arg_51_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_51_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_11)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_11 and arg_51_1.time_ < 0 + var_54_11 + arg_54_0 and not isNil(var_54_10) and arg_51_1.var_.characterEffect10076ui_story then
				arg_51_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_51_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_54_12 = 0
			local var_54_13 = 0.65

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_12 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_14 = arg_51_1:GetWordFromCfg(412021012)
				local var_54_15 = arg_51_1:FormatText(var_54_14.content)

				arg_51_1.text_.text = var_54_15

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_17 = 26 <= 0 and var_54_13 or var_54_13 * (utf8.len(var_54_15) / 26)

				if (26 <= 0 and var_54_13 or var_54_13 * (utf8.len(var_54_15) / 26)) > 0 and var_54_13 < var_54_17 then
					arg_51_1.talkMaxDuration = var_54_17

					if var_54_17 + var_54_12 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_17 + var_54_12
					end
				end

				arg_51_1.text_.text = var_54_15
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021012", "story_v_out_412021.awb") ~= 0 then
					local var_54_18 = manager.audio:GetVoiceLength("story_v_out_412021", "412021012", "story_v_out_412021.awb") / 1000

					if var_54_18 + var_54_12 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_18 + var_54_12
					end

					if var_54_14.prefab_name ~= "" and arg_51_1.actors_[var_54_14.prefab_name] ~= nil then
						local var_54_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_14.prefab_name].transform, "story_v_out_412021", "412021012", "story_v_out_412021.awb")

						arg_51_1:RecordAudio("412021012", var_54_19)
						arg_51_1:RecordAudio("412021012", var_54_19)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_412021", "412021012", "story_v_out_412021.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_412021", "412021012", "story_v_out_412021.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_20 = math.max(var_54_13, arg_51_1.talkMaxDuration)

			if var_54_12 <= arg_51_1.time_ and arg_51_1.time_ < var_54_12 + var_54_20 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_12) / var_54_20

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_12 + var_54_20 and arg_51_1.time_ < var_54_12 + var_54_20 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play412021013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 412021013
		arg_55_1.duration_ = 9.7

		local var_55_0 = {
			zh = 7,
			ja = 9.7
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
				arg_55_0:Play412021014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos1097ui_story = arg_55_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_58_0 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 then
				arg_55_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_55_1.time_ - 0) / var_58_0)
				arg_55_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1097ui_story"].transform.position).z)
				arg_55_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1097ui_story"].transform.localEulerAngles = arg_55_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 then
				arg_55_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_55_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1097ui_story"].transform.position).z)
				arg_55_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1097ui_story"].transform.localEulerAngles = arg_55_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_58_1 = arg_55_1.actors_["1097ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect1097ui_story == nil then
				arg_55_1.var_.characterEffect1097ui_story = var_58_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_2 and not isNil(var_58_1) then
				if arg_55_1.var_.characterEffect1097ui_story and not isNil(var_58_1) then
					arg_55_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_2 and arg_55_1.time_ < 0 + var_58_2 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect1097ui_story then
				arg_55_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_58_4 = arg_55_1.actors_["10083ui_story"].transform

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos10083ui_story = var_58_4.localPosition
			end

			local var_58_5 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_5 then
				var_58_4.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10083ui_story, Vector3.New(0, 100, 0), (arg_55_1.time_ - 0) / var_58_5)
				var_58_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_4.position).x, (manager.ui.mainCamera.transform.position - var_58_4.position).y, (manager.ui.mainCamera.transform.position - var_58_4.position).z)
				var_58_4.localEulerAngles.z = 0
				var_58_4.localEulerAngles.x = 0
				var_58_4.localEulerAngles = var_58_4.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_5 and arg_55_1.time_ < 0 + var_58_5 + arg_58_0 then
				var_58_4.localPosition = Vector3.New(0, 100, 0)
				var_58_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_4.position).x, (manager.ui.mainCamera.transform.position - var_58_4.position).y, (manager.ui.mainCamera.transform.position - var_58_4.position).z)
				var_58_4.localEulerAngles.z = 0
				var_58_4.localEulerAngles.x = 0
				var_58_4.localEulerAngles = var_58_4.localEulerAngles
			end

			local var_58_6 = arg_55_1.actors_["10083ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_6) and arg_55_1.var_.characterEffect10083ui_story == nil then
				arg_55_1.var_.characterEffect10083ui_story = var_58_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_7 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_7 and not isNil(var_58_6) then
				if arg_55_1.var_.characterEffect10083ui_story and not isNil(var_58_6) then
					arg_55_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_55_1.var_.characterEffect10083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_7)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_7 and arg_55_1.time_ < 0 + var_58_7 + arg_58_0 and not isNil(var_58_6) and arg_55_1.var_.characterEffect10083ui_story then
				arg_55_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_55_1.var_.characterEffect10083ui_story.fillRatio = 0.5
			end

			local var_58_8 = 0
			local var_58_9 = 0.675

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_8 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_10 = arg_55_1:GetWordFromCfg(412021013)
				local var_58_11 = arg_55_1:FormatText(var_58_10.content)

				arg_55_1.text_.text = var_58_11

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_13 = 27 <= 0 and var_58_9 or var_58_9 * (utf8.len(var_58_11) / 27)

				if (27 <= 0 and var_58_9 or var_58_9 * (utf8.len(var_58_11) / 27)) > 0 and var_58_9 < var_58_13 then
					arg_55_1.talkMaxDuration = var_58_13

					if var_58_13 + var_58_8 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_13 + var_58_8
					end
				end

				arg_55_1.text_.text = var_58_11
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021013", "story_v_out_412021.awb") ~= 0 then
					local var_58_14 = manager.audio:GetVoiceLength("story_v_out_412021", "412021013", "story_v_out_412021.awb") / 1000

					if var_58_14 + var_58_8 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_14 + var_58_8
					end

					if var_58_10.prefab_name ~= "" and arg_55_1.actors_[var_58_10.prefab_name] ~= nil then
						local var_58_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_10.prefab_name].transform, "story_v_out_412021", "412021013", "story_v_out_412021.awb")

						arg_55_1:RecordAudio("412021013", var_58_15)
						arg_55_1:RecordAudio("412021013", var_58_15)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_412021", "412021013", "story_v_out_412021.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_412021", "412021013", "story_v_out_412021.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_16 = math.max(var_58_9, arg_55_1.talkMaxDuration)

			if var_58_8 <= arg_55_1.time_ and arg_55_1.time_ < var_58_8 + var_58_16 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_8) / var_58_16

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_8 + var_58_16 and arg_55_1.time_ < var_58_8 + var_58_16 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
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
	Play412021014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 412021014
		arg_59_1.duration_ = 8.2

		local var_59_0 = {
			zh = 6.766,
			ja = 8.2
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play412021015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0.65

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_1 = arg_59_1:GetWordFromCfg(412021014)
				local var_62_2 = arg_59_1:FormatText(var_62_1.content)

				arg_59_1.text_.text = var_62_2

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_4 = 26 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 26)

				if (26 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 26)) > 0 and var_62_0 < var_62_4 then
					arg_59_1.talkMaxDuration = var_62_4

					if var_62_4 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_4 + 0
					end
				end

				arg_59_1.text_.text = var_62_2
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021014", "story_v_out_412021.awb") ~= 0 then
					local var_62_5 = manager.audio:GetVoiceLength("story_v_out_412021", "412021014", "story_v_out_412021.awb") / 1000

					if var_62_5 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_5 + 0
					end

					if var_62_1.prefab_name ~= "" and arg_59_1.actors_[var_62_1.prefab_name] ~= nil then
						local var_62_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_1.prefab_name].transform, "story_v_out_412021", "412021014", "story_v_out_412021.awb")

						arg_59_1:RecordAudio("412021014", var_62_6)
						arg_59_1:RecordAudio("412021014", var_62_6)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_412021", "412021014", "story_v_out_412021.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_412021", "412021014", "story_v_out_412021.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_7 = math.max(var_62_0, arg_59_1.talkMaxDuration)

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_7 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - 0) / var_62_7

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= 0 + var_62_7 and arg_59_1.time_ < 0 + var_62_7 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play412021015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 412021015
		arg_63_1.duration_ = 12.37

		local var_63_0 = {
			zh = 10.133,
			ja = 12.366
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play412021016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 2 < arg_63_1.time_ and arg_63_1.time_ <= 2 + arg_66_0 then
				local var_66_0 = arg_63_1.bgs_.I09g

				arg_63_1.bgs_.I09g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_66_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_66_1 = var_66_0:GetComponent("SpriteRenderer")

				if var_66_1 and var_66_1.sprite then
					local var_66_2 = 2 * (var_66_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_66_0.transform.localScale = Vector3.New(var_66_2 / var_66_1.sprite.bounds.size.y < var_66_2 * manager.ui.mainCameraCom_.aspect / var_66_1.sprite.bounds.size.x and var_66_2 * manager.ui.mainCameraCom_.aspect / var_66_1.sprite.bounds.size.x or var_66_2 / var_66_1.sprite.bounds.size.y, var_66_2 / var_66_1.sprite.bounds.size.y < var_66_2 * manager.ui.mainCameraCom_.aspect / var_66_1.sprite.bounds.size.x and var_66_2 * manager.ui.mainCameraCom_.aspect / var_66_1.sprite.bounds.size.x or var_66_2 / var_66_1.sprite.bounds.size.y, 0)
				end

				for iter_66_0, iter_66_1 in pairs(arg_63_1.bgs_) do
					if iter_66_0 ~= "I09g" then
						iter_66_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_66_3 = 4

			if 4 < arg_63_1.time_ and arg_63_1.time_ <= var_66_3 + arg_66_0 then
				arg_63_1.allBtn_.enabled = false
			end

			if arg_63_1.time_ >= var_66_3 + 0.3 and arg_63_1.time_ < var_66_3 + 0.3 + arg_66_0 then
				arg_63_1.allBtn_.enabled = true
			end

			local var_66_4 = 0

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_4 + arg_66_0 then
				arg_63_1.mask_.enabled = true
				arg_63_1.mask_.raycastTarget = true

				arg_63_1:SetGaussion(false)
			end

			local var_66_5 = 2

			if var_66_4 <= arg_63_1.time_ and arg_63_1.time_ < var_66_4 + var_66_5 then
				local var_66_6 = Color.New(0, 0, 0)

				var_66_6.a = Mathf.Lerp(0, 1, (arg_63_1.time_ - var_66_4) / var_66_5)
				arg_63_1.mask_.color = var_66_6
			end

			if arg_63_1.time_ >= var_66_4 + var_66_5 and arg_63_1.time_ < var_66_4 + var_66_5 + arg_66_0 then
				local var_66_7 = Color.New(0, 0, 0)

				var_66_7.a = 1
				arg_63_1.mask_.color = var_66_7
			end

			local var_66_8 = 2

			if 2 < arg_63_1.time_ and arg_63_1.time_ <= var_66_8 + arg_66_0 then
				arg_63_1.mask_.enabled = true
				arg_63_1.mask_.raycastTarget = true

				arg_63_1:SetGaussion(false)
			end

			local var_66_9 = 2

			if var_66_8 <= arg_63_1.time_ and arg_63_1.time_ < var_66_8 + var_66_9 then
				local var_66_10 = Color.New(0, 0, 0)

				var_66_10.a = Mathf.Lerp(1, 0, (arg_63_1.time_ - var_66_8) / var_66_9)
				arg_63_1.mask_.color = var_66_10
			end

			if arg_63_1.time_ >= var_66_8 + var_66_9 and arg_63_1.time_ < var_66_8 + var_66_9 + arg_66_0 then
				local var_66_11 = Color.New(0, 0, 0)

				arg_63_1.mask_.enabled = false
				var_66_11.a = 0
				arg_63_1.mask_.color = var_66_11
			end

			local var_66_12 = arg_63_1.actors_["10076ui_story"].transform

			if 3.8 < arg_63_1.time_ and arg_63_1.time_ <= 3.8 + arg_66_0 then
				arg_63_1.var_.moveOldPos10076ui_story = var_66_12.localPosition
			end

			local var_66_13 = 0.001

			if 3.8 <= arg_63_1.time_ and arg_63_1.time_ < 3.8 + var_66_13 then
				var_66_12.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos10076ui_story, Vector3.New(0, -0.35, -4), (arg_63_1.time_ - 3.8) / var_66_13)
				var_66_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_66_12.position).x, (manager.ui.mainCamera.transform.position - var_66_12.position).y, (manager.ui.mainCamera.transform.position - var_66_12.position).z)
				var_66_12.localEulerAngles.z = 0
				var_66_12.localEulerAngles.x = 0
				var_66_12.localEulerAngles = var_66_12.localEulerAngles
			end

			if arg_63_1.time_ >= 3.8 + var_66_13 and arg_63_1.time_ < 3.8 + var_66_13 + arg_66_0 then
				var_66_12.localPosition = Vector3.New(0, -0.35, -4)
				var_66_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_66_12.position).x, (manager.ui.mainCamera.transform.position - var_66_12.position).y, (manager.ui.mainCamera.transform.position - var_66_12.position).z)
				var_66_12.localEulerAngles.z = 0
				var_66_12.localEulerAngles.x = 0
				var_66_12.localEulerAngles = var_66_12.localEulerAngles
			end

			local var_66_14 = arg_63_1.actors_["10076ui_story"]

			if 3.8 < arg_63_1.time_ and arg_63_1.time_ <= 3.8 + arg_66_0 and not isNil(var_66_14) and arg_63_1.var_.characterEffect10076ui_story == nil then
				arg_63_1.var_.characterEffect10076ui_story = var_66_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_15 = 0.200000002980232

			if 3.8 <= arg_63_1.time_ and arg_63_1.time_ < 3.8 + var_66_15 and not isNil(var_66_14) then
				if arg_63_1.var_.characterEffect10076ui_story and not isNil(var_66_14) then
					arg_63_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 3.8 + var_66_15 and arg_63_1.time_ < 3.8 + var_66_15 + arg_66_0 and not isNil(var_66_14) and arg_63_1.var_.characterEffect10076ui_story then
				arg_63_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			if 3.8 < arg_63_1.time_ and arg_63_1.time_ <= 3.8 + arg_66_0 then
				arg_63_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action3_1")
			end

			if 3.8 < arg_63_1.time_ and arg_63_1.time_ <= 3.8 + arg_66_0 then
				arg_63_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_66_17 = arg_63_1.actors_["1097ui_story"].transform

			if 1.96599999815226 < arg_63_1.time_ and arg_63_1.time_ <= 1.96599999815226 + arg_66_0 then
				arg_63_1.var_.moveOldPos1097ui_story = var_66_17.localPosition
			end

			local var_66_18 = 0.001

			if 1.96599999815226 <= arg_63_1.time_ and arg_63_1.time_ < 1.96599999815226 + var_66_18 then
				var_66_17.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_63_1.time_ - 1.96599999815226) / var_66_18)
				var_66_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_66_17.position).x, (manager.ui.mainCamera.transform.position - var_66_17.position).y, (manager.ui.mainCamera.transform.position - var_66_17.position).z)
				var_66_17.localEulerAngles.z = 0
				var_66_17.localEulerAngles.x = 0
				var_66_17.localEulerAngles = var_66_17.localEulerAngles
			end

			if arg_63_1.time_ >= 1.96599999815226 + var_66_18 and arg_63_1.time_ < 1.96599999815226 + var_66_18 + arg_66_0 then
				var_66_17.localPosition = Vector3.New(0, 100, 0)
				var_66_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_66_17.position).x, (manager.ui.mainCamera.transform.position - var_66_17.position).y, (manager.ui.mainCamera.transform.position - var_66_17.position).z)
				var_66_17.localEulerAngles.z = 0
				var_66_17.localEulerAngles.x = 0
				var_66_17.localEulerAngles = var_66_17.localEulerAngles
			end

			local var_66_19 = arg_63_1.actors_["1097ui_story"]

			if 1.96599999815226 < arg_63_1.time_ and arg_63_1.time_ <= 1.96599999815226 + arg_66_0 and not isNil(var_66_19) and arg_63_1.var_.characterEffect1097ui_story == nil then
				arg_63_1.var_.characterEffect1097ui_story = var_66_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_20 = 0.034000001847744

			if 1.96599999815226 <= arg_63_1.time_ and arg_63_1.time_ < 1.96599999815226 + var_66_20 and not isNil(var_66_19) then
				if arg_63_1.var_.characterEffect1097ui_story and not isNil(var_66_19) then
					arg_63_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 1.96599999815226) / var_66_20)
				end
			end

			if arg_63_1.time_ >= 1.96599999815226 + var_66_20 and arg_63_1.time_ < 1.96599999815226 + var_66_20 + arg_66_0 and not isNil(var_66_19) and arg_63_1.var_.characterEffect1097ui_story then
				arg_63_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			if arg_63_1.frameCnt_ <= 1 then
				arg_63_1.dialog_:SetActive(false)
			end

			local var_66_21 = 4
			local var_66_22 = 0.675

			if 4 < arg_63_1.time_ and arg_63_1.time_ <= var_66_21 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0

				arg_63_1.dialog_:SetActive(true)

				arg_63_1.dialogCg_.alpha = 0

				local var_66_23 = LeanTween.value(arg_63_1.dialog_, 0, 1, 0.3)

				var_66_23:setOnUpdate(LuaHelper.FloatAction(function(arg_67_0)
					arg_63_1.dialogCg_.alpha = arg_67_0
				end))
				var_66_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_63_1.dialog_)
					var_66_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_63_1.duration_ = arg_63_1.duration_ + 0.3

				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_24 = arg_63_1:GetWordFromCfg(412021015)
				local var_66_25 = arg_63_1:FormatText(var_66_24.content)

				arg_63_1.text_.text = var_66_25

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_27 = 27 <= 0 and var_66_22 or var_66_22 * (utf8.len(var_66_25) / 27)

				if (27 <= 0 and var_66_22 or var_66_22 * (utf8.len(var_66_25) / 27)) > 0 and var_66_22 < var_66_27 then
					arg_63_1.talkMaxDuration = var_66_27
					var_66_21 = var_66_21 + 0.3

					if var_66_27 + var_66_21 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_27 + var_66_21
					end
				end

				arg_63_1.text_.text = var_66_25
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021015", "story_v_out_412021.awb") ~= 0 then
					local var_66_28 = manager.audio:GetVoiceLength("story_v_out_412021", "412021015", "story_v_out_412021.awb") / 1000

					if var_66_28 + var_66_21 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_28 + var_66_21
					end

					if var_66_24.prefab_name ~= "" and arg_63_1.actors_[var_66_24.prefab_name] ~= nil then
						local var_66_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_24.prefab_name].transform, "story_v_out_412021", "412021015", "story_v_out_412021.awb")

						arg_63_1:RecordAudio("412021015", var_66_29)
						arg_63_1:RecordAudio("412021015", var_66_29)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_412021", "412021015", "story_v_out_412021.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_412021", "412021015", "story_v_out_412021.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_30 = var_66_21 + 0.3
			local var_66_31 = math.max(var_66_22, arg_63_1.talkMaxDuration)

			if var_66_21 + 0.3 <= arg_63_1.time_ and arg_63_1.time_ < var_66_30 + var_66_31 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_30) / var_66_31

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_30 + var_66_31 and arg_63_1.time_ < var_66_30 + var_66_31 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play412021016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 412021016
		arg_69_1.duration_ = 3.2

		local var_69_0 = {
			zh = 3.2,
			ja = 2.333
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
				arg_69_0:Play412021017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1097ui_story = arg_69_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1097ui_story, Vector3.New(0.7, -0.54, -6.3), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1097ui_story"].transform.position).z)
				arg_69_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1097ui_story"].transform.localEulerAngles = arg_69_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0.7, -0.54, -6.3)
				arg_69_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1097ui_story"].transform.position).z)
				arg_69_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1097ui_story"].transform.localEulerAngles = arg_69_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_72_1 = arg_69_1.actors_["1097ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1097ui_story == nil then
				arg_69_1.var_.characterEffect1097ui_story = var_72_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 and not isNil(var_72_1) then
				if arg_69_1.var_.characterEffect1097ui_story and not isNil(var_72_1) then
					arg_69_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1097ui_story then
				arg_69_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_72_4 = arg_69_1.actors_["10076ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_4) and arg_69_1.var_.characterEffect10076ui_story == nil then
				arg_69_1.var_.characterEffect10076ui_story = var_72_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_5 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_5 and not isNil(var_72_4) then
				if arg_69_1.var_.characterEffect10076ui_story and not isNil(var_72_4) then
					arg_69_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_69_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_5)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_5 and arg_69_1.time_ < 0 + var_72_5 + arg_72_0 and not isNil(var_72_4) and arg_69_1.var_.characterEffect10076ui_story then
				arg_69_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_69_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_72_6 = arg_69_1.actors_["10076ui_story"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10076ui_story = var_72_6.localPosition
			end

			local var_72_7 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_7 then
				var_72_6.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10076ui_story, Vector3.New(-1, -0.35, -4), (arg_69_1.time_ - 0) / var_72_7)
				var_72_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_6.position).x, (manager.ui.mainCamera.transform.position - var_72_6.position).y, (manager.ui.mainCamera.transform.position - var_72_6.position).z)
				var_72_6.localEulerAngles.z = 0
				var_72_6.localEulerAngles.x = 0
				var_72_6.localEulerAngles = var_72_6.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_7 and arg_69_1.time_ < 0 + var_72_7 + arg_72_0 then
				var_72_6.localPosition = Vector3.New(-1, -0.35, -4)
				var_72_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_6.position).x, (manager.ui.mainCamera.transform.position - var_72_6.position).y, (manager.ui.mainCamera.transform.position - var_72_6.position).z)
				var_72_6.localEulerAngles.z = 0
				var_72_6.localEulerAngles.x = 0
				var_72_6.localEulerAngles = var_72_6.localEulerAngles
			end

			local var_72_8 = 0
			local var_72_9 = 0.225

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_10 = arg_69_1:GetWordFromCfg(412021016)
				local var_72_11 = arg_69_1:FormatText(var_72_10.content)

				arg_69_1.text_.text = var_72_11

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_13 = 9 <= 0 and var_72_9 or var_72_9 * (utf8.len(var_72_11) / 9)

				if (9 <= 0 and var_72_9 or var_72_9 * (utf8.len(var_72_11) / 9)) > 0 and var_72_9 < var_72_13 then
					arg_69_1.talkMaxDuration = var_72_13

					if var_72_13 + var_72_8 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_13 + var_72_8
					end
				end

				arg_69_1.text_.text = var_72_11
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021016", "story_v_out_412021.awb") ~= 0 then
					local var_72_14 = manager.audio:GetVoiceLength("story_v_out_412021", "412021016", "story_v_out_412021.awb") / 1000

					if var_72_14 + var_72_8 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_14 + var_72_8
					end

					if var_72_10.prefab_name ~= "" and arg_69_1.actors_[var_72_10.prefab_name] ~= nil then
						local var_72_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_10.prefab_name].transform, "story_v_out_412021", "412021016", "story_v_out_412021.awb")

						arg_69_1:RecordAudio("412021016", var_72_15)
						arg_69_1:RecordAudio("412021016", var_72_15)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_412021", "412021016", "story_v_out_412021.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_412021", "412021016", "story_v_out_412021.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_16 = math.max(var_72_9, arg_69_1.talkMaxDuration)

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_16 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_8) / var_72_16

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_8 + var_72_16 and arg_69_1.time_ < var_72_8 + var_72_16 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play412021017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 412021017
		arg_73_1.duration_ = 10.6

		local var_73_0 = {
			zh = 8.266,
			ja = 10.6
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play412021018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos10076ui_story = arg_73_1.actors_["10076ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["10076ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10076ui_story, Vector3.New(-1, -0.35, -4), (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["10076ui_story"].transform.position).z)
				arg_73_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["10076ui_story"].transform.localEulerAngles = arg_73_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["10076ui_story"].transform.localPosition = Vector3.New(-1, -0.35, -4)
				arg_73_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["10076ui_story"].transform.position).z)
				arg_73_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["10076ui_story"].transform.localEulerAngles = arg_73_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			local var_76_1 = arg_73_1.actors_["10076ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect10076ui_story == nil then
				arg_73_1.var_.characterEffect10076ui_story = var_76_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_2 and not isNil(var_76_1) then
				if arg_73_1.var_.characterEffect10076ui_story and not isNil(var_76_1) then
					arg_73_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_2 and arg_73_1.time_ < 0 + var_76_2 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect10076ui_story then
				arg_73_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action3_2")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_76_4 = arg_73_1.actors_["1097ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_4) and arg_73_1.var_.characterEffect1097ui_story == nil then
				arg_73_1.var_.characterEffect1097ui_story = var_76_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_5 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_5 and not isNil(var_76_4) then
				if arg_73_1.var_.characterEffect1097ui_story and not isNil(var_76_4) then
					arg_73_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_5)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_5 and arg_73_1.time_ < 0 + var_76_5 + arg_76_0 and not isNil(var_76_4) and arg_73_1.var_.characterEffect1097ui_story then
				arg_73_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_76_6 = 0
			local var_76_7 = 0.85

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_8 = arg_73_1:GetWordFromCfg(412021017)
				local var_76_9 = arg_73_1:FormatText(var_76_8.content)

				arg_73_1.text_.text = var_76_9

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_11 = 34 <= 0 and var_76_7 or var_76_7 * (utf8.len(var_76_9) / 34)

				if (34 <= 0 and var_76_7 or var_76_7 * (utf8.len(var_76_9) / 34)) > 0 and var_76_7 < var_76_11 then
					arg_73_1.talkMaxDuration = var_76_11

					if var_76_11 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_11 + var_76_6
					end
				end

				arg_73_1.text_.text = var_76_9
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021017", "story_v_out_412021.awb") ~= 0 then
					local var_76_12 = manager.audio:GetVoiceLength("story_v_out_412021", "412021017", "story_v_out_412021.awb") / 1000

					if var_76_12 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_12 + var_76_6
					end

					if var_76_8.prefab_name ~= "" and arg_73_1.actors_[var_76_8.prefab_name] ~= nil then
						local var_76_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_8.prefab_name].transform, "story_v_out_412021", "412021017", "story_v_out_412021.awb")

						arg_73_1:RecordAudio("412021017", var_76_13)
						arg_73_1:RecordAudio("412021017", var_76_13)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_412021", "412021017", "story_v_out_412021.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_412021", "412021017", "story_v_out_412021.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_14 = math.max(var_76_7, arg_73_1.talkMaxDuration)

			if var_76_6 <= arg_73_1.time_ and arg_73_1.time_ < var_76_6 + var_76_14 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_6) / var_76_14

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_6 + var_76_14 and arg_73_1.time_ < var_76_6 + var_76_14 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play412021018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 412021018
		arg_77_1.duration_ = 7.9

		local var_77_0 = {
			zh = 5.466,
			ja = 7.9
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
				arg_77_0:Play412021019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["10076ui_story"]) and arg_77_1.var_.characterEffect10076ui_story == nil then
				arg_77_1.var_.characterEffect10076ui_story = arg_77_1.actors_["10076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["10076ui_story"]) then
				if arg_77_1.var_.characterEffect10076ui_story and not isNil(arg_77_1.actors_["10076ui_story"]) then
					arg_77_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_77_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_0)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["10076ui_story"]) and arg_77_1.var_.characterEffect10076ui_story then
				arg_77_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_77_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_80_1 = arg_77_1.actors_["1097ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1097ui_story == nil then
				arg_77_1.var_.characterEffect1097ui_story = var_80_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 and not isNil(var_80_1) then
				if arg_77_1.var_.characterEffect1097ui_story and not isNil(var_80_1) then
					arg_77_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1097ui_story then
				arg_77_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_80_4 = 0
			local var_80_5 = 0.45

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_6 = arg_77_1:GetWordFromCfg(412021018)
				local var_80_7 = arg_77_1:FormatText(var_80_6.content)

				arg_77_1.text_.text = var_80_7

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_9 = 18 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 18)

				if (18 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 18)) > 0 and var_80_5 < var_80_9 then
					arg_77_1.talkMaxDuration = var_80_9

					if var_80_9 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_9 + var_80_4
					end
				end

				arg_77_1.text_.text = var_80_7
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021018", "story_v_out_412021.awb") ~= 0 then
					local var_80_10 = manager.audio:GetVoiceLength("story_v_out_412021", "412021018", "story_v_out_412021.awb") / 1000

					if var_80_10 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_4
					end

					if var_80_6.prefab_name ~= "" and arg_77_1.actors_[var_80_6.prefab_name] ~= nil then
						local var_80_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_6.prefab_name].transform, "story_v_out_412021", "412021018", "story_v_out_412021.awb")

						arg_77_1:RecordAudio("412021018", var_80_11)
						arg_77_1:RecordAudio("412021018", var_80_11)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_412021", "412021018", "story_v_out_412021.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_412021", "412021018", "story_v_out_412021.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_12 = math.max(var_80_5, arg_77_1.talkMaxDuration)

			if var_80_4 <= arg_77_1.time_ and arg_77_1.time_ < var_80_4 + var_80_12 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_4) / var_80_12

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_4 + var_80_12 and arg_77_1.time_ < var_80_4 + var_80_12 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play412021019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 412021019
		arg_81_1.duration_ = 9.4

		local var_81_0 = {
			zh = 5.1,
			ja = 9.4
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play412021020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["10076ui_story"]) and arg_81_1.var_.characterEffect10076ui_story == nil then
				arg_81_1.var_.characterEffect10076ui_story = arg_81_1.actors_["10076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["10076ui_story"]) then
				if arg_81_1.var_.characterEffect10076ui_story and not isNil(arg_81_1.actors_["10076ui_story"]) then
					arg_81_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["10076ui_story"]) and arg_81_1.var_.characterEffect10076ui_story then
				arg_81_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action1_1")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_2 = arg_81_1.actors_["1097ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.characterEffect1097ui_story == nil then
				arg_81_1.var_.characterEffect1097ui_story = var_84_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_3 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_3 and not isNil(var_84_2) then
				if arg_81_1.var_.characterEffect1097ui_story and not isNil(var_84_2) then
					arg_81_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_3)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_3 and arg_81_1.time_ < 0 + var_84_3 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.characterEffect1097ui_story then
				arg_81_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_84_4 = 0
			local var_84_5 = 0.5

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_6 = arg_81_1:GetWordFromCfg(412021019)
				local var_84_7 = arg_81_1:FormatText(var_84_6.content)

				arg_81_1.text_.text = var_84_7

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 20 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 20)

				if (20 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 20)) > 0 and var_84_5 < var_84_9 then
					arg_81_1.talkMaxDuration = var_84_9

					if var_84_9 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_4
					end
				end

				arg_81_1.text_.text = var_84_7
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021019", "story_v_out_412021.awb") ~= 0 then
					local var_84_10 = manager.audio:GetVoiceLength("story_v_out_412021", "412021019", "story_v_out_412021.awb") / 1000

					if var_84_10 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_4
					end

					if var_84_6.prefab_name ~= "" and arg_81_1.actors_[var_84_6.prefab_name] ~= nil then
						local var_84_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_6.prefab_name].transform, "story_v_out_412021", "412021019", "story_v_out_412021.awb")

						arg_81_1:RecordAudio("412021019", var_84_11)
						arg_81_1:RecordAudio("412021019", var_84_11)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_412021", "412021019", "story_v_out_412021.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_412021", "412021019", "story_v_out_412021.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_12 = math.max(var_84_5, arg_81_1.talkMaxDuration)

			if var_84_4 <= arg_81_1.time_ and arg_81_1.time_ < var_84_4 + var_84_12 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_4) / var_84_12

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_4 + var_84_12 and arg_81_1.time_ < var_84_4 + var_84_12 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play412021020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 412021020
		arg_85_1.duration_ = 10.9

		local var_85_0 = {
			zh = 7.533,
			ja = 10.9
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
				arg_85_0:Play412021021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1097ui_story"]) and arg_85_1.var_.characterEffect1097ui_story == nil then
				arg_85_1.var_.characterEffect1097ui_story = arg_85_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["1097ui_story"]) then
				if arg_85_1.var_.characterEffect1097ui_story and not isNil(arg_85_1.actors_["1097ui_story"]) then
					arg_85_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["1097ui_story"]) and arg_85_1.var_.characterEffect1097ui_story then
				arg_85_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_88_2 = arg_85_1.actors_["10076ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.characterEffect10076ui_story == nil then
				arg_85_1.var_.characterEffect10076ui_story = var_88_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_3 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_3 and not isNil(var_88_2) then
				if arg_85_1.var_.characterEffect10076ui_story and not isNil(var_88_2) then
					arg_85_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_85_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_3)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_3 and arg_85_1.time_ < 0 + var_88_3 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.characterEffect10076ui_story then
				arg_85_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_85_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_88_4 = 0
			local var_88_5 = 0.675

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_6 = arg_85_1:GetWordFromCfg(412021020)
				local var_88_7 = arg_85_1:FormatText(var_88_6.content)

				arg_85_1.text_.text = var_88_7

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_9 = 27 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 27)

				if (27 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 27)) > 0 and var_88_5 < var_88_9 then
					arg_85_1.talkMaxDuration = var_88_9

					if var_88_9 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_7
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021020", "story_v_out_412021.awb") ~= 0 then
					local var_88_10 = manager.audio:GetVoiceLength("story_v_out_412021", "412021020", "story_v_out_412021.awb") / 1000

					if var_88_10 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_4
					end

					if var_88_6.prefab_name ~= "" and arg_85_1.actors_[var_88_6.prefab_name] ~= nil then
						local var_88_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_6.prefab_name].transform, "story_v_out_412021", "412021020", "story_v_out_412021.awb")

						arg_85_1:RecordAudio("412021020", var_88_11)
						arg_85_1:RecordAudio("412021020", var_88_11)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_412021", "412021020", "story_v_out_412021.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_412021", "412021020", "story_v_out_412021.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_12 = math.max(var_88_5, arg_85_1.talkMaxDuration)

			if var_88_4 <= arg_85_1.time_ and arg_85_1.time_ < var_88_4 + var_88_12 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_4) / var_88_12

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_4 + var_88_12 and arg_85_1.time_ < var_88_4 + var_88_12 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play412021021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 412021021
		arg_89_1.duration_ = 9

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play412021022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if arg_89_1.bgs_.EN0105 == nil then
				local var_92_0 = Object.Instantiate(arg_89_1.paintGo_)

				var_92_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "EN0105")
				var_92_0.name = "EN0105"
				var_92_0.transform.parent = arg_89_1.stage_.transform
				var_92_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_89_1.bgs_.EN0105 = var_92_0
			end

			if 1.98333333333333 < arg_89_1.time_ and arg_89_1.time_ <= 1.98333333333333 + arg_92_0 then
				local var_92_1 = arg_89_1.bgs_.EN0105

				arg_89_1.bgs_.EN0105.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_92_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_92_2 = var_92_1:GetComponent("SpriteRenderer")

				if var_92_2 and var_92_2.sprite then
					local var_92_3 = 2 * (var_92_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_92_1.transform.localScale = Vector3.New(var_92_3 / var_92_2.sprite.bounds.size.y < var_92_3 * manager.ui.mainCameraCom_.aspect / var_92_2.sprite.bounds.size.x and var_92_3 * manager.ui.mainCameraCom_.aspect / var_92_2.sprite.bounds.size.x or var_92_3 / var_92_2.sprite.bounds.size.y, var_92_3 / var_92_2.sprite.bounds.size.y < var_92_3 * manager.ui.mainCameraCom_.aspect / var_92_2.sprite.bounds.size.x and var_92_3 * manager.ui.mainCameraCom_.aspect / var_92_2.sprite.bounds.size.x or var_92_3 / var_92_2.sprite.bounds.size.y, 0)
				end

				for iter_92_0, iter_92_1 in pairs(arg_89_1.bgs_) do
					if iter_92_0 ~= "EN0105" then
						iter_92_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_92_4 = 4

			if 4 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.allBtn_.enabled = false
			end

			if arg_89_1.time_ >= var_92_4 + 0.3 and arg_89_1.time_ < var_92_4 + 0.3 + arg_92_0 then
				arg_89_1.allBtn_.enabled = true
			end

			local var_92_5 = 0

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_5 + arg_92_0 then
				arg_89_1.mask_.enabled = true
				arg_89_1.mask_.raycastTarget = true

				arg_89_1:SetGaussion(false)
			end

			local var_92_6 = 2

			if var_92_5 <= arg_89_1.time_ and arg_89_1.time_ < var_92_5 + var_92_6 then
				local var_92_7 = Color.New(0, 0, 0)

				var_92_7.a = Mathf.Lerp(0, 1, (arg_89_1.time_ - var_92_5) / var_92_6)
				arg_89_1.mask_.color = var_92_7
			end

			if arg_89_1.time_ >= var_92_5 + var_92_6 and arg_89_1.time_ < var_92_5 + var_92_6 + arg_92_0 then
				local var_92_8 = Color.New(0, 0, 0)

				var_92_8.a = 1
				arg_89_1.mask_.color = var_92_8
			end

			local var_92_9 = 2

			if 2 < arg_89_1.time_ and arg_89_1.time_ <= var_92_9 + arg_92_0 then
				arg_89_1.mask_.enabled = true
				arg_89_1.mask_.raycastTarget = true

				arg_89_1:SetGaussion(false)
			end

			local var_92_10 = 2

			if var_92_9 <= arg_89_1.time_ and arg_89_1.time_ < var_92_9 + var_92_10 then
				local var_92_11 = Color.New(0, 0, 0)

				var_92_11.a = Mathf.Lerp(1, 0, (arg_89_1.time_ - var_92_9) / var_92_10)
				arg_89_1.mask_.color = var_92_11
			end

			if arg_89_1.time_ >= var_92_9 + var_92_10 and arg_89_1.time_ < var_92_9 + var_92_10 + arg_92_0 then
				local var_92_12 = Color.New(0, 0, 0)

				arg_89_1.mask_.enabled = false
				var_92_12.a = 0
				arg_89_1.mask_.color = var_92_12
			end

			local var_92_13 = arg_89_1.actors_["1097ui_story"].transform

			if 1.96599999815226 < arg_89_1.time_ and arg_89_1.time_ <= 1.96599999815226 + arg_92_0 then
				arg_89_1.var_.moveOldPos1097ui_story = var_92_13.localPosition
			end

			local var_92_14 = 0.001

			if 1.96599999815226 <= arg_89_1.time_ and arg_89_1.time_ < 1.96599999815226 + var_92_14 then
				var_92_13.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_89_1.time_ - 1.96599999815226) / var_92_14)
				var_92_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_13.position).x, (manager.ui.mainCamera.transform.position - var_92_13.position).y, (manager.ui.mainCamera.transform.position - var_92_13.position).z)
				var_92_13.localEulerAngles.z = 0
				var_92_13.localEulerAngles.x = 0
				var_92_13.localEulerAngles = var_92_13.localEulerAngles
			end

			if arg_89_1.time_ >= 1.96599999815226 + var_92_14 and arg_89_1.time_ < 1.96599999815226 + var_92_14 + arg_92_0 then
				var_92_13.localPosition = Vector3.New(0, 100, 0)
				var_92_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_13.position).x, (manager.ui.mainCamera.transform.position - var_92_13.position).y, (manager.ui.mainCamera.transform.position - var_92_13.position).z)
				var_92_13.localEulerAngles.z = 0
				var_92_13.localEulerAngles.x = 0
				var_92_13.localEulerAngles = var_92_13.localEulerAngles
			end

			local var_92_15 = arg_89_1.actors_["1097ui_story"]

			if 1.96599999815226 < arg_89_1.time_ and arg_89_1.time_ <= 1.96599999815226 + arg_92_0 and not isNil(var_92_15) and arg_89_1.var_.characterEffect1097ui_story == nil then
				arg_89_1.var_.characterEffect1097ui_story = var_92_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_16 = 0.034000001847744

			if 1.96599999815226 <= arg_89_1.time_ and arg_89_1.time_ < 1.96599999815226 + var_92_16 and not isNil(var_92_15) then
				if arg_89_1.var_.characterEffect1097ui_story and not isNil(var_92_15) then
					arg_89_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 1.96599999815226) / var_92_16)
				end
			end

			if arg_89_1.time_ >= 1.96599999815226 + var_92_16 and arg_89_1.time_ < 1.96599999815226 + var_92_16 + arg_92_0 and not isNil(var_92_15) and arg_89_1.var_.characterEffect1097ui_story then
				arg_89_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_92_17 = arg_89_1.actors_["10076ui_story"].transform

			if 1.96599999815226 < arg_89_1.time_ and arg_89_1.time_ <= 1.96599999815226 + arg_92_0 then
				arg_89_1.var_.moveOldPos10076ui_story = var_92_17.localPosition
			end

			local var_92_18 = 0.001

			if 1.96599999815226 <= arg_89_1.time_ and arg_89_1.time_ < 1.96599999815226 + var_92_18 then
				var_92_17.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10076ui_story, Vector3.New(0, 100, 0), (arg_89_1.time_ - 1.96599999815226) / var_92_18)
				var_92_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_17.position).x, (manager.ui.mainCamera.transform.position - var_92_17.position).y, (manager.ui.mainCamera.transform.position - var_92_17.position).z)
				var_92_17.localEulerAngles.z = 0
				var_92_17.localEulerAngles.x = 0
				var_92_17.localEulerAngles = var_92_17.localEulerAngles
			end

			if arg_89_1.time_ >= 1.96599999815226 + var_92_18 and arg_89_1.time_ < 1.96599999815226 + var_92_18 + arg_92_0 then
				var_92_17.localPosition = Vector3.New(0, 100, 0)
				var_92_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_17.position).x, (manager.ui.mainCamera.transform.position - var_92_17.position).y, (manager.ui.mainCamera.transform.position - var_92_17.position).z)
				var_92_17.localEulerAngles.z = 0
				var_92_17.localEulerAngles.x = 0
				var_92_17.localEulerAngles = var_92_17.localEulerAngles
			end

			local var_92_19 = arg_89_1.actors_["10076ui_story"]

			if 1.96599999815226 < arg_89_1.time_ and arg_89_1.time_ <= 1.96599999815226 + arg_92_0 and not isNil(var_92_19) and arg_89_1.var_.characterEffect10076ui_story == nil then
				arg_89_1.var_.characterEffect10076ui_story = var_92_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_20 = 0.034000001847744

			if 1.96599999815226 <= arg_89_1.time_ and arg_89_1.time_ < 1.96599999815226 + var_92_20 and not isNil(var_92_19) then
				if arg_89_1.var_.characterEffect10076ui_story and not isNil(var_92_19) then
					arg_89_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_89_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 1.96599999815226) / var_92_20)
				end
			end

			if arg_89_1.time_ >= 1.96599999815226 + var_92_20 and arg_89_1.time_ < 1.96599999815226 + var_92_20 + arg_92_0 and not isNil(var_92_19) and arg_89_1.var_.characterEffect10076ui_story then
				arg_89_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_89_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_92_21 = arg_89_1.bgs_.EN0105.transform

			if 2 < arg_89_1.time_ and arg_89_1.time_ <= 2 + arg_92_0 then
				arg_89_1.var_.moveOldPosEN0105 = var_92_21.localPosition
			end

			local var_92_22 = 0.001

			if 2 <= arg_89_1.time_ and arg_89_1.time_ < 2 + var_92_22 then
				var_92_21.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPosEN0105, Vector3.New(0, 1, 9), (arg_89_1.time_ - 2) / var_92_22)
			end

			if arg_89_1.time_ >= 2 + var_92_22 and arg_89_1.time_ < 2 + var_92_22 + arg_92_0 then
				var_92_21.localPosition = Vector3.New(0, 1, 9)
			end

			local var_92_23 = arg_89_1.bgs_.EN0105.transform

			if 2.01666666666667 < arg_89_1.time_ and arg_89_1.time_ <= 2.01666666666667 + arg_92_0 then
				arg_89_1.var_.moveOldPosEN0105 = var_92_23.localPosition
			end

			local var_92_24 = 5

			if 2.01666666666667 <= arg_89_1.time_ and arg_89_1.time_ < 2.01666666666667 + var_92_24 then
				var_92_23.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPosEN0105, Vector3.New(0, 1, 10), (arg_89_1.time_ - 2.01666666666667) / var_92_24)
			end

			if arg_89_1.time_ >= 2.01666666666667 + var_92_24 and arg_89_1.time_ < 2.01666666666667 + var_92_24 + arg_92_0 then
				var_92_23.localPosition = Vector3.New(0, 1, 10)
			end

			local var_92_25 = 4

			if 4 < arg_89_1.time_ and arg_89_1.time_ <= var_92_25 + arg_92_0 then
				arg_89_1.allBtn_.enabled = false
			end

			if arg_89_1.time_ >= var_92_25 + 3.01666666666667 and arg_89_1.time_ < var_92_25 + 3.01666666666667 + arg_92_0 then
				arg_89_1.allBtn_.enabled = true
			end

			if arg_89_1.frameCnt_ <= 1 then
				arg_89_1.dialog_:SetActive(false)
			end

			local var_92_26 = 4
			local var_92_27 = 0.35

			if 4 < arg_89_1.time_ and arg_89_1.time_ <= var_92_26 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0

				arg_89_1.dialog_:SetActive(true)

				arg_89_1.dialogCg_.alpha = 0

				local var_92_28 = LeanTween.value(arg_89_1.dialog_, 0, 1, 0.3)

				var_92_28:setOnUpdate(LuaHelper.FloatAction(function(arg_93_0)
					arg_89_1.dialogCg_.alpha = arg_93_0
				end))
				var_92_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_89_1.dialog_)
					var_92_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_89_1.duration_ = arg_89_1.duration_ + 0.3

				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_29 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(412021021).content)

				arg_89_1.text_.text = var_92_29

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_31 = 14 <= 0 and var_92_27 or var_92_27 * (utf8.len(var_92_29) / 14)

				if (14 <= 0 and var_92_27 or var_92_27 * (utf8.len(var_92_29) / 14)) > 0 and var_92_27 < var_92_31 then
					arg_89_1.talkMaxDuration = var_92_31
					var_92_26 = var_92_26 + 0.3

					if var_92_31 + var_92_26 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_31 + var_92_26
					end
				end

				arg_89_1.text_.text = var_92_29
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_32 = var_92_26 + 0.3
			local var_92_33 = math.max(var_92_27, arg_89_1.talkMaxDuration)

			if var_92_26 + 0.3 <= arg_89_1.time_ and arg_89_1.time_ < var_92_32 + var_92_33 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_32) / var_92_33

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_32 + var_92_33 and arg_89_1.time_ < var_92_32 + var_92_33 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "EN0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "EN0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play412021022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 412021022
		arg_95_1.duration_ = 4.17

		local var_95_0 = {
			zh = 4.166,
			ja = 3.433
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
				arg_95_0:Play412021023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0.4

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_1 = arg_95_1:GetWordFromCfg(412021022)
				local var_98_2 = arg_95_1:FormatText(var_98_1.content)

				arg_95_1.text_.text = var_98_2

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_4 = 16 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 16)

				if (16 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 16)) > 0 and var_98_0 < var_98_4 then
					arg_95_1.talkMaxDuration = var_98_4

					if var_98_4 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_4 + 0
					end
				end

				arg_95_1.text_.text = var_98_2
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021022", "story_v_out_412021.awb") ~= 0 then
					local var_98_5 = manager.audio:GetVoiceLength("story_v_out_412021", "412021022", "story_v_out_412021.awb") / 1000

					if var_98_5 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_5 + 0
					end

					if var_98_1.prefab_name ~= "" and arg_95_1.actors_[var_98_1.prefab_name] ~= nil then
						local var_98_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_1.prefab_name].transform, "story_v_out_412021", "412021022", "story_v_out_412021.awb")

						arg_95_1:RecordAudio("412021022", var_98_6)
						arg_95_1:RecordAudio("412021022", var_98_6)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_412021", "412021022", "story_v_out_412021.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_412021", "412021022", "story_v_out_412021.awb")
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
	Play412021023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 412021023
		arg_99_1.duration_ = 6.6

		local var_99_0 = {
			zh = 6.6,
			ja = 1.9
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
				arg_99_0:Play412021024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0.25

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_1 = arg_99_1:GetWordFromCfg(412021023)
				local var_102_2 = arg_99_1:FormatText(var_102_1.content)

				arg_99_1.text_.text = var_102_2

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 10 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 10)

				if (10 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 10)) > 0 and var_102_0 < var_102_4 then
					arg_99_1.talkMaxDuration = var_102_4

					if var_102_4 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_4 + 0
					end
				end

				arg_99_1.text_.text = var_102_2
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021023", "story_v_out_412021.awb") ~= 0 then
					local var_102_5 = manager.audio:GetVoiceLength("story_v_out_412021", "412021023", "story_v_out_412021.awb") / 1000

					if var_102_5 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_5 + 0
					end

					if var_102_1.prefab_name ~= "" and arg_99_1.actors_[var_102_1.prefab_name] ~= nil then
						local var_102_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_1.prefab_name].transform, "story_v_out_412021", "412021023", "story_v_out_412021.awb")

						arg_99_1:RecordAudio("412021023", var_102_6)
						arg_99_1:RecordAudio("412021023", var_102_6)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_412021", "412021023", "story_v_out_412021.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_412021", "412021023", "story_v_out_412021.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_7 = math.max(var_102_0, arg_99_1.talkMaxDuration)

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_7 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - 0) / var_102_7

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= 0 + var_102_7 and arg_99_1.time_ < 0 + var_102_7 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play412021024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 412021024
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play412021025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(arg_103_1.actors_["1097ui_story"]) and arg_103_1.var_.characterEffect1097ui_story == nil then
				arg_103_1.var_.characterEffect1097ui_story = arg_103_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_0 = 0.2

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 and not isNil(arg_103_1.actors_["1097ui_story"]) then
				if arg_103_1.var_.characterEffect1097ui_story and not isNil(arg_103_1.actors_["1097ui_story"]) then
					arg_103_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_103_1.time_ - 0) / var_106_0)
				end
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 and not isNil(arg_103_1.actors_["1097ui_story"]) and arg_103_1.var_.characterEffect1097ui_story then
				arg_103_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_106_1 = 0
			local var_106_2 = 0.925

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_3 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(412021024).content)

				arg_103_1.text_.text = var_106_3

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 37 <= 0 and var_106_2 or var_106_2 * (utf8.len(var_106_3) / 37)

				if (37 <= 0 and var_106_2 or var_106_2 * (utf8.len(var_106_3) / 37)) > 0 and var_106_2 < var_106_5 then
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
	Play412021025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 412021025
		arg_107_1.duration_ = 7.3

		local var_107_0 = {
			zh = 6.366,
			ja = 7.3
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
				arg_107_0:Play412021026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0.4

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_1 = arg_107_1:GetWordFromCfg(412021025)
				local var_110_2 = arg_107_1:FormatText(var_110_1.content)

				arg_107_1.text_.text = var_110_2

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_4 = 16 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_2) / 16)

				if (16 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_2) / 16)) > 0 and var_110_0 < var_110_4 then
					arg_107_1.talkMaxDuration = var_110_4

					if var_110_4 + 0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_4 + 0
					end
				end

				arg_107_1.text_.text = var_110_2
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021025", "story_v_out_412021.awb") ~= 0 then
					local var_110_5 = manager.audio:GetVoiceLength("story_v_out_412021", "412021025", "story_v_out_412021.awb") / 1000

					if var_110_5 + 0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_5 + 0
					end

					if var_110_1.prefab_name ~= "" and arg_107_1.actors_[var_110_1.prefab_name] ~= nil then
						local var_110_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_1.prefab_name].transform, "story_v_out_412021", "412021025", "story_v_out_412021.awb")

						arg_107_1:RecordAudio("412021025", var_110_6)
						arg_107_1:RecordAudio("412021025", var_110_6)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_412021", "412021025", "story_v_out_412021.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_412021", "412021025", "story_v_out_412021.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_7 = math.max(var_110_0, arg_107_1.talkMaxDuration)

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_7 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - 0) / var_110_7

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= 0 + var_110_7 and arg_107_1.time_ < 0 + var_110_7 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play412021026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 412021026
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play412021027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["1097ui_story"]) and arg_111_1.var_.characterEffect1097ui_story == nil then
				arg_111_1.var_.characterEffect1097ui_story = arg_111_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_0 = 0.2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["1097ui_story"]) then
				if arg_111_1.var_.characterEffect1097ui_story and not isNil(arg_111_1.actors_["1097ui_story"]) then
					arg_111_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0) / var_114_0)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["1097ui_story"]) and arg_111_1.var_.characterEffect1097ui_story then
				arg_111_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_114_1 = 0
			local var_114_2 = 0.15

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_3 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(412021026).content)

				arg_111_1.text_.text = var_114_3

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 6 <= 0 and var_114_2 or var_114_2 * (utf8.len(var_114_3) / 6)

				if (6 <= 0 and var_114_2 or var_114_2 * (utf8.len(var_114_3) / 6)) > 0 and var_114_2 < var_114_5 then
					arg_111_1.talkMaxDuration = var_114_5

					if var_114_5 + var_114_1 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_5 + var_114_1
					end
				end

				arg_111_1.text_.text = var_114_3
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_6 = math.max(var_114_2, arg_111_1.talkMaxDuration)

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_6 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_1) / var_114_6

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_1 + var_114_6 and arg_111_1.time_ < var_114_1 + var_114_6 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play412021027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 412021027
		arg_115_1.duration_ = 11.27

		local var_115_0 = {
			zh = 7.066,
			ja = 11.266
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play412021028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0.75

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10076")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_1 = arg_115_1:GetWordFromCfg(412021027)
				local var_118_2 = arg_115_1:FormatText(var_118_1.content)

				arg_115_1.text_.text = var_118_2

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_4 = 30 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 30)

				if (30 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 30)) > 0 and var_118_0 < var_118_4 then
					arg_115_1.talkMaxDuration = var_118_4

					if var_118_4 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_4 + 0
					end
				end

				arg_115_1.text_.text = var_118_2
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021027", "story_v_out_412021.awb") ~= 0 then
					local var_118_5 = manager.audio:GetVoiceLength("story_v_out_412021", "412021027", "story_v_out_412021.awb") / 1000

					if var_118_5 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_5 + 0
					end

					if var_118_1.prefab_name ~= "" and arg_115_1.actors_[var_118_1.prefab_name] ~= nil then
						local var_118_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_1.prefab_name].transform, "story_v_out_412021", "412021027", "story_v_out_412021.awb")

						arg_115_1:RecordAudio("412021027", var_118_6)
						arg_115_1:RecordAudio("412021027", var_118_6)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_412021", "412021027", "story_v_out_412021.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_412021", "412021027", "story_v_out_412021.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_7 = math.max(var_118_0, arg_115_1.talkMaxDuration)

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_7 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - 0) / var_118_7

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= 0 + var_118_7 and arg_115_1.time_ < 0 + var_118_7 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play412021028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 412021028
		arg_119_1.duration_ = 4.2

		local var_119_0 = {
			zh = 3.633,
			ja = 4.2
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
				arg_119_0:Play412021029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["10076ui_story"]) and arg_119_1.var_.characterEffect10076ui_story == nil then
				arg_119_1.var_.characterEffect10076ui_story = arg_119_1.actors_["10076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_0 = 0.2

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["10076ui_story"]) then
				if arg_119_1.var_.characterEffect10076ui_story and not isNil(arg_119_1.actors_["10076ui_story"]) then
					arg_119_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_119_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_0)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["10076ui_story"]) and arg_119_1.var_.characterEffect10076ui_story then
				arg_119_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_119_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_122_1 = 0
			local var_122_2 = 0.375

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_3 = arg_119_1:GetWordFromCfg(412021028)
				local var_122_4 = arg_119_1:FormatText(var_122_3.content)

				arg_119_1.text_.text = var_122_4

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_6 = 15 <= 0 and var_122_2 or var_122_2 * (utf8.len(var_122_4) / 15)

				if (15 <= 0 and var_122_2 or var_122_2 * (utf8.len(var_122_4) / 15)) > 0 and var_122_2 < var_122_6 then
					arg_119_1.talkMaxDuration = var_122_6

					if var_122_6 + var_122_1 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_6 + var_122_1
					end
				end

				arg_119_1.text_.text = var_122_4
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021028", "story_v_out_412021.awb") ~= 0 then
					local var_122_7 = manager.audio:GetVoiceLength("story_v_out_412021", "412021028", "story_v_out_412021.awb") / 1000

					if var_122_7 + var_122_1 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_7 + var_122_1
					end

					if var_122_3.prefab_name ~= "" and arg_119_1.actors_[var_122_3.prefab_name] ~= nil then
						local var_122_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_3.prefab_name].transform, "story_v_out_412021", "412021028", "story_v_out_412021.awb")

						arg_119_1:RecordAudio("412021028", var_122_8)
						arg_119_1:RecordAudio("412021028", var_122_8)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_412021", "412021028", "story_v_out_412021.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_412021", "412021028", "story_v_out_412021.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_9 = math.max(var_122_2, arg_119_1.talkMaxDuration)

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_9 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_1) / var_122_9

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_1 + var_122_9 and arg_119_1.time_ < var_122_1 + var_122_9 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play412021029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 412021029
		arg_123_1.duration_ = 12.03

		local var_123_0 = {
			zh = 11.3,
			ja = 12.033
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play412021030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["1097ui_story"]) and arg_123_1.var_.characterEffect1097ui_story == nil then
				arg_123_1.var_.characterEffect1097ui_story = arg_123_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_0 = 0.2

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["1097ui_story"]) then
				if arg_123_1.var_.characterEffect1097ui_story and not isNil(arg_123_1.actors_["1097ui_story"]) then
					arg_123_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["1097ui_story"]) and arg_123_1.var_.characterEffect1097ui_story then
				arg_123_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_126_2 = 0
			local var_126_3 = 0.725

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_2 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_4 = arg_123_1:GetWordFromCfg(412021029)
				local var_126_5 = arg_123_1:FormatText(var_126_4.content)

				arg_123_1.text_.text = var_126_5

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_7 = 29 <= 0 and var_126_3 or var_126_3 * (utf8.len(var_126_5) / 29)

				if (29 <= 0 and var_126_3 or var_126_3 * (utf8.len(var_126_5) / 29)) > 0 and var_126_3 < var_126_7 then
					arg_123_1.talkMaxDuration = var_126_7

					if var_126_7 + var_126_2 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_7 + var_126_2
					end
				end

				arg_123_1.text_.text = var_126_5
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021029", "story_v_out_412021.awb") ~= 0 then
					local var_126_8 = manager.audio:GetVoiceLength("story_v_out_412021", "412021029", "story_v_out_412021.awb") / 1000

					if var_126_8 + var_126_2 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_2
					end

					if var_126_4.prefab_name ~= "" and arg_123_1.actors_[var_126_4.prefab_name] ~= nil then
						local var_126_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_4.prefab_name].transform, "story_v_out_412021", "412021029", "story_v_out_412021.awb")

						arg_123_1:RecordAudio("412021029", var_126_9)
						arg_123_1:RecordAudio("412021029", var_126_9)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_412021", "412021029", "story_v_out_412021.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_412021", "412021029", "story_v_out_412021.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_10 = math.max(var_126_3, arg_123_1.talkMaxDuration)

			if var_126_2 <= arg_123_1.time_ and arg_123_1.time_ < var_126_2 + var_126_10 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_2) / var_126_10

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_2 + var_126_10 and arg_123_1.time_ < var_126_2 + var_126_10 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play412021030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 412021030
		arg_127_1.duration_ = 4.83

		local var_127_0 = {
			zh = 3.7,
			ja = 4.833
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
				arg_127_0:Play412021031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["1097ui_story"]) and arg_127_1.var_.characterEffect1097ui_story == nil then
				arg_127_1.var_.characterEffect1097ui_story = arg_127_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_0 = 0.2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["1097ui_story"]) then
				if arg_127_1.var_.characterEffect1097ui_story and not isNil(arg_127_1.actors_["1097ui_story"]) then
					arg_127_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_0)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["1097ui_story"]) and arg_127_1.var_.characterEffect1097ui_story then
				arg_127_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_130_1 = 0
			local var_130_2 = 0.45

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_3 = arg_127_1:GetWordFromCfg(412021030)
				local var_130_4 = arg_127_1:FormatText(var_130_3.content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_6 = 18 <= 0 and var_130_2 or var_130_2 * (utf8.len(var_130_4) / 18)

				if (18 <= 0 and var_130_2 or var_130_2 * (utf8.len(var_130_4) / 18)) > 0 and var_130_2 < var_130_6 then
					arg_127_1.talkMaxDuration = var_130_6

					if var_130_6 + var_130_1 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_6 + var_130_1
					end
				end

				arg_127_1.text_.text = var_130_4
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021030", "story_v_out_412021.awb") ~= 0 then
					local var_130_7 = manager.audio:GetVoiceLength("story_v_out_412021", "412021030", "story_v_out_412021.awb") / 1000

					if var_130_7 + var_130_1 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_7 + var_130_1
					end

					if var_130_3.prefab_name ~= "" and arg_127_1.actors_[var_130_3.prefab_name] ~= nil then
						local var_130_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_3.prefab_name].transform, "story_v_out_412021", "412021030", "story_v_out_412021.awb")

						arg_127_1:RecordAudio("412021030", var_130_8)
						arg_127_1:RecordAudio("412021030", var_130_8)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_412021", "412021030", "story_v_out_412021.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_412021", "412021030", "story_v_out_412021.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_9 = math.max(var_130_2, arg_127_1.talkMaxDuration)

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_9 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_1) / var_130_9

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_1 + var_130_9 and arg_127_1.time_ < var_130_1 + var_130_9 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play412021031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 412021031
		arg_131_1.duration_ = 11

		local var_131_0 = {
			zh = 11,
			ja = 8.233
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play412021032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.95

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_1 = arg_131_1:GetWordFromCfg(412021031)
				local var_134_2 = arg_131_1:FormatText(var_134_1.content)

				arg_131_1.text_.text = var_134_2

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_4 = 38 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 38)

				if (38 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 38)) > 0 and var_134_0 < var_134_4 then
					arg_131_1.talkMaxDuration = var_134_4

					if var_134_4 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_4 + 0
					end
				end

				arg_131_1.text_.text = var_134_2
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021031", "story_v_out_412021.awb") ~= 0 then
					local var_134_5 = manager.audio:GetVoiceLength("story_v_out_412021", "412021031", "story_v_out_412021.awb") / 1000

					if var_134_5 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_5 + 0
					end

					if var_134_1.prefab_name ~= "" and arg_131_1.actors_[var_134_1.prefab_name] ~= nil then
						local var_134_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_1.prefab_name].transform, "story_v_out_412021", "412021031", "story_v_out_412021.awb")

						arg_131_1:RecordAudio("412021031", var_134_6)
						arg_131_1:RecordAudio("412021031", var_134_6)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_412021", "412021031", "story_v_out_412021.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_412021", "412021031", "story_v_out_412021.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_7 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_7 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_7

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_7 and arg_131_1.time_ < 0 + var_134_7 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play412021032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 412021032
		arg_135_1.duration_ = 9.6

		local var_135_0 = {
			zh = 4.466,
			ja = 9.6
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
				arg_135_0:Play412021033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0.35

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_1 = arg_135_1:GetWordFromCfg(412021032)
				local var_138_2 = arg_135_1:FormatText(var_138_1.content)

				arg_135_1.text_.text = var_138_2

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_4 = 14 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 14)

				if (14 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 14)) > 0 and var_138_0 < var_138_4 then
					arg_135_1.talkMaxDuration = var_138_4

					if var_138_4 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_4 + 0
					end
				end

				arg_135_1.text_.text = var_138_2
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021032", "story_v_out_412021.awb") ~= 0 then
					local var_138_5 = manager.audio:GetVoiceLength("story_v_out_412021", "412021032", "story_v_out_412021.awb") / 1000

					if var_138_5 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_5 + 0
					end

					if var_138_1.prefab_name ~= "" and arg_135_1.actors_[var_138_1.prefab_name] ~= nil then
						local var_138_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_1.prefab_name].transform, "story_v_out_412021", "412021032", "story_v_out_412021.awb")

						arg_135_1:RecordAudio("412021032", var_138_6)
						arg_135_1:RecordAudio("412021032", var_138_6)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_412021", "412021032", "story_v_out_412021.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_412021", "412021032", "story_v_out_412021.awb")
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
	Play412021033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 412021033
		arg_139_1.duration_ = 4.63

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play412021034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				local var_142_0 = arg_139_1.bgs_.I09g

				arg_139_1.bgs_.I09g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_142_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_142_1 = var_142_0:GetComponent("SpriteRenderer")

				if var_142_1 and var_142_1.sprite then
					local var_142_2 = 2 * (var_142_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_142_0.transform.localScale = Vector3.New(var_142_2 / var_142_1.sprite.bounds.size.y < var_142_2 * manager.ui.mainCameraCom_.aspect / var_142_1.sprite.bounds.size.x and var_142_2 * manager.ui.mainCameraCom_.aspect / var_142_1.sprite.bounds.size.x or var_142_2 / var_142_1.sprite.bounds.size.y, var_142_2 / var_142_1.sprite.bounds.size.y < var_142_2 * manager.ui.mainCameraCom_.aspect / var_142_1.sprite.bounds.size.x and var_142_2 * manager.ui.mainCameraCom_.aspect / var_142_1.sprite.bounds.size.x or var_142_2 / var_142_1.sprite.bounds.size.y, 0)
				end

				for iter_142_0, iter_142_1 in pairs(arg_139_1.bgs_) do
					if iter_142_0 ~= "I09g" then
						iter_142_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_142_3 = 1.999999999999

			if 1.999999999999 < arg_139_1.time_ and arg_139_1.time_ <= var_142_3 + arg_142_0 then
				arg_139_1.allBtn_.enabled = false
			end

			if arg_139_1.time_ >= var_142_3 + 0.3 and arg_139_1.time_ < var_142_3 + 0.3 + arg_142_0 then
				arg_139_1.allBtn_.enabled = true
			end

			local var_142_4 = 0

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_4 + arg_142_0 then
				arg_139_1.mask_.enabled = true
				arg_139_1.mask_.raycastTarget = true

				arg_139_1:SetGaussion(false)
			end

			local var_142_5 = 2

			if var_142_4 <= arg_139_1.time_ and arg_139_1.time_ < var_142_4 + var_142_5 then
				local var_142_6 = Color.New(1, 1, 1)

				var_142_6.a = Mathf.Lerp(1, 0, (arg_139_1.time_ - var_142_4) / var_142_5)
				arg_139_1.mask_.color = var_142_6
			end

			if arg_139_1.time_ >= var_142_4 + var_142_5 and arg_139_1.time_ < var_142_4 + var_142_5 + arg_142_0 then
				local var_142_7 = Color.New(1, 1, 1)

				arg_139_1.mask_.enabled = false
				var_142_7.a = 0
				arg_139_1.mask_.color = var_142_7
			end

			local var_142_8 = arg_139_1.actors_["10076ui_story"].transform

			if 1.8 < arg_139_1.time_ and arg_139_1.time_ <= 1.8 + arg_142_0 then
				arg_139_1.var_.moveOldPos10076ui_story = var_142_8.localPosition
			end

			local var_142_9 = 0.001

			if 1.8 <= arg_139_1.time_ and arg_139_1.time_ < 1.8 + var_142_9 then
				var_142_8.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10076ui_story, Vector3.New(-1, -0.35, -4), (arg_139_1.time_ - 1.8) / var_142_9)
				var_142_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_8.position).x, (manager.ui.mainCamera.transform.position - var_142_8.position).y, (manager.ui.mainCamera.transform.position - var_142_8.position).z)
				var_142_8.localEulerAngles.z = 0
				var_142_8.localEulerAngles.x = 0
				var_142_8.localEulerAngles = var_142_8.localEulerAngles
			end

			if arg_139_1.time_ >= 1.8 + var_142_9 and arg_139_1.time_ < 1.8 + var_142_9 + arg_142_0 then
				var_142_8.localPosition = Vector3.New(-1, -0.35, -4)
				var_142_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_8.position).x, (manager.ui.mainCamera.transform.position - var_142_8.position).y, (manager.ui.mainCamera.transform.position - var_142_8.position).z)
				var_142_8.localEulerAngles.z = 0
				var_142_8.localEulerAngles.x = 0
				var_142_8.localEulerAngles = var_142_8.localEulerAngles
			end

			local var_142_10 = arg_139_1.actors_["10076ui_story"]

			if 1.8 < arg_139_1.time_ and arg_139_1.time_ <= 1.8 + arg_142_0 and not isNil(var_142_10) and arg_139_1.var_.characterEffect10076ui_story == nil then
				arg_139_1.var_.characterEffect10076ui_story = var_142_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_11 = 0.200000002980232

			if 1.8 <= arg_139_1.time_ and arg_139_1.time_ < 1.8 + var_142_11 and not isNil(var_142_10) then
				if arg_139_1.var_.characterEffect10076ui_story and not isNil(var_142_10) then
					arg_139_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 1.8 + var_142_11 and arg_139_1.time_ < 1.8 + var_142_11 + arg_142_0 and not isNil(var_142_10) and arg_139_1.var_.characterEffect10076ui_story then
				arg_139_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			if 1.8 < arg_139_1.time_ and arg_139_1.time_ <= 1.8 + arg_142_0 then
				arg_139_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action3_1")
			end

			if 1.8 < arg_139_1.time_ and arg_139_1.time_ <= 1.8 + arg_142_0 then
				arg_139_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_142_13 = arg_139_1.actors_["1097ui_story"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1097ui_story = var_142_13.localPosition
			end

			local var_142_14 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_14 then
				var_142_13.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_139_1.time_ - 0) / var_142_14)
				var_142_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_13.position).x, (manager.ui.mainCamera.transform.position - var_142_13.position).y, (manager.ui.mainCamera.transform.position - var_142_13.position).z)
				var_142_13.localEulerAngles.z = 0
				var_142_13.localEulerAngles.x = 0
				var_142_13.localEulerAngles = var_142_13.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_14 and arg_139_1.time_ < 0 + var_142_14 + arg_142_0 then
				var_142_13.localPosition = Vector3.New(0, 100, 0)
				var_142_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_13.position).x, (manager.ui.mainCamera.transform.position - var_142_13.position).y, (manager.ui.mainCamera.transform.position - var_142_13.position).z)
				var_142_13.localEulerAngles.z = 0
				var_142_13.localEulerAngles.x = 0
				var_142_13.localEulerAngles = var_142_13.localEulerAngles
			end

			if arg_139_1.frameCnt_ <= 1 then
				arg_139_1.dialog_:SetActive(false)
			end

			local var_142_15 = 1.999999999999
			local var_142_16 = 0.25

			if 1.999999999999 < arg_139_1.time_ and arg_139_1.time_ <= var_142_15 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0

				arg_139_1.dialog_:SetActive(true)

				arg_139_1.dialogCg_.alpha = 0

				local var_142_17 = LeanTween.value(arg_139_1.dialog_, 0, 1, 0.3)

				var_142_17:setOnUpdate(LuaHelper.FloatAction(function(arg_143_0)
					arg_139_1.dialogCg_.alpha = arg_143_0
				end))
				var_142_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_139_1.dialog_)
					var_142_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_139_1.duration_ = arg_139_1.duration_ + 0.3

				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_18 = arg_139_1:GetWordFromCfg(412021033)
				local var_142_19 = arg_139_1:FormatText(var_142_18.content)

				arg_139_1.text_.text = var_142_19

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_21 = 10 <= 0 and var_142_16 or var_142_16 * (utf8.len(var_142_19) / 10)

				if (10 <= 0 and var_142_16 or var_142_16 * (utf8.len(var_142_19) / 10)) > 0 and var_142_16 < var_142_21 then
					arg_139_1.talkMaxDuration = var_142_21
					var_142_15 = var_142_15 + 0.3

					if var_142_21 + var_142_15 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_21 + var_142_15
					end
				end

				arg_139_1.text_.text = var_142_19
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021033", "story_v_out_412021.awb") ~= 0 then
					local var_142_22 = manager.audio:GetVoiceLength("story_v_out_412021", "412021033", "story_v_out_412021.awb") / 1000

					if var_142_22 + var_142_15 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_22 + var_142_15
					end

					if var_142_18.prefab_name ~= "" and arg_139_1.actors_[var_142_18.prefab_name] ~= nil then
						local var_142_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_18.prefab_name].transform, "story_v_out_412021", "412021033", "story_v_out_412021.awb")

						arg_139_1:RecordAudio("412021033", var_142_23)
						arg_139_1:RecordAudio("412021033", var_142_23)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_412021", "412021033", "story_v_out_412021.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_412021", "412021033", "story_v_out_412021.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_24 = var_142_15 + 0.3
			local var_142_25 = math.max(var_142_16, arg_139_1.talkMaxDuration)

			if var_142_15 + 0.3 <= arg_139_1.time_ and arg_139_1.time_ < var_142_24 + var_142_25 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_24) / var_142_25

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_24 + var_142_25 and arg_139_1.time_ < var_142_24 + var_142_25 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play412021034 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 412021034
		arg_145_1.duration_ = 5.29

		local var_145_0 = {
			zh = 4.558,
			ja = 5.291
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
				arg_145_0:Play412021035(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1097ui_story = arg_145_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1097ui_story, Vector3.New(0.7, -0.54, -6.3), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1097ui_story"].transform.position).z)
				arg_145_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1097ui_story"].transform.localEulerAngles = arg_145_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0.7, -0.54, -6.3)
				arg_145_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1097ui_story"].transform.position).z)
				arg_145_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1097ui_story"].transform.localEulerAngles = arg_145_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_148_1 = arg_145_1.actors_["1097ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect1097ui_story == nil then
				arg_145_1.var_.characterEffect1097ui_story = var_148_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_2 and not isNil(var_148_1) then
				if arg_145_1.var_.characterEffect1097ui_story and not isNil(var_148_1) then
					arg_145_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_2 and arg_145_1.time_ < 0 + var_148_2 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect1097ui_story then
				arg_145_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action2_1")
			end

			if 2 < arg_145_1.time_ and arg_145_1.time_ <= 2 + arg_148_0 then
				arg_145_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action2_2")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1301cva")
			end

			if 2 < arg_145_1.time_ and arg_145_1.time_ <= 2 + arg_148_0 then
				arg_145_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_148_4 = arg_145_1.actors_["10076ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_4) and arg_145_1.var_.characterEffect10076ui_story == nil then
				arg_145_1.var_.characterEffect10076ui_story = var_148_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_5 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_5 and not isNil(var_148_4) then
				if arg_145_1.var_.characterEffect10076ui_story and not isNil(var_148_4) then
					arg_145_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_145_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_5)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_5 and arg_145_1.time_ < 0 + var_148_5 + arg_148_0 and not isNil(var_148_4) and arg_145_1.var_.characterEffect10076ui_story then
				arg_145_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_145_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_148_6 = 0

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_6 + arg_148_0 then
				arg_145_1.allBtn_.enabled = false
			end

			if arg_145_1.time_ >= var_148_6 + 1.825 and arg_145_1.time_ < var_148_6 + 1.825 + arg_148_0 then
				arg_145_1.allBtn_.enabled = true
			end

			if arg_145_1.frameCnt_ <= 1 then
				arg_145_1.dialog_:SetActive(false)
			end

			local var_148_7 = 1.825
			local var_148_8 = 0.175

			if 1.825 < arg_145_1.time_ and arg_145_1.time_ <= var_148_7 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0

				arg_145_1.dialog_:SetActive(true)

				arg_145_1.dialogCg_.alpha = 0

				local var_148_9 = LeanTween.value(arg_145_1.dialog_, 0, 1, 0.3)

				var_148_9:setOnUpdate(LuaHelper.FloatAction(function(arg_149_0)
					arg_145_1.dialogCg_.alpha = arg_149_0
				end))
				var_148_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_145_1.dialog_)
					var_148_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_145_1.duration_ = arg_145_1.duration_ + 0.3

				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_10 = arg_145_1:GetWordFromCfg(412021034)
				local var_148_11 = arg_145_1:FormatText(var_148_10.content)

				arg_145_1.text_.text = var_148_11

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_13 = 7 <= 0 and var_148_8 or var_148_8 * (utf8.len(var_148_11) / 7)

				if (7 <= 0 and var_148_8 or var_148_8 * (utf8.len(var_148_11) / 7)) > 0 and var_148_8 < var_148_13 then
					arg_145_1.talkMaxDuration = var_148_13
					var_148_7 = var_148_7 + 0.3

					if var_148_13 + var_148_7 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_13 + var_148_7
					end
				end

				arg_145_1.text_.text = var_148_11
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021034", "story_v_out_412021.awb") ~= 0 then
					local var_148_14 = manager.audio:GetVoiceLength("story_v_out_412021", "412021034", "story_v_out_412021.awb") / 1000

					if var_148_14 + var_148_7 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_14 + var_148_7
					end

					if var_148_10.prefab_name ~= "" and arg_145_1.actors_[var_148_10.prefab_name] ~= nil then
						local var_148_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_10.prefab_name].transform, "story_v_out_412021", "412021034", "story_v_out_412021.awb")

						arg_145_1:RecordAudio("412021034", var_148_15)
						arg_145_1:RecordAudio("412021034", var_148_15)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_412021", "412021034", "story_v_out_412021.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_412021", "412021034", "story_v_out_412021.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_16 = var_148_7 + 0.3
			local var_148_17 = math.max(var_148_8, arg_145_1.talkMaxDuration)

			if var_148_7 + 0.3 <= arg_145_1.time_ and arg_145_1.time_ < var_148_16 + var_148_17 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_16) / var_148_17

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_16 + var_148_17 and arg_145_1.time_ < var_148_16 + var_148_17 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play412021035 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 412021035
		arg_151_1.duration_ = 11.77

		local var_151_0 = {
			zh = 10.866,
			ja = 11.766
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play412021036(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos10083ui_story = arg_151_1.actors_["10083ui_story"].transform.localPosition
			end

			local var_154_0 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 then
				arg_151_1.actors_["10083ui_story"].transform.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10083ui_story, Vector3.New(0, -2.6, -2.8), (arg_151_1.time_ - 0) / var_154_0)
				arg_151_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["10083ui_story"].transform.position).z)
				arg_151_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["10083ui_story"].transform.localEulerAngles = arg_151_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 then
				arg_151_1.actors_["10083ui_story"].transform.localPosition = Vector3.New(0, -2.6, -2.8)
				arg_151_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["10083ui_story"].transform.position).z)
				arg_151_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["10083ui_story"].transform.localEulerAngles = arg_151_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			local var_154_1 = arg_151_1.actors_["10083ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect10083ui_story == nil then
				arg_151_1.var_.characterEffect10083ui_story = var_154_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_2 and not isNil(var_154_1) then
				if arg_151_1.var_.characterEffect10083ui_story and not isNil(var_154_1) then
					arg_151_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_2 and arg_151_1.time_ < 0 + var_154_2 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect10083ui_story then
				arg_151_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action1_1")
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_154_4 = arg_151_1.actors_["10076ui_story"].transform

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos10076ui_story = var_154_4.localPosition
			end

			local var_154_5 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_5 then
				var_154_4.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10076ui_story, Vector3.New(0, 100, 0), (arg_151_1.time_ - 0) / var_154_5)
				var_154_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_4.position).x, (manager.ui.mainCamera.transform.position - var_154_4.position).y, (manager.ui.mainCamera.transform.position - var_154_4.position).z)
				var_154_4.localEulerAngles.z = 0
				var_154_4.localEulerAngles.x = 0
				var_154_4.localEulerAngles = var_154_4.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_5 and arg_151_1.time_ < 0 + var_154_5 + arg_154_0 then
				var_154_4.localPosition = Vector3.New(0, 100, 0)
				var_154_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_4.position).x, (manager.ui.mainCamera.transform.position - var_154_4.position).y, (manager.ui.mainCamera.transform.position - var_154_4.position).z)
				var_154_4.localEulerAngles.z = 0
				var_154_4.localEulerAngles.x = 0
				var_154_4.localEulerAngles = var_154_4.localEulerAngles
			end

			local var_154_6 = arg_151_1.actors_["10076ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_6) and arg_151_1.var_.characterEffect10076ui_story == nil then
				arg_151_1.var_.characterEffect10076ui_story = var_154_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_7 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_7 and not isNil(var_154_6) then
				if arg_151_1.var_.characterEffect10076ui_story and not isNil(var_154_6) then
					arg_151_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_151_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_7)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_7 and arg_151_1.time_ < 0 + var_154_7 + arg_154_0 and not isNil(var_154_6) and arg_151_1.var_.characterEffect10076ui_story then
				arg_151_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_151_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_154_8 = arg_151_1.actors_["1097ui_story"].transform

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos1097ui_story = var_154_8.localPosition
			end

			local var_154_9 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_9 then
				var_154_8.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_151_1.time_ - 0) / var_154_9)
				var_154_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_8.position).x, (manager.ui.mainCamera.transform.position - var_154_8.position).y, (manager.ui.mainCamera.transform.position - var_154_8.position).z)
				var_154_8.localEulerAngles.z = 0
				var_154_8.localEulerAngles.x = 0
				var_154_8.localEulerAngles = var_154_8.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_9 and arg_151_1.time_ < 0 + var_154_9 + arg_154_0 then
				var_154_8.localPosition = Vector3.New(0, 100, 0)
				var_154_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_8.position).x, (manager.ui.mainCamera.transform.position - var_154_8.position).y, (manager.ui.mainCamera.transform.position - var_154_8.position).z)
				var_154_8.localEulerAngles.z = 0
				var_154_8.localEulerAngles.x = 0
				var_154_8.localEulerAngles = var_154_8.localEulerAngles
			end

			local var_154_10 = arg_151_1.actors_["1097ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_10) and arg_151_1.var_.characterEffect1097ui_story == nil then
				arg_151_1.var_.characterEffect1097ui_story = var_154_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_11 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_11 and not isNil(var_154_10) then
				if arg_151_1.var_.characterEffect1097ui_story and not isNil(var_154_10) then
					arg_151_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_11)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_11 and arg_151_1.time_ < 0 + var_154_11 + arg_154_0 and not isNil(var_154_10) and arg_151_1.var_.characterEffect1097ui_story then
				arg_151_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_154_12 = arg_151_1.actors_["1097ui_story"].transform

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos1097ui_story = var_154_12.localPosition
			end

			local var_154_13 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_13 then
				var_154_12.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_151_1.time_ - 0) / var_154_13)
				var_154_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_12.position).x, (manager.ui.mainCamera.transform.position - var_154_12.position).y, (manager.ui.mainCamera.transform.position - var_154_12.position).z)
				var_154_12.localEulerAngles.z = 0
				var_154_12.localEulerAngles.x = 0
				var_154_12.localEulerAngles = var_154_12.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_13 and arg_151_1.time_ < 0 + var_154_13 + arg_154_0 then
				var_154_12.localPosition = Vector3.New(0, 100, 0)
				var_154_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_12.position).x, (manager.ui.mainCamera.transform.position - var_154_12.position).y, (manager.ui.mainCamera.transform.position - var_154_12.position).z)
				var_154_12.localEulerAngles.z = 0
				var_154_12.localEulerAngles.x = 0
				var_154_12.localEulerAngles = var_154_12.localEulerAngles
			end

			local var_154_14 = 0
			local var_154_15 = 1.3

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_14 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_16 = arg_151_1:GetWordFromCfg(412021035)
				local var_154_17 = arg_151_1:FormatText(var_154_16.content)

				arg_151_1.text_.text = var_154_17

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_19 = 52 <= 0 and var_154_15 or var_154_15 * (utf8.len(var_154_17) / 52)

				if (52 <= 0 and var_154_15 or var_154_15 * (utf8.len(var_154_17) / 52)) > 0 and var_154_15 < var_154_19 then
					arg_151_1.talkMaxDuration = var_154_19

					if var_154_19 + var_154_14 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_19 + var_154_14
					end
				end

				arg_151_1.text_.text = var_154_17
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021035", "story_v_out_412021.awb") ~= 0 then
					local var_154_20 = manager.audio:GetVoiceLength("story_v_out_412021", "412021035", "story_v_out_412021.awb") / 1000

					if var_154_20 + var_154_14 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_20 + var_154_14
					end

					if var_154_16.prefab_name ~= "" and arg_151_1.actors_[var_154_16.prefab_name] ~= nil then
						local var_154_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_16.prefab_name].transform, "story_v_out_412021", "412021035", "story_v_out_412021.awb")

						arg_151_1:RecordAudio("412021035", var_154_21)
						arg_151_1:RecordAudio("412021035", var_154_21)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_412021", "412021035", "story_v_out_412021.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_412021", "412021035", "story_v_out_412021.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_22 = math.max(var_154_15, arg_151_1.talkMaxDuration)

			if var_154_14 <= arg_151_1.time_ and arg_151_1.time_ < var_154_14 + var_154_22 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_14) / var_154_22

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_14 + var_154_22 and arg_151_1.time_ < var_154_14 + var_154_22 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play412021036 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 412021036
		arg_155_1.duration_ = 4.67

		local var_155_0 = {
			zh = 3.333,
			ja = 4.666
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play412021037(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos1097ui_story = arg_155_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_158_0 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 then
				arg_155_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1097ui_story, Vector3.New(0.7, -0.54, -6.3), (arg_155_1.time_ - 0) / var_158_0)
				arg_155_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1097ui_story"].transform.position).z)
				arg_155_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["1097ui_story"].transform.localEulerAngles = arg_155_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 then
				arg_155_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0.7, -0.54, -6.3)
				arg_155_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1097ui_story"].transform.position).z)
				arg_155_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["1097ui_story"].transform.localEulerAngles = arg_155_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_158_1 = arg_155_1.actors_["1097ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect1097ui_story == nil then
				arg_155_1.var_.characterEffect1097ui_story = var_158_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_2 and not isNil(var_158_1) then
				if arg_155_1.var_.characterEffect1097ui_story and not isNil(var_158_1) then
					arg_155_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_2 and arg_155_1.time_ < 0 + var_158_2 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect1097ui_story then
				arg_155_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_158_4 = arg_155_1.actors_["10083ui_story"].transform

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos10083ui_story = var_158_4.localPosition
			end

			local var_158_5 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_5 then
				var_158_4.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10083ui_story, Vector3.New(0, 100, 0), (arg_155_1.time_ - 0) / var_158_5)
				var_158_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_4.position).x, (manager.ui.mainCamera.transform.position - var_158_4.position).y, (manager.ui.mainCamera.transform.position - var_158_4.position).z)
				var_158_4.localEulerAngles.z = 0
				var_158_4.localEulerAngles.x = 0
				var_158_4.localEulerAngles = var_158_4.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_5 and arg_155_1.time_ < 0 + var_158_5 + arg_158_0 then
				var_158_4.localPosition = Vector3.New(0, 100, 0)
				var_158_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_4.position).x, (manager.ui.mainCamera.transform.position - var_158_4.position).y, (manager.ui.mainCamera.transform.position - var_158_4.position).z)
				var_158_4.localEulerAngles.z = 0
				var_158_4.localEulerAngles.x = 0
				var_158_4.localEulerAngles = var_158_4.localEulerAngles
			end

			local var_158_6 = arg_155_1.actors_["10083ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_6) and arg_155_1.var_.characterEffect10083ui_story == nil then
				arg_155_1.var_.characterEffect10083ui_story = var_158_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_7 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_7 and not isNil(var_158_6) then
				if arg_155_1.var_.characterEffect10083ui_story and not isNil(var_158_6) then
					arg_155_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_155_1.var_.characterEffect10083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 0) / var_158_7)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_7 and arg_155_1.time_ < 0 + var_158_7 + arg_158_0 and not isNil(var_158_6) and arg_155_1.var_.characterEffect10083ui_story then
				arg_155_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_155_1.var_.characterEffect10083ui_story.fillRatio = 0.5
			end

			local var_158_8 = 0
			local var_158_9 = 0.225

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_8 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_10 = arg_155_1:GetWordFromCfg(412021036)
				local var_158_11 = arg_155_1:FormatText(var_158_10.content)

				arg_155_1.text_.text = var_158_11

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_13 = 9 <= 0 and var_158_9 or var_158_9 * (utf8.len(var_158_11) / 9)

				if (9 <= 0 and var_158_9 or var_158_9 * (utf8.len(var_158_11) / 9)) > 0 and var_158_9 < var_158_13 then
					arg_155_1.talkMaxDuration = var_158_13

					if var_158_13 + var_158_8 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_13 + var_158_8
					end
				end

				arg_155_1.text_.text = var_158_11
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021036", "story_v_out_412021.awb") ~= 0 then
					local var_158_14 = manager.audio:GetVoiceLength("story_v_out_412021", "412021036", "story_v_out_412021.awb") / 1000

					if var_158_14 + var_158_8 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_14 + var_158_8
					end

					if var_158_10.prefab_name ~= "" and arg_155_1.actors_[var_158_10.prefab_name] ~= nil then
						local var_158_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_10.prefab_name].transform, "story_v_out_412021", "412021036", "story_v_out_412021.awb")

						arg_155_1:RecordAudio("412021036", var_158_15)
						arg_155_1:RecordAudio("412021036", var_158_15)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_412021", "412021036", "story_v_out_412021.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_412021", "412021036", "story_v_out_412021.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_16 = math.max(var_158_9, arg_155_1.talkMaxDuration)

			if var_158_8 <= arg_155_1.time_ and arg_155_1.time_ < var_158_8 + var_158_16 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_8) / var_158_16

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_8 + var_158_16 and arg_155_1.time_ < var_158_8 + var_158_16 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play412021037 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 412021037
		arg_159_1.duration_ = 5.37

		local var_159_0 = {
			zh = 4.133,
			ja = 5.366
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play412021038(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos10076ui_story = arg_159_1.actors_["10076ui_story"].transform.localPosition
			end

			local var_162_0 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 then
				arg_159_1.actors_["10076ui_story"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10076ui_story, Vector3.New(-1, -0.35, -4), (arg_159_1.time_ - 0) / var_162_0)
				arg_159_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["10076ui_story"].transform.position).z)
				arg_159_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["10076ui_story"].transform.localEulerAngles = arg_159_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 then
				arg_159_1.actors_["10076ui_story"].transform.localPosition = Vector3.New(-1, -0.35, -4)
				arg_159_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["10076ui_story"].transform.position).z)
				arg_159_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["10076ui_story"].transform.localEulerAngles = arg_159_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			local var_162_1 = arg_159_1.actors_["10076ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect10076ui_story == nil then
				arg_159_1.var_.characterEffect10076ui_story = var_162_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_2 and not isNil(var_162_1) then
				if arg_159_1.var_.characterEffect10076ui_story and not isNil(var_162_1) then
					arg_159_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_2 and arg_159_1.time_ < 0 + var_162_2 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect10076ui_story then
				arg_159_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action3_1")
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_162_4 = arg_159_1.actors_["1097ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_4) and arg_159_1.var_.characterEffect1097ui_story == nil then
				arg_159_1.var_.characterEffect1097ui_story = var_162_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_5 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_5 and not isNil(var_162_4) then
				if arg_159_1.var_.characterEffect1097ui_story and not isNil(var_162_4) then
					arg_159_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_159_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_5)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_5 and arg_159_1.time_ < 0 + var_162_5 + arg_162_0 and not isNil(var_162_4) and arg_159_1.var_.characterEffect1097ui_story then
				arg_159_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_159_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_162_6 = 0
			local var_162_7 = 0.525

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_6 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_8 = arg_159_1:GetWordFromCfg(412021037)
				local var_162_9 = arg_159_1:FormatText(var_162_8.content)

				arg_159_1.text_.text = var_162_9

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_11 = 21 <= 0 and var_162_7 or var_162_7 * (utf8.len(var_162_9) / 21)

				if (21 <= 0 and var_162_7 or var_162_7 * (utf8.len(var_162_9) / 21)) > 0 and var_162_7 < var_162_11 then
					arg_159_1.talkMaxDuration = var_162_11

					if var_162_11 + var_162_6 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_11 + var_162_6
					end
				end

				arg_159_1.text_.text = var_162_9
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021037", "story_v_out_412021.awb") ~= 0 then
					local var_162_12 = manager.audio:GetVoiceLength("story_v_out_412021", "412021037", "story_v_out_412021.awb") / 1000

					if var_162_12 + var_162_6 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_12 + var_162_6
					end

					if var_162_8.prefab_name ~= "" and arg_159_1.actors_[var_162_8.prefab_name] ~= nil then
						local var_162_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_8.prefab_name].transform, "story_v_out_412021", "412021037", "story_v_out_412021.awb")

						arg_159_1:RecordAudio("412021037", var_162_13)
						arg_159_1:RecordAudio("412021037", var_162_13)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_412021", "412021037", "story_v_out_412021.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_412021", "412021037", "story_v_out_412021.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_14 = math.max(var_162_7, arg_159_1.talkMaxDuration)

			if var_162_6 <= arg_159_1.time_ and arg_159_1.time_ < var_162_6 + var_162_14 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_6) / var_162_14

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_6 + var_162_14 and arg_159_1.time_ < var_162_6 + var_162_14 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play412021038 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 412021038
		arg_163_1.duration_ = 7.67

		local var_163_0 = {
			zh = 5.933,
			ja = 7.666
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play412021039(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0.8

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_1 = arg_163_1:GetWordFromCfg(412021038)
				local var_166_2 = arg_163_1:FormatText(var_166_1.content)

				arg_163_1.text_.text = var_166_2

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_4 = 32 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_2) / 32)

				if (32 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_2) / 32)) > 0 and var_166_0 < var_166_4 then
					arg_163_1.talkMaxDuration = var_166_4

					if var_166_4 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_4 + 0
					end
				end

				arg_163_1.text_.text = var_166_2
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021038", "story_v_out_412021.awb") ~= 0 then
					local var_166_5 = manager.audio:GetVoiceLength("story_v_out_412021", "412021038", "story_v_out_412021.awb") / 1000

					if var_166_5 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_5 + 0
					end

					if var_166_1.prefab_name ~= "" and arg_163_1.actors_[var_166_1.prefab_name] ~= nil then
						local var_166_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_1.prefab_name].transform, "story_v_out_412021", "412021038", "story_v_out_412021.awb")

						arg_163_1:RecordAudio("412021038", var_166_6)
						arg_163_1:RecordAudio("412021038", var_166_6)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_412021", "412021038", "story_v_out_412021.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_412021", "412021038", "story_v_out_412021.awb")
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
	Play412021039 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 412021039
		arg_167_1.duration_ = 8.93

		local var_167_0 = {
			zh = 3.466,
			ja = 8.933
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play412021040(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0.425

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_1 = arg_167_1:GetWordFromCfg(412021039)
				local var_170_2 = arg_167_1:FormatText(var_170_1.content)

				arg_167_1.text_.text = var_170_2

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_4 = 17 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 17)

				if (17 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 17)) > 0 and var_170_0 < var_170_4 then
					arg_167_1.talkMaxDuration = var_170_4

					if var_170_4 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_4 + 0
					end
				end

				arg_167_1.text_.text = var_170_2
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021039", "story_v_out_412021.awb") ~= 0 then
					local var_170_5 = manager.audio:GetVoiceLength("story_v_out_412021", "412021039", "story_v_out_412021.awb") / 1000

					if var_170_5 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + 0
					end

					if var_170_1.prefab_name ~= "" and arg_167_1.actors_[var_170_1.prefab_name] ~= nil then
						local var_170_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_1.prefab_name].transform, "story_v_out_412021", "412021039", "story_v_out_412021.awb")

						arg_167_1:RecordAudio("412021039", var_170_6)
						arg_167_1:RecordAudio("412021039", var_170_6)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_412021", "412021039", "story_v_out_412021.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_412021", "412021039", "story_v_out_412021.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_7 = math.max(var_170_0, arg_167_1.talkMaxDuration)

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_7 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - 0) / var_170_7

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= 0 + var_170_7 and arg_167_1.time_ < 0 + var_170_7 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play412021040 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 412021040
		arg_171_1.duration_ = 6.37

		local var_171_0 = {
			zh = 6.366,
			ja = 5
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play412021041(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1097ui_story = arg_171_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_174_0 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 then
				arg_171_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1097ui_story, Vector3.New(0.7, -0.54, -6.3), (arg_171_1.time_ - 0) / var_174_0)
				arg_171_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1097ui_story"].transform.position).z)
				arg_171_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1097ui_story"].transform.localEulerAngles = arg_171_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 then
				arg_171_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0.7, -0.54, -6.3)
				arg_171_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1097ui_story"].transform.position).z)
				arg_171_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1097ui_story"].transform.localEulerAngles = arg_171_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_174_1 = arg_171_1.actors_["1097ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect1097ui_story == nil then
				arg_171_1.var_.characterEffect1097ui_story = var_174_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_2 and not isNil(var_174_1) then
				if arg_171_1.var_.characterEffect1097ui_story and not isNil(var_174_1) then
					arg_171_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_2 and arg_171_1.time_ < 0 + var_174_2 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect1097ui_story then
				arg_171_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_174_4 = arg_171_1.actors_["10076ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_4) and arg_171_1.var_.characterEffect10076ui_story == nil then
				arg_171_1.var_.characterEffect10076ui_story = var_174_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_5 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_5 and not isNil(var_174_4) then
				if arg_171_1.var_.characterEffect10076ui_story and not isNil(var_174_4) then
					arg_171_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_171_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_5)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_5 and arg_171_1.time_ < 0 + var_174_5 + arg_174_0 and not isNil(var_174_4) and arg_171_1.var_.characterEffect10076ui_story then
				arg_171_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_171_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_174_6 = 0
			local var_174_7 = 0.45

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_6 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_8 = arg_171_1:GetWordFromCfg(412021040)
				local var_174_9 = arg_171_1:FormatText(var_174_8.content)

				arg_171_1.text_.text = var_174_9

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_11 = 18 <= 0 and var_174_7 or var_174_7 * (utf8.len(var_174_9) / 18)

				if (18 <= 0 and var_174_7 or var_174_7 * (utf8.len(var_174_9) / 18)) > 0 and var_174_7 < var_174_11 then
					arg_171_1.talkMaxDuration = var_174_11

					if var_174_11 + var_174_6 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_11 + var_174_6
					end
				end

				arg_171_1.text_.text = var_174_9
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021040", "story_v_out_412021.awb") ~= 0 then
					local var_174_12 = manager.audio:GetVoiceLength("story_v_out_412021", "412021040", "story_v_out_412021.awb") / 1000

					if var_174_12 + var_174_6 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_12 + var_174_6
					end

					if var_174_8.prefab_name ~= "" and arg_171_1.actors_[var_174_8.prefab_name] ~= nil then
						local var_174_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_8.prefab_name].transform, "story_v_out_412021", "412021040", "story_v_out_412021.awb")

						arg_171_1:RecordAudio("412021040", var_174_13)
						arg_171_1:RecordAudio("412021040", var_174_13)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_412021", "412021040", "story_v_out_412021.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_412021", "412021040", "story_v_out_412021.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_14 = math.max(var_174_7, arg_171_1.talkMaxDuration)

			if var_174_6 <= arg_171_1.time_ and arg_171_1.time_ < var_174_6 + var_174_14 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_6) / var_174_14

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_6 + var_174_14 and arg_171_1.time_ < var_174_6 + var_174_14 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play412021041 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 412021041
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play412021042(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos1097ui_story = arg_175_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_178_0 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 then
				arg_175_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_175_1.time_ - 0) / var_178_0)
				arg_175_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1097ui_story"].transform.position).z)
				arg_175_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1097ui_story"].transform.localEulerAngles = arg_175_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 then
				arg_175_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_175_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1097ui_story"].transform.position).z)
				arg_175_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1097ui_story"].transform.localEulerAngles = arg_175_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_178_1 = arg_175_1.actors_["1097ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect1097ui_story == nil then
				arg_175_1.var_.characterEffect1097ui_story = var_178_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_2 and not isNil(var_178_1) then
				if arg_175_1.var_.characterEffect1097ui_story and not isNil(var_178_1) then
					arg_175_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_175_1.time_ - 0) / var_178_2)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_2 and arg_175_1.time_ < 0 + var_178_2 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect1097ui_story then
				arg_175_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_178_3 = arg_175_1.actors_["10076ui_story"].transform

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos10076ui_story = var_178_3.localPosition
			end

			local var_178_4 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_4 then
				var_178_3.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10076ui_story, Vector3.New(0, 100, 0), (arg_175_1.time_ - 0) / var_178_4)
				var_178_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_178_3.position).x, (manager.ui.mainCamera.transform.position - var_178_3.position).y, (manager.ui.mainCamera.transform.position - var_178_3.position).z)
				var_178_3.localEulerAngles.z = 0
				var_178_3.localEulerAngles.x = 0
				var_178_3.localEulerAngles = var_178_3.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_4 and arg_175_1.time_ < 0 + var_178_4 + arg_178_0 then
				var_178_3.localPosition = Vector3.New(0, 100, 0)
				var_178_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_178_3.position).x, (manager.ui.mainCamera.transform.position - var_178_3.position).y, (manager.ui.mainCamera.transform.position - var_178_3.position).z)
				var_178_3.localEulerAngles.z = 0
				var_178_3.localEulerAngles.x = 0
				var_178_3.localEulerAngles = var_178_3.localEulerAngles
			end

			local var_178_5 = 0
			local var_178_6 = 0.875

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_5 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_7 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(412021041).content)

				arg_175_1.text_.text = var_178_7

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_9 = 35 <= 0 and var_178_6 or var_178_6 * (utf8.len(var_178_7) / 35)

				if (35 <= 0 and var_178_6 or var_178_6 * (utf8.len(var_178_7) / 35)) > 0 and var_178_6 < var_178_9 then
					arg_175_1.talkMaxDuration = var_178_9

					if var_178_9 + var_178_5 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_9 + var_178_5
					end
				end

				arg_175_1.text_.text = var_178_7
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_10 = math.max(var_178_6, arg_175_1.talkMaxDuration)

			if var_178_5 <= arg_175_1.time_ and arg_175_1.time_ < var_178_5 + var_178_10 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_5) / var_178_10

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_5 + var_178_10 and arg_175_1.time_ < var_178_5 + var_178_10 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play412021042 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 412021042
		arg_179_1.duration_ = 5.2

		local var_179_0 = {
			zh = 5.2,
			ja = 1.999999999999
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play412021043(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos1097ui_story = arg_179_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_182_0 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 then
				arg_179_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_179_1.time_ - 0) / var_182_0)
				arg_179_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1097ui_story"].transform.position).z)
				arg_179_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1097ui_story"].transform.localEulerAngles = arg_179_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 then
				arg_179_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_179_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1097ui_story"].transform.position).z)
				arg_179_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1097ui_story"].transform.localEulerAngles = arg_179_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_182_1 = arg_179_1.actors_["1097ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect1097ui_story == nil then
				arg_179_1.var_.characterEffect1097ui_story = var_182_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_2 and not isNil(var_182_1) then
				if arg_179_1.var_.characterEffect1097ui_story and not isNil(var_182_1) then
					arg_179_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_2 and arg_179_1.time_ < 0 + var_182_2 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect1097ui_story then
				arg_179_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_182_4 = 0
			local var_182_5 = 0.2

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_4 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_6 = arg_179_1:GetWordFromCfg(412021042)
				local var_182_7 = arg_179_1:FormatText(var_182_6.content)

				arg_179_1.text_.text = var_182_7

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_9 = 8 <= 0 and var_182_5 or var_182_5 * (utf8.len(var_182_7) / 8)

				if (8 <= 0 and var_182_5 or var_182_5 * (utf8.len(var_182_7) / 8)) > 0 and var_182_5 < var_182_9 then
					arg_179_1.talkMaxDuration = var_182_9

					if var_182_9 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_9 + var_182_4
					end
				end

				arg_179_1.text_.text = var_182_7
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021042", "story_v_out_412021.awb") ~= 0 then
					local var_182_10 = manager.audio:GetVoiceLength("story_v_out_412021", "412021042", "story_v_out_412021.awb") / 1000

					if var_182_10 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_10 + var_182_4
					end

					if var_182_6.prefab_name ~= "" and arg_179_1.actors_[var_182_6.prefab_name] ~= nil then
						local var_182_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_6.prefab_name].transform, "story_v_out_412021", "412021042", "story_v_out_412021.awb")

						arg_179_1:RecordAudio("412021042", var_182_11)
						arg_179_1:RecordAudio("412021042", var_182_11)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_412021", "412021042", "story_v_out_412021.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_412021", "412021042", "story_v_out_412021.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_12 = math.max(var_182_5, arg_179_1.talkMaxDuration)

			if var_182_4 <= arg_179_1.time_ and arg_179_1.time_ < var_182_4 + var_182_12 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_4) / var_182_12

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_4 + var_182_12 and arg_179_1.time_ < var_182_4 + var_182_12 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play412021043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 412021043
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play412021044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos1097ui_story = arg_183_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_186_0 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 then
				arg_183_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_183_1.time_ - 0) / var_186_0)
				arg_183_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1097ui_story"].transform.position).z)
				arg_183_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1097ui_story"].transform.localEulerAngles = arg_183_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 then
				arg_183_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_183_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1097ui_story"].transform.position).z)
				arg_183_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1097ui_story"].transform.localEulerAngles = arg_183_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_186_1 = arg_183_1.actors_["1097ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect1097ui_story == nil then
				arg_183_1.var_.characterEffect1097ui_story = var_186_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_2 and not isNil(var_186_1) then
				if arg_183_1.var_.characterEffect1097ui_story and not isNil(var_186_1) then
					arg_183_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_183_1.time_ - 0) / var_186_2)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_2 and arg_183_1.time_ < 0 + var_186_2 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect1097ui_story then
				arg_183_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_186_3 = 0
			local var_186_4 = 0.9

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_3 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_5 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(412021043).content)

				arg_183_1.text_.text = var_186_5

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_7 = 36 <= 0 and var_186_4 or var_186_4 * (utf8.len(var_186_5) / 36)

				if (36 <= 0 and var_186_4 or var_186_4 * (utf8.len(var_186_5) / 36)) > 0 and var_186_4 < var_186_7 then
					arg_183_1.talkMaxDuration = var_186_7

					if var_186_7 + var_186_3 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_7 + var_186_3
					end
				end

				arg_183_1.text_.text = var_186_5
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_8 = math.max(var_186_4, arg_183_1.talkMaxDuration)

			if var_186_3 <= arg_183_1.time_ and arg_183_1.time_ < var_186_3 + var_186_8 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_3) / var_186_8

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_3 + var_186_8 and arg_183_1.time_ < var_186_3 + var_186_8 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play412021044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 412021044
		arg_187_1.duration_ = 5

		local var_187_0 = {
			zh = 5,
			ja = 3.733
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play412021045(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos10083ui_story = arg_187_1.actors_["10083ui_story"].transform.localPosition
			end

			local var_190_0 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 then
				arg_187_1.actors_["10083ui_story"].transform.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos10083ui_story, Vector3.New(-1, -2.6, -2.8), (arg_187_1.time_ - 0) / var_190_0)
				arg_187_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["10083ui_story"].transform.position).z)
				arg_187_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["10083ui_story"].transform.localEulerAngles = arg_187_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 then
				arg_187_1.actors_["10083ui_story"].transform.localPosition = Vector3.New(-1, -2.6, -2.8)
				arg_187_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["10083ui_story"].transform.position).z)
				arg_187_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["10083ui_story"].transform.localEulerAngles = arg_187_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			local var_190_1 = arg_187_1.actors_["10083ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect10083ui_story == nil then
				arg_187_1.var_.characterEffect10083ui_story = var_190_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_2 and not isNil(var_190_1) then
				if arg_187_1.var_.characterEffect10083ui_story and not isNil(var_190_1) then
					arg_187_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= 0 + var_190_2 and arg_187_1.time_ < 0 + var_190_2 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect10083ui_story then
				arg_187_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action1_1")
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_190_4 = 0
			local var_190_5 = 0.65

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_4 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_6 = arg_187_1:GetWordFromCfg(412021044)
				local var_190_7 = arg_187_1:FormatText(var_190_6.content)

				arg_187_1.text_.text = var_190_7

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_9 = 26 <= 0 and var_190_5 or var_190_5 * (utf8.len(var_190_7) / 26)

				if (26 <= 0 and var_190_5 or var_190_5 * (utf8.len(var_190_7) / 26)) > 0 and var_190_5 < var_190_9 then
					arg_187_1.talkMaxDuration = var_190_9

					if var_190_9 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_9 + var_190_4
					end
				end

				arg_187_1.text_.text = var_190_7
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021044", "story_v_out_412021.awb") ~= 0 then
					local var_190_10 = manager.audio:GetVoiceLength("story_v_out_412021", "412021044", "story_v_out_412021.awb") / 1000

					if var_190_10 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_10 + var_190_4
					end

					if var_190_6.prefab_name ~= "" and arg_187_1.actors_[var_190_6.prefab_name] ~= nil then
						local var_190_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_6.prefab_name].transform, "story_v_out_412021", "412021044", "story_v_out_412021.awb")

						arg_187_1:RecordAudio("412021044", var_190_11)
						arg_187_1:RecordAudio("412021044", var_190_11)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_412021", "412021044", "story_v_out_412021.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_412021", "412021044", "story_v_out_412021.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_12 = math.max(var_190_5, arg_187_1.talkMaxDuration)

			if var_190_4 <= arg_187_1.time_ and arg_187_1.time_ < var_190_4 + var_190_12 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_4) / var_190_12

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_4 + var_190_12 and arg_187_1.time_ < var_190_4 + var_190_12 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play412021045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 412021045
		arg_191_1.duration_ = 3.83

		local var_191_0 = {
			zh = 2.966,
			ja = 3.833
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play412021046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos10076ui_story = arg_191_1.actors_["10076ui_story"].transform.localPosition
			end

			local var_194_0 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 then
				arg_191_1.actors_["10076ui_story"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10076ui_story, Vector3.New(1, -0.35, -4), (arg_191_1.time_ - 0) / var_194_0)
				arg_191_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["10076ui_story"].transform.position).z)
				arg_191_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["10076ui_story"].transform.localEulerAngles = arg_191_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 then
				arg_191_1.actors_["10076ui_story"].transform.localPosition = Vector3.New(1, -0.35, -4)
				arg_191_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["10076ui_story"].transform.position).z)
				arg_191_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["10076ui_story"].transform.localEulerAngles = arg_191_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			local var_194_1 = arg_191_1.actors_["10076ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect10076ui_story == nil then
				arg_191_1.var_.characterEffect10076ui_story = var_194_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_2 and not isNil(var_194_1) then
				if arg_191_1.var_.characterEffect10076ui_story and not isNil(var_194_1) then
					arg_191_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_2 and arg_191_1.time_ < 0 + var_194_2 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect10076ui_story then
				arg_191_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action1_1")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_194_4 = arg_191_1.actors_["10083ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_4) and arg_191_1.var_.characterEffect10083ui_story == nil then
				arg_191_1.var_.characterEffect10083ui_story = var_194_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_5 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_5 and not isNil(var_194_4) then
				if arg_191_1.var_.characterEffect10083ui_story and not isNil(var_194_4) then
					arg_191_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_191_1.var_.characterEffect10083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_191_1.time_ - 0) / var_194_5)
				end
			end

			if arg_191_1.time_ >= 0 + var_194_5 and arg_191_1.time_ < 0 + var_194_5 + arg_194_0 and not isNil(var_194_4) and arg_191_1.var_.characterEffect10083ui_story then
				arg_191_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_191_1.var_.characterEffect10083ui_story.fillRatio = 0.5
			end

			local var_194_6 = 0
			local var_194_7 = 0.35

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_6 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_8 = arg_191_1:GetWordFromCfg(412021045)
				local var_194_9 = arg_191_1:FormatText(var_194_8.content)

				arg_191_1.text_.text = var_194_9

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_11 = 14 <= 0 and var_194_7 or var_194_7 * (utf8.len(var_194_9) / 14)

				if (14 <= 0 and var_194_7 or var_194_7 * (utf8.len(var_194_9) / 14)) > 0 and var_194_7 < var_194_11 then
					arg_191_1.talkMaxDuration = var_194_11

					if var_194_11 + var_194_6 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_11 + var_194_6
					end
				end

				arg_191_1.text_.text = var_194_9
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021045", "story_v_out_412021.awb") ~= 0 then
					local var_194_12 = manager.audio:GetVoiceLength("story_v_out_412021", "412021045", "story_v_out_412021.awb") / 1000

					if var_194_12 + var_194_6 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_12 + var_194_6
					end

					if var_194_8.prefab_name ~= "" and arg_191_1.actors_[var_194_8.prefab_name] ~= nil then
						local var_194_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_8.prefab_name].transform, "story_v_out_412021", "412021045", "story_v_out_412021.awb")

						arg_191_1:RecordAudio("412021045", var_194_13)
						arg_191_1:RecordAudio("412021045", var_194_13)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_412021", "412021045", "story_v_out_412021.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_412021", "412021045", "story_v_out_412021.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_14 = math.max(var_194_7, arg_191_1.talkMaxDuration)

			if var_194_6 <= arg_191_1.time_ and arg_191_1.time_ < var_194_6 + var_194_14 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_6) / var_194_14

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_6 + var_194_14 and arg_191_1.time_ < var_194_6 + var_194_14 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play412021046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 412021046
		arg_195_1.duration_ = 7.6

		local var_195_0 = {
			zh = 4.266,
			ja = 7.6
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play412021047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if arg_195_1.actors_["10078ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10078ui_story"))) then
				local var_198_0 = Object.Instantiate(Asset.Load("Char/" .. "10078ui_story"), arg_195_1.stage_.transform)

				var_198_0.name = "10078ui_story"
				var_198_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_195_1.actors_["10078ui_story"] = var_198_0

				local var_198_1 = var_198_0:GetComponentInChildren(typeof(CharacterEffect))

				var_198_1.enabled = true

				local var_198_2 = GameObjectTools.GetOrAddComponent(var_198_0, typeof(DynamicBoneHelper))

				if var_198_2 then
					var_198_2:EnableDynamicBone(false)
				end

				arg_195_1:ShowWeapon(var_198_1.transform, false)

				arg_195_1.var_["10078ui_story" .. "Animator"] = var_198_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_195_1.var_["10078ui_story" .. "Animator"].applyRootMotion = true
				arg_195_1.var_["10078ui_story" .. "LipSync"] = var_198_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_198_3 = arg_195_1.actors_["10078ui_story"].transform

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos10078ui_story = var_198_3.localPosition
			end

			local var_198_4 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_4 then
				var_198_3.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10078ui_story, Vector3.New(0, -0.5, -6.3), (arg_195_1.time_ - 0) / var_198_4)
				var_198_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_198_3.position).x, (manager.ui.mainCamera.transform.position - var_198_3.position).y, (manager.ui.mainCamera.transform.position - var_198_3.position).z)
				var_198_3.localEulerAngles.z = 0
				var_198_3.localEulerAngles.x = 0
				var_198_3.localEulerAngles = var_198_3.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_4 and arg_195_1.time_ < 0 + var_198_4 + arg_198_0 then
				var_198_3.localPosition = Vector3.New(0, -0.5, -6.3)
				var_198_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_198_3.position).x, (manager.ui.mainCamera.transform.position - var_198_3.position).y, (manager.ui.mainCamera.transform.position - var_198_3.position).z)
				var_198_3.localEulerAngles.z = 0
				var_198_3.localEulerAngles.x = 0
				var_198_3.localEulerAngles = var_198_3.localEulerAngles
			end

			local var_198_5 = arg_195_1.actors_["10078ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_5) and arg_195_1.var_.characterEffect10078ui_story == nil then
				arg_195_1.var_.characterEffect10078ui_story = var_198_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_6 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_6 and not isNil(var_198_5) then
				if arg_195_1.var_.characterEffect10078ui_story and not isNil(var_198_5) then
					arg_195_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 0 + var_198_6 and arg_195_1.time_ < 0 + var_198_6 + arg_198_0 and not isNil(var_198_5) and arg_195_1.var_.characterEffect10078ui_story then
				arg_195_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			local var_198_8 = arg_195_1.actors_["10083ui_story"].transform

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos10083ui_story = var_198_8.localPosition
			end

			local var_198_9 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_9 then
				var_198_8.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10083ui_story, Vector3.New(0, 100, 0), (arg_195_1.time_ - 0) / var_198_9)
				var_198_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_198_8.position).x, (manager.ui.mainCamera.transform.position - var_198_8.position).y, (manager.ui.mainCamera.transform.position - var_198_8.position).z)
				var_198_8.localEulerAngles.z = 0
				var_198_8.localEulerAngles.x = 0
				var_198_8.localEulerAngles = var_198_8.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_9 and arg_195_1.time_ < 0 + var_198_9 + arg_198_0 then
				var_198_8.localPosition = Vector3.New(0, 100, 0)
				var_198_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_198_8.position).x, (manager.ui.mainCamera.transform.position - var_198_8.position).y, (manager.ui.mainCamera.transform.position - var_198_8.position).z)
				var_198_8.localEulerAngles.z = 0
				var_198_8.localEulerAngles.x = 0
				var_198_8.localEulerAngles = var_198_8.localEulerAngles
			end

			local var_198_10 = arg_195_1.actors_["10083ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_10) and arg_195_1.var_.characterEffect10083ui_story == nil then
				arg_195_1.var_.characterEffect10083ui_story = var_198_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_11 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_11 and not isNil(var_198_10) then
				if arg_195_1.var_.characterEffect10083ui_story and not isNil(var_198_10) then
					arg_195_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_195_1.var_.characterEffect10083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_11)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_11 and arg_195_1.time_ < 0 + var_198_11 + arg_198_0 and not isNil(var_198_10) and arg_195_1.var_.characterEffect10083ui_story then
				arg_195_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_195_1.var_.characterEffect10083ui_story.fillRatio = 0.5
			end

			local var_198_12 = arg_195_1.actors_["10076ui_story"].transform

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos10076ui_story = var_198_12.localPosition
			end

			local var_198_13 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_13 then
				var_198_12.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10076ui_story, Vector3.New(0, 100, 0), (arg_195_1.time_ - 0) / var_198_13)
				var_198_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_198_12.position).x, (manager.ui.mainCamera.transform.position - var_198_12.position).y, (manager.ui.mainCamera.transform.position - var_198_12.position).z)
				var_198_12.localEulerAngles.z = 0
				var_198_12.localEulerAngles.x = 0
				var_198_12.localEulerAngles = var_198_12.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_13 and arg_195_1.time_ < 0 + var_198_13 + arg_198_0 then
				var_198_12.localPosition = Vector3.New(0, 100, 0)
				var_198_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_198_12.position).x, (manager.ui.mainCamera.transform.position - var_198_12.position).y, (manager.ui.mainCamera.transform.position - var_198_12.position).z)
				var_198_12.localEulerAngles.z = 0
				var_198_12.localEulerAngles.x = 0
				var_198_12.localEulerAngles = var_198_12.localEulerAngles
			end

			local var_198_14 = arg_195_1.actors_["10076ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_14) and arg_195_1.var_.characterEffect10076ui_story == nil then
				arg_195_1.var_.characterEffect10076ui_story = var_198_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_15 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_15 and not isNil(var_198_14) then
				if arg_195_1.var_.characterEffect10076ui_story and not isNil(var_198_14) then
					arg_195_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_195_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_15)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_15 and arg_195_1.time_ < 0 + var_198_15 + arg_198_0 and not isNil(var_198_14) and arg_195_1.var_.characterEffect10076ui_story then
				arg_195_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_195_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			local var_198_16 = 0
			local var_198_17 = 0.275

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_16 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_18 = arg_195_1:GetWordFromCfg(412021046)
				local var_198_19 = arg_195_1:FormatText(var_198_18.content)

				arg_195_1.text_.text = var_198_19

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_21 = 11 <= 0 and var_198_17 or var_198_17 * (utf8.len(var_198_19) / 11)

				if (11 <= 0 and var_198_17 or var_198_17 * (utf8.len(var_198_19) / 11)) > 0 and var_198_17 < var_198_21 then
					arg_195_1.talkMaxDuration = var_198_21

					if var_198_21 + var_198_16 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_21 + var_198_16
					end
				end

				arg_195_1.text_.text = var_198_19
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021046", "story_v_out_412021.awb") ~= 0 then
					local var_198_22 = manager.audio:GetVoiceLength("story_v_out_412021", "412021046", "story_v_out_412021.awb") / 1000

					if var_198_22 + var_198_16 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_22 + var_198_16
					end

					if var_198_18.prefab_name ~= "" and arg_195_1.actors_[var_198_18.prefab_name] ~= nil then
						local var_198_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_18.prefab_name].transform, "story_v_out_412021", "412021046", "story_v_out_412021.awb")

						arg_195_1:RecordAudio("412021046", var_198_23)
						arg_195_1:RecordAudio("412021046", var_198_23)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_412021", "412021046", "story_v_out_412021.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_412021", "412021046", "story_v_out_412021.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_24 = math.max(var_198_17, arg_195_1.talkMaxDuration)

			if var_198_16 <= arg_195_1.time_ and arg_195_1.time_ < var_198_16 + var_198_24 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_16) / var_198_24

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_16 + var_198_24 and arg_195_1.time_ < var_198_16 + var_198_24 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play412021047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 412021047
		arg_199_1.duration_ = 3.97

		local var_199_0 = {
			zh = 3.966,
			ja = 3.333
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play412021048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos1097ui_story = arg_199_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_202_0 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 then
				arg_199_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_199_1.time_ - 0) / var_202_0)
				arg_199_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1097ui_story"].transform.position).z)
				arg_199_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["1097ui_story"].transform.localEulerAngles = arg_199_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 then
				arg_199_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_199_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1097ui_story"].transform.position).z)
				arg_199_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["1097ui_story"].transform.localEulerAngles = arg_199_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_202_1 = arg_199_1.actors_["1097ui_story"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect1097ui_story == nil then
				arg_199_1.var_.characterEffect1097ui_story = var_202_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_2 and not isNil(var_202_1) then
				if arg_199_1.var_.characterEffect1097ui_story and not isNil(var_202_1) then
					arg_199_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= 0 + var_202_2 and arg_199_1.time_ < 0 + var_202_2 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect1097ui_story then
				arg_199_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_202_4 = arg_199_1.actors_["10078ui_story"].transform

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos10078ui_story = var_202_4.localPosition
			end

			local var_202_5 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_5 then
				var_202_4.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10078ui_story, Vector3.New(0, 100, 0), (arg_199_1.time_ - 0) / var_202_5)
				var_202_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_202_4.position).x, (manager.ui.mainCamera.transform.position - var_202_4.position).y, (manager.ui.mainCamera.transform.position - var_202_4.position).z)
				var_202_4.localEulerAngles.z = 0
				var_202_4.localEulerAngles.x = 0
				var_202_4.localEulerAngles = var_202_4.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_5 and arg_199_1.time_ < 0 + var_202_5 + arg_202_0 then
				var_202_4.localPosition = Vector3.New(0, 100, 0)
				var_202_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_202_4.position).x, (manager.ui.mainCamera.transform.position - var_202_4.position).y, (manager.ui.mainCamera.transform.position - var_202_4.position).z)
				var_202_4.localEulerAngles.z = 0
				var_202_4.localEulerAngles.x = 0
				var_202_4.localEulerAngles = var_202_4.localEulerAngles
			end

			local var_202_6 = arg_199_1.actors_["10078ui_story"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_6) and arg_199_1.var_.characterEffect10078ui_story == nil then
				arg_199_1.var_.characterEffect10078ui_story = var_202_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_7 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_7 and not isNil(var_202_6) then
				if arg_199_1.var_.characterEffect10078ui_story and not isNil(var_202_6) then
					arg_199_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_199_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_199_1.time_ - 0) / var_202_7)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_7 and arg_199_1.time_ < 0 + var_202_7 + arg_202_0 and not isNil(var_202_6) and arg_199_1.var_.characterEffect10078ui_story then
				arg_199_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_199_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_202_8 = 0
			local var_202_9 = 0.325

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_8 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_10 = arg_199_1:GetWordFromCfg(412021047)
				local var_202_11 = arg_199_1:FormatText(var_202_10.content)

				arg_199_1.text_.text = var_202_11

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_13 = 13 <= 0 and var_202_9 or var_202_9 * (utf8.len(var_202_11) / 13)

				if (13 <= 0 and var_202_9 or var_202_9 * (utf8.len(var_202_11) / 13)) > 0 and var_202_9 < var_202_13 then
					arg_199_1.talkMaxDuration = var_202_13

					if var_202_13 + var_202_8 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_13 + var_202_8
					end
				end

				arg_199_1.text_.text = var_202_11
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021047", "story_v_out_412021.awb") ~= 0 then
					local var_202_14 = manager.audio:GetVoiceLength("story_v_out_412021", "412021047", "story_v_out_412021.awb") / 1000

					if var_202_14 + var_202_8 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_14 + var_202_8
					end

					if var_202_10.prefab_name ~= "" and arg_199_1.actors_[var_202_10.prefab_name] ~= nil then
						local var_202_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_10.prefab_name].transform, "story_v_out_412021", "412021047", "story_v_out_412021.awb")

						arg_199_1:RecordAudio("412021047", var_202_15)
						arg_199_1:RecordAudio("412021047", var_202_15)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_412021", "412021047", "story_v_out_412021.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_412021", "412021047", "story_v_out_412021.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_16 = math.max(var_202_9, arg_199_1.talkMaxDuration)

			if var_202_8 <= arg_199_1.time_ and arg_199_1.time_ < var_202_8 + var_202_16 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_8) / var_202_16

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_8 + var_202_16 and arg_199_1.time_ < var_202_8 + var_202_16 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play412021048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 412021048
		arg_203_1.duration_ = 11.97

		local var_203_0 = {
			zh = 7.1,
			ja = 11.966
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play412021049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos10078ui_story = arg_203_1.actors_["10078ui_story"].transform.localPosition
			end

			local var_206_0 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 then
				arg_203_1.actors_["10078ui_story"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos10078ui_story, Vector3.New(0, -0.5, -6.3), (arg_203_1.time_ - 0) / var_206_0)
				arg_203_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["10078ui_story"].transform.position).z)
				arg_203_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["10078ui_story"].transform.localEulerAngles = arg_203_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 then
				arg_203_1.actors_["10078ui_story"].transform.localPosition = Vector3.New(0, -0.5, -6.3)
				arg_203_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["10078ui_story"].transform.position).z)
				arg_203_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["10078ui_story"].transform.localEulerAngles = arg_203_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			local var_206_1 = arg_203_1.actors_["10078ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect10078ui_story == nil then
				arg_203_1.var_.characterEffect10078ui_story = var_206_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_2 and not isNil(var_206_1) then
				if arg_203_1.var_.characterEffect10078ui_story and not isNil(var_206_1) then
					arg_203_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_2 and arg_203_1.time_ < 0 + var_206_2 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect10078ui_story then
				arg_203_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			local var_206_4 = arg_203_1.actors_["1097ui_story"].transform

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1097ui_story = var_206_4.localPosition
			end

			local var_206_5 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_5 then
				var_206_4.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_203_1.time_ - 0) / var_206_5)
				var_206_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_206_4.position).x, (manager.ui.mainCamera.transform.position - var_206_4.position).y, (manager.ui.mainCamera.transform.position - var_206_4.position).z)
				var_206_4.localEulerAngles.z = 0
				var_206_4.localEulerAngles.x = 0
				var_206_4.localEulerAngles = var_206_4.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_5 and arg_203_1.time_ < 0 + var_206_5 + arg_206_0 then
				var_206_4.localPosition = Vector3.New(0, 100, 0)
				var_206_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_206_4.position).x, (manager.ui.mainCamera.transform.position - var_206_4.position).y, (manager.ui.mainCamera.transform.position - var_206_4.position).z)
				var_206_4.localEulerAngles.z = 0
				var_206_4.localEulerAngles.x = 0
				var_206_4.localEulerAngles = var_206_4.localEulerAngles
			end

			local var_206_6 = arg_203_1.actors_["1097ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_6) and arg_203_1.var_.characterEffect1097ui_story == nil then
				arg_203_1.var_.characterEffect1097ui_story = var_206_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_7 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_7 and not isNil(var_206_6) then
				if arg_203_1.var_.characterEffect1097ui_story and not isNil(var_206_6) then
					arg_203_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_203_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_203_1.time_ - 0) / var_206_7)
				end
			end

			if arg_203_1.time_ >= 0 + var_206_7 and arg_203_1.time_ < 0 + var_206_7 + arg_206_0 and not isNil(var_206_6) and arg_203_1.var_.characterEffect1097ui_story then
				arg_203_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_203_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_2")
			end

			local var_206_8 = 0
			local var_206_9 = 0.5

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_8 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_10 = arg_203_1:GetWordFromCfg(412021048)
				local var_206_11 = arg_203_1:FormatText(var_206_10.content)

				arg_203_1.text_.text = var_206_11

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_13 = 20 <= 0 and var_206_9 or var_206_9 * (utf8.len(var_206_11) / 20)

				if (20 <= 0 and var_206_9 or var_206_9 * (utf8.len(var_206_11) / 20)) > 0 and var_206_9 < var_206_13 then
					arg_203_1.talkMaxDuration = var_206_13

					if var_206_13 + var_206_8 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_13 + var_206_8
					end
				end

				arg_203_1.text_.text = var_206_11
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021048", "story_v_out_412021.awb") ~= 0 then
					local var_206_14 = manager.audio:GetVoiceLength("story_v_out_412021", "412021048", "story_v_out_412021.awb") / 1000

					if var_206_14 + var_206_8 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_14 + var_206_8
					end

					if var_206_10.prefab_name ~= "" and arg_203_1.actors_[var_206_10.prefab_name] ~= nil then
						local var_206_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_10.prefab_name].transform, "story_v_out_412021", "412021048", "story_v_out_412021.awb")

						arg_203_1:RecordAudio("412021048", var_206_15)
						arg_203_1:RecordAudio("412021048", var_206_15)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_412021", "412021048", "story_v_out_412021.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_412021", "412021048", "story_v_out_412021.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_16 = math.max(var_206_9, arg_203_1.talkMaxDuration)

			if var_206_8 <= arg_203_1.time_ and arg_203_1.time_ < var_206_8 + var_206_16 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_8) / var_206_16

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_8 + var_206_16 and arg_203_1.time_ < var_206_8 + var_206_16 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play412021049 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 412021049
		arg_207_1.duration_ = 6.03

		local var_207_0 = {
			zh = 4.3,
			ja = 6.033
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play412021050(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos10076ui_story = arg_207_1.actors_["10076ui_story"].transform.localPosition
			end

			local var_210_0 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 then
				arg_207_1.actors_["10076ui_story"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos10076ui_story, Vector3.New(0, -0.35, -4), (arg_207_1.time_ - 0) / var_210_0)
				arg_207_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["10076ui_story"].transform.position).z)
				arg_207_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["10076ui_story"].transform.localEulerAngles = arg_207_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 then
				arg_207_1.actors_["10076ui_story"].transform.localPosition = Vector3.New(0, -0.35, -4)
				arg_207_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["10076ui_story"].transform.position).z)
				arg_207_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["10076ui_story"].transform.localEulerAngles = arg_207_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			local var_210_1 = arg_207_1.actors_["10076ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect10076ui_story == nil then
				arg_207_1.var_.characterEffect10076ui_story = var_210_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_2 and not isNil(var_210_1) then
				if arg_207_1.var_.characterEffect10076ui_story and not isNil(var_210_1) then
					arg_207_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= 0 + var_210_2 and arg_207_1.time_ < 0 + var_210_2 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect10076ui_story then
				arg_207_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action3_1")
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_210_4 = arg_207_1.actors_["10078ui_story"].transform

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos10078ui_story = var_210_4.localPosition
			end

			local var_210_5 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_5 then
				var_210_4.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos10078ui_story, Vector3.New(0, 100, 0), (arg_207_1.time_ - 0) / var_210_5)
				var_210_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_210_4.position).x, (manager.ui.mainCamera.transform.position - var_210_4.position).y, (manager.ui.mainCamera.transform.position - var_210_4.position).z)
				var_210_4.localEulerAngles.z = 0
				var_210_4.localEulerAngles.x = 0
				var_210_4.localEulerAngles = var_210_4.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_5 and arg_207_1.time_ < 0 + var_210_5 + arg_210_0 then
				var_210_4.localPosition = Vector3.New(0, 100, 0)
				var_210_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_210_4.position).x, (manager.ui.mainCamera.transform.position - var_210_4.position).y, (manager.ui.mainCamera.transform.position - var_210_4.position).z)
				var_210_4.localEulerAngles.z = 0
				var_210_4.localEulerAngles.x = 0
				var_210_4.localEulerAngles = var_210_4.localEulerAngles
			end

			local var_210_6 = arg_207_1.actors_["10078ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_6) and arg_207_1.var_.characterEffect10078ui_story == nil then
				arg_207_1.var_.characterEffect10078ui_story = var_210_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_7 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_7 and not isNil(var_210_6) then
				if arg_207_1.var_.characterEffect10078ui_story and not isNil(var_210_6) then
					arg_207_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_207_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_7)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_7 and arg_207_1.time_ < 0 + var_210_7 + arg_210_0 and not isNil(var_210_6) and arg_207_1.var_.characterEffect10078ui_story then
				arg_207_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_207_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_210_8 = 0
			local var_210_9 = 0.525

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_8 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_10 = arg_207_1:GetWordFromCfg(412021049)
				local var_210_11 = arg_207_1:FormatText(var_210_10.content)

				arg_207_1.text_.text = var_210_11

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_13 = 21 <= 0 and var_210_9 or var_210_9 * (utf8.len(var_210_11) / 21)

				if (21 <= 0 and var_210_9 or var_210_9 * (utf8.len(var_210_11) / 21)) > 0 and var_210_9 < var_210_13 then
					arg_207_1.talkMaxDuration = var_210_13

					if var_210_13 + var_210_8 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_13 + var_210_8
					end
				end

				arg_207_1.text_.text = var_210_11
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021049", "story_v_out_412021.awb") ~= 0 then
					local var_210_14 = manager.audio:GetVoiceLength("story_v_out_412021", "412021049", "story_v_out_412021.awb") / 1000

					if var_210_14 + var_210_8 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_14 + var_210_8
					end

					if var_210_10.prefab_name ~= "" and arg_207_1.actors_[var_210_10.prefab_name] ~= nil then
						local var_210_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_10.prefab_name].transform, "story_v_out_412021", "412021049", "story_v_out_412021.awb")

						arg_207_1:RecordAudio("412021049", var_210_15)
						arg_207_1:RecordAudio("412021049", var_210_15)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_412021", "412021049", "story_v_out_412021.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_412021", "412021049", "story_v_out_412021.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_16 = math.max(var_210_9, arg_207_1.talkMaxDuration)

			if var_210_8 <= arg_207_1.time_ and arg_207_1.time_ < var_210_8 + var_210_16 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_8) / var_210_16

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_8 + var_210_16 and arg_207_1.time_ < var_210_8 + var_210_16 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play412021050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 412021050
		arg_211_1.duration_ = 10.23

		local var_211_0 = {
			zh = 10.133,
			ja = 10.233
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play412021051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(arg_211_1.actors_["10076ui_story"]) and arg_211_1.var_.characterEffect10076ui_story == nil then
				arg_211_1.var_.characterEffect10076ui_story = arg_211_1.actors_["10076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_0 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 and not isNil(arg_211_1.actors_["10076ui_story"]) then
				if arg_211_1.var_.characterEffect10076ui_story and not isNil(arg_211_1.actors_["10076ui_story"]) then
					arg_211_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_211_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_211_1.time_ - 0) / var_214_0)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 and not isNil(arg_211_1.actors_["10076ui_story"]) and arg_211_1.var_.characterEffect10076ui_story then
				arg_211_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_211_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_214_1 = arg_211_1.actors_["10078ui_story"].transform

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos10078ui_story = var_214_1.localPosition
			end

			local var_214_2 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_2 then
				var_214_1.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos10078ui_story, Vector3.New(0, -0.5, -6.3), (arg_211_1.time_ - 0) / var_214_2)
				var_214_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_1.position).x, (manager.ui.mainCamera.transform.position - var_214_1.position).y, (manager.ui.mainCamera.transform.position - var_214_1.position).z)
				var_214_1.localEulerAngles.z = 0
				var_214_1.localEulerAngles.x = 0
				var_214_1.localEulerAngles = var_214_1.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_2 and arg_211_1.time_ < 0 + var_214_2 + arg_214_0 then
				var_214_1.localPosition = Vector3.New(0, -0.5, -6.3)
				var_214_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_1.position).x, (manager.ui.mainCamera.transform.position - var_214_1.position).y, (manager.ui.mainCamera.transform.position - var_214_1.position).z)
				var_214_1.localEulerAngles.z = 0
				var_214_1.localEulerAngles.x = 0
				var_214_1.localEulerAngles = var_214_1.localEulerAngles
			end

			local var_214_3 = arg_211_1.actors_["10078ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_3) and arg_211_1.var_.characterEffect10078ui_story == nil then
				arg_211_1.var_.characterEffect10078ui_story = var_214_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_4 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_4 and not isNil(var_214_3) then
				if arg_211_1.var_.characterEffect10078ui_story and not isNil(var_214_3) then
					arg_211_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 0 + var_214_4 and arg_211_1.time_ < 0 + var_214_4 + arg_214_0 and not isNil(var_214_3) and arg_211_1.var_.characterEffect10078ui_story then
				arg_211_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			local var_214_6 = arg_211_1.actors_["10076ui_story"].transform

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos10076ui_story = var_214_6.localPosition
			end

			local var_214_7 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_7 then
				var_214_6.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos10076ui_story, Vector3.New(0, 100, 0), (arg_211_1.time_ - 0) / var_214_7)
				var_214_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_6.position).x, (manager.ui.mainCamera.transform.position - var_214_6.position).y, (manager.ui.mainCamera.transform.position - var_214_6.position).z)
				var_214_6.localEulerAngles.z = 0
				var_214_6.localEulerAngles.x = 0
				var_214_6.localEulerAngles = var_214_6.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_7 and arg_211_1.time_ < 0 + var_214_7 + arg_214_0 then
				var_214_6.localPosition = Vector3.New(0, 100, 0)
				var_214_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_6.position).x, (manager.ui.mainCamera.transform.position - var_214_6.position).y, (manager.ui.mainCamera.transform.position - var_214_6.position).z)
				var_214_6.localEulerAngles.z = 0
				var_214_6.localEulerAngles.x = 0
				var_214_6.localEulerAngles = var_214_6.localEulerAngles
			end

			local var_214_8 = arg_211_1.actors_["10076ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_8) and arg_211_1.var_.characterEffect10076ui_story == nil then
				arg_211_1.var_.characterEffect10076ui_story = var_214_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_9 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_9 and not isNil(var_214_8) then
				if arg_211_1.var_.characterEffect10076ui_story and not isNil(var_214_8) then
					arg_211_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_211_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_211_1.time_ - 0) / var_214_9)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_9 and arg_211_1.time_ < 0 + var_214_9 + arg_214_0 and not isNil(var_214_8) and arg_211_1.var_.characterEffect10076ui_story then
				arg_211_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_211_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_214_10 = 0
			local var_214_11 = 0.675

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_10 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_12 = arg_211_1:GetWordFromCfg(412021050)
				local var_214_13 = arg_211_1:FormatText(var_214_12.content)

				arg_211_1.text_.text = var_214_13

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_15 = 27 <= 0 and var_214_11 or var_214_11 * (utf8.len(var_214_13) / 27)

				if (27 <= 0 and var_214_11 or var_214_11 * (utf8.len(var_214_13) / 27)) > 0 and var_214_11 < var_214_15 then
					arg_211_1.talkMaxDuration = var_214_15

					if var_214_15 + var_214_10 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_15 + var_214_10
					end
				end

				arg_211_1.text_.text = var_214_13
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021050", "story_v_out_412021.awb") ~= 0 then
					local var_214_16 = manager.audio:GetVoiceLength("story_v_out_412021", "412021050", "story_v_out_412021.awb") / 1000

					if var_214_16 + var_214_10 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_16 + var_214_10
					end

					if var_214_12.prefab_name ~= "" and arg_211_1.actors_[var_214_12.prefab_name] ~= nil then
						local var_214_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_12.prefab_name].transform, "story_v_out_412021", "412021050", "story_v_out_412021.awb")

						arg_211_1:RecordAudio("412021050", var_214_17)
						arg_211_1:RecordAudio("412021050", var_214_17)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_412021", "412021050", "story_v_out_412021.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_412021", "412021050", "story_v_out_412021.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_18 = math.max(var_214_11, arg_211_1.talkMaxDuration)

			if var_214_10 <= arg_211_1.time_ and arg_211_1.time_ < var_214_10 + var_214_18 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_10) / var_214_18

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_10 + var_214_18 and arg_211_1.time_ < var_214_10 + var_214_18 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play412021051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 412021051
		arg_215_1.duration_ = 4.93

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play412021052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos1097ui_story = arg_215_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_218_0 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 then
				arg_215_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_215_1.time_ - 0) / var_218_0)
				arg_215_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1097ui_story"].transform.position).z)
				arg_215_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["1097ui_story"].transform.localEulerAngles = arg_215_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 then
				arg_215_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_215_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1097ui_story"].transform.position).z)
				arg_215_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["1097ui_story"].transform.localEulerAngles = arg_215_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_218_1 = arg_215_1.actors_["1097ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect1097ui_story == nil then
				arg_215_1.var_.characterEffect1097ui_story = var_218_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_2 and not isNil(var_218_1) then
				if arg_215_1.var_.characterEffect1097ui_story and not isNil(var_218_1) then
					arg_215_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= 0 + var_218_2 and arg_215_1.time_ < 0 + var_218_2 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect1097ui_story then
				arg_215_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_218_4 = arg_215_1.actors_["10078ui_story"].transform

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos10078ui_story = var_218_4.localPosition
			end

			local var_218_5 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_5 then
				var_218_4.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos10078ui_story, Vector3.New(0, 100, 0), (arg_215_1.time_ - 0) / var_218_5)
				var_218_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_218_4.position).x, (manager.ui.mainCamera.transform.position - var_218_4.position).y, (manager.ui.mainCamera.transform.position - var_218_4.position).z)
				var_218_4.localEulerAngles.z = 0
				var_218_4.localEulerAngles.x = 0
				var_218_4.localEulerAngles = var_218_4.localEulerAngles
			end

			if arg_215_1.time_ >= 0 + var_218_5 and arg_215_1.time_ < 0 + var_218_5 + arg_218_0 then
				var_218_4.localPosition = Vector3.New(0, 100, 0)
				var_218_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_218_4.position).x, (manager.ui.mainCamera.transform.position - var_218_4.position).y, (manager.ui.mainCamera.transform.position - var_218_4.position).z)
				var_218_4.localEulerAngles.z = 0
				var_218_4.localEulerAngles.x = 0
				var_218_4.localEulerAngles = var_218_4.localEulerAngles
			end

			local var_218_6 = arg_215_1.actors_["10076ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_6) and arg_215_1.var_.characterEffect10076ui_story == nil then
				arg_215_1.var_.characterEffect10076ui_story = var_218_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_7 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_7 and not isNil(var_218_6) then
				if arg_215_1.var_.characterEffect10076ui_story and not isNil(var_218_6) then
					arg_215_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_215_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_215_1.time_ - 0) / var_218_7)
				end
			end

			if arg_215_1.time_ >= 0 + var_218_7 and arg_215_1.time_ < 0 + var_218_7 + arg_218_0 and not isNil(var_218_6) and arg_215_1.var_.characterEffect10076ui_story then
				arg_215_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_215_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_218_8 = 0
			local var_218_9 = 0.375

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_8 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_10 = arg_215_1:GetWordFromCfg(412021051)
				local var_218_11 = arg_215_1:FormatText(var_218_10.content)

				arg_215_1.text_.text = var_218_11

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_13 = 15 <= 0 and var_218_9 or var_218_9 * (utf8.len(var_218_11) / 15)

				if (15 <= 0 and var_218_9 or var_218_9 * (utf8.len(var_218_11) / 15)) > 0 and var_218_9 < var_218_13 then
					arg_215_1.talkMaxDuration = var_218_13

					if var_218_13 + var_218_8 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_13 + var_218_8
					end
				end

				arg_215_1.text_.text = var_218_11
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021051", "story_v_out_412021.awb") ~= 0 then
					local var_218_14 = manager.audio:GetVoiceLength("story_v_out_412021", "412021051", "story_v_out_412021.awb") / 1000

					if var_218_14 + var_218_8 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_14 + var_218_8
					end

					if var_218_10.prefab_name ~= "" and arg_215_1.actors_[var_218_10.prefab_name] ~= nil then
						local var_218_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_10.prefab_name].transform, "story_v_out_412021", "412021051", "story_v_out_412021.awb")

						arg_215_1:RecordAudio("412021051", var_218_15)
						arg_215_1:RecordAudio("412021051", var_218_15)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_412021", "412021051", "story_v_out_412021.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_412021", "412021051", "story_v_out_412021.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_16 = math.max(var_218_9, arg_215_1.talkMaxDuration)

			if var_218_8 <= arg_215_1.time_ and arg_215_1.time_ < var_218_8 + var_218_16 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_8) / var_218_16

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_8 + var_218_16 and arg_215_1.time_ < var_218_8 + var_218_16 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play412021052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 412021052
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play412021053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(arg_219_1.actors_["1097ui_story"]) and arg_219_1.var_.characterEffect1097ui_story == nil then
				arg_219_1.var_.characterEffect1097ui_story = arg_219_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_0 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 and not isNil(arg_219_1.actors_["1097ui_story"]) then
				if arg_219_1.var_.characterEffect1097ui_story and not isNil(arg_219_1.actors_["1097ui_story"]) then
					arg_219_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 0) / var_222_0)
				end
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 and not isNil(arg_219_1.actors_["1097ui_story"]) and arg_219_1.var_.characterEffect1097ui_story then
				arg_219_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_222_1 = 0
			local var_222_2 = 0.475

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_3 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(412021052).content)

				arg_219_1.text_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 19 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 19)

				if (19 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 19)) > 0 and var_222_2 < var_222_5 then
					arg_219_1.talkMaxDuration = var_222_5

					if var_222_5 + var_222_1 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + var_222_1
					end
				end

				arg_219_1.text_.text = var_222_3
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_6 = math.max(var_222_2, arg_219_1.talkMaxDuration)

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_6 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_1) / var_222_6

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_1 + var_222_6 and arg_219_1.time_ < var_222_1 + var_222_6 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play412021053 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 412021053
		arg_223_1.duration_ = 7.03

		local var_223_0 = {
			zh = 6.7,
			ja = 7.033
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play412021054(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos10078ui_story = arg_223_1.actors_["10078ui_story"].transform.localPosition
			end

			local var_226_0 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 then
				arg_223_1.actors_["10078ui_story"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos10078ui_story, Vector3.New(0, -0.5, -6.3), (arg_223_1.time_ - 0) / var_226_0)
				arg_223_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["10078ui_story"].transform.position).z)
				arg_223_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["10078ui_story"].transform.localEulerAngles = arg_223_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 then
				arg_223_1.actors_["10078ui_story"].transform.localPosition = Vector3.New(0, -0.5, -6.3)
				arg_223_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["10078ui_story"].transform.position).z)
				arg_223_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["10078ui_story"].transform.localEulerAngles = arg_223_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			local var_226_1 = arg_223_1.actors_["10078ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect10078ui_story == nil then
				arg_223_1.var_.characterEffect10078ui_story = var_226_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_2 and not isNil(var_226_1) then
				if arg_223_1.var_.characterEffect10078ui_story and not isNil(var_226_1) then
					arg_223_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 0 + var_226_2 and arg_223_1.time_ < 0 + var_226_2 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect10078ui_story then
				arg_223_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action5_1")
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_226_4 = arg_223_1.actors_["1097ui_story"].transform

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos1097ui_story = var_226_4.localPosition
			end

			local var_226_5 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_5 then
				var_226_4.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_223_1.time_ - 0) / var_226_5)
				var_226_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_4.position).x, (manager.ui.mainCamera.transform.position - var_226_4.position).y, (manager.ui.mainCamera.transform.position - var_226_4.position).z)
				var_226_4.localEulerAngles.z = 0
				var_226_4.localEulerAngles.x = 0
				var_226_4.localEulerAngles = var_226_4.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_5 and arg_223_1.time_ < 0 + var_226_5 + arg_226_0 then
				var_226_4.localPosition = Vector3.New(0, 100, 0)
				var_226_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_4.position).x, (manager.ui.mainCamera.transform.position - var_226_4.position).y, (manager.ui.mainCamera.transform.position - var_226_4.position).z)
				var_226_4.localEulerAngles.z = 0
				var_226_4.localEulerAngles.x = 0
				var_226_4.localEulerAngles = var_226_4.localEulerAngles
			end

			local var_226_6 = 0
			local var_226_7 = 0.425

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_6 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_8 = arg_223_1:GetWordFromCfg(412021053)
				local var_226_9 = arg_223_1:FormatText(var_226_8.content)

				arg_223_1.text_.text = var_226_9

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_11 = 17 <= 0 and var_226_7 or var_226_7 * (utf8.len(var_226_9) / 17)

				if (17 <= 0 and var_226_7 or var_226_7 * (utf8.len(var_226_9) / 17)) > 0 and var_226_7 < var_226_11 then
					arg_223_1.talkMaxDuration = var_226_11

					if var_226_11 + var_226_6 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_11 + var_226_6
					end
				end

				arg_223_1.text_.text = var_226_9
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021053", "story_v_out_412021.awb") ~= 0 then
					local var_226_12 = manager.audio:GetVoiceLength("story_v_out_412021", "412021053", "story_v_out_412021.awb") / 1000

					if var_226_12 + var_226_6 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_12 + var_226_6
					end

					if var_226_8.prefab_name ~= "" and arg_223_1.actors_[var_226_8.prefab_name] ~= nil then
						local var_226_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_8.prefab_name].transform, "story_v_out_412021", "412021053", "story_v_out_412021.awb")

						arg_223_1:RecordAudio("412021053", var_226_13)
						arg_223_1:RecordAudio("412021053", var_226_13)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_412021", "412021053", "story_v_out_412021.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_412021", "412021053", "story_v_out_412021.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_14 = math.max(var_226_7, arg_223_1.talkMaxDuration)

			if var_226_6 <= arg_223_1.time_ and arg_223_1.time_ < var_226_6 + var_226_14 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_6) / var_226_14

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_6 + var_226_14 and arg_223_1.time_ < var_226_6 + var_226_14 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play412021054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 412021054
		arg_227_1.duration_ = 10.3

		local var_227_0 = {
			zh = 10.3,
			ja = 6.333
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play412021055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos10083ui_story = arg_227_1.actors_["10083ui_story"].transform.localPosition
			end

			local var_230_0 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 then
				arg_227_1.actors_["10083ui_story"].transform.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos10083ui_story, Vector3.New(0, -2.6, -2.8), (arg_227_1.time_ - 0) / var_230_0)
				arg_227_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["10083ui_story"].transform.position).z)
				arg_227_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["10083ui_story"].transform.localEulerAngles = arg_227_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 then
				arg_227_1.actors_["10083ui_story"].transform.localPosition = Vector3.New(0, -2.6, -2.8)
				arg_227_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["10083ui_story"].transform.position).z)
				arg_227_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["10083ui_story"].transform.localEulerAngles = arg_227_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			local var_230_1 = arg_227_1.actors_["10083ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect10083ui_story == nil then
				arg_227_1.var_.characterEffect10083ui_story = var_230_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_2 and not isNil(var_230_1) then
				if arg_227_1.var_.characterEffect10083ui_story and not isNil(var_230_1) then
					arg_227_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= 0 + var_230_2 and arg_227_1.time_ < 0 + var_230_2 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect10083ui_story then
				arg_227_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action1_1")
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_230_4 = arg_227_1.actors_["10078ui_story"].transform

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos10078ui_story = var_230_4.localPosition
			end

			local var_230_5 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_5 then
				var_230_4.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos10078ui_story, Vector3.New(0, 100, 0), (arg_227_1.time_ - 0) / var_230_5)
				var_230_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_230_4.position).x, (manager.ui.mainCamera.transform.position - var_230_4.position).y, (manager.ui.mainCamera.transform.position - var_230_4.position).z)
				var_230_4.localEulerAngles.z = 0
				var_230_4.localEulerAngles.x = 0
				var_230_4.localEulerAngles = var_230_4.localEulerAngles
			end

			if arg_227_1.time_ >= 0 + var_230_5 and arg_227_1.time_ < 0 + var_230_5 + arg_230_0 then
				var_230_4.localPosition = Vector3.New(0, 100, 0)
				var_230_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_230_4.position).x, (manager.ui.mainCamera.transform.position - var_230_4.position).y, (manager.ui.mainCamera.transform.position - var_230_4.position).z)
				var_230_4.localEulerAngles.z = 0
				var_230_4.localEulerAngles.x = 0
				var_230_4.localEulerAngles = var_230_4.localEulerAngles
			end

			local var_230_6 = arg_227_1.actors_["10078ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_6) and arg_227_1.var_.characterEffect10078ui_story == nil then
				arg_227_1.var_.characterEffect10078ui_story = var_230_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_7 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_7 and not isNil(var_230_6) then
				if arg_227_1.var_.characterEffect10078ui_story and not isNil(var_230_6) then
					arg_227_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_227_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_227_1.time_ - 0) / var_230_7)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_7 and arg_227_1.time_ < 0 + var_230_7 + arg_230_0 and not isNil(var_230_6) and arg_227_1.var_.characterEffect10078ui_story then
				arg_227_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_227_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_230_8 = 0
			local var_230_9 = 1.175

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_8 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_10 = arg_227_1:GetWordFromCfg(412021054)
				local var_230_11 = arg_227_1:FormatText(var_230_10.content)

				arg_227_1.text_.text = var_230_11

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_13 = 47 <= 0 and var_230_9 or var_230_9 * (utf8.len(var_230_11) / 47)

				if (47 <= 0 and var_230_9 or var_230_9 * (utf8.len(var_230_11) / 47)) > 0 and var_230_9 < var_230_13 then
					arg_227_1.talkMaxDuration = var_230_13

					if var_230_13 + var_230_8 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_13 + var_230_8
					end
				end

				arg_227_1.text_.text = var_230_11
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021054", "story_v_out_412021.awb") ~= 0 then
					local var_230_14 = manager.audio:GetVoiceLength("story_v_out_412021", "412021054", "story_v_out_412021.awb") / 1000

					if var_230_14 + var_230_8 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_14 + var_230_8
					end

					if var_230_10.prefab_name ~= "" and arg_227_1.actors_[var_230_10.prefab_name] ~= nil then
						local var_230_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_10.prefab_name].transform, "story_v_out_412021", "412021054", "story_v_out_412021.awb")

						arg_227_1:RecordAudio("412021054", var_230_15)
						arg_227_1:RecordAudio("412021054", var_230_15)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_412021", "412021054", "story_v_out_412021.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_412021", "412021054", "story_v_out_412021.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_16 = math.max(var_230_9, arg_227_1.talkMaxDuration)

			if var_230_8 <= arg_227_1.time_ and arg_227_1.time_ < var_230_8 + var_230_16 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_8) / var_230_16

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_8 + var_230_16 and arg_227_1.time_ < var_230_8 + var_230_16 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play412021055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 412021055
		arg_231_1.duration_ = 4.63

		local var_231_0 = {
			zh = 3,
			ja = 4.633
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play412021056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos10076ui_story = arg_231_1.actors_["10076ui_story"].transform.localPosition
			end

			local var_234_0 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 then
				arg_231_1.actors_["10076ui_story"].transform.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10076ui_story, Vector3.New(0, -0.35, -4), (arg_231_1.time_ - 0) / var_234_0)
				arg_231_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["10076ui_story"].transform.position).z)
				arg_231_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["10076ui_story"].transform.localEulerAngles = arg_231_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 then
				arg_231_1.actors_["10076ui_story"].transform.localPosition = Vector3.New(0, -0.35, -4)
				arg_231_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["10076ui_story"].transform.position).z)
				arg_231_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["10076ui_story"].transform.localEulerAngles = arg_231_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			local var_234_1 = arg_231_1.actors_["10076ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect10076ui_story == nil then
				arg_231_1.var_.characterEffect10076ui_story = var_234_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_2 and not isNil(var_234_1) then
				if arg_231_1.var_.characterEffect10076ui_story and not isNil(var_234_1) then
					arg_231_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0 + var_234_2 and arg_231_1.time_ < 0 + var_234_2 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect10076ui_story then
				arg_231_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action1_1")
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_234_4 = arg_231_1.actors_["10083ui_story"].transform

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos10083ui_story = var_234_4.localPosition
			end

			local var_234_5 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_5 then
				var_234_4.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10083ui_story, Vector3.New(0, 100, 0), (arg_231_1.time_ - 0) / var_234_5)
				var_234_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_4.position).x, (manager.ui.mainCamera.transform.position - var_234_4.position).y, (manager.ui.mainCamera.transform.position - var_234_4.position).z)
				var_234_4.localEulerAngles.z = 0
				var_234_4.localEulerAngles.x = 0
				var_234_4.localEulerAngles = var_234_4.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_5 and arg_231_1.time_ < 0 + var_234_5 + arg_234_0 then
				var_234_4.localPosition = Vector3.New(0, 100, 0)
				var_234_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_4.position).x, (manager.ui.mainCamera.transform.position - var_234_4.position).y, (manager.ui.mainCamera.transform.position - var_234_4.position).z)
				var_234_4.localEulerAngles.z = 0
				var_234_4.localEulerAngles.x = 0
				var_234_4.localEulerAngles = var_234_4.localEulerAngles
			end

			local var_234_6 = arg_231_1.actors_["10083ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_6) and arg_231_1.var_.characterEffect10083ui_story == nil then
				arg_231_1.var_.characterEffect10083ui_story = var_234_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_7 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_7 and not isNil(var_234_6) then
				if arg_231_1.var_.characterEffect10083ui_story and not isNil(var_234_6) then
					arg_231_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_231_1.var_.characterEffect10083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_231_1.time_ - 0) / var_234_7)
				end
			end

			if arg_231_1.time_ >= 0 + var_234_7 and arg_231_1.time_ < 0 + var_234_7 + arg_234_0 and not isNil(var_234_6) and arg_231_1.var_.characterEffect10083ui_story then
				arg_231_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_231_1.var_.characterEffect10083ui_story.fillRatio = 0.5
			end

			local var_234_8 = 0
			local var_234_9 = 0.4

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_8 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_10 = arg_231_1:GetWordFromCfg(412021055)
				local var_234_11 = arg_231_1:FormatText(var_234_10.content)

				arg_231_1.text_.text = var_234_11

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_13 = 16 <= 0 and var_234_9 or var_234_9 * (utf8.len(var_234_11) / 16)

				if (16 <= 0 and var_234_9 or var_234_9 * (utf8.len(var_234_11) / 16)) > 0 and var_234_9 < var_234_13 then
					arg_231_1.talkMaxDuration = var_234_13

					if var_234_13 + var_234_8 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_13 + var_234_8
					end
				end

				arg_231_1.text_.text = var_234_11
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021055", "story_v_out_412021.awb") ~= 0 then
					local var_234_14 = manager.audio:GetVoiceLength("story_v_out_412021", "412021055", "story_v_out_412021.awb") / 1000

					if var_234_14 + var_234_8 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_14 + var_234_8
					end

					if var_234_10.prefab_name ~= "" and arg_231_1.actors_[var_234_10.prefab_name] ~= nil then
						local var_234_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_10.prefab_name].transform, "story_v_out_412021", "412021055", "story_v_out_412021.awb")

						arg_231_1:RecordAudio("412021055", var_234_15)
						arg_231_1:RecordAudio("412021055", var_234_15)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_412021", "412021055", "story_v_out_412021.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_412021", "412021055", "story_v_out_412021.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_16 = math.max(var_234_9, arg_231_1.talkMaxDuration)

			if var_234_8 <= arg_231_1.time_ and arg_231_1.time_ < var_234_8 + var_234_16 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_8) / var_234_16

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_8 + var_234_16 and arg_231_1.time_ < var_234_8 + var_234_16 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play412021056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 412021056
		arg_235_1.duration_ = 4.67

		local var_235_0 = {
			zh = 4.666,
			ja = 1.733
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play412021057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos1097ui_story = arg_235_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_238_0 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 then
				arg_235_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_235_1.time_ - 0) / var_238_0)
				arg_235_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1097ui_story"].transform.position).z)
				arg_235_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["1097ui_story"].transform.localEulerAngles = arg_235_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 then
				arg_235_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_235_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1097ui_story"].transform.position).z)
				arg_235_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["1097ui_story"].transform.localEulerAngles = arg_235_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_238_1 = arg_235_1.actors_["1097ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_1) and arg_235_1.var_.characterEffect1097ui_story == nil then
				arg_235_1.var_.characterEffect1097ui_story = var_238_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_2 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_2 and not isNil(var_238_1) then
				if arg_235_1.var_.characterEffect1097ui_story and not isNil(var_238_1) then
					arg_235_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= 0 + var_238_2 and arg_235_1.time_ < 0 + var_238_2 + arg_238_0 and not isNil(var_238_1) and arg_235_1.var_.characterEffect1097ui_story then
				arg_235_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_238_4 = arg_235_1.actors_["10076ui_story"].transform

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos10076ui_story = var_238_4.localPosition
			end

			local var_238_5 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_5 then
				var_238_4.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos10076ui_story, Vector3.New(0, 100, 0), (arg_235_1.time_ - 0) / var_238_5)
				var_238_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_238_4.position).x, (manager.ui.mainCamera.transform.position - var_238_4.position).y, (manager.ui.mainCamera.transform.position - var_238_4.position).z)
				var_238_4.localEulerAngles.z = 0
				var_238_4.localEulerAngles.x = 0
				var_238_4.localEulerAngles = var_238_4.localEulerAngles
			end

			if arg_235_1.time_ >= 0 + var_238_5 and arg_235_1.time_ < 0 + var_238_5 + arg_238_0 then
				var_238_4.localPosition = Vector3.New(0, 100, 0)
				var_238_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_238_4.position).x, (manager.ui.mainCamera.transform.position - var_238_4.position).y, (manager.ui.mainCamera.transform.position - var_238_4.position).z)
				var_238_4.localEulerAngles.z = 0
				var_238_4.localEulerAngles.x = 0
				var_238_4.localEulerAngles = var_238_4.localEulerAngles
			end

			local var_238_6 = arg_235_1.actors_["10076ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_6) and arg_235_1.var_.characterEffect10076ui_story == nil then
				arg_235_1.var_.characterEffect10076ui_story = var_238_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_7 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_7 and not isNil(var_238_6) then
				if arg_235_1.var_.characterEffect10076ui_story and not isNil(var_238_6) then
					arg_235_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_235_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_235_1.time_ - 0) / var_238_7)
				end
			end

			if arg_235_1.time_ >= 0 + var_238_7 and arg_235_1.time_ < 0 + var_238_7 + arg_238_0 and not isNil(var_238_6) and arg_235_1.var_.characterEffect10076ui_story then
				arg_235_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_235_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_238_8 = 0
			local var_238_9 = 0.475

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_8 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_10 = arg_235_1:GetWordFromCfg(412021056)
				local var_238_11 = arg_235_1:FormatText(var_238_10.content)

				arg_235_1.text_.text = var_238_11

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_13 = 19 <= 0 and var_238_9 or var_238_9 * (utf8.len(var_238_11) / 19)

				if (19 <= 0 and var_238_9 or var_238_9 * (utf8.len(var_238_11) / 19)) > 0 and var_238_9 < var_238_13 then
					arg_235_1.talkMaxDuration = var_238_13

					if var_238_13 + var_238_8 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_13 + var_238_8
					end
				end

				arg_235_1.text_.text = var_238_11
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021056", "story_v_out_412021.awb") ~= 0 then
					local var_238_14 = manager.audio:GetVoiceLength("story_v_out_412021", "412021056", "story_v_out_412021.awb") / 1000

					if var_238_14 + var_238_8 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_14 + var_238_8
					end

					if var_238_10.prefab_name ~= "" and arg_235_1.actors_[var_238_10.prefab_name] ~= nil then
						local var_238_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_10.prefab_name].transform, "story_v_out_412021", "412021056", "story_v_out_412021.awb")

						arg_235_1:RecordAudio("412021056", var_238_15)
						arg_235_1:RecordAudio("412021056", var_238_15)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_412021", "412021056", "story_v_out_412021.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_412021", "412021056", "story_v_out_412021.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_16 = math.max(var_238_9, arg_235_1.talkMaxDuration)

			if var_238_8 <= arg_235_1.time_ and arg_235_1.time_ < var_238_8 + var_238_16 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_8) / var_238_16

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_8 + var_238_16 and arg_235_1.time_ < var_238_8 + var_238_16 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play412021057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 412021057
		arg_239_1.duration_ = 6.13

		local var_239_0 = {
			zh = 6.133,
			ja = 4.433
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play412021058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos10078ui_story = arg_239_1.actors_["10078ui_story"].transform.localPosition
			end

			local var_242_0 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 then
				arg_239_1.actors_["10078ui_story"].transform.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos10078ui_story, Vector3.New(0, -0.5, -6.3), (arg_239_1.time_ - 0) / var_242_0)
				arg_239_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["10078ui_story"].transform.position).z)
				arg_239_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["10078ui_story"].transform.localEulerAngles = arg_239_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 then
				arg_239_1.actors_["10078ui_story"].transform.localPosition = Vector3.New(0, -0.5, -6.3)
				arg_239_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["10078ui_story"].transform.position).z)
				arg_239_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["10078ui_story"].transform.localEulerAngles = arg_239_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			local var_242_1 = arg_239_1.actors_["10078ui_story"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect10078ui_story == nil then
				arg_239_1.var_.characterEffect10078ui_story = var_242_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_2 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_2 and not isNil(var_242_1) then
				if arg_239_1.var_.characterEffect10078ui_story and not isNil(var_242_1) then
					arg_239_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= 0 + var_242_2 and arg_239_1.time_ < 0 + var_242_2 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect10078ui_story then
				arg_239_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_242_4 = arg_239_1.actors_["1097ui_story"].transform

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos1097ui_story = var_242_4.localPosition
			end

			local var_242_5 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_5 then
				var_242_4.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_239_1.time_ - 0) / var_242_5)
				var_242_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_242_4.position).x, (manager.ui.mainCamera.transform.position - var_242_4.position).y, (manager.ui.mainCamera.transform.position - var_242_4.position).z)
				var_242_4.localEulerAngles.z = 0
				var_242_4.localEulerAngles.x = 0
				var_242_4.localEulerAngles = var_242_4.localEulerAngles
			end

			if arg_239_1.time_ >= 0 + var_242_5 and arg_239_1.time_ < 0 + var_242_5 + arg_242_0 then
				var_242_4.localPosition = Vector3.New(0, 100, 0)
				var_242_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_242_4.position).x, (manager.ui.mainCamera.transform.position - var_242_4.position).y, (manager.ui.mainCamera.transform.position - var_242_4.position).z)
				var_242_4.localEulerAngles.z = 0
				var_242_4.localEulerAngles.x = 0
				var_242_4.localEulerAngles = var_242_4.localEulerAngles
			end

			local var_242_6 = arg_239_1.actors_["1097ui_story"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_6) and arg_239_1.var_.characterEffect1097ui_story == nil then
				arg_239_1.var_.characterEffect1097ui_story = var_242_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_7 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_7 and not isNil(var_242_6) then
				if arg_239_1.var_.characterEffect1097ui_story and not isNil(var_242_6) then
					arg_239_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_239_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_239_1.time_ - 0) / var_242_7)
				end
			end

			if arg_239_1.time_ >= 0 + var_242_7 and arg_239_1.time_ < 0 + var_242_7 + arg_242_0 and not isNil(var_242_6) and arg_239_1.var_.characterEffect1097ui_story then
				arg_239_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_239_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_242_8 = 0
			local var_242_9 = 0.375

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_8 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_10 = arg_239_1:GetWordFromCfg(412021057)
				local var_242_11 = arg_239_1:FormatText(var_242_10.content)

				arg_239_1.text_.text = var_242_11

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_13 = 15 <= 0 and var_242_9 or var_242_9 * (utf8.len(var_242_11) / 15)

				if (15 <= 0 and var_242_9 or var_242_9 * (utf8.len(var_242_11) / 15)) > 0 and var_242_9 < var_242_13 then
					arg_239_1.talkMaxDuration = var_242_13

					if var_242_13 + var_242_8 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_13 + var_242_8
					end
				end

				arg_239_1.text_.text = var_242_11
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021057", "story_v_out_412021.awb") ~= 0 then
					local var_242_14 = manager.audio:GetVoiceLength("story_v_out_412021", "412021057", "story_v_out_412021.awb") / 1000

					if var_242_14 + var_242_8 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_14 + var_242_8
					end

					if var_242_10.prefab_name ~= "" and arg_239_1.actors_[var_242_10.prefab_name] ~= nil then
						local var_242_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_10.prefab_name].transform, "story_v_out_412021", "412021057", "story_v_out_412021.awb")

						arg_239_1:RecordAudio("412021057", var_242_15)
						arg_239_1:RecordAudio("412021057", var_242_15)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_412021", "412021057", "story_v_out_412021.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_412021", "412021057", "story_v_out_412021.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_16 = math.max(var_242_9, arg_239_1.talkMaxDuration)

			if var_242_8 <= arg_239_1.time_ and arg_239_1.time_ < var_242_8 + var_242_16 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_8) / var_242_16

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_8 + var_242_16 and arg_239_1.time_ < var_242_8 + var_242_16 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play412021058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 412021058
		arg_243_1.duration_ = 6.9

		local var_243_0 = {
			zh = 4.033,
			ja = 6.9
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play412021059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0.325

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_1 = arg_243_1:GetWordFromCfg(412021058)
				local var_246_2 = arg_243_1:FormatText(var_246_1.content)

				arg_243_1.text_.text = var_246_2

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_4 = 13 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_2) / 13)

				if (13 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_2) / 13)) > 0 and var_246_0 < var_246_4 then
					arg_243_1.talkMaxDuration = var_246_4

					if var_246_4 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_4 + 0
					end
				end

				arg_243_1.text_.text = var_246_2
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021058", "story_v_out_412021.awb") ~= 0 then
					local var_246_5 = manager.audio:GetVoiceLength("story_v_out_412021", "412021058", "story_v_out_412021.awb") / 1000

					if var_246_5 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_5 + 0
					end

					if var_246_1.prefab_name ~= "" and arg_243_1.actors_[var_246_1.prefab_name] ~= nil then
						local var_246_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_1.prefab_name].transform, "story_v_out_412021", "412021058", "story_v_out_412021.awb")

						arg_243_1:RecordAudio("412021058", var_246_6)
						arg_243_1:RecordAudio("412021058", var_246_6)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_412021", "412021058", "story_v_out_412021.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_412021", "412021058", "story_v_out_412021.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_7 = math.max(var_246_0, arg_243_1.talkMaxDuration)

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_7 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - 0) / var_246_7

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= 0 + var_246_7 and arg_243_1.time_ < 0 + var_246_7 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play412021059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 412021059
		arg_247_1.duration_ = 4.87

		local var_247_0 = {
			zh = 4.866,
			ja = 4.833
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
			arg_247_1.auto_ = false
		end

		function arg_247_1.playNext_(arg_249_0)
			arg_247_1.onStoryFinished_()
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos1097ui_story = arg_247_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_250_0 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 then
				arg_247_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_247_1.time_ - 0) / var_250_0)
				arg_247_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1097ui_story"].transform.position).z)
				arg_247_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["1097ui_story"].transform.localEulerAngles = arg_247_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 then
				arg_247_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_247_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1097ui_story"].transform.position).z)
				arg_247_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["1097ui_story"].transform.localEulerAngles = arg_247_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_250_1 = arg_247_1.actors_["1097ui_story"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect1097ui_story == nil then
				arg_247_1.var_.characterEffect1097ui_story = var_250_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_2 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_2 and not isNil(var_250_1) then
				if arg_247_1.var_.characterEffect1097ui_story and not isNil(var_250_1) then
					arg_247_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= 0 + var_250_2 and arg_247_1.time_ < 0 + var_250_2 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect1097ui_story then
				arg_247_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action3_1")
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_250_4 = arg_247_1.actors_["10078ui_story"].transform

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos10078ui_story = var_250_4.localPosition
			end

			local var_250_5 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_5 then
				var_250_4.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10078ui_story, Vector3.New(0, 100, 0), (arg_247_1.time_ - 0) / var_250_5)
				var_250_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_250_4.position).x, (manager.ui.mainCamera.transform.position - var_250_4.position).y, (manager.ui.mainCamera.transform.position - var_250_4.position).z)
				var_250_4.localEulerAngles.z = 0
				var_250_4.localEulerAngles.x = 0
				var_250_4.localEulerAngles = var_250_4.localEulerAngles
			end

			if arg_247_1.time_ >= 0 + var_250_5 and arg_247_1.time_ < 0 + var_250_5 + arg_250_0 then
				var_250_4.localPosition = Vector3.New(0, 100, 0)
				var_250_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_250_4.position).x, (manager.ui.mainCamera.transform.position - var_250_4.position).y, (manager.ui.mainCamera.transform.position - var_250_4.position).z)
				var_250_4.localEulerAngles.z = 0
				var_250_4.localEulerAngles.x = 0
				var_250_4.localEulerAngles = var_250_4.localEulerAngles
			end

			local var_250_6 = arg_247_1.actors_["10078ui_story"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_6) and arg_247_1.var_.characterEffect10078ui_story == nil then
				arg_247_1.var_.characterEffect10078ui_story = var_250_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_7 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_7 and not isNil(var_250_6) then
				if arg_247_1.var_.characterEffect10078ui_story and not isNil(var_250_6) then
					arg_247_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_247_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_247_1.time_ - 0) / var_250_7)
				end
			end

			if arg_247_1.time_ >= 0 + var_250_7 and arg_247_1.time_ < 0 + var_250_7 + arg_250_0 and not isNil(var_250_6) and arg_247_1.var_.characterEffect10078ui_story then
				arg_247_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_247_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_250_8 = 0
			local var_250_9 = 0.4

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_8 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_10 = arg_247_1:GetWordFromCfg(412021059)
				local var_250_11 = arg_247_1:FormatText(var_250_10.content)

				arg_247_1.text_.text = var_250_11

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_13 = 16 <= 0 and var_250_9 or var_250_9 * (utf8.len(var_250_11) / 16)

				if (16 <= 0 and var_250_9 or var_250_9 * (utf8.len(var_250_11) / 16)) > 0 and var_250_9 < var_250_13 then
					arg_247_1.talkMaxDuration = var_250_13

					if var_250_13 + var_250_8 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_13 + var_250_8
					end
				end

				arg_247_1.text_.text = var_250_11
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412021", "412021059", "story_v_out_412021.awb") ~= 0 then
					local var_250_14 = manager.audio:GetVoiceLength("story_v_out_412021", "412021059", "story_v_out_412021.awb") / 1000

					if var_250_14 + var_250_8 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_14 + var_250_8
					end

					if var_250_10.prefab_name ~= "" and arg_247_1.actors_[var_250_10.prefab_name] ~= nil then
						local var_250_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_10.prefab_name].transform, "story_v_out_412021", "412021059", "story_v_out_412021.awb")

						arg_247_1:RecordAudio("412021059", var_250_15)
						arg_247_1:RecordAudio("412021059", var_250_15)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_412021", "412021059", "story_v_out_412021.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_412021", "412021059", "story_v_out_412021.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_16 = math.max(var_250_9, arg_247_1.talkMaxDuration)

			if var_250_8 <= arg_247_1.time_ and arg_247_1.time_ < var_250_8 + var_250_16 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_8) / var_250_16

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_8 + var_250_16 and arg_247_1.time_ < var_250_8 + var_250_16 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I09f",
		"TextureConfig/Background/I09g",
		"TextureConfig/Background/EN0105"
	},
	voices = {
		"story_v_out_412021.awb"
	}
}
