return {
	Play1102701001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1102701001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1102701002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.B13 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B13")
				var_4_0.name = "B13"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.B13 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.B13

				arg_1_1.bgs_.B13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B13" then
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

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

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
			local var_4_15 = 0.8

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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1102701001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 32 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 32)

				if (32 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 32)) > 0 and var_4_15 < var_4_19 then
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
	Play1102701002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1102701002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1102701003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.35

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(1102701002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 54 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 54)

				if (54 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 54)) > 0 and var_12_0 < var_12_3 then
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
	Play1102701003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1102701003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1102701004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 1.225

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(1102701003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 49 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 49)

				if (49 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 49)) > 0 and var_16_0 < var_16_3 then
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
	Play1102701004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1102701004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1102701005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.9

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

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(1102701004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 36 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 36)

				if (36 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 36)) > 0 and var_20_0 < var_20_3 then
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
	Play1102701005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1102701005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1102701006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 1.2

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

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(1102701005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 48 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 48)

				if (48 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 48)) > 0 and var_24_0 < var_24_3 then
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
	Play1102701006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1102701006
		arg_25_1.duration_ = 4.7

		local var_25_0 = {
			ja = 4.7,
			ko = 3.6,
			zh = 3.6
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
				arg_25_0:Play1102701007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if arg_25_1.actors_["1027ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1027ui_story"))) then
				local var_28_0 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_25_1.stage_.transform)

				var_28_0.name = "1027ui_story"
				var_28_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["1027ui_story"] = var_28_0

				local var_28_1 = var_28_0:GetComponentInChildren(typeof(CharacterEffect))

				var_28_1.enabled = true

				local var_28_2 = GameObjectTools.GetOrAddComponent(var_28_0, typeof(DynamicBoneHelper))

				if var_28_2 then
					var_28_2:EnableDynamicBone(false)
				end

				arg_25_1:ShowWeapon(var_28_1.transform, false)

				arg_25_1.var_["1027ui_story" .. "Animator"] = var_28_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_25_1.var_["1027ui_story" .. "Animator"].applyRootMotion = true
				arg_25_1.var_["1027ui_story" .. "LipSync"] = var_28_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_28_3 = arg_25_1.actors_["1027ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1027ui_story = var_28_3.localPosition
			end

			local var_28_4 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				var_28_3.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_25_1.time_ - 0) / var_28_4)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				var_28_3.localPosition = Vector3.New(0, -0.81, -5.8)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			local var_28_5 = arg_25_1.actors_["1027ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect1027ui_story == nil then
				arg_25_1.var_.characterEffect1027ui_story = var_28_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_6 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_6 and not isNil(var_28_5) then
				if arg_25_1.var_.characterEffect1027ui_story and not isNil(var_28_5) then
					arg_25_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_6 and arg_25_1.time_ < 0 + var_28_6 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect1027ui_story then
				arg_25_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_28_8 = 0
			local var_28_9 = 0.3

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_10 = arg_25_1:GetWordFromCfg(1102701006)
				local var_28_11 = arg_25_1:FormatText(var_28_10.content)

				arg_25_1.text_.text = var_28_11

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_13 = 12 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 12)

				if (12 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 12)) > 0 and var_28_9 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_8
					end
				end

				arg_25_1.text_.text = var_28_11
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701006", "story_v_side_new_1102701.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701006", "story_v_side_new_1102701.awb") / 1000

					if var_28_14 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_8
					end

					if var_28_10.prefab_name ~= "" and arg_25_1.actors_[var_28_10.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_10.prefab_name].transform, "story_v_side_new_1102701", "1102701006", "story_v_side_new_1102701.awb")

						arg_25_1:RecordAudio("1102701006", var_28_15)
						arg_25_1:RecordAudio("1102701006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701006", "story_v_side_new_1102701.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701006", "story_v_side_new_1102701.awb")
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
				actorName = "1027ui_story",
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
	Play1102701007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1102701007
		arg_29_1.duration_ = 9.5

		local var_29_0 = {
			ja = 9.5,
			ko = 8.366,
			zh = 8.366
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
				arg_29_0:Play1102701008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action427")
			end

			local var_32_0 = 0
			local var_32_1 = 0.7

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_2 = arg_29_1:GetWordFromCfg(1102701007)
				local var_32_3 = arg_29_1:FormatText(var_32_2.content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 28 <= 0 and var_32_1 or var_32_1 * (utf8.len(var_32_3) / 28)

				if (28 <= 0 and var_32_1 or var_32_1 * (utf8.len(var_32_3) / 28)) > 0 and var_32_1 < var_32_5 then
					arg_29_1.talkMaxDuration = var_32_5

					if var_32_5 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701007", "story_v_side_new_1102701.awb") ~= 0 then
					local var_32_6 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701007", "story_v_side_new_1102701.awb") / 1000

					if var_32_6 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_0
					end

					if var_32_2.prefab_name ~= "" and arg_29_1.actors_[var_32_2.prefab_name] ~= nil then
						local var_32_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_2.prefab_name].transform, "story_v_side_new_1102701", "1102701007", "story_v_side_new_1102701.awb")

						arg_29_1:RecordAudio("1102701007", var_32_7)
						arg_29_1:RecordAudio("1102701007", var_32_7)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701007", "story_v_side_new_1102701.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701007", "story_v_side_new_1102701.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_8 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_8 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_8

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_8 and arg_29_1.time_ < var_32_0 + var_32_8 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play1102701008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1102701008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1102701009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1027ui_story = arg_33_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1027ui_story"].transform.position).z)
				arg_33_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1027ui_story"].transform.localEulerAngles = arg_33_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1027ui_story"].transform.position).z)
				arg_33_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1027ui_story"].transform.localEulerAngles = arg_33_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["1027ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1027ui_story == nil then
				arg_33_1.var_.characterEffect1027ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect1027ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_2)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1027ui_story then
				arg_33_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_36_3 = 0
			local var_36_4 = 1.125

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_3 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_5 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(1102701008).content)

				arg_33_1.text_.text = var_36_5

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_7 = 45 <= 0 and var_36_4 or var_36_4 * (utf8.len(var_36_5) / 45)

				if (45 <= 0 and var_36_4 or var_36_4 * (utf8.len(var_36_5) / 45)) > 0 and var_36_4 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_3 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_3
					end
				end

				arg_33_1.text_.text = var_36_5
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_8 = math.max(var_36_4, arg_33_1.talkMaxDuration)

			if var_36_3 <= arg_33_1.time_ and arg_33_1.time_ < var_36_3 + var_36_8 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_3) / var_36_8

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_3 + var_36_8 and arg_33_1.time_ < var_36_3 + var_36_8 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
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
	Play1102701009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1102701009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1102701010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.35

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_1 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(1102701009).content)

				arg_37_1.text_.text = var_40_1

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_3 = 14 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 14)

				if (14 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 14)) > 0 and var_40_0 < var_40_3 then
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
	Play1102701010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1102701010
		arg_41_1.duration_ = 12.43

		local var_41_0 = {
			ja = 12.433,
			ko = 9.5,
			zh = 9.5
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
				arg_41_0:Play1102701011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1027ui_story = arg_41_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1027ui_story"].transform.position).z)
				arg_41_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1027ui_story"].transform.localEulerAngles = arg_41_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, -0.81, -5.8)
				arg_41_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1027ui_story"].transform.position).z)
				arg_41_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1027ui_story"].transform.localEulerAngles = arg_41_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["1027ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1027ui_story == nil then
				arg_41_1.var_.characterEffect1027ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect1027ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1027ui_story then
				arg_41_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_44_4 = 0
			local var_44_5 = 0.7

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_6 = arg_41_1:GetWordFromCfg(1102701010)
				local var_44_7 = arg_41_1:FormatText(var_44_6.content)

				arg_41_1.text_.text = var_44_7

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_9 = 28 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 28)

				if (28 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 28)) > 0 and var_44_5 < var_44_9 then
					arg_41_1.talkMaxDuration = var_44_9

					if var_44_9 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_4
					end
				end

				arg_41_1.text_.text = var_44_7
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701010", "story_v_side_new_1102701.awb") ~= 0 then
					local var_44_10 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701010", "story_v_side_new_1102701.awb") / 1000

					if var_44_10 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_4
					end

					if var_44_6.prefab_name ~= "" and arg_41_1.actors_[var_44_6.prefab_name] ~= nil then
						local var_44_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_6.prefab_name].transform, "story_v_side_new_1102701", "1102701010", "story_v_side_new_1102701.awb")

						arg_41_1:RecordAudio("1102701010", var_44_11)
						arg_41_1:RecordAudio("1102701010", var_44_11)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701010", "story_v_side_new_1102701.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701010", "story_v_side_new_1102701.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_12 = math.max(var_44_5, arg_41_1.talkMaxDuration)

			if var_44_4 <= arg_41_1.time_ and arg_41_1.time_ < var_44_4 + var_44_12 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_4) / var_44_12

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_4 + var_44_12 and arg_41_1.time_ < var_44_4 + var_44_12 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play1102701011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1102701011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1102701012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1027ui_story"]) and arg_45_1.var_.characterEffect1027ui_story == nil then
				arg_45_1.var_.characterEffect1027ui_story = arg_45_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1027ui_story"]) then
				if arg_45_1.var_.characterEffect1027ui_story and not isNil(arg_45_1.actors_["1027ui_story"]) then
					arg_45_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1027ui_story"]) and arg_45_1.var_.characterEffect1027ui_story then
				arg_45_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_48_1 = 0
			local var_48_2 = 0.2

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
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

				local var_48_3 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(1102701011).content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 8 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 8)

				if (8 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 8)) > 0 and var_48_2 < var_48_5 then
					arg_45_1.talkMaxDuration = var_48_5

					if var_48_5 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + var_48_1
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_6 = math.max(var_48_2, arg_45_1.talkMaxDuration)

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_6 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_1) / var_48_6

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_1 + var_48_6 and arg_45_1.time_ < var_48_1 + var_48_6 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play1102701012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1102701012
		arg_49_1.duration_ = 2.17

		local var_49_0 = {
			ja = 0.999999999999,
			ko = 2.166,
			zh = 2.166
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
				arg_49_0:Play1102701013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:AudioAction("play", "effect", "se_story_side_1027", "se_story_side_1027_dog1", "")
			end

			local var_52_1 = 0
			local var_52_2 = 0.125

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080_1")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:GetWordFromCfg(1102701012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_6 = 4 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_4) / 4)

				if (4 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_4) / 4)) > 0 and var_52_2 < var_52_6 then
					arg_49_1.talkMaxDuration = var_52_6

					if var_52_6 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_6 + var_52_1
					end
				end

				arg_49_1.text_.text = var_52_4
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701012", "story_v_side_new_1102701.awb") ~= 0 then
					local var_52_7 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701012", "story_v_side_new_1102701.awb") / 1000

					if var_52_7 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_1
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_side_new_1102701", "1102701012", "story_v_side_new_1102701.awb")

						arg_49_1:RecordAudio("1102701012", var_52_8)
						arg_49_1:RecordAudio("1102701012", var_52_8)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701012", "story_v_side_new_1102701.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701012", "story_v_side_new_1102701.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_9 = math.max(var_52_2, arg_49_1.talkMaxDuration)

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_9 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_1) / var_52_9

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_1 + var_52_9 and arg_49_1.time_ < var_52_1 + var_52_9 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play1102701013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1102701013
		arg_53_1.duration_ = 10.23

		local var_53_0 = {
			ja = 10.233,
			ko = 7.266,
			zh = 7.266
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
				arg_53_0:Play1102701014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1027ui_story"]) and arg_53_1.var_.characterEffect1027ui_story == nil then
				arg_53_1.var_.characterEffect1027ui_story = arg_53_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1027ui_story"]) then
				if arg_53_1.var_.characterEffect1027ui_story and not isNil(arg_53_1.actors_["1027ui_story"]) then
					arg_53_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1027ui_story"]) and arg_53_1.var_.characterEffect1027ui_story then
				arg_53_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action4_1")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_56_2 = 0
			local var_56_3 = 0.925

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_4 = arg_53_1:GetWordFromCfg(1102701013)
				local var_56_5 = arg_53_1:FormatText(var_56_4.content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_7 = 37 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 37)

				if (37 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 37)) > 0 and var_56_3 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_2
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701013", "story_v_side_new_1102701.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701013", "story_v_side_new_1102701.awb") / 1000

					if var_56_8 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_2
					end

					if var_56_4.prefab_name ~= "" and arg_53_1.actors_[var_56_4.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_4.prefab_name].transform, "story_v_side_new_1102701", "1102701013", "story_v_side_new_1102701.awb")

						arg_53_1:RecordAudio("1102701013", var_56_9)
						arg_53_1:RecordAudio("1102701013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701013", "story_v_side_new_1102701.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701013", "story_v_side_new_1102701.awb")
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
	Play1102701014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1102701014
		arg_57_1.duration_ = 1.93

		local var_57_0 = {
			ja = 1.933,
			ko = 1.9,
			zh = 1.9
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
				arg_57_0:Play1102701015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1027ui_story"]) and arg_57_1.var_.characterEffect1027ui_story == nil then
				arg_57_1.var_.characterEffect1027ui_story = arg_57_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1027ui_story"]) then
				if arg_57_1.var_.characterEffect1027ui_story and not isNil(arg_57_1.actors_["1027ui_story"]) then
					arg_57_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_0)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1027ui_story"]) and arg_57_1.var_.characterEffect1027ui_story then
				arg_57_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:AudioAction("play", "effect", "se_story_15", "se_story_15_dog7", "")
			end

			local var_60_2 = 0
			local var_60_3 = 0.125

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080_1")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_4 = arg_57_1:GetWordFromCfg(1102701014)
				local var_60_5 = arg_57_1:FormatText(var_60_4.content)

				arg_57_1.text_.text = var_60_5

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_7 = 5 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 5)

				if (5 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 5)) > 0 and var_60_3 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_2
					end
				end

				arg_57_1.text_.text = var_60_5
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701014", "story_v_side_new_1102701.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701014", "story_v_side_new_1102701.awb") / 1000

					if var_60_8 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_2
					end

					if var_60_4.prefab_name ~= "" and arg_57_1.actors_[var_60_4.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_4.prefab_name].transform, "story_v_side_new_1102701", "1102701014", "story_v_side_new_1102701.awb")

						arg_57_1:RecordAudio("1102701014", var_60_9)
						arg_57_1:RecordAudio("1102701014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701014", "story_v_side_new_1102701.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701014", "story_v_side_new_1102701.awb")
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
	Play1102701015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1102701015
		arg_61_1.duration_ = 11

		local var_61_0 = {
			ja = 7.466,
			ko = 11,
			zh = 11
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
				arg_61_0:Play1102701016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1027ui_story"]) and arg_61_1.var_.characterEffect1027ui_story == nil then
				arg_61_1.var_.characterEffect1027ui_story = arg_61_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1027ui_story"]) then
				if arg_61_1.var_.characterEffect1027ui_story and not isNil(arg_61_1.actors_["1027ui_story"]) then
					arg_61_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1027ui_story"]) and arg_61_1.var_.characterEffect1027ui_story then
				arg_61_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_64_2 = 0
			local var_64_3 = 0.95

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_4 = arg_61_1:GetWordFromCfg(1102701015)
				local var_64_5 = arg_61_1:FormatText(var_64_4.content)

				arg_61_1.text_.text = var_64_5

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_7 = 38 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_5) / 38)

				if (38 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_5) / 38)) > 0 and var_64_3 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_2
					end
				end

				arg_61_1.text_.text = var_64_5
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701015", "story_v_side_new_1102701.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701015", "story_v_side_new_1102701.awb") / 1000

					if var_64_8 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_2
					end

					if var_64_4.prefab_name ~= "" and arg_61_1.actors_[var_64_4.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_4.prefab_name].transform, "story_v_side_new_1102701", "1102701015", "story_v_side_new_1102701.awb")

						arg_61_1:RecordAudio("1102701015", var_64_9)
						arg_61_1:RecordAudio("1102701015", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701015", "story_v_side_new_1102701.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701015", "story_v_side_new_1102701.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_10 = math.max(var_64_3, arg_61_1.talkMaxDuration)

			if var_64_2 <= arg_61_1.time_ and arg_61_1.time_ < var_64_2 + var_64_10 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_2) / var_64_10

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_2 + var_64_10 and arg_61_1.time_ < var_64_2 + var_64_10 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play1102701016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1102701016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1102701017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1027ui_story = arg_65_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1027ui_story"].transform.position).z)
				arg_65_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1027ui_story"].transform.localEulerAngles = arg_65_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_65_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1027ui_story"].transform.position).z)
				arg_65_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1027ui_story"].transform.localEulerAngles = arg_65_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["1027ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1027ui_story == nil then
				arg_65_1.var_.characterEffect1027ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect1027ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_2)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1027ui_story then
				arg_65_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_68_3 = 0
			local var_68_4 = 1.225

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_3 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_5 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(1102701016).content)

				arg_65_1.text_.text = var_68_5

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_7 = 49 <= 0 and var_68_4 or var_68_4 * (utf8.len(var_68_5) / 49)

				if (49 <= 0 and var_68_4 or var_68_4 * (utf8.len(var_68_5) / 49)) > 0 and var_68_4 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_3 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_3
					end
				end

				arg_65_1.text_.text = var_68_5
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_8 = math.max(var_68_4, arg_65_1.talkMaxDuration)

			if var_68_3 <= arg_65_1.time_ and arg_65_1.time_ < var_68_3 + var_68_8 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_3) / var_68_8

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_3 + var_68_8 and arg_65_1.time_ < var_68_3 + var_68_8 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
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
	Play1102701017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1102701017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play1102701018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 1.15

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_1 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(1102701017).content)

				arg_69_1.text_.text = var_72_1

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_3 = 46 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 46)

				if (46 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 46)) > 0 and var_72_0 < var_72_3 then
					arg_69_1.talkMaxDuration = var_72_3

					if var_72_3 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_3 + 0
					end
				end

				arg_69_1.text_.text = var_72_1
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_4 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_4

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play1102701018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1102701018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1102701019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.625

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
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

				local var_76_1 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(1102701018).content)

				arg_73_1.text_.text = var_76_1

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_3 = 25 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 25)

				if (25 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 25)) > 0 and var_76_0 < var_76_3 then
					arg_73_1.talkMaxDuration = var_76_3

					if var_76_3 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_3 + 0
					end
				end

				arg_73_1.text_.text = var_76_1
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_4 = math.max(var_76_0, arg_73_1.talkMaxDuration)

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - 0) / var_76_4

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play1102701019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1102701019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play1102701020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 1.025

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
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

				local var_80_1 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(1102701019).content)

				arg_77_1.text_.text = var_80_1

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_3 = 41 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 41)

				if (41 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 41)) > 0 and var_80_0 < var_80_3 then
					arg_77_1.talkMaxDuration = var_80_3

					if var_80_3 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_3 + 0
					end
				end

				arg_77_1.text_.text = var_80_1
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_4 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_4

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play1102701020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1102701020
		arg_81_1.duration_ = 15.3

		local var_81_0 = {
			ja = 11.366,
			ko = 15.3,
			zh = 15.3
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
				arg_81_0:Play1102701021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1027ui_story = arg_81_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1027ui_story"].transform.position).z)
				arg_81_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1027ui_story"].transform.localEulerAngles = arg_81_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, -0.81, -5.8)
				arg_81_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1027ui_story"].transform.position).z)
				arg_81_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1027ui_story"].transform.localEulerAngles = arg_81_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_84_1 = arg_81_1.actors_["1027ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1027ui_story == nil then
				arg_81_1.var_.characterEffect1027ui_story = var_84_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 and not isNil(var_84_1) then
				if arg_81_1.var_.characterEffect1027ui_story and not isNil(var_84_1) then
					arg_81_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1027ui_story then
				arg_81_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_84_4 = 0
			local var_84_5 = 1.2

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_6 = arg_81_1:GetWordFromCfg(1102701020)
				local var_84_7 = arg_81_1:FormatText(var_84_6.content)

				arg_81_1.text_.text = var_84_7

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 48 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 48)

				if (48 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 48)) > 0 and var_84_5 < var_84_9 then
					arg_81_1.talkMaxDuration = var_84_9

					if var_84_9 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_4
					end
				end

				arg_81_1.text_.text = var_84_7
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701020", "story_v_side_new_1102701.awb") ~= 0 then
					local var_84_10 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701020", "story_v_side_new_1102701.awb") / 1000

					if var_84_10 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_4
					end

					if var_84_6.prefab_name ~= "" and arg_81_1.actors_[var_84_6.prefab_name] ~= nil then
						local var_84_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_6.prefab_name].transform, "story_v_side_new_1102701", "1102701020", "story_v_side_new_1102701.awb")

						arg_81_1:RecordAudio("1102701020", var_84_11)
						arg_81_1:RecordAudio("1102701020", var_84_11)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701020", "story_v_side_new_1102701.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701020", "story_v_side_new_1102701.awb")
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

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
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
	Play1102701021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1102701021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play1102701022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1027ui_story = arg_85_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1027ui_story"].transform.position).z)
				arg_85_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1027ui_story"].transform.localEulerAngles = arg_85_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_85_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1027ui_story"].transform.position).z)
				arg_85_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1027ui_story"].transform.localEulerAngles = arg_85_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["1027ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1027ui_story == nil then
				arg_85_1.var_.characterEffect1027ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect1027ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_2)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1027ui_story then
				arg_85_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_88_3 = 0
			local var_88_4 = 0.775

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_3 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_5 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(1102701021).content)

				arg_85_1.text_.text = var_88_5

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_7 = 31 <= 0 and var_88_4 or var_88_4 * (utf8.len(var_88_5) / 31)

				if (31 <= 0 and var_88_4 or var_88_4 * (utf8.len(var_88_5) / 31)) > 0 and var_88_4 < var_88_7 then
					arg_85_1.talkMaxDuration = var_88_7

					if var_88_7 + var_88_3 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_3
					end
				end

				arg_85_1.text_.text = var_88_5
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_8 = math.max(var_88_4, arg_85_1.talkMaxDuration)

			if var_88_3 <= arg_85_1.time_ and arg_85_1.time_ < var_88_3 + var_88_8 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_3) / var_88_8

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_3 + var_88_8 and arg_85_1.time_ < var_88_3 + var_88_8 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play1102701022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1102701022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play1102701023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.8

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_1 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(1102701022).content)

				arg_89_1.text_.text = var_92_1

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_3 = 32 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 32)

				if (32 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 32)) > 0 and var_92_0 < var_92_3 then
					arg_89_1.talkMaxDuration = var_92_3

					if var_92_3 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_3 + 0
					end
				end

				arg_89_1.text_.text = var_92_1
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_4 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_4

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play1102701023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1102701023
		arg_93_1.duration_ = 2.3

		local var_93_0 = {
			ja = 1.3,
			ko = 2.3,
			zh = 2.3
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
				arg_93_0:Play1102701024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:AudioAction("play", "effect", "se_story_15", "se_story_15_dog9", "")
			end

			local var_96_1 = 0
			local var_96_2 = 0.125

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080_1")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_3 = arg_93_1:GetWordFromCfg(1102701023)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_6 = 5 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_4) / 5)

				if (5 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_4) / 5)) > 0 and var_96_2 < var_96_6 then
					arg_93_1.talkMaxDuration = var_96_6

					if var_96_6 + var_96_1 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_6 + var_96_1
					end
				end

				arg_93_1.text_.text = var_96_4
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701023", "story_v_side_new_1102701.awb") ~= 0 then
					local var_96_7 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701023", "story_v_side_new_1102701.awb") / 1000

					if var_96_7 + var_96_1 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_1
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_side_new_1102701", "1102701023", "story_v_side_new_1102701.awb")

						arg_93_1:RecordAudio("1102701023", var_96_8)
						arg_93_1:RecordAudio("1102701023", var_96_8)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701023", "story_v_side_new_1102701.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701023", "story_v_side_new_1102701.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_9 = math.max(var_96_2, arg_93_1.talkMaxDuration)

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_9 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_1) / var_96_9

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_1 + var_96_9 and arg_93_1.time_ < var_96_1 + var_96_9 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play1102701024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1102701024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play1102701025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 1.325

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_1 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(1102701024).content)

				arg_97_1.text_.text = var_100_1

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_3 = 53 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 53)

				if (53 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 53)) > 0 and var_100_0 < var_100_3 then
					arg_97_1.talkMaxDuration = var_100_3

					if var_100_3 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_3 + 0
					end
				end

				arg_97_1.text_.text = var_100_1
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_4 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_4

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play1102701025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1102701025
		arg_101_1.duration_ = 4.1

		local var_101_0 = {
			ja = 4.1,
			ko = 3,
			zh = 3
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
				arg_101_0:Play1102701026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1027ui_story = arg_101_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1027ui_story"].transform.position).z)
				arg_101_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1027ui_story"].transform.localEulerAngles = arg_101_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, -0.81, -5.8)
				arg_101_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1027ui_story"].transform.position).z)
				arg_101_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1027ui_story"].transform.localEulerAngles = arg_101_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["1027ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1027ui_story == nil then
				arg_101_1.var_.characterEffect1027ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect1027ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1027ui_story then
				arg_101_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_2")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_104_4 = 0
			local var_104_5 = 0.3

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_6 = arg_101_1:GetWordFromCfg(1102701025)
				local var_104_7 = arg_101_1:FormatText(var_104_6.content)

				arg_101_1.text_.text = var_104_7

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_9 = 12 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 12)

				if (12 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 12)) > 0 and var_104_5 < var_104_9 then
					arg_101_1.talkMaxDuration = var_104_9

					if var_104_9 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_9 + var_104_4
					end
				end

				arg_101_1.text_.text = var_104_7
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701025", "story_v_side_new_1102701.awb") ~= 0 then
					local var_104_10 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701025", "story_v_side_new_1102701.awb") / 1000

					if var_104_10 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_10 + var_104_4
					end

					if var_104_6.prefab_name ~= "" and arg_101_1.actors_[var_104_6.prefab_name] ~= nil then
						local var_104_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_6.prefab_name].transform, "story_v_side_new_1102701", "1102701025", "story_v_side_new_1102701.awb")

						arg_101_1:RecordAudio("1102701025", var_104_11)
						arg_101_1:RecordAudio("1102701025", var_104_11)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701025", "story_v_side_new_1102701.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701025", "story_v_side_new_1102701.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_12 = math.max(var_104_5, arg_101_1.talkMaxDuration)

			if var_104_4 <= arg_101_1.time_ and arg_101_1.time_ < var_104_4 + var_104_12 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_4) / var_104_12

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_4 + var_104_12 and arg_101_1.time_ < var_104_4 + var_104_12 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play1102701026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1102701026
		arg_105_1.duration_ = 7.67

		local var_105_0 = {
			ja = 7.666,
			ko = 6.2,
			zh = 6.2
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
				arg_105_0:Play1102701027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.8

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_1 = arg_105_1:GetWordFromCfg(1102701026)
				local var_108_2 = arg_105_1:FormatText(var_108_1.content)

				arg_105_1.text_.text = var_108_2

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 32 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 32)

				if (32 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 32)) > 0 and var_108_0 < var_108_4 then
					arg_105_1.talkMaxDuration = var_108_4

					if var_108_4 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_4 + 0
					end
				end

				arg_105_1.text_.text = var_108_2
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701026", "story_v_side_new_1102701.awb") ~= 0 then
					local var_108_5 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701026", "story_v_side_new_1102701.awb") / 1000

					if var_108_5 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + 0
					end

					if var_108_1.prefab_name ~= "" and arg_105_1.actors_[var_108_1.prefab_name] ~= nil then
						local var_108_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_1.prefab_name].transform, "story_v_side_new_1102701", "1102701026", "story_v_side_new_1102701.awb")

						arg_105_1:RecordAudio("1102701026", var_108_6)
						arg_105_1:RecordAudio("1102701026", var_108_6)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701026", "story_v_side_new_1102701.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701026", "story_v_side_new_1102701.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_7 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_7 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_7

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_7 and arg_105_1.time_ < 0 + var_108_7 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play1102701027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1102701027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play1102701028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["1027ui_story"]) and arg_109_1.var_.characterEffect1027ui_story == nil then
				arg_109_1.var_.characterEffect1027ui_story = arg_109_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["1027ui_story"]) then
				if arg_109_1.var_.characterEffect1027ui_story and not isNil(arg_109_1.actors_["1027ui_story"]) then
					arg_109_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_0)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["1027ui_story"]) and arg_109_1.var_.characterEffect1027ui_story then
				arg_109_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_112_1 = 0
			local var_112_2 = 0.6

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

				local var_112_3 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(1102701027).content)

				arg_109_1.text_.text = var_112_3

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 24 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 24)

				if (24 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 24)) > 0 and var_112_2 < var_112_5 then
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
	Play1102701028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1102701028
		arg_113_1.duration_ = 3.8

		local var_113_0 = {
			ja = 3.8,
			ko = 2.766,
			zh = 2.766
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
				arg_113_0:Play1102701029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1027ui_story"]) and arg_113_1.var_.characterEffect1027ui_story == nil then
				arg_113_1.var_.characterEffect1027ui_story = arg_113_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["1027ui_story"]) then
				if arg_113_1.var_.characterEffect1027ui_story and not isNil(arg_113_1.actors_["1027ui_story"]) then
					arg_113_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["1027ui_story"]) and arg_113_1.var_.characterEffect1027ui_story then
				arg_113_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_116_2 = 0
			local var_116_3 = 0.25

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_2 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_4 = arg_113_1:GetWordFromCfg(1102701028)
				local var_116_5 = arg_113_1:FormatText(var_116_4.content)

				arg_113_1.text_.text = var_116_5

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_7 = 10 <= 0 and var_116_3 or var_116_3 * (utf8.len(var_116_5) / 10)

				if (10 <= 0 and var_116_3 or var_116_3 * (utf8.len(var_116_5) / 10)) > 0 and var_116_3 < var_116_7 then
					arg_113_1.talkMaxDuration = var_116_7

					if var_116_7 + var_116_2 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_2
					end
				end

				arg_113_1.text_.text = var_116_5
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701028", "story_v_side_new_1102701.awb") ~= 0 then
					local var_116_8 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701028", "story_v_side_new_1102701.awb") / 1000

					if var_116_8 + var_116_2 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_8 + var_116_2
					end

					if var_116_4.prefab_name ~= "" and arg_113_1.actors_[var_116_4.prefab_name] ~= nil then
						local var_116_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_4.prefab_name].transform, "story_v_side_new_1102701", "1102701028", "story_v_side_new_1102701.awb")

						arg_113_1:RecordAudio("1102701028", var_116_9)
						arg_113_1:RecordAudio("1102701028", var_116_9)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701028", "story_v_side_new_1102701.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701028", "story_v_side_new_1102701.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_10 = math.max(var_116_3, arg_113_1.talkMaxDuration)

			if var_116_2 <= arg_113_1.time_ and arg_113_1.time_ < var_116_2 + var_116_10 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_2) / var_116_10

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_2 + var_116_10 and arg_113_1.time_ < var_116_2 + var_116_10 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play1102701029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 1102701029
		arg_117_1.duration_ = 11.47

		local var_117_0 = {
			ja = 11.466,
			ko = 9.433,
			zh = 9.433
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
				arg_117_0:Play1102701030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 3.8 < arg_117_1.time_ and arg_117_1.time_ <= 3.8 + arg_120_0 then
				arg_117_1.var_.moveOldPos1027ui_story = arg_117_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 3.8 <= arg_117_1.time_ and arg_117_1.time_ < 3.8 + var_120_0 then
				arg_117_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_117_1.time_ - 3.8) / var_120_0)
				arg_117_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1027ui_story"].transform.position).z)
				arg_117_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1027ui_story"].transform.localEulerAngles = arg_117_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 3.8 + var_120_0 and arg_117_1.time_ < 3.8 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, -0.81, -5.8)
				arg_117_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1027ui_story"].transform.position).z)
				arg_117_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1027ui_story"].transform.localEulerAngles = arg_117_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_120_1 = arg_117_1.actors_["1027ui_story"]

			if 3.8 < arg_117_1.time_ and arg_117_1.time_ <= 3.8 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1027ui_story == nil then
				arg_117_1.var_.characterEffect1027ui_story = var_120_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if 3.8 <= arg_117_1.time_ and arg_117_1.time_ < 3.8 + var_120_2 and not isNil(var_120_1) then
				if arg_117_1.var_.characterEffect1027ui_story and not isNil(var_120_1) then
					arg_117_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 3.8 + var_120_2 and arg_117_1.time_ < 3.8 + var_120_2 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1027ui_story then
				arg_117_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 3.8 < arg_117_1.time_ and arg_117_1.time_ <= 3.8 + arg_120_0 then
				arg_117_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action6_1")
			end

			if 3.8 < arg_117_1.time_ and arg_117_1.time_ <= 3.8 + arg_120_0 then
				arg_117_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_120_4 = arg_117_1.actors_["1027ui_story"].transform

			if 1.96599999815226 < arg_117_1.time_ and arg_117_1.time_ <= 1.96599999815226 + arg_120_0 then
				arg_117_1.var_.moveOldPos1027ui_story = var_120_4.localPosition
			end

			local var_120_5 = 0.001

			if 1.96599999815226 <= arg_117_1.time_ and arg_117_1.time_ < 1.96599999815226 + var_120_5 then
				var_120_4.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_117_1.time_ - 1.96599999815226) / var_120_5)
				var_120_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_4.position).x, (manager.ui.mainCamera.transform.position - var_120_4.position).y, (manager.ui.mainCamera.transform.position - var_120_4.position).z)
				var_120_4.localEulerAngles.z = 0
				var_120_4.localEulerAngles.x = 0
				var_120_4.localEulerAngles = var_120_4.localEulerAngles
			end

			if arg_117_1.time_ >= 1.96599999815226 + var_120_5 and arg_117_1.time_ < 1.96599999815226 + var_120_5 + arg_120_0 then
				var_120_4.localPosition = Vector3.New(0, 100, 0)
				var_120_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_4.position).x, (manager.ui.mainCamera.transform.position - var_120_4.position).y, (manager.ui.mainCamera.transform.position - var_120_4.position).z)
				var_120_4.localEulerAngles.z = 0
				var_120_4.localEulerAngles.x = 0
				var_120_4.localEulerAngles = var_120_4.localEulerAngles
			end

			local var_120_6 = 0

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_6 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_7 = 2

			if var_120_6 <= arg_117_1.time_ and arg_117_1.time_ < var_120_6 + var_120_7 then
				local var_120_8 = Color.New(0, 0, 0)

				var_120_8.a = Mathf.Lerp(0, 1, (arg_117_1.time_ - var_120_6) / var_120_7)
				arg_117_1.mask_.color = var_120_8
			end

			if arg_117_1.time_ >= var_120_6 + var_120_7 and arg_117_1.time_ < var_120_6 + var_120_7 + arg_120_0 then
				local var_120_9 = Color.New(0, 0, 0)

				var_120_9.a = 1
				arg_117_1.mask_.color = var_120_9
			end

			local var_120_10 = 2

			if 2 < arg_117_1.time_ and arg_117_1.time_ <= var_120_10 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_11 = 2

			if var_120_10 <= arg_117_1.time_ and arg_117_1.time_ < var_120_10 + var_120_11 then
				local var_120_12 = Color.New(0, 0, 0)

				var_120_12.a = Mathf.Lerp(1, 0, (arg_117_1.time_ - var_120_10) / var_120_11)
				arg_117_1.mask_.color = var_120_12
			end

			if arg_117_1.time_ >= var_120_10 + var_120_11 and arg_117_1.time_ < var_120_10 + var_120_11 + arg_120_0 then
				local var_120_13 = Color.New(0, 0, 0)

				arg_117_1.mask_.enabled = false
				var_120_13.a = 0
				arg_117_1.mask_.color = var_120_13
			end

			local var_120_14 = "ST04b"

			if arg_117_1.bgs_.ST04b == nil then
				local var_120_15 = Object.Instantiate(arg_117_1.paintGo_)

				var_120_15:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_120_14)
				var_120_15.name = var_120_14
				var_120_15.transform.parent = arg_117_1.stage_.transform
				var_120_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_117_1.bgs_[var_120_14] = var_120_15
			end

			if 2 < arg_117_1.time_ and arg_117_1.time_ <= 2 + arg_120_0 then
				local var_120_16 = arg_117_1.bgs_.ST04b

				arg_117_1.bgs_.ST04b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_120_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_120_17 = var_120_16:GetComponent("SpriteRenderer")

				if var_120_17 and var_120_17.sprite then
					local var_120_18 = 2 * (var_120_16.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_120_16.transform.localScale = Vector3.New(var_120_18 / var_120_17.sprite.bounds.size.y < var_120_18 * manager.ui.mainCameraCom_.aspect / var_120_17.sprite.bounds.size.x and var_120_18 * manager.ui.mainCameraCom_.aspect / var_120_17.sprite.bounds.size.x or var_120_18 / var_120_17.sprite.bounds.size.y, var_120_18 / var_120_17.sprite.bounds.size.y < var_120_18 * manager.ui.mainCameraCom_.aspect / var_120_17.sprite.bounds.size.x and var_120_18 * manager.ui.mainCameraCom_.aspect / var_120_17.sprite.bounds.size.x or var_120_18 / var_120_17.sprite.bounds.size.y, 0)
				end

				for iter_120_0, iter_120_1 in pairs(arg_117_1.bgs_) do
					if iter_120_0 ~= "ST04b" then
						iter_120_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:AudioAction("play", "effect", "se_story_side_1080", "se_story_1080_parkloop", "")
			end

			if arg_117_1.frameCnt_ <= 1 then
				arg_117_1.dialog_:SetActive(false)
			end

			local var_120_20 = 4
			local var_120_21 = 0.675

			if 4 < arg_117_1.time_ and arg_117_1.time_ <= var_120_20 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0

				arg_117_1.dialog_:SetActive(true)

				arg_117_1.dialogCg_.alpha = 0

				local var_120_22 = LeanTween.value(arg_117_1.dialog_, 0, 1, 0.3)

				var_120_22:setOnUpdate(LuaHelper.FloatAction(function(arg_121_0)
					arg_117_1.dialogCg_.alpha = arg_121_0
				end))
				var_120_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_117_1.dialog_)
					var_120_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_117_1.duration_ = arg_117_1.duration_ + 0.3

				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_23 = arg_117_1:GetWordFromCfg(1102701029)
				local var_120_24 = arg_117_1:FormatText(var_120_23.content)

				arg_117_1.text_.text = var_120_24

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_26 = 27 <= 0 and var_120_21 or var_120_21 * (utf8.len(var_120_24) / 27)

				if (27 <= 0 and var_120_21 or var_120_21 * (utf8.len(var_120_24) / 27)) > 0 and var_120_21 < var_120_26 then
					arg_117_1.talkMaxDuration = var_120_26
					var_120_20 = var_120_20 + 0.3

					if var_120_26 + var_120_20 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_26 + var_120_20
					end
				end

				arg_117_1.text_.text = var_120_24
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701029", "story_v_side_new_1102701.awb") ~= 0 then
					local var_120_27 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701029", "story_v_side_new_1102701.awb") / 1000

					if var_120_27 + var_120_20 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_27 + var_120_20
					end

					if var_120_23.prefab_name ~= "" and arg_117_1.actors_[var_120_23.prefab_name] ~= nil then
						local var_120_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_23.prefab_name].transform, "story_v_side_new_1102701", "1102701029", "story_v_side_new_1102701.awb")

						arg_117_1:RecordAudio("1102701029", var_120_28)
						arg_117_1:RecordAudio("1102701029", var_120_28)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701029", "story_v_side_new_1102701.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701029", "story_v_side_new_1102701.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_29 = var_120_20 + 0.3
			local var_120_30 = math.max(var_120_21, arg_117_1.talkMaxDuration)

			if var_120_20 + 0.3 <= arg_117_1.time_ and arg_117_1.time_ < var_120_29 + var_120_30 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_29) / var_120_30

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_29 + var_120_30 and arg_117_1.time_ < var_120_29 + var_120_30 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play1102701030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 1102701030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play1102701031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["1027ui_story"]) and arg_123_1.var_.characterEffect1027ui_story == nil then
				arg_123_1.var_.characterEffect1027ui_story = arg_123_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_0 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["1027ui_story"]) then
				if arg_123_1.var_.characterEffect1027ui_story and not isNil(arg_123_1.actors_["1027ui_story"]) then
					arg_123_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_0)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["1027ui_story"]) and arg_123_1.var_.characterEffect1027ui_story then
				arg_123_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_126_1 = 0
			local var_126_2 = 0.825

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_3 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(1102701030).content)

				arg_123_1.text_.text = var_126_3

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 33 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_3) / 33)

				if (33 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_3) / 33)) > 0 and var_126_2 < var_126_5 then
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

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play1102701031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 1102701031
		arg_127_1.duration_ = 12.93

		local var_127_0 = {
			ja = 10.166,
			ko = 12.933,
			zh = 12.933
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
				arg_127_0:Play1102701032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos1027ui_story = arg_127_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_130_0 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 then
				arg_127_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_127_1.time_ - 0) / var_130_0)
				arg_127_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1027ui_story"].transform.position).z)
				arg_127_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1027ui_story"].transform.localEulerAngles = arg_127_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 then
				arg_127_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, -0.81, -5.8)
				arg_127_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1027ui_story"].transform.position).z)
				arg_127_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1027ui_story"].transform.localEulerAngles = arg_127_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_130_1 = arg_127_1.actors_["1027ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1027ui_story == nil then
				arg_127_1.var_.characterEffect1027ui_story = var_130_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_2 and not isNil(var_130_1) then
				if arg_127_1.var_.characterEffect1027ui_story and not isNil(var_130_1) then
					arg_127_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_2 and arg_127_1.time_ < 0 + var_130_2 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1027ui_story then
				arg_127_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action464")
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_130_4 = 0
			local var_130_5 = 1.425

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_4 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_6 = arg_127_1:GetWordFromCfg(1102701031)
				local var_130_7 = arg_127_1:FormatText(var_130_6.content)

				arg_127_1.text_.text = var_130_7

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_9 = 57 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 57)

				if (57 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 57)) > 0 and var_130_5 < var_130_9 then
					arg_127_1.talkMaxDuration = var_130_9

					if var_130_9 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_9 + var_130_4
					end
				end

				arg_127_1.text_.text = var_130_7
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701031", "story_v_side_new_1102701.awb") ~= 0 then
					local var_130_10 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701031", "story_v_side_new_1102701.awb") / 1000

					if var_130_10 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_4
					end

					if var_130_6.prefab_name ~= "" and arg_127_1.actors_[var_130_6.prefab_name] ~= nil then
						local var_130_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_6.prefab_name].transform, "story_v_side_new_1102701", "1102701031", "story_v_side_new_1102701.awb")

						arg_127_1:RecordAudio("1102701031", var_130_11)
						arg_127_1:RecordAudio("1102701031", var_130_11)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701031", "story_v_side_new_1102701.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701031", "story_v_side_new_1102701.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_12 = math.max(var_130_5, arg_127_1.talkMaxDuration)

			if var_130_4 <= arg_127_1.time_ and arg_127_1.time_ < var_130_4 + var_130_12 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_4) / var_130_12

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_4 + var_130_12 and arg_127_1.time_ < var_130_4 + var_130_12 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play1102701032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 1102701032
		arg_131_1.duration_ = 6.83

		local var_131_0 = {
			ja = 6.133,
			ko = 6.833,
			zh = 6.833
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
				arg_131_0:Play1102701033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.9

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_1 = arg_131_1:GetWordFromCfg(1102701032)
				local var_134_2 = arg_131_1:FormatText(var_134_1.content)

				arg_131_1.text_.text = var_134_2

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_4 = 36 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 36)

				if (36 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 36)) > 0 and var_134_0 < var_134_4 then
					arg_131_1.talkMaxDuration = var_134_4

					if var_134_4 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_4 + 0
					end
				end

				arg_131_1.text_.text = var_134_2
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701032", "story_v_side_new_1102701.awb") ~= 0 then
					local var_134_5 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701032", "story_v_side_new_1102701.awb") / 1000

					if var_134_5 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_5 + 0
					end

					if var_134_1.prefab_name ~= "" and arg_131_1.actors_[var_134_1.prefab_name] ~= nil then
						local var_134_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_1.prefab_name].transform, "story_v_side_new_1102701", "1102701032", "story_v_side_new_1102701.awb")

						arg_131_1:RecordAudio("1102701032", var_134_6)
						arg_131_1:RecordAudio("1102701032", var_134_6)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701032", "story_v_side_new_1102701.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701032", "story_v_side_new_1102701.awb")
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
	Play1102701033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 1102701033
		arg_135_1.duration_ = 7.53

		local var_135_0 = {
			ja = 7.533,
			ko = 4.6,
			zh = 4.6
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
				arg_135_0:Play1102701034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_138_0 = 0
			local var_138_1 = 0.45

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_2 = arg_135_1:GetWordFromCfg(1102701033)
				local var_138_3 = arg_135_1:FormatText(var_138_2.content)

				arg_135_1.text_.text = var_138_3

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 18 <= 0 and var_138_1 or var_138_1 * (utf8.len(var_138_3) / 18)

				if (18 <= 0 and var_138_1 or var_138_1 * (utf8.len(var_138_3) / 18)) > 0 and var_138_1 < var_138_5 then
					arg_135_1.talkMaxDuration = var_138_5

					if var_138_5 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_5 + var_138_0
					end
				end

				arg_135_1.text_.text = var_138_3
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701033", "story_v_side_new_1102701.awb") ~= 0 then
					local var_138_6 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701033", "story_v_side_new_1102701.awb") / 1000

					if var_138_6 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_6 + var_138_0
					end

					if var_138_2.prefab_name ~= "" and arg_135_1.actors_[var_138_2.prefab_name] ~= nil then
						local var_138_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_2.prefab_name].transform, "story_v_side_new_1102701", "1102701033", "story_v_side_new_1102701.awb")

						arg_135_1:RecordAudio("1102701033", var_138_7)
						arg_135_1:RecordAudio("1102701033", var_138_7)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701033", "story_v_side_new_1102701.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701033", "story_v_side_new_1102701.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_8 = math.max(var_138_1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_8 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_0) / var_138_8

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_8 and arg_135_1.time_ < var_138_0 + var_138_8 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play1102701034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 1102701034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play1102701035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["1027ui_story"]) and arg_139_1.var_.characterEffect1027ui_story == nil then
				arg_139_1.var_.characterEffect1027ui_story = arg_139_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_0 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["1027ui_story"]) then
				if arg_139_1.var_.characterEffect1027ui_story and not isNil(arg_139_1.actors_["1027ui_story"]) then
					arg_139_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_0)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["1027ui_story"]) and arg_139_1.var_.characterEffect1027ui_story then
				arg_139_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_142_1 = arg_139_1.actors_["1027ui_story"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1027ui_story = var_142_1.localPosition
			end

			local var_142_2 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_2 then
				var_142_1.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_139_1.time_ - 0) / var_142_2)
				var_142_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_1.position).x, (manager.ui.mainCamera.transform.position - var_142_1.position).y, (manager.ui.mainCamera.transform.position - var_142_1.position).z)
				var_142_1.localEulerAngles.z = 0
				var_142_1.localEulerAngles.x = 0
				var_142_1.localEulerAngles = var_142_1.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_2 and arg_139_1.time_ < 0 + var_142_2 + arg_142_0 then
				var_142_1.localPosition = Vector3.New(0, 100, 0)
				var_142_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_1.position).x, (manager.ui.mainCamera.transform.position - var_142_1.position).y, (manager.ui.mainCamera.transform.position - var_142_1.position).z)
				var_142_1.localEulerAngles.z = 0
				var_142_1.localEulerAngles.x = 0
				var_142_1.localEulerAngles = var_142_1.localEulerAngles
			end

			local var_142_3 = 0
			local var_142_4 = 1.2

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_3 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_5 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(1102701034).content)

				arg_139_1.text_.text = var_142_5

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_7 = 48 <= 0 and var_142_4 or var_142_4 * (utf8.len(var_142_5) / 48)

				if (48 <= 0 and var_142_4 or var_142_4 * (utf8.len(var_142_5) / 48)) > 0 and var_142_4 < var_142_7 then
					arg_139_1.talkMaxDuration = var_142_7

					if var_142_7 + var_142_3 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_3
					end
				end

				arg_139_1.text_.text = var_142_5
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_8 = math.max(var_142_4, arg_139_1.talkMaxDuration)

			if var_142_3 <= arg_139_1.time_ and arg_139_1.time_ < var_142_3 + var_142_8 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_3) / var_142_8

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_3 + var_142_8 and arg_139_1.time_ < var_142_3 + var_142_8 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
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

		arg_139_1:InitPlayNodeList()
	end,
	Play1102701035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 1102701035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play1102701036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0.8

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_1 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(1102701035).content)

				arg_143_1.text_.text = var_146_1

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_3 = 32 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 32)

				if (32 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 32)) > 0 and var_146_0 < var_146_3 then
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
	Play1102701036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 1102701036
		arg_147_1.duration_ = 14.13

		local var_147_0 = {
			ja = 9.566,
			ko = 14.133,
			zh = 14.133
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play1102701037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1027ui_story = arg_147_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_150_0 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 then
				arg_147_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_147_1.time_ - 0) / var_150_0)
				arg_147_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1027ui_story"].transform.position).z)
				arg_147_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1027ui_story"].transform.localEulerAngles = arg_147_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 then
				arg_147_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, -0.81, -5.8)
				arg_147_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1027ui_story"].transform.position).z)
				arg_147_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1027ui_story"].transform.localEulerAngles = arg_147_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_150_1 = arg_147_1.actors_["1027ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect1027ui_story == nil then
				arg_147_1.var_.characterEffect1027ui_story = var_150_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_2 and not isNil(var_150_1) then
				if arg_147_1.var_.characterEffect1027ui_story and not isNil(var_150_1) then
					arg_147_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_2 and arg_147_1.time_ < 0 + var_150_2 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect1027ui_story then
				arg_147_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action3_1")
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_150_4 = 0
			local var_150_5 = 1.3

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_6 = arg_147_1:GetWordFromCfg(1102701036)
				local var_150_7 = arg_147_1:FormatText(var_150_6.content)

				arg_147_1.text_.text = var_150_7

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_9 = 52 <= 0 and var_150_5 or var_150_5 * (utf8.len(var_150_7) / 52)

				if (52 <= 0 and var_150_5 or var_150_5 * (utf8.len(var_150_7) / 52)) > 0 and var_150_5 < var_150_9 then
					arg_147_1.talkMaxDuration = var_150_9

					if var_150_9 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_9 + var_150_4
					end
				end

				arg_147_1.text_.text = var_150_7
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701036", "story_v_side_new_1102701.awb") ~= 0 then
					local var_150_10 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701036", "story_v_side_new_1102701.awb") / 1000

					if var_150_10 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_10 + var_150_4
					end

					if var_150_6.prefab_name ~= "" and arg_147_1.actors_[var_150_6.prefab_name] ~= nil then
						local var_150_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_6.prefab_name].transform, "story_v_side_new_1102701", "1102701036", "story_v_side_new_1102701.awb")

						arg_147_1:RecordAudio("1102701036", var_150_11)
						arg_147_1:RecordAudio("1102701036", var_150_11)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701036", "story_v_side_new_1102701.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701036", "story_v_side_new_1102701.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_12 = math.max(var_150_5, arg_147_1.talkMaxDuration)

			if var_150_4 <= arg_147_1.time_ and arg_147_1.time_ < var_150_4 + var_150_12 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_4) / var_150_12

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_4 + var_150_12 and arg_147_1.time_ < var_150_4 + var_150_12 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play1102701037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 1102701037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play1102701038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["1027ui_story"]) and arg_151_1.var_.characterEffect1027ui_story == nil then
				arg_151_1.var_.characterEffect1027ui_story = arg_151_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_0 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["1027ui_story"]) then
				if arg_151_1.var_.characterEffect1027ui_story and not isNil(arg_151_1.actors_["1027ui_story"]) then
					arg_151_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_0)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["1027ui_story"]) and arg_151_1.var_.characterEffect1027ui_story then
				arg_151_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_154_1 = 0
			local var_154_2 = 0.4

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_3 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(1102701037).content)

				arg_151_1.text_.text = var_154_3

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 16 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_3) / 16)

				if (16 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_3) / 16)) > 0 and var_154_2 < var_154_5 then
					arg_151_1.talkMaxDuration = var_154_5

					if var_154_5 + var_154_1 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + var_154_1
					end
				end

				arg_151_1.text_.text = var_154_3
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_6 = math.max(var_154_2, arg_151_1.talkMaxDuration)

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_6 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_1) / var_154_6

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_1 + var_154_6 and arg_151_1.time_ < var_154_1 + var_154_6 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play1102701038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 1102701038
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play1102701039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0.45

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
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

				local var_158_1 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(1102701038).content)

				arg_155_1.text_.text = var_158_1

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_3 = 18 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 18)

				if (18 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 18)) > 0 and var_158_0 < var_158_3 then
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
	Play1102701039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 1102701039
		arg_159_1.duration_ = 6.3

		local var_159_0 = {
			ja = 4.933,
			ko = 6.3,
			zh = 6.3
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
				arg_159_0:Play1102701040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["1027ui_story"]) and arg_159_1.var_.characterEffect1027ui_story == nil then
				arg_159_1.var_.characterEffect1027ui_story = arg_159_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_0 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["1027ui_story"]) then
				if arg_159_1.var_.characterEffect1027ui_story and not isNil(arg_159_1.actors_["1027ui_story"]) then
					arg_159_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["1027ui_story"]) and arg_159_1.var_.characterEffect1027ui_story then
				arg_159_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action3_2")
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_162_2 = 0
			local var_162_3 = 0.675

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_2 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_4 = arg_159_1:GetWordFromCfg(1102701039)
				local var_162_5 = arg_159_1:FormatText(var_162_4.content)

				arg_159_1.text_.text = var_162_5

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_7 = 27 <= 0 and var_162_3 or var_162_3 * (utf8.len(var_162_5) / 27)

				if (27 <= 0 and var_162_3 or var_162_3 * (utf8.len(var_162_5) / 27)) > 0 and var_162_3 < var_162_7 then
					arg_159_1.talkMaxDuration = var_162_7

					if var_162_7 + var_162_2 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_7 + var_162_2
					end
				end

				arg_159_1.text_.text = var_162_5
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701039", "story_v_side_new_1102701.awb") ~= 0 then
					local var_162_8 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701039", "story_v_side_new_1102701.awb") / 1000

					if var_162_8 + var_162_2 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_2
					end

					if var_162_4.prefab_name ~= "" and arg_159_1.actors_[var_162_4.prefab_name] ~= nil then
						local var_162_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_4.prefab_name].transform, "story_v_side_new_1102701", "1102701039", "story_v_side_new_1102701.awb")

						arg_159_1:RecordAudio("1102701039", var_162_9)
						arg_159_1:RecordAudio("1102701039", var_162_9)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701039", "story_v_side_new_1102701.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701039", "story_v_side_new_1102701.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_10 = math.max(var_162_3, arg_159_1.talkMaxDuration)

			if var_162_2 <= arg_159_1.time_ and arg_159_1.time_ < var_162_2 + var_162_10 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_2) / var_162_10

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_2 + var_162_10 and arg_159_1.time_ < var_162_2 + var_162_10 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play1102701040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 1102701040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play1102701041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["1027ui_story"]) and arg_163_1.var_.characterEffect1027ui_story == nil then
				arg_163_1.var_.characterEffect1027ui_story = arg_163_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_0 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["1027ui_story"]) then
				if arg_163_1.var_.characterEffect1027ui_story and not isNil(arg_163_1.actors_["1027ui_story"]) then
					arg_163_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_0)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["1027ui_story"]) and arg_163_1.var_.characterEffect1027ui_story then
				arg_163_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_166_1 = 0
			local var_166_2 = 0.25

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

				local var_166_3 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(1102701040).content)

				arg_163_1.text_.text = var_166_3

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 10 <= 0 and var_166_2 or var_166_2 * (utf8.len(var_166_3) / 10)

				if (10 <= 0 and var_166_2 or var_166_2 * (utf8.len(var_166_3) / 10)) > 0 and var_166_2 < var_166_5 then
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
	Play1102701041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 1102701041
		arg_167_1.duration_ = 13.07

		local var_167_0 = {
			ja = 13.066,
			ko = 8.7,
			zh = 8.7
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
				arg_167_0:Play1102701042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["1027ui_story"]) and arg_167_1.var_.characterEffect1027ui_story == nil then
				arg_167_1.var_.characterEffect1027ui_story = arg_167_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_0 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["1027ui_story"]) then
				if arg_167_1.var_.characterEffect1027ui_story and not isNil(arg_167_1.actors_["1027ui_story"]) then
					arg_167_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["1027ui_story"]) and arg_167_1.var_.characterEffect1027ui_story then
				arg_167_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_170_2 = 0
			local var_170_3 = 0.75

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_2 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_4 = arg_167_1:GetWordFromCfg(1102701041)
				local var_170_5 = arg_167_1:FormatText(var_170_4.content)

				arg_167_1.text_.text = var_170_5

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_7 = 30 <= 0 and var_170_3 or var_170_3 * (utf8.len(var_170_5) / 30)

				if (30 <= 0 and var_170_3 or var_170_3 * (utf8.len(var_170_5) / 30)) > 0 and var_170_3 < var_170_7 then
					arg_167_1.talkMaxDuration = var_170_7

					if var_170_7 + var_170_2 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_2
					end
				end

				arg_167_1.text_.text = var_170_5
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701041", "story_v_side_new_1102701.awb") ~= 0 then
					local var_170_8 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701041", "story_v_side_new_1102701.awb") / 1000

					if var_170_8 + var_170_2 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_2
					end

					if var_170_4.prefab_name ~= "" and arg_167_1.actors_[var_170_4.prefab_name] ~= nil then
						local var_170_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_4.prefab_name].transform, "story_v_side_new_1102701", "1102701041", "story_v_side_new_1102701.awb")

						arg_167_1:RecordAudio("1102701041", var_170_9)
						arg_167_1:RecordAudio("1102701041", var_170_9)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701041", "story_v_side_new_1102701.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701041", "story_v_side_new_1102701.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_10 = math.max(var_170_3, arg_167_1.talkMaxDuration)

			if var_170_2 <= arg_167_1.time_ and arg_167_1.time_ < var_170_2 + var_170_10 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_2) / var_170_10

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_2 + var_170_10 and arg_167_1.time_ < var_170_2 + var_170_10 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play1102701042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 1102701042
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play1102701043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["1027ui_story"]) and arg_171_1.var_.characterEffect1027ui_story == nil then
				arg_171_1.var_.characterEffect1027ui_story = arg_171_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_0 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["1027ui_story"]) then
				if arg_171_1.var_.characterEffect1027ui_story and not isNil(arg_171_1.actors_["1027ui_story"]) then
					arg_171_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_0)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["1027ui_story"]) and arg_171_1.var_.characterEffect1027ui_story then
				arg_171_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_174_1 = 0
			local var_174_2 = 0.65

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

				local var_174_3 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(1102701042).content)

				arg_171_1.text_.text = var_174_3

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 26 <= 0 and var_174_2 or var_174_2 * (utf8.len(var_174_3) / 26)

				if (26 <= 0 and var_174_2 or var_174_2 * (utf8.len(var_174_3) / 26)) > 0 and var_174_2 < var_174_5 then
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
	Play1102701043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 1102701043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play1102701044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.575

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

				local var_178_1 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(1102701043).content)

				arg_175_1.text_.text = var_178_1

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_3 = 23 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 23)

				if (23 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 23)) > 0 and var_178_0 < var_178_3 then
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
	Play1102701044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 1102701044
		arg_179_1.duration_ = 12.5

		local var_179_0 = {
			ja = 12.5,
			ko = 8.2,
			zh = 8.2
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
				arg_179_0:Play1102701045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["1027ui_story"]) and arg_179_1.var_.characterEffect1027ui_story == nil then
				arg_179_1.var_.characterEffect1027ui_story = arg_179_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_0 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["1027ui_story"]) then
				if arg_179_1.var_.characterEffect1027ui_story and not isNil(arg_179_1.actors_["1027ui_story"]) then
					arg_179_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["1027ui_story"]) and arg_179_1.var_.characterEffect1027ui_story then
				arg_179_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_182_2 = 0
			local var_182_3 = 0.925

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_2 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_4 = arg_179_1:GetWordFromCfg(1102701044)
				local var_182_5 = arg_179_1:FormatText(var_182_4.content)

				arg_179_1.text_.text = var_182_5

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_7 = 37 <= 0 and var_182_3 or var_182_3 * (utf8.len(var_182_5) / 37)

				if (37 <= 0 and var_182_3 or var_182_3 * (utf8.len(var_182_5) / 37)) > 0 and var_182_3 < var_182_7 then
					arg_179_1.talkMaxDuration = var_182_7

					if var_182_7 + var_182_2 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_7 + var_182_2
					end
				end

				arg_179_1.text_.text = var_182_5
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701044", "story_v_side_new_1102701.awb") ~= 0 then
					local var_182_8 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701044", "story_v_side_new_1102701.awb") / 1000

					if var_182_8 + var_182_2 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_8 + var_182_2
					end

					if var_182_4.prefab_name ~= "" and arg_179_1.actors_[var_182_4.prefab_name] ~= nil then
						local var_182_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_4.prefab_name].transform, "story_v_side_new_1102701", "1102701044", "story_v_side_new_1102701.awb")

						arg_179_1:RecordAudio("1102701044", var_182_9)
						arg_179_1:RecordAudio("1102701044", var_182_9)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701044", "story_v_side_new_1102701.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701044", "story_v_side_new_1102701.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_10 = math.max(var_182_3, arg_179_1.talkMaxDuration)

			if var_182_2 <= arg_179_1.time_ and arg_179_1.time_ < var_182_2 + var_182_10 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_2) / var_182_10

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_2 + var_182_10 and arg_179_1.time_ < var_182_2 + var_182_10 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play1102701045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 1102701045
		arg_183_1.duration_ = 8.6

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play1102701046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 1

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_1 = arg_183_1:GetWordFromCfg(1102701045)
				local var_186_2 = arg_183_1:FormatText(var_186_1.content)

				arg_183_1.text_.text = var_186_2

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_4 = 40 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 40)

				if (40 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 40)) > 0 and var_186_0 < var_186_4 then
					arg_183_1.talkMaxDuration = var_186_4

					if var_186_4 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_4 + 0
					end
				end

				arg_183_1.text_.text = var_186_2
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701045", "story_v_side_new_1102701.awb") ~= 0 then
					local var_186_5 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701045", "story_v_side_new_1102701.awb") / 1000

					if var_186_5 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + 0
					end

					if var_186_1.prefab_name ~= "" and arg_183_1.actors_[var_186_1.prefab_name] ~= nil then
						local var_186_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_1.prefab_name].transform, "story_v_side_new_1102701", "1102701045", "story_v_side_new_1102701.awb")

						arg_183_1:RecordAudio("1102701045", var_186_6)
						arg_183_1:RecordAudio("1102701045", var_186_6)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701045", "story_v_side_new_1102701.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701045", "story_v_side_new_1102701.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_7 = math.max(var_186_0, arg_183_1.talkMaxDuration)

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_7 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - 0) / var_186_7

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= 0 + var_186_7 and arg_183_1.time_ < 0 + var_186_7 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play1102701046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1102701046
		arg_187_1.duration_ = 14.23

		local var_187_0 = {
			ja = 14.233,
			ko = 12.966,
			zh = 12.966
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
				arg_187_0:Play1102701047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action6_1")
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_190_0 = 0
			local var_190_1 = 1.25

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_2 = arg_187_1:GetWordFromCfg(1102701046)
				local var_190_3 = arg_187_1:FormatText(var_190_2.content)

				arg_187_1.text_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 50 <= 0 and var_190_1 or var_190_1 * (utf8.len(var_190_3) / 50)

				if (50 <= 0 and var_190_1 or var_190_1 * (utf8.len(var_190_3) / 50)) > 0 and var_190_1 < var_190_5 then
					arg_187_1.talkMaxDuration = var_190_5

					if var_190_5 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + var_190_0
					end
				end

				arg_187_1.text_.text = var_190_3
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701046", "story_v_side_new_1102701.awb") ~= 0 then
					local var_190_6 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701046", "story_v_side_new_1102701.awb") / 1000

					if var_190_6 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_6 + var_190_0
					end

					if var_190_2.prefab_name ~= "" and arg_187_1.actors_[var_190_2.prefab_name] ~= nil then
						local var_190_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_2.prefab_name].transform, "story_v_side_new_1102701", "1102701046", "story_v_side_new_1102701.awb")

						arg_187_1:RecordAudio("1102701046", var_190_7)
						arg_187_1:RecordAudio("1102701046", var_190_7)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701046", "story_v_side_new_1102701.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701046", "story_v_side_new_1102701.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_8 = math.max(var_190_1, arg_187_1.talkMaxDuration)

			if var_190_0 <= arg_187_1.time_ and arg_187_1.time_ < var_190_0 + var_190_8 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_0) / var_190_8

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_0 + var_190_8 and arg_187_1.time_ < var_190_0 + var_190_8 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play1102701047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 1102701047
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play1102701048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["1027ui_story"]) and arg_191_1.var_.characterEffect1027ui_story == nil then
				arg_191_1.var_.characterEffect1027ui_story = arg_191_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_0 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 and not isNil(arg_191_1.actors_["1027ui_story"]) then
				if arg_191_1.var_.characterEffect1027ui_story and not isNil(arg_191_1.actors_["1027ui_story"]) then
					arg_191_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_191_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_191_1.time_ - 0) / var_194_0)
				end
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 and not isNil(arg_191_1.actors_["1027ui_story"]) and arg_191_1.var_.characterEffect1027ui_story then
				arg_191_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_191_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_194_1 = 0
			local var_194_2 = 0.425

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

				local var_194_3 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(1102701047).content)

				arg_191_1.text_.text = var_194_3

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 17 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_3) / 17)

				if (17 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_3) / 17)) > 0 and var_194_2 < var_194_5 then
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
	Play1102701048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 1102701048
		arg_195_1.duration_ = 2.87

		local var_195_0 = {
			ja = 2.866,
			ko = 1.7,
			zh = 1.7
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
				arg_195_0:Play1102701049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:AudioAction("play", "effect", "se_story_side_1027", "se_story_side_1027_dog2", "")
			end

			local var_198_1 = 0
			local var_198_2 = 0.125

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080_1")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_3 = arg_195_1:GetWordFromCfg(1102701048)
				local var_198_4 = arg_195_1:FormatText(var_198_3.content)

				arg_195_1.text_.text = var_198_4

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_6 = 5 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_4) / 5)

				if (5 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_4) / 5)) > 0 and var_198_2 < var_198_6 then
					arg_195_1.talkMaxDuration = var_198_6

					if var_198_6 + var_198_1 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_6 + var_198_1
					end
				end

				arg_195_1.text_.text = var_198_4
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701048", "story_v_side_new_1102701.awb") ~= 0 then
					local var_198_7 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701048", "story_v_side_new_1102701.awb") / 1000

					if var_198_7 + var_198_1 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_7 + var_198_1
					end

					if var_198_3.prefab_name ~= "" and arg_195_1.actors_[var_198_3.prefab_name] ~= nil then
						local var_198_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_3.prefab_name].transform, "story_v_side_new_1102701", "1102701048", "story_v_side_new_1102701.awb")

						arg_195_1:RecordAudio("1102701048", var_198_8)
						arg_195_1:RecordAudio("1102701048", var_198_8)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701048", "story_v_side_new_1102701.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701048", "story_v_side_new_1102701.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_9 = math.max(var_198_2, arg_195_1.talkMaxDuration)

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_9 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_1) / var_198_9

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_1 + var_198_9 and arg_195_1.time_ < var_198_1 + var_198_9 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play1102701049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 1102701049
		arg_199_1.duration_ = 18.63

		local var_199_0 = {
			ja = 18.633,
			ko = 12.6,
			zh = 12.6
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
				arg_199_0:Play1102701050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["1027ui_story"]) and arg_199_1.var_.characterEffect1027ui_story == nil then
				arg_199_1.var_.characterEffect1027ui_story = arg_199_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_0 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["1027ui_story"]) then
				if arg_199_1.var_.characterEffect1027ui_story and not isNil(arg_199_1.actors_["1027ui_story"]) then
					arg_199_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["1027ui_story"]) and arg_199_1.var_.characterEffect1027ui_story then
				arg_199_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action463")
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_202_2 = 0
			local var_202_3 = 1.175

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_2 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_4 = arg_199_1:GetWordFromCfg(1102701049)
				local var_202_5 = arg_199_1:FormatText(var_202_4.content)

				arg_199_1.text_.text = var_202_5

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_7 = 47 <= 0 and var_202_3 or var_202_3 * (utf8.len(var_202_5) / 47)

				if (47 <= 0 and var_202_3 or var_202_3 * (utf8.len(var_202_5) / 47)) > 0 and var_202_3 < var_202_7 then
					arg_199_1.talkMaxDuration = var_202_7

					if var_202_7 + var_202_2 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_7 + var_202_2
					end
				end

				arg_199_1.text_.text = var_202_5
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701049", "story_v_side_new_1102701.awb") ~= 0 then
					local var_202_8 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701049", "story_v_side_new_1102701.awb") / 1000

					if var_202_8 + var_202_2 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_8 + var_202_2
					end

					if var_202_4.prefab_name ~= "" and arg_199_1.actors_[var_202_4.prefab_name] ~= nil then
						local var_202_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_4.prefab_name].transform, "story_v_side_new_1102701", "1102701049", "story_v_side_new_1102701.awb")

						arg_199_1:RecordAudio("1102701049", var_202_9)
						arg_199_1:RecordAudio("1102701049", var_202_9)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701049", "story_v_side_new_1102701.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701049", "story_v_side_new_1102701.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_10 = math.max(var_202_3, arg_199_1.talkMaxDuration)

			if var_202_2 <= arg_199_1.time_ and arg_199_1.time_ < var_202_2 + var_202_10 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_2) / var_202_10

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_2 + var_202_10 and arg_199_1.time_ < var_202_2 + var_202_10 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play1102701050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 1102701050
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play1102701051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["1027ui_story"]) and arg_203_1.var_.characterEffect1027ui_story == nil then
				arg_203_1.var_.characterEffect1027ui_story = arg_203_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_0 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["1027ui_story"]) then
				if arg_203_1.var_.characterEffect1027ui_story and not isNil(arg_203_1.actors_["1027ui_story"]) then
					arg_203_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_203_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_203_1.time_ - 0) / var_206_0)
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["1027ui_story"]) and arg_203_1.var_.characterEffect1027ui_story then
				arg_203_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_203_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_206_1 = 0
			local var_206_2 = 0.575

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_3 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(1102701050).content)

				arg_203_1.text_.text = var_206_3

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_5 = 23 <= 0 and var_206_2 or var_206_2 * (utf8.len(var_206_3) / 23)

				if (23 <= 0 and var_206_2 or var_206_2 * (utf8.len(var_206_3) / 23)) > 0 and var_206_2 < var_206_5 then
					arg_203_1.talkMaxDuration = var_206_5

					if var_206_5 + var_206_1 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + var_206_1
					end
				end

				arg_203_1.text_.text = var_206_3
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_6 = math.max(var_206_2, arg_203_1.talkMaxDuration)

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_6 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_1) / var_206_6

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_1 + var_206_6 and arg_203_1.time_ < var_206_1 + var_206_6 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play1102701051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 1102701051
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play1102701052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0.775

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_1 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(1102701051).content)

				arg_207_1.text_.text = var_210_1

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_3 = 31 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_1) / 31)

				if (31 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_1) / 31)) > 0 and var_210_0 < var_210_3 then
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
	Play1102701052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 1102701052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play1102701053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0.55

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_1 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(1102701052).content)

				arg_211_1.text_.text = var_214_1

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_3 = 22 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 22)

				if (22 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 22)) > 0 and var_214_0 < var_214_3 then
					arg_211_1.talkMaxDuration = var_214_3

					if var_214_3 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_3 + 0
					end
				end

				arg_211_1.text_.text = var_214_1
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_4 = math.max(var_214_0, arg_211_1.talkMaxDuration)

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_4 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - 0) / var_214_4

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= 0 + var_214_4 and arg_211_1.time_ < 0 + var_214_4 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play1102701053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 1102701053
		arg_215_1.duration_ = 1.27

		local var_215_0 = {
			ja = 1.033,
			ko = 1.266,
			zh = 1.266
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play1102701054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:AudioAction("play", "effect", "se_story_side_1027", "se_story_side_1027_dog3", "")
			end

			local var_218_1 = 0
			local var_218_2 = 0.15

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080_1")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_3 = arg_215_1:GetWordFromCfg(1102701053)
				local var_218_4 = arg_215_1:FormatText(var_218_3.content)

				arg_215_1.text_.text = var_218_4

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_6 = 6 <= 0 and var_218_2 or var_218_2 * (utf8.len(var_218_4) / 6)

				if (6 <= 0 and var_218_2 or var_218_2 * (utf8.len(var_218_4) / 6)) > 0 and var_218_2 < var_218_6 then
					arg_215_1.talkMaxDuration = var_218_6

					if var_218_6 + var_218_1 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_6 + var_218_1
					end
				end

				arg_215_1.text_.text = var_218_4
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701053", "story_v_side_new_1102701.awb") ~= 0 then
					local var_218_7 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701053", "story_v_side_new_1102701.awb") / 1000

					if var_218_7 + var_218_1 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_7 + var_218_1
					end

					if var_218_3.prefab_name ~= "" and arg_215_1.actors_[var_218_3.prefab_name] ~= nil then
						local var_218_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_3.prefab_name].transform, "story_v_side_new_1102701", "1102701053", "story_v_side_new_1102701.awb")

						arg_215_1:RecordAudio("1102701053", var_218_8)
						arg_215_1:RecordAudio("1102701053", var_218_8)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701053", "story_v_side_new_1102701.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701053", "story_v_side_new_1102701.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_9 = math.max(var_218_2, arg_215_1.talkMaxDuration)

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_9 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_1) / var_218_9

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_1 + var_218_9 and arg_215_1.time_ < var_218_1 + var_218_9 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play1102701054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 1102701054
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play1102701055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos1027ui_story = arg_219_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_222_0 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 then
				arg_219_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_219_1.time_ - 0) / var_222_0)
				arg_219_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1027ui_story"].transform.position).z)
				arg_219_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1027ui_story"].transform.localEulerAngles = arg_219_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 then
				arg_219_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_219_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1027ui_story"].transform.position).z)
				arg_219_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1027ui_story"].transform.localEulerAngles = arg_219_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_222_1 = arg_219_1.actors_["1027ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect1027ui_story == nil then
				arg_219_1.var_.characterEffect1027ui_story = var_222_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_2 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_2 and not isNil(var_222_1) then
				if arg_219_1.var_.characterEffect1027ui_story and not isNil(var_222_1) then
					arg_219_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 0) / var_222_2)
				end
			end

			if arg_219_1.time_ >= 0 + var_222_2 and arg_219_1.time_ < 0 + var_222_2 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect1027ui_story then
				arg_219_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_222_3 = 0
			local var_222_4 = 0.55

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_3 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_5 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(1102701054).content)

				arg_219_1.text_.text = var_222_5

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_7 = 22 <= 0 and var_222_4 or var_222_4 * (utf8.len(var_222_5) / 22)

				if (22 <= 0 and var_222_4 or var_222_4 * (utf8.len(var_222_5) / 22)) > 0 and var_222_4 < var_222_7 then
					arg_219_1.talkMaxDuration = var_222_7

					if var_222_7 + var_222_3 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_7 + var_222_3
					end
				end

				arg_219_1.text_.text = var_222_5
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_8 = math.max(var_222_4, arg_219_1.talkMaxDuration)

			if var_222_3 <= arg_219_1.time_ and arg_219_1.time_ < var_222_3 + var_222_8 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_3) / var_222_8

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_3 + var_222_8 and arg_219_1.time_ < var_222_3 + var_222_8 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play1102701055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 1102701055
		arg_223_1.duration_ = 4

		local var_223_0 = {
			ja = 3.966,
			ko = 4,
			zh = 4
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
				arg_223_0:Play1102701056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos1027ui_story = arg_223_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_226_0 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 then
				arg_223_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_223_1.time_ - 0) / var_226_0)
				arg_223_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1027ui_story"].transform.position).z)
				arg_223_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["1027ui_story"].transform.localEulerAngles = arg_223_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 then
				arg_223_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, -0.81, -5.8)
				arg_223_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1027ui_story"].transform.position).z)
				arg_223_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["1027ui_story"].transform.localEulerAngles = arg_223_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_226_1 = arg_223_1.actors_["1027ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect1027ui_story == nil then
				arg_223_1.var_.characterEffect1027ui_story = var_226_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_2 and not isNil(var_226_1) then
				if arg_223_1.var_.characterEffect1027ui_story and not isNil(var_226_1) then
					arg_223_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 0 + var_226_2 and arg_223_1.time_ < 0 + var_226_2 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect1027ui_story then
				arg_223_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_226_4 = 0
			local var_226_5 = 0.275

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_4 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_6 = arg_223_1:GetWordFromCfg(1102701055)
				local var_226_7 = arg_223_1:FormatText(var_226_6.content)

				arg_223_1.text_.text = var_226_7

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_9 = 11 <= 0 and var_226_5 or var_226_5 * (utf8.len(var_226_7) / 11)

				if (11 <= 0 and var_226_5 or var_226_5 * (utf8.len(var_226_7) / 11)) > 0 and var_226_5 < var_226_9 then
					arg_223_1.talkMaxDuration = var_226_9

					if var_226_9 + var_226_4 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_9 + var_226_4
					end
				end

				arg_223_1.text_.text = var_226_7
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701055", "story_v_side_new_1102701.awb") ~= 0 then
					local var_226_10 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701055", "story_v_side_new_1102701.awb") / 1000

					if var_226_10 + var_226_4 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_10 + var_226_4
					end

					if var_226_6.prefab_name ~= "" and arg_223_1.actors_[var_226_6.prefab_name] ~= nil then
						local var_226_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_6.prefab_name].transform, "story_v_side_new_1102701", "1102701055", "story_v_side_new_1102701.awb")

						arg_223_1:RecordAudio("1102701055", var_226_11)
						arg_223_1:RecordAudio("1102701055", var_226_11)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701055", "story_v_side_new_1102701.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701055", "story_v_side_new_1102701.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_12 = math.max(var_226_5, arg_223_1.talkMaxDuration)

			if var_226_4 <= arg_223_1.time_ and arg_223_1.time_ < var_226_4 + var_226_12 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_4) / var_226_12

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_4 + var_226_12 and arg_223_1.time_ < var_226_4 + var_226_12 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
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
	Play1102701056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 1102701056
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play1102701057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(arg_227_1.actors_["1027ui_story"]) and arg_227_1.var_.characterEffect1027ui_story == nil then
				arg_227_1.var_.characterEffect1027ui_story = arg_227_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_0 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 and not isNil(arg_227_1.actors_["1027ui_story"]) then
				if arg_227_1.var_.characterEffect1027ui_story and not isNil(arg_227_1.actors_["1027ui_story"]) then
					arg_227_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_227_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_227_1.time_ - 0) / var_230_0)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 and not isNil(arg_227_1.actors_["1027ui_story"]) and arg_227_1.var_.characterEffect1027ui_story then
				arg_227_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_227_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_230_1 = 0
			local var_230_2 = 0.3

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_3 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(1102701056).content)

				arg_227_1.text_.text = var_230_3

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 12 <= 0 and var_230_2 or var_230_2 * (utf8.len(var_230_3) / 12)

				if (12 <= 0 and var_230_2 or var_230_2 * (utf8.len(var_230_3) / 12)) > 0 and var_230_2 < var_230_5 then
					arg_227_1.talkMaxDuration = var_230_5

					if var_230_5 + var_230_1 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + var_230_1
					end
				end

				arg_227_1.text_.text = var_230_3
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_6 = math.max(var_230_2, arg_227_1.talkMaxDuration)

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_6 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_1) / var_230_6

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_1 + var_230_6 and arg_227_1.time_ < var_230_1 + var_230_6 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play1102701057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 1102701057
		arg_231_1.duration_ = 2.6

		local var_231_0 = {
			ja = 2.6,
			ko = 2.233,
			zh = 2.233
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
				arg_231_0:Play1102701058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["1027ui_story"]) and arg_231_1.var_.characterEffect1027ui_story == nil then
				arg_231_1.var_.characterEffect1027ui_story = arg_231_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_0 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 and not isNil(arg_231_1.actors_["1027ui_story"]) then
				if arg_231_1.var_.characterEffect1027ui_story and not isNil(arg_231_1.actors_["1027ui_story"]) then
					arg_231_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 and not isNil(arg_231_1.actors_["1027ui_story"]) and arg_231_1.var_.characterEffect1027ui_story then
				arg_231_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_234_2 = 0
			local var_234_3 = 0.125

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_2 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_4 = arg_231_1:GetWordFromCfg(1102701057)
				local var_234_5 = arg_231_1:FormatText(var_234_4.content)

				arg_231_1.text_.text = var_234_5

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_7 = 5 <= 0 and var_234_3 or var_234_3 * (utf8.len(var_234_5) / 5)

				if (5 <= 0 and var_234_3 or var_234_3 * (utf8.len(var_234_5) / 5)) > 0 and var_234_3 < var_234_7 then
					arg_231_1.talkMaxDuration = var_234_7

					if var_234_7 + var_234_2 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_7 + var_234_2
					end
				end

				arg_231_1.text_.text = var_234_5
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701057", "story_v_side_new_1102701.awb") ~= 0 then
					local var_234_8 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701057", "story_v_side_new_1102701.awb") / 1000

					if var_234_8 + var_234_2 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_8 + var_234_2
					end

					if var_234_4.prefab_name ~= "" and arg_231_1.actors_[var_234_4.prefab_name] ~= nil then
						local var_234_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_4.prefab_name].transform, "story_v_side_new_1102701", "1102701057", "story_v_side_new_1102701.awb")

						arg_231_1:RecordAudio("1102701057", var_234_9)
						arg_231_1:RecordAudio("1102701057", var_234_9)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701057", "story_v_side_new_1102701.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701057", "story_v_side_new_1102701.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_10 = math.max(var_234_3, arg_231_1.talkMaxDuration)

			if var_234_2 <= arg_231_1.time_ and arg_231_1.time_ < var_234_2 + var_234_10 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_2) / var_234_10

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_2 + var_234_10 and arg_231_1.time_ < var_234_2 + var_234_10 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play1102701058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 1102701058
		arg_235_1.duration_ = 2.5

		local var_235_0 = {
			ja = 0.999999999999,
			ko = 2.5,
			zh = 2.5
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
				arg_235_0:Play1102701059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(arg_235_1.actors_["1027ui_story"]) and arg_235_1.var_.characterEffect1027ui_story == nil then
				arg_235_1.var_.characterEffect1027ui_story = arg_235_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_0 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 and not isNil(arg_235_1.actors_["1027ui_story"]) then
				if arg_235_1.var_.characterEffect1027ui_story and not isNil(arg_235_1.actors_["1027ui_story"]) then
					arg_235_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_235_1.time_ - 0) / var_238_0)
				end
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 and not isNil(arg_235_1.actors_["1027ui_story"]) and arg_235_1.var_.characterEffect1027ui_story then
				arg_235_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:AudioAction("play", "effect", "se_story_side_1027", "se_story_side_1027_dog4", "")
			end

			local var_238_2 = 0
			local var_238_3 = 0.125

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_2 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080_1")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_4 = arg_235_1:GetWordFromCfg(1102701058)
				local var_238_5 = arg_235_1:FormatText(var_238_4.content)

				arg_235_1.text_.text = var_238_5

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_7 = 5 <= 0 and var_238_3 or var_238_3 * (utf8.len(var_238_5) / 5)

				if (5 <= 0 and var_238_3 or var_238_3 * (utf8.len(var_238_5) / 5)) > 0 and var_238_3 < var_238_7 then
					arg_235_1.talkMaxDuration = var_238_7

					if var_238_7 + var_238_2 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_7 + var_238_2
					end
				end

				arg_235_1.text_.text = var_238_5
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701058", "story_v_side_new_1102701.awb") ~= 0 then
					local var_238_8 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701058", "story_v_side_new_1102701.awb") / 1000

					if var_238_8 + var_238_2 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_8 + var_238_2
					end

					if var_238_4.prefab_name ~= "" and arg_235_1.actors_[var_238_4.prefab_name] ~= nil then
						local var_238_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_4.prefab_name].transform, "story_v_side_new_1102701", "1102701058", "story_v_side_new_1102701.awb")

						arg_235_1:RecordAudio("1102701058", var_238_9)
						arg_235_1:RecordAudio("1102701058", var_238_9)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701058", "story_v_side_new_1102701.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701058", "story_v_side_new_1102701.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_10 = math.max(var_238_3, arg_235_1.talkMaxDuration)

			if var_238_2 <= arg_235_1.time_ and arg_235_1.time_ < var_238_2 + var_238_10 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_2) / var_238_10

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_2 + var_238_10 and arg_235_1.time_ < var_238_2 + var_238_10 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play1102701059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 1102701059
		arg_239_1.duration_ = 10.63

		local var_239_0 = {
			ja = 7.933,
			ko = 10.633,
			zh = 10.633
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
				arg_239_0:Play1102701060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(arg_239_1.actors_["1027ui_story"]) and arg_239_1.var_.characterEffect1027ui_story == nil then
				arg_239_1.var_.characterEffect1027ui_story = arg_239_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_0 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 and not isNil(arg_239_1.actors_["1027ui_story"]) then
				if arg_239_1.var_.characterEffect1027ui_story and not isNil(arg_239_1.actors_["1027ui_story"]) then
					arg_239_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 and not isNil(arg_239_1.actors_["1027ui_story"]) and arg_239_1.var_.characterEffect1027ui_story then
				arg_239_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action6_1")
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_242_2 = 0
			local var_242_3 = 0.925

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_2 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_4 = arg_239_1:GetWordFromCfg(1102701059)
				local var_242_5 = arg_239_1:FormatText(var_242_4.content)

				arg_239_1.text_.text = var_242_5

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_7 = 37 <= 0 and var_242_3 or var_242_3 * (utf8.len(var_242_5) / 37)

				if (37 <= 0 and var_242_3 or var_242_3 * (utf8.len(var_242_5) / 37)) > 0 and var_242_3 < var_242_7 then
					arg_239_1.talkMaxDuration = var_242_7

					if var_242_7 + var_242_2 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_7 + var_242_2
					end
				end

				arg_239_1.text_.text = var_242_5
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701059", "story_v_side_new_1102701.awb") ~= 0 then
					local var_242_8 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701059", "story_v_side_new_1102701.awb") / 1000

					if var_242_8 + var_242_2 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_8 + var_242_2
					end

					if var_242_4.prefab_name ~= "" and arg_239_1.actors_[var_242_4.prefab_name] ~= nil then
						local var_242_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_4.prefab_name].transform, "story_v_side_new_1102701", "1102701059", "story_v_side_new_1102701.awb")

						arg_239_1:RecordAudio("1102701059", var_242_9)
						arg_239_1:RecordAudio("1102701059", var_242_9)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701059", "story_v_side_new_1102701.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701059", "story_v_side_new_1102701.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_10 = math.max(var_242_3, arg_239_1.talkMaxDuration)

			if var_242_2 <= arg_239_1.time_ and arg_239_1.time_ < var_242_2 + var_242_10 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_2) / var_242_10

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_2 + var_242_10 and arg_239_1.time_ < var_242_2 + var_242_10 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play1102701060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 1102701060
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play1102701061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(arg_243_1.actors_["1027ui_story"]) and arg_243_1.var_.characterEffect1027ui_story == nil then
				arg_243_1.var_.characterEffect1027ui_story = arg_243_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_0 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 and not isNil(arg_243_1.actors_["1027ui_story"]) then
				if arg_243_1.var_.characterEffect1027ui_story and not isNil(arg_243_1.actors_["1027ui_story"]) then
					arg_243_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_243_1.time_ - 0) / var_246_0)
				end
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 and not isNil(arg_243_1.actors_["1027ui_story"]) and arg_243_1.var_.characterEffect1027ui_story then
				arg_243_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_246_1 = 0
			local var_246_2 = 0.35

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
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

				local var_246_3 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(1102701060).content)

				arg_243_1.text_.text = var_246_3

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_5 = 14 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_3) / 14)

				if (14 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_3) / 14)) > 0 and var_246_2 < var_246_5 then
					arg_243_1.talkMaxDuration = var_246_5

					if var_246_5 + var_246_1 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_5 + var_246_1
					end
				end

				arg_243_1.text_.text = var_246_3
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_6 = math.max(var_246_2, arg_243_1.talkMaxDuration)

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_6 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_1) / var_246_6

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_1 + var_246_6 and arg_243_1.time_ < var_246_1 + var_246_6 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play1102701061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 1102701061
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play1102701062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 1.05

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

				local var_250_1 = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(1102701061).content)

				arg_247_1.text_.text = var_250_1

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_3 = 42 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_1) / 42)

				if (42 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_1) / 42)) > 0 and var_250_0 < var_250_3 then
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
	Play1102701062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 1102701062
		arg_251_1.duration_ = 11.9

		local var_251_0 = {
			ja = 11.9,
			ko = 9,
			zh = 9
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play1102701063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(arg_251_1.actors_["1027ui_story"]) and arg_251_1.var_.characterEffect1027ui_story == nil then
				arg_251_1.var_.characterEffect1027ui_story = arg_251_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_0 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 and not isNil(arg_251_1.actors_["1027ui_story"]) then
				if arg_251_1.var_.characterEffect1027ui_story and not isNil(arg_251_1.actors_["1027ui_story"]) then
					arg_251_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 and not isNil(arg_251_1.actors_["1027ui_story"]) and arg_251_1.var_.characterEffect1027ui_story then
				arg_251_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action6_2")
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_254_2 = 0
			local var_254_3 = 0.9

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_2 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_4 = arg_251_1:GetWordFromCfg(1102701062)
				local var_254_5 = arg_251_1:FormatText(var_254_4.content)

				arg_251_1.text_.text = var_254_5

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_7 = 36 <= 0 and var_254_3 or var_254_3 * (utf8.len(var_254_5) / 36)

				if (36 <= 0 and var_254_3 or var_254_3 * (utf8.len(var_254_5) / 36)) > 0 and var_254_3 < var_254_7 then
					arg_251_1.talkMaxDuration = var_254_7

					if var_254_7 + var_254_2 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_7 + var_254_2
					end
				end

				arg_251_1.text_.text = var_254_5
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701062", "story_v_side_new_1102701.awb") ~= 0 then
					local var_254_8 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701062", "story_v_side_new_1102701.awb") / 1000

					if var_254_8 + var_254_2 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_8 + var_254_2
					end

					if var_254_4.prefab_name ~= "" and arg_251_1.actors_[var_254_4.prefab_name] ~= nil then
						local var_254_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_4.prefab_name].transform, "story_v_side_new_1102701", "1102701062", "story_v_side_new_1102701.awb")

						arg_251_1:RecordAudio("1102701062", var_254_9)
						arg_251_1:RecordAudio("1102701062", var_254_9)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701062", "story_v_side_new_1102701.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701062", "story_v_side_new_1102701.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_10 = math.max(var_254_3, arg_251_1.talkMaxDuration)

			if var_254_2 <= arg_251_1.time_ and arg_251_1.time_ < var_254_2 + var_254_10 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_2) / var_254_10

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_2 + var_254_10 and arg_251_1.time_ < var_254_2 + var_254_10 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play1102701063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 1102701063
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play1102701064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["1027ui_story"]) and arg_255_1.var_.characterEffect1027ui_story == nil then
				arg_255_1.var_.characterEffect1027ui_story = arg_255_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_0 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["1027ui_story"]) then
				if arg_255_1.var_.characterEffect1027ui_story and not isNil(arg_255_1.actors_["1027ui_story"]) then
					arg_255_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_255_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_255_1.time_ - 0) / var_258_0)
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["1027ui_story"]) and arg_255_1.var_.characterEffect1027ui_story then
				arg_255_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_255_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_258_1 = 0
			local var_258_2 = 0.425

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

				local var_258_3 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(1102701063).content)

				arg_255_1.text_.text = var_258_3

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_5 = 17 <= 0 and var_258_2 or var_258_2 * (utf8.len(var_258_3) / 17)

				if (17 <= 0 and var_258_2 or var_258_2 * (utf8.len(var_258_3) / 17)) > 0 and var_258_2 < var_258_5 then
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
	Play1102701064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 1102701064
		arg_259_1.duration_ = 9.8

		local var_259_0 = {
			ja = 9.8,
			ko = 7.966,
			zh = 7.966
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play1102701065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(arg_259_1.actors_["1027ui_story"]) and arg_259_1.var_.characterEffect1027ui_story == nil then
				arg_259_1.var_.characterEffect1027ui_story = arg_259_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_0 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 and not isNil(arg_259_1.actors_["1027ui_story"]) then
				if arg_259_1.var_.characterEffect1027ui_story and not isNil(arg_259_1.actors_["1027ui_story"]) then
					arg_259_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 and not isNil(arg_259_1.actors_["1027ui_story"]) and arg_259_1.var_.characterEffect1027ui_story then
				arg_259_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action4_1")
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_262_2 = 0
			local var_262_3 = 0.925

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_2 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_4 = arg_259_1:GetWordFromCfg(1102701064)
				local var_262_5 = arg_259_1:FormatText(var_262_4.content)

				arg_259_1.text_.text = var_262_5

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_7 = 37 <= 0 and var_262_3 or var_262_3 * (utf8.len(var_262_5) / 37)

				if (37 <= 0 and var_262_3 or var_262_3 * (utf8.len(var_262_5) / 37)) > 0 and var_262_3 < var_262_7 then
					arg_259_1.talkMaxDuration = var_262_7

					if var_262_7 + var_262_2 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_7 + var_262_2
					end
				end

				arg_259_1.text_.text = var_262_5
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701064", "story_v_side_new_1102701.awb") ~= 0 then
					local var_262_8 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701064", "story_v_side_new_1102701.awb") / 1000

					if var_262_8 + var_262_2 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_8 + var_262_2
					end

					if var_262_4.prefab_name ~= "" and arg_259_1.actors_[var_262_4.prefab_name] ~= nil then
						local var_262_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_4.prefab_name].transform, "story_v_side_new_1102701", "1102701064", "story_v_side_new_1102701.awb")

						arg_259_1:RecordAudio("1102701064", var_262_9)
						arg_259_1:RecordAudio("1102701064", var_262_9)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701064", "story_v_side_new_1102701.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701064", "story_v_side_new_1102701.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_10 = math.max(var_262_3, arg_259_1.talkMaxDuration)

			if var_262_2 <= arg_259_1.time_ and arg_259_1.time_ < var_262_2 + var_262_10 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_2) / var_262_10

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_2 + var_262_10 and arg_259_1.time_ < var_262_2 + var_262_10 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play1102701065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 1102701065
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play1102701066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(arg_263_1.actors_["1027ui_story"]) and arg_263_1.var_.characterEffect1027ui_story == nil then
				arg_263_1.var_.characterEffect1027ui_story = arg_263_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_0 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 and not isNil(arg_263_1.actors_["1027ui_story"]) then
				if arg_263_1.var_.characterEffect1027ui_story and not isNil(arg_263_1.actors_["1027ui_story"]) then
					arg_263_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_263_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_263_1.time_ - 0) / var_266_0)
				end
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 and not isNil(arg_263_1.actors_["1027ui_story"]) and arg_263_1.var_.characterEffect1027ui_story then
				arg_263_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_263_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_266_1 = 0
			local var_266_2 = 0.3

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
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

				local var_266_3 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(1102701065).content)

				arg_263_1.text_.text = var_266_3

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_5 = 12 <= 0 and var_266_2 or var_266_2 * (utf8.len(var_266_3) / 12)

				if (12 <= 0 and var_266_2 or var_266_2 * (utf8.len(var_266_3) / 12)) > 0 and var_266_2 < var_266_5 then
					arg_263_1.talkMaxDuration = var_266_5

					if var_266_5 + var_266_1 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_5 + var_266_1
					end
				end

				arg_263_1.text_.text = var_266_3
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_6 = math.max(var_266_2, arg_263_1.talkMaxDuration)

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_6 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_1) / var_266_6

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_1 + var_266_6 and arg_263_1.time_ < var_266_1 + var_266_6 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play1102701066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 1102701066
		arg_267_1.duration_ = 10.2

		local var_267_0 = {
			ja = 10.2,
			ko = 7.666,
			zh = 7.666
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play1102701067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(arg_267_1.actors_["1027ui_story"]) and arg_267_1.var_.characterEffect1027ui_story == nil then
				arg_267_1.var_.characterEffect1027ui_story = arg_267_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_0 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 and not isNil(arg_267_1.actors_["1027ui_story"]) then
				if arg_267_1.var_.characterEffect1027ui_story and not isNil(arg_267_1.actors_["1027ui_story"]) then
					arg_267_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 and not isNil(arg_267_1.actors_["1027ui_story"]) and arg_267_1.var_.characterEffect1027ui_story then
				arg_267_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_270_2 = 0
			local var_270_3 = 0.925

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_2 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_4 = arg_267_1:GetWordFromCfg(1102701066)
				local var_270_5 = arg_267_1:FormatText(var_270_4.content)

				arg_267_1.text_.text = var_270_5

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_7 = 37 <= 0 and var_270_3 or var_270_3 * (utf8.len(var_270_5) / 37)

				if (37 <= 0 and var_270_3 or var_270_3 * (utf8.len(var_270_5) / 37)) > 0 and var_270_3 < var_270_7 then
					arg_267_1.talkMaxDuration = var_270_7

					if var_270_7 + var_270_2 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_7 + var_270_2
					end
				end

				arg_267_1.text_.text = var_270_5
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701066", "story_v_side_new_1102701.awb") ~= 0 then
					local var_270_8 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701066", "story_v_side_new_1102701.awb") / 1000

					if var_270_8 + var_270_2 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_8 + var_270_2
					end

					if var_270_4.prefab_name ~= "" and arg_267_1.actors_[var_270_4.prefab_name] ~= nil then
						local var_270_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_4.prefab_name].transform, "story_v_side_new_1102701", "1102701066", "story_v_side_new_1102701.awb")

						arg_267_1:RecordAudio("1102701066", var_270_9)
						arg_267_1:RecordAudio("1102701066", var_270_9)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701066", "story_v_side_new_1102701.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701066", "story_v_side_new_1102701.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_10 = math.max(var_270_3, arg_267_1.talkMaxDuration)

			if var_270_2 <= arg_267_1.time_ and arg_267_1.time_ < var_270_2 + var_270_10 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_2) / var_270_10

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_2 + var_270_10 and arg_267_1.time_ < var_270_2 + var_270_10 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play1102701067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 1102701067
		arg_271_1.duration_ = 12.03

		local var_271_0 = {
			ja = 9.933,
			ko = 12.033,
			zh = 12.033
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play1102701068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_274_0 = 0
			local var_274_1 = 1.275

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_2 = arg_271_1:GetWordFromCfg(1102701067)
				local var_274_3 = arg_271_1:FormatText(var_274_2.content)

				arg_271_1.text_.text = var_274_3

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_5 = 50 <= 0 and var_274_1 or var_274_1 * (utf8.len(var_274_3) / 50)

				if (50 <= 0 and var_274_1 or var_274_1 * (utf8.len(var_274_3) / 50)) > 0 and var_274_1 < var_274_5 then
					arg_271_1.talkMaxDuration = var_274_5

					if var_274_5 + var_274_0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_5 + var_274_0
					end
				end

				arg_271_1.text_.text = var_274_3
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701067", "story_v_side_new_1102701.awb") ~= 0 then
					local var_274_6 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701067", "story_v_side_new_1102701.awb") / 1000

					if var_274_6 + var_274_0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_6 + var_274_0
					end

					if var_274_2.prefab_name ~= "" and arg_271_1.actors_[var_274_2.prefab_name] ~= nil then
						local var_274_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_2.prefab_name].transform, "story_v_side_new_1102701", "1102701067", "story_v_side_new_1102701.awb")

						arg_271_1:RecordAudio("1102701067", var_274_7)
						arg_271_1:RecordAudio("1102701067", var_274_7)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701067", "story_v_side_new_1102701.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701067", "story_v_side_new_1102701.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_8 = math.max(var_274_1, arg_271_1.talkMaxDuration)

			if var_274_0 <= arg_271_1.time_ and arg_271_1.time_ < var_274_0 + var_274_8 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_0) / var_274_8

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_0 + var_274_8 and arg_271_1.time_ < var_274_0 + var_274_8 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play1102701068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 1102701068
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play1102701069(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(arg_275_1.actors_["1027ui_story"]) and arg_275_1.var_.characterEffect1027ui_story == nil then
				arg_275_1.var_.characterEffect1027ui_story = arg_275_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_0 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 and not isNil(arg_275_1.actors_["1027ui_story"]) then
				if arg_275_1.var_.characterEffect1027ui_story and not isNil(arg_275_1.actors_["1027ui_story"]) then
					arg_275_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_275_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_275_1.time_ - 0) / var_278_0)
				end
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 and not isNil(arg_275_1.actors_["1027ui_story"]) and arg_275_1.var_.characterEffect1027ui_story then
				arg_275_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_275_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_278_1 = 0
			local var_278_2 = 0.7

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, true)
				arg_275_1.iconController_:SetSelectedState("hero")

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_3 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(1102701068).content)

				arg_275_1.text_.text = var_278_3

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_5 = 28 <= 0 and var_278_2 or var_278_2 * (utf8.len(var_278_3) / 28)

				if (28 <= 0 and var_278_2 or var_278_2 * (utf8.len(var_278_3) / 28)) > 0 and var_278_2 < var_278_5 then
					arg_275_1.talkMaxDuration = var_278_5

					if var_278_5 + var_278_1 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_5 + var_278_1
					end
				end

				arg_275_1.text_.text = var_278_3
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_6 = math.max(var_278_2, arg_275_1.talkMaxDuration)

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_6 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_1) / var_278_6

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_1 + var_278_6 and arg_275_1.time_ < var_278_1 + var_278_6 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play1102701069 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 1102701069
		arg_279_1.duration_ = 9.67

		local var_279_0 = {
			ja = 9.466,
			ko = 9.666,
			zh = 9.666
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
				arg_279_0:Play1102701070(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(arg_279_1.actors_["1027ui_story"]) and arg_279_1.var_.characterEffect1027ui_story == nil then
				arg_279_1.var_.characterEffect1027ui_story = arg_279_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_0 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 and not isNil(arg_279_1.actors_["1027ui_story"]) then
				if arg_279_1.var_.characterEffect1027ui_story and not isNil(arg_279_1.actors_["1027ui_story"]) then
					arg_279_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 and not isNil(arg_279_1.actors_["1027ui_story"]) and arg_279_1.var_.characterEffect1027ui_story then
				arg_279_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action4_2")
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_282_2 = 0
			local var_282_3 = 1

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_2 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_4 = arg_279_1:GetWordFromCfg(1102701069)
				local var_282_5 = arg_279_1:FormatText(var_282_4.content)

				arg_279_1.text_.text = var_282_5

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_7 = 40 <= 0 and var_282_3 or var_282_3 * (utf8.len(var_282_5) / 40)

				if (40 <= 0 and var_282_3 or var_282_3 * (utf8.len(var_282_5) / 40)) > 0 and var_282_3 < var_282_7 then
					arg_279_1.talkMaxDuration = var_282_7

					if var_282_7 + var_282_2 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_7 + var_282_2
					end
				end

				arg_279_1.text_.text = var_282_5
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701069", "story_v_side_new_1102701.awb") ~= 0 then
					local var_282_8 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701069", "story_v_side_new_1102701.awb") / 1000

					if var_282_8 + var_282_2 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_8 + var_282_2
					end

					if var_282_4.prefab_name ~= "" and arg_279_1.actors_[var_282_4.prefab_name] ~= nil then
						local var_282_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_4.prefab_name].transform, "story_v_side_new_1102701", "1102701069", "story_v_side_new_1102701.awb")

						arg_279_1:RecordAudio("1102701069", var_282_9)
						arg_279_1:RecordAudio("1102701069", var_282_9)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701069", "story_v_side_new_1102701.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701069", "story_v_side_new_1102701.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_10 = math.max(var_282_3, arg_279_1.talkMaxDuration)

			if var_282_2 <= arg_279_1.time_ and arg_279_1.time_ < var_282_2 + var_282_10 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_2) / var_282_10

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_2 + var_282_10 and arg_279_1.time_ < var_282_2 + var_282_10 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play1102701070 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 1102701070
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play1102701071(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(arg_283_1.actors_["1027ui_story"]) and arg_283_1.var_.characterEffect1027ui_story == nil then
				arg_283_1.var_.characterEffect1027ui_story = arg_283_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_0 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 and not isNil(arg_283_1.actors_["1027ui_story"]) then
				if arg_283_1.var_.characterEffect1027ui_story and not isNil(arg_283_1.actors_["1027ui_story"]) then
					arg_283_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_283_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_283_1.time_ - 0) / var_286_0)
				end
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 and not isNil(arg_283_1.actors_["1027ui_story"]) and arg_283_1.var_.characterEffect1027ui_story then
				arg_283_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_283_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:AudioAction("play", "effect", "se_story", "se_story_communication", "")
			end

			local var_286_2 = 0
			local var_286_3 = 0.725

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_2 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, false)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_4 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(1102701070).content)

				arg_283_1.text_.text = var_286_4

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_6 = 29 <= 0 and var_286_3 or var_286_3 * (utf8.len(var_286_4) / 29)

				if (29 <= 0 and var_286_3 or var_286_3 * (utf8.len(var_286_4) / 29)) > 0 and var_286_3 < var_286_6 then
					arg_283_1.talkMaxDuration = var_286_6

					if var_286_6 + var_286_2 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_6 + var_286_2
					end
				end

				arg_283_1.text_.text = var_286_4
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_7 = math.max(var_286_3, arg_283_1.talkMaxDuration)

			if var_286_2 <= arg_283_1.time_ and arg_283_1.time_ < var_286_2 + var_286_7 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_2) / var_286_7

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_2 + var_286_7 and arg_283_1.time_ < var_286_2 + var_286_7 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play1102701071 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 1102701071
		arg_287_1.duration_ = 4.83

		local var_287_0 = {
			ja = 4.833,
			ko = 2.966,
			zh = 2.966
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
				arg_287_0:Play1102701072(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.var_.moveOldPos1027ui_story = arg_287_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_290_0 = 0.001

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 then
				arg_287_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_287_1.time_ - 0) / var_290_0)
				arg_287_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_287_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1027ui_story"].transform.position).z)
				arg_287_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_287_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_287_1.actors_["1027ui_story"].transform.localEulerAngles = arg_287_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 then
				arg_287_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, -0.81, -5.8)
				arg_287_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_287_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1027ui_story"].transform.position).z)
				arg_287_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_287_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_287_1.actors_["1027ui_story"].transform.localEulerAngles = arg_287_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_290_1 = arg_287_1.actors_["1027ui_story"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_1) and arg_287_1.var_.characterEffect1027ui_story == nil then
				arg_287_1.var_.characterEffect1027ui_story = var_290_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_2 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_2 and not isNil(var_290_1) then
				if arg_287_1.var_.characterEffect1027ui_story and not isNil(var_290_1) then
					arg_287_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= 0 + var_290_2 and arg_287_1.time_ < 0 + var_290_2 + arg_290_0 and not isNil(var_290_1) and arg_287_1.var_.characterEffect1027ui_story then
				arg_287_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_290_4 = 0
			local var_290_5 = 0.35

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_4 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_6 = arg_287_1:GetWordFromCfg(1102701071)
				local var_290_7 = arg_287_1:FormatText(var_290_6.content)

				arg_287_1.text_.text = var_290_7

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_9 = 14 <= 0 and var_290_5 or var_290_5 * (utf8.len(var_290_7) / 14)

				if (14 <= 0 and var_290_5 or var_290_5 * (utf8.len(var_290_7) / 14)) > 0 and var_290_5 < var_290_9 then
					arg_287_1.talkMaxDuration = var_290_9

					if var_290_9 + var_290_4 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_9 + var_290_4
					end
				end

				arg_287_1.text_.text = var_290_7
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701071", "story_v_side_new_1102701.awb") ~= 0 then
					local var_290_10 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701071", "story_v_side_new_1102701.awb") / 1000

					if var_290_10 + var_290_4 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_10 + var_290_4
					end

					if var_290_6.prefab_name ~= "" and arg_287_1.actors_[var_290_6.prefab_name] ~= nil then
						local var_290_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_6.prefab_name].transform, "story_v_side_new_1102701", "1102701071", "story_v_side_new_1102701.awb")

						arg_287_1:RecordAudio("1102701071", var_290_11)
						arg_287_1:RecordAudio("1102701071", var_290_11)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701071", "story_v_side_new_1102701.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701071", "story_v_side_new_1102701.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_12 = math.max(var_290_5, arg_287_1.talkMaxDuration)

			if var_290_4 <= arg_287_1.time_ and arg_287_1.time_ < var_290_4 + var_290_12 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_4) / var_290_12

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_4 + var_290_12 and arg_287_1.time_ < var_290_4 + var_290_12 + arg_290_0 then
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
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play1102701072 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 1102701072
		arg_291_1.duration_ = 8.6

		local var_291_0 = {
			ja = 8.6,
			ko = 4.433,
			zh = 4.433
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
				arg_291_0:Play1102701073(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(arg_291_1.actors_["1027ui_story"]) and arg_291_1.var_.characterEffect1027ui_story == nil then
				arg_291_1.var_.characterEffect1027ui_story = arg_291_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_0 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 and not isNil(arg_291_1.actors_["1027ui_story"]) then
				if arg_291_1.var_.characterEffect1027ui_story and not isNil(arg_291_1.actors_["1027ui_story"]) then
					arg_291_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 and not isNil(arg_291_1.actors_["1027ui_story"]) and arg_291_1.var_.characterEffect1027ui_story then
				arg_291_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_2")
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_294_2 = 0
			local var_294_3 = 0.475

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_2 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_4 = arg_291_1:GetWordFromCfg(1102701072)
				local var_294_5 = arg_291_1:FormatText(var_294_4.content)

				arg_291_1.text_.text = var_294_5

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_7 = 19 <= 0 and var_294_3 or var_294_3 * (utf8.len(var_294_5) / 19)

				if (19 <= 0 and var_294_3 or var_294_3 * (utf8.len(var_294_5) / 19)) > 0 and var_294_3 < var_294_7 then
					arg_291_1.talkMaxDuration = var_294_7

					if var_294_7 + var_294_2 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_7 + var_294_2
					end
				end

				arg_291_1.text_.text = var_294_5
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701072", "story_v_side_new_1102701.awb") ~= 0 then
					local var_294_8 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701072", "story_v_side_new_1102701.awb") / 1000

					if var_294_8 + var_294_2 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_8 + var_294_2
					end

					if var_294_4.prefab_name ~= "" and arg_291_1.actors_[var_294_4.prefab_name] ~= nil then
						local var_294_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_4.prefab_name].transform, "story_v_side_new_1102701", "1102701072", "story_v_side_new_1102701.awb")

						arg_291_1:RecordAudio("1102701072", var_294_9)
						arg_291_1:RecordAudio("1102701072", var_294_9)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701072", "story_v_side_new_1102701.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701072", "story_v_side_new_1102701.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_10 = math.max(var_294_3, arg_291_1.talkMaxDuration)

			if var_294_2 <= arg_291_1.time_ and arg_291_1.time_ < var_294_2 + var_294_10 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_2) / var_294_10

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_2 + var_294_10 and arg_291_1.time_ < var_294_2 + var_294_10 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play1102701073 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 1102701073
		arg_295_1.duration_ = 1.57

		local var_295_0 = {
			ja = 0.999999999999,
			ko = 1.566,
			zh = 1.566
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
				arg_295_0:Play1102701074(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(arg_295_1.actors_["1027ui_story"]) and arg_295_1.var_.characterEffect1027ui_story == nil then
				arg_295_1.var_.characterEffect1027ui_story = arg_295_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_0 = 0.200000002980232

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 and not isNil(arg_295_1.actors_["1027ui_story"]) then
				if arg_295_1.var_.characterEffect1027ui_story and not isNil(arg_295_1.actors_["1027ui_story"]) then
					arg_295_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_295_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_295_1.time_ - 0) / var_298_0)
				end
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 and not isNil(arg_295_1.actors_["1027ui_story"]) and arg_295_1.var_.characterEffect1027ui_story then
				arg_295_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_295_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:AudioAction("play", "effect", "se_story_side_1027", "se_story_side_1027_dog5", "")
			end

			local var_298_2 = 0
			local var_298_3 = 0.1

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_2 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080_1")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_4 = arg_295_1:GetWordFromCfg(1102701073)
				local var_298_5 = arg_295_1:FormatText(var_298_4.content)

				arg_295_1.text_.text = var_298_5

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_7 = 4 <= 0 and var_298_3 or var_298_3 * (utf8.len(var_298_5) / 4)

				if (4 <= 0 and var_298_3 or var_298_3 * (utf8.len(var_298_5) / 4)) > 0 and var_298_3 < var_298_7 then
					arg_295_1.talkMaxDuration = var_298_7

					if var_298_7 + var_298_2 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_7 + var_298_2
					end
				end

				arg_295_1.text_.text = var_298_5
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701073", "story_v_side_new_1102701.awb") ~= 0 then
					local var_298_8 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701073", "story_v_side_new_1102701.awb") / 1000

					if var_298_8 + var_298_2 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_8 + var_298_2
					end

					if var_298_4.prefab_name ~= "" and arg_295_1.actors_[var_298_4.prefab_name] ~= nil then
						local var_298_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_4.prefab_name].transform, "story_v_side_new_1102701", "1102701073", "story_v_side_new_1102701.awb")

						arg_295_1:RecordAudio("1102701073", var_298_9)
						arg_295_1:RecordAudio("1102701073", var_298_9)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701073", "story_v_side_new_1102701.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701073", "story_v_side_new_1102701.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_10 = math.max(var_298_3, arg_295_1.talkMaxDuration)

			if var_298_2 <= arg_295_1.time_ and arg_295_1.time_ < var_298_2 + var_298_10 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_2) / var_298_10

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_2 + var_298_10 and arg_295_1.time_ < var_298_2 + var_298_10 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play1102701074 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 1102701074
		arg_299_1.duration_ = 4.6

		local var_299_0 = {
			ja = 3.1,
			ko = 4.6,
			zh = 4.6
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
				arg_299_0:Play1102701075(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(arg_299_1.actors_["1027ui_story"]) and arg_299_1.var_.characterEffect1027ui_story == nil then
				arg_299_1.var_.characterEffect1027ui_story = arg_299_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_0 = 0.200000002980232

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_0 and not isNil(arg_299_1.actors_["1027ui_story"]) then
				if arg_299_1.var_.characterEffect1027ui_story and not isNil(arg_299_1.actors_["1027ui_story"]) then
					arg_299_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= 0 + var_302_0 and arg_299_1.time_ < 0 + var_302_0 + arg_302_0 and not isNil(arg_299_1.actors_["1027ui_story"]) and arg_299_1.var_.characterEffect1027ui_story then
				arg_299_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_302_2 = 0
			local var_302_3 = 0.4

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_2 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_4 = arg_299_1:GetWordFromCfg(1102701074)
				local var_302_5 = arg_299_1:FormatText(var_302_4.content)

				arg_299_1.text_.text = var_302_5

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_7 = 16 <= 0 and var_302_3 or var_302_3 * (utf8.len(var_302_5) / 16)

				if (16 <= 0 and var_302_3 or var_302_3 * (utf8.len(var_302_5) / 16)) > 0 and var_302_3 < var_302_7 then
					arg_299_1.talkMaxDuration = var_302_7

					if var_302_7 + var_302_2 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_7 + var_302_2
					end
				end

				arg_299_1.text_.text = var_302_5
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701074", "story_v_side_new_1102701.awb") ~= 0 then
					local var_302_8 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701074", "story_v_side_new_1102701.awb") / 1000

					if var_302_8 + var_302_2 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_8 + var_302_2
					end

					if var_302_4.prefab_name ~= "" and arg_299_1.actors_[var_302_4.prefab_name] ~= nil then
						local var_302_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_4.prefab_name].transform, "story_v_side_new_1102701", "1102701074", "story_v_side_new_1102701.awb")

						arg_299_1:RecordAudio("1102701074", var_302_9)
						arg_299_1:RecordAudio("1102701074", var_302_9)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701074", "story_v_side_new_1102701.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701074", "story_v_side_new_1102701.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_10 = math.max(var_302_3, arg_299_1.talkMaxDuration)

			if var_302_2 <= arg_299_1.time_ and arg_299_1.time_ < var_302_2 + var_302_10 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_2) / var_302_10

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_2 + var_302_10 and arg_299_1.time_ < var_302_2 + var_302_10 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play1102701075 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 1102701075
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play1102701076(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(arg_303_1.actors_["1027ui_story"]) and arg_303_1.var_.characterEffect1027ui_story == nil then
				arg_303_1.var_.characterEffect1027ui_story = arg_303_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_0 = 0.200000002980232

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 and not isNil(arg_303_1.actors_["1027ui_story"]) then
				if arg_303_1.var_.characterEffect1027ui_story and not isNil(arg_303_1.actors_["1027ui_story"]) then
					arg_303_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_303_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_303_1.time_ - 0) / var_306_0)
				end
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 and not isNil(arg_303_1.actors_["1027ui_story"]) and arg_303_1.var_.characterEffect1027ui_story then
				arg_303_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_303_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_306_1 = 0
			local var_306_2 = 0.65

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

				local var_306_3 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(1102701075).content)

				arg_303_1.text_.text = var_306_3

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_5 = 26 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_3) / 26)

				if (26 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_3) / 26)) > 0 and var_306_2 < var_306_5 then
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

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play1102701076 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 1102701076
		arg_307_1.duration_ = 4.07

		local var_307_0 = {
			ja = 4.066,
			ko = 2.3,
			zh = 2.3
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
				arg_307_0:Play1102701077(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(arg_307_1.actors_["1027ui_story"]) and arg_307_1.var_.characterEffect1027ui_story == nil then
				arg_307_1.var_.characterEffect1027ui_story = arg_307_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_0 = 0.200000002980232

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 and not isNil(arg_307_1.actors_["1027ui_story"]) then
				if arg_307_1.var_.characterEffect1027ui_story and not isNil(arg_307_1.actors_["1027ui_story"]) then
					arg_307_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 and not isNil(arg_307_1.actors_["1027ui_story"]) and arg_307_1.var_.characterEffect1027ui_story then
				arg_307_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_310_2 = 0
			local var_310_3 = 0.275

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_2 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_4 = arg_307_1:GetWordFromCfg(1102701076)
				local var_310_5 = arg_307_1:FormatText(var_310_4.content)

				arg_307_1.text_.text = var_310_5

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_7 = 11 <= 0 and var_310_3 or var_310_3 * (utf8.len(var_310_5) / 11)

				if (11 <= 0 and var_310_3 or var_310_3 * (utf8.len(var_310_5) / 11)) > 0 and var_310_3 < var_310_7 then
					arg_307_1.talkMaxDuration = var_310_7

					if var_310_7 + var_310_2 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_7 + var_310_2
					end
				end

				arg_307_1.text_.text = var_310_5
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701076", "story_v_side_new_1102701.awb") ~= 0 then
					local var_310_8 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701076", "story_v_side_new_1102701.awb") / 1000

					if var_310_8 + var_310_2 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_8 + var_310_2
					end

					if var_310_4.prefab_name ~= "" and arg_307_1.actors_[var_310_4.prefab_name] ~= nil then
						local var_310_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_4.prefab_name].transform, "story_v_side_new_1102701", "1102701076", "story_v_side_new_1102701.awb")

						arg_307_1:RecordAudio("1102701076", var_310_9)
						arg_307_1:RecordAudio("1102701076", var_310_9)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701076", "story_v_side_new_1102701.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701076", "story_v_side_new_1102701.awb")
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
	Play1102701077 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 1102701077
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play1102701078(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(arg_311_1.actors_["1027ui_story"]) and arg_311_1.var_.characterEffect1027ui_story == nil then
				arg_311_1.var_.characterEffect1027ui_story = arg_311_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_0 = 0.200000002980232

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 and not isNil(arg_311_1.actors_["1027ui_story"]) then
				if arg_311_1.var_.characterEffect1027ui_story and not isNil(arg_311_1.actors_["1027ui_story"]) then
					arg_311_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_311_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_311_1.time_ - 0) / var_314_0)
				end
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 and not isNil(arg_311_1.actors_["1027ui_story"]) and arg_311_1.var_.characterEffect1027ui_story then
				arg_311_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_311_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_314_1 = 0
			local var_314_2 = 0.7

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, true)
				arg_311_1.iconController_:SetSelectedState("hero")

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_3 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(1102701077).content)

				arg_311_1.text_.text = var_314_3

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_5 = 28 <= 0 and var_314_2 or var_314_2 * (utf8.len(var_314_3) / 28)

				if (28 <= 0 and var_314_2 or var_314_2 * (utf8.len(var_314_3) / 28)) > 0 and var_314_2 < var_314_5 then
					arg_311_1.talkMaxDuration = var_314_5

					if var_314_5 + var_314_1 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_5 + var_314_1
					end
				end

				arg_311_1.text_.text = var_314_3
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_6 = math.max(var_314_2, arg_311_1.talkMaxDuration)

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_6 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_1) / var_314_6

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_1 + var_314_6 and arg_311_1.time_ < var_314_1 + var_314_6 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play1102701078 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 1102701078
		arg_315_1.duration_ = 6.57

		local var_315_0 = {
			ja = 6.566,
			ko = 4.866,
			zh = 4.866
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
				arg_315_0:Play1102701079(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(arg_315_1.actors_["1027ui_story"]) and arg_315_1.var_.characterEffect1027ui_story == nil then
				arg_315_1.var_.characterEffect1027ui_story = arg_315_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_0 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 and not isNil(arg_315_1.actors_["1027ui_story"]) then
				if arg_315_1.var_.characterEffect1027ui_story and not isNil(arg_315_1.actors_["1027ui_story"]) then
					arg_315_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 and not isNil(arg_315_1.actors_["1027ui_story"]) and arg_315_1.var_.characterEffect1027ui_story then
				arg_315_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_2")
			end

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_318_2 = 0
			local var_318_3 = 0.45

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_2 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_4 = arg_315_1:GetWordFromCfg(1102701078)
				local var_318_5 = arg_315_1:FormatText(var_318_4.content)

				arg_315_1.text_.text = var_318_5

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_7 = 18 <= 0 and var_318_3 or var_318_3 * (utf8.len(var_318_5) / 18)

				if (18 <= 0 and var_318_3 or var_318_3 * (utf8.len(var_318_5) / 18)) > 0 and var_318_3 < var_318_7 then
					arg_315_1.talkMaxDuration = var_318_7

					if var_318_7 + var_318_2 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_7 + var_318_2
					end
				end

				arg_315_1.text_.text = var_318_5
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701078", "story_v_side_new_1102701.awb") ~= 0 then
					local var_318_8 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701078", "story_v_side_new_1102701.awb") / 1000

					if var_318_8 + var_318_2 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_8 + var_318_2
					end

					if var_318_4.prefab_name ~= "" and arg_315_1.actors_[var_318_4.prefab_name] ~= nil then
						local var_318_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_4.prefab_name].transform, "story_v_side_new_1102701", "1102701078", "story_v_side_new_1102701.awb")

						arg_315_1:RecordAudio("1102701078", var_318_9)
						arg_315_1:RecordAudio("1102701078", var_318_9)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701078", "story_v_side_new_1102701.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701078", "story_v_side_new_1102701.awb")
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
	Play1102701079 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 1102701079
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play1102701080(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(arg_319_1.actors_["1027ui_story"]) and arg_319_1.var_.characterEffect1027ui_story == nil then
				arg_319_1.var_.characterEffect1027ui_story = arg_319_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_0 = 0.200000002980232

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_0 and not isNil(arg_319_1.actors_["1027ui_story"]) then
				if arg_319_1.var_.characterEffect1027ui_story and not isNil(arg_319_1.actors_["1027ui_story"]) then
					arg_319_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_319_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_319_1.time_ - 0) / var_322_0)
				end
			end

			if arg_319_1.time_ >= 0 + var_322_0 and arg_319_1.time_ < 0 + var_322_0 + arg_322_0 and not isNil(arg_319_1.actors_["1027ui_story"]) and arg_319_1.var_.characterEffect1027ui_story then
				arg_319_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_319_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_322_1 = 0
			local var_322_2 = 0.275

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, true)
				arg_319_1.iconController_:SetSelectedState("hero")

				arg_319_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_319_1.callingController_:SetSelectedState("normal")

				arg_319_1.keyicon_.color = Color.New(1, 1, 1)
				arg_319_1.icon_.color = Color.New(1, 1, 1)

				local var_322_3 = arg_319_1:FormatText(arg_319_1:GetWordFromCfg(1102701079).content)

				arg_319_1.text_.text = var_322_3

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_5 = 11 <= 0 and var_322_2 or var_322_2 * (utf8.len(var_322_3) / 11)

				if (11 <= 0 and var_322_2 or var_322_2 * (utf8.len(var_322_3) / 11)) > 0 and var_322_2 < var_322_5 then
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
	Play1102701080 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 1102701080
		arg_323_1.duration_ = 3.77

		local var_323_0 = {
			ja = 3.766,
			ko = 2.566,
			zh = 2.566
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
				arg_323_0:Play1102701081(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(arg_323_1.actors_["1027ui_story"]) and arg_323_1.var_.characterEffect1027ui_story == nil then
				arg_323_1.var_.characterEffect1027ui_story = arg_323_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_0 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 and not isNil(arg_323_1.actors_["1027ui_story"]) then
				if arg_323_1.var_.characterEffect1027ui_story and not isNil(arg_323_1.actors_["1027ui_story"]) then
					arg_323_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 and not isNil(arg_323_1.actors_["1027ui_story"]) and arg_323_1.var_.characterEffect1027ui_story then
				arg_323_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action6_1")
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_326_2 = 0
			local var_326_3 = 0.35

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_2 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_4 = arg_323_1:GetWordFromCfg(1102701080)
				local var_326_5 = arg_323_1:FormatText(var_326_4.content)

				arg_323_1.text_.text = var_326_5

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_7 = 14 <= 0 and var_326_3 or var_326_3 * (utf8.len(var_326_5) / 14)

				if (14 <= 0 and var_326_3 or var_326_3 * (utf8.len(var_326_5) / 14)) > 0 and var_326_3 < var_326_7 then
					arg_323_1.talkMaxDuration = var_326_7

					if var_326_7 + var_326_2 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_7 + var_326_2
					end
				end

				arg_323_1.text_.text = var_326_5
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701080", "story_v_side_new_1102701.awb") ~= 0 then
					local var_326_8 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701080", "story_v_side_new_1102701.awb") / 1000

					if var_326_8 + var_326_2 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_8 + var_326_2
					end

					if var_326_4.prefab_name ~= "" and arg_323_1.actors_[var_326_4.prefab_name] ~= nil then
						local var_326_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_4.prefab_name].transform, "story_v_side_new_1102701", "1102701080", "story_v_side_new_1102701.awb")

						arg_323_1:RecordAudio("1102701080", var_326_9)
						arg_323_1:RecordAudio("1102701080", var_326_9)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701080", "story_v_side_new_1102701.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701080", "story_v_side_new_1102701.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_10 = math.max(var_326_3, arg_323_1.talkMaxDuration)

			if var_326_2 <= arg_323_1.time_ and arg_323_1.time_ < var_326_2 + var_326_10 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_2) / var_326_10

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_2 + var_326_10 and arg_323_1.time_ < var_326_2 + var_326_10 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play1102701081 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 1102701081
		arg_327_1.duration_ = 9

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play1102701082(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 1.96599999815226 < arg_327_1.time_ and arg_327_1.time_ <= 1.96599999815226 + arg_330_0 then
				arg_327_1.var_.moveOldPos1027ui_story = arg_327_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_330_0 = 0.001

			if 1.96599999815226 <= arg_327_1.time_ and arg_327_1.time_ < 1.96599999815226 + var_330_0 then
				arg_327_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_327_1.time_ - 1.96599999815226) / var_330_0)
				arg_327_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_327_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["1027ui_story"].transform.position).z)
				arg_327_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_327_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_327_1.actors_["1027ui_story"].transform.localEulerAngles = arg_327_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_327_1.time_ >= 1.96599999815226 + var_330_0 and arg_327_1.time_ < 1.96599999815226 + var_330_0 + arg_330_0 then
				arg_327_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_327_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_327_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["1027ui_story"].transform.position).z)
				arg_327_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_327_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_327_1.actors_["1027ui_story"].transform.localEulerAngles = arg_327_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_330_1 = arg_327_1.actors_["1027ui_story"]

			if 1.96599999815226 < arg_327_1.time_ and arg_327_1.time_ <= 1.96599999815226 + arg_330_0 and not isNil(var_330_1) and arg_327_1.var_.characterEffect1027ui_story == nil then
				arg_327_1.var_.characterEffect1027ui_story = var_330_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_2 = 0.034000001847744

			if 1.96599999815226 <= arg_327_1.time_ and arg_327_1.time_ < 1.96599999815226 + var_330_2 and not isNil(var_330_1) then
				if arg_327_1.var_.characterEffect1027ui_story and not isNil(var_330_1) then
					arg_327_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_327_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_327_1.time_ - 1.96599999815226) / var_330_2)
				end
			end

			if arg_327_1.time_ >= 1.96599999815226 + var_330_2 and arg_327_1.time_ < 1.96599999815226 + var_330_2 + arg_330_0 and not isNil(var_330_1) and arg_327_1.var_.characterEffect1027ui_story then
				arg_327_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_327_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_330_3 = "ST10"

			if arg_327_1.bgs_.ST10 == nil then
				local var_330_4 = Object.Instantiate(arg_327_1.paintGo_)

				var_330_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_330_3)
				var_330_4.name = var_330_3
				var_330_4.transform.parent = arg_327_1.stage_.transform
				var_330_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_327_1.bgs_[var_330_3] = var_330_4
			end

			if 2 < arg_327_1.time_ and arg_327_1.time_ <= 2 + arg_330_0 then
				local var_330_5 = arg_327_1.bgs_.ST10

				arg_327_1.bgs_.ST10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_330_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_330_6 = var_330_5:GetComponent("SpriteRenderer")

				if var_330_6 and var_330_6.sprite then
					local var_330_7 = 2 * (var_330_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_330_5.transform.localScale = Vector3.New(var_330_7 / var_330_6.sprite.bounds.size.y < var_330_7 * manager.ui.mainCameraCom_.aspect / var_330_6.sprite.bounds.size.x and var_330_7 * manager.ui.mainCameraCom_.aspect / var_330_6.sprite.bounds.size.x or var_330_7 / var_330_6.sprite.bounds.size.y, var_330_7 / var_330_6.sprite.bounds.size.y < var_330_7 * manager.ui.mainCameraCom_.aspect / var_330_6.sprite.bounds.size.x and var_330_7 * manager.ui.mainCameraCom_.aspect / var_330_6.sprite.bounds.size.x or var_330_7 / var_330_6.sprite.bounds.size.y, 0)
				end

				for iter_330_0, iter_330_1 in pairs(arg_327_1.bgs_) do
					if iter_330_0 ~= "ST10" then
						iter_330_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_330_8 = 0

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_8 + arg_330_0 then
				arg_327_1.mask_.enabled = true
				arg_327_1.mask_.raycastTarget = true

				arg_327_1:SetGaussion(false)
			end

			local var_330_9 = 2

			if var_330_8 <= arg_327_1.time_ and arg_327_1.time_ < var_330_8 + var_330_9 then
				local var_330_10 = Color.New(0, 0, 0)

				var_330_10.a = Mathf.Lerp(0, 1, (arg_327_1.time_ - var_330_8) / var_330_9)
				arg_327_1.mask_.color = var_330_10
			end

			if arg_327_1.time_ >= var_330_8 + var_330_9 and arg_327_1.time_ < var_330_8 + var_330_9 + arg_330_0 then
				local var_330_11 = Color.New(0, 0, 0)

				var_330_11.a = 1
				arg_327_1.mask_.color = var_330_11
			end

			local var_330_12 = 2

			if 2 < arg_327_1.time_ and arg_327_1.time_ <= var_330_12 + arg_330_0 then
				arg_327_1.mask_.enabled = true
				arg_327_1.mask_.raycastTarget = true

				arg_327_1:SetGaussion(false)
			end

			local var_330_13 = 2

			if var_330_12 <= arg_327_1.time_ and arg_327_1.time_ < var_330_12 + var_330_13 then
				local var_330_14 = Color.New(0, 0, 0)

				var_330_14.a = Mathf.Lerp(1, 0, (arg_327_1.time_ - var_330_12) / var_330_13)
				arg_327_1.mask_.color = var_330_14
			end

			if arg_327_1.time_ >= var_330_12 + var_330_13 and arg_327_1.time_ < var_330_12 + var_330_13 + arg_330_0 then
				local var_330_15 = Color.New(0, 0, 0)

				arg_327_1.mask_.enabled = false
				var_330_15.a = 0
				arg_327_1.mask_.color = var_330_15
			end

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1:AudioAction("stop", "effect", "se_story_side_1080", "se_story_1080_parkloop", "")
			end

			if arg_327_1.frameCnt_ <= 1 then
				arg_327_1.dialog_:SetActive(false)
			end

			local var_330_17 = 4
			local var_330_18 = 0.6

			if 4 < arg_327_1.time_ and arg_327_1.time_ <= var_330_17 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0

				arg_327_1.dialog_:SetActive(true)

				arg_327_1.dialogCg_.alpha = 0

				local var_330_19 = LeanTween.value(arg_327_1.dialog_, 0, 1, 0.3)

				var_330_19:setOnUpdate(LuaHelper.FloatAction(function(arg_331_0)
					arg_327_1.dialogCg_.alpha = arg_331_0
				end))
				var_330_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_327_1.dialog_)
					var_330_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_327_1.duration_ = arg_327_1.duration_ + 0.3

				SetActive(arg_327_1.leftNameGo_, false)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_20 = arg_327_1:FormatText(arg_327_1:GetWordFromCfg(1102701081).content)

				arg_327_1.text_.text = var_330_20

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_22 = 24 <= 0 and var_330_18 or var_330_18 * (utf8.len(var_330_20) / 24)

				if (24 <= 0 and var_330_18 or var_330_18 * (utf8.len(var_330_20) / 24)) > 0 and var_330_18 < var_330_22 then
					arg_327_1.talkMaxDuration = var_330_22
					var_330_17 = var_330_17 + 0.3

					if var_330_22 + var_330_17 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_22 + var_330_17
					end
				end

				arg_327_1.text_.text = var_330_20
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_23 = var_330_17 + 0.3
			local var_330_24 = math.max(var_330_18, arg_327_1.talkMaxDuration)

			if var_330_17 + 0.3 <= arg_327_1.time_ and arg_327_1.time_ < var_330_23 + var_330_24 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_23) / var_330_24

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_23 + var_330_24 and arg_327_1.time_ < var_330_23 + var_330_24 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_327_1:InitPlayNodeList()
	end,
	Play1102701082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 1102701082
		arg_333_1.duration_ = 9.8

		local var_333_0 = {
			ja = 9.8,
			ko = 9.7,
			zh = 9.7
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play1102701083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.var_.moveOldPos1027ui_story = arg_333_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_336_0 = 0.001

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 then
				arg_333_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_333_1.time_ - 0) / var_336_0)
				arg_333_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_333_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1027ui_story"].transform.position).z)
				arg_333_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_333_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_333_1.actors_["1027ui_story"].transform.localEulerAngles = arg_333_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 then
				arg_333_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, -0.81, -5.8)
				arg_333_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_333_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1027ui_story"].transform.position).z)
				arg_333_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_333_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_333_1.actors_["1027ui_story"].transform.localEulerAngles = arg_333_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_336_1 = arg_333_1.actors_["1027ui_story"]

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(var_336_1) and arg_333_1.var_.characterEffect1027ui_story == nil then
				arg_333_1.var_.characterEffect1027ui_story = var_336_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_2 = 0.200000002980232

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_2 and not isNil(var_336_1) then
				if arg_333_1.var_.characterEffect1027ui_story and not isNil(var_336_1) then
					arg_333_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= 0 + var_336_2 and arg_333_1.time_ < 0 + var_336_2 + arg_336_0 and not isNil(var_336_1) and arg_333_1.var_.characterEffect1027ui_story then
				arg_333_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_336_4 = 0
			local var_336_5 = 0.95

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_4 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_6 = arg_333_1:GetWordFromCfg(1102701082)
				local var_336_7 = arg_333_1:FormatText(var_336_6.content)

				arg_333_1.text_.text = var_336_7

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_9 = 38 <= 0 and var_336_5 or var_336_5 * (utf8.len(var_336_7) / 38)

				if (38 <= 0 and var_336_5 or var_336_5 * (utf8.len(var_336_7) / 38)) > 0 and var_336_5 < var_336_9 then
					arg_333_1.talkMaxDuration = var_336_9

					if var_336_9 + var_336_4 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_9 + var_336_4
					end
				end

				arg_333_1.text_.text = var_336_7
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701082", "story_v_side_new_1102701.awb") ~= 0 then
					local var_336_10 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701082", "story_v_side_new_1102701.awb") / 1000

					if var_336_10 + var_336_4 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_10 + var_336_4
					end

					if var_336_6.prefab_name ~= "" and arg_333_1.actors_[var_336_6.prefab_name] ~= nil then
						local var_336_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_6.prefab_name].transform, "story_v_side_new_1102701", "1102701082", "story_v_side_new_1102701.awb")

						arg_333_1:RecordAudio("1102701082", var_336_11)
						arg_333_1:RecordAudio("1102701082", var_336_11)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701082", "story_v_side_new_1102701.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701082", "story_v_side_new_1102701.awb")
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

		arg_333_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_333_1:InitPlayNodeList()
	end,
	Play1102701083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 1102701083
		arg_337_1.duration_ = 1.5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play1102701084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(arg_337_1.actors_["1027ui_story"]) and arg_337_1.var_.characterEffect1027ui_story == nil then
				arg_337_1.var_.characterEffect1027ui_story = arg_337_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_0 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 and not isNil(arg_337_1.actors_["1027ui_story"]) then
				if arg_337_1.var_.characterEffect1027ui_story and not isNil(arg_337_1.actors_["1027ui_story"]) then
					arg_337_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_337_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_337_1.time_ - 0) / var_340_0)
				end
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 and not isNil(arg_337_1.actors_["1027ui_story"]) and arg_337_1.var_.characterEffect1027ui_story then
				arg_337_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_337_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_340_1 = 0
			local var_340_2 = 0.125

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[138].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_3 = arg_337_1:GetWordFromCfg(1102701083)
				local var_340_4 = arg_337_1:FormatText(var_340_3.content)

				arg_337_1.text_.text = var_340_4

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_6 = 5 <= 0 and var_340_2 or var_340_2 * (utf8.len(var_340_4) / 5)

				if (5 <= 0 and var_340_2 or var_340_2 * (utf8.len(var_340_4) / 5)) > 0 and var_340_2 < var_340_6 then
					arg_337_1.talkMaxDuration = var_340_6

					if var_340_6 + var_340_1 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_6 + var_340_1
					end
				end

				arg_337_1.text_.text = var_340_4
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701083", "story_v_side_new_1102701.awb") ~= 0 then
					local var_340_7 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701083", "story_v_side_new_1102701.awb") / 1000

					if var_340_7 + var_340_1 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_7 + var_340_1
					end

					if var_340_3.prefab_name ~= "" and arg_337_1.actors_[var_340_3.prefab_name] ~= nil then
						local var_340_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_3.prefab_name].transform, "story_v_side_new_1102701", "1102701083", "story_v_side_new_1102701.awb")

						arg_337_1:RecordAudio("1102701083", var_340_8)
						arg_337_1:RecordAudio("1102701083", var_340_8)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701083", "story_v_side_new_1102701.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701083", "story_v_side_new_1102701.awb")
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
	Play1102701084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 1102701084
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play1102701085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 0.8

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, true)
				arg_341_1.iconController_:SetSelectedState("hero")

				arg_341_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_341_1.callingController_:SetSelectedState("normal")

				arg_341_1.keyicon_.color = Color.New(1, 1, 1)
				arg_341_1.icon_.color = Color.New(1, 1, 1)

				local var_344_1 = arg_341_1:FormatText(arg_341_1:GetWordFromCfg(1102701084).content)

				arg_341_1.text_.text = var_344_1

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_3 = 32 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_1) / 32)

				if (32 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_1) / 32)) > 0 and var_344_0 < var_344_3 then
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
	Play1102701085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 1102701085
		arg_345_1.duration_ = 7.73

		local var_345_0 = {
			ja = 6.433,
			ko = 7.733,
			zh = 7.733
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
				arg_345_0:Play1102701086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(arg_345_1.actors_["1027ui_story"]) and arg_345_1.var_.characterEffect1027ui_story == nil then
				arg_345_1.var_.characterEffect1027ui_story = arg_345_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_0 = 0.200000002980232

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 and not isNil(arg_345_1.actors_["1027ui_story"]) then
				if arg_345_1.var_.characterEffect1027ui_story and not isNil(arg_345_1.actors_["1027ui_story"]) then
					arg_345_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 and not isNil(arg_345_1.actors_["1027ui_story"]) and arg_345_1.var_.characterEffect1027ui_story then
				arg_345_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_2")
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_348_2 = 0
			local var_348_3 = 0.75

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_2 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_4 = arg_345_1:GetWordFromCfg(1102701085)
				local var_348_5 = arg_345_1:FormatText(var_348_4.content)

				arg_345_1.text_.text = var_348_5

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_7 = 30 <= 0 and var_348_3 or var_348_3 * (utf8.len(var_348_5) / 30)

				if (30 <= 0 and var_348_3 or var_348_3 * (utf8.len(var_348_5) / 30)) > 0 and var_348_3 < var_348_7 then
					arg_345_1.talkMaxDuration = var_348_7

					if var_348_7 + var_348_2 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_7 + var_348_2
					end
				end

				arg_345_1.text_.text = var_348_5
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701085", "story_v_side_new_1102701.awb") ~= 0 then
					local var_348_8 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701085", "story_v_side_new_1102701.awb") / 1000

					if var_348_8 + var_348_2 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_8 + var_348_2
					end

					if var_348_4.prefab_name ~= "" and arg_345_1.actors_[var_348_4.prefab_name] ~= nil then
						local var_348_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_4.prefab_name].transform, "story_v_side_new_1102701", "1102701085", "story_v_side_new_1102701.awb")

						arg_345_1:RecordAudio("1102701085", var_348_9)
						arg_345_1:RecordAudio("1102701085", var_348_9)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701085", "story_v_side_new_1102701.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701085", "story_v_side_new_1102701.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_10 = math.max(var_348_3, arg_345_1.talkMaxDuration)

			if var_348_2 <= arg_345_1.time_ and arg_345_1.time_ < var_348_2 + var_348_10 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_2) / var_348_10

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_2 + var_348_10 and arg_345_1.time_ < var_348_2 + var_348_10 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play1102701086 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 1102701086
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play1102701087(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(arg_349_1.actors_["1027ui_story"]) and arg_349_1.var_.characterEffect1027ui_story == nil then
				arg_349_1.var_.characterEffect1027ui_story = arg_349_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_0 = 0.200000002980232

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 and not isNil(arg_349_1.actors_["1027ui_story"]) then
				if arg_349_1.var_.characterEffect1027ui_story and not isNil(arg_349_1.actors_["1027ui_story"]) then
					arg_349_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_349_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_349_1.time_ - 0) / var_352_0)
				end
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 and not isNil(arg_349_1.actors_["1027ui_story"]) and arg_349_1.var_.characterEffect1027ui_story then
				arg_349_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_349_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_352_1 = 0
			local var_352_2 = 0.45

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, true)
				arg_349_1.iconController_:SetSelectedState("hero")

				arg_349_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_349_1.callingController_:SetSelectedState("normal")

				arg_349_1.keyicon_.color = Color.New(1, 1, 1)
				arg_349_1.icon_.color = Color.New(1, 1, 1)

				local var_352_3 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(1102701086).content)

				arg_349_1.text_.text = var_352_3

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_5 = 18 <= 0 and var_352_2 or var_352_2 * (utf8.len(var_352_3) / 18)

				if (18 <= 0 and var_352_2 or var_352_2 * (utf8.len(var_352_3) / 18)) > 0 and var_352_2 < var_352_5 then
					arg_349_1.talkMaxDuration = var_352_5

					if var_352_5 + var_352_1 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_5 + var_352_1
					end
				end

				arg_349_1.text_.text = var_352_3
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_6 = math.max(var_352_2, arg_349_1.talkMaxDuration)

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_6 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_1) / var_352_6

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_1 + var_352_6 and arg_349_1.time_ < var_352_1 + var_352_6 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play1102701087 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 1102701087
		arg_353_1.duration_ = 9.4

		local var_353_0 = {
			ja = 8.966,
			ko = 9.4,
			zh = 9.4
		}
		local var_353_1 = manager.audio:GetLocalizationFlag()

		if var_353_0[var_353_1] ~= nil then
			arg_353_1.duration_ = var_353_0[var_353_1]
		end

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play1102701088(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.var_.moveOldPos1027ui_story = arg_353_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_356_0 = 0.001

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 then
				arg_353_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1027ui_story, Vector3.New(-0.7, -0.81, -5.8), (arg_353_1.time_ - 0) / var_356_0)
				arg_353_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1027ui_story"].transform.position).z)
				arg_353_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["1027ui_story"].transform.localEulerAngles = arg_353_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 then
				arg_353_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(-0.7, -0.81, -5.8)
				arg_353_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1027ui_story"].transform.position).z)
				arg_353_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["1027ui_story"].transform.localEulerAngles = arg_353_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_356_1 = arg_353_1.actors_["1027ui_story"]

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(var_356_1) and arg_353_1.var_.characterEffect1027ui_story == nil then
				arg_353_1.var_.characterEffect1027ui_story = var_356_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_2 = 0.200000002980232

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_2 and not isNil(var_356_1) then
				if arg_353_1.var_.characterEffect1027ui_story and not isNil(var_356_1) then
					arg_353_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_353_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_353_1.time_ - 0) / var_356_2)
				end
			end

			if arg_353_1.time_ >= 0 + var_356_2 and arg_353_1.time_ < 0 + var_356_2 + arg_356_0 and not isNil(var_356_1) and arg_353_1.var_.characterEffect1027ui_story then
				arg_353_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_353_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_356_3 = "1066ui_story"

			if arg_353_1.actors_["1066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1066ui_story"))) then
				local var_356_4 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_353_1.stage_.transform)

				var_356_4.name = var_356_3
				var_356_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_353_1.actors_[var_356_3] = var_356_4

				local var_356_5 = var_356_4:GetComponentInChildren(typeof(CharacterEffect))

				var_356_5.enabled = true

				local var_356_6 = GameObjectTools.GetOrAddComponent(var_356_4, typeof(DynamicBoneHelper))

				if var_356_6 then
					var_356_6:EnableDynamicBone(false)
				end

				arg_353_1:ShowWeapon(var_356_5.transform, false)

				arg_353_1.var_[var_356_3 .. "Animator"] = var_356_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_353_1.var_[var_356_3 .. "Animator"].applyRootMotion = true
				arg_353_1.var_[var_356_3 .. "LipSync"] = var_356_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_356_7 = arg_353_1.actors_["1066ui_story"].transform

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.var_.moveOldPos1066ui_story = var_356_7.localPosition
			end

			local var_356_8 = 0.001

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_8 then
				var_356_7.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1066ui_story, Vector3.New(0.7, -0.77, -6.1), (arg_353_1.time_ - 0) / var_356_8)
				var_356_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_356_7.position).x, (manager.ui.mainCamera.transform.position - var_356_7.position).y, (manager.ui.mainCamera.transform.position - var_356_7.position).z)
				var_356_7.localEulerAngles.z = 0
				var_356_7.localEulerAngles.x = 0
				var_356_7.localEulerAngles = var_356_7.localEulerAngles
			end

			if arg_353_1.time_ >= 0 + var_356_8 and arg_353_1.time_ < 0 + var_356_8 + arg_356_0 then
				var_356_7.localPosition = Vector3.New(0.7, -0.77, -6.1)
				var_356_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_356_7.position).x, (manager.ui.mainCamera.transform.position - var_356_7.position).y, (manager.ui.mainCamera.transform.position - var_356_7.position).z)
				var_356_7.localEulerAngles.z = 0
				var_356_7.localEulerAngles.x = 0
				var_356_7.localEulerAngles = var_356_7.localEulerAngles
			end

			local var_356_9 = arg_353_1.actors_["1066ui_story"]

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(var_356_9) and arg_353_1.var_.characterEffect1066ui_story == nil then
				arg_353_1.var_.characterEffect1066ui_story = var_356_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_10 = 0.200000002980232

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_10 and not isNil(var_356_9) then
				if arg_353_1.var_.characterEffect1066ui_story and not isNil(var_356_9) then
					arg_353_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_353_1.time_ >= 0 + var_356_10 and arg_353_1.time_ < 0 + var_356_10 + arg_356_0 and not isNil(var_356_9) and arg_353_1.var_.characterEffect1066ui_story then
				arg_353_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_356_12 = 0
			local var_356_13 = 0.975

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_12 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_14 = arg_353_1:GetWordFromCfg(1102701087)
				local var_356_15 = arg_353_1:FormatText(var_356_14.content)

				arg_353_1.text_.text = var_356_15

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_17 = 39 <= 0 and var_356_13 or var_356_13 * (utf8.len(var_356_15) / 39)

				if (39 <= 0 and var_356_13 or var_356_13 * (utf8.len(var_356_15) / 39)) > 0 and var_356_13 < var_356_17 then
					arg_353_1.talkMaxDuration = var_356_17

					if var_356_17 + var_356_12 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_17 + var_356_12
					end
				end

				arg_353_1.text_.text = var_356_15
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701087", "story_v_side_new_1102701.awb") ~= 0 then
					local var_356_18 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701087", "story_v_side_new_1102701.awb") / 1000

					if var_356_18 + var_356_12 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_18 + var_356_12
					end

					if var_356_14.prefab_name ~= "" and arg_353_1.actors_[var_356_14.prefab_name] ~= nil then
						local var_356_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_14.prefab_name].transform, "story_v_side_new_1102701", "1102701087", "story_v_side_new_1102701.awb")

						arg_353_1:RecordAudio("1102701087", var_356_19)
						arg_353_1:RecordAudio("1102701087", var_356_19)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701087", "story_v_side_new_1102701.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701087", "story_v_side_new_1102701.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_20 = math.max(var_356_13, arg_353_1.talkMaxDuration)

			if var_356_12 <= arg_353_1.time_ and arg_353_1.time_ < var_356_12 + var_356_20 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_12) / var_356_20

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_12 + var_356_20 and arg_353_1.time_ < var_356_12 + var_356_20 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_353_1:InitPlayNodeList()
	end,
	Play1102701088 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 1102701088
		arg_357_1.duration_ = 2.77

		local var_357_0 = {
			ja = 2.6,
			ko = 2.766,
			zh = 2.766
		}
		local var_357_1 = manager.audio:GetLocalizationFlag()

		if var_357_0[var_357_1] ~= nil then
			arg_357_1.duration_ = var_357_0[var_357_1]
		end

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play1102701089(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_1")
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_360_0 = 0
			local var_360_1 = 0.275

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_0 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_2 = arg_357_1:GetWordFromCfg(1102701088)
				local var_360_3 = arg_357_1:FormatText(var_360_2.content)

				arg_357_1.text_.text = var_360_3

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_5 = 11 <= 0 and var_360_1 or var_360_1 * (utf8.len(var_360_3) / 11)

				if (11 <= 0 and var_360_1 or var_360_1 * (utf8.len(var_360_3) / 11)) > 0 and var_360_1 < var_360_5 then
					arg_357_1.talkMaxDuration = var_360_5

					if var_360_5 + var_360_0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_5 + var_360_0
					end
				end

				arg_357_1.text_.text = var_360_3
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701088", "story_v_side_new_1102701.awb") ~= 0 then
					local var_360_6 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701088", "story_v_side_new_1102701.awb") / 1000

					if var_360_6 + var_360_0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_6 + var_360_0
					end

					if var_360_2.prefab_name ~= "" and arg_357_1.actors_[var_360_2.prefab_name] ~= nil then
						local var_360_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_2.prefab_name].transform, "story_v_side_new_1102701", "1102701088", "story_v_side_new_1102701.awb")

						arg_357_1:RecordAudio("1102701088", var_360_7)
						arg_357_1:RecordAudio("1102701088", var_360_7)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701088", "story_v_side_new_1102701.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701088", "story_v_side_new_1102701.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_8 = math.max(var_360_1, arg_357_1.talkMaxDuration)

			if var_360_0 <= arg_357_1.time_ and arg_357_1.time_ < var_360_0 + var_360_8 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_0) / var_360_8

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_0 + var_360_8 and arg_357_1.time_ < var_360_0 + var_360_8 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play1102701089 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 1102701089
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play1102701090(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(arg_361_1.actors_["1066ui_story"]) and arg_361_1.var_.characterEffect1066ui_story == nil then
				arg_361_1.var_.characterEffect1066ui_story = arg_361_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_0 = 0.200000002980232

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 and not isNil(arg_361_1.actors_["1066ui_story"]) then
				if arg_361_1.var_.characterEffect1066ui_story and not isNil(arg_361_1.actors_["1066ui_story"]) then
					arg_361_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_361_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_361_1.time_ - 0) / var_364_0)
				end
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 and not isNil(arg_361_1.actors_["1066ui_story"]) and arg_361_1.var_.characterEffect1066ui_story then
				arg_361_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_361_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_364_1 = 0
			local var_364_2 = 0.475

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, true)
				arg_361_1.iconController_:SetSelectedState("hero")

				arg_361_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_361_1.callingController_:SetSelectedState("normal")

				arg_361_1.keyicon_.color = Color.New(1, 1, 1)
				arg_361_1.icon_.color = Color.New(1, 1, 1)

				local var_364_3 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(1102701089).content)

				arg_361_1.text_.text = var_364_3

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_5 = 19 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_3) / 19)

				if (19 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_3) / 19)) > 0 and var_364_2 < var_364_5 then
					arg_361_1.talkMaxDuration = var_364_5

					if var_364_5 + var_364_1 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_5 + var_364_1
					end
				end

				arg_361_1.text_.text = var_364_3
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_6 = math.max(var_364_2, arg_361_1.talkMaxDuration)

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_6 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_1) / var_364_6

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_1 + var_364_6 and arg_361_1.time_ < var_364_1 + var_364_6 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play1102701090 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 1102701090
		arg_365_1.duration_ = 3.37

		local var_365_0 = {
			ja = 2.5,
			ko = 3.366,
			zh = 3.366
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play1102701091(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(arg_365_1.actors_["1066ui_story"]) and arg_365_1.var_.characterEffect1066ui_story == nil then
				arg_365_1.var_.characterEffect1066ui_story = arg_365_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_0 = 0.200000002980232

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_0 and not isNil(arg_365_1.actors_["1066ui_story"]) then
				if arg_365_1.var_.characterEffect1066ui_story and not isNil(arg_365_1.actors_["1066ui_story"]) then
					arg_365_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_365_1.time_ >= 0 + var_368_0 and arg_365_1.time_ < 0 + var_368_0 + arg_368_0 and not isNil(arg_365_1.actors_["1066ui_story"]) and arg_365_1.var_.characterEffect1066ui_story then
				arg_365_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action424")
			end

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_368_2 = 0
			local var_368_3 = 0.325

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_2 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_4 = arg_365_1:GetWordFromCfg(1102701090)
				local var_368_5 = arg_365_1:FormatText(var_368_4.content)

				arg_365_1.text_.text = var_368_5

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_7 = 13 <= 0 and var_368_3 or var_368_3 * (utf8.len(var_368_5) / 13)

				if (13 <= 0 and var_368_3 or var_368_3 * (utf8.len(var_368_5) / 13)) > 0 and var_368_3 < var_368_7 then
					arg_365_1.talkMaxDuration = var_368_7

					if var_368_7 + var_368_2 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_7 + var_368_2
					end
				end

				arg_365_1.text_.text = var_368_5
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701090", "story_v_side_new_1102701.awb") ~= 0 then
					local var_368_8 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701090", "story_v_side_new_1102701.awb") / 1000

					if var_368_8 + var_368_2 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_8 + var_368_2
					end

					if var_368_4.prefab_name ~= "" and arg_365_1.actors_[var_368_4.prefab_name] ~= nil then
						local var_368_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_4.prefab_name].transform, "story_v_side_new_1102701", "1102701090", "story_v_side_new_1102701.awb")

						arg_365_1:RecordAudio("1102701090", var_368_9)
						arg_365_1:RecordAudio("1102701090", var_368_9)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701090", "story_v_side_new_1102701.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701090", "story_v_side_new_1102701.awb")
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
	Play1102701091 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 1102701091
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play1102701092(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.var_.moveOldPos1066ui_story = arg_369_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_372_0 = 0.001

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 then
				arg_369_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_369_1.time_ - 0) / var_372_0)
				arg_369_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_369_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1066ui_story"].transform.position).z)
				arg_369_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_369_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_369_1.actors_["1066ui_story"].transform.localEulerAngles = arg_369_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 then
				arg_369_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_369_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_369_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1066ui_story"].transform.position).z)
				arg_369_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_369_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_369_1.actors_["1066ui_story"].transform.localEulerAngles = arg_369_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_372_1 = arg_369_1.actors_["1066ui_story"]

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(var_372_1) and arg_369_1.var_.characterEffect1066ui_story == nil then
				arg_369_1.var_.characterEffect1066ui_story = var_372_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_2 = 0.200000002980232

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_2 and not isNil(var_372_1) then
				if arg_369_1.var_.characterEffect1066ui_story and not isNil(var_372_1) then
					arg_369_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_369_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_369_1.time_ - 0) / var_372_2)
				end
			end

			if arg_369_1.time_ >= 0 + var_372_2 and arg_369_1.time_ < 0 + var_372_2 + arg_372_0 and not isNil(var_372_1) and arg_369_1.var_.characterEffect1066ui_story then
				arg_369_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_369_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_372_3 = arg_369_1.actors_["1027ui_story"].transform

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.var_.moveOldPos1027ui_story = var_372_3.localPosition
			end

			local var_372_4 = 0.001

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_4 then
				var_372_3.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_369_1.time_ - 0) / var_372_4)
				var_372_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_372_3.position).x, (manager.ui.mainCamera.transform.position - var_372_3.position).y, (manager.ui.mainCamera.transform.position - var_372_3.position).z)
				var_372_3.localEulerAngles.z = 0
				var_372_3.localEulerAngles.x = 0
				var_372_3.localEulerAngles = var_372_3.localEulerAngles
			end

			if arg_369_1.time_ >= 0 + var_372_4 and arg_369_1.time_ < 0 + var_372_4 + arg_372_0 then
				var_372_3.localPosition = Vector3.New(0, 100, 0)
				var_372_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_372_3.position).x, (manager.ui.mainCamera.transform.position - var_372_3.position).y, (manager.ui.mainCamera.transform.position - var_372_3.position).z)
				var_372_3.localEulerAngles.z = 0
				var_372_3.localEulerAngles.x = 0
				var_372_3.localEulerAngles = var_372_3.localEulerAngles
			end

			local var_372_5 = 0
			local var_372_6 = 1.4

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_5 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, false)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_7 = arg_369_1:FormatText(arg_369_1:GetWordFromCfg(1102701091).content)

				arg_369_1.text_.text = var_372_7

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_9 = 56 <= 0 and var_372_6 or var_372_6 * (utf8.len(var_372_7) / 56)

				if (56 <= 0 and var_372_6 or var_372_6 * (utf8.len(var_372_7) / 56)) > 0 and var_372_6 < var_372_9 then
					arg_369_1.talkMaxDuration = var_372_9

					if var_372_9 + var_372_5 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_9 + var_372_5
					end
				end

				arg_369_1.text_.text = var_372_7
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_10 = math.max(var_372_6, arg_369_1.talkMaxDuration)

			if var_372_5 <= arg_369_1.time_ and arg_369_1.time_ < var_372_5 + var_372_10 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_5) / var_372_10

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_5 + var_372_10 and arg_369_1.time_ < var_372_5 + var_372_10 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_369_1:InitPlayNodeList()
	end,
	Play1102701092 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 1102701092
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play1102701093(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = 1.075

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, false)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_1 = arg_373_1:FormatText(arg_373_1:GetWordFromCfg(1102701092).content)

				arg_373_1.text_.text = var_376_1

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_3 = 43 <= 0 and var_376_0 or var_376_0 * (utf8.len(var_376_1) / 43)

				if (43 <= 0 and var_376_0 or var_376_0 * (utf8.len(var_376_1) / 43)) > 0 and var_376_0 < var_376_3 then
					arg_373_1.talkMaxDuration = var_376_3

					if var_376_3 + 0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_3 + 0
					end
				end

				arg_373_1.text_.text = var_376_1
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_4 = math.max(var_376_0, arg_373_1.talkMaxDuration)

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_4 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - 0) / var_376_4

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= 0 + var_376_4 and arg_373_1.time_ < 0 + var_376_4 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play1102701093 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 1102701093
		arg_377_1.duration_ = 5.8

		local var_377_0 = {
			ja = 4.9,
			ko = 5.8,
			zh = 5.8
		}
		local var_377_1 = manager.audio:GetLocalizationFlag()

		if var_377_0[var_377_1] ~= nil then
			arg_377_1.duration_ = var_377_0[var_377_1]
		end

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play1102701094(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.var_.moveOldPos1027ui_story = arg_377_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_380_0 = 0.001

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 then
				arg_377_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_377_1.time_ - 0) / var_380_0)
				arg_377_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_377_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1027ui_story"].transform.position).z)
				arg_377_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_377_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_377_1.actors_["1027ui_story"].transform.localEulerAngles = arg_377_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 then
				arg_377_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, -0.81, -5.8)
				arg_377_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_377_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1027ui_story"].transform.position).z)
				arg_377_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_377_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_377_1.actors_["1027ui_story"].transform.localEulerAngles = arg_377_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_380_1 = arg_377_1.actors_["1027ui_story"]

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(var_380_1) and arg_377_1.var_.characterEffect1027ui_story == nil then
				arg_377_1.var_.characterEffect1027ui_story = var_380_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_2 = 0.200000002980232

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_2 and not isNil(var_380_1) then
				if arg_377_1.var_.characterEffect1027ui_story and not isNil(var_380_1) then
					arg_377_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_377_1.time_ >= 0 + var_380_2 and arg_377_1.time_ < 0 + var_380_2 + arg_380_0 and not isNil(var_380_1) and arg_377_1.var_.characterEffect1027ui_story then
				arg_377_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_380_4 = 0
			local var_380_5 = 0.375

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_4 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_6 = arg_377_1:GetWordFromCfg(1102701093)
				local var_380_7 = arg_377_1:FormatText(var_380_6.content)

				arg_377_1.text_.text = var_380_7

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_9 = 15 <= 0 and var_380_5 or var_380_5 * (utf8.len(var_380_7) / 15)

				if (15 <= 0 and var_380_5 or var_380_5 * (utf8.len(var_380_7) / 15)) > 0 and var_380_5 < var_380_9 then
					arg_377_1.talkMaxDuration = var_380_9

					if var_380_9 + var_380_4 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_9 + var_380_4
					end
				end

				arg_377_1.text_.text = var_380_7
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701093", "story_v_side_new_1102701.awb") ~= 0 then
					local var_380_10 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701093", "story_v_side_new_1102701.awb") / 1000

					if var_380_10 + var_380_4 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_10 + var_380_4
					end

					if var_380_6.prefab_name ~= "" and arg_377_1.actors_[var_380_6.prefab_name] ~= nil then
						local var_380_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_6.prefab_name].transform, "story_v_side_new_1102701", "1102701093", "story_v_side_new_1102701.awb")

						arg_377_1:RecordAudio("1102701093", var_380_11)
						arg_377_1:RecordAudio("1102701093", var_380_11)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701093", "story_v_side_new_1102701.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701093", "story_v_side_new_1102701.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_12 = math.max(var_380_5, arg_377_1.talkMaxDuration)

			if var_380_4 <= arg_377_1.time_ and arg_377_1.time_ < var_380_4 + var_380_12 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_4) / var_380_12

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_4 + var_380_12 and arg_377_1.time_ < var_380_4 + var_380_12 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_377_1:InitPlayNodeList()
	end,
	Play1102701094 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 1102701094
		arg_381_1.duration_ = 8.47

		local var_381_0 = {
			ja = 8.466,
			ko = 6.6,
			zh = 6.6
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play1102701095(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(arg_381_1.actors_["1027ui_story"]) and arg_381_1.var_.characterEffect1027ui_story == nil then
				arg_381_1.var_.characterEffect1027ui_story = arg_381_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_0 = 0.200000002980232

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_0 and not isNil(arg_381_1.actors_["1027ui_story"]) then
				if arg_381_1.var_.characterEffect1027ui_story and not isNil(arg_381_1.actors_["1027ui_story"]) then
					arg_381_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_381_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_381_1.time_ - 0) / var_384_0)
				end
			end

			if arg_381_1.time_ >= 0 + var_384_0 and arg_381_1.time_ < 0 + var_384_0 + arg_384_0 and not isNil(arg_381_1.actors_["1027ui_story"]) and arg_381_1.var_.characterEffect1027ui_story then
				arg_381_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_381_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_384_1 = 0
			local var_384_2 = 0.625

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_1 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[203].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, true)
				arg_381_1.iconController_:SetSelectedState("hero")

				arg_381_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10013")

				arg_381_1.callingController_:SetSelectedState("normal")

				arg_381_1.keyicon_.color = Color.New(1, 1, 1)
				arg_381_1.icon_.color = Color.New(1, 1, 1)

				local var_384_3 = arg_381_1:GetWordFromCfg(1102701094)
				local var_384_4 = arg_381_1:FormatText(var_384_3.content)

				arg_381_1.text_.text = var_384_4

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_6 = 25 <= 0 and var_384_2 or var_384_2 * (utf8.len(var_384_4) / 25)

				if (25 <= 0 and var_384_2 or var_384_2 * (utf8.len(var_384_4) / 25)) > 0 and var_384_2 < var_384_6 then
					arg_381_1.talkMaxDuration = var_384_6

					if var_384_6 + var_384_1 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_6 + var_384_1
					end
				end

				arg_381_1.text_.text = var_384_4
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701094", "story_v_side_new_1102701.awb") ~= 0 then
					local var_384_7 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701094", "story_v_side_new_1102701.awb") / 1000

					if var_384_7 + var_384_1 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_7 + var_384_1
					end

					if var_384_3.prefab_name ~= "" and arg_381_1.actors_[var_384_3.prefab_name] ~= nil then
						local var_384_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_3.prefab_name].transform, "story_v_side_new_1102701", "1102701094", "story_v_side_new_1102701.awb")

						arg_381_1:RecordAudio("1102701094", var_384_8)
						arg_381_1:RecordAudio("1102701094", var_384_8)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701094", "story_v_side_new_1102701.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701094", "story_v_side_new_1102701.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_9 = math.max(var_384_2, arg_381_1.talkMaxDuration)

			if var_384_1 <= arg_381_1.time_ and arg_381_1.time_ < var_384_1 + var_384_9 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_1) / var_384_9

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_1 + var_384_9 and arg_381_1.time_ < var_384_1 + var_384_9 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play1102701095 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 1102701095
		arg_385_1.duration_ = 7.13

		local var_385_0 = {
			ja = 3.6,
			ko = 7.133,
			zh = 7.133
		}
		local var_385_1 = manager.audio:GetLocalizationFlag()

		if var_385_0[var_385_1] ~= nil then
			arg_385_1.duration_ = var_385_0[var_385_1]
		end

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play1102701096(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(arg_385_1.actors_["1027ui_story"]) and arg_385_1.var_.characterEffect1027ui_story == nil then
				arg_385_1.var_.characterEffect1027ui_story = arg_385_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_0 = 0.200000002980232

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_0 and not isNil(arg_385_1.actors_["1027ui_story"]) then
				if arg_385_1.var_.characterEffect1027ui_story and not isNil(arg_385_1.actors_["1027ui_story"]) then
					arg_385_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_385_1.time_ >= 0 + var_388_0 and arg_385_1.time_ < 0 + var_388_0 + arg_388_0 and not isNil(arg_385_1.actors_["1027ui_story"]) and arg_385_1.var_.characterEffect1027ui_story then
				arg_385_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action4_1")
			end

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_388_2 = 0
			local var_388_3 = 0.375

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_2 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_4 = arg_385_1:GetWordFromCfg(1102701095)
				local var_388_5 = arg_385_1:FormatText(var_388_4.content)

				arg_385_1.text_.text = var_388_5

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_7 = 15 <= 0 and var_388_3 or var_388_3 * (utf8.len(var_388_5) / 15)

				if (15 <= 0 and var_388_3 or var_388_3 * (utf8.len(var_388_5) / 15)) > 0 and var_388_3 < var_388_7 then
					arg_385_1.talkMaxDuration = var_388_7

					if var_388_7 + var_388_2 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_7 + var_388_2
					end
				end

				arg_385_1.text_.text = var_388_5
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701095", "story_v_side_new_1102701.awb") ~= 0 then
					local var_388_8 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701095", "story_v_side_new_1102701.awb") / 1000

					if var_388_8 + var_388_2 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_8 + var_388_2
					end

					if var_388_4.prefab_name ~= "" and arg_385_1.actors_[var_388_4.prefab_name] ~= nil then
						local var_388_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_4.prefab_name].transform, "story_v_side_new_1102701", "1102701095", "story_v_side_new_1102701.awb")

						arg_385_1:RecordAudio("1102701095", var_388_9)
						arg_385_1:RecordAudio("1102701095", var_388_9)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701095", "story_v_side_new_1102701.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701095", "story_v_side_new_1102701.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_10 = math.max(var_388_3, arg_385_1.talkMaxDuration)

			if var_388_2 <= arg_385_1.time_ and arg_385_1.time_ < var_388_2 + var_388_10 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_2) / var_388_10

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_2 + var_388_10 and arg_385_1.time_ < var_388_2 + var_388_10 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play1102701096 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 1102701096
		arg_389_1.duration_ = 3.5

		local var_389_0 = {
			ja = 2.166,
			ko = 3.5,
			zh = 3.5
		}
		local var_389_1 = manager.audio:GetLocalizationFlag()

		if var_389_0[var_389_1] ~= nil then
			arg_389_1.duration_ = var_389_0[var_389_1]
		end

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play1102701097(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(arg_389_1.actors_["1027ui_story"]) and arg_389_1.var_.characterEffect1027ui_story == nil then
				arg_389_1.var_.characterEffect1027ui_story = arg_389_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_0 = 0.200000002980232

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 and not isNil(arg_389_1.actors_["1027ui_story"]) then
				if arg_389_1.var_.characterEffect1027ui_story and not isNil(arg_389_1.actors_["1027ui_story"]) then
					arg_389_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_389_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_389_1.time_ - 0) / var_392_0)
				end
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 and not isNil(arg_389_1.actors_["1027ui_story"]) and arg_389_1.var_.characterEffect1027ui_story then
				arg_389_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_389_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_392_1 = 0
			local var_392_2 = 0.325

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[203].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, true)
				arg_389_1.iconController_:SetSelectedState("hero")

				arg_389_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10013")

				arg_389_1.callingController_:SetSelectedState("normal")

				arg_389_1.keyicon_.color = Color.New(1, 1, 1)
				arg_389_1.icon_.color = Color.New(1, 1, 1)

				local var_392_3 = arg_389_1:GetWordFromCfg(1102701096)
				local var_392_4 = arg_389_1:FormatText(var_392_3.content)

				arg_389_1.text_.text = var_392_4

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_6 = 13 <= 0 and var_392_2 or var_392_2 * (utf8.len(var_392_4) / 13)

				if (13 <= 0 and var_392_2 or var_392_2 * (utf8.len(var_392_4) / 13)) > 0 and var_392_2 < var_392_6 then
					arg_389_1.talkMaxDuration = var_392_6

					if var_392_6 + var_392_1 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_6 + var_392_1
					end
				end

				arg_389_1.text_.text = var_392_4
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701096", "story_v_side_new_1102701.awb") ~= 0 then
					local var_392_7 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701096", "story_v_side_new_1102701.awb") / 1000

					if var_392_7 + var_392_1 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_7 + var_392_1
					end

					if var_392_3.prefab_name ~= "" and arg_389_1.actors_[var_392_3.prefab_name] ~= nil then
						local var_392_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_3.prefab_name].transform, "story_v_side_new_1102701", "1102701096", "story_v_side_new_1102701.awb")

						arg_389_1:RecordAudio("1102701096", var_392_8)
						arg_389_1:RecordAudio("1102701096", var_392_8)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701096", "story_v_side_new_1102701.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701096", "story_v_side_new_1102701.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_9 = math.max(var_392_2, arg_389_1.talkMaxDuration)

			if var_392_1 <= arg_389_1.time_ and arg_389_1.time_ < var_392_1 + var_392_9 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_1) / var_392_9

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_1 + var_392_9 and arg_389_1.time_ < var_392_1 + var_392_9 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play1102701097 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 1102701097
		arg_393_1.duration_ = 6.6

		local var_393_0 = {
			ja = 6.6,
			ko = 4.466,
			zh = 4.466
		}
		local var_393_1 = manager.audio:GetLocalizationFlag()

		if var_393_0[var_393_1] ~= nil then
			arg_393_1.duration_ = var_393_0[var_393_1]
		end

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play1102701098(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(arg_393_1.actors_["1027ui_story"]) and arg_393_1.var_.characterEffect1027ui_story == nil then
				arg_393_1.var_.characterEffect1027ui_story = arg_393_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_0 = 0.200000002980232

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_0 and not isNil(arg_393_1.actors_["1027ui_story"]) then
				if arg_393_1.var_.characterEffect1027ui_story and not isNil(arg_393_1.actors_["1027ui_story"]) then
					arg_393_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_393_1.time_ >= 0 + var_396_0 and arg_393_1.time_ < 0 + var_396_0 + arg_396_0 and not isNil(arg_393_1.actors_["1027ui_story"]) and arg_393_1.var_.characterEffect1027ui_story then
				arg_393_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action4_2")
			end

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_396_2 = 0
			local var_396_3 = 0.45

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_2 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_4 = arg_393_1:GetWordFromCfg(1102701097)
				local var_396_5 = arg_393_1:FormatText(var_396_4.content)

				arg_393_1.text_.text = var_396_5

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_7 = 18 <= 0 and var_396_3 or var_396_3 * (utf8.len(var_396_5) / 18)

				if (18 <= 0 and var_396_3 or var_396_3 * (utf8.len(var_396_5) / 18)) > 0 and var_396_3 < var_396_7 then
					arg_393_1.talkMaxDuration = var_396_7

					if var_396_7 + var_396_2 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_7 + var_396_2
					end
				end

				arg_393_1.text_.text = var_396_5
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701097", "story_v_side_new_1102701.awb") ~= 0 then
					local var_396_8 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701097", "story_v_side_new_1102701.awb") / 1000

					if var_396_8 + var_396_2 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_8 + var_396_2
					end

					if var_396_4.prefab_name ~= "" and arg_393_1.actors_[var_396_4.prefab_name] ~= nil then
						local var_396_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_4.prefab_name].transform, "story_v_side_new_1102701", "1102701097", "story_v_side_new_1102701.awb")

						arg_393_1:RecordAudio("1102701097", var_396_9)
						arg_393_1:RecordAudio("1102701097", var_396_9)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701097", "story_v_side_new_1102701.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701097", "story_v_side_new_1102701.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_10 = math.max(var_396_3, arg_393_1.talkMaxDuration)

			if var_396_2 <= arg_393_1.time_ and arg_393_1.time_ < var_396_2 + var_396_10 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_2) / var_396_10

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_2 + var_396_10 and arg_393_1.time_ < var_396_2 + var_396_10 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play1102701098 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 1102701098
		arg_397_1.duration_ = 5.13

		local var_397_0 = {
			ja = 3.266,
			ko = 5.133,
			zh = 5.133
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
				arg_397_0:Play1102701099(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 0.625

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_1 = arg_397_1:GetWordFromCfg(1102701098)
				local var_400_2 = arg_397_1:FormatText(var_400_1.content)

				arg_397_1.text_.text = var_400_2

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_4 = 25 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_2) / 25)

				if (25 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_2) / 25)) > 0 and var_400_0 < var_400_4 then
					arg_397_1.talkMaxDuration = var_400_4

					if var_400_4 + 0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_4 + 0
					end
				end

				arg_397_1.text_.text = var_400_2
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701098", "story_v_side_new_1102701.awb") ~= 0 then
					local var_400_5 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701098", "story_v_side_new_1102701.awb") / 1000

					if var_400_5 + 0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_5 + 0
					end

					if var_400_1.prefab_name ~= "" and arg_397_1.actors_[var_400_1.prefab_name] ~= nil then
						local var_400_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_1.prefab_name].transform, "story_v_side_new_1102701", "1102701098", "story_v_side_new_1102701.awb")

						arg_397_1:RecordAudio("1102701098", var_400_6)
						arg_397_1:RecordAudio("1102701098", var_400_6)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701098", "story_v_side_new_1102701.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701098", "story_v_side_new_1102701.awb")
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
	Play1102701099 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 1102701099
		arg_401_1.duration_ = 11.63

		local var_401_0 = {
			ja = 11.633,
			ko = 7.233,
			zh = 7.233
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play1102701100(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(arg_401_1.actors_["1027ui_story"]) and arg_401_1.var_.characterEffect1027ui_story == nil then
				arg_401_1.var_.characterEffect1027ui_story = arg_401_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_0 = 0.200000002980232

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_0 and not isNil(arg_401_1.actors_["1027ui_story"]) then
				if arg_401_1.var_.characterEffect1027ui_story and not isNil(arg_401_1.actors_["1027ui_story"]) then
					arg_401_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_401_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_401_1.time_ - 0) / var_404_0)
				end
			end

			if arg_401_1.time_ >= 0 + var_404_0 and arg_401_1.time_ < 0 + var_404_0 + arg_404_0 and not isNil(arg_401_1.actors_["1027ui_story"]) and arg_401_1.var_.characterEffect1027ui_story then
				arg_401_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_401_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_404_1 = 0
			local var_404_2 = 0.925

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[203].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, true)
				arg_401_1.iconController_:SetSelectedState("hero")

				arg_401_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10013")

				arg_401_1.callingController_:SetSelectedState("normal")

				arg_401_1.keyicon_.color = Color.New(1, 1, 1)
				arg_401_1.icon_.color = Color.New(1, 1, 1)

				local var_404_3 = arg_401_1:GetWordFromCfg(1102701099)
				local var_404_4 = arg_401_1:FormatText(var_404_3.content)

				arg_401_1.text_.text = var_404_4

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_6 = 37 <= 0 and var_404_2 or var_404_2 * (utf8.len(var_404_4) / 37)

				if (37 <= 0 and var_404_2 or var_404_2 * (utf8.len(var_404_4) / 37)) > 0 and var_404_2 < var_404_6 then
					arg_401_1.talkMaxDuration = var_404_6

					if var_404_6 + var_404_1 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_6 + var_404_1
					end
				end

				arg_401_1.text_.text = var_404_4
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701099", "story_v_side_new_1102701.awb") ~= 0 then
					local var_404_7 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701099", "story_v_side_new_1102701.awb") / 1000

					if var_404_7 + var_404_1 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_7 + var_404_1
					end

					if var_404_3.prefab_name ~= "" and arg_401_1.actors_[var_404_3.prefab_name] ~= nil then
						local var_404_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_3.prefab_name].transform, "story_v_side_new_1102701", "1102701099", "story_v_side_new_1102701.awb")

						arg_401_1:RecordAudio("1102701099", var_404_8)
						arg_401_1:RecordAudio("1102701099", var_404_8)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701099", "story_v_side_new_1102701.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701099", "story_v_side_new_1102701.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_9 = math.max(var_404_2, arg_401_1.talkMaxDuration)

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_9 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_1) / var_404_9

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_1 + var_404_9 and arg_401_1.time_ < var_404_1 + var_404_9 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play1102701100 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 1102701100
		arg_405_1.duration_ = 11.27

		local var_405_0 = {
			ja = 11.266,
			ko = 10.866,
			zh = 10.866
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
				arg_405_0:Play1102701101(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.var_.moveOldPos1027ui_story = arg_405_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_408_0 = 0.001

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_0 then
				arg_405_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos1027ui_story, Vector3.New(-0.7, -0.81, -5.8), (arg_405_1.time_ - 0) / var_408_0)
				arg_405_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_405_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1027ui_story"].transform.position).z)
				arg_405_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_405_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_405_1.actors_["1027ui_story"].transform.localEulerAngles = arg_405_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_405_1.time_ >= 0 + var_408_0 and arg_405_1.time_ < 0 + var_408_0 + arg_408_0 then
				arg_405_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(-0.7, -0.81, -5.8)
				arg_405_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_405_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1027ui_story"].transform.position).z)
				arg_405_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_405_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_405_1.actors_["1027ui_story"].transform.localEulerAngles = arg_405_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_408_1 = arg_405_1.actors_["1027ui_story"]

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(var_408_1) and arg_405_1.var_.characterEffect1027ui_story == nil then
				arg_405_1.var_.characterEffect1027ui_story = var_408_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_2 = 0.200000002980232

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_2 and not isNil(var_408_1) then
				if arg_405_1.var_.characterEffect1027ui_story and not isNil(var_408_1) then
					arg_405_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_405_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_405_1.time_ - 0) / var_408_2)
				end
			end

			if arg_405_1.time_ >= 0 + var_408_2 and arg_405_1.time_ < 0 + var_408_2 + arg_408_0 and not isNil(var_408_1) and arg_405_1.var_.characterEffect1027ui_story then
				arg_405_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_405_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_408_3 = arg_405_1.actors_["1066ui_story"].transform

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.var_.moveOldPos1066ui_story = var_408_3.localPosition
			end

			local var_408_4 = 0.001

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_4 then
				var_408_3.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos1066ui_story, Vector3.New(0.7, -0.77, -6.1), (arg_405_1.time_ - 0) / var_408_4)
				var_408_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_408_3.position).x, (manager.ui.mainCamera.transform.position - var_408_3.position).y, (manager.ui.mainCamera.transform.position - var_408_3.position).z)
				var_408_3.localEulerAngles.z = 0
				var_408_3.localEulerAngles.x = 0
				var_408_3.localEulerAngles = var_408_3.localEulerAngles
			end

			if arg_405_1.time_ >= 0 + var_408_4 and arg_405_1.time_ < 0 + var_408_4 + arg_408_0 then
				var_408_3.localPosition = Vector3.New(0.7, -0.77, -6.1)
				var_408_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_408_3.position).x, (manager.ui.mainCamera.transform.position - var_408_3.position).y, (manager.ui.mainCamera.transform.position - var_408_3.position).z)
				var_408_3.localEulerAngles.z = 0
				var_408_3.localEulerAngles.x = 0
				var_408_3.localEulerAngles = var_408_3.localEulerAngles
			end

			local var_408_5 = arg_405_1.actors_["1066ui_story"]

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(var_408_5) and arg_405_1.var_.characterEffect1066ui_story == nil then
				arg_405_1.var_.characterEffect1066ui_story = var_408_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_6 = 0.200000002980232

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_6 and not isNil(var_408_5) then
				if arg_405_1.var_.characterEffect1066ui_story and not isNil(var_408_5) then
					arg_405_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_405_1.time_ >= 0 + var_408_6 and arg_405_1.time_ < 0 + var_408_6 + arg_408_0 and not isNil(var_408_5) and arg_405_1.var_.characterEffect1066ui_story then
				arg_405_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_1")
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_408_8 = 0
			local var_408_9 = 1.4

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_8 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_10 = arg_405_1:GetWordFromCfg(1102701100)
				local var_408_11 = arg_405_1:FormatText(var_408_10.content)

				arg_405_1.text_.text = var_408_11

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_13 = 56 <= 0 and var_408_9 or var_408_9 * (utf8.len(var_408_11) / 56)

				if (56 <= 0 and var_408_9 or var_408_9 * (utf8.len(var_408_11) / 56)) > 0 and var_408_9 < var_408_13 then
					arg_405_1.talkMaxDuration = var_408_13

					if var_408_13 + var_408_8 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_13 + var_408_8
					end
				end

				arg_405_1.text_.text = var_408_11
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701100", "story_v_side_new_1102701.awb") ~= 0 then
					local var_408_14 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701100", "story_v_side_new_1102701.awb") / 1000

					if var_408_14 + var_408_8 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_14 + var_408_8
					end

					if var_408_10.prefab_name ~= "" and arg_405_1.actors_[var_408_10.prefab_name] ~= nil then
						local var_408_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_10.prefab_name].transform, "story_v_side_new_1102701", "1102701100", "story_v_side_new_1102701.awb")

						arg_405_1:RecordAudio("1102701100", var_408_15)
						arg_405_1:RecordAudio("1102701100", var_408_15)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701100", "story_v_side_new_1102701.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701100", "story_v_side_new_1102701.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_16 = math.max(var_408_9, arg_405_1.talkMaxDuration)

			if var_408_8 <= arg_405_1.time_ and arg_405_1.time_ < var_408_8 + var_408_16 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_8) / var_408_16

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_8 + var_408_16 and arg_405_1.time_ < var_408_8 + var_408_16 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_405_1:InitPlayNodeList()
	end,
	Play1102701101 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 1102701101
		arg_409_1.duration_ = 4.53

		local var_409_0 = {
			ja = 1.999999999999,
			ko = 4.533,
			zh = 4.533
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
				arg_409_0:Play1102701102(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(arg_409_1.actors_["1027ui_story"]) and arg_409_1.var_.characterEffect1027ui_story == nil then
				arg_409_1.var_.characterEffect1027ui_story = arg_409_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_0 = 0.200000002980232

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 and not isNil(arg_409_1.actors_["1027ui_story"]) then
				if arg_409_1.var_.characterEffect1027ui_story and not isNil(arg_409_1.actors_["1027ui_story"]) then
					arg_409_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 and not isNil(arg_409_1.actors_["1027ui_story"]) and arg_409_1.var_.characterEffect1027ui_story then
				arg_409_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_412_2 = arg_409_1.actors_["1066ui_story"]

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(var_412_2) and arg_409_1.var_.characterEffect1066ui_story == nil then
				arg_409_1.var_.characterEffect1066ui_story = var_412_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_3 = 0.200000002980232

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_3 and not isNil(var_412_2) then
				if arg_409_1.var_.characterEffect1066ui_story and not isNil(var_412_2) then
					arg_409_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_409_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_409_1.time_ - 0) / var_412_3)
				end
			end

			if arg_409_1.time_ >= 0 + var_412_3 and arg_409_1.time_ < 0 + var_412_3 + arg_412_0 and not isNil(var_412_2) and arg_409_1.var_.characterEffect1066ui_story then
				arg_409_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_409_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_412_4 = 0
			local var_412_5 = 0.4

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_4 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_6 = arg_409_1:GetWordFromCfg(1102701101)
				local var_412_7 = arg_409_1:FormatText(var_412_6.content)

				arg_409_1.text_.text = var_412_7

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_9 = 16 <= 0 and var_412_5 or var_412_5 * (utf8.len(var_412_7) / 16)

				if (16 <= 0 and var_412_5 or var_412_5 * (utf8.len(var_412_7) / 16)) > 0 and var_412_5 < var_412_9 then
					arg_409_1.talkMaxDuration = var_412_9

					if var_412_9 + var_412_4 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_9 + var_412_4
					end
				end

				arg_409_1.text_.text = var_412_7
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701101", "story_v_side_new_1102701.awb") ~= 0 then
					local var_412_10 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701101", "story_v_side_new_1102701.awb") / 1000

					if var_412_10 + var_412_4 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_10 + var_412_4
					end

					if var_412_6.prefab_name ~= "" and arg_409_1.actors_[var_412_6.prefab_name] ~= nil then
						local var_412_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_6.prefab_name].transform, "story_v_side_new_1102701", "1102701101", "story_v_side_new_1102701.awb")

						arg_409_1:RecordAudio("1102701101", var_412_11)
						arg_409_1:RecordAudio("1102701101", var_412_11)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701101", "story_v_side_new_1102701.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701101", "story_v_side_new_1102701.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_12 = math.max(var_412_5, arg_409_1.talkMaxDuration)

			if var_412_4 <= arg_409_1.time_ and arg_409_1.time_ < var_412_4 + var_412_12 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_4) / var_412_12

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_4 + var_412_12 and arg_409_1.time_ < var_412_4 + var_412_12 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play1102701102 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 1102701102
		arg_413_1.duration_ = 11.23

		local var_413_0 = {
			ja = 9.8,
			ko = 11.233,
			zh = 11.233
		}
		local var_413_1 = manager.audio:GetLocalizationFlag()

		if var_413_0[var_413_1] ~= nil then
			arg_413_1.duration_ = var_413_0[var_413_1]
		end

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play1102701103(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(arg_413_1.actors_["1027ui_story"]) and arg_413_1.var_.characterEffect1027ui_story == nil then
				arg_413_1.var_.characterEffect1027ui_story = arg_413_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_0 = 0.200000002980232

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_0 and not isNil(arg_413_1.actors_["1027ui_story"]) then
				if arg_413_1.var_.characterEffect1027ui_story and not isNil(arg_413_1.actors_["1027ui_story"]) then
					arg_413_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_413_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_413_1.time_ - 0) / var_416_0)
				end
			end

			if arg_413_1.time_ >= 0 + var_416_0 and arg_413_1.time_ < 0 + var_416_0 + arg_416_0 and not isNil(arg_413_1.actors_["1027ui_story"]) and arg_413_1.var_.characterEffect1027ui_story then
				arg_413_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_413_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_416_1 = 0
			local var_416_2 = 1.325

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				arg_413_1.leftNameTxt_.text = arg_413_1:FormatText(StoryNameCfg[203].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, true)
				arg_413_1.iconController_:SetSelectedState("hero")

				arg_413_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10013")

				arg_413_1.callingController_:SetSelectedState("normal")

				arg_413_1.keyicon_.color = Color.New(1, 1, 1)
				arg_413_1.icon_.color = Color.New(1, 1, 1)

				local var_416_3 = arg_413_1:GetWordFromCfg(1102701102)
				local var_416_4 = arg_413_1:FormatText(var_416_3.content)

				arg_413_1.text_.text = var_416_4

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_6 = 53 <= 0 and var_416_2 or var_416_2 * (utf8.len(var_416_4) / 53)

				if (53 <= 0 and var_416_2 or var_416_2 * (utf8.len(var_416_4) / 53)) > 0 and var_416_2 < var_416_6 then
					arg_413_1.talkMaxDuration = var_416_6

					if var_416_6 + var_416_1 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_6 + var_416_1
					end
				end

				arg_413_1.text_.text = var_416_4
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701102", "story_v_side_new_1102701.awb") ~= 0 then
					local var_416_7 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701102", "story_v_side_new_1102701.awb") / 1000

					if var_416_7 + var_416_1 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_7 + var_416_1
					end

					if var_416_3.prefab_name ~= "" and arg_413_1.actors_[var_416_3.prefab_name] ~= nil then
						local var_416_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_3.prefab_name].transform, "story_v_side_new_1102701", "1102701102", "story_v_side_new_1102701.awb")

						arg_413_1:RecordAudio("1102701102", var_416_8)
						arg_413_1:RecordAudio("1102701102", var_416_8)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701102", "story_v_side_new_1102701.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701102", "story_v_side_new_1102701.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_9 = math.max(var_416_2, arg_413_1.talkMaxDuration)

			if var_416_1 <= arg_413_1.time_ and arg_413_1.time_ < var_416_1 + var_416_9 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_1) / var_416_9

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_1 + var_416_9 and arg_413_1.time_ < var_416_1 + var_416_9 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play1102701103 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 1102701103
		arg_417_1.duration_ = 6.43

		local var_417_0 = {
			ja = 4.566,
			ko = 6.433,
			zh = 6.433
		}
		local var_417_1 = manager.audio:GetLocalizationFlag()

		if var_417_0[var_417_1] ~= nil then
			arg_417_1.duration_ = var_417_0[var_417_1]
		end

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play1102701104(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(arg_417_1.actors_["1027ui_story"]) and arg_417_1.var_.characterEffect1027ui_story == nil then
				arg_417_1.var_.characterEffect1027ui_story = arg_417_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_0 = 0.200000002980232

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 and not isNil(arg_417_1.actors_["1027ui_story"]) then
				if arg_417_1.var_.characterEffect1027ui_story and not isNil(arg_417_1.actors_["1027ui_story"]) then
					arg_417_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 and not isNil(arg_417_1.actors_["1027ui_story"]) and arg_417_1.var_.characterEffect1027ui_story then
				arg_417_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action5_1")
			end

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_420_2 = 0
			local var_420_3 = 0.65

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_2 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_4 = arg_417_1:GetWordFromCfg(1102701103)
				local var_420_5 = arg_417_1:FormatText(var_420_4.content)

				arg_417_1.text_.text = var_420_5

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_7 = 26 <= 0 and var_420_3 or var_420_3 * (utf8.len(var_420_5) / 26)

				if (26 <= 0 and var_420_3 or var_420_3 * (utf8.len(var_420_5) / 26)) > 0 and var_420_3 < var_420_7 then
					arg_417_1.talkMaxDuration = var_420_7

					if var_420_7 + var_420_2 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_7 + var_420_2
					end
				end

				arg_417_1.text_.text = var_420_5
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701103", "story_v_side_new_1102701.awb") ~= 0 then
					local var_420_8 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701103", "story_v_side_new_1102701.awb") / 1000

					if var_420_8 + var_420_2 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_8 + var_420_2
					end

					if var_420_4.prefab_name ~= "" and arg_417_1.actors_[var_420_4.prefab_name] ~= nil then
						local var_420_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_4.prefab_name].transform, "story_v_side_new_1102701", "1102701103", "story_v_side_new_1102701.awb")

						arg_417_1:RecordAudio("1102701103", var_420_9)
						arg_417_1:RecordAudio("1102701103", var_420_9)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701103", "story_v_side_new_1102701.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701103", "story_v_side_new_1102701.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_10 = math.max(var_420_3, arg_417_1.talkMaxDuration)

			if var_420_2 <= arg_417_1.time_ and arg_417_1.time_ < var_420_2 + var_420_10 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_2) / var_420_10

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_2 + var_420_10 and arg_417_1.time_ < var_420_2 + var_420_10 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play1102701104 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 1102701104
		arg_421_1.duration_ = 10.7

		local var_421_0 = {
			ja = 5.333,
			ko = 10.7,
			zh = 10.7
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
				arg_421_0:Play1102701105(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action5_2")
			end

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_424_0 = 0
			local var_424_1 = 1.375

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_0 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_2 = arg_421_1:GetWordFromCfg(1102701104)
				local var_424_3 = arg_421_1:FormatText(var_424_2.content)

				arg_421_1.text_.text = var_424_3

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_5 = 55 <= 0 and var_424_1 or var_424_1 * (utf8.len(var_424_3) / 55)

				if (55 <= 0 and var_424_1 or var_424_1 * (utf8.len(var_424_3) / 55)) > 0 and var_424_1 < var_424_5 then
					arg_421_1.talkMaxDuration = var_424_5

					if var_424_5 + var_424_0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_5 + var_424_0
					end
				end

				arg_421_1.text_.text = var_424_3
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701104", "story_v_side_new_1102701.awb") ~= 0 then
					local var_424_6 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701104", "story_v_side_new_1102701.awb") / 1000

					if var_424_6 + var_424_0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_6 + var_424_0
					end

					if var_424_2.prefab_name ~= "" and arg_421_1.actors_[var_424_2.prefab_name] ~= nil then
						local var_424_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_2.prefab_name].transform, "story_v_side_new_1102701", "1102701104", "story_v_side_new_1102701.awb")

						arg_421_1:RecordAudio("1102701104", var_424_7)
						arg_421_1:RecordAudio("1102701104", var_424_7)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701104", "story_v_side_new_1102701.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701104", "story_v_side_new_1102701.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_8 = math.max(var_424_1, arg_421_1.talkMaxDuration)

			if var_424_0 <= arg_421_1.time_ and arg_421_1.time_ < var_424_0 + var_424_8 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_0) / var_424_8

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_0 + var_424_8 and arg_421_1.time_ < var_424_0 + var_424_8 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play1102701105 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 1102701105
		arg_425_1.duration_ = 9.5

		local var_425_0 = {
			ja = 6.5,
			ko = 9.5,
			zh = 9.5
		}
		local var_425_1 = manager.audio:GetLocalizationFlag()

		if var_425_0[var_425_1] ~= nil then
			arg_425_1.duration_ = var_425_0[var_425_1]
		end

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play1102701106(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 and not isNil(arg_425_1.actors_["1027ui_story"]) and arg_425_1.var_.characterEffect1027ui_story == nil then
				arg_425_1.var_.characterEffect1027ui_story = arg_425_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_0 = 0.200000002980232

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_0 and not isNil(arg_425_1.actors_["1027ui_story"]) then
				if arg_425_1.var_.characterEffect1027ui_story and not isNil(arg_425_1.actors_["1027ui_story"]) then
					arg_425_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_425_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_425_1.time_ - 0) / var_428_0)
				end
			end

			if arg_425_1.time_ >= 0 + var_428_0 and arg_425_1.time_ < 0 + var_428_0 + arg_428_0 and not isNil(arg_425_1.actors_["1027ui_story"]) and arg_425_1.var_.characterEffect1027ui_story then
				arg_425_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_425_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_428_1 = 0
			local var_428_2 = 1.05

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_1 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[203].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, true)
				arg_425_1.iconController_:SetSelectedState("hero")

				arg_425_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10013")

				arg_425_1.callingController_:SetSelectedState("normal")

				arg_425_1.keyicon_.color = Color.New(1, 1, 1)
				arg_425_1.icon_.color = Color.New(1, 1, 1)

				local var_428_3 = arg_425_1:GetWordFromCfg(1102701105)
				local var_428_4 = arg_425_1:FormatText(var_428_3.content)

				arg_425_1.text_.text = var_428_4

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_6 = 42 <= 0 and var_428_2 or var_428_2 * (utf8.len(var_428_4) / 42)

				if (42 <= 0 and var_428_2 or var_428_2 * (utf8.len(var_428_4) / 42)) > 0 and var_428_2 < var_428_6 then
					arg_425_1.talkMaxDuration = var_428_6

					if var_428_6 + var_428_1 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_6 + var_428_1
					end
				end

				arg_425_1.text_.text = var_428_4
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701105", "story_v_side_new_1102701.awb") ~= 0 then
					local var_428_7 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701105", "story_v_side_new_1102701.awb") / 1000

					if var_428_7 + var_428_1 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_7 + var_428_1
					end

					if var_428_3.prefab_name ~= "" and arg_425_1.actors_[var_428_3.prefab_name] ~= nil then
						local var_428_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_3.prefab_name].transform, "story_v_side_new_1102701", "1102701105", "story_v_side_new_1102701.awb")

						arg_425_1:RecordAudio("1102701105", var_428_8)
						arg_425_1:RecordAudio("1102701105", var_428_8)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701105", "story_v_side_new_1102701.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701105", "story_v_side_new_1102701.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_9 = math.max(var_428_2, arg_425_1.talkMaxDuration)

			if var_428_1 <= arg_425_1.time_ and arg_425_1.time_ < var_428_1 + var_428_9 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_1) / var_428_9

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_1 + var_428_9 and arg_425_1.time_ < var_428_1 + var_428_9 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play1102701106 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 1102701106
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play1102701107(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1.var_.moveOldPos1027ui_story = arg_429_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_432_0 = 0.001

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_0 then
				arg_429_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_429_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_429_1.time_ - 0) / var_432_0)
				arg_429_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_429_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["1027ui_story"].transform.position).z)
				arg_429_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_429_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_429_1.actors_["1027ui_story"].transform.localEulerAngles = arg_429_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_429_1.time_ >= 0 + var_432_0 and arg_429_1.time_ < 0 + var_432_0 + arg_432_0 then
				arg_429_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_429_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_429_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["1027ui_story"].transform.position).z)
				arg_429_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_429_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_429_1.actors_["1027ui_story"].transform.localEulerAngles = arg_429_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_432_1 = arg_429_1.actors_["1027ui_story"]

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(var_432_1) and arg_429_1.var_.characterEffect1027ui_story == nil then
				arg_429_1.var_.characterEffect1027ui_story = var_432_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_2 = 0.034000001847744

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_2 and not isNil(var_432_1) then
				if arg_429_1.var_.characterEffect1027ui_story and not isNil(var_432_1) then
					arg_429_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_429_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_429_1.time_ - 0) / var_432_2)
				end
			end

			if arg_429_1.time_ >= 0 + var_432_2 and arg_429_1.time_ < 0 + var_432_2 + arg_432_0 and not isNil(var_432_1) and arg_429_1.var_.characterEffect1027ui_story then
				arg_429_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_429_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_432_3 = arg_429_1.actors_["1066ui_story"].transform

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1.var_.moveOldPos1066ui_story = var_432_3.localPosition
			end

			local var_432_4 = 0.001

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_4 then
				var_432_3.localPosition = Vector3.Lerp(arg_429_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_429_1.time_ - 0) / var_432_4)
				var_432_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_432_3.position).x, (manager.ui.mainCamera.transform.position - var_432_3.position).y, (manager.ui.mainCamera.transform.position - var_432_3.position).z)
				var_432_3.localEulerAngles.z = 0
				var_432_3.localEulerAngles.x = 0
				var_432_3.localEulerAngles = var_432_3.localEulerAngles
			end

			if arg_429_1.time_ >= 0 + var_432_4 and arg_429_1.time_ < 0 + var_432_4 + arg_432_0 then
				var_432_3.localPosition = Vector3.New(0, 100, 0)
				var_432_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_432_3.position).x, (manager.ui.mainCamera.transform.position - var_432_3.position).y, (manager.ui.mainCamera.transform.position - var_432_3.position).z)
				var_432_3.localEulerAngles.z = 0
				var_432_3.localEulerAngles.x = 0
				var_432_3.localEulerAngles = var_432_3.localEulerAngles
			end

			local var_432_5 = arg_429_1.actors_["1066ui_story"]

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(var_432_5) and arg_429_1.var_.characterEffect1066ui_story == nil then
				arg_429_1.var_.characterEffect1066ui_story = var_432_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_6 = 0.034000001847744

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_6 and not isNil(var_432_5) then
				if arg_429_1.var_.characterEffect1066ui_story and not isNil(var_432_5) then
					arg_429_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_429_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_429_1.time_ - 0) / var_432_6)
				end
			end

			if arg_429_1.time_ >= 0 + var_432_6 and arg_429_1.time_ < 0 + var_432_6 + arg_432_0 and not isNil(var_432_5) and arg_429_1.var_.characterEffect1066ui_story then
				arg_429_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_429_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_432_7 = 0
			local var_432_8 = 1.375

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_7 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, false)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_9 = arg_429_1:FormatText(arg_429_1:GetWordFromCfg(1102701106).content)

				arg_429_1.text_.text = var_432_9

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_11 = 54 <= 0 and var_432_8 or var_432_8 * (utf8.len(var_432_9) / 54)

				if (54 <= 0 and var_432_8 or var_432_8 * (utf8.len(var_432_9) / 54)) > 0 and var_432_8 < var_432_11 then
					arg_429_1.talkMaxDuration = var_432_11

					if var_432_11 + var_432_7 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_11 + var_432_7
					end
				end

				arg_429_1.text_.text = var_432_9
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_12 = math.max(var_432_8, arg_429_1.talkMaxDuration)

			if var_432_7 <= arg_429_1.time_ and arg_429_1.time_ < var_432_7 + var_432_12 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_7) / var_432_12

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_7 + var_432_12 and arg_429_1.time_ < var_432_7 + var_432_12 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_429_1:InitPlayNodeList()
	end,
	Play1102701107 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 1102701107
		arg_433_1.duration_ = 6.73

		local var_433_0 = {
			ja = 5.4,
			ko = 6.733,
			zh = 6.733
		}
		local var_433_1 = manager.audio:GetLocalizationFlag()

		if var_433_0[var_433_1] ~= nil then
			arg_433_1.duration_ = var_433_0[var_433_1]
		end

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play1102701108(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = 0.275

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				arg_433_1.leftNameTxt_.text = arg_433_1:FormatText(StoryNameCfg[203].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, true)
				arg_433_1.iconController_:SetSelectedState("hero")

				arg_433_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10013")

				arg_433_1.callingController_:SetSelectedState("normal")

				arg_433_1.keyicon_.color = Color.New(1, 1, 1)
				arg_433_1.icon_.color = Color.New(1, 1, 1)

				local var_436_1 = arg_433_1:GetWordFromCfg(1102701107)
				local var_436_2 = arg_433_1:FormatText(var_436_1.content)

				arg_433_1.text_.text = var_436_2

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_4 = 11 <= 0 and var_436_0 or var_436_0 * (utf8.len(var_436_2) / 11)

				if (11 <= 0 and var_436_0 or var_436_0 * (utf8.len(var_436_2) / 11)) > 0 and var_436_0 < var_436_4 then
					arg_433_1.talkMaxDuration = var_436_4

					if var_436_4 + 0 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_4 + 0
					end
				end

				arg_433_1.text_.text = var_436_2
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701107", "story_v_side_new_1102701.awb") ~= 0 then
					local var_436_5 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701107", "story_v_side_new_1102701.awb") / 1000

					if var_436_5 + 0 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_5 + 0
					end

					if var_436_1.prefab_name ~= "" and arg_433_1.actors_[var_436_1.prefab_name] ~= nil then
						local var_436_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_1.prefab_name].transform, "story_v_side_new_1102701", "1102701107", "story_v_side_new_1102701.awb")

						arg_433_1:RecordAudio("1102701107", var_436_6)
						arg_433_1:RecordAudio("1102701107", var_436_6)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701107", "story_v_side_new_1102701.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701107", "story_v_side_new_1102701.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_7 = math.max(var_436_0, arg_433_1.talkMaxDuration)

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_7 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - 0) / var_436_7

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= 0 + var_436_7 and arg_433_1.time_ < 0 + var_436_7 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play1102701108 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 1102701108
		arg_437_1.duration_ = 12.5

		local var_437_0 = {
			ja = 12.5,
			ko = 9.9,
			zh = 9.9
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
				arg_437_0:Play1102701109(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1.var_.moveOldPos1066ui_story = arg_437_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_440_0 = 0.001

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_0 then
				arg_437_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_437_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_437_1.time_ - 0) / var_440_0)
				arg_437_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_437_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1066ui_story"].transform.position).z)
				arg_437_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_437_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_437_1.actors_["1066ui_story"].transform.localEulerAngles = arg_437_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_437_1.time_ >= 0 + var_440_0 and arg_437_1.time_ < 0 + var_440_0 + arg_440_0 then
				arg_437_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_437_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_437_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1066ui_story"].transform.position).z)
				arg_437_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_437_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_437_1.actors_["1066ui_story"].transform.localEulerAngles = arg_437_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_440_1 = arg_437_1.actors_["1066ui_story"]

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(var_440_1) and arg_437_1.var_.characterEffect1066ui_story == nil then
				arg_437_1.var_.characterEffect1066ui_story = var_440_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_2 = 0.200000002980232

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_2 and not isNil(var_440_1) then
				if arg_437_1.var_.characterEffect1066ui_story and not isNil(var_440_1) then
					arg_437_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_437_1.time_ >= 0 + var_440_2 and arg_437_1.time_ < 0 + var_440_2 + arg_440_0 and not isNil(var_440_1) and arg_437_1.var_.characterEffect1066ui_story then
				arg_437_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_1")
			end

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_440_4 = 0
			local var_440_5 = 1.225

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_4 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_6 = arg_437_1:GetWordFromCfg(1102701108)
				local var_440_7 = arg_437_1:FormatText(var_440_6.content)

				arg_437_1.text_.text = var_440_7

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_9 = 49 <= 0 and var_440_5 or var_440_5 * (utf8.len(var_440_7) / 49)

				if (49 <= 0 and var_440_5 or var_440_5 * (utf8.len(var_440_7) / 49)) > 0 and var_440_5 < var_440_9 then
					arg_437_1.talkMaxDuration = var_440_9

					if var_440_9 + var_440_4 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_9 + var_440_4
					end
				end

				arg_437_1.text_.text = var_440_7
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701108", "story_v_side_new_1102701.awb") ~= 0 then
					local var_440_10 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701108", "story_v_side_new_1102701.awb") / 1000

					if var_440_10 + var_440_4 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_10 + var_440_4
					end

					if var_440_6.prefab_name ~= "" and arg_437_1.actors_[var_440_6.prefab_name] ~= nil then
						local var_440_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_6.prefab_name].transform, "story_v_side_new_1102701", "1102701108", "story_v_side_new_1102701.awb")

						arg_437_1:RecordAudio("1102701108", var_440_11)
						arg_437_1:RecordAudio("1102701108", var_440_11)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701108", "story_v_side_new_1102701.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701108", "story_v_side_new_1102701.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_12 = math.max(var_440_5, arg_437_1.talkMaxDuration)

			if var_440_4 <= arg_437_1.time_ and arg_437_1.time_ < var_440_4 + var_440_12 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_4) / var_440_12

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_4 + var_440_12 and arg_437_1.time_ < var_440_4 + var_440_12 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_437_1:InitPlayNodeList()
	end,
	Play1102701109 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 1102701109
		arg_441_1.duration_ = 10.7

		local var_441_0 = {
			ja = 10.3,
			ko = 10.7,
			zh = 10.7
		}
		local var_441_1 = manager.audio:GetLocalizationFlag()

		if var_441_0[var_441_1] ~= nil then
			arg_441_1.duration_ = var_441_0[var_441_1]
		end

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play1102701110(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = 1.225

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				arg_441_1.leftNameTxt_.text = arg_441_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_1 = arg_441_1:GetWordFromCfg(1102701109)
				local var_444_2 = arg_441_1:FormatText(var_444_1.content)

				arg_441_1.text_.text = var_444_2

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_4 = 50 <= 0 and var_444_0 or var_444_0 * (utf8.len(var_444_2) / 50)

				if (50 <= 0 and var_444_0 or var_444_0 * (utf8.len(var_444_2) / 50)) > 0 and var_444_0 < var_444_4 then
					arg_441_1.talkMaxDuration = var_444_4

					if var_444_4 + 0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_4 + 0
					end
				end

				arg_441_1.text_.text = var_444_2
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701109", "story_v_side_new_1102701.awb") ~= 0 then
					local var_444_5 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701109", "story_v_side_new_1102701.awb") / 1000

					if var_444_5 + 0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_5 + 0
					end

					if var_444_1.prefab_name ~= "" and arg_441_1.actors_[var_444_1.prefab_name] ~= nil then
						local var_444_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_1.prefab_name].transform, "story_v_side_new_1102701", "1102701109", "story_v_side_new_1102701.awb")

						arg_441_1:RecordAudio("1102701109", var_444_6)
						arg_441_1:RecordAudio("1102701109", var_444_6)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701109", "story_v_side_new_1102701.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701109", "story_v_side_new_1102701.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_7 = math.max(var_444_0, arg_441_1.talkMaxDuration)

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_7 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - 0) / var_444_7

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= 0 + var_444_7 and arg_441_1.time_ < 0 + var_444_7 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play1102701110 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 1102701110
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play1102701111(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 and not isNil(arg_445_1.actors_["1066ui_story"]) and arg_445_1.var_.characterEffect1066ui_story == nil then
				arg_445_1.var_.characterEffect1066ui_story = arg_445_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_0 = 0.200000002980232

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_0 and not isNil(arg_445_1.actors_["1066ui_story"]) then
				if arg_445_1.var_.characterEffect1066ui_story and not isNil(arg_445_1.actors_["1066ui_story"]) then
					arg_445_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_445_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_445_1.time_ - 0) / var_448_0)
				end
			end

			if arg_445_1.time_ >= 0 + var_448_0 and arg_445_1.time_ < 0 + var_448_0 + arg_448_0 and not isNil(arg_445_1.actors_["1066ui_story"]) and arg_445_1.var_.characterEffect1066ui_story then
				arg_445_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_445_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_448_1 = 0
			local var_448_2 = 0.625

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_1 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				arg_445_1.leftNameTxt_.text = arg_445_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, true)
				arg_445_1.iconController_:SetSelectedState("hero")

				arg_445_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_445_1.callingController_:SetSelectedState("normal")

				arg_445_1.keyicon_.color = Color.New(1, 1, 1)
				arg_445_1.icon_.color = Color.New(1, 1, 1)

				local var_448_3 = arg_445_1:FormatText(arg_445_1:GetWordFromCfg(1102701110).content)

				arg_445_1.text_.text = var_448_3

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_5 = 25 <= 0 and var_448_2 or var_448_2 * (utf8.len(var_448_3) / 25)

				if (25 <= 0 and var_448_2 or var_448_2 * (utf8.len(var_448_3) / 25)) > 0 and var_448_2 < var_448_5 then
					arg_445_1.talkMaxDuration = var_448_5

					if var_448_5 + var_448_1 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_5 + var_448_1
					end
				end

				arg_445_1.text_.text = var_448_3
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_6 = math.max(var_448_2, arg_445_1.talkMaxDuration)

			if var_448_1 <= arg_445_1.time_ and arg_445_1.time_ < var_448_1 + var_448_6 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_1) / var_448_6

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_1 + var_448_6 and arg_445_1.time_ < var_448_1 + var_448_6 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play1102701111 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 1102701111
		arg_449_1.duration_ = 3.7

		local var_449_0 = {
			ja = 3.7,
			ko = 3.4,
			zh = 3.4
		}
		local var_449_1 = manager.audio:GetLocalizationFlag()

		if var_449_0[var_449_1] ~= nil then
			arg_449_1.duration_ = var_449_0[var_449_1]
		end

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play1102701112(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.var_.moveOldPos1066ui_story = arg_449_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_452_0 = 0.001

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_0 then
				arg_449_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos1066ui_story, Vector3.New(-0.7, -0.77, -6.1), (arg_449_1.time_ - 0) / var_452_0)
				arg_449_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_449_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["1066ui_story"].transform.position).z)
				arg_449_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_449_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_449_1.actors_["1066ui_story"].transform.localEulerAngles = arg_449_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_449_1.time_ >= 0 + var_452_0 and arg_449_1.time_ < 0 + var_452_0 + arg_452_0 then
				arg_449_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.77, -6.1)
				arg_449_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_449_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["1066ui_story"].transform.position).z)
				arg_449_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_449_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_449_1.actors_["1066ui_story"].transform.localEulerAngles = arg_449_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_452_1 = arg_449_1.actors_["1066ui_story"]

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 and not isNil(var_452_1) and arg_449_1.var_.characterEffect1066ui_story == nil then
				arg_449_1.var_.characterEffect1066ui_story = var_452_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_2 = 0.200000002980232

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_2 and not isNil(var_452_1) then
				if arg_449_1.var_.characterEffect1066ui_story and not isNil(var_452_1) then
					arg_449_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_449_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_449_1.time_ - 0) / var_452_2)
				end
			end

			if arg_449_1.time_ >= 0 + var_452_2 and arg_449_1.time_ < 0 + var_452_2 + arg_452_0 and not isNil(var_452_1) and arg_449_1.var_.characterEffect1066ui_story then
				arg_449_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_449_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_452_3 = arg_449_1.actors_["1027ui_story"].transform

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.var_.moveOldPos1027ui_story = var_452_3.localPosition
			end

			local var_452_4 = 0.001

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_4 then
				var_452_3.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos1027ui_story, Vector3.New(0.7, -0.81, -5.8), (arg_449_1.time_ - 0) / var_452_4)
				var_452_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_452_3.position).x, (manager.ui.mainCamera.transform.position - var_452_3.position).y, (manager.ui.mainCamera.transform.position - var_452_3.position).z)
				var_452_3.localEulerAngles.z = 0
				var_452_3.localEulerAngles.x = 0
				var_452_3.localEulerAngles = var_452_3.localEulerAngles
			end

			if arg_449_1.time_ >= 0 + var_452_4 and arg_449_1.time_ < 0 + var_452_4 + arg_452_0 then
				var_452_3.localPosition = Vector3.New(0.7, -0.81, -5.8)
				var_452_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_452_3.position).x, (manager.ui.mainCamera.transform.position - var_452_3.position).y, (manager.ui.mainCamera.transform.position - var_452_3.position).z)
				var_452_3.localEulerAngles.z = 0
				var_452_3.localEulerAngles.x = 0
				var_452_3.localEulerAngles = var_452_3.localEulerAngles
			end

			local var_452_5 = arg_449_1.actors_["1027ui_story"]

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 and not isNil(var_452_5) and arg_449_1.var_.characterEffect1027ui_story == nil then
				arg_449_1.var_.characterEffect1027ui_story = var_452_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_6 = 0.200000002980232

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_6 and not isNil(var_452_5) then
				if arg_449_1.var_.characterEffect1027ui_story and not isNil(var_452_5) then
					arg_449_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_449_1.time_ >= 0 + var_452_6 and arg_449_1.time_ < 0 + var_452_6 + arg_452_0 and not isNil(var_452_5) and arg_449_1.var_.characterEffect1027ui_story then
				arg_449_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_452_8 = 0
			local var_452_9 = 0.425

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_8 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_10 = arg_449_1:GetWordFromCfg(1102701111)
				local var_452_11 = arg_449_1:FormatText(var_452_10.content)

				arg_449_1.text_.text = var_452_11

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_13 = 17 <= 0 and var_452_9 or var_452_9 * (utf8.len(var_452_11) / 17)

				if (17 <= 0 and var_452_9 or var_452_9 * (utf8.len(var_452_11) / 17)) > 0 and var_452_9 < var_452_13 then
					arg_449_1.talkMaxDuration = var_452_13

					if var_452_13 + var_452_8 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_13 + var_452_8
					end
				end

				arg_449_1.text_.text = var_452_11
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701111", "story_v_side_new_1102701.awb") ~= 0 then
					local var_452_14 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701111", "story_v_side_new_1102701.awb") / 1000

					if var_452_14 + var_452_8 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_14 + var_452_8
					end

					if var_452_10.prefab_name ~= "" and arg_449_1.actors_[var_452_10.prefab_name] ~= nil then
						local var_452_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_10.prefab_name].transform, "story_v_side_new_1102701", "1102701111", "story_v_side_new_1102701.awb")

						arg_449_1:RecordAudio("1102701111", var_452_15)
						arg_449_1:RecordAudio("1102701111", var_452_15)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701111", "story_v_side_new_1102701.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701111", "story_v_side_new_1102701.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_16 = math.max(var_452_9, arg_449_1.talkMaxDuration)

			if var_452_8 <= arg_449_1.time_ and arg_449_1.time_ < var_452_8 + var_452_16 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_8) / var_452_16

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_8 + var_452_16 and arg_449_1.time_ < var_452_8 + var_452_16 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_449_1:InitPlayNodeList()
	end,
	Play1102701112 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 1102701112
		arg_453_1.duration_ = 11.3

		local var_453_0 = {
			ja = 11.3,
			ko = 8.933,
			zh = 8.933
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
				arg_453_0:Play1102701113(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 and not isNil(arg_453_1.actors_["1027ui_story"]) and arg_453_1.var_.characterEffect1027ui_story == nil then
				arg_453_1.var_.characterEffect1027ui_story = arg_453_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_0 = 0.200000002980232

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_0 and not isNil(arg_453_1.actors_["1027ui_story"]) then
				if arg_453_1.var_.characterEffect1027ui_story and not isNil(arg_453_1.actors_["1027ui_story"]) then
					arg_453_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_453_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_453_1.time_ - 0) / var_456_0)
				end
			end

			if arg_453_1.time_ >= 0 + var_456_0 and arg_453_1.time_ < 0 + var_456_0 + arg_456_0 and not isNil(arg_453_1.actors_["1027ui_story"]) and arg_453_1.var_.characterEffect1027ui_story then
				arg_453_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_453_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_456_1 = 0
			local var_456_2 = 0.9

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_1 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[203].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, true)
				arg_453_1.iconController_:SetSelectedState("hero")

				arg_453_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10013")

				arg_453_1.callingController_:SetSelectedState("normal")

				arg_453_1.keyicon_.color = Color.New(1, 1, 1)
				arg_453_1.icon_.color = Color.New(1, 1, 1)

				local var_456_3 = arg_453_1:GetWordFromCfg(1102701112)
				local var_456_4 = arg_453_1:FormatText(var_456_3.content)

				arg_453_1.text_.text = var_456_4

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_6 = 36 <= 0 and var_456_2 or var_456_2 * (utf8.len(var_456_4) / 36)

				if (36 <= 0 and var_456_2 or var_456_2 * (utf8.len(var_456_4) / 36)) > 0 and var_456_2 < var_456_6 then
					arg_453_1.talkMaxDuration = var_456_6

					if var_456_6 + var_456_1 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_6 + var_456_1
					end
				end

				arg_453_1.text_.text = var_456_4
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701112", "story_v_side_new_1102701.awb") ~= 0 then
					local var_456_7 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701112", "story_v_side_new_1102701.awb") / 1000

					if var_456_7 + var_456_1 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_7 + var_456_1
					end

					if var_456_3.prefab_name ~= "" and arg_453_1.actors_[var_456_3.prefab_name] ~= nil then
						local var_456_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_3.prefab_name].transform, "story_v_side_new_1102701", "1102701112", "story_v_side_new_1102701.awb")

						arg_453_1:RecordAudio("1102701112", var_456_8)
						arg_453_1:RecordAudio("1102701112", var_456_8)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701112", "story_v_side_new_1102701.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701112", "story_v_side_new_1102701.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_9 = math.max(var_456_2, arg_453_1.talkMaxDuration)

			if var_456_1 <= arg_453_1.time_ and arg_453_1.time_ < var_456_1 + var_456_9 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_1) / var_456_9

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_1 + var_456_9 and arg_453_1.time_ < var_456_1 + var_456_9 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play1102701113 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 1102701113
		arg_457_1.duration_ = 7

		local var_457_0 = {
			ja = 6.366,
			ko = 7,
			zh = 7
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
				arg_457_0:Play1102701114(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 and not isNil(arg_457_1.actors_["1027ui_story"]) and arg_457_1.var_.characterEffect1027ui_story == nil then
				arg_457_1.var_.characterEffect1027ui_story = arg_457_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_460_0 = 0.200000002980232

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_0 and not isNil(arg_457_1.actors_["1027ui_story"]) then
				if arg_457_1.var_.characterEffect1027ui_story and not isNil(arg_457_1.actors_["1027ui_story"]) then
					arg_457_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_457_1.time_ >= 0 + var_460_0 and arg_457_1.time_ < 0 + var_460_0 + arg_460_0 and not isNil(arg_457_1.actors_["1027ui_story"]) and arg_457_1.var_.characterEffect1027ui_story then
				arg_457_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action7_1")
			end

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_460_2 = 0
			local var_460_3 = 0.675

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_2 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_4 = arg_457_1:GetWordFromCfg(1102701113)
				local var_460_5 = arg_457_1:FormatText(var_460_4.content)

				arg_457_1.text_.text = var_460_5

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_7 = 27 <= 0 and var_460_3 or var_460_3 * (utf8.len(var_460_5) / 27)

				if (27 <= 0 and var_460_3 or var_460_3 * (utf8.len(var_460_5) / 27)) > 0 and var_460_3 < var_460_7 then
					arg_457_1.talkMaxDuration = var_460_7

					if var_460_7 + var_460_2 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_7 + var_460_2
					end
				end

				arg_457_1.text_.text = var_460_5
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701113", "story_v_side_new_1102701.awb") ~= 0 then
					local var_460_8 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701113", "story_v_side_new_1102701.awb") / 1000

					if var_460_8 + var_460_2 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_8 + var_460_2
					end

					if var_460_4.prefab_name ~= "" and arg_457_1.actors_[var_460_4.prefab_name] ~= nil then
						local var_460_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_4.prefab_name].transform, "story_v_side_new_1102701", "1102701113", "story_v_side_new_1102701.awb")

						arg_457_1:RecordAudio("1102701113", var_460_9)
						arg_457_1:RecordAudio("1102701113", var_460_9)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701113", "story_v_side_new_1102701.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701113", "story_v_side_new_1102701.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_10 = math.max(var_460_3, arg_457_1.talkMaxDuration)

			if var_460_2 <= arg_457_1.time_ and arg_457_1.time_ < var_460_2 + var_460_10 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_2) / var_460_10

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_2 + var_460_10 and arg_457_1.time_ < var_460_2 + var_460_10 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play1102701114 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 1102701114
		arg_461_1.duration_ = 5.73

		local var_461_0 = {
			ja = 5.733,
			ko = 3.5,
			zh = 3.5
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
				arg_461_0:Play1102701115(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 and not isNil(arg_461_1.actors_["1066ui_story"]) and arg_461_1.var_.characterEffect1066ui_story == nil then
				arg_461_1.var_.characterEffect1066ui_story = arg_461_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_0 = 0.200000002980232

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_0 and not isNil(arg_461_1.actors_["1066ui_story"]) then
				if arg_461_1.var_.characterEffect1066ui_story and not isNil(arg_461_1.actors_["1066ui_story"]) then
					arg_461_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_461_1.time_ >= 0 + var_464_0 and arg_461_1.time_ < 0 + var_464_0 + arg_464_0 and not isNil(arg_461_1.actors_["1066ui_story"]) and arg_461_1.var_.characterEffect1066ui_story then
				arg_461_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_2")
			end

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_464_2 = arg_461_1.actors_["1027ui_story"]

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 and not isNil(var_464_2) and arg_461_1.var_.characterEffect1027ui_story == nil then
				arg_461_1.var_.characterEffect1027ui_story = var_464_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_3 = 0.200000002980232

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_3 and not isNil(var_464_2) then
				if arg_461_1.var_.characterEffect1027ui_story and not isNil(var_464_2) then
					arg_461_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_461_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_461_1.time_ - 0) / var_464_3)
				end
			end

			if arg_461_1.time_ >= 0 + var_464_3 and arg_461_1.time_ < 0 + var_464_3 + arg_464_0 and not isNil(var_464_2) and arg_461_1.var_.characterEffect1027ui_story then
				arg_461_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_461_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_464_4 = 0
			local var_464_5 = 0.425

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_4 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_6 = arg_461_1:GetWordFromCfg(1102701114)
				local var_464_7 = arg_461_1:FormatText(var_464_6.content)

				arg_461_1.text_.text = var_464_7

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_9 = 17 <= 0 and var_464_5 or var_464_5 * (utf8.len(var_464_7) / 17)

				if (17 <= 0 and var_464_5 or var_464_5 * (utf8.len(var_464_7) / 17)) > 0 and var_464_5 < var_464_9 then
					arg_461_1.talkMaxDuration = var_464_9

					if var_464_9 + var_464_4 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_9 + var_464_4
					end
				end

				arg_461_1.text_.text = var_464_7
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701114", "story_v_side_new_1102701.awb") ~= 0 then
					local var_464_10 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701114", "story_v_side_new_1102701.awb") / 1000

					if var_464_10 + var_464_4 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_10 + var_464_4
					end

					if var_464_6.prefab_name ~= "" and arg_461_1.actors_[var_464_6.prefab_name] ~= nil then
						local var_464_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_6.prefab_name].transform, "story_v_side_new_1102701", "1102701114", "story_v_side_new_1102701.awb")

						arg_461_1:RecordAudio("1102701114", var_464_11)
						arg_461_1:RecordAudio("1102701114", var_464_11)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701114", "story_v_side_new_1102701.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701114", "story_v_side_new_1102701.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_12 = math.max(var_464_5, arg_461_1.talkMaxDuration)

			if var_464_4 <= arg_461_1.time_ and arg_461_1.time_ < var_464_4 + var_464_12 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_4) / var_464_12

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_4 + var_464_12 and arg_461_1.time_ < var_464_4 + var_464_12 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play1102701115 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 1102701115
		arg_465_1.duration_ = 15

		local var_465_0 = {
			ja = 15,
			ko = 9.1,
			zh = 9.1
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
				arg_465_0:Play1102701116(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 and not isNil(arg_465_1.actors_["1066ui_story"]) and arg_465_1.var_.characterEffect1066ui_story == nil then
				arg_465_1.var_.characterEffect1066ui_story = arg_465_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_0 = 0.200000002980232

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_0 and not isNil(arg_465_1.actors_["1066ui_story"]) then
				if arg_465_1.var_.characterEffect1066ui_story and not isNil(arg_465_1.actors_["1066ui_story"]) then
					arg_465_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_465_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_465_1.time_ - 0) / var_468_0)
				end
			end

			if arg_465_1.time_ >= 0 + var_468_0 and arg_465_1.time_ < 0 + var_468_0 + arg_468_0 and not isNil(arg_465_1.actors_["1066ui_story"]) and arg_465_1.var_.characterEffect1066ui_story then
				arg_465_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_465_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action7_2")
			end

			local var_468_1 = 0
			local var_468_2 = 1.125

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_1 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				arg_465_1.leftNameTxt_.text = arg_465_1:FormatText(StoryNameCfg[203].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, true)
				arg_465_1.iconController_:SetSelectedState("hero")

				arg_465_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10013")

				arg_465_1.callingController_:SetSelectedState("normal")

				arg_465_1.keyicon_.color = Color.New(1, 1, 1)
				arg_465_1.icon_.color = Color.New(1, 1, 1)

				local var_468_3 = arg_465_1:GetWordFromCfg(1102701115)
				local var_468_4 = arg_465_1:FormatText(var_468_3.content)

				arg_465_1.text_.text = var_468_4

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_6 = 45 <= 0 and var_468_2 or var_468_2 * (utf8.len(var_468_4) / 45)

				if (45 <= 0 and var_468_2 or var_468_2 * (utf8.len(var_468_4) / 45)) > 0 and var_468_2 < var_468_6 then
					arg_465_1.talkMaxDuration = var_468_6

					if var_468_6 + var_468_1 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_6 + var_468_1
					end
				end

				arg_465_1.text_.text = var_468_4
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701115", "story_v_side_new_1102701.awb") ~= 0 then
					local var_468_7 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701115", "story_v_side_new_1102701.awb") / 1000

					if var_468_7 + var_468_1 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_7 + var_468_1
					end

					if var_468_3.prefab_name ~= "" and arg_465_1.actors_[var_468_3.prefab_name] ~= nil then
						local var_468_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_3.prefab_name].transform, "story_v_side_new_1102701", "1102701115", "story_v_side_new_1102701.awb")

						arg_465_1:RecordAudio("1102701115", var_468_8)
						arg_465_1:RecordAudio("1102701115", var_468_8)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701115", "story_v_side_new_1102701.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701115", "story_v_side_new_1102701.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_9 = math.max(var_468_2, arg_465_1.talkMaxDuration)

			if var_468_1 <= arg_465_1.time_ and arg_465_1.time_ < var_468_1 + var_468_9 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_1) / var_468_9

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_1 + var_468_9 and arg_465_1.time_ < var_468_1 + var_468_9 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play1102701116 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 1102701116
		arg_469_1.duration_ = 5.53

		local var_469_0 = {
			ja = 5.1,
			ko = 5.533,
			zh = 5.533
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
				arg_469_0:Play1102701117(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 and not isNil(arg_469_1.actors_["1066ui_story"]) and arg_469_1.var_.characterEffect1066ui_story == nil then
				arg_469_1.var_.characterEffect1066ui_story = arg_469_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_0 = 0.200000002980232

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_0 and not isNil(arg_469_1.actors_["1066ui_story"]) then
				if arg_469_1.var_.characterEffect1066ui_story and not isNil(arg_469_1.actors_["1066ui_story"]) then
					arg_469_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_469_1.time_ >= 0 + var_472_0 and arg_469_1.time_ < 0 + var_472_0 + arg_472_0 and not isNil(arg_469_1.actors_["1066ui_story"]) and arg_469_1.var_.characterEffect1066ui_story then
				arg_469_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_1")
			end

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_472_2 = 0
			local var_472_3 = 0.525

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_2 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				arg_469_1.leftNameTxt_.text = arg_469_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_4 = arg_469_1:GetWordFromCfg(1102701116)
				local var_472_5 = arg_469_1:FormatText(var_472_4.content)

				arg_469_1.text_.text = var_472_5

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_7 = 21 <= 0 and var_472_3 or var_472_3 * (utf8.len(var_472_5) / 21)

				if (21 <= 0 and var_472_3 or var_472_3 * (utf8.len(var_472_5) / 21)) > 0 and var_472_3 < var_472_7 then
					arg_469_1.talkMaxDuration = var_472_7

					if var_472_7 + var_472_2 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_7 + var_472_2
					end
				end

				arg_469_1.text_.text = var_472_5
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701116", "story_v_side_new_1102701.awb") ~= 0 then
					local var_472_8 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701116", "story_v_side_new_1102701.awb") / 1000

					if var_472_8 + var_472_2 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_8 + var_472_2
					end

					if var_472_4.prefab_name ~= "" and arg_469_1.actors_[var_472_4.prefab_name] ~= nil then
						local var_472_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_4.prefab_name].transform, "story_v_side_new_1102701", "1102701116", "story_v_side_new_1102701.awb")

						arg_469_1:RecordAudio("1102701116", var_472_9)
						arg_469_1:RecordAudio("1102701116", var_472_9)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701116", "story_v_side_new_1102701.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701116", "story_v_side_new_1102701.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_10 = math.max(var_472_3, arg_469_1.talkMaxDuration)

			if var_472_2 <= arg_469_1.time_ and arg_469_1.time_ < var_472_2 + var_472_10 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_2) / var_472_10

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_2 + var_472_10 and arg_469_1.time_ < var_472_2 + var_472_10 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play1102701117 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 1102701117
		arg_473_1.duration_ = 15.23

		local var_473_0 = {
			ja = 15.233,
			ko = 11.133,
			zh = 11.133
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
				arg_473_0:Play1102701118(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 and not isNil(arg_473_1.actors_["1066ui_story"]) and arg_473_1.var_.characterEffect1066ui_story == nil then
				arg_473_1.var_.characterEffect1066ui_story = arg_473_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_0 = 0.200000002980232

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_0 and not isNil(arg_473_1.actors_["1066ui_story"]) then
				if arg_473_1.var_.characterEffect1066ui_story and not isNil(arg_473_1.actors_["1066ui_story"]) then
					arg_473_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_473_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_473_1.time_ - 0) / var_476_0)
				end
			end

			if arg_473_1.time_ >= 0 + var_476_0 and arg_473_1.time_ < 0 + var_476_0 + arg_476_0 and not isNil(arg_473_1.actors_["1066ui_story"]) and arg_473_1.var_.characterEffect1066ui_story then
				arg_473_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_473_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_476_1 = 0
			local var_476_2 = 1.175

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_1 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[203].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, true)
				arg_473_1.iconController_:SetSelectedState("hero")

				arg_473_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10013")

				arg_473_1.callingController_:SetSelectedState("normal")

				arg_473_1.keyicon_.color = Color.New(1, 1, 1)
				arg_473_1.icon_.color = Color.New(1, 1, 1)

				local var_476_3 = arg_473_1:GetWordFromCfg(1102701117)
				local var_476_4 = arg_473_1:FormatText(var_476_3.content)

				arg_473_1.text_.text = var_476_4

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_6 = 47 <= 0 and var_476_2 or var_476_2 * (utf8.len(var_476_4) / 47)

				if (47 <= 0 and var_476_2 or var_476_2 * (utf8.len(var_476_4) / 47)) > 0 and var_476_2 < var_476_6 then
					arg_473_1.talkMaxDuration = var_476_6

					if var_476_6 + var_476_1 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_6 + var_476_1
					end
				end

				arg_473_1.text_.text = var_476_4
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701117", "story_v_side_new_1102701.awb") ~= 0 then
					local var_476_7 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701117", "story_v_side_new_1102701.awb") / 1000

					if var_476_7 + var_476_1 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_7 + var_476_1
					end

					if var_476_3.prefab_name ~= "" and arg_473_1.actors_[var_476_3.prefab_name] ~= nil then
						local var_476_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_3.prefab_name].transform, "story_v_side_new_1102701", "1102701117", "story_v_side_new_1102701.awb")

						arg_473_1:RecordAudio("1102701117", var_476_8)
						arg_473_1:RecordAudio("1102701117", var_476_8)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701117", "story_v_side_new_1102701.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701117", "story_v_side_new_1102701.awb")
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

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play1102701118 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 1102701118
		arg_477_1.duration_ = 8.1

		local var_477_0 = {
			ja = 8.1,
			ko = 5,
			zh = 5
		}
		local var_477_1 = manager.audio:GetLocalizationFlag()

		if var_477_0[var_477_1] ~= nil then
			arg_477_1.duration_ = var_477_0[var_477_1]
		end

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play1102701119(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 and not isNil(arg_477_1.actors_["1027ui_story"]) and arg_477_1.var_.characterEffect1027ui_story == nil then
				arg_477_1.var_.characterEffect1027ui_story = arg_477_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_0 = 0.200000002980232

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_0 and not isNil(arg_477_1.actors_["1027ui_story"]) then
				if arg_477_1.var_.characterEffect1027ui_story and not isNil(arg_477_1.actors_["1027ui_story"]) then
					arg_477_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_477_1.time_ >= 0 + var_480_0 and arg_477_1.time_ < 0 + var_480_0 + arg_480_0 and not isNil(arg_477_1.actors_["1027ui_story"]) and arg_477_1.var_.characterEffect1027ui_story then
				arg_477_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action6_1")
			end

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_480_2 = 0
			local var_480_3 = 0.725

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_2 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_4 = arg_477_1:GetWordFromCfg(1102701118)
				local var_480_5 = arg_477_1:FormatText(var_480_4.content)

				arg_477_1.text_.text = var_480_5

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_7 = 29 <= 0 and var_480_3 or var_480_3 * (utf8.len(var_480_5) / 29)

				if (29 <= 0 and var_480_3 or var_480_3 * (utf8.len(var_480_5) / 29)) > 0 and var_480_3 < var_480_7 then
					arg_477_1.talkMaxDuration = var_480_7

					if var_480_7 + var_480_2 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_7 + var_480_2
					end
				end

				arg_477_1.text_.text = var_480_5
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701118", "story_v_side_new_1102701.awb") ~= 0 then
					local var_480_8 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701118", "story_v_side_new_1102701.awb") / 1000

					if var_480_8 + var_480_2 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_8 + var_480_2
					end

					if var_480_4.prefab_name ~= "" and arg_477_1.actors_[var_480_4.prefab_name] ~= nil then
						local var_480_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_4.prefab_name].transform, "story_v_side_new_1102701", "1102701118", "story_v_side_new_1102701.awb")

						arg_477_1:RecordAudio("1102701118", var_480_9)
						arg_477_1:RecordAudio("1102701118", var_480_9)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701118", "story_v_side_new_1102701.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701118", "story_v_side_new_1102701.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_10 = math.max(var_480_3, arg_477_1.talkMaxDuration)

			if var_480_2 <= arg_477_1.time_ and arg_477_1.time_ < var_480_2 + var_480_10 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_2) / var_480_10

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_2 + var_480_10 and arg_477_1.time_ < var_480_2 + var_480_10 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play1102701119 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 1102701119
		arg_481_1.duration_ = 2.3

		local var_481_0 = {
			ja = 1.333,
			ko = 2.3,
			zh = 2.3
		}
		local var_481_1 = manager.audio:GetLocalizationFlag()

		if var_481_0[var_481_1] ~= nil then
			arg_481_1.duration_ = var_481_0[var_481_1]
		end

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play1102701120(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 and not isNil(arg_481_1.actors_["1027ui_story"]) and arg_481_1.var_.characterEffect1027ui_story == nil then
				arg_481_1.var_.characterEffect1027ui_story = arg_481_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_0 = 0.200000002980232

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_0 and not isNil(arg_481_1.actors_["1027ui_story"]) then
				if arg_481_1.var_.characterEffect1027ui_story and not isNil(arg_481_1.actors_["1027ui_story"]) then
					arg_481_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_481_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_481_1.time_ - 0) / var_484_0)
				end
			end

			if arg_481_1.time_ >= 0 + var_484_0 and arg_481_1.time_ < 0 + var_484_0 + arg_484_0 and not isNil(arg_481_1.actors_["1027ui_story"]) and arg_481_1.var_.characterEffect1027ui_story then
				arg_481_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_481_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_484_1 = 0
			local var_484_2 = 0.175

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_1 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[203].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, true)
				arg_481_1.iconController_:SetSelectedState("hero")

				arg_481_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10013")

				arg_481_1.callingController_:SetSelectedState("normal")

				arg_481_1.keyicon_.color = Color.New(1, 1, 1)
				arg_481_1.icon_.color = Color.New(1, 1, 1)

				local var_484_3 = arg_481_1:GetWordFromCfg(1102701119)
				local var_484_4 = arg_481_1:FormatText(var_484_3.content)

				arg_481_1.text_.text = var_484_4

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_6 = 7 <= 0 and var_484_2 or var_484_2 * (utf8.len(var_484_4) / 7)

				if (7 <= 0 and var_484_2 or var_484_2 * (utf8.len(var_484_4) / 7)) > 0 and var_484_2 < var_484_6 then
					arg_481_1.talkMaxDuration = var_484_6

					if var_484_6 + var_484_1 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_6 + var_484_1
					end
				end

				arg_481_1.text_.text = var_484_4
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701119", "story_v_side_new_1102701.awb") ~= 0 then
					local var_484_7 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701119", "story_v_side_new_1102701.awb") / 1000

					if var_484_7 + var_484_1 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_7 + var_484_1
					end

					if var_484_3.prefab_name ~= "" and arg_481_1.actors_[var_484_3.prefab_name] ~= nil then
						local var_484_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_3.prefab_name].transform, "story_v_side_new_1102701", "1102701119", "story_v_side_new_1102701.awb")

						arg_481_1:RecordAudio("1102701119", var_484_8)
						arg_481_1:RecordAudio("1102701119", var_484_8)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701119", "story_v_side_new_1102701.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701119", "story_v_side_new_1102701.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_9 = math.max(var_484_2, arg_481_1.talkMaxDuration)

			if var_484_1 <= arg_481_1.time_ and arg_481_1.time_ < var_484_1 + var_484_9 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_1) / var_484_9

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_1 + var_484_9 and arg_481_1.time_ < var_484_1 + var_484_9 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play1102701120 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 1102701120
		arg_485_1.duration_ = 9.7

		local var_485_0 = {
			ja = 6.666,
			ko = 9.7,
			zh = 9.7
		}
		local var_485_1 = manager.audio:GetLocalizationFlag()

		if var_485_0[var_485_1] ~= nil then
			arg_485_1.duration_ = var_485_0[var_485_1]
		end

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play1102701121(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 and not isNil(arg_485_1.actors_["1027ui_story"]) and arg_485_1.var_.characterEffect1027ui_story == nil then
				arg_485_1.var_.characterEffect1027ui_story = arg_485_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_0 = 0.200000002980232

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_0 and not isNil(arg_485_1.actors_["1027ui_story"]) then
				if arg_485_1.var_.characterEffect1027ui_story and not isNil(arg_485_1.actors_["1027ui_story"]) then
					arg_485_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_485_1.time_ >= 0 + var_488_0 and arg_485_1.time_ < 0 + var_488_0 + arg_488_0 and not isNil(arg_485_1.actors_["1027ui_story"]) and arg_485_1.var_.characterEffect1027ui_story then
				arg_485_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action462")
			end

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_488_2 = 0
			local var_488_3 = 1.05

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_2 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				arg_485_1.leftNameTxt_.text = arg_485_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_4 = arg_485_1:GetWordFromCfg(1102701120)
				local var_488_5 = arg_485_1:FormatText(var_488_4.content)

				arg_485_1.text_.text = var_488_5

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_7 = 42 <= 0 and var_488_3 or var_488_3 * (utf8.len(var_488_5) / 42)

				if (42 <= 0 and var_488_3 or var_488_3 * (utf8.len(var_488_5) / 42)) > 0 and var_488_3 < var_488_7 then
					arg_485_1.talkMaxDuration = var_488_7

					if var_488_7 + var_488_2 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_7 + var_488_2
					end
				end

				arg_485_1.text_.text = var_488_5
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701120", "story_v_side_new_1102701.awb") ~= 0 then
					local var_488_8 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701120", "story_v_side_new_1102701.awb") / 1000

					if var_488_8 + var_488_2 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_8 + var_488_2
					end

					if var_488_4.prefab_name ~= "" and arg_485_1.actors_[var_488_4.prefab_name] ~= nil then
						local var_488_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_4.prefab_name].transform, "story_v_side_new_1102701", "1102701120", "story_v_side_new_1102701.awb")

						arg_485_1:RecordAudio("1102701120", var_488_9)
						arg_485_1:RecordAudio("1102701120", var_488_9)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701120", "story_v_side_new_1102701.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701120", "story_v_side_new_1102701.awb")
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
	Play1102701121 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 1102701121
		arg_489_1.duration_ = 5.7

		local var_489_0 = {
			ja = 3.333,
			ko = 5.7,
			zh = 5.7
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
				arg_489_0:Play1102701122(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 and not isNil(arg_489_1.actors_["1027ui_story"]) and arg_489_1.var_.characterEffect1027ui_story == nil then
				arg_489_1.var_.characterEffect1027ui_story = arg_489_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_492_0 = 0.200000002980232

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_0 and not isNil(arg_489_1.actors_["1027ui_story"]) then
				if arg_489_1.var_.characterEffect1027ui_story and not isNil(arg_489_1.actors_["1027ui_story"]) then
					arg_489_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_489_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_489_1.time_ - 0) / var_492_0)
				end
			end

			if arg_489_1.time_ >= 0 + var_492_0 and arg_489_1.time_ < 0 + var_492_0 + arg_492_0 and not isNil(arg_489_1.actors_["1027ui_story"]) and arg_489_1.var_.characterEffect1027ui_story then
				arg_489_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_489_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_492_1 = 0
			local var_492_2 = 0.55

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_1 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				arg_489_1.leftNameTxt_.text = arg_489_1:FormatText(StoryNameCfg[203].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, true)
				arg_489_1.iconController_:SetSelectedState("hero")

				arg_489_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10013")

				arg_489_1.callingController_:SetSelectedState("normal")

				arg_489_1.keyicon_.color = Color.New(1, 1, 1)
				arg_489_1.icon_.color = Color.New(1, 1, 1)

				local var_492_3 = arg_489_1:GetWordFromCfg(1102701121)
				local var_492_4 = arg_489_1:FormatText(var_492_3.content)

				arg_489_1.text_.text = var_492_4

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_6 = 22 <= 0 and var_492_2 or var_492_2 * (utf8.len(var_492_4) / 22)

				if (22 <= 0 and var_492_2 or var_492_2 * (utf8.len(var_492_4) / 22)) > 0 and var_492_2 < var_492_6 then
					arg_489_1.talkMaxDuration = var_492_6

					if var_492_6 + var_492_1 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_6 + var_492_1
					end
				end

				arg_489_1.text_.text = var_492_4
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701121", "story_v_side_new_1102701.awb") ~= 0 then
					local var_492_7 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701121", "story_v_side_new_1102701.awb") / 1000

					if var_492_7 + var_492_1 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_7 + var_492_1
					end

					if var_492_3.prefab_name ~= "" and arg_489_1.actors_[var_492_3.prefab_name] ~= nil then
						local var_492_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_489_1.actors_[var_492_3.prefab_name].transform, "story_v_side_new_1102701", "1102701121", "story_v_side_new_1102701.awb")

						arg_489_1:RecordAudio("1102701121", var_492_8)
						arg_489_1:RecordAudio("1102701121", var_492_8)
					else
						arg_489_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701121", "story_v_side_new_1102701.awb")
					end

					arg_489_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701121", "story_v_side_new_1102701.awb")
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

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play1102701122 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 1102701122
		arg_493_1.duration_ = 5

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play1102701123(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = 0.975

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

				local var_496_1 = arg_493_1:FormatText(arg_493_1:GetWordFromCfg(1102701122).content)

				arg_493_1.text_.text = var_496_1

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_3 = 39 <= 0 and var_496_0 or var_496_0 * (utf8.len(var_496_1) / 39)

				if (39 <= 0 and var_496_0 or var_496_0 * (utf8.len(var_496_1) / 39)) > 0 and var_496_0 < var_496_3 then
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
	Play1102701123 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 1102701123
		arg_497_1.duration_ = 9.1

		local var_497_0 = {
			ja = 6.9,
			ko = 9.1,
			zh = 9.1
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
				arg_497_0:Play1102701124(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 and not isNil(arg_497_1.actors_["1066ui_story"]) and arg_497_1.var_.characterEffect1066ui_story == nil then
				arg_497_1.var_.characterEffect1066ui_story = arg_497_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_500_0 = 0.200000002980232

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_0 and not isNil(arg_497_1.actors_["1066ui_story"]) then
				if arg_497_1.var_.characterEffect1066ui_story and not isNil(arg_497_1.actors_["1066ui_story"]) then
					arg_497_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_497_1.time_ >= 0 + var_500_0 and arg_497_1.time_ < 0 + var_500_0 + arg_500_0 and not isNil(arg_497_1.actors_["1066ui_story"]) and arg_497_1.var_.characterEffect1066ui_story then
				arg_497_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_500_2 = 0
			local var_500_3 = 1.2

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_2 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				arg_497_1.leftNameTxt_.text = arg_497_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_4 = arg_497_1:GetWordFromCfg(1102701123)
				local var_500_5 = arg_497_1:FormatText(var_500_4.content)

				arg_497_1.text_.text = var_500_5

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_7 = 48 <= 0 and var_500_3 or var_500_3 * (utf8.len(var_500_5) / 48)

				if (48 <= 0 and var_500_3 or var_500_3 * (utf8.len(var_500_5) / 48)) > 0 and var_500_3 < var_500_7 then
					arg_497_1.talkMaxDuration = var_500_7

					if var_500_7 + var_500_2 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_7 + var_500_2
					end
				end

				arg_497_1.text_.text = var_500_5
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701123", "story_v_side_new_1102701.awb") ~= 0 then
					local var_500_8 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701123", "story_v_side_new_1102701.awb") / 1000

					if var_500_8 + var_500_2 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_8 + var_500_2
					end

					if var_500_4.prefab_name ~= "" and arg_497_1.actors_[var_500_4.prefab_name] ~= nil then
						local var_500_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_497_1.actors_[var_500_4.prefab_name].transform, "story_v_side_new_1102701", "1102701123", "story_v_side_new_1102701.awb")

						arg_497_1:RecordAudio("1102701123", var_500_9)
						arg_497_1:RecordAudio("1102701123", var_500_9)
					else
						arg_497_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701123", "story_v_side_new_1102701.awb")
					end

					arg_497_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701123", "story_v_side_new_1102701.awb")
				end

				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_10 = math.max(var_500_3, arg_497_1.talkMaxDuration)

			if var_500_2 <= arg_497_1.time_ and arg_497_1.time_ < var_500_2 + var_500_10 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_2) / var_500_10

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_2 + var_500_10 and arg_497_1.time_ < var_500_2 + var_500_10 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play1102701124 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 1102701124
		arg_501_1.duration_ = 5

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play1102701125(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 and not isNil(arg_501_1.actors_["1066ui_story"]) and arg_501_1.var_.characterEffect1066ui_story == nil then
				arg_501_1.var_.characterEffect1066ui_story = arg_501_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_504_0 = 0.200000002980232

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_0 and not isNil(arg_501_1.actors_["1066ui_story"]) then
				if arg_501_1.var_.characterEffect1066ui_story and not isNil(arg_501_1.actors_["1066ui_story"]) then
					arg_501_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_501_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_501_1.time_ - 0) / var_504_0)
				end
			end

			if arg_501_1.time_ >= 0 + var_504_0 and arg_501_1.time_ < 0 + var_504_0 + arg_504_0 and not isNil(arg_501_1.actors_["1066ui_story"]) and arg_501_1.var_.characterEffect1066ui_story then
				arg_501_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_501_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_504_1 = 0
			local var_504_2 = 0.55

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_1 + arg_504_0 then
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

				local var_504_3 = arg_501_1:FormatText(arg_501_1:GetWordFromCfg(1102701124).content)

				arg_501_1.text_.text = var_504_3

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_5 = 22 <= 0 and var_504_2 or var_504_2 * (utf8.len(var_504_3) / 22)

				if (22 <= 0 and var_504_2 or var_504_2 * (utf8.len(var_504_3) / 22)) > 0 and var_504_2 < var_504_5 then
					arg_501_1.talkMaxDuration = var_504_5

					if var_504_5 + var_504_1 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_5 + var_504_1
					end
				end

				arg_501_1.text_.text = var_504_3
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_6 = math.max(var_504_2, arg_501_1.talkMaxDuration)

			if var_504_1 <= arg_501_1.time_ and arg_501_1.time_ < var_504_1 + var_504_6 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_1) / var_504_6

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_1 + var_504_6 and arg_501_1.time_ < var_504_1 + var_504_6 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play1102701125 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 1102701125
		arg_505_1.duration_ = 19.07

		local var_505_0 = {
			ja = 19.066,
			ko = 6.966,
			zh = 6.966
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
				arg_505_0:Play1102701126(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			local var_508_0 = 0.825

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				arg_505_1.leftNameTxt_.text = arg_505_1:FormatText(StoryNameCfg[203].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, true)
				arg_505_1.iconController_:SetSelectedState("hero")

				arg_505_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10013")

				arg_505_1.callingController_:SetSelectedState("normal")

				arg_505_1.keyicon_.color = Color.New(1, 1, 1)
				arg_505_1.icon_.color = Color.New(1, 1, 1)

				local var_508_1 = arg_505_1:GetWordFromCfg(1102701125)
				local var_508_2 = arg_505_1:FormatText(var_508_1.content)

				arg_505_1.text_.text = var_508_2

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_4 = 33 <= 0 and var_508_0 or var_508_0 * (utf8.len(var_508_2) / 33)

				if (33 <= 0 and var_508_0 or var_508_0 * (utf8.len(var_508_2) / 33)) > 0 and var_508_0 < var_508_4 then
					arg_505_1.talkMaxDuration = var_508_4

					if var_508_4 + 0 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_4 + 0
					end
				end

				arg_505_1.text_.text = var_508_2
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701125", "story_v_side_new_1102701.awb") ~= 0 then
					local var_508_5 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701125", "story_v_side_new_1102701.awb") / 1000

					if var_508_5 + 0 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_5 + 0
					end

					if var_508_1.prefab_name ~= "" and arg_505_1.actors_[var_508_1.prefab_name] ~= nil then
						local var_508_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_505_1.actors_[var_508_1.prefab_name].transform, "story_v_side_new_1102701", "1102701125", "story_v_side_new_1102701.awb")

						arg_505_1:RecordAudio("1102701125", var_508_6)
						arg_505_1:RecordAudio("1102701125", var_508_6)
					else
						arg_505_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701125", "story_v_side_new_1102701.awb")
					end

					arg_505_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701125", "story_v_side_new_1102701.awb")
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
	Play1102701126 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 1102701126
		arg_509_1.duration_ = 13.1

		local var_509_0 = {
			ja = 13.1,
			ko = 8.933,
			zh = 8.933
		}
		local var_509_1 = manager.audio:GetLocalizationFlag()

		if var_509_0[var_509_1] ~= nil then
			arg_509_1.duration_ = var_509_0[var_509_1]
		end

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play1102701127(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			local var_512_0 = 1.05

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				arg_509_1.leftNameTxt_.text = arg_509_1:FormatText(StoryNameCfg[203].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, true)
				arg_509_1.iconController_:SetSelectedState("hero")

				arg_509_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10013")

				arg_509_1.callingController_:SetSelectedState("normal")

				arg_509_1.keyicon_.color = Color.New(1, 1, 1)
				arg_509_1.icon_.color = Color.New(1, 1, 1)

				local var_512_1 = arg_509_1:GetWordFromCfg(1102701126)
				local var_512_2 = arg_509_1:FormatText(var_512_1.content)

				arg_509_1.text_.text = var_512_2

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_4 = 42 <= 0 and var_512_0 or var_512_0 * (utf8.len(var_512_2) / 42)

				if (42 <= 0 and var_512_0 or var_512_0 * (utf8.len(var_512_2) / 42)) > 0 and var_512_0 < var_512_4 then
					arg_509_1.talkMaxDuration = var_512_4

					if var_512_4 + 0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_4 + 0
					end
				end

				arg_509_1.text_.text = var_512_2
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701126", "story_v_side_new_1102701.awb") ~= 0 then
					local var_512_5 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701126", "story_v_side_new_1102701.awb") / 1000

					if var_512_5 + 0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_5 + 0
					end

					if var_512_1.prefab_name ~= "" and arg_509_1.actors_[var_512_1.prefab_name] ~= nil then
						local var_512_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_509_1.actors_[var_512_1.prefab_name].transform, "story_v_side_new_1102701", "1102701126", "story_v_side_new_1102701.awb")

						arg_509_1:RecordAudio("1102701126", var_512_6)
						arg_509_1:RecordAudio("1102701126", var_512_6)
					else
						arg_509_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701126", "story_v_side_new_1102701.awb")
					end

					arg_509_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701126", "story_v_side_new_1102701.awb")
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
	Play1102701127 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 1102701127
		arg_513_1.duration_ = 12.33

		local var_513_0 = {
			ja = 12.333,
			ko = 9.6,
			zh = 9.6
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
				arg_513_0:Play1102701128(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 and not isNil(arg_513_1.actors_["1027ui_story"]) and arg_513_1.var_.characterEffect1027ui_story == nil then
				arg_513_1.var_.characterEffect1027ui_story = arg_513_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_516_0 = 0.200000002980232

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_0 and not isNil(arg_513_1.actors_["1027ui_story"]) then
				if arg_513_1.var_.characterEffect1027ui_story and not isNil(arg_513_1.actors_["1027ui_story"]) then
					arg_513_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_513_1.time_ >= 0 + var_516_0 and arg_513_1.time_ < 0 + var_516_0 + arg_516_0 and not isNil(arg_513_1.actors_["1027ui_story"]) and arg_513_1.var_.characterEffect1027ui_story then
				arg_513_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 then
				arg_513_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_2")
			end

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 then
				arg_513_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_516_2 = 0
			local var_516_3 = 1.05

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= var_516_2 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				arg_513_1.leftNameTxt_.text = arg_513_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_4 = arg_513_1:GetWordFromCfg(1102701127)
				local var_516_5 = arg_513_1:FormatText(var_516_4.content)

				arg_513_1.text_.text = var_516_5

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_7 = 42 <= 0 and var_516_3 or var_516_3 * (utf8.len(var_516_5) / 42)

				if (42 <= 0 and var_516_3 or var_516_3 * (utf8.len(var_516_5) / 42)) > 0 and var_516_3 < var_516_7 then
					arg_513_1.talkMaxDuration = var_516_7

					if var_516_7 + var_516_2 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_7 + var_516_2
					end
				end

				arg_513_1.text_.text = var_516_5
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701127", "story_v_side_new_1102701.awb") ~= 0 then
					local var_516_8 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701127", "story_v_side_new_1102701.awb") / 1000

					if var_516_8 + var_516_2 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_8 + var_516_2
					end

					if var_516_4.prefab_name ~= "" and arg_513_1.actors_[var_516_4.prefab_name] ~= nil then
						local var_516_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_513_1.actors_[var_516_4.prefab_name].transform, "story_v_side_new_1102701", "1102701127", "story_v_side_new_1102701.awb")

						arg_513_1:RecordAudio("1102701127", var_516_9)
						arg_513_1:RecordAudio("1102701127", var_516_9)
					else
						arg_513_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701127", "story_v_side_new_1102701.awb")
					end

					arg_513_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701127", "story_v_side_new_1102701.awb")
				end

				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_10 = math.max(var_516_3, arg_513_1.talkMaxDuration)

			if var_516_2 <= arg_513_1.time_ and arg_513_1.time_ < var_516_2 + var_516_10 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_2) / var_516_10

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_2 + var_516_10 and arg_513_1.time_ < var_516_2 + var_516_10 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play1102701128 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 1102701128
		arg_517_1.duration_ = 3.47

		local var_517_0 = {
			ja = 2.5,
			ko = 3.466,
			zh = 3.466
		}
		local var_517_1 = manager.audio:GetLocalizationFlag()

		if var_517_0[var_517_1] ~= nil then
			arg_517_1.duration_ = var_517_0[var_517_1]
		end

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play1102701129(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 and not isNil(arg_517_1.actors_["1027ui_story"]) and arg_517_1.var_.characterEffect1027ui_story == nil then
				arg_517_1.var_.characterEffect1027ui_story = arg_517_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_520_0 = 0.200000002980232

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_0 and not isNil(arg_517_1.actors_["1027ui_story"]) then
				if arg_517_1.var_.characterEffect1027ui_story and not isNil(arg_517_1.actors_["1027ui_story"]) then
					arg_517_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_517_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_517_1.time_ - 0) / var_520_0)
				end
			end

			if arg_517_1.time_ >= 0 + var_520_0 and arg_517_1.time_ < 0 + var_520_0 + arg_520_0 and not isNil(arg_517_1.actors_["1027ui_story"]) and arg_517_1.var_.characterEffect1027ui_story then
				arg_517_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_517_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_520_1 = 0
			local var_520_2 = 0.275

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_1 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				arg_517_1.leftNameTxt_.text = arg_517_1:FormatText(StoryNameCfg[203].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, true)
				arg_517_1.iconController_:SetSelectedState("hero")

				arg_517_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10013")

				arg_517_1.callingController_:SetSelectedState("normal")

				arg_517_1.keyicon_.color = Color.New(1, 1, 1)
				arg_517_1.icon_.color = Color.New(1, 1, 1)

				local var_520_3 = arg_517_1:GetWordFromCfg(1102701128)
				local var_520_4 = arg_517_1:FormatText(var_520_3.content)

				arg_517_1.text_.text = var_520_4

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_6 = 11 <= 0 and var_520_2 or var_520_2 * (utf8.len(var_520_4) / 11)

				if (11 <= 0 and var_520_2 or var_520_2 * (utf8.len(var_520_4) / 11)) > 0 and var_520_2 < var_520_6 then
					arg_517_1.talkMaxDuration = var_520_6

					if var_520_6 + var_520_1 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_6 + var_520_1
					end
				end

				arg_517_1.text_.text = var_520_4
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701128", "story_v_side_new_1102701.awb") ~= 0 then
					local var_520_7 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701128", "story_v_side_new_1102701.awb") / 1000

					if var_520_7 + var_520_1 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_7 + var_520_1
					end

					if var_520_3.prefab_name ~= "" and arg_517_1.actors_[var_520_3.prefab_name] ~= nil then
						local var_520_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_517_1.actors_[var_520_3.prefab_name].transform, "story_v_side_new_1102701", "1102701128", "story_v_side_new_1102701.awb")

						arg_517_1:RecordAudio("1102701128", var_520_8)
						arg_517_1:RecordAudio("1102701128", var_520_8)
					else
						arg_517_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701128", "story_v_side_new_1102701.awb")
					end

					arg_517_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701128", "story_v_side_new_1102701.awb")
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
	Play1102701129 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 1102701129
		arg_521_1.duration_ = 5

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play1102701130(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = 0.375

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				arg_521_1.leftNameTxt_.text = arg_521_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, true)
				arg_521_1.iconController_:SetSelectedState("hero")

				arg_521_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_521_1.callingController_:SetSelectedState("normal")

				arg_521_1.keyicon_.color = Color.New(1, 1, 1)
				arg_521_1.icon_.color = Color.New(1, 1, 1)

				local var_524_1 = arg_521_1:FormatText(arg_521_1:GetWordFromCfg(1102701129).content)

				arg_521_1.text_.text = var_524_1

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_3 = 15 <= 0 and var_524_0 or var_524_0 * (utf8.len(var_524_1) / 15)

				if (15 <= 0 and var_524_0 or var_524_0 * (utf8.len(var_524_1) / 15)) > 0 and var_524_0 < var_524_3 then
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
	Play1102701130 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 1102701130
		arg_525_1.duration_ = 6.47

		local var_525_0 = {
			ja = 5.466,
			ko = 6.466,
			zh = 6.466
		}
		local var_525_1 = manager.audio:GetLocalizationFlag()

		if var_525_0[var_525_1] ~= nil then
			arg_525_1.duration_ = var_525_0[var_525_1]
		end

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play1102701131(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 and not isNil(arg_525_1.actors_["1066ui_story"]) and arg_525_1.var_.characterEffect1066ui_story == nil then
				arg_525_1.var_.characterEffect1066ui_story = arg_525_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_528_0 = 0.200000002980232

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_0 and not isNil(arg_525_1.actors_["1066ui_story"]) then
				if arg_525_1.var_.characterEffect1066ui_story and not isNil(arg_525_1.actors_["1066ui_story"]) then
					arg_525_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_525_1.time_ >= 0 + var_528_0 and arg_525_1.time_ < 0 + var_528_0 + arg_528_0 and not isNil(arg_525_1.actors_["1066ui_story"]) and arg_525_1.var_.characterEffect1066ui_story then
				arg_525_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_2")
			end

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_528_2 = 0
			local var_528_3 = 0.85

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= var_528_2 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				arg_525_1.leftNameTxt_.text = arg_525_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_4 = arg_525_1:GetWordFromCfg(1102701130)
				local var_528_5 = arg_525_1:FormatText(var_528_4.content)

				arg_525_1.text_.text = var_528_5

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_7 = 34 <= 0 and var_528_3 or var_528_3 * (utf8.len(var_528_5) / 34)

				if (34 <= 0 and var_528_3 or var_528_3 * (utf8.len(var_528_5) / 34)) > 0 and var_528_3 < var_528_7 then
					arg_525_1.talkMaxDuration = var_528_7

					if var_528_7 + var_528_2 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_7 + var_528_2
					end
				end

				arg_525_1.text_.text = var_528_5
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701130", "story_v_side_new_1102701.awb") ~= 0 then
					local var_528_8 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701130", "story_v_side_new_1102701.awb") / 1000

					if var_528_8 + var_528_2 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_8 + var_528_2
					end

					if var_528_4.prefab_name ~= "" and arg_525_1.actors_[var_528_4.prefab_name] ~= nil then
						local var_528_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_525_1.actors_[var_528_4.prefab_name].transform, "story_v_side_new_1102701", "1102701130", "story_v_side_new_1102701.awb")

						arg_525_1:RecordAudio("1102701130", var_528_9)
						arg_525_1:RecordAudio("1102701130", var_528_9)
					else
						arg_525_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701130", "story_v_side_new_1102701.awb")
					end

					arg_525_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701130", "story_v_side_new_1102701.awb")
				end

				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_10 = math.max(var_528_3, arg_525_1.talkMaxDuration)

			if var_528_2 <= arg_525_1.time_ and arg_525_1.time_ < var_528_2 + var_528_10 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_2) / var_528_10

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_2 + var_528_10 and arg_525_1.time_ < var_528_2 + var_528_10 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play1102701131 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 1102701131
		arg_529_1.duration_ = 9.57

		local var_529_0 = {
			ja = 9.566,
			ko = 7.566,
			zh = 7.566
		}
		local var_529_1 = manager.audio:GetLocalizationFlag()

		if var_529_0[var_529_1] ~= nil then
			arg_529_1.duration_ = var_529_0[var_529_1]
		end

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play1102701132(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			local var_532_0 = 1.05

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, true)

				arg_529_1.leftNameTxt_.text = arg_529_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_529_1.leftNameTxt_.transform)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1.leftNameTxt_.text)
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_1 = arg_529_1:GetWordFromCfg(1102701131)
				local var_532_2 = arg_529_1:FormatText(var_532_1.content)

				arg_529_1.text_.text = var_532_2

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_4 = 42 <= 0 and var_532_0 or var_532_0 * (utf8.len(var_532_2) / 42)

				if (42 <= 0 and var_532_0 or var_532_0 * (utf8.len(var_532_2) / 42)) > 0 and var_532_0 < var_532_4 then
					arg_529_1.talkMaxDuration = var_532_4

					if var_532_4 + 0 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_4 + 0
					end
				end

				arg_529_1.text_.text = var_532_2
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701131", "story_v_side_new_1102701.awb") ~= 0 then
					local var_532_5 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701131", "story_v_side_new_1102701.awb") / 1000

					if var_532_5 + 0 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_5 + 0
					end

					if var_532_1.prefab_name ~= "" and arg_529_1.actors_[var_532_1.prefab_name] ~= nil then
						local var_532_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_529_1.actors_[var_532_1.prefab_name].transform, "story_v_side_new_1102701", "1102701131", "story_v_side_new_1102701.awb")

						arg_529_1:RecordAudio("1102701131", var_532_6)
						arg_529_1:RecordAudio("1102701131", var_532_6)
					else
						arg_529_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701131", "story_v_side_new_1102701.awb")
					end

					arg_529_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701131", "story_v_side_new_1102701.awb")
				end

				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_7 = math.max(var_532_0, arg_529_1.talkMaxDuration)

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_7 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - 0) / var_532_7

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= 0 + var_532_7 and arg_529_1.time_ < 0 + var_532_7 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play1102701132 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 1102701132
		arg_533_1.duration_ = 4.57

		local var_533_0 = {
			ja = 4.566,
			ko = 4.5,
			zh = 4.5
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
				arg_533_0:Play1102701133(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			local var_536_0 = 0.625

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				arg_533_1.leftNameTxt_.text = arg_533_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, false)
				arg_533_1.callingController_:SetSelectedState("normal")

				local var_536_1 = arg_533_1:GetWordFromCfg(1102701132)
				local var_536_2 = arg_533_1:FormatText(var_536_1.content)

				arg_533_1.text_.text = var_536_2

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_4 = 25 <= 0 and var_536_0 or var_536_0 * (utf8.len(var_536_2) / 25)

				if (25 <= 0 and var_536_0 or var_536_0 * (utf8.len(var_536_2) / 25)) > 0 and var_536_0 < var_536_4 then
					arg_533_1.talkMaxDuration = var_536_4

					if var_536_4 + 0 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_4 + 0
					end
				end

				arg_533_1.text_.text = var_536_2
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701132", "story_v_side_new_1102701.awb") ~= 0 then
					local var_536_5 = manager.audio:GetVoiceLength("story_v_side_new_1102701", "1102701132", "story_v_side_new_1102701.awb") / 1000

					if var_536_5 + 0 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_5 + 0
					end

					if var_536_1.prefab_name ~= "" and arg_533_1.actors_[var_536_1.prefab_name] ~= nil then
						local var_536_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_533_1.actors_[var_536_1.prefab_name].transform, "story_v_side_new_1102701", "1102701132", "story_v_side_new_1102701.awb")

						arg_533_1:RecordAudio("1102701132", var_536_6)
						arg_533_1:RecordAudio("1102701132", var_536_6)
					else
						arg_533_1:AudioAction("play", "voice", "story_v_side_new_1102701", "1102701132", "story_v_side_new_1102701.awb")
					end

					arg_533_1:RecordHistoryTalkVoice("story_v_side_new_1102701", "1102701132", "story_v_side_new_1102701.awb")
				end

				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_7 = math.max(var_536_0, arg_533_1.talkMaxDuration)

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_7 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - 0) / var_536_7

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= 0 + var_536_7 and arg_533_1.time_ < 0 + var_536_7 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {}

		arg_533_1:InitPlayNodeList()
	end,
	Play1102701133 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 1102701133
		arg_537_1.duration_ = 5

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
			arg_537_1.auto_ = false
		end

		function arg_537_1.playNext_(arg_539_0)
			arg_537_1.onStoryFinished_()
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 and not isNil(arg_537_1.actors_["1066ui_story"]) and arg_537_1.var_.characterEffect1066ui_story == nil then
				arg_537_1.var_.characterEffect1066ui_story = arg_537_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_540_0 = 0.200000002980232

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_0 and not isNil(arg_537_1.actors_["1066ui_story"]) then
				if arg_537_1.var_.characterEffect1066ui_story and not isNil(arg_537_1.actors_["1066ui_story"]) then
					arg_537_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_537_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_537_1.time_ - 0) / var_540_0)
				end
			end

			if arg_537_1.time_ >= 0 + var_540_0 and arg_537_1.time_ < 0 + var_540_0 + arg_540_0 and not isNil(arg_537_1.actors_["1066ui_story"]) and arg_537_1.var_.characterEffect1066ui_story then
				arg_537_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_537_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_540_1 = 0
			local var_540_2 = 0.275

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= var_540_1 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				arg_537_1.leftNameTxt_.text = arg_537_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, true)
				arg_537_1.iconController_:SetSelectedState("hero")

				arg_537_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_537_1.callingController_:SetSelectedState("normal")

				arg_537_1.keyicon_.color = Color.New(1, 1, 1)
				arg_537_1.icon_.color = Color.New(1, 1, 1)

				local var_540_3 = arg_537_1:FormatText(arg_537_1:GetWordFromCfg(1102701133).content)

				arg_537_1.text_.text = var_540_3

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_5 = 11 <= 0 and var_540_2 or var_540_2 * (utf8.len(var_540_3) / 11)

				if (11 <= 0 and var_540_2 or var_540_2 * (utf8.len(var_540_3) / 11)) > 0 and var_540_2 < var_540_5 then
					arg_537_1.talkMaxDuration = var_540_5

					if var_540_5 + var_540_1 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_5 + var_540_1
					end
				end

				arg_537_1.text_.text = var_540_3
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)
				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_6 = math.max(var_540_2, arg_537_1.talkMaxDuration)

			if var_540_1 <= arg_537_1.time_ and arg_537_1.time_ < var_540_1 + var_540_6 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_1) / var_540_6

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_1 + var_540_6 and arg_537_1.time_ < var_540_1 + var_540_6 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B13",
		"TextureConfig/Background/ST04b",
		"TextureConfig/Background/ST10"
	},
	voices = {
		"story_v_side_new_1102701.awb"
	}
}
