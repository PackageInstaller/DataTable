return {
	Play1104201001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1104201001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1104201002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.F01a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F01a")
				var_4_0.name = "F01a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.F01a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.F01a

				arg_1_1.bgs_.F01a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "F01a" then
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

			if 1.53333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.53333333333333 + arg_4_0 then
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

			local var_4_14 = 1.999999999999
			local var_4_15 = 0.975

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1104201001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 39 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 39)

				if (39 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 39)) > 0 and var_4_15 < var_4_19 then
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
	Play1104201002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1104201002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1104201003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.25

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(1104201002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 50 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 50)

				if (50 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 50)) > 0 and var_12_0 < var_12_3 then
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
	Play1104201003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1104201003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1104201004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.9

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(1104201003).content)

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
	Play1104201004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1104201004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1104201005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.975

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

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(1104201004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 39 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 39)

				if (39 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 39)) > 0 and var_20_0 < var_20_3 then
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
	Play1104201005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1104201005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1104201006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.775

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

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(1104201005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 31 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 31)

				if (31 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 31)) > 0 and var_24_0 < var_24_3 then
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
	Play1104201006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1104201006
		arg_25_1.duration_ = 1.93

		local var_25_0 = {
			ja = 1.166,
			ko = 1.933,
			zh = 1.933
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
				arg_25_0:Play1104201007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if arg_25_1.actors_["6045_story"] == nil and not isNil((Asset.Load("Char/" .. "6045_story"))) then
				local var_28_0 = Object.Instantiate(Asset.Load("Char/" .. "6045_story"), arg_25_1.stage_.transform)

				var_28_0.name = "6045_story"
				var_28_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["6045_story"] = var_28_0

				local var_28_1 = var_28_0:GetComponentInChildren(typeof(CharacterEffect))

				var_28_1.enabled = true

				local var_28_2 = GameObjectTools.GetOrAddComponent(var_28_0, typeof(DynamicBoneHelper))

				if var_28_2 then
					var_28_2:EnableDynamicBone(false)
				end

				arg_25_1:ShowWeapon(var_28_1.transform, false)

				arg_25_1.var_["6045_story" .. "Animator"] = var_28_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_25_1.var_["6045_story" .. "Animator"].applyRootMotion = true
				arg_25_1.var_["6045_story" .. "LipSync"] = var_28_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_28_3 = arg_25_1.actors_["6045_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos6045_story = var_28_3.localPosition

				local var_28_4 = GameObjectTools.GetOrAddComponent(var_28_3.gameObject, typeof(DynamicBoneHelper))

				if var_28_4 then
					var_28_4:EnableDynamicBone(false)
				end
			end

			local var_28_5 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_5 then
				var_28_3.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos6045_story, Vector3.New(0, -0.5, -6.3), (arg_25_1.time_ - 0) / var_28_5)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_5 and arg_25_1.time_ < 0 + var_28_5 + arg_28_0 then
				var_28_3.localPosition = Vector3.New(0, -0.5, -6.3)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles

				local var_28_6 = GameObjectTools.GetOrAddComponent(var_28_3.gameObject, typeof(DynamicBoneHelper))

				if var_28_6 then
					var_28_6:EnableDynamicBone(true)
				end
			end

			local var_28_7 = arg_25_1.actors_["6045_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.characterEffect6045_story == nil then
				arg_25_1.var_.characterEffect6045_story = var_28_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_8 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_8 and not isNil(var_28_7) then
				if arg_25_1.var_.characterEffect6045_story and not isNil(var_28_7) then
					arg_25_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_8 and arg_25_1.time_ < 0 + var_28_8 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.characterEffect6045_story then
				arg_25_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_10 = 0
			local var_28_11 = 0.125

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_12 = arg_25_1:GetWordFromCfg(1104201006)
				local var_28_13 = arg_25_1:FormatText(var_28_12.content)

				arg_25_1.text_.text = var_28_13

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_15 = 5 <= 0 and var_28_11 or var_28_11 * (utf8.len(var_28_13) / 5)

				if (5 <= 0 and var_28_11 or var_28_11 * (utf8.len(var_28_13) / 5)) > 0 and var_28_11 < var_28_15 then
					arg_25_1.talkMaxDuration = var_28_15

					if var_28_15 + var_28_10 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_15 + var_28_10
					end
				end

				arg_25_1.text_.text = var_28_13
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201006", "story_v_side_new_1104201.awb") ~= 0 then
					local var_28_16 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201006", "story_v_side_new_1104201.awb") / 1000

					if var_28_16 + var_28_10 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_16 + var_28_10
					end

					if var_28_12.prefab_name ~= "" and arg_25_1.actors_[var_28_12.prefab_name] ~= nil then
						local var_28_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_12.prefab_name].transform, "story_v_side_new_1104201", "1104201006", "story_v_side_new_1104201.awb")

						arg_25_1:RecordAudio("1104201006", var_28_17)
						arg_25_1:RecordAudio("1104201006", var_28_17)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201006", "story_v_side_new_1104201.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201006", "story_v_side_new_1104201.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_18 = math.max(var_28_11, arg_25_1.talkMaxDuration)

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_18 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_10) / var_28_18

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_10 + var_28_18 and arg_25_1.time_ < var_28_10 + var_28_18 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
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
	Play1104201007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1104201007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1104201008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["6045_story"]) and arg_29_1.var_.characterEffect6045_story == nil then
				arg_29_1.var_.characterEffect6045_story = arg_29_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["6045_story"]) then
				if arg_29_1.var_.characterEffect6045_story and not isNil(arg_29_1.actors_["6045_story"]) then
					arg_29_1.var_.characterEffect6045_story.fillFlat = true
					arg_29_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_0)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["6045_story"]) and arg_29_1.var_.characterEffect6045_story then
				arg_29_1.var_.characterEffect6045_story.fillFlat = true
				arg_29_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_32_1 = 0
			local var_32_2 = 0.45

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

				local var_32_3 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(1104201007).content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 18 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 18)

				if (18 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 18)) > 0 and var_32_2 < var_32_5 then
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
	Play1104201008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1104201008
		arg_33_1.duration_ = 7.53

		local var_33_0 = {
			ja = 7.333,
			ko = 7.533,
			zh = 7.533
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
				arg_33_0:Play1104201009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos6045_story = arg_33_1.actors_["6045_story"].transform.localPosition

				local var_36_0 = GameObjectTools.GetOrAddComponent(arg_33_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_36_0 then
					var_36_0:EnableDynamicBone(false)
				end
			end

			local var_36_1 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_1 then
				arg_33_1.actors_["6045_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos6045_story, Vector3.New(-0.7, -0.5, -6.3), (arg_33_1.time_ - 0) / var_36_1)
				arg_33_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["6045_story"].transform.position).z)
				arg_33_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["6045_story"].transform.localEulerAngles = arg_33_1.actors_["6045_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_1 and arg_33_1.time_ < 0 + var_36_1 + arg_36_0 then
				arg_33_1.actors_["6045_story"].transform.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				arg_33_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["6045_story"].transform.position).z)
				arg_33_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["6045_story"].transform.localEulerAngles = arg_33_1.actors_["6045_story"].transform.localEulerAngles

				local var_36_2 = GameObjectTools.GetOrAddComponent(arg_33_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_36_2 then
					var_36_2:EnableDynamicBone(true)
				end
			end

			local var_36_3 = arg_33_1.actors_["6045_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_3) and arg_33_1.var_.characterEffect6045_story == nil then
				arg_33_1.var_.characterEffect6045_story = var_36_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_4 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 and not isNil(var_36_3) then
				if arg_33_1.var_.characterEffect6045_story and not isNil(var_36_3) then
					arg_33_1.var_.characterEffect6045_story.fillFlat = true
					arg_33_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_4)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 and not isNil(var_36_3) and arg_33_1.var_.characterEffect6045_story then
				arg_33_1.var_.characterEffect6045_story.fillFlat = true
				arg_33_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_36_5 = "6046_story"

			if arg_33_1.actors_["6046_story"] == nil and not isNil((Asset.Load("Char/" .. "6046_story"))) then
				local var_36_6 = Object.Instantiate(Asset.Load("Char/" .. "6046_story"), arg_33_1.stage_.transform)

				var_36_6.name = var_36_5
				var_36_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_[var_36_5] = var_36_6

				local var_36_7 = var_36_6:GetComponentInChildren(typeof(CharacterEffect))

				var_36_7.enabled = true

				local var_36_8 = GameObjectTools.GetOrAddComponent(var_36_6, typeof(DynamicBoneHelper))

				if var_36_8 then
					var_36_8:EnableDynamicBone(false)
				end

				arg_33_1:ShowWeapon(var_36_7.transform, false)

				arg_33_1.var_[var_36_5 .. "Animator"] = var_36_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_33_1.var_[var_36_5 .. "Animator"].applyRootMotion = true
				arg_33_1.var_[var_36_5 .. "LipSync"] = var_36_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_36_9 = arg_33_1.actors_["6046_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos6046_story = var_36_9.localPosition

				local var_36_10 = GameObjectTools.GetOrAddComponent(var_36_9.gameObject, typeof(DynamicBoneHelper))

				if var_36_10 then
					var_36_10:EnableDynamicBone(false)
				end
			end

			local var_36_11 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_11 then
				var_36_9.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos6046_story, Vector3.New(0.7, -0.5, -6.3), (arg_33_1.time_ - 0) / var_36_11)
				var_36_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_9.position).x, (manager.ui.mainCamera.transform.position - var_36_9.position).y, (manager.ui.mainCamera.transform.position - var_36_9.position).z)
				var_36_9.localEulerAngles.z = 0
				var_36_9.localEulerAngles.x = 0
				var_36_9.localEulerAngles = var_36_9.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_11 and arg_33_1.time_ < 0 + var_36_11 + arg_36_0 then
				var_36_9.localPosition = Vector3.New(0.7, -0.5, -6.3)
				var_36_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_9.position).x, (manager.ui.mainCamera.transform.position - var_36_9.position).y, (manager.ui.mainCamera.transform.position - var_36_9.position).z)
				var_36_9.localEulerAngles.z = 0
				var_36_9.localEulerAngles.x = 0
				var_36_9.localEulerAngles = var_36_9.localEulerAngles

				local var_36_12 = GameObjectTools.GetOrAddComponent(var_36_9.gameObject, typeof(DynamicBoneHelper))

				if var_36_12 then
					var_36_12:EnableDynamicBone(true)
				end
			end

			local var_36_13 = arg_33_1.actors_["6046_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_13) and arg_33_1.var_.characterEffect6046_story == nil then
				arg_33_1.var_.characterEffect6046_story = var_36_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_14 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_14 and not isNil(var_36_13) then
				if arg_33_1.var_.characterEffect6046_story and not isNil(var_36_13) then
					arg_33_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_14 and arg_33_1.time_ < 0 + var_36_14 + arg_36_0 and not isNil(var_36_13) and arg_33_1.var_.characterEffect6046_story then
				arg_33_1.var_.characterEffect6046_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_16 = 0
			local var_36_17 = 0.725

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_16 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_18 = arg_33_1:GetWordFromCfg(1104201008)
				local var_36_19 = arg_33_1:FormatText(var_36_18.content)

				arg_33_1.text_.text = var_36_19

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_21 = 29 <= 0 and var_36_17 or var_36_17 * (utf8.len(var_36_19) / 29)

				if (29 <= 0 and var_36_17 or var_36_17 * (utf8.len(var_36_19) / 29)) > 0 and var_36_17 < var_36_21 then
					arg_33_1.talkMaxDuration = var_36_21

					if var_36_21 + var_36_16 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_21 + var_36_16
					end
				end

				arg_33_1.text_.text = var_36_19
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201008", "story_v_side_new_1104201.awb") ~= 0 then
					local var_36_22 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201008", "story_v_side_new_1104201.awb") / 1000

					if var_36_22 + var_36_16 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_22 + var_36_16
					end

					if var_36_18.prefab_name ~= "" and arg_33_1.actors_[var_36_18.prefab_name] ~= nil then
						local var_36_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_18.prefab_name].transform, "story_v_side_new_1104201", "1104201008", "story_v_side_new_1104201.awb")

						arg_33_1:RecordAudio("1104201008", var_36_23)
						arg_33_1:RecordAudio("1104201008", var_36_23)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201008", "story_v_side_new_1104201.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201008", "story_v_side_new_1104201.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_24 = math.max(var_36_17, arg_33_1.talkMaxDuration)

			if var_36_16 <= arg_33_1.time_ and arg_33_1.time_ < var_36_16 + var_36_24 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_16) / var_36_24

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_16 + var_36_24 and arg_33_1.time_ < var_36_16 + var_36_24 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
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
	Play1104201009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1104201009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1104201010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["6046_story"]) and arg_37_1.var_.characterEffect6046_story == nil then
				arg_37_1.var_.characterEffect6046_story = arg_37_1.actors_["6046_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["6046_story"]) then
				if arg_37_1.var_.characterEffect6046_story and not isNil(arg_37_1.actors_["6046_story"]) then
					arg_37_1.var_.characterEffect6046_story.fillFlat = true
					arg_37_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["6046_story"]) and arg_37_1.var_.characterEffect6046_story then
				arg_37_1.var_.characterEffect6046_story.fillFlat = true
				arg_37_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_40_1 = 0
			local var_40_2 = 0.425

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
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

				local var_40_3 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(1104201009).content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 17 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 17)

				if (17 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 17)) > 0 and var_40_2 < var_40_5 then
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
	Play1104201010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1104201010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1104201011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.65

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

				local var_44_1 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(1104201010).content)

				arg_41_1.text_.text = var_44_1

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_3 = 26 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 26)

				if (26 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 26)) > 0 and var_44_0 < var_44_3 then
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
	Play1104201011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1104201011
		arg_45_1.duration_ = 12.13

		local var_45_0 = {
			ja = 12.133,
			ko = 9.233,
			zh = 9.233
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
				arg_45_0:Play1104201012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["6046_story"]) and arg_45_1.var_.characterEffect6046_story == nil then
				arg_45_1.var_.characterEffect6046_story = arg_45_1.actors_["6046_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["6046_story"]) then
				if arg_45_1.var_.characterEffect6046_story and not isNil(arg_45_1.actors_["6046_story"]) then
					arg_45_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["6046_story"]) and arg_45_1.var_.characterEffect6046_story then
				arg_45_1.var_.characterEffect6046_story.fillFlat = false
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_2")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_48_2 = 0
			local var_48_3 = 0.925

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_4 = arg_45_1:GetWordFromCfg(1104201011)
				local var_48_5 = arg_45_1:FormatText(var_48_4.content)

				arg_45_1.text_.text = var_48_5

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_7 = 37 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 37)

				if (37 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 37)) > 0 and var_48_3 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_2
					end
				end

				arg_45_1.text_.text = var_48_5
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201011", "story_v_side_new_1104201.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201011", "story_v_side_new_1104201.awb") / 1000

					if var_48_8 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_2
					end

					if var_48_4.prefab_name ~= "" and arg_45_1.actors_[var_48_4.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_4.prefab_name].transform, "story_v_side_new_1104201", "1104201011", "story_v_side_new_1104201.awb")

						arg_45_1:RecordAudio("1104201011", var_48_9)
						arg_45_1:RecordAudio("1104201011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201011", "story_v_side_new_1104201.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201011", "story_v_side_new_1104201.awb")
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
	Play1104201012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1104201012
		arg_49_1.duration_ = 4.4

		local var_49_0 = {
			ja = 3.566,
			ko = 4.4,
			zh = 4.4
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
				arg_49_0:Play1104201013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["6045_story"]) and arg_49_1.var_.characterEffect6045_story == nil then
				arg_49_1.var_.characterEffect6045_story = arg_49_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["6045_story"]) then
				if arg_49_1.var_.characterEffect6045_story and not isNil(arg_49_1.actors_["6045_story"]) then
					arg_49_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["6045_story"]) and arg_49_1.var_.characterEffect6045_story then
				arg_49_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_1")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_52_2 = arg_49_1.actors_["6046_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.characterEffect6046_story == nil then
				arg_49_1.var_.characterEffect6046_story = var_52_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_3 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_3 and not isNil(var_52_2) then
				if arg_49_1.var_.characterEffect6046_story and not isNil(var_52_2) then
					arg_49_1.var_.characterEffect6046_story.fillFlat = true
					arg_49_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_3)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_3 and arg_49_1.time_ < 0 + var_52_3 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.characterEffect6046_story then
				arg_49_1.var_.characterEffect6046_story.fillFlat = true
				arg_49_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_52_4 = 0
			local var_52_5 = 0.4

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_6 = arg_49_1:GetWordFromCfg(1104201012)
				local var_52_7 = arg_49_1:FormatText(var_52_6.content)

				arg_49_1.text_.text = var_52_7

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 16 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 16)

				if (16 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 16)) > 0 and var_52_5 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_4
					end
				end

				arg_49_1.text_.text = var_52_7
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201012", "story_v_side_new_1104201.awb") ~= 0 then
					local var_52_10 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201012", "story_v_side_new_1104201.awb") / 1000

					if var_52_10 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_4
					end

					if var_52_6.prefab_name ~= "" and arg_49_1.actors_[var_52_6.prefab_name] ~= nil then
						local var_52_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_6.prefab_name].transform, "story_v_side_new_1104201", "1104201012", "story_v_side_new_1104201.awb")

						arg_49_1:RecordAudio("1104201012", var_52_11)
						arg_49_1:RecordAudio("1104201012", var_52_11)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201012", "story_v_side_new_1104201.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201012", "story_v_side_new_1104201.awb")
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

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play1104201013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1104201013
		arg_53_1.duration_ = 5.07

		local var_53_0 = {
			ja = 5.066,
			ko = 3.866,
			zh = 3.866
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
				arg_53_0:Play1104201014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["6046_story"]) and arg_53_1.var_.characterEffect6046_story == nil then
				arg_53_1.var_.characterEffect6046_story = arg_53_1.actors_["6046_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["6046_story"]) then
				if arg_53_1.var_.characterEffect6046_story and not isNil(arg_53_1.actors_["6046_story"]) then
					arg_53_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["6046_story"]) and arg_53_1.var_.characterEffect6046_story then
				arg_53_1.var_.characterEffect6046_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_56_2 = arg_53_1.actors_["6045_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.characterEffect6045_story == nil then
				arg_53_1.var_.characterEffect6045_story = var_56_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_3 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_3 and not isNil(var_56_2) then
				if arg_53_1.var_.characterEffect6045_story and not isNil(var_56_2) then
					arg_53_1.var_.characterEffect6045_story.fillFlat = true
					arg_53_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_3)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_3 and arg_53_1.time_ < 0 + var_56_3 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.characterEffect6045_story then
				arg_53_1.var_.characterEffect6045_story.fillFlat = true
				arg_53_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_56_4 = 0
			local var_56_5 = 0.4

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_6 = arg_53_1:GetWordFromCfg(1104201013)
				local var_56_7 = arg_53_1:FormatText(var_56_6.content)

				arg_53_1.text_.text = var_56_7

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 16 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 16)

				if (16 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 16)) > 0 and var_56_5 < var_56_9 then
					arg_53_1.talkMaxDuration = var_56_9

					if var_56_9 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_7
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201013", "story_v_side_new_1104201.awb") ~= 0 then
					local var_56_10 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201013", "story_v_side_new_1104201.awb") / 1000

					if var_56_10 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_4
					end

					if var_56_6.prefab_name ~= "" and arg_53_1.actors_[var_56_6.prefab_name] ~= nil then
						local var_56_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_6.prefab_name].transform, "story_v_side_new_1104201", "1104201013", "story_v_side_new_1104201.awb")

						arg_53_1:RecordAudio("1104201013", var_56_11)
						arg_53_1:RecordAudio("1104201013", var_56_11)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201013", "story_v_side_new_1104201.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201013", "story_v_side_new_1104201.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_12 = math.max(var_56_5, arg_53_1.talkMaxDuration)

			if var_56_4 <= arg_53_1.time_ and arg_53_1.time_ < var_56_4 + var_56_12 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_4) / var_56_12

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_4 + var_56_12 and arg_53_1.time_ < var_56_4 + var_56_12 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play1104201014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1104201014
		arg_57_1.duration_ = 5.97

		local var_57_0 = {
			ja = 5.966,
			ko = 5.866,
			zh = 5.866
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
				arg_57_0:Play1104201015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["6045_story"]) and arg_57_1.var_.characterEffect6045_story == nil then
				arg_57_1.var_.characterEffect6045_story = arg_57_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["6045_story"]) then
				if arg_57_1.var_.characterEffect6045_story and not isNil(arg_57_1.actors_["6045_story"]) then
					arg_57_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["6045_story"]) and arg_57_1.var_.characterEffect6045_story then
				arg_57_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_2")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_60_2 = arg_57_1.actors_["6046_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.characterEffect6046_story == nil then
				arg_57_1.var_.characterEffect6046_story = var_60_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_3 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_3 and not isNil(var_60_2) then
				if arg_57_1.var_.characterEffect6046_story and not isNil(var_60_2) then
					arg_57_1.var_.characterEffect6046_story.fillFlat = true
					arg_57_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_3)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_3 and arg_57_1.time_ < 0 + var_60_3 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.characterEffect6046_story then
				arg_57_1.var_.characterEffect6046_story.fillFlat = true
				arg_57_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_60_4 = 0
			local var_60_5 = 0.475

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:GetWordFromCfg(1104201014)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 19 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 19)

				if (19 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 19)) > 0 and var_60_5 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201014", "story_v_side_new_1104201.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201014", "story_v_side_new_1104201.awb") / 1000

					if var_60_10 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_4
					end

					if var_60_6.prefab_name ~= "" and arg_57_1.actors_[var_60_6.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_6.prefab_name].transform, "story_v_side_new_1104201", "1104201014", "story_v_side_new_1104201.awb")

						arg_57_1:RecordAudio("1104201014", var_60_11)
						arg_57_1:RecordAudio("1104201014", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201014", "story_v_side_new_1104201.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201014", "story_v_side_new_1104201.awb")
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

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play1104201015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1104201015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play1104201016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["6045_story"]) and arg_61_1.var_.characterEffect6045_story == nil then
				arg_61_1.var_.characterEffect6045_story = arg_61_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["6045_story"]) then
				if arg_61_1.var_.characterEffect6045_story and not isNil(arg_61_1.actors_["6045_story"]) then
					arg_61_1.var_.characterEffect6045_story.fillFlat = true
					arg_61_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_0)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["6045_story"]) and arg_61_1.var_.characterEffect6045_story then
				arg_61_1.var_.characterEffect6045_story.fillFlat = true
				arg_61_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_64_1 = 0
			local var_64_2 = 0.05

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

				local var_64_3 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(1104201015).content)

				arg_61_1.text_.text = var_64_3

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 2 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_3) / 2)

				if (2 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_3) / 2)) > 0 and var_64_2 < var_64_5 then
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
	Play1104201016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1104201016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1104201017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.8

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

				local var_68_1 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(1104201016).content)

				arg_65_1.text_.text = var_68_1

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_3 = 32 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 32)

				if (32 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 32)) > 0 and var_68_0 < var_68_3 then
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
	Play1104201017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1104201017
		arg_69_1.duration_ = 7.67

		local var_69_0 = {
			ja = 7.666,
			ko = 6.333,
			zh = 6.333
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
				arg_69_0:Play1104201018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["6045_story"]) and arg_69_1.var_.characterEffect6045_story == nil then
				arg_69_1.var_.characterEffect6045_story = arg_69_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["6045_story"]) then
				if arg_69_1.var_.characterEffect6045_story and not isNil(arg_69_1.actors_["6045_story"]) then
					arg_69_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["6045_story"]) and arg_69_1.var_.characterEffect6045_story then
				arg_69_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_72_2 = 0
			local var_72_3 = 0.5

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_2 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_4 = arg_69_1:GetWordFromCfg(1104201017)
				local var_72_5 = arg_69_1:FormatText(var_72_4.content)

				arg_69_1.text_.text = var_72_5

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_7 = 20 <= 0 and var_72_3 or var_72_3 * (utf8.len(var_72_5) / 20)

				if (20 <= 0 and var_72_3 or var_72_3 * (utf8.len(var_72_5) / 20)) > 0 and var_72_3 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_2
					end
				end

				arg_69_1.text_.text = var_72_5
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201017", "story_v_side_new_1104201.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201017", "story_v_side_new_1104201.awb") / 1000

					if var_72_8 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_2
					end

					if var_72_4.prefab_name ~= "" and arg_69_1.actors_[var_72_4.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_4.prefab_name].transform, "story_v_side_new_1104201", "1104201017", "story_v_side_new_1104201.awb")

						arg_69_1:RecordAudio("1104201017", var_72_9)
						arg_69_1:RecordAudio("1104201017", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201017", "story_v_side_new_1104201.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201017", "story_v_side_new_1104201.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_10 = math.max(var_72_3, arg_69_1.talkMaxDuration)

			if var_72_2 <= arg_69_1.time_ and arg_69_1.time_ < var_72_2 + var_72_10 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_2) / var_72_10

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_2 + var_72_10 and arg_69_1.time_ < var_72_2 + var_72_10 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play1104201018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1104201018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1104201019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["6045_story"]) and arg_73_1.var_.characterEffect6045_story == nil then
				arg_73_1.var_.characterEffect6045_story = arg_73_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["6045_story"]) then
				if arg_73_1.var_.characterEffect6045_story and not isNil(arg_73_1.actors_["6045_story"]) then
					arg_73_1.var_.characterEffect6045_story.fillFlat = true
					arg_73_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_0)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["6045_story"]) and arg_73_1.var_.characterEffect6045_story then
				arg_73_1.var_.characterEffect6045_story.fillFlat = true
				arg_73_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_76_1 = 0
			local var_76_2 = 0.1

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

				local var_76_3 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(1104201018).content)

				arg_73_1.text_.text = var_76_3

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 4 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 4)

				if (4 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 4)) > 0 and var_76_2 < var_76_5 then
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
	Play1104201019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1104201019
		arg_77_1.duration_ = 7.87

		local var_77_0 = {
			ja = 6.466,
			ko = 7.866,
			zh = 7.866
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
				arg_77_0:Play1104201020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["6046_story"]) and arg_77_1.var_.characterEffect6046_story == nil then
				arg_77_1.var_.characterEffect6046_story = arg_77_1.actors_["6046_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["6046_story"]) then
				if arg_77_1.var_.characterEffect6046_story and not isNil(arg_77_1.actors_["6046_story"]) then
					arg_77_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["6046_story"]) and arg_77_1.var_.characterEffect6046_story then
				arg_77_1.var_.characterEffect6046_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_80_2 = 0
			local var_80_3 = 0.775

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_4 = arg_77_1:GetWordFromCfg(1104201019)
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201019", "story_v_side_new_1104201.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201019", "story_v_side_new_1104201.awb") / 1000

					if var_80_8 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_2
					end

					if var_80_4.prefab_name ~= "" and arg_77_1.actors_[var_80_4.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_4.prefab_name].transform, "story_v_side_new_1104201", "1104201019", "story_v_side_new_1104201.awb")

						arg_77_1:RecordAudio("1104201019", var_80_9)
						arg_77_1:RecordAudio("1104201019", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201019", "story_v_side_new_1104201.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201019", "story_v_side_new_1104201.awb")
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
	Play1104201020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1104201020
		arg_81_1.duration_ = 5

		local var_81_0 = {
			ja = 4.566,
			ko = 5,
			zh = 5
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
				arg_81_0:Play1104201021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["6045_story"]) and arg_81_1.var_.characterEffect6045_story == nil then
				arg_81_1.var_.characterEffect6045_story = arg_81_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["6045_story"]) then
				if arg_81_1.var_.characterEffect6045_story and not isNil(arg_81_1.actors_["6045_story"]) then
					arg_81_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["6045_story"]) and arg_81_1.var_.characterEffect6045_story then
				arg_81_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_2 = arg_81_1.actors_["6046_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.characterEffect6046_story == nil then
				arg_81_1.var_.characterEffect6046_story = var_84_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_3 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_3 and not isNil(var_84_2) then
				if arg_81_1.var_.characterEffect6046_story and not isNil(var_84_2) then
					arg_81_1.var_.characterEffect6046_story.fillFlat = true
					arg_81_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_3)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_3 and arg_81_1.time_ < 0 + var_84_3 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.characterEffect6046_story then
				arg_81_1.var_.characterEffect6046_story.fillFlat = true
				arg_81_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_84_4 = 0
			local var_84_5 = 0.475

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_6 = arg_81_1:GetWordFromCfg(1104201020)
				local var_84_7 = arg_81_1:FormatText(var_84_6.content)

				arg_81_1.text_.text = var_84_7

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 19 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 19)

				if (19 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 19)) > 0 and var_84_5 < var_84_9 then
					arg_81_1.talkMaxDuration = var_84_9

					if var_84_9 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_4
					end
				end

				arg_81_1.text_.text = var_84_7
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201020", "story_v_side_new_1104201.awb") ~= 0 then
					local var_84_10 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201020", "story_v_side_new_1104201.awb") / 1000

					if var_84_10 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_4
					end

					if var_84_6.prefab_name ~= "" and arg_81_1.actors_[var_84_6.prefab_name] ~= nil then
						local var_84_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_6.prefab_name].transform, "story_v_side_new_1104201", "1104201020", "story_v_side_new_1104201.awb")

						arg_81_1:RecordAudio("1104201020", var_84_11)
						arg_81_1:RecordAudio("1104201020", var_84_11)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201020", "story_v_side_new_1104201.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201020", "story_v_side_new_1104201.awb")
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
	Play1104201021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1104201021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play1104201022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["6045_story"]) and arg_85_1.var_.characterEffect6045_story == nil then
				arg_85_1.var_.characterEffect6045_story = arg_85_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["6045_story"]) then
				if arg_85_1.var_.characterEffect6045_story and not isNil(arg_85_1.actors_["6045_story"]) then
					arg_85_1.var_.characterEffect6045_story.fillFlat = true
					arg_85_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_0)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["6045_story"]) and arg_85_1.var_.characterEffect6045_story then
				arg_85_1.var_.characterEffect6045_story.fillFlat = true
				arg_85_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_88_1 = 0
			local var_88_2 = 0.125

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
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

				local var_88_3 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(1104201021).content)

				arg_85_1.text_.text = var_88_3

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 5 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 5)

				if (5 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 5)) > 0 and var_88_2 < var_88_5 then
					arg_85_1.talkMaxDuration = var_88_5

					if var_88_5 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + var_88_1
					end
				end

				arg_85_1.text_.text = var_88_3
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_6 = math.max(var_88_2, arg_85_1.talkMaxDuration)

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_6 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_1) / var_88_6

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_1 + var_88_6 and arg_85_1.time_ < var_88_1 + var_88_6 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play1104201022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1104201022
		arg_89_1.duration_ = 3.63

		local var_89_0 = {
			ja = 2.6,
			ko = 3.633,
			zh = 3.633
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
				arg_89_0:Play1104201023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos6045_story = arg_89_1.actors_["6045_story"].transform.localPosition

				local var_92_0 = GameObjectTools.GetOrAddComponent(arg_89_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_92_0 then
					var_92_0:EnableDynamicBone(false)
				end
			end

			local var_92_1 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_1 then
				arg_89_1.actors_["6045_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos6045_story, Vector3.New(0, 100, 0), (arg_89_1.time_ - 0) / var_92_1)
				arg_89_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["6045_story"].transform.position).z)
				arg_89_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["6045_story"].transform.localEulerAngles = arg_89_1.actors_["6045_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_1 and arg_89_1.time_ < 0 + var_92_1 + arg_92_0 then
				arg_89_1.actors_["6045_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_89_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["6045_story"].transform.position).z)
				arg_89_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["6045_story"].transform.localEulerAngles = arg_89_1.actors_["6045_story"].transform.localEulerAngles

				local var_92_2 = GameObjectTools.GetOrAddComponent(arg_89_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_92_2 then
					var_92_2:EnableDynamicBone(true)
				end
			end

			local var_92_3 = arg_89_1.actors_["6045_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_3) and arg_89_1.var_.characterEffect6045_story == nil then
				arg_89_1.var_.characterEffect6045_story = var_92_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_4 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 and not isNil(var_92_3) then
				if arg_89_1.var_.characterEffect6045_story and not isNil(var_92_3) then
					arg_89_1.var_.characterEffect6045_story.fillFlat = true
					arg_89_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_4)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 and not isNil(var_92_3) and arg_89_1.var_.characterEffect6045_story then
				arg_89_1.var_.characterEffect6045_story.fillFlat = true
				arg_89_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_92_5 = arg_89_1.actors_["6046_story"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos6046_story = var_92_5.localPosition

				local var_92_6 = GameObjectTools.GetOrAddComponent(var_92_5.gameObject, typeof(DynamicBoneHelper))

				if var_92_6 then
					var_92_6:EnableDynamicBone(false)
				end
			end

			local var_92_7 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_7 then
				var_92_5.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (arg_89_1.time_ - 0) / var_92_7)
				var_92_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_5.position).x, (manager.ui.mainCamera.transform.position - var_92_5.position).y, (manager.ui.mainCamera.transform.position - var_92_5.position).z)
				var_92_5.localEulerAngles.z = 0
				var_92_5.localEulerAngles.x = 0
				var_92_5.localEulerAngles = var_92_5.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_7 and arg_89_1.time_ < 0 + var_92_7 + arg_92_0 then
				var_92_5.localPosition = Vector3.New(0, 100, 0)
				var_92_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_5.position).x, (manager.ui.mainCamera.transform.position - var_92_5.position).y, (manager.ui.mainCamera.transform.position - var_92_5.position).z)
				var_92_5.localEulerAngles.z = 0
				var_92_5.localEulerAngles.x = 0
				var_92_5.localEulerAngles = var_92_5.localEulerAngles

				local var_92_8 = GameObjectTools.GetOrAddComponent(var_92_5.gameObject, typeof(DynamicBoneHelper))

				if var_92_8 then
					var_92_8:EnableDynamicBone(true)
				end
			end

			local var_92_9 = arg_89_1.actors_["6046_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect6046_story == nil then
				arg_89_1.var_.characterEffect6046_story = var_92_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_10 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_10 and not isNil(var_92_9) then
				if arg_89_1.var_.characterEffect6046_story and not isNil(var_92_9) then
					arg_89_1.var_.characterEffect6046_story.fillFlat = true
					arg_89_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_10)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_10 and arg_89_1.time_ < 0 + var_92_10 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect6046_story then
				arg_89_1.var_.characterEffect6046_story.fillFlat = true
				arg_89_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_92_11 = "1042ui_story"

			if arg_89_1.actors_["1042ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1042ui_story"))) then
				local var_92_12 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_89_1.stage_.transform)

				var_92_12.name = var_92_11
				var_92_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_89_1.actors_[var_92_11] = var_92_12

				local var_92_13 = var_92_12:GetComponentInChildren(typeof(CharacterEffect))

				var_92_13.enabled = true

				local var_92_14 = GameObjectTools.GetOrAddComponent(var_92_12, typeof(DynamicBoneHelper))

				if var_92_14 then
					var_92_14:EnableDynamicBone(false)
				end

				arg_89_1:ShowWeapon(var_92_13.transform, false)

				arg_89_1.var_[var_92_11 .. "Animator"] = var_92_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_89_1.var_[var_92_11 .. "Animator"].applyRootMotion = true
				arg_89_1.var_[var_92_11 .. "LipSync"] = var_92_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_92_15 = arg_89_1.actors_["1042ui_story"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1042ui_story = var_92_15.localPosition
			end

			local var_92_16 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_16 then
				var_92_15.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1042ui_story, Vector3.New(0, -1.06, -6.2), (arg_89_1.time_ - 0) / var_92_16)
				var_92_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_15.position).x, (manager.ui.mainCamera.transform.position - var_92_15.position).y, (manager.ui.mainCamera.transform.position - var_92_15.position).z)
				var_92_15.localEulerAngles.z = 0
				var_92_15.localEulerAngles.x = 0
				var_92_15.localEulerAngles = var_92_15.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_16 and arg_89_1.time_ < 0 + var_92_16 + arg_92_0 then
				var_92_15.localPosition = Vector3.New(0, -1.06, -6.2)
				var_92_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_15.position).x, (manager.ui.mainCamera.transform.position - var_92_15.position).y, (manager.ui.mainCamera.transform.position - var_92_15.position).z)
				var_92_15.localEulerAngles.z = 0
				var_92_15.localEulerAngles.x = 0
				var_92_15.localEulerAngles = var_92_15.localEulerAngles
			end

			local var_92_17 = arg_89_1.actors_["1042ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_17) and arg_89_1.var_.characterEffect1042ui_story == nil then
				arg_89_1.var_.characterEffect1042ui_story = var_92_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_18 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_18 and not isNil(var_92_17) then
				if arg_89_1.var_.characterEffect1042ui_story and not isNil(var_92_17) then
					arg_89_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_18 and arg_89_1.time_ < 0 + var_92_18 + arg_92_0 and not isNil(var_92_17) and arg_89_1.var_.characterEffect1042ui_story then
				arg_89_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action1_1")
			end

			local var_92_20 = 0
			local var_92_21 = 0.425

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_20 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_22 = arg_89_1:GetWordFromCfg(1104201022)
				local var_92_23 = arg_89_1:FormatText(var_92_22.content)

				arg_89_1.text_.text = var_92_23

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_25 = 17 <= 0 and var_92_21 or var_92_21 * (utf8.len(var_92_23) / 17)

				if (17 <= 0 and var_92_21 or var_92_21 * (utf8.len(var_92_23) / 17)) > 0 and var_92_21 < var_92_25 then
					arg_89_1.talkMaxDuration = var_92_25

					if var_92_25 + var_92_20 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_25 + var_92_20
					end
				end

				arg_89_1.text_.text = var_92_23
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201022", "story_v_side_new_1104201.awb") ~= 0 then
					local var_92_26 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201022", "story_v_side_new_1104201.awb") / 1000

					if var_92_26 + var_92_20 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_26 + var_92_20
					end

					if var_92_22.prefab_name ~= "" and arg_89_1.actors_[var_92_22.prefab_name] ~= nil then
						local var_92_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_22.prefab_name].transform, "story_v_side_new_1104201", "1104201022", "story_v_side_new_1104201.awb")

						arg_89_1:RecordAudio("1104201022", var_92_27)
						arg_89_1:RecordAudio("1104201022", var_92_27)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201022", "story_v_side_new_1104201.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201022", "story_v_side_new_1104201.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_28 = math.max(var_92_21, arg_89_1.talkMaxDuration)

			if var_92_20 <= arg_89_1.time_ and arg_89_1.time_ < var_92_20 + var_92_28 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_20) / var_92_28

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_20 + var_92_28 and arg_89_1.time_ < var_92_20 + var_92_28 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
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
	Play1104201023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1104201023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play1104201024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["1042ui_story"]) and arg_93_1.var_.characterEffect1042ui_story == nil then
				arg_93_1.var_.characterEffect1042ui_story = arg_93_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["1042ui_story"]) then
				if arg_93_1.var_.characterEffect1042ui_story and not isNil(arg_93_1.actors_["1042ui_story"]) then
					arg_93_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_0)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["1042ui_story"]) and arg_93_1.var_.characterEffect1042ui_story then
				arg_93_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_96_1 = 0
			local var_96_2 = 1.05

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
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

				local var_96_3 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(1104201023).content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 42 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 42)

				if (42 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 42)) > 0 and var_96_2 < var_96_5 then
					arg_93_1.talkMaxDuration = var_96_5

					if var_96_5 + var_96_1 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + var_96_1
					end
				end

				arg_93_1.text_.text = var_96_3
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_6 = math.max(var_96_2, arg_93_1.talkMaxDuration)

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_6 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_1) / var_96_6

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_1 + var_96_6 and arg_93_1.time_ < var_96_1 + var_96_6 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play1104201024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1104201024
		arg_97_1.duration_ = 10.03

		local var_97_0 = {
			ja = 9.566,
			ko = 10.033,
			zh = 10.033
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
				arg_97_0:Play1104201025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1042ui_story"]) and arg_97_1.var_.characterEffect1042ui_story == nil then
				arg_97_1.var_.characterEffect1042ui_story = arg_97_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1042ui_story"]) then
				if arg_97_1.var_.characterEffect1042ui_story and not isNil(arg_97_1.actors_["1042ui_story"]) then
					arg_97_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1042ui_story"]) and arg_97_1.var_.characterEffect1042ui_story then
				arg_97_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_100_2 = 0
			local var_100_3 = 1.05

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_2 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_4 = arg_97_1:GetWordFromCfg(1104201024)
				local var_100_5 = arg_97_1:FormatText(var_100_4.content)

				arg_97_1.text_.text = var_100_5

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_7 = 42 <= 0 and var_100_3 or var_100_3 * (utf8.len(var_100_5) / 42)

				if (42 <= 0 and var_100_3 or var_100_3 * (utf8.len(var_100_5) / 42)) > 0 and var_100_3 < var_100_7 then
					arg_97_1.talkMaxDuration = var_100_7

					if var_100_7 + var_100_2 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_2
					end
				end

				arg_97_1.text_.text = var_100_5
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201024", "story_v_side_new_1104201.awb") ~= 0 then
					local var_100_8 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201024", "story_v_side_new_1104201.awb") / 1000

					if var_100_8 + var_100_2 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_2
					end

					if var_100_4.prefab_name ~= "" and arg_97_1.actors_[var_100_4.prefab_name] ~= nil then
						local var_100_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_4.prefab_name].transform, "story_v_side_new_1104201", "1104201024", "story_v_side_new_1104201.awb")

						arg_97_1:RecordAudio("1104201024", var_100_9)
						arg_97_1:RecordAudio("1104201024", var_100_9)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201024", "story_v_side_new_1104201.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201024", "story_v_side_new_1104201.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_10 = math.max(var_100_3, arg_97_1.talkMaxDuration)

			if var_100_2 <= arg_97_1.time_ and arg_97_1.time_ < var_100_2 + var_100_10 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_2) / var_100_10

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_2 + var_100_10 and arg_97_1.time_ < var_100_2 + var_100_10 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play1104201025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1104201025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play1104201026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1042ui_story"]) and arg_101_1.var_.characterEffect1042ui_story == nil then
				arg_101_1.var_.characterEffect1042ui_story = arg_101_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1042ui_story"]) then
				if arg_101_1.var_.characterEffect1042ui_story and not isNil(arg_101_1.actors_["1042ui_story"]) then
					arg_101_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_0)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1042ui_story"]) and arg_101_1.var_.characterEffect1042ui_story then
				arg_101_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_104_1 = 0
			local var_104_2 = 0.825

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_3 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(1104201025).content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 33 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 33)

				if (33 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 33)) > 0 and var_104_2 < var_104_5 then
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
	Play1104201026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1104201026
		arg_105_1.duration_ = 8.33

		local var_105_0 = {
			ja = 8.333,
			ko = 7.9,
			zh = 7.9
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
				arg_105_0:Play1104201027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1042ui_story"]) and arg_105_1.var_.characterEffect1042ui_story == nil then
				arg_105_1.var_.characterEffect1042ui_story = arg_105_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1042ui_story"]) then
				if arg_105_1.var_.characterEffect1042ui_story and not isNil(arg_105_1.actors_["1042ui_story"]) then
					arg_105_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1042ui_story"]) and arg_105_1.var_.characterEffect1042ui_story then
				arg_105_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action5_1")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_108_2 = 0
			local var_108_3 = 0.875

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_2 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_4 = arg_105_1:GetWordFromCfg(1104201026)
				local var_108_5 = arg_105_1:FormatText(var_108_4.content)

				arg_105_1.text_.text = var_108_5

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_7 = 35 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_5) / 35)

				if (35 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_5) / 35)) > 0 and var_108_3 < var_108_7 then
					arg_105_1.talkMaxDuration = var_108_7

					if var_108_7 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_2
					end
				end

				arg_105_1.text_.text = var_108_5
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201026", "story_v_side_new_1104201.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201026", "story_v_side_new_1104201.awb") / 1000

					if var_108_8 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_2
					end

					if var_108_4.prefab_name ~= "" and arg_105_1.actors_[var_108_4.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_4.prefab_name].transform, "story_v_side_new_1104201", "1104201026", "story_v_side_new_1104201.awb")

						arg_105_1:RecordAudio("1104201026", var_108_9)
						arg_105_1:RecordAudio("1104201026", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201026", "story_v_side_new_1104201.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201026", "story_v_side_new_1104201.awb")
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
	Play1104201027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1104201027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play1104201028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["1042ui_story"]) and arg_109_1.var_.characterEffect1042ui_story == nil then
				arg_109_1.var_.characterEffect1042ui_story = arg_109_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["1042ui_story"]) then
				if arg_109_1.var_.characterEffect1042ui_story and not isNil(arg_109_1.actors_["1042ui_story"]) then
					arg_109_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_0)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["1042ui_story"]) and arg_109_1.var_.characterEffect1042ui_story then
				arg_109_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_112_1 = 0
			local var_112_2 = 0.175

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

				local var_112_3 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(1104201027).content)

				arg_109_1.text_.text = var_112_3

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 7 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 7)

				if (7 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 7)) > 0 and var_112_2 < var_112_5 then
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
	Play1104201028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1104201028
		arg_113_1.duration_ = 9.07

		local var_113_0 = {
			ja = 9.066,
			ko = 7.166,
			zh = 7.166
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
				arg_113_0:Play1104201029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action457")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_116_0 = arg_113_1.actors_["1042ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1042ui_story == nil then
				arg_113_1.var_.characterEffect1042ui_story = var_116_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_1 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_1 and not isNil(var_116_0) then
				if arg_113_1.var_.characterEffect1042ui_story and not isNil(var_116_0) then
					arg_113_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_1 and arg_113_1.time_ < 0 + var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1042ui_story then
				arg_113_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_116_3 = 0
			local var_116_4 = 0.725

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_3 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_5 = arg_113_1:GetWordFromCfg(1104201028)
				local var_116_6 = arg_113_1:FormatText(var_116_5.content)

				arg_113_1.text_.text = var_116_6

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_8 = 29 <= 0 and var_116_4 or var_116_4 * (utf8.len(var_116_6) / 29)

				if (29 <= 0 and var_116_4 or var_116_4 * (utf8.len(var_116_6) / 29)) > 0 and var_116_4 < var_116_8 then
					arg_113_1.talkMaxDuration = var_116_8

					if var_116_8 + var_116_3 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_8 + var_116_3
					end
				end

				arg_113_1.text_.text = var_116_6
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201028", "story_v_side_new_1104201.awb") ~= 0 then
					local var_116_9 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201028", "story_v_side_new_1104201.awb") / 1000

					if var_116_9 + var_116_3 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_9 + var_116_3
					end

					if var_116_5.prefab_name ~= "" and arg_113_1.actors_[var_116_5.prefab_name] ~= nil then
						local var_116_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_5.prefab_name].transform, "story_v_side_new_1104201", "1104201028", "story_v_side_new_1104201.awb")

						arg_113_1:RecordAudio("1104201028", var_116_10)
						arg_113_1:RecordAudio("1104201028", var_116_10)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201028", "story_v_side_new_1104201.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201028", "story_v_side_new_1104201.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_11 = math.max(var_116_4, arg_113_1.talkMaxDuration)

			if var_116_3 <= arg_113_1.time_ and arg_113_1.time_ < var_116_3 + var_116_11 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_3) / var_116_11

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_3 + var_116_11 and arg_113_1.time_ < var_116_3 + var_116_11 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play1104201029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 1104201029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play1104201030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["1042ui_story"]) and arg_117_1.var_.characterEffect1042ui_story == nil then
				arg_117_1.var_.characterEffect1042ui_story = arg_117_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["1042ui_story"]) then
				if arg_117_1.var_.characterEffect1042ui_story and not isNil(arg_117_1.actors_["1042ui_story"]) then
					arg_117_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_0)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["1042ui_story"]) and arg_117_1.var_.characterEffect1042ui_story then
				arg_117_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_120_1 = 0
			local var_120_2 = 0.325

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_3 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(1104201029).content)

				arg_117_1.text_.text = var_120_3

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 13 <= 0 and var_120_2 or var_120_2 * (utf8.len(var_120_3) / 13)

				if (13 <= 0 and var_120_2 or var_120_2 * (utf8.len(var_120_3) / 13)) > 0 and var_120_2 < var_120_5 then
					arg_117_1.talkMaxDuration = var_120_5

					if var_120_5 + var_120_1 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + var_120_1
					end
				end

				arg_117_1.text_.text = var_120_3
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_6 = math.max(var_120_2, arg_117_1.talkMaxDuration)

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_6 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_1) / var_120_6

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_1 + var_120_6 and arg_117_1.time_ < var_120_1 + var_120_6 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play1104201030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 1104201030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play1104201031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 1.25

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_1 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(1104201030).content)

				arg_121_1.text_.text = var_124_1

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_3 = 50 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 50)

				if (50 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 50)) > 0 and var_124_0 < var_124_3 then
					arg_121_1.talkMaxDuration = var_124_3

					if var_124_3 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_3 + 0
					end
				end

				arg_121_1.text_.text = var_124_1
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_4 = math.max(var_124_0, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - 0) / var_124_4

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play1104201031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 1104201031
		arg_125_1.duration_ = 12.1

		local var_125_0 = {
			ja = 12.1,
			ko = 8.1,
			zh = 8.1
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play1104201032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1042ui_story = arg_125_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1042ui_story"].transform.position).z)
				arg_125_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1042ui_story"].transform.localEulerAngles = arg_125_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_125_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1042ui_story"].transform.position).z)
				arg_125_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1042ui_story"].transform.localEulerAngles = arg_125_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_128_1 = arg_125_1.actors_["1042ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1042ui_story == nil then
				arg_125_1.var_.characterEffect1042ui_story = var_128_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 and not isNil(var_128_1) then
				if arg_125_1.var_.characterEffect1042ui_story and not isNil(var_128_1) then
					arg_125_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_2)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1042ui_story then
				arg_125_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_128_3 = arg_125_1.actors_["6045_story"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos6045_story = var_128_3.localPosition

				local var_128_4 = GameObjectTools.GetOrAddComponent(var_128_3.gameObject, typeof(DynamicBoneHelper))

				if var_128_4 then
					var_128_4:EnableDynamicBone(false)
				end
			end

			local var_128_5 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_5 then
				var_128_3.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos6045_story, Vector3.New(-0.7, -0.5, -6.3), (arg_125_1.time_ - 0) / var_128_5)
				var_128_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_3.position).x, (manager.ui.mainCamera.transform.position - var_128_3.position).y, (manager.ui.mainCamera.transform.position - var_128_3.position).z)
				var_128_3.localEulerAngles.z = 0
				var_128_3.localEulerAngles.x = 0
				var_128_3.localEulerAngles = var_128_3.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_5 and arg_125_1.time_ < 0 + var_128_5 + arg_128_0 then
				var_128_3.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				var_128_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_3.position).x, (manager.ui.mainCamera.transform.position - var_128_3.position).y, (manager.ui.mainCamera.transform.position - var_128_3.position).z)
				var_128_3.localEulerAngles.z = 0
				var_128_3.localEulerAngles.x = 0
				var_128_3.localEulerAngles = var_128_3.localEulerAngles

				local var_128_6 = GameObjectTools.GetOrAddComponent(var_128_3.gameObject, typeof(DynamicBoneHelper))

				if var_128_6 then
					var_128_6:EnableDynamicBone(true)
				end
			end

			local var_128_7 = arg_125_1.actors_["6045_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_7) and arg_125_1.var_.characterEffect6045_story == nil then
				arg_125_1.var_.characterEffect6045_story = var_128_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_8 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_8 and not isNil(var_128_7) then
				if arg_125_1.var_.characterEffect6045_story and not isNil(var_128_7) then
					arg_125_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_8 and arg_125_1.time_ < 0 + var_128_8 + arg_128_0 and not isNil(var_128_7) and arg_125_1.var_.characterEffect6045_story then
				arg_125_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_128_10 = arg_125_1.actors_["6046_story"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos6046_story = var_128_10.localPosition

				local var_128_11 = GameObjectTools.GetOrAddComponent(var_128_10.gameObject, typeof(DynamicBoneHelper))

				if var_128_11 then
					var_128_11:EnableDynamicBone(false)
				end
			end

			local var_128_12 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_12 then
				var_128_10.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos6046_story, Vector3.New(0.7, -0.5, -6.3), (arg_125_1.time_ - 0) / var_128_12)
				var_128_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_10.position).x, (manager.ui.mainCamera.transform.position - var_128_10.position).y, (manager.ui.mainCamera.transform.position - var_128_10.position).z)
				var_128_10.localEulerAngles.z = 0
				var_128_10.localEulerAngles.x = 0
				var_128_10.localEulerAngles = var_128_10.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_12 and arg_125_1.time_ < 0 + var_128_12 + arg_128_0 then
				var_128_10.localPosition = Vector3.New(0.7, -0.5, -6.3)
				var_128_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_10.position).x, (manager.ui.mainCamera.transform.position - var_128_10.position).y, (manager.ui.mainCamera.transform.position - var_128_10.position).z)
				var_128_10.localEulerAngles.z = 0
				var_128_10.localEulerAngles.x = 0
				var_128_10.localEulerAngles = var_128_10.localEulerAngles

				local var_128_13 = GameObjectTools.GetOrAddComponent(var_128_10.gameObject, typeof(DynamicBoneHelper))

				if var_128_13 then
					var_128_13:EnableDynamicBone(true)
				end
			end

			local var_128_14 = arg_125_1.actors_["6046_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_14) and arg_125_1.var_.characterEffect6046_story == nil then
				arg_125_1.var_.characterEffect6046_story = var_128_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_15 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_15 and not isNil(var_128_14) then
				if arg_125_1.var_.characterEffect6046_story and not isNil(var_128_14) then
					arg_125_1.var_.characterEffect6046_story.fillFlat = true
					arg_125_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_15)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_15 and arg_125_1.time_ < 0 + var_128_15 + arg_128_0 and not isNil(var_128_14) and arg_125_1.var_.characterEffect6046_story then
				arg_125_1.var_.characterEffect6046_story.fillFlat = true
				arg_125_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_128_16 = 0
			local var_128_17 = 0.725

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_16 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_18 = arg_125_1:GetWordFromCfg(1104201031)
				local var_128_19 = arg_125_1:FormatText(var_128_18.content)

				arg_125_1.text_.text = var_128_19

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_21 = 29 <= 0 and var_128_17 or var_128_17 * (utf8.len(var_128_19) / 29)

				if (29 <= 0 and var_128_17 or var_128_17 * (utf8.len(var_128_19) / 29)) > 0 and var_128_17 < var_128_21 then
					arg_125_1.talkMaxDuration = var_128_21

					if var_128_21 + var_128_16 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_21 + var_128_16
					end
				end

				arg_125_1.text_.text = var_128_19
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201031", "story_v_side_new_1104201.awb") ~= 0 then
					local var_128_22 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201031", "story_v_side_new_1104201.awb") / 1000

					if var_128_22 + var_128_16 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_22 + var_128_16
					end

					if var_128_18.prefab_name ~= "" and arg_125_1.actors_[var_128_18.prefab_name] ~= nil then
						local var_128_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_18.prefab_name].transform, "story_v_side_new_1104201", "1104201031", "story_v_side_new_1104201.awb")

						arg_125_1:RecordAudio("1104201031", var_128_23)
						arg_125_1:RecordAudio("1104201031", var_128_23)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201031", "story_v_side_new_1104201.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201031", "story_v_side_new_1104201.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_24 = math.max(var_128_17, arg_125_1.talkMaxDuration)

			if var_128_16 <= arg_125_1.time_ and arg_125_1.time_ < var_128_16 + var_128_24 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_16) / var_128_24

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_16 + var_128_24 and arg_125_1.time_ < var_128_16 + var_128_24 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
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
	Play1104201032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 1104201032
		arg_129_1.duration_ = 3.73

		local var_129_0 = {
			ja = 2.966,
			ko = 3.733,
			zh = 3.733
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
				arg_129_0:Play1104201033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["6046_story"]) and arg_129_1.var_.characterEffect6046_story == nil then
				arg_129_1.var_.characterEffect6046_story = arg_129_1.actors_["6046_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["6046_story"]) then
				if arg_129_1.var_.characterEffect6046_story and not isNil(arg_129_1.actors_["6046_story"]) then
					arg_129_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["6046_story"]) and arg_129_1.var_.characterEffect6046_story then
				arg_129_1.var_.characterEffect6046_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_132_2 = arg_129_1.actors_["6045_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.characterEffect6045_story == nil then
				arg_129_1.var_.characterEffect6045_story = var_132_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_3 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_3 and not isNil(var_132_2) then
				if arg_129_1.var_.characterEffect6045_story and not isNil(var_132_2) then
					arg_129_1.var_.characterEffect6045_story.fillFlat = true
					arg_129_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_3)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_3 and arg_129_1.time_ < 0 + var_132_3 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.characterEffect6045_story then
				arg_129_1.var_.characterEffect6045_story.fillFlat = true
				arg_129_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_132_4 = 0
			local var_132_5 = 0.325

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_6 = arg_129_1:GetWordFromCfg(1104201032)
				local var_132_7 = arg_129_1:FormatText(var_132_6.content)

				arg_129_1.text_.text = var_132_7

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_9 = 13 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 13)

				if (13 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 13)) > 0 and var_132_5 < var_132_9 then
					arg_129_1.talkMaxDuration = var_132_9

					if var_132_9 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_4
					end
				end

				arg_129_1.text_.text = var_132_7
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201032", "story_v_side_new_1104201.awb") ~= 0 then
					local var_132_10 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201032", "story_v_side_new_1104201.awb") / 1000

					if var_132_10 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_4
					end

					if var_132_6.prefab_name ~= "" and arg_129_1.actors_[var_132_6.prefab_name] ~= nil then
						local var_132_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_6.prefab_name].transform, "story_v_side_new_1104201", "1104201032", "story_v_side_new_1104201.awb")

						arg_129_1:RecordAudio("1104201032", var_132_11)
						arg_129_1:RecordAudio("1104201032", var_132_11)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201032", "story_v_side_new_1104201.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201032", "story_v_side_new_1104201.awb")
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

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play1104201033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 1104201033
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play1104201034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["6046_story"]) and arg_133_1.var_.characterEffect6046_story == nil then
				arg_133_1.var_.characterEffect6046_story = arg_133_1.actors_["6046_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["6046_story"]) then
				if arg_133_1.var_.characterEffect6046_story and not isNil(arg_133_1.actors_["6046_story"]) then
					arg_133_1.var_.characterEffect6046_story.fillFlat = true
					arg_133_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_0)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["6046_story"]) and arg_133_1.var_.characterEffect6046_story then
				arg_133_1.var_.characterEffect6046_story.fillFlat = true
				arg_133_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_136_1 = 0
			local var_136_2 = 0.2

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

				local var_136_3 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(1104201033).content)

				arg_133_1.text_.text = var_136_3

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 8 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_3) / 8)

				if (8 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_3) / 8)) > 0 and var_136_2 < var_136_5 then
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
	Play1104201034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 1104201034
		arg_137_1.duration_ = 8.8

		local var_137_0 = {
			ja = 8.8,
			ko = 6.433,
			zh = 6.433
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
				arg_137_0:Play1104201035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["6045_story"]) and arg_137_1.var_.characterEffect6045_story == nil then
				arg_137_1.var_.characterEffect6045_story = arg_137_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["6045_story"]) then
				if arg_137_1.var_.characterEffect6045_story and not isNil(arg_137_1.actors_["6045_story"]) then
					arg_137_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["6045_story"]) and arg_137_1.var_.characterEffect6045_story then
				arg_137_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action2_1")
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_140_2 = 0
			local var_140_3 = 0.575

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_2 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_4 = arg_137_1:GetWordFromCfg(1104201034)
				local var_140_5 = arg_137_1:FormatText(var_140_4.content)

				arg_137_1.text_.text = var_140_5

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_7 = 23 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_5) / 23)

				if (23 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_5) / 23)) > 0 and var_140_3 < var_140_7 then
					arg_137_1.talkMaxDuration = var_140_7

					if var_140_7 + var_140_2 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_2
					end
				end

				arg_137_1.text_.text = var_140_5
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201034", "story_v_side_new_1104201.awb") ~= 0 then
					local var_140_8 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201034", "story_v_side_new_1104201.awb") / 1000

					if var_140_8 + var_140_2 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_8 + var_140_2
					end

					if var_140_4.prefab_name ~= "" and arg_137_1.actors_[var_140_4.prefab_name] ~= nil then
						local var_140_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_4.prefab_name].transform, "story_v_side_new_1104201", "1104201034", "story_v_side_new_1104201.awb")

						arg_137_1:RecordAudio("1104201034", var_140_9)
						arg_137_1:RecordAudio("1104201034", var_140_9)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201034", "story_v_side_new_1104201.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201034", "story_v_side_new_1104201.awb")
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
	Play1104201035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 1104201035
		arg_141_1.duration_ = 6.5

		local var_141_0 = {
			ja = 5.133,
			ko = 6.5,
			zh = 6.5
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
				arg_141_0:Play1104201036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["6046_story"]) and arg_141_1.var_.characterEffect6046_story == nil then
				arg_141_1.var_.characterEffect6046_story = arg_141_1.actors_["6046_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["6046_story"]) then
				if arg_141_1.var_.characterEffect6046_story and not isNil(arg_141_1.actors_["6046_story"]) then
					arg_141_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["6046_story"]) and arg_141_1.var_.characterEffect6046_story then
				arg_141_1.var_.characterEffect6046_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action5_1")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_144_2 = arg_141_1.actors_["6045_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.characterEffect6045_story == nil then
				arg_141_1.var_.characterEffect6045_story = var_144_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_3 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_3 and not isNil(var_144_2) then
				if arg_141_1.var_.characterEffect6045_story and not isNil(var_144_2) then
					arg_141_1.var_.characterEffect6045_story.fillFlat = true
					arg_141_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_3)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_3 and arg_141_1.time_ < 0 + var_144_3 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.characterEffect6045_story then
				arg_141_1.var_.characterEffect6045_story.fillFlat = true
				arg_141_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_144_4 = 0
			local var_144_5 = 0.65

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_6 = arg_141_1:GetWordFromCfg(1104201035)
				local var_144_7 = arg_141_1:FormatText(var_144_6.content)

				arg_141_1.text_.text = var_144_7

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_9 = 26 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 26)

				if (26 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 26)) > 0 and var_144_5 < var_144_9 then
					arg_141_1.talkMaxDuration = var_144_9

					if var_144_9 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_9 + var_144_4
					end
				end

				arg_141_1.text_.text = var_144_7
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201035", "story_v_side_new_1104201.awb") ~= 0 then
					local var_144_10 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201035", "story_v_side_new_1104201.awb") / 1000

					if var_144_10 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_4
					end

					if var_144_6.prefab_name ~= "" and arg_141_1.actors_[var_144_6.prefab_name] ~= nil then
						local var_144_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_6.prefab_name].transform, "story_v_side_new_1104201", "1104201035", "story_v_side_new_1104201.awb")

						arg_141_1:RecordAudio("1104201035", var_144_11)
						arg_141_1:RecordAudio("1104201035", var_144_11)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201035", "story_v_side_new_1104201.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201035", "story_v_side_new_1104201.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_12 = math.max(var_144_5, arg_141_1.talkMaxDuration)

			if var_144_4 <= arg_141_1.time_ and arg_141_1.time_ < var_144_4 + var_144_12 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_4) / var_144_12

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_4 + var_144_12 and arg_141_1.time_ < var_144_4 + var_144_12 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play1104201036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 1104201036
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play1104201037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["6046_story"]) and arg_145_1.var_.characterEffect6046_story == nil then
				arg_145_1.var_.characterEffect6046_story = arg_145_1.actors_["6046_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_0 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["6046_story"]) then
				if arg_145_1.var_.characterEffect6046_story and not isNil(arg_145_1.actors_["6046_story"]) then
					arg_145_1.var_.characterEffect6046_story.fillFlat = true
					arg_145_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_0)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["6046_story"]) and arg_145_1.var_.characterEffect6046_story then
				arg_145_1.var_.characterEffect6046_story.fillFlat = true
				arg_145_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_148_1 = 0
			local var_148_2 = 0.15

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
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

				local var_148_3 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(1104201036).content)

				arg_145_1.text_.text = var_148_3

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 6 <= 0 and var_148_2 or var_148_2 * (utf8.len(var_148_3) / 6)

				if (6 <= 0 and var_148_2 or var_148_2 * (utf8.len(var_148_3) / 6)) > 0 and var_148_2 < var_148_5 then
					arg_145_1.talkMaxDuration = var_148_5

					if var_148_5 + var_148_1 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + var_148_1
					end
				end

				arg_145_1.text_.text = var_148_3
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_6 = math.max(var_148_2, arg_145_1.talkMaxDuration)

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_6 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_1) / var_148_6

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_1 + var_148_6 and arg_145_1.time_ < var_148_1 + var_148_6 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play1104201037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 1104201037
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play1104201038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos6046_story = arg_149_1.actors_["6046_story"].transform.localPosition

				local var_152_0 = GameObjectTools.GetOrAddComponent(arg_149_1.actors_["6046_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_152_0 then
					var_152_0:EnableDynamicBone(false)
				end
			end

			local var_152_1 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_1 then
				arg_149_1.actors_["6046_story"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (arg_149_1.time_ - 0) / var_152_1)
				arg_149_1.actors_["6046_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["6046_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["6046_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["6046_story"].transform.position).z)
				arg_149_1.actors_["6046_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["6046_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["6046_story"].transform.localEulerAngles = arg_149_1.actors_["6046_story"].transform.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_1 and arg_149_1.time_ < 0 + var_152_1 + arg_152_0 then
				arg_149_1.actors_["6046_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_149_1.actors_["6046_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["6046_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["6046_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["6046_story"].transform.position).z)
				arg_149_1.actors_["6046_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["6046_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["6046_story"].transform.localEulerAngles = arg_149_1.actors_["6046_story"].transform.localEulerAngles

				local var_152_2 = GameObjectTools.GetOrAddComponent(arg_149_1.actors_["6046_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_152_2 then
					var_152_2:EnableDynamicBone(true)
				end
			end

			local var_152_3 = arg_149_1.actors_["6046_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_3) and arg_149_1.var_.characterEffect6046_story == nil then
				arg_149_1.var_.characterEffect6046_story = var_152_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_4 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_4 and not isNil(var_152_3) then
				if arg_149_1.var_.characterEffect6046_story and not isNil(var_152_3) then
					arg_149_1.var_.characterEffect6046_story.fillFlat = true
					arg_149_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_4)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_4 and arg_149_1.time_ < 0 + var_152_4 + arg_152_0 and not isNil(var_152_3) and arg_149_1.var_.characterEffect6046_story then
				arg_149_1.var_.characterEffect6046_story.fillFlat = true
				arg_149_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_152_5 = arg_149_1.actors_["6045_story"].transform

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos6045_story = var_152_5.localPosition

				local var_152_6 = GameObjectTools.GetOrAddComponent(var_152_5.gameObject, typeof(DynamicBoneHelper))

				if var_152_6 then
					var_152_6:EnableDynamicBone(false)
				end
			end

			local var_152_7 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_7 then
				var_152_5.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos6045_story, Vector3.New(0, 100, 0), (arg_149_1.time_ - 0) / var_152_7)
				var_152_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_5.position).x, (manager.ui.mainCamera.transform.position - var_152_5.position).y, (manager.ui.mainCamera.transform.position - var_152_5.position).z)
				var_152_5.localEulerAngles.z = 0
				var_152_5.localEulerAngles.x = 0
				var_152_5.localEulerAngles = var_152_5.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_7 and arg_149_1.time_ < 0 + var_152_7 + arg_152_0 then
				var_152_5.localPosition = Vector3.New(0, 100, 0)
				var_152_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_5.position).x, (manager.ui.mainCamera.transform.position - var_152_5.position).y, (manager.ui.mainCamera.transform.position - var_152_5.position).z)
				var_152_5.localEulerAngles.z = 0
				var_152_5.localEulerAngles.x = 0
				var_152_5.localEulerAngles = var_152_5.localEulerAngles

				local var_152_8 = GameObjectTools.GetOrAddComponent(var_152_5.gameObject, typeof(DynamicBoneHelper))

				if var_152_8 then
					var_152_8:EnableDynamicBone(true)
				end
			end

			local var_152_9 = arg_149_1.actors_["6045_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_9) and arg_149_1.var_.characterEffect6045_story == nil then
				arg_149_1.var_.characterEffect6045_story = var_152_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_10 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_10 and not isNil(var_152_9) then
				if arg_149_1.var_.characterEffect6045_story and not isNil(var_152_9) then
					arg_149_1.var_.characterEffect6045_story.fillFlat = true
					arg_149_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_10)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_10 and arg_149_1.time_ < 0 + var_152_10 + arg_152_0 and not isNil(var_152_9) and arg_149_1.var_.characterEffect6045_story then
				arg_149_1.var_.characterEffect6045_story.fillFlat = true
				arg_149_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_152_11 = 0
			local var_152_12 = 1.125

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_11 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_13 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(1104201037).content)

				arg_149_1.text_.text = var_152_13

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_15 = 45 <= 0 and var_152_12 or var_152_12 * (utf8.len(var_152_13) / 45)

				if (45 <= 0 and var_152_12 or var_152_12 * (utf8.len(var_152_13) / 45)) > 0 and var_152_12 < var_152_15 then
					arg_149_1.talkMaxDuration = var_152_15

					if var_152_15 + var_152_11 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_15 + var_152_11
					end
				end

				arg_149_1.text_.text = var_152_13
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_16 = math.max(var_152_12, arg_149_1.talkMaxDuration)

			if var_152_11 <= arg_149_1.time_ and arg_149_1.time_ < var_152_11 + var_152_16 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_11) / var_152_16

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_11 + var_152_16 and arg_149_1.time_ < var_152_11 + var_152_16 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
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
	Play1104201038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 1104201038
		arg_153_1.duration_ = 6.27

		local var_153_0 = {
			ja = 6.266,
			ko = 5.633,
			zh = 5.633
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
				arg_153_0:Play1104201039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1042ui_story = arg_153_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_156_0 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 then
				arg_153_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1042ui_story, Vector3.New(0, -1.06, -6.2), (arg_153_1.time_ - 0) / var_156_0)
				arg_153_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1042ui_story"].transform.position).z)
				arg_153_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1042ui_story"].transform.localEulerAngles = arg_153_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 then
				arg_153_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_153_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1042ui_story"].transform.position).z)
				arg_153_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1042ui_story"].transform.localEulerAngles = arg_153_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_156_1 = arg_153_1.actors_["1042ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1042ui_story == nil then
				arg_153_1.var_.characterEffect1042ui_story = var_156_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_2 and not isNil(var_156_1) then
				if arg_153_1.var_.characterEffect1042ui_story and not isNil(var_156_1) then
					arg_153_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_2 and arg_153_1.time_ < 0 + var_156_2 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1042ui_story then
				arg_153_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_156_4 = 0
			local var_156_5 = 0.55

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_6 = arg_153_1:GetWordFromCfg(1104201038)
				local var_156_7 = arg_153_1:FormatText(var_156_6.content)

				arg_153_1.text_.text = var_156_7

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_9 = 22 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 22)

				if (22 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 22)) > 0 and var_156_5 < var_156_9 then
					arg_153_1.talkMaxDuration = var_156_9

					if var_156_9 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_9 + var_156_4
					end
				end

				arg_153_1.text_.text = var_156_7
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201038", "story_v_side_new_1104201.awb") ~= 0 then
					local var_156_10 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201038", "story_v_side_new_1104201.awb") / 1000

					if var_156_10 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_4
					end

					if var_156_6.prefab_name ~= "" and arg_153_1.actors_[var_156_6.prefab_name] ~= nil then
						local var_156_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_6.prefab_name].transform, "story_v_side_new_1104201", "1104201038", "story_v_side_new_1104201.awb")

						arg_153_1:RecordAudio("1104201038", var_156_11)
						arg_153_1:RecordAudio("1104201038", var_156_11)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201038", "story_v_side_new_1104201.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201038", "story_v_side_new_1104201.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_12 = math.max(var_156_5, arg_153_1.talkMaxDuration)

			if var_156_4 <= arg_153_1.time_ and arg_153_1.time_ < var_156_4 + var_156_12 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_4) / var_156_12

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_4 + var_156_12 and arg_153_1.time_ < var_156_4 + var_156_12 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play1104201039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 1104201039
		arg_157_1.duration_ = 4.77

		local var_157_0 = {
			ja = 4.766,
			ko = 2.766,
			zh = 2.766
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play1104201040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1042ui_story = arg_157_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_160_0 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 then
				arg_157_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_157_1.time_ - 0) / var_160_0)
				arg_157_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1042ui_story"].transform.position).z)
				arg_157_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1042ui_story"].transform.localEulerAngles = arg_157_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 then
				arg_157_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_157_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1042ui_story"].transform.position).z)
				arg_157_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1042ui_story"].transform.localEulerAngles = arg_157_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_160_1 = arg_157_1.actors_["1042ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1042ui_story == nil then
				arg_157_1.var_.characterEffect1042ui_story = var_160_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_2 and not isNil(var_160_1) then
				if arg_157_1.var_.characterEffect1042ui_story and not isNil(var_160_1) then
					arg_157_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_2)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_2 and arg_157_1.time_ < 0 + var_160_2 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1042ui_story then
				arg_157_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_160_3 = arg_157_1.actors_["6045_story"].transform

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos6045_story = var_160_3.localPosition

				local var_160_4 = GameObjectTools.GetOrAddComponent(var_160_3.gameObject, typeof(DynamicBoneHelper))

				if var_160_4 then
					var_160_4:EnableDynamicBone(false)
				end
			end

			local var_160_5 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_5 then
				var_160_3.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos6045_story, Vector3.New(-0.7, -0.5, -6.3), (arg_157_1.time_ - 0) / var_160_5)
				var_160_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_3.position).x, (manager.ui.mainCamera.transform.position - var_160_3.position).y, (manager.ui.mainCamera.transform.position - var_160_3.position).z)
				var_160_3.localEulerAngles.z = 0
				var_160_3.localEulerAngles.x = 0
				var_160_3.localEulerAngles = var_160_3.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_5 and arg_157_1.time_ < 0 + var_160_5 + arg_160_0 then
				var_160_3.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				var_160_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_3.position).x, (manager.ui.mainCamera.transform.position - var_160_3.position).y, (manager.ui.mainCamera.transform.position - var_160_3.position).z)
				var_160_3.localEulerAngles.z = 0
				var_160_3.localEulerAngles.x = 0
				var_160_3.localEulerAngles = var_160_3.localEulerAngles

				local var_160_6 = GameObjectTools.GetOrAddComponent(var_160_3.gameObject, typeof(DynamicBoneHelper))

				if var_160_6 then
					var_160_6:EnableDynamicBone(true)
				end
			end

			local var_160_7 = arg_157_1.actors_["6045_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_7) and arg_157_1.var_.characterEffect6045_story == nil then
				arg_157_1.var_.characterEffect6045_story = var_160_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_8 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_8 and not isNil(var_160_7) then
				if arg_157_1.var_.characterEffect6045_story and not isNil(var_160_7) then
					arg_157_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_8 and arg_157_1.time_ < 0 + var_160_8 + arg_160_0 and not isNil(var_160_7) and arg_157_1.var_.characterEffect6045_story then
				arg_157_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_160_10 = arg_157_1.actors_["6046_story"].transform

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos6046_story = var_160_10.localPosition

				local var_160_11 = GameObjectTools.GetOrAddComponent(var_160_10.gameObject, typeof(DynamicBoneHelper))

				if var_160_11 then
					var_160_11:EnableDynamicBone(false)
				end
			end

			local var_160_12 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_12 then
				var_160_10.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos6046_story, Vector3.New(0.7, -0.5, -6.3), (arg_157_1.time_ - 0) / var_160_12)
				var_160_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_10.position).x, (manager.ui.mainCamera.transform.position - var_160_10.position).y, (manager.ui.mainCamera.transform.position - var_160_10.position).z)
				var_160_10.localEulerAngles.z = 0
				var_160_10.localEulerAngles.x = 0
				var_160_10.localEulerAngles = var_160_10.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_12 and arg_157_1.time_ < 0 + var_160_12 + arg_160_0 then
				var_160_10.localPosition = Vector3.New(0.7, -0.5, -6.3)
				var_160_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_10.position).x, (manager.ui.mainCamera.transform.position - var_160_10.position).y, (manager.ui.mainCamera.transform.position - var_160_10.position).z)
				var_160_10.localEulerAngles.z = 0
				var_160_10.localEulerAngles.x = 0
				var_160_10.localEulerAngles = var_160_10.localEulerAngles

				local var_160_13 = GameObjectTools.GetOrAddComponent(var_160_10.gameObject, typeof(DynamicBoneHelper))

				if var_160_13 then
					var_160_13:EnableDynamicBone(true)
				end
			end

			local var_160_14 = arg_157_1.actors_["6046_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_14) and arg_157_1.var_.characterEffect6046_story == nil then
				arg_157_1.var_.characterEffect6046_story = var_160_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_15 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_15 and not isNil(var_160_14) then
				if arg_157_1.var_.characterEffect6046_story and not isNil(var_160_14) then
					arg_157_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_15 and arg_157_1.time_ < 0 + var_160_15 + arg_160_0 and not isNil(var_160_14) and arg_157_1.var_.characterEffect6046_story then
				arg_157_1.var_.characterEffect6046_story.fillFlat = false
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			local var_160_17 = 0
			local var_160_18 = 0.25

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_17 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[233].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_19 = arg_157_1:GetWordFromCfg(1104201039)
				local var_160_20 = arg_157_1:FormatText(var_160_19.content)

				arg_157_1.text_.text = var_160_20

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_22 = 10 <= 0 and var_160_18 or var_160_18 * (utf8.len(var_160_20) / 10)

				if (10 <= 0 and var_160_18 or var_160_18 * (utf8.len(var_160_20) / 10)) > 0 and var_160_18 < var_160_22 then
					arg_157_1.talkMaxDuration = var_160_22

					if var_160_22 + var_160_17 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_22 + var_160_17
					end
				end

				arg_157_1.text_.text = var_160_20
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201039", "story_v_side_new_1104201.awb") ~= 0 then
					local var_160_23 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201039", "story_v_side_new_1104201.awb") / 1000

					if var_160_23 + var_160_17 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_23 + var_160_17
					end

					if var_160_19.prefab_name ~= "" and arg_157_1.actors_[var_160_19.prefab_name] ~= nil then
						local var_160_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_19.prefab_name].transform, "story_v_side_new_1104201", "1104201039", "story_v_side_new_1104201.awb")

						arg_157_1:RecordAudio("1104201039", var_160_24)
						arg_157_1:RecordAudio("1104201039", var_160_24)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201039", "story_v_side_new_1104201.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201039", "story_v_side_new_1104201.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_25 = math.max(var_160_18, arg_157_1.talkMaxDuration)

			if var_160_17 <= arg_157_1.time_ and arg_157_1.time_ < var_160_17 + var_160_25 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_17) / var_160_25

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_17 + var_160_25 and arg_157_1.time_ < var_160_17 + var_160_25 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
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
	Play1104201040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 1104201040
		arg_161_1.duration_ = 6

		local var_161_0 = {
			ja = 6,
			ko = 5.866,
			zh = 5.866
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play1104201041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1042ui_story = arg_161_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1042ui_story, Vector3.New(0, -1.06, -6.2), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1042ui_story"].transform.position).z)
				arg_161_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1042ui_story"].transform.localEulerAngles = arg_161_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_161_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1042ui_story"].transform.position).z)
				arg_161_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1042ui_story"].transform.localEulerAngles = arg_161_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_164_1 = arg_161_1.actors_["6045_story"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos6045_story = var_164_1.localPosition

				local var_164_2 = GameObjectTools.GetOrAddComponent(var_164_1.gameObject, typeof(DynamicBoneHelper))

				if var_164_2 then
					var_164_2:EnableDynamicBone(false)
				end
			end

			local var_164_3 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_3 then
				var_164_1.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos6045_story, Vector3.New(0, 100, 0), (arg_161_1.time_ - 0) / var_164_3)
				var_164_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_1.position).x, (manager.ui.mainCamera.transform.position - var_164_1.position).y, (manager.ui.mainCamera.transform.position - var_164_1.position).z)
				var_164_1.localEulerAngles.z = 0
				var_164_1.localEulerAngles.x = 0
				var_164_1.localEulerAngles = var_164_1.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_3 and arg_161_1.time_ < 0 + var_164_3 + arg_164_0 then
				var_164_1.localPosition = Vector3.New(0, 100, 0)
				var_164_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_1.position).x, (manager.ui.mainCamera.transform.position - var_164_1.position).y, (manager.ui.mainCamera.transform.position - var_164_1.position).z)
				var_164_1.localEulerAngles.z = 0
				var_164_1.localEulerAngles.x = 0
				var_164_1.localEulerAngles = var_164_1.localEulerAngles

				local var_164_4 = GameObjectTools.GetOrAddComponent(var_164_1.gameObject, typeof(DynamicBoneHelper))

				if var_164_4 then
					var_164_4:EnableDynamicBone(true)
				end
			end

			local var_164_5 = arg_161_1.actors_["6045_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_5) and arg_161_1.var_.characterEffect6045_story == nil then
				arg_161_1.var_.characterEffect6045_story = var_164_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_6 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_6 and not isNil(var_164_5) then
				if arg_161_1.var_.characterEffect6045_story and not isNil(var_164_5) then
					arg_161_1.var_.characterEffect6045_story.fillFlat = true
					arg_161_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_6)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_6 and arg_161_1.time_ < 0 + var_164_6 + arg_164_0 and not isNil(var_164_5) and arg_161_1.var_.characterEffect6045_story then
				arg_161_1.var_.characterEffect6045_story.fillFlat = true
				arg_161_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_164_7 = arg_161_1.actors_["6046_story"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos6046_story = var_164_7.localPosition

				local var_164_8 = GameObjectTools.GetOrAddComponent(var_164_7.gameObject, typeof(DynamicBoneHelper))

				if var_164_8 then
					var_164_8:EnableDynamicBone(false)
				end
			end

			local var_164_9 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_9 then
				var_164_7.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (arg_161_1.time_ - 0) / var_164_9)
				var_164_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_7.position).x, (manager.ui.mainCamera.transform.position - var_164_7.position).y, (manager.ui.mainCamera.transform.position - var_164_7.position).z)
				var_164_7.localEulerAngles.z = 0
				var_164_7.localEulerAngles.x = 0
				var_164_7.localEulerAngles = var_164_7.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_9 and arg_161_1.time_ < 0 + var_164_9 + arg_164_0 then
				var_164_7.localPosition = Vector3.New(0, 100, 0)
				var_164_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_7.position).x, (manager.ui.mainCamera.transform.position - var_164_7.position).y, (manager.ui.mainCamera.transform.position - var_164_7.position).z)
				var_164_7.localEulerAngles.z = 0
				var_164_7.localEulerAngles.x = 0
				var_164_7.localEulerAngles = var_164_7.localEulerAngles

				local var_164_10 = GameObjectTools.GetOrAddComponent(var_164_7.gameObject, typeof(DynamicBoneHelper))

				if var_164_10 then
					var_164_10:EnableDynamicBone(true)
				end
			end

			local var_164_11 = arg_161_1.actors_["6046_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_11) and arg_161_1.var_.characterEffect6046_story == nil then
				arg_161_1.var_.characterEffect6046_story = var_164_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_12 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_12 and not isNil(var_164_11) then
				if arg_161_1.var_.characterEffect6046_story and not isNil(var_164_11) then
					arg_161_1.var_.characterEffect6046_story.fillFlat = true
					arg_161_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_12)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_12 and arg_161_1.time_ < 0 + var_164_12 + arg_164_0 and not isNil(var_164_11) and arg_161_1.var_.characterEffect6046_story then
				arg_161_1.var_.characterEffect6046_story.fillFlat = true
				arg_161_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_2")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_164_13 = arg_161_1.actors_["1042ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_13) and arg_161_1.var_.characterEffect1042ui_story == nil then
				arg_161_1.var_.characterEffect1042ui_story = var_164_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_14 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_14 and not isNil(var_164_13) then
				if arg_161_1.var_.characterEffect1042ui_story and not isNil(var_164_13) then
					arg_161_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_14 and arg_161_1.time_ < 0 + var_164_14 + arg_164_0 and not isNil(var_164_13) and arg_161_1.var_.characterEffect1042ui_story then
				arg_161_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_164_16 = 0
			local var_164_17 = 0.6

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_16 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_18 = arg_161_1:GetWordFromCfg(1104201040)
				local var_164_19 = arg_161_1:FormatText(var_164_18.content)

				arg_161_1.text_.text = var_164_19

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_21 = 24 <= 0 and var_164_17 or var_164_17 * (utf8.len(var_164_19) / 24)

				if (24 <= 0 and var_164_17 or var_164_17 * (utf8.len(var_164_19) / 24)) > 0 and var_164_17 < var_164_21 then
					arg_161_1.talkMaxDuration = var_164_21

					if var_164_21 + var_164_16 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_21 + var_164_16
					end
				end

				arg_161_1.text_.text = var_164_19
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201040", "story_v_side_new_1104201.awb") ~= 0 then
					local var_164_22 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201040", "story_v_side_new_1104201.awb") / 1000

					if var_164_22 + var_164_16 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_22 + var_164_16
					end

					if var_164_18.prefab_name ~= "" and arg_161_1.actors_[var_164_18.prefab_name] ~= nil then
						local var_164_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_18.prefab_name].transform, "story_v_side_new_1104201", "1104201040", "story_v_side_new_1104201.awb")

						arg_161_1:RecordAudio("1104201040", var_164_23)
						arg_161_1:RecordAudio("1104201040", var_164_23)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201040", "story_v_side_new_1104201.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201040", "story_v_side_new_1104201.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_24 = math.max(var_164_17, arg_161_1.talkMaxDuration)

			if var_164_16 <= arg_161_1.time_ and arg_161_1.time_ < var_164_16 + var_164_24 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_16) / var_164_24

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_16 + var_164_24 and arg_161_1.time_ < var_164_16 + var_164_24 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play1104201041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 1104201041
		arg_165_1.duration_ = 11.57

		local var_165_0 = {
			ja = 11.566,
			ko = 10.9,
			zh = 10.9
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play1104201042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1042ui_story = arg_165_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1042ui_story"].transform.position).z)
				arg_165_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1042ui_story"].transform.localEulerAngles = arg_165_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_165_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1042ui_story"].transform.position).z)
				arg_165_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1042ui_story"].transform.localEulerAngles = arg_165_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_168_1 = arg_165_1.actors_["1042ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1042ui_story == nil then
				arg_165_1.var_.characterEffect1042ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 and not isNil(var_168_1) then
				if arg_165_1.var_.characterEffect1042ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_2)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1042ui_story then
				arg_165_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_168_3 = arg_165_1.actors_["6045_story"].transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos6045_story = var_168_3.localPosition

				local var_168_4 = GameObjectTools.GetOrAddComponent(var_168_3.gameObject, typeof(DynamicBoneHelper))

				if var_168_4 then
					var_168_4:EnableDynamicBone(false)
				end
			end

			local var_168_5 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_5 then
				var_168_3.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos6045_story, Vector3.New(-0.7, -0.5, -6.3), (arg_165_1.time_ - 0) / var_168_5)
				var_168_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_3.position).x, (manager.ui.mainCamera.transform.position - var_168_3.position).y, (manager.ui.mainCamera.transform.position - var_168_3.position).z)
				var_168_3.localEulerAngles.z = 0
				var_168_3.localEulerAngles.x = 0
				var_168_3.localEulerAngles = var_168_3.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_5 and arg_165_1.time_ < 0 + var_168_5 + arg_168_0 then
				var_168_3.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				var_168_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_3.position).x, (manager.ui.mainCamera.transform.position - var_168_3.position).y, (manager.ui.mainCamera.transform.position - var_168_3.position).z)
				var_168_3.localEulerAngles.z = 0
				var_168_3.localEulerAngles.x = 0
				var_168_3.localEulerAngles = var_168_3.localEulerAngles

				local var_168_6 = GameObjectTools.GetOrAddComponent(var_168_3.gameObject, typeof(DynamicBoneHelper))

				if var_168_6 then
					var_168_6:EnableDynamicBone(true)
				end
			end

			local var_168_7 = arg_165_1.actors_["6045_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_7) and arg_165_1.var_.characterEffect6045_story == nil then
				arg_165_1.var_.characterEffect6045_story = var_168_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_8 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_8 and not isNil(var_168_7) then
				if arg_165_1.var_.characterEffect6045_story and not isNil(var_168_7) then
					arg_165_1.var_.characterEffect6045_story.fillFlat = true
					arg_165_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_8)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_8 and arg_165_1.time_ < 0 + var_168_8 + arg_168_0 and not isNil(var_168_7) and arg_165_1.var_.characterEffect6045_story then
				arg_165_1.var_.characterEffect6045_story.fillFlat = true
				arg_165_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_168_9 = arg_165_1.actors_["6046_story"].transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos6046_story = var_168_9.localPosition

				local var_168_10 = GameObjectTools.GetOrAddComponent(var_168_9.gameObject, typeof(DynamicBoneHelper))

				if var_168_10 then
					var_168_10:EnableDynamicBone(false)
				end
			end

			local var_168_11 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_11 then
				var_168_9.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos6046_story, Vector3.New(0.7, -0.5, -6.3), (arg_165_1.time_ - 0) / var_168_11)
				var_168_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_9.position).x, (manager.ui.mainCamera.transform.position - var_168_9.position).y, (manager.ui.mainCamera.transform.position - var_168_9.position).z)
				var_168_9.localEulerAngles.z = 0
				var_168_9.localEulerAngles.x = 0
				var_168_9.localEulerAngles = var_168_9.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_11 and arg_165_1.time_ < 0 + var_168_11 + arg_168_0 then
				var_168_9.localPosition = Vector3.New(0.7, -0.5, -6.3)
				var_168_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_9.position).x, (manager.ui.mainCamera.transform.position - var_168_9.position).y, (manager.ui.mainCamera.transform.position - var_168_9.position).z)
				var_168_9.localEulerAngles.z = 0
				var_168_9.localEulerAngles.x = 0
				var_168_9.localEulerAngles = var_168_9.localEulerAngles

				local var_168_12 = GameObjectTools.GetOrAddComponent(var_168_9.gameObject, typeof(DynamicBoneHelper))

				if var_168_12 then
					var_168_12:EnableDynamicBone(true)
				end
			end

			local var_168_13 = arg_165_1.actors_["6046_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_13) and arg_165_1.var_.characterEffect6046_story == nil then
				arg_165_1.var_.characterEffect6046_story = var_168_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_14 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_14 and not isNil(var_168_13) then
				if arg_165_1.var_.characterEffect6046_story and not isNil(var_168_13) then
					arg_165_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_14 and arg_165_1.time_ < 0 + var_168_14 + arg_168_0 and not isNil(var_168_13) and arg_165_1.var_.characterEffect6046_story then
				arg_165_1.var_.characterEffect6046_story.fillFlat = false
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action3_1")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_168_16 = 0
			local var_168_17 = 1.05

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_16 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_18 = arg_165_1:GetWordFromCfg(1104201041)
				local var_168_19 = arg_165_1:FormatText(var_168_18.content)

				arg_165_1.text_.text = var_168_19

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_21 = 42 <= 0 and var_168_17 or var_168_17 * (utf8.len(var_168_19) / 42)

				if (42 <= 0 and var_168_17 or var_168_17 * (utf8.len(var_168_19) / 42)) > 0 and var_168_17 < var_168_21 then
					arg_165_1.talkMaxDuration = var_168_21

					if var_168_21 + var_168_16 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_21 + var_168_16
					end
				end

				arg_165_1.text_.text = var_168_19
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201041", "story_v_side_new_1104201.awb") ~= 0 then
					local var_168_22 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201041", "story_v_side_new_1104201.awb") / 1000

					if var_168_22 + var_168_16 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_22 + var_168_16
					end

					if var_168_18.prefab_name ~= "" and arg_165_1.actors_[var_168_18.prefab_name] ~= nil then
						local var_168_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_18.prefab_name].transform, "story_v_side_new_1104201", "1104201041", "story_v_side_new_1104201.awb")

						arg_165_1:RecordAudio("1104201041", var_168_23)
						arg_165_1:RecordAudio("1104201041", var_168_23)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201041", "story_v_side_new_1104201.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201041", "story_v_side_new_1104201.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_24 = math.max(var_168_17, arg_165_1.talkMaxDuration)

			if var_168_16 <= arg_165_1.time_ and arg_165_1.time_ < var_168_16 + var_168_24 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_16) / var_168_24

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_16 + var_168_24 and arg_165_1.time_ < var_168_16 + var_168_24 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
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
	Play1104201042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 1104201042
		arg_169_1.duration_ = 12.47

		local var_169_0 = {
			ja = 11.533,
			ko = 12.466,
			zh = 12.466
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play1104201043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(arg_169_1.actors_["6045_story"]) and arg_169_1.var_.characterEffect6045_story == nil then
				arg_169_1.var_.characterEffect6045_story = arg_169_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_0 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 and not isNil(arg_169_1.actors_["6045_story"]) then
				if arg_169_1.var_.characterEffect6045_story and not isNil(arg_169_1.actors_["6045_story"]) then
					arg_169_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 and not isNil(arg_169_1.actors_["6045_story"]) and arg_169_1.var_.characterEffect6045_story then
				arg_169_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action3_1")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_172_2 = arg_169_1.actors_["6046_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.characterEffect6046_story == nil then
				arg_169_1.var_.characterEffect6046_story = var_172_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_3 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_3 and not isNil(var_172_2) then
				if arg_169_1.var_.characterEffect6046_story and not isNil(var_172_2) then
					arg_169_1.var_.characterEffect6046_story.fillFlat = true
					arg_169_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_3)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_3 and arg_169_1.time_ < 0 + var_172_3 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.characterEffect6046_story then
				arg_169_1.var_.characterEffect6046_story.fillFlat = true
				arg_169_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_172_4 = 0
			local var_172_5 = 1.125

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_4 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_6 = arg_169_1:GetWordFromCfg(1104201042)
				local var_172_7 = arg_169_1:FormatText(var_172_6.content)

				arg_169_1.text_.text = var_172_7

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_9 = 45 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 45)

				if (45 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 45)) > 0 and var_172_5 < var_172_9 then
					arg_169_1.talkMaxDuration = var_172_9

					if var_172_9 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_9 + var_172_4
					end
				end

				arg_169_1.text_.text = var_172_7
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201042", "story_v_side_new_1104201.awb") ~= 0 then
					local var_172_10 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201042", "story_v_side_new_1104201.awb") / 1000

					if var_172_10 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_10 + var_172_4
					end

					if var_172_6.prefab_name ~= "" and arg_169_1.actors_[var_172_6.prefab_name] ~= nil then
						local var_172_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_6.prefab_name].transform, "story_v_side_new_1104201", "1104201042", "story_v_side_new_1104201.awb")

						arg_169_1:RecordAudio("1104201042", var_172_11)
						arg_169_1:RecordAudio("1104201042", var_172_11)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201042", "story_v_side_new_1104201.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201042", "story_v_side_new_1104201.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_12 = math.max(var_172_5, arg_169_1.talkMaxDuration)

			if var_172_4 <= arg_169_1.time_ and arg_169_1.time_ < var_172_4 + var_172_12 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_4) / var_172_12

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_4 + var_172_12 and arg_169_1.time_ < var_172_4 + var_172_12 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play1104201043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 1104201043
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play1104201044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["6045_story"]) and arg_173_1.var_.characterEffect6045_story == nil then
				arg_173_1.var_.characterEffect6045_story = arg_173_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_0 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["6045_story"]) then
				if arg_173_1.var_.characterEffect6045_story and not isNil(arg_173_1.actors_["6045_story"]) then
					arg_173_1.var_.characterEffect6045_story.fillFlat = true
					arg_173_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_0)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["6045_story"]) and arg_173_1.var_.characterEffect6045_story then
				arg_173_1.var_.characterEffect6045_story.fillFlat = true
				arg_173_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action3_2")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action3_2")
			end

			local var_176_1 = 0
			local var_176_2 = 0.75

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_3 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(1104201043).content)

				arg_173_1.text_.text = var_176_3

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 30 <= 0 and var_176_2 or var_176_2 * (utf8.len(var_176_3) / 30)

				if (30 <= 0 and var_176_2 or var_176_2 * (utf8.len(var_176_3) / 30)) > 0 and var_176_2 < var_176_5 then
					arg_173_1.talkMaxDuration = var_176_5

					if var_176_5 + var_176_1 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + var_176_1
					end
				end

				arg_173_1.text_.text = var_176_3
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_6 = math.max(var_176_2, arg_173_1.talkMaxDuration)

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_6 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_1) / var_176_6

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_1 + var_176_6 and arg_173_1.time_ < var_176_1 + var_176_6 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play1104201044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 1104201044
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play1104201045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0.85

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_1 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(1104201044).content)

				arg_177_1.text_.text = var_180_1

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_3 = 34 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_1) / 34)

				if (34 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_1) / 34)) > 0 and var_180_0 < var_180_3 then
					arg_177_1.talkMaxDuration = var_180_3

					if var_180_3 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_3 + 0
					end
				end

				arg_177_1.text_.text = var_180_1
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_4 = math.max(var_180_0, arg_177_1.talkMaxDuration)

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_4 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - 0) / var_180_4

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= 0 + var_180_4 and arg_177_1.time_ < 0 + var_180_4 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play1104201045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 1104201045
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play1104201046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 1.075

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_1 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(1104201045).content)

				arg_181_1.text_.text = var_184_1

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_3 = 43 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 43)

				if (43 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 43)) > 0 and var_184_0 < var_184_3 then
					arg_181_1.talkMaxDuration = var_184_3

					if var_184_3 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_3 + 0
					end
				end

				arg_181_1.text_.text = var_184_1
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_4 = math.max(var_184_0, arg_181_1.talkMaxDuration)

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_4 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - 0) / var_184_4

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= 0 + var_184_4 and arg_181_1.time_ < 0 + var_184_4 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play1104201046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 1104201046
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play1104201047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0.225

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_1 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(1104201046).content)

				arg_185_1.text_.text = var_188_1

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_3 = 9 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 9)

				if (9 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 9)) > 0 and var_188_0 < var_188_3 then
					arg_185_1.talkMaxDuration = var_188_3

					if var_188_3 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_3 + 0
					end
				end

				arg_185_1.text_.text = var_188_1
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_4 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_4 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_4

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_4 and arg_185_1.time_ < 0 + var_188_4 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play1104201047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 1104201047
		arg_189_1.duration_ = 9.1

		local var_189_0 = {
			ja = 5.233,
			ko = 9.1,
			zh = 9.1
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
				arg_189_0:Play1104201048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1042ui_story = arg_189_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_192_0 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 then
				arg_189_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1042ui_story, Vector3.New(0, -1.06, -6.2), (arg_189_1.time_ - 0) / var_192_0)
				arg_189_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1042ui_story"].transform.position).z)
				arg_189_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1042ui_story"].transform.localEulerAngles = arg_189_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 then
				arg_189_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_189_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1042ui_story"].transform.position).z)
				arg_189_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1042ui_story"].transform.localEulerAngles = arg_189_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_192_1 = arg_189_1.actors_["1042ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1042ui_story == nil then
				arg_189_1.var_.characterEffect1042ui_story = var_192_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_2 and not isNil(var_192_1) then
				if arg_189_1.var_.characterEffect1042ui_story and not isNil(var_192_1) then
					arg_189_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= 0 + var_192_2 and arg_189_1.time_ < 0 + var_192_2 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1042ui_story then
				arg_189_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_192_4 = arg_189_1.actors_["6045_story"].transform

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos6045_story = var_192_4.localPosition

				local var_192_5 = GameObjectTools.GetOrAddComponent(var_192_4.gameObject, typeof(DynamicBoneHelper))

				if var_192_5 then
					var_192_5:EnableDynamicBone(false)
				end
			end

			local var_192_6 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_6 then
				var_192_4.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos6045_story, Vector3.New(0, 100, 0), (arg_189_1.time_ - 0) / var_192_6)
				var_192_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_4.position).x, (manager.ui.mainCamera.transform.position - var_192_4.position).y, (manager.ui.mainCamera.transform.position - var_192_4.position).z)
				var_192_4.localEulerAngles.z = 0
				var_192_4.localEulerAngles.x = 0
				var_192_4.localEulerAngles = var_192_4.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_6 and arg_189_1.time_ < 0 + var_192_6 + arg_192_0 then
				var_192_4.localPosition = Vector3.New(0, 100, 0)
				var_192_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_4.position).x, (manager.ui.mainCamera.transform.position - var_192_4.position).y, (manager.ui.mainCamera.transform.position - var_192_4.position).z)
				var_192_4.localEulerAngles.z = 0
				var_192_4.localEulerAngles.x = 0
				var_192_4.localEulerAngles = var_192_4.localEulerAngles

				local var_192_7 = GameObjectTools.GetOrAddComponent(var_192_4.gameObject, typeof(DynamicBoneHelper))

				if var_192_7 then
					var_192_7:EnableDynamicBone(true)
				end
			end

			local var_192_8 = arg_189_1.actors_["6045_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_8) and arg_189_1.var_.characterEffect6045_story == nil then
				arg_189_1.var_.characterEffect6045_story = var_192_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_9 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_9 and not isNil(var_192_8) then
				if arg_189_1.var_.characterEffect6045_story and not isNil(var_192_8) then
					arg_189_1.var_.characterEffect6045_story.fillFlat = true
					arg_189_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_9)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_9 and arg_189_1.time_ < 0 + var_192_9 + arg_192_0 and not isNil(var_192_8) and arg_189_1.var_.characterEffect6045_story then
				arg_189_1.var_.characterEffect6045_story.fillFlat = true
				arg_189_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_192_10 = arg_189_1.actors_["6046_story"].transform

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos6046_story = var_192_10.localPosition

				local var_192_11 = GameObjectTools.GetOrAddComponent(var_192_10.gameObject, typeof(DynamicBoneHelper))

				if var_192_11 then
					var_192_11:EnableDynamicBone(false)
				end
			end

			local var_192_12 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_12 then
				var_192_10.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (arg_189_1.time_ - 0) / var_192_12)
				var_192_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_10.position).x, (manager.ui.mainCamera.transform.position - var_192_10.position).y, (manager.ui.mainCamera.transform.position - var_192_10.position).z)
				var_192_10.localEulerAngles.z = 0
				var_192_10.localEulerAngles.x = 0
				var_192_10.localEulerAngles = var_192_10.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_12 and arg_189_1.time_ < 0 + var_192_12 + arg_192_0 then
				var_192_10.localPosition = Vector3.New(0, 100, 0)
				var_192_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_10.position).x, (manager.ui.mainCamera.transform.position - var_192_10.position).y, (manager.ui.mainCamera.transform.position - var_192_10.position).z)
				var_192_10.localEulerAngles.z = 0
				var_192_10.localEulerAngles.x = 0
				var_192_10.localEulerAngles = var_192_10.localEulerAngles

				local var_192_13 = GameObjectTools.GetOrAddComponent(var_192_10.gameObject, typeof(DynamicBoneHelper))

				if var_192_13 then
					var_192_13:EnableDynamicBone(true)
				end
			end

			local var_192_14 = arg_189_1.actors_["6046_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_14) and arg_189_1.var_.characterEffect6046_story == nil then
				arg_189_1.var_.characterEffect6046_story = var_192_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_15 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_15 and not isNil(var_192_14) then
				if arg_189_1.var_.characterEffect6046_story and not isNil(var_192_14) then
					arg_189_1.var_.characterEffect6046_story.fillFlat = true
					arg_189_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_15)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_15 and arg_189_1.time_ < 0 + var_192_15 + arg_192_0 and not isNil(var_192_14) and arg_189_1.var_.characterEffect6046_story then
				arg_189_1.var_.characterEffect6046_story.fillFlat = true
				arg_189_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action1_1")
			end

			local var_192_16 = 0
			local var_192_17 = 0.95

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_16 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_18 = arg_189_1:GetWordFromCfg(1104201047)
				local var_192_19 = arg_189_1:FormatText(var_192_18.content)

				arg_189_1.text_.text = var_192_19

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_21 = 38 <= 0 and var_192_17 or var_192_17 * (utf8.len(var_192_19) / 38)

				if (38 <= 0 and var_192_17 or var_192_17 * (utf8.len(var_192_19) / 38)) > 0 and var_192_17 < var_192_21 then
					arg_189_1.talkMaxDuration = var_192_21

					if var_192_21 + var_192_16 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_21 + var_192_16
					end
				end

				arg_189_1.text_.text = var_192_19
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201047", "story_v_side_new_1104201.awb") ~= 0 then
					local var_192_22 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201047", "story_v_side_new_1104201.awb") / 1000

					if var_192_22 + var_192_16 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_22 + var_192_16
					end

					if var_192_18.prefab_name ~= "" and arg_189_1.actors_[var_192_18.prefab_name] ~= nil then
						local var_192_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_18.prefab_name].transform, "story_v_side_new_1104201", "1104201047", "story_v_side_new_1104201.awb")

						arg_189_1:RecordAudio("1104201047", var_192_23)
						arg_189_1:RecordAudio("1104201047", var_192_23)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201047", "story_v_side_new_1104201.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201047", "story_v_side_new_1104201.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_24 = math.max(var_192_17, arg_189_1.talkMaxDuration)

			if var_192_16 <= arg_189_1.time_ and arg_189_1.time_ < var_192_16 + var_192_24 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_16) / var_192_24

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_16 + var_192_24 and arg_189_1.time_ < var_192_16 + var_192_24 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play1104201048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 1104201048
		arg_193_1.duration_ = 7.43

		local var_193_0 = {
			ja = 4.966,
			ko = 7.433,
			zh = 7.433
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
				arg_193_0:Play1104201049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action6_1")
			end

			local var_196_0 = 0
			local var_196_1 = 0.6

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_2 = arg_193_1:GetWordFromCfg(1104201048)
				local var_196_3 = arg_193_1:FormatText(var_196_2.content)

				arg_193_1.text_.text = var_196_3

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 24 <= 0 and var_196_1 or var_196_1 * (utf8.len(var_196_3) / 24)

				if (24 <= 0 and var_196_1 or var_196_1 * (utf8.len(var_196_3) / 24)) > 0 and var_196_1 < var_196_5 then
					arg_193_1.talkMaxDuration = var_196_5

					if var_196_5 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + var_196_0
					end
				end

				arg_193_1.text_.text = var_196_3
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201048", "story_v_side_new_1104201.awb") ~= 0 then
					local var_196_6 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201048", "story_v_side_new_1104201.awb") / 1000

					if var_196_6 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_6 + var_196_0
					end

					if var_196_2.prefab_name ~= "" and arg_193_1.actors_[var_196_2.prefab_name] ~= nil then
						local var_196_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_2.prefab_name].transform, "story_v_side_new_1104201", "1104201048", "story_v_side_new_1104201.awb")

						arg_193_1:RecordAudio("1104201048", var_196_7)
						arg_193_1:RecordAudio("1104201048", var_196_7)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201048", "story_v_side_new_1104201.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201048", "story_v_side_new_1104201.awb")
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
	Play1104201049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 1104201049
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play1104201050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["1042ui_story"]) and arg_197_1.var_.characterEffect1042ui_story == nil then
				arg_197_1.var_.characterEffect1042ui_story = arg_197_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_0 = 0.2

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["1042ui_story"]) then
				if arg_197_1.var_.characterEffect1042ui_story and not isNil(arg_197_1.actors_["1042ui_story"]) then
					arg_197_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_0)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["1042ui_story"]) and arg_197_1.var_.characterEffect1042ui_story then
				arg_197_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_200_1 = 0
			local var_200_2 = 0.625

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

				local var_200_3 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(1104201049).content)

				arg_197_1.text_.text = var_200_3

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 25 <= 0 and var_200_2 or var_200_2 * (utf8.len(var_200_3) / 25)

				if (25 <= 0 and var_200_2 or var_200_2 * (utf8.len(var_200_3) / 25)) > 0 and var_200_2 < var_200_5 then
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
	Play1104201050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 1104201050
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play1104201051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 1

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_1 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(1104201050).content)

				arg_201_1.text_.text = var_204_1

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_3 = 40 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 40)

				if (40 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 40)) > 0 and var_204_0 < var_204_3 then
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
	Play1104201051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 1104201051
		arg_205_1.duration_ = 7.93

		local var_205_0 = {
			ja = 7.933,
			ko = 7.166,
			zh = 7.166
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play1104201052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(arg_205_1.actors_["1042ui_story"]) and arg_205_1.var_.characterEffect1042ui_story == nil then
				arg_205_1.var_.characterEffect1042ui_story = arg_205_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_0 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 and not isNil(arg_205_1.actors_["1042ui_story"]) then
				if arg_205_1.var_.characterEffect1042ui_story and not isNil(arg_205_1.actors_["1042ui_story"]) then
					arg_205_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 and not isNil(arg_205_1.actors_["1042ui_story"]) and arg_205_1.var_.characterEffect1042ui_story then
				arg_205_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_208_2 = 0
			local var_208_3 = 0.575

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_2 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_4 = arg_205_1:GetWordFromCfg(1104201051)
				local var_208_5 = arg_205_1:FormatText(var_208_4.content)

				arg_205_1.text_.text = var_208_5

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_7 = 23 <= 0 and var_208_3 or var_208_3 * (utf8.len(var_208_5) / 23)

				if (23 <= 0 and var_208_3 or var_208_3 * (utf8.len(var_208_5) / 23)) > 0 and var_208_3 < var_208_7 then
					arg_205_1.talkMaxDuration = var_208_7

					if var_208_7 + var_208_2 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_7 + var_208_2
					end
				end

				arg_205_1.text_.text = var_208_5
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201051", "story_v_side_new_1104201.awb") ~= 0 then
					local var_208_8 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201051", "story_v_side_new_1104201.awb") / 1000

					if var_208_8 + var_208_2 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_8 + var_208_2
					end

					if var_208_4.prefab_name ~= "" and arg_205_1.actors_[var_208_4.prefab_name] ~= nil then
						local var_208_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_4.prefab_name].transform, "story_v_side_new_1104201", "1104201051", "story_v_side_new_1104201.awb")

						arg_205_1:RecordAudio("1104201051", var_208_9)
						arg_205_1:RecordAudio("1104201051", var_208_9)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201051", "story_v_side_new_1104201.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201051", "story_v_side_new_1104201.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_10 = math.max(var_208_3, arg_205_1.talkMaxDuration)

			if var_208_2 <= arg_205_1.time_ and arg_205_1.time_ < var_208_2 + var_208_10 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_2) / var_208_10

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_2 + var_208_10 and arg_205_1.time_ < var_208_2 + var_208_10 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play1104201052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 1104201052
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play1104201053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(arg_209_1.actors_["1042ui_story"]) and arg_209_1.var_.characterEffect1042ui_story == nil then
				arg_209_1.var_.characterEffect1042ui_story = arg_209_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_0 = 0.2

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 and not isNil(arg_209_1.actors_["1042ui_story"]) then
				if arg_209_1.var_.characterEffect1042ui_story and not isNil(arg_209_1.actors_["1042ui_story"]) then
					arg_209_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_209_1.time_ - 0) / var_212_0)
				end
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 and not isNil(arg_209_1.actors_["1042ui_story"]) and arg_209_1.var_.characterEffect1042ui_story then
				arg_209_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_212_1 = 0
			local var_212_2 = 0.6

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

				local var_212_3 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(1104201052).content)

				arg_209_1.text_.text = var_212_3

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_5 = 24 <= 0 and var_212_2 or var_212_2 * (utf8.len(var_212_3) / 24)

				if (24 <= 0 and var_212_2 or var_212_2 * (utf8.len(var_212_3) / 24)) > 0 and var_212_2 < var_212_5 then
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

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play1104201053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 1104201053
		arg_213_1.duration_ = 10.87

		local var_213_0 = {
			ja = 10.866,
			ko = 7.633,
			zh = 7.633
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
				arg_213_0:Play1104201054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(arg_213_1.actors_["1042ui_story"]) and arg_213_1.var_.characterEffect1042ui_story == nil then
				arg_213_1.var_.characterEffect1042ui_story = arg_213_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_0 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 and not isNil(arg_213_1.actors_["1042ui_story"]) then
				if arg_213_1.var_.characterEffect1042ui_story and not isNil(arg_213_1.actors_["1042ui_story"]) then
					arg_213_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 and not isNil(arg_213_1.actors_["1042ui_story"]) and arg_213_1.var_.characterEffect1042ui_story then
				arg_213_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action6_2")
			end

			local var_216_2 = 0
			local var_216_3 = 0.85

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_2 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_4 = arg_213_1:GetWordFromCfg(1104201053)
				local var_216_5 = arg_213_1:FormatText(var_216_4.content)

				arg_213_1.text_.text = var_216_5

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_7 = 34 <= 0 and var_216_3 or var_216_3 * (utf8.len(var_216_5) / 34)

				if (34 <= 0 and var_216_3 or var_216_3 * (utf8.len(var_216_5) / 34)) > 0 and var_216_3 < var_216_7 then
					arg_213_1.talkMaxDuration = var_216_7

					if var_216_7 + var_216_2 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_7 + var_216_2
					end
				end

				arg_213_1.text_.text = var_216_5
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201053", "story_v_side_new_1104201.awb") ~= 0 then
					local var_216_8 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201053", "story_v_side_new_1104201.awb") / 1000

					if var_216_8 + var_216_2 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_8 + var_216_2
					end

					if var_216_4.prefab_name ~= "" and arg_213_1.actors_[var_216_4.prefab_name] ~= nil then
						local var_216_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_4.prefab_name].transform, "story_v_side_new_1104201", "1104201053", "story_v_side_new_1104201.awb")

						arg_213_1:RecordAudio("1104201053", var_216_9)
						arg_213_1:RecordAudio("1104201053", var_216_9)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201053", "story_v_side_new_1104201.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201053", "story_v_side_new_1104201.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_10 = math.max(var_216_3, arg_213_1.talkMaxDuration)

			if var_216_2 <= arg_213_1.time_ and arg_213_1.time_ < var_216_2 + var_216_10 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_2) / var_216_10

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_2 + var_216_10 and arg_213_1.time_ < var_216_2 + var_216_10 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play1104201054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 1104201054
		arg_217_1.duration_ = 12.07

		local var_217_0 = {
			ja = 12.066,
			ko = 11.733,
			zh = 11.733
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play1104201055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 1.125

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_1 = arg_217_1:GetWordFromCfg(1104201054)
				local var_220_2 = arg_217_1:FormatText(var_220_1.content)

				arg_217_1.text_.text = var_220_2

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_4 = 45 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 45)

				if (45 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 45)) > 0 and var_220_0 < var_220_4 then
					arg_217_1.talkMaxDuration = var_220_4

					if var_220_4 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_4 + 0
					end
				end

				arg_217_1.text_.text = var_220_2
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201054", "story_v_side_new_1104201.awb") ~= 0 then
					local var_220_5 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201054", "story_v_side_new_1104201.awb") / 1000

					if var_220_5 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + 0
					end

					if var_220_1.prefab_name ~= "" and arg_217_1.actors_[var_220_1.prefab_name] ~= nil then
						local var_220_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_1.prefab_name].transform, "story_v_side_new_1104201", "1104201054", "story_v_side_new_1104201.awb")

						arg_217_1:RecordAudio("1104201054", var_220_6)
						arg_217_1:RecordAudio("1104201054", var_220_6)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201054", "story_v_side_new_1104201.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201054", "story_v_side_new_1104201.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_7 = math.max(var_220_0, arg_217_1.talkMaxDuration)

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_7 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - 0) / var_220_7

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= 0 + var_220_7 and arg_217_1.time_ < 0 + var_220_7 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play1104201055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1104201055
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play1104201056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(arg_221_1.actors_["1042ui_story"]) and arg_221_1.var_.characterEffect1042ui_story == nil then
				arg_221_1.var_.characterEffect1042ui_story = arg_221_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_0 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 and not isNil(arg_221_1.actors_["1042ui_story"]) then
				if arg_221_1.var_.characterEffect1042ui_story and not isNil(arg_221_1.actors_["1042ui_story"]) then
					arg_221_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_221_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_221_1.time_ - 0) / var_224_0)
				end
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 and not isNil(arg_221_1.actors_["1042ui_story"]) and arg_221_1.var_.characterEffect1042ui_story then
				arg_221_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_221_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_224_1 = 0
			local var_224_2 = 0.3

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
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

				local var_224_3 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(1104201055).content)

				arg_221_1.text_.text = var_224_3

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_5 = 12 <= 0 and var_224_2 or var_224_2 * (utf8.len(var_224_3) / 12)

				if (12 <= 0 and var_224_2 or var_224_2 * (utf8.len(var_224_3) / 12)) > 0 and var_224_2 < var_224_5 then
					arg_221_1.talkMaxDuration = var_224_5

					if var_224_5 + var_224_1 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + var_224_1
					end
				end

				arg_221_1.text_.text = var_224_3
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_6 = math.max(var_224_2, arg_221_1.talkMaxDuration)

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_6 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_1) / var_224_6

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_1 + var_224_6 and arg_221_1.time_ < var_224_1 + var_224_6 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play1104201056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1104201056
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play1104201057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0.9

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_1 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(1104201056).content)

				arg_225_1.text_.text = var_228_1

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_3 = 36 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_1) / 36)

				if (36 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_1) / 36)) > 0 and var_228_0 < var_228_3 then
					arg_225_1.talkMaxDuration = var_228_3

					if var_228_3 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_3 + 0
					end
				end

				arg_225_1.text_.text = var_228_1
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_4 = math.max(var_228_0, arg_225_1.talkMaxDuration)

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_4 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - 0) / var_228_4

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= 0 + var_228_4 and arg_225_1.time_ < 0 + var_228_4 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play1104201057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1104201057
		arg_229_1.duration_ = 5.6

		local var_229_0 = {
			ja = 5.6,
			ko = 2.966,
			zh = 2.966
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
				arg_229_0:Play1104201058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["1042ui_story"]) and arg_229_1.var_.characterEffect1042ui_story == nil then
				arg_229_1.var_.characterEffect1042ui_story = arg_229_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_0 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["1042ui_story"]) then
				if arg_229_1.var_.characterEffect1042ui_story and not isNil(arg_229_1.actors_["1042ui_story"]) then
					arg_229_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["1042ui_story"]) and arg_229_1.var_.characterEffect1042ui_story then
				arg_229_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_232_2 = 0
			local var_232_3 = 0.225

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_2 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_4 = arg_229_1:GetWordFromCfg(1104201057)
				local var_232_5 = arg_229_1:FormatText(var_232_4.content)

				arg_229_1.text_.text = var_232_5

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_7 = 9 <= 0 and var_232_3 or var_232_3 * (utf8.len(var_232_5) / 9)

				if (9 <= 0 and var_232_3 or var_232_3 * (utf8.len(var_232_5) / 9)) > 0 and var_232_3 < var_232_7 then
					arg_229_1.talkMaxDuration = var_232_7

					if var_232_7 + var_232_2 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_7 + var_232_2
					end
				end

				arg_229_1.text_.text = var_232_5
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201057", "story_v_side_new_1104201.awb") ~= 0 then
					local var_232_8 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201057", "story_v_side_new_1104201.awb") / 1000

					if var_232_8 + var_232_2 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_8 + var_232_2
					end

					if var_232_4.prefab_name ~= "" and arg_229_1.actors_[var_232_4.prefab_name] ~= nil then
						local var_232_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_4.prefab_name].transform, "story_v_side_new_1104201", "1104201057", "story_v_side_new_1104201.awb")

						arg_229_1:RecordAudio("1104201057", var_232_9)
						arg_229_1:RecordAudio("1104201057", var_232_9)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201057", "story_v_side_new_1104201.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201057", "story_v_side_new_1104201.awb")
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
	Play1104201058 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1104201058
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play1104201059(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(arg_233_1.actors_["1042ui_story"]) and arg_233_1.var_.characterEffect1042ui_story == nil then
				arg_233_1.var_.characterEffect1042ui_story = arg_233_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_0 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 and not isNil(arg_233_1.actors_["1042ui_story"]) then
				if arg_233_1.var_.characterEffect1042ui_story and not isNil(arg_233_1.actors_["1042ui_story"]) then
					arg_233_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_0)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 and not isNil(arg_233_1.actors_["1042ui_story"]) and arg_233_1.var_.characterEffect1042ui_story then
				arg_233_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_236_1 = 0
			local var_236_2 = 0.425

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

				local var_236_3 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(1104201058).content)

				arg_233_1.text_.text = var_236_3

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_5 = 17 <= 0 and var_236_2 or var_236_2 * (utf8.len(var_236_3) / 17)

				if (17 <= 0 and var_236_2 or var_236_2 * (utf8.len(var_236_3) / 17)) > 0 and var_236_2 < var_236_5 then
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
	Play1104201059 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1104201059
		arg_237_1.duration_ = 8.43

		local var_237_0 = {
			ja = 8.433,
			ko = 4.9,
			zh = 4.9
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play1104201060(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(arg_237_1.actors_["1042ui_story"]) and arg_237_1.var_.characterEffect1042ui_story == nil then
				arg_237_1.var_.characterEffect1042ui_story = arg_237_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_0 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 and not isNil(arg_237_1.actors_["1042ui_story"]) then
				if arg_237_1.var_.characterEffect1042ui_story and not isNil(arg_237_1.actors_["1042ui_story"]) then
					arg_237_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 and not isNil(arg_237_1.actors_["1042ui_story"]) and arg_237_1.var_.characterEffect1042ui_story then
				arg_237_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_240_2 = 0
			local var_240_3 = 0.4

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_2 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_4 = arg_237_1:GetWordFromCfg(1104201059)
				local var_240_5 = arg_237_1:FormatText(var_240_4.content)

				arg_237_1.text_.text = var_240_5

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_7 = 16 <= 0 and var_240_3 or var_240_3 * (utf8.len(var_240_5) / 16)

				if (16 <= 0 and var_240_3 or var_240_3 * (utf8.len(var_240_5) / 16)) > 0 and var_240_3 < var_240_7 then
					arg_237_1.talkMaxDuration = var_240_7

					if var_240_7 + var_240_2 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_7 + var_240_2
					end
				end

				arg_237_1.text_.text = var_240_5
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201059", "story_v_side_new_1104201.awb") ~= 0 then
					local var_240_8 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201059", "story_v_side_new_1104201.awb") / 1000

					if var_240_8 + var_240_2 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_8 + var_240_2
					end

					if var_240_4.prefab_name ~= "" and arg_237_1.actors_[var_240_4.prefab_name] ~= nil then
						local var_240_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_4.prefab_name].transform, "story_v_side_new_1104201", "1104201059", "story_v_side_new_1104201.awb")

						arg_237_1:RecordAudio("1104201059", var_240_9)
						arg_237_1:RecordAudio("1104201059", var_240_9)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201059", "story_v_side_new_1104201.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201059", "story_v_side_new_1104201.awb")
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
	Play1104201060 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 1104201060
		arg_241_1.duration_ = 4.87

		local var_241_0 = {
			ja = 3.233,
			ko = 4.866,
			zh = 4.866
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
				arg_241_0:Play1104201061(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1042ui_story = arg_241_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_244_0 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 then
				arg_241_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_241_1.time_ - 0) / var_244_0)
				arg_241_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1042ui_story"].transform.position).z)
				arg_241_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1042ui_story"].transform.localEulerAngles = arg_241_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 then
				arg_241_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_241_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1042ui_story"].transform.position).z)
				arg_241_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1042ui_story"].transform.localEulerAngles = arg_241_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_244_1 = arg_241_1.actors_["1042ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect1042ui_story == nil then
				arg_241_1.var_.characterEffect1042ui_story = var_244_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_2 and not isNil(var_244_1) then
				if arg_241_1.var_.characterEffect1042ui_story and not isNil(var_244_1) then
					arg_241_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_241_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_241_1.time_ - 0) / var_244_2)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_2 and arg_241_1.time_ < 0 + var_244_2 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect1042ui_story then
				arg_241_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_241_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_244_3 = arg_241_1.actors_["6045_story"].transform

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos6045_story = var_244_3.localPosition

				local var_244_4 = GameObjectTools.GetOrAddComponent(var_244_3.gameObject, typeof(DynamicBoneHelper))

				if var_244_4 then
					var_244_4:EnableDynamicBone(false)
				end
			end

			local var_244_5 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_5 then
				var_244_3.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos6045_story, Vector3.New(-0.7, -0.5, -6.3), (arg_241_1.time_ - 0) / var_244_5)
				var_244_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_244_3.position).x, (manager.ui.mainCamera.transform.position - var_244_3.position).y, (manager.ui.mainCamera.transform.position - var_244_3.position).z)
				var_244_3.localEulerAngles.z = 0
				var_244_3.localEulerAngles.x = 0
				var_244_3.localEulerAngles = var_244_3.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_5 and arg_241_1.time_ < 0 + var_244_5 + arg_244_0 then
				var_244_3.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				var_244_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_244_3.position).x, (manager.ui.mainCamera.transform.position - var_244_3.position).y, (manager.ui.mainCamera.transform.position - var_244_3.position).z)
				var_244_3.localEulerAngles.z = 0
				var_244_3.localEulerAngles.x = 0
				var_244_3.localEulerAngles = var_244_3.localEulerAngles

				local var_244_6 = GameObjectTools.GetOrAddComponent(var_244_3.gameObject, typeof(DynamicBoneHelper))

				if var_244_6 then
					var_244_6:EnableDynamicBone(true)
				end
			end

			local var_244_7 = arg_241_1.actors_["6045_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_7) and arg_241_1.var_.characterEffect6045_story == nil then
				arg_241_1.var_.characterEffect6045_story = var_244_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_8 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_8 and not isNil(var_244_7) then
				if arg_241_1.var_.characterEffect6045_story and not isNil(var_244_7) then
					arg_241_1.var_.characterEffect6045_story.fillFlat = true
					arg_241_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_241_1.time_ - 0) / var_244_8)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_8 and arg_241_1.time_ < 0 + var_244_8 + arg_244_0 and not isNil(var_244_7) and arg_241_1.var_.characterEffect6045_story then
				arg_241_1.var_.characterEffect6045_story.fillFlat = true
				arg_241_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_244_9 = arg_241_1.actors_["6046_story"].transform

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos6046_story = var_244_9.localPosition

				local var_244_10 = GameObjectTools.GetOrAddComponent(var_244_9.gameObject, typeof(DynamicBoneHelper))

				if var_244_10 then
					var_244_10:EnableDynamicBone(false)
				end
			end

			local var_244_11 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_11 then
				var_244_9.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos6046_story, Vector3.New(0.7, -0.5, -6.3), (arg_241_1.time_ - 0) / var_244_11)
				var_244_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_244_9.position).x, (manager.ui.mainCamera.transform.position - var_244_9.position).y, (manager.ui.mainCamera.transform.position - var_244_9.position).z)
				var_244_9.localEulerAngles.z = 0
				var_244_9.localEulerAngles.x = 0
				var_244_9.localEulerAngles = var_244_9.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_11 and arg_241_1.time_ < 0 + var_244_11 + arg_244_0 then
				var_244_9.localPosition = Vector3.New(0.7, -0.5, -6.3)
				var_244_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_244_9.position).x, (manager.ui.mainCamera.transform.position - var_244_9.position).y, (manager.ui.mainCamera.transform.position - var_244_9.position).z)
				var_244_9.localEulerAngles.z = 0
				var_244_9.localEulerAngles.x = 0
				var_244_9.localEulerAngles = var_244_9.localEulerAngles

				local var_244_12 = GameObjectTools.GetOrAddComponent(var_244_9.gameObject, typeof(DynamicBoneHelper))

				if var_244_12 then
					var_244_12:EnableDynamicBone(true)
				end
			end

			local var_244_13 = arg_241_1.actors_["6046_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_13) and arg_241_1.var_.characterEffect6046_story == nil then
				arg_241_1.var_.characterEffect6046_story = var_244_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_14 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_14 and not isNil(var_244_13) then
				if arg_241_1.var_.characterEffect6046_story and not isNil(var_244_13) then
					arg_241_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_14 and arg_241_1.time_ < 0 + var_244_14 + arg_244_0 and not isNil(var_244_13) and arg_241_1.var_.characterEffect6046_story then
				arg_241_1.var_.characterEffect6046_story.fillFlat = false
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_244_16 = 0
			local var_244_17 = 0.475

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_16 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_18 = arg_241_1:GetWordFromCfg(1104201060)
				local var_244_19 = arg_241_1:FormatText(var_244_18.content)

				arg_241_1.text_.text = var_244_19

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_21 = 19 <= 0 and var_244_17 or var_244_17 * (utf8.len(var_244_19) / 19)

				if (19 <= 0 and var_244_17 or var_244_17 * (utf8.len(var_244_19) / 19)) > 0 and var_244_17 < var_244_21 then
					arg_241_1.talkMaxDuration = var_244_21

					if var_244_21 + var_244_16 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_21 + var_244_16
					end
				end

				arg_241_1.text_.text = var_244_19
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201060", "story_v_side_new_1104201.awb") ~= 0 then
					local var_244_22 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201060", "story_v_side_new_1104201.awb") / 1000

					if var_244_22 + var_244_16 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_22 + var_244_16
					end

					if var_244_18.prefab_name ~= "" and arg_241_1.actors_[var_244_18.prefab_name] ~= nil then
						local var_244_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_18.prefab_name].transform, "story_v_side_new_1104201", "1104201060", "story_v_side_new_1104201.awb")

						arg_241_1:RecordAudio("1104201060", var_244_23)
						arg_241_1:RecordAudio("1104201060", var_244_23)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201060", "story_v_side_new_1104201.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201060", "story_v_side_new_1104201.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_24 = math.max(var_244_17, arg_241_1.talkMaxDuration)

			if var_244_16 <= arg_241_1.time_ and arg_241_1.time_ < var_244_16 + var_244_24 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_16) / var_244_24

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_16 + var_244_24 and arg_241_1.time_ < var_244_16 + var_244_24 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
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
	Play1104201061 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 1104201061
		arg_245_1.duration_ = 8

		local var_245_0 = {
			ja = 3.2,
			ko = 8,
			zh = 8
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
				arg_245_0:Play1104201062(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["6045_story"]) and arg_245_1.var_.characterEffect6045_story == nil then
				arg_245_1.var_.characterEffect6045_story = arg_245_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_0 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["6045_story"]) then
				if arg_245_1.var_.characterEffect6045_story and not isNil(arg_245_1.actors_["6045_story"]) then
					arg_245_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["6045_story"]) and arg_245_1.var_.characterEffect6045_story then
				arg_245_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_248_2 = arg_245_1.actors_["6046_story"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_2) and arg_245_1.var_.characterEffect6046_story == nil then
				arg_245_1.var_.characterEffect6046_story = var_248_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_3 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_3 and not isNil(var_248_2) then
				if arg_245_1.var_.characterEffect6046_story and not isNil(var_248_2) then
					arg_245_1.var_.characterEffect6046_story.fillFlat = true
					arg_245_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_245_1.time_ - 0) / var_248_3)
				end
			end

			if arg_245_1.time_ >= 0 + var_248_3 and arg_245_1.time_ < 0 + var_248_3 + arg_248_0 and not isNil(var_248_2) and arg_245_1.var_.characterEffect6046_story then
				arg_245_1.var_.characterEffect6046_story.fillFlat = true
				arg_245_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_248_4 = 0
			local var_248_5 = 0.675

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_4 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_6 = arg_245_1:GetWordFromCfg(1104201061)
				local var_248_7 = arg_245_1:FormatText(var_248_6.content)

				arg_245_1.text_.text = var_248_7

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_9 = 27 <= 0 and var_248_5 or var_248_5 * (utf8.len(var_248_7) / 27)

				if (27 <= 0 and var_248_5 or var_248_5 * (utf8.len(var_248_7) / 27)) > 0 and var_248_5 < var_248_9 then
					arg_245_1.talkMaxDuration = var_248_9

					if var_248_9 + var_248_4 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_9 + var_248_4
					end
				end

				arg_245_1.text_.text = var_248_7
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201061", "story_v_side_new_1104201.awb") ~= 0 then
					local var_248_10 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201061", "story_v_side_new_1104201.awb") / 1000

					if var_248_10 + var_248_4 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_10 + var_248_4
					end

					if var_248_6.prefab_name ~= "" and arg_245_1.actors_[var_248_6.prefab_name] ~= nil then
						local var_248_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_6.prefab_name].transform, "story_v_side_new_1104201", "1104201061", "story_v_side_new_1104201.awb")

						arg_245_1:RecordAudio("1104201061", var_248_11)
						arg_245_1:RecordAudio("1104201061", var_248_11)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201061", "story_v_side_new_1104201.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201061", "story_v_side_new_1104201.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_12 = math.max(var_248_5, arg_245_1.talkMaxDuration)

			if var_248_4 <= arg_245_1.time_ and arg_245_1.time_ < var_248_4 + var_248_12 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_4) / var_248_12

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_4 + var_248_12 and arg_245_1.time_ < var_248_4 + var_248_12 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play1104201062 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 1104201062
		arg_249_1.duration_ = 4.27

		local var_249_0 = {
			ja = 3.766,
			ko = 4.266,
			zh = 4.266
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
				arg_249_0:Play1104201063(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["6046_story"]) and arg_249_1.var_.characterEffect6046_story == nil then
				arg_249_1.var_.characterEffect6046_story = arg_249_1.actors_["6046_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_0 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["6046_story"]) then
				if arg_249_1.var_.characterEffect6046_story and not isNil(arg_249_1.actors_["6046_story"]) then
					arg_249_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["6046_story"]) and arg_249_1.var_.characterEffect6046_story then
				arg_249_1.var_.characterEffect6046_story.fillFlat = false
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_252_2 = arg_249_1.actors_["6045_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_2) and arg_249_1.var_.characterEffect6045_story == nil then
				arg_249_1.var_.characterEffect6045_story = var_252_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_3 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_3 and not isNil(var_252_2) then
				if arg_249_1.var_.characterEffect6045_story and not isNil(var_252_2) then
					arg_249_1.var_.characterEffect6045_story.fillFlat = true
					arg_249_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_249_1.time_ - 0) / var_252_3)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_3 and arg_249_1.time_ < 0 + var_252_3 + arg_252_0 and not isNil(var_252_2) and arg_249_1.var_.characterEffect6045_story then
				arg_249_1.var_.characterEffect6045_story.fillFlat = true
				arg_249_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_252_4 = 0
			local var_252_5 = 0.425

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_4 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_6 = arg_249_1:GetWordFromCfg(1104201062)
				local var_252_7 = arg_249_1:FormatText(var_252_6.content)

				arg_249_1.text_.text = var_252_7

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_9 = 17 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 17)

				if (17 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 17)) > 0 and var_252_5 < var_252_9 then
					arg_249_1.talkMaxDuration = var_252_9

					if var_252_9 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_9 + var_252_4
					end
				end

				arg_249_1.text_.text = var_252_7
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201062", "story_v_side_new_1104201.awb") ~= 0 then
					local var_252_10 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201062", "story_v_side_new_1104201.awb") / 1000

					if var_252_10 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_10 + var_252_4
					end

					if var_252_6.prefab_name ~= "" and arg_249_1.actors_[var_252_6.prefab_name] ~= nil then
						local var_252_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_6.prefab_name].transform, "story_v_side_new_1104201", "1104201062", "story_v_side_new_1104201.awb")

						arg_249_1:RecordAudio("1104201062", var_252_11)
						arg_249_1:RecordAudio("1104201062", var_252_11)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201062", "story_v_side_new_1104201.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201062", "story_v_side_new_1104201.awb")
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

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play1104201063 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 1104201063
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play1104201064(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(arg_253_1.actors_["6046_story"]) and arg_253_1.var_.characterEffect6046_story == nil then
				arg_253_1.var_.characterEffect6046_story = arg_253_1.actors_["6046_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_0 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 and not isNil(arg_253_1.actors_["6046_story"]) then
				if arg_253_1.var_.characterEffect6046_story and not isNil(arg_253_1.actors_["6046_story"]) then
					arg_253_1.var_.characterEffect6046_story.fillFlat = true
					arg_253_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_0)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 and not isNil(arg_253_1.actors_["6046_story"]) and arg_253_1.var_.characterEffect6046_story then
				arg_253_1.var_.characterEffect6046_story.fillFlat = true
				arg_253_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_256_1 = 0
			local var_256_2 = 0.675

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_3 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(1104201063).content)

				arg_253_1.text_.text = var_256_3

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_5 = 27 <= 0 and var_256_2 or var_256_2 * (utf8.len(var_256_3) / 27)

				if (27 <= 0 and var_256_2 or var_256_2 * (utf8.len(var_256_3) / 27)) > 0 and var_256_2 < var_256_5 then
					arg_253_1.talkMaxDuration = var_256_5

					if var_256_5 + var_256_1 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_5 + var_256_1
					end
				end

				arg_253_1.text_.text = var_256_3
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_6 = math.max(var_256_2, arg_253_1.talkMaxDuration)

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_6 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_1) / var_256_6

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_1 + var_256_6 and arg_253_1.time_ < var_256_1 + var_256_6 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play1104201064 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 1104201064
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play1104201065(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0.475

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

				local var_260_1 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(1104201064).content)

				arg_257_1.text_.text = var_260_1

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_3 = 19 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 19)

				if (19 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 19)) > 0 and var_260_0 < var_260_3 then
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
	Play1104201065 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 1104201065
		arg_261_1.duration_ = 2.77

		local var_261_0 = {
			ja = 1.999999999999,
			ko = 2.766,
			zh = 2.766
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play1104201066(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(arg_261_1.actors_["6046_story"]) and arg_261_1.var_.characterEffect6046_story == nil then
				arg_261_1.var_.characterEffect6046_story = arg_261_1.actors_["6046_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_0 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 and not isNil(arg_261_1.actors_["6046_story"]) then
				if arg_261_1.var_.characterEffect6046_story and not isNil(arg_261_1.actors_["6046_story"]) then
					arg_261_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 and not isNil(arg_261_1.actors_["6046_story"]) and arg_261_1.var_.characterEffect6046_story then
				arg_261_1.var_.characterEffect6046_story.fillFlat = false
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action5_1")
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_264_2 = 0
			local var_264_3 = 0.15

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_2 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_4 = arg_261_1:GetWordFromCfg(1104201065)
				local var_264_5 = arg_261_1:FormatText(var_264_4.content)

				arg_261_1.text_.text = var_264_5

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_7 = 6 <= 0 and var_264_3 or var_264_3 * (utf8.len(var_264_5) / 6)

				if (6 <= 0 and var_264_3 or var_264_3 * (utf8.len(var_264_5) / 6)) > 0 and var_264_3 < var_264_7 then
					arg_261_1.talkMaxDuration = var_264_7

					if var_264_7 + var_264_2 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_7 + var_264_2
					end
				end

				arg_261_1.text_.text = var_264_5
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201065", "story_v_side_new_1104201.awb") ~= 0 then
					local var_264_8 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201065", "story_v_side_new_1104201.awb") / 1000

					if var_264_8 + var_264_2 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_8 + var_264_2
					end

					if var_264_4.prefab_name ~= "" and arg_261_1.actors_[var_264_4.prefab_name] ~= nil then
						local var_264_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_4.prefab_name].transform, "story_v_side_new_1104201", "1104201065", "story_v_side_new_1104201.awb")

						arg_261_1:RecordAudio("1104201065", var_264_9)
						arg_261_1:RecordAudio("1104201065", var_264_9)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201065", "story_v_side_new_1104201.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201065", "story_v_side_new_1104201.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_10 = math.max(var_264_3, arg_261_1.talkMaxDuration)

			if var_264_2 <= arg_261_1.time_ and arg_261_1.time_ < var_264_2 + var_264_10 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_2) / var_264_10

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_2 + var_264_10 and arg_261_1.time_ < var_264_2 + var_264_10 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play1104201066 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 1104201066
		arg_265_1.duration_ = 15.07

		local var_265_0 = {
			ja = 15.066,
			ko = 13.866,
			zh = 13.866
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play1104201067(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(arg_265_1.actors_["6045_story"]) and arg_265_1.var_.characterEffect6045_story == nil then
				arg_265_1.var_.characterEffect6045_story = arg_265_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_0 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 and not isNil(arg_265_1.actors_["6045_story"]) then
				if arg_265_1.var_.characterEffect6045_story and not isNil(arg_265_1.actors_["6045_story"]) then
					arg_265_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 and not isNil(arg_265_1.actors_["6045_story"]) and arg_265_1.var_.characterEffect6045_story then
				arg_265_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_268_2 = arg_265_1.actors_["6046_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.characterEffect6046_story == nil then
				arg_265_1.var_.characterEffect6046_story = var_268_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_3 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_3 and not isNil(var_268_2) then
				if arg_265_1.var_.characterEffect6046_story and not isNil(var_268_2) then
					arg_265_1.var_.characterEffect6046_story.fillFlat = true
					arg_265_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_265_1.time_ - 0) / var_268_3)
				end
			end

			if arg_265_1.time_ >= 0 + var_268_3 and arg_265_1.time_ < 0 + var_268_3 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.characterEffect6046_story then
				arg_265_1.var_.characterEffect6046_story.fillFlat = true
				arg_265_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_268_4 = 0
			local var_268_5 = 1.175

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_4 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_6 = arg_265_1:GetWordFromCfg(1104201066)
				local var_268_7 = arg_265_1:FormatText(var_268_6.content)

				arg_265_1.text_.text = var_268_7

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_9 = 47 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_7) / 47)

				if (47 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_7) / 47)) > 0 and var_268_5 < var_268_9 then
					arg_265_1.talkMaxDuration = var_268_9

					if var_268_9 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_9 + var_268_4
					end
				end

				arg_265_1.text_.text = var_268_7
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201066", "story_v_side_new_1104201.awb") ~= 0 then
					local var_268_10 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201066", "story_v_side_new_1104201.awb") / 1000

					if var_268_10 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_10 + var_268_4
					end

					if var_268_6.prefab_name ~= "" and arg_265_1.actors_[var_268_6.prefab_name] ~= nil then
						local var_268_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_6.prefab_name].transform, "story_v_side_new_1104201", "1104201066", "story_v_side_new_1104201.awb")

						arg_265_1:RecordAudio("1104201066", var_268_11)
						arg_265_1:RecordAudio("1104201066", var_268_11)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201066", "story_v_side_new_1104201.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201066", "story_v_side_new_1104201.awb")
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

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play1104201067 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 1104201067
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play1104201068(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(arg_269_1.actors_["6045_story"]) and arg_269_1.var_.characterEffect6045_story == nil then
				arg_269_1.var_.characterEffect6045_story = arg_269_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_0 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 and not isNil(arg_269_1.actors_["6045_story"]) then
				if arg_269_1.var_.characterEffect6045_story and not isNil(arg_269_1.actors_["6045_story"]) then
					arg_269_1.var_.characterEffect6045_story.fillFlat = true
					arg_269_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_269_1.time_ - 0) / var_272_0)
				end
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 and not isNil(arg_269_1.actors_["6045_story"]) and arg_269_1.var_.characterEffect6045_story then
				arg_269_1.var_.characterEffect6045_story.fillFlat = true
				arg_269_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_272_1 = 0
			local var_272_2 = 0.525

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

				local var_272_3 = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(1104201067).content)

				arg_269_1.text_.text = var_272_3

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_5 = 21 <= 0 and var_272_2 or var_272_2 * (utf8.len(var_272_3) / 21)

				if (21 <= 0 and var_272_2 or var_272_2 * (utf8.len(var_272_3) / 21)) > 0 and var_272_2 < var_272_5 then
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
	Play1104201068 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 1104201068
		arg_273_1.duration_ = 3.5

		local var_273_0 = {
			ja = 3.5,
			ko = 2.1,
			zh = 2.1
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play1104201069(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(arg_273_1.actors_["6046_story"]) and arg_273_1.var_.characterEffect6046_story == nil then
				arg_273_1.var_.characterEffect6046_story = arg_273_1.actors_["6046_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_0 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 and not isNil(arg_273_1.actors_["6046_story"]) then
				if arg_273_1.var_.characterEffect6046_story and not isNil(arg_273_1.actors_["6046_story"]) then
					arg_273_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 and not isNil(arg_273_1.actors_["6046_story"]) and arg_273_1.var_.characterEffect6046_story then
				arg_273_1.var_.characterEffect6046_story.fillFlat = false
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_276_2 = 0
			local var_276_3 = 0.2

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_2 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_4 = arg_273_1:GetWordFromCfg(1104201068)
				local var_276_5 = arg_273_1:FormatText(var_276_4.content)

				arg_273_1.text_.text = var_276_5

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_7 = 8 <= 0 and var_276_3 or var_276_3 * (utf8.len(var_276_5) / 8)

				if (8 <= 0 and var_276_3 or var_276_3 * (utf8.len(var_276_5) / 8)) > 0 and var_276_3 < var_276_7 then
					arg_273_1.talkMaxDuration = var_276_7

					if var_276_7 + var_276_2 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_7 + var_276_2
					end
				end

				arg_273_1.text_.text = var_276_5
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201068", "story_v_side_new_1104201.awb") ~= 0 then
					local var_276_8 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201068", "story_v_side_new_1104201.awb") / 1000

					if var_276_8 + var_276_2 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_8 + var_276_2
					end

					if var_276_4.prefab_name ~= "" and arg_273_1.actors_[var_276_4.prefab_name] ~= nil then
						local var_276_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_4.prefab_name].transform, "story_v_side_new_1104201", "1104201068", "story_v_side_new_1104201.awb")

						arg_273_1:RecordAudio("1104201068", var_276_9)
						arg_273_1:RecordAudio("1104201068", var_276_9)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201068", "story_v_side_new_1104201.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201068", "story_v_side_new_1104201.awb")
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
	Play1104201069 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 1104201069
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play1104201070(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(arg_277_1.actors_["6046_story"]) and arg_277_1.var_.characterEffect6046_story == nil then
				arg_277_1.var_.characterEffect6046_story = arg_277_1.actors_["6046_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_0 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 and not isNil(arg_277_1.actors_["6046_story"]) then
				if arg_277_1.var_.characterEffect6046_story and not isNil(arg_277_1.actors_["6046_story"]) then
					arg_277_1.var_.characterEffect6046_story.fillFlat = true
					arg_277_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_277_1.time_ - 0) / var_280_0)
				end
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 and not isNil(arg_277_1.actors_["6046_story"]) and arg_277_1.var_.characterEffect6046_story then
				arg_277_1.var_.characterEffect6046_story.fillFlat = true
				arg_277_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_280_1 = 0
			local var_280_2 = 0.4

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_3 = arg_277_1:FormatText(arg_277_1:GetWordFromCfg(1104201069).content)

				arg_277_1.text_.text = var_280_3

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_5 = 16 <= 0 and var_280_2 or var_280_2 * (utf8.len(var_280_3) / 16)

				if (16 <= 0 and var_280_2 or var_280_2 * (utf8.len(var_280_3) / 16)) > 0 and var_280_2 < var_280_5 then
					arg_277_1.talkMaxDuration = var_280_5

					if var_280_5 + var_280_1 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_5 + var_280_1
					end
				end

				arg_277_1.text_.text = var_280_3
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_6 = math.max(var_280_2, arg_277_1.talkMaxDuration)

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_6 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_1) / var_280_6

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_1 + var_280_6 and arg_277_1.time_ < var_280_1 + var_280_6 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play1104201070 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 1104201070
		arg_281_1.duration_ = 11.97

		local var_281_0 = {
			ja = 11.966,
			ko = 8.433,
			zh = 8.433
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
				arg_281_0:Play1104201071(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(arg_281_1.actors_["6045_story"]) and arg_281_1.var_.characterEffect6045_story == nil then
				arg_281_1.var_.characterEffect6045_story = arg_281_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_0 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 and not isNil(arg_281_1.actors_["6045_story"]) then
				if arg_281_1.var_.characterEffect6045_story and not isNil(arg_281_1.actors_["6045_story"]) then
					arg_281_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 and not isNil(arg_281_1.actors_["6045_story"]) and arg_281_1.var_.characterEffect6045_story then
				arg_281_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_284_2 = 0
			local var_284_3 = 0.75

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_2 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_4 = arg_281_1:GetWordFromCfg(1104201070)
				local var_284_5 = arg_281_1:FormatText(var_284_4.content)

				arg_281_1.text_.text = var_284_5

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_7 = 30 <= 0 and var_284_3 or var_284_3 * (utf8.len(var_284_5) / 30)

				if (30 <= 0 and var_284_3 or var_284_3 * (utf8.len(var_284_5) / 30)) > 0 and var_284_3 < var_284_7 then
					arg_281_1.talkMaxDuration = var_284_7

					if var_284_7 + var_284_2 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_7 + var_284_2
					end
				end

				arg_281_1.text_.text = var_284_5
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201070", "story_v_side_new_1104201.awb") ~= 0 then
					local var_284_8 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201070", "story_v_side_new_1104201.awb") / 1000

					if var_284_8 + var_284_2 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_8 + var_284_2
					end

					if var_284_4.prefab_name ~= "" and arg_281_1.actors_[var_284_4.prefab_name] ~= nil then
						local var_284_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_4.prefab_name].transform, "story_v_side_new_1104201", "1104201070", "story_v_side_new_1104201.awb")

						arg_281_1:RecordAudio("1104201070", var_284_9)
						arg_281_1:RecordAudio("1104201070", var_284_9)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201070", "story_v_side_new_1104201.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201070", "story_v_side_new_1104201.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_10 = math.max(var_284_3, arg_281_1.talkMaxDuration)

			if var_284_2 <= arg_281_1.time_ and arg_281_1.time_ < var_284_2 + var_284_10 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_2) / var_284_10

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_2 + var_284_10 and arg_281_1.time_ < var_284_2 + var_284_10 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play1104201071 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 1104201071
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play1104201072(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["6045_story"]) and arg_285_1.var_.characterEffect6045_story == nil then
				arg_285_1.var_.characterEffect6045_story = arg_285_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_0 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["6045_story"]) then
				if arg_285_1.var_.characterEffect6045_story and not isNil(arg_285_1.actors_["6045_story"]) then
					arg_285_1.var_.characterEffect6045_story.fillFlat = true
					arg_285_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_285_1.time_ - 0) / var_288_0)
				end
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["6045_story"]) and arg_285_1.var_.characterEffect6045_story then
				arg_285_1.var_.characterEffect6045_story.fillFlat = true
				arg_285_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_288_1 = 0
			local var_288_2 = 0.325

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

				local var_288_3 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(1104201071).content)

				arg_285_1.text_.text = var_288_3

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_5 = 13 <= 0 and var_288_2 or var_288_2 * (utf8.len(var_288_3) / 13)

				if (13 <= 0 and var_288_2 or var_288_2 * (utf8.len(var_288_3) / 13)) > 0 and var_288_2 < var_288_5 then
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
	Play1104201072 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 1104201072
		arg_289_1.duration_ = 4.23

		local var_289_0 = {
			ja = 3.133,
			ko = 4.233,
			zh = 4.233
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
				arg_289_0:Play1104201073(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(arg_289_1.actors_["6046_story"]) and arg_289_1.var_.characterEffect6046_story == nil then
				arg_289_1.var_.characterEffect6046_story = arg_289_1.actors_["6046_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_0 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 and not isNil(arg_289_1.actors_["6046_story"]) then
				if arg_289_1.var_.characterEffect6046_story and not isNil(arg_289_1.actors_["6046_story"]) then
					arg_289_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 and not isNil(arg_289_1.actors_["6046_story"]) and arg_289_1.var_.characterEffect6046_story then
				arg_289_1.var_.characterEffect6046_story.fillFlat = false
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_292_2 = 0
			local var_292_3 = 0.425

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_2 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_4 = arg_289_1:GetWordFromCfg(1104201072)
				local var_292_5 = arg_289_1:FormatText(var_292_4.content)

				arg_289_1.text_.text = var_292_5

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_7 = 17 <= 0 and var_292_3 or var_292_3 * (utf8.len(var_292_5) / 17)

				if (17 <= 0 and var_292_3 or var_292_3 * (utf8.len(var_292_5) / 17)) > 0 and var_292_3 < var_292_7 then
					arg_289_1.talkMaxDuration = var_292_7

					if var_292_7 + var_292_2 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_7 + var_292_2
					end
				end

				arg_289_1.text_.text = var_292_5
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201072", "story_v_side_new_1104201.awb") ~= 0 then
					local var_292_8 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201072", "story_v_side_new_1104201.awb") / 1000

					if var_292_8 + var_292_2 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_8 + var_292_2
					end

					if var_292_4.prefab_name ~= "" and arg_289_1.actors_[var_292_4.prefab_name] ~= nil then
						local var_292_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_4.prefab_name].transform, "story_v_side_new_1104201", "1104201072", "story_v_side_new_1104201.awb")

						arg_289_1:RecordAudio("1104201072", var_292_9)
						arg_289_1:RecordAudio("1104201072", var_292_9)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201072", "story_v_side_new_1104201.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201072", "story_v_side_new_1104201.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_10 = math.max(var_292_3, arg_289_1.talkMaxDuration)

			if var_292_2 <= arg_289_1.time_ and arg_289_1.time_ < var_292_2 + var_292_10 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_2) / var_292_10

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_2 + var_292_10 and arg_289_1.time_ < var_292_2 + var_292_10 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play1104201073 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 1104201073
		arg_293_1.duration_ = 9

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play1104201074(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if arg_293_1.bgs_.ST22 == nil then
				local var_296_0 = Object.Instantiate(arg_293_1.paintGo_)

				var_296_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST22")
				var_296_0.name = "ST22"
				var_296_0.transform.parent = arg_293_1.stage_.transform
				var_296_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_293_1.bgs_.ST22 = var_296_0
			end

			if 1.999999999999 < arg_293_1.time_ and arg_293_1.time_ <= 1.999999999999 + arg_296_0 then
				local var_296_1 = arg_293_1.bgs_.ST22

				arg_293_1.bgs_.ST22.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_296_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_296_2 = var_296_1:GetComponent("SpriteRenderer")

				if var_296_2 and var_296_2.sprite then
					local var_296_3 = 2 * (var_296_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_296_1.transform.localScale = Vector3.New(var_296_3 / var_296_2.sprite.bounds.size.y < var_296_3 * manager.ui.mainCameraCom_.aspect / var_296_2.sprite.bounds.size.x and var_296_3 * manager.ui.mainCameraCom_.aspect / var_296_2.sprite.bounds.size.x or var_296_3 / var_296_2.sprite.bounds.size.y, var_296_3 / var_296_2.sprite.bounds.size.y < var_296_3 * manager.ui.mainCameraCom_.aspect / var_296_2.sprite.bounds.size.x and var_296_3 * manager.ui.mainCameraCom_.aspect / var_296_2.sprite.bounds.size.x or var_296_3 / var_296_2.sprite.bounds.size.y, 0)
				end

				for iter_296_0, iter_296_1 in pairs(arg_293_1.bgs_) do
					if iter_296_0 ~= "ST22" then
						iter_296_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_296_4 = 0

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_4 + arg_296_0 then
				arg_293_1.mask_.enabled = true
				arg_293_1.mask_.raycastTarget = true

				arg_293_1:SetGaussion(false)
			end

			local var_296_5 = 2

			if var_296_4 <= arg_293_1.time_ and arg_293_1.time_ < var_296_4 + var_296_5 then
				local var_296_6 = Color.New(0, 0, 0)

				var_296_6.a = Mathf.Lerp(0, 1, (arg_293_1.time_ - var_296_4) / var_296_5)
				arg_293_1.mask_.color = var_296_6
			end

			if arg_293_1.time_ >= var_296_4 + var_296_5 and arg_293_1.time_ < var_296_4 + var_296_5 + arg_296_0 then
				local var_296_7 = Color.New(0, 0, 0)

				var_296_7.a = 1
				arg_293_1.mask_.color = var_296_7
			end

			local var_296_8 = 2

			if 2 < arg_293_1.time_ and arg_293_1.time_ <= var_296_8 + arg_296_0 then
				arg_293_1.mask_.enabled = true
				arg_293_1.mask_.raycastTarget = true

				arg_293_1:SetGaussion(false)
			end

			local var_296_9 = 2

			if var_296_8 <= arg_293_1.time_ and arg_293_1.time_ < var_296_8 + var_296_9 then
				local var_296_10 = Color.New(0, 0, 0)

				var_296_10.a = Mathf.Lerp(1, 0, (arg_293_1.time_ - var_296_8) / var_296_9)
				arg_293_1.mask_.color = var_296_10
			end

			if arg_293_1.time_ >= var_296_8 + var_296_9 and arg_293_1.time_ < var_296_8 + var_296_9 + arg_296_0 then
				local var_296_11 = Color.New(0, 0, 0)

				arg_293_1.mask_.enabled = false
				var_296_11.a = 0
				arg_293_1.mask_.color = var_296_11
			end

			local var_296_12 = arg_293_1.actors_["6046_story"].transform

			if 1.96599999815226 < arg_293_1.time_ and arg_293_1.time_ <= 1.96599999815226 + arg_296_0 then
				arg_293_1.var_.moveOldPos6046_story = var_296_12.localPosition

				local var_296_13 = GameObjectTools.GetOrAddComponent(var_296_12.gameObject, typeof(DynamicBoneHelper))

				if var_296_13 then
					var_296_13:EnableDynamicBone(false)
				end
			end

			local var_296_14 = 0.001

			if 1.96599999815226 <= arg_293_1.time_ and arg_293_1.time_ < 1.96599999815226 + var_296_14 then
				var_296_12.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (arg_293_1.time_ - 1.96599999815226) / var_296_14)
				var_296_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_296_12.position).x, (manager.ui.mainCamera.transform.position - var_296_12.position).y, (manager.ui.mainCamera.transform.position - var_296_12.position).z)
				var_296_12.localEulerAngles.z = 0
				var_296_12.localEulerAngles.x = 0
				var_296_12.localEulerAngles = var_296_12.localEulerAngles
			end

			if arg_293_1.time_ >= 1.96599999815226 + var_296_14 and arg_293_1.time_ < 1.96599999815226 + var_296_14 + arg_296_0 then
				var_296_12.localPosition = Vector3.New(0, 100, 0)
				var_296_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_296_12.position).x, (manager.ui.mainCamera.transform.position - var_296_12.position).y, (manager.ui.mainCamera.transform.position - var_296_12.position).z)
				var_296_12.localEulerAngles.z = 0
				var_296_12.localEulerAngles.x = 0
				var_296_12.localEulerAngles = var_296_12.localEulerAngles

				local var_296_15 = GameObjectTools.GetOrAddComponent(var_296_12.gameObject, typeof(DynamicBoneHelper))

				if var_296_15 then
					var_296_15:EnableDynamicBone(true)
				end
			end

			local var_296_16 = arg_293_1.actors_["6046_story"]

			if 1.96599999815226 < arg_293_1.time_ and arg_293_1.time_ <= 1.96599999815226 + arg_296_0 and not isNil(var_296_16) and arg_293_1.var_.characterEffect6046_story == nil then
				arg_293_1.var_.characterEffect6046_story = var_296_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_17 = 0.034000001847744

			if 1.96599999815226 <= arg_293_1.time_ and arg_293_1.time_ < 1.96599999815226 + var_296_17 and not isNil(var_296_16) then
				if arg_293_1.var_.characterEffect6046_story and not isNil(var_296_16) then
					arg_293_1.var_.characterEffect6046_story.fillFlat = true
					arg_293_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_293_1.time_ - 1.96599999815226) / var_296_17)
				end
			end

			if arg_293_1.time_ >= 1.96599999815226 + var_296_17 and arg_293_1.time_ < 1.96599999815226 + var_296_17 + arg_296_0 and not isNil(var_296_16) and arg_293_1.var_.characterEffect6046_story then
				arg_293_1.var_.characterEffect6046_story.fillFlat = true
				arg_293_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_296_18 = arg_293_1.actors_["6045_story"].transform

			if 1.96599999815226 < arg_293_1.time_ and arg_293_1.time_ <= 1.96599999815226 + arg_296_0 then
				arg_293_1.var_.moveOldPos6045_story = var_296_18.localPosition

				local var_296_19 = GameObjectTools.GetOrAddComponent(var_296_18.gameObject, typeof(DynamicBoneHelper))

				if var_296_19 then
					var_296_19:EnableDynamicBone(false)
				end
			end

			local var_296_20 = 0.001

			if 1.96599999815226 <= arg_293_1.time_ and arg_293_1.time_ < 1.96599999815226 + var_296_20 then
				var_296_18.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos6045_story, Vector3.New(0, 100, 0), (arg_293_1.time_ - 1.96599999815226) / var_296_20)
				var_296_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_296_18.position).x, (manager.ui.mainCamera.transform.position - var_296_18.position).y, (manager.ui.mainCamera.transform.position - var_296_18.position).z)
				var_296_18.localEulerAngles.z = 0
				var_296_18.localEulerAngles.x = 0
				var_296_18.localEulerAngles = var_296_18.localEulerAngles
			end

			if arg_293_1.time_ >= 1.96599999815226 + var_296_20 and arg_293_1.time_ < 1.96599999815226 + var_296_20 + arg_296_0 then
				var_296_18.localPosition = Vector3.New(0, 100, 0)
				var_296_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_296_18.position).x, (manager.ui.mainCamera.transform.position - var_296_18.position).y, (manager.ui.mainCamera.transform.position - var_296_18.position).z)
				var_296_18.localEulerAngles.z = 0
				var_296_18.localEulerAngles.x = 0
				var_296_18.localEulerAngles = var_296_18.localEulerAngles

				local var_296_21 = GameObjectTools.GetOrAddComponent(var_296_18.gameObject, typeof(DynamicBoneHelper))

				if var_296_21 then
					var_296_21:EnableDynamicBone(true)
				end
			end

			local var_296_22 = arg_293_1.actors_["6045_story"]

			if 1.96599999815226 < arg_293_1.time_ and arg_293_1.time_ <= 1.96599999815226 + arg_296_0 and not isNil(var_296_22) and arg_293_1.var_.characterEffect6045_story == nil then
				arg_293_1.var_.characterEffect6045_story = var_296_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_23 = 0.034000001847744

			if 1.96599999815226 <= arg_293_1.time_ and arg_293_1.time_ < 1.96599999815226 + var_296_23 and not isNil(var_296_22) then
				if arg_293_1.var_.characterEffect6045_story and not isNil(var_296_22) then
					arg_293_1.var_.characterEffect6045_story.fillFlat = true
					arg_293_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_293_1.time_ - 1.96599999815226) / var_296_23)
				end
			end

			if arg_293_1.time_ >= 1.96599999815226 + var_296_23 and arg_293_1.time_ < 1.96599999815226 + var_296_23 + arg_296_0 and not isNil(var_296_22) and arg_293_1.var_.characterEffect6045_story then
				arg_293_1.var_.characterEffect6045_story.fillFlat = true
				arg_293_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			if arg_293_1.frameCnt_ <= 1 then
				arg_293_1.dialog_:SetActive(false)
			end

			local var_296_24 = 3.999999999999
			local var_296_25 = 1.075

			if 3.999999999999 < arg_293_1.time_ and arg_293_1.time_ <= var_296_24 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0

				arg_293_1.dialog_:SetActive(true)

				arg_293_1.dialogCg_.alpha = 0

				local var_296_26 = LeanTween.value(arg_293_1.dialog_, 0, 1, 0.3)

				var_296_26:setOnUpdate(LuaHelper.FloatAction(function(arg_297_0)
					arg_293_1.dialogCg_.alpha = arg_297_0
				end))
				var_296_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_293_1.dialog_)
					var_296_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_293_1.duration_ = arg_293_1.duration_ + 0.3

				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_27 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(1104201073).content)

				arg_293_1.text_.text = var_296_27

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_29 = 43 <= 0 and var_296_25 or var_296_25 * (utf8.len(var_296_27) / 43)

				if (43 <= 0 and var_296_25 or var_296_25 * (utf8.len(var_296_27) / 43)) > 0 and var_296_25 < var_296_29 then
					arg_293_1.talkMaxDuration = var_296_29
					var_296_24 = var_296_24 + 0.3

					if var_296_29 + var_296_24 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_29 + var_296_24
					end
				end

				arg_293_1.text_.text = var_296_27
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_30 = var_296_24 + 0.3
			local var_296_31 = math.max(var_296_25, arg_293_1.talkMaxDuration)

			if var_296_24 + 0.3 <= arg_293_1.time_ and arg_293_1.time_ < var_296_30 + var_296_31 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_30) / var_296_31

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_30 + var_296_31 and arg_293_1.time_ < var_296_30 + var_296_31 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play1104201074 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 1104201074
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play1104201075(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0.6

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, false)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_1 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(1104201074).content)

				arg_299_1.text_.text = var_302_1

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_3 = 24 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 24)

				if (24 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 24)) > 0 and var_302_0 < var_302_3 then
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
	Play1104201075 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 1104201075
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play1104201076(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0.75

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, true)
				arg_303_1.iconController_:SetSelectedState("hero")

				arg_303_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_303_1.callingController_:SetSelectedState("normal")

				arg_303_1.keyicon_.color = Color.New(1, 1, 1)
				arg_303_1.icon_.color = Color.New(1, 1, 1)

				local var_306_1 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(1104201075).content)

				arg_303_1.text_.text = var_306_1

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_3 = 30 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 30)

				if (30 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 30)) > 0 and var_306_0 < var_306_3 then
					arg_303_1.talkMaxDuration = var_306_3

					if var_306_3 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_3 + 0
					end
				end

				arg_303_1.text_.text = var_306_1
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_4 = math.max(var_306_0, arg_303_1.talkMaxDuration)

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_4 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - 0) / var_306_4

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= 0 + var_306_4 and arg_303_1.time_ < 0 + var_306_4 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play1104201076 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 1104201076
		arg_307_1.duration_ = 12.77

		local var_307_0 = {
			ja = 9.266,
			ko = 12.766,
			zh = 12.766
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
				arg_307_0:Play1104201077(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.var_.moveOldPos6045_story = arg_307_1.actors_["6045_story"].transform.localPosition

				local var_310_0 = GameObjectTools.GetOrAddComponent(arg_307_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_310_0 then
					var_310_0:EnableDynamicBone(false)
				end
			end

			local var_310_1 = 0.001

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_1 then
				arg_307_1.actors_["6045_story"].transform.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos6045_story, Vector3.New(0, -0.5, -6.3), (arg_307_1.time_ - 0) / var_310_1)
				arg_307_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_307_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["6045_story"].transform.position).z)
				arg_307_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_307_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_307_1.actors_["6045_story"].transform.localEulerAngles = arg_307_1.actors_["6045_story"].transform.localEulerAngles
			end

			if arg_307_1.time_ >= 0 + var_310_1 and arg_307_1.time_ < 0 + var_310_1 + arg_310_0 then
				arg_307_1.actors_["6045_story"].transform.localPosition = Vector3.New(0, -0.5, -6.3)
				arg_307_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_307_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["6045_story"].transform.position).z)
				arg_307_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_307_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_307_1.actors_["6045_story"].transform.localEulerAngles = arg_307_1.actors_["6045_story"].transform.localEulerAngles

				local var_310_2 = GameObjectTools.GetOrAddComponent(arg_307_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_310_2 then
					var_310_2:EnableDynamicBone(true)
				end
			end

			local var_310_3 = arg_307_1.actors_["6045_story"]

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(var_310_3) and arg_307_1.var_.characterEffect6045_story == nil then
				arg_307_1.var_.characterEffect6045_story = var_310_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_4 = 0.200000002980232

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_4 and not isNil(var_310_3) then
				if arg_307_1.var_.characterEffect6045_story and not isNil(var_310_3) then
					arg_307_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= 0 + var_310_4 and arg_307_1.time_ < 0 + var_310_4 + arg_310_0 and not isNil(var_310_3) and arg_307_1.var_.characterEffect6045_story then
				arg_307_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_310_6 = 0
			local var_310_7 = 1.175

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_6 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_8 = arg_307_1:GetWordFromCfg(1104201076)
				local var_310_9 = arg_307_1:FormatText(var_310_8.content)

				arg_307_1.text_.text = var_310_9

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_11 = 47 <= 0 and var_310_7 or var_310_7 * (utf8.len(var_310_9) / 47)

				if (47 <= 0 and var_310_7 or var_310_7 * (utf8.len(var_310_9) / 47)) > 0 and var_310_7 < var_310_11 then
					arg_307_1.talkMaxDuration = var_310_11

					if var_310_11 + var_310_6 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_11 + var_310_6
					end
				end

				arg_307_1.text_.text = var_310_9
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201076", "story_v_side_new_1104201.awb") ~= 0 then
					local var_310_12 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201076", "story_v_side_new_1104201.awb") / 1000

					if var_310_12 + var_310_6 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_12 + var_310_6
					end

					if var_310_8.prefab_name ~= "" and arg_307_1.actors_[var_310_8.prefab_name] ~= nil then
						local var_310_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_8.prefab_name].transform, "story_v_side_new_1104201", "1104201076", "story_v_side_new_1104201.awb")

						arg_307_1:RecordAudio("1104201076", var_310_13)
						arg_307_1:RecordAudio("1104201076", var_310_13)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201076", "story_v_side_new_1104201.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201076", "story_v_side_new_1104201.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_14 = math.max(var_310_7, arg_307_1.talkMaxDuration)

			if var_310_6 <= arg_307_1.time_ and arg_307_1.time_ < var_310_6 + var_310_14 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_6) / var_310_14

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_6 + var_310_14 and arg_307_1.time_ < var_310_6 + var_310_14 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	Play1104201077 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 1104201077
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play1104201078(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(arg_311_1.actors_["6045_story"]) and arg_311_1.var_.characterEffect6045_story == nil then
				arg_311_1.var_.characterEffect6045_story = arg_311_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_0 = 0.200000002980232

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 and not isNil(arg_311_1.actors_["6045_story"]) then
				if arg_311_1.var_.characterEffect6045_story and not isNil(arg_311_1.actors_["6045_story"]) then
					arg_311_1.var_.characterEffect6045_story.fillFlat = true
					arg_311_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_311_1.time_ - 0) / var_314_0)
				end
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 and not isNil(arg_311_1.actors_["6045_story"]) and arg_311_1.var_.characterEffect6045_story then
				arg_311_1.var_.characterEffect6045_story.fillFlat = true
				arg_311_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_314_1 = 0
			local var_314_2 = 1.025

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

				local var_314_3 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(1104201077).content)

				arg_311_1.text_.text = var_314_3

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_5 = 41 <= 0 and var_314_2 or var_314_2 * (utf8.len(var_314_3) / 41)

				if (41 <= 0 and var_314_2 or var_314_2 * (utf8.len(var_314_3) / 41)) > 0 and var_314_2 < var_314_5 then
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
	Play1104201078 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 1104201078
		arg_315_1.duration_ = 3.1

		local var_315_0 = {
			ja = 2.166,
			ko = 3.1,
			zh = 3.1
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
				arg_315_0:Play1104201079(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.var_.moveOldPos6045_story = arg_315_1.actors_["6045_story"].transform.localPosition

				local var_318_0 = GameObjectTools.GetOrAddComponent(arg_315_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_318_0 then
					var_318_0:EnableDynamicBone(false)
				end
			end

			local var_318_1 = 0.001

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_1 then
				arg_315_1.actors_["6045_story"].transform.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos6045_story, Vector3.New(-0.7, -0.5, -6.3), (arg_315_1.time_ - 0) / var_318_1)
				arg_315_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_315_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["6045_story"].transform.position).z)
				arg_315_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_315_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_315_1.actors_["6045_story"].transform.localEulerAngles = arg_315_1.actors_["6045_story"].transform.localEulerAngles
			end

			if arg_315_1.time_ >= 0 + var_318_1 and arg_315_1.time_ < 0 + var_318_1 + arg_318_0 then
				arg_315_1.actors_["6045_story"].transform.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				arg_315_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_315_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["6045_story"].transform.position).z)
				arg_315_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_315_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_315_1.actors_["6045_story"].transform.localEulerAngles = arg_315_1.actors_["6045_story"].transform.localEulerAngles

				local var_318_2 = GameObjectTools.GetOrAddComponent(arg_315_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_318_2 then
					var_318_2:EnableDynamicBone(true)
				end
			end

			local var_318_3 = arg_315_1.actors_["6045_story"]

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(var_318_3) and arg_315_1.var_.characterEffect6045_story == nil then
				arg_315_1.var_.characterEffect6045_story = var_318_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_4 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_4 and not isNil(var_318_3) then
				if arg_315_1.var_.characterEffect6045_story and not isNil(var_318_3) then
					arg_315_1.var_.characterEffect6045_story.fillFlat = true
					arg_315_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_315_1.time_ - 0) / var_318_4)
				end
			end

			if arg_315_1.time_ >= 0 + var_318_4 and arg_315_1.time_ < 0 + var_318_4 + arg_318_0 and not isNil(var_318_3) and arg_315_1.var_.characterEffect6045_story then
				arg_315_1.var_.characterEffect6045_story.fillFlat = true
				arg_315_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_318_5 = arg_315_1.actors_["6046_story"].transform

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.var_.moveOldPos6046_story = var_318_5.localPosition

				local var_318_6 = GameObjectTools.GetOrAddComponent(var_318_5.gameObject, typeof(DynamicBoneHelper))

				if var_318_6 then
					var_318_6:EnableDynamicBone(false)
				end
			end

			local var_318_7 = 0.001

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_7 then
				var_318_5.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos6046_story, Vector3.New(0.7, -0.5, -6.3), (arg_315_1.time_ - 0) / var_318_7)
				var_318_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_318_5.position).x, (manager.ui.mainCamera.transform.position - var_318_5.position).y, (manager.ui.mainCamera.transform.position - var_318_5.position).z)
				var_318_5.localEulerAngles.z = 0
				var_318_5.localEulerAngles.x = 0
				var_318_5.localEulerAngles = var_318_5.localEulerAngles
			end

			if arg_315_1.time_ >= 0 + var_318_7 and arg_315_1.time_ < 0 + var_318_7 + arg_318_0 then
				var_318_5.localPosition = Vector3.New(0.7, -0.5, -6.3)
				var_318_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_318_5.position).x, (manager.ui.mainCamera.transform.position - var_318_5.position).y, (manager.ui.mainCamera.transform.position - var_318_5.position).z)
				var_318_5.localEulerAngles.z = 0
				var_318_5.localEulerAngles.x = 0
				var_318_5.localEulerAngles = var_318_5.localEulerAngles

				local var_318_8 = GameObjectTools.GetOrAddComponent(var_318_5.gameObject, typeof(DynamicBoneHelper))

				if var_318_8 then
					var_318_8:EnableDynamicBone(true)
				end
			end

			local var_318_9 = arg_315_1.actors_["6046_story"]

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(var_318_9) and arg_315_1.var_.characterEffect6046_story == nil then
				arg_315_1.var_.characterEffect6046_story = var_318_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_10 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_10 and not isNil(var_318_9) then
				if arg_315_1.var_.characterEffect6046_story and not isNil(var_318_9) then
					arg_315_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_315_1.time_ >= 0 + var_318_10 and arg_315_1.time_ < 0 + var_318_10 + arg_318_0 and not isNil(var_318_9) and arg_315_1.var_.characterEffect6046_story then
				arg_315_1.var_.characterEffect6046_story.fillFlat = false
			end

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_318_12 = 0
			local var_318_13 = 0.25

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_12 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_14 = arg_315_1:GetWordFromCfg(1104201078)
				local var_318_15 = arg_315_1:FormatText(var_318_14.content)

				arg_315_1.text_.text = var_318_15

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_17 = 10 <= 0 and var_318_13 or var_318_13 * (utf8.len(var_318_15) / 10)

				if (10 <= 0 and var_318_13 or var_318_13 * (utf8.len(var_318_15) / 10)) > 0 and var_318_13 < var_318_17 then
					arg_315_1.talkMaxDuration = var_318_17

					if var_318_17 + var_318_12 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_17 + var_318_12
					end
				end

				arg_315_1.text_.text = var_318_15
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201078", "story_v_side_new_1104201.awb") ~= 0 then
					local var_318_18 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201078", "story_v_side_new_1104201.awb") / 1000

					if var_318_18 + var_318_12 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_18 + var_318_12
					end

					if var_318_14.prefab_name ~= "" and arg_315_1.actors_[var_318_14.prefab_name] ~= nil then
						local var_318_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_14.prefab_name].transform, "story_v_side_new_1104201", "1104201078", "story_v_side_new_1104201.awb")

						arg_315_1:RecordAudio("1104201078", var_318_19)
						arg_315_1:RecordAudio("1104201078", var_318_19)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201078", "story_v_side_new_1104201.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201078", "story_v_side_new_1104201.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_20 = math.max(var_318_13, arg_315_1.talkMaxDuration)

			if var_318_12 <= arg_315_1.time_ and arg_315_1.time_ < var_318_12 + var_318_20 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_12) / var_318_20

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_12 + var_318_20 and arg_315_1.time_ < var_318_12 + var_318_20 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_315_1:InitPlayNodeList()
	end,
	Play1104201079 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 1104201079
		arg_319_1.duration_ = 9.33

		local var_319_0 = {
			ja = 9.333,
			ko = 9.066,
			zh = 9.066
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
				arg_319_0:Play1104201080(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(arg_319_1.actors_["6045_story"]) and arg_319_1.var_.characterEffect6045_story == nil then
				arg_319_1.var_.characterEffect6045_story = arg_319_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_0 = 0.200000002980232

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_0 and not isNil(arg_319_1.actors_["6045_story"]) then
				if arg_319_1.var_.characterEffect6045_story and not isNil(arg_319_1.actors_["6045_story"]) then
					arg_319_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_319_1.time_ >= 0 + var_322_0 and arg_319_1.time_ < 0 + var_322_0 + arg_322_0 and not isNil(arg_319_1.actors_["6045_story"]) and arg_319_1.var_.characterEffect6045_story then
				arg_319_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_1")
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_322_2 = arg_319_1.actors_["6046_story"]

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(var_322_2) and arg_319_1.var_.characterEffect6046_story == nil then
				arg_319_1.var_.characterEffect6046_story = var_322_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_3 = 0.200000002980232

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_3 and not isNil(var_322_2) then
				if arg_319_1.var_.characterEffect6046_story and not isNil(var_322_2) then
					arg_319_1.var_.characterEffect6046_story.fillFlat = true
					arg_319_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_319_1.time_ - 0) / var_322_3)
				end
			end

			if arg_319_1.time_ >= 0 + var_322_3 and arg_319_1.time_ < 0 + var_322_3 + arg_322_0 and not isNil(var_322_2) and arg_319_1.var_.characterEffect6046_story then
				arg_319_1.var_.characterEffect6046_story.fillFlat = true
				arg_319_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_322_4 = 0
			local var_322_5 = 0.825

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_4 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_6 = arg_319_1:GetWordFromCfg(1104201079)
				local var_322_7 = arg_319_1:FormatText(var_322_6.content)

				arg_319_1.text_.text = var_322_7

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_9 = 33 <= 0 and var_322_5 or var_322_5 * (utf8.len(var_322_7) / 33)

				if (33 <= 0 and var_322_5 or var_322_5 * (utf8.len(var_322_7) / 33)) > 0 and var_322_5 < var_322_9 then
					arg_319_1.talkMaxDuration = var_322_9

					if var_322_9 + var_322_4 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_9 + var_322_4
					end
				end

				arg_319_1.text_.text = var_322_7
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201079", "story_v_side_new_1104201.awb") ~= 0 then
					local var_322_10 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201079", "story_v_side_new_1104201.awb") / 1000

					if var_322_10 + var_322_4 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_10 + var_322_4
					end

					if var_322_6.prefab_name ~= "" and arg_319_1.actors_[var_322_6.prefab_name] ~= nil then
						local var_322_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_6.prefab_name].transform, "story_v_side_new_1104201", "1104201079", "story_v_side_new_1104201.awb")

						arg_319_1:RecordAudio("1104201079", var_322_11)
						arg_319_1:RecordAudio("1104201079", var_322_11)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201079", "story_v_side_new_1104201.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201079", "story_v_side_new_1104201.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_12 = math.max(var_322_5, arg_319_1.talkMaxDuration)

			if var_322_4 <= arg_319_1.time_ and arg_319_1.time_ < var_322_4 + var_322_12 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_4) / var_322_12

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_4 + var_322_12 and arg_319_1.time_ < var_322_4 + var_322_12 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play1104201080 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 1104201080
		arg_323_1.duration_ = 10.7

		local var_323_0 = {
			ja = 10.7,
			ko = 6.533,
			zh = 6.533
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
				arg_323_0:Play1104201081(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = 0.575

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_1 = arg_323_1:GetWordFromCfg(1104201080)
				local var_326_2 = arg_323_1:FormatText(var_326_1.content)

				arg_323_1.text_.text = var_326_2

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_4 = 23 <= 0 and var_326_0 or var_326_0 * (utf8.len(var_326_2) / 23)

				if (23 <= 0 and var_326_0 or var_326_0 * (utf8.len(var_326_2) / 23)) > 0 and var_326_0 < var_326_4 then
					arg_323_1.talkMaxDuration = var_326_4

					if var_326_4 + 0 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_4 + 0
					end
				end

				arg_323_1.text_.text = var_326_2
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201080", "story_v_side_new_1104201.awb") ~= 0 then
					local var_326_5 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201080", "story_v_side_new_1104201.awb") / 1000

					if var_326_5 + 0 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_5 + 0
					end

					if var_326_1.prefab_name ~= "" and arg_323_1.actors_[var_326_1.prefab_name] ~= nil then
						local var_326_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_1.prefab_name].transform, "story_v_side_new_1104201", "1104201080", "story_v_side_new_1104201.awb")

						arg_323_1:RecordAudio("1104201080", var_326_6)
						arg_323_1:RecordAudio("1104201080", var_326_6)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201080", "story_v_side_new_1104201.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201080", "story_v_side_new_1104201.awb")
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
	Play1104201081 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 1104201081
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play1104201082(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(arg_327_1.actors_["6045_story"]) and arg_327_1.var_.characterEffect6045_story == nil then
				arg_327_1.var_.characterEffect6045_story = arg_327_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_0 = 0.200000002980232

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 and not isNil(arg_327_1.actors_["6045_story"]) then
				if arg_327_1.var_.characterEffect6045_story and not isNil(arg_327_1.actors_["6045_story"]) then
					arg_327_1.var_.characterEffect6045_story.fillFlat = true
					arg_327_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_327_1.time_ - 0) / var_330_0)
				end
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 and not isNil(arg_327_1.actors_["6045_story"]) and arg_327_1.var_.characterEffect6045_story then
				arg_327_1.var_.characterEffect6045_story.fillFlat = true
				arg_327_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_330_1 = 0
			local var_330_2 = 1.175

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, true)
				arg_327_1.iconController_:SetSelectedState("hero")

				arg_327_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_327_1.callingController_:SetSelectedState("normal")

				arg_327_1.keyicon_.color = Color.New(1, 1, 1)
				arg_327_1.icon_.color = Color.New(1, 1, 1)

				local var_330_3 = arg_327_1:FormatText(arg_327_1:GetWordFromCfg(1104201081).content)

				arg_327_1.text_.text = var_330_3

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_5 = 47 <= 0 and var_330_2 or var_330_2 * (utf8.len(var_330_3) / 47)

				if (47 <= 0 and var_330_2 or var_330_2 * (utf8.len(var_330_3) / 47)) > 0 and var_330_2 < var_330_5 then
					arg_327_1.talkMaxDuration = var_330_5

					if var_330_5 + var_330_1 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_5 + var_330_1
					end
				end

				arg_327_1.text_.text = var_330_3
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_6 = math.max(var_330_2, arg_327_1.talkMaxDuration)

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_6 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_1) / var_330_6

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_1 + var_330_6 and arg_327_1.time_ < var_330_1 + var_330_6 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play1104201082 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 1104201082
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play1104201083(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 0.375

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, true)
				arg_331_1.iconController_:SetSelectedState("hero")

				arg_331_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_331_1.callingController_:SetSelectedState("normal")

				arg_331_1.keyicon_.color = Color.New(1, 1, 1)
				arg_331_1.icon_.color = Color.New(1, 1, 1)

				local var_334_1 = arg_331_1:FormatText(arg_331_1:GetWordFromCfg(1104201082).content)

				arg_331_1.text_.text = var_334_1

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_3 = 15 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_1) / 15)

				if (15 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_1) / 15)) > 0 and var_334_0 < var_334_3 then
					arg_331_1.talkMaxDuration = var_334_3

					if var_334_3 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_3 + 0
					end
				end

				arg_331_1.text_.text = var_334_1
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_4 = math.max(var_334_0, arg_331_1.talkMaxDuration)

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_4 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - 0) / var_334_4

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= 0 + var_334_4 and arg_331_1.time_ < 0 + var_334_4 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play1104201083 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 1104201083
		arg_335_1.duration_ = 12.3

		local var_335_0 = {
			ja = 12.3,
			ko = 8.633,
			zh = 8.633
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
				arg_335_0:Play1104201084(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(arg_335_1.actors_["6045_story"]) and arg_335_1.var_.characterEffect6045_story == nil then
				arg_335_1.var_.characterEffect6045_story = arg_335_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_0 = 0.200000002980232

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_0 and not isNil(arg_335_1.actors_["6045_story"]) then
				if arg_335_1.var_.characterEffect6045_story and not isNil(arg_335_1.actors_["6045_story"]) then
					arg_335_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_335_1.time_ >= 0 + var_338_0 and arg_335_1.time_ < 0 + var_338_0 + arg_338_0 and not isNil(arg_335_1.actors_["6045_story"]) and arg_335_1.var_.characterEffect6045_story then
				arg_335_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_2")
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_2")
			end

			local var_338_2 = 0
			local var_338_3 = 0.85

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_2 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_4 = arg_335_1:GetWordFromCfg(1104201083)
				local var_338_5 = arg_335_1:FormatText(var_338_4.content)

				arg_335_1.text_.text = var_338_5

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_7 = 34 <= 0 and var_338_3 or var_338_3 * (utf8.len(var_338_5) / 34)

				if (34 <= 0 and var_338_3 or var_338_3 * (utf8.len(var_338_5) / 34)) > 0 and var_338_3 < var_338_7 then
					arg_335_1.talkMaxDuration = var_338_7

					if var_338_7 + var_338_2 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_7 + var_338_2
					end
				end

				arg_335_1.text_.text = var_338_5
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201083", "story_v_side_new_1104201.awb") ~= 0 then
					local var_338_8 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201083", "story_v_side_new_1104201.awb") / 1000

					if var_338_8 + var_338_2 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_8 + var_338_2
					end

					if var_338_4.prefab_name ~= "" and arg_335_1.actors_[var_338_4.prefab_name] ~= nil then
						local var_338_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_4.prefab_name].transform, "story_v_side_new_1104201", "1104201083", "story_v_side_new_1104201.awb")

						arg_335_1:RecordAudio("1104201083", var_338_9)
						arg_335_1:RecordAudio("1104201083", var_338_9)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201083", "story_v_side_new_1104201.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201083", "story_v_side_new_1104201.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_10 = math.max(var_338_3, arg_335_1.talkMaxDuration)

			if var_338_2 <= arg_335_1.time_ and arg_335_1.time_ < var_338_2 + var_338_10 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_2) / var_338_10

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_2 + var_338_10 and arg_335_1.time_ < var_338_2 + var_338_10 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play1104201084 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 1104201084
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play1104201085(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(arg_339_1.actors_["6045_story"]) and arg_339_1.var_.characterEffect6045_story == nil then
				arg_339_1.var_.characterEffect6045_story = arg_339_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_0 = 0.200000002980232

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 and not isNil(arg_339_1.actors_["6045_story"]) then
				if arg_339_1.var_.characterEffect6045_story and not isNil(arg_339_1.actors_["6045_story"]) then
					arg_339_1.var_.characterEffect6045_story.fillFlat = true
					arg_339_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_339_1.time_ - 0) / var_342_0)
				end
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 and not isNil(arg_339_1.actors_["6045_story"]) and arg_339_1.var_.characterEffect6045_story then
				arg_339_1.var_.characterEffect6045_story.fillFlat = true
				arg_339_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_342_1 = 0
			local var_342_2 = 0.125

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, true)
				arg_339_1.iconController_:SetSelectedState("hero")

				arg_339_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_339_1.callingController_:SetSelectedState("normal")

				arg_339_1.keyicon_.color = Color.New(1, 1, 1)
				arg_339_1.icon_.color = Color.New(1, 1, 1)

				local var_342_3 = arg_339_1:FormatText(arg_339_1:GetWordFromCfg(1104201084).content)

				arg_339_1.text_.text = var_342_3

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_5 = 5 <= 0 and var_342_2 or var_342_2 * (utf8.len(var_342_3) / 5)

				if (5 <= 0 and var_342_2 or var_342_2 * (utf8.len(var_342_3) / 5)) > 0 and var_342_2 < var_342_5 then
					arg_339_1.talkMaxDuration = var_342_5

					if var_342_5 + var_342_1 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_5 + var_342_1
					end
				end

				arg_339_1.text_.text = var_342_3
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_6 = math.max(var_342_2, arg_339_1.talkMaxDuration)

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_6 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_1) / var_342_6

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_1 + var_342_6 and arg_339_1.time_ < var_342_1 + var_342_6 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play1104201085 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 1104201085
		arg_343_1.duration_ = 14.6

		local var_343_0 = {
			ja = 14.6,
			ko = 12.866,
			zh = 12.866
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
				arg_343_0:Play1104201086(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(arg_343_1.actors_["6045_story"]) and arg_343_1.var_.characterEffect6045_story == nil then
				arg_343_1.var_.characterEffect6045_story = arg_343_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_0 = 0.200000002980232

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 and not isNil(arg_343_1.actors_["6045_story"]) then
				if arg_343_1.var_.characterEffect6045_story and not isNil(arg_343_1.actors_["6045_story"]) then
					arg_343_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 and not isNil(arg_343_1.actors_["6045_story"]) and arg_343_1.var_.characterEffect6045_story then
				arg_343_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_346_2 = 0
			local var_346_3 = 1.175

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_2 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_4 = arg_343_1:GetWordFromCfg(1104201085)
				local var_346_5 = arg_343_1:FormatText(var_346_4.content)

				arg_343_1.text_.text = var_346_5

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_7 = 47 <= 0 and var_346_3 or var_346_3 * (utf8.len(var_346_5) / 47)

				if (47 <= 0 and var_346_3 or var_346_3 * (utf8.len(var_346_5) / 47)) > 0 and var_346_3 < var_346_7 then
					arg_343_1.talkMaxDuration = var_346_7

					if var_346_7 + var_346_2 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_7 + var_346_2
					end
				end

				arg_343_1.text_.text = var_346_5
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201085", "story_v_side_new_1104201.awb") ~= 0 then
					local var_346_8 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201085", "story_v_side_new_1104201.awb") / 1000

					if var_346_8 + var_346_2 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_8 + var_346_2
					end

					if var_346_4.prefab_name ~= "" and arg_343_1.actors_[var_346_4.prefab_name] ~= nil then
						local var_346_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_4.prefab_name].transform, "story_v_side_new_1104201", "1104201085", "story_v_side_new_1104201.awb")

						arg_343_1:RecordAudio("1104201085", var_346_9)
						arg_343_1:RecordAudio("1104201085", var_346_9)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201085", "story_v_side_new_1104201.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201085", "story_v_side_new_1104201.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_10 = math.max(var_346_3, arg_343_1.talkMaxDuration)

			if var_346_2 <= arg_343_1.time_ and arg_343_1.time_ < var_346_2 + var_346_10 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_2) / var_346_10

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_2 + var_346_10 and arg_343_1.time_ < var_346_2 + var_346_10 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play1104201086 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 1104201086
		arg_347_1.duration_ = 18.63

		local var_347_0 = {
			ja = 15.566,
			ko = 18.633,
			zh = 18.633
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
				arg_347_0:Play1104201087(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 1.65

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_1 = arg_347_1:GetWordFromCfg(1104201086)
				local var_350_2 = arg_347_1:FormatText(var_350_1.content)

				arg_347_1.text_.text = var_350_2

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_4 = 66 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_2) / 66)

				if (66 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_2) / 66)) > 0 and var_350_0 < var_350_4 then
					arg_347_1.talkMaxDuration = var_350_4

					if var_350_4 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_4 + 0
					end
				end

				arg_347_1.text_.text = var_350_2
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201086", "story_v_side_new_1104201.awb") ~= 0 then
					local var_350_5 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201086", "story_v_side_new_1104201.awb") / 1000

					if var_350_5 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_5 + 0
					end

					if var_350_1.prefab_name ~= "" and arg_347_1.actors_[var_350_1.prefab_name] ~= nil then
						local var_350_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_1.prefab_name].transform, "story_v_side_new_1104201", "1104201086", "story_v_side_new_1104201.awb")

						arg_347_1:RecordAudio("1104201086", var_350_6)
						arg_347_1:RecordAudio("1104201086", var_350_6)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201086", "story_v_side_new_1104201.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201086", "story_v_side_new_1104201.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_7 = math.max(var_350_0, arg_347_1.talkMaxDuration)

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_7 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - 0) / var_350_7

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= 0 + var_350_7 and arg_347_1.time_ < 0 + var_350_7 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play1104201087 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 1104201087
		arg_351_1.duration_ = 3.7

		local var_351_0 = {
			ja = 2.866,
			ko = 3.7,
			zh = 3.7
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
				arg_351_0:Play1104201088(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(arg_351_1.actors_["6046_story"]) and arg_351_1.var_.characterEffect6046_story == nil then
				arg_351_1.var_.characterEffect6046_story = arg_351_1.actors_["6046_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_0 = 0.200000002980232

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 and not isNil(arg_351_1.actors_["6046_story"]) then
				if arg_351_1.var_.characterEffect6046_story and not isNil(arg_351_1.actors_["6046_story"]) then
					arg_351_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 and not isNil(arg_351_1.actors_["6046_story"]) and arg_351_1.var_.characterEffect6046_story then
				arg_351_1.var_.characterEffect6046_story.fillFlat = false
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_354_2 = arg_351_1.actors_["6045_story"]

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(var_354_2) and arg_351_1.var_.characterEffect6045_story == nil then
				arg_351_1.var_.characterEffect6045_story = var_354_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_3 = 0.200000002980232

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_3 and not isNil(var_354_2) then
				if arg_351_1.var_.characterEffect6045_story and not isNil(var_354_2) then
					arg_351_1.var_.characterEffect6045_story.fillFlat = true
					arg_351_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_351_1.time_ - 0) / var_354_3)
				end
			end

			if arg_351_1.time_ >= 0 + var_354_3 and arg_351_1.time_ < 0 + var_354_3 + arg_354_0 and not isNil(var_354_2) and arg_351_1.var_.characterEffect6045_story then
				arg_351_1.var_.characterEffect6045_story.fillFlat = true
				arg_351_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_354_4 = 0
			local var_354_5 = 0.325

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_4 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_6 = arg_351_1:GetWordFromCfg(1104201087)
				local var_354_7 = arg_351_1:FormatText(var_354_6.content)

				arg_351_1.text_.text = var_354_7

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_9 = 13 <= 0 and var_354_5 or var_354_5 * (utf8.len(var_354_7) / 13)

				if (13 <= 0 and var_354_5 or var_354_5 * (utf8.len(var_354_7) / 13)) > 0 and var_354_5 < var_354_9 then
					arg_351_1.talkMaxDuration = var_354_9

					if var_354_9 + var_354_4 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_9 + var_354_4
					end
				end

				arg_351_1.text_.text = var_354_7
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201087", "story_v_side_new_1104201.awb") ~= 0 then
					local var_354_10 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201087", "story_v_side_new_1104201.awb") / 1000

					if var_354_10 + var_354_4 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_10 + var_354_4
					end

					if var_354_6.prefab_name ~= "" and arg_351_1.actors_[var_354_6.prefab_name] ~= nil then
						local var_354_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_6.prefab_name].transform, "story_v_side_new_1104201", "1104201087", "story_v_side_new_1104201.awb")

						arg_351_1:RecordAudio("1104201087", var_354_11)
						arg_351_1:RecordAudio("1104201087", var_354_11)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201087", "story_v_side_new_1104201.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201087", "story_v_side_new_1104201.awb")
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
	Play1104201088 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 1104201088
		arg_355_1.duration_ = 18.5

		local var_355_0 = {
			ja = 18.5,
			ko = 13.533,
			zh = 13.533
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play1104201089(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(arg_355_1.actors_["6045_story"]) and arg_355_1.var_.characterEffect6045_story == nil then
				arg_355_1.var_.characterEffect6045_story = arg_355_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_0 = 0.200000002980232

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_0 and not isNil(arg_355_1.actors_["6045_story"]) then
				if arg_355_1.var_.characterEffect6045_story and not isNil(arg_355_1.actors_["6045_story"]) then
					arg_355_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_355_1.time_ >= 0 + var_358_0 and arg_355_1.time_ < 0 + var_358_0 + arg_358_0 and not isNil(arg_355_1.actors_["6045_story"]) and arg_355_1.var_.characterEffect6045_story then
				arg_355_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_358_2 = arg_355_1.actors_["6046_story"]

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(var_358_2) and arg_355_1.var_.characterEffect6046_story == nil then
				arg_355_1.var_.characterEffect6046_story = var_358_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_3 = 0.200000002980232

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_3 and not isNil(var_358_2) then
				if arg_355_1.var_.characterEffect6046_story and not isNil(var_358_2) then
					arg_355_1.var_.characterEffect6046_story.fillFlat = true
					arg_355_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_355_1.time_ - 0) / var_358_3)
				end
			end

			if arg_355_1.time_ >= 0 + var_358_3 and arg_355_1.time_ < 0 + var_358_3 + arg_358_0 and not isNil(var_358_2) and arg_355_1.var_.characterEffect6046_story then
				arg_355_1.var_.characterEffect6046_story.fillFlat = true
				arg_355_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_358_4 = 0
			local var_358_5 = 1.15

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_4 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_6 = arg_355_1:GetWordFromCfg(1104201088)
				local var_358_7 = arg_355_1:FormatText(var_358_6.content)

				arg_355_1.text_.text = var_358_7

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_9 = 45 <= 0 and var_358_5 or var_358_5 * (utf8.len(var_358_7) / 45)

				if (45 <= 0 and var_358_5 or var_358_5 * (utf8.len(var_358_7) / 45)) > 0 and var_358_5 < var_358_9 then
					arg_355_1.talkMaxDuration = var_358_9

					if var_358_9 + var_358_4 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_9 + var_358_4
					end
				end

				arg_355_1.text_.text = var_358_7
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201088", "story_v_side_new_1104201.awb") ~= 0 then
					local var_358_10 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201088", "story_v_side_new_1104201.awb") / 1000

					if var_358_10 + var_358_4 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_10 + var_358_4
					end

					if var_358_6.prefab_name ~= "" and arg_355_1.actors_[var_358_6.prefab_name] ~= nil then
						local var_358_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_6.prefab_name].transform, "story_v_side_new_1104201", "1104201088", "story_v_side_new_1104201.awb")

						arg_355_1:RecordAudio("1104201088", var_358_11)
						arg_355_1:RecordAudio("1104201088", var_358_11)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201088", "story_v_side_new_1104201.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201088", "story_v_side_new_1104201.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_12 = math.max(var_358_5, arg_355_1.talkMaxDuration)

			if var_358_4 <= arg_355_1.time_ and arg_355_1.time_ < var_358_4 + var_358_12 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_4) / var_358_12

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_4 + var_358_12 and arg_355_1.time_ < var_358_4 + var_358_12 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play1104201089 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 1104201089
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play1104201090(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(arg_359_1.actors_["6045_story"]) and arg_359_1.var_.characterEffect6045_story == nil then
				arg_359_1.var_.characterEffect6045_story = arg_359_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_0 = 0.200000002980232

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 and not isNil(arg_359_1.actors_["6045_story"]) then
				if arg_359_1.var_.characterEffect6045_story and not isNil(arg_359_1.actors_["6045_story"]) then
					arg_359_1.var_.characterEffect6045_story.fillFlat = true
					arg_359_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_359_1.time_ - 0) / var_362_0)
				end
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 and not isNil(arg_359_1.actors_["6045_story"]) and arg_359_1.var_.characterEffect6045_story then
				arg_359_1.var_.characterEffect6045_story.fillFlat = true
				arg_359_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_362_1 = 0
			local var_362_2 = 0.2

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, true)
				arg_359_1.iconController_:SetSelectedState("hero")

				arg_359_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_359_1.callingController_:SetSelectedState("normal")

				arg_359_1.keyicon_.color = Color.New(1, 1, 1)
				arg_359_1.icon_.color = Color.New(1, 1, 1)

				local var_362_3 = arg_359_1:FormatText(arg_359_1:GetWordFromCfg(1104201089).content)

				arg_359_1.text_.text = var_362_3

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_5 = 8 <= 0 and var_362_2 or var_362_2 * (utf8.len(var_362_3) / 8)

				if (8 <= 0 and var_362_2 or var_362_2 * (utf8.len(var_362_3) / 8)) > 0 and var_362_2 < var_362_5 then
					arg_359_1.talkMaxDuration = var_362_5

					if var_362_5 + var_362_1 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_5 + var_362_1
					end
				end

				arg_359_1.text_.text = var_362_3
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_6 = math.max(var_362_2, arg_359_1.talkMaxDuration)

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_6 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_1) / var_362_6

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_1 + var_362_6 and arg_359_1.time_ < var_362_1 + var_362_6 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play1104201090 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 1104201090
		arg_363_1.duration_ = 11.07

		local var_363_0 = {
			ja = 9.866,
			ko = 11.066,
			zh = 11.066
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play1104201091(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(arg_363_1.actors_["6045_story"]) and arg_363_1.var_.characterEffect6045_story == nil then
				arg_363_1.var_.characterEffect6045_story = arg_363_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_0 = 0.200000002980232

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_0 and not isNil(arg_363_1.actors_["6045_story"]) then
				if arg_363_1.var_.characterEffect6045_story and not isNil(arg_363_1.actors_["6045_story"]) then
					arg_363_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_363_1.time_ >= 0 + var_366_0 and arg_363_1.time_ < 0 + var_366_0 + arg_366_0 and not isNil(arg_363_1.actors_["6045_story"]) and arg_363_1.var_.characterEffect6045_story then
				arg_363_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_366_2 = 0
			local var_366_3 = 1.175

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_2 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_4 = arg_363_1:GetWordFromCfg(1104201090)
				local var_366_5 = arg_363_1:FormatText(var_366_4.content)

				arg_363_1.text_.text = var_366_5

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_7 = 43 <= 0 and var_366_3 or var_366_3 * (utf8.len(var_366_5) / 43)

				if (43 <= 0 and var_366_3 or var_366_3 * (utf8.len(var_366_5) / 43)) > 0 and var_366_3 < var_366_7 then
					arg_363_1.talkMaxDuration = var_366_7

					if var_366_7 + var_366_2 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_7 + var_366_2
					end
				end

				arg_363_1.text_.text = var_366_5
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201090", "story_v_side_new_1104201.awb") ~= 0 then
					local var_366_8 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201090", "story_v_side_new_1104201.awb") / 1000

					if var_366_8 + var_366_2 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_8 + var_366_2
					end

					if var_366_4.prefab_name ~= "" and arg_363_1.actors_[var_366_4.prefab_name] ~= nil then
						local var_366_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_4.prefab_name].transform, "story_v_side_new_1104201", "1104201090", "story_v_side_new_1104201.awb")

						arg_363_1:RecordAudio("1104201090", var_366_9)
						arg_363_1:RecordAudio("1104201090", var_366_9)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201090", "story_v_side_new_1104201.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201090", "story_v_side_new_1104201.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_10 = math.max(var_366_3, arg_363_1.talkMaxDuration)

			if var_366_2 <= arg_363_1.time_ and arg_363_1.time_ < var_366_2 + var_366_10 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_2) / var_366_10

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_2 + var_366_10 and arg_363_1.time_ < var_366_2 + var_366_10 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play1104201091 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 1104201091
		arg_367_1.duration_ = 7.17

		local var_367_0 = {
			ja = 7.166,
			ko = 7.133,
			zh = 7.133
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
				arg_367_0:Play1104201092(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 0.65

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_1 = arg_367_1:GetWordFromCfg(1104201091)
				local var_370_2 = arg_367_1:FormatText(var_370_1.content)

				arg_367_1.text_.text = var_370_2

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_4 = 27 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_2) / 27)

				if (27 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_2) / 27)) > 0 and var_370_0 < var_370_4 then
					arg_367_1.talkMaxDuration = var_370_4

					if var_370_4 + 0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_4 + 0
					end
				end

				arg_367_1.text_.text = var_370_2
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201091", "story_v_side_new_1104201.awb") ~= 0 then
					local var_370_5 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201091", "story_v_side_new_1104201.awb") / 1000

					if var_370_5 + 0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_5 + 0
					end

					if var_370_1.prefab_name ~= "" and arg_367_1.actors_[var_370_1.prefab_name] ~= nil then
						local var_370_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_1.prefab_name].transform, "story_v_side_new_1104201", "1104201091", "story_v_side_new_1104201.awb")

						arg_367_1:RecordAudio("1104201091", var_370_6)
						arg_367_1:RecordAudio("1104201091", var_370_6)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201091", "story_v_side_new_1104201.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201091", "story_v_side_new_1104201.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_7 = math.max(var_370_0, arg_367_1.talkMaxDuration)

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_7 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - 0) / var_370_7

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= 0 + var_370_7 and arg_367_1.time_ < 0 + var_370_7 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play1104201092 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 1104201092
		arg_371_1.duration_ = 18.17

		local var_371_0 = {
			ja = 18.166,
			ko = 16.2,
			zh = 16.2
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
				arg_371_0:Play1104201093(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 1.375

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_1 = arg_371_1:GetWordFromCfg(1104201092)
				local var_374_2 = arg_371_1:FormatText(var_374_1.content)

				arg_371_1.text_.text = var_374_2

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_4 = 55 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_2) / 55)

				if (55 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_2) / 55)) > 0 and var_374_0 < var_374_4 then
					arg_371_1.talkMaxDuration = var_374_4

					if var_374_4 + 0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_4 + 0
					end
				end

				arg_371_1.text_.text = var_374_2
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201092", "story_v_side_new_1104201.awb") ~= 0 then
					local var_374_5 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201092", "story_v_side_new_1104201.awb") / 1000

					if var_374_5 + 0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_5 + 0
					end

					if var_374_1.prefab_name ~= "" and arg_371_1.actors_[var_374_1.prefab_name] ~= nil then
						local var_374_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_1.prefab_name].transform, "story_v_side_new_1104201", "1104201092", "story_v_side_new_1104201.awb")

						arg_371_1:RecordAudio("1104201092", var_374_6)
						arg_371_1:RecordAudio("1104201092", var_374_6)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201092", "story_v_side_new_1104201.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201092", "story_v_side_new_1104201.awb")
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
	Play1104201093 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 1104201093
		arg_375_1.duration_ = 5

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play1104201094(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.var_.moveOldPos6045_story = arg_375_1.actors_["6045_story"].transform.localPosition

				local var_378_0 = GameObjectTools.GetOrAddComponent(arg_375_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_378_0 then
					var_378_0:EnableDynamicBone(false)
				end
			end

			local var_378_1 = 0.001

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_1 then
				arg_375_1.actors_["6045_story"].transform.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos6045_story, Vector3.New(0, 100, 0), (arg_375_1.time_ - 0) / var_378_1)
				arg_375_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["6045_story"].transform.position).z)
				arg_375_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["6045_story"].transform.localEulerAngles = arg_375_1.actors_["6045_story"].transform.localEulerAngles
			end

			if arg_375_1.time_ >= 0 + var_378_1 and arg_375_1.time_ < 0 + var_378_1 + arg_378_0 then
				arg_375_1.actors_["6045_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_375_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["6045_story"].transform.position).z)
				arg_375_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["6045_story"].transform.localEulerAngles = arg_375_1.actors_["6045_story"].transform.localEulerAngles

				local var_378_2 = GameObjectTools.GetOrAddComponent(arg_375_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_378_2 then
					var_378_2:EnableDynamicBone(true)
				end
			end

			local var_378_3 = arg_375_1.actors_["6046_story"].transform

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.var_.moveOldPos6046_story = var_378_3.localPosition

				local var_378_4 = GameObjectTools.GetOrAddComponent(var_378_3.gameObject, typeof(DynamicBoneHelper))

				if var_378_4 then
					var_378_4:EnableDynamicBone(false)
				end
			end

			local var_378_5 = 0.001

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_5 then
				var_378_3.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (arg_375_1.time_ - 0) / var_378_5)
				var_378_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_378_3.position).x, (manager.ui.mainCamera.transform.position - var_378_3.position).y, (manager.ui.mainCamera.transform.position - var_378_3.position).z)
				var_378_3.localEulerAngles.z = 0
				var_378_3.localEulerAngles.x = 0
				var_378_3.localEulerAngles = var_378_3.localEulerAngles
			end

			if arg_375_1.time_ >= 0 + var_378_5 and arg_375_1.time_ < 0 + var_378_5 + arg_378_0 then
				var_378_3.localPosition = Vector3.New(0, 100, 0)
				var_378_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_378_3.position).x, (manager.ui.mainCamera.transform.position - var_378_3.position).y, (manager.ui.mainCamera.transform.position - var_378_3.position).z)
				var_378_3.localEulerAngles.z = 0
				var_378_3.localEulerAngles.x = 0
				var_378_3.localEulerAngles = var_378_3.localEulerAngles

				local var_378_6 = GameObjectTools.GetOrAddComponent(var_378_3.gameObject, typeof(DynamicBoneHelper))

				if var_378_6 then
					var_378_6:EnableDynamicBone(true)
				end
			end

			local var_378_7 = 0
			local var_378_8 = 0.575

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_7 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, false)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_9 = arg_375_1:FormatText(arg_375_1:GetWordFromCfg(1104201093).content)

				arg_375_1.text_.text = var_378_9

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_11 = 23 <= 0 and var_378_8 or var_378_8 * (utf8.len(var_378_9) / 23)

				if (23 <= 0 and var_378_8 or var_378_8 * (utf8.len(var_378_9) / 23)) > 0 and var_378_8 < var_378_11 then
					arg_375_1.talkMaxDuration = var_378_11

					if var_378_11 + var_378_7 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_11 + var_378_7
					end
				end

				arg_375_1.text_.text = var_378_9
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_12 = math.max(var_378_8, arg_375_1.talkMaxDuration)

			if var_378_7 <= arg_375_1.time_ and arg_375_1.time_ < var_378_7 + var_378_12 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_7) / var_378_12

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_7 + var_378_12 and arg_375_1.time_ < var_378_7 + var_378_12 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play1104201094 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 1104201094
		arg_379_1.duration_ = 3.27

		local var_379_0 = {
			ja = 2.166,
			ko = 3.266,
			zh = 3.266
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
				arg_379_0:Play1104201095(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(arg_379_1.actors_["6046_story"]) and arg_379_1.var_.characterEffect6046_story == nil then
				arg_379_1.var_.characterEffect6046_story = arg_379_1.actors_["6046_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_0 = 0.200000002980232

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_0 and not isNil(arg_379_1.actors_["6046_story"]) then
				if arg_379_1.var_.characterEffect6046_story and not isNil(arg_379_1.actors_["6046_story"]) then
					arg_379_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= 0 + var_382_0 and arg_379_1.time_ < 0 + var_382_0 + arg_382_0 and not isNil(arg_379_1.actors_["6046_story"]) and arg_379_1.var_.characterEffect6046_story then
				arg_379_1.var_.characterEffect6046_story.fillFlat = false
			end

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_382_2 = arg_379_1.actors_["6046_story"].transform

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.var_.moveOldPos6046_story = var_382_2.localPosition

				local var_382_3 = GameObjectTools.GetOrAddComponent(var_382_2.gameObject, typeof(DynamicBoneHelper))

				if var_382_3 then
					var_382_3:EnableDynamicBone(false)
				end
			end

			local var_382_4 = 0.001

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_4 then
				var_382_2.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos6046_story, Vector3.New(0, -0.5, -6.3), (arg_379_1.time_ - 0) / var_382_4)
				var_382_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_382_2.position).x, (manager.ui.mainCamera.transform.position - var_382_2.position).y, (manager.ui.mainCamera.transform.position - var_382_2.position).z)
				var_382_2.localEulerAngles.z = 0
				var_382_2.localEulerAngles.x = 0
				var_382_2.localEulerAngles = var_382_2.localEulerAngles
			end

			if arg_379_1.time_ >= 0 + var_382_4 and arg_379_1.time_ < 0 + var_382_4 + arg_382_0 then
				var_382_2.localPosition = Vector3.New(0, -0.5, -6.3)
				var_382_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_382_2.position).x, (manager.ui.mainCamera.transform.position - var_382_2.position).y, (manager.ui.mainCamera.transform.position - var_382_2.position).z)
				var_382_2.localEulerAngles.z = 0
				var_382_2.localEulerAngles.x = 0
				var_382_2.localEulerAngles = var_382_2.localEulerAngles

				local var_382_5 = GameObjectTools.GetOrAddComponent(var_382_2.gameObject, typeof(DynamicBoneHelper))

				if var_382_5 then
					var_382_5:EnableDynamicBone(true)
				end
			end

			local var_382_6 = 0
			local var_382_7 = 0.25

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_6 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_8 = arg_379_1:GetWordFromCfg(1104201094)
				local var_382_9 = arg_379_1:FormatText(var_382_8.content)

				arg_379_1.text_.text = var_382_9

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_11 = 10 <= 0 and var_382_7 or var_382_7 * (utf8.len(var_382_9) / 10)

				if (10 <= 0 and var_382_7 or var_382_7 * (utf8.len(var_382_9) / 10)) > 0 and var_382_7 < var_382_11 then
					arg_379_1.talkMaxDuration = var_382_11

					if var_382_11 + var_382_6 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_11 + var_382_6
					end
				end

				arg_379_1.text_.text = var_382_9
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201094", "story_v_side_new_1104201.awb") ~= 0 then
					local var_382_12 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201094", "story_v_side_new_1104201.awb") / 1000

					if var_382_12 + var_382_6 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_12 + var_382_6
					end

					if var_382_8.prefab_name ~= "" and arg_379_1.actors_[var_382_8.prefab_name] ~= nil then
						local var_382_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_8.prefab_name].transform, "story_v_side_new_1104201", "1104201094", "story_v_side_new_1104201.awb")

						arg_379_1:RecordAudio("1104201094", var_382_13)
						arg_379_1:RecordAudio("1104201094", var_382_13)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201094", "story_v_side_new_1104201.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201094", "story_v_side_new_1104201.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_14 = math.max(var_382_7, arg_379_1.talkMaxDuration)

			if var_382_6 <= arg_379_1.time_ and arg_379_1.time_ < var_382_6 + var_382_14 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_6) / var_382_14

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_6 + var_382_14 and arg_379_1.time_ < var_382_6 + var_382_14 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
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
	Play1104201095 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 1104201095
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play1104201096(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(arg_383_1.actors_["6046_story"]) and arg_383_1.var_.characterEffect6046_story == nil then
				arg_383_1.var_.characterEffect6046_story = arg_383_1.actors_["6046_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_0 = 0.200000002980232

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_0 and not isNil(arg_383_1.actors_["6046_story"]) then
				if arg_383_1.var_.characterEffect6046_story and not isNil(arg_383_1.actors_["6046_story"]) then
					arg_383_1.var_.characterEffect6046_story.fillFlat = true
					arg_383_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_383_1.time_ - 0) / var_386_0)
				end
			end

			if arg_383_1.time_ >= 0 + var_386_0 and arg_383_1.time_ < 0 + var_386_0 + arg_386_0 and not isNil(arg_383_1.actors_["6046_story"]) and arg_383_1.var_.characterEffect6046_story then
				arg_383_1.var_.characterEffect6046_story.fillFlat = true
				arg_383_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_386_1 = 0
			local var_386_2 = 0.45

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

				local var_386_3 = arg_383_1:FormatText(arg_383_1:GetWordFromCfg(1104201095).content)

				arg_383_1.text_.text = var_386_3

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_5 = 18 <= 0 and var_386_2 or var_386_2 * (utf8.len(var_386_3) / 18)

				if (18 <= 0 and var_386_2 or var_386_2 * (utf8.len(var_386_3) / 18)) > 0 and var_386_2 < var_386_5 then
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
	Play1104201096 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 1104201096
		arg_387_1.duration_ = 7.4

		local var_387_0 = {
			ja = 6.566,
			ko = 7.4,
			zh = 7.4
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
				arg_387_0:Play1104201097(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(arg_387_1.actors_["6046_story"]) and arg_387_1.var_.characterEffect6046_story == nil then
				arg_387_1.var_.characterEffect6046_story = arg_387_1.actors_["6046_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_0 = 0.200000002980232

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_0 and not isNil(arg_387_1.actors_["6046_story"]) then
				if arg_387_1.var_.characterEffect6046_story and not isNil(arg_387_1.actors_["6046_story"]) then
					arg_387_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_387_1.time_ >= 0 + var_390_0 and arg_387_1.time_ < 0 + var_390_0 + arg_390_0 and not isNil(arg_387_1.actors_["6046_story"]) and arg_387_1.var_.characterEffect6046_story then
				arg_387_1.var_.characterEffect6046_story.fillFlat = false
			end

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_390_2 = 0
			local var_390_3 = 0.725

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_2 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_4 = arg_387_1:GetWordFromCfg(1104201096)
				local var_390_5 = arg_387_1:FormatText(var_390_4.content)

				arg_387_1.text_.text = var_390_5

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_7 = 29 <= 0 and var_390_3 or var_390_3 * (utf8.len(var_390_5) / 29)

				if (29 <= 0 and var_390_3 or var_390_3 * (utf8.len(var_390_5) / 29)) > 0 and var_390_3 < var_390_7 then
					arg_387_1.talkMaxDuration = var_390_7

					if var_390_7 + var_390_2 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_7 + var_390_2
					end
				end

				arg_387_1.text_.text = var_390_5
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201096", "story_v_side_new_1104201.awb") ~= 0 then
					local var_390_8 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201096", "story_v_side_new_1104201.awb") / 1000

					if var_390_8 + var_390_2 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_8 + var_390_2
					end

					if var_390_4.prefab_name ~= "" and arg_387_1.actors_[var_390_4.prefab_name] ~= nil then
						local var_390_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_4.prefab_name].transform, "story_v_side_new_1104201", "1104201096", "story_v_side_new_1104201.awb")

						arg_387_1:RecordAudio("1104201096", var_390_9)
						arg_387_1:RecordAudio("1104201096", var_390_9)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201096", "story_v_side_new_1104201.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201096", "story_v_side_new_1104201.awb")
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
	Play1104201097 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 1104201097
		arg_391_1.duration_ = 2.07

		local var_391_0 = {
			ja = 2.066,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play1104201098(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			local var_394_0 = 0
			local var_394_1 = 0.15

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_0 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_2 = arg_391_1:GetWordFromCfg(1104201097)
				local var_394_3 = arg_391_1:FormatText(var_394_2.content)

				arg_391_1.text_.text = var_394_3

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_5 = 6 <= 0 and var_394_1 or var_394_1 * (utf8.len(var_394_3) / 6)

				if (6 <= 0 and var_394_1 or var_394_1 * (utf8.len(var_394_3) / 6)) > 0 and var_394_1 < var_394_5 then
					arg_391_1.talkMaxDuration = var_394_5

					if var_394_5 + var_394_0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_5 + var_394_0
					end
				end

				arg_391_1.text_.text = var_394_3
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201097", "story_v_side_new_1104201.awb") ~= 0 then
					local var_394_6 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201097", "story_v_side_new_1104201.awb") / 1000

					if var_394_6 + var_394_0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_6 + var_394_0
					end

					if var_394_2.prefab_name ~= "" and arg_391_1.actors_[var_394_2.prefab_name] ~= nil then
						local var_394_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_2.prefab_name].transform, "story_v_side_new_1104201", "1104201097", "story_v_side_new_1104201.awb")

						arg_391_1:RecordAudio("1104201097", var_394_7)
						arg_391_1:RecordAudio("1104201097", var_394_7)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201097", "story_v_side_new_1104201.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201097", "story_v_side_new_1104201.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_8 = math.max(var_394_1, arg_391_1.talkMaxDuration)

			if var_394_0 <= arg_391_1.time_ and arg_391_1.time_ < var_394_0 + var_394_8 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_0) / var_394_8

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_0 + var_394_8 and arg_391_1.time_ < var_394_0 + var_394_8 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play1104201098 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 1104201098
		arg_395_1.duration_ = 2.83

		local var_395_0 = {
			ja = 2.833,
			ko = 2.033,
			zh = 2.033
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
				arg_395_0:Play1104201099(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 and not isNil(arg_395_1.actors_["6046_story"]) and arg_395_1.var_.characterEffect6046_story == nil then
				arg_395_1.var_.characterEffect6046_story = arg_395_1.actors_["6046_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_0 = 0.2

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_0 and not isNil(arg_395_1.actors_["6046_story"]) then
				if arg_395_1.var_.characterEffect6046_story and not isNil(arg_395_1.actors_["6046_story"]) then
					arg_395_1.var_.characterEffect6046_story.fillFlat = true
					arg_395_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_395_1.time_ - 0) / var_398_0)
				end
			end

			if arg_395_1.time_ >= 0 + var_398_0 and arg_395_1.time_ < 0 + var_398_0 + arg_398_0 and not isNil(arg_395_1.actors_["6046_story"]) and arg_395_1.var_.characterEffect6046_story then
				arg_395_1.var_.characterEffect6046_story.fillFlat = true
				arg_395_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_398_1 = 0
			local var_398_2 = 0.1

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_1 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, true)
				arg_395_1.iconController_:SetSelectedState("hero")

				arg_395_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6045")

				arg_395_1.callingController_:SetSelectedState("normal")

				arg_395_1.keyicon_.color = Color.New(1, 1, 1)
				arg_395_1.icon_.color = Color.New(1, 1, 1)

				local var_398_3 = arg_395_1:GetWordFromCfg(1104201098)
				local var_398_4 = arg_395_1:FormatText(var_398_3.content)

				arg_395_1.text_.text = var_398_4

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_6 = 4 <= 0 and var_398_2 or var_398_2 * (utf8.len(var_398_4) / 4)

				if (4 <= 0 and var_398_2 or var_398_2 * (utf8.len(var_398_4) / 4)) > 0 and var_398_2 < var_398_6 then
					arg_395_1.talkMaxDuration = var_398_6

					if var_398_6 + var_398_1 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_6 + var_398_1
					end
				end

				arg_395_1.text_.text = var_398_4
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201098", "story_v_side_new_1104201.awb") ~= 0 then
					local var_398_7 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201098", "story_v_side_new_1104201.awb") / 1000

					if var_398_7 + var_398_1 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_7 + var_398_1
					end

					if var_398_3.prefab_name ~= "" and arg_395_1.actors_[var_398_3.prefab_name] ~= nil then
						local var_398_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_3.prefab_name].transform, "story_v_side_new_1104201", "1104201098", "story_v_side_new_1104201.awb")

						arg_395_1:RecordAudio("1104201098", var_398_8)
						arg_395_1:RecordAudio("1104201098", var_398_8)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201098", "story_v_side_new_1104201.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201098", "story_v_side_new_1104201.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_9 = math.max(var_398_2, arg_395_1.talkMaxDuration)

			if var_398_1 <= arg_395_1.time_ and arg_395_1.time_ < var_398_1 + var_398_9 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_1) / var_398_9

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_1 + var_398_9 and arg_395_1.time_ < var_398_1 + var_398_9 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play1104201099 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 1104201099
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play1104201100(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = 0.575

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
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

				local var_402_1 = arg_399_1:FormatText(arg_399_1:GetWordFromCfg(1104201099).content)

				arg_399_1.text_.text = var_402_1

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_3 = 23 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_1) / 23)

				if (23 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_1) / 23)) > 0 and var_402_0 < var_402_3 then
					arg_399_1.talkMaxDuration = var_402_3

					if var_402_3 + 0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_3 + 0
					end
				end

				arg_399_1.text_.text = var_402_1
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_4 = math.max(var_402_0, arg_399_1.talkMaxDuration)

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_4 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - 0) / var_402_4

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= 0 + var_402_4 and arg_399_1.time_ < 0 + var_402_4 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play1104201100 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 1104201100
		arg_403_1.duration_ = 5

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play1104201101(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.var_.moveOldPos6046_story = arg_403_1.actors_["6046_story"].transform.localPosition

				local var_406_0 = GameObjectTools.GetOrAddComponent(arg_403_1.actors_["6046_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_406_0 then
					var_406_0:EnableDynamicBone(false)
				end
			end

			local var_406_1 = 0.001

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_1 then
				arg_403_1.actors_["6046_story"].transform.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (arg_403_1.time_ - 0) / var_406_1)
				arg_403_1.actors_["6046_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_403_1.actors_["6046_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["6046_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["6046_story"].transform.position).z)
				arg_403_1.actors_["6046_story"].transform.localEulerAngles.z = 0
				arg_403_1.actors_["6046_story"].transform.localEulerAngles.x = 0
				arg_403_1.actors_["6046_story"].transform.localEulerAngles = arg_403_1.actors_["6046_story"].transform.localEulerAngles
			end

			if arg_403_1.time_ >= 0 + var_406_1 and arg_403_1.time_ < 0 + var_406_1 + arg_406_0 then
				arg_403_1.actors_["6046_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_403_1.actors_["6046_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_403_1.actors_["6046_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["6046_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["6046_story"].transform.position).z)
				arg_403_1.actors_["6046_story"].transform.localEulerAngles.z = 0
				arg_403_1.actors_["6046_story"].transform.localEulerAngles.x = 0
				arg_403_1.actors_["6046_story"].transform.localEulerAngles = arg_403_1.actors_["6046_story"].transform.localEulerAngles

				local var_406_2 = GameObjectTools.GetOrAddComponent(arg_403_1.actors_["6046_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_406_2 then
					var_406_2:EnableDynamicBone(true)
				end
			end

			local var_406_3 = 0
			local var_406_4 = 0.775

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

				local var_406_5 = arg_403_1:FormatText(arg_403_1:GetWordFromCfg(1104201100).content)

				arg_403_1.text_.text = var_406_5

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_7 = 31 <= 0 and var_406_4 or var_406_4 * (utf8.len(var_406_5) / 31)

				if (31 <= 0 and var_406_4 or var_406_4 * (utf8.len(var_406_5) / 31)) > 0 and var_406_4 < var_406_7 then
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
				actorName = "6046_story",
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
	Play1104201101 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 1104201101
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play1104201102(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = 0.5

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, true)
				arg_407_1.iconController_:SetSelectedState("hero")

				arg_407_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_407_1.callingController_:SetSelectedState("normal")

				arg_407_1.keyicon_.color = Color.New(1, 1, 1)
				arg_407_1.icon_.color = Color.New(1, 1, 1)

				local var_410_1 = arg_407_1:FormatText(arg_407_1:GetWordFromCfg(1104201101).content)

				arg_407_1.text_.text = var_410_1

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_3 = 20 <= 0 and var_410_0 or var_410_0 * (utf8.len(var_410_1) / 20)

				if (20 <= 0 and var_410_0 or var_410_0 * (utf8.len(var_410_1) / 20)) > 0 and var_410_0 < var_410_3 then
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
	Play1104201102 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 1104201102
		arg_411_1.duration_ = 12.13

		local var_411_0 = {
			ja = 8.933,
			ko = 12.133,
			zh = 12.133
		}
		local var_411_1 = manager.audio:GetLocalizationFlag()

		if var_411_0[var_411_1] ~= nil then
			arg_411_1.duration_ = var_411_0[var_411_1]
		end

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play1104201103(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.var_.moveOldPos6045_story = arg_411_1.actors_["6045_story"].transform.localPosition

				local var_414_0 = GameObjectTools.GetOrAddComponent(arg_411_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_414_0 then
					var_414_0:EnableDynamicBone(false)
				end
			end

			local var_414_1 = 0.001

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_1 then
				arg_411_1.actors_["6045_story"].transform.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos6045_story, Vector3.New(-0.7, -0.5, -6.3), (arg_411_1.time_ - 0) / var_414_1)
				arg_411_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_411_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["6045_story"].transform.position).z)
				arg_411_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_411_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_411_1.actors_["6045_story"].transform.localEulerAngles = arg_411_1.actors_["6045_story"].transform.localEulerAngles
			end

			if arg_411_1.time_ >= 0 + var_414_1 and arg_411_1.time_ < 0 + var_414_1 + arg_414_0 then
				arg_411_1.actors_["6045_story"].transform.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				arg_411_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_411_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["6045_story"].transform.position).z)
				arg_411_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_411_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_411_1.actors_["6045_story"].transform.localEulerAngles = arg_411_1.actors_["6045_story"].transform.localEulerAngles

				local var_414_2 = GameObjectTools.GetOrAddComponent(arg_411_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_414_2 then
					var_414_2:EnableDynamicBone(true)
				end
			end

			local var_414_3 = arg_411_1.actors_["6045_story"]

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 and not isNil(var_414_3) and arg_411_1.var_.characterEffect6045_story == nil then
				arg_411_1.var_.characterEffect6045_story = var_414_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_4 = 0.200000002980232

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_4 and not isNil(var_414_3) then
				if arg_411_1.var_.characterEffect6045_story and not isNil(var_414_3) then
					arg_411_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_411_1.time_ >= 0 + var_414_4 and arg_411_1.time_ < 0 + var_414_4 + arg_414_0 and not isNil(var_414_3) and arg_411_1.var_.characterEffect6045_story then
				arg_411_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_414_6 = arg_411_1.actors_["6046_story"].transform

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.var_.moveOldPos6046_story = var_414_6.localPosition

				local var_414_7 = GameObjectTools.GetOrAddComponent(var_414_6.gameObject, typeof(DynamicBoneHelper))

				if var_414_7 then
					var_414_7:EnableDynamicBone(false)
				end
			end

			local var_414_8 = 0.001

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_8 then
				var_414_6.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos6046_story, Vector3.New(0.7, -0.5, -6.3), (arg_411_1.time_ - 0) / var_414_8)
				var_414_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_414_6.position).x, (manager.ui.mainCamera.transform.position - var_414_6.position).y, (manager.ui.mainCamera.transform.position - var_414_6.position).z)
				var_414_6.localEulerAngles.z = 0
				var_414_6.localEulerAngles.x = 0
				var_414_6.localEulerAngles = var_414_6.localEulerAngles
			end

			if arg_411_1.time_ >= 0 + var_414_8 and arg_411_1.time_ < 0 + var_414_8 + arg_414_0 then
				var_414_6.localPosition = Vector3.New(0.7, -0.5, -6.3)
				var_414_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_414_6.position).x, (manager.ui.mainCamera.transform.position - var_414_6.position).y, (manager.ui.mainCamera.transform.position - var_414_6.position).z)
				var_414_6.localEulerAngles.z = 0
				var_414_6.localEulerAngles.x = 0
				var_414_6.localEulerAngles = var_414_6.localEulerAngles

				local var_414_9 = GameObjectTools.GetOrAddComponent(var_414_6.gameObject, typeof(DynamicBoneHelper))

				if var_414_9 then
					var_414_9:EnableDynamicBone(true)
				end
			end

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_414_10 = 0
			local var_414_11 = 1.05

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_10 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_12 = arg_411_1:GetWordFromCfg(1104201102)
				local var_414_13 = arg_411_1:FormatText(var_414_12.content)

				arg_411_1.text_.text = var_414_13

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_15 = 42 <= 0 and var_414_11 or var_414_11 * (utf8.len(var_414_13) / 42)

				if (42 <= 0 and var_414_11 or var_414_11 * (utf8.len(var_414_13) / 42)) > 0 and var_414_11 < var_414_15 then
					arg_411_1.talkMaxDuration = var_414_15

					if var_414_15 + var_414_10 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_15 + var_414_10
					end
				end

				arg_411_1.text_.text = var_414_13
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201102", "story_v_side_new_1104201.awb") ~= 0 then
					local var_414_16 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201102", "story_v_side_new_1104201.awb") / 1000

					if var_414_16 + var_414_10 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_16 + var_414_10
					end

					if var_414_12.prefab_name ~= "" and arg_411_1.actors_[var_414_12.prefab_name] ~= nil then
						local var_414_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_12.prefab_name].transform, "story_v_side_new_1104201", "1104201102", "story_v_side_new_1104201.awb")

						arg_411_1:RecordAudio("1104201102", var_414_17)
						arg_411_1:RecordAudio("1104201102", var_414_17)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201102", "story_v_side_new_1104201.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201102", "story_v_side_new_1104201.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_18 = math.max(var_414_11, arg_411_1.talkMaxDuration)

			if var_414_10 <= arg_411_1.time_ and arg_411_1.time_ < var_414_10 + var_414_18 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_10) / var_414_18

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_10 + var_414_18 and arg_411_1.time_ < var_414_10 + var_414_18 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
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
	Play1104201103 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 1104201103
		arg_415_1.duration_ = 5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play1104201104(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 and not isNil(arg_415_1.actors_["6045_story"]) and arg_415_1.var_.characterEffect6045_story == nil then
				arg_415_1.var_.characterEffect6045_story = arg_415_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_0 = 0.200000002980232

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_0 and not isNil(arg_415_1.actors_["6045_story"]) then
				if arg_415_1.var_.characterEffect6045_story and not isNil(arg_415_1.actors_["6045_story"]) then
					arg_415_1.var_.characterEffect6045_story.fillFlat = true
					arg_415_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_415_1.time_ - 0) / var_418_0)
				end
			end

			if arg_415_1.time_ >= 0 + var_418_0 and arg_415_1.time_ < 0 + var_418_0 + arg_418_0 and not isNil(arg_415_1.actors_["6045_story"]) and arg_415_1.var_.characterEffect6045_story then
				arg_415_1.var_.characterEffect6045_story.fillFlat = true
				arg_415_1.var_.characterEffect6045_story.fillRatio = 0.5
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

				local var_418_3 = arg_415_1:FormatText(arg_415_1:GetWordFromCfg(1104201103).content)

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
	Play1104201104 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 1104201104
		arg_419_1.duration_ = 12.2

		local var_419_0 = {
			ja = 11.5,
			ko = 12.2,
			zh = 12.2
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
				arg_419_0:Play1104201105(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 and not isNil(arg_419_1.actors_["6046_story"]) and arg_419_1.var_.characterEffect6046_story == nil then
				arg_419_1.var_.characterEffect6046_story = arg_419_1.actors_["6046_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_0 = 0.200000002980232

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_0 and not isNil(arg_419_1.actors_["6046_story"]) then
				if arg_419_1.var_.characterEffect6046_story and not isNil(arg_419_1.actors_["6046_story"]) then
					arg_419_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_419_1.time_ >= 0 + var_422_0 and arg_419_1.time_ < 0 + var_422_0 + arg_422_0 and not isNil(arg_419_1.actors_["6046_story"]) and arg_419_1.var_.characterEffect6046_story then
				arg_419_1.var_.characterEffect6046_story.fillFlat = false
			end

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_422_2 = 0
			local var_422_3 = 1.15

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_2 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_4 = arg_419_1:GetWordFromCfg(1104201104)
				local var_422_5 = arg_419_1:FormatText(var_422_4.content)

				arg_419_1.text_.text = var_422_5

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_7 = 46 <= 0 and var_422_3 or var_422_3 * (utf8.len(var_422_5) / 46)

				if (46 <= 0 and var_422_3 or var_422_3 * (utf8.len(var_422_5) / 46)) > 0 and var_422_3 < var_422_7 then
					arg_419_1.talkMaxDuration = var_422_7

					if var_422_7 + var_422_2 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_7 + var_422_2
					end
				end

				arg_419_1.text_.text = var_422_5
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201104", "story_v_side_new_1104201.awb") ~= 0 then
					local var_422_8 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201104", "story_v_side_new_1104201.awb") / 1000

					if var_422_8 + var_422_2 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_8 + var_422_2
					end

					if var_422_4.prefab_name ~= "" and arg_419_1.actors_[var_422_4.prefab_name] ~= nil then
						local var_422_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_4.prefab_name].transform, "story_v_side_new_1104201", "1104201104", "story_v_side_new_1104201.awb")

						arg_419_1:RecordAudio("1104201104", var_422_9)
						arg_419_1:RecordAudio("1104201104", var_422_9)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201104", "story_v_side_new_1104201.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201104", "story_v_side_new_1104201.awb")
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
	Play1104201105 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 1104201105
		arg_423_1.duration_ = 13.1

		local var_423_0 = {
			ja = 13.1,
			ko = 12.4,
			zh = 12.4
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
				arg_423_0:Play1104201106(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(arg_423_1.actors_["6045_story"]) and arg_423_1.var_.characterEffect6045_story == nil then
				arg_423_1.var_.characterEffect6045_story = arg_423_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_0 = 0.200000002980232

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_0 and not isNil(arg_423_1.actors_["6045_story"]) then
				if arg_423_1.var_.characterEffect6045_story and not isNil(arg_423_1.actors_["6045_story"]) then
					arg_423_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_423_1.time_ >= 0 + var_426_0 and arg_423_1.time_ < 0 + var_426_0 + arg_426_0 and not isNil(arg_423_1.actors_["6045_story"]) and arg_423_1.var_.characterEffect6045_story then
				arg_423_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_1")
			end

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_426_2 = arg_423_1.actors_["6046_story"]

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(var_426_2) and arg_423_1.var_.characterEffect6046_story == nil then
				arg_423_1.var_.characterEffect6046_story = var_426_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_3 = 0.200000002980232

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_3 and not isNil(var_426_2) then
				if arg_423_1.var_.characterEffect6046_story and not isNil(var_426_2) then
					arg_423_1.var_.characterEffect6046_story.fillFlat = true
					arg_423_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_423_1.time_ - 0) / var_426_3)
				end
			end

			if arg_423_1.time_ >= 0 + var_426_3 and arg_423_1.time_ < 0 + var_426_3 + arg_426_0 and not isNil(var_426_2) and arg_423_1.var_.characterEffect6046_story then
				arg_423_1.var_.characterEffect6046_story.fillFlat = true
				arg_423_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_426_4 = 0
			local var_426_5 = 1.05

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_4 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_6 = arg_423_1:GetWordFromCfg(1104201105)
				local var_426_7 = arg_423_1:FormatText(var_426_6.content)

				arg_423_1.text_.text = var_426_7

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_9 = 42 <= 0 and var_426_5 or var_426_5 * (utf8.len(var_426_7) / 42)

				if (42 <= 0 and var_426_5 or var_426_5 * (utf8.len(var_426_7) / 42)) > 0 and var_426_5 < var_426_9 then
					arg_423_1.talkMaxDuration = var_426_9

					if var_426_9 + var_426_4 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_9 + var_426_4
					end
				end

				arg_423_1.text_.text = var_426_7
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201105", "story_v_side_new_1104201.awb") ~= 0 then
					local var_426_10 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201105", "story_v_side_new_1104201.awb") / 1000

					if var_426_10 + var_426_4 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_10 + var_426_4
					end

					if var_426_6.prefab_name ~= "" and arg_423_1.actors_[var_426_6.prefab_name] ~= nil then
						local var_426_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_6.prefab_name].transform, "story_v_side_new_1104201", "1104201105", "story_v_side_new_1104201.awb")

						arg_423_1:RecordAudio("1104201105", var_426_11)
						arg_423_1:RecordAudio("1104201105", var_426_11)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201105", "story_v_side_new_1104201.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201105", "story_v_side_new_1104201.awb")
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
	Play1104201106 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 1104201106
		arg_427_1.duration_ = 9.73

		local var_427_0 = {
			ja = 5.733,
			ko = 9.733,
			zh = 9.733
		}
		local var_427_1 = manager.audio:GetLocalizationFlag()

		if var_427_0[var_427_1] ~= nil then
			arg_427_1.duration_ = var_427_0[var_427_1]
		end

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play1104201107(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(arg_427_1.actors_["6046_story"]) and arg_427_1.var_.characterEffect6046_story == nil then
				arg_427_1.var_.characterEffect6046_story = arg_427_1.actors_["6046_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_0 = 0.200000002980232

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_0 and not isNil(arg_427_1.actors_["6046_story"]) then
				if arg_427_1.var_.characterEffect6046_story and not isNil(arg_427_1.actors_["6046_story"]) then
					arg_427_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_427_1.time_ >= 0 + var_430_0 and arg_427_1.time_ < 0 + var_430_0 + arg_430_0 and not isNil(arg_427_1.actors_["6046_story"]) and arg_427_1.var_.characterEffect6046_story then
				arg_427_1.var_.characterEffect6046_story.fillFlat = false
			end

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_430_2 = arg_427_1.actors_["6045_story"]

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(var_430_2) and arg_427_1.var_.characterEffect6045_story == nil then
				arg_427_1.var_.characterEffect6045_story = var_430_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_3 = 0.200000002980232

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_3 and not isNil(var_430_2) then
				if arg_427_1.var_.characterEffect6045_story and not isNil(var_430_2) then
					arg_427_1.var_.characterEffect6045_story.fillFlat = true
					arg_427_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_427_1.time_ - 0) / var_430_3)
				end
			end

			if arg_427_1.time_ >= 0 + var_430_3 and arg_427_1.time_ < 0 + var_430_3 + arg_430_0 and not isNil(var_430_2) and arg_427_1.var_.characterEffect6045_story then
				arg_427_1.var_.characterEffect6045_story.fillFlat = true
				arg_427_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_430_4 = 0
			local var_430_5 = 0.9

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_4 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_6 = arg_427_1:GetWordFromCfg(1104201106)
				local var_430_7 = arg_427_1:FormatText(var_430_6.content)

				arg_427_1.text_.text = var_430_7

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_9 = 36 <= 0 and var_430_5 or var_430_5 * (utf8.len(var_430_7) / 36)

				if (36 <= 0 and var_430_5 or var_430_5 * (utf8.len(var_430_7) / 36)) > 0 and var_430_5 < var_430_9 then
					arg_427_1.talkMaxDuration = var_430_9

					if var_430_9 + var_430_4 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_9 + var_430_4
					end
				end

				arg_427_1.text_.text = var_430_7
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201106", "story_v_side_new_1104201.awb") ~= 0 then
					local var_430_10 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201106", "story_v_side_new_1104201.awb") / 1000

					if var_430_10 + var_430_4 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_10 + var_430_4
					end

					if var_430_6.prefab_name ~= "" and arg_427_1.actors_[var_430_6.prefab_name] ~= nil then
						local var_430_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_6.prefab_name].transform, "story_v_side_new_1104201", "1104201106", "story_v_side_new_1104201.awb")

						arg_427_1:RecordAudio("1104201106", var_430_11)
						arg_427_1:RecordAudio("1104201106", var_430_11)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201106", "story_v_side_new_1104201.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201106", "story_v_side_new_1104201.awb")
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

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play1104201107 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 1104201107
		arg_431_1.duration_ = 5.67

		local var_431_0 = {
			ja = 1.999999999999,
			ko = 5.666,
			zh = 5.666
		}
		local var_431_1 = manager.audio:GetLocalizationFlag()

		if var_431_0[var_431_1] ~= nil then
			arg_431_1.duration_ = var_431_0[var_431_1]
		end

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play1104201108(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 and not isNil(arg_431_1.actors_["6045_story"]) and arg_431_1.var_.characterEffect6045_story == nil then
				arg_431_1.var_.characterEffect6045_story = arg_431_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_0 = 0.200000002980232

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_0 and not isNil(arg_431_1.actors_["6045_story"]) then
				if arg_431_1.var_.characterEffect6045_story and not isNil(arg_431_1.actors_["6045_story"]) then
					arg_431_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_431_1.time_ >= 0 + var_434_0 and arg_431_1.time_ < 0 + var_434_0 + arg_434_0 and not isNil(arg_431_1.actors_["6045_story"]) and arg_431_1.var_.characterEffect6045_story then
				arg_431_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_2")
			end

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_434_2 = arg_431_1.actors_["6046_story"]

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 and not isNil(var_434_2) and arg_431_1.var_.characterEffect6046_story == nil then
				arg_431_1.var_.characterEffect6046_story = var_434_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_3 = 0.200000002980232

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_3 and not isNil(var_434_2) then
				if arg_431_1.var_.characterEffect6046_story and not isNil(var_434_2) then
					arg_431_1.var_.characterEffect6046_story.fillFlat = true
					arg_431_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_431_1.time_ - 0) / var_434_3)
				end
			end

			if arg_431_1.time_ >= 0 + var_434_3 and arg_431_1.time_ < 0 + var_434_3 + arg_434_0 and not isNil(var_434_2) and arg_431_1.var_.characterEffect6046_story then
				arg_431_1.var_.characterEffect6046_story.fillFlat = true
				arg_431_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_434_4 = 0
			local var_434_5 = 0.375

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_4 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				arg_431_1.leftNameTxt_.text = arg_431_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_6 = arg_431_1:GetWordFromCfg(1104201107)
				local var_434_7 = arg_431_1:FormatText(var_434_6.content)

				arg_431_1.text_.text = var_434_7

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_9 = 15 <= 0 and var_434_5 or var_434_5 * (utf8.len(var_434_7) / 15)

				if (15 <= 0 and var_434_5 or var_434_5 * (utf8.len(var_434_7) / 15)) > 0 and var_434_5 < var_434_9 then
					arg_431_1.talkMaxDuration = var_434_9

					if var_434_9 + var_434_4 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_9 + var_434_4
					end
				end

				arg_431_1.text_.text = var_434_7
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201107", "story_v_side_new_1104201.awb") ~= 0 then
					local var_434_10 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201107", "story_v_side_new_1104201.awb") / 1000

					if var_434_10 + var_434_4 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_10 + var_434_4
					end

					if var_434_6.prefab_name ~= "" and arg_431_1.actors_[var_434_6.prefab_name] ~= nil then
						local var_434_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_6.prefab_name].transform, "story_v_side_new_1104201", "1104201107", "story_v_side_new_1104201.awb")

						arg_431_1:RecordAudio("1104201107", var_434_11)
						arg_431_1:RecordAudio("1104201107", var_434_11)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201107", "story_v_side_new_1104201.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201107", "story_v_side_new_1104201.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_12 = math.max(var_434_5, arg_431_1.talkMaxDuration)

			if var_434_4 <= arg_431_1.time_ and arg_431_1.time_ < var_434_4 + var_434_12 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_4) / var_434_12

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_4 + var_434_12 and arg_431_1.time_ < var_434_4 + var_434_12 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play1104201108 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 1104201108
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play1104201109(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(arg_435_1.actors_["6045_story"]) and arg_435_1.var_.characterEffect6045_story == nil then
				arg_435_1.var_.characterEffect6045_story = arg_435_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_0 = 0.200000002980232

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_0 and not isNil(arg_435_1.actors_["6045_story"]) then
				if arg_435_1.var_.characterEffect6045_story and not isNil(arg_435_1.actors_["6045_story"]) then
					arg_435_1.var_.characterEffect6045_story.fillFlat = true
					arg_435_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_435_1.time_ - 0) / var_438_0)
				end
			end

			if arg_435_1.time_ >= 0 + var_438_0 and arg_435_1.time_ < 0 + var_438_0 + arg_438_0 and not isNil(arg_435_1.actors_["6045_story"]) and arg_435_1.var_.characterEffect6045_story then
				arg_435_1.var_.characterEffect6045_story.fillFlat = true
				arg_435_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_2")
			end

			local var_438_1 = 0
			local var_438_2 = 0.65

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_1 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				arg_435_1.leftNameTxt_.text = arg_435_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, true)
				arg_435_1.iconController_:SetSelectedState("hero")

				arg_435_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_435_1.callingController_:SetSelectedState("normal")

				arg_435_1.keyicon_.color = Color.New(1, 1, 1)
				arg_435_1.icon_.color = Color.New(1, 1, 1)

				local var_438_3 = arg_435_1:FormatText(arg_435_1:GetWordFromCfg(1104201108).content)

				arg_435_1.text_.text = var_438_3

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_5 = 26 <= 0 and var_438_2 or var_438_2 * (utf8.len(var_438_3) / 26)

				if (26 <= 0 and var_438_2 or var_438_2 * (utf8.len(var_438_3) / 26)) > 0 and var_438_2 < var_438_5 then
					arg_435_1.talkMaxDuration = var_438_5

					if var_438_5 + var_438_1 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_5 + var_438_1
					end
				end

				arg_435_1.text_.text = var_438_3
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_6 = math.max(var_438_2, arg_435_1.talkMaxDuration)

			if var_438_1 <= arg_435_1.time_ and arg_435_1.time_ < var_438_1 + var_438_6 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_1) / var_438_6

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_1 + var_438_6 and arg_435_1.time_ < var_438_1 + var_438_6 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play1104201109 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 1104201109
		arg_439_1.duration_ = 7.67

		local var_439_0 = {
			ja = 7.6,
			ko = 7.666,
			zh = 7.666
		}
		local var_439_1 = manager.audio:GetLocalizationFlag()

		if var_439_0[var_439_1] ~= nil then
			arg_439_1.duration_ = var_439_0[var_439_1]
		end

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play1104201110(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 and not isNil(arg_439_1.actors_["6046_story"]) and arg_439_1.var_.characterEffect6046_story == nil then
				arg_439_1.var_.characterEffect6046_story = arg_439_1.actors_["6046_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_442_0 = 0.200000002980232

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_0 and not isNil(arg_439_1.actors_["6046_story"]) then
				if arg_439_1.var_.characterEffect6046_story and not isNil(arg_439_1.actors_["6046_story"]) then
					arg_439_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_439_1.time_ >= 0 + var_442_0 and arg_439_1.time_ < 0 + var_442_0 + arg_442_0 and not isNil(arg_439_1.actors_["6046_story"]) and arg_439_1.var_.characterEffect6046_story then
				arg_439_1.var_.characterEffect6046_story.fillFlat = false
			end

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_442_2 = 0
			local var_442_3 = 0.675

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_2 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				arg_439_1.leftNameTxt_.text = arg_439_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_4 = arg_439_1:GetWordFromCfg(1104201109)
				local var_442_5 = arg_439_1:FormatText(var_442_4.content)

				arg_439_1.text_.text = var_442_5

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_7 = 27 <= 0 and var_442_3 or var_442_3 * (utf8.len(var_442_5) / 27)

				if (27 <= 0 and var_442_3 or var_442_3 * (utf8.len(var_442_5) / 27)) > 0 and var_442_3 < var_442_7 then
					arg_439_1.talkMaxDuration = var_442_7

					if var_442_7 + var_442_2 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_7 + var_442_2
					end
				end

				arg_439_1.text_.text = var_442_5
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201109", "story_v_side_new_1104201.awb") ~= 0 then
					local var_442_8 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201109", "story_v_side_new_1104201.awb") / 1000

					if var_442_8 + var_442_2 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_8 + var_442_2
					end

					if var_442_4.prefab_name ~= "" and arg_439_1.actors_[var_442_4.prefab_name] ~= nil then
						local var_442_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_4.prefab_name].transform, "story_v_side_new_1104201", "1104201109", "story_v_side_new_1104201.awb")

						arg_439_1:RecordAudio("1104201109", var_442_9)
						arg_439_1:RecordAudio("1104201109", var_442_9)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201109", "story_v_side_new_1104201.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201109", "story_v_side_new_1104201.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_10 = math.max(var_442_3, arg_439_1.talkMaxDuration)

			if var_442_2 <= arg_439_1.time_ and arg_439_1.time_ < var_442_2 + var_442_10 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_2) / var_442_10

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_2 + var_442_10 and arg_439_1.time_ < var_442_2 + var_442_10 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play1104201110 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 1104201110
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play1104201111(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 and not isNil(arg_443_1.actors_["6046_story"]) and arg_443_1.var_.characterEffect6046_story == nil then
				arg_443_1.var_.characterEffect6046_story = arg_443_1.actors_["6046_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_446_0 = 0.200000002980232

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_0 and not isNil(arg_443_1.actors_["6046_story"]) then
				if arg_443_1.var_.characterEffect6046_story and not isNil(arg_443_1.actors_["6046_story"]) then
					arg_443_1.var_.characterEffect6046_story.fillFlat = true
					arg_443_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_443_1.time_ - 0) / var_446_0)
				end
			end

			if arg_443_1.time_ >= 0 + var_446_0 and arg_443_1.time_ < 0 + var_446_0 + arg_446_0 and not isNil(arg_443_1.actors_["6046_story"]) and arg_443_1.var_.characterEffect6046_story then
				arg_443_1.var_.characterEffect6046_story.fillFlat = true
				arg_443_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_446_1 = 0
			local var_446_2 = 0.275

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_1 + arg_446_0 then
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

				local var_446_3 = arg_443_1:FormatText(arg_443_1:GetWordFromCfg(1104201110).content)

				arg_443_1.text_.text = var_446_3

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_5 = 11 <= 0 and var_446_2 or var_446_2 * (utf8.len(var_446_3) / 11)

				if (11 <= 0 and var_446_2 or var_446_2 * (utf8.len(var_446_3) / 11)) > 0 and var_446_2 < var_446_5 then
					arg_443_1.talkMaxDuration = var_446_5

					if var_446_5 + var_446_1 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_5 + var_446_1
					end
				end

				arg_443_1.text_.text = var_446_3
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)
				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_6 = math.max(var_446_2, arg_443_1.talkMaxDuration)

			if var_446_1 <= arg_443_1.time_ and arg_443_1.time_ < var_446_1 + var_446_6 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_1) / var_446_6

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_1 + var_446_6 and arg_443_1.time_ < var_446_1 + var_446_6 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play1104201111 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 1104201111
		arg_447_1.duration_ = 5

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play1104201112(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = 0.4

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

				local var_450_1 = arg_447_1:FormatText(arg_447_1:GetWordFromCfg(1104201111).content)

				arg_447_1.text_.text = var_450_1

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_3 = 16 <= 0 and var_450_0 or var_450_0 * (utf8.len(var_450_1) / 16)

				if (16 <= 0 and var_450_0 or var_450_0 * (utf8.len(var_450_1) / 16)) > 0 and var_450_0 < var_450_3 then
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
	Play1104201112 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 1104201112
		arg_451_1.duration_ = 4.77

		local var_451_0 = {
			ja = 4.766,
			ko = 3.833,
			zh = 3.833
		}
		local var_451_1 = manager.audio:GetLocalizationFlag()

		if var_451_0[var_451_1] ~= nil then
			arg_451_1.duration_ = var_451_0[var_451_1]
		end

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play1104201113(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1.var_.moveOldPos6045_story = arg_451_1.actors_["6045_story"].transform.localPosition

				local var_454_0 = GameObjectTools.GetOrAddComponent(arg_451_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_454_0 then
					var_454_0:EnableDynamicBone(false)
				end
			end

			local var_454_1 = 0.001

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_1 then
				arg_451_1.actors_["6045_story"].transform.localPosition = Vector3.Lerp(arg_451_1.var_.moveOldPos6045_story, Vector3.New(-0.7, -0.5, -6.3), (arg_451_1.time_ - 0) / var_454_1)
				arg_451_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_451_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_451_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_451_1.actors_["6045_story"].transform.position).z)
				arg_451_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_451_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_451_1.actors_["6045_story"].transform.localEulerAngles = arg_451_1.actors_["6045_story"].transform.localEulerAngles
			end

			if arg_451_1.time_ >= 0 + var_454_1 and arg_451_1.time_ < 0 + var_454_1 + arg_454_0 then
				arg_451_1.actors_["6045_story"].transform.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				arg_451_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_451_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_451_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_451_1.actors_["6045_story"].transform.position).z)
				arg_451_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_451_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_451_1.actors_["6045_story"].transform.localEulerAngles = arg_451_1.actors_["6045_story"].transform.localEulerAngles

				local var_454_2 = GameObjectTools.GetOrAddComponent(arg_451_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_454_2 then
					var_454_2:EnableDynamicBone(true)
				end
			end

			local var_454_3 = arg_451_1.actors_["6045_story"]

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 and not isNil(var_454_3) and arg_451_1.var_.characterEffect6045_story == nil then
				arg_451_1.var_.characterEffect6045_story = var_454_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_4 = 0.200000002980232

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_4 and not isNil(var_454_3) then
				if arg_451_1.var_.characterEffect6045_story and not isNil(var_454_3) then
					arg_451_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_451_1.time_ >= 0 + var_454_4 and arg_451_1.time_ < 0 + var_454_4 + arg_454_0 and not isNil(var_454_3) and arg_451_1.var_.characterEffect6045_story then
				arg_451_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action2_1")
			end

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_454_6 = 0
			local var_454_7 = 0.3

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_6 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				arg_451_1.leftNameTxt_.text = arg_451_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_8 = arg_451_1:GetWordFromCfg(1104201112)
				local var_454_9 = arg_451_1:FormatText(var_454_8.content)

				arg_451_1.text_.text = var_454_9

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_11 = 12 <= 0 and var_454_7 or var_454_7 * (utf8.len(var_454_9) / 12)

				if (12 <= 0 and var_454_7 or var_454_7 * (utf8.len(var_454_9) / 12)) > 0 and var_454_7 < var_454_11 then
					arg_451_1.talkMaxDuration = var_454_11

					if var_454_11 + var_454_6 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_11 + var_454_6
					end
				end

				arg_451_1.text_.text = var_454_9
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201112", "story_v_side_new_1104201.awb") ~= 0 then
					local var_454_12 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201112", "story_v_side_new_1104201.awb") / 1000

					if var_454_12 + var_454_6 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_12 + var_454_6
					end

					if var_454_8.prefab_name ~= "" and arg_451_1.actors_[var_454_8.prefab_name] ~= nil then
						local var_454_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_8.prefab_name].transform, "story_v_side_new_1104201", "1104201112", "story_v_side_new_1104201.awb")

						arg_451_1:RecordAudio("1104201112", var_454_13)
						arg_451_1:RecordAudio("1104201112", var_454_13)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201112", "story_v_side_new_1104201.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201112", "story_v_side_new_1104201.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_14 = math.max(var_454_7, arg_451_1.talkMaxDuration)

			if var_454_6 <= arg_451_1.time_ and arg_451_1.time_ < var_454_6 + var_454_14 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_6) / var_454_14

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_6 + var_454_14 and arg_451_1.time_ < var_454_6 + var_454_14 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_451_1:InitPlayNodeList()
	end,
	Play1104201113 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 1104201113
		arg_455_1.duration_ = 10.4

		local var_455_0 = {
			ja = 10.2,
			ko = 10.4,
			zh = 10.4
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
				arg_455_0:Play1104201114(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = 0.875

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				arg_455_1.leftNameTxt_.text = arg_455_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_1 = arg_455_1:GetWordFromCfg(1104201113)
				local var_458_2 = arg_455_1:FormatText(var_458_1.content)

				arg_455_1.text_.text = var_458_2

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_4 = 35 <= 0 and var_458_0 or var_458_0 * (utf8.len(var_458_2) / 35)

				if (35 <= 0 and var_458_0 or var_458_0 * (utf8.len(var_458_2) / 35)) > 0 and var_458_0 < var_458_4 then
					arg_455_1.talkMaxDuration = var_458_4

					if var_458_4 + 0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_4 + 0
					end
				end

				arg_455_1.text_.text = var_458_2
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201113", "story_v_side_new_1104201.awb") ~= 0 then
					local var_458_5 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201113", "story_v_side_new_1104201.awb") / 1000

					if var_458_5 + 0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_5 + 0
					end

					if var_458_1.prefab_name ~= "" and arg_455_1.actors_[var_458_1.prefab_name] ~= nil then
						local var_458_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_1.prefab_name].transform, "story_v_side_new_1104201", "1104201113", "story_v_side_new_1104201.awb")

						arg_455_1:RecordAudio("1104201113", var_458_6)
						arg_455_1:RecordAudio("1104201113", var_458_6)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201113", "story_v_side_new_1104201.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201113", "story_v_side_new_1104201.awb")
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
	Play1104201114 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 1104201114
		arg_459_1.duration_ = 5

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play1104201115(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 and not isNil(arg_459_1.actors_["6045_story"]) and arg_459_1.var_.characterEffect6045_story == nil then
				arg_459_1.var_.characterEffect6045_story = arg_459_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_462_0 = 0.200000002980232

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_0 and not isNil(arg_459_1.actors_["6045_story"]) then
				if arg_459_1.var_.characterEffect6045_story and not isNil(arg_459_1.actors_["6045_story"]) then
					arg_459_1.var_.characterEffect6045_story.fillFlat = true
					arg_459_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_459_1.time_ - 0) / var_462_0)
				end
			end

			if arg_459_1.time_ >= 0 + var_462_0 and arg_459_1.time_ < 0 + var_462_0 + arg_462_0 and not isNil(arg_459_1.actors_["6045_story"]) and arg_459_1.var_.characterEffect6045_story then
				arg_459_1.var_.characterEffect6045_story.fillFlat = true
				arg_459_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_462_1 = 0
			local var_462_2 = 0.625

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= var_462_1 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				arg_459_1.leftNameTxt_.text = arg_459_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, true)
				arg_459_1.iconController_:SetSelectedState("hero")

				arg_459_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_459_1.callingController_:SetSelectedState("normal")

				arg_459_1.keyicon_.color = Color.New(1, 1, 1)
				arg_459_1.icon_.color = Color.New(1, 1, 1)

				local var_462_3 = arg_459_1:FormatText(arg_459_1:GetWordFromCfg(1104201114).content)

				arg_459_1.text_.text = var_462_3

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_5 = 25 <= 0 and var_462_2 or var_462_2 * (utf8.len(var_462_3) / 25)

				if (25 <= 0 and var_462_2 or var_462_2 * (utf8.len(var_462_3) / 25)) > 0 and var_462_2 < var_462_5 then
					arg_459_1.talkMaxDuration = var_462_5

					if var_462_5 + var_462_1 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_5 + var_462_1
					end
				end

				arg_459_1.text_.text = var_462_3
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)
				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_6 = math.max(var_462_2, arg_459_1.talkMaxDuration)

			if var_462_1 <= arg_459_1.time_ and arg_459_1.time_ < var_462_1 + var_462_6 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_1) / var_462_6

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_1 + var_462_6 and arg_459_1.time_ < var_462_1 + var_462_6 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play1104201115 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 1104201115
		arg_463_1.duration_ = 4.3

		local var_463_0 = {
			ja = 4.3,
			ko = 4.133,
			zh = 4.133
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
				arg_463_0:Play1104201116(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 and not isNil(arg_463_1.actors_["6045_story"]) and arg_463_1.var_.characterEffect6045_story == nil then
				arg_463_1.var_.characterEffect6045_story = arg_463_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_466_0 = 0.200000002980232

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_0 and not isNil(arg_463_1.actors_["6045_story"]) then
				if arg_463_1.var_.characterEffect6045_story and not isNil(arg_463_1.actors_["6045_story"]) then
					arg_463_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_463_1.time_ >= 0 + var_466_0 and arg_463_1.time_ < 0 + var_466_0 + arg_466_0 and not isNil(arg_463_1.actors_["6045_story"]) and arg_463_1.var_.characterEffect6045_story then
				arg_463_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action2_2")
			end

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_466_2 = 0
			local var_466_3 = 0.325

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= var_466_2 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				arg_463_1.leftNameTxt_.text = arg_463_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_4 = arg_463_1:GetWordFromCfg(1104201115)
				local var_466_5 = arg_463_1:FormatText(var_466_4.content)

				arg_463_1.text_.text = var_466_5

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_7 = 13 <= 0 and var_466_3 or var_466_3 * (utf8.len(var_466_5) / 13)

				if (13 <= 0 and var_466_3 or var_466_3 * (utf8.len(var_466_5) / 13)) > 0 and var_466_3 < var_466_7 then
					arg_463_1.talkMaxDuration = var_466_7

					if var_466_7 + var_466_2 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_7 + var_466_2
					end
				end

				arg_463_1.text_.text = var_466_5
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201115", "story_v_side_new_1104201.awb") ~= 0 then
					local var_466_8 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201115", "story_v_side_new_1104201.awb") / 1000

					if var_466_8 + var_466_2 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_8 + var_466_2
					end

					if var_466_4.prefab_name ~= "" and arg_463_1.actors_[var_466_4.prefab_name] ~= nil then
						local var_466_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_4.prefab_name].transform, "story_v_side_new_1104201", "1104201115", "story_v_side_new_1104201.awb")

						arg_463_1:RecordAudio("1104201115", var_466_9)
						arg_463_1:RecordAudio("1104201115", var_466_9)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201115", "story_v_side_new_1104201.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201115", "story_v_side_new_1104201.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_10 = math.max(var_466_3, arg_463_1.talkMaxDuration)

			if var_466_2 <= arg_463_1.time_ and arg_463_1.time_ < var_466_2 + var_466_10 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_2) / var_466_10

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_2 + var_466_10 and arg_463_1.time_ < var_466_2 + var_466_10 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play1104201116 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 1104201116
		arg_467_1.duration_ = 5

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play1104201117(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 and not isNil(arg_467_1.actors_["6045_story"]) and arg_467_1.var_.characterEffect6045_story == nil then
				arg_467_1.var_.characterEffect6045_story = arg_467_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_470_0 = 0.200000002980232

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_0 and not isNil(arg_467_1.actors_["6045_story"]) then
				if arg_467_1.var_.characterEffect6045_story and not isNil(arg_467_1.actors_["6045_story"]) then
					arg_467_1.var_.characterEffect6045_story.fillFlat = true
					arg_467_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_467_1.time_ - 0) / var_470_0)
				end
			end

			if arg_467_1.time_ >= 0 + var_470_0 and arg_467_1.time_ < 0 + var_470_0 + arg_470_0 and not isNil(arg_467_1.actors_["6045_story"]) and arg_467_1.var_.characterEffect6045_story then
				arg_467_1.var_.characterEffect6045_story.fillFlat = true
				arg_467_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_470_1 = 0
			local var_470_2 = 0.1

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_1 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				arg_467_1.leftNameTxt_.text = arg_467_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, true)
				arg_467_1.iconController_:SetSelectedState("hero")

				arg_467_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_467_1.callingController_:SetSelectedState("normal")

				arg_467_1.keyicon_.color = Color.New(1, 1, 1)
				arg_467_1.icon_.color = Color.New(1, 1, 1)

				local var_470_3 = arg_467_1:FormatText(arg_467_1:GetWordFromCfg(1104201116).content)

				arg_467_1.text_.text = var_470_3

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_5 = 4 <= 0 and var_470_2 or var_470_2 * (utf8.len(var_470_3) / 4)

				if (4 <= 0 and var_470_2 or var_470_2 * (utf8.len(var_470_3) / 4)) > 0 and var_470_2 < var_470_5 then
					arg_467_1.talkMaxDuration = var_470_5

					if var_470_5 + var_470_1 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_5 + var_470_1
					end
				end

				arg_467_1.text_.text = var_470_3
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)
				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_6 = math.max(var_470_2, arg_467_1.talkMaxDuration)

			if var_470_1 <= arg_467_1.time_ and arg_467_1.time_ < var_470_1 + var_470_6 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_1) / var_470_6

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_1 + var_470_6 and arg_467_1.time_ < var_470_1 + var_470_6 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play1104201117 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 1104201117
		arg_471_1.duration_ = 9

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play1104201118(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			if 1.96599999815226 < arg_471_1.time_ and arg_471_1.time_ <= 1.96599999815226 + arg_474_0 then
				arg_471_1.var_.moveOldPos6045_story = arg_471_1.actors_["6045_story"].transform.localPosition

				local var_474_0 = GameObjectTools.GetOrAddComponent(arg_471_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_474_0 then
					var_474_0:EnableDynamicBone(false)
				end
			end

			local var_474_1 = 0.001

			if 1.96599999815226 <= arg_471_1.time_ and arg_471_1.time_ < 1.96599999815226 + var_474_1 then
				arg_471_1.actors_["6045_story"].transform.localPosition = Vector3.Lerp(arg_471_1.var_.moveOldPos6045_story, Vector3.New(0, 100, 0), (arg_471_1.time_ - 1.96599999815226) / var_474_1)
				arg_471_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_471_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_471_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_471_1.actors_["6045_story"].transform.position).z)
				arg_471_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_471_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_471_1.actors_["6045_story"].transform.localEulerAngles = arg_471_1.actors_["6045_story"].transform.localEulerAngles
			end

			if arg_471_1.time_ >= 1.96599999815226 + var_474_1 and arg_471_1.time_ < 1.96599999815226 + var_474_1 + arg_474_0 then
				arg_471_1.actors_["6045_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_471_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_471_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_471_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_471_1.actors_["6045_story"].transform.position).z)
				arg_471_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_471_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_471_1.actors_["6045_story"].transform.localEulerAngles = arg_471_1.actors_["6045_story"].transform.localEulerAngles

				local var_474_2 = GameObjectTools.GetOrAddComponent(arg_471_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_474_2 then
					var_474_2:EnableDynamicBone(true)
				end
			end

			local var_474_3 = arg_471_1.actors_["6045_story"]

			if 1.96599999815226 < arg_471_1.time_ and arg_471_1.time_ <= 1.96599999815226 + arg_474_0 and not isNil(var_474_3) and arg_471_1.var_.characterEffect6045_story == nil then
				arg_471_1.var_.characterEffect6045_story = var_474_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_474_4 = 0.034000001847744

			if 1.96599999815226 <= arg_471_1.time_ and arg_471_1.time_ < 1.96599999815226 + var_474_4 and not isNil(var_474_3) then
				if arg_471_1.var_.characterEffect6045_story and not isNil(var_474_3) then
					arg_471_1.var_.characterEffect6045_story.fillFlat = true
					arg_471_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_471_1.time_ - 1.96599999815226) / var_474_4)
				end
			end

			if arg_471_1.time_ >= 1.96599999815226 + var_474_4 and arg_471_1.time_ < 1.96599999815226 + var_474_4 + arg_474_0 and not isNil(var_474_3) and arg_471_1.var_.characterEffect6045_story then
				arg_471_1.var_.characterEffect6045_story.fillFlat = true
				arg_471_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_474_5 = arg_471_1.actors_["6046_story"].transform

			if 1.96599999815226 < arg_471_1.time_ and arg_471_1.time_ <= 1.96599999815226 + arg_474_0 then
				arg_471_1.var_.moveOldPos6046_story = var_474_5.localPosition

				local var_474_6 = GameObjectTools.GetOrAddComponent(var_474_5.gameObject, typeof(DynamicBoneHelper))

				if var_474_6 then
					var_474_6:EnableDynamicBone(false)
				end
			end

			local var_474_7 = 0.001

			if 1.96599999815226 <= arg_471_1.time_ and arg_471_1.time_ < 1.96599999815226 + var_474_7 then
				var_474_5.localPosition = Vector3.Lerp(arg_471_1.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (arg_471_1.time_ - 1.96599999815226) / var_474_7)
				var_474_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_474_5.position).x, (manager.ui.mainCamera.transform.position - var_474_5.position).y, (manager.ui.mainCamera.transform.position - var_474_5.position).z)
				var_474_5.localEulerAngles.z = 0
				var_474_5.localEulerAngles.x = 0
				var_474_5.localEulerAngles = var_474_5.localEulerAngles
			end

			if arg_471_1.time_ >= 1.96599999815226 + var_474_7 and arg_471_1.time_ < 1.96599999815226 + var_474_7 + arg_474_0 then
				var_474_5.localPosition = Vector3.New(0, 100, 0)
				var_474_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_474_5.position).x, (manager.ui.mainCamera.transform.position - var_474_5.position).y, (manager.ui.mainCamera.transform.position - var_474_5.position).z)
				var_474_5.localEulerAngles.z = 0
				var_474_5.localEulerAngles.x = 0
				var_474_5.localEulerAngles = var_474_5.localEulerAngles

				local var_474_8 = GameObjectTools.GetOrAddComponent(var_474_5.gameObject, typeof(DynamicBoneHelper))

				if var_474_8 then
					var_474_8:EnableDynamicBone(true)
				end
			end

			local var_474_9 = arg_471_1.actors_["6046_story"]

			if 1.96599999815226 < arg_471_1.time_ and arg_471_1.time_ <= 1.96599999815226 + arg_474_0 and not isNil(var_474_9) and arg_471_1.var_.characterEffect6046_story == nil then
				arg_471_1.var_.characterEffect6046_story = var_474_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_474_10 = 0.034000001847744

			if 1.96599999815226 <= arg_471_1.time_ and arg_471_1.time_ < 1.96599999815226 + var_474_10 and not isNil(var_474_9) then
				if arg_471_1.var_.characterEffect6046_story and not isNil(var_474_9) then
					arg_471_1.var_.characterEffect6046_story.fillFlat = true
					arg_471_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_471_1.time_ - 1.96599999815226) / var_474_10)
				end
			end

			if arg_471_1.time_ >= 1.96599999815226 + var_474_10 and arg_471_1.time_ < 1.96599999815226 + var_474_10 + arg_474_0 and not isNil(var_474_9) and arg_471_1.var_.characterEffect6046_story then
				arg_471_1.var_.characterEffect6046_story.fillFlat = true
				arg_471_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_474_11 = 0

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= var_474_11 + arg_474_0 then
				arg_471_1.mask_.enabled = true
				arg_471_1.mask_.raycastTarget = true

				arg_471_1:SetGaussion(false)
			end

			local var_474_12 = 2

			if var_474_11 <= arg_471_1.time_ and arg_471_1.time_ < var_474_11 + var_474_12 then
				local var_474_13 = Color.New(0, 0, 0)

				var_474_13.a = Mathf.Lerp(0, 1, (arg_471_1.time_ - var_474_11) / var_474_12)
				arg_471_1.mask_.color = var_474_13
			end

			if arg_471_1.time_ >= var_474_11 + var_474_12 and arg_471_1.time_ < var_474_11 + var_474_12 + arg_474_0 then
				local var_474_14 = Color.New(0, 0, 0)

				var_474_14.a = 1
				arg_471_1.mask_.color = var_474_14
			end

			local var_474_15 = 2

			if 2 < arg_471_1.time_ and arg_471_1.time_ <= var_474_15 + arg_474_0 then
				arg_471_1.mask_.enabled = true
				arg_471_1.mask_.raycastTarget = true

				arg_471_1:SetGaussion(false)
			end

			local var_474_16 = 2

			if var_474_15 <= arg_471_1.time_ and arg_471_1.time_ < var_474_15 + var_474_16 then
				local var_474_17 = Color.New(0, 0, 0)

				var_474_17.a = Mathf.Lerp(1, 0, (arg_471_1.time_ - var_474_15) / var_474_16)
				arg_471_1.mask_.color = var_474_17
			end

			if arg_471_1.time_ >= var_474_15 + var_474_16 and arg_471_1.time_ < var_474_15 + var_474_16 + arg_474_0 then
				local var_474_18 = Color.New(0, 0, 0)

				arg_471_1.mask_.enabled = false
				var_474_18.a = 0
				arg_471_1.mask_.color = var_474_18
			end

			if arg_471_1.frameCnt_ <= 1 then
				arg_471_1.dialog_:SetActive(false)
			end

			local var_474_19 = 3.999999999999
			local var_474_20 = 1.2

			if 3.999999999999 < arg_471_1.time_ and arg_471_1.time_ <= var_474_19 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0

				arg_471_1.dialog_:SetActive(true)

				arg_471_1.dialogCg_.alpha = 0

				local var_474_21 = LeanTween.value(arg_471_1.dialog_, 0, 1, 0.3)

				var_474_21:setOnUpdate(LuaHelper.FloatAction(function(arg_475_0)
					arg_471_1.dialogCg_.alpha = arg_475_0
				end))
				var_474_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_471_1.dialog_)
					var_474_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_471_1.duration_ = arg_471_1.duration_ + 0.3

				SetActive(arg_471_1.leftNameGo_, false)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_22 = arg_471_1:FormatText(arg_471_1:GetWordFromCfg(1104201117).content)

				arg_471_1.text_.text = var_474_22

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_24 = 48 <= 0 and var_474_20 or var_474_20 * (utf8.len(var_474_22) / 48)

				if (48 <= 0 and var_474_20 or var_474_20 * (utf8.len(var_474_22) / 48)) > 0 and var_474_20 < var_474_24 then
					arg_471_1.talkMaxDuration = var_474_24
					var_474_19 = var_474_19 + 0.3

					if var_474_24 + var_474_19 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_24 + var_474_19
					end
				end

				arg_471_1.text_.text = var_474_22
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)
				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_25 = var_474_19 + 0.3
			local var_474_26 = math.max(var_474_20, arg_471_1.talkMaxDuration)

			if var_474_19 + 0.3 <= arg_471_1.time_ and arg_471_1.time_ < var_474_25 + var_474_26 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_25) / var_474_26

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_25 + var_474_26 and arg_471_1.time_ < var_474_25 + var_474_26 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_471_1:InitPlayNodeList()
	end,
	Play1104201118 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 1104201118
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play1104201119(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = 0.875

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, false)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_1 = arg_477_1:FormatText(arg_477_1:GetWordFromCfg(1104201118).content)

				arg_477_1.text_.text = var_480_1

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_3 = 35 <= 0 and var_480_0 or var_480_0 * (utf8.len(var_480_1) / 35)

				if (35 <= 0 and var_480_0 or var_480_0 * (utf8.len(var_480_1) / 35)) > 0 and var_480_0 < var_480_3 then
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
	Play1104201119 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 1104201119
		arg_481_1.duration_ = 6.03

		local var_481_0 = {
			ja = 6.033,
			ko = 4.9,
			zh = 4.9
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
				arg_481_0:Play1104201120(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.var_.moveOldPos6045_story = arg_481_1.actors_["6045_story"].transform.localPosition

				local var_484_0 = GameObjectTools.GetOrAddComponent(arg_481_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_484_0 then
					var_484_0:EnableDynamicBone(false)
				end
			end

			local var_484_1 = 0.001

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_1 then
				arg_481_1.actors_["6045_story"].transform.localPosition = Vector3.Lerp(arg_481_1.var_.moveOldPos6045_story, Vector3.New(-0.7, -0.5, -6.3), (arg_481_1.time_ - 0) / var_484_1)
				arg_481_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_481_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["6045_story"].transform.position).z)
				arg_481_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_481_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_481_1.actors_["6045_story"].transform.localEulerAngles = arg_481_1.actors_["6045_story"].transform.localEulerAngles
			end

			if arg_481_1.time_ >= 0 + var_484_1 and arg_481_1.time_ < 0 + var_484_1 + arg_484_0 then
				arg_481_1.actors_["6045_story"].transform.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				arg_481_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_481_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["6045_story"].transform.position).z)
				arg_481_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_481_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_481_1.actors_["6045_story"].transform.localEulerAngles = arg_481_1.actors_["6045_story"].transform.localEulerAngles

				local var_484_2 = GameObjectTools.GetOrAddComponent(arg_481_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_484_2 then
					var_484_2:EnableDynamicBone(true)
				end
			end

			local var_484_3 = arg_481_1.actors_["6045_story"]

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 and not isNil(var_484_3) and arg_481_1.var_.characterEffect6045_story == nil then
				arg_481_1.var_.characterEffect6045_story = var_484_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_4 = 0.200000002980232

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_4 and not isNil(var_484_3) then
				if arg_481_1.var_.characterEffect6045_story and not isNil(var_484_3) then
					arg_481_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_481_1.time_ >= 0 + var_484_4 and arg_481_1.time_ < 0 + var_484_4 + arg_484_0 and not isNil(var_484_3) and arg_481_1.var_.characterEffect6045_story then
				arg_481_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_1")
			end

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_484_6 = arg_481_1.actors_["6046_story"].transform

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.var_.moveOldPos6046_story = var_484_6.localPosition

				local var_484_7 = GameObjectTools.GetOrAddComponent(var_484_6.gameObject, typeof(DynamicBoneHelper))

				if var_484_7 then
					var_484_7:EnableDynamicBone(false)
				end
			end

			local var_484_8 = 0.001

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_8 then
				var_484_6.localPosition = Vector3.Lerp(arg_481_1.var_.moveOldPos6046_story, Vector3.New(0.7, -0.5, -6.3), (arg_481_1.time_ - 0) / var_484_8)
				var_484_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_484_6.position).x, (manager.ui.mainCamera.transform.position - var_484_6.position).y, (manager.ui.mainCamera.transform.position - var_484_6.position).z)
				var_484_6.localEulerAngles.z = 0
				var_484_6.localEulerAngles.x = 0
				var_484_6.localEulerAngles = var_484_6.localEulerAngles
			end

			if arg_481_1.time_ >= 0 + var_484_8 and arg_481_1.time_ < 0 + var_484_8 + arg_484_0 then
				var_484_6.localPosition = Vector3.New(0.7, -0.5, -6.3)
				var_484_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_484_6.position).x, (manager.ui.mainCamera.transform.position - var_484_6.position).y, (manager.ui.mainCamera.transform.position - var_484_6.position).z)
				var_484_6.localEulerAngles.z = 0
				var_484_6.localEulerAngles.x = 0
				var_484_6.localEulerAngles = var_484_6.localEulerAngles

				local var_484_9 = GameObjectTools.GetOrAddComponent(var_484_6.gameObject, typeof(DynamicBoneHelper))

				if var_484_9 then
					var_484_9:EnableDynamicBone(true)
				end
			end

			local var_484_10 = arg_481_1.actors_["6046_story"]

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 and not isNil(var_484_10) and arg_481_1.var_.characterEffect6046_story == nil then
				arg_481_1.var_.characterEffect6046_story = var_484_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_11 = 0.200000002980232

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_11 and not isNil(var_484_10) then
				if arg_481_1.var_.characterEffect6046_story and not isNil(var_484_10) then
					arg_481_1.var_.characterEffect6046_story.fillFlat = true
					arg_481_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_481_1.time_ - 0) / var_484_11)
				end
			end

			if arg_481_1.time_ >= 0 + var_484_11 and arg_481_1.time_ < 0 + var_484_11 + arg_484_0 and not isNil(var_484_10) and arg_481_1.var_.characterEffect6046_story then
				arg_481_1.var_.characterEffect6046_story.fillFlat = true
				arg_481_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_484_12 = 0
			local var_484_13 = 0.4

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_12 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_14 = arg_481_1:GetWordFromCfg(1104201119)
				local var_484_15 = arg_481_1:FormatText(var_484_14.content)

				arg_481_1.text_.text = var_484_15

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_17 = 16 <= 0 and var_484_13 or var_484_13 * (utf8.len(var_484_15) / 16)

				if (16 <= 0 and var_484_13 or var_484_13 * (utf8.len(var_484_15) / 16)) > 0 and var_484_13 < var_484_17 then
					arg_481_1.talkMaxDuration = var_484_17

					if var_484_17 + var_484_12 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_17 + var_484_12
					end
				end

				arg_481_1.text_.text = var_484_15
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201119", "story_v_side_new_1104201.awb") ~= 0 then
					local var_484_18 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201119", "story_v_side_new_1104201.awb") / 1000

					if var_484_18 + var_484_12 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_18 + var_484_12
					end

					if var_484_14.prefab_name ~= "" and arg_481_1.actors_[var_484_14.prefab_name] ~= nil then
						local var_484_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_14.prefab_name].transform, "story_v_side_new_1104201", "1104201119", "story_v_side_new_1104201.awb")

						arg_481_1:RecordAudio("1104201119", var_484_19)
						arg_481_1:RecordAudio("1104201119", var_484_19)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201119", "story_v_side_new_1104201.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201119", "story_v_side_new_1104201.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_20 = math.max(var_484_13, arg_481_1.talkMaxDuration)

			if var_484_12 <= arg_481_1.time_ and arg_481_1.time_ < var_484_12 + var_484_20 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_12) / var_484_20

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_12 + var_484_20 and arg_481_1.time_ < var_484_12 + var_484_20 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_481_1:InitPlayNodeList()
	end,
	Play1104201120 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 1104201120
		arg_485_1.duration_ = 9.5

		local var_485_0 = {
			ja = 9.5,
			ko = 9.166,
			zh = 9.166
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
				arg_485_0:Play1104201121(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 and not isNil(arg_485_1.actors_["6046_story"]) and arg_485_1.var_.characterEffect6046_story == nil then
				arg_485_1.var_.characterEffect6046_story = arg_485_1.actors_["6046_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_0 = 0.200000002980232

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_0 and not isNil(arg_485_1.actors_["6046_story"]) then
				if arg_485_1.var_.characterEffect6046_story and not isNil(arg_485_1.actors_["6046_story"]) then
					arg_485_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_485_1.time_ >= 0 + var_488_0 and arg_485_1.time_ < 0 + var_488_0 + arg_488_0 and not isNil(arg_485_1.actors_["6046_story"]) and arg_485_1.var_.characterEffect6046_story then
				arg_485_1.var_.characterEffect6046_story.fillFlat = false
			end

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_488_2 = arg_485_1.actors_["6045_story"]

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 and not isNil(var_488_2) and arg_485_1.var_.characterEffect6045_story == nil then
				arg_485_1.var_.characterEffect6045_story = var_488_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_3 = 0.200000002980232

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_3 and not isNil(var_488_2) then
				if arg_485_1.var_.characterEffect6045_story and not isNil(var_488_2) then
					arg_485_1.var_.characterEffect6045_story.fillFlat = true
					arg_485_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_485_1.time_ - 0) / var_488_3)
				end
			end

			if arg_485_1.time_ >= 0 + var_488_3 and arg_485_1.time_ < 0 + var_488_3 + arg_488_0 and not isNil(var_488_2) and arg_485_1.var_.characterEffect6045_story then
				arg_485_1.var_.characterEffect6045_story.fillFlat = true
				arg_485_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_488_4 = 0
			local var_488_5 = 0.825

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_4 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				arg_485_1.leftNameTxt_.text = arg_485_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_6 = arg_485_1:GetWordFromCfg(1104201120)
				local var_488_7 = arg_485_1:FormatText(var_488_6.content)

				arg_485_1.text_.text = var_488_7

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_9 = 33 <= 0 and var_488_5 or var_488_5 * (utf8.len(var_488_7) / 33)

				if (33 <= 0 and var_488_5 or var_488_5 * (utf8.len(var_488_7) / 33)) > 0 and var_488_5 < var_488_9 then
					arg_485_1.talkMaxDuration = var_488_9

					if var_488_9 + var_488_4 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_9 + var_488_4
					end
				end

				arg_485_1.text_.text = var_488_7
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201120", "story_v_side_new_1104201.awb") ~= 0 then
					local var_488_10 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201120", "story_v_side_new_1104201.awb") / 1000

					if var_488_10 + var_488_4 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_10 + var_488_4
					end

					if var_488_6.prefab_name ~= "" and arg_485_1.actors_[var_488_6.prefab_name] ~= nil then
						local var_488_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_6.prefab_name].transform, "story_v_side_new_1104201", "1104201120", "story_v_side_new_1104201.awb")

						arg_485_1:RecordAudio("1104201120", var_488_11)
						arg_485_1:RecordAudio("1104201120", var_488_11)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201120", "story_v_side_new_1104201.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201120", "story_v_side_new_1104201.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_12 = math.max(var_488_5, arg_485_1.talkMaxDuration)

			if var_488_4 <= arg_485_1.time_ and arg_485_1.time_ < var_488_4 + var_488_12 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_4) / var_488_12

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_4 + var_488_12 and arg_485_1.time_ < var_488_4 + var_488_12 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play1104201121 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 1104201121
		arg_489_1.duration_ = 8.8

		local var_489_0 = {
			ja = 7.733,
			ko = 8.8,
			zh = 8.8
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
				arg_489_0:Play1104201122(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 and not isNil(arg_489_1.actors_["6045_story"]) and arg_489_1.var_.characterEffect6045_story == nil then
				arg_489_1.var_.characterEffect6045_story = arg_489_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_492_0 = 0.200000002980232

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_0 and not isNil(arg_489_1.actors_["6045_story"]) then
				if arg_489_1.var_.characterEffect6045_story and not isNil(arg_489_1.actors_["6045_story"]) then
					arg_489_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_489_1.time_ >= 0 + var_492_0 and arg_489_1.time_ < 0 + var_492_0 + arg_492_0 and not isNil(arg_489_1.actors_["6045_story"]) and arg_489_1.var_.characterEffect6045_story then
				arg_489_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_2")
			end

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_492_2 = arg_489_1.actors_["6046_story"]

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 and not isNil(var_492_2) and arg_489_1.var_.characterEffect6046_story == nil then
				arg_489_1.var_.characterEffect6046_story = var_492_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_492_3 = 0.200000002980232

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_3 and not isNil(var_492_2) then
				if arg_489_1.var_.characterEffect6046_story and not isNil(var_492_2) then
					arg_489_1.var_.characterEffect6046_story.fillFlat = true
					arg_489_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_489_1.time_ - 0) / var_492_3)
				end
			end

			if arg_489_1.time_ >= 0 + var_492_3 and arg_489_1.time_ < 0 + var_492_3 + arg_492_0 and not isNil(var_492_2) and arg_489_1.var_.characterEffect6046_story then
				arg_489_1.var_.characterEffect6046_story.fillFlat = true
				arg_489_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_492_4 = 0
			local var_492_5 = 0.575

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_4 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				arg_489_1.leftNameTxt_.text = arg_489_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_6 = arg_489_1:GetWordFromCfg(1104201121)
				local var_492_7 = arg_489_1:FormatText(var_492_6.content)

				arg_489_1.text_.text = var_492_7

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_9 = 23 <= 0 and var_492_5 or var_492_5 * (utf8.len(var_492_7) / 23)

				if (23 <= 0 and var_492_5 or var_492_5 * (utf8.len(var_492_7) / 23)) > 0 and var_492_5 < var_492_9 then
					arg_489_1.talkMaxDuration = var_492_9

					if var_492_9 + var_492_4 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_9 + var_492_4
					end
				end

				arg_489_1.text_.text = var_492_7
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201121", "story_v_side_new_1104201.awb") ~= 0 then
					local var_492_10 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201121", "story_v_side_new_1104201.awb") / 1000

					if var_492_10 + var_492_4 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_10 + var_492_4
					end

					if var_492_6.prefab_name ~= "" and arg_489_1.actors_[var_492_6.prefab_name] ~= nil then
						local var_492_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_489_1.actors_[var_492_6.prefab_name].transform, "story_v_side_new_1104201", "1104201121", "story_v_side_new_1104201.awb")

						arg_489_1:RecordAudio("1104201121", var_492_11)
						arg_489_1:RecordAudio("1104201121", var_492_11)
					else
						arg_489_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201121", "story_v_side_new_1104201.awb")
					end

					arg_489_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201121", "story_v_side_new_1104201.awb")
				end

				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_12 = math.max(var_492_5, arg_489_1.talkMaxDuration)

			if var_492_4 <= arg_489_1.time_ and arg_489_1.time_ < var_492_4 + var_492_12 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_4) / var_492_12

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_4 + var_492_12 and arg_489_1.time_ < var_492_4 + var_492_12 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play1104201122 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 1104201122
		arg_493_1.duration_ = 5

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play1104201123(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1.var_.moveOldPos6045_story = arg_493_1.actors_["6045_story"].transform.localPosition

				local var_496_0 = GameObjectTools.GetOrAddComponent(arg_493_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_496_0 then
					var_496_0:EnableDynamicBone(false)
				end
			end

			local var_496_1 = 0.001

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_1 then
				arg_493_1.actors_["6045_story"].transform.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPos6045_story, Vector3.New(0, 100, 0), (arg_493_1.time_ - 0) / var_496_1)
				arg_493_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_493_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["6045_story"].transform.position).z)
				arg_493_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_493_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_493_1.actors_["6045_story"].transform.localEulerAngles = arg_493_1.actors_["6045_story"].transform.localEulerAngles
			end

			if arg_493_1.time_ >= 0 + var_496_1 and arg_493_1.time_ < 0 + var_496_1 + arg_496_0 then
				arg_493_1.actors_["6045_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_493_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_493_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["6045_story"].transform.position).z)
				arg_493_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_493_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_493_1.actors_["6045_story"].transform.localEulerAngles = arg_493_1.actors_["6045_story"].transform.localEulerAngles

				local var_496_2 = GameObjectTools.GetOrAddComponent(arg_493_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_496_2 then
					var_496_2:EnableDynamicBone(true)
				end
			end

			local var_496_3 = arg_493_1.actors_["6045_story"]

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 and not isNil(var_496_3) and arg_493_1.var_.characterEffect6045_story == nil then
				arg_493_1.var_.characterEffect6045_story = var_496_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_4 = 0.200000002980232

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_4 and not isNil(var_496_3) then
				if arg_493_1.var_.characterEffect6045_story and not isNil(var_496_3) then
					arg_493_1.var_.characterEffect6045_story.fillFlat = true
					arg_493_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_493_1.time_ - 0) / var_496_4)
				end
			end

			if arg_493_1.time_ >= 0 + var_496_4 and arg_493_1.time_ < 0 + var_496_4 + arg_496_0 and not isNil(var_496_3) and arg_493_1.var_.characterEffect6045_story then
				arg_493_1.var_.characterEffect6045_story.fillFlat = true
				arg_493_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_496_5 = arg_493_1.actors_["6046_story"].transform

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1.var_.moveOldPos6046_story = var_496_5.localPosition

				local var_496_6 = GameObjectTools.GetOrAddComponent(var_496_5.gameObject, typeof(DynamicBoneHelper))

				if var_496_6 then
					var_496_6:EnableDynamicBone(false)
				end
			end

			local var_496_7 = 0.001

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_7 then
				var_496_5.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (arg_493_1.time_ - 0) / var_496_7)
				var_496_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_496_5.position).x, (manager.ui.mainCamera.transform.position - var_496_5.position).y, (manager.ui.mainCamera.transform.position - var_496_5.position).z)
				var_496_5.localEulerAngles.z = 0
				var_496_5.localEulerAngles.x = 0
				var_496_5.localEulerAngles = var_496_5.localEulerAngles
			end

			if arg_493_1.time_ >= 0 + var_496_7 and arg_493_1.time_ < 0 + var_496_7 + arg_496_0 then
				var_496_5.localPosition = Vector3.New(0, 100, 0)
				var_496_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_496_5.position).x, (manager.ui.mainCamera.transform.position - var_496_5.position).y, (manager.ui.mainCamera.transform.position - var_496_5.position).z)
				var_496_5.localEulerAngles.z = 0
				var_496_5.localEulerAngles.x = 0
				var_496_5.localEulerAngles = var_496_5.localEulerAngles

				local var_496_8 = GameObjectTools.GetOrAddComponent(var_496_5.gameObject, typeof(DynamicBoneHelper))

				if var_496_8 then
					var_496_8:EnableDynamicBone(true)
				end
			end

			local var_496_9 = arg_493_1.actors_["6046_story"]

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 and not isNil(var_496_9) and arg_493_1.var_.characterEffect6046_story == nil then
				arg_493_1.var_.characterEffect6046_story = var_496_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_10 = 0.200000002980232

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_10 and not isNil(var_496_9) then
				if arg_493_1.var_.characterEffect6046_story and not isNil(var_496_9) then
					arg_493_1.var_.characterEffect6046_story.fillFlat = true
					arg_493_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_493_1.time_ - 0) / var_496_10)
				end
			end

			if arg_493_1.time_ >= 0 + var_496_10 and arg_493_1.time_ < 0 + var_496_10 + arg_496_0 and not isNil(var_496_9) and arg_493_1.var_.characterEffect6046_story then
				arg_493_1.var_.characterEffect6046_story.fillFlat = true
				arg_493_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1:AudioAction("play", "effect", "se_story_side_1042", "se_story_1042_head", "")
			end

			local var_496_12 = 0
			local var_496_13 = 0.25

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_12 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, false)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_14 = arg_493_1:FormatText(arg_493_1:GetWordFromCfg(1104201122).content)

				arg_493_1.text_.text = var_496_14

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_16 = 10 <= 0 and var_496_13 or var_496_13 * (utf8.len(var_496_14) / 10)

				if (10 <= 0 and var_496_13 or var_496_13 * (utf8.len(var_496_14) / 10)) > 0 and var_496_13 < var_496_16 then
					arg_493_1.talkMaxDuration = var_496_16

					if var_496_16 + var_496_12 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_16 + var_496_12
					end
				end

				arg_493_1.text_.text = var_496_14
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)
				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_17 = math.max(var_496_13, arg_493_1.talkMaxDuration)

			if var_496_12 <= arg_493_1.time_ and arg_493_1.time_ < var_496_12 + var_496_17 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_12) / var_496_17

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_12 + var_496_17 and arg_493_1.time_ < var_496_12 + var_496_17 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_493_1:InitPlayNodeList()
	end,
	Play1104201123 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 1104201123
		arg_497_1.duration_ = 5

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play1104201124(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = 0.875

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, false)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_1 = arg_497_1:FormatText(arg_497_1:GetWordFromCfg(1104201123).content)

				arg_497_1.text_.text = var_500_1

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_3 = 35 <= 0 and var_500_0 or var_500_0 * (utf8.len(var_500_1) / 35)

				if (35 <= 0 and var_500_0 or var_500_0 * (utf8.len(var_500_1) / 35)) > 0 and var_500_0 < var_500_3 then
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
	Play1104201124 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 1104201124
		arg_501_1.duration_ = 5.2

		local var_501_0 = {
			ja = 5.2,
			ko = 4.566,
			zh = 4.566
		}
		local var_501_1 = manager.audio:GetLocalizationFlag()

		if var_501_0[var_501_1] ~= nil then
			arg_501_1.duration_ = var_501_0[var_501_1]
		end

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play1104201125(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1.var_.moveOldPos6045_story = arg_501_1.actors_["6045_story"].transform.localPosition

				local var_504_0 = GameObjectTools.GetOrAddComponent(arg_501_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_504_0 then
					var_504_0:EnableDynamicBone(false)
				end
			end

			local var_504_1 = 0.001

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_1 then
				arg_501_1.actors_["6045_story"].transform.localPosition = Vector3.Lerp(arg_501_1.var_.moveOldPos6045_story, Vector3.New(-0.7, -0.5, -6.3), (arg_501_1.time_ - 0) / var_504_1)
				arg_501_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_501_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_501_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_501_1.actors_["6045_story"].transform.position).z)
				arg_501_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_501_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_501_1.actors_["6045_story"].transform.localEulerAngles = arg_501_1.actors_["6045_story"].transform.localEulerAngles
			end

			if arg_501_1.time_ >= 0 + var_504_1 and arg_501_1.time_ < 0 + var_504_1 + arg_504_0 then
				arg_501_1.actors_["6045_story"].transform.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				arg_501_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_501_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_501_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_501_1.actors_["6045_story"].transform.position).z)
				arg_501_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_501_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_501_1.actors_["6045_story"].transform.localEulerAngles = arg_501_1.actors_["6045_story"].transform.localEulerAngles

				local var_504_2 = GameObjectTools.GetOrAddComponent(arg_501_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_504_2 then
					var_504_2:EnableDynamicBone(true)
				end
			end

			local var_504_3 = arg_501_1.actors_["6045_story"]

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 and not isNil(var_504_3) and arg_501_1.var_.characterEffect6045_story == nil then
				arg_501_1.var_.characterEffect6045_story = var_504_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_504_4 = 0.200000002980232

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_4 and not isNil(var_504_3) then
				if arg_501_1.var_.characterEffect6045_story and not isNil(var_504_3) then
					arg_501_1.var_.characterEffect6045_story.fillFlat = true
					arg_501_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_501_1.time_ - 0) / var_504_4)
				end
			end

			if arg_501_1.time_ >= 0 + var_504_4 and arg_501_1.time_ < 0 + var_504_4 + arg_504_0 and not isNil(var_504_3) and arg_501_1.var_.characterEffect6045_story then
				arg_501_1.var_.characterEffect6045_story.fillFlat = true
				arg_501_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_504_5 = arg_501_1.actors_["6046_story"].transform

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1.var_.moveOldPos6046_story = var_504_5.localPosition

				local var_504_6 = GameObjectTools.GetOrAddComponent(var_504_5.gameObject, typeof(DynamicBoneHelper))

				if var_504_6 then
					var_504_6:EnableDynamicBone(false)
				end
			end

			local var_504_7 = 0.001

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_7 then
				var_504_5.localPosition = Vector3.Lerp(arg_501_1.var_.moveOldPos6046_story, Vector3.New(0.7, -0.5, -6.3), (arg_501_1.time_ - 0) / var_504_7)
				var_504_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_504_5.position).x, (manager.ui.mainCamera.transform.position - var_504_5.position).y, (manager.ui.mainCamera.transform.position - var_504_5.position).z)
				var_504_5.localEulerAngles.z = 0
				var_504_5.localEulerAngles.x = 0
				var_504_5.localEulerAngles = var_504_5.localEulerAngles
			end

			if arg_501_1.time_ >= 0 + var_504_7 and arg_501_1.time_ < 0 + var_504_7 + arg_504_0 then
				var_504_5.localPosition = Vector3.New(0.7, -0.5, -6.3)
				var_504_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_504_5.position).x, (manager.ui.mainCamera.transform.position - var_504_5.position).y, (manager.ui.mainCamera.transform.position - var_504_5.position).z)
				var_504_5.localEulerAngles.z = 0
				var_504_5.localEulerAngles.x = 0
				var_504_5.localEulerAngles = var_504_5.localEulerAngles

				local var_504_8 = GameObjectTools.GetOrAddComponent(var_504_5.gameObject, typeof(DynamicBoneHelper))

				if var_504_8 then
					var_504_8:EnableDynamicBone(true)
				end
			end

			local var_504_9 = arg_501_1.actors_["6046_story"]

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 and not isNil(var_504_9) and arg_501_1.var_.characterEffect6046_story == nil then
				arg_501_1.var_.characterEffect6046_story = var_504_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_504_10 = 0.200000002980232

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_10 and not isNil(var_504_9) then
				if arg_501_1.var_.characterEffect6046_story and not isNil(var_504_9) then
					arg_501_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_501_1.time_ >= 0 + var_504_10 and arg_501_1.time_ < 0 + var_504_10 + arg_504_0 and not isNil(var_504_9) and arg_501_1.var_.characterEffect6046_story then
				arg_501_1.var_.characterEffect6046_story.fillFlat = false
			end

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_504_12 = 0
			local var_504_13 = 0.35

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_12 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				arg_501_1.leftNameTxt_.text = arg_501_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_14 = arg_501_1:GetWordFromCfg(1104201124)
				local var_504_15 = arg_501_1:FormatText(var_504_14.content)

				arg_501_1.text_.text = var_504_15

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_17 = 14 <= 0 and var_504_13 or var_504_13 * (utf8.len(var_504_15) / 14)

				if (14 <= 0 and var_504_13 or var_504_13 * (utf8.len(var_504_15) / 14)) > 0 and var_504_13 < var_504_17 then
					arg_501_1.talkMaxDuration = var_504_17

					if var_504_17 + var_504_12 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_17 + var_504_12
					end
				end

				arg_501_1.text_.text = var_504_15
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201124", "story_v_side_new_1104201.awb") ~= 0 then
					local var_504_18 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201124", "story_v_side_new_1104201.awb") / 1000

					if var_504_18 + var_504_12 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_18 + var_504_12
					end

					if var_504_14.prefab_name ~= "" and arg_501_1.actors_[var_504_14.prefab_name] ~= nil then
						local var_504_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_501_1.actors_[var_504_14.prefab_name].transform, "story_v_side_new_1104201", "1104201124", "story_v_side_new_1104201.awb")

						arg_501_1:RecordAudio("1104201124", var_504_19)
						arg_501_1:RecordAudio("1104201124", var_504_19)
					else
						arg_501_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201124", "story_v_side_new_1104201.awb")
					end

					arg_501_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201124", "story_v_side_new_1104201.awb")
				end

				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_20 = math.max(var_504_13, arg_501_1.talkMaxDuration)

			if var_504_12 <= arg_501_1.time_ and arg_501_1.time_ < var_504_12 + var_504_20 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_12) / var_504_20

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_12 + var_504_20 and arg_501_1.time_ < var_504_12 + var_504_20 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_501_1:InitPlayNodeList()
	end,
	Play1104201125 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 1104201125
		arg_505_1.duration_ = 8.43

		local var_505_0 = {
			ja = 8.433,
			ko = 8.1,
			zh = 8.1
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
				arg_505_0:Play1104201126(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 and not isNil(arg_505_1.actors_["6045_story"]) and arg_505_1.var_.characterEffect6045_story == nil then
				arg_505_1.var_.characterEffect6045_story = arg_505_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_508_0 = 0.200000002980232

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_0 and not isNil(arg_505_1.actors_["6045_story"]) then
				if arg_505_1.var_.characterEffect6045_story and not isNil(arg_505_1.actors_["6045_story"]) then
					arg_505_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_505_1.time_ >= 0 + var_508_0 and arg_505_1.time_ < 0 + var_508_0 + arg_508_0 and not isNil(arg_505_1.actors_["6045_story"]) and arg_505_1.var_.characterEffect6045_story then
				arg_505_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_508_2 = arg_505_1.actors_["6046_story"]

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 and not isNil(var_508_2) and arg_505_1.var_.characterEffect6046_story == nil then
				arg_505_1.var_.characterEffect6046_story = var_508_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_508_3 = 0.200000002980232

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_3 and not isNil(var_508_2) then
				if arg_505_1.var_.characterEffect6046_story and not isNil(var_508_2) then
					arg_505_1.var_.characterEffect6046_story.fillFlat = true
					arg_505_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_505_1.time_ - 0) / var_508_3)
				end
			end

			if arg_505_1.time_ >= 0 + var_508_3 and arg_505_1.time_ < 0 + var_508_3 + arg_508_0 and not isNil(var_508_2) and arg_505_1.var_.characterEffect6046_story then
				arg_505_1.var_.characterEffect6046_story.fillFlat = true
				arg_505_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_508_4 = 0
			local var_508_5 = 0.575

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= var_508_4 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				arg_505_1.leftNameTxt_.text = arg_505_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_6 = arg_505_1:GetWordFromCfg(1104201125)
				local var_508_7 = arg_505_1:FormatText(var_508_6.content)

				arg_505_1.text_.text = var_508_7

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_9 = 23 <= 0 and var_508_5 or var_508_5 * (utf8.len(var_508_7) / 23)

				if (23 <= 0 and var_508_5 or var_508_5 * (utf8.len(var_508_7) / 23)) > 0 and var_508_5 < var_508_9 then
					arg_505_1.talkMaxDuration = var_508_9

					if var_508_9 + var_508_4 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_9 + var_508_4
					end
				end

				arg_505_1.text_.text = var_508_7
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201125", "story_v_side_new_1104201.awb") ~= 0 then
					local var_508_10 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201125", "story_v_side_new_1104201.awb") / 1000

					if var_508_10 + var_508_4 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_10 + var_508_4
					end

					if var_508_6.prefab_name ~= "" and arg_505_1.actors_[var_508_6.prefab_name] ~= nil then
						local var_508_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_505_1.actors_[var_508_6.prefab_name].transform, "story_v_side_new_1104201", "1104201125", "story_v_side_new_1104201.awb")

						arg_505_1:RecordAudio("1104201125", var_508_11)
						arg_505_1:RecordAudio("1104201125", var_508_11)
					else
						arg_505_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201125", "story_v_side_new_1104201.awb")
					end

					arg_505_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201125", "story_v_side_new_1104201.awb")
				end

				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_12 = math.max(var_508_5, arg_505_1.talkMaxDuration)

			if var_508_4 <= arg_505_1.time_ and arg_505_1.time_ < var_508_4 + var_508_12 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_4) / var_508_12

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_4 + var_508_12 and arg_505_1.time_ < var_508_4 + var_508_12 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play1104201126 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 1104201126
		arg_509_1.duration_ = 10.03

		local var_509_0 = {
			ja = 9.5,
			ko = 10.033,
			zh = 10.033
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
				arg_509_0:Play1104201127(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_1")
			end

			local var_512_0 = 0
			local var_512_1 = 0.75

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= var_512_0 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				arg_509_1.leftNameTxt_.text = arg_509_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_2 = arg_509_1:GetWordFromCfg(1104201126)
				local var_512_3 = arg_509_1:FormatText(var_512_2.content)

				arg_509_1.text_.text = var_512_3

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_5 = 30 <= 0 and var_512_1 or var_512_1 * (utf8.len(var_512_3) / 30)

				if (30 <= 0 and var_512_1 or var_512_1 * (utf8.len(var_512_3) / 30)) > 0 and var_512_1 < var_512_5 then
					arg_509_1.talkMaxDuration = var_512_5

					if var_512_5 + var_512_0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_5 + var_512_0
					end
				end

				arg_509_1.text_.text = var_512_3
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201126", "story_v_side_new_1104201.awb") ~= 0 then
					local var_512_6 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201126", "story_v_side_new_1104201.awb") / 1000

					if var_512_6 + var_512_0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_6 + var_512_0
					end

					if var_512_2.prefab_name ~= "" and arg_509_1.actors_[var_512_2.prefab_name] ~= nil then
						local var_512_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_509_1.actors_[var_512_2.prefab_name].transform, "story_v_side_new_1104201", "1104201126", "story_v_side_new_1104201.awb")

						arg_509_1:RecordAudio("1104201126", var_512_7)
						arg_509_1:RecordAudio("1104201126", var_512_7)
					else
						arg_509_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201126", "story_v_side_new_1104201.awb")
					end

					arg_509_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201126", "story_v_side_new_1104201.awb")
				end

				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_8 = math.max(var_512_1, arg_509_1.talkMaxDuration)

			if var_512_0 <= arg_509_1.time_ and arg_509_1.time_ < var_512_0 + var_512_8 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_0) / var_512_8

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_0 + var_512_8 and arg_509_1.time_ < var_512_0 + var_512_8 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play1104201127 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 1104201127
		arg_513_1.duration_ = 4

		local var_513_0 = {
			ja = 4,
			ko = 3.666,
			zh = 3.666
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
				arg_513_0:Play1104201128(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 and not isNil(arg_513_1.actors_["6046_story"]) and arg_513_1.var_.characterEffect6046_story == nil then
				arg_513_1.var_.characterEffect6046_story = arg_513_1.actors_["6046_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_516_0 = 0.200000002980232

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_0 and not isNil(arg_513_1.actors_["6046_story"]) then
				if arg_513_1.var_.characterEffect6046_story and not isNil(arg_513_1.actors_["6046_story"]) then
					arg_513_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_513_1.time_ >= 0 + var_516_0 and arg_513_1.time_ < 0 + var_516_0 + arg_516_0 and not isNil(arg_513_1.actors_["6046_story"]) and arg_513_1.var_.characterEffect6046_story then
				arg_513_1.var_.characterEffect6046_story.fillFlat = false
			end

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 then
				arg_513_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action5_1")
			end

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 then
				arg_513_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_516_2 = arg_513_1.actors_["6045_story"]

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 and not isNil(var_516_2) and arg_513_1.var_.characterEffect6045_story == nil then
				arg_513_1.var_.characterEffect6045_story = var_516_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_516_3 = 0.200000002980232

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_3 and not isNil(var_516_2) then
				if arg_513_1.var_.characterEffect6045_story and not isNil(var_516_2) then
					arg_513_1.var_.characterEffect6045_story.fillFlat = true
					arg_513_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_513_1.time_ - 0) / var_516_3)
				end
			end

			if arg_513_1.time_ >= 0 + var_516_3 and arg_513_1.time_ < 0 + var_516_3 + arg_516_0 and not isNil(var_516_2) and arg_513_1.var_.characterEffect6045_story then
				arg_513_1.var_.characterEffect6045_story.fillFlat = true
				arg_513_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_516_4 = 0
			local var_516_5 = 0.35

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= var_516_4 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				arg_513_1.leftNameTxt_.text = arg_513_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_6 = arg_513_1:GetWordFromCfg(1104201127)
				local var_516_7 = arg_513_1:FormatText(var_516_6.content)

				arg_513_1.text_.text = var_516_7

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_9 = 14 <= 0 and var_516_5 or var_516_5 * (utf8.len(var_516_7) / 14)

				if (14 <= 0 and var_516_5 or var_516_5 * (utf8.len(var_516_7) / 14)) > 0 and var_516_5 < var_516_9 then
					arg_513_1.talkMaxDuration = var_516_9

					if var_516_9 + var_516_4 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_9 + var_516_4
					end
				end

				arg_513_1.text_.text = var_516_7
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201127", "story_v_side_new_1104201.awb") ~= 0 then
					local var_516_10 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201127", "story_v_side_new_1104201.awb") / 1000

					if var_516_10 + var_516_4 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_10 + var_516_4
					end

					if var_516_6.prefab_name ~= "" and arg_513_1.actors_[var_516_6.prefab_name] ~= nil then
						local var_516_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_513_1.actors_[var_516_6.prefab_name].transform, "story_v_side_new_1104201", "1104201127", "story_v_side_new_1104201.awb")

						arg_513_1:RecordAudio("1104201127", var_516_11)
						arg_513_1:RecordAudio("1104201127", var_516_11)
					else
						arg_513_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201127", "story_v_side_new_1104201.awb")
					end

					arg_513_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201127", "story_v_side_new_1104201.awb")
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

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play1104201128 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 1104201128
		arg_517_1.duration_ = 8.2

		local var_517_0 = {
			ja = 7.366,
			ko = 8.2,
			zh = 8.2
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
				arg_517_0:Play1104201129(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = 0.65

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				arg_517_1.leftNameTxt_.text = arg_517_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_1 = arg_517_1:GetWordFromCfg(1104201128)
				local var_520_2 = arg_517_1:FormatText(var_520_1.content)

				arg_517_1.text_.text = var_520_2

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_4 = 26 <= 0 and var_520_0 or var_520_0 * (utf8.len(var_520_2) / 26)

				if (26 <= 0 and var_520_0 or var_520_0 * (utf8.len(var_520_2) / 26)) > 0 and var_520_0 < var_520_4 then
					arg_517_1.talkMaxDuration = var_520_4

					if var_520_4 + 0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_4 + 0
					end
				end

				arg_517_1.text_.text = var_520_2
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201128", "story_v_side_new_1104201.awb") ~= 0 then
					local var_520_5 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201128", "story_v_side_new_1104201.awb") / 1000

					if var_520_5 + 0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_5 + 0
					end

					if var_520_1.prefab_name ~= "" and arg_517_1.actors_[var_520_1.prefab_name] ~= nil then
						local var_520_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_517_1.actors_[var_520_1.prefab_name].transform, "story_v_side_new_1104201", "1104201128", "story_v_side_new_1104201.awb")

						arg_517_1:RecordAudio("1104201128", var_520_6)
						arg_517_1:RecordAudio("1104201128", var_520_6)
					else
						arg_517_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201128", "story_v_side_new_1104201.awb")
					end

					arg_517_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201128", "story_v_side_new_1104201.awb")
				end

				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_7 = math.max(var_520_0, arg_517_1.talkMaxDuration)

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_7 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - 0) / var_520_7

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= 0 + var_520_7 and arg_517_1.time_ < 0 + var_520_7 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play1104201129 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 1104201129
		arg_521_1.duration_ = 6.7

		local var_521_0 = {
			ja = 4.4,
			ko = 6.7,
			zh = 6.7
		}
		local var_521_1 = manager.audio:GetLocalizationFlag()

		if var_521_0[var_521_1] ~= nil then
			arg_521_1.duration_ = var_521_0[var_521_1]
		end

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play1104201130(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 and not isNil(arg_521_1.actors_["6045_story"]) and arg_521_1.var_.characterEffect6045_story == nil then
				arg_521_1.var_.characterEffect6045_story = arg_521_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_524_0 = 0.200000002980232

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_0 and not isNil(arg_521_1.actors_["6045_story"]) then
				if arg_521_1.var_.characterEffect6045_story and not isNil(arg_521_1.actors_["6045_story"]) then
					arg_521_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_521_1.time_ >= 0 + var_524_0 and arg_521_1.time_ < 0 + var_524_0 + arg_524_0 and not isNil(arg_521_1.actors_["6045_story"]) and arg_521_1.var_.characterEffect6045_story then
				arg_521_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_2")
			end

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_524_2 = arg_521_1.actors_["6046_story"]

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 and not isNil(var_524_2) and arg_521_1.var_.characterEffect6046_story == nil then
				arg_521_1.var_.characterEffect6046_story = var_524_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_524_3 = 0.200000002980232

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_3 and not isNil(var_524_2) then
				if arg_521_1.var_.characterEffect6046_story and not isNil(var_524_2) then
					arg_521_1.var_.characterEffect6046_story.fillFlat = true
					arg_521_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_521_1.time_ - 0) / var_524_3)
				end
			end

			if arg_521_1.time_ >= 0 + var_524_3 and arg_521_1.time_ < 0 + var_524_3 + arg_524_0 and not isNil(var_524_2) and arg_521_1.var_.characterEffect6046_story then
				arg_521_1.var_.characterEffect6046_story.fillFlat = true
				arg_521_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_524_4 = 0
			local var_524_5 = 0.525

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= var_524_4 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				arg_521_1.leftNameTxt_.text = arg_521_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_6 = arg_521_1:GetWordFromCfg(1104201129)
				local var_524_7 = arg_521_1:FormatText(var_524_6.content)

				arg_521_1.text_.text = var_524_7

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_9 = 21 <= 0 and var_524_5 or var_524_5 * (utf8.len(var_524_7) / 21)

				if (21 <= 0 and var_524_5 or var_524_5 * (utf8.len(var_524_7) / 21)) > 0 and var_524_5 < var_524_9 then
					arg_521_1.talkMaxDuration = var_524_9

					if var_524_9 + var_524_4 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_9 + var_524_4
					end
				end

				arg_521_1.text_.text = var_524_7
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201129", "story_v_side_new_1104201.awb") ~= 0 then
					local var_524_10 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201129", "story_v_side_new_1104201.awb") / 1000

					if var_524_10 + var_524_4 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_10 + var_524_4
					end

					if var_524_6.prefab_name ~= "" and arg_521_1.actors_[var_524_6.prefab_name] ~= nil then
						local var_524_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_521_1.actors_[var_524_6.prefab_name].transform, "story_v_side_new_1104201", "1104201129", "story_v_side_new_1104201.awb")

						arg_521_1:RecordAudio("1104201129", var_524_11)
						arg_521_1:RecordAudio("1104201129", var_524_11)
					else
						arg_521_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201129", "story_v_side_new_1104201.awb")
					end

					arg_521_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201129", "story_v_side_new_1104201.awb")
				end

				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_12 = math.max(var_524_5, arg_521_1.talkMaxDuration)

			if var_524_4 <= arg_521_1.time_ and arg_521_1.time_ < var_524_4 + var_524_12 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_4) / var_524_12

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_4 + var_524_12 and arg_521_1.time_ < var_524_4 + var_524_12 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play1104201130 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 1104201130
		arg_525_1.duration_ = 5.07

		local var_525_0 = {
			ja = 4.333,
			ko = 5.066,
			zh = 5.066
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
				arg_525_0:Play1104201131(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = 0.425

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				arg_525_1.leftNameTxt_.text = arg_525_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_1 = arg_525_1:GetWordFromCfg(1104201130)
				local var_528_2 = arg_525_1:FormatText(var_528_1.content)

				arg_525_1.text_.text = var_528_2

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_4 = 17 <= 0 and var_528_0 or var_528_0 * (utf8.len(var_528_2) / 17)

				if (17 <= 0 and var_528_0 or var_528_0 * (utf8.len(var_528_2) / 17)) > 0 and var_528_0 < var_528_4 then
					arg_525_1.talkMaxDuration = var_528_4

					if var_528_4 + 0 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_4 + 0
					end
				end

				arg_525_1.text_.text = var_528_2
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201130", "story_v_side_new_1104201.awb") ~= 0 then
					local var_528_5 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201130", "story_v_side_new_1104201.awb") / 1000

					if var_528_5 + 0 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_5 + 0
					end

					if var_528_1.prefab_name ~= "" and arg_525_1.actors_[var_528_1.prefab_name] ~= nil then
						local var_528_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_525_1.actors_[var_528_1.prefab_name].transform, "story_v_side_new_1104201", "1104201130", "story_v_side_new_1104201.awb")

						arg_525_1:RecordAudio("1104201130", var_528_6)
						arg_525_1:RecordAudio("1104201130", var_528_6)
					else
						arg_525_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201130", "story_v_side_new_1104201.awb")
					end

					arg_525_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201130", "story_v_side_new_1104201.awb")
				end

				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_7 = math.max(var_528_0, arg_525_1.talkMaxDuration)

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_7 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - 0) / var_528_7

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= 0 + var_528_7 and arg_525_1.time_ < 0 + var_528_7 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play1104201131 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 1104201131
		arg_529_1.duration_ = 9

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play1104201132(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			if 1.95 < arg_529_1.time_ and arg_529_1.time_ <= 1.95 + arg_532_0 then
				arg_529_1.var_.moveOldPos6045_story = arg_529_1.actors_["6045_story"].transform.localPosition

				local var_532_0 = GameObjectTools.GetOrAddComponent(arg_529_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_532_0 then
					var_532_0:EnableDynamicBone(false)
				end
			end

			local var_532_1 = 0.001

			if 1.95 <= arg_529_1.time_ and arg_529_1.time_ < 1.95 + var_532_1 then
				arg_529_1.actors_["6045_story"].transform.localPosition = Vector3.Lerp(arg_529_1.var_.moveOldPos6045_story, Vector3.New(0, 100, 0), (arg_529_1.time_ - 1.95) / var_532_1)
				arg_529_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_529_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_529_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_529_1.actors_["6045_story"].transform.position).z)
				arg_529_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_529_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_529_1.actors_["6045_story"].transform.localEulerAngles = arg_529_1.actors_["6045_story"].transform.localEulerAngles
			end

			if arg_529_1.time_ >= 1.95 + var_532_1 and arg_529_1.time_ < 1.95 + var_532_1 + arg_532_0 then
				arg_529_1.actors_["6045_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_529_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_529_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_529_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_529_1.actors_["6045_story"].transform.position).z)
				arg_529_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_529_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_529_1.actors_["6045_story"].transform.localEulerAngles = arg_529_1.actors_["6045_story"].transform.localEulerAngles

				local var_532_2 = GameObjectTools.GetOrAddComponent(arg_529_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_532_2 then
					var_532_2:EnableDynamicBone(true)
				end
			end

			local var_532_3 = arg_529_1.actors_["6045_story"]

			if 1.95 < arg_529_1.time_ and arg_529_1.time_ <= 1.95 + arg_532_0 and not isNil(var_532_3) and arg_529_1.var_.characterEffect6045_story == nil then
				arg_529_1.var_.characterEffect6045_story = var_532_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_532_4 = 0.05

			if 1.95 <= arg_529_1.time_ and arg_529_1.time_ < 1.95 + var_532_4 and not isNil(var_532_3) then
				if arg_529_1.var_.characterEffect6045_story and not isNil(var_532_3) then
					arg_529_1.var_.characterEffect6045_story.fillFlat = true
					arg_529_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_529_1.time_ - 1.95) / var_532_4)
				end
			end

			if arg_529_1.time_ >= 1.95 + var_532_4 and arg_529_1.time_ < 1.95 + var_532_4 + arg_532_0 and not isNil(var_532_3) and arg_529_1.var_.characterEffect6045_story then
				arg_529_1.var_.characterEffect6045_story.fillFlat = true
				arg_529_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_532_5 = arg_529_1.actors_["6046_story"].transform

			if 1.95 < arg_529_1.time_ and arg_529_1.time_ <= 1.95 + arg_532_0 then
				arg_529_1.var_.moveOldPos6046_story = var_532_5.localPosition

				local var_532_6 = GameObjectTools.GetOrAddComponent(var_532_5.gameObject, typeof(DynamicBoneHelper))

				if var_532_6 then
					var_532_6:EnableDynamicBone(false)
				end
			end

			local var_532_7 = 0.001

			if 1.95 <= arg_529_1.time_ and arg_529_1.time_ < 1.95 + var_532_7 then
				var_532_5.localPosition = Vector3.Lerp(arg_529_1.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (arg_529_1.time_ - 1.95) / var_532_7)
				var_532_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_532_5.position).x, (manager.ui.mainCamera.transform.position - var_532_5.position).y, (manager.ui.mainCamera.transform.position - var_532_5.position).z)
				var_532_5.localEulerAngles.z = 0
				var_532_5.localEulerAngles.x = 0
				var_532_5.localEulerAngles = var_532_5.localEulerAngles
			end

			if arg_529_1.time_ >= 1.95 + var_532_7 and arg_529_1.time_ < 1.95 + var_532_7 + arg_532_0 then
				var_532_5.localPosition = Vector3.New(0, 100, 0)
				var_532_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_532_5.position).x, (manager.ui.mainCamera.transform.position - var_532_5.position).y, (manager.ui.mainCamera.transform.position - var_532_5.position).z)
				var_532_5.localEulerAngles.z = 0
				var_532_5.localEulerAngles.x = 0
				var_532_5.localEulerAngles = var_532_5.localEulerAngles

				local var_532_8 = GameObjectTools.GetOrAddComponent(var_532_5.gameObject, typeof(DynamicBoneHelper))

				if var_532_8 then
					var_532_8:EnableDynamicBone(true)
				end
			end

			local var_532_9 = arg_529_1.actors_["6046_story"]

			if 1.95 < arg_529_1.time_ and arg_529_1.time_ <= 1.95 + arg_532_0 and not isNil(var_532_9) and arg_529_1.var_.characterEffect6046_story == nil then
				arg_529_1.var_.characterEffect6046_story = var_532_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_532_10 = 0.05

			if 1.95 <= arg_529_1.time_ and arg_529_1.time_ < 1.95 + var_532_10 and not isNil(var_532_9) then
				if arg_529_1.var_.characterEffect6046_story and not isNil(var_532_9) then
					arg_529_1.var_.characterEffect6046_story.fillFlat = true
					arg_529_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_529_1.time_ - 1.95) / var_532_10)
				end
			end

			if arg_529_1.time_ >= 1.95 + var_532_10 and arg_529_1.time_ < 1.95 + var_532_10 + arg_532_0 and not isNil(var_532_9) and arg_529_1.var_.characterEffect6046_story then
				arg_529_1.var_.characterEffect6046_story.fillFlat = true
				arg_529_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_532_11 = 0

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= var_532_11 + arg_532_0 then
				arg_529_1.mask_.enabled = true
				arg_529_1.mask_.raycastTarget = true

				arg_529_1:SetGaussion(false)
			end

			local var_532_12 = 2

			if var_532_11 <= arg_529_1.time_ and arg_529_1.time_ < var_532_11 + var_532_12 then
				local var_532_13 = Color.New(0, 0, 0)

				var_532_13.a = Mathf.Lerp(0, 1, (arg_529_1.time_ - var_532_11) / var_532_12)
				arg_529_1.mask_.color = var_532_13
			end

			if arg_529_1.time_ >= var_532_11 + var_532_12 and arg_529_1.time_ < var_532_11 + var_532_12 + arg_532_0 then
				local var_532_14 = Color.New(0, 0, 0)

				var_532_14.a = 1
				arg_529_1.mask_.color = var_532_14
			end

			local var_532_15 = 2

			if 2 < arg_529_1.time_ and arg_529_1.time_ <= var_532_15 + arg_532_0 then
				arg_529_1.mask_.enabled = true
				arg_529_1.mask_.raycastTarget = true

				arg_529_1:SetGaussion(false)
			end

			local var_532_16 = 2

			if var_532_15 <= arg_529_1.time_ and arg_529_1.time_ < var_532_15 + var_532_16 then
				local var_532_17 = Color.New(0, 0, 0)

				var_532_17.a = Mathf.Lerp(1, 0, (arg_529_1.time_ - var_532_15) / var_532_16)
				arg_529_1.mask_.color = var_532_17
			end

			if arg_529_1.time_ >= var_532_15 + var_532_16 and arg_529_1.time_ < var_532_15 + var_532_16 + arg_532_0 then
				local var_532_18 = Color.New(0, 0, 0)

				arg_529_1.mask_.enabled = false
				var_532_18.a = 0
				arg_529_1.mask_.color = var_532_18
			end

			if arg_529_1.frameCnt_ <= 1 then
				arg_529_1.dialog_:SetActive(false)
			end

			local var_532_19 = 4
			local var_532_20 = 0.05

			if 4 < arg_529_1.time_ and arg_529_1.time_ <= var_532_19 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0

				arg_529_1.dialog_:SetActive(true)

				arg_529_1.dialogCg_.alpha = 0

				local var_532_21 = LeanTween.value(arg_529_1.dialog_, 0, 1, 0.3)

				var_532_21:setOnUpdate(LuaHelper.FloatAction(function(arg_533_0)
					arg_529_1.dialogCg_.alpha = arg_533_0
				end))
				var_532_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_529_1.dialog_)
					var_532_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_529_1.duration_ = arg_529_1.duration_ + 0.3

				SetActive(arg_529_1.leftNameGo_, false)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_22 = arg_529_1:FormatText(arg_529_1:GetWordFromCfg(1104201131).content)

				arg_529_1.text_.text = var_532_22

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_24 = 2 <= 0 and var_532_20 or var_532_20 * (utf8.len(var_532_22) / 2)

				if (2 <= 0 and var_532_20 or var_532_20 * (utf8.len(var_532_22) / 2)) > 0 and var_532_20 < var_532_24 then
					arg_529_1.talkMaxDuration = var_532_24
					var_532_19 = var_532_19 + 0.3

					if var_532_24 + var_532_19 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_24 + var_532_19
					end
				end

				arg_529_1.text_.text = var_532_22
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)
				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_25 = var_532_19 + 0.3
			local var_532_26 = math.max(var_532_20, arg_529_1.talkMaxDuration)

			if var_532_19 + 0.3 <= arg_529_1.time_ and arg_529_1.time_ < var_532_25 + var_532_26 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_25) / var_532_26

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_25 + var_532_26 and arg_529_1.time_ < var_532_25 + var_532_26 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.95,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.95,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_529_1:InitPlayNodeList()
	end,
	Play1104201132 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 1104201132
		arg_535_1.duration_ = 5.83

		local var_535_0 = {
			ja = 3.533,
			ko = 5.833,
			zh = 5.833
		}
		local var_535_1 = manager.audio:GetLocalizationFlag()

		if var_535_0[var_535_1] ~= nil then
			arg_535_1.duration_ = var_535_0[var_535_1]
		end

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play1104201133(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1.var_.moveOldPos6045_story = arg_535_1.actors_["6045_story"].transform.localPosition

				local var_538_0 = GameObjectTools.GetOrAddComponent(arg_535_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_538_0 then
					var_538_0:EnableDynamicBone(false)
				end
			end

			local var_538_1 = 0.001

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_1 then
				arg_535_1.actors_["6045_story"].transform.localPosition = Vector3.Lerp(arg_535_1.var_.moveOldPos6045_story, Vector3.New(-0.7, -0.5, -6.3), (arg_535_1.time_ - 0) / var_538_1)
				arg_535_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_535_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_535_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_535_1.actors_["6045_story"].transform.position).z)
				arg_535_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_535_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_535_1.actors_["6045_story"].transform.localEulerAngles = arg_535_1.actors_["6045_story"].transform.localEulerAngles
			end

			if arg_535_1.time_ >= 0 + var_538_1 and arg_535_1.time_ < 0 + var_538_1 + arg_538_0 then
				arg_535_1.actors_["6045_story"].transform.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				arg_535_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_535_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_535_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_535_1.actors_["6045_story"].transform.position).z)
				arg_535_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_535_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_535_1.actors_["6045_story"].transform.localEulerAngles = arg_535_1.actors_["6045_story"].transform.localEulerAngles

				local var_538_2 = GameObjectTools.GetOrAddComponent(arg_535_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_538_2 then
					var_538_2:EnableDynamicBone(true)
				end
			end

			local var_538_3 = arg_535_1.actors_["6045_story"]

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 and not isNil(var_538_3) and arg_535_1.var_.characterEffect6045_story == nil then
				arg_535_1.var_.characterEffect6045_story = var_538_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_538_4 = 0.200000002980232

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_4 and not isNil(var_538_3) then
				if arg_535_1.var_.characterEffect6045_story and not isNil(var_538_3) then
					arg_535_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_535_1.time_ >= 0 + var_538_4 and arg_535_1.time_ < 0 + var_538_4 + arg_538_0 and not isNil(var_538_3) and arg_535_1.var_.characterEffect6045_story then
				arg_535_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_538_6 = arg_535_1.actors_["6046_story"].transform

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1.var_.moveOldPos6046_story = var_538_6.localPosition

				local var_538_7 = GameObjectTools.GetOrAddComponent(var_538_6.gameObject, typeof(DynamicBoneHelper))

				if var_538_7 then
					var_538_7:EnableDynamicBone(false)
				end
			end

			local var_538_8 = 0.001

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_8 then
				var_538_6.localPosition = Vector3.Lerp(arg_535_1.var_.moveOldPos6046_story, Vector3.New(0.7, -0.5, -6.3), (arg_535_1.time_ - 0) / var_538_8)
				var_538_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_538_6.position).x, (manager.ui.mainCamera.transform.position - var_538_6.position).y, (manager.ui.mainCamera.transform.position - var_538_6.position).z)
				var_538_6.localEulerAngles.z = 0
				var_538_6.localEulerAngles.x = 0
				var_538_6.localEulerAngles = var_538_6.localEulerAngles
			end

			if arg_535_1.time_ >= 0 + var_538_8 and arg_535_1.time_ < 0 + var_538_8 + arg_538_0 then
				var_538_6.localPosition = Vector3.New(0.7, -0.5, -6.3)
				var_538_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_538_6.position).x, (manager.ui.mainCamera.transform.position - var_538_6.position).y, (manager.ui.mainCamera.transform.position - var_538_6.position).z)
				var_538_6.localEulerAngles.z = 0
				var_538_6.localEulerAngles.x = 0
				var_538_6.localEulerAngles = var_538_6.localEulerAngles

				local var_538_9 = GameObjectTools.GetOrAddComponent(var_538_6.gameObject, typeof(DynamicBoneHelper))

				if var_538_9 then
					var_538_9:EnableDynamicBone(true)
				end
			end

			local var_538_10 = arg_535_1.actors_["6046_story"]

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 and not isNil(var_538_10) and arg_535_1.var_.characterEffect6046_story == nil then
				arg_535_1.var_.characterEffect6046_story = var_538_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_538_11 = 0.200000002980232

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_11 and not isNil(var_538_10) then
				if arg_535_1.var_.characterEffect6046_story and not isNil(var_538_10) then
					arg_535_1.var_.characterEffect6046_story.fillFlat = true
					arg_535_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_535_1.time_ - 0) / var_538_11)
				end
			end

			if arg_535_1.time_ >= 0 + var_538_11 and arg_535_1.time_ < 0 + var_538_11 + arg_538_0 and not isNil(var_538_10) and arg_535_1.var_.characterEffect6046_story then
				arg_535_1.var_.characterEffect6046_story.fillFlat = true
				arg_535_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_538_12 = 0
			local var_538_13 = 0.4

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= var_538_12 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				arg_535_1.leftNameTxt_.text = arg_535_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_14 = arg_535_1:GetWordFromCfg(1104201132)
				local var_538_15 = arg_535_1:FormatText(var_538_14.content)

				arg_535_1.text_.text = var_538_15

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_17 = 16 <= 0 and var_538_13 or var_538_13 * (utf8.len(var_538_15) / 16)

				if (16 <= 0 and var_538_13 or var_538_13 * (utf8.len(var_538_15) / 16)) > 0 and var_538_13 < var_538_17 then
					arg_535_1.talkMaxDuration = var_538_17

					if var_538_17 + var_538_12 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_17 + var_538_12
					end
				end

				arg_535_1.text_.text = var_538_15
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201132", "story_v_side_new_1104201.awb") ~= 0 then
					local var_538_18 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201132", "story_v_side_new_1104201.awb") / 1000

					if var_538_18 + var_538_12 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_18 + var_538_12
					end

					if var_538_14.prefab_name ~= "" and arg_535_1.actors_[var_538_14.prefab_name] ~= nil then
						local var_538_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_535_1.actors_[var_538_14.prefab_name].transform, "story_v_side_new_1104201", "1104201132", "story_v_side_new_1104201.awb")

						arg_535_1:RecordAudio("1104201132", var_538_19)
						arg_535_1:RecordAudio("1104201132", var_538_19)
					else
						arg_535_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201132", "story_v_side_new_1104201.awb")
					end

					arg_535_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201132", "story_v_side_new_1104201.awb")
				end

				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_20 = math.max(var_538_13, arg_535_1.talkMaxDuration)

			if var_538_12 <= arg_535_1.time_ and arg_535_1.time_ < var_538_12 + var_538_20 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_12) / var_538_20

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_12 + var_538_20 and arg_535_1.time_ < var_538_12 + var_538_20 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_535_1:InitPlayNodeList()
	end,
	Play1104201133 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 1104201133
		arg_539_1.duration_ = 5

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play1104201134(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 and not isNil(arg_539_1.actors_["6045_story"]) and arg_539_1.var_.characterEffect6045_story == nil then
				arg_539_1.var_.characterEffect6045_story = arg_539_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_542_0 = 0.200000002980232

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_0 and not isNil(arg_539_1.actors_["6045_story"]) then
				if arg_539_1.var_.characterEffect6045_story and not isNil(arg_539_1.actors_["6045_story"]) then
					arg_539_1.var_.characterEffect6045_story.fillFlat = true
					arg_539_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_539_1.time_ - 0) / var_542_0)
				end
			end

			if arg_539_1.time_ >= 0 + var_542_0 and arg_539_1.time_ < 0 + var_542_0 + arg_542_0 and not isNil(arg_539_1.actors_["6045_story"]) and arg_539_1.var_.characterEffect6045_story then
				arg_539_1.var_.characterEffect6045_story.fillFlat = true
				arg_539_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_542_1 = 0
			local var_542_2 = 0.55

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= var_542_1 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				arg_539_1.leftNameTxt_.text = arg_539_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, true)
				arg_539_1.iconController_:SetSelectedState("hero")

				arg_539_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_539_1.callingController_:SetSelectedState("normal")

				arg_539_1.keyicon_.color = Color.New(1, 1, 1)
				arg_539_1.icon_.color = Color.New(1, 1, 1)

				local var_542_3 = arg_539_1:FormatText(arg_539_1:GetWordFromCfg(1104201133).content)

				arg_539_1.text_.text = var_542_3

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_5 = 22 <= 0 and var_542_2 or var_542_2 * (utf8.len(var_542_3) / 22)

				if (22 <= 0 and var_542_2 or var_542_2 * (utf8.len(var_542_3) / 22)) > 0 and var_542_2 < var_542_5 then
					arg_539_1.talkMaxDuration = var_542_5

					if var_542_5 + var_542_1 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_5 + var_542_1
					end
				end

				arg_539_1.text_.text = var_542_3
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)
				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_6 = math.max(var_542_2, arg_539_1.talkMaxDuration)

			if var_542_1 <= arg_539_1.time_ and arg_539_1.time_ < var_542_1 + var_542_6 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_1) / var_542_6

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_1 + var_542_6 and arg_539_1.time_ < var_542_1 + var_542_6 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play1104201134 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 1104201134
		arg_543_1.duration_ = 5

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play1104201135(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			local var_546_0 = 0.525

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				arg_543_1.leftNameTxt_.text = arg_543_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, true)
				arg_543_1.iconController_:SetSelectedState("hero")

				arg_543_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_543_1.callingController_:SetSelectedState("normal")

				arg_543_1.keyicon_.color = Color.New(1, 1, 1)
				arg_543_1.icon_.color = Color.New(1, 1, 1)

				local var_546_1 = arg_543_1:FormatText(arg_543_1:GetWordFromCfg(1104201134).content)

				arg_543_1.text_.text = var_546_1

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_3 = 21 <= 0 and var_546_0 or var_546_0 * (utf8.len(var_546_1) / 21)

				if (21 <= 0 and var_546_0 or var_546_0 * (utf8.len(var_546_1) / 21)) > 0 and var_546_0 < var_546_3 then
					arg_543_1.talkMaxDuration = var_546_3

					if var_546_3 + 0 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_3 + 0
					end
				end

				arg_543_1.text_.text = var_546_1
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)
				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_4 = math.max(var_546_0, arg_543_1.talkMaxDuration)

			if 0 <= arg_543_1.time_ and arg_543_1.time_ < 0 + var_546_4 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - 0) / var_546_4

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= 0 + var_546_4 and arg_543_1.time_ < 0 + var_546_4 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {}

		arg_543_1:InitPlayNodeList()
	end,
	Play1104201135 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 1104201135
		arg_547_1.duration_ = 7.73

		local var_547_0 = {
			ja = 3.433,
			ko = 7.733,
			zh = 7.733
		}
		local var_547_1 = manager.audio:GetLocalizationFlag()

		if var_547_0[var_547_1] ~= nil then
			arg_547_1.duration_ = var_547_0[var_547_1]
		end

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play1104201136(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 and not isNil(arg_547_1.actors_["6046_story"]) and arg_547_1.var_.characterEffect6046_story == nil then
				arg_547_1.var_.characterEffect6046_story = arg_547_1.actors_["6046_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_550_0 = 0.200000002980232

			if 0 <= arg_547_1.time_ and arg_547_1.time_ < 0 + var_550_0 and not isNil(arg_547_1.actors_["6046_story"]) then
				if arg_547_1.var_.characterEffect6046_story and not isNil(arg_547_1.actors_["6046_story"]) then
					arg_547_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_547_1.time_ >= 0 + var_550_0 and arg_547_1.time_ < 0 + var_550_0 + arg_550_0 and not isNil(arg_547_1.actors_["6046_story"]) and arg_547_1.var_.characterEffect6046_story then
				arg_547_1.var_.characterEffect6046_story.fillFlat = false
			end

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 then
				arg_547_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 then
				arg_547_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_550_2 = 0
			local var_550_3 = 0.75

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= var_550_2 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, true)

				arg_547_1.leftNameTxt_.text = arg_547_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_547_1.leftNameTxt_.transform)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1.leftNameTxt_.text)
				SetActive(arg_547_1.iconTrs_.gameObject, false)
				arg_547_1.callingController_:SetSelectedState("normal")

				local var_550_4 = arg_547_1:GetWordFromCfg(1104201135)
				local var_550_5 = arg_547_1:FormatText(var_550_4.content)

				arg_547_1.text_.text = var_550_5

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_7 = 30 <= 0 and var_550_3 or var_550_3 * (utf8.len(var_550_5) / 30)

				if (30 <= 0 and var_550_3 or var_550_3 * (utf8.len(var_550_5) / 30)) > 0 and var_550_3 < var_550_7 then
					arg_547_1.talkMaxDuration = var_550_7

					if var_550_7 + var_550_2 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_7 + var_550_2
					end
				end

				arg_547_1.text_.text = var_550_5
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201135", "story_v_side_new_1104201.awb") ~= 0 then
					local var_550_8 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201135", "story_v_side_new_1104201.awb") / 1000

					if var_550_8 + var_550_2 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_8 + var_550_2
					end

					if var_550_4.prefab_name ~= "" and arg_547_1.actors_[var_550_4.prefab_name] ~= nil then
						local var_550_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_547_1.actors_[var_550_4.prefab_name].transform, "story_v_side_new_1104201", "1104201135", "story_v_side_new_1104201.awb")

						arg_547_1:RecordAudio("1104201135", var_550_9)
						arg_547_1:RecordAudio("1104201135", var_550_9)
					else
						arg_547_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201135", "story_v_side_new_1104201.awb")
					end

					arg_547_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201135", "story_v_side_new_1104201.awb")
				end

				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_10 = math.max(var_550_3, arg_547_1.talkMaxDuration)

			if var_550_2 <= arg_547_1.time_ and arg_547_1.time_ < var_550_2 + var_550_10 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - var_550_2) / var_550_10

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= var_550_2 + var_550_10 and arg_547_1.time_ < var_550_2 + var_550_10 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {}

		arg_547_1:InitPlayNodeList()
	end,
	Play1104201136 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 1104201136
		arg_551_1.duration_ = 4.8

		local var_551_0 = {
			ja = 4.1,
			ko = 4.8,
			zh = 4.8
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
			arg_551_1.auto_ = false
		end

		function arg_551_1.playNext_(arg_553_0)
			arg_551_1.onStoryFinished_()
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 and not isNil(arg_551_1.actors_["6045_story"]) and arg_551_1.var_.characterEffect6045_story == nil then
				arg_551_1.var_.characterEffect6045_story = arg_551_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_554_0 = 0.200000002980232

			if 0 <= arg_551_1.time_ and arg_551_1.time_ < 0 + var_554_0 and not isNil(arg_551_1.actors_["6045_story"]) then
				if arg_551_1.var_.characterEffect6045_story and not isNil(arg_551_1.actors_["6045_story"]) then
					arg_551_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_551_1.time_ >= 0 + var_554_0 and arg_551_1.time_ < 0 + var_554_0 + arg_554_0 and not isNil(arg_551_1.actors_["6045_story"]) and arg_551_1.var_.characterEffect6045_story then
				arg_551_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 then
				arg_551_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 then
				arg_551_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_554_2 = arg_551_1.actors_["6046_story"]

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 and not isNil(var_554_2) and arg_551_1.var_.characterEffect6046_story == nil then
				arg_551_1.var_.characterEffect6046_story = var_554_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_554_3 = 0.200000002980232

			if 0 <= arg_551_1.time_ and arg_551_1.time_ < 0 + var_554_3 and not isNil(var_554_2) then
				if arg_551_1.var_.characterEffect6046_story and not isNil(var_554_2) then
					arg_551_1.var_.characterEffect6046_story.fillFlat = true
					arg_551_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_551_1.time_ - 0) / var_554_3)
				end
			end

			if arg_551_1.time_ >= 0 + var_554_3 and arg_551_1.time_ < 0 + var_554_3 + arg_554_0 and not isNil(var_554_2) and arg_551_1.var_.characterEffect6046_story then
				arg_551_1.var_.characterEffect6046_story.fillFlat = true
				arg_551_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_554_4 = 0
			local var_554_5 = 0.4

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= var_554_4 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, true)

				arg_551_1.leftNameTxt_.text = arg_551_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, false)
				arg_551_1.callingController_:SetSelectedState("normal")

				local var_554_6 = arg_551_1:GetWordFromCfg(1104201136)
				local var_554_7 = arg_551_1:FormatText(var_554_6.content)

				arg_551_1.text_.text = var_554_7

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_9 = 16 <= 0 and var_554_5 or var_554_5 * (utf8.len(var_554_7) / 16)

				if (16 <= 0 and var_554_5 or var_554_5 * (utf8.len(var_554_7) / 16)) > 0 and var_554_5 < var_554_9 then
					arg_551_1.talkMaxDuration = var_554_9

					if var_554_9 + var_554_4 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_9 + var_554_4
					end
				end

				arg_551_1.text_.text = var_554_7
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201136", "story_v_side_new_1104201.awb") ~= 0 then
					local var_554_10 = manager.audio:GetVoiceLength("story_v_side_new_1104201", "1104201136", "story_v_side_new_1104201.awb") / 1000

					if var_554_10 + var_554_4 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_10 + var_554_4
					end

					if var_554_6.prefab_name ~= "" and arg_551_1.actors_[var_554_6.prefab_name] ~= nil then
						local var_554_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_551_1.actors_[var_554_6.prefab_name].transform, "story_v_side_new_1104201", "1104201136", "story_v_side_new_1104201.awb")

						arg_551_1:RecordAudio("1104201136", var_554_11)
						arg_551_1:RecordAudio("1104201136", var_554_11)
					else
						arg_551_1:AudioAction("play", "voice", "story_v_side_new_1104201", "1104201136", "story_v_side_new_1104201.awb")
					end

					arg_551_1:RecordHistoryTalkVoice("story_v_side_new_1104201", "1104201136", "story_v_side_new_1104201.awb")
				end

				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_12 = math.max(var_554_5, arg_551_1.talkMaxDuration)

			if var_554_4 <= arg_551_1.time_ and arg_551_1.time_ < var_554_4 + var_554_12 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - var_554_4) / var_554_12

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= var_554_4 + var_554_12 and arg_551_1.time_ < var_554_4 + var_554_12 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {}

		arg_551_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F01a",
		"TextureConfig/Background/ST22"
	},
	voices = {
		"story_v_side_new_1104201.awb"
	}
}
