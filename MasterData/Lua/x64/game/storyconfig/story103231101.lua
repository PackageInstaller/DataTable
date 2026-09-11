return {
	Play323111001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 323111001
		arg_1_1.duration_ = 6.77

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play323111002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST2005 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2005")
				var_4_0.name = "ST2005"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST2005 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST2005

				arg_1_1.bgs_.ST2005.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST2005" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			if 0.433333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.433333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_8_story_mountain_kunlun", "bgm_activity_4_8_story_mountain_kunlun", "bgm_activity_4_8_story_mountain_kunlun.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_4_8_story_mountain_kunlun", "bgm_activity_4_8_story_mountain_kunlun")

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

			if 0.166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.166666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_ice_cave", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_16 = 1.76666666666667
			local var_4_17 = 1.325

			if 1.76666666666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_18 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_18:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_19 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(323111001).content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 53 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 53)

				if (53 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 53)) > 0 and var_4_17 < var_4_21 then
					arg_1_1.talkMaxDuration = var_4_21
					var_4_16 = var_4_16 + 0.3

					if var_4_21 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_16
					end
				end

				arg_1_1.text_.text = var_4_19
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_22 = var_4_16 + 0.3
			local var_4_23 = math.max(var_4_17, arg_1_1.talkMaxDuration)

			if var_4_16 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_23 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_22) / var_4_23

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_22 + var_4_23 and arg_1_1.time_ < var_4_22 + var_4_23 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play323111002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 323111002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play323111003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.125

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(323111002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 45 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 45)

				if (45 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 45)) > 0 and var_12_0 < var_12_3 then
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
	Play323111003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 323111003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play323111004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 1.4

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(323111003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 56 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 56)

				if (56 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 56)) > 0 and var_16_0 < var_16_3 then
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
	Play323111004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 323111004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play323111005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.275

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

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(323111004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 11 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 11)

				if (11 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 11)) > 0 and var_20_0 < var_20_3 then
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
	Play323111005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 323111005
		arg_21_1.duration_ = 8.13

		local var_21_0 = {
			zh = 5.666,
			ja = 8.133
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play323111006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.425

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:GetWordFromCfg(323111005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 17 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 17)

				if (17 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 17)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111005", "story_v_out_323111.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_323111", "323111005", "story_v_out_323111.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_323111", "323111005", "story_v_out_323111.awb")

						arg_21_1:RecordAudio("323111005", var_24_6)
						arg_21_1:RecordAudio("323111005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_323111", "323111005", "story_v_out_323111.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_323111", "323111005", "story_v_out_323111.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play323111006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 323111006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play323111007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0.714021598687395 < arg_25_1.time_ and arg_25_1.time_ <= 0.714021598687395 + arg_28_0 then
				arg_25_1:AudioAction("play", "effect", "se_story_148", "se_story_148_footstep_snow01", "")
			end

			local var_28_1 = 0
			local var_28_2 = 1.325

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(323111006).content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 53 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 53)

				if (53 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 53)) > 0 and var_28_2 < var_28_5 then
					arg_25_1.talkMaxDuration = var_28_5

					if var_28_5 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + var_28_1
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_6 = math.max(var_28_2, arg_25_1.talkMaxDuration)

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_6 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_1) / var_28_6

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_1 + var_28_6 and arg_25_1.time_ < var_28_1 + var_28_6 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play323111007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 323111007
		arg_29_1.duration_ = 5.3

		local var_29_0 = {
			zh = 4.033,
			ja = 5.3
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
				arg_29_0:Play323111008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.actors_["1053ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1053ui_story"))) then
				local var_32_0 = Object.Instantiate(Asset.Load("Char/" .. "1053ui_story"), arg_29_1.stage_.transform)

				var_32_0.name = "1053ui_story"
				var_32_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.actors_["1053ui_story"] = var_32_0

				local var_32_1 = var_32_0:GetComponentInChildren(typeof(CharacterEffect))

				var_32_1.enabled = true

				local var_32_2 = GameObjectTools.GetOrAddComponent(var_32_0, typeof(DynamicBoneHelper))

				if var_32_2 then
					var_32_2:EnableDynamicBone(false)
				end

				arg_29_1:ShowWeapon(var_32_1.transform, false)

				arg_29_1.var_["1053ui_story" .. "Animator"] = var_32_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_29_1.var_["1053ui_story" .. "Animator"].applyRootMotion = true
				arg_29_1.var_["1053ui_story" .. "LipSync"] = var_32_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_32_3 = arg_29_1.actors_["1053ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1053ui_story = var_32_3.localPosition

				local var_32_4 = GameObjectTools.GetOrAddComponent(var_32_3.gameObject, typeof(DynamicBoneHelper))

				if var_32_4 then
					var_32_4:EnableDynamicBone(false)
				end
			end

			local var_32_5 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_5 then
				var_32_3.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_29_1.time_ - 0) / var_32_5)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_5 and arg_29_1.time_ < 0 + var_32_5 + arg_32_0 then
				var_32_3.localPosition = Vector3.New(0, -1.08, -6)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles

				local var_32_6 = GameObjectTools.GetOrAddComponent(var_32_3.gameObject, typeof(DynamicBoneHelper))

				if var_32_6 then
					var_32_6:EnableDynamicBone(true)
				end
			end

			local var_32_7 = arg_29_1.actors_["1053ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_7) and arg_29_1.var_.characterEffect1053ui_story == nil then
				arg_29_1.var_.characterEffect1053ui_story = var_32_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_8 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_8 and not isNil(var_32_7) then
				if arg_29_1.var_.characterEffect1053ui_story and not isNil(var_32_7) then
					arg_29_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_8 and arg_29_1.time_ < 0 + var_32_8 + arg_32_0 and not isNil(var_32_7) and arg_29_1.var_.characterEffect1053ui_story then
				arg_29_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action3_1")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_32_10 = 0
			local var_32_11 = 0.5

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[1453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_12 = arg_29_1:GetWordFromCfg(323111007)
				local var_32_13 = arg_29_1:FormatText(var_32_12.content)

				arg_29_1.text_.text = var_32_13

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_15 = 20 <= 0 and var_32_11 or var_32_11 * (utf8.len(var_32_13) / 20)

				if (20 <= 0 and var_32_11 or var_32_11 * (utf8.len(var_32_13) / 20)) > 0 and var_32_11 < var_32_15 then
					arg_29_1.talkMaxDuration = var_32_15

					if var_32_15 + var_32_10 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_15 + var_32_10
					end
				end

				arg_29_1.text_.text = var_32_13
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111007", "story_v_out_323111.awb") ~= 0 then
					local var_32_16 = manager.audio:GetVoiceLength("story_v_out_323111", "323111007", "story_v_out_323111.awb") / 1000

					if var_32_16 + var_32_10 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_16 + var_32_10
					end

					if var_32_12.prefab_name ~= "" and arg_29_1.actors_[var_32_12.prefab_name] ~= nil then
						local var_32_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_12.prefab_name].transform, "story_v_out_323111", "323111007", "story_v_out_323111.awb")

						arg_29_1:RecordAudio("323111007", var_32_17)
						arg_29_1:RecordAudio("323111007", var_32_17)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_323111", "323111007", "story_v_out_323111.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_323111", "323111007", "story_v_out_323111.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_18 = math.max(var_32_11, arg_29_1.talkMaxDuration)

			if var_32_10 <= arg_29_1.time_ and arg_29_1.time_ < var_32_10 + var_32_18 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_10) / var_32_18

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_10 + var_32_18 and arg_29_1.time_ < var_32_10 + var_32_18 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
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
	Play323111008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 323111008
		arg_33_1.duration_ = 7.13

		local var_33_0 = {
			zh = 3.8,
			ja = 7.133
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
				arg_33_0:Play323111009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1053ui_story"]) and arg_33_1.var_.characterEffect1053ui_story == nil then
				arg_33_1.var_.characterEffect1053ui_story = arg_33_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1053ui_story"]) then
				if arg_33_1.var_.characterEffect1053ui_story and not isNil(arg_33_1.actors_["1053ui_story"]) then
					arg_33_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1053ui_story"]) and arg_33_1.var_.characterEffect1053ui_story then
				arg_33_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0
			local var_36_2 = 0.4

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_3 = arg_33_1:GetWordFromCfg(323111008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_6 = 16 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_4) / 16)

				if (16 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_4) / 16)) > 0 and var_36_2 < var_36_6 then
					arg_33_1.talkMaxDuration = var_36_6

					if var_36_6 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111008", "story_v_out_323111.awb") ~= 0 then
					local var_36_7 = manager.audio:GetVoiceLength("story_v_out_323111", "323111008", "story_v_out_323111.awb") / 1000

					if var_36_7 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_1
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_323111", "323111008", "story_v_out_323111.awb")

						arg_33_1:RecordAudio("323111008", var_36_8)
						arg_33_1:RecordAudio("323111008", var_36_8)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_323111", "323111008", "story_v_out_323111.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_323111", "323111008", "story_v_out_323111.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_9 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_9 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_9

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_9 and arg_33_1.time_ < var_36_1 + var_36_9 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play323111009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 323111009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play323111010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1053ui_story = arg_37_1.actors_["1053ui_story"].transform.localPosition

				local var_40_0 = GameObjectTools.GetOrAddComponent(arg_37_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_40_0 then
					var_40_0:EnableDynamicBone(false)
				end
			end

			local var_40_1 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_1 then
				arg_37_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_37_1.time_ - 0) / var_40_1)
				arg_37_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1053ui_story"].transform.position).z)
				arg_37_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1053ui_story"].transform.localEulerAngles = arg_37_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_1 and arg_37_1.time_ < 0 + var_40_1 + arg_40_0 then
				arg_37_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1053ui_story"].transform.position).z)
				arg_37_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1053ui_story"].transform.localEulerAngles = arg_37_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_40_2 = GameObjectTools.GetOrAddComponent(arg_37_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_40_2 then
					var_40_2:EnableDynamicBone(true)
				end
			end

			local var_40_3 = 0
			local var_40_4 = 1.075

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_3 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_5 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(323111009).content)

				arg_37_1.text_.text = var_40_5

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_7 = 43 <= 0 and var_40_4 or var_40_4 * (utf8.len(var_40_5) / 43)

				if (43 <= 0 and var_40_4 or var_40_4 * (utf8.len(var_40_5) / 43)) > 0 and var_40_4 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_3 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_3
					end
				end

				arg_37_1.text_.text = var_40_5
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_8 = math.max(var_40_4, arg_37_1.talkMaxDuration)

			if var_40_3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_3 + var_40_8 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_3) / var_40_8

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_3 + var_40_8 and arg_37_1.time_ < var_40_3 + var_40_8 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
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
	Play323111010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 323111010
		arg_41_1.duration_ = 2.57

		local var_41_0 = {
			zh = 1.999999999999,
			ja = 2.566
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
				arg_41_0:Play323111011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1053ui_story = arg_41_1.actors_["1053ui_story"].transform.localPosition

				local var_44_0 = GameObjectTools.GetOrAddComponent(arg_41_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_44_0 then
					var_44_0:EnableDynamicBone(false)
				end
			end

			local var_44_1 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_1 then
				arg_41_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_41_1.time_ - 0) / var_44_1)
				arg_41_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1053ui_story"].transform.position).z)
				arg_41_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1053ui_story"].transform.localEulerAngles = arg_41_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_1 and arg_41_1.time_ < 0 + var_44_1 + arg_44_0 then
				arg_41_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_41_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1053ui_story"].transform.position).z)
				arg_41_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1053ui_story"].transform.localEulerAngles = arg_41_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_44_2 = GameObjectTools.GetOrAddComponent(arg_41_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_44_2 then
					var_44_2:EnableDynamicBone(true)
				end
			end

			local var_44_3 = arg_41_1.actors_["1053ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_3) and arg_41_1.var_.characterEffect1053ui_story == nil then
				arg_41_1.var_.characterEffect1053ui_story = var_44_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_4 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 and not isNil(var_44_3) then
				if arg_41_1.var_.characterEffect1053ui_story and not isNil(var_44_3) then
					arg_41_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 and not isNil(var_44_3) and arg_41_1.var_.characterEffect1053ui_story then
				arg_41_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053actionlink/1053action436")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_44_6 = 0
			local var_44_7 = 0.1

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[1453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_8 = arg_41_1:GetWordFromCfg(323111010)
				local var_44_9 = arg_41_1:FormatText(var_44_8.content)

				arg_41_1.text_.text = var_44_9

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 4 <= 0 and var_44_7 or var_44_7 * (utf8.len(var_44_9) / 4)

				if (4 <= 0 and var_44_7 or var_44_7 * (utf8.len(var_44_9) / 4)) > 0 and var_44_7 < var_44_11 then
					arg_41_1.talkMaxDuration = var_44_11

					if var_44_11 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_11 + var_44_6
					end
				end

				arg_41_1.text_.text = var_44_9
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111010", "story_v_out_323111.awb") ~= 0 then
					local var_44_12 = manager.audio:GetVoiceLength("story_v_out_323111", "323111010", "story_v_out_323111.awb") / 1000

					if var_44_12 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_12 + var_44_6
					end

					if var_44_8.prefab_name ~= "" and arg_41_1.actors_[var_44_8.prefab_name] ~= nil then
						local var_44_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_8.prefab_name].transform, "story_v_out_323111", "323111010", "story_v_out_323111.awb")

						arg_41_1:RecordAudio("323111010", var_44_13)
						arg_41_1:RecordAudio("323111010", var_44_13)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_323111", "323111010", "story_v_out_323111.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_323111", "323111010", "story_v_out_323111.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_14 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_14 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_6) / var_44_14

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_6 + var_44_14 and arg_41_1.time_ < var_44_6 + var_44_14 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
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
	Play323111011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 323111011
		arg_45_1.duration_ = 7.9

		local var_45_0 = {
			zh = 3.533,
			ja = 7.9
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
				arg_45_0:Play323111012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1053ui_story"]) and arg_45_1.var_.characterEffect1053ui_story == nil then
				arg_45_1.var_.characterEffect1053ui_story = arg_45_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1053ui_story"]) then
				if arg_45_1.var_.characterEffect1053ui_story and not isNil(arg_45_1.actors_["1053ui_story"]) then
					arg_45_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1053ui_story"]) and arg_45_1.var_.characterEffect1053ui_story then
				arg_45_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_48_1 = 0
			local var_48_2 = 0.3

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_3 = arg_45_1:GetWordFromCfg(323111011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_6 = 12 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_4) / 12)

				if (12 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_4) / 12)) > 0 and var_48_2 < var_48_6 then
					arg_45_1.talkMaxDuration = var_48_6

					if var_48_6 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_6 + var_48_1
					end
				end

				arg_45_1.text_.text = var_48_4
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111011", "story_v_out_323111.awb") ~= 0 then
					local var_48_7 = manager.audio:GetVoiceLength("story_v_out_323111", "323111011", "story_v_out_323111.awb") / 1000

					if var_48_7 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_1
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_323111", "323111011", "story_v_out_323111.awb")

						arg_45_1:RecordAudio("323111011", var_48_8)
						arg_45_1:RecordAudio("323111011", var_48_8)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_323111", "323111011", "story_v_out_323111.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_323111", "323111011", "story_v_out_323111.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_9 = math.max(var_48_2, arg_45_1.talkMaxDuration)

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_9 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_1) / var_48_9

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_1 + var_48_9 and arg_45_1.time_ < var_48_1 + var_48_9 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play323111012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 323111012
		arg_49_1.duration_ = 5.3

		local var_49_0 = {
			zh = 2.233,
			ja = 5.3
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
				arg_49_0:Play323111013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1053ui_story"]) and arg_49_1.var_.characterEffect1053ui_story == nil then
				arg_49_1.var_.characterEffect1053ui_story = arg_49_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1053ui_story"]) then
				if arg_49_1.var_.characterEffect1053ui_story and not isNil(arg_49_1.actors_["1053ui_story"]) then
					arg_49_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1053ui_story"]) and arg_49_1.var_.characterEffect1053ui_story then
				arg_49_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_52_2 = 0
			local var_52_3 = 0.25

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[1453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_4 = arg_49_1:GetWordFromCfg(323111012)
				local var_52_5 = arg_49_1:FormatText(var_52_4.content)

				arg_49_1.text_.text = var_52_5

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_7 = 10 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 10)

				if (10 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 10)) > 0 and var_52_3 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_2
					end
				end

				arg_49_1.text_.text = var_52_5
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111012", "story_v_out_323111.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_323111", "323111012", "story_v_out_323111.awb") / 1000

					if var_52_8 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_2
					end

					if var_52_4.prefab_name ~= "" and arg_49_1.actors_[var_52_4.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_4.prefab_name].transform, "story_v_out_323111", "323111012", "story_v_out_323111.awb")

						arg_49_1:RecordAudio("323111012", var_52_9)
						arg_49_1:RecordAudio("323111012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_323111", "323111012", "story_v_out_323111.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_323111", "323111012", "story_v_out_323111.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_3, arg_49_1.talkMaxDuration)

			if var_52_2 <= arg_49_1.time_ and arg_49_1.time_ < var_52_2 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_2) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_2 + var_52_10 and arg_49_1.time_ < var_52_2 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play323111013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 323111013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play323111014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1053ui_story = arg_53_1.actors_["1053ui_story"].transform.localPosition

				local var_56_0 = GameObjectTools.GetOrAddComponent(arg_53_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_56_0 then
					var_56_0:EnableDynamicBone(false)
				end
			end

			local var_56_1 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_1 then
				arg_53_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_53_1.time_ - 0) / var_56_1)
				arg_53_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1053ui_story"].transform.position).z)
				arg_53_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1053ui_story"].transform.localEulerAngles = arg_53_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_1 and arg_53_1.time_ < 0 + var_56_1 + arg_56_0 then
				arg_53_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1053ui_story"].transform.position).z)
				arg_53_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1053ui_story"].transform.localEulerAngles = arg_53_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_56_2 = GameObjectTools.GetOrAddComponent(arg_53_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_56_2 then
					var_56_2:EnableDynamicBone(true)
				end
			end

			local var_56_3 = arg_53_1.actors_["1053ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_3) and arg_53_1.var_.characterEffect1053ui_story == nil then
				arg_53_1.var_.characterEffect1053ui_story = var_56_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_4 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 and not isNil(var_56_3) then
				if arg_53_1.var_.characterEffect1053ui_story and not isNil(var_56_3) then
					arg_53_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_4)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 and not isNil(var_56_3) and arg_53_1.var_.characterEffect1053ui_story then
				arg_53_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 0.366666666666667 < arg_53_1.time_ and arg_53_1.time_ <= 0.366666666666667 + arg_56_0 then
				arg_53_1:AudioAction("play", "effect", "se_story_148", "se_story_148_footstep_snow02", "")
			end

			local var_56_6 = 0
			local var_56_7 = 0.95

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_8 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(323111013).content)

				arg_53_1.text_.text = var_56_8

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_10 = 38 <= 0 and var_56_7 or var_56_7 * (utf8.len(var_56_8) / 38)

				if (38 <= 0 and var_56_7 or var_56_7 * (utf8.len(var_56_8) / 38)) > 0 and var_56_7 < var_56_10 then
					arg_53_1.talkMaxDuration = var_56_10

					if var_56_10 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_6
					end
				end

				arg_53_1.text_.text = var_56_8
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_11 = math.max(var_56_7, arg_53_1.talkMaxDuration)

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_11 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_6) / var_56_11

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_6 + var_56_11 and arg_53_1.time_ < var_56_6 + var_56_11 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
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
	Play323111014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 323111014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play323111015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 1.675

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_1 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(323111014).content)

				arg_57_1.text_.text = var_60_1

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_3 = 67 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 67)

				if (67 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 67)) > 0 and var_60_0 < var_60_3 then
					arg_57_1.talkMaxDuration = var_60_3

					if var_60_3 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_3 + 0
					end
				end

				arg_57_1.text_.text = var_60_1
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_4 = math.max(var_60_0, arg_57_1.talkMaxDuration)

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - 0) / var_60_4

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play323111015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 323111015
		arg_61_1.duration_ = 7.5

		local var_61_0 = {
			zh = 6.233,
			ja = 7.5
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
				arg_61_0:Play323111016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1053ui_story = arg_61_1.actors_["1053ui_story"].transform.localPosition

				local var_64_0 = GameObjectTools.GetOrAddComponent(arg_61_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_64_0 then
					var_64_0:EnableDynamicBone(false)
				end
			end

			local var_64_1 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_1 then
				arg_61_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_61_1.time_ - 0) / var_64_1)
				arg_61_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1053ui_story"].transform.position).z)
				arg_61_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1053ui_story"].transform.localEulerAngles = arg_61_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_1 and arg_61_1.time_ < 0 + var_64_1 + arg_64_0 then
				arg_61_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_61_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1053ui_story"].transform.position).z)
				arg_61_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1053ui_story"].transform.localEulerAngles = arg_61_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_64_2 = GameObjectTools.GetOrAddComponent(arg_61_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_64_2 then
					var_64_2:EnableDynamicBone(true)
				end
			end

			local var_64_3 = arg_61_1.actors_["1053ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_3) and arg_61_1.var_.characterEffect1053ui_story == nil then
				arg_61_1.var_.characterEffect1053ui_story = var_64_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_4 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 and not isNil(var_64_3) then
				if arg_61_1.var_.characterEffect1053ui_story and not isNil(var_64_3) then
					arg_61_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 and not isNil(var_64_3) and arg_61_1.var_.characterEffect1053ui_story then
				arg_61_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action6_2")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_64_6 = 0
			local var_64_7 = 0.9

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[1453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_8 = arg_61_1:GetWordFromCfg(323111015)
				local var_64_9 = arg_61_1:FormatText(var_64_8.content)

				arg_61_1.text_.text = var_64_9

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_11 = 36 <= 0 and var_64_7 or var_64_7 * (utf8.len(var_64_9) / 36)

				if (36 <= 0 and var_64_7 or var_64_7 * (utf8.len(var_64_9) / 36)) > 0 and var_64_7 < var_64_11 then
					arg_61_1.talkMaxDuration = var_64_11

					if var_64_11 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_11 + var_64_6
					end
				end

				arg_61_1.text_.text = var_64_9
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111015", "story_v_out_323111.awb") ~= 0 then
					local var_64_12 = manager.audio:GetVoiceLength("story_v_out_323111", "323111015", "story_v_out_323111.awb") / 1000

					if var_64_12 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_12 + var_64_6
					end

					if var_64_8.prefab_name ~= "" and arg_61_1.actors_[var_64_8.prefab_name] ~= nil then
						local var_64_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_8.prefab_name].transform, "story_v_out_323111", "323111015", "story_v_out_323111.awb")

						arg_61_1:RecordAudio("323111015", var_64_13)
						arg_61_1:RecordAudio("323111015", var_64_13)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_323111", "323111015", "story_v_out_323111.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_323111", "323111015", "story_v_out_323111.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_14 = math.max(var_64_7, arg_61_1.talkMaxDuration)

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_14 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_6) / var_64_14

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_6 + var_64_14 and arg_61_1.time_ < var_64_6 + var_64_14 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
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
	Play323111016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 323111016
		arg_65_1.duration_ = 10.7

		local var_65_0 = {
			zh = 9,
			ja = 10.7
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
				arg_65_0:Play323111017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1053ui_story"]) and arg_65_1.var_.characterEffect1053ui_story == nil then
				arg_65_1.var_.characterEffect1053ui_story = arg_65_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1053ui_story"]) then
				if arg_65_1.var_.characterEffect1053ui_story and not isNil(arg_65_1.actors_["1053ui_story"]) then
					arg_65_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_0)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1053ui_story"]) and arg_65_1.var_.characterEffect1053ui_story then
				arg_65_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_68_1 = 0
			local var_68_2 = 0.7

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_3 = arg_65_1:GetWordFromCfg(323111016)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_6 = 28 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_4) / 28)

				if (28 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_4) / 28)) > 0 and var_68_2 < var_68_6 then
					arg_65_1.talkMaxDuration = var_68_6

					if var_68_6 + var_68_1 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_6 + var_68_1
					end
				end

				arg_65_1.text_.text = var_68_4
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111016", "story_v_out_323111.awb") ~= 0 then
					local var_68_7 = manager.audio:GetVoiceLength("story_v_out_323111", "323111016", "story_v_out_323111.awb") / 1000

					if var_68_7 + var_68_1 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_1
					end

					if var_68_3.prefab_name ~= "" and arg_65_1.actors_[var_68_3.prefab_name] ~= nil then
						local var_68_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_3.prefab_name].transform, "story_v_out_323111", "323111016", "story_v_out_323111.awb")

						arg_65_1:RecordAudio("323111016", var_68_8)
						arg_65_1:RecordAudio("323111016", var_68_8)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_323111", "323111016", "story_v_out_323111.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_323111", "323111016", "story_v_out_323111.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_9 = math.max(var_68_2, arg_65_1.talkMaxDuration)

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_9 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_1) / var_68_9

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_1 + var_68_9 and arg_65_1.time_ < var_68_1 + var_68_9 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play323111017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 323111017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play323111018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.125

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

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_1 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(323111017).content)

				arg_69_1.text_.text = var_72_1

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_3 = 5 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 5)

				if (5 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 5)) > 0 and var_72_0 < var_72_3 then
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
	Play323111018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 323111018
		arg_73_1.duration_ = 13.7

		local var_73_0 = {
			zh = 7.8,
			ja = 13.7
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
				arg_73_0:Play323111019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1053ui_story"]) and arg_73_1.var_.characterEffect1053ui_story == nil then
				arg_73_1.var_.characterEffect1053ui_story = arg_73_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1053ui_story"]) then
				if arg_73_1.var_.characterEffect1053ui_story and not isNil(arg_73_1.actors_["1053ui_story"]) then
					arg_73_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1053ui_story"]) and arg_73_1.var_.characterEffect1053ui_story then
				arg_73_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_76_2 = 0
			local var_76_3 = 0.85

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[1453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_4 = arg_73_1:GetWordFromCfg(323111018)
				local var_76_5 = arg_73_1:FormatText(var_76_4.content)

				arg_73_1.text_.text = var_76_5

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_7 = 34 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 34)

				if (34 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 34)) > 0 and var_76_3 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_2
					end
				end

				arg_73_1.text_.text = var_76_5
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111018", "story_v_out_323111.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_323111", "323111018", "story_v_out_323111.awb") / 1000

					if var_76_8 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_2
					end

					if var_76_4.prefab_name ~= "" and arg_73_1.actors_[var_76_4.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_4.prefab_name].transform, "story_v_out_323111", "323111018", "story_v_out_323111.awb")

						arg_73_1:RecordAudio("323111018", var_76_9)
						arg_73_1:RecordAudio("323111018", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_323111", "323111018", "story_v_out_323111.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_323111", "323111018", "story_v_out_323111.awb")
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
	Play323111019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 323111019
		arg_77_1.duration_ = 4.8

		local var_77_0 = {
			zh = 3.1,
			ja = 4.8
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
				arg_77_0:Play323111020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1053ui_story"]) and arg_77_1.var_.characterEffect1053ui_story == nil then
				arg_77_1.var_.characterEffect1053ui_story = arg_77_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1053ui_story"]) then
				if arg_77_1.var_.characterEffect1053ui_story and not isNil(arg_77_1.actors_["1053ui_story"]) then
					arg_77_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_0)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1053ui_story"]) and arg_77_1.var_.characterEffect1053ui_story then
				arg_77_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_80_1 = 0
			local var_80_2 = 0.275

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_3 = arg_77_1:GetWordFromCfg(323111019)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_6 = 11 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_4) / 11)

				if (11 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_4) / 11)) > 0 and var_80_2 < var_80_6 then
					arg_77_1.talkMaxDuration = var_80_6

					if var_80_6 + var_80_1 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_6 + var_80_1
					end
				end

				arg_77_1.text_.text = var_80_4
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111019", "story_v_out_323111.awb") ~= 0 then
					local var_80_7 = manager.audio:GetVoiceLength("story_v_out_323111", "323111019", "story_v_out_323111.awb") / 1000

					if var_80_7 + var_80_1 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_1
					end

					if var_80_3.prefab_name ~= "" and arg_77_1.actors_[var_80_3.prefab_name] ~= nil then
						local var_80_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_3.prefab_name].transform, "story_v_out_323111", "323111019", "story_v_out_323111.awb")

						arg_77_1:RecordAudio("323111019", var_80_8)
						arg_77_1:RecordAudio("323111019", var_80_8)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_323111", "323111019", "story_v_out_323111.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_323111", "323111019", "story_v_out_323111.awb")
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
	Play323111020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 323111020
		arg_81_1.duration_ = 4.6

		local var_81_0 = {
			zh = 4.2,
			ja = 4.6
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
				arg_81_0:Play323111021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1053ui_story"]) and arg_81_1.var_.characterEffect1053ui_story == nil then
				arg_81_1.var_.characterEffect1053ui_story = arg_81_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1053ui_story"]) then
				if arg_81_1.var_.characterEffect1053ui_story and not isNil(arg_81_1.actors_["1053ui_story"]) then
					arg_81_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1053ui_story"]) and arg_81_1.var_.characterEffect1053ui_story then
				arg_81_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action2_1")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_84_2 = 0
			local var_84_3 = 0.5

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_2 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[1453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_4 = arg_81_1:GetWordFromCfg(323111020)
				local var_84_5 = arg_81_1:FormatText(var_84_4.content)

				arg_81_1.text_.text = var_84_5

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_7 = 20 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_5) / 20)

				if (20 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_5) / 20)) > 0 and var_84_3 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_2
					end
				end

				arg_81_1.text_.text = var_84_5
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111020", "story_v_out_323111.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_323111", "323111020", "story_v_out_323111.awb") / 1000

					if var_84_8 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_2
					end

					if var_84_4.prefab_name ~= "" and arg_81_1.actors_[var_84_4.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_4.prefab_name].transform, "story_v_out_323111", "323111020", "story_v_out_323111.awb")

						arg_81_1:RecordAudio("323111020", var_84_9)
						arg_81_1:RecordAudio("323111020", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_323111", "323111020", "story_v_out_323111.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_323111", "323111020", "story_v_out_323111.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_3, arg_81_1.talkMaxDuration)

			if var_84_2 <= arg_81_1.time_ and arg_81_1.time_ < var_84_2 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_2) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_2 + var_84_10 and arg_81_1.time_ < var_84_2 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play323111021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 323111021
		arg_85_1.duration_ = 7.3

		local var_85_0 = {
			zh = 4.866,
			ja = 7.3
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
				arg_85_0:Play323111022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1053ui_story"]) and arg_85_1.var_.characterEffect1053ui_story == nil then
				arg_85_1.var_.characterEffect1053ui_story = arg_85_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["1053ui_story"]) then
				if arg_85_1.var_.characterEffect1053ui_story and not isNil(arg_85_1.actors_["1053ui_story"]) then
					arg_85_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_0)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["1053ui_story"]) and arg_85_1.var_.characterEffect1053ui_story then
				arg_85_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_88_1 = 0
			local var_88_2 = 0.55

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_3 = arg_85_1:GetWordFromCfg(323111021)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_6 = 22 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_4) / 22)

				if (22 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_4) / 22)) > 0 and var_88_2 < var_88_6 then
					arg_85_1.talkMaxDuration = var_88_6

					if var_88_6 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_6 + var_88_1
					end
				end

				arg_85_1.text_.text = var_88_4
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111021", "story_v_out_323111.awb") ~= 0 then
					local var_88_7 = manager.audio:GetVoiceLength("story_v_out_323111", "323111021", "story_v_out_323111.awb") / 1000

					if var_88_7 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_1
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_323111", "323111021", "story_v_out_323111.awb")

						arg_85_1:RecordAudio("323111021", var_88_8)
						arg_85_1:RecordAudio("323111021", var_88_8)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_323111", "323111021", "story_v_out_323111.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_323111", "323111021", "story_v_out_323111.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_9 = math.max(var_88_2, arg_85_1.talkMaxDuration)

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_9 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_1) / var_88_9

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_1 + var_88_9 and arg_85_1.time_ < var_88_1 + var_88_9 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play323111022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 323111022
		arg_89_1.duration_ = 10.97

		local var_89_0 = {
			zh = 10.966,
			ja = 10.2
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
				arg_89_0:Play323111023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 1.35

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_1 = arg_89_1:GetWordFromCfg(323111022)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 54 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 54)

				if (54 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 54)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111022", "story_v_out_323111.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_out_323111", "323111022", "story_v_out_323111.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_out_323111", "323111022", "story_v_out_323111.awb")

						arg_89_1:RecordAudio("323111022", var_92_6)
						arg_89_1:RecordAudio("323111022", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_323111", "323111022", "story_v_out_323111.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_323111", "323111022", "story_v_out_323111.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_7 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_7 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_7

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_7 and arg_89_1.time_ < 0 + var_92_7 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play323111023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 323111023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play323111024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1053ui_story = arg_93_1.actors_["1053ui_story"].transform.localPosition

				local var_96_0 = GameObjectTools.GetOrAddComponent(arg_93_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_96_0 then
					var_96_0:EnableDynamicBone(false)
				end
			end

			local var_96_1 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_1 then
				arg_93_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_93_1.time_ - 0) / var_96_1)
				arg_93_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1053ui_story"].transform.position).z)
				arg_93_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1053ui_story"].transform.localEulerAngles = arg_93_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_1 and arg_93_1.time_ < 0 + var_96_1 + arg_96_0 then
				arg_93_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_93_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1053ui_story"].transform.position).z)
				arg_93_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1053ui_story"].transform.localEulerAngles = arg_93_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_96_2 = GameObjectTools.GetOrAddComponent(arg_93_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_96_2 then
					var_96_2:EnableDynamicBone(true)
				end
			end

			local var_96_3 = 0
			local var_96_4 = 1.425

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_3 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_5 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(323111023).content)

				arg_93_1.text_.text = var_96_5

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_7 = 57 <= 0 and var_96_4 or var_96_4 * (utf8.len(var_96_5) / 57)

				if (57 <= 0 and var_96_4 or var_96_4 * (utf8.len(var_96_5) / 57)) > 0 and var_96_4 < var_96_7 then
					arg_93_1.talkMaxDuration = var_96_7

					if var_96_7 + var_96_3 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_3
					end
				end

				arg_93_1.text_.text = var_96_5
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_8 = math.max(var_96_4, arg_93_1.talkMaxDuration)

			if var_96_3 <= arg_93_1.time_ and arg_93_1.time_ < var_96_3 + var_96_8 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_3) / var_96_8

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_3 + var_96_8 and arg_93_1.time_ < var_96_3 + var_96_8 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play323111024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 323111024
		arg_97_1.duration_ = 15.97

		local var_97_0 = {
			zh = 9.566,
			ja = 15.966
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
				arg_97_0:Play323111025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1053ui_story = arg_97_1.actors_["1053ui_story"].transform.localPosition

				local var_100_0 = GameObjectTools.GetOrAddComponent(arg_97_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_100_0 then
					var_100_0:EnableDynamicBone(false)
				end
			end

			local var_100_1 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_1 then
				arg_97_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_97_1.time_ - 0) / var_100_1)
				arg_97_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1053ui_story"].transform.position).z)
				arg_97_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1053ui_story"].transform.localEulerAngles = arg_97_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_1 and arg_97_1.time_ < 0 + var_100_1 + arg_100_0 then
				arg_97_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_97_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1053ui_story"].transform.position).z)
				arg_97_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1053ui_story"].transform.localEulerAngles = arg_97_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_100_2 = GameObjectTools.GetOrAddComponent(arg_97_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_100_2 then
					var_100_2:EnableDynamicBone(true)
				end
			end

			local var_100_3 = arg_97_1.actors_["1053ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_3) and arg_97_1.var_.characterEffect1053ui_story == nil then
				arg_97_1.var_.characterEffect1053ui_story = var_100_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_4 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 and not isNil(var_100_3) then
				if arg_97_1.var_.characterEffect1053ui_story and not isNil(var_100_3) then
					arg_97_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 and not isNil(var_100_3) and arg_97_1.var_.characterEffect1053ui_story then
				arg_97_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action2_2")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_100_6 = 0
			local var_100_7 = 0.9

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[1453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_8 = arg_97_1:GetWordFromCfg(323111024)
				local var_100_9 = arg_97_1:FormatText(var_100_8.content)

				arg_97_1.text_.text = var_100_9

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_11 = 36 <= 0 and var_100_7 or var_100_7 * (utf8.len(var_100_9) / 36)

				if (36 <= 0 and var_100_7 or var_100_7 * (utf8.len(var_100_9) / 36)) > 0 and var_100_7 < var_100_11 then
					arg_97_1.talkMaxDuration = var_100_11

					if var_100_11 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_11 + var_100_6
					end
				end

				arg_97_1.text_.text = var_100_9
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111024", "story_v_out_323111.awb") ~= 0 then
					local var_100_12 = manager.audio:GetVoiceLength("story_v_out_323111", "323111024", "story_v_out_323111.awb") / 1000

					if var_100_12 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_12 + var_100_6
					end

					if var_100_8.prefab_name ~= "" and arg_97_1.actors_[var_100_8.prefab_name] ~= nil then
						local var_100_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_8.prefab_name].transform, "story_v_out_323111", "323111024", "story_v_out_323111.awb")

						arg_97_1:RecordAudio("323111024", var_100_13)
						arg_97_1:RecordAudio("323111024", var_100_13)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_323111", "323111024", "story_v_out_323111.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_323111", "323111024", "story_v_out_323111.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_14 = math.max(var_100_7, arg_97_1.talkMaxDuration)

			if var_100_6 <= arg_97_1.time_ and arg_97_1.time_ < var_100_6 + var_100_14 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_6) / var_100_14

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_6 + var_100_14 and arg_97_1.time_ < var_100_6 + var_100_14 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
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
	Play323111025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 323111025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play323111026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1053ui_story"]) and arg_101_1.var_.characterEffect1053ui_story == nil then
				arg_101_1.var_.characterEffect1053ui_story = arg_101_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1053ui_story"]) then
				if arg_101_1.var_.characterEffect1053ui_story and not isNil(arg_101_1.actors_["1053ui_story"]) then
					arg_101_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_0)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1053ui_story"]) and arg_101_1.var_.characterEffect1053ui_story then
				arg_101_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_104_1 = 0
			local var_104_2 = 0.6

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_3 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(323111025).content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 24 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 24)

				if (24 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 24)) > 0 and var_104_2 < var_104_5 then
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
	Play323111026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 323111026
		arg_105_1.duration_ = 12.2

		local var_105_0 = {
			zh = 11.333,
			ja = 12.2
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
				arg_105_0:Play323111027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.675

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_1 = arg_105_1:GetWordFromCfg(323111026)
				local var_108_2 = arg_105_1:FormatText(var_108_1.content)

				arg_105_1.text_.text = var_108_2

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 27 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 27)

				if (27 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 27)) > 0 and var_108_0 < var_108_4 then
					arg_105_1.talkMaxDuration = var_108_4

					if var_108_4 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_4 + 0
					end
				end

				arg_105_1.text_.text = var_108_2
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111026", "story_v_out_323111.awb") ~= 0 then
					local var_108_5 = manager.audio:GetVoiceLength("story_v_out_323111", "323111026", "story_v_out_323111.awb") / 1000

					if var_108_5 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + 0
					end

					if var_108_1.prefab_name ~= "" and arg_105_1.actors_[var_108_1.prefab_name] ~= nil then
						local var_108_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_1.prefab_name].transform, "story_v_out_323111", "323111026", "story_v_out_323111.awb")

						arg_105_1:RecordAudio("323111026", var_108_6)
						arg_105_1:RecordAudio("323111026", var_108_6)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_323111", "323111026", "story_v_out_323111.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_323111", "323111026", "story_v_out_323111.awb")
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
	Play323111027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 323111027
		arg_109_1.duration_ = 1.9

		local var_109_0 = {
			zh = 1.6,
			ja = 1.9
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
				arg_109_0:Play323111028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["1053ui_story"]) and arg_109_1.var_.characterEffect1053ui_story == nil then
				arg_109_1.var_.characterEffect1053ui_story = arg_109_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["1053ui_story"]) then
				if arg_109_1.var_.characterEffect1053ui_story and not isNil(arg_109_1.actors_["1053ui_story"]) then
					arg_109_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["1053ui_story"]) and arg_109_1.var_.characterEffect1053ui_story then
				arg_109_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_112_2 = 0
			local var_112_3 = 0.2

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[1453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_4 = arg_109_1:GetWordFromCfg(323111027)
				local var_112_5 = arg_109_1:FormatText(var_112_4.content)

				arg_109_1.text_.text = var_112_5

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_7 = 8 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 8)

				if (8 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 8)) > 0 and var_112_3 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_2
					end
				end

				arg_109_1.text_.text = var_112_5
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111027", "story_v_out_323111.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_323111", "323111027", "story_v_out_323111.awb") / 1000

					if var_112_8 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_2
					end

					if var_112_4.prefab_name ~= "" and arg_109_1.actors_[var_112_4.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_4.prefab_name].transform, "story_v_out_323111", "323111027", "story_v_out_323111.awb")

						arg_109_1:RecordAudio("323111027", var_112_9)
						arg_109_1:RecordAudio("323111027", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_323111", "323111027", "story_v_out_323111.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_323111", "323111027", "story_v_out_323111.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_10 = math.max(var_112_3, arg_109_1.talkMaxDuration)

			if var_112_2 <= arg_109_1.time_ and arg_109_1.time_ < var_112_2 + var_112_10 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_2) / var_112_10

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_2 + var_112_10 and arg_109_1.time_ < var_112_2 + var_112_10 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play323111028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 323111028
		arg_113_1.duration_ = 10.23

		local var_113_0 = {
			zh = 6.3,
			ja = 10.233
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
				arg_113_0:Play323111029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1053ui_story"]) and arg_113_1.var_.characterEffect1053ui_story == nil then
				arg_113_1.var_.characterEffect1053ui_story = arg_113_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["1053ui_story"]) then
				if arg_113_1.var_.characterEffect1053ui_story and not isNil(arg_113_1.actors_["1053ui_story"]) then
					arg_113_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_0)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["1053ui_story"]) and arg_113_1.var_.characterEffect1053ui_story then
				arg_113_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_116_1 = 0
			local var_116_2 = 0.7

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_3 = arg_113_1:GetWordFromCfg(323111028)
				local var_116_4 = arg_113_1:FormatText(var_116_3.content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_6 = 28 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_4) / 28)

				if (28 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_4) / 28)) > 0 and var_116_2 < var_116_6 then
					arg_113_1.talkMaxDuration = var_116_6

					if var_116_6 + var_116_1 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_6 + var_116_1
					end
				end

				arg_113_1.text_.text = var_116_4
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111028", "story_v_out_323111.awb") ~= 0 then
					local var_116_7 = manager.audio:GetVoiceLength("story_v_out_323111", "323111028", "story_v_out_323111.awb") / 1000

					if var_116_7 + var_116_1 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_1
					end

					if var_116_3.prefab_name ~= "" and arg_113_1.actors_[var_116_3.prefab_name] ~= nil then
						local var_116_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_3.prefab_name].transform, "story_v_out_323111", "323111028", "story_v_out_323111.awb")

						arg_113_1:RecordAudio("323111028", var_116_8)
						arg_113_1:RecordAudio("323111028", var_116_8)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_323111", "323111028", "story_v_out_323111.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_323111", "323111028", "story_v_out_323111.awb")
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
	Play323111029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 323111029
		arg_117_1.duration_ = 4.07

		local var_117_0 = {
			zh = 2.7,
			ja = 4.066
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
				arg_117_0:Play323111030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["1053ui_story"]) and arg_117_1.var_.characterEffect1053ui_story == nil then
				arg_117_1.var_.characterEffect1053ui_story = arg_117_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["1053ui_story"]) then
				if arg_117_1.var_.characterEffect1053ui_story and not isNil(arg_117_1.actors_["1053ui_story"]) then
					arg_117_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["1053ui_story"]) and arg_117_1.var_.characterEffect1053ui_story then
				arg_117_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action5_1")
			end

			local var_120_2 = 0
			local var_120_3 = 0.25

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_2 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[1453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_4 = arg_117_1:GetWordFromCfg(323111029)
				local var_120_5 = arg_117_1:FormatText(var_120_4.content)

				arg_117_1.text_.text = var_120_5

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_7 = 10 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_5) / 10)

				if (10 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_5) / 10)) > 0 and var_120_3 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_2
					end
				end

				arg_117_1.text_.text = var_120_5
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111029", "story_v_out_323111.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_out_323111", "323111029", "story_v_out_323111.awb") / 1000

					if var_120_8 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_2
					end

					if var_120_4.prefab_name ~= "" and arg_117_1.actors_[var_120_4.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_4.prefab_name].transform, "story_v_out_323111", "323111029", "story_v_out_323111.awb")

						arg_117_1:RecordAudio("323111029", var_120_9)
						arg_117_1:RecordAudio("323111029", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_323111", "323111029", "story_v_out_323111.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_323111", "323111029", "story_v_out_323111.awb")
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
	Play323111030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 323111030
		arg_121_1.duration_ = 2.7

		local var_121_0 = {
			zh = 2.7,
			ja = 2.333
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
				arg_121_0:Play323111031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["1053ui_story"]) and arg_121_1.var_.characterEffect1053ui_story == nil then
				arg_121_1.var_.characterEffect1053ui_story = arg_121_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["1053ui_story"]) then
				if arg_121_1.var_.characterEffect1053ui_story and not isNil(arg_121_1.actors_["1053ui_story"]) then
					arg_121_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_0)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["1053ui_story"]) and arg_121_1.var_.characterEffect1053ui_story then
				arg_121_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_124_1 = 0
			local var_124_2 = 0.125

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_3 = arg_121_1:GetWordFromCfg(323111030)
				local var_124_4 = arg_121_1:FormatText(var_124_3.content)

				arg_121_1.text_.text = var_124_4

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_6 = 5 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_4) / 5)

				if (5 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_4) / 5)) > 0 and var_124_2 < var_124_6 then
					arg_121_1.talkMaxDuration = var_124_6

					if var_124_6 + var_124_1 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_6 + var_124_1
					end
				end

				arg_121_1.text_.text = var_124_4
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111030", "story_v_out_323111.awb") ~= 0 then
					local var_124_7 = manager.audio:GetVoiceLength("story_v_out_323111", "323111030", "story_v_out_323111.awb") / 1000

					if var_124_7 + var_124_1 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_7 + var_124_1
					end

					if var_124_3.prefab_name ~= "" and arg_121_1.actors_[var_124_3.prefab_name] ~= nil then
						local var_124_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_3.prefab_name].transform, "story_v_out_323111", "323111030", "story_v_out_323111.awb")

						arg_121_1:RecordAudio("323111030", var_124_8)
						arg_121_1:RecordAudio("323111030", var_124_8)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_323111", "323111030", "story_v_out_323111.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_323111", "323111030", "story_v_out_323111.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_9 = math.max(var_124_2, arg_121_1.talkMaxDuration)

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_9 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_1) / var_124_9

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_1 + var_124_9 and arg_121_1.time_ < var_124_1 + var_124_9 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play323111031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 323111031
		arg_125_1.duration_ = 8.13

		local var_125_0 = {
			zh = 6.2,
			ja = 8.133
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
				arg_125_0:Play323111032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["1053ui_story"]) and arg_125_1.var_.characterEffect1053ui_story == nil then
				arg_125_1.var_.characterEffect1053ui_story = arg_125_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["1053ui_story"]) then
				if arg_125_1.var_.characterEffect1053ui_story and not isNil(arg_125_1.actors_["1053ui_story"]) then
					arg_125_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["1053ui_story"]) and arg_125_1.var_.characterEffect1053ui_story then
				arg_125_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_128_2 = 0
			local var_128_3 = 0.65

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_2 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[1453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_4 = arg_125_1:GetWordFromCfg(323111031)
				local var_128_5 = arg_125_1:FormatText(var_128_4.content)

				arg_125_1.text_.text = var_128_5

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_7 = 26 <= 0 and var_128_3 or var_128_3 * (utf8.len(var_128_5) / 26)

				if (26 <= 0 and var_128_3 or var_128_3 * (utf8.len(var_128_5) / 26)) > 0 and var_128_3 < var_128_7 then
					arg_125_1.talkMaxDuration = var_128_7

					if var_128_7 + var_128_2 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_7 + var_128_2
					end
				end

				arg_125_1.text_.text = var_128_5
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111031", "story_v_out_323111.awb") ~= 0 then
					local var_128_8 = manager.audio:GetVoiceLength("story_v_out_323111", "323111031", "story_v_out_323111.awb") / 1000

					if var_128_8 + var_128_2 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_8 + var_128_2
					end

					if var_128_4.prefab_name ~= "" and arg_125_1.actors_[var_128_4.prefab_name] ~= nil then
						local var_128_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_4.prefab_name].transform, "story_v_out_323111", "323111031", "story_v_out_323111.awb")

						arg_125_1:RecordAudio("323111031", var_128_9)
						arg_125_1:RecordAudio("323111031", var_128_9)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_323111", "323111031", "story_v_out_323111.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_323111", "323111031", "story_v_out_323111.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_10 = math.max(var_128_3, arg_125_1.talkMaxDuration)

			if var_128_2 <= arg_125_1.time_ and arg_125_1.time_ < var_128_2 + var_128_10 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_2) / var_128_10

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_2 + var_128_10 and arg_125_1.time_ < var_128_2 + var_128_10 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play323111032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 323111032
		arg_129_1.duration_ = 11.9

		local var_129_0 = {
			zh = 8.1,
			ja = 11.9
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
				arg_129_0:Play323111033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053actionlink/1053action453")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_132_0 = 0
			local var_132_1 = 0.9

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[1453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_2 = arg_129_1:GetWordFromCfg(323111032)
				local var_132_3 = arg_129_1:FormatText(var_132_2.content)

				arg_129_1.text_.text = var_132_3

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 36 <= 0 and var_132_1 or var_132_1 * (utf8.len(var_132_3) / 36)

				if (36 <= 0 and var_132_1 or var_132_1 * (utf8.len(var_132_3) / 36)) > 0 and var_132_1 < var_132_5 then
					arg_129_1.talkMaxDuration = var_132_5

					if var_132_5 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + var_132_0
					end
				end

				arg_129_1.text_.text = var_132_3
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111032", "story_v_out_323111.awb") ~= 0 then
					local var_132_6 = manager.audio:GetVoiceLength("story_v_out_323111", "323111032", "story_v_out_323111.awb") / 1000

					if var_132_6 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_6 + var_132_0
					end

					if var_132_2.prefab_name ~= "" and arg_129_1.actors_[var_132_2.prefab_name] ~= nil then
						local var_132_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_2.prefab_name].transform, "story_v_out_323111", "323111032", "story_v_out_323111.awb")

						arg_129_1:RecordAudio("323111032", var_132_7)
						arg_129_1:RecordAudio("323111032", var_132_7)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_323111", "323111032", "story_v_out_323111.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_323111", "323111032", "story_v_out_323111.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_8 = math.max(var_132_1, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_8 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_0) / var_132_8

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_8 and arg_129_1.time_ < var_132_0 + var_132_8 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play323111033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 323111033
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play323111034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["1053ui_story"]) and arg_133_1.var_.characterEffect1053ui_story == nil then
				arg_133_1.var_.characterEffect1053ui_story = arg_133_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["1053ui_story"]) then
				if arg_133_1.var_.characterEffect1053ui_story and not isNil(arg_133_1.actors_["1053ui_story"]) then
					arg_133_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_0)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["1053ui_story"]) and arg_133_1.var_.characterEffect1053ui_story then
				arg_133_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_136_1 = arg_133_1.actors_["1053ui_story"].transform

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1053ui_story = var_136_1.localPosition

				local var_136_2 = GameObjectTools.GetOrAddComponent(var_136_1.gameObject, typeof(DynamicBoneHelper))

				if var_136_2 then
					var_136_2:EnableDynamicBone(false)
				end
			end

			local var_136_3 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_3 then
				var_136_1.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_133_1.time_ - 0) / var_136_3)
				var_136_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_1.position).x, (manager.ui.mainCamera.transform.position - var_136_1.position).y, (manager.ui.mainCamera.transform.position - var_136_1.position).z)
				var_136_1.localEulerAngles.z = 0
				var_136_1.localEulerAngles.x = 0
				var_136_1.localEulerAngles = var_136_1.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_3 and arg_133_1.time_ < 0 + var_136_3 + arg_136_0 then
				var_136_1.localPosition = Vector3.New(0, 100, 0)
				var_136_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_1.position).x, (manager.ui.mainCamera.transform.position - var_136_1.position).y, (manager.ui.mainCamera.transform.position - var_136_1.position).z)
				var_136_1.localEulerAngles.z = 0
				var_136_1.localEulerAngles.x = 0
				var_136_1.localEulerAngles = var_136_1.localEulerAngles

				local var_136_4 = GameObjectTools.GetOrAddComponent(var_136_1.gameObject, typeof(DynamicBoneHelper))

				if var_136_4 then
					var_136_4:EnableDynamicBone(true)
				end
			end

			local var_136_5 = 0
			local var_136_6 = 1.15

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_5 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_7 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(323111033).content)

				arg_133_1.text_.text = var_136_7

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_9 = 46 <= 0 and var_136_6 or var_136_6 * (utf8.len(var_136_7) / 46)

				if (46 <= 0 and var_136_6 or var_136_6 * (utf8.len(var_136_7) / 46)) > 0 and var_136_6 < var_136_9 then
					arg_133_1.talkMaxDuration = var_136_9

					if var_136_9 + var_136_5 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_9 + var_136_5
					end
				end

				arg_133_1.text_.text = var_136_7
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_10 = math.max(var_136_6, arg_133_1.talkMaxDuration)

			if var_136_5 <= arg_133_1.time_ and arg_133_1.time_ < var_136_5 + var_136_10 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_5) / var_136_10

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_5 + var_136_10 and arg_133_1.time_ < var_136_5 + var_136_10 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
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
	Play323111034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 323111034
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play323111035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0.625

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_1 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(323111034).content)

				arg_137_1.text_.text = var_140_1

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_3 = 25 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 25)

				if (25 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 25)) > 0 and var_140_0 < var_140_3 then
					arg_137_1.talkMaxDuration = var_140_3

					if var_140_3 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_3 + 0
					end
				end

				arg_137_1.text_.text = var_140_1
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_4 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_4 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_4

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_4 and arg_137_1.time_ < 0 + var_140_4 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play323111035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 323111035
		arg_141_1.duration_ = 5.2

		local var_141_0 = {
			zh = 2.4,
			ja = 5.2
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
				arg_141_0:Play323111036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0.275

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_1 = arg_141_1:GetWordFromCfg(323111035)
				local var_144_2 = arg_141_1:FormatText(var_144_1.content)

				arg_141_1.text_.text = var_144_2

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_4 = 11 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 11)

				if (11 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 11)) > 0 and var_144_0 < var_144_4 then
					arg_141_1.talkMaxDuration = var_144_4

					if var_144_4 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_4 + 0
					end
				end

				arg_141_1.text_.text = var_144_2
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111035", "story_v_out_323111.awb") ~= 0 then
					local var_144_5 = manager.audio:GetVoiceLength("story_v_out_323111", "323111035", "story_v_out_323111.awb") / 1000

					if var_144_5 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + 0
					end

					if var_144_1.prefab_name ~= "" and arg_141_1.actors_[var_144_1.prefab_name] ~= nil then
						local var_144_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_1.prefab_name].transform, "story_v_out_323111", "323111035", "story_v_out_323111.awb")

						arg_141_1:RecordAudio("323111035", var_144_6)
						arg_141_1:RecordAudio("323111035", var_144_6)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_323111", "323111035", "story_v_out_323111.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_323111", "323111035", "story_v_out_323111.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_7 = math.max(var_144_0, arg_141_1.talkMaxDuration)

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_7 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - 0) / var_144_7

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= 0 + var_144_7 and arg_141_1.time_ < 0 + var_144_7 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play323111036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 323111036
		arg_145_1.duration_ = 7.7

		local var_145_0 = {
			zh = 6.733,
			ja = 7.7
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
				arg_145_0:Play323111037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1053ui_story = arg_145_1.actors_["1053ui_story"].transform.localPosition

				local var_148_0 = GameObjectTools.GetOrAddComponent(arg_145_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_148_0 then
					var_148_0:EnableDynamicBone(false)
				end
			end

			local var_148_1 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_1 then
				arg_145_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_145_1.time_ - 0) / var_148_1)
				arg_145_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1053ui_story"].transform.position).z)
				arg_145_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1053ui_story"].transform.localEulerAngles = arg_145_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_1 and arg_145_1.time_ < 0 + var_148_1 + arg_148_0 then
				arg_145_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_145_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1053ui_story"].transform.position).z)
				arg_145_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1053ui_story"].transform.localEulerAngles = arg_145_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_148_2 = GameObjectTools.GetOrAddComponent(arg_145_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_148_2 then
					var_148_2:EnableDynamicBone(true)
				end
			end

			local var_148_3 = arg_145_1.actors_["1053ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_3) and arg_145_1.var_.characterEffect1053ui_story == nil then
				arg_145_1.var_.characterEffect1053ui_story = var_148_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_4 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_4 and not isNil(var_148_3) then
				if arg_145_1.var_.characterEffect1053ui_story and not isNil(var_148_3) then
					arg_145_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_4 and arg_145_1.time_ < 0 + var_148_4 + arg_148_0 and not isNil(var_148_3) and arg_145_1.var_.characterEffect1053ui_story then
				arg_145_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action3_2")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_148_6 = 0
			local var_148_7 = 0.65

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_6 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[1453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_8 = arg_145_1:GetWordFromCfg(323111036)
				local var_148_9 = arg_145_1:FormatText(var_148_8.content)

				arg_145_1.text_.text = var_148_9

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_11 = 26 <= 0 and var_148_7 or var_148_7 * (utf8.len(var_148_9) / 26)

				if (26 <= 0 and var_148_7 or var_148_7 * (utf8.len(var_148_9) / 26)) > 0 and var_148_7 < var_148_11 then
					arg_145_1.talkMaxDuration = var_148_11

					if var_148_11 + var_148_6 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_11 + var_148_6
					end
				end

				arg_145_1.text_.text = var_148_9
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111036", "story_v_out_323111.awb") ~= 0 then
					local var_148_12 = manager.audio:GetVoiceLength("story_v_out_323111", "323111036", "story_v_out_323111.awb") / 1000

					if var_148_12 + var_148_6 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_12 + var_148_6
					end

					if var_148_8.prefab_name ~= "" and arg_145_1.actors_[var_148_8.prefab_name] ~= nil then
						local var_148_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_8.prefab_name].transform, "story_v_out_323111", "323111036", "story_v_out_323111.awb")

						arg_145_1:RecordAudio("323111036", var_148_13)
						arg_145_1:RecordAudio("323111036", var_148_13)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_323111", "323111036", "story_v_out_323111.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_323111", "323111036", "story_v_out_323111.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_14 = math.max(var_148_7, arg_145_1.talkMaxDuration)

			if var_148_6 <= arg_145_1.time_ and arg_145_1.time_ < var_148_6 + var_148_14 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_6) / var_148_14

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_6 + var_148_14 and arg_145_1.time_ < var_148_6 + var_148_14 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
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
	Play323111037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 323111037
		arg_149_1.duration_ = 13.67

		local var_149_0 = {
			zh = 8.2,
			ja = 13.666
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
				arg_149_0:Play323111038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["1053ui_story"]) and arg_149_1.var_.characterEffect1053ui_story == nil then
				arg_149_1.var_.characterEffect1053ui_story = arg_149_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_0 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["1053ui_story"]) then
				if arg_149_1.var_.characterEffect1053ui_story and not isNil(arg_149_1.actors_["1053ui_story"]) then
					arg_149_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_0)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["1053ui_story"]) and arg_149_1.var_.characterEffect1053ui_story then
				arg_149_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_152_1 = 0
			local var_152_2 = 0.775

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_3 = arg_149_1:GetWordFromCfg(323111037)
				local var_152_4 = arg_149_1:FormatText(var_152_3.content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_6 = 31 <= 0 and var_152_2 or var_152_2 * (utf8.len(var_152_4) / 31)

				if (31 <= 0 and var_152_2 or var_152_2 * (utf8.len(var_152_4) / 31)) > 0 and var_152_2 < var_152_6 then
					arg_149_1.talkMaxDuration = var_152_6

					if var_152_6 + var_152_1 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_6 + var_152_1
					end
				end

				arg_149_1.text_.text = var_152_4
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111037", "story_v_out_323111.awb") ~= 0 then
					local var_152_7 = manager.audio:GetVoiceLength("story_v_out_323111", "323111037", "story_v_out_323111.awb") / 1000

					if var_152_7 + var_152_1 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_7 + var_152_1
					end

					if var_152_3.prefab_name ~= "" and arg_149_1.actors_[var_152_3.prefab_name] ~= nil then
						local var_152_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_3.prefab_name].transform, "story_v_out_323111", "323111037", "story_v_out_323111.awb")

						arg_149_1:RecordAudio("323111037", var_152_8)
						arg_149_1:RecordAudio("323111037", var_152_8)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_323111", "323111037", "story_v_out_323111.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_323111", "323111037", "story_v_out_323111.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_9 = math.max(var_152_2, arg_149_1.talkMaxDuration)

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_9 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_1) / var_152_9

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_1 + var_152_9 and arg_149_1.time_ < var_152_1 + var_152_9 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play323111038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 323111038
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play323111039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0.325

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
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

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_1 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(323111038).content)

				arg_153_1.text_.text = var_156_1

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_3 = 13 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_1) / 13)

				if (13 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_1) / 13)) > 0 and var_156_0 < var_156_3 then
					arg_153_1.talkMaxDuration = var_156_3

					if var_156_3 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_3 + 0
					end
				end

				arg_153_1.text_.text = var_156_1
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_4 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_4 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_4

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_4 and arg_153_1.time_ < 0 + var_156_4 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play323111039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 323111039
		arg_157_1.duration_ = 17.5

		local var_157_0 = {
			zh = 9.366,
			ja = 17.5
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
				arg_157_0:Play323111040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.975

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_1 = arg_157_1:GetWordFromCfg(323111039)
				local var_160_2 = arg_157_1:FormatText(var_160_1.content)

				arg_157_1.text_.text = var_160_2

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_4 = 39 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 39)

				if (39 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 39)) > 0 and var_160_0 < var_160_4 then
					arg_157_1.talkMaxDuration = var_160_4

					if var_160_4 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_4 + 0
					end
				end

				arg_157_1.text_.text = var_160_2
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111039", "story_v_out_323111.awb") ~= 0 then
					local var_160_5 = manager.audio:GetVoiceLength("story_v_out_323111", "323111039", "story_v_out_323111.awb") / 1000

					if var_160_5 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + 0
					end

					if var_160_1.prefab_name ~= "" and arg_157_1.actors_[var_160_1.prefab_name] ~= nil then
						local var_160_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_1.prefab_name].transform, "story_v_out_323111", "323111039", "story_v_out_323111.awb")

						arg_157_1:RecordAudio("323111039", var_160_6)
						arg_157_1:RecordAudio("323111039", var_160_6)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_323111", "323111039", "story_v_out_323111.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_323111", "323111039", "story_v_out_323111.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_7 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_7 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_7

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_7 and arg_157_1.time_ < 0 + var_160_7 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play323111040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 323111040
		arg_161_1.duration_ = 11.43

		local var_161_0 = {
			zh = 11.433,
			ja = 8.566
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
				arg_161_0:Play323111041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.95

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_1 = arg_161_1:GetWordFromCfg(323111040)
				local var_164_2 = arg_161_1:FormatText(var_164_1.content)

				arg_161_1.text_.text = var_164_2

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 38 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 38)

				if (38 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 38)) > 0 and var_164_0 < var_164_4 then
					arg_161_1.talkMaxDuration = var_164_4

					if var_164_4 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_4 + 0
					end
				end

				arg_161_1.text_.text = var_164_2
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111040", "story_v_out_323111.awb") ~= 0 then
					local var_164_5 = manager.audio:GetVoiceLength("story_v_out_323111", "323111040", "story_v_out_323111.awb") / 1000

					if var_164_5 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + 0
					end

					if var_164_1.prefab_name ~= "" and arg_161_1.actors_[var_164_1.prefab_name] ~= nil then
						local var_164_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_1.prefab_name].transform, "story_v_out_323111", "323111040", "story_v_out_323111.awb")

						arg_161_1:RecordAudio("323111040", var_164_6)
						arg_161_1:RecordAudio("323111040", var_164_6)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_323111", "323111040", "story_v_out_323111.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_323111", "323111040", "story_v_out_323111.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_7 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_7 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_7

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_7 and arg_161_1.time_ < 0 + var_164_7 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play323111041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 323111041
		arg_165_1.duration_ = 6.9

		local var_165_0 = {
			zh = 5.866,
			ja = 6.9
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
				arg_165_0:Play323111042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["1053ui_story"]) and arg_165_1.var_.characterEffect1053ui_story == nil then
				arg_165_1.var_.characterEffect1053ui_story = arg_165_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_0 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["1053ui_story"]) then
				if arg_165_1.var_.characterEffect1053ui_story and not isNil(arg_165_1.actors_["1053ui_story"]) then
					arg_165_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["1053ui_story"]) and arg_165_1.var_.characterEffect1053ui_story then
				arg_165_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_168_2 = 0
			local var_168_3 = 0.725

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_2 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[1453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_4 = arg_165_1:GetWordFromCfg(323111041)
				local var_168_5 = arg_165_1:FormatText(var_168_4.content)

				arg_165_1.text_.text = var_168_5

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_7 = 29 <= 0 and var_168_3 or var_168_3 * (utf8.len(var_168_5) / 29)

				if (29 <= 0 and var_168_3 or var_168_3 * (utf8.len(var_168_5) / 29)) > 0 and var_168_3 < var_168_7 then
					arg_165_1.talkMaxDuration = var_168_7

					if var_168_7 + var_168_2 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_7 + var_168_2
					end
				end

				arg_165_1.text_.text = var_168_5
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111041", "story_v_out_323111.awb") ~= 0 then
					local var_168_8 = manager.audio:GetVoiceLength("story_v_out_323111", "323111041", "story_v_out_323111.awb") / 1000

					if var_168_8 + var_168_2 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_8 + var_168_2
					end

					if var_168_4.prefab_name ~= "" and arg_165_1.actors_[var_168_4.prefab_name] ~= nil then
						local var_168_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_4.prefab_name].transform, "story_v_out_323111", "323111041", "story_v_out_323111.awb")

						arg_165_1:RecordAudio("323111041", var_168_9)
						arg_165_1:RecordAudio("323111041", var_168_9)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_323111", "323111041", "story_v_out_323111.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_323111", "323111041", "story_v_out_323111.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_10 = math.max(var_168_3, arg_165_1.talkMaxDuration)

			if var_168_2 <= arg_165_1.time_ and arg_165_1.time_ < var_168_2 + var_168_10 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_2) / var_168_10

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_2 + var_168_10 and arg_165_1.time_ < var_168_2 + var_168_10 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play323111042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 323111042
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play323111043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1053ui_story = arg_169_1.actors_["1053ui_story"].transform.localPosition

				local var_172_0 = GameObjectTools.GetOrAddComponent(arg_169_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_172_0 then
					var_172_0:EnableDynamicBone(false)
				end
			end

			local var_172_1 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_1 then
				arg_169_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_169_1.time_ - 0) / var_172_1)
				arg_169_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1053ui_story"].transform.position).z)
				arg_169_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1053ui_story"].transform.localEulerAngles = arg_169_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_1 and arg_169_1.time_ < 0 + var_172_1 + arg_172_0 then
				arg_169_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_169_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1053ui_story"].transform.position).z)
				arg_169_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1053ui_story"].transform.localEulerAngles = arg_169_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_172_2 = GameObjectTools.GetOrAddComponent(arg_169_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_172_2 then
					var_172_2:EnableDynamicBone(true)
				end
			end

			local var_172_3 = arg_169_1.actors_["1053ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_3) and arg_169_1.var_.characterEffect1053ui_story == nil then
				arg_169_1.var_.characterEffect1053ui_story = var_172_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_4 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 and not isNil(var_172_3) then
				if arg_169_1.var_.characterEffect1053ui_story and not isNil(var_172_3) then
					arg_169_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_4)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 and not isNil(var_172_3) and arg_169_1.var_.characterEffect1053ui_story then
				arg_169_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_172_5 = 0
			local var_172_6 = 1.4

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_5 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_7 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(323111042).content)

				arg_169_1.text_.text = var_172_7

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_9 = 56 <= 0 and var_172_6 or var_172_6 * (utf8.len(var_172_7) / 56)

				if (56 <= 0 and var_172_6 or var_172_6 * (utf8.len(var_172_7) / 56)) > 0 and var_172_6 < var_172_9 then
					arg_169_1.talkMaxDuration = var_172_9

					if var_172_9 + var_172_5 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_9 + var_172_5
					end
				end

				arg_169_1.text_.text = var_172_7
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_10 = math.max(var_172_6, arg_169_1.talkMaxDuration)

			if var_172_5 <= arg_169_1.time_ and arg_169_1.time_ < var_172_5 + var_172_10 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_5) / var_172_10

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_5 + var_172_10 and arg_169_1.time_ < var_172_5 + var_172_10 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
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
	Play323111043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 323111043
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play323111044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0.375

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
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

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_1 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(323111043).content)

				arg_173_1.text_.text = var_176_1

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_3 = 15 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 15)

				if (15 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 15)) > 0 and var_176_0 < var_176_3 then
					arg_173_1.talkMaxDuration = var_176_3

					if var_176_3 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_3 + 0
					end
				end

				arg_173_1.text_.text = var_176_1
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_4 = math.max(var_176_0, arg_173_1.talkMaxDuration)

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_4 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - 0) / var_176_4

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= 0 + var_176_4 and arg_173_1.time_ < 0 + var_176_4 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play323111044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 323111044
		arg_177_1.duration_ = 2.93

		local var_177_0 = {
			zh = 1.8,
			ja = 2.933
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
				arg_177_0:Play323111045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0.15

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_1 = arg_177_1:GetWordFromCfg(323111044)
				local var_180_2 = arg_177_1:FormatText(var_180_1.content)

				arg_177_1.text_.text = var_180_2

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_4 = 6 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 6)

				if (6 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 6)) > 0 and var_180_0 < var_180_4 then
					arg_177_1.talkMaxDuration = var_180_4

					if var_180_4 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_4 + 0
					end
				end

				arg_177_1.text_.text = var_180_2
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111044", "story_v_out_323111.awb") ~= 0 then
					local var_180_5 = manager.audio:GetVoiceLength("story_v_out_323111", "323111044", "story_v_out_323111.awb") / 1000

					if var_180_5 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + 0
					end

					if var_180_1.prefab_name ~= "" and arg_177_1.actors_[var_180_1.prefab_name] ~= nil then
						local var_180_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_1.prefab_name].transform, "story_v_out_323111", "323111044", "story_v_out_323111.awb")

						arg_177_1:RecordAudio("323111044", var_180_6)
						arg_177_1:RecordAudio("323111044", var_180_6)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_323111", "323111044", "story_v_out_323111.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_323111", "323111044", "story_v_out_323111.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_7 = math.max(var_180_0, arg_177_1.talkMaxDuration)

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_7 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - 0) / var_180_7

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= 0 + var_180_7 and arg_177_1.time_ < 0 + var_180_7 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play323111045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 323111045
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play323111046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 1.275

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

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_1 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(323111045).content)

				arg_181_1.text_.text = var_184_1

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_3 = 51 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 51)

				if (51 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 51)) > 0 and var_184_0 < var_184_3 then
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
	Play323111046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 323111046
		arg_185_1.duration_ = 5.3

		local var_185_0 = {
			zh = 3.066,
			ja = 5.3
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
				arg_185_0:Play323111047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0.35

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_1 = arg_185_1:GetWordFromCfg(323111046)
				local var_188_2 = arg_185_1:FormatText(var_188_1.content)

				arg_185_1.text_.text = var_188_2

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 14 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 14)

				if (14 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 14)) > 0 and var_188_0 < var_188_4 then
					arg_185_1.talkMaxDuration = var_188_4

					if var_188_4 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_4 + 0
					end
				end

				arg_185_1.text_.text = var_188_2
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111046", "story_v_out_323111.awb") ~= 0 then
					local var_188_5 = manager.audio:GetVoiceLength("story_v_out_323111", "323111046", "story_v_out_323111.awb") / 1000

					if var_188_5 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + 0
					end

					if var_188_1.prefab_name ~= "" and arg_185_1.actors_[var_188_1.prefab_name] ~= nil then
						local var_188_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_1.prefab_name].transform, "story_v_out_323111", "323111046", "story_v_out_323111.awb")

						arg_185_1:RecordAudio("323111046", var_188_6)
						arg_185_1:RecordAudio("323111046", var_188_6)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_323111", "323111046", "story_v_out_323111.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_323111", "323111046", "story_v_out_323111.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_7 and arg_185_1.time_ < 0 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play323111047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 323111047
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play323111048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0.075

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
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

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_1 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(323111047).content)

				arg_189_1.text_.text = var_192_1

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_3 = 3 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_1) / 3)

				if (3 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_1) / 3)) > 0 and var_192_0 < var_192_3 then
					arg_189_1.talkMaxDuration = var_192_3

					if var_192_3 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_3 + 0
					end
				end

				arg_189_1.text_.text = var_192_1
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_4 = math.max(var_192_0, arg_189_1.talkMaxDuration)

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_4 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - 0) / var_192_4

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= 0 + var_192_4 and arg_189_1.time_ < 0 + var_192_4 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play323111048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 323111048
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play323111049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0.9

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

				local var_196_1 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(323111048).content)

				arg_193_1.text_.text = var_196_1

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_3 = 36 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 36)

				if (36 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 36)) > 0 and var_196_0 < var_196_3 then
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
	Play323111049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 323111049
		arg_197_1.duration_ = 9.23

		local var_197_0 = {
			zh = 9.233,
			ja = 8.633
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
				arg_197_0:Play323111050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1053ui_story = arg_197_1.actors_["1053ui_story"].transform.localPosition

				local var_200_0 = GameObjectTools.GetOrAddComponent(arg_197_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_200_0 then
					var_200_0:EnableDynamicBone(false)
				end
			end

			local var_200_1 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_1 then
				arg_197_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_197_1.time_ - 0) / var_200_1)
				arg_197_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1053ui_story"].transform.position).z)
				arg_197_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1053ui_story"].transform.localEulerAngles = arg_197_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_1 and arg_197_1.time_ < 0 + var_200_1 + arg_200_0 then
				arg_197_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_197_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1053ui_story"].transform.position).z)
				arg_197_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1053ui_story"].transform.localEulerAngles = arg_197_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_200_2 = GameObjectTools.GetOrAddComponent(arg_197_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_200_2 then
					var_200_2:EnableDynamicBone(true)
				end
			end

			local var_200_3 = arg_197_1.actors_["1053ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_3) and arg_197_1.var_.characterEffect1053ui_story == nil then
				arg_197_1.var_.characterEffect1053ui_story = var_200_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_4 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_4 and not isNil(var_200_3) then
				if arg_197_1.var_.characterEffect1053ui_story and not isNil(var_200_3) then
					arg_197_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_4 and arg_197_1.time_ < 0 + var_200_4 + arg_200_0 and not isNil(var_200_3) and arg_197_1.var_.characterEffect1053ui_story then
				arg_197_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action3_1")
			end

			local var_200_6 = 0
			local var_200_7 = 0.925

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_6 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[1453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_8 = arg_197_1:GetWordFromCfg(323111049)
				local var_200_9 = arg_197_1:FormatText(var_200_8.content)

				arg_197_1.text_.text = var_200_9

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_11 = 37 <= 0 and var_200_7 or var_200_7 * (utf8.len(var_200_9) / 37)

				if (37 <= 0 and var_200_7 or var_200_7 * (utf8.len(var_200_9) / 37)) > 0 and var_200_7 < var_200_11 then
					arg_197_1.talkMaxDuration = var_200_11

					if var_200_11 + var_200_6 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_11 + var_200_6
					end
				end

				arg_197_1.text_.text = var_200_9
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111049", "story_v_out_323111.awb") ~= 0 then
					local var_200_12 = manager.audio:GetVoiceLength("story_v_out_323111", "323111049", "story_v_out_323111.awb") / 1000

					if var_200_12 + var_200_6 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_12 + var_200_6
					end

					if var_200_8.prefab_name ~= "" and arg_197_1.actors_[var_200_8.prefab_name] ~= nil then
						local var_200_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_8.prefab_name].transform, "story_v_out_323111", "323111049", "story_v_out_323111.awb")

						arg_197_1:RecordAudio("323111049", var_200_13)
						arg_197_1:RecordAudio("323111049", var_200_13)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_323111", "323111049", "story_v_out_323111.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_323111", "323111049", "story_v_out_323111.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_14 = math.max(var_200_7, arg_197_1.talkMaxDuration)

			if var_200_6 <= arg_197_1.time_ and arg_197_1.time_ < var_200_6 + var_200_14 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_6) / var_200_14

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_6 + var_200_14 and arg_197_1.time_ < var_200_6 + var_200_14 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play323111050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 323111050
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play323111051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(arg_201_1.actors_["1053ui_story"]) and arg_201_1.var_.characterEffect1053ui_story == nil then
				arg_201_1.var_.characterEffect1053ui_story = arg_201_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_0 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 and not isNil(arg_201_1.actors_["1053ui_story"]) then
				if arg_201_1.var_.characterEffect1053ui_story and not isNil(arg_201_1.actors_["1053ui_story"]) then
					arg_201_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_201_1.time_ - 0) / var_204_0)
				end
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 and not isNil(arg_201_1.actors_["1053ui_story"]) and arg_201_1.var_.characterEffect1053ui_story then
				arg_201_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_204_1 = 0
			local var_204_2 = 0.6

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
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

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_3 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(323111050).content)

				arg_201_1.text_.text = var_204_3

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 24 <= 0 and var_204_2 or var_204_2 * (utf8.len(var_204_3) / 24)

				if (24 <= 0 and var_204_2 or var_204_2 * (utf8.len(var_204_3) / 24)) > 0 and var_204_2 < var_204_5 then
					arg_201_1.talkMaxDuration = var_204_5

					if var_204_5 + var_204_1 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + var_204_1
					end
				end

				arg_201_1.text_.text = var_204_3
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_6 = math.max(var_204_2, arg_201_1.talkMaxDuration)

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_6 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_1) / var_204_6

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_1 + var_204_6 and arg_201_1.time_ < var_204_1 + var_204_6 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play323111051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 323111051
		arg_205_1.duration_ = 5.5

		local var_205_0 = {
			zh = 3.933,
			ja = 5.5
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
				arg_205_0:Play323111052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(arg_205_1.actors_["1053ui_story"]) and arg_205_1.var_.characterEffect1053ui_story == nil then
				arg_205_1.var_.characterEffect1053ui_story = arg_205_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_0 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 and not isNil(arg_205_1.actors_["1053ui_story"]) then
				if arg_205_1.var_.characterEffect1053ui_story and not isNil(arg_205_1.actors_["1053ui_story"]) then
					arg_205_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 and not isNil(arg_205_1.actors_["1053ui_story"]) and arg_205_1.var_.characterEffect1053ui_story then
				arg_205_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_208_2 = 0
			local var_208_3 = 0.45

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_2 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[1453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_4 = arg_205_1:GetWordFromCfg(323111051)
				local var_208_5 = arg_205_1:FormatText(var_208_4.content)

				arg_205_1.text_.text = var_208_5

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_7 = 18 <= 0 and var_208_3 or var_208_3 * (utf8.len(var_208_5) / 18)

				if (18 <= 0 and var_208_3 or var_208_3 * (utf8.len(var_208_5) / 18)) > 0 and var_208_3 < var_208_7 then
					arg_205_1.talkMaxDuration = var_208_7

					if var_208_7 + var_208_2 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_7 + var_208_2
					end
				end

				arg_205_1.text_.text = var_208_5
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111051", "story_v_out_323111.awb") ~= 0 then
					local var_208_8 = manager.audio:GetVoiceLength("story_v_out_323111", "323111051", "story_v_out_323111.awb") / 1000

					if var_208_8 + var_208_2 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_8 + var_208_2
					end

					if var_208_4.prefab_name ~= "" and arg_205_1.actors_[var_208_4.prefab_name] ~= nil then
						local var_208_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_4.prefab_name].transform, "story_v_out_323111", "323111051", "story_v_out_323111.awb")

						arg_205_1:RecordAudio("323111051", var_208_9)
						arg_205_1:RecordAudio("323111051", var_208_9)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_323111", "323111051", "story_v_out_323111.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_323111", "323111051", "story_v_out_323111.awb")
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
	Play323111052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 323111052
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play323111053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1053ui_story = arg_209_1.actors_["1053ui_story"].transform.localPosition

				local var_212_0 = GameObjectTools.GetOrAddComponent(arg_209_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_212_0 then
					var_212_0:EnableDynamicBone(false)
				end
			end

			local var_212_1 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_1 then
				arg_209_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_209_1.time_ - 0) / var_212_1)
				arg_209_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1053ui_story"].transform.position).z)
				arg_209_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1053ui_story"].transform.localEulerAngles = arg_209_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_1 and arg_209_1.time_ < 0 + var_212_1 + arg_212_0 then
				arg_209_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_209_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1053ui_story"].transform.position).z)
				arg_209_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1053ui_story"].transform.localEulerAngles = arg_209_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_212_2 = GameObjectTools.GetOrAddComponent(arg_209_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_212_2 then
					var_212_2:EnableDynamicBone(true)
				end
			end

			local var_212_3 = arg_209_1.actors_["1053ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_3) and arg_209_1.var_.characterEffect1053ui_story == nil then
				arg_209_1.var_.characterEffect1053ui_story = var_212_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_4 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_4 and not isNil(var_212_3) then
				if arg_209_1.var_.characterEffect1053ui_story and not isNil(var_212_3) then
					arg_209_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_209_1.time_ - 0) / var_212_4)
				end
			end

			if arg_209_1.time_ >= 0 + var_212_4 and arg_209_1.time_ < 0 + var_212_4 + arg_212_0 and not isNil(var_212_3) and arg_209_1.var_.characterEffect1053ui_story then
				arg_209_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_212_5 = 0
			local var_212_6 = 1.7

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_5 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_7 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(323111052).content)

				arg_209_1.text_.text = var_212_7

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_9 = 68 <= 0 and var_212_6 or var_212_6 * (utf8.len(var_212_7) / 68)

				if (68 <= 0 and var_212_6 or var_212_6 * (utf8.len(var_212_7) / 68)) > 0 and var_212_6 < var_212_9 then
					arg_209_1.talkMaxDuration = var_212_9

					if var_212_9 + var_212_5 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_9 + var_212_5
					end
				end

				arg_209_1.text_.text = var_212_7
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_10 = math.max(var_212_6, arg_209_1.talkMaxDuration)

			if var_212_5 <= arg_209_1.time_ and arg_209_1.time_ < var_212_5 + var_212_10 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_5) / var_212_10

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_5 + var_212_10 and arg_209_1.time_ < var_212_5 + var_212_10 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play323111053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 323111053
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play323111054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0.725

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
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

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_1 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(323111053).content)

				arg_213_1.text_.text = var_216_1

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_3 = 29 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_1) / 29)

				if (29 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_1) / 29)) > 0 and var_216_0 < var_216_3 then
					arg_213_1.talkMaxDuration = var_216_3

					if var_216_3 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_3 + 0
					end
				end

				arg_213_1.text_.text = var_216_1
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_4 = math.max(var_216_0, arg_213_1.talkMaxDuration)

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_4 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - 0) / var_216_4

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= 0 + var_216_4 and arg_213_1.time_ < 0 + var_216_4 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play323111054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 323111054
		arg_217_1.duration_ = 5.13

		local var_217_0 = {
			zh = 4.5,
			ja = 5.133
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
				arg_217_0:Play323111055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0.375

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_1 = arg_217_1:GetWordFromCfg(323111054)
				local var_220_2 = arg_217_1:FormatText(var_220_1.content)

				arg_217_1.text_.text = var_220_2

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_4 = 15 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 15)

				if (15 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 15)) > 0 and var_220_0 < var_220_4 then
					arg_217_1.talkMaxDuration = var_220_4

					if var_220_4 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_4 + 0
					end
				end

				arg_217_1.text_.text = var_220_2
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111054", "story_v_out_323111.awb") ~= 0 then
					local var_220_5 = manager.audio:GetVoiceLength("story_v_out_323111", "323111054", "story_v_out_323111.awb") / 1000

					if var_220_5 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + 0
					end

					if var_220_1.prefab_name ~= "" and arg_217_1.actors_[var_220_1.prefab_name] ~= nil then
						local var_220_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_1.prefab_name].transform, "story_v_out_323111", "323111054", "story_v_out_323111.awb")

						arg_217_1:RecordAudio("323111054", var_220_6)
						arg_217_1:RecordAudio("323111054", var_220_6)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_323111", "323111054", "story_v_out_323111.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_323111", "323111054", "story_v_out_323111.awb")
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
	Play323111055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 323111055
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play323111056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1053ui_story = arg_221_1.actors_["1053ui_story"].transform.localPosition

				local var_224_0 = GameObjectTools.GetOrAddComponent(arg_221_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_224_0 then
					var_224_0:EnableDynamicBone(false)
				end
			end

			local var_224_1 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_1 then
				arg_221_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_221_1.time_ - 0) / var_224_1)
				arg_221_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1053ui_story"].transform.position).z)
				arg_221_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1053ui_story"].transform.localEulerAngles = arg_221_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_1 and arg_221_1.time_ < 0 + var_224_1 + arg_224_0 then
				arg_221_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_221_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1053ui_story"].transform.position).z)
				arg_221_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1053ui_story"].transform.localEulerAngles = arg_221_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_224_2 = GameObjectTools.GetOrAddComponent(arg_221_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_224_2 then
					var_224_2:EnableDynamicBone(true)
				end
			end

			local var_224_3 = 0
			local var_224_4 = 0.95

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_3 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_5 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(323111055).content)

				arg_221_1.text_.text = var_224_5

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_7 = 38 <= 0 and var_224_4 or var_224_4 * (utf8.len(var_224_5) / 38)

				if (38 <= 0 and var_224_4 or var_224_4 * (utf8.len(var_224_5) / 38)) > 0 and var_224_4 < var_224_7 then
					arg_221_1.talkMaxDuration = var_224_7

					if var_224_7 + var_224_3 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_3
					end
				end

				arg_221_1.text_.text = var_224_5
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_8 = math.max(var_224_4, arg_221_1.talkMaxDuration)

			if var_224_3 <= arg_221_1.time_ and arg_221_1.time_ < var_224_3 + var_224_8 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_3) / var_224_8

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_3 + var_224_8 and arg_221_1.time_ < var_224_3 + var_224_8 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play323111056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 323111056
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play323111057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0.166666666666667 < arg_225_1.time_ and arg_225_1.time_ <= 0.166666666666667 + arg_228_0 then
				arg_225_1:AudioAction("play", "effect", "se_story_148", "se_story_148_footstep_snow03", "")
			end

			local var_228_1 = 0
			local var_228_2 = 1.325

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_3 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(323111056).content)

				arg_225_1.text_.text = var_228_3

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 53 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_3) / 53)

				if (53 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_3) / 53)) > 0 and var_228_2 < var_228_5 then
					arg_225_1.talkMaxDuration = var_228_5

					if var_228_5 + var_228_1 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + var_228_1
					end
				end

				arg_225_1.text_.text = var_228_3
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_6 = math.max(var_228_2, arg_225_1.talkMaxDuration)

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_6 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_1) / var_228_6

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_1 + var_228_6 and arg_225_1.time_ < var_228_1 + var_228_6 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play323111057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 323111057
		arg_229_1.duration_ = 2

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play323111058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos1053ui_story = arg_229_1.actors_["1053ui_story"].transform.localPosition

				local var_232_0 = GameObjectTools.GetOrAddComponent(arg_229_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_232_0 then
					var_232_0:EnableDynamicBone(false)
				end
			end

			local var_232_1 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_1 then
				arg_229_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_229_1.time_ - 0) / var_232_1)
				arg_229_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1053ui_story"].transform.position).z)
				arg_229_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["1053ui_story"].transform.localEulerAngles = arg_229_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_1 and arg_229_1.time_ < 0 + var_232_1 + arg_232_0 then
				arg_229_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_229_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1053ui_story"].transform.position).z)
				arg_229_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["1053ui_story"].transform.localEulerAngles = arg_229_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_232_2 = GameObjectTools.GetOrAddComponent(arg_229_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_232_2 then
					var_232_2:EnableDynamicBone(true)
				end
			end

			local var_232_3 = arg_229_1.actors_["1053ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_3) and arg_229_1.var_.characterEffect1053ui_story == nil then
				arg_229_1.var_.characterEffect1053ui_story = var_232_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_4 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_4 and not isNil(var_232_3) then
				if arg_229_1.var_.characterEffect1053ui_story and not isNil(var_232_3) then
					arg_229_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_4 and arg_229_1.time_ < 0 + var_232_4 + arg_232_0 and not isNil(var_232_3) and arg_229_1.var_.characterEffect1053ui_story then
				arg_229_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action3_2")
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_232_8 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_229_1.bgmTxt_.text ~= var_232_8 and arg_229_1.bgmTxt_.text ~= "" then
						if arg_229_1.bgmTxt2_.text ~= "" then
							arg_229_1.bgmTxt_.text = arg_229_1.bgmTxt2_.text
						end

						arg_229_1.bgmTxt2_.text = var_232_8

						arg_229_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_229_1.bgmTxt_.text = var_232_8
						arg_229_1.bgmTxt2_.text = var_232_8
					end

					if arg_229_1.bgmTimer then
						arg_229_1.bgmTimer:Stop()

						arg_229_1.bgmTimer = nil
					end

					if arg_229_1.settingData.show_music_name == 1 then
						arg_229_1.musicController:SetSelectedState("show")
						arg_229_1.musicAnimator_:Play("open", 0, 0)

						if arg_229_1.settingData.music_time ~= 0 then
							arg_229_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_229_1.settingData.music_time), function()
								if arg_229_1 == nil or isNil(arg_229_1.bgmTxt_) then
									return
								end

								arg_229_1.musicController:SetSelectedState("hide")
								arg_229_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_232_9 = 0
			local var_232_10 = 0.1

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_9 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[1453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_11 = arg_229_1:GetWordFromCfg(323111057)
				local var_232_12 = arg_229_1:FormatText(var_232_11.content)

				arg_229_1.text_.text = var_232_12

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_14 = 4 <= 0 and var_232_10 or var_232_10 * (utf8.len(var_232_12) / 4)

				if (4 <= 0 and var_232_10 or var_232_10 * (utf8.len(var_232_12) / 4)) > 0 and var_232_10 < var_232_14 then
					arg_229_1.talkMaxDuration = var_232_14

					if var_232_14 + var_232_9 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_14 + var_232_9
					end
				end

				arg_229_1.text_.text = var_232_12
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111057", "story_v_out_323111.awb") ~= 0 then
					local var_232_15 = manager.audio:GetVoiceLength("story_v_out_323111", "323111057", "story_v_out_323111.awb") / 1000

					if var_232_15 + var_232_9 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_15 + var_232_9
					end

					if var_232_11.prefab_name ~= "" and arg_229_1.actors_[var_232_11.prefab_name] ~= nil then
						local var_232_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_11.prefab_name].transform, "story_v_out_323111", "323111057", "story_v_out_323111.awb")

						arg_229_1:RecordAudio("323111057", var_232_16)
						arg_229_1:RecordAudio("323111057", var_232_16)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_323111", "323111057", "story_v_out_323111.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_323111", "323111057", "story_v_out_323111.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_17 = math.max(var_232_10, arg_229_1.talkMaxDuration)

			if var_232_9 <= arg_229_1.time_ and arg_229_1.time_ < var_232_9 + var_232_17 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_9) / var_232_17

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_9 + var_232_17 and arg_229_1.time_ < var_232_9 + var_232_17 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
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
	Play323111058 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 323111058
		arg_234_1.duration_ = 1.9

		local var_234_0 = {
			zh = 1.433333333332,
			ja = 1.9
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play323111059(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_237_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_234_1.bgmTxt_.text ~= var_237_2 and arg_234_1.bgmTxt_.text ~= "" then
						if arg_234_1.bgmTxt2_.text ~= "" then
							arg_234_1.bgmTxt_.text = arg_234_1.bgmTxt2_.text
						end

						arg_234_1.bgmTxt2_.text = var_237_2

						arg_234_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_234_1.bgmTxt_.text = var_237_2
						arg_234_1.bgmTxt2_.text = var_237_2
					end

					if arg_234_1.bgmTimer then
						arg_234_1.bgmTimer:Stop()

						arg_234_1.bgmTimer = nil
					end

					if arg_234_1.settingData.show_music_name == 1 then
						arg_234_1.musicController:SetSelectedState("show")
						arg_234_1.musicAnimator_:Play("open", 0, 0)

						if arg_234_1.settingData.music_time ~= 0 then
							arg_234_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_234_1.settingData.music_time), function()
								if arg_234_1 == nil or isNil(arg_234_1.bgmTxt_) then
									return
								end

								arg_234_1.musicController:SetSelectedState("hide")
								arg_234_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.433333333333333 < arg_234_1.time_ and arg_234_1.time_ <= 0.433333333333333 + arg_237_0 then
				arg_234_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_237_5 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if "" ~= "" then
					if arg_234_1.bgmTxt_.text ~= var_237_5 and arg_234_1.bgmTxt_.text ~= "" then
						if arg_234_1.bgmTxt2_.text ~= "" then
							arg_234_1.bgmTxt_.text = arg_234_1.bgmTxt2_.text
						end

						arg_234_1.bgmTxt2_.text = var_237_5

						arg_234_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_234_1.bgmTxt_.text = var_237_5
						arg_234_1.bgmTxt2_.text = var_237_5
					end

					if arg_234_1.bgmTimer then
						arg_234_1.bgmTimer:Stop()

						arg_234_1.bgmTimer = nil
					end

					if arg_234_1.settingData.show_music_name == 1 then
						arg_234_1.musicController:SetSelectedState("show")
						arg_234_1.musicAnimator_:Play("open", 0, 0)

						if arg_234_1.settingData.music_time ~= 0 then
							arg_234_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_234_1.settingData.music_time), function()
								if arg_234_1 == nil or isNil(arg_234_1.bgmTxt_) then
									return
								end

								arg_234_1.musicController:SetSelectedState("hide")
								arg_234_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_237_6 = arg_234_1.actors_["1053ui_story"]

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(var_237_6) and arg_234_1.var_.characterEffect1053ui_story == nil then
				arg_234_1.var_.characterEffect1053ui_story = var_237_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_7 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_7 and not isNil(var_237_6) then
				if arg_234_1.var_.characterEffect1053ui_story and not isNil(var_237_6) then
					arg_234_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_234_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_234_1.time_ - 0) / var_237_7)
				end
			end

			if arg_234_1.time_ >= 0 + var_237_7 and arg_234_1.time_ < 0 + var_237_7 + arg_237_0 and not isNil(var_237_6) and arg_234_1.var_.characterEffect1053ui_story then
				arg_234_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_234_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_237_8 = 0
			local var_237_9 = 0.075

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_8 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, true)
				arg_234_1.iconController_:SetSelectedState("hero")

				arg_234_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_234_1.callingController_:SetSelectedState("normal")

				arg_234_1.keyicon_.color = Color.New(1, 1, 1)
				arg_234_1.icon_.color = Color.New(1, 1, 1)

				local var_237_10 = arg_234_1:GetWordFromCfg(323111058)
				local var_237_11 = arg_234_1:FormatText(var_237_10.content)

				arg_234_1.text_.text = var_237_11

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_13 = 3 <= 0 and var_237_9 or var_237_9 * (utf8.len(var_237_11) / 3)

				if (3 <= 0 and var_237_9 or var_237_9 * (utf8.len(var_237_11) / 3)) > 0 and var_237_9 < var_237_13 then
					arg_234_1.talkMaxDuration = var_237_13

					if var_237_13 + var_237_8 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_13 + var_237_8
					end
				end

				arg_234_1.text_.text = var_237_11
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111058", "story_v_out_323111.awb") ~= 0 then
					local var_237_14 = manager.audio:GetVoiceLength("story_v_out_323111", "323111058", "story_v_out_323111.awb") / 1000

					if var_237_14 + var_237_8 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_14 + var_237_8
					end

					if var_237_10.prefab_name ~= "" and arg_234_1.actors_[var_237_10.prefab_name] ~= nil then
						local var_237_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_10.prefab_name].transform, "story_v_out_323111", "323111058", "story_v_out_323111.awb")

						arg_234_1:RecordAudio("323111058", var_237_15)
						arg_234_1:RecordAudio("323111058", var_237_15)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_323111", "323111058", "story_v_out_323111.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_323111", "323111058", "story_v_out_323111.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_16 = math.max(var_237_9, arg_234_1.talkMaxDuration)

			if var_237_8 <= arg_234_1.time_ and arg_234_1.time_ < var_237_8 + var_237_16 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_8) / var_237_16

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_8 + var_237_16 and arg_234_1.time_ < var_237_8 + var_237_16 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play323111059 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 323111059
		arg_240_1.duration_ = 6.53

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play323111060(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				local var_243_0 = arg_240_1.var_.effect444

				if not arg_240_1.var_.effect444 then
					var_243_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang03"), manager.ui.mainCamera.transform)
					var_243_0.name = "444"
					arg_240_1.var_.effect444 = var_243_0
				else
					var_243_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_243_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_243_0.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_243_2 = Mathf.Max(Screen.width / Screen.height / 1.7777777777777777, (Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1)))

				var_243_0.transform.localScale = Vector3.New(var_243_0.transform.localScale.x * var_243_2, var_243_0.transform.localScale.y * var_243_2, var_243_0.transform.localScale.z * var_243_2)
			end

			if 1.77445409726351 < arg_240_1.time_ and arg_240_1.time_ <= 1.77445409726351 + arg_243_0 then
				if arg_240_1.var_.effect444 then
					Object.Destroy(arg_240_1.var_.effect444)

					arg_240_1.var_.effect444 = nil
				end
			end

			local var_243_4 = 0.366666666666667

			if 0.366666666666667 < arg_240_1.time_ and arg_240_1.time_ <= var_243_4 + arg_243_0 then
				arg_240_1.mask_.enabled = true
				arg_240_1.mask_.raycastTarget = true

				arg_240_1:SetGaussion(false)
			end

			local var_243_5 = 0.766666669646899

			if var_243_4 <= arg_240_1.time_ and arg_240_1.time_ < var_243_4 + var_243_5 then
				local var_243_6 = Color.New(1, 1, 1)

				var_243_6.a = Mathf.Lerp(1, 0, (arg_240_1.time_ - var_243_4) / var_243_5)
				arg_240_1.mask_.color = var_243_6
			end

			if arg_240_1.time_ >= var_243_4 + var_243_5 and arg_240_1.time_ < var_243_4 + var_243_5 + arg_243_0 then
				local var_243_7 = Color.New(1, 1, 1)

				arg_240_1.mask_.enabled = false
				var_243_7.a = 0
				arg_240_1.mask_.color = var_243_7
			end

			local var_243_8 = 0

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_8 + arg_243_0 then
				arg_240_1.allBtn_.enabled = false
			end

			if arg_240_1.time_ >= var_243_8 + 1.63333333333333 and arg_240_1.time_ < var_243_8 + 1.63333333333333 + arg_243_0 then
				arg_240_1.allBtn_.enabled = true
			end

			if 0.166666666666667 < arg_240_1.time_ and arg_240_1.time_ <= 0.166666666666667 + arg_243_0 then
				arg_240_1:AudioAction("play", "effect", "se_story_148", "se_story_148_sword02", "")
			end

			local var_243_10 = arg_240_1.actors_["1053ui_story"].transform

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.var_.moveOldPos1053ui_story = var_243_10.localPosition

				local var_243_11 = GameObjectTools.GetOrAddComponent(var_243_10.gameObject, typeof(DynamicBoneHelper))

				if var_243_11 then
					var_243_11:EnableDynamicBone(false)
				end
			end

			local var_243_12 = 0.001

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_12 then
				var_243_10.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_240_1.time_ - 0) / var_243_12)
				var_243_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_243_10.position).x, (manager.ui.mainCamera.transform.position - var_243_10.position).y, (manager.ui.mainCamera.transform.position - var_243_10.position).z)
				var_243_10.localEulerAngles.z = 0
				var_243_10.localEulerAngles.x = 0
				var_243_10.localEulerAngles = var_243_10.localEulerAngles
			end

			if arg_240_1.time_ >= 0 + var_243_12 and arg_240_1.time_ < 0 + var_243_12 + arg_243_0 then
				var_243_10.localPosition = Vector3.New(0, 100, 0)
				var_243_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_243_10.position).x, (manager.ui.mainCamera.transform.position - var_243_10.position).y, (manager.ui.mainCamera.transform.position - var_243_10.position).z)
				var_243_10.localEulerAngles.z = 0
				var_243_10.localEulerAngles.x = 0
				var_243_10.localEulerAngles = var_243_10.localEulerAngles

				local var_243_13 = GameObjectTools.GetOrAddComponent(var_243_10.gameObject, typeof(DynamicBoneHelper))

				if var_243_13 then
					var_243_13:EnableDynamicBone(true)
				end
			end

			if arg_240_1.frameCnt_ <= 1 then
				arg_240_1.dialog_:SetActive(false)
			end

			local var_243_14 = 1.53333333333333
			local var_243_15 = 1.05

			if 1.53333333333333 < arg_240_1.time_ and arg_240_1.time_ <= var_243_14 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0

				arg_240_1.dialog_:SetActive(true)

				arg_240_1.dialogCg_.alpha = 0

				local var_243_16 = LeanTween.value(arg_240_1.dialog_, 0, 1, 0.3)

				var_243_16:setOnUpdate(LuaHelper.FloatAction(function(arg_244_0)
					arg_240_1.dialogCg_.alpha = arg_244_0
				end))
				var_243_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_240_1.dialog_)
					var_243_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_240_1.duration_ = arg_240_1.duration_ + 0.3

				SetActive(arg_240_1.leftNameGo_, false)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_17 = arg_240_1:FormatText(arg_240_1:GetWordFromCfg(323111059).content)

				arg_240_1.text_.text = var_243_17

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_19 = 42 <= 0 and var_243_15 or var_243_15 * (utf8.len(var_243_17) / 42)

				if (42 <= 0 and var_243_15 or var_243_15 * (utf8.len(var_243_17) / 42)) > 0 and var_243_15 < var_243_19 then
					arg_240_1.talkMaxDuration = var_243_19
					var_243_14 = var_243_14 + 0.3

					if var_243_19 + var_243_14 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_19 + var_243_14
					end
				end

				arg_240_1.text_.text = var_243_17
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_20 = var_243_14 + 0.3
			local var_243_21 = math.max(var_243_15, arg_240_1.talkMaxDuration)

			if var_243_14 + 0.3 <= arg_240_1.time_ and arg_240_1.time_ < var_243_20 + var_243_21 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_20) / var_243_21

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_20 + var_243_21 and arg_240_1.time_ < var_243_20 + var_243_21 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 1,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D_Shake",
				duration = 0.799999997019768,
				amplitudeGain = 1,
				startTime = 0.200000002980232,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_240_1:InitPlayNodeList()
	end,
	Play323111060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 323111060
		arg_246_1.duration_ = 5.33

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play323111061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				local var_249_0 = arg_246_1.var_.effect2344233

				if not arg_246_1.var_.effect2344233 then
					var_249_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust_1"), manager.ui.mainCamera.transform)
					var_249_0.name = "233"
					arg_246_1.var_.effect2344233 = var_249_0
				else
					var_249_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_249_0.transform.localPosition = Vector3.New(0, -0.34, 0)
				var_249_0.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_249_2 = Mathf.Max(Screen.width / Screen.height / 1.7777777777777777, (Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1)))

				var_249_0.transform.localScale = Vector3.New(var_249_0.transform.localScale.x * var_249_2, var_249_0.transform.localScale.y * var_249_2, var_249_0.transform.localScale.z * var_249_2)
			end

			local var_249_3 = 0

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_3 + arg_249_0 then
				arg_246_1.allBtn_.enabled = false
			end

			if arg_246_1.time_ >= var_249_3 + 0.7 and arg_246_1.time_ < var_249_3 + 0.7 + arg_249_0 then
				arg_246_1.allBtn_.enabled = true
			end

			if 0.166666666666667 < arg_246_1.time_ and arg_246_1.time_ <= 0.166666666666667 + arg_249_0 then
				arg_246_1:AudioAction("play", "effect", "se_story_148", "se_story_148_sword_hit", "")
			end

			if arg_246_1.frameCnt_ <= 1 then
				arg_246_1.dialog_:SetActive(false)
			end

			local var_249_5 = 0.333333333333333
			local var_249_6 = 1.4

			if 0.333333333333333 < arg_246_1.time_ and arg_246_1.time_ <= var_249_5 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0

				arg_246_1.dialog_:SetActive(true)

				arg_246_1.dialogCg_.alpha = 0

				local var_249_7 = LeanTween.value(arg_246_1.dialog_, 0, 1, 0.3)

				var_249_7:setOnUpdate(LuaHelper.FloatAction(function(arg_250_0)
					arg_246_1.dialogCg_.alpha = arg_250_0
				end))
				var_249_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_246_1.dialog_)
					var_249_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_246_1.duration_ = arg_246_1.duration_ + 0.3

				SetActive(arg_246_1.leftNameGo_, false)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_8 = arg_246_1:FormatText(arg_246_1:GetWordFromCfg(323111060).content)

				arg_246_1.text_.text = var_249_8

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_10 = 56 <= 0 and var_249_6 or var_249_6 * (utf8.len(var_249_8) / 56)

				if (56 <= 0 and var_249_6 or var_249_6 * (utf8.len(var_249_8) / 56)) > 0 and var_249_6 < var_249_10 then
					arg_246_1.talkMaxDuration = var_249_10
					var_249_5 = var_249_5 + 0.3

					if var_249_10 + var_249_5 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_10 + var_249_5
					end
				end

				arg_246_1.text_.text = var_249_8
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_11 = var_249_5 + 0.3
			local var_249_12 = math.max(var_249_6, arg_246_1.talkMaxDuration)

			if var_249_5 + 0.3 <= arg_246_1.time_ and arg_246_1.time_ < var_249_11 + var_249_12 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_11) / var_249_12

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_11 + var_249_12 and arg_246_1.time_ < var_249_11 + var_249_12 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequency = 4,
				className = "StoryShakeNode",
				duration = 0.366666666666667,
				startTime = 0.333333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.DIALOG,
				offset = Vector3.New(10, 0.1, 0.1)
			}
		}

		arg_246_1:InitPlayNodeList()
	end,
	Play323111061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 323111061
		arg_252_1.duration_ = 9.37

		local var_252_0 = {
			zh = 5.4,
			ja = 9.366
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play323111062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 0.475

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_252_1.callingController_:SetSelectedState("normal")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_1 = arg_252_1:GetWordFromCfg(323111061)
				local var_255_2 = arg_252_1:FormatText(var_255_1.content)

				arg_252_1.text_.text = var_255_2

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_4 = 19 <= 0 and var_255_0 or var_255_0 * (utf8.len(var_255_2) / 19)

				if (19 <= 0 and var_255_0 or var_255_0 * (utf8.len(var_255_2) / 19)) > 0 and var_255_0 < var_255_4 then
					arg_252_1.talkMaxDuration = var_255_4

					if var_255_4 + 0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_4 + 0
					end
				end

				arg_252_1.text_.text = var_255_2
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111061", "story_v_out_323111.awb") ~= 0 then
					local var_255_5 = manager.audio:GetVoiceLength("story_v_out_323111", "323111061", "story_v_out_323111.awb") / 1000

					if var_255_5 + 0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_5 + 0
					end

					if var_255_1.prefab_name ~= "" and arg_252_1.actors_[var_255_1.prefab_name] ~= nil then
						local var_255_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_1.prefab_name].transform, "story_v_out_323111", "323111061", "story_v_out_323111.awb")

						arg_252_1:RecordAudio("323111061", var_255_6)
						arg_252_1:RecordAudio("323111061", var_255_6)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_323111", "323111061", "story_v_out_323111.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_323111", "323111061", "story_v_out_323111.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_7 = math.max(var_255_0, arg_252_1.talkMaxDuration)

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_7 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - 0) / var_255_7

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= 0 + var_255_7 and arg_252_1.time_ < 0 + var_255_7 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play323111062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 323111062
		arg_256_1.duration_ = 6.1

		local var_256_0 = {
			zh = 4,
			ja = 6.1
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play323111063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.var_.moveOldPos1053ui_story = arg_256_1.actors_["1053ui_story"].transform.localPosition

				local var_259_0 = GameObjectTools.GetOrAddComponent(arg_256_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_259_0 then
					var_259_0:EnableDynamicBone(false)
				end
			end

			local var_259_1 = 0.001

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_1 then
				arg_256_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_256_1.time_ - 0) / var_259_1)
				arg_256_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_256_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["1053ui_story"].transform.position).z)
				arg_256_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_256_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_256_1.actors_["1053ui_story"].transform.localEulerAngles = arg_256_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_256_1.time_ >= 0 + var_259_1 and arg_256_1.time_ < 0 + var_259_1 + arg_259_0 then
				arg_256_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_256_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_256_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["1053ui_story"].transform.position).z)
				arg_256_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_256_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_256_1.actors_["1053ui_story"].transform.localEulerAngles = arg_256_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_259_2 = GameObjectTools.GetOrAddComponent(arg_256_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_259_2 then
					var_259_2:EnableDynamicBone(true)
				end
			end

			local var_259_3 = arg_256_1.actors_["1053ui_story"]

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(var_259_3) and arg_256_1.var_.characterEffect1053ui_story == nil then
				arg_256_1.var_.characterEffect1053ui_story = var_259_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_4 = 0.200000002980232

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_4 and not isNil(var_259_3) then
				if arg_256_1.var_.characterEffect1053ui_story and not isNil(var_259_3) then
					arg_256_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_256_1.time_ >= 0 + var_259_4 and arg_256_1.time_ < 0 + var_259_4 + arg_259_0 and not isNil(var_259_3) and arg_256_1.var_.characterEffect1053ui_story then
				arg_256_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action1_1")
			end

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_259_6 = 0
			local var_259_7 = 0.4

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_6 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[1453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_8 = arg_256_1:GetWordFromCfg(323111062)
				local var_259_9 = arg_256_1:FormatText(var_259_8.content)

				arg_256_1.text_.text = var_259_9

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_11 = 16 <= 0 and var_259_7 or var_259_7 * (utf8.len(var_259_9) / 16)

				if (16 <= 0 and var_259_7 or var_259_7 * (utf8.len(var_259_9) / 16)) > 0 and var_259_7 < var_259_11 then
					arg_256_1.talkMaxDuration = var_259_11

					if var_259_11 + var_259_6 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_11 + var_259_6
					end
				end

				arg_256_1.text_.text = var_259_9
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111062", "story_v_out_323111.awb") ~= 0 then
					local var_259_12 = manager.audio:GetVoiceLength("story_v_out_323111", "323111062", "story_v_out_323111.awb") / 1000

					if var_259_12 + var_259_6 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_12 + var_259_6
					end

					if var_259_8.prefab_name ~= "" and arg_256_1.actors_[var_259_8.prefab_name] ~= nil then
						local var_259_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_8.prefab_name].transform, "story_v_out_323111", "323111062", "story_v_out_323111.awb")

						arg_256_1:RecordAudio("323111062", var_259_13)
						arg_256_1:RecordAudio("323111062", var_259_13)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_323111", "323111062", "story_v_out_323111.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_323111", "323111062", "story_v_out_323111.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_14 = math.max(var_259_7, arg_256_1.talkMaxDuration)

			if var_259_6 <= arg_256_1.time_ and arg_256_1.time_ < var_259_6 + var_259_14 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_6) / var_259_14

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_6 + var_259_14 and arg_256_1.time_ < var_259_6 + var_259_14 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_256_1:InitPlayNodeList()
	end,
	Play323111063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 323111063
		arg_260_1.duration_ = 7.7

		local var_260_0 = {
			zh = 4.8,
			ja = 7.7
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play323111064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if arg_260_1.actors_["1059ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1059ui_story"))) then
				local var_263_0 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_260_1.stage_.transform)

				var_263_0.name = "1059ui_story"
				var_263_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_260_1.actors_["1059ui_story"] = var_263_0

				local var_263_1 = var_263_0:GetComponentInChildren(typeof(CharacterEffect))

				var_263_1.enabled = true

				local var_263_2 = GameObjectTools.GetOrAddComponent(var_263_0, typeof(DynamicBoneHelper))

				if var_263_2 then
					var_263_2:EnableDynamicBone(false)
				end

				arg_260_1:ShowWeapon(var_263_1.transform, false)

				arg_260_1.var_["1059ui_story" .. "Animator"] = var_263_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_260_1.var_["1059ui_story" .. "Animator"].applyRootMotion = true
				arg_260_1.var_["1059ui_story" .. "LipSync"] = var_263_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_263_3 = arg_260_1.actors_["1059ui_story"]

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 and not isNil(var_263_3) and arg_260_1.var_.characterEffect1059ui_story == nil then
				arg_260_1.var_.characterEffect1059ui_story = var_263_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_4 = 0.200000002980232

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_4 and not isNil(var_263_3) then
				if arg_260_1.var_.characterEffect1059ui_story and not isNil(var_263_3) then
					arg_260_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_260_1.time_ >= 0 + var_263_4 and arg_260_1.time_ < 0 + var_263_4 + arg_263_0 and not isNil(var_263_3) and arg_260_1.var_.characterEffect1059ui_story then
				arg_260_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_263_6 = arg_260_1.actors_["1053ui_story"]

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 and not isNil(var_263_6) and arg_260_1.var_.characterEffect1053ui_story == nil then
				arg_260_1.var_.characterEffect1053ui_story = var_263_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_7 = 0.200000002980232

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_7 and not isNil(var_263_6) then
				if arg_260_1.var_.characterEffect1053ui_story and not isNil(var_263_6) then
					arg_260_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_260_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_260_1.time_ - 0) / var_263_7)
				end
			end

			if arg_260_1.time_ >= 0 + var_263_7 and arg_260_1.time_ < 0 + var_263_7 + arg_263_0 and not isNil(var_263_6) and arg_260_1.var_.characterEffect1053ui_story then
				arg_260_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_260_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_263_8 = 0
			local var_263_9 = 0.5

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_8 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, true)
				arg_260_1.iconController_:SetSelectedState("hero")

				arg_260_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_260_1.callingController_:SetSelectedState("normal")

				arg_260_1.keyicon_.color = Color.New(1, 1, 1)
				arg_260_1.icon_.color = Color.New(1, 1, 1)

				local var_263_10 = arg_260_1:GetWordFromCfg(323111063)
				local var_263_11 = arg_260_1:FormatText(var_263_10.content)

				arg_260_1.text_.text = var_263_11

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_13 = 20 <= 0 and var_263_9 or var_263_9 * (utf8.len(var_263_11) / 20)

				if (20 <= 0 and var_263_9 or var_263_9 * (utf8.len(var_263_11) / 20)) > 0 and var_263_9 < var_263_13 then
					arg_260_1.talkMaxDuration = var_263_13

					if var_263_13 + var_263_8 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_13 + var_263_8
					end
				end

				arg_260_1.text_.text = var_263_11
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111063", "story_v_out_323111.awb") ~= 0 then
					local var_263_14 = manager.audio:GetVoiceLength("story_v_out_323111", "323111063", "story_v_out_323111.awb") / 1000

					if var_263_14 + var_263_8 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_14 + var_263_8
					end

					if var_263_10.prefab_name ~= "" and arg_260_1.actors_[var_263_10.prefab_name] ~= nil then
						local var_263_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_10.prefab_name].transform, "story_v_out_323111", "323111063", "story_v_out_323111.awb")

						arg_260_1:RecordAudio("323111063", var_263_15)
						arg_260_1:RecordAudio("323111063", var_263_15)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_323111", "323111063", "story_v_out_323111.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_323111", "323111063", "story_v_out_323111.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_16 = math.max(var_263_9, arg_260_1.talkMaxDuration)

			if var_263_8 <= arg_260_1.time_ and arg_260_1.time_ < var_263_8 + var_263_16 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_8) / var_263_16

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_8 + var_263_16 and arg_260_1.time_ < var_263_8 + var_263_16 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play323111064 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 323111064
		arg_264_1.duration_ = 8.17

		local var_264_0 = {
			zh = 6.333,
			ja = 8.166
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
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play323111065(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = 0.525

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, true)
				arg_264_1.iconController_:SetSelectedState("hero")

				arg_264_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_264_1.callingController_:SetSelectedState("normal")

				arg_264_1.keyicon_.color = Color.New(1, 1, 1)
				arg_264_1.icon_.color = Color.New(1, 1, 1)

				local var_267_1 = arg_264_1:GetWordFromCfg(323111064)
				local var_267_2 = arg_264_1:FormatText(var_267_1.content)

				arg_264_1.text_.text = var_267_2

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_4 = 21 <= 0 and var_267_0 or var_267_0 * (utf8.len(var_267_2) / 21)

				if (21 <= 0 and var_267_0 or var_267_0 * (utf8.len(var_267_2) / 21)) > 0 and var_267_0 < var_267_4 then
					arg_264_1.talkMaxDuration = var_267_4

					if var_267_4 + 0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_4 + 0
					end
				end

				arg_264_1.text_.text = var_267_2
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111064", "story_v_out_323111.awb") ~= 0 then
					local var_267_5 = manager.audio:GetVoiceLength("story_v_out_323111", "323111064", "story_v_out_323111.awb") / 1000

					if var_267_5 + 0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_5 + 0
					end

					if var_267_1.prefab_name ~= "" and arg_264_1.actors_[var_267_1.prefab_name] ~= nil then
						local var_267_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_1.prefab_name].transform, "story_v_out_323111", "323111064", "story_v_out_323111.awb")

						arg_264_1:RecordAudio("323111064", var_267_6)
						arg_264_1:RecordAudio("323111064", var_267_6)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_323111", "323111064", "story_v_out_323111.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_323111", "323111064", "story_v_out_323111.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_7 = math.max(var_267_0, arg_264_1.talkMaxDuration)

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_7 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - 0) / var_267_7

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= 0 + var_267_7 and arg_264_1.time_ < 0 + var_267_7 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play323111065 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 323111065
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play323111066(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 and not isNil(arg_268_1.actors_["1059ui_story"]) and arg_268_1.var_.characterEffect1059ui_story == nil then
				arg_268_1.var_.characterEffect1059ui_story = arg_268_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_0 = 0.200000002980232

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_0 and not isNil(arg_268_1.actors_["1059ui_story"]) then
				if arg_268_1.var_.characterEffect1059ui_story and not isNil(arg_268_1.actors_["1059ui_story"]) then
					arg_268_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_268_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_268_1.time_ - 0) / var_271_0)
				end
			end

			if arg_268_1.time_ >= 0 + var_271_0 and arg_268_1.time_ < 0 + var_271_0 + arg_271_0 and not isNil(arg_268_1.actors_["1059ui_story"]) and arg_268_1.var_.characterEffect1059ui_story then
				arg_268_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_268_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_271_1 = 0
			local var_271_2 = 0.475

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_1 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, true)
				arg_268_1.iconController_:SetSelectedState("hero")

				arg_268_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_268_1.callingController_:SetSelectedState("normal")

				arg_268_1.keyicon_.color = Color.New(1, 1, 1)
				arg_268_1.icon_.color = Color.New(1, 1, 1)

				local var_271_3 = arg_268_1:FormatText(arg_268_1:GetWordFromCfg(323111065).content)

				arg_268_1.text_.text = var_271_3

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_5 = 19 <= 0 and var_271_2 or var_271_2 * (utf8.len(var_271_3) / 19)

				if (19 <= 0 and var_271_2 or var_271_2 * (utf8.len(var_271_3) / 19)) > 0 and var_271_2 < var_271_5 then
					arg_268_1.talkMaxDuration = var_271_5

					if var_271_5 + var_271_1 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_5 + var_271_1
					end
				end

				arg_268_1.text_.text = var_271_3
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_6 = math.max(var_271_2, arg_268_1.talkMaxDuration)

			if var_271_1 <= arg_268_1.time_ and arg_268_1.time_ < var_271_1 + var_271_6 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_1) / var_271_6

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_1 + var_271_6 and arg_268_1.time_ < var_271_1 + var_271_6 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play323111066 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 323111066
		arg_272_1.duration_ = 9.13

		local var_272_0 = {
			zh = 5.766,
			ja = 9.133
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play323111067(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 and not isNil(arg_272_1.actors_["1059ui_story"]) and arg_272_1.var_.characterEffect1059ui_story == nil then
				arg_272_1.var_.characterEffect1059ui_story = arg_272_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_0 = 0.200000002980232

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_0 and not isNil(arg_272_1.actors_["1059ui_story"]) then
				if arg_272_1.var_.characterEffect1059ui_story and not isNil(arg_272_1.actors_["1059ui_story"]) then
					arg_272_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_272_1.time_ >= 0 + var_275_0 and arg_272_1.time_ < 0 + var_275_0 + arg_275_0 and not isNil(arg_272_1.actors_["1059ui_story"]) and arg_272_1.var_.characterEffect1059ui_story then
				arg_272_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_275_2 = 0
			local var_275_3 = 0.475

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_2 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, true)
				arg_272_1.iconController_:SetSelectedState("hero")

				arg_272_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_272_1.callingController_:SetSelectedState("normal")

				arg_272_1.keyicon_.color = Color.New(1, 1, 1)
				arg_272_1.icon_.color = Color.New(1, 1, 1)

				local var_275_4 = arg_272_1:GetWordFromCfg(323111066)
				local var_275_5 = arg_272_1:FormatText(var_275_4.content)

				arg_272_1.text_.text = var_275_5

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_7 = 19 <= 0 and var_275_3 or var_275_3 * (utf8.len(var_275_5) / 19)

				if (19 <= 0 and var_275_3 or var_275_3 * (utf8.len(var_275_5) / 19)) > 0 and var_275_3 < var_275_7 then
					arg_272_1.talkMaxDuration = var_275_7

					if var_275_7 + var_275_2 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_7 + var_275_2
					end
				end

				arg_272_1.text_.text = var_275_5
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111066", "story_v_out_323111.awb") ~= 0 then
					local var_275_8 = manager.audio:GetVoiceLength("story_v_out_323111", "323111066", "story_v_out_323111.awb") / 1000

					if var_275_8 + var_275_2 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_8 + var_275_2
					end

					if var_275_4.prefab_name ~= "" and arg_272_1.actors_[var_275_4.prefab_name] ~= nil then
						local var_275_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_4.prefab_name].transform, "story_v_out_323111", "323111066", "story_v_out_323111.awb")

						arg_272_1:RecordAudio("323111066", var_275_9)
						arg_272_1:RecordAudio("323111066", var_275_9)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_323111", "323111066", "story_v_out_323111.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_323111", "323111066", "story_v_out_323111.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_10 = math.max(var_275_3, arg_272_1.talkMaxDuration)

			if var_275_2 <= arg_272_1.time_ and arg_272_1.time_ < var_275_2 + var_275_10 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_2) / var_275_10

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_2 + var_275_10 and arg_272_1.time_ < var_275_2 + var_275_10 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play323111067 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 323111067
		arg_276_1.duration_ = 9

		local var_276_0 = {
			zh = 6.233,
			ja = 9
		}
		local var_276_1 = manager.audio:GetLocalizationFlag()

		if var_276_0[var_276_1] ~= nil then
			arg_276_1.duration_ = var_276_0[var_276_1]
		end

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play323111068(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(arg_276_1.actors_["1053ui_story"]) and arg_276_1.var_.characterEffect1053ui_story == nil then
				arg_276_1.var_.characterEffect1053ui_story = arg_276_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_0 = 0.200000002980232

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_0 and not isNil(arg_276_1.actors_["1053ui_story"]) then
				if arg_276_1.var_.characterEffect1053ui_story and not isNil(arg_276_1.actors_["1053ui_story"]) then
					arg_276_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_276_1.time_ >= 0 + var_279_0 and arg_276_1.time_ < 0 + var_279_0 + arg_279_0 and not isNil(arg_276_1.actors_["1053ui_story"]) and arg_276_1.var_.characterEffect1053ui_story then
				arg_276_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action6_1")
			end

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_279_2 = 0
			local var_279_3 = 0.65

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_2 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[1453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_4 = arg_276_1:GetWordFromCfg(323111067)
				local var_279_5 = arg_276_1:FormatText(var_279_4.content)

				arg_276_1.text_.text = var_279_5

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_7 = 26 <= 0 and var_279_3 or var_279_3 * (utf8.len(var_279_5) / 26)

				if (26 <= 0 and var_279_3 or var_279_3 * (utf8.len(var_279_5) / 26)) > 0 and var_279_3 < var_279_7 then
					arg_276_1.talkMaxDuration = var_279_7

					if var_279_7 + var_279_2 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_7 + var_279_2
					end
				end

				arg_276_1.text_.text = var_279_5
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111067", "story_v_out_323111.awb") ~= 0 then
					local var_279_8 = manager.audio:GetVoiceLength("story_v_out_323111", "323111067", "story_v_out_323111.awb") / 1000

					if var_279_8 + var_279_2 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_8 + var_279_2
					end

					if var_279_4.prefab_name ~= "" and arg_276_1.actors_[var_279_4.prefab_name] ~= nil then
						local var_279_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_4.prefab_name].transform, "story_v_out_323111", "323111067", "story_v_out_323111.awb")

						arg_276_1:RecordAudio("323111067", var_279_9)
						arg_276_1:RecordAudio("323111067", var_279_9)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_323111", "323111067", "story_v_out_323111.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_323111", "323111067", "story_v_out_323111.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_10 = math.max(var_279_3, arg_276_1.talkMaxDuration)

			if var_279_2 <= arg_276_1.time_ and arg_276_1.time_ < var_279_2 + var_279_10 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_2) / var_279_10

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_2 + var_279_10 and arg_276_1.time_ < var_279_2 + var_279_10 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play323111068 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 323111068
		arg_280_1.duration_ = 3.5

		local var_280_0 = {
			zh = 3.333,
			ja = 3.5
		}
		local var_280_1 = manager.audio:GetLocalizationFlag()

		if var_280_0[var_280_1] ~= nil then
			arg_280_1.duration_ = var_280_0[var_280_1]
		end

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play323111069(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(arg_280_1.actors_["1053ui_story"]) and arg_280_1.var_.characterEffect1053ui_story == nil then
				arg_280_1.var_.characterEffect1053ui_story = arg_280_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_0 = 0.200000002980232

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_0 and not isNil(arg_280_1.actors_["1053ui_story"]) then
				if arg_280_1.var_.characterEffect1053ui_story and not isNil(arg_280_1.actors_["1053ui_story"]) then
					arg_280_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_280_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_280_1.time_ - 0) / var_283_0)
				end
			end

			if arg_280_1.time_ >= 0 + var_283_0 and arg_280_1.time_ < 0 + var_283_0 + arg_283_0 and not isNil(arg_280_1.actors_["1053ui_story"]) and arg_280_1.var_.characterEffect1053ui_story then
				arg_280_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_280_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_283_1 = 0
			local var_283_2 = 0.25

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, true)
				arg_280_1.iconController_:SetSelectedState("hero")

				arg_280_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_280_1.callingController_:SetSelectedState("normal")

				arg_280_1.keyicon_.color = Color.New(1, 1, 1)
				arg_280_1.icon_.color = Color.New(1, 1, 1)

				local var_283_3 = arg_280_1:GetWordFromCfg(323111068)
				local var_283_4 = arg_280_1:FormatText(var_283_3.content)

				arg_280_1.text_.text = var_283_4

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_6 = 10 <= 0 and var_283_2 or var_283_2 * (utf8.len(var_283_4) / 10)

				if (10 <= 0 and var_283_2 or var_283_2 * (utf8.len(var_283_4) / 10)) > 0 and var_283_2 < var_283_6 then
					arg_280_1.talkMaxDuration = var_283_6

					if var_283_6 + var_283_1 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_6 + var_283_1
					end
				end

				arg_280_1.text_.text = var_283_4
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111068", "story_v_out_323111.awb") ~= 0 then
					local var_283_7 = manager.audio:GetVoiceLength("story_v_out_323111", "323111068", "story_v_out_323111.awb") / 1000

					if var_283_7 + var_283_1 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_7 + var_283_1
					end

					if var_283_3.prefab_name ~= "" and arg_280_1.actors_[var_283_3.prefab_name] ~= nil then
						local var_283_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_3.prefab_name].transform, "story_v_out_323111", "323111068", "story_v_out_323111.awb")

						arg_280_1:RecordAudio("323111068", var_283_8)
						arg_280_1:RecordAudio("323111068", var_283_8)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_323111", "323111068", "story_v_out_323111.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_323111", "323111068", "story_v_out_323111.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_9 = math.max(var_283_2, arg_280_1.talkMaxDuration)

			if var_283_1 <= arg_280_1.time_ and arg_280_1.time_ < var_283_1 + var_283_9 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_1) / var_283_9

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_1 + var_283_9 and arg_280_1.time_ < var_283_1 + var_283_9 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play323111069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 323111069
		arg_284_1.duration_ = 7.4

		local var_284_0 = {
			zh = 4.933,
			ja = 7.4
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play323111070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 and not isNil(arg_284_1.actors_["1053ui_story"]) and arg_284_1.var_.characterEffect1053ui_story == nil then
				arg_284_1.var_.characterEffect1053ui_story = arg_284_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_0 = 0.200000002980232

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_0 and not isNil(arg_284_1.actors_["1053ui_story"]) then
				if arg_284_1.var_.characterEffect1053ui_story and not isNil(arg_284_1.actors_["1053ui_story"]) then
					arg_284_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_284_1.time_ >= 0 + var_287_0 and arg_284_1.time_ < 0 + var_287_0 + arg_287_0 and not isNil(arg_284_1.actors_["1053ui_story"]) and arg_284_1.var_.characterEffect1053ui_story then
				arg_284_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_287_2 = arg_284_1.actors_["1059ui_story"]

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 and not isNil(var_287_2) and arg_284_1.var_.characterEffect1059ui_story == nil then
				arg_284_1.var_.characterEffect1059ui_story = var_287_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_3 = 0.200000002980232

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_3 and not isNil(var_287_2) then
				if arg_284_1.var_.characterEffect1059ui_story and not isNil(var_287_2) then
					arg_284_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_284_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_284_1.time_ - 0) / var_287_3)
				end
			end

			if arg_284_1.time_ >= 0 + var_287_3 and arg_284_1.time_ < 0 + var_287_3 + arg_287_0 and not isNil(var_287_2) and arg_284_1.var_.characterEffect1059ui_story then
				arg_284_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_284_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action6_2")
			end

			local var_287_4 = 0
			local var_287_5 = 0.65

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_4 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[1453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_6 = arg_284_1:GetWordFromCfg(323111069)
				local var_287_7 = arg_284_1:FormatText(var_287_6.content)

				arg_284_1.text_.text = var_287_7

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_9 = 26 <= 0 and var_287_5 or var_287_5 * (utf8.len(var_287_7) / 26)

				if (26 <= 0 and var_287_5 or var_287_5 * (utf8.len(var_287_7) / 26)) > 0 and var_287_5 < var_287_9 then
					arg_284_1.talkMaxDuration = var_287_9

					if var_287_9 + var_287_4 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_9 + var_287_4
					end
				end

				arg_284_1.text_.text = var_287_7
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111069", "story_v_out_323111.awb") ~= 0 then
					local var_287_10 = manager.audio:GetVoiceLength("story_v_out_323111", "323111069", "story_v_out_323111.awb") / 1000

					if var_287_10 + var_287_4 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_10 + var_287_4
					end

					if var_287_6.prefab_name ~= "" and arg_284_1.actors_[var_287_6.prefab_name] ~= nil then
						local var_287_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_6.prefab_name].transform, "story_v_out_323111", "323111069", "story_v_out_323111.awb")

						arg_284_1:RecordAudio("323111069", var_287_11)
						arg_284_1:RecordAudio("323111069", var_287_11)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_323111", "323111069", "story_v_out_323111.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_323111", "323111069", "story_v_out_323111.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_12 = math.max(var_287_5, arg_284_1.talkMaxDuration)

			if var_287_4 <= arg_284_1.time_ and arg_284_1.time_ < var_287_4 + var_287_12 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_4) / var_287_12

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_4 + var_287_12 and arg_284_1.time_ < var_287_4 + var_287_12 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play323111070 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 323111070
		arg_288_1.duration_ = 6.3

		local var_288_0 = {
			zh = 3.333,
			ja = 6.3
		}
		local var_288_1 = manager.audio:GetLocalizationFlag()

		if var_288_0[var_288_1] ~= nil then
			arg_288_1.duration_ = var_288_0[var_288_1]
		end

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play323111071(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(arg_288_1.actors_["1059ui_story"]) and arg_288_1.var_.characterEffect1059ui_story == nil then
				arg_288_1.var_.characterEffect1059ui_story = arg_288_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_0 = 0.200000002980232

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_0 and not isNil(arg_288_1.actors_["1059ui_story"]) then
				if arg_288_1.var_.characterEffect1059ui_story and not isNil(arg_288_1.actors_["1059ui_story"]) then
					arg_288_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_288_1.time_ >= 0 + var_291_0 and arg_288_1.time_ < 0 + var_291_0 + arg_291_0 and not isNil(arg_288_1.actors_["1059ui_story"]) and arg_288_1.var_.characterEffect1059ui_story then
				arg_288_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_291_2 = arg_288_1.actors_["1053ui_story"]

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(var_291_2) and arg_288_1.var_.characterEffect1053ui_story == nil then
				arg_288_1.var_.characterEffect1053ui_story = var_291_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_3 = 0.200000002980232

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_3 and not isNil(var_291_2) then
				if arg_288_1.var_.characterEffect1053ui_story and not isNil(var_291_2) then
					arg_288_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_288_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_288_1.time_ - 0) / var_291_3)
				end
			end

			if arg_288_1.time_ >= 0 + var_291_3 and arg_288_1.time_ < 0 + var_291_3 + arg_291_0 and not isNil(var_291_2) and arg_288_1.var_.characterEffect1053ui_story then
				arg_288_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_288_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_291_4 = 0
			local var_291_5 = 0.25

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_4 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, true)
				arg_288_1.iconController_:SetSelectedState("hero")

				arg_288_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_288_1.callingController_:SetSelectedState("normal")

				arg_288_1.keyicon_.color = Color.New(1, 1, 1)
				arg_288_1.icon_.color = Color.New(1, 1, 1)

				local var_291_6 = arg_288_1:GetWordFromCfg(323111070)
				local var_291_7 = arg_288_1:FormatText(var_291_6.content)

				arg_288_1.text_.text = var_291_7

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_9 = 10 <= 0 and var_291_5 or var_291_5 * (utf8.len(var_291_7) / 10)

				if (10 <= 0 and var_291_5 or var_291_5 * (utf8.len(var_291_7) / 10)) > 0 and var_291_5 < var_291_9 then
					arg_288_1.talkMaxDuration = var_291_9

					if var_291_9 + var_291_4 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_9 + var_291_4
					end
				end

				arg_288_1.text_.text = var_291_7
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111070", "story_v_out_323111.awb") ~= 0 then
					local var_291_10 = manager.audio:GetVoiceLength("story_v_out_323111", "323111070", "story_v_out_323111.awb") / 1000

					if var_291_10 + var_291_4 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_10 + var_291_4
					end

					if var_291_6.prefab_name ~= "" and arg_288_1.actors_[var_291_6.prefab_name] ~= nil then
						local var_291_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_6.prefab_name].transform, "story_v_out_323111", "323111070", "story_v_out_323111.awb")

						arg_288_1:RecordAudio("323111070", var_291_11)
						arg_288_1:RecordAudio("323111070", var_291_11)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_323111", "323111070", "story_v_out_323111.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_323111", "323111070", "story_v_out_323111.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_12 = math.max(var_291_5, arg_288_1.talkMaxDuration)

			if var_291_4 <= arg_288_1.time_ and arg_288_1.time_ < var_291_4 + var_291_12 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_4) / var_291_12

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_4 + var_291_12 and arg_288_1.time_ < var_291_4 + var_291_12 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play323111071 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 323111071
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play323111072(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.var_.moveOldPos1053ui_story = arg_292_1.actors_["1053ui_story"].transform.localPosition

				local var_295_0 = GameObjectTools.GetOrAddComponent(arg_292_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_295_0 then
					var_295_0:EnableDynamicBone(false)
				end
			end

			local var_295_1 = 0.001

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_1 then
				arg_292_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_292_1.time_ - 0) / var_295_1)
				arg_292_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_292_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["1053ui_story"].transform.position).z)
				arg_292_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_292_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_292_1.actors_["1053ui_story"].transform.localEulerAngles = arg_292_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_292_1.time_ >= 0 + var_295_1 and arg_292_1.time_ < 0 + var_295_1 + arg_295_0 then
				arg_292_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_292_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_292_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["1053ui_story"].transform.position).z)
				arg_292_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_292_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_292_1.actors_["1053ui_story"].transform.localEulerAngles = arg_292_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_295_2 = GameObjectTools.GetOrAddComponent(arg_292_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_295_2 then
					var_295_2:EnableDynamicBone(true)
				end
			end

			local var_295_3 = arg_292_1.actors_["1059ui_story"].transform

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.var_.moveOldPos1059ui_story = var_295_3.localPosition
			end

			local var_295_4 = 0.001

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_4 then
				var_295_3.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_292_1.time_ - 0) / var_295_4)
				var_295_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_295_3.position).x, (manager.ui.mainCamera.transform.position - var_295_3.position).y, (manager.ui.mainCamera.transform.position - var_295_3.position).z)
				var_295_3.localEulerAngles.z = 0
				var_295_3.localEulerAngles.x = 0
				var_295_3.localEulerAngles = var_295_3.localEulerAngles
			end

			if arg_292_1.time_ >= 0 + var_295_4 and arg_292_1.time_ < 0 + var_295_4 + arg_295_0 then
				var_295_3.localPosition = Vector3.New(0, 100, 0)
				var_295_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_295_3.position).x, (manager.ui.mainCamera.transform.position - var_295_3.position).y, (manager.ui.mainCamera.transform.position - var_295_3.position).z)
				var_295_3.localEulerAngles.z = 0
				var_295_3.localEulerAngles.x = 0
				var_295_3.localEulerAngles = var_295_3.localEulerAngles
			end

			local var_295_5 = arg_292_1.actors_["1059ui_story"]

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(var_295_5) and arg_292_1.var_.characterEffect1059ui_story == nil then
				arg_292_1.var_.characterEffect1059ui_story = var_295_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_6 = 0.200000002980232

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_6 and not isNil(var_295_5) then
				if arg_292_1.var_.characterEffect1059ui_story and not isNil(var_295_5) then
					arg_292_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_292_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_292_1.time_ - 0) / var_295_6)
				end
			end

			if arg_292_1.time_ >= 0 + var_295_6 and arg_292_1.time_ < 0 + var_295_6 + arg_295_0 and not isNil(var_295_5) and arg_292_1.var_.characterEffect1059ui_story then
				arg_292_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_292_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_295_7 = 0
			local var_295_8 = 1.025

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_7 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, false)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_9 = arg_292_1:FormatText(arg_292_1:GetWordFromCfg(323111071).content)

				arg_292_1.text_.text = var_295_9

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_11 = 41 <= 0 and var_295_8 or var_295_8 * (utf8.len(var_295_9) / 41)

				if (41 <= 0 and var_295_8 or var_295_8 * (utf8.len(var_295_9) / 41)) > 0 and var_295_8 < var_295_11 then
					arg_292_1.talkMaxDuration = var_295_11

					if var_295_11 + var_295_7 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_11 + var_295_7
					end
				end

				arg_292_1.text_.text = var_295_9
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_12 = math.max(var_295_8, arg_292_1.talkMaxDuration)

			if var_295_7 <= arg_292_1.time_ and arg_292_1.time_ < var_295_7 + var_295_12 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_7) / var_295_12

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_7 + var_295_12 and arg_292_1.time_ < var_295_7 + var_295_12 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_292_1:InitPlayNodeList()
	end,
	Play323111072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 323111072
		arg_296_1.duration_ = 5.87

		local var_296_0 = {
			zh = 3,
			ja = 5.866
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play323111073(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = 0.3

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, true)
				arg_296_1.iconController_:SetSelectedState("hero")

				arg_296_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_296_1.callingController_:SetSelectedState("normal")

				arg_296_1.keyicon_.color = Color.New(1, 1, 1)
				arg_296_1.icon_.color = Color.New(1, 1, 1)

				local var_299_1 = arg_296_1:GetWordFromCfg(323111072)
				local var_299_2 = arg_296_1:FormatText(var_299_1.content)

				arg_296_1.text_.text = var_299_2

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_4 = 12 <= 0 and var_299_0 or var_299_0 * (utf8.len(var_299_2) / 12)

				if (12 <= 0 and var_299_0 or var_299_0 * (utf8.len(var_299_2) / 12)) > 0 and var_299_0 < var_299_4 then
					arg_296_1.talkMaxDuration = var_299_4

					if var_299_4 + 0 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_4 + 0
					end
				end

				arg_296_1.text_.text = var_299_2
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111072", "story_v_out_323111.awb") ~= 0 then
					local var_299_5 = manager.audio:GetVoiceLength("story_v_out_323111", "323111072", "story_v_out_323111.awb") / 1000

					if var_299_5 + 0 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_5 + 0
					end

					if var_299_1.prefab_name ~= "" and arg_296_1.actors_[var_299_1.prefab_name] ~= nil then
						local var_299_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_1.prefab_name].transform, "story_v_out_323111", "323111072", "story_v_out_323111.awb")

						arg_296_1:RecordAudio("323111072", var_299_6)
						arg_296_1:RecordAudio("323111072", var_299_6)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_323111", "323111072", "story_v_out_323111.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_323111", "323111072", "story_v_out_323111.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_7 = math.max(var_299_0, arg_296_1.talkMaxDuration)

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_7 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - 0) / var_299_7

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= 0 + var_299_7 and arg_296_1.time_ < 0 + var_299_7 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play323111073 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 323111073
		arg_300_1.duration_ = 9.6

		local var_300_0 = {
			zh = 6.766,
			ja = 9.6
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play323111074(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.var_.moveOldPos1053ui_story = arg_300_1.actors_["1053ui_story"].transform.localPosition

				local var_303_0 = GameObjectTools.GetOrAddComponent(arg_300_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_303_0 then
					var_303_0:EnableDynamicBone(false)
				end
			end

			local var_303_1 = 0.001

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_1 then
				arg_300_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_300_1.time_ - 0) / var_303_1)
				arg_300_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_300_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["1053ui_story"].transform.position).z)
				arg_300_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_300_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_300_1.actors_["1053ui_story"].transform.localEulerAngles = arg_300_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_300_1.time_ >= 0 + var_303_1 and arg_300_1.time_ < 0 + var_303_1 + arg_303_0 then
				arg_300_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_300_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_300_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["1053ui_story"].transform.position).z)
				arg_300_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_300_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_300_1.actors_["1053ui_story"].transform.localEulerAngles = arg_300_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_303_2 = GameObjectTools.GetOrAddComponent(arg_300_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_303_2 then
					var_303_2:EnableDynamicBone(true)
				end
			end

			local var_303_3 = arg_300_1.actors_["1053ui_story"]

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(var_303_3) and arg_300_1.var_.characterEffect1053ui_story == nil then
				arg_300_1.var_.characterEffect1053ui_story = var_303_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_4 = 0.200000002980232

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_4 and not isNil(var_303_3) then
				if arg_300_1.var_.characterEffect1053ui_story and not isNil(var_303_3) then
					arg_300_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_300_1.time_ >= 0 + var_303_4 and arg_300_1.time_ < 0 + var_303_4 + arg_303_0 and not isNil(var_303_3) and arg_300_1.var_.characterEffect1053ui_story then
				arg_300_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_303_6 = 0
			local var_303_7 = 0.75

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_6 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[1453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_8 = arg_300_1:GetWordFromCfg(323111073)
				local var_303_9 = arg_300_1:FormatText(var_303_8.content)

				arg_300_1.text_.text = var_303_9

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_11 = 30 <= 0 and var_303_7 or var_303_7 * (utf8.len(var_303_9) / 30)

				if (30 <= 0 and var_303_7 or var_303_7 * (utf8.len(var_303_9) / 30)) > 0 and var_303_7 < var_303_11 then
					arg_300_1.talkMaxDuration = var_303_11

					if var_303_11 + var_303_6 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_11 + var_303_6
					end
				end

				arg_300_1.text_.text = var_303_9
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111073", "story_v_out_323111.awb") ~= 0 then
					local var_303_12 = manager.audio:GetVoiceLength("story_v_out_323111", "323111073", "story_v_out_323111.awb") / 1000

					if var_303_12 + var_303_6 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_12 + var_303_6
					end

					if var_303_8.prefab_name ~= "" and arg_300_1.actors_[var_303_8.prefab_name] ~= nil then
						local var_303_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_8.prefab_name].transform, "story_v_out_323111", "323111073", "story_v_out_323111.awb")

						arg_300_1:RecordAudio("323111073", var_303_13)
						arg_300_1:RecordAudio("323111073", var_303_13)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_323111", "323111073", "story_v_out_323111.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_323111", "323111073", "story_v_out_323111.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_14 = math.max(var_303_7, arg_300_1.talkMaxDuration)

			if var_303_6 <= arg_300_1.time_ and arg_300_1.time_ < var_303_6 + var_303_14 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_6) / var_303_14

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_6 + var_303_14 and arg_300_1.time_ < var_303_6 + var_303_14 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_300_1:InitPlayNodeList()
	end,
	Play323111074 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 323111074
		arg_304_1.duration_ = 5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play323111075(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 and not isNil(arg_304_1.actors_["1053ui_story"]) and arg_304_1.var_.characterEffect1053ui_story == nil then
				arg_304_1.var_.characterEffect1053ui_story = arg_304_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_0 = 0.200000002980232

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_0 and not isNil(arg_304_1.actors_["1053ui_story"]) then
				if arg_304_1.var_.characterEffect1053ui_story and not isNil(arg_304_1.actors_["1053ui_story"]) then
					arg_304_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_304_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_304_1.time_ - 0) / var_307_0)
				end
			end

			if arg_304_1.time_ >= 0 + var_307_0 and arg_304_1.time_ < 0 + var_307_0 + arg_307_0 and not isNil(arg_304_1.actors_["1053ui_story"]) and arg_304_1.var_.characterEffect1053ui_story then
				arg_304_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_304_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_307_1 = 0
			local var_307_2 = 0.275

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_1 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, true)
				arg_304_1.iconController_:SetSelectedState("hero")

				arg_304_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_304_1.callingController_:SetSelectedState("normal")

				arg_304_1.keyicon_.color = Color.New(1, 1, 1)
				arg_304_1.icon_.color = Color.New(1, 1, 1)

				local var_307_3 = arg_304_1:FormatText(arg_304_1:GetWordFromCfg(323111074).content)

				arg_304_1.text_.text = var_307_3

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_5 = 11 <= 0 and var_307_2 or var_307_2 * (utf8.len(var_307_3) / 11)

				if (11 <= 0 and var_307_2 or var_307_2 * (utf8.len(var_307_3) / 11)) > 0 and var_307_2 < var_307_5 then
					arg_304_1.talkMaxDuration = var_307_5

					if var_307_5 + var_307_1 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_5 + var_307_1
					end
				end

				arg_304_1.text_.text = var_307_3
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_6 = math.max(var_307_2, arg_304_1.talkMaxDuration)

			if var_307_1 <= arg_304_1.time_ and arg_304_1.time_ < var_307_1 + var_307_6 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_1) / var_307_6

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_1 + var_307_6 and arg_304_1.time_ < var_307_1 + var_307_6 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play323111075 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 323111075
		arg_308_1.duration_ = 8.73

		local var_308_0 = {
			zh = 3.966,
			ja = 8.733
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
			arg_308_1.auto_ = false
		end

		function arg_308_1.playNext_(arg_310_0)
			arg_308_1.onStoryFinished_()
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(arg_308_1.actors_["1053ui_story"]) and arg_308_1.var_.characterEffect1053ui_story == nil then
				arg_308_1.var_.characterEffect1053ui_story = arg_308_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_0 = 0.200000002980232

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_0 and not isNil(arg_308_1.actors_["1053ui_story"]) then
				if arg_308_1.var_.characterEffect1053ui_story and not isNil(arg_308_1.actors_["1053ui_story"]) then
					arg_308_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_308_1.time_ >= 0 + var_311_0 and arg_308_1.time_ < 0 + var_311_0 + arg_311_0 and not isNil(arg_308_1.actors_["1053ui_story"]) and arg_308_1.var_.characterEffect1053ui_story then
				arg_308_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_311_2 = 0
			local var_311_3 = 0.4

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_2 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[1453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_4 = arg_308_1:GetWordFromCfg(323111075)
				local var_311_5 = arg_308_1:FormatText(var_311_4.content)

				arg_308_1.text_.text = var_311_5

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_7 = 16 <= 0 and var_311_3 or var_311_3 * (utf8.len(var_311_5) / 16)

				if (16 <= 0 and var_311_3 or var_311_3 * (utf8.len(var_311_5) / 16)) > 0 and var_311_3 < var_311_7 then
					arg_308_1.talkMaxDuration = var_311_7

					if var_311_7 + var_311_2 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_7 + var_311_2
					end
				end

				arg_308_1.text_.text = var_311_5
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323111", "323111075", "story_v_out_323111.awb") ~= 0 then
					local var_311_8 = manager.audio:GetVoiceLength("story_v_out_323111", "323111075", "story_v_out_323111.awb") / 1000

					if var_311_8 + var_311_2 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_8 + var_311_2
					end

					if var_311_4.prefab_name ~= "" and arg_308_1.actors_[var_311_4.prefab_name] ~= nil then
						local var_311_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_4.prefab_name].transform, "story_v_out_323111", "323111075", "story_v_out_323111.awb")

						arg_308_1:RecordAudio("323111075", var_311_9)
						arg_308_1:RecordAudio("323111075", var_311_9)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_323111", "323111075", "story_v_out_323111.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_323111", "323111075", "story_v_out_323111.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_10 = math.max(var_311_3, arg_308_1.talkMaxDuration)

			if var_311_2 <= arg_308_1.time_ and arg_308_1.time_ < var_311_2 + var_311_10 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_2) / var_311_10

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_2 + var_311_10 and arg_308_1.time_ < var_311_2 + var_311_10 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2005"
	},
	voices = {
		"story_v_out_323111.awb"
	}
}
