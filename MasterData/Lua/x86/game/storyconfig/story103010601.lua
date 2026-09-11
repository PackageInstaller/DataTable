return {
	Play301061001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 301061001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play301061002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.B01c == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B01c")
				var_4_0.name = "B01c"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.B01c = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.B01c

				arg_1_1.bgs_.B01c.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B01c" then
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
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if 1.16666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.16666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous.awb")

				local var_4_12 = manager.audio:GetAudioName("bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_12 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_12

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_12
						arg_1_1.bgmTxt2_.text = var_4_12
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_room", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_14 = 2
			local var_4_15 = 1.825

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(301061001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 73 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 73)

				if (73 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 73)) > 0 and var_4_15 < var_4_19 then
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
	Play301061002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 301061002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play301061003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 1.35

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

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(301061002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 54 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 54)

				if (54 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 54)) > 0 and var_11_0 < var_11_3 then
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
	Play301061003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 301061003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play301061004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.475

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(301061003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 19 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 19)

				if (19 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 19)) > 0 and var_15_0 < var_15_3 then
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
	Play301061004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 301061004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play301061005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.4

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

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_1 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(301061004).content)

				arg_16_1.text_.text = var_19_1

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_3 = 16 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 16)

				if (16 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 16)) > 0 and var_19_0 < var_19_3 then
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
	Play301061005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 301061005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play301061006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:AudioAction("play", "effect", "se_story_side_1093", "se_story_1093_message_calling", "")
			end

			local var_23_1 = 0
			local var_23_2 = 1.025

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_3 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(301061005).content)

				arg_20_1.text_.text = var_23_3

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 41 <= 0 and var_23_2 or var_23_2 * (utf8.len(var_23_3) / 41)

				if (41 <= 0 and var_23_2 or var_23_2 * (utf8.len(var_23_3) / 41)) > 0 and var_23_2 < var_23_5 then
					arg_20_1.talkMaxDuration = var_23_5

					if var_23_5 + var_23_1 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + var_23_1
					end
				end

				arg_20_1.text_.text = var_23_3
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_6 = math.max(var_23_2, arg_20_1.talkMaxDuration)

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_6 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_1) / var_23_6

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_1 + var_23_6 and arg_20_1.time_ < var_23_1 + var_23_6 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play301061006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 301061006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play301061007(arg_24_1)
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

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_1 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(301061006).content)

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
	Play301061007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 301061007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play301061008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 1.775

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_1 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(301061007).content)

				arg_28_1.text_.text = var_31_1

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_3 = 63 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 63)

				if (63 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 63)) > 0 and var_31_0 < var_31_3 then
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
	Play301061008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 301061008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play301061009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0.1

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_1 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(301061008).content)

				arg_32_1.text_.text = var_35_1

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_3 = 4 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_1) / 4)

				if (4 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_1) / 4)) > 0 and var_35_0 < var_35_3 then
					arg_32_1.talkMaxDuration = var_35_3

					if var_35_3 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_3 + 0
					end
				end

				arg_32_1.text_.text = var_35_1
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_4 = math.max(var_35_0, arg_32_1.talkMaxDuration)

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_4 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - 0) / var_35_4

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= 0 + var_35_4 and arg_32_1.time_ < 0 + var_35_4 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play301061009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 301061009
		arg_36_1.duration_ = 2.63

		local var_36_0 = {
			zh = 1.566,
			ja = 2.633
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play301061010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0.05

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[100].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedb")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_1 = arg_36_1:GetWordFromCfg(301061009)
				local var_39_2 = arg_36_1:FormatText(var_39_1.content)

				arg_36_1.text_.text = var_39_2

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_4 = 2 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 2)

				if (2 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 2)) > 0 and var_39_0 < var_39_4 then
					arg_36_1.talkMaxDuration = var_39_4

					if var_39_4 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_4 + 0
					end
				end

				arg_36_1.text_.text = var_39_2
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301061", "301061009", "story_v_out_301061.awb") ~= 0 then
					local var_39_5 = manager.audio:GetVoiceLength("story_v_out_301061", "301061009", "story_v_out_301061.awb") / 1000

					if var_39_5 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_5 + 0
					end

					if var_39_1.prefab_name ~= "" and arg_36_1.actors_[var_39_1.prefab_name] ~= nil then
						local var_39_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_1.prefab_name].transform, "story_v_out_301061", "301061009", "story_v_out_301061.awb")

						arg_36_1:RecordAudio("301061009", var_39_6)
						arg_36_1:RecordAudio("301061009", var_39_6)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_301061", "301061009", "story_v_out_301061.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_301061", "301061009", "story_v_out_301061.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_7 = math.max(var_39_0, arg_36_1.talkMaxDuration)

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_7 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - 0) / var_39_7

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= 0 + var_39_7 and arg_36_1.time_ < 0 + var_39_7 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play301061010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 301061010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play301061011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0.5

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_1 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(301061010).content)

				arg_40_1.text_.text = var_43_1

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_3 = 20 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_1) / 20)

				if (20 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_1) / 20)) > 0 and var_43_0 < var_43_3 then
					arg_40_1.talkMaxDuration = var_43_3

					if var_43_3 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_3 + 0
					end
				end

				arg_40_1.text_.text = var_43_1
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_4 = math.max(var_43_0, arg_40_1.talkMaxDuration)

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_4 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - 0) / var_43_4

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= 0 + var_43_4 and arg_40_1.time_ < 0 + var_43_4 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play301061011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 301061011
		arg_44_1.duration_ = 6.43

		local var_44_0 = {
			zh = 4.4,
			ja = 6.433
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play301061012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0.15

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[100].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedb")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_1 = arg_44_1:GetWordFromCfg(301061011)
				local var_47_2 = arg_44_1:FormatText(var_47_1.content)

				arg_44_1.text_.text = var_47_2

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_4 = 6 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 6)

				if (6 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 6)) > 0 and var_47_0 < var_47_4 then
					arg_44_1.talkMaxDuration = var_47_4

					if var_47_4 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_4 + 0
					end
				end

				arg_44_1.text_.text = var_47_2
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301061", "301061011", "story_v_out_301061.awb") ~= 0 then
					local var_47_5 = manager.audio:GetVoiceLength("story_v_out_301061", "301061011", "story_v_out_301061.awb") / 1000

					if var_47_5 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_5 + 0
					end

					if var_47_1.prefab_name ~= "" and arg_44_1.actors_[var_47_1.prefab_name] ~= nil then
						local var_47_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_1.prefab_name].transform, "story_v_out_301061", "301061011", "story_v_out_301061.awb")

						arg_44_1:RecordAudio("301061011", var_47_6)
						arg_44_1:RecordAudio("301061011", var_47_6)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_301061", "301061011", "story_v_out_301061.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_301061", "301061011", "story_v_out_301061.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_7 = math.max(var_47_0, arg_44_1.talkMaxDuration)

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_7 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - 0) / var_47_7

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= 0 + var_47_7 and arg_44_1.time_ < 0 + var_47_7 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play301061012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 301061012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play301061013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0.625

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_1 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(301061012).content)

				arg_48_1.text_.text = var_51_1

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_3 = 25 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 25)

				if (25 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 25)) > 0 and var_51_0 < var_51_3 then
					arg_48_1.talkMaxDuration = var_51_3

					if var_51_3 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_3 + 0
					end
				end

				arg_48_1.text_.text = var_51_1
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_4 = math.max(var_51_0, arg_48_1.talkMaxDuration)

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_4 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - 0) / var_51_4

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= 0 + var_51_4 and arg_48_1.time_ < 0 + var_51_4 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play301061013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 301061013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play301061014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0.45

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_1 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(301061013).content)

				arg_52_1.text_.text = var_55_1

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_3 = 18 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_1) / 18)

				if (18 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_1) / 18)) > 0 and var_55_0 < var_55_3 then
					arg_52_1.talkMaxDuration = var_55_3

					if var_55_3 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_3 + 0
					end
				end

				arg_52_1.text_.text = var_55_1
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_4 = math.max(var_55_0, arg_52_1.talkMaxDuration)

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_4 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - 0) / var_55_4

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= 0 + var_55_4 and arg_52_1.time_ < 0 + var_55_4 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play301061014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 301061014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play301061015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 1.65

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

				local var_59_1 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(301061014).content)

				arg_56_1.text_.text = var_59_1

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_3 = 66 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_1) / 66)

				if (66 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_1) / 66)) > 0 and var_59_0 < var_59_3 then
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
	Play301061015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 301061015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play301061016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 1.375

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_1 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(301061015).content)

				arg_60_1.text_.text = var_63_1

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_3 = 55 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_1) / 55)

				if (55 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_1) / 55)) > 0 and var_63_0 < var_63_3 then
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
	Play301061016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 301061016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play301061017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_67_0 = 0.6

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 then
				local var_67_1, var_67_2 = math.modf((arg_64_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_67_2 * 0.13, var_67_2 * 0.13, var_67_2 * 0.13) + arg_64_1.var_.shakeOldPos
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 then
				manager.ui.mainCamera.transform.localPosition = arg_64_1.var_.shakeOldPos
			end

			local var_67_3 = 0

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_3 + arg_67_0 then
				arg_64_1.allBtn_.enabled = false
			end

			if arg_64_1.time_ >= var_67_3 + 0.6 and arg_64_1.time_ < var_67_3 + 0.6 + arg_67_0 then
				arg_64_1.allBtn_.enabled = true
			end

			local var_67_4 = 0
			local var_67_5 = 0.225

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_4 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_6 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(301061016).content)

				arg_64_1.text_.text = var_67_6

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_8 = 9 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_6) / 9)

				if (9 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_6) / 9)) > 0 and var_67_5 < var_67_8 then
					arg_64_1.talkMaxDuration = var_67_8

					if var_67_8 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_8 + var_67_4
					end
				end

				arg_64_1.text_.text = var_67_6
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_9 = math.max(var_67_5, arg_64_1.talkMaxDuration)

			if var_67_4 <= arg_64_1.time_ and arg_64_1.time_ < var_67_4 + var_67_9 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_4) / var_67_9

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_4 + var_67_9 and arg_64_1.time_ < var_67_4 + var_67_9 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play301061017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 301061017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play301061018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:AudioAction("play", "effect", "se_story_152", "se_story_152_trash_can", "")
			end

			local var_71_1 = 0
			local var_71_2 = 1.125

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_3 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(301061017).content)

				arg_68_1.text_.text = var_71_3

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_5 = 45 <= 0 and var_71_2 or var_71_2 * (utf8.len(var_71_3) / 45)

				if (45 <= 0 and var_71_2 or var_71_2 * (utf8.len(var_71_3) / 45)) > 0 and var_71_2 < var_71_5 then
					arg_68_1.talkMaxDuration = var_71_5

					if var_71_5 + var_71_1 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_5 + var_71_1
					end
				end

				arg_68_1.text_.text = var_71_3
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_6 = math.max(var_71_2, arg_68_1.talkMaxDuration)

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_6 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_1) / var_71_6

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_1 + var_71_6 and arg_68_1.time_ < var_71_1 + var_71_6 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play301061018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 301061018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play301061019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0.95

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

				local var_75_1 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(301061018).content)

				arg_72_1.text_.text = var_75_1

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_3 = 38 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_1) / 38)

				if (38 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_1) / 38)) > 0 and var_75_0 < var_75_3 then
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
	Play301061019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 301061019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play301061020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 2.1

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_1 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(301061019).content)

				arg_76_1.text_.text = var_79_1

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_3 = 84 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_1) / 84)

				if (84 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_1) / 84)) > 0 and var_79_0 < var_79_3 then
					arg_76_1.talkMaxDuration = var_79_3

					if var_79_3 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_3 + 0
					end
				end

				arg_76_1.text_.text = var_79_1
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_4 = math.max(var_79_0, arg_76_1.talkMaxDuration)

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_4 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - 0) / var_79_4

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= 0 + var_79_4 and arg_76_1.time_ < 0 + var_79_4 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play301061020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 301061020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play301061021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 1.55

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_1 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(301061020).content)

				arg_80_1.text_.text = var_83_1

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_3 = 62 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_1) / 62)

				if (62 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_1) / 62)) > 0 and var_83_0 < var_83_3 then
					arg_80_1.talkMaxDuration = var_83_3

					if var_83_3 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_3 + 0
					end
				end

				arg_80_1.text_.text = var_83_1
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_4 = math.max(var_83_0, arg_80_1.talkMaxDuration)

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_4 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - 0) / var_83_4

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= 0 + var_83_4 and arg_80_1.time_ < 0 + var_83_4 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play301061021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 301061021
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play301061022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0.3

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

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_1 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(301061021).content)

				arg_84_1.text_.text = var_87_1

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_3 = 12 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_1) / 12)

				if (12 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_1) / 12)) > 0 and var_87_0 < var_87_3 then
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
	Play301061022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 301061022
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play301061023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_9001
			local var_91_9000

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				local var_91_0 = arg_88_1.var_.effectzaguoqu1

				if not arg_88_1.var_.effectzaguoqu1 then
					var_91_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_91_0.name = "zaguoqu1"
					arg_88_1.var_.effectzaguoqu1 = var_91_0
				else
					var_91_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_91_0.transform.localPosition = Vector3.New(0, 0, 8.88)
				var_91_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.2 < arg_88_1.time_ and arg_88_1.time_ <= 0.2 + arg_91_0 then
				local var_91_2 = arg_88_1.var_.effectzaguoqu2

				if not arg_88_1.var_.effectzaguoqu2 then
					var_91_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_91_2.name = "zaguoqu2"
					arg_88_1.var_.effectzaguoqu2 = var_91_2
				else
					var_91_2.transform:SetParent(var_91_9001)
				end

				var_91_2.transform.localPosition = Vector3.New(2.55, 1.2, 8.88)
				var_91_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.4 < arg_88_1.time_ and arg_88_1.time_ <= 0.4 + arg_91_0 then
				local var_91_4 = arg_88_1.var_.effectzaguoqu3

				if not arg_88_1.var_.effectzaguoqu3 then
					var_91_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_91_4.name = "zaguoqu3"
					arg_88_1.var_.effectzaguoqu3 = var_91_4
				else
					var_91_4.transform:SetParent(var_91_9000)
				end

				var_91_4.transform.localPosition = Vector3.New(-3.01, -1.59, 6.4)
				var_91_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_91_6 = manager.ui.mainCamera.transform

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.shakeOldPos = var_91_6.localPosition
			end

			local var_91_7 = 0.6

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_7 then
				local var_91_8, var_91_9 = math.modf((arg_88_1.time_ - 0) / 0.066)

				var_91_6.localPosition = Vector3.New(var_91_9 * 0.13, var_91_9 * 0.13, var_91_9 * 0.13) + arg_88_1.var_.shakeOldPos
			end

			if arg_88_1.time_ >= 0 + var_91_7 and arg_88_1.time_ < 0 + var_91_7 + arg_91_0 then
				var_91_6.localPosition = arg_88_1.var_.shakeOldPos
			end

			local var_91_10 = 0

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_10 + arg_91_0 then
				arg_88_1.allBtn_.enabled = false
			end

			if arg_88_1.time_ >= var_91_10 + 0.6 and arg_88_1.time_ < var_91_10 + 0.6 + arg_91_0 then
				arg_88_1.allBtn_.enabled = true
			end

			local var_91_11 = 0
			local var_91_12 = 1.45

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_11 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_13 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(301061022).content)

				arg_88_1.text_.text = var_91_13

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_15 = 58 <= 0 and var_91_12 or var_91_12 * (utf8.len(var_91_13) / 58)

				if (58 <= 0 and var_91_12 or var_91_12 * (utf8.len(var_91_13) / 58)) > 0 and var_91_12 < var_91_15 then
					arg_88_1.talkMaxDuration = var_91_15

					if var_91_15 + var_91_11 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_15 + var_91_11
					end
				end

				arg_88_1.text_.text = var_91_13
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_16 = math.max(var_91_12, arg_88_1.talkMaxDuration)

			if var_91_11 <= arg_88_1.time_ and arg_88_1.time_ < var_91_11 + var_91_16 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_11) / var_91_16

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_11 + var_91_16 and arg_88_1.time_ < var_91_11 + var_91_16 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play301061023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 301061023
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play301061024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 1.225

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_1 = arg_92_1:FormatText(arg_92_1:GetWordFromCfg(301061023).content)

				arg_92_1.text_.text = var_95_1

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_3 = 49 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_1) / 49)

				if (49 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_1) / 49)) > 0 and var_95_0 < var_95_3 then
					arg_92_1.talkMaxDuration = var_95_3

					if var_95_3 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_3 + 0
					end
				end

				arg_92_1.text_.text = var_95_1
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_4 = math.max(var_95_0, arg_92_1.talkMaxDuration)

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_4 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - 0) / var_95_4

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= 0 + var_95_4 and arg_92_1.time_ < 0 + var_95_4 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play301061024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 301061024
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play301061025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 1.325

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_1 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(301061024).content)

				arg_96_1.text_.text = var_99_1

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_3 = 53 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_1) / 53)

				if (53 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_1) / 53)) > 0 and var_99_0 < var_99_3 then
					arg_96_1.talkMaxDuration = var_99_3

					if var_99_3 + 0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_3 + 0
					end
				end

				arg_96_1.text_.text = var_99_1
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_4 = math.max(var_99_0, arg_96_1.talkMaxDuration)

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_4 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - 0) / var_99_4

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= 0 + var_99_4 and arg_96_1.time_ < 0 + var_99_4 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play301061025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 301061025
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play301061026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0.1

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_1 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(301061025).content)

				arg_100_1.text_.text = var_103_1

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_3 = 4 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_1) / 4)

				if (4 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_1) / 4)) > 0 and var_103_0 < var_103_3 then
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
	Play301061026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 301061026
		arg_104_1.duration_ = 6.17

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play301061027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_9000

			if arg_104_1.bgs_.MS0102 == nil then
				local var_107_0 = Object.Instantiate(arg_104_1.paintGo_)

				var_107_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "MS0102")
				var_107_0.name = "MS0102"
				var_107_0.transform.parent = arg_104_1.stage_.transform
				var_107_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_104_1.bgs_.MS0102 = var_107_0
			end

			if 0.366666666666667 < arg_104_1.time_ and arg_104_1.time_ <= 0.366666666666667 + arg_107_0 then
				local var_107_1 = arg_104_1.bgs_.MS0102

				arg_104_1.bgs_.MS0102.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_107_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_107_2 = var_107_1:GetComponent("SpriteRenderer")

				if var_107_2 and var_107_2.sprite then
					local var_107_3 = 2 * (var_107_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_107_1.transform.localScale = Vector3.New(var_107_3 / var_107_2.sprite.bounds.size.y < var_107_3 * manager.ui.mainCameraCom_.aspect / var_107_2.sprite.bounds.size.x and var_107_3 * manager.ui.mainCameraCom_.aspect / var_107_2.sprite.bounds.size.x or var_107_3 / var_107_2.sprite.bounds.size.y, var_107_3 / var_107_2.sprite.bounds.size.y < var_107_3 * manager.ui.mainCameraCom_.aspect / var_107_2.sprite.bounds.size.x and var_107_3 * manager.ui.mainCameraCom_.aspect / var_107_2.sprite.bounds.size.x or var_107_3 / var_107_2.sprite.bounds.size.y, 0)
				end

				for iter_107_0, iter_107_1 in pairs(arg_104_1.bgs_) do
					if iter_107_0 ~= "MS0102" then
						iter_107_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_107_4 = 1.16666666666667

			if 1.16666666666667 < arg_104_1.time_ and arg_104_1.time_ <= var_107_4 + arg_107_0 then
				arg_104_1.allBtn_.enabled = false
			end

			if arg_104_1.time_ >= var_107_4 + 0.3 and arg_104_1.time_ < var_107_4 + 0.3 + arg_107_0 then
				arg_104_1.allBtn_.enabled = true
			end

			local var_107_5 = 0

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_5 + arg_107_0 then
				arg_104_1.mask_.enabled = true
				arg_104_1.mask_.raycastTarget = true

				arg_104_1:SetGaussion(false)
			end

			local var_107_6 = 0.366666666666667

			if var_107_5 <= arg_104_1.time_ and arg_104_1.time_ < var_107_5 + var_107_6 then
				local var_107_7 = Color.New(0, 0, 0)

				var_107_7.a = Mathf.Lerp(0, 1, (arg_104_1.time_ - var_107_5) / var_107_6)
				arg_104_1.mask_.color = var_107_7
			end

			if arg_104_1.time_ >= var_107_5 + var_107_6 and arg_104_1.time_ < var_107_5 + var_107_6 + arg_107_0 then
				local var_107_8 = Color.New(0, 0, 0)

				var_107_8.a = 1
				arg_104_1.mask_.color = var_107_8
			end

			local var_107_9 = 0.366666666666667

			if 0.366666666666667 < arg_104_1.time_ and arg_104_1.time_ <= var_107_9 + arg_107_0 then
				arg_104_1.mask_.enabled = true
				arg_104_1.mask_.raycastTarget = true

				arg_104_1:SetGaussion(false)
			end

			local var_107_10 = 0.266666666666667

			if var_107_9 <= arg_104_1.time_ and arg_104_1.time_ < var_107_9 + var_107_10 then
				local var_107_11 = Color.New(0, 0, 0)

				var_107_11.a = Mathf.Lerp(1, 0, (arg_104_1.time_ - var_107_9) / var_107_10)
				arg_104_1.mask_.color = var_107_11
			end

			if arg_104_1.time_ >= var_107_9 + var_107_10 and arg_104_1.time_ < var_107_9 + var_107_10 + arg_107_0 then
				local var_107_12 = Color.New(0, 0, 0)

				arg_104_1.mask_.enabled = false
				var_107_12.a = 0
				arg_104_1.mask_.color = var_107_12
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				local var_107_13 = arg_104_1.var_.effectdaguozhuchuchang1

				if not arg_104_1.var_.effectdaguozhuchuchang1 then
					var_107_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_lightmoment"), manager.ui.mainCamera.transform)
					var_107_13.name = "daguozhuchuchang1"
					arg_104_1.var_.effectdaguozhuchuchang1 = var_107_13
				else
					var_107_13.transform:SetParent(var_107_9000)
				end

				var_107_13.transform.localPosition = Vector3.New(0, 0, 0)
				var_107_13.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_107_15 = Mathf.Max(Screen.width / Screen.height / 1.7777777777777777, (Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1)))

				var_107_13.transform.localScale = Vector3.New(var_107_13.transform.localScale.x * var_107_15, var_107_13.transform.localScale.y * var_107_15, var_107_13.transform.localScale.z * var_107_15)
			end

			local var_107_16 = arg_104_1.bgs_.MS0102.transform

			if 0.333333333333333 < arg_104_1.time_ and arg_104_1.time_ <= 0.333333333333333 + arg_107_0 then
				arg_104_1.var_.moveOldPosMS0102 = var_107_16.localPosition
			end

			local var_107_17 = 2

			if 0.333333333333333 <= arg_104_1.time_ and arg_104_1.time_ < 0.333333333333333 + var_107_17 then
				var_107_16.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPosMS0102, Vector3.New(1, 0.5, 7.5), (arg_104_1.time_ - 0.333333333333333) / var_107_17)
			end

			if arg_104_1.time_ >= 0.333333333333333 + var_107_17 and arg_104_1.time_ < 0.333333333333333 + var_107_17 + arg_107_0 then
				var_107_16.localPosition = Vector3.New(1, 0.5, 7.5)
			end

			if arg_104_1.frameCnt_ <= 1 then
				arg_104_1.dialog_:SetActive(false)
			end

			local var_107_18 = 1.16666666666667
			local var_107_19 = 1.65

			if 1.16666666666667 < arg_104_1.time_ and arg_104_1.time_ <= var_107_18 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0

				arg_104_1.dialog_:SetActive(true)

				arg_104_1.dialogCg_.alpha = 0

				local var_107_20 = LeanTween.value(arg_104_1.dialog_, 0, 1, 0.3)

				var_107_20:setOnUpdate(LuaHelper.FloatAction(function(arg_108_0)
					arg_104_1.dialogCg_.alpha = arg_108_0
				end))
				var_107_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_104_1.dialog_)
					var_107_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_104_1.duration_ = arg_104_1.duration_ + 0.3

				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_21 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(301061026).content)

				arg_104_1.text_.text = var_107_21

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_23 = 64 <= 0 and var_107_19 or var_107_19 * (utf8.len(var_107_21) / 64)

				if (64 <= 0 and var_107_19 or var_107_19 * (utf8.len(var_107_21) / 64)) > 0 and var_107_19 < var_107_23 then
					arg_104_1.talkMaxDuration = var_107_23
					var_107_18 = var_107_18 + 0.3

					if var_107_23 + var_107_18 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_23 + var_107_18
					end
				end

				arg_104_1.text_.text = var_107_21
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_24 = var_107_18 + 0.3
			local var_107_25 = math.max(var_107_19, arg_104_1.talkMaxDuration)

			if var_107_18 + 0.3 <= arg_104_1.time_ and arg_104_1.time_ < var_107_24 + var_107_25 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_24) / var_107_25

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_24 + var_107_25 and arg_104_1.time_ < var_107_24 + var_107_25 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS0102",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 0.333333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(1, 0.5, 8),
					endPos = Vector3.New(1, 0.5, 7.5),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play301061027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 301061027
		arg_110_1.duration_ = 6.77

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play301061028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_9001
			local var_113_9000

			if 0.533333333333333 < arg_110_1.time_ and arg_110_1.time_ <= 0.533333333333333 + arg_113_0 then
				arg_110_1.var_.moveOldPosMS0102 = arg_110_1.bgs_.MS0102.transform.localPosition
			end

			local var_113_0 = 0.966666666666667

			if 0.533333333333333 <= arg_110_1.time_ and arg_110_1.time_ < 0.533333333333333 + var_113_0 then
				arg_110_1.bgs_.MS0102.transform.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPosMS0102, Vector3.New(0, 1, 10), (arg_110_1.time_ - 0.533333333333333) / var_113_0)
			end

			if arg_110_1.time_ >= 0.533333333333333 + var_113_0 and arg_110_1.time_ < 0.533333333333333 + var_113_0 + arg_113_0 then
				arg_110_1.bgs_.MS0102.transform.localPosition = Vector3.New(0, 1, 10)
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				local var_113_1 = arg_110_1.var_.effectdaguozhujibaiguaiwu1

				if not arg_110_1.var_.effectdaguozhujibaiguaiwu1 then
					var_113_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang07"), manager.ui.mainCamera.transform)
					var_113_1.name = "daguozhujibaiguaiwu1"
					arg_110_1.var_.effectdaguozhujibaiguaiwu1 = var_113_1
				else
					var_113_1.transform:SetParent(var_113_9001)
				end

				var_113_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_113_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.76666666666667 < arg_110_1.time_ and arg_110_1.time_ <= 2.76666666666667 + arg_113_0 then
				if arg_110_1.var_.effectdaguozhujibaiguaiwu1 then
					Object.Destroy(arg_110_1.var_.effectdaguozhujibaiguaiwu1)

					arg_110_1.var_.effectdaguozhujibaiguaiwu1 = nil
				end
			end

			local var_113_4 = 0

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_4 + arg_113_0 then
				arg_110_1.allBtn_.enabled = false
			end

			if arg_110_1.time_ >= var_113_4 + 2.66666666666667 and arg_110_1.time_ < var_113_4 + 2.66666666666667 + arg_113_0 then
				arg_110_1.allBtn_.enabled = true
			end

			if 1 < arg_110_1.time_ and arg_110_1.time_ <= 1 + arg_113_0 then
				local var_113_5 = arg_110_1.var_.effectRREWW

				if not arg_110_1.var_.effectRREWW then
					var_113_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), manager.ui.mainCamera.transform)
					var_113_5.name = "RREWW"
					arg_110_1.var_.effectRREWW = var_113_5
				else
					var_113_5.transform:SetParent(var_113_9000)
				end

				var_113_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_113_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.5 < arg_110_1.time_ and arg_110_1.time_ <= 2.5 + arg_113_0 then
				if arg_110_1.var_.effectRREWW then
					Object.Destroy(arg_110_1.var_.effectRREWW)

					arg_110_1.var_.effectRREWW = nil
				end
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:AudioAction("play", "effect", "se_story_152", "se_story_152_heavy_down", "")
			end

			if arg_110_1.frameCnt_ <= 1 then
				arg_110_1.dialog_:SetActive(false)
			end

			local var_113_9 = 1.76666666666667
			local var_113_10 = 1.8

			if 1.76666666666667 < arg_110_1.time_ and arg_110_1.time_ <= var_113_9 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0

				arg_110_1.dialog_:SetActive(true)

				arg_110_1.dialogCg_.alpha = 0

				local var_113_11 = LeanTween.value(arg_110_1.dialog_, 0, 1, 0.3)

				var_113_11:setOnUpdate(LuaHelper.FloatAction(function(arg_114_0)
					arg_110_1.dialogCg_.alpha = arg_114_0
				end))
				var_113_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_110_1.dialog_)
					var_113_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_110_1.duration_ = arg_110_1.duration_ + 0.3

				SetActive(arg_110_1.leftNameGo_, false)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_12 = arg_110_1:FormatText(arg_110_1:GetWordFromCfg(301061027).content)

				arg_110_1.text_.text = var_113_12

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_14 = 72 <= 0 and var_113_10 or var_113_10 * (utf8.len(var_113_12) / 72)

				if (72 <= 0 and var_113_10 or var_113_10 * (utf8.len(var_113_12) / 72)) > 0 and var_113_10 < var_113_14 then
					arg_110_1.talkMaxDuration = var_113_14
					var_113_9 = var_113_9 + 0.3

					if var_113_14 + var_113_9 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_14 + var_113_9
					end
				end

				arg_110_1.text_.text = var_113_12
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_15 = var_113_9 + 0.3
			local var_113_16 = math.max(var_113_10, arg_110_1.talkMaxDuration)

			if var_113_9 + 0.3 <= arg_110_1.time_ and arg_110_1.time_ < var_113_15 + var_113_16 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_15) / var_113_16

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_15 + var_113_16 and arg_110_1.time_ < var_113_15 + var_113_16 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS0102",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.966666666666667,
				startTime = 0.533333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(1, 0.5, 7.5),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeInOutCubic
				}
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play301061028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 301061028
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play301061029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0.1

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_1 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(301061028).content)

				arg_116_1.text_.text = var_119_1

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_3 = 4 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_1) / 4)

				if (4 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_1) / 4)) > 0 and var_119_0 < var_119_3 then
					arg_116_1.talkMaxDuration = var_119_3

					if var_119_3 + 0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_3 + 0
					end
				end

				arg_116_1.text_.text = var_119_1
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_4 = math.max(var_119_0, arg_116_1.talkMaxDuration)

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_4 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - 0) / var_119_4

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= 0 + var_119_4 and arg_116_1.time_ < 0 + var_119_4 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play301061029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 301061029
		arg_120_1.duration_ = 5.73

		local var_120_0 = {
			zh = 5.73266666666667,
			ja = 4.29966666666667
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play301061030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if arg_120_1.bgs_.MS0102a == nil then
				local var_123_0 = Object.Instantiate(arg_120_1.paintGo_)

				var_123_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "MS0102a")
				var_123_0.name = "MS0102a"
				var_123_0.transform.parent = arg_120_1.stage_.transform
				var_123_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_120_1.bgs_.MS0102a = var_123_0
			end

			if 1.55739871130014 < arg_120_1.time_ and arg_120_1.time_ <= 1.55739871130014 + arg_123_0 then
				local var_123_1 = arg_120_1.bgs_.MS0102a

				arg_120_1.bgs_.MS0102a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_123_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_123_2 = var_123_1:GetComponent("SpriteRenderer")

				if var_123_2 and var_123_2.sprite then
					local var_123_3 = 2 * (var_123_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_123_1.transform.localScale = Vector3.New(var_123_3 / var_123_2.sprite.bounds.size.y < var_123_3 * manager.ui.mainCameraCom_.aspect / var_123_2.sprite.bounds.size.x and var_123_3 * manager.ui.mainCameraCom_.aspect / var_123_2.sprite.bounds.size.x or var_123_3 / var_123_2.sprite.bounds.size.y, var_123_3 / var_123_2.sprite.bounds.size.y < var_123_3 * manager.ui.mainCameraCom_.aspect / var_123_2.sprite.bounds.size.x and var_123_3 * manager.ui.mainCameraCom_.aspect / var_123_2.sprite.bounds.size.x or var_123_3 / var_123_2.sprite.bounds.size.y, 0)
				end

				for iter_123_0, iter_123_1 in pairs(arg_120_1.bgs_) do
					if iter_123_0 ~= "MS0102a" then
						iter_123_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_123_4 = 2.25739871130014

			if 2.25739871130014 < arg_120_1.time_ and arg_120_1.time_ <= var_123_4 + arg_123_0 then
				arg_120_1.allBtn_.enabled = false
			end

			if arg_120_1.time_ >= var_123_4 + 0.5 and arg_120_1.time_ < var_123_4 + 0.5 + arg_123_0 then
				arg_120_1.allBtn_.enabled = true
			end

			local var_123_5 = 0

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_5 + arg_123_0 then
				arg_120_1.mask_.enabled = true
				arg_120_1.mask_.raycastTarget = true

				arg_120_1:SetGaussion(false)
			end

			local var_123_6 = 1.55739871130014

			if var_123_5 <= arg_120_1.time_ and arg_120_1.time_ < var_123_5 + var_123_6 then
				local var_123_7 = Color.New(1, 1, 1)

				var_123_7.a = Mathf.Lerp(0, 1, (arg_120_1.time_ - var_123_5) / var_123_6)
				arg_120_1.mask_.color = var_123_7
			end

			if arg_120_1.time_ >= var_123_5 + var_123_6 and arg_120_1.time_ < var_123_5 + var_123_6 + arg_123_0 then
				local var_123_8 = Color.New(1, 1, 1)

				var_123_8.a = 1
				arg_120_1.mask_.color = var_123_8
			end

			local var_123_9 = 1.55739871130014

			if 1.55739871130014 < arg_120_1.time_ and arg_120_1.time_ <= var_123_9 + arg_123_0 then
				arg_120_1.mask_.enabled = true
				arg_120_1.mask_.raycastTarget = true

				arg_120_1:SetGaussion(false)
			end

			local var_123_10 = 0.7

			if var_123_9 <= arg_120_1.time_ and arg_120_1.time_ < var_123_9 + var_123_10 then
				local var_123_11 = Color.New(1, 1, 1)

				var_123_11.a = Mathf.Lerp(1, 0, (arg_120_1.time_ - var_123_9) / var_123_10)
				arg_120_1.mask_.color = var_123_11
			end

			if arg_120_1.time_ >= var_123_9 + var_123_10 and arg_120_1.time_ < var_123_9 + var_123_10 + arg_123_0 then
				local var_123_12 = Color.New(1, 1, 1)

				arg_120_1.mask_.enabled = false
				var_123_12.a = 0
				arg_120_1.mask_.color = var_123_12
			end

			local var_123_13 = arg_120_1.bgs_.MS0102a.transform

			if 1.55739871130015 < arg_120_1.time_ and arg_120_1.time_ <= 1.55739871130015 + arg_123_0 then
				arg_120_1.var_.moveOldPosMS0102a = var_123_13.localPosition
			end

			local var_123_14 = 2.13333333333333

			if 1.55739871130015 <= arg_120_1.time_ and arg_120_1.time_ < 1.55739871130015 + var_123_14 then
				var_123_13.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPosMS0102a, Vector3.New(0, 1, 7), (arg_120_1.time_ - 1.55739871130015) / var_123_14)
			end

			if arg_120_1.time_ >= 1.55739871130015 + var_123_14 and arg_120_1.time_ < 1.55739871130015 + var_123_14 + arg_123_0 then
				var_123_13.localPosition = Vector3.New(0, 1, 7)
			end

			local var_123_15 = 1.9

			if 1.9 < arg_120_1.time_ and arg_120_1.time_ <= var_123_15 + arg_123_0 then
				arg_120_1.allBtn_.enabled = false
			end

			if arg_120_1.time_ >= var_123_15 + 1.65739871130014 and arg_120_1.time_ < var_123_15 + 1.65739871130014 + arg_123_0 then
				arg_120_1.allBtn_.enabled = true
			end

			if arg_120_1.frameCnt_ <= 1 then
				arg_120_1.dialog_:SetActive(false)
			end

			local var_123_16 = 2.96666666666667
			local var_123_17 = 0.2

			if 2.96666666666667 < arg_120_1.time_ and arg_120_1.time_ <= var_123_16 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0

				arg_120_1.dialog_:SetActive(true)

				arg_120_1.dialogCg_.alpha = 0

				local var_123_18 = LeanTween.value(arg_120_1.dialog_, 0, 1, 0.3)

				var_123_18:setOnUpdate(LuaHelper.FloatAction(function(arg_124_0)
					arg_120_1.dialogCg_.alpha = arg_124_0
				end))
				var_123_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_120_1.dialog_)
					var_123_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_120_1.duration_ = arg_120_1.duration_ + 0.3

				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_19 = arg_120_1:GetWordFromCfg(301061029)
				local var_123_20 = arg_120_1:FormatText(var_123_19.content)

				arg_120_1.text_.text = var_123_20

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_22 = 8 <= 0 and var_123_17 or var_123_17 * (utf8.len(var_123_20) / 8)

				if (8 <= 0 and var_123_17 or var_123_17 * (utf8.len(var_123_20) / 8)) > 0 and var_123_17 < var_123_22 then
					arg_120_1.talkMaxDuration = var_123_22
					var_123_16 = var_123_16 + 0.3

					if var_123_22 + var_123_16 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_22 + var_123_16
					end
				end

				arg_120_1.text_.text = var_123_20
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301061", "301061029", "story_v_out_301061.awb") ~= 0 then
					local var_123_23 = manager.audio:GetVoiceLength("story_v_out_301061", "301061029", "story_v_out_301061.awb") / 1000

					if var_123_23 + var_123_16 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_23 + var_123_16
					end

					if var_123_19.prefab_name ~= "" and arg_120_1.actors_[var_123_19.prefab_name] ~= nil then
						local var_123_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_19.prefab_name].transform, "story_v_out_301061", "301061029", "story_v_out_301061.awb")

						arg_120_1:RecordAudio("301061029", var_123_24)
						arg_120_1:RecordAudio("301061029", var_123_24)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_301061", "301061029", "story_v_out_301061.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_301061", "301061029", "story_v_out_301061.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_25 = var_123_16 + 0.3
			local var_123_26 = math.max(var_123_17, arg_120_1.talkMaxDuration)

			if var_123_16 + 0.3 <= arg_120_1.time_ and arg_120_1.time_ < var_123_25 + var_123_26 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_25) / var_123_26

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_25 + var_123_26 and arg_120_1.time_ < var_123_25 + var_123_26 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS0102a",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.13333333333333,
				startTime = 1.55739871130015,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 2),
					endPos = Vector3.New(0, 1, 7),
					easeType = LeanTweenType.easeInOutQuad
				}
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play301061030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 301061030
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play301061031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 1.6

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, false)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_1 = arg_126_1:FormatText(arg_126_1:GetWordFromCfg(301061030).content)

				arg_126_1.text_.text = var_129_1

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_3 = 64 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_1) / 64)

				if (64 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_1) / 64)) > 0 and var_129_0 < var_129_3 then
					arg_126_1.talkMaxDuration = var_129_3

					if var_129_3 + 0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_3 + 0
					end
				end

				arg_126_1.text_.text = var_129_1
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_4 = math.max(var_129_0, arg_126_1.talkMaxDuration)

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_4 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - 0) / var_129_4

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= 0 + var_129_4 and arg_126_1.time_ < 0 + var_129_4 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play301061031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 301061031
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play301061032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 1.4

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_1 = arg_130_1:FormatText(arg_130_1:GetWordFromCfg(301061031).content)

				arg_130_1.text_.text = var_133_1

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_3 = 56 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_1) / 56)

				if (56 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_1) / 56)) > 0 and var_133_0 < var_133_3 then
					arg_130_1.talkMaxDuration = var_133_3

					if var_133_3 + 0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_3 + 0
					end
				end

				arg_130_1.text_.text = var_133_1
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_4 = math.max(var_133_0, arg_130_1.talkMaxDuration)

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_4 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - 0) / var_133_4

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= 0 + var_133_4 and arg_130_1.time_ < 0 + var_133_4 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play301061032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 301061032
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play301061033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 1

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, false)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_1 = arg_134_1:FormatText(arg_134_1:GetWordFromCfg(301061032).content)

				arg_134_1.text_.text = var_137_1

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_3 = 40 <= 0 and var_137_0 or var_137_0 * (utf8.len(var_137_1) / 40)

				if (40 <= 0 and var_137_0 or var_137_0 * (utf8.len(var_137_1) / 40)) > 0 and var_137_0 < var_137_3 then
					arg_134_1.talkMaxDuration = var_137_3

					if var_137_3 + 0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_3 + 0
					end
				end

				arg_134_1.text_.text = var_137_1
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_4 = math.max(var_137_0, arg_134_1.talkMaxDuration)

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_4 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - 0) / var_137_4

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= 0 + var_137_4 and arg_134_1.time_ < 0 + var_137_4 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play301061033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 301061033
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play301061034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0.275

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, false)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_1 = arg_138_1:FormatText(arg_138_1:GetWordFromCfg(301061033).content)

				arg_138_1.text_.text = var_141_1

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_3 = 11 <= 0 and var_141_0 or var_141_0 * (utf8.len(var_141_1) / 11)

				if (11 <= 0 and var_141_0 or var_141_0 * (utf8.len(var_141_1) / 11)) > 0 and var_141_0 < var_141_3 then
					arg_138_1.talkMaxDuration = var_141_3

					if var_141_3 + 0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_3 + 0
					end
				end

				arg_138_1.text_.text = var_141_1
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_4 = math.max(var_141_0, arg_138_1.talkMaxDuration)

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_4 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - 0) / var_141_4

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= 0 + var_141_4 and arg_138_1.time_ < 0 + var_141_4 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play301061034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 301061034
		arg_142_1.duration_ = 5.77

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play301061035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 2 < arg_142_1.time_ and arg_142_1.time_ <= 2 + arg_145_0 then
				local var_145_0 = arg_142_1.bgs_.B01c

				arg_142_1.bgs_.B01c.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_145_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_145_1 = var_145_0:GetComponent("SpriteRenderer")

				if var_145_1 and var_145_1.sprite then
					local var_145_2 = 2 * (var_145_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_145_0.transform.localScale = Vector3.New(var_145_2 / var_145_1.sprite.bounds.size.y < var_145_2 * manager.ui.mainCameraCom_.aspect / var_145_1.sprite.bounds.size.x and var_145_2 * manager.ui.mainCameraCom_.aspect / var_145_1.sprite.bounds.size.x or var_145_2 / var_145_1.sprite.bounds.size.y, var_145_2 / var_145_1.sprite.bounds.size.y < var_145_2 * manager.ui.mainCameraCom_.aspect / var_145_1.sprite.bounds.size.x and var_145_2 * manager.ui.mainCameraCom_.aspect / var_145_1.sprite.bounds.size.x or var_145_2 / var_145_1.sprite.bounds.size.y, 0)
				end

				for iter_145_0, iter_145_1 in pairs(arg_142_1.bgs_) do
					if iter_145_0 ~= "B01c" then
						iter_145_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_145_3 = 4

			if 4 < arg_142_1.time_ and arg_142_1.time_ <= var_145_3 + arg_145_0 then
				arg_142_1.allBtn_.enabled = false
			end

			if arg_142_1.time_ >= var_145_3 + 0.3 and arg_142_1.time_ < var_145_3 + 0.3 + arg_145_0 then
				arg_142_1.allBtn_.enabled = true
			end

			local var_145_4 = 0

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_4 + arg_145_0 then
				arg_142_1.mask_.enabled = true
				arg_142_1.mask_.raycastTarget = true

				arg_142_1:SetGaussion(false)
			end

			local var_145_5 = 2

			if var_145_4 <= arg_142_1.time_ and arg_142_1.time_ < var_145_4 + var_145_5 then
				local var_145_6 = Color.New(0, 0, 0)

				var_145_6.a = Mathf.Lerp(0, 1, (arg_142_1.time_ - var_145_4) / var_145_5)
				arg_142_1.mask_.color = var_145_6
			end

			if arg_142_1.time_ >= var_145_4 + var_145_5 and arg_142_1.time_ < var_145_4 + var_145_5 + arg_145_0 then
				local var_145_7 = Color.New(0, 0, 0)

				var_145_7.a = 1
				arg_142_1.mask_.color = var_145_7
			end

			local var_145_8 = 2

			if 2 < arg_142_1.time_ and arg_142_1.time_ <= var_145_8 + arg_145_0 then
				arg_142_1.mask_.enabled = true
				arg_142_1.mask_.raycastTarget = true

				arg_142_1:SetGaussion(false)
			end

			local var_145_9 = 2

			if var_145_8 <= arg_142_1.time_ and arg_142_1.time_ < var_145_8 + var_145_9 then
				local var_145_10 = Color.New(0, 0, 0)

				var_145_10.a = Mathf.Lerp(1, 0, (arg_142_1.time_ - var_145_8) / var_145_9)
				arg_142_1.mask_.color = var_145_10
			end

			if arg_142_1.time_ >= var_145_8 + var_145_9 and arg_142_1.time_ < var_145_8 + var_145_9 + arg_145_0 then
				local var_145_11 = Color.New(0, 0, 0)

				arg_142_1.mask_.enabled = false
				var_145_11.a = 0
				arg_142_1.mask_.color = var_145_11
			end

			local var_145_12 = "1166ui_story"

			if arg_142_1.actors_["1166ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1166ui_story"))) then
				local var_145_13 = Object.Instantiate(Asset.Load("Char/" .. "1166ui_story"), arg_142_1.stage_.transform)

				var_145_13.name = var_145_12
				var_145_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_142_1.actors_[var_145_12] = var_145_13

				local var_145_14 = var_145_13:GetComponentInChildren(typeof(CharacterEffect))

				var_145_14.enabled = true

				local var_145_15 = GameObjectTools.GetOrAddComponent(var_145_13, typeof(DynamicBoneHelper))

				if var_145_15 then
					var_145_15:EnableDynamicBone(false)
				end

				arg_142_1:ShowWeapon(var_145_14.transform, false)

				arg_142_1.var_[var_145_12 .. "Animator"] = var_145_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_142_1.var_[var_145_12 .. "Animator"].applyRootMotion = true
				arg_142_1.var_[var_145_12 .. "LipSync"] = var_145_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_145_16 = arg_142_1.actors_["1166ui_story"].transform

			if 3.76666666666667 < arg_142_1.time_ and arg_142_1.time_ <= 3.76666666666667 + arg_145_0 then
				arg_142_1.var_.moveOldPos1166ui_story = var_145_16.localPosition

				local var_145_17 = GameObjectTools.GetOrAddComponent(var_145_16.gameObject, typeof(DynamicBoneHelper))

				if var_145_17 then
					var_145_17:EnableDynamicBone(false)
				end
			end

			local var_145_18 = 0.001

			if 3.76666666666667 <= arg_142_1.time_ and arg_142_1.time_ < 3.76666666666667 + var_145_18 then
				var_145_16.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos1166ui_story, Vector3.New(0, -0.75, -6.25), (arg_142_1.time_ - 3.76666666666667) / var_145_18)
				var_145_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_145_16.position).x, (manager.ui.mainCamera.transform.position - var_145_16.position).y, (manager.ui.mainCamera.transform.position - var_145_16.position).z)
				var_145_16.localEulerAngles.z = 0
				var_145_16.localEulerAngles.x = 0
				var_145_16.localEulerAngles = var_145_16.localEulerAngles
			end

			if arg_142_1.time_ >= 3.76666666666667 + var_145_18 and arg_142_1.time_ < 3.76666666666667 + var_145_18 + arg_145_0 then
				var_145_16.localPosition = Vector3.New(0, -0.75, -6.25)
				var_145_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_145_16.position).x, (manager.ui.mainCamera.transform.position - var_145_16.position).y, (manager.ui.mainCamera.transform.position - var_145_16.position).z)
				var_145_16.localEulerAngles.z = 0
				var_145_16.localEulerAngles.x = 0
				var_145_16.localEulerAngles = var_145_16.localEulerAngles

				local var_145_19 = GameObjectTools.GetOrAddComponent(var_145_16.gameObject, typeof(DynamicBoneHelper))

				if var_145_19 then
					var_145_19:EnableDynamicBone(true)
				end
			end

			local var_145_20 = arg_142_1.actors_["1166ui_story"]

			if 3.76666666666667 < arg_142_1.time_ and arg_142_1.time_ <= 3.76666666666667 + arg_145_0 and not isNil(var_145_20) and arg_142_1.var_.characterEffect1166ui_story == nil then
				arg_142_1.var_.characterEffect1166ui_story = var_145_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_21 = 0.200000002980232

			if 3.76666666666667 <= arg_142_1.time_ and arg_142_1.time_ < 3.76666666666667 + var_145_21 and not isNil(var_145_20) then
				if arg_142_1.var_.characterEffect1166ui_story and not isNil(var_145_20) then
					arg_142_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= 3.76666666666667 + var_145_21 and arg_142_1.time_ < 3.76666666666667 + var_145_21 + arg_145_0 and not isNil(var_145_20) and arg_142_1.var_.characterEffect1166ui_story then
				arg_142_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			if 3.76666666666667 < arg_142_1.time_ and arg_142_1.time_ <= 3.76666666666667 + arg_145_0 then
				arg_142_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action1_1")
			end

			if 3.76666666666667 < arg_142_1.time_ and arg_142_1.time_ <= 3.76666666666667 + arg_145_0 then
				arg_142_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if arg_142_1.frameCnt_ <= 1 then
				arg_142_1.dialog_:SetActive(false)
			end

			local var_145_23 = 4
			local var_145_24 = 0.125

			if 4 < arg_142_1.time_ and arg_142_1.time_ <= var_145_23 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0

				arg_142_1.dialog_:SetActive(true)

				arg_142_1.dialogCg_.alpha = 0

				local var_145_25 = LeanTween.value(arg_142_1.dialog_, 0, 1, 0.3)

				var_145_25:setOnUpdate(LuaHelper.FloatAction(function(arg_146_0)
					arg_142_1.dialogCg_.alpha = arg_146_0
				end))
				var_145_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_142_1.dialog_)
					var_145_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_142_1.duration_ = arg_142_1.duration_ + 0.3

				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_26 = arg_142_1:GetWordFromCfg(301061034)
				local var_145_27 = arg_142_1:FormatText(var_145_26.content)

				arg_142_1.text_.text = var_145_27

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_29 = 5 <= 0 and var_145_24 or var_145_24 * (utf8.len(var_145_27) / 5)

				if (5 <= 0 and var_145_24 or var_145_24 * (utf8.len(var_145_27) / 5)) > 0 and var_145_24 < var_145_29 then
					arg_142_1.talkMaxDuration = var_145_29
					var_145_23 = var_145_23 + 0.3

					if var_145_29 + var_145_23 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_29 + var_145_23
					end
				end

				arg_142_1.text_.text = var_145_27
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301061", "301061034", "story_v_out_301061.awb") ~= 0 then
					local var_145_30 = manager.audio:GetVoiceLength("story_v_out_301061", "301061034", "story_v_out_301061.awb") / 1000

					if var_145_30 + var_145_23 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_30 + var_145_23
					end

					if var_145_26.prefab_name ~= "" and arg_142_1.actors_[var_145_26.prefab_name] ~= nil then
						local var_145_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_26.prefab_name].transform, "story_v_out_301061", "301061034", "story_v_out_301061.awb")

						arg_142_1:RecordAudio("301061034", var_145_31)
						arg_142_1:RecordAudio("301061034", var_145_31)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_301061", "301061034", "story_v_out_301061.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_301061", "301061034", "story_v_out_301061.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_32 = var_145_23 + 0.3
			local var_145_33 = math.max(var_145_24, arg_142_1.talkMaxDuration)

			if var_145_23 + 0.3 <= arg_142_1.time_ and arg_142_1.time_ < var_145_32 + var_145_33 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_32) / var_145_33

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_32 + var_145_33 and arg_142_1.time_ < var_145_32 + var_145_33 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.76666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_142_1:InitPlayNodeList()
	end,
	Play301061035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 301061035
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play301061036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(arg_148_1.actors_["1166ui_story"]) and arg_148_1.var_.characterEffect1166ui_story == nil then
				arg_148_1.var_.characterEffect1166ui_story = arg_148_1.actors_["1166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_0 = 0.200000002980232

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 and not isNil(arg_148_1.actors_["1166ui_story"]) then
				if arg_148_1.var_.characterEffect1166ui_story and not isNil(arg_148_1.actors_["1166ui_story"]) then
					arg_148_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_148_1.var_.characterEffect1166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_148_1.time_ - 0) / var_151_0)
				end
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 and not isNil(arg_148_1.actors_["1166ui_story"]) and arg_148_1.var_.characterEffect1166ui_story then
				arg_148_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_148_1.var_.characterEffect1166ui_story.fillRatio = 0.5
			end

			local var_151_1 = 0
			local var_151_2 = 0.25

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, true)
				arg_148_1.iconController_:SetSelectedState("hero")

				arg_148_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_148_1.callingController_:SetSelectedState("normal")

				arg_148_1.keyicon_.color = Color.New(1, 1, 1)
				arg_148_1.icon_.color = Color.New(1, 1, 1)

				local var_151_3 = arg_148_1:FormatText(arg_148_1:GetWordFromCfg(301061035).content)

				arg_148_1.text_.text = var_151_3

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_5 = 10 <= 0 and var_151_2 or var_151_2 * (utf8.len(var_151_3) / 10)

				if (10 <= 0 and var_151_2 or var_151_2 * (utf8.len(var_151_3) / 10)) > 0 and var_151_2 < var_151_5 then
					arg_148_1.talkMaxDuration = var_151_5

					if var_151_5 + var_151_1 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_5 + var_151_1
					end
				end

				arg_148_1.text_.text = var_151_3
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_6 = math.max(var_151_2, arg_148_1.talkMaxDuration)

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_6 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_1) / var_151_6

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_1 + var_151_6 and arg_148_1.time_ < var_151_1 + var_151_6 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play301061036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 301061036
		arg_152_1.duration_ = 2

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play301061037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(arg_152_1.actors_["1166ui_story"]) and arg_152_1.var_.characterEffect1166ui_story == nil then
				arg_152_1.var_.characterEffect1166ui_story = arg_152_1.actors_["1166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_0 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 and not isNil(arg_152_1.actors_["1166ui_story"]) then
				if arg_152_1.var_.characterEffect1166ui_story and not isNil(arg_152_1.actors_["1166ui_story"]) then
					arg_152_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 and not isNil(arg_152_1.actors_["1166ui_story"]) and arg_152_1.var_.characterEffect1166ui_story then
				arg_152_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action1_1")
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganB", "EmotionTimelineAnimator")
			end

			local var_155_2 = 0
			local var_155_3 = 0.175

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_2 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_4 = arg_152_1:GetWordFromCfg(301061036)
				local var_155_5 = arg_152_1:FormatText(var_155_4.content)

				arg_152_1.text_.text = var_155_5

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_7 = 7 <= 0 and var_155_3 or var_155_3 * (utf8.len(var_155_5) / 7)

				if (7 <= 0 and var_155_3 or var_155_3 * (utf8.len(var_155_5) / 7)) > 0 and var_155_3 < var_155_7 then
					arg_152_1.talkMaxDuration = var_155_7

					if var_155_7 + var_155_2 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_7 + var_155_2
					end
				end

				arg_152_1.text_.text = var_155_5
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301061", "301061036", "story_v_out_301061.awb") ~= 0 then
					local var_155_8 = manager.audio:GetVoiceLength("story_v_out_301061", "301061036", "story_v_out_301061.awb") / 1000

					if var_155_8 + var_155_2 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_8 + var_155_2
					end

					if var_155_4.prefab_name ~= "" and arg_152_1.actors_[var_155_4.prefab_name] ~= nil then
						local var_155_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_4.prefab_name].transform, "story_v_out_301061", "301061036", "story_v_out_301061.awb")

						arg_152_1:RecordAudio("301061036", var_155_9)
						arg_152_1:RecordAudio("301061036", var_155_9)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_301061", "301061036", "story_v_out_301061.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_301061", "301061036", "story_v_out_301061.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_10 = math.max(var_155_3, arg_152_1.talkMaxDuration)

			if var_155_2 <= arg_152_1.time_ and arg_152_1.time_ < var_155_2 + var_155_10 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_2) / var_155_10

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_2 + var_155_10 and arg_152_1.time_ < var_155_2 + var_155_10 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play301061037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 301061037
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play301061038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(arg_156_1.actors_["1166ui_story"]) and arg_156_1.var_.characterEffect1166ui_story == nil then
				arg_156_1.var_.characterEffect1166ui_story = arg_156_1.actors_["1166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_0 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 and not isNil(arg_156_1.actors_["1166ui_story"]) then
				if arg_156_1.var_.characterEffect1166ui_story and not isNil(arg_156_1.actors_["1166ui_story"]) then
					arg_156_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_156_1.time_ - 0) / var_159_0)
				end
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 and not isNil(arg_156_1.actors_["1166ui_story"]) and arg_156_1.var_.characterEffect1166ui_story then
				arg_156_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1166ui_story.fillRatio = 0.5
			end

			local var_159_1 = 0
			local var_159_2 = 0.5

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_3 = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(301061037).content)

				arg_156_1.text_.text = var_159_3

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_5 = 20 <= 0 and var_159_2 or var_159_2 * (utf8.len(var_159_3) / 20)

				if (20 <= 0 and var_159_2 or var_159_2 * (utf8.len(var_159_3) / 20)) > 0 and var_159_2 < var_159_5 then
					arg_156_1.talkMaxDuration = var_159_5

					if var_159_5 + var_159_1 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_5 + var_159_1
					end
				end

				arg_156_1.text_.text = var_159_3
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_6 = math.max(var_159_2, arg_156_1.talkMaxDuration)

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_6 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_1) / var_159_6

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_1 + var_159_6 and arg_156_1.time_ < var_159_1 + var_159_6 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play301061038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 301061038
		arg_160_1.duration_ = 2

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play301061039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(arg_160_1.actors_["1166ui_story"]) and arg_160_1.var_.characterEffect1166ui_story == nil then
				arg_160_1.var_.characterEffect1166ui_story = arg_160_1.actors_["1166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_0 = 0.200000002980232

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_0 and not isNil(arg_160_1.actors_["1166ui_story"]) then
				if arg_160_1.var_.characterEffect1166ui_story and not isNil(arg_160_1.actors_["1166ui_story"]) then
					arg_160_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= 0 + var_163_0 and arg_160_1.time_ < 0 + var_163_0 + arg_163_0 and not isNil(arg_160_1.actors_["1166ui_story"]) and arg_160_1.var_.characterEffect1166ui_story then
				arg_160_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action2_1")
			end

			local var_163_2 = 0
			local var_163_3 = 0.05

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_2 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_4 = arg_160_1:GetWordFromCfg(301061038)
				local var_163_5 = arg_160_1:FormatText(var_163_4.content)

				arg_160_1.text_.text = var_163_5

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_7 = 2 <= 0 and var_163_3 or var_163_3 * (utf8.len(var_163_5) / 2)

				if (2 <= 0 and var_163_3 or var_163_3 * (utf8.len(var_163_5) / 2)) > 0 and var_163_3 < var_163_7 then
					arg_160_1.talkMaxDuration = var_163_7

					if var_163_7 + var_163_2 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_7 + var_163_2
					end
				end

				arg_160_1.text_.text = var_163_5
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301061", "301061038", "story_v_out_301061.awb") ~= 0 then
					local var_163_8 = manager.audio:GetVoiceLength("story_v_out_301061", "301061038", "story_v_out_301061.awb") / 1000

					if var_163_8 + var_163_2 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_8 + var_163_2
					end

					if var_163_4.prefab_name ~= "" and arg_160_1.actors_[var_163_4.prefab_name] ~= nil then
						local var_163_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_4.prefab_name].transform, "story_v_out_301061", "301061038", "story_v_out_301061.awb")

						arg_160_1:RecordAudio("301061038", var_163_9)
						arg_160_1:RecordAudio("301061038", var_163_9)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_301061", "301061038", "story_v_out_301061.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_301061", "301061038", "story_v_out_301061.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_10 = math.max(var_163_3, arg_160_1.talkMaxDuration)

			if var_163_2 <= arg_160_1.time_ and arg_160_1.time_ < var_163_2 + var_163_10 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_2) / var_163_10

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_2 + var_163_10 and arg_160_1.time_ < var_163_2 + var_163_10 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play301061039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 301061039
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play301061040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.var_.moveOldPos1166ui_story = arg_164_1.actors_["1166ui_story"].transform.localPosition

				local var_167_0 = GameObjectTools.GetOrAddComponent(arg_164_1.actors_["1166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_167_0 then
					var_167_0:EnableDynamicBone(false)
				end
			end

			local var_167_1 = 0.001

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_1 then
				arg_164_1.actors_["1166ui_story"].transform.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1166ui_story, Vector3.New(0, 100, 0), (arg_164_1.time_ - 0) / var_167_1)
				arg_164_1.actors_["1166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_164_1.actors_["1166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1166ui_story"].transform.position).z)
				arg_164_1.actors_["1166ui_story"].transform.localEulerAngles.z = 0
				arg_164_1.actors_["1166ui_story"].transform.localEulerAngles.x = 0
				arg_164_1.actors_["1166ui_story"].transform.localEulerAngles = arg_164_1.actors_["1166ui_story"].transform.localEulerAngles
			end

			if arg_164_1.time_ >= 0 + var_167_1 and arg_164_1.time_ < 0 + var_167_1 + arg_167_0 then
				arg_164_1.actors_["1166ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_164_1.actors_["1166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_164_1.actors_["1166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1166ui_story"].transform.position).z)
				arg_164_1.actors_["1166ui_story"].transform.localEulerAngles.z = 0
				arg_164_1.actors_["1166ui_story"].transform.localEulerAngles.x = 0
				arg_164_1.actors_["1166ui_story"].transform.localEulerAngles = arg_164_1.actors_["1166ui_story"].transform.localEulerAngles

				local var_167_2 = GameObjectTools.GetOrAddComponent(arg_164_1.actors_["1166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_167_2 then
					var_167_2:EnableDynamicBone(true)
				end
			end

			local var_167_3 = arg_164_1.actors_["1166ui_story"]

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(var_167_3) and arg_164_1.var_.characterEffect1166ui_story == nil then
				arg_164_1.var_.characterEffect1166ui_story = var_167_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_4 = 0.200000002980232

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_4 and not isNil(var_167_3) then
				if arg_164_1.var_.characterEffect1166ui_story and not isNil(var_167_3) then
					arg_164_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_164_1.var_.characterEffect1166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_164_1.time_ - 0) / var_167_4)
				end
			end

			if arg_164_1.time_ >= 0 + var_167_4 and arg_164_1.time_ < 0 + var_167_4 + arg_167_0 and not isNil(var_167_3) and arg_164_1.var_.characterEffect1166ui_story then
				arg_164_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_164_1.var_.characterEffect1166ui_story.fillRatio = 0.5
			end

			local var_167_5 = 0
			local var_167_6 = 1

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_5 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, false)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_7 = arg_164_1:FormatText(arg_164_1:GetWordFromCfg(301061039).content)

				arg_164_1.text_.text = var_167_7

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_9 = 40 <= 0 and var_167_6 or var_167_6 * (utf8.len(var_167_7) / 40)

				if (40 <= 0 and var_167_6 or var_167_6 * (utf8.len(var_167_7) / 40)) > 0 and var_167_6 < var_167_9 then
					arg_164_1.talkMaxDuration = var_167_9

					if var_167_9 + var_167_5 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_9 + var_167_5
					end
				end

				arg_164_1.text_.text = var_167_7
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_10 = math.max(var_167_6, arg_164_1.talkMaxDuration)

			if var_167_5 <= arg_164_1.time_ and arg_164_1.time_ < var_167_5 + var_167_10 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_5) / var_167_10

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_5 + var_167_10 and arg_164_1.time_ < var_167_5 + var_167_10 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play301061040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 301061040
		arg_168_1.duration_ = 4.7

		local var_168_0 = {
			zh = 4.7,
			ja = 1.999999999999
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play301061041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos1166ui_story = arg_168_1.actors_["1166ui_story"].transform.localPosition

				local var_171_0 = GameObjectTools.GetOrAddComponent(arg_168_1.actors_["1166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_171_0 then
					var_171_0:EnableDynamicBone(false)
				end
			end

			local var_171_1 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_1 then
				arg_168_1.actors_["1166ui_story"].transform.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1166ui_story, Vector3.New(0, -0.75, -6.25), (arg_168_1.time_ - 0) / var_171_1)
				arg_168_1.actors_["1166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_168_1.actors_["1166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1166ui_story"].transform.position).z)
				arg_168_1.actors_["1166ui_story"].transform.localEulerAngles.z = 0
				arg_168_1.actors_["1166ui_story"].transform.localEulerAngles.x = 0
				arg_168_1.actors_["1166ui_story"].transform.localEulerAngles = arg_168_1.actors_["1166ui_story"].transform.localEulerAngles
			end

			if arg_168_1.time_ >= 0 + var_171_1 and arg_168_1.time_ < 0 + var_171_1 + arg_171_0 then
				arg_168_1.actors_["1166ui_story"].transform.localPosition = Vector3.New(0, -0.75, -6.25)
				arg_168_1.actors_["1166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_168_1.actors_["1166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1166ui_story"].transform.position).z)
				arg_168_1.actors_["1166ui_story"].transform.localEulerAngles.z = 0
				arg_168_1.actors_["1166ui_story"].transform.localEulerAngles.x = 0
				arg_168_1.actors_["1166ui_story"].transform.localEulerAngles = arg_168_1.actors_["1166ui_story"].transform.localEulerAngles

				local var_171_2 = GameObjectTools.GetOrAddComponent(arg_168_1.actors_["1166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_171_2 then
					var_171_2:EnableDynamicBone(true)
				end
			end

			local var_171_3 = arg_168_1.actors_["1166ui_story"]

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(var_171_3) and arg_168_1.var_.characterEffect1166ui_story == nil then
				arg_168_1.var_.characterEffect1166ui_story = var_171_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_4 = 0.200000002980232

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_4 and not isNil(var_171_3) then
				if arg_168_1.var_.characterEffect1166ui_story and not isNil(var_171_3) then
					arg_168_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= 0 + var_171_4 and arg_168_1.time_ < 0 + var_171_4 + arg_171_0 and not isNil(var_171_3) and arg_168_1.var_.characterEffect1166ui_story then
				arg_168_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action2_2")
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_171_6 = 0
			local var_171_7 = 0.425

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_6 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_8 = arg_168_1:GetWordFromCfg(301061040)
				local var_171_9 = arg_168_1:FormatText(var_171_8.content)

				arg_168_1.text_.text = var_171_9

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_11 = 17 <= 0 and var_171_7 or var_171_7 * (utf8.len(var_171_9) / 17)

				if (17 <= 0 and var_171_7 or var_171_7 * (utf8.len(var_171_9) / 17)) > 0 and var_171_7 < var_171_11 then
					arg_168_1.talkMaxDuration = var_171_11

					if var_171_11 + var_171_6 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_11 + var_171_6
					end
				end

				arg_168_1.text_.text = var_171_9
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301061", "301061040", "story_v_out_301061.awb") ~= 0 then
					local var_171_12 = manager.audio:GetVoiceLength("story_v_out_301061", "301061040", "story_v_out_301061.awb") / 1000

					if var_171_12 + var_171_6 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_12 + var_171_6
					end

					if var_171_8.prefab_name ~= "" and arg_168_1.actors_[var_171_8.prefab_name] ~= nil then
						local var_171_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_8.prefab_name].transform, "story_v_out_301061", "301061040", "story_v_out_301061.awb")

						arg_168_1:RecordAudio("301061040", var_171_13)
						arg_168_1:RecordAudio("301061040", var_171_13)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_301061", "301061040", "story_v_out_301061.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_301061", "301061040", "story_v_out_301061.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_14 = math.max(var_171_7, arg_168_1.talkMaxDuration)

			if var_171_6 <= arg_168_1.time_ and arg_168_1.time_ < var_171_6 + var_171_14 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_6) / var_171_14

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_6 + var_171_14 and arg_168_1.time_ < var_171_6 + var_171_14 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_168_1:InitPlayNodeList()
	end,
	Play301061041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 301061041
		arg_172_1.duration_ = 6.07

		local var_172_0 = {
			zh = 6.066,
			ja = 1.333
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play301061042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action1_1")
			end

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_175_0 = 0
			local var_175_1 = 0.6

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_2 = arg_172_1:GetWordFromCfg(301061041)
				local var_175_3 = arg_172_1:FormatText(var_175_2.content)

				arg_172_1.text_.text = var_175_3

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_5 = 24 <= 0 and var_175_1 or var_175_1 * (utf8.len(var_175_3) / 24)

				if (24 <= 0 and var_175_1 or var_175_1 * (utf8.len(var_175_3) / 24)) > 0 and var_175_1 < var_175_5 then
					arg_172_1.talkMaxDuration = var_175_5

					if var_175_5 + var_175_0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_5 + var_175_0
					end
				end

				arg_172_1.text_.text = var_175_3
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301061", "301061041", "story_v_out_301061.awb") ~= 0 then
					local var_175_6 = manager.audio:GetVoiceLength("story_v_out_301061", "301061041", "story_v_out_301061.awb") / 1000

					if var_175_6 + var_175_0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_6 + var_175_0
					end

					if var_175_2.prefab_name ~= "" and arg_172_1.actors_[var_175_2.prefab_name] ~= nil then
						local var_175_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_2.prefab_name].transform, "story_v_out_301061", "301061041", "story_v_out_301061.awb")

						arg_172_1:RecordAudio("301061041", var_175_7)
						arg_172_1:RecordAudio("301061041", var_175_7)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_301061", "301061041", "story_v_out_301061.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_301061", "301061041", "story_v_out_301061.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_8 = math.max(var_175_1, arg_172_1.talkMaxDuration)

			if var_175_0 <= arg_172_1.time_ and arg_172_1.time_ < var_175_0 + var_175_8 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_0) / var_175_8

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_0 + var_175_8 and arg_172_1.time_ < var_175_0 + var_175_8 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play301061042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 301061042
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play301061043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(arg_176_1.actors_["1166ui_story"]) and arg_176_1.var_.characterEffect1166ui_story == nil then
				arg_176_1.var_.characterEffect1166ui_story = arg_176_1.actors_["1166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_0 = 0.200000002980232

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_0 and not isNil(arg_176_1.actors_["1166ui_story"]) then
				if arg_176_1.var_.characterEffect1166ui_story and not isNil(arg_176_1.actors_["1166ui_story"]) then
					arg_176_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_176_1.var_.characterEffect1166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_176_1.time_ - 0) / var_179_0)
				end
			end

			if arg_176_1.time_ >= 0 + var_179_0 and arg_176_1.time_ < 0 + var_179_0 + arg_179_0 and not isNil(arg_176_1.actors_["1166ui_story"]) and arg_176_1.var_.characterEffect1166ui_story then
				arg_176_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_176_1.var_.characterEffect1166ui_story.fillRatio = 0.5
			end

			local var_179_1 = 0
			local var_179_2 = 0.075

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, true)
				arg_176_1.iconController_:SetSelectedState("hero")

				arg_176_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_176_1.callingController_:SetSelectedState("normal")

				arg_176_1.keyicon_.color = Color.New(1, 1, 1)
				arg_176_1.icon_.color = Color.New(1, 1, 1)

				local var_179_3 = arg_176_1:FormatText(arg_176_1:GetWordFromCfg(301061042).content)

				arg_176_1.text_.text = var_179_3

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_5 = 3 <= 0 and var_179_2 or var_179_2 * (utf8.len(var_179_3) / 3)

				if (3 <= 0 and var_179_2 or var_179_2 * (utf8.len(var_179_3) / 3)) > 0 and var_179_2 < var_179_5 then
					arg_176_1.talkMaxDuration = var_179_5

					if var_179_5 + var_179_1 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_5 + var_179_1
					end
				end

				arg_176_1.text_.text = var_179_3
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_6 = math.max(var_179_2, arg_176_1.talkMaxDuration)

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_6 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_1) / var_179_6

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_1 + var_179_6 and arg_176_1.time_ < var_179_1 + var_179_6 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play301061043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 301061043
		arg_180_1.duration_ = 3.57

		local var_180_0 = {
			zh = 3.566,
			ja = 1.999999999999
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play301061044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(arg_180_1.actors_["1166ui_story"]) and arg_180_1.var_.characterEffect1166ui_story == nil then
				arg_180_1.var_.characterEffect1166ui_story = arg_180_1.actors_["1166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_0 = 0.200000002980232

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_0 and not isNil(arg_180_1.actors_["1166ui_story"]) then
				if arg_180_1.var_.characterEffect1166ui_story and not isNil(arg_180_1.actors_["1166ui_story"]) then
					arg_180_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= 0 + var_183_0 and arg_180_1.time_ < 0 + var_183_0 + arg_183_0 and not isNil(arg_180_1.actors_["1166ui_story"]) and arg_180_1.var_.characterEffect1166ui_story then
				arg_180_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action3_1")
			end

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_183_2 = 0
			local var_183_3 = 0.4

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_2 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_4 = arg_180_1:GetWordFromCfg(301061043)
				local var_183_5 = arg_180_1:FormatText(var_183_4.content)

				arg_180_1.text_.text = var_183_5

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_7 = 16 <= 0 and var_183_3 or var_183_3 * (utf8.len(var_183_5) / 16)

				if (16 <= 0 and var_183_3 or var_183_3 * (utf8.len(var_183_5) / 16)) > 0 and var_183_3 < var_183_7 then
					arg_180_1.talkMaxDuration = var_183_7

					if var_183_7 + var_183_2 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_7 + var_183_2
					end
				end

				arg_180_1.text_.text = var_183_5
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301061", "301061043", "story_v_out_301061.awb") ~= 0 then
					local var_183_8 = manager.audio:GetVoiceLength("story_v_out_301061", "301061043", "story_v_out_301061.awb") / 1000

					if var_183_8 + var_183_2 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_8 + var_183_2
					end

					if var_183_4.prefab_name ~= "" and arg_180_1.actors_[var_183_4.prefab_name] ~= nil then
						local var_183_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_4.prefab_name].transform, "story_v_out_301061", "301061043", "story_v_out_301061.awb")

						arg_180_1:RecordAudio("301061043", var_183_9)
						arg_180_1:RecordAudio("301061043", var_183_9)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_301061", "301061043", "story_v_out_301061.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_301061", "301061043", "story_v_out_301061.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_10 = math.max(var_183_3, arg_180_1.talkMaxDuration)

			if var_183_2 <= arg_180_1.time_ and arg_180_1.time_ < var_183_2 + var_183_10 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_2) / var_183_10

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_2 + var_183_10 and arg_180_1.time_ < var_183_2 + var_183_10 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play301061044 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 301061044
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play301061045(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(arg_184_1.actors_["1166ui_story"]) and arg_184_1.var_.characterEffect1166ui_story == nil then
				arg_184_1.var_.characterEffect1166ui_story = arg_184_1.actors_["1166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_0 = 0.200000002980232

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 and not isNil(arg_184_1.actors_["1166ui_story"]) then
				if arg_184_1.var_.characterEffect1166ui_story and not isNil(arg_184_1.actors_["1166ui_story"]) then
					arg_184_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_184_1.var_.characterEffect1166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_184_1.time_ - 0) / var_187_0)
				end
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 and not isNil(arg_184_1.actors_["1166ui_story"]) and arg_184_1.var_.characterEffect1166ui_story then
				arg_184_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_184_1.var_.characterEffect1166ui_story.fillRatio = 0.5
			end

			local var_187_1 = 0
			local var_187_2 = 0.475

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, true)
				arg_184_1.iconController_:SetSelectedState("hero")

				arg_184_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_184_1.callingController_:SetSelectedState("normal")

				arg_184_1.keyicon_.color = Color.New(1, 1, 1)
				arg_184_1.icon_.color = Color.New(1, 1, 1)

				local var_187_3 = arg_184_1:FormatText(arg_184_1:GetWordFromCfg(301061044).content)

				arg_184_1.text_.text = var_187_3

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_5 = 19 <= 0 and var_187_2 or var_187_2 * (utf8.len(var_187_3) / 19)

				if (19 <= 0 and var_187_2 or var_187_2 * (utf8.len(var_187_3) / 19)) > 0 and var_187_2 < var_187_5 then
					arg_184_1.talkMaxDuration = var_187_5

					if var_187_5 + var_187_1 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_5 + var_187_1
					end
				end

				arg_184_1.text_.text = var_187_3
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_6 = math.max(var_187_2, arg_184_1.talkMaxDuration)

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_6 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_1) / var_187_6

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_1 + var_187_6 and arg_184_1.time_ < var_187_1 + var_187_6 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play301061045 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 301061045
		arg_188_1.duration_ = 2

		local var_188_0 = {
			zh = 2,
			ja = 1.999999999999
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play301061046(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(arg_188_1.actors_["1166ui_story"]) and arg_188_1.var_.characterEffect1166ui_story == nil then
				arg_188_1.var_.characterEffect1166ui_story = arg_188_1.actors_["1166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_0 = 0.200000002980232

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_0 and not isNil(arg_188_1.actors_["1166ui_story"]) then
				if arg_188_1.var_.characterEffect1166ui_story and not isNil(arg_188_1.actors_["1166ui_story"]) then
					arg_188_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= 0 + var_191_0 and arg_188_1.time_ < 0 + var_191_0 + arg_191_0 and not isNil(arg_188_1.actors_["1166ui_story"]) and arg_188_1.var_.characterEffect1166ui_story then
				arg_188_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_191_2 = 0
			local var_191_3 = 0.225

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_2 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_4 = arg_188_1:GetWordFromCfg(301061045)
				local var_191_5 = arg_188_1:FormatText(var_191_4.content)

				arg_188_1.text_.text = var_191_5

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_7 = 9 <= 0 and var_191_3 or var_191_3 * (utf8.len(var_191_5) / 9)

				if (9 <= 0 and var_191_3 or var_191_3 * (utf8.len(var_191_5) / 9)) > 0 and var_191_3 < var_191_7 then
					arg_188_1.talkMaxDuration = var_191_7

					if var_191_7 + var_191_2 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_7 + var_191_2
					end
				end

				arg_188_1.text_.text = var_191_5
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301061", "301061045", "story_v_out_301061.awb") ~= 0 then
					local var_191_8 = manager.audio:GetVoiceLength("story_v_out_301061", "301061045", "story_v_out_301061.awb") / 1000

					if var_191_8 + var_191_2 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_8 + var_191_2
					end

					if var_191_4.prefab_name ~= "" and arg_188_1.actors_[var_191_4.prefab_name] ~= nil then
						local var_191_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_4.prefab_name].transform, "story_v_out_301061", "301061045", "story_v_out_301061.awb")

						arg_188_1:RecordAudio("301061045", var_191_9)
						arg_188_1:RecordAudio("301061045", var_191_9)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_301061", "301061045", "story_v_out_301061.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_301061", "301061045", "story_v_out_301061.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_10 = math.max(var_191_3, arg_188_1.talkMaxDuration)

			if var_191_2 <= arg_188_1.time_ and arg_188_1.time_ < var_191_2 + var_191_10 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_2) / var_191_10

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_2 + var_191_10 and arg_188_1.time_ < var_191_2 + var_191_10 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play301061046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 301061046
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play301061047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(arg_192_1.actors_["1166ui_story"]) and arg_192_1.var_.characterEffect1166ui_story == nil then
				arg_192_1.var_.characterEffect1166ui_story = arg_192_1.actors_["1166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_0 = 0.200000002980232

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_0 and not isNil(arg_192_1.actors_["1166ui_story"]) then
				if arg_192_1.var_.characterEffect1166ui_story and not isNil(arg_192_1.actors_["1166ui_story"]) then
					arg_192_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_192_1.var_.characterEffect1166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_192_1.time_ - 0) / var_195_0)
				end
			end

			if arg_192_1.time_ >= 0 + var_195_0 and arg_192_1.time_ < 0 + var_195_0 + arg_195_0 and not isNil(arg_192_1.actors_["1166ui_story"]) and arg_192_1.var_.characterEffect1166ui_story then
				arg_192_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_192_1.var_.characterEffect1166ui_story.fillRatio = 0.5
			end

			local var_195_1 = 0
			local var_195_2 = 0.425

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, true)
				arg_192_1.iconController_:SetSelectedState("hero")

				arg_192_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_192_1.callingController_:SetSelectedState("normal")

				arg_192_1.keyicon_.color = Color.New(1, 1, 1)
				arg_192_1.icon_.color = Color.New(1, 1, 1)

				local var_195_3 = arg_192_1:FormatText(arg_192_1:GetWordFromCfg(301061046).content)

				arg_192_1.text_.text = var_195_3

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_5 = 17 <= 0 and var_195_2 or var_195_2 * (utf8.len(var_195_3) / 17)

				if (17 <= 0 and var_195_2 or var_195_2 * (utf8.len(var_195_3) / 17)) > 0 and var_195_2 < var_195_5 then
					arg_192_1.talkMaxDuration = var_195_5

					if var_195_5 + var_195_1 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_5 + var_195_1
					end
				end

				arg_192_1.text_.text = var_195_3
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_6 = math.max(var_195_2, arg_192_1.talkMaxDuration)

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_6 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_1) / var_195_6

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_1 + var_195_6 and arg_192_1.time_ < var_195_1 + var_195_6 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play301061047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 301061047
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play301061048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.var_.moveOldPos1166ui_story = arg_196_1.actors_["1166ui_story"].transform.localPosition

				local var_199_0 = GameObjectTools.GetOrAddComponent(arg_196_1.actors_["1166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_199_0 then
					var_199_0:EnableDynamicBone(false)
				end
			end

			local var_199_1 = 0.001

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_1 then
				arg_196_1.actors_["1166ui_story"].transform.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1166ui_story, Vector3.New(0, 100, 0), (arg_196_1.time_ - 0) / var_199_1)
				arg_196_1.actors_["1166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_196_1.actors_["1166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["1166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["1166ui_story"].transform.position).z)
				arg_196_1.actors_["1166ui_story"].transform.localEulerAngles.z = 0
				arg_196_1.actors_["1166ui_story"].transform.localEulerAngles.x = 0
				arg_196_1.actors_["1166ui_story"].transform.localEulerAngles = arg_196_1.actors_["1166ui_story"].transform.localEulerAngles
			end

			if arg_196_1.time_ >= 0 + var_199_1 and arg_196_1.time_ < 0 + var_199_1 + arg_199_0 then
				arg_196_1.actors_["1166ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_196_1.actors_["1166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_196_1.actors_["1166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["1166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["1166ui_story"].transform.position).z)
				arg_196_1.actors_["1166ui_story"].transform.localEulerAngles.z = 0
				arg_196_1.actors_["1166ui_story"].transform.localEulerAngles.x = 0
				arg_196_1.actors_["1166ui_story"].transform.localEulerAngles = arg_196_1.actors_["1166ui_story"].transform.localEulerAngles

				local var_199_2 = GameObjectTools.GetOrAddComponent(arg_196_1.actors_["1166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_199_2 then
					var_199_2:EnableDynamicBone(true)
				end
			end

			local var_199_3 = 0
			local var_199_4 = 0.825

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_3 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, false)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_5 = arg_196_1:FormatText(arg_196_1:GetWordFromCfg(301061047).content)

				arg_196_1.text_.text = var_199_5

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_7 = 33 <= 0 and var_199_4 or var_199_4 * (utf8.len(var_199_5) / 33)

				if (33 <= 0 and var_199_4 or var_199_4 * (utf8.len(var_199_5) / 33)) > 0 and var_199_4 < var_199_7 then
					arg_196_1.talkMaxDuration = var_199_7

					if var_199_7 + var_199_3 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_7 + var_199_3
					end
				end

				arg_196_1.text_.text = var_199_5
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_8 = math.max(var_199_4, arg_196_1.talkMaxDuration)

			if var_199_3 <= arg_196_1.time_ and arg_196_1.time_ < var_199_3 + var_199_8 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_3) / var_199_8

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_3 + var_199_8 and arg_196_1.time_ < var_199_3 + var_199_8 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play301061048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 301061048
		arg_200_1.duration_ = 6.6

		local var_200_0 = {
			zh = 6.6,
			ja = 1.999999999999
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play301061049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.var_.moveOldPos1166ui_story = arg_200_1.actors_["1166ui_story"].transform.localPosition

				local var_203_0 = GameObjectTools.GetOrAddComponent(arg_200_1.actors_["1166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_203_0 then
					var_203_0:EnableDynamicBone(false)
				end
			end

			local var_203_1 = 0.001

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_1 then
				arg_200_1.actors_["1166ui_story"].transform.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1166ui_story, Vector3.New(0, -0.75, -6.25), (arg_200_1.time_ - 0) / var_203_1)
				arg_200_1.actors_["1166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_200_1.actors_["1166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_200_1.actors_["1166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_200_1.actors_["1166ui_story"].transform.position).z)
				arg_200_1.actors_["1166ui_story"].transform.localEulerAngles.z = 0
				arg_200_1.actors_["1166ui_story"].transform.localEulerAngles.x = 0
				arg_200_1.actors_["1166ui_story"].transform.localEulerAngles = arg_200_1.actors_["1166ui_story"].transform.localEulerAngles
			end

			if arg_200_1.time_ >= 0 + var_203_1 and arg_200_1.time_ < 0 + var_203_1 + arg_203_0 then
				arg_200_1.actors_["1166ui_story"].transform.localPosition = Vector3.New(0, -0.75, -6.25)
				arg_200_1.actors_["1166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_200_1.actors_["1166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_200_1.actors_["1166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_200_1.actors_["1166ui_story"].transform.position).z)
				arg_200_1.actors_["1166ui_story"].transform.localEulerAngles.z = 0
				arg_200_1.actors_["1166ui_story"].transform.localEulerAngles.x = 0
				arg_200_1.actors_["1166ui_story"].transform.localEulerAngles = arg_200_1.actors_["1166ui_story"].transform.localEulerAngles

				local var_203_2 = GameObjectTools.GetOrAddComponent(arg_200_1.actors_["1166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_203_2 then
					var_203_2:EnableDynamicBone(true)
				end
			end

			local var_203_3 = arg_200_1.actors_["1166ui_story"]

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(var_203_3) and arg_200_1.var_.characterEffect1166ui_story == nil then
				arg_200_1.var_.characterEffect1166ui_story = var_203_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_4 = 0.200000002980232

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_4 and not isNil(var_203_3) then
				if arg_200_1.var_.characterEffect1166ui_story and not isNil(var_203_3) then
					arg_200_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_200_1.time_ >= 0 + var_203_4 and arg_200_1.time_ < 0 + var_203_4 + arg_203_0 and not isNil(var_203_3) and arg_200_1.var_.characterEffect1166ui_story then
				arg_200_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action3_2")
			end

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_203_6 = 0
			local var_203_7 = 0.6

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_6 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_8 = arg_200_1:GetWordFromCfg(301061048)
				local var_203_9 = arg_200_1:FormatText(var_203_8.content)

				arg_200_1.text_.text = var_203_9

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_11 = 24 <= 0 and var_203_7 or var_203_7 * (utf8.len(var_203_9) / 24)

				if (24 <= 0 and var_203_7 or var_203_7 * (utf8.len(var_203_9) / 24)) > 0 and var_203_7 < var_203_11 then
					arg_200_1.talkMaxDuration = var_203_11

					if var_203_11 + var_203_6 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_11 + var_203_6
					end
				end

				arg_200_1.text_.text = var_203_9
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301061", "301061048", "story_v_out_301061.awb") ~= 0 then
					local var_203_12 = manager.audio:GetVoiceLength("story_v_out_301061", "301061048", "story_v_out_301061.awb") / 1000

					if var_203_12 + var_203_6 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_12 + var_203_6
					end

					if var_203_8.prefab_name ~= "" and arg_200_1.actors_[var_203_8.prefab_name] ~= nil then
						local var_203_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_8.prefab_name].transform, "story_v_out_301061", "301061048", "story_v_out_301061.awb")

						arg_200_1:RecordAudio("301061048", var_203_13)
						arg_200_1:RecordAudio("301061048", var_203_13)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_301061", "301061048", "story_v_out_301061.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_301061", "301061048", "story_v_out_301061.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_14 = math.max(var_203_7, arg_200_1.talkMaxDuration)

			if var_203_6 <= arg_200_1.time_ and arg_200_1.time_ < var_203_6 + var_203_14 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_6) / var_203_14

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_6 + var_203_14 and arg_200_1.time_ < var_203_6 + var_203_14 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_200_1:InitPlayNodeList()
	end,
	Play301061049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 301061049
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play301061050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(arg_204_1.actors_["1166ui_story"]) and arg_204_1.var_.characterEffect1166ui_story == nil then
				arg_204_1.var_.characterEffect1166ui_story = arg_204_1.actors_["1166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_0 = 0.200000002980232

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_0 and not isNil(arg_204_1.actors_["1166ui_story"]) then
				if arg_204_1.var_.characterEffect1166ui_story and not isNil(arg_204_1.actors_["1166ui_story"]) then
					arg_204_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_204_1.var_.characterEffect1166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_204_1.time_ - 0) / var_207_0)
				end
			end

			if arg_204_1.time_ >= 0 + var_207_0 and arg_204_1.time_ < 0 + var_207_0 + arg_207_0 and not isNil(arg_204_1.actors_["1166ui_story"]) and arg_204_1.var_.characterEffect1166ui_story then
				arg_204_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_204_1.var_.characterEffect1166ui_story.fillRatio = 0.5
			end

			local var_207_1 = 0
			local var_207_2 = 0.375

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, true)
				arg_204_1.iconController_:SetSelectedState("hero")

				arg_204_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_204_1.callingController_:SetSelectedState("normal")

				arg_204_1.keyicon_.color = Color.New(1, 1, 1)
				arg_204_1.icon_.color = Color.New(1, 1, 1)

				local var_207_3 = arg_204_1:FormatText(arg_204_1:GetWordFromCfg(301061049).content)

				arg_204_1.text_.text = var_207_3

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_5 = 15 <= 0 and var_207_2 or var_207_2 * (utf8.len(var_207_3) / 15)

				if (15 <= 0 and var_207_2 or var_207_2 * (utf8.len(var_207_3) / 15)) > 0 and var_207_2 < var_207_5 then
					arg_204_1.talkMaxDuration = var_207_5

					if var_207_5 + var_207_1 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_5 + var_207_1
					end
				end

				arg_204_1.text_.text = var_207_3
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_6 = math.max(var_207_2, arg_204_1.talkMaxDuration)

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_6 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_1) / var_207_6

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_1 + var_207_6 and arg_204_1.time_ < var_207_1 + var_207_6 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play301061050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 301061050
		arg_208_1.duration_ = 2

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play301061051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(arg_208_1.actors_["1166ui_story"]) and arg_208_1.var_.characterEffect1166ui_story == nil then
				arg_208_1.var_.characterEffect1166ui_story = arg_208_1.actors_["1166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_0 = 0.200000002980232

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_0 and not isNil(arg_208_1.actors_["1166ui_story"]) then
				if arg_208_1.var_.characterEffect1166ui_story and not isNil(arg_208_1.actors_["1166ui_story"]) then
					arg_208_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_208_1.time_ >= 0 + var_211_0 and arg_208_1.time_ < 0 + var_211_0 + arg_211_0 and not isNil(arg_208_1.actors_["1166ui_story"]) and arg_208_1.var_.characterEffect1166ui_story then
				arg_208_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action1_1")
			end

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_211_2 = 0
			local var_211_3 = 0.075

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_2 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_4 = arg_208_1:GetWordFromCfg(301061050)
				local var_211_5 = arg_208_1:FormatText(var_211_4.content)

				arg_208_1.text_.text = var_211_5

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_7 = 3 <= 0 and var_211_3 or var_211_3 * (utf8.len(var_211_5) / 3)

				if (3 <= 0 and var_211_3 or var_211_3 * (utf8.len(var_211_5) / 3)) > 0 and var_211_3 < var_211_7 then
					arg_208_1.talkMaxDuration = var_211_7

					if var_211_7 + var_211_2 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_7 + var_211_2
					end
				end

				arg_208_1.text_.text = var_211_5
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301061", "301061050", "story_v_out_301061.awb") ~= 0 then
					local var_211_8 = manager.audio:GetVoiceLength("story_v_out_301061", "301061050", "story_v_out_301061.awb") / 1000

					if var_211_8 + var_211_2 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_8 + var_211_2
					end

					if var_211_4.prefab_name ~= "" and arg_208_1.actors_[var_211_4.prefab_name] ~= nil then
						local var_211_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_4.prefab_name].transform, "story_v_out_301061", "301061050", "story_v_out_301061.awb")

						arg_208_1:RecordAudio("301061050", var_211_9)
						arg_208_1:RecordAudio("301061050", var_211_9)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_301061", "301061050", "story_v_out_301061.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_301061", "301061050", "story_v_out_301061.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_10 = math.max(var_211_3, arg_208_1.talkMaxDuration)

			if var_211_2 <= arg_208_1.time_ and arg_208_1.time_ < var_211_2 + var_211_10 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_2) / var_211_10

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_2 + var_211_10 and arg_208_1.time_ < var_211_2 + var_211_10 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play301061051 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 301061051
		arg_212_1.duration_ = 5

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play301061052(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(arg_212_1.actors_["1166ui_story"]) and arg_212_1.var_.characterEffect1166ui_story == nil then
				arg_212_1.var_.characterEffect1166ui_story = arg_212_1.actors_["1166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_0 = 0.200000002980232

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_0 and not isNil(arg_212_1.actors_["1166ui_story"]) then
				if arg_212_1.var_.characterEffect1166ui_story and not isNil(arg_212_1.actors_["1166ui_story"]) then
					arg_212_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_212_1.var_.characterEffect1166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_212_1.time_ - 0) / var_215_0)
				end
			end

			if arg_212_1.time_ >= 0 + var_215_0 and arg_212_1.time_ < 0 + var_215_0 + arg_215_0 and not isNil(arg_212_1.actors_["1166ui_story"]) and arg_212_1.var_.characterEffect1166ui_story then
				arg_212_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_212_1.var_.characterEffect1166ui_story.fillRatio = 0.5
			end

			local var_215_1 = 0
			local var_215_2 = 0.6

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, true)
				arg_212_1.iconController_:SetSelectedState("hero")

				arg_212_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_212_1.callingController_:SetSelectedState("normal")

				arg_212_1.keyicon_.color = Color.New(1, 1, 1)
				arg_212_1.icon_.color = Color.New(1, 1, 1)

				local var_215_3 = arg_212_1:FormatText(arg_212_1:GetWordFromCfg(301061051).content)

				arg_212_1.text_.text = var_215_3

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_5 = 24 <= 0 and var_215_2 or var_215_2 * (utf8.len(var_215_3) / 24)

				if (24 <= 0 and var_215_2 or var_215_2 * (utf8.len(var_215_3) / 24)) > 0 and var_215_2 < var_215_5 then
					arg_212_1.talkMaxDuration = var_215_5

					if var_215_5 + var_215_1 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_5 + var_215_1
					end
				end

				arg_212_1.text_.text = var_215_3
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)
				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_6 = math.max(var_215_2, arg_212_1.talkMaxDuration)

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_6 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_1) / var_215_6

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_1 + var_215_6 and arg_212_1.time_ < var_215_1 + var_215_6 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play301061052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 301061052
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play301061053(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = 0.575

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, true)
				arg_216_1.iconController_:SetSelectedState("hero")

				arg_216_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_216_1.callingController_:SetSelectedState("normal")

				arg_216_1.keyicon_.color = Color.New(1, 1, 1)
				arg_216_1.icon_.color = Color.New(1, 1, 1)

				local var_219_1 = arg_216_1:FormatText(arg_216_1:GetWordFromCfg(301061052).content)

				arg_216_1.text_.text = var_219_1

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_3 = 23 <= 0 and var_219_0 or var_219_0 * (utf8.len(var_219_1) / 23)

				if (23 <= 0 and var_219_0 or var_219_0 * (utf8.len(var_219_1) / 23)) > 0 and var_219_0 < var_219_3 then
					arg_216_1.talkMaxDuration = var_219_3

					if var_219_3 + 0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_3 + 0
					end
				end

				arg_216_1.text_.text = var_219_1
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_4 = math.max(var_219_0, arg_216_1.talkMaxDuration)

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_4 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - 0) / var_219_4

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= 0 + var_219_4 and arg_216_1.time_ < 0 + var_219_4 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play301061053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 301061053
		arg_220_1.duration_ = 2

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play301061054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(arg_220_1.actors_["1166ui_story"]) and arg_220_1.var_.characterEffect1166ui_story == nil then
				arg_220_1.var_.characterEffect1166ui_story = arg_220_1.actors_["1166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_0 = 0.200000002980232

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_0 and not isNil(arg_220_1.actors_["1166ui_story"]) then
				if arg_220_1.var_.characterEffect1166ui_story and not isNil(arg_220_1.actors_["1166ui_story"]) then
					arg_220_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= 0 + var_223_0 and arg_220_1.time_ < 0 + var_223_0 + arg_223_0 and not isNil(arg_220_1.actors_["1166ui_story"]) and arg_220_1.var_.characterEffect1166ui_story then
				arg_220_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action8_1")
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganD", "EmotionTimelineAnimator")
			end

			local var_223_2 = 0
			local var_223_3 = 0.175

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_2 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_4 = arg_220_1:GetWordFromCfg(301061053)
				local var_223_5 = arg_220_1:FormatText(var_223_4.content)

				arg_220_1.text_.text = var_223_5

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_7 = 7 <= 0 and var_223_3 or var_223_3 * (utf8.len(var_223_5) / 7)

				if (7 <= 0 and var_223_3 or var_223_3 * (utf8.len(var_223_5) / 7)) > 0 and var_223_3 < var_223_7 then
					arg_220_1.talkMaxDuration = var_223_7

					if var_223_7 + var_223_2 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_7 + var_223_2
					end
				end

				arg_220_1.text_.text = var_223_5
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301061", "301061053", "story_v_out_301061.awb") ~= 0 then
					local var_223_8 = manager.audio:GetVoiceLength("story_v_out_301061", "301061053", "story_v_out_301061.awb") / 1000

					if var_223_8 + var_223_2 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_8 + var_223_2
					end

					if var_223_4.prefab_name ~= "" and arg_220_1.actors_[var_223_4.prefab_name] ~= nil then
						local var_223_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_4.prefab_name].transform, "story_v_out_301061", "301061053", "story_v_out_301061.awb")

						arg_220_1:RecordAudio("301061053", var_223_9)
						arg_220_1:RecordAudio("301061053", var_223_9)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_301061", "301061053", "story_v_out_301061.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_301061", "301061053", "story_v_out_301061.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_10 = math.max(var_223_3, arg_220_1.talkMaxDuration)

			if var_223_2 <= arg_220_1.time_ and arg_220_1.time_ < var_223_2 + var_223_10 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_2) / var_223_10

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_2 + var_223_10 and arg_220_1.time_ < var_223_2 + var_223_10 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play301061054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 301061054
		arg_224_1.duration_ = 7.13

		local var_224_0 = {
			zh = 7.133,
			ja = 1.999999999999
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play301061055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action8_2")
			end

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_227_0 = 0
			local var_227_1 = 0.85

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_0 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_2 = arg_224_1:GetWordFromCfg(301061054)
				local var_227_3 = arg_224_1:FormatText(var_227_2.content)

				arg_224_1.text_.text = var_227_3

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_5 = 34 <= 0 and var_227_1 or var_227_1 * (utf8.len(var_227_3) / 34)

				if (34 <= 0 and var_227_1 or var_227_1 * (utf8.len(var_227_3) / 34)) > 0 and var_227_1 < var_227_5 then
					arg_224_1.talkMaxDuration = var_227_5

					if var_227_5 + var_227_0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_5 + var_227_0
					end
				end

				arg_224_1.text_.text = var_227_3
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301061", "301061054", "story_v_out_301061.awb") ~= 0 then
					local var_227_6 = manager.audio:GetVoiceLength("story_v_out_301061", "301061054", "story_v_out_301061.awb") / 1000

					if var_227_6 + var_227_0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_6 + var_227_0
					end

					if var_227_2.prefab_name ~= "" and arg_224_1.actors_[var_227_2.prefab_name] ~= nil then
						local var_227_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_2.prefab_name].transform, "story_v_out_301061", "301061054", "story_v_out_301061.awb")

						arg_224_1:RecordAudio("301061054", var_227_7)
						arg_224_1:RecordAudio("301061054", var_227_7)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_301061", "301061054", "story_v_out_301061.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_301061", "301061054", "story_v_out_301061.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_8 = math.max(var_227_1, arg_224_1.talkMaxDuration)

			if var_227_0 <= arg_224_1.time_ and arg_224_1.time_ < var_227_0 + var_227_8 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_0) / var_227_8

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_0 + var_227_8 and arg_224_1.time_ < var_227_0 + var_227_8 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play301061055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 301061055
		arg_228_1.duration_ = 1

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"

			SetActive(arg_228_1.choicesGo_, true)

			for iter_229_0, iter_229_1 in ipairs(arg_228_1.choices_) do
				SetActive(iter_229_1.go, iter_229_0 <= 2)
			end

			arg_228_1.choices_[1].txt.text = arg_228_1:FormatText(StoryChoiceCfg[1728].name)
			arg_228_1.choices_[2].txt.text = arg_228_1:FormatText(StoryChoiceCfg[1729].name)
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play301061056(arg_228_1)
			end

			if arg_230_0 == 2 then
				arg_228_0:Play301061056(arg_228_1)
			end

			arg_228_1:RecordChoiceLog(301061055, 1728, 1729)
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(arg_228_1.actors_["1166ui_story"]) and arg_228_1.var_.characterEffect1166ui_story == nil then
				arg_228_1.var_.characterEffect1166ui_story = arg_228_1.actors_["1166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_0 = 0.200000002980232

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_0 and not isNil(arg_228_1.actors_["1166ui_story"]) then
				if arg_228_1.var_.characterEffect1166ui_story and not isNil(arg_228_1.actors_["1166ui_story"]) then
					arg_228_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_228_1.var_.characterEffect1166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_228_1.time_ - 0) / var_231_0)
				end
			end

			if arg_228_1.time_ >= 0 + var_231_0 and arg_228_1.time_ < 0 + var_231_0 + arg_231_0 and not isNil(arg_228_1.actors_["1166ui_story"]) and arg_228_1.var_.characterEffect1166ui_story then
				arg_228_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_228_1.var_.characterEffect1166ui_story.fillRatio = 0.5
			end

			local var_231_1 = 0

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 then
				arg_228_1.allBtn_.enabled = false
			end

			if arg_228_1.time_ >= var_231_1 + 0.566666666666667 and arg_228_1.time_ < var_231_1 + 0.566666666666667 + arg_231_0 then
				arg_228_1.allBtn_.enabled = true
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play301061056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 301061056
		arg_232_1.duration_ = 3.37

		local var_232_0 = {
			zh = 3.366,
			ja = 1.999999999999
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play301061057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(arg_232_1.actors_["1166ui_story"]) and arg_232_1.var_.characterEffect1166ui_story == nil then
				arg_232_1.var_.characterEffect1166ui_story = arg_232_1.actors_["1166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_0 = 0.200000002980232

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_0 and not isNil(arg_232_1.actors_["1166ui_story"]) then
				if arg_232_1.var_.characterEffect1166ui_story and not isNil(arg_232_1.actors_["1166ui_story"]) then
					arg_232_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_232_1.time_ >= 0 + var_235_0 and arg_232_1.time_ < 0 + var_235_0 + arg_235_0 and not isNil(arg_232_1.actors_["1166ui_story"]) and arg_232_1.var_.characterEffect1166ui_story then
				arg_232_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_235_2 = "1166ui_story"

			if arg_232_1.actors_["1166ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1166ui_story"))) then
				local var_235_3 = Object.Instantiate(Asset.Load("Char/" .. "1166ui_story"), arg_232_1.stage_.transform)

				var_235_3.name = var_235_2
				var_235_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_232_1.actors_[var_235_2] = var_235_3

				local var_235_4 = var_235_3:GetComponentInChildren(typeof(CharacterEffect))

				var_235_4.enabled = true

				local var_235_5 = GameObjectTools.GetOrAddComponent(var_235_3, typeof(DynamicBoneHelper))

				if var_235_5 then
					var_235_5:EnableDynamicBone(false)
				end

				arg_232_1:ShowWeapon(var_235_4.transform, false)

				arg_232_1.var_[var_235_2 .. "Animator"] = var_235_4.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_232_1.var_[var_235_2 .. "Animator"].applyRootMotion = true
				arg_232_1.var_[var_235_2 .. "LipSync"] = var_235_4.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action2_1")
			end

			local var_235_6 = "1166ui_story"

			if arg_232_1.actors_["1166ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1166ui_story"))) then
				local var_235_7 = Object.Instantiate(Asset.Load("Char/" .. "1166ui_story"), arg_232_1.stage_.transform)

				var_235_7.name = var_235_6
				var_235_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_232_1.actors_[var_235_6] = var_235_7

				local var_235_8 = var_235_7:GetComponentInChildren(typeof(CharacterEffect))

				var_235_8.enabled = true

				local var_235_9 = GameObjectTools.GetOrAddComponent(var_235_7, typeof(DynamicBoneHelper))

				if var_235_9 then
					var_235_9:EnableDynamicBone(false)
				end

				arg_232_1:ShowWeapon(var_235_8.transform, false)

				arg_232_1.var_[var_235_6 .. "Animator"] = var_235_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_232_1.var_[var_235_6 .. "Animator"].applyRootMotion = true
				arg_232_1.var_[var_235_6 .. "LipSync"] = var_235_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_235_10 = 0
			local var_235_11 = 0.425

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_10 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_12 = arg_232_1:GetWordFromCfg(301061056)
				local var_235_13 = arg_232_1:FormatText(var_235_12.content)

				arg_232_1.text_.text = var_235_13

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_15 = 17 <= 0 and var_235_11 or var_235_11 * (utf8.len(var_235_13) / 17)

				if (17 <= 0 and var_235_11 or var_235_11 * (utf8.len(var_235_13) / 17)) > 0 and var_235_11 < var_235_15 then
					arg_232_1.talkMaxDuration = var_235_15

					if var_235_15 + var_235_10 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_15 + var_235_10
					end
				end

				arg_232_1.text_.text = var_235_13
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301061", "301061056", "story_v_out_301061.awb") ~= 0 then
					local var_235_16 = manager.audio:GetVoiceLength("story_v_out_301061", "301061056", "story_v_out_301061.awb") / 1000

					if var_235_16 + var_235_10 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_16 + var_235_10
					end

					if var_235_12.prefab_name ~= "" and arg_232_1.actors_[var_235_12.prefab_name] ~= nil then
						local var_235_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_12.prefab_name].transform, "story_v_out_301061", "301061056", "story_v_out_301061.awb")

						arg_232_1:RecordAudio("301061056", var_235_17)
						arg_232_1:RecordAudio("301061056", var_235_17)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_301061", "301061056", "story_v_out_301061.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_301061", "301061056", "story_v_out_301061.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_18 = math.max(var_235_11, arg_232_1.talkMaxDuration)

			if var_235_10 <= arg_232_1.time_ and arg_232_1.time_ < var_235_10 + var_235_18 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_10) / var_235_18

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_10 + var_235_18 and arg_232_1.time_ < var_235_10 + var_235_18 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play301061057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 301061057
		arg_236_1.duration_ = 6.5

		local var_236_0 = {
			zh = 6.5,
			ja = 1.333
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
				arg_236_0:Play301061058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 0.7

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_1 = arg_236_1:GetWordFromCfg(301061057)
				local var_239_2 = arg_236_1:FormatText(var_239_1.content)

				arg_236_1.text_.text = var_239_2

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_4 = 28 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_2) / 28)

				if (28 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_2) / 28)) > 0 and var_239_0 < var_239_4 then
					arg_236_1.talkMaxDuration = var_239_4

					if var_239_4 + 0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_4 + 0
					end
				end

				arg_236_1.text_.text = var_239_2
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301061", "301061057", "story_v_out_301061.awb") ~= 0 then
					local var_239_5 = manager.audio:GetVoiceLength("story_v_out_301061", "301061057", "story_v_out_301061.awb") / 1000

					if var_239_5 + 0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_5 + 0
					end

					if var_239_1.prefab_name ~= "" and arg_236_1.actors_[var_239_1.prefab_name] ~= nil then
						local var_239_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_1.prefab_name].transform, "story_v_out_301061", "301061057", "story_v_out_301061.awb")

						arg_236_1:RecordAudio("301061057", var_239_6)
						arg_236_1:RecordAudio("301061057", var_239_6)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_301061", "301061057", "story_v_out_301061.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_301061", "301061057", "story_v_out_301061.awb")
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
	Play301061058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 301061058
		arg_240_1.duration_ = 2.4

		local var_240_0 = {
			zh = 2.4,
			ja = 1.999999999999
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play301061059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action2_2")
			end

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_243_0 = 0
			local var_243_1 = 0.275

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_2 = arg_240_1:GetWordFromCfg(301061058)
				local var_243_3 = arg_240_1:FormatText(var_243_2.content)

				arg_240_1.text_.text = var_243_3

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_5 = 11 <= 0 and var_243_1 or var_243_1 * (utf8.len(var_243_3) / 11)

				if (11 <= 0 and var_243_1 or var_243_1 * (utf8.len(var_243_3) / 11)) > 0 and var_243_1 < var_243_5 then
					arg_240_1.talkMaxDuration = var_243_5

					if var_243_5 + var_243_0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_5 + var_243_0
					end
				end

				arg_240_1.text_.text = var_243_3
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301061", "301061058", "story_v_out_301061.awb") ~= 0 then
					local var_243_6 = manager.audio:GetVoiceLength("story_v_out_301061", "301061058", "story_v_out_301061.awb") / 1000

					if var_243_6 + var_243_0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_6 + var_243_0
					end

					if var_243_2.prefab_name ~= "" and arg_240_1.actors_[var_243_2.prefab_name] ~= nil then
						local var_243_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_2.prefab_name].transform, "story_v_out_301061", "301061058", "story_v_out_301061.awb")

						arg_240_1:RecordAudio("301061058", var_243_7)
						arg_240_1:RecordAudio("301061058", var_243_7)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_301061", "301061058", "story_v_out_301061.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_301061", "301061058", "story_v_out_301061.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_8 = math.max(var_243_1, arg_240_1.talkMaxDuration)

			if var_243_0 <= arg_240_1.time_ and arg_240_1.time_ < var_243_0 + var_243_8 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_0) / var_243_8

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_0 + var_243_8 and arg_240_1.time_ < var_243_0 + var_243_8 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play301061059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 301061059
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play301061060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(arg_244_1.actors_["1166ui_story"]) and arg_244_1.var_.characterEffect1166ui_story == nil then
				arg_244_1.var_.characterEffect1166ui_story = arg_244_1.actors_["1166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_0 = 0.200000002980232

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_0 and not isNil(arg_244_1.actors_["1166ui_story"]) then
				if arg_244_1.var_.characterEffect1166ui_story and not isNil(arg_244_1.actors_["1166ui_story"]) then
					arg_244_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_244_1.var_.characterEffect1166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_244_1.time_ - 0) / var_247_0)
				end
			end

			if arg_244_1.time_ >= 0 + var_247_0 and arg_244_1.time_ < 0 + var_247_0 + arg_247_0 and not isNil(arg_244_1.actors_["1166ui_story"]) and arg_244_1.var_.characterEffect1166ui_story then
				arg_244_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_244_1.var_.characterEffect1166ui_story.fillRatio = 0.5
			end

			local var_247_1 = 0
			local var_247_2 = 0.375

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, true)
				arg_244_1.iconController_:SetSelectedState("hero")

				arg_244_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_244_1.callingController_:SetSelectedState("normal")

				arg_244_1.keyicon_.color = Color.New(1, 1, 1)
				arg_244_1.icon_.color = Color.New(1, 1, 1)

				local var_247_3 = arg_244_1:FormatText(arg_244_1:GetWordFromCfg(301061059).content)

				arg_244_1.text_.text = var_247_3

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_5 = 15 <= 0 and var_247_2 or var_247_2 * (utf8.len(var_247_3) / 15)

				if (15 <= 0 and var_247_2 or var_247_2 * (utf8.len(var_247_3) / 15)) > 0 and var_247_2 < var_247_5 then
					arg_244_1.talkMaxDuration = var_247_5

					if var_247_5 + var_247_1 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_5 + var_247_1
					end
				end

				arg_244_1.text_.text = var_247_3
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_6 = math.max(var_247_2, arg_244_1.talkMaxDuration)

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_6 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_1) / var_247_6

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_1 + var_247_6 and arg_244_1.time_ < var_247_1 + var_247_6 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play301061060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 301061060
		arg_248_1.duration_ = 9.63

		local var_248_0 = {
			zh = 9.633,
			ja = 1.999999999999
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play301061061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(arg_248_1.actors_["1166ui_story"]) and arg_248_1.var_.characterEffect1166ui_story == nil then
				arg_248_1.var_.characterEffect1166ui_story = arg_248_1.actors_["1166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_0 = 0.200000002980232

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_0 and not isNil(arg_248_1.actors_["1166ui_story"]) then
				if arg_248_1.var_.characterEffect1166ui_story and not isNil(arg_248_1.actors_["1166ui_story"]) then
					arg_248_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_248_1.time_ >= 0 + var_251_0 and arg_248_1.time_ < 0 + var_251_0 + arg_251_0 and not isNil(arg_248_1.actors_["1166ui_story"]) and arg_248_1.var_.characterEffect1166ui_story then
				arg_248_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action3_1")
			end

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_251_2 = 0
			local var_251_3 = 1.075

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_2 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_4 = arg_248_1:GetWordFromCfg(301061060)
				local var_251_5 = arg_248_1:FormatText(var_251_4.content)

				arg_248_1.text_.text = var_251_5

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_7 = 43 <= 0 and var_251_3 or var_251_3 * (utf8.len(var_251_5) / 43)

				if (43 <= 0 and var_251_3 or var_251_3 * (utf8.len(var_251_5) / 43)) > 0 and var_251_3 < var_251_7 then
					arg_248_1.talkMaxDuration = var_251_7

					if var_251_7 + var_251_2 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_7 + var_251_2
					end
				end

				arg_248_1.text_.text = var_251_5
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301061", "301061060", "story_v_out_301061.awb") ~= 0 then
					local var_251_8 = manager.audio:GetVoiceLength("story_v_out_301061", "301061060", "story_v_out_301061.awb") / 1000

					if var_251_8 + var_251_2 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_8 + var_251_2
					end

					if var_251_4.prefab_name ~= "" and arg_248_1.actors_[var_251_4.prefab_name] ~= nil then
						local var_251_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_4.prefab_name].transform, "story_v_out_301061", "301061060", "story_v_out_301061.awb")

						arg_248_1:RecordAudio("301061060", var_251_9)
						arg_248_1:RecordAudio("301061060", var_251_9)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_301061", "301061060", "story_v_out_301061.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_301061", "301061060", "story_v_out_301061.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_10 = math.max(var_251_3, arg_248_1.talkMaxDuration)

			if var_251_2 <= arg_248_1.time_ and arg_248_1.time_ < var_251_2 + var_251_10 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_2) / var_251_10

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_2 + var_251_10 and arg_248_1.time_ < var_251_2 + var_251_10 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play301061061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 301061061
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play301061062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(arg_252_1.actors_["1166ui_story"]) and arg_252_1.var_.characterEffect1166ui_story == nil then
				arg_252_1.var_.characterEffect1166ui_story = arg_252_1.actors_["1166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_0 = 0.200000002980232

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_0 and not isNil(arg_252_1.actors_["1166ui_story"]) then
				if arg_252_1.var_.characterEffect1166ui_story and not isNil(arg_252_1.actors_["1166ui_story"]) then
					arg_252_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_252_1.var_.characterEffect1166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_252_1.time_ - 0) / var_255_0)
				end
			end

			if arg_252_1.time_ >= 0 + var_255_0 and arg_252_1.time_ < 0 + var_255_0 + arg_255_0 and not isNil(arg_252_1.actors_["1166ui_story"]) and arg_252_1.var_.characterEffect1166ui_story then
				arg_252_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_252_1.var_.characterEffect1166ui_story.fillRatio = 0.5
			end

			local var_255_1 = 0
			local var_255_2 = 0.125

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_252_1.callingController_:SetSelectedState("normal")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_3 = arg_252_1:FormatText(arg_252_1:GetWordFromCfg(301061061).content)

				arg_252_1.text_.text = var_255_3

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_5 = 5 <= 0 and var_255_2 or var_255_2 * (utf8.len(var_255_3) / 5)

				if (5 <= 0 and var_255_2 or var_255_2 * (utf8.len(var_255_3) / 5)) > 0 and var_255_2 < var_255_5 then
					arg_252_1.talkMaxDuration = var_255_5

					if var_255_5 + var_255_1 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_5 + var_255_1
					end
				end

				arg_252_1.text_.text = var_255_3
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_6 = math.max(var_255_2, arg_252_1.talkMaxDuration)

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_6 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_1) / var_255_6

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_1 + var_255_6 and arg_252_1.time_ < var_255_1 + var_255_6 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play301061062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 301061062
		arg_256_1.duration_ = 2

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play301061063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(arg_256_1.actors_["1166ui_story"]) and arg_256_1.var_.characterEffect1166ui_story == nil then
				arg_256_1.var_.characterEffect1166ui_story = arg_256_1.actors_["1166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_0 = 0.200000002980232

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_0 and not isNil(arg_256_1.actors_["1166ui_story"]) then
				if arg_256_1.var_.characterEffect1166ui_story and not isNil(arg_256_1.actors_["1166ui_story"]) then
					arg_256_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_256_1.time_ >= 0 + var_259_0 and arg_256_1.time_ < 0 + var_259_0 + arg_259_0 and not isNil(arg_256_1.actors_["1166ui_story"]) and arg_256_1.var_.characterEffect1166ui_story then
				arg_256_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileB_weixiao", "EmotionTimelineAnimator")
			end

			local var_259_2 = 0
			local var_259_3 = 0.075

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_2 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_4 = arg_256_1:GetWordFromCfg(301061062)
				local var_259_5 = arg_256_1:FormatText(var_259_4.content)

				arg_256_1.text_.text = var_259_5

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_7 = 3 <= 0 and var_259_3 or var_259_3 * (utf8.len(var_259_5) / 3)

				if (3 <= 0 and var_259_3 or var_259_3 * (utf8.len(var_259_5) / 3)) > 0 and var_259_3 < var_259_7 then
					arg_256_1.talkMaxDuration = var_259_7

					if var_259_7 + var_259_2 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_7 + var_259_2
					end
				end

				arg_256_1.text_.text = var_259_5
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301061", "301061062", "story_v_out_301061.awb") ~= 0 then
					local var_259_8 = manager.audio:GetVoiceLength("story_v_out_301061", "301061062", "story_v_out_301061.awb") / 1000

					if var_259_8 + var_259_2 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_8 + var_259_2
					end

					if var_259_4.prefab_name ~= "" and arg_256_1.actors_[var_259_4.prefab_name] ~= nil then
						local var_259_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_4.prefab_name].transform, "story_v_out_301061", "301061062", "story_v_out_301061.awb")

						arg_256_1:RecordAudio("301061062", var_259_9)
						arg_256_1:RecordAudio("301061062", var_259_9)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_301061", "301061062", "story_v_out_301061.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_301061", "301061062", "story_v_out_301061.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_10 = math.max(var_259_3, arg_256_1.talkMaxDuration)

			if var_259_2 <= arg_256_1.time_ and arg_256_1.time_ < var_259_2 + var_259_10 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_2) / var_259_10

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_2 + var_259_10 and arg_256_1.time_ < var_259_2 + var_259_10 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play301061063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 301061063
		arg_260_1.duration_ = 5

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play301061064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.var_.moveOldPos1166ui_story = arg_260_1.actors_["1166ui_story"].transform.localPosition

				local var_263_0 = GameObjectTools.GetOrAddComponent(arg_260_1.actors_["1166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_263_0 then
					var_263_0:EnableDynamicBone(false)
				end
			end

			local var_263_1 = 0.001

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_1 then
				arg_260_1.actors_["1166ui_story"].transform.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos1166ui_story, Vector3.New(0, 100, 0), (arg_260_1.time_ - 0) / var_263_1)
				arg_260_1.actors_["1166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_260_1.actors_["1166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["1166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["1166ui_story"].transform.position).z)
				arg_260_1.actors_["1166ui_story"].transform.localEulerAngles.z = 0
				arg_260_1.actors_["1166ui_story"].transform.localEulerAngles.x = 0
				arg_260_1.actors_["1166ui_story"].transform.localEulerAngles = arg_260_1.actors_["1166ui_story"].transform.localEulerAngles
			end

			if arg_260_1.time_ >= 0 + var_263_1 and arg_260_1.time_ < 0 + var_263_1 + arg_263_0 then
				arg_260_1.actors_["1166ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_260_1.actors_["1166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_260_1.actors_["1166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["1166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["1166ui_story"].transform.position).z)
				arg_260_1.actors_["1166ui_story"].transform.localEulerAngles.z = 0
				arg_260_1.actors_["1166ui_story"].transform.localEulerAngles.x = 0
				arg_260_1.actors_["1166ui_story"].transform.localEulerAngles = arg_260_1.actors_["1166ui_story"].transform.localEulerAngles

				local var_263_2 = GameObjectTools.GetOrAddComponent(arg_260_1.actors_["1166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_263_2 then
					var_263_2:EnableDynamicBone(true)
				end
			end

			local var_263_3 = arg_260_1.actors_["1166ui_story"]

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 and not isNil(var_263_3) and arg_260_1.var_.characterEffect1166ui_story == nil then
				arg_260_1.var_.characterEffect1166ui_story = var_263_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_4 = 0.200000002980232

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_4 and not isNil(var_263_3) then
				if arg_260_1.var_.characterEffect1166ui_story and not isNil(var_263_3) then
					arg_260_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_260_1.var_.characterEffect1166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_260_1.time_ - 0) / var_263_4)
				end
			end

			if arg_260_1.time_ >= 0 + var_263_4 and arg_260_1.time_ < 0 + var_263_4 + arg_263_0 and not isNil(var_263_3) and arg_260_1.var_.characterEffect1166ui_story then
				arg_260_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_260_1.var_.characterEffect1166ui_story.fillRatio = 0.5
			end

			local var_263_5 = 0
			local var_263_6 = 0.975

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_5 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, false)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_7 = arg_260_1:FormatText(arg_260_1:GetWordFromCfg(301061063).content)

				arg_260_1.text_.text = var_263_7

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_9 = 39 <= 0 and var_263_6 or var_263_6 * (utf8.len(var_263_7) / 39)

				if (39 <= 0 and var_263_6 or var_263_6 * (utf8.len(var_263_7) / 39)) > 0 and var_263_6 < var_263_9 then
					arg_260_1.talkMaxDuration = var_263_9

					if var_263_9 + var_263_5 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_9 + var_263_5
					end
				end

				arg_260_1.text_.text = var_263_7
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_10 = math.max(var_263_6, arg_260_1.talkMaxDuration)

			if var_263_5 <= arg_260_1.time_ and arg_260_1.time_ < var_263_5 + var_263_10 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_5) / var_263_10

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_5 + var_263_10 and arg_260_1.time_ < var_263_5 + var_263_10 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_260_1:InitPlayNodeList()
	end,
	Play301061064 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 301061064
		arg_264_1.duration_ = 4

		local var_264_0 = {
			zh = 4,
			ja = 1.999999999999
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
			arg_264_1.auto_ = false
		end

		function arg_264_1.playNext_(arg_266_0)
			arg_264_1.onStoryFinished_()
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.var_.moveOldPos1166ui_story = arg_264_1.actors_["1166ui_story"].transform.localPosition

				local var_267_0 = GameObjectTools.GetOrAddComponent(arg_264_1.actors_["1166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_267_0 then
					var_267_0:EnableDynamicBone(false)
				end
			end

			local var_267_1 = 0.001

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_1 then
				arg_264_1.actors_["1166ui_story"].transform.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos1166ui_story, Vector3.New(0, -0.75, -6.25), (arg_264_1.time_ - 0) / var_267_1)
				arg_264_1.actors_["1166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_264_1.actors_["1166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["1166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["1166ui_story"].transform.position).z)
				arg_264_1.actors_["1166ui_story"].transform.localEulerAngles.z = 0
				arg_264_1.actors_["1166ui_story"].transform.localEulerAngles.x = 0
				arg_264_1.actors_["1166ui_story"].transform.localEulerAngles = arg_264_1.actors_["1166ui_story"].transform.localEulerAngles
			end

			if arg_264_1.time_ >= 0 + var_267_1 and arg_264_1.time_ < 0 + var_267_1 + arg_267_0 then
				arg_264_1.actors_["1166ui_story"].transform.localPosition = Vector3.New(0, -0.75, -6.25)
				arg_264_1.actors_["1166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_264_1.actors_["1166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["1166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["1166ui_story"].transform.position).z)
				arg_264_1.actors_["1166ui_story"].transform.localEulerAngles.z = 0
				arg_264_1.actors_["1166ui_story"].transform.localEulerAngles.x = 0
				arg_264_1.actors_["1166ui_story"].transform.localEulerAngles = arg_264_1.actors_["1166ui_story"].transform.localEulerAngles

				local var_267_2 = GameObjectTools.GetOrAddComponent(arg_264_1.actors_["1166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_267_2 then
					var_267_2:EnableDynamicBone(true)
				end
			end

			local var_267_3 = arg_264_1.actors_["1166ui_story"]

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(var_267_3) and arg_264_1.var_.characterEffect1166ui_story == nil then
				arg_264_1.var_.characterEffect1166ui_story = var_267_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_4 = 0.200000002980232

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_4 and not isNil(var_267_3) then
				if arg_264_1.var_.characterEffect1166ui_story and not isNil(var_267_3) then
					arg_264_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_264_1.time_ >= 0 + var_267_4 and arg_264_1.time_ < 0 + var_267_4 + arg_267_0 and not isNil(var_267_3) and arg_264_1.var_.characterEffect1166ui_story then
				arg_264_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action4_1")
			end

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_267_6 = 0
			local var_267_7 = 0.4

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_6 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_8 = arg_264_1:GetWordFromCfg(301061064)
				local var_267_9 = arg_264_1:FormatText(var_267_8.content)

				arg_264_1.text_.text = var_267_9

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_11 = 16 <= 0 and var_267_7 or var_267_7 * (utf8.len(var_267_9) / 16)

				if (16 <= 0 and var_267_7 or var_267_7 * (utf8.len(var_267_9) / 16)) > 0 and var_267_7 < var_267_11 then
					arg_264_1.talkMaxDuration = var_267_11

					if var_267_11 + var_267_6 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_11 + var_267_6
					end
				end

				arg_264_1.text_.text = var_267_9
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301061", "301061064", "story_v_out_301061.awb") ~= 0 then
					local var_267_12 = manager.audio:GetVoiceLength("story_v_out_301061", "301061064", "story_v_out_301061.awb") / 1000

					if var_267_12 + var_267_6 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_12 + var_267_6
					end

					if var_267_8.prefab_name ~= "" and arg_264_1.actors_[var_267_8.prefab_name] ~= nil then
						local var_267_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_8.prefab_name].transform, "story_v_out_301061", "301061064", "story_v_out_301061.awb")

						arg_264_1:RecordAudio("301061064", var_267_13)
						arg_264_1:RecordAudio("301061064", var_267_13)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_301061", "301061064", "story_v_out_301061.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_301061", "301061064", "story_v_out_301061.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_14 = math.max(var_267_7, arg_264_1.talkMaxDuration)

			if var_267_6 <= arg_264_1.time_ and arg_264_1.time_ < var_267_6 + var_267_14 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_6) / var_267_14

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_6 + var_267_14 and arg_264_1.time_ < var_267_6 + var_267_14 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_264_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B01c",
		"TextureConfig/Background/MS0102",
		"TextureConfig/Background/MS0102a"
	},
	voices = {
		"story_v_out_301061.awb"
	}
}
