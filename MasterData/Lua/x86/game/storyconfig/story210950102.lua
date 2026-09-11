return {
	Play1109502001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1109502001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1109502002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST04b == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST04b")
				var_4_0.name = "ST04b"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST04b = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST04b

				arg_1_1.bgs_.ST04b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST04b" then
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

			if 0.833333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.833333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily01", "bgm_side_daily01", "bgm_side_daily01.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_side_daily01", "bgm_side_daily01")

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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1109502001).content)

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
	Play1109502002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1109502002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1109502003(arg_9_1)
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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(1109502002).content)

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
	Play1109502003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1109502003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1109502004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.9

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(1109502003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 36 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 36)

				if (36 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 36)) > 0 and var_16_0 < var_16_3 then
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
	Play1109502004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1109502004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1109502005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.825

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

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(1109502004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 33 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 33)

				if (33 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 33)) > 0 and var_20_0 < var_20_3 then
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
	Play1109502005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1109502005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1109502006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.25

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

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(1109502005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 10 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 10)

				if (10 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 10)) > 0 and var_24_0 < var_24_3 then
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
	Play1109502006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1109502006
		arg_25_1.duration_ = 7.93

		local var_25_0 = {
			zh = 6.3,
			ja = 7.933
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
				arg_25_0:Play1109502007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if arg_25_1.actors_["10058ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10058ui_story"))) then
				local var_28_0 = Object.Instantiate(Asset.Load("Char/" .. "10058ui_story"), arg_25_1.stage_.transform)

				var_28_0.name = "10058ui_story"
				var_28_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["10058ui_story"] = var_28_0

				local var_28_1 = var_28_0:GetComponentInChildren(typeof(CharacterEffect))

				var_28_1.enabled = true

				local var_28_2 = GameObjectTools.GetOrAddComponent(var_28_0, typeof(DynamicBoneHelper))

				if var_28_2 then
					var_28_2:EnableDynamicBone(false)
				end

				arg_25_1:ShowWeapon(var_28_1.transform, false)

				arg_25_1.var_["10058ui_story" .. "Animator"] = var_28_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_25_1.var_["10058ui_story" .. "Animator"].applyRootMotion = true
				arg_25_1.var_["10058ui_story" .. "LipSync"] = var_28_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_28_3 = arg_25_1.actors_["10058ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10058ui_story = var_28_3.localPosition
			end

			local var_28_4 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				var_28_3.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_25_1.time_ - 0) / var_28_4)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				var_28_3.localPosition = Vector3.New(0, -0.98, -6.1)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			local var_28_5 = arg_25_1.actors_["10058ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect10058ui_story == nil then
				arg_25_1.var_.characterEffect10058ui_story = var_28_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_6 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_6 and not isNil(var_28_5) then
				if arg_25_1.var_.characterEffect10058ui_story and not isNil(var_28_5) then
					arg_25_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_6 and arg_25_1.time_ < 0 + var_28_6 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect10058ui_story then
				arg_25_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_28_8 = 0
			local var_28_9 = 0.725

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_10 = arg_25_1:GetWordFromCfg(1109502006)
				local var_28_11 = arg_25_1:FormatText(var_28_10.content)

				arg_25_1.text_.text = var_28_11

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_13 = 29 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 29)

				if (29 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 29)) > 0 and var_28_9 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_8
					end
				end

				arg_25_1.text_.text = var_28_11
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502006", "story_v_side_new_1109502.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502006", "story_v_side_new_1109502.awb") / 1000

					if var_28_14 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_8
					end

					if var_28_10.prefab_name ~= "" and arg_25_1.actors_[var_28_10.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_10.prefab_name].transform, "story_v_side_new_1109502", "1109502006", "story_v_side_new_1109502.awb")

						arg_25_1:RecordAudio("1109502006", var_28_15)
						arg_25_1:RecordAudio("1109502006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502006", "story_v_side_new_1109502.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502006", "story_v_side_new_1109502.awb")
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
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play1109502007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1109502007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1109502008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["10058ui_story"]) and arg_29_1.var_.characterEffect10058ui_story == nil then
				arg_29_1.var_.characterEffect10058ui_story = arg_29_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["10058ui_story"]) then
				if arg_29_1.var_.characterEffect10058ui_story and not isNil(arg_29_1.actors_["10058ui_story"]) then
					arg_29_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_29_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_0)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["10058ui_story"]) and arg_29_1.var_.characterEffect10058ui_story then
				arg_29_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_29_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_32_1 = 0
			local var_32_2 = 0.425

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(1109502007).content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 17 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 17)

				if (17 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 17)) > 0 and var_32_2 < var_32_5 then
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
	Play1109502008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1109502008
		arg_33_1.duration_ = 4.73

		local var_33_0 = {
			zh = 4.7,
			ja = 4.733
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
				arg_33_0:Play1109502009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["10058ui_story"]) and arg_33_1.var_.characterEffect10058ui_story == nil then
				arg_33_1.var_.characterEffect10058ui_story = arg_33_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["10058ui_story"]) then
				if arg_33_1.var_.characterEffect10058ui_story and not isNil(arg_33_1.actors_["10058ui_story"]) then
					arg_33_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["10058ui_story"]) and arg_33_1.var_.characterEffect10058ui_story then
				arg_33_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_36_2 = 0
			local var_36_3 = 0.45

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_4 = arg_33_1:GetWordFromCfg(1109502008)
				local var_36_5 = arg_33_1:FormatText(var_36_4.content)

				arg_33_1.text_.text = var_36_5

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_7 = 18 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 18)

				if (18 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 18)) > 0 and var_36_3 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_2
					end
				end

				arg_33_1.text_.text = var_36_5
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502008", "story_v_side_new_1109502.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502008", "story_v_side_new_1109502.awb") / 1000

					if var_36_8 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_2
					end

					if var_36_4.prefab_name ~= "" and arg_33_1.actors_[var_36_4.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_4.prefab_name].transform, "story_v_side_new_1109502", "1109502008", "story_v_side_new_1109502.awb")

						arg_33_1:RecordAudio("1109502008", var_36_9)
						arg_33_1:RecordAudio("1109502008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502008", "story_v_side_new_1109502.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502008", "story_v_side_new_1109502.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_10 = math.max(var_36_3, arg_33_1.talkMaxDuration)

			if var_36_2 <= arg_33_1.time_ and arg_33_1.time_ < var_36_2 + var_36_10 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_2) / var_36_10

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_2 + var_36_10 and arg_33_1.time_ < var_36_2 + var_36_10 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play1109502009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1109502009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1109502010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["10058ui_story"]) and arg_37_1.var_.characterEffect10058ui_story == nil then
				arg_37_1.var_.characterEffect10058ui_story = arg_37_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["10058ui_story"]) then
				if arg_37_1.var_.characterEffect10058ui_story and not isNil(arg_37_1.actors_["10058ui_story"]) then
					arg_37_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_37_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["10058ui_story"]) and arg_37_1.var_.characterEffect10058ui_story then
				arg_37_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_37_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_40_1 = 0
			local var_40_2 = 0.6

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_3 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(1109502009).content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 24 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 24)

				if (24 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 24)) > 0 and var_40_2 < var_40_5 then
					arg_37_1.talkMaxDuration = var_40_5

					if var_40_5 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_6 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_6 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_6

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_6 and arg_37_1.time_ < var_40_1 + var_40_6 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play1109502010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1109502010
		arg_41_1.duration_ = 1

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"

			SetActive(arg_41_1.choicesGo_, true)

			for iter_42_0, iter_42_1 in ipairs(arg_41_1.choices_) do
				SetActive(iter_42_1.go, iter_42_0 <= 3)
			end

			arg_41_1.choices_[1].txt.text = arg_41_1:FormatText(StoryChoiceCfg[716].name)
			arg_41_1.choices_[2].txt.text = arg_41_1:FormatText(StoryChoiceCfg[717].name)
			arg_41_1.choices_[3].txt.text = arg_41_1:FormatText(StoryChoiceCfg[718].name)
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1109502011(arg_41_1)
			end

			if arg_43_0 == 2 then
				arg_41_0:Play1109502012(arg_41_1)
			end

			if arg_43_0 == 3 then
				arg_41_0:Play1109502013(arg_41_1)
			end

			arg_41_1:RecordChoiceLog(1109502010, 716, 717, 718)
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.allBtn_.enabled = false
			end

			if arg_41_1.time_ >= 0 + 0.5 and arg_41_1.time_ < 0 + 0.5 + arg_44_0 then
				arg_41_1.allBtn_.enabled = true
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play1109502011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1109502011
		arg_45_1.duration_ = 3.3

		local var_45_0 = {
			zh = 2.733,
			ja = 3.3
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
				arg_45_0:Play1109502016(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["10058ui_story"]) and arg_45_1.var_.characterEffect10058ui_story == nil then
				arg_45_1.var_.characterEffect10058ui_story = arg_45_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["10058ui_story"]) then
				if arg_45_1.var_.characterEffect10058ui_story and not isNil(arg_45_1.actors_["10058ui_story"]) then
					arg_45_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["10058ui_story"]) and arg_45_1.var_.characterEffect10058ui_story then
				arg_45_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_48_2 = 0
			local var_48_3 = 0.125

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_4 = arg_45_1:GetWordFromCfg(1109502011)
				local var_48_5 = arg_45_1:FormatText(var_48_4.content)

				arg_45_1.text_.text = var_48_5

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_7 = 5 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 5)

				if (5 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 5)) > 0 and var_48_3 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_2
					end
				end

				arg_45_1.text_.text = var_48_5
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502011", "story_v_side_new_1109502.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502011", "story_v_side_new_1109502.awb") / 1000

					if var_48_8 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_2
					end

					if var_48_4.prefab_name ~= "" and arg_45_1.actors_[var_48_4.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_4.prefab_name].transform, "story_v_side_new_1109502", "1109502011", "story_v_side_new_1109502.awb")

						arg_45_1:RecordAudio("1109502011", var_48_9)
						arg_45_1:RecordAudio("1109502011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502011", "story_v_side_new_1109502.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502011", "story_v_side_new_1109502.awb")
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
	Play1109502016 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1109502016
		arg_49_1.duration_ = 7.73

		local var_49_0 = {
			zh = 4.1,
			ja = 7.733
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1109502017(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos10058ui_story = arg_49_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10058ui_story"].transform.position).z)
				arg_49_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["10058ui_story"].transform.localEulerAngles = arg_49_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_49_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10058ui_story"].transform.position).z)
				arg_49_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["10058ui_story"].transform.localEulerAngles = arg_49_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_52_1 = arg_49_1.actors_["10058ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect10058ui_story == nil then
				arg_49_1.var_.characterEffect10058ui_story = var_52_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 and not isNil(var_52_1) then
				if arg_49_1.var_.characterEffect10058ui_story and not isNil(var_52_1) then
					arg_49_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect10058ui_story then
				arg_49_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_52_4 = 0
			local var_52_5 = 0.3

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_6 = arg_49_1:GetWordFromCfg(1109502016)
				local var_52_7 = arg_49_1:FormatText(var_52_6.content)

				arg_49_1.text_.text = var_52_7

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 12 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 12)

				if (12 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 12)) > 0 and var_52_5 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_4
					end
				end

				arg_49_1.text_.text = var_52_7
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502016", "story_v_side_new_1109502.awb") ~= 0 then
					local var_52_10 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502016", "story_v_side_new_1109502.awb") / 1000

					if var_52_10 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_4
					end

					if var_52_6.prefab_name ~= "" and arg_49_1.actors_[var_52_6.prefab_name] ~= nil then
						local var_52_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_6.prefab_name].transform, "story_v_side_new_1109502", "1109502016", "story_v_side_new_1109502.awb")

						arg_49_1:RecordAudio("1109502016", var_52_11)
						arg_49_1:RecordAudio("1109502016", var_52_11)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502016", "story_v_side_new_1109502.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502016", "story_v_side_new_1109502.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_12 = math.max(var_52_5, arg_49_1.talkMaxDuration)

			if var_52_4 <= arg_49_1.time_ and arg_49_1.time_ < var_52_4 + var_52_12 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_4) / var_52_12

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_4 + var_52_12 and arg_49_1.time_ < var_52_4 + var_52_12 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play1109502017 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1109502017
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play1109502018(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["10058ui_story"]) and arg_53_1.var_.characterEffect10058ui_story == nil then
				arg_53_1.var_.characterEffect10058ui_story = arg_53_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["10058ui_story"]) then
				if arg_53_1.var_.characterEffect10058ui_story and not isNil(arg_53_1.actors_["10058ui_story"]) then
					arg_53_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_53_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_0)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["10058ui_story"]) and arg_53_1.var_.characterEffect10058ui_story then
				arg_53_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_53_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_56_1 = 0
			local var_56_2 = 0.275

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_3 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(1109502017).content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 11 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_3) / 11)

				if (11 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_3) / 11)) > 0 and var_56_2 < var_56_5 then
					arg_53_1.talkMaxDuration = var_56_5

					if var_56_5 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + var_56_1
					end
				end

				arg_53_1.text_.text = var_56_3
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_6 = math.max(var_56_2, arg_53_1.talkMaxDuration)

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_6 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_1) / var_56_6

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_1 + var_56_6 and arg_53_1.time_ < var_56_1 + var_56_6 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play1109502018 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1109502018
		arg_57_1.duration_ = 4.7

		local var_57_0 = {
			zh = 3,
			ja = 4.7
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
				arg_57_0:Play1109502019(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["10058ui_story"]) and arg_57_1.var_.characterEffect10058ui_story == nil then
				arg_57_1.var_.characterEffect10058ui_story = arg_57_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["10058ui_story"]) then
				if arg_57_1.var_.characterEffect10058ui_story and not isNil(arg_57_1.actors_["10058ui_story"]) then
					arg_57_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["10058ui_story"]) and arg_57_1.var_.characterEffect10058ui_story then
				arg_57_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_60_2 = 0
			local var_60_3 = 0.4

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_4 = arg_57_1:GetWordFromCfg(1109502018)
				local var_60_5 = arg_57_1:FormatText(var_60_4.content)

				arg_57_1.text_.text = var_60_5

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_7 = 16 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 16)

				if (16 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 16)) > 0 and var_60_3 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_2
					end
				end

				arg_57_1.text_.text = var_60_5
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502018", "story_v_side_new_1109502.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502018", "story_v_side_new_1109502.awb") / 1000

					if var_60_8 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_2
					end

					if var_60_4.prefab_name ~= "" and arg_57_1.actors_[var_60_4.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_4.prefab_name].transform, "story_v_side_new_1109502", "1109502018", "story_v_side_new_1109502.awb")

						arg_57_1:RecordAudio("1109502018", var_60_9)
						arg_57_1:RecordAudio("1109502018", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502018", "story_v_side_new_1109502.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502018", "story_v_side_new_1109502.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_3, arg_57_1.talkMaxDuration)

			if var_60_2 <= arg_57_1.time_ and arg_57_1.time_ < var_60_2 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_2) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_2 + var_60_10 and arg_57_1.time_ < var_60_2 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play1109502019 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1109502019
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play1109502020(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["10058ui_story"]) and arg_61_1.var_.characterEffect10058ui_story == nil then
				arg_61_1.var_.characterEffect10058ui_story = arg_61_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["10058ui_story"]) then
				if arg_61_1.var_.characterEffect10058ui_story and not isNil(arg_61_1.actors_["10058ui_story"]) then
					arg_61_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_61_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_0)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["10058ui_story"]) and arg_61_1.var_.characterEffect10058ui_story then
				arg_61_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_61_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_64_1 = 0
			local var_64_2 = 0.425

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
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

				local var_64_3 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(1109502019).content)

				arg_61_1.text_.text = var_64_3

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 17 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_3) / 17)

				if (17 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_3) / 17)) > 0 and var_64_2 < var_64_5 then
					arg_61_1.talkMaxDuration = var_64_5

					if var_64_5 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + var_64_1
					end
				end

				arg_61_1.text_.text = var_64_3
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_6 = math.max(var_64_2, arg_61_1.talkMaxDuration)

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_6 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_1) / var_64_6

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_1 + var_64_6 and arg_61_1.time_ < var_64_1 + var_64_6 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play1109502020 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1109502020
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1109502021(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.5

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_1 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(1109502020).content)

				arg_65_1.text_.text = var_68_1

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_3 = 20 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 20)

				if (20 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 20)) > 0 and var_68_0 < var_68_3 then
					arg_65_1.talkMaxDuration = var_68_3

					if var_68_3 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_3 + 0
					end
				end

				arg_65_1.text_.text = var_68_1
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_4 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_4

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play1109502021 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1109502021
		arg_69_1.duration_ = 7.27

		local var_69_0 = {
			zh = 3.066,
			ja = 7.266
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
				arg_69_0:Play1109502022(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10058ui_story = arg_69_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10058ui_story"].transform.position).z)
				arg_69_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["10058ui_story"].transform.localEulerAngles = arg_69_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_69_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10058ui_story"].transform.position).z)
				arg_69_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["10058ui_story"].transform.localEulerAngles = arg_69_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_72_1 = arg_69_1.actors_["10058ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect10058ui_story == nil then
				arg_69_1.var_.characterEffect10058ui_story = var_72_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.0166666666666667

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 and not isNil(var_72_1) then
				if arg_69_1.var_.characterEffect10058ui_story and not isNil(var_72_1) then
					arg_69_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect10058ui_story then
				arg_69_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095actionlink/1095action424")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_72_4 = 0
			local var_72_5 = 0.275

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_6 = arg_69_1:GetWordFromCfg(1109502021)
				local var_72_7 = arg_69_1:FormatText(var_72_6.content)

				arg_69_1.text_.text = var_72_7

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_9 = 11 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 11)

				if (11 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 11)) > 0 and var_72_5 < var_72_9 then
					arg_69_1.talkMaxDuration = var_72_9

					if var_72_9 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_4
					end
				end

				arg_69_1.text_.text = var_72_7
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502021", "story_v_side_new_1109502.awb") ~= 0 then
					local var_72_10 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502021", "story_v_side_new_1109502.awb") / 1000

					if var_72_10 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_4
					end

					if var_72_6.prefab_name ~= "" and arg_69_1.actors_[var_72_6.prefab_name] ~= nil then
						local var_72_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_6.prefab_name].transform, "story_v_side_new_1109502", "1109502021", "story_v_side_new_1109502.awb")

						arg_69_1:RecordAudio("1109502021", var_72_11)
						arg_69_1:RecordAudio("1109502021", var_72_11)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502021", "story_v_side_new_1109502.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502021", "story_v_side_new_1109502.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_12 = math.max(var_72_5, arg_69_1.talkMaxDuration)

			if var_72_4 <= arg_69_1.time_ and arg_69_1.time_ < var_72_4 + var_72_12 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_4) / var_72_12

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_4 + var_72_12 and arg_69_1.time_ < var_72_4 + var_72_12 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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
	Play1109502022 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1109502022
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1109502023(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["10058ui_story"]) and arg_73_1.var_.characterEffect10058ui_story == nil then
				arg_73_1.var_.characterEffect10058ui_story = arg_73_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["10058ui_story"]) then
				if arg_73_1.var_.characterEffect10058ui_story and not isNil(arg_73_1.actors_["10058ui_story"]) then
					arg_73_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_73_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_0)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["10058ui_story"]) and arg_73_1.var_.characterEffect10058ui_story then
				arg_73_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_73_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_76_1 = 0
			local var_76_2 = 0.85

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_3 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(1109502022).content)

				arg_73_1.text_.text = var_76_3

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 34 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 34)

				if (34 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 34)) > 0 and var_76_2 < var_76_5 then
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
	Play1109502023 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1109502023
		arg_77_1.duration_ = 8.47

		local var_77_0 = {
			zh = 6.933,
			ja = 8.466
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
				arg_77_0:Play1109502024(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["10058ui_story"]) and arg_77_1.var_.characterEffect10058ui_story == nil then
				arg_77_1.var_.characterEffect10058ui_story = arg_77_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["10058ui_story"]) then
				if arg_77_1.var_.characterEffect10058ui_story and not isNil(arg_77_1.actors_["10058ui_story"]) then
					arg_77_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["10058ui_story"]) and arg_77_1.var_.characterEffect10058ui_story then
				arg_77_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_80_2 = 0
			local var_80_3 = 0.775

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_4 = arg_77_1:GetWordFromCfg(1109502023)
				local var_80_5 = arg_77_1:FormatText(var_80_4.content)

				arg_77_1.text_.text = var_80_5

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_7 = 31 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 31)

				if (31 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 31)) > 0 and var_80_3 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_2
					end
				end

				arg_77_1.text_.text = var_80_5
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502023", "story_v_side_new_1109502.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502023", "story_v_side_new_1109502.awb") / 1000

					if var_80_8 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_2
					end

					if var_80_4.prefab_name ~= "" and arg_77_1.actors_[var_80_4.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_4.prefab_name].transform, "story_v_side_new_1109502", "1109502023", "story_v_side_new_1109502.awb")

						arg_77_1:RecordAudio("1109502023", var_80_9)
						arg_77_1:RecordAudio("1109502023", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502023", "story_v_side_new_1109502.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502023", "story_v_side_new_1109502.awb")
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
	Play1109502024 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1109502024
		arg_81_1.duration_ = 6.27

		local var_81_0 = {
			zh = 2.666,
			ja = 6.266
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
				arg_81_0:Play1109502025(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_2")
			end

			local var_84_0 = 0
			local var_84_1 = 0.275

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_2 = arg_81_1:GetWordFromCfg(1109502024)
				local var_84_3 = arg_81_1:FormatText(var_84_2.content)

				arg_81_1.text_.text = var_84_3

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 11 <= 0 and var_84_1 or var_84_1 * (utf8.len(var_84_3) / 11)

				if (11 <= 0 and var_84_1 or var_84_1 * (utf8.len(var_84_3) / 11)) > 0 and var_84_1 < var_84_5 then
					arg_81_1.talkMaxDuration = var_84_5

					if var_84_5 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + var_84_0
					end
				end

				arg_81_1.text_.text = var_84_3
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502024", "story_v_side_new_1109502.awb") ~= 0 then
					local var_84_6 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502024", "story_v_side_new_1109502.awb") / 1000

					if var_84_6 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_6 + var_84_0
					end

					if var_84_2.prefab_name ~= "" and arg_81_1.actors_[var_84_2.prefab_name] ~= nil then
						local var_84_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_2.prefab_name].transform, "story_v_side_new_1109502", "1109502024", "story_v_side_new_1109502.awb")

						arg_81_1:RecordAudio("1109502024", var_84_7)
						arg_81_1:RecordAudio("1109502024", var_84_7)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502024", "story_v_side_new_1109502.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502024", "story_v_side_new_1109502.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_8 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_8 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_8

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_8 and arg_81_1.time_ < var_84_0 + var_84_8 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play1109502025 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1109502025
		arg_85_1.duration_ = 9

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play1109502026(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				local var_88_0 = arg_85_1.bgs_.ST04b

				arg_85_1.bgs_.ST04b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_88_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_88_1 = var_88_0:GetComponent("SpriteRenderer")

				if var_88_1 and var_88_1.sprite then
					local var_88_2 = 2 * (var_88_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_88_0.transform.localScale = Vector3.New(var_88_2 / var_88_1.sprite.bounds.size.y < var_88_2 * manager.ui.mainCameraCom_.aspect / var_88_1.sprite.bounds.size.x and var_88_2 * manager.ui.mainCameraCom_.aspect / var_88_1.sprite.bounds.size.x or var_88_2 / var_88_1.sprite.bounds.size.y, var_88_2 / var_88_1.sprite.bounds.size.y < var_88_2 * manager.ui.mainCameraCom_.aspect / var_88_1.sprite.bounds.size.x and var_88_2 * manager.ui.mainCameraCom_.aspect / var_88_1.sprite.bounds.size.x or var_88_2 / var_88_1.sprite.bounds.size.y, 0)
				end

				for iter_88_0, iter_88_1 in pairs(arg_85_1.bgs_) do
					if iter_88_0 ~= "ST04b" then
						iter_88_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_88_3 = "ST28"

			if arg_85_1.bgs_.ST28 == nil then
				local var_88_4 = Object.Instantiate(arg_85_1.paintGo_)

				var_88_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_88_3)
				var_88_4.name = var_88_3
				var_88_4.transform.parent = arg_85_1.stage_.transform
				var_88_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_85_1.bgs_[var_88_3] = var_88_4
			end

			if 2 < arg_85_1.time_ and arg_85_1.time_ <= 2 + arg_88_0 then
				local var_88_5 = arg_85_1.bgs_.ST28

				arg_85_1.bgs_.ST28.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_88_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_88_6 = var_88_5:GetComponent("SpriteRenderer")

				if var_88_6 and var_88_6.sprite then
					local var_88_7 = 2 * (var_88_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_88_5.transform.localScale = Vector3.New(var_88_7 / var_88_6.sprite.bounds.size.y < var_88_7 * manager.ui.mainCameraCom_.aspect / var_88_6.sprite.bounds.size.x and var_88_7 * manager.ui.mainCameraCom_.aspect / var_88_6.sprite.bounds.size.x or var_88_7 / var_88_6.sprite.bounds.size.y, var_88_7 / var_88_6.sprite.bounds.size.y < var_88_7 * manager.ui.mainCameraCom_.aspect / var_88_6.sprite.bounds.size.x and var_88_7 * manager.ui.mainCameraCom_.aspect / var_88_6.sprite.bounds.size.x or var_88_7 / var_88_6.sprite.bounds.size.y, 0)
				end

				for iter_88_2, iter_88_3 in pairs(arg_85_1.bgs_) do
					if iter_88_2 ~= "ST28" then
						iter_88_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_88_8 = 0

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 then
				arg_85_1.mask_.enabled = true
				arg_85_1.mask_.raycastTarget = true

				arg_85_1:SetGaussion(false)
			end

			local var_88_9 = 2

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_9 then
				local var_88_10 = Color.New(0, 0, 0)

				var_88_10.a = Mathf.Lerp(0, 1, (arg_85_1.time_ - var_88_8) / var_88_9)
				arg_85_1.mask_.color = var_88_10
			end

			if arg_85_1.time_ >= var_88_8 + var_88_9 and arg_85_1.time_ < var_88_8 + var_88_9 + arg_88_0 then
				local var_88_11 = Color.New(0, 0, 0)

				var_88_11.a = 1
				arg_85_1.mask_.color = var_88_11
			end

			local var_88_12 = 2

			if 2 < arg_85_1.time_ and arg_85_1.time_ <= var_88_12 + arg_88_0 then
				arg_85_1.mask_.enabled = true
				arg_85_1.mask_.raycastTarget = true

				arg_85_1:SetGaussion(false)
			end

			local var_88_13 = 2

			if var_88_12 <= arg_85_1.time_ and arg_85_1.time_ < var_88_12 + var_88_13 then
				local var_88_14 = Color.New(0, 0, 0)

				var_88_14.a = Mathf.Lerp(1, 0, (arg_85_1.time_ - var_88_12) / var_88_13)
				arg_85_1.mask_.color = var_88_14
			end

			if arg_85_1.time_ >= var_88_12 + var_88_13 and arg_85_1.time_ < var_88_12 + var_88_13 + arg_88_0 then
				local var_88_15 = Color.New(0, 0, 0)

				arg_85_1.mask_.enabled = false
				var_88_15.a = 0
				arg_85_1.mask_.color = var_88_15
			end

			local var_88_16 = arg_85_1.actors_["10058ui_story"].transform

			if 2 < arg_85_1.time_ and arg_85_1.time_ <= 2 + arg_88_0 then
				arg_85_1.var_.moveOldPos10058ui_story = var_88_16.localPosition
			end

			local var_88_17 = 0.001

			if 2 <= arg_85_1.time_ and arg_85_1.time_ < 2 + var_88_17 then
				var_88_16.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_85_1.time_ - 2) / var_88_17)
				var_88_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_16.position).x, (manager.ui.mainCamera.transform.position - var_88_16.position).y, (manager.ui.mainCamera.transform.position - var_88_16.position).z)
				var_88_16.localEulerAngles.z = 0
				var_88_16.localEulerAngles.x = 0
				var_88_16.localEulerAngles = var_88_16.localEulerAngles
			end

			if arg_85_1.time_ >= 2 + var_88_17 and arg_85_1.time_ < 2 + var_88_17 + arg_88_0 then
				var_88_16.localPosition = Vector3.New(0, 100, 0)
				var_88_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_16.position).x, (manager.ui.mainCamera.transform.position - var_88_16.position).y, (manager.ui.mainCamera.transform.position - var_88_16.position).z)
				var_88_16.localEulerAngles.z = 0
				var_88_16.localEulerAngles.x = 0
				var_88_16.localEulerAngles = var_88_16.localEulerAngles
			end

			if 3.5 < arg_85_1.time_ and arg_85_1.time_ <= 3.5 + arg_88_0 then
				arg_85_1:AudioAction("play", "effect", "se_story_side_1080", "se_story_1080_parkloop", "")
			end

			if arg_85_1.frameCnt_ <= 1 then
				arg_85_1.dialog_:SetActive(false)
			end

			local var_88_19 = 3.999999999999
			local var_88_20 = 0.55

			if 3.999999999999 < arg_85_1.time_ and arg_85_1.time_ <= var_88_19 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0

				arg_85_1.dialog_:SetActive(true)

				arg_85_1.dialogCg_.alpha = 0

				local var_88_21 = LeanTween.value(arg_85_1.dialog_, 0, 1, 0.3)

				var_88_21:setOnUpdate(LuaHelper.FloatAction(function(arg_89_0)
					arg_85_1.dialogCg_.alpha = arg_89_0
				end))
				var_88_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_85_1.dialog_)
					var_88_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_85_1.duration_ = arg_85_1.duration_ + 0.3

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

				local var_88_22 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(1109502025).content)

				arg_85_1.text_.text = var_88_22

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_24 = 22 <= 0 and var_88_20 or var_88_20 * (utf8.len(var_88_22) / 22)

				if (22 <= 0 and var_88_20 or var_88_20 * (utf8.len(var_88_22) / 22)) > 0 and var_88_20 < var_88_24 then
					arg_85_1.talkMaxDuration = var_88_24
					var_88_19 = var_88_19 + 0.3

					if var_88_24 + var_88_19 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_24 + var_88_19
					end
				end

				arg_85_1.text_.text = var_88_22
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_25 = var_88_19 + 0.3
			local var_88_26 = math.max(var_88_20, arg_85_1.talkMaxDuration)

			if var_88_19 + 0.3 <= arg_85_1.time_ and arg_85_1.time_ < var_88_25 + var_88_26 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_25) / var_88_26

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_25 + var_88_26 and arg_85_1.time_ < var_88_25 + var_88_26 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play1109502026 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 1109502026
		arg_91_1.duration_ = 7.37

		local var_91_0 = {
			zh = 2.3,
			ja = 7.366
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play1109502027(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(arg_91_1.actors_["10058ui_story"]) and arg_91_1.var_.characterEffect10058ui_story == nil then
				arg_91_1.var_.characterEffect10058ui_story = arg_91_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_0 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 and not isNil(arg_91_1.actors_["10058ui_story"]) then
				if arg_91_1.var_.characterEffect10058ui_story and not isNil(arg_91_1.actors_["10058ui_story"]) then
					arg_91_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 and not isNil(arg_91_1.actors_["10058ui_story"]) and arg_91_1.var_.characterEffect10058ui_story then
				arg_91_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_94_2 = arg_91_1.actors_["10058ui_story"].transform

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos10058ui_story = var_94_2.localPosition
			end

			local var_94_3 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_3 then
				var_94_2.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_91_1.time_ - 0) / var_94_3)
				var_94_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_2.position).x, (manager.ui.mainCamera.transform.position - var_94_2.position).y, (manager.ui.mainCamera.transform.position - var_94_2.position).z)
				var_94_2.localEulerAngles.z = 0
				var_94_2.localEulerAngles.x = 0
				var_94_2.localEulerAngles = var_94_2.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_3 and arg_91_1.time_ < 0 + var_94_3 + arg_94_0 then
				var_94_2.localPosition = Vector3.New(0, -0.98, -6.1)
				var_94_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_2.position).x, (manager.ui.mainCamera.transform.position - var_94_2.position).y, (manager.ui.mainCamera.transform.position - var_94_2.position).z)
				var_94_2.localEulerAngles.z = 0
				var_94_2.localEulerAngles.x = 0
				var_94_2.localEulerAngles = var_94_2.localEulerAngles
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_94_4 = 0
			local var_94_5 = 0.275

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_4 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_6 = arg_91_1:GetWordFromCfg(1109502026)
				local var_94_7 = arg_91_1:FormatText(var_94_6.content)

				arg_91_1.text_.text = var_94_7

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_9 = 11 <= 0 and var_94_5 or var_94_5 * (utf8.len(var_94_7) / 11)

				if (11 <= 0 and var_94_5 or var_94_5 * (utf8.len(var_94_7) / 11)) > 0 and var_94_5 < var_94_9 then
					arg_91_1.talkMaxDuration = var_94_9

					if var_94_9 + var_94_4 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_9 + var_94_4
					end
				end

				arg_91_1.text_.text = var_94_7
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502026", "story_v_side_new_1109502.awb") ~= 0 then
					local var_94_10 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502026", "story_v_side_new_1109502.awb") / 1000

					if var_94_10 + var_94_4 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_10 + var_94_4
					end

					if var_94_6.prefab_name ~= "" and arg_91_1.actors_[var_94_6.prefab_name] ~= nil then
						local var_94_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_6.prefab_name].transform, "story_v_side_new_1109502", "1109502026", "story_v_side_new_1109502.awb")

						arg_91_1:RecordAudio("1109502026", var_94_11)
						arg_91_1:RecordAudio("1109502026", var_94_11)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502026", "story_v_side_new_1109502.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502026", "story_v_side_new_1109502.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_12 = math.max(var_94_5, arg_91_1.talkMaxDuration)

			if var_94_4 <= arg_91_1.time_ and arg_91_1.time_ < var_94_4 + var_94_12 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_4) / var_94_12

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_4 + var_94_12 and arg_91_1.time_ < var_94_4 + var_94_12 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play1109502027 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 1109502027
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play1109502028(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(arg_95_1.actors_["10058ui_story"]) and arg_95_1.var_.characterEffect10058ui_story == nil then
				arg_95_1.var_.characterEffect10058ui_story = arg_95_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_0 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 and not isNil(arg_95_1.actors_["10058ui_story"]) then
				if arg_95_1.var_.characterEffect10058ui_story and not isNil(arg_95_1.actors_["10058ui_story"]) then
					arg_95_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_95_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_95_1.time_ - 0) / var_98_0)
				end
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 and not isNil(arg_95_1.actors_["10058ui_story"]) and arg_95_1.var_.characterEffect10058ui_story then
				arg_95_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_95_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_98_1 = 0
			local var_98_2 = 0.475

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_3 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(1109502027).content)

				arg_95_1.text_.text = var_98_3

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 19 <= 0 and var_98_2 or var_98_2 * (utf8.len(var_98_3) / 19)

				if (19 <= 0 and var_98_2 or var_98_2 * (utf8.len(var_98_3) / 19)) > 0 and var_98_2 < var_98_5 then
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
	Play1109502028 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 1109502028
		arg_99_1.duration_ = 5.1

		local var_99_0 = {
			zh = 1.566,
			ja = 5.1
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
				arg_99_0:Play1109502029(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos10058ui_story = arg_99_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_102_0 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 then
				arg_99_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_99_1.time_ - 0) / var_102_0)
				arg_99_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10058ui_story"].transform.position).z)
				arg_99_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["10058ui_story"].transform.localEulerAngles = arg_99_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 then
				arg_99_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_99_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10058ui_story"].transform.position).z)
				arg_99_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["10058ui_story"].transform.localEulerAngles = arg_99_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_102_1 = arg_99_1.actors_["10058ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect10058ui_story == nil then
				arg_99_1.var_.characterEffect10058ui_story = var_102_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_2 and not isNil(var_102_1) then
				if arg_99_1.var_.characterEffect10058ui_story and not isNil(var_102_1) then
					arg_99_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= 0 + var_102_2 and arg_99_1.time_ < 0 + var_102_2 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect10058ui_story then
				arg_99_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_102_4 = 0
			local var_102_5 = 0.175

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_4 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_6 = arg_99_1:GetWordFromCfg(1109502028)
				local var_102_7 = arg_99_1:FormatText(var_102_6.content)

				arg_99_1.text_.text = var_102_7

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_9 = 7 <= 0 and var_102_5 or var_102_5 * (utf8.len(var_102_7) / 7)

				if (7 <= 0 and var_102_5 or var_102_5 * (utf8.len(var_102_7) / 7)) > 0 and var_102_5 < var_102_9 then
					arg_99_1.talkMaxDuration = var_102_9

					if var_102_9 + var_102_4 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_9 + var_102_4
					end
				end

				arg_99_1.text_.text = var_102_7
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502028", "story_v_side_new_1109502.awb") ~= 0 then
					local var_102_10 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502028", "story_v_side_new_1109502.awb") / 1000

					if var_102_10 + var_102_4 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_10 + var_102_4
					end

					if var_102_6.prefab_name ~= "" and arg_99_1.actors_[var_102_6.prefab_name] ~= nil then
						local var_102_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_6.prefab_name].transform, "story_v_side_new_1109502", "1109502028", "story_v_side_new_1109502.awb")

						arg_99_1:RecordAudio("1109502028", var_102_11)
						arg_99_1:RecordAudio("1109502028", var_102_11)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502028", "story_v_side_new_1109502.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502028", "story_v_side_new_1109502.awb")
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
				actorName = "10058ui_story",
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
	Play1109502029 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 1109502029
		arg_103_1.duration_ = 3.47

		local var_103_0 = {
			zh = 2.1,
			ja = 3.466
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
				arg_103_0:Play1109502030(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0.25

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_1 = arg_103_1:GetWordFromCfg(1109502029)
				local var_106_2 = arg_103_1:FormatText(var_106_1.content)

				arg_103_1.text_.text = var_106_2

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_4 = 10 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_2) / 10)

				if (10 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_2) / 10)) > 0 and var_106_0 < var_106_4 then
					arg_103_1.talkMaxDuration = var_106_4

					if var_106_4 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_4 + 0
					end
				end

				arg_103_1.text_.text = var_106_2
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502029", "story_v_side_new_1109502.awb") ~= 0 then
					local var_106_5 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502029", "story_v_side_new_1109502.awb") / 1000

					if var_106_5 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_5 + 0
					end

					if var_106_1.prefab_name ~= "" and arg_103_1.actors_[var_106_1.prefab_name] ~= nil then
						local var_106_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_1.prefab_name].transform, "story_v_side_new_1109502", "1109502029", "story_v_side_new_1109502.awb")

						arg_103_1:RecordAudio("1109502029", var_106_6)
						arg_103_1:RecordAudio("1109502029", var_106_6)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502029", "story_v_side_new_1109502.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502029", "story_v_side_new_1109502.awb")
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
	Play1109502030 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 1109502030
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play1109502031(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos10058ui_story = arg_107_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_110_0 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 then
				arg_107_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_107_1.time_ - 0) / var_110_0)
				arg_107_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["10058ui_story"].transform.position).z)
				arg_107_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["10058ui_story"].transform.localEulerAngles = arg_107_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 then
				arg_107_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_107_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["10058ui_story"].transform.position).z)
				arg_107_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["10058ui_story"].transform.localEulerAngles = arg_107_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_110_1 = 0
			local var_110_2 = 0.775

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_3 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(1109502030).content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 31 <= 0 and var_110_2 or var_110_2 * (utf8.len(var_110_3) / 31)

				if (31 <= 0 and var_110_2 or var_110_2 * (utf8.len(var_110_3) / 31)) > 0 and var_110_2 < var_110_5 then
					arg_107_1.talkMaxDuration = var_110_5

					if var_110_5 + var_110_1 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_5 + var_110_1
					end
				end

				arg_107_1.text_.text = var_110_3
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_6 = math.max(var_110_2, arg_107_1.talkMaxDuration)

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_6 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_1) / var_110_6

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_1 + var_110_6 and arg_107_1.time_ < var_110_1 + var_110_6 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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
	Play1109502031 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 1109502031
		arg_111_1.duration_ = 11

		local var_111_0 = {
			zh = 5.466,
			ja = 11
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
				arg_111_0:Play1109502032(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos10058ui_story = arg_111_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_114_0 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 then
				arg_111_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_111_1.time_ - 0) / var_114_0)
				arg_111_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["10058ui_story"].transform.position).z)
				arg_111_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["10058ui_story"].transform.localEulerAngles = arg_111_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 then
				arg_111_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_111_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["10058ui_story"].transform.position).z)
				arg_111_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["10058ui_story"].transform.localEulerAngles = arg_111_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_114_1 = arg_111_1.actors_["10058ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_1) and arg_111_1.var_.characterEffect10058ui_story == nil then
				arg_111_1.var_.characterEffect10058ui_story = var_114_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_2 and not isNil(var_114_1) then
				if arg_111_1.var_.characterEffect10058ui_story and not isNil(var_114_1) then
					arg_111_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= 0 + var_114_2 and arg_111_1.time_ < 0 + var_114_2 + arg_114_0 and not isNil(var_114_1) and arg_111_1.var_.characterEffect10058ui_story then
				arg_111_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_114_4 = 0
			local var_114_5 = 0.65

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_4 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_6 = arg_111_1:GetWordFromCfg(1109502031)
				local var_114_7 = arg_111_1:FormatText(var_114_6.content)

				arg_111_1.text_.text = var_114_7

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_9 = 26 <= 0 and var_114_5 or var_114_5 * (utf8.len(var_114_7) / 26)

				if (26 <= 0 and var_114_5 or var_114_5 * (utf8.len(var_114_7) / 26)) > 0 and var_114_5 < var_114_9 then
					arg_111_1.talkMaxDuration = var_114_9

					if var_114_9 + var_114_4 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_9 + var_114_4
					end
				end

				arg_111_1.text_.text = var_114_7
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502031", "story_v_side_new_1109502.awb") ~= 0 then
					local var_114_10 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502031", "story_v_side_new_1109502.awb") / 1000

					if var_114_10 + var_114_4 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_10 + var_114_4
					end

					if var_114_6.prefab_name ~= "" and arg_111_1.actors_[var_114_6.prefab_name] ~= nil then
						local var_114_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_6.prefab_name].transform, "story_v_side_new_1109502", "1109502031", "story_v_side_new_1109502.awb")

						arg_111_1:RecordAudio("1109502031", var_114_11)
						arg_111_1:RecordAudio("1109502031", var_114_11)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502031", "story_v_side_new_1109502.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502031", "story_v_side_new_1109502.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_12 = math.max(var_114_5, arg_111_1.talkMaxDuration)

			if var_114_4 <= arg_111_1.time_ and arg_111_1.time_ < var_114_4 + var_114_12 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_4) / var_114_12

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_4 + var_114_12 and arg_111_1.time_ < var_114_4 + var_114_12 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play1109502032 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 1109502032
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play1109502033(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(arg_115_1.actors_["10058ui_story"]) and arg_115_1.var_.characterEffect10058ui_story == nil then
				arg_115_1.var_.characterEffect10058ui_story = arg_115_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_0 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 and not isNil(arg_115_1.actors_["10058ui_story"]) then
				if arg_115_1.var_.characterEffect10058ui_story and not isNil(arg_115_1.actors_["10058ui_story"]) then
					arg_115_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_115_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_115_1.time_ - 0) / var_118_0)
				end
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 and not isNil(arg_115_1.actors_["10058ui_story"]) and arg_115_1.var_.characterEffect10058ui_story then
				arg_115_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_115_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_118_1 = arg_115_1.actors_["10058ui_story"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos10058ui_story = var_118_1.localPosition
			end

			local var_118_2 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_2 then
				var_118_1.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_115_1.time_ - 0) / var_118_2)
				var_118_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_1.position).x, (manager.ui.mainCamera.transform.position - var_118_1.position).y, (manager.ui.mainCamera.transform.position - var_118_1.position).z)
				var_118_1.localEulerAngles.z = 0
				var_118_1.localEulerAngles.x = 0
				var_118_1.localEulerAngles = var_118_1.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_2 and arg_115_1.time_ < 0 + var_118_2 + arg_118_0 then
				var_118_1.localPosition = Vector3.New(0, -0.98, -6.1)
				var_118_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_1.position).x, (manager.ui.mainCamera.transform.position - var_118_1.position).y, (manager.ui.mainCamera.transform.position - var_118_1.position).z)
				var_118_1.localEulerAngles.z = 0
				var_118_1.localEulerAngles.x = 0
				var_118_1.localEulerAngles = var_118_1.localEulerAngles
			end

			local var_118_3 = 0
			local var_118_4 = 0.975

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_3 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_5 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(1109502032).content)

				arg_115_1.text_.text = var_118_5

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_7 = 39 <= 0 and var_118_4 or var_118_4 * (utf8.len(var_118_5) / 39)

				if (39 <= 0 and var_118_4 or var_118_4 * (utf8.len(var_118_5) / 39)) > 0 and var_118_4 < var_118_7 then
					arg_115_1.talkMaxDuration = var_118_7

					if var_118_7 + var_118_3 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_7 + var_118_3
					end
				end

				arg_115_1.text_.text = var_118_5
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_8 = math.max(var_118_4, arg_115_1.talkMaxDuration)

			if var_118_3 <= arg_115_1.time_ and arg_115_1.time_ < var_118_3 + var_118_8 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_3) / var_118_8

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_3 + var_118_8 and arg_115_1.time_ < var_118_3 + var_118_8 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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
	Play1109502033 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 1109502033
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play1109502034(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0.2

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
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

				local var_122_1 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(1109502033).content)

				arg_119_1.text_.text = var_122_1

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_3 = 8 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_1) / 8)

				if (8 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_1) / 8)) > 0 and var_122_0 < var_122_3 then
					arg_119_1.talkMaxDuration = var_122_3

					if var_122_3 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_3 + 0
					end
				end

				arg_119_1.text_.text = var_122_1
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_4 = math.max(var_122_0, arg_119_1.talkMaxDuration)

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_4 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - 0) / var_122_4

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= 0 + var_122_4 and arg_119_1.time_ < 0 + var_122_4 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play1109502034 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 1109502034
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play1109502035(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10058ui_story = arg_123_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_126_0 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 then
				arg_123_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_123_1.time_ - 0) / var_126_0)
				arg_123_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["10058ui_story"].transform.position).z)
				arg_123_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["10058ui_story"].transform.localEulerAngles = arg_123_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 then
				arg_123_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_123_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["10058ui_story"].transform.position).z)
				arg_123_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["10058ui_story"].transform.localEulerAngles = arg_123_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_126_1 = 0
			local var_126_2 = 1.375

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_3 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(1109502034).content)

				arg_123_1.text_.text = var_126_3

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 55 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_3) / 55)

				if (55 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_3) / 55)) > 0 and var_126_2 < var_126_5 then
					arg_123_1.talkMaxDuration = var_126_5

					if var_126_5 + var_126_1 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_5 + var_126_1
					end
				end

				arg_123_1.text_.text = var_126_3
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_6 = math.max(var_126_2, arg_123_1.talkMaxDuration)

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_6 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_1) / var_126_6

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_1 + var_126_6 and arg_123_1.time_ < var_126_1 + var_126_6 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play1109502035 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 1109502035
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play1109502036(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.475

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_1 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(1109502035).content)

				arg_127_1.text_.text = var_130_1

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_3 = 19 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 19)

				if (19 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 19)) > 0 and var_130_0 < var_130_3 then
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
	Play1109502036 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 1109502036
		arg_131_1.duration_ = 8.57

		local var_131_0 = {
			zh = 7.733,
			ja = 8.566
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
				arg_131_0:Play1109502037(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos10058ui_story = arg_131_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_134_0 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 then
				arg_131_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_131_1.time_ - 0) / var_134_0)
				arg_131_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["10058ui_story"].transform.position).z)
				arg_131_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["10058ui_story"].transform.localEulerAngles = arg_131_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 then
				arg_131_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_131_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["10058ui_story"].transform.position).z)
				arg_131_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["10058ui_story"].transform.localEulerAngles = arg_131_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_134_1 = arg_131_1.actors_["10058ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect10058ui_story == nil then
				arg_131_1.var_.characterEffect10058ui_story = var_134_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.034000001847744

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_2 and not isNil(var_134_1) then
				if arg_131_1.var_.characterEffect10058ui_story and not isNil(var_134_1) then
					arg_131_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_2 and arg_131_1.time_ < 0 + var_134_2 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect10058ui_story then
				arg_131_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_134_4 = 0
			local var_134_5 = 0.975

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_4 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_6 = arg_131_1:GetWordFromCfg(1109502036)
				local var_134_7 = arg_131_1:FormatText(var_134_6.content)

				arg_131_1.text_.text = var_134_7

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_9 = 39 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 39)

				if (39 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 39)) > 0 and var_134_5 < var_134_9 then
					arg_131_1.talkMaxDuration = var_134_9

					if var_134_9 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_9 + var_134_4
					end
				end

				arg_131_1.text_.text = var_134_7
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502036", "story_v_side_new_1109502.awb") ~= 0 then
					local var_134_10 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502036", "story_v_side_new_1109502.awb") / 1000

					if var_134_10 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_10 + var_134_4
					end

					if var_134_6.prefab_name ~= "" and arg_131_1.actors_[var_134_6.prefab_name] ~= nil then
						local var_134_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_6.prefab_name].transform, "story_v_side_new_1109502", "1109502036", "story_v_side_new_1109502.awb")

						arg_131_1:RecordAudio("1109502036", var_134_11)
						arg_131_1:RecordAudio("1109502036", var_134_11)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502036", "story_v_side_new_1109502.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502036", "story_v_side_new_1109502.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_12 = math.max(var_134_5, arg_131_1.talkMaxDuration)

			if var_134_4 <= arg_131_1.time_ and arg_131_1.time_ < var_134_4 + var_134_12 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_4) / var_134_12

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_4 + var_134_12 and arg_131_1.time_ < var_134_4 + var_134_12 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play1109502037 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 1109502037
		arg_135_1.duration_ = 17.83

		local var_135_0 = {
			zh = 10.8,
			ja = 17.833
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
				arg_135_0:Play1109502038(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 1.225

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_1 = arg_135_1:GetWordFromCfg(1109502037)
				local var_138_2 = arg_135_1:FormatText(var_138_1.content)

				arg_135_1.text_.text = var_138_2

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_4 = 49 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 49)

				if (49 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 49)) > 0 and var_138_0 < var_138_4 then
					arg_135_1.talkMaxDuration = var_138_4

					if var_138_4 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_4 + 0
					end
				end

				arg_135_1.text_.text = var_138_2
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502037", "story_v_side_new_1109502.awb") ~= 0 then
					local var_138_5 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502037", "story_v_side_new_1109502.awb") / 1000

					if var_138_5 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_5 + 0
					end

					if var_138_1.prefab_name ~= "" and arg_135_1.actors_[var_138_1.prefab_name] ~= nil then
						local var_138_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_1.prefab_name].transform, "story_v_side_new_1109502", "1109502037", "story_v_side_new_1109502.awb")

						arg_135_1:RecordAudio("1109502037", var_138_6)
						arg_135_1:RecordAudio("1109502037", var_138_6)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502037", "story_v_side_new_1109502.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502037", "story_v_side_new_1109502.awb")
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
	Play1109502038 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 1109502038
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play1109502039(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["10058ui_story"]) and arg_139_1.var_.characterEffect10058ui_story == nil then
				arg_139_1.var_.characterEffect10058ui_story = arg_139_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_0 = 0.0166666666666667

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["10058ui_story"]) then
				if arg_139_1.var_.characterEffect10058ui_story and not isNil(arg_139_1.actors_["10058ui_story"]) then
					arg_139_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_139_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_0)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["10058ui_story"]) and arg_139_1.var_.characterEffect10058ui_story then
				arg_139_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_139_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_142_1 = 0
			local var_142_2 = 0.125

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
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

				local var_142_3 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(1109502038).content)

				arg_139_1.text_.text = var_142_3

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 5 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_3) / 5)

				if (5 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_3) / 5)) > 0 and var_142_2 < var_142_5 then
					arg_139_1.talkMaxDuration = var_142_5

					if var_142_5 + var_142_1 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_5 + var_142_1
					end
				end

				arg_139_1.text_.text = var_142_3
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_6 = math.max(var_142_2, arg_139_1.talkMaxDuration)

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_6 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_1) / var_142_6

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_1 + var_142_6 and arg_139_1.time_ < var_142_1 + var_142_6 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play1109502039 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 1109502039
		arg_143_1.duration_ = 9.53

		local var_143_0 = {
			zh = 8.2,
			ja = 9.533
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
				arg_143_0:Play1109502040(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["10058ui_story"]) and arg_143_1.var_.characterEffect10058ui_story == nil then
				arg_143_1.var_.characterEffect10058ui_story = arg_143_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_0 = 0.2

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["10058ui_story"]) then
				if arg_143_1.var_.characterEffect10058ui_story and not isNil(arg_143_1.actors_["10058ui_story"]) then
					arg_143_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["10058ui_story"]) and arg_143_1.var_.characterEffect10058ui_story then
				arg_143_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			local var_146_2 = 0
			local var_146_3 = 0.75

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_2 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_4 = arg_143_1:GetWordFromCfg(1109502039)
				local var_146_5 = arg_143_1:FormatText(var_146_4.content)

				arg_143_1.text_.text = var_146_5

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_7 = 30 <= 0 and var_146_3 or var_146_3 * (utf8.len(var_146_5) / 30)

				if (30 <= 0 and var_146_3 or var_146_3 * (utf8.len(var_146_5) / 30)) > 0 and var_146_3 < var_146_7 then
					arg_143_1.talkMaxDuration = var_146_7

					if var_146_7 + var_146_2 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_2
					end
				end

				arg_143_1.text_.text = var_146_5
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502039", "story_v_side_new_1109502.awb") ~= 0 then
					local var_146_8 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502039", "story_v_side_new_1109502.awb") / 1000

					if var_146_8 + var_146_2 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_2
					end

					if var_146_4.prefab_name ~= "" and arg_143_1.actors_[var_146_4.prefab_name] ~= nil then
						local var_146_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_4.prefab_name].transform, "story_v_side_new_1109502", "1109502039", "story_v_side_new_1109502.awb")

						arg_143_1:RecordAudio("1109502039", var_146_9)
						arg_143_1:RecordAudio("1109502039", var_146_9)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502039", "story_v_side_new_1109502.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502039", "story_v_side_new_1109502.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_10 = math.max(var_146_3, arg_143_1.talkMaxDuration)

			if var_146_2 <= arg_143_1.time_ and arg_143_1.time_ < var_146_2 + var_146_10 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_2) / var_146_10

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_2 + var_146_10 and arg_143_1.time_ < var_146_2 + var_146_10 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play1109502040 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 1109502040
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play1109502041(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["10058ui_story"]) and arg_147_1.var_.characterEffect10058ui_story == nil then
				arg_147_1.var_.characterEffect10058ui_story = arg_147_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_0 = 0.0166666666666667

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["10058ui_story"]) then
				if arg_147_1.var_.characterEffect10058ui_story and not isNil(arg_147_1.actors_["10058ui_story"]) then
					arg_147_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_147_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_0)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["10058ui_story"]) and arg_147_1.var_.characterEffect10058ui_story then
				arg_147_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_147_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_150_1 = 0
			local var_150_2 = 0.55

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
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

				local var_150_3 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(1109502040).content)

				arg_147_1.text_.text = var_150_3

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 22 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 22)

				if (22 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 22)) > 0 and var_150_2 < var_150_5 then
					arg_147_1.talkMaxDuration = var_150_5

					if var_150_5 + var_150_1 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + var_150_1
					end
				end

				arg_147_1.text_.text = var_150_3
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_6 = math.max(var_150_2, arg_147_1.talkMaxDuration)

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_6 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_1) / var_150_6

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_1 + var_150_6 and arg_147_1.time_ < var_150_1 + var_150_6 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play1109502041 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 1109502041
		arg_151_1.duration_ = 3.73

		local var_151_0 = {
			zh = 2.866,
			ja = 3.733
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
				arg_151_0:Play1109502042(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos10058ui_story = arg_151_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_154_0 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 then
				arg_151_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_151_1.time_ - 0) / var_154_0)
				arg_151_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["10058ui_story"].transform.position).z)
				arg_151_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["10058ui_story"].transform.localEulerAngles = arg_151_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 then
				arg_151_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_151_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["10058ui_story"].transform.position).z)
				arg_151_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["10058ui_story"].transform.localEulerAngles = arg_151_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_154_1 = arg_151_1.actors_["10058ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect10058ui_story == nil then
				arg_151_1.var_.characterEffect10058ui_story = var_154_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_2 and not isNil(var_154_1) then
				if arg_151_1.var_.characterEffect10058ui_story and not isNil(var_154_1) then
					arg_151_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_2 and arg_151_1.time_ < 0 + var_154_2 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect10058ui_story then
				arg_151_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_154_4 = 0
			local var_154_5 = 0.2

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_6 = arg_151_1:GetWordFromCfg(1109502041)
				local var_154_7 = arg_151_1:FormatText(var_154_6.content)

				arg_151_1.text_.text = var_154_7

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_9 = 8 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_7) / 8)

				if (8 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_7) / 8)) > 0 and var_154_5 < var_154_9 then
					arg_151_1.talkMaxDuration = var_154_9

					if var_154_9 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_9 + var_154_4
					end
				end

				arg_151_1.text_.text = var_154_7
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502041", "story_v_side_new_1109502.awb") ~= 0 then
					local var_154_10 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502041", "story_v_side_new_1109502.awb") / 1000

					if var_154_10 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_10 + var_154_4
					end

					if var_154_6.prefab_name ~= "" and arg_151_1.actors_[var_154_6.prefab_name] ~= nil then
						local var_154_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_6.prefab_name].transform, "story_v_side_new_1109502", "1109502041", "story_v_side_new_1109502.awb")

						arg_151_1:RecordAudio("1109502041", var_154_11)
						arg_151_1:RecordAudio("1109502041", var_154_11)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502041", "story_v_side_new_1109502.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502041", "story_v_side_new_1109502.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_12 = math.max(var_154_5, arg_151_1.talkMaxDuration)

			if var_154_4 <= arg_151_1.time_ and arg_151_1.time_ < var_154_4 + var_154_12 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_4) / var_154_12

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_4 + var_154_12 and arg_151_1.time_ < var_154_4 + var_154_12 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play1109502042 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 1109502042
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play1109502043(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["10058ui_story"]) and arg_155_1.var_.characterEffect10058ui_story == nil then
				arg_155_1.var_.characterEffect10058ui_story = arg_155_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_0 = 0.0166666666666667

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["10058ui_story"]) then
				if arg_155_1.var_.characterEffect10058ui_story and not isNil(arg_155_1.actors_["10058ui_story"]) then
					arg_155_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_155_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 0) / var_158_0)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["10058ui_story"]) and arg_155_1.var_.characterEffect10058ui_story then
				arg_155_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_155_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_158_1 = 0
			local var_158_2 = 0.325

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_3 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(1109502042).content)

				arg_155_1.text_.text = var_158_3

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 13 <= 0 and var_158_2 or var_158_2 * (utf8.len(var_158_3) / 13)

				if (13 <= 0 and var_158_2 or var_158_2 * (utf8.len(var_158_3) / 13)) > 0 and var_158_2 < var_158_5 then
					arg_155_1.talkMaxDuration = var_158_5

					if var_158_5 + var_158_1 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + var_158_1
					end
				end

				arg_155_1.text_.text = var_158_3
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_6 = math.max(var_158_2, arg_155_1.talkMaxDuration)

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_6 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_1) / var_158_6

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_1 + var_158_6 and arg_155_1.time_ < var_158_1 + var_158_6 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play1109502043 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 1109502043
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play1109502044(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos10058ui_story = arg_159_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_162_0 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 then
				arg_159_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_159_1.time_ - 0) / var_162_0)
				arg_159_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["10058ui_story"].transform.position).z)
				arg_159_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["10058ui_story"].transform.localEulerAngles = arg_159_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 then
				arg_159_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_159_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["10058ui_story"].transform.position).z)
				arg_159_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["10058ui_story"].transform.localEulerAngles = arg_159_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_162_1 = 0
			local var_162_2 = 1.475

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_3 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(1109502043).content)

				arg_159_1.text_.text = var_162_3

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 59 <= 0 and var_162_2 or var_162_2 * (utf8.len(var_162_3) / 59)

				if (59 <= 0 and var_162_2 or var_162_2 * (utf8.len(var_162_3) / 59)) > 0 and var_162_2 < var_162_5 then
					arg_159_1.talkMaxDuration = var_162_5

					if var_162_5 + var_162_1 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + var_162_1
					end
				end

				arg_159_1.text_.text = var_162_3
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_6 = math.max(var_162_2, arg_159_1.talkMaxDuration)

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_6 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_1) / var_162_6

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_1 + var_162_6 and arg_159_1.time_ < var_162_1 + var_162_6 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play1109502044 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 1109502044
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play1109502045(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0.25

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
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

				local var_166_1 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(1109502044).content)

				arg_163_1.text_.text = var_166_1

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_3 = 10 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 10)

				if (10 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 10)) > 0 and var_166_0 < var_166_3 then
					arg_163_1.talkMaxDuration = var_166_3

					if var_166_3 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_3 + 0
					end
				end

				arg_163_1.text_.text = var_166_1
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_4 = math.max(var_166_0, arg_163_1.talkMaxDuration)

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_4 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - 0) / var_166_4

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= 0 + var_166_4 and arg_163_1.time_ < 0 + var_166_4 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play1109502045 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 1109502045
		arg_167_1.duration_ = 10.7

		local var_167_0 = {
			zh = 7.233,
			ja = 10.7
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
				arg_167_0:Play1109502046(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos10058ui_story = arg_167_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_170_0 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 then
				arg_167_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_167_1.time_ - 0) / var_170_0)
				arg_167_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["10058ui_story"].transform.position).z)
				arg_167_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["10058ui_story"].transform.localEulerAngles = arg_167_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 then
				arg_167_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_167_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["10058ui_story"].transform.position).z)
				arg_167_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["10058ui_story"].transform.localEulerAngles = arg_167_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_170_1 = arg_167_1.actors_["10058ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect10058ui_story == nil then
				arg_167_1.var_.characterEffect10058ui_story = var_170_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_2 and not isNil(var_170_1) then
				if arg_167_1.var_.characterEffect10058ui_story and not isNil(var_170_1) then
					arg_167_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_2 and arg_167_1.time_ < 0 + var_170_2 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect10058ui_story then
				arg_167_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_170_4 = 0
			local var_170_5 = 0.875

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_4 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_6 = arg_167_1:GetWordFromCfg(1109502045)
				local var_170_7 = arg_167_1:FormatText(var_170_6.content)

				arg_167_1.text_.text = var_170_7

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_9 = 35 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_7) / 35)

				if (35 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_7) / 35)) > 0 and var_170_5 < var_170_9 then
					arg_167_1.talkMaxDuration = var_170_9

					if var_170_9 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_9 + var_170_4
					end
				end

				arg_167_1.text_.text = var_170_7
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502045", "story_v_side_new_1109502.awb") ~= 0 then
					local var_170_10 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502045", "story_v_side_new_1109502.awb") / 1000

					if var_170_10 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_10 + var_170_4
					end

					if var_170_6.prefab_name ~= "" and arg_167_1.actors_[var_170_6.prefab_name] ~= nil then
						local var_170_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_6.prefab_name].transform, "story_v_side_new_1109502", "1109502045", "story_v_side_new_1109502.awb")

						arg_167_1:RecordAudio("1109502045", var_170_11)
						arg_167_1:RecordAudio("1109502045", var_170_11)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502045", "story_v_side_new_1109502.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502045", "story_v_side_new_1109502.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_12 = math.max(var_170_5, arg_167_1.talkMaxDuration)

			if var_170_4 <= arg_167_1.time_ and arg_167_1.time_ < var_170_4 + var_170_12 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_4) / var_170_12

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_4 + var_170_12 and arg_167_1.time_ < var_170_4 + var_170_12 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play1109502046 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 1109502046
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play1109502047(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["10058ui_story"]) and arg_171_1.var_.characterEffect10058ui_story == nil then
				arg_171_1.var_.characterEffect10058ui_story = arg_171_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_0 = 0.2

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["10058ui_story"]) then
				if arg_171_1.var_.characterEffect10058ui_story and not isNil(arg_171_1.actors_["10058ui_story"]) then
					arg_171_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_171_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_0)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["10058ui_story"]) and arg_171_1.var_.characterEffect10058ui_story then
				arg_171_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_171_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_174_1 = 0
			local var_174_2 = 0.2

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_3 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(1109502046).content)

				arg_171_1.text_.text = var_174_3

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 8 <= 0 and var_174_2 or var_174_2 * (utf8.len(var_174_3) / 8)

				if (8 <= 0 and var_174_2 or var_174_2 * (utf8.len(var_174_3) / 8)) > 0 and var_174_2 < var_174_5 then
					arg_171_1.talkMaxDuration = var_174_5

					if var_174_5 + var_174_1 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + var_174_1
					end
				end

				arg_171_1.text_.text = var_174_3
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_6 = math.max(var_174_2, arg_171_1.talkMaxDuration)

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_6 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_1) / var_174_6

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_1 + var_174_6 and arg_171_1.time_ < var_174_1 + var_174_6 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play1109502047 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 1109502047
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play1109502048(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action6_2")
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_178_0 = 0
			local var_178_1 = 1.05

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_2 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(1109502047).content)

				arg_175_1.text_.text = var_178_2

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 42 <= 0 and var_178_1 or var_178_1 * (utf8.len(var_178_2) / 42)

				if (42 <= 0 and var_178_1 or var_178_1 * (utf8.len(var_178_2) / 42)) > 0 and var_178_1 < var_178_4 then
					arg_175_1.talkMaxDuration = var_178_4

					if var_178_4 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_4 + var_178_0
					end
				end

				arg_175_1.text_.text = var_178_2
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_5 = math.max(var_178_1, arg_175_1.talkMaxDuration)

			if var_178_0 <= arg_175_1.time_ and arg_175_1.time_ < var_178_0 + var_178_5 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_0) / var_178_5

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_0 + var_178_5 and arg_175_1.time_ < var_178_0 + var_178_5 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play1109502048 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 1109502048
		arg_179_1.duration_ = 5.77

		local var_179_0 = {
			zh = 3.433,
			ja = 5.766
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
				arg_179_0:Play1109502049(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_182_0 = 0
			local var_182_1 = 0.325

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_2 = arg_179_1:GetWordFromCfg(1109502048)
				local var_182_3 = arg_179_1:FormatText(var_182_2.content)

				arg_179_1.text_.text = var_182_3

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 13 <= 0 and var_182_1 or var_182_1 * (utf8.len(var_182_3) / 13)

				if (13 <= 0 and var_182_1 or var_182_1 * (utf8.len(var_182_3) / 13)) > 0 and var_182_1 < var_182_5 then
					arg_179_1.talkMaxDuration = var_182_5

					if var_182_5 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_5 + var_182_0
					end
				end

				arg_179_1.text_.text = var_182_3
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502048", "story_v_side_new_1109502.awb") ~= 0 then
					local var_182_6 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502048", "story_v_side_new_1109502.awb") / 1000

					if var_182_6 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_6 + var_182_0
					end

					if var_182_2.prefab_name ~= "" and arg_179_1.actors_[var_182_2.prefab_name] ~= nil then
						local var_182_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_2.prefab_name].transform, "story_v_side_new_1109502", "1109502048", "story_v_side_new_1109502.awb")

						arg_179_1:RecordAudio("1109502048", var_182_7)
						arg_179_1:RecordAudio("1109502048", var_182_7)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502048", "story_v_side_new_1109502.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502048", "story_v_side_new_1109502.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_8 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_8 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_0) / var_182_8

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_8 and arg_179_1.time_ < var_182_0 + var_182_8 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play1109502049 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 1109502049
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play1109502050(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos10058ui_story = arg_183_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_186_0 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 then
				arg_183_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_183_1.time_ - 0) / var_186_0)
				arg_183_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["10058ui_story"].transform.position).z)
				arg_183_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["10058ui_story"].transform.localEulerAngles = arg_183_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 then
				arg_183_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_183_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["10058ui_story"].transform.position).z)
				arg_183_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["10058ui_story"].transform.localEulerAngles = arg_183_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_186_1 = 0
			local var_186_2 = 0.825

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_3 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(1109502049).content)

				arg_183_1.text_.text = var_186_3

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 33 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_3) / 33)

				if (33 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_3) / 33)) > 0 and var_186_2 < var_186_5 then
					arg_183_1.talkMaxDuration = var_186_5

					if var_186_5 + var_186_1 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + var_186_1
					end
				end

				arg_183_1.text_.text = var_186_3
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_6 = math.max(var_186_2, arg_183_1.talkMaxDuration)

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_6 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_1) / var_186_6

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_1 + var_186_6 and arg_183_1.time_ < var_186_1 + var_186_6 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play1109502050 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1109502050
		arg_187_1.duration_ = 8.43

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play1109502051(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				local var_190_0 = arg_187_1.bgs_.ST28

				arg_187_1.bgs_.ST28.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_190_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_190_1 = var_190_0:GetComponent("SpriteRenderer")

				if var_190_1 and var_190_1.sprite then
					local var_190_2 = 2 * (var_190_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_190_0.transform.localScale = Vector3.New(var_190_2 / var_190_1.sprite.bounds.size.y < var_190_2 * manager.ui.mainCameraCom_.aspect / var_190_1.sprite.bounds.size.x and var_190_2 * manager.ui.mainCameraCom_.aspect / var_190_1.sprite.bounds.size.x or var_190_2 / var_190_1.sprite.bounds.size.y, var_190_2 / var_190_1.sprite.bounds.size.y < var_190_2 * manager.ui.mainCameraCom_.aspect / var_190_1.sprite.bounds.size.x and var_190_2 * manager.ui.mainCameraCom_.aspect / var_190_1.sprite.bounds.size.x or var_190_2 / var_190_1.sprite.bounds.size.y, 0)
				end

				for iter_190_0, iter_190_1 in pairs(arg_187_1.bgs_) do
					if iter_190_0 ~= "ST28" then
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

			local var_190_4 = 1.999999999999

			if var_190_3 <= arg_187_1.time_ and arg_187_1.time_ < var_190_3 + var_190_4 then
				local var_190_5 = Color.New(0, 0, 0)

				var_190_5.a = Mathf.Lerp(0, 1, (arg_187_1.time_ - var_190_3) / var_190_4)
				arg_187_1.mask_.color = var_190_5
			end

			if arg_187_1.time_ >= var_190_3 + var_190_4 and arg_187_1.time_ < var_190_3 + var_190_4 + arg_190_0 then
				local var_190_6 = Color.New(0, 0, 0)

				var_190_6.a = 1
				arg_187_1.mask_.color = var_190_6
			end

			local var_190_7 = 1.999999999999

			if 1.999999999999 < arg_187_1.time_ and arg_187_1.time_ <= var_190_7 + arg_190_0 then
				arg_187_1.mask_.enabled = true
				arg_187_1.mask_.raycastTarget = true

				arg_187_1:SetGaussion(false)
			end

			local var_190_8 = 1.5

			if var_190_7 <= arg_187_1.time_ and arg_187_1.time_ < var_190_7 + var_190_8 then
				local var_190_9 = Color.New(0, 0, 0)

				var_190_9.a = Mathf.Lerp(1, 0, (arg_187_1.time_ - var_190_7) / var_190_8)
				arg_187_1.mask_.color = var_190_9
			end

			if arg_187_1.time_ >= var_190_7 + var_190_8 and arg_187_1.time_ < var_190_7 + var_190_8 + arg_190_0 then
				local var_190_10 = Color.New(0, 0, 0)

				arg_187_1.mask_.enabled = false
				var_190_10.a = 0
				arg_187_1.mask_.color = var_190_10
			end

			if arg_187_1.frameCnt_ <= 1 then
				arg_187_1.dialog_:SetActive(false)
			end

			local var_190_11 = 3.43333333333333
			local var_190_12 = 0.966666666666667

			if 3.43333333333333 < arg_187_1.time_ and arg_187_1.time_ <= var_190_11 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0

				arg_187_1.dialog_:SetActive(true)

				arg_187_1.dialogCg_.alpha = 0

				local var_190_13 = LeanTween.value(arg_187_1.dialog_, 0, 1, 0.3)

				var_190_13:setOnUpdate(LuaHelper.FloatAction(function(arg_191_0)
					arg_187_1.dialogCg_.alpha = arg_191_0
				end))
				var_190_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_187_1.dialog_)
					var_190_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_187_1.duration_ = arg_187_1.duration_ + 0.3

				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_14 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(1109502050).content)

				arg_187_1.text_.text = var_190_14

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_16 = 43 <= 0 and var_190_12 or var_190_12 * (utf8.len(var_190_14) / 43)

				if (43 <= 0 and var_190_12 or var_190_12 * (utf8.len(var_190_14) / 43)) > 0 and var_190_12 < var_190_16 then
					arg_187_1.talkMaxDuration = var_190_16
					var_190_11 = var_190_11 + 0.3

					if var_190_16 + var_190_11 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_16 + var_190_11
					end
				end

				arg_187_1.text_.text = var_190_14
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_17 = var_190_11 + 0.3
			local var_190_18 = math.max(var_190_12, arg_187_1.talkMaxDuration)

			if var_190_11 + 0.3 <= arg_187_1.time_ and arg_187_1.time_ < var_190_17 + var_190_18 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_17) / var_190_18

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_17 + var_190_18 and arg_187_1.time_ < var_190_17 + var_190_18 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play1109502051 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 1109502051
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play1109502052(arg_193_1)
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

				local var_196_1 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(1109502051).content)

				arg_193_1.text_.text = var_196_1

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_3 = 30 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 30)

				if (30 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 30)) > 0 and var_196_0 < var_196_3 then
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
	Play1109502052 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 1109502052
		arg_197_1.duration_ = 7

		local var_197_0 = {
			zh = 6.366,
			ja = 7
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
				arg_197_0:Play1109502053(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0
			local var_200_1 = 0.675

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0

				arg_197_1.dialog_:SetActive(true)

				arg_197_1.dialogCg_.alpha = 0

				local var_200_2 = LeanTween.value(arg_197_1.dialog_, 0, 1, 0.3)

				var_200_2:setOnUpdate(LuaHelper.FloatAction(function(arg_201_0)
					arg_197_1.dialogCg_.alpha = arg_201_0
				end))
				var_200_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_197_1.dialog_)
					var_200_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_197_1.duration_ = arg_197_1.duration_ + 0.3

				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_3 = arg_197_1:GetWordFromCfg(1109502052)
				local var_200_4 = arg_197_1:FormatText(var_200_3.content)

				arg_197_1.text_.text = var_200_4

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_6 = 27 <= 0 and var_200_1 or var_200_1 * (utf8.len(var_200_4) / 27)

				if (27 <= 0 and var_200_1 or var_200_1 * (utf8.len(var_200_4) / 27)) > 0 and var_200_1 < var_200_6 then
					arg_197_1.talkMaxDuration = var_200_6
					var_200_0 = var_200_0 + 0.3

					if var_200_6 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_6 + var_200_0
					end
				end

				arg_197_1.text_.text = var_200_4
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502052", "story_v_side_new_1109502.awb") ~= 0 then
					local var_200_7 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502052", "story_v_side_new_1109502.awb") / 1000

					if var_200_7 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_7 + var_200_0
					end

					if var_200_3.prefab_name ~= "" and arg_197_1.actors_[var_200_3.prefab_name] ~= nil then
						local var_200_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_3.prefab_name].transform, "story_v_side_new_1109502", "1109502052", "story_v_side_new_1109502.awb")

						arg_197_1:RecordAudio("1109502052", var_200_8)
						arg_197_1:RecordAudio("1109502052", var_200_8)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502052", "story_v_side_new_1109502.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502052", "story_v_side_new_1109502.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_9 = var_200_0 + 0.3
			local var_200_10 = math.max(var_200_1, arg_197_1.talkMaxDuration)

			if var_200_0 + 0.3 <= arg_197_1.time_ and arg_197_1.time_ < var_200_9 + var_200_10 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_9) / var_200_10

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_9 + var_200_10 and arg_197_1.time_ < var_200_9 + var_200_10 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play1109502053 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 1109502053
		arg_203_1.duration_ = 5.77

		local var_203_0 = {
			zh = 5.633,
			ja = 5.766
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
				arg_203_0:Play1109502054(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_206_0 = 0.6

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 then
				local var_206_1, var_206_2 = math.modf((arg_203_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_206_2 * 0.13, var_206_2 * 0.13, var_206_2 * 0.13) + arg_203_1.var_.shakeOldPos
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 then
				manager.ui.mainCamera.transform.localPosition = arg_203_1.var_.shakeOldPos
			end

			local var_206_3 = 0

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_3 + arg_206_0 then
				arg_203_1.allBtn_.enabled = false
			end

			if arg_203_1.time_ >= var_206_3 + 0.6 and arg_203_1.time_ < var_206_3 + 0.6 + arg_206_0 then
				arg_203_1.allBtn_.enabled = true
			end

			local var_206_4 = 0
			local var_206_5 = 0.5

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_6 = arg_203_1:GetWordFromCfg(1109502053)
				local var_206_7 = arg_203_1:FormatText(var_206_6.content)

				arg_203_1.text_.text = var_206_7

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_9 = 20 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 20)

				if (20 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 20)) > 0 and var_206_5 < var_206_9 then
					arg_203_1.talkMaxDuration = var_206_9

					if var_206_9 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_9 + var_206_4
					end
				end

				arg_203_1.text_.text = var_206_7
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502053", "story_v_side_new_1109502.awb") ~= 0 then
					local var_206_10 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502053", "story_v_side_new_1109502.awb") / 1000

					if var_206_10 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_10 + var_206_4
					end

					if var_206_6.prefab_name ~= "" and arg_203_1.actors_[var_206_6.prefab_name] ~= nil then
						local var_206_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_6.prefab_name].transform, "story_v_side_new_1109502", "1109502053", "story_v_side_new_1109502.awb")

						arg_203_1:RecordAudio("1109502053", var_206_11)
						arg_203_1:RecordAudio("1109502053", var_206_11)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502053", "story_v_side_new_1109502.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502053", "story_v_side_new_1109502.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_12 = math.max(var_206_5, arg_203_1.talkMaxDuration)

			if var_206_4 <= arg_203_1.time_ and arg_203_1.time_ < var_206_4 + var_206_12 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_4) / var_206_12

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_4 + var_206_12 and arg_203_1.time_ < var_206_4 + var_206_12 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play1109502054 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 1109502054
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play1109502055(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 1.15

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_1 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(1109502054).content)

				arg_207_1.text_.text = var_210_1

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_3 = 46 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_1) / 46)

				if (46 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_1) / 46)) > 0 and var_210_0 < var_210_3 then
					arg_207_1.talkMaxDuration = var_210_3

					if var_210_3 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_3 + 0
					end
				end

				arg_207_1.text_.text = var_210_1
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_4 = math.max(var_210_0, arg_207_1.talkMaxDuration)

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_4 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - 0) / var_210_4

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= 0 + var_210_4 and arg_207_1.time_ < 0 + var_210_4 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play1109502055 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 1109502055
		arg_211_1.duration_ = 4.1

		local var_211_0 = {
			zh = 1.999999999999,
			ja = 4.1
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
				arg_211_0:Play1109502056(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos10058ui_story = arg_211_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_214_0 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 then
				arg_211_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_211_1.time_ - 0) / var_214_0)
				arg_211_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["10058ui_story"].transform.position).z)
				arg_211_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["10058ui_story"].transform.localEulerAngles = arg_211_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 then
				arg_211_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_211_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["10058ui_story"].transform.position).z)
				arg_211_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["10058ui_story"].transform.localEulerAngles = arg_211_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_214_1 = arg_211_1.actors_["10058ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect10058ui_story == nil then
				arg_211_1.var_.characterEffect10058ui_story = var_214_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_2 and not isNil(var_214_1) then
				if arg_211_1.var_.characterEffect10058ui_story and not isNil(var_214_1) then
					arg_211_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 0 + var_214_2 and arg_211_1.time_ < 0 + var_214_2 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect10058ui_story then
				arg_211_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action5_1")
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_214_4 = 0
			local var_214_5 = 0.075

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_4 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_6 = arg_211_1:GetWordFromCfg(1109502055)
				local var_214_7 = arg_211_1:FormatText(var_214_6.content)

				arg_211_1.text_.text = var_214_7

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_9 = 3 <= 0 and var_214_5 or var_214_5 * (utf8.len(var_214_7) / 3)

				if (3 <= 0 and var_214_5 or var_214_5 * (utf8.len(var_214_7) / 3)) > 0 and var_214_5 < var_214_9 then
					arg_211_1.talkMaxDuration = var_214_9

					if var_214_9 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_9 + var_214_4
					end
				end

				arg_211_1.text_.text = var_214_7
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502055", "story_v_side_new_1109502.awb") ~= 0 then
					local var_214_10 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502055", "story_v_side_new_1109502.awb") / 1000

					if var_214_10 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_10 + var_214_4
					end

					if var_214_6.prefab_name ~= "" and arg_211_1.actors_[var_214_6.prefab_name] ~= nil then
						local var_214_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_6.prefab_name].transform, "story_v_side_new_1109502", "1109502055", "story_v_side_new_1109502.awb")

						arg_211_1:RecordAudio("1109502055", var_214_11)
						arg_211_1:RecordAudio("1109502055", var_214_11)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502055", "story_v_side_new_1109502.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502055", "story_v_side_new_1109502.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_12 = math.max(var_214_5, arg_211_1.talkMaxDuration)

			if var_214_4 <= arg_211_1.time_ and arg_211_1.time_ < var_214_4 + var_214_12 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_4) / var_214_12

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_4 + var_214_12 and arg_211_1.time_ < var_214_4 + var_214_12 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play1109502056 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 1109502056
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play1109502057(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(arg_215_1.actors_["10058ui_story"]) and arg_215_1.var_.characterEffect10058ui_story == nil then
				arg_215_1.var_.characterEffect10058ui_story = arg_215_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_0 = 0.2

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 and not isNil(arg_215_1.actors_["10058ui_story"]) then
				if arg_215_1.var_.characterEffect10058ui_story and not isNil(arg_215_1.actors_["10058ui_story"]) then
					arg_215_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_215_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_215_1.time_ - 0) / var_218_0)
				end
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 and not isNil(arg_215_1.actors_["10058ui_story"]) and arg_215_1.var_.characterEffect10058ui_story then
				arg_215_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_215_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_218_1 = 0
			local var_218_2 = 0.575

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

				local var_218_3 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(1109502056).content)

				arg_215_1.text_.text = var_218_3

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_5 = 23 <= 0 and var_218_2 or var_218_2 * (utf8.len(var_218_3) / 23)

				if (23 <= 0 and var_218_2 or var_218_2 * (utf8.len(var_218_3) / 23)) > 0 and var_218_2 < var_218_5 then
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
	Play1109502057 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 1109502057
		arg_219_1.duration_ = 2.53

		local var_219_0 = {
			zh = 1.466,
			ja = 2.533
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play1109502058(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(arg_219_1.actors_["10058ui_story"]) and arg_219_1.var_.characterEffect10058ui_story == nil then
				arg_219_1.var_.characterEffect10058ui_story = arg_219_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_0 = 0.2

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 and not isNil(arg_219_1.actors_["10058ui_story"]) then
				if arg_219_1.var_.characterEffect10058ui_story and not isNil(arg_219_1.actors_["10058ui_story"]) then
					arg_219_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 and not isNil(arg_219_1.actors_["10058ui_story"]) and arg_219_1.var_.characterEffect10058ui_story then
				arg_219_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_222_2 = 0
			local var_222_3 = 0.125

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_2 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_4 = arg_219_1:GetWordFromCfg(1109502057)
				local var_222_5 = arg_219_1:FormatText(var_222_4.content)

				arg_219_1.text_.text = var_222_5

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_7 = 5 <= 0 and var_222_3 or var_222_3 * (utf8.len(var_222_5) / 5)

				if (5 <= 0 and var_222_3 or var_222_3 * (utf8.len(var_222_5) / 5)) > 0 and var_222_3 < var_222_7 then
					arg_219_1.talkMaxDuration = var_222_7

					if var_222_7 + var_222_2 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_7 + var_222_2
					end
				end

				arg_219_1.text_.text = var_222_5
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502057", "story_v_side_new_1109502.awb") ~= 0 then
					local var_222_8 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502057", "story_v_side_new_1109502.awb") / 1000

					if var_222_8 + var_222_2 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_8 + var_222_2
					end

					if var_222_4.prefab_name ~= "" and arg_219_1.actors_[var_222_4.prefab_name] ~= nil then
						local var_222_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_4.prefab_name].transform, "story_v_side_new_1109502", "1109502057", "story_v_side_new_1109502.awb")

						arg_219_1:RecordAudio("1109502057", var_222_9)
						arg_219_1:RecordAudio("1109502057", var_222_9)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502057", "story_v_side_new_1109502.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502057", "story_v_side_new_1109502.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_10 = math.max(var_222_3, arg_219_1.talkMaxDuration)

			if var_222_2 <= arg_219_1.time_ and arg_219_1.time_ < var_222_2 + var_222_10 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_2) / var_222_10

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_2 + var_222_10 and arg_219_1.time_ < var_222_2 + var_222_10 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play1109502058 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 1109502058
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play1109502059(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos10058ui_story = arg_223_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_226_0 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 then
				arg_223_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_223_1.time_ - 0) / var_226_0)
				arg_223_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["10058ui_story"].transform.position).z)
				arg_223_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["10058ui_story"].transform.localEulerAngles = arg_223_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 then
				arg_223_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_223_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["10058ui_story"].transform.position).z)
				arg_223_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["10058ui_story"].transform.localEulerAngles = arg_223_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_226_1 = 0
			local var_226_2 = 0.375

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
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

				local var_226_3 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(1109502058).content)

				arg_223_1.text_.text = var_226_3

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_5 = 15 <= 0 and var_226_2 or var_226_2 * (utf8.len(var_226_3) / 15)

				if (15 <= 0 and var_226_2 or var_226_2 * (utf8.len(var_226_3) / 15)) > 0 and var_226_2 < var_226_5 then
					arg_223_1.talkMaxDuration = var_226_5

					if var_226_5 + var_226_1 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_5 + var_226_1
					end
				end

				arg_223_1.text_.text = var_226_3
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_6 = math.max(var_226_2, arg_223_1.talkMaxDuration)

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_6 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_1) / var_226_6

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_1 + var_226_6 and arg_223_1.time_ < var_226_1 + var_226_6 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play1109502059 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 1109502059
		arg_227_1.duration_ = 6.7

		local var_227_0 = {
			zh = 4.1,
			ja = 6.7
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
				arg_227_0:Play1109502060(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0.275

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[663].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_1 = arg_227_1:GetWordFromCfg(1109502059)
				local var_230_2 = arg_227_1:FormatText(var_230_1.content)

				arg_227_1.text_.text = var_230_2

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_4 = 11 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 11)

				if (11 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 11)) > 0 and var_230_0 < var_230_4 then
					arg_227_1.talkMaxDuration = var_230_4

					if var_230_4 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_4 + 0
					end
				end

				arg_227_1.text_.text = var_230_2
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502059", "story_v_side_new_1109502.awb") ~= 0 then
					local var_230_5 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502059", "story_v_side_new_1109502.awb") / 1000

					if var_230_5 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + 0
					end

					if var_230_1.prefab_name ~= "" and arg_227_1.actors_[var_230_1.prefab_name] ~= nil then
						local var_230_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_1.prefab_name].transform, "story_v_side_new_1109502", "1109502059", "story_v_side_new_1109502.awb")

						arg_227_1:RecordAudio("1109502059", var_230_6)
						arg_227_1:RecordAudio("1109502059", var_230_6)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502059", "story_v_side_new_1109502.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502059", "story_v_side_new_1109502.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_7 = math.max(var_230_0, arg_227_1.talkMaxDuration)

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_7 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - 0) / var_230_7

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= 0 + var_230_7 and arg_227_1.time_ < 0 + var_230_7 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play1109502060 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 1109502060
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play1109502061(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0.95

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_1 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(1109502060).content)

				arg_231_1.text_.text = var_234_1

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_3 = 38 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_1) / 38)

				if (38 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_1) / 38)) > 0 and var_234_0 < var_234_3 then
					arg_231_1.talkMaxDuration = var_234_3

					if var_234_3 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_3 + 0
					end
				end

				arg_231_1.text_.text = var_234_1
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_4 = math.max(var_234_0, arg_231_1.talkMaxDuration)

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_4 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - 0) / var_234_4

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= 0 + var_234_4 and arg_231_1.time_ < 0 + var_234_4 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play1109502061 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 1109502061
		arg_235_1.duration_ = 7.7

		local var_235_0 = {
			zh = 5.166,
			ja = 7.7
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
				arg_235_0:Play1109502062(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0.6

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[664].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_1 = arg_235_1:GetWordFromCfg(1109502061)
				local var_238_2 = arg_235_1:FormatText(var_238_1.content)

				arg_235_1.text_.text = var_238_2

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_4 = 24 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 24)

				if (24 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 24)) > 0 and var_238_0 < var_238_4 then
					arg_235_1.talkMaxDuration = var_238_4

					if var_238_4 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_4 + 0
					end
				end

				arg_235_1.text_.text = var_238_2
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502061", "story_v_side_new_1109502.awb") ~= 0 then
					local var_238_5 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502061", "story_v_side_new_1109502.awb") / 1000

					if var_238_5 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_5 + 0
					end

					if var_238_1.prefab_name ~= "" and arg_235_1.actors_[var_238_1.prefab_name] ~= nil then
						local var_238_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_1.prefab_name].transform, "story_v_side_new_1109502", "1109502061", "story_v_side_new_1109502.awb")

						arg_235_1:RecordAudio("1109502061", var_238_6)
						arg_235_1:RecordAudio("1109502061", var_238_6)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502061", "story_v_side_new_1109502.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502061", "story_v_side_new_1109502.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_7 = math.max(var_238_0, arg_235_1.talkMaxDuration)

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_7 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - 0) / var_238_7

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= 0 + var_238_7 and arg_235_1.time_ < 0 + var_238_7 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play1109502062 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 1109502062
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play1109502063(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0.225

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_1 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(1109502062).content)

				arg_239_1.text_.text = var_242_1

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_3 = 9 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 9)

				if (9 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 9)) > 0 and var_242_0 < var_242_3 then
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
	Play1109502063 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 1109502063
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play1109502064(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0.6

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_1 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(1109502063).content)

				arg_243_1.text_.text = var_246_1

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_3 = 24 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_1) / 24)

				if (24 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_1) / 24)) > 0 and var_246_0 < var_246_3 then
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
	Play1109502064 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 1109502064
		arg_247_1.duration_ = 5.17

		local var_247_0 = {
			zh = 2.466,
			ja = 5.166
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
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play1109502065(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0.3

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[664].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_1 = arg_247_1:GetWordFromCfg(1109502064)
				local var_250_2 = arg_247_1:FormatText(var_250_1.content)

				arg_247_1.text_.text = var_250_2

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_4 = 12 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 12)

				if (12 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 12)) > 0 and var_250_0 < var_250_4 then
					arg_247_1.talkMaxDuration = var_250_4

					if var_250_4 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_4 + 0
					end
				end

				arg_247_1.text_.text = var_250_2
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502064", "story_v_side_new_1109502.awb") ~= 0 then
					local var_250_5 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502064", "story_v_side_new_1109502.awb") / 1000

					if var_250_5 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_5 + 0
					end

					if var_250_1.prefab_name ~= "" and arg_247_1.actors_[var_250_1.prefab_name] ~= nil then
						local var_250_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_1.prefab_name].transform, "story_v_side_new_1109502", "1109502064", "story_v_side_new_1109502.awb")

						arg_247_1:RecordAudio("1109502064", var_250_6)
						arg_247_1:RecordAudio("1109502064", var_250_6)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502064", "story_v_side_new_1109502.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502064", "story_v_side_new_1109502.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_7 = math.max(var_250_0, arg_247_1.talkMaxDuration)

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_7 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - 0) / var_250_7

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= 0 + var_250_7 and arg_247_1.time_ < 0 + var_250_7 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play1109502065 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 1109502065
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play1109502066(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0.325

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_1 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(1109502065).content)

				arg_251_1.text_.text = var_254_1

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_3 = 13 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_1) / 13)

				if (13 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_1) / 13)) > 0 and var_254_0 < var_254_3 then
					arg_251_1.talkMaxDuration = var_254_3

					if var_254_3 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_3 + 0
					end
				end

				arg_251_1.text_.text = var_254_1
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_4 = math.max(var_254_0, arg_251_1.talkMaxDuration)

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_4 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - 0) / var_254_4

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= 0 + var_254_4 and arg_251_1.time_ < 0 + var_254_4 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play1109502066 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 1109502066
		arg_255_1.duration_ = 8.7

		local var_255_0 = {
			zh = 7.633,
			ja = 8.7
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play1109502067(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 1.025

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[664].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_1 = arg_255_1:GetWordFromCfg(1109502066)
				local var_258_2 = arg_255_1:FormatText(var_258_1.content)

				arg_255_1.text_.text = var_258_2

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_4 = 41 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 41)

				if (41 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 41)) > 0 and var_258_0 < var_258_4 then
					arg_255_1.talkMaxDuration = var_258_4

					if var_258_4 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_4 + 0
					end
				end

				arg_255_1.text_.text = var_258_2
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502066", "story_v_side_new_1109502.awb") ~= 0 then
					local var_258_5 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502066", "story_v_side_new_1109502.awb") / 1000

					if var_258_5 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + 0
					end

					if var_258_1.prefab_name ~= "" and arg_255_1.actors_[var_258_1.prefab_name] ~= nil then
						local var_258_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_1.prefab_name].transform, "story_v_side_new_1109502", "1109502066", "story_v_side_new_1109502.awb")

						arg_255_1:RecordAudio("1109502066", var_258_6)
						arg_255_1:RecordAudio("1109502066", var_258_6)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502066", "story_v_side_new_1109502.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502066", "story_v_side_new_1109502.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_7 = math.max(var_258_0, arg_255_1.talkMaxDuration)

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_7 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - 0) / var_258_7

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= 0 + var_258_7 and arg_255_1.time_ < 0 + var_258_7 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play1109502067 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 1109502067
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play1109502068(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0.2

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, true)
				arg_259_1.iconController_:SetSelectedState("hero")

				arg_259_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_259_1.callingController_:SetSelectedState("normal")

				arg_259_1.keyicon_.color = Color.New(1, 1, 1)
				arg_259_1.icon_.color = Color.New(1, 1, 1)

				local var_262_1 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(1109502067).content)

				arg_259_1.text_.text = var_262_1

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_3 = 8 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_1) / 8)

				if (8 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_1) / 8)) > 0 and var_262_0 < var_262_3 then
					arg_259_1.talkMaxDuration = var_262_3

					if var_262_3 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_3 + 0
					end
				end

				arg_259_1.text_.text = var_262_1
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_4 = math.max(var_262_0, arg_259_1.talkMaxDuration)

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_4 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - 0) / var_262_4

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= 0 + var_262_4 and arg_259_1.time_ < 0 + var_262_4 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play1109502068 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 1109502068
		arg_263_1.duration_ = 7

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play1109502069(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				local var_266_0 = arg_263_1.bgs_.ST28

				arg_263_1.bgs_.ST28.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_266_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_266_1 = var_266_0:GetComponent("SpriteRenderer")

				if var_266_1 and var_266_1.sprite then
					local var_266_2 = 2 * (var_266_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_266_0.transform.localScale = Vector3.New(var_266_2 / var_266_1.sprite.bounds.size.y < var_266_2 * manager.ui.mainCameraCom_.aspect / var_266_1.sprite.bounds.size.x and var_266_2 * manager.ui.mainCameraCom_.aspect / var_266_1.sprite.bounds.size.x or var_266_2 / var_266_1.sprite.bounds.size.y, var_266_2 / var_266_1.sprite.bounds.size.y < var_266_2 * manager.ui.mainCameraCom_.aspect / var_266_1.sprite.bounds.size.x and var_266_2 * manager.ui.mainCameraCom_.aspect / var_266_1.sprite.bounds.size.x or var_266_2 / var_266_1.sprite.bounds.size.y, 0)
				end

				for iter_266_0, iter_266_1 in pairs(arg_263_1.bgs_) do
					if iter_266_0 ~= "ST28" then
						iter_266_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_266_3 = 0

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_3 + arg_266_0 then
				arg_263_1.mask_.enabled = true
				arg_263_1.mask_.raycastTarget = true

				arg_263_1:SetGaussion(false)
			end

			local var_266_4 = 2

			if var_266_3 <= arg_263_1.time_ and arg_263_1.time_ < var_266_3 + var_266_4 then
				local var_266_5 = Color.New(0, 0, 0)

				var_266_5.a = Mathf.Lerp(0, 1, (arg_263_1.time_ - var_266_3) / var_266_4)
				arg_263_1.mask_.color = var_266_5
			end

			if arg_263_1.time_ >= var_266_3 + var_266_4 and arg_263_1.time_ < var_266_3 + var_266_4 + arg_266_0 then
				local var_266_6 = Color.New(0, 0, 0)

				var_266_6.a = 1
				arg_263_1.mask_.color = var_266_6
			end

			local var_266_7 = 2

			if 2 < arg_263_1.time_ and arg_263_1.time_ <= var_266_7 + arg_266_0 then
				arg_263_1.mask_.enabled = true
				arg_263_1.mask_.raycastTarget = true

				arg_263_1:SetGaussion(false)
			end

			local var_266_8 = 1.76666666666667

			if var_266_7 <= arg_263_1.time_ and arg_263_1.time_ < var_266_7 + var_266_8 then
				local var_266_9 = Color.New(0, 0, 0)

				var_266_9.a = Mathf.Lerp(1, 0, (arg_263_1.time_ - var_266_7) / var_266_8)
				arg_263_1.mask_.color = var_266_9
			end

			if arg_263_1.time_ >= var_266_7 + var_266_8 and arg_263_1.time_ < var_266_7 + var_266_8 + arg_266_0 then
				local var_266_10 = Color.New(0, 0, 0)

				arg_263_1.mask_.enabled = false
				var_266_10.a = 0
				arg_263_1.mask_.color = var_266_10
			end

			local var_266_11 = arg_263_1.actors_["10058ui_story"].transform

			if 2 < arg_263_1.time_ and arg_263_1.time_ <= 2 + arg_266_0 then
				arg_263_1.var_.moveOldPos10058ui_story = var_266_11.localPosition
			end

			local var_266_12 = 0.001

			if 2 <= arg_263_1.time_ and arg_263_1.time_ < 2 + var_266_12 then
				var_266_11.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_263_1.time_ - 2) / var_266_12)
				var_266_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_266_11.position).x, (manager.ui.mainCamera.transform.position - var_266_11.position).y, (manager.ui.mainCamera.transform.position - var_266_11.position).z)
				var_266_11.localEulerAngles.z = 0
				var_266_11.localEulerAngles.x = 0
				var_266_11.localEulerAngles = var_266_11.localEulerAngles
			end

			if arg_263_1.time_ >= 2 + var_266_12 and arg_263_1.time_ < 2 + var_266_12 + arg_266_0 then
				var_266_11.localPosition = Vector3.New(0, -0.98, -6.1)
				var_266_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_266_11.position).x, (manager.ui.mainCamera.transform.position - var_266_11.position).y, (manager.ui.mainCamera.transform.position - var_266_11.position).z)
				var_266_11.localEulerAngles.z = 0
				var_266_11.localEulerAngles.x = 0
				var_266_11.localEulerAngles = var_266_11.localEulerAngles
			end

			local var_266_13 = arg_263_1.actors_["10058ui_story"]

			if 2 < arg_263_1.time_ and arg_263_1.time_ <= 2 + arg_266_0 and not isNil(var_266_13) and arg_263_1.var_.characterEffect10058ui_story == nil then
				arg_263_1.var_.characterEffect10058ui_story = var_266_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_14 = 0.2

			if 2 <= arg_263_1.time_ and arg_263_1.time_ < 2 + var_266_14 and not isNil(var_266_13) then
				if arg_263_1.var_.characterEffect10058ui_story and not isNil(var_266_13) then
					arg_263_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= 2 + var_266_14 and arg_263_1.time_ < 2 + var_266_14 + arg_266_0 and not isNil(var_266_13) and arg_263_1.var_.characterEffect10058ui_story then
				arg_263_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 2 < arg_263_1.time_ and arg_263_1.time_ <= 2 + arg_266_0 then
				arg_263_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 2 < arg_263_1.time_ and arg_263_1.time_ <= 2 + arg_266_0 then
				arg_263_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			if arg_263_1.frameCnt_ <= 1 then
				arg_263_1.dialog_:SetActive(false)
			end

			local var_266_16 = 2
			local var_266_17 = 1.125

			if 2 < arg_263_1.time_ and arg_263_1.time_ <= var_266_16 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0

				arg_263_1.dialog_:SetActive(true)

				arg_263_1.dialogCg_.alpha = 0

				local var_266_18 = LeanTween.value(arg_263_1.dialog_, 0, 1, 0.3)

				var_266_18:setOnUpdate(LuaHelper.FloatAction(function(arg_267_0)
					arg_263_1.dialogCg_.alpha = arg_267_0
				end))
				var_266_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_263_1.dialog_)
					var_266_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_263_1.duration_ = arg_263_1.duration_ + 0.3

				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, true)
				arg_263_1.iconController_:SetSelectedState("hero")

				arg_263_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_263_1.callingController_:SetSelectedState("normal")

				arg_263_1.keyicon_.color = Color.New(1, 1, 1)
				arg_263_1.icon_.color = Color.New(1, 1, 1)

				local var_266_19 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(1109502068).content)

				arg_263_1.text_.text = var_266_19

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_21 = 45 <= 0 and var_266_17 or var_266_17 * (utf8.len(var_266_19) / 45)

				if (45 <= 0 and var_266_17 or var_266_17 * (utf8.len(var_266_19) / 45)) > 0 and var_266_17 < var_266_21 then
					arg_263_1.talkMaxDuration = var_266_21
					var_266_16 = var_266_16 + 0.3

					if var_266_21 + var_266_16 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_21 + var_266_16
					end
				end

				arg_263_1.text_.text = var_266_19
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_22 = var_266_16 + 0.3
			local var_266_23 = math.max(var_266_17, arg_263_1.talkMaxDuration)

			if var_266_16 + 0.3 <= arg_263_1.time_ and arg_263_1.time_ < var_266_22 + var_266_23 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_22) / var_266_23

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_22 + var_266_23 and arg_263_1.time_ < var_266_22 + var_266_23 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play1109502069 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 1109502069
		arg_269_1.duration_ = 4.27

		local var_269_0 = {
			zh = 2.233,
			ja = 4.266
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play1109502070(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095actionlink/1095action432")
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_272_0 = 0
			local var_272_1 = 0.25

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_2 = arg_269_1:GetWordFromCfg(1109502069)
				local var_272_3 = arg_269_1:FormatText(var_272_2.content)

				arg_269_1.text_.text = var_272_3

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_5 = 10 <= 0 and var_272_1 or var_272_1 * (utf8.len(var_272_3) / 10)

				if (10 <= 0 and var_272_1 or var_272_1 * (utf8.len(var_272_3) / 10)) > 0 and var_272_1 < var_272_5 then
					arg_269_1.talkMaxDuration = var_272_5

					if var_272_5 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_5 + var_272_0
					end
				end

				arg_269_1.text_.text = var_272_3
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502069", "story_v_side_new_1109502.awb") ~= 0 then
					local var_272_6 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502069", "story_v_side_new_1109502.awb") / 1000

					if var_272_6 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_6 + var_272_0
					end

					if var_272_2.prefab_name ~= "" and arg_269_1.actors_[var_272_2.prefab_name] ~= nil then
						local var_272_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_2.prefab_name].transform, "story_v_side_new_1109502", "1109502069", "story_v_side_new_1109502.awb")

						arg_269_1:RecordAudio("1109502069", var_272_7)
						arg_269_1:RecordAudio("1109502069", var_272_7)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502069", "story_v_side_new_1109502.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502069", "story_v_side_new_1109502.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_8 = math.max(var_272_1, arg_269_1.talkMaxDuration)

			if var_272_0 <= arg_269_1.time_ and arg_269_1.time_ < var_272_0 + var_272_8 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_0) / var_272_8

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_0 + var_272_8 and arg_269_1.time_ < var_272_0 + var_272_8 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play1109502070 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 1109502070
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play1109502071(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(arg_273_1.actors_["10058ui_story"]) and arg_273_1.var_.characterEffect10058ui_story == nil then
				arg_273_1.var_.characterEffect10058ui_story = arg_273_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_0 = 0.0166666666666667

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 and not isNil(arg_273_1.actors_["10058ui_story"]) then
				if arg_273_1.var_.characterEffect10058ui_story and not isNil(arg_273_1.actors_["10058ui_story"]) then
					arg_273_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_273_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_273_1.time_ - 0) / var_276_0)
				end
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 and not isNil(arg_273_1.actors_["10058ui_story"]) and arg_273_1.var_.characterEffect10058ui_story then
				arg_273_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_273_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_276_1 = 0
			local var_276_2 = 0.725

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
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

				local var_276_3 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(1109502070).content)

				arg_273_1.text_.text = var_276_3

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 29 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 29)

				if (29 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 29)) > 0 and var_276_2 < var_276_5 then
					arg_273_1.talkMaxDuration = var_276_5

					if var_276_5 + var_276_1 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_5 + var_276_1
					end
				end

				arg_273_1.text_.text = var_276_3
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_6 = math.max(var_276_2, arg_273_1.talkMaxDuration)

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_6 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_1) / var_276_6

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_1 + var_276_6 and arg_273_1.time_ < var_276_1 + var_276_6 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play1109502071 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 1109502071
		arg_277_1.duration_ = 9.7

		local var_277_0 = {
			zh = 9.633,
			ja = 9.7
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
				arg_277_0:Play1109502072(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos10058ui_story = arg_277_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_280_0 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 then
				arg_277_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_277_1.time_ - 0) / var_280_0)
				arg_277_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["10058ui_story"].transform.position).z)
				arg_277_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["10058ui_story"].transform.localEulerAngles = arg_277_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 then
				arg_277_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_277_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["10058ui_story"].transform.position).z)
				arg_277_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["10058ui_story"].transform.localEulerAngles = arg_277_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_280_1 = arg_277_1.actors_["10058ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect10058ui_story == nil then
				arg_277_1.var_.characterEffect10058ui_story = var_280_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_2 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_2 and not isNil(var_280_1) then
				if arg_277_1.var_.characterEffect10058ui_story and not isNil(var_280_1) then
					arg_277_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= 0 + var_280_2 and arg_277_1.time_ < 0 + var_280_2 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect10058ui_story then
				arg_277_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			local var_280_4 = 0
			local var_280_5 = 0.875

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_4 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_6 = arg_277_1:GetWordFromCfg(1109502071)
				local var_280_7 = arg_277_1:FormatText(var_280_6.content)

				arg_277_1.text_.text = var_280_7

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_9 = 35 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 35)

				if (35 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 35)) > 0 and var_280_5 < var_280_9 then
					arg_277_1.talkMaxDuration = var_280_9

					if var_280_9 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_9 + var_280_4
					end
				end

				arg_277_1.text_.text = var_280_7
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502071", "story_v_side_new_1109502.awb") ~= 0 then
					local var_280_10 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502071", "story_v_side_new_1109502.awb") / 1000

					if var_280_10 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_10 + var_280_4
					end

					if var_280_6.prefab_name ~= "" and arg_277_1.actors_[var_280_6.prefab_name] ~= nil then
						local var_280_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_6.prefab_name].transform, "story_v_side_new_1109502", "1109502071", "story_v_side_new_1109502.awb")

						arg_277_1:RecordAudio("1109502071", var_280_11)
						arg_277_1:RecordAudio("1109502071", var_280_11)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502071", "story_v_side_new_1109502.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502071", "story_v_side_new_1109502.awb")
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
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play1109502072 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 1109502072
		arg_281_1.duration_ = 7

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play1109502073(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				local var_284_0 = arg_281_1.bgs_.ST28

				arg_281_1.bgs_.ST28.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_284_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_284_1 = var_284_0:GetComponent("SpriteRenderer")

				if var_284_1 and var_284_1.sprite then
					local var_284_2 = 2 * (var_284_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_284_0.transform.localScale = Vector3.New(var_284_2 / var_284_1.sprite.bounds.size.y < var_284_2 * manager.ui.mainCameraCom_.aspect / var_284_1.sprite.bounds.size.x and var_284_2 * manager.ui.mainCameraCom_.aspect / var_284_1.sprite.bounds.size.x or var_284_2 / var_284_1.sprite.bounds.size.y, var_284_2 / var_284_1.sprite.bounds.size.y < var_284_2 * manager.ui.mainCameraCom_.aspect / var_284_1.sprite.bounds.size.x and var_284_2 * manager.ui.mainCameraCom_.aspect / var_284_1.sprite.bounds.size.x or var_284_2 / var_284_1.sprite.bounds.size.y, 0)
				end

				for iter_284_0, iter_284_1 in pairs(arg_281_1.bgs_) do
					if iter_284_0 ~= "ST28" then
						iter_284_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_284_3 = "STblack"

			if arg_281_1.bgs_.STblack == nil then
				local var_284_4 = Object.Instantiate(arg_281_1.paintGo_)

				var_284_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_284_3)
				var_284_4.name = var_284_3
				var_284_4.transform.parent = arg_281_1.stage_.transform
				var_284_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_281_1.bgs_[var_284_3] = var_284_4
			end

			if 2 < arg_281_1.time_ and arg_281_1.time_ <= 2 + arg_284_0 then
				local var_284_5 = arg_281_1.bgs_.STblack

				arg_281_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_284_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_284_6 = var_284_5:GetComponent("SpriteRenderer")

				if var_284_6 and var_284_6.sprite then
					local var_284_7 = 2 * (var_284_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_284_5.transform.localScale = Vector3.New(var_284_7 / var_284_6.sprite.bounds.size.y < var_284_7 * manager.ui.mainCameraCom_.aspect / var_284_6.sprite.bounds.size.x and var_284_7 * manager.ui.mainCameraCom_.aspect / var_284_6.sprite.bounds.size.x or var_284_7 / var_284_6.sprite.bounds.size.y, var_284_7 / var_284_6.sprite.bounds.size.y < var_284_7 * manager.ui.mainCameraCom_.aspect / var_284_6.sprite.bounds.size.x and var_284_7 * manager.ui.mainCameraCom_.aspect / var_284_6.sprite.bounds.size.x or var_284_7 / var_284_6.sprite.bounds.size.y, 0)
				end

				for iter_284_2, iter_284_3 in pairs(arg_281_1.bgs_) do
					if iter_284_2 ~= "STblack" then
						iter_284_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_284_8 = 0

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_8 + arg_284_0 then
				arg_281_1.mask_.enabled = true
				arg_281_1.mask_.raycastTarget = true

				arg_281_1:SetGaussion(false)
			end

			local var_284_9 = 2

			if var_284_8 <= arg_281_1.time_ and arg_281_1.time_ < var_284_8 + var_284_9 then
				local var_284_10 = Color.New(0, 0, 0)

				var_284_10.a = Mathf.Lerp(0, 1, (arg_281_1.time_ - var_284_8) / var_284_9)
				arg_281_1.mask_.color = var_284_10
			end

			if arg_281_1.time_ >= var_284_8 + var_284_9 and arg_281_1.time_ < var_284_8 + var_284_9 + arg_284_0 then
				local var_284_11 = Color.New(0, 0, 0)

				var_284_11.a = 1
				arg_281_1.mask_.color = var_284_11
			end

			local var_284_12 = 2

			if 2 < arg_281_1.time_ and arg_281_1.time_ <= var_284_12 + arg_284_0 then
				arg_281_1.mask_.enabled = true
				arg_281_1.mask_.raycastTarget = true

				arg_281_1:SetGaussion(false)
			end

			local var_284_13 = 2

			if var_284_12 <= arg_281_1.time_ and arg_281_1.time_ < var_284_12 + var_284_13 then
				local var_284_14 = Color.New(0, 0, 0)

				var_284_14.a = Mathf.Lerp(1, 0, (arg_281_1.time_ - var_284_12) / var_284_13)
				arg_281_1.mask_.color = var_284_14
			end

			if arg_281_1.time_ >= var_284_12 + var_284_13 and arg_281_1.time_ < var_284_12 + var_284_13 + arg_284_0 then
				local var_284_15 = Color.New(0, 0, 0)

				arg_281_1.mask_.enabled = false
				var_284_15.a = 0
				arg_281_1.mask_.color = var_284_15
			end

			local var_284_16 = arg_281_1.actors_["10058ui_story"].transform

			if 2 < arg_281_1.time_ and arg_281_1.time_ <= 2 + arg_284_0 then
				arg_281_1.var_.moveOldPos10058ui_story = var_284_16.localPosition
			end

			local var_284_17 = 0.001

			if 2 <= arg_281_1.time_ and arg_281_1.time_ < 2 + var_284_17 then
				var_284_16.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_281_1.time_ - 2) / var_284_17)
				var_284_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_284_16.position).x, (manager.ui.mainCamera.transform.position - var_284_16.position).y, (manager.ui.mainCamera.transform.position - var_284_16.position).z)
				var_284_16.localEulerAngles.z = 0
				var_284_16.localEulerAngles.x = 0
				var_284_16.localEulerAngles = var_284_16.localEulerAngles
			end

			if arg_281_1.time_ >= 2 + var_284_17 and arg_281_1.time_ < 2 + var_284_17 + arg_284_0 then
				var_284_16.localPosition = Vector3.New(0, 100, 0)
				var_284_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_284_16.position).x, (manager.ui.mainCamera.transform.position - var_284_16.position).y, (manager.ui.mainCamera.transform.position - var_284_16.position).z)
				var_284_16.localEulerAngles.z = 0
				var_284_16.localEulerAngles.x = 0
				var_284_16.localEulerAngles = var_284_16.localEulerAngles
			end

			local var_284_18 = arg_281_1.actors_["10058ui_story"]

			if 2 < arg_281_1.time_ and arg_281_1.time_ <= 2 + arg_284_0 and not isNil(var_284_18) and arg_281_1.var_.characterEffect10058ui_story == nil then
				arg_281_1.var_.characterEffect10058ui_story = var_284_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_19 = 0.200000002980232

			if 2 <= arg_281_1.time_ and arg_281_1.time_ < 2 + var_284_19 and not isNil(var_284_18) then
				if arg_281_1.var_.characterEffect10058ui_story and not isNil(var_284_18) then
					arg_281_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_281_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_281_1.time_ - 2) / var_284_19)
				end
			end

			if arg_281_1.time_ >= 2 + var_284_19 and arg_281_1.time_ < 2 + var_284_19 + arg_284_0 and not isNil(var_284_18) and arg_281_1.var_.characterEffect10058ui_story then
				arg_281_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_281_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_284_22 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_281_1.bgmTxt_.text ~= var_284_22 and arg_281_1.bgmTxt_.text ~= "" then
						if arg_281_1.bgmTxt2_.text ~= "" then
							arg_281_1.bgmTxt_.text = arg_281_1.bgmTxt2_.text
						end

						arg_281_1.bgmTxt2_.text = var_284_22

						arg_281_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_281_1.bgmTxt_.text = var_284_22
						arg_281_1.bgmTxt2_.text = var_284_22
					end

					if arg_281_1.bgmTimer then
						arg_281_1.bgmTimer:Stop()

						arg_281_1.bgmTimer = nil
					end

					if arg_281_1.settingData.show_music_name == 1 then
						arg_281_1.musicController:SetSelectedState("show")
						arg_281_1.musicAnimator_:Play("open", 0, 0)

						if arg_281_1.settingData.music_time ~= 0 then
							arg_281_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_281_1.settingData.music_time), function()
								if arg_281_1 == nil or isNil(arg_281_1.bgmTxt_) then
									return
								end

								arg_281_1.musicController:SetSelectedState("hide")
								arg_281_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.20000000298023 < arg_281_1.time_ and arg_281_1.time_ <= 1.20000000298023 + arg_284_0 then
				arg_281_1:AudioAction("play", "music", "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_284_25 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

				if "" ~= "" then
					if arg_281_1.bgmTxt_.text ~= var_284_25 and arg_281_1.bgmTxt_.text ~= "" then
						if arg_281_1.bgmTxt2_.text ~= "" then
							arg_281_1.bgmTxt_.text = arg_281_1.bgmTxt2_.text
						end

						arg_281_1.bgmTxt2_.text = var_284_25

						arg_281_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_281_1.bgmTxt_.text = var_284_25
						arg_281_1.bgmTxt2_.text = var_284_25
					end

					if arg_281_1.bgmTimer then
						arg_281_1.bgmTimer:Stop()

						arg_281_1.bgmTimer = nil
					end

					if arg_281_1.settingData.show_music_name == 1 then
						arg_281_1.musicController:SetSelectedState("show")
						arg_281_1.musicAnimator_:Play("open", 0, 0)

						if arg_281_1.settingData.music_time ~= 0 then
							arg_281_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_281_1.settingData.music_time), function()
								if arg_281_1 == nil or isNil(arg_281_1.bgmTxt_) then
									return
								end

								arg_281_1.musicController:SetSelectedState("hide")
								arg_281_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_281_1.frameCnt_ <= 1 then
				arg_281_1.dialog_:SetActive(false)
			end

			local var_284_26 = 2
			local var_284_27 = 0.475

			if 2 < arg_281_1.time_ and arg_281_1.time_ <= var_284_26 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0

				arg_281_1.dialog_:SetActive(true)

				arg_281_1.dialogCg_.alpha = 0

				local var_284_28 = LeanTween.value(arg_281_1.dialog_, 0, 1, 0.3)

				var_284_28:setOnUpdate(LuaHelper.FloatAction(function(arg_287_0)
					arg_281_1.dialogCg_.alpha = arg_287_0
				end))
				var_284_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_281_1.dialog_)
					var_284_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_281_1.duration_ = arg_281_1.duration_ + 0.3

				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_29 = arg_281_1:FormatText(arg_281_1:GetWordFromCfg(1109502072).content)

				arg_281_1.text_.text = var_284_29

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_31 = 19 <= 0 and var_284_27 or var_284_27 * (utf8.len(var_284_29) / 19)

				if (19 <= 0 and var_284_27 or var_284_27 * (utf8.len(var_284_29) / 19)) > 0 and var_284_27 < var_284_31 then
					arg_281_1.talkMaxDuration = var_284_31
					var_284_26 = var_284_26 + 0.3

					if var_284_31 + var_284_26 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_31 + var_284_26
					end
				end

				arg_281_1.text_.text = var_284_29
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_32 = var_284_26 + 0.3
			local var_284_33 = math.max(var_284_27, arg_281_1.talkMaxDuration)

			if var_284_26 + 0.3 <= arg_281_1.time_ and arg_281_1.time_ < var_284_32 + var_284_33 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_32) / var_284_33

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_32 + var_284_33 and arg_281_1.time_ < var_284_32 + var_284_33 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play1109502073 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 1109502073
		arg_289_1.duration_ = 6.8

		local var_289_0 = {
			zh = 6.799999999999,
			ja = 5.699999999999
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play1109502074(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				local var_292_0 = arg_289_1.bgs_.ST28

				arg_289_1.bgs_.ST28.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_292_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_292_1 = var_292_0:GetComponent("SpriteRenderer")

				if var_292_1 and var_292_1.sprite then
					local var_292_2 = 2 * (var_292_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_292_0.transform.localScale = Vector3.New(var_292_2 / var_292_1.sprite.bounds.size.y < var_292_2 * manager.ui.mainCameraCom_.aspect / var_292_1.sprite.bounds.size.x and var_292_2 * manager.ui.mainCameraCom_.aspect / var_292_1.sprite.bounds.size.x or var_292_2 / var_292_1.sprite.bounds.size.y, var_292_2 / var_292_1.sprite.bounds.size.y < var_292_2 * manager.ui.mainCameraCom_.aspect / var_292_1.sprite.bounds.size.x and var_292_2 * manager.ui.mainCameraCom_.aspect / var_292_1.sprite.bounds.size.x or var_292_2 / var_292_1.sprite.bounds.size.y, 0)
				end

				for iter_292_0, iter_292_1 in pairs(arg_289_1.bgs_) do
					if iter_292_0 ~= "ST28" then
						iter_292_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_292_3 = 0

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_3 + arg_292_0 then
				arg_289_1.mask_.enabled = true
				arg_289_1.mask_.raycastTarget = true

				arg_289_1:SetGaussion(false)
			end

			local var_292_4 = 2

			if var_292_3 <= arg_289_1.time_ and arg_289_1.time_ < var_292_3 + var_292_4 then
				local var_292_5 = Color.New(0, 0, 0)

				var_292_5.a = Mathf.Lerp(1, 0, (arg_289_1.time_ - var_292_3) / var_292_4)
				arg_289_1.mask_.color = var_292_5
			end

			if arg_289_1.time_ >= var_292_3 + var_292_4 and arg_289_1.time_ < var_292_3 + var_292_4 + arg_292_0 then
				local var_292_6 = Color.New(0, 0, 0)

				arg_289_1.mask_.enabled = false
				var_292_6.a = 0
				arg_289_1.mask_.color = var_292_6
			end

			if arg_289_1.frameCnt_ <= 1 then
				arg_289_1.dialog_:SetActive(false)
			end

			local var_292_7 = 1.999999999999
			local var_292_8 = 0.225

			if 1.999999999999 < arg_289_1.time_ and arg_289_1.time_ <= var_292_7 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0

				arg_289_1.dialog_:SetActive(true)

				arg_289_1.dialogCg_.alpha = 0

				local var_292_9 = LeanTween.value(arg_289_1.dialog_, 0, 1, 0.3)

				var_292_9:setOnUpdate(LuaHelper.FloatAction(function(arg_293_0)
					arg_289_1.dialogCg_.alpha = arg_293_0
				end))
				var_292_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_289_1.dialog_)
					var_292_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_289_1.duration_ = arg_289_1.duration_ + 0.3

				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[664].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(1, 1, 1)
				arg_289_1.icon_.color = Color.New(1, 1, 1)

				local var_292_10 = arg_289_1:GetWordFromCfg(1109502073)
				local var_292_11 = arg_289_1:FormatText(var_292_10.content)

				arg_289_1.text_.text = var_292_11

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_13 = 9 <= 0 and var_292_8 or var_292_8 * (utf8.len(var_292_11) / 9)

				if (9 <= 0 and var_292_8 or var_292_8 * (utf8.len(var_292_11) / 9)) > 0 and var_292_8 < var_292_13 then
					arg_289_1.talkMaxDuration = var_292_13
					var_292_7 = var_292_7 + 0.3

					if var_292_13 + var_292_7 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_13 + var_292_7
					end
				end

				arg_289_1.text_.text = var_292_11
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502073", "story_v_side_new_1109502.awb") ~= 0 then
					local var_292_14 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502073", "story_v_side_new_1109502.awb") / 1000

					if var_292_14 + var_292_7 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_14 + var_292_7
					end

					if var_292_10.prefab_name ~= "" and arg_289_1.actors_[var_292_10.prefab_name] ~= nil then
						local var_292_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_10.prefab_name].transform, "story_v_side_new_1109502", "1109502073", "story_v_side_new_1109502.awb")

						arg_289_1:RecordAudio("1109502073", var_292_15)
						arg_289_1:RecordAudio("1109502073", var_292_15)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502073", "story_v_side_new_1109502.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502073", "story_v_side_new_1109502.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_16 = var_292_7 + 0.3
			local var_292_17 = math.max(var_292_8, arg_289_1.talkMaxDuration)

			if var_292_7 + 0.3 <= arg_289_1.time_ and arg_289_1.time_ < var_292_16 + var_292_17 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_16) / var_292_17

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_16 + var_292_17 and arg_289_1.time_ < var_292_16 + var_292_17 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play1109502074 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 1109502074
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play1109502075(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0.475

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

				local var_298_1 = arg_295_1:FormatText(arg_295_1:GetWordFromCfg(1109502074).content)

				arg_295_1.text_.text = var_298_1

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_3 = 19 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_1) / 19)

				if (19 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_1) / 19)) > 0 and var_298_0 < var_298_3 then
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
	Play1109502075 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 1109502075
		arg_299_1.duration_ = 3.27

		local var_299_0 = {
			zh = 1.999999999999,
			ja = 3.266
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
				arg_299_0:Play1109502076(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos10058ui_story = arg_299_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_302_0 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_0 then
				arg_299_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_299_1.time_ - 0) / var_302_0)
				arg_299_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_299_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["10058ui_story"].transform.position).z)
				arg_299_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_299_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_299_1.actors_["10058ui_story"].transform.localEulerAngles = arg_299_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_299_1.time_ >= 0 + var_302_0 and arg_299_1.time_ < 0 + var_302_0 + arg_302_0 then
				arg_299_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_299_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_299_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["10058ui_story"].transform.position).z)
				arg_299_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_299_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_299_1.actors_["10058ui_story"].transform.localEulerAngles = arg_299_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_302_1 = arg_299_1.actors_["10058ui_story"]

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(var_302_1) and arg_299_1.var_.characterEffect10058ui_story == nil then
				arg_299_1.var_.characterEffect10058ui_story = var_302_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_2 = 0.200000002980232

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_2 and not isNil(var_302_1) then
				if arg_299_1.var_.characterEffect10058ui_story and not isNil(var_302_1) then
					arg_299_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= 0 + var_302_2 and arg_299_1.time_ < 0 + var_302_2 + arg_302_0 and not isNil(var_302_1) and arg_299_1.var_.characterEffect10058ui_story then
				arg_299_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_302_4 = 0
			local var_302_5 = 0.1

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_4 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_6 = arg_299_1:GetWordFromCfg(1109502075)
				local var_302_7 = arg_299_1:FormatText(var_302_6.content)

				arg_299_1.text_.text = var_302_7

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_9 = 4 <= 0 and var_302_5 or var_302_5 * (utf8.len(var_302_7) / 4)

				if (4 <= 0 and var_302_5 or var_302_5 * (utf8.len(var_302_7) / 4)) > 0 and var_302_5 < var_302_9 then
					arg_299_1.talkMaxDuration = var_302_9

					if var_302_9 + var_302_4 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_9 + var_302_4
					end
				end

				arg_299_1.text_.text = var_302_7
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502075", "story_v_side_new_1109502.awb") ~= 0 then
					local var_302_10 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502075", "story_v_side_new_1109502.awb") / 1000

					if var_302_10 + var_302_4 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_10 + var_302_4
					end

					if var_302_6.prefab_name ~= "" and arg_299_1.actors_[var_302_6.prefab_name] ~= nil then
						local var_302_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_6.prefab_name].transform, "story_v_side_new_1109502", "1109502075", "story_v_side_new_1109502.awb")

						arg_299_1:RecordAudio("1109502075", var_302_11)
						arg_299_1:RecordAudio("1109502075", var_302_11)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502075", "story_v_side_new_1109502.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502075", "story_v_side_new_1109502.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_12 = math.max(var_302_5, arg_299_1.talkMaxDuration)

			if var_302_4 <= arg_299_1.time_ and arg_299_1.time_ < var_302_4 + var_302_12 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_4) / var_302_12

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_4 + var_302_12 and arg_299_1.time_ < var_302_4 + var_302_12 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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
	Play1109502076 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 1109502076
		arg_303_1.duration_ = 5.37

		local var_303_0 = {
			zh = 2.7,
			ja = 5.366
		}
		local var_303_1 = manager.audio:GetLocalizationFlag()

		if var_303_0[var_303_1] ~= nil then
			arg_303_1.duration_ = var_303_0[var_303_1]
		end

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play1109502077(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(arg_303_1.actors_["10058ui_story"]) and arg_303_1.var_.characterEffect10058ui_story == nil then
				arg_303_1.var_.characterEffect10058ui_story = arg_303_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_0 = 0.200000002980232

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 and not isNil(arg_303_1.actors_["10058ui_story"]) then
				if arg_303_1.var_.characterEffect10058ui_story and not isNil(arg_303_1.actors_["10058ui_story"]) then
					arg_303_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_303_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_303_1.time_ - 0) / var_306_0)
				end
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 and not isNil(arg_303_1.actors_["10058ui_story"]) and arg_303_1.var_.characterEffect10058ui_story then
				arg_303_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_303_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_306_1 = 0
			local var_306_2 = 0.25

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[664].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, true)
				arg_303_1.iconController_:SetSelectedState("hero")

				arg_303_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_303_1.callingController_:SetSelectedState("normal")

				arg_303_1.keyicon_.color = Color.New(1, 1, 1)
				arg_303_1.icon_.color = Color.New(1, 1, 1)

				local var_306_3 = arg_303_1:GetWordFromCfg(1109502076)
				local var_306_4 = arg_303_1:FormatText(var_306_3.content)

				arg_303_1.text_.text = var_306_4

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_6 = 10 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_4) / 10)

				if (10 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_4) / 10)) > 0 and var_306_2 < var_306_6 then
					arg_303_1.talkMaxDuration = var_306_6

					if var_306_6 + var_306_1 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_6 + var_306_1
					end
				end

				arg_303_1.text_.text = var_306_4
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502076", "story_v_side_new_1109502.awb") ~= 0 then
					local var_306_7 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502076", "story_v_side_new_1109502.awb") / 1000

					if var_306_7 + var_306_1 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_7 + var_306_1
					end

					if var_306_3.prefab_name ~= "" and arg_303_1.actors_[var_306_3.prefab_name] ~= nil then
						local var_306_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_3.prefab_name].transform, "story_v_side_new_1109502", "1109502076", "story_v_side_new_1109502.awb")

						arg_303_1:RecordAudio("1109502076", var_306_8)
						arg_303_1:RecordAudio("1109502076", var_306_8)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502076", "story_v_side_new_1109502.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502076", "story_v_side_new_1109502.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_9 = math.max(var_306_2, arg_303_1.talkMaxDuration)

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_9 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_1) / var_306_9

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_1 + var_306_9 and arg_303_1.time_ < var_306_1 + var_306_9 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play1109502077 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 1109502077
		arg_307_1.duration_ = 6.2

		local var_307_0 = {
			zh = 4.766,
			ja = 6.2
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play1109502078(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(arg_307_1.actors_["10058ui_story"]) and arg_307_1.var_.characterEffect10058ui_story == nil then
				arg_307_1.var_.characterEffect10058ui_story = arg_307_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_0 = 0.0166666666666667

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 and not isNil(arg_307_1.actors_["10058ui_story"]) then
				if arg_307_1.var_.characterEffect10058ui_story and not isNil(arg_307_1.actors_["10058ui_story"]) then
					arg_307_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 and not isNil(arg_307_1.actors_["10058ui_story"]) and arg_307_1.var_.characterEffect10058ui_story then
				arg_307_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_310_2 = 0
			local var_310_3 = 0.5

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_2 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_4 = arg_307_1:GetWordFromCfg(1109502077)
				local var_310_5 = arg_307_1:FormatText(var_310_4.content)

				arg_307_1.text_.text = var_310_5

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_7 = 20 <= 0 and var_310_3 or var_310_3 * (utf8.len(var_310_5) / 20)

				if (20 <= 0 and var_310_3 or var_310_3 * (utf8.len(var_310_5) / 20)) > 0 and var_310_3 < var_310_7 then
					arg_307_1.talkMaxDuration = var_310_7

					if var_310_7 + var_310_2 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_7 + var_310_2
					end
				end

				arg_307_1.text_.text = var_310_5
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502077", "story_v_side_new_1109502.awb") ~= 0 then
					local var_310_8 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502077", "story_v_side_new_1109502.awb") / 1000

					if var_310_8 + var_310_2 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_8 + var_310_2
					end

					if var_310_4.prefab_name ~= "" and arg_307_1.actors_[var_310_4.prefab_name] ~= nil then
						local var_310_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_4.prefab_name].transform, "story_v_side_new_1109502", "1109502077", "story_v_side_new_1109502.awb")

						arg_307_1:RecordAudio("1109502077", var_310_9)
						arg_307_1:RecordAudio("1109502077", var_310_9)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502077", "story_v_side_new_1109502.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502077", "story_v_side_new_1109502.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_10 = math.max(var_310_3, arg_307_1.talkMaxDuration)

			if var_310_2 <= arg_307_1.time_ and arg_307_1.time_ < var_310_2 + var_310_10 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_2) / var_310_10

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_2 + var_310_10 and arg_307_1.time_ < var_310_2 + var_310_10 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play1109502078 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 1109502078
		arg_311_1.duration_ = 6.93

		local var_311_0 = {
			zh = 4.566,
			ja = 6.933
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
				arg_311_0:Play1109502079(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(arg_311_1.actors_["10058ui_story"]) and arg_311_1.var_.characterEffect10058ui_story == nil then
				arg_311_1.var_.characterEffect10058ui_story = arg_311_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_0 = 0.0166666666666667

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 and not isNil(arg_311_1.actors_["10058ui_story"]) then
				if arg_311_1.var_.characterEffect10058ui_story and not isNil(arg_311_1.actors_["10058ui_story"]) then
					arg_311_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_311_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_311_1.time_ - 0) / var_314_0)
				end
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 and not isNil(arg_311_1.actors_["10058ui_story"]) and arg_311_1.var_.characterEffect10058ui_story then
				arg_311_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_311_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_314_1 = 0
			local var_314_2 = 0.425

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[664].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, true)
				arg_311_1.iconController_:SetSelectedState("hero")

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_3 = arg_311_1:GetWordFromCfg(1109502078)
				local var_314_4 = arg_311_1:FormatText(var_314_3.content)

				arg_311_1.text_.text = var_314_4

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_6 = 17 <= 0 and var_314_2 or var_314_2 * (utf8.len(var_314_4) / 17)

				if (17 <= 0 and var_314_2 or var_314_2 * (utf8.len(var_314_4) / 17)) > 0 and var_314_2 < var_314_6 then
					arg_311_1.talkMaxDuration = var_314_6

					if var_314_6 + var_314_1 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_6 + var_314_1
					end
				end

				arg_311_1.text_.text = var_314_4
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502078", "story_v_side_new_1109502.awb") ~= 0 then
					local var_314_7 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502078", "story_v_side_new_1109502.awb") / 1000

					if var_314_7 + var_314_1 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_7 + var_314_1
					end

					if var_314_3.prefab_name ~= "" and arg_311_1.actors_[var_314_3.prefab_name] ~= nil then
						local var_314_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_3.prefab_name].transform, "story_v_side_new_1109502", "1109502078", "story_v_side_new_1109502.awb")

						arg_311_1:RecordAudio("1109502078", var_314_8)
						arg_311_1:RecordAudio("1109502078", var_314_8)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502078", "story_v_side_new_1109502.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502078", "story_v_side_new_1109502.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_9 = math.max(var_314_2, arg_311_1.talkMaxDuration)

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_9 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_1) / var_314_9

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_1 + var_314_9 and arg_311_1.time_ < var_314_1 + var_314_9 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play1109502079 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 1109502079
		arg_315_1.duration_ = 2

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play1109502080(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(arg_315_1.actors_["10058ui_story"]) and arg_315_1.var_.characterEffect10058ui_story == nil then
				arg_315_1.var_.characterEffect10058ui_story = arg_315_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_0 = 0.0166666666666667

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 and not isNil(arg_315_1.actors_["10058ui_story"]) then
				if arg_315_1.var_.characterEffect10058ui_story and not isNil(arg_315_1.actors_["10058ui_story"]) then
					arg_315_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 and not isNil(arg_315_1.actors_["10058ui_story"]) and arg_315_1.var_.characterEffect10058ui_story then
				arg_315_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_318_2 = 0
			local var_318_3 = 0.075

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_2 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_4 = arg_315_1:GetWordFromCfg(1109502079)
				local var_318_5 = arg_315_1:FormatText(var_318_4.content)

				arg_315_1.text_.text = var_318_5

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_7 = 3 <= 0 and var_318_3 or var_318_3 * (utf8.len(var_318_5) / 3)

				if (3 <= 0 and var_318_3 or var_318_3 * (utf8.len(var_318_5) / 3)) > 0 and var_318_3 < var_318_7 then
					arg_315_1.talkMaxDuration = var_318_7

					if var_318_7 + var_318_2 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_7 + var_318_2
					end
				end

				arg_315_1.text_.text = var_318_5
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502079", "story_v_side_new_1109502.awb") ~= 0 then
					local var_318_8 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502079", "story_v_side_new_1109502.awb") / 1000

					if var_318_8 + var_318_2 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_8 + var_318_2
					end

					if var_318_4.prefab_name ~= "" and arg_315_1.actors_[var_318_4.prefab_name] ~= nil then
						local var_318_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_4.prefab_name].transform, "story_v_side_new_1109502", "1109502079", "story_v_side_new_1109502.awb")

						arg_315_1:RecordAudio("1109502079", var_318_9)
						arg_315_1:RecordAudio("1109502079", var_318_9)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502079", "story_v_side_new_1109502.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502079", "story_v_side_new_1109502.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_10 = math.max(var_318_3, arg_315_1.talkMaxDuration)

			if var_318_2 <= arg_315_1.time_ and arg_315_1.time_ < var_318_2 + var_318_10 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_2) / var_318_10

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_2 + var_318_10 and arg_315_1.time_ < var_318_2 + var_318_10 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play1109502080 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 1109502080
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play1109502081(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(arg_319_1.actors_["10058ui_story"]) and arg_319_1.var_.characterEffect10058ui_story == nil then
				arg_319_1.var_.characterEffect10058ui_story = arg_319_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_0 = 0.0166666666666667

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_0 and not isNil(arg_319_1.actors_["10058ui_story"]) then
				if arg_319_1.var_.characterEffect10058ui_story and not isNil(arg_319_1.actors_["10058ui_story"]) then
					arg_319_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_319_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_319_1.time_ - 0) / var_322_0)
				end
			end

			if arg_319_1.time_ >= 0 + var_322_0 and arg_319_1.time_ < 0 + var_322_0 + arg_322_0 and not isNil(arg_319_1.actors_["10058ui_story"]) and arg_319_1.var_.characterEffect10058ui_story then
				arg_319_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_319_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_322_1 = 0
			local var_322_2 = 0.775

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, false)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_3 = arg_319_1:FormatText(arg_319_1:GetWordFromCfg(1109502080).content)

				arg_319_1.text_.text = var_322_3

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_5 = 31 <= 0 and var_322_2 or var_322_2 * (utf8.len(var_322_3) / 31)

				if (31 <= 0 and var_322_2 or var_322_2 * (utf8.len(var_322_3) / 31)) > 0 and var_322_2 < var_322_5 then
					arg_319_1.talkMaxDuration = var_322_5

					if var_322_5 + var_322_1 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_5 + var_322_1
					end
				end

				arg_319_1.text_.text = var_322_3
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_6 = math.max(var_322_2, arg_319_1.talkMaxDuration)

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_6 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_1) / var_322_6

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_1 + var_322_6 and arg_319_1.time_ < var_322_1 + var_322_6 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play1109502081 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 1109502081
		arg_323_1.duration_ = 5.27

		local var_323_0 = {
			zh = 4.1,
			ja = 5.266
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
				arg_323_0:Play1109502082(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = 0.475

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[664].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, true)
				arg_323_1.iconController_:SetSelectedState("hero")

				arg_323_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_323_1.callingController_:SetSelectedState("normal")

				arg_323_1.keyicon_.color = Color.New(1, 1, 1)
				arg_323_1.icon_.color = Color.New(1, 1, 1)

				local var_326_1 = arg_323_1:GetWordFromCfg(1109502081)
				local var_326_2 = arg_323_1:FormatText(var_326_1.content)

				arg_323_1.text_.text = var_326_2

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_4 = 19 <= 0 and var_326_0 or var_326_0 * (utf8.len(var_326_2) / 19)

				if (19 <= 0 and var_326_0 or var_326_0 * (utf8.len(var_326_2) / 19)) > 0 and var_326_0 < var_326_4 then
					arg_323_1.talkMaxDuration = var_326_4

					if var_326_4 + 0 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_4 + 0
					end
				end

				arg_323_1.text_.text = var_326_2
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502081", "story_v_side_new_1109502.awb") ~= 0 then
					local var_326_5 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502081", "story_v_side_new_1109502.awb") / 1000

					if var_326_5 + 0 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_5 + 0
					end

					if var_326_1.prefab_name ~= "" and arg_323_1.actors_[var_326_1.prefab_name] ~= nil then
						local var_326_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_1.prefab_name].transform, "story_v_side_new_1109502", "1109502081", "story_v_side_new_1109502.awb")

						arg_323_1:RecordAudio("1109502081", var_326_6)
						arg_323_1:RecordAudio("1109502081", var_326_6)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502081", "story_v_side_new_1109502.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502081", "story_v_side_new_1109502.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_7 = math.max(var_326_0, arg_323_1.talkMaxDuration)

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_7 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - 0) / var_326_7

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= 0 + var_326_7 and arg_323_1.time_ < 0 + var_326_7 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play1109502082 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 1109502082
		arg_327_1.duration_ = 1

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"

			SetActive(arg_327_1.choicesGo_, true)

			for iter_328_0, iter_328_1 in ipairs(arg_327_1.choices_) do
				SetActive(iter_328_1.go, iter_328_0 <= 1)
			end

			arg_327_1.choices_[1].txt.text = arg_327_1:FormatText(StoryChoiceCfg[719].name)
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play1109502083(arg_327_1)
			end

			arg_327_1:RecordChoiceLog(1109502082, 719)
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.allBtn_.enabled = false
			end

			if arg_327_1.time_ >= 0 + 0.5 and arg_327_1.time_ < 0 + 0.5 + arg_330_0 then
				arg_327_1.allBtn_.enabled = true
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play1109502083 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 1109502083
		arg_331_1.duration_ = 6.3

		local var_331_0 = {
			zh = 5.333,
			ja = 6.3
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
				arg_331_0:Play1109502084(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 1.48333333333333 < arg_331_1.time_ and arg_331_1.time_ <= 1.48333333333333 + arg_334_0 then
				arg_331_1.var_.moveOldPos10058ui_story = arg_331_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_334_0 = 0.001

			if 1.48333333333333 <= arg_331_1.time_ and arg_331_1.time_ < 1.48333333333333 + var_334_0 then
				arg_331_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_331_1.time_ - 1.48333333333333) / var_334_0)
				arg_331_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_331_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["10058ui_story"].transform.position).z)
				arg_331_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_331_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_331_1.actors_["10058ui_story"].transform.localEulerAngles = arg_331_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_331_1.time_ >= 1.48333333333333 + var_334_0 and arg_331_1.time_ < 1.48333333333333 + var_334_0 + arg_334_0 then
				arg_331_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_331_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_331_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["10058ui_story"].transform.position).z)
				arg_331_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_331_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_331_1.actors_["10058ui_story"].transform.localEulerAngles = arg_331_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_334_1 = 0

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 then
				arg_331_1.mask_.enabled = true
				arg_331_1.mask_.raycastTarget = true

				arg_331_1:SetGaussion(false)
			end

			local var_334_2 = 1.5

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_2 then
				local var_334_3 = Color.New(0.02830189, 0.02830189, 0.02830189)

				var_334_3.a = Mathf.Lerp(0, 1, (arg_331_1.time_ - var_334_1) / var_334_2)
				arg_331_1.mask_.color = var_334_3
			end

			if arg_331_1.time_ >= var_334_1 + var_334_2 and arg_331_1.time_ < var_334_1 + var_334_2 + arg_334_0 then
				local var_334_4 = Color.New(0.02830189, 0.02830189, 0.02830189)

				var_334_4.a = 1
				arg_331_1.mask_.color = var_334_4
			end

			local var_334_5 = 1.5

			if 1.5 < arg_331_1.time_ and arg_331_1.time_ <= var_334_5 + arg_334_0 then
				arg_331_1.mask_.enabled = true
				arg_331_1.mask_.raycastTarget = true

				arg_331_1:SetGaussion(false)
			end

			local var_334_6 = 1.5

			if var_334_5 <= arg_331_1.time_ and arg_331_1.time_ < var_334_5 + var_334_6 then
				local var_334_7 = Color.New(0.02830189, 0.02830189, 0.02830189)

				var_334_7.a = Mathf.Lerp(1, 0, (arg_331_1.time_ - var_334_5) / var_334_6)
				arg_331_1.mask_.color = var_334_7
			end

			if arg_331_1.time_ >= var_334_5 + var_334_6 and arg_331_1.time_ < var_334_5 + var_334_6 + arg_334_0 then
				local var_334_8 = Color.New(0.02830189, 0.02830189, 0.02830189)

				arg_331_1.mask_.enabled = false
				var_334_8.a = 0
				arg_331_1.mask_.color = var_334_8
			end

			if arg_331_1.frameCnt_ <= 1 then
				arg_331_1.dialog_:SetActive(false)
			end

			local var_334_9 = 3
			local var_334_10 = 0.133333333333333

			if 3 < arg_331_1.time_ and arg_331_1.time_ <= var_334_9 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0

				arg_331_1.dialog_:SetActive(true)

				arg_331_1.dialogCg_.alpha = 0

				local var_334_11 = LeanTween.value(arg_331_1.dialog_, 0, 1, 0.3)

				var_334_11:setOnUpdate(LuaHelper.FloatAction(function(arg_335_0)
					arg_331_1.dialogCg_.alpha = arg_335_0
				end))
				var_334_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_331_1.dialog_)
					var_334_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_331_1.duration_ = arg_331_1.duration_ + 0.3

				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[664].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, true)
				arg_331_1.iconController_:SetSelectedState("hero")

				arg_331_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_331_1.callingController_:SetSelectedState("normal")

				arg_331_1.keyicon_.color = Color.New(1, 1, 1)
				arg_331_1.icon_.color = Color.New(1, 1, 1)

				local var_334_12 = arg_331_1:GetWordFromCfg(1109502083)
				local var_334_13 = arg_331_1:FormatText(var_334_12.content)

				arg_331_1.text_.text = var_334_13

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_15 = 5 <= 0 and var_334_10 or var_334_10 * (utf8.len(var_334_13) / 5)

				if (5 <= 0 and var_334_10 or var_334_10 * (utf8.len(var_334_13) / 5)) > 0 and var_334_10 < var_334_15 then
					arg_331_1.talkMaxDuration = var_334_15
					var_334_9 = var_334_9 + 0.3

					if var_334_15 + var_334_9 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_15 + var_334_9
					end
				end

				arg_331_1.text_.text = var_334_13
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502083", "story_v_side_new_1109502.awb") ~= 0 then
					local var_334_16 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502083", "story_v_side_new_1109502.awb") / 1000

					if var_334_16 + var_334_9 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_16 + var_334_9
					end

					if var_334_12.prefab_name ~= "" and arg_331_1.actors_[var_334_12.prefab_name] ~= nil then
						local var_334_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_12.prefab_name].transform, "story_v_side_new_1109502", "1109502083", "story_v_side_new_1109502.awb")

						arg_331_1:RecordAudio("1109502083", var_334_17)
						arg_331_1:RecordAudio("1109502083", var_334_17)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502083", "story_v_side_new_1109502.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502083", "story_v_side_new_1109502.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_18 = var_334_9 + 0.3
			local var_334_19 = math.max(var_334_10, arg_331_1.talkMaxDuration)

			if var_334_9 + 0.3 <= arg_331_1.time_ and arg_331_1.time_ < var_334_18 + var_334_19 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_18) / var_334_19

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_18 + var_334_19 and arg_331_1.time_ < var_334_18 + var_334_19 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666666,
				className = "StoryMoveNode",
				startTime = 1.48333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_331_1:InitPlayNodeList()
	end,
	Play1109502084 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 1109502084
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play1109502085(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0.975

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, false)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_1 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(1109502084).content)

				arg_337_1.text_.text = var_340_1

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_3 = 39 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_1) / 39)

				if (39 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_1) / 39)) > 0 and var_340_0 < var_340_3 then
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
	Play1109502085 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 1109502085
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play1109502086(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 0.45

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, false)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_1 = arg_341_1:FormatText(arg_341_1:GetWordFromCfg(1109502085).content)

				arg_341_1.text_.text = var_344_1

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_3 = 18 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_1) / 18)

				if (18 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_1) / 18)) > 0 and var_344_0 < var_344_3 then
					arg_341_1.talkMaxDuration = var_344_3

					if var_344_3 + 0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_3 + 0
					end
				end

				arg_341_1.text_.text = var_344_1
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_4 = math.max(var_344_0, arg_341_1.talkMaxDuration)

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_4 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - 0) / var_344_4

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= 0 + var_344_4 and arg_341_1.time_ < 0 + var_344_4 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play1109502086 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 1109502086
		arg_345_1.duration_ = 3.33

		local var_345_0 = {
			zh = 1.5,
			ja = 3.333
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play1109502087(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = 0.125

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[664].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, true)
				arg_345_1.iconController_:SetSelectedState("hero")

				arg_345_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_345_1.callingController_:SetSelectedState("normal")

				arg_345_1.keyicon_.color = Color.New(1, 1, 1)
				arg_345_1.icon_.color = Color.New(1, 1, 1)

				local var_348_1 = arg_345_1:GetWordFromCfg(1109502086)
				local var_348_2 = arg_345_1:FormatText(var_348_1.content)

				arg_345_1.text_.text = var_348_2

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_4 = 5 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_2) / 5)

				if (5 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_2) / 5)) > 0 and var_348_0 < var_348_4 then
					arg_345_1.talkMaxDuration = var_348_4

					if var_348_4 + 0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_4 + 0
					end
				end

				arg_345_1.text_.text = var_348_2
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502086", "story_v_side_new_1109502.awb") ~= 0 then
					local var_348_5 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502086", "story_v_side_new_1109502.awb") / 1000

					if var_348_5 + 0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_5 + 0
					end

					if var_348_1.prefab_name ~= "" and arg_345_1.actors_[var_348_1.prefab_name] ~= nil then
						local var_348_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_1.prefab_name].transform, "story_v_side_new_1109502", "1109502086", "story_v_side_new_1109502.awb")

						arg_345_1:RecordAudio("1109502086", var_348_6)
						arg_345_1:RecordAudio("1109502086", var_348_6)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502086", "story_v_side_new_1109502.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502086", "story_v_side_new_1109502.awb")
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
	Play1109502087 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 1109502087
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play1109502088(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0.275

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, false)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_1 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(1109502087).content)

				arg_349_1.text_.text = var_352_1

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_3 = 11 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_1) / 11)

				if (11 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_1) / 11)) > 0 and var_352_0 < var_352_3 then
					arg_349_1.talkMaxDuration = var_352_3

					if var_352_3 + 0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_3 + 0
					end
				end

				arg_349_1.text_.text = var_352_1
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_4 = math.max(var_352_0, arg_349_1.talkMaxDuration)

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_4 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - 0) / var_352_4

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= 0 + var_352_4 and arg_349_1.time_ < 0 + var_352_4 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play1109502088 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 1109502088
		arg_353_1.duration_ = 2.6

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play1109502089(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 0.275

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[664].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, true)
				arg_353_1.iconController_:SetSelectedState("hero")

				arg_353_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_353_1.callingController_:SetSelectedState("normal")

				arg_353_1.keyicon_.color = Color.New(1, 1, 1)
				arg_353_1.icon_.color = Color.New(1, 1, 1)

				local var_356_1 = arg_353_1:GetWordFromCfg(1109502088)
				local var_356_2 = arg_353_1:FormatText(var_356_1.content)

				arg_353_1.text_.text = var_356_2

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_4 = 11 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_2) / 11)

				if (11 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_2) / 11)) > 0 and var_356_0 < var_356_4 then
					arg_353_1.talkMaxDuration = var_356_4

					if var_356_4 + 0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_4 + 0
					end
				end

				arg_353_1.text_.text = var_356_2
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502088", "story_v_side_new_1109502.awb") ~= 0 then
					local var_356_5 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502088", "story_v_side_new_1109502.awb") / 1000

					if var_356_5 + 0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_5 + 0
					end

					if var_356_1.prefab_name ~= "" and arg_353_1.actors_[var_356_1.prefab_name] ~= nil then
						local var_356_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_1.prefab_name].transform, "story_v_side_new_1109502", "1109502088", "story_v_side_new_1109502.awb")

						arg_353_1:RecordAudio("1109502088", var_356_6)
						arg_353_1:RecordAudio("1109502088", var_356_6)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502088", "story_v_side_new_1109502.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502088", "story_v_side_new_1109502.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_7 = math.max(var_356_0, arg_353_1.talkMaxDuration)

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_7 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - 0) / var_356_7

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= 0 + var_356_7 and arg_353_1.time_ < 0 + var_356_7 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play1109502089 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 1109502089
		arg_357_1.duration_ = 8.67

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play1109502090(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.mask_.enabled = true
				arg_357_1.mask_.raycastTarget = true

				arg_357_1:SetGaussion(false)
			end

			local var_360_0 = 2

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 then
				local var_360_1 = Color.New(0, 0, 0)

				var_360_1.a = Mathf.Lerp(0, 1, (arg_357_1.time_ - 0) / var_360_0)
				arg_357_1.mask_.color = var_360_1
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 then
				local var_360_2 = Color.New(0, 0, 0)

				var_360_2.a = 1
				arg_357_1.mask_.color = var_360_2
			end

			local var_360_3 = 2

			if 2 < arg_357_1.time_ and arg_357_1.time_ <= var_360_3 + arg_360_0 then
				arg_357_1.mask_.enabled = true
				arg_357_1.mask_.raycastTarget = true

				arg_357_1:SetGaussion(false)
			end

			local var_360_4 = 1.66666666666667

			if var_360_3 <= arg_357_1.time_ and arg_357_1.time_ < var_360_3 + var_360_4 then
				local var_360_5 = Color.New(0, 0, 0)

				var_360_5.a = Mathf.Lerp(1, 0, (arg_357_1.time_ - var_360_3) / var_360_4)
				arg_357_1.mask_.color = var_360_5
			end

			if arg_357_1.time_ >= var_360_3 + var_360_4 and arg_357_1.time_ < var_360_3 + var_360_4 + arg_360_0 then
				local var_360_6 = Color.New(0, 0, 0)

				arg_357_1.mask_.enabled = false
				var_360_6.a = 0
				arg_357_1.mask_.color = var_360_6
			end

			if arg_357_1.frameCnt_ <= 1 then
				arg_357_1.dialog_:SetActive(false)
			end

			local var_360_7 = 3.66666666666667
			local var_360_8 = 1.25

			if 3.66666666666667 < arg_357_1.time_ and arg_357_1.time_ <= var_360_7 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0

				arg_357_1.dialog_:SetActive(true)

				arg_357_1.dialogCg_.alpha = 0

				local var_360_9 = LeanTween.value(arg_357_1.dialog_, 0, 1, 0.3)

				var_360_9:setOnUpdate(LuaHelper.FloatAction(function(arg_361_0)
					arg_357_1.dialogCg_.alpha = arg_361_0
				end))
				var_360_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_357_1.dialog_)
					var_360_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_357_1.duration_ = arg_357_1.duration_ + 0.3

				SetActive(arg_357_1.leftNameGo_, false)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_10 = arg_357_1:FormatText(arg_357_1:GetWordFromCfg(1109502089).content)

				arg_357_1.text_.text = var_360_10

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_12 = 50 <= 0 and var_360_8 or var_360_8 * (utf8.len(var_360_10) / 50)

				if (50 <= 0 and var_360_8 or var_360_8 * (utf8.len(var_360_10) / 50)) > 0 and var_360_8 < var_360_12 then
					arg_357_1.talkMaxDuration = var_360_12
					var_360_7 = var_360_7 + 0.3

					if var_360_12 + var_360_7 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_12 + var_360_7
					end
				end

				arg_357_1.text_.text = var_360_10
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_13 = var_360_7 + 0.3
			local var_360_14 = math.max(var_360_8, arg_357_1.talkMaxDuration)

			if var_360_7 + 0.3 <= arg_357_1.time_ and arg_357_1.time_ < var_360_13 + var_360_14 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_13) / var_360_14

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_13 + var_360_14 and arg_357_1.time_ < var_360_13 + var_360_14 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play1109502090 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 1109502090
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play1109502091(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 0.35

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
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

				local var_366_1 = arg_363_1:FormatText(arg_363_1:GetWordFromCfg(1109502090).content)

				arg_363_1.text_.text = var_366_1

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_3 = 14 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_1) / 14)

				if (14 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_1) / 14)) > 0 and var_366_0 < var_366_3 then
					arg_363_1.talkMaxDuration = var_366_3

					if var_366_3 + 0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_3 + 0
					end
				end

				arg_363_1.text_.text = var_366_1
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_4 = math.max(var_366_0, arg_363_1.talkMaxDuration)

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_4 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - 0) / var_366_4

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= 0 + var_366_4 and arg_363_1.time_ < 0 + var_366_4 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play1109502091 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 1109502091
		arg_367_1.duration_ = 3.7

		local var_367_0 = {
			zh = 3.7,
			ja = 3.533
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
				arg_367_0:Play1109502092(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.var_.moveOldPos10058ui_story = arg_367_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_370_0 = 0.001

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_0 then
				arg_367_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_367_1.time_ - 0) / var_370_0)
				arg_367_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_367_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["10058ui_story"].transform.position).z)
				arg_367_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_367_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_367_1.actors_["10058ui_story"].transform.localEulerAngles = arg_367_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_367_1.time_ >= 0 + var_370_0 and arg_367_1.time_ < 0 + var_370_0 + arg_370_0 then
				arg_367_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_367_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_367_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["10058ui_story"].transform.position).z)
				arg_367_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_367_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_367_1.actors_["10058ui_story"].transform.localEulerAngles = arg_367_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_370_1 = arg_367_1.actors_["10058ui_story"]

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(var_370_1) and arg_367_1.var_.characterEffect10058ui_story == nil then
				arg_367_1.var_.characterEffect10058ui_story = var_370_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_2 = 0.200000002980232

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_2 and not isNil(var_370_1) then
				if arg_367_1.var_.characterEffect10058ui_story and not isNil(var_370_1) then
					arg_367_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_367_1.time_ >= 0 + var_370_2 and arg_367_1.time_ < 0 + var_370_2 + arg_370_0 and not isNil(var_370_1) and arg_367_1.var_.characterEffect10058ui_story then
				arg_367_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095actionlink/1095action424")
			end

			local var_370_4 = 0
			local var_370_5 = 0.3

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_4 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_6 = arg_367_1:GetWordFromCfg(1109502091)
				local var_370_7 = arg_367_1:FormatText(var_370_6.content)

				arg_367_1.text_.text = var_370_7

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_9 = 12 <= 0 and var_370_5 or var_370_5 * (utf8.len(var_370_7) / 12)

				if (12 <= 0 and var_370_5 or var_370_5 * (utf8.len(var_370_7) / 12)) > 0 and var_370_5 < var_370_9 then
					arg_367_1.talkMaxDuration = var_370_9

					if var_370_9 + var_370_4 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_9 + var_370_4
					end
				end

				arg_367_1.text_.text = var_370_7
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502091", "story_v_side_new_1109502.awb") ~= 0 then
					local var_370_10 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502091", "story_v_side_new_1109502.awb") / 1000

					if var_370_10 + var_370_4 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_10 + var_370_4
					end

					if var_370_6.prefab_name ~= "" and arg_367_1.actors_[var_370_6.prefab_name] ~= nil then
						local var_370_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_6.prefab_name].transform, "story_v_side_new_1109502", "1109502091", "story_v_side_new_1109502.awb")

						arg_367_1:RecordAudio("1109502091", var_370_11)
						arg_367_1:RecordAudio("1109502091", var_370_11)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502091", "story_v_side_new_1109502.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502091", "story_v_side_new_1109502.awb")
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
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_367_1:InitPlayNodeList()
	end,
	Play1109502092 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 1109502092
		arg_371_1.duration_ = 6.13

		local var_371_0 = {
			zh = 4.7,
			ja = 6.133
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
				arg_371_0:Play1109502093(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(arg_371_1.actors_["10058ui_story"]) and arg_371_1.var_.characterEffect10058ui_story == nil then
				arg_371_1.var_.characterEffect10058ui_story = arg_371_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_0 = 0.200000002980232

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_0 and not isNil(arg_371_1.actors_["10058ui_story"]) then
				if arg_371_1.var_.characterEffect10058ui_story and not isNil(arg_371_1.actors_["10058ui_story"]) then
					arg_371_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_371_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_371_1.time_ - 0) / var_374_0)
				end
			end

			if arg_371_1.time_ >= 0 + var_374_0 and arg_371_1.time_ < 0 + var_374_0 + arg_374_0 and not isNil(arg_371_1.actors_["10058ui_story"]) and arg_371_1.var_.characterEffect10058ui_story then
				arg_371_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_371_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_374_1 = 0
			local var_374_2 = 0.575

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[664].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, true)
				arg_371_1.iconController_:SetSelectedState("hero")

				arg_371_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_371_1.callingController_:SetSelectedState("normal")

				arg_371_1.keyicon_.color = Color.New(1, 1, 1)
				arg_371_1.icon_.color = Color.New(1, 1, 1)

				local var_374_3 = arg_371_1:GetWordFromCfg(1109502092)
				local var_374_4 = arg_371_1:FormatText(var_374_3.content)

				arg_371_1.text_.text = var_374_4

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_6 = 23 <= 0 and var_374_2 or var_374_2 * (utf8.len(var_374_4) / 23)

				if (23 <= 0 and var_374_2 or var_374_2 * (utf8.len(var_374_4) / 23)) > 0 and var_374_2 < var_374_6 then
					arg_371_1.talkMaxDuration = var_374_6

					if var_374_6 + var_374_1 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_6 + var_374_1
					end
				end

				arg_371_1.text_.text = var_374_4
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502092", "story_v_side_new_1109502.awb") ~= 0 then
					local var_374_7 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502092", "story_v_side_new_1109502.awb") / 1000

					if var_374_7 + var_374_1 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_7 + var_374_1
					end

					if var_374_3.prefab_name ~= "" and arg_371_1.actors_[var_374_3.prefab_name] ~= nil then
						local var_374_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_3.prefab_name].transform, "story_v_side_new_1109502", "1109502092", "story_v_side_new_1109502.awb")

						arg_371_1:RecordAudio("1109502092", var_374_8)
						arg_371_1:RecordAudio("1109502092", var_374_8)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502092", "story_v_side_new_1109502.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502092", "story_v_side_new_1109502.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_9 = math.max(var_374_2, arg_371_1.talkMaxDuration)

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_9 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_1) / var_374_9

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_1 + var_374_9 and arg_371_1.time_ < var_374_1 + var_374_9 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play1109502093 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 1109502093
		arg_375_1.duration_ = 5

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play1109502094(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = 0.4

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
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

				local var_378_1 = arg_375_1:FormatText(arg_375_1:GetWordFromCfg(1109502093).content)

				arg_375_1.text_.text = var_378_1

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_3 = 16 <= 0 and var_378_0 or var_378_0 * (utf8.len(var_378_1) / 16)

				if (16 <= 0 and var_378_0 or var_378_0 * (utf8.len(var_378_1) / 16)) > 0 and var_378_0 < var_378_3 then
					arg_375_1.talkMaxDuration = var_378_3

					if var_378_3 + 0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_3 + 0
					end
				end

				arg_375_1.text_.text = var_378_1
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_4 = math.max(var_378_0, arg_375_1.talkMaxDuration)

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_4 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - 0) / var_378_4

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= 0 + var_378_4 and arg_375_1.time_ < 0 + var_378_4 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play1109502094 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 1109502094
		arg_379_1.duration_ = 6

		local var_379_0 = {
			zh = 3.566,
			ja = 6
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
				arg_379_0:Play1109502095(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(arg_379_1.actors_["10058ui_story"]) and arg_379_1.var_.characterEffect10058ui_story == nil then
				arg_379_1.var_.characterEffect10058ui_story = arg_379_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_0 = 0.0166666666666667

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_0 and not isNil(arg_379_1.actors_["10058ui_story"]) then
				if arg_379_1.var_.characterEffect10058ui_story and not isNil(arg_379_1.actors_["10058ui_story"]) then
					arg_379_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= 0 + var_382_0 and arg_379_1.time_ < 0 + var_382_0 + arg_382_0 and not isNil(arg_379_1.actors_["10058ui_story"]) and arg_379_1.var_.characterEffect10058ui_story then
				arg_379_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095actionlink/1095action442")
			end

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_382_2 = 0
			local var_382_3 = 0.275

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_2 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_4 = arg_379_1:GetWordFromCfg(1109502094)
				local var_382_5 = arg_379_1:FormatText(var_382_4.content)

				arg_379_1.text_.text = var_382_5

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_7 = 11 <= 0 and var_382_3 or var_382_3 * (utf8.len(var_382_5) / 11)

				if (11 <= 0 and var_382_3 or var_382_3 * (utf8.len(var_382_5) / 11)) > 0 and var_382_3 < var_382_7 then
					arg_379_1.talkMaxDuration = var_382_7

					if var_382_7 + var_382_2 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_7 + var_382_2
					end
				end

				arg_379_1.text_.text = var_382_5
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502094", "story_v_side_new_1109502.awb") ~= 0 then
					local var_382_8 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502094", "story_v_side_new_1109502.awb") / 1000

					if var_382_8 + var_382_2 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_8 + var_382_2
					end

					if var_382_4.prefab_name ~= "" and arg_379_1.actors_[var_382_4.prefab_name] ~= nil then
						local var_382_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_4.prefab_name].transform, "story_v_side_new_1109502", "1109502094", "story_v_side_new_1109502.awb")

						arg_379_1:RecordAudio("1109502094", var_382_9)
						arg_379_1:RecordAudio("1109502094", var_382_9)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502094", "story_v_side_new_1109502.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502094", "story_v_side_new_1109502.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_10 = math.max(var_382_3, arg_379_1.talkMaxDuration)

			if var_382_2 <= arg_379_1.time_ and arg_379_1.time_ < var_382_2 + var_382_10 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_2) / var_382_10

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_2 + var_382_10 and arg_379_1.time_ < var_382_2 + var_382_10 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play1109502095 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 1109502095
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play1109502096(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(arg_383_1.actors_["10058ui_story"]) and arg_383_1.var_.characterEffect10058ui_story == nil then
				arg_383_1.var_.characterEffect10058ui_story = arg_383_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_0 = 0.0166666666666667

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_0 and not isNil(arg_383_1.actors_["10058ui_story"]) then
				if arg_383_1.var_.characterEffect10058ui_story and not isNil(arg_383_1.actors_["10058ui_story"]) then
					arg_383_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_383_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_383_1.time_ - 0) / var_386_0)
				end
			end

			if arg_383_1.time_ >= 0 + var_386_0 and arg_383_1.time_ < 0 + var_386_0 + arg_386_0 and not isNil(arg_383_1.actors_["10058ui_story"]) and arg_383_1.var_.characterEffect10058ui_story then
				arg_383_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_383_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_386_1 = 0
			local var_386_2 = 0.6

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, false)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_3 = arg_383_1:FormatText(arg_383_1:GetWordFromCfg(1109502095).content)

				arg_383_1.text_.text = var_386_3

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_5 = 24 <= 0 and var_386_2 or var_386_2 * (utf8.len(var_386_3) / 24)

				if (24 <= 0 and var_386_2 or var_386_2 * (utf8.len(var_386_3) / 24)) > 0 and var_386_2 < var_386_5 then
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
	Play1109502096 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 1109502096
		arg_387_1.duration_ = 4

		local var_387_0 = {
			zh = 1.933,
			ja = 4
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
				arg_387_0:Play1109502097(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 0.225

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[664].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, true)
				arg_387_1.iconController_:SetSelectedState("hero")

				arg_387_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_387_1.callingController_:SetSelectedState("normal")

				arg_387_1.keyicon_.color = Color.New(1, 1, 1)
				arg_387_1.icon_.color = Color.New(1, 1, 1)

				local var_390_1 = arg_387_1:GetWordFromCfg(1109502096)
				local var_390_2 = arg_387_1:FormatText(var_390_1.content)

				arg_387_1.text_.text = var_390_2

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_4 = 9 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_2) / 9)

				if (9 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_2) / 9)) > 0 and var_390_0 < var_390_4 then
					arg_387_1.talkMaxDuration = var_390_4

					if var_390_4 + 0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_4 + 0
					end
				end

				arg_387_1.text_.text = var_390_2
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502096", "story_v_side_new_1109502.awb") ~= 0 then
					local var_390_5 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502096", "story_v_side_new_1109502.awb") / 1000

					if var_390_5 + 0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_5 + 0
					end

					if var_390_1.prefab_name ~= "" and arg_387_1.actors_[var_390_1.prefab_name] ~= nil then
						local var_390_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_1.prefab_name].transform, "story_v_side_new_1109502", "1109502096", "story_v_side_new_1109502.awb")

						arg_387_1:RecordAudio("1109502096", var_390_6)
						arg_387_1:RecordAudio("1109502096", var_390_6)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502096", "story_v_side_new_1109502.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502096", "story_v_side_new_1109502.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_7 = math.max(var_390_0, arg_387_1.talkMaxDuration)

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_7 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - 0) / var_390_7

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= 0 + var_390_7 and arg_387_1.time_ < 0 + var_390_7 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play1109502097 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 1109502097
		arg_391_1.duration_ = 6

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play1109502098(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.var_.moveOldPos10058ui_story = arg_391_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_394_0 = 0.001

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_0 then
				arg_391_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_391_1.time_ - 0) / var_394_0)
				arg_391_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_391_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["10058ui_story"].transform.position).z)
				arg_391_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_391_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_391_1.actors_["10058ui_story"].transform.localEulerAngles = arg_391_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_391_1.time_ >= 0 + var_394_0 and arg_391_1.time_ < 0 + var_394_0 + arg_394_0 then
				arg_391_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_391_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_391_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["10058ui_story"].transform.position).z)
				arg_391_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_391_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_391_1.actors_["10058ui_story"].transform.localEulerAngles = arg_391_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_394_1 = 0

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_1 + arg_394_0 then
				arg_391_1.mask_.enabled = true
				arg_391_1.mask_.raycastTarget = true

				arg_391_1:SetGaussion(false)
			end

			local var_394_2 = 1

			if var_394_1 <= arg_391_1.time_ and arg_391_1.time_ < var_394_1 + var_394_2 then
				local var_394_3 = Color.New(1, 1, 1)

				var_394_3.a = Mathf.Lerp(1, 0, (arg_391_1.time_ - var_394_1) / var_394_2)
				arg_391_1.mask_.color = var_394_3
			end

			if arg_391_1.time_ >= var_394_1 + var_394_2 and arg_391_1.time_ < var_394_1 + var_394_2 + arg_394_0 then
				local var_394_4 = Color.New(1, 1, 1)

				arg_391_1.mask_.enabled = false
				var_394_4.a = 0
				arg_391_1.mask_.color = var_394_4
			end

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1:AudioAction("play", "effect", "se_story_16", "se_story_16_camera", "")
			end

			if arg_391_1.frameCnt_ <= 1 then
				arg_391_1.dialog_:SetActive(false)
			end

			local var_394_6 = 1
			local var_394_7 = 0.575

			if 1 < arg_391_1.time_ and arg_391_1.time_ <= var_394_6 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0

				arg_391_1.dialog_:SetActive(true)

				arg_391_1.dialogCg_.alpha = 0

				local var_394_8 = LeanTween.value(arg_391_1.dialog_, 0, 1, 0.3)

				var_394_8:setOnUpdate(LuaHelper.FloatAction(function(arg_395_0)
					arg_391_1.dialogCg_.alpha = arg_395_0
				end))
				var_394_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_391_1.dialog_)
					var_394_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_391_1.duration_ = arg_391_1.duration_ + 0.3

				SetActive(arg_391_1.leftNameGo_, false)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_9 = arg_391_1:FormatText(arg_391_1:GetWordFromCfg(1109502097).content)

				arg_391_1.text_.text = var_394_9

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_11 = 23 <= 0 and var_394_7 or var_394_7 * (utf8.len(var_394_9) / 23)

				if (23 <= 0 and var_394_7 or var_394_7 * (utf8.len(var_394_9) / 23)) > 0 and var_394_7 < var_394_11 then
					arg_391_1.talkMaxDuration = var_394_11
					var_394_6 = var_394_6 + 0.3

					if var_394_11 + var_394_6 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_11 + var_394_6
					end
				end

				arg_391_1.text_.text = var_394_9
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_12 = var_394_6 + 0.3
			local var_394_13 = math.max(var_394_7, arg_391_1.talkMaxDuration)

			if var_394_6 + 0.3 <= arg_391_1.time_ and arg_391_1.time_ < var_394_12 + var_394_13 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_12) / var_394_13

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_12 + var_394_13 and arg_391_1.time_ < var_394_12 + var_394_13 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_391_1:InitPlayNodeList()
	end,
	Play1109502098 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 1109502098
		arg_397_1.duration_ = 12.1

		local var_397_0 = {
			zh = 8.5,
			ja = 12.1
		}
		local var_397_1 = manager.audio:GetLocalizationFlag()

		if var_397_0[var_397_1] ~= nil then
			arg_397_1.duration_ = var_397_0[var_397_1]
		end

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play1109502099(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 0.775

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[664].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, true)
				arg_397_1.iconController_:SetSelectedState("hero")

				arg_397_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_397_1.callingController_:SetSelectedState("normal")

				arg_397_1.keyicon_.color = Color.New(1, 1, 1)
				arg_397_1.icon_.color = Color.New(1, 1, 1)

				local var_400_1 = arg_397_1:GetWordFromCfg(1109502098)
				local var_400_2 = arg_397_1:FormatText(var_400_1.content)

				arg_397_1.text_.text = var_400_2

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_4 = 31 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_2) / 31)

				if (31 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_2) / 31)) > 0 and var_400_0 < var_400_4 then
					arg_397_1.talkMaxDuration = var_400_4

					if var_400_4 + 0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_4 + 0
					end
				end

				arg_397_1.text_.text = var_400_2
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502098", "story_v_side_new_1109502.awb") ~= 0 then
					local var_400_5 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502098", "story_v_side_new_1109502.awb") / 1000

					if var_400_5 + 0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_5 + 0
					end

					if var_400_1.prefab_name ~= "" and arg_397_1.actors_[var_400_1.prefab_name] ~= nil then
						local var_400_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_1.prefab_name].transform, "story_v_side_new_1109502", "1109502098", "story_v_side_new_1109502.awb")

						arg_397_1:RecordAudio("1109502098", var_400_6)
						arg_397_1:RecordAudio("1109502098", var_400_6)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502098", "story_v_side_new_1109502.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502098", "story_v_side_new_1109502.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_7 = math.max(var_400_0, arg_397_1.talkMaxDuration)

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_7 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - 0) / var_400_7

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= 0 + var_400_7 and arg_397_1.time_ < 0 + var_400_7 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play1109502099 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 1109502099
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play1109502100(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0.875

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, true)
				arg_401_1.iconController_:SetSelectedState("hero")

				arg_401_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_401_1.callingController_:SetSelectedState("normal")

				arg_401_1.keyicon_.color = Color.New(1, 1, 1)
				arg_401_1.icon_.color = Color.New(1, 1, 1)

				local var_404_1 = arg_401_1:FormatText(arg_401_1:GetWordFromCfg(1109502099).content)

				arg_401_1.text_.text = var_404_1

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_3 = 35 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_1) / 35)

				if (35 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_1) / 35)) > 0 and var_404_0 < var_404_3 then
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
	Play1109502100 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 1109502100
		arg_405_1.duration_ = 2.73

		local var_405_0 = {
			zh = 1.999999999999,
			ja = 2.733
		}
		local var_405_1 = manager.audio:GetLocalizationFlag()

		if var_405_0[var_405_1] ~= nil then
			arg_405_1.duration_ = var_405_0[var_405_1]
		end

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play1109502101(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_408_0 = arg_405_1.actors_["10058ui_story"]

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(var_408_0) and arg_405_1.var_.characterEffect10058ui_story == nil then
				arg_405_1.var_.characterEffect10058ui_story = var_408_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_1 = 0.0166666666666667

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_1 and not isNil(var_408_0) then
				if arg_405_1.var_.characterEffect10058ui_story and not isNil(var_408_0) then
					arg_405_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_405_1.time_ >= 0 + var_408_1 and arg_405_1.time_ < 0 + var_408_1 + arg_408_0 and not isNil(var_408_0) and arg_405_1.var_.characterEffect10058ui_story then
				arg_405_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_408_3 = arg_405_1.actors_["10058ui_story"].transform

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.var_.moveOldPos10058ui_story = var_408_3.localPosition
			end

			local var_408_4 = 0.001

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_4 then
				var_408_3.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_405_1.time_ - 0) / var_408_4)
				var_408_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_408_3.position).x, (manager.ui.mainCamera.transform.position - var_408_3.position).y, (manager.ui.mainCamera.transform.position - var_408_3.position).z)
				var_408_3.localEulerAngles.z = 0
				var_408_3.localEulerAngles.x = 0
				var_408_3.localEulerAngles = var_408_3.localEulerAngles
			end

			if arg_405_1.time_ >= 0 + var_408_4 and arg_405_1.time_ < 0 + var_408_4 + arg_408_0 then
				var_408_3.localPosition = Vector3.New(0, -0.98, -6.1)
				var_408_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_408_3.position).x, (manager.ui.mainCamera.transform.position - var_408_3.position).y, (manager.ui.mainCamera.transform.position - var_408_3.position).z)
				var_408_3.localEulerAngles.z = 0
				var_408_3.localEulerAngles.x = 0
				var_408_3.localEulerAngles = var_408_3.localEulerAngles
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_408_5 = 0
			local var_408_6 = 0.1

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_5 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_7 = arg_405_1:GetWordFromCfg(1109502100)
				local var_408_8 = arg_405_1:FormatText(var_408_7.content)

				arg_405_1.text_.text = var_408_8

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_10 = 4 <= 0 and var_408_6 or var_408_6 * (utf8.len(var_408_8) / 4)

				if (4 <= 0 and var_408_6 or var_408_6 * (utf8.len(var_408_8) / 4)) > 0 and var_408_6 < var_408_10 then
					arg_405_1.talkMaxDuration = var_408_10

					if var_408_10 + var_408_5 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_10 + var_408_5
					end
				end

				arg_405_1.text_.text = var_408_8
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502100", "story_v_side_new_1109502.awb") ~= 0 then
					local var_408_11 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502100", "story_v_side_new_1109502.awb") / 1000

					if var_408_11 + var_408_5 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_11 + var_408_5
					end

					if var_408_7.prefab_name ~= "" and arg_405_1.actors_[var_408_7.prefab_name] ~= nil then
						local var_408_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_7.prefab_name].transform, "story_v_side_new_1109502", "1109502100", "story_v_side_new_1109502.awb")

						arg_405_1:RecordAudio("1109502100", var_408_12)
						arg_405_1:RecordAudio("1109502100", var_408_12)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502100", "story_v_side_new_1109502.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502100", "story_v_side_new_1109502.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_13 = math.max(var_408_6, arg_405_1.talkMaxDuration)

			if var_408_5 <= arg_405_1.time_ and arg_405_1.time_ < var_408_5 + var_408_13 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_5) / var_408_13

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_5 + var_408_13 and arg_405_1.time_ < var_408_5 + var_408_13 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_405_1:InitPlayNodeList()
	end,
	Play1109502101 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 1109502101
		arg_409_1.duration_ = 12.4

		local var_409_0 = {
			zh = 7.033,
			ja = 12.4
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
				arg_409_0:Play1109502102(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(arg_409_1.actors_["10058ui_story"]) and arg_409_1.var_.characterEffect10058ui_story == nil then
				arg_409_1.var_.characterEffect10058ui_story = arg_409_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_0 = 0.0166666666666667

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 and not isNil(arg_409_1.actors_["10058ui_story"]) then
				if arg_409_1.var_.characterEffect10058ui_story and not isNil(arg_409_1.actors_["10058ui_story"]) then
					arg_409_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_409_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_409_1.time_ - 0) / var_412_0)
				end
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 and not isNil(arg_409_1.actors_["10058ui_story"]) and arg_409_1.var_.characterEffect10058ui_story then
				arg_409_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_409_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_412_1 = 0
			local var_412_2 = 0.75

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[664].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, true)
				arg_409_1.iconController_:SetSelectedState("hero")

				arg_409_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_409_1.callingController_:SetSelectedState("normal")

				arg_409_1.keyicon_.color = Color.New(1, 1, 1)
				arg_409_1.icon_.color = Color.New(1, 1, 1)

				local var_412_3 = arg_409_1:GetWordFromCfg(1109502101)
				local var_412_4 = arg_409_1:FormatText(var_412_3.content)

				arg_409_1.text_.text = var_412_4

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_6 = 30 <= 0 and var_412_2 or var_412_2 * (utf8.len(var_412_4) / 30)

				if (30 <= 0 and var_412_2 or var_412_2 * (utf8.len(var_412_4) / 30)) > 0 and var_412_2 < var_412_6 then
					arg_409_1.talkMaxDuration = var_412_6

					if var_412_6 + var_412_1 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_6 + var_412_1
					end
				end

				arg_409_1.text_.text = var_412_4
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502101", "story_v_side_new_1109502.awb") ~= 0 then
					local var_412_7 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502101", "story_v_side_new_1109502.awb") / 1000

					if var_412_7 + var_412_1 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_7 + var_412_1
					end

					if var_412_3.prefab_name ~= "" and arg_409_1.actors_[var_412_3.prefab_name] ~= nil then
						local var_412_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_3.prefab_name].transform, "story_v_side_new_1109502", "1109502101", "story_v_side_new_1109502.awb")

						arg_409_1:RecordAudio("1109502101", var_412_8)
						arg_409_1:RecordAudio("1109502101", var_412_8)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502101", "story_v_side_new_1109502.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502101", "story_v_side_new_1109502.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_9 = math.max(var_412_2, arg_409_1.talkMaxDuration)

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_9 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_1) / var_412_9

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_1 + var_412_9 and arg_409_1.time_ < var_412_1 + var_412_9 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play1109502102 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 1109502102
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play1109502103(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.var_.moveOldPos10058ui_story = arg_413_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_416_0 = 0.001

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_0 then
				arg_413_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_413_1.time_ - 0) / var_416_0)
				arg_413_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_413_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["10058ui_story"].transform.position).z)
				arg_413_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_413_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_413_1.actors_["10058ui_story"].transform.localEulerAngles = arg_413_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_413_1.time_ >= 0 + var_416_0 and arg_413_1.time_ < 0 + var_416_0 + arg_416_0 then
				arg_413_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_413_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_413_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["10058ui_story"].transform.position).z)
				arg_413_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_413_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_413_1.actors_["10058ui_story"].transform.localEulerAngles = arg_413_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_416_1 = 0
			local var_416_2 = 0.825

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, false)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_3 = arg_413_1:FormatText(arg_413_1:GetWordFromCfg(1109502102).content)

				arg_413_1.text_.text = var_416_3

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_5 = 33 <= 0 and var_416_2 or var_416_2 * (utf8.len(var_416_3) / 33)

				if (33 <= 0 and var_416_2 or var_416_2 * (utf8.len(var_416_3) / 33)) > 0 and var_416_2 < var_416_5 then
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

		arg_413_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_413_1:InitPlayNodeList()
	end,
	Play1109502103 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 1109502103
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play1109502104(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = 0.35

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, true)
				arg_417_1.iconController_:SetSelectedState("hero")

				arg_417_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_417_1.callingController_:SetSelectedState("normal")

				arg_417_1.keyicon_.color = Color.New(1, 1, 1)
				arg_417_1.icon_.color = Color.New(1, 1, 1)

				local var_420_1 = arg_417_1:FormatText(arg_417_1:GetWordFromCfg(1109502103).content)

				arg_417_1.text_.text = var_420_1

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_3 = 14 <= 0 and var_420_0 or var_420_0 * (utf8.len(var_420_1) / 14)

				if (14 <= 0 and var_420_0 or var_420_0 * (utf8.len(var_420_1) / 14)) > 0 and var_420_0 < var_420_3 then
					arg_417_1.talkMaxDuration = var_420_3

					if var_420_3 + 0 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_3 + 0
					end
				end

				arg_417_1.text_.text = var_420_1
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_4 = math.max(var_420_0, arg_417_1.talkMaxDuration)

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_4 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - 0) / var_420_4

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= 0 + var_420_4 and arg_417_1.time_ < 0 + var_420_4 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play1109502104 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 1109502104
		arg_421_1.duration_ = 11.33

		local var_421_0 = {
			zh = 6.533,
			ja = 11.333
		}
		local var_421_1 = manager.audio:GetLocalizationFlag()

		if var_421_0[var_421_1] ~= nil then
			arg_421_1.duration_ = var_421_0[var_421_1]
		end

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play1109502105(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = 0.75

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[664].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, true)
				arg_421_1.iconController_:SetSelectedState("hero")

				arg_421_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_421_1.callingController_:SetSelectedState("normal")

				arg_421_1.keyicon_.color = Color.New(1, 1, 1)
				arg_421_1.icon_.color = Color.New(1, 1, 1)

				local var_424_1 = arg_421_1:GetWordFromCfg(1109502104)
				local var_424_2 = arg_421_1:FormatText(var_424_1.content)

				arg_421_1.text_.text = var_424_2

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_4 = 30 <= 0 and var_424_0 or var_424_0 * (utf8.len(var_424_2) / 30)

				if (30 <= 0 and var_424_0 or var_424_0 * (utf8.len(var_424_2) / 30)) > 0 and var_424_0 < var_424_4 then
					arg_421_1.talkMaxDuration = var_424_4

					if var_424_4 + 0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_4 + 0
					end
				end

				arg_421_1.text_.text = var_424_2
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502104", "story_v_side_new_1109502.awb") ~= 0 then
					local var_424_5 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502104", "story_v_side_new_1109502.awb") / 1000

					if var_424_5 + 0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_5 + 0
					end

					if var_424_1.prefab_name ~= "" and arg_421_1.actors_[var_424_1.prefab_name] ~= nil then
						local var_424_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_1.prefab_name].transform, "story_v_side_new_1109502", "1109502104", "story_v_side_new_1109502.awb")

						arg_421_1:RecordAudio("1109502104", var_424_6)
						arg_421_1:RecordAudio("1109502104", var_424_6)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502104", "story_v_side_new_1109502.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502104", "story_v_side_new_1109502.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_7 = math.max(var_424_0, arg_421_1.talkMaxDuration)

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_7 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - 0) / var_424_7

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= 0 + var_424_7 and arg_421_1.time_ < 0 + var_424_7 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play1109502105 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 1109502105
		arg_425_1.duration_ = 5

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play1109502106(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = 0.4

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, true)
				arg_425_1.iconController_:SetSelectedState("hero")

				arg_425_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_425_1.callingController_:SetSelectedState("normal")

				arg_425_1.keyicon_.color = Color.New(1, 1, 1)
				arg_425_1.icon_.color = Color.New(1, 1, 1)

				local var_428_1 = arg_425_1:FormatText(arg_425_1:GetWordFromCfg(1109502105).content)

				arg_425_1.text_.text = var_428_1

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_3 = 16 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_1) / 16)

				if (16 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_1) / 16)) > 0 and var_428_0 < var_428_3 then
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
	Play1109502106 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 1109502106
		arg_429_1.duration_ = 8.5

		local var_429_0 = {
			zh = 3.8,
			ja = 8.5
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
				arg_429_0:Play1109502107(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = 0.375

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				arg_429_1.leftNameTxt_.text = arg_429_1:FormatText(StoryNameCfg[664].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, true)
				arg_429_1.iconController_:SetSelectedState("hero")

				arg_429_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_429_1.callingController_:SetSelectedState("normal")

				arg_429_1.keyicon_.color = Color.New(1, 1, 1)
				arg_429_1.icon_.color = Color.New(1, 1, 1)

				local var_432_1 = arg_429_1:GetWordFromCfg(1109502106)
				local var_432_2 = arg_429_1:FormatText(var_432_1.content)

				arg_429_1.text_.text = var_432_2

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_4 = 15 <= 0 and var_432_0 or var_432_0 * (utf8.len(var_432_2) / 15)

				if (15 <= 0 and var_432_0 or var_432_0 * (utf8.len(var_432_2) / 15)) > 0 and var_432_0 < var_432_4 then
					arg_429_1.talkMaxDuration = var_432_4

					if var_432_4 + 0 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_4 + 0
					end
				end

				arg_429_1.text_.text = var_432_2
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502106", "story_v_side_new_1109502.awb") ~= 0 then
					local var_432_5 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502106", "story_v_side_new_1109502.awb") / 1000

					if var_432_5 + 0 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_5 + 0
					end

					if var_432_1.prefab_name ~= "" and arg_429_1.actors_[var_432_1.prefab_name] ~= nil then
						local var_432_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_1.prefab_name].transform, "story_v_side_new_1109502", "1109502106", "story_v_side_new_1109502.awb")

						arg_429_1:RecordAudio("1109502106", var_432_6)
						arg_429_1:RecordAudio("1109502106", var_432_6)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502106", "story_v_side_new_1109502.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502106", "story_v_side_new_1109502.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_7 = math.max(var_432_0, arg_429_1.talkMaxDuration)

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_7 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - 0) / var_432_7

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= 0 + var_432_7 and arg_429_1.time_ < 0 + var_432_7 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play1109502107 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 1109502107
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play1109502108(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = 0.55

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
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

				local var_436_1 = arg_433_1:FormatText(arg_433_1:GetWordFromCfg(1109502107).content)

				arg_433_1.text_.text = var_436_1

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_3 = 22 <= 0 and var_436_0 or var_436_0 * (utf8.len(var_436_1) / 22)

				if (22 <= 0 and var_436_0 or var_436_0 * (utf8.len(var_436_1) / 22)) > 0 and var_436_0 < var_436_3 then
					arg_433_1.talkMaxDuration = var_436_3

					if var_436_3 + 0 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_3 + 0
					end
				end

				arg_433_1.text_.text = var_436_1
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)
				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_4 = math.max(var_436_0, arg_433_1.talkMaxDuration)

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_4 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - 0) / var_436_4

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= 0 + var_436_4 and arg_433_1.time_ < 0 + var_436_4 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play1109502108 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 1109502108
		arg_437_1.duration_ = 7.03

		local var_437_0 = {
			zh = 4.866,
			ja = 7.033
		}
		local var_437_1 = manager.audio:GetLocalizationFlag()

		if var_437_0[var_437_1] ~= nil then
			arg_437_1.duration_ = var_437_0[var_437_1]
		end

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play1109502109(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = 0.65

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[664].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, true)
				arg_437_1.iconController_:SetSelectedState("hero")

				arg_437_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_437_1.callingController_:SetSelectedState("normal")

				arg_437_1.keyicon_.color = Color.New(1, 1, 1)
				arg_437_1.icon_.color = Color.New(1, 1, 1)

				local var_440_1 = arg_437_1:GetWordFromCfg(1109502108)
				local var_440_2 = arg_437_1:FormatText(var_440_1.content)

				arg_437_1.text_.text = var_440_2

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_4 = 26 <= 0 and var_440_0 or var_440_0 * (utf8.len(var_440_2) / 26)

				if (26 <= 0 and var_440_0 or var_440_0 * (utf8.len(var_440_2) / 26)) > 0 and var_440_0 < var_440_4 then
					arg_437_1.talkMaxDuration = var_440_4

					if var_440_4 + 0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_4 + 0
					end
				end

				arg_437_1.text_.text = var_440_2
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502108", "story_v_side_new_1109502.awb") ~= 0 then
					local var_440_5 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502108", "story_v_side_new_1109502.awb") / 1000

					if var_440_5 + 0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_5 + 0
					end

					if var_440_1.prefab_name ~= "" and arg_437_1.actors_[var_440_1.prefab_name] ~= nil then
						local var_440_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_1.prefab_name].transform, "story_v_side_new_1109502", "1109502108", "story_v_side_new_1109502.awb")

						arg_437_1:RecordAudio("1109502108", var_440_6)
						arg_437_1:RecordAudio("1109502108", var_440_6)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502108", "story_v_side_new_1109502.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502108", "story_v_side_new_1109502.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_7 = math.max(var_440_0, arg_437_1.talkMaxDuration)

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_7 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - 0) / var_440_7

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= 0 + var_440_7 and arg_437_1.time_ < 0 + var_440_7 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play1109502109 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 1109502109
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play1109502110(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = 0.2

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

				local var_444_1 = arg_441_1:FormatText(arg_441_1:GetWordFromCfg(1109502109).content)

				arg_441_1.text_.text = var_444_1

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_3 = 8 <= 0 and var_444_0 or var_444_0 * (utf8.len(var_444_1) / 8)

				if (8 <= 0 and var_444_0 or var_444_0 * (utf8.len(var_444_1) / 8)) > 0 and var_444_0 < var_444_3 then
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
	Play1109502110 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 1109502110
		arg_445_1.duration_ = 6.13

		local var_445_0 = {
			zh = 2.2,
			ja = 6.133
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
				arg_445_0:Play1109502111(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = 0.25

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				arg_445_1.leftNameTxt_.text = arg_445_1:FormatText(StoryNameCfg[664].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, true)
				arg_445_1.iconController_:SetSelectedState("hero")

				arg_445_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_445_1.callingController_:SetSelectedState("normal")

				arg_445_1.keyicon_.color = Color.New(1, 1, 1)
				arg_445_1.icon_.color = Color.New(1, 1, 1)

				local var_448_1 = arg_445_1:GetWordFromCfg(1109502110)
				local var_448_2 = arg_445_1:FormatText(var_448_1.content)

				arg_445_1.text_.text = var_448_2

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_4 = 10 <= 0 and var_448_0 or var_448_0 * (utf8.len(var_448_2) / 10)

				if (10 <= 0 and var_448_0 or var_448_0 * (utf8.len(var_448_2) / 10)) > 0 and var_448_0 < var_448_4 then
					arg_445_1.talkMaxDuration = var_448_4

					if var_448_4 + 0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_4 + 0
					end
				end

				arg_445_1.text_.text = var_448_2
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502110", "story_v_side_new_1109502.awb") ~= 0 then
					local var_448_5 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502110", "story_v_side_new_1109502.awb") / 1000

					if var_448_5 + 0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_5 + 0
					end

					if var_448_1.prefab_name ~= "" and arg_445_1.actors_[var_448_1.prefab_name] ~= nil then
						local var_448_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_1.prefab_name].transform, "story_v_side_new_1109502", "1109502110", "story_v_side_new_1109502.awb")

						arg_445_1:RecordAudio("1109502110", var_448_6)
						arg_445_1:RecordAudio("1109502110", var_448_6)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502110", "story_v_side_new_1109502.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502110", "story_v_side_new_1109502.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_7 = math.max(var_448_0, arg_445_1.talkMaxDuration)

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_7 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - 0) / var_448_7

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= 0 + var_448_7 and arg_445_1.time_ < 0 + var_448_7 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play1109502111 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 1109502111
		arg_449_1.duration_ = 1

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"

			SetActive(arg_449_1.choicesGo_, true)

			for iter_450_0, iter_450_1 in ipairs(arg_449_1.choices_) do
				SetActive(iter_450_1.go, iter_450_0 <= 2)
			end

			arg_449_1.choices_[1].txt.text = arg_449_1:FormatText(StoryChoiceCfg[720].name)
			arg_449_1.choices_[2].txt.text = arg_449_1:FormatText(StoryChoiceCfg[721].name)
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play1109502112(arg_449_1)
			end

			if arg_451_0 == 2 then
				arg_449_0:Play1109502112(arg_449_1)
			end

			arg_449_1:RecordChoiceLog(1109502111, 720, 721)
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.allBtn_.enabled = false
			end

			if arg_449_1.time_ >= 0 + 0.5 and arg_449_1.time_ < 0 + 0.5 + arg_452_0 then
				arg_449_1.allBtn_.enabled = true
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play1109502112 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 1109502112
		arg_453_1.duration_ = 2.9

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play1109502113(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = 0.375

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[664].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, true)
				arg_453_1.iconController_:SetSelectedState("hero")

				arg_453_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_453_1.callingController_:SetSelectedState("normal")

				arg_453_1.keyicon_.color = Color.New(1, 1, 1)
				arg_453_1.icon_.color = Color.New(1, 1, 1)

				local var_456_1 = arg_453_1:GetWordFromCfg(1109502112)
				local var_456_2 = arg_453_1:FormatText(var_456_1.content)

				arg_453_1.text_.text = var_456_2

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_4 = 15 <= 0 and var_456_0 or var_456_0 * (utf8.len(var_456_2) / 15)

				if (15 <= 0 and var_456_0 or var_456_0 * (utf8.len(var_456_2) / 15)) > 0 and var_456_0 < var_456_4 then
					arg_453_1.talkMaxDuration = var_456_4

					if var_456_4 + 0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_4 + 0
					end
				end

				arg_453_1.text_.text = var_456_2
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502112", "story_v_side_new_1109502.awb") ~= 0 then
					local var_456_5 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502112", "story_v_side_new_1109502.awb") / 1000

					if var_456_5 + 0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_5 + 0
					end

					if var_456_1.prefab_name ~= "" and arg_453_1.actors_[var_456_1.prefab_name] ~= nil then
						local var_456_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_1.prefab_name].transform, "story_v_side_new_1109502", "1109502112", "story_v_side_new_1109502.awb")

						arg_453_1:RecordAudio("1109502112", var_456_6)
						arg_453_1:RecordAudio("1109502112", var_456_6)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502112", "story_v_side_new_1109502.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502112", "story_v_side_new_1109502.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_7 = math.max(var_456_0, arg_453_1.talkMaxDuration)

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_7 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - 0) / var_456_7

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= 0 + var_456_7 and arg_453_1.time_ < 0 + var_456_7 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play1109502113 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 1109502113
		arg_457_1.duration_ = 4.73

		local var_457_0 = {
			zh = 1.133,
			ja = 4.733
		}
		local var_457_1 = manager.audio:GetLocalizationFlag()

		if var_457_0[var_457_1] ~= nil then
			arg_457_1.duration_ = var_457_0[var_457_1]
		end

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play1109502114(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.var_.moveOldPos10058ui_story = arg_457_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_460_0 = 0.001

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_0 then
				arg_457_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_457_1.time_ - 0) / var_460_0)
				arg_457_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_457_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["10058ui_story"].transform.position).z)
				arg_457_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_457_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_457_1.actors_["10058ui_story"].transform.localEulerAngles = arg_457_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_457_1.time_ >= 0 + var_460_0 and arg_457_1.time_ < 0 + var_460_0 + arg_460_0 then
				arg_457_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_457_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_457_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["10058ui_story"].transform.position).z)
				arg_457_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_457_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_457_1.actors_["10058ui_story"].transform.localEulerAngles = arg_457_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_460_1 = arg_457_1.actors_["10058ui_story"]

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 and not isNil(var_460_1) and arg_457_1.var_.characterEffect10058ui_story == nil then
				arg_457_1.var_.characterEffect10058ui_story = var_460_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_460_2 = 0.200000002980232

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_2 and not isNil(var_460_1) then
				if arg_457_1.var_.characterEffect10058ui_story and not isNil(var_460_1) then
					arg_457_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_457_1.time_ >= 0 + var_460_2 and arg_457_1.time_ < 0 + var_460_2 + arg_460_0 and not isNil(var_460_1) and arg_457_1.var_.characterEffect10058ui_story then
				arg_457_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_460_4 = 0
			local var_460_5 = 0.075

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_4 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_6 = arg_457_1:GetWordFromCfg(1109502113)
				local var_460_7 = arg_457_1:FormatText(var_460_6.content)

				arg_457_1.text_.text = var_460_7

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_9 = 3 <= 0 and var_460_5 or var_460_5 * (utf8.len(var_460_7) / 3)

				if (3 <= 0 and var_460_5 or var_460_5 * (utf8.len(var_460_7) / 3)) > 0 and var_460_5 < var_460_9 then
					arg_457_1.talkMaxDuration = var_460_9

					if var_460_9 + var_460_4 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_9 + var_460_4
					end
				end

				arg_457_1.text_.text = var_460_7
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502113", "story_v_side_new_1109502.awb") ~= 0 then
					local var_460_10 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502113", "story_v_side_new_1109502.awb") / 1000

					if var_460_10 + var_460_4 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_10 + var_460_4
					end

					if var_460_6.prefab_name ~= "" and arg_457_1.actors_[var_460_6.prefab_name] ~= nil then
						local var_460_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_6.prefab_name].transform, "story_v_side_new_1109502", "1109502113", "story_v_side_new_1109502.awb")

						arg_457_1:RecordAudio("1109502113", var_460_11)
						arg_457_1:RecordAudio("1109502113", var_460_11)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502113", "story_v_side_new_1109502.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502113", "story_v_side_new_1109502.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_12 = math.max(var_460_5, arg_457_1.talkMaxDuration)

			if var_460_4 <= arg_457_1.time_ and arg_457_1.time_ < var_460_4 + var_460_12 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_4) / var_460_12

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_4 + var_460_12 and arg_457_1.time_ < var_460_4 + var_460_12 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_457_1:InitPlayNodeList()
	end,
	Play1109502114 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 1109502114
		arg_461_1.duration_ = 3.77

		local var_461_0 = {
			zh = 0.999999999999,
			ja = 3.766
		}
		local var_461_1 = manager.audio:GetLocalizationFlag()

		if var_461_0[var_461_1] ~= nil then
			arg_461_1.duration_ = var_461_0[var_461_1]
		end

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play1109502115(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 and not isNil(arg_461_1.actors_["10058ui_story"]) and arg_461_1.var_.characterEffect10058ui_story == nil then
				arg_461_1.var_.characterEffect10058ui_story = arg_461_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_0 = 0.1

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_0 and not isNil(arg_461_1.actors_["10058ui_story"]) then
				if arg_461_1.var_.characterEffect10058ui_story and not isNil(arg_461_1.actors_["10058ui_story"]) then
					arg_461_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_461_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_461_1.time_ - 0) / var_464_0)
				end
			end

			if arg_461_1.time_ >= 0 + var_464_0 and arg_461_1.time_ < 0 + var_464_0 + arg_464_0 and not isNil(arg_461_1.actors_["10058ui_story"]) and arg_461_1.var_.characterEffect10058ui_story then
				arg_461_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_461_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_464_1 = 0
			local var_464_2 = 0.1

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_1 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[664].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, true)
				arg_461_1.iconController_:SetSelectedState("hero")

				arg_461_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_461_1.callingController_:SetSelectedState("normal")

				arg_461_1.keyicon_.color = Color.New(1, 1, 1)
				arg_461_1.icon_.color = Color.New(1, 1, 1)

				local var_464_3 = arg_461_1:GetWordFromCfg(1109502114)
				local var_464_4 = arg_461_1:FormatText(var_464_3.content)

				arg_461_1.text_.text = var_464_4

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_6 = 4 <= 0 and var_464_2 or var_464_2 * (utf8.len(var_464_4) / 4)

				if (4 <= 0 and var_464_2 or var_464_2 * (utf8.len(var_464_4) / 4)) > 0 and var_464_2 < var_464_6 then
					arg_461_1.talkMaxDuration = var_464_6

					if var_464_6 + var_464_1 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_6 + var_464_1
					end
				end

				arg_461_1.text_.text = var_464_4
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502114", "story_v_side_new_1109502.awb") ~= 0 then
					local var_464_7 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502114", "story_v_side_new_1109502.awb") / 1000

					if var_464_7 + var_464_1 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_7 + var_464_1
					end

					if var_464_3.prefab_name ~= "" and arg_461_1.actors_[var_464_3.prefab_name] ~= nil then
						local var_464_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_3.prefab_name].transform, "story_v_side_new_1109502", "1109502114", "story_v_side_new_1109502.awb")

						arg_461_1:RecordAudio("1109502114", var_464_8)
						arg_461_1:RecordAudio("1109502114", var_464_8)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502114", "story_v_side_new_1109502.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502114", "story_v_side_new_1109502.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_9 = math.max(var_464_2, arg_461_1.talkMaxDuration)

			if var_464_1 <= arg_461_1.time_ and arg_461_1.time_ < var_464_1 + var_464_9 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_1) / var_464_9

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_1 + var_464_9 and arg_461_1.time_ < var_464_1 + var_464_9 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play1109502115 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 1109502115
		arg_465_1.duration_ = 2.8

		local var_465_0 = {
			zh = 2.8,
			ja = 2.333
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
				arg_465_0:Play1109502116(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 and not isNil(arg_465_1.actors_["10058ui_story"]) and arg_465_1.var_.characterEffect10058ui_story == nil then
				arg_465_1.var_.characterEffect10058ui_story = arg_465_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_0 = 0.200000002980232

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_0 and not isNil(arg_465_1.actors_["10058ui_story"]) then
				if arg_465_1.var_.characterEffect10058ui_story and not isNil(arg_465_1.actors_["10058ui_story"]) then
					arg_465_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_465_1.time_ >= 0 + var_468_0 and arg_465_1.time_ < 0 + var_468_0 + arg_468_0 and not isNil(arg_465_1.actors_["10058ui_story"]) and arg_465_1.var_.characterEffect10058ui_story then
				arg_465_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_468_2 = 0
			local var_468_3 = 0.35

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_2 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				arg_465_1.leftNameTxt_.text = arg_465_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_4 = arg_465_1:GetWordFromCfg(1109502115)
				local var_468_5 = arg_465_1:FormatText(var_468_4.content)

				arg_465_1.text_.text = var_468_5

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_7 = 14 <= 0 and var_468_3 or var_468_3 * (utf8.len(var_468_5) / 14)

				if (14 <= 0 and var_468_3 or var_468_3 * (utf8.len(var_468_5) / 14)) > 0 and var_468_3 < var_468_7 then
					arg_465_1.talkMaxDuration = var_468_7

					if var_468_7 + var_468_2 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_7 + var_468_2
					end
				end

				arg_465_1.text_.text = var_468_5
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502115", "story_v_side_new_1109502.awb") ~= 0 then
					local var_468_8 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502115", "story_v_side_new_1109502.awb") / 1000

					if var_468_8 + var_468_2 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_8 + var_468_2
					end

					if var_468_4.prefab_name ~= "" and arg_465_1.actors_[var_468_4.prefab_name] ~= nil then
						local var_468_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_4.prefab_name].transform, "story_v_side_new_1109502", "1109502115", "story_v_side_new_1109502.awb")

						arg_465_1:RecordAudio("1109502115", var_468_9)
						arg_465_1:RecordAudio("1109502115", var_468_9)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502115", "story_v_side_new_1109502.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502115", "story_v_side_new_1109502.awb")
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
	Play1109502116 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 1109502116
		arg_469_1.duration_ = 4.3

		local var_469_0 = {
			zh = 2.933,
			ja = 4.3
		}
		local var_469_1 = manager.audio:GetLocalizationFlag()

		if var_469_0[var_469_1] ~= nil then
			arg_469_1.duration_ = var_469_0[var_469_1]
		end

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play1109502117(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 and not isNil(arg_469_1.actors_["10058ui_story"]) and arg_469_1.var_.characterEffect10058ui_story == nil then
				arg_469_1.var_.characterEffect10058ui_story = arg_469_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_0 = 0.200000002980232

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_0 and not isNil(arg_469_1.actors_["10058ui_story"]) then
				if arg_469_1.var_.characterEffect10058ui_story and not isNil(arg_469_1.actors_["10058ui_story"]) then
					arg_469_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_469_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_469_1.time_ - 0) / var_472_0)
				end
			end

			if arg_469_1.time_ >= 0 + var_472_0 and arg_469_1.time_ < 0 + var_472_0 + arg_472_0 and not isNil(arg_469_1.actors_["10058ui_story"]) and arg_469_1.var_.characterEffect10058ui_story then
				arg_469_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_469_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_472_1 = 0
			local var_472_2 = 0.25

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_1 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				arg_469_1.leftNameTxt_.text = arg_469_1:FormatText(StoryNameCfg[664].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, true)
				arg_469_1.iconController_:SetSelectedState("hero")

				arg_469_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_469_1.callingController_:SetSelectedState("normal")

				arg_469_1.keyicon_.color = Color.New(1, 1, 1)
				arg_469_1.icon_.color = Color.New(1, 1, 1)

				local var_472_3 = arg_469_1:GetWordFromCfg(1109502116)
				local var_472_4 = arg_469_1:FormatText(var_472_3.content)

				arg_469_1.text_.text = var_472_4

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_6 = 10 <= 0 and var_472_2 or var_472_2 * (utf8.len(var_472_4) / 10)

				if (10 <= 0 and var_472_2 or var_472_2 * (utf8.len(var_472_4) / 10)) > 0 and var_472_2 < var_472_6 then
					arg_469_1.talkMaxDuration = var_472_6

					if var_472_6 + var_472_1 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_6 + var_472_1
					end
				end

				arg_469_1.text_.text = var_472_4
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502116", "story_v_side_new_1109502.awb") ~= 0 then
					local var_472_7 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502116", "story_v_side_new_1109502.awb") / 1000

					if var_472_7 + var_472_1 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_7 + var_472_1
					end

					if var_472_3.prefab_name ~= "" and arg_469_1.actors_[var_472_3.prefab_name] ~= nil then
						local var_472_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_3.prefab_name].transform, "story_v_side_new_1109502", "1109502116", "story_v_side_new_1109502.awb")

						arg_469_1:RecordAudio("1109502116", var_472_8)
						arg_469_1:RecordAudio("1109502116", var_472_8)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502116", "story_v_side_new_1109502.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502116", "story_v_side_new_1109502.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_9 = math.max(var_472_2, arg_469_1.talkMaxDuration)

			if var_472_1 <= arg_469_1.time_ and arg_469_1.time_ < var_472_1 + var_472_9 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_1) / var_472_9

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_1 + var_472_9 and arg_469_1.time_ < var_472_1 + var_472_9 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play1109502117 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 1109502117
		arg_473_1.duration_ = 3.53

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play1109502118(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1.var_.moveOldPos10058ui_story = arg_473_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_476_0 = 0.001

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_0 then
				arg_473_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_473_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_473_1.time_ - 0) / var_476_0)
				arg_473_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_473_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["10058ui_story"].transform.position).z)
				arg_473_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_473_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_473_1.actors_["10058ui_story"].transform.localEulerAngles = arg_473_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_473_1.time_ >= 0 + var_476_0 and arg_473_1.time_ < 0 + var_476_0 + arg_476_0 then
				arg_473_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_473_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_473_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["10058ui_story"].transform.position).z)
				arg_473_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_473_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_473_1.actors_["10058ui_story"].transform.localEulerAngles = arg_473_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_476_1 = 0
			local var_476_2 = 0.8

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_1 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, false)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_3 = arg_473_1:GetWordFromCfg(1109502117)
				local var_476_4 = arg_473_1:FormatText(var_476_3.content)

				arg_473_1.text_.text = var_476_4

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_6 = 32 <= 0 and var_476_2 or var_476_2 * (utf8.len(var_476_4) / 32)

				if (32 <= 0 and var_476_2 or var_476_2 * (utf8.len(var_476_4) / 32)) > 0 and var_476_2 < var_476_6 then
					arg_473_1.talkMaxDuration = var_476_6

					if var_476_6 + var_476_1 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_6 + var_476_1
					end
				end

				arg_473_1.text_.text = var_476_4
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502117", "story_v_side_new_1109502.awb") ~= 0 then
					local var_476_7 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502117", "story_v_side_new_1109502.awb") / 1000

					if var_476_7 + var_476_1 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_7 + var_476_1
					end

					if var_476_3.prefab_name ~= "" and arg_473_1.actors_[var_476_3.prefab_name] ~= nil then
						local var_476_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_3.prefab_name].transform, "story_v_side_new_1109502", "1109502117", "story_v_side_new_1109502.awb")

						arg_473_1:RecordAudio("1109502117", var_476_8)
						arg_473_1:RecordAudio("1109502117", var_476_8)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502117", "story_v_side_new_1109502.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502117", "story_v_side_new_1109502.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_9 = math.max(var_476_2, arg_473_1.talkMaxDuration)

			if var_476_1 <= arg_473_1.time_ and arg_473_1.time_ < var_476_1 + var_476_9 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_1) / var_476_9

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_1 + var_476_9 and arg_473_1.time_ < var_476_1 + var_476_9 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_473_1:InitPlayNodeList()
	end,
	Play1109502118 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 1109502118
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play1109502119(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = 0.3

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
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

				local var_480_1 = arg_477_1:FormatText(arg_477_1:GetWordFromCfg(1109502118).content)

				arg_477_1.text_.text = var_480_1

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_3 = 12 <= 0 and var_480_0 or var_480_0 * (utf8.len(var_480_1) / 12)

				if (12 <= 0 and var_480_0 or var_480_0 * (utf8.len(var_480_1) / 12)) > 0 and var_480_0 < var_480_3 then
					arg_477_1.talkMaxDuration = var_480_3

					if var_480_3 + 0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_3 + 0
					end
				end

				arg_477_1.text_.text = var_480_1
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_4 = math.max(var_480_0, arg_477_1.talkMaxDuration)

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_4 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - 0) / var_480_4

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= 0 + var_480_4 and arg_477_1.time_ < 0 + var_480_4 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play1109502119 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 1109502119
		arg_481_1.duration_ = 2.5

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play1109502120(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.var_.moveOldPos10058ui_story = arg_481_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_484_0 = 0.001

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_0 then
				arg_481_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_481_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_481_1.time_ - 0) / var_484_0)
				arg_481_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_481_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["10058ui_story"].transform.position).z)
				arg_481_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_481_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_481_1.actors_["10058ui_story"].transform.localEulerAngles = arg_481_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_481_1.time_ >= 0 + var_484_0 and arg_481_1.time_ < 0 + var_484_0 + arg_484_0 then
				arg_481_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_481_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_481_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["10058ui_story"].transform.position).z)
				arg_481_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_481_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_481_1.actors_["10058ui_story"].transform.localEulerAngles = arg_481_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_484_1 = arg_481_1.actors_["10058ui_story"]

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 and not isNil(var_484_1) and arg_481_1.var_.characterEffect10058ui_story == nil then
				arg_481_1.var_.characterEffect10058ui_story = var_484_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_2 = 0.200000002980232

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_2 and not isNil(var_484_1) then
				if arg_481_1.var_.characterEffect10058ui_story and not isNil(var_484_1) then
					arg_481_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_481_1.time_ >= 0 + var_484_2 and arg_481_1.time_ < 0 + var_484_2 + arg_484_0 and not isNil(var_484_1) and arg_481_1.var_.characterEffect10058ui_story then
				arg_481_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_484_4 = 0
			local var_484_5 = 0.175

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_4 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_6 = arg_481_1:GetWordFromCfg(1109502119)
				local var_484_7 = arg_481_1:FormatText(var_484_6.content)

				arg_481_1.text_.text = var_484_7

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_9 = 7 <= 0 and var_484_5 or var_484_5 * (utf8.len(var_484_7) / 7)

				if (7 <= 0 and var_484_5 or var_484_5 * (utf8.len(var_484_7) / 7)) > 0 and var_484_5 < var_484_9 then
					arg_481_1.talkMaxDuration = var_484_9

					if var_484_9 + var_484_4 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_9 + var_484_4
					end
				end

				arg_481_1.text_.text = var_484_7
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502119", "story_v_side_new_1109502.awb") ~= 0 then
					local var_484_10 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502119", "story_v_side_new_1109502.awb") / 1000

					if var_484_10 + var_484_4 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_10 + var_484_4
					end

					if var_484_6.prefab_name ~= "" and arg_481_1.actors_[var_484_6.prefab_name] ~= nil then
						local var_484_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_6.prefab_name].transform, "story_v_side_new_1109502", "1109502119", "story_v_side_new_1109502.awb")

						arg_481_1:RecordAudio("1109502119", var_484_11)
						arg_481_1:RecordAudio("1109502119", var_484_11)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502119", "story_v_side_new_1109502.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502119", "story_v_side_new_1109502.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_12 = math.max(var_484_5, arg_481_1.talkMaxDuration)

			if var_484_4 <= arg_481_1.time_ and arg_481_1.time_ < var_484_4 + var_484_12 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_4) / var_484_12

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_4 + var_484_12 and arg_481_1.time_ < var_484_4 + var_484_12 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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
	Play1109502120 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 1109502120
		arg_485_1.duration_ = 3.8

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play1109502121(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 and not isNil(arg_485_1.actors_["10058ui_story"]) and arg_485_1.var_.characterEffect10058ui_story == nil then
				arg_485_1.var_.characterEffect10058ui_story = arg_485_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_0 = 0.200000002980232

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_0 and not isNil(arg_485_1.actors_["10058ui_story"]) then
				if arg_485_1.var_.characterEffect10058ui_story and not isNil(arg_485_1.actors_["10058ui_story"]) then
					arg_485_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_485_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_485_1.time_ - 0) / var_488_0)
				end
			end

			if arg_485_1.time_ >= 0 + var_488_0 and arg_485_1.time_ < 0 + var_488_0 + arg_488_0 and not isNil(arg_485_1.actors_["10058ui_story"]) and arg_485_1.var_.characterEffect10058ui_story then
				arg_485_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_485_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_488_1 = 0
			local var_488_2 = 0.45

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_1 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				arg_485_1.leftNameTxt_.text = arg_485_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, true)
				arg_485_1.iconController_:SetSelectedState("hero")

				arg_485_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_485_1.callingController_:SetSelectedState("normal")

				arg_485_1.keyicon_.color = Color.New(1, 1, 1)
				arg_485_1.icon_.color = Color.New(1, 1, 1)

				local var_488_3 = arg_485_1:GetWordFromCfg(1109502120)
				local var_488_4 = arg_485_1:FormatText(var_488_3.content)

				arg_485_1.text_.text = var_488_4

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_6 = 18 <= 0 and var_488_2 or var_488_2 * (utf8.len(var_488_4) / 18)

				if (18 <= 0 and var_488_2 or var_488_2 * (utf8.len(var_488_4) / 18)) > 0 and var_488_2 < var_488_6 then
					arg_485_1.talkMaxDuration = var_488_6

					if var_488_6 + var_488_1 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_6 + var_488_1
					end
				end

				arg_485_1.text_.text = var_488_4
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502120", "story_v_side_new_1109502.awb") ~= 0 then
					local var_488_7 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502120", "story_v_side_new_1109502.awb") / 1000

					if var_488_7 + var_488_1 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_7 + var_488_1
					end

					if var_488_3.prefab_name ~= "" and arg_485_1.actors_[var_488_3.prefab_name] ~= nil then
						local var_488_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_3.prefab_name].transform, "story_v_side_new_1109502", "1109502120", "story_v_side_new_1109502.awb")

						arg_485_1:RecordAudio("1109502120", var_488_8)
						arg_485_1:RecordAudio("1109502120", var_488_8)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502120", "story_v_side_new_1109502.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502120", "story_v_side_new_1109502.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_9 = math.max(var_488_2, arg_485_1.talkMaxDuration)

			if var_488_1 <= arg_485_1.time_ and arg_485_1.time_ < var_488_1 + var_488_9 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_1) / var_488_9

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_1 + var_488_9 and arg_485_1.time_ < var_488_1 + var_488_9 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play1109502121 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 1109502121
		arg_489_1.duration_ = 3.77

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play1109502122(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1.var_.moveOldPos10058ui_story = arg_489_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_492_0 = 0.001

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_0 then
				arg_489_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_489_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_489_1.time_ - 0) / var_492_0)
				arg_489_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_489_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_489_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_489_1.actors_["10058ui_story"].transform.position).z)
				arg_489_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_489_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_489_1.actors_["10058ui_story"].transform.localEulerAngles = arg_489_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_489_1.time_ >= 0 + var_492_0 and arg_489_1.time_ < 0 + var_492_0 + arg_492_0 then
				arg_489_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_489_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_489_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_489_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_489_1.actors_["10058ui_story"].transform.position).z)
				arg_489_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_489_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_489_1.actors_["10058ui_story"].transform.localEulerAngles = arg_489_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_492_1 = 0
			local var_492_2 = 0.45

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_1 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				arg_489_1.leftNameTxt_.text = arg_489_1:FormatText(StoryNameCfg[664].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, true)
				arg_489_1.iconController_:SetSelectedState("hero")

				arg_489_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_489_1.callingController_:SetSelectedState("normal")

				arg_489_1.keyicon_.color = Color.New(1, 1, 1)
				arg_489_1.icon_.color = Color.New(1, 1, 1)

				local var_492_3 = arg_489_1:GetWordFromCfg(1109502121)
				local var_492_4 = arg_489_1:FormatText(var_492_3.content)

				arg_489_1.text_.text = var_492_4

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_6 = 18 <= 0 and var_492_2 or var_492_2 * (utf8.len(var_492_4) / 18)

				if (18 <= 0 and var_492_2 or var_492_2 * (utf8.len(var_492_4) / 18)) > 0 and var_492_2 < var_492_6 then
					arg_489_1.talkMaxDuration = var_492_6

					if var_492_6 + var_492_1 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_6 + var_492_1
					end
				end

				arg_489_1.text_.text = var_492_4
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502121", "story_v_side_new_1109502.awb") ~= 0 then
					local var_492_7 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502121", "story_v_side_new_1109502.awb") / 1000

					if var_492_7 + var_492_1 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_7 + var_492_1
					end

					if var_492_3.prefab_name ~= "" and arg_489_1.actors_[var_492_3.prefab_name] ~= nil then
						local var_492_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_489_1.actors_[var_492_3.prefab_name].transform, "story_v_side_new_1109502", "1109502121", "story_v_side_new_1109502.awb")

						arg_489_1:RecordAudio("1109502121", var_492_8)
						arg_489_1:RecordAudio("1109502121", var_492_8)
					else
						arg_489_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502121", "story_v_side_new_1109502.awb")
					end

					arg_489_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502121", "story_v_side_new_1109502.awb")
				end

				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_9 = math.max(var_492_2, arg_489_1.talkMaxDuration)

			if var_492_1 <= arg_489_1.time_ and arg_489_1.time_ < var_492_1 + var_492_9 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_1) / var_492_9

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_1 + var_492_9 and arg_489_1.time_ < var_492_1 + var_492_9 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_489_1:InitPlayNodeList()
	end,
	Play1109502122 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 1109502122
		arg_493_1.duration_ = 6.2

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play1109502123(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = 0.45

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, false)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_1 = arg_493_1:GetWordFromCfg(1109502122)
				local var_496_2 = arg_493_1:FormatText(var_496_1.content)

				arg_493_1.text_.text = var_496_2

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_4 = 18 <= 0 and var_496_0 or var_496_0 * (utf8.len(var_496_2) / 18)

				if (18 <= 0 and var_496_0 or var_496_0 * (utf8.len(var_496_2) / 18)) > 0 and var_496_0 < var_496_4 then
					arg_493_1.talkMaxDuration = var_496_4

					if var_496_4 + 0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_4 + 0
					end
				end

				arg_493_1.text_.text = var_496_2
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502122", "story_v_side_new_1109502.awb") ~= 0 then
					local var_496_5 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502122", "story_v_side_new_1109502.awb") / 1000

					if var_496_5 + 0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_5 + 0
					end

					if var_496_1.prefab_name ~= "" and arg_493_1.actors_[var_496_1.prefab_name] ~= nil then
						local var_496_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_493_1.actors_[var_496_1.prefab_name].transform, "story_v_side_new_1109502", "1109502122", "story_v_side_new_1109502.awb")

						arg_493_1:RecordAudio("1109502122", var_496_6)
						arg_493_1:RecordAudio("1109502122", var_496_6)
					else
						arg_493_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502122", "story_v_side_new_1109502.awb")
					end

					arg_493_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502122", "story_v_side_new_1109502.awb")
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
	Play1109502123 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 1109502123
		arg_497_1.duration_ = 5

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play1109502124(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = 0.075

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				arg_497_1.leftNameTxt_.text = arg_497_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, true)
				arg_497_1.iconController_:SetSelectedState("hero")

				arg_497_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_497_1.callingController_:SetSelectedState("normal")

				arg_497_1.keyicon_.color = Color.New(1, 1, 1)
				arg_497_1.icon_.color = Color.New(1, 1, 1)

				local var_500_1 = arg_497_1:FormatText(arg_497_1:GetWordFromCfg(1109502123).content)

				arg_497_1.text_.text = var_500_1

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_3 = 3 <= 0 and var_500_0 or var_500_0 * (utf8.len(var_500_1) / 3)

				if (3 <= 0 and var_500_0 or var_500_0 * (utf8.len(var_500_1) / 3)) > 0 and var_500_0 < var_500_3 then
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
	Play1109502124 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 1109502124
		arg_501_1.duration_ = 4.23

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play1109502125(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = 0.625

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				arg_501_1.leftNameTxt_.text = arg_501_1:FormatText(StoryNameCfg[664].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, true)
				arg_501_1.iconController_:SetSelectedState("hero")

				arg_501_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_501_1.callingController_:SetSelectedState("normal")

				arg_501_1.keyicon_.color = Color.New(1, 1, 1)
				arg_501_1.icon_.color = Color.New(1, 1, 1)

				local var_504_1 = arg_501_1:GetWordFromCfg(1109502124)
				local var_504_2 = arg_501_1:FormatText(var_504_1.content)

				arg_501_1.text_.text = var_504_2

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_4 = 23 <= 0 and var_504_0 or var_504_0 * (utf8.len(var_504_2) / 23)

				if (23 <= 0 and var_504_0 or var_504_0 * (utf8.len(var_504_2) / 23)) > 0 and var_504_0 < var_504_4 then
					arg_501_1.talkMaxDuration = var_504_4

					if var_504_4 + 0 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_4 + 0
					end
				end

				arg_501_1.text_.text = var_504_2
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502124", "story_v_side_new_1109502.awb") ~= 0 then
					local var_504_5 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502124", "story_v_side_new_1109502.awb") / 1000

					if var_504_5 + 0 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_5 + 0
					end

					if var_504_1.prefab_name ~= "" and arg_501_1.actors_[var_504_1.prefab_name] ~= nil then
						local var_504_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_501_1.actors_[var_504_1.prefab_name].transform, "story_v_side_new_1109502", "1109502124", "story_v_side_new_1109502.awb")

						arg_501_1:RecordAudio("1109502124", var_504_6)
						arg_501_1:RecordAudio("1109502124", var_504_6)
					else
						arg_501_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502124", "story_v_side_new_1109502.awb")
					end

					arg_501_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502124", "story_v_side_new_1109502.awb")
				end

				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_7 = math.max(var_504_0, arg_501_1.talkMaxDuration)

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_7 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - 0) / var_504_7

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= 0 + var_504_7 and arg_501_1.time_ < 0 + var_504_7 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play1109502125 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 1109502125
		arg_505_1.duration_ = 7.4

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play1109502126(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			local var_508_0 = 1.1

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				arg_505_1.leftNameTxt_.text = arg_505_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, true)
				arg_505_1.iconController_:SetSelectedState("hero")

				arg_505_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_505_1.callingController_:SetSelectedState("normal")

				arg_505_1.keyicon_.color = Color.New(1, 1, 1)
				arg_505_1.icon_.color = Color.New(1, 1, 1)

				local var_508_1 = arg_505_1:GetWordFromCfg(1109502125)
				local var_508_2 = arg_505_1:FormatText(var_508_1.content)

				arg_505_1.text_.text = var_508_2

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_4 = 44 <= 0 and var_508_0 or var_508_0 * (utf8.len(var_508_2) / 44)

				if (44 <= 0 and var_508_0 or var_508_0 * (utf8.len(var_508_2) / 44)) > 0 and var_508_0 < var_508_4 then
					arg_505_1.talkMaxDuration = var_508_4

					if var_508_4 + 0 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_4 + 0
					end
				end

				arg_505_1.text_.text = var_508_2
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502125", "story_v_side_new_1109502.awb") ~= 0 then
					local var_508_5 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502125", "story_v_side_new_1109502.awb") / 1000

					if var_508_5 + 0 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_5 + 0
					end

					if var_508_1.prefab_name ~= "" and arg_505_1.actors_[var_508_1.prefab_name] ~= nil then
						local var_508_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_505_1.actors_[var_508_1.prefab_name].transform, "story_v_side_new_1109502", "1109502125", "story_v_side_new_1109502.awb")

						arg_505_1:RecordAudio("1109502125", var_508_6)
						arg_505_1:RecordAudio("1109502125", var_508_6)
					else
						arg_505_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502125", "story_v_side_new_1109502.awb")
					end

					arg_505_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502125", "story_v_side_new_1109502.awb")
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
	Play1109502126 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 1109502126
		arg_509_1.duration_ = 1.7

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play1109502127(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			local var_512_0 = 0.075

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				arg_509_1.leftNameTxt_.text = arg_509_1:FormatText(StoryNameCfg[664].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, true)
				arg_509_1.iconController_:SetSelectedState("hero")

				arg_509_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_509_1.callingController_:SetSelectedState("normal")

				arg_509_1.keyicon_.color = Color.New(1, 1, 1)
				arg_509_1.icon_.color = Color.New(1, 1, 1)

				local var_512_1 = arg_509_1:GetWordFromCfg(1109502126)
				local var_512_2 = arg_509_1:FormatText(var_512_1.content)

				arg_509_1.text_.text = var_512_2

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_4 = 3 <= 0 and var_512_0 or var_512_0 * (utf8.len(var_512_2) / 3)

				if (3 <= 0 and var_512_0 or var_512_0 * (utf8.len(var_512_2) / 3)) > 0 and var_512_0 < var_512_4 then
					arg_509_1.talkMaxDuration = var_512_4

					if var_512_4 + 0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_4 + 0
					end
				end

				arg_509_1.text_.text = var_512_2
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502126", "story_v_side_new_1109502.awb") ~= 0 then
					local var_512_5 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502126", "story_v_side_new_1109502.awb") / 1000

					if var_512_5 + 0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_5 + 0
					end

					if var_512_1.prefab_name ~= "" and arg_509_1.actors_[var_512_1.prefab_name] ~= nil then
						local var_512_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_509_1.actors_[var_512_1.prefab_name].transform, "story_v_side_new_1109502", "1109502126", "story_v_side_new_1109502.awb")

						arg_509_1:RecordAudio("1109502126", var_512_6)
						arg_509_1:RecordAudio("1109502126", var_512_6)
					else
						arg_509_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502126", "story_v_side_new_1109502.awb")
					end

					arg_509_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502126", "story_v_side_new_1109502.awb")
				end

				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_7 = math.max(var_512_0, arg_509_1.talkMaxDuration)

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_7 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - 0) / var_512_7

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= 0 + var_512_7 and arg_509_1.time_ < 0 + var_512_7 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play1109502127 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 1109502127
		arg_513_1.duration_ = 2.1

		local var_513_0 = {
			zh = 2.1,
			ja = 1.999999999999
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
				arg_513_0:Play1109502128(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 then
				arg_513_1.var_.moveOldPos10058ui_story = arg_513_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_516_0 = 0.001

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_0 then
				arg_513_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_513_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_513_1.time_ - 0) / var_516_0)
				arg_513_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_513_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_513_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_513_1.actors_["10058ui_story"].transform.position).z)
				arg_513_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_513_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_513_1.actors_["10058ui_story"].transform.localEulerAngles = arg_513_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_513_1.time_ >= 0 + var_516_0 and arg_513_1.time_ < 0 + var_516_0 + arg_516_0 then
				arg_513_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_513_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_513_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_513_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_513_1.actors_["10058ui_story"].transform.position).z)
				arg_513_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_513_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_513_1.actors_["10058ui_story"].transform.localEulerAngles = arg_513_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_516_1 = arg_513_1.actors_["10058ui_story"]

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 and not isNil(var_516_1) and arg_513_1.var_.characterEffect10058ui_story == nil then
				arg_513_1.var_.characterEffect10058ui_story = var_516_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_516_2 = 0.200000002980232

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_2 and not isNil(var_516_1) then
				if arg_513_1.var_.characterEffect10058ui_story and not isNil(var_516_1) then
					arg_513_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_513_1.time_ >= 0 + var_516_2 and arg_513_1.time_ < 0 + var_516_2 + arg_516_0 and not isNil(var_516_1) and arg_513_1.var_.characterEffect10058ui_story then
				arg_513_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 then
				arg_513_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			local var_516_4 = 0
			local var_516_5 = 0.25

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= var_516_4 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				arg_513_1.leftNameTxt_.text = arg_513_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_6 = arg_513_1:GetWordFromCfg(1109502127)
				local var_516_7 = arg_513_1:FormatText(var_516_6.content)

				arg_513_1.text_.text = var_516_7

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_9 = 10 <= 0 and var_516_5 or var_516_5 * (utf8.len(var_516_7) / 10)

				if (10 <= 0 and var_516_5 or var_516_5 * (utf8.len(var_516_7) / 10)) > 0 and var_516_5 < var_516_9 then
					arg_513_1.talkMaxDuration = var_516_9

					if var_516_9 + var_516_4 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_9 + var_516_4
					end
				end

				arg_513_1.text_.text = var_516_7
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502127", "story_v_side_new_1109502.awb") ~= 0 then
					local var_516_10 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502127", "story_v_side_new_1109502.awb") / 1000

					if var_516_10 + var_516_4 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_10 + var_516_4
					end

					if var_516_6.prefab_name ~= "" and arg_513_1.actors_[var_516_6.prefab_name] ~= nil then
						local var_516_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_513_1.actors_[var_516_6.prefab_name].transform, "story_v_side_new_1109502", "1109502127", "story_v_side_new_1109502.awb")

						arg_513_1:RecordAudio("1109502127", var_516_11)
						arg_513_1:RecordAudio("1109502127", var_516_11)
					else
						arg_513_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502127", "story_v_side_new_1109502.awb")
					end

					arg_513_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502127", "story_v_side_new_1109502.awb")
				end

				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_12 = math.max(var_516_5, arg_513_1.talkMaxDuration)

			if var_516_4 <= arg_513_1.time_ and arg_513_1.time_ < var_516_4 + var_516_12 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_4) / var_516_12

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_4 + var_516_12 and arg_513_1.time_ < var_516_4 + var_516_12 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_513_1:InitPlayNodeList()
	end,
	Play1109502128 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 1109502128
		arg_517_1.duration_ = 3.57

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play1109502129(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 and not isNil(arg_517_1.actors_["10058ui_story"]) and arg_517_1.var_.characterEffect10058ui_story == nil then
				arg_517_1.var_.characterEffect10058ui_story = arg_517_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_520_0 = 0.200000002980232

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_0 and not isNil(arg_517_1.actors_["10058ui_story"]) then
				if arg_517_1.var_.characterEffect10058ui_story and not isNil(arg_517_1.actors_["10058ui_story"]) then
					arg_517_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_517_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_517_1.time_ - 0) / var_520_0)
				end
			end

			if arg_517_1.time_ >= 0 + var_520_0 and arg_517_1.time_ < 0 + var_520_0 + arg_520_0 and not isNil(arg_517_1.actors_["10058ui_story"]) and arg_517_1.var_.characterEffect10058ui_story then
				arg_517_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_517_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_520_1 = 0
			local var_520_2 = 0.55

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_1 + arg_520_0 then
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

				local var_520_3 = arg_517_1:GetWordFromCfg(1109502128)
				local var_520_4 = arg_517_1:FormatText(var_520_3.content)

				arg_517_1.text_.text = var_520_4

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_6 = 22 <= 0 and var_520_2 or var_520_2 * (utf8.len(var_520_4) / 22)

				if (22 <= 0 and var_520_2 or var_520_2 * (utf8.len(var_520_4) / 22)) > 0 and var_520_2 < var_520_6 then
					arg_517_1.talkMaxDuration = var_520_6

					if var_520_6 + var_520_1 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_6 + var_520_1
					end
				end

				arg_517_1.text_.text = var_520_4
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502128", "story_v_side_new_1109502.awb") ~= 0 then
					local var_520_7 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502128", "story_v_side_new_1109502.awb") / 1000

					if var_520_7 + var_520_1 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_7 + var_520_1
					end

					if var_520_3.prefab_name ~= "" and arg_517_1.actors_[var_520_3.prefab_name] ~= nil then
						local var_520_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_517_1.actors_[var_520_3.prefab_name].transform, "story_v_side_new_1109502", "1109502128", "story_v_side_new_1109502.awb")

						arg_517_1:RecordAudio("1109502128", var_520_8)
						arg_517_1:RecordAudio("1109502128", var_520_8)
					else
						arg_517_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502128", "story_v_side_new_1109502.awb")
					end

					arg_517_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502128", "story_v_side_new_1109502.awb")
				end

				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_9 = math.max(var_520_2, arg_517_1.talkMaxDuration)

			if var_520_1 <= arg_517_1.time_ and arg_517_1.time_ < var_520_1 + var_520_9 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_1) / var_520_9

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_1 + var_520_9 and arg_517_1.time_ < var_520_1 + var_520_9 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play1109502129 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 1109502129
		arg_521_1.duration_ = 1.57

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play1109502130(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 and not isNil(arg_521_1.actors_["10058ui_story"]) and arg_521_1.var_.characterEffect10058ui_story == nil then
				arg_521_1.var_.characterEffect10058ui_story = arg_521_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_524_0 = 0.200000002980232

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_0 and not isNil(arg_521_1.actors_["10058ui_story"]) then
				if arg_521_1.var_.characterEffect10058ui_story and not isNil(arg_521_1.actors_["10058ui_story"]) then
					arg_521_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_521_1.time_ >= 0 + var_524_0 and arg_521_1.time_ < 0 + var_524_0 + arg_524_0 and not isNil(arg_521_1.actors_["10058ui_story"]) and arg_521_1.var_.characterEffect10058ui_story then
				arg_521_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_524_2 = 0
			local var_524_3 = 0.1

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= var_524_2 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				arg_521_1.leftNameTxt_.text = arg_521_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_4 = arg_521_1:GetWordFromCfg(1109502129)
				local var_524_5 = arg_521_1:FormatText(var_524_4.content)

				arg_521_1.text_.text = var_524_5

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_7 = 4 <= 0 and var_524_3 or var_524_3 * (utf8.len(var_524_5) / 4)

				if (4 <= 0 and var_524_3 or var_524_3 * (utf8.len(var_524_5) / 4)) > 0 and var_524_3 < var_524_7 then
					arg_521_1.talkMaxDuration = var_524_7

					if var_524_7 + var_524_2 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_7 + var_524_2
					end
				end

				arg_521_1.text_.text = var_524_5
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502129", "story_v_side_new_1109502.awb") ~= 0 then
					local var_524_8 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502129", "story_v_side_new_1109502.awb") / 1000

					if var_524_8 + var_524_2 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_8 + var_524_2
					end

					if var_524_4.prefab_name ~= "" and arg_521_1.actors_[var_524_4.prefab_name] ~= nil then
						local var_524_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_521_1.actors_[var_524_4.prefab_name].transform, "story_v_side_new_1109502", "1109502129", "story_v_side_new_1109502.awb")

						arg_521_1:RecordAudio("1109502129", var_524_9)
						arg_521_1:RecordAudio("1109502129", var_524_9)
					else
						arg_521_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502129", "story_v_side_new_1109502.awb")
					end

					arg_521_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502129", "story_v_side_new_1109502.awb")
				end

				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_10 = math.max(var_524_3, arg_521_1.talkMaxDuration)

			if var_524_2 <= arg_521_1.time_ and arg_521_1.time_ < var_524_2 + var_524_10 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_2) / var_524_10

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_2 + var_524_10 and arg_521_1.time_ < var_524_2 + var_524_10 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play1109502130 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 1109502130
		arg_525_1.duration_ = 3.27

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play1109502131(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 and not isNil(arg_525_1.actors_["10058ui_story"]) and arg_525_1.var_.characterEffect10058ui_story == nil then
				arg_525_1.var_.characterEffect10058ui_story = arg_525_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_528_0 = 0.200000002980232

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_0 and not isNil(arg_525_1.actors_["10058ui_story"]) then
				if arg_525_1.var_.characterEffect10058ui_story and not isNil(arg_525_1.actors_["10058ui_story"]) then
					arg_525_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_525_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_525_1.time_ - 0) / var_528_0)
				end
			end

			if arg_525_1.time_ >= 0 + var_528_0 and arg_525_1.time_ < 0 + var_528_0 + arg_528_0 and not isNil(arg_525_1.actors_["10058ui_story"]) and arg_525_1.var_.characterEffect10058ui_story then
				arg_525_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_525_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_528_1 = 0
			local var_528_2 = 1.15

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= var_528_1 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				arg_525_1.leftNameTxt_.text = arg_525_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, true)
				arg_525_1.iconController_:SetSelectedState("hero")

				arg_525_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_525_1.callingController_:SetSelectedState("normal")

				arg_525_1.keyicon_.color = Color.New(1, 1, 1)
				arg_525_1.icon_.color = Color.New(1, 1, 1)

				local var_528_3 = arg_525_1:GetWordFromCfg(1109502130)
				local var_528_4 = arg_525_1:FormatText(var_528_3.content)

				arg_525_1.text_.text = var_528_4

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_6 = 46 <= 0 and var_528_2 or var_528_2 * (utf8.len(var_528_4) / 46)

				if (46 <= 0 and var_528_2 or var_528_2 * (utf8.len(var_528_4) / 46)) > 0 and var_528_2 < var_528_6 then
					arg_525_1.talkMaxDuration = var_528_6

					if var_528_6 + var_528_1 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_6 + var_528_1
					end
				end

				arg_525_1.text_.text = var_528_4
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502130", "story_v_side_new_1109502.awb") ~= 0 then
					local var_528_7 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502130", "story_v_side_new_1109502.awb") / 1000

					if var_528_7 + var_528_1 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_7 + var_528_1
					end

					if var_528_3.prefab_name ~= "" and arg_525_1.actors_[var_528_3.prefab_name] ~= nil then
						local var_528_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_525_1.actors_[var_528_3.prefab_name].transform, "story_v_side_new_1109502", "1109502130", "story_v_side_new_1109502.awb")

						arg_525_1:RecordAudio("1109502130", var_528_8)
						arg_525_1:RecordAudio("1109502130", var_528_8)
					else
						arg_525_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502130", "story_v_side_new_1109502.awb")
					end

					arg_525_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502130", "story_v_side_new_1109502.awb")
				end

				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_9 = math.max(var_528_2, arg_525_1.talkMaxDuration)

			if var_528_1 <= arg_525_1.time_ and arg_525_1.time_ < var_528_1 + var_528_9 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_1) / var_528_9

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_1 + var_528_9 and arg_525_1.time_ < var_528_1 + var_528_9 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play1109502131 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 1109502131
		arg_529_1.duration_ = 2.53

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play1109502132(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 and not isNil(arg_529_1.actors_["10058ui_story"]) and arg_529_1.var_.characterEffect10058ui_story == nil then
				arg_529_1.var_.characterEffect10058ui_story = arg_529_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_532_0 = 0.200000002980232

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_0 and not isNil(arg_529_1.actors_["10058ui_story"]) then
				if arg_529_1.var_.characterEffect10058ui_story and not isNil(arg_529_1.actors_["10058ui_story"]) then
					arg_529_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_529_1.time_ >= 0 + var_532_0 and arg_529_1.time_ < 0 + var_532_0 + arg_532_0 and not isNil(arg_529_1.actors_["10058ui_story"]) and arg_529_1.var_.characterEffect10058ui_story then
				arg_529_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			local var_532_2 = 0
			local var_532_3 = 0.325

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= var_532_2 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, true)

				arg_529_1.leftNameTxt_.text = arg_529_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_529_1.leftNameTxt_.transform)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1.leftNameTxt_.text)
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_4 = arg_529_1:GetWordFromCfg(1109502131)
				local var_532_5 = arg_529_1:FormatText(var_532_4.content)

				arg_529_1.text_.text = var_532_5

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_7 = 13 <= 0 and var_532_3 or var_532_3 * (utf8.len(var_532_5) / 13)

				if (13 <= 0 and var_532_3 or var_532_3 * (utf8.len(var_532_5) / 13)) > 0 and var_532_3 < var_532_7 then
					arg_529_1.talkMaxDuration = var_532_7

					if var_532_7 + var_532_2 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_7 + var_532_2
					end
				end

				arg_529_1.text_.text = var_532_5
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502131", "story_v_side_new_1109502.awb") ~= 0 then
					local var_532_8 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502131", "story_v_side_new_1109502.awb") / 1000

					if var_532_8 + var_532_2 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_8 + var_532_2
					end

					if var_532_4.prefab_name ~= "" and arg_529_1.actors_[var_532_4.prefab_name] ~= nil then
						local var_532_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_529_1.actors_[var_532_4.prefab_name].transform, "story_v_side_new_1109502", "1109502131", "story_v_side_new_1109502.awb")

						arg_529_1:RecordAudio("1109502131", var_532_9)
						arg_529_1:RecordAudio("1109502131", var_532_9)
					else
						arg_529_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502131", "story_v_side_new_1109502.awb")
					end

					arg_529_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502131", "story_v_side_new_1109502.awb")
				end

				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_10 = math.max(var_532_3, arg_529_1.talkMaxDuration)

			if var_532_2 <= arg_529_1.time_ and arg_529_1.time_ < var_532_2 + var_532_10 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_2) / var_532_10

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_2 + var_532_10 and arg_529_1.time_ < var_532_2 + var_532_10 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play1109502132 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 1109502132
		arg_533_1.duration_ = 8

		local var_533_0 = {
			zh = 8,
			ja = 2.1
		}
		local var_533_1 = manager.audio:GetLocalizationFlag()

		if var_533_0[var_533_1] ~= nil then
			arg_533_1.duration_ = var_533_0[var_533_1]
		end

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play1109502133(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 then
				arg_533_1.var_.moveOldPos10058ui_story = arg_533_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_536_0 = 0.001

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_0 then
				arg_533_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_533_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_533_1.time_ - 0) / var_536_0)
				arg_533_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_533_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_533_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_533_1.actors_["10058ui_story"].transform.position).z)
				arg_533_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_533_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_533_1.actors_["10058ui_story"].transform.localEulerAngles = arg_533_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_533_1.time_ >= 0 + var_536_0 and arg_533_1.time_ < 0 + var_536_0 + arg_536_0 then
				arg_533_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_533_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_533_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_533_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_533_1.actors_["10058ui_story"].transform.position).z)
				arg_533_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_533_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_533_1.actors_["10058ui_story"].transform.localEulerAngles = arg_533_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_536_1 = 0
			local var_536_2 = 0.95

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= var_536_1 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				arg_533_1.leftNameTxt_.text = arg_533_1:FormatText(StoryNameCfg[664].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, true)
				arg_533_1.iconController_:SetSelectedState("hero")

				arg_533_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_533_1.callingController_:SetSelectedState("normal")

				arg_533_1.keyicon_.color = Color.New(1, 1, 1)
				arg_533_1.icon_.color = Color.New(1, 1, 1)

				local var_536_3 = arg_533_1:GetWordFromCfg(1109502132)
				local var_536_4 = arg_533_1:FormatText(var_536_3.content)

				arg_533_1.text_.text = var_536_4

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_6 = 38 <= 0 and var_536_2 or var_536_2 * (utf8.len(var_536_4) / 38)

				if (38 <= 0 and var_536_2 or var_536_2 * (utf8.len(var_536_4) / 38)) > 0 and var_536_2 < var_536_6 then
					arg_533_1.talkMaxDuration = var_536_6

					if var_536_6 + var_536_1 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_6 + var_536_1
					end
				end

				arg_533_1.text_.text = var_536_4
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502132", "story_v_side_new_1109502.awb") ~= 0 then
					local var_536_7 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502132", "story_v_side_new_1109502.awb") / 1000

					if var_536_7 + var_536_1 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_7 + var_536_1
					end

					if var_536_3.prefab_name ~= "" and arg_533_1.actors_[var_536_3.prefab_name] ~= nil then
						local var_536_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_533_1.actors_[var_536_3.prefab_name].transform, "story_v_side_new_1109502", "1109502132", "story_v_side_new_1109502.awb")

						arg_533_1:RecordAudio("1109502132", var_536_8)
						arg_533_1:RecordAudio("1109502132", var_536_8)
					else
						arg_533_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502132", "story_v_side_new_1109502.awb")
					end

					arg_533_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502132", "story_v_side_new_1109502.awb")
				end

				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_9 = math.max(var_536_2, arg_533_1.talkMaxDuration)

			if var_536_1 <= arg_533_1.time_ and arg_533_1.time_ < var_536_1 + var_536_9 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - var_536_1) / var_536_9

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= var_536_1 + var_536_9 and arg_533_1.time_ < var_536_1 + var_536_9 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_533_1:InitPlayNodeList()
	end,
	Play1109502133 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 1109502133
		arg_537_1.duration_ = 7.63

		local var_537_0 = {
			zh = 5.1,
			ja = 7.633
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
				arg_537_0:Play1109502134(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			local var_540_0 = 0.675

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				arg_537_1.leftNameTxt_.text = arg_537_1:FormatText(StoryNameCfg[664].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, true)
				arg_537_1.iconController_:SetSelectedState("hero")

				arg_537_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_537_1.callingController_:SetSelectedState("normal")

				arg_537_1.keyicon_.color = Color.New(1, 1, 1)
				arg_537_1.icon_.color = Color.New(1, 1, 1)

				local var_540_1 = arg_537_1:GetWordFromCfg(1109502133)
				local var_540_2 = arg_537_1:FormatText(var_540_1.content)

				arg_537_1.text_.text = var_540_2

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_4 = 27 <= 0 and var_540_0 or var_540_0 * (utf8.len(var_540_2) / 27)

				if (27 <= 0 and var_540_0 or var_540_0 * (utf8.len(var_540_2) / 27)) > 0 and var_540_0 < var_540_4 then
					arg_537_1.talkMaxDuration = var_540_4

					if var_540_4 + 0 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_4 + 0
					end
				end

				arg_537_1.text_.text = var_540_2
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502133", "story_v_side_new_1109502.awb") ~= 0 then
					local var_540_5 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502133", "story_v_side_new_1109502.awb") / 1000

					if var_540_5 + 0 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_5 + 0
					end

					if var_540_1.prefab_name ~= "" and arg_537_1.actors_[var_540_1.prefab_name] ~= nil then
						local var_540_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_537_1.actors_[var_540_1.prefab_name].transform, "story_v_side_new_1109502", "1109502133", "story_v_side_new_1109502.awb")

						arg_537_1:RecordAudio("1109502133", var_540_6)
						arg_537_1:RecordAudio("1109502133", var_540_6)
					else
						arg_537_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502133", "story_v_side_new_1109502.awb")
					end

					arg_537_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502133", "story_v_side_new_1109502.awb")
				end

				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_7 = math.max(var_540_0, arg_537_1.talkMaxDuration)

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_7 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - 0) / var_540_7

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= 0 + var_540_7 and arg_537_1.time_ < 0 + var_540_7 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play1109502134 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 1109502134
		arg_541_1.duration_ = 7.07

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play1109502135(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1.var_.moveOldPos10058ui_story = arg_541_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_544_0 = 0.001

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_0 then
				arg_541_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_541_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_541_1.time_ - 0) / var_544_0)
				arg_541_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_541_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_541_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_541_1.actors_["10058ui_story"].transform.position).z)
				arg_541_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_541_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_541_1.actors_["10058ui_story"].transform.localEulerAngles = arg_541_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_541_1.time_ >= 0 + var_544_0 and arg_541_1.time_ < 0 + var_544_0 + arg_544_0 then
				arg_541_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_541_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_541_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_541_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_541_1.actors_["10058ui_story"].transform.position).z)
				arg_541_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_541_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_541_1.actors_["10058ui_story"].transform.localEulerAngles = arg_541_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_544_1 = 0
			local var_544_2 = 0.425

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= var_544_1 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, false)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_3 = arg_541_1:GetWordFromCfg(1109502134)
				local var_544_4 = arg_541_1:FormatText(var_544_3.content)

				arg_541_1.text_.text = var_544_4

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_6 = 17 <= 0 and var_544_2 or var_544_2 * (utf8.len(var_544_4) / 17)

				if (17 <= 0 and var_544_2 or var_544_2 * (utf8.len(var_544_4) / 17)) > 0 and var_544_2 < var_544_6 then
					arg_541_1.talkMaxDuration = var_544_6

					if var_544_6 + var_544_1 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_6 + var_544_1
					end
				end

				arg_541_1.text_.text = var_544_4
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502134", "story_v_side_new_1109502.awb") ~= 0 then
					local var_544_7 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502134", "story_v_side_new_1109502.awb") / 1000

					if var_544_7 + var_544_1 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_7 + var_544_1
					end

					if var_544_3.prefab_name ~= "" and arg_541_1.actors_[var_544_3.prefab_name] ~= nil then
						local var_544_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_541_1.actors_[var_544_3.prefab_name].transform, "story_v_side_new_1109502", "1109502134", "story_v_side_new_1109502.awb")

						arg_541_1:RecordAudio("1109502134", var_544_8)
						arg_541_1:RecordAudio("1109502134", var_544_8)
					else
						arg_541_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502134", "story_v_side_new_1109502.awb")
					end

					arg_541_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502134", "story_v_side_new_1109502.awb")
				end

				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_9 = math.max(var_544_2, arg_541_1.talkMaxDuration)

			if var_544_1 <= arg_541_1.time_ and arg_541_1.time_ < var_544_1 + var_544_9 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_1) / var_544_9

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_1 + var_544_9 and arg_541_1.time_ < var_544_1 + var_544_9 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_541_1:InitPlayNodeList()
	end,
	Play1109502135 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 1109502135
		arg_545_1.duration_ = 7.97

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play1109502136(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			if 1.53333333333333 < arg_545_1.time_ and arg_545_1.time_ <= 1.53333333333333 + arg_548_0 then
				local var_548_0 = arg_545_1.bgs_.ST28

				arg_545_1.bgs_.ST28.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_548_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_548_1 = var_548_0:GetComponent("SpriteRenderer")

				if var_548_1 and var_548_1.sprite then
					local var_548_2 = 2 * (var_548_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_548_0.transform.localScale = Vector3.New(var_548_2 / var_548_1.sprite.bounds.size.y < var_548_2 * manager.ui.mainCameraCom_.aspect / var_548_1.sprite.bounds.size.x and var_548_2 * manager.ui.mainCameraCom_.aspect / var_548_1.sprite.bounds.size.x or var_548_2 / var_548_1.sprite.bounds.size.y, var_548_2 / var_548_1.sprite.bounds.size.y < var_548_2 * manager.ui.mainCameraCom_.aspect / var_548_1.sprite.bounds.size.x and var_548_2 * manager.ui.mainCameraCom_.aspect / var_548_1.sprite.bounds.size.x or var_548_2 / var_548_1.sprite.bounds.size.y, 0)
				end

				for iter_548_0, iter_548_1 in pairs(arg_545_1.bgs_) do
					if iter_548_0 ~= "ST28" then
						iter_548_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_548_3 = 0

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= var_548_3 + arg_548_0 then
				arg_545_1.mask_.enabled = true
				arg_545_1.mask_.raycastTarget = false

				arg_545_1:SetGaussion(false)
			end

			local var_548_4 = 1.53333333333333

			if var_548_3 <= arg_545_1.time_ and arg_545_1.time_ < var_548_3 + var_548_4 then
				local var_548_5 = Color.New(0, 0, 0)

				var_548_5.a = Mathf.Lerp(0, 1, (arg_545_1.time_ - var_548_3) / var_548_4)
				arg_545_1.mask_.color = var_548_5
			end

			if arg_545_1.time_ >= var_548_3 + var_548_4 and arg_545_1.time_ < var_548_3 + var_548_4 + arg_548_0 then
				local var_548_6 = Color.New(0, 0, 0)

				var_548_6.a = 1
				arg_545_1.mask_.color = var_548_6
			end

			local var_548_7 = 1.53333333333333

			if 1.53333333333333 < arg_545_1.time_ and arg_545_1.time_ <= var_548_7 + arg_548_0 then
				arg_545_1.mask_.enabled = true
				arg_545_1.mask_.raycastTarget = false

				arg_545_1:SetGaussion(false)
			end

			local var_548_8 = 1.43333333333333

			if var_548_7 <= arg_545_1.time_ and arg_545_1.time_ < var_548_7 + var_548_8 then
				local var_548_9 = Color.New(0, 0, 0)

				var_548_9.a = Mathf.Lerp(1, 0, (arg_545_1.time_ - var_548_7) / var_548_8)
				arg_545_1.mask_.color = var_548_9
			end

			if arg_545_1.time_ >= var_548_7 + var_548_8 and arg_545_1.time_ < var_548_7 + var_548_8 + arg_548_0 then
				local var_548_10 = Color.New(0, 0, 0)

				arg_545_1.mask_.enabled = false
				var_548_10.a = 0
				arg_545_1.mask_.color = var_548_10
			end

			if arg_545_1.frameCnt_ <= 1 then
				arg_545_1.dialog_:SetActive(false)
			end

			local var_548_11 = 2.96666666666667
			local var_548_12 = 0.85

			if 2.96666666666667 < arg_545_1.time_ and arg_545_1.time_ <= var_548_11 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0

				arg_545_1.dialog_:SetActive(true)

				arg_545_1.dialogCg_.alpha = 0

				local var_548_13 = LeanTween.value(arg_545_1.dialog_, 0, 1, 0.3)

				var_548_13:setOnUpdate(LuaHelper.FloatAction(function(arg_549_0)
					arg_545_1.dialogCg_.alpha = arg_549_0
				end))
				var_548_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_545_1.dialog_)
					var_548_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_545_1.duration_ = arg_545_1.duration_ + 0.3

				SetActive(arg_545_1.leftNameGo_, false)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_14 = arg_545_1:FormatText(arg_545_1:GetWordFromCfg(1109502135).content)

				arg_545_1.text_.text = var_548_14

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_16 = 34 <= 0 and var_548_12 or var_548_12 * (utf8.len(var_548_14) / 34)

				if (34 <= 0 and var_548_12 or var_548_12 * (utf8.len(var_548_14) / 34)) > 0 and var_548_12 < var_548_16 then
					arg_545_1.talkMaxDuration = var_548_16
					var_548_11 = var_548_11 + 0.3

					if var_548_16 + var_548_11 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_16 + var_548_11
					end
				end

				arg_545_1.text_.text = var_548_14
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)
				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_17 = var_548_11 + 0.3
			local var_548_18 = math.max(var_548_12, arg_545_1.talkMaxDuration)

			if var_548_11 + 0.3 <= arg_545_1.time_ and arg_545_1.time_ < var_548_17 + var_548_18 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_17) / var_548_18

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_17 + var_548_18 and arg_545_1.time_ < var_548_17 + var_548_18 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {}

		arg_545_1:InitPlayNodeList()
	end,
	Play1109502136 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 1109502136
		arg_551_1.duration_ = 5

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play1109502137(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			local var_554_0 = 0.15

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, true)

				arg_551_1.leftNameTxt_.text = arg_551_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, true)
				arg_551_1.iconController_:SetSelectedState("hero")

				arg_551_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_551_1.callingController_:SetSelectedState("normal")

				arg_551_1.keyicon_.color = Color.New(1, 1, 1)
				arg_551_1.icon_.color = Color.New(1, 1, 1)

				local var_554_1 = arg_551_1:FormatText(arg_551_1:GetWordFromCfg(1109502136).content)

				arg_551_1.text_.text = var_554_1

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_3 = 6 <= 0 and var_554_0 or var_554_0 * (utf8.len(var_554_1) / 6)

				if (6 <= 0 and var_554_0 or var_554_0 * (utf8.len(var_554_1) / 6)) > 0 and var_554_0 < var_554_3 then
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
	Play1109502137 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 1109502137
		arg_555_1.duration_ = 5.5

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play1109502138(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 then
				arg_555_1.var_.moveOldPos10058ui_story = arg_555_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_558_0 = 0.001

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_0 then
				arg_555_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_555_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_555_1.time_ - 0) / var_558_0)
				arg_555_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_555_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_555_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_555_1.actors_["10058ui_story"].transform.position).z)
				arg_555_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_555_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_555_1.actors_["10058ui_story"].transform.localEulerAngles = arg_555_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_555_1.time_ >= 0 + var_558_0 and arg_555_1.time_ < 0 + var_558_0 + arg_558_0 then
				arg_555_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_555_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_555_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_555_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_555_1.actors_["10058ui_story"].transform.position).z)
				arg_555_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_555_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_555_1.actors_["10058ui_story"].transform.localEulerAngles = arg_555_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_558_1 = arg_555_1.actors_["10058ui_story"]

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 and not isNil(var_558_1) and arg_555_1.var_.characterEffect10058ui_story == nil then
				arg_555_1.var_.characterEffect10058ui_story = var_558_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_558_2 = 0.200000002980232

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_2 and not isNil(var_558_1) then
				if arg_555_1.var_.characterEffect10058ui_story and not isNil(var_558_1) then
					arg_555_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_555_1.time_ >= 0 + var_558_2 and arg_555_1.time_ < 0 + var_558_2 + arg_558_0 and not isNil(var_558_1) and arg_555_1.var_.characterEffect10058ui_story then
				arg_555_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_558_4 = 0
			local var_558_5 = 0.575

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= var_558_4 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, true)

				arg_555_1.leftNameTxt_.text = arg_555_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_555_1.leftNameTxt_.transform)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1.leftNameTxt_.text)
				SetActive(arg_555_1.iconTrs_.gameObject, false)
				arg_555_1.callingController_:SetSelectedState("normal")

				local var_558_6 = arg_555_1:GetWordFromCfg(1109502137)
				local var_558_7 = arg_555_1:FormatText(var_558_6.content)

				arg_555_1.text_.text = var_558_7

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_9 = 23 <= 0 and var_558_5 or var_558_5 * (utf8.len(var_558_7) / 23)

				if (23 <= 0 and var_558_5 or var_558_5 * (utf8.len(var_558_7) / 23)) > 0 and var_558_5 < var_558_9 then
					arg_555_1.talkMaxDuration = var_558_9

					if var_558_9 + var_558_4 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_9 + var_558_4
					end
				end

				arg_555_1.text_.text = var_558_7
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502137", "story_v_side_new_1109502.awb") ~= 0 then
					local var_558_10 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502137", "story_v_side_new_1109502.awb") / 1000

					if var_558_10 + var_558_4 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_10 + var_558_4
					end

					if var_558_6.prefab_name ~= "" and arg_555_1.actors_[var_558_6.prefab_name] ~= nil then
						local var_558_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_555_1.actors_[var_558_6.prefab_name].transform, "story_v_side_new_1109502", "1109502137", "story_v_side_new_1109502.awb")

						arg_555_1:RecordAudio("1109502137", var_558_11)
						arg_555_1:RecordAudio("1109502137", var_558_11)
					else
						arg_555_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502137", "story_v_side_new_1109502.awb")
					end

					arg_555_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502137", "story_v_side_new_1109502.awb")
				end

				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_12 = math.max(var_558_5, arg_555_1.talkMaxDuration)

			if var_558_4 <= arg_555_1.time_ and arg_555_1.time_ < var_558_4 + var_558_12 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_4) / var_558_12

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_4 + var_558_12 and arg_555_1.time_ < var_558_4 + var_558_12 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_555_1:InitPlayNodeList()
	end,
	Play1109502138 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 1109502138
		arg_559_1.duration_ = 13.3

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play1109502139(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 and not isNil(arg_559_1.actors_["10058ui_story"]) and arg_559_1.var_.characterEffect10058ui_story == nil then
				arg_559_1.var_.characterEffect10058ui_story = arg_559_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_562_0 = 0.200000002980232

			if 0 <= arg_559_1.time_ and arg_559_1.time_ < 0 + var_562_0 and not isNil(arg_559_1.actors_["10058ui_story"]) then
				if arg_559_1.var_.characterEffect10058ui_story and not isNil(arg_559_1.actors_["10058ui_story"]) then
					arg_559_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_559_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_559_1.time_ - 0) / var_562_0)
				end
			end

			if arg_559_1.time_ >= 0 + var_562_0 and arg_559_1.time_ < 0 + var_562_0 + arg_562_0 and not isNil(arg_559_1.actors_["10058ui_story"]) and arg_559_1.var_.characterEffect10058ui_story then
				arg_559_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_559_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_562_1 = 0
			local var_562_2 = 0.55

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= var_562_1 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, false)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_559_1.iconTrs_.gameObject, false)
				arg_559_1.callingController_:SetSelectedState("normal")

				local var_562_3 = arg_559_1:GetWordFromCfg(1109502138)
				local var_562_4 = arg_559_1:FormatText(var_562_3.content)

				arg_559_1.text_.text = var_562_4

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_6 = 22 <= 0 and var_562_2 or var_562_2 * (utf8.len(var_562_4) / 22)

				if (22 <= 0 and var_562_2 or var_562_2 * (utf8.len(var_562_4) / 22)) > 0 and var_562_2 < var_562_6 then
					arg_559_1.talkMaxDuration = var_562_6

					if var_562_6 + var_562_1 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_6 + var_562_1
					end
				end

				arg_559_1.text_.text = var_562_4
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502138", "story_v_side_new_1109502.awb") ~= 0 then
					local var_562_7 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502138", "story_v_side_new_1109502.awb") / 1000

					if var_562_7 + var_562_1 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_7 + var_562_1
					end

					if var_562_3.prefab_name ~= "" and arg_559_1.actors_[var_562_3.prefab_name] ~= nil then
						local var_562_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_559_1.actors_[var_562_3.prefab_name].transform, "story_v_side_new_1109502", "1109502138", "story_v_side_new_1109502.awb")

						arg_559_1:RecordAudio("1109502138", var_562_8)
						arg_559_1:RecordAudio("1109502138", var_562_8)
					else
						arg_559_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502138", "story_v_side_new_1109502.awb")
					end

					arg_559_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502138", "story_v_side_new_1109502.awb")
				end

				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_9 = math.max(var_562_2, arg_559_1.talkMaxDuration)

			if var_562_1 <= arg_559_1.time_ and arg_559_1.time_ < var_562_1 + var_562_9 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - var_562_1) / var_562_9

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= var_562_1 + var_562_9 and arg_559_1.time_ < var_562_1 + var_562_9 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {}

		arg_559_1:InitPlayNodeList()
	end,
	Play1109502139 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 1109502139
		arg_563_1.duration_ = 5

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play1109502140(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			local var_566_0 = 0.075

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

				local var_566_1 = arg_563_1:FormatText(arg_563_1:GetWordFromCfg(1109502139).content)

				arg_563_1.text_.text = var_566_1

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_3 = 3 <= 0 and var_566_0 or var_566_0 * (utf8.len(var_566_1) / 3)

				if (3 <= 0 and var_566_0 or var_566_0 * (utf8.len(var_566_1) / 3)) > 0 and var_566_0 < var_566_3 then
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
	Play1109502140 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 1109502140
		arg_567_1.duration_ = 5.2

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play1109502141(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			if 0 < arg_567_1.time_ and arg_567_1.time_ <= 0 + arg_570_0 and not isNil(arg_567_1.actors_["10058ui_story"]) and arg_567_1.var_.characterEffect10058ui_story == nil then
				arg_567_1.var_.characterEffect10058ui_story = arg_567_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_570_0 = 0.200000002980232

			if 0 <= arg_567_1.time_ and arg_567_1.time_ < 0 + var_570_0 and not isNil(arg_567_1.actors_["10058ui_story"]) then
				if arg_567_1.var_.characterEffect10058ui_story and not isNil(arg_567_1.actors_["10058ui_story"]) then
					arg_567_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_567_1.time_ >= 0 + var_570_0 and arg_567_1.time_ < 0 + var_570_0 + arg_570_0 and not isNil(arg_567_1.actors_["10058ui_story"]) and arg_567_1.var_.characterEffect10058ui_story then
				arg_567_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= 0 + arg_570_0 then
				arg_567_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= 0 + arg_570_0 then
				arg_567_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_570_2 = 0
			local var_570_3 = 0.525

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= var_570_2 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, true)

				arg_567_1.leftNameTxt_.text = arg_567_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_567_1.leftNameTxt_.transform)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1.leftNameTxt_.text)
				SetActive(arg_567_1.iconTrs_.gameObject, false)
				arg_567_1.callingController_:SetSelectedState("normal")

				local var_570_4 = arg_567_1:GetWordFromCfg(1109502140)
				local var_570_5 = arg_567_1:FormatText(var_570_4.content)

				arg_567_1.text_.text = var_570_5

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_7 = 21 <= 0 and var_570_3 or var_570_3 * (utf8.len(var_570_5) / 21)

				if (21 <= 0 and var_570_3 or var_570_3 * (utf8.len(var_570_5) / 21)) > 0 and var_570_3 < var_570_7 then
					arg_567_1.talkMaxDuration = var_570_7

					if var_570_7 + var_570_2 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_7 + var_570_2
					end
				end

				arg_567_1.text_.text = var_570_5
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502140", "story_v_side_new_1109502.awb") ~= 0 then
					local var_570_8 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502140", "story_v_side_new_1109502.awb") / 1000

					if var_570_8 + var_570_2 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_8 + var_570_2
					end

					if var_570_4.prefab_name ~= "" and arg_567_1.actors_[var_570_4.prefab_name] ~= nil then
						local var_570_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_567_1.actors_[var_570_4.prefab_name].transform, "story_v_side_new_1109502", "1109502140", "story_v_side_new_1109502.awb")

						arg_567_1:RecordAudio("1109502140", var_570_9)
						arg_567_1:RecordAudio("1109502140", var_570_9)
					else
						arg_567_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502140", "story_v_side_new_1109502.awb")
					end

					arg_567_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502140", "story_v_side_new_1109502.awb")
				end

				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_10 = math.max(var_570_3, arg_567_1.talkMaxDuration)

			if var_570_2 <= arg_567_1.time_ and arg_567_1.time_ < var_570_2 + var_570_10 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - var_570_2) / var_570_10

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= var_570_2 + var_570_10 and arg_567_1.time_ < var_570_2 + var_570_10 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {}

		arg_567_1:InitPlayNodeList()
	end,
	Play1109502141 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 1109502141
		arg_571_1.duration_ = 5.8

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play1109502142(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			if 0 < arg_571_1.time_ and arg_571_1.time_ <= 0 + arg_574_0 and not isNil(arg_571_1.actors_["10058ui_story"]) and arg_571_1.var_.characterEffect10058ui_story == nil then
				arg_571_1.var_.characterEffect10058ui_story = arg_571_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_574_0 = 0.200000002980232

			if 0 <= arg_571_1.time_ and arg_571_1.time_ < 0 + var_574_0 and not isNil(arg_571_1.actors_["10058ui_story"]) then
				if arg_571_1.var_.characterEffect10058ui_story and not isNil(arg_571_1.actors_["10058ui_story"]) then
					arg_571_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_571_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_571_1.time_ - 0) / var_574_0)
				end
			end

			if arg_571_1.time_ >= 0 + var_574_0 and arg_571_1.time_ < 0 + var_574_0 + arg_574_0 and not isNil(arg_571_1.actors_["10058ui_story"]) and arg_571_1.var_.characterEffect10058ui_story then
				arg_571_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_571_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_574_1 = 0
			local var_574_2 = 0.2

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

				local var_574_3 = arg_571_1:GetWordFromCfg(1109502141)
				local var_574_4 = arg_571_1:FormatText(var_574_3.content)

				arg_571_1.text_.text = var_574_4

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_6 = 8 <= 0 and var_574_2 or var_574_2 * (utf8.len(var_574_4) / 8)

				if (8 <= 0 and var_574_2 or var_574_2 * (utf8.len(var_574_4) / 8)) > 0 and var_574_2 < var_574_6 then
					arg_571_1.talkMaxDuration = var_574_6

					if var_574_6 + var_574_1 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_6 + var_574_1
					end
				end

				arg_571_1.text_.text = var_574_4
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502141", "story_v_side_new_1109502.awb") ~= 0 then
					local var_574_7 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502141", "story_v_side_new_1109502.awb") / 1000

					if var_574_7 + var_574_1 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_7 + var_574_1
					end

					if var_574_3.prefab_name ~= "" and arg_571_1.actors_[var_574_3.prefab_name] ~= nil then
						local var_574_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_571_1.actors_[var_574_3.prefab_name].transform, "story_v_side_new_1109502", "1109502141", "story_v_side_new_1109502.awb")

						arg_571_1:RecordAudio("1109502141", var_574_8)
						arg_571_1:RecordAudio("1109502141", var_574_8)
					else
						arg_571_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502141", "story_v_side_new_1109502.awb")
					end

					arg_571_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502141", "story_v_side_new_1109502.awb")
				end

				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_9 = math.max(var_574_2, arg_571_1.talkMaxDuration)

			if var_574_1 <= arg_571_1.time_ and arg_571_1.time_ < var_574_1 + var_574_9 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - var_574_1) / var_574_9

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= var_574_1 + var_574_9 and arg_571_1.time_ < var_574_1 + var_574_9 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {}

		arg_571_1:InitPlayNodeList()
	end,
	Play1109502142 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 1109502142
		arg_575_1.duration_ = 3.07

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play1109502143(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 then
				arg_575_1.var_.moveOldPos10058ui_story = arg_575_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_578_0 = 0.001

			if 0 <= arg_575_1.time_ and arg_575_1.time_ < 0 + var_578_0 then
				arg_575_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_575_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_575_1.time_ - 0) / var_578_0)
				arg_575_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_575_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_575_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_575_1.actors_["10058ui_story"].transform.position).z)
				arg_575_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_575_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_575_1.actors_["10058ui_story"].transform.localEulerAngles = arg_575_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_575_1.time_ >= 0 + var_578_0 and arg_575_1.time_ < 0 + var_578_0 + arg_578_0 then
				arg_575_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_575_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_575_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_575_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_575_1.actors_["10058ui_story"].transform.position).z)
				arg_575_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_575_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_575_1.actors_["10058ui_story"].transform.localEulerAngles = arg_575_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_578_1 = arg_575_1.actors_["10058ui_story"]

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 and not isNil(var_578_1) and arg_575_1.var_.characterEffect10058ui_story == nil then
				arg_575_1.var_.characterEffect10058ui_story = var_578_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_578_2 = 0.200000002980232

			if 0 <= arg_575_1.time_ and arg_575_1.time_ < 0 + var_578_2 and not isNil(var_578_1) then
				if arg_575_1.var_.characterEffect10058ui_story and not isNil(var_578_1) then
					arg_575_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_575_1.time_ >= 0 + var_578_2 and arg_575_1.time_ < 0 + var_578_2 + arg_578_0 and not isNil(var_578_1) and arg_575_1.var_.characterEffect10058ui_story then
				arg_575_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_578_4 = 0
			local var_578_5 = 0.325

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= var_578_4 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, true)

				arg_575_1.leftNameTxt_.text = arg_575_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_575_1.leftNameTxt_.transform)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1.leftNameTxt_.text)
				SetActive(arg_575_1.iconTrs_.gameObject, false)
				arg_575_1.callingController_:SetSelectedState("normal")

				local var_578_6 = arg_575_1:GetWordFromCfg(1109502142)
				local var_578_7 = arg_575_1:FormatText(var_578_6.content)

				arg_575_1.text_.text = var_578_7

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_9 = 13 <= 0 and var_578_5 or var_578_5 * (utf8.len(var_578_7) / 13)

				if (13 <= 0 and var_578_5 or var_578_5 * (utf8.len(var_578_7) / 13)) > 0 and var_578_5 < var_578_9 then
					arg_575_1.talkMaxDuration = var_578_9

					if var_578_9 + var_578_4 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_9 + var_578_4
					end
				end

				arg_575_1.text_.text = var_578_7
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502142", "story_v_side_new_1109502.awb") ~= 0 then
					local var_578_10 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502142", "story_v_side_new_1109502.awb") / 1000

					if var_578_10 + var_578_4 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_10 + var_578_4
					end

					if var_578_6.prefab_name ~= "" and arg_575_1.actors_[var_578_6.prefab_name] ~= nil then
						local var_578_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_575_1.actors_[var_578_6.prefab_name].transform, "story_v_side_new_1109502", "1109502142", "story_v_side_new_1109502.awb")

						arg_575_1:RecordAudio("1109502142", var_578_11)
						arg_575_1:RecordAudio("1109502142", var_578_11)
					else
						arg_575_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502142", "story_v_side_new_1109502.awb")
					end

					arg_575_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502142", "story_v_side_new_1109502.awb")
				end

				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_12 = math.max(var_578_5, arg_575_1.talkMaxDuration)

			if var_578_4 <= arg_575_1.time_ and arg_575_1.time_ < var_578_4 + var_578_12 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - var_578_4) / var_578_12

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= var_578_4 + var_578_12 and arg_575_1.time_ < var_578_4 + var_578_12 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_575_1:InitPlayNodeList()
	end,
	Play1109502143 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 1109502143
		arg_579_1.duration_ = 4.77

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play1109502144(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			if 0 < arg_579_1.time_ and arg_579_1.time_ <= 0 + arg_582_0 and not isNil(arg_579_1.actors_["10058ui_story"]) and arg_579_1.var_.characterEffect10058ui_story == nil then
				arg_579_1.var_.characterEffect10058ui_story = arg_579_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_582_0 = 0.200000002980232

			if 0 <= arg_579_1.time_ and arg_579_1.time_ < 0 + var_582_0 and not isNil(arg_579_1.actors_["10058ui_story"]) then
				if arg_579_1.var_.characterEffect10058ui_story and not isNil(arg_579_1.actors_["10058ui_story"]) then
					arg_579_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_579_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_579_1.time_ - 0) / var_582_0)
				end
			end

			if arg_579_1.time_ >= 0 + var_582_0 and arg_579_1.time_ < 0 + var_582_0 + arg_582_0 and not isNil(arg_579_1.actors_["10058ui_story"]) and arg_579_1.var_.characterEffect10058ui_story then
				arg_579_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_579_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_582_1 = 0
			local var_582_2 = 0.4

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= var_582_1 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, true)

				arg_579_1.leftNameTxt_.text = arg_579_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_579_1.leftNameTxt_.transform)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1.leftNameTxt_.text)
				SetActive(arg_579_1.iconTrs_.gameObject, true)
				arg_579_1.iconController_:SetSelectedState("hero")

				arg_579_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_579_1.callingController_:SetSelectedState("normal")

				arg_579_1.keyicon_.color = Color.New(1, 1, 1)
				arg_579_1.icon_.color = Color.New(1, 1, 1)

				local var_582_3 = arg_579_1:GetWordFromCfg(1109502143)
				local var_582_4 = arg_579_1:FormatText(var_582_3.content)

				arg_579_1.text_.text = var_582_4

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_6 = 16 <= 0 and var_582_2 or var_582_2 * (utf8.len(var_582_4) / 16)

				if (16 <= 0 and var_582_2 or var_582_2 * (utf8.len(var_582_4) / 16)) > 0 and var_582_2 < var_582_6 then
					arg_579_1.talkMaxDuration = var_582_6

					if var_582_6 + var_582_1 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_6 + var_582_1
					end
				end

				arg_579_1.text_.text = var_582_4
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502143", "story_v_side_new_1109502.awb") ~= 0 then
					local var_582_7 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502143", "story_v_side_new_1109502.awb") / 1000

					if var_582_7 + var_582_1 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_7 + var_582_1
					end

					if var_582_3.prefab_name ~= "" and arg_579_1.actors_[var_582_3.prefab_name] ~= nil then
						local var_582_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_579_1.actors_[var_582_3.prefab_name].transform, "story_v_side_new_1109502", "1109502143", "story_v_side_new_1109502.awb")

						arg_579_1:RecordAudio("1109502143", var_582_8)
						arg_579_1:RecordAudio("1109502143", var_582_8)
					else
						arg_579_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502143", "story_v_side_new_1109502.awb")
					end

					arg_579_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502143", "story_v_side_new_1109502.awb")
				end

				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_9 = math.max(var_582_2, arg_579_1.talkMaxDuration)

			if var_582_1 <= arg_579_1.time_ and arg_579_1.time_ < var_582_1 + var_582_9 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - var_582_1) / var_582_9

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= var_582_1 + var_582_9 and arg_579_1.time_ < var_582_1 + var_582_9 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	Play1109502144 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 1109502144
		arg_583_1.duration_ = 9.7

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play1109502145(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 and not isNil(arg_583_1.actors_["10058ui_story"]) and arg_583_1.var_.characterEffect10058ui_story == nil then
				arg_583_1.var_.characterEffect10058ui_story = arg_583_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_586_0 = 0.200000002980232

			if 0 <= arg_583_1.time_ and arg_583_1.time_ < 0 + var_586_0 and not isNil(arg_583_1.actors_["10058ui_story"]) then
				if arg_583_1.var_.characterEffect10058ui_story and not isNil(arg_583_1.actors_["10058ui_story"]) then
					arg_583_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_583_1.time_ >= 0 + var_586_0 and arg_583_1.time_ < 0 + var_586_0 + arg_586_0 and not isNil(arg_583_1.actors_["10058ui_story"]) and arg_583_1.var_.characterEffect10058ui_story then
				arg_583_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 then
				arg_583_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 then
				arg_583_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095actionlink/1095action424")
			end

			local var_586_2 = 0
			local var_586_3 = 0.975

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= var_586_2 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, true)

				arg_583_1.leftNameTxt_.text = arg_583_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_583_1.leftNameTxt_.transform)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1.leftNameTxt_.text)
				SetActive(arg_583_1.iconTrs_.gameObject, false)
				arg_583_1.callingController_:SetSelectedState("normal")

				local var_586_4 = arg_583_1:GetWordFromCfg(1109502144)
				local var_586_5 = arg_583_1:FormatText(var_586_4.content)

				arg_583_1.text_.text = var_586_5

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_7 = 39 <= 0 and var_586_3 or var_586_3 * (utf8.len(var_586_5) / 39)

				if (39 <= 0 and var_586_3 or var_586_3 * (utf8.len(var_586_5) / 39)) > 0 and var_586_3 < var_586_7 then
					arg_583_1.talkMaxDuration = var_586_7

					if var_586_7 + var_586_2 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_7 + var_586_2
					end
				end

				arg_583_1.text_.text = var_586_5
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502144", "story_v_side_new_1109502.awb") ~= 0 then
					local var_586_8 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502144", "story_v_side_new_1109502.awb") / 1000

					if var_586_8 + var_586_2 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_8 + var_586_2
					end

					if var_586_4.prefab_name ~= "" and arg_583_1.actors_[var_586_4.prefab_name] ~= nil then
						local var_586_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_583_1.actors_[var_586_4.prefab_name].transform, "story_v_side_new_1109502", "1109502144", "story_v_side_new_1109502.awb")

						arg_583_1:RecordAudio("1109502144", var_586_9)
						arg_583_1:RecordAudio("1109502144", var_586_9)
					else
						arg_583_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502144", "story_v_side_new_1109502.awb")
					end

					arg_583_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502144", "story_v_side_new_1109502.awb")
				end

				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_10 = math.max(var_586_3, arg_583_1.talkMaxDuration)

			if var_586_2 <= arg_583_1.time_ and arg_583_1.time_ < var_586_2 + var_586_10 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - var_586_2) / var_586_10

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= var_586_2 + var_586_10 and arg_583_1.time_ < var_586_2 + var_586_10 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {}

		arg_583_1:InitPlayNodeList()
	end,
	Play1109502145 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 1109502145
		arg_587_1.duration_ = 11.1

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play1109502146(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			if 0 < arg_587_1.time_ and arg_587_1.time_ <= 0 + arg_590_0 and not isNil(arg_587_1.actors_["10058ui_story"]) and arg_587_1.var_.characterEffect10058ui_story == nil then
				arg_587_1.var_.characterEffect10058ui_story = arg_587_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_590_0 = 0.200000002980232

			if 0 <= arg_587_1.time_ and arg_587_1.time_ < 0 + var_590_0 and not isNil(arg_587_1.actors_["10058ui_story"]) then
				if arg_587_1.var_.characterEffect10058ui_story and not isNil(arg_587_1.actors_["10058ui_story"]) then
					arg_587_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_587_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_587_1.time_ - 0) / var_590_0)
				end
			end

			if arg_587_1.time_ >= 0 + var_590_0 and arg_587_1.time_ < 0 + var_590_0 + arg_590_0 and not isNil(arg_587_1.actors_["10058ui_story"]) and arg_587_1.var_.characterEffect10058ui_story then
				arg_587_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_587_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_590_1 = 0
			local var_590_2 = 0.675

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

				local var_590_3 = arg_587_1:GetWordFromCfg(1109502145)
				local var_590_4 = arg_587_1:FormatText(var_590_3.content)

				arg_587_1.text_.text = var_590_4

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_6 = 27 <= 0 and var_590_2 or var_590_2 * (utf8.len(var_590_4) / 27)

				if (27 <= 0 and var_590_2 or var_590_2 * (utf8.len(var_590_4) / 27)) > 0 and var_590_2 < var_590_6 then
					arg_587_1.talkMaxDuration = var_590_6

					if var_590_6 + var_590_1 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_6 + var_590_1
					end
				end

				arg_587_1.text_.text = var_590_4
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502145", "story_v_side_new_1109502.awb") ~= 0 then
					local var_590_7 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502145", "story_v_side_new_1109502.awb") / 1000

					if var_590_7 + var_590_1 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_7 + var_590_1
					end

					if var_590_3.prefab_name ~= "" and arg_587_1.actors_[var_590_3.prefab_name] ~= nil then
						local var_590_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_587_1.actors_[var_590_3.prefab_name].transform, "story_v_side_new_1109502", "1109502145", "story_v_side_new_1109502.awb")

						arg_587_1:RecordAudio("1109502145", var_590_8)
						arg_587_1:RecordAudio("1109502145", var_590_8)
					else
						arg_587_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502145", "story_v_side_new_1109502.awb")
					end

					arg_587_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502145", "story_v_side_new_1109502.awb")
				end

				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_9 = math.max(var_590_2, arg_587_1.talkMaxDuration)

			if var_590_1 <= arg_587_1.time_ and arg_587_1.time_ < var_590_1 + var_590_9 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - var_590_1) / var_590_9

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= var_590_1 + var_590_9 and arg_587_1.time_ < var_590_1 + var_590_9 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {}

		arg_587_1:InitPlayNodeList()
	end,
	Play1109502146 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 1109502146
		arg_591_1.duration_ = 5

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
		end

		function arg_591_1.playNext_(arg_593_0)
			if arg_593_0 == 1 then
				arg_591_0:Play1109502147(arg_591_1)
			end
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			local var_594_0 = 0.2

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

				local var_594_1 = arg_591_1:FormatText(arg_591_1:GetWordFromCfg(1109502146).content)

				arg_591_1.text_.text = var_594_1

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_3 = 8 <= 0 and var_594_0 or var_594_0 * (utf8.len(var_594_1) / 8)

				if (8 <= 0 and var_594_0 or var_594_0 * (utf8.len(var_594_1) / 8)) > 0 and var_594_0 < var_594_3 then
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
	Play1109502147 = function(arg_595_0, arg_595_1)
		arg_595_1.time_ = 0
		arg_595_1.frameCnt_ = 0
		arg_595_1.state_ = "playing"
		arg_595_1.curTalkId_ = 1109502147
		arg_595_1.duration_ = 8.67

		SetActive(arg_595_1.tipsGo_, false)

		function arg_595_1.onSingleLineFinish_()
			arg_595_1.onSingleLineUpdate_ = nil
			arg_595_1.onSingleLineFinish_ = nil
			arg_595_1.state_ = "waiting"
		end

		function arg_595_1.playNext_(arg_597_0)
			if arg_597_0 == 1 then
				arg_595_0:Play1109502148(arg_595_1)
			end
		end

		function arg_595_1.onSingleLineUpdate_(arg_598_0)
			if 0 < arg_595_1.time_ and arg_595_1.time_ <= 0 + arg_598_0 then
				arg_595_1.var_.moveOldPos10058ui_story = arg_595_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_598_0 = 0.001

			if 0 <= arg_595_1.time_ and arg_595_1.time_ < 0 + var_598_0 then
				arg_595_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_595_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_595_1.time_ - 0) / var_598_0)
				arg_595_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_595_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_595_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_595_1.actors_["10058ui_story"].transform.position).z)
				arg_595_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_595_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_595_1.actors_["10058ui_story"].transform.localEulerAngles = arg_595_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_595_1.time_ >= 0 + var_598_0 and arg_595_1.time_ < 0 + var_598_0 + arg_598_0 then
				arg_595_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_595_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_595_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_595_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_595_1.actors_["10058ui_story"].transform.position).z)
				arg_595_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_595_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_595_1.actors_["10058ui_story"].transform.localEulerAngles = arg_595_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_598_1 = arg_595_1.actors_["10058ui_story"]

			if 0 < arg_595_1.time_ and arg_595_1.time_ <= 0 + arg_598_0 and not isNil(var_598_1) and arg_595_1.var_.characterEffect10058ui_story == nil then
				arg_595_1.var_.characterEffect10058ui_story = var_598_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_598_2 = 0.200000002980232

			if 0 <= arg_595_1.time_ and arg_595_1.time_ < 0 + var_598_2 and not isNil(var_598_1) then
				if arg_595_1.var_.characterEffect10058ui_story and not isNil(var_598_1) then
					arg_595_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_595_1.time_ >= 0 + var_598_2 and arg_595_1.time_ < 0 + var_598_2 + arg_598_0 and not isNil(var_598_1) and arg_595_1.var_.characterEffect10058ui_story then
				arg_595_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_595_1.time_ and arg_595_1.time_ <= 0 + arg_598_0 then
				arg_595_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_2")
			end

			local var_598_4 = 0
			local var_598_5 = 0.975

			if 0 < arg_595_1.time_ and arg_595_1.time_ <= var_598_4 + arg_598_0 then
				arg_595_1.talkMaxDuration = 0
				arg_595_1.dialogCg_.alpha = 1

				arg_595_1.dialog_:SetActive(true)
				SetActive(arg_595_1.leftNameGo_, true)

				arg_595_1.leftNameTxt_.text = arg_595_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_595_1.leftNameTxt_.transform)

				arg_595_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_595_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_595_1:RecordName(arg_595_1.leftNameTxt_.text)
				SetActive(arg_595_1.iconTrs_.gameObject, false)
				arg_595_1.callingController_:SetSelectedState("normal")

				local var_598_6 = arg_595_1:GetWordFromCfg(1109502147)
				local var_598_7 = arg_595_1:FormatText(var_598_6.content)

				arg_595_1.text_.text = var_598_7

				LuaForUtil.ClearLinePrefixSymbol(arg_595_1.text_)

				local var_598_9 = 39 <= 0 and var_598_5 or var_598_5 * (utf8.len(var_598_7) / 39)

				if (39 <= 0 and var_598_5 or var_598_5 * (utf8.len(var_598_7) / 39)) > 0 and var_598_5 < var_598_9 then
					arg_595_1.talkMaxDuration = var_598_9

					if var_598_9 + var_598_4 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_9 + var_598_4
					end
				end

				arg_595_1.text_.text = var_598_7
				arg_595_1.typewritter.percent = 0

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502147", "story_v_side_new_1109502.awb") ~= 0 then
					local var_598_10 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502147", "story_v_side_new_1109502.awb") / 1000

					if var_598_10 + var_598_4 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_10 + var_598_4
					end

					if var_598_6.prefab_name ~= "" and arg_595_1.actors_[var_598_6.prefab_name] ~= nil then
						local var_598_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_595_1.actors_[var_598_6.prefab_name].transform, "story_v_side_new_1109502", "1109502147", "story_v_side_new_1109502.awb")

						arg_595_1:RecordAudio("1109502147", var_598_11)
						arg_595_1:RecordAudio("1109502147", var_598_11)
					else
						arg_595_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502147", "story_v_side_new_1109502.awb")
					end

					arg_595_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502147", "story_v_side_new_1109502.awb")
				end

				arg_595_1:RecordContent(arg_595_1.text_.text)
			end

			local var_598_12 = math.max(var_598_5, arg_595_1.talkMaxDuration)

			if var_598_4 <= arg_595_1.time_ and arg_595_1.time_ < var_598_4 + var_598_12 then
				arg_595_1.typewritter.percent = (arg_595_1.time_ - var_598_4) / var_598_12

				arg_595_1.typewritter:SetDirty()
			end

			if arg_595_1.time_ >= var_598_4 + var_598_12 and arg_595_1.time_ < var_598_4 + var_598_12 + arg_598_0 then
				arg_595_1.typewritter.percent = 1

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(true)
			end
		end

		arg_595_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_595_1:InitPlayNodeList()
	end,
	Play1109502148 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 1109502148
		arg_599_1.duration_ = 17.2

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play1109502149(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			if 0 < arg_599_1.time_ and arg_599_1.time_ <= 0 + arg_602_0 and not isNil(arg_599_1.actors_["10058ui_story"]) and arg_599_1.var_.characterEffect10058ui_story == nil then
				arg_599_1.var_.characterEffect10058ui_story = arg_599_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_602_0 = 0.200000002980232

			if 0 <= arg_599_1.time_ and arg_599_1.time_ < 0 + var_602_0 and not isNil(arg_599_1.actors_["10058ui_story"]) then
				if arg_599_1.var_.characterEffect10058ui_story and not isNil(arg_599_1.actors_["10058ui_story"]) then
					arg_599_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_599_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_599_1.time_ - 0) / var_602_0)
				end
			end

			if arg_599_1.time_ >= 0 + var_602_0 and arg_599_1.time_ < 0 + var_602_0 + arg_602_0 and not isNil(arg_599_1.actors_["10058ui_story"]) and arg_599_1.var_.characterEffect10058ui_story then
				arg_599_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_599_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_602_1 = 0
			local var_602_2 = 0.275

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= var_602_1 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0
				arg_599_1.dialogCg_.alpha = 1

				arg_599_1.dialog_:SetActive(true)
				SetActive(arg_599_1.leftNameGo_, true)

				arg_599_1.leftNameTxt_.text = arg_599_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_599_1.leftNameTxt_.transform)

				arg_599_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_599_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_599_1:RecordName(arg_599_1.leftNameTxt_.text)
				SetActive(arg_599_1.iconTrs_.gameObject, true)
				arg_599_1.iconController_:SetSelectedState("hero")

				arg_599_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_599_1.callingController_:SetSelectedState("normal")

				arg_599_1.keyicon_.color = Color.New(1, 1, 1)
				arg_599_1.icon_.color = Color.New(1, 1, 1)

				local var_602_3 = arg_599_1:GetWordFromCfg(1109502148)
				local var_602_4 = arg_599_1:FormatText(var_602_3.content)

				arg_599_1.text_.text = var_602_4

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_6 = 11 <= 0 and var_602_2 or var_602_2 * (utf8.len(var_602_4) / 11)

				if (11 <= 0 and var_602_2 or var_602_2 * (utf8.len(var_602_4) / 11)) > 0 and var_602_2 < var_602_6 then
					arg_599_1.talkMaxDuration = var_602_6

					if var_602_6 + var_602_1 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_6 + var_602_1
					end
				end

				arg_599_1.text_.text = var_602_4
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502148", "story_v_side_new_1109502.awb") ~= 0 then
					local var_602_7 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502148", "story_v_side_new_1109502.awb") / 1000

					if var_602_7 + var_602_1 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_7 + var_602_1
					end

					if var_602_3.prefab_name ~= "" and arg_599_1.actors_[var_602_3.prefab_name] ~= nil then
						local var_602_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_599_1.actors_[var_602_3.prefab_name].transform, "story_v_side_new_1109502", "1109502148", "story_v_side_new_1109502.awb")

						arg_599_1:RecordAudio("1109502148", var_602_8)
						arg_599_1:RecordAudio("1109502148", var_602_8)
					else
						arg_599_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502148", "story_v_side_new_1109502.awb")
					end

					arg_599_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502148", "story_v_side_new_1109502.awb")
				end

				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_9 = math.max(var_602_2, arg_599_1.talkMaxDuration)

			if var_602_1 <= arg_599_1.time_ and arg_599_1.time_ < var_602_1 + var_602_9 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - var_602_1) / var_602_9

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= var_602_1 + var_602_9 and arg_599_1.time_ < var_602_1 + var_602_9 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {}

		arg_599_1:InitPlayNodeList()
	end,
	Play1109502149 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 1109502149
		arg_603_1.duration_ = 5.03

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play1109502150(arg_603_1)
			end
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			if 0 < arg_603_1.time_ and arg_603_1.time_ <= 0 + arg_606_0 and not isNil(arg_603_1.actors_["10058ui_story"]) and arg_603_1.var_.characterEffect10058ui_story == nil then
				arg_603_1.var_.characterEffect10058ui_story = arg_603_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_606_0 = 0.200000002980232

			if 0 <= arg_603_1.time_ and arg_603_1.time_ < 0 + var_606_0 and not isNil(arg_603_1.actors_["10058ui_story"]) then
				if arg_603_1.var_.characterEffect10058ui_story and not isNil(arg_603_1.actors_["10058ui_story"]) then
					arg_603_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_603_1.time_ >= 0 + var_606_0 and arg_603_1.time_ < 0 + var_606_0 + arg_606_0 and not isNil(arg_603_1.actors_["10058ui_story"]) and arg_603_1.var_.characterEffect10058ui_story then
				arg_603_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_606_2 = 0
			local var_606_3 = 0.525

			if 0 < arg_603_1.time_ and arg_603_1.time_ <= var_606_2 + arg_606_0 then
				arg_603_1.talkMaxDuration = 0
				arg_603_1.dialogCg_.alpha = 1

				arg_603_1.dialog_:SetActive(true)
				SetActive(arg_603_1.leftNameGo_, true)

				arg_603_1.leftNameTxt_.text = arg_603_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_603_1.leftNameTxt_.transform)

				arg_603_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_603_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_603_1:RecordName(arg_603_1.leftNameTxt_.text)
				SetActive(arg_603_1.iconTrs_.gameObject, false)
				arg_603_1.callingController_:SetSelectedState("normal")

				local var_606_4 = arg_603_1:GetWordFromCfg(1109502149)
				local var_606_5 = arg_603_1:FormatText(var_606_4.content)

				arg_603_1.text_.text = var_606_5

				LuaForUtil.ClearLinePrefixSymbol(arg_603_1.text_)

				local var_606_7 = 21 <= 0 and var_606_3 or var_606_3 * (utf8.len(var_606_5) / 21)

				if (21 <= 0 and var_606_3 or var_606_3 * (utf8.len(var_606_5) / 21)) > 0 and var_606_3 < var_606_7 then
					arg_603_1.talkMaxDuration = var_606_7

					if var_606_7 + var_606_2 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_7 + var_606_2
					end
				end

				arg_603_1.text_.text = var_606_5
				arg_603_1.typewritter.percent = 0

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502149", "story_v_side_new_1109502.awb") ~= 0 then
					local var_606_8 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502149", "story_v_side_new_1109502.awb") / 1000

					if var_606_8 + var_606_2 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_8 + var_606_2
					end

					if var_606_4.prefab_name ~= "" and arg_603_1.actors_[var_606_4.prefab_name] ~= nil then
						local var_606_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_603_1.actors_[var_606_4.prefab_name].transform, "story_v_side_new_1109502", "1109502149", "story_v_side_new_1109502.awb")

						arg_603_1:RecordAudio("1109502149", var_606_9)
						arg_603_1:RecordAudio("1109502149", var_606_9)
					else
						arg_603_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502149", "story_v_side_new_1109502.awb")
					end

					arg_603_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502149", "story_v_side_new_1109502.awb")
				end

				arg_603_1:RecordContent(arg_603_1.text_.text)
			end

			local var_606_10 = math.max(var_606_3, arg_603_1.talkMaxDuration)

			if var_606_2 <= arg_603_1.time_ and arg_603_1.time_ < var_606_2 + var_606_10 then
				arg_603_1.typewritter.percent = (arg_603_1.time_ - var_606_2) / var_606_10

				arg_603_1.typewritter:SetDirty()
			end

			if arg_603_1.time_ >= var_606_2 + var_606_10 and arg_603_1.time_ < var_606_2 + var_606_10 + arg_606_0 then
				arg_603_1.typewritter.percent = 1

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(true)
			end
		end

		arg_603_1.nodeConfigList_ = {}

		arg_603_1:InitPlayNodeList()
	end,
	Play1109502150 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 1109502150
		arg_607_1.duration_ = 6.83

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
		end

		function arg_607_1.playNext_(arg_609_0)
			if arg_609_0 == 1 then
				arg_607_0:Play1109502151(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			if 0 < arg_607_1.time_ and arg_607_1.time_ <= 0 + arg_610_0 and not isNil(arg_607_1.actors_["10058ui_story"]) and arg_607_1.var_.characterEffect10058ui_story == nil then
				arg_607_1.var_.characterEffect10058ui_story = arg_607_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_610_0 = 0.200000002980232

			if 0 <= arg_607_1.time_ and arg_607_1.time_ < 0 + var_610_0 and not isNil(arg_607_1.actors_["10058ui_story"]) then
				if arg_607_1.var_.characterEffect10058ui_story and not isNil(arg_607_1.actors_["10058ui_story"]) then
					arg_607_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_607_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_607_1.time_ - 0) / var_610_0)
				end
			end

			if arg_607_1.time_ >= 0 + var_610_0 and arg_607_1.time_ < 0 + var_610_0 + arg_610_0 and not isNil(arg_607_1.actors_["10058ui_story"]) and arg_607_1.var_.characterEffect10058ui_story then
				arg_607_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_607_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_610_1 = 0
			local var_610_2 = 0.05

			if 0 < arg_607_1.time_ and arg_607_1.time_ <= var_610_1 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, true)

				arg_607_1.leftNameTxt_.text = arg_607_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_607_1.leftNameTxt_.transform)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1.leftNameTxt_.text)
				SetActive(arg_607_1.iconTrs_.gameObject, true)
				arg_607_1.iconController_:SetSelectedState("hero")

				arg_607_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_607_1.callingController_:SetSelectedState("normal")

				arg_607_1.keyicon_.color = Color.New(1, 1, 1)
				arg_607_1.icon_.color = Color.New(1, 1, 1)

				local var_610_3 = arg_607_1:GetWordFromCfg(1109502150)
				local var_610_4 = arg_607_1:FormatText(var_610_3.content)

				arg_607_1.text_.text = var_610_4

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_6 = 2 <= 0 and var_610_2 or var_610_2 * (utf8.len(var_610_4) / 2)

				if (2 <= 0 and var_610_2 or var_610_2 * (utf8.len(var_610_4) / 2)) > 0 and var_610_2 < var_610_6 then
					arg_607_1.talkMaxDuration = var_610_6

					if var_610_6 + var_610_1 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_6 + var_610_1
					end
				end

				arg_607_1.text_.text = var_610_4
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502150", "story_v_side_new_1109502.awb") ~= 0 then
					local var_610_7 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502150", "story_v_side_new_1109502.awb") / 1000

					if var_610_7 + var_610_1 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_7 + var_610_1
					end

					if var_610_3.prefab_name ~= "" and arg_607_1.actors_[var_610_3.prefab_name] ~= nil then
						local var_610_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_607_1.actors_[var_610_3.prefab_name].transform, "story_v_side_new_1109502", "1109502150", "story_v_side_new_1109502.awb")

						arg_607_1:RecordAudio("1109502150", var_610_8)
						arg_607_1:RecordAudio("1109502150", var_610_8)
					else
						arg_607_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502150", "story_v_side_new_1109502.awb")
					end

					arg_607_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502150", "story_v_side_new_1109502.awb")
				end

				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_9 = math.max(var_610_2, arg_607_1.talkMaxDuration)

			if var_610_1 <= arg_607_1.time_ and arg_607_1.time_ < var_610_1 + var_610_9 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - var_610_1) / var_610_9

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= var_610_1 + var_610_9 and arg_607_1.time_ < var_610_1 + var_610_9 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {}

		arg_607_1:InitPlayNodeList()
	end,
	Play1109502151 = function(arg_611_0, arg_611_1)
		arg_611_1.time_ = 0
		arg_611_1.frameCnt_ = 0
		arg_611_1.state_ = "playing"
		arg_611_1.curTalkId_ = 1109502151
		arg_611_1.duration_ = 10.57

		SetActive(arg_611_1.tipsGo_, false)

		function arg_611_1.onSingleLineFinish_()
			arg_611_1.onSingleLineUpdate_ = nil
			arg_611_1.onSingleLineFinish_ = nil
			arg_611_1.state_ = "waiting"
		end

		function arg_611_1.playNext_(arg_613_0)
			if arg_613_0 == 1 then
				arg_611_0:Play1109502152(arg_611_1)
			end
		end

		function arg_611_1.onSingleLineUpdate_(arg_614_0)
			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 and not isNil(arg_611_1.actors_["10058ui_story"]) and arg_611_1.var_.characterEffect10058ui_story == nil then
				arg_611_1.var_.characterEffect10058ui_story = arg_611_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_614_0 = 0.200000002980232

			if 0 <= arg_611_1.time_ and arg_611_1.time_ < 0 + var_614_0 and not isNil(arg_611_1.actors_["10058ui_story"]) then
				if arg_611_1.var_.characterEffect10058ui_story and not isNil(arg_611_1.actors_["10058ui_story"]) then
					arg_611_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_611_1.time_ >= 0 + var_614_0 and arg_611_1.time_ < 0 + var_614_0 + arg_614_0 and not isNil(arg_611_1.actors_["10058ui_story"]) and arg_611_1.var_.characterEffect10058ui_story then
				arg_611_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 then
				arg_611_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 then
				arg_611_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_614_2 = 0
			local var_614_3 = 1.175

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= var_614_2 + arg_614_0 then
				arg_611_1.talkMaxDuration = 0
				arg_611_1.dialogCg_.alpha = 1

				arg_611_1.dialog_:SetActive(true)
				SetActive(arg_611_1.leftNameGo_, true)

				arg_611_1.leftNameTxt_.text = arg_611_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_611_1.leftNameTxt_.transform)

				arg_611_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_611_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_611_1:RecordName(arg_611_1.leftNameTxt_.text)
				SetActive(arg_611_1.iconTrs_.gameObject, false)
				arg_611_1.callingController_:SetSelectedState("normal")

				local var_614_4 = arg_611_1:GetWordFromCfg(1109502151)
				local var_614_5 = arg_611_1:FormatText(var_614_4.content)

				arg_611_1.text_.text = var_614_5

				LuaForUtil.ClearLinePrefixSymbol(arg_611_1.text_)

				local var_614_7 = 47 <= 0 and var_614_3 or var_614_3 * (utf8.len(var_614_5) / 47)

				if (47 <= 0 and var_614_3 or var_614_3 * (utf8.len(var_614_5) / 47)) > 0 and var_614_3 < var_614_7 then
					arg_611_1.talkMaxDuration = var_614_7

					if var_614_7 + var_614_2 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_7 + var_614_2
					end
				end

				arg_611_1.text_.text = var_614_5
				arg_611_1.typewritter.percent = 0

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502151", "story_v_side_new_1109502.awb") ~= 0 then
					local var_614_8 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502151", "story_v_side_new_1109502.awb") / 1000

					if var_614_8 + var_614_2 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_8 + var_614_2
					end

					if var_614_4.prefab_name ~= "" and arg_611_1.actors_[var_614_4.prefab_name] ~= nil then
						local var_614_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_611_1.actors_[var_614_4.prefab_name].transform, "story_v_side_new_1109502", "1109502151", "story_v_side_new_1109502.awb")

						arg_611_1:RecordAudio("1109502151", var_614_9)
						arg_611_1:RecordAudio("1109502151", var_614_9)
					else
						arg_611_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502151", "story_v_side_new_1109502.awb")
					end

					arg_611_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502151", "story_v_side_new_1109502.awb")
				end

				arg_611_1:RecordContent(arg_611_1.text_.text)
			end

			local var_614_10 = math.max(var_614_3, arg_611_1.talkMaxDuration)

			if var_614_2 <= arg_611_1.time_ and arg_611_1.time_ < var_614_2 + var_614_10 then
				arg_611_1.typewritter.percent = (arg_611_1.time_ - var_614_2) / var_614_10

				arg_611_1.typewritter:SetDirty()
			end

			if arg_611_1.time_ >= var_614_2 + var_614_10 and arg_611_1.time_ < var_614_2 + var_614_10 + arg_614_0 then
				arg_611_1.typewritter.percent = 1

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(true)
			end
		end

		arg_611_1.nodeConfigList_ = {}

		arg_611_1:InitPlayNodeList()
	end,
	Play1109502152 = function(arg_615_0, arg_615_1)
		arg_615_1.time_ = 0
		arg_615_1.frameCnt_ = 0
		arg_615_1.state_ = "playing"
		arg_615_1.curTalkId_ = 1109502152
		arg_615_1.duration_ = 14.6

		SetActive(arg_615_1.tipsGo_, false)

		function arg_615_1.onSingleLineFinish_()
			arg_615_1.onSingleLineUpdate_ = nil
			arg_615_1.onSingleLineFinish_ = nil
			arg_615_1.state_ = "waiting"
		end

		function arg_615_1.playNext_(arg_617_0)
			if arg_617_0 == 1 then
				arg_615_0:Play1109502153(arg_615_1)
			end
		end

		function arg_615_1.onSingleLineUpdate_(arg_618_0)
			if 0 < arg_615_1.time_ and arg_615_1.time_ <= 0 + arg_618_0 and not isNil(arg_615_1.actors_["10058ui_story"]) and arg_615_1.var_.characterEffect10058ui_story == nil then
				arg_615_1.var_.characterEffect10058ui_story = arg_615_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_618_0 = 0.200000002980232

			if 0 <= arg_615_1.time_ and arg_615_1.time_ < 0 + var_618_0 and not isNil(arg_615_1.actors_["10058ui_story"]) then
				if arg_615_1.var_.characterEffect10058ui_story and not isNil(arg_615_1.actors_["10058ui_story"]) then
					arg_615_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_615_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_615_1.time_ - 0) / var_618_0)
				end
			end

			if arg_615_1.time_ >= 0 + var_618_0 and arg_615_1.time_ < 0 + var_618_0 + arg_618_0 and not isNil(arg_615_1.actors_["10058ui_story"]) and arg_615_1.var_.characterEffect10058ui_story then
				arg_615_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_615_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_618_1 = 0
			local var_618_2 = 0.85

			if 0 < arg_615_1.time_ and arg_615_1.time_ <= var_618_1 + arg_618_0 then
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

				local var_618_3 = arg_615_1:GetWordFromCfg(1109502152)
				local var_618_4 = arg_615_1:FormatText(var_618_3.content)

				arg_615_1.text_.text = var_618_4

				LuaForUtil.ClearLinePrefixSymbol(arg_615_1.text_)

				local var_618_6 = 34 <= 0 and var_618_2 or var_618_2 * (utf8.len(var_618_4) / 34)

				if (34 <= 0 and var_618_2 or var_618_2 * (utf8.len(var_618_4) / 34)) > 0 and var_618_2 < var_618_6 then
					arg_615_1.talkMaxDuration = var_618_6

					if var_618_6 + var_618_1 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_6 + var_618_1
					end
				end

				arg_615_1.text_.text = var_618_4
				arg_615_1.typewritter.percent = 0

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502152", "story_v_side_new_1109502.awb") ~= 0 then
					local var_618_7 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502152", "story_v_side_new_1109502.awb") / 1000

					if var_618_7 + var_618_1 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_7 + var_618_1
					end

					if var_618_3.prefab_name ~= "" and arg_615_1.actors_[var_618_3.prefab_name] ~= nil then
						local var_618_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_615_1.actors_[var_618_3.prefab_name].transform, "story_v_side_new_1109502", "1109502152", "story_v_side_new_1109502.awb")

						arg_615_1:RecordAudio("1109502152", var_618_8)
						arg_615_1:RecordAudio("1109502152", var_618_8)
					else
						arg_615_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502152", "story_v_side_new_1109502.awb")
					end

					arg_615_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502152", "story_v_side_new_1109502.awb")
				end

				arg_615_1:RecordContent(arg_615_1.text_.text)
			end

			local var_618_9 = math.max(var_618_2, arg_615_1.talkMaxDuration)

			if var_618_1 <= arg_615_1.time_ and arg_615_1.time_ < var_618_1 + var_618_9 then
				arg_615_1.typewritter.percent = (arg_615_1.time_ - var_618_1) / var_618_9

				arg_615_1.typewritter:SetDirty()
			end

			if arg_615_1.time_ >= var_618_1 + var_618_9 and arg_615_1.time_ < var_618_1 + var_618_9 + arg_618_0 then
				arg_615_1.typewritter.percent = 1

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(true)
			end
		end

		arg_615_1.nodeConfigList_ = {}

		arg_615_1:InitPlayNodeList()
	end,
	Play1109502153 = function(arg_619_0, arg_619_1)
		arg_619_1.time_ = 0
		arg_619_1.frameCnt_ = 0
		arg_619_1.state_ = "playing"
		arg_619_1.curTalkId_ = 1109502153
		arg_619_1.duration_ = 5.2

		SetActive(arg_619_1.tipsGo_, false)

		function arg_619_1.onSingleLineFinish_()
			arg_619_1.onSingleLineUpdate_ = nil
			arg_619_1.onSingleLineFinish_ = nil
			arg_619_1.state_ = "waiting"
		end

		function arg_619_1.playNext_(arg_621_0)
			if arg_621_0 == 1 then
				arg_619_0:Play1109502154(arg_619_1)
			end
		end

		function arg_619_1.onSingleLineUpdate_(arg_622_0)
			if 0 < arg_619_1.time_ and arg_619_1.time_ <= 0 + arg_622_0 then
				arg_619_1.var_.moveOldPos10058ui_story = arg_619_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_622_0 = 0.001

			if 0 <= arg_619_1.time_ and arg_619_1.time_ < 0 + var_622_0 then
				arg_619_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_619_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_619_1.time_ - 0) / var_622_0)
				arg_619_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_619_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_619_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_619_1.actors_["10058ui_story"].transform.position).z)
				arg_619_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_619_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_619_1.actors_["10058ui_story"].transform.localEulerAngles = arg_619_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_619_1.time_ >= 0 + var_622_0 and arg_619_1.time_ < 0 + var_622_0 + arg_622_0 then
				arg_619_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_619_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_619_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_619_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_619_1.actors_["10058ui_story"].transform.position).z)
				arg_619_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_619_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_619_1.actors_["10058ui_story"].transform.localEulerAngles = arg_619_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_622_1 = arg_619_1.actors_["10058ui_story"]

			if 0 < arg_619_1.time_ and arg_619_1.time_ <= 0 + arg_622_0 and not isNil(var_622_1) and arg_619_1.var_.characterEffect10058ui_story == nil then
				arg_619_1.var_.characterEffect10058ui_story = var_622_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_622_2 = 0.200000002980232

			if 0 <= arg_619_1.time_ and arg_619_1.time_ < 0 + var_622_2 and not isNil(var_622_1) then
				if arg_619_1.var_.characterEffect10058ui_story and not isNil(var_622_1) then
					arg_619_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_619_1.time_ >= 0 + var_622_2 and arg_619_1.time_ < 0 + var_622_2 + arg_622_0 and not isNil(var_622_1) and arg_619_1.var_.characterEffect10058ui_story then
				arg_619_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_619_1.time_ and arg_619_1.time_ <= 0 + arg_622_0 then
				arg_619_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095actionlink/1095action426")
			end

			local var_622_4 = 0
			local var_622_5 = 0.625

			if 0 < arg_619_1.time_ and arg_619_1.time_ <= var_622_4 + arg_622_0 then
				arg_619_1.talkMaxDuration = 0
				arg_619_1.dialogCg_.alpha = 1

				arg_619_1.dialog_:SetActive(true)
				SetActive(arg_619_1.leftNameGo_, true)

				arg_619_1.leftNameTxt_.text = arg_619_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_619_1.leftNameTxt_.transform)

				arg_619_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_619_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_619_1:RecordName(arg_619_1.leftNameTxt_.text)
				SetActive(arg_619_1.iconTrs_.gameObject, false)
				arg_619_1.callingController_:SetSelectedState("normal")

				local var_622_6 = arg_619_1:GetWordFromCfg(1109502153)
				local var_622_7 = arg_619_1:FormatText(var_622_6.content)

				arg_619_1.text_.text = var_622_7

				LuaForUtil.ClearLinePrefixSymbol(arg_619_1.text_)

				local var_622_9 = 25 <= 0 and var_622_5 or var_622_5 * (utf8.len(var_622_7) / 25)

				if (25 <= 0 and var_622_5 or var_622_5 * (utf8.len(var_622_7) / 25)) > 0 and var_622_5 < var_622_9 then
					arg_619_1.talkMaxDuration = var_622_9

					if var_622_9 + var_622_4 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_9 + var_622_4
					end
				end

				arg_619_1.text_.text = var_622_7
				arg_619_1.typewritter.percent = 0

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502153", "story_v_side_new_1109502.awb") ~= 0 then
					local var_622_10 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502153", "story_v_side_new_1109502.awb") / 1000

					if var_622_10 + var_622_4 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_10 + var_622_4
					end

					if var_622_6.prefab_name ~= "" and arg_619_1.actors_[var_622_6.prefab_name] ~= nil then
						local var_622_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_619_1.actors_[var_622_6.prefab_name].transform, "story_v_side_new_1109502", "1109502153", "story_v_side_new_1109502.awb")

						arg_619_1:RecordAudio("1109502153", var_622_11)
						arg_619_1:RecordAudio("1109502153", var_622_11)
					else
						arg_619_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502153", "story_v_side_new_1109502.awb")
					end

					arg_619_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502153", "story_v_side_new_1109502.awb")
				end

				arg_619_1:RecordContent(arg_619_1.text_.text)
			end

			local var_622_12 = math.max(var_622_5, arg_619_1.talkMaxDuration)

			if var_622_4 <= arg_619_1.time_ and arg_619_1.time_ < var_622_4 + var_622_12 then
				arg_619_1.typewritter.percent = (arg_619_1.time_ - var_622_4) / var_622_12

				arg_619_1.typewritter:SetDirty()
			end

			if arg_619_1.time_ >= var_622_4 + var_622_12 and arg_619_1.time_ < var_622_4 + var_622_12 + arg_622_0 then
				arg_619_1.typewritter.percent = 1

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(true)
			end
		end

		arg_619_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_619_1:InitPlayNodeList()
	end,
	Play1109502154 = function(arg_623_0, arg_623_1)
		arg_623_1.time_ = 0
		arg_623_1.frameCnt_ = 0
		arg_623_1.state_ = "playing"
		arg_623_1.curTalkId_ = 1109502154
		arg_623_1.duration_ = 8.23

		SetActive(arg_623_1.tipsGo_, false)

		function arg_623_1.onSingleLineFinish_()
			arg_623_1.onSingleLineUpdate_ = nil
			arg_623_1.onSingleLineFinish_ = nil
			arg_623_1.state_ = "waiting"
		end

		function arg_623_1.playNext_(arg_625_0)
			if arg_625_0 == 1 then
				arg_623_0:Play1109502155(arg_623_1)
			end
		end

		function arg_623_1.onSingleLineUpdate_(arg_626_0)
			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 and not isNil(arg_623_1.actors_["10058ui_story"]) and arg_623_1.var_.characterEffect10058ui_story == nil then
				arg_623_1.var_.characterEffect10058ui_story = arg_623_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_626_0 = 0.200000002980232

			if 0 <= arg_623_1.time_ and arg_623_1.time_ < 0 + var_626_0 and not isNil(arg_623_1.actors_["10058ui_story"]) then
				if arg_623_1.var_.characterEffect10058ui_story and not isNil(arg_623_1.actors_["10058ui_story"]) then
					arg_623_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_623_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_623_1.time_ - 0) / var_626_0)
				end
			end

			if arg_623_1.time_ >= 0 + var_626_0 and arg_623_1.time_ < 0 + var_626_0 + arg_626_0 and not isNil(arg_623_1.actors_["10058ui_story"]) and arg_623_1.var_.characterEffect10058ui_story then
				arg_623_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_623_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_626_1 = arg_623_1.actors_["10058ui_story"].transform

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 then
				arg_623_1.var_.moveOldPos10058ui_story = var_626_1.localPosition
			end

			local var_626_2 = 0.001

			if 0 <= arg_623_1.time_ and arg_623_1.time_ < 0 + var_626_2 then
				var_626_1.localPosition = Vector3.Lerp(arg_623_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_623_1.time_ - 0) / var_626_2)
				var_626_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_626_1.position).x, (manager.ui.mainCamera.transform.position - var_626_1.position).y, (manager.ui.mainCamera.transform.position - var_626_1.position).z)
				var_626_1.localEulerAngles.z = 0
				var_626_1.localEulerAngles.x = 0
				var_626_1.localEulerAngles = var_626_1.localEulerAngles
			end

			if arg_623_1.time_ >= 0 + var_626_2 and arg_623_1.time_ < 0 + var_626_2 + arg_626_0 then
				var_626_1.localPosition = Vector3.New(0, 100, 0)
				var_626_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_626_1.position).x, (manager.ui.mainCamera.transform.position - var_626_1.position).y, (manager.ui.mainCamera.transform.position - var_626_1.position).z)
				var_626_1.localEulerAngles.z = 0
				var_626_1.localEulerAngles.x = 0
				var_626_1.localEulerAngles = var_626_1.localEulerAngles
			end

			local var_626_3 = 0
			local var_626_4 = 0.625

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= var_626_3 + arg_626_0 then
				arg_623_1.talkMaxDuration = 0
				arg_623_1.dialogCg_.alpha = 1

				arg_623_1.dialog_:SetActive(true)
				SetActive(arg_623_1.leftNameGo_, false)

				arg_623_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_623_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_623_1:RecordName(arg_623_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_623_1.iconTrs_.gameObject, false)
				arg_623_1.callingController_:SetSelectedState("normal")

				local var_626_5 = arg_623_1:GetWordFromCfg(1109502154)
				local var_626_6 = arg_623_1:FormatText(var_626_5.content)

				arg_623_1.text_.text = var_626_6

				LuaForUtil.ClearLinePrefixSymbol(arg_623_1.text_)

				local var_626_8 = 25 <= 0 and var_626_4 or var_626_4 * (utf8.len(var_626_6) / 25)

				if (25 <= 0 and var_626_4 or var_626_4 * (utf8.len(var_626_6) / 25)) > 0 and var_626_4 < var_626_8 then
					arg_623_1.talkMaxDuration = var_626_8

					if var_626_8 + var_626_3 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_8 + var_626_3
					end
				end

				arg_623_1.text_.text = var_626_6
				arg_623_1.typewritter.percent = 0

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502154", "story_v_side_new_1109502.awb") ~= 0 then
					local var_626_9 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502154", "story_v_side_new_1109502.awb") / 1000

					if var_626_9 + var_626_3 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_9 + var_626_3
					end

					if var_626_5.prefab_name ~= "" and arg_623_1.actors_[var_626_5.prefab_name] ~= nil then
						local var_626_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_623_1.actors_[var_626_5.prefab_name].transform, "story_v_side_new_1109502", "1109502154", "story_v_side_new_1109502.awb")

						arg_623_1:RecordAudio("1109502154", var_626_10)
						arg_623_1:RecordAudio("1109502154", var_626_10)
					else
						arg_623_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502154", "story_v_side_new_1109502.awb")
					end

					arg_623_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502154", "story_v_side_new_1109502.awb")
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

		arg_623_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_623_1:InitPlayNodeList()
	end,
	Play1109502155 = function(arg_627_0, arg_627_1)
		arg_627_1.time_ = 0
		arg_627_1.frameCnt_ = 0
		arg_627_1.state_ = "playing"
		arg_627_1.curTalkId_ = 1109502155
		arg_627_1.duration_ = 5

		SetActive(arg_627_1.tipsGo_, false)

		function arg_627_1.onSingleLineFinish_()
			arg_627_1.onSingleLineUpdate_ = nil
			arg_627_1.onSingleLineFinish_ = nil
			arg_627_1.state_ = "waiting"
		end

		function arg_627_1.playNext_(arg_629_0)
			if arg_629_0 == 1 then
				arg_627_0:Play1109502156(arg_627_1)
			end
		end

		function arg_627_1.onSingleLineUpdate_(arg_630_0)
			local var_630_0 = 0.1

			if 0 < arg_627_1.time_ and arg_627_1.time_ <= 0 + arg_630_0 then
				arg_627_1.talkMaxDuration = 0
				arg_627_1.dialogCg_.alpha = 1

				arg_627_1.dialog_:SetActive(true)
				SetActive(arg_627_1.leftNameGo_, true)

				arg_627_1.leftNameTxt_.text = arg_627_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_627_1.leftNameTxt_.transform)

				arg_627_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_627_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_627_1:RecordName(arg_627_1.leftNameTxt_.text)
				SetActive(arg_627_1.iconTrs_.gameObject, true)
				arg_627_1.iconController_:SetSelectedState("hero")

				arg_627_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_627_1.callingController_:SetSelectedState("normal")

				arg_627_1.keyicon_.color = Color.New(1, 1, 1)
				arg_627_1.icon_.color = Color.New(1, 1, 1)

				local var_630_1 = arg_627_1:FormatText(arg_627_1:GetWordFromCfg(1109502155).content)

				arg_627_1.text_.text = var_630_1

				LuaForUtil.ClearLinePrefixSymbol(arg_627_1.text_)

				local var_630_3 = 4 <= 0 and var_630_0 or var_630_0 * (utf8.len(var_630_1) / 4)

				if (4 <= 0 and var_630_0 or var_630_0 * (utf8.len(var_630_1) / 4)) > 0 and var_630_0 < var_630_3 then
					arg_627_1.talkMaxDuration = var_630_3

					if var_630_3 + 0 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_3 + 0
					end
				end

				arg_627_1.text_.text = var_630_1
				arg_627_1.typewritter.percent = 0

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(false)
				arg_627_1:RecordContent(arg_627_1.text_.text)
			end

			local var_630_4 = math.max(var_630_0, arg_627_1.talkMaxDuration)

			if 0 <= arg_627_1.time_ and arg_627_1.time_ < 0 + var_630_4 then
				arg_627_1.typewritter.percent = (arg_627_1.time_ - 0) / var_630_4

				arg_627_1.typewritter:SetDirty()
			end

			if arg_627_1.time_ >= 0 + var_630_4 and arg_627_1.time_ < 0 + var_630_4 + arg_630_0 then
				arg_627_1.typewritter.percent = 1

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(true)
			end
		end

		arg_627_1.nodeConfigList_ = {}

		arg_627_1:InitPlayNodeList()
	end,
	Play1109502156 = function(arg_631_0, arg_631_1)
		arg_631_1.time_ = 0
		arg_631_1.frameCnt_ = 0
		arg_631_1.state_ = "playing"
		arg_631_1.curTalkId_ = 1109502156
		arg_631_1.duration_ = 5.4

		SetActive(arg_631_1.tipsGo_, false)

		function arg_631_1.onSingleLineFinish_()
			arg_631_1.onSingleLineUpdate_ = nil
			arg_631_1.onSingleLineFinish_ = nil
			arg_631_1.state_ = "waiting"
		end

		function arg_631_1.playNext_(arg_633_0)
			if arg_633_0 == 1 then
				arg_631_0:Play1109502157(arg_631_1)
			end
		end

		function arg_631_1.onSingleLineUpdate_(arg_634_0)
			if 0 < arg_631_1.time_ and arg_631_1.time_ <= 0 + arg_634_0 and not isNil(arg_631_1.actors_["10058ui_story"]) and arg_631_1.var_.characterEffect10058ui_story == nil then
				arg_631_1.var_.characterEffect10058ui_story = arg_631_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_634_0 = 0.200000002980232

			if 0 <= arg_631_1.time_ and arg_631_1.time_ < 0 + var_634_0 and not isNil(arg_631_1.actors_["10058ui_story"]) then
				if arg_631_1.var_.characterEffect10058ui_story and not isNil(arg_631_1.actors_["10058ui_story"]) then
					arg_631_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_631_1.time_ >= 0 + var_634_0 and arg_631_1.time_ < 0 + var_634_0 + arg_634_0 and not isNil(arg_631_1.actors_["10058ui_story"]) and arg_631_1.var_.characterEffect10058ui_story then
				arg_631_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_631_1.time_ and arg_631_1.time_ <= 0 + arg_634_0 then
				arg_631_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_634_2 = arg_631_1.actors_["10058ui_story"].transform

			if 0 < arg_631_1.time_ and arg_631_1.time_ <= 0 + arg_634_0 then
				arg_631_1.var_.moveOldPos10058ui_story = var_634_2.localPosition
			end

			local var_634_3 = 0.001

			if 0 <= arg_631_1.time_ and arg_631_1.time_ < 0 + var_634_3 then
				var_634_2.localPosition = Vector3.Lerp(arg_631_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_631_1.time_ - 0) / var_634_3)
				var_634_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_634_2.position).x, (manager.ui.mainCamera.transform.position - var_634_2.position).y, (manager.ui.mainCamera.transform.position - var_634_2.position).z)
				var_634_2.localEulerAngles.z = 0
				var_634_2.localEulerAngles.x = 0
				var_634_2.localEulerAngles = var_634_2.localEulerAngles
			end

			if arg_631_1.time_ >= 0 + var_634_3 and arg_631_1.time_ < 0 + var_634_3 + arg_634_0 then
				var_634_2.localPosition = Vector3.New(0, -0.98, -6.1)
				var_634_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_634_2.position).x, (manager.ui.mainCamera.transform.position - var_634_2.position).y, (manager.ui.mainCamera.transform.position - var_634_2.position).z)
				var_634_2.localEulerAngles.z = 0
				var_634_2.localEulerAngles.x = 0
				var_634_2.localEulerAngles = var_634_2.localEulerAngles
			end

			local var_634_4 = 0
			local var_634_5 = 0.7

			if 0 < arg_631_1.time_ and arg_631_1.time_ <= var_634_4 + arg_634_0 then
				arg_631_1.talkMaxDuration = 0
				arg_631_1.dialogCg_.alpha = 1

				arg_631_1.dialog_:SetActive(true)
				SetActive(arg_631_1.leftNameGo_, true)

				arg_631_1.leftNameTxt_.text = arg_631_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_631_1.leftNameTxt_.transform)

				arg_631_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_631_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_631_1:RecordName(arg_631_1.leftNameTxt_.text)
				SetActive(arg_631_1.iconTrs_.gameObject, false)
				arg_631_1.callingController_:SetSelectedState("normal")

				local var_634_6 = arg_631_1:GetWordFromCfg(1109502156)
				local var_634_7 = arg_631_1:FormatText(var_634_6.content)

				arg_631_1.text_.text = var_634_7

				LuaForUtil.ClearLinePrefixSymbol(arg_631_1.text_)

				local var_634_9 = 28 <= 0 and var_634_5 or var_634_5 * (utf8.len(var_634_7) / 28)

				if (28 <= 0 and var_634_5 or var_634_5 * (utf8.len(var_634_7) / 28)) > 0 and var_634_5 < var_634_9 then
					arg_631_1.talkMaxDuration = var_634_9

					if var_634_9 + var_634_4 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_9 + var_634_4
					end
				end

				arg_631_1.text_.text = var_634_7
				arg_631_1.typewritter.percent = 0

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502156", "story_v_side_new_1109502.awb") ~= 0 then
					local var_634_10 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502156", "story_v_side_new_1109502.awb") / 1000

					if var_634_10 + var_634_4 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_10 + var_634_4
					end

					if var_634_6.prefab_name ~= "" and arg_631_1.actors_[var_634_6.prefab_name] ~= nil then
						local var_634_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_631_1.actors_[var_634_6.prefab_name].transform, "story_v_side_new_1109502", "1109502156", "story_v_side_new_1109502.awb")

						arg_631_1:RecordAudio("1109502156", var_634_11)
						arg_631_1:RecordAudio("1109502156", var_634_11)
					else
						arg_631_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502156", "story_v_side_new_1109502.awb")
					end

					arg_631_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502156", "story_v_side_new_1109502.awb")
				end

				arg_631_1:RecordContent(arg_631_1.text_.text)
			end

			local var_634_12 = math.max(var_634_5, arg_631_1.talkMaxDuration)

			if var_634_4 <= arg_631_1.time_ and arg_631_1.time_ < var_634_4 + var_634_12 then
				arg_631_1.typewritter.percent = (arg_631_1.time_ - var_634_4) / var_634_12

				arg_631_1.typewritter:SetDirty()
			end

			if arg_631_1.time_ >= var_634_4 + var_634_12 and arg_631_1.time_ < var_634_4 + var_634_12 + arg_634_0 then
				arg_631_1.typewritter.percent = 1

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(true)
			end
		end

		arg_631_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_631_1:InitPlayNodeList()
	end,
	Play1109502157 = function(arg_635_0, arg_635_1)
		arg_635_1.time_ = 0
		arg_635_1.frameCnt_ = 0
		arg_635_1.state_ = "playing"
		arg_635_1.curTalkId_ = 1109502157
		arg_635_1.duration_ = 9.23

		local var_635_0 = {
			zh = 3,
			ja = 9.233
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
				arg_635_0:Play1109502158(arg_635_1)
			end
		end

		function arg_635_1.onSingleLineUpdate_(arg_638_0)
			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 and not isNil(arg_635_1.actors_["10058ui_story"]) and arg_635_1.var_.characterEffect10058ui_story == nil then
				arg_635_1.var_.characterEffect10058ui_story = arg_635_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_638_0 = 0.200000002980232

			if 0 <= arg_635_1.time_ and arg_635_1.time_ < 0 + var_638_0 and not isNil(arg_635_1.actors_["10058ui_story"]) then
				if arg_635_1.var_.characterEffect10058ui_story and not isNil(arg_635_1.actors_["10058ui_story"]) then
					arg_635_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_635_1.time_ >= 0 + var_638_0 and arg_635_1.time_ < 0 + var_638_0 + arg_638_0 and not isNil(arg_635_1.actors_["10058ui_story"]) and arg_635_1.var_.characterEffect10058ui_story then
				arg_635_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_638_2 = 0
			local var_638_3 = 0.35

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= var_638_2 + arg_638_0 then
				arg_635_1.talkMaxDuration = 0
				arg_635_1.dialogCg_.alpha = 1

				arg_635_1.dialog_:SetActive(true)
				SetActive(arg_635_1.leftNameGo_, true)

				arg_635_1.leftNameTxt_.text = arg_635_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_635_1.leftNameTxt_.transform)

				arg_635_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_635_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_635_1:RecordName(arg_635_1.leftNameTxt_.text)
				SetActive(arg_635_1.iconTrs_.gameObject, false)
				arg_635_1.callingController_:SetSelectedState("normal")

				local var_638_4 = arg_635_1:GetWordFromCfg(1109502157)
				local var_638_5 = arg_635_1:FormatText(var_638_4.content)

				arg_635_1.text_.text = var_638_5

				LuaForUtil.ClearLinePrefixSymbol(arg_635_1.text_)

				local var_638_7 = 14 <= 0 and var_638_3 or var_638_3 * (utf8.len(var_638_5) / 14)

				if (14 <= 0 and var_638_3 or var_638_3 * (utf8.len(var_638_5) / 14)) > 0 and var_638_3 < var_638_7 then
					arg_635_1.talkMaxDuration = var_638_7

					if var_638_7 + var_638_2 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_7 + var_638_2
					end
				end

				arg_635_1.text_.text = var_638_5
				arg_635_1.typewritter.percent = 0

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502157", "story_v_side_new_1109502.awb") ~= 0 then
					local var_638_8 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502157", "story_v_side_new_1109502.awb") / 1000

					if var_638_8 + var_638_2 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_8 + var_638_2
					end

					if var_638_4.prefab_name ~= "" and arg_635_1.actors_[var_638_4.prefab_name] ~= nil then
						local var_638_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_635_1.actors_[var_638_4.prefab_name].transform, "story_v_side_new_1109502", "1109502157", "story_v_side_new_1109502.awb")

						arg_635_1:RecordAudio("1109502157", var_638_9)
						arg_635_1:RecordAudio("1109502157", var_638_9)
					else
						arg_635_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502157", "story_v_side_new_1109502.awb")
					end

					arg_635_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502157", "story_v_side_new_1109502.awb")
				end

				arg_635_1:RecordContent(arg_635_1.text_.text)
			end

			local var_638_10 = math.max(var_638_3, arg_635_1.talkMaxDuration)

			if var_638_2 <= arg_635_1.time_ and arg_635_1.time_ < var_638_2 + var_638_10 then
				arg_635_1.typewritter.percent = (arg_635_1.time_ - var_638_2) / var_638_10

				arg_635_1.typewritter:SetDirty()
			end

			if arg_635_1.time_ >= var_638_2 + var_638_10 and arg_635_1.time_ < var_638_2 + var_638_10 + arg_638_0 then
				arg_635_1.typewritter.percent = 1

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(true)
			end
		end

		arg_635_1.nodeConfigList_ = {}

		arg_635_1:InitPlayNodeList()
	end,
	Play1109502158 = function(arg_639_0, arg_639_1)
		arg_639_1.time_ = 0
		arg_639_1.frameCnt_ = 0
		arg_639_1.state_ = "playing"
		arg_639_1.curTalkId_ = 1109502158
		arg_639_1.duration_ = 6.17

		SetActive(arg_639_1.tipsGo_, false)

		function arg_639_1.onSingleLineFinish_()
			arg_639_1.onSingleLineUpdate_ = nil
			arg_639_1.onSingleLineFinish_ = nil
			arg_639_1.state_ = "waiting"
		end

		function arg_639_1.playNext_(arg_641_0)
			if arg_641_0 == 1 then
				arg_639_0:Play1109502159(arg_639_1)
			end
		end

		function arg_639_1.onSingleLineUpdate_(arg_642_0)
			if 0 < arg_639_1.time_ and arg_639_1.time_ <= 0 + arg_642_0 and not isNil(arg_639_1.actors_["10058ui_story"]) and arg_639_1.var_.characterEffect10058ui_story == nil then
				arg_639_1.var_.characterEffect10058ui_story = arg_639_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_642_0 = 0.200000002980232

			if 0 <= arg_639_1.time_ and arg_639_1.time_ < 0 + var_642_0 and not isNil(arg_639_1.actors_["10058ui_story"]) then
				if arg_639_1.var_.characterEffect10058ui_story and not isNil(arg_639_1.actors_["10058ui_story"]) then
					arg_639_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_639_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_639_1.time_ - 0) / var_642_0)
				end
			end

			if arg_639_1.time_ >= 0 + var_642_0 and arg_639_1.time_ < 0 + var_642_0 + arg_642_0 and not isNil(arg_639_1.actors_["10058ui_story"]) and arg_639_1.var_.characterEffect10058ui_story then
				arg_639_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_639_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_642_1 = 0
			local var_642_2 = 0.125

			if 0 < arg_639_1.time_ and arg_639_1.time_ <= var_642_1 + arg_642_0 then
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

				local var_642_3 = arg_639_1:GetWordFromCfg(1109502158)
				local var_642_4 = arg_639_1:FormatText(var_642_3.content)

				arg_639_1.text_.text = var_642_4

				LuaForUtil.ClearLinePrefixSymbol(arg_639_1.text_)

				local var_642_6 = 5 <= 0 and var_642_2 or var_642_2 * (utf8.len(var_642_4) / 5)

				if (5 <= 0 and var_642_2 or var_642_2 * (utf8.len(var_642_4) / 5)) > 0 and var_642_2 < var_642_6 then
					arg_639_1.talkMaxDuration = var_642_6

					if var_642_6 + var_642_1 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_6 + var_642_1
					end
				end

				arg_639_1.text_.text = var_642_4
				arg_639_1.typewritter.percent = 0

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502158", "story_v_side_new_1109502.awb") ~= 0 then
					local var_642_7 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502158", "story_v_side_new_1109502.awb") / 1000

					if var_642_7 + var_642_1 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_7 + var_642_1
					end

					if var_642_3.prefab_name ~= "" and arg_639_1.actors_[var_642_3.prefab_name] ~= nil then
						local var_642_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_639_1.actors_[var_642_3.prefab_name].transform, "story_v_side_new_1109502", "1109502158", "story_v_side_new_1109502.awb")

						arg_639_1:RecordAudio("1109502158", var_642_8)
						arg_639_1:RecordAudio("1109502158", var_642_8)
					else
						arg_639_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502158", "story_v_side_new_1109502.awb")
					end

					arg_639_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502158", "story_v_side_new_1109502.awb")
				end

				arg_639_1:RecordContent(arg_639_1.text_.text)
			end

			local var_642_9 = math.max(var_642_2, arg_639_1.talkMaxDuration)

			if var_642_1 <= arg_639_1.time_ and arg_639_1.time_ < var_642_1 + var_642_9 then
				arg_639_1.typewritter.percent = (arg_639_1.time_ - var_642_1) / var_642_9

				arg_639_1.typewritter:SetDirty()
			end

			if arg_639_1.time_ >= var_642_1 + var_642_9 and arg_639_1.time_ < var_642_1 + var_642_9 + arg_642_0 then
				arg_639_1.typewritter.percent = 1

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(true)
			end
		end

		arg_639_1.nodeConfigList_ = {}

		arg_639_1:InitPlayNodeList()
	end,
	Play1109502159 = function(arg_643_0, arg_643_1)
		arg_643_1.time_ = 0
		arg_643_1.frameCnt_ = 0
		arg_643_1.state_ = "playing"
		arg_643_1.curTalkId_ = 1109502159
		arg_643_1.duration_ = 3.5

		SetActive(arg_643_1.tipsGo_, false)

		function arg_643_1.onSingleLineFinish_()
			arg_643_1.onSingleLineUpdate_ = nil
			arg_643_1.onSingleLineFinish_ = nil
			arg_643_1.state_ = "waiting"
		end

		function arg_643_1.playNext_(arg_645_0)
			if arg_645_0 == 1 then
				arg_643_0:Play1109502160(arg_643_1)
			end
		end

		function arg_643_1.onSingleLineUpdate_(arg_646_0)
			if 0 < arg_643_1.time_ and arg_643_1.time_ <= 0 + arg_646_0 then
				arg_643_1.var_.moveOldPos10058ui_story = arg_643_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_646_0 = 0.001

			if 0 <= arg_643_1.time_ and arg_643_1.time_ < 0 + var_646_0 then
				arg_643_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_643_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_643_1.time_ - 0) / var_646_0)
				arg_643_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_643_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_643_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_643_1.actors_["10058ui_story"].transform.position).z)
				arg_643_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_643_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_643_1.actors_["10058ui_story"].transform.localEulerAngles = arg_643_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_643_1.time_ >= 0 + var_646_0 and arg_643_1.time_ < 0 + var_646_0 + arg_646_0 then
				arg_643_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_643_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_643_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_643_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_643_1.actors_["10058ui_story"].transform.position).z)
				arg_643_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_643_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_643_1.actors_["10058ui_story"].transform.localEulerAngles = arg_643_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_646_1 = arg_643_1.actors_["10058ui_story"]

			if 0 < arg_643_1.time_ and arg_643_1.time_ <= 0 + arg_646_0 and not isNil(var_646_1) and arg_643_1.var_.characterEffect10058ui_story == nil then
				arg_643_1.var_.characterEffect10058ui_story = var_646_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_646_2 = 0.200000002980232

			if 0 <= arg_643_1.time_ and arg_643_1.time_ < 0 + var_646_2 and not isNil(var_646_1) then
				if arg_643_1.var_.characterEffect10058ui_story and not isNil(var_646_1) then
					arg_643_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_643_1.time_ >= 0 + var_646_2 and arg_643_1.time_ < 0 + var_646_2 + arg_646_0 and not isNil(var_646_1) and arg_643_1.var_.characterEffect10058ui_story then
				arg_643_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_646_4 = 0
			local var_646_5 = 0.375

			if 0 < arg_643_1.time_ and arg_643_1.time_ <= var_646_4 + arg_646_0 then
				arg_643_1.talkMaxDuration = 0
				arg_643_1.dialogCg_.alpha = 1

				arg_643_1.dialog_:SetActive(true)
				SetActive(arg_643_1.leftNameGo_, true)

				arg_643_1.leftNameTxt_.text = arg_643_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_643_1.leftNameTxt_.transform)

				arg_643_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_643_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_643_1:RecordName(arg_643_1.leftNameTxt_.text)
				SetActive(arg_643_1.iconTrs_.gameObject, false)
				arg_643_1.callingController_:SetSelectedState("normal")

				local var_646_6 = arg_643_1:GetWordFromCfg(1109502159)
				local var_646_7 = arg_643_1:FormatText(var_646_6.content)

				arg_643_1.text_.text = var_646_7

				LuaForUtil.ClearLinePrefixSymbol(arg_643_1.text_)

				local var_646_9 = 15 <= 0 and var_646_5 or var_646_5 * (utf8.len(var_646_7) / 15)

				if (15 <= 0 and var_646_5 or var_646_5 * (utf8.len(var_646_7) / 15)) > 0 and var_646_5 < var_646_9 then
					arg_643_1.talkMaxDuration = var_646_9

					if var_646_9 + var_646_4 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_9 + var_646_4
					end
				end

				arg_643_1.text_.text = var_646_7
				arg_643_1.typewritter.percent = 0

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502159", "story_v_side_new_1109502.awb") ~= 0 then
					local var_646_10 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502159", "story_v_side_new_1109502.awb") / 1000

					if var_646_10 + var_646_4 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_10 + var_646_4
					end

					if var_646_6.prefab_name ~= "" and arg_643_1.actors_[var_646_6.prefab_name] ~= nil then
						local var_646_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_643_1.actors_[var_646_6.prefab_name].transform, "story_v_side_new_1109502", "1109502159", "story_v_side_new_1109502.awb")

						arg_643_1:RecordAudio("1109502159", var_646_11)
						arg_643_1:RecordAudio("1109502159", var_646_11)
					else
						arg_643_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502159", "story_v_side_new_1109502.awb")
					end

					arg_643_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502159", "story_v_side_new_1109502.awb")
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
				actorName = "10058ui_story",
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
	Play1109502160 = function(arg_647_0, arg_647_1)
		arg_647_1.time_ = 0
		arg_647_1.frameCnt_ = 0
		arg_647_1.state_ = "playing"
		arg_647_1.curTalkId_ = 1109502160
		arg_647_1.duration_ = 6.03

		SetActive(arg_647_1.tipsGo_, false)

		function arg_647_1.onSingleLineFinish_()
			arg_647_1.onSingleLineUpdate_ = nil
			arg_647_1.onSingleLineFinish_ = nil
			arg_647_1.state_ = "waiting"
		end

		function arg_647_1.playNext_(arg_649_0)
			if arg_649_0 == 1 then
				arg_647_0:Play1109502161(arg_647_1)
			end
		end

		function arg_647_1.onSingleLineUpdate_(arg_650_0)
			if 0 < arg_647_1.time_ and arg_647_1.time_ <= 0 + arg_650_0 and not isNil(arg_647_1.actors_["10058ui_story"]) and arg_647_1.var_.characterEffect10058ui_story == nil then
				arg_647_1.var_.characterEffect10058ui_story = arg_647_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_650_0 = 0.200000002980232

			if 0 <= arg_647_1.time_ and arg_647_1.time_ < 0 + var_650_0 and not isNil(arg_647_1.actors_["10058ui_story"]) then
				if arg_647_1.var_.characterEffect10058ui_story and not isNil(arg_647_1.actors_["10058ui_story"]) then
					arg_647_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_647_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_647_1.time_ - 0) / var_650_0)
				end
			end

			if arg_647_1.time_ >= 0 + var_650_0 and arg_647_1.time_ < 0 + var_650_0 + arg_650_0 and not isNil(arg_647_1.actors_["10058ui_story"]) and arg_647_1.var_.characterEffect10058ui_story then
				arg_647_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_647_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_650_1 = arg_647_1.actors_["10058ui_story"].transform

			if 0 < arg_647_1.time_ and arg_647_1.time_ <= 0 + arg_650_0 then
				arg_647_1.var_.moveOldPos10058ui_story = var_650_1.localPosition
			end

			local var_650_2 = 0.001

			if 0 <= arg_647_1.time_ and arg_647_1.time_ < 0 + var_650_2 then
				var_650_1.localPosition = Vector3.Lerp(arg_647_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_647_1.time_ - 0) / var_650_2)
				var_650_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_650_1.position).x, (manager.ui.mainCamera.transform.position - var_650_1.position).y, (manager.ui.mainCamera.transform.position - var_650_1.position).z)
				var_650_1.localEulerAngles.z = 0
				var_650_1.localEulerAngles.x = 0
				var_650_1.localEulerAngles = var_650_1.localEulerAngles
			end

			if arg_647_1.time_ >= 0 + var_650_2 and arg_647_1.time_ < 0 + var_650_2 + arg_650_0 then
				var_650_1.localPosition = Vector3.New(0, 100, 0)
				var_650_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_650_1.position).x, (manager.ui.mainCamera.transform.position - var_650_1.position).y, (manager.ui.mainCamera.transform.position - var_650_1.position).z)
				var_650_1.localEulerAngles.z = 0
				var_650_1.localEulerAngles.x = 0
				var_650_1.localEulerAngles = var_650_1.localEulerAngles
			end

			local var_650_3 = 0
			local var_650_4 = 0.5

			if 0 < arg_647_1.time_ and arg_647_1.time_ <= var_650_3 + arg_650_0 then
				arg_647_1.talkMaxDuration = 0
				arg_647_1.dialogCg_.alpha = 1

				arg_647_1.dialog_:SetActive(true)
				SetActive(arg_647_1.leftNameGo_, false)

				arg_647_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_647_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_647_1:RecordName(arg_647_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_647_1.iconTrs_.gameObject, false)
				arg_647_1.callingController_:SetSelectedState("normal")

				local var_650_5 = arg_647_1:GetWordFromCfg(1109502160)
				local var_650_6 = arg_647_1:FormatText(var_650_5.content)

				arg_647_1.text_.text = var_650_6

				LuaForUtil.ClearLinePrefixSymbol(arg_647_1.text_)

				local var_650_8 = 20 <= 0 and var_650_4 or var_650_4 * (utf8.len(var_650_6) / 20)

				if (20 <= 0 and var_650_4 or var_650_4 * (utf8.len(var_650_6) / 20)) > 0 and var_650_4 < var_650_8 then
					arg_647_1.talkMaxDuration = var_650_8

					if var_650_8 + var_650_3 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_8 + var_650_3
					end
				end

				arg_647_1.text_.text = var_650_6
				arg_647_1.typewritter.percent = 0

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502160", "story_v_side_new_1109502.awb") ~= 0 then
					local var_650_9 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502160", "story_v_side_new_1109502.awb") / 1000

					if var_650_9 + var_650_3 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_9 + var_650_3
					end

					if var_650_5.prefab_name ~= "" and arg_647_1.actors_[var_650_5.prefab_name] ~= nil then
						local var_650_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_647_1.actors_[var_650_5.prefab_name].transform, "story_v_side_new_1109502", "1109502160", "story_v_side_new_1109502.awb")

						arg_647_1:RecordAudio("1109502160", var_650_10)
						arg_647_1:RecordAudio("1109502160", var_650_10)
					else
						arg_647_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502160", "story_v_side_new_1109502.awb")
					end

					arg_647_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502160", "story_v_side_new_1109502.awb")
				end

				arg_647_1:RecordContent(arg_647_1.text_.text)
			end

			local var_650_11 = math.max(var_650_4, arg_647_1.talkMaxDuration)

			if var_650_3 <= arg_647_1.time_ and arg_647_1.time_ < var_650_3 + var_650_11 then
				arg_647_1.typewritter.percent = (arg_647_1.time_ - var_650_3) / var_650_11

				arg_647_1.typewritter:SetDirty()
			end

			if arg_647_1.time_ >= var_650_3 + var_650_11 and arg_647_1.time_ < var_650_3 + var_650_11 + arg_650_0 then
				arg_647_1.typewritter.percent = 1

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(true)
			end
		end

		arg_647_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_647_1:InitPlayNodeList()
	end,
	Play1109502161 = function(arg_651_0, arg_651_1)
		arg_651_1.time_ = 0
		arg_651_1.frameCnt_ = 0
		arg_651_1.state_ = "playing"
		arg_651_1.curTalkId_ = 1109502161
		arg_651_1.duration_ = 9

		SetActive(arg_651_1.tipsGo_, false)

		function arg_651_1.onSingleLineFinish_()
			arg_651_1.onSingleLineUpdate_ = nil
			arg_651_1.onSingleLineFinish_ = nil
			arg_651_1.state_ = "waiting"
		end

		function arg_651_1.playNext_(arg_653_0)
			if arg_653_0 == 1 then
				arg_651_0:Play1109502162(arg_651_1)
			end
		end

		function arg_651_1.onSingleLineUpdate_(arg_654_0)
			if 0 < arg_651_1.time_ and arg_651_1.time_ <= 0 + arg_654_0 then
				local var_654_0 = arg_651_1.bgs_.ST28

				arg_651_1.bgs_.ST28.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_654_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_654_1 = var_654_0:GetComponent("SpriteRenderer")

				if var_654_1 and var_654_1.sprite then
					local var_654_2 = 2 * (var_654_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_654_0.transform.localScale = Vector3.New(var_654_2 / var_654_1.sprite.bounds.size.y < var_654_2 * manager.ui.mainCameraCom_.aspect / var_654_1.sprite.bounds.size.x and var_654_2 * manager.ui.mainCameraCom_.aspect / var_654_1.sprite.bounds.size.x or var_654_2 / var_654_1.sprite.bounds.size.y, var_654_2 / var_654_1.sprite.bounds.size.y < var_654_2 * manager.ui.mainCameraCom_.aspect / var_654_1.sprite.bounds.size.x and var_654_2 * manager.ui.mainCameraCom_.aspect / var_654_1.sprite.bounds.size.x or var_654_2 / var_654_1.sprite.bounds.size.y, 0)
				end

				for iter_654_0, iter_654_1 in pairs(arg_651_1.bgs_) do
					if iter_654_0 ~= "ST28" then
						iter_654_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_654_3 = "I05d"

			if arg_651_1.bgs_.I05d == nil then
				local var_654_4 = Object.Instantiate(arg_651_1.paintGo_)

				var_654_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_654_3)
				var_654_4.name = var_654_3
				var_654_4.transform.parent = arg_651_1.stage_.transform
				var_654_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_651_1.bgs_[var_654_3] = var_654_4
			end

			if 2 < arg_651_1.time_ and arg_651_1.time_ <= 2 + arg_654_0 then
				local var_654_5 = arg_651_1.bgs_.I05d

				arg_651_1.bgs_.I05d.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_654_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_654_6 = var_654_5:GetComponent("SpriteRenderer")

				if var_654_6 and var_654_6.sprite then
					local var_654_7 = 2 * (var_654_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_654_5.transform.localScale = Vector3.New(var_654_7 / var_654_6.sprite.bounds.size.y < var_654_7 * manager.ui.mainCameraCom_.aspect / var_654_6.sprite.bounds.size.x and var_654_7 * manager.ui.mainCameraCom_.aspect / var_654_6.sprite.bounds.size.x or var_654_7 / var_654_6.sprite.bounds.size.y, var_654_7 / var_654_6.sprite.bounds.size.y < var_654_7 * manager.ui.mainCameraCom_.aspect / var_654_6.sprite.bounds.size.x and var_654_7 * manager.ui.mainCameraCom_.aspect / var_654_6.sprite.bounds.size.x or var_654_7 / var_654_6.sprite.bounds.size.y, 0)
				end

				for iter_654_2, iter_654_3 in pairs(arg_651_1.bgs_) do
					if iter_654_2 ~= "I05d" then
						iter_654_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_654_8 = 2

			if 2 < arg_651_1.time_ and arg_651_1.time_ <= var_654_8 + arg_654_0 then
				arg_651_1.mask_.enabled = true
				arg_651_1.mask_.raycastTarget = true

				arg_651_1:SetGaussion(false)
			end

			local var_654_9 = 2

			if var_654_8 <= arg_651_1.time_ and arg_651_1.time_ < var_654_8 + var_654_9 then
				local var_654_10 = Color.New(0, 0, 0)

				var_654_10.a = Mathf.Lerp(1, 0, (arg_651_1.time_ - var_654_8) / var_654_9)
				arg_651_1.mask_.color = var_654_10
			end

			if arg_651_1.time_ >= var_654_8 + var_654_9 and arg_651_1.time_ < var_654_8 + var_654_9 + arg_654_0 then
				local var_654_11 = Color.New(0, 0, 0)

				arg_651_1.mask_.enabled = false
				var_654_11.a = 0
				arg_651_1.mask_.color = var_654_11
			end

			local var_654_12 = 0

			if 0 < arg_651_1.time_ and arg_651_1.time_ <= var_654_12 + arg_654_0 then
				arg_651_1.mask_.enabled = true
				arg_651_1.mask_.raycastTarget = true

				arg_651_1:SetGaussion(false)
			end

			local var_654_13 = 2

			if var_654_12 <= arg_651_1.time_ and arg_651_1.time_ < var_654_12 + var_654_13 then
				local var_654_14 = Color.New(0, 0, 0)

				var_654_14.a = Mathf.Lerp(0, 1, (arg_651_1.time_ - var_654_12) / var_654_13)
				arg_651_1.mask_.color = var_654_14
			end

			if arg_651_1.time_ >= var_654_12 + var_654_13 and arg_651_1.time_ < var_654_12 + var_654_13 + arg_654_0 then
				local var_654_15 = Color.New(0, 0, 0)

				var_654_15.a = 1
				arg_651_1.mask_.color = var_654_15
			end

			if 0 < arg_651_1.time_ and arg_651_1.time_ <= 0 + arg_654_0 then
				arg_651_1:AudioAction("stop", "effect", "se_story_side_1080", "se_story_1080_parkloop", "")
			end

			if arg_651_1.frameCnt_ <= 1 then
				arg_651_1.dialog_:SetActive(false)
			end

			local var_654_17 = 4
			local var_654_18 = 0.25

			if 4 < arg_651_1.time_ and arg_651_1.time_ <= var_654_17 + arg_654_0 then
				arg_651_1.talkMaxDuration = 0

				arg_651_1.dialog_:SetActive(true)

				arg_651_1.dialogCg_.alpha = 0

				local var_654_19 = LeanTween.value(arg_651_1.dialog_, 0, 1, 0.3)

				var_654_19:setOnUpdate(LuaHelper.FloatAction(function(arg_655_0)
					arg_651_1.dialogCg_.alpha = arg_655_0
				end))
				var_654_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_651_1.dialog_)
					var_654_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_651_1.duration_ = arg_651_1.duration_ + 0.3

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

				local var_654_20 = arg_651_1:FormatText(arg_651_1:GetWordFromCfg(1109502161).content)

				arg_651_1.text_.text = var_654_20

				LuaForUtil.ClearLinePrefixSymbol(arg_651_1.text_)

				local var_654_22 = 10 <= 0 and var_654_18 or var_654_18 * (utf8.len(var_654_20) / 10)

				if (10 <= 0 and var_654_18 or var_654_18 * (utf8.len(var_654_20) / 10)) > 0 and var_654_18 < var_654_22 then
					arg_651_1.talkMaxDuration = var_654_22
					var_654_17 = var_654_17 + 0.3

					if var_654_22 + var_654_17 > arg_651_1.duration_ then
						arg_651_1.duration_ = var_654_22 + var_654_17
					end
				end

				arg_651_1.text_.text = var_654_20
				arg_651_1.typewritter.percent = 0

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(false)
				arg_651_1:RecordContent(arg_651_1.text_.text)
			end

			local var_654_23 = var_654_17 + 0.3
			local var_654_24 = math.max(var_654_18, arg_651_1.talkMaxDuration)

			if var_654_17 + 0.3 <= arg_651_1.time_ and arg_651_1.time_ < var_654_23 + var_654_24 then
				arg_651_1.typewritter.percent = (arg_651_1.time_ - var_654_23) / var_654_24

				arg_651_1.typewritter:SetDirty()
			end

			if arg_651_1.time_ >= var_654_23 + var_654_24 and arg_651_1.time_ < var_654_23 + var_654_24 + arg_654_0 then
				arg_651_1.typewritter.percent = 1

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(true)
			end
		end

		arg_651_1.nodeConfigList_ = {}

		arg_651_1:InitPlayNodeList()
	end,
	Play1109502162 = function(arg_657_0, arg_657_1)
		arg_657_1.time_ = 0
		arg_657_1.frameCnt_ = 0
		arg_657_1.state_ = "playing"
		arg_657_1.curTalkId_ = 1109502162
		arg_657_1.duration_ = 4.13

		SetActive(arg_657_1.tipsGo_, false)

		function arg_657_1.onSingleLineFinish_()
			arg_657_1.onSingleLineUpdate_ = nil
			arg_657_1.onSingleLineFinish_ = nil
			arg_657_1.state_ = "waiting"
		end

		function arg_657_1.playNext_(arg_659_0)
			if arg_659_0 == 1 then
				arg_657_0:Play1109502163(arg_657_1)
			end
		end

		function arg_657_1.onSingleLineUpdate_(arg_660_0)
			if 0 < arg_657_1.time_ and arg_657_1.time_ <= 0 + arg_660_0 then
				arg_657_1.var_.moveOldPos10058ui_story = arg_657_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_660_0 = 0.001

			if 0 <= arg_657_1.time_ and arg_657_1.time_ < 0 + var_660_0 then
				arg_657_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_657_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_657_1.time_ - 0) / var_660_0)
				arg_657_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_657_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_657_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_657_1.actors_["10058ui_story"].transform.position).z)
				arg_657_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_657_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_657_1.actors_["10058ui_story"].transform.localEulerAngles = arg_657_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_657_1.time_ >= 0 + var_660_0 and arg_657_1.time_ < 0 + var_660_0 + arg_660_0 then
				arg_657_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_657_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_657_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_657_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_657_1.actors_["10058ui_story"].transform.position).z)
				arg_657_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_657_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_657_1.actors_["10058ui_story"].transform.localEulerAngles = arg_657_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_660_1 = arg_657_1.actors_["10058ui_story"]

			if 0 < arg_657_1.time_ and arg_657_1.time_ <= 0 + arg_660_0 and not isNil(var_660_1) and arg_657_1.var_.characterEffect10058ui_story == nil then
				arg_657_1.var_.characterEffect10058ui_story = var_660_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_660_2 = 0.200000002980232

			if 0 <= arg_657_1.time_ and arg_657_1.time_ < 0 + var_660_2 and not isNil(var_660_1) then
				if arg_657_1.var_.characterEffect10058ui_story and not isNil(var_660_1) then
					arg_657_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_657_1.time_ >= 0 + var_660_2 and arg_657_1.time_ < 0 + var_660_2 + arg_660_0 and not isNil(var_660_1) and arg_657_1.var_.characterEffect10058ui_story then
				arg_657_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_657_1.time_ and arg_657_1.time_ <= 0 + arg_660_0 then
				arg_657_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0.200000002980232 < arg_657_1.time_ and arg_657_1.time_ <= 0.200000002980232 + arg_660_0 then
				arg_657_1:AudioAction("play", "effect", "se_story_side_1096", "se_story_1096_crowd_loop", "")
			end

			local var_660_5 = 0
			local var_660_6 = 0.475

			if 0 < arg_657_1.time_ and arg_657_1.time_ <= var_660_5 + arg_660_0 then
				arg_657_1.talkMaxDuration = 0
				arg_657_1.dialogCg_.alpha = 1

				arg_657_1.dialog_:SetActive(true)
				SetActive(arg_657_1.leftNameGo_, true)

				arg_657_1.leftNameTxt_.text = arg_657_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_657_1.leftNameTxt_.transform)

				arg_657_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_657_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_657_1:RecordName(arg_657_1.leftNameTxt_.text)
				SetActive(arg_657_1.iconTrs_.gameObject, false)
				arg_657_1.callingController_:SetSelectedState("normal")

				local var_660_7 = arg_657_1:GetWordFromCfg(1109502162)
				local var_660_8 = arg_657_1:FormatText(var_660_7.content)

				arg_657_1.text_.text = var_660_8

				LuaForUtil.ClearLinePrefixSymbol(arg_657_1.text_)

				local var_660_10 = 19 <= 0 and var_660_6 or var_660_6 * (utf8.len(var_660_8) / 19)

				if (19 <= 0 and var_660_6 or var_660_6 * (utf8.len(var_660_8) / 19)) > 0 and var_660_6 < var_660_10 then
					arg_657_1.talkMaxDuration = var_660_10

					if var_660_10 + var_660_5 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_10 + var_660_5
					end
				end

				arg_657_1.text_.text = var_660_8
				arg_657_1.typewritter.percent = 0

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502162", "story_v_side_new_1109502.awb") ~= 0 then
					local var_660_11 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502162", "story_v_side_new_1109502.awb") / 1000

					if var_660_11 + var_660_5 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_11 + var_660_5
					end

					if var_660_7.prefab_name ~= "" and arg_657_1.actors_[var_660_7.prefab_name] ~= nil then
						local var_660_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_657_1.actors_[var_660_7.prefab_name].transform, "story_v_side_new_1109502", "1109502162", "story_v_side_new_1109502.awb")

						arg_657_1:RecordAudio("1109502162", var_660_12)
						arg_657_1:RecordAudio("1109502162", var_660_12)
					else
						arg_657_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502162", "story_v_side_new_1109502.awb")
					end

					arg_657_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502162", "story_v_side_new_1109502.awb")
				end

				arg_657_1:RecordContent(arg_657_1.text_.text)
			end

			local var_660_13 = math.max(var_660_6, arg_657_1.talkMaxDuration)

			if var_660_5 <= arg_657_1.time_ and arg_657_1.time_ < var_660_5 + var_660_13 then
				arg_657_1.typewritter.percent = (arg_657_1.time_ - var_660_5) / var_660_13

				arg_657_1.typewritter:SetDirty()
			end

			if arg_657_1.time_ >= var_660_5 + var_660_13 and arg_657_1.time_ < var_660_5 + var_660_13 + arg_660_0 then
				arg_657_1.typewritter.percent = 1

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(true)
			end
		end

		arg_657_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_657_1:InitPlayNodeList()
	end,
	Play1109502163 = function(arg_661_0, arg_661_1)
		arg_661_1.time_ = 0
		arg_661_1.frameCnt_ = 0
		arg_661_1.state_ = "playing"
		arg_661_1.curTalkId_ = 1109502163
		arg_661_1.duration_ = 11.4

		local var_661_0 = {
			zh = 11.4,
			ja = 6.5
		}
		local var_661_1 = manager.audio:GetLocalizationFlag()

		if var_661_0[var_661_1] ~= nil then
			arg_661_1.duration_ = var_661_0[var_661_1]
		end

		SetActive(arg_661_1.tipsGo_, false)

		function arg_661_1.onSingleLineFinish_()
			arg_661_1.onSingleLineUpdate_ = nil
			arg_661_1.onSingleLineFinish_ = nil
			arg_661_1.state_ = "waiting"
		end

		function arg_661_1.playNext_(arg_663_0)
			if arg_663_0 == 1 then
				arg_661_0:Play1109502164(arg_661_1)
			end
		end

		function arg_661_1.onSingleLineUpdate_(arg_664_0)
			if 0 < arg_661_1.time_ and arg_661_1.time_ <= 0 + arg_664_0 and not isNil(arg_661_1.actors_["10058ui_story"]) and arg_661_1.var_.characterEffect10058ui_story == nil then
				arg_661_1.var_.characterEffect10058ui_story = arg_661_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_664_0 = 0.200000002980232

			if 0 <= arg_661_1.time_ and arg_661_1.time_ < 0 + var_664_0 and not isNil(arg_661_1.actors_["10058ui_story"]) then
				if arg_661_1.var_.characterEffect10058ui_story and not isNil(arg_661_1.actors_["10058ui_story"]) then
					arg_661_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_661_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_661_1.time_ - 0) / var_664_0)
				end
			end

			if arg_661_1.time_ >= 0 + var_664_0 and arg_661_1.time_ < 0 + var_664_0 + arg_664_0 and not isNil(arg_661_1.actors_["10058ui_story"]) and arg_661_1.var_.characterEffect10058ui_story then
				arg_661_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_661_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_664_1 = arg_661_1.actors_["10058ui_story"].transform

			if 0 < arg_661_1.time_ and arg_661_1.time_ <= 0 + arg_664_0 then
				arg_661_1.var_.moveOldPos10058ui_story = var_664_1.localPosition
			end

			local var_664_2 = 0.001

			if 0 <= arg_661_1.time_ and arg_661_1.time_ < 0 + var_664_2 then
				var_664_1.localPosition = Vector3.Lerp(arg_661_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_661_1.time_ - 0) / var_664_2)
				var_664_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_664_1.position).x, (manager.ui.mainCamera.transform.position - var_664_1.position).y, (manager.ui.mainCamera.transform.position - var_664_1.position).z)
				var_664_1.localEulerAngles.z = 0
				var_664_1.localEulerAngles.x = 0
				var_664_1.localEulerAngles = var_664_1.localEulerAngles
			end

			if arg_661_1.time_ >= 0 + var_664_2 and arg_661_1.time_ < 0 + var_664_2 + arg_664_0 then
				var_664_1.localPosition = Vector3.New(0, 100, 0)
				var_664_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_664_1.position).x, (manager.ui.mainCamera.transform.position - var_664_1.position).y, (manager.ui.mainCamera.transform.position - var_664_1.position).z)
				var_664_1.localEulerAngles.z = 0
				var_664_1.localEulerAngles.x = 0
				var_664_1.localEulerAngles = var_664_1.localEulerAngles
			end

			local var_664_3 = 0
			local var_664_4 = 1.1

			if 0 < arg_661_1.time_ and arg_661_1.time_ <= var_664_3 + arg_664_0 then
				arg_661_1.talkMaxDuration = 0
				arg_661_1.dialogCg_.alpha = 1

				arg_661_1.dialog_:SetActive(true)
				SetActive(arg_661_1.leftNameGo_, true)

				arg_661_1.leftNameTxt_.text = arg_661_1:FormatText(StoryNameCfg[426].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_661_1.leftNameTxt_.transform)

				arg_661_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_661_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_661_1:RecordName(arg_661_1.leftNameTxt_.text)
				SetActive(arg_661_1.iconTrs_.gameObject, true)
				arg_661_1.iconController_:SetSelectedState("hero")

				arg_661_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_661_1.callingController_:SetSelectedState("normal")

				arg_661_1.keyicon_.color = Color.New(1, 1, 1)
				arg_661_1.icon_.color = Color.New(1, 1, 1)

				local var_664_5 = arg_661_1:GetWordFromCfg(1109502163)
				local var_664_6 = arg_661_1:FormatText(var_664_5.content)

				arg_661_1.text_.text = var_664_6

				LuaForUtil.ClearLinePrefixSymbol(arg_661_1.text_)

				local var_664_8 = 44 <= 0 and var_664_4 or var_664_4 * (utf8.len(var_664_6) / 44)

				if (44 <= 0 and var_664_4 or var_664_4 * (utf8.len(var_664_6) / 44)) > 0 and var_664_4 < var_664_8 then
					arg_661_1.talkMaxDuration = var_664_8

					if var_664_8 + var_664_3 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_8 + var_664_3
					end
				end

				arg_661_1.text_.text = var_664_6
				arg_661_1.typewritter.percent = 0

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502163", "story_v_side_new_1109502.awb") ~= 0 then
					local var_664_9 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502163", "story_v_side_new_1109502.awb") / 1000

					if var_664_9 + var_664_3 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_9 + var_664_3
					end

					if var_664_5.prefab_name ~= "" and arg_661_1.actors_[var_664_5.prefab_name] ~= nil then
						local var_664_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_661_1.actors_[var_664_5.prefab_name].transform, "story_v_side_new_1109502", "1109502163", "story_v_side_new_1109502.awb")

						arg_661_1:RecordAudio("1109502163", var_664_10)
						arg_661_1:RecordAudio("1109502163", var_664_10)
					else
						arg_661_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502163", "story_v_side_new_1109502.awb")
					end

					arg_661_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502163", "story_v_side_new_1109502.awb")
				end

				arg_661_1:RecordContent(arg_661_1.text_.text)
			end

			local var_664_11 = math.max(var_664_4, arg_661_1.talkMaxDuration)

			if var_664_3 <= arg_661_1.time_ and arg_661_1.time_ < var_664_3 + var_664_11 then
				arg_661_1.typewritter.percent = (arg_661_1.time_ - var_664_3) / var_664_11

				arg_661_1.typewritter:SetDirty()
			end

			if arg_661_1.time_ >= var_664_3 + var_664_11 and arg_661_1.time_ < var_664_3 + var_664_11 + arg_664_0 then
				arg_661_1.typewritter.percent = 1

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(true)
			end
		end

		arg_661_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_661_1:InitPlayNodeList()
	end,
	Play1109502164 = function(arg_665_0, arg_665_1)
		arg_665_1.time_ = 0
		arg_665_1.frameCnt_ = 0
		arg_665_1.state_ = "playing"
		arg_665_1.curTalkId_ = 1109502164
		arg_665_1.duration_ = 18.17

		local var_665_0 = {
			zh = 9.733,
			ja = 18.166
		}
		local var_665_1 = manager.audio:GetLocalizationFlag()

		if var_665_0[var_665_1] ~= nil then
			arg_665_1.duration_ = var_665_0[var_665_1]
		end

		SetActive(arg_665_1.tipsGo_, false)

		function arg_665_1.onSingleLineFinish_()
			arg_665_1.onSingleLineUpdate_ = nil
			arg_665_1.onSingleLineFinish_ = nil
			arg_665_1.state_ = "waiting"
		end

		function arg_665_1.playNext_(arg_667_0)
			if arg_667_0 == 1 then
				arg_665_0:Play1109502165(arg_665_1)
			end
		end

		function arg_665_1.onSingleLineUpdate_(arg_668_0)
			local var_668_0 = 1.25

			if 0 < arg_665_1.time_ and arg_665_1.time_ <= 0 + arg_668_0 then
				arg_665_1.talkMaxDuration = 0
				arg_665_1.dialogCg_.alpha = 1

				arg_665_1.dialog_:SetActive(true)
				SetActive(arg_665_1.leftNameGo_, true)

				arg_665_1.leftNameTxt_.text = arg_665_1:FormatText(StoryNameCfg[426].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_665_1.leftNameTxt_.transform)

				arg_665_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_665_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_665_1:RecordName(arg_665_1.leftNameTxt_.text)
				SetActive(arg_665_1.iconTrs_.gameObject, true)
				arg_665_1.iconController_:SetSelectedState("hero")

				arg_665_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_665_1.callingController_:SetSelectedState("normal")

				arg_665_1.keyicon_.color = Color.New(1, 1, 1)
				arg_665_1.icon_.color = Color.New(1, 1, 1)

				local var_668_1 = arg_665_1:GetWordFromCfg(1109502164)
				local var_668_2 = arg_665_1:FormatText(var_668_1.content)

				arg_665_1.text_.text = var_668_2

				LuaForUtil.ClearLinePrefixSymbol(arg_665_1.text_)

				local var_668_4 = 50 <= 0 and var_668_0 or var_668_0 * (utf8.len(var_668_2) / 50)

				if (50 <= 0 and var_668_0 or var_668_0 * (utf8.len(var_668_2) / 50)) > 0 and var_668_0 < var_668_4 then
					arg_665_1.talkMaxDuration = var_668_4

					if var_668_4 + 0 > arg_665_1.duration_ then
						arg_665_1.duration_ = var_668_4 + 0
					end
				end

				arg_665_1.text_.text = var_668_2
				arg_665_1.typewritter.percent = 0

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502164", "story_v_side_new_1109502.awb") ~= 0 then
					local var_668_5 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502164", "story_v_side_new_1109502.awb") / 1000

					if var_668_5 + 0 > arg_665_1.duration_ then
						arg_665_1.duration_ = var_668_5 + 0
					end

					if var_668_1.prefab_name ~= "" and arg_665_1.actors_[var_668_1.prefab_name] ~= nil then
						local var_668_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_665_1.actors_[var_668_1.prefab_name].transform, "story_v_side_new_1109502", "1109502164", "story_v_side_new_1109502.awb")

						arg_665_1:RecordAudio("1109502164", var_668_6)
						arg_665_1:RecordAudio("1109502164", var_668_6)
					else
						arg_665_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502164", "story_v_side_new_1109502.awb")
					end

					arg_665_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502164", "story_v_side_new_1109502.awb")
				end

				arg_665_1:RecordContent(arg_665_1.text_.text)
			end

			local var_668_7 = math.max(var_668_0, arg_665_1.talkMaxDuration)

			if 0 <= arg_665_1.time_ and arg_665_1.time_ < 0 + var_668_7 then
				arg_665_1.typewritter.percent = (arg_665_1.time_ - 0) / var_668_7

				arg_665_1.typewritter:SetDirty()
			end

			if arg_665_1.time_ >= 0 + var_668_7 and arg_665_1.time_ < 0 + var_668_7 + arg_668_0 then
				arg_665_1.typewritter.percent = 1

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(true)
			end
		end

		arg_665_1.nodeConfigList_ = {}

		arg_665_1:InitPlayNodeList()
	end,
	Play1109502165 = function(arg_669_0, arg_669_1)
		arg_669_1.time_ = 0
		arg_669_1.frameCnt_ = 0
		arg_669_1.state_ = "playing"
		arg_669_1.curTalkId_ = 1109502165
		arg_669_1.duration_ = 15.6

		SetActive(arg_669_1.tipsGo_, false)

		function arg_669_1.onSingleLineFinish_()
			arg_669_1.onSingleLineUpdate_ = nil
			arg_669_1.onSingleLineFinish_ = nil
			arg_669_1.state_ = "waiting"
		end

		function arg_669_1.playNext_(arg_671_0)
			if arg_671_0 == 1 then
				arg_669_0:Play1109502166(arg_669_1)
			end
		end

		function arg_669_1.onSingleLineUpdate_(arg_672_0)
			local var_672_0 = 0.525

			if 0 < arg_669_1.time_ and arg_669_1.time_ <= 0 + arg_672_0 then
				arg_669_1.talkMaxDuration = 0
				arg_669_1.dialogCg_.alpha = 1

				arg_669_1.dialog_:SetActive(true)
				SetActive(arg_669_1.leftNameGo_, false)

				arg_669_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_669_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_669_1:RecordName(arg_669_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_669_1.iconTrs_.gameObject, false)
				arg_669_1.callingController_:SetSelectedState("normal")

				local var_672_1 = arg_669_1:GetWordFromCfg(1109502165)
				local var_672_2 = arg_669_1:FormatText(var_672_1.content)

				arg_669_1.text_.text = var_672_2

				LuaForUtil.ClearLinePrefixSymbol(arg_669_1.text_)

				local var_672_4 = 21 <= 0 and var_672_0 or var_672_0 * (utf8.len(var_672_2) / 21)

				if (21 <= 0 and var_672_0 or var_672_0 * (utf8.len(var_672_2) / 21)) > 0 and var_672_0 < var_672_4 then
					arg_669_1.talkMaxDuration = var_672_4

					if var_672_4 + 0 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_4 + 0
					end
				end

				arg_669_1.text_.text = var_672_2
				arg_669_1.typewritter.percent = 0

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502165", "story_v_side_new_1109502.awb") ~= 0 then
					local var_672_5 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502165", "story_v_side_new_1109502.awb") / 1000

					if var_672_5 + 0 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_5 + 0
					end

					if var_672_1.prefab_name ~= "" and arg_669_1.actors_[var_672_1.prefab_name] ~= nil then
						local var_672_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_669_1.actors_[var_672_1.prefab_name].transform, "story_v_side_new_1109502", "1109502165", "story_v_side_new_1109502.awb")

						arg_669_1:RecordAudio("1109502165", var_672_6)
						arg_669_1:RecordAudio("1109502165", var_672_6)
					else
						arg_669_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502165", "story_v_side_new_1109502.awb")
					end

					arg_669_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502165", "story_v_side_new_1109502.awb")
				end

				arg_669_1:RecordContent(arg_669_1.text_.text)
			end

			local var_672_7 = math.max(var_672_0, arg_669_1.talkMaxDuration)

			if 0 <= arg_669_1.time_ and arg_669_1.time_ < 0 + var_672_7 then
				arg_669_1.typewritter.percent = (arg_669_1.time_ - 0) / var_672_7

				arg_669_1.typewritter:SetDirty()
			end

			if arg_669_1.time_ >= 0 + var_672_7 and arg_669_1.time_ < 0 + var_672_7 + arg_672_0 then
				arg_669_1.typewritter.percent = 1

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(true)
			end
		end

		arg_669_1.nodeConfigList_ = {}

		arg_669_1:InitPlayNodeList()
	end,
	Play1109502166 = function(arg_673_0, arg_673_1)
		arg_673_1.time_ = 0
		arg_673_1.frameCnt_ = 0
		arg_673_1.state_ = "playing"
		arg_673_1.curTalkId_ = 1109502166
		arg_673_1.duration_ = 4.27

		SetActive(arg_673_1.tipsGo_, false)

		function arg_673_1.onSingleLineFinish_()
			arg_673_1.onSingleLineUpdate_ = nil
			arg_673_1.onSingleLineFinish_ = nil
			arg_673_1.state_ = "waiting"
		end

		function arg_673_1.playNext_(arg_675_0)
			if arg_675_0 == 1 then
				arg_673_0:Play1109502167(arg_673_1)
			end
		end

		function arg_673_1.onSingleLineUpdate_(arg_676_0)
			local var_676_0 = 0.575

			if 0 < arg_673_1.time_ and arg_673_1.time_ <= 0 + arg_676_0 then
				arg_673_1.talkMaxDuration = 0
				arg_673_1.dialogCg_.alpha = 1

				arg_673_1.dialog_:SetActive(true)
				SetActive(arg_673_1.leftNameGo_, true)

				arg_673_1.leftNameTxt_.text = arg_673_1:FormatText(StoryNameCfg[426].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_673_1.leftNameTxt_.transform)

				arg_673_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_673_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_673_1:RecordName(arg_673_1.leftNameTxt_.text)
				SetActive(arg_673_1.iconTrs_.gameObject, true)
				arg_673_1.iconController_:SetSelectedState("hero")

				arg_673_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_673_1.callingController_:SetSelectedState("normal")

				arg_673_1.keyicon_.color = Color.New(1, 1, 1)
				arg_673_1.icon_.color = Color.New(1, 1, 1)

				local var_676_1 = arg_673_1:GetWordFromCfg(1109502166)
				local var_676_2 = arg_673_1:FormatText(var_676_1.content)

				arg_673_1.text_.text = var_676_2

				LuaForUtil.ClearLinePrefixSymbol(arg_673_1.text_)

				local var_676_4 = 23 <= 0 and var_676_0 or var_676_0 * (utf8.len(var_676_2) / 23)

				if (23 <= 0 and var_676_0 or var_676_0 * (utf8.len(var_676_2) / 23)) > 0 and var_676_0 < var_676_4 then
					arg_673_1.talkMaxDuration = var_676_4

					if var_676_4 + 0 > arg_673_1.duration_ then
						arg_673_1.duration_ = var_676_4 + 0
					end
				end

				arg_673_1.text_.text = var_676_2
				arg_673_1.typewritter.percent = 0

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502166", "story_v_side_new_1109502.awb") ~= 0 then
					local var_676_5 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502166", "story_v_side_new_1109502.awb") / 1000

					if var_676_5 + 0 > arg_673_1.duration_ then
						arg_673_1.duration_ = var_676_5 + 0
					end

					if var_676_1.prefab_name ~= "" and arg_673_1.actors_[var_676_1.prefab_name] ~= nil then
						local var_676_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_673_1.actors_[var_676_1.prefab_name].transform, "story_v_side_new_1109502", "1109502166", "story_v_side_new_1109502.awb")

						arg_673_1:RecordAudio("1109502166", var_676_6)
						arg_673_1:RecordAudio("1109502166", var_676_6)
					else
						arg_673_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502166", "story_v_side_new_1109502.awb")
					end

					arg_673_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502166", "story_v_side_new_1109502.awb")
				end

				arg_673_1:RecordContent(arg_673_1.text_.text)
			end

			local var_676_7 = math.max(var_676_0, arg_673_1.talkMaxDuration)

			if 0 <= arg_673_1.time_ and arg_673_1.time_ < 0 + var_676_7 then
				arg_673_1.typewritter.percent = (arg_673_1.time_ - 0) / var_676_7

				arg_673_1.typewritter:SetDirty()
			end

			if arg_673_1.time_ >= 0 + var_676_7 and arg_673_1.time_ < 0 + var_676_7 + arg_676_0 then
				arg_673_1.typewritter.percent = 1

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(true)
			end
		end

		arg_673_1.nodeConfigList_ = {}

		arg_673_1:InitPlayNodeList()
	end,
	Play1109502167 = function(arg_677_0, arg_677_1)
		arg_677_1.time_ = 0
		arg_677_1.frameCnt_ = 0
		arg_677_1.state_ = "playing"
		arg_677_1.curTalkId_ = 1109502167
		arg_677_1.duration_ = 5.77

		SetActive(arg_677_1.tipsGo_, false)

		function arg_677_1.onSingleLineFinish_()
			arg_677_1.onSingleLineUpdate_ = nil
			arg_677_1.onSingleLineFinish_ = nil
			arg_677_1.state_ = "waiting"
		end

		function arg_677_1.playNext_(arg_679_0)
			if arg_679_0 == 1 then
				arg_677_0:Play1109502168(arg_677_1)
			end
		end

		function arg_677_1.onSingleLineUpdate_(arg_680_0)
			local var_680_0 = 0.225

			if 0 < arg_677_1.time_ and arg_677_1.time_ <= 0 + arg_680_0 then
				arg_677_1.talkMaxDuration = 0
				arg_677_1.dialogCg_.alpha = 1

				arg_677_1.dialog_:SetActive(true)
				SetActive(arg_677_1.leftNameGo_, true)

				arg_677_1.leftNameTxt_.text = arg_677_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_677_1.leftNameTxt_.transform)

				arg_677_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_677_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_677_1:RecordName(arg_677_1.leftNameTxt_.text)
				SetActive(arg_677_1.iconTrs_.gameObject, true)
				arg_677_1.iconController_:SetSelectedState("hero")

				arg_677_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_677_1.callingController_:SetSelectedState("normal")

				arg_677_1.keyicon_.color = Color.New(1, 1, 1)
				arg_677_1.icon_.color = Color.New(1, 1, 1)

				local var_680_1 = arg_677_1:GetWordFromCfg(1109502167)
				local var_680_2 = arg_677_1:FormatText(var_680_1.content)

				arg_677_1.text_.text = var_680_2

				LuaForUtil.ClearLinePrefixSymbol(arg_677_1.text_)

				local var_680_4 = 9 <= 0 and var_680_0 or var_680_0 * (utf8.len(var_680_2) / 9)

				if (9 <= 0 and var_680_0 or var_680_0 * (utf8.len(var_680_2) / 9)) > 0 and var_680_0 < var_680_4 then
					arg_677_1.talkMaxDuration = var_680_4

					if var_680_4 + 0 > arg_677_1.duration_ then
						arg_677_1.duration_ = var_680_4 + 0
					end
				end

				arg_677_1.text_.text = var_680_2
				arg_677_1.typewritter.percent = 0

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502167", "story_v_side_new_1109502.awb") ~= 0 then
					local var_680_5 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502167", "story_v_side_new_1109502.awb") / 1000

					if var_680_5 + 0 > arg_677_1.duration_ then
						arg_677_1.duration_ = var_680_5 + 0
					end

					if var_680_1.prefab_name ~= "" and arg_677_1.actors_[var_680_1.prefab_name] ~= nil then
						local var_680_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_677_1.actors_[var_680_1.prefab_name].transform, "story_v_side_new_1109502", "1109502167", "story_v_side_new_1109502.awb")

						arg_677_1:RecordAudio("1109502167", var_680_6)
						arg_677_1:RecordAudio("1109502167", var_680_6)
					else
						arg_677_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502167", "story_v_side_new_1109502.awb")
					end

					arg_677_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502167", "story_v_side_new_1109502.awb")
				end

				arg_677_1:RecordContent(arg_677_1.text_.text)
			end

			local var_680_7 = math.max(var_680_0, arg_677_1.talkMaxDuration)

			if 0 <= arg_677_1.time_ and arg_677_1.time_ < 0 + var_680_7 then
				arg_677_1.typewritter.percent = (arg_677_1.time_ - 0) / var_680_7

				arg_677_1.typewritter:SetDirty()
			end

			if arg_677_1.time_ >= 0 + var_680_7 and arg_677_1.time_ < 0 + var_680_7 + arg_680_0 then
				arg_677_1.typewritter.percent = 1

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(true)
			end
		end

		arg_677_1.nodeConfigList_ = {}

		arg_677_1:InitPlayNodeList()
	end,
	Play1109502168 = function(arg_681_0, arg_681_1)
		arg_681_1.time_ = 0
		arg_681_1.frameCnt_ = 0
		arg_681_1.state_ = "playing"
		arg_681_1.curTalkId_ = 1109502168
		arg_681_1.duration_ = 3.93

		SetActive(arg_681_1.tipsGo_, false)

		function arg_681_1.onSingleLineFinish_()
			arg_681_1.onSingleLineUpdate_ = nil
			arg_681_1.onSingleLineFinish_ = nil
			arg_681_1.state_ = "waiting"
		end

		function arg_681_1.playNext_(arg_683_0)
			if arg_683_0 == 1 then
				arg_681_0:Play1109502169(arg_681_1)
			end
		end

		function arg_681_1.onSingleLineUpdate_(arg_684_0)
			if 0 < arg_681_1.time_ and arg_681_1.time_ <= 0 + arg_684_0 then
				arg_681_1.var_.moveOldPos10058ui_story = arg_681_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_684_0 = 0.001

			if 0 <= arg_681_1.time_ and arg_681_1.time_ < 0 + var_684_0 then
				arg_681_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_681_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_681_1.time_ - 0) / var_684_0)
				arg_681_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_681_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_681_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_681_1.actors_["10058ui_story"].transform.position).z)
				arg_681_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_681_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_681_1.actors_["10058ui_story"].transform.localEulerAngles = arg_681_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_681_1.time_ >= 0 + var_684_0 and arg_681_1.time_ < 0 + var_684_0 + arg_684_0 then
				arg_681_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_681_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_681_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_681_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_681_1.actors_["10058ui_story"].transform.position).z)
				arg_681_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_681_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_681_1.actors_["10058ui_story"].transform.localEulerAngles = arg_681_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_684_1 = arg_681_1.actors_["10058ui_story"]

			if 0 < arg_681_1.time_ and arg_681_1.time_ <= 0 + arg_684_0 and not isNil(var_684_1) and arg_681_1.var_.characterEffect10058ui_story == nil then
				arg_681_1.var_.characterEffect10058ui_story = var_684_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_684_2 = 0.200000002980232

			if 0 <= arg_681_1.time_ and arg_681_1.time_ < 0 + var_684_2 and not isNil(var_684_1) then
				if arg_681_1.var_.characterEffect10058ui_story and not isNil(var_684_1) then
					arg_681_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_681_1.time_ >= 0 + var_684_2 and arg_681_1.time_ < 0 + var_684_2 + arg_684_0 and not isNil(var_684_1) and arg_681_1.var_.characterEffect10058ui_story then
				arg_681_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_681_1.time_ and arg_681_1.time_ <= 0 + arg_684_0 then
				arg_681_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_681_1.time_ and arg_681_1.time_ <= 0 + arg_684_0 then
				arg_681_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_684_4 = 0
			local var_684_5 = 0.5

			if 0 < arg_681_1.time_ and arg_681_1.time_ <= var_684_4 + arg_684_0 then
				arg_681_1.talkMaxDuration = 0
				arg_681_1.dialogCg_.alpha = 1

				arg_681_1.dialog_:SetActive(true)
				SetActive(arg_681_1.leftNameGo_, true)

				arg_681_1.leftNameTxt_.text = arg_681_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_681_1.leftNameTxt_.transform)

				arg_681_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_681_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_681_1:RecordName(arg_681_1.leftNameTxt_.text)
				SetActive(arg_681_1.iconTrs_.gameObject, false)
				arg_681_1.callingController_:SetSelectedState("normal")

				local var_684_6 = arg_681_1:GetWordFromCfg(1109502168)
				local var_684_7 = arg_681_1:FormatText(var_684_6.content)

				arg_681_1.text_.text = var_684_7

				LuaForUtil.ClearLinePrefixSymbol(arg_681_1.text_)

				local var_684_9 = 20 <= 0 and var_684_5 or var_684_5 * (utf8.len(var_684_7) / 20)

				if (20 <= 0 and var_684_5 or var_684_5 * (utf8.len(var_684_7) / 20)) > 0 and var_684_5 < var_684_9 then
					arg_681_1.talkMaxDuration = var_684_9

					if var_684_9 + var_684_4 > arg_681_1.duration_ then
						arg_681_1.duration_ = var_684_9 + var_684_4
					end
				end

				arg_681_1.text_.text = var_684_7
				arg_681_1.typewritter.percent = 0

				arg_681_1.typewritter:SetDirty()
				arg_681_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502168", "story_v_side_new_1109502.awb") ~= 0 then
					local var_684_10 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502168", "story_v_side_new_1109502.awb") / 1000

					if var_684_10 + var_684_4 > arg_681_1.duration_ then
						arg_681_1.duration_ = var_684_10 + var_684_4
					end

					if var_684_6.prefab_name ~= "" and arg_681_1.actors_[var_684_6.prefab_name] ~= nil then
						local var_684_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_681_1.actors_[var_684_6.prefab_name].transform, "story_v_side_new_1109502", "1109502168", "story_v_side_new_1109502.awb")

						arg_681_1:RecordAudio("1109502168", var_684_11)
						arg_681_1:RecordAudio("1109502168", var_684_11)
					else
						arg_681_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502168", "story_v_side_new_1109502.awb")
					end

					arg_681_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502168", "story_v_side_new_1109502.awb")
				end

				arg_681_1:RecordContent(arg_681_1.text_.text)
			end

			local var_684_12 = math.max(var_684_5, arg_681_1.talkMaxDuration)

			if var_684_4 <= arg_681_1.time_ and arg_681_1.time_ < var_684_4 + var_684_12 then
				arg_681_1.typewritter.percent = (arg_681_1.time_ - var_684_4) / var_684_12

				arg_681_1.typewritter:SetDirty()
			end

			if arg_681_1.time_ >= var_684_4 + var_684_12 and arg_681_1.time_ < var_684_4 + var_684_12 + arg_684_0 then
				arg_681_1.typewritter.percent = 1

				arg_681_1.typewritter:SetDirty()
				arg_681_1:ShowNextGo(true)
			end
		end

		arg_681_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_681_1:InitPlayNodeList()
	end,
	Play1109502169 = function(arg_685_0, arg_685_1)
		arg_685_1.time_ = 0
		arg_685_1.frameCnt_ = 0
		arg_685_1.state_ = "playing"
		arg_685_1.curTalkId_ = 1109502169
		arg_685_1.duration_ = 1

		SetActive(arg_685_1.tipsGo_, false)

		function arg_685_1.onSingleLineFinish_()
			arg_685_1.onSingleLineUpdate_ = nil
			arg_685_1.onSingleLineFinish_ = nil
			arg_685_1.state_ = "waiting"

			SetActive(arg_685_1.choicesGo_, true)

			for iter_686_0, iter_686_1 in ipairs(arg_685_1.choices_) do
				SetActive(iter_686_1.go, iter_686_0 <= 2)
			end

			arg_685_1.choices_[1].txt.text = arg_685_1:FormatText(StoryChoiceCfg[722].name)
			arg_685_1.choices_[2].txt.text = arg_685_1:FormatText(StoryChoiceCfg[723].name)
		end

		function arg_685_1.playNext_(arg_687_0)
			if arg_687_0 == 1 then
				arg_685_0:Play1109502171(arg_685_1)
			end

			if arg_687_0 == 2 then
				arg_685_0:Play1109502170(arg_685_1)
			end

			arg_685_1:RecordChoiceLog(1109502169, 722, 723)
		end

		function arg_685_1.onSingleLineUpdate_(arg_688_0)
			if 0 < arg_685_1.time_ and arg_685_1.time_ <= 0 + arg_688_0 then
				arg_685_1.allBtn_.enabled = false
			end

			if arg_685_1.time_ >= 0 + 0.5 and arg_685_1.time_ < 0 + 0.5 + arg_688_0 then
				arg_685_1.allBtn_.enabled = true
			end

			local var_688_0 = arg_685_1.actors_["10058ui_story"]

			if 0 < arg_685_1.time_ and arg_685_1.time_ <= 0 + arg_688_0 and not isNil(var_688_0) and arg_685_1.var_.characterEffect10058ui_story == nil then
				arg_685_1.var_.characterEffect10058ui_story = var_688_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_688_1 = 0.2

			if 0 <= arg_685_1.time_ and arg_685_1.time_ < 0 + var_688_1 and not isNil(var_688_0) then
				if arg_685_1.var_.characterEffect10058ui_story and not isNil(var_688_0) then
					arg_685_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_685_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_685_1.time_ - 0) / var_688_1)
				end
			end

			if arg_685_1.time_ >= 0 + var_688_1 and arg_685_1.time_ < 0 + var_688_1 + arg_688_0 and not isNil(var_688_0) and arg_685_1.var_.characterEffect10058ui_story then
				arg_685_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_685_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end
		end

		arg_685_1.nodeConfigList_ = {}

		arg_685_1:InitPlayNodeList()
	end,
	Play1109502171 = function(arg_689_0, arg_689_1)
		arg_689_1.time_ = 0
		arg_689_1.frameCnt_ = 0
		arg_689_1.state_ = "playing"
		arg_689_1.curTalkId_ = 1109502171
		arg_689_1.duration_ = 4.1

		local var_689_0 = {
			zh = 4.1,
			ja = 3.933
		}
		local var_689_1 = manager.audio:GetLocalizationFlag()

		if var_689_0[var_689_1] ~= nil then
			arg_689_1.duration_ = var_689_0[var_689_1]
		end

		SetActive(arg_689_1.tipsGo_, false)

		function arg_689_1.onSingleLineFinish_()
			arg_689_1.onSingleLineUpdate_ = nil
			arg_689_1.onSingleLineFinish_ = nil
			arg_689_1.state_ = "waiting"
			arg_689_1.auto_ = false
		end

		function arg_689_1.playNext_(arg_691_0)
			arg_689_1.onStoryFinished_()
		end

		function arg_689_1.onSingleLineUpdate_(arg_692_0)
			if 0 < arg_689_1.time_ and arg_689_1.time_ <= 0 + arg_692_0 and not isNil(arg_689_1.actors_["10058ui_story"]) and arg_689_1.var_.characterEffect10058ui_story == nil then
				arg_689_1.var_.characterEffect10058ui_story = arg_689_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_692_0 = 0.2

			if 0 <= arg_689_1.time_ and arg_689_1.time_ < 0 + var_692_0 and not isNil(arg_689_1.actors_["10058ui_story"]) then
				if arg_689_1.var_.characterEffect10058ui_story and not isNil(arg_689_1.actors_["10058ui_story"]) then
					arg_689_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_689_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_689_1.time_ - 0) / var_692_0)
				end
			end

			if arg_689_1.time_ >= 0 + var_692_0 and arg_689_1.time_ < 0 + var_692_0 + arg_692_0 and not isNil(arg_689_1.actors_["10058ui_story"]) and arg_689_1.var_.characterEffect10058ui_story then
				arg_689_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_689_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_692_1 = 0
			local var_692_2 = 0.55

			if 0 < arg_689_1.time_ and arg_689_1.time_ <= var_692_1 + arg_692_0 then
				arg_689_1.talkMaxDuration = 0
				arg_689_1.dialogCg_.alpha = 1

				arg_689_1.dialog_:SetActive(true)
				SetActive(arg_689_1.leftNameGo_, true)

				arg_689_1.leftNameTxt_.text = arg_689_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_689_1.leftNameTxt_.transform)

				arg_689_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_689_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_689_1:RecordName(arg_689_1.leftNameTxt_.text)
				SetActive(arg_689_1.iconTrs_.gameObject, false)
				arg_689_1.callingController_:SetSelectedState("normal")

				local var_692_3 = arg_689_1:GetWordFromCfg(1109502171)
				local var_692_4 = arg_689_1:FormatText(var_692_3.content)

				arg_689_1.text_.text = var_692_4

				LuaForUtil.ClearLinePrefixSymbol(arg_689_1.text_)

				local var_692_6 = 22 <= 0 and var_692_2 or var_692_2 * (utf8.len(var_692_4) / 22)

				if (22 <= 0 and var_692_2 or var_692_2 * (utf8.len(var_692_4) / 22)) > 0 and var_692_2 < var_692_6 then
					arg_689_1.talkMaxDuration = var_692_6

					if var_692_6 + var_692_1 > arg_689_1.duration_ then
						arg_689_1.duration_ = var_692_6 + var_692_1
					end
				end

				arg_689_1.text_.text = var_692_4
				arg_689_1.typewritter.percent = 0

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502171", "story_v_side_new_1109502.awb") ~= 0 then
					local var_692_7 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502171", "story_v_side_new_1109502.awb") / 1000

					if var_692_7 + var_692_1 > arg_689_1.duration_ then
						arg_689_1.duration_ = var_692_7 + var_692_1
					end

					if var_692_3.prefab_name ~= "" and arg_689_1.actors_[var_692_3.prefab_name] ~= nil then
						local var_692_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_689_1.actors_[var_692_3.prefab_name].transform, "story_v_side_new_1109502", "1109502171", "story_v_side_new_1109502.awb")

						arg_689_1:RecordAudio("1109502171", var_692_8)
						arg_689_1:RecordAudio("1109502171", var_692_8)
					else
						arg_689_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502171", "story_v_side_new_1109502.awb")
					end

					arg_689_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502171", "story_v_side_new_1109502.awb")
				end

				arg_689_1:RecordContent(arg_689_1.text_.text)
			end

			local var_692_9 = math.max(var_692_2, arg_689_1.talkMaxDuration)

			if var_692_1 <= arg_689_1.time_ and arg_689_1.time_ < var_692_1 + var_692_9 then
				arg_689_1.typewritter.percent = (arg_689_1.time_ - var_692_1) / var_692_9

				arg_689_1.typewritter:SetDirty()
			end

			if arg_689_1.time_ >= var_692_1 + var_692_9 and arg_689_1.time_ < var_692_1 + var_692_9 + arg_692_0 then
				arg_689_1.typewritter.percent = 1

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(true)
			end
		end

		arg_689_1.nodeConfigList_ = {}

		arg_689_1:InitPlayNodeList()
	end,
	Play1109502170 = function(arg_693_0, arg_693_1)
		arg_693_1.time_ = 0
		arg_693_1.frameCnt_ = 0
		arg_693_1.state_ = "playing"
		arg_693_1.curTalkId_ = 1109502170
		arg_693_1.duration_ = 3.67

		SetActive(arg_693_1.tipsGo_, false)

		function arg_693_1.onSingleLineFinish_()
			arg_693_1.onSingleLineUpdate_ = nil
			arg_693_1.onSingleLineFinish_ = nil
			arg_693_1.state_ = "waiting"
		end

		function arg_693_1.playNext_(arg_695_0)
			if arg_695_0 == 1 then
				arg_693_0:Play1109502171(arg_693_1)
			end
		end

		function arg_693_1.onSingleLineUpdate_(arg_696_0)
			if 0 < arg_693_1.time_ and arg_693_1.time_ <= 0 + arg_696_0 and not isNil(arg_693_1.actors_["10058ui_story"]) and arg_693_1.var_.characterEffect10058ui_story == nil then
				arg_693_1.var_.characterEffect10058ui_story = arg_693_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_696_0 = 0.200000002980232

			if 0 <= arg_693_1.time_ and arg_693_1.time_ < 0 + var_696_0 and not isNil(arg_693_1.actors_["10058ui_story"]) then
				if arg_693_1.var_.characterEffect10058ui_story and not isNil(arg_693_1.actors_["10058ui_story"]) then
					arg_693_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_693_1.time_ >= 0 + var_696_0 and arg_693_1.time_ < 0 + var_696_0 + arg_696_0 and not isNil(arg_693_1.actors_["10058ui_story"]) and arg_693_1.var_.characterEffect10058ui_story then
				arg_693_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_696_2 = "10058ui_story"

			if arg_693_1.actors_["10058ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10058ui_story"))) then
				local var_696_3 = Object.Instantiate(Asset.Load("Char/" .. "10058ui_story"), arg_693_1.stage_.transform)

				var_696_3.name = var_696_2
				var_696_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_693_1.actors_[var_696_2] = var_696_3

				local var_696_4 = var_696_3:GetComponentInChildren(typeof(CharacterEffect))

				var_696_4.enabled = true

				local var_696_5 = GameObjectTools.GetOrAddComponent(var_696_3, typeof(DynamicBoneHelper))

				if var_696_5 then
					var_696_5:EnableDynamicBone(false)
				end

				arg_693_1:ShowWeapon(var_696_4.transform, false)

				arg_693_1.var_[var_696_2 .. "Animator"] = var_696_4.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_693_1.var_[var_696_2 .. "Animator"].applyRootMotion = true
				arg_693_1.var_[var_696_2 .. "LipSync"] = var_696_4.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_693_1.time_ and arg_693_1.time_ <= 0 + arg_696_0 then
				arg_693_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_696_6 = 0
			local var_696_7 = 0.425

			if 0 < arg_693_1.time_ and arg_693_1.time_ <= var_696_6 + arg_696_0 then
				arg_693_1.talkMaxDuration = 0
				arg_693_1.dialogCg_.alpha = 1

				arg_693_1.dialog_:SetActive(true)
				SetActive(arg_693_1.leftNameGo_, true)

				arg_693_1.leftNameTxt_.text = arg_693_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_693_1.leftNameTxt_.transform)

				arg_693_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_693_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_693_1:RecordName(arg_693_1.leftNameTxt_.text)
				SetActive(arg_693_1.iconTrs_.gameObject, false)
				arg_693_1.callingController_:SetSelectedState("normal")

				local var_696_8 = arg_693_1:GetWordFromCfg(1109502170)
				local var_696_9 = arg_693_1:FormatText(var_696_8.content)

				arg_693_1.text_.text = var_696_9

				LuaForUtil.ClearLinePrefixSymbol(arg_693_1.text_)

				local var_696_11 = 17 <= 0 and var_696_7 or var_696_7 * (utf8.len(var_696_9) / 17)

				if (17 <= 0 and var_696_7 or var_696_7 * (utf8.len(var_696_9) / 17)) > 0 and var_696_7 < var_696_11 then
					arg_693_1.talkMaxDuration = var_696_11

					if var_696_11 + var_696_6 > arg_693_1.duration_ then
						arg_693_1.duration_ = var_696_11 + var_696_6
					end
				end

				arg_693_1.text_.text = var_696_9
				arg_693_1.typewritter.percent = 0

				arg_693_1.typewritter:SetDirty()
				arg_693_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502170", "story_v_side_new_1109502.awb") ~= 0 then
					local var_696_12 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502170", "story_v_side_new_1109502.awb") / 1000

					if var_696_12 + var_696_6 > arg_693_1.duration_ then
						arg_693_1.duration_ = var_696_12 + var_696_6
					end

					if var_696_8.prefab_name ~= "" and arg_693_1.actors_[var_696_8.prefab_name] ~= nil then
						local var_696_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_693_1.actors_[var_696_8.prefab_name].transform, "story_v_side_new_1109502", "1109502170", "story_v_side_new_1109502.awb")

						arg_693_1:RecordAudio("1109502170", var_696_13)
						arg_693_1:RecordAudio("1109502170", var_696_13)
					else
						arg_693_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502170", "story_v_side_new_1109502.awb")
					end

					arg_693_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502170", "story_v_side_new_1109502.awb")
				end

				arg_693_1:RecordContent(arg_693_1.text_.text)
			end

			local var_696_14 = math.max(var_696_7, arg_693_1.talkMaxDuration)

			if var_696_6 <= arg_693_1.time_ and arg_693_1.time_ < var_696_6 + var_696_14 then
				arg_693_1.typewritter.percent = (arg_693_1.time_ - var_696_6) / var_696_14

				arg_693_1.typewritter:SetDirty()
			end

			if arg_693_1.time_ >= var_696_6 + var_696_14 and arg_693_1.time_ < var_696_6 + var_696_14 + arg_696_0 then
				arg_693_1.typewritter.percent = 1

				arg_693_1.typewritter:SetDirty()
				arg_693_1:ShowNextGo(true)
			end
		end

		arg_693_1.nodeConfigList_ = {}

		arg_693_1:InitPlayNodeList()
	end,
	Play1109502012 = function(arg_697_0, arg_697_1)
		arg_697_1.time_ = 0
		arg_697_1.frameCnt_ = 0
		arg_697_1.state_ = "playing"
		arg_697_1.curTalkId_ = 1109502012
		arg_697_1.duration_ = 5.03

		local var_697_0 = {
			zh = 2.833,
			ja = 5.033
		}
		local var_697_1 = manager.audio:GetLocalizationFlag()

		if var_697_0[var_697_1] ~= nil then
			arg_697_1.duration_ = var_697_0[var_697_1]
		end

		SetActive(arg_697_1.tipsGo_, false)

		function arg_697_1.onSingleLineFinish_()
			arg_697_1.onSingleLineUpdate_ = nil
			arg_697_1.onSingleLineFinish_ = nil
			arg_697_1.state_ = "waiting"
		end

		function arg_697_1.playNext_(arg_699_0)
			if arg_699_0 == 1 then
				arg_697_0:Play1109502016(arg_697_1)
			end
		end

		function arg_697_1.onSingleLineUpdate_(arg_700_0)
			if 0 < arg_697_1.time_ and arg_697_1.time_ <= 0 + arg_700_0 and not isNil(arg_697_1.actors_["10058ui_story"]) and arg_697_1.var_.characterEffect10058ui_story == nil then
				arg_697_1.var_.characterEffect10058ui_story = arg_697_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_700_0 = 0.200000002980232

			if 0 <= arg_697_1.time_ and arg_697_1.time_ < 0 + var_700_0 and not isNil(arg_697_1.actors_["10058ui_story"]) then
				if arg_697_1.var_.characterEffect10058ui_story and not isNil(arg_697_1.actors_["10058ui_story"]) then
					arg_697_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_697_1.time_ >= 0 + var_700_0 and arg_697_1.time_ < 0 + var_700_0 + arg_700_0 and not isNil(arg_697_1.actors_["10058ui_story"]) and arg_697_1.var_.characterEffect10058ui_story then
				arg_697_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_700_2 = 0
			local var_700_3 = 0.35

			if 0 < arg_697_1.time_ and arg_697_1.time_ <= var_700_2 + arg_700_0 then
				arg_697_1.talkMaxDuration = 0
				arg_697_1.dialogCg_.alpha = 1

				arg_697_1.dialog_:SetActive(true)
				SetActive(arg_697_1.leftNameGo_, true)

				arg_697_1.leftNameTxt_.text = arg_697_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_697_1.leftNameTxt_.transform)

				arg_697_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_697_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_697_1:RecordName(arg_697_1.leftNameTxt_.text)
				SetActive(arg_697_1.iconTrs_.gameObject, false)
				arg_697_1.callingController_:SetSelectedState("normal")

				local var_700_4 = arg_697_1:GetWordFromCfg(1109502012)
				local var_700_5 = arg_697_1:FormatText(var_700_4.content)

				arg_697_1.text_.text = var_700_5

				LuaForUtil.ClearLinePrefixSymbol(arg_697_1.text_)

				local var_700_7 = 14 <= 0 and var_700_3 or var_700_3 * (utf8.len(var_700_5) / 14)

				if (14 <= 0 and var_700_3 or var_700_3 * (utf8.len(var_700_5) / 14)) > 0 and var_700_3 < var_700_7 then
					arg_697_1.talkMaxDuration = var_700_7

					if var_700_7 + var_700_2 > arg_697_1.duration_ then
						arg_697_1.duration_ = var_700_7 + var_700_2
					end
				end

				arg_697_1.text_.text = var_700_5
				arg_697_1.typewritter.percent = 0

				arg_697_1.typewritter:SetDirty()
				arg_697_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502012", "story_v_side_new_1109502.awb") ~= 0 then
					local var_700_8 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502012", "story_v_side_new_1109502.awb") / 1000

					if var_700_8 + var_700_2 > arg_697_1.duration_ then
						arg_697_1.duration_ = var_700_8 + var_700_2
					end

					if var_700_4.prefab_name ~= "" and arg_697_1.actors_[var_700_4.prefab_name] ~= nil then
						local var_700_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_697_1.actors_[var_700_4.prefab_name].transform, "story_v_side_new_1109502", "1109502012", "story_v_side_new_1109502.awb")

						arg_697_1:RecordAudio("1109502012", var_700_9)
						arg_697_1:RecordAudio("1109502012", var_700_9)
					else
						arg_697_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502012", "story_v_side_new_1109502.awb")
					end

					arg_697_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502012", "story_v_side_new_1109502.awb")
				end

				arg_697_1:RecordContent(arg_697_1.text_.text)
			end

			local var_700_10 = math.max(var_700_3, arg_697_1.talkMaxDuration)

			if var_700_2 <= arg_697_1.time_ and arg_697_1.time_ < var_700_2 + var_700_10 then
				arg_697_1.typewritter.percent = (arg_697_1.time_ - var_700_2) / var_700_10

				arg_697_1.typewritter:SetDirty()
			end

			if arg_697_1.time_ >= var_700_2 + var_700_10 and arg_697_1.time_ < var_700_2 + var_700_10 + arg_700_0 then
				arg_697_1.typewritter.percent = 1

				arg_697_1.typewritter:SetDirty()
				arg_697_1:ShowNextGo(true)
			end
		end

		arg_697_1.nodeConfigList_ = {}

		arg_697_1:InitPlayNodeList()
	end,
	Play1109502013 = function(arg_701_0, arg_701_1)
		arg_701_1.time_ = 0
		arg_701_1.frameCnt_ = 0
		arg_701_1.state_ = "playing"
		arg_701_1.curTalkId_ = 1109502013
		arg_701_1.duration_ = 3.67

		local var_701_0 = {
			zh = 1.5,
			ja = 3.666
		}
		local var_701_1 = manager.audio:GetLocalizationFlag()

		if var_701_0[var_701_1] ~= nil then
			arg_701_1.duration_ = var_701_0[var_701_1]
		end

		SetActive(arg_701_1.tipsGo_, false)

		function arg_701_1.onSingleLineFinish_()
			arg_701_1.onSingleLineUpdate_ = nil
			arg_701_1.onSingleLineFinish_ = nil
			arg_701_1.state_ = "waiting"
		end

		function arg_701_1.playNext_(arg_703_0)
			if arg_703_0 == 1 then
				arg_701_0:Play1109502014(arg_701_1)
			end
		end

		function arg_701_1.onSingleLineUpdate_(arg_704_0)
			if 0 < arg_701_1.time_ and arg_701_1.time_ <= 0 + arg_704_0 and not isNil(arg_701_1.actors_["10058ui_story"]) and arg_701_1.var_.characterEffect10058ui_story == nil then
				arg_701_1.var_.characterEffect10058ui_story = arg_701_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_704_0 = 0.200000002980232

			if 0 <= arg_701_1.time_ and arg_701_1.time_ < 0 + var_704_0 and not isNil(arg_701_1.actors_["10058ui_story"]) then
				if arg_701_1.var_.characterEffect10058ui_story and not isNil(arg_701_1.actors_["10058ui_story"]) then
					arg_701_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_701_1.time_ >= 0 + var_704_0 and arg_701_1.time_ < 0 + var_704_0 + arg_704_0 and not isNil(arg_701_1.actors_["10058ui_story"]) and arg_701_1.var_.characterEffect10058ui_story then
				arg_701_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_704_2 = 0
			local var_704_3 = 0.15

			if 0 < arg_701_1.time_ and arg_701_1.time_ <= var_704_2 + arg_704_0 then
				arg_701_1.talkMaxDuration = 0
				arg_701_1.dialogCg_.alpha = 1

				arg_701_1.dialog_:SetActive(true)
				SetActive(arg_701_1.leftNameGo_, true)

				arg_701_1.leftNameTxt_.text = arg_701_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_701_1.leftNameTxt_.transform)

				arg_701_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_701_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_701_1:RecordName(arg_701_1.leftNameTxt_.text)
				SetActive(arg_701_1.iconTrs_.gameObject, false)
				arg_701_1.callingController_:SetSelectedState("normal")

				local var_704_4 = arg_701_1:GetWordFromCfg(1109502013)
				local var_704_5 = arg_701_1:FormatText(var_704_4.content)

				arg_701_1.text_.text = var_704_5

				LuaForUtil.ClearLinePrefixSymbol(arg_701_1.text_)

				local var_704_7 = 6 <= 0 and var_704_3 or var_704_3 * (utf8.len(var_704_5) / 6)

				if (6 <= 0 and var_704_3 or var_704_3 * (utf8.len(var_704_5) / 6)) > 0 and var_704_3 < var_704_7 then
					arg_701_1.talkMaxDuration = var_704_7

					if var_704_7 + var_704_2 > arg_701_1.duration_ then
						arg_701_1.duration_ = var_704_7 + var_704_2
					end
				end

				arg_701_1.text_.text = var_704_5
				arg_701_1.typewritter.percent = 0

				arg_701_1.typewritter:SetDirty()
				arg_701_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502013", "story_v_side_new_1109502.awb") ~= 0 then
					local var_704_8 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502013", "story_v_side_new_1109502.awb") / 1000

					if var_704_8 + var_704_2 > arg_701_1.duration_ then
						arg_701_1.duration_ = var_704_8 + var_704_2
					end

					if var_704_4.prefab_name ~= "" and arg_701_1.actors_[var_704_4.prefab_name] ~= nil then
						local var_704_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_701_1.actors_[var_704_4.prefab_name].transform, "story_v_side_new_1109502", "1109502013", "story_v_side_new_1109502.awb")

						arg_701_1:RecordAudio("1109502013", var_704_9)
						arg_701_1:RecordAudio("1109502013", var_704_9)
					else
						arg_701_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502013", "story_v_side_new_1109502.awb")
					end

					arg_701_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502013", "story_v_side_new_1109502.awb")
				end

				arg_701_1:RecordContent(arg_701_1.text_.text)
			end

			local var_704_10 = math.max(var_704_3, arg_701_1.talkMaxDuration)

			if var_704_2 <= arg_701_1.time_ and arg_701_1.time_ < var_704_2 + var_704_10 then
				arg_701_1.typewritter.percent = (arg_701_1.time_ - var_704_2) / var_704_10

				arg_701_1.typewritter:SetDirty()
			end

			if arg_701_1.time_ >= var_704_2 + var_704_10 and arg_701_1.time_ < var_704_2 + var_704_10 + arg_704_0 then
				arg_701_1.typewritter.percent = 1

				arg_701_1.typewritter:SetDirty()
				arg_701_1:ShowNextGo(true)
			end
		end

		arg_701_1.nodeConfigList_ = {}

		arg_701_1:InitPlayNodeList()
	end,
	Play1109502014 = function(arg_705_0, arg_705_1)
		arg_705_1.time_ = 0
		arg_705_1.frameCnt_ = 0
		arg_705_1.state_ = "playing"
		arg_705_1.curTalkId_ = 1109502014
		arg_705_1.duration_ = 5

		SetActive(arg_705_1.tipsGo_, false)

		function arg_705_1.onSingleLineFinish_()
			arg_705_1.onSingleLineUpdate_ = nil
			arg_705_1.onSingleLineFinish_ = nil
			arg_705_1.state_ = "waiting"
		end

		function arg_705_1.playNext_(arg_707_0)
			if arg_707_0 == 1 then
				arg_705_0:Play1109502015(arg_705_1)
			end
		end

		function arg_705_1.onSingleLineUpdate_(arg_708_0)
			local var_708_0 = 0.075

			if 0 < arg_705_1.time_ and arg_705_1.time_ <= 0 + arg_708_0 then
				arg_705_1.talkMaxDuration = 0
				arg_705_1.dialogCg_.alpha = 1

				arg_705_1.dialog_:SetActive(true)
				SetActive(arg_705_1.leftNameGo_, true)

				arg_705_1.leftNameTxt_.text = arg_705_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_705_1.leftNameTxt_.transform)

				arg_705_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_705_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_705_1:RecordName(arg_705_1.leftNameTxt_.text)
				SetActive(arg_705_1.iconTrs_.gameObject, true)
				arg_705_1.iconController_:SetSelectedState("hero")

				arg_705_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_705_1.callingController_:SetSelectedState("normal")

				arg_705_1.keyicon_.color = Color.New(1, 1, 1)
				arg_705_1.icon_.color = Color.New(1, 1, 1)

				local var_708_1 = arg_705_1:FormatText(arg_705_1:GetWordFromCfg(1109502014).content)

				arg_705_1.text_.text = var_708_1

				LuaForUtil.ClearLinePrefixSymbol(arg_705_1.text_)

				local var_708_3 = 3 <= 0 and var_708_0 or var_708_0 * (utf8.len(var_708_1) / 3)

				if (3 <= 0 and var_708_0 or var_708_0 * (utf8.len(var_708_1) / 3)) > 0 and var_708_0 < var_708_3 then
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
	Play1109502015 = function(arg_709_0, arg_709_1)
		arg_709_1.time_ = 0
		arg_709_1.frameCnt_ = 0
		arg_709_1.state_ = "playing"
		arg_709_1.curTalkId_ = 1109502015
		arg_709_1.duration_ = 2.57

		local var_709_0 = {
			zh = 2.566,
			ja = 2.133
		}
		local var_709_1 = manager.audio:GetLocalizationFlag()

		if var_709_0[var_709_1] ~= nil then
			arg_709_1.duration_ = var_709_0[var_709_1]
		end

		SetActive(arg_709_1.tipsGo_, false)

		function arg_709_1.onSingleLineFinish_()
			arg_709_1.onSingleLineUpdate_ = nil
			arg_709_1.onSingleLineFinish_ = nil
			arg_709_1.state_ = "waiting"
		end

		function arg_709_1.playNext_(arg_711_0)
			if arg_711_0 == 1 then
				arg_709_0:Play1109502016(arg_709_1)
			end
		end

		function arg_709_1.onSingleLineUpdate_(arg_712_0)
			local var_712_0 = 0.225

			if 0 < arg_709_1.time_ and arg_709_1.time_ <= 0 + arg_712_0 then
				arg_709_1.talkMaxDuration = 0
				arg_709_1.dialogCg_.alpha = 1

				arg_709_1.dialog_:SetActive(true)
				SetActive(arg_709_1.leftNameGo_, true)

				arg_709_1.leftNameTxt_.text = arg_709_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_709_1.leftNameTxt_.transform)

				arg_709_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_709_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_709_1:RecordName(arg_709_1.leftNameTxt_.text)
				SetActive(arg_709_1.iconTrs_.gameObject, false)
				arg_709_1.callingController_:SetSelectedState("normal")

				local var_712_1 = arg_709_1:GetWordFromCfg(1109502015)
				local var_712_2 = arg_709_1:FormatText(var_712_1.content)

				arg_709_1.text_.text = var_712_2

				LuaForUtil.ClearLinePrefixSymbol(arg_709_1.text_)

				local var_712_4 = 9 <= 0 and var_712_0 or var_712_0 * (utf8.len(var_712_2) / 9)

				if (9 <= 0 and var_712_0 or var_712_0 * (utf8.len(var_712_2) / 9)) > 0 and var_712_0 < var_712_4 then
					arg_709_1.talkMaxDuration = var_712_4

					if var_712_4 + 0 > arg_709_1.duration_ then
						arg_709_1.duration_ = var_712_4 + 0
					end
				end

				arg_709_1.text_.text = var_712_2
				arg_709_1.typewritter.percent = 0

				arg_709_1.typewritter:SetDirty()
				arg_709_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502015", "story_v_side_new_1109502.awb") ~= 0 then
					local var_712_5 = manager.audio:GetVoiceLength("story_v_side_new_1109502", "1109502015", "story_v_side_new_1109502.awb") / 1000

					if var_712_5 + 0 > arg_709_1.duration_ then
						arg_709_1.duration_ = var_712_5 + 0
					end

					if var_712_1.prefab_name ~= "" and arg_709_1.actors_[var_712_1.prefab_name] ~= nil then
						local var_712_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_709_1.actors_[var_712_1.prefab_name].transform, "story_v_side_new_1109502", "1109502015", "story_v_side_new_1109502.awb")

						arg_709_1:RecordAudio("1109502015", var_712_6)
						arg_709_1:RecordAudio("1109502015", var_712_6)
					else
						arg_709_1:AudioAction("play", "voice", "story_v_side_new_1109502", "1109502015", "story_v_side_new_1109502.awb")
					end

					arg_709_1:RecordHistoryTalkVoice("story_v_side_new_1109502", "1109502015", "story_v_side_new_1109502.awb")
				end

				arg_709_1:RecordContent(arg_709_1.text_.text)
			end

			local var_712_7 = math.max(var_712_0, arg_709_1.talkMaxDuration)

			if 0 <= arg_709_1.time_ and arg_709_1.time_ < 0 + var_712_7 then
				arg_709_1.typewritter.percent = (arg_709_1.time_ - 0) / var_712_7

				arg_709_1.typewritter:SetDirty()
			end

			if arg_709_1.time_ >= 0 + var_712_7 and arg_709_1.time_ < 0 + var_712_7 + arg_712_0 then
				arg_709_1.typewritter.percent = 1

				arg_709_1.typewritter:SetDirty()
				arg_709_1:ShowNextGo(true)
			end
		end

		arg_709_1.nodeConfigList_ = {}

		arg_709_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST04b",
		"TextureConfig/Background/ST28",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/I05d"
	},
	voices = {
		"story_v_side_new_1109502.awb"
	}
}
