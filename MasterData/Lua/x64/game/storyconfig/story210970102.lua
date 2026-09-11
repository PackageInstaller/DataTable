return {
	Play1109702001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1109702001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1109702002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I09 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I09")
				var_4_0.name = "I09"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I09 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I09

				arg_1_1.bgs_.I09.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I09" then
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

			if 0.3 < arg_1_1.time_ and arg_1_1.time_ <= 0.3 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_2_story_corridor_dream", "bgm_activity_3_2_story_corridor_dream", "bgm_activity_3_2_story_corridor_dream.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_3_2_story_corridor_dream", "bgm_activity_3_2_story_corridor_dream")

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
			local var_4_15 = 0.075

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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1109702001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 3 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 3)

				if (3 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 3)) > 0 and var_4_15 < var_4_19 then
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
	Play1109702002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1109702002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1109702003(arg_9_1)
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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(1109702002).content)

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
	Play1109702003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1109702003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1109702004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.775

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(1109702003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 31 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 31)

				if (31 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 31)) > 0 and var_16_0 < var_16_3 then
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
	Play1109702004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1109702004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1109702005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.95

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

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(1109702004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 38 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 38)

				if (38 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 38)) > 0 and var_20_0 < var_20_3 then
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
	Play1109702005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1109702005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1109702006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 1.4

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

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(1109702005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 54 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 54)

				if (54 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 54)) > 0 and var_24_0 < var_24_3 then
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
	Play1109702006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1109702006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1109702007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.45

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

				local var_28_1 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(1109702006).content)

				arg_25_1.text_.text = var_28_1

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_3 = 18 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 18)

				if (18 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 18)) > 0 and var_28_0 < var_28_3 then
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
	Play1109702007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1109702007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1109702008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.775

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(1109702007).content)

				arg_29_1.text_.text = var_32_1

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_3 = 31 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 31)

				if (31 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 31)) > 0 and var_32_0 < var_32_3 then
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
	Play1109702008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1109702008
		arg_33_1.duration_ = 2.97

		local var_33_0 = {
			zh = 2.966,
			ja = 1.999999999999
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
				arg_33_0:Play1109702009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if arg_33_1.actors_["1197ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1197ui_story"))) then
				local var_36_0 = Object.Instantiate(Asset.Load("Char/" .. "1197ui_story"), arg_33_1.stage_.transform)

				var_36_0.name = "1197ui_story"
				var_36_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_["1197ui_story"] = var_36_0

				local var_36_1 = var_36_0:GetComponentInChildren(typeof(CharacterEffect))

				var_36_1.enabled = true

				local var_36_2 = GameObjectTools.GetOrAddComponent(var_36_0, typeof(DynamicBoneHelper))

				if var_36_2 then
					var_36_2:EnableDynamicBone(false)
				end

				arg_33_1:ShowWeapon(var_36_1.transform, false)

				arg_33_1.var_["1197ui_story" .. "Animator"] = var_36_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_33_1.var_["1197ui_story" .. "Animator"].applyRootMotion = true
				arg_33_1.var_["1197ui_story" .. "LipSync"] = var_36_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_36_3 = arg_33_1.actors_["1197ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1197ui_story = var_36_3.localPosition
			end

			local var_36_4 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				var_36_3.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_33_1.time_ - 0) / var_36_4)
				var_36_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_3.position).x, (manager.ui.mainCamera.transform.position - var_36_3.position).y, (manager.ui.mainCamera.transform.position - var_36_3.position).z)
				var_36_3.localEulerAngles.z = 0
				var_36_3.localEulerAngles.x = 0
				var_36_3.localEulerAngles = var_36_3.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				var_36_3.localPosition = Vector3.New(0, -0.545, -6.3)
				var_36_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_3.position).x, (manager.ui.mainCamera.transform.position - var_36_3.position).y, (manager.ui.mainCamera.transform.position - var_36_3.position).z)
				var_36_3.localEulerAngles.z = 0
				var_36_3.localEulerAngles.x = 0
				var_36_3.localEulerAngles = var_36_3.localEulerAngles
			end

			local var_36_5 = arg_33_1.actors_["1197ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.characterEffect1197ui_story == nil then
				arg_33_1.var_.characterEffect1197ui_story = var_36_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_6 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_6 and not isNil(var_36_5) then
				if arg_33_1.var_.characterEffect1197ui_story and not isNil(var_36_5) then
					arg_33_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_6 and arg_33_1.time_ < 0 + var_36_6 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.characterEffect1197ui_story then
				arg_33_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action7_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_36_8 = 0
			local var_36_9 = 0.55

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_10 = arg_33_1:GetWordFromCfg(1109702008)
				local var_36_11 = arg_33_1:FormatText(var_36_10.content)

				arg_33_1.text_.text = var_36_11

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_13 = 22 <= 0 and var_36_9 or var_36_9 * (utf8.len(var_36_11) / 22)

				if (22 <= 0 and var_36_9 or var_36_9 * (utf8.len(var_36_11) / 22)) > 0 and var_36_9 < var_36_13 then
					arg_33_1.talkMaxDuration = var_36_13

					if var_36_13 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_8
					end
				end

				arg_33_1.text_.text = var_36_11
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702008", "story_v_side_new_1109702.awb") ~= 0 then
					local var_36_14 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702008", "story_v_side_new_1109702.awb") / 1000

					if var_36_14 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_14 + var_36_8
					end

					if var_36_10.prefab_name ~= "" and arg_33_1.actors_[var_36_10.prefab_name] ~= nil then
						local var_36_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_10.prefab_name].transform, "story_v_side_new_1109702", "1109702008", "story_v_side_new_1109702.awb")

						arg_33_1:RecordAudio("1109702008", var_36_15)
						arg_33_1:RecordAudio("1109702008", var_36_15)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702008", "story_v_side_new_1109702.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702008", "story_v_side_new_1109702.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_16 = math.max(var_36_9, arg_33_1.talkMaxDuration)

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_16 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_8) / var_36_16

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_8 + var_36_16 and arg_33_1.time_ < var_36_8 + var_36_16 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
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
	Play1109702009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1109702009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1109702010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1197ui_story"]) and arg_37_1.var_.characterEffect1197ui_story == nil then
				arg_37_1.var_.characterEffect1197ui_story = arg_37_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1197ui_story"]) then
				if arg_37_1.var_.characterEffect1197ui_story and not isNil(arg_37_1.actors_["1197ui_story"]) then
					arg_37_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1197ui_story"]) and arg_37_1.var_.characterEffect1197ui_story then
				arg_37_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_40_1 = 0
			local var_40_2 = 0.45

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

				local var_40_3 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(1109702009).content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 18 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 18)

				if (18 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 18)) > 0 and var_40_2 < var_40_5 then
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
	Play1109702010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1109702010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1109702011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.55

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

				local var_44_1 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(1109702010).content)

				arg_41_1.text_.text = var_44_1

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_3 = 22 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 22)

				if (22 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 22)) > 0 and var_44_0 < var_44_3 then
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
	Play1109702011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1109702011
		arg_45_1.duration_ = 3.67

		local var_45_0 = {
			zh = 3.666,
			ja = 2.566
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
				arg_45_0:Play1109702012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1197ui_story = arg_45_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1197ui_story"].transform.position).z)
				arg_45_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1197ui_story"].transform.localEulerAngles = arg_45_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, -0.545, -6.3)
				arg_45_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1197ui_story"].transform.position).z)
				arg_45_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1197ui_story"].transform.localEulerAngles = arg_45_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["1197ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1197ui_story == nil then
				arg_45_1.var_.characterEffect1197ui_story = var_48_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 and not isNil(var_48_1) then
				if arg_45_1.var_.characterEffect1197ui_story and not isNil(var_48_1) then
					arg_45_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1197ui_story then
				arg_45_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action7_2")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_48_4 = 0
			local var_48_5 = 0.275

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_6 = arg_45_1:GetWordFromCfg(1109702011)
				local var_48_7 = arg_45_1:FormatText(var_48_6.content)

				arg_45_1.text_.text = var_48_7

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_9 = 11 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 11)

				if (11 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 11)) > 0 and var_48_5 < var_48_9 then
					arg_45_1.talkMaxDuration = var_48_9

					if var_48_9 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_4
					end
				end

				arg_45_1.text_.text = var_48_7
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702011", "story_v_side_new_1109702.awb") ~= 0 then
					local var_48_10 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702011", "story_v_side_new_1109702.awb") / 1000

					if var_48_10 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_4
					end

					if var_48_6.prefab_name ~= "" and arg_45_1.actors_[var_48_6.prefab_name] ~= nil then
						local var_48_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_6.prefab_name].transform, "story_v_side_new_1109702", "1109702011", "story_v_side_new_1109702.awb")

						arg_45_1:RecordAudio("1109702011", var_48_11)
						arg_45_1:RecordAudio("1109702011", var_48_11)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702011", "story_v_side_new_1109702.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702011", "story_v_side_new_1109702.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_12 = math.max(var_48_5, arg_45_1.talkMaxDuration)

			if var_48_4 <= arg_45_1.time_ and arg_45_1.time_ < var_48_4 + var_48_12 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_4) / var_48_12

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_4 + var_48_12 and arg_45_1.time_ < var_48_4 + var_48_12 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play1109702012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1109702012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1109702013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1197ui_story"]) and arg_49_1.var_.characterEffect1197ui_story == nil then
				arg_49_1.var_.characterEffect1197ui_story = arg_49_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1197ui_story"]) then
				if arg_49_1.var_.characterEffect1197ui_story and not isNil(arg_49_1.actors_["1197ui_story"]) then
					arg_49_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_0)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1197ui_story"]) and arg_49_1.var_.characterEffect1197ui_story then
				arg_49_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_52_1 = 0
			local var_52_2 = 0.05

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(1109702012).content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 2 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 2)

				if (2 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 2)) > 0 and var_52_2 < var_52_5 then
					arg_49_1.talkMaxDuration = var_52_5

					if var_52_5 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + var_52_1
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_6 = math.max(var_52_2, arg_49_1.talkMaxDuration)

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_6 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_1) / var_52_6

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_1 + var_52_6 and arg_49_1.time_ < var_52_1 + var_52_6 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play1109702013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1109702013
		arg_53_1.duration_ = 12.3

		local var_53_0 = {
			zh = 6.233,
			ja = 12.3
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
				arg_53_0:Play1109702014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1197ui_story"]) and arg_53_1.var_.characterEffect1197ui_story == nil then
				arg_53_1.var_.characterEffect1197ui_story = arg_53_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1197ui_story"]) then
				if arg_53_1.var_.characterEffect1197ui_story and not isNil(arg_53_1.actors_["1197ui_story"]) then
					arg_53_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1197ui_story"]) and arg_53_1.var_.characterEffect1197ui_story then
				arg_53_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_56_2 = 0
			local var_56_3 = 0.625

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_4 = arg_53_1:GetWordFromCfg(1109702013)
				local var_56_5 = arg_53_1:FormatText(var_56_4.content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_7 = 25 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 25)

				if (25 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 25)) > 0 and var_56_3 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_2
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702013", "story_v_side_new_1109702.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702013", "story_v_side_new_1109702.awb") / 1000

					if var_56_8 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_2
					end

					if var_56_4.prefab_name ~= "" and arg_53_1.actors_[var_56_4.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_4.prefab_name].transform, "story_v_side_new_1109702", "1109702013", "story_v_side_new_1109702.awb")

						arg_53_1:RecordAudio("1109702013", var_56_9)
						arg_53_1:RecordAudio("1109702013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702013", "story_v_side_new_1109702.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702013", "story_v_side_new_1109702.awb")
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
	Play1109702014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1109702014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play1109702015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1197ui_story"]) and arg_57_1.var_.characterEffect1197ui_story == nil then
				arg_57_1.var_.characterEffect1197ui_story = arg_57_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1197ui_story"]) then
				if arg_57_1.var_.characterEffect1197ui_story and not isNil(arg_57_1.actors_["1197ui_story"]) then
					arg_57_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_0)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1197ui_story"]) and arg_57_1.var_.characterEffect1197ui_story then
				arg_57_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_60_1 = 0
			local var_60_2 = 0.25

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_3 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(1109702014).content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 10 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 10)

				if (10 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 10)) > 0 and var_60_2 < var_60_5 then
					arg_57_1.talkMaxDuration = var_60_5

					if var_60_5 + var_60_1 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + var_60_1
					end
				end

				arg_57_1.text_.text = var_60_3
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_6 = math.max(var_60_2, arg_57_1.talkMaxDuration)

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_6 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_1) / var_60_6

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_1 + var_60_6 and arg_57_1.time_ < var_60_1 + var_60_6 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play1109702015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1109702015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play1109702016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.6

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(1109702015).content)

				arg_61_1.text_.text = var_64_1

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_3 = 24 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 24)

				if (24 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 24)) > 0 and var_64_0 < var_64_3 then
					arg_61_1.talkMaxDuration = var_64_3

					if var_64_3 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_3 + 0
					end
				end

				arg_61_1.text_.text = var_64_1
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_4 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_4

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play1109702016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1109702016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1109702017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.725

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

				local var_68_1 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(1109702016).content)

				arg_65_1.text_.text = var_68_1

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_3 = 29 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 29)

				if (29 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 29)) > 0 and var_68_0 < var_68_3 then
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
	Play1109702017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1109702017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play1109702018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.95

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

				local var_72_1 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(1109702017).content)

				arg_69_1.text_.text = var_72_1

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_3 = 38 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 38)

				if (38 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 38)) > 0 and var_72_0 < var_72_3 then
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
	Play1109702018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1109702018
		arg_73_1.duration_ = 2.73

		local var_73_0 = {
			zh = 2.633,
			ja = 2.733
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
				arg_73_0:Play1109702019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1197ui_story = arg_73_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1197ui_story"].transform.position).z)
				arg_73_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1197ui_story"].transform.localEulerAngles = arg_73_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, -0.545, -6.3)
				arg_73_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1197ui_story"].transform.position).z)
				arg_73_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1197ui_story"].transform.localEulerAngles = arg_73_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_76_1 = arg_73_1.actors_["1197ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1197ui_story == nil then
				arg_73_1.var_.characterEffect1197ui_story = var_76_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_2 and not isNil(var_76_1) then
				if arg_73_1.var_.characterEffect1197ui_story and not isNil(var_76_1) then
					arg_73_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_2 and arg_73_1.time_ < 0 + var_76_2 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1197ui_story then
				arg_73_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action7_1")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_76_4 = 0
			local var_76_5 = 0.2

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_6 = arg_73_1:GetWordFromCfg(1109702018)
				local var_76_7 = arg_73_1:FormatText(var_76_6.content)

				arg_73_1.text_.text = var_76_7

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_9 = 8 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 8)

				if (8 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 8)) > 0 and var_76_5 < var_76_9 then
					arg_73_1.talkMaxDuration = var_76_9

					if var_76_9 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_9 + var_76_4
					end
				end

				arg_73_1.text_.text = var_76_7
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702018", "story_v_side_new_1109702.awb") ~= 0 then
					local var_76_10 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702018", "story_v_side_new_1109702.awb") / 1000

					if var_76_10 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_4
					end

					if var_76_6.prefab_name ~= "" and arg_73_1.actors_[var_76_6.prefab_name] ~= nil then
						local var_76_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_6.prefab_name].transform, "story_v_side_new_1109702", "1109702018", "story_v_side_new_1109702.awb")

						arg_73_1:RecordAudio("1109702018", var_76_11)
						arg_73_1:RecordAudio("1109702018", var_76_11)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702018", "story_v_side_new_1109702.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702018", "story_v_side_new_1109702.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_12 = math.max(var_76_5, arg_73_1.talkMaxDuration)

			if var_76_4 <= arg_73_1.time_ and arg_73_1.time_ < var_76_4 + var_76_12 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_4) / var_76_12

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_4 + var_76_12 and arg_73_1.time_ < var_76_4 + var_76_12 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
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
	Play1109702019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1109702019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play1109702020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1197ui_story"]) and arg_77_1.var_.characterEffect1197ui_story == nil then
				arg_77_1.var_.characterEffect1197ui_story = arg_77_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1197ui_story"]) then
				if arg_77_1.var_.characterEffect1197ui_story and not isNil(arg_77_1.actors_["1197ui_story"]) then
					arg_77_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_0)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1197ui_story"]) and arg_77_1.var_.characterEffect1197ui_story then
				arg_77_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_80_1 = 0
			local var_80_2 = 0.1

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

				local var_80_3 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(1109702019).content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 4 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 4)

				if (4 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 4)) > 0 and var_80_2 < var_80_5 then
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
	Play1109702020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1109702020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play1109702021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.7

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

				local var_84_1 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(1109702020).content)

				arg_81_1.text_.text = var_84_1

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_3 = 28 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 28)

				if (28 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 28)) > 0 and var_84_0 < var_84_3 then
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
	Play1109702021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1109702021
		arg_85_1.duration_ = 6.23

		local var_85_0 = {
			zh = 6.233,
			ja = 5.766
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
				arg_85_0:Play1109702022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1197ui_story = arg_85_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1197ui_story"].transform.position).z)
				arg_85_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1197ui_story"].transform.localEulerAngles = arg_85_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, -0.545, -6.3)
				arg_85_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1197ui_story"].transform.position).z)
				arg_85_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1197ui_story"].transform.localEulerAngles = arg_85_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["1197ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1197ui_story == nil then
				arg_85_1.var_.characterEffect1197ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect1197ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1197ui_story then
				arg_85_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197actionlink/1197action479")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_88_4 = 0
			local var_88_5 = 0.75

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

				local var_88_6 = arg_85_1:GetWordFromCfg(1109702021)
				local var_88_7 = arg_85_1:FormatText(var_88_6.content)

				arg_85_1.text_.text = var_88_7

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_9 = 30 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 30)

				if (30 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 30)) > 0 and var_88_5 < var_88_9 then
					arg_85_1.talkMaxDuration = var_88_9

					if var_88_9 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_7
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702021", "story_v_side_new_1109702.awb") ~= 0 then
					local var_88_10 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702021", "story_v_side_new_1109702.awb") / 1000

					if var_88_10 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_4
					end

					if var_88_6.prefab_name ~= "" and arg_85_1.actors_[var_88_6.prefab_name] ~= nil then
						local var_88_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_6.prefab_name].transform, "story_v_side_new_1109702", "1109702021", "story_v_side_new_1109702.awb")

						arg_85_1:RecordAudio("1109702021", var_88_11)
						arg_85_1:RecordAudio("1109702021", var_88_11)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702021", "story_v_side_new_1109702.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702021", "story_v_side_new_1109702.awb")
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

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
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
	Play1109702022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1109702022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play1109702023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1197ui_story"]) and arg_89_1.var_.characterEffect1197ui_story == nil then
				arg_89_1.var_.characterEffect1197ui_story = arg_89_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1197ui_story"]) then
				if arg_89_1.var_.characterEffect1197ui_story and not isNil(arg_89_1.actors_["1197ui_story"]) then
					arg_89_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_0)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1197ui_story"]) and arg_89_1.var_.characterEffect1197ui_story then
				arg_89_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_92_1 = 0
			local var_92_2 = 0.825

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
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

				local var_92_3 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(1109702022).content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 33 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 33)

				if (33 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 33)) > 0 and var_92_2 < var_92_5 then
					arg_89_1.talkMaxDuration = var_92_5

					if var_92_5 + var_92_1 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + var_92_1
					end
				end

				arg_89_1.text_.text = var_92_3
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_6 = math.max(var_92_2, arg_89_1.talkMaxDuration)

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_6 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_1) / var_92_6

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_1 + var_92_6 and arg_89_1.time_ < var_92_1 + var_92_6 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play1109702023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1109702023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play1109702024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.875

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
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

				local var_96_1 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(1109702023).content)

				arg_93_1.text_.text = var_96_1

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_3 = 35 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 35)

				if (35 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 35)) > 0 and var_96_0 < var_96_3 then
					arg_93_1.talkMaxDuration = var_96_3

					if var_96_3 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_3 + 0
					end
				end

				arg_93_1.text_.text = var_96_1
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_4 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_4

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play1109702024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1109702024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play1109702025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.525

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

				local var_100_1 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(1109702024).content)

				arg_97_1.text_.text = var_100_1

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_3 = 21 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 21)

				if (21 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 21)) > 0 and var_100_0 < var_100_3 then
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
	Play1109702025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1109702025
		arg_101_1.duration_ = 6.8

		local var_101_0 = {
			zh = 6.8,
			ja = 3.133
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
				arg_101_0:Play1109702026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1197ui_story = arg_101_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1197ui_story"].transform.position).z)
				arg_101_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1197ui_story"].transform.localEulerAngles = arg_101_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, -0.545, -6.3)
				arg_101_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1197ui_story"].transform.position).z)
				arg_101_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1197ui_story"].transform.localEulerAngles = arg_101_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["1197ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1197ui_story == nil then
				arg_101_1.var_.characterEffect1197ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect1197ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1197ui_story then
				arg_101_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197actionlink/1197action497")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_104_4 = 0
			local var_104_5 = 0.475

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_6 = arg_101_1:GetWordFromCfg(1109702025)
				local var_104_7 = arg_101_1:FormatText(var_104_6.content)

				arg_101_1.text_.text = var_104_7

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_9 = 19 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 19)

				if (19 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 19)) > 0 and var_104_5 < var_104_9 then
					arg_101_1.talkMaxDuration = var_104_9

					if var_104_9 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_9 + var_104_4
					end
				end

				arg_101_1.text_.text = var_104_7
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702025", "story_v_side_new_1109702.awb") ~= 0 then
					local var_104_10 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702025", "story_v_side_new_1109702.awb") / 1000

					if var_104_10 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_10 + var_104_4
					end

					if var_104_6.prefab_name ~= "" and arg_101_1.actors_[var_104_6.prefab_name] ~= nil then
						local var_104_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_6.prefab_name].transform, "story_v_side_new_1109702", "1109702025", "story_v_side_new_1109702.awb")

						arg_101_1:RecordAudio("1109702025", var_104_11)
						arg_101_1:RecordAudio("1109702025", var_104_11)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702025", "story_v_side_new_1109702.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702025", "story_v_side_new_1109702.awb")
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
				actorName = "1197ui_story",
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
	Play1109702026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1109702026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play1109702027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1197ui_story"]) and arg_105_1.var_.characterEffect1197ui_story == nil then
				arg_105_1.var_.characterEffect1197ui_story = arg_105_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1197ui_story"]) then
				if arg_105_1.var_.characterEffect1197ui_story and not isNil(arg_105_1.actors_["1197ui_story"]) then
					arg_105_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_0)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1197ui_story"]) and arg_105_1.var_.characterEffect1197ui_story then
				arg_105_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_108_1 = 0
			local var_108_2 = 0.65

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_3 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(1109702026).content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 26 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 26)

				if (26 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 26)) > 0 and var_108_2 < var_108_5 then
					arg_105_1.talkMaxDuration = var_108_5

					if var_108_5 + var_108_1 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + var_108_1
					end
				end

				arg_105_1.text_.text = var_108_3
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_6 = math.max(var_108_2, arg_105_1.talkMaxDuration)

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_6 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_1) / var_108_6

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_1 + var_108_6 and arg_105_1.time_ < var_108_1 + var_108_6 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play1109702027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1109702027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play1109702028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.35

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
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

				local var_112_1 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(1109702027).content)

				arg_109_1.text_.text = var_112_1

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_3 = 14 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 14)

				if (14 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 14)) > 0 and var_112_0 < var_112_3 then
					arg_109_1.talkMaxDuration = var_112_3

					if var_112_3 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_3 + 0
					end
				end

				arg_109_1.text_.text = var_112_1
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_4 = math.max(var_112_0, arg_109_1.talkMaxDuration)

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_4 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - 0) / var_112_4

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= 0 + var_112_4 and arg_109_1.time_ < 0 + var_112_4 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play1109702028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1109702028
		arg_113_1.duration_ = 8.77

		local var_113_0 = {
			zh = 3.866,
			ja = 8.766
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
				arg_113_0:Play1109702029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1197ui_story = arg_113_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1197ui_story"].transform.position).z)
				arg_113_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1197ui_story"].transform.localEulerAngles = arg_113_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, -0.545, -6.3)
				arg_113_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1197ui_story"].transform.position).z)
				arg_113_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1197ui_story"].transform.localEulerAngles = arg_113_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_116_1 = arg_113_1.actors_["1197ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1197ui_story == nil then
				arg_113_1.var_.characterEffect1197ui_story = var_116_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 and not isNil(var_116_1) then
				if arg_113_1.var_.characterEffect1197ui_story and not isNil(var_116_1) then
					arg_113_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1197ui_story then
				arg_113_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action7_2")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_116_4 = 0
			local var_116_5 = 0.525

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_6 = arg_113_1:GetWordFromCfg(1109702028)
				local var_116_7 = arg_113_1:FormatText(var_116_6.content)

				arg_113_1.text_.text = var_116_7

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_9 = 21 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 21)

				if (21 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 21)) > 0 and var_116_5 < var_116_9 then
					arg_113_1.talkMaxDuration = var_116_9

					if var_116_9 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_9 + var_116_4
					end
				end

				arg_113_1.text_.text = var_116_7
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702028", "story_v_side_new_1109702.awb") ~= 0 then
					local var_116_10 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702028", "story_v_side_new_1109702.awb") / 1000

					if var_116_10 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_4
					end

					if var_116_6.prefab_name ~= "" and arg_113_1.actors_[var_116_6.prefab_name] ~= nil then
						local var_116_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_6.prefab_name].transform, "story_v_side_new_1109702", "1109702028", "story_v_side_new_1109702.awb")

						arg_113_1:RecordAudio("1109702028", var_116_11)
						arg_113_1:RecordAudio("1109702028", var_116_11)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702028", "story_v_side_new_1109702.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702028", "story_v_side_new_1109702.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_12 = math.max(var_116_5, arg_113_1.talkMaxDuration)

			if var_116_4 <= arg_113_1.time_ and arg_113_1.time_ < var_116_4 + var_116_12 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_4) / var_116_12

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_4 + var_116_12 and arg_113_1.time_ < var_116_4 + var_116_12 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play1109702029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 1109702029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play1109702030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["1197ui_story"]) and arg_117_1.var_.characterEffect1197ui_story == nil then
				arg_117_1.var_.characterEffect1197ui_story = arg_117_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["1197ui_story"]) then
				if arg_117_1.var_.characterEffect1197ui_story and not isNil(arg_117_1.actors_["1197ui_story"]) then
					arg_117_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_0)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["1197ui_story"]) and arg_117_1.var_.characterEffect1197ui_story then
				arg_117_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_120_1 = 0
			local var_120_2 = 0.6

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

				local var_120_3 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(1109702029).content)

				arg_117_1.text_.text = var_120_3

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 24 <= 0 and var_120_2 or var_120_2 * (utf8.len(var_120_3) / 24)

				if (24 <= 0 and var_120_2 or var_120_2 * (utf8.len(var_120_3) / 24)) > 0 and var_120_2 < var_120_5 then
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
	Play1109702030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 1109702030
		arg_121_1.duration_ = 8.37

		local var_121_0 = {
			zh = 5.366,
			ja = 8.366
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play1109702031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["1197ui_story"]) and arg_121_1.var_.characterEffect1197ui_story == nil then
				arg_121_1.var_.characterEffect1197ui_story = arg_121_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["1197ui_story"]) then
				if arg_121_1.var_.characterEffect1197ui_story and not isNil(arg_121_1.actors_["1197ui_story"]) then
					arg_121_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["1197ui_story"]) and arg_121_1.var_.characterEffect1197ui_story then
				arg_121_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action1_1")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_124_2 = 0
			local var_124_3 = 0.8

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_2 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_4 = arg_121_1:GetWordFromCfg(1109702030)
				local var_124_5 = arg_121_1:FormatText(var_124_4.content)

				arg_121_1.text_.text = var_124_5

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_7 = 32 <= 0 and var_124_3 or var_124_3 * (utf8.len(var_124_5) / 32)

				if (32 <= 0 and var_124_3 or var_124_3 * (utf8.len(var_124_5) / 32)) > 0 and var_124_3 < var_124_7 then
					arg_121_1.talkMaxDuration = var_124_7

					if var_124_7 + var_124_2 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_7 + var_124_2
					end
				end

				arg_121_1.text_.text = var_124_5
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702030", "story_v_side_new_1109702.awb") ~= 0 then
					local var_124_8 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702030", "story_v_side_new_1109702.awb") / 1000

					if var_124_8 + var_124_2 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_8 + var_124_2
					end

					if var_124_4.prefab_name ~= "" and arg_121_1.actors_[var_124_4.prefab_name] ~= nil then
						local var_124_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_4.prefab_name].transform, "story_v_side_new_1109702", "1109702030", "story_v_side_new_1109702.awb")

						arg_121_1:RecordAudio("1109702030", var_124_9)
						arg_121_1:RecordAudio("1109702030", var_124_9)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702030", "story_v_side_new_1109702.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702030", "story_v_side_new_1109702.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_10 = math.max(var_124_3, arg_121_1.talkMaxDuration)

			if var_124_2 <= arg_121_1.time_ and arg_121_1.time_ < var_124_2 + var_124_10 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_2) / var_124_10

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_2 + var_124_10 and arg_121_1.time_ < var_124_2 + var_124_10 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play1109702031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 1109702031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play1109702032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["1197ui_story"]) and arg_125_1.var_.characterEffect1197ui_story == nil then
				arg_125_1.var_.characterEffect1197ui_story = arg_125_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["1197ui_story"]) then
				if arg_125_1.var_.characterEffect1197ui_story and not isNil(arg_125_1.actors_["1197ui_story"]) then
					arg_125_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_0)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["1197ui_story"]) and arg_125_1.var_.characterEffect1197ui_story then
				arg_125_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_128_1 = 0
			local var_128_2 = 0.6

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

				local var_128_3 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(1109702031).content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 24 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 24)

				if (24 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 24)) > 0 and var_128_2 < var_128_5 then
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

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play1109702032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 1109702032
		arg_129_1.duration_ = 13.1

		local var_129_0 = {
			zh = 10.733,
			ja = 13.1
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
				arg_129_0:Play1109702033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1197ui_story = arg_129_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_132_0 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				arg_129_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_129_1.time_ - 0) / var_132_0)
				arg_129_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1197ui_story"].transform.position).z)
				arg_129_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1197ui_story"].transform.localEulerAngles = arg_129_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				arg_129_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, -0.545, -6.3)
				arg_129_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1197ui_story"].transform.position).z)
				arg_129_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1197ui_story"].transform.localEulerAngles = arg_129_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_132_1 = arg_129_1.actors_["1197ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1197ui_story == nil then
				arg_129_1.var_.characterEffect1197ui_story = var_132_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_2 and not isNil(var_132_1) then
				if arg_129_1.var_.characterEffect1197ui_story and not isNil(var_132_1) then
					arg_129_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_2 and arg_129_1.time_ < 0 + var_132_2 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1197ui_story then
				arg_129_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action9_1")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_132_4 = 0
			local var_132_5 = 0.925

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_6 = arg_129_1:GetWordFromCfg(1109702032)
				local var_132_7 = arg_129_1:FormatText(var_132_6.content)

				arg_129_1.text_.text = var_132_7

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_9 = 37 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 37)

				if (37 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 37)) > 0 and var_132_5 < var_132_9 then
					arg_129_1.talkMaxDuration = var_132_9

					if var_132_9 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_4
					end
				end

				arg_129_1.text_.text = var_132_7
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702032", "story_v_side_new_1109702.awb") ~= 0 then
					local var_132_10 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702032", "story_v_side_new_1109702.awb") / 1000

					if var_132_10 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_4
					end

					if var_132_6.prefab_name ~= "" and arg_129_1.actors_[var_132_6.prefab_name] ~= nil then
						local var_132_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_6.prefab_name].transform, "story_v_side_new_1109702", "1109702032", "story_v_side_new_1109702.awb")

						arg_129_1:RecordAudio("1109702032", var_132_11)
						arg_129_1:RecordAudio("1109702032", var_132_11)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702032", "story_v_side_new_1109702.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702032", "story_v_side_new_1109702.awb")
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

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play1109702033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 1109702033
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play1109702034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1197ui_story = arg_133_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_136_0 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 then
				arg_133_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1197ui_story, Vector3.New(0, 100, 0), (arg_133_1.time_ - 0) / var_136_0)
				arg_133_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1197ui_story"].transform.position).z)
				arg_133_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1197ui_story"].transform.localEulerAngles = arg_133_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 then
				arg_133_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_133_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1197ui_story"].transform.position).z)
				arg_133_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1197ui_story"].transform.localEulerAngles = arg_133_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_136_1 = arg_133_1.actors_["1197ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1197ui_story == nil then
				arg_133_1.var_.characterEffect1197ui_story = var_136_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 and not isNil(var_136_1) then
				if arg_133_1.var_.characterEffect1197ui_story and not isNil(var_136_1) then
					arg_133_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_2)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1197ui_story then
				arg_133_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_136_3 = 0
			local var_136_4 = 1.2

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_3 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_5 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(1109702033).content)

				arg_133_1.text_.text = var_136_5

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_7 = 48 <= 0 and var_136_4 or var_136_4 * (utf8.len(var_136_5) / 48)

				if (48 <= 0 and var_136_4 or var_136_4 * (utf8.len(var_136_5) / 48)) > 0 and var_136_4 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_3 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_3
					end
				end

				arg_133_1.text_.text = var_136_5
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_8 = math.max(var_136_4, arg_133_1.talkMaxDuration)

			if var_136_3 <= arg_133_1.time_ and arg_133_1.time_ < var_136_3 + var_136_8 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_3) / var_136_8

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_3 + var_136_8 and arg_133_1.time_ < var_136_3 + var_136_8 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play1109702034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 1109702034
		arg_137_1.duration_ = 9

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play1109702035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 2 < arg_137_1.time_ and arg_137_1.time_ <= 2 + arg_140_0 then
				local var_140_0 = arg_137_1.bgs_.I09

				arg_137_1.bgs_.I09.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_140_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_140_1 = var_140_0:GetComponent("SpriteRenderer")

				if var_140_1 and var_140_1.sprite then
					local var_140_2 = 2 * (var_140_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_140_0.transform.localScale = Vector3.New(var_140_2 / var_140_1.sprite.bounds.size.y < var_140_2 * manager.ui.mainCameraCom_.aspect / var_140_1.sprite.bounds.size.x and var_140_2 * manager.ui.mainCameraCom_.aspect / var_140_1.sprite.bounds.size.x or var_140_2 / var_140_1.sprite.bounds.size.y, var_140_2 / var_140_1.sprite.bounds.size.y < var_140_2 * manager.ui.mainCameraCom_.aspect / var_140_1.sprite.bounds.size.x and var_140_2 * manager.ui.mainCameraCom_.aspect / var_140_1.sprite.bounds.size.x or var_140_2 / var_140_1.sprite.bounds.size.y, 0)
				end

				for iter_140_0, iter_140_1 in pairs(arg_137_1.bgs_) do
					if iter_140_0 ~= "I09" then
						iter_140_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_140_3 = 3.999999999999

			if 3.999999999999 < arg_137_1.time_ and arg_137_1.time_ <= var_140_3 + arg_140_0 then
				arg_137_1.allBtn_.enabled = false
			end

			if arg_137_1.time_ >= var_140_3 + 0.3 and arg_137_1.time_ < var_140_3 + 0.3 + arg_140_0 then
				arg_137_1.allBtn_.enabled = true
			end

			local var_140_4 = 0

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1.mask_.enabled = true
				arg_137_1.mask_.raycastTarget = true

				arg_137_1:SetGaussion(false)
			end

			local var_140_5 = 2

			if var_140_4 <= arg_137_1.time_ and arg_137_1.time_ < var_140_4 + var_140_5 then
				local var_140_6 = Color.New(1, 1, 1)

				var_140_6.a = Mathf.Lerp(0, 1, (arg_137_1.time_ - var_140_4) / var_140_5)
				arg_137_1.mask_.color = var_140_6
			end

			if arg_137_1.time_ >= var_140_4 + var_140_5 and arg_137_1.time_ < var_140_4 + var_140_5 + arg_140_0 then
				local var_140_7 = Color.New(1, 1, 1)

				var_140_7.a = 1
				arg_137_1.mask_.color = var_140_7
			end

			local var_140_8 = 2

			if 2 < arg_137_1.time_ and arg_137_1.time_ <= var_140_8 + arg_140_0 then
				arg_137_1.mask_.enabled = true
				arg_137_1.mask_.raycastTarget = true

				arg_137_1:SetGaussion(false)
			end

			local var_140_9 = 2

			if var_140_8 <= arg_137_1.time_ and arg_137_1.time_ < var_140_8 + var_140_9 then
				local var_140_10 = Color.New(1, 1, 1)

				var_140_10.a = Mathf.Lerp(1, 0, (arg_137_1.time_ - var_140_8) / var_140_9)
				arg_137_1.mask_.color = var_140_10
			end

			if arg_137_1.time_ >= var_140_8 + var_140_9 and arg_137_1.time_ < var_140_8 + var_140_9 + arg_140_0 then
				local var_140_11 = Color.New(1, 1, 1)

				arg_137_1.mask_.enabled = false
				var_140_11.a = 0
				arg_137_1.mask_.color = var_140_11
			end

			if arg_137_1.frameCnt_ <= 1 then
				arg_137_1.dialog_:SetActive(false)
			end

			local var_140_12 = 4
			local var_140_13 = 0.55

			if 4 < arg_137_1.time_ and arg_137_1.time_ <= var_140_12 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0

				arg_137_1.dialog_:SetActive(true)

				arg_137_1.dialogCg_.alpha = 0

				local var_140_14 = LeanTween.value(arg_137_1.dialog_, 0, 1, 0.3)

				var_140_14:setOnUpdate(LuaHelper.FloatAction(function(arg_141_0)
					arg_137_1.dialogCg_.alpha = arg_141_0
				end))
				var_140_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_137_1.dialog_)
					var_140_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_137_1.duration_ = arg_137_1.duration_ + 0.3

				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_15 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(1109702034).content)

				arg_137_1.text_.text = var_140_15

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_17 = 22 <= 0 and var_140_13 or var_140_13 * (utf8.len(var_140_15) / 22)

				if (22 <= 0 and var_140_13 or var_140_13 * (utf8.len(var_140_15) / 22)) > 0 and var_140_13 < var_140_17 then
					arg_137_1.talkMaxDuration = var_140_17
					var_140_12 = var_140_12 + 0.3

					if var_140_17 + var_140_12 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_17 + var_140_12
					end
				end

				arg_137_1.text_.text = var_140_15
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_18 = var_140_12 + 0.3
			local var_140_19 = math.max(var_140_13, arg_137_1.talkMaxDuration)

			if var_140_12 + 0.3 <= arg_137_1.time_ and arg_137_1.time_ < var_140_18 + var_140_19 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_18) / var_140_19

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_18 + var_140_19 and arg_137_1.time_ < var_140_18 + var_140_19 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play1109702035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 1109702035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play1109702036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0.425

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

				local var_146_1 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(1109702035).content)

				arg_143_1.text_.text = var_146_1

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_3 = 17 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 17)

				if (17 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 17)) > 0 and var_146_0 < var_146_3 then
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
	Play1109702036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 1109702036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play1109702037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 1.425

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_1 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(1109702036).content)

				arg_147_1.text_.text = var_150_1

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_3 = 57 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 57)

				if (57 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 57)) > 0 and var_150_0 < var_150_3 then
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
	Play1109702037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 1109702037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play1109702038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.45

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
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

				local var_154_1 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(1109702037).content)

				arg_151_1.text_.text = var_154_1

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_3 = 18 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 18)

				if (18 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 18)) > 0 and var_154_0 < var_154_3 then
					arg_151_1.talkMaxDuration = var_154_3

					if var_154_3 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_3 + 0
					end
				end

				arg_151_1.text_.text = var_154_1
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_4 = math.max(var_154_0, arg_151_1.talkMaxDuration)

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_4 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - 0) / var_154_4

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= 0 + var_154_4 and arg_151_1.time_ < 0 + var_154_4 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play1109702038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 1109702038
		arg_155_1.duration_ = 2

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play1109702039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos1197ui_story = arg_155_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_158_0 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 then
				arg_155_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_155_1.time_ - 0) / var_158_0)
				arg_155_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1197ui_story"].transform.position).z)
				arg_155_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["1197ui_story"].transform.localEulerAngles = arg_155_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 then
				arg_155_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, -0.545, -6.3)
				arg_155_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1197ui_story"].transform.position).z)
				arg_155_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["1197ui_story"].transform.localEulerAngles = arg_155_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_158_1 = arg_155_1.actors_["1197ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect1197ui_story == nil then
				arg_155_1.var_.characterEffect1197ui_story = var_158_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_2 and not isNil(var_158_1) then
				if arg_155_1.var_.characterEffect1197ui_story and not isNil(var_158_1) then
					arg_155_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_2 and arg_155_1.time_ < 0 + var_158_2 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect1197ui_story then
				arg_155_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action5_1")
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_158_4 = 0
			local var_158_5 = 0.15

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_4 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_6 = arg_155_1:GetWordFromCfg(1109702038)
				local var_158_7 = arg_155_1:FormatText(var_158_6.content)

				arg_155_1.text_.text = var_158_7

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_9 = 6 <= 0 and var_158_5 or var_158_5 * (utf8.len(var_158_7) / 6)

				if (6 <= 0 and var_158_5 or var_158_5 * (utf8.len(var_158_7) / 6)) > 0 and var_158_5 < var_158_9 then
					arg_155_1.talkMaxDuration = var_158_9

					if var_158_9 + var_158_4 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_9 + var_158_4
					end
				end

				arg_155_1.text_.text = var_158_7
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702038", "story_v_side_new_1109702.awb") ~= 0 then
					local var_158_10 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702038", "story_v_side_new_1109702.awb") / 1000

					if var_158_10 + var_158_4 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_10 + var_158_4
					end

					if var_158_6.prefab_name ~= "" and arg_155_1.actors_[var_158_6.prefab_name] ~= nil then
						local var_158_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_6.prefab_name].transform, "story_v_side_new_1109702", "1109702038", "story_v_side_new_1109702.awb")

						arg_155_1:RecordAudio("1109702038", var_158_11)
						arg_155_1:RecordAudio("1109702038", var_158_11)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702038", "story_v_side_new_1109702.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702038", "story_v_side_new_1109702.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_12 = math.max(var_158_5, arg_155_1.talkMaxDuration)

			if var_158_4 <= arg_155_1.time_ and arg_155_1.time_ < var_158_4 + var_158_12 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_4) / var_158_12

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_4 + var_158_12 and arg_155_1.time_ < var_158_4 + var_158_12 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
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
	Play1109702039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 1109702039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play1109702040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["1197ui_story"]) and arg_159_1.var_.characterEffect1197ui_story == nil then
				arg_159_1.var_.characterEffect1197ui_story = arg_159_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_0 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["1197ui_story"]) then
				if arg_159_1.var_.characterEffect1197ui_story and not isNil(arg_159_1.actors_["1197ui_story"]) then
					arg_159_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_159_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_0)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["1197ui_story"]) and arg_159_1.var_.characterEffect1197ui_story then
				arg_159_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_159_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_162_1 = 0
			local var_162_2 = 0.15

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_3 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(1109702039).content)

				arg_159_1.text_.text = var_162_3

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 6 <= 0 and var_162_2 or var_162_2 * (utf8.len(var_162_3) / 6)

				if (6 <= 0 and var_162_2 or var_162_2 * (utf8.len(var_162_3) / 6)) > 0 and var_162_2 < var_162_5 then
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

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play1109702040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 1109702040
		arg_163_1.duration_ = 3.2

		local var_163_0 = {
			zh = 2.8,
			ja = 3.2
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
				arg_163_0:Play1109702041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["1197ui_story"]) and arg_163_1.var_.characterEffect1197ui_story == nil then
				arg_163_1.var_.characterEffect1197ui_story = arg_163_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_0 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["1197ui_story"]) then
				if arg_163_1.var_.characterEffect1197ui_story and not isNil(arg_163_1.actors_["1197ui_story"]) then
					arg_163_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["1197ui_story"]) and arg_163_1.var_.characterEffect1197ui_story then
				arg_163_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action5_2")
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_166_2 = 0
			local var_166_3 = 0.45

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_2 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_4 = arg_163_1:GetWordFromCfg(1109702040)
				local var_166_5 = arg_163_1:FormatText(var_166_4.content)

				arg_163_1.text_.text = var_166_5

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_7 = 18 <= 0 and var_166_3 or var_166_3 * (utf8.len(var_166_5) / 18)

				if (18 <= 0 and var_166_3 or var_166_3 * (utf8.len(var_166_5) / 18)) > 0 and var_166_3 < var_166_7 then
					arg_163_1.talkMaxDuration = var_166_7

					if var_166_7 + var_166_2 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_7 + var_166_2
					end
				end

				arg_163_1.text_.text = var_166_5
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702040", "story_v_side_new_1109702.awb") ~= 0 then
					local var_166_8 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702040", "story_v_side_new_1109702.awb") / 1000

					if var_166_8 + var_166_2 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_8 + var_166_2
					end

					if var_166_4.prefab_name ~= "" and arg_163_1.actors_[var_166_4.prefab_name] ~= nil then
						local var_166_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_4.prefab_name].transform, "story_v_side_new_1109702", "1109702040", "story_v_side_new_1109702.awb")

						arg_163_1:RecordAudio("1109702040", var_166_9)
						arg_163_1:RecordAudio("1109702040", var_166_9)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702040", "story_v_side_new_1109702.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702040", "story_v_side_new_1109702.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_10 = math.max(var_166_3, arg_163_1.talkMaxDuration)

			if var_166_2 <= arg_163_1.time_ and arg_163_1.time_ < var_166_2 + var_166_10 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_2) / var_166_10

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_2 + var_166_10 and arg_163_1.time_ < var_166_2 + var_166_10 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play1109702041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 1109702041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play1109702042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["1197ui_story"]) and arg_167_1.var_.characterEffect1197ui_story == nil then
				arg_167_1.var_.characterEffect1197ui_story = arg_167_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_0 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["1197ui_story"]) then
				if arg_167_1.var_.characterEffect1197ui_story and not isNil(arg_167_1.actors_["1197ui_story"]) then
					arg_167_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_0)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["1197ui_story"]) and arg_167_1.var_.characterEffect1197ui_story then
				arg_167_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_170_1 = 0
			local var_170_2 = 0.75

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_3 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(1109702041).content)

				arg_167_1.text_.text = var_170_3

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 30 <= 0 and var_170_2 or var_170_2 * (utf8.len(var_170_3) / 30)

				if (30 <= 0 and var_170_2 or var_170_2 * (utf8.len(var_170_3) / 30)) > 0 and var_170_2 < var_170_5 then
					arg_167_1.talkMaxDuration = var_170_5

					if var_170_5 + var_170_1 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + var_170_1
					end
				end

				arg_167_1.text_.text = var_170_3
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_6 = math.max(var_170_2, arg_167_1.talkMaxDuration)

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_6 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_1) / var_170_6

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_1 + var_170_6 and arg_167_1.time_ < var_170_1 + var_170_6 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play1109702042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 1109702042
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play1109702043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1197ui_story = arg_171_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_174_0 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 then
				arg_171_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1197ui_story, Vector3.New(0, 100, 0), (arg_171_1.time_ - 0) / var_174_0)
				arg_171_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1197ui_story"].transform.position).z)
				arg_171_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1197ui_story"].transform.localEulerAngles = arg_171_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 then
				arg_171_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_171_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1197ui_story"].transform.position).z)
				arg_171_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1197ui_story"].transform.localEulerAngles = arg_171_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_174_1 = manager.ui.mainCamera.transform

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.shakeOldPos = var_174_1.localPosition
			end

			local var_174_2 = 0.6

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_2 then
				local var_174_3, var_174_4 = math.modf((arg_171_1.time_ - 0) / 0.066)

				var_174_1.localPosition = Vector3.New(var_174_4 * 0.13, var_174_4 * 0.13, var_174_4 * 0.13) + arg_171_1.var_.shakeOldPos
			end

			if arg_171_1.time_ >= 0 + var_174_2 and arg_171_1.time_ < 0 + var_174_2 + arg_174_0 then
				var_174_1.localPosition = arg_171_1.var_.shakeOldPos
			end

			local var_174_5 = 0

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_5 + arg_174_0 then
				arg_171_1.allBtn_.enabled = false
			end

			if arg_171_1.time_ >= var_174_5 + 0.6 and arg_171_1.time_ < var_174_5 + 0.6 + arg_174_0 then
				arg_171_1.allBtn_.enabled = true
			end

			local var_174_6 = 0
			local var_174_7 = 1

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_6 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_8 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(1109702042).content)

				arg_171_1.text_.text = var_174_8

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_10 = 40 <= 0 and var_174_7 or var_174_7 * (utf8.len(var_174_8) / 40)

				if (40 <= 0 and var_174_7 or var_174_7 * (utf8.len(var_174_8) / 40)) > 0 and var_174_7 < var_174_10 then
					arg_171_1.talkMaxDuration = var_174_10

					if var_174_10 + var_174_6 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_10 + var_174_6
					end
				end

				arg_171_1.text_.text = var_174_8
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_11 = math.max(var_174_7, arg_171_1.talkMaxDuration)

			if var_174_6 <= arg_171_1.time_ and arg_171_1.time_ < var_174_6 + var_174_11 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_6) / var_174_11

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_6 + var_174_11 and arg_171_1.time_ < var_174_6 + var_174_11 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play1109702043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 1109702043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play1109702044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.4

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

				local var_178_1 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(1109702043).content)

				arg_175_1.text_.text = var_178_1

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_3 = 16 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 16)

				if (16 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 16)) > 0 and var_178_0 < var_178_3 then
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
	Play1109702044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 1109702044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play1109702045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 1.575

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_1 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(1109702044).content)

				arg_179_1.text_.text = var_182_1

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_3 = 63 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 63)

				if (63 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 63)) > 0 and var_182_0 < var_182_3 then
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
	Play1109702045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 1109702045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play1109702046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0.325

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_1 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(1109702045).content)

				arg_183_1.text_.text = var_186_1

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_3 = 13 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 13)

				if (13 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 13)) > 0 and var_186_0 < var_186_3 then
					arg_183_1.talkMaxDuration = var_186_3

					if var_186_3 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_3 + 0
					end
				end

				arg_183_1.text_.text = var_186_1
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_4 = math.max(var_186_0, arg_183_1.talkMaxDuration)

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_4 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - 0) / var_186_4

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= 0 + var_186_4 and arg_183_1.time_ < 0 + var_186_4 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play1109702046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1109702046
		arg_187_1.duration_ = 4.67

		local var_187_0 = {
			zh = 3.6,
			ja = 4.666
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
				arg_187_0:Play1109702047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["1197ui_story"]) and arg_187_1.var_.characterEffect1197ui_story == nil then
				arg_187_1.var_.characterEffect1197ui_story = arg_187_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_0 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["1197ui_story"]) then
				if arg_187_1.var_.characterEffect1197ui_story and not isNil(arg_187_1.actors_["1197ui_story"]) then
					arg_187_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["1197ui_story"]) and arg_187_1.var_.characterEffect1197ui_story then
				arg_187_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action1_1")
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_190_2 = arg_187_1.actors_["1197ui_story"].transform

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos1197ui_story = var_190_2.localPosition
			end

			local var_190_3 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_3 then
				var_190_2.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_187_1.time_ - 0) / var_190_3)
				var_190_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_190_2.position).x, (manager.ui.mainCamera.transform.position - var_190_2.position).y, (manager.ui.mainCamera.transform.position - var_190_2.position).z)
				var_190_2.localEulerAngles.z = 0
				var_190_2.localEulerAngles.x = 0
				var_190_2.localEulerAngles = var_190_2.localEulerAngles
			end

			if arg_187_1.time_ >= 0 + var_190_3 and arg_187_1.time_ < 0 + var_190_3 + arg_190_0 then
				var_190_2.localPosition = Vector3.New(0, -0.545, -6.3)
				var_190_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_190_2.position).x, (manager.ui.mainCamera.transform.position - var_190_2.position).y, (manager.ui.mainCamera.transform.position - var_190_2.position).z)
				var_190_2.localEulerAngles.z = 0
				var_190_2.localEulerAngles.x = 0
				var_190_2.localEulerAngles = var_190_2.localEulerAngles
			end

			local var_190_4 = 0
			local var_190_5 = 0.3

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_4 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_6 = arg_187_1:GetWordFromCfg(1109702046)
				local var_190_7 = arg_187_1:FormatText(var_190_6.content)

				arg_187_1.text_.text = var_190_7

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_9 = 12 <= 0 and var_190_5 or var_190_5 * (utf8.len(var_190_7) / 12)

				if (12 <= 0 and var_190_5 or var_190_5 * (utf8.len(var_190_7) / 12)) > 0 and var_190_5 < var_190_9 then
					arg_187_1.talkMaxDuration = var_190_9

					if var_190_9 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_9 + var_190_4
					end
				end

				arg_187_1.text_.text = var_190_7
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702046", "story_v_side_new_1109702.awb") ~= 0 then
					local var_190_10 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702046", "story_v_side_new_1109702.awb") / 1000

					if var_190_10 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_10 + var_190_4
					end

					if var_190_6.prefab_name ~= "" and arg_187_1.actors_[var_190_6.prefab_name] ~= nil then
						local var_190_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_6.prefab_name].transform, "story_v_side_new_1109702", "1109702046", "story_v_side_new_1109702.awb")

						arg_187_1:RecordAudio("1109702046", var_190_11)
						arg_187_1:RecordAudio("1109702046", var_190_11)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702046", "story_v_side_new_1109702.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702046", "story_v_side_new_1109702.awb")
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
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play1109702047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 1109702047
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play1109702048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["1197ui_story"]) and arg_191_1.var_.characterEffect1197ui_story == nil then
				arg_191_1.var_.characterEffect1197ui_story = arg_191_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_0 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 and not isNil(arg_191_1.actors_["1197ui_story"]) then
				if arg_191_1.var_.characterEffect1197ui_story and not isNil(arg_191_1.actors_["1197ui_story"]) then
					arg_191_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_191_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_191_1.time_ - 0) / var_194_0)
				end
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 and not isNil(arg_191_1.actors_["1197ui_story"]) and arg_191_1.var_.characterEffect1197ui_story then
				arg_191_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_191_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_194_1 = 0
			local var_194_2 = 0.85

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_3 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(1109702047).content)

				arg_191_1.text_.text = var_194_3

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 34 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_3) / 34)

				if (34 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_3) / 34)) > 0 and var_194_2 < var_194_5 then
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
	Play1109702048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 1109702048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play1109702049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.325

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_1 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(1109702048).content)

				arg_195_1.text_.text = var_198_1

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_3 = 13 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 13)

				if (13 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 13)) > 0 and var_198_0 < var_198_3 then
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
	Play1109702049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 1109702049
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play1109702050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0.425

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_1 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(1109702049).content)

				arg_199_1.text_.text = var_202_1

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_3 = 17 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 17)

				if (17 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 17)) > 0 and var_202_0 < var_202_3 then
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
	Play1109702050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 1109702050
		arg_203_1.duration_ = 3.57

		local var_203_0 = {
			zh = 3.166,
			ja = 3.566
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
				arg_203_0:Play1109702051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["1197ui_story"]) and arg_203_1.var_.characterEffect1197ui_story == nil then
				arg_203_1.var_.characterEffect1197ui_story = arg_203_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_0 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["1197ui_story"]) then
				if arg_203_1.var_.characterEffect1197ui_story and not isNil(arg_203_1.actors_["1197ui_story"]) then
					arg_203_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["1197ui_story"]) and arg_203_1.var_.characterEffect1197ui_story then
				arg_203_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action7_1")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_206_2 = 0
			local var_206_3 = 0.525

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_2 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_4 = arg_203_1:GetWordFromCfg(1109702050)
				local var_206_5 = arg_203_1:FormatText(var_206_4.content)

				arg_203_1.text_.text = var_206_5

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_7 = 21 <= 0 and var_206_3 or var_206_3 * (utf8.len(var_206_5) / 21)

				if (21 <= 0 and var_206_3 or var_206_3 * (utf8.len(var_206_5) / 21)) > 0 and var_206_3 < var_206_7 then
					arg_203_1.talkMaxDuration = var_206_7

					if var_206_7 + var_206_2 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_7 + var_206_2
					end
				end

				arg_203_1.text_.text = var_206_5
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702050", "story_v_side_new_1109702.awb") ~= 0 then
					local var_206_8 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702050", "story_v_side_new_1109702.awb") / 1000

					if var_206_8 + var_206_2 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_8 + var_206_2
					end

					if var_206_4.prefab_name ~= "" and arg_203_1.actors_[var_206_4.prefab_name] ~= nil then
						local var_206_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_4.prefab_name].transform, "story_v_side_new_1109702", "1109702050", "story_v_side_new_1109702.awb")

						arg_203_1:RecordAudio("1109702050", var_206_9)
						arg_203_1:RecordAudio("1109702050", var_206_9)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702050", "story_v_side_new_1109702.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702050", "story_v_side_new_1109702.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_10 = math.max(var_206_3, arg_203_1.talkMaxDuration)

			if var_206_2 <= arg_203_1.time_ and arg_203_1.time_ < var_206_2 + var_206_10 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_2) / var_206_10

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_2 + var_206_10 and arg_203_1.time_ < var_206_2 + var_206_10 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play1109702051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 1109702051
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play1109702052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(arg_207_1.actors_["1197ui_story"]) and arg_207_1.var_.characterEffect1197ui_story == nil then
				arg_207_1.var_.characterEffect1197ui_story = arg_207_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_0 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 and not isNil(arg_207_1.actors_["1197ui_story"]) then
				if arg_207_1.var_.characterEffect1197ui_story and not isNil(arg_207_1.actors_["1197ui_story"]) then
					arg_207_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_0)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 and not isNil(arg_207_1.actors_["1197ui_story"]) and arg_207_1.var_.characterEffect1197ui_story then
				arg_207_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_210_1 = 0
			local var_210_2 = 0.075

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
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

				local var_210_3 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(1109702051).content)

				arg_207_1.text_.text = var_210_3

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 3 <= 0 and var_210_2 or var_210_2 * (utf8.len(var_210_3) / 3)

				if (3 <= 0 and var_210_2 or var_210_2 * (utf8.len(var_210_3) / 3)) > 0 and var_210_2 < var_210_5 then
					arg_207_1.talkMaxDuration = var_210_5

					if var_210_5 + var_210_1 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + var_210_1
					end
				end

				arg_207_1.text_.text = var_210_3
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_6 = math.max(var_210_2, arg_207_1.talkMaxDuration)

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_6 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_1) / var_210_6

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_1 + var_210_6 and arg_207_1.time_ < var_210_1 + var_210_6 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play1109702052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 1109702052
		arg_211_1.duration_ = 4.1

		local var_211_0 = {
			zh = 4.1,
			ja = 2.233
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
				arg_211_0:Play1109702053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(arg_211_1.actors_["1197ui_story"]) and arg_211_1.var_.characterEffect1197ui_story == nil then
				arg_211_1.var_.characterEffect1197ui_story = arg_211_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_0 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 and not isNil(arg_211_1.actors_["1197ui_story"]) then
				if arg_211_1.var_.characterEffect1197ui_story and not isNil(arg_211_1.actors_["1197ui_story"]) then
					arg_211_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 and not isNil(arg_211_1.actors_["1197ui_story"]) and arg_211_1.var_.characterEffect1197ui_story then
				arg_211_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action7_2")
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_214_2 = 0
			local var_214_3 = 0.675

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_2 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_4 = arg_211_1:GetWordFromCfg(1109702052)
				local var_214_5 = arg_211_1:FormatText(var_214_4.content)

				arg_211_1.text_.text = var_214_5

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_7 = 27 <= 0 and var_214_3 or var_214_3 * (utf8.len(var_214_5) / 27)

				if (27 <= 0 and var_214_3 or var_214_3 * (utf8.len(var_214_5) / 27)) > 0 and var_214_3 < var_214_7 then
					arg_211_1.talkMaxDuration = var_214_7

					if var_214_7 + var_214_2 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_7 + var_214_2
					end
				end

				arg_211_1.text_.text = var_214_5
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702052", "story_v_side_new_1109702.awb") ~= 0 then
					local var_214_8 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702052", "story_v_side_new_1109702.awb") / 1000

					if var_214_8 + var_214_2 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_8 + var_214_2
					end

					if var_214_4.prefab_name ~= "" and arg_211_1.actors_[var_214_4.prefab_name] ~= nil then
						local var_214_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_4.prefab_name].transform, "story_v_side_new_1109702", "1109702052", "story_v_side_new_1109702.awb")

						arg_211_1:RecordAudio("1109702052", var_214_9)
						arg_211_1:RecordAudio("1109702052", var_214_9)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702052", "story_v_side_new_1109702.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702052", "story_v_side_new_1109702.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_10 = math.max(var_214_3, arg_211_1.talkMaxDuration)

			if var_214_2 <= arg_211_1.time_ and arg_211_1.time_ < var_214_2 + var_214_10 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_2) / var_214_10

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_2 + var_214_10 and arg_211_1.time_ < var_214_2 + var_214_10 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play1109702053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 1109702053
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play1109702054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(arg_215_1.actors_["1197ui_story"]) and arg_215_1.var_.characterEffect1197ui_story == nil then
				arg_215_1.var_.characterEffect1197ui_story = arg_215_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_0 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 and not isNil(arg_215_1.actors_["1197ui_story"]) then
				if arg_215_1.var_.characterEffect1197ui_story and not isNil(arg_215_1.actors_["1197ui_story"]) then
					arg_215_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_215_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_215_1.time_ - 0) / var_218_0)
				end
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 and not isNil(arg_215_1.actors_["1197ui_story"]) and arg_215_1.var_.characterEffect1197ui_story then
				arg_215_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_215_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_218_1 = 0
			local var_218_2 = 0.175

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

				local var_218_3 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(1109702053).content)

				arg_215_1.text_.text = var_218_3

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_5 = 7 <= 0 and var_218_2 or var_218_2 * (utf8.len(var_218_3) / 7)

				if (7 <= 0 and var_218_2 or var_218_2 * (utf8.len(var_218_3) / 7)) > 0 and var_218_2 < var_218_5 then
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
	Play1109702054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 1109702054
		arg_219_1.duration_ = 9

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play1109702055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 2 < arg_219_1.time_ and arg_219_1.time_ <= 2 + arg_222_0 then
				local var_222_0 = arg_219_1.bgs_.I09

				arg_219_1.bgs_.I09.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_222_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_222_1 = var_222_0:GetComponent("SpriteRenderer")

				if var_222_1 and var_222_1.sprite then
					local var_222_2 = 2 * (var_222_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_222_0.transform.localScale = Vector3.New(var_222_2 / var_222_1.sprite.bounds.size.y < var_222_2 * manager.ui.mainCameraCom_.aspect / var_222_1.sprite.bounds.size.x and var_222_2 * manager.ui.mainCameraCom_.aspect / var_222_1.sprite.bounds.size.x or var_222_2 / var_222_1.sprite.bounds.size.y, var_222_2 / var_222_1.sprite.bounds.size.y < var_222_2 * manager.ui.mainCameraCom_.aspect / var_222_1.sprite.bounds.size.x and var_222_2 * manager.ui.mainCameraCom_.aspect / var_222_1.sprite.bounds.size.x or var_222_2 / var_222_1.sprite.bounds.size.y, 0)
				end

				for iter_222_0, iter_222_1 in pairs(arg_219_1.bgs_) do
					if iter_222_0 ~= "I09" then
						iter_222_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_222_3 = 0

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_3 + arg_222_0 then
				arg_219_1.mask_.enabled = true
				arg_219_1.mask_.raycastTarget = true

				arg_219_1:SetGaussion(false)
			end

			local var_222_4 = 2

			if var_222_3 <= arg_219_1.time_ and arg_219_1.time_ < var_222_3 + var_222_4 then
				local var_222_5 = Color.New(1, 1, 1)

				var_222_5.a = Mathf.Lerp(0, 1, (arg_219_1.time_ - var_222_3) / var_222_4)
				arg_219_1.mask_.color = var_222_5
			end

			if arg_219_1.time_ >= var_222_3 + var_222_4 and arg_219_1.time_ < var_222_3 + var_222_4 + arg_222_0 then
				local var_222_6 = Color.New(1, 1, 1)

				var_222_6.a = 1
				arg_219_1.mask_.color = var_222_6
			end

			local var_222_7 = 2

			if 2 < arg_219_1.time_ and arg_219_1.time_ <= var_222_7 + arg_222_0 then
				arg_219_1.mask_.enabled = true
				arg_219_1.mask_.raycastTarget = true

				arg_219_1:SetGaussion(false)
			end

			local var_222_8 = 2

			if var_222_7 <= arg_219_1.time_ and arg_219_1.time_ < var_222_7 + var_222_8 then
				local var_222_9 = Color.New(1, 1, 1)

				var_222_9.a = Mathf.Lerp(1, 0, (arg_219_1.time_ - var_222_7) / var_222_8)
				arg_219_1.mask_.color = var_222_9
			end

			if arg_219_1.time_ >= var_222_7 + var_222_8 and arg_219_1.time_ < var_222_7 + var_222_8 + arg_222_0 then
				local var_222_10 = Color.New(1, 1, 1)

				arg_219_1.mask_.enabled = false
				var_222_10.a = 0
				arg_219_1.mask_.color = var_222_10
			end

			local var_222_11 = arg_219_1.actors_["1197ui_story"].transform

			if 1.96599999815226 < arg_219_1.time_ and arg_219_1.time_ <= 1.96599999815226 + arg_222_0 then
				arg_219_1.var_.moveOldPos1197ui_story = var_222_11.localPosition
			end

			local var_222_12 = 0.001

			if 1.96599999815226 <= arg_219_1.time_ and arg_219_1.time_ < 1.96599999815226 + var_222_12 then
				var_222_11.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1197ui_story, Vector3.New(0, 100, 0), (arg_219_1.time_ - 1.96599999815226) / var_222_12)
				var_222_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_222_11.position).x, (manager.ui.mainCamera.transform.position - var_222_11.position).y, (manager.ui.mainCamera.transform.position - var_222_11.position).z)
				var_222_11.localEulerAngles.z = 0
				var_222_11.localEulerAngles.x = 0
				var_222_11.localEulerAngles = var_222_11.localEulerAngles
			end

			if arg_219_1.time_ >= 1.96599999815226 + var_222_12 and arg_219_1.time_ < 1.96599999815226 + var_222_12 + arg_222_0 then
				var_222_11.localPosition = Vector3.New(0, 100, 0)
				var_222_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_222_11.position).x, (manager.ui.mainCamera.transform.position - var_222_11.position).y, (manager.ui.mainCamera.transform.position - var_222_11.position).z)
				var_222_11.localEulerAngles.z = 0
				var_222_11.localEulerAngles.x = 0
				var_222_11.localEulerAngles = var_222_11.localEulerAngles
			end

			local var_222_13 = arg_219_1.actors_["1197ui_story"]

			if 1.96599999815226 < arg_219_1.time_ and arg_219_1.time_ <= 1.96599999815226 + arg_222_0 and not isNil(var_222_13) and arg_219_1.var_.characterEffect1197ui_story == nil then
				arg_219_1.var_.characterEffect1197ui_story = var_222_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_14 = 0.034000001847744

			if 1.96599999815226 <= arg_219_1.time_ and arg_219_1.time_ < 1.96599999815226 + var_222_14 and not isNil(var_222_13) then
				if arg_219_1.var_.characterEffect1197ui_story and not isNil(var_222_13) then
					arg_219_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 1.96599999815226) / var_222_14)
				end
			end

			if arg_219_1.time_ >= 1.96599999815226 + var_222_14 and arg_219_1.time_ < 1.96599999815226 + var_222_14 + arg_222_0 and not isNil(var_222_13) and arg_219_1.var_.characterEffect1197ui_story then
				arg_219_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			if arg_219_1.frameCnt_ <= 1 then
				arg_219_1.dialog_:SetActive(false)
			end

			local var_222_15 = 4
			local var_222_16 = 0.05

			if 4 < arg_219_1.time_ and arg_219_1.time_ <= var_222_15 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0

				arg_219_1.dialog_:SetActive(true)

				arg_219_1.dialogCg_.alpha = 0

				local var_222_17 = LeanTween.value(arg_219_1.dialog_, 0, 1, 0.3)

				var_222_17:setOnUpdate(LuaHelper.FloatAction(function(arg_223_0)
					arg_219_1.dialogCg_.alpha = arg_223_0
				end))
				var_222_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_219_1.dialog_)
					var_222_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_219_1.duration_ = arg_219_1.duration_ + 0.3

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

				local var_222_18 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(1109702054).content)

				arg_219_1.text_.text = var_222_18

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_20 = 2 <= 0 and var_222_16 or var_222_16 * (utf8.len(var_222_18) / 2)

				if (2 <= 0 and var_222_16 or var_222_16 * (utf8.len(var_222_18) / 2)) > 0 and var_222_16 < var_222_20 then
					arg_219_1.talkMaxDuration = var_222_20
					var_222_15 = var_222_15 + 0.3

					if var_222_20 + var_222_15 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_20 + var_222_15
					end
				end

				arg_219_1.text_.text = var_222_18
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_21 = var_222_15 + 0.3
			local var_222_22 = math.max(var_222_16, arg_219_1.talkMaxDuration)

			if var_222_15 + 0.3 <= arg_219_1.time_ and arg_219_1.time_ < var_222_21 + var_222_22 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_21) / var_222_22

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_21 + var_222_22 and arg_219_1.time_ < var_222_21 + var_222_22 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play1109702055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1109702055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play1109702056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 1

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_1 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(1109702055).content)

				arg_225_1.text_.text = var_228_1

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_3 = 40 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_1) / 40)

				if (40 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_1) / 40)) > 0 and var_228_0 < var_228_3 then
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
	Play1109702056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1109702056
		arg_229_1.duration_ = 4.43

		local var_229_0 = {
			zh = 4.433,
			ja = 4.166
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
				arg_229_0:Play1109702057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos1197ui_story = arg_229_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_232_0 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 then
				arg_229_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_229_1.time_ - 0) / var_232_0)
				arg_229_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1197ui_story"].transform.position).z)
				arg_229_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["1197ui_story"].transform.localEulerAngles = arg_229_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 then
				arg_229_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, -0.545, -6.3)
				arg_229_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1197ui_story"].transform.position).z)
				arg_229_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["1197ui_story"].transform.localEulerAngles = arg_229_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_232_1 = arg_229_1.actors_["1197ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect1197ui_story == nil then
				arg_229_1.var_.characterEffect1197ui_story = var_232_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_2 and not isNil(var_232_1) then
				if arg_229_1.var_.characterEffect1197ui_story and not isNil(var_232_1) then
					arg_229_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_2 and arg_229_1.time_ < 0 + var_232_2 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect1197ui_story then
				arg_229_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action1_1")
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_232_4 = 0
			local var_232_5 = 0.425

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_4 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_6 = arg_229_1:GetWordFromCfg(1109702056)
				local var_232_7 = arg_229_1:FormatText(var_232_6.content)

				arg_229_1.text_.text = var_232_7

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_9 = 17 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_7) / 17)

				if (17 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_7) / 17)) > 0 and var_232_5 < var_232_9 then
					arg_229_1.talkMaxDuration = var_232_9

					if var_232_9 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_9 + var_232_4
					end
				end

				arg_229_1.text_.text = var_232_7
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702056", "story_v_side_new_1109702.awb") ~= 0 then
					local var_232_10 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702056", "story_v_side_new_1109702.awb") / 1000

					if var_232_10 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_10 + var_232_4
					end

					if var_232_6.prefab_name ~= "" and arg_229_1.actors_[var_232_6.prefab_name] ~= nil then
						local var_232_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_6.prefab_name].transform, "story_v_side_new_1109702", "1109702056", "story_v_side_new_1109702.awb")

						arg_229_1:RecordAudio("1109702056", var_232_11)
						arg_229_1:RecordAudio("1109702056", var_232_11)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702056", "story_v_side_new_1109702.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702056", "story_v_side_new_1109702.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_12 = math.max(var_232_5, arg_229_1.talkMaxDuration)

			if var_232_4 <= arg_229_1.time_ and arg_229_1.time_ < var_232_4 + var_232_12 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_4) / var_232_12

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_4 + var_232_12 and arg_229_1.time_ < var_232_4 + var_232_12 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play1109702057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1109702057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play1109702058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(arg_233_1.actors_["1197ui_story"]) and arg_233_1.var_.characterEffect1197ui_story == nil then
				arg_233_1.var_.characterEffect1197ui_story = arg_233_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_0 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 and not isNil(arg_233_1.actors_["1197ui_story"]) then
				if arg_233_1.var_.characterEffect1197ui_story and not isNil(arg_233_1.actors_["1197ui_story"]) then
					arg_233_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_0)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 and not isNil(arg_233_1.actors_["1197ui_story"]) and arg_233_1.var_.characterEffect1197ui_story then
				arg_233_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_236_1 = 0
			local var_236_2 = 0.2

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

				local var_236_3 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(1109702057).content)

				arg_233_1.text_.text = var_236_3

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_5 = 8 <= 0 and var_236_2 or var_236_2 * (utf8.len(var_236_3) / 8)

				if (8 <= 0 and var_236_2 or var_236_2 * (utf8.len(var_236_3) / 8)) > 0 and var_236_2 < var_236_5 then
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
	Play1109702058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1109702058
		arg_237_1.duration_ = 9

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play1109702059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 2 < arg_237_1.time_ and arg_237_1.time_ <= 2 + arg_240_0 then
				local var_240_0 = arg_237_1.bgs_.I09

				arg_237_1.bgs_.I09.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_240_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_240_1 = var_240_0:GetComponent("SpriteRenderer")

				if var_240_1 and var_240_1.sprite then
					local var_240_2 = 2 * (var_240_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_240_0.transform.localScale = Vector3.New(var_240_2 / var_240_1.sprite.bounds.size.y < var_240_2 * manager.ui.mainCameraCom_.aspect / var_240_1.sprite.bounds.size.x and var_240_2 * manager.ui.mainCameraCom_.aspect / var_240_1.sprite.bounds.size.x or var_240_2 / var_240_1.sprite.bounds.size.y, var_240_2 / var_240_1.sprite.bounds.size.y < var_240_2 * manager.ui.mainCameraCom_.aspect / var_240_1.sprite.bounds.size.x and var_240_2 * manager.ui.mainCameraCom_.aspect / var_240_1.sprite.bounds.size.x or var_240_2 / var_240_1.sprite.bounds.size.y, 0)
				end

				for iter_240_0, iter_240_1 in pairs(arg_237_1.bgs_) do
					if iter_240_0 ~= "I09" then
						iter_240_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_240_3 = 3.999999999999

			if 3.999999999999 < arg_237_1.time_ and arg_237_1.time_ <= var_240_3 + arg_240_0 then
				arg_237_1.allBtn_.enabled = false
			end

			if arg_237_1.time_ >= var_240_3 + 0.3 and arg_237_1.time_ < var_240_3 + 0.3 + arg_240_0 then
				arg_237_1.allBtn_.enabled = true
			end

			local var_240_4 = 0

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_4 + arg_240_0 then
				arg_237_1.mask_.enabled = true
				arg_237_1.mask_.raycastTarget = true

				arg_237_1:SetGaussion(false)
			end

			local var_240_5 = 2

			if var_240_4 <= arg_237_1.time_ and arg_237_1.time_ < var_240_4 + var_240_5 then
				local var_240_6 = Color.New(1, 1, 1)

				var_240_6.a = Mathf.Lerp(0, 1, (arg_237_1.time_ - var_240_4) / var_240_5)
				arg_237_1.mask_.color = var_240_6
			end

			if arg_237_1.time_ >= var_240_4 + var_240_5 and arg_237_1.time_ < var_240_4 + var_240_5 + arg_240_0 then
				local var_240_7 = Color.New(1, 1, 1)

				var_240_7.a = 1
				arg_237_1.mask_.color = var_240_7
			end

			local var_240_8 = 2

			if 2 < arg_237_1.time_ and arg_237_1.time_ <= var_240_8 + arg_240_0 then
				arg_237_1.mask_.enabled = true
				arg_237_1.mask_.raycastTarget = true

				arg_237_1:SetGaussion(false)
			end

			local var_240_9 = 2

			if var_240_8 <= arg_237_1.time_ and arg_237_1.time_ < var_240_8 + var_240_9 then
				local var_240_10 = Color.New(1, 1, 1)

				var_240_10.a = Mathf.Lerp(1, 0, (arg_237_1.time_ - var_240_8) / var_240_9)
				arg_237_1.mask_.color = var_240_10
			end

			if arg_237_1.time_ >= var_240_8 + var_240_9 and arg_237_1.time_ < var_240_8 + var_240_9 + arg_240_0 then
				local var_240_11 = Color.New(1, 1, 1)

				arg_237_1.mask_.enabled = false
				var_240_11.a = 0
				arg_237_1.mask_.color = var_240_11
			end

			local var_240_12 = arg_237_1.actors_["1197ui_story"].transform

			if 1.96599999815226 < arg_237_1.time_ and arg_237_1.time_ <= 1.96599999815226 + arg_240_0 then
				arg_237_1.var_.moveOldPos1197ui_story = var_240_12.localPosition
			end

			local var_240_13 = 0.001

			if 1.96599999815226 <= arg_237_1.time_ and arg_237_1.time_ < 1.96599999815226 + var_240_13 then
				var_240_12.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1197ui_story, Vector3.New(0, 100, 0), (arg_237_1.time_ - 1.96599999815226) / var_240_13)
				var_240_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_240_12.position).x, (manager.ui.mainCamera.transform.position - var_240_12.position).y, (manager.ui.mainCamera.transform.position - var_240_12.position).z)
				var_240_12.localEulerAngles.z = 0
				var_240_12.localEulerAngles.x = 0
				var_240_12.localEulerAngles = var_240_12.localEulerAngles
			end

			if arg_237_1.time_ >= 1.96599999815226 + var_240_13 and arg_237_1.time_ < 1.96599999815226 + var_240_13 + arg_240_0 then
				var_240_12.localPosition = Vector3.New(0, 100, 0)
				var_240_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_240_12.position).x, (manager.ui.mainCamera.transform.position - var_240_12.position).y, (manager.ui.mainCamera.transform.position - var_240_12.position).z)
				var_240_12.localEulerAngles.z = 0
				var_240_12.localEulerAngles.x = 0
				var_240_12.localEulerAngles = var_240_12.localEulerAngles
			end

			local var_240_14 = arg_237_1.actors_["1197ui_story"]

			if 1.96599999815226 < arg_237_1.time_ and arg_237_1.time_ <= 1.96599999815226 + arg_240_0 and not isNil(var_240_14) and arg_237_1.var_.characterEffect1197ui_story == nil then
				arg_237_1.var_.characterEffect1197ui_story = var_240_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_15 = 0.034000001847744

			if 1.96599999815226 <= arg_237_1.time_ and arg_237_1.time_ < 1.96599999815226 + var_240_15 and not isNil(var_240_14) then
				if arg_237_1.var_.characterEffect1197ui_story and not isNil(var_240_14) then
					arg_237_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 1.96599999815226) / var_240_15)
				end
			end

			if arg_237_1.time_ >= 1.96599999815226 + var_240_15 and arg_237_1.time_ < 1.96599999815226 + var_240_15 + arg_240_0 and not isNil(var_240_14) and arg_237_1.var_.characterEffect1197ui_story then
				arg_237_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			if arg_237_1.frameCnt_ <= 1 then
				arg_237_1.dialog_:SetActive(false)
			end

			local var_240_16 = 3.999999999999
			local var_240_17 = 0.7

			if 3.999999999999 < arg_237_1.time_ and arg_237_1.time_ <= var_240_16 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0

				arg_237_1.dialog_:SetActive(true)

				arg_237_1.dialogCg_.alpha = 0

				local var_240_18 = LeanTween.value(arg_237_1.dialog_, 0, 1, 0.3)

				var_240_18:setOnUpdate(LuaHelper.FloatAction(function(arg_241_0)
					arg_237_1.dialogCg_.alpha = arg_241_0
				end))
				var_240_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_237_1.dialog_)
					var_240_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_237_1.duration_ = arg_237_1.duration_ + 0.3

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

				local var_240_19 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(1109702058).content)

				arg_237_1.text_.text = var_240_19

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_21 = 28 <= 0 and var_240_17 or var_240_17 * (utf8.len(var_240_19) / 28)

				if (28 <= 0 and var_240_17 or var_240_17 * (utf8.len(var_240_19) / 28)) > 0 and var_240_17 < var_240_21 then
					arg_237_1.talkMaxDuration = var_240_21
					var_240_16 = var_240_16 + 0.3

					if var_240_21 + var_240_16 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_21 + var_240_16
					end
				end

				arg_237_1.text_.text = var_240_19
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_22 = var_240_16 + 0.3
			local var_240_23 = math.max(var_240_17, arg_237_1.talkMaxDuration)

			if var_240_16 + 0.3 <= arg_237_1.time_ and arg_237_1.time_ < var_240_22 + var_240_23 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_22) / var_240_23

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_22 + var_240_23 and arg_237_1.time_ < var_240_22 + var_240_23 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play1109702059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 1109702059
		arg_243_1.duration_ = 2

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play1109702060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos1197ui_story = arg_243_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_246_0 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 then
				arg_243_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_243_1.time_ - 0) / var_246_0)
				arg_243_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1197ui_story"].transform.position).z)
				arg_243_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1197ui_story"].transform.localEulerAngles = arg_243_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 then
				arg_243_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, -0.545, -6.3)
				arg_243_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1197ui_story"].transform.position).z)
				arg_243_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1197ui_story"].transform.localEulerAngles = arg_243_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_246_1 = arg_243_1.actors_["1197ui_story"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect1197ui_story == nil then
				arg_243_1.var_.characterEffect1197ui_story = var_246_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_2 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_2 and not isNil(var_246_1) then
				if arg_243_1.var_.characterEffect1197ui_story and not isNil(var_246_1) then
					arg_243_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= 0 + var_246_2 and arg_243_1.time_ < 0 + var_246_2 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect1197ui_story then
				arg_243_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action7_1")
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_246_4 = 0
			local var_246_5 = 0.15

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_4 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_6 = arg_243_1:GetWordFromCfg(1109702059)
				local var_246_7 = arg_243_1:FormatText(var_246_6.content)

				arg_243_1.text_.text = var_246_7

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_9 = 6 <= 0 and var_246_5 or var_246_5 * (utf8.len(var_246_7) / 6)

				if (6 <= 0 and var_246_5 or var_246_5 * (utf8.len(var_246_7) / 6)) > 0 and var_246_5 < var_246_9 then
					arg_243_1.talkMaxDuration = var_246_9

					if var_246_9 + var_246_4 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_9 + var_246_4
					end
				end

				arg_243_1.text_.text = var_246_7
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702059", "story_v_side_new_1109702.awb") ~= 0 then
					local var_246_10 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702059", "story_v_side_new_1109702.awb") / 1000

					if var_246_10 + var_246_4 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_10 + var_246_4
					end

					if var_246_6.prefab_name ~= "" and arg_243_1.actors_[var_246_6.prefab_name] ~= nil then
						local var_246_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_6.prefab_name].transform, "story_v_side_new_1109702", "1109702059", "story_v_side_new_1109702.awb")

						arg_243_1:RecordAudio("1109702059", var_246_11)
						arg_243_1:RecordAudio("1109702059", var_246_11)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702059", "story_v_side_new_1109702.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702059", "story_v_side_new_1109702.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_12 = math.max(var_246_5, arg_243_1.talkMaxDuration)

			if var_246_4 <= arg_243_1.time_ and arg_243_1.time_ < var_246_4 + var_246_12 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_4) / var_246_12

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_4 + var_246_12 and arg_243_1.time_ < var_246_4 + var_246_12 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play1109702060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 1109702060
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play1109702061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["1197ui_story"]) and arg_247_1.var_.characterEffect1197ui_story == nil then
				arg_247_1.var_.characterEffect1197ui_story = arg_247_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_0 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 and not isNil(arg_247_1.actors_["1197ui_story"]) then
				if arg_247_1.var_.characterEffect1197ui_story and not isNil(arg_247_1.actors_["1197ui_story"]) then
					arg_247_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_247_1.time_ - 0) / var_250_0)
				end
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 and not isNil(arg_247_1.actors_["1197ui_story"]) and arg_247_1.var_.characterEffect1197ui_story then
				arg_247_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_250_1 = 0
			local var_250_2 = 0.2

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
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

				local var_250_3 = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(1109702060).content)

				arg_247_1.text_.text = var_250_3

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_5 = 8 <= 0 and var_250_2 or var_250_2 * (utf8.len(var_250_3) / 8)

				if (8 <= 0 and var_250_2 or var_250_2 * (utf8.len(var_250_3) / 8)) > 0 and var_250_2 < var_250_5 then
					arg_247_1.talkMaxDuration = var_250_5

					if var_250_5 + var_250_1 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_5 + var_250_1
					end
				end

				arg_247_1.text_.text = var_250_3
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_6 = math.max(var_250_2, arg_247_1.talkMaxDuration)

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_6 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_1) / var_250_6

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_1 + var_250_6 and arg_247_1.time_ < var_250_1 + var_250_6 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play1109702061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 1109702061
		arg_251_1.duration_ = 9

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play1109702062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 2 < arg_251_1.time_ and arg_251_1.time_ <= 2 + arg_254_0 then
				local var_254_0 = arg_251_1.bgs_.I09

				arg_251_1.bgs_.I09.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_254_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_254_1 = var_254_0:GetComponent("SpriteRenderer")

				if var_254_1 and var_254_1.sprite then
					local var_254_2 = 2 * (var_254_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_254_0.transform.localScale = Vector3.New(var_254_2 / var_254_1.sprite.bounds.size.y < var_254_2 * manager.ui.mainCameraCom_.aspect / var_254_1.sprite.bounds.size.x and var_254_2 * manager.ui.mainCameraCom_.aspect / var_254_1.sprite.bounds.size.x or var_254_2 / var_254_1.sprite.bounds.size.y, var_254_2 / var_254_1.sprite.bounds.size.y < var_254_2 * manager.ui.mainCameraCom_.aspect / var_254_1.sprite.bounds.size.x and var_254_2 * manager.ui.mainCameraCom_.aspect / var_254_1.sprite.bounds.size.x or var_254_2 / var_254_1.sprite.bounds.size.y, 0)
				end

				for iter_254_0, iter_254_1 in pairs(arg_251_1.bgs_) do
					if iter_254_0 ~= "I09" then
						iter_254_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_254_3 = 0

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_3 + arg_254_0 then
				arg_251_1.mask_.enabled = true
				arg_251_1.mask_.raycastTarget = true

				arg_251_1:SetGaussion(false)
			end

			local var_254_4 = 2

			if var_254_3 <= arg_251_1.time_ and arg_251_1.time_ < var_254_3 + var_254_4 then
				local var_254_5 = Color.New(1, 1, 1)

				var_254_5.a = Mathf.Lerp(0, 1, (arg_251_1.time_ - var_254_3) / var_254_4)
				arg_251_1.mask_.color = var_254_5
			end

			if arg_251_1.time_ >= var_254_3 + var_254_4 and arg_251_1.time_ < var_254_3 + var_254_4 + arg_254_0 then
				local var_254_6 = Color.New(1, 1, 1)

				var_254_6.a = 1
				arg_251_1.mask_.color = var_254_6
			end

			local var_254_7 = 2

			if 2 < arg_251_1.time_ and arg_251_1.time_ <= var_254_7 + arg_254_0 then
				arg_251_1.mask_.enabled = true
				arg_251_1.mask_.raycastTarget = true

				arg_251_1:SetGaussion(false)
			end

			local var_254_8 = 2

			if var_254_7 <= arg_251_1.time_ and arg_251_1.time_ < var_254_7 + var_254_8 then
				local var_254_9 = Color.New(1, 1, 1)

				var_254_9.a = Mathf.Lerp(1, 0, (arg_251_1.time_ - var_254_7) / var_254_8)
				arg_251_1.mask_.color = var_254_9
			end

			if arg_251_1.time_ >= var_254_7 + var_254_8 and arg_251_1.time_ < var_254_7 + var_254_8 + arg_254_0 then
				local var_254_10 = Color.New(1, 1, 1)

				arg_251_1.mask_.enabled = false
				var_254_10.a = 0
				arg_251_1.mask_.color = var_254_10
			end

			local var_254_11 = arg_251_1.actors_["1197ui_story"].transform

			if 1.96599999815226 < arg_251_1.time_ and arg_251_1.time_ <= 1.96599999815226 + arg_254_0 then
				arg_251_1.var_.moveOldPos1197ui_story = var_254_11.localPosition
			end

			local var_254_12 = 0.001

			if 1.96599999815226 <= arg_251_1.time_ and arg_251_1.time_ < 1.96599999815226 + var_254_12 then
				var_254_11.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1197ui_story, Vector3.New(0, 100, 0), (arg_251_1.time_ - 1.96599999815226) / var_254_12)
				var_254_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_254_11.position).x, (manager.ui.mainCamera.transform.position - var_254_11.position).y, (manager.ui.mainCamera.transform.position - var_254_11.position).z)
				var_254_11.localEulerAngles.z = 0
				var_254_11.localEulerAngles.x = 0
				var_254_11.localEulerAngles = var_254_11.localEulerAngles
			end

			if arg_251_1.time_ >= 1.96599999815226 + var_254_12 and arg_251_1.time_ < 1.96599999815226 + var_254_12 + arg_254_0 then
				var_254_11.localPosition = Vector3.New(0, 100, 0)
				var_254_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_254_11.position).x, (manager.ui.mainCamera.transform.position - var_254_11.position).y, (manager.ui.mainCamera.transform.position - var_254_11.position).z)
				var_254_11.localEulerAngles.z = 0
				var_254_11.localEulerAngles.x = 0
				var_254_11.localEulerAngles = var_254_11.localEulerAngles
			end

			local var_254_13 = arg_251_1.actors_["1197ui_story"]

			if 1.96599999815226 < arg_251_1.time_ and arg_251_1.time_ <= 1.96599999815226 + arg_254_0 and not isNil(var_254_13) and arg_251_1.var_.characterEffect1197ui_story == nil then
				arg_251_1.var_.characterEffect1197ui_story = var_254_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_14 = 0.034000001847744

			if 1.96599999815226 <= arg_251_1.time_ and arg_251_1.time_ < 1.96599999815226 + var_254_14 and not isNil(var_254_13) then
				if arg_251_1.var_.characterEffect1197ui_story and not isNil(var_254_13) then
					arg_251_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_251_1.time_ - 1.96599999815226) / var_254_14)
				end
			end

			if arg_251_1.time_ >= 1.96599999815226 + var_254_14 and arg_251_1.time_ < 1.96599999815226 + var_254_14 + arg_254_0 and not isNil(var_254_13) and arg_251_1.var_.characterEffect1197ui_story then
				arg_251_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			if arg_251_1.frameCnt_ <= 1 then
				arg_251_1.dialog_:SetActive(false)
			end

			local var_254_15 = 3.999999999999
			local var_254_16 = 1.1

			if 3.999999999999 < arg_251_1.time_ and arg_251_1.time_ <= var_254_15 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0

				arg_251_1.dialog_:SetActive(true)

				arg_251_1.dialogCg_.alpha = 0

				local var_254_17 = LeanTween.value(arg_251_1.dialog_, 0, 1, 0.3)

				var_254_17:setOnUpdate(LuaHelper.FloatAction(function(arg_255_0)
					arg_251_1.dialogCg_.alpha = arg_255_0
				end))
				var_254_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_251_1.dialog_)
					var_254_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_251_1.duration_ = arg_251_1.duration_ + 0.3

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

				local var_254_18 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(1109702061).content)

				arg_251_1.text_.text = var_254_18

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_20 = 44 <= 0 and var_254_16 or var_254_16 * (utf8.len(var_254_18) / 44)

				if (44 <= 0 and var_254_16 or var_254_16 * (utf8.len(var_254_18) / 44)) > 0 and var_254_16 < var_254_20 then
					arg_251_1.talkMaxDuration = var_254_20
					var_254_15 = var_254_15 + 0.3

					if var_254_20 + var_254_15 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_20 + var_254_15
					end
				end

				arg_251_1.text_.text = var_254_18
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_21 = var_254_15 + 0.3
			local var_254_22 = math.max(var_254_16, arg_251_1.talkMaxDuration)

			if var_254_15 + 0.3 <= arg_251_1.time_ and arg_251_1.time_ < var_254_21 + var_254_22 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_21) / var_254_22

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_21 + var_254_22 and arg_251_1.time_ < var_254_21 + var_254_22 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play1109702062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 1109702062
		arg_257_1.duration_ = 5.4

		local var_257_0 = {
			zh = 5.4,
			ja = 4.333
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
				arg_257_0:Play1109702063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1197ui_story = arg_257_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_260_0 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 then
				arg_257_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_257_1.time_ - 0) / var_260_0)
				arg_257_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1197ui_story"].transform.position).z)
				arg_257_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1197ui_story"].transform.localEulerAngles = arg_257_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 then
				arg_257_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, -0.545, -6.3)
				arg_257_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1197ui_story"].transform.position).z)
				arg_257_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1197ui_story"].transform.localEulerAngles = arg_257_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_260_1 = arg_257_1.actors_["1197ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_1) and arg_257_1.var_.characterEffect1197ui_story == nil then
				arg_257_1.var_.characterEffect1197ui_story = var_260_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_2 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_2 and not isNil(var_260_1) then
				if arg_257_1.var_.characterEffect1197ui_story and not isNil(var_260_1) then
					arg_257_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= 0 + var_260_2 and arg_257_1.time_ < 0 + var_260_2 + arg_260_0 and not isNil(var_260_1) and arg_257_1.var_.characterEffect1197ui_story then
				arg_257_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action1_1")
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_260_4 = 0
			local var_260_5 = 0.625

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_4 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_6 = arg_257_1:GetWordFromCfg(1109702062)
				local var_260_7 = arg_257_1:FormatText(var_260_6.content)

				arg_257_1.text_.text = var_260_7

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_9 = 25 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_7) / 25)

				if (25 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_7) / 25)) > 0 and var_260_5 < var_260_9 then
					arg_257_1.talkMaxDuration = var_260_9

					if var_260_9 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_9 + var_260_4
					end
				end

				arg_257_1.text_.text = var_260_7
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702062", "story_v_side_new_1109702.awb") ~= 0 then
					local var_260_10 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702062", "story_v_side_new_1109702.awb") / 1000

					if var_260_10 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_10 + var_260_4
					end

					if var_260_6.prefab_name ~= "" and arg_257_1.actors_[var_260_6.prefab_name] ~= nil then
						local var_260_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_6.prefab_name].transform, "story_v_side_new_1109702", "1109702062", "story_v_side_new_1109702.awb")

						arg_257_1:RecordAudio("1109702062", var_260_11)
						arg_257_1:RecordAudio("1109702062", var_260_11)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702062", "story_v_side_new_1109702.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702062", "story_v_side_new_1109702.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_12 = math.max(var_260_5, arg_257_1.talkMaxDuration)

			if var_260_4 <= arg_257_1.time_ and arg_257_1.time_ < var_260_4 + var_260_12 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_4) / var_260_12

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_4 + var_260_12 and arg_257_1.time_ < var_260_4 + var_260_12 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play1109702063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 1109702063
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play1109702064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(arg_261_1.actors_["1197ui_story"]) and arg_261_1.var_.characterEffect1197ui_story == nil then
				arg_261_1.var_.characterEffect1197ui_story = arg_261_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_0 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 and not isNil(arg_261_1.actors_["1197ui_story"]) then
				if arg_261_1.var_.characterEffect1197ui_story and not isNil(arg_261_1.actors_["1197ui_story"]) then
					arg_261_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_261_1.time_ - 0) / var_264_0)
				end
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 and not isNil(arg_261_1.actors_["1197ui_story"]) and arg_261_1.var_.characterEffect1197ui_story then
				arg_261_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_264_1 = 0
			local var_264_2 = 0.375

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

				local var_264_3 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(1109702063).content)

				arg_261_1.text_.text = var_264_3

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 15 <= 0 and var_264_2 or var_264_2 * (utf8.len(var_264_3) / 15)

				if (15 <= 0 and var_264_2 or var_264_2 * (utf8.len(var_264_3) / 15)) > 0 and var_264_2 < var_264_5 then
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
	Play1109702064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 1109702064
		arg_265_1.duration_ = 9

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play1109702065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 2 < arg_265_1.time_ and arg_265_1.time_ <= 2 + arg_268_0 then
				local var_268_0 = arg_265_1.bgs_.I09

				arg_265_1.bgs_.I09.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_268_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_268_1 = var_268_0:GetComponent("SpriteRenderer")

				if var_268_1 and var_268_1.sprite then
					local var_268_2 = 2 * (var_268_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_268_0.transform.localScale = Vector3.New(var_268_2 / var_268_1.sprite.bounds.size.y < var_268_2 * manager.ui.mainCameraCom_.aspect / var_268_1.sprite.bounds.size.x and var_268_2 * manager.ui.mainCameraCom_.aspect / var_268_1.sprite.bounds.size.x or var_268_2 / var_268_1.sprite.bounds.size.y, var_268_2 / var_268_1.sprite.bounds.size.y < var_268_2 * manager.ui.mainCameraCom_.aspect / var_268_1.sprite.bounds.size.x and var_268_2 * manager.ui.mainCameraCom_.aspect / var_268_1.sprite.bounds.size.x or var_268_2 / var_268_1.sprite.bounds.size.y, 0)
				end

				for iter_268_0, iter_268_1 in pairs(arg_265_1.bgs_) do
					if iter_268_0 ~= "I09" then
						iter_268_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_268_3 = 4

			if 4 < arg_265_1.time_ and arg_265_1.time_ <= var_268_3 + arg_268_0 then
				arg_265_1.allBtn_.enabled = false
			end

			if arg_265_1.time_ >= var_268_3 + 0.3 and arg_265_1.time_ < var_268_3 + 0.3 + arg_268_0 then
				arg_265_1.allBtn_.enabled = true
			end

			local var_268_4 = 0

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_4 + arg_268_0 then
				arg_265_1.mask_.enabled = true
				arg_265_1.mask_.raycastTarget = true

				arg_265_1:SetGaussion(false)
			end

			local var_268_5 = 2

			if var_268_4 <= arg_265_1.time_ and arg_265_1.time_ < var_268_4 + var_268_5 then
				local var_268_6 = Color.New(0, 0, 0)

				var_268_6.a = Mathf.Lerp(0, 1, (arg_265_1.time_ - var_268_4) / var_268_5)
				arg_265_1.mask_.color = var_268_6
			end

			if arg_265_1.time_ >= var_268_4 + var_268_5 and arg_265_1.time_ < var_268_4 + var_268_5 + arg_268_0 then
				local var_268_7 = Color.New(0, 0, 0)

				var_268_7.a = 1
				arg_265_1.mask_.color = var_268_7
			end

			local var_268_8 = 2

			if 2 < arg_265_1.time_ and arg_265_1.time_ <= var_268_8 + arg_268_0 then
				arg_265_1.mask_.enabled = true
				arg_265_1.mask_.raycastTarget = true

				arg_265_1:SetGaussion(false)
			end

			local var_268_9 = 2

			if var_268_8 <= arg_265_1.time_ and arg_265_1.time_ < var_268_8 + var_268_9 then
				local var_268_10 = Color.New(0, 0, 0)

				var_268_10.a = Mathf.Lerp(1, 0, (arg_265_1.time_ - var_268_8) / var_268_9)
				arg_265_1.mask_.color = var_268_10
			end

			if arg_265_1.time_ >= var_268_8 + var_268_9 and arg_265_1.time_ < var_268_8 + var_268_9 + arg_268_0 then
				local var_268_11 = Color.New(0, 0, 0)

				arg_265_1.mask_.enabled = false
				var_268_11.a = 0
				arg_265_1.mask_.color = var_268_11
			end

			local var_268_12 = arg_265_1.actors_["1197ui_story"].transform

			if 1.95 < arg_265_1.time_ and arg_265_1.time_ <= 1.95 + arg_268_0 then
				arg_265_1.var_.moveOldPos1197ui_story = var_268_12.localPosition
			end

			local var_268_13 = 0.001

			if 1.95 <= arg_265_1.time_ and arg_265_1.time_ < 1.95 + var_268_13 then
				var_268_12.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1197ui_story, Vector3.New(0, 100, 0), (arg_265_1.time_ - 1.95) / var_268_13)
				var_268_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_12.position).x, (manager.ui.mainCamera.transform.position - var_268_12.position).y, (manager.ui.mainCamera.transform.position - var_268_12.position).z)
				var_268_12.localEulerAngles.z = 0
				var_268_12.localEulerAngles.x = 0
				var_268_12.localEulerAngles = var_268_12.localEulerAngles
			end

			if arg_265_1.time_ >= 1.95 + var_268_13 and arg_265_1.time_ < 1.95 + var_268_13 + arg_268_0 then
				var_268_12.localPosition = Vector3.New(0, 100, 0)
				var_268_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_12.position).x, (manager.ui.mainCamera.transform.position - var_268_12.position).y, (manager.ui.mainCamera.transform.position - var_268_12.position).z)
				var_268_12.localEulerAngles.z = 0
				var_268_12.localEulerAngles.x = 0
				var_268_12.localEulerAngles = var_268_12.localEulerAngles
			end

			local var_268_14 = arg_265_1.actors_["1197ui_story"]

			if 1.95 < arg_265_1.time_ and arg_265_1.time_ <= 1.95 + arg_268_0 and not isNil(var_268_14) and arg_265_1.var_.characterEffect1197ui_story == nil then
				arg_265_1.var_.characterEffect1197ui_story = var_268_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_15 = 0.05

			if 1.95 <= arg_265_1.time_ and arg_265_1.time_ < 1.95 + var_268_15 and not isNil(var_268_14) then
				if arg_265_1.var_.characterEffect1197ui_story and not isNil(var_268_14) then
					arg_265_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_265_1.time_ - 1.95) / var_268_15)
				end
			end

			if arg_265_1.time_ >= 1.95 + var_268_15 and arg_265_1.time_ < 1.95 + var_268_15 + arg_268_0 and not isNil(var_268_14) and arg_265_1.var_.characterEffect1197ui_story then
				arg_265_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			if arg_265_1.frameCnt_ <= 1 then
				arg_265_1.dialog_:SetActive(false)
			end

			local var_268_16 = 4
			local var_268_17 = 0.05

			if 4 < arg_265_1.time_ and arg_265_1.time_ <= var_268_16 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0

				arg_265_1.dialog_:SetActive(true)

				arg_265_1.dialogCg_.alpha = 0

				local var_268_18 = LeanTween.value(arg_265_1.dialog_, 0, 1, 0.3)

				var_268_18:setOnUpdate(LuaHelper.FloatAction(function(arg_269_0)
					arg_265_1.dialogCg_.alpha = arg_269_0
				end))
				var_268_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_265_1.dialog_)
					var_268_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_265_1.duration_ = arg_265_1.duration_ + 0.3

				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_19 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(1109702064).content)

				arg_265_1.text_.text = var_268_19

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_21 = 2 <= 0 and var_268_17 or var_268_17 * (utf8.len(var_268_19) / 2)

				if (2 <= 0 and var_268_17 or var_268_17 * (utf8.len(var_268_19) / 2)) > 0 and var_268_17 < var_268_21 then
					arg_265_1.talkMaxDuration = var_268_21
					var_268_16 = var_268_16 + 0.3

					if var_268_21 + var_268_16 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_21 + var_268_16
					end
				end

				arg_265_1.text_.text = var_268_19
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_22 = var_268_16 + 0.3
			local var_268_23 = math.max(var_268_17, arg_265_1.talkMaxDuration)

			if var_268_16 + 0.3 <= arg_265_1.time_ and arg_265_1.time_ < var_268_22 + var_268_23 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_22) / var_268_23

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_22 + var_268_23 and arg_265_1.time_ < var_268_22 + var_268_23 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.95,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play1109702065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 1109702065
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play1109702066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0.125

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

				local var_274_1 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(1109702065).content)

				arg_271_1.text_.text = var_274_1

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_3 = 5 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 5)

				if (5 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 5)) > 0 and var_274_0 < var_274_3 then
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
	Play1109702066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 1109702066
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play1109702067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0.55

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_1 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(1109702066).content)

				arg_275_1.text_.text = var_278_1

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_3 = 22 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_1) / 22)

				if (22 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_1) / 22)) > 0 and var_278_0 < var_278_3 then
					arg_275_1.talkMaxDuration = var_278_3

					if var_278_3 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_3 + 0
					end
				end

				arg_275_1.text_.text = var_278_1
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_4 = math.max(var_278_0, arg_275_1.talkMaxDuration)

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_4 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - 0) / var_278_4

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= 0 + var_278_4 and arg_275_1.time_ < 0 + var_278_4 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play1109702067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 1109702067
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play1109702068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 0.7

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
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

				local var_282_1 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(1109702067).content)

				arg_279_1.text_.text = var_282_1

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_3 = 28 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_1) / 28)

				if (28 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_1) / 28)) > 0 and var_282_0 < var_282_3 then
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
	Play1109702068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 1109702068
		arg_283_1.duration_ = 6.47

		local var_283_0 = {
			zh = 4.833,
			ja = 6.466
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
				arg_283_0:Play1109702069(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos1197ui_story = arg_283_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_286_0 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 then
				arg_283_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_283_1.time_ - 0) / var_286_0)
				arg_283_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1197ui_story"].transform.position).z)
				arg_283_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["1197ui_story"].transform.localEulerAngles = arg_283_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 then
				arg_283_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, -0.545, -6.3)
				arg_283_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1197ui_story"].transform.position).z)
				arg_283_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["1197ui_story"].transform.localEulerAngles = arg_283_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_286_1 = arg_283_1.actors_["1197ui_story"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect1197ui_story == nil then
				arg_283_1.var_.characterEffect1197ui_story = var_286_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_2 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_2 and not isNil(var_286_1) then
				if arg_283_1.var_.characterEffect1197ui_story and not isNil(var_286_1) then
					arg_283_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= 0 + var_286_2 and arg_283_1.time_ < 0 + var_286_2 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect1197ui_story then
				arg_283_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action7_1")
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_286_4 = 0
			local var_286_5 = 0.45

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_4 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_6 = arg_283_1:GetWordFromCfg(1109702068)
				local var_286_7 = arg_283_1:FormatText(var_286_6.content)

				arg_283_1.text_.text = var_286_7

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_9 = 18 <= 0 and var_286_5 or var_286_5 * (utf8.len(var_286_7) / 18)

				if (18 <= 0 and var_286_5 or var_286_5 * (utf8.len(var_286_7) / 18)) > 0 and var_286_5 < var_286_9 then
					arg_283_1.talkMaxDuration = var_286_9

					if var_286_9 + var_286_4 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_9 + var_286_4
					end
				end

				arg_283_1.text_.text = var_286_7
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702068", "story_v_side_new_1109702.awb") ~= 0 then
					local var_286_10 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702068", "story_v_side_new_1109702.awb") / 1000

					if var_286_10 + var_286_4 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_10 + var_286_4
					end

					if var_286_6.prefab_name ~= "" and arg_283_1.actors_[var_286_6.prefab_name] ~= nil then
						local var_286_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_6.prefab_name].transform, "story_v_side_new_1109702", "1109702068", "story_v_side_new_1109702.awb")

						arg_283_1:RecordAudio("1109702068", var_286_11)
						arg_283_1:RecordAudio("1109702068", var_286_11)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702068", "story_v_side_new_1109702.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702068", "story_v_side_new_1109702.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_12 = math.max(var_286_5, arg_283_1.talkMaxDuration)

			if var_286_4 <= arg_283_1.time_ and arg_283_1.time_ < var_286_4 + var_286_12 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_4) / var_286_12

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_4 + var_286_12 and arg_283_1.time_ < var_286_4 + var_286_12 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_283_1:InitPlayNodeList()
	end,
	Play1109702069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 1109702069
		arg_287_1.duration_ = 4.6

		local var_287_0 = {
			zh = 4.6,
			ja = 4.266
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
				arg_287_0:Play1109702070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_290_0 = 0
			local var_290_1 = 0.4

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_2 = arg_287_1:GetWordFromCfg(1109702069)
				local var_290_3 = arg_287_1:FormatText(var_290_2.content)

				arg_287_1.text_.text = var_290_3

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_5 = 16 <= 0 and var_290_1 or var_290_1 * (utf8.len(var_290_3) / 16)

				if (16 <= 0 and var_290_1 or var_290_1 * (utf8.len(var_290_3) / 16)) > 0 and var_290_1 < var_290_5 then
					arg_287_1.talkMaxDuration = var_290_5

					if var_290_5 + var_290_0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_5 + var_290_0
					end
				end

				arg_287_1.text_.text = var_290_3
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702069", "story_v_side_new_1109702.awb") ~= 0 then
					local var_290_6 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702069", "story_v_side_new_1109702.awb") / 1000

					if var_290_6 + var_290_0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_6 + var_290_0
					end

					if var_290_2.prefab_name ~= "" and arg_287_1.actors_[var_290_2.prefab_name] ~= nil then
						local var_290_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_2.prefab_name].transform, "story_v_side_new_1109702", "1109702069", "story_v_side_new_1109702.awb")

						arg_287_1:RecordAudio("1109702069", var_290_7)
						arg_287_1:RecordAudio("1109702069", var_290_7)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702069", "story_v_side_new_1109702.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702069", "story_v_side_new_1109702.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_8 = math.max(var_290_1, arg_287_1.talkMaxDuration)

			if var_290_0 <= arg_287_1.time_ and arg_287_1.time_ < var_290_0 + var_290_8 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_0) / var_290_8

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_0 + var_290_8 and arg_287_1.time_ < var_290_0 + var_290_8 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play1109702070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 1109702070
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play1109702071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos1197ui_story = arg_291_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_294_0 = 0.001

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 then
				arg_291_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_291_1.time_ - 0) / var_294_0)
				arg_291_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_291_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1197ui_story"].transform.position).z)
				arg_291_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_291_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_291_1.actors_["1197ui_story"].transform.localEulerAngles = arg_291_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 then
				arg_291_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, -0.545, -6.3)
				arg_291_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_291_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1197ui_story"].transform.position).z)
				arg_291_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_291_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_291_1.actors_["1197ui_story"].transform.localEulerAngles = arg_291_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_294_1 = arg_291_1.actors_["1197ui_story"]

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(var_294_1) and arg_291_1.var_.characterEffect1197ui_story == nil then
				arg_291_1.var_.characterEffect1197ui_story = var_294_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_2 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_2 and not isNil(var_294_1) then
				if arg_291_1.var_.characterEffect1197ui_story and not isNil(var_294_1) then
					arg_291_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_291_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_291_1.time_ - 0) / var_294_2)
				end
			end

			if arg_291_1.time_ >= 0 + var_294_2 and arg_291_1.time_ < 0 + var_294_2 + arg_294_0 and not isNil(var_294_1) and arg_291_1.var_.characterEffect1197ui_story then
				arg_291_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_291_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_294_3 = 0
			local var_294_4 = 0.05

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_3 + arg_294_0 then
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

				local var_294_5 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(1109702070).content)

				arg_291_1.text_.text = var_294_5

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_7 = 2 <= 0 and var_294_4 or var_294_4 * (utf8.len(var_294_5) / 2)

				if (2 <= 0 and var_294_4 or var_294_4 * (utf8.len(var_294_5) / 2)) > 0 and var_294_4 < var_294_7 then
					arg_291_1.talkMaxDuration = var_294_7

					if var_294_7 + var_294_3 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_7 + var_294_3
					end
				end

				arg_291_1.text_.text = var_294_5
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_8 = math.max(var_294_4, arg_291_1.talkMaxDuration)

			if var_294_3 <= arg_291_1.time_ and arg_291_1.time_ < var_294_3 + var_294_8 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_3) / var_294_8

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_3 + var_294_8 and arg_291_1.time_ < var_294_3 + var_294_8 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play1109702071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 1109702071
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play1109702072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0.55

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_1 = arg_295_1:FormatText(arg_295_1:GetWordFromCfg(1109702071).content)

				arg_295_1.text_.text = var_298_1

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_3 = 22 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_1) / 22)

				if (22 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_1) / 22)) > 0 and var_298_0 < var_298_3 then
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
	Play1109702072 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 1109702072
		arg_299_1.duration_ = 4.73

		local var_299_0 = {
			zh = 4.733,
			ja = 2.433
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
				arg_299_0:Play1109702073(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos1197ui_story = arg_299_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_302_0 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_0 then
				arg_299_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_299_1.time_ - 0) / var_302_0)
				arg_299_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_299_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1197ui_story"].transform.position).z)
				arg_299_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_299_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_299_1.actors_["1197ui_story"].transform.localEulerAngles = arg_299_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_299_1.time_ >= 0 + var_302_0 and arg_299_1.time_ < 0 + var_302_0 + arg_302_0 then
				arg_299_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, -0.545, -6.3)
				arg_299_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_299_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1197ui_story"].transform.position).z)
				arg_299_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_299_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_299_1.actors_["1197ui_story"].transform.localEulerAngles = arg_299_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_302_1 = arg_299_1.actors_["1197ui_story"]

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(var_302_1) and arg_299_1.var_.characterEffect1197ui_story == nil then
				arg_299_1.var_.characterEffect1197ui_story = var_302_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_2 = 0.200000002980232

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_2 and not isNil(var_302_1) then
				if arg_299_1.var_.characterEffect1197ui_story and not isNil(var_302_1) then
					arg_299_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= 0 + var_302_2 and arg_299_1.time_ < 0 + var_302_2 + arg_302_0 and not isNil(var_302_1) and arg_299_1.var_.characterEffect1197ui_story then
				arg_299_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action7_2")
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_302_4 = 0
			local var_302_5 = 0.3

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_4 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_6 = arg_299_1:GetWordFromCfg(1109702072)
				local var_302_7 = arg_299_1:FormatText(var_302_6.content)

				arg_299_1.text_.text = var_302_7

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_9 = 12 <= 0 and var_302_5 or var_302_5 * (utf8.len(var_302_7) / 12)

				if (12 <= 0 and var_302_5 or var_302_5 * (utf8.len(var_302_7) / 12)) > 0 and var_302_5 < var_302_9 then
					arg_299_1.talkMaxDuration = var_302_9

					if var_302_9 + var_302_4 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_9 + var_302_4
					end
				end

				arg_299_1.text_.text = var_302_7
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702072", "story_v_side_new_1109702.awb") ~= 0 then
					local var_302_10 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702072", "story_v_side_new_1109702.awb") / 1000

					if var_302_10 + var_302_4 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_10 + var_302_4
					end

					if var_302_6.prefab_name ~= "" and arg_299_1.actors_[var_302_6.prefab_name] ~= nil then
						local var_302_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_6.prefab_name].transform, "story_v_side_new_1109702", "1109702072", "story_v_side_new_1109702.awb")

						arg_299_1:RecordAudio("1109702072", var_302_11)
						arg_299_1:RecordAudio("1109702072", var_302_11)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702072", "story_v_side_new_1109702.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702072", "story_v_side_new_1109702.awb")
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
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play1109702073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 1109702073
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play1109702074(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(arg_303_1.actors_["1197ui_story"]) and arg_303_1.var_.characterEffect1197ui_story == nil then
				arg_303_1.var_.characterEffect1197ui_story = arg_303_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_0 = 0.200000002980232

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 and not isNil(arg_303_1.actors_["1197ui_story"]) then
				if arg_303_1.var_.characterEffect1197ui_story and not isNil(arg_303_1.actors_["1197ui_story"]) then
					arg_303_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_303_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_303_1.time_ - 0) / var_306_0)
				end
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 and not isNil(arg_303_1.actors_["1197ui_story"]) and arg_303_1.var_.characterEffect1197ui_story then
				arg_303_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_303_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_306_1 = 0
			local var_306_2 = 0.7

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 then
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

				local var_306_3 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(1109702073).content)

				arg_303_1.text_.text = var_306_3

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_5 = 28 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_3) / 28)

				if (28 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_3) / 28)) > 0 and var_306_2 < var_306_5 then
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
	Play1109702074 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 1109702074
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play1109702075(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0.6

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

				local var_310_1 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(1109702074).content)

				arg_307_1.text_.text = var_310_1

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_3 = 24 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_1) / 24)

				if (24 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_1) / 24)) > 0 and var_310_0 < var_310_3 then
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
	Play1109702075 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 1109702075
		arg_311_1.duration_ = 5.97

		local var_311_0 = {
			zh = 5.966,
			ja = 4
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
				arg_311_0:Play1109702076(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.var_.moveOldPos1197ui_story = arg_311_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_314_0 = 0.001

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 then
				arg_311_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_311_1.time_ - 0) / var_314_0)
				arg_311_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_311_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1197ui_story"].transform.position).z)
				arg_311_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_311_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_311_1.actors_["1197ui_story"].transform.localEulerAngles = arg_311_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 then
				arg_311_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, -0.545, -6.3)
				arg_311_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_311_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1197ui_story"].transform.position).z)
				arg_311_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_311_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_311_1.actors_["1197ui_story"].transform.localEulerAngles = arg_311_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_314_1 = arg_311_1.actors_["1197ui_story"]

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(var_314_1) and arg_311_1.var_.characterEffect1197ui_story == nil then
				arg_311_1.var_.characterEffect1197ui_story = var_314_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_2 = 0.200000002980232

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_2 and not isNil(var_314_1) then
				if arg_311_1.var_.characterEffect1197ui_story and not isNil(var_314_1) then
					arg_311_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= 0 + var_314_2 and arg_311_1.time_ < 0 + var_314_2 + arg_314_0 and not isNil(var_314_1) and arg_311_1.var_.characterEffect1197ui_story then
				arg_311_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action7_1")
			end

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_314_4 = 0
			local var_314_5 = 0.4

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_4 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_6 = arg_311_1:GetWordFromCfg(1109702075)
				local var_314_7 = arg_311_1:FormatText(var_314_6.content)

				arg_311_1.text_.text = var_314_7

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_9 = 16 <= 0 and var_314_5 or var_314_5 * (utf8.len(var_314_7) / 16)

				if (16 <= 0 and var_314_5 or var_314_5 * (utf8.len(var_314_7) / 16)) > 0 and var_314_5 < var_314_9 then
					arg_311_1.talkMaxDuration = var_314_9

					if var_314_9 + var_314_4 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_9 + var_314_4
					end
				end

				arg_311_1.text_.text = var_314_7
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702075", "story_v_side_new_1109702.awb") ~= 0 then
					local var_314_10 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702075", "story_v_side_new_1109702.awb") / 1000

					if var_314_10 + var_314_4 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_10 + var_314_4
					end

					if var_314_6.prefab_name ~= "" and arg_311_1.actors_[var_314_6.prefab_name] ~= nil then
						local var_314_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_6.prefab_name].transform, "story_v_side_new_1109702", "1109702075", "story_v_side_new_1109702.awb")

						arg_311_1:RecordAudio("1109702075", var_314_11)
						arg_311_1:RecordAudio("1109702075", var_314_11)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702075", "story_v_side_new_1109702.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702075", "story_v_side_new_1109702.awb")
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
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_311_1:InitPlayNodeList()
	end,
	Play1109702076 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 1109702076
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play1109702077(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(arg_315_1.actors_["1197ui_story"]) and arg_315_1.var_.characterEffect1197ui_story == nil then
				arg_315_1.var_.characterEffect1197ui_story = arg_315_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_0 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 and not isNil(arg_315_1.actors_["1197ui_story"]) then
				if arg_315_1.var_.characterEffect1197ui_story and not isNil(arg_315_1.actors_["1197ui_story"]) then
					arg_315_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_315_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_315_1.time_ - 0) / var_318_0)
				end
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 and not isNil(arg_315_1.actors_["1197ui_story"]) and arg_315_1.var_.characterEffect1197ui_story then
				arg_315_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_315_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_318_1 = 0
			local var_318_2 = 0.25

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, true)
				arg_315_1.iconController_:SetSelectedState("hero")

				arg_315_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_315_1.callingController_:SetSelectedState("normal")

				arg_315_1.keyicon_.color = Color.New(1, 1, 1)
				arg_315_1.icon_.color = Color.New(1, 1, 1)

				local var_318_3 = arg_315_1:FormatText(arg_315_1:GetWordFromCfg(1109702076).content)

				arg_315_1.text_.text = var_318_3

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_5 = 10 <= 0 and var_318_2 or var_318_2 * (utf8.len(var_318_3) / 10)

				if (10 <= 0 and var_318_2 or var_318_2 * (utf8.len(var_318_3) / 10)) > 0 and var_318_2 < var_318_5 then
					arg_315_1.talkMaxDuration = var_318_5

					if var_318_5 + var_318_1 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_5 + var_318_1
					end
				end

				arg_315_1.text_.text = var_318_3
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_6 = math.max(var_318_2, arg_315_1.talkMaxDuration)

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_6 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_1) / var_318_6

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_1 + var_318_6 and arg_315_1.time_ < var_318_1 + var_318_6 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play1109702077 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 1109702077
		arg_319_1.duration_ = 3.77

		local var_319_0 = {
			zh = 3.566,
			ja = 3.766
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
				arg_319_0:Play1109702078(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.var_.moveOldPos1197ui_story = arg_319_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_322_0 = 0.001

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_0 then
				arg_319_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_319_1.time_ - 0) / var_322_0)
				arg_319_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_319_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["1197ui_story"].transform.position).z)
				arg_319_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_319_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_319_1.actors_["1197ui_story"].transform.localEulerAngles = arg_319_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_319_1.time_ >= 0 + var_322_0 and arg_319_1.time_ < 0 + var_322_0 + arg_322_0 then
				arg_319_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, -0.545, -6.3)
				arg_319_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_319_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["1197ui_story"].transform.position).z)
				arg_319_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_319_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_319_1.actors_["1197ui_story"].transform.localEulerAngles = arg_319_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_322_1 = arg_319_1.actors_["1197ui_story"]

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(var_322_1) and arg_319_1.var_.characterEffect1197ui_story == nil then
				arg_319_1.var_.characterEffect1197ui_story = var_322_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_2 = 0.200000002980232

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_2 and not isNil(var_322_1) then
				if arg_319_1.var_.characterEffect1197ui_story and not isNil(var_322_1) then
					arg_319_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_319_1.time_ >= 0 + var_322_2 and arg_319_1.time_ < 0 + var_322_2 + arg_322_0 and not isNil(var_322_1) and arg_319_1.var_.characterEffect1197ui_story then
				arg_319_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action7_2")
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_322_4 = 0
			local var_322_5 = 0.55

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_4 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_6 = arg_319_1:GetWordFromCfg(1109702077)
				local var_322_7 = arg_319_1:FormatText(var_322_6.content)

				arg_319_1.text_.text = var_322_7

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_9 = 22 <= 0 and var_322_5 or var_322_5 * (utf8.len(var_322_7) / 22)

				if (22 <= 0 and var_322_5 or var_322_5 * (utf8.len(var_322_7) / 22)) > 0 and var_322_5 < var_322_9 then
					arg_319_1.talkMaxDuration = var_322_9

					if var_322_9 + var_322_4 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_9 + var_322_4
					end
				end

				arg_319_1.text_.text = var_322_7
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702077", "story_v_side_new_1109702.awb") ~= 0 then
					local var_322_10 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702077", "story_v_side_new_1109702.awb") / 1000

					if var_322_10 + var_322_4 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_10 + var_322_4
					end

					if var_322_6.prefab_name ~= "" and arg_319_1.actors_[var_322_6.prefab_name] ~= nil then
						local var_322_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_6.prefab_name].transform, "story_v_side_new_1109702", "1109702077", "story_v_side_new_1109702.awb")

						arg_319_1:RecordAudio("1109702077", var_322_11)
						arg_319_1:RecordAudio("1109702077", var_322_11)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702077", "story_v_side_new_1109702.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702077", "story_v_side_new_1109702.awb")
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

		arg_319_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_319_1:InitPlayNodeList()
	end,
	Play1109702078 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 1109702078
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play1109702079(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(arg_323_1.actors_["1197ui_story"]) and arg_323_1.var_.characterEffect1197ui_story == nil then
				arg_323_1.var_.characterEffect1197ui_story = arg_323_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_0 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 and not isNil(arg_323_1.actors_["1197ui_story"]) then
				if arg_323_1.var_.characterEffect1197ui_story and not isNil(arg_323_1.actors_["1197ui_story"]) then
					arg_323_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_323_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_323_1.time_ - 0) / var_326_0)
				end
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 and not isNil(arg_323_1.actors_["1197ui_story"]) and arg_323_1.var_.characterEffect1197ui_story then
				arg_323_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_323_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_326_1 = 0
			local var_326_2 = 0.35

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 then
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

				local var_326_3 = arg_323_1:FormatText(arg_323_1:GetWordFromCfg(1109702078).content)

				arg_323_1.text_.text = var_326_3

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_5 = 14 <= 0 and var_326_2 or var_326_2 * (utf8.len(var_326_3) / 14)

				if (14 <= 0 and var_326_2 or var_326_2 * (utf8.len(var_326_3) / 14)) > 0 and var_326_2 < var_326_5 then
					arg_323_1.talkMaxDuration = var_326_5

					if var_326_5 + var_326_1 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_5 + var_326_1
					end
				end

				arg_323_1.text_.text = var_326_3
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_6 = math.max(var_326_2, arg_323_1.talkMaxDuration)

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_6 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_1) / var_326_6

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_1 + var_326_6 and arg_323_1.time_ < var_326_1 + var_326_6 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play1109702079 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 1109702079
		arg_327_1.duration_ = 3.47

		local var_327_0 = {
			zh = 3.466,
			ja = 2.6
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
				arg_327_0:Play1109702080(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(arg_327_1.actors_["1197ui_story"]) and arg_327_1.var_.characterEffect1197ui_story == nil then
				arg_327_1.var_.characterEffect1197ui_story = arg_327_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_0 = 0.200000002980232

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 and not isNil(arg_327_1.actors_["1197ui_story"]) then
				if arg_327_1.var_.characterEffect1197ui_story and not isNil(arg_327_1.actors_["1197ui_story"]) then
					arg_327_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 and not isNil(arg_327_1.actors_["1197ui_story"]) and arg_327_1.var_.characterEffect1197ui_story then
				arg_327_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_330_2 = 0
			local var_330_3 = 0.55

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_2 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_4 = arg_327_1:GetWordFromCfg(1109702079)
				local var_330_5 = arg_327_1:FormatText(var_330_4.content)

				arg_327_1.text_.text = var_330_5

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_7 = 22 <= 0 and var_330_3 or var_330_3 * (utf8.len(var_330_5) / 22)

				if (22 <= 0 and var_330_3 or var_330_3 * (utf8.len(var_330_5) / 22)) > 0 and var_330_3 < var_330_7 then
					arg_327_1.talkMaxDuration = var_330_7

					if var_330_7 + var_330_2 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_7 + var_330_2
					end
				end

				arg_327_1.text_.text = var_330_5
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702079", "story_v_side_new_1109702.awb") ~= 0 then
					local var_330_8 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702079", "story_v_side_new_1109702.awb") / 1000

					if var_330_8 + var_330_2 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_8 + var_330_2
					end

					if var_330_4.prefab_name ~= "" and arg_327_1.actors_[var_330_4.prefab_name] ~= nil then
						local var_330_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_4.prefab_name].transform, "story_v_side_new_1109702", "1109702079", "story_v_side_new_1109702.awb")

						arg_327_1:RecordAudio("1109702079", var_330_9)
						arg_327_1:RecordAudio("1109702079", var_330_9)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702079", "story_v_side_new_1109702.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702079", "story_v_side_new_1109702.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_10 = math.max(var_330_3, arg_327_1.talkMaxDuration)

			if var_330_2 <= arg_327_1.time_ and arg_327_1.time_ < var_330_2 + var_330_10 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_2) / var_330_10

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_2 + var_330_10 and arg_327_1.time_ < var_330_2 + var_330_10 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play1109702080 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 1109702080
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play1109702081(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(arg_331_1.actors_["1197ui_story"]) and arg_331_1.var_.characterEffect1197ui_story == nil then
				arg_331_1.var_.characterEffect1197ui_story = arg_331_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_0 = 0.200000002980232

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 and not isNil(arg_331_1.actors_["1197ui_story"]) then
				if arg_331_1.var_.characterEffect1197ui_story and not isNil(arg_331_1.actors_["1197ui_story"]) then
					arg_331_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_331_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_331_1.time_ - 0) / var_334_0)
				end
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 and not isNil(arg_331_1.actors_["1197ui_story"]) and arg_331_1.var_.characterEffect1197ui_story then
				arg_331_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_331_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_334_1 = 0
			local var_334_2 = 0.7

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 then
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

				local var_334_3 = arg_331_1:FormatText(arg_331_1:GetWordFromCfg(1109702080).content)

				arg_331_1.text_.text = var_334_3

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_5 = 28 <= 0 and var_334_2 or var_334_2 * (utf8.len(var_334_3) / 28)

				if (28 <= 0 and var_334_2 or var_334_2 * (utf8.len(var_334_3) / 28)) > 0 and var_334_2 < var_334_5 then
					arg_331_1.talkMaxDuration = var_334_5

					if var_334_5 + var_334_1 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_5 + var_334_1
					end
				end

				arg_331_1.text_.text = var_334_3
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_6 = math.max(var_334_2, arg_331_1.talkMaxDuration)

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_6 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_1) / var_334_6

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_1 + var_334_6 and arg_331_1.time_ < var_334_1 + var_334_6 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play1109702081 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 1109702081
		arg_335_1.duration_ = 6.13

		local var_335_0 = {
			zh = 6.133,
			ja = 6.1
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
				arg_335_0:Play1109702082(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(arg_335_1.actors_["1197ui_story"]) and arg_335_1.var_.characterEffect1197ui_story == nil then
				arg_335_1.var_.characterEffect1197ui_story = arg_335_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_0 = 0.200000002980232

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_0 and not isNil(arg_335_1.actors_["1197ui_story"]) then
				if arg_335_1.var_.characterEffect1197ui_story and not isNil(arg_335_1.actors_["1197ui_story"]) then
					arg_335_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_335_1.time_ >= 0 + var_338_0 and arg_335_1.time_ < 0 + var_338_0 + arg_338_0 and not isNil(arg_335_1.actors_["1197ui_story"]) and arg_335_1.var_.characterEffect1197ui_story then
				arg_335_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action9_1")
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_338_2 = 0
			local var_338_3 = 0.8

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_2 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_4 = arg_335_1:GetWordFromCfg(1109702081)
				local var_338_5 = arg_335_1:FormatText(var_338_4.content)

				arg_335_1.text_.text = var_338_5

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_7 = 32 <= 0 and var_338_3 or var_338_3 * (utf8.len(var_338_5) / 32)

				if (32 <= 0 and var_338_3 or var_338_3 * (utf8.len(var_338_5) / 32)) > 0 and var_338_3 < var_338_7 then
					arg_335_1.talkMaxDuration = var_338_7

					if var_338_7 + var_338_2 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_7 + var_338_2
					end
				end

				arg_335_1.text_.text = var_338_5
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702081", "story_v_side_new_1109702.awb") ~= 0 then
					local var_338_8 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702081", "story_v_side_new_1109702.awb") / 1000

					if var_338_8 + var_338_2 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_8 + var_338_2
					end

					if var_338_4.prefab_name ~= "" and arg_335_1.actors_[var_338_4.prefab_name] ~= nil then
						local var_338_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_4.prefab_name].transform, "story_v_side_new_1109702", "1109702081", "story_v_side_new_1109702.awb")

						arg_335_1:RecordAudio("1109702081", var_338_9)
						arg_335_1:RecordAudio("1109702081", var_338_9)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702081", "story_v_side_new_1109702.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702081", "story_v_side_new_1109702.awb")
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
	Play1109702082 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 1109702082
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play1109702083(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(arg_339_1.actors_["1197ui_story"]) and arg_339_1.var_.characterEffect1197ui_story == nil then
				arg_339_1.var_.characterEffect1197ui_story = arg_339_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_0 = 0.200000002980232

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 and not isNil(arg_339_1.actors_["1197ui_story"]) then
				if arg_339_1.var_.characterEffect1197ui_story and not isNil(arg_339_1.actors_["1197ui_story"]) then
					arg_339_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_339_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_339_1.time_ - 0) / var_342_0)
				end
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 and not isNil(arg_339_1.actors_["1197ui_story"]) and arg_339_1.var_.characterEffect1197ui_story then
				arg_339_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_339_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_342_1 = arg_339_1.actors_["1197ui_story"].transform

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.moveOldPos1197ui_story = var_342_1.localPosition
			end

			local var_342_2 = 0.001

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_2 then
				var_342_1.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1197ui_story, Vector3.New(0, 100, 0), (arg_339_1.time_ - 0) / var_342_2)
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

			local var_342_3 = 0
			local var_342_4 = 0.95

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_3 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, false)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_5 = arg_339_1:FormatText(arg_339_1:GetWordFromCfg(1109702082).content)

				arg_339_1.text_.text = var_342_5

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_7 = 38 <= 0 and var_342_4 or var_342_4 * (utf8.len(var_342_5) / 38)

				if (38 <= 0 and var_342_4 or var_342_4 * (utf8.len(var_342_5) / 38)) > 0 and var_342_4 < var_342_7 then
					arg_339_1.talkMaxDuration = var_342_7

					if var_342_7 + var_342_3 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_7 + var_342_3
					end
				end

				arg_339_1.text_.text = var_342_5
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_8 = math.max(var_342_4, arg_339_1.talkMaxDuration)

			if var_342_3 <= arg_339_1.time_ and arg_339_1.time_ < var_342_3 + var_342_8 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_3) / var_342_8

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_3 + var_342_8 and arg_339_1.time_ < var_342_3 + var_342_8 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
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
	Play1109702083 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 1109702083
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play1109702084(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 0.425

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, true)
				arg_343_1.iconController_:SetSelectedState("hero")

				arg_343_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_343_1.callingController_:SetSelectedState("normal")

				arg_343_1.keyicon_.color = Color.New(1, 1, 1)
				arg_343_1.icon_.color = Color.New(1, 1, 1)

				local var_346_1 = arg_343_1:FormatText(arg_343_1:GetWordFromCfg(1109702083).content)

				arg_343_1.text_.text = var_346_1

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_3 = 17 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_1) / 17)

				if (17 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_1) / 17)) > 0 and var_346_0 < var_346_3 then
					arg_343_1.talkMaxDuration = var_346_3

					if var_346_3 + 0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_3 + 0
					end
				end

				arg_343_1.text_.text = var_346_1
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_4 = math.max(var_346_0, arg_343_1.talkMaxDuration)

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_4 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - 0) / var_346_4

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= 0 + var_346_4 and arg_343_1.time_ < 0 + var_346_4 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play1109702084 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 1109702084
		arg_347_1.duration_ = 9

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play1109702085(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if arg_347_1.bgs_.I06b == nil then
				local var_350_0 = Object.Instantiate(arg_347_1.paintGo_)

				var_350_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I06b")
				var_350_0.name = "I06b"
				var_350_0.transform.parent = arg_347_1.stage_.transform
				var_350_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_347_1.bgs_.I06b = var_350_0
			end

			if 2 < arg_347_1.time_ and arg_347_1.time_ <= 2 + arg_350_0 then
				local var_350_1 = arg_347_1.bgs_.I06b

				arg_347_1.bgs_.I06b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_350_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_350_2 = var_350_1:GetComponent("SpriteRenderer")

				if var_350_2 and var_350_2.sprite then
					local var_350_3 = 2 * (var_350_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_350_1.transform.localScale = Vector3.New(var_350_3 / var_350_2.sprite.bounds.size.y < var_350_3 * manager.ui.mainCameraCom_.aspect / var_350_2.sprite.bounds.size.x and var_350_3 * manager.ui.mainCameraCom_.aspect / var_350_2.sprite.bounds.size.x or var_350_3 / var_350_2.sprite.bounds.size.y, var_350_3 / var_350_2.sprite.bounds.size.y < var_350_3 * manager.ui.mainCameraCom_.aspect / var_350_2.sprite.bounds.size.x and var_350_3 * manager.ui.mainCameraCom_.aspect / var_350_2.sprite.bounds.size.x or var_350_3 / var_350_2.sprite.bounds.size.y, 0)
				end

				for iter_350_0, iter_350_1 in pairs(arg_347_1.bgs_) do
					if iter_350_0 ~= "I06b" then
						iter_350_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_350_4 = 3.999999999999

			if 3.999999999999 < arg_347_1.time_ and arg_347_1.time_ <= var_350_4 + arg_350_0 then
				arg_347_1.allBtn_.enabled = false
			end

			if arg_347_1.time_ >= var_350_4 + 0.3 and arg_347_1.time_ < var_350_4 + 0.3 + arg_350_0 then
				arg_347_1.allBtn_.enabled = true
			end

			local var_350_5 = 0

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_5 + arg_350_0 then
				arg_347_1.mask_.enabled = true
				arg_347_1.mask_.raycastTarget = true

				arg_347_1:SetGaussion(false)
			end

			local var_350_6 = 2

			if var_350_5 <= arg_347_1.time_ and arg_347_1.time_ < var_350_5 + var_350_6 then
				local var_350_7 = Color.New(0, 0, 0)

				var_350_7.a = Mathf.Lerp(0, 1, (arg_347_1.time_ - var_350_5) / var_350_6)
				arg_347_1.mask_.color = var_350_7
			end

			if arg_347_1.time_ >= var_350_5 + var_350_6 and arg_347_1.time_ < var_350_5 + var_350_6 + arg_350_0 then
				local var_350_8 = Color.New(0, 0, 0)

				var_350_8.a = 1
				arg_347_1.mask_.color = var_350_8
			end

			local var_350_9 = 2

			if 2 < arg_347_1.time_ and arg_347_1.time_ <= var_350_9 + arg_350_0 then
				arg_347_1.mask_.enabled = true
				arg_347_1.mask_.raycastTarget = true

				arg_347_1:SetGaussion(false)
			end

			local var_350_10 = 2

			if var_350_9 <= arg_347_1.time_ and arg_347_1.time_ < var_350_9 + var_350_10 then
				local var_350_11 = Color.New(0, 0, 0)

				var_350_11.a = Mathf.Lerp(1, 0, (arg_347_1.time_ - var_350_9) / var_350_10)
				arg_347_1.mask_.color = var_350_11
			end

			if arg_347_1.time_ >= var_350_9 + var_350_10 and arg_347_1.time_ < var_350_9 + var_350_10 + arg_350_0 then
				local var_350_12 = Color.New(0, 0, 0)

				arg_347_1.mask_.enabled = false
				var_350_12.a = 0
				arg_347_1.mask_.color = var_350_12
			end

			local var_350_13 = arg_347_1.actors_["1197ui_story"].transform

			if 1.98333333333333 < arg_347_1.time_ and arg_347_1.time_ <= 1.98333333333333 + arg_350_0 then
				arg_347_1.var_.moveOldPos1197ui_story = var_350_13.localPosition
			end

			local var_350_14 = 0.001

			if 1.98333333333333 <= arg_347_1.time_ and arg_347_1.time_ < 1.98333333333333 + var_350_14 then
				var_350_13.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos1197ui_story, Vector3.New(0, 100, 0), (arg_347_1.time_ - 1.98333333333333) / var_350_14)
				var_350_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_350_13.position).x, (manager.ui.mainCamera.transform.position - var_350_13.position).y, (manager.ui.mainCamera.transform.position - var_350_13.position).z)
				var_350_13.localEulerAngles.z = 0
				var_350_13.localEulerAngles.x = 0
				var_350_13.localEulerAngles = var_350_13.localEulerAngles
			end

			if arg_347_1.time_ >= 1.98333333333333 + var_350_14 and arg_347_1.time_ < 1.98333333333333 + var_350_14 + arg_350_0 then
				var_350_13.localPosition = Vector3.New(0, 100, 0)
				var_350_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_350_13.position).x, (manager.ui.mainCamera.transform.position - var_350_13.position).y, (manager.ui.mainCamera.transform.position - var_350_13.position).z)
				var_350_13.localEulerAngles.z = 0
				var_350_13.localEulerAngles.x = 0
				var_350_13.localEulerAngles = var_350_13.localEulerAngles
			end

			local var_350_15 = arg_347_1.actors_["1197ui_story"]

			if 1.98333333333333 < arg_347_1.time_ and arg_347_1.time_ <= 1.98333333333333 + arg_350_0 and not isNil(var_350_15) and arg_347_1.var_.characterEffect1197ui_story == nil then
				arg_347_1.var_.characterEffect1197ui_story = var_350_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_16 = 0.0166666666666667

			if 1.98333333333333 <= arg_347_1.time_ and arg_347_1.time_ < 1.98333333333333 + var_350_16 and not isNil(var_350_15) then
				if arg_347_1.var_.characterEffect1197ui_story and not isNil(var_350_15) then
					arg_347_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_347_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_347_1.time_ - 1.98333333333333) / var_350_16)
				end
			end

			if arg_347_1.time_ >= 1.98333333333333 + var_350_16 and arg_347_1.time_ < 1.98333333333333 + var_350_16 + arg_350_0 and not isNil(var_350_15) and arg_347_1.var_.characterEffect1197ui_story then
				arg_347_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_347_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			if arg_347_1.frameCnt_ <= 1 then
				arg_347_1.dialog_:SetActive(false)
			end

			local var_350_17 = 4
			local var_350_18 = 0.05

			if 4 < arg_347_1.time_ and arg_347_1.time_ <= var_350_17 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0

				arg_347_1.dialog_:SetActive(true)

				arg_347_1.dialogCg_.alpha = 0

				local var_350_19 = LeanTween.value(arg_347_1.dialog_, 0, 1, 0.3)

				var_350_19:setOnUpdate(LuaHelper.FloatAction(function(arg_351_0)
					arg_347_1.dialogCg_.alpha = arg_351_0
				end))
				var_350_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_347_1.dialog_)
					var_350_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_347_1.duration_ = arg_347_1.duration_ + 0.3

				SetActive(arg_347_1.leftNameGo_, false)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_20 = arg_347_1:FormatText(arg_347_1:GetWordFromCfg(1109702084).content)

				arg_347_1.text_.text = var_350_20

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_22 = 2 <= 0 and var_350_18 or var_350_18 * (utf8.len(var_350_20) / 2)

				if (2 <= 0 and var_350_18 or var_350_18 * (utf8.len(var_350_20) / 2)) > 0 and var_350_18 < var_350_22 then
					arg_347_1.talkMaxDuration = var_350_22
					var_350_17 = var_350_17 + 0.3

					if var_350_22 + var_350_17 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_22 + var_350_17
					end
				end

				arg_347_1.text_.text = var_350_20
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)
				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_23 = var_350_17 + 0.3
			local var_350_24 = math.max(var_350_18, arg_347_1.talkMaxDuration)

			if var_350_17 + 0.3 <= arg_347_1.time_ and arg_347_1.time_ < var_350_23 + var_350_24 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_23) / var_350_24

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_23 + var_350_24 and arg_347_1.time_ < var_350_23 + var_350_24 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_347_1:InitPlayNodeList()
	end,
	Play1109702085 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 1109702085
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play1109702086(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 0.325

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, true)
				arg_353_1.iconController_:SetSelectedState("hero")

				arg_353_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_353_1.callingController_:SetSelectedState("normal")

				arg_353_1.keyicon_.color = Color.New(1, 1, 1)
				arg_353_1.icon_.color = Color.New(1, 1, 1)

				local var_356_1 = arg_353_1:FormatText(arg_353_1:GetWordFromCfg(1109702085).content)

				arg_353_1.text_.text = var_356_1

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_3 = 13 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_1) / 13)

				if (13 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_1) / 13)) > 0 and var_356_0 < var_356_3 then
					arg_353_1.talkMaxDuration = var_356_3

					if var_356_3 + 0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_3 + 0
					end
				end

				arg_353_1.text_.text = var_356_1
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_4 = math.max(var_356_0, arg_353_1.talkMaxDuration)

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_4 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - 0) / var_356_4

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= 0 + var_356_4 and arg_353_1.time_ < 0 + var_356_4 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play1109702086 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 1109702086
		arg_357_1.duration_ = 3.6

		local var_357_0 = {
			zh = 3.2,
			ja = 3.6
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
				arg_357_0:Play1109702087(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.var_.moveOldPos1197ui_story = arg_357_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_360_0 = 0.001

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 then
				arg_357_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_357_1.time_ - 0) / var_360_0)
				arg_357_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1197ui_story"].transform.position).z)
				arg_357_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["1197ui_story"].transform.localEulerAngles = arg_357_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 then
				arg_357_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, -0.545, -6.3)
				arg_357_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1197ui_story"].transform.position).z)
				arg_357_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["1197ui_story"].transform.localEulerAngles = arg_357_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_360_1 = arg_357_1.actors_["1197ui_story"]

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(var_360_1) and arg_357_1.var_.characterEffect1197ui_story == nil then
				arg_357_1.var_.characterEffect1197ui_story = var_360_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_2 = 0.200000002980232

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_2 and not isNil(var_360_1) then
				if arg_357_1.var_.characterEffect1197ui_story and not isNil(var_360_1) then
					arg_357_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= 0 + var_360_2 and arg_357_1.time_ < 0 + var_360_2 + arg_360_0 and not isNil(var_360_1) and arg_357_1.var_.characterEffect1197ui_story then
				arg_357_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action1_1")
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_360_4 = 0
			local var_360_5 = 0.55

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_4 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_6 = arg_357_1:GetWordFromCfg(1109702086)
				local var_360_7 = arg_357_1:FormatText(var_360_6.content)

				arg_357_1.text_.text = var_360_7

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_9 = 22 <= 0 and var_360_5 or var_360_5 * (utf8.len(var_360_7) / 22)

				if (22 <= 0 and var_360_5 or var_360_5 * (utf8.len(var_360_7) / 22)) > 0 and var_360_5 < var_360_9 then
					arg_357_1.talkMaxDuration = var_360_9

					if var_360_9 + var_360_4 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_9 + var_360_4
					end
				end

				arg_357_1.text_.text = var_360_7
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702086", "story_v_side_new_1109702.awb") ~= 0 then
					local var_360_10 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702086", "story_v_side_new_1109702.awb") / 1000

					if var_360_10 + var_360_4 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_10 + var_360_4
					end

					if var_360_6.prefab_name ~= "" and arg_357_1.actors_[var_360_6.prefab_name] ~= nil then
						local var_360_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_6.prefab_name].transform, "story_v_side_new_1109702", "1109702086", "story_v_side_new_1109702.awb")

						arg_357_1:RecordAudio("1109702086", var_360_11)
						arg_357_1:RecordAudio("1109702086", var_360_11)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702086", "story_v_side_new_1109702.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702086", "story_v_side_new_1109702.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_12 = math.max(var_360_5, arg_357_1.talkMaxDuration)

			if var_360_4 <= arg_357_1.time_ and arg_357_1.time_ < var_360_4 + var_360_12 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_4) / var_360_12

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_4 + var_360_12 and arg_357_1.time_ < var_360_4 + var_360_12 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_357_1:InitPlayNodeList()
	end,
	Play1109702087 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 1109702087
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play1109702088(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(arg_361_1.actors_["1197ui_story"]) and arg_361_1.var_.characterEffect1197ui_story == nil then
				arg_361_1.var_.characterEffect1197ui_story = arg_361_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_0 = 0.200000002980232

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 and not isNil(arg_361_1.actors_["1197ui_story"]) then
				if arg_361_1.var_.characterEffect1197ui_story and not isNil(arg_361_1.actors_["1197ui_story"]) then
					arg_361_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_361_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_361_1.time_ - 0) / var_364_0)
				end
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 and not isNil(arg_361_1.actors_["1197ui_story"]) and arg_361_1.var_.characterEffect1197ui_story then
				arg_361_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_361_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_364_1 = 0
			local var_364_2 = 0.175

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

				local var_364_3 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(1109702087).content)

				arg_361_1.text_.text = var_364_3

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_5 = 7 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_3) / 7)

				if (7 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_3) / 7)) > 0 and var_364_2 < var_364_5 then
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
	Play1109702088 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 1109702088
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play1109702089(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 1.175

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, false)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_1 = arg_365_1:FormatText(arg_365_1:GetWordFromCfg(1109702088).content)

				arg_365_1.text_.text = var_368_1

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_3 = 47 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_1) / 47)

				if (47 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_1) / 47)) > 0 and var_368_0 < var_368_3 then
					arg_365_1.talkMaxDuration = var_368_3

					if var_368_3 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_3 + 0
					end
				end

				arg_365_1.text_.text = var_368_1
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_4 = math.max(var_368_0, arg_365_1.talkMaxDuration)

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_4 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - 0) / var_368_4

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= 0 + var_368_4 and arg_365_1.time_ < 0 + var_368_4 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play1109702089 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 1109702089
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play1109702090(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = 0.8

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, true)
				arg_369_1.iconController_:SetSelectedState("hero")

				arg_369_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_369_1.callingController_:SetSelectedState("normal")

				arg_369_1.keyicon_.color = Color.New(1, 1, 1)
				arg_369_1.icon_.color = Color.New(1, 1, 1)

				local var_372_1 = arg_369_1:FormatText(arg_369_1:GetWordFromCfg(1109702089).content)

				arg_369_1.text_.text = var_372_1

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_3 = 32 <= 0 and var_372_0 or var_372_0 * (utf8.len(var_372_1) / 32)

				if (32 <= 0 and var_372_0 or var_372_0 * (utf8.len(var_372_1) / 32)) > 0 and var_372_0 < var_372_3 then
					arg_369_1.talkMaxDuration = var_372_3

					if var_372_3 + 0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_3 + 0
					end
				end

				arg_369_1.text_.text = var_372_1
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_4 = math.max(var_372_0, arg_369_1.talkMaxDuration)

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_4 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - 0) / var_372_4

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= 0 + var_372_4 and arg_369_1.time_ < 0 + var_372_4 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play1109702090 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 1109702090
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play1109702091(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = 0.4

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, true)
				arg_373_1.iconController_:SetSelectedState("hero")

				arg_373_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_373_1.callingController_:SetSelectedState("normal")

				arg_373_1.keyicon_.color = Color.New(1, 1, 1)
				arg_373_1.icon_.color = Color.New(1, 1, 1)

				local var_376_1 = arg_373_1:FormatText(arg_373_1:GetWordFromCfg(1109702090).content)

				arg_373_1.text_.text = var_376_1

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_3 = 16 <= 0 and var_376_0 or var_376_0 * (utf8.len(var_376_1) / 16)

				if (16 <= 0 and var_376_0 or var_376_0 * (utf8.len(var_376_1) / 16)) > 0 and var_376_0 < var_376_3 then
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
	Play1109702091 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 1109702091
		arg_377_1.duration_ = 4.13

		local var_377_0 = {
			zh = 2.433,
			ja = 4.133
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
				arg_377_0:Play1109702092(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.var_.moveOldPos1197ui_story = arg_377_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_380_0 = 0.001

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 then
				arg_377_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_377_1.time_ - 0) / var_380_0)
				arg_377_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_377_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1197ui_story"].transform.position).z)
				arg_377_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_377_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_377_1.actors_["1197ui_story"].transform.localEulerAngles = arg_377_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 then
				arg_377_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, -0.545, -6.3)
				arg_377_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_377_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1197ui_story"].transform.position).z)
				arg_377_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_377_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_377_1.actors_["1197ui_story"].transform.localEulerAngles = arg_377_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_380_1 = arg_377_1.actors_["1197ui_story"]

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(var_380_1) and arg_377_1.var_.characterEffect1197ui_story == nil then
				arg_377_1.var_.characterEffect1197ui_story = var_380_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_2 = 0.200000002980232

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_2 and not isNil(var_380_1) then
				if arg_377_1.var_.characterEffect1197ui_story and not isNil(var_380_1) then
					arg_377_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_377_1.time_ >= 0 + var_380_2 and arg_377_1.time_ < 0 + var_380_2 + arg_380_0 and not isNil(var_380_1) and arg_377_1.var_.characterEffect1197ui_story then
				arg_377_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action6_1")
			end

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_380_4 = 0
			local var_380_5 = 0.275

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_4 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_6 = arg_377_1:GetWordFromCfg(1109702091)
				local var_380_7 = arg_377_1:FormatText(var_380_6.content)

				arg_377_1.text_.text = var_380_7

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_9 = 11 <= 0 and var_380_5 or var_380_5 * (utf8.len(var_380_7) / 11)

				if (11 <= 0 and var_380_5 or var_380_5 * (utf8.len(var_380_7) / 11)) > 0 and var_380_5 < var_380_9 then
					arg_377_1.talkMaxDuration = var_380_9

					if var_380_9 + var_380_4 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_9 + var_380_4
					end
				end

				arg_377_1.text_.text = var_380_7
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702091", "story_v_side_new_1109702.awb") ~= 0 then
					local var_380_10 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702091", "story_v_side_new_1109702.awb") / 1000

					if var_380_10 + var_380_4 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_10 + var_380_4
					end

					if var_380_6.prefab_name ~= "" and arg_377_1.actors_[var_380_6.prefab_name] ~= nil then
						local var_380_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_6.prefab_name].transform, "story_v_side_new_1109702", "1109702091", "story_v_side_new_1109702.awb")

						arg_377_1:RecordAudio("1109702091", var_380_11)
						arg_377_1:RecordAudio("1109702091", var_380_11)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702091", "story_v_side_new_1109702.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702091", "story_v_side_new_1109702.awb")
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
				actorName = "1197ui_story",
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
	Play1109702092 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 1109702092
		arg_381_1.duration_ = 4.3

		local var_381_0 = {
			zh = 2.466,
			ja = 4.3
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
				arg_381_0:Play1109702093(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_384_0 = 0
			local var_384_1 = 0.475

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_0 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_2 = arg_381_1:GetWordFromCfg(1109702092)
				local var_384_3 = arg_381_1:FormatText(var_384_2.content)

				arg_381_1.text_.text = var_384_3

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_5 = 19 <= 0 and var_384_1 or var_384_1 * (utf8.len(var_384_3) / 19)

				if (19 <= 0 and var_384_1 or var_384_1 * (utf8.len(var_384_3) / 19)) > 0 and var_384_1 < var_384_5 then
					arg_381_1.talkMaxDuration = var_384_5

					if var_384_5 + var_384_0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_5 + var_384_0
					end
				end

				arg_381_1.text_.text = var_384_3
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702092", "story_v_side_new_1109702.awb") ~= 0 then
					local var_384_6 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702092", "story_v_side_new_1109702.awb") / 1000

					if var_384_6 + var_384_0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_6 + var_384_0
					end

					if var_384_2.prefab_name ~= "" and arg_381_1.actors_[var_384_2.prefab_name] ~= nil then
						local var_384_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_2.prefab_name].transform, "story_v_side_new_1109702", "1109702092", "story_v_side_new_1109702.awb")

						arg_381_1:RecordAudio("1109702092", var_384_7)
						arg_381_1:RecordAudio("1109702092", var_384_7)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702092", "story_v_side_new_1109702.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702092", "story_v_side_new_1109702.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_8 = math.max(var_384_1, arg_381_1.talkMaxDuration)

			if var_384_0 <= arg_381_1.time_ and arg_381_1.time_ < var_384_0 + var_384_8 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_0) / var_384_8

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_0 + var_384_8 and arg_381_1.time_ < var_384_0 + var_384_8 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play1109702093 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 1109702093
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play1109702094(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(arg_385_1.actors_["1197ui_story"]) and arg_385_1.var_.characterEffect1197ui_story == nil then
				arg_385_1.var_.characterEffect1197ui_story = arg_385_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_0 = 0.200000002980232

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_0 and not isNil(arg_385_1.actors_["1197ui_story"]) then
				if arg_385_1.var_.characterEffect1197ui_story and not isNil(arg_385_1.actors_["1197ui_story"]) then
					arg_385_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_385_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_385_1.time_ - 0) / var_388_0)
				end
			end

			if arg_385_1.time_ >= 0 + var_388_0 and arg_385_1.time_ < 0 + var_388_0 + arg_388_0 and not isNil(arg_385_1.actors_["1197ui_story"]) and arg_385_1.var_.characterEffect1197ui_story then
				arg_385_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_385_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_388_1 = arg_385_1.actors_["1197ui_story"].transform

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.var_.moveOldPos1197ui_story = var_388_1.localPosition
			end

			local var_388_2 = 0.001

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_2 then
				var_388_1.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos1197ui_story, Vector3.New(0, 100, 0), (arg_385_1.time_ - 0) / var_388_2)
				var_388_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_388_1.position).x, (manager.ui.mainCamera.transform.position - var_388_1.position).y, (manager.ui.mainCamera.transform.position - var_388_1.position).z)
				var_388_1.localEulerAngles.z = 0
				var_388_1.localEulerAngles.x = 0
				var_388_1.localEulerAngles = var_388_1.localEulerAngles
			end

			if arg_385_1.time_ >= 0 + var_388_2 and arg_385_1.time_ < 0 + var_388_2 + arg_388_0 then
				var_388_1.localPosition = Vector3.New(0, 100, 0)
				var_388_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_388_1.position).x, (manager.ui.mainCamera.transform.position - var_388_1.position).y, (manager.ui.mainCamera.transform.position - var_388_1.position).z)
				var_388_1.localEulerAngles.z = 0
				var_388_1.localEulerAngles.x = 0
				var_388_1.localEulerAngles = var_388_1.localEulerAngles
			end

			if 0.200000002980232 < arg_385_1.time_ and arg_385_1.time_ <= 0.200000002980232 + arg_388_0 then
				arg_385_1:AudioAction("play", "effect", "se_story_side_1097", "se_story_side_1097_RollerCoaster", "")
			end

			local var_388_4 = 0
			local var_388_5 = 0.975

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_4 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, false)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_6 = arg_385_1:FormatText(arg_385_1:GetWordFromCfg(1109702093).content)

				arg_385_1.text_.text = var_388_6

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_8 = 39 <= 0 and var_388_5 or var_388_5 * (utf8.len(var_388_6) / 39)

				if (39 <= 0 and var_388_5 or var_388_5 * (utf8.len(var_388_6) / 39)) > 0 and var_388_5 < var_388_8 then
					arg_385_1.talkMaxDuration = var_388_8

					if var_388_8 + var_388_4 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_8 + var_388_4
					end
				end

				arg_385_1.text_.text = var_388_6
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_9 = math.max(var_388_5, arg_385_1.talkMaxDuration)

			if var_388_4 <= arg_385_1.time_ and arg_385_1.time_ < var_388_4 + var_388_9 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_4) / var_388_9

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_4 + var_388_9 and arg_385_1.time_ < var_388_4 + var_388_9 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_385_1:InitPlayNodeList()
	end,
	Play1109702094 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 1109702094
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play1109702095(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = 0.775

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, false)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_1 = arg_389_1:FormatText(arg_389_1:GetWordFromCfg(1109702094).content)

				arg_389_1.text_.text = var_392_1

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_3 = 31 <= 0 and var_392_0 or var_392_0 * (utf8.len(var_392_1) / 31)

				if (31 <= 0 and var_392_0 or var_392_0 * (utf8.len(var_392_1) / 31)) > 0 and var_392_0 < var_392_3 then
					arg_389_1.talkMaxDuration = var_392_3

					if var_392_3 + 0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_3 + 0
					end
				end

				arg_389_1.text_.text = var_392_1
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_4 = math.max(var_392_0, arg_389_1.talkMaxDuration)

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_4 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - 0) / var_392_4

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= 0 + var_392_4 and arg_389_1.time_ < 0 + var_392_4 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play1109702095 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 1109702095
		arg_393_1.duration_ = 3.1

		local var_393_0 = {
			zh = 2.4,
			ja = 3.1
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
				arg_393_0:Play1109702096(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.var_.moveOldPos1197ui_story = arg_393_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_396_0 = 0.001

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_0 then
				arg_393_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_393_1.time_ - 0) / var_396_0)
				arg_393_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_393_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_393_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_393_1.actors_["1197ui_story"].transform.position).z)
				arg_393_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_393_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_393_1.actors_["1197ui_story"].transform.localEulerAngles = arg_393_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_393_1.time_ >= 0 + var_396_0 and arg_393_1.time_ < 0 + var_396_0 + arg_396_0 then
				arg_393_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, -0.545, -6.3)
				arg_393_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_393_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_393_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_393_1.actors_["1197ui_story"].transform.position).z)
				arg_393_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_393_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_393_1.actors_["1197ui_story"].transform.localEulerAngles = arg_393_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_396_1 = arg_393_1.actors_["1197ui_story"]

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(var_396_1) and arg_393_1.var_.characterEffect1197ui_story == nil then
				arg_393_1.var_.characterEffect1197ui_story = var_396_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_2 = 0.200000002980232

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_2 and not isNil(var_396_1) then
				if arg_393_1.var_.characterEffect1197ui_story and not isNil(var_396_1) then
					arg_393_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_393_1.time_ >= 0 + var_396_2 and arg_393_1.time_ < 0 + var_396_2 + arg_396_0 and not isNil(var_396_1) and arg_393_1.var_.characterEffect1197ui_story then
				arg_393_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action1_1")
			end

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_396_4 = 0
			local var_396_5 = 0.225

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_4 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_6 = arg_393_1:GetWordFromCfg(1109702095)
				local var_396_7 = arg_393_1:FormatText(var_396_6.content)

				arg_393_1.text_.text = var_396_7

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_9 = 9 <= 0 and var_396_5 or var_396_5 * (utf8.len(var_396_7) / 9)

				if (9 <= 0 and var_396_5 or var_396_5 * (utf8.len(var_396_7) / 9)) > 0 and var_396_5 < var_396_9 then
					arg_393_1.talkMaxDuration = var_396_9

					if var_396_9 + var_396_4 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_9 + var_396_4
					end
				end

				arg_393_1.text_.text = var_396_7
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702095", "story_v_side_new_1109702.awb") ~= 0 then
					local var_396_10 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702095", "story_v_side_new_1109702.awb") / 1000

					if var_396_10 + var_396_4 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_10 + var_396_4
					end

					if var_396_6.prefab_name ~= "" and arg_393_1.actors_[var_396_6.prefab_name] ~= nil then
						local var_396_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_6.prefab_name].transform, "story_v_side_new_1109702", "1109702095", "story_v_side_new_1109702.awb")

						arg_393_1:RecordAudio("1109702095", var_396_11)
						arg_393_1:RecordAudio("1109702095", var_396_11)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702095", "story_v_side_new_1109702.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702095", "story_v_side_new_1109702.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_12 = math.max(var_396_5, arg_393_1.talkMaxDuration)

			if var_396_4 <= arg_393_1.time_ and arg_393_1.time_ < var_396_4 + var_396_12 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_4) / var_396_12

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_4 + var_396_12 and arg_393_1.time_ < var_396_4 + var_396_12 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_393_1:InitPlayNodeList()
	end,
	Play1109702096 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 1109702096
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play1109702097(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(arg_397_1.actors_["1197ui_story"]) and arg_397_1.var_.characterEffect1197ui_story == nil then
				arg_397_1.var_.characterEffect1197ui_story = arg_397_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_0 = 0.200000002980232

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_0 and not isNil(arg_397_1.actors_["1197ui_story"]) then
				if arg_397_1.var_.characterEffect1197ui_story and not isNil(arg_397_1.actors_["1197ui_story"]) then
					arg_397_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_397_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_397_1.time_ - 0) / var_400_0)
				end
			end

			if arg_397_1.time_ >= 0 + var_400_0 and arg_397_1.time_ < 0 + var_400_0 + arg_400_0 and not isNil(arg_397_1.actors_["1197ui_story"]) and arg_397_1.var_.characterEffect1197ui_story then
				arg_397_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_397_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_400_1 = 0
			local var_400_2 = 0.175

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, true)
				arg_397_1.iconController_:SetSelectedState("hero")

				arg_397_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_397_1.callingController_:SetSelectedState("normal")

				arg_397_1.keyicon_.color = Color.New(1, 1, 1)
				arg_397_1.icon_.color = Color.New(1, 1, 1)

				local var_400_3 = arg_397_1:FormatText(arg_397_1:GetWordFromCfg(1109702096).content)

				arg_397_1.text_.text = var_400_3

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_5 = 7 <= 0 and var_400_2 or var_400_2 * (utf8.len(var_400_3) / 7)

				if (7 <= 0 and var_400_2 or var_400_2 * (utf8.len(var_400_3) / 7)) > 0 and var_400_2 < var_400_5 then
					arg_397_1.talkMaxDuration = var_400_5

					if var_400_5 + var_400_1 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_5 + var_400_1
					end
				end

				arg_397_1.text_.text = var_400_3
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_6 = math.max(var_400_2, arg_397_1.talkMaxDuration)

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_6 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_1) / var_400_6

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_1 + var_400_6 and arg_397_1.time_ < var_400_1 + var_400_6 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play1109702097 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 1109702097
		arg_401_1.duration_ = 5.6

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play1109702098(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.var_.moveOldPos1197ui_story = arg_401_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_404_0 = 0.001

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_0 then
				arg_401_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos1197ui_story, Vector3.New(0, 100, 0), (arg_401_1.time_ - 0) / var_404_0)
				arg_401_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_401_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["1197ui_story"].transform.position).z)
				arg_401_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_401_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_401_1.actors_["1197ui_story"].transform.localEulerAngles = arg_401_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_401_1.time_ >= 0 + var_404_0 and arg_401_1.time_ < 0 + var_404_0 + arg_404_0 then
				arg_401_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_401_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_401_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["1197ui_story"].transform.position).z)
				arg_401_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_401_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_401_1.actors_["1197ui_story"].transform.localEulerAngles = arg_401_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_404_1 = 0

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 then
				arg_401_1.mask_.enabled = true
				arg_401_1.mask_.raycastTarget = true

				arg_401_1:SetGaussion(false)
			end

			local var_404_2 = 0.6

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_2 then
				local var_404_3 = Color.New(1, 1, 1)

				var_404_3.a = Mathf.Lerp(1, 0, (arg_401_1.time_ - var_404_1) / var_404_2)
				arg_401_1.mask_.color = var_404_3
			end

			if arg_401_1.time_ >= var_404_1 + var_404_2 and arg_401_1.time_ < var_404_1 + var_404_2 + arg_404_0 then
				local var_404_4 = Color.New(1, 1, 1)

				arg_401_1.mask_.enabled = false
				var_404_4.a = 0
				arg_401_1.mask_.color = var_404_4
			end

			local var_404_5 = manager.ui.mainCamera.transform

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.var_.shakeOldPos = var_404_5.localPosition
			end

			local var_404_6 = 1

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_6 then
				local var_404_7, var_404_8 = math.modf((arg_401_1.time_ - 0) / 0.066)

				var_404_5.localPosition = Vector3.New(var_404_8 * 0.13, var_404_8 * 0.13, var_404_8 * 0.13) + arg_401_1.var_.shakeOldPos
			end

			if arg_401_1.time_ >= 0 + var_404_6 and arg_401_1.time_ < 0 + var_404_6 + arg_404_0 then
				var_404_5.localPosition = arg_401_1.var_.shakeOldPos
			end

			local var_404_9 = 0

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_9 + arg_404_0 then
				arg_401_1.allBtn_.enabled = false
			end

			if arg_401_1.time_ >= var_404_9 + 0.6 and arg_401_1.time_ < var_404_9 + 0.6 + arg_404_0 then
				arg_401_1.allBtn_.enabled = true
			end

			local var_404_10 = 0.6
			local var_404_11 = 1.075

			if 0.6 < arg_401_1.time_ and arg_401_1.time_ <= var_404_10 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, false)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_12 = arg_401_1:FormatText(arg_401_1:GetWordFromCfg(1109702097).content)

				arg_401_1.text_.text = var_404_12

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_14 = 43 <= 0 and var_404_11 or var_404_11 * (utf8.len(var_404_12) / 43)

				if (43 <= 0 and var_404_11 or var_404_11 * (utf8.len(var_404_12) / 43)) > 0 and var_404_11 < var_404_14 then
					arg_401_1.talkMaxDuration = var_404_14

					if var_404_14 + var_404_10 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_14 + var_404_10
					end
				end

				arg_401_1.text_.text = var_404_12
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_15 = math.max(var_404_11, arg_401_1.talkMaxDuration)

			if var_404_10 <= arg_401_1.time_ and arg_401_1.time_ < var_404_10 + var_404_15 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_10) / var_404_15

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_10 + var_404_15 and arg_401_1.time_ < var_404_10 + var_404_15 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_401_1:InitPlayNodeList()
	end,
	Play1109702098 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 1109702098
		arg_405_1.duration_ = 2.5

		local var_405_0 = {
			zh = 2.5,
			ja = 2.333
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
				arg_405_0:Play1109702099(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.var_.moveOldPos1197ui_story = arg_405_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_408_0 = 0.001

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_0 then
				arg_405_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_405_1.time_ - 0) / var_408_0)
				arg_405_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_405_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1197ui_story"].transform.position).z)
				arg_405_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_405_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_405_1.actors_["1197ui_story"].transform.localEulerAngles = arg_405_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_405_1.time_ >= 0 + var_408_0 and arg_405_1.time_ < 0 + var_408_0 + arg_408_0 then
				arg_405_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, -0.545, -6.3)
				arg_405_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_405_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1197ui_story"].transform.position).z)
				arg_405_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_405_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_405_1.actors_["1197ui_story"].transform.localEulerAngles = arg_405_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_408_1 = arg_405_1.actors_["1197ui_story"]

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(var_408_1) and arg_405_1.var_.characterEffect1197ui_story == nil then
				arg_405_1.var_.characterEffect1197ui_story = var_408_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_2 = 0.200000002980232

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_2 and not isNil(var_408_1) then
				if arg_405_1.var_.characterEffect1197ui_story and not isNil(var_408_1) then
					arg_405_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_405_1.time_ >= 0 + var_408_2 and arg_405_1.time_ < 0 + var_408_2 + arg_408_0 and not isNil(var_408_1) and arg_405_1.var_.characterEffect1197ui_story then
				arg_405_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action1_1")
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_408_4 = 0
			local var_408_5 = 0.2

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_4 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_6 = arg_405_1:GetWordFromCfg(1109702098)
				local var_408_7 = arg_405_1:FormatText(var_408_6.content)

				arg_405_1.text_.text = var_408_7

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_9 = 8 <= 0 and var_408_5 or var_408_5 * (utf8.len(var_408_7) / 8)

				if (8 <= 0 and var_408_5 or var_408_5 * (utf8.len(var_408_7) / 8)) > 0 and var_408_5 < var_408_9 then
					arg_405_1.talkMaxDuration = var_408_9

					if var_408_9 + var_408_4 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_9 + var_408_4
					end
				end

				arg_405_1.text_.text = var_408_7
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702098", "story_v_side_new_1109702.awb") ~= 0 then
					local var_408_10 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702098", "story_v_side_new_1109702.awb") / 1000

					if var_408_10 + var_408_4 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_10 + var_408_4
					end

					if var_408_6.prefab_name ~= "" and arg_405_1.actors_[var_408_6.prefab_name] ~= nil then
						local var_408_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_6.prefab_name].transform, "story_v_side_new_1109702", "1109702098", "story_v_side_new_1109702.awb")

						arg_405_1:RecordAudio("1109702098", var_408_11)
						arg_405_1:RecordAudio("1109702098", var_408_11)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702098", "story_v_side_new_1109702.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702098", "story_v_side_new_1109702.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_12 = math.max(var_408_5, arg_405_1.talkMaxDuration)

			if var_408_4 <= arg_405_1.time_ and arg_405_1.time_ < var_408_4 + var_408_12 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_4) / var_408_12

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_4 + var_408_12 and arg_405_1.time_ < var_408_4 + var_408_12 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
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
	Play1109702099 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 1109702099
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play1109702100(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(arg_409_1.actors_["1197ui_story"]) and arg_409_1.var_.characterEffect1197ui_story == nil then
				arg_409_1.var_.characterEffect1197ui_story = arg_409_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_0 = 0.200000002980232

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 and not isNil(arg_409_1.actors_["1197ui_story"]) then
				if arg_409_1.var_.characterEffect1197ui_story and not isNil(arg_409_1.actors_["1197ui_story"]) then
					arg_409_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_409_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_409_1.time_ - 0) / var_412_0)
				end
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 and not isNil(arg_409_1.actors_["1197ui_story"]) and arg_409_1.var_.characterEffect1197ui_story then
				arg_409_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_409_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_412_1 = 0
			local var_412_2 = 0.15

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, true)
				arg_409_1.iconController_:SetSelectedState("hero")

				arg_409_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_409_1.callingController_:SetSelectedState("normal")

				arg_409_1.keyicon_.color = Color.New(1, 1, 1)
				arg_409_1.icon_.color = Color.New(1, 1, 1)

				local var_412_3 = arg_409_1:FormatText(arg_409_1:GetWordFromCfg(1109702099).content)

				arg_409_1.text_.text = var_412_3

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_5 = 6 <= 0 and var_412_2 or var_412_2 * (utf8.len(var_412_3) / 6)

				if (6 <= 0 and var_412_2 or var_412_2 * (utf8.len(var_412_3) / 6)) > 0 and var_412_2 < var_412_5 then
					arg_409_1.talkMaxDuration = var_412_5

					if var_412_5 + var_412_1 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_5 + var_412_1
					end
				end

				arg_409_1.text_.text = var_412_3
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_6 = math.max(var_412_2, arg_409_1.talkMaxDuration)

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_6 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_1) / var_412_6

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_1 + var_412_6 and arg_409_1.time_ < var_412_1 + var_412_6 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play1109702100 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 1109702100
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play1109702101(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.var_.moveOldPos1197ui_story = arg_413_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_416_0 = 0.001

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_0 then
				arg_413_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos1197ui_story, Vector3.New(0, 100, 0), (arg_413_1.time_ - 0) / var_416_0)
				arg_413_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_413_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1197ui_story"].transform.position).z)
				arg_413_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_413_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_413_1.actors_["1197ui_story"].transform.localEulerAngles = arg_413_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_413_1.time_ >= 0 + var_416_0 and arg_413_1.time_ < 0 + var_416_0 + arg_416_0 then
				arg_413_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_413_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_413_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1197ui_story"].transform.position).z)
				arg_413_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_413_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_413_1.actors_["1197ui_story"].transform.localEulerAngles = arg_413_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_416_1 = manager.ui.mainCamera.transform

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.var_.shakeOldPos = var_416_1.localPosition
			end

			local var_416_2 = 0.6

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_2 then
				local var_416_3, var_416_4 = math.modf((arg_413_1.time_ - 0) / 0.066)

				var_416_1.localPosition = Vector3.New(var_416_4 * 0.13, var_416_4 * 0.13, var_416_4 * 0.13) + arg_413_1.var_.shakeOldPos
			end

			if arg_413_1.time_ >= 0 + var_416_2 and arg_413_1.time_ < 0 + var_416_2 + arg_416_0 then
				var_416_1.localPosition = arg_413_1.var_.shakeOldPos
			end

			local var_416_5 = 0

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_5 + arg_416_0 then
				arg_413_1.allBtn_.enabled = false
			end

			if arg_413_1.time_ >= var_416_5 + 0.6 and arg_413_1.time_ < var_416_5 + 0.6 + arg_416_0 then
				arg_413_1.allBtn_.enabled = true
			end

			local var_416_6 = 0
			local var_416_7 = 0.775

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_6 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, false)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_8 = arg_413_1:FormatText(arg_413_1:GetWordFromCfg(1109702100).content)

				arg_413_1.text_.text = var_416_8

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_10 = 31 <= 0 and var_416_7 or var_416_7 * (utf8.len(var_416_8) / 31)

				if (31 <= 0 and var_416_7 or var_416_7 * (utf8.len(var_416_8) / 31)) > 0 and var_416_7 < var_416_10 then
					arg_413_1.talkMaxDuration = var_416_10

					if var_416_10 + var_416_6 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_10 + var_416_6
					end
				end

				arg_413_1.text_.text = var_416_8
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_11 = math.max(var_416_7, arg_413_1.talkMaxDuration)

			if var_416_6 <= arg_413_1.time_ and arg_413_1.time_ < var_416_6 + var_416_11 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_6) / var_416_11

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_6 + var_416_11 and arg_413_1.time_ < var_416_6 + var_416_11 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_413_1:InitPlayNodeList()
	end,
	Play1109702101 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 1109702101
		arg_417_1.duration_ = 4.77

		local var_417_0 = {
			zh = 4.766,
			ja = 2.4
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
				arg_417_0:Play1109702102(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1.var_.moveOldPos1197ui_story = arg_417_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_420_0 = 0.001

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 then
				arg_417_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_417_1.time_ - 0) / var_420_0)
				arg_417_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_417_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["1197ui_story"].transform.position).z)
				arg_417_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_417_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_417_1.actors_["1197ui_story"].transform.localEulerAngles = arg_417_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 then
				arg_417_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, -0.545, -6.3)
				arg_417_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_417_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["1197ui_story"].transform.position).z)
				arg_417_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_417_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_417_1.actors_["1197ui_story"].transform.localEulerAngles = arg_417_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_420_1 = arg_417_1.actors_["1197ui_story"]

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(var_420_1) and arg_417_1.var_.characterEffect1197ui_story == nil then
				arg_417_1.var_.characterEffect1197ui_story = var_420_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_2 = 0.200000002980232

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_2 and not isNil(var_420_1) then
				if arg_417_1.var_.characterEffect1197ui_story and not isNil(var_420_1) then
					arg_417_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_417_1.time_ >= 0 + var_420_2 and arg_417_1.time_ < 0 + var_420_2 + arg_420_0 and not isNil(var_420_1) and arg_417_1.var_.characterEffect1197ui_story then
				arg_417_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action7_1")
			end

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_420_4 = 0
			local var_420_5 = 0.45

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_4 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_6 = arg_417_1:GetWordFromCfg(1109702101)
				local var_420_7 = arg_417_1:FormatText(var_420_6.content)

				arg_417_1.text_.text = var_420_7

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_9 = 18 <= 0 and var_420_5 or var_420_5 * (utf8.len(var_420_7) / 18)

				if (18 <= 0 and var_420_5 or var_420_5 * (utf8.len(var_420_7) / 18)) > 0 and var_420_5 < var_420_9 then
					arg_417_1.talkMaxDuration = var_420_9

					if var_420_9 + var_420_4 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_9 + var_420_4
					end
				end

				arg_417_1.text_.text = var_420_7
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702101", "story_v_side_new_1109702.awb") ~= 0 then
					local var_420_10 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702101", "story_v_side_new_1109702.awb") / 1000

					if var_420_10 + var_420_4 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_10 + var_420_4
					end

					if var_420_6.prefab_name ~= "" and arg_417_1.actors_[var_420_6.prefab_name] ~= nil then
						local var_420_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_6.prefab_name].transform, "story_v_side_new_1109702", "1109702101", "story_v_side_new_1109702.awb")

						arg_417_1:RecordAudio("1109702101", var_420_11)
						arg_417_1:RecordAudio("1109702101", var_420_11)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702101", "story_v_side_new_1109702.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702101", "story_v_side_new_1109702.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_12 = math.max(var_420_5, arg_417_1.talkMaxDuration)

			if var_420_4 <= arg_417_1.time_ and arg_417_1.time_ < var_420_4 + var_420_12 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_4) / var_420_12

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_4 + var_420_12 and arg_417_1.time_ < var_420_4 + var_420_12 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_417_1:InitPlayNodeList()
	end,
	Play1109702102 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 1109702102
		arg_421_1.duration_ = 5

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play1109702103(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(arg_421_1.actors_["1197ui_story"]) and arg_421_1.var_.characterEffect1197ui_story == nil then
				arg_421_1.var_.characterEffect1197ui_story = arg_421_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_0 = 0.200000002980232

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_0 and not isNil(arg_421_1.actors_["1197ui_story"]) then
				if arg_421_1.var_.characterEffect1197ui_story and not isNil(arg_421_1.actors_["1197ui_story"]) then
					arg_421_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_421_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_421_1.time_ - 0) / var_424_0)
				end
			end

			if arg_421_1.time_ >= 0 + var_424_0 and arg_421_1.time_ < 0 + var_424_0 + arg_424_0 and not isNil(arg_421_1.actors_["1197ui_story"]) and arg_421_1.var_.characterEffect1197ui_story then
				arg_421_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_421_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_424_1 = arg_421_1.actors_["1197ui_story"].transform

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1.var_.moveOldPos1197ui_story = var_424_1.localPosition
			end

			local var_424_2 = 0.001

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_2 then
				var_424_1.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos1197ui_story, Vector3.New(0, 100, 0), (arg_421_1.time_ - 0) / var_424_2)
				var_424_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_424_1.position).x, (manager.ui.mainCamera.transform.position - var_424_1.position).y, (manager.ui.mainCamera.transform.position - var_424_1.position).z)
				var_424_1.localEulerAngles.z = 0
				var_424_1.localEulerAngles.x = 0
				var_424_1.localEulerAngles = var_424_1.localEulerAngles
			end

			if arg_421_1.time_ >= 0 + var_424_2 and arg_421_1.time_ < 0 + var_424_2 + arg_424_0 then
				var_424_1.localPosition = Vector3.New(0, 100, 0)
				var_424_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_424_1.position).x, (manager.ui.mainCamera.transform.position - var_424_1.position).y, (manager.ui.mainCamera.transform.position - var_424_1.position).z)
				var_424_1.localEulerAngles.z = 0
				var_424_1.localEulerAngles.x = 0
				var_424_1.localEulerAngles = var_424_1.localEulerAngles
			end

			local var_424_3 = 0
			local var_424_4 = 0.875

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_3 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, false)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_5 = arg_421_1:FormatText(arg_421_1:GetWordFromCfg(1109702102).content)

				arg_421_1.text_.text = var_424_5

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_7 = 35 <= 0 and var_424_4 or var_424_4 * (utf8.len(var_424_5) / 35)

				if (35 <= 0 and var_424_4 or var_424_4 * (utf8.len(var_424_5) / 35)) > 0 and var_424_4 < var_424_7 then
					arg_421_1.talkMaxDuration = var_424_7

					if var_424_7 + var_424_3 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_7 + var_424_3
					end
				end

				arg_421_1.text_.text = var_424_5
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_8 = math.max(var_424_4, arg_421_1.talkMaxDuration)

			if var_424_3 <= arg_421_1.time_ and arg_421_1.time_ < var_424_3 + var_424_8 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_3) / var_424_8

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_3 + var_424_8 and arg_421_1.time_ < var_424_3 + var_424_8 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_421_1:InitPlayNodeList()
	end,
	Play1109702103 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 1109702103
		arg_425_1.duration_ = 5

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play1109702104(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = 0.05

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

				local var_428_1 = arg_425_1:FormatText(arg_425_1:GetWordFromCfg(1109702103).content)

				arg_425_1.text_.text = var_428_1

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_3 = 2 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_1) / 2)

				if (2 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_1) / 2)) > 0 and var_428_0 < var_428_3 then
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
	Play1109702104 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 1109702104
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play1109702105(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = 0.45

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, false)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_1 = arg_429_1:FormatText(arg_429_1:GetWordFromCfg(1109702104).content)

				arg_429_1.text_.text = var_432_1

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_3 = 18 <= 0 and var_432_0 or var_432_0 * (utf8.len(var_432_1) / 18)

				if (18 <= 0 and var_432_0 or var_432_0 * (utf8.len(var_432_1) / 18)) > 0 and var_432_0 < var_432_3 then
					arg_429_1.talkMaxDuration = var_432_3

					if var_432_3 + 0 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_3 + 0
					end
				end

				arg_429_1.text_.text = var_432_1
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_4 = math.max(var_432_0, arg_429_1.talkMaxDuration)

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_4 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - 0) / var_432_4

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= 0 + var_432_4 and arg_429_1.time_ < 0 + var_432_4 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play1109702105 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 1109702105
		arg_433_1.duration_ = 5.63

		local var_433_0 = {
			zh = 3.333,
			ja = 5.633
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
				arg_433_0:Play1109702106(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.var_.moveOldPos1197ui_story = arg_433_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_436_0 = 0.001

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_0 then
				arg_433_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_433_1.time_ - 0) / var_436_0)
				arg_433_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_433_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1197ui_story"].transform.position).z)
				arg_433_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_433_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_433_1.actors_["1197ui_story"].transform.localEulerAngles = arg_433_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_433_1.time_ >= 0 + var_436_0 and arg_433_1.time_ < 0 + var_436_0 + arg_436_0 then
				arg_433_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, -0.545, -6.3)
				arg_433_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_433_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1197ui_story"].transform.position).z)
				arg_433_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_433_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_433_1.actors_["1197ui_story"].transform.localEulerAngles = arg_433_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_436_1 = arg_433_1.actors_["1197ui_story"]

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(var_436_1) and arg_433_1.var_.characterEffect1197ui_story == nil then
				arg_433_1.var_.characterEffect1197ui_story = var_436_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_2 = 0.200000002980232

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_2 and not isNil(var_436_1) then
				if arg_433_1.var_.characterEffect1197ui_story and not isNil(var_436_1) then
					arg_433_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_433_1.time_ >= 0 + var_436_2 and arg_433_1.time_ < 0 + var_436_2 + arg_436_0 and not isNil(var_436_1) and arg_433_1.var_.characterEffect1197ui_story then
				arg_433_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action9_1")
			end

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_436_4 = 0
			local var_436_5 = 0.575

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_4 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				arg_433_1.leftNameTxt_.text = arg_433_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_6 = arg_433_1:GetWordFromCfg(1109702105)
				local var_436_7 = arg_433_1:FormatText(var_436_6.content)

				arg_433_1.text_.text = var_436_7

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_9 = 23 <= 0 and var_436_5 or var_436_5 * (utf8.len(var_436_7) / 23)

				if (23 <= 0 and var_436_5 or var_436_5 * (utf8.len(var_436_7) / 23)) > 0 and var_436_5 < var_436_9 then
					arg_433_1.talkMaxDuration = var_436_9

					if var_436_9 + var_436_4 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_9 + var_436_4
					end
				end

				arg_433_1.text_.text = var_436_7
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702105", "story_v_side_new_1109702.awb") ~= 0 then
					local var_436_10 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702105", "story_v_side_new_1109702.awb") / 1000

					if var_436_10 + var_436_4 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_10 + var_436_4
					end

					if var_436_6.prefab_name ~= "" and arg_433_1.actors_[var_436_6.prefab_name] ~= nil then
						local var_436_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_6.prefab_name].transform, "story_v_side_new_1109702", "1109702105", "story_v_side_new_1109702.awb")

						arg_433_1:RecordAudio("1109702105", var_436_11)
						arg_433_1:RecordAudio("1109702105", var_436_11)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702105", "story_v_side_new_1109702.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702105", "story_v_side_new_1109702.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_12 = math.max(var_436_5, arg_433_1.talkMaxDuration)

			if var_436_4 <= arg_433_1.time_ and arg_433_1.time_ < var_436_4 + var_436_12 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_4) / var_436_12

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_4 + var_436_12 and arg_433_1.time_ < var_436_4 + var_436_12 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_433_1:InitPlayNodeList()
	end,
	Play1109702106 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 1109702106
		arg_437_1.duration_ = 5

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play1109702107(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(arg_437_1.actors_["1197ui_story"]) and arg_437_1.var_.characterEffect1197ui_story == nil then
				arg_437_1.var_.characterEffect1197ui_story = arg_437_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_0 = 0.200000002980232

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_0 and not isNil(arg_437_1.actors_["1197ui_story"]) then
				if arg_437_1.var_.characterEffect1197ui_story and not isNil(arg_437_1.actors_["1197ui_story"]) then
					arg_437_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_437_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_437_1.time_ - 0) / var_440_0)
				end
			end

			if arg_437_1.time_ >= 0 + var_440_0 and arg_437_1.time_ < 0 + var_440_0 + arg_440_0 and not isNil(arg_437_1.actors_["1197ui_story"]) and arg_437_1.var_.characterEffect1197ui_story then
				arg_437_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_437_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_440_1 = 0
			local var_440_2 = 1.175

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_1 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, true)
				arg_437_1.iconController_:SetSelectedState("hero")

				arg_437_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_437_1.callingController_:SetSelectedState("normal")

				arg_437_1.keyicon_.color = Color.New(1, 1, 1)
				arg_437_1.icon_.color = Color.New(1, 1, 1)

				local var_440_3 = arg_437_1:FormatText(arg_437_1:GetWordFromCfg(1109702106).content)

				arg_437_1.text_.text = var_440_3

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_5 = 47 <= 0 and var_440_2 or var_440_2 * (utf8.len(var_440_3) / 47)

				if (47 <= 0 and var_440_2 or var_440_2 * (utf8.len(var_440_3) / 47)) > 0 and var_440_2 < var_440_5 then
					arg_437_1.talkMaxDuration = var_440_5

					if var_440_5 + var_440_1 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_5 + var_440_1
					end
				end

				arg_437_1.text_.text = var_440_3
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_6 = math.max(var_440_2, arg_437_1.talkMaxDuration)

			if var_440_1 <= arg_437_1.time_ and arg_437_1.time_ < var_440_1 + var_440_6 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_1) / var_440_6

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_1 + var_440_6 and arg_437_1.time_ < var_440_1 + var_440_6 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play1109702107 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 1109702107
		arg_441_1.duration_ = 3.47

		local var_441_0 = {
			zh = 3.466,
			ja = 1.999999999999
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
				arg_441_0:Play1109702108(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action9_2")
			end

			local var_444_0 = arg_441_1.actors_["1197ui_story"]

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 and not isNil(var_444_0) and arg_441_1.var_.characterEffect1197ui_story == nil then
				arg_441_1.var_.characterEffect1197ui_story = var_444_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_1 = 0.200000002980232

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_1 and not isNil(var_444_0) then
				if arg_441_1.var_.characterEffect1197ui_story and not isNil(var_444_0) then
					arg_441_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_441_1.time_ >= 0 + var_444_1 and arg_441_1.time_ < 0 + var_444_1 + arg_444_0 and not isNil(var_444_0) and arg_441_1.var_.characterEffect1197ui_story then
				arg_441_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			local var_444_3 = 0
			local var_444_4 = 0.2

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_3 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				arg_441_1.leftNameTxt_.text = arg_441_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_5 = arg_441_1:GetWordFromCfg(1109702107)
				local var_444_6 = arg_441_1:FormatText(var_444_5.content)

				arg_441_1.text_.text = var_444_6

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_8 = 8 <= 0 and var_444_4 or var_444_4 * (utf8.len(var_444_6) / 8)

				if (8 <= 0 and var_444_4 or var_444_4 * (utf8.len(var_444_6) / 8)) > 0 and var_444_4 < var_444_8 then
					arg_441_1.talkMaxDuration = var_444_8

					if var_444_8 + var_444_3 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_8 + var_444_3
					end
				end

				arg_441_1.text_.text = var_444_6
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702107", "story_v_side_new_1109702.awb") ~= 0 then
					local var_444_9 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702107", "story_v_side_new_1109702.awb") / 1000

					if var_444_9 + var_444_3 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_9 + var_444_3
					end

					if var_444_5.prefab_name ~= "" and arg_441_1.actors_[var_444_5.prefab_name] ~= nil then
						local var_444_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_5.prefab_name].transform, "story_v_side_new_1109702", "1109702107", "story_v_side_new_1109702.awb")

						arg_441_1:RecordAudio("1109702107", var_444_10)
						arg_441_1:RecordAudio("1109702107", var_444_10)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702107", "story_v_side_new_1109702.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702107", "story_v_side_new_1109702.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_11 = math.max(var_444_4, arg_441_1.talkMaxDuration)

			if var_444_3 <= arg_441_1.time_ and arg_441_1.time_ < var_444_3 + var_444_11 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_3) / var_444_11

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_3 + var_444_11 and arg_441_1.time_ < var_444_3 + var_444_11 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play1109702108 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 1109702108
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play1109702109(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 and not isNil(arg_445_1.actors_["1197ui_story"]) and arg_445_1.var_.characterEffect1197ui_story == nil then
				arg_445_1.var_.characterEffect1197ui_story = arg_445_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_0 = 0.200000002980232

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_0 and not isNil(arg_445_1.actors_["1197ui_story"]) then
				if arg_445_1.var_.characterEffect1197ui_story and not isNil(arg_445_1.actors_["1197ui_story"]) then
					arg_445_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_445_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_445_1.time_ - 0) / var_448_0)
				end
			end

			if arg_445_1.time_ >= 0 + var_448_0 and arg_445_1.time_ < 0 + var_448_0 + arg_448_0 and not isNil(arg_445_1.actors_["1197ui_story"]) and arg_445_1.var_.characterEffect1197ui_story then
				arg_445_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_445_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_448_1 = 0
			local var_448_2 = 0.6

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_1 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, false)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_3 = arg_445_1:FormatText(arg_445_1:GetWordFromCfg(1109702108).content)

				arg_445_1.text_.text = var_448_3

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_5 = 24 <= 0 and var_448_2 or var_448_2 * (utf8.len(var_448_3) / 24)

				if (24 <= 0 and var_448_2 or var_448_2 * (utf8.len(var_448_3) / 24)) > 0 and var_448_2 < var_448_5 then
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
	Play1109702109 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 1109702109
		arg_449_1.duration_ = 4.33

		local var_449_0 = {
			zh = 4.066,
			ja = 4.333
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
				arg_449_0:Play1109702110(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 and not isNil(arg_449_1.actors_["1197ui_story"]) and arg_449_1.var_.characterEffect1197ui_story == nil then
				arg_449_1.var_.characterEffect1197ui_story = arg_449_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_0 = 0.200000002980232

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_0 and not isNil(arg_449_1.actors_["1197ui_story"]) then
				if arg_449_1.var_.characterEffect1197ui_story and not isNil(arg_449_1.actors_["1197ui_story"]) then
					arg_449_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_449_1.time_ >= 0 + var_452_0 and arg_449_1.time_ < 0 + var_452_0 + arg_452_0 and not isNil(arg_449_1.actors_["1197ui_story"]) and arg_449_1.var_.characterEffect1197ui_story then
				arg_449_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_452_2 = 0
			local var_452_3 = 0.325

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_2 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_4 = arg_449_1:GetWordFromCfg(1109702109)
				local var_452_5 = arg_449_1:FormatText(var_452_4.content)

				arg_449_1.text_.text = var_452_5

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_7 = 13 <= 0 and var_452_3 or var_452_3 * (utf8.len(var_452_5) / 13)

				if (13 <= 0 and var_452_3 or var_452_3 * (utf8.len(var_452_5) / 13)) > 0 and var_452_3 < var_452_7 then
					arg_449_1.talkMaxDuration = var_452_7

					if var_452_7 + var_452_2 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_7 + var_452_2
					end
				end

				arg_449_1.text_.text = var_452_5
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702109", "story_v_side_new_1109702.awb") ~= 0 then
					local var_452_8 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702109", "story_v_side_new_1109702.awb") / 1000

					if var_452_8 + var_452_2 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_8 + var_452_2
					end

					if var_452_4.prefab_name ~= "" and arg_449_1.actors_[var_452_4.prefab_name] ~= nil then
						local var_452_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_4.prefab_name].transform, "story_v_side_new_1109702", "1109702109", "story_v_side_new_1109702.awb")

						arg_449_1:RecordAudio("1109702109", var_452_9)
						arg_449_1:RecordAudio("1109702109", var_452_9)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702109", "story_v_side_new_1109702.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702109", "story_v_side_new_1109702.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_10 = math.max(var_452_3, arg_449_1.talkMaxDuration)

			if var_452_2 <= arg_449_1.time_ and arg_449_1.time_ < var_452_2 + var_452_10 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_2) / var_452_10

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_2 + var_452_10 and arg_449_1.time_ < var_452_2 + var_452_10 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play1109702110 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 1109702110
		arg_453_1.duration_ = 5.47

		local var_453_0 = {
			zh = 5.466,
			ja = 5.266
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
				arg_453_0:Play1109702111(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action7_1")
			end

			local var_456_0 = 0
			local var_456_1 = 0.45

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_0 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_2 = arg_453_1:GetWordFromCfg(1109702110)
				local var_456_3 = arg_453_1:FormatText(var_456_2.content)

				arg_453_1.text_.text = var_456_3

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_5 = 18 <= 0 and var_456_1 or var_456_1 * (utf8.len(var_456_3) / 18)

				if (18 <= 0 and var_456_1 or var_456_1 * (utf8.len(var_456_3) / 18)) > 0 and var_456_1 < var_456_5 then
					arg_453_1.talkMaxDuration = var_456_5

					if var_456_5 + var_456_0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_5 + var_456_0
					end
				end

				arg_453_1.text_.text = var_456_3
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702110", "story_v_side_new_1109702.awb") ~= 0 then
					local var_456_6 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702110", "story_v_side_new_1109702.awb") / 1000

					if var_456_6 + var_456_0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_6 + var_456_0
					end

					if var_456_2.prefab_name ~= "" and arg_453_1.actors_[var_456_2.prefab_name] ~= nil then
						local var_456_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_2.prefab_name].transform, "story_v_side_new_1109702", "1109702110", "story_v_side_new_1109702.awb")

						arg_453_1:RecordAudio("1109702110", var_456_7)
						arg_453_1:RecordAudio("1109702110", var_456_7)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702110", "story_v_side_new_1109702.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702110", "story_v_side_new_1109702.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_8 = math.max(var_456_1, arg_453_1.talkMaxDuration)

			if var_456_0 <= arg_453_1.time_ and arg_453_1.time_ < var_456_0 + var_456_8 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_0) / var_456_8

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_0 + var_456_8 and arg_453_1.time_ < var_456_0 + var_456_8 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play1109702111 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 1109702111
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play1109702112(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 and not isNil(arg_457_1.actors_["1197ui_story"]) and arg_457_1.var_.characterEffect1197ui_story == nil then
				arg_457_1.var_.characterEffect1197ui_story = arg_457_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_460_0 = 0.200000002980232

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_0 and not isNil(arg_457_1.actors_["1197ui_story"]) then
				if arg_457_1.var_.characterEffect1197ui_story and not isNil(arg_457_1.actors_["1197ui_story"]) then
					arg_457_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_457_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_457_1.time_ - 0) / var_460_0)
				end
			end

			if arg_457_1.time_ >= 0 + var_460_0 and arg_457_1.time_ < 0 + var_460_0 + arg_460_0 and not isNil(arg_457_1.actors_["1197ui_story"]) and arg_457_1.var_.characterEffect1197ui_story then
				arg_457_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_457_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_460_1 = 0
			local var_460_2 = 0.05

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

				local var_460_3 = arg_457_1:FormatText(arg_457_1:GetWordFromCfg(1109702111).content)

				arg_457_1.text_.text = var_460_3

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_5 = 2 <= 0 and var_460_2 or var_460_2 * (utf8.len(var_460_3) / 2)

				if (2 <= 0 and var_460_2 or var_460_2 * (utf8.len(var_460_3) / 2)) > 0 and var_460_2 < var_460_5 then
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
	Play1109702112 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 1109702112
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play1109702113(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 0.65

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, false)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_1 = arg_461_1:FormatText(arg_461_1:GetWordFromCfg(1109702112).content)

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
	Play1109702113 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 1109702113
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play1109702114(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = 1.2

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				arg_465_1.leftNameTxt_.text = arg_465_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, true)
				arg_465_1.iconController_:SetSelectedState("hero")

				arg_465_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_465_1.callingController_:SetSelectedState("normal")

				arg_465_1.keyicon_.color = Color.New(1, 1, 1)
				arg_465_1.icon_.color = Color.New(1, 1, 1)

				local var_468_1 = arg_465_1:FormatText(arg_465_1:GetWordFromCfg(1109702113).content)

				arg_465_1.text_.text = var_468_1

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_3 = 48 <= 0 and var_468_0 or var_468_0 * (utf8.len(var_468_1) / 48)

				if (48 <= 0 and var_468_0 or var_468_0 * (utf8.len(var_468_1) / 48)) > 0 and var_468_0 < var_468_3 then
					arg_465_1.talkMaxDuration = var_468_3

					if var_468_3 + 0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_3 + 0
					end
				end

				arg_465_1.text_.text = var_468_1
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_4 = math.max(var_468_0, arg_465_1.talkMaxDuration)

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_4 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - 0) / var_468_4

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= 0 + var_468_4 and arg_465_1.time_ < 0 + var_468_4 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play1109702114 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 1109702114
		arg_469_1.duration_ = 2.4

		local var_469_0 = {
			zh = 1.999999999999,
			ja = 2.4
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
				arg_469_0:Play1109702115(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 and not isNil(arg_469_1.actors_["1197ui_story"]) and arg_469_1.var_.characterEffect1197ui_story == nil then
				arg_469_1.var_.characterEffect1197ui_story = arg_469_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_0 = 0.200000002980232

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_0 and not isNil(arg_469_1.actors_["1197ui_story"]) then
				if arg_469_1.var_.characterEffect1197ui_story and not isNil(arg_469_1.actors_["1197ui_story"]) then
					arg_469_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_469_1.time_ >= 0 + var_472_0 and arg_469_1.time_ < 0 + var_472_0 + arg_472_0 and not isNil(arg_469_1.actors_["1197ui_story"]) and arg_469_1.var_.characterEffect1197ui_story then
				arg_469_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action7_2")
			end

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_472_2 = 0
			local var_472_3 = 0.15

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_2 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				arg_469_1.leftNameTxt_.text = arg_469_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_4 = arg_469_1:GetWordFromCfg(1109702114)
				local var_472_5 = arg_469_1:FormatText(var_472_4.content)

				arg_469_1.text_.text = var_472_5

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_7 = 6 <= 0 and var_472_3 or var_472_3 * (utf8.len(var_472_5) / 6)

				if (6 <= 0 and var_472_3 or var_472_3 * (utf8.len(var_472_5) / 6)) > 0 and var_472_3 < var_472_7 then
					arg_469_1.talkMaxDuration = var_472_7

					if var_472_7 + var_472_2 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_7 + var_472_2
					end
				end

				arg_469_1.text_.text = var_472_5
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702114", "story_v_side_new_1109702.awb") ~= 0 then
					local var_472_8 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702114", "story_v_side_new_1109702.awb") / 1000

					if var_472_8 + var_472_2 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_8 + var_472_2
					end

					if var_472_4.prefab_name ~= "" and arg_469_1.actors_[var_472_4.prefab_name] ~= nil then
						local var_472_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_4.prefab_name].transform, "story_v_side_new_1109702", "1109702114", "story_v_side_new_1109702.awb")

						arg_469_1:RecordAudio("1109702114", var_472_9)
						arg_469_1:RecordAudio("1109702114", var_472_9)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702114", "story_v_side_new_1109702.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702114", "story_v_side_new_1109702.awb")
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
	Play1109702115 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 1109702115
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play1109702116(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 and not isNil(arg_473_1.actors_["1197ui_story"]) and arg_473_1.var_.characterEffect1197ui_story == nil then
				arg_473_1.var_.characterEffect1197ui_story = arg_473_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_0 = 0.200000002980232

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_0 and not isNil(arg_473_1.actors_["1197ui_story"]) then
				if arg_473_1.var_.characterEffect1197ui_story and not isNil(arg_473_1.actors_["1197ui_story"]) then
					arg_473_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_473_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_473_1.time_ - 0) / var_476_0)
				end
			end

			if arg_473_1.time_ >= 0 + var_476_0 and arg_473_1.time_ < 0 + var_476_0 + arg_476_0 and not isNil(arg_473_1.actors_["1197ui_story"]) and arg_473_1.var_.characterEffect1197ui_story then
				arg_473_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_473_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_476_1 = 0
			local var_476_2 = 0.2

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_1 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, true)
				arg_473_1.iconController_:SetSelectedState("hero")

				arg_473_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_473_1.callingController_:SetSelectedState("normal")

				arg_473_1.keyicon_.color = Color.New(1, 1, 1)
				arg_473_1.icon_.color = Color.New(1, 1, 1)

				local var_476_3 = arg_473_1:FormatText(arg_473_1:GetWordFromCfg(1109702115).content)

				arg_473_1.text_.text = var_476_3

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_5 = 8 <= 0 and var_476_2 or var_476_2 * (utf8.len(var_476_3) / 8)

				if (8 <= 0 and var_476_2 or var_476_2 * (utf8.len(var_476_3) / 8)) > 0 and var_476_2 < var_476_5 then
					arg_473_1.talkMaxDuration = var_476_5

					if var_476_5 + var_476_1 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_5 + var_476_1
					end
				end

				arg_473_1.text_.text = var_476_3
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_6 = math.max(var_476_2, arg_473_1.talkMaxDuration)

			if var_476_1 <= arg_473_1.time_ and arg_473_1.time_ < var_476_1 + var_476_6 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_1) / var_476_6

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_1 + var_476_6 and arg_473_1.time_ < var_476_1 + var_476_6 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play1109702116 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 1109702116
		arg_477_1.duration_ = 2.47

		local var_477_0 = {
			zh = 2.466,
			ja = 2.3
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
				arg_477_0:Play1109702117(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 and not isNil(arg_477_1.actors_["1197ui_story"]) and arg_477_1.var_.characterEffect1197ui_story == nil then
				arg_477_1.var_.characterEffect1197ui_story = arg_477_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_0 = 0.200000002980232

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_0 and not isNil(arg_477_1.actors_["1197ui_story"]) then
				if arg_477_1.var_.characterEffect1197ui_story and not isNil(arg_477_1.actors_["1197ui_story"]) then
					arg_477_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_477_1.time_ >= 0 + var_480_0 and arg_477_1.time_ < 0 + var_480_0 + arg_480_0 and not isNil(arg_477_1.actors_["1197ui_story"]) and arg_477_1.var_.characterEffect1197ui_story then
				arg_477_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_480_2 = 0
			local var_480_3 = 0.2

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_2 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_4 = arg_477_1:GetWordFromCfg(1109702116)
				local var_480_5 = arg_477_1:FormatText(var_480_4.content)

				arg_477_1.text_.text = var_480_5

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_7 = 8 <= 0 and var_480_3 or var_480_3 * (utf8.len(var_480_5) / 8)

				if (8 <= 0 and var_480_3 or var_480_3 * (utf8.len(var_480_5) / 8)) > 0 and var_480_3 < var_480_7 then
					arg_477_1.talkMaxDuration = var_480_7

					if var_480_7 + var_480_2 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_7 + var_480_2
					end
				end

				arg_477_1.text_.text = var_480_5
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702116", "story_v_side_new_1109702.awb") ~= 0 then
					local var_480_8 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702116", "story_v_side_new_1109702.awb") / 1000

					if var_480_8 + var_480_2 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_8 + var_480_2
					end

					if var_480_4.prefab_name ~= "" and arg_477_1.actors_[var_480_4.prefab_name] ~= nil then
						local var_480_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_4.prefab_name].transform, "story_v_side_new_1109702", "1109702116", "story_v_side_new_1109702.awb")

						arg_477_1:RecordAudio("1109702116", var_480_9)
						arg_477_1:RecordAudio("1109702116", var_480_9)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702116", "story_v_side_new_1109702.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702116", "story_v_side_new_1109702.awb")
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
	Play1109702117 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 1109702117
		arg_481_1.duration_ = 5

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play1109702118(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 and not isNil(arg_481_1.actors_["1197ui_story"]) and arg_481_1.var_.characterEffect1197ui_story == nil then
				arg_481_1.var_.characterEffect1197ui_story = arg_481_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_0 = 0.200000002980232

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_0 and not isNil(arg_481_1.actors_["1197ui_story"]) then
				if arg_481_1.var_.characterEffect1197ui_story and not isNil(arg_481_1.actors_["1197ui_story"]) then
					arg_481_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_481_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_481_1.time_ - 0) / var_484_0)
				end
			end

			if arg_481_1.time_ >= 0 + var_484_0 and arg_481_1.time_ < 0 + var_484_0 + arg_484_0 and not isNil(arg_481_1.actors_["1197ui_story"]) and arg_481_1.var_.characterEffect1197ui_story then
				arg_481_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_481_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_484_1 = 0
			local var_484_2 = 1.375

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

				local var_484_3 = arg_481_1:FormatText(arg_481_1:GetWordFromCfg(1109702117).content)

				arg_481_1.text_.text = var_484_3

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_5 = 55 <= 0 and var_484_2 or var_484_2 * (utf8.len(var_484_3) / 55)

				if (55 <= 0 and var_484_2 or var_484_2 * (utf8.len(var_484_3) / 55)) > 0 and var_484_2 < var_484_5 then
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

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play1109702118 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 1109702118
		arg_485_1.duration_ = 5

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play1109702119(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = 0.525

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

				local var_488_1 = arg_485_1:FormatText(arg_485_1:GetWordFromCfg(1109702118).content)

				arg_485_1.text_.text = var_488_1

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_3 = 21 <= 0 and var_488_0 or var_488_0 * (utf8.len(var_488_1) / 21)

				if (21 <= 0 and var_488_0 or var_488_0 * (utf8.len(var_488_1) / 21)) > 0 and var_488_0 < var_488_3 then
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
	Play1109702119 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 1109702119
		arg_489_1.duration_ = 9

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play1109702120(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			if arg_489_1.bgs_.I09a == nil then
				local var_492_0 = Object.Instantiate(arg_489_1.paintGo_)

				var_492_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I09a")
				var_492_0.name = "I09a"
				var_492_0.transform.parent = arg_489_1.stage_.transform
				var_492_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_489_1.bgs_.I09a = var_492_0
			end

			if 2 < arg_489_1.time_ and arg_489_1.time_ <= 2 + arg_492_0 then
				local var_492_1 = arg_489_1.bgs_.I09a

				arg_489_1.bgs_.I09a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_492_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_492_2 = var_492_1:GetComponent("SpriteRenderer")

				if var_492_2 and var_492_2.sprite then
					local var_492_3 = 2 * (var_492_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_492_1.transform.localScale = Vector3.New(var_492_3 / var_492_2.sprite.bounds.size.y < var_492_3 * manager.ui.mainCameraCom_.aspect / var_492_2.sprite.bounds.size.x and var_492_3 * manager.ui.mainCameraCom_.aspect / var_492_2.sprite.bounds.size.x or var_492_3 / var_492_2.sprite.bounds.size.y, var_492_3 / var_492_2.sprite.bounds.size.y < var_492_3 * manager.ui.mainCameraCom_.aspect / var_492_2.sprite.bounds.size.x and var_492_3 * manager.ui.mainCameraCom_.aspect / var_492_2.sprite.bounds.size.x or var_492_3 / var_492_2.sprite.bounds.size.y, 0)
				end

				for iter_492_0, iter_492_1 in pairs(arg_489_1.bgs_) do
					if iter_492_0 ~= "I09a" then
						iter_492_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_492_4 = 3.999999999999

			if 3.999999999999 < arg_489_1.time_ and arg_489_1.time_ <= var_492_4 + arg_492_0 then
				arg_489_1.allBtn_.enabled = false
			end

			if arg_489_1.time_ >= var_492_4 + 0.3 and arg_489_1.time_ < var_492_4 + 0.3 + arg_492_0 then
				arg_489_1.allBtn_.enabled = true
			end

			local var_492_5 = 0

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_5 + arg_492_0 then
				arg_489_1.mask_.enabled = true
				arg_489_1.mask_.raycastTarget = true

				arg_489_1:SetGaussion(false)
			end

			local var_492_6 = 2

			if var_492_5 <= arg_489_1.time_ and arg_489_1.time_ < var_492_5 + var_492_6 then
				local var_492_7 = Color.New(1, 1, 1)

				var_492_7.a = Mathf.Lerp(0, 1, (arg_489_1.time_ - var_492_5) / var_492_6)
				arg_489_1.mask_.color = var_492_7
			end

			if arg_489_1.time_ >= var_492_5 + var_492_6 and arg_489_1.time_ < var_492_5 + var_492_6 + arg_492_0 then
				local var_492_8 = Color.New(1, 1, 1)

				var_492_8.a = 1
				arg_489_1.mask_.color = var_492_8
			end

			local var_492_9 = 2

			if 2 < arg_489_1.time_ and arg_489_1.time_ <= var_492_9 + arg_492_0 then
				arg_489_1.mask_.enabled = true
				arg_489_1.mask_.raycastTarget = true

				arg_489_1:SetGaussion(false)
			end

			local var_492_10 = 2

			if var_492_9 <= arg_489_1.time_ and arg_489_1.time_ < var_492_9 + var_492_10 then
				local var_492_11 = Color.New(1, 1, 1)

				var_492_11.a = Mathf.Lerp(1, 0, (arg_489_1.time_ - var_492_9) / var_492_10)
				arg_489_1.mask_.color = var_492_11
			end

			if arg_489_1.time_ >= var_492_9 + var_492_10 and arg_489_1.time_ < var_492_9 + var_492_10 + arg_492_0 then
				local var_492_12 = Color.New(1, 1, 1)

				arg_489_1.mask_.enabled = false
				var_492_12.a = 0
				arg_489_1.mask_.color = var_492_12
			end

			local var_492_13 = arg_489_1.actors_["1197ui_story"].transform

			if 1.96599999815226 < arg_489_1.time_ and arg_489_1.time_ <= 1.96599999815226 + arg_492_0 then
				arg_489_1.var_.moveOldPos1197ui_story = var_492_13.localPosition
			end

			local var_492_14 = 0.001

			if 1.96599999815226 <= arg_489_1.time_ and arg_489_1.time_ < 1.96599999815226 + var_492_14 then
				var_492_13.localPosition = Vector3.Lerp(arg_489_1.var_.moveOldPos1197ui_story, Vector3.New(0, 100, 0), (arg_489_1.time_ - 1.96599999815226) / var_492_14)
				var_492_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_492_13.position).x, (manager.ui.mainCamera.transform.position - var_492_13.position).y, (manager.ui.mainCamera.transform.position - var_492_13.position).z)
				var_492_13.localEulerAngles.z = 0
				var_492_13.localEulerAngles.x = 0
				var_492_13.localEulerAngles = var_492_13.localEulerAngles
			end

			if arg_489_1.time_ >= 1.96599999815226 + var_492_14 and arg_489_1.time_ < 1.96599999815226 + var_492_14 + arg_492_0 then
				var_492_13.localPosition = Vector3.New(0, 100, 0)
				var_492_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_492_13.position).x, (manager.ui.mainCamera.transform.position - var_492_13.position).y, (manager.ui.mainCamera.transform.position - var_492_13.position).z)
				var_492_13.localEulerAngles.z = 0
				var_492_13.localEulerAngles.x = 0
				var_492_13.localEulerAngles = var_492_13.localEulerAngles
			end

			local var_492_15 = arg_489_1.actors_["1197ui_story"]

			if 1.96599999815226 < arg_489_1.time_ and arg_489_1.time_ <= 1.96599999815226 + arg_492_0 and not isNil(var_492_15) and arg_489_1.var_.characterEffect1197ui_story == nil then
				arg_489_1.var_.characterEffect1197ui_story = var_492_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_492_16 = 0.034000001847744

			if 1.96599999815226 <= arg_489_1.time_ and arg_489_1.time_ < 1.96599999815226 + var_492_16 and not isNil(var_492_15) then
				if arg_489_1.var_.characterEffect1197ui_story and not isNil(var_492_15) then
					arg_489_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_489_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_489_1.time_ - 1.96599999815226) / var_492_16)
				end
			end

			if arg_489_1.time_ >= 1.96599999815226 + var_492_16 and arg_489_1.time_ < 1.96599999815226 + var_492_16 + arg_492_0 and not isNil(var_492_15) and arg_489_1.var_.characterEffect1197ui_story then
				arg_489_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_489_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			if arg_489_1.frameCnt_ <= 1 then
				arg_489_1.dialog_:SetActive(false)
			end

			local var_492_17 = 4
			local var_492_18 = 0.1

			if 4 < arg_489_1.time_ and arg_489_1.time_ <= var_492_17 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0

				arg_489_1.dialog_:SetActive(true)

				arg_489_1.dialogCg_.alpha = 0

				local var_492_19 = LeanTween.value(arg_489_1.dialog_, 0, 1, 0.3)

				var_492_19:setOnUpdate(LuaHelper.FloatAction(function(arg_493_0)
					arg_489_1.dialogCg_.alpha = arg_493_0
				end))
				var_492_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_489_1.dialog_)
					var_492_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_489_1.duration_ = arg_489_1.duration_ + 0.3

				SetActive(arg_489_1.leftNameGo_, true)

				arg_489_1.leftNameTxt_.text = arg_489_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, true)
				arg_489_1.iconController_:SetSelectedState("hero")

				arg_489_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_489_1.callingController_:SetSelectedState("normal")

				arg_489_1.keyicon_.color = Color.New(1, 1, 1)
				arg_489_1.icon_.color = Color.New(1, 1, 1)

				local var_492_20 = arg_489_1:FormatText(arg_489_1:GetWordFromCfg(1109702119).content)

				arg_489_1.text_.text = var_492_20

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_22 = 4 <= 0 and var_492_18 or var_492_18 * (utf8.len(var_492_20) / 4)

				if (4 <= 0 and var_492_18 or var_492_18 * (utf8.len(var_492_20) / 4)) > 0 and var_492_18 < var_492_22 then
					arg_489_1.talkMaxDuration = var_492_22
					var_492_17 = var_492_17 + 0.3

					if var_492_22 + var_492_17 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_22 + var_492_17
					end
				end

				arg_489_1.text_.text = var_492_20
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_23 = var_492_17 + 0.3
			local var_492_24 = math.max(var_492_18, arg_489_1.talkMaxDuration)

			if var_492_17 + 0.3 <= arg_489_1.time_ and arg_489_1.time_ < var_492_23 + var_492_24 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_23) / var_492_24

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_23 + var_492_24 and arg_489_1.time_ < var_492_23 + var_492_24 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_489_1:InitPlayNodeList()
	end,
	Play1109702120 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 1109702120
		arg_495_1.duration_ = 5

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play1109702121(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = 1.425

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, false)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_1 = arg_495_1:FormatText(arg_495_1:GetWordFromCfg(1109702120).content)

				arg_495_1.text_.text = var_498_1

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_3 = 57 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_1) / 57)

				if (57 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_1) / 57)) > 0 and var_498_0 < var_498_3 then
					arg_495_1.talkMaxDuration = var_498_3

					if var_498_3 + 0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_3 + 0
					end
				end

				arg_495_1.text_.text = var_498_1
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)
				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_4 = math.max(var_498_0, arg_495_1.talkMaxDuration)

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_4 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - 0) / var_498_4

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= 0 + var_498_4 and arg_495_1.time_ < 0 + var_498_4 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play1109702121 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 1109702121
		arg_499_1.duration_ = 3.3

		local var_499_0 = {
			zh = 3.3,
			ja = 1.999999999999
		}
		local var_499_1 = manager.audio:GetLocalizationFlag()

		if var_499_0[var_499_1] ~= nil then
			arg_499_1.duration_ = var_499_0[var_499_1]
		end

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play1109702122(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1.var_.moveOldPos1197ui_story = arg_499_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_502_0 = 0.001

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_0 then
				arg_499_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_499_1.time_ - 0) / var_502_0)
				arg_499_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_499_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["1197ui_story"].transform.position).z)
				arg_499_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_499_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_499_1.actors_["1197ui_story"].transform.localEulerAngles = arg_499_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_499_1.time_ >= 0 + var_502_0 and arg_499_1.time_ < 0 + var_502_0 + arg_502_0 then
				arg_499_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, -0.545, -6.3)
				arg_499_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_499_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["1197ui_story"].transform.position).z)
				arg_499_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_499_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_499_1.actors_["1197ui_story"].transform.localEulerAngles = arg_499_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_502_1 = arg_499_1.actors_["1197ui_story"]

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 and not isNil(var_502_1) and arg_499_1.var_.characterEffect1197ui_story == nil then
				arg_499_1.var_.characterEffect1197ui_story = var_502_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_502_2 = 0.200000002980232

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_2 and not isNil(var_502_1) then
				if arg_499_1.var_.characterEffect1197ui_story and not isNil(var_502_1) then
					arg_499_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_499_1.time_ >= 0 + var_502_2 and arg_499_1.time_ < 0 + var_502_2 + arg_502_0 and not isNil(var_502_1) and arg_499_1.var_.characterEffect1197ui_story then
				arg_499_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action1_1")
			end

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_502_4 = 0
			local var_502_5 = 0.55

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_4 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				arg_499_1.leftNameTxt_.text = arg_499_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_6 = arg_499_1:GetWordFromCfg(1109702121)
				local var_502_7 = arg_499_1:FormatText(var_502_6.content)

				arg_499_1.text_.text = var_502_7

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_9 = 22 <= 0 and var_502_5 or var_502_5 * (utf8.len(var_502_7) / 22)

				if (22 <= 0 and var_502_5 or var_502_5 * (utf8.len(var_502_7) / 22)) > 0 and var_502_5 < var_502_9 then
					arg_499_1.talkMaxDuration = var_502_9

					if var_502_9 + var_502_4 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_9 + var_502_4
					end
				end

				arg_499_1.text_.text = var_502_7
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702121", "story_v_side_new_1109702.awb") ~= 0 then
					local var_502_10 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702121", "story_v_side_new_1109702.awb") / 1000

					if var_502_10 + var_502_4 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_10 + var_502_4
					end

					if var_502_6.prefab_name ~= "" and arg_499_1.actors_[var_502_6.prefab_name] ~= nil then
						local var_502_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_6.prefab_name].transform, "story_v_side_new_1109702", "1109702121", "story_v_side_new_1109702.awb")

						arg_499_1:RecordAudio("1109702121", var_502_11)
						arg_499_1:RecordAudio("1109702121", var_502_11)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702121", "story_v_side_new_1109702.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702121", "story_v_side_new_1109702.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_12 = math.max(var_502_5, arg_499_1.talkMaxDuration)

			if var_502_4 <= arg_499_1.time_ and arg_499_1.time_ < var_502_4 + var_502_12 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_4) / var_502_12

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_4 + var_502_12 and arg_499_1.time_ < var_502_4 + var_502_12 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_499_1:InitPlayNodeList()
	end,
	Play1109702122 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 1109702122
		arg_503_1.duration_ = 2.9

		local var_503_0 = {
			zh = 2.9,
			ja = 2.633
		}
		local var_503_1 = manager.audio:GetLocalizationFlag()

		if var_503_0[var_503_1] ~= nil then
			arg_503_1.duration_ = var_503_0[var_503_1]
		end

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play1109702123(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action9_1")
			end

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_506_0 = 0
			local var_506_1 = 0.275

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_0 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				arg_503_1.leftNameTxt_.text = arg_503_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_2 = arg_503_1:GetWordFromCfg(1109702122)
				local var_506_3 = arg_503_1:FormatText(var_506_2.content)

				arg_503_1.text_.text = var_506_3

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_5 = 11 <= 0 and var_506_1 or var_506_1 * (utf8.len(var_506_3) / 11)

				if (11 <= 0 and var_506_1 or var_506_1 * (utf8.len(var_506_3) / 11)) > 0 and var_506_1 < var_506_5 then
					arg_503_1.talkMaxDuration = var_506_5

					if var_506_5 + var_506_0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_5 + var_506_0
					end
				end

				arg_503_1.text_.text = var_506_3
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702122", "story_v_side_new_1109702.awb") ~= 0 then
					local var_506_6 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702122", "story_v_side_new_1109702.awb") / 1000

					if var_506_6 + var_506_0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_6 + var_506_0
					end

					if var_506_2.prefab_name ~= "" and arg_503_1.actors_[var_506_2.prefab_name] ~= nil then
						local var_506_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_2.prefab_name].transform, "story_v_side_new_1109702", "1109702122", "story_v_side_new_1109702.awb")

						arg_503_1:RecordAudio("1109702122", var_506_7)
						arg_503_1:RecordAudio("1109702122", var_506_7)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702122", "story_v_side_new_1109702.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702122", "story_v_side_new_1109702.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_8 = math.max(var_506_1, arg_503_1.talkMaxDuration)

			if var_506_0 <= arg_503_1.time_ and arg_503_1.time_ < var_506_0 + var_506_8 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_0) / var_506_8

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_0 + var_506_8 and arg_503_1.time_ < var_506_0 + var_506_8 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play1109702123 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 1109702123
		arg_507_1.duration_ = 5

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play1109702124(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 and not isNil(arg_507_1.actors_["1197ui_story"]) and arg_507_1.var_.characterEffect1197ui_story == nil then
				arg_507_1.var_.characterEffect1197ui_story = arg_507_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_510_0 = 0.200000002980232

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_0 and not isNil(arg_507_1.actors_["1197ui_story"]) then
				if arg_507_1.var_.characterEffect1197ui_story and not isNil(arg_507_1.actors_["1197ui_story"]) then
					arg_507_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_507_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_507_1.time_ - 0) / var_510_0)
				end
			end

			if arg_507_1.time_ >= 0 + var_510_0 and arg_507_1.time_ < 0 + var_510_0 + arg_510_0 and not isNil(arg_507_1.actors_["1197ui_story"]) and arg_507_1.var_.characterEffect1197ui_story then
				arg_507_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_507_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_510_1 = 0
			local var_510_2 = 0.275

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_1 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				arg_507_1.leftNameTxt_.text = arg_507_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, true)
				arg_507_1.iconController_:SetSelectedState("hero")

				arg_507_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_507_1.callingController_:SetSelectedState("normal")

				arg_507_1.keyicon_.color = Color.New(1, 1, 1)
				arg_507_1.icon_.color = Color.New(1, 1, 1)

				local var_510_3 = arg_507_1:FormatText(arg_507_1:GetWordFromCfg(1109702123).content)

				arg_507_1.text_.text = var_510_3

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_5 = 11 <= 0 and var_510_2 or var_510_2 * (utf8.len(var_510_3) / 11)

				if (11 <= 0 and var_510_2 or var_510_2 * (utf8.len(var_510_3) / 11)) > 0 and var_510_2 < var_510_5 then
					arg_507_1.talkMaxDuration = var_510_5

					if var_510_5 + var_510_1 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_5 + var_510_1
					end
				end

				arg_507_1.text_.text = var_510_3
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_6 = math.max(var_510_2, arg_507_1.talkMaxDuration)

			if var_510_1 <= arg_507_1.time_ and arg_507_1.time_ < var_510_1 + var_510_6 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_1) / var_510_6

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_1 + var_510_6 and arg_507_1.time_ < var_510_1 + var_510_6 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play1109702124 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 1109702124
		arg_511_1.duration_ = 5

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play1109702125(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1.var_.moveOldPos1197ui_story = arg_511_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_514_0 = 0.001

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_0 then
				arg_511_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_511_1.var_.moveOldPos1197ui_story, Vector3.New(0, 100, 0), (arg_511_1.time_ - 0) / var_514_0)
				arg_511_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_511_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_511_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_511_1.actors_["1197ui_story"].transform.position).z)
				arg_511_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_511_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_511_1.actors_["1197ui_story"].transform.localEulerAngles = arg_511_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_511_1.time_ >= 0 + var_514_0 and arg_511_1.time_ < 0 + var_514_0 + arg_514_0 then
				arg_511_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_511_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_511_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_511_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_511_1.actors_["1197ui_story"].transform.position).z)
				arg_511_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_511_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_511_1.actors_["1197ui_story"].transform.localEulerAngles = arg_511_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_514_1 = 0
			local var_514_2 = 0.9

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_1 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, false)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_3 = arg_511_1:FormatText(arg_511_1:GetWordFromCfg(1109702124).content)

				arg_511_1.text_.text = var_514_3

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_5 = 36 <= 0 and var_514_2 or var_514_2 * (utf8.len(var_514_3) / 36)

				if (36 <= 0 and var_514_2 or var_514_2 * (utf8.len(var_514_3) / 36)) > 0 and var_514_2 < var_514_5 then
					arg_511_1.talkMaxDuration = var_514_5

					if var_514_5 + var_514_1 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_5 + var_514_1
					end
				end

				arg_511_1.text_.text = var_514_3
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)
				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_6 = math.max(var_514_2, arg_511_1.talkMaxDuration)

			if var_514_1 <= arg_511_1.time_ and arg_511_1.time_ < var_514_1 + var_514_6 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_1) / var_514_6

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_1 + var_514_6 and arg_511_1.time_ < var_514_1 + var_514_6 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_511_1:InitPlayNodeList()
	end,
	Play1109702125 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 1109702125
		arg_515_1.duration_ = 5

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play1109702126(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = 0.3

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				arg_515_1.leftNameTxt_.text = arg_515_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, true)
				arg_515_1.iconController_:SetSelectedState("hero")

				arg_515_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_515_1.callingController_:SetSelectedState("normal")

				arg_515_1.keyicon_.color = Color.New(1, 1, 1)
				arg_515_1.icon_.color = Color.New(1, 1, 1)

				local var_518_1 = arg_515_1:FormatText(arg_515_1:GetWordFromCfg(1109702125).content)

				arg_515_1.text_.text = var_518_1

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_3 = 12 <= 0 and var_518_0 or var_518_0 * (utf8.len(var_518_1) / 12)

				if (12 <= 0 and var_518_0 or var_518_0 * (utf8.len(var_518_1) / 12)) > 0 and var_518_0 < var_518_3 then
					arg_515_1.talkMaxDuration = var_518_3

					if var_518_3 + 0 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_3 + 0
					end
				end

				arg_515_1.text_.text = var_518_1
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)
				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_4 = math.max(var_518_0, arg_515_1.talkMaxDuration)

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_4 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - 0) / var_518_4

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= 0 + var_518_4 and arg_515_1.time_ < 0 + var_518_4 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play1109702126 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 1109702126
		arg_519_1.duration_ = 3.6

		local var_519_0 = {
			zh = 2.8,
			ja = 3.6
		}
		local var_519_1 = manager.audio:GetLocalizationFlag()

		if var_519_0[var_519_1] ~= nil then
			arg_519_1.duration_ = var_519_0[var_519_1]
		end

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play1109702127(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1.var_.moveOldPos1197ui_story = arg_519_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_522_0 = 0.001

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_0 then
				arg_519_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_519_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_519_1.time_ - 0) / var_522_0)
				arg_519_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_519_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_519_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_519_1.actors_["1197ui_story"].transform.position).z)
				arg_519_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_519_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_519_1.actors_["1197ui_story"].transform.localEulerAngles = arg_519_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_519_1.time_ >= 0 + var_522_0 and arg_519_1.time_ < 0 + var_522_0 + arg_522_0 then
				arg_519_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, -0.545, -6.3)
				arg_519_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_519_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_519_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_519_1.actors_["1197ui_story"].transform.position).z)
				arg_519_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_519_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_519_1.actors_["1197ui_story"].transform.localEulerAngles = arg_519_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_522_1 = arg_519_1.actors_["1197ui_story"]

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 and not isNil(var_522_1) and arg_519_1.var_.characterEffect1197ui_story == nil then
				arg_519_1.var_.characterEffect1197ui_story = var_522_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_522_2 = 0.200000002980232

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_2 and not isNil(var_522_1) then
				if arg_519_1.var_.characterEffect1197ui_story and not isNil(var_522_1) then
					arg_519_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_519_1.time_ >= 0 + var_522_2 and arg_519_1.time_ < 0 + var_522_2 + arg_522_0 and not isNil(var_522_1) and arg_519_1.var_.characterEffect1197ui_story then
				arg_519_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action7_1")
			end

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_522_4 = 0
			local var_522_5 = 0.55

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_4 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				arg_519_1.leftNameTxt_.text = arg_519_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_6 = arg_519_1:GetWordFromCfg(1109702126)
				local var_522_7 = arg_519_1:FormatText(var_522_6.content)

				arg_519_1.text_.text = var_522_7

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_9 = 22 <= 0 and var_522_5 or var_522_5 * (utf8.len(var_522_7) / 22)

				if (22 <= 0 and var_522_5 or var_522_5 * (utf8.len(var_522_7) / 22)) > 0 and var_522_5 < var_522_9 then
					arg_519_1.talkMaxDuration = var_522_9

					if var_522_9 + var_522_4 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_9 + var_522_4
					end
				end

				arg_519_1.text_.text = var_522_7
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702126", "story_v_side_new_1109702.awb") ~= 0 then
					local var_522_10 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702126", "story_v_side_new_1109702.awb") / 1000

					if var_522_10 + var_522_4 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_10 + var_522_4
					end

					if var_522_6.prefab_name ~= "" and arg_519_1.actors_[var_522_6.prefab_name] ~= nil then
						local var_522_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_6.prefab_name].transform, "story_v_side_new_1109702", "1109702126", "story_v_side_new_1109702.awb")

						arg_519_1:RecordAudio("1109702126", var_522_11)
						arg_519_1:RecordAudio("1109702126", var_522_11)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702126", "story_v_side_new_1109702.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702126", "story_v_side_new_1109702.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_12 = math.max(var_522_5, arg_519_1.talkMaxDuration)

			if var_522_4 <= arg_519_1.time_ and arg_519_1.time_ < var_522_4 + var_522_12 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_4) / var_522_12

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_4 + var_522_12 and arg_519_1.time_ < var_522_4 + var_522_12 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_519_1:InitPlayNodeList()
	end,
	Play1109702127 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 1109702127
		arg_523_1.duration_ = 5

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play1109702128(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 and not isNil(arg_523_1.actors_["1197ui_story"]) and arg_523_1.var_.characterEffect1197ui_story == nil then
				arg_523_1.var_.characterEffect1197ui_story = arg_523_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_526_0 = 0.200000002980232

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_0 and not isNil(arg_523_1.actors_["1197ui_story"]) then
				if arg_523_1.var_.characterEffect1197ui_story and not isNil(arg_523_1.actors_["1197ui_story"]) then
					arg_523_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_523_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_523_1.time_ - 0) / var_526_0)
				end
			end

			if arg_523_1.time_ >= 0 + var_526_0 and arg_523_1.time_ < 0 + var_526_0 + arg_526_0 and not isNil(arg_523_1.actors_["1197ui_story"]) and arg_523_1.var_.characterEffect1197ui_story then
				arg_523_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_523_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_526_1 = 0
			local var_526_2 = 0.85

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= var_526_1 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				arg_523_1.leftNameTxt_.text = arg_523_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, true)
				arg_523_1.iconController_:SetSelectedState("hero")

				arg_523_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_523_1.callingController_:SetSelectedState("normal")

				arg_523_1.keyicon_.color = Color.New(1, 1, 1)
				arg_523_1.icon_.color = Color.New(1, 1, 1)

				local var_526_3 = arg_523_1:FormatText(arg_523_1:GetWordFromCfg(1109702127).content)

				arg_523_1.text_.text = var_526_3

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_5 = 34 <= 0 and var_526_2 or var_526_2 * (utf8.len(var_526_3) / 34)

				if (34 <= 0 and var_526_2 or var_526_2 * (utf8.len(var_526_3) / 34)) > 0 and var_526_2 < var_526_5 then
					arg_523_1.talkMaxDuration = var_526_5

					if var_526_5 + var_526_1 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_5 + var_526_1
					end
				end

				arg_523_1.text_.text = var_526_3
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_6 = math.max(var_526_2, arg_523_1.talkMaxDuration)

			if var_526_1 <= arg_523_1.time_ and arg_523_1.time_ < var_526_1 + var_526_6 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_1) / var_526_6

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_1 + var_526_6 and arg_523_1.time_ < var_526_1 + var_526_6 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play1109702128 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 1109702128
		arg_527_1.duration_ = 2.73

		local var_527_0 = {
			zh = 1.999999999999,
			ja = 2.733
		}
		local var_527_1 = manager.audio:GetLocalizationFlag()

		if var_527_0[var_527_1] ~= nil then
			arg_527_1.duration_ = var_527_0[var_527_1]
		end

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play1109702129(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 and not isNil(arg_527_1.actors_["1197ui_story"]) and arg_527_1.var_.characterEffect1197ui_story == nil then
				arg_527_1.var_.characterEffect1197ui_story = arg_527_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_530_0 = 0.200000002980232

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_0 and not isNil(arg_527_1.actors_["1197ui_story"]) then
				if arg_527_1.var_.characterEffect1197ui_story and not isNil(arg_527_1.actors_["1197ui_story"]) then
					arg_527_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_527_1.time_ >= 0 + var_530_0 and arg_527_1.time_ < 0 + var_530_0 + arg_530_0 and not isNil(arg_527_1.actors_["1197ui_story"]) and arg_527_1.var_.characterEffect1197ui_story then
				arg_527_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action7_2")
			end

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_530_2 = 0
			local var_530_3 = 0.15

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= var_530_2 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				arg_527_1.leftNameTxt_.text = arg_527_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_4 = arg_527_1:GetWordFromCfg(1109702128)
				local var_530_5 = arg_527_1:FormatText(var_530_4.content)

				arg_527_1.text_.text = var_530_5

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_7 = 6 <= 0 and var_530_3 or var_530_3 * (utf8.len(var_530_5) / 6)

				if (6 <= 0 and var_530_3 or var_530_3 * (utf8.len(var_530_5) / 6)) > 0 and var_530_3 < var_530_7 then
					arg_527_1.talkMaxDuration = var_530_7

					if var_530_7 + var_530_2 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_7 + var_530_2
					end
				end

				arg_527_1.text_.text = var_530_5
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702128", "story_v_side_new_1109702.awb") ~= 0 then
					local var_530_8 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702128", "story_v_side_new_1109702.awb") / 1000

					if var_530_8 + var_530_2 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_8 + var_530_2
					end

					if var_530_4.prefab_name ~= "" and arg_527_1.actors_[var_530_4.prefab_name] ~= nil then
						local var_530_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_527_1.actors_[var_530_4.prefab_name].transform, "story_v_side_new_1109702", "1109702128", "story_v_side_new_1109702.awb")

						arg_527_1:RecordAudio("1109702128", var_530_9)
						arg_527_1:RecordAudio("1109702128", var_530_9)
					else
						arg_527_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702128", "story_v_side_new_1109702.awb")
					end

					arg_527_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702128", "story_v_side_new_1109702.awb")
				end

				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_10 = math.max(var_530_3, arg_527_1.talkMaxDuration)

			if var_530_2 <= arg_527_1.time_ and arg_527_1.time_ < var_530_2 + var_530_10 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_2) / var_530_10

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_2 + var_530_10 and arg_527_1.time_ < var_530_2 + var_530_10 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play1109702129 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 1109702129
		arg_531_1.duration_ = 5

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play1109702130(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 and not isNil(arg_531_1.actors_["1197ui_story"]) and arg_531_1.var_.characterEffect1197ui_story == nil then
				arg_531_1.var_.characterEffect1197ui_story = arg_531_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_534_0 = 0.200000002980232

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_0 and not isNil(arg_531_1.actors_["1197ui_story"]) then
				if arg_531_1.var_.characterEffect1197ui_story and not isNil(arg_531_1.actors_["1197ui_story"]) then
					arg_531_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_531_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_531_1.time_ - 0) / var_534_0)
				end
			end

			if arg_531_1.time_ >= 0 + var_534_0 and arg_531_1.time_ < 0 + var_534_0 + arg_534_0 and not isNil(arg_531_1.actors_["1197ui_story"]) and arg_531_1.var_.characterEffect1197ui_story then
				arg_531_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_531_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_534_1 = 0
			local var_534_2 = 0.75

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= var_534_1 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, false)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_3 = arg_531_1:FormatText(arg_531_1:GetWordFromCfg(1109702129).content)

				arg_531_1.text_.text = var_534_3

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_5 = 30 <= 0 and var_534_2 or var_534_2 * (utf8.len(var_534_3) / 30)

				if (30 <= 0 and var_534_2 or var_534_2 * (utf8.len(var_534_3) / 30)) > 0 and var_534_2 < var_534_5 then
					arg_531_1.talkMaxDuration = var_534_5

					if var_534_5 + var_534_1 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_5 + var_534_1
					end
				end

				arg_531_1.text_.text = var_534_3
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)
				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_6 = math.max(var_534_2, arg_531_1.talkMaxDuration)

			if var_534_1 <= arg_531_1.time_ and arg_531_1.time_ < var_534_1 + var_534_6 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_1) / var_534_6

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_1 + var_534_6 and arg_531_1.time_ < var_534_1 + var_534_6 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play1109702130 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 1109702130
		arg_535_1.duration_ = 4.27

		local var_535_0 = {
			zh = 3.533,
			ja = 4.266
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
				arg_535_0:Play1109702131(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 and not isNil(arg_535_1.actors_["1197ui_story"]) and arg_535_1.var_.characterEffect1197ui_story == nil then
				arg_535_1.var_.characterEffect1197ui_story = arg_535_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_538_0 = 0.200000002980232

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_0 and not isNil(arg_535_1.actors_["1197ui_story"]) then
				if arg_535_1.var_.characterEffect1197ui_story and not isNil(arg_535_1.actors_["1197ui_story"]) then
					arg_535_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_535_1.time_ >= 0 + var_538_0 and arg_535_1.time_ < 0 + var_538_0 + arg_538_0 and not isNil(arg_535_1.actors_["1197ui_story"]) and arg_535_1.var_.characterEffect1197ui_story then
				arg_535_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_538_2 = 0
			local var_538_3 = 0.35

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= var_538_2 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				arg_535_1.leftNameTxt_.text = arg_535_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_4 = arg_535_1:GetWordFromCfg(1109702130)
				local var_538_5 = arg_535_1:FormatText(var_538_4.content)

				arg_535_1.text_.text = var_538_5

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_7 = 14 <= 0 and var_538_3 or var_538_3 * (utf8.len(var_538_5) / 14)

				if (14 <= 0 and var_538_3 or var_538_3 * (utf8.len(var_538_5) / 14)) > 0 and var_538_3 < var_538_7 then
					arg_535_1.talkMaxDuration = var_538_7

					if var_538_7 + var_538_2 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_7 + var_538_2
					end
				end

				arg_535_1.text_.text = var_538_5
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702130", "story_v_side_new_1109702.awb") ~= 0 then
					local var_538_8 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702130", "story_v_side_new_1109702.awb") / 1000

					if var_538_8 + var_538_2 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_8 + var_538_2
					end

					if var_538_4.prefab_name ~= "" and arg_535_1.actors_[var_538_4.prefab_name] ~= nil then
						local var_538_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_535_1.actors_[var_538_4.prefab_name].transform, "story_v_side_new_1109702", "1109702130", "story_v_side_new_1109702.awb")

						arg_535_1:RecordAudio("1109702130", var_538_9)
						arg_535_1:RecordAudio("1109702130", var_538_9)
					else
						arg_535_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702130", "story_v_side_new_1109702.awb")
					end

					arg_535_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702130", "story_v_side_new_1109702.awb")
				end

				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_10 = math.max(var_538_3, arg_535_1.talkMaxDuration)

			if var_538_2 <= arg_535_1.time_ and arg_535_1.time_ < var_538_2 + var_538_10 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_2) / var_538_10

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_2 + var_538_10 and arg_535_1.time_ < var_538_2 + var_538_10 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {}

		arg_535_1:InitPlayNodeList()
	end,
	Play1109702131 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 1109702131
		arg_539_1.duration_ = 5

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play1109702132(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 and not isNil(arg_539_1.actors_["1197ui_story"]) and arg_539_1.var_.characterEffect1197ui_story == nil then
				arg_539_1.var_.characterEffect1197ui_story = arg_539_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_542_0 = 0.200000002980232

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_0 and not isNil(arg_539_1.actors_["1197ui_story"]) then
				if arg_539_1.var_.characterEffect1197ui_story and not isNil(arg_539_1.actors_["1197ui_story"]) then
					arg_539_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_539_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_539_1.time_ - 0) / var_542_0)
				end
			end

			if arg_539_1.time_ >= 0 + var_542_0 and arg_539_1.time_ < 0 + var_542_0 + arg_542_0 and not isNil(arg_539_1.actors_["1197ui_story"]) and arg_539_1.var_.characterEffect1197ui_story then
				arg_539_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_539_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_542_1 = 0
			local var_542_2 = 0.375

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

				local var_542_3 = arg_539_1:FormatText(arg_539_1:GetWordFromCfg(1109702131).content)

				arg_539_1.text_.text = var_542_3

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_5 = 15 <= 0 and var_542_2 or var_542_2 * (utf8.len(var_542_3) / 15)

				if (15 <= 0 and var_542_2 or var_542_2 * (utf8.len(var_542_3) / 15)) > 0 and var_542_2 < var_542_5 then
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
	Play1109702132 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 1109702132
		arg_543_1.duration_ = 6.87

		local var_543_0 = {
			zh = 2.8,
			ja = 6.866
		}
		local var_543_1 = manager.audio:GetLocalizationFlag()

		if var_543_0[var_543_1] ~= nil then
			arg_543_1.duration_ = var_543_0[var_543_1]
		end

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play1109702133(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 and not isNil(arg_543_1.actors_["1197ui_story"]) and arg_543_1.var_.characterEffect1197ui_story == nil then
				arg_543_1.var_.characterEffect1197ui_story = arg_543_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_546_0 = 0.200000002980232

			if 0 <= arg_543_1.time_ and arg_543_1.time_ < 0 + var_546_0 and not isNil(arg_543_1.actors_["1197ui_story"]) then
				if arg_543_1.var_.characterEffect1197ui_story and not isNil(arg_543_1.actors_["1197ui_story"]) then
					arg_543_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_543_1.time_ >= 0 + var_546_0 and arg_543_1.time_ < 0 + var_546_0 + arg_546_0 and not isNil(arg_543_1.actors_["1197ui_story"]) and arg_543_1.var_.characterEffect1197ui_story then
				arg_543_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 then
				arg_543_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_546_2 = 0
			local var_546_3 = 0.525

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= var_546_2 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				arg_543_1.leftNameTxt_.text = arg_543_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_4 = arg_543_1:GetWordFromCfg(1109702132)
				local var_546_5 = arg_543_1:FormatText(var_546_4.content)

				arg_543_1.text_.text = var_546_5

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_7 = 21 <= 0 and var_546_3 or var_546_3 * (utf8.len(var_546_5) / 21)

				if (21 <= 0 and var_546_3 or var_546_3 * (utf8.len(var_546_5) / 21)) > 0 and var_546_3 < var_546_7 then
					arg_543_1.talkMaxDuration = var_546_7

					if var_546_7 + var_546_2 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_7 + var_546_2
					end
				end

				arg_543_1.text_.text = var_546_5
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702132", "story_v_side_new_1109702.awb") ~= 0 then
					local var_546_8 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702132", "story_v_side_new_1109702.awb") / 1000

					if var_546_8 + var_546_2 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_8 + var_546_2
					end

					if var_546_4.prefab_name ~= "" and arg_543_1.actors_[var_546_4.prefab_name] ~= nil then
						local var_546_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_543_1.actors_[var_546_4.prefab_name].transform, "story_v_side_new_1109702", "1109702132", "story_v_side_new_1109702.awb")

						arg_543_1:RecordAudio("1109702132", var_546_9)
						arg_543_1:RecordAudio("1109702132", var_546_9)
					else
						arg_543_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702132", "story_v_side_new_1109702.awb")
					end

					arg_543_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702132", "story_v_side_new_1109702.awb")
				end

				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_10 = math.max(var_546_3, arg_543_1.talkMaxDuration)

			if var_546_2 <= arg_543_1.time_ and arg_543_1.time_ < var_546_2 + var_546_10 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_2) / var_546_10

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_2 + var_546_10 and arg_543_1.time_ < var_546_2 + var_546_10 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {}

		arg_543_1:InitPlayNodeList()
	end,
	Play1109702133 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 1109702133
		arg_547_1.duration_ = 5

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play1109702134(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 and not isNil(arg_547_1.actors_["1197ui_story"]) and arg_547_1.var_.characterEffect1197ui_story == nil then
				arg_547_1.var_.characterEffect1197ui_story = arg_547_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_550_0 = 0.200000002980232

			if 0 <= arg_547_1.time_ and arg_547_1.time_ < 0 + var_550_0 and not isNil(arg_547_1.actors_["1197ui_story"]) then
				if arg_547_1.var_.characterEffect1197ui_story and not isNil(arg_547_1.actors_["1197ui_story"]) then
					arg_547_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_547_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_547_1.time_ - 0) / var_550_0)
				end
			end

			if arg_547_1.time_ >= 0 + var_550_0 and arg_547_1.time_ < 0 + var_550_0 + arg_550_0 and not isNil(arg_547_1.actors_["1197ui_story"]) and arg_547_1.var_.characterEffect1197ui_story then
				arg_547_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_547_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_550_1 = 0
			local var_550_2 = 0.25

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= var_550_1 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, true)

				arg_547_1.leftNameTxt_.text = arg_547_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_547_1.leftNameTxt_.transform)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1.leftNameTxt_.text)
				SetActive(arg_547_1.iconTrs_.gameObject, true)
				arg_547_1.iconController_:SetSelectedState("hero")

				arg_547_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_547_1.callingController_:SetSelectedState("normal")

				arg_547_1.keyicon_.color = Color.New(1, 1, 1)
				arg_547_1.icon_.color = Color.New(1, 1, 1)

				local var_550_3 = arg_547_1:FormatText(arg_547_1:GetWordFromCfg(1109702133).content)

				arg_547_1.text_.text = var_550_3

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_5 = 10 <= 0 and var_550_2 or var_550_2 * (utf8.len(var_550_3) / 10)

				if (10 <= 0 and var_550_2 or var_550_2 * (utf8.len(var_550_3) / 10)) > 0 and var_550_2 < var_550_5 then
					arg_547_1.talkMaxDuration = var_550_5

					if var_550_5 + var_550_1 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_5 + var_550_1
					end
				end

				arg_547_1.text_.text = var_550_3
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)
				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_6 = math.max(var_550_2, arg_547_1.talkMaxDuration)

			if var_550_1 <= arg_547_1.time_ and arg_547_1.time_ < var_550_1 + var_550_6 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - var_550_1) / var_550_6

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= var_550_1 + var_550_6 and arg_547_1.time_ < var_550_1 + var_550_6 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {}

		arg_547_1:InitPlayNodeList()
	end,
	Play1109702134 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 1109702134
		arg_551_1.duration_ = 5

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play1109702135(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			local var_554_0 = 0.75

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, false)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_551_1.iconTrs_.gameObject, false)
				arg_551_1.callingController_:SetSelectedState("normal")

				local var_554_1 = arg_551_1:FormatText(arg_551_1:GetWordFromCfg(1109702134).content)

				arg_551_1.text_.text = var_554_1

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_3 = 30 <= 0 and var_554_0 or var_554_0 * (utf8.len(var_554_1) / 30)

				if (30 <= 0 and var_554_0 or var_554_0 * (utf8.len(var_554_1) / 30)) > 0 and var_554_0 < var_554_3 then
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
	Play1109702135 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 1109702135
		arg_555_1.duration_ = 2.5

		local var_555_0 = {
			zh = 2.5,
			ja = 1.999999999999
		}
		local var_555_1 = manager.audio:GetLocalizationFlag()

		if var_555_0[var_555_1] ~= nil then
			arg_555_1.duration_ = var_555_0[var_555_1]
		end

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play1109702136(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 and not isNil(arg_555_1.actors_["1197ui_story"]) and arg_555_1.var_.characterEffect1197ui_story == nil then
				arg_555_1.var_.characterEffect1197ui_story = arg_555_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_558_0 = 0.200000002980232

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_0 and not isNil(arg_555_1.actors_["1197ui_story"]) then
				if arg_555_1.var_.characterEffect1197ui_story and not isNil(arg_555_1.actors_["1197ui_story"]) then
					arg_555_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_555_1.time_ >= 0 + var_558_0 and arg_555_1.time_ < 0 + var_558_0 + arg_558_0 and not isNil(arg_555_1.actors_["1197ui_story"]) and arg_555_1.var_.characterEffect1197ui_story then
				arg_555_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 then
				arg_555_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action7_1")
			end

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 then
				arg_555_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_558_2 = 0
			local var_558_3 = 0.275

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= var_558_2 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, true)

				arg_555_1.leftNameTxt_.text = arg_555_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_555_1.leftNameTxt_.transform)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1.leftNameTxt_.text)
				SetActive(arg_555_1.iconTrs_.gameObject, false)
				arg_555_1.callingController_:SetSelectedState("normal")

				local var_558_4 = arg_555_1:GetWordFromCfg(1109702135)
				local var_558_5 = arg_555_1:FormatText(var_558_4.content)

				arg_555_1.text_.text = var_558_5

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_7 = 11 <= 0 and var_558_3 or var_558_3 * (utf8.len(var_558_5) / 11)

				if (11 <= 0 and var_558_3 or var_558_3 * (utf8.len(var_558_5) / 11)) > 0 and var_558_3 < var_558_7 then
					arg_555_1.talkMaxDuration = var_558_7

					if var_558_7 + var_558_2 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_7 + var_558_2
					end
				end

				arg_555_1.text_.text = var_558_5
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702135", "story_v_side_new_1109702.awb") ~= 0 then
					local var_558_8 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702135", "story_v_side_new_1109702.awb") / 1000

					if var_558_8 + var_558_2 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_8 + var_558_2
					end

					if var_558_4.prefab_name ~= "" and arg_555_1.actors_[var_558_4.prefab_name] ~= nil then
						local var_558_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_555_1.actors_[var_558_4.prefab_name].transform, "story_v_side_new_1109702", "1109702135", "story_v_side_new_1109702.awb")

						arg_555_1:RecordAudio("1109702135", var_558_9)
						arg_555_1:RecordAudio("1109702135", var_558_9)
					else
						arg_555_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702135", "story_v_side_new_1109702.awb")
					end

					arg_555_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702135", "story_v_side_new_1109702.awb")
				end

				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_10 = math.max(var_558_3, arg_555_1.talkMaxDuration)

			if var_558_2 <= arg_555_1.time_ and arg_555_1.time_ < var_558_2 + var_558_10 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_2) / var_558_10

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_2 + var_558_10 and arg_555_1.time_ < var_558_2 + var_558_10 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {}

		arg_555_1:InitPlayNodeList()
	end,
	Play1109702136 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 1109702136
		arg_559_1.duration_ = 5

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play1109702137(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 and not isNil(arg_559_1.actors_["1197ui_story"]) and arg_559_1.var_.characterEffect1197ui_story == nil then
				arg_559_1.var_.characterEffect1197ui_story = arg_559_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_562_0 = 0.200000002980232

			if 0 <= arg_559_1.time_ and arg_559_1.time_ < 0 + var_562_0 and not isNil(arg_559_1.actors_["1197ui_story"]) then
				if arg_559_1.var_.characterEffect1197ui_story and not isNil(arg_559_1.actors_["1197ui_story"]) then
					arg_559_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_559_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_559_1.time_ - 0) / var_562_0)
				end
			end

			if arg_559_1.time_ >= 0 + var_562_0 and arg_559_1.time_ < 0 + var_562_0 + arg_562_0 and not isNil(arg_559_1.actors_["1197ui_story"]) and arg_559_1.var_.characterEffect1197ui_story then
				arg_559_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_559_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_562_1 = 0
			local var_562_2 = 0.05

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= var_562_1 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, true)

				arg_559_1.leftNameTxt_.text = arg_559_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_559_1.leftNameTxt_.transform)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1.leftNameTxt_.text)
				SetActive(arg_559_1.iconTrs_.gameObject, true)
				arg_559_1.iconController_:SetSelectedState("hero")

				arg_559_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_559_1.callingController_:SetSelectedState("normal")

				arg_559_1.keyicon_.color = Color.New(1, 1, 1)
				arg_559_1.icon_.color = Color.New(1, 1, 1)

				local var_562_3 = arg_559_1:FormatText(arg_559_1:GetWordFromCfg(1109702136).content)

				arg_559_1.text_.text = var_562_3

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_5 = 2 <= 0 and var_562_2 or var_562_2 * (utf8.len(var_562_3) / 2)

				if (2 <= 0 and var_562_2 or var_562_2 * (utf8.len(var_562_3) / 2)) > 0 and var_562_2 < var_562_5 then
					arg_559_1.talkMaxDuration = var_562_5

					if var_562_5 + var_562_1 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_5 + var_562_1
					end
				end

				arg_559_1.text_.text = var_562_3
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)
				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_6 = math.max(var_562_2, arg_559_1.talkMaxDuration)

			if var_562_1 <= arg_559_1.time_ and arg_559_1.time_ < var_562_1 + var_562_6 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - var_562_1) / var_562_6

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= var_562_1 + var_562_6 and arg_559_1.time_ < var_562_1 + var_562_6 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {}

		arg_559_1:InitPlayNodeList()
	end,
	Play1109702137 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 1109702137
		arg_563_1.duration_ = 5

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play1109702138(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			local var_566_0 = 0.75

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, false)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_563_1.iconTrs_.gameObject, false)
				arg_563_1.callingController_:SetSelectedState("normal")

				local var_566_1 = arg_563_1:FormatText(arg_563_1:GetWordFromCfg(1109702137).content)

				arg_563_1.text_.text = var_566_1

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_3 = 30 <= 0 and var_566_0 or var_566_0 * (utf8.len(var_566_1) / 30)

				if (30 <= 0 and var_566_0 or var_566_0 * (utf8.len(var_566_1) / 30)) > 0 and var_566_0 < var_566_3 then
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
	Play1109702138 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 1109702138
		arg_567_1.duration_ = 2.9

		local var_567_0 = {
			zh = 2.3,
			ja = 2.9
		}
		local var_567_1 = manager.audio:GetLocalizationFlag()

		if var_567_0[var_567_1] ~= nil then
			arg_567_1.duration_ = var_567_0[var_567_1]
		end

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play1109702139(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			if 0 < arg_567_1.time_ and arg_567_1.time_ <= 0 + arg_570_0 and not isNil(arg_567_1.actors_["1197ui_story"]) and arg_567_1.var_.characterEffect1197ui_story == nil then
				arg_567_1.var_.characterEffect1197ui_story = arg_567_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_570_0 = 0.200000002980232

			if 0 <= arg_567_1.time_ and arg_567_1.time_ < 0 + var_570_0 and not isNil(arg_567_1.actors_["1197ui_story"]) then
				if arg_567_1.var_.characterEffect1197ui_story and not isNil(arg_567_1.actors_["1197ui_story"]) then
					arg_567_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_567_1.time_ >= 0 + var_570_0 and arg_567_1.time_ < 0 + var_570_0 + arg_570_0 and not isNil(arg_567_1.actors_["1197ui_story"]) and arg_567_1.var_.characterEffect1197ui_story then
				arg_567_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= 0 + arg_570_0 then
				arg_567_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action7_2")
			end

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= 0 + arg_570_0 then
				arg_567_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_570_2 = 0
			local var_570_3 = 0.175

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= var_570_2 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, true)

				arg_567_1.leftNameTxt_.text = arg_567_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_567_1.leftNameTxt_.transform)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1.leftNameTxt_.text)
				SetActive(arg_567_1.iconTrs_.gameObject, false)
				arg_567_1.callingController_:SetSelectedState("normal")

				local var_570_4 = arg_567_1:GetWordFromCfg(1109702138)
				local var_570_5 = arg_567_1:FormatText(var_570_4.content)

				arg_567_1.text_.text = var_570_5

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_7 = 7 <= 0 and var_570_3 or var_570_3 * (utf8.len(var_570_5) / 7)

				if (7 <= 0 and var_570_3 or var_570_3 * (utf8.len(var_570_5) / 7)) > 0 and var_570_3 < var_570_7 then
					arg_567_1.talkMaxDuration = var_570_7

					if var_570_7 + var_570_2 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_7 + var_570_2
					end
				end

				arg_567_1.text_.text = var_570_5
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702138", "story_v_side_new_1109702.awb") ~= 0 then
					local var_570_8 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702138", "story_v_side_new_1109702.awb") / 1000

					if var_570_8 + var_570_2 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_8 + var_570_2
					end

					if var_570_4.prefab_name ~= "" and arg_567_1.actors_[var_570_4.prefab_name] ~= nil then
						local var_570_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_567_1.actors_[var_570_4.prefab_name].transform, "story_v_side_new_1109702", "1109702138", "story_v_side_new_1109702.awb")

						arg_567_1:RecordAudio("1109702138", var_570_9)
						arg_567_1:RecordAudio("1109702138", var_570_9)
					else
						arg_567_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702138", "story_v_side_new_1109702.awb")
					end

					arg_567_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702138", "story_v_side_new_1109702.awb")
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
	Play1109702139 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 1109702139
		arg_571_1.duration_ = 5

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play1109702140(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			if 0 < arg_571_1.time_ and arg_571_1.time_ <= 0 + arg_574_0 and not isNil(arg_571_1.actors_["1197ui_story"]) and arg_571_1.var_.characterEffect1197ui_story == nil then
				arg_571_1.var_.characterEffect1197ui_story = arg_571_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_574_0 = 0.200000002980232

			if 0 <= arg_571_1.time_ and arg_571_1.time_ < 0 + var_574_0 and not isNil(arg_571_1.actors_["1197ui_story"]) then
				if arg_571_1.var_.characterEffect1197ui_story and not isNil(arg_571_1.actors_["1197ui_story"]) then
					arg_571_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_571_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_571_1.time_ - 0) / var_574_0)
				end
			end

			if arg_571_1.time_ >= 0 + var_574_0 and arg_571_1.time_ < 0 + var_574_0 + arg_574_0 and not isNil(arg_571_1.actors_["1197ui_story"]) and arg_571_1.var_.characterEffect1197ui_story then
				arg_571_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_571_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_574_1 = 0
			local var_574_2 = 0.075

			if 0 < arg_571_1.time_ and arg_571_1.time_ <= var_574_1 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, true)

				arg_571_1.leftNameTxt_.text = arg_571_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_571_1.leftNameTxt_.transform)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1.leftNameTxt_.text)
				SetActive(arg_571_1.iconTrs_.gameObject, true)
				arg_571_1.iconController_:SetSelectedState("hero")

				arg_571_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_571_1.callingController_:SetSelectedState("normal")

				arg_571_1.keyicon_.color = Color.New(1, 1, 1)
				arg_571_1.icon_.color = Color.New(1, 1, 1)

				local var_574_3 = arg_571_1:FormatText(arg_571_1:GetWordFromCfg(1109702139).content)

				arg_571_1.text_.text = var_574_3

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_5 = 3 <= 0 and var_574_2 or var_574_2 * (utf8.len(var_574_3) / 3)

				if (3 <= 0 and var_574_2 or var_574_2 * (utf8.len(var_574_3) / 3)) > 0 and var_574_2 < var_574_5 then
					arg_571_1.talkMaxDuration = var_574_5

					if var_574_5 + var_574_1 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_5 + var_574_1
					end
				end

				arg_571_1.text_.text = var_574_3
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)
				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_6 = math.max(var_574_2, arg_571_1.talkMaxDuration)

			if var_574_1 <= arg_571_1.time_ and arg_571_1.time_ < var_574_1 + var_574_6 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - var_574_1) / var_574_6

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= var_574_1 + var_574_6 and arg_571_1.time_ < var_574_1 + var_574_6 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {}

		arg_571_1:InitPlayNodeList()
	end,
	Play1109702140 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 1109702140
		arg_575_1.duration_ = 3.77

		local var_575_0 = {
			zh = 3.766,
			ja = 3.733
		}
		local var_575_1 = manager.audio:GetLocalizationFlag()

		if var_575_0[var_575_1] ~= nil then
			arg_575_1.duration_ = var_575_0[var_575_1]
		end

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play1109702141(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 and not isNil(arg_575_1.actors_["1197ui_story"]) and arg_575_1.var_.characterEffect1197ui_story == nil then
				arg_575_1.var_.characterEffect1197ui_story = arg_575_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_578_0 = 0.200000002980232

			if 0 <= arg_575_1.time_ and arg_575_1.time_ < 0 + var_578_0 and not isNil(arg_575_1.actors_["1197ui_story"]) then
				if arg_575_1.var_.characterEffect1197ui_story and not isNil(arg_575_1.actors_["1197ui_story"]) then
					arg_575_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_575_1.time_ >= 0 + var_578_0 and arg_575_1.time_ < 0 + var_578_0 + arg_578_0 and not isNil(arg_575_1.actors_["1197ui_story"]) and arg_575_1.var_.characterEffect1197ui_story then
				arg_575_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 then
				arg_575_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_578_2 = 0
			local var_578_3 = 0.375

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= var_578_2 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, true)

				arg_575_1.leftNameTxt_.text = arg_575_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_575_1.leftNameTxt_.transform)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1.leftNameTxt_.text)
				SetActive(arg_575_1.iconTrs_.gameObject, false)
				arg_575_1.callingController_:SetSelectedState("normal")

				local var_578_4 = arg_575_1:GetWordFromCfg(1109702140)
				local var_578_5 = arg_575_1:FormatText(var_578_4.content)

				arg_575_1.text_.text = var_578_5

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_7 = 15 <= 0 and var_578_3 or var_578_3 * (utf8.len(var_578_5) / 15)

				if (15 <= 0 and var_578_3 or var_578_3 * (utf8.len(var_578_5) / 15)) > 0 and var_578_3 < var_578_7 then
					arg_575_1.talkMaxDuration = var_578_7

					if var_578_7 + var_578_2 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_7 + var_578_2
					end
				end

				arg_575_1.text_.text = var_578_5
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702140", "story_v_side_new_1109702.awb") ~= 0 then
					local var_578_8 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702140", "story_v_side_new_1109702.awb") / 1000

					if var_578_8 + var_578_2 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_8 + var_578_2
					end

					if var_578_4.prefab_name ~= "" and arg_575_1.actors_[var_578_4.prefab_name] ~= nil then
						local var_578_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_575_1.actors_[var_578_4.prefab_name].transform, "story_v_side_new_1109702", "1109702140", "story_v_side_new_1109702.awb")

						arg_575_1:RecordAudio("1109702140", var_578_9)
						arg_575_1:RecordAudio("1109702140", var_578_9)
					else
						arg_575_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702140", "story_v_side_new_1109702.awb")
					end

					arg_575_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702140", "story_v_side_new_1109702.awb")
				end

				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_10 = math.max(var_578_3, arg_575_1.talkMaxDuration)

			if var_578_2 <= arg_575_1.time_ and arg_575_1.time_ < var_578_2 + var_578_10 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - var_578_2) / var_578_10

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= var_578_2 + var_578_10 and arg_575_1.time_ < var_578_2 + var_578_10 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {}

		arg_575_1:InitPlayNodeList()
	end,
	Play1109702141 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 1109702141
		arg_579_1.duration_ = 5

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play1109702142(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			if 0 < arg_579_1.time_ and arg_579_1.time_ <= 0 + arg_582_0 and not isNil(arg_579_1.actors_["1197ui_story"]) and arg_579_1.var_.characterEffect1197ui_story == nil then
				arg_579_1.var_.characterEffect1197ui_story = arg_579_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_582_0 = 0.200000002980232

			if 0 <= arg_579_1.time_ and arg_579_1.time_ < 0 + var_582_0 and not isNil(arg_579_1.actors_["1197ui_story"]) then
				if arg_579_1.var_.characterEffect1197ui_story and not isNil(arg_579_1.actors_["1197ui_story"]) then
					arg_579_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_579_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_579_1.time_ - 0) / var_582_0)
				end
			end

			if arg_579_1.time_ >= 0 + var_582_0 and arg_579_1.time_ < 0 + var_582_0 + arg_582_0 and not isNil(arg_579_1.actors_["1197ui_story"]) and arg_579_1.var_.characterEffect1197ui_story then
				arg_579_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_579_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_582_1 = 0
			local var_582_2 = 0.1

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

				local var_582_3 = arg_579_1:FormatText(arg_579_1:GetWordFromCfg(1109702141).content)

				arg_579_1.text_.text = var_582_3

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_5 = 4 <= 0 and var_582_2 or var_582_2 * (utf8.len(var_582_3) / 4)

				if (4 <= 0 and var_582_2 or var_582_2 * (utf8.len(var_582_3) / 4)) > 0 and var_582_2 < var_582_5 then
					arg_579_1.talkMaxDuration = var_582_5

					if var_582_5 + var_582_1 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_5 + var_582_1
					end
				end

				arg_579_1.text_.text = var_582_3
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)
				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_6 = math.max(var_582_2, arg_579_1.talkMaxDuration)

			if var_582_1 <= arg_579_1.time_ and arg_579_1.time_ < var_582_1 + var_582_6 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - var_582_1) / var_582_6

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= var_582_1 + var_582_6 and arg_579_1.time_ < var_582_1 + var_582_6 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	Play1109702142 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 1109702142
		arg_583_1.duration_ = 3.4

		local var_583_0 = {
			zh = 2.833,
			ja = 3.4
		}
		local var_583_1 = manager.audio:GetLocalizationFlag()

		if var_583_0[var_583_1] ~= nil then
			arg_583_1.duration_ = var_583_0[var_583_1]
		end

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play1109702143(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 and not isNil(arg_583_1.actors_["1197ui_story"]) and arg_583_1.var_.characterEffect1197ui_story == nil then
				arg_583_1.var_.characterEffect1197ui_story = arg_583_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_586_0 = 0.200000002980232

			if 0 <= arg_583_1.time_ and arg_583_1.time_ < 0 + var_586_0 and not isNil(arg_583_1.actors_["1197ui_story"]) then
				if arg_583_1.var_.characterEffect1197ui_story and not isNil(arg_583_1.actors_["1197ui_story"]) then
					arg_583_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_583_1.time_ >= 0 + var_586_0 and arg_583_1.time_ < 0 + var_586_0 + arg_586_0 and not isNil(arg_583_1.actors_["1197ui_story"]) and arg_583_1.var_.characterEffect1197ui_story then
				arg_583_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 then
				arg_583_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action3_1")
			end

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 then
				arg_583_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_586_2 = 0
			local var_586_3 = 0.35

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= var_586_2 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, true)

				arg_583_1.leftNameTxt_.text = arg_583_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_583_1.leftNameTxt_.transform)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1.leftNameTxt_.text)
				SetActive(arg_583_1.iconTrs_.gameObject, false)
				arg_583_1.callingController_:SetSelectedState("normal")

				local var_586_4 = arg_583_1:GetWordFromCfg(1109702142)
				local var_586_5 = arg_583_1:FormatText(var_586_4.content)

				arg_583_1.text_.text = var_586_5

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_7 = 14 <= 0 and var_586_3 or var_586_3 * (utf8.len(var_586_5) / 14)

				if (14 <= 0 and var_586_3 or var_586_3 * (utf8.len(var_586_5) / 14)) > 0 and var_586_3 < var_586_7 then
					arg_583_1.talkMaxDuration = var_586_7

					if var_586_7 + var_586_2 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_7 + var_586_2
					end
				end

				arg_583_1.text_.text = var_586_5
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702142", "story_v_side_new_1109702.awb") ~= 0 then
					local var_586_8 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702142", "story_v_side_new_1109702.awb") / 1000

					if var_586_8 + var_586_2 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_8 + var_586_2
					end

					if var_586_4.prefab_name ~= "" and arg_583_1.actors_[var_586_4.prefab_name] ~= nil then
						local var_586_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_583_1.actors_[var_586_4.prefab_name].transform, "story_v_side_new_1109702", "1109702142", "story_v_side_new_1109702.awb")

						arg_583_1:RecordAudio("1109702142", var_586_9)
						arg_583_1:RecordAudio("1109702142", var_586_9)
					else
						arg_583_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702142", "story_v_side_new_1109702.awb")
					end

					arg_583_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702142", "story_v_side_new_1109702.awb")
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
	Play1109702143 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 1109702143
		arg_587_1.duration_ = 5

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play1109702144(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			if 0 < arg_587_1.time_ and arg_587_1.time_ <= 0 + arg_590_0 and not isNil(arg_587_1.actors_["1197ui_story"]) and arg_587_1.var_.characterEffect1197ui_story == nil then
				arg_587_1.var_.characterEffect1197ui_story = arg_587_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_590_0 = 0.200000002980232

			if 0 <= arg_587_1.time_ and arg_587_1.time_ < 0 + var_590_0 and not isNil(arg_587_1.actors_["1197ui_story"]) then
				if arg_587_1.var_.characterEffect1197ui_story and not isNil(arg_587_1.actors_["1197ui_story"]) then
					arg_587_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_587_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_587_1.time_ - 0) / var_590_0)
				end
			end

			if arg_587_1.time_ >= 0 + var_590_0 and arg_587_1.time_ < 0 + var_590_0 + arg_590_0 and not isNil(arg_587_1.actors_["1197ui_story"]) and arg_587_1.var_.characterEffect1197ui_story then
				arg_587_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_587_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_590_1 = 0
			local var_590_2 = 0.875

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

				local var_590_3 = arg_587_1:FormatText(arg_587_1:GetWordFromCfg(1109702143).content)

				arg_587_1.text_.text = var_590_3

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_5 = 35 <= 0 and var_590_2 or var_590_2 * (utf8.len(var_590_3) / 35)

				if (35 <= 0 and var_590_2 or var_590_2 * (utf8.len(var_590_3) / 35)) > 0 and var_590_2 < var_590_5 then
					arg_587_1.talkMaxDuration = var_590_5

					if var_590_5 + var_590_1 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_5 + var_590_1
					end
				end

				arg_587_1.text_.text = var_590_3
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)
				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_6 = math.max(var_590_2, arg_587_1.talkMaxDuration)

			if var_590_1 <= arg_587_1.time_ and arg_587_1.time_ < var_590_1 + var_590_6 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - var_590_1) / var_590_6

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= var_590_1 + var_590_6 and arg_587_1.time_ < var_590_1 + var_590_6 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {}

		arg_587_1:InitPlayNodeList()
	end,
	Play1109702144 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 1109702144
		arg_591_1.duration_ = 2

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
		end

		function arg_591_1.playNext_(arg_593_0)
			if arg_593_0 == 1 then
				arg_591_0:Play1109702145(arg_591_1)
			end
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			if 0 < arg_591_1.time_ and arg_591_1.time_ <= 0 + arg_594_0 then
				arg_591_1.var_.moveOldPos1197ui_story = arg_591_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_594_0 = 0.001

			if 0 <= arg_591_1.time_ and arg_591_1.time_ < 0 + var_594_0 then
				arg_591_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_591_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_591_1.time_ - 0) / var_594_0)
				arg_591_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_591_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_591_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_591_1.actors_["1197ui_story"].transform.position).z)
				arg_591_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_591_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_591_1.actors_["1197ui_story"].transform.localEulerAngles = arg_591_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_591_1.time_ >= 0 + var_594_0 and arg_591_1.time_ < 0 + var_594_0 + arg_594_0 then
				arg_591_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, -0.545, -6.3)
				arg_591_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_591_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_591_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_591_1.actors_["1197ui_story"].transform.position).z)
				arg_591_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_591_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_591_1.actors_["1197ui_story"].transform.localEulerAngles = arg_591_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_594_1 = arg_591_1.actors_["1197ui_story"]

			if 0 < arg_591_1.time_ and arg_591_1.time_ <= 0 + arg_594_0 and not isNil(var_594_1) and arg_591_1.var_.characterEffect1197ui_story == nil then
				arg_591_1.var_.characterEffect1197ui_story = var_594_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_594_2 = 0.200000002980232

			if 0 <= arg_591_1.time_ and arg_591_1.time_ < 0 + var_594_2 and not isNil(var_594_1) then
				if arg_591_1.var_.characterEffect1197ui_story and not isNil(var_594_1) then
					arg_591_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_591_1.time_ >= 0 + var_594_2 and arg_591_1.time_ < 0 + var_594_2 + arg_594_0 and not isNil(var_594_1) and arg_591_1.var_.characterEffect1197ui_story then
				arg_591_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_591_1.time_ and arg_591_1.time_ <= 0 + arg_594_0 then
				arg_591_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action3_2")
			end

			if 0 < arg_591_1.time_ and arg_591_1.time_ <= 0 + arg_594_0 then
				arg_591_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_594_4 = 0
			local var_594_5 = 0.075

			if 0 < arg_591_1.time_ and arg_591_1.time_ <= var_594_4 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0
				arg_591_1.dialogCg_.alpha = 1

				arg_591_1.dialog_:SetActive(true)
				SetActive(arg_591_1.leftNameGo_, true)

				arg_591_1.leftNameTxt_.text = arg_591_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_591_1.leftNameTxt_.transform)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1.leftNameTxt_.text)
				SetActive(arg_591_1.iconTrs_.gameObject, false)
				arg_591_1.callingController_:SetSelectedState("normal")

				local var_594_6 = arg_591_1:GetWordFromCfg(1109702144)
				local var_594_7 = arg_591_1:FormatText(var_594_6.content)

				arg_591_1.text_.text = var_594_7

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_9 = 3 <= 0 and var_594_5 or var_594_5 * (utf8.len(var_594_7) / 3)

				if (3 <= 0 and var_594_5 or var_594_5 * (utf8.len(var_594_7) / 3)) > 0 and var_594_5 < var_594_9 then
					arg_591_1.talkMaxDuration = var_594_9

					if var_594_9 + var_594_4 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_9 + var_594_4
					end
				end

				arg_591_1.text_.text = var_594_7
				arg_591_1.typewritter.percent = 0

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702144", "story_v_side_new_1109702.awb") ~= 0 then
					local var_594_10 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702144", "story_v_side_new_1109702.awb") / 1000

					if var_594_10 + var_594_4 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_10 + var_594_4
					end

					if var_594_6.prefab_name ~= "" and arg_591_1.actors_[var_594_6.prefab_name] ~= nil then
						local var_594_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_591_1.actors_[var_594_6.prefab_name].transform, "story_v_side_new_1109702", "1109702144", "story_v_side_new_1109702.awb")

						arg_591_1:RecordAudio("1109702144", var_594_11)
						arg_591_1:RecordAudio("1109702144", var_594_11)
					else
						arg_591_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702144", "story_v_side_new_1109702.awb")
					end

					arg_591_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702144", "story_v_side_new_1109702.awb")
				end

				arg_591_1:RecordContent(arg_591_1.text_.text)
			end

			local var_594_12 = math.max(var_594_5, arg_591_1.talkMaxDuration)

			if var_594_4 <= arg_591_1.time_ and arg_591_1.time_ < var_594_4 + var_594_12 then
				arg_591_1.typewritter.percent = (arg_591_1.time_ - var_594_4) / var_594_12

				arg_591_1.typewritter:SetDirty()
			end

			if arg_591_1.time_ >= var_594_4 + var_594_12 and arg_591_1.time_ < var_594_4 + var_594_12 + arg_594_0 then
				arg_591_1.typewritter.percent = 1

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(true)
			end
		end

		arg_591_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_591_1:InitPlayNodeList()
	end,
	Play1109702145 = function(arg_595_0, arg_595_1)
		arg_595_1.time_ = 0
		arg_595_1.frameCnt_ = 0
		arg_595_1.state_ = "playing"
		arg_595_1.curTalkId_ = 1109702145
		arg_595_1.duration_ = 5

		SetActive(arg_595_1.tipsGo_, false)

		function arg_595_1.onSingleLineFinish_()
			arg_595_1.onSingleLineUpdate_ = nil
			arg_595_1.onSingleLineFinish_ = nil
			arg_595_1.state_ = "waiting"
		end

		function arg_595_1.playNext_(arg_597_0)
			if arg_597_0 == 1 then
				arg_595_0:Play1109702146(arg_595_1)
			end
		end

		function arg_595_1.onSingleLineUpdate_(arg_598_0)
			if 0 < arg_595_1.time_ and arg_595_1.time_ <= 0 + arg_598_0 and not isNil(arg_595_1.actors_["1197ui_story"]) and arg_595_1.var_.characterEffect1197ui_story == nil then
				arg_595_1.var_.characterEffect1197ui_story = arg_595_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_598_0 = 0.200000002980232

			if 0 <= arg_595_1.time_ and arg_595_1.time_ < 0 + var_598_0 and not isNil(arg_595_1.actors_["1197ui_story"]) then
				if arg_595_1.var_.characterEffect1197ui_story and not isNil(arg_595_1.actors_["1197ui_story"]) then
					arg_595_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_595_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_595_1.time_ - 0) / var_598_0)
				end
			end

			if arg_595_1.time_ >= 0 + var_598_0 and arg_595_1.time_ < 0 + var_598_0 + arg_598_0 and not isNil(arg_595_1.actors_["1197ui_story"]) and arg_595_1.var_.characterEffect1197ui_story then
				arg_595_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_595_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_598_1 = 0
			local var_598_2 = 0.575

			if 0 < arg_595_1.time_ and arg_595_1.time_ <= var_598_1 + arg_598_0 then
				arg_595_1.talkMaxDuration = 0
				arg_595_1.dialogCg_.alpha = 1

				arg_595_1.dialog_:SetActive(true)
				SetActive(arg_595_1.leftNameGo_, true)

				arg_595_1.leftNameTxt_.text = arg_595_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_595_1.leftNameTxt_.transform)

				arg_595_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_595_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_595_1:RecordName(arg_595_1.leftNameTxt_.text)
				SetActive(arg_595_1.iconTrs_.gameObject, true)
				arg_595_1.iconController_:SetSelectedState("hero")

				arg_595_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_595_1.callingController_:SetSelectedState("normal")

				arg_595_1.keyicon_.color = Color.New(1, 1, 1)
				arg_595_1.icon_.color = Color.New(1, 1, 1)

				local var_598_3 = arg_595_1:FormatText(arg_595_1:GetWordFromCfg(1109702145).content)

				arg_595_1.text_.text = var_598_3

				LuaForUtil.ClearLinePrefixSymbol(arg_595_1.text_)

				local var_598_5 = 23 <= 0 and var_598_2 or var_598_2 * (utf8.len(var_598_3) / 23)

				if (23 <= 0 and var_598_2 or var_598_2 * (utf8.len(var_598_3) / 23)) > 0 and var_598_2 < var_598_5 then
					arg_595_1.talkMaxDuration = var_598_5

					if var_598_5 + var_598_1 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_5 + var_598_1
					end
				end

				arg_595_1.text_.text = var_598_3
				arg_595_1.typewritter.percent = 0

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(false)
				arg_595_1:RecordContent(arg_595_1.text_.text)
			end

			local var_598_6 = math.max(var_598_2, arg_595_1.talkMaxDuration)

			if var_598_1 <= arg_595_1.time_ and arg_595_1.time_ < var_598_1 + var_598_6 then
				arg_595_1.typewritter.percent = (arg_595_1.time_ - var_598_1) / var_598_6

				arg_595_1.typewritter:SetDirty()
			end

			if arg_595_1.time_ >= var_598_1 + var_598_6 and arg_595_1.time_ < var_598_1 + var_598_6 + arg_598_0 then
				arg_595_1.typewritter.percent = 1

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(true)
			end
		end

		arg_595_1.nodeConfigList_ = {}

		arg_595_1:InitPlayNodeList()
	end,
	Play1109702146 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 1109702146
		arg_599_1.duration_ = 5

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play1109702147(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			local var_602_0 = 0.625

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= 0 + arg_602_0 then
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

				local var_602_1 = arg_599_1:FormatText(arg_599_1:GetWordFromCfg(1109702146).content)

				arg_599_1.text_.text = var_602_1

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_3 = 25 <= 0 and var_602_0 or var_602_0 * (utf8.len(var_602_1) / 25)

				if (25 <= 0 and var_602_0 or var_602_0 * (utf8.len(var_602_1) / 25)) > 0 and var_602_0 < var_602_3 then
					arg_599_1.talkMaxDuration = var_602_3

					if var_602_3 + 0 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_3 + 0
					end
				end

				arg_599_1.text_.text = var_602_1
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)
				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_4 = math.max(var_602_0, arg_599_1.talkMaxDuration)

			if 0 <= arg_599_1.time_ and arg_599_1.time_ < 0 + var_602_4 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - 0) / var_602_4

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= 0 + var_602_4 and arg_599_1.time_ < 0 + var_602_4 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {}

		arg_599_1:InitPlayNodeList()
	end,
	Play1109702147 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 1109702147
		arg_603_1.duration_ = 5

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play1109702148(arg_603_1)
			end
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			if 0 < arg_603_1.time_ and arg_603_1.time_ <= 0 + arg_606_0 then
				arg_603_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_606_0 = arg_603_1.actors_["1197ui_story"].transform

			if 0 < arg_603_1.time_ and arg_603_1.time_ <= 0 + arg_606_0 then
				arg_603_1.var_.moveOldPos1197ui_story = var_606_0.localPosition
			end

			local var_606_1 = 0.001

			if 0 <= arg_603_1.time_ and arg_603_1.time_ < 0 + var_606_1 then
				var_606_0.localPosition = Vector3.Lerp(arg_603_1.var_.moveOldPos1197ui_story, Vector3.New(0, 100, 0), (arg_603_1.time_ - 0) / var_606_1)
				var_606_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_606_0.position).x, (manager.ui.mainCamera.transform.position - var_606_0.position).y, (manager.ui.mainCamera.transform.position - var_606_0.position).z)
				var_606_0.localEulerAngles.z = 0
				var_606_0.localEulerAngles.x = 0
				var_606_0.localEulerAngles = var_606_0.localEulerAngles
			end

			if arg_603_1.time_ >= 0 + var_606_1 and arg_603_1.time_ < 0 + var_606_1 + arg_606_0 then
				var_606_0.localPosition = Vector3.New(0, 100, 0)
				var_606_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_606_0.position).x, (manager.ui.mainCamera.transform.position - var_606_0.position).y, (manager.ui.mainCamera.transform.position - var_606_0.position).z)
				var_606_0.localEulerAngles.z = 0
				var_606_0.localEulerAngles.x = 0
				var_606_0.localEulerAngles = var_606_0.localEulerAngles
			end

			local var_606_2 = 0
			local var_606_3 = 0.95

			if 0 < arg_603_1.time_ and arg_603_1.time_ <= var_606_2 + arg_606_0 then
				arg_603_1.talkMaxDuration = 0
				arg_603_1.dialogCg_.alpha = 1

				arg_603_1.dialog_:SetActive(true)
				SetActive(arg_603_1.leftNameGo_, false)

				arg_603_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_603_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_603_1:RecordName(arg_603_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_603_1.iconTrs_.gameObject, false)
				arg_603_1.callingController_:SetSelectedState("normal")

				local var_606_4 = arg_603_1:FormatText(arg_603_1:GetWordFromCfg(1109702147).content)

				arg_603_1.text_.text = var_606_4

				LuaForUtil.ClearLinePrefixSymbol(arg_603_1.text_)

				local var_606_6 = 38 <= 0 and var_606_3 or var_606_3 * (utf8.len(var_606_4) / 38)

				if (38 <= 0 and var_606_3 or var_606_3 * (utf8.len(var_606_4) / 38)) > 0 and var_606_3 < var_606_6 then
					arg_603_1.talkMaxDuration = var_606_6

					if var_606_6 + var_606_2 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_6 + var_606_2
					end
				end

				arg_603_1.text_.text = var_606_4
				arg_603_1.typewritter.percent = 0

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(false)
				arg_603_1:RecordContent(arg_603_1.text_.text)
			end

			local var_606_7 = math.max(var_606_3, arg_603_1.talkMaxDuration)

			if var_606_2 <= arg_603_1.time_ and arg_603_1.time_ < var_606_2 + var_606_7 then
				arg_603_1.typewritter.percent = (arg_603_1.time_ - var_606_2) / var_606_7

				arg_603_1.typewritter:SetDirty()
			end

			if arg_603_1.time_ >= var_606_2 + var_606_7 and arg_603_1.time_ < var_606_2 + var_606_7 + arg_606_0 then
				arg_603_1.typewritter.percent = 1

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(true)
			end
		end

		arg_603_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_603_1:InitPlayNodeList()
	end,
	Play1109702148 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 1109702148
		arg_607_1.duration_ = 14.87

		local var_607_0 = {
			zh = 5.166,
			ja = 14.866
		}
		local var_607_1 = manager.audio:GetLocalizationFlag()

		if var_607_0[var_607_1] ~= nil then
			arg_607_1.duration_ = var_607_0[var_607_1]
		end

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
		end

		function arg_607_1.playNext_(arg_609_0)
			if arg_609_0 == 1 then
				arg_607_0:Play1109702149(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			local var_610_0 = 0.625

			if 0 < arg_607_1.time_ and arg_607_1.time_ <= 0 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, true)

				arg_607_1.leftNameTxt_.text = arg_607_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_607_1.leftNameTxt_.transform)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1.leftNameTxt_.text)
				SetActive(arg_607_1.iconTrs_.gameObject, true)
				arg_607_1.iconController_:SetSelectedState("hero")

				arg_607_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1197")

				arg_607_1.callingController_:SetSelectedState("normal")

				arg_607_1.keyicon_.color = Color.New(1, 1, 1)
				arg_607_1.icon_.color = Color.New(1, 1, 1)

				local var_610_1 = arg_607_1:GetWordFromCfg(1109702148)
				local var_610_2 = arg_607_1:FormatText(var_610_1.content)

				arg_607_1.text_.text = var_610_2

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_4 = 25 <= 0 and var_610_0 or var_610_0 * (utf8.len(var_610_2) / 25)

				if (25 <= 0 and var_610_0 or var_610_0 * (utf8.len(var_610_2) / 25)) > 0 and var_610_0 < var_610_4 then
					arg_607_1.talkMaxDuration = var_610_4

					if var_610_4 + 0 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_4 + 0
					end
				end

				arg_607_1.text_.text = var_610_2
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702148", "story_v_side_new_1109702.awb") ~= 0 then
					local var_610_5 = manager.audio:GetVoiceLength("story_v_side_new_1109702", "1109702148", "story_v_side_new_1109702.awb") / 1000

					if var_610_5 + 0 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_5 + 0
					end

					if var_610_1.prefab_name ~= "" and arg_607_1.actors_[var_610_1.prefab_name] ~= nil then
						local var_610_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_607_1.actors_[var_610_1.prefab_name].transform, "story_v_side_new_1109702", "1109702148", "story_v_side_new_1109702.awb")

						arg_607_1:RecordAudio("1109702148", var_610_6)
						arg_607_1:RecordAudio("1109702148", var_610_6)
					else
						arg_607_1:AudioAction("play", "voice", "story_v_side_new_1109702", "1109702148", "story_v_side_new_1109702.awb")
					end

					arg_607_1:RecordHistoryTalkVoice("story_v_side_new_1109702", "1109702148", "story_v_side_new_1109702.awb")
				end

				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_7 = math.max(var_610_0, arg_607_1.talkMaxDuration)

			if 0 <= arg_607_1.time_ and arg_607_1.time_ < 0 + var_610_7 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - 0) / var_610_7

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= 0 + var_610_7 and arg_607_1.time_ < 0 + var_610_7 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {}

		arg_607_1:InitPlayNodeList()
	end,
	Play1109702149 = function(arg_611_0, arg_611_1)
		arg_611_1.time_ = 0
		arg_611_1.frameCnt_ = 0
		arg_611_1.state_ = "playing"
		arg_611_1.curTalkId_ = 1109702149
		arg_611_1.duration_ = 5

		SetActive(arg_611_1.tipsGo_, false)

		function arg_611_1.onSingleLineFinish_()
			arg_611_1.onSingleLineUpdate_ = nil
			arg_611_1.onSingleLineFinish_ = nil
			arg_611_1.state_ = "waiting"
			arg_611_1.auto_ = false
		end

		function arg_611_1.playNext_(arg_613_0)
			arg_611_1.onStoryFinished_()
		end

		function arg_611_1.onSingleLineUpdate_(arg_614_0)
			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 and not isNil(arg_611_1.actors_["1197ui_story"]) and arg_611_1.var_.characterEffect1197ui_story == nil then
				arg_611_1.var_.characterEffect1197ui_story = arg_611_1.actors_["1197ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_614_0 = 0.200000002980232

			if 0 <= arg_611_1.time_ and arg_611_1.time_ < 0 + var_614_0 and not isNil(arg_611_1.actors_["1197ui_story"]) then
				if arg_611_1.var_.characterEffect1197ui_story and not isNil(arg_611_1.actors_["1197ui_story"]) then
					arg_611_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_611_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_611_1.time_ - 0) / var_614_0)
				end
			end

			if arg_611_1.time_ >= 0 + var_614_0 and arg_611_1.time_ < 0 + var_614_0 + arg_614_0 and not isNil(arg_611_1.actors_["1197ui_story"]) and arg_611_1.var_.characterEffect1197ui_story then
				arg_611_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_611_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_614_1 = 0
			local var_614_2 = 0.825

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= var_614_1 + arg_614_0 then
				arg_611_1.talkMaxDuration = 0
				arg_611_1.dialogCg_.alpha = 1

				arg_611_1.dialog_:SetActive(true)
				SetActive(arg_611_1.leftNameGo_, false)

				arg_611_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_611_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_611_1:RecordName(arg_611_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_611_1.iconTrs_.gameObject, false)
				arg_611_1.callingController_:SetSelectedState("normal")

				local var_614_3 = arg_611_1:FormatText(arg_611_1:GetWordFromCfg(1109702149).content)

				arg_611_1.text_.text = var_614_3

				LuaForUtil.ClearLinePrefixSymbol(arg_611_1.text_)

				local var_614_5 = 33 <= 0 and var_614_2 or var_614_2 * (utf8.len(var_614_3) / 33)

				if (33 <= 0 and var_614_2 or var_614_2 * (utf8.len(var_614_3) / 33)) > 0 and var_614_2 < var_614_5 then
					arg_611_1.talkMaxDuration = var_614_5

					if var_614_5 + var_614_1 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_5 + var_614_1
					end
				end

				arg_611_1.text_.text = var_614_3
				arg_611_1.typewritter.percent = 0

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(false)
				arg_611_1:RecordContent(arg_611_1.text_.text)
			end

			local var_614_6 = math.max(var_614_2, arg_611_1.talkMaxDuration)

			if var_614_1 <= arg_611_1.time_ and arg_611_1.time_ < var_614_1 + var_614_6 then
				arg_611_1.typewritter.percent = (arg_611_1.time_ - var_614_1) / var_614_6

				arg_611_1.typewritter:SetDirty()
			end

			if arg_611_1.time_ >= var_614_1 + var_614_6 and arg_611_1.time_ < var_614_1 + var_614_6 + arg_614_0 then
				arg_611_1.typewritter.percent = 1

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(true)
			end
		end

		arg_611_1.nodeConfigList_ = {}

		arg_611_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I09",
		"TextureConfig/Background/I06b",
		"TextureConfig/Background/I09a"
	},
	voices = {
		"story_v_side_new_1109702.awb"
	}
}
