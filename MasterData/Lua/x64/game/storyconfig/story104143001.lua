return {
	Play414301001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 414301001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play414301002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.H07f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H07f")
				var_4_0.name = "H07f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.H07f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.H07f

				arg_1_1.bgs_.H07f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "H07f" then
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

			if 0.4 < arg_1_1.time_ and arg_1_1.time_ <= 0.4 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax")

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
			local var_4_15 = 0.825

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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(414301001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 33 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 33)

				if (33 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 33)) > 0 and var_4_15 < var_4_19 then
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
	Play414301002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 414301002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play414301003(arg_9_1)
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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(414301002).content)

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
	Play414301003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 414301003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play414301004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 1.2

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(414301003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 48 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 48)

				if (48 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 48)) > 0 and var_16_0 < var_16_3 then
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
	Play414301004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 414301004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play414301005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 1.05

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

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(414301004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 42 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 42)

				if (42 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 42)) > 0 and var_20_0 < var_20_3 then
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
	Play414301005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 414301005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play414301006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.2

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

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(414301005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 8 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 8)

				if (8 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 8)) > 0 and var_24_0 < var_24_3 then
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
	Play414301006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 414301006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play414301007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if arg_25_1.actors_["104902ui_story"] == nil and not isNil((Asset.Load("Char/" .. "104902ui_story"))) then
				local var_28_0 = Object.Instantiate(Asset.Load("Char/" .. "104902ui_story"), arg_25_1.stage_.transform)

				var_28_0.name = "104902ui_story"
				var_28_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["104902ui_story"] = var_28_0

				local var_28_1 = var_28_0:GetComponentInChildren(typeof(CharacterEffect))

				var_28_1.enabled = true

				local var_28_2 = GameObjectTools.GetOrAddComponent(var_28_0, typeof(DynamicBoneHelper))

				if var_28_2 then
					var_28_2:EnableDynamicBone(false)
				end

				arg_25_1:ShowWeapon(var_28_1.transform, false)

				arg_25_1.var_["104902ui_story" .. "Animator"] = var_28_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_25_1.var_["104902ui_story" .. "Animator"].applyRootMotion = true
				arg_25_1.var_["104902ui_story" .. "LipSync"] = var_28_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_28_3 = arg_25_1.actors_["104902ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos104902ui_story = var_28_3.localPosition

				arg_25_1:ShowWeapon(arg_25_1.var_["104902ui_story" .. "Animator"].transform, false)
			end

			local var_28_4 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				var_28_3.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos104902ui_story, Vector3.New(0, -1.2, -6), (arg_25_1.time_ - 0) / var_28_4)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				var_28_3.localPosition = Vector3.New(0, -1.2, -6)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			local var_28_5 = arg_25_1.actors_["104902ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect104902ui_story == nil then
				arg_25_1.var_.characterEffect104902ui_story = var_28_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_6 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_6 and not isNil(var_28_5) then
				if arg_25_1.var_.characterEffect104902ui_story and not isNil(var_28_5) then
					arg_25_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_6 and arg_25_1.time_ < 0 + var_28_6 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect104902ui_story then
				arg_25_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/story104902/story104902action/104902action4_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_28_8 = 0
			local var_28_9 = 0.475

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_10 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(414301006).content)

				arg_25_1.text_.text = var_28_10

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_12 = 19 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_10) / 19)

				if (19 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_10) / 19)) > 0 and var_28_9 < var_28_12 then
					arg_25_1.talkMaxDuration = var_28_12

					if var_28_12 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_12 + var_28_8
					end
				end

				arg_25_1.text_.text = var_28_10
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_13 = math.max(var_28_9, arg_25_1.talkMaxDuration)

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_13 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_8) / var_28_13

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_8 + var_28_13 and arg_25_1.time_ < var_28_8 + var_28_13 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902ui_story",
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
	Play414301007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 414301007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play414301008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.525

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(414301007).content)

				arg_29_1.text_.text = var_32_1

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_3 = 21 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 21)

				if (21 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 21)) > 0 and var_32_0 < var_32_3 then
					arg_29_1.talkMaxDuration = var_32_3

					if var_32_3 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_3 + 0
					end
				end

				arg_29_1.text_.text = var_32_1
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_4 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_4

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play414301008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 414301008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play414301009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["104902ui_story"]) and arg_33_1.var_.characterEffect104902ui_story == nil then
				arg_33_1.var_.characterEffect104902ui_story = arg_33_1.actors_["104902ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["104902ui_story"]) then
				if arg_33_1.var_.characterEffect104902ui_story and not isNil(arg_33_1.actors_["104902ui_story"]) then
					arg_33_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_33_1.var_.characterEffect104902ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["104902ui_story"]) and arg_33_1.var_.characterEffect104902ui_story then
				arg_33_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_33_1.var_.characterEffect104902ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0
			local var_36_2 = 0.6

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

				local var_36_3 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(414301008).content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 24 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 24)

				if (24 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 24)) > 0 and var_36_2 < var_36_5 then
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
	Play414301009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 414301009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play414301010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.675

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

				local var_40_1 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(414301009).content)

				arg_37_1.text_.text = var_40_1

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_3 = 27 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 27)

				if (27 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 27)) > 0 and var_40_0 < var_40_3 then
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
	Play414301010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 414301010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play414301011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos104902ui_story = arg_41_1.actors_["104902ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["104902ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos104902ui_story, Vector3.New(0, 100, 0), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["104902ui_story"].transform.position).z)
				arg_41_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["104902ui_story"].transform.localEulerAngles = arg_41_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["104902ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_41_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["104902ui_story"].transform.position).z)
				arg_41_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["104902ui_story"].transform.localEulerAngles = arg_41_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			local var_44_1 = 0
			local var_44_2 = 1.15

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_3 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(414301010).content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 46 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 46)

				if (46 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 46)) > 0 and var_44_2 < var_44_5 then
					arg_41_1.talkMaxDuration = var_44_5

					if var_44_5 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + var_44_1
					end
				end

				arg_41_1.text_.text = var_44_3
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_6 = math.max(var_44_2, arg_41_1.talkMaxDuration)

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_6 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_1) / var_44_6

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_1 + var_44_6 and arg_41_1.time_ < var_44_1 + var_44_6 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902ui_story",
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
	Play414301011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 414301011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play414301012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.525

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

				local var_48_1 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(414301011).content)

				arg_45_1.text_.text = var_48_1

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_3 = 21 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 21)

				if (21 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 21)) > 0 and var_48_0 < var_48_3 then
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
	Play414301012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 414301012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play414301013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if arg_49_1.actors_["1035ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1035ui_story"))) then
				local var_52_0 = Object.Instantiate(Asset.Load("Char/" .. "1035ui_story"), arg_49_1.stage_.transform)

				var_52_0.name = "1035ui_story"
				var_52_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_49_1.actors_["1035ui_story"] = var_52_0

				local var_52_1 = var_52_0:GetComponentInChildren(typeof(CharacterEffect))

				var_52_1.enabled = true

				local var_52_2 = GameObjectTools.GetOrAddComponent(var_52_0, typeof(DynamicBoneHelper))

				if var_52_2 then
					var_52_2:EnableDynamicBone(false)
				end

				arg_49_1:ShowWeapon(var_52_1.transform, false)

				arg_49_1.var_["1035ui_story" .. "Animator"] = var_52_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_49_1.var_["1035ui_story" .. "Animator"].applyRootMotion = true
				arg_49_1.var_["1035ui_story" .. "LipSync"] = var_52_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_52_3 = arg_49_1.actors_["1035ui_story"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1035ui_story = var_52_3.localPosition
			end

			local var_52_4 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				var_52_3.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1035ui_story, Vector3.New(0, -1.05, -5.6), (arg_49_1.time_ - 0) / var_52_4)
				var_52_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_3.position).x, (manager.ui.mainCamera.transform.position - var_52_3.position).y, (manager.ui.mainCamera.transform.position - var_52_3.position).z)
				var_52_3.localEulerAngles.z = 0
				var_52_3.localEulerAngles.x = 0
				var_52_3.localEulerAngles = var_52_3.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				var_52_3.localPosition = Vector3.New(0, -1.05, -5.6)
				var_52_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_3.position).x, (manager.ui.mainCamera.transform.position - var_52_3.position).y, (manager.ui.mainCamera.transform.position - var_52_3.position).z)
				var_52_3.localEulerAngles.z = 0
				var_52_3.localEulerAngles.x = 0
				var_52_3.localEulerAngles = var_52_3.localEulerAngles
			end

			local var_52_5 = arg_49_1.actors_["1035ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_5) and arg_49_1.var_.characterEffect1035ui_story == nil then
				arg_49_1.var_.characterEffect1035ui_story = var_52_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_6 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_6 and not isNil(var_52_5) then
				if arg_49_1.var_.characterEffect1035ui_story and not isNil(var_52_5) then
					arg_49_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_6 and arg_49_1.time_ < 0 + var_52_6 + arg_52_0 and not isNil(var_52_5) and arg_49_1.var_.characterEffect1035ui_story then
				arg_49_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action4_1")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_52_8 = 0
			local var_52_9 = 0.3

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_10 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(414301012).content)

				arg_49_1.text_.text = var_52_10

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_12 = 12 <= 0 and var_52_9 or var_52_9 * (utf8.len(var_52_10) / 12)

				if (12 <= 0 and var_52_9 or var_52_9 * (utf8.len(var_52_10) / 12)) > 0 and var_52_9 < var_52_12 then
					arg_49_1.talkMaxDuration = var_52_12

					if var_52_12 + var_52_8 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_12 + var_52_8
					end
				end

				arg_49_1.text_.text = var_52_10
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_13 = math.max(var_52_9, arg_49_1.talkMaxDuration)

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_13 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_8) / var_52_13

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_8 + var_52_13 and arg_49_1.time_ < var_52_8 + var_52_13 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
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
	Play414301013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 414301013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play414301014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1035ui_story = arg_53_1.actors_["1035ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["1035ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1035ui_story, Vector3.New(0, 100, 0), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1035ui_story"].transform.position).z)
				arg_53_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1035ui_story"].transform.localEulerAngles = arg_53_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["1035ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1035ui_story"].transform.position).z)
				arg_53_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1035ui_story"].transform.localEulerAngles = arg_53_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["1035ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1035ui_story == nil then
				arg_53_1.var_.characterEffect1035ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect1035ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect1035ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1035ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_2)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1035ui_story then
				arg_53_1.var_.characterEffect1035ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1035ui_story.fillRatio = 0.5
			end

			local var_56_3 = "1016ui_story"

			if arg_53_1.actors_["1016ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1016ui_story"))) then
				local var_56_4 = Object.Instantiate(Asset.Load("Char/" .. "1016ui_story"), arg_53_1.stage_.transform)

				var_56_4.name = var_56_3
				var_56_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.actors_[var_56_3] = var_56_4

				local var_56_5 = var_56_4:GetComponentInChildren(typeof(CharacterEffect))

				var_56_5.enabled = true

				local var_56_6 = GameObjectTools.GetOrAddComponent(var_56_4, typeof(DynamicBoneHelper))

				if var_56_6 then
					var_56_6:EnableDynamicBone(false)
				end

				arg_53_1:ShowWeapon(var_56_5.transform, false)

				arg_53_1.var_[var_56_3 .. "Animator"] = var_56_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_53_1.var_[var_56_3 .. "Animator"].applyRootMotion = true
				arg_53_1.var_[var_56_3 .. "LipSync"] = var_56_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_56_7 = arg_53_1.actors_["1016ui_story"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1016ui_story = var_56_7.localPosition

				arg_53_1:ShowWeapon(arg_53_1.var_["1016ui_story" .. "Animator"].transform, false)
			end

			local var_56_8 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_8 then
				var_56_7.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1016ui_story, Vector3.New(0, -18.66, -121.78), (arg_53_1.time_ - 0) / var_56_8)
				var_56_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_7.position).x, (manager.ui.mainCamera.transform.position - var_56_7.position).y, (manager.ui.mainCamera.transform.position - var_56_7.position).z)
				var_56_7.localEulerAngles.z = 0
				var_56_7.localEulerAngles.x = 0
				var_56_7.localEulerAngles = var_56_7.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_8 and arg_53_1.time_ < 0 + var_56_8 + arg_56_0 then
				var_56_7.localPosition = Vector3.New(0, -18.66, -121.78)
				var_56_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_7.position).x, (manager.ui.mainCamera.transform.position - var_56_7.position).y, (manager.ui.mainCamera.transform.position - var_56_7.position).z)
				var_56_7.localEulerAngles.z = 0
				var_56_7.localEulerAngles.x = 0
				var_56_7.localEulerAngles = var_56_7.localEulerAngles
			end

			local var_56_9 = arg_53_1.actors_["1016ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_9) and arg_53_1.var_.characterEffect1016ui_story == nil then
				arg_53_1.var_.characterEffect1016ui_story = var_56_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_10 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_10 and not isNil(var_56_9) then
				if arg_53_1.var_.characterEffect1016ui_story and not isNil(var_56_9) then
					arg_53_1.var_.characterEffect1016ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_10 and arg_53_1.time_ < 0 + var_56_10 + arg_56_0 and not isNil(var_56_9) and arg_53_1.var_.characterEffect1016ui_story then
				arg_53_1.var_.characterEffect1016ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/story1016/story1016action/1016action3_1")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_56_12 = 0
			local var_56_13 = 0.475

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_12 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[260].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_14 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(414301013).content)

				arg_53_1.text_.text = var_56_14

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_16 = 19 <= 0 and var_56_13 or var_56_13 * (utf8.len(var_56_14) / 19)

				if (19 <= 0 and var_56_13 or var_56_13 * (utf8.len(var_56_14) / 19)) > 0 and var_56_13 < var_56_16 then
					arg_53_1.talkMaxDuration = var_56_16

					if var_56_16 + var_56_12 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_16 + var_56_12
					end
				end

				arg_53_1.text_.text = var_56_14
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_17 = math.max(var_56_13, arg_53_1.talkMaxDuration)

			if var_56_12 <= arg_53_1.time_ and arg_53_1.time_ < var_56_12 + var_56_17 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_12) / var_56_17

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_12 + var_56_17 and arg_53_1.time_ < var_56_12 + var_56_17 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play414301014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 414301014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play414301015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1035ui_story = arg_57_1.actors_["1035ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["1035ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1035ui_story, Vector3.New(0, -1.05, -5.6), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1035ui_story"].transform.position).z)
				arg_57_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1035ui_story"].transform.localEulerAngles = arg_57_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["1035ui_story"].transform.localPosition = Vector3.New(0, -1.05, -5.6)
				arg_57_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1035ui_story"].transform.position).z)
				arg_57_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1035ui_story"].transform.localEulerAngles = arg_57_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["1035ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1035ui_story == nil then
				arg_57_1.var_.characterEffect1035ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect1035ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1035ui_story then
				arg_57_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035actionlink/1035action446")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_60_4 = arg_57_1.actors_["1016ui_story"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1016ui_story = var_60_4.localPosition
			end

			local var_60_5 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_5 then
				var_60_4.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1016ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 0) / var_60_5)
				var_60_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_4.position).x, (manager.ui.mainCamera.transform.position - var_60_4.position).y, (manager.ui.mainCamera.transform.position - var_60_4.position).z)
				var_60_4.localEulerAngles.z = 0
				var_60_4.localEulerAngles.x = 0
				var_60_4.localEulerAngles = var_60_4.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_5 and arg_57_1.time_ < 0 + var_60_5 + arg_60_0 then
				var_60_4.localPosition = Vector3.New(0, 100, 0)
				var_60_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_4.position).x, (manager.ui.mainCamera.transform.position - var_60_4.position).y, (manager.ui.mainCamera.transform.position - var_60_4.position).z)
				var_60_4.localEulerAngles.z = 0
				var_60_4.localEulerAngles.x = 0
				var_60_4.localEulerAngles = var_60_4.localEulerAngles
			end

			local var_60_6 = arg_57_1.actors_["1016ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_6) and arg_57_1.var_.characterEffect1016ui_story == nil then
				arg_57_1.var_.characterEffect1016ui_story = var_60_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_7 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_7 and not isNil(var_60_6) then
				if arg_57_1.var_.characterEffect1016ui_story and not isNil(var_60_6) then
					arg_57_1.var_.characterEffect1016ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1016ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_7)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_7 and arg_57_1.time_ < 0 + var_60_7 + arg_60_0 and not isNil(var_60_6) and arg_57_1.var_.characterEffect1016ui_story then
				arg_57_1.var_.characterEffect1016ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1016ui_story.fillRatio = 0.5
			end

			local var_60_8 = 0
			local var_60_9 = 0.45

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_10 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(414301014).content)

				arg_57_1.text_.text = var_60_10

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_12 = 18 <= 0 and var_60_9 or var_60_9 * (utf8.len(var_60_10) / 18)

				if (18 <= 0 and var_60_9 or var_60_9 * (utf8.len(var_60_10) / 18)) > 0 and var_60_9 < var_60_12 then
					arg_57_1.talkMaxDuration = var_60_12

					if var_60_12 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_12 + var_60_8
					end
				end

				arg_57_1.text_.text = var_60_10
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_13 = math.max(var_60_9, arg_57_1.talkMaxDuration)

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_13 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_8) / var_60_13

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_8 + var_60_13 and arg_57_1.time_ < var_60_8 + var_60_13 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1016ui_story",
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
	Play414301015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 414301015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play414301016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1035ui_story = arg_61_1.actors_["1035ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["1035ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1035ui_story, Vector3.New(0, 100, 0), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1035ui_story"].transform.position).z)
				arg_61_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1035ui_story"].transform.localEulerAngles = arg_61_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["1035ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_61_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1035ui_story"].transform.position).z)
				arg_61_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1035ui_story"].transform.localEulerAngles = arg_61_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			local var_64_1 = arg_61_1.actors_["1035ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1035ui_story == nil then
				arg_61_1.var_.characterEffect1035ui_story = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 and not isNil(var_64_1) then
				if arg_61_1.var_.characterEffect1035ui_story and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect1035ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1035ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_2)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1035ui_story then
				arg_61_1.var_.characterEffect1035ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1035ui_story.fillRatio = 0.5
			end

			local var_64_3 = arg_61_1.actors_["104902ui_story"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos104902ui_story = var_64_3.localPosition
			end

			local var_64_4 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				var_64_3.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos104902ui_story, Vector3.New(0, -1.2, -6), (arg_61_1.time_ - 0) / var_64_4)
				var_64_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_3.position).x, (manager.ui.mainCamera.transform.position - var_64_3.position).y, (manager.ui.mainCamera.transform.position - var_64_3.position).z)
				var_64_3.localEulerAngles.z = 0
				var_64_3.localEulerAngles.x = 0
				var_64_3.localEulerAngles = var_64_3.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				var_64_3.localPosition = Vector3.New(0, -1.2, -6)
				var_64_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_3.position).x, (manager.ui.mainCamera.transform.position - var_64_3.position).y, (manager.ui.mainCamera.transform.position - var_64_3.position).z)
				var_64_3.localEulerAngles.z = 0
				var_64_3.localEulerAngles.x = 0
				var_64_3.localEulerAngles = var_64_3.localEulerAngles
			end

			local var_64_5 = arg_61_1.actors_["104902ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_5) and arg_61_1.var_.characterEffect104902ui_story == nil then
				arg_61_1.var_.characterEffect104902ui_story = var_64_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_6 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_6 and not isNil(var_64_5) then
				if arg_61_1.var_.characterEffect104902ui_story and not isNil(var_64_5) then
					arg_61_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_6 and arg_61_1.time_ < 0 + var_64_6 + arg_64_0 and not isNil(var_64_5) and arg_61_1.var_.characterEffect104902ui_story then
				arg_61_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/story104902/story104902action/104902action4_2")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_64_8 = 0
			local var_64_9 = 0.525

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_10 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(414301015).content)

				arg_61_1.text_.text = var_64_10

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_12 = 21 <= 0 and var_64_9 or var_64_9 * (utf8.len(var_64_10) / 21)

				if (21 <= 0 and var_64_9 or var_64_9 * (utf8.len(var_64_10) / 21)) > 0 and var_64_9 < var_64_12 then
					arg_61_1.talkMaxDuration = var_64_12

					if var_64_12 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_12 + var_64_8
					end
				end

				arg_61_1.text_.text = var_64_10
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_13 = math.max(var_64_9, arg_61_1.talkMaxDuration)

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_13 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_8) / var_64_13

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_8 + var_64_13 and arg_61_1.time_ < var_64_8 + var_64_13 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "104902ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play414301016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 414301016
		arg_65_1.duration_ = 1

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"

			SetActive(arg_65_1.choicesGo_, true)

			for iter_66_0, iter_66_1 in ipairs(arg_65_1.choices_) do
				SetActive(iter_66_1.go, iter_66_0 <= 2)
			end

			arg_65_1.choices_[1].txt.text = arg_65_1:FormatText(StoryChoiceCfg[884].name)
			arg_65_1.choices_[2].txt.text = arg_65_1:FormatText(StoryChoiceCfg[885].name)
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play414301017(arg_65_1)
			end

			if arg_67_0 == 2 then
				arg_65_0:Play414301019(arg_65_1)
			end

			arg_65_1:RecordChoiceLog(414301016, 884, 885)
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["104902ui_story"]) and arg_65_1.var_.characterEffect104902ui_story == nil then
				arg_65_1.var_.characterEffect104902ui_story = arg_65_1.actors_["104902ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["104902ui_story"]) then
				if arg_65_1.var_.characterEffect104902ui_story and not isNil(arg_65_1.actors_["104902ui_story"]) then
					arg_65_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_65_1.var_.characterEffect104902ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_0)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["104902ui_story"]) and arg_65_1.var_.characterEffect104902ui_story then
				arg_65_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_65_1.var_.characterEffect104902ui_story.fillRatio = 0.5
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play414301017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 414301017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play414301018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.475

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_1 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(414301017).content)

				arg_69_1.text_.text = var_72_1

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_3 = 19 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 19)

				if (19 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 19)) > 0 and var_72_0 < var_72_3 then
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
	Play414301018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 414301018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play414301020(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["104902ui_story"]) and arg_73_1.var_.characterEffect104902ui_story == nil then
				arg_73_1.var_.characterEffect104902ui_story = arg_73_1.actors_["104902ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["104902ui_story"]) then
				if arg_73_1.var_.characterEffect104902ui_story and not isNil(arg_73_1.actors_["104902ui_story"]) then
					arg_73_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["104902ui_story"]) and arg_73_1.var_.characterEffect104902ui_story then
				arg_73_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_76_2 = 0
			local var_76_3 = 0.4

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_4 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(414301018).content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_6 = 16 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_4) / 16)

				if (16 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_4) / 16)) > 0 and var_76_3 < var_76_6 then
					arg_73_1.talkMaxDuration = var_76_6

					if var_76_6 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_6 + var_76_2
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_7 = math.max(var_76_3, arg_73_1.talkMaxDuration)

			if var_76_2 <= arg_73_1.time_ and arg_73_1.time_ < var_76_2 + var_76_7 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_2) / var_76_7

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_2 + var_76_7 and arg_73_1.time_ < var_76_2 + var_76_7 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play414301020 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 414301020
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play414301021(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["104902ui_story"]) and arg_77_1.var_.characterEffect104902ui_story == nil then
				arg_77_1.var_.characterEffect104902ui_story = arg_77_1.actors_["104902ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["104902ui_story"]) then
				if arg_77_1.var_.characterEffect104902ui_story and not isNil(arg_77_1.actors_["104902ui_story"]) then
					arg_77_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_77_1.var_.characterEffect104902ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_0)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["104902ui_story"]) and arg_77_1.var_.characterEffect104902ui_story then
				arg_77_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_77_1.var_.characterEffect104902ui_story.fillRatio = 0.5
			end

			local var_80_1 = 0
			local var_80_2 = 0.525

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
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

				local var_80_3 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(414301020).content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 21 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 21)

				if (21 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 21)) > 0 and var_80_2 < var_80_5 then
					arg_77_1.talkMaxDuration = var_80_5

					if var_80_5 + var_80_1 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + var_80_1
					end
				end

				arg_77_1.text_.text = var_80_3
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_6 = math.max(var_80_2, arg_77_1.talkMaxDuration)

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_6 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_1) / var_80_6

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_1 + var_80_6 and arg_77_1.time_ < var_80_1 + var_80_6 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play414301021 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 414301021
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play414301022(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["104902ui_story"]) and arg_81_1.var_.characterEffect104902ui_story == nil then
				arg_81_1.var_.characterEffect104902ui_story = arg_81_1.actors_["104902ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["104902ui_story"]) then
				if arg_81_1.var_.characterEffect104902ui_story and not isNil(arg_81_1.actors_["104902ui_story"]) then
					arg_81_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["104902ui_story"]) and arg_81_1.var_.characterEffect104902ui_story then
				arg_81_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			local var_84_2 = 0
			local var_84_3 = 0.4

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_2 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_4 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(414301021).content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_6 = 16 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_4) / 16)

				if (16 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_4) / 16)) > 0 and var_84_3 < var_84_6 then
					arg_81_1.talkMaxDuration = var_84_6

					if var_84_6 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_6 + var_84_2
					end
				end

				arg_81_1.text_.text = var_84_4
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_7 = math.max(var_84_3, arg_81_1.talkMaxDuration)

			if var_84_2 <= arg_81_1.time_ and arg_81_1.time_ < var_84_2 + var_84_7 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_2) / var_84_7

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_2 + var_84_7 and arg_81_1.time_ < var_84_2 + var_84_7 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play414301022 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 414301022
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play414301023(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["104902ui_story"]) and arg_85_1.var_.characterEffect104902ui_story == nil then
				arg_85_1.var_.characterEffect104902ui_story = arg_85_1.actors_["104902ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["104902ui_story"]) then
				if arg_85_1.var_.characterEffect104902ui_story and not isNil(arg_85_1.actors_["104902ui_story"]) then
					arg_85_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_85_1.var_.characterEffect104902ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_0)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["104902ui_story"]) and arg_85_1.var_.characterEffect104902ui_story then
				arg_85_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_85_1.var_.characterEffect104902ui_story.fillRatio = 0.5
			end

			local var_88_1 = 0
			local var_88_2 = 0.225

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

				local var_88_3 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(414301022).content)

				arg_85_1.text_.text = var_88_3

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 9 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 9)

				if (9 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 9)) > 0 and var_88_2 < var_88_5 then
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
	Play414301023 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 414301023
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play414301024(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos104902ui_story = arg_89_1.actors_["104902ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["104902ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos104902ui_story, Vector3.New(0, -1.2, -6), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["104902ui_story"].transform.position).z)
				arg_89_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["104902ui_story"].transform.localEulerAngles = arg_89_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["104902ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_89_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["104902ui_story"].transform.position).z)
				arg_89_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["104902ui_story"].transform.localEulerAngles = arg_89_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			local var_92_1 = arg_89_1.actors_["104902ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect104902ui_story == nil then
				arg_89_1.var_.characterEffect104902ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect104902ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect104902ui_story then
				arg_89_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/story104902/story104902action/104902action1_1")
			end

			local var_92_4 = 0
			local var_92_5 = 0.425

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_6 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(414301023).content)

				arg_89_1.text_.text = var_92_6

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_8 = 17 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_6) / 17)

				if (17 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_6) / 17)) > 0 and var_92_5 < var_92_8 then
					arg_89_1.talkMaxDuration = var_92_8

					if var_92_8 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_6
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_9 = math.max(var_92_5, arg_89_1.talkMaxDuration)

			if var_92_4 <= arg_89_1.time_ and arg_89_1.time_ < var_92_4 + var_92_9 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_4) / var_92_9

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_4 + var_92_9 and arg_89_1.time_ < var_92_4 + var_92_9 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902ui_story",
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
	Play414301024 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 414301024
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play414301025(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["104902ui_story"]) and arg_93_1.var_.characterEffect104902ui_story == nil then
				arg_93_1.var_.characterEffect104902ui_story = arg_93_1.actors_["104902ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["104902ui_story"]) then
				if arg_93_1.var_.characterEffect104902ui_story and not isNil(arg_93_1.actors_["104902ui_story"]) then
					arg_93_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_93_1.var_.characterEffect104902ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_0)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["104902ui_story"]) and arg_93_1.var_.characterEffect104902ui_story then
				arg_93_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_93_1.var_.characterEffect104902ui_story.fillRatio = 0.5
			end

			local var_96_1 = 0
			local var_96_2 = 0.725

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

				local var_96_3 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(414301024).content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 29 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 29)

				if (29 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 29)) > 0 and var_96_2 < var_96_5 then
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
	Play414301025 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 414301025
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play414301026(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos104902ui_story = arg_97_1.actors_["104902ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["104902ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos104902ui_story, Vector3.New(0, -1.2, -6), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["104902ui_story"].transform.position).z)
				arg_97_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["104902ui_story"].transform.localEulerAngles = arg_97_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["104902ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_97_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["104902ui_story"].transform.position).z)
				arg_97_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["104902ui_story"].transform.localEulerAngles = arg_97_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["104902ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect104902ui_story == nil then
				arg_97_1.var_.characterEffect104902ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect104902ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect104902ui_story then
				arg_97_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/story104902/story104902action/104902action5_1")
			end

			local var_100_4 = 0
			local var_100_5 = 0.3

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_6 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(414301025).content)

				arg_97_1.text_.text = var_100_6

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_8 = 12 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_6) / 12)

				if (12 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_6) / 12)) > 0 and var_100_5 < var_100_8 then
					arg_97_1.talkMaxDuration = var_100_8

					if var_100_8 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_4
					end
				end

				arg_97_1.text_.text = var_100_6
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_9 = math.max(var_100_5, arg_97_1.talkMaxDuration)

			if var_100_4 <= arg_97_1.time_ and arg_97_1.time_ < var_100_4 + var_100_9 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_4) / var_100_9

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_4 + var_100_9 and arg_97_1.time_ < var_100_4 + var_100_9 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play414301026 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 414301026
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play414301027(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["104902ui_story"]) and arg_101_1.var_.characterEffect104902ui_story == nil then
				arg_101_1.var_.characterEffect104902ui_story = arg_101_1.actors_["104902ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["104902ui_story"]) then
				if arg_101_1.var_.characterEffect104902ui_story and not isNil(arg_101_1.actors_["104902ui_story"]) then
					arg_101_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_101_1.var_.characterEffect104902ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_0)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["104902ui_story"]) and arg_101_1.var_.characterEffect104902ui_story then
				arg_101_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_101_1.var_.characterEffect104902ui_story.fillRatio = 0.5
			end

			local var_104_1 = 0
			local var_104_2 = 0.75

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

				local var_104_3 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(414301026).content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 30 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 30)

				if (30 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 30)) > 0 and var_104_2 < var_104_5 then
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
	Play414301027 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 414301027
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play414301028(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.5

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_1 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(414301027).content)

				arg_105_1.text_.text = var_108_1

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_3 = 20 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 20)

				if (20 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 20)) > 0 and var_108_0 < var_108_3 then
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
	Play414301028 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 414301028
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play414301029(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/story104902/story104902action/104902action5_2")
			end

			local var_112_0 = arg_109_1.actors_["104902ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect104902ui_story == nil then
				arg_109_1.var_.characterEffect104902ui_story = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_1 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_1 and not isNil(var_112_0) then
				if arg_109_1.var_.characterEffect104902ui_story and not isNil(var_112_0) then
					arg_109_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_1 and arg_109_1.time_ < 0 + var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect104902ui_story then
				arg_109_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			local var_112_3 = 0
			local var_112_4 = 0.425

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_3 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_5 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(414301028).content)

				arg_109_1.text_.text = var_112_5

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_7 = 17 <= 0 and var_112_4 or var_112_4 * (utf8.len(var_112_5) / 17)

				if (17 <= 0 and var_112_4 or var_112_4 * (utf8.len(var_112_5) / 17)) > 0 and var_112_4 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_3 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_3
					end
				end

				arg_109_1.text_.text = var_112_5
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_8 = math.max(var_112_4, arg_109_1.talkMaxDuration)

			if var_112_3 <= arg_109_1.time_ and arg_109_1.time_ < var_112_3 + var_112_8 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_3) / var_112_8

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_3 + var_112_8 and arg_109_1.time_ < var_112_3 + var_112_8 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play414301029 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 414301029
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play414301030(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["104902ui_story"]) and arg_113_1.var_.characterEffect104902ui_story == nil then
				arg_113_1.var_.characterEffect104902ui_story = arg_113_1.actors_["104902ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["104902ui_story"]) then
				if arg_113_1.var_.characterEffect104902ui_story and not isNil(arg_113_1.actors_["104902ui_story"]) then
					arg_113_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_113_1.var_.characterEffect104902ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_0)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["104902ui_story"]) and arg_113_1.var_.characterEffect104902ui_story then
				arg_113_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_113_1.var_.characterEffect104902ui_story.fillRatio = 0.5
			end

			local var_116_1 = 0
			local var_116_2 = 0.45

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
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

				local var_116_3 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(414301029).content)

				arg_113_1.text_.text = var_116_3

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 18 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 18)

				if (18 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 18)) > 0 and var_116_2 < var_116_5 then
					arg_113_1.talkMaxDuration = var_116_5

					if var_116_5 + var_116_1 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + var_116_1
					end
				end

				arg_113_1.text_.text = var_116_3
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_6 = math.max(var_116_2, arg_113_1.talkMaxDuration)

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_6 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_1) / var_116_6

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_1 + var_116_6 and arg_113_1.time_ < var_116_1 + var_116_6 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play414301030 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 414301030
		arg_117_1.duration_ = 9

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play414301031(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 2 < arg_117_1.time_ and arg_117_1.time_ <= 2 + arg_120_0 then
				local var_120_0 = arg_117_1.bgs_.H07f

				arg_117_1.bgs_.H07f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_120_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_120_1 = var_120_0:GetComponent("SpriteRenderer")

				if var_120_1 and var_120_1.sprite then
					local var_120_2 = 2 * (var_120_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_120_0.transform.localScale = Vector3.New(var_120_2 / var_120_1.sprite.bounds.size.y < var_120_2 * manager.ui.mainCameraCom_.aspect / var_120_1.sprite.bounds.size.x and var_120_2 * manager.ui.mainCameraCom_.aspect / var_120_1.sprite.bounds.size.x or var_120_2 / var_120_1.sprite.bounds.size.y, var_120_2 / var_120_1.sprite.bounds.size.y < var_120_2 * manager.ui.mainCameraCom_.aspect / var_120_1.sprite.bounds.size.x and var_120_2 * manager.ui.mainCameraCom_.aspect / var_120_1.sprite.bounds.size.x or var_120_2 / var_120_1.sprite.bounds.size.y, 0)
				end

				for iter_120_0, iter_120_1 in pairs(arg_117_1.bgs_) do
					if iter_120_0 ~= "H07f" then
						iter_120_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_120_3 = 0

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_3 + arg_120_0 then
				arg_117_1.allBtn_.enabled = false
			end

			if arg_117_1.time_ >= var_120_3 + 0.3 and arg_117_1.time_ < var_120_3 + 0.3 + arg_120_0 then
				arg_117_1.allBtn_.enabled = true
			end

			local var_120_4 = 0

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_5 = 2

			if var_120_4 <= arg_117_1.time_ and arg_117_1.time_ < var_120_4 + var_120_5 then
				local var_120_6 = Color.New(0, 0, 0)

				var_120_6.a = Mathf.Lerp(0, 1, (arg_117_1.time_ - var_120_4) / var_120_5)
				arg_117_1.mask_.color = var_120_6
			end

			if arg_117_1.time_ >= var_120_4 + var_120_5 and arg_117_1.time_ < var_120_4 + var_120_5 + arg_120_0 then
				local var_120_7 = Color.New(0, 0, 0)

				var_120_7.a = 1
				arg_117_1.mask_.color = var_120_7
			end

			local var_120_8 = 2

			if 2 < arg_117_1.time_ and arg_117_1.time_ <= var_120_8 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_9 = 2

			if var_120_8 <= arg_117_1.time_ and arg_117_1.time_ < var_120_8 + var_120_9 then
				local var_120_10 = Color.New(0, 0, 0)

				var_120_10.a = Mathf.Lerp(1, 0, (arg_117_1.time_ - var_120_8) / var_120_9)
				arg_117_1.mask_.color = var_120_10
			end

			if arg_117_1.time_ >= var_120_8 + var_120_9 and arg_117_1.time_ < var_120_8 + var_120_9 + arg_120_0 then
				local var_120_11 = Color.New(0, 0, 0)

				arg_117_1.mask_.enabled = false
				var_120_11.a = 0
				arg_117_1.mask_.color = var_120_11
			end

			local var_120_12 = arg_117_1.actors_["104902ui_story"].transform

			if 2 < arg_117_1.time_ and arg_117_1.time_ <= 2 + arg_120_0 then
				arg_117_1.var_.moveOldPos104902ui_story = var_120_12.localPosition
			end

			local var_120_13 = 0.001

			if 2 <= arg_117_1.time_ and arg_117_1.time_ < 2 + var_120_13 then
				var_120_12.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos104902ui_story, Vector3.New(0, 100, 0), (arg_117_1.time_ - 2) / var_120_13)
				var_120_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_12.position).x, (manager.ui.mainCamera.transform.position - var_120_12.position).y, (manager.ui.mainCamera.transform.position - var_120_12.position).z)
				var_120_12.localEulerAngles.z = 0
				var_120_12.localEulerAngles.x = 0
				var_120_12.localEulerAngles = var_120_12.localEulerAngles
			end

			if arg_117_1.time_ >= 2 + var_120_13 and arg_117_1.time_ < 2 + var_120_13 + arg_120_0 then
				var_120_12.localPosition = Vector3.New(0, 100, 0)
				var_120_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_12.position).x, (manager.ui.mainCamera.transform.position - var_120_12.position).y, (manager.ui.mainCamera.transform.position - var_120_12.position).z)
				var_120_12.localEulerAngles.z = 0
				var_120_12.localEulerAngles.x = 0
				var_120_12.localEulerAngles = var_120_12.localEulerAngles
			end

			if arg_117_1.frameCnt_ <= 1 then
				arg_117_1.dialog_:SetActive(false)
			end

			local var_120_14 = 4
			local var_120_15 = 1.15

			if 4 < arg_117_1.time_ and arg_117_1.time_ <= var_120_14 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0

				arg_117_1.dialog_:SetActive(true)

				arg_117_1.dialogCg_.alpha = 0

				local var_120_16 = LeanTween.value(arg_117_1.dialog_, 0, 1, 0.3)

				var_120_16:setOnUpdate(LuaHelper.FloatAction(function(arg_121_0)
					arg_117_1.dialogCg_.alpha = arg_121_0
				end))
				var_120_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_117_1.dialog_)
					var_120_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_117_1.duration_ = arg_117_1.duration_ + 0.3

				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_17 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(414301030).content)

				arg_117_1.text_.text = var_120_17

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_19 = 46 <= 0 and var_120_15 or var_120_15 * (utf8.len(var_120_17) / 46)

				if (46 <= 0 and var_120_15 or var_120_15 * (utf8.len(var_120_17) / 46)) > 0 and var_120_15 < var_120_19 then
					arg_117_1.talkMaxDuration = var_120_19
					var_120_14 = var_120_14 + 0.3

					if var_120_19 + var_120_14 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_19 + var_120_14
					end
				end

				arg_117_1.text_.text = var_120_17
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_20 = var_120_14 + 0.3
			local var_120_21 = math.max(var_120_15, arg_117_1.talkMaxDuration)

			if var_120_14 + 0.3 <= arg_117_1.time_ and arg_117_1.time_ < var_120_20 + var_120_21 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_20) / var_120_21

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_20 + var_120_21 and arg_117_1.time_ < var_120_20 + var_120_21 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play414301031 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 414301031
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play414301032(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0.6

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
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

				local var_126_1 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(414301031).content)

				arg_123_1.text_.text = var_126_1

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_3 = 24 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 24)

				if (24 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 24)) > 0 and var_126_0 < var_126_3 then
					arg_123_1.talkMaxDuration = var_126_3

					if var_126_3 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_3 + 0
					end
				end

				arg_123_1.text_.text = var_126_1
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_4 = math.max(var_126_0, arg_123_1.talkMaxDuration)

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - 0) / var_126_4

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play414301032 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 414301032
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play414301033(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.275

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_1 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(414301032).content)

				arg_127_1.text_.text = var_130_1

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_3 = 11 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 11)

				if (11 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 11)) > 0 and var_130_0 < var_130_3 then
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
	Play414301033 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 414301033
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play414301034(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.35

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_1 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(414301033).content)

				arg_131_1.text_.text = var_134_1

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_3 = 14 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 14)

				if (14 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 14)) > 0 and var_134_0 < var_134_3 then
					arg_131_1.talkMaxDuration = var_134_3

					if var_134_3 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_3 + 0
					end
				end

				arg_131_1.text_.text = var_134_1
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_4 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_4

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play414301034 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 414301034
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play414301035(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 1.125

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_1 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(414301034).content)

				arg_135_1.text_.text = var_138_1

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_3 = 45 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_1) / 45)

				if (45 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_1) / 45)) > 0 and var_138_0 < var_138_3 then
					arg_135_1.talkMaxDuration = var_138_3

					if var_138_3 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_3 + 0
					end
				end

				arg_135_1.text_.text = var_138_1
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_4 = math.max(var_138_0, arg_135_1.talkMaxDuration)

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_4 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - 0) / var_138_4

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= 0 + var_138_4 and arg_135_1.time_ < 0 + var_138_4 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play414301035 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 414301035
		arg_139_1.duration_ = 6.43

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play414301036(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.mask_.enabled = true
				arg_139_1.mask_.raycastTarget = true

				arg_139_1:SetGaussion(false)
			end

			local var_142_0 = 0.5

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 then
				local var_142_1 = Color.New(1, 1, 1)

				var_142_1.a = Mathf.Lerp(0, 1, (arg_139_1.time_ - 0) / var_142_0)
				arg_139_1.mask_.color = var_142_1
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 then
				local var_142_2 = Color.New(1, 1, 1)

				var_142_2.a = 1
				arg_139_1.mask_.color = var_142_2
			end

			local var_142_3 = 0.5

			if 0.5 < arg_139_1.time_ and arg_139_1.time_ <= var_142_3 + arg_142_0 then
				arg_139_1.mask_.enabled = true
				arg_139_1.mask_.raycastTarget = true

				arg_139_1:SetGaussion(false)
			end

			local var_142_4 = 0.8

			if var_142_3 <= arg_139_1.time_ and arg_139_1.time_ < var_142_3 + var_142_4 then
				local var_142_5 = Color.New(1, 1, 1)

				var_142_5.a = Mathf.Lerp(1, 0, (arg_139_1.time_ - var_142_3) / var_142_4)
				arg_139_1.mask_.color = var_142_5
			end

			if arg_139_1.time_ >= var_142_3 + var_142_4 and arg_139_1.time_ < var_142_3 + var_142_4 + arg_142_0 then
				local var_142_6 = Color.New(1, 1, 1)

				arg_139_1.mask_.enabled = false
				var_142_6.a = 0
				arg_139_1.mask_.color = var_142_6
			end

			if 0.5 < arg_139_1.time_ and arg_139_1.time_ <= 0.5 + arg_142_0 then
				arg_139_1:AudioAction("play", "effect", "se_story_side_1039", "se_story_1039_water", "")
			end

			if arg_139_1.frameCnt_ <= 1 then
				arg_139_1.dialog_:SetActive(false)
			end

			local var_142_8 = 1.43333333333333
			local var_142_9 = 1.3

			if 1.43333333333333 < arg_139_1.time_ and arg_139_1.time_ <= var_142_8 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0

				arg_139_1.dialog_:SetActive(true)

				arg_139_1.dialogCg_.alpha = 0

				local var_142_10 = LeanTween.value(arg_139_1.dialog_, 0, 1, 0.3)

				var_142_10:setOnUpdate(LuaHelper.FloatAction(function(arg_143_0)
					arg_139_1.dialogCg_.alpha = arg_143_0
				end))
				var_142_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_139_1.dialog_)
					var_142_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_139_1.duration_ = arg_139_1.duration_ + 0.3

				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_11 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(414301035).content)

				arg_139_1.text_.text = var_142_11

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_13 = 52 <= 0 and var_142_9 or var_142_9 * (utf8.len(var_142_11) / 52)

				if (52 <= 0 and var_142_9 or var_142_9 * (utf8.len(var_142_11) / 52)) > 0 and var_142_9 < var_142_13 then
					arg_139_1.talkMaxDuration = var_142_13
					var_142_8 = var_142_8 + 0.3

					if var_142_13 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_13 + var_142_8
					end
				end

				arg_139_1.text_.text = var_142_11
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_14 = var_142_8 + 0.3
			local var_142_15 = math.max(var_142_9, arg_139_1.talkMaxDuration)

			if var_142_8 + 0.3 <= arg_139_1.time_ and arg_139_1.time_ < var_142_14 + var_142_15 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_14) / var_142_15

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_14 + var_142_15 and arg_139_1.time_ < var_142_14 + var_142_15 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play414301036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 414301036
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play414301037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.25

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

				local var_148_1 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(414301036).content)

				arg_145_1.text_.text = var_148_1

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_3 = 10 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 10)

				if (10 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 10)) > 0 and var_148_0 < var_148_3 then
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
	Play414301037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 414301037
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play414301038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if arg_149_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_152_0 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_149_1.stage_.transform)

				var_152_0.name = "1148ui_story"
				var_152_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_149_1.actors_["1148ui_story"] = var_152_0

				local var_152_1 = var_152_0:GetComponentInChildren(typeof(CharacterEffect))

				var_152_1.enabled = true

				local var_152_2 = GameObjectTools.GetOrAddComponent(var_152_0, typeof(DynamicBoneHelper))

				if var_152_2 then
					var_152_2:EnableDynamicBone(false)
				end

				arg_149_1:ShowWeapon(var_152_1.transform, false)

				arg_149_1.var_["1148ui_story" .. "Animator"] = var_152_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_149_1.var_["1148ui_story" .. "Animator"].applyRootMotion = true
				arg_149_1.var_["1148ui_story" .. "LipSync"] = var_152_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_152_3 = arg_149_1.actors_["1148ui_story"].transform

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1148ui_story = var_152_3.localPosition

				arg_149_1:ShowWeapon(arg_149_1.var_["1148ui_story" .. "Animator"].transform, false)
			end

			local var_152_4 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_4 then
				var_152_3.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_149_1.time_ - 0) / var_152_4)
				var_152_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_3.position).x, (manager.ui.mainCamera.transform.position - var_152_3.position).y, (manager.ui.mainCamera.transform.position - var_152_3.position).z)
				var_152_3.localEulerAngles.z = 0
				var_152_3.localEulerAngles.x = 0
				var_152_3.localEulerAngles = var_152_3.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_4 and arg_149_1.time_ < 0 + var_152_4 + arg_152_0 then
				var_152_3.localPosition = Vector3.New(0, -0.8, -6.2)
				var_152_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_3.position).x, (manager.ui.mainCamera.transform.position - var_152_3.position).y, (manager.ui.mainCamera.transform.position - var_152_3.position).z)
				var_152_3.localEulerAngles.z = 0
				var_152_3.localEulerAngles.x = 0
				var_152_3.localEulerAngles = var_152_3.localEulerAngles
			end

			local var_152_5 = arg_149_1.actors_["1148ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_5) and arg_149_1.var_.characterEffect1148ui_story == nil then
				arg_149_1.var_.characterEffect1148ui_story = var_152_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_6 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_6 and not isNil(var_152_5) then
				if arg_149_1.var_.characterEffect1148ui_story and not isNil(var_152_5) then
					arg_149_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_6 and arg_149_1.time_ < 0 + var_152_6 + arg_152_0 and not isNil(var_152_5) and arg_149_1.var_.characterEffect1148ui_story then
				arg_149_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_152_8 = 0
			local var_152_9 = 0.45

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_8 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_10 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(414301037).content)

				arg_149_1.text_.text = var_152_10

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_12 = 18 <= 0 and var_152_9 or var_152_9 * (utf8.len(var_152_10) / 18)

				if (18 <= 0 and var_152_9 or var_152_9 * (utf8.len(var_152_10) / 18)) > 0 and var_152_9 < var_152_12 then
					arg_149_1.talkMaxDuration = var_152_12

					if var_152_12 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_12 + var_152_8
					end
				end

				arg_149_1.text_.text = var_152_10
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_13 = math.max(var_152_9, arg_149_1.talkMaxDuration)

			if var_152_8 <= arg_149_1.time_ and arg_149_1.time_ < var_152_8 + var_152_13 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_8) / var_152_13

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_8 + var_152_13 and arg_149_1.time_ < var_152_8 + var_152_13 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
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
	Play414301038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 414301038
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play414301039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["1148ui_story"]) and arg_153_1.var_.characterEffect1148ui_story == nil then
				arg_153_1.var_.characterEffect1148ui_story = arg_153_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_0 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["1148ui_story"]) then
				if arg_153_1.var_.characterEffect1148ui_story and not isNil(arg_153_1.actors_["1148ui_story"]) then
					arg_153_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_0)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["1148ui_story"]) and arg_153_1.var_.characterEffect1148ui_story then
				arg_153_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_156_1 = 0
			local var_156_2 = 0.575

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

				local var_156_3 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(414301038).content)

				arg_153_1.text_.text = var_156_3

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 23 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_3) / 23)

				if (23 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_3) / 23)) > 0 and var_156_2 < var_156_5 then
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
	Play414301039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 414301039
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play414301040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1148ui_story = arg_157_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_160_0 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 then
				arg_157_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_157_1.time_ - 0) / var_160_0)
				arg_157_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1148ui_story"].transform.position).z)
				arg_157_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1148ui_story"].transform.localEulerAngles = arg_157_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 then
				arg_157_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_157_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1148ui_story"].transform.position).z)
				arg_157_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1148ui_story"].transform.localEulerAngles = arg_157_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_160_1 = arg_157_1.actors_["1148ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1148ui_story == nil then
				arg_157_1.var_.characterEffect1148ui_story = var_160_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_2 and not isNil(var_160_1) then
				if arg_157_1.var_.characterEffect1148ui_story and not isNil(var_160_1) then
					arg_157_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_2 and arg_157_1.time_ < 0 + var_160_2 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1148ui_story then
				arg_157_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action435")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_160_4 = 0
			local var_160_5 = 0.75

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_4 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_6 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(414301039).content)

				arg_157_1.text_.text = var_160_6

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_8 = 30 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_6) / 30)

				if (30 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_6) / 30)) > 0 and var_160_5 < var_160_8 then
					arg_157_1.talkMaxDuration = var_160_8

					if var_160_8 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_8 + var_160_4
					end
				end

				arg_157_1.text_.text = var_160_6
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_9 = math.max(var_160_5, arg_157_1.talkMaxDuration)

			if var_160_4 <= arg_157_1.time_ and arg_157_1.time_ < var_160_4 + var_160_9 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_4) / var_160_9

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_4 + var_160_9 and arg_157_1.time_ < var_160_4 + var_160_9 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
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
	Play414301040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 414301040
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play414301041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(arg_161_1.actors_["1148ui_story"]) and arg_161_1.var_.characterEffect1148ui_story == nil then
				arg_161_1.var_.characterEffect1148ui_story = arg_161_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_0 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 and not isNil(arg_161_1.actors_["1148ui_story"]) then
				if arg_161_1.var_.characterEffect1148ui_story and not isNil(arg_161_1.actors_["1148ui_story"]) then
					arg_161_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_0)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 and not isNil(arg_161_1.actors_["1148ui_story"]) and arg_161_1.var_.characterEffect1148ui_story then
				arg_161_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_164_1 = 0
			local var_164_2 = 0.575

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
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

				local var_164_3 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(414301040).content)

				arg_161_1.text_.text = var_164_3

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 23 <= 0 and var_164_2 or var_164_2 * (utf8.len(var_164_3) / 23)

				if (23 <= 0 and var_164_2 or var_164_2 * (utf8.len(var_164_3) / 23)) > 0 and var_164_2 < var_164_5 then
					arg_161_1.talkMaxDuration = var_164_5

					if var_164_5 + var_164_1 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + var_164_1
					end
				end

				arg_161_1.text_.text = var_164_3
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_6 = math.max(var_164_2, arg_161_1.talkMaxDuration)

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_6 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_1) / var_164_6

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_1 + var_164_6 and arg_161_1.time_ < var_164_1 + var_164_6 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play414301041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 414301041
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play414301042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1148ui_story = arg_165_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1148ui_story"].transform.position).z)
				arg_165_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1148ui_story"].transform.localEulerAngles = arg_165_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_165_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1148ui_story"].transform.position).z)
				arg_165_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1148ui_story"].transform.localEulerAngles = arg_165_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_168_1 = arg_165_1.actors_["1148ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1148ui_story == nil then
				arg_165_1.var_.characterEffect1148ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 and not isNil(var_168_1) then
				if arg_165_1.var_.characterEffect1148ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_2)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1148ui_story then
				arg_165_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_168_3 = arg_165_1.actors_["104902ui_story"].transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos104902ui_story = var_168_3.localPosition
			end

			local var_168_4 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_4 then
				var_168_3.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos104902ui_story, Vector3.New(0, -1.2, -6), (arg_165_1.time_ - 0) / var_168_4)
				var_168_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_3.position).x, (manager.ui.mainCamera.transform.position - var_168_3.position).y, (manager.ui.mainCamera.transform.position - var_168_3.position).z)
				var_168_3.localEulerAngles.z = 0
				var_168_3.localEulerAngles.x = 0
				var_168_3.localEulerAngles = var_168_3.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_4 and arg_165_1.time_ < 0 + var_168_4 + arg_168_0 then
				var_168_3.localPosition = Vector3.New(0, -1.2, -6)
				var_168_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_3.position).x, (manager.ui.mainCamera.transform.position - var_168_3.position).y, (manager.ui.mainCamera.transform.position - var_168_3.position).z)
				var_168_3.localEulerAngles.z = 0
				var_168_3.localEulerAngles.x = 0
				var_168_3.localEulerAngles = var_168_3.localEulerAngles
			end

			local var_168_5 = arg_165_1.actors_["104902ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_5) and arg_165_1.var_.characterEffect104902ui_story == nil then
				arg_165_1.var_.characterEffect104902ui_story = var_168_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_6 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_6 and not isNil(var_168_5) then
				if arg_165_1.var_.characterEffect104902ui_story and not isNil(var_168_5) then
					arg_165_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_6 and arg_165_1.time_ < 0 + var_168_6 + arg_168_0 and not isNil(var_168_5) and arg_165_1.var_.characterEffect104902ui_story then
				arg_165_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/story104902/story104902action/104902action2_1")
			end

			local var_168_8 = 0
			local var_168_9 = 0.15

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_8 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_10 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(414301041).content)

				arg_165_1.text_.text = var_168_10

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_12 = 6 <= 0 and var_168_9 or var_168_9 * (utf8.len(var_168_10) / 6)

				if (6 <= 0 and var_168_9 or var_168_9 * (utf8.len(var_168_10) / 6)) > 0 and var_168_9 < var_168_12 then
					arg_165_1.talkMaxDuration = var_168_12

					if var_168_12 + var_168_8 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_12 + var_168_8
					end
				end

				arg_165_1.text_.text = var_168_10
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_13 = math.max(var_168_9, arg_165_1.talkMaxDuration)

			if var_168_8 <= arg_165_1.time_ and arg_165_1.time_ < var_168_8 + var_168_13 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_8) / var_168_13

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_8 + var_168_13 and arg_165_1.time_ < var_168_8 + var_168_13 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "104902ui_story",
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
	Play414301042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 414301042
		arg_169_1.duration_ = 6.63

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play414301043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos104902ui_story = arg_169_1.actors_["104902ui_story"].transform.localPosition
			end

			local var_172_0 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				arg_169_1.actors_["104902ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos104902ui_story, Vector3.New(0, 100, 0), (arg_169_1.time_ - 0) / var_172_0)
				arg_169_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["104902ui_story"].transform.position).z)
				arg_169_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["104902ui_story"].transform.localEulerAngles = arg_169_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				arg_169_1.actors_["104902ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_169_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["104902ui_story"].transform.position).z)
				arg_169_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["104902ui_story"].transform.localEulerAngles = arg_169_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			local var_172_1 = arg_169_1.actors_["104902ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect104902ui_story == nil then
				arg_169_1.var_.characterEffect104902ui_story = var_172_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_2 and not isNil(var_172_1) then
				if arg_169_1.var_.characterEffect104902ui_story and not isNil(var_172_1) then
					arg_169_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_169_1.var_.characterEffect104902ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_2)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_2 and arg_169_1.time_ < 0 + var_172_2 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect104902ui_story then
				arg_169_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_169_1.var_.characterEffect104902ui_story.fillRatio = 0.5
			end

			local var_172_3 = 0

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_3 + arg_172_0 then
				arg_169_1.mask_.enabled = true
				arg_169_1.mask_.raycastTarget = true

				arg_169_1:SetGaussion(false)
			end

			local var_172_4 = 1.36666666666667

			if var_172_3 <= arg_169_1.time_ and arg_169_1.time_ < var_172_3 + var_172_4 then
				local var_172_5 = Color.New(1, 1, 1)

				var_172_5.a = Mathf.Lerp(1, 0, (arg_169_1.time_ - var_172_3) / var_172_4)
				arg_169_1.mask_.color = var_172_5
			end

			if arg_169_1.time_ >= var_172_3 + var_172_4 and arg_169_1.time_ < var_172_3 + var_172_4 + arg_172_0 then
				local var_172_6 = Color.New(1, 1, 1)

				arg_169_1.mask_.enabled = false
				var_172_6.a = 0
				arg_169_1.mask_.color = var_172_6
			end

			if 1.36666666666667 < arg_169_1.time_ and arg_169_1.time_ <= 1.36666666666667 + arg_172_0 then
				arg_169_1:AudioAction("play", "effect", "minigame_activity_2_2", "minigame_activity_2_2_watergun_enter", "")
			end

			if arg_169_1.frameCnt_ <= 1 then
				arg_169_1.dialog_:SetActive(false)
			end

			local var_172_8 = 1.633333333332
			local var_172_9 = 0.9

			if 1.633333333332 < arg_169_1.time_ and arg_169_1.time_ <= var_172_8 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0

				arg_169_1.dialog_:SetActive(true)

				arg_169_1.dialogCg_.alpha = 0

				local var_172_10 = LeanTween.value(arg_169_1.dialog_, 0, 1, 0.3)

				var_172_10:setOnUpdate(LuaHelper.FloatAction(function(arg_173_0)
					arg_169_1.dialogCg_.alpha = arg_173_0
				end))
				var_172_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_169_1.dialog_)
					var_172_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_169_1.duration_ = arg_169_1.duration_ + 0.3

				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_11 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(414301042).content)

				arg_169_1.text_.text = var_172_11

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_13 = 36 <= 0 and var_172_9 or var_172_9 * (utf8.len(var_172_11) / 36)

				if (36 <= 0 and var_172_9 or var_172_9 * (utf8.len(var_172_11) / 36)) > 0 and var_172_9 < var_172_13 then
					arg_169_1.talkMaxDuration = var_172_13
					var_172_8 = var_172_8 + 0.3

					if var_172_13 + var_172_8 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_13 + var_172_8
					end
				end

				arg_169_1.text_.text = var_172_11
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_14 = var_172_8 + 0.3
			local var_172_15 = math.max(var_172_9, arg_169_1.talkMaxDuration)

			if var_172_8 + 0.3 <= arg_169_1.time_ and arg_169_1.time_ < var_172_14 + var_172_15 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_14) / var_172_15

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_14 + var_172_15 and arg_169_1.time_ < var_172_14 + var_172_15 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play414301043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 414301043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play414301044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 1.075

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_1 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(414301043).content)

				arg_175_1.text_.text = var_178_1

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_3 = 43 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 43)

				if (43 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 43)) > 0 and var_178_0 < var_178_3 then
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
	Play414301044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 414301044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play414301045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0.4

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
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

				local var_182_1 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(414301044).content)

				arg_179_1.text_.text = var_182_1

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_3 = 16 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 16)

				if (16 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 16)) > 0 and var_182_0 < var_182_3 then
					arg_179_1.talkMaxDuration = var_182_3

					if var_182_3 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_3 + 0
					end
				end

				arg_179_1.text_.text = var_182_1
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_4 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_4

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play414301045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 414301045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play414301046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if arg_183_1.actors_["107001ui_story"] == nil and not isNil((Asset.Load("Char/" .. "107001ui_story"))) then
				local var_186_0 = Object.Instantiate(Asset.Load("Char/" .. "107001ui_story"), arg_183_1.stage_.transform)

				var_186_0.name = "107001ui_story"
				var_186_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_183_1.actors_["107001ui_story"] = var_186_0

				local var_186_1 = var_186_0:GetComponentInChildren(typeof(CharacterEffect))

				var_186_1.enabled = true

				local var_186_2 = GameObjectTools.GetOrAddComponent(var_186_0, typeof(DynamicBoneHelper))

				if var_186_2 then
					var_186_2:EnableDynamicBone(false)
				end

				arg_183_1:ShowWeapon(var_186_1.transform, false)

				arg_183_1.var_["107001ui_story" .. "Animator"] = var_186_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_183_1.var_["107001ui_story" .. "Animator"].applyRootMotion = true
				arg_183_1.var_["107001ui_story" .. "LipSync"] = var_186_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_186_3 = arg_183_1.actors_["107001ui_story"].transform

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos107001ui_story = var_186_3.localPosition

				arg_183_1:ShowWeapon(arg_183_1.var_["107001ui_story" .. "Animator"].transform, false)
			end

			local var_186_4 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_4 then
				var_186_3.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos107001ui_story, Vector3.New(0, -0.95, -6.05), (arg_183_1.time_ - 0) / var_186_4)
				var_186_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_186_3.position).x, (manager.ui.mainCamera.transform.position - var_186_3.position).y, (manager.ui.mainCamera.transform.position - var_186_3.position).z)
				var_186_3.localEulerAngles.z = 0
				var_186_3.localEulerAngles.x = 0
				var_186_3.localEulerAngles = var_186_3.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_4 and arg_183_1.time_ < 0 + var_186_4 + arg_186_0 then
				var_186_3.localPosition = Vector3.New(0, -0.95, -6.05)
				var_186_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_186_3.position).x, (manager.ui.mainCamera.transform.position - var_186_3.position).y, (manager.ui.mainCamera.transform.position - var_186_3.position).z)
				var_186_3.localEulerAngles.z = 0
				var_186_3.localEulerAngles.x = 0
				var_186_3.localEulerAngles = var_186_3.localEulerAngles
			end

			local var_186_5 = arg_183_1.actors_["107001ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_5) and arg_183_1.var_.characterEffect107001ui_story == nil then
				arg_183_1.var_.characterEffect107001ui_story = var_186_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_6 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_6 and not isNil(var_186_5) then
				if arg_183_1.var_.characterEffect107001ui_story and not isNil(var_186_5) then
					arg_183_1.var_.characterEffect107001ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_6 and arg_183_1.time_ < 0 + var_186_6 + arg_186_0 and not isNil(var_186_5) and arg_183_1.var_.characterEffect107001ui_story then
				arg_183_1.var_.characterEffect107001ui_story.fillFlat = false
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("107001ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("107001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_186_8 = arg_183_1.actors_["104902ui_story"].transform

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos104902ui_story = var_186_8.localPosition
			end

			local var_186_9 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_9 then
				var_186_8.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos104902ui_story, Vector3.New(0, 100, 0), (arg_183_1.time_ - 0) / var_186_9)
				var_186_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_186_8.position).x, (manager.ui.mainCamera.transform.position - var_186_8.position).y, (manager.ui.mainCamera.transform.position - var_186_8.position).z)
				var_186_8.localEulerAngles.z = 0
				var_186_8.localEulerAngles.x = 0
				var_186_8.localEulerAngles = var_186_8.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_9 and arg_183_1.time_ < 0 + var_186_9 + arg_186_0 then
				var_186_8.localPosition = Vector3.New(0, 100, 0)
				var_186_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_186_8.position).x, (manager.ui.mainCamera.transform.position - var_186_8.position).y, (manager.ui.mainCamera.transform.position - var_186_8.position).z)
				var_186_8.localEulerAngles.z = 0
				var_186_8.localEulerAngles.x = 0
				var_186_8.localEulerAngles = var_186_8.localEulerAngles
			end

			local var_186_10 = 0
			local var_186_11 = 0.6

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_10 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_12 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(414301045).content)

				arg_183_1.text_.text = var_186_12

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_14 = 24 <= 0 and var_186_11 or var_186_11 * (utf8.len(var_186_12) / 24)

				if (24 <= 0 and var_186_11 or var_186_11 * (utf8.len(var_186_12) / 24)) > 0 and var_186_11 < var_186_14 then
					arg_183_1.talkMaxDuration = var_186_14

					if var_186_14 + var_186_10 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_14 + var_186_10
					end
				end

				arg_183_1.text_.text = var_186_12
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_15 = math.max(var_186_11, arg_183_1.talkMaxDuration)

			if var_186_10 <= arg_183_1.time_ and arg_183_1.time_ < var_186_10 + var_186_15 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_10) / var_186_15

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_10 + var_186_15 and arg_183_1.time_ < var_186_10 + var_186_15 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "107001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "104902ui_story",
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
	Play414301046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 414301046
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play414301047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos107001ui_story = arg_187_1.actors_["107001ui_story"].transform.localPosition
			end

			local var_190_0 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 then
				arg_187_1.actors_["107001ui_story"].transform.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos107001ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_187_1.time_ - 0) / var_190_0)
				arg_187_1.actors_["107001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["107001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["107001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["107001ui_story"].transform.position).z)
				arg_187_1.actors_["107001ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["107001ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["107001ui_story"].transform.localEulerAngles = arg_187_1.actors_["107001ui_story"].transform.localEulerAngles
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 then
				arg_187_1.actors_["107001ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_187_1.actors_["107001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["107001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["107001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["107001ui_story"].transform.position).z)
				arg_187_1.actors_["107001ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["107001ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["107001ui_story"].transform.localEulerAngles = arg_187_1.actors_["107001ui_story"].transform.localEulerAngles
			end

			local var_190_1 = arg_187_1.actors_["107001ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect107001ui_story == nil then
				arg_187_1.var_.characterEffect107001ui_story = var_190_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_2 and not isNil(var_190_1) then
				if arg_187_1.var_.characterEffect107001ui_story and not isNil(var_190_1) then
					arg_187_1.var_.characterEffect107001ui_story.fillFlat = true
					arg_187_1.var_.characterEffect107001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_2)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_2 and arg_187_1.time_ < 0 + var_190_2 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect107001ui_story then
				arg_187_1.var_.characterEffect107001ui_story.fillFlat = true
				arg_187_1.var_.characterEffect107001ui_story.fillRatio = 0.5
			end

			local var_190_3 = arg_187_1.actors_["1148ui_story"].transform

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos1148ui_story = var_190_3.localPosition
			end

			local var_190_4 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_4 then
				var_190_3.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1148ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_187_1.time_ - 0) / var_190_4)
				var_190_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_190_3.position).x, (manager.ui.mainCamera.transform.position - var_190_3.position).y, (manager.ui.mainCamera.transform.position - var_190_3.position).z)
				var_190_3.localEulerAngles.z = 0
				var_190_3.localEulerAngles.x = 0
				var_190_3.localEulerAngles = var_190_3.localEulerAngles
			end

			if arg_187_1.time_ >= 0 + var_190_4 and arg_187_1.time_ < 0 + var_190_4 + arg_190_0 then
				var_190_3.localPosition = Vector3.New(0.7, -0.8, -6.2)
				var_190_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_190_3.position).x, (manager.ui.mainCamera.transform.position - var_190_3.position).y, (manager.ui.mainCamera.transform.position - var_190_3.position).z)
				var_190_3.localEulerAngles.z = 0
				var_190_3.localEulerAngles.x = 0
				var_190_3.localEulerAngles = var_190_3.localEulerAngles
			end

			local var_190_5 = arg_187_1.actors_["1148ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_5) and arg_187_1.var_.characterEffect1148ui_story == nil then
				arg_187_1.var_.characterEffect1148ui_story = var_190_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_6 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_6 and not isNil(var_190_5) then
				if arg_187_1.var_.characterEffect1148ui_story and not isNil(var_190_5) then
					arg_187_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= 0 + var_190_6 and arg_187_1.time_ < 0 + var_190_6 + arg_190_0 and not isNil(var_190_5) and arg_187_1.var_.characterEffect1148ui_story then
				arg_187_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_2")
			end

			local var_190_8 = 0
			local var_190_9 = 1.15

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_8 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_10 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(414301046).content)

				arg_187_1.text_.text = var_190_10

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_12 = 46 <= 0 and var_190_9 or var_190_9 * (utf8.len(var_190_10) / 46)

				if (46 <= 0 and var_190_9 or var_190_9 * (utf8.len(var_190_10) / 46)) > 0 and var_190_9 < var_190_12 then
					arg_187_1.talkMaxDuration = var_190_12

					if var_190_12 + var_190_8 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_12 + var_190_8
					end
				end

				arg_187_1.text_.text = var_190_10
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_13 = math.max(var_190_9, arg_187_1.talkMaxDuration)

			if var_190_8 <= arg_187_1.time_ and arg_187_1.time_ < var_190_8 + var_190_13 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_8) / var_190_13

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_8 + var_190_13 and arg_187_1.time_ < var_190_8 + var_190_13 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "107001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
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
	Play414301047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 414301047
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play414301048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos107001ui_story = arg_191_1.actors_["107001ui_story"].transform.localPosition

				arg_191_1:ShowWeapon(arg_191_1.var_["107001ui_story" .. "Animator"].transform, false)
			end

			local var_194_0 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 then
				arg_191_1.actors_["107001ui_story"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos107001ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_191_1.time_ - 0) / var_194_0)
				arg_191_1.actors_["107001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["107001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["107001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["107001ui_story"].transform.position).z)
				arg_191_1.actors_["107001ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["107001ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["107001ui_story"].transform.localEulerAngles = arg_191_1.actors_["107001ui_story"].transform.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 then
				arg_191_1.actors_["107001ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_191_1.actors_["107001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["107001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["107001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["107001ui_story"].transform.position).z)
				arg_191_1.actors_["107001ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["107001ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["107001ui_story"].transform.localEulerAngles = arg_191_1.actors_["107001ui_story"].transform.localEulerAngles
			end

			local var_194_1 = arg_191_1.actors_["107001ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect107001ui_story == nil then
				arg_191_1.var_.characterEffect107001ui_story = var_194_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_2 and not isNil(var_194_1) then
				if arg_191_1.var_.characterEffect107001ui_story and not isNil(var_194_1) then
					arg_191_1.var_.characterEffect107001ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_2 and arg_191_1.time_ < 0 + var_194_2 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect107001ui_story then
				arg_191_1.var_.characterEffect107001ui_story.fillFlat = false
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("107001ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("107001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_194_4 = arg_191_1.actors_["1148ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_4) and arg_191_1.var_.characterEffect1148ui_story == nil then
				arg_191_1.var_.characterEffect1148ui_story = var_194_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_5 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_5 and not isNil(var_194_4) then
				if arg_191_1.var_.characterEffect1148ui_story and not isNil(var_194_4) then
					arg_191_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_191_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_191_1.time_ - 0) / var_194_5)
				end
			end

			if arg_191_1.time_ >= 0 + var_194_5 and arg_191_1.time_ < 0 + var_194_5 + arg_194_0 and not isNil(var_194_4) and arg_191_1.var_.characterEffect1148ui_story then
				arg_191_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_191_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_194_6 = 0
			local var_194_7 = 0.525

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_6 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_8 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(414301047).content)

				arg_191_1.text_.text = var_194_8

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_10 = 21 <= 0 and var_194_7 or var_194_7 * (utf8.len(var_194_8) / 21)

				if (21 <= 0 and var_194_7 or var_194_7 * (utf8.len(var_194_8) / 21)) > 0 and var_194_7 < var_194_10 then
					arg_191_1.talkMaxDuration = var_194_10

					if var_194_10 + var_194_6 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_10 + var_194_6
					end
				end

				arg_191_1.text_.text = var_194_8
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_11 = math.max(var_194_7, arg_191_1.talkMaxDuration)

			if var_194_6 <= arg_191_1.time_ and arg_191_1.time_ < var_194_6 + var_194_11 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_6) / var_194_11

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_6 + var_194_11 and arg_191_1.time_ < var_194_6 + var_194_11 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "107001ui_story",
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
	Play414301048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 414301048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play414301049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["107001ui_story"]) and arg_195_1.var_.characterEffect107001ui_story == nil then
				arg_195_1.var_.characterEffect107001ui_story = arg_195_1.actors_["107001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_0 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["107001ui_story"]) then
				if arg_195_1.var_.characterEffect107001ui_story and not isNil(arg_195_1.actors_["107001ui_story"]) then
					arg_195_1.var_.characterEffect107001ui_story.fillFlat = true
					arg_195_1.var_.characterEffect107001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_0)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["107001ui_story"]) and arg_195_1.var_.characterEffect107001ui_story then
				arg_195_1.var_.characterEffect107001ui_story.fillFlat = true
				arg_195_1.var_.characterEffect107001ui_story.fillRatio = 0.5
			end

			local var_198_1 = arg_195_1.actors_["107001ui_story"].transform

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos107001ui_story = var_198_1.localPosition

				arg_195_1:ShowWeapon(arg_195_1.var_["107001ui_story" .. "Animator"].transform, false)
			end

			local var_198_2 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_2 then
				var_198_1.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos107001ui_story, Vector3.New(0, 100, 0), (arg_195_1.time_ - 0) / var_198_2)
				var_198_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_198_1.position).x, (manager.ui.mainCamera.transform.position - var_198_1.position).y, (manager.ui.mainCamera.transform.position - var_198_1.position).z)
				var_198_1.localEulerAngles.z = 0
				var_198_1.localEulerAngles.x = 0
				var_198_1.localEulerAngles = var_198_1.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_2 and arg_195_1.time_ < 0 + var_198_2 + arg_198_0 then
				var_198_1.localPosition = Vector3.New(0, 100, 0)
				var_198_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_198_1.position).x, (manager.ui.mainCamera.transform.position - var_198_1.position).y, (manager.ui.mainCamera.transform.position - var_198_1.position).z)
				var_198_1.localEulerAngles.z = 0
				var_198_1.localEulerAngles.x = 0
				var_198_1.localEulerAngles = var_198_1.localEulerAngles
			end

			local var_198_3 = arg_195_1.actors_["1148ui_story"].transform

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos1148ui_story = var_198_3.localPosition
			end

			local var_198_4 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_4 then
				var_198_3.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_195_1.time_ - 0) / var_198_4)
				var_198_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_198_3.position).x, (manager.ui.mainCamera.transform.position - var_198_3.position).y, (manager.ui.mainCamera.transform.position - var_198_3.position).z)
				var_198_3.localEulerAngles.z = 0
				var_198_3.localEulerAngles.x = 0
				var_198_3.localEulerAngles = var_198_3.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_4 and arg_195_1.time_ < 0 + var_198_4 + arg_198_0 then
				var_198_3.localPosition = Vector3.New(0, 100, 0)
				var_198_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_198_3.position).x, (manager.ui.mainCamera.transform.position - var_198_3.position).y, (manager.ui.mainCamera.transform.position - var_198_3.position).z)
				var_198_3.localEulerAngles.z = 0
				var_198_3.localEulerAngles.x = 0
				var_198_3.localEulerAngles = var_198_3.localEulerAngles
			end

			local var_198_5 = 0
			local var_198_6 = 0.85

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_5 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_7 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(414301048).content)

				arg_195_1.text_.text = var_198_7

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_9 = 34 <= 0 and var_198_6 or var_198_6 * (utf8.len(var_198_7) / 34)

				if (34 <= 0 and var_198_6 or var_198_6 * (utf8.len(var_198_7) / 34)) > 0 and var_198_6 < var_198_9 then
					arg_195_1.talkMaxDuration = var_198_9

					if var_198_9 + var_198_5 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_9 + var_198_5
					end
				end

				arg_195_1.text_.text = var_198_7
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_10 = math.max(var_198_6, arg_195_1.talkMaxDuration)

			if var_198_5 <= arg_195_1.time_ and arg_195_1.time_ < var_198_5 + var_198_10 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_5) / var_198_10

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_5 + var_198_10 and arg_195_1.time_ < var_198_5 + var_198_10 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "107001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
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
	Play414301049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 414301049
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play414301050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos1148ui_story = arg_199_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_202_0 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 then
				arg_199_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1148ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_199_1.time_ - 0) / var_202_0)
				arg_199_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1148ui_story"].transform.position).z)
				arg_199_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["1148ui_story"].transform.localEulerAngles = arg_199_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 then
				arg_199_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0.7, -0.8, -6.2)
				arg_199_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1148ui_story"].transform.position).z)
				arg_199_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["1148ui_story"].transform.localEulerAngles = arg_199_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_202_1 = arg_199_1.actors_["1148ui_story"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect1148ui_story == nil then
				arg_199_1.var_.characterEffect1148ui_story = var_202_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_2 and not isNil(var_202_1) then
				if arg_199_1.var_.characterEffect1148ui_story and not isNil(var_202_1) then
					arg_199_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= 0 + var_202_2 and arg_199_1.time_ < 0 + var_202_2 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect1148ui_story then
				arg_199_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_202_4 = 0
			local var_202_5 = 0.45

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_4 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_6 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(414301049).content)

				arg_199_1.text_.text = var_202_6

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_8 = 18 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_6) / 18)

				if (18 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_6) / 18)) > 0 and var_202_5 < var_202_8 then
					arg_199_1.talkMaxDuration = var_202_8

					if var_202_8 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_8 + var_202_4
					end
				end

				arg_199_1.text_.text = var_202_6
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_9 = math.max(var_202_5, arg_199_1.talkMaxDuration)

			if var_202_4 <= arg_199_1.time_ and arg_199_1.time_ < var_202_4 + var_202_9 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_4) / var_202_9

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_4 + var_202_9 and arg_199_1.time_ < var_202_4 + var_202_9 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
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
	Play414301050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 414301050
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play414301051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos107001ui_story = arg_203_1.actors_["107001ui_story"].transform.localPosition
			end

			local var_206_0 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 then
				arg_203_1.actors_["107001ui_story"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos107001ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_203_1.time_ - 0) / var_206_0)
				arg_203_1.actors_["107001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["107001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["107001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["107001ui_story"].transform.position).z)
				arg_203_1.actors_["107001ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["107001ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["107001ui_story"].transform.localEulerAngles = arg_203_1.actors_["107001ui_story"].transform.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 then
				arg_203_1.actors_["107001ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_203_1.actors_["107001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["107001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["107001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["107001ui_story"].transform.position).z)
				arg_203_1.actors_["107001ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["107001ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["107001ui_story"].transform.localEulerAngles = arg_203_1.actors_["107001ui_story"].transform.localEulerAngles
			end

			local var_206_1 = arg_203_1.actors_["107001ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect107001ui_story == nil then
				arg_203_1.var_.characterEffect107001ui_story = var_206_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_2 and not isNil(var_206_1) then
				if arg_203_1.var_.characterEffect107001ui_story and not isNil(var_206_1) then
					arg_203_1.var_.characterEffect107001ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_2 and arg_203_1.time_ < 0 + var_206_2 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect107001ui_story then
				arg_203_1.var_.characterEffect107001ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("107001ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("107001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_206_4 = arg_203_1.actors_["1148ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_4) and arg_203_1.var_.characterEffect1148ui_story == nil then
				arg_203_1.var_.characterEffect1148ui_story = var_206_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_5 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_5 and not isNil(var_206_4) then
				if arg_203_1.var_.characterEffect1148ui_story and not isNil(var_206_4) then
					arg_203_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_203_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_203_1.time_ - 0) / var_206_5)
				end
			end

			if arg_203_1.time_ >= 0 + var_206_5 and arg_203_1.time_ < 0 + var_206_5 + arg_206_0 and not isNil(var_206_4) and arg_203_1.var_.characterEffect1148ui_story then
				arg_203_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_203_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_206_6 = 0
			local var_206_7 = 0.95

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_6 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_8 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(414301050).content)

				arg_203_1.text_.text = var_206_8

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_10 = 38 <= 0 and var_206_7 or var_206_7 * (utf8.len(var_206_8) / 38)

				if (38 <= 0 and var_206_7 or var_206_7 * (utf8.len(var_206_8) / 38)) > 0 and var_206_7 < var_206_10 then
					arg_203_1.talkMaxDuration = var_206_10

					if var_206_10 + var_206_6 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_10 + var_206_6
					end
				end

				arg_203_1.text_.text = var_206_8
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_11 = math.max(var_206_7, arg_203_1.talkMaxDuration)

			if var_206_6 <= arg_203_1.time_ and arg_203_1.time_ < var_206_6 + var_206_11 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_6) / var_206_11

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_6 + var_206_11 and arg_203_1.time_ < var_206_6 + var_206_11 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "107001ui_story",
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
	Play414301051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 414301051
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play414301052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("107001ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action442")
			end

			local var_210_0 = 0
			local var_210_1 = 0.475

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_2 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(414301051).content)

				arg_207_1.text_.text = var_210_2

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_4 = 19 <= 0 and var_210_1 or var_210_1 * (utf8.len(var_210_2) / 19)

				if (19 <= 0 and var_210_1 or var_210_1 * (utf8.len(var_210_2) / 19)) > 0 and var_210_1 < var_210_4 then
					arg_207_1.talkMaxDuration = var_210_4

					if var_210_4 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_4 + var_210_0
					end
				end

				arg_207_1.text_.text = var_210_2
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_5 = math.max(var_210_1, arg_207_1.talkMaxDuration)

			if var_210_0 <= arg_207_1.time_ and arg_207_1.time_ < var_210_0 + var_210_5 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_0) / var_210_5

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_0 + var_210_5 and arg_207_1.time_ < var_210_0 + var_210_5 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play414301052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 414301052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play414301053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1148ui_story = arg_211_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_214_0 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 then
				arg_211_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1148ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_211_1.time_ - 0) / var_214_0)
				arg_211_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1148ui_story"].transform.position).z)
				arg_211_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1148ui_story"].transform.localEulerAngles = arg_211_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 then
				arg_211_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0.7, -0.8, -6.2)
				arg_211_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1148ui_story"].transform.position).z)
				arg_211_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1148ui_story"].transform.localEulerAngles = arg_211_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_214_1 = arg_211_1.actors_["1148ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect1148ui_story == nil then
				arg_211_1.var_.characterEffect1148ui_story = var_214_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_2 and not isNil(var_214_1) then
				if arg_211_1.var_.characterEffect1148ui_story and not isNil(var_214_1) then
					arg_211_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 0 + var_214_2 and arg_211_1.time_ < 0 + var_214_2 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect1148ui_story then
				arg_211_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action447")
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_214_4 = arg_211_1.actors_["107001ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_4) and arg_211_1.var_.characterEffect107001ui_story == nil then
				arg_211_1.var_.characterEffect107001ui_story = var_214_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_5 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_5 and not isNil(var_214_4) then
				if arg_211_1.var_.characterEffect107001ui_story and not isNil(var_214_4) then
					arg_211_1.var_.characterEffect107001ui_story.fillFlat = true
					arg_211_1.var_.characterEffect107001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_211_1.time_ - 0) / var_214_5)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_5 and arg_211_1.time_ < 0 + var_214_5 + arg_214_0 and not isNil(var_214_4) and arg_211_1.var_.characterEffect107001ui_story then
				arg_211_1.var_.characterEffect107001ui_story.fillFlat = true
				arg_211_1.var_.characterEffect107001ui_story.fillRatio = 0.5
			end

			local var_214_6 = 0
			local var_214_7 = 0.6

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_6 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_8 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(414301052).content)

				arg_211_1.text_.text = var_214_8

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_10 = 24 <= 0 and var_214_7 or var_214_7 * (utf8.len(var_214_8) / 24)

				if (24 <= 0 and var_214_7 or var_214_7 * (utf8.len(var_214_8) / 24)) > 0 and var_214_7 < var_214_10 then
					arg_211_1.talkMaxDuration = var_214_10

					if var_214_10 + var_214_6 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_10 + var_214_6
					end
				end

				arg_211_1.text_.text = var_214_8
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_11 = math.max(var_214_7, arg_211_1.talkMaxDuration)

			if var_214_6 <= arg_211_1.time_ and arg_211_1.time_ < var_214_6 + var_214_11 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_6) / var_214_11

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_6 + var_214_11 and arg_211_1.time_ < var_214_6 + var_214_11 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
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
	Play414301053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 414301053
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play414301054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_2")
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_218_0 = 0
			local var_218_1 = 0.55

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_2 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(414301053).content)

				arg_215_1.text_.text = var_218_2

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_4 = 22 <= 0 and var_218_1 or var_218_1 * (utf8.len(var_218_2) / 22)

				if (22 <= 0 and var_218_1 or var_218_1 * (utf8.len(var_218_2) / 22)) > 0 and var_218_1 < var_218_4 then
					arg_215_1.talkMaxDuration = var_218_4

					if var_218_4 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_4 + var_218_0
					end
				end

				arg_215_1.text_.text = var_218_2
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_5 = math.max(var_218_1, arg_215_1.talkMaxDuration)

			if var_218_0 <= arg_215_1.time_ and arg_215_1.time_ < var_218_0 + var_218_5 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_0) / var_218_5

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_0 + var_218_5 and arg_215_1.time_ < var_218_0 + var_218_5 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play414301054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 414301054
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play414301055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(arg_219_1.actors_["1148ui_story"]) and arg_219_1.var_.characterEffect1148ui_story == nil then
				arg_219_1.var_.characterEffect1148ui_story = arg_219_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_0 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 and not isNil(arg_219_1.actors_["1148ui_story"]) then
				if arg_219_1.var_.characterEffect1148ui_story and not isNil(arg_219_1.actors_["1148ui_story"]) then
					arg_219_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 0) / var_222_0)
				end
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 and not isNil(arg_219_1.actors_["1148ui_story"]) and arg_219_1.var_.characterEffect1148ui_story then
				arg_219_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_222_1 = 0
			local var_222_2 = 0.175

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_3 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(414301054).content)

				arg_219_1.text_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 7 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 7)

				if (7 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 7)) > 0 and var_222_2 < var_222_5 then
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
	Play414301055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 414301055
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play414301056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos104902ui_story = arg_223_1.actors_["104902ui_story"].transform.localPosition
			end

			local var_226_0 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 then
				arg_223_1.actors_["104902ui_story"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos104902ui_story, Vector3.New(0, -1.2, -6), (arg_223_1.time_ - 0) / var_226_0)
				arg_223_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["104902ui_story"].transform.position).z)
				arg_223_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["104902ui_story"].transform.localEulerAngles = arg_223_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 then
				arg_223_1.actors_["104902ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_223_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["104902ui_story"].transform.position).z)
				arg_223_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["104902ui_story"].transform.localEulerAngles = arg_223_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			local var_226_1 = arg_223_1.actors_["104902ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect104902ui_story == nil then
				arg_223_1.var_.characterEffect104902ui_story = var_226_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_2 and not isNil(var_226_1) then
				if arg_223_1.var_.characterEffect104902ui_story and not isNil(var_226_1) then
					arg_223_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 0 + var_226_2 and arg_223_1.time_ < 0 + var_226_2 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect104902ui_story then
				arg_223_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_226_4 = arg_223_1.actors_["1148ui_story"].transform

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos1148ui_story = var_226_4.localPosition
			end

			local var_226_5 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_5 then
				var_226_4.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_223_1.time_ - 0) / var_226_5)
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

			local var_226_6 = arg_223_1.actors_["1148ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_6) and arg_223_1.var_.characterEffect1148ui_story == nil then
				arg_223_1.var_.characterEffect1148ui_story = var_226_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_7 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_7 and not isNil(var_226_6) then
				if arg_223_1.var_.characterEffect1148ui_story and not isNil(var_226_6) then
					arg_223_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_7)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_7 and arg_223_1.time_ < 0 + var_226_7 + arg_226_0 and not isNil(var_226_6) and arg_223_1.var_.characterEffect1148ui_story then
				arg_223_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_226_8 = arg_223_1.actors_["107001ui_story"].transform

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos107001ui_story = var_226_8.localPosition
			end

			local var_226_9 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_9 then
				var_226_8.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos107001ui_story, Vector3.New(0, 100, 0), (arg_223_1.time_ - 0) / var_226_9)
				var_226_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_8.position).x, (manager.ui.mainCamera.transform.position - var_226_8.position).y, (manager.ui.mainCamera.transform.position - var_226_8.position).z)
				var_226_8.localEulerAngles.z = 0
				var_226_8.localEulerAngles.x = 0
				var_226_8.localEulerAngles = var_226_8.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_9 and arg_223_1.time_ < 0 + var_226_9 + arg_226_0 then
				var_226_8.localPosition = Vector3.New(0, 100, 0)
				var_226_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_8.position).x, (manager.ui.mainCamera.transform.position - var_226_8.position).y, (manager.ui.mainCamera.transform.position - var_226_8.position).z)
				var_226_8.localEulerAngles.z = 0
				var_226_8.localEulerAngles.x = 0
				var_226_8.localEulerAngles = var_226_8.localEulerAngles
			end

			local var_226_10 = arg_223_1.actors_["107001ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_10) and arg_223_1.var_.characterEffect107001ui_story == nil then
				arg_223_1.var_.characterEffect107001ui_story = var_226_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_11 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_11 and not isNil(var_226_10) then
				if arg_223_1.var_.characterEffect107001ui_story and not isNil(var_226_10) then
					arg_223_1.var_.characterEffect107001ui_story.fillFlat = true
					arg_223_1.var_.characterEffect107001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_11)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_11 and arg_223_1.time_ < 0 + var_226_11 + arg_226_0 and not isNil(var_226_10) and arg_223_1.var_.characterEffect107001ui_story then
				arg_223_1.var_.characterEffect107001ui_story.fillFlat = true
				arg_223_1.var_.characterEffect107001ui_story.fillRatio = 0.5
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/story104902/story104902action/104902action2_2")
			end

			local var_226_12 = 0
			local var_226_13 = 0.45

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_12 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_14 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(414301055).content)

				arg_223_1.text_.text = var_226_14

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_16 = 18 <= 0 and var_226_13 or var_226_13 * (utf8.len(var_226_14) / 18)

				if (18 <= 0 and var_226_13 or var_226_13 * (utf8.len(var_226_14) / 18)) > 0 and var_226_13 < var_226_16 then
					arg_223_1.talkMaxDuration = var_226_16

					if var_226_16 + var_226_12 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_16 + var_226_12
					end
				end

				arg_223_1.text_.text = var_226_14
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_17 = math.max(var_226_13, arg_223_1.talkMaxDuration)

			if var_226_12 <= arg_223_1.time_ and arg_223_1.time_ < var_226_12 + var_226_17 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_12) / var_226_17

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_12 + var_226_17 and arg_223_1.time_ < var_226_12 + var_226_17 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "107001ui_story",
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
	Play414301056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 414301056
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play414301057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(arg_227_1.actors_["104902ui_story"]) and arg_227_1.var_.characterEffect104902ui_story == nil then
				arg_227_1.var_.characterEffect104902ui_story = arg_227_1.actors_["104902ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_0 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 and not isNil(arg_227_1.actors_["104902ui_story"]) then
				if arg_227_1.var_.characterEffect104902ui_story and not isNil(arg_227_1.actors_["104902ui_story"]) then
					arg_227_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_227_1.var_.characterEffect104902ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_227_1.time_ - 0) / var_230_0)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 and not isNil(arg_227_1.actors_["104902ui_story"]) and arg_227_1.var_.characterEffect104902ui_story then
				arg_227_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_227_1.var_.characterEffect104902ui_story.fillRatio = 0.5
			end

			local var_230_1 = 0
			local var_230_2 = 0.7

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

				local var_230_3 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(414301056).content)

				arg_227_1.text_.text = var_230_3

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 28 <= 0 and var_230_2 or var_230_2 * (utf8.len(var_230_3) / 28)

				if (28 <= 0 and var_230_2 or var_230_2 * (utf8.len(var_230_3) / 28)) > 0 and var_230_2 < var_230_5 then
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
	Play414301057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 414301057
		arg_231_1.duration_ = 9

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play414301058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if arg_231_1.bgs_.ST0101 == nil then
				local var_234_0 = Object.Instantiate(arg_231_1.paintGo_)

				var_234_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0101")
				var_234_0.name = "ST0101"
				var_234_0.transform.parent = arg_231_1.stage_.transform
				var_234_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_231_1.bgs_.ST0101 = var_234_0
			end

			if 2 < arg_231_1.time_ and arg_231_1.time_ <= 2 + arg_234_0 then
				local var_234_1 = arg_231_1.bgs_.ST0101

				arg_231_1.bgs_.ST0101.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_234_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_234_2 = var_234_1:GetComponent("SpriteRenderer")

				if var_234_2 and var_234_2.sprite then
					local var_234_3 = 2 * (var_234_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_234_1.transform.localScale = Vector3.New(var_234_3 / var_234_2.sprite.bounds.size.y < var_234_3 * manager.ui.mainCameraCom_.aspect / var_234_2.sprite.bounds.size.x and var_234_3 * manager.ui.mainCameraCom_.aspect / var_234_2.sprite.bounds.size.x or var_234_3 / var_234_2.sprite.bounds.size.y, var_234_3 / var_234_2.sprite.bounds.size.y < var_234_3 * manager.ui.mainCameraCom_.aspect / var_234_2.sprite.bounds.size.x and var_234_3 * manager.ui.mainCameraCom_.aspect / var_234_2.sprite.bounds.size.x or var_234_3 / var_234_2.sprite.bounds.size.y, 0)
				end

				for iter_234_0, iter_234_1 in pairs(arg_231_1.bgs_) do
					if iter_234_0 ~= "ST0101" then
						iter_234_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_234_4 = 0

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_4 + arg_234_0 then
				arg_231_1.allBtn_.enabled = false
			end

			if arg_231_1.time_ >= var_234_4 + 0.3 and arg_231_1.time_ < var_234_4 + 0.3 + arg_234_0 then
				arg_231_1.allBtn_.enabled = true
			end

			local var_234_5 = 0

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_5 + arg_234_0 then
				arg_231_1.mask_.enabled = true
				arg_231_1.mask_.raycastTarget = true

				arg_231_1:SetGaussion(false)
			end

			local var_234_6 = 2

			if var_234_5 <= arg_231_1.time_ and arg_231_1.time_ < var_234_5 + var_234_6 then
				local var_234_7 = Color.New(0, 0, 0)

				var_234_7.a = Mathf.Lerp(0, 1, (arg_231_1.time_ - var_234_5) / var_234_6)
				arg_231_1.mask_.color = var_234_7
			end

			if arg_231_1.time_ >= var_234_5 + var_234_6 and arg_231_1.time_ < var_234_5 + var_234_6 + arg_234_0 then
				local var_234_8 = Color.New(0, 0, 0)

				var_234_8.a = 1
				arg_231_1.mask_.color = var_234_8
			end

			local var_234_9 = 2

			if 2 < arg_231_1.time_ and arg_231_1.time_ <= var_234_9 + arg_234_0 then
				arg_231_1.mask_.enabled = true
				arg_231_1.mask_.raycastTarget = true

				arg_231_1:SetGaussion(false)
			end

			local var_234_10 = 2

			if var_234_9 <= arg_231_1.time_ and arg_231_1.time_ < var_234_9 + var_234_10 then
				local var_234_11 = Color.New(0, 0, 0)

				var_234_11.a = Mathf.Lerp(1, 0, (arg_231_1.time_ - var_234_9) / var_234_10)
				arg_231_1.mask_.color = var_234_11
			end

			if arg_231_1.time_ >= var_234_9 + var_234_10 and arg_231_1.time_ < var_234_9 + var_234_10 + arg_234_0 then
				local var_234_12 = Color.New(0, 0, 0)

				arg_231_1.mask_.enabled = false
				var_234_12.a = 0
				arg_231_1.mask_.color = var_234_12
			end

			local var_234_13 = arg_231_1.actors_["104902ui_story"].transform

			if 2 < arg_231_1.time_ and arg_231_1.time_ <= 2 + arg_234_0 then
				arg_231_1.var_.moveOldPos104902ui_story = var_234_13.localPosition
			end

			local var_234_14 = 0.001

			if 2 <= arg_231_1.time_ and arg_231_1.time_ < 2 + var_234_14 then
				var_234_13.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos104902ui_story, Vector3.New(0, 100, 0), (arg_231_1.time_ - 2) / var_234_14)
				var_234_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_13.position).x, (manager.ui.mainCamera.transform.position - var_234_13.position).y, (manager.ui.mainCamera.transform.position - var_234_13.position).z)
				var_234_13.localEulerAngles.z = 0
				var_234_13.localEulerAngles.x = 0
				var_234_13.localEulerAngles = var_234_13.localEulerAngles
			end

			if arg_231_1.time_ >= 2 + var_234_14 and arg_231_1.time_ < 2 + var_234_14 + arg_234_0 then
				var_234_13.localPosition = Vector3.New(0, 100, 0)
				var_234_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_13.position).x, (manager.ui.mainCamera.transform.position - var_234_13.position).y, (manager.ui.mainCamera.transform.position - var_234_13.position).z)
				var_234_13.localEulerAngles.z = 0
				var_234_13.localEulerAngles.x = 0
				var_234_13.localEulerAngles = var_234_13.localEulerAngles
			end

			if arg_231_1.frameCnt_ <= 1 then
				arg_231_1.dialog_:SetActive(false)
			end

			local var_234_15 = 4
			local var_234_16 = 0.6

			if 4 < arg_231_1.time_ and arg_231_1.time_ <= var_234_15 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0

				arg_231_1.dialog_:SetActive(true)

				arg_231_1.dialogCg_.alpha = 0

				local var_234_17 = LeanTween.value(arg_231_1.dialog_, 0, 1, 0.3)

				var_234_17:setOnUpdate(LuaHelper.FloatAction(function(arg_235_0)
					arg_231_1.dialogCg_.alpha = arg_235_0
				end))
				var_234_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_231_1.dialog_)
					var_234_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_231_1.duration_ = arg_231_1.duration_ + 0.3

				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1049")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_18 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(414301057).content)

				arg_231_1.text_.text = var_234_18

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_20 = 24 <= 0 and var_234_16 or var_234_16 * (utf8.len(var_234_18) / 24)

				if (24 <= 0 and var_234_16 or var_234_16 * (utf8.len(var_234_18) / 24)) > 0 and var_234_16 < var_234_20 then
					arg_231_1.talkMaxDuration = var_234_20
					var_234_15 = var_234_15 + 0.3

					if var_234_20 + var_234_15 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_20 + var_234_15
					end
				end

				arg_231_1.text_.text = var_234_18
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_21 = var_234_15 + 0.3
			local var_234_22 = math.max(var_234_16, arg_231_1.talkMaxDuration)

			if var_234_15 + 0.3 <= arg_231_1.time_ and arg_231_1.time_ < var_234_21 + var_234_22 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_21) / var_234_22

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_21 + var_234_22 and arg_231_1.time_ < var_234_21 + var_234_22 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play414301058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 414301058
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play414301059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(arg_237_1.actors_["104902ui_story"]) and arg_237_1.var_.characterEffect104902ui_story == nil then
				arg_237_1.var_.characterEffect104902ui_story = arg_237_1.actors_["104902ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_0 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 and not isNil(arg_237_1.actors_["104902ui_story"]) then
				if arg_237_1.var_.characterEffect104902ui_story and not isNil(arg_237_1.actors_["104902ui_story"]) then
					arg_237_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_237_1.var_.characterEffect104902ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_0)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 and not isNil(arg_237_1.actors_["104902ui_story"]) and arg_237_1.var_.characterEffect104902ui_story then
				arg_237_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_237_1.var_.characterEffect104902ui_story.fillRatio = 0.5
			end

			local var_240_1 = 0
			local var_240_2 = 0.65

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

				local var_240_3 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(414301058).content)

				arg_237_1.text_.text = var_240_3

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_5 = 26 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_3) / 26)

				if (26 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_3) / 26)) > 0 and var_240_2 < var_240_5 then
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
	Play414301059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 414301059
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play414301060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0.925

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_1 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(414301059).content)

				arg_241_1.text_.text = var_244_1

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_3 = 37 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_1) / 37)

				if (37 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_1) / 37)) > 0 and var_244_0 < var_244_3 then
					arg_241_1.talkMaxDuration = var_244_3

					if var_244_3 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_3 + 0
					end
				end

				arg_241_1.text_.text = var_244_1
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_4 = math.max(var_244_0, arg_241_1.talkMaxDuration)

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_4 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - 0) / var_244_4

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= 0 + var_244_4 and arg_241_1.time_ < 0 + var_244_4 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play414301060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 414301060
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play414301061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0.575

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_1 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(414301060).content)

				arg_245_1.text_.text = var_248_1

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_3 = 23 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_1) / 23)

				if (23 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_1) / 23)) > 0 and var_248_0 < var_248_3 then
					arg_245_1.talkMaxDuration = var_248_3

					if var_248_3 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_3 + 0
					end
				end

				arg_245_1.text_.text = var_248_1
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_4 = math.max(var_248_0, arg_245_1.talkMaxDuration)

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_4 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - 0) / var_248_4

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= 0 + var_248_4 and arg_245_1.time_ < 0 + var_248_4 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play414301061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 414301061
		arg_249_1.duration_ = 7.53

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play414301062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 1.26666666666667 < arg_249_1.time_ and arg_249_1.time_ <= 1.26666666666667 + arg_252_0 then
				local var_252_0 = arg_249_1.bgs_.H07f

				arg_249_1.bgs_.H07f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_252_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_252_1 = var_252_0:GetComponent("SpriteRenderer")

				if var_252_1 and var_252_1.sprite then
					local var_252_2 = 2 * (var_252_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_252_0.transform.localScale = Vector3.New(var_252_2 / var_252_1.sprite.bounds.size.y < var_252_2 * manager.ui.mainCameraCom_.aspect / var_252_1.sprite.bounds.size.x and var_252_2 * manager.ui.mainCameraCom_.aspect / var_252_1.sprite.bounds.size.x or var_252_2 / var_252_1.sprite.bounds.size.y, var_252_2 / var_252_1.sprite.bounds.size.y < var_252_2 * manager.ui.mainCameraCom_.aspect / var_252_1.sprite.bounds.size.x and var_252_2 * manager.ui.mainCameraCom_.aspect / var_252_1.sprite.bounds.size.x or var_252_2 / var_252_1.sprite.bounds.size.y, 0)
				end

				for iter_252_0, iter_252_1 in pairs(arg_249_1.bgs_) do
					if iter_252_0 ~= "H07f" then
						iter_252_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_252_3 = 0

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_3 + arg_252_0 then
				arg_249_1.allBtn_.enabled = false
			end

			if arg_249_1.time_ >= var_252_3 + 0.3 and arg_249_1.time_ < var_252_3 + 0.3 + arg_252_0 then
				arg_249_1.allBtn_.enabled = true
			end

			local var_252_4 = 0

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_4 + arg_252_0 then
				arg_249_1.mask_.enabled = true
				arg_249_1.mask_.raycastTarget = true

				arg_249_1:SetGaussion(false)
			end

			local var_252_5 = 1.26666666666667

			if var_252_4 <= arg_249_1.time_ and arg_249_1.time_ < var_252_4 + var_252_5 then
				local var_252_6 = Color.New(0, 0, 0)

				var_252_6.a = Mathf.Lerp(0, 1, (arg_249_1.time_ - var_252_4) / var_252_5)
				arg_249_1.mask_.color = var_252_6
			end

			if arg_249_1.time_ >= var_252_4 + var_252_5 and arg_249_1.time_ < var_252_4 + var_252_5 + arg_252_0 then
				local var_252_7 = Color.New(0, 0, 0)

				var_252_7.a = 1
				arg_249_1.mask_.color = var_252_7
			end

			local var_252_8 = 1.26666666666667

			if 1.26666666666667 < arg_249_1.time_ and arg_249_1.time_ <= var_252_8 + arg_252_0 then
				arg_249_1.mask_.enabled = true
				arg_249_1.mask_.raycastTarget = true

				arg_249_1:SetGaussion(false)
			end

			local var_252_9 = 1.43333333333333

			if var_252_8 <= arg_249_1.time_ and arg_249_1.time_ < var_252_8 + var_252_9 then
				local var_252_10 = Color.New(0, 0, 0)

				var_252_10.a = Mathf.Lerp(1, 0, (arg_249_1.time_ - var_252_8) / var_252_9)
				arg_249_1.mask_.color = var_252_10
			end

			if arg_249_1.time_ >= var_252_8 + var_252_9 and arg_249_1.time_ < var_252_8 + var_252_9 + arg_252_0 then
				local var_252_11 = Color.New(0, 0, 0)

				arg_249_1.mask_.enabled = false
				var_252_11.a = 0
				arg_249_1.mask_.color = var_252_11
			end

			if arg_249_1.frameCnt_ <= 1 then
				arg_249_1.dialog_:SetActive(false)
			end

			local var_252_12 = 2.53333333333333
			local var_252_13 = 1.175

			if 2.53333333333333 < arg_249_1.time_ and arg_249_1.time_ <= var_252_12 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0

				arg_249_1.dialog_:SetActive(true)

				arg_249_1.dialogCg_.alpha = 0

				local var_252_14 = LeanTween.value(arg_249_1.dialog_, 0, 1, 0.3)

				var_252_14:setOnUpdate(LuaHelper.FloatAction(function(arg_253_0)
					arg_249_1.dialogCg_.alpha = arg_253_0
				end))
				var_252_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_249_1.dialog_)
					var_252_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_249_1.duration_ = arg_249_1.duration_ + 0.3

				SetActive(arg_249_1.leftNameGo_, false)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_15 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(414301061).content)

				arg_249_1.text_.text = var_252_15

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_17 = 47 <= 0 and var_252_13 or var_252_13 * (utf8.len(var_252_15) / 47)

				if (47 <= 0 and var_252_13 or var_252_13 * (utf8.len(var_252_15) / 47)) > 0 and var_252_13 < var_252_17 then
					arg_249_1.talkMaxDuration = var_252_17
					var_252_12 = var_252_12 + 0.3

					if var_252_17 + var_252_12 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_17 + var_252_12
					end
				end

				arg_249_1.text_.text = var_252_15
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_18 = var_252_12 + 0.3
			local var_252_19 = math.max(var_252_13, arg_249_1.talkMaxDuration)

			if var_252_12 + 0.3 <= arg_249_1.time_ and arg_249_1.time_ < var_252_18 + var_252_19 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_18) / var_252_19

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_18 + var_252_19 and arg_249_1.time_ < var_252_18 + var_252_19 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play414301062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 414301062
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play414301063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos1148ui_story = arg_255_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_258_0 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 then
				arg_255_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_255_1.time_ - 0) / var_258_0)
				arg_255_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1148ui_story"].transform.position).z)
				arg_255_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["1148ui_story"].transform.localEulerAngles = arg_255_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 then
				arg_255_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_255_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1148ui_story"].transform.position).z)
				arg_255_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["1148ui_story"].transform.localEulerAngles = arg_255_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_258_1 = arg_255_1.actors_["1148ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_1) and arg_255_1.var_.characterEffect1148ui_story == nil then
				arg_255_1.var_.characterEffect1148ui_story = var_258_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_2 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_2 and not isNil(var_258_1) then
				if arg_255_1.var_.characterEffect1148ui_story and not isNil(var_258_1) then
					arg_255_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= 0 + var_258_2 and arg_255_1.time_ < 0 + var_258_2 + arg_258_0 and not isNil(var_258_1) and arg_255_1.var_.characterEffect1148ui_story then
				arg_255_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_258_4 = 0
			local var_258_5 = 0.425

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_4 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_6 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(414301062).content)

				arg_255_1.text_.text = var_258_6

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_8 = 17 <= 0 and var_258_5 or var_258_5 * (utf8.len(var_258_6) / 17)

				if (17 <= 0 and var_258_5 or var_258_5 * (utf8.len(var_258_6) / 17)) > 0 and var_258_5 < var_258_8 then
					arg_255_1.talkMaxDuration = var_258_8

					if var_258_8 + var_258_4 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_8 + var_258_4
					end
				end

				arg_255_1.text_.text = var_258_6
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_9 = math.max(var_258_5, arg_255_1.talkMaxDuration)

			if var_258_4 <= arg_255_1.time_ and arg_255_1.time_ < var_258_4 + var_258_9 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_4) / var_258_9

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_4 + var_258_9 and arg_255_1.time_ < var_258_4 + var_258_9 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play414301063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 414301063
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play414301064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos1148ui_story = arg_259_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_262_0 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 then
				arg_259_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_259_1.time_ - 0) / var_262_0)
				arg_259_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1148ui_story"].transform.position).z)
				arg_259_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["1148ui_story"].transform.localEulerAngles = arg_259_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 then
				arg_259_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_259_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1148ui_story"].transform.position).z)
				arg_259_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["1148ui_story"].transform.localEulerAngles = arg_259_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_262_1 = arg_259_1.actors_["1148ui_story"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_1) and arg_259_1.var_.characterEffect1148ui_story == nil then
				arg_259_1.var_.characterEffect1148ui_story = var_262_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_2 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_2 and not isNil(var_262_1) then
				if arg_259_1.var_.characterEffect1148ui_story and not isNil(var_262_1) then
					arg_259_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_259_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_259_1.time_ - 0) / var_262_2)
				end
			end

			if arg_259_1.time_ >= 0 + var_262_2 and arg_259_1.time_ < 0 + var_262_2 + arg_262_0 and not isNil(var_262_1) and arg_259_1.var_.characterEffect1148ui_story then
				arg_259_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_259_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_262_3 = arg_259_1.actors_["107001ui_story"].transform

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos107001ui_story = var_262_3.localPosition
			end

			local var_262_4 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_4 then
				var_262_3.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos107001ui_story, Vector3.New(0, -0.95, -6.05), (arg_259_1.time_ - 0) / var_262_4)
				var_262_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_262_3.position).x, (manager.ui.mainCamera.transform.position - var_262_3.position).y, (manager.ui.mainCamera.transform.position - var_262_3.position).z)
				var_262_3.localEulerAngles.z = 0
				var_262_3.localEulerAngles.x = 0
				var_262_3.localEulerAngles = var_262_3.localEulerAngles
			end

			if arg_259_1.time_ >= 0 + var_262_4 and arg_259_1.time_ < 0 + var_262_4 + arg_262_0 then
				var_262_3.localPosition = Vector3.New(0, -0.95, -6.05)
				var_262_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_262_3.position).x, (manager.ui.mainCamera.transform.position - var_262_3.position).y, (manager.ui.mainCamera.transform.position - var_262_3.position).z)
				var_262_3.localEulerAngles.z = 0
				var_262_3.localEulerAngles.x = 0
				var_262_3.localEulerAngles = var_262_3.localEulerAngles
			end

			local var_262_5 = arg_259_1.actors_["107001ui_story"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_5) and arg_259_1.var_.characterEffect107001ui_story == nil then
				arg_259_1.var_.characterEffect107001ui_story = var_262_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_6 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_6 and not isNil(var_262_5) then
				if arg_259_1.var_.characterEffect107001ui_story and not isNil(var_262_5) then
					arg_259_1.var_.characterEffect107001ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= 0 + var_262_6 and arg_259_1.time_ < 0 + var_262_6 + arg_262_0 and not isNil(var_262_5) and arg_259_1.var_.characterEffect107001ui_story then
				arg_259_1.var_.characterEffect107001ui_story.fillFlat = false
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("107001ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action2_2")
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("107001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_262_8 = 0
			local var_262_9 = 0.45

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_8 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_10 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(414301063).content)

				arg_259_1.text_.text = var_262_10

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_12 = 18 <= 0 and var_262_9 or var_262_9 * (utf8.len(var_262_10) / 18)

				if (18 <= 0 and var_262_9 or var_262_9 * (utf8.len(var_262_10) / 18)) > 0 and var_262_9 < var_262_12 then
					arg_259_1.talkMaxDuration = var_262_12

					if var_262_12 + var_262_8 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_12 + var_262_8
					end
				end

				arg_259_1.text_.text = var_262_10
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_13 = math.max(var_262_9, arg_259_1.talkMaxDuration)

			if var_262_8 <= arg_259_1.time_ and arg_259_1.time_ < var_262_8 + var_262_13 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_8) / var_262_13

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_8 + var_262_13 and arg_259_1.time_ < var_262_8 + var_262_13 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "107001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_259_1:InitPlayNodeList()
	end,
	Play414301064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 414301064
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play414301065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(arg_263_1.actors_["107001ui_story"]) and arg_263_1.var_.characterEffect107001ui_story == nil then
				arg_263_1.var_.characterEffect107001ui_story = arg_263_1.actors_["107001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_0 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 and not isNil(arg_263_1.actors_["107001ui_story"]) then
				if arg_263_1.var_.characterEffect107001ui_story and not isNil(arg_263_1.actors_["107001ui_story"]) then
					arg_263_1.var_.characterEffect107001ui_story.fillFlat = true
					arg_263_1.var_.characterEffect107001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_263_1.time_ - 0) / var_266_0)
				end
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 and not isNil(arg_263_1.actors_["107001ui_story"]) and arg_263_1.var_.characterEffect107001ui_story then
				arg_263_1.var_.characterEffect107001ui_story.fillFlat = true
				arg_263_1.var_.characterEffect107001ui_story.fillRatio = 0.5
			end

			local var_266_1 = 0
			local var_266_2 = 0.4

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

				local var_266_3 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(414301064).content)

				arg_263_1.text_.text = var_266_3

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_5 = 16 <= 0 and var_266_2 or var_266_2 * (utf8.len(var_266_3) / 16)

				if (16 <= 0 and var_266_2 or var_266_2 * (utf8.len(var_266_3) / 16)) > 0 and var_266_2 < var_266_5 then
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
	Play414301065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 414301065
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play414301066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPos107001ui_story = arg_267_1.actors_["107001ui_story"].transform.localPosition

				arg_267_1:ShowWeapon(arg_267_1.var_["107001ui_story" .. "Animator"].transform, false)
			end

			local var_270_0 = 0.001

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 then
				arg_267_1.actors_["107001ui_story"].transform.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos107001ui_story, Vector3.New(0, 100, 0), (arg_267_1.time_ - 0) / var_270_0)
				arg_267_1.actors_["107001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_267_1.actors_["107001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["107001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["107001ui_story"].transform.position).z)
				arg_267_1.actors_["107001ui_story"].transform.localEulerAngles.z = 0
				arg_267_1.actors_["107001ui_story"].transform.localEulerAngles.x = 0
				arg_267_1.actors_["107001ui_story"].transform.localEulerAngles = arg_267_1.actors_["107001ui_story"].transform.localEulerAngles
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 then
				arg_267_1.actors_["107001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_267_1.actors_["107001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_267_1.actors_["107001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["107001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["107001ui_story"].transform.position).z)
				arg_267_1.actors_["107001ui_story"].transform.localEulerAngles.z = 0
				arg_267_1.actors_["107001ui_story"].transform.localEulerAngles.x = 0
				arg_267_1.actors_["107001ui_story"].transform.localEulerAngles = arg_267_1.actors_["107001ui_story"].transform.localEulerAngles
			end

			local var_270_1 = 0
			local var_270_2 = 0.35

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

				local var_270_3 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(414301065).content)

				arg_267_1.text_.text = var_270_3

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_5 = 14 <= 0 and var_270_2 or var_270_2 * (utf8.len(var_270_3) / 14)

				if (14 <= 0 and var_270_2 or var_270_2 * (utf8.len(var_270_3) / 14)) > 0 and var_270_2 < var_270_5 then
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

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "107001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play414301066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 414301066
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play414301067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos107001ui_story = arg_271_1.actors_["107001ui_story"].transform.localPosition
			end

			local var_274_0 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 then
				arg_271_1.actors_["107001ui_story"].transform.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos107001ui_story, Vector3.New(0, 100, 0), (arg_271_1.time_ - 0) / var_274_0)
				arg_271_1.actors_["107001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["107001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["107001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["107001ui_story"].transform.position).z)
				arg_271_1.actors_["107001ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["107001ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["107001ui_story"].transform.localEulerAngles = arg_271_1.actors_["107001ui_story"].transform.localEulerAngles
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 then
				arg_271_1.actors_["107001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_271_1.actors_["107001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["107001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["107001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["107001ui_story"].transform.position).z)
				arg_271_1.actors_["107001ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["107001ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["107001ui_story"].transform.localEulerAngles = arg_271_1.actors_["107001ui_story"].transform.localEulerAngles
			end

			local var_274_1 = arg_271_1.actors_["107001ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_1) and arg_271_1.var_.characterEffect107001ui_story == nil then
				arg_271_1.var_.characterEffect107001ui_story = var_274_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_2 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_2 and not isNil(var_274_1) then
				if arg_271_1.var_.characterEffect107001ui_story and not isNil(var_274_1) then
					arg_271_1.var_.characterEffect107001ui_story.fillFlat = true
					arg_271_1.var_.characterEffect107001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_271_1.time_ - 0) / var_274_2)
				end
			end

			if arg_271_1.time_ >= 0 + var_274_2 and arg_271_1.time_ < 0 + var_274_2 + arg_274_0 and not isNil(var_274_1) and arg_271_1.var_.characterEffect107001ui_story then
				arg_271_1.var_.characterEffect107001ui_story.fillFlat = true
				arg_271_1.var_.characterEffect107001ui_story.fillRatio = 0.5
			end

			local var_274_3 = arg_271_1.actors_["1035ui_story"].transform

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos1035ui_story = var_274_3.localPosition
			end

			local var_274_4 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_4 then
				var_274_3.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1035ui_story, Vector3.New(0, -1.05, -5.6), (arg_271_1.time_ - 0) / var_274_4)
				var_274_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_274_3.position).x, (manager.ui.mainCamera.transform.position - var_274_3.position).y, (manager.ui.mainCamera.transform.position - var_274_3.position).z)
				var_274_3.localEulerAngles.z = 0
				var_274_3.localEulerAngles.x = 0
				var_274_3.localEulerAngles = var_274_3.localEulerAngles
			end

			if arg_271_1.time_ >= 0 + var_274_4 and arg_271_1.time_ < 0 + var_274_4 + arg_274_0 then
				var_274_3.localPosition = Vector3.New(0, -1.05, -5.6)
				var_274_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_274_3.position).x, (manager.ui.mainCamera.transform.position - var_274_3.position).y, (manager.ui.mainCamera.transform.position - var_274_3.position).z)
				var_274_3.localEulerAngles.z = 0
				var_274_3.localEulerAngles.x = 0
				var_274_3.localEulerAngles = var_274_3.localEulerAngles
			end

			local var_274_5 = arg_271_1.actors_["1035ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_5) and arg_271_1.var_.characterEffect1035ui_story == nil then
				arg_271_1.var_.characterEffect1035ui_story = var_274_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_6 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_6 and not isNil(var_274_5) then
				if arg_271_1.var_.characterEffect1035ui_story and not isNil(var_274_5) then
					arg_271_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= 0 + var_274_6 and arg_271_1.time_ < 0 + var_274_6 + arg_274_0 and not isNil(var_274_5) and arg_271_1.var_.characterEffect1035ui_story then
				arg_271_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035actionlink/1035action467")
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_274_8 = 0
			local var_274_9 = 0.775

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_8 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_10 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(414301066).content)

				arg_271_1.text_.text = var_274_10

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_12 = 31 <= 0 and var_274_9 or var_274_9 * (utf8.len(var_274_10) / 31)

				if (31 <= 0 and var_274_9 or var_274_9 * (utf8.len(var_274_10) / 31)) > 0 and var_274_9 < var_274_12 then
					arg_271_1.talkMaxDuration = var_274_12

					if var_274_12 + var_274_8 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_12 + var_274_8
					end
				end

				arg_271_1.text_.text = var_274_10
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_13 = math.max(var_274_9, arg_271_1.talkMaxDuration)

			if var_274_8 <= arg_271_1.time_ and arg_271_1.time_ < var_274_8 + var_274_13 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_8) / var_274_13

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_8 + var_274_13 and arg_271_1.time_ < var_274_8 + var_274_13 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "107001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play414301067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 414301067
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play414301068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos1035ui_story = arg_275_1.actors_["1035ui_story"].transform.localPosition
			end

			local var_278_0 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 then
				arg_275_1.actors_["1035ui_story"].transform.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos1035ui_story, Vector3.New(0, 100, 0), (arg_275_1.time_ - 0) / var_278_0)
				arg_275_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1035ui_story"].transform.position).z)
				arg_275_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["1035ui_story"].transform.localEulerAngles = arg_275_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 then
				arg_275_1.actors_["1035ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_275_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1035ui_story"].transform.position).z)
				arg_275_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["1035ui_story"].transform.localEulerAngles = arg_275_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			local var_278_1 = arg_275_1.actors_["1035ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect1035ui_story == nil then
				arg_275_1.var_.characterEffect1035ui_story = var_278_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_2 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_2 and not isNil(var_278_1) then
				if arg_275_1.var_.characterEffect1035ui_story and not isNil(var_278_1) then
					arg_275_1.var_.characterEffect1035ui_story.fillFlat = true
					arg_275_1.var_.characterEffect1035ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_275_1.time_ - 0) / var_278_2)
				end
			end

			if arg_275_1.time_ >= 0 + var_278_2 and arg_275_1.time_ < 0 + var_278_2 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect1035ui_story then
				arg_275_1.var_.characterEffect1035ui_story.fillFlat = true
				arg_275_1.var_.characterEffect1035ui_story.fillRatio = 0.5
			end

			local var_278_3 = arg_275_1.actors_["1016ui_story"].transform

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos1016ui_story = var_278_3.localPosition
			end

			local var_278_4 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_4 then
				var_278_3.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos1016ui_story, Vector3.New(0, -18.66, -121.78), (arg_275_1.time_ - 0) / var_278_4)
				var_278_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_278_3.position).x, (manager.ui.mainCamera.transform.position - var_278_3.position).y, (manager.ui.mainCamera.transform.position - var_278_3.position).z)
				var_278_3.localEulerAngles.z = 0
				var_278_3.localEulerAngles.x = 0
				var_278_3.localEulerAngles = var_278_3.localEulerAngles
			end

			if arg_275_1.time_ >= 0 + var_278_4 and arg_275_1.time_ < 0 + var_278_4 + arg_278_0 then
				var_278_3.localPosition = Vector3.New(0, -18.66, -121.78)
				var_278_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_278_3.position).x, (manager.ui.mainCamera.transform.position - var_278_3.position).y, (manager.ui.mainCamera.transform.position - var_278_3.position).z)
				var_278_3.localEulerAngles.z = 0
				var_278_3.localEulerAngles.x = 0
				var_278_3.localEulerAngles = var_278_3.localEulerAngles
			end

			local var_278_5 = arg_275_1.actors_["1016ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_5) and arg_275_1.var_.characterEffect1016ui_story == nil then
				arg_275_1.var_.characterEffect1016ui_story = var_278_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_6 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_6 and not isNil(var_278_5) then
				if arg_275_1.var_.characterEffect1016ui_story and not isNil(var_278_5) then
					arg_275_1.var_.characterEffect1016ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= 0 + var_278_6 and arg_275_1.time_ < 0 + var_278_6 + arg_278_0 and not isNil(var_278_5) and arg_275_1.var_.characterEffect1016ui_story then
				arg_275_1.var_.characterEffect1016ui_story.fillFlat = false
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/story1016/story1016action/1016action7_1")
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_278_8 = 0
			local var_278_9 = 0.225

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_8 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[260].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_10 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(414301067).content)

				arg_275_1.text_.text = var_278_10

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_12 = 9 <= 0 and var_278_9 or var_278_9 * (utf8.len(var_278_10) / 9)

				if (9 <= 0 and var_278_9 or var_278_9 * (utf8.len(var_278_10) / 9)) > 0 and var_278_9 < var_278_12 then
					arg_275_1.talkMaxDuration = var_278_12

					if var_278_12 + var_278_8 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_12 + var_278_8
					end
				end

				arg_275_1.text_.text = var_278_10
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_13 = math.max(var_278_9, arg_275_1.talkMaxDuration)

			if var_278_8 <= arg_275_1.time_ and arg_275_1.time_ < var_278_8 + var_278_13 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_8) / var_278_13

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_8 + var_278_13 and arg_275_1.time_ < var_278_8 + var_278_13 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_275_1:InitPlayNodeList()
	end,
	Play414301068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 414301068
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play414301069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos1016ui_story = arg_279_1.actors_["1016ui_story"].transform.localPosition
			end

			local var_282_0 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 then
				arg_279_1.actors_["1016ui_story"].transform.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1016ui_story, Vector3.New(0, 100, 0), (arg_279_1.time_ - 0) / var_282_0)
				arg_279_1.actors_["1016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["1016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1016ui_story"].transform.position).z)
				arg_279_1.actors_["1016ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["1016ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["1016ui_story"].transform.localEulerAngles = arg_279_1.actors_["1016ui_story"].transform.localEulerAngles
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 then
				arg_279_1.actors_["1016ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_279_1.actors_["1016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["1016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1016ui_story"].transform.position).z)
				arg_279_1.actors_["1016ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["1016ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["1016ui_story"].transform.localEulerAngles = arg_279_1.actors_["1016ui_story"].transform.localEulerAngles
			end

			local var_282_1 = arg_279_1.actors_["1016ui_story"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect1016ui_story == nil then
				arg_279_1.var_.characterEffect1016ui_story = var_282_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_2 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_2 and not isNil(var_282_1) then
				if arg_279_1.var_.characterEffect1016ui_story and not isNil(var_282_1) then
					arg_279_1.var_.characterEffect1016ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1016ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_279_1.time_ - 0) / var_282_2)
				end
			end

			if arg_279_1.time_ >= 0 + var_282_2 and arg_279_1.time_ < 0 + var_282_2 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect1016ui_story then
				arg_279_1.var_.characterEffect1016ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1016ui_story.fillRatio = 0.5
			end

			local var_282_3 = 0
			local var_282_4 = 0.85

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_3 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_5 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(414301068).content)

				arg_279_1.text_.text = var_282_5

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_7 = 34 <= 0 and var_282_4 or var_282_4 * (utf8.len(var_282_5) / 34)

				if (34 <= 0 and var_282_4 or var_282_4 * (utf8.len(var_282_5) / 34)) > 0 and var_282_4 < var_282_7 then
					arg_279_1.talkMaxDuration = var_282_7

					if var_282_7 + var_282_3 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_7 + var_282_3
					end
				end

				arg_279_1.text_.text = var_282_5
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_8 = math.max(var_282_4, arg_279_1.talkMaxDuration)

			if var_282_3 <= arg_279_1.time_ and arg_279_1.time_ < var_282_3 + var_282_8 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_3) / var_282_8

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_3 + var_282_8 and arg_279_1.time_ < var_282_3 + var_282_8 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play414301069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 414301069
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play414301070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 0.3

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

				local var_286_1 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(414301069).content)

				arg_283_1.text_.text = var_286_1

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_3 = 12 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 12)

				if (12 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 12)) > 0 and var_286_0 < var_286_3 then
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
	Play414301070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 414301070
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
			arg_287_1.auto_ = false
		end

		function arg_287_1.playNext_(arg_289_0)
			arg_287_1.onStoryFinished_()
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.var_.moveOldPos1148ui_story = arg_287_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_290_0 = 0.001

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 then
				arg_287_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_287_1.time_ - 0) / var_290_0)
				arg_287_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_287_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1148ui_story"].transform.position).z)
				arg_287_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_287_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_287_1.actors_["1148ui_story"].transform.localEulerAngles = arg_287_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 then
				arg_287_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_287_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_287_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1148ui_story"].transform.position).z)
				arg_287_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_287_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_287_1.actors_["1148ui_story"].transform.localEulerAngles = arg_287_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_290_1 = arg_287_1.actors_["1148ui_story"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_1) and arg_287_1.var_.characterEffect1148ui_story == nil then
				arg_287_1.var_.characterEffect1148ui_story = var_290_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_2 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_2 and not isNil(var_290_1) then
				if arg_287_1.var_.characterEffect1148ui_story and not isNil(var_290_1) then
					arg_287_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= 0 + var_290_2 and arg_287_1.time_ < 0 + var_290_2 + arg_290_0 and not isNil(var_290_1) and arg_287_1.var_.characterEffect1148ui_story then
				arg_287_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action435")
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_290_4 = 0
			local var_290_5 = 0.45

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_4 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_6 = arg_287_1:FormatText(arg_287_1:GetWordFromCfg(414301070).content)

				arg_287_1.text_.text = var_290_6

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_8 = 18 <= 0 and var_290_5 or var_290_5 * (utf8.len(var_290_6) / 18)

				if (18 <= 0 and var_290_5 or var_290_5 * (utf8.len(var_290_6) / 18)) > 0 and var_290_5 < var_290_8 then
					arg_287_1.talkMaxDuration = var_290_8

					if var_290_8 + var_290_4 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_8 + var_290_4
					end
				end

				arg_287_1.text_.text = var_290_6
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_9 = math.max(var_290_5, arg_287_1.talkMaxDuration)

			if var_290_4 <= arg_287_1.time_ and arg_287_1.time_ < var_290_4 + var_290_9 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_4) / var_290_9

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_4 + var_290_9 and arg_287_1.time_ < var_290_4 + var_290_9 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
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
	Play414301019 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 414301019
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play414301020(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(arg_291_1.actors_["104902ui_story"]) and arg_291_1.var_.characterEffect104902ui_story == nil then
				arg_291_1.var_.characterEffect104902ui_story = arg_291_1.actors_["104902ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_0 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 and not isNil(arg_291_1.actors_["104902ui_story"]) then
				if arg_291_1.var_.characterEffect104902ui_story and not isNil(arg_291_1.actors_["104902ui_story"]) then
					arg_291_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_291_1.var_.characterEffect104902ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_291_1.time_ - 0) / var_294_0)
				end
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 and not isNil(arg_291_1.actors_["104902ui_story"]) and arg_291_1.var_.characterEffect104902ui_story then
				arg_291_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_291_1.var_.characterEffect104902ui_story.fillRatio = 0.5
			end

			local var_294_1 = 0
			local var_294_2 = 0.9

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

				local var_294_3 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(414301019).content)

				arg_291_1.text_.text = var_294_3

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_5 = 36 <= 0 and var_294_2 or var_294_2 * (utf8.len(var_294_3) / 36)

				if (36 <= 0 and var_294_2 or var_294_2 * (utf8.len(var_294_3) / 36)) > 0 and var_294_2 < var_294_5 then
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
	assets = {
		"TextureConfig/Background/H07f",
		"TextureConfig/Background/ST0101"
	},
	voices = {}
}
