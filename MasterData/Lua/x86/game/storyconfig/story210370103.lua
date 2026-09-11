return {
	Play103703001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 103703001
		arg_1_1.duration_ = 6.5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play103703002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST13 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST13")
				var_4_0.name = "ST13"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST13 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST13

				arg_1_1.bgs_.ST13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST13" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_4 = arg_1_1.bgs_.ST13:GetComponent("SpriteRenderer")

				if var_4_4 then
					arg_1_1.var_.alphaOldValueST13 = var_4_4.color.a
					arg_1_1.var_.alphaMatValueST13 = var_4_4
				end

				arg_1_1.var_.alphaOldValueST13 = 0
			end

			local var_4_5 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_5 then
				if arg_1_1.var_.alphaMatValueST13 then
					arg_1_1.var_.alphaMatValueST13.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueST13, 1, (arg_1_1.time_ - 0) / var_4_5)
					arg_1_1.var_.alphaMatValueST13.color = arg_1_1.var_.alphaMatValueST13.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_5 and arg_1_1.time_ < 0 + var_4_5 + arg_4_0 and arg_1_1.var_.alphaMatValueST13 then
				arg_1_1.var_.alphaMatValueST13.color.a = 1
				arg_1_1.var_.alphaMatValueST13.color = arg_1_1.var_.alphaMatValueST13.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_8 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_8 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_8

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_8
						arg_1_1.bgmTxt2_.text = var_4_8
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

			if 1.4 < arg_1_1.time_ and arg_1_1.time_ <= 1.4 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_4_11 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_12 = 1.5
			local var_4_13 = 0.9

			if 1.5 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_14 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_14:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
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

				local var_4_15 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(103703001).content)

				arg_1_1.text_.text = var_4_15

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_17 = 36 <= 0 and var_4_13 or var_4_13 * (utf8.len(var_4_15) / 36)

				if (36 <= 0 and var_4_13 or var_4_13 * (utf8.len(var_4_15) / 36)) > 0 and var_4_13 < var_4_17 then
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
	Play103703002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 103703002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play103703003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.075

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(103703002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 43 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 43)

				if (43 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 43)) > 0 and var_12_0 < var_12_3 then
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
	Play103703003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 103703003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play103703004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 1.05

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(103703003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 42 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 42)

				if (42 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 42)) > 0 and var_16_0 < var_16_3 then
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
	Play103703004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 103703004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play103703005(arg_17_1)
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

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(103703004).content)

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
	Play103703005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 103703005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play103703006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:AudioAction("play", "effect", "se_story_side_1037", "se_story_1037_doorbell", "")
			end

			local var_24_1 = 0
			local var_24_2 = 0.075

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_3 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(103703005).content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 5 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 5)

				if (5 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 5)) > 0 and var_24_2 < var_24_5 then
					arg_21_1.talkMaxDuration = var_24_5

					if var_24_5 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + var_24_1
					end
				end

				arg_21_1.text_.text = var_24_3
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_6 = math.max(var_24_2, arg_21_1.talkMaxDuration)

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_6 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_1) / var_24_6

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_1 + var_24_6 and arg_21_1.time_ < var_24_1 + var_24_6 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play103703006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 103703006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play103703007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.4

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

				local var_28_1 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(103703006).content)

				arg_25_1.text_.text = var_28_1

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_3 = 16 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 16)

				if (16 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 16)) > 0 and var_28_0 < var_28_3 then
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
	Play103703007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 103703007
		arg_29_1.duration_ = 3.17

		local var_29_0 = {
			ja = 3.166,
			ko = 2.533,
			en = 1.999999999999
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
				arg_29_0:Play103703008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.actors_["1037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1037ui_story"))) then
				local var_32_0 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_29_1.stage_.transform)

				var_32_0.name = "1037ui_story"
				var_32_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.actors_["1037ui_story"] = var_32_0

				local var_32_1 = var_32_0:GetComponentInChildren(typeof(CharacterEffect))

				var_32_1.enabled = true

				local var_32_2 = GameObjectTools.GetOrAddComponent(var_32_0, typeof(DynamicBoneHelper))

				if var_32_2 then
					var_32_2:EnableDynamicBone(false)
				end

				arg_29_1:ShowWeapon(var_32_1.transform, false)

				arg_29_1.var_["1037ui_story" .. "Animator"] = var_32_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_29_1.var_["1037ui_story" .. "Animator"].applyRootMotion = true
				arg_29_1.var_["1037ui_story" .. "LipSync"] = var_32_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_32_3 = arg_29_1.actors_["1037ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1037ui_story = var_32_3.localPosition
			end

			local var_32_4 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				var_32_3.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_29_1.time_ - 0) / var_32_4)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				var_32_3.localPosition = Vector3.New(0, -1.09, -5.81)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			local var_32_5 = arg_29_1.actors_["1037ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect1037ui_story == nil then
				arg_29_1.var_.characterEffect1037ui_story = var_32_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_6 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_6 and not isNil(var_32_5) then
				if arg_29_1.var_.characterEffect1037ui_story and not isNil(var_32_5) then
					arg_29_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_6 and arg_29_1.time_ < 0 + var_32_6 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect1037ui_story then
				arg_29_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action4_1")
			end

			local var_32_8 = 0
			local var_32_9 = 0.15

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_10 = arg_29_1:GetWordFromCfg(103703007)
				local var_32_11 = arg_29_1:FormatText(var_32_10.content)

				arg_29_1.text_.text = var_32_11

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_13 = 6 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 6)

				if (6 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 6)) > 0 and var_32_9 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_8
					end
				end

				arg_29_1.text_.text = var_32_11
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703007", "story_v_side_old_103703.awb") ~= 0 then
					local var_32_14 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703007", "story_v_side_old_103703.awb") / 1000

					if var_32_14 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_8
					end

					if var_32_10.prefab_name ~= "" and arg_29_1.actors_[var_32_10.prefab_name] ~= nil then
						local var_32_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_10.prefab_name].transform, "story_v_side_old_103703", "103703007", "story_v_side_old_103703.awb")

						arg_29_1:RecordAudio("103703007", var_32_15)
						arg_29_1:RecordAudio("103703007", var_32_15)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703007", "story_v_side_old_103703.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703007", "story_v_side_old_103703.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_16 = math.max(var_32_9, arg_29_1.talkMaxDuration)

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_16 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_8) / var_32_16

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_8 + var_32_16 and arg_29_1.time_ < var_32_8 + var_32_16 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
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
	Play103703008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 103703008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play103703009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1037ui_story"]) and arg_33_1.var_.characterEffect1037ui_story == nil then
				arg_33_1.var_.characterEffect1037ui_story = arg_33_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1037ui_story"]) then
				if arg_33_1.var_.characterEffect1037ui_story and not isNil(arg_33_1.actors_["1037ui_story"]) then
					arg_33_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1037ui_story"]) and arg_33_1.var_.characterEffect1037ui_story then
				arg_33_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0
			local var_36_2 = 0.525

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
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

				local var_36_3 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(103703008).content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 21 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 21)

				if (21 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 21)) > 0 and var_36_2 < var_36_5 then
					arg_33_1.talkMaxDuration = var_36_5

					if var_36_5 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_6 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_6 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_6

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_6 and arg_33_1.time_ < var_36_1 + var_36_6 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play103703009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 103703009
		arg_37_1.duration_ = 10.23

		local var_37_0 = {
			ja = 10.233,
			ko = 4.2,
			en = 5
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play103703010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1037ui_story"]) and arg_37_1.var_.characterEffect1037ui_story == nil then
				arg_37_1.var_.characterEffect1037ui_story = arg_37_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1037ui_story"]) then
				if arg_37_1.var_.characterEffect1037ui_story and not isNil(arg_37_1.actors_["1037ui_story"]) then
					arg_37_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1037ui_story"]) and arg_37_1.var_.characterEffect1037ui_story then
				arg_37_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action4_2")
			end

			local var_40_2 = 0
			local var_40_3 = 0.325

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_2 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_4 = arg_37_1:GetWordFromCfg(103703009)
				local var_40_5 = arg_37_1:FormatText(var_40_4.content)

				arg_37_1.text_.text = var_40_5

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_7 = 13 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_5) / 13)

				if (13 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_5) / 13)) > 0 and var_40_3 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_2
					end
				end

				arg_37_1.text_.text = var_40_5
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703009", "story_v_side_old_103703.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703009", "story_v_side_old_103703.awb") / 1000

					if var_40_8 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_2
					end

					if var_40_4.prefab_name ~= "" and arg_37_1.actors_[var_40_4.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_4.prefab_name].transform, "story_v_side_old_103703", "103703009", "story_v_side_old_103703.awb")

						arg_37_1:RecordAudio("103703009", var_40_9)
						arg_37_1:RecordAudio("103703009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703009", "story_v_side_old_103703.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703009", "story_v_side_old_103703.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_10 = math.max(var_40_3, arg_37_1.talkMaxDuration)

			if var_40_2 <= arg_37_1.time_ and arg_37_1.time_ < var_40_2 + var_40_10 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_2) / var_40_10

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_2 + var_40_10 and arg_37_1.time_ < var_40_2 + var_40_10 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play103703010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 103703010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play103703011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1037ui_story = arg_41_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1037ui_story"].transform.position).z)
				arg_41_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1037ui_story"].transform.localEulerAngles = arg_41_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_41_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1037ui_story"].transform.position).z)
				arg_41_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1037ui_story"].transform.localEulerAngles = arg_41_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:AudioAction("play", "effect", "se_story_side_1037", "se_story_1037_doorbell02", "")
			end

			local var_44_2 = 0
			local var_44_3 = 0.175

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_2 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_4 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(103703010).content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_6 = 9 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_4) / 9)

				if (9 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_4) / 9)) > 0 and var_44_3 < var_44_6 then
					arg_41_1.talkMaxDuration = var_44_6

					if var_44_6 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_6 + var_44_2
					end
				end

				arg_41_1.text_.text = var_44_4
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_7 = math.max(var_44_3, arg_41_1.talkMaxDuration)

			if var_44_2 <= arg_41_1.time_ and arg_41_1.time_ < var_44_2 + var_44_7 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_2) / var_44_7

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_2 + var_44_7 and arg_41_1.time_ < var_44_2 + var_44_7 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play103703011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 103703011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play103703012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.2

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_1 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(103703011).content)

				arg_45_1.text_.text = var_48_1

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_3 = 8 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 8)

				if (8 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 8)) > 0 and var_48_0 < var_48_3 then
					arg_45_1.talkMaxDuration = var_48_3

					if var_48_3 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_3 + 0
					end
				end

				arg_45_1.text_.text = var_48_1
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_4 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_4

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play103703012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 103703012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play103703013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.825

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_1 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(103703012).content)

				arg_49_1.text_.text = var_52_1

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_3 = 33 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 33)

				if (33 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 33)) > 0 and var_52_0 < var_52_3 then
					arg_49_1.talkMaxDuration = var_52_3

					if var_52_3 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_3 + 0
					end
				end

				arg_49_1.text_.text = var_52_1
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_4 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_4

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play103703013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 103703013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play103703014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.625

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(103703013).content)

				arg_53_1.text_.text = var_56_1

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_3 = 25 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 25)

				if (25 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 25)) > 0 and var_56_0 < var_56_3 then
					arg_53_1.talkMaxDuration = var_56_3

					if var_56_3 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_3 + 0
					end
				end

				arg_53_1.text_.text = var_56_1
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_4 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_4

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play103703014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 103703014
		arg_57_1.duration_ = 3.9

		local var_57_0 = {
			ja = 3.9,
			ko = 2.7,
			en = 2.7
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play103703015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1037ui_story = arg_57_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1037ui_story"].transform.position).z)
				arg_57_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1037ui_story"].transform.localEulerAngles = arg_57_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, -1.09, -5.81)
				arg_57_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1037ui_story"].transform.position).z)
				arg_57_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1037ui_story"].transform.localEulerAngles = arg_57_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["1037ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1037ui_story == nil then
				arg_57_1.var_.characterEffect1037ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect1037ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1037ui_story then
				arg_57_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action1_1")
			end

			local var_60_4 = 0
			local var_60_5 = 0.2

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:GetWordFromCfg(103703014)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 8 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 8)

				if (8 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 8)) > 0 and var_60_5 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703014", "story_v_side_old_103703.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703014", "story_v_side_old_103703.awb") / 1000

					if var_60_10 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_4
					end

					if var_60_6.prefab_name ~= "" and arg_57_1.actors_[var_60_6.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_6.prefab_name].transform, "story_v_side_old_103703", "103703014", "story_v_side_old_103703.awb")

						arg_57_1:RecordAudio("103703014", var_60_11)
						arg_57_1:RecordAudio("103703014", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703014", "story_v_side_old_103703.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703014", "story_v_side_old_103703.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_12 = math.max(var_60_5, arg_57_1.talkMaxDuration)

			if var_60_4 <= arg_57_1.time_ and arg_57_1.time_ < var_60_4 + var_60_12 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_4) / var_60_12

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_4 + var_60_12 and arg_57_1.time_ < var_60_4 + var_60_12 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play103703015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 103703015
		arg_61_1.duration_ = 14

		local var_61_0 = {
			ja = 14,
			ko = 6.566,
			en = 6.166
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play103703016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1037ui_story"]) and arg_61_1.var_.characterEffect1037ui_story == nil then
				arg_61_1.var_.characterEffect1037ui_story = arg_61_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1037ui_story"]) then
				if arg_61_1.var_.characterEffect1037ui_story and not isNil(arg_61_1.actors_["1037ui_story"]) then
					arg_61_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_0)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1037ui_story"]) and arg_61_1.var_.characterEffect1037ui_story then
				arg_61_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_64_1 = 0
			local var_64_2 = 0.825

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_3 = arg_61_1:GetWordFromCfg(103703015)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_6 = 33 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_4) / 33)

				if (33 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_4) / 33)) > 0 and var_64_2 < var_64_6 then
					arg_61_1.talkMaxDuration = var_64_6

					if var_64_6 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_1
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703015", "story_v_side_old_103703.awb") ~= 0 then
					local var_64_7 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703015", "story_v_side_old_103703.awb") / 1000

					if var_64_7 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_1
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_side_old_103703", "103703015", "story_v_side_old_103703.awb")

						arg_61_1:RecordAudio("103703015", var_64_8)
						arg_61_1:RecordAudio("103703015", var_64_8)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703015", "story_v_side_old_103703.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703015", "story_v_side_old_103703.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_9 = math.max(var_64_2, arg_61_1.talkMaxDuration)

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_9 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_1) / var_64_9

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_1 + var_64_9 and arg_61_1.time_ < var_64_1 + var_64_9 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play103703016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 103703016
		arg_65_1.duration_ = 7.43

		local var_65_0 = {
			ja = 6.4,
			ko = 6.433,
			en = 7.433
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
				arg_65_0:Play103703017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1037ui_story"]) and arg_65_1.var_.characterEffect1037ui_story == nil then
				arg_65_1.var_.characterEffect1037ui_story = arg_65_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1037ui_story"]) then
				if arg_65_1.var_.characterEffect1037ui_story and not isNil(arg_65_1.actors_["1037ui_story"]) then
					arg_65_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1037ui_story"]) and arg_65_1.var_.characterEffect1037ui_story then
				arg_65_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_68_2 = 0
			local var_68_3 = 0.725

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_2 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_4 = arg_65_1:GetWordFromCfg(103703016)
				local var_68_5 = arg_65_1:FormatText(var_68_4.content)

				arg_65_1.text_.text = var_68_5

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_7 = 29 <= 0 and var_68_3 or var_68_3 * (utf8.len(var_68_5) / 29)

				if (29 <= 0 and var_68_3 or var_68_3 * (utf8.len(var_68_5) / 29)) > 0 and var_68_3 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_2
					end
				end

				arg_65_1.text_.text = var_68_5
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703016", "story_v_side_old_103703.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703016", "story_v_side_old_103703.awb") / 1000

					if var_68_8 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_2
					end

					if var_68_4.prefab_name ~= "" and arg_65_1.actors_[var_68_4.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_4.prefab_name].transform, "story_v_side_old_103703", "103703016", "story_v_side_old_103703.awb")

						arg_65_1:RecordAudio("103703016", var_68_9)
						arg_65_1:RecordAudio("103703016", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703016", "story_v_side_old_103703.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703016", "story_v_side_old_103703.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_10 = math.max(var_68_3, arg_65_1.talkMaxDuration)

			if var_68_2 <= arg_65_1.time_ and arg_65_1.time_ < var_68_2 + var_68_10 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_2) / var_68_10

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_2 + var_68_10 and arg_65_1.time_ < var_68_2 + var_68_10 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play103703017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 103703017
		arg_69_1.duration_ = 5

		local var_69_0 = {
			ja = 5,
			ko = 4.866,
			en = 3
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
				arg_69_0:Play103703018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1037ui_story"]) and arg_69_1.var_.characterEffect1037ui_story == nil then
				arg_69_1.var_.characterEffect1037ui_story = arg_69_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1037ui_story"]) then
				if arg_69_1.var_.characterEffect1037ui_story and not isNil(arg_69_1.actors_["1037ui_story"]) then
					arg_69_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_0)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1037ui_story"]) and arg_69_1.var_.characterEffect1037ui_story then
				arg_69_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_72_1 = 0
			local var_72_2 = 0.475

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[190].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundeda")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:GetWordFromCfg(103703017)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_6 = 19 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_4) / 19)

				if (19 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_4) / 19)) > 0 and var_72_2 < var_72_6 then
					arg_69_1.talkMaxDuration = var_72_6

					if var_72_6 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_6 + var_72_1
					end
				end

				arg_69_1.text_.text = var_72_4
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703017", "story_v_side_old_103703.awb") ~= 0 then
					local var_72_7 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703017", "story_v_side_old_103703.awb") / 1000

					if var_72_7 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_1
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_side_old_103703", "103703017", "story_v_side_old_103703.awb")

						arg_69_1:RecordAudio("103703017", var_72_8)
						arg_69_1:RecordAudio("103703017", var_72_8)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703017", "story_v_side_old_103703.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703017", "story_v_side_old_103703.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_9 = math.max(var_72_2, arg_69_1.talkMaxDuration)

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_9 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_1) / var_72_9

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_1 + var_72_9 and arg_69_1.time_ < var_72_1 + var_72_9 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play103703018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 103703018
		arg_73_1.duration_ = 4.83

		local var_73_0 = {
			ja = 4.833,
			ko = 4.5,
			en = 3.866
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
				arg_73_0:Play103703019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1037ui_story"]) and arg_73_1.var_.characterEffect1037ui_story == nil then
				arg_73_1.var_.characterEffect1037ui_story = arg_73_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1037ui_story"]) then
				if arg_73_1.var_.characterEffect1037ui_story and not isNil(arg_73_1.actors_["1037ui_story"]) then
					arg_73_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1037ui_story"]) and arg_73_1.var_.characterEffect1037ui_story then
				arg_73_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action1_1")
			end

			local var_76_2 = 0
			local var_76_3 = 0.475

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_4 = arg_73_1:GetWordFromCfg(103703018)
				local var_76_5 = arg_73_1:FormatText(var_76_4.content)

				arg_73_1.text_.text = var_76_5

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_7 = 19 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 19)

				if (19 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 19)) > 0 and var_76_3 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_2
					end
				end

				arg_73_1.text_.text = var_76_5
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703018", "story_v_side_old_103703.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703018", "story_v_side_old_103703.awb") / 1000

					if var_76_8 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_2
					end

					if var_76_4.prefab_name ~= "" and arg_73_1.actors_[var_76_4.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_4.prefab_name].transform, "story_v_side_old_103703", "103703018", "story_v_side_old_103703.awb")

						arg_73_1:RecordAudio("103703018", var_76_9)
						arg_73_1:RecordAudio("103703018", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703018", "story_v_side_old_103703.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703018", "story_v_side_old_103703.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_3, arg_73_1.talkMaxDuration)

			if var_76_2 <= arg_73_1.time_ and arg_73_1.time_ < var_76_2 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_2) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_2 + var_76_10 and arg_73_1.time_ < var_76_2 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play103703019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 103703019
		arg_77_1.duration_ = 5.57

		local var_77_0 = {
			ja = 5.566,
			ko = 4.2,
			en = 3.6
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
				arg_77_0:Play103703020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1037ui_story"]) and arg_77_1.var_.characterEffect1037ui_story == nil then
				arg_77_1.var_.characterEffect1037ui_story = arg_77_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1037ui_story"]) then
				if arg_77_1.var_.characterEffect1037ui_story and not isNil(arg_77_1.actors_["1037ui_story"]) then
					arg_77_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_0)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1037ui_story"]) and arg_77_1.var_.characterEffect1037ui_story then
				arg_77_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_80_1 = 0
			local var_80_2 = 0.5

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[190].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_3 = arg_77_1:GetWordFromCfg(103703019)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_6 = 20 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_4) / 20)

				if (20 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_4) / 20)) > 0 and var_80_2 < var_80_6 then
					arg_77_1.talkMaxDuration = var_80_6

					if var_80_6 + var_80_1 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_6 + var_80_1
					end
				end

				arg_77_1.text_.text = var_80_4
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703019", "story_v_side_old_103703.awb") ~= 0 then
					local var_80_7 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703019", "story_v_side_old_103703.awb") / 1000

					if var_80_7 + var_80_1 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_1
					end

					if var_80_3.prefab_name ~= "" and arg_77_1.actors_[var_80_3.prefab_name] ~= nil then
						local var_80_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_3.prefab_name].transform, "story_v_side_old_103703", "103703019", "story_v_side_old_103703.awb")

						arg_77_1:RecordAudio("103703019", var_80_8)
						arg_77_1:RecordAudio("103703019", var_80_8)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703019", "story_v_side_old_103703.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703019", "story_v_side_old_103703.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_9 = math.max(var_80_2, arg_77_1.talkMaxDuration)

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_9 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_1) / var_80_9

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_1 + var_80_9 and arg_77_1.time_ < var_80_1 + var_80_9 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play103703020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 103703020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play103703021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.8

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_1 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(103703020).content)

				arg_81_1.text_.text = var_84_1

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_3 = 32 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 32)

				if (32 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 32)) > 0 and var_84_0 < var_84_3 then
					arg_81_1.talkMaxDuration = var_84_3

					if var_84_3 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_3 + 0
					end
				end

				arg_81_1.text_.text = var_84_1
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_4 = math.max(var_84_0, arg_81_1.talkMaxDuration)

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - 0) / var_84_4

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play103703021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 103703021
		arg_85_1.duration_ = 8.6

		local var_85_0 = {
			ja = 8.6,
			ko = 7.7,
			en = 5.433
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
				arg_85_0:Play103703022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1037ui_story"]) and arg_85_1.var_.characterEffect1037ui_story == nil then
				arg_85_1.var_.characterEffect1037ui_story = arg_85_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["1037ui_story"]) then
				if arg_85_1.var_.characterEffect1037ui_story and not isNil(arg_85_1.actors_["1037ui_story"]) then
					arg_85_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["1037ui_story"]) and arg_85_1.var_.characterEffect1037ui_story then
				arg_85_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			local var_88_2 = 0
			local var_88_3 = 0.8

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_2 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_4 = arg_85_1:GetWordFromCfg(103703021)
				local var_88_5 = arg_85_1:FormatText(var_88_4.content)

				arg_85_1.text_.text = var_88_5

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_7 = 32 <= 0 and var_88_3 or var_88_3 * (utf8.len(var_88_5) / 32)

				if (32 <= 0 and var_88_3 or var_88_3 * (utf8.len(var_88_5) / 32)) > 0 and var_88_3 < var_88_7 then
					arg_85_1.talkMaxDuration = var_88_7

					if var_88_7 + var_88_2 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_2
					end
				end

				arg_85_1.text_.text = var_88_5
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703021", "story_v_side_old_103703.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703021", "story_v_side_old_103703.awb") / 1000

					if var_88_8 + var_88_2 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_2
					end

					if var_88_4.prefab_name ~= "" and arg_85_1.actors_[var_88_4.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_4.prefab_name].transform, "story_v_side_old_103703", "103703021", "story_v_side_old_103703.awb")

						arg_85_1:RecordAudio("103703021", var_88_9)
						arg_85_1:RecordAudio("103703021", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703021", "story_v_side_old_103703.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703021", "story_v_side_old_103703.awb")
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
	Play103703022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 103703022
		arg_89_1.duration_ = 6.2

		local var_89_0 = {
			ja = 6.2,
			ko = 4.6,
			en = 3.433
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play103703023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1037ui_story"]) and arg_89_1.var_.characterEffect1037ui_story == nil then
				arg_89_1.var_.characterEffect1037ui_story = arg_89_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1037ui_story"]) then
				if arg_89_1.var_.characterEffect1037ui_story and not isNil(arg_89_1.actors_["1037ui_story"]) then
					arg_89_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_0)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1037ui_story"]) and arg_89_1.var_.characterEffect1037ui_story then
				arg_89_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_92_1 = 0
			local var_92_2 = 0.4

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[190].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_3 = arg_89_1:GetWordFromCfg(103703022)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_6 = 16 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_4) / 16)

				if (16 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_4) / 16)) > 0 and var_92_2 < var_92_6 then
					arg_89_1.talkMaxDuration = var_92_6

					if var_92_6 + var_92_1 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_6 + var_92_1
					end
				end

				arg_89_1.text_.text = var_92_4
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703022", "story_v_side_old_103703.awb") ~= 0 then
					local var_92_7 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703022", "story_v_side_old_103703.awb") / 1000

					if var_92_7 + var_92_1 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_1
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_side_old_103703", "103703022", "story_v_side_old_103703.awb")

						arg_89_1:RecordAudio("103703022", var_92_8)
						arg_89_1:RecordAudio("103703022", var_92_8)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703022", "story_v_side_old_103703.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703022", "story_v_side_old_103703.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_9 = math.max(var_92_2, arg_89_1.talkMaxDuration)

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_9 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_1) / var_92_9

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_1 + var_92_9 and arg_89_1.time_ < var_92_1 + var_92_9 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play103703023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 103703023
		arg_93_1.duration_ = 10.3

		local var_93_0 = {
			ja = 10.3,
			ko = 8,
			en = 9.8
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
				arg_93_0:Play103703024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["1037ui_story"]) and arg_93_1.var_.characterEffect1037ui_story == nil then
				arg_93_1.var_.characterEffect1037ui_story = arg_93_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["1037ui_story"]) then
				if arg_93_1.var_.characterEffect1037ui_story and not isNil(arg_93_1.actors_["1037ui_story"]) then
					arg_93_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["1037ui_story"]) and arg_93_1.var_.characterEffect1037ui_story then
				arg_93_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_96_2 = 0
			local var_96_3 = 1.025

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_2 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_4 = arg_93_1:GetWordFromCfg(103703023)
				local var_96_5 = arg_93_1:FormatText(var_96_4.content)

				arg_93_1.text_.text = var_96_5

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_7 = 41 <= 0 and var_96_3 or var_96_3 * (utf8.len(var_96_5) / 41)

				if (41 <= 0 and var_96_3 or var_96_3 * (utf8.len(var_96_5) / 41)) > 0 and var_96_3 < var_96_7 then
					arg_93_1.talkMaxDuration = var_96_7

					if var_96_7 + var_96_2 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_2
					end
				end

				arg_93_1.text_.text = var_96_5
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703023", "story_v_side_old_103703.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703023", "story_v_side_old_103703.awb") / 1000

					if var_96_8 + var_96_2 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_2
					end

					if var_96_4.prefab_name ~= "" and arg_93_1.actors_[var_96_4.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_4.prefab_name].transform, "story_v_side_old_103703", "103703023", "story_v_side_old_103703.awb")

						arg_93_1:RecordAudio("103703023", var_96_9)
						arg_93_1:RecordAudio("103703023", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703023", "story_v_side_old_103703.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703023", "story_v_side_old_103703.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_10 = math.max(var_96_3, arg_93_1.talkMaxDuration)

			if var_96_2 <= arg_93_1.time_ and arg_93_1.time_ < var_96_2 + var_96_10 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_2) / var_96_10

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_2 + var_96_10 and arg_93_1.time_ < var_96_2 + var_96_10 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play103703024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 103703024
		arg_97_1.duration_ = 8.53

		local var_97_0 = {
			ja = 5.7,
			ko = 6.2,
			en = 8.533
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
				arg_97_0:Play103703025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_100_0 = 0
			local var_100_1 = 0.8

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_2 = arg_97_1:GetWordFromCfg(103703024)
				local var_100_3 = arg_97_1:FormatText(var_100_2.content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 32 <= 0 and var_100_1 or var_100_1 * (utf8.len(var_100_3) / 32)

				if (32 <= 0 and var_100_1 or var_100_1 * (utf8.len(var_100_3) / 32)) > 0 and var_100_1 < var_100_5 then
					arg_97_1.talkMaxDuration = var_100_5

					if var_100_5 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_3
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703024", "story_v_side_old_103703.awb") ~= 0 then
					local var_100_6 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703024", "story_v_side_old_103703.awb") / 1000

					if var_100_6 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_6 + var_100_0
					end

					if var_100_2.prefab_name ~= "" and arg_97_1.actors_[var_100_2.prefab_name] ~= nil then
						local var_100_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_2.prefab_name].transform, "story_v_side_old_103703", "103703024", "story_v_side_old_103703.awb")

						arg_97_1:RecordAudio("103703024", var_100_7)
						arg_97_1:RecordAudio("103703024", var_100_7)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703024", "story_v_side_old_103703.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703024", "story_v_side_old_103703.awb")
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
	Play103703025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 103703025
		arg_101_1.duration_ = 6.93

		local var_101_0 = {
			ja = 6.933,
			ko = 3.9,
			en = 2.2
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play103703026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1037ui_story"]) and arg_101_1.var_.characterEffect1037ui_story == nil then
				arg_101_1.var_.characterEffect1037ui_story = arg_101_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1037ui_story"]) then
				if arg_101_1.var_.characterEffect1037ui_story and not isNil(arg_101_1.actors_["1037ui_story"]) then
					arg_101_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_0)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1037ui_story"]) and arg_101_1.var_.characterEffect1037ui_story then
				arg_101_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_104_1 = 0
			local var_104_2 = 0.45

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[190].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_3 = arg_101_1:GetWordFromCfg(103703025)
				local var_104_4 = arg_101_1:FormatText(var_104_3.content)

				arg_101_1.text_.text = var_104_4

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_6 = 18 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_4) / 18)

				if (18 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_4) / 18)) > 0 and var_104_2 < var_104_6 then
					arg_101_1.talkMaxDuration = var_104_6

					if var_104_6 + var_104_1 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_6 + var_104_1
					end
				end

				arg_101_1.text_.text = var_104_4
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703025", "story_v_side_old_103703.awb") ~= 0 then
					local var_104_7 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703025", "story_v_side_old_103703.awb") / 1000

					if var_104_7 + var_104_1 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_1
					end

					if var_104_3.prefab_name ~= "" and arg_101_1.actors_[var_104_3.prefab_name] ~= nil then
						local var_104_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_3.prefab_name].transform, "story_v_side_old_103703", "103703025", "story_v_side_old_103703.awb")

						arg_101_1:RecordAudio("103703025", var_104_8)
						arg_101_1:RecordAudio("103703025", var_104_8)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703025", "story_v_side_old_103703.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703025", "story_v_side_old_103703.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_9 = math.max(var_104_2, arg_101_1.talkMaxDuration)

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_9 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_1) / var_104_9

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_1 + var_104_9 and arg_101_1.time_ < var_104_1 + var_104_9 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play103703026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 103703026
		arg_105_1.duration_ = 12.87

		local var_105_0 = {
			ja = 12.866,
			ko = 12.066,
			en = 12.533
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play103703027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1037ui_story"]) and arg_105_1.var_.characterEffect1037ui_story == nil then
				arg_105_1.var_.characterEffect1037ui_story = arg_105_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1037ui_story"]) then
				if arg_105_1.var_.characterEffect1037ui_story and not isNil(arg_105_1.actors_["1037ui_story"]) then
					arg_105_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1037ui_story"]) and arg_105_1.var_.characterEffect1037ui_story then
				arg_105_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_2")
			end

			local var_108_2 = 0
			local var_108_3 = 1.15

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_2 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_4 = arg_105_1:GetWordFromCfg(103703026)
				local var_108_5 = arg_105_1:FormatText(var_108_4.content)

				arg_105_1.text_.text = var_108_5

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_7 = 46 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_5) / 46)

				if (46 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_5) / 46)) > 0 and var_108_3 < var_108_7 then
					arg_105_1.talkMaxDuration = var_108_7

					if var_108_7 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_2
					end
				end

				arg_105_1.text_.text = var_108_5
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703026", "story_v_side_old_103703.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703026", "story_v_side_old_103703.awb") / 1000

					if var_108_8 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_2
					end

					if var_108_4.prefab_name ~= "" and arg_105_1.actors_[var_108_4.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_4.prefab_name].transform, "story_v_side_old_103703", "103703026", "story_v_side_old_103703.awb")

						arg_105_1:RecordAudio("103703026", var_108_9)
						arg_105_1:RecordAudio("103703026", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703026", "story_v_side_old_103703.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703026", "story_v_side_old_103703.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_10 = math.max(var_108_3, arg_105_1.talkMaxDuration)

			if var_108_2 <= arg_105_1.time_ and arg_105_1.time_ < var_108_2 + var_108_10 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_2) / var_108_10

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_2 + var_108_10 and arg_105_1.time_ < var_108_2 + var_108_10 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play103703027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 103703027
		arg_109_1.duration_ = 11.53

		local var_109_0 = {
			ja = 11.533,
			ko = 8.366,
			en = 8.766
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play103703028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_112_0 = 0
			local var_112_1 = 0.975

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_2 = arg_109_1:GetWordFromCfg(103703027)
				local var_112_3 = arg_109_1:FormatText(var_112_2.content)

				arg_109_1.text_.text = var_112_3

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 39 <= 0 and var_112_1 or var_112_1 * (utf8.len(var_112_3) / 39)

				if (39 <= 0 and var_112_1 or var_112_1 * (utf8.len(var_112_3) / 39)) > 0 and var_112_1 < var_112_5 then
					arg_109_1.talkMaxDuration = var_112_5

					if var_112_5 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + var_112_0
					end
				end

				arg_109_1.text_.text = var_112_3
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703027", "story_v_side_old_103703.awb") ~= 0 then
					local var_112_6 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703027", "story_v_side_old_103703.awb") / 1000

					if var_112_6 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_6 + var_112_0
					end

					if var_112_2.prefab_name ~= "" and arg_109_1.actors_[var_112_2.prefab_name] ~= nil then
						local var_112_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_2.prefab_name].transform, "story_v_side_old_103703", "103703027", "story_v_side_old_103703.awb")

						arg_109_1:RecordAudio("103703027", var_112_7)
						arg_109_1:RecordAudio("103703027", var_112_7)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703027", "story_v_side_old_103703.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703027", "story_v_side_old_103703.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_8 = math.max(var_112_1, arg_109_1.talkMaxDuration)

			if var_112_0 <= arg_109_1.time_ and arg_109_1.time_ < var_112_0 + var_112_8 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_0) / var_112_8

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_0 + var_112_8 and arg_109_1.time_ < var_112_0 + var_112_8 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play103703028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 103703028
		arg_113_1.duration_ = 5.93

		local var_113_0 = {
			ja = 4.4,
			ko = 5.566,
			en = 5.933
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play103703029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1037ui_story"]) and arg_113_1.var_.characterEffect1037ui_story == nil then
				arg_113_1.var_.characterEffect1037ui_story = arg_113_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["1037ui_story"]) then
				if arg_113_1.var_.characterEffect1037ui_story and not isNil(arg_113_1.actors_["1037ui_story"]) then
					arg_113_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_0)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["1037ui_story"]) and arg_113_1.var_.characterEffect1037ui_story then
				arg_113_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_116_1 = 0
			local var_116_2 = 0.775

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[190].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_3 = arg_113_1:GetWordFromCfg(103703028)
				local var_116_4 = arg_113_1:FormatText(var_116_3.content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_6 = 31 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_4) / 31)

				if (31 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_4) / 31)) > 0 and var_116_2 < var_116_6 then
					arg_113_1.talkMaxDuration = var_116_6

					if var_116_6 + var_116_1 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_6 + var_116_1
					end
				end

				arg_113_1.text_.text = var_116_4
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703028", "story_v_side_old_103703.awb") ~= 0 then
					local var_116_7 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703028", "story_v_side_old_103703.awb") / 1000

					if var_116_7 + var_116_1 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_1
					end

					if var_116_3.prefab_name ~= "" and arg_113_1.actors_[var_116_3.prefab_name] ~= nil then
						local var_116_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_3.prefab_name].transform, "story_v_side_old_103703", "103703028", "story_v_side_old_103703.awb")

						arg_113_1:RecordAudio("103703028", var_116_8)
						arg_113_1:RecordAudio("103703028", var_116_8)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703028", "story_v_side_old_103703.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703028", "story_v_side_old_103703.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_9 = math.max(var_116_2, arg_113_1.talkMaxDuration)

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_9 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_1) / var_116_9

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_1 + var_116_9 and arg_113_1.time_ < var_116_1 + var_116_9 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play103703029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 103703029
		arg_117_1.duration_ = 3.67

		local var_117_0 = {
			ja = 3.666,
			ko = 1.999999999999,
			en = 2.6
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
				arg_117_0:Play103703030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["1037ui_story"]) and arg_117_1.var_.characterEffect1037ui_story == nil then
				arg_117_1.var_.characterEffect1037ui_story = arg_117_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["1037ui_story"]) then
				if arg_117_1.var_.characterEffect1037ui_story and not isNil(arg_117_1.actors_["1037ui_story"]) then
					arg_117_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["1037ui_story"]) and arg_117_1.var_.characterEffect1037ui_story then
				arg_117_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_120_2 = 0
			local var_120_3 = 0.075

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_2 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_4 = arg_117_1:GetWordFromCfg(103703029)
				local var_120_5 = arg_117_1:FormatText(var_120_4.content)

				arg_117_1.text_.text = var_120_5

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_7 = 3 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_5) / 3)

				if (3 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_5) / 3)) > 0 and var_120_3 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_2
					end
				end

				arg_117_1.text_.text = var_120_5
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703029", "story_v_side_old_103703.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703029", "story_v_side_old_103703.awb") / 1000

					if var_120_8 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_2
					end

					if var_120_4.prefab_name ~= "" and arg_117_1.actors_[var_120_4.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_4.prefab_name].transform, "story_v_side_old_103703", "103703029", "story_v_side_old_103703.awb")

						arg_117_1:RecordAudio("103703029", var_120_9)
						arg_117_1:RecordAudio("103703029", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703029", "story_v_side_old_103703.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703029", "story_v_side_old_103703.awb")
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
	Play103703030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 103703030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play103703031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["1037ui_story"]) and arg_121_1.var_.characterEffect1037ui_story == nil then
				arg_121_1.var_.characterEffect1037ui_story = arg_121_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["1037ui_story"]) then
				if arg_121_1.var_.characterEffect1037ui_story and not isNil(arg_121_1.actors_["1037ui_story"]) then
					arg_121_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_0)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["1037ui_story"]) and arg_121_1.var_.characterEffect1037ui_story then
				arg_121_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_124_1 = 0
			local var_124_2 = 0.625

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_3 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(103703030).content)

				arg_121_1.text_.text = var_124_3

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 25 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_3) / 25)

				if (25 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_3) / 25)) > 0 and var_124_2 < var_124_5 then
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
	Play103703031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 103703031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play103703032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1037ui_story = arg_125_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1037ui_story"].transform.position).z)
				arg_125_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1037ui_story"].transform.localEulerAngles = arg_125_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_125_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1037ui_story"].transform.position).z)
				arg_125_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1037ui_story"].transform.localEulerAngles = arg_125_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_128_1 = 0
			local var_128_2 = 1

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

				local var_128_3 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(103703031).content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 40 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 40)

				if (40 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 40)) > 0 and var_128_2 < var_128_5 then
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
				actorName = "1037ui_story",
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
	Play103703032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 103703032
		arg_129_1.duration_ = 8.53

		local var_129_0 = {
			ja = 8.533,
			ko = 7.2,
			en = 4.866
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play103703033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0.775

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[190].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_1 = arg_129_1:GetWordFromCfg(103703032)
				local var_132_2 = arg_129_1:FormatText(var_132_1.content)

				arg_129_1.text_.text = var_132_2

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 31 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 31)

				if (31 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 31)) > 0 and var_132_0 < var_132_4 then
					arg_129_1.talkMaxDuration = var_132_4

					if var_132_4 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_4 + 0
					end
				end

				arg_129_1.text_.text = var_132_2
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703032", "story_v_side_old_103703.awb") ~= 0 then
					local var_132_5 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703032", "story_v_side_old_103703.awb") / 1000

					if var_132_5 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + 0
					end

					if var_132_1.prefab_name ~= "" and arg_129_1.actors_[var_132_1.prefab_name] ~= nil then
						local var_132_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_1.prefab_name].transform, "story_v_side_old_103703", "103703032", "story_v_side_old_103703.awb")

						arg_129_1:RecordAudio("103703032", var_132_6)
						arg_129_1:RecordAudio("103703032", var_132_6)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703032", "story_v_side_old_103703.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703032", "story_v_side_old_103703.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_7 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_7 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_7

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_7 and arg_129_1.time_ < 0 + var_132_7 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play103703033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 103703033
		arg_133_1.duration_ = 7.47

		local var_133_0 = {
			ja = 5.8,
			ko = 7.466,
			en = 5.433
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
				arg_133_0:Play103703034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.775

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[190].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_1 = arg_133_1:GetWordFromCfg(103703033)
				local var_136_2 = arg_133_1:FormatText(var_136_1.content)

				arg_133_1.text_.text = var_136_2

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 31 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 31)

				if (31 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 31)) > 0 and var_136_0 < var_136_4 then
					arg_133_1.talkMaxDuration = var_136_4

					if var_136_4 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_4 + 0
					end
				end

				arg_133_1.text_.text = var_136_2
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703033", "story_v_side_old_103703.awb") ~= 0 then
					local var_136_5 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703033", "story_v_side_old_103703.awb") / 1000

					if var_136_5 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + 0
					end

					if var_136_1.prefab_name ~= "" and arg_133_1.actors_[var_136_1.prefab_name] ~= nil then
						local var_136_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_1.prefab_name].transform, "story_v_side_old_103703", "103703033", "story_v_side_old_103703.awb")

						arg_133_1:RecordAudio("103703033", var_136_6)
						arg_133_1:RecordAudio("103703033", var_136_6)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703033", "story_v_side_old_103703.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703033", "story_v_side_old_103703.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_0, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - 0) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_7 and arg_133_1.time_ < 0 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play103703034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 103703034
		arg_137_1.duration_ = 5.73

		local var_137_0 = {
			ja = 5.6,
			ko = 4.733,
			en = 5.733
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play103703035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos1037ui_story = arg_137_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_140_0 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 then
				arg_137_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_137_1.time_ - 0) / var_140_0)
				arg_137_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1037ui_story"].transform.position).z)
				arg_137_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["1037ui_story"].transform.localEulerAngles = arg_137_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 then
				arg_137_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, -1.09, -5.81)
				arg_137_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1037ui_story"].transform.position).z)
				arg_137_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["1037ui_story"].transform.localEulerAngles = arg_137_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_140_1 = arg_137_1.actors_["1037ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect1037ui_story == nil then
				arg_137_1.var_.characterEffect1037ui_story = var_140_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.2

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_2 and not isNil(var_140_1) then
				if arg_137_1.var_.characterEffect1037ui_story and not isNil(var_140_1) then
					arg_137_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_2 and arg_137_1.time_ < 0 + var_140_2 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect1037ui_story then
				arg_137_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			local var_140_4 = 0
			local var_140_5 = 0.65

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_6 = arg_137_1:GetWordFromCfg(103703034)
				local var_140_7 = arg_137_1:FormatText(var_140_6.content)

				arg_137_1.text_.text = var_140_7

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_9 = 26 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 26)

				if (26 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 26)) > 0 and var_140_5 < var_140_9 then
					arg_137_1.talkMaxDuration = var_140_9

					if var_140_9 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_9 + var_140_4
					end
				end

				arg_137_1.text_.text = var_140_7
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703034", "story_v_side_old_103703.awb") ~= 0 then
					local var_140_10 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703034", "story_v_side_old_103703.awb") / 1000

					if var_140_10 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_10 + var_140_4
					end

					if var_140_6.prefab_name ~= "" and arg_137_1.actors_[var_140_6.prefab_name] ~= nil then
						local var_140_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_6.prefab_name].transform, "story_v_side_old_103703", "103703034", "story_v_side_old_103703.awb")

						arg_137_1:RecordAudio("103703034", var_140_11)
						arg_137_1:RecordAudio("103703034", var_140_11)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703034", "story_v_side_old_103703.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703034", "story_v_side_old_103703.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_12 = math.max(var_140_5, arg_137_1.talkMaxDuration)

			if var_140_4 <= arg_137_1.time_ and arg_137_1.time_ < var_140_4 + var_140_12 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_4) / var_140_12

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_4 + var_140_12 and arg_137_1.time_ < var_140_4 + var_140_12 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play103703035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 103703035
		arg_141_1.duration_ = 6.57

		local var_141_0 = {
			ja = 6.4,
			ko = 6.566,
			en = 3.533
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play103703036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_144_0 = 0
			local var_144_1 = 0.7

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_2 = arg_141_1:GetWordFromCfg(103703035)
				local var_144_3 = arg_141_1:FormatText(var_144_2.content)

				arg_141_1.text_.text = var_144_3

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 28 <= 0 and var_144_1 or var_144_1 * (utf8.len(var_144_3) / 28)

				if (28 <= 0 and var_144_1 or var_144_1 * (utf8.len(var_144_3) / 28)) > 0 and var_144_1 < var_144_5 then
					arg_141_1.talkMaxDuration = var_144_5

					if var_144_5 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + var_144_0
					end
				end

				arg_141_1.text_.text = var_144_3
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703035", "story_v_side_old_103703.awb") ~= 0 then
					local var_144_6 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703035", "story_v_side_old_103703.awb") / 1000

					if var_144_6 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_6 + var_144_0
					end

					if var_144_2.prefab_name ~= "" and arg_141_1.actors_[var_144_2.prefab_name] ~= nil then
						local var_144_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_2.prefab_name].transform, "story_v_side_old_103703", "103703035", "story_v_side_old_103703.awb")

						arg_141_1:RecordAudio("103703035", var_144_7)
						arg_141_1:RecordAudio("103703035", var_144_7)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703035", "story_v_side_old_103703.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703035", "story_v_side_old_103703.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_8 = math.max(var_144_1, arg_141_1.talkMaxDuration)

			if var_144_0 <= arg_141_1.time_ and arg_141_1.time_ < var_144_0 + var_144_8 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_0) / var_144_8

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_0 + var_144_8 and arg_141_1.time_ < var_144_0 + var_144_8 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play103703036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 103703036
		arg_145_1.duration_ = 6.53

		local var_145_0 = {
			ja = 6.533,
			ko = 4.433,
			en = 3.333
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
				arg_145_0:Play103703037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["1037ui_story"]) and arg_145_1.var_.characterEffect1037ui_story == nil then
				arg_145_1.var_.characterEffect1037ui_story = arg_145_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_0 = 0.2

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["1037ui_story"]) then
				if arg_145_1.var_.characterEffect1037ui_story and not isNil(arg_145_1.actors_["1037ui_story"]) then
					arg_145_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_0)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["1037ui_story"]) and arg_145_1.var_.characterEffect1037ui_story then
				arg_145_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_148_1 = 0
			local var_148_2 = 0.425

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[190].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_3 = arg_145_1:GetWordFromCfg(103703036)
				local var_148_4 = arg_145_1:FormatText(var_148_3.content)

				arg_145_1.text_.text = var_148_4

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_6 = 17 <= 0 and var_148_2 or var_148_2 * (utf8.len(var_148_4) / 17)

				if (17 <= 0 and var_148_2 or var_148_2 * (utf8.len(var_148_4) / 17)) > 0 and var_148_2 < var_148_6 then
					arg_145_1.talkMaxDuration = var_148_6

					if var_148_6 + var_148_1 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_6 + var_148_1
					end
				end

				arg_145_1.text_.text = var_148_4
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703036", "story_v_side_old_103703.awb") ~= 0 then
					local var_148_7 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703036", "story_v_side_old_103703.awb") / 1000

					if var_148_7 + var_148_1 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_1
					end

					if var_148_3.prefab_name ~= "" and arg_145_1.actors_[var_148_3.prefab_name] ~= nil then
						local var_148_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_3.prefab_name].transform, "story_v_side_old_103703", "103703036", "story_v_side_old_103703.awb")

						arg_145_1:RecordAudio("103703036", var_148_8)
						arg_145_1:RecordAudio("103703036", var_148_8)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703036", "story_v_side_old_103703.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703036", "story_v_side_old_103703.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_9 = math.max(var_148_2, arg_145_1.talkMaxDuration)

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_9 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_1) / var_148_9

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_1 + var_148_9 and arg_145_1.time_ < var_148_1 + var_148_9 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play103703037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 103703037
		arg_149_1.duration_ = 9.8

		local var_149_0 = {
			ja = 9.8,
			ko = 4.7,
			en = 4.5
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
				arg_149_0:Play103703038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["1037ui_story"]) and arg_149_1.var_.characterEffect1037ui_story == nil then
				arg_149_1.var_.characterEffect1037ui_story = arg_149_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_0 = 0.2

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["1037ui_story"]) then
				if arg_149_1.var_.characterEffect1037ui_story and not isNil(arg_149_1.actors_["1037ui_story"]) then
					arg_149_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["1037ui_story"]) and arg_149_1.var_.characterEffect1037ui_story then
				arg_149_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037actionlink/1037action424")
			end

			local var_152_2 = 0
			local var_152_3 = 0.45

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_2 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_4 = arg_149_1:GetWordFromCfg(103703037)
				local var_152_5 = arg_149_1:FormatText(var_152_4.content)

				arg_149_1.text_.text = var_152_5

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_7 = 18 <= 0 and var_152_3 or var_152_3 * (utf8.len(var_152_5) / 18)

				if (18 <= 0 and var_152_3 or var_152_3 * (utf8.len(var_152_5) / 18)) > 0 and var_152_3 < var_152_7 then
					arg_149_1.talkMaxDuration = var_152_7

					if var_152_7 + var_152_2 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_7 + var_152_2
					end
				end

				arg_149_1.text_.text = var_152_5
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703037", "story_v_side_old_103703.awb") ~= 0 then
					local var_152_8 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703037", "story_v_side_old_103703.awb") / 1000

					if var_152_8 + var_152_2 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_8 + var_152_2
					end

					if var_152_4.prefab_name ~= "" and arg_149_1.actors_[var_152_4.prefab_name] ~= nil then
						local var_152_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_4.prefab_name].transform, "story_v_side_old_103703", "103703037", "story_v_side_old_103703.awb")

						arg_149_1:RecordAudio("103703037", var_152_9)
						arg_149_1:RecordAudio("103703037", var_152_9)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703037", "story_v_side_old_103703.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703037", "story_v_side_old_103703.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_10 = math.max(var_152_3, arg_149_1.talkMaxDuration)

			if var_152_2 <= arg_149_1.time_ and arg_149_1.time_ < var_152_2 + var_152_10 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_2) / var_152_10

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_2 + var_152_10 and arg_149_1.time_ < var_152_2 + var_152_10 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play103703038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 103703038
		arg_153_1.duration_ = 7.13

		local var_153_0 = {
			ja = 5.333,
			ko = 6.766,
			en = 7.133
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
				arg_153_0:Play103703039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["1037ui_story"]) and arg_153_1.var_.characterEffect1037ui_story == nil then
				arg_153_1.var_.characterEffect1037ui_story = arg_153_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_0 = 0.2

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["1037ui_story"]) then
				if arg_153_1.var_.characterEffect1037ui_story and not isNil(arg_153_1.actors_["1037ui_story"]) then
					arg_153_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_0)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["1037ui_story"]) and arg_153_1.var_.characterEffect1037ui_story then
				arg_153_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_156_1 = 0
			local var_156_2 = 0.675

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[190].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_3 = arg_153_1:GetWordFromCfg(103703038)
				local var_156_4 = arg_153_1:FormatText(var_156_3.content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_6 = 26 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_4) / 26)

				if (26 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_4) / 26)) > 0 and var_156_2 < var_156_6 then
					arg_153_1.talkMaxDuration = var_156_6

					if var_156_6 + var_156_1 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_6 + var_156_1
					end
				end

				arg_153_1.text_.text = var_156_4
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703038", "story_v_side_old_103703.awb") ~= 0 then
					local var_156_7 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703038", "story_v_side_old_103703.awb") / 1000

					if var_156_7 + var_156_1 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_7 + var_156_1
					end

					if var_156_3.prefab_name ~= "" and arg_153_1.actors_[var_156_3.prefab_name] ~= nil then
						local var_156_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_3.prefab_name].transform, "story_v_side_old_103703", "103703038", "story_v_side_old_103703.awb")

						arg_153_1:RecordAudio("103703038", var_156_8)
						arg_153_1:RecordAudio("103703038", var_156_8)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703038", "story_v_side_old_103703.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703038", "story_v_side_old_103703.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_9 = math.max(var_156_2, arg_153_1.talkMaxDuration)

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_9 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_1) / var_156_9

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_1 + var_156_9 and arg_153_1.time_ < var_156_1 + var_156_9 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play103703039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 103703039
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play103703040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1037ui_story = arg_157_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_160_0 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 then
				arg_157_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_157_1.time_ - 0) / var_160_0)
				arg_157_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1037ui_story"].transform.position).z)
				arg_157_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1037ui_story"].transform.localEulerAngles = arg_157_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 then
				arg_157_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_157_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1037ui_story"].transform.position).z)
				arg_157_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1037ui_story"].transform.localEulerAngles = arg_157_1.actors_["1037ui_story"].transform.localEulerAngles
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

				local var_160_3 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(103703039).content)

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

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play103703040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 103703040
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play103703041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 1.05

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(103703040).content)

				arg_161_1.text_.text = var_164_1

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_3 = 42 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 42)

				if (42 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 42)) > 0 and var_164_0 < var_164_3 then
					arg_161_1.talkMaxDuration = var_164_3

					if var_164_3 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_3 + 0
					end
				end

				arg_161_1.text_.text = var_164_1
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_4 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_4

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play103703041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 103703041
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play103703042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0.825

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_1 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(103703041).content)

				arg_165_1.text_.text = var_168_1

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_3 = 33 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 33)

				if (33 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 33)) > 0 and var_168_0 < var_168_3 then
					arg_165_1.talkMaxDuration = var_168_3

					if var_168_3 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_3 + 0
					end
				end

				arg_165_1.text_.text = var_168_1
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_4 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_4 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_4

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_4 and arg_165_1.time_ < 0 + var_168_4 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play103703042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 103703042
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play103703043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0.425

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

				local var_172_1 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(103703042).content)

				arg_169_1.text_.text = var_172_1

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_3 = 17 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 17)

				if (17 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 17)) > 0 and var_172_0 < var_172_3 then
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
	Play103703043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 103703043
		arg_173_1.duration_ = 5.13

		local var_173_0 = {
			ja = 3.966,
			ko = 5.1,
			en = 5.133
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
				arg_173_0:Play103703044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1037ui_story = arg_173_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_176_0 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 then
				arg_173_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_173_1.time_ - 0) / var_176_0)
				arg_173_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1037ui_story"].transform.position).z)
				arg_173_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1037ui_story"].transform.localEulerAngles = arg_173_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 then
				arg_173_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, -1.09, -5.81)
				arg_173_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1037ui_story"].transform.position).z)
				arg_173_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1037ui_story"].transform.localEulerAngles = arg_173_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_176_1 = arg_173_1.actors_["1037ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1037ui_story == nil then
				arg_173_1.var_.characterEffect1037ui_story = var_176_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.2

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_2 and not isNil(var_176_1) then
				if arg_173_1.var_.characterEffect1037ui_story and not isNil(var_176_1) then
					arg_173_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_2 and arg_173_1.time_ < 0 + var_176_2 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1037ui_story then
				arg_173_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			local var_176_4 = 0
			local var_176_5 = 0.65

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_6 = arg_173_1:GetWordFromCfg(103703043)
				local var_176_7 = arg_173_1:FormatText(var_176_6.content)

				arg_173_1.text_.text = var_176_7

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_9 = 26 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 26)

				if (26 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 26)) > 0 and var_176_5 < var_176_9 then
					arg_173_1.talkMaxDuration = var_176_9

					if var_176_9 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_9 + var_176_4
					end
				end

				arg_173_1.text_.text = var_176_7
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703043", "story_v_side_old_103703.awb") ~= 0 then
					local var_176_10 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703043", "story_v_side_old_103703.awb") / 1000

					if var_176_10 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_10 + var_176_4
					end

					if var_176_6.prefab_name ~= "" and arg_173_1.actors_[var_176_6.prefab_name] ~= nil then
						local var_176_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_6.prefab_name].transform, "story_v_side_old_103703", "103703043", "story_v_side_old_103703.awb")

						arg_173_1:RecordAudio("103703043", var_176_11)
						arg_173_1:RecordAudio("103703043", var_176_11)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703043", "story_v_side_old_103703.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703043", "story_v_side_old_103703.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_12 = math.max(var_176_5, arg_173_1.talkMaxDuration)

			if var_176_4 <= arg_173_1.time_ and arg_173_1.time_ < var_176_4 + var_176_12 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_4) / var_176_12

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_4 + var_176_12 and arg_173_1.time_ < var_176_4 + var_176_12 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play103703044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 103703044
		arg_177_1.duration_ = 7.7

		local var_177_0 = {
			ja = 7.7,
			ko = 6.1,
			en = 5
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
				arg_177_0:Play103703045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_180_0 = 0
			local var_180_1 = 0.75

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_2 = arg_177_1:GetWordFromCfg(103703044)
				local var_180_3 = arg_177_1:FormatText(var_180_2.content)

				arg_177_1.text_.text = var_180_3

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_5 = 30 <= 0 and var_180_1 or var_180_1 * (utf8.len(var_180_3) / 30)

				if (30 <= 0 and var_180_1 or var_180_1 * (utf8.len(var_180_3) / 30)) > 0 and var_180_1 < var_180_5 then
					arg_177_1.talkMaxDuration = var_180_5

					if var_180_5 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + var_180_0
					end
				end

				arg_177_1.text_.text = var_180_3
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703044", "story_v_side_old_103703.awb") ~= 0 then
					local var_180_6 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703044", "story_v_side_old_103703.awb") / 1000

					if var_180_6 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_6 + var_180_0
					end

					if var_180_2.prefab_name ~= "" and arg_177_1.actors_[var_180_2.prefab_name] ~= nil then
						local var_180_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_2.prefab_name].transform, "story_v_side_old_103703", "103703044", "story_v_side_old_103703.awb")

						arg_177_1:RecordAudio("103703044", var_180_7)
						arg_177_1:RecordAudio("103703044", var_180_7)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703044", "story_v_side_old_103703.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703044", "story_v_side_old_103703.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_8 = math.max(var_180_1, arg_177_1.talkMaxDuration)

			if var_180_0 <= arg_177_1.time_ and arg_177_1.time_ < var_180_0 + var_180_8 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_0) / var_180_8

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_0 + var_180_8 and arg_177_1.time_ < var_180_0 + var_180_8 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play103703045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 103703045
		arg_181_1.duration_ = 11.97

		local var_181_0 = {
			ja = 11.966,
			ko = 8.033,
			en = 7.133
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play103703046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_2")
			end

			local var_184_0 = 0
			local var_184_1 = 0.875

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_2 = arg_181_1:GetWordFromCfg(103703045)
				local var_184_3 = arg_181_1:FormatText(var_184_2.content)

				arg_181_1.text_.text = var_184_3

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 35 <= 0 and var_184_1 or var_184_1 * (utf8.len(var_184_3) / 35)

				if (35 <= 0 and var_184_1 or var_184_1 * (utf8.len(var_184_3) / 35)) > 0 and var_184_1 < var_184_5 then
					arg_181_1.talkMaxDuration = var_184_5

					if var_184_5 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + var_184_0
					end
				end

				arg_181_1.text_.text = var_184_3
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703045", "story_v_side_old_103703.awb") ~= 0 then
					local var_184_6 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703045", "story_v_side_old_103703.awb") / 1000

					if var_184_6 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_6 + var_184_0
					end

					if var_184_2.prefab_name ~= "" and arg_181_1.actors_[var_184_2.prefab_name] ~= nil then
						local var_184_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_2.prefab_name].transform, "story_v_side_old_103703", "103703045", "story_v_side_old_103703.awb")

						arg_181_1:RecordAudio("103703045", var_184_7)
						arg_181_1:RecordAudio("103703045", var_184_7)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703045", "story_v_side_old_103703.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703045", "story_v_side_old_103703.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_8 = math.max(var_184_1, arg_181_1.talkMaxDuration)

			if var_184_0 <= arg_181_1.time_ and arg_181_1.time_ < var_184_0 + var_184_8 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_0) / var_184_8

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_0 + var_184_8 and arg_181_1.time_ < var_184_0 + var_184_8 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play103703046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 103703046
		arg_185_1.duration_ = 17.03

		local var_185_0 = {
			ja = 17.033,
			ko = 6.733,
			en = 8.666
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
				arg_185_0:Play103703047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			local var_188_0 = 0
			local var_188_1 = 0.925

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_2 = arg_185_1:GetWordFromCfg(103703046)
				local var_188_3 = arg_185_1:FormatText(var_188_2.content)

				arg_185_1.text_.text = var_188_3

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 37 <= 0 and var_188_1 or var_188_1 * (utf8.len(var_188_3) / 37)

				if (37 <= 0 and var_188_1 or var_188_1 * (utf8.len(var_188_3) / 37)) > 0 and var_188_1 < var_188_5 then
					arg_185_1.talkMaxDuration = var_188_5

					if var_188_5 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_3
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703046", "story_v_side_old_103703.awb") ~= 0 then
					local var_188_6 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703046", "story_v_side_old_103703.awb") / 1000

					if var_188_6 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_6 + var_188_0
					end

					if var_188_2.prefab_name ~= "" and arg_185_1.actors_[var_188_2.prefab_name] ~= nil then
						local var_188_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_2.prefab_name].transform, "story_v_side_old_103703", "103703046", "story_v_side_old_103703.awb")

						arg_185_1:RecordAudio("103703046", var_188_7)
						arg_185_1:RecordAudio("103703046", var_188_7)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703046", "story_v_side_old_103703.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703046", "story_v_side_old_103703.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_8 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_8 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_8

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_8 and arg_185_1.time_ < var_188_0 + var_188_8 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play103703047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 103703047
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play103703048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["1037ui_story"]) and arg_189_1.var_.characterEffect1037ui_story == nil then
				arg_189_1.var_.characterEffect1037ui_story = arg_189_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_0 = 0.2

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["1037ui_story"]) then
				if arg_189_1.var_.characterEffect1037ui_story and not isNil(arg_189_1.actors_["1037ui_story"]) then
					arg_189_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_0)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["1037ui_story"]) and arg_189_1.var_.characterEffect1037ui_story then
				arg_189_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_192_1 = 0
			local var_192_2 = 0.45

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

				local var_192_3 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(103703047).content)

				arg_189_1.text_.text = var_192_3

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 18 <= 0 and var_192_2 or var_192_2 * (utf8.len(var_192_3) / 18)

				if (18 <= 0 and var_192_2 or var_192_2 * (utf8.len(var_192_3) / 18)) > 0 and var_192_2 < var_192_5 then
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
	Play103703048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 103703048
		arg_193_1.duration_ = 2.37

		local var_193_0 = {
			ja = 2.366,
			ko = 2.3,
			en = 1.999999999999
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
				arg_193_0:Play103703049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(arg_193_1.actors_["1037ui_story"]) and arg_193_1.var_.characterEffect1037ui_story == nil then
				arg_193_1.var_.characterEffect1037ui_story = arg_193_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_0 = 0.2

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 and not isNil(arg_193_1.actors_["1037ui_story"]) then
				if arg_193_1.var_.characterEffect1037ui_story and not isNil(arg_193_1.actors_["1037ui_story"]) then
					arg_193_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 and not isNil(arg_193_1.actors_["1037ui_story"]) and arg_193_1.var_.characterEffect1037ui_story then
				arg_193_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_196_2 = 0
			local var_196_3 = 0.35

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_2 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_4 = arg_193_1:GetWordFromCfg(103703048)
				local var_196_5 = arg_193_1:FormatText(var_196_4.content)

				arg_193_1.text_.text = var_196_5

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_7 = 14 <= 0 and var_196_3 or var_196_3 * (utf8.len(var_196_5) / 14)

				if (14 <= 0 and var_196_3 or var_196_3 * (utf8.len(var_196_5) / 14)) > 0 and var_196_3 < var_196_7 then
					arg_193_1.talkMaxDuration = var_196_7

					if var_196_7 + var_196_2 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_7 + var_196_2
					end
				end

				arg_193_1.text_.text = var_196_5
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703048", "story_v_side_old_103703.awb") ~= 0 then
					local var_196_8 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703048", "story_v_side_old_103703.awb") / 1000

					if var_196_8 + var_196_2 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_8 + var_196_2
					end

					if var_196_4.prefab_name ~= "" and arg_193_1.actors_[var_196_4.prefab_name] ~= nil then
						local var_196_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_4.prefab_name].transform, "story_v_side_old_103703", "103703048", "story_v_side_old_103703.awb")

						arg_193_1:RecordAudio("103703048", var_196_9)
						arg_193_1:RecordAudio("103703048", var_196_9)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703048", "story_v_side_old_103703.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703048", "story_v_side_old_103703.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_10 = math.max(var_196_3, arg_193_1.talkMaxDuration)

			if var_196_2 <= arg_193_1.time_ and arg_193_1.time_ < var_196_2 + var_196_10 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_2) / var_196_10

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_2 + var_196_10 and arg_193_1.time_ < var_196_2 + var_196_10 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play103703049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 103703049
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play103703050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["1037ui_story"]) and arg_197_1.var_.characterEffect1037ui_story == nil then
				arg_197_1.var_.characterEffect1037ui_story = arg_197_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_0 = 0.2

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["1037ui_story"]) then
				if arg_197_1.var_.characterEffect1037ui_story and not isNil(arg_197_1.actors_["1037ui_story"]) then
					arg_197_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_0)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["1037ui_story"]) and arg_197_1.var_.characterEffect1037ui_story then
				arg_197_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_200_1 = 0
			local var_200_2 = 1

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_3 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(103703049).content)

				arg_197_1.text_.text = var_200_3

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 40 <= 0 and var_200_2 or var_200_2 * (utf8.len(var_200_3) / 40)

				if (40 <= 0 and var_200_2 or var_200_2 * (utf8.len(var_200_3) / 40)) > 0 and var_200_2 < var_200_5 then
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
	Play103703050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 103703050
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play103703051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0.775

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_1 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(103703050).content)

				arg_201_1.text_.text = var_204_1

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_3 = 31 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 31)

				if (31 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 31)) > 0 and var_204_0 < var_204_3 then
					arg_201_1.talkMaxDuration = var_204_3

					if var_204_3 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_3 + 0
					end
				end

				arg_201_1.text_.text = var_204_1
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_4 = math.max(var_204_0, arg_201_1.talkMaxDuration)

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_4 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - 0) / var_204_4

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= 0 + var_204_4 and arg_201_1.time_ < 0 + var_204_4 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play103703051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 103703051
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play103703052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0.975

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
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

				local var_208_1 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(103703051).content)

				arg_205_1.text_.text = var_208_1

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_3 = 39 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 39)

				if (39 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 39)) > 0 and var_208_0 < var_208_3 then
					arg_205_1.talkMaxDuration = var_208_3

					if var_208_3 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_3 + 0
					end
				end

				arg_205_1.text_.text = var_208_1
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_4 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_4 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_4

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_4 and arg_205_1.time_ < 0 + var_208_4 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play103703052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 103703052
		arg_209_1.duration_ = 9.07

		local var_209_0 = {
			ja = 9.066,
			ko = 6.666,
			en = 6.933
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play103703053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(arg_209_1.actors_["1037ui_story"]) and arg_209_1.var_.characterEffect1037ui_story == nil then
				arg_209_1.var_.characterEffect1037ui_story = arg_209_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_0 = 0.2

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 and not isNil(arg_209_1.actors_["1037ui_story"]) then
				if arg_209_1.var_.characterEffect1037ui_story and not isNil(arg_209_1.actors_["1037ui_story"]) then
					arg_209_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 and not isNil(arg_209_1.actors_["1037ui_story"]) and arg_209_1.var_.characterEffect1037ui_story then
				arg_209_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_2")
			end

			local var_212_2 = 0
			local var_212_3 = 0.675

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_2 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_4 = arg_209_1:GetWordFromCfg(103703052)
				local var_212_5 = arg_209_1:FormatText(var_212_4.content)

				arg_209_1.text_.text = var_212_5

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_7 = 27 <= 0 and var_212_3 or var_212_3 * (utf8.len(var_212_5) / 27)

				if (27 <= 0 and var_212_3 or var_212_3 * (utf8.len(var_212_5) / 27)) > 0 and var_212_3 < var_212_7 then
					arg_209_1.talkMaxDuration = var_212_7

					if var_212_7 + var_212_2 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_7 + var_212_2
					end
				end

				arg_209_1.text_.text = var_212_5
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703052", "story_v_side_old_103703.awb") ~= 0 then
					local var_212_8 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703052", "story_v_side_old_103703.awb") / 1000

					if var_212_8 + var_212_2 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_8 + var_212_2
					end

					if var_212_4.prefab_name ~= "" and arg_209_1.actors_[var_212_4.prefab_name] ~= nil then
						local var_212_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_4.prefab_name].transform, "story_v_side_old_103703", "103703052", "story_v_side_old_103703.awb")

						arg_209_1:RecordAudio("103703052", var_212_9)
						arg_209_1:RecordAudio("103703052", var_212_9)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703052", "story_v_side_old_103703.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703052", "story_v_side_old_103703.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_10 = math.max(var_212_3, arg_209_1.talkMaxDuration)

			if var_212_2 <= arg_209_1.time_ and arg_209_1.time_ < var_212_2 + var_212_10 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_2) / var_212_10

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_2 + var_212_10 and arg_209_1.time_ < var_212_2 + var_212_10 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play103703053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 103703053
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play103703054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(arg_213_1.actors_["1037ui_story"]) and arg_213_1.var_.characterEffect1037ui_story == nil then
				arg_213_1.var_.characterEffect1037ui_story = arg_213_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_0 = 0.2

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 and not isNil(arg_213_1.actors_["1037ui_story"]) then
				if arg_213_1.var_.characterEffect1037ui_story and not isNil(arg_213_1.actors_["1037ui_story"]) then
					arg_213_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 0) / var_216_0)
				end
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 and not isNil(arg_213_1.actors_["1037ui_story"]) and arg_213_1.var_.characterEffect1037ui_story then
				arg_213_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_216_1 = 0
			local var_216_2 = 0.575

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_3 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(103703053).content)

				arg_213_1.text_.text = var_216_3

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_5 = 23 <= 0 and var_216_2 or var_216_2 * (utf8.len(var_216_3) / 23)

				if (23 <= 0 and var_216_2 or var_216_2 * (utf8.len(var_216_3) / 23)) > 0 and var_216_2 < var_216_5 then
					arg_213_1.talkMaxDuration = var_216_5

					if var_216_5 + var_216_1 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_5 + var_216_1
					end
				end

				arg_213_1.text_.text = var_216_3
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_6 = math.max(var_216_2, arg_213_1.talkMaxDuration)

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_6 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_1) / var_216_6

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_1 + var_216_6 and arg_213_1.time_ < var_216_1 + var_216_6 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play103703054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 103703054
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play103703055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0.7

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
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

				local var_220_1 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(103703054).content)

				arg_217_1.text_.text = var_220_1

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_3 = 28 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_1) / 28)

				if (28 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_1) / 28)) > 0 and var_220_0 < var_220_3 then
					arg_217_1.talkMaxDuration = var_220_3

					if var_220_3 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_3 + 0
					end
				end

				arg_217_1.text_.text = var_220_1
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_4 = math.max(var_220_0, arg_217_1.talkMaxDuration)

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_4 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - 0) / var_220_4

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= 0 + var_220_4 and arg_217_1.time_ < 0 + var_220_4 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play103703055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 103703055
		arg_221_1.duration_ = 3.8

		local var_221_0 = {
			ja = 3.8,
			ko = 3.3,
			en = 3.166
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
				arg_221_0:Play103703056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(arg_221_1.actors_["1037ui_story"]) and arg_221_1.var_.characterEffect1037ui_story == nil then
				arg_221_1.var_.characterEffect1037ui_story = arg_221_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_0 = 0.2

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 and not isNil(arg_221_1.actors_["1037ui_story"]) then
				if arg_221_1.var_.characterEffect1037ui_story and not isNil(arg_221_1.actors_["1037ui_story"]) then
					arg_221_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 and not isNil(arg_221_1.actors_["1037ui_story"]) and arg_221_1.var_.characterEffect1037ui_story then
				arg_221_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_224_2 = 0
			local var_224_3 = 0.225

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_2 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_4 = arg_221_1:GetWordFromCfg(103703055)
				local var_224_5 = arg_221_1:FormatText(var_224_4.content)

				arg_221_1.text_.text = var_224_5

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_7 = 9 <= 0 and var_224_3 or var_224_3 * (utf8.len(var_224_5) / 9)

				if (9 <= 0 and var_224_3 or var_224_3 * (utf8.len(var_224_5) / 9)) > 0 and var_224_3 < var_224_7 then
					arg_221_1.talkMaxDuration = var_224_7

					if var_224_7 + var_224_2 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_2
					end
				end

				arg_221_1.text_.text = var_224_5
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703055", "story_v_side_old_103703.awb") ~= 0 then
					local var_224_8 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703055", "story_v_side_old_103703.awb") / 1000

					if var_224_8 + var_224_2 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_8 + var_224_2
					end

					if var_224_4.prefab_name ~= "" and arg_221_1.actors_[var_224_4.prefab_name] ~= nil then
						local var_224_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_4.prefab_name].transform, "story_v_side_old_103703", "103703055", "story_v_side_old_103703.awb")

						arg_221_1:RecordAudio("103703055", var_224_9)
						arg_221_1:RecordAudio("103703055", var_224_9)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703055", "story_v_side_old_103703.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703055", "story_v_side_old_103703.awb")
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
	Play103703056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 103703056
		arg_225_1.duration_ = 7.17

		local var_225_0 = {
			ja = 5.433,
			ko = 7.166,
			en = 7.1
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
				arg_225_0:Play103703057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(arg_225_1.actors_["1037ui_story"]) and arg_225_1.var_.characterEffect1037ui_story == nil then
				arg_225_1.var_.characterEffect1037ui_story = arg_225_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_0 = 0.2

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 and not isNil(arg_225_1.actors_["1037ui_story"]) then
				if arg_225_1.var_.characterEffect1037ui_story and not isNil(arg_225_1.actors_["1037ui_story"]) then
					arg_225_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_0)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 and not isNil(arg_225_1.actors_["1037ui_story"]) and arg_225_1.var_.characterEffect1037ui_story then
				arg_225_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_228_1 = 0
			local var_228_2 = 0.625

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[190].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_3 = arg_225_1:GetWordFromCfg(103703056)
				local var_228_4 = arg_225_1:FormatText(var_228_3.content)

				arg_225_1.text_.text = var_228_4

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_6 = 25 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_4) / 25)

				if (25 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_4) / 25)) > 0 and var_228_2 < var_228_6 then
					arg_225_1.talkMaxDuration = var_228_6

					if var_228_6 + var_228_1 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_6 + var_228_1
					end
				end

				arg_225_1.text_.text = var_228_4
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703056", "story_v_side_old_103703.awb") ~= 0 then
					local var_228_7 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703056", "story_v_side_old_103703.awb") / 1000

					if var_228_7 + var_228_1 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_7 + var_228_1
					end

					if var_228_3.prefab_name ~= "" and arg_225_1.actors_[var_228_3.prefab_name] ~= nil then
						local var_228_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_3.prefab_name].transform, "story_v_side_old_103703", "103703056", "story_v_side_old_103703.awb")

						arg_225_1:RecordAudio("103703056", var_228_8)
						arg_225_1:RecordAudio("103703056", var_228_8)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703056", "story_v_side_old_103703.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703056", "story_v_side_old_103703.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_9 = math.max(var_228_2, arg_225_1.talkMaxDuration)

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_9 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_1) / var_228_9

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_1 + var_228_9 and arg_225_1.time_ < var_228_1 + var_228_9 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play103703057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 103703057
		arg_229_1.duration_ = 11.43

		local var_229_0 = {
			ja = 11.433,
			ko = 8.233,
			en = 9.033
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
				arg_229_0:Play103703058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["1037ui_story"]) and arg_229_1.var_.characterEffect1037ui_story == nil then
				arg_229_1.var_.characterEffect1037ui_story = arg_229_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_0 = 0.2

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["1037ui_story"]) then
				if arg_229_1.var_.characterEffect1037ui_story and not isNil(arg_229_1.actors_["1037ui_story"]) then
					arg_229_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["1037ui_story"]) and arg_229_1.var_.characterEffect1037ui_story then
				arg_229_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_232_2 = 0
			local var_232_3 = 0.95

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_2 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_4 = arg_229_1:GetWordFromCfg(103703057)
				local var_232_5 = arg_229_1:FormatText(var_232_4.content)

				arg_229_1.text_.text = var_232_5

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_7 = 38 <= 0 and var_232_3 or var_232_3 * (utf8.len(var_232_5) / 38)

				if (38 <= 0 and var_232_3 or var_232_3 * (utf8.len(var_232_5) / 38)) > 0 and var_232_3 < var_232_7 then
					arg_229_1.talkMaxDuration = var_232_7

					if var_232_7 + var_232_2 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_7 + var_232_2
					end
				end

				arg_229_1.text_.text = var_232_5
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703057", "story_v_side_old_103703.awb") ~= 0 then
					local var_232_8 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703057", "story_v_side_old_103703.awb") / 1000

					if var_232_8 + var_232_2 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_8 + var_232_2
					end

					if var_232_4.prefab_name ~= "" and arg_229_1.actors_[var_232_4.prefab_name] ~= nil then
						local var_232_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_4.prefab_name].transform, "story_v_side_old_103703", "103703057", "story_v_side_old_103703.awb")

						arg_229_1:RecordAudio("103703057", var_232_9)
						arg_229_1:RecordAudio("103703057", var_232_9)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703057", "story_v_side_old_103703.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703057", "story_v_side_old_103703.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_10 = math.max(var_232_3, arg_229_1.talkMaxDuration)

			if var_232_2 <= arg_229_1.time_ and arg_229_1.time_ < var_232_2 + var_232_10 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_2) / var_232_10

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_2 + var_232_10 and arg_229_1.time_ < var_232_2 + var_232_10 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play103703058 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 103703058
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play103703059(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(arg_233_1.actors_["1037ui_story"]) and arg_233_1.var_.characterEffect1037ui_story == nil then
				arg_233_1.var_.characterEffect1037ui_story = arg_233_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_0 = 0.2

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 and not isNil(arg_233_1.actors_["1037ui_story"]) then
				if arg_233_1.var_.characterEffect1037ui_story and not isNil(arg_233_1.actors_["1037ui_story"]) then
					arg_233_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_0)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 and not isNil(arg_233_1.actors_["1037ui_story"]) and arg_233_1.var_.characterEffect1037ui_story then
				arg_233_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_236_1 = 0
			local var_236_2 = 1.075

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

				local var_236_3 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(103703058).content)

				arg_233_1.text_.text = var_236_3

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_5 = 43 <= 0 and var_236_2 or var_236_2 * (utf8.len(var_236_3) / 43)

				if (43 <= 0 and var_236_2 or var_236_2 * (utf8.len(var_236_3) / 43)) > 0 and var_236_2 < var_236_5 then
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
	Play103703059 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 103703059
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play103703060(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0.85

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_1 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(103703059).content)

				arg_237_1.text_.text = var_240_1

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_3 = 34 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_1) / 34)

				if (34 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_1) / 34)) > 0 and var_240_0 < var_240_3 then
					arg_237_1.talkMaxDuration = var_240_3

					if var_240_3 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_3 + 0
					end
				end

				arg_237_1.text_.text = var_240_1
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_4 = math.max(var_240_0, arg_237_1.talkMaxDuration)

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_4 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - 0) / var_240_4

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= 0 + var_240_4 and arg_237_1.time_ < 0 + var_240_4 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play103703060 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 103703060
		arg_241_1.duration_ = 4.83

		local var_241_0 = {
			ja = 4.833,
			ko = 3.233,
			en = 3.7
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
				arg_241_0:Play103703061(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(arg_241_1.actors_["1037ui_story"]) and arg_241_1.var_.characterEffect1037ui_story == nil then
				arg_241_1.var_.characterEffect1037ui_story = arg_241_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_0 = 0.2

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 and not isNil(arg_241_1.actors_["1037ui_story"]) then
				if arg_241_1.var_.characterEffect1037ui_story and not isNil(arg_241_1.actors_["1037ui_story"]) then
					arg_241_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 and not isNil(arg_241_1.actors_["1037ui_story"]) and arg_241_1.var_.characterEffect1037ui_story then
				arg_241_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action3_1")
			end

			local var_244_2 = 0
			local var_244_3 = 0.35

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_2 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_4 = arg_241_1:GetWordFromCfg(103703060)
				local var_244_5 = arg_241_1:FormatText(var_244_4.content)

				arg_241_1.text_.text = var_244_5

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_7 = 14 <= 0 and var_244_3 or var_244_3 * (utf8.len(var_244_5) / 14)

				if (14 <= 0 and var_244_3 or var_244_3 * (utf8.len(var_244_5) / 14)) > 0 and var_244_3 < var_244_7 then
					arg_241_1.talkMaxDuration = var_244_7

					if var_244_7 + var_244_2 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_7 + var_244_2
					end
				end

				arg_241_1.text_.text = var_244_5
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703060", "story_v_side_old_103703.awb") ~= 0 then
					local var_244_8 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703060", "story_v_side_old_103703.awb") / 1000

					if var_244_8 + var_244_2 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_8 + var_244_2
					end

					if var_244_4.prefab_name ~= "" and arg_241_1.actors_[var_244_4.prefab_name] ~= nil then
						local var_244_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_4.prefab_name].transform, "story_v_side_old_103703", "103703060", "story_v_side_old_103703.awb")

						arg_241_1:RecordAudio("103703060", var_244_9)
						arg_241_1:RecordAudio("103703060", var_244_9)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703060", "story_v_side_old_103703.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703060", "story_v_side_old_103703.awb")
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
	Play103703061 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 103703061
		arg_245_1.duration_ = 14.4

		local var_245_0 = {
			ja = 14.4,
			ko = 8.733,
			en = 7.7
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
				arg_245_0:Play103703062(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_248_0 = 0
			local var_248_1 = 0.975

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_2 = arg_245_1:GetWordFromCfg(103703061)
				local var_248_3 = arg_245_1:FormatText(var_248_2.content)

				arg_245_1.text_.text = var_248_3

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 39 <= 0 and var_248_1 or var_248_1 * (utf8.len(var_248_3) / 39)

				if (39 <= 0 and var_248_1 or var_248_1 * (utf8.len(var_248_3) / 39)) > 0 and var_248_1 < var_248_5 then
					arg_245_1.talkMaxDuration = var_248_5

					if var_248_5 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_5 + var_248_0
					end
				end

				arg_245_1.text_.text = var_248_3
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703061", "story_v_side_old_103703.awb") ~= 0 then
					local var_248_6 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703061", "story_v_side_old_103703.awb") / 1000

					if var_248_6 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_6 + var_248_0
					end

					if var_248_2.prefab_name ~= "" and arg_245_1.actors_[var_248_2.prefab_name] ~= nil then
						local var_248_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_2.prefab_name].transform, "story_v_side_old_103703", "103703061", "story_v_side_old_103703.awb")

						arg_245_1:RecordAudio("103703061", var_248_7)
						arg_245_1:RecordAudio("103703061", var_248_7)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703061", "story_v_side_old_103703.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703061", "story_v_side_old_103703.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_8 = math.max(var_248_1, arg_245_1.talkMaxDuration)

			if var_248_0 <= arg_245_1.time_ and arg_245_1.time_ < var_248_0 + var_248_8 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_0) / var_248_8

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_0 + var_248_8 and arg_245_1.time_ < var_248_0 + var_248_8 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play103703062 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 103703062
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play103703063(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["1037ui_story"]) and arg_249_1.var_.characterEffect1037ui_story == nil then
				arg_249_1.var_.characterEffect1037ui_story = arg_249_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_0 = 0.2

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["1037ui_story"]) then
				if arg_249_1.var_.characterEffect1037ui_story and not isNil(arg_249_1.actors_["1037ui_story"]) then
					arg_249_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_249_1.time_ - 0) / var_252_0)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["1037ui_story"]) and arg_249_1.var_.characterEffect1037ui_story then
				arg_249_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_252_1 = 0
			local var_252_2 = 0.6

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

				local var_252_3 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(103703062).content)

				arg_249_1.text_.text = var_252_3

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_5 = 24 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_3) / 24)

				if (24 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_3) / 24)) > 0 and var_252_2 < var_252_5 then
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
	Play103703063 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 103703063
		arg_253_1.duration_ = 0.17

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"

			SetActive(arg_253_1.choicesGo_, true)

			for iter_254_0, iter_254_1 in ipairs(arg_253_1.choices_) do
				SetActive(iter_254_1.go, iter_254_0 <= 2)
			end

			arg_253_1.choices_[1].txt.text = arg_253_1:FormatText(StoryChoiceCfg[125].name)
			arg_253_1.choices_[2].txt.text = arg_253_1:FormatText(StoryChoiceCfg[126].name)
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play103703064(arg_253_1)
			end

			if arg_255_0 == 2 then
				arg_253_0:Play103703065(arg_253_1)
			end

			arg_253_1:RecordChoiceLog(103703063, 125, 126)
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			return
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play103703064 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 103703064
		arg_257_1.duration_ = 8.6

		local var_257_0 = {
			ja = 8.6,
			ko = 4.1,
			en = 4.3
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
				arg_257_0:Play103703066(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(arg_257_1.actors_["1037ui_story"]) and arg_257_1.var_.characterEffect1037ui_story == nil then
				arg_257_1.var_.characterEffect1037ui_story = arg_257_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_0 = 0.2

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 and not isNil(arg_257_1.actors_["1037ui_story"]) then
				if arg_257_1.var_.characterEffect1037ui_story and not isNil(arg_257_1.actors_["1037ui_story"]) then
					arg_257_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 and not isNil(arg_257_1.actors_["1037ui_story"]) and arg_257_1.var_.characterEffect1037ui_story then
				arg_257_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037actionlink/1037action435")
			end

			local var_260_2 = 0
			local var_260_3 = 0.6

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_2 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_4 = arg_257_1:GetWordFromCfg(103703064)
				local var_260_5 = arg_257_1:FormatText(var_260_4.content)

				arg_257_1.text_.text = var_260_5

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_7 = 24 <= 0 and var_260_3 or var_260_3 * (utf8.len(var_260_5) / 24)

				if (24 <= 0 and var_260_3 or var_260_3 * (utf8.len(var_260_5) / 24)) > 0 and var_260_3 < var_260_7 then
					arg_257_1.talkMaxDuration = var_260_7

					if var_260_7 + var_260_2 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_7 + var_260_2
					end
				end

				arg_257_1.text_.text = var_260_5
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703064", "story_v_side_old_103703.awb") ~= 0 then
					local var_260_8 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703064", "story_v_side_old_103703.awb") / 1000

					if var_260_8 + var_260_2 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_8 + var_260_2
					end

					if var_260_4.prefab_name ~= "" and arg_257_1.actors_[var_260_4.prefab_name] ~= nil then
						local var_260_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_4.prefab_name].transform, "story_v_side_old_103703", "103703064", "story_v_side_old_103703.awb")

						arg_257_1:RecordAudio("103703064", var_260_9)
						arg_257_1:RecordAudio("103703064", var_260_9)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703064", "story_v_side_old_103703.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703064", "story_v_side_old_103703.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_10 = math.max(var_260_3, arg_257_1.talkMaxDuration)

			if var_260_2 <= arg_257_1.time_ and arg_257_1.time_ < var_260_2 + var_260_10 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_2) / var_260_10

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_2 + var_260_10 and arg_257_1.time_ < var_260_2 + var_260_10 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play103703066 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 103703066
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play103703067(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(arg_261_1.actors_["1037ui_story"]) and arg_261_1.var_.characterEffect1037ui_story == nil then
				arg_261_1.var_.characterEffect1037ui_story = arg_261_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_0 = 0.2

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 and not isNil(arg_261_1.actors_["1037ui_story"]) then
				if arg_261_1.var_.characterEffect1037ui_story and not isNil(arg_261_1.actors_["1037ui_story"]) then
					arg_261_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_261_1.time_ - 0) / var_264_0)
				end
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 and not isNil(arg_261_1.actors_["1037ui_story"]) and arg_261_1.var_.characterEffect1037ui_story then
				arg_261_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_264_1 = 0
			local var_264_2 = 0.45

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

				local var_264_3 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(103703066).content)

				arg_261_1.text_.text = var_264_3

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 18 <= 0 and var_264_2 or var_264_2 * (utf8.len(var_264_3) / 18)

				if (18 <= 0 and var_264_2 or var_264_2 * (utf8.len(var_264_3) / 18)) > 0 and var_264_2 < var_264_5 then
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
	Play103703067 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 103703067
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play103703068(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0.45

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_1 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(103703067).content)

				arg_265_1.text_.text = var_268_1

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_3 = 18 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 18)

				if (18 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 18)) > 0 and var_268_0 < var_268_3 then
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
	Play103703068 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 103703068
		arg_269_1.duration_ = 8

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play103703069(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if arg_269_1.bgs_.A00 == nil then
				local var_272_0 = Object.Instantiate(arg_269_1.paintGo_)

				var_272_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "A00")
				var_272_0.name = "A00"
				var_272_0.transform.parent = arg_269_1.stage_.transform
				var_272_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_269_1.bgs_.A00 = var_272_0
			end

			if 1.5 < arg_269_1.time_ and arg_269_1.time_ <= 1.5 + arg_272_0 then
				local var_272_1 = arg_269_1.bgs_.A00

				arg_269_1.bgs_.A00.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_272_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_272_2 = var_272_1:GetComponent("SpriteRenderer")

				if var_272_2 and var_272_2.sprite then
					local var_272_3 = 2 * (var_272_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_272_1.transform.localScale = Vector3.New(var_272_3 / var_272_2.sprite.bounds.size.y < var_272_3 * manager.ui.mainCameraCom_.aspect / var_272_2.sprite.bounds.size.x and var_272_3 * manager.ui.mainCameraCom_.aspect / var_272_2.sprite.bounds.size.x or var_272_3 / var_272_2.sprite.bounds.size.y, var_272_3 / var_272_2.sprite.bounds.size.y < var_272_3 * manager.ui.mainCameraCom_.aspect / var_272_2.sprite.bounds.size.x and var_272_3 * manager.ui.mainCameraCom_.aspect / var_272_2.sprite.bounds.size.x or var_272_3 / var_272_2.sprite.bounds.size.y, 0)
				end

				for iter_272_0, iter_272_1 in pairs(arg_269_1.bgs_) do
					if iter_272_0 ~= "A00" then
						iter_272_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				local var_272_4 = arg_269_1.bgs_.ST13:GetComponent("SpriteRenderer")

				if var_272_4 then
					arg_269_1.var_.alphaOldValueST13 = var_272_4.color.a
					arg_269_1.var_.alphaMatValueST13 = var_272_4
				end

				arg_269_1.var_.alphaOldValueST13 = 1
			end

			local var_272_5 = 1.5

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_5 then
				if arg_269_1.var_.alphaMatValueST13 then
					arg_269_1.var_.alphaMatValueST13.color.a = Mathf.Lerp(arg_269_1.var_.alphaOldValueST13, 0, (arg_269_1.time_ - 0) / var_272_5)
					arg_269_1.var_.alphaMatValueST13.color = arg_269_1.var_.alphaMatValueST13.color
				end
			end

			if arg_269_1.time_ >= 0 + var_272_5 and arg_269_1.time_ < 0 + var_272_5 + arg_272_0 and arg_269_1.var_.alphaMatValueST13 then
				arg_269_1.var_.alphaMatValueST13.color.a = 0
				arg_269_1.var_.alphaMatValueST13.color = arg_269_1.var_.alphaMatValueST13.color
			end

			if 1.5 < arg_269_1.time_ and arg_269_1.time_ <= 1.5 + arg_272_0 then
				local var_272_6 = arg_269_1.bgs_.A00:GetComponent("SpriteRenderer")

				if var_272_6 then
					arg_269_1.var_.alphaOldValueA00 = var_272_6.color.a
					arg_269_1.var_.alphaMatValueA00 = var_272_6
				end

				arg_269_1.var_.alphaOldValueA00 = 0
			end

			local var_272_7 = 1.5

			if 1.5 <= arg_269_1.time_ and arg_269_1.time_ < 1.5 + var_272_7 then
				if arg_269_1.var_.alphaMatValueA00 then
					arg_269_1.var_.alphaMatValueA00.color.a = Mathf.Lerp(arg_269_1.var_.alphaOldValueA00, 1, (arg_269_1.time_ - 1.5) / var_272_7)
					arg_269_1.var_.alphaMatValueA00.color = arg_269_1.var_.alphaMatValueA00.color
				end
			end

			if arg_269_1.time_ >= 1.5 + var_272_7 and arg_269_1.time_ < 1.5 + var_272_7 + arg_272_0 and arg_269_1.var_.alphaMatValueA00 then
				arg_269_1.var_.alphaMatValueA00.color.a = 1
				arg_269_1.var_.alphaMatValueA00.color = arg_269_1.var_.alphaMatValueA00.color
			end

			local var_272_8 = arg_269_1.actors_["1037ui_story"].transform

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos1037ui_story = var_272_8.localPosition
			end

			local var_272_9 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_9 then
				var_272_8.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_269_1.time_ - 0) / var_272_9)
				var_272_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_272_8.position).x, (manager.ui.mainCamera.transform.position - var_272_8.position).y, (manager.ui.mainCamera.transform.position - var_272_8.position).z)
				var_272_8.localEulerAngles.z = 0
				var_272_8.localEulerAngles.x = 0
				var_272_8.localEulerAngles = var_272_8.localEulerAngles
			end

			if arg_269_1.time_ >= 0 + var_272_9 and arg_269_1.time_ < 0 + var_272_9 + arg_272_0 then
				var_272_8.localPosition = Vector3.New(0, 100, 0)
				var_272_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_272_8.position).x, (manager.ui.mainCamera.transform.position - var_272_8.position).y, (manager.ui.mainCamera.transform.position - var_272_8.position).z)
				var_272_8.localEulerAngles.z = 0
				var_272_8.localEulerAngles.x = 0
				var_272_8.localEulerAngles = var_272_8.localEulerAngles
			end

			if arg_269_1.frameCnt_ <= 1 then
				arg_269_1.dialog_:SetActive(false)
			end

			local var_272_10 = 3
			local var_272_11 = 0.7

			if 3 < arg_269_1.time_ and arg_269_1.time_ <= var_272_10 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0

				arg_269_1.dialog_:SetActive(true)

				arg_269_1.dialogCg_.alpha = 0

				local var_272_12 = LeanTween.value(arg_269_1.dialog_, 0, 1, 0.3)

				var_272_12:setOnUpdate(LuaHelper.FloatAction(function(arg_273_0)
					arg_269_1.dialogCg_.alpha = arg_273_0
				end))
				var_272_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_269_1.dialog_)
					var_272_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_269_1.duration_ = arg_269_1.duration_ + 0.3

				SetActive(arg_269_1.leftNameGo_, false)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_13 = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(103703068).content)

				arg_269_1.text_.text = var_272_13

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_15 = 28 <= 0 and var_272_11 or var_272_11 * (utf8.len(var_272_13) / 28)

				if (28 <= 0 and var_272_11 or var_272_11 * (utf8.len(var_272_13) / 28)) > 0 and var_272_11 < var_272_15 then
					arg_269_1.talkMaxDuration = var_272_15
					var_272_10 = var_272_10 + 0.3

					if var_272_15 + var_272_10 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_15 + var_272_10
					end
				end

				arg_269_1.text_.text = var_272_13
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_16 = var_272_10 + 0.3
			local var_272_17 = math.max(var_272_11, arg_269_1.talkMaxDuration)

			if var_272_10 + 0.3 <= arg_269_1.time_ and arg_269_1.time_ < var_272_16 + var_272_17 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_16) / var_272_17

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_16 + var_272_17 and arg_269_1.time_ < var_272_16 + var_272_17 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play103703069 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 103703069
		arg_275_1.duration_ = 1.57

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play103703070(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0.1

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_1 = arg_275_1:GetWordFromCfg(103703069)
				local var_278_2 = arg_275_1:FormatText(var_278_1.content)

				arg_275_1.text_.text = var_278_2

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_4 = 4 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_2) / 4)

				if (4 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_2) / 4)) > 0 and var_278_0 < var_278_4 then
					arg_275_1.talkMaxDuration = var_278_4

					if var_278_4 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_4 + 0
					end
				end

				arg_275_1.text_.text = var_278_2
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703069", "story_v_side_old_103703.awb") ~= 0 then
					local var_278_5 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703069", "story_v_side_old_103703.awb") / 1000

					if var_278_5 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_5 + 0
					end

					if var_278_1.prefab_name ~= "" and arg_275_1.actors_[var_278_1.prefab_name] ~= nil then
						local var_278_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_1.prefab_name].transform, "story_v_side_old_103703", "103703069", "story_v_side_old_103703.awb")

						arg_275_1:RecordAudio("103703069", var_278_6)
						arg_275_1:RecordAudio("103703069", var_278_6)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703069", "story_v_side_old_103703.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703069", "story_v_side_old_103703.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_7 = math.max(var_278_0, arg_275_1.talkMaxDuration)

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_7 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - 0) / var_278_7

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= 0 + var_278_7 and arg_275_1.time_ < 0 + var_278_7 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play103703070 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 103703070
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play103703071(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 0.9

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_1 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(103703070).content)

				arg_279_1.text_.text = var_282_1

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_3 = 36 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_1) / 36)

				if (36 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_1) / 36)) > 0 and var_282_0 < var_282_3 then
					arg_279_1.talkMaxDuration = var_282_3

					if var_282_3 + 0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_3 + 0
					end
				end

				arg_279_1.text_.text = var_282_1
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_4 = math.max(var_282_0, arg_279_1.talkMaxDuration)

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_4 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - 0) / var_282_4

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= 0 + var_282_4 and arg_279_1.time_ < 0 + var_282_4 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play103703071 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 103703071
		arg_283_1.duration_ = 3.57

		local var_283_0 = {
			ja = 3.566,
			ko = 3.133,
			en = 3.3
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play103703072(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if arg_283_1.actors_["1027ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1027ui_story"))) then
				local var_286_0 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_283_1.stage_.transform)

				var_286_0.name = "1027ui_story"
				var_286_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_283_1.actors_["1027ui_story"] = var_286_0

				local var_286_1 = var_286_0:GetComponentInChildren(typeof(CharacterEffect))

				var_286_1.enabled = true

				local var_286_2 = GameObjectTools.GetOrAddComponent(var_286_0, typeof(DynamicBoneHelper))

				if var_286_2 then
					var_286_2:EnableDynamicBone(false)
				end

				arg_283_1:ShowWeapon(var_286_1.transform, false)

				arg_283_1.var_["1027ui_story" .. "Animator"] = var_286_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_283_1.var_["1027ui_story" .. "Animator"].applyRootMotion = true
				arg_283_1.var_["1027ui_story" .. "LipSync"] = var_286_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_286_3 = arg_283_1.actors_["1027ui_story"].transform

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos1027ui_story = var_286_3.localPosition
			end

			local var_286_4 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_4 then
				var_286_3.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_283_1.time_ - 0) / var_286_4)
				var_286_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_286_3.position).x, (manager.ui.mainCamera.transform.position - var_286_3.position).y, (manager.ui.mainCamera.transform.position - var_286_3.position).z)
				var_286_3.localEulerAngles.z = 0
				var_286_3.localEulerAngles.x = 0
				var_286_3.localEulerAngles = var_286_3.localEulerAngles
			end

			if arg_283_1.time_ >= 0 + var_286_4 and arg_283_1.time_ < 0 + var_286_4 + arg_286_0 then
				var_286_3.localPosition = Vector3.New(0, -0.81, -5.8)
				var_286_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_286_3.position).x, (manager.ui.mainCamera.transform.position - var_286_3.position).y, (manager.ui.mainCamera.transform.position - var_286_3.position).z)
				var_286_3.localEulerAngles.z = 0
				var_286_3.localEulerAngles.x = 0
				var_286_3.localEulerAngles = var_286_3.localEulerAngles
			end

			local var_286_5 = arg_283_1.actors_["1027ui_story"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_5) and arg_283_1.var_.characterEffect1027ui_story == nil then
				arg_283_1.var_.characterEffect1027ui_story = var_286_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_6 = 0.2

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_6 and not isNil(var_286_5) then
				if arg_283_1.var_.characterEffect1027ui_story and not isNil(var_286_5) then
					arg_283_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= 0 + var_286_6 and arg_283_1.time_ < 0 + var_286_6 + arg_286_0 and not isNil(var_286_5) and arg_283_1.var_.characterEffect1027ui_story then
				arg_283_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			local var_286_8 = 0
			local var_286_9 = 0.35

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_8 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_10 = arg_283_1:GetWordFromCfg(103703071)
				local var_286_11 = arg_283_1:FormatText(var_286_10.content)

				arg_283_1.text_.text = var_286_11

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_13 = 14 <= 0 and var_286_9 or var_286_9 * (utf8.len(var_286_11) / 14)

				if (14 <= 0 and var_286_9 or var_286_9 * (utf8.len(var_286_11) / 14)) > 0 and var_286_9 < var_286_13 then
					arg_283_1.talkMaxDuration = var_286_13

					if var_286_13 + var_286_8 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_13 + var_286_8
					end
				end

				arg_283_1.text_.text = var_286_11
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703071", "story_v_side_old_103703.awb") ~= 0 then
					local var_286_14 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703071", "story_v_side_old_103703.awb") / 1000

					if var_286_14 + var_286_8 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_14 + var_286_8
					end

					if var_286_10.prefab_name ~= "" and arg_283_1.actors_[var_286_10.prefab_name] ~= nil then
						local var_286_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_10.prefab_name].transform, "story_v_side_old_103703", "103703071", "story_v_side_old_103703.awb")

						arg_283_1:RecordAudio("103703071", var_286_15)
						arg_283_1:RecordAudio("103703071", var_286_15)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703071", "story_v_side_old_103703.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703071", "story_v_side_old_103703.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_16 = math.max(var_286_9, arg_283_1.talkMaxDuration)

			if var_286_8 <= arg_283_1.time_ and arg_283_1.time_ < var_286_8 + var_286_16 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_8) / var_286_16

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_8 + var_286_16 and arg_283_1.time_ < var_286_8 + var_286_16 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_283_1:InitPlayNodeList()
	end,
	Play103703072 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 103703072
		arg_287_1.duration_ = 6.87

		local var_287_0 = {
			ja = 5.8,
			ko = 5.7,
			en = 6.866
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
				arg_287_0:Play103703073(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.var_.moveOldPos1027ui_story = arg_287_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_290_0 = 0.001

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 then
				arg_287_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1027ui_story, Vector3.New(-0.7, -0.81, -5.8), (arg_287_1.time_ - 0) / var_290_0)
				arg_287_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_287_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1027ui_story"].transform.position).z)
				arg_287_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_287_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_287_1.actors_["1027ui_story"].transform.localEulerAngles = arg_287_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 then
				arg_287_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(-0.7, -0.81, -5.8)
				arg_287_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_287_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1027ui_story"].transform.position).z)
				arg_287_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_287_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_287_1.actors_["1027ui_story"].transform.localEulerAngles = arg_287_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_290_1 = "1080ui_story"

			if arg_287_1.actors_["1080ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1080ui_story"))) then
				local var_290_2 = Object.Instantiate(Asset.Load("Char/" .. "1080ui_story"), arg_287_1.stage_.transform)

				var_290_2.name = var_290_1
				var_290_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_287_1.actors_[var_290_1] = var_290_2

				local var_290_3 = var_290_2:GetComponentInChildren(typeof(CharacterEffect))

				var_290_3.enabled = true

				local var_290_4 = GameObjectTools.GetOrAddComponent(var_290_2, typeof(DynamicBoneHelper))

				if var_290_4 then
					var_290_4:EnableDynamicBone(false)
				end

				arg_287_1:ShowWeapon(var_290_3.transform, false)

				arg_287_1.var_[var_290_1 .. "Animator"] = var_290_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_287_1.var_[var_290_1 .. "Animator"].applyRootMotion = true
				arg_287_1.var_[var_290_1 .. "LipSync"] = var_290_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_290_5 = arg_287_1.actors_["1080ui_story"].transform

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.var_.moveOldPos1080ui_story = var_290_5.localPosition
			end

			local var_290_6 = 0.001

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_6 then
				var_290_5.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1080ui_story, Vector3.New(0.7, -1.01, -6.05), (arg_287_1.time_ - 0) / var_290_6)
				var_290_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_290_5.position).x, (manager.ui.mainCamera.transform.position - var_290_5.position).y, (manager.ui.mainCamera.transform.position - var_290_5.position).z)
				var_290_5.localEulerAngles.z = 0
				var_290_5.localEulerAngles.x = 0
				var_290_5.localEulerAngles = var_290_5.localEulerAngles
			end

			if arg_287_1.time_ >= 0 + var_290_6 and arg_287_1.time_ < 0 + var_290_6 + arg_290_0 then
				var_290_5.localPosition = Vector3.New(0.7, -1.01, -6.05)
				var_290_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_290_5.position).x, (manager.ui.mainCamera.transform.position - var_290_5.position).y, (manager.ui.mainCamera.transform.position - var_290_5.position).z)
				var_290_5.localEulerAngles.z = 0
				var_290_5.localEulerAngles.x = 0
				var_290_5.localEulerAngles = var_290_5.localEulerAngles
			end

			local var_290_7 = arg_287_1.actors_["1027ui_story"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_7) and arg_287_1.var_.characterEffect1027ui_story == nil then
				arg_287_1.var_.characterEffect1027ui_story = var_290_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_8 = 0.2

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_8 and not isNil(var_290_7) then
				if arg_287_1.var_.characterEffect1027ui_story and not isNil(var_290_7) then
					arg_287_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_287_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_287_1.time_ - 0) / var_290_8)
				end
			end

			if arg_287_1.time_ >= 0 + var_290_8 and arg_287_1.time_ < 0 + var_290_8 + arg_290_0 and not isNil(var_290_7) and arg_287_1.var_.characterEffect1027ui_story then
				arg_287_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_287_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_290_9 = arg_287_1.actors_["1080ui_story"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_9) and arg_287_1.var_.characterEffect1080ui_story == nil then
				arg_287_1.var_.characterEffect1080ui_story = var_290_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_10 = 0.2

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_10 and not isNil(var_290_9) then
				if arg_287_1.var_.characterEffect1080ui_story and not isNil(var_290_9) then
					arg_287_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= 0 + var_290_10 and arg_287_1.time_ < 0 + var_290_10 + arg_290_0 and not isNil(var_290_9) and arg_287_1.var_.characterEffect1080ui_story then
				arg_287_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_1")
			end

			local var_290_12 = 0
			local var_290_13 = 0.65

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_12 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_14 = arg_287_1:GetWordFromCfg(103703072)
				local var_290_15 = arg_287_1:FormatText(var_290_14.content)

				arg_287_1.text_.text = var_290_15

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_17 = 26 <= 0 and var_290_13 or var_290_13 * (utf8.len(var_290_15) / 26)

				if (26 <= 0 and var_290_13 or var_290_13 * (utf8.len(var_290_15) / 26)) > 0 and var_290_13 < var_290_17 then
					arg_287_1.talkMaxDuration = var_290_17

					if var_290_17 + var_290_12 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_17 + var_290_12
					end
				end

				arg_287_1.text_.text = var_290_15
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703072", "story_v_side_old_103703.awb") ~= 0 then
					local var_290_18 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703072", "story_v_side_old_103703.awb") / 1000

					if var_290_18 + var_290_12 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_18 + var_290_12
					end

					if var_290_14.prefab_name ~= "" and arg_287_1.actors_[var_290_14.prefab_name] ~= nil then
						local var_290_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_14.prefab_name].transform, "story_v_side_old_103703", "103703072", "story_v_side_old_103703.awb")

						arg_287_1:RecordAudio("103703072", var_290_19)
						arg_287_1:RecordAudio("103703072", var_290_19)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703072", "story_v_side_old_103703.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703072", "story_v_side_old_103703.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_20 = math.max(var_290_13, arg_287_1.talkMaxDuration)

			if var_290_12 <= arg_287_1.time_ and arg_287_1.time_ < var_290_12 + var_290_20 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_12) / var_290_20

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_12 + var_290_20 and arg_287_1.time_ < var_290_12 + var_290_20 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play103703073 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 103703073
		arg_291_1.duration_ = 3.97

		local var_291_0 = {
			ja = 3.766,
			ko = 3.7,
			en = 3.966
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play103703074(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos1027ui_story = arg_291_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_294_0 = 0.001

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 then
				arg_291_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_291_1.time_ - 0) / var_294_0)
				arg_291_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_291_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1027ui_story"].transform.position).z)
				arg_291_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_291_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_291_1.actors_["1027ui_story"].transform.localEulerAngles = arg_291_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 then
				arg_291_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_291_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_291_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1027ui_story"].transform.position).z)
				arg_291_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_291_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_291_1.actors_["1027ui_story"].transform.localEulerAngles = arg_291_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_294_1 = arg_291_1.actors_["1080ui_story"].transform

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos1080ui_story = var_294_1.localPosition
			end

			local var_294_2 = 0.001

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_2 then
				var_294_1.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_291_1.time_ - 0) / var_294_2)
				var_294_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_294_1.position).x, (manager.ui.mainCamera.transform.position - var_294_1.position).y, (manager.ui.mainCamera.transform.position - var_294_1.position).z)
				var_294_1.localEulerAngles.z = 0
				var_294_1.localEulerAngles.x = 0
				var_294_1.localEulerAngles = var_294_1.localEulerAngles
			end

			if arg_291_1.time_ >= 0 + var_294_2 and arg_291_1.time_ < 0 + var_294_2 + arg_294_0 then
				var_294_1.localPosition = Vector3.New(0, 100, 0)
				var_294_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_294_1.position).x, (manager.ui.mainCamera.transform.position - var_294_1.position).y, (manager.ui.mainCamera.transform.position - var_294_1.position).z)
				var_294_1.localEulerAngles.z = 0
				var_294_1.localEulerAngles.x = 0
				var_294_1.localEulerAngles = var_294_1.localEulerAngles
			end

			local var_294_3 = arg_291_1.actors_["1037ui_story"].transform

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos1037ui_story = var_294_3.localPosition
			end

			local var_294_4 = 0.001

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_4 then
				var_294_3.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_291_1.time_ - 0) / var_294_4)
				var_294_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_294_3.position).x, (manager.ui.mainCamera.transform.position - var_294_3.position).y, (manager.ui.mainCamera.transform.position - var_294_3.position).z)
				var_294_3.localEulerAngles.z = 0
				var_294_3.localEulerAngles.x = 0
				var_294_3.localEulerAngles = var_294_3.localEulerAngles
			end

			if arg_291_1.time_ >= 0 + var_294_4 and arg_291_1.time_ < 0 + var_294_4 + arg_294_0 then
				var_294_3.localPosition = Vector3.New(0, -1.09, -5.81)
				var_294_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_294_3.position).x, (manager.ui.mainCamera.transform.position - var_294_3.position).y, (manager.ui.mainCamera.transform.position - var_294_3.position).z)
				var_294_3.localEulerAngles.z = 0
				var_294_3.localEulerAngles.x = 0
				var_294_3.localEulerAngles = var_294_3.localEulerAngles
			end

			local var_294_5 = arg_291_1.actors_["1037ui_story"]

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(var_294_5) and arg_291_1.var_.characterEffect1037ui_story == nil then
				arg_291_1.var_.characterEffect1037ui_story = var_294_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_6 = 0.2

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_6 and not isNil(var_294_5) then
				if arg_291_1.var_.characterEffect1037ui_story and not isNil(var_294_5) then
					arg_291_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= 0 + var_294_6 and arg_291_1.time_ < 0 + var_294_6 + arg_294_0 and not isNil(var_294_5) and arg_291_1.var_.characterEffect1037ui_story then
				arg_291_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action3_1")
			end

			local var_294_8 = 0
			local var_294_9 = 0.3

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_8 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_10 = arg_291_1:GetWordFromCfg(103703073)
				local var_294_11 = arg_291_1:FormatText(var_294_10.content)

				arg_291_1.text_.text = var_294_11

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_13 = 12 <= 0 and var_294_9 or var_294_9 * (utf8.len(var_294_11) / 12)

				if (12 <= 0 and var_294_9 or var_294_9 * (utf8.len(var_294_11) / 12)) > 0 and var_294_9 < var_294_13 then
					arg_291_1.talkMaxDuration = var_294_13

					if var_294_13 + var_294_8 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_13 + var_294_8
					end
				end

				arg_291_1.text_.text = var_294_11
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703073", "story_v_side_old_103703.awb") ~= 0 then
					local var_294_14 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703073", "story_v_side_old_103703.awb") / 1000

					if var_294_14 + var_294_8 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_14 + var_294_8
					end

					if var_294_10.prefab_name ~= "" and arg_291_1.actors_[var_294_10.prefab_name] ~= nil then
						local var_294_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_10.prefab_name].transform, "story_v_side_old_103703", "103703073", "story_v_side_old_103703.awb")

						arg_291_1:RecordAudio("103703073", var_294_15)
						arg_291_1:RecordAudio("103703073", var_294_15)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703073", "story_v_side_old_103703.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703073", "story_v_side_old_103703.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_16 = math.max(var_294_9, arg_291_1.talkMaxDuration)

			if var_294_8 <= arg_291_1.time_ and arg_291_1.time_ < var_294_8 + var_294_16 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_8) / var_294_16

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_8 + var_294_16 and arg_291_1.time_ < var_294_8 + var_294_16 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play103703074 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 103703074
		arg_295_1.duration_ = 10.7

		local var_295_0 = {
			ja = 10.7,
			ko = 8.3,
			en = 5.8
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
				arg_295_0:Play103703075(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos1037ui_story = arg_295_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_298_0 = 0.001

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 then
				arg_295_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_295_1.time_ - 0) / var_298_0)
				arg_295_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1037ui_story"].transform.position).z)
				arg_295_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["1037ui_story"].transform.localEulerAngles = arg_295_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 then
				arg_295_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_295_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1037ui_story"].transform.position).z)
				arg_295_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["1037ui_story"].transform.localEulerAngles = arg_295_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_298_1 = arg_295_1.actors_["1027ui_story"].transform

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos1027ui_story = var_298_1.localPosition
			end

			local var_298_2 = 0.001

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_2 then
				var_298_1.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_295_1.time_ - 0) / var_298_2)
				var_298_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_298_1.position).x, (manager.ui.mainCamera.transform.position - var_298_1.position).y, (manager.ui.mainCamera.transform.position - var_298_1.position).z)
				var_298_1.localEulerAngles.z = 0
				var_298_1.localEulerAngles.x = 0
				var_298_1.localEulerAngles = var_298_1.localEulerAngles
			end

			if arg_295_1.time_ >= 0 + var_298_2 and arg_295_1.time_ < 0 + var_298_2 + arg_298_0 then
				var_298_1.localPosition = Vector3.New(0, -0.81, -5.8)
				var_298_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_298_1.position).x, (manager.ui.mainCamera.transform.position - var_298_1.position).y, (manager.ui.mainCamera.transform.position - var_298_1.position).z)
				var_298_1.localEulerAngles.z = 0
				var_298_1.localEulerAngles.x = 0
				var_298_1.localEulerAngles = var_298_1.localEulerAngles
			end

			local var_298_3 = arg_295_1.actors_["1027ui_story"]

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(var_298_3) and arg_295_1.var_.characterEffect1027ui_story == nil then
				arg_295_1.var_.characterEffect1027ui_story = var_298_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_4 = 0.2

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_4 and not isNil(var_298_3) then
				if arg_295_1.var_.characterEffect1027ui_story and not isNil(var_298_3) then
					arg_295_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_295_1.time_ >= 0 + var_298_4 and arg_295_1.time_ < 0 + var_298_4 + arg_298_0 and not isNil(var_298_3) and arg_295_1.var_.characterEffect1027ui_story then
				arg_295_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			local var_298_6 = 0
			local var_298_7 = 0.9

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_6 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_8 = arg_295_1:GetWordFromCfg(103703074)
				local var_298_9 = arg_295_1:FormatText(var_298_8.content)

				arg_295_1.text_.text = var_298_9

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_11 = 36 <= 0 and var_298_7 or var_298_7 * (utf8.len(var_298_9) / 36)

				if (36 <= 0 and var_298_7 or var_298_7 * (utf8.len(var_298_9) / 36)) > 0 and var_298_7 < var_298_11 then
					arg_295_1.talkMaxDuration = var_298_11

					if var_298_11 + var_298_6 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_11 + var_298_6
					end
				end

				arg_295_1.text_.text = var_298_9
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703074", "story_v_side_old_103703.awb") ~= 0 then
					local var_298_12 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703074", "story_v_side_old_103703.awb") / 1000

					if var_298_12 + var_298_6 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_12 + var_298_6
					end

					if var_298_8.prefab_name ~= "" and arg_295_1.actors_[var_298_8.prefab_name] ~= nil then
						local var_298_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_8.prefab_name].transform, "story_v_side_old_103703", "103703074", "story_v_side_old_103703.awb")

						arg_295_1:RecordAudio("103703074", var_298_13)
						arg_295_1:RecordAudio("103703074", var_298_13)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703074", "story_v_side_old_103703.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703074", "story_v_side_old_103703.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_14 = math.max(var_298_7, arg_295_1.talkMaxDuration)

			if var_298_6 <= arg_295_1.time_ and arg_295_1.time_ < var_298_6 + var_298_14 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_6) / var_298_14

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_6 + var_298_14 and arg_295_1.time_ < var_298_6 + var_298_14 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_295_1:InitPlayNodeList()
	end,
	Play103703075 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 103703075
		arg_299_1.duration_ = 9.37

		local var_299_0 = {
			ja = 9.366,
			ko = 5.5,
			en = 3.766
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play103703076(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos1027ui_story = arg_299_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_302_0 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_0 then
				arg_299_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_299_1.time_ - 0) / var_302_0)
				arg_299_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_299_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1027ui_story"].transform.position).z)
				arg_299_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_299_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_299_1.actors_["1027ui_story"].transform.localEulerAngles = arg_299_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_299_1.time_ >= 0 + var_302_0 and arg_299_1.time_ < 0 + var_302_0 + arg_302_0 then
				arg_299_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_299_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_299_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1027ui_story"].transform.position).z)
				arg_299_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_299_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_299_1.actors_["1027ui_story"].transform.localEulerAngles = arg_299_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_302_1 = arg_299_1.actors_["1037ui_story"].transform

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos1037ui_story = var_302_1.localPosition
			end

			local var_302_2 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_2 then
				var_302_1.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_299_1.time_ - 0) / var_302_2)
				var_302_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_302_1.position).x, (manager.ui.mainCamera.transform.position - var_302_1.position).y, (manager.ui.mainCamera.transform.position - var_302_1.position).z)
				var_302_1.localEulerAngles.z = 0
				var_302_1.localEulerAngles.x = 0
				var_302_1.localEulerAngles = var_302_1.localEulerAngles
			end

			if arg_299_1.time_ >= 0 + var_302_2 and arg_299_1.time_ < 0 + var_302_2 + arg_302_0 then
				var_302_1.localPosition = Vector3.New(0, -1.09, -5.81)
				var_302_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_302_1.position).x, (manager.ui.mainCamera.transform.position - var_302_1.position).y, (manager.ui.mainCamera.transform.position - var_302_1.position).z)
				var_302_1.localEulerAngles.z = 0
				var_302_1.localEulerAngles.x = 0
				var_302_1.localEulerAngles = var_302_1.localEulerAngles
			end

			local var_302_3 = arg_299_1.actors_["1037ui_story"]

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(var_302_3) and arg_299_1.var_.characterEffect1037ui_story == nil then
				arg_299_1.var_.characterEffect1037ui_story = var_302_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_4 = 0.2

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_4 and not isNil(var_302_3) then
				if arg_299_1.var_.characterEffect1037ui_story and not isNil(var_302_3) then
					arg_299_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= 0 + var_302_4 and arg_299_1.time_ < 0 + var_302_4 + arg_302_0 and not isNil(var_302_3) and arg_299_1.var_.characterEffect1037ui_story then
				arg_299_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action1_1")
			end

			local var_302_6 = 0
			local var_302_7 = 0.65

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_6 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_8 = arg_299_1:GetWordFromCfg(103703075)
				local var_302_9 = arg_299_1:FormatText(var_302_8.content)

				arg_299_1.text_.text = var_302_9

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_11 = 26 <= 0 and var_302_7 or var_302_7 * (utf8.len(var_302_9) / 26)

				if (26 <= 0 and var_302_7 or var_302_7 * (utf8.len(var_302_9) / 26)) > 0 and var_302_7 < var_302_11 then
					arg_299_1.talkMaxDuration = var_302_11

					if var_302_11 + var_302_6 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_11 + var_302_6
					end
				end

				arg_299_1.text_.text = var_302_9
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703075", "story_v_side_old_103703.awb") ~= 0 then
					local var_302_12 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703075", "story_v_side_old_103703.awb") / 1000

					if var_302_12 + var_302_6 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_12 + var_302_6
					end

					if var_302_8.prefab_name ~= "" and arg_299_1.actors_[var_302_8.prefab_name] ~= nil then
						local var_302_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_8.prefab_name].transform, "story_v_side_old_103703", "103703075", "story_v_side_old_103703.awb")

						arg_299_1:RecordAudio("103703075", var_302_13)
						arg_299_1:RecordAudio("103703075", var_302_13)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703075", "story_v_side_old_103703.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703075", "story_v_side_old_103703.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_14 = math.max(var_302_7, arg_299_1.talkMaxDuration)

			if var_302_6 <= arg_299_1.time_ and arg_299_1.time_ < var_302_6 + var_302_14 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_6) / var_302_14

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_6 + var_302_14 and arg_299_1.time_ < var_302_6 + var_302_14 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play103703076 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 103703076
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play103703077(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos1037ui_story = arg_303_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_306_0 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 then
				arg_303_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_303_1.time_ - 0) / var_306_0)
				arg_303_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_303_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1037ui_story"].transform.position).z)
				arg_303_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_303_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_303_1.actors_["1037ui_story"].transform.localEulerAngles = arg_303_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 then
				arg_303_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_303_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_303_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1037ui_story"].transform.position).z)
				arg_303_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_303_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_303_1.actors_["1037ui_story"].transform.localEulerAngles = arg_303_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_306_1 = 0
			local var_306_2 = 0.725

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_3 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(103703076).content)

				arg_303_1.text_.text = var_306_3

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_5 = 29 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_3) / 29)

				if (29 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_3) / 29)) > 0 and var_306_2 < var_306_5 then
					arg_303_1.talkMaxDuration = var_306_5

					if var_306_5 + var_306_1 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_5 + var_306_1
					end
				end

				arg_303_1.text_.text = var_306_3
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_6 = math.max(var_306_2, arg_303_1.talkMaxDuration)

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_6 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_1) / var_306_6

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_1 + var_306_6 and arg_303_1.time_ < var_306_1 + var_306_6 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_303_1:InitPlayNodeList()
	end,
	Play103703077 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 103703077
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play103703078(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0.425

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, true)
				arg_307_1.iconController_:SetSelectedState("hero")

				arg_307_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_307_1.callingController_:SetSelectedState("normal")

				arg_307_1.keyicon_.color = Color.New(1, 1, 1)
				arg_307_1.icon_.color = Color.New(1, 1, 1)

				local var_310_1 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(103703077).content)

				arg_307_1.text_.text = var_310_1

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_3 = 17 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_1) / 17)

				if (17 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_1) / 17)) > 0 and var_310_0 < var_310_3 then
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
	Play103703078 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 103703078
		arg_311_1.duration_ = 12

		local var_311_0 = {
			ja = 12,
			ko = 4.5,
			en = 4.333
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play103703079(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.var_.moveOldPos1027ui_story = arg_311_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_314_0 = 0.001

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 then
				arg_311_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_311_1.time_ - 0) / var_314_0)
				arg_311_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_311_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1027ui_story"].transform.position).z)
				arg_311_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_311_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_311_1.actors_["1027ui_story"].transform.localEulerAngles = arg_311_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 then
				arg_311_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, -0.81, -5.8)
				arg_311_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_311_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1027ui_story"].transform.position).z)
				arg_311_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_311_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_311_1.actors_["1027ui_story"].transform.localEulerAngles = arg_311_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_314_1 = arg_311_1.actors_["1027ui_story"]

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(var_314_1) and arg_311_1.var_.characterEffect1027ui_story == nil then
				arg_311_1.var_.characterEffect1027ui_story = var_314_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_2 = 0.2

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_2 and not isNil(var_314_1) then
				if arg_311_1.var_.characterEffect1027ui_story and not isNil(var_314_1) then
					arg_311_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= 0 + var_314_2 and arg_311_1.time_ < 0 + var_314_2 + arg_314_0 and not isNil(var_314_1) and arg_311_1.var_.characterEffect1027ui_story then
				arg_311_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action6_1")
			end

			local var_314_4 = 0
			local var_314_5 = 0.5

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_4 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_6 = arg_311_1:GetWordFromCfg(103703078)
				local var_314_7 = arg_311_1:FormatText(var_314_6.content)

				arg_311_1.text_.text = var_314_7

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_9 = 20 <= 0 and var_314_5 or var_314_5 * (utf8.len(var_314_7) / 20)

				if (20 <= 0 and var_314_5 or var_314_5 * (utf8.len(var_314_7) / 20)) > 0 and var_314_5 < var_314_9 then
					arg_311_1.talkMaxDuration = var_314_9

					if var_314_9 + var_314_4 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_9 + var_314_4
					end
				end

				arg_311_1.text_.text = var_314_7
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703078", "story_v_side_old_103703.awb") ~= 0 then
					local var_314_10 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703078", "story_v_side_old_103703.awb") / 1000

					if var_314_10 + var_314_4 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_10 + var_314_4
					end

					if var_314_6.prefab_name ~= "" and arg_311_1.actors_[var_314_6.prefab_name] ~= nil then
						local var_314_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_6.prefab_name].transform, "story_v_side_old_103703", "103703078", "story_v_side_old_103703.awb")

						arg_311_1:RecordAudio("103703078", var_314_11)
						arg_311_1:RecordAudio("103703078", var_314_11)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703078", "story_v_side_old_103703.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703078", "story_v_side_old_103703.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_12 = math.max(var_314_5, arg_311_1.talkMaxDuration)

			if var_314_4 <= arg_311_1.time_ and arg_311_1.time_ < var_314_4 + var_314_12 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_4) / var_314_12

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_4 + var_314_12 and arg_311_1.time_ < var_314_4 + var_314_12 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_311_1:InitPlayNodeList()
	end,
	Play103703079 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 103703079
		arg_315_1.duration_ = 4.43

		local var_315_0 = {
			ja = 4.433,
			ko = 3.266,
			en = 4
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play103703080(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.var_.moveOldPos1027ui_story = arg_315_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_318_0 = 0.001

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 then
				arg_315_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1027ui_story, Vector3.New(-0.7, -0.81, -5.8), (arg_315_1.time_ - 0) / var_318_0)
				arg_315_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_315_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["1027ui_story"].transform.position).z)
				arg_315_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_315_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_315_1.actors_["1027ui_story"].transform.localEulerAngles = arg_315_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 then
				arg_315_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(-0.7, -0.81, -5.8)
				arg_315_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_315_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["1027ui_story"].transform.position).z)
				arg_315_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_315_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_315_1.actors_["1027ui_story"].transform.localEulerAngles = arg_315_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_318_1 = arg_315_1.actors_["1080ui_story"].transform

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.var_.moveOldPos1080ui_story = var_318_1.localPosition
			end

			local var_318_2 = 0.001

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_2 then
				var_318_1.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1080ui_story, Vector3.New(0.7, -1.01, -6.05), (arg_315_1.time_ - 0) / var_318_2)
				var_318_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_318_1.position).x, (manager.ui.mainCamera.transform.position - var_318_1.position).y, (manager.ui.mainCamera.transform.position - var_318_1.position).z)
				var_318_1.localEulerAngles.z = 0
				var_318_1.localEulerAngles.x = 0
				var_318_1.localEulerAngles = var_318_1.localEulerAngles
			end

			if arg_315_1.time_ >= 0 + var_318_2 and arg_315_1.time_ < 0 + var_318_2 + arg_318_0 then
				var_318_1.localPosition = Vector3.New(0.7, -1.01, -6.05)
				var_318_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_318_1.position).x, (manager.ui.mainCamera.transform.position - var_318_1.position).y, (manager.ui.mainCamera.transform.position - var_318_1.position).z)
				var_318_1.localEulerAngles.z = 0
				var_318_1.localEulerAngles.x = 0
				var_318_1.localEulerAngles = var_318_1.localEulerAngles
			end

			local var_318_3 = arg_315_1.actors_["1027ui_story"]

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(var_318_3) and arg_315_1.var_.characterEffect1027ui_story == nil then
				arg_315_1.var_.characterEffect1027ui_story = var_318_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_4 = 0.2

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_4 and not isNil(var_318_3) then
				if arg_315_1.var_.characterEffect1027ui_story and not isNil(var_318_3) then
					arg_315_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_315_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_315_1.time_ - 0) / var_318_4)
				end
			end

			if arg_315_1.time_ >= 0 + var_318_4 and arg_315_1.time_ < 0 + var_318_4 + arg_318_0 and not isNil(var_318_3) and arg_315_1.var_.characterEffect1027ui_story then
				arg_315_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_315_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_318_5 = arg_315_1.actors_["1080ui_story"]

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(var_318_5) and arg_315_1.var_.characterEffect1080ui_story == nil then
				arg_315_1.var_.characterEffect1080ui_story = var_318_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_6 = 0.2

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_6 and not isNil(var_318_5) then
				if arg_315_1.var_.characterEffect1080ui_story and not isNil(var_318_5) then
					arg_315_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_315_1.time_ >= 0 + var_318_6 and arg_315_1.time_ < 0 + var_318_6 + arg_318_0 and not isNil(var_318_5) and arg_315_1.var_.characterEffect1080ui_story then
				arg_315_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_1")
			end

			local var_318_8 = 0
			local var_318_9 = 0.5

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_8 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_10 = arg_315_1:GetWordFromCfg(103703079)
				local var_318_11 = arg_315_1:FormatText(var_318_10.content)

				arg_315_1.text_.text = var_318_11

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_13 = 20 <= 0 and var_318_9 or var_318_9 * (utf8.len(var_318_11) / 20)

				if (20 <= 0 and var_318_9 or var_318_9 * (utf8.len(var_318_11) / 20)) > 0 and var_318_9 < var_318_13 then
					arg_315_1.talkMaxDuration = var_318_13

					if var_318_13 + var_318_8 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_13 + var_318_8
					end
				end

				arg_315_1.text_.text = var_318_11
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703079", "story_v_side_old_103703.awb") ~= 0 then
					local var_318_14 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703079", "story_v_side_old_103703.awb") / 1000

					if var_318_14 + var_318_8 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_14 + var_318_8
					end

					if var_318_10.prefab_name ~= "" and arg_315_1.actors_[var_318_10.prefab_name] ~= nil then
						local var_318_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_10.prefab_name].transform, "story_v_side_old_103703", "103703079", "story_v_side_old_103703.awb")

						arg_315_1:RecordAudio("103703079", var_318_15)
						arg_315_1:RecordAudio("103703079", var_318_15)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703079", "story_v_side_old_103703.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703079", "story_v_side_old_103703.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_16 = math.max(var_318_9, arg_315_1.talkMaxDuration)

			if var_318_8 <= arg_315_1.time_ and arg_315_1.time_ < var_318_8 + var_318_16 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_8) / var_318_16

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_8 + var_318_16 and arg_315_1.time_ < var_318_8 + var_318_16 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_315_1:InitPlayNodeList()
	end,
	Play103703080 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 103703080
		arg_319_1.duration_ = 11.87

		local var_319_0 = {
			ja = 11.866,
			ko = 6.1,
			en = 7.9
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
				arg_319_0:Play103703081(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.var_.moveOldPos1027ui_story = arg_319_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_322_0 = 0.001

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_0 then
				arg_319_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_319_1.time_ - 0) / var_322_0)
				arg_319_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_319_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["1027ui_story"].transform.position).z)
				arg_319_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_319_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_319_1.actors_["1027ui_story"].transform.localEulerAngles = arg_319_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_319_1.time_ >= 0 + var_322_0 and arg_319_1.time_ < 0 + var_322_0 + arg_322_0 then
				arg_319_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_319_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_319_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["1027ui_story"].transform.position).z)
				arg_319_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_319_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_319_1.actors_["1027ui_story"].transform.localEulerAngles = arg_319_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_322_1 = arg_319_1.actors_["1080ui_story"].transform

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.var_.moveOldPos1080ui_story = var_322_1.localPosition
			end

			local var_322_2 = 0.001

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_2 then
				var_322_1.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_319_1.time_ - 0) / var_322_2)
				var_322_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_322_1.position).x, (manager.ui.mainCamera.transform.position - var_322_1.position).y, (manager.ui.mainCamera.transform.position - var_322_1.position).z)
				var_322_1.localEulerAngles.z = 0
				var_322_1.localEulerAngles.x = 0
				var_322_1.localEulerAngles = var_322_1.localEulerAngles
			end

			if arg_319_1.time_ >= 0 + var_322_2 and arg_319_1.time_ < 0 + var_322_2 + arg_322_0 then
				var_322_1.localPosition = Vector3.New(0, 100, 0)
				var_322_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_322_1.position).x, (manager.ui.mainCamera.transform.position - var_322_1.position).y, (manager.ui.mainCamera.transform.position - var_322_1.position).z)
				var_322_1.localEulerAngles.z = 0
				var_322_1.localEulerAngles.x = 0
				var_322_1.localEulerAngles = var_322_1.localEulerAngles
			end

			local var_322_3 = arg_319_1.actors_["1037ui_story"].transform

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.var_.moveOldPos1037ui_story = var_322_3.localPosition
			end

			local var_322_4 = 0.001

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_4 then
				var_322_3.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_319_1.time_ - 0) / var_322_4)
				var_322_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_322_3.position).x, (manager.ui.mainCamera.transform.position - var_322_3.position).y, (manager.ui.mainCamera.transform.position - var_322_3.position).z)
				var_322_3.localEulerAngles.z = 0
				var_322_3.localEulerAngles.x = 0
				var_322_3.localEulerAngles = var_322_3.localEulerAngles
			end

			if arg_319_1.time_ >= 0 + var_322_4 and arg_319_1.time_ < 0 + var_322_4 + arg_322_0 then
				var_322_3.localPosition = Vector3.New(0, -1.09, -5.81)
				var_322_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_322_3.position).x, (manager.ui.mainCamera.transform.position - var_322_3.position).y, (manager.ui.mainCamera.transform.position - var_322_3.position).z)
				var_322_3.localEulerAngles.z = 0
				var_322_3.localEulerAngles.x = 0
				var_322_3.localEulerAngles = var_322_3.localEulerAngles
			end

			local var_322_5 = arg_319_1.actors_["1037ui_story"]

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(var_322_5) and arg_319_1.var_.characterEffect1037ui_story == nil then
				arg_319_1.var_.characterEffect1037ui_story = var_322_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_6 = 0.2

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_6 and not isNil(var_322_5) then
				if arg_319_1.var_.characterEffect1037ui_story and not isNil(var_322_5) then
					arg_319_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_319_1.time_ >= 0 + var_322_6 and arg_319_1.time_ < 0 + var_322_6 + arg_322_0 and not isNil(var_322_5) and arg_319_1.var_.characterEffect1037ui_story then
				arg_319_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action3_1")
			end

			local var_322_8 = 0
			local var_322_9 = 0.75

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_8 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_10 = arg_319_1:GetWordFromCfg(103703080)
				local var_322_11 = arg_319_1:FormatText(var_322_10.content)

				arg_319_1.text_.text = var_322_11

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_13 = 30 <= 0 and var_322_9 or var_322_9 * (utf8.len(var_322_11) / 30)

				if (30 <= 0 and var_322_9 or var_322_9 * (utf8.len(var_322_11) / 30)) > 0 and var_322_9 < var_322_13 then
					arg_319_1.talkMaxDuration = var_322_13

					if var_322_13 + var_322_8 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_13 + var_322_8
					end
				end

				arg_319_1.text_.text = var_322_11
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703080", "story_v_side_old_103703.awb") ~= 0 then
					local var_322_14 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703080", "story_v_side_old_103703.awb") / 1000

					if var_322_14 + var_322_8 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_14 + var_322_8
					end

					if var_322_10.prefab_name ~= "" and arg_319_1.actors_[var_322_10.prefab_name] ~= nil then
						local var_322_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_10.prefab_name].transform, "story_v_side_old_103703", "103703080", "story_v_side_old_103703.awb")

						arg_319_1:RecordAudio("103703080", var_322_15)
						arg_319_1:RecordAudio("103703080", var_322_15)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703080", "story_v_side_old_103703.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703080", "story_v_side_old_103703.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_16 = math.max(var_322_9, arg_319_1.talkMaxDuration)

			if var_322_8 <= arg_319_1.time_ and arg_319_1.time_ < var_322_8 + var_322_16 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_8) / var_322_16

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_8 + var_322_16 and arg_319_1.time_ < var_322_8 + var_322_16 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_319_1:InitPlayNodeList()
	end,
	Play103703081 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 103703081
		arg_323_1.duration_ = 3.6

		local var_323_0 = {
			ja = 3.6,
			ko = 1.999999999999,
			en = 2.133
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
				arg_323_0:Play103703082(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos1037ui_story = arg_323_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_326_0 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 then
				arg_323_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_323_1.time_ - 0) / var_326_0)
				arg_323_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_323_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1037ui_story"].transform.position).z)
				arg_323_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_323_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_323_1.actors_["1037ui_story"].transform.localEulerAngles = arg_323_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 then
				arg_323_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_323_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_323_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1037ui_story"].transform.position).z)
				arg_323_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_323_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_323_1.actors_["1037ui_story"].transform.localEulerAngles = arg_323_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_326_1 = arg_323_1.actors_["1080ui_story"].transform

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos1080ui_story = var_326_1.localPosition
			end

			local var_326_2 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_2 then
				var_326_1.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1080ui_story, Vector3.New(0, -1.01, -6.05), (arg_323_1.time_ - 0) / var_326_2)
				var_326_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_326_1.position).x, (manager.ui.mainCamera.transform.position - var_326_1.position).y, (manager.ui.mainCamera.transform.position - var_326_1.position).z)
				var_326_1.localEulerAngles.z = 0
				var_326_1.localEulerAngles.x = 0
				var_326_1.localEulerAngles = var_326_1.localEulerAngles
			end

			if arg_323_1.time_ >= 0 + var_326_2 and arg_323_1.time_ < 0 + var_326_2 + arg_326_0 then
				var_326_1.localPosition = Vector3.New(0, -1.01, -6.05)
				var_326_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_326_1.position).x, (manager.ui.mainCamera.transform.position - var_326_1.position).y, (manager.ui.mainCamera.transform.position - var_326_1.position).z)
				var_326_1.localEulerAngles.z = 0
				var_326_1.localEulerAngles.x = 0
				var_326_1.localEulerAngles = var_326_1.localEulerAngles
			end

			local var_326_3 = arg_323_1.actors_["1080ui_story"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_3) and arg_323_1.var_.characterEffect1080ui_story == nil then
				arg_323_1.var_.characterEffect1080ui_story = var_326_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_4 = 0.2

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_4 and not isNil(var_326_3) then
				if arg_323_1.var_.characterEffect1080ui_story and not isNil(var_326_3) then
					arg_323_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= 0 + var_326_4 and arg_323_1.time_ < 0 + var_326_4 + arg_326_0 and not isNil(var_326_3) and arg_323_1.var_.characterEffect1080ui_story then
				arg_323_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action5_1")
			end

			local var_326_6 = 0
			local var_326_7 = 0.25

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_6 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_8 = arg_323_1:GetWordFromCfg(103703081)
				local var_326_9 = arg_323_1:FormatText(var_326_8.content)

				arg_323_1.text_.text = var_326_9

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_11 = 10 <= 0 and var_326_7 or var_326_7 * (utf8.len(var_326_9) / 10)

				if (10 <= 0 and var_326_7 or var_326_7 * (utf8.len(var_326_9) / 10)) > 0 and var_326_7 < var_326_11 then
					arg_323_1.talkMaxDuration = var_326_11

					if var_326_11 + var_326_6 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_11 + var_326_6
					end
				end

				arg_323_1.text_.text = var_326_9
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703081", "story_v_side_old_103703.awb") ~= 0 then
					local var_326_12 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703081", "story_v_side_old_103703.awb") / 1000

					if var_326_12 + var_326_6 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_12 + var_326_6
					end

					if var_326_8.prefab_name ~= "" and arg_323_1.actors_[var_326_8.prefab_name] ~= nil then
						local var_326_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_8.prefab_name].transform, "story_v_side_old_103703", "103703081", "story_v_side_old_103703.awb")

						arg_323_1:RecordAudio("103703081", var_326_13)
						arg_323_1:RecordAudio("103703081", var_326_13)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703081", "story_v_side_old_103703.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703081", "story_v_side_old_103703.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_14 = math.max(var_326_7, arg_323_1.talkMaxDuration)

			if var_326_6 <= arg_323_1.time_ and arg_323_1.time_ < var_326_6 + var_326_14 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_6) / var_326_14

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_6 + var_326_14 and arg_323_1.time_ < var_326_6 + var_326_14 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play103703082 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 103703082
		arg_327_1.duration_ = 3.9

		local var_327_0 = {
			ja = 3.9,
			ko = 1.999999999999,
			en = 1.999999999999
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play103703083(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.var_.moveOldPos1080ui_story = arg_327_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_330_0 = 0.001

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 then
				arg_327_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_327_1.time_ - 0) / var_330_0)
				arg_327_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_327_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["1080ui_story"].transform.position).z)
				arg_327_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_327_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_327_1.actors_["1080ui_story"].transform.localEulerAngles = arg_327_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 then
				arg_327_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_327_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_327_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["1080ui_story"].transform.position).z)
				arg_327_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_327_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_327_1.actors_["1080ui_story"].transform.localEulerAngles = arg_327_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_330_1 = arg_327_1.actors_["1037ui_story"].transform

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.var_.moveOldPos1037ui_story = var_330_1.localPosition
			end

			local var_330_2 = 0.001

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_2 then
				var_330_1.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_327_1.time_ - 0) / var_330_2)
				var_330_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_330_1.position).x, (manager.ui.mainCamera.transform.position - var_330_1.position).y, (manager.ui.mainCamera.transform.position - var_330_1.position).z)
				var_330_1.localEulerAngles.z = 0
				var_330_1.localEulerAngles.x = 0
				var_330_1.localEulerAngles = var_330_1.localEulerAngles
			end

			if arg_327_1.time_ >= 0 + var_330_2 and arg_327_1.time_ < 0 + var_330_2 + arg_330_0 then
				var_330_1.localPosition = Vector3.New(0, -1.09, -5.81)
				var_330_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_330_1.position).x, (manager.ui.mainCamera.transform.position - var_330_1.position).y, (manager.ui.mainCamera.transform.position - var_330_1.position).z)
				var_330_1.localEulerAngles.z = 0
				var_330_1.localEulerAngles.x = 0
				var_330_1.localEulerAngles = var_330_1.localEulerAngles
			end

			local var_330_3 = arg_327_1.actors_["1037ui_story"]

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(var_330_3) and arg_327_1.var_.characterEffect1037ui_story == nil then
				arg_327_1.var_.characterEffect1037ui_story = var_330_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_4 = 0.2

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_4 and not isNil(var_330_3) then
				if arg_327_1.var_.characterEffect1037ui_story and not isNil(var_330_3) then
					arg_327_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_327_1.time_ >= 0 + var_330_4 and arg_327_1.time_ < 0 + var_330_4 + arg_330_0 and not isNil(var_330_3) and arg_327_1.var_.characterEffect1037ui_story then
				arg_327_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action4_1")
			end

			local var_330_6 = 0
			local var_330_7 = 0.075

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_6 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_8 = arg_327_1:GetWordFromCfg(103703082)
				local var_330_9 = arg_327_1:FormatText(var_330_8.content)

				arg_327_1.text_.text = var_330_9

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_11 = 3 <= 0 and var_330_7 or var_330_7 * (utf8.len(var_330_9) / 3)

				if (3 <= 0 and var_330_7 or var_330_7 * (utf8.len(var_330_9) / 3)) > 0 and var_330_7 < var_330_11 then
					arg_327_1.talkMaxDuration = var_330_11

					if var_330_11 + var_330_6 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_11 + var_330_6
					end
				end

				arg_327_1.text_.text = var_330_9
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703082", "story_v_side_old_103703.awb") ~= 0 then
					local var_330_12 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703082", "story_v_side_old_103703.awb") / 1000

					if var_330_12 + var_330_6 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_12 + var_330_6
					end

					if var_330_8.prefab_name ~= "" and arg_327_1.actors_[var_330_8.prefab_name] ~= nil then
						local var_330_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_8.prefab_name].transform, "story_v_side_old_103703", "103703082", "story_v_side_old_103703.awb")

						arg_327_1:RecordAudio("103703082", var_330_13)
						arg_327_1:RecordAudio("103703082", var_330_13)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703082", "story_v_side_old_103703.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703082", "story_v_side_old_103703.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_14 = math.max(var_330_7, arg_327_1.talkMaxDuration)

			if var_330_6 <= arg_327_1.time_ and arg_327_1.time_ < var_330_6 + var_330_14 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_6) / var_330_14

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_6 + var_330_14 and arg_327_1.time_ < var_330_6 + var_330_14 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_327_1:InitPlayNodeList()
	end,
	Play103703083 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 103703083
		arg_331_1.duration_ = 6.4

		local var_331_0 = {
			ja = 6.4,
			ko = 4.466,
			en = 3
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
				arg_331_0:Play103703084(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.var_.moveOldPos1037ui_story = arg_331_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_334_0 = 0.001

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 then
				arg_331_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_331_1.time_ - 0) / var_334_0)
				arg_331_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_331_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1037ui_story"].transform.position).z)
				arg_331_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_331_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_331_1.actors_["1037ui_story"].transform.localEulerAngles = arg_331_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 then
				arg_331_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_331_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_331_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1037ui_story"].transform.position).z)
				arg_331_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_331_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_331_1.actors_["1037ui_story"].transform.localEulerAngles = arg_331_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_334_1 = arg_331_1.actors_["1080ui_story"].transform

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.var_.moveOldPos1080ui_story = var_334_1.localPosition
			end

			local var_334_2 = 0.001

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_2 then
				var_334_1.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos1080ui_story, Vector3.New(0, -1.01, -6.05), (arg_331_1.time_ - 0) / var_334_2)
				var_334_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_334_1.position).x, (manager.ui.mainCamera.transform.position - var_334_1.position).y, (manager.ui.mainCamera.transform.position - var_334_1.position).z)
				var_334_1.localEulerAngles.z = 0
				var_334_1.localEulerAngles.x = 0
				var_334_1.localEulerAngles = var_334_1.localEulerAngles
			end

			if arg_331_1.time_ >= 0 + var_334_2 and arg_331_1.time_ < 0 + var_334_2 + arg_334_0 then
				var_334_1.localPosition = Vector3.New(0, -1.01, -6.05)
				var_334_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_334_1.position).x, (manager.ui.mainCamera.transform.position - var_334_1.position).y, (manager.ui.mainCamera.transform.position - var_334_1.position).z)
				var_334_1.localEulerAngles.z = 0
				var_334_1.localEulerAngles.x = 0
				var_334_1.localEulerAngles = var_334_1.localEulerAngles
			end

			local var_334_3 = arg_331_1.actors_["1080ui_story"]

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(var_334_3) and arg_331_1.var_.characterEffect1080ui_story == nil then
				arg_331_1.var_.characterEffect1080ui_story = var_334_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_4 = 0.2

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_4 and not isNil(var_334_3) then
				if arg_331_1.var_.characterEffect1080ui_story and not isNil(var_334_3) then
					arg_331_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_331_1.time_ >= 0 + var_334_4 and arg_331_1.time_ < 0 + var_334_4 + arg_334_0 and not isNil(var_334_3) and arg_331_1.var_.characterEffect1080ui_story then
				arg_331_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action3_1")
			end

			local var_334_6 = 0
			local var_334_7 = 0.575

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_6 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_8 = arg_331_1:GetWordFromCfg(103703083)
				local var_334_9 = arg_331_1:FormatText(var_334_8.content)

				arg_331_1.text_.text = var_334_9

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_11 = 23 <= 0 and var_334_7 or var_334_7 * (utf8.len(var_334_9) / 23)

				if (23 <= 0 and var_334_7 or var_334_7 * (utf8.len(var_334_9) / 23)) > 0 and var_334_7 < var_334_11 then
					arg_331_1.talkMaxDuration = var_334_11

					if var_334_11 + var_334_6 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_11 + var_334_6
					end
				end

				arg_331_1.text_.text = var_334_9
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703083", "story_v_side_old_103703.awb") ~= 0 then
					local var_334_12 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703083", "story_v_side_old_103703.awb") / 1000

					if var_334_12 + var_334_6 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_12 + var_334_6
					end

					if var_334_8.prefab_name ~= "" and arg_331_1.actors_[var_334_8.prefab_name] ~= nil then
						local var_334_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_8.prefab_name].transform, "story_v_side_old_103703", "103703083", "story_v_side_old_103703.awb")

						arg_331_1:RecordAudio("103703083", var_334_13)
						arg_331_1:RecordAudio("103703083", var_334_13)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703083", "story_v_side_old_103703.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703083", "story_v_side_old_103703.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_14 = math.max(var_334_7, arg_331_1.talkMaxDuration)

			if var_334_6 <= arg_331_1.time_ and arg_331_1.time_ < var_334_6 + var_334_14 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_6) / var_334_14

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_6 + var_334_14 and arg_331_1.time_ < var_334_6 + var_334_14 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_331_1:InitPlayNodeList()
	end,
	Play103703084 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 103703084
		arg_335_1.duration_ = 6.13

		local var_335_0 = {
			ja = 6.133,
			ko = 3.466,
			en = 3.666
		}
		local var_335_1 = manager.audio:GetLocalizationFlag()

		if var_335_0[var_335_1] ~= nil then
			arg_335_1.duration_ = var_335_0[var_335_1]
		end

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play103703085(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.var_.moveOldPos1027ui_story = arg_335_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_338_0 = 0.001

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_0 then
				arg_335_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1027ui_story, Vector3.New(-0.7, -0.81, -5.8), (arg_335_1.time_ - 0) / var_338_0)
				arg_335_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_335_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["1027ui_story"].transform.position).z)
				arg_335_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_335_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_335_1.actors_["1027ui_story"].transform.localEulerAngles = arg_335_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_335_1.time_ >= 0 + var_338_0 and arg_335_1.time_ < 0 + var_338_0 + arg_338_0 then
				arg_335_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(-0.7, -0.81, -5.8)
				arg_335_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_335_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["1027ui_story"].transform.position).z)
				arg_335_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_335_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_335_1.actors_["1027ui_story"].transform.localEulerAngles = arg_335_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_338_1 = arg_335_1.actors_["1080ui_story"].transform

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.var_.moveOldPos1080ui_story = var_338_1.localPosition
			end

			local var_338_2 = 0.001

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_2 then
				var_338_1.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1080ui_story, Vector3.New(0.7, -1.01, -6.05), (arg_335_1.time_ - 0) / var_338_2)
				var_338_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_338_1.position).x, (manager.ui.mainCamera.transform.position - var_338_1.position).y, (manager.ui.mainCamera.transform.position - var_338_1.position).z)
				var_338_1.localEulerAngles.z = 0
				var_338_1.localEulerAngles.x = 0
				var_338_1.localEulerAngles = var_338_1.localEulerAngles
			end

			if arg_335_1.time_ >= 0 + var_338_2 and arg_335_1.time_ < 0 + var_338_2 + arg_338_0 then
				var_338_1.localPosition = Vector3.New(0.7, -1.01, -6.05)
				var_338_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_338_1.position).x, (manager.ui.mainCamera.transform.position - var_338_1.position).y, (manager.ui.mainCamera.transform.position - var_338_1.position).z)
				var_338_1.localEulerAngles.z = 0
				var_338_1.localEulerAngles.x = 0
				var_338_1.localEulerAngles = var_338_1.localEulerAngles
			end

			local var_338_3 = arg_335_1.actors_["1080ui_story"]

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(var_338_3) and arg_335_1.var_.characterEffect1080ui_story == nil then
				arg_335_1.var_.characterEffect1080ui_story = var_338_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_4 = 0.2

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_4 and not isNil(var_338_3) then
				if arg_335_1.var_.characterEffect1080ui_story and not isNil(var_338_3) then
					arg_335_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_335_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_335_1.time_ - 0) / var_338_4)
				end
			end

			if arg_335_1.time_ >= 0 + var_338_4 and arg_335_1.time_ < 0 + var_338_4 + arg_338_0 and not isNil(var_338_3) and arg_335_1.var_.characterEffect1080ui_story then
				arg_335_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_335_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_338_5 = arg_335_1.actors_["1027ui_story"]

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(var_338_5) and arg_335_1.var_.characterEffect1027ui_story == nil then
				arg_335_1.var_.characterEffect1027ui_story = var_338_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_6 = 0.2

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_6 and not isNil(var_338_5) then
				if arg_335_1.var_.characterEffect1027ui_story and not isNil(var_338_5) then
					arg_335_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_335_1.time_ >= 0 + var_338_6 and arg_335_1.time_ < 0 + var_338_6 + arg_338_0 and not isNil(var_338_5) and arg_335_1.var_.characterEffect1027ui_story then
				arg_335_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			local var_338_8 = 0
			local var_338_9 = 0.475

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_8 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_10 = arg_335_1:GetWordFromCfg(103703084)
				local var_338_11 = arg_335_1:FormatText(var_338_10.content)

				arg_335_1.text_.text = var_338_11

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_13 = 19 <= 0 and var_338_9 or var_338_9 * (utf8.len(var_338_11) / 19)

				if (19 <= 0 and var_338_9 or var_338_9 * (utf8.len(var_338_11) / 19)) > 0 and var_338_9 < var_338_13 then
					arg_335_1.talkMaxDuration = var_338_13

					if var_338_13 + var_338_8 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_13 + var_338_8
					end
				end

				arg_335_1.text_.text = var_338_11
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703084", "story_v_side_old_103703.awb") ~= 0 then
					local var_338_14 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703084", "story_v_side_old_103703.awb") / 1000

					if var_338_14 + var_338_8 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_14 + var_338_8
					end

					if var_338_10.prefab_name ~= "" and arg_335_1.actors_[var_338_10.prefab_name] ~= nil then
						local var_338_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_10.prefab_name].transform, "story_v_side_old_103703", "103703084", "story_v_side_old_103703.awb")

						arg_335_1:RecordAudio("103703084", var_338_15)
						arg_335_1:RecordAudio("103703084", var_338_15)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703084", "story_v_side_old_103703.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703084", "story_v_side_old_103703.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_16 = math.max(var_338_9, arg_335_1.talkMaxDuration)

			if var_338_8 <= arg_335_1.time_ and arg_335_1.time_ < var_338_8 + var_338_16 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_8) / var_338_16

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_8 + var_338_16 and arg_335_1.time_ < var_338_8 + var_338_16 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_335_1:InitPlayNodeList()
	end,
	Play103703085 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 103703085
		arg_339_1.duration_ = 7.1

		local var_339_0 = {
			ja = 7.1,
			ko = 2.333,
			en = 2.3
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play103703086(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.moveOldPos1027ui_story = arg_339_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_342_0 = 0.001

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 then
				arg_339_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_339_1.time_ - 0) / var_342_0)
				arg_339_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_339_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1027ui_story"].transform.position).z)
				arg_339_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_339_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_339_1.actors_["1027ui_story"].transform.localEulerAngles = arg_339_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 then
				arg_339_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_339_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_339_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1027ui_story"].transform.position).z)
				arg_339_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_339_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_339_1.actors_["1027ui_story"].transform.localEulerAngles = arg_339_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_342_1 = arg_339_1.actors_["1080ui_story"].transform

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.moveOldPos1080ui_story = var_342_1.localPosition
			end

			local var_342_2 = 0.001

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_2 then
				var_342_1.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_339_1.time_ - 0) / var_342_2)
				var_342_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_342_1.position).x, (manager.ui.mainCamera.transform.position - var_342_1.position).y, (manager.ui.mainCamera.transform.position - var_342_1.position).z)
				var_342_1.localEulerAngles.z = 0
				var_342_1.localEulerAngles.x = 0
				var_342_1.localEulerAngles = var_342_1.localEulerAngles
			end

			if arg_339_1.time_ >= 0 + var_342_2 and arg_339_1.time_ < 0 + var_342_2 + arg_342_0 then
				var_342_1.localPosition = Vector3.New(0, 100, 0)
				var_342_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_342_1.position).x, (manager.ui.mainCamera.transform.position - var_342_1.position).y, (manager.ui.mainCamera.transform.position - var_342_1.position).z)
				var_342_1.localEulerAngles.z = 0
				var_342_1.localEulerAngles.x = 0
				var_342_1.localEulerAngles = var_342_1.localEulerAngles
			end

			local var_342_3 = arg_339_1.actors_["1037ui_story"].transform

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.moveOldPos1037ui_story = var_342_3.localPosition
			end

			local var_342_4 = 0.001

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_4 then
				var_342_3.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_339_1.time_ - 0) / var_342_4)
				var_342_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_342_3.position).x, (manager.ui.mainCamera.transform.position - var_342_3.position).y, (manager.ui.mainCamera.transform.position - var_342_3.position).z)
				var_342_3.localEulerAngles.z = 0
				var_342_3.localEulerAngles.x = 0
				var_342_3.localEulerAngles = var_342_3.localEulerAngles
			end

			if arg_339_1.time_ >= 0 + var_342_4 and arg_339_1.time_ < 0 + var_342_4 + arg_342_0 then
				var_342_3.localPosition = Vector3.New(0, -1.09, -5.81)
				var_342_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_342_3.position).x, (manager.ui.mainCamera.transform.position - var_342_3.position).y, (manager.ui.mainCamera.transform.position - var_342_3.position).z)
				var_342_3.localEulerAngles.z = 0
				var_342_3.localEulerAngles.x = 0
				var_342_3.localEulerAngles = var_342_3.localEulerAngles
			end

			local var_342_5 = arg_339_1.actors_["1037ui_story"]

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(var_342_5) and arg_339_1.var_.characterEffect1037ui_story == nil then
				arg_339_1.var_.characterEffect1037ui_story = var_342_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_6 = 0.2

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_6 and not isNil(var_342_5) then
				if arg_339_1.var_.characterEffect1037ui_story and not isNil(var_342_5) then
					arg_339_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= 0 + var_342_6 and arg_339_1.time_ < 0 + var_342_6 + arg_342_0 and not isNil(var_342_5) and arg_339_1.var_.characterEffect1037ui_story then
				arg_339_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action4_1")
			end

			local var_342_8 = 0
			local var_342_9 = 0.3

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_8 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_10 = arg_339_1:GetWordFromCfg(103703085)
				local var_342_11 = arg_339_1:FormatText(var_342_10.content)

				arg_339_1.text_.text = var_342_11

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_13 = 12 <= 0 and var_342_9 or var_342_9 * (utf8.len(var_342_11) / 12)

				if (12 <= 0 and var_342_9 or var_342_9 * (utf8.len(var_342_11) / 12)) > 0 and var_342_9 < var_342_13 then
					arg_339_1.talkMaxDuration = var_342_13

					if var_342_13 + var_342_8 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_13 + var_342_8
					end
				end

				arg_339_1.text_.text = var_342_11
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703085", "story_v_side_old_103703.awb") ~= 0 then
					local var_342_14 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703085", "story_v_side_old_103703.awb") / 1000

					if var_342_14 + var_342_8 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_14 + var_342_8
					end

					if var_342_10.prefab_name ~= "" and arg_339_1.actors_[var_342_10.prefab_name] ~= nil then
						local var_342_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_10.prefab_name].transform, "story_v_side_old_103703", "103703085", "story_v_side_old_103703.awb")

						arg_339_1:RecordAudio("103703085", var_342_15)
						arg_339_1:RecordAudio("103703085", var_342_15)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703085", "story_v_side_old_103703.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703085", "story_v_side_old_103703.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_16 = math.max(var_342_9, arg_339_1.talkMaxDuration)

			if var_342_8 <= arg_339_1.time_ and arg_339_1.time_ < var_342_8 + var_342_16 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_8) / var_342_16

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_8 + var_342_16 and arg_339_1.time_ < var_342_8 + var_342_16 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_339_1:InitPlayNodeList()
	end,
	Play103703086 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 103703086
		arg_343_1.duration_ = 3.63

		local var_343_0 = {
			ja = 3.633,
			ko = 2.766,
			en = 3.1
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play103703087(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.var_.moveOldPos1037ui_story = arg_343_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_346_0 = 0.001

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 then
				arg_343_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos1037ui_story, Vector3.New(-0.7, -1.09, -5.81), (arg_343_1.time_ - 0) / var_346_0)
				arg_343_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_343_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["1037ui_story"].transform.position).z)
				arg_343_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_343_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_343_1.actors_["1037ui_story"].transform.localEulerAngles = arg_343_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 then
				arg_343_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(-0.7, -1.09, -5.81)
				arg_343_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_343_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["1037ui_story"].transform.position).z)
				arg_343_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_343_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_343_1.actors_["1037ui_story"].transform.localEulerAngles = arg_343_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_346_1 = arg_343_1.actors_["1080ui_story"].transform

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.var_.moveOldPos1080ui_story = var_346_1.localPosition
			end

			local var_346_2 = 0.001

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_2 then
				var_346_1.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos1080ui_story, Vector3.New(0.7, -1.01, -6.05), (arg_343_1.time_ - 0) / var_346_2)
				var_346_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_346_1.position).x, (manager.ui.mainCamera.transform.position - var_346_1.position).y, (manager.ui.mainCamera.transform.position - var_346_1.position).z)
				var_346_1.localEulerAngles.z = 0
				var_346_1.localEulerAngles.x = 0
				var_346_1.localEulerAngles = var_346_1.localEulerAngles
			end

			if arg_343_1.time_ >= 0 + var_346_2 and arg_343_1.time_ < 0 + var_346_2 + arg_346_0 then
				var_346_1.localPosition = Vector3.New(0.7, -1.01, -6.05)
				var_346_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_346_1.position).x, (manager.ui.mainCamera.transform.position - var_346_1.position).y, (manager.ui.mainCamera.transform.position - var_346_1.position).z)
				var_346_1.localEulerAngles.z = 0
				var_346_1.localEulerAngles.x = 0
				var_346_1.localEulerAngles = var_346_1.localEulerAngles
			end

			local var_346_3 = arg_343_1.actors_["1037ui_story"]

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(var_346_3) and arg_343_1.var_.characterEffect1037ui_story == nil then
				arg_343_1.var_.characterEffect1037ui_story = var_346_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_4 = 0.2

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_4 and not isNil(var_346_3) then
				if arg_343_1.var_.characterEffect1037ui_story and not isNil(var_346_3) then
					arg_343_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_343_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_343_1.time_ - 0) / var_346_4)
				end
			end

			if arg_343_1.time_ >= 0 + var_346_4 and arg_343_1.time_ < 0 + var_346_4 + arg_346_0 and not isNil(var_346_3) and arg_343_1.var_.characterEffect1037ui_story then
				arg_343_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_343_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_346_5 = arg_343_1.actors_["1080ui_story"]

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(var_346_5) and arg_343_1.var_.characterEffect1080ui_story == nil then
				arg_343_1.var_.characterEffect1080ui_story = var_346_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_6 = 0.2

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_6 and not isNil(var_346_5) then
				if arg_343_1.var_.characterEffect1080ui_story and not isNil(var_346_5) then
					arg_343_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_343_1.time_ >= 0 + var_346_6 and arg_343_1.time_ < 0 + var_346_6 + arg_346_0 and not isNil(var_346_5) and arg_343_1.var_.characterEffect1080ui_story then
				arg_343_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action3_1")
			end

			local var_346_8 = 0
			local var_346_9 = 0.275

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_8 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_10 = arg_343_1:GetWordFromCfg(103703086)
				local var_346_11 = arg_343_1:FormatText(var_346_10.content)

				arg_343_1.text_.text = var_346_11

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_13 = 11 <= 0 and var_346_9 or var_346_9 * (utf8.len(var_346_11) / 11)

				if (11 <= 0 and var_346_9 or var_346_9 * (utf8.len(var_346_11) / 11)) > 0 and var_346_9 < var_346_13 then
					arg_343_1.talkMaxDuration = var_346_13

					if var_346_13 + var_346_8 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_13 + var_346_8
					end
				end

				arg_343_1.text_.text = var_346_11
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703086", "story_v_side_old_103703.awb") ~= 0 then
					local var_346_14 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703086", "story_v_side_old_103703.awb") / 1000

					if var_346_14 + var_346_8 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_14 + var_346_8
					end

					if var_346_10.prefab_name ~= "" and arg_343_1.actors_[var_346_10.prefab_name] ~= nil then
						local var_346_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_10.prefab_name].transform, "story_v_side_old_103703", "103703086", "story_v_side_old_103703.awb")

						arg_343_1:RecordAudio("103703086", var_346_15)
						arg_343_1:RecordAudio("103703086", var_346_15)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703086", "story_v_side_old_103703.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703086", "story_v_side_old_103703.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_16 = math.max(var_346_9, arg_343_1.talkMaxDuration)

			if var_346_8 <= arg_343_1.time_ and arg_343_1.time_ < var_346_8 + var_346_16 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_8) / var_346_16

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_8 + var_346_16 and arg_343_1.time_ < var_346_8 + var_346_16 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_343_1:InitPlayNodeList()
	end,
	Play103703087 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 103703087
		arg_347_1.duration_ = 12.8

		local var_347_0 = {
			ja = 12.8,
			ko = 7.366,
			en = 8.733
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play103703088(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(arg_347_1.actors_["1080ui_story"]) and arg_347_1.var_.characterEffect1080ui_story == nil then
				arg_347_1.var_.characterEffect1080ui_story = arg_347_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_0 = 0.2

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 and not isNil(arg_347_1.actors_["1080ui_story"]) then
				if arg_347_1.var_.characterEffect1080ui_story and not isNil(arg_347_1.actors_["1080ui_story"]) then
					arg_347_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_347_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_347_1.time_ - 0) / var_350_0)
				end
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 and not isNil(arg_347_1.actors_["1080ui_story"]) and arg_347_1.var_.characterEffect1080ui_story then
				arg_347_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_347_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_350_1 = arg_347_1.actors_["1037ui_story"]

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(var_350_1) and arg_347_1.var_.characterEffect1037ui_story == nil then
				arg_347_1.var_.characterEffect1037ui_story = var_350_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_2 = 0.2

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_2 and not isNil(var_350_1) then
				if arg_347_1.var_.characterEffect1037ui_story and not isNil(var_350_1) then
					arg_347_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_347_1.time_ >= 0 + var_350_2 and arg_347_1.time_ < 0 + var_350_2 + arg_350_0 and not isNil(var_350_1) and arg_347_1.var_.characterEffect1037ui_story then
				arg_347_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037actionlink/1037action443")
			end

			local var_350_4 = 0
			local var_350_5 = 0.8

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_4 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_6 = arg_347_1:GetWordFromCfg(103703087)
				local var_350_7 = arg_347_1:FormatText(var_350_6.content)

				arg_347_1.text_.text = var_350_7

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_9 = 32 <= 0 and var_350_5 or var_350_5 * (utf8.len(var_350_7) / 32)

				if (32 <= 0 and var_350_5 or var_350_5 * (utf8.len(var_350_7) / 32)) > 0 and var_350_5 < var_350_9 then
					arg_347_1.talkMaxDuration = var_350_9

					if var_350_9 + var_350_4 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_9 + var_350_4
					end
				end

				arg_347_1.text_.text = var_350_7
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703087", "story_v_side_old_103703.awb") ~= 0 then
					local var_350_10 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703087", "story_v_side_old_103703.awb") / 1000

					if var_350_10 + var_350_4 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_10 + var_350_4
					end

					if var_350_6.prefab_name ~= "" and arg_347_1.actors_[var_350_6.prefab_name] ~= nil then
						local var_350_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_6.prefab_name].transform, "story_v_side_old_103703", "103703087", "story_v_side_old_103703.awb")

						arg_347_1:RecordAudio("103703087", var_350_11)
						arg_347_1:RecordAudio("103703087", var_350_11)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703087", "story_v_side_old_103703.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703087", "story_v_side_old_103703.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_12 = math.max(var_350_5, arg_347_1.talkMaxDuration)

			if var_350_4 <= arg_347_1.time_ and arg_347_1.time_ < var_350_4 + var_350_12 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_4) / var_350_12

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_4 + var_350_12 and arg_347_1.time_ < var_350_4 + var_350_12 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play103703088 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 103703088
		arg_351_1.duration_ = 2.5

		local var_351_0 = {
			ja = 2.5,
			ko = 1.999999999999,
			en = 1.999999999999
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play103703089(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(arg_351_1.actors_["1037ui_story"]) and arg_351_1.var_.characterEffect1037ui_story == nil then
				arg_351_1.var_.characterEffect1037ui_story = arg_351_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_0 = 0.2

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 and not isNil(arg_351_1.actors_["1037ui_story"]) then
				if arg_351_1.var_.characterEffect1037ui_story and not isNil(arg_351_1.actors_["1037ui_story"]) then
					arg_351_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_351_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_351_1.time_ - 0) / var_354_0)
				end
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 and not isNil(arg_351_1.actors_["1037ui_story"]) and arg_351_1.var_.characterEffect1037ui_story then
				arg_351_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_351_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_354_1 = arg_351_1.actors_["1080ui_story"]

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(var_354_1) and arg_351_1.var_.characterEffect1080ui_story == nil then
				arg_351_1.var_.characterEffect1080ui_story = var_354_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_2 = 0.2

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_2 and not isNil(var_354_1) then
				if arg_351_1.var_.characterEffect1080ui_story and not isNil(var_354_1) then
					arg_351_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_351_1.time_ >= 0 + var_354_2 and arg_351_1.time_ < 0 + var_354_2 + arg_354_0 and not isNil(var_354_1) and arg_351_1.var_.characterEffect1080ui_story then
				arg_351_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080actionlink/1080action434")
			end

			local var_354_4 = 0
			local var_354_5 = 0.1

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_4 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_6 = arg_351_1:GetWordFromCfg(103703088)
				local var_354_7 = arg_351_1:FormatText(var_354_6.content)

				arg_351_1.text_.text = var_354_7

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_9 = 4 <= 0 and var_354_5 or var_354_5 * (utf8.len(var_354_7) / 4)

				if (4 <= 0 and var_354_5 or var_354_5 * (utf8.len(var_354_7) / 4)) > 0 and var_354_5 < var_354_9 then
					arg_351_1.talkMaxDuration = var_354_9

					if var_354_9 + var_354_4 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_9 + var_354_4
					end
				end

				arg_351_1.text_.text = var_354_7
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703088", "story_v_side_old_103703.awb") ~= 0 then
					local var_354_10 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703088", "story_v_side_old_103703.awb") / 1000

					if var_354_10 + var_354_4 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_10 + var_354_4
					end

					if var_354_6.prefab_name ~= "" and arg_351_1.actors_[var_354_6.prefab_name] ~= nil then
						local var_354_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_6.prefab_name].transform, "story_v_side_old_103703", "103703088", "story_v_side_old_103703.awb")

						arg_351_1:RecordAudio("103703088", var_354_11)
						arg_351_1:RecordAudio("103703088", var_354_11)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703088", "story_v_side_old_103703.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703088", "story_v_side_old_103703.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_12 = math.max(var_354_5, arg_351_1.talkMaxDuration)

			if var_354_4 <= arg_351_1.time_ and arg_351_1.time_ < var_354_4 + var_354_12 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_4) / var_354_12

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_4 + var_354_12 and arg_351_1.time_ < var_354_4 + var_354_12 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play103703089 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 103703089
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play103703090(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(arg_355_1.actors_["1080ui_story"]) and arg_355_1.var_.characterEffect1080ui_story == nil then
				arg_355_1.var_.characterEffect1080ui_story = arg_355_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_0 = 0.2

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_0 and not isNil(arg_355_1.actors_["1080ui_story"]) then
				if arg_355_1.var_.characterEffect1080ui_story and not isNil(arg_355_1.actors_["1080ui_story"]) then
					arg_355_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_355_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_355_1.time_ - 0) / var_358_0)
				end
			end

			if arg_355_1.time_ >= 0 + var_358_0 and arg_355_1.time_ < 0 + var_358_0 + arg_358_0 and not isNil(arg_355_1.actors_["1080ui_story"]) and arg_355_1.var_.characterEffect1080ui_story then
				arg_355_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_355_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_358_1 = 0
			local var_358_2 = 0.55

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, false)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_3 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(103703089).content)

				arg_355_1.text_.text = var_358_3

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_5 = 22 <= 0 and var_358_2 or var_358_2 * (utf8.len(var_358_3) / 22)

				if (22 <= 0 and var_358_2 or var_358_2 * (utf8.len(var_358_3) / 22)) > 0 and var_358_2 < var_358_5 then
					arg_355_1.talkMaxDuration = var_358_5

					if var_358_5 + var_358_1 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_5 + var_358_1
					end
				end

				arg_355_1.text_.text = var_358_3
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_6 = math.max(var_358_2, arg_355_1.talkMaxDuration)

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_6 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_1) / var_358_6

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_1 + var_358_6 and arg_355_1.time_ < var_358_1 + var_358_6 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play103703090 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 103703090
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play103703091(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.moveOldPos1037ui_story = arg_359_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_362_0 = 0.001

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 then
				arg_359_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_359_1.time_ - 0) / var_362_0)
				arg_359_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_359_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1037ui_story"].transform.position).z)
				arg_359_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_359_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_359_1.actors_["1037ui_story"].transform.localEulerAngles = arg_359_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 then
				arg_359_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_359_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_359_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1037ui_story"].transform.position).z)
				arg_359_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_359_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_359_1.actors_["1037ui_story"].transform.localEulerAngles = arg_359_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_362_1 = arg_359_1.actors_["1080ui_story"].transform

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.moveOldPos1080ui_story = var_362_1.localPosition
			end

			local var_362_2 = 0.001

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_2 then
				var_362_1.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_359_1.time_ - 0) / var_362_2)
				var_362_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_362_1.position).x, (manager.ui.mainCamera.transform.position - var_362_1.position).y, (manager.ui.mainCamera.transform.position - var_362_1.position).z)
				var_362_1.localEulerAngles.z = 0
				var_362_1.localEulerAngles.x = 0
				var_362_1.localEulerAngles = var_362_1.localEulerAngles
			end

			if arg_359_1.time_ >= 0 + var_362_2 and arg_359_1.time_ < 0 + var_362_2 + arg_362_0 then
				var_362_1.localPosition = Vector3.New(0, 100, 0)
				var_362_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_362_1.position).x, (manager.ui.mainCamera.transform.position - var_362_1.position).y, (manager.ui.mainCamera.transform.position - var_362_1.position).z)
				var_362_1.localEulerAngles.z = 0
				var_362_1.localEulerAngles.x = 0
				var_362_1.localEulerAngles = var_362_1.localEulerAngles
			end

			local var_362_3 = 0
			local var_362_4 = 0.925

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_3 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, false)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_5 = arg_359_1:FormatText(arg_359_1:GetWordFromCfg(103703090).content)

				arg_359_1.text_.text = var_362_5

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_7 = 37 <= 0 and var_362_4 or var_362_4 * (utf8.len(var_362_5) / 37)

				if (37 <= 0 and var_362_4 or var_362_4 * (utf8.len(var_362_5) / 37)) > 0 and var_362_4 < var_362_7 then
					arg_359_1.talkMaxDuration = var_362_7

					if var_362_7 + var_362_3 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_7 + var_362_3
					end
				end

				arg_359_1.text_.text = var_362_5
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_8 = math.max(var_362_4, arg_359_1.talkMaxDuration)

			if var_362_3 <= arg_359_1.time_ and arg_359_1.time_ < var_362_3 + var_362_8 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_3) / var_362_8

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_3 + var_362_8 and arg_359_1.time_ < var_362_3 + var_362_8 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play103703091 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 103703091
		arg_363_1.duration_ = 0.17

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"

			SetActive(arg_363_1.choicesGo_, true)

			for iter_364_0, iter_364_1 in ipairs(arg_363_1.choices_) do
				SetActive(iter_364_1.go, iter_364_0 <= 1)
			end

			arg_363_1.choices_[1].txt.text = arg_363_1:FormatText(StoryChoiceCfg[127].name)
			arg_363_1.choices_[2].txt.text = arg_363_1:FormatText(StoryChoiceCfg[128].name)
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play103703092(arg_363_1)
			end

			arg_363_1:RecordChoiceLog(103703091, 127, 128)
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			return
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play103703092 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 103703092
		arg_367_1.duration_ = 2.97

		local var_367_0 = {
			ja = 1.999999999999,
			ko = 2.966,
			en = 2.933
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play103703093(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.var_.moveOldPos1080ui_story = arg_367_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_370_0 = 0.001

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_0 then
				arg_367_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos1080ui_story, Vector3.New(0, -1.01, -6.05), (arg_367_1.time_ - 0) / var_370_0)
				arg_367_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_367_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1080ui_story"].transform.position).z)
				arg_367_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_367_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_367_1.actors_["1080ui_story"].transform.localEulerAngles = arg_367_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_367_1.time_ >= 0 + var_370_0 and arg_367_1.time_ < 0 + var_370_0 + arg_370_0 then
				arg_367_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.05)
				arg_367_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_367_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1080ui_story"].transform.position).z)
				arg_367_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_367_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_367_1.actors_["1080ui_story"].transform.localEulerAngles = arg_367_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_370_1 = arg_367_1.actors_["1080ui_story"]

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(var_370_1) and arg_367_1.var_.characterEffect1080ui_story == nil then
				arg_367_1.var_.characterEffect1080ui_story = var_370_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_2 = 0.2

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_2 and not isNil(var_370_1) then
				if arg_367_1.var_.characterEffect1080ui_story and not isNil(var_370_1) then
					arg_367_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_367_1.time_ >= 0 + var_370_2 and arg_367_1.time_ < 0 + var_370_2 + arg_370_0 and not isNil(var_370_1) and arg_367_1.var_.characterEffect1080ui_story then
				arg_367_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_1")
			end

			local var_370_4 = 0
			local var_370_5 = 0.175

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_4 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_6 = arg_367_1:GetWordFromCfg(103703092)
				local var_370_7 = arg_367_1:FormatText(var_370_6.content)

				arg_367_1.text_.text = var_370_7

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_9 = 7 <= 0 and var_370_5 or var_370_5 * (utf8.len(var_370_7) / 7)

				if (7 <= 0 and var_370_5 or var_370_5 * (utf8.len(var_370_7) / 7)) > 0 and var_370_5 < var_370_9 then
					arg_367_1.talkMaxDuration = var_370_9

					if var_370_9 + var_370_4 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_9 + var_370_4
					end
				end

				arg_367_1.text_.text = var_370_7
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703092", "story_v_side_old_103703.awb") ~= 0 then
					local var_370_10 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703092", "story_v_side_old_103703.awb") / 1000

					if var_370_10 + var_370_4 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_10 + var_370_4
					end

					if var_370_6.prefab_name ~= "" and arg_367_1.actors_[var_370_6.prefab_name] ~= nil then
						local var_370_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_6.prefab_name].transform, "story_v_side_old_103703", "103703092", "story_v_side_old_103703.awb")

						arg_367_1:RecordAudio("103703092", var_370_11)
						arg_367_1:RecordAudio("103703092", var_370_11)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703092", "story_v_side_old_103703.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703092", "story_v_side_old_103703.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_12 = math.max(var_370_5, arg_367_1.talkMaxDuration)

			if var_370_4 <= arg_367_1.time_ and arg_367_1.time_ < var_370_4 + var_370_12 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_4) / var_370_12

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_4 + var_370_12 and arg_367_1.time_ < var_370_4 + var_370_12 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_367_1:InitPlayNodeList()
	end,
	Play103703093 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 103703093
		arg_371_1.duration_ = 5.83

		local var_371_0 = {
			ja = 4.966,
			ko = 5.833,
			en = 5.533
		}
		local var_371_1 = manager.audio:GetLocalizationFlag()

		if var_371_0[var_371_1] ~= nil then
			arg_371_1.duration_ = var_371_0[var_371_1]
		end

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play103703094(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.var_.moveOldPos1027ui_story = arg_371_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_374_0 = 0.001

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_0 then
				arg_371_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos1027ui_story, Vector3.New(0.7, -0.81, -5.8), (arg_371_1.time_ - 0) / var_374_0)
				arg_371_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_371_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1027ui_story"].transform.position).z)
				arg_371_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_371_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_371_1.actors_["1027ui_story"].transform.localEulerAngles = arg_371_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_371_1.time_ >= 0 + var_374_0 and arg_371_1.time_ < 0 + var_374_0 + arg_374_0 then
				arg_371_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0.7, -0.81, -5.8)
				arg_371_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_371_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1027ui_story"].transform.position).z)
				arg_371_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_371_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_371_1.actors_["1027ui_story"].transform.localEulerAngles = arg_371_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_374_1 = arg_371_1.actors_["1080ui_story"].transform

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.var_.moveOldPos1080ui_story = var_374_1.localPosition
			end

			local var_374_2 = 0.001

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_2 then
				var_374_1.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos1080ui_story, Vector3.New(-0.7, -1.01, -6.05), (arg_371_1.time_ - 0) / var_374_2)
				var_374_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_374_1.position).x, (manager.ui.mainCamera.transform.position - var_374_1.position).y, (manager.ui.mainCamera.transform.position - var_374_1.position).z)
				var_374_1.localEulerAngles.z = 0
				var_374_1.localEulerAngles.x = 0
				var_374_1.localEulerAngles = var_374_1.localEulerAngles
			end

			if arg_371_1.time_ >= 0 + var_374_2 and arg_371_1.time_ < 0 + var_374_2 + arg_374_0 then
				var_374_1.localPosition = Vector3.New(-0.7, -1.01, -6.05)
				var_374_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_374_1.position).x, (manager.ui.mainCamera.transform.position - var_374_1.position).y, (manager.ui.mainCamera.transform.position - var_374_1.position).z)
				var_374_1.localEulerAngles.z = 0
				var_374_1.localEulerAngles.x = 0
				var_374_1.localEulerAngles = var_374_1.localEulerAngles
			end

			local var_374_3 = arg_371_1.actors_["1080ui_story"]

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(var_374_3) and arg_371_1.var_.characterEffect1080ui_story == nil then
				arg_371_1.var_.characterEffect1080ui_story = var_374_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_4 = 0.2

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_4 and not isNil(var_374_3) then
				if arg_371_1.var_.characterEffect1080ui_story and not isNil(var_374_3) then
					arg_371_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_371_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_371_1.time_ - 0) / var_374_4)
				end
			end

			if arg_371_1.time_ >= 0 + var_374_4 and arg_371_1.time_ < 0 + var_374_4 + arg_374_0 and not isNil(var_374_3) and arg_371_1.var_.characterEffect1080ui_story then
				arg_371_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_371_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_374_5 = arg_371_1.actors_["1027ui_story"]

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(var_374_5) and arg_371_1.var_.characterEffect1027ui_story == nil then
				arg_371_1.var_.characterEffect1027ui_story = var_374_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_6 = 0.2

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_6 and not isNil(var_374_5) then
				if arg_371_1.var_.characterEffect1027ui_story and not isNil(var_374_5) then
					arg_371_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_371_1.time_ >= 0 + var_374_6 and arg_371_1.time_ < 0 + var_374_6 + arg_374_0 and not isNil(var_374_5) and arg_371_1.var_.characterEffect1027ui_story then
				arg_371_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action3_1")
			end

			local var_374_8 = 0
			local var_374_9 = 0.7

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_8 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_10 = arg_371_1:GetWordFromCfg(103703093)
				local var_374_11 = arg_371_1:FormatText(var_374_10.content)

				arg_371_1.text_.text = var_374_11

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_13 = 28 <= 0 and var_374_9 or var_374_9 * (utf8.len(var_374_11) / 28)

				if (28 <= 0 and var_374_9 or var_374_9 * (utf8.len(var_374_11) / 28)) > 0 and var_374_9 < var_374_13 then
					arg_371_1.talkMaxDuration = var_374_13

					if var_374_13 + var_374_8 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_13 + var_374_8
					end
				end

				arg_371_1.text_.text = var_374_11
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703093", "story_v_side_old_103703.awb") ~= 0 then
					local var_374_14 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703093", "story_v_side_old_103703.awb") / 1000

					if var_374_14 + var_374_8 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_14 + var_374_8
					end

					if var_374_10.prefab_name ~= "" and arg_371_1.actors_[var_374_10.prefab_name] ~= nil then
						local var_374_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_10.prefab_name].transform, "story_v_side_old_103703", "103703093", "story_v_side_old_103703.awb")

						arg_371_1:RecordAudio("103703093", var_374_15)
						arg_371_1:RecordAudio("103703093", var_374_15)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703093", "story_v_side_old_103703.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703093", "story_v_side_old_103703.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_16 = math.max(var_374_9, arg_371_1.talkMaxDuration)

			if var_374_8 <= arg_371_1.time_ and arg_371_1.time_ < var_374_8 + var_374_16 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_8) / var_374_16

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_8 + var_374_16 and arg_371_1.time_ < var_374_8 + var_374_16 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_371_1:InitPlayNodeList()
	end,
	Play103703094 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 103703094
		arg_375_1.duration_ = 8.07

		local var_375_0 = {
			ja = 8.066,
			ko = 7.7,
			en = 5.2
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play103703095(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action432")
			end

			local var_378_0 = 0
			local var_378_1 = 0.975

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_0 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_2 = arg_375_1:GetWordFromCfg(103703094)
				local var_378_3 = arg_375_1:FormatText(var_378_2.content)

				arg_375_1.text_.text = var_378_3

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_5 = 36 <= 0 and var_378_1 or var_378_1 * (utf8.len(var_378_3) / 36)

				if (36 <= 0 and var_378_1 or var_378_1 * (utf8.len(var_378_3) / 36)) > 0 and var_378_1 < var_378_5 then
					arg_375_1.talkMaxDuration = var_378_5

					if var_378_5 + var_378_0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_5 + var_378_0
					end
				end

				arg_375_1.text_.text = var_378_3
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703094", "story_v_side_old_103703.awb") ~= 0 then
					local var_378_6 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703094", "story_v_side_old_103703.awb") / 1000

					if var_378_6 + var_378_0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_6 + var_378_0
					end

					if var_378_2.prefab_name ~= "" and arg_375_1.actors_[var_378_2.prefab_name] ~= nil then
						local var_378_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_2.prefab_name].transform, "story_v_side_old_103703", "103703094", "story_v_side_old_103703.awb")

						arg_375_1:RecordAudio("103703094", var_378_7)
						arg_375_1:RecordAudio("103703094", var_378_7)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703094", "story_v_side_old_103703.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703094", "story_v_side_old_103703.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_8 = math.max(var_378_1, arg_375_1.talkMaxDuration)

			if var_378_0 <= arg_375_1.time_ and arg_375_1.time_ < var_378_0 + var_378_8 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_0) / var_378_8

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_0 + var_378_8 and arg_375_1.time_ < var_378_0 + var_378_8 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play103703095 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 103703095
		arg_379_1.duration_ = 5

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play103703096(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.var_.moveOldPos1027ui_story = arg_379_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_382_0 = 0.001

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_0 then
				arg_379_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_379_1.time_ - 0) / var_382_0)
				arg_379_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_379_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1027ui_story"].transform.position).z)
				arg_379_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_379_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_379_1.actors_["1027ui_story"].transform.localEulerAngles = arg_379_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_379_1.time_ >= 0 + var_382_0 and arg_379_1.time_ < 0 + var_382_0 + arg_382_0 then
				arg_379_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_379_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_379_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1027ui_story"].transform.position).z)
				arg_379_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_379_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_379_1.actors_["1027ui_story"].transform.localEulerAngles = arg_379_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_382_1 = arg_379_1.actors_["1080ui_story"].transform

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.var_.moveOldPos1080ui_story = var_382_1.localPosition
			end

			local var_382_2 = 0.001

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_2 then
				var_382_1.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_379_1.time_ - 0) / var_382_2)
				var_382_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_382_1.position).x, (manager.ui.mainCamera.transform.position - var_382_1.position).y, (manager.ui.mainCamera.transform.position - var_382_1.position).z)
				var_382_1.localEulerAngles.z = 0
				var_382_1.localEulerAngles.x = 0
				var_382_1.localEulerAngles = var_382_1.localEulerAngles
			end

			if arg_379_1.time_ >= 0 + var_382_2 and arg_379_1.time_ < 0 + var_382_2 + arg_382_0 then
				var_382_1.localPosition = Vector3.New(0, 100, 0)
				var_382_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_382_1.position).x, (manager.ui.mainCamera.transform.position - var_382_1.position).y, (manager.ui.mainCamera.transform.position - var_382_1.position).z)
				var_382_1.localEulerAngles.z = 0
				var_382_1.localEulerAngles.x = 0
				var_382_1.localEulerAngles = var_382_1.localEulerAngles
			end

			local var_382_3 = 0
			local var_382_4 = 0.025

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_3 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, true)
				arg_379_1.iconController_:SetSelectedState("hero")

				arg_379_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_379_1.callingController_:SetSelectedState("normal")

				arg_379_1.keyicon_.color = Color.New(1, 1, 1)
				arg_379_1.icon_.color = Color.New(1, 1, 1)

				local var_382_5 = arg_379_1:FormatText(arg_379_1:GetWordFromCfg(103703095).content)

				arg_379_1.text_.text = var_382_5

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_7 = 1 <= 0 and var_382_4 or var_382_4 * (utf8.len(var_382_5) / 1)

				if (1 <= 0 and var_382_4 or var_382_4 * (utf8.len(var_382_5) / 1)) > 0 and var_382_4 < var_382_7 then
					arg_379_1.talkMaxDuration = var_382_7

					if var_382_7 + var_382_3 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_7 + var_382_3
					end
				end

				arg_379_1.text_.text = var_382_5
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)
				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_8 = math.max(var_382_4, arg_379_1.talkMaxDuration)

			if var_382_3 <= arg_379_1.time_ and arg_379_1.time_ < var_382_3 + var_382_8 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_3) / var_382_8

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_3 + var_382_8 and arg_379_1.time_ < var_382_3 + var_382_8 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_379_1:InitPlayNodeList()
	end,
	Play103703096 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 103703096
		arg_383_1.duration_ = 8.97

		local var_383_0 = {
			ja = 8.966,
			ko = 6,
			en = 5.333
		}
		local var_383_1 = manager.audio:GetLocalizationFlag()

		if var_383_0[var_383_1] ~= nil then
			arg_383_1.duration_ = var_383_0[var_383_1]
		end

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play103703097(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.var_.moveOldPos1037ui_story = arg_383_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_386_0 = 0.001

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_0 then
				arg_383_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_383_1.time_ - 0) / var_386_0)
				arg_383_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_383_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1037ui_story"].transform.position).z)
				arg_383_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_383_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_383_1.actors_["1037ui_story"].transform.localEulerAngles = arg_383_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_383_1.time_ >= 0 + var_386_0 and arg_383_1.time_ < 0 + var_386_0 + arg_386_0 then
				arg_383_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, -1.09, -5.81)
				arg_383_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_383_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1037ui_story"].transform.position).z)
				arg_383_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_383_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_383_1.actors_["1037ui_story"].transform.localEulerAngles = arg_383_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_386_1 = arg_383_1.actors_["1037ui_story"]

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(var_386_1) and arg_383_1.var_.characterEffect1037ui_story == nil then
				arg_383_1.var_.characterEffect1037ui_story = var_386_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_2 = 0.2

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_2 and not isNil(var_386_1) then
				if arg_383_1.var_.characterEffect1037ui_story and not isNil(var_386_1) then
					arg_383_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_383_1.time_ >= 0 + var_386_2 and arg_383_1.time_ < 0 + var_386_2 + arg_386_0 and not isNil(var_386_1) and arg_383_1.var_.characterEffect1037ui_story then
				arg_383_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action4_1")
			end

			local var_386_4 = 0
			local var_386_5 = 0.6

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_4 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_6 = arg_383_1:GetWordFromCfg(103703096)
				local var_386_7 = arg_383_1:FormatText(var_386_6.content)

				arg_383_1.text_.text = var_386_7

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_9 = 24 <= 0 and var_386_5 or var_386_5 * (utf8.len(var_386_7) / 24)

				if (24 <= 0 and var_386_5 or var_386_5 * (utf8.len(var_386_7) / 24)) > 0 and var_386_5 < var_386_9 then
					arg_383_1.talkMaxDuration = var_386_9

					if var_386_9 + var_386_4 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_9 + var_386_4
					end
				end

				arg_383_1.text_.text = var_386_7
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703096", "story_v_side_old_103703.awb") ~= 0 then
					local var_386_10 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703096", "story_v_side_old_103703.awb") / 1000

					if var_386_10 + var_386_4 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_10 + var_386_4
					end

					if var_386_6.prefab_name ~= "" and arg_383_1.actors_[var_386_6.prefab_name] ~= nil then
						local var_386_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_6.prefab_name].transform, "story_v_side_old_103703", "103703096", "story_v_side_old_103703.awb")

						arg_383_1:RecordAudio("103703096", var_386_11)
						arg_383_1:RecordAudio("103703096", var_386_11)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703096", "story_v_side_old_103703.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703096", "story_v_side_old_103703.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_12 = math.max(var_386_5, arg_383_1.talkMaxDuration)

			if var_386_4 <= arg_383_1.time_ and arg_383_1.time_ < var_386_4 + var_386_12 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_4) / var_386_12

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_4 + var_386_12 and arg_383_1.time_ < var_386_4 + var_386_12 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_383_1:InitPlayNodeList()
	end,
	Play103703097 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 103703097
		arg_387_1.duration_ = 15

		local var_387_0 = {
			ja = 15,
			ko = 7.633,
			en = 9.9
		}
		local var_387_1 = manager.audio:GetLocalizationFlag()

		if var_387_0[var_387_1] ~= nil then
			arg_387_1.duration_ = var_387_0[var_387_1]
		end

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play103703098(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action4_2")
			end

			local var_390_0 = 0
			local var_390_1 = 1.025

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_2 = arg_387_1:GetWordFromCfg(103703097)
				local var_390_3 = arg_387_1:FormatText(var_390_2.content)

				arg_387_1.text_.text = var_390_3

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_5 = 41 <= 0 and var_390_1 or var_390_1 * (utf8.len(var_390_3) / 41)

				if (41 <= 0 and var_390_1 or var_390_1 * (utf8.len(var_390_3) / 41)) > 0 and var_390_1 < var_390_5 then
					arg_387_1.talkMaxDuration = var_390_5

					if var_390_5 + var_390_0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_5 + var_390_0
					end
				end

				arg_387_1.text_.text = var_390_3
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703097", "story_v_side_old_103703.awb") ~= 0 then
					local var_390_6 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703097", "story_v_side_old_103703.awb") / 1000

					if var_390_6 + var_390_0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_6 + var_390_0
					end

					if var_390_2.prefab_name ~= "" and arg_387_1.actors_[var_390_2.prefab_name] ~= nil then
						local var_390_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_2.prefab_name].transform, "story_v_side_old_103703", "103703097", "story_v_side_old_103703.awb")

						arg_387_1:RecordAudio("103703097", var_390_7)
						arg_387_1:RecordAudio("103703097", var_390_7)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703097", "story_v_side_old_103703.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703097", "story_v_side_old_103703.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_8 = math.max(var_390_1, arg_387_1.talkMaxDuration)

			if var_390_0 <= arg_387_1.time_ and arg_387_1.time_ < var_390_0 + var_390_8 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_0) / var_390_8

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_0 + var_390_8 and arg_387_1.time_ < var_390_0 + var_390_8 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play103703098 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 103703098
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play103703099(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 and not isNil(arg_391_1.actors_["1037ui_story"]) and arg_391_1.var_.characterEffect1037ui_story == nil then
				arg_391_1.var_.characterEffect1037ui_story = arg_391_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_0 = 0.2

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_0 and not isNil(arg_391_1.actors_["1037ui_story"]) then
				if arg_391_1.var_.characterEffect1037ui_story and not isNil(arg_391_1.actors_["1037ui_story"]) then
					arg_391_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_391_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_391_1.time_ - 0) / var_394_0)
				end
			end

			if arg_391_1.time_ >= 0 + var_394_0 and arg_391_1.time_ < 0 + var_394_0 + arg_394_0 and not isNil(arg_391_1.actors_["1037ui_story"]) and arg_391_1.var_.characterEffect1037ui_story then
				arg_391_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_391_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_394_1 = 0
			local var_394_2 = 0.125

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

				local var_394_3 = arg_391_1:FormatText(arg_391_1:GetWordFromCfg(103703098).content)

				arg_391_1.text_.text = var_394_3

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_5 = 5 <= 0 and var_394_2 or var_394_2 * (utf8.len(var_394_3) / 5)

				if (5 <= 0 and var_394_2 or var_394_2 * (utf8.len(var_394_3) / 5)) > 0 and var_394_2 < var_394_5 then
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
	Play103703099 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 103703099
		arg_395_1.duration_ = 7.33

		local var_395_0 = {
			ja = 7.333,
			ko = 4.133,
			en = 4.133
		}
		local var_395_1 = manager.audio:GetLocalizationFlag()

		if var_395_0[var_395_1] ~= nil then
			arg_395_1.duration_ = var_395_0[var_395_1]
		end

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play103703100(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 and not isNil(arg_395_1.actors_["1037ui_story"]) and arg_395_1.var_.characterEffect1037ui_story == nil then
				arg_395_1.var_.characterEffect1037ui_story = arg_395_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_0 = 0.2

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_0 and not isNil(arg_395_1.actors_["1037ui_story"]) then
				if arg_395_1.var_.characterEffect1037ui_story and not isNil(arg_395_1.actors_["1037ui_story"]) then
					arg_395_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_395_1.time_ >= 0 + var_398_0 and arg_395_1.time_ < 0 + var_398_0 + arg_398_0 and not isNil(arg_395_1.actors_["1037ui_story"]) and arg_395_1.var_.characterEffect1037ui_story then
				arg_395_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037actionlink/1037action442")
			end

			local var_398_2 = 0
			local var_398_3 = 0.375

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_2 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_4 = arg_395_1:GetWordFromCfg(103703099)
				local var_398_5 = arg_395_1:FormatText(var_398_4.content)

				arg_395_1.text_.text = var_398_5

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_7 = 15 <= 0 and var_398_3 or var_398_3 * (utf8.len(var_398_5) / 15)

				if (15 <= 0 and var_398_3 or var_398_3 * (utf8.len(var_398_5) / 15)) > 0 and var_398_3 < var_398_7 then
					arg_395_1.talkMaxDuration = var_398_7

					if var_398_7 + var_398_2 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_7 + var_398_2
					end
				end

				arg_395_1.text_.text = var_398_5
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703099", "story_v_side_old_103703.awb") ~= 0 then
					local var_398_8 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703099", "story_v_side_old_103703.awb") / 1000

					if var_398_8 + var_398_2 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_8 + var_398_2
					end

					if var_398_4.prefab_name ~= "" and arg_395_1.actors_[var_398_4.prefab_name] ~= nil then
						local var_398_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_4.prefab_name].transform, "story_v_side_old_103703", "103703099", "story_v_side_old_103703.awb")

						arg_395_1:RecordAudio("103703099", var_398_9)
						arg_395_1:RecordAudio("103703099", var_398_9)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703099", "story_v_side_old_103703.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703099", "story_v_side_old_103703.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_10 = math.max(var_398_3, arg_395_1.talkMaxDuration)

			if var_398_2 <= arg_395_1.time_ and arg_395_1.time_ < var_398_2 + var_398_10 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_2) / var_398_10

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_2 + var_398_10 and arg_395_1.time_ < var_398_2 + var_398_10 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play103703100 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 103703100
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play103703101(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1.var_.moveOldPos1037ui_story = arg_399_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_402_0 = 0.001

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_0 then
				arg_399_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_399_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_399_1.time_ - 0) / var_402_0)
				arg_399_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_399_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_399_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_399_1.actors_["1037ui_story"].transform.position).z)
				arg_399_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_399_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_399_1.actors_["1037ui_story"].transform.localEulerAngles = arg_399_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_399_1.time_ >= 0 + var_402_0 and arg_399_1.time_ < 0 + var_402_0 + arg_402_0 then
				arg_399_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_399_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_399_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_399_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_399_1.actors_["1037ui_story"].transform.position).z)
				arg_399_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_399_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_399_1.actors_["1037ui_story"].transform.localEulerAngles = arg_399_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_402_1 = 0
			local var_402_2 = 0.4

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_1 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, false)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_3 = arg_399_1:FormatText(arg_399_1:GetWordFromCfg(103703100).content)

				arg_399_1.text_.text = var_402_3

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_5 = 16 <= 0 and var_402_2 or var_402_2 * (utf8.len(var_402_3) / 16)

				if (16 <= 0 and var_402_2 or var_402_2 * (utf8.len(var_402_3) / 16)) > 0 and var_402_2 < var_402_5 then
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

		arg_399_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_399_1:InitPlayNodeList()
	end,
	Play103703101 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 103703101
		arg_403_1.duration_ = 9.7

		local var_403_0 = {
			ja = 9.7,
			ko = 6.666,
			en = 4.533
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play103703102(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.var_.moveOldPos1027ui_story = arg_403_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_406_0 = 0.001

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_0 then
				arg_403_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_403_1.time_ - 0) / var_406_0)
				arg_403_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_403_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1027ui_story"].transform.position).z)
				arg_403_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_403_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_403_1.actors_["1027ui_story"].transform.localEulerAngles = arg_403_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_403_1.time_ >= 0 + var_406_0 and arg_403_1.time_ < 0 + var_406_0 + arg_406_0 then
				arg_403_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, -0.81, -5.8)
				arg_403_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_403_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1027ui_story"].transform.position).z)
				arg_403_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_403_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_403_1.actors_["1027ui_story"].transform.localEulerAngles = arg_403_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_406_1 = arg_403_1.actors_["1027ui_story"]

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(var_406_1) and arg_403_1.var_.characterEffect1027ui_story == nil then
				arg_403_1.var_.characterEffect1027ui_story = var_406_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_2 = 0.2

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_2 and not isNil(var_406_1) then
				if arg_403_1.var_.characterEffect1027ui_story and not isNil(var_406_1) then
					arg_403_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_403_1.time_ >= 0 + var_406_2 and arg_403_1.time_ < 0 + var_406_2 + arg_406_0 and not isNil(var_406_1) and arg_403_1.var_.characterEffect1027ui_story then
				arg_403_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action3_1")
			end

			local var_406_4 = 0
			local var_406_5 = 0.65

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_4 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_6 = arg_403_1:GetWordFromCfg(103703101)
				local var_406_7 = arg_403_1:FormatText(var_406_6.content)

				arg_403_1.text_.text = var_406_7

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_9 = 26 <= 0 and var_406_5 or var_406_5 * (utf8.len(var_406_7) / 26)

				if (26 <= 0 and var_406_5 or var_406_5 * (utf8.len(var_406_7) / 26)) > 0 and var_406_5 < var_406_9 then
					arg_403_1.talkMaxDuration = var_406_9

					if var_406_9 + var_406_4 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_9 + var_406_4
					end
				end

				arg_403_1.text_.text = var_406_7
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703101", "story_v_side_old_103703.awb") ~= 0 then
					local var_406_10 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703101", "story_v_side_old_103703.awb") / 1000

					if var_406_10 + var_406_4 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_10 + var_406_4
					end

					if var_406_6.prefab_name ~= "" and arg_403_1.actors_[var_406_6.prefab_name] ~= nil then
						local var_406_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_6.prefab_name].transform, "story_v_side_old_103703", "103703101", "story_v_side_old_103703.awb")

						arg_403_1:RecordAudio("103703101", var_406_11)
						arg_403_1:RecordAudio("103703101", var_406_11)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703101", "story_v_side_old_103703.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703101", "story_v_side_old_103703.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_12 = math.max(var_406_5, arg_403_1.talkMaxDuration)

			if var_406_4 <= arg_403_1.time_ and arg_403_1.time_ < var_406_4 + var_406_12 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_4) / var_406_12

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_4 + var_406_12 and arg_403_1.time_ < var_406_4 + var_406_12 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_403_1:InitPlayNodeList()
	end,
	Play103703102 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 103703102
		arg_407_1.duration_ = 6.2

		local var_407_0 = {
			ja = 6.2,
			ko = 4.6,
			en = 4.1
		}
		local var_407_1 = manager.audio:GetLocalizationFlag()

		if var_407_0[var_407_1] ~= nil then
			arg_407_1.duration_ = var_407_0[var_407_1]
		end

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play103703103(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.var_.moveOldPos1027ui_story = arg_407_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_410_0 = 0.001

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_0 then
				arg_407_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos1027ui_story, Vector3.New(-0.7, -0.81, -5.8), (arg_407_1.time_ - 0) / var_410_0)
				arg_407_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_407_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["1027ui_story"].transform.position).z)
				arg_407_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_407_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_407_1.actors_["1027ui_story"].transform.localEulerAngles = arg_407_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_407_1.time_ >= 0 + var_410_0 and arg_407_1.time_ < 0 + var_410_0 + arg_410_0 then
				arg_407_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(-0.7, -0.81, -5.8)
				arg_407_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_407_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["1027ui_story"].transform.position).z)
				arg_407_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_407_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_407_1.actors_["1027ui_story"].transform.localEulerAngles = arg_407_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_410_1 = arg_407_1.actors_["1080ui_story"].transform

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.var_.moveOldPos1080ui_story = var_410_1.localPosition
			end

			local var_410_2 = 0.001

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_2 then
				var_410_1.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos1080ui_story, Vector3.New(0.7, -1.01, -6.05), (arg_407_1.time_ - 0) / var_410_2)
				var_410_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_410_1.position).x, (manager.ui.mainCamera.transform.position - var_410_1.position).y, (manager.ui.mainCamera.transform.position - var_410_1.position).z)
				var_410_1.localEulerAngles.z = 0
				var_410_1.localEulerAngles.x = 0
				var_410_1.localEulerAngles = var_410_1.localEulerAngles
			end

			if arg_407_1.time_ >= 0 + var_410_2 and arg_407_1.time_ < 0 + var_410_2 + arg_410_0 then
				var_410_1.localPosition = Vector3.New(0.7, -1.01, -6.05)
				var_410_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_410_1.position).x, (manager.ui.mainCamera.transform.position - var_410_1.position).y, (manager.ui.mainCamera.transform.position - var_410_1.position).z)
				var_410_1.localEulerAngles.z = 0
				var_410_1.localEulerAngles.x = 0
				var_410_1.localEulerAngles = var_410_1.localEulerAngles
			end

			local var_410_3 = arg_407_1.actors_["1027ui_story"]

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(var_410_3) and arg_407_1.var_.characterEffect1027ui_story == nil then
				arg_407_1.var_.characterEffect1027ui_story = var_410_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_4 = 0.2

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_4 and not isNil(var_410_3) then
				if arg_407_1.var_.characterEffect1027ui_story and not isNil(var_410_3) then
					arg_407_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_407_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_407_1.time_ - 0) / var_410_4)
				end
			end

			if arg_407_1.time_ >= 0 + var_410_4 and arg_407_1.time_ < 0 + var_410_4 + arg_410_0 and not isNil(var_410_3) and arg_407_1.var_.characterEffect1027ui_story then
				arg_407_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_407_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_410_5 = arg_407_1.actors_["1080ui_story"]

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(var_410_5) and arg_407_1.var_.characterEffect1080ui_story == nil then
				arg_407_1.var_.characterEffect1080ui_story = var_410_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_6 = 0.2

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_6 and not isNil(var_410_5) then
				if arg_407_1.var_.characterEffect1080ui_story and not isNil(var_410_5) then
					arg_407_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_407_1.time_ >= 0 + var_410_6 and arg_407_1.time_ < 0 + var_410_6 + arg_410_0 and not isNil(var_410_5) and arg_407_1.var_.characterEffect1080ui_story then
				arg_407_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_1")
			end

			local var_410_8 = 0
			local var_410_9 = 0.525

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_8 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_10 = arg_407_1:GetWordFromCfg(103703102)
				local var_410_11 = arg_407_1:FormatText(var_410_10.content)

				arg_407_1.text_.text = var_410_11

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_13 = 21 <= 0 and var_410_9 or var_410_9 * (utf8.len(var_410_11) / 21)

				if (21 <= 0 and var_410_9 or var_410_9 * (utf8.len(var_410_11) / 21)) > 0 and var_410_9 < var_410_13 then
					arg_407_1.talkMaxDuration = var_410_13

					if var_410_13 + var_410_8 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_13 + var_410_8
					end
				end

				arg_407_1.text_.text = var_410_11
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703102", "story_v_side_old_103703.awb") ~= 0 then
					local var_410_14 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703102", "story_v_side_old_103703.awb") / 1000

					if var_410_14 + var_410_8 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_14 + var_410_8
					end

					if var_410_10.prefab_name ~= "" and arg_407_1.actors_[var_410_10.prefab_name] ~= nil then
						local var_410_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_10.prefab_name].transform, "story_v_side_old_103703", "103703102", "story_v_side_old_103703.awb")

						arg_407_1:RecordAudio("103703102", var_410_15)
						arg_407_1:RecordAudio("103703102", var_410_15)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703102", "story_v_side_old_103703.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703102", "story_v_side_old_103703.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_16 = math.max(var_410_9, arg_407_1.talkMaxDuration)

			if var_410_8 <= arg_407_1.time_ and arg_407_1.time_ < var_410_8 + var_410_16 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_8) / var_410_16

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_8 + var_410_16 and arg_407_1.time_ < var_410_8 + var_410_16 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_407_1:InitPlayNodeList()
	end,
	Play103703103 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 103703103
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play103703104(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 and not isNil(arg_411_1.actors_["1080ui_story"]) and arg_411_1.var_.characterEffect1080ui_story == nil then
				arg_411_1.var_.characterEffect1080ui_story = arg_411_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_0 = 0.2

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_0 and not isNil(arg_411_1.actors_["1080ui_story"]) then
				if arg_411_1.var_.characterEffect1080ui_story and not isNil(arg_411_1.actors_["1080ui_story"]) then
					arg_411_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_411_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_411_1.time_ - 0) / var_414_0)
				end
			end

			if arg_411_1.time_ >= 0 + var_414_0 and arg_411_1.time_ < 0 + var_414_0 + arg_414_0 and not isNil(arg_411_1.actors_["1080ui_story"]) and arg_411_1.var_.characterEffect1080ui_story then
				arg_411_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_411_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_414_1 = 0
			local var_414_2 = 0.55

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, true)
				arg_411_1.iconController_:SetSelectedState("hero")

				arg_411_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_411_1.callingController_:SetSelectedState("normal")

				arg_411_1.keyicon_.color = Color.New(1, 1, 1)
				arg_411_1.icon_.color = Color.New(1, 1, 1)

				local var_414_3 = arg_411_1:FormatText(arg_411_1:GetWordFromCfg(103703103).content)

				arg_411_1.text_.text = var_414_3

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_5 = 22 <= 0 and var_414_2 or var_414_2 * (utf8.len(var_414_3) / 22)

				if (22 <= 0 and var_414_2 or var_414_2 * (utf8.len(var_414_3) / 22)) > 0 and var_414_2 < var_414_5 then
					arg_411_1.talkMaxDuration = var_414_5

					if var_414_5 + var_414_1 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_5 + var_414_1
					end
				end

				arg_411_1.text_.text = var_414_3
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_6 = math.max(var_414_2, arg_411_1.talkMaxDuration)

			if var_414_1 <= arg_411_1.time_ and arg_411_1.time_ < var_414_1 + var_414_6 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_1) / var_414_6

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_1 + var_414_6 and arg_411_1.time_ < var_414_1 + var_414_6 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play103703104 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 103703104
		arg_415_1.duration_ = 5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play103703105(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 0.575

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
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

				local var_418_1 = arg_415_1:FormatText(arg_415_1:GetWordFromCfg(103703104).content)

				arg_415_1.text_.text = var_418_1

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_3 = 23 <= 0 and var_418_0 or var_418_0 * (utf8.len(var_418_1) / 23)

				if (23 <= 0 and var_418_0 or var_418_0 * (utf8.len(var_418_1) / 23)) > 0 and var_418_0 < var_418_3 then
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
	Play103703105 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 103703105
		arg_419_1.duration_ = 4.5

		local var_419_0 = {
			ja = 4.233,
			ko = 4.233,
			en = 4.5
		}
		local var_419_1 = manager.audio:GetLocalizationFlag()

		if var_419_0[var_419_1] ~= nil then
			arg_419_1.duration_ = var_419_0[var_419_1]
		end

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play103703106(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 and not isNil(arg_419_1.actors_["1027ui_story"]) and arg_419_1.var_.characterEffect1027ui_story == nil then
				arg_419_1.var_.characterEffect1027ui_story = arg_419_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_0 = 0.2

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_0 and not isNil(arg_419_1.actors_["1027ui_story"]) then
				if arg_419_1.var_.characterEffect1027ui_story and not isNil(arg_419_1.actors_["1027ui_story"]) then
					arg_419_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_419_1.time_ >= 0 + var_422_0 and arg_419_1.time_ < 0 + var_422_0 + arg_422_0 and not isNil(arg_419_1.actors_["1027ui_story"]) and arg_419_1.var_.characterEffect1027ui_story then
				arg_419_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action434")
			end

			local var_422_2 = 0
			local var_422_3 = 0.45

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_2 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_4 = arg_419_1:GetWordFromCfg(103703105)
				local var_422_5 = arg_419_1:FormatText(var_422_4.content)

				arg_419_1.text_.text = var_422_5

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_7 = 18 <= 0 and var_422_3 or var_422_3 * (utf8.len(var_422_5) / 18)

				if (18 <= 0 and var_422_3 or var_422_3 * (utf8.len(var_422_5) / 18)) > 0 and var_422_3 < var_422_7 then
					arg_419_1.talkMaxDuration = var_422_7

					if var_422_7 + var_422_2 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_7 + var_422_2
					end
				end

				arg_419_1.text_.text = var_422_5
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703105", "story_v_side_old_103703.awb") ~= 0 then
					local var_422_8 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703105", "story_v_side_old_103703.awb") / 1000

					if var_422_8 + var_422_2 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_8 + var_422_2
					end

					if var_422_4.prefab_name ~= "" and arg_419_1.actors_[var_422_4.prefab_name] ~= nil then
						local var_422_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_4.prefab_name].transform, "story_v_side_old_103703", "103703105", "story_v_side_old_103703.awb")

						arg_419_1:RecordAudio("103703105", var_422_9)
						arg_419_1:RecordAudio("103703105", var_422_9)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703105", "story_v_side_old_103703.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703105", "story_v_side_old_103703.awb")
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
	Play103703106 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 103703106
		arg_423_1.duration_ = 4.97

		local var_423_0 = {
			ja = 1.999999999999,
			ko = 2.9,
			en = 4.966
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
				arg_423_0:Play103703107(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(arg_423_1.actors_["1027ui_story"]) and arg_423_1.var_.characterEffect1027ui_story == nil then
				arg_423_1.var_.characterEffect1027ui_story = arg_423_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_0 = 0.2

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_0 and not isNil(arg_423_1.actors_["1027ui_story"]) then
				if arg_423_1.var_.characterEffect1027ui_story and not isNil(arg_423_1.actors_["1027ui_story"]) then
					arg_423_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_423_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_423_1.time_ - 0) / var_426_0)
				end
			end

			if arg_423_1.time_ >= 0 + var_426_0 and arg_423_1.time_ < 0 + var_426_0 + arg_426_0 and not isNil(arg_423_1.actors_["1027ui_story"]) and arg_423_1.var_.characterEffect1027ui_story then
				arg_423_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_423_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_426_1 = arg_423_1.actors_["1080ui_story"]

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(var_426_1) and arg_423_1.var_.characterEffect1080ui_story == nil then
				arg_423_1.var_.characterEffect1080ui_story = var_426_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_2 = 0.2

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_2 and not isNil(var_426_1) then
				if arg_423_1.var_.characterEffect1080ui_story and not isNil(var_426_1) then
					arg_423_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_423_1.time_ >= 0 + var_426_2 and arg_423_1.time_ < 0 + var_426_2 + arg_426_0 and not isNil(var_426_1) and arg_423_1.var_.characterEffect1080ui_story then
				arg_423_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080actionlink/1080action427")
			end

			local var_426_4 = 0
			local var_426_5 = 0.2

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_4 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_6 = arg_423_1:GetWordFromCfg(103703106)
				local var_426_7 = arg_423_1:FormatText(var_426_6.content)

				arg_423_1.text_.text = var_426_7

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_9 = 8 <= 0 and var_426_5 or var_426_5 * (utf8.len(var_426_7) / 8)

				if (8 <= 0 and var_426_5 or var_426_5 * (utf8.len(var_426_7) / 8)) > 0 and var_426_5 < var_426_9 then
					arg_423_1.talkMaxDuration = var_426_9

					if var_426_9 + var_426_4 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_9 + var_426_4
					end
				end

				arg_423_1.text_.text = var_426_7
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703106", "story_v_side_old_103703.awb") ~= 0 then
					local var_426_10 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703106", "story_v_side_old_103703.awb") / 1000

					if var_426_10 + var_426_4 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_10 + var_426_4
					end

					if var_426_6.prefab_name ~= "" and arg_423_1.actors_[var_426_6.prefab_name] ~= nil then
						local var_426_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_6.prefab_name].transform, "story_v_side_old_103703", "103703106", "story_v_side_old_103703.awb")

						arg_423_1:RecordAudio("103703106", var_426_11)
						arg_423_1:RecordAudio("103703106", var_426_11)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703106", "story_v_side_old_103703.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703106", "story_v_side_old_103703.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_12 = math.max(var_426_5, arg_423_1.talkMaxDuration)

			if var_426_4 <= arg_423_1.time_ and arg_423_1.time_ < var_426_4 + var_426_12 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_4) / var_426_12

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_4 + var_426_12 and arg_423_1.time_ < var_426_4 + var_426_12 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play103703107 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 103703107
		arg_427_1.duration_ = 5

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play103703108(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(arg_427_1.actors_["1080ui_story"]) and arg_427_1.var_.characterEffect1080ui_story == nil then
				arg_427_1.var_.characterEffect1080ui_story = arg_427_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_0 = 0.2

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_0 and not isNil(arg_427_1.actors_["1080ui_story"]) then
				if arg_427_1.var_.characterEffect1080ui_story and not isNil(arg_427_1.actors_["1080ui_story"]) then
					arg_427_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_427_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_427_1.time_ - 0) / var_430_0)
				end
			end

			if arg_427_1.time_ >= 0 + var_430_0 and arg_427_1.time_ < 0 + var_430_0 + arg_430_0 and not isNil(arg_427_1.actors_["1080ui_story"]) and arg_427_1.var_.characterEffect1080ui_story then
				arg_427_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_427_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_430_1 = 0
			local var_430_2 = 0.5

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_1 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, true)
				arg_427_1.iconController_:SetSelectedState("hero")

				arg_427_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_427_1.callingController_:SetSelectedState("normal")

				arg_427_1.keyicon_.color = Color.New(1, 1, 1)
				arg_427_1.icon_.color = Color.New(1, 1, 1)

				local var_430_3 = arg_427_1:FormatText(arg_427_1:GetWordFromCfg(103703107).content)

				arg_427_1.text_.text = var_430_3

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_5 = 20 <= 0 and var_430_2 or var_430_2 * (utf8.len(var_430_3) / 20)

				if (20 <= 0 and var_430_2 or var_430_2 * (utf8.len(var_430_3) / 20)) > 0 and var_430_2 < var_430_5 then
					arg_427_1.talkMaxDuration = var_430_5

					if var_430_5 + var_430_1 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_5 + var_430_1
					end
				end

				arg_427_1.text_.text = var_430_3
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_6 = math.max(var_430_2, arg_427_1.talkMaxDuration)

			if var_430_1 <= arg_427_1.time_ and arg_427_1.time_ < var_430_1 + var_430_6 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_1) / var_430_6

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_1 + var_430_6 and arg_427_1.time_ < var_430_1 + var_430_6 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play103703108 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 103703108
		arg_431_1.duration_ = 1.57

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play103703109(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1.var_.moveOldPos1027ui_story = arg_431_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_434_0 = 0.001

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_0 then
				arg_431_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_431_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_431_1.time_ - 0) / var_434_0)
				arg_431_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_431_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_431_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_431_1.actors_["1027ui_story"].transform.position).z)
				arg_431_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_431_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_431_1.actors_["1027ui_story"].transform.localEulerAngles = arg_431_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_431_1.time_ >= 0 + var_434_0 and arg_431_1.time_ < 0 + var_434_0 + arg_434_0 then
				arg_431_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_431_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_431_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_431_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_431_1.actors_["1027ui_story"].transform.position).z)
				arg_431_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_431_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_431_1.actors_["1027ui_story"].transform.localEulerAngles = arg_431_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_434_1 = arg_431_1.actors_["1080ui_story"].transform

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1.var_.moveOldPos1080ui_story = var_434_1.localPosition
			end

			local var_434_2 = 0.001

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_2 then
				var_434_1.localPosition = Vector3.Lerp(arg_431_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_431_1.time_ - 0) / var_434_2)
				var_434_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_434_1.position).x, (manager.ui.mainCamera.transform.position - var_434_1.position).y, (manager.ui.mainCamera.transform.position - var_434_1.position).z)
				var_434_1.localEulerAngles.z = 0
				var_434_1.localEulerAngles.x = 0
				var_434_1.localEulerAngles = var_434_1.localEulerAngles
			end

			if arg_431_1.time_ >= 0 + var_434_2 and arg_431_1.time_ < 0 + var_434_2 + arg_434_0 then
				var_434_1.localPosition = Vector3.New(0, 100, 0)
				var_434_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_434_1.position).x, (manager.ui.mainCamera.transform.position - var_434_1.position).y, (manager.ui.mainCamera.transform.position - var_434_1.position).z)
				var_434_1.localEulerAngles.z = 0
				var_434_1.localEulerAngles.x = 0
				var_434_1.localEulerAngles = var_434_1.localEulerAngles
			end

			local var_434_3 = 0
			local var_434_4 = 0.1

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_3 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				arg_431_1.leftNameTxt_.text = arg_431_1:FormatText(StoryNameCfg[113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_5 = arg_431_1:GetWordFromCfg(103703108)
				local var_434_6 = arg_431_1:FormatText(var_434_5.content)

				arg_431_1.text_.text = var_434_6

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_8 = 4 <= 0 and var_434_4 or var_434_4 * (utf8.len(var_434_6) / 4)

				if (4 <= 0 and var_434_4 or var_434_4 * (utf8.len(var_434_6) / 4)) > 0 and var_434_4 < var_434_8 then
					arg_431_1.talkMaxDuration = var_434_8

					if var_434_8 + var_434_3 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_8 + var_434_3
					end
				end

				arg_431_1.text_.text = var_434_6
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703108", "story_v_side_old_103703.awb") ~= 0 then
					local var_434_9 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703108", "story_v_side_old_103703.awb") / 1000

					if var_434_9 + var_434_3 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_9 + var_434_3
					end

					if var_434_5.prefab_name ~= "" and arg_431_1.actors_[var_434_5.prefab_name] ~= nil then
						local var_434_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_5.prefab_name].transform, "story_v_side_old_103703", "103703108", "story_v_side_old_103703.awb")

						arg_431_1:RecordAudio("103703108", var_434_10)
						arg_431_1:RecordAudio("103703108", var_434_10)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703108", "story_v_side_old_103703.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703108", "story_v_side_old_103703.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_11 = math.max(var_434_4, arg_431_1.talkMaxDuration)

			if var_434_3 <= arg_431_1.time_ and arg_431_1.time_ < var_434_3 + var_434_11 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_3) / var_434_11

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_3 + var_434_11 and arg_431_1.time_ < var_434_3 + var_434_11 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_431_1:InitPlayNodeList()
	end,
	Play103703109 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 103703109
		arg_435_1.duration_ = 8

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play103703110(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			if arg_435_1.bgs_.B13 == nil then
				local var_438_0 = Object.Instantiate(arg_435_1.paintGo_)

				var_438_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B13")
				var_438_0.name = "B13"
				var_438_0.transform.parent = arg_435_1.stage_.transform
				var_438_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_435_1.bgs_.B13 = var_438_0
			end

			if 1.5 < arg_435_1.time_ and arg_435_1.time_ <= 1.5 + arg_438_0 then
				local var_438_1 = arg_435_1.bgs_.B13

				arg_435_1.bgs_.B13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_438_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_438_2 = var_438_1:GetComponent("SpriteRenderer")

				if var_438_2 and var_438_2.sprite then
					local var_438_3 = 2 * (var_438_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_438_1.transform.localScale = Vector3.New(var_438_3 / var_438_2.sprite.bounds.size.y < var_438_3 * manager.ui.mainCameraCom_.aspect / var_438_2.sprite.bounds.size.x and var_438_3 * manager.ui.mainCameraCom_.aspect / var_438_2.sprite.bounds.size.x or var_438_3 / var_438_2.sprite.bounds.size.y, var_438_3 / var_438_2.sprite.bounds.size.y < var_438_3 * manager.ui.mainCameraCom_.aspect / var_438_2.sprite.bounds.size.x and var_438_3 * manager.ui.mainCameraCom_.aspect / var_438_2.sprite.bounds.size.x or var_438_3 / var_438_2.sprite.bounds.size.y, 0)
				end

				for iter_438_0, iter_438_1 in pairs(arg_435_1.bgs_) do
					if iter_438_0 ~= "B13" then
						iter_438_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				local var_438_4 = arg_435_1.bgs_.A00:GetComponent("SpriteRenderer")

				if var_438_4 then
					arg_435_1.var_.alphaOldValueA00 = var_438_4.color.a
					arg_435_1.var_.alphaMatValueA00 = var_438_4
				end

				arg_435_1.var_.alphaOldValueA00 = 1
			end

			local var_438_5 = 1.5

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_5 then
				if arg_435_1.var_.alphaMatValueA00 then
					arg_435_1.var_.alphaMatValueA00.color.a = Mathf.Lerp(arg_435_1.var_.alphaOldValueA00, 0, (arg_435_1.time_ - 0) / var_438_5)
					arg_435_1.var_.alphaMatValueA00.color = arg_435_1.var_.alphaMatValueA00.color
				end
			end

			if arg_435_1.time_ >= 0 + var_438_5 and arg_435_1.time_ < 0 + var_438_5 + arg_438_0 and arg_435_1.var_.alphaMatValueA00 then
				arg_435_1.var_.alphaMatValueA00.color.a = 0
				arg_435_1.var_.alphaMatValueA00.color = arg_435_1.var_.alphaMatValueA00.color
			end

			if 1.5 < arg_435_1.time_ and arg_435_1.time_ <= 1.5 + arg_438_0 then
				local var_438_6 = arg_435_1.bgs_.B13:GetComponent("SpriteRenderer")

				if var_438_6 then
					arg_435_1.var_.alphaOldValueB13 = var_438_6.color.a
					arg_435_1.var_.alphaMatValueB13 = var_438_6
				end

				arg_435_1.var_.alphaOldValueB13 = 0
			end

			local var_438_7 = 1.5

			if 1.5 <= arg_435_1.time_ and arg_435_1.time_ < 1.5 + var_438_7 then
				if arg_435_1.var_.alphaMatValueB13 then
					arg_435_1.var_.alphaMatValueB13.color.a = Mathf.Lerp(arg_435_1.var_.alphaOldValueB13, 1, (arg_435_1.time_ - 1.5) / var_438_7)
					arg_435_1.var_.alphaMatValueB13.color = arg_435_1.var_.alphaMatValueB13.color
				end
			end

			if arg_435_1.time_ >= 1.5 + var_438_7 and arg_435_1.time_ < 1.5 + var_438_7 + arg_438_0 and arg_435_1.var_.alphaMatValueB13 then
				arg_435_1.var_.alphaMatValueB13.color.a = 1
				arg_435_1.var_.alphaMatValueB13.color = arg_435_1.var_.alphaMatValueB13.color
			end

			if arg_435_1.frameCnt_ <= 1 then
				arg_435_1.dialog_:SetActive(false)
			end

			local var_438_8 = 3
			local var_438_9 = 0.7

			if 3 < arg_435_1.time_ and arg_435_1.time_ <= var_438_8 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0

				arg_435_1.dialog_:SetActive(true)

				arg_435_1.dialogCg_.alpha = 0

				local var_438_10 = LeanTween.value(arg_435_1.dialog_, 0, 1, 0.3)

				var_438_10:setOnUpdate(LuaHelper.FloatAction(function(arg_439_0)
					arg_435_1.dialogCg_.alpha = arg_439_0
				end))
				var_438_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_435_1.dialog_)
					var_438_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_435_1.duration_ = arg_435_1.duration_ + 0.3

				SetActive(arg_435_1.leftNameGo_, false)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_11 = arg_435_1:FormatText(arg_435_1:GetWordFromCfg(103703109).content)

				arg_435_1.text_.text = var_438_11

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_13 = 28 <= 0 and var_438_9 or var_438_9 * (utf8.len(var_438_11) / 28)

				if (28 <= 0 and var_438_9 or var_438_9 * (utf8.len(var_438_11) / 28)) > 0 and var_438_9 < var_438_13 then
					arg_435_1.talkMaxDuration = var_438_13
					var_438_8 = var_438_8 + 0.3

					if var_438_13 + var_438_8 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_13 + var_438_8
					end
				end

				arg_435_1.text_.text = var_438_11
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_14 = var_438_8 + 0.3
			local var_438_15 = math.max(var_438_9, arg_435_1.talkMaxDuration)

			if var_438_8 + 0.3 <= arg_435_1.time_ and arg_435_1.time_ < var_438_14 + var_438_15 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_14) / var_438_15

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_14 + var_438_15 and arg_435_1.time_ < var_438_14 + var_438_15 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play103703110 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 103703110
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play103703111(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = 0.225

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				arg_441_1.leftNameTxt_.text = arg_441_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, true)
				arg_441_1.iconController_:SetSelectedState("hero")

				arg_441_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_441_1.callingController_:SetSelectedState("normal")

				arg_441_1.keyicon_.color = Color.New(1, 1, 1)
				arg_441_1.icon_.color = Color.New(1, 1, 1)

				local var_444_1 = arg_441_1:FormatText(arg_441_1:GetWordFromCfg(103703110).content)

				arg_441_1.text_.text = var_444_1

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_3 = 9 <= 0 and var_444_0 or var_444_0 * (utf8.len(var_444_1) / 9)

				if (9 <= 0 and var_444_0 or var_444_0 * (utf8.len(var_444_1) / 9)) > 0 and var_444_0 < var_444_3 then
					arg_441_1.talkMaxDuration = var_444_3

					if var_444_3 + 0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_3 + 0
					end
				end

				arg_441_1.text_.text = var_444_1
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)
				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_4 = math.max(var_444_0, arg_441_1.talkMaxDuration)

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_4 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - 0) / var_444_4

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= 0 + var_444_4 and arg_441_1.time_ < 0 + var_444_4 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play103703111 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 103703111
		arg_445_1.duration_ = 7.63

		local var_445_0 = {
			ja = 6.866,
			ko = 7.633,
			en = 7.433
		}
		local var_445_1 = manager.audio:GetLocalizationFlag()

		if var_445_0[var_445_1] ~= nil then
			arg_445_1.duration_ = var_445_0[var_445_1]
		end

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play103703112(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1.var_.moveOldPos1037ui_story = arg_445_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_448_0 = 0.001

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_0 then
				arg_445_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_445_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_445_1.time_ - 0) / var_448_0)
				arg_445_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_445_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_445_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_445_1.actors_["1037ui_story"].transform.position).z)
				arg_445_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_445_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_445_1.actors_["1037ui_story"].transform.localEulerAngles = arg_445_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_445_1.time_ >= 0 + var_448_0 and arg_445_1.time_ < 0 + var_448_0 + arg_448_0 then
				arg_445_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, -1.09, -5.81)
				arg_445_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_445_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_445_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_445_1.actors_["1037ui_story"].transform.position).z)
				arg_445_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_445_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_445_1.actors_["1037ui_story"].transform.localEulerAngles = arg_445_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_448_1 = arg_445_1.actors_["1037ui_story"]

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 and not isNil(var_448_1) and arg_445_1.var_.characterEffect1037ui_story == nil then
				arg_445_1.var_.characterEffect1037ui_story = var_448_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_2 = 0.2

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_2 and not isNil(var_448_1) then
				if arg_445_1.var_.characterEffect1037ui_story and not isNil(var_448_1) then
					arg_445_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_445_1.time_ >= 0 + var_448_2 and arg_445_1.time_ < 0 + var_448_2 + arg_448_0 and not isNil(var_448_1) and arg_445_1.var_.characterEffect1037ui_story then
				arg_445_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			local var_448_4 = 0
			local var_448_5 = 0.825

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_4 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				arg_445_1.leftNameTxt_.text = arg_445_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_6 = arg_445_1:GetWordFromCfg(103703111)
				local var_448_7 = arg_445_1:FormatText(var_448_6.content)

				arg_445_1.text_.text = var_448_7

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_9 = 33 <= 0 and var_448_5 or var_448_5 * (utf8.len(var_448_7) / 33)

				if (33 <= 0 and var_448_5 or var_448_5 * (utf8.len(var_448_7) / 33)) > 0 and var_448_5 < var_448_9 then
					arg_445_1.talkMaxDuration = var_448_9

					if var_448_9 + var_448_4 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_9 + var_448_4
					end
				end

				arg_445_1.text_.text = var_448_7
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703111", "story_v_side_old_103703.awb") ~= 0 then
					local var_448_10 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703111", "story_v_side_old_103703.awb") / 1000

					if var_448_10 + var_448_4 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_10 + var_448_4
					end

					if var_448_6.prefab_name ~= "" and arg_445_1.actors_[var_448_6.prefab_name] ~= nil then
						local var_448_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_6.prefab_name].transform, "story_v_side_old_103703", "103703111", "story_v_side_old_103703.awb")

						arg_445_1:RecordAudio("103703111", var_448_11)
						arg_445_1:RecordAudio("103703111", var_448_11)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703111", "story_v_side_old_103703.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703111", "story_v_side_old_103703.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_12 = math.max(var_448_5, arg_445_1.talkMaxDuration)

			if var_448_4 <= arg_445_1.time_ and arg_445_1.time_ < var_448_4 + var_448_12 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_4) / var_448_12

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_4 + var_448_12 and arg_445_1.time_ < var_448_4 + var_448_12 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_445_1:InitPlayNodeList()
	end,
	Play103703112 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 103703112
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play103703113(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 and not isNil(arg_449_1.actors_["1037ui_story"]) and arg_449_1.var_.characterEffect1037ui_story == nil then
				arg_449_1.var_.characterEffect1037ui_story = arg_449_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_0 = 0.2

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_0 and not isNil(arg_449_1.actors_["1037ui_story"]) then
				if arg_449_1.var_.characterEffect1037ui_story and not isNil(arg_449_1.actors_["1037ui_story"]) then
					arg_449_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_449_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_449_1.time_ - 0) / var_452_0)
				end
			end

			if arg_449_1.time_ >= 0 + var_452_0 and arg_449_1.time_ < 0 + var_452_0 + arg_452_0 and not isNil(arg_449_1.actors_["1037ui_story"]) and arg_449_1.var_.characterEffect1037ui_story then
				arg_449_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_449_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_452_1 = 0
			local var_452_2 = 0.55

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_1 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, true)
				arg_449_1.iconController_:SetSelectedState("hero")

				arg_449_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_449_1.callingController_:SetSelectedState("normal")

				arg_449_1.keyicon_.color = Color.New(1, 1, 1)
				arg_449_1.icon_.color = Color.New(1, 1, 1)

				local var_452_3 = arg_449_1:FormatText(arg_449_1:GetWordFromCfg(103703112).content)

				arg_449_1.text_.text = var_452_3

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_5 = 22 <= 0 and var_452_2 or var_452_2 * (utf8.len(var_452_3) / 22)

				if (22 <= 0 and var_452_2 or var_452_2 * (utf8.len(var_452_3) / 22)) > 0 and var_452_2 < var_452_5 then
					arg_449_1.talkMaxDuration = var_452_5

					if var_452_5 + var_452_1 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_5 + var_452_1
					end
				end

				arg_449_1.text_.text = var_452_3
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_6 = math.max(var_452_2, arg_449_1.talkMaxDuration)

			if var_452_1 <= arg_449_1.time_ and arg_449_1.time_ < var_452_1 + var_452_6 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_1) / var_452_6

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_1 + var_452_6 and arg_449_1.time_ < var_452_1 + var_452_6 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play103703113 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 103703113
		arg_453_1.duration_ = 7.93

		local var_453_0 = {
			ja = 7.933,
			ko = 5.566,
			en = 4.533
		}
		local var_453_1 = manager.audio:GetLocalizationFlag()

		if var_453_0[var_453_1] ~= nil then
			arg_453_1.duration_ = var_453_0[var_453_1]
		end

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play103703114(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 and not isNil(arg_453_1.actors_["1037ui_story"]) and arg_453_1.var_.characterEffect1037ui_story == nil then
				arg_453_1.var_.characterEffect1037ui_story = arg_453_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_0 = 0.2

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_0 and not isNil(arg_453_1.actors_["1037ui_story"]) then
				if arg_453_1.var_.characterEffect1037ui_story and not isNil(arg_453_1.actors_["1037ui_story"]) then
					arg_453_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_453_1.time_ >= 0 + var_456_0 and arg_453_1.time_ < 0 + var_456_0 + arg_456_0 and not isNil(arg_453_1.actors_["1037ui_story"]) and arg_453_1.var_.characterEffect1037ui_story then
				arg_453_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037actionlink/1037action424")
			end

			local var_456_2 = 0
			local var_456_3 = 0.45

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_2 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_4 = arg_453_1:GetWordFromCfg(103703113)
				local var_456_5 = arg_453_1:FormatText(var_456_4.content)

				arg_453_1.text_.text = var_456_5

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_7 = 18 <= 0 and var_456_3 or var_456_3 * (utf8.len(var_456_5) / 18)

				if (18 <= 0 and var_456_3 or var_456_3 * (utf8.len(var_456_5) / 18)) > 0 and var_456_3 < var_456_7 then
					arg_453_1.talkMaxDuration = var_456_7

					if var_456_7 + var_456_2 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_7 + var_456_2
					end
				end

				arg_453_1.text_.text = var_456_5
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703113", "story_v_side_old_103703.awb") ~= 0 then
					local var_456_8 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703113", "story_v_side_old_103703.awb") / 1000

					if var_456_8 + var_456_2 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_8 + var_456_2
					end

					if var_456_4.prefab_name ~= "" and arg_453_1.actors_[var_456_4.prefab_name] ~= nil then
						local var_456_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_4.prefab_name].transform, "story_v_side_old_103703", "103703113", "story_v_side_old_103703.awb")

						arg_453_1:RecordAudio("103703113", var_456_9)
						arg_453_1:RecordAudio("103703113", var_456_9)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703113", "story_v_side_old_103703.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703113", "story_v_side_old_103703.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_10 = math.max(var_456_3, arg_453_1.talkMaxDuration)

			if var_456_2 <= arg_453_1.time_ and arg_453_1.time_ < var_456_2 + var_456_10 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_2) / var_456_10

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_2 + var_456_10 and arg_453_1.time_ < var_456_2 + var_456_10 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play103703114 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 103703114
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play103703115(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 and not isNil(arg_457_1.actors_["1037ui_story"]) and arg_457_1.var_.characterEffect1037ui_story == nil then
				arg_457_1.var_.characterEffect1037ui_story = arg_457_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_460_0 = 0.2

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_0 and not isNil(arg_457_1.actors_["1037ui_story"]) then
				if arg_457_1.var_.characterEffect1037ui_story and not isNil(arg_457_1.actors_["1037ui_story"]) then
					arg_457_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_457_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_457_1.time_ - 0) / var_460_0)
				end
			end

			if arg_457_1.time_ >= 0 + var_460_0 and arg_457_1.time_ < 0 + var_460_0 + arg_460_0 and not isNil(arg_457_1.actors_["1037ui_story"]) and arg_457_1.var_.characterEffect1037ui_story then
				arg_457_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_457_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_460_1 = 0
			local var_460_2 = 0.825

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_1 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, true)
				arg_457_1.iconController_:SetSelectedState("hero")

				arg_457_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_457_1.callingController_:SetSelectedState("normal")

				arg_457_1.keyicon_.color = Color.New(1, 1, 1)
				arg_457_1.icon_.color = Color.New(1, 1, 1)

				local var_460_3 = arg_457_1:FormatText(arg_457_1:GetWordFromCfg(103703114).content)

				arg_457_1.text_.text = var_460_3

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_5 = 33 <= 0 and var_460_2 or var_460_2 * (utf8.len(var_460_3) / 33)

				if (33 <= 0 and var_460_2 or var_460_2 * (utf8.len(var_460_3) / 33)) > 0 and var_460_2 < var_460_5 then
					arg_457_1.talkMaxDuration = var_460_5

					if var_460_5 + var_460_1 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_5 + var_460_1
					end
				end

				arg_457_1.text_.text = var_460_3
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)
				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_6 = math.max(var_460_2, arg_457_1.talkMaxDuration)

			if var_460_1 <= arg_457_1.time_ and arg_457_1.time_ < var_460_1 + var_460_6 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_1) / var_460_6

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_1 + var_460_6 and arg_457_1.time_ < var_460_1 + var_460_6 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play103703115 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 103703115
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play103703116(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 0.65

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, true)
				arg_461_1.iconController_:SetSelectedState("hero")

				arg_461_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_461_1.callingController_:SetSelectedState("normal")

				arg_461_1.keyicon_.color = Color.New(1, 1, 1)
				arg_461_1.icon_.color = Color.New(1, 1, 1)

				local var_464_1 = arg_461_1:FormatText(arg_461_1:GetWordFromCfg(103703115).content)

				arg_461_1.text_.text = var_464_1

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_3 = 26 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_1) / 26)

				if (26 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_1) / 26)) > 0 and var_464_0 < var_464_3 then
					arg_461_1.talkMaxDuration = var_464_3

					if var_464_3 + 0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_3 + 0
					end
				end

				arg_461_1.text_.text = var_464_1
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_4 = math.max(var_464_0, arg_461_1.talkMaxDuration)

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_4 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - 0) / var_464_4

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= 0 + var_464_4 and arg_461_1.time_ < 0 + var_464_4 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play103703116 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 103703116
		arg_465_1.duration_ = 4.17

		local var_465_0 = {
			ja = 3.9,
			ko = 3.266,
			en = 4.166
		}
		local var_465_1 = manager.audio:GetLocalizationFlag()

		if var_465_0[var_465_1] ~= nil then
			arg_465_1.duration_ = var_465_0[var_465_1]
		end

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play103703117(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 and not isNil(arg_465_1.actors_["1037ui_story"]) and arg_465_1.var_.characterEffect1037ui_story == nil then
				arg_465_1.var_.characterEffect1037ui_story = arg_465_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_0 = 0.2

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_0 and not isNil(arg_465_1.actors_["1037ui_story"]) then
				if arg_465_1.var_.characterEffect1037ui_story and not isNil(arg_465_1.actors_["1037ui_story"]) then
					arg_465_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_465_1.time_ >= 0 + var_468_0 and arg_465_1.time_ < 0 + var_468_0 + arg_468_0 and not isNil(arg_465_1.actors_["1037ui_story"]) and arg_465_1.var_.characterEffect1037ui_story then
				arg_465_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037actionlink/1037action442")
			end

			local var_468_2 = 0
			local var_468_3 = 0.325

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_2 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				arg_465_1.leftNameTxt_.text = arg_465_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_4 = arg_465_1:GetWordFromCfg(103703116)
				local var_468_5 = arg_465_1:FormatText(var_468_4.content)

				arg_465_1.text_.text = var_468_5

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_7 = 13 <= 0 and var_468_3 or var_468_3 * (utf8.len(var_468_5) / 13)

				if (13 <= 0 and var_468_3 or var_468_3 * (utf8.len(var_468_5) / 13)) > 0 and var_468_3 < var_468_7 then
					arg_465_1.talkMaxDuration = var_468_7

					if var_468_7 + var_468_2 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_7 + var_468_2
					end
				end

				arg_465_1.text_.text = var_468_5
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703116", "story_v_side_old_103703.awb") ~= 0 then
					local var_468_8 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703116", "story_v_side_old_103703.awb") / 1000

					if var_468_8 + var_468_2 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_8 + var_468_2
					end

					if var_468_4.prefab_name ~= "" and arg_465_1.actors_[var_468_4.prefab_name] ~= nil then
						local var_468_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_4.prefab_name].transform, "story_v_side_old_103703", "103703116", "story_v_side_old_103703.awb")

						arg_465_1:RecordAudio("103703116", var_468_9)
						arg_465_1:RecordAudio("103703116", var_468_9)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703116", "story_v_side_old_103703.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703116", "story_v_side_old_103703.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_10 = math.max(var_468_3, arg_465_1.talkMaxDuration)

			if var_468_2 <= arg_465_1.time_ and arg_465_1.time_ < var_468_2 + var_468_10 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_2) / var_468_10

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_2 + var_468_10 and arg_465_1.time_ < var_468_2 + var_468_10 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play103703117 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 103703117
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play103703118(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 and not isNil(arg_469_1.actors_["1037ui_story"]) and arg_469_1.var_.characterEffect1037ui_story == nil then
				arg_469_1.var_.characterEffect1037ui_story = arg_469_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_0 = 0.2

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_0 and not isNil(arg_469_1.actors_["1037ui_story"]) then
				if arg_469_1.var_.characterEffect1037ui_story and not isNil(arg_469_1.actors_["1037ui_story"]) then
					arg_469_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_469_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_469_1.time_ - 0) / var_472_0)
				end
			end

			if arg_469_1.time_ >= 0 + var_472_0 and arg_469_1.time_ < 0 + var_472_0 + arg_472_0 and not isNil(arg_469_1.actors_["1037ui_story"]) and arg_469_1.var_.characterEffect1037ui_story then
				arg_469_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_469_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_472_1 = 0
			local var_472_2 = 0.775

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_1 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				arg_469_1.leftNameTxt_.text = arg_469_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, true)
				arg_469_1.iconController_:SetSelectedState("hero")

				arg_469_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_469_1.callingController_:SetSelectedState("normal")

				arg_469_1.keyicon_.color = Color.New(1, 1, 1)
				arg_469_1.icon_.color = Color.New(1, 1, 1)

				local var_472_3 = arg_469_1:FormatText(arg_469_1:GetWordFromCfg(103703117).content)

				arg_469_1.text_.text = var_472_3

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_5 = 31 <= 0 and var_472_2 or var_472_2 * (utf8.len(var_472_3) / 31)

				if (31 <= 0 and var_472_2 or var_472_2 * (utf8.len(var_472_3) / 31)) > 0 and var_472_2 < var_472_5 then
					arg_469_1.talkMaxDuration = var_472_5

					if var_472_5 + var_472_1 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_5 + var_472_1
					end
				end

				arg_469_1.text_.text = var_472_3
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_6 = math.max(var_472_2, arg_469_1.talkMaxDuration)

			if var_472_1 <= arg_469_1.time_ and arg_469_1.time_ < var_472_1 + var_472_6 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_1) / var_472_6

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_1 + var_472_6 and arg_469_1.time_ < var_472_1 + var_472_6 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play103703118 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 103703118
		arg_473_1.duration_ = 3.43

		local var_473_0 = {
			ja = 3.433,
			ko = 2.9,
			en = 2.566
		}
		local var_473_1 = manager.audio:GetLocalizationFlag()

		if var_473_0[var_473_1] ~= nil then
			arg_473_1.duration_ = var_473_0[var_473_1]
		end

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play103703119(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 and not isNil(arg_473_1.actors_["1037ui_story"]) and arg_473_1.var_.characterEffect1037ui_story == nil then
				arg_473_1.var_.characterEffect1037ui_story = arg_473_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_0 = 0.2

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_0 and not isNil(arg_473_1.actors_["1037ui_story"]) then
				if arg_473_1.var_.characterEffect1037ui_story and not isNil(arg_473_1.actors_["1037ui_story"]) then
					arg_473_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_473_1.time_ >= 0 + var_476_0 and arg_473_1.time_ < 0 + var_476_0 + arg_476_0 and not isNil(arg_473_1.actors_["1037ui_story"]) and arg_473_1.var_.characterEffect1037ui_story then
				arg_473_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_476_2 = 0
			local var_476_3 = 0.175

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_2 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_4 = arg_473_1:GetWordFromCfg(103703118)
				local var_476_5 = arg_473_1:FormatText(var_476_4.content)

				arg_473_1.text_.text = var_476_5

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_7 = 7 <= 0 and var_476_3 or var_476_3 * (utf8.len(var_476_5) / 7)

				if (7 <= 0 and var_476_3 or var_476_3 * (utf8.len(var_476_5) / 7)) > 0 and var_476_3 < var_476_7 then
					arg_473_1.talkMaxDuration = var_476_7

					if var_476_7 + var_476_2 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_7 + var_476_2
					end
				end

				arg_473_1.text_.text = var_476_5
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703118", "story_v_side_old_103703.awb") ~= 0 then
					local var_476_8 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703118", "story_v_side_old_103703.awb") / 1000

					if var_476_8 + var_476_2 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_8 + var_476_2
					end

					if var_476_4.prefab_name ~= "" and arg_473_1.actors_[var_476_4.prefab_name] ~= nil then
						local var_476_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_4.prefab_name].transform, "story_v_side_old_103703", "103703118", "story_v_side_old_103703.awb")

						arg_473_1:RecordAudio("103703118", var_476_9)
						arg_473_1:RecordAudio("103703118", var_476_9)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703118", "story_v_side_old_103703.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703118", "story_v_side_old_103703.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_10 = math.max(var_476_3, arg_473_1.talkMaxDuration)

			if var_476_2 <= arg_473_1.time_ and arg_473_1.time_ < var_476_2 + var_476_10 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_2) / var_476_10

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_2 + var_476_10 and arg_473_1.time_ < var_476_2 + var_476_10 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play103703119 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 103703119
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play103703120(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 and not isNil(arg_477_1.actors_["1037ui_story"]) and arg_477_1.var_.characterEffect1037ui_story == nil then
				arg_477_1.var_.characterEffect1037ui_story = arg_477_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_0 = 0.2

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_0 and not isNil(arg_477_1.actors_["1037ui_story"]) then
				if arg_477_1.var_.characterEffect1037ui_story and not isNil(arg_477_1.actors_["1037ui_story"]) then
					arg_477_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_477_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_477_1.time_ - 0) / var_480_0)
				end
			end

			if arg_477_1.time_ >= 0 + var_480_0 and arg_477_1.time_ < 0 + var_480_0 + arg_480_0 and not isNil(arg_477_1.actors_["1037ui_story"]) and arg_477_1.var_.characterEffect1037ui_story then
				arg_477_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_477_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_480_1 = 0
			local var_480_2 = 0.525

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_1 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, true)
				arg_477_1.iconController_:SetSelectedState("hero")

				arg_477_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_477_1.callingController_:SetSelectedState("normal")

				arg_477_1.keyicon_.color = Color.New(1, 1, 1)
				arg_477_1.icon_.color = Color.New(1, 1, 1)

				local var_480_3 = arg_477_1:FormatText(arg_477_1:GetWordFromCfg(103703119).content)

				arg_477_1.text_.text = var_480_3

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_5 = 21 <= 0 and var_480_2 or var_480_2 * (utf8.len(var_480_3) / 21)

				if (21 <= 0 and var_480_2 or var_480_2 * (utf8.len(var_480_3) / 21)) > 0 and var_480_2 < var_480_5 then
					arg_477_1.talkMaxDuration = var_480_5

					if var_480_5 + var_480_1 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_5 + var_480_1
					end
				end

				arg_477_1.text_.text = var_480_3
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_6 = math.max(var_480_2, arg_477_1.talkMaxDuration)

			if var_480_1 <= arg_477_1.time_ and arg_477_1.time_ < var_480_1 + var_480_6 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_1) / var_480_6

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_1 + var_480_6 and arg_477_1.time_ < var_480_1 + var_480_6 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play103703120 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 103703120
		arg_481_1.duration_ = 5

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play103703121(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.var_.moveOldPos1037ui_story = arg_481_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_484_0 = 0.001

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_0 then
				arg_481_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_481_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_481_1.time_ - 0) / var_484_0)
				arg_481_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_481_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1037ui_story"].transform.position).z)
				arg_481_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_481_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_481_1.actors_["1037ui_story"].transform.localEulerAngles = arg_481_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_481_1.time_ >= 0 + var_484_0 and arg_481_1.time_ < 0 + var_484_0 + arg_484_0 then
				arg_481_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_481_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_481_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1037ui_story"].transform.position).z)
				arg_481_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_481_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_481_1.actors_["1037ui_story"].transform.localEulerAngles = arg_481_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_484_1 = 0
			local var_484_2 = 0.775

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_1 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, false)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_3 = arg_481_1:FormatText(arg_481_1:GetWordFromCfg(103703120).content)

				arg_481_1.text_.text = var_484_3

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_5 = 31 <= 0 and var_484_2 or var_484_2 * (utf8.len(var_484_3) / 31)

				if (31 <= 0 and var_484_2 or var_484_2 * (utf8.len(var_484_3) / 31)) > 0 and var_484_2 < var_484_5 then
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

		arg_481_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_481_1:InitPlayNodeList()
	end,
	Play103703121 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 103703121
		arg_485_1.duration_ = 5

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play103703122(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = 0.875

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, false)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_1 = arg_485_1:FormatText(arg_485_1:GetWordFromCfg(103703121).content)

				arg_485_1.text_.text = var_488_1

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_3 = 35 <= 0 and var_488_0 or var_488_0 * (utf8.len(var_488_1) / 35)

				if (35 <= 0 and var_488_0 or var_488_0 * (utf8.len(var_488_1) / 35)) > 0 and var_488_0 < var_488_3 then
					arg_485_1.talkMaxDuration = var_488_3

					if var_488_3 + 0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_3 + 0
					end
				end

				arg_485_1.text_.text = var_488_1
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)
				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_4 = math.max(var_488_0, arg_485_1.talkMaxDuration)

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_4 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - 0) / var_488_4

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= 0 + var_488_4 and arg_485_1.time_ < 0 + var_488_4 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play103703122 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 103703122
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
			arg_489_1.auto_ = false
		end

		function arg_489_1.playNext_(arg_491_0)
			arg_489_1.onStoryFinished_()
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = 0.325

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

				local var_492_1 = arg_489_1:FormatText(arg_489_1:GetWordFromCfg(103703122).content)

				arg_489_1.text_.text = var_492_1

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_3 = 13 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_1) / 13)

				if (13 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_1) / 13)) > 0 and var_492_0 < var_492_3 then
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
	Play103703065 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 103703065
		arg_493_1.duration_ = 7.67

		local var_493_0 = {
			ja = 7.666,
			ko = 6.266,
			en = 6.2
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
				arg_493_0:Play103703066(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 and not isNil(arg_493_1.actors_["1037ui_story"]) and arg_493_1.var_.characterEffect1037ui_story == nil then
				arg_493_1.var_.characterEffect1037ui_story = arg_493_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_0 = 0.2

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_0 and not isNil(arg_493_1.actors_["1037ui_story"]) then
				if arg_493_1.var_.characterEffect1037ui_story and not isNil(arg_493_1.actors_["1037ui_story"]) then
					arg_493_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_493_1.time_ >= 0 + var_496_0 and arg_493_1.time_ < 0 + var_496_0 + arg_496_0 and not isNil(arg_493_1.actors_["1037ui_story"]) and arg_493_1.var_.characterEffect1037ui_story then
				arg_493_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_496_2 = "1037ui_story"

			if arg_493_1.actors_["1037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1037ui_story"))) then
				local var_496_3 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_493_1.stage_.transform)

				var_496_3.name = var_496_2
				var_496_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_493_1.actors_[var_496_2] = var_496_3

				local var_496_4 = var_496_3:GetComponentInChildren(typeof(CharacterEffect))

				var_496_4.enabled = true

				local var_496_5 = GameObjectTools.GetOrAddComponent(var_496_3, typeof(DynamicBoneHelper))

				if var_496_5 then
					var_496_5:EnableDynamicBone(false)
				end

				arg_493_1:ShowWeapon(var_496_4.transform, false)

				arg_493_1.var_[var_496_2 .. "Animator"] = var_496_4.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_493_1.var_[var_496_2 .. "Animator"].applyRootMotion = true
				arg_493_1.var_[var_496_2 .. "LipSync"] = var_496_4.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_496_6 = "1037ui_story"

			if arg_493_1.actors_["1037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1037ui_story"))) then
				local var_496_7 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_493_1.stage_.transform)

				var_496_7.name = var_496_6
				var_496_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_493_1.actors_[var_496_6] = var_496_7

				local var_496_8 = var_496_7:GetComponentInChildren(typeof(CharacterEffect))

				var_496_8.enabled = true

				local var_496_9 = GameObjectTools.GetOrAddComponent(var_496_7, typeof(DynamicBoneHelper))

				if var_496_9 then
					var_496_9:EnableDynamicBone(false)
				end

				arg_493_1:ShowWeapon(var_496_8.transform, false)

				arg_493_1.var_[var_496_6 .. "Animator"] = var_496_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_493_1.var_[var_496_6 .. "Animator"].applyRootMotion = true
				arg_493_1.var_[var_496_6 .. "LipSync"] = var_496_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037actionlink/1037action435")
			end

			local var_496_10 = 0
			local var_496_11 = 0.75

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_10 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				arg_493_1.leftNameTxt_.text = arg_493_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_12 = arg_493_1:GetWordFromCfg(103703065)
				local var_496_13 = arg_493_1:FormatText(var_496_12.content)

				arg_493_1.text_.text = var_496_13

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_15 = 30 <= 0 and var_496_11 or var_496_11 * (utf8.len(var_496_13) / 30)

				if (30 <= 0 and var_496_11 or var_496_11 * (utf8.len(var_496_13) / 30)) > 0 and var_496_11 < var_496_15 then
					arg_493_1.talkMaxDuration = var_496_15

					if var_496_15 + var_496_10 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_15 + var_496_10
					end
				end

				arg_493_1.text_.text = var_496_13
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103703", "103703065", "story_v_side_old_103703.awb") ~= 0 then
					local var_496_16 = manager.audio:GetVoiceLength("story_v_side_old_103703", "103703065", "story_v_side_old_103703.awb") / 1000

					if var_496_16 + var_496_10 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_16 + var_496_10
					end

					if var_496_12.prefab_name ~= "" and arg_493_1.actors_[var_496_12.prefab_name] ~= nil then
						local var_496_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_493_1.actors_[var_496_12.prefab_name].transform, "story_v_side_old_103703", "103703065", "story_v_side_old_103703.awb")

						arg_493_1:RecordAudio("103703065", var_496_17)
						arg_493_1:RecordAudio("103703065", var_496_17)
					else
						arg_493_1:AudioAction("play", "voice", "story_v_side_old_103703", "103703065", "story_v_side_old_103703.awb")
					end

					arg_493_1:RecordHistoryTalkVoice("story_v_side_old_103703", "103703065", "story_v_side_old_103703.awb")
				end

				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_18 = math.max(var_496_11, arg_493_1.talkMaxDuration)

			if var_496_10 <= arg_493_1.time_ and arg_493_1.time_ < var_496_10 + var_496_18 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_10) / var_496_18

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_10 + var_496_18 and arg_493_1.time_ < var_496_10 + var_496_18 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST13",
		"TextureConfig/Background/A00",
		"TextureConfig/Background/B13"
	},
	voices = {
		"story_v_side_old_103703.awb"
	}
}
