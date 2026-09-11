return {
	Play102801001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 102801001
		arg_1_1.duration_ = 6.33

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play102801002(arg_1_1)
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

			local var_4_5 = 1.33333333333333

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

			if 1.33333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.33333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

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

			local var_4_14 = 1.33333333333333
			local var_4_15 = 0.533333333333333

			if 1.33333333333333 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(102801001).content)

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
	Play102801002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 102801002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play102801003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.5

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(102801002).content)

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
	Play102801003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 102801003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play102801004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.5

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(102801003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 34 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 34)

				if (34 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 34)) > 0 and var_16_0 < var_16_3 then
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
	Play102801004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 102801004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play102801005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 1.5

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

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(102801004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 80 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 80)

				if (80 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 80)) > 0 and var_20_0 < var_20_3 then
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
	Play102801005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 102801005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play102801006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.5

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

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(102801005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 27 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 27)

				if (27 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 27)) > 0 and var_24_0 < var_24_3 then
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
	Play102801006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 102801006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play102801007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.5

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

				local var_28_1 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(102801006).content)

				arg_25_1.text_.text = var_28_1

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_3 = 26 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 26)

				if (26 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 26)) > 0 and var_28_0 < var_28_3 then
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
	Play102801007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 102801007
		arg_29_1.duration_ = 9

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play102801008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.bgs_.B13 == nil then
				local var_32_0 = Object.Instantiate(arg_29_1.paintGo_)

				var_32_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B13")
				var_32_0.name = "B13"
				var_32_0.transform.parent = arg_29_1.stage_.transform
				var_32_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.bgs_.B13 = var_32_0
			end

			if 2 < arg_29_1.time_ and arg_29_1.time_ <= 2 + arg_32_0 then
				local var_32_1 = arg_29_1.bgs_.B13

				arg_29_1.bgs_.B13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_32_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_32_2 = var_32_1:GetComponent("SpriteRenderer")

				if var_32_2 and var_32_2.sprite then
					local var_32_3 = 2 * (var_32_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_32_1.transform.localScale = Vector3.New(var_32_3 / var_32_2.sprite.bounds.size.y < var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x and var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x or var_32_3 / var_32_2.sprite.bounds.size.y, var_32_3 / var_32_2.sprite.bounds.size.y < var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x and var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x or var_32_3 / var_32_2.sprite.bounds.size.y, 0)
				end

				for iter_32_0, iter_32_1 in pairs(arg_29_1.bgs_) do
					if iter_32_0 ~= "B13" then
						iter_32_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_32_4 = 0

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_5 = 2

			if var_32_4 <= arg_29_1.time_ and arg_29_1.time_ < var_32_4 + var_32_5 then
				local var_32_6 = Color.New(0, 0, 0)

				var_32_6.a = Mathf.Lerp(0, 1, (arg_29_1.time_ - var_32_4) / var_32_5)
				arg_29_1.mask_.color = var_32_6
			end

			if arg_29_1.time_ >= var_32_4 + var_32_5 and arg_29_1.time_ < var_32_4 + var_32_5 + arg_32_0 then
				local var_32_7 = Color.New(0, 0, 0)

				var_32_7.a = 1
				arg_29_1.mask_.color = var_32_7
			end

			local var_32_8 = 2

			if 2 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_9 = 1.999999999999

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_9 then
				local var_32_10 = Color.New(0, 0, 0)

				var_32_10.a = Mathf.Lerp(1, 0, (arg_29_1.time_ - var_32_8) / var_32_9)
				arg_29_1.mask_.color = var_32_10
			end

			if arg_29_1.time_ >= var_32_8 + var_32_9 and arg_29_1.time_ < var_32_8 + var_32_9 + arg_32_0 then
				local var_32_11 = Color.New(0, 0, 0)

				arg_29_1.mask_.enabled = false
				var_32_11.a = 0
				arg_29_1.mask_.color = var_32_11
			end

			if arg_29_1.frameCnt_ <= 1 then
				arg_29_1.dialog_:SetActive(false)
			end

			local var_32_12 = 4
			local var_32_13 = 0.5

			if 4 < arg_29_1.time_ and arg_29_1.time_ <= var_32_12 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0

				arg_29_1.dialog_:SetActive(true)

				arg_29_1.dialogCg_.alpha = 0

				local var_32_14 = LeanTween.value(arg_29_1.dialog_, 0, 1, 0.3)

				var_32_14:setOnUpdate(LuaHelper.FloatAction(function(arg_33_0)
					arg_29_1.dialogCg_.alpha = arg_33_0
				end))
				var_32_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_29_1.dialog_)
					var_32_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_29_1.duration_ = arg_29_1.duration_ + 0.3

				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_15 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(102801007).content)

				arg_29_1.text_.text = var_32_15

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_17 = 19 <= 0 and var_32_13 or var_32_13 * (utf8.len(var_32_15) / 19)

				if (19 <= 0 and var_32_13 or var_32_13 * (utf8.len(var_32_15) / 19)) > 0 and var_32_13 < var_32_17 then
					arg_29_1.talkMaxDuration = var_32_17
					var_32_12 = var_32_12 + 0.3

					if var_32_17 + var_32_12 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_17 + var_32_12
					end
				end

				arg_29_1.text_.text = var_32_15
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_18 = var_32_12 + 0.3
			local var_32_19 = math.max(var_32_13, arg_29_1.talkMaxDuration)

			if var_32_12 + 0.3 <= arg_29_1.time_ and arg_29_1.time_ < var_32_18 + var_32_19 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_18) / var_32_19

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_18 + var_32_19 and arg_29_1.time_ < var_32_18 + var_32_19 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play102801008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 102801008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play102801009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0.5

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_1 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(102801008).content)

				arg_35_1.text_.text = var_38_1

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_3 = 17 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_1) / 17)

				if (17 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_1) / 17)) > 0 and var_38_0 < var_38_3 then
					arg_35_1.talkMaxDuration = var_38_3

					if var_38_3 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_3 + 0
					end
				end

				arg_35_1.text_.text = var_38_1
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_4 = math.max(var_38_0, arg_35_1.talkMaxDuration)

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_4 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - 0) / var_38_4

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= 0 + var_38_4 and arg_35_1.time_ < 0 + var_38_4 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play102801009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 102801009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play102801010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0.3

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

				local var_42_1 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(102801009).content)

				arg_39_1.text_.text = var_42_1

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_3 = 6 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 6)

				if (6 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 6)) > 0 and var_42_0 < var_42_3 then
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
	Play102801010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 102801010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play102801011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0.5

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_1 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(102801010).content)

				arg_43_1.text_.text = var_46_1

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_3 = 33 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 33)

				if (33 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 33)) > 0 and var_46_0 < var_46_3 then
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
	Play102801011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 102801011
		arg_47_1.duration_ = 5.23

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play102801012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if arg_47_1.actors_["1028ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1028ui_story"))) then
				local var_50_0 = Object.Instantiate(Asset.Load("Char/" .. "1028ui_story"), arg_47_1.stage_.transform)

				var_50_0.name = "1028ui_story"
				var_50_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_47_1.actors_["1028ui_story"] = var_50_0

				local var_50_1 = var_50_0:GetComponentInChildren(typeof(CharacterEffect))

				var_50_1.enabled = true

				local var_50_2 = GameObjectTools.GetOrAddComponent(var_50_0, typeof(DynamicBoneHelper))

				if var_50_2 then
					var_50_2:EnableDynamicBone(false)
				end

				arg_47_1:ShowWeapon(var_50_1.transform, false)

				arg_47_1.var_["1028ui_story" .. "Animator"] = var_50_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_47_1.var_["1028ui_story" .. "Animator"].applyRootMotion = true
				arg_47_1.var_["1028ui_story" .. "LipSync"] = var_50_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_50_3 = arg_47_1.actors_["1028ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_3) and arg_47_1.var_.characterEffect1028ui_story == nil then
				arg_47_1.var_.characterEffect1028ui_story = var_50_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_4 = 0.0166666666666667

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_4 and not isNil(var_50_3) then
				if arg_47_1.var_.characterEffect1028ui_story and not isNil(var_50_3) then
					arg_47_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_4 and arg_47_1.time_ < 0 + var_50_4 + arg_50_0 and not isNil(var_50_3) and arg_47_1.var_.characterEffect1028ui_story then
				arg_47_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_50_6 = arg_47_1.actors_["1028ui_story"].transform

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1028ui_story = var_50_6.localPosition

				arg_47_1:ShowWeapon(arg_47_1.var_["1028ui_story" .. "Animator"].transform, false)
			end

			local var_50_7 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_7 then
				var_50_6.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1028ui_story, Vector3.New(0, -0.9, -5.9), (arg_47_1.time_ - 0) / var_50_7)
				var_50_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_6.position).x, (manager.ui.mainCamera.transform.position - var_50_6.position).y, (manager.ui.mainCamera.transform.position - var_50_6.position).z)
				var_50_6.localEulerAngles.z = 0
				var_50_6.localEulerAngles.x = 0
				var_50_6.localEulerAngles = var_50_6.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_7 and arg_47_1.time_ < 0 + var_50_7 + arg_50_0 then
				var_50_6.localPosition = Vector3.New(0, -0.9, -5.9)
				var_50_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_6.position).x, (manager.ui.mainCamera.transform.position - var_50_6.position).y, (manager.ui.mainCamera.transform.position - var_50_6.position).z)
				var_50_6.localEulerAngles.z = 0
				var_50_6.localEulerAngles.x = 0
				var_50_6.localEulerAngles = var_50_6.localEulerAngles
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action1_1")
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_50_8 = 0.034
			local var_50_9 = 0.5

			if 0.034 < arg_47_1.time_ and arg_47_1.time_ <= var_50_8 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_10 = arg_47_1:GetWordFromCfg(102801011)
				local var_50_11 = arg_47_1:FormatText(var_50_10.content)

				arg_47_1.text_.text = var_50_11

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_13 = 15 <= 0 and var_50_9 or var_50_9 * (utf8.len(var_50_11) / 15)

				if (15 <= 0 and var_50_9 or var_50_9 * (utf8.len(var_50_11) / 15)) > 0 and var_50_9 < var_50_13 then
					arg_47_1.talkMaxDuration = var_50_13

					if var_50_13 + var_50_8 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_13 + var_50_8
					end
				end

				arg_47_1.text_.text = var_50_11
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801011", "story_v_side_old_102801.awb") ~= 0 then
					local var_50_14 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801011", "story_v_side_old_102801.awb") / 1000

					if var_50_14 + var_50_8 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_14 + var_50_8
					end

					if var_50_10.prefab_name ~= "" and arg_47_1.actors_[var_50_10.prefab_name] ~= nil then
						local var_50_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_10.prefab_name].transform, "story_v_side_old_102801", "102801011", "story_v_side_old_102801.awb")

						arg_47_1:RecordAudio("102801011", var_50_15)
						arg_47_1:RecordAudio("102801011", var_50_15)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801011", "story_v_side_old_102801.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801011", "story_v_side_old_102801.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_16 = math.max(var_50_9, arg_47_1.talkMaxDuration)

			if var_50_8 <= arg_47_1.time_ and arg_47_1.time_ < var_50_8 + var_50_16 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_8) / var_50_16

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_8 + var_50_16 and arg_47_1.time_ < var_50_8 + var_50_16 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play102801012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 102801012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play102801013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["1028ui_story"]) and arg_51_1.var_.characterEffect1028ui_story == nil then
				arg_51_1.var_.characterEffect1028ui_story = arg_51_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_0 = 0.034

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["1028ui_story"]) then
				if arg_51_1.var_.characterEffect1028ui_story and not isNil(arg_51_1.actors_["1028ui_story"]) then
					arg_51_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_0)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["1028ui_story"]) and arg_51_1.var_.characterEffect1028ui_story then
				arg_51_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_54_1 = 0
			local var_54_2 = 0.45

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_3 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(102801012).content)

				arg_51_1.text_.text = var_54_3

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 18 <= 0 and var_54_2 or var_54_2 * (utf8.len(var_54_3) / 18)

				if (18 <= 0 and var_54_2 or var_54_2 * (utf8.len(var_54_3) / 18)) > 0 and var_54_2 < var_54_5 then
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
	Play102801013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 102801013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play102801014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action1_1")
			end

			local var_58_0 = 0
			local var_58_1 = 0.4

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_2 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(102801013).content)

				arg_55_1.text_.text = var_58_2

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_4 = 16 <= 0 and var_58_1 or var_58_1 * (utf8.len(var_58_2) / 16)

				if (16 <= 0 and var_58_1 or var_58_1 * (utf8.len(var_58_2) / 16)) > 0 and var_58_1 < var_58_4 then
					arg_55_1.talkMaxDuration = var_58_4

					if var_58_4 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_4 + var_58_0
					end
				end

				arg_55_1.text_.text = var_58_2
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_5 = math.max(var_58_1, arg_55_1.talkMaxDuration)

			if var_58_0 <= arg_55_1.time_ and arg_55_1.time_ < var_58_0 + var_58_5 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_0) / var_58_5

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_0 + var_58_5 and arg_55_1.time_ < var_58_0 + var_58_5 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play102801014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 102801014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play102801015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 1.075

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_1 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(102801014).content)

				arg_59_1.text_.text = var_62_1

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_3 = 43 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 43)

				if (43 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 43)) > 0 and var_62_0 < var_62_3 then
					arg_59_1.talkMaxDuration = var_62_3

					if var_62_3 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_3 + 0
					end
				end

				arg_59_1.text_.text = var_62_1
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_4 = math.max(var_62_0, arg_59_1.talkMaxDuration)

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_4 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - 0) / var_62_4

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= 0 + var_62_4 and arg_59_1.time_ < 0 + var_62_4 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play102801015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 102801015
		arg_63_1.duration_ = 9.37

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play102801016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["1028ui_story"]) and arg_63_1.var_.characterEffect1028ui_story == nil then
				arg_63_1.var_.characterEffect1028ui_story = arg_63_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_0 = 0.0166666666666667

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["1028ui_story"]) then
				if arg_63_1.var_.characterEffect1028ui_story and not isNil(arg_63_1.actors_["1028ui_story"]) then
					arg_63_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["1028ui_story"]) and arg_63_1.var_.characterEffect1028ui_story then
				arg_63_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action7_1")
			end

			local var_66_2 = 0
			local var_66_3 = 0.8

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_2 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_4 = arg_63_1:GetWordFromCfg(102801015)
				local var_66_5 = arg_63_1:FormatText(var_66_4.content)

				arg_63_1.text_.text = var_66_5

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_7 = 40 <= 0 and var_66_3 or var_66_3 * (utf8.len(var_66_5) / 40)

				if (40 <= 0 and var_66_3 or var_66_3 * (utf8.len(var_66_5) / 40)) > 0 and var_66_3 < var_66_7 then
					arg_63_1.talkMaxDuration = var_66_7

					if var_66_7 + var_66_2 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_7 + var_66_2
					end
				end

				arg_63_1.text_.text = var_66_5
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801015", "story_v_side_old_102801.awb") ~= 0 then
					local var_66_8 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801015", "story_v_side_old_102801.awb") / 1000

					if var_66_8 + var_66_2 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_8 + var_66_2
					end

					if var_66_4.prefab_name ~= "" and arg_63_1.actors_[var_66_4.prefab_name] ~= nil then
						local var_66_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_4.prefab_name].transform, "story_v_side_old_102801", "102801015", "story_v_side_old_102801.awb")

						arg_63_1:RecordAudio("102801015", var_66_9)
						arg_63_1:RecordAudio("102801015", var_66_9)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801015", "story_v_side_old_102801.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801015", "story_v_side_old_102801.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_10 = math.max(var_66_3, arg_63_1.talkMaxDuration)

			if var_66_2 <= arg_63_1.time_ and arg_63_1.time_ < var_66_2 + var_66_10 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_2) / var_66_10

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_2 + var_66_10 and arg_63_1.time_ < var_66_2 + var_66_10 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play102801016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 102801016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play102801017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["1028ui_story"]) and arg_67_1.var_.characterEffect1028ui_story == nil then
				arg_67_1.var_.characterEffect1028ui_story = arg_67_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_0 = 0.034

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["1028ui_story"]) then
				if arg_67_1.var_.characterEffect1028ui_story and not isNil(arg_67_1.actors_["1028ui_story"]) then
					arg_67_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_0)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["1028ui_story"]) and arg_67_1.var_.characterEffect1028ui_story then
				arg_67_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1028ui_story.fillRatio = 0.5
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

				local var_70_3 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(102801016).content)

				arg_67_1.text_.text = var_70_3

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 31 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_3) / 31)

				if (31 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_3) / 31)) > 0 and var_70_2 < var_70_5 then
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
	Play102801017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 102801017
		arg_71_1.duration_ = 9.87

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play102801018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2204cva")
			end

			local var_74_0 = arg_71_1.actors_["1028ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect1028ui_story == nil then
				arg_71_1.var_.characterEffect1028ui_story = var_74_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_1 = 0.0166666666666667

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_1 and not isNil(var_74_0) then
				if arg_71_1.var_.characterEffect1028ui_story and not isNil(var_74_0) then
					arg_71_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_1 and arg_71_1.time_ < 0 + var_74_1 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect1028ui_story then
				arg_71_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_74_3 = 0
			local var_74_4 = 0.775

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_3 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_5 = arg_71_1:GetWordFromCfg(102801017)
				local var_74_6 = arg_71_1:FormatText(var_74_5.content)

				arg_71_1.text_.text = var_74_6

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_8 = 31 <= 0 and var_74_4 or var_74_4 * (utf8.len(var_74_6) / 31)

				if (31 <= 0 and var_74_4 or var_74_4 * (utf8.len(var_74_6) / 31)) > 0 and var_74_4 < var_74_8 then
					arg_71_1.talkMaxDuration = var_74_8

					if var_74_8 + var_74_3 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_8 + var_74_3
					end
				end

				arg_71_1.text_.text = var_74_6
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801017", "story_v_side_old_102801.awb") ~= 0 then
					local var_74_9 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801017", "story_v_side_old_102801.awb") / 1000

					if var_74_9 + var_74_3 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_9 + var_74_3
					end

					if var_74_5.prefab_name ~= "" and arg_71_1.actors_[var_74_5.prefab_name] ~= nil then
						local var_74_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_5.prefab_name].transform, "story_v_side_old_102801", "102801017", "story_v_side_old_102801.awb")

						arg_71_1:RecordAudio("102801017", var_74_10)
						arg_71_1:RecordAudio("102801017", var_74_10)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801017", "story_v_side_old_102801.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801017", "story_v_side_old_102801.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_11 = math.max(var_74_4, arg_71_1.talkMaxDuration)

			if var_74_3 <= arg_71_1.time_ and arg_71_1.time_ < var_74_3 + var_74_11 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_3) / var_74_11

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_3 + var_74_11 and arg_71_1.time_ < var_74_3 + var_74_11 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play102801018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 102801018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play102801019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["1028ui_story"]) and arg_75_1.var_.characterEffect1028ui_story == nil then
				arg_75_1.var_.characterEffect1028ui_story = arg_75_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_0 = 0.034

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["1028ui_story"]) then
				if arg_75_1.var_.characterEffect1028ui_story and not isNil(arg_75_1.actors_["1028ui_story"]) then
					arg_75_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_0)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["1028ui_story"]) and arg_75_1.var_.characterEffect1028ui_story then
				arg_75_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_78_1 = 0
			local var_78_2 = 0.333333333333333

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_3 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(102801018).content)

				arg_75_1.text_.text = var_78_3

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 8 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 8)

				if (8 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 8)) > 0 and var_78_2 < var_78_5 then
					arg_75_1.talkMaxDuration = var_78_5

					if var_78_5 + var_78_1 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + var_78_1
					end
				end

				arg_75_1.text_.text = var_78_3
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_6 = math.max(var_78_2, arg_75_1.talkMaxDuration)

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_6 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_1) / var_78_6

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_1 + var_78_6 and arg_75_1.time_ < var_78_1 + var_78_6 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play102801019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 102801019
		arg_79_1.duration_ = 7.47

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play102801020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["1028ui_story"]) and arg_79_1.var_.characterEffect1028ui_story == nil then
				arg_79_1.var_.characterEffect1028ui_story = arg_79_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_0 = 0.0166666666666667

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["1028ui_story"]) then
				if arg_79_1.var_.characterEffect1028ui_story and not isNil(arg_79_1.actors_["1028ui_story"]) then
					arg_79_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["1028ui_story"]) and arg_79_1.var_.characterEffect1028ui_story then
				arg_79_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action7_2")
			end

			local var_82_2 = 0
			local var_82_3 = 0.775

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_2 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_4 = arg_79_1:GetWordFromCfg(102801019)
				local var_82_5 = arg_79_1:FormatText(var_82_4.content)

				arg_79_1.text_.text = var_82_5

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_7 = 30 <= 0 and var_82_3 or var_82_3 * (utf8.len(var_82_5) / 30)

				if (30 <= 0 and var_82_3 or var_82_3 * (utf8.len(var_82_5) / 30)) > 0 and var_82_3 < var_82_7 then
					arg_79_1.talkMaxDuration = var_82_7

					if var_82_7 + var_82_2 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_7 + var_82_2
					end
				end

				arg_79_1.text_.text = var_82_5
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801019", "story_v_side_old_102801.awb") ~= 0 then
					local var_82_8 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801019", "story_v_side_old_102801.awb") / 1000

					if var_82_8 + var_82_2 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_8 + var_82_2
					end

					if var_82_4.prefab_name ~= "" and arg_79_1.actors_[var_82_4.prefab_name] ~= nil then
						local var_82_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_4.prefab_name].transform, "story_v_side_old_102801", "102801019", "story_v_side_old_102801.awb")

						arg_79_1:RecordAudio("102801019", var_82_9)
						arg_79_1:RecordAudio("102801019", var_82_9)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801019", "story_v_side_old_102801.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801019", "story_v_side_old_102801.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_10 = math.max(var_82_3, arg_79_1.talkMaxDuration)

			if var_82_2 <= arg_79_1.time_ and arg_79_1.time_ < var_82_2 + var_82_10 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_2) / var_82_10

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_2 + var_82_10 and arg_79_1.time_ < var_82_2 + var_82_10 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play102801020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 102801020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play102801021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["1028ui_story"]) and arg_83_1.var_.characterEffect1028ui_story == nil then
				arg_83_1.var_.characterEffect1028ui_story = arg_83_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_0 = 0.034

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["1028ui_story"]) then
				if arg_83_1.var_.characterEffect1028ui_story and not isNil(arg_83_1.actors_["1028ui_story"]) then
					arg_83_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_0)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["1028ui_story"]) and arg_83_1.var_.characterEffect1028ui_story then
				arg_83_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_86_1 = 0
			local var_86_2 = 0.5

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
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

				local var_86_3 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(102801020).content)

				arg_83_1.text_.text = var_86_3

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 11 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_3) / 11)

				if (11 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_3) / 11)) > 0 and var_86_2 < var_86_5 then
					arg_83_1.talkMaxDuration = var_86_5

					if var_86_5 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + var_86_1
					end
				end

				arg_83_1.text_.text = var_86_3
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_6 = math.max(var_86_2, arg_83_1.talkMaxDuration)

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_6 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_1) / var_86_6

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_1 + var_86_6 and arg_83_1.time_ < var_86_1 + var_86_6 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play102801021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 102801021
		arg_87_1.duration_ = 2

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play102801022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_90_0 = arg_87_1.actors_["1028ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect1028ui_story == nil then
				arg_87_1.var_.characterEffect1028ui_story = var_90_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_1 = 0.0166666666666667

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_1 and not isNil(var_90_0) then
				if arg_87_1.var_.characterEffect1028ui_story and not isNil(var_90_0) then
					arg_87_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_1 and arg_87_1.time_ < 0 + var_90_1 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect1028ui_story then
				arg_87_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_90_3 = 0
			local var_90_4 = 0.133333333333333

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_3 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_5 = arg_87_1:GetWordFromCfg(102801021)
				local var_90_6 = arg_87_1:FormatText(var_90_5.content)

				arg_87_1.text_.text = var_90_6

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_8 = 4 <= 0 and var_90_4 or var_90_4 * (utf8.len(var_90_6) / 4)

				if (4 <= 0 and var_90_4 or var_90_4 * (utf8.len(var_90_6) / 4)) > 0 and var_90_4 < var_90_8 then
					arg_87_1.talkMaxDuration = var_90_8

					if var_90_8 + var_90_3 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_8 + var_90_3
					end
				end

				arg_87_1.text_.text = var_90_6
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801021", "story_v_side_old_102801.awb") ~= 0 then
					local var_90_9 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801021", "story_v_side_old_102801.awb") / 1000

					if var_90_9 + var_90_3 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_9 + var_90_3
					end

					if var_90_5.prefab_name ~= "" and arg_87_1.actors_[var_90_5.prefab_name] ~= nil then
						local var_90_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_5.prefab_name].transform, "story_v_side_old_102801", "102801021", "story_v_side_old_102801.awb")

						arg_87_1:RecordAudio("102801021", var_90_10)
						arg_87_1:RecordAudio("102801021", var_90_10)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801021", "story_v_side_old_102801.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801021", "story_v_side_old_102801.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_11 = math.max(var_90_4, arg_87_1.talkMaxDuration)

			if var_90_3 <= arg_87_1.time_ and arg_87_1.time_ < var_90_3 + var_90_11 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_3) / var_90_11

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_3 + var_90_11 and arg_87_1.time_ < var_90_3 + var_90_11 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play102801022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 102801022
		arg_91_1.duration_ = 2.37

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play102801023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0.0333333333333333 < arg_91_1.time_ and arg_91_1.time_ <= 0.0333333333333333 + arg_94_0 then
				arg_91_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_94_0 = 0
			local var_94_1 = 0.5

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_2 = arg_91_1:GetWordFromCfg(102801022)
				local var_94_3 = arg_91_1:FormatText(var_94_2.content)

				arg_91_1.text_.text = var_94_3

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 10 <= 0 and var_94_1 or var_94_1 * (utf8.len(var_94_3) / 10)

				if (10 <= 0 and var_94_1 or var_94_1 * (utf8.len(var_94_3) / 10)) > 0 and var_94_1 < var_94_5 then
					arg_91_1.talkMaxDuration = var_94_5

					if var_94_5 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_5 + var_94_0
					end
				end

				arg_91_1.text_.text = var_94_3
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801022", "story_v_side_old_102801.awb") ~= 0 then
					local var_94_6 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801022", "story_v_side_old_102801.awb") / 1000

					if var_94_6 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_6 + var_94_0
					end

					if var_94_2.prefab_name ~= "" and arg_91_1.actors_[var_94_2.prefab_name] ~= nil then
						local var_94_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_2.prefab_name].transform, "story_v_side_old_102801", "102801022", "story_v_side_old_102801.awb")

						arg_91_1:RecordAudio("102801022", var_94_7)
						arg_91_1:RecordAudio("102801022", var_94_7)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801022", "story_v_side_old_102801.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801022", "story_v_side_old_102801.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_8 = math.max(var_94_1, arg_91_1.talkMaxDuration)

			if var_94_0 <= arg_91_1.time_ and arg_91_1.time_ < var_94_0 + var_94_8 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_0) / var_94_8

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_0 + var_94_8 and arg_91_1.time_ < var_94_0 + var_94_8 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play102801023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 102801023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play102801024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(arg_95_1.actors_["1028ui_story"]) and arg_95_1.var_.characterEffect1028ui_story == nil then
				arg_95_1.var_.characterEffect1028ui_story = arg_95_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_0 = 0.0166666666666667

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 and not isNil(arg_95_1.actors_["1028ui_story"]) then
				if arg_95_1.var_.characterEffect1028ui_story and not isNil(arg_95_1.actors_["1028ui_story"]) then
					arg_95_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_95_1.time_ - 0) / var_98_0)
				end
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 and not isNil(arg_95_1.actors_["1028ui_story"]) and arg_95_1.var_.characterEffect1028ui_story then
				arg_95_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_98_1 = 0
			local var_98_2 = 0.5

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_3 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(102801023).content)

				arg_95_1.text_.text = var_98_3

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 21 <= 0 and var_98_2 or var_98_2 * (utf8.len(var_98_3) / 21)

				if (21 <= 0 and var_98_2 or var_98_2 * (utf8.len(var_98_3) / 21)) > 0 and var_98_2 < var_98_5 then
					arg_95_1.talkMaxDuration = var_98_5

					if var_98_5 + var_98_1 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_5 + var_98_1
					end
				end

				arg_95_1.text_.text = var_98_3
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_6 = math.max(var_98_2, arg_95_1.talkMaxDuration)

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_6 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_1) / var_98_6

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_1 + var_98_6 and arg_95_1.time_ < var_98_1 + var_98_6 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play102801024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 102801024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play102801025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0.45

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_1 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(102801024).content)

				arg_99_1.text_.text = var_102_1

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_3 = 18 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 18)

				if (18 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 18)) > 0 and var_102_0 < var_102_3 then
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
	Play102801025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 102801025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play102801026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0.675

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
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

				local var_106_1 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(102801025).content)

				arg_103_1.text_.text = var_106_1

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_3 = 27 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_1) / 27)

				if (27 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_1) / 27)) > 0 and var_106_0 < var_106_3 then
					arg_103_1.talkMaxDuration = var_106_3

					if var_106_3 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_3 + 0
					end
				end

				arg_103_1.text_.text = var_106_1
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_4 = math.max(var_106_0, arg_103_1.talkMaxDuration)

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_4 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - 0) / var_106_4

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= 0 + var_106_4 and arg_103_1.time_ < 0 + var_106_4 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play102801026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 102801026
		arg_107_1.duration_ = 2.57

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play102801027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_110_0 = arg_107_1.actors_["1028ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect1028ui_story == nil then
				arg_107_1.var_.characterEffect1028ui_story = var_110_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_1 = 0.0166666666666667

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_1 and not isNil(var_110_0) then
				if arg_107_1.var_.characterEffect1028ui_story and not isNil(var_110_0) then
					arg_107_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_1 and arg_107_1.time_ < 0 + var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect1028ui_story then
				arg_107_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_110_3 = 0
			local var_110_4 = 0.2

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_3 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_5 = arg_107_1:GetWordFromCfg(102801026)
				local var_110_6 = arg_107_1:FormatText(var_110_5.content)

				arg_107_1.text_.text = var_110_6

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_8 = 6 <= 0 and var_110_4 or var_110_4 * (utf8.len(var_110_6) / 6)

				if (6 <= 0 and var_110_4 or var_110_4 * (utf8.len(var_110_6) / 6)) > 0 and var_110_4 < var_110_8 then
					arg_107_1.talkMaxDuration = var_110_8

					if var_110_8 + var_110_3 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_8 + var_110_3
					end
				end

				arg_107_1.text_.text = var_110_6
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801026", "story_v_side_old_102801.awb") ~= 0 then
					local var_110_9 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801026", "story_v_side_old_102801.awb") / 1000

					if var_110_9 + var_110_3 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_9 + var_110_3
					end

					if var_110_5.prefab_name ~= "" and arg_107_1.actors_[var_110_5.prefab_name] ~= nil then
						local var_110_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_5.prefab_name].transform, "story_v_side_old_102801", "102801026", "story_v_side_old_102801.awb")

						arg_107_1:RecordAudio("102801026", var_110_10)
						arg_107_1:RecordAudio("102801026", var_110_10)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801026", "story_v_side_old_102801.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801026", "story_v_side_old_102801.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_11 = math.max(var_110_4, arg_107_1.talkMaxDuration)

			if var_110_3 <= arg_107_1.time_ and arg_107_1.time_ < var_110_3 + var_110_11 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_3) / var_110_11

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_3 + var_110_11 and arg_107_1.time_ < var_110_3 + var_110_11 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play102801027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 102801027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play102801028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["1028ui_story"]) and arg_111_1.var_.characterEffect1028ui_story == nil then
				arg_111_1.var_.characterEffect1028ui_story = arg_111_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_0 = 0.0166666666666667

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["1028ui_story"]) then
				if arg_111_1.var_.characterEffect1028ui_story and not isNil(arg_111_1.actors_["1028ui_story"]) then
					arg_111_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0) / var_114_0)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["1028ui_story"]) and arg_111_1.var_.characterEffect1028ui_story then
				arg_111_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_114_1 = 0
			local var_114_2 = 0.75

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
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

				local var_114_3 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(102801027).content)

				arg_111_1.text_.text = var_114_3

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 30 <= 0 and var_114_2 or var_114_2 * (utf8.len(var_114_3) / 30)

				if (30 <= 0 and var_114_2 or var_114_2 * (utf8.len(var_114_3) / 30)) > 0 and var_114_2 < var_114_5 then
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
	Play102801028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 102801028
		arg_115_1.duration_ = 2

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play102801029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_118_0 = arg_115_1.actors_["1028ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1028ui_story == nil then
				arg_115_1.var_.characterEffect1028ui_story = var_118_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_1 = 0.0166666666666667

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_1 and not isNil(var_118_0) then
				if arg_115_1.var_.characterEffect1028ui_story and not isNil(var_118_0) then
					arg_115_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_1 and arg_115_1.time_ < 0 + var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1028ui_story then
				arg_115_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_118_3 = 0
			local var_118_4 = 0.1

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_3 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_5 = arg_115_1:GetWordFromCfg(102801028)
				local var_118_6 = arg_115_1:FormatText(var_118_5.content)

				arg_115_1.text_.text = var_118_6

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_8 = 2 <= 0 and var_118_4 or var_118_4 * (utf8.len(var_118_6) / 2)

				if (2 <= 0 and var_118_4 or var_118_4 * (utf8.len(var_118_6) / 2)) > 0 and var_118_4 < var_118_8 then
					arg_115_1.talkMaxDuration = var_118_8

					if var_118_8 + var_118_3 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_8 + var_118_3
					end
				end

				arg_115_1.text_.text = var_118_6
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801028", "story_v_side_old_102801.awb") ~= 0 then
					local var_118_9 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801028", "story_v_side_old_102801.awb") / 1000

					if var_118_9 + var_118_3 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_9 + var_118_3
					end

					if var_118_5.prefab_name ~= "" and arg_115_1.actors_[var_118_5.prefab_name] ~= nil then
						local var_118_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_5.prefab_name].transform, "story_v_side_old_102801", "102801028", "story_v_side_old_102801.awb")

						arg_115_1:RecordAudio("102801028", var_118_10)
						arg_115_1:RecordAudio("102801028", var_118_10)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801028", "story_v_side_old_102801.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801028", "story_v_side_old_102801.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_11 = math.max(var_118_4, arg_115_1.talkMaxDuration)

			if var_118_3 <= arg_115_1.time_ and arg_115_1.time_ < var_118_3 + var_118_11 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_3) / var_118_11

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_3 + var_118_11 and arg_115_1.time_ < var_118_3 + var_118_11 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play102801029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 102801029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play102801030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["1028ui_story"]) and arg_119_1.var_.characterEffect1028ui_story == nil then
				arg_119_1.var_.characterEffect1028ui_story = arg_119_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_0 = 0.0166666666666667

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["1028ui_story"]) then
				if arg_119_1.var_.characterEffect1028ui_story and not isNil(arg_119_1.actors_["1028ui_story"]) then
					arg_119_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_0)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["1028ui_story"]) and arg_119_1.var_.characterEffect1028ui_story then
				arg_119_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_122_1 = 0
			local var_122_2 = 0.333333333333333

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_3 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(102801029).content)

				arg_119_1.text_.text = var_122_3

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_5 = 17 <= 0 and var_122_2 or var_122_2 * (utf8.len(var_122_3) / 17)

				if (17 <= 0 and var_122_2 or var_122_2 * (utf8.len(var_122_3) / 17)) > 0 and var_122_2 < var_122_5 then
					arg_119_1.talkMaxDuration = var_122_5

					if var_122_5 + var_122_1 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_5 + var_122_1
					end
				end

				arg_119_1.text_.text = var_122_3
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_6 = math.max(var_122_2, arg_119_1.talkMaxDuration)

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_6 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_1) / var_122_6

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_1 + var_122_6 and arg_119_1.time_ < var_122_1 + var_122_6 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play102801030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 102801030
		arg_123_1.duration_ = 4.63

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play102801031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action3_1")
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_126_0 = arg_123_1.actors_["1028ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1028ui_story == nil then
				arg_123_1.var_.characterEffect1028ui_story = var_126_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_1 = 0.034

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_1 and not isNil(var_126_0) then
				if arg_123_1.var_.characterEffect1028ui_story and not isNil(var_126_0) then
					arg_123_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_1 and arg_123_1.time_ < 0 + var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1028ui_story then
				arg_123_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_126_3 = 0
			local var_126_4 = 0.45

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_3 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_5 = arg_123_1:GetWordFromCfg(102801030)
				local var_126_6 = arg_123_1:FormatText(var_126_5.content)

				arg_123_1.text_.text = var_126_6

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_8 = 17 <= 0 and var_126_4 or var_126_4 * (utf8.len(var_126_6) / 17)

				if (17 <= 0 and var_126_4 or var_126_4 * (utf8.len(var_126_6) / 17)) > 0 and var_126_4 < var_126_8 then
					arg_123_1.talkMaxDuration = var_126_8

					if var_126_8 + var_126_3 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_3
					end
				end

				arg_123_1.text_.text = var_126_6
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801030", "story_v_side_old_102801.awb") ~= 0 then
					local var_126_9 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801030", "story_v_side_old_102801.awb") / 1000

					if var_126_9 + var_126_3 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_9 + var_126_3
					end

					if var_126_5.prefab_name ~= "" and arg_123_1.actors_[var_126_5.prefab_name] ~= nil then
						local var_126_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_5.prefab_name].transform, "story_v_side_old_102801", "102801030", "story_v_side_old_102801.awb")

						arg_123_1:RecordAudio("102801030", var_126_10)
						arg_123_1:RecordAudio("102801030", var_126_10)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801030", "story_v_side_old_102801.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801030", "story_v_side_old_102801.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_11 = math.max(var_126_4, arg_123_1.talkMaxDuration)

			if var_126_3 <= arg_123_1.time_ and arg_123_1.time_ < var_126_3 + var_126_11 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_3) / var_126_11

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_3 + var_126_11 and arg_123_1.time_ < var_126_3 + var_126_11 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play102801031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 102801031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play102801032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.65

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_1 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(102801031).content)

				arg_127_1.text_.text = var_130_1

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_3 = 26 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 26)

				if (26 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 26)) > 0 and var_130_0 < var_130_3 then
					arg_127_1.talkMaxDuration = var_130_3

					if var_130_3 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_3 + 0
					end
				end

				arg_127_1.text_.text = var_130_1
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_4 = math.max(var_130_0, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - 0) / var_130_4

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play102801032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 102801032
		arg_131_1.duration_ = 15.73

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play102801033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action3_2")
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_134_0 = 0
			local var_134_1 = 0.7

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_2 = arg_131_1:GetWordFromCfg(102801032)
				local var_134_3 = arg_131_1:FormatText(var_134_2.content)

				arg_131_1.text_.text = var_134_3

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 39 <= 0 and var_134_1 or var_134_1 * (utf8.len(var_134_3) / 39)

				if (39 <= 0 and var_134_1 or var_134_1 * (utf8.len(var_134_3) / 39)) > 0 and var_134_1 < var_134_5 then
					arg_131_1.talkMaxDuration = var_134_5

					if var_134_5 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_5 + var_134_0
					end
				end

				arg_131_1.text_.text = var_134_3
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801032", "story_v_side_old_102801.awb") ~= 0 then
					local var_134_6 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801032", "story_v_side_old_102801.awb") / 1000

					if var_134_6 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_6 + var_134_0
					end

					if var_134_2.prefab_name ~= "" and arg_131_1.actors_[var_134_2.prefab_name] ~= nil then
						local var_134_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_2.prefab_name].transform, "story_v_side_old_102801", "102801032", "story_v_side_old_102801.awb")

						arg_131_1:RecordAudio("102801032", var_134_7)
						arg_131_1:RecordAudio("102801032", var_134_7)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801032", "story_v_side_old_102801.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801032", "story_v_side_old_102801.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_8 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_8 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_8

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_8 and arg_131_1.time_ < var_134_0 + var_134_8 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play102801033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 102801033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play102801034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["1028ui_story"]) and arg_135_1.var_.characterEffect1028ui_story == nil then
				arg_135_1.var_.characterEffect1028ui_story = arg_135_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_0 = 0.0166666666666667

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["1028ui_story"]) then
				if arg_135_1.var_.characterEffect1028ui_story and not isNil(arg_135_1.actors_["1028ui_story"]) then
					arg_135_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_135_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_135_1.time_ - 0) / var_138_0)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["1028ui_story"]) and arg_135_1.var_.characterEffect1028ui_story then
				arg_135_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_135_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_138_1 = 0
			local var_138_2 = 0.675

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_3 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(102801033).content)

				arg_135_1.text_.text = var_138_3

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 27 <= 0 and var_138_2 or var_138_2 * (utf8.len(var_138_3) / 27)

				if (27 <= 0 and var_138_2 or var_138_2 * (utf8.len(var_138_3) / 27)) > 0 and var_138_2 < var_138_5 then
					arg_135_1.talkMaxDuration = var_138_5

					if var_138_5 + var_138_1 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_5 + var_138_1
					end
				end

				arg_135_1.text_.text = var_138_3
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_6 = math.max(var_138_2, arg_135_1.talkMaxDuration)

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_6 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_1) / var_138_6

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_1 + var_138_6 and arg_135_1.time_ < var_138_1 + var_138_6 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play102801034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 102801034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play102801035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 1

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_1 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(102801034).content)

				arg_139_1.text_.text = var_142_1

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_3 = 57 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 57)

				if (57 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 57)) > 0 and var_142_0 < var_142_3 then
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
	Play102801035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 102801035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play102801036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 1.4

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_1 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(102801035).content)

				arg_143_1.text_.text = var_146_1

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_3 = 76 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 76)

				if (76 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 76)) > 0 and var_146_0 < var_146_3 then
					arg_143_1.talkMaxDuration = var_146_3

					if var_146_3 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_3 + 0
					end
				end

				arg_143_1.text_.text = var_146_1
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_4 = math.max(var_146_0, arg_143_1.talkMaxDuration)

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_4 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - 0) / var_146_4

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= 0 + var_146_4 and arg_143_1.time_ < 0 + var_146_4 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play102801036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 102801036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play102801037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0.525

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_1 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(102801036).content)

				arg_147_1.text_.text = var_150_1

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_3 = 21 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 21)

				if (21 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 21)) > 0 and var_150_0 < var_150_3 then
					arg_147_1.talkMaxDuration = var_150_3

					if var_150_3 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_3 + 0
					end
				end

				arg_147_1.text_.text = var_150_1
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_4 = math.max(var_150_0, arg_147_1.talkMaxDuration)

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_4 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - 0) / var_150_4

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= 0 + var_150_4 and arg_147_1.time_ < 0 + var_150_4 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play102801037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 102801037
		arg_151_1.duration_ = 14.5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play102801038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action6_1")
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_154_0 = arg_151_1.actors_["1028ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1028ui_story == nil then
				arg_151_1.var_.characterEffect1028ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_1 = 0.034

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_1 and not isNil(var_154_0) then
				if arg_151_1.var_.characterEffect1028ui_story and not isNil(var_154_0) then
					arg_151_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_1 and arg_151_1.time_ < 0 + var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1028ui_story then
				arg_151_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_154_3 = 0
			local var_154_4 = 0.6

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_3 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_5 = arg_151_1:GetWordFromCfg(102801037)
				local var_154_6 = arg_151_1:FormatText(var_154_5.content)

				arg_151_1.text_.text = var_154_6

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_8 = 34 <= 0 and var_154_4 or var_154_4 * (utf8.len(var_154_6) / 34)

				if (34 <= 0 and var_154_4 or var_154_4 * (utf8.len(var_154_6) / 34)) > 0 and var_154_4 < var_154_8 then
					arg_151_1.talkMaxDuration = var_154_8

					if var_154_8 + var_154_3 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_8 + var_154_3
					end
				end

				arg_151_1.text_.text = var_154_6
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801037", "story_v_side_old_102801.awb") ~= 0 then
					local var_154_9 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801037", "story_v_side_old_102801.awb") / 1000

					if var_154_9 + var_154_3 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_9 + var_154_3
					end

					if var_154_5.prefab_name ~= "" and arg_151_1.actors_[var_154_5.prefab_name] ~= nil then
						local var_154_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_5.prefab_name].transform, "story_v_side_old_102801", "102801037", "story_v_side_old_102801.awb")

						arg_151_1:RecordAudio("102801037", var_154_10)
						arg_151_1:RecordAudio("102801037", var_154_10)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801037", "story_v_side_old_102801.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801037", "story_v_side_old_102801.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_11 = math.max(var_154_4, arg_151_1.talkMaxDuration)

			if var_154_3 <= arg_151_1.time_ and arg_151_1.time_ < var_154_3 + var_154_11 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_3) / var_154_11

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_3 + var_154_11 and arg_151_1.time_ < var_154_3 + var_154_11 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play102801038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 102801038
		arg_155_1.duration_ = 9.37

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play102801039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_158_0 = 0
			local var_158_1 = 0.85

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_2 = arg_155_1:GetWordFromCfg(102801038)
				local var_158_3 = arg_155_1:FormatText(var_158_2.content)

				arg_155_1.text_.text = var_158_3

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 34 <= 0 and var_158_1 or var_158_1 * (utf8.len(var_158_3) / 34)

				if (34 <= 0 and var_158_1 or var_158_1 * (utf8.len(var_158_3) / 34)) > 0 and var_158_1 < var_158_5 then
					arg_155_1.talkMaxDuration = var_158_5

					if var_158_5 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + var_158_0
					end
				end

				arg_155_1.text_.text = var_158_3
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801038", "story_v_side_old_102801.awb") ~= 0 then
					local var_158_6 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801038", "story_v_side_old_102801.awb") / 1000

					if var_158_6 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_6 + var_158_0
					end

					if var_158_2.prefab_name ~= "" and arg_155_1.actors_[var_158_2.prefab_name] ~= nil then
						local var_158_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_2.prefab_name].transform, "story_v_side_old_102801", "102801038", "story_v_side_old_102801.awb")

						arg_155_1:RecordAudio("102801038", var_158_7)
						arg_155_1:RecordAudio("102801038", var_158_7)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801038", "story_v_side_old_102801.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801038", "story_v_side_old_102801.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_8 = math.max(var_158_1, arg_155_1.talkMaxDuration)

			if var_158_0 <= arg_155_1.time_ and arg_155_1.time_ < var_158_0 + var_158_8 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_0) / var_158_8

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_0 + var_158_8 and arg_155_1.time_ < var_158_0 + var_158_8 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play102801039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 102801039
		arg_159_1.duration_ = 6.67

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play102801040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action6_2")
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_162_0 = 0
			local var_162_1 = 0.65

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_2 = arg_159_1:GetWordFromCfg(102801039)
				local var_162_3 = arg_159_1:FormatText(var_162_2.content)

				arg_159_1.text_.text = var_162_3

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 26 <= 0 and var_162_1 or var_162_1 * (utf8.len(var_162_3) / 26)

				if (26 <= 0 and var_162_1 or var_162_1 * (utf8.len(var_162_3) / 26)) > 0 and var_162_1 < var_162_5 then
					arg_159_1.talkMaxDuration = var_162_5

					if var_162_5 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + var_162_0
					end
				end

				arg_159_1.text_.text = var_162_3
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801039", "story_v_side_old_102801.awb") ~= 0 then
					local var_162_6 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801039", "story_v_side_old_102801.awb") / 1000

					if var_162_6 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_6 + var_162_0
					end

					if var_162_2.prefab_name ~= "" and arg_159_1.actors_[var_162_2.prefab_name] ~= nil then
						local var_162_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_2.prefab_name].transform, "story_v_side_old_102801", "102801039", "story_v_side_old_102801.awb")

						arg_159_1:RecordAudio("102801039", var_162_7)
						arg_159_1:RecordAudio("102801039", var_162_7)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801039", "story_v_side_old_102801.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801039", "story_v_side_old_102801.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_8 = math.max(var_162_1, arg_159_1.talkMaxDuration)

			if var_162_0 <= arg_159_1.time_ and arg_159_1.time_ < var_162_0 + var_162_8 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_0) / var_162_8

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_0 + var_162_8 and arg_159_1.time_ < var_162_0 + var_162_8 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play102801040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 102801040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play102801041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["1028ui_story"]) and arg_163_1.var_.characterEffect1028ui_story == nil then
				arg_163_1.var_.characterEffect1028ui_story = arg_163_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_0 = 0.034

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["1028ui_story"]) then
				if arg_163_1.var_.characterEffect1028ui_story and not isNil(arg_163_1.actors_["1028ui_story"]) then
					arg_163_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_0)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["1028ui_story"]) and arg_163_1.var_.characterEffect1028ui_story then
				arg_163_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_166_1 = 0
			local var_166_2 = 0.1

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_3 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(102801040).content)

				arg_163_1.text_.text = var_166_3

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 2 <= 0 and var_166_2 or var_166_2 * (utf8.len(var_166_3) / 2)

				if (2 <= 0 and var_166_2 or var_166_2 * (utf8.len(var_166_3) / 2)) > 0 and var_166_2 < var_166_5 then
					arg_163_1.talkMaxDuration = var_166_5

					if var_166_5 + var_166_1 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_5 + var_166_1
					end
				end

				arg_163_1.text_.text = var_166_3
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_6 = math.max(var_166_2, arg_163_1.talkMaxDuration)

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_6 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_1) / var_166_6

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_1 + var_166_6 and arg_163_1.time_ < var_166_1 + var_166_6 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play102801041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 102801041
		arg_167_1.duration_ = 7.23

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play102801042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_170_0 = arg_167_1.actors_["1028ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect1028ui_story == nil then
				arg_167_1.var_.characterEffect1028ui_story = var_170_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_1 = 0.034

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_1 and not isNil(var_170_0) then
				if arg_167_1.var_.characterEffect1028ui_story and not isNil(var_170_0) then
					arg_167_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_1 and arg_167_1.time_ < 0 + var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect1028ui_story then
				arg_167_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_170_3 = 0
			local var_170_4 = 0.633333333333333

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_3 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_5 = arg_167_1:GetWordFromCfg(102801041)
				local var_170_6 = arg_167_1:FormatText(var_170_5.content)

				arg_167_1.text_.text = var_170_6

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_8 = 56 <= 0 and var_170_4 or var_170_4 * (utf8.len(var_170_6) / 56)

				if (56 <= 0 and var_170_4 or var_170_4 * (utf8.len(var_170_6) / 56)) > 0 and var_170_4 < var_170_8 then
					arg_167_1.talkMaxDuration = var_170_8

					if var_170_8 + var_170_3 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_3
					end
				end

				arg_167_1.text_.text = var_170_6
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801041", "story_v_side_old_102801.awb") ~= 0 then
					local var_170_9 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801041", "story_v_side_old_102801.awb") / 1000

					if var_170_9 + var_170_3 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_9 + var_170_3
					end

					if var_170_5.prefab_name ~= "" and arg_167_1.actors_[var_170_5.prefab_name] ~= nil then
						local var_170_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_5.prefab_name].transform, "story_v_side_old_102801", "102801041", "story_v_side_old_102801.awb")

						arg_167_1:RecordAudio("102801041", var_170_10)
						arg_167_1:RecordAudio("102801041", var_170_10)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801041", "story_v_side_old_102801.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801041", "story_v_side_old_102801.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_11 = math.max(var_170_4, arg_167_1.talkMaxDuration)

			if var_170_3 <= arg_167_1.time_ and arg_167_1.time_ < var_170_3 + var_170_11 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_3) / var_170_11

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_3 + var_170_11 and arg_167_1.time_ < var_170_3 + var_170_11 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play102801042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 102801042
		arg_171_1.duration_ = 10.07

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play102801043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_174_0 = 0
			local var_174_1 = 0.666666666666667

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_2 = arg_171_1:GetWordFromCfg(102801042)
				local var_174_3 = arg_171_1:FormatText(var_174_2.content)

				arg_171_1.text_.text = var_174_3

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 48 <= 0 and var_174_1 or var_174_1 * (utf8.len(var_174_3) / 48)

				if (48 <= 0 and var_174_1 or var_174_1 * (utf8.len(var_174_3) / 48)) > 0 and var_174_1 < var_174_5 then
					arg_171_1.talkMaxDuration = var_174_5

					if var_174_5 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + var_174_0
					end
				end

				arg_171_1.text_.text = var_174_3
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801042", "story_v_side_old_102801.awb") ~= 0 then
					local var_174_6 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801042", "story_v_side_old_102801.awb") / 1000

					if var_174_6 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_6 + var_174_0
					end

					if var_174_2.prefab_name ~= "" and arg_171_1.actors_[var_174_2.prefab_name] ~= nil then
						local var_174_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_2.prefab_name].transform, "story_v_side_old_102801", "102801042", "story_v_side_old_102801.awb")

						arg_171_1:RecordAudio("102801042", var_174_7)
						arg_171_1:RecordAudio("102801042", var_174_7)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801042", "story_v_side_old_102801.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801042", "story_v_side_old_102801.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_8 = math.max(var_174_1, arg_171_1.talkMaxDuration)

			if var_174_0 <= arg_171_1.time_ and arg_171_1.time_ < var_174_0 + var_174_8 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_0) / var_174_8

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_0 + var_174_8 and arg_171_1.time_ < var_174_0 + var_174_8 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play102801043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 102801043
		arg_175_1.duration_ = 13.3

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play102801044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_178_0 = 0
			local var_178_1 = 0.6

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_2 = arg_175_1:GetWordFromCfg(102801043)
				local var_178_3 = arg_175_1:FormatText(var_178_2.content)

				arg_175_1.text_.text = var_178_3

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 41 <= 0 and var_178_1 or var_178_1 * (utf8.len(var_178_3) / 41)

				if (41 <= 0 and var_178_1 or var_178_1 * (utf8.len(var_178_3) / 41)) > 0 and var_178_1 < var_178_5 then
					arg_175_1.talkMaxDuration = var_178_5

					if var_178_5 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + var_178_0
					end
				end

				arg_175_1.text_.text = var_178_3
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801043", "story_v_side_old_102801.awb") ~= 0 then
					local var_178_6 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801043", "story_v_side_old_102801.awb") / 1000

					if var_178_6 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_6 + var_178_0
					end

					if var_178_2.prefab_name ~= "" and arg_175_1.actors_[var_178_2.prefab_name] ~= nil then
						local var_178_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_2.prefab_name].transform, "story_v_side_old_102801", "102801043", "story_v_side_old_102801.awb")

						arg_175_1:RecordAudio("102801043", var_178_7)
						arg_175_1:RecordAudio("102801043", var_178_7)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801043", "story_v_side_old_102801.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801043", "story_v_side_old_102801.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_8 = math.max(var_178_1, arg_175_1.talkMaxDuration)

			if var_178_0 <= arg_175_1.time_ and arg_175_1.time_ < var_178_0 + var_178_8 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_0) / var_178_8

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_0 + var_178_8 and arg_175_1.time_ < var_178_0 + var_178_8 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play102801044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 102801044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play102801045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["1028ui_story"]) and arg_179_1.var_.characterEffect1028ui_story == nil then
				arg_179_1.var_.characterEffect1028ui_story = arg_179_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_0 = 0.034

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["1028ui_story"]) then
				if arg_179_1.var_.characterEffect1028ui_story and not isNil(arg_179_1.actors_["1028ui_story"]) then
					arg_179_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_179_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_179_1.time_ - 0) / var_182_0)
				end
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["1028ui_story"]) and arg_179_1.var_.characterEffect1028ui_story then
				arg_179_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_179_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_182_1 = 0
			local var_182_2 = 0.325

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_3 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(102801044).content)

				arg_179_1.text_.text = var_182_3

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 13 <= 0 and var_182_2 or var_182_2 * (utf8.len(var_182_3) / 13)

				if (13 <= 0 and var_182_2 or var_182_2 * (utf8.len(var_182_3) / 13)) > 0 and var_182_2 < var_182_5 then
					arg_179_1.talkMaxDuration = var_182_5

					if var_182_5 + var_182_1 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_5 + var_182_1
					end
				end

				arg_179_1.text_.text = var_182_3
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_6 = math.max(var_182_2, arg_179_1.talkMaxDuration)

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_6 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_1) / var_182_6

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_1 + var_182_6 and arg_179_1.time_ < var_182_1 + var_182_6 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play102801045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 102801045
		arg_183_1.duration_ = 10.97

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play102801046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_186_0 = arg_183_1.actors_["1028ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1028ui_story == nil then
				arg_183_1.var_.characterEffect1028ui_story = var_186_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_1 = 0.034

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_1 and not isNil(var_186_0) then
				if arg_183_1.var_.characterEffect1028ui_story and not isNil(var_186_0) then
					arg_183_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_1 and arg_183_1.time_ < 0 + var_186_1 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1028ui_story then
				arg_183_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_186_3 = 0
			local var_186_4 = 0.5

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_3 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_5 = arg_183_1:GetWordFromCfg(102801045)
				local var_186_6 = arg_183_1:FormatText(var_186_5.content)

				arg_183_1.text_.text = var_186_6

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_8 = 36 <= 0 and var_186_4 or var_186_4 * (utf8.len(var_186_6) / 36)

				if (36 <= 0 and var_186_4 or var_186_4 * (utf8.len(var_186_6) / 36)) > 0 and var_186_4 < var_186_8 then
					arg_183_1.talkMaxDuration = var_186_8

					if var_186_8 + var_186_3 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_8 + var_186_3
					end
				end

				arg_183_1.text_.text = var_186_6
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801045", "story_v_side_old_102801.awb") ~= 0 then
					local var_186_9 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801045", "story_v_side_old_102801.awb") / 1000

					if var_186_9 + var_186_3 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_9 + var_186_3
					end

					if var_186_5.prefab_name ~= "" and arg_183_1.actors_[var_186_5.prefab_name] ~= nil then
						local var_186_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_5.prefab_name].transform, "story_v_side_old_102801", "102801045", "story_v_side_old_102801.awb")

						arg_183_1:RecordAudio("102801045", var_186_10)
						arg_183_1:RecordAudio("102801045", var_186_10)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801045", "story_v_side_old_102801.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801045", "story_v_side_old_102801.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_11 = math.max(var_186_4, arg_183_1.talkMaxDuration)

			if var_186_3 <= arg_183_1.time_ and arg_183_1.time_ < var_186_3 + var_186_11 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_3) / var_186_11

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_3 + var_186_11 and arg_183_1.time_ < var_186_3 + var_186_11 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play102801046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 102801046
		arg_187_1.duration_ = 8.83

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play102801047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.5

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_1 = arg_187_1:GetWordFromCfg(102801046)
				local var_190_2 = arg_187_1:FormatText(var_190_1.content)

				arg_187_1.text_.text = var_190_2

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 40 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 40)

				if (40 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 40)) > 0 and var_190_0 < var_190_4 then
					arg_187_1.talkMaxDuration = var_190_4

					if var_190_4 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_4 + 0
					end
				end

				arg_187_1.text_.text = var_190_2
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801046", "story_v_side_old_102801.awb") ~= 0 then
					local var_190_5 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801046", "story_v_side_old_102801.awb") / 1000

					if var_190_5 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + 0
					end

					if var_190_1.prefab_name ~= "" and arg_187_1.actors_[var_190_1.prefab_name] ~= nil then
						local var_190_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_1.prefab_name].transform, "story_v_side_old_102801", "102801046", "story_v_side_old_102801.awb")

						arg_187_1:RecordAudio("102801046", var_190_6)
						arg_187_1:RecordAudio("102801046", var_190_6)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801046", "story_v_side_old_102801.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801046", "story_v_side_old_102801.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_7 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_7 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_7

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_7 and arg_187_1.time_ < 0 + var_190_7 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play102801047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 102801047
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play102801048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["1028ui_story"]) and arg_191_1.var_.characterEffect1028ui_story == nil then
				arg_191_1.var_.characterEffect1028ui_story = arg_191_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_0 = 0.034

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 and not isNil(arg_191_1.actors_["1028ui_story"]) then
				if arg_191_1.var_.characterEffect1028ui_story and not isNil(arg_191_1.actors_["1028ui_story"]) then
					arg_191_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_191_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_191_1.time_ - 0) / var_194_0)
				end
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 and not isNil(arg_191_1.actors_["1028ui_story"]) and arg_191_1.var_.characterEffect1028ui_story then
				arg_191_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_191_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_194_1 = 0
			local var_194_2 = 0.2

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_3 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(102801047).content)

				arg_191_1.text_.text = var_194_3

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 4 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_3) / 4)

				if (4 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_3) / 4)) > 0 and var_194_2 < var_194_5 then
					arg_191_1.talkMaxDuration = var_194_5

					if var_194_5 + var_194_1 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_5 + var_194_1
					end
				end

				arg_191_1.text_.text = var_194_3
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_6 = math.max(var_194_2, arg_191_1.talkMaxDuration)

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_6 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_1) / var_194_6

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_1 + var_194_6 and arg_191_1.time_ < var_194_1 + var_194_6 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play102801048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 102801048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play102801049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.633333333333333

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_1 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(102801048).content)

				arg_195_1.text_.text = var_198_1

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_3 = 50 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 50)

				if (50 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 50)) > 0 and var_198_0 < var_198_3 then
					arg_195_1.talkMaxDuration = var_198_3

					if var_198_3 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_3 + 0
					end
				end

				arg_195_1.text_.text = var_198_1
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_4 = math.max(var_198_0, arg_195_1.talkMaxDuration)

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_4 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - 0) / var_198_4

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= 0 + var_198_4 and arg_195_1.time_ < 0 + var_198_4 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play102801049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 102801049
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play102801050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0.6

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_1 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(102801049).content)

				arg_199_1.text_.text = var_202_1

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_3 = 32 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 32)

				if (32 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 32)) > 0 and var_202_0 < var_202_3 then
					arg_199_1.talkMaxDuration = var_202_3

					if var_202_3 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_3 + 0
					end
				end

				arg_199_1.text_.text = var_202_1
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_4 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_4 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_4

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_4 and arg_199_1.time_ < 0 + var_202_4 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play102801050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 102801050
		arg_203_1.duration_ = 2

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play102801051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_206_0 = arg_203_1.actors_["1028ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect1028ui_story == nil then
				arg_203_1.var_.characterEffect1028ui_story = var_206_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_1 = 0.034

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_1 and not isNil(var_206_0) then
				if arg_203_1.var_.characterEffect1028ui_story and not isNil(var_206_0) then
					arg_203_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_1 and arg_203_1.time_ < 0 + var_206_1 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect1028ui_story then
				arg_203_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_206_3 = 0
			local var_206_4 = 0.05

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_3 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_5 = arg_203_1:GetWordFromCfg(102801050)
				local var_206_6 = arg_203_1:FormatText(var_206_5.content)

				arg_203_1.text_.text = var_206_6

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_8 = 2 <= 0 and var_206_4 or var_206_4 * (utf8.len(var_206_6) / 2)

				if (2 <= 0 and var_206_4 or var_206_4 * (utf8.len(var_206_6) / 2)) > 0 and var_206_4 < var_206_8 then
					arg_203_1.talkMaxDuration = var_206_8

					if var_206_8 + var_206_3 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_8 + var_206_3
					end
				end

				arg_203_1.text_.text = var_206_6
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801050", "story_v_side_old_102801.awb") ~= 0 then
					local var_206_9 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801050", "story_v_side_old_102801.awb") / 1000

					if var_206_9 + var_206_3 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_9 + var_206_3
					end

					if var_206_5.prefab_name ~= "" and arg_203_1.actors_[var_206_5.prefab_name] ~= nil then
						local var_206_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_5.prefab_name].transform, "story_v_side_old_102801", "102801050", "story_v_side_old_102801.awb")

						arg_203_1:RecordAudio("102801050", var_206_10)
						arg_203_1:RecordAudio("102801050", var_206_10)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801050", "story_v_side_old_102801.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801050", "story_v_side_old_102801.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_11 = math.max(var_206_4, arg_203_1.talkMaxDuration)

			if var_206_3 <= arg_203_1.time_ and arg_203_1.time_ < var_206_3 + var_206_11 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_3) / var_206_11

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_3 + var_206_11 and arg_203_1.time_ < var_206_3 + var_206_11 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play102801051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 102801051
		arg_207_1.duration_ = 7.43

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play102801052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_210_0 = 0
			local var_210_1 = 0.325

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_2 = arg_207_1:GetWordFromCfg(102801051)
				local var_210_3 = arg_207_1:FormatText(var_210_2.content)

				arg_207_1.text_.text = var_210_3

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 13 <= 0 and var_210_1 or var_210_1 * (utf8.len(var_210_3) / 13)

				if (13 <= 0 and var_210_1 or var_210_1 * (utf8.len(var_210_3) / 13)) > 0 and var_210_1 < var_210_5 then
					arg_207_1.talkMaxDuration = var_210_5

					if var_210_5 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + var_210_0
					end
				end

				arg_207_1.text_.text = var_210_3
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801051", "story_v_side_old_102801.awb") ~= 0 then
					local var_210_6 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801051", "story_v_side_old_102801.awb") / 1000

					if var_210_6 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_6 + var_210_0
					end

					if var_210_2.prefab_name ~= "" and arg_207_1.actors_[var_210_2.prefab_name] ~= nil then
						local var_210_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_2.prefab_name].transform, "story_v_side_old_102801", "102801051", "story_v_side_old_102801.awb")

						arg_207_1:RecordAudio("102801051", var_210_7)
						arg_207_1:RecordAudio("102801051", var_210_7)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801051", "story_v_side_old_102801.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801051", "story_v_side_old_102801.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_8 = math.max(var_210_1, arg_207_1.talkMaxDuration)

			if var_210_0 <= arg_207_1.time_ and arg_207_1.time_ < var_210_0 + var_210_8 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_0) / var_210_8

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_0 + var_210_8 and arg_207_1.time_ < var_210_0 + var_210_8 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play102801052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 102801052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play102801053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action1_1")
			end

			local var_214_0 = 0
			local var_214_1 = 0.5

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_2 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(102801052).content)

				arg_211_1.text_.text = var_214_2

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_4 = 39 <= 0 and var_214_1 or var_214_1 * (utf8.len(var_214_2) / 39)

				if (39 <= 0 and var_214_1 or var_214_1 * (utf8.len(var_214_2) / 39)) > 0 and var_214_1 < var_214_4 then
					arg_211_1.talkMaxDuration = var_214_4

					if var_214_4 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_4 + var_214_0
					end
				end

				arg_211_1.text_.text = var_214_2
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_5 = math.max(var_214_1, arg_211_1.talkMaxDuration)

			if var_214_0 <= arg_211_1.time_ and arg_211_1.time_ < var_214_0 + var_214_5 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_0) / var_214_5

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_0 + var_214_5 and arg_211_1.time_ < var_214_0 + var_214_5 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play102801053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 102801053
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play102801054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(arg_215_1.actors_["1028ui_story"]) and arg_215_1.var_.characterEffect1028ui_story == nil then
				arg_215_1.var_.characterEffect1028ui_story = arg_215_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_0 = 0.034

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 and not isNil(arg_215_1.actors_["1028ui_story"]) then
				if arg_215_1.var_.characterEffect1028ui_story and not isNil(arg_215_1.actors_["1028ui_story"]) then
					arg_215_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_215_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_215_1.time_ - 0) / var_218_0)
				end
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 and not isNil(arg_215_1.actors_["1028ui_story"]) and arg_215_1.var_.characterEffect1028ui_story then
				arg_215_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_215_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_218_1 = 0
			local var_218_2 = 0.35

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_3 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(102801053).content)

				arg_215_1.text_.text = var_218_3

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_5 = 14 <= 0 and var_218_2 or var_218_2 * (utf8.len(var_218_3) / 14)

				if (14 <= 0 and var_218_2 or var_218_2 * (utf8.len(var_218_3) / 14)) > 0 and var_218_2 < var_218_5 then
					arg_215_1.talkMaxDuration = var_218_5

					if var_218_5 + var_218_1 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + var_218_1
					end
				end

				arg_215_1.text_.text = var_218_3
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_6 = math.max(var_218_2, arg_215_1.talkMaxDuration)

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_6 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_1) / var_218_6

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_1 + var_218_6 and arg_215_1.time_ < var_218_1 + var_218_6 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play102801054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 102801054
		arg_219_1.duration_ = 2

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play102801055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action7_1")
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_222_0 = arg_219_1.actors_["1028ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect1028ui_story == nil then
				arg_219_1.var_.characterEffect1028ui_story = var_222_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_1 = 0.034

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_1 and not isNil(var_222_0) then
				if arg_219_1.var_.characterEffect1028ui_story and not isNil(var_222_0) then
					arg_219_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 0 + var_222_1 and arg_219_1.time_ < 0 + var_222_1 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect1028ui_story then
				arg_219_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_222_3 = 0
			local var_222_4 = 0.1

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_3 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_5 = arg_219_1:GetWordFromCfg(102801054)
				local var_222_6 = arg_219_1:FormatText(var_222_5.content)

				arg_219_1.text_.text = var_222_6

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_8 = 4 <= 0 and var_222_4 or var_222_4 * (utf8.len(var_222_6) / 4)

				if (4 <= 0 and var_222_4 or var_222_4 * (utf8.len(var_222_6) / 4)) > 0 and var_222_4 < var_222_8 then
					arg_219_1.talkMaxDuration = var_222_8

					if var_222_8 + var_222_3 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_8 + var_222_3
					end
				end

				arg_219_1.text_.text = var_222_6
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801054", "story_v_side_old_102801.awb") ~= 0 then
					local var_222_9 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801054", "story_v_side_old_102801.awb") / 1000

					if var_222_9 + var_222_3 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_9 + var_222_3
					end

					if var_222_5.prefab_name ~= "" and arg_219_1.actors_[var_222_5.prefab_name] ~= nil then
						local var_222_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_5.prefab_name].transform, "story_v_side_old_102801", "102801054", "story_v_side_old_102801.awb")

						arg_219_1:RecordAudio("102801054", var_222_10)
						arg_219_1:RecordAudio("102801054", var_222_10)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801054", "story_v_side_old_102801.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801054", "story_v_side_old_102801.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_11 = math.max(var_222_4, arg_219_1.talkMaxDuration)

			if var_222_3 <= arg_219_1.time_ and arg_219_1.time_ < var_222_3 + var_222_11 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_3) / var_222_11

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_3 + var_222_11 and arg_219_1.time_ < var_222_3 + var_222_11 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play102801055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 102801055
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play102801056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0.4

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_1 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(102801055).content)

				arg_223_1.text_.text = var_226_1

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_3 = 16 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_1) / 16)

				if (16 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_1) / 16)) > 0 and var_226_0 < var_226_3 then
					arg_223_1.talkMaxDuration = var_226_3

					if var_226_3 + 0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_3 + 0
					end
				end

				arg_223_1.text_.text = var_226_1
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_4 = math.max(var_226_0, arg_223_1.talkMaxDuration)

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_4 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - 0) / var_226_4

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= 0 + var_226_4 and arg_223_1.time_ < 0 + var_226_4 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play102801056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 102801056
		arg_227_1.duration_ = 7.7

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play102801057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_230_0 = 0
			local var_230_1 = 0.5

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_2 = arg_227_1:GetWordFromCfg(102801056)
				local var_230_3 = arg_227_1:FormatText(var_230_2.content)

				arg_227_1.text_.text = var_230_3

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 23 <= 0 and var_230_1 or var_230_1 * (utf8.len(var_230_3) / 23)

				if (23 <= 0 and var_230_1 or var_230_1 * (utf8.len(var_230_3) / 23)) > 0 and var_230_1 < var_230_5 then
					arg_227_1.talkMaxDuration = var_230_5

					if var_230_5 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + var_230_0
					end
				end

				arg_227_1.text_.text = var_230_3
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801056", "story_v_side_old_102801.awb") ~= 0 then
					local var_230_6 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801056", "story_v_side_old_102801.awb") / 1000

					if var_230_6 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_6 + var_230_0
					end

					if var_230_2.prefab_name ~= "" and arg_227_1.actors_[var_230_2.prefab_name] ~= nil then
						local var_230_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_2.prefab_name].transform, "story_v_side_old_102801", "102801056", "story_v_side_old_102801.awb")

						arg_227_1:RecordAudio("102801056", var_230_7)
						arg_227_1:RecordAudio("102801056", var_230_7)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801056", "story_v_side_old_102801.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801056", "story_v_side_old_102801.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_8 = math.max(var_230_1, arg_227_1.talkMaxDuration)

			if var_230_0 <= arg_227_1.time_ and arg_227_1.time_ < var_230_0 + var_230_8 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_0) / var_230_8

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_0 + var_230_8 and arg_227_1.time_ < var_230_0 + var_230_8 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play102801057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 102801057
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play102801058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["1028ui_story"]) and arg_231_1.var_.characterEffect1028ui_story == nil then
				arg_231_1.var_.characterEffect1028ui_story = arg_231_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_0 = 0.034

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 and not isNil(arg_231_1.actors_["1028ui_story"]) then
				if arg_231_1.var_.characterEffect1028ui_story and not isNil(arg_231_1.actors_["1028ui_story"]) then
					arg_231_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_231_1.time_ - 0) / var_234_0)
				end
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 and not isNil(arg_231_1.actors_["1028ui_story"]) and arg_231_1.var_.characterEffect1028ui_story then
				arg_231_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_234_1 = 0
			local var_234_2 = 0.225

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_3 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(102801057).content)

				arg_231_1.text_.text = var_234_3

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_5 = 9 <= 0 and var_234_2 or var_234_2 * (utf8.len(var_234_3) / 9)

				if (9 <= 0 and var_234_2 or var_234_2 * (utf8.len(var_234_3) / 9)) > 0 and var_234_2 < var_234_5 then
					arg_231_1.talkMaxDuration = var_234_5

					if var_234_5 + var_234_1 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_5 + var_234_1
					end
				end

				arg_231_1.text_.text = var_234_3
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_6 = math.max(var_234_2, arg_231_1.talkMaxDuration)

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_6 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_1) / var_234_6

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_1 + var_234_6 and arg_231_1.time_ < var_234_1 + var_234_6 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play102801058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 102801058
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play102801059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0.625

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_1 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(102801058).content)

				arg_235_1.text_.text = var_238_1

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_3 = 25 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 25)

				if (25 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 25)) > 0 and var_238_0 < var_238_3 then
					arg_235_1.talkMaxDuration = var_238_3

					if var_238_3 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_3 + 0
					end
				end

				arg_235_1.text_.text = var_238_1
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_4 = math.max(var_238_0, arg_235_1.talkMaxDuration)

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_4 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - 0) / var_238_4

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= 0 + var_238_4 and arg_235_1.time_ < 0 + var_238_4 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play102801059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 102801059
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play102801060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0.5

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_1 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(102801059).content)

				arg_239_1.text_.text = var_242_1

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_3 = 33 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 33)

				if (33 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 33)) > 0 and var_242_0 < var_242_3 then
					arg_239_1.talkMaxDuration = var_242_3

					if var_242_3 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_3 + 0
					end
				end

				arg_239_1.text_.text = var_242_1
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_4 = math.max(var_242_0, arg_239_1.talkMaxDuration)

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_4 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - 0) / var_242_4

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= 0 + var_242_4 and arg_239_1.time_ < 0 + var_242_4 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play102801060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 102801060
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play102801061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0.125

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_1 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(102801060).content)

				arg_243_1.text_.text = var_246_1

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_3 = 5 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_1) / 5)

				if (5 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_1) / 5)) > 0 and var_246_0 < var_246_3 then
					arg_243_1.talkMaxDuration = var_246_3

					if var_246_3 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_3 + 0
					end
				end

				arg_243_1.text_.text = var_246_1
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_4 = math.max(var_246_0, arg_243_1.talkMaxDuration)

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_4 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - 0) / var_246_4

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= 0 + var_246_4 and arg_243_1.time_ < 0 + var_246_4 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play102801061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 102801061
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play102801062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0.6

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_1 = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(102801061).content)

				arg_247_1.text_.text = var_250_1

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_3 = 30 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_1) / 30)

				if (30 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_1) / 30)) > 0 and var_250_0 < var_250_3 then
					arg_247_1.talkMaxDuration = var_250_3

					if var_250_3 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_3 + 0
					end
				end

				arg_247_1.text_.text = var_250_1
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_4 = math.max(var_250_0, arg_247_1.talkMaxDuration)

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_4 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - 0) / var_250_4

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= 0 + var_250_4 and arg_247_1.time_ < 0 + var_250_4 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play102801062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 102801062
		arg_251_1.duration_ = 2

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play102801063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action7_2")
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_254_0 = arg_251_1.actors_["1028ui_story"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect1028ui_story == nil then
				arg_251_1.var_.characterEffect1028ui_story = var_254_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_1 = 0.034

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_1 and not isNil(var_254_0) then
				if arg_251_1.var_.characterEffect1028ui_story and not isNil(var_254_0) then
					arg_251_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= 0 + var_254_1 and arg_251_1.time_ < 0 + var_254_1 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect1028ui_story then
				arg_251_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_254_3 = 0
			local var_254_4 = 0.075

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_3 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_5 = arg_251_1:GetWordFromCfg(102801062)
				local var_254_6 = arg_251_1:FormatText(var_254_5.content)

				arg_251_1.text_.text = var_254_6

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_8 = 3 <= 0 and var_254_4 or var_254_4 * (utf8.len(var_254_6) / 3)

				if (3 <= 0 and var_254_4 or var_254_4 * (utf8.len(var_254_6) / 3)) > 0 and var_254_4 < var_254_8 then
					arg_251_1.talkMaxDuration = var_254_8

					if var_254_8 + var_254_3 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_8 + var_254_3
					end
				end

				arg_251_1.text_.text = var_254_6
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801062", "story_v_side_old_102801.awb") ~= 0 then
					local var_254_9 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801062", "story_v_side_old_102801.awb") / 1000

					if var_254_9 + var_254_3 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_9 + var_254_3
					end

					if var_254_5.prefab_name ~= "" and arg_251_1.actors_[var_254_5.prefab_name] ~= nil then
						local var_254_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_5.prefab_name].transform, "story_v_side_old_102801", "102801062", "story_v_side_old_102801.awb")

						arg_251_1:RecordAudio("102801062", var_254_10)
						arg_251_1:RecordAudio("102801062", var_254_10)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801062", "story_v_side_old_102801.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801062", "story_v_side_old_102801.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_11 = math.max(var_254_4, arg_251_1.talkMaxDuration)

			if var_254_3 <= arg_251_1.time_ and arg_251_1.time_ < var_254_3 + var_254_11 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_3) / var_254_11

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_3 + var_254_11 and arg_251_1.time_ < var_254_3 + var_254_11 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play102801063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 102801063
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play102801064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["1028ui_story"]) and arg_255_1.var_.characterEffect1028ui_story == nil then
				arg_255_1.var_.characterEffect1028ui_story = arg_255_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_0 = 0.034

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["1028ui_story"]) then
				if arg_255_1.var_.characterEffect1028ui_story and not isNil(arg_255_1.actors_["1028ui_story"]) then
					arg_255_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_255_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_255_1.time_ - 0) / var_258_0)
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["1028ui_story"]) and arg_255_1.var_.characterEffect1028ui_story then
				arg_255_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_255_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_258_1 = 0
			local var_258_2 = 0.225

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_3 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(102801063).content)

				arg_255_1.text_.text = var_258_3

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_5 = 9 <= 0 and var_258_2 or var_258_2 * (utf8.len(var_258_3) / 9)

				if (9 <= 0 and var_258_2 or var_258_2 * (utf8.len(var_258_3) / 9)) > 0 and var_258_2 < var_258_5 then
					arg_255_1.talkMaxDuration = var_258_5

					if var_258_5 + var_258_1 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + var_258_1
					end
				end

				arg_255_1.text_.text = var_258_3
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_6 = math.max(var_258_2, arg_255_1.talkMaxDuration)

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_6 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_1) / var_258_6

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_1 + var_258_6 and arg_255_1.time_ < var_258_1 + var_258_6 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play102801064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 102801064
		arg_259_1.duration_ = 2

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play102801065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action1_1")
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_262_0 = arg_259_1.actors_["1028ui_story"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.characterEffect1028ui_story == nil then
				arg_259_1.var_.characterEffect1028ui_story = var_262_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_1 = 0.034

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_1 and not isNil(var_262_0) then
				if arg_259_1.var_.characterEffect1028ui_story and not isNil(var_262_0) then
					arg_259_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= 0 + var_262_1 and arg_259_1.time_ < 0 + var_262_1 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.characterEffect1028ui_story then
				arg_259_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_262_3 = 0
			local var_262_4 = 0.05

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_3 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_5 = arg_259_1:GetWordFromCfg(102801064)
				local var_262_6 = arg_259_1:FormatText(var_262_5.content)

				arg_259_1.text_.text = var_262_6

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_8 = 2 <= 0 and var_262_4 or var_262_4 * (utf8.len(var_262_6) / 2)

				if (2 <= 0 and var_262_4 or var_262_4 * (utf8.len(var_262_6) / 2)) > 0 and var_262_4 < var_262_8 then
					arg_259_1.talkMaxDuration = var_262_8

					if var_262_8 + var_262_3 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_8 + var_262_3
					end
				end

				arg_259_1.text_.text = var_262_6
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801064", "story_v_side_old_102801.awb") ~= 0 then
					local var_262_9 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801064", "story_v_side_old_102801.awb") / 1000

					if var_262_9 + var_262_3 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_9 + var_262_3
					end

					if var_262_5.prefab_name ~= "" and arg_259_1.actors_[var_262_5.prefab_name] ~= nil then
						local var_262_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_5.prefab_name].transform, "story_v_side_old_102801", "102801064", "story_v_side_old_102801.awb")

						arg_259_1:RecordAudio("102801064", var_262_10)
						arg_259_1:RecordAudio("102801064", var_262_10)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801064", "story_v_side_old_102801.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801064", "story_v_side_old_102801.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_11 = math.max(var_262_4, arg_259_1.talkMaxDuration)

			if var_262_3 <= arg_259_1.time_ and arg_259_1.time_ < var_262_3 + var_262_11 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_3) / var_262_11

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_3 + var_262_11 and arg_259_1.time_ < var_262_3 + var_262_11 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play102801065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 102801065
		arg_263_1.duration_ = 11.53

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play102801066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action3_1")
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_266_0 = 0
			local var_266_1 = 0.6

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_0 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_2 = arg_263_1:GetWordFromCfg(102801065)
				local var_266_3 = arg_263_1:FormatText(var_266_2.content)

				arg_263_1.text_.text = var_266_3

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_5 = 33 <= 0 and var_266_1 or var_266_1 * (utf8.len(var_266_3) / 33)

				if (33 <= 0 and var_266_1 or var_266_1 * (utf8.len(var_266_3) / 33)) > 0 and var_266_1 < var_266_5 then
					arg_263_1.talkMaxDuration = var_266_5

					if var_266_5 + var_266_0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_5 + var_266_0
					end
				end

				arg_263_1.text_.text = var_266_3
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801065", "story_v_side_old_102801.awb") ~= 0 then
					local var_266_6 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801065", "story_v_side_old_102801.awb") / 1000

					if var_266_6 + var_266_0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_6 + var_266_0
					end

					if var_266_2.prefab_name ~= "" and arg_263_1.actors_[var_266_2.prefab_name] ~= nil then
						local var_266_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_2.prefab_name].transform, "story_v_side_old_102801", "102801065", "story_v_side_old_102801.awb")

						arg_263_1:RecordAudio("102801065", var_266_7)
						arg_263_1:RecordAudio("102801065", var_266_7)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801065", "story_v_side_old_102801.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801065", "story_v_side_old_102801.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_8 = math.max(var_266_1, arg_263_1.talkMaxDuration)

			if var_266_0 <= arg_263_1.time_ and arg_263_1.time_ < var_266_0 + var_266_8 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_0) / var_266_8

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_0 + var_266_8 and arg_263_1.time_ < var_266_0 + var_266_8 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play102801066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 102801066
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play102801067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(arg_267_1.actors_["1028ui_story"]) and arg_267_1.var_.characterEffect1028ui_story == nil then
				arg_267_1.var_.characterEffect1028ui_story = arg_267_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_0 = 0.034

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 and not isNil(arg_267_1.actors_["1028ui_story"]) then
				if arg_267_1.var_.characterEffect1028ui_story and not isNil(arg_267_1.actors_["1028ui_story"]) then
					arg_267_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_267_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_267_1.time_ - 0) / var_270_0)
				end
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 and not isNil(arg_267_1.actors_["1028ui_story"]) and arg_267_1.var_.characterEffect1028ui_story then
				arg_267_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_267_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_270_1 = 0
			local var_270_2 = 0.7

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_267_1.callingController_:SetSelectedState("normal")

				arg_267_1.keyicon_.color = Color.New(1, 1, 1)
				arg_267_1.icon_.color = Color.New(1, 1, 1)

				local var_270_3 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(102801066).content)

				arg_267_1.text_.text = var_270_3

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_5 = 28 <= 0 and var_270_2 or var_270_2 * (utf8.len(var_270_3) / 28)

				if (28 <= 0 and var_270_2 or var_270_2 * (utf8.len(var_270_3) / 28)) > 0 and var_270_2 < var_270_5 then
					arg_267_1.talkMaxDuration = var_270_5

					if var_270_5 + var_270_1 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_5 + var_270_1
					end
				end

				arg_267_1.text_.text = var_270_3
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_6 = math.max(var_270_2, arg_267_1.talkMaxDuration)

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_6 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_1) / var_270_6

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_1 + var_270_6 and arg_267_1.time_ < var_270_1 + var_270_6 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play102801067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 102801067
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play102801068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0.35

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_1 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(102801067).content)

				arg_271_1.text_.text = var_274_1

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_3 = 14 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 14)

				if (14 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 14)) > 0 and var_274_0 < var_274_3 then
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
	Play102801068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 102801068
		arg_275_1.duration_ = 2.4

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play102801069(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action3_2")
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_278_0 = arg_275_1.actors_["1028ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect1028ui_story == nil then
				arg_275_1.var_.characterEffect1028ui_story = var_278_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_1 = 0.034

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_1 and not isNil(var_278_0) then
				if arg_275_1.var_.characterEffect1028ui_story and not isNil(var_278_0) then
					arg_275_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= 0 + var_278_1 and arg_275_1.time_ < 0 + var_278_1 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect1028ui_story then
				arg_275_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_278_3 = 0
			local var_278_4 = 0.2

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_3 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_5 = arg_275_1:GetWordFromCfg(102801068)
				local var_278_6 = arg_275_1:FormatText(var_278_5.content)

				arg_275_1.text_.text = var_278_6

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_8 = 8 <= 0 and var_278_4 or var_278_4 * (utf8.len(var_278_6) / 8)

				if (8 <= 0 and var_278_4 or var_278_4 * (utf8.len(var_278_6) / 8)) > 0 and var_278_4 < var_278_8 then
					arg_275_1.talkMaxDuration = var_278_8

					if var_278_8 + var_278_3 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_8 + var_278_3
					end
				end

				arg_275_1.text_.text = var_278_6
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801068", "story_v_side_old_102801.awb") ~= 0 then
					local var_278_9 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801068", "story_v_side_old_102801.awb") / 1000

					if var_278_9 + var_278_3 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_9 + var_278_3
					end

					if var_278_5.prefab_name ~= "" and arg_275_1.actors_[var_278_5.prefab_name] ~= nil then
						local var_278_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_5.prefab_name].transform, "story_v_side_old_102801", "102801068", "story_v_side_old_102801.awb")

						arg_275_1:RecordAudio("102801068", var_278_10)
						arg_275_1:RecordAudio("102801068", var_278_10)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801068", "story_v_side_old_102801.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801068", "story_v_side_old_102801.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_11 = math.max(var_278_4, arg_275_1.talkMaxDuration)

			if var_278_3 <= arg_275_1.time_ and arg_275_1.time_ < var_278_3 + var_278_11 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_3) / var_278_11

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_3 + var_278_11 and arg_275_1.time_ < var_278_3 + var_278_11 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play102801069 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 102801069
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play102801070(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(arg_279_1.actors_["1028ui_story"]) and arg_279_1.var_.characterEffect1028ui_story == nil then
				arg_279_1.var_.characterEffect1028ui_story = arg_279_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_0 = 0.034

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 and not isNil(arg_279_1.actors_["1028ui_story"]) then
				if arg_279_1.var_.characterEffect1028ui_story and not isNil(arg_279_1.actors_["1028ui_story"]) then
					arg_279_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_279_1.time_ - 0) / var_282_0)
				end
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 and not isNil(arg_279_1.actors_["1028ui_story"]) and arg_279_1.var_.characterEffect1028ui_story then
				arg_279_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_282_1 = 0
			local var_282_2 = 0.6

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, true)
				arg_279_1.iconController_:SetSelectedState("hero")

				arg_279_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_279_1.callingController_:SetSelectedState("normal")

				arg_279_1.keyicon_.color = Color.New(1, 1, 1)
				arg_279_1.icon_.color = Color.New(1, 1, 1)

				local var_282_3 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(102801069).content)

				arg_279_1.text_.text = var_282_3

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_5 = 34 <= 0 and var_282_2 or var_282_2 * (utf8.len(var_282_3) / 34)

				if (34 <= 0 and var_282_2 or var_282_2 * (utf8.len(var_282_3) / 34)) > 0 and var_282_2 < var_282_5 then
					arg_279_1.talkMaxDuration = var_282_5

					if var_282_5 + var_282_1 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_5 + var_282_1
					end
				end

				arg_279_1.text_.text = var_282_3
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_6 = math.max(var_282_2, arg_279_1.talkMaxDuration)

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_6 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_1) / var_282_6

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_1 + var_282_6 and arg_279_1.time_ < var_282_1 + var_282_6 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play102801070 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 102801070
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play102801071(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 1

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

				local var_286_1 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(102801070).content)

				arg_283_1.text_.text = var_286_1

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_3 = 54 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 54)

				if (54 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 54)) > 0 and var_286_0 < var_286_3 then
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
	Play102801071 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 102801071
		arg_287_1.duration_ = 3.4

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play102801072(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(arg_287_1.actors_["1028ui_story"]) and arg_287_1.var_.characterEffect1028ui_story == nil then
				arg_287_1.var_.characterEffect1028ui_story = arg_287_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_0 = 0.034

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 and not isNil(arg_287_1.actors_["1028ui_story"]) then
				if arg_287_1.var_.characterEffect1028ui_story and not isNil(arg_287_1.actors_["1028ui_story"]) then
					arg_287_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 and not isNil(arg_287_1.actors_["1028ui_story"]) and arg_287_1.var_.characterEffect1028ui_story then
				arg_287_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_290_2 = 0
			local var_290_3 = 0.25

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_2 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_4 = arg_287_1:GetWordFromCfg(102801071)
				local var_290_5 = arg_287_1:FormatText(var_290_4.content)

				arg_287_1.text_.text = var_290_5

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_7 = 10 <= 0 and var_290_3 or var_290_3 * (utf8.len(var_290_5) / 10)

				if (10 <= 0 and var_290_3 or var_290_3 * (utf8.len(var_290_5) / 10)) > 0 and var_290_3 < var_290_7 then
					arg_287_1.talkMaxDuration = var_290_7

					if var_290_7 + var_290_2 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_7 + var_290_2
					end
				end

				arg_287_1.text_.text = var_290_5
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801071", "story_v_side_old_102801.awb") ~= 0 then
					local var_290_8 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801071", "story_v_side_old_102801.awb") / 1000

					if var_290_8 + var_290_2 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_8 + var_290_2
					end

					if var_290_4.prefab_name ~= "" and arg_287_1.actors_[var_290_4.prefab_name] ~= nil then
						local var_290_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_4.prefab_name].transform, "story_v_side_old_102801", "102801071", "story_v_side_old_102801.awb")

						arg_287_1:RecordAudio("102801071", var_290_9)
						arg_287_1:RecordAudio("102801071", var_290_9)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801071", "story_v_side_old_102801.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801071", "story_v_side_old_102801.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_10 = math.max(var_290_3, arg_287_1.talkMaxDuration)

			if var_290_2 <= arg_287_1.time_ and arg_287_1.time_ < var_290_2 + var_290_10 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_2) / var_290_10

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_2 + var_290_10 and arg_287_1.time_ < var_290_2 + var_290_10 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play102801072 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 102801072
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play102801073(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(arg_291_1.actors_["1028ui_story"]) and arg_291_1.var_.characterEffect1028ui_story == nil then
				arg_291_1.var_.characterEffect1028ui_story = arg_291_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_0 = 0.034

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 and not isNil(arg_291_1.actors_["1028ui_story"]) then
				if arg_291_1.var_.characterEffect1028ui_story and not isNil(arg_291_1.actors_["1028ui_story"]) then
					arg_291_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_291_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_291_1.time_ - 0) / var_294_0)
				end
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 and not isNil(arg_291_1.actors_["1028ui_story"]) and arg_291_1.var_.characterEffect1028ui_story then
				arg_291_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_291_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_294_1 = 0
			local var_294_2 = 0.1

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 then
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

				local var_294_3 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(102801072).content)

				arg_291_1.text_.text = var_294_3

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_5 = 4 <= 0 and var_294_2 or var_294_2 * (utf8.len(var_294_3) / 4)

				if (4 <= 0 and var_294_2 or var_294_2 * (utf8.len(var_294_3) / 4)) > 0 and var_294_2 < var_294_5 then
					arg_291_1.talkMaxDuration = var_294_5

					if var_294_5 + var_294_1 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_5 + var_294_1
					end
				end

				arg_291_1.text_.text = var_294_3
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_6 = math.max(var_294_2, arg_291_1.talkMaxDuration)

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_6 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_1) / var_294_6

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_1 + var_294_6 and arg_291_1.time_ < var_294_1 + var_294_6 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play102801073 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 102801073
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play102801074(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0.4

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_1 = arg_295_1:FormatText(arg_295_1:GetWordFromCfg(102801073).content)

				arg_295_1.text_.text = var_298_1

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_3 = 13 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_1) / 13)

				if (13 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_1) / 13)) > 0 and var_298_0 < var_298_3 then
					arg_295_1.talkMaxDuration = var_298_3

					if var_298_3 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_3 + 0
					end
				end

				arg_295_1.text_.text = var_298_1
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_4 = math.max(var_298_0, arg_295_1.talkMaxDuration)

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_4 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - 0) / var_298_4

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= 0 + var_298_4 and arg_295_1.time_ < 0 + var_298_4 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play102801074 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 102801074
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play102801075(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0.55

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, true)
				arg_299_1.iconController_:SetSelectedState("hero")

				arg_299_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_299_1.callingController_:SetSelectedState("normal")

				arg_299_1.keyicon_.color = Color.New(1, 1, 1)
				arg_299_1.icon_.color = Color.New(1, 1, 1)

				local var_302_1 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(102801074).content)

				arg_299_1.text_.text = var_302_1

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_3 = 22 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 22)

				if (22 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 22)) > 0 and var_302_0 < var_302_3 then
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
	Play102801075 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 102801075
		arg_303_1.duration_ = 1.1

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play102801076(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(arg_303_1.actors_["1028ui_story"]) and arg_303_1.var_.characterEffect1028ui_story == nil then
				arg_303_1.var_.characterEffect1028ui_story = arg_303_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_0 = 0.034

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 and not isNil(arg_303_1.actors_["1028ui_story"]) then
				if arg_303_1.var_.characterEffect1028ui_story and not isNil(arg_303_1.actors_["1028ui_story"]) then
					arg_303_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 and not isNil(arg_303_1.actors_["1028ui_story"]) and arg_303_1.var_.characterEffect1028ui_story then
				arg_303_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_306_2 = 0
			local var_306_3 = 0.05

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_2 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_4 = arg_303_1:GetWordFromCfg(102801075)
				local var_306_5 = arg_303_1:FormatText(var_306_4.content)

				arg_303_1.text_.text = var_306_5

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_7 = 2 <= 0 and var_306_3 or var_306_3 * (utf8.len(var_306_5) / 2)

				if (2 <= 0 and var_306_3 or var_306_3 * (utf8.len(var_306_5) / 2)) > 0 and var_306_3 < var_306_7 then
					arg_303_1.talkMaxDuration = var_306_7

					if var_306_7 + var_306_2 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_7 + var_306_2
					end
				end

				arg_303_1.text_.text = var_306_5
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801075", "story_v_side_old_102801.awb") ~= 0 then
					local var_306_8 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801075", "story_v_side_old_102801.awb") / 1000

					if var_306_8 + var_306_2 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_8 + var_306_2
					end

					if var_306_4.prefab_name ~= "" and arg_303_1.actors_[var_306_4.prefab_name] ~= nil then
						local var_306_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_4.prefab_name].transform, "story_v_side_old_102801", "102801075", "story_v_side_old_102801.awb")

						arg_303_1:RecordAudio("102801075", var_306_9)
						arg_303_1:RecordAudio("102801075", var_306_9)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801075", "story_v_side_old_102801.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801075", "story_v_side_old_102801.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_10 = math.max(var_306_3, arg_303_1.talkMaxDuration)

			if var_306_2 <= arg_303_1.time_ and arg_303_1.time_ < var_306_2 + var_306_10 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_2) / var_306_10

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_2 + var_306_10 and arg_303_1.time_ < var_306_2 + var_306_10 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play102801076 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 102801076
		arg_307_1.duration_ = 5.73

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play102801077(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action7_1")
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_310_0 = 0
			local var_310_1 = 0.3

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_2 = arg_307_1:GetWordFromCfg(102801076)
				local var_310_3 = arg_307_1:FormatText(var_310_2.content)

				arg_307_1.text_.text = var_310_3

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_5 = 12 <= 0 and var_310_1 or var_310_1 * (utf8.len(var_310_3) / 12)

				if (12 <= 0 and var_310_1 or var_310_1 * (utf8.len(var_310_3) / 12)) > 0 and var_310_1 < var_310_5 then
					arg_307_1.talkMaxDuration = var_310_5

					if var_310_5 + var_310_0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_5 + var_310_0
					end
				end

				arg_307_1.text_.text = var_310_3
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801076", "story_v_side_old_102801.awb") ~= 0 then
					local var_310_6 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801076", "story_v_side_old_102801.awb") / 1000

					if var_310_6 + var_310_0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_6 + var_310_0
					end

					if var_310_2.prefab_name ~= "" and arg_307_1.actors_[var_310_2.prefab_name] ~= nil then
						local var_310_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_2.prefab_name].transform, "story_v_side_old_102801", "102801076", "story_v_side_old_102801.awb")

						arg_307_1:RecordAudio("102801076", var_310_7)
						arg_307_1:RecordAudio("102801076", var_310_7)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801076", "story_v_side_old_102801.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801076", "story_v_side_old_102801.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_8 = math.max(var_310_1, arg_307_1.talkMaxDuration)

			if var_310_0 <= arg_307_1.time_ and arg_307_1.time_ < var_310_0 + var_310_8 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_0) / var_310_8

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_0 + var_310_8 and arg_307_1.time_ < var_310_0 + var_310_8 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play102801077 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 102801077
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play102801078(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0.625

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

				local var_314_1 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(102801077).content)

				arg_311_1.text_.text = var_314_1

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_3 = 25 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 25)

				if (25 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 25)) > 0 and var_314_0 < var_314_3 then
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
	Play102801078 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 102801078
		arg_315_1.duration_ = 8.9

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play102801079(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action7_2")
			end

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_318_0 = 0
			local var_318_1 = 0.65

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_0 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_2 = arg_315_1:GetWordFromCfg(102801078)
				local var_318_3 = arg_315_1:FormatText(var_318_2.content)

				arg_315_1.text_.text = var_318_3

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_5 = 26 <= 0 and var_318_1 or var_318_1 * (utf8.len(var_318_3) / 26)

				if (26 <= 0 and var_318_1 or var_318_1 * (utf8.len(var_318_3) / 26)) > 0 and var_318_1 < var_318_5 then
					arg_315_1.talkMaxDuration = var_318_5

					if var_318_5 + var_318_0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_5 + var_318_0
					end
				end

				arg_315_1.text_.text = var_318_3
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801078", "story_v_side_old_102801.awb") ~= 0 then
					local var_318_6 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801078", "story_v_side_old_102801.awb") / 1000

					if var_318_6 + var_318_0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_6 + var_318_0
					end

					if var_318_2.prefab_name ~= "" and arg_315_1.actors_[var_318_2.prefab_name] ~= nil then
						local var_318_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_2.prefab_name].transform, "story_v_side_old_102801", "102801078", "story_v_side_old_102801.awb")

						arg_315_1:RecordAudio("102801078", var_318_7)
						arg_315_1:RecordAudio("102801078", var_318_7)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801078", "story_v_side_old_102801.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801078", "story_v_side_old_102801.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_8 = math.max(var_318_1, arg_315_1.talkMaxDuration)

			if var_318_0 <= arg_315_1.time_ and arg_315_1.time_ < var_318_0 + var_318_8 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_0) / var_318_8

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_0 + var_318_8 and arg_315_1.time_ < var_318_0 + var_318_8 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play102801079 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 102801079
		arg_319_1.duration_ = 5.8

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play102801080(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_322_0 = 0
			local var_322_1 = 0.65

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_0 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_2 = arg_319_1:GetWordFromCfg(102801079)
				local var_322_3 = arg_319_1:FormatText(var_322_2.content)

				arg_319_1.text_.text = var_322_3

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_5 = 26 <= 0 and var_322_1 or var_322_1 * (utf8.len(var_322_3) / 26)

				if (26 <= 0 and var_322_1 or var_322_1 * (utf8.len(var_322_3) / 26)) > 0 and var_322_1 < var_322_5 then
					arg_319_1.talkMaxDuration = var_322_5

					if var_322_5 + var_322_0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_5 + var_322_0
					end
				end

				arg_319_1.text_.text = var_322_3
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801079", "story_v_side_old_102801.awb") ~= 0 then
					local var_322_6 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801079", "story_v_side_old_102801.awb") / 1000

					if var_322_6 + var_322_0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_6 + var_322_0
					end

					if var_322_2.prefab_name ~= "" and arg_319_1.actors_[var_322_2.prefab_name] ~= nil then
						local var_322_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_2.prefab_name].transform, "story_v_side_old_102801", "102801079", "story_v_side_old_102801.awb")

						arg_319_1:RecordAudio("102801079", var_322_7)
						arg_319_1:RecordAudio("102801079", var_322_7)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801079", "story_v_side_old_102801.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801079", "story_v_side_old_102801.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_8 = math.max(var_322_1, arg_319_1.talkMaxDuration)

			if var_322_0 <= arg_319_1.time_ and arg_319_1.time_ < var_322_0 + var_322_8 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_0) / var_322_8

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_0 + var_322_8 and arg_319_1.time_ < var_322_0 + var_322_8 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play102801080 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 102801080
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play102801081(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = 0.325

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, true)
				arg_323_1.iconController_:SetSelectedState("hero")

				arg_323_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_323_1.callingController_:SetSelectedState("normal")

				arg_323_1.keyicon_.color = Color.New(1, 1, 1)
				arg_323_1.icon_.color = Color.New(1, 1, 1)

				local var_326_1 = arg_323_1:FormatText(arg_323_1:GetWordFromCfg(102801080).content)

				arg_323_1.text_.text = var_326_1

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_3 = 12 <= 0 and var_326_0 or var_326_0 * (utf8.len(var_326_1) / 12)

				if (12 <= 0 and var_326_0 or var_326_0 * (utf8.len(var_326_1) / 12)) > 0 and var_326_0 < var_326_3 then
					arg_323_1.talkMaxDuration = var_326_3

					if var_326_3 + 0 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_3 + 0
					end
				end

				arg_323_1.text_.text = var_326_1
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_4 = math.max(var_326_0, arg_323_1.talkMaxDuration)

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_4 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - 0) / var_326_4

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= 0 + var_326_4 and arg_323_1.time_ < 0 + var_326_4 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play102801081 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 102801081
		arg_327_1.duration_ = 11.13

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play102801082(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if arg_327_1.bgs_.H02 == nil then
				local var_330_0 = Object.Instantiate(arg_327_1.paintGo_)

				var_330_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H02")
				var_330_0.name = "H02"
				var_330_0.transform.parent = arg_327_1.stage_.transform
				var_330_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_327_1.bgs_.H02 = var_330_0
			end

			if 2 < arg_327_1.time_ and arg_327_1.time_ <= 2 + arg_330_0 then
				local var_330_1 = arg_327_1.bgs_.H02

				arg_327_1.bgs_.H02.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_330_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_330_2 = var_330_1:GetComponent("SpriteRenderer")

				if var_330_2 and var_330_2.sprite then
					local var_330_3 = 2 * (var_330_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_330_1.transform.localScale = Vector3.New(var_330_3 / var_330_2.sprite.bounds.size.y < var_330_3 * manager.ui.mainCameraCom_.aspect / var_330_2.sprite.bounds.size.x and var_330_3 * manager.ui.mainCameraCom_.aspect / var_330_2.sprite.bounds.size.x or var_330_3 / var_330_2.sprite.bounds.size.y, var_330_3 / var_330_2.sprite.bounds.size.y < var_330_3 * manager.ui.mainCameraCom_.aspect / var_330_2.sprite.bounds.size.x and var_330_3 * manager.ui.mainCameraCom_.aspect / var_330_2.sprite.bounds.size.x or var_330_3 / var_330_2.sprite.bounds.size.y, 0)
				end

				for iter_330_0, iter_330_1 in pairs(arg_327_1.bgs_) do
					if iter_330_0 ~= "H02" then
						iter_330_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_330_4 = 0

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_4 + arg_330_0 then
				arg_327_1.mask_.enabled = true
				arg_327_1.mask_.raycastTarget = true

				arg_327_1:SetGaussion(false)
			end

			local var_330_5 = 2

			if var_330_4 <= arg_327_1.time_ and arg_327_1.time_ < var_330_4 + var_330_5 then
				local var_330_6 = Color.New(0, 0, 0)

				var_330_6.a = Mathf.Lerp(0, 1, (arg_327_1.time_ - var_330_4) / var_330_5)
				arg_327_1.mask_.color = var_330_6
			end

			if arg_327_1.time_ >= var_330_4 + var_330_5 and arg_327_1.time_ < var_330_4 + var_330_5 + arg_330_0 then
				local var_330_7 = Color.New(0, 0, 0)

				var_330_7.a = 1
				arg_327_1.mask_.color = var_330_7
			end

			local var_330_8 = 2

			if 2 < arg_327_1.time_ and arg_327_1.time_ <= var_330_8 + arg_330_0 then
				arg_327_1.mask_.enabled = true
				arg_327_1.mask_.raycastTarget = true

				arg_327_1:SetGaussion(false)
			end

			local var_330_9 = 2

			if var_330_8 <= arg_327_1.time_ and arg_327_1.time_ < var_330_8 + var_330_9 then
				local var_330_10 = Color.New(0, 0, 0)

				var_330_10.a = Mathf.Lerp(1, 0, (arg_327_1.time_ - var_330_8) / var_330_9)
				arg_327_1.mask_.color = var_330_10
			end

			if arg_327_1.time_ >= var_330_8 + var_330_9 and arg_327_1.time_ < var_330_8 + var_330_9 + arg_330_0 then
				local var_330_11 = Color.New(0, 0, 0)

				arg_327_1.mask_.enabled = false
				var_330_11.a = 0
				arg_327_1.mask_.color = var_330_11
			end

			local var_330_12 = "1059ui_story"

			if arg_327_1.actors_["1059ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1059ui_story"))) then
				local var_330_13 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_327_1.stage_.transform)

				var_330_13.name = var_330_12
				var_330_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_327_1.actors_[var_330_12] = var_330_13

				local var_330_14 = var_330_13:GetComponentInChildren(typeof(CharacterEffect))

				var_330_14.enabled = true

				local var_330_15 = GameObjectTools.GetOrAddComponent(var_330_13, typeof(DynamicBoneHelper))

				if var_330_15 then
					var_330_15:EnableDynamicBone(false)
				end

				arg_327_1:ShowWeapon(var_330_14.transform, false)

				arg_327_1.var_[var_330_12 .. "Animator"] = var_330_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_327_1.var_[var_330_12 .. "Animator"].applyRootMotion = true
				arg_327_1.var_[var_330_12 .. "LipSync"] = var_330_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_330_16 = arg_327_1.actors_["1059ui_story"].transform

			if 3.98333333333333 < arg_327_1.time_ and arg_327_1.time_ <= 3.98333333333333 + arg_330_0 then
				arg_327_1.var_.moveOldPos1059ui_story = var_330_16.localPosition

				arg_327_1:ShowWeapon(arg_327_1.var_["1059ui_story" .. "Animator"].transform, false)
			end

			local var_330_17 = 0.001

			if 3.98333333333333 <= arg_327_1.time_ and arg_327_1.time_ < 3.98333333333333 + var_330_17 then
				var_330_16.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos1059ui_story, Vector3.New(0.7, -1.05, -6), (arg_327_1.time_ - 3.98333333333333) / var_330_17)
				var_330_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_330_16.position).x, (manager.ui.mainCamera.transform.position - var_330_16.position).y, (manager.ui.mainCamera.transform.position - var_330_16.position).z)
				var_330_16.localEulerAngles.z = 0
				var_330_16.localEulerAngles.x = 0
				var_330_16.localEulerAngles = var_330_16.localEulerAngles
			end

			if arg_327_1.time_ >= 3.98333333333333 + var_330_17 and arg_327_1.time_ < 3.98333333333333 + var_330_17 + arg_330_0 then
				var_330_16.localPosition = Vector3.New(0.7, -1.05, -6)
				var_330_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_330_16.position).x, (manager.ui.mainCamera.transform.position - var_330_16.position).y, (manager.ui.mainCamera.transform.position - var_330_16.position).z)
				var_330_16.localEulerAngles.z = 0
				var_330_16.localEulerAngles.x = 0
				var_330_16.localEulerAngles = var_330_16.localEulerAngles
			end

			local var_330_18 = arg_327_1.actors_["1028ui_story"].transform

			if 1.98333333333333 < arg_327_1.time_ and arg_327_1.time_ <= 1.98333333333333 + arg_330_0 then
				arg_327_1.var_.moveOldPos1028ui_story = var_330_18.localPosition

				arg_327_1:ShowWeapon(arg_327_1.var_["1028ui_story" .. "Animator"].transform, false)
			end

			local var_330_19 = 0.001

			if 1.98333333333333 <= arg_327_1.time_ and arg_327_1.time_ < 1.98333333333333 + var_330_19 then
				var_330_18.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos1028ui_story, Vector3.New(0, 100, 0), (arg_327_1.time_ - 1.98333333333333) / var_330_19)
				var_330_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_330_18.position).x, (manager.ui.mainCamera.transform.position - var_330_18.position).y, (manager.ui.mainCamera.transform.position - var_330_18.position).z)
				var_330_18.localEulerAngles.z = 0
				var_330_18.localEulerAngles.x = 0
				var_330_18.localEulerAngles = var_330_18.localEulerAngles
			end

			if arg_327_1.time_ >= 1.98333333333333 + var_330_19 and arg_327_1.time_ < 1.98333333333333 + var_330_19 + arg_330_0 then
				var_330_18.localPosition = Vector3.New(0, 100, 0)
				var_330_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_330_18.position).x, (manager.ui.mainCamera.transform.position - var_330_18.position).y, (manager.ui.mainCamera.transform.position - var_330_18.position).z)
				var_330_18.localEulerAngles.z = 0
				var_330_18.localEulerAngles.x = 0
				var_330_18.localEulerAngles = var_330_18.localEulerAngles
			end

			local var_330_20 = "1148ui_story"

			if arg_327_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_330_21 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_327_1.stage_.transform)

				var_330_21.name = var_330_20
				var_330_21.transform.localPosition = Vector3.New(0, 100, 0)
				arg_327_1.actors_[var_330_20] = var_330_21

				local var_330_22 = var_330_21:GetComponentInChildren(typeof(CharacterEffect))

				var_330_22.enabled = true

				local var_330_23 = GameObjectTools.GetOrAddComponent(var_330_21, typeof(DynamicBoneHelper))

				if var_330_23 then
					var_330_23:EnableDynamicBone(false)
				end

				arg_327_1:ShowWeapon(var_330_22.transform, false)

				arg_327_1.var_[var_330_20 .. "Animator"] = var_330_22.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_327_1.var_[var_330_20 .. "Animator"].applyRootMotion = true
				arg_327_1.var_[var_330_20 .. "LipSync"] = var_330_22.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_330_24 = arg_327_1.actors_["1148ui_story"].transform

			if 3.98333333333333 < arg_327_1.time_ and arg_327_1.time_ <= 3.98333333333333 + arg_330_0 then
				arg_327_1.var_.moveOldPos1148ui_story = var_330_24.localPosition

				arg_327_1:ShowWeapon(arg_327_1.var_["1148ui_story" .. "Animator"].transform, false)
			end

			local var_330_25 = 0.001

			if 3.98333333333333 <= arg_327_1.time_ and arg_327_1.time_ < 3.98333333333333 + var_330_25 then
				var_330_24.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos1148ui_story, Vector3.New(-0.7, -0.8, -6.2), (arg_327_1.time_ - 3.98333333333333) / var_330_25)
				var_330_24.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_330_24.position).x, (manager.ui.mainCamera.transform.position - var_330_24.position).y, (manager.ui.mainCamera.transform.position - var_330_24.position).z)
				var_330_24.localEulerAngles.z = 0
				var_330_24.localEulerAngles.x = 0
				var_330_24.localEulerAngles = var_330_24.localEulerAngles
			end

			if arg_327_1.time_ >= 3.98333333333333 + var_330_25 and arg_327_1.time_ < 3.98333333333333 + var_330_25 + arg_330_0 then
				var_330_24.localPosition = Vector3.New(-0.7, -0.8, -6.2)
				var_330_24.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_330_24.position).x, (manager.ui.mainCamera.transform.position - var_330_24.position).y, (manager.ui.mainCamera.transform.position - var_330_24.position).z)
				var_330_24.localEulerAngles.z = 0
				var_330_24.localEulerAngles.x = 0
				var_330_24.localEulerAngles = var_330_24.localEulerAngles
			end

			local var_330_26 = arg_327_1.actors_["1059ui_story"]

			if 3.98333333333333 < arg_327_1.time_ and arg_327_1.time_ <= 3.98333333333333 + arg_330_0 and not isNil(var_330_26) and arg_327_1.var_.characterEffect1059ui_story == nil then
				arg_327_1.var_.characterEffect1059ui_story = var_330_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_27 = 0.0166666666666666

			if 3.98333333333333 <= arg_327_1.time_ and arg_327_1.time_ < 3.98333333333333 + var_330_27 and not isNil(var_330_26) then
				if arg_327_1.var_.characterEffect1059ui_story and not isNil(var_330_26) then
					arg_327_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_327_1.time_ >= 3.98333333333333 + var_330_27 and arg_327_1.time_ < 3.98333333333333 + var_330_27 + arg_330_0 and not isNil(var_330_26) and arg_327_1.var_.characterEffect1059ui_story then
				arg_327_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_330_29 = arg_327_1.actors_["1148ui_story"]

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(var_330_29) and arg_327_1.var_.characterEffect1148ui_story == nil then
				arg_327_1.var_.characterEffect1148ui_story = var_330_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_30 = 0.0166666666666667

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_30 and not isNil(var_330_29) then
				if arg_327_1.var_.characterEffect1148ui_story and not isNil(var_330_29) then
					arg_327_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_327_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_327_1.time_ - 0) / var_330_30)
				end
			end

			if arg_327_1.time_ >= 0 + var_330_30 and arg_327_1.time_ < 0 + var_330_30 + arg_330_0 and not isNil(var_330_29) and arg_327_1.var_.characterEffect1148ui_story then
				arg_327_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_327_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 4 < arg_327_1.time_ and arg_327_1.time_ <= 4 + arg_330_0 then
				arg_327_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action5_1")
			end

			if 4 < arg_327_1.time_ and arg_327_1.time_ <= 4 + arg_330_0 then
				arg_327_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			if 4 < arg_327_1.time_ and arg_327_1.time_ <= 4 + arg_330_0 then
				arg_327_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action1_1")
			end

			if 4 < arg_327_1.time_ and arg_327_1.time_ <= 4 + arg_330_0 then
				arg_327_1:AudioAction("play", "effect", "se_story_activity_1_2_summer1", "se_story_activity_1_2_summer1_beachdayloop", "")
			end

			if arg_327_1.frameCnt_ <= 1 then
				arg_327_1.dialog_:SetActive(false)
			end

			local var_330_32 = 4
			local var_330_33 = 0.8

			if 4 < arg_327_1.time_ and arg_327_1.time_ <= var_330_32 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0

				arg_327_1.dialog_:SetActive(true)

				arg_327_1.dialogCg_.alpha = 0

				local var_330_34 = LeanTween.value(arg_327_1.dialog_, 0, 1, 0.3)

				var_330_34:setOnUpdate(LuaHelper.FloatAction(function(arg_331_0)
					arg_327_1.dialogCg_.alpha = arg_331_0
				end))
				var_330_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_327_1.dialog_)
					var_330_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_327_1.duration_ = arg_327_1.duration_ + 0.3

				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_35 = arg_327_1:GetWordFromCfg(102801081)
				local var_330_36 = arg_327_1:FormatText(var_330_35.content)

				arg_327_1.text_.text = var_330_36

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_38 = 24 <= 0 and var_330_33 or var_330_33 * (utf8.len(var_330_36) / 24)

				if (24 <= 0 and var_330_33 or var_330_33 * (utf8.len(var_330_36) / 24)) > 0 and var_330_33 < var_330_38 then
					arg_327_1.talkMaxDuration = var_330_38
					var_330_32 = var_330_32 + 0.3

					if var_330_38 + var_330_32 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_38 + var_330_32
					end
				end

				arg_327_1.text_.text = var_330_36
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801081", "story_v_side_old_102801.awb") ~= 0 then
					local var_330_39 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801081", "story_v_side_old_102801.awb") / 1000

					if var_330_39 + var_330_32 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_39 + var_330_32
					end

					if var_330_35.prefab_name ~= "" and arg_327_1.actors_[var_330_35.prefab_name] ~= nil then
						local var_330_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_35.prefab_name].transform, "story_v_side_old_102801", "102801081", "story_v_side_old_102801.awb")

						arg_327_1:RecordAudio("102801081", var_330_40)
						arg_327_1:RecordAudio("102801081", var_330_40)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801081", "story_v_side_old_102801.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801081", "story_v_side_old_102801.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_41 = var_330_32 + 0.3
			local var_330_42 = math.max(var_330_33, arg_327_1.talkMaxDuration)

			if var_330_32 + 0.3 <= arg_327_1.time_ and arg_327_1.time_ < var_330_41 + var_330_42 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_41) / var_330_42

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_41 + var_330_42 and arg_327_1.time_ < var_330_41 + var_330_42 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666665,
				className = "StoryMoveNode",
				startTime = 3.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666665,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666665,
				className = "StoryMoveNode",
				startTime = 3.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_327_1:InitPlayNodeList()
	end,
	Play102801082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 102801082
		arg_333_1.duration_ = 8.1

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play102801083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(arg_333_1.actors_["1148ui_story"]) and arg_333_1.var_.characterEffect1148ui_story == nil then
				arg_333_1.var_.characterEffect1148ui_story = arg_333_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_0 = 0.0166666666666667

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 and not isNil(arg_333_1.actors_["1148ui_story"]) then
				if arg_333_1.var_.characterEffect1148ui_story and not isNil(arg_333_1.actors_["1148ui_story"]) then
					arg_333_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 and not isNil(arg_333_1.actors_["1148ui_story"]) and arg_333_1.var_.characterEffect1148ui_story then
				arg_333_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_336_2 = arg_333_1.actors_["1059ui_story"]

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(var_336_2) and arg_333_1.var_.characterEffect1059ui_story == nil then
				arg_333_1.var_.characterEffect1059ui_story = var_336_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_3 = 0.0166666666666667

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_3 and not isNil(var_336_2) then
				if arg_333_1.var_.characterEffect1059ui_story and not isNil(var_336_2) then
					arg_333_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_333_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_333_1.time_ - 0) / var_336_3)
				end
			end

			if arg_333_1.time_ >= 0 + var_336_3 and arg_333_1.time_ < 0 + var_336_3 + arg_336_0 and not isNil(var_336_2) and arg_333_1.var_.characterEffect1059ui_story then
				arg_333_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_333_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action9_1")
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_336_4 = 0
			local var_336_5 = 0.775

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_4 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_6 = arg_333_1:GetWordFromCfg(102801082)
				local var_336_7 = arg_333_1:FormatText(var_336_6.content)

				arg_333_1.text_.text = var_336_7

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_9 = 31 <= 0 and var_336_5 or var_336_5 * (utf8.len(var_336_7) / 31)

				if (31 <= 0 and var_336_5 or var_336_5 * (utf8.len(var_336_7) / 31)) > 0 and var_336_5 < var_336_9 then
					arg_333_1.talkMaxDuration = var_336_9

					if var_336_9 + var_336_4 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_9 + var_336_4
					end
				end

				arg_333_1.text_.text = var_336_7
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801082", "story_v_side_old_102801.awb") ~= 0 then
					local var_336_10 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801082", "story_v_side_old_102801.awb") / 1000

					if var_336_10 + var_336_4 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_10 + var_336_4
					end

					if var_336_6.prefab_name ~= "" and arg_333_1.actors_[var_336_6.prefab_name] ~= nil then
						local var_336_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_6.prefab_name].transform, "story_v_side_old_102801", "102801082", "story_v_side_old_102801.awb")

						arg_333_1:RecordAudio("102801082", var_336_11)
						arg_333_1:RecordAudio("102801082", var_336_11)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801082", "story_v_side_old_102801.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801082", "story_v_side_old_102801.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_12 = math.max(var_336_5, arg_333_1.talkMaxDuration)

			if var_336_4 <= arg_333_1.time_ and arg_333_1.time_ < var_336_4 + var_336_12 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_4) / var_336_12

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_4 + var_336_12 and arg_333_1.time_ < var_336_4 + var_336_12 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play102801083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 102801083
		arg_337_1.duration_ = 3.9

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play102801084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(arg_337_1.actors_["1148ui_story"]) and arg_337_1.var_.characterEffect1148ui_story == nil then
				arg_337_1.var_.characterEffect1148ui_story = arg_337_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_0 = 0.1

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 and not isNil(arg_337_1.actors_["1148ui_story"]) then
				if arg_337_1.var_.characterEffect1148ui_story and not isNil(arg_337_1.actors_["1148ui_story"]) then
					arg_337_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_337_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_337_1.time_ - 0) / var_340_0)
				end
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 and not isNil(arg_337_1.actors_["1148ui_story"]) and arg_337_1.var_.characterEffect1148ui_story then
				arg_337_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_337_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_340_1 = 0
			local var_340_2 = 0.1

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[366].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fatherb")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_3 = arg_337_1:GetWordFromCfg(102801083)
				local var_340_4 = arg_337_1:FormatText(var_340_3.content)

				arg_337_1.text_.text = var_340_4

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_6 = 2 <= 0 and var_340_2 or var_340_2 * (utf8.len(var_340_4) / 2)

				if (2 <= 0 and var_340_2 or var_340_2 * (utf8.len(var_340_4) / 2)) > 0 and var_340_2 < var_340_6 then
					arg_337_1.talkMaxDuration = var_340_6

					if var_340_6 + var_340_1 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_6 + var_340_1
					end
				end

				arg_337_1.text_.text = var_340_4
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801083", "story_v_side_old_102801.awb") ~= 0 then
					local var_340_7 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801083", "story_v_side_old_102801.awb") / 1000

					if var_340_7 + var_340_1 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_7 + var_340_1
					end

					if var_340_3.prefab_name ~= "" and arg_337_1.actors_[var_340_3.prefab_name] ~= nil then
						local var_340_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_3.prefab_name].transform, "story_v_side_old_102801", "102801083", "story_v_side_old_102801.awb")

						arg_337_1:RecordAudio("102801083", var_340_8)
						arg_337_1:RecordAudio("102801083", var_340_8)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801083", "story_v_side_old_102801.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801083", "story_v_side_old_102801.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_9 = math.max(var_340_2, arg_337_1.talkMaxDuration)

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_9 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_1) / var_340_9

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_1 + var_340_9 and arg_337_1.time_ < var_340_1 + var_340_9 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play102801084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 102801084
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play102801085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action9_2")
			end

			local var_344_0 = 0
			local var_344_1 = 0.6

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

				local var_344_2 = arg_341_1:FormatText(arg_341_1:GetWordFromCfg(102801084).content)

				arg_341_1.text_.text = var_344_2

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_4 = 37 <= 0 and var_344_1 or var_344_1 * (utf8.len(var_344_2) / 37)

				if (37 <= 0 and var_344_1 or var_344_1 * (utf8.len(var_344_2) / 37)) > 0 and var_344_1 < var_344_4 then
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
	Play102801085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 102801085
		arg_345_1.duration_ = 5.93

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play102801086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = 0.4

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[362].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, true)
				arg_345_1.iconController_:SetSelectedState("hero")

				arg_345_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fatherb")

				arg_345_1.callingController_:SetSelectedState("normal")

				arg_345_1.keyicon_.color = Color.New(1, 1, 1)
				arg_345_1.icon_.color = Color.New(1, 1, 1)

				local var_348_1 = arg_345_1:GetWordFromCfg(102801085)
				local var_348_2 = arg_345_1:FormatText(var_348_1.content)

				arg_345_1.text_.text = var_348_2

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_4 = 16 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_2) / 16)

				if (16 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_2) / 16)) > 0 and var_348_0 < var_348_4 then
					arg_345_1.talkMaxDuration = var_348_4

					if var_348_4 + 0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_4 + 0
					end
				end

				arg_345_1.text_.text = var_348_2
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801085", "story_v_side_old_102801.awb") ~= 0 then
					local var_348_5 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801085", "story_v_side_old_102801.awb") / 1000

					if var_348_5 + 0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_5 + 0
					end

					if var_348_1.prefab_name ~= "" and arg_345_1.actors_[var_348_1.prefab_name] ~= nil then
						local var_348_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_1.prefab_name].transform, "story_v_side_old_102801", "102801085", "story_v_side_old_102801.awb")

						arg_345_1:RecordAudio("102801085", var_348_6)
						arg_345_1:RecordAudio("102801085", var_348_6)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801085", "story_v_side_old_102801.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801085", "story_v_side_old_102801.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_7 = math.max(var_348_0, arg_345_1.talkMaxDuration)

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_7 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - 0) / var_348_7

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= 0 + var_348_7 and arg_345_1.time_ < 0 + var_348_7 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play102801086 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 102801086
		arg_349_1.duration_ = 9.9

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play102801087(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(arg_349_1.actors_["1148ui_story"]) and arg_349_1.var_.characterEffect1148ui_story == nil then
				arg_349_1.var_.characterEffect1148ui_story = arg_349_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_0 = 0.1

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 and not isNil(arg_349_1.actors_["1148ui_story"]) then
				if arg_349_1.var_.characterEffect1148ui_story and not isNil(arg_349_1.actors_["1148ui_story"]) then
					arg_349_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 and not isNil(arg_349_1.actors_["1148ui_story"]) and arg_349_1.var_.characterEffect1148ui_story then
				arg_349_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_352_2 = 0
			local var_352_3 = 0.8

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_2 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_4 = arg_349_1:GetWordFromCfg(102801086)
				local var_352_5 = arg_349_1:FormatText(var_352_4.content)

				arg_349_1.text_.text = var_352_5

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_7 = 32 <= 0 and var_352_3 or var_352_3 * (utf8.len(var_352_5) / 32)

				if (32 <= 0 and var_352_3 or var_352_3 * (utf8.len(var_352_5) / 32)) > 0 and var_352_3 < var_352_7 then
					arg_349_1.talkMaxDuration = var_352_7

					if var_352_7 + var_352_2 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_7 + var_352_2
					end
				end

				arg_349_1.text_.text = var_352_5
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801086", "story_v_side_old_102801.awb") ~= 0 then
					local var_352_8 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801086", "story_v_side_old_102801.awb") / 1000

					if var_352_8 + var_352_2 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_8 + var_352_2
					end

					if var_352_4.prefab_name ~= "" and arg_349_1.actors_[var_352_4.prefab_name] ~= nil then
						local var_352_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_4.prefab_name].transform, "story_v_side_old_102801", "102801086", "story_v_side_old_102801.awb")

						arg_349_1:RecordAudio("102801086", var_352_9)
						arg_349_1:RecordAudio("102801086", var_352_9)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801086", "story_v_side_old_102801.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801086", "story_v_side_old_102801.awb")
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
	Play102801087 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 102801087
		arg_353_1.duration_ = 7.4

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play102801088(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(arg_353_1.actors_["1148ui_story"]) and arg_353_1.var_.characterEffect1148ui_story == nil then
				arg_353_1.var_.characterEffect1148ui_story = arg_353_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_0 = 0.1

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 and not isNil(arg_353_1.actors_["1148ui_story"]) then
				if arg_353_1.var_.characterEffect1148ui_story and not isNil(arg_353_1.actors_["1148ui_story"]) then
					arg_353_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_353_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_353_1.time_ - 0) / var_356_0)
				end
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 and not isNil(arg_353_1.actors_["1148ui_story"]) and arg_353_1.var_.characterEffect1148ui_story then
				arg_353_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_353_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_356_1 = 0
			local var_356_2 = 0.6

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[366].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, true)
				arg_353_1.iconController_:SetSelectedState("hero")

				arg_353_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fatherb")

				arg_353_1.callingController_:SetSelectedState("normal")

				arg_353_1.keyicon_.color = Color.New(1, 1, 1)
				arg_353_1.icon_.color = Color.New(1, 1, 1)

				local var_356_3 = arg_353_1:GetWordFromCfg(102801087)
				local var_356_4 = arg_353_1:FormatText(var_356_3.content)

				arg_353_1.text_.text = var_356_4

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_6 = 24 <= 0 and var_356_2 or var_356_2 * (utf8.len(var_356_4) / 24)

				if (24 <= 0 and var_356_2 or var_356_2 * (utf8.len(var_356_4) / 24)) > 0 and var_356_2 < var_356_6 then
					arg_353_1.talkMaxDuration = var_356_6

					if var_356_6 + var_356_1 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_6 + var_356_1
					end
				end

				arg_353_1.text_.text = var_356_4
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801087", "story_v_side_old_102801.awb") ~= 0 then
					local var_356_7 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801087", "story_v_side_old_102801.awb") / 1000

					if var_356_7 + var_356_1 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_7 + var_356_1
					end

					if var_356_3.prefab_name ~= "" and arg_353_1.actors_[var_356_3.prefab_name] ~= nil then
						local var_356_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_3.prefab_name].transform, "story_v_side_old_102801", "102801087", "story_v_side_old_102801.awb")

						arg_353_1:RecordAudio("102801087", var_356_8)
						arg_353_1:RecordAudio("102801087", var_356_8)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801087", "story_v_side_old_102801.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801087", "story_v_side_old_102801.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_9 = math.max(var_356_2, arg_353_1.talkMaxDuration)

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_9 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_1) / var_356_9

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_1 + var_356_9 and arg_353_1.time_ < var_356_1 + var_356_9 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play102801088 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 102801088
		arg_357_1.duration_ = 3.9

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play102801089(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(arg_357_1.actors_["1059ui_story"]) and arg_357_1.var_.characterEffect1059ui_story == nil then
				arg_357_1.var_.characterEffect1059ui_story = arg_357_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_0 = 0.1

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 and not isNil(arg_357_1.actors_["1059ui_story"]) then
				if arg_357_1.var_.characterEffect1059ui_story and not isNil(arg_357_1.actors_["1059ui_story"]) then
					arg_357_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 and not isNil(arg_357_1.actors_["1059ui_story"]) and arg_357_1.var_.characterEffect1059ui_story then
				arg_357_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action5_2")
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_360_2 = 0
			local var_360_3 = 0.55

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_2 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_4 = arg_357_1:GetWordFromCfg(102801088)
				local var_360_5 = arg_357_1:FormatText(var_360_4.content)

				arg_357_1.text_.text = var_360_5

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_7 = 21 <= 0 and var_360_3 or var_360_3 * (utf8.len(var_360_5) / 21)

				if (21 <= 0 and var_360_3 or var_360_3 * (utf8.len(var_360_5) / 21)) > 0 and var_360_3 < var_360_7 then
					arg_357_1.talkMaxDuration = var_360_7

					if var_360_7 + var_360_2 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_7 + var_360_2
					end
				end

				arg_357_1.text_.text = var_360_5
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801088", "story_v_side_old_102801.awb") ~= 0 then
					local var_360_8 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801088", "story_v_side_old_102801.awb") / 1000

					if var_360_8 + var_360_2 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_8 + var_360_2
					end

					if var_360_4.prefab_name ~= "" and arg_357_1.actors_[var_360_4.prefab_name] ~= nil then
						local var_360_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_4.prefab_name].transform, "story_v_side_old_102801", "102801088", "story_v_side_old_102801.awb")

						arg_357_1:RecordAudio("102801088", var_360_9)
						arg_357_1:RecordAudio("102801088", var_360_9)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801088", "story_v_side_old_102801.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801088", "story_v_side_old_102801.awb")
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
	Play102801089 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 102801089
		arg_361_1.duration_ = 8.63

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play102801090(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(arg_361_1.actors_["1059ui_story"]) and arg_361_1.var_.characterEffect1059ui_story == nil then
				arg_361_1.var_.characterEffect1059ui_story = arg_361_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_0 = 0.1

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 and not isNil(arg_361_1.actors_["1059ui_story"]) then
				if arg_361_1.var_.characterEffect1059ui_story and not isNil(arg_361_1.actors_["1059ui_story"]) then
					arg_361_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_361_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_361_1.time_ - 0) / var_364_0)
				end
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 and not isNil(arg_361_1.actors_["1059ui_story"]) and arg_361_1.var_.characterEffect1059ui_story then
				arg_361_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_361_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_364_1 = 0
			local var_364_2 = 1.05

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[366].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, true)
				arg_361_1.iconController_:SetSelectedState("hero")

				arg_361_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fatherb")

				arg_361_1.callingController_:SetSelectedState("normal")

				arg_361_1.keyicon_.color = Color.New(1, 1, 1)
				arg_361_1.icon_.color = Color.New(1, 1, 1)

				local var_364_3 = arg_361_1:GetWordFromCfg(102801089)
				local var_364_4 = arg_361_1:FormatText(var_364_3.content)

				arg_361_1.text_.text = var_364_4

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_6 = 42 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_4) / 42)

				if (42 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_4) / 42)) > 0 and var_364_2 < var_364_6 then
					arg_361_1.talkMaxDuration = var_364_6

					if var_364_6 + var_364_1 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_6 + var_364_1
					end
				end

				arg_361_1.text_.text = var_364_4
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801089", "story_v_side_old_102801.awb") ~= 0 then
					local var_364_7 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801089", "story_v_side_old_102801.awb") / 1000

					if var_364_7 + var_364_1 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_7 + var_364_1
					end

					if var_364_3.prefab_name ~= "" and arg_361_1.actors_[var_364_3.prefab_name] ~= nil then
						local var_364_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_3.prefab_name].transform, "story_v_side_old_102801", "102801089", "story_v_side_old_102801.awb")

						arg_361_1:RecordAudio("102801089", var_364_8)
						arg_361_1:RecordAudio("102801089", var_364_8)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801089", "story_v_side_old_102801.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801089", "story_v_side_old_102801.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_9 = math.max(var_364_2, arg_361_1.talkMaxDuration)

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_9 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_1) / var_364_9

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_1 + var_364_9 and arg_361_1.time_ < var_364_1 + var_364_9 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play102801090 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 102801090
		arg_365_1.duration_ = 7.2

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play102801091(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(arg_365_1.actors_["1148ui_story"]) and arg_365_1.var_.characterEffect1148ui_story == nil then
				arg_365_1.var_.characterEffect1148ui_story = arg_365_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_0 = 0.1

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_0 and not isNil(arg_365_1.actors_["1148ui_story"]) then
				if arg_365_1.var_.characterEffect1148ui_story and not isNil(arg_365_1.actors_["1148ui_story"]) then
					arg_365_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_365_1.time_ >= 0 + var_368_0 and arg_365_1.time_ < 0 + var_368_0 + arg_368_0 and not isNil(arg_365_1.actors_["1148ui_story"]) and arg_365_1.var_.characterEffect1148ui_story then
				arg_365_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_2")
			end

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_368_2 = 0
			local var_368_3 = 0.525

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_2 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_4 = arg_365_1:GetWordFromCfg(102801090)
				local var_368_5 = arg_365_1:FormatText(var_368_4.content)

				arg_365_1.text_.text = var_368_5

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_7 = 21 <= 0 and var_368_3 or var_368_3 * (utf8.len(var_368_5) / 21)

				if (21 <= 0 and var_368_3 or var_368_3 * (utf8.len(var_368_5) / 21)) > 0 and var_368_3 < var_368_7 then
					arg_365_1.talkMaxDuration = var_368_7

					if var_368_7 + var_368_2 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_7 + var_368_2
					end
				end

				arg_365_1.text_.text = var_368_5
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801090", "story_v_side_old_102801.awb") ~= 0 then
					local var_368_8 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801090", "story_v_side_old_102801.awb") / 1000

					if var_368_8 + var_368_2 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_8 + var_368_2
					end

					if var_368_4.prefab_name ~= "" and arg_365_1.actors_[var_368_4.prefab_name] ~= nil then
						local var_368_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_4.prefab_name].transform, "story_v_side_old_102801", "102801090", "story_v_side_old_102801.awb")

						arg_365_1:RecordAudio("102801090", var_368_9)
						arg_365_1:RecordAudio("102801090", var_368_9)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801090", "story_v_side_old_102801.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801090", "story_v_side_old_102801.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_10 = math.max(var_368_3, arg_365_1.talkMaxDuration)

			if var_368_2 <= arg_365_1.time_ and arg_365_1.time_ < var_368_2 + var_368_10 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_2) / var_368_10

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_2 + var_368_10 and arg_365_1.time_ < var_368_2 + var_368_10 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play102801091 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 102801091
		arg_369_1.duration_ = 6.7

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play102801092(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(arg_369_1.actors_["1148ui_story"]) and arg_369_1.var_.characterEffect1148ui_story == nil then
				arg_369_1.var_.characterEffect1148ui_story = arg_369_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_0 = 0.1

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 and not isNil(arg_369_1.actors_["1148ui_story"]) then
				if arg_369_1.var_.characterEffect1148ui_story and not isNil(arg_369_1.actors_["1148ui_story"]) then
					arg_369_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_369_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_369_1.time_ - 0) / var_372_0)
				end
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 and not isNil(arg_369_1.actors_["1148ui_story"]) and arg_369_1.var_.characterEffect1148ui_story then
				arg_369_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_369_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_372_1 = 0
			local var_372_2 = 0.375

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[362].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, true)
				arg_369_1.iconController_:SetSelectedState("hero")

				arg_369_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fatherb")

				arg_369_1.callingController_:SetSelectedState("normal")

				arg_369_1.keyicon_.color = Color.New(1, 1, 1)
				arg_369_1.icon_.color = Color.New(1, 1, 1)

				local var_372_3 = arg_369_1:GetWordFromCfg(102801091)
				local var_372_4 = arg_369_1:FormatText(var_372_3.content)

				arg_369_1.text_.text = var_372_4

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_6 = 15 <= 0 and var_372_2 or var_372_2 * (utf8.len(var_372_4) / 15)

				if (15 <= 0 and var_372_2 or var_372_2 * (utf8.len(var_372_4) / 15)) > 0 and var_372_2 < var_372_6 then
					arg_369_1.talkMaxDuration = var_372_6

					if var_372_6 + var_372_1 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_6 + var_372_1
					end
				end

				arg_369_1.text_.text = var_372_4
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801091", "story_v_side_old_102801.awb") ~= 0 then
					local var_372_7 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801091", "story_v_side_old_102801.awb") / 1000

					if var_372_7 + var_372_1 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_7 + var_372_1
					end

					if var_372_3.prefab_name ~= "" and arg_369_1.actors_[var_372_3.prefab_name] ~= nil then
						local var_372_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_3.prefab_name].transform, "story_v_side_old_102801", "102801091", "story_v_side_old_102801.awb")

						arg_369_1:RecordAudio("102801091", var_372_8)
						arg_369_1:RecordAudio("102801091", var_372_8)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801091", "story_v_side_old_102801.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801091", "story_v_side_old_102801.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_9 = math.max(var_372_2, arg_369_1.talkMaxDuration)

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_9 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_1) / var_372_9

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_1 + var_372_9 and arg_369_1.time_ < var_372_1 + var_372_9 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play102801092 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 102801092
		arg_373_1.duration_ = 9.6

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play102801093(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = 0.925

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[366].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, true)
				arg_373_1.iconController_:SetSelectedState("hero")

				arg_373_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fatherb")

				arg_373_1.callingController_:SetSelectedState("normal")

				arg_373_1.keyicon_.color = Color.New(1, 1, 1)
				arg_373_1.icon_.color = Color.New(1, 1, 1)

				local var_376_1 = arg_373_1:GetWordFromCfg(102801092)
				local var_376_2 = arg_373_1:FormatText(var_376_1.content)

				arg_373_1.text_.text = var_376_2

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_4 = 36 <= 0 and var_376_0 or var_376_0 * (utf8.len(var_376_2) / 36)

				if (36 <= 0 and var_376_0 or var_376_0 * (utf8.len(var_376_2) / 36)) > 0 and var_376_0 < var_376_4 then
					arg_373_1.talkMaxDuration = var_376_4

					if var_376_4 + 0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_4 + 0
					end
				end

				arg_373_1.text_.text = var_376_2
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801092", "story_v_side_old_102801.awb") ~= 0 then
					local var_376_5 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801092", "story_v_side_old_102801.awb") / 1000

					if var_376_5 + 0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_5 + 0
					end

					if var_376_1.prefab_name ~= "" and arg_373_1.actors_[var_376_1.prefab_name] ~= nil then
						local var_376_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_1.prefab_name].transform, "story_v_side_old_102801", "102801092", "story_v_side_old_102801.awb")

						arg_373_1:RecordAudio("102801092", var_376_6)
						arg_373_1:RecordAudio("102801092", var_376_6)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801092", "story_v_side_old_102801.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801092", "story_v_side_old_102801.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_7 = math.max(var_376_0, arg_373_1.talkMaxDuration)

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_7 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - 0) / var_376_7

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= 0 + var_376_7 and arg_373_1.time_ < 0 + var_376_7 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play102801093 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 102801093
		arg_377_1.duration_ = 11.37

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play102801094(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 0.55

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[366].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, true)
				arg_377_1.iconController_:SetSelectedState("hero")

				arg_377_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fatherb")

				arg_377_1.callingController_:SetSelectedState("normal")

				arg_377_1.keyicon_.color = Color.New(1, 1, 1)
				arg_377_1.icon_.color = Color.New(1, 1, 1)

				local var_380_1 = arg_377_1:GetWordFromCfg(102801093)
				local var_380_2 = arg_377_1:FormatText(var_380_1.content)

				arg_377_1.text_.text = var_380_2

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_4 = 22 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_2) / 22)

				if (22 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_2) / 22)) > 0 and var_380_0 < var_380_4 then
					arg_377_1.talkMaxDuration = var_380_4

					if var_380_4 + 0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_4 + 0
					end
				end

				arg_377_1.text_.text = var_380_2
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801093", "story_v_side_old_102801.awb") ~= 0 then
					local var_380_5 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801093", "story_v_side_old_102801.awb") / 1000

					if var_380_5 + 0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_5 + 0
					end

					if var_380_1.prefab_name ~= "" and arg_377_1.actors_[var_380_1.prefab_name] ~= nil then
						local var_380_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_1.prefab_name].transform, "story_v_side_old_102801", "102801093", "story_v_side_old_102801.awb")

						arg_377_1:RecordAudio("102801093", var_380_6)
						arg_377_1:RecordAudio("102801093", var_380_6)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801093", "story_v_side_old_102801.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801093", "story_v_side_old_102801.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_7 = math.max(var_380_0, arg_377_1.talkMaxDuration)

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_7 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - 0) / var_380_7

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= 0 + var_380_7 and arg_377_1.time_ < 0 + var_380_7 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play102801094 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 102801094
		arg_381_1.duration_ = 7.5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play102801095(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(arg_381_1.actors_["1059ui_story"]) and arg_381_1.var_.characterEffect1059ui_story == nil then
				arg_381_1.var_.characterEffect1059ui_story = arg_381_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_0 = 0.1

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_0 and not isNil(arg_381_1.actors_["1059ui_story"]) then
				if arg_381_1.var_.characterEffect1059ui_story and not isNil(arg_381_1.actors_["1059ui_story"]) then
					arg_381_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_381_1.time_ >= 0 + var_384_0 and arg_381_1.time_ < 0 + var_384_0 + arg_384_0 and not isNil(arg_381_1.actors_["1059ui_story"]) and arg_381_1.var_.characterEffect1059ui_story then
				arg_381_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action2_1")
			end

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_384_2 = 0
			local var_384_3 = 0.6

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_2 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_4 = arg_381_1:GetWordFromCfg(102801094)
				local var_384_5 = arg_381_1:FormatText(var_384_4.content)

				arg_381_1.text_.text = var_384_5

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_7 = 34 <= 0 and var_384_3 or var_384_3 * (utf8.len(var_384_5) / 34)

				if (34 <= 0 and var_384_3 or var_384_3 * (utf8.len(var_384_5) / 34)) > 0 and var_384_3 < var_384_7 then
					arg_381_1.talkMaxDuration = var_384_7

					if var_384_7 + var_384_2 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_7 + var_384_2
					end
				end

				arg_381_1.text_.text = var_384_5
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801094", "story_v_side_old_102801.awb") ~= 0 then
					local var_384_8 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801094", "story_v_side_old_102801.awb") / 1000

					if var_384_8 + var_384_2 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_8 + var_384_2
					end

					if var_384_4.prefab_name ~= "" and arg_381_1.actors_[var_384_4.prefab_name] ~= nil then
						local var_384_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_4.prefab_name].transform, "story_v_side_old_102801", "102801094", "story_v_side_old_102801.awb")

						arg_381_1:RecordAudio("102801094", var_384_9)
						arg_381_1:RecordAudio("102801094", var_384_9)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801094", "story_v_side_old_102801.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801094", "story_v_side_old_102801.awb")
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
	Play102801095 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 102801095
		arg_385_1.duration_ = 5.27

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play102801096(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(arg_385_1.actors_["1148ui_story"]) and arg_385_1.var_.characterEffect1148ui_story == nil then
				arg_385_1.var_.characterEffect1148ui_story = arg_385_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_0 = 0.1

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_0 and not isNil(arg_385_1.actors_["1148ui_story"]) then
				if arg_385_1.var_.characterEffect1148ui_story and not isNil(arg_385_1.actors_["1148ui_story"]) then
					arg_385_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_385_1.time_ >= 0 + var_388_0 and arg_385_1.time_ < 0 + var_388_0 + arg_388_0 and not isNil(arg_385_1.actors_["1148ui_story"]) and arg_385_1.var_.characterEffect1148ui_story then
				arg_385_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_388_2 = arg_385_1.actors_["1059ui_story"]

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(var_388_2) and arg_385_1.var_.characterEffect1059ui_story == nil then
				arg_385_1.var_.characterEffect1059ui_story = var_388_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_3 = 0.1

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_3 and not isNil(var_388_2) then
				if arg_385_1.var_.characterEffect1059ui_story and not isNil(var_388_2) then
					arg_385_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_385_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_385_1.time_ - 0) / var_388_3)
				end
			end

			if arg_385_1.time_ >= 0 + var_388_3 and arg_385_1.time_ < 0 + var_388_3 + arg_388_0 and not isNil(var_388_2) and arg_385_1.var_.characterEffect1059ui_story then
				arg_385_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_385_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action2_1")
			end

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action2_2")
			end

			local var_388_4 = 0
			local var_388_5 = 0.5

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_4 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_6 = arg_385_1:GetWordFromCfg(102801095)
				local var_388_7 = arg_385_1:FormatText(var_388_6.content)

				arg_385_1.text_.text = var_388_7

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_9 = 13 <= 0 and var_388_5 or var_388_5 * (utf8.len(var_388_7) / 13)

				if (13 <= 0 and var_388_5 or var_388_5 * (utf8.len(var_388_7) / 13)) > 0 and var_388_5 < var_388_9 then
					arg_385_1.talkMaxDuration = var_388_9

					if var_388_9 + var_388_4 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_9 + var_388_4
					end
				end

				arg_385_1.text_.text = var_388_7
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801095", "story_v_side_old_102801.awb") ~= 0 then
					local var_388_10 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801095", "story_v_side_old_102801.awb") / 1000

					if var_388_10 + var_388_4 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_10 + var_388_4
					end

					if var_388_6.prefab_name ~= "" and arg_385_1.actors_[var_388_6.prefab_name] ~= nil then
						local var_388_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_6.prefab_name].transform, "story_v_side_old_102801", "102801095", "story_v_side_old_102801.awb")

						arg_385_1:RecordAudio("102801095", var_388_11)
						arg_385_1:RecordAudio("102801095", var_388_11)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801095", "story_v_side_old_102801.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801095", "story_v_side_old_102801.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_12 = math.max(var_388_5, arg_385_1.talkMaxDuration)

			if var_388_4 <= arg_385_1.time_ and arg_385_1.time_ < var_388_4 + var_388_12 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_4) / var_388_12

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_4 + var_388_12 and arg_385_1.time_ < var_388_4 + var_388_12 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play102801096 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 102801096
		arg_389_1.duration_ = 3.43

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
			arg_389_1.auto_ = false
		end

		function arg_389_1.playNext_(arg_391_0)
			arg_389_1.onStoryFinished_()
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(arg_389_1.actors_["1059ui_story"]) and arg_389_1.var_.characterEffect1059ui_story == nil then
				arg_389_1.var_.characterEffect1059ui_story = arg_389_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_0 = 0.1

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 and not isNil(arg_389_1.actors_["1059ui_story"]) then
				if arg_389_1.var_.characterEffect1059ui_story and not isNil(arg_389_1.actors_["1059ui_story"]) then
					arg_389_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 and not isNil(arg_389_1.actors_["1059ui_story"]) and arg_389_1.var_.characterEffect1059ui_story then
				arg_389_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action4_1")
			end

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_392_2 = 0
			local var_392_3 = 0.725

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_2 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_4 = arg_389_1:GetWordFromCfg(102801096)
				local var_392_5 = arg_389_1:FormatText(var_392_4.content)

				arg_389_1.text_.text = var_392_5

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_7 = 28 <= 0 and var_392_3 or var_392_3 * (utf8.len(var_392_5) / 28)

				if (28 <= 0 and var_392_3 or var_392_3 * (utf8.len(var_392_5) / 28)) > 0 and var_392_3 < var_392_7 then
					arg_389_1.talkMaxDuration = var_392_7

					if var_392_7 + var_392_2 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_7 + var_392_2
					end
				end

				arg_389_1.text_.text = var_392_5
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102801", "102801096", "story_v_side_old_102801.awb") ~= 0 then
					local var_392_8 = manager.audio:GetVoiceLength("story_v_side_old_102801", "102801096", "story_v_side_old_102801.awb") / 1000

					if var_392_8 + var_392_2 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_8 + var_392_2
					end

					if var_392_4.prefab_name ~= "" and arg_389_1.actors_[var_392_4.prefab_name] ~= nil then
						local var_392_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_4.prefab_name].transform, "story_v_side_old_102801", "102801096", "story_v_side_old_102801.awb")

						arg_389_1:RecordAudio("102801096", var_392_9)
						arg_389_1:RecordAudio("102801096", var_392_9)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_side_old_102801", "102801096", "story_v_side_old_102801.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_side_old_102801", "102801096", "story_v_side_old_102801.awb")
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
	assets = {
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/B13",
		"TextureConfig/Background/H02"
	},
	voices = {
		"story_v_side_old_102801.awb"
	}
}
